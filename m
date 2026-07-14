Return-Path: <stable+bounces-274502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PX3qCR9+Vmps7QAAu9opvQ
	(envelope-from <stable+bounces-274502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:21:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D18757CC3
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:21:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="QjgJ/JWK";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274502-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274502-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 027FF30333CF
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DF3331ECD;
	Tue, 14 Jul 2026 18:21:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36F93CF204
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 18:21:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053276; cv=none; b=sHwOD4U4fLMxrWVIvYAKcxOZ3rmo+gTYWPwYnp/8DaupcN9e1y9m7DlCieSit3wF8SZ3lk+tIGcixEp3DD8mEYnYE9TYFfMEuUkiG+2P9TdAAHRIK+jFLrkvzM8mLpo/Tk2UCZdQXQyl+fY1GbSB9ranyUmnU7tJxbiqgq4vACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053276; c=relaxed/simple;
	bh=1ppw4XdZA8uVbAbcxpD99MmvyLgsgvCe2DbzUdCCiOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmV3S+KKRdmxjZ+W3tLuKaGC90suDXc8ptTpOkwlLUkpb7BU57l8mJ55DYFnphvTsCwD7QkNSueEgOSYC8oQwQ5n8mwMrutbnj4OeIu0Nd0Xnkf0mVyqlXMahpTo3wWvFGpSGzJO70ZyZnp/x3+z2Hy0TLcQw/hDfKekOTvvsWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjgJ/JWK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57451F000E9;
	Tue, 14 Jul 2026 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784053275;
	bh=biQMdFE+SIuK38t6fw9ISLz//c8kIWIueIbLhn4ss1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QjgJ/JWKCU0eCAdK+7OAh1WjgrWyhAuCbb/4Kbnz2zwCNKOC4KmE61ky+wGeg5F+J
	 oKCilH8DcMDcRw9BNMbivvIo0qzIZoozOGoIIeibt1Ys9KdWxV0zzx6PGyR9hPozHr
	 1Jfx2YhztAYKfr1zMgRpV6tixDX5SaAYAYn1C/xhr9tbR7LXnSzozqjkQH+BIfIxY1
	 q4pmjbgg5cU17LkiYkY9K0PDd3TcuZS8PIoN1tgN1QN+zd8Ppc+VJcqq1cuBoa7WcI
	 Q72eauxlQ/FyFNiXy7oAj/vcgDbYdJNIq5yXTkuupbf6YupJR2RwI7M64+Yz7DGPVs
	 isP4AntrGaewQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling
Date: Tue, 14 Jul 2026 14:21:13 -0400
Message-ID: <20260714182113.3081792-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071331-starfish-handgun-6882@gregkh>
References: <2026071331-starfish-handgun-6882@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274502-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:hongxing.zhu@nxp.com,m:mani@kernel.org,m:bhelgaas@google.com,m:Frank.Li@nxp.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92D18757CC3

From: Richard Zhu <hongxing.zhu@nxp.com>

[ Upstream commit aad953fb4eed0df5486cd54ccad80ac197678e01 ]

The IMX6SX_GPR12_PCIE_TEST_POWERDOWN bit does not control the PCIe
reference clock on i.MX6SX. Instead, it is part of i.MX6SX PCIe core
reset sequence.

Move the IMX6SX_GPR12_PCIE_TEST_POWERDOWN assertion/deassertion into
the core reset functions to properly reflect its purpose. Remove the
.enable_ref_clk() callback for i.MX6SX since it was incorrectly
manipulating this bit.

Fixes: e3c06cd063d6 ("PCI: imx6: Add initial imx6sx support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260319090844.444987-1-hongxing.zhu@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4f20094faee532..7ebf5889687597 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -539,9 +539,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 			dev_err(dev, "unable to enable pcie_axi clock\n");
 			break;
 		}
-
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
 	case IMX6QP:
 	case IMX6Q:
@@ -740,6 +737,8 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
 		break;
 	case IMX6SX:
+		regmap_clear_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
 		break;
-- 
2.53.0


