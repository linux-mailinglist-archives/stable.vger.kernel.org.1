Return-Path: <stable+bounces-250449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKkzBlMQDmrw5wUAu9opvQ
	(envelope-from <stable+bounces-250449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:49:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E90598C61
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3793E376FF6D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B96B363C59;
	Wed, 20 May 2026 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="teK8Mj6E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D520221F2F;
	Wed, 20 May 2026 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295441; cv=none; b=pe3uEUtgUVZEQNfJEx/wkttXvxIo9Q24mUHg2EWnJK9QVxqoTiw94WQcvPcA5EAQGaW0zk+WSlIq4x4ZFmfd85bm+C5kKcPzwGl6b+4LQEM+oo2WggS4KpC/dhTbmutvNmpldSMriSKYuQ7BsVjlpk9Yy9IbDghYcJKv3gxLAUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295441; c=relaxed/simple;
	bh=3lirELHYPlltxMskfyU1VhUNSEN3fMhDbDAQOffg85s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLNqFM26P7pcSa4dQT0gnQFmq/Wh249HXnkGoUSor7zvf9KI6g0n5M2djL2Qp+1SjtNsdz5w0jwLjjxTAPnxBaQHy9/x40exS0KqgPGNDp7poLkOPCYqzvCsugSMMcOPM5jJH3VFaTWGW50R1aFo+ZKfkF7xMbS0S0D8GPmLC+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=teK8Mj6E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AC91F000E9;
	Wed, 20 May 2026 16:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295440;
	bh=Z1WjxznSrPoz1f1xYzHPJ+Y/P551hEJcZ8XDwGZ9cTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=teK8Mj6E4c/+82Pi3wKTFQvblCv1oqc1FHiTLirQIk0wbtssAywJDlB1I8wy6kb1m
	 SA8snXiwVJruThY21QRnxWr5hby/7BbpCeUVU/AAqhs89O7ojm9PQikZUBAVPzjCNz
	 TZE/5xNFPkCmddnbB0dH7LyuIVrvudcXfWw6N4uw=
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
Subject: [PATCH 7.0 0419/1146] PCI: tegra194: Disable PERST# IRQ only in Endpoint mode
Date: Wed, 20 May 2026 18:11:09 +0200
Message-ID: <20260520162157.678724437@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250449-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A9E90598C61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manikanta Maddireddy <mmaddireddy@nvidia.com>

[ Upstream commit 40658a31b6e134169c648041efc84944c4c71dcd ]

The PERST# GPIO interrupt is only registered when the controller is
operating in Endpoint mode. In Root Port mode, the PERST# GPIO is
configured as an output to control downstream devices, and no interrupt is
registered for it.

Currently, tegra_pcie_dw_stop_link() unconditionally calls disable_irq()
on pex_rst_irq, which causes issues in Root Port mode where this IRQ is
not registered.

Fix this by only disabling the PERST# IRQ when operating in Endpoint mode,
where the interrupt is actually registered and used to detect PERST#
assertion/deassertion from the host.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Link: https://patch.msgid.link/20260324190755.1094879-6-mmaddireddy@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index c84eb1ba3a11c..ceb34110a50b3 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1025,7 +1025,8 @@ static void tegra_pcie_dw_stop_link(struct dw_pcie *pci)
 {
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 
-	disable_irq(pcie->pex_rst_irq);
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		disable_irq(pcie->pex_rst_irq);
 }
 
 static const struct dw_pcie_ops tegra_dw_pcie_ops = {
-- 
2.53.0




