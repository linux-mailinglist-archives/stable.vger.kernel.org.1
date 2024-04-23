Return-Path: <stable+bounces-40690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79D48AE78A
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 15:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883431F25A6C
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAC21350C8;
	Tue, 23 Apr 2024 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u7bErI+8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC51350CD
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877741; cv=none; b=FkQmUCvVPAatcePbI0Zha2F4zav4X0SDA9akwLsGomr9FhEVJpyy2sOY/JZkWixXjg2XC2g3Sg+VxoaLqpUdfPpCimTSBdnxRL4/WiaH9KirrW18ijaQ2ja/Gh2Dhp5YnW3xsyCrrRYQkhuMh3UP2h5obPd3t0NU2jxCXkBH/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877741; c=relaxed/simple;
	bh=aBBHF/1BqcpgUsOrUcJnBGtOoAAj7IAwVhHm9sNrN+g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gaOnsb0QCyBj7PpHMX2FT2V9JqumYf2Wlg4tf2zyFidzZQ0TplMES4xls5hoJi1CKKcwa/bH5ZEVNwj3mPMMxx9PTlZUH/ILce8Dmpdfdm9SSDC2fB3QfIYywEFADjLqrqF6+FDYJJUiAoBo02d9rJ/6OXopGQMlGHgMa/B7pPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u7bErI+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC86CC116B1;
	Tue, 23 Apr 2024 13:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877740;
	bh=aBBHF/1BqcpgUsOrUcJnBGtOoAAj7IAwVhHm9sNrN+g=;
	h=Subject:To:Cc:From:Date:From;
	b=u7bErI+8Ua1gdfwRuSGsuQLc7iDDvvP9NnjHyNyIhgIwiL07UfpTchfs/yheeqliU
	 REBWy+1dDUIgpEi9RBjSZdzNNtnJs3Hr42GUh5LwzNLPTvBuS4rg6OL1ZEEedi7qdE
	 60ChWSnZpvymDy2CJHKhn5q0b0GDGZtfW08x+sVc=
Subject: FAILED: patch "[PATCH] drm/vmwgfx: Fix crtc's atomic check conditional" failed to apply to 5.10-stable tree
To: zack.rusin@broadcom.com,bcm-kernel-feedback-list@broadcom.com,ian.forbes@broadcom.com,martin.krastev@broadcom.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 06:08:50 -0700
Message-ID: <2024042350-wikipedia-jogging-8ed0@gregkh>
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
git cherry-pick -x a60ccade88f926e871a57176e86a34bbf0db0098
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042350-wikipedia-jogging-8ed0@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

a60ccade88f9 ("drm/vmwgfx: Fix crtc's atomic check conditional")
29b77ad7b9ca ("drm/atomic: Pass the full state to CRTC atomic_check")
c489573b5b6c ("Merge drm/drm-next into drm-misc-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a60ccade88f926e871a57176e86a34bbf0db0098 Mon Sep 17 00:00:00 2001
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 11 Apr 2024 22:55:10 -0400
Subject: [PATCH] drm/vmwgfx: Fix crtc's atomic check conditional

The conditional was supposed to prevent enabling of a crtc state
without a set primary plane. Accidently it also prevented disabling
crtc state with a set primary plane. Neither is correct.

Fix the conditional and just driver-warn when a crtc state has been
enabled without a primary plane which will help debug broken userspace.

Fixes IGT's kms_atomic_interruptible and kms_atomic_transition tests.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 06ec41909e31 ("drm/vmwgfx: Add and connect CRTC helper functions")
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.12+
Reviewed-by: Ian Forbes <ian.forbes@broadcom.com>
Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240412025511.78553-5-zack.rusin@broadcom.com

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index cd4925346ed4..84ae4e10a2eb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -933,6 +933,7 @@ int vmw_du_cursor_plane_atomic_check(struct drm_plane *plane,
 int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
 			     struct drm_atomic_state *state)
 {
+	struct vmw_private *vmw = vmw_priv(crtc->dev);
 	struct drm_crtc_state *new_state = drm_atomic_get_new_crtc_state(state,
 									 crtc);
 	struct vmw_display_unit *du = vmw_crtc_to_du(new_state->crtc);
@@ -940,9 +941,13 @@ int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
 	bool has_primary = new_state->plane_mask &
 			   drm_plane_mask(crtc->primary);
 
-	/* We always want to have an active plane with an active CRTC */
-	if (has_primary != new_state->enable)
-		return -EINVAL;
+	/*
+	 * This is fine in general, but broken userspace might expect
+	 * some actual rendering so give a clue as why it's blank.
+	 */
+	if (new_state->enable && !has_primary)
+		drm_dbg_driver(&vmw->drm,
+			       "CRTC without a primary plane will be blank.\n");
 
 
 	if (new_state->connector_mask != connector_mask &&


