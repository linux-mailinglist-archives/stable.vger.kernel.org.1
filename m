Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9DB7353A1
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjFSKrN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjFSKqv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:46:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E611BC8
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9999860B9B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEB7C433C8;
        Mon, 19 Jun 2023 10:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171587;
        bh=J/tTqgo641HYVk9EzkTqYtxqHXRyv7pA9oc9qdMCfGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVYXtc2CH/Z6kp4up7hGEFVarb5jq843ImlUxJQ1v51ZavfAWa6jzXIgFzbzz7xQd
         H4haeJeudV5oqWloLWK+JsaSGD3z+sFI0IUJ0X1jaIJEvRH7PYicYcOQ0MtmemKfe3
         qA1k2gYU0bduqO6N5fMLdb1D72GPY4+K3SfMq8+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 061/166] btrfs: can_nocow_file_extent should pass down args->strict from callers
Date:   Mon, 19 Jun 2023 12:28:58 +0200
Message-ID: <20230619102157.758509442@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chris Mason <clm@fb.com>

commit deccae40e4b30f98837e44225194d80c8baf2233 upstream.

Commit 619104ba453ad0 ("btrfs: move common NOCOW checks against a file
extent into a helper") changed our call to btrfs_cross_ref_exist() to
always pass false for the 'strict' parameter.  We're passing this down
through the stack so that we can do a full check for cross references
during swapfile activation.

With strict always false, this test fails:

  btrfs subvol create swappy
  chattr +C swappy
  fallocate -l1G swappy/swapfile
  chmod 600 swappy/swapfile
  mkswap swappy/swapfile

  btrfs subvol snap swappy swapsnap
  btrfs subvol del -C swapsnap

  btrfs fi sync /
  sync;sync;sync

  swapon swappy/swapfile

The fix is to just use args->strict, and everyone except swapfile
activation is passing false.

Fixes: 619104ba453ad0 ("btrfs: move common NOCOW checks against a file extent into a helper")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1849,7 +1849,7 @@ static int can_nocow_file_extent(struct
 
 	ret = btrfs_cross_ref_exist(root, btrfs_ino(inode),
 				    key->offset - args->extent_offset,
-				    args->disk_bytenr, false, path);
+				    args->disk_bytenr, args->strict, path);
 	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
 	if (ret != 0)
 		goto out;


