Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE3D754E3D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 12:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjGPKPx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 06:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPKPw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 06:15:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F02E46
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 03:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10DE860C7A
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 10:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2ADC433C8;
        Sun, 16 Jul 2023 10:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689502550;
        bh=PKXy8A+tF2pmbaoz2P9s08NeohfsEFRelaAXOT4+M0U=;
        h=Subject:To:Cc:From:Date:From;
        b=eL9Sh8gO5Ks9SV5g2ZCeeUL38EFGY6abKMwXKnY7i/3VN2CXeHsF19byayzHTIOSK
         qBMDehFafZs9BZyERA6Bc0i15zdRxApvZR3B0NHBgFW9aLwGS0whfy+WT8eM9jGqoE
         WhR6RxyR/fZ1pIAr/Zo96o1Yp5Btqxh5TjzbDWTc=
Subject: FAILED: patch "[PATCH] btrfs: fix fsverify read error handling in end_page_read" failed to apply to 6.4-stable tree
To:     hch@lst.de, dsterba@suse.com, josef@toxicpanda.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 12:15:42 +0200
Message-ID: <2023071642-refinish-raking-4c3a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2c14f0ffdd30bd3d321ad5fe76fcf701746e1df6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071642-refinish-raking-4c3a@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c14f0ffdd30bd3d321ad5fe76fcf701746e1df6 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 31 May 2023 08:04:52 +0200
Subject: [PATCH] btrfs: fix fsverify read error handling in end_page_read

Also clear the uptodate bit to make sure the page isn't seen as uptodate
in the page cache if fsverity verification fails.

Fixes: 146054090b08 ("btrfs: initial fsverity support")
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8e42ce48b52e..a943a6622489 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -497,12 +497,8 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 	ASSERT(page_offset(page) <= start &&
 	       start + len <= page_offset(page) + PAGE_SIZE);
 
-	if (uptodate) {
-		if (!btrfs_verify_page(page, start)) {
-			btrfs_page_set_error(fs_info, page, start, len);
-		} else {
-			btrfs_page_set_uptodate(fs_info, page, start, len);
-		}
+	if (uptodate && btrfs_verify_page(page, start)) {
+		btrfs_page_set_uptodate(fs_info, page, start, len);
 	} else {
 		btrfs_page_clear_uptodate(fs_info, page, start, len);
 		btrfs_page_set_error(fs_info, page, start, len);

