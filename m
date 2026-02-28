Return-Path: <stable+bounces-220354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PD0I001o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA221C5FD2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3E1331ACB8D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F413739D335;
	Sat, 28 Feb 2026 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFA2Mxyn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C939DBB9;
	Sat, 28 Feb 2026 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300251; cv=none; b=e9PfMNV9ZePvaAWIr3z+sfmFAy+vKDvNU7mh8TGzgZiwjdTNMv3Y02hyWFRlBXL10KLLrLzQqK6hYme7YLkUbhYA8Sh2YXaKFBVqLrA8aQ1N9LbBxtseBgUpx4by7lIrY9MejgEBgQLGBPYlvWgk0CSJT0tqvyiM6W2uaAqG9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300251; c=relaxed/simple;
	bh=lFIQsHIrqvNn21gjj9XgQaLlMHDAjX6d1NCnweCJJc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jySEppH6GmyeuxglNL8CvgiNzRSwg88LyW/J4Am/nk4afK0gGYlpUlb+NJo5laqpHqDORl0fTjqHcKHIktVq+Bj0o99dFHDlpN363fsqGmL/o3mBeZHZ7dk47PqPXfeUuZeMyNZpR0ISiRPaOIBm4jPU2+IOvZPiR02SaTEuIOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFA2Mxyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1A6C19425;
	Sat, 28 Feb 2026 17:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300251;
	bh=lFIQsHIrqvNn21gjj9XgQaLlMHDAjX6d1NCnweCJJc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFA2Mxyn/HIVaf8SeK5d0hjaKyTLKbgNT38NVqfj/K7rve8VZpDiONTO+6sWxI6N2
	 6wQgwX0PtYlqHKi++cAxgKQTo9Qq6HxLTIGGRtcYrNxB2LshXeLy4MAIzoyzpEKgMd
	 XyHrBGZFbTdBj5DFzR93bxfgADtW880aUIap9nKXyGweQyZ3+Vl9jUIJuK8YmlolNZ
	 WJa95aO56TbqlT7AKo1oFBmhIYOwG8McONEZnwErtO7k7g3gqRgvKXOMgbzL5JlPQo
	 /f+0v7cDc/4CiaHtUG3lWNeZWlrg8rWbuwFbOE8sIFBPHV1k3CksbwfTZOr/rrR0zv
	 9+hb312txZtrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 276/844] PCI: dw-rockchip: Disable BAR 0 and BAR 1 for Root Port
Date: Sat, 28 Feb 2026 12:23:09 -0500
Message-ID: <20260228173244.1509663-277-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220354-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3EA221C5FD2
X-Rspamd-Action: no action

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit b5d712e5b87fc56ff838684afb1bae359eb8069f ]

Some Rockchip PCIe Root Ports report bogus size of 1GiB for the BAR
memories and they cause below resource allocation issue during probe.

  pci 0000:00:00.0: [1d87:3588] type 01 class 0x060400 PCIe Root Port
  pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x3fffffff]
  pci 0000:00:00.0: BAR 1 [mem 0x00000000-0x3fffffff]
  pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
	...
  pci 0000:00:00.0: BAR 0 [mem 0x900000000-0x93fffffff]: assigned
  pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: can't assign; no space
  pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: failed to assign
  pci 0000:00:00.0: ROM [mem 0xf0200000-0xf020ffff pref]: assigned
  pci 0000:00:00.0: BAR 0 [mem 0x900000000-0x93fffffff]: releasing
  pci 0000:00:00.0: ROM [mem 0xf0200000-0xf020ffff pref]: releasing
  pci 0000:00:00.0: BAR 0 [mem 0x900000000-0x93fffffff]: assigned
  pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: can't assign; no space
  pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: failed to assign

Since there is no use of the Root Port BAR memories, disable both of them.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
[mani: reworded the description and comment]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/1766570461-138256-1-git-send-email-shawn.lin@rock-chips.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index bf8ec3ca6f689..a3daac74d3f18 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -80,6 +80,8 @@
 #define  PCIE_LINKUP_MASK		GENMASK(17, 16)
 #define  PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
 
+#define PCIE_TYPE0_HDR_DBI2_OFFSET      0x100000
+
 struct rockchip_pcie {
 	struct dw_pcie pci;
 	void __iomem *apb_base;
@@ -292,6 +294,8 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	if (irq < 0)
 		return irq;
 
+	pci->dbi_base2 = pci->dbi_base + PCIE_TYPE0_HDR_DBI2_OFFSET;
+
 	ret = rockchip_pcie_init_irq_domain(rockchip);
 	if (ret < 0)
 		dev_err(dev, "failed to init irq domain\n");
@@ -302,6 +306,10 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	rockchip_pcie_configure_l1ss(pci);
 	rockchip_pcie_enable_l0s(pci);
 
+	/* Disable Root Ports BAR0 and BAR1 as they report bogus size */
+	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, 0x0);
+	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_1, 0x0);
+
 	return 0;
 }
 
-- 
2.51.0


