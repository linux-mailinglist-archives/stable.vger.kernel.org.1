Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F3876AFDC
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjHAJut (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjHAJub (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:50:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F9E7C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2669614F3
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A977C433C7;
        Tue,  1 Aug 2023 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883405;
        bh=6hSXEj0CDhgWglOtH5cIrOW2HkZJorFM0jvomap85/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O8U47kIft5JeNh9tCgzHvG79XNAjyPVpWiq7wtCt+bgp1Q+2LSKHMMQsbrI7n85kP
         rE1/74bmumvVrYhJIomxdvcO+YNcIbggqYSg67Hr2peAVKODDk9VeSW8aHrmo0uimU
         MCetoz0wc15t35TvJN06/kBW8Uo3w1YDQluzGJq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 186/239] btrfs: account block group tree when calculating global reserve size
Date:   Tue,  1 Aug 2023 11:20:50 +0200
Message-ID: <20230801091932.384568495@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
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
@@ -349,6 +349,11 @@ void btrfs_update_global_block_rsv(struc
 	}
 	read_unlock(&fs_info->global_root_lock);
 
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
+		num_bytes += btrfs_root_used(&fs_info->block_group_root->root_item);
+		min_items++;
+	}
+
 	/*
 	 * But we also want to reserve enough space so we can do the fallback
 	 * global reserve for an unlink, which is an additional


