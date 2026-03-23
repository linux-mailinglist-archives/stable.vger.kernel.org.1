Return-Path: <stable+bounces-229132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG5jFqlZwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:18:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C34C2F61B5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 115D030793FD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7BD25333F;
	Mon, 23 Mar 2026 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M7vLiF6+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02D23BF9B;
	Mon, 23 Mar 2026 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278162; cv=none; b=FXsxudSoNf7FPFo+Ass8NAsr5/OXm0uRBG0v8SYpNcnLtffopE9lM6L+nd0ApeNybQ4opCgH9Px68dPvIuE8Nxpgfk+RgjQRIk0VbSG6XSjTYOBG/RLaW2G3UBAyG5kEvDNlfXdHv3+MiVjrkDGkxIzp8l0r8UEQFZCV7m0CVLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278162; c=relaxed/simple;
	bh=Pjd9AosC/+2Y+GkXUZfW73YhP/TfemWag3BgJnJxa/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVwn9+ubLgnS20JK+qCfHO6UvzbHoLqO9lNYL89v9O2J74VDQHocMiJ4MUXXyBoc5WcXbKoF0BTEAoB2bZMmypMcZEQQtOmEjP0Zw55alw1SdPvFuPxm6zY1AJQOOILUP+d7HlAn4y5zANeYlnHLsxuDXTsVLeKSK4JXIK0sHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M7vLiF6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BF6C4CEF7;
	Mon, 23 Mar 2026 15:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278161;
	bh=Pjd9AosC/+2Y+GkXUZfW73YhP/TfemWag3BgJnJxa/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7vLiF6+2cDm94nzsdVULiksU2Pm3oYZvgWIBBh2fizvUIEBMWQ8YVaAfy6hM6JZ1
	 RuhxbtxVvdzvEMHpFTd6xd6ExD8joZsQYyhIRik+g+YjHMujgB3vZXltZ2s2mnVG/H
	 v9C5/ASWnyILdpnKHe7m/mJK4Rk1B8jm4fCx7l2c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pengyu Luo <mitltlatltl@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 219/567] drm/msm/dsi: fix pclk rate calculation for bonded dsi
Date: Mon, 23 Mar 2026 14:42:19 +0100
Message-ID: <20260323134539.247597215@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229132-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.qualcomm.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5C34C2F61B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pengyu Luo <mitltlatltl@gmail.com>

[ Upstream commit e4eb11b34d6c84f398d8f08d7cb4d6c38e739dd2 ]

Recently, we round up new_hdisplay once at most, for bonded dsi, we
may need twice, since they are independent links, we should round up
each half separately. This also aligns with the hdisplay we program
later in dsi_timing_setup()

Example:
	full_hdisplay = 1904, dsc_bpp = 8, bpc = 8
	new_full_hdisplay = DIV_ROUND_UP(1904 * 8, 8 * 3) = 635

if we use half display
	new_half_hdisplay = DIV_ROUND_UP(952 * 8, 8 * 3) = 318
	new_full_display = 636

Fixes: 7c9e4a554d4a ("drm/msm/dsi: Reduce pclk rate for compression")
Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/709716/
Link: https://lore.kernel.org/r/20260306163255.215456-1-mitltlatltl@gmail.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 48a39f8727441..6077331deba97 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -548,13 +548,30 @@ void dsi_link_clk_disable_v2(struct msm_dsi_host *msm_host)
  *  FIXME: Reconsider this if/when CMD mode handling is rewritten to use
  *  transfer time and data overhead as a starting point of the calculations.
  */
-static unsigned long dsi_adjust_pclk_for_compression(const struct drm_display_mode *mode,
-		const struct drm_dsc_config *dsc)
+static unsigned long
+dsi_adjust_pclk_for_compression(const struct drm_display_mode *mode,
+				const struct drm_dsc_config *dsc,
+				bool is_bonded_dsi)
 {
-	int new_hdisplay = DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_int(dsc),
-			dsc->bits_per_component * 3);
+	int hdisplay, new_hdisplay, new_htotal;
 
-	int new_htotal = mode->htotal - mode->hdisplay + new_hdisplay;
+	/*
+	 * For bonded DSI, split hdisplay across two links and round up each
+	 * half separately, passing the full hdisplay would only round up once.
+	 * This also aligns with the hdisplay we program later in
+	 * dsi_timing_setup()
+	 */
+	hdisplay = mode->hdisplay;
+	if (is_bonded_dsi)
+		hdisplay /= 2;
+
+	new_hdisplay = DIV_ROUND_UP(hdisplay * drm_dsc_get_bpp_int(dsc),
+				    dsc->bits_per_component * 3);
+
+	if (is_bonded_dsi)
+		new_hdisplay *= 2;
+
+	new_htotal = mode->htotal - mode->hdisplay + new_hdisplay;
 
 	return mult_frac(mode->clock * 1000u, new_htotal, mode->htotal);
 }
@@ -567,7 +584,7 @@ static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode,
 	pclk_rate = mode->clock * 1000u;
 
 	if (dsc)
-		pclk_rate = dsi_adjust_pclk_for_compression(mode, dsc);
+		pclk_rate = dsi_adjust_pclk_for_compression(mode, dsc, is_bonded_dsi);
 
 	/*
 	 * For bonded DSI mode, the current DRM mode has the complete width of the
-- 
2.51.0




