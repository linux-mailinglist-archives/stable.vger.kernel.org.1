Return-Path: <stable+bounces-220781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPZzC+5Wo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:58:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B5A1C8A7B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40CD5338ACED
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B269940A904;
	Sat, 28 Feb 2026 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUnAx/va"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7396140A8FC;
	Sat, 28 Feb 2026 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300665; cv=none; b=A5QcILoDcuMKaXygHTm3FUS8OYrTg/WG5/Tqi96Wnf9h2MBt7l4gbx7QvVZWpDVcxA3C43ZVDWaS3qOCgeSbkuSbjEX/FX+fWUe6WpEN4yRI13ZeXKslA53y1rA9kAq8gV6TZTKe+0mSlIl+5EKlaKPBjiUhmbY1c3z7r/0QzXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300665; c=relaxed/simple;
	bh=JSxcDFknxS5iM5aU8le0mweKjNJSX/1pheTt1QFMtgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d65/z9HUar2m6WUbXAMcwbxVq03x95K4RPYshQbt39M/hICenqZNH8Nfg016u3OH7KuDj/uGtur+PL0O1kh7rVAS60eNp/bVHvUFPVfQY31jhmXHpEPFmFd1K9QXhDLU1q0JybqwE/1be6RZVuL1pJArHZY/UBaIp88EpSuLB/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUnAx/va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565B0C116D0;
	Sat, 28 Feb 2026 17:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300665;
	bh=JSxcDFknxS5iM5aU8le0mweKjNJSX/1pheTt1QFMtgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUnAx/vaprACkiCRMNwZtWNg/5cqdC0jvCDGL7Br4LdCRsW5XX/u1nszPRA2v2qKL
	 CZewt/KjgXMRLFU8651g9Ppj6r38E43nJJmvHaoKKkLiYirW45CvfcjyQlohzFnvTJ
	 TPIU8c0rjuDJsTyVvsEFMp+SCfof3nUxR8bt14hUl6GuW/2m1VuiIbcqlZMVHwLgBl
	 pdmbWZTDbhQdfurLbS3ziEiMJAUA8hog/C/huXsQRkCkXZDoXZPwg9SFIahz0khC/a
	 E9WsLOk2HnSpEoZJ8AXVNRznuVpRupwKhICWRgZUJFHPveSM+2gw6FK7/Mvgo2eiBS
	 ju8RF9TZAx0+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haotien Hsu <haotienh@nvidia.com>,
	stable <stable@kernel.org>,
	Wayne Chang <waynec@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 702/844] usb: gadget: tegra-xudc: Add handling for BLCG_COREPLL_PWRDN
Date: Sat, 28 Feb 2026 12:30:15 -0500
Message-ID: <20260228173244.1509663-703-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220781-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,msgid.link:url]
X-Rspamd-Queue-Id: 30B5A1C8A7B
X-Rspamd-Action: no action

From: Haotien Hsu <haotienh@nvidia.com>

[ Upstream commit 1132e90840abf3e7db11f1d28199e9fbc0b0e69e ]

The COREPLL_PWRDN bit in the BLCG register must be set when the XUSB
device controller is powergated and cleared when it is unpowergated.
If this bit is not explicitly controlled, the core PLL may remain in an
incorrect power state across suspend/resume or ELPG transitions.
Therefore, update the driver to explicitly control this bit during
powergate transitions.

Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
Cc: stable <stable@kernel.org>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
Signed-off-by: Wayne Chang <waynec@nvidia.com>
Link: https://patch.msgid.link/20260123173121.4093902-1-waynec@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 9d2007f448c04..7f7251c10e952 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -3392,17 +3392,18 @@ static void tegra_xudc_device_params_init(struct tegra_xudc *xudc)
 {
 	u32 val, imod;
 
+	val = xudc_readl(xudc, BLCG);
 	if (xudc->soc->has_ipfs) {
-		val = xudc_readl(xudc, BLCG);
 		val |= BLCG_ALL;
 		val &= ~(BLCG_DFPCI | BLCG_UFPCI | BLCG_FE |
 				BLCG_COREPLL_PWRDN);
 		val |= BLCG_IOPLL_0_PWRDN;
 		val |= BLCG_IOPLL_1_PWRDN;
 		val |= BLCG_IOPLL_2_PWRDN;
-
-		xudc_writel(xudc, val, BLCG);
+	} else {
+		val &= ~BLCG_COREPLL_PWRDN;
 	}
+	xudc_writel(xudc, val, BLCG);
 
 	if (xudc->soc->port_speed_quirk)
 		tegra_xudc_limit_port_speed(xudc);
@@ -3953,6 +3954,7 @@ static void tegra_xudc_remove(struct platform_device *pdev)
 static int __maybe_unused tegra_xudc_powergate(struct tegra_xudc *xudc)
 {
 	unsigned long flags;
+	u32 val;
 
 	dev_dbg(xudc->dev, "entering ELPG\n");
 
@@ -3965,6 +3967,10 @@ static int __maybe_unused tegra_xudc_powergate(struct tegra_xudc *xudc)
 
 	spin_unlock_irqrestore(&xudc->lock, flags);
 
+	val = xudc_readl(xudc, BLCG);
+	val |= BLCG_COREPLL_PWRDN;
+	xudc_writel(xudc, val, BLCG);
+
 	clk_bulk_disable_unprepare(xudc->soc->num_clks, xudc->clks);
 
 	regulator_bulk_disable(xudc->soc->num_supplies, xudc->supplies);
-- 
2.51.0


