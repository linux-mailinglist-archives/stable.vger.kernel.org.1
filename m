Return-Path: <stable+bounces-11902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258FB8316DF
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBE71F26ABD
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6561822F0F;
	Thu, 18 Jan 2024 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K2biKEm8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F58B65C;
	Thu, 18 Jan 2024 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575054; cv=none; b=gTWlx+tOKsgZ8AYS2lUU06stE+jvbwwszmaX3kZCcvX1b57Opli4xZei3uzgNLrhNDtJFuv1imZGey50rndzhnaqxflGXzItj2IxS5IvYNwUsHy58lITB5sg54XnxqSYHPmYx2Lqoct8v/kHoOjvERs59D+Wbw6a47fJe57PmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575054; c=relaxed/simple;
	bh=3bWr3eWbWDWaYnYgkJ+0x+IjfjZr3X8Bycy8T+6wyUk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:User-Agent:X-stable:
	 X-Patchwork-Hint:MIME-Version:Content-Transfer-Encoding; b=n4uOC+nvUNi7TqhbRCp4PHTfLd1QXRAAl68jAk/J1N1U3kH9whKsSLXfU/gcTMagtwqXN1lUSyjsKgI2KJ1/spg1nHsXysEiJDFyxRIYm1XPsuhSn/EDA9iqvtw5Az7lmULpOEHQeWJvFrDs+u6aJk7eBJlchsu6HpDt7omEZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K2biKEm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB4AC433F1;
	Thu, 18 Jan 2024 10:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575054;
	bh=3bWr3eWbWDWaYnYgkJ+0x+IjfjZr3X8Bycy8T+6wyUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K2biKEm8hNzk8CTea3507nsb0uQ6VuXM7yyz04fIZo+GmR3LMLHqUQB+oYAFD/D2j
	 h9kayueaedDp3GRPjBT4pPeSJ+4J02djfzHqLCrtLq203CDb/GR5Knr4wlZPNFjJxn
	 0BjnZ5wo4PofjhQvpMWsi1zlIj/Zucy0N37L+wz8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	LeoLiuoc <LeoLiu-oc@zhaoxin.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.7 24/28] PCI: Add ACS quirk for more Zhaoxin Root Ports
Date: Thu, 18 Jan 2024 11:49:14 +0100
Message-ID: <20240118104302.051675494@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118104301.249503558@linuxfoundation.org>
References: <20240118104301.249503558@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

commit e367e3c765f5477b2e79da0f1399aed49e2d1e37 upstream.

Add more Root Port Device IDs to pci_quirk_zhaoxin_pcie_ports_acs() for
some new Zhaoxin platforms.

Fixes: 299bd044a6f3 ("PCI: Add ACS quirk for Zhaoxin Root/Downstream Ports")
Link: https://lore.kernel.org/r/20231211091543.735903-1-LeoLiu-oc@zhaoxin.com
Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
[bhelgaas: update subject, drop changelog, add Fixes, add stable tag, fix
whitespace, wrap code comment]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: <stable@vger.kernel.org>	# 5.7
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/quirks.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4699,17 +4699,21 @@ static int pci_quirk_xgene_acs(struct pc
  * But the implementation could block peer-to-peer transactions between them
  * and provide ACS-like functionality.
  */
-static int  pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	if (!pci_is_pcie(dev) ||
 	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
 	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
 		return -ENOTTY;
 
+	/*
+	 * Future Zhaoxin Root Ports and Switch Downstream Ports will
+	 * implement ACS capability in accordance with the PCIe Spec.
+	 */
 	switch (dev->device) {
 	case 0x0710 ... 0x071e:
 	case 0x0721:
-	case 0x0723 ... 0x0732:
+	case 0x0723 ... 0x0752:
 		return pci_acs_ctrl_enabled(acs_flags,
 			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 	}



