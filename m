Return-Path: <stable+bounces-169786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F12B284CB
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFDD620AC4
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8A42E5D31;
	Fri, 15 Aug 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LXidEcMw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E137B257844
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277922; cv=none; b=WB1AhZyjExG/+eZ6A4dzBAWLRrqZSzxKTbAQDrRaOo5uHV5Ju6YQXQowqrrC4Pf/EQ5os99kScL2a0X4A/dJfFyrKqp1thdQWiThgifd70lDJEkaKVXF48cBUjv+VqUqlVsiLKEftLI2d63DGA8GmO5G9aGghY67yjPAjYnkrnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277922; c=relaxed/simple;
	bh=CtnnIsPNKfWZl0NAqOMpiPqKPipBn8An+5cBx7sC1SY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IOpVhRGIwBaI+mGrlHaVnBAEaufqCFvDUw9T2wwtnlhk0ELVKnoiRTHc36aDKTUZmZd3awxjAYm/wkI8Qr9F4yllM8lrzFmnkLxhZmcmjhxivhUizlpSuHKgHhMTseDxUvYwsy9vC+u3UEviF9LqErmm/0hCNpiH5y0C8obWOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LXidEcMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480E5C4CEEB;
	Fri, 15 Aug 2025 17:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755277921;
	bh=CtnnIsPNKfWZl0NAqOMpiPqKPipBn8An+5cBx7sC1SY=;
	h=Subject:To:Cc:From:Date:From;
	b=LXidEcMwZX/g0SGdvIySAe4ZF+F6cG9BiRFOab0idFAlnHxJKZ+caZo3C0iAQI0U/
	 HgggsX1qKGmu1/b8hyrETsqVyFyIGtcMzwt/uNkaYGnVNr/cw9QPQ8b10A9xjJ0l8o
	 cEUSOvt/6MHBq3N4fLdndgijbVgXwW31oYSjHvZM=
Subject: FAILED: patch "[PATCH] block: Make REQ_OP_ZONE_FINISH a write operation" failed to apply to 5.15-stable tree
To: dlemoal@kernel.org,axboe@kernel.dk,bvanassche@acm.org,hch@lst.de,johannes.thumshirn@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Aug 2025 19:11:44 +0200
Message-ID: <2025081544-slackness-vantage-3e99@gregkh>
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
git cherry-pick -x 3f66ccbaaef3a0c5bd844eab04e3207b4061c546
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081544-slackness-vantage-3e99@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


