Return-Path: <stable+bounces-69510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473DF95677E
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6121C2180C
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751F8145324;
	Mon, 19 Aug 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mu+ErShF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CB213B592
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061052; cv=none; b=NyBwEv/8zKnqF1Iy4Sp0CqHVjyjgtkSVA2CX5Hbw2Qrt3ODUv5jj1W6uGARx/4K30BikywCuugblKkMJ1ZvZX6gVVGXCYYJvHt6U7aj1zxxwwcggYDSqMX+mz7Hjm5BMUFQbRinkWeJQ12uK0ogHoZoJBiK1+1HaoS2AbH3AGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061052; c=relaxed/simple;
	bh=NfL2aJ01cVJcZ/Owo4JyVzPG4t4ni6i5+IqunoJAWA4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fe+nak/CnNlxlibPadHiDpcEsWxjnVUxYQcjRhJMA6z1DYX8JHpgTlzUO2Aw3yGAzGMcecMvra8sUM7AwJ/K2UDnKpcQCYDAiVW6VzlJGNMMVZ0p5fc113qT3Pcpl+wz1QXP8wJiLtPpZRes8+Yejo8gAlpXvfINknaCqiOKy3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mu+ErShF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF1FC4AF0C;
	Mon, 19 Aug 2024 09:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061052;
	bh=NfL2aJ01cVJcZ/Owo4JyVzPG4t4ni6i5+IqunoJAWA4=;
	h=Subject:To:Cc:From:Date:From;
	b=mu+ErShF/Jp2AcxFDiRupRTm1Fd84Ohik69nbMMumbgBBq50T7WkXZ/i+8qWaA3JP
	 slR2IyYELMwfd6UpLf3wqhc8tKfYe7qcYOiN1/zwpzkm6yziDYszEJD+4y3+qYMR8f
	 kHQKO9nrfmC4XsmuG4GjWH22+MHz2WqVCkwWAB9U=
Subject: FAILED: patch "[PATCH] net: mana: Fix doorbell out of order violation and avoid" failed to apply to 6.1-stable tree
To: longli@microsoft.com,haiyangz@microsoft.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:50:49 +0200
Message-ID: <2024081949-strategy-gatherer-758e@gregkh>
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
git cherry-pick -x 58a63729c957621f1990c3494c702711188ca347
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081949-strategy-gatherer-758e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

58a63729c957 ("net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 58a63729c957621f1990c3494c702711188ca347 Mon Sep 17 00:00:00 2001
From: Long Li <longli@microsoft.com>
Date: Fri, 9 Aug 2024 08:58:58 -0700
Subject: [PATCH] net: mana: Fix doorbell out of order violation and avoid
 unnecessary doorbell rings

After napi_complete_done() is called when NAPI is polling in the current
process context, another NAPI may be scheduled and start running in
softirq on another CPU and may ring the doorbell before the current CPU
does. When combined with unnecessary rings when there is no need to arm
the CQ, it triggers error paths in the hardware.

This patch fixes this by calling napi_complete_done() after doorbell
rings. It limits the number of unnecessary rings when there is
no need to arm. MANA hardware specifies that there must be one doorbell
ring every 8 CQ wraparounds. This driver guarantees one doorbell ring as
soon as the number of consumed CQEs exceeds 4 CQ wraparounds. In practical
workloads, the 4 CQ wraparounds proves to be big enough that it rarely
exceeds this limit before all the napi weight is consumed.

To implement this, add a per-CQ counter cq->work_done_since_doorbell,
and make sure the CQ is armed as soon as passing 4 wraparounds of the CQ.

Cc: stable@vger.kernel.org
Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
Link: https://patch.msgid.link/1723219138-29887-1-git-send-email-longli@linuxonhyperv.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index ae717d06e66f..39f56973746d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1792,7 +1792,6 @@ static void mana_poll_rx_cq(struct mana_cq *cq)
 static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
 {
 	struct mana_cq *cq = context;
-	u8 arm_bit;
 	int w;
 
 	WARN_ON_ONCE(cq->gdma_cq != gdma_queue);
@@ -1803,16 +1802,23 @@ static int mana_cq_handler(void *context, struct gdma_queue *gdma_queue)
 		mana_poll_tx_cq(cq);
 
 	w = cq->work_done;
+	cq->work_done_since_doorbell += w;
 
-	if (w < cq->budget &&
-	    napi_complete_done(&cq->napi, w)) {
-		arm_bit = SET_ARM_BIT;
-	} else {
-		arm_bit = 0;
+	if (w < cq->budget) {
+		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
+		cq->work_done_since_doorbell = 0;
+		napi_complete_done(&cq->napi, w);
+	} else if (cq->work_done_since_doorbell >
+		   cq->gdma_cq->queue_size / COMP_ENTRY_SIZE * 4) {
+		/* MANA hardware requires at least one doorbell ring every 8
+		 * wraparounds of CQ even if there is no need to arm the CQ.
+		 * This driver rings the doorbell as soon as we have exceeded
+		 * 4 wraparounds.
+		 */
+		mana_gd_ring_cq(gdma_queue, 0);
+		cq->work_done_since_doorbell = 0;
 	}
 
-	mana_gd_ring_cq(gdma_queue, arm_bit);
-
 	return w;
 }
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 6439fd8b437b..7caa334f4888 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -275,6 +275,7 @@ struct mana_cq {
 	/* NAPI data */
 	struct napi_struct napi;
 	int work_done;
+	int work_done_since_doorbell;
 	int budget;
 };
 


