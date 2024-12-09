Return-Path: <stable+bounces-100202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFB29E9902
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59501887E42
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22C1B4222;
	Mon,  9 Dec 2024 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfGmd0u+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE21B041F
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754928; cv=none; b=LSjJxNmlrVEu7CY6wXNqa+lYpUSu2tgrRFD4nrAx6A9+QlYZ22vKFhrV5ajcGmv+322no0wd65YgUEoOSfz0V9eg6IBTk0PFGyrioo3X9sZDhVWyDqu0sZ6tnyZ3gP5HG4r2ILM1hkgCdEv3gWRBsqYaNQEnMxUGeAh1M7HGDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754928; c=relaxed/simple;
	bh=sR1fc+l47Ls3Bl0MWPyy1lXj58/Yirm7mBqb/xln79Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uobkGRc6tg1IqzCNC6A00U3CYKNZvl271pWP+eTfQNYg1Ic3TZ1Q6i0pgq4U5062CXlp/DVDZuVBoNTJ8Jwq/MtcZBGtRHb4vKLB2L1lqVHOq4yqLyYdnKuiwi9/LZg0wvRaCMa8+4vpbAhEpq3UvJo5Bb/xQaOTmiNjBBFnziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfGmd0u+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B010CC4CED1;
	Mon,  9 Dec 2024 14:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754926;
	bh=sR1fc+l47Ls3Bl0MWPyy1lXj58/Yirm7mBqb/xln79Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cfGmd0u+yc2W6kLTQdBkpsjYQQza+K9l7rJFV57xyQvEsN6uEBUWzf9bpOcgSR9CY
	 RV0UDqxQwrZqQpjwv5h7i0SHEAtv32O55GHiixjAbw/Hl2xk5H197iWYvSX2PXA0w9
	 E+5UIJMTyHfPqYD2IGwwjyGPEJ3WmhWSjljly+7crWqmBbANAfJcEpGsGCDJZRG97M
	 iEnSRJBTnQ/7gAUQemfsgpHuMQmGELLdVA5iRUJW8SpnOr2iYhDSSB3AkXLU0jBbyN
	 asiHbeOJpWDP3AIRrMT1D4LTjtw37vmy4EnvgG2EV93x3xLw72FwY6H+bbLp0QHUBd
	 LqSlqkhn4wTgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] PCI: rockchip-ep: Fix address translation unit programming
Date: Mon,  9 Dec 2024 09:35:24 -0500
Message-ID: <20241208204449-befe3843a6b31298@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209010151.631762-1-dlemoal@kernel.org>
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
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  64f093c4d99d7 ! 1:  64746368e3317 PCI: rockchip-ep: Fix address translation unit programming
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
| stable/linux-5.4.y        |  Success    |  Success   |

