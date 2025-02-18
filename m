Return-Path: <stable+bounces-116774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8290EA39E1C
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32BC97A20A8
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E646523770D;
	Tue, 18 Feb 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w1bLcywU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498C171A7
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887170; cv=none; b=U1GNHXfem70S2L1XfzwtktvMFQJoFS3ODzx0IxgvBWdXaBveRVVYs0UfefOHoqjooLlLam6YS9NAqWntXzVh1LDE7oMocxScsBZldFXlfAQAAq3PBjiYxBTrddKFpWgz+JA2e6cMqxXUgHiJjaiLB1rH3p2FqA/AYphXBGIMtaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887170; c=relaxed/simple;
	bh=CGABQBuZS2T4SP/nCaDzaeMpnT7n3hPKw926ZQcYmbc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sRLq5U18hn25M+UFsi0dwXpHB9qzovso62ljfqdQb1m9eLiEK6gHucXDlKFord8bvthByTTzEsf14dagjL3T3KRprci1Md5paNILJWQe37cAUygdX+telJqnd8I6JQ94I/JQcSSyqhGWHZr1/o3f7q+Q9A+aVr04YQQSIevy2Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w1bLcywU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE605C4CEE2;
	Tue, 18 Feb 2025 13:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739887170;
	bh=CGABQBuZS2T4SP/nCaDzaeMpnT7n3hPKw926ZQcYmbc=;
	h=Subject:To:Cc:From:Date:From;
	b=w1bLcywUjhu7QNiffKNnmUMHL0JJIkTD/oen5efCjm24i3etYR/Nl5fIbrCGiwN7Y
	 u/Eoon5Kbpe7pwxY0uXqtuC3jtSOmKfbLsrfsaFkflE6e0OQm5lg3Necm0nPgamzBu
	 w/SDNzopFzDmGbRCdIQI1KgryQAipo3mmygBY2oo=
Subject: FAILED: patch "[PATCH] drm/tidss: Fix race condition while handling interrupt" failed to apply to 5.10-stable tree
To: devarsht@ti.com,aradhya.bhatia@linux.dev,jcormier@criticallink.com,tomi.valkeinen@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 14:59:16 +0100
Message-ID: <2025021816-stonework-task-247b@gregkh>
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
git cherry-pick -x a9a73f2661e6f625d306c9b0ef082e4593f45a21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021816-stonework-task-247b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a9a73f2661e6f625d306c9b0ef082e4593f45a21 Mon Sep 17 00:00:00 2001
From: Devarsh Thakkar <devarsht@ti.com>
Date: Mon, 21 Oct 2024 17:07:50 +0300
Subject: [PATCH] drm/tidss: Fix race condition while handling interrupt
 registers

The driver has a spinlock for protecting the irq_masks field and irq
enable registers. However, the driver misses protecting the irq status
registers which can lead to races.

Take the spinlock when accessing irqstatus too.

Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
Cc: stable@vger.kernel.org
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
[Tomi: updated the desc]
Reviewed-by: Jonathan Cormier <jcormier@criticallink.com>
Tested-by: Jonathan Cormier <jcormier@criticallink.com>
Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241021-tidss-irq-fix-v1-6-82ddaec94e4a@ideasonboard.com

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 515f82e8a0a5..07f5c26cfa26 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -2767,8 +2767,12 @@ static void dispc_init_errata(struct dispc_device *dispc)
  */
 static void dispc_softreset_k2g(struct dispc_device *dispc)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&dispc->tidss->wait_lock, flags);
 	dispc_set_irqenable(dispc, 0);
 	dispc_read_and_clear_irqstatus(dispc);
+	spin_unlock_irqrestore(&dispc->tidss->wait_lock, flags);
 
 	for (unsigned int vp_idx = 0; vp_idx < dispc->feat->num_vps; ++vp_idx)
 		VP_REG_FLD_MOD(dispc, vp_idx, DISPC_VP_CONTROL, 0, 0, 0);
diff --git a/drivers/gpu/drm/tidss/tidss_irq.c b/drivers/gpu/drm/tidss/tidss_irq.c
index 3cc4024ec7ff..8af4682ba56b 100644
--- a/drivers/gpu/drm/tidss/tidss_irq.c
+++ b/drivers/gpu/drm/tidss/tidss_irq.c
@@ -60,7 +60,9 @@ static irqreturn_t tidss_irq_handler(int irq, void *arg)
 	unsigned int id;
 	dispc_irq_t irqstatus;
 
+	spin_lock(&tidss->wait_lock);
 	irqstatus = dispc_read_and_clear_irqstatus(tidss->dispc);
+	spin_unlock(&tidss->wait_lock);
 
 	for (id = 0; id < tidss->num_crtcs; id++) {
 		struct drm_crtc *crtc = tidss->crtcs[id];


