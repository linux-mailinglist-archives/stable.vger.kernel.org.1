Return-Path: <stable+bounces-100208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC649E9909
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404991675C1
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629481B4236;
	Mon,  9 Dec 2024 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG/9mZTt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210EC1B4230
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754941; cv=none; b=gpYZ+A0ra8BvuvhRUOBLhOCXygCqqh17ZNJgma4IVDOZvTtxtvD5PGDGtmqcFHK/OXL1Llpt4+XrInuShZ0a6rUkPNT52OE7BzE+hdsk8Q6PfycjdZGNoq7wrncpd2uVla/VxTo0RlA8SYwhTmsgxS352AYses3yQaxY9oSm9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754941; c=relaxed/simple;
	bh=eABXLIweVlrnmMJi0uMs84W1zT/zOGL68X8ei54DjW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZoNDE4uXazFMXwu45aCXPgha1P+rX1V+lyyZ9OQnCRErFriTK3iL2cAS8YhuDr3mm+qRHEtBu6RdSq60Ss0TmBFvEK2tgW/fko2vla8komzoWmtvQ20xNnsc2IPiW3dsQXGaNl9xGPuFAKKFagxXP3mI4G/wkq5Imr3OTQQwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG/9mZTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BE1C4CED1;
	Mon,  9 Dec 2024 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754941;
	bh=eABXLIweVlrnmMJi0uMs84W1zT/zOGL68X8ei54DjW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nG/9mZTtiIb2zYVhY5c2i2WyVRmxA00bHmOYJikzZkhvy8sK3gJG3R7hBu2Qiidyj
	 2WXynrTCaFDQrS/qUR7e96vH0KNnTCQgaM+t/mly/bSkAKG0CtjL/jilewFsLQvmiZ
	 6vZv57GjtP+7qPUm4Rqtu7seCe1eJRCbZSInp3lwtzT4uMoVLBXKOXNPDWu86HzRr2
	 6OSGOzWPDzVL3CLjL5czFchxXRGjemPkA+/1/MwLE3ZYEmzSGDREx34UGXJXIr1c2Q
	 7ZYzC8NaUaEmObszB9VfDrAB7OfoyTbKSWKwzO1pr27HSd0t6vOVaQT1hlLsC+2R/b
	 epUyNSPDxSSKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] PCI: rockchip-ep: Fix address translation unit programming
Date: Mon,  9 Dec 2024 09:35:39 -0500
Message-ID: <20241208203835-417d48592969d506@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209005721.599249-1-dlemoal@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 64f093c4d99d797b68b407a9d8767aadc3e3ea7a


Status in newer kernel trees:
6.12.y | Present (different SHA1: ac9e6da4b96c)
6.6.y | Present (different SHA1: c26371c3c46c)
6.1.y | Present (different SHA1: 2d9d52b990b0)
5.15.y | Present (different SHA1: 46fa1a3f32ae)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  64f093c4d99d7 ! 1:  6ab13b3924c50 PCI: rockchip-ep: Fix address translation unit programming
    @@ Commit message
         Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
         Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
         Cc: stable@vger.kernel.org
    +    (cherry picked from commit 64f093c4d99d797b68b407a9d8767aadc3e3ea7a)
     
      ## drivers/pci/controller/pcie-rockchip-ep.c ##
     @@ drivers/pci/controller/pcie-rockchip-ep.c: static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
    - 			    ROCKCHIP_PCIE_AT_OB_REGION_DESC1(region));
    + 			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(region));
      }
      
     +static int rockchip_pcie_ep_ob_atu_num_bits(struct rockchip_pcie *rockchip,
    @@ drivers/pci/controller/pcie-rockchip-ep.c: static void rockchip_pcie_clear_ep_ob
     +}
     +
      static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
    - 					 u32 r, u64 cpu_addr, u64 pci_addr,
    - 					 size_t size)
    + 					 u32 r, u32 type, u64 cpu_addr,
    + 					 u64 pci_addr, size_t size)
      {
    --	int num_pass_bits = fls64(size - 1);
    +-	u64 sz = 1ULL << fls64(size - 1);
    +-	int num_pass_bits = ilog2(sz);
     +	int num_pass_bits;
    - 	u32 addr0, addr1, desc0;
    + 	u32 addr0, addr1, desc0, desc1;
    + 	bool is_nor_msg = (type == AXI_WRAPPER_NOR_MSG);
      
    +-	/* The minimal region size is 1MB */
     -	if (num_pass_bits < 8)
     -		num_pass_bits = 8;
     +	num_pass_bits = rockchip_pcie_ep_ob_atu_num_bits(rockchip,
     +							 pci_addr, size);
      
    - 	addr0 = ((num_pass_bits - 1) & PCIE_CORE_OB_REGION_ADDR0_NUM_BITS) |
    - 		(lower_32_bits(pci_addr) & PCIE_CORE_OB_REGION_ADDR0_LO_ADDR);
    + 	cpu_addr -= rockchip->mem_res->start;
    + 	addr0 = ((is_nor_msg ? 0x10 : (num_pass_bits - 1)) &
     
      ## drivers/pci/controller/pcie-rockchip.h ##
     @@
    - 	(PCIE_EP_PF_CONFIG_REGS_BASE + (((fn) << 12) & GENMASK(19, 12)))
    - #define ROCKCHIP_PCIE_EP_VIRT_FUNC_BASE(fn) \
    - 	(PCIE_EP_PF_CONFIG_REGS_BASE + 0x10000 + (((fn) << 12) & GENMASK(19, 12)))
    + #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP	BIT(24)
    + #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR				0x1
    + #define ROCKCHIP_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
     +
     +#define ROCKCHIP_PCIE_AT_MIN_NUM_BITS  8
     +#define ROCKCHIP_PCIE_AT_MAX_NUM_BITS  20
     +
      #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
    - 	(PCIE_CORE_AXI_CONF_BASE + 0x0828 + (fn) * 0x0040 + (bar) * 0x0008)
    + 	(PCIE_RC_RP_ATS_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
      #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

