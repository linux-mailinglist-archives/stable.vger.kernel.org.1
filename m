Return-Path: <stable+bounces-169784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F74B284C3
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3670B67644
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7342C30FF37;
	Fri, 15 Aug 2025 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XxmspiiY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282B30FF12
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277915; cv=none; b=gnlmX1K1E8GFYfT3akeLoBR1470VztFERSZDHzUnAEg5WMDf6d9AOh8QzoTnbEazxI1KVGEyD8CCF2mr0iFkmJrl9NUf7KrBfw9Ien91Tt88YfoxRxugjWX+C3+Z0EMDi0zCJmdiVJihG+P/4zYc4qx0JZk9g1TxDEKDrYxUfjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277915; c=relaxed/simple;
	bh=mFwcIfMRBdSrgq0ASu38CwgPJZFpsVI3McIzuxR4nWo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FxHD1VyDCXu/Bfqn0uSoNiLcKF6gdz8nWtLb2qljRp9zwmMqhwdtfxsc2Pw27cCq3gJjhF0P9GxWaZSyVcI4joQBOwCHnKQ5zpie8z4TIAIJbBr4g9xh6r5vR5NbaD54KpQzeUkNxJVjk81j26HqZTYteodOhr+1ZN/ZLmCPHRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XxmspiiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DED6C4CEEB;
	Fri, 15 Aug 2025 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755277915;
	bh=mFwcIfMRBdSrgq0ASu38CwgPJZFpsVI3McIzuxR4nWo=;
	h=Subject:To:Cc:From:Date:From;
	b=XxmspiiYFlkC7yQsCMzpT7OW1zX/1UwysIokqwZWp6tV8pw3CYiBsuGlNwm/onrRJ
	 FW9iRTNQr26zySBPg8zQ7Adk8nR0Xr8S5yrnjrIEswxKX6luboMwwVJ0afE7YNBGAX
	 2Hfnarrg7DVVx2BPTDxEYGNqxke3lI/eVEtvB7E8=
Subject: FAILED: patch "[PATCH] block: Make REQ_OP_ZONE_FINISH a write operation" failed to apply to 6.1-stable tree
To: dlemoal@kernel.org,axboe@kernel.dk,bvanassche@acm.org,hch@lst.de,johannes.thumshirn@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Aug 2025 19:11:43 +0200
Message-ID: <2025081543-myself-easiest-be00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3f66ccbaaef3a0c5bd844eab04e3207b4061c546
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081543-myself-easiest-be00@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3f66ccbaaef3a0c5bd844eab04e3207b4061c546 Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Wed, 25 Jun 2025 18:33:23 +0900
Subject: [PATCH] block: Make REQ_OP_ZONE_FINISH a write operation

REQ_OP_ZONE_FINISH is defined as "12", which makes
op_is_write(REQ_OP_ZONE_FINISH) return false, despite the fact that a
zone finish operation is an operation that modifies a zone (transition
it to full) and so should be considered as a write operation (albeit
one that does not transfer any data to the device).

Fix this by redefining REQ_OP_ZONE_FINISH to be an odd number (13), and
redefine REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL using sequential
odd numbers from that new value.

Fixes: 6c1b1da58f8c ("block: add zone open, close and finish operations")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20250625093327.548866-2-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3d1577f07c1c..930daff207df 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -350,11 +350,11 @@ enum req_op {
 	/* Close a zone */
 	REQ_OP_ZONE_CLOSE	= (__force blk_opf_t)11,
 	/* Transition a zone to full */
-	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)12,
+	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)13,
 	/* reset a zone write pointer */
-	REQ_OP_ZONE_RESET	= (__force blk_opf_t)13,
+	REQ_OP_ZONE_RESET	= (__force blk_opf_t)15,
 	/* reset all the zone present on the device */
-	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)15,
+	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
 
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= (__force blk_opf_t)34,


