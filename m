Return-Path: <stable+bounces-212031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIinEd0semnd3gEAu9opvQ
	(envelope-from <stable+bounces-212031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:35:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDE6A408A
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBF2331EA1BD
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A76236B07E;
	Wed, 28 Jan 2026 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g148Azxv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D273369960;
	Wed, 28 Jan 2026 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614167; cv=none; b=goM5qk97ag24EUg81wFDs91522W+QRKHILThaGbtqRuQUT17jjJ8D9akv3vjfpF6n3/CJd8PiITNpFY2Mcw+GMEB9xivbRZuWPDkPJzevsl/yRhDpoQfxWkC79LuxUHddg11ZCAP5bAMobf5Pg2aenaH4gkOEOBOiJ7mNVnT2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614167; c=relaxed/simple;
	bh=usuxPJPHK1/7fvby/4EWVd5py0wn/BZXLZNGG/BMbuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3GCOAFHB5Oo6fXqpYVqrmuHYECm2vzf/fDBTuAr1kKpWJLX/OjTdDZQOKFdxuprPVk5aN5gvVR0pve5ye03QgXh9wvTN8ub1C1etR8oGsf6WkQiGB71uJqd4V51kqIiUyFaZjRiWzWdJi+CciHHCfAix19P0XDnWDsN9aTw8RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g148Azxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DE3C4CEF1;
	Wed, 28 Jan 2026 15:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614167;
	bh=usuxPJPHK1/7fvby/4EWVd5py0wn/BZXLZNGG/BMbuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g148AzxvIA/hhvYdnIex97zncOhX2lSsJSQ/n0mCdIZDag48GwZ8YN7ZRBBPVJ4E7
	 QRZ1Kiwm2RLrkBR13mbPhgRTMWj7Pcs1dSBJseaJwSztxBm6xhFotfK9mEs5sWKqep
	 FfCkMcFBpnssgsZ6SGDIjHuIHZKDnza8nnRidATI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wayne Chang <waynec@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.6 055/254] phy: tegra: xusb: Explicitly configure HS_DISCON_LEVEL to 0x7
Date: Wed, 28 Jan 2026 16:20:31 +0100
Message-ID: <20260128145346.680070115@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212031-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,nvidia.com:email,msgid.link:url]
X-Rspamd-Queue-Id: CDDE6A408A
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wayne Chang <waynec@nvidia.com>

commit b246caa68037aa495390a60d080acaeb84f45fff upstream.

The USB2 Bias Pad Control register manages analog parameters for signal
detection. Previously, the HS_DISCON_LEVEL relied on hardware reset
values, which may lead to the detection failure.

Explicitly configure HS_DISCON_LEVEL to 0x7. This ensures the disconnect
threshold is sufficient to guarantee reliable detection.

Fixes: bbf711682cd5 ("phy: tegra: xusb: Add Tegra186 support")
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
Link: https://patch.msgid.link/20251212032116.768307-1-waynec@nvidia.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/tegra/xusb-tegra186.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -84,6 +84,7 @@
 #define XUSB_PADCTL_USB2_BIAS_PAD_CTL0		0x284
 #define  BIAS_PAD_PD				BIT(11)
 #define  HS_SQUELCH_LEVEL(x)			(((x) & 0x7) << 0)
+#define  HS_DISCON_LEVEL(x)			(((x) & 0x7) << 3)
 
 #define XUSB_PADCTL_USB2_BIAS_PAD_CTL1		0x288
 #define  USB2_TRK_START_TIMER(x)		(((x) & 0x7f) << 12)
@@ -623,6 +624,8 @@ static void tegra186_utmi_bias_pad_power
 	value &= ~BIAS_PAD_PD;
 	value &= ~HS_SQUELCH_LEVEL(~0);
 	value |= HS_SQUELCH_LEVEL(priv->calib.hs_squelch);
+	value &= ~HS_DISCON_LEVEL(~0);
+	value |= HS_DISCON_LEVEL(0x7);
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
 
 	udelay(1);



