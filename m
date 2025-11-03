Return-Path: <stable+bounces-192108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C844CC29B57
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 01:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A4064E8763
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 00:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8780018DB2A;
	Mon,  3 Nov 2025 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tV858FxP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A0517A316
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130890; cv=none; b=lu1g9aGYDBuUc3XEXRzM2c3hrtpBtM5S8EF9Dy980VRIM5SIbDausMAmG4FlaqWIkBpX2oZp5l7cj09vktxGNoDSexGkdIAvv4grgWQeSxdE1Pc/LEqflsdXfjg5SaDQngue7o2VeXHrEeYzdl3P5/Dq599a/xuJ9YuZToqY9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130890; c=relaxed/simple;
	bh=w02Syvb0Gguc32fiiXs+pye1bOH2S2MBbFf88GlEQiY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BOLDZDj0GAgOIva7oWLMkan7GF/zxxb2FPw1taCbInf8f/o8PfVJbJaErAmmfGSDt+mDmhduHLWcbBD7rsSJJhdxcBUzY2+sxuzmvtSY4VpQN2l/VZBvfmPa7yYU2Nw9eJOXU7JRGIYBW9QLxk/f4hLJ+V55tcoaHWZwDD71mfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tV858FxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F6EC116B1;
	Mon,  3 Nov 2025 00:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762130888;
	bh=w02Syvb0Gguc32fiiXs+pye1bOH2S2MBbFf88GlEQiY=;
	h=Subject:To:Cc:From:Date:From;
	b=tV858FxPFzf1RzEK0EC6cowkJI0eYMta35Q3qvaQkPv1kZyXI1zWuGc5i+MQ++ann
	 HpTDeRmsKTO4A9UqQmksMEbnx2SFLe6pNgJXUJVBffKz+8btnpaZ4NQRMLgYpidKkm
	 GiQUNDpezCXX94XPKDlNdNsd7mhKJViAIgkQxBTI=
Subject: FAILED: patch "[PATCH] block: make REQ_OP_ZONE_OPEN a write operation" failed to apply to 5.15-stable tree
To: dlemoal@kernel.org,axboe@kernel.dk,hch@lst.de,johannes.thumshirn@wdc.com,kch@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Nov 2025 09:48:06 +0900
Message-ID: <2025110306-catcher-numerous-6cd3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 19de03b312d69a7e9bacb51c806c6e3f4207376c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110306-catcher-numerous-6cd3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 19de03b312d69a7e9bacb51c806c6e3f4207376c Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Mon, 27 Oct 2025 09:27:33 +0900
Subject: [PATCH] block: make REQ_OP_ZONE_OPEN a write operation

A REQ_OP_OPEN_ZONE request changes the condition of a sequential zone of
a zoned block device to the explicitly open condition
(BLK_ZONE_COND_EXP_OPEN). As such, it should be considered a write
operation.

Change this operation code to be an odd number to reflect this. The
following operation numbers are changed to keep the numbering compact.

No problems were reported without this change as this operation has no
data. However, this unifies the zone operation to reflect that they
modify the device state and also allows strengthening checks in the
block layer, e.g. checking if this operation is not issued against a
read-only device.

Fixes: 6c1b1da58f8c ("block: add zone open, close and finish operations")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d8ba743a89b7..44c30183ecc3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -341,15 +341,15 @@ enum req_op {
 	/* write the zero filled sector many times */
 	REQ_OP_WRITE_ZEROES	= (__force blk_opf_t)9,
 	/* Open a zone */
-	REQ_OP_ZONE_OPEN	= (__force blk_opf_t)10,
+	REQ_OP_ZONE_OPEN	= (__force blk_opf_t)11,
 	/* Close a zone */
-	REQ_OP_ZONE_CLOSE	= (__force blk_opf_t)11,
+	REQ_OP_ZONE_CLOSE	= (__force blk_opf_t)13,
 	/* Transition a zone to full */
-	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)13,
+	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)15,
 	/* reset a zone write pointer */
-	REQ_OP_ZONE_RESET	= (__force blk_opf_t)15,
+	REQ_OP_ZONE_RESET	= (__force blk_opf_t)17,
 	/* reset all the zone present on the device */
-	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
+	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)19,
 
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= (__force blk_opf_t)34,


