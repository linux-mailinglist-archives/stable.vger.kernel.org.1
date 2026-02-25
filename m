Return-Path: <stable+bounces-218314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG5MHKxRnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:34:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C2718F051
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8602B308100D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB332417E0;
	Wed, 25 Feb 2026 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z8UBFYkX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A31D5ABA;
	Wed, 25 Feb 2026 01:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983117; cv=none; b=qlJAZ00G72Ej5ODRgnJCK6XoG1MGIZN1c/Bm+JXHpGJFaksHDHBl1bn5Oar0r2HBUv7eaIwwduCYm3C5LJeqRgTWfNzthBRiCOReXyxTvQ7nJCrxoM3bdyq6jVK3P5jwbcYPkTfG676+bKGUjKqfnLZeYiWw/wY9Cq3UD53O/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983117; c=relaxed/simple;
	bh=0O24iYf6ie0lTl6Qu6YoqI+JQnxMlHEeoAkYtJMJYzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6aWfV5+47sjN0839FKunxohUhFmoz8bZR1qahBgMWGCpuvDHJ0YIh+WmZcCZ4Bz6+ScAVt8czOqYumksh5nljMcw0OTUMu5geLS1TMhEP6OH+kf1IAXDYfxE2tNJm4Ypf8QxCKLCpzv5QiZB5bC4PCBpqBMjS/lXXZzFmh8zkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z8UBFYkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEE7C19424;
	Wed, 25 Feb 2026 01:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983115;
	bh=0O24iYf6ie0lTl6Qu6YoqI+JQnxMlHEeoAkYtJMJYzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z8UBFYkXTImZPHKePDerb/7M/VQBHzq8JpHiBVw6/Dgr2y6HQK01BtN7dgxxb3rha
	 5HlMa8M+Q52F0rSAU+xwrCbASu+SyKhLT8l+ZmAytk3UAcUYb9RpBnyqX6+RnO16x7
	 2vMPliVcGxq45qLEyavt6NKlkhIs3koZgAcKv+uY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 275/781] drm/rockchip: dw_hdmi_qp: Fix RK3576 HPD interrupt handling
Date: Tue, 24 Feb 2026 17:16:24 -0800
Message-ID: <20260225012406.443526985@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218314-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 11C2718F051
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 5f7be8afc40c5ccf1be0410514703e50a49532c0 ]

The threaded interrupt handler on RK3576 checks HPD IRQ status before
deciding to continue with interrupt clearing and unmasking.

This is not only redundant, since a similar verification has been
already performed by the hard IRQ handler before masking the interrupt,
but is also error prone, because it might happen that hardware clears
the status register right after the masking operation completes, and
before the threaded handler reads its value.

The consequence is that HPD IRQ gets never unmasked, which breaks
hotplug detection until reloading the driver or rebooting the system.

Drop the unnecessary verification of the HPD interrupt status from the
threaded interrupt handler.

Fixes: 36439120efbd ("drm/rockchip: dw_hdmi_qp: Add basic RK3576 HDMI output support")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20260115-dw-hdmi-qp-hpd-v1-1-e59c166eaa65@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 8604342f99432..c7158b1b8c59e 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -280,12 +280,7 @@ static irqreturn_t dw_hdmi_qp_rk3576_hardirq(int irq, void *dev_id)
 static irqreturn_t dw_hdmi_qp_rk3576_irq(int irq, void *dev_id)
 {
 	struct rockchip_hdmi_qp *hdmi = dev_id;
-	u32 intr_stat, val;
-
-	regmap_read(hdmi->regmap, RK3576_IOC_HDMI_HPD_STATUS, &intr_stat);
-
-	if (!intr_stat)
-		return IRQ_NONE;
+	u32 val;
 
 	val = FIELD_PREP_WM16(RK3576_HDMI_HPD_INT_CLR, 1);
 	regmap_write(hdmi->regmap, RK3576_IOC_MISC_CON0, val);
-- 
2.51.0




