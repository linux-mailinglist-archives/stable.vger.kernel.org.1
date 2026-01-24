Return-Path: <stable+bounces-211465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHgFOqr/dGl+/wAAu9opvQ
	(envelope-from <stable+bounces-211465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 18:21:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAAB7E4BE
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 18:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE1273005755
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 17:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C2E255F5E;
	Sat, 24 Jan 2026 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Wp9nb7MG"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523022F16E;
	Sat, 24 Jan 2026 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769275302; cv=none; b=XFQrLmPCcCp1N+0CHVsHgBUW94A1oAipO+GoCzPfgI64w6MufKlOdsveftcSOMPVj0J9AxvdzRMmsVQZ9AdfpApMamVuT06XVj8M2uHogqf+IquRx/WuV+/YzKnc8rlNQmMD8faLId5ErZr0/Ae3y3KB9RCFrPbHHFnCEaixrnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769275302; c=relaxed/simple;
	bh=klI/8DtlWetqET+K6snjmlkQ5ErwnNBTMyoeJFBz9+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rT3950ga25KxX1+YsBuioMgPtDRjK6lpIT2PzUzelcVNv81kM4yk8Jpvfb8m58U3FPrc5/zPLDXGZ1je7FLJXM4YXIXl9SxMsmXy7sFS/hEPA7nSkaFXbZiCSUaTOc5P8rj0Y7wt+t/NeHEDsDCKQ/SCDmjghMJ74GELVNRtFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Wp9nb7MG; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4CCF326FEF;
	Sat, 24 Jan 2026 18:21:37 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aP7TyxFD8zZK; Sat, 24 Jan 2026 18:21:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769275296; bh=klI/8DtlWetqET+K6snjmlkQ5ErwnNBTMyoeJFBz9+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Wp9nb7MGtgs06wn2LUecVfQm+w3HcKup8A1sOo8yRn8ecmHqKhWdGQFAK9KyjWb5/
	 PdfYm8jus4fv6LOauMc8YyeRHwU407LwrmCmrsumCAPyicelSxY1sPe55N2wb8Jd3f
	 +v7Gbd8w1rJ3NrswCu+zhU1SJXGQWEqvimQi+cxX1xXsHFpfrV6FNka8hN4MxA+w7k
	 85WBXS+cA8aral0QWDTkuXooKj8r9PNrSvbWuQws+M1uIccZI+OMXyJgUsrovuUiD1
	 S56VeXSMsLXW6tUEl7w9Fo0TxT00PBjt+UwsfcKjszzjA/iQxXhy3qpqeUiXdIoHS0
	 80Vr6XBot6qyg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sat, 24 Jan 2026 22:50:47 +0530
Subject: [PATCH 2/3] drm/bridge: samsung-dsim: enable MFLUSH_VS for Exynos
 7870 DSIM
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260124-exynos-dsim-fixes-v1-2-122d047a23d1@disroot.org>
References: <20260124-exynos-dsim-fixes-v1-0-122d047a23d1@disroot.org>
In-Reply-To: <20260124-exynos-dsim-fixes-v1-0-122d047a23d1@disroot.org>
To: Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211465-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[samsung.com,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:email,disroot.org:dkim,disroot.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CAAB7E4BE
X-Rspamd-Action: no action

Commit a36c533ad3e1 ("drm/bridge: samsung-dsim: Always flush display
FIFO on vsync pulse") intends to enable FIFO flushing at v-sync pulse by
not setting the active-low MFLUSH_VS bit.

However, in Exynos 7870 DSIM, the MFLUSH_VS bit is active-high. There is
no publicly available documentation to the best of my knowledge, but
downstream kernel code [1] supports this claim. Enable the bit for
Exynos 7870.

Cc: stable@vger.kernel.org # v6.17 and later
Link: https://github.com/samsungexynos7870/android_kernel_samsung_exynos7870/blob/a3762bb1761aec8543fae511b087da620e24cee5/drivers/video/fbdev/exynos/decon_7870/dsim_reg_7870.c#L699 [1]
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 975f8b50ae660..91f230953a49f 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1089,6 +1089,13 @@ static int samsung_dsim_init_link(struct samsung_dsim *dsi)
 			reg |= DSIM_HBP_DISABLE_MODE;
 		if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_NO_HSA)
 			reg |= DSIM_HSA_DISABLE_MODE;
+
+		/*
+		 * For some hardware types, DSIM_MFLUSH_VS bit needs to be
+		 * enabled explicitly.
+		 */
+		if (dsi->plat_data->hw_type == DSIM_TYPE_EXYNOS7870)
+			reg |= DSIM_MFLUSH_VS;
 	}
 
 	if (dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)

-- 
2.52.0


