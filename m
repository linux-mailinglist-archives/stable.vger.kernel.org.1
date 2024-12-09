Return-Path: <stable+bounces-100086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E559E88CE
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 02:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B111638AE
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 01:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBD9F4F1;
	Mon,  9 Dec 2024 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxgtJdjm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19544BA3D
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 01:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733706135; cv=none; b=Q/ngtgR/EzVojmuTOmcWtCPdiJNXQuyNXZU2PC5gDFPiZd58Q0tB3cuIvRNlswHidNKUTHVV1j8NwbdLVlkWBYwsWvb1TdH9W0qh436arldz4uYvZp0XJKRiRvuH0aQySUhcM4hGYr8SgEF6s2IsvWEMUJ++lsGbSzDpV1Yr5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733706135; c=relaxed/simple;
	bh=Oitb2wArj09p/H6160f7SI9ohqC/bnw8VukNLlKE45I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtqjuIn3E2wCvGR/qaIr4ZHPXvoHAlVunEV2hIEd5KCA35E2I7sF2lRlDgrqhWGVu3kz86H4JW2ZlrEAzl/2YT04/H9NITeYNYzqvAfVduwVcz/R3Ms+5PUZPlXc7NqZhRLYphj/yxVtWqkVTlpDEP0Vc81Hpb2vwdaayfReMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxgtJdjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79031C4CED2
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 01:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733706134;
	bh=Oitb2wArj09p/H6160f7SI9ohqC/bnw8VukNLlKE45I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WxgtJdjmVLhN+5ddOeygDXfiwMCoC0Z2nbU7cwxxgfp1NN5jBSqhB5b+IH/YJ16Et
	 LSS9PMBP70Pf11TuVydcLMFR7/J4YEq+oa5JZtSafyjfFBnntys+ykQHUBjR0/WHU6
	 fTiPx5aRsOlK7yoMHDGi34HB5FKY89/QLHJ8EBYjO0G1issKcZmVMO6+fZB5Bz4w83
	 ibiJ1dh56G6elqIQP5FqK4DwfcBvnuLKY2kMHgQ7zCTHwvGlTgkOtDpr9vlD20Rdv7
	 NSTk9T7Og2yEp0xui6USIUy0LPSYXuCd6uERnXthz8wkNOaA84scIlMl4ZHU5ivELa
	 k7YHr5w3HOBqA==
From: Damien Le Moal <dlemoal@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 5.4.y] PCI: rockchip-ep: Fix address translation unit programming
Date: Mon,  9 Dec 2024 10:01:51 +0900
Message-ID: <20241209010151.631762-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2024120622-undusted-antitrust-7300@gregkh>
References: <2024120622-undusted-antitrust-7300@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Rockchip PCIe endpoint controller handles PCIe transfers addresses
by masking the lower bits of the programmed PCI address and using the
same number of lower bits masked from the CPU address space used for the
mapping. For a PCI mapping of <size> bytes starting from <pci_addr>,
the number of bits masked is the number of address bits changing in the
address range [pci_addr..pci_addr + size - 1].

However, rockchip_pcie_prog_ep_ob_atu() calculates num_pass_bits only
using the size of the mapping, resulting in an incorrect number of mask
bits depending on the value of the PCI address to map.

Fix this by introducing the helper function
rockchip_pcie_ep_ob_atu_num_bits() to correctly calculate the number of
mask bits to use to program the address translation unit. The number of
mask bits is calculated depending on both the PCI address and size of
the mapping, and clamped between 8 and 20 using the macros
ROCKCHIP_PCIE_AT_MIN_NUM_BITS and ROCKCHIP_PCIE_AT_MAX_NUM_BITS. As
defined in the Rockchip RK3399 TRM V1.3 Part2, Sections 17.5.5.1.1 and
17.6.8.2.1, this clamping is necessary because:

  1) The lower 8 bits of the PCI address to be mapped by the outbound
     region are ignored. So a minimum of 8 address bits are needed and
     imply that the PCI address must be aligned to 256.

  2) The outbound memory regions are 1MB in size. So while we can specify
     up to 63-bits for the PCI address (num_bits filed uses bits 0 to 5 of
     the outbound address region 0 register), we must limit the number of
     valid address bits to 20 to match the memory window maximum size (1
     << 20 = 1MB).

Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
Link: https://lore.kernel.org/r/20241017015849.190271-2-dlemoal@kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
(cherry picked from commit 64f093c4d99d797b68b407a9d8767aadc3e3ea7a)
---
 drivers/pci/controller/pcie-rockchip-ep.c | 18 +++++++++++++-----
 drivers/pci/controller/pcie-rockchip.h    |  4 ++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 8f2886ed89d1..8fc8848311ab 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -66,18 +66,26 @@ static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
 			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(region));
 }
 
+static int rockchip_pcie_ep_ob_atu_num_bits(struct rockchip_pcie *rockchip,
+					    u64 pci_addr, size_t size)
+{
+	int num_pass_bits = fls64(pci_addr ^ (pci_addr + size - 1));
+
+	return clamp(num_pass_bits,
+		     ROCKCHIP_PCIE_AT_MIN_NUM_BITS,
+		     ROCKCHIP_PCIE_AT_MAX_NUM_BITS);
+}
+
 static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
 					 u32 r, u32 type, u64 cpu_addr,
 					 u64 pci_addr, size_t size)
 {
-	u64 sz = 1ULL << fls64(size - 1);
-	int num_pass_bits = ilog2(sz);
+	int num_pass_bits;
 	u32 addr0, addr1, desc0, desc1;
 	bool is_nor_msg = (type == AXI_WRAPPER_NOR_MSG);
 
-	/* The minimal region size is 1MB */
-	if (num_pass_bits < 8)
-		num_pass_bits = 8;
+	num_pass_bits = rockchip_pcie_ep_ob_atu_num_bits(rockchip,
+							 pci_addr, size);
 
 	cpu_addr -= rockchip->mem_res->start;
 	addr0 = ((is_nor_msg ? 0x10 : (num_pass_bits - 1)) &
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 1c45b3c32151..de24b0488e0b 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -241,6 +241,10 @@
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP	BIT(24)
 #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR				0x1
 #define ROCKCHIP_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
+
+#define ROCKCHIP_PCIE_AT_MIN_NUM_BITS  8
+#define ROCKCHIP_PCIE_AT_MAX_NUM_BITS  20
+
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
 	(PCIE_RC_RP_ATS_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
-- 
2.47.1


