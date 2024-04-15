Return-Path: <stable+bounces-39516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA498A5261
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6971C2275B
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630157317C;
	Mon, 15 Apr 2024 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D5vGgudp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C371730
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189291; cv=none; b=sjXOzpuRsqPYwhLhzIMuZm7dt1nHx5hZPaXbKBCK9lGpqd+1DCXu8yyapD9UQPpGTgCbAu7KgB3+olIB98lPRkGoAxr4FbRkqcHgFLLLD4I18RL/84GNcf/+L777D/YLwbNOB0t4kySZYCb8vy80lZEfIAFmdR+vSu6PtMVPeRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189291; c=relaxed/simple;
	bh=pEIA5rKs+EJjLTQqyUDH5w8cGgFDQON+vVxxjQF+9Dc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bppF9Y5KjWCuhHePDHJdLWPY3ZDx2FZYg8JcwVHHNtI41joOXIvZXsJd+szC5rE6RpB3MEHhzcecoPHtG49ia2kq+ev/ZNySZ+lC4oDE4lQs0qW10WcnhLhaPHmNMUz1snG8z+Mgn6GH3DCKmW6gHFNnA+yGKichViH2dJ1pHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D5vGgudp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCC9C113CC;
	Mon, 15 Apr 2024 13:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713189290;
	bh=pEIA5rKs+EJjLTQqyUDH5w8cGgFDQON+vVxxjQF+9Dc=;
	h=Subject:To:Cc:From:Date:From;
	b=D5vGgudphjD1SnKpulF114E2HetMD2l9/azcO+P8DyWEzSFXsb6ODrp5WK92pcTYc
	 r3Sxrx2JNmtI8yAhddA8ZEXGYLh46Hopeu9enifFqI6rZFqfr4xvcXRXfQph7/nRdj
	 qtF+Yqp3oJpGb+sEvegu/gp6z9ndGUQdajhnyy58=
Subject: FAILED: patch "[PATCH] drm/i915: Disable port sync when bigjoiner is used" failed to apply to 5.10-stable tree
To: ville.syrjala@linux.intel.com,rodrigo.vivi@intel.com,vandita.kulkarni@intel.com,vidya.srinivas@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Apr 2024 15:54:47 +0200
Message-ID: <2024041547-freely-probable-b5c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0653d501409eeb9f1deb7e4c12e4d0d2c9f1cba1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041547-freely-probable-b5c9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0653d501409eeb9f1deb7e4c12e4d0d2c9f1cba1 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Fri, 5 Apr 2024 00:34:27 +0300
Subject: [PATCH] drm/i915: Disable port sync when bigjoiner is used
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current modeset sequence can't handle port sync and bigjoiner
at the same time. Refuse port sync when bigjoiner is needed,
at least until we fix the modeset sequence.

v2: Add a FIXME (Vandite)

Cc: stable@vger.kernel.org
Tested-by: Vidya Srinivas <vidya.srinivas@intel.com>
Reviewed-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240404213441.17637-4-ville.syrjala@linux.intel.com
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
(cherry picked from commit b37e1347b991459c38c56ec2476087854a4f720b)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index c587a8efeafc..c17462b4c2ac 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4256,7 +4256,12 @@ static bool m_n_equal(const struct intel_link_m_n *m_n_1,
 static bool crtcs_port_sync_compatible(const struct intel_crtc_state *crtc_state1,
 				       const struct intel_crtc_state *crtc_state2)
 {
+	/*
+	 * FIXME the modeset sequence is currently wrong and
+	 * can't deal with bigjoiner + port sync at the same time.
+	 */
 	return crtc_state1->hw.active && crtc_state2->hw.active &&
+		!crtc_state1->bigjoiner_pipes && !crtc_state2->bigjoiner_pipes &&
 		crtc_state1->output_types == crtc_state2->output_types &&
 		crtc_state1->output_format == crtc_state2->output_format &&
 		crtc_state1->lane_count == crtc_state2->lane_count &&


