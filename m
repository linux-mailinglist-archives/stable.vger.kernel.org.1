Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D634476AE99
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjHAJkL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjHAJjw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:39:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415FA3C26
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EC7E614FE
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287AAC433CA;
        Tue,  1 Aug 2023 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882652;
        bh=y/bIETCGL3gNQXWpf1U/fD4YwtGOlxsVggONvGCkbZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QB6sZM6ENDjPchyu2l6iN/GFuWQfSb2An5Fm42EzrdRtxtusjp/pjZMsirCukF/yg
         XSd5YplcemQgVLs89dh420N6xuLhdogAuYu8X3awnDIOwoVeerKCf5pmA9mat4y1+e
         RMPzq+73eLPKyriK0rsEMNs/aHi7aUFVwL0uLBF4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 183/228] btrfs: account block group tree when calculating global reserve size
Date:   Tue,  1 Aug 2023 11:20:41 +0200
Message-ID: <20230801091929.470263077@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit 8dbfc14fc736eb701089aff09645c3d4ad3decb1 upstream.

When using the block group tree feature, this tree is a critical tree just
like the extent, csum and free space trees, and just like them it uses the
delayed refs block reserve.

So take into account the block group tree, and its current size, when
calculating the size for the global reserve.

CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/block-rsv.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -377,6 +377,11 @@ void btrfs_update_global_block_rsv(struc
 	}
 	read_unlock(&fs_info->global_root_lock);
 
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
+		num_bytes += btrfs_root_used(&fs_info->block_group_root->root_item);
+		min_items++;
+	}
+
 	/*
 	 * But we also want to reserve enough space so we can do the fallback
 	 * global reserve for an unlink, which is an additional 5 items (see the


