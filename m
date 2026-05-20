Return-Path: <stable+bounces-253062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFJIC1UBDmo95QUAu9opvQ
	(envelope-from <stable+bounces-253062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:45:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D95972FE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 655F630CE8C0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEA23E2AAD;
	Wed, 20 May 2026 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yNLHt5ti"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE3BDF59;
	Wed, 20 May 2026 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302304; cv=none; b=kdyEH+yYERfb2YHEYOBIRZ5RcPmROL0L6DmS6h6ckKTjKj5hqfh53VFbEzFRbcIayrvJf1oRHWKgNcvHOyP0tg8RZBuF91R57n5GGV64rTMjEmz5/8y7dP8EVdmr81L5BjLjv5JBQvtmZKc0n6OfRKyyJHZAS1Rii/4+Wk8uP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302304; c=relaxed/simple;
	bh=Py8V/sHP02jsT4b+zqEbFfRlmkLId4QmP0W+CTLK5Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RashIKC5sa0HZ/GxguoTyFnIEqeeIMufiRNnBg6ByV0zuGtcZWcV79JN7oKzyS4nMgNYZU++PNtdQFV6mjCnti84wd0dhz+67JHNJTNbVBTkXSpSc9jnP36Le7AMgSoLbLuxv6o84L5A1W4QzFIoP04m6SQkFLBlUn8I6+3nniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yNLHt5ti; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268961F000E9;
	Wed, 20 May 2026 18:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302303;
	bh=7ODuuQriPOAUpHKJQaqoEj/kv8Ra52DHmQP9u9ACXoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yNLHt5tiv9VxgHGCNwVw6dHfvWa8Qs0VXDUCjxwWZVKixtfUyeygu3GmqhhbgKz82
	 C1N7AufBnjgZGACG6yFUKJIsns9D0JwmjuMSErORbpL2Fon71VDYGnfp9vbjfBHPit
	 LqUPy8F3ysOBKVqVK+EPnE3/2KtogHmMzS1quoLM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 165/508] PCI: tegra194: Use DWC IP core version
Date: Wed, 20 May 2026 18:19:48 +0200
Message-ID: <20260520162102.214443813@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253062-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email,msgid.link:url]
X-Rspamd-Queue-Id: C58D95972FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manikanta Maddireddy <mmaddireddy@nvidia.com>

[ Upstream commit ea60ca067f0f098043610c96a915d162113c1aac ]

Tegra194 PCIe driver used custom version numbers to detect Tegra194 and
Tegra234 IPs. With version detect logic added, version check results in
mismatch warnings:

  tegra194-pcie 14100000.pcie: Versions don't match (0000562a != 3536322a)

Use HW version numbers which match to PORT_LOGIC.PCIE_VERSION_OFF in
Tegra194 driver to avoid these kernel warnings.

Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Link: https://patch.msgid.link/20260324190755.1094879-12-mmaddireddy@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 drivers/pci/controller/dwc/pcie-tegra194.c   | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index fec9473869bce..1ffa31797a17c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -31,8 +31,10 @@
 #define DW_PCIE_VER_470A		0x3437302a
 #define DW_PCIE_VER_480A		0x3438302a
 #define DW_PCIE_VER_490A		0x3439302a
+#define DW_PCIE_VER_500A		0x3530302a
 #define DW_PCIE_VER_520A		0x3532302a
 #define DW_PCIE_VER_540A		0x3534302a
+#define DW_PCIE_VER_562A		0x3536322a
 
 #define __dw_pcie_ver_cmp(_pci, _ver, _op) \
 	((_pci)->version _op DW_PCIE_VER_ ## _ver)
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index cab6cd5b8f3cd..89109e380635c 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -37,8 +37,8 @@
 #include <soc/tegra/bpmp-abi.h>
 #include "../../pci.h"
 
-#define TEGRA194_DWC_IP_VER			0x490A
-#define TEGRA234_DWC_IP_VER			0x562A
+#define TEGRA194_DWC_IP_VER			DW_PCIE_VER_500A
+#define TEGRA234_DWC_IP_VER			DW_PCIE_VER_562A
 
 #define APPL_PINMUX				0x0
 #define APPL_PINMUX_PEX_RST			BIT(0)
-- 
2.53.0




