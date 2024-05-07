Return-Path: <stable+bounces-43201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7CF8BEDD6
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 22:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25A11C24C64
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 20:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A8A187348;
	Tue,  7 May 2024 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFKgktAx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5B918733D;
	Tue,  7 May 2024 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112422; cv=none; b=dOn7RSEJTP2BMiJGjlsy6AhY/G4Slf3b0zW+F/C331/g/8o9g89sHUbYO1ACexsIamXgp5l8PMEYC1xjajmVAzZhkzlofgy5zgnu7NH7Vo9/ou5gadtS6cTpn/AOZv268sZq2v3qbXD0LF8YBFoMAl5umgmgAfstPVLXuijvhWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112422; c=relaxed/simple;
	bh=i7Z1HNtJG37JLhdjWG8mqhFn64dp16Fl/8geNmVF/G8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCUspA5qgWKVeP6yldnw8I+UzTWf4gvq39Y07JuAgJkmG7Ge+wa2Vx8AY4yEzMOthl5hK74KN7B1GmV7qOpca2zKsNWuk10lJcPBpaFTuxympuDnCJGhfgHMWReWJuYloSHoZnZ+cKJ4omrgGoGSo/5Ze3MyBiyzmlW7jzwaGAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFKgktAx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715112421; x=1746648421;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i7Z1HNtJG37JLhdjWG8mqhFn64dp16Fl/8geNmVF/G8=;
  b=YFKgktAxD433sIyf4orDRlzKTndD5oeAI/OzYxlBG5t7wWyA0mUFkMOi
   TrZoIC60PBipXYX+rlwiMOH2bpH/I5R+PtaX83xJuHOxNr232o477N8jk
   6TLYjG3WQhbLpnizAHQ0eLCrxtB+JDTwfX7POzOX+ZqkLsNQG0KIyKiW3
   KG5vILxm/NfS7+V+MsNWiE/iKQ7wbKZSij/1mSbfpaf88W9peHrE7tc81
   cDulIhTuAUBpFYq6KWWovUCmAvvmXTSUuWRgOIh52XGD2X9ZHdUU4Bqyc
   2ZHr8x+OgM0G4FX+MDqM5gxVUaWeh5N5ADrWMe5QysN6KJrH5fzO/bUOQ
   g==;
X-CSE-ConnectionGUID: i5P38uGTSVSwpzupz4Bo0g==
X-CSE-MsgGUID: snqFt1IyTCih5L4oAjZPqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11091603"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11091603"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:07:00 -0700
X-CSE-ConnectionGUID: NXEFWf9QRgW1mw17iqtcTQ==
X-CSE-MsgGUID: u69ADPL+R5Om6IN4WCjPig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28607425"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.132.135])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:06:58 -0700
Date: Tue, 7 May 2024 13:06:57 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, Minghuan Lian <minghuan.Lian@nxp.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>
Subject: Re: Patch "PCI: Use PCI_HEADER_TYPE_* instead of literals" has been
 added to the 6.6-stable tree
Message-ID: <20240507130657.00000df3@linux.intel.com>
In-Reply-To: <20240422223629.1576683-1-sashal@kernel.org>
References: <20240422223629.1576683-1-sashal@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Apr 2024 18:36:27 -0400
Sasha Levin <sashal@kernel.org> wrote:

