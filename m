Return-Path: <stable+bounces-39517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F338A5263
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741091C2298F
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0330973189;
	Mon, 15 Apr 2024 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sHYI5AY6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A017317C
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189299; cv=none; b=c6FIozdWfLuxjq1X2XAE5vAX4jrh1AqwLrNU+q7pckFbLb/uYiqa5lPH0QMj0q6PHQZ8jz7Oa8LiyknO33Jtl2Vl8bYfKIZ9NlYO8H3HxJOcDoWNDEkWqjcMZyfOCLA70qBRZYi1yXtcQvQN+Ezlzu2In50lpAjtT4VW+XO3rts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189299; c=relaxed/simple;
	bh=Z+Ze5VqUBRiO74NQ7QWlXrik+JFbDJTvRPu2FMhyadM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HqMUzemaOa5sEp9U5tP0F6QPwK/mw4xYLmGVvKn/tj0Z11e9S4HiarRCc2YjnIA+aW3+VbxvSBhkStetjNzfuD0M/HJROqw3e5bK6AcH57BERH6ohzRsCY+NmeRvg34Jtc9YI/EpS+uyjkL7S6rAofscO2f2FNbm5RYzFcdUx4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sHYI5AY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED289C113CC;
	Mon, 15 Apr 2024 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713189299;
	bh=Z+Ze5VqUBRiO74NQ7QWlXrik+JFbDJTvRPu2FMhyadM=;
	h=Subject:To:Cc:From:Date:From;
	b=sHYI5AY6KNhKtpogZE+yBIh4ZjDkIwyhRsthdlrMSLt9DJ+q+tDnVJRx+/vC3Fo7G
	 Ldy7iEyXB08TtbWc6LYgxIJk9Pre627XIjqvJc7JpOKPwrrQkbDzBdgDznjYt85F3j
	 lC2H93NCYI0fATnOQD+tSqFx1p39dM9WvjVXO9Bk=
Subject: FAILED: patch "[PATCH] drm/i915: Disable port sync when bigjoiner is used" failed to apply to 5.15-stable tree
To: ville.syrjala@linux.intel.com,rodrigo.vivi@intel.com,vandita.kulkarni@intel.com,vidya.srinivas@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Apr 2024 15:54:48 +0200
Message-ID: <2024041548-aftermath-grafted-5575@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0653d501409eeb9f1deb7e4c12e4d0d2c9f1cba1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041548-aftermath-grafted-5575@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


