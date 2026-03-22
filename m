Return-Path: <stable+bounces-227848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDXrBqkgwGkOEAQAu9opvQ
	(envelope-from <stable+bounces-227848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 18:02:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A16C82EA19A
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 18:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63CCB3006125
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FA4310651;
	Sun, 22 Mar 2026 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Z65NM3eO"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4417C175A7B;
	Sun, 22 Mar 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774198944; cv=none; b=aO+9mf/asbGbBLrFtjmKY+/l6krMwv00JDTTZMpEIre7u0ysXqS4TVi2s9OxW483aZQolqXSLFePY48h3LOxsSW6/FmYow/ezhWhZmf08Jh8KO/T9gSu7j9Wt58ssClUk+9IBIv4jcKABFQPgVIA4rMjTIYt4pyz5QF0uL/MEH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774198944; c=relaxed/simple;
	bh=iW7rNRh2ArJWOxm9/fuOocPIaTFuDAFc1tz6G/PVRKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uxkJi5jmjwJrNM0/bggrgGWXBA20a0hpbUQkCsO4oo9UXtwsNEL6KZRbAtl2UskQ+JsPlI1HaijxXY8smY9qDGHWQ1gzEXPsUjdC8WvFPWAdIF8yq8Dj4D/fU7Onr20TFpSYH6ts1ckRDQIz0inZsMGSK5vXsq4DG3FnyLZRTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Z65NM3eO; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D260B26E75;
	Sun, 22 Mar 2026 18:02:21 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uLtavyJ539ik; Sun, 22 Mar 2026 18:02:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774198940; bh=iW7rNRh2ArJWOxm9/fuOocPIaTFuDAFc1tz6G/PVRKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z65NM3eObpu8kyaSTYSY8vm83xcXAschgnwWAP8aqijIT8g+lO+PO0AxfFkv4kKmr
	 oxeVq8sEwLyWztt44CcSCrcsT8e6gQN7nHtrrJrnygWNO2u27Y3j7JDulv9SPllLpr
	 EE8D6G2IFdCGBtLe6tIFEkfgFlubHag6jYCRJlzcInMOvH5C8lzkZNBdjHhFIuZKTv
	 FiITvi3xRJ1xkXA/2S+U7WWRxEYwVcrbDV1uFBeIyyyURPbIwDREmRHSVS8pUB6LmB
	 7XO8hMVjcIy1k+IWlslTBM0oS3XKHsTYkl9w4frUSzIK0ZhQGx/9CUL85s3B0ObR+G
	 7E0TBy1lD4nyA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sun, 22 Mar 2026 22:32:06 +0530
Subject: [PATCH RESEND v2 1/2] drm/bridge: samsung-dsim: enable MFLUSH_VS
 for Exynos 7870 DSIM
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260322-exynos-dsim-fixes-v2-1-0069c9e1d9bf@disroot.org>
References: <20260322-exynos-dsim-fixes-v2-0-0069c9e1d9bf@disroot.org>
In-Reply-To: <20260322-exynos-dsim-fixes-v2-0-0069c9e1d9bf@disroot.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227848-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A16C82EA19A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit a36c533ad3e1 ("drm/bridge: samsung-dsim: Always flush display
FIFO on vsync pulse") intends to enable FIFO flushing at v-sync pulse by
not setting the active-low MFLUSH_VS bit.

However, in Exynos 7870 DSIM, the MFLUSH_VS bit is active-high. There is
no publicly available documentation to the best of my knowledge, but
downstream kernel code [1] supports this claim. Enable the bit for
Exynos 7870.

Cc: stable@vger.kernel.org # v6.17 and later
Link: https://github.com/samsungexynos7870/android_kernel_samsung_exynos7870/blob/a3762bb1761ae/drivers/video/fbdev/exynos/decon_7870/dsim_reg_7870.c#L699 [1]
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 1d85e706c74b9..70f8946ad3b24 100644
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
2.53.0


