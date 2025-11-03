Return-Path: <stable+bounces-192109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE552C29B6F
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 01:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3ACB1889C8C
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 00:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB71E2C187;
	Mon,  3 Nov 2025 00:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wR14pc6I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9945017D2
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 00:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130897; cv=none; b=Cvh4CBgwXOQMYaK/UDD2e7AO22B0sIVubIUD2CraQlBQ6VjKNyhDpLPxnC393OP2vHRRj6n/NIk6yv0of2DKjqORMgnd5J+FrwvGBTnR0pEHHqRz3/HHJEcNhzboPyrJlVHx7tpfgiIhqVfp9838XUeNUCY6gtNrtD6IacZrpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130897; c=relaxed/simple;
	bh=nuJclFfaIg6LPOF1Dc+2x/9aG2yz+iPZdClAzLIASvo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xpm9HE8sLkyrFfcwUi2kCUbgI2ABAn1X16cVFcQjla2bVHJ1/gDzvuOxosg2NaroKl6S/BS41pMM+BeKEqZi9xESD/OE6Fg4QTIz3Dkoh/Kq7M9DT3QAaCSMfB6I8Qu960v1ZKIb7OaNx5qhd/ioUOOjalyrL7BR9/bF2i9XZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wR14pc6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B22C4CEF7;
	Mon,  3 Nov 2025 00:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762130897;
	bh=nuJclFfaIg6LPOF1Dc+2x/9aG2yz+iPZdClAzLIASvo=;
	h=Subject:To:Cc:From:Date:From;
	b=wR14pc6ITAIbL/J3oGYOuf3RisATqY9KnJaWf+oomTUErPlYxhRzsfpSgehrXzWr+
	 HI+Mlvpj3MBowlTUoYHt2ul7lnRRKs0kzYDiqJOFuEG538rL3Pm7dF/7EiLU5DQYS2
	 TpyYPRUXZbZ1WV35goBjm1QQCyMkYOO7hi1tsI+w=
Subject: FAILED: patch "[PATCH] block: make REQ_OP_ZONE_OPEN a write operation" failed to apply to 5.10-stable tree
To: dlemoal@kernel.org,axboe@kernel.dk,hch@lst.de,johannes.thumshirn@wdc.com,kch@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Nov 2025 09:48:06 +0900
Message-ID: <2025110306-unclaimed-spinach-e0cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 19de03b312d69a7e9bacb51c806c6e3f4207376c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110306-unclaimed-spinach-e0cc@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