> This is a note to let you know that I've just added the patch titled
>=20
>     PCI: Use PCI_HEADER_TYPE_* instead of literals
>=20
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      pci-use-pci_header_type_-instead-of-literals.patch
> and it can be found in the queue-6.6 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable
> tree, please let <stable@vger.kernel.org> know about it.
>=20
>=20
>=20
> commit 47a6faa3158d5013c24f05c59c3d3b84f273d9dd
> Author: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Date:   Tue Oct 3 15:53:00 2023 +0300
>=20
>     PCI: Use PCI_HEADER_TYPE_* instead of literals
>    =20
>     [ Upstream commit 83c088148c8e5c439eec6c7651692f797547e1a8 ]
>    =20
>     Replace literals under drivers/pci/ with PCI_HEADER_TYPE_MASK,
>     PCI_HEADER_TYPE_NORMAL, and PCI_HEADER_TYPE_MFD.
>    =20
>     Also replace !! boolean conversions with FIELD_GET().
>    =20
>     Link:
> https://lore.kernel.org/r/20231003125300.5541-4-ilpo.jarvinen@linux.intel=
.com
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com> Reviewed-by:
> Wolfram Sang <wsa+renesas@sang-engineering.com> # for Renesas R-Car
> Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c
> b/drivers/pci/controller/dwc/pci-layerscape.c index
> b931d597656f6..37956e09c65bd 100644 ---
> a/drivers/pci/controller/dwc/pci-layerscape.c +++
> b/drivers/pci/controller/dwc/pci-layerscape.c @@ -58,7 +58,7 @@
> static bool ls_pcie_is_bridge(struct ls_pcie *pcie) u32 header_type;
> =20
>  	header_type =3D ioread8(pci->dbi_base + PCI_HEADER_TYPE);
> -	header_type &=3D 0x7f;
> +	header_type &=3D PCI_HEADER_TYPE_MASK;
> =20
>  	return header_type =3D=3D PCI_HEADER_TYPE_BRIDGE;
>  }
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c index
> 45b97a4b14dbd..32951f7d6d6d6 100644 ---
> a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c +++
> b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c @@ -539,7
> +539,7 @@ static bool mobiveil_pcie_is_bridge(struct mobiveil_pcie
> *pcie) u32 header_type;=20
>  	header_type =3D mobiveil_csr_readb(pcie, PCI_HEADER_TYPE);
> -	header_type &=3D 0x7f;
> +	header_type &=3D PCI_HEADER_TYPE_MASK;
> =20
>  	return header_type =3D=3D PCI_HEADER_TYPE_BRIDGE;
>  }
> diff --git a/drivers/pci/controller/pcie-iproc.c
> b/drivers/pci/controller/pcie-iproc.c index
> bd1c98b688516..97f739a2c9f8f 100644 ---
> a/drivers/pci/controller/pcie-iproc.c +++
> b/drivers/pci/controller/pcie-iproc.c @@ -783,7 +783,7 @@ static int
> iproc_pcie_check_link(struct iproc_pcie *pcie)=20
>  	/* make sure we are not in EP mode */
>  	iproc_pci_raw_config_read32(pcie, 0, PCI_HEADER_TYPE, 1,
> &hdr_type);
> -	if ((hdr_type & 0x7f) !=3D PCI_HEADER_TYPE_BRIDGE) {
> +	if ((hdr_type & PCI_HEADER_TYPE_MASK) !=3D
> PCI_HEADER_TYPE_BRIDGE) { dev_err(dev, "in EP mode, hdr=3D%#02x\n",
> hdr_type); return -EFAULT;
>  	}
> diff --git a/drivers/pci/controller/pcie-rcar-ep.c
> b/drivers/pci/controller/pcie-rcar-ep.c index
> f9682df1da619..7034c0ff23d0d 100644 ---
> a/drivers/pci/controller/pcie-rcar-ep.c +++
> b/drivers/pci/controller/pcie-rcar-ep.c @@ -43,7 +43,7 @@ static void
> rcar_pcie_ep_hw_init(struct rcar_pcie *pcie) rcar_rmw32(pcie,
> REXPCAP(0), 0xff, PCI_CAP_ID_EXP); rcar_rmw32(pcie,
> REXPCAP(PCI_EXP_FLAGS), PCI_EXP_FLAGS_TYPE, PCI_EXP_TYPE_ENDPOINT <<
> 4);
> -	rcar_rmw32(pcie, RCONF(PCI_HEADER_TYPE), 0x7f,
> +	rcar_rmw32(pcie, RCONF(PCI_HEADER_TYPE),
> PCI_HEADER_TYPE_MASK, PCI_HEADER_TYPE_NORMAL);
> =20
>  	/* Write out the physical slot number =3D 0 */
> diff --git a/drivers/pci/controller/pcie-rcar-host.c
> b/drivers/pci/controller/pcie-rcar-host.c index
> 88975e40ee2fb..bf7cc0b6a6957 100644 ---
> a/drivers/pci/controller/pcie-rcar-host.c +++
> b/drivers/pci/controller/pcie-rcar-host.c @@ -460,7 +460,7 @@ static
> int rcar_pcie_hw_init(struct rcar_pcie *pcie) rcar_rmw32(pcie,
> REXPCAP(0), 0xff, PCI_CAP_ID_EXP); rcar_rmw32(pcie,
> REXPCAP(PCI_EXP_FLAGS), PCI_EXP_FLAGS_TYPE, PCI_EXP_TYPE_ROOT_PORT <<
> 4);
> -	rcar_rmw32(pcie, RCONF(PCI_HEADER_TYPE), 0x7f,
> +	rcar_rmw32(pcie, RCONF(PCI_HEADER_TYPE),
> PCI_HEADER_TYPE_MASK, PCI_HEADER_TYPE_BRIDGE);
> =20
>  	/* Enable data link layer active state reporting */
> diff --git a/drivers/pci/controller/vmd.c
> b/drivers/pci/controller/vmd.c index 6ac0afae0ca18..2af46e6587aff
> 100644 --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -527,7 +527,7 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
> =20
>  			hdr_type =3D readb(base + PCI_HEADER_TYPE);
> =20
> -			functions =3D (hdr_type & 0x80) ? 8 : 1;
> +			functions =3D (hdr_type & PCI_HEADER_TYPE_MFD)

Acked-by: Nirmal Patel <nirmal.patel@linux.intel.com>

> ? 8 : 1; for (fn =3D 0; fn < functions; fn++) {
>  				base =3D vmd->cfgbar +
> PCIE_ECAM_OFFSET(bus, PCI_DEVFN(dev, fn), 0);
> diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c
> b/drivers/pci/hotplug/cpqphp_ctrl.c index
> e429ecddc8feb..c01968ef0bd7b 100644 ---
> a/drivers/pci/hotplug/cpqphp_ctrl.c +++
> b/drivers/pci/hotplug/cpqphp_ctrl.c @@ -2059,7 +2059,7 @@ int
> cpqhp_process_SS(struct controller *ctrl, struct pci_func *func)
> return rc;=20
>  			/* If it's a bridge, check the VGA Enable
> bit */
> -			if ((header_type & 0x7F) =3D=3D
> PCI_HEADER_TYPE_BRIDGE) {
> +			if ((header_type & PCI_HEADER_TYPE_MASK) =3D=3D
> PCI_HEADER_TYPE_BRIDGE) { rc =3D pci_bus_read_config_byte(pci_bus,
> devfn, PCI_BRIDGE_CONTROL, &BCR); if (rc)
>  					return rc;
> @@ -2342,7 +2342,7 @@ static int configure_new_function(struct
> controller *ctrl, struct pci_func *func if (rc)
>  		return rc;
> =20
> -	if ((temp_byte & 0x7F) =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> +	if ((temp_byte & PCI_HEADER_TYPE_MASK) =3D=3D
> PCI_HEADER_TYPE_BRIDGE) { /* set Primary bus */
>  		dbg("set Primary bus =3D %d\n", func->bus);
>  		rc =3D pci_bus_write_config_byte(pci_bus, devfn,
> PCI_PRIMARY_BUS, func->bus); @@ -2739,7 +2739,7 @@ static int
> configure_new_function(struct controller *ctrl, struct pci_func *func
>  					 *   PCI_BRIDGE_CTL_SERR |
>  					 *   PCI_BRIDGE_CTL_NO_ISA */
>  		rc =3D pci_bus_write_config_word(pci_bus, devfn,
> PCI_BRIDGE_CONTROL, command);
> -	} else if ((temp_byte & 0x7F) =3D=3D PCI_HEADER_TYPE_NORMAL) {
> +	} else if ((temp_byte & PCI_HEADER_TYPE_MASK) =3D=3D
> PCI_HEADER_TYPE_NORMAL) { /* Standard device */
>  		rc =3D pci_bus_read_config_byte(pci_bus, devfn, 0x0B,
> &class_code);=20
> diff --git a/drivers/pci/hotplug/cpqphp_pci.c
> b/drivers/pci/hotplug/cpqphp_pci.c index 3b248426a9f42..e9f1fb333a718
> 100644 --- a/drivers/pci/hotplug/cpqphp_pci.c
> +++ b/drivers/pci/hotplug/cpqphp_pci.c
> @@ -363,7 +363,7 @@ int cpqhp_save_config(struct controller *ctrl,
> int busnumber, int is_hot_plug) return rc;
> =20
>  		/* If multi-function device, set max_functions to 8
> */
> -		if (header_type & 0x80)
> +		if (header_type & PCI_HEADER_TYPE_MFD)
>  			max_functions =3D 8;
>  		else
>  			max_functions =3D 1;
> @@ -372,7 +372,7 @@ int cpqhp_save_config(struct controller *ctrl,
> int busnumber, int is_hot_plug)=20
>  		do {
>  			DevError =3D 0;
> -			if ((header_type & 0x7F) =3D=3D
> PCI_HEADER_TYPE_BRIDGE) {
> +			if ((header_type & PCI_HEADER_TYPE_MASK) =3D=3D
> PCI_HEADER_TYPE_BRIDGE) { /* Recurse the subordinate bus
>  				 * get the subordinate bus number
>  				 */
> @@ -487,13 +487,13 @@ int cpqhp_save_slot_config(struct controller
> *ctrl, struct pci_func *new_slot)
> pci_bus_read_config_byte(ctrl->pci_bus, PCI_DEVFN(new_slot->device,
> 0), 0x0B, &class_code); pci_bus_read_config_byte(ctrl->pci_bus,
> PCI_DEVFN(new_slot->device, 0), PCI_HEADER_TYPE, &header_type);=20
> -	if (header_type & 0x80)	/* Multi-function device */
> +	if (header_type & PCI_HEADER_TYPE_MFD)
>  		max_functions =3D 8;
>  	else
>  		max_functions =3D 1;
> =20
>  	while (function < max_functions) {
> -		if ((header_type & 0x7F) =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> +		if ((header_type & PCI_HEADER_TYPE_MASK) =3D=3D
> PCI_HEADER_TYPE_BRIDGE) { /*  Recurse the subordinate bus */
>  			pci_bus_read_config_byte(ctrl->pci_bus,
> PCI_DEVFN(new_slot->device, function), PCI_SECONDARY_BUS,
> &secondary_bus); @@ -571,7 +571,7 @@ int
> cpqhp_save_base_addr_length(struct controller *ctrl, struct pci_func
> *func) /* Check for Bridge */ pci_bus_read_config_byte(pci_bus,
> devfn, PCI_HEADER_TYPE, &header_type);=20
> -		if ((header_type & 0x7F) =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> +		if ((header_type & PCI_HEADER_TYPE_MASK) =3D=3D
> PCI_HEADER_TYPE_BRIDGE) { pci_bus_read_config_byte(pci_bus, devfn,
> PCI_SECONDARY_BUS, &secondary_bus);=20
>  			sub_bus =3D (int) secondary_bus;
> @@ -625,7 +625,7 @@ int cpqhp_save_base_addr_length(struct controller
> *ctrl, struct pci_func *func)=20
>  			}	/* End of base register loop */
> =20
> -		} else if ((header_type & 0x7F) =3D=3D 0x00) {
> +		} else if ((header_type & PCI_HEADER_TYPE_MASK) =3D=3D
> PCI_HEADER_TYPE_NORMAL) { /* Figure out IO and memory base lengths */
>  			for (cloop =3D 0x10; cloop <=3D 0x24; cloop +=3D
> 4) { temp_register =3D 0xFFFFFFFF;
> @@ -723,7 +723,7 @@ int cpqhp_save_used_resources(struct controller
> *ctrl, struct pci_func *func) /* Check for Bridge */
>  		pci_bus_read_config_byte(pci_bus, devfn,
> PCI_HEADER_TYPE, &header_type);=20
> -		if ((header_type & 0x7F) =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> +		if ((header_type & PCI_HEADER_TYPE_MASK) =3D=3D
> PCI_HEADER_TYPE_BRIDGE) { /* Clear Bridge Control Register */
>  			command =3D 0x00;
>  			pci_bus_write_config_word(pci_bus, devfn,
> PCI_BRIDGE_CONTROL, command); @@ -858,7 +858,7 @@ int
> cpqhp_save_used_resources(struct controller *ctrl, struct pci_func
> *func) } }	/* End of base register loop */
>  		/* Standard header */
> -		} else if ((header_type & 0x7F) =3D=3D 0x00) {
> +		} else if ((header_type & PCI_HEADER_TYPE_MASK) =3D=3D
> PCI_HEADER_TYPE_NORMAL) { /* Figure out IO and memory base lengths */
>  			for (cloop =3D 0x10; cloop <=3D 0x24; cloop +=3D
> 4) { pci_bus_read_config_dword(pci_bus, devfn, cloop, &save_base);
> @@ -975,7 +975,7 @@ int cpqhp_configure_board(struct controller
> *ctrl, struct pci_func *func) pci_bus_read_config_byte(pci_bus,
> devfn, PCI_HEADER_TYPE, &header_type);=20
>  		/* If this is a bridge device, restore subordinate
> devices */
> -		if ((header_type & 0x7F) =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> +		if ((header_type & PCI_HEADER_TYPE_MASK) =3D=3D
> PCI_HEADER_TYPE_BRIDGE) { pci_bus_read_config_byte(pci_bus, devfn,
> PCI_SECONDARY_BUS, &secondary_bus);=20
>  			sub_bus =3D (int) secondary_bus;
> @@ -1067,7 +1067,7 @@ int cpqhp_valid_replace(struct controller
> *ctrl, struct pci_func *func) /* Check for Bridge */
>  		pci_bus_read_config_byte(pci_bus, devfn,
> PCI_HEADER_TYPE, &header_type);=20
> -		if ((header_type & 0x7F) =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> +		if ((header_type & PCI_HEADER_TYPE_MASK) =3D=3D
> PCI_HEADER_TYPE_BRIDGE) { /* In order to continue checking, we must
> program the
>  			 * bus registers in the bridge to respond to
> accesses
>  			 * for its subordinate bus(es)
> @@ -1090,7 +1090,7 @@ int cpqhp_valid_replace(struct controller
> *ctrl, struct pci_func *func)=20
>  		}
>  		/* Check to see if it is a standard config header */
> -		else if ((header_type & 0x7F) =3D=3D
> PCI_HEADER_TYPE_NORMAL) {
> +		else if ((header_type & PCI_HEADER_TYPE_MASK) =3D=3D
> PCI_HEADER_TYPE_NORMAL) { /* Check subsystem vendor and ID */
>  			pci_bus_read_config_dword(pci_bus, devfn,
> PCI_SUBSYSTEM_VENDOR_ID, &temp_register);=20
> diff --git a/drivers/pci/hotplug/ibmphp.h
> b/drivers/pci/hotplug/ibmphp.h index 41eafe511210f..c248a09be7b5d
> 100644 --- a/drivers/pci/hotplug/ibmphp.h
> +++ b/drivers/pci/hotplug/ibmphp.h
> @@ -17,6 +17,7 @@
>   */
> =20
>  #include <linux/pci_hotplug.h>
> +#include <linux/pci_regs.h>
> =20
>  extern int ibmphp_debug;
> =20
> @@ -286,8 +287,8 @@ int ibmphp_register_pci(void);
> =20
>  /* pci specific defines */
>  #define PCI_VENDOR_ID_NOTVALID		0xFFFF
> -#define PCI_HEADER_TYPE_MULTIDEVICE	0x80
> -#define PCI_HEADER_TYPE_MULTIBRIDGE	0x81
> +#define PCI_HEADER_TYPE_MULTIDEVICE
> (PCI_HEADER_TYPE_MFD|PCI_HEADER_TYPE_NORMAL) +#define
> PCI_HEADER_TYPE_MULTIBRIDGE
> (PCI_HEADER_TYPE_MFD|PCI_HEADER_TYPE_BRIDGE) #define LATENCY
> 	0x64 #define CACHE		64
> diff --git a/drivers/pci/hotplug/ibmphp_pci.c
> b/drivers/pci/hotplug/ibmphp_pci.c index 50038e5f9ca40..eeb412cbd9fe3
> 100644 --- a/drivers/pci/hotplug/ibmphp_pci.c
> +++ b/drivers/pci/hotplug/ibmphp_pci.c
> @@ -1087,7 +1087,7 @@ static struct res_needed
> *scan_behind_bridge(struct pci_func *func, u8 busno)
> pci_bus_read_config_dword(ibmphp_pci_bus, devfn, PCI_CLASS_REVISION,
> &class); debug("hdr_type behind the bridge is %x\n", hdr_type);
> -				if ((hdr_type & 0x7f) =3D=3D
> PCI_HEADER_TYPE_BRIDGE) {
> +				if ((hdr_type &
> PCI_HEADER_TYPE_MASK) =3D=3D PCI_HEADER_TYPE_BRIDGE) { err("embedded
> bridges not supported for hot-plugging.\n"); amount->not_correct =3D 1;
>  					return amount;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 06fc6f532d6c4..dae9d9e2826f0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -534,7 +534,7 @@ u8 pci_bus_find_capability(struct pci_bus *bus,
> unsigned int devfn, int cap)=20
>  	pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE,
> &hdr_type);=20
> -	pos =3D __pci_bus_find_cap_start(bus, devfn, hdr_type & 0x7f);
> +	pos =3D __pci_bus_find_cap_start(bus, devfn, hdr_type &
> PCI_HEADER_TYPE_MASK); if (pos)
>  		pos =3D __pci_find_next_cap(bus, devfn, pos, cap);
> =20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b3976dcb71f10..675f77ac1968d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1849,8 +1849,8 @@ static void quirk_jmicron_ata(struct pci_dev
> *pdev)=20
>  	/* Update pdev accordingly */
>  	pci_read_config_byte(pdev, PCI_HEADER_TYPE, &hdr);
> -	pdev->hdr_type =3D hdr & 0x7f;
> -	pdev->multifunction =3D !!(hdr & 0x80);
> +	pdev->hdr_type =3D hdr & PCI_HEADER_TYPE_MASK;
> +	pdev->multifunction =3D FIELD_GET(PCI_HEADER_TYPE_MFD, hdr);
> =20
>  	pci_read_config_dword(pdev, PCI_CLASS_REVISION, &class);
>  	pdev->class =3D class >> 8;
> @@ -5710,7 +5710,7 @@ static void quirk_nvidia_hda(struct pci_dev
> *gpu)=20
>  	/* The GPU becomes a multi-function device when the HDA is
> enabled */ pci_read_config_byte(gpu, PCI_HEADER_TYPE, &hdr_type);
> -	gpu->multifunction =3D !!(hdr_type & 0x80);
> +	gpu->multifunction =3D FIELD_GET(PCI_HEADER_TYPE_MFD,
> hdr_type); }
>  DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>  			       PCI_BASE_CLASS_DISPLAY, 16,
> quirk_nvidia_hda);

