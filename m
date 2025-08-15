Return-Path: <stable+bounces-169783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CC4B284C9
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 19:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCB56204F5
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE58E30FF31;
	Fri, 15 Aug 2025 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hjE5+2CL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A930FF33
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277906; cv=none; b=D0b+nv+aKBwnRN10MB0ewSOd3k4tVOFHjGwyYLXoFpCYFOxetT5HCWzpkFv0E99kv5RtPYQMSal/8NTwKgIt75gPSLN+TJlwN3xCfMxpmo4/muAEC16CUQb5egt+tMt4xK5R9SZzh2PcqpxRwxsYeDqJdbZtBU7VvNHaJbbDQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277906; c=relaxed/simple;
	bh=P4CEmbVcTYClgXF193hfFrYQZG7G64Lwf4vN6t3iWhw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CzxnAo5No1yVZIxyIwkKS02VQzETWLM2H8D1Cpni2/9vghB4QgmaO81rFCxb/P30dQD8o86kOX6l59iuqRcuUNDdwYy201YkY1njC7e6ySOYvz+6s4m37R+W2NTtfiLhd6hlPLYn/qLXvstx+H2uzcfYne/FNWY9SOul4GqGEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hjE5+2CL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B491AC4CEEB;
	Fri, 15 Aug 2025 17:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755277906;
	bh=P4CEmbVcTYClgXF193hfFrYQZG7G64Lwf4vN6t3iWhw=;
	h=Subject:To:Cc:From:Date:From;
	b=hjE5+2CL7HxsEcQJwWXbhm18VRdduTRc8D+MrWa5eNBrqjxvrPs0Iohs9LzSa6yK5
	 G5gppLrXUjtRwrj8RQmwdPtA74SLaLwVOZLaLLoH9VKCfv3e5orRbqAV3NuEwqDNa4
	 2SiW76iwciPQY2D+66j3d+8gRBDCpU52Vt6io6VA=
Subject: FAILED: patch "[PATCH] block: Make REQ_OP_ZONE_FINISH a write operation" failed to apply to 6.6-stable tree
To: dlemoal@kernel.org,axboe@kernel.dk,bvanassche@acm.org,hch@lst.de,johannes.thumshirn@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Aug 2025 19:11:43 +0200
Message-ID: <2025081543-graffiti-nastily-6e2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3f66ccbaaef3a0c5bd844eab04e3207b4061c546
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081543-graffiti-nastily-6e2b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


