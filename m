Return-Path: <stable+bounces-16133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E8183F0EB
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056061F212B0
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762D1DDCF;
	Sat, 27 Jan 2024 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eg3mDW44"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C916C18E07
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395095; cv=none; b=uGN905hYZ2CDxUpUJ3YNmZAPpbWWoYY1Ljp9DwEBI7/K7x+adut+jp/PLb6280A74EHdSOgznmHnc+hVXWwzV+b5NEAGU0/mwP5ulFhhzSlU2B+1jm6DvlQ6vCPQFtl4ApG5n9Eqks/JBUWxXp4qqaHGlH+M9anj7tNV1mhyKoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395095; c=relaxed/simple;
	bh=w+Bio8pJi/7n2TiG58tMfSZRup0J0Txum2s15/lQ4m0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VnGqSrHVFWYVaQqlz+IYjNYeZ5aDId5VWEe+IUP5Vbpsml/0+gb24/94z1iGTRAJfm1IIQa9Gz4arcB4RaGdMKP6J8ouZQ4CLY0zqQQtbD5QeEGBEQg/MWg402Eh3GeXTz0ARF/nxkXuQkDz5rWj5CbMNZlwGd7HxE4JTE6hpT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eg3mDW44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91872C43390;
	Sat, 27 Jan 2024 22:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706395095;
	bh=w+Bio8pJi/7n2TiG58tMfSZRup0J0Txum2s15/lQ4m0=;
	h=Subject:To:Cc:From:Date:From;
	b=Eg3mDW444iWzMEyfTbrHGASLU/r0lyfTwnimvcgImJFha1SDbypgwigDfTGRvQt4h
	 +SNrULiQoNSocm2dR2npVQaOx/OXU/RLwuV4y8VabQU02QGHh5Ubt1IQEZI+utl5Xq
	 NtbdKd6/ZTM9lflGflO9FhFMXF77mlkP/cvSnQYg=
Subject: FAILED: patch "[PATCH] drm/amd/display: Restore guard against default backlight" failed to apply to 6.7-stable tree
To: mario.limonciello@amd.com,alexander.deucher@amd.com,camille.cho@amd.com,hamza.mahfooz@amd.com,krunoslav.kovac@amd.com,mark.herbert42@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:38:14 -0800
Message-ID: <2024012714-quaintly-zoom-035c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x a2020be69490ee8778c59a02e7b270dfeecffbd4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012714-quaintly-zoom-035c@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

a2020be69490 ("drm/amd/display: Restore guard against default backlight value < 1 nit")
43b8ac4b34ec ("drm/amd/display: Simplify brightness initialization")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2020be69490ee8778c59a02e7b270dfeecffbd4 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 6 Dec 2023 12:08:26 -0600
Subject: [PATCH] drm/amd/display: Restore guard against default backlight
 value < 1 nit

Mark reports that brightness is not restored after Xorg dpms screen blank.

This behavior was introduced by commit d9e865826c20 ("drm/amd/display:
Simplify brightness initialization") which dropped the cached backlight
value in display code, but also removed code for when the default value
read back was less than 1 nit.

Restore this code so that the backlight brightness is restored to the
correct default value in this circumstance.

Reported-by: Mark Herbert <mark.herbert42@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3031
Cc: stable@vger.kernel.org
Cc: Camille Cho <camille.cho@amd.com>
Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Fixes: d9e865826c20 ("drm/amd/display: Simplify brightness initialization")
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index ac0fa88b52a0..bf53a86ea817 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -287,8 +287,8 @@ bool set_default_brightness_aux(struct dc_link *link)
 	if (link && link->dpcd_sink_ext_caps.bits.oled == 1) {
 		if (!read_default_bl_aux(link, &default_backlight))
 			default_backlight = 150000;
-		// if > 5000, it might be wrong readback
-		if (default_backlight > 5000000)
+		// if < 1 nits or > 5000, it might be wrong readback
+		if (default_backlight < 1000 || default_backlight > 5000000)
 			default_backlight = 150000;
 
 		return edp_set_backlight_level_nits(link, true,


