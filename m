Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8B9755726
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjGPU5o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjGPU5n (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:57:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C626129
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1848860E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289A2C433C7;
        Sun, 16 Jul 2023 20:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689541058;
        bh=2X7LhEIqDv0wlrZZAPuRafMM+iqwIHX2DBzTjF8krpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGEgHD7zsLEg8yhTrtg5Ihp1IqW3mgKAbebKlJpemtv7kQO6QcLiw62xR7nvQDDjj
         l2ammiNamBEvqqs3CyCtXc53QwL1O2A9mfBS7rb9croXT6aXsrrWUUxum4CRilH/l+
         SQjsvsJ0f/yY0FYkCWNkMWBmpP8q09pKc6g5W9jc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 557/591] btrfs: bail out reclaim process if filesystem is read-only
Date:   Sun, 16 Jul 2023 21:51:36 +0200
Message-ID: <20230716194938.266036433@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Naohiro Aota <naota@elisp.net>

commit 93463ff7b54626f8276c0bd3d3f968fbf8d5d380 upstream.

When a filesystem is read-only, we cannot reclaim a block group as it
cannot rewrite the data. Just bail out in that case.

Note that it can drop block groups in this case. As we did
sb_start_write(), read-only filesystem means we got a fatal error and
forced read-only. There is no chance to reclaim them again.

Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/block-group.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1603,8 +1603,15 @@ void btrfs_reclaim_bgs_work(struct work_
 		}
 		spin_unlock(&bg->lock);
 
-		/* Get out fast, in case we're unmounting the filesystem */
-		if (btrfs_fs_closing(fs_info)) {
+		/*
+		 * Get out fast, in case we're read-only or unmounting the
+		 * filesystem. It is OK to drop block groups from the list even
+		 * for the read-only case. As we did sb_start_write(),
+		 * "mount -o remount,ro" won't happen and read-only filesystem
+		 * means it is forced read-only due to a fatal error. So, it
+		 * never gets back to read-write to let us reclaim again.
+		 */
+		if (btrfs_need_cleaner_sleep(fs_info)) {
 			up_write(&space_info->groups_sem);
 			goto next;
 		}


