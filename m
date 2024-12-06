Return-Path: <stable+bounces-99064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 858469E6F24
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF50218822ED
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D05D2066DC;
	Fri,  6 Dec 2024 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W/KGcCar"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DED46426
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490839; cv=none; b=NDolbyxf5OIl85b0Ux+Iye3r7VGbZaeLDbBmNHw+T/QL5qQPL1B7AjpMvojCf+GyuKXNuenjy2XR/DGHT01IpTtBPAro3iJR3B+oN8HkFNWbPcRAorOMCJqvGXf8W48J5jbuToM+SoAFDINdU6u8oob/HyhFdWv6pp8w96opQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490839; c=relaxed/simple;
	bh=rq+qeeoTZlSKBXDTz8B8CS4qBkJoIrpogUPslJWT2e8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nOI7HwjiJjYMtTfK4LNL5iQX4wHGKXb1BIfqBBQ6Qo176uE7qqJDhxCaX0isYtBK4WbTbrURqAaSdFCqBNRqeuBnJF6YPcn3oo7RtAQxoPddcjLJW0G6KXvnvJO50/FYt6u9U2W+YDr9lnyB/la5CgmxeAbZROZCwHGASf3at30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W/KGcCar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC9AC4CED1;
	Fri,  6 Dec 2024 13:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733490838;
	bh=rq+qeeoTZlSKBXDTz8B8CS4qBkJoIrpogUPslJWT2e8=;
	h=Subject:To:Cc:From:Date:From;
	b=W/KGcCarLfEfKEkbkTVJC2C3s+TVduNITBicmYNriTXi2BwTQB3kAR/FSWiecm7lt
	 b46KzUsUIfu/HRY/Qh9tfMxuPmqeG/Hjx/qqtJVmXhpCghj36gKcNMSfxoidaVmM6D
	 YNzzptkGsVL6ofX0Ld+5FSMgwsgtvazBN6bgErcM=
Subject: FAILED: patch "[PATCH] drm/sti: avoid potential dereference of error pointers in" failed to apply to 5.10-stable tree
To: make24@iscas.ac.cn,alain.volmat@foss.st.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 14:13:55 +0100
Message-ID: <2024120655-capable-garter-12d3@gregkh>
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
git cherry-pick -x c1ab40a1fdfee732c7e6ff2fb8253760293e47e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120655-capable-garter-12d3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c1ab40a1fdfee732c7e6ff2fb8253760293e47e8 Mon Sep 17 00:00:00 2001
From: Ma Ke <make24@iscas.ac.cn>
Date: Fri, 13 Sep 2024 17:09:26 +0800
Subject: [PATCH] drm/sti: avoid potential dereference of error pointers in
 sti_hqvdp_atomic_check

The return value of drm_atomic_get_crtc_state() needs to be
checked. To avoid use of error pointer 'crtc_state' in case
of the failure.

Cc: stable@vger.kernel.org
Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Link: https://patchwork.freedesktop.org/patch/msgid/20240913090926.2023716-1-make24@iscas.ac.cn
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>

diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index acbf70b95aeb..5793cf2cb897 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -1037,6 +1037,9 @@ static int sti_hqvdp_atomic_check(struct drm_plane *drm_plane,
 		return 0;
 
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
+
 	mode = &crtc_state->mode;
 	dst_x = new_plane_state->crtc_x;
 	dst_y = new_plane_state->crtc_y;


