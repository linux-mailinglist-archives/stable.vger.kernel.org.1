Return-Path: <stable+bounces-168149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE32DB233B0
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28C91B63CF7
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E5D2FE595;
	Tue, 12 Aug 2025 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XvgcfmFV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D802FD1AD;
	Tue, 12 Aug 2025 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023208; cv=none; b=J2C1uKpE5fBLhF9gqEiy5hFAPhEJV4uzhNoZ4c77AvBx37WKnjmKhXrlOzFoKfvqpBe3wKtoKAlldytYphUj4XtMcYYPZF7602OWn0rWPX4WpSwvTqNgTVt8Lq5HVbCtNO6xmmPCw30kRSUeNyPzE1yshEZl2BpCaylwa98HoKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023208; c=relaxed/simple;
	bh=HUbwfTRMOsEabjP7GxE+gfihq0/FGxj6rUUpTJ8z2yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRcdpeNVu4a10j22gVQadgaeS0/JCCWpLwpHRLf5sjvTRQmtumjvzE1zUILkzJC8qnXlSerPIC847jxSA9yO55HFgvQwNp6LiFsNvgyBmGywz4l5Tl8c3VkUYD66F9twMy69waw9xHN+ajf7bqgFrbaUvUsEozwOSxPm0sZyFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XvgcfmFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7A8C4CEF1;
	Tue, 12 Aug 2025 18:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023208;
	bh=HUbwfTRMOsEabjP7GxE+gfihq0/FGxj6rUUpTJ8z2yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XvgcfmFVDWO5gNyfdVyFoMBbVxaGyWlmA4mtPOVhXx0cr3zKg7/o62svvazDrkIKf
	 27iQPY+rncaEjOt5bg/YaXKg13+b15vklKMy8STARuhwi4xsVvRwh6rUSJZ+qXBdQ5
	 YoHMMvigLnumqBevJMkR0LXGj8ai+ju0QOMC686I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 013/627] block: mtip32xx: Fix usage of dma_map_sg()
Date: Tue, 12 Aug 2025 19:25:08 +0200
Message-ID: <20250812173419.827838469@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit 8e1fab9cccc7b806b0cffdceabb09b310b83b553 ]

The dma_map_sg() can fail and, in case of failure, returns 0.  If it
fails, mtip_hw_submit_io() returns an error.

The dma_unmap_sg() requires the nents parameter to be the same as the
one passed to dma_map_sg(). This patch saves the nents in
command->scatter_ents.

Fixes: 88523a61558a ("block: Add driver for Micron RealSSD pcie flash cards")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20250627121123.203731-2-fourier.thomas@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/mtip32xx/mtip32xx.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 66ce6b81c7d9..8fc7761397bd 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2040,11 +2040,12 @@ static int mtip_hw_ioctl(struct driver_data *dd, unsigned int cmd,
  * @dir      Direction (read or write)
  *
  * return value
- *	None
+ *	0	The IO completed successfully.
+ *	-ENOMEM	The DMA mapping failed.
  */
-static void mtip_hw_submit_io(struct driver_data *dd, struct request *rq,
-			      struct mtip_cmd *command,
-			      struct blk_mq_hw_ctx *hctx)
+static int mtip_hw_submit_io(struct driver_data *dd, struct request *rq,
+			     struct mtip_cmd *command,
+			     struct blk_mq_hw_ctx *hctx)
 {
 	struct mtip_cmd_hdr *hdr =
 		dd->port->command_list + sizeof(struct mtip_cmd_hdr) * rq->tag;
@@ -2056,12 +2057,14 @@ static void mtip_hw_submit_io(struct driver_data *dd, struct request *rq,
 	unsigned int nents;
 
 	/* Map the scatter list for DMA access */
-	nents = blk_rq_map_sg(rq, command->sg);
-	nents = dma_map_sg(&dd->pdev->dev, command->sg, nents, dma_dir);
+	command->scatter_ents = blk_rq_map_sg(rq, command->sg);
+	nents = dma_map_sg(&dd->pdev->dev, command->sg,
+			   command->scatter_ents, dma_dir);
+	if (!nents)
+		return -ENOMEM;
 
-	prefetch(&port->flags);
 
-	command->scatter_ents = nents;
+	prefetch(&port->flags);
 
 	/*
 	 * The number of retries for this command before it is
@@ -2112,11 +2115,13 @@ static void mtip_hw_submit_io(struct driver_data *dd, struct request *rq,
 	if (unlikely(port->flags & MTIP_PF_PAUSE_IO)) {
 		set_bit(rq->tag, port->cmds_to_issue);
 		set_bit(MTIP_PF_ISSUE_CMDS_BIT, &port->flags);
-		return;
+		return 0;
 	}
 
 	/* Issue the command to the hardware */
 	mtip_issue_ncq_command(port, rq->tag);
+
+	return 0;
 }
 
 /*
@@ -3315,7 +3320,9 @@ static blk_status_t mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
-	mtip_hw_submit_io(dd, rq, cmd, hctx);
+	if (mtip_hw_submit_io(dd, rq, cmd, hctx))
+		return BLK_STS_IOERR;
+
 	return BLK_STS_OK;
 }
 
-- 
2.39.5




