Return-Path: <stable+bounces-109337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1C2A14A34
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 08:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0DF3A06D7
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 07:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79E81F55F8;
	Fri, 17 Jan 2025 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v8/8xYPK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5A9155300
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737099409; cv=none; b=AU/R8yRPu351mjd8fbdhdpYen81qF7YqOl4DgPxIYw7/FskBFhE9M+jJeac/ZgNQBUMaL9Mj9HpCtsrq8pvpAoKokV5X62n2Cej3nlYd3Xnq0dQlshqq+3Y5xtyY6MXq8f8sIik9UwNREV/aMWc7rd6xKaSTMU5bjlTV4pyYloI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737099409; c=relaxed/simple;
	bh=mBsIOxlTwNxpEx6kFORvLtqAUQxlEym0PjNs8wDUOi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbbzGmWzTbj2FU+8F047c1S6ggXlPMj592rEA4ZzZXWI7Qu2toKbmjj/AMqAblhESHd8iAbNeQD3gqx179Dq9kPRRJ8AacdwGNyvOqTmW3Cu116usfPYdqeTH1mH8sNNosEIkHUORPexXrrP+GqjJoZPCCwI1L5BCv4rfIJ5Uo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v8/8xYPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BE2C4CEDD;
	Fri, 17 Jan 2025 07:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737099408;
	bh=mBsIOxlTwNxpEx6kFORvLtqAUQxlEym0PjNs8wDUOi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v8/8xYPKzbFjDyxYSIBt9ukw0dyOB2Htg5Q2+VQ5h60NkICbr5TU7Zn6lvAsQxIvH
	 hrb1W+OEvS4Fk0YlD/HcgT2NjXfKPfbWGzhJm6WtF4anUVOosauqV/g8dzxyEG3pVw
	 xLK4ihgLp5Xqr0wenTxbXjT/83GiCMjQzjKPQDwA=
Date: Fri, 17 Jan 2025 08:35:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bo Sun <Bo.Sun.CN@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] PCI: controller: Restore PCI_REASSIGN_ALL_BUS when
 PCI_PROBE_ONLY is enabled
Message-ID: <2025011745-smite-banister-392b@gregkh>
References: <20250117072933.28157-1-Bo.Sun.CN@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117072933.28157-1-Bo.Sun.CN@windriver.com>

On Fri, Jan 17, 2025 at 03:29:31PM +0800, Bo Sun wrote:
> On our Marvell OCTEON CN96XX board, we observed the following panic on
> the latest kernel:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
> Mem abort info:
>   ESR = 0x0000000096000005
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x05: level 1 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [0000000000000080] user address but active_mm is swapper
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 9 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc7-00149-g9bffa1ad25b8 #1
> Hardware name: Marvell OcteonTX CN96XX board (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : of_pci_add_properties+0x278/0x4c8
> lr : of_pci_add_properties+0x258/0x4c8
> sp : ffff8000822ef9b0
> x29: ffff8000822ef9b0 x28: ffff000106dd8000 x27: ffff800081bc3b30
> x26: ffff800081540118 x25: ffff8000813d2be0 x24: 0000000000000000
> x23: ffff00010528a800 x22: ffff000107c50000 x21: ffff0001039c2630
> x20: ffff0001039c2630 x19: 0000000000000000 x18: ffffffffffffffff
> x17: 00000000a49c1b85 x16: 0000000084c07b58 x15: ffff000103a10f98
> x14: ffffffffffffffff x13: ffff000103a10f96 x12: 0000000000000003
> x11: 0101010101010101 x10: 000000000000002c x9 : ffff800080ca7acc
> x8 : ffff0001038fd900 x7 : 0000000000000000 x6 : 0000000000696370
> x5 : 0000000000000000 x4 : 0000000000000002 x3 : ffff8000822efa40
> x2 : ffff800081341000 x1 : ffff000107c50000 x0 : 0000000000000000
> Call trace:
>  of_pci_add_properties+0x278/0x4c8 (P)
>  of_pci_make_dev_node+0xe0/0x158
>  pci_bus_add_device+0x158/0x210
>  pci_bus_add_devices+0x40/0x98
>  pci_host_probe+0x94/0x118
>  pci_host_common_probe+0x120/0x1a0
>  platform_probe+0x70/0xf0
>  really_probe+0xb4/0x2a8
>  __driver_probe_device+0x80/0x140
>  driver_probe_device+0x48/0x170
>  __driver_attach+0x9c/0x1b0
>  bus_for_each_dev+0x7c/0xe8
>  driver_attach+0x2c/0x40
>  bus_add_driver+0xec/0x218
>  driver_register+0x68/0x138
>  __platform_driver_register+0x2c/0x40
>  gen_pci_driver_init+0x24/0x38
>  do_one_initcall+0x4c/0x278
>  kernel_init_freeable+0x1f4/0x3d0
>  kernel_init+0x28/0x1f0
>  ret_from_fork+0x10/0x20
> Code: aa1603e1 f0005522 d2800044 91000042 (f94040a0)
> 
> This regression was introduced by commit 7246a4520b4b ("PCI: Use
> preserve_config in place of pci_flags"). On our board, the 002:00:07.0
> bridge is misconfigured by the bootloader. Both its secondary and
> subordinate bus numbers are initialized to 0, while its fixed secondary
> bus number is set to 8. However, bus number 8 is also assigned to another
> bridge (0002:00:0f.0). Although this is a bootloader issue, before the
> change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was
> set by default when PCI_PROBE_ONLY was enabled, ensuing that all the
> bus number for these bridges were reassigned, avoiding any conflicts.
> 
> After the change introduced in commit 7246a4520b4b, the bus numbers
> assigned by the bootloader are reused by all other bridges, except
> the misconfigured 002:00:07.0 bridge. The kernel attempt to reconfigure
> 002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
> bootloader. However, since a pci_bus has already been allocated for
> bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
> 002:00:07.0. This results in a pci bridge device without a pci_bus
> attached (pdev->subordinate == NULL). Consequently, accessing
> pdev->subordinate in of_pci_prop_bus_range() leads to a NULL pointer
> dereference.
> 
> To summarize, we need to restore the PCI_REASSIGN_ALL_BUS flag when
> PCI_PROBE_ONLY is enabled in order to work around issue like the one
> described above.
> 
> Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
> Signed-off-by: Bo Sun <Bo.Sun.CN@windriver.com>
> ---
>  drivers/pci/controller/pci-host-common.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index cf5f59a745b3..615923acbc3e 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -73,6 +73,10 @@ int pci_host_common_probe(struct platform_device *pdev)
>  	if (IS_ERR(cfg))
>  		return PTR_ERR(cfg);
>  
> +	/* Do not reassign resources if probe only */
> +	if (!pci_has_flag(PCI_PROBE_ONLY))
> +		pci_add_flags(PCI_REASSIGN_ALL_BUS);
> +
>  	bridge->sysdata = cfg;
>  	bridge->ops = (struct pci_ops *)&ops->pci_ops;
>  	bridge->msi_domain = true;
> -- 
> 2.48.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

