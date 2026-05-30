Return-Path: <stable+bounces-258382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPHZLoQmG2qf/ggAu9opvQ
	(envelope-from <stable+bounces-258382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:03:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD6610E3D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75AE63004688
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7751339A4A4;
	Sat, 30 May 2026 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UKrb5wNX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3E4349CC5;
	Sat, 30 May 2026 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164166; cv=none; b=L5ynT0hpvG1qB+pIrYFuPf7VBvN7miwCLHoW7Nh/QYrRXEsAEFnicKdLWRREUBHo8sd9rev/HksydWCT858Z+DmlK4QlxMHzNVRgyQ/FgG6tJf6BKafs3JkR8AO+b+HGQoA5QwuvdBF82bXtLlnBeZLLUYjUGRQ2AA+nNnPhNw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164166; c=relaxed/simple;
	bh=8r56om+26vNz9Jnv1uGGK4e/Addc3XF2yFeMmpqVKyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1NBsTlAKMXnZE4vpnAy6K29ikY3Y0dp7+72Ss2bw3AtBkjxI9J4Uoa5szEc1oPVn9p5YmtozLBIKAw+bwV1SocNadCrMS1xb0GHhd2KHBG5t69k6LHjrGQl96A6eU9n2yMpHpv04bCpkB80BEAb3MdCJ99Hc6SAOm+zo628SDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UKrb5wNX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA791F00893;
	Sat, 30 May 2026 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164165;
	bh=S1fPccKv5tCTA56OAV18Z5adzCin572HL9wn7+MKfsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UKrb5wNXA+XXytpP25trpHjBQaHNoctHEaZ4bW1862r7NwH6wMGhNpkdjKeR7c8nJ
	 8xQZBAjF61hXeRIh0OPkUKLDXOJxJBk0urEvpsYS/IbtHjOnV9tDmCdXoLoig0er15
	 86IcZSwSBe1gLxERlanYO+1tJ0WnBBmmr5N87B90=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vidya Sagar <vidyas@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 474/776] PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
Date: Sat, 30 May 2026 18:03:08 +0200
Message-ID: <20260530160252.594221143@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258382-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CBAD6610E3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vidya Sagar <vidyas@nvidia.com>

[ Upstream commit f62bc7917de1374dce86a852ffba8baf9cb7a56a ]

The GPIO DT property "nvidia,refclk-select", to select the PCIe reference
clock is optional. Use devm_gpiod_get_optional() to get it.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Link: https://patch.msgid.link/20260324190755.1094879-7-mmaddireddy@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index c32184e8e5636..d5f48aa6bf5a2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1146,9 +1146,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 		return err;
 	}
 
-	pcie->pex_refclk_sel_gpiod = devm_gpiod_get(pcie->dev,
-						    "nvidia,refclk-select",
-						    GPIOD_OUT_HIGH);
+	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
+							     "nvidia,refclk-select",
+							     GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
 		int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
 		const char *level = KERN_ERR;
-- 
2.53.0




