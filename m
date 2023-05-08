Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABABB6FADF2
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbjEHLjo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbjEHLj3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:39:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1275B96
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:39:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A25F563371
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD409C433EF;
        Mon,  8 May 2023 11:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545947;
        bh=weTz1ND2/3hvmQ5T4x5HdoiULr0WHvuceGgqw5k4rbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrgmXm/BDmo5tRVhkQUw0RsSDTIWreJLPhP+NyI99H0ZPTr8X1OkVCq84gWH5tYpb
         UMRD09gyyUNx9y/dgPj+UZ2Yxg5acEGpsMBr7Xk1TH6wDWuwFgxRccavDBlrg+H2RY
         NZgPtY58Qf16kkKU5RC63h+262rGMkptEUHr3bWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 207/371] md/raid10: fix leak of r10bio->remaining for recovery
Date:   Mon,  8 May 2023 11:46:48 +0200
Message-Id: <20230508094820.295495885@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 26208a7cffd0c7cbf14237ccd20c7270b3ffeb7e ]

raid10_sync_request() will add 'r10bio->remaining' for both rdev and
replacement rdev. However, if the read io fails, recovery_request_write()
returns without issuing the write io, in this case, end_sync_request()
is only called once and 'remaining' is leaked, cause an io hang.

Fix the problem by decreasing 'remaining' according to if 'bio' and
'repl_bio' is valid.

Fixes: 24afd80d99f8 ("md/raid10: handle recovery of replacement devices.")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230310073855.1337560-5-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid10.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 4bf09ecedec14..2b4a4dc213d8c 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2581,11 +2581,22 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 {
 	struct r10conf *conf = mddev->private;
 	int d;
-	struct bio *wbio, *wbio2;
+	struct bio *wbio = r10_bio->devs[1].bio;
+	struct bio *wbio2 = r10_bio->devs[1].repl_bio;
+
+	/* Need to test wbio2->bi_end_io before we call
+	 * submit_bio_noacct as if the former is NULL,
+	 * the latter is free to free wbio2.
+	 */
+	if (wbio2 && !wbio2->bi_end_io)
+		wbio2 = NULL;
 
 	if (!test_bit(R10BIO_Uptodate, &r10_bio->state)) {
 		fix_recovery_read_error(r10_bio);
-		end_sync_request(r10_bio);
+		if (wbio->bi_end_io)
+			end_sync_request(r10_bio);
+		if (wbio2)
+			end_sync_request(r10_bio);
 		return;
 	}
 
@@ -2594,14 +2605,6 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 	 * and submit the write request
 	 */
 	d = r10_bio->devs[1].devnum;
-	wbio = r10_bio->devs[1].bio;
-	wbio2 = r10_bio->devs[1].repl_bio;
-	/* Need to test wbio2->bi_end_io before we call
-	 * submit_bio_noacct as if the former is NULL,
-	 * the latter is free to free wbio2.
-	 */
-	if (wbio2 && !wbio2->bi_end_io)
-		wbio2 = NULL;
 	if (wbio->bi_end_io) {
 		atomic_inc(&conf->mirrors[d].rdev->nr_pending);
 		md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(wbio));
-- 
2.39.2



