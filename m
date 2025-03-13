Return-Path: <stable+bounces-124242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72320A5EF27
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC61F7AE948
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3950C265CC8;
	Thu, 13 Mar 2025 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7iR8v1L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB43265CC1
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856917; cv=none; b=BB1S1uE8DFkdvGC4cM4mBnKL7puJJlbDCay4ZU/cnW8iR38GikN4XmAsMKRmJQ26NahSS1q+kyqilhRjAQCS6rqnLQfwYbP8Tl0hDeJHo3WwAUDsOcJf0HK5G2VpZqmfF8ul+lzY4Oh4kQptYbNke7tBWY+pka1ug1vOnTMSPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856917; c=relaxed/simple;
	bh=uQx5AB3+d5Ba0CA6Kamc6yvLcbCLKrjynpyvABPwAag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUektNmfAG5Ii21wpdz/B/lAmn5Ik4KoaFvV/9oJ7ZjL99c2BFNCVezW6PwZtB0Wr4XZxkvk6s1HMo8XiBAhkGpMCHrg8KRTDcw3UwBL+CWXID+9XbmZyXGlI9UvOcHxrPC8owYVeEyogJikCSw8F58aI7kH81PkDWQbFhGy0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7iR8v1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCB4C4CEF0;
	Thu, 13 Mar 2025 09:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856917;
	bh=uQx5AB3+d5Ba0CA6Kamc6yvLcbCLKrjynpyvABPwAag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7iR8v1LkjW/hFXwLClWvsHGFJWAEj3RscAFrr+tjOWiY3tnjA5t6gZw7pO14ZWbe
	 dpzV8EBbq+6J6GBgqPt7k+CGs/mJiNQ98TW7WOr23XniJBSohYBGziPlsmJyYItkBO
	 CD/vOz/1BB3VczemRZHkh+IujebLwJRODr9rNtbtpqRUa6YtO4nFQYFOZRmEqSUTRF
	 BuugMoR8wAAaNnhYAoeVOWTSEYOaYK7a8boQjdTlG1RBohzLyl/h1ZtzdRerSZ5hZ4
	 g4jTQ7vKH55HcH3GZHM3Zj5OqIWJoFWjEnEwN5bJ71OJ45OhrJDC73ieA6sEzZ89Dx
	 7+7QCGKTFvpSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	michal.pecio@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] usb: xhci: Enable the TRB overfetch quirk on VIA VL805
Date: Thu, 13 Mar 2025 05:08:35 -0400
Message-Id: <20250312201303-813ab2bbeb6c9a99@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250310000221.1a7d4993@foxbook>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: c133ec0e5717868c9967fa3df92a55e537b1aead

Status in newer kernel trees:
6.13.y | Present (different SHA1: b273b3dc3b5c)
6.12.y | Present (different SHA1: 43115ac4e752)
6.6.y | Present (different SHA1: 2a3d68873fc2)
6.1.y | Present (different SHA1: bd139706d043)
5.15.y | Present (different SHA1: e256a546d03d)

Note: The patch differs from the upstream commit:
---
1:  c133ec0e57178 ! 1:  3d064d3287ee6 usb: xhci: Enable the TRB overfetch quirk on VIA VL805
    @@ Commit message
         Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
         Link: https://lore.kernel.org/r/20250225095927.2512358-2-mathias.nyman@linux.intel.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    (cherry picked from commit c133ec0e5717868c9967fa3df92a55e537b1aead)
    +    [ Michal: merge conflict with white space and an unrelated quirk ]
    +    Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
     
      ## drivers/usb/host/xhci-mem.c ##
     @@ drivers/usb/host/xhci-mem.c: int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
    @@ drivers/usb/host/xhci-mem.c: int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flag
     
      ## drivers/usb/host/xhci-pci.c ##
     @@
    - #define PCI_DEVICE_ID_ETRON_EJ168		0x7023
    - #define PCI_DEVICE_ID_ETRON_EJ188		0x7052
    + #define PCI_DEVICE_ID_EJ168		0x7023
    + #define PCI_DEVICE_ID_EJ188		0x7052
      
     +#define PCI_DEVICE_ID_VIA_VL805			0x3483
     +
    - #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI		0x8c31
    - #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI		0x9c31
    + #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
    + #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
      #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_XHCI	0x9cb1
     @@ drivers/usb/host/xhci-pci.c: static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
      			pdev->device == 0x3432)
      		xhci->quirks |= XHCI_BROKEN_STREAMS;
      
    --	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483)
    +-	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483) {
     +	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == PCI_DEVICE_ID_VIA_VL805) {
      		xhci->quirks |= XHCI_LPM_SUPPORT;
     +		xhci->quirks |= XHCI_TRB_OVERFETCH;
    -+	}
    + 		xhci->quirks |= XHCI_EP_CTX_BROKEN_DCS;
    + 	}
      
    - 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
    - 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
     @@ drivers/usb/host/xhci-pci.c: static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
      
      		if (pdev->device == 0x9202) {
    @@ drivers/usb/host/xhci-pci.c: static void xhci_pci_quirks(struct device *dev, str
     +			xhci->quirks |= XHCI_TRB_OVERFETCH;
      	}
      
    - 	if (pdev->vendor == PCI_VENDOR_ID_CDNS &&
    + 	/* xHC spec requires PCI devices to support D3hot and D3cold */
     
      ## drivers/usb/host/xhci.h ##
     @@ drivers/usb/host/xhci.h: struct xhci_hcd {
    @@ drivers/usb/host/xhci.h: struct xhci_hcd {
     -#define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
     +#define XHCI_TRB_OVERFETCH	BIT_ULL(45)
      #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
    - #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
    - #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
    + 
    + 	unsigned int		num_active_eps;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

