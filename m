Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBF976113C
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjGYKtB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjGYKs7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:48:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E171B19A1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:48:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6110F6165D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3DDC433C7;
        Tue, 25 Jul 2023 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282137;
        bh=jplUyhcBfxZAne3W/LLK0tsKT3vr6FP3Fk8hUdI77c0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D9vBE+z8AU+ULeDe3mzMAY90TrI7SgU+Md/jEtvTmo8wTKQUOGZeZSShFd0IFqCWZ
         3IrqglLFXTcK+nhrGk/B/JlzsoZGTSp7geKDNJJLgsGZg6SzWO7icsRrekHlc6g4Qw
         Wl2mymhlal4nM0tWxxVnIXhTYqKEVrr3imm39qEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Boris Burkov <boris@bur.io>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 021/227] btrfs: fix double iput() on inode after an error during orphan cleanup
Date:   Tue, 25 Jul 2023 12:43:08 +0200
Message-ID: <20230725104515.677318290@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit b777d279ff31979add57e8a3f810bceb7ef0cfb7 upstream.

At btrfs_orphan_cleanup(), if we were able to find the inode, we do an
iput() on the inode, then if btrfs_drop_verity_items() succeeds and then
either btrfs_start_transaction() or btrfs_del_orphan_item() fail, we do
another iput() in the respective error paths, resulting in an extra iput()
on the inode.

Fix this by setting inode to NULL after the first iput(), as iput()
ignores a NULL inode pointer argument.

Fixes: a13bb2c03848 ("btrfs: add missing iputs on orphan cleanup failure")
CC: stable@vger.kernel.org # 6.4
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3618,6 +3618,7 @@ int btrfs_orphan_cleanup(struct btrfs_ro
 			if (inode) {
 				ret = btrfs_drop_verity_items(BTRFS_I(inode));
 				iput(inode);
+				inode = NULL;
 				if (ret)
 					goto out;
 			}


