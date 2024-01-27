Return-Path: <stable+bounces-16201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A5D83F1A4
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9355CB23DFB
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A71200AD;
	Sat, 27 Jan 2024 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sC0ywup6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE01B80B
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397171; cv=none; b=S5xdS8JtJQvsWV1RIwdZgeI1WYNoAeBRaVj8bswf6N77sdz/h8KgNXJPw1V9RbLXm0iZQXiZexFX14E4vGVUb+D5TOwbKANGljaRVSUAkjxHG+Be0XTswYn1REjFf51paf8hhjzSyHftNNti8bTMr2YsULR7LiVBeMIEdrutIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397171; c=relaxed/simple;
	bh=LNFISiRQm7To56GVLKujWuGof56BKcNLHehOmdIoCWU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HLlHBc03FbdpDU88jIWDGPvMB8cykgrW6HzuI6kJi4l4ZOCV+dNgRF1/T9QfwZ37iMQ5jK8fPitXbV7XvZ8Nf5nokDBeaDAAO/KqgdNdwIapFSE2EWnoE+/i/J9du3jttpO34xAWEvE6wV7/Ij7f8cuy9egaLKIK7LxhV+Vyu5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sC0ywup6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E6EC43390;
	Sat, 27 Jan 2024 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397171;
	bh=LNFISiRQm7To56GVLKujWuGof56BKcNLHehOmdIoCWU=;
	h=Subject:To:Cc:From:Date:From;
	b=sC0ywup6OzsLl+5/mgLeFegDZX92mXgPvgiaegB7Y0xoMpCw0XscPVV+TclajL3Uw
	 iDbMMynzSi+GCAZdgk52wZ1DgVcUiGDZJbpCoha67ehpeGaLBu2TQ2KNnwr/uYnKY2
	 Kc71B8DWd+PEuzJfG8Obem1Ff6l2PBZw7Mon3C20=
Subject: FAILED: patch "[PATCH] drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01 name and" failed to apply to 6.6-stable tree
To: hsinyi@chromium.org,dianders@chromium.org,mripard@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:12:50 -0800
Message-ID: <2024012750-extent-anew-979b@gregkh>
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
git cherry-pick -x fc6e7679296530106ee0954e8ddef1aa58b2e0b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012750-extent-anew-979b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

fc6e76792965 ("drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01 name and timing")
3db2420422a5 ("drm/panel-edp: Add AUO B116XTN02, BOE NT116WHM-N21,836X2, NV116WHM-N49 V8.0")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc6e7679296530106ee0954e8ddef1aa58b2e0b5 Mon Sep 17 00:00:00 2001
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Tue, 7 Nov 2023 12:41:51 -0800
Subject: [PATCH] drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01 name and
 timing

Rename AUO 0x405c B116XAK01 to B116XAK01.0 and adjust the timing of
auo_b116xak01: T3=200, T12=500, T7_max = 50 according to decoding edid
and datasheet.

Fixes: da458286a5e2 ("drm/panel: Add support for AUO B116XAK01 panel")
Cc: stable@vger.kernel.org
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231107204611.3082200-2-hsinyi@chromium.org

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 9dce4c702414..2fba7c1f49ce 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -973,6 +973,8 @@ static const struct panel_desc auo_b116xak01 = {
 	},
 	.delay = {
 		.hpd_absent = 200,
+		.unprepare = 500,
+		.enable = 50,
 	},
 };
 
@@ -1870,7 +1872,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),


