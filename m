Return-Path: <stable+bounces-116773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A406DA39E2F
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C366C3A9FD0
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B395E267B94;
	Tue, 18 Feb 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o+SgYkUQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6369B23770D
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887167; cv=none; b=QQnoKLiGDtNSTmwb477j7clC8PFPQvfuAOysbdK5WpcA843EizXd6DcLZmTUBYNtBuP2sQuyWPGqMOSALdgmhFpoVemScARYDcAd2MOd+ijF8jHFQV0lFDeDxmtCvVF1Mu6+YuefBeyu4/2W9pbtSsVUKJCdX5TgN62QTlsdoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887167; c=relaxed/simple;
	bh=F1TnvoClYy/dLOqIDIDjXx2lUjmwYpHwYSA3hgzSqjk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YB79vDcz3rBfXvPIgnWHtlCCgjuNz9VTNn4g/pWxbTaO2b4p0mJz4I4nvWMCAuRhzBSMZeOacfN7GgxZ8gOvy988O0Ktk7b0mLGFvZOgtgVZvexa+csmf0tLynUORZi615hMdUeflI26FEM1zbxPTGqutbxq617QjQjzXLszz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o+SgYkUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E81C4CEE2;
	Tue, 18 Feb 2025 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739887166;
	bh=F1TnvoClYy/dLOqIDIDjXx2lUjmwYpHwYSA3hgzSqjk=;
	h=Subject:To:Cc:From:Date:From;
	b=o+SgYkUQwCVkGyslbwhV7pBy8AR1lVgTkbWrEZdbul/am+5n32/opH2jpWqTsQ8rM
	 XxkKcHQXqMbqSjSThrEN2+swlebliMJNjhX9rrzl3P0DPw1sxDppE88CpvJO6wtHQS
	 oYnEPrjUQXr7KC6eNtJGuf6CE05SeoILOg41dGe4=
Subject: FAILED: patch "[PATCH] drm/tidss: Fix race condition while handling interrupt" failed to apply to 6.1-stable tree
To: devarsht@ti.com,aradhya.bhatia@linux.dev,jcormier@criticallink.com,tomi.valkeinen@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 14:59:15 +0100
Message-ID: <2025021815-procreate-false-2b40@gregkh>
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
git cherry-pick -x a9a73f2661e6f625d306c9b0ef082e4593f45a21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021815-procreate-false-2b40@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


