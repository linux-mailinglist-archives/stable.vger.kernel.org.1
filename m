Return-Path: <stable+bounces-210852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEY2E/QkcWl8eQAAu9opvQ
	(envelope-from <stable+bounces-210852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:11:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C96055BE36
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4ECE9300DE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129537F109;
	Wed, 21 Jan 2026 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eOFijKnu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F193090E8;
	Wed, 21 Jan 2026 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019603; cv=none; b=FRnMA9BV95j1ZTMWuwgsTCcrXBmW7+6oFj7cryjrqjnrglO1cLxuJaDineaQEUkvJTUI/JsxZmUhin+tr6PMRN1iXIm5mGccdJIm/nA/lnG7TlH6KFFKajVXoRYkK/Wwjfxmile9q+Sz2V4EDpXaRu4F1Wedpbv5BZVpdkGGL3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019603; c=relaxed/simple;
	bh=CwirIoUdzxJ6dXY6XWuUNO9nmPefkKx5Ln+EH5SzeiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHzFxTzHdTsTrOKLFOhm2VZ69vYVflQINbSIL8ZJmvhz/Qg1yRCCSNWJgayuu3umlw3Ts8ZkkqVBtDdgEgH3EwW47Do6Wq0G8KlIrwcll5ZwVpYxqrPFniHlfrtnWAdfjFKsF6fx+f0NwTJBdizKYQfTjJmLy5bXRCSDxqTO9K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eOFijKnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B58C19422;
	Wed, 21 Jan 2026 18:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019602;
	bh=CwirIoUdzxJ6dXY6XWuUNO9nmPefkKx5Ln+EH5SzeiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eOFijKnuCpPvSSWtrk+y0EnYH46nPD4hBIF53SzZ9rReY4Rmmv4rSWIATv0TB9d0/
	 +DIQPul6WWpbm1v0CuIpHBZUmaMYy3u8P8gTgneyqbu3ZwidsMn9C3lQFANr3o20d4
	 re1Wc+SsHXb64U3+syDfHxZ6luqvKGNegV1Smd50=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 052/139] phy: ti: da8xx-usb: Handle devm_pm_runtime_enable() errors
Date: Wed, 21 Jan 2026 19:15:00 +0100
Message-ID: <20260121181413.328833511@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-210852-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C96055BE36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit 08aa19de72110df8ac10c9e67349dd884eeed41d ]

devm_pm_runtime_enable() can fail due to memory allocation. The current
code ignores its return value after calling pm_runtime_set_active(),
leaving the device in an inconsistent state if runtime PM initialization
fails.

Check the return value of devm_pm_runtime_enable() and return on
failure. Also move the declaration of 'ret' to the function scope
to support this check.

Fixes: ee8e41b5044f ("phy: ti: phy-da8xx-usb: Add runtime PM support")
Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20251124105734.1027-1-vulab@iscas.ac.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/ti/phy-da8xx-usb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-da8xx-usb.c b/drivers/phy/ti/phy-da8xx-usb.c
index 68aa595b6ad8d..256f5238153a5 100644
--- a/drivers/phy/ti/phy-da8xx-usb.c
+++ b/drivers/phy/ti/phy-da8xx-usb.c
@@ -180,6 +180,7 @@ static int da8xx_usb_phy_probe(struct platform_device *pdev)
 	struct da8xx_usb_phy_platform_data *pdata = dev->platform_data;
 	struct device_node	*node = dev->of_node;
 	struct da8xx_usb_phy	*d_phy;
+	int ret;
 
 	d_phy = devm_kzalloc(dev, sizeof(*d_phy), GFP_KERNEL);
 	if (!d_phy)
@@ -233,8 +234,6 @@ static int da8xx_usb_phy_probe(struct platform_device *pdev)
 			return PTR_ERR(d_phy->phy_provider);
 		}
 	} else {
-		int ret;
-
 		ret = phy_create_lookup(d_phy->usb11_phy, "usb-phy",
 					"ohci-da8xx");
 		if (ret)
@@ -249,7 +248,9 @@ static int da8xx_usb_phy_probe(struct platform_device *pdev)
 			  PHY_INIT_BITS, PHY_INIT_BITS);
 
 	pm_runtime_set_active(dev);
-	devm_pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 	/*
 	 * Prevent runtime pm from being ON by default. Users can enable
 	 * it using power/control in sysfs.
-- 
2.51.0




