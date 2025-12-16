Return-Path: <stable+bounces-201316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14668CC233A
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 094683011194
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CD3341AD6;
	Tue, 16 Dec 2025 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EmwLURFx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348D32BF22;
	Tue, 16 Dec 2025 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884242; cv=none; b=kOuNiQBdQgXKQu1bvlgJtbcqVm9KemwN05DF6JHVkWU1U4mS9ez0F0r3cF+ZiVrPAXas5e07y7GFxhr5+Sz0/D1/oTZYiRjYG8LxXmMplf+uGkXqpf+RpMg4jlR2upnq4DfgIn2jlWRbieFuR6jVCKJeX7HG5SxVd2V9TidyNFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884242; c=relaxed/simple;
	bh=vQCMLM88mqKwxJDXWeS0ryxOZy7iVh+5O6yiyrEIOGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nksP88aQmCAyNKkSecDptv5Fq3tGX8ruGCM88i/R5+oIVjqOWWxx1tfRIzV7NbJUaktAiIUMKfRZMFI8+bA7kaefhoB00h4tfdG2Obm1zUjVC45lSvMMZLvGrBkwMck+GJ+Gu8rW7PoaCjc1MxbMhKfUB8lxjwdBDl8JxCnSmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EmwLURFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F963C4CEF1;
	Tue, 16 Dec 2025 11:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765884242;
	bh=vQCMLM88mqKwxJDXWeS0ryxOZy7iVh+5O6yiyrEIOGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EmwLURFxVFqVmi0YLUPxlSL4NMAWcCr24gR2YIse9Tq0vP9oKqAUyH1ea44Z5hvGz
	 P0L2Hi2m7w5rmaoABVTzFvOvNugvztwdLv6TrTWOXViHnMC72OAGpTfQmtE5/wCZXZ
	 Dp27bNEBZFuFQ1XjsOAoMUpSSNyrtcSfygxQeFJ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 133/354] dt-bindings: PCI: amlogic: Fix the register name of the DBI region
Date: Tue, 16 Dec 2025 12:11:40 +0100
Message-ID: <20251216111325.739156982@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
References: <20251216111320.896758933@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[ Upstream commit 4813dea9e272ba0a57c50b8d51d440dd8e3ccdd7 ]

Binding incorrectly specifies the 'DBI' region as 'ELBI'. DBI is a must
have region for DWC controllers as it has the Root Port and controller
specific registers, while ELBI has optional registers.

Hence, fix the binding. Though this is an ABI break, this change is needed
to accurately describe the PCI memory map.

Fixes: 7cd210391101 ("dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe controller")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20251101-pci-meson-fix-v1-1-c50dcc56ed6a@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
index 79a21ba0f9fd6..c8258ef403283 100644
--- a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
@@ -36,13 +36,13 @@ properties:
 
   reg:
     items:
-      - description: External local bus interface registers
+      - description: Data Bus Interface registers
       - description: Meson designed configuration registers
       - description: PCIe configuration space
 
   reg-names:
     items:
-      - const: elbi
+      - const: dbi
       - const: cfg
       - const: config
 
@@ -113,7 +113,7 @@ examples:
     pcie: pcie@f9800000 {
         compatible = "amlogic,axg-pcie", "snps,dw-pcie";
         reg = <0xf9800000 0x400000>, <0xff646000 0x2000>, <0xf9f00000 0x100000>;
-        reg-names = "elbi", "cfg", "config";
+        reg-names = "dbi", "cfg", "config";
         interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
         clocks = <&pclk>, <&clk_port>, <&clk_phy>;
         clock-names = "pclk", "port", "general";
-- 
2.51.0




