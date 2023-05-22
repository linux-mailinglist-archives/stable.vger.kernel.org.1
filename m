Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C542B70C90C
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjEVTo3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjEVTo1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF3CDC
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A286621A1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94D7C433EF;
        Mon, 22 May 2023 19:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784666;
        bh=AAnMYEwkY3TX+vPDX7HdSENvhJDwCV2scrmHBehi18A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLCc821dGPavnZ/89bpr2xzvxM3rpOGJjZTkI4KhgvEX/jBnwwYcMC2Gg7F8OfLkr
         UZlF2uVc5o7Cz1AXgCRmJ+YR5j00z8vINKSMs3hDRRmm45ky1tgluyUfCDaZZsA4Yo
         vjg4puyFQJvMbbkL54u58WU9OY/1xjPh4oLk8I40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 118/364] md: fix soft lockup in status_resync
Date:   Mon, 22 May 2023 20:07:03 +0100
Message-Id: <20230522190415.738336115@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 6efddf1e32e2a264694766ca485a4f5e04ee82a7 ]

status_resync() will calculate 'curr_resync - recovery_active' to show
user a progress bar like following:

[============>........]  resync = 61.4%

'curr_resync' and 'recovery_active' is updated in md_do_sync(), and
status_resync() can read them concurrently, hence it's possible that
'curr_resync - recovery_active' can overflow to a huge number. In this
case status_resync() will be stuck in the loop to print a large amount
of '=', which will end up soft lockup.

Fix the problem by setting 'resync' to MD_RESYNC_ACTIVE in this case,
this way resync in progress will be reported to user.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230310073855.1337560-3-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 13321dbb5fbcf..d479e1656ef33 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8029,16 +8029,16 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
 	} else if (resync > max_sectors) {
 		resync = max_sectors;
 	} else {
-		resync -= atomic_read(&mddev->recovery_active);
-		if (resync < MD_RESYNC_ACTIVE) {
-			/*
-			 * Resync has started, but the subtraction has
-			 * yielded one of the special values. Force it
-			 * to active to ensure the status reports an
-			 * active resync.
-			 */
+		res = atomic_read(&mddev->recovery_active);
+		/*
+		 * Resync has started, but the subtraction has overflowed or
+		 * yielded one of the special values. Force it to active to
+		 * ensure the status reports an active resync.
+		 */
+		if (resync < res || resync - res < MD_RESYNC_ACTIVE)
 			resync = MD_RESYNC_ACTIVE;
-		}
+		else
+			resync -= res;
 	}
 
 	if (resync == MD_RESYNC_NONE) {
-- 
2.39.2



