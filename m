Return-Path: <stable+bounces-158845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E98AECCA0
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 14:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4083A1890FF1
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16E91DE3A5;
	Sun, 29 Jun 2025 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R69BqBsF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ABBEEA9
	for <stable@vger.kernel.org>; Sun, 29 Jun 2025 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751201155; cv=none; b=Pp6d0ereGgoNkZJ06NupbKRvcR/VUEZLvNTUxJQlro3852kh5TK466o1QMToShQ8aOABrFUD3rAKjWTHn0iyyt9AY6G+5QwCqstlFGa5k9dPAiWMn7sUXibwoz+SCYe2xmxbl7UBLqtX2gk+wX8GvnYPji+TX5UmX0umS+A7/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751201155; c=relaxed/simple;
	bh=T9wwM5HGmEXutR1F65IAR3J+tzjTHgH2DBXnPqVo8hE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lCHJ1X4yLY6eFAm3yovJryEYr48iHeDs3a7N72nsrrzzvom//xVo+NbRoSshhiXN/gTWQ8BcJTfNzPkikauiOSbacRC9mIK2cZ12nz6f+Hiuka8oP2TThZyNZAOMQBpHNz+qpWc29CIN4Q2o5OAVr+nQIWy1Xy0WE6PsNzQo5NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R69BqBsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49ADC4CEEB;
	Sun, 29 Jun 2025 12:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751201155;
	bh=T9wwM5HGmEXutR1F65IAR3J+tzjTHgH2DBXnPqVo8hE=;
	h=Subject:To:Cc:From:Date:From;
	b=R69BqBsFBHXx3KNBuJdNcYB2w2Xa5qnH97z2O1bDTsDxfeQCCj5exoH5W1FtpmDVG
	 P37gRh4G71xCfbI6yk8gFucZk24/PAhEwEyOgq1P1iEaH6qr1A6or7r9egpmA4dQl+
	 hmBQJkMKOM+f6SN8WrMDnlUmtKHdd3cOB2AFPt0c=
Subject: FAILED: patch "[PATCH] drm/xe: move DPT l2 flush to a more sensible place" failed to apply to 6.12-stable tree
To: matthew.auld@intel.com,lucas.demarchi@intel.com,maarten.lankhorst@linux.intel.com,thomas.hellstrom@linux.intel.com,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Jun 2025 14:44:31 +0200
Message-ID: <2025062931-astride-stoneware-df77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f16873f42a06b620669d48a4b5c3f888cb3653a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062931-astride-stoneware-df77@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f16873f42a06b620669d48a4b5c3f888cb3653a1 Mon Sep 17 00:00:00 2001
From: Matthew Auld <matthew.auld@intel.com>
Date: Fri, 6 Jun 2025 11:45:48 +0100
Subject: [PATCH] drm/xe: move DPT l2 flush to a more sensible place
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Only need the flush for DPT host updates here. Normal GGTT updates don't
need special flush.

Fixes: 01570b446939 ("drm/xe/bmg: implement Wa_16023588340")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://lore.kernel.org/r/20250606104546.1996818-4-matthew.auld@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 35db1da40c8cfd7511dc42f342a133601eb45449)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index d918ae1c8061..55259969480b 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -164,6 +164,9 @@ static int __xe_pin_fb_vma_dpt(const struct intel_framebuffer *fb,
 
 	vma->dpt = dpt;
 	vma->node = dpt->ggtt_node[tile0->id];
+
+	/* Ensure DPT writes are flushed */
+	xe_device_l2_flush(xe);
 	return 0;
 }
 
@@ -333,8 +336,6 @@ static struct i915_vma *__xe_pin_fb_vma(const struct intel_framebuffer *fb,
 	if (ret)
 		goto err_unpin;
 
-	/* Ensure DPT writes are flushed */
-	xe_device_l2_flush(xe);
 	return vma;
 
 err_unpin:


