Return-Path: <stable+bounces-244466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DWQDgrL+2lsEwAAu9opvQ
	(envelope-from <stable+bounces-244466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 01:13:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AC24E177C
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 01:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA97F3014655
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 23:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E533CC9E9;
	Wed,  6 May 2026 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="sZhtatkG"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE13B8945
	for <stable@vger.kernel.org>; Wed,  6 May 2026 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778109175; cv=none; b=VPqBoC/eV8OMpoLrKrOo4mYUdDz95WMNO6uwh5+xo6IAT49OSMU2lVXrz+xH6D1lfS4u2QXyVjtI4x5fhq0n4G5RY+BFKIJw8wNZ4jKaF8kgb6esElEY43HY6uH9vN26ddZjibm4kco7d5EeyA3TQl59MXAe65Ci4j5kLm73jwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778109175; c=relaxed/simple;
	bh=oMuo8Rnq8w2p7inyiM35ATP0XNTOcpCTuRYP0cYEHys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPHM9kWflMIbVEHtsFYb5u4zJ58OyBVzm9peS4joJVucegrwB9bErkx8G3dkumPPbPI33DHhBRw1vnkr39b3KaXXe1gvIO7XhqbGbeMLY83fq1qztZG29wa4fSO10K0OWpayy7FCuvKTJKSQsZQg8NND8yR8m/bdP5Q466xhvp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=sZhtatkG; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Date: Wed, 6 May 2026 16:12:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=key1; t=1778109170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VPryY3JxDMD7g2hwNJDxssCyQbAmb4ZMfyj6+Mo6obc=;
	b=sZhtatkGKux6yQx+e+CdwqzLr/SYMIoc9AATl959oi3FECjVeQjj8qsW2ldsAFSAxaeJkN
	Vvm1n1OlWXVaAoV2SUCcXt/T8UV48bWY8Hx9hOyOkkLpVQcVa/CDhYDtZ204hqc+rrOiTT
	341VbkUsYCX5tet7UqONJgYxtDypBW/PxGcfx4KKPPF+W4LQ4wYBoadV9k943VUyCE9hXz
	k0qNMEH1FnsZWtQcvD45hYcoP4dR9pPAr35JOrEICNJ4vFOWFc+6iFpU3lLmB2aFBg1+ON
	6FaMxiyycqQI60FiATunmS3XTSeqMeo1SmPILoEEpC18MTaNR+m1b3taASpW9A==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Krister Johansen <kjlx@templeofstupid.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	longli@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhklinux@outlook.com,
	matthew.ruffell@canonical.com, hargar@linux.microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Drivers: hv: vmbus: Improve the logic of reserving
 fb_mmio on Gen2 VMs
Message-ID: <afvK6A0W21PVJpUE@templeofstupid.com>
References: <20260505004846.193441-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505004846.193441-1-decui@microsoft.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 91AC24E177C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[templeofstupid.com,none];
	R_DKIM_ALLOW(-0.20)[templeofstupid.com:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,vger.kernel.org,outlook.com,canonical.com,linux.microsoft.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[templeofstupid.com:+];
	TAGGED_FROM(0.00)[bounces-244466-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kjlx@templeofstupid.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 05:48:46PM -0700, Dexuan Cui wrote:
> If vmbus_reserve_fb() in the kdump/kexec kernel fails to properly reserve
> the framebuffer MMIO range (which is below 4GB) due to a Gen2 VM's
> screen.lfb_base being zero [1], there is an MMIO conflict between the
> drivers hyperv-drm and pci-hyperv: when the driver pci-hyperv's
> hv_pci_allocate_bridge_windows() calls vmbus_allocate_mmio() to get a
> 32-bit MMIO range, it may get an MMIO range that overlaps with the
> framebuffer MMIO range, and later hv_pci_enter_d0() fails with an
> error message "PCI Pass-through VSP failed D0 Entry with status" since
> the host thinks that PCI devices must not use MMIO space that the
> host has assigned to the framebuffer.
> 
> This is especially an issue if pci-hyperv is built-in and hyperv-drm is
> built as a module. Consequently, the kdump/kexec kernel fails to detect
> PCI devices via pci-hyperv, and may fail to mount the root file system,
> which may reside in a NVMe disk. The issue described here has existed
> for SR-IOV VF NICs since day one of the pci-hyperv driver, and has been
> worked around on x64 when possible. With the recent introduction of
> ARM64 VMs that boot from NVMe, there is no workaround, so we need a
> formal fix.
> 
> On Gen2 VMs, if the screen.lfb_base is 0 in the kdump/kexec kernel [1],
> fall back to the low MMIO base, which should be equal to the framebuffer
> MMIO base [2] (the statement is true according to my testing on x64
> Windows Server 2016, and on x64 and ARM64 Windows Server 2025 and on
> Azure. I checked with the Hyper-V team and they said the statement should
> continue to be true for Gen2 VMs). In the first kernel, screen.lfb_base
> is not 0; if the user specifies a very high resolution, it's not enough
> to only reserve 8MB: in this case, reserve half of the space below 4GB,
> but cap the reservation to 128MB, which is the required framebuffer size
> of the highest resolution 7680*4320 supported by Hyper-V.
> 
> While at it, fix the comparison "end > VTPM_BASE_ADDRESS" by changing
> the > to >=. Here the 'end' is an inclusive end (typically, it's
> 0xFFFF_FFFF for the low MMIO range).
> 
> Note: vmbus_reserve_fb() now also reserves an MMIO range at the beginning
> of the low MMIO range on CVMs, which have no framebuffers (the
> 'screen.lfb_base' in vmbus_reserve_fb() is 0 for CVMs), just in case the
> host might treat the beginning of the low MMIO range specially [4]. BTW,
> the OpenHCL kernel is not affected by the change, because that kernel
> boots with DeviceTree rather than ACPI (so vmbus_reserve_fb() won't run
> there), and there is no framebuffer device for that kernel.
> 
> Note: normally Gen1 VMs don't have the MMIO conflict issue because the
> framebuffer MMIO range (which is hardcoded to base=4GB-128MB and
> size=64MB for Gen1 VMs by the host) is always reported via the legacy PCI
> graphics device's BAR, so the kdump/kexec kernel can reserve the 64MB
> MMIO range; however, if the VM is configured to use a very high resolution
> and the required framebuffer size exceeds 64MB (AFAIK, in practice, this
> isn't a typical configuration by users), the hyperv-drm driver may need to
> allocate an MMIO range above 4GB and change the framebuffer MMIO location
> to the allocated MMIO range -- in this case, there can still be issues [3]
> which can't be easily fixed: any possible affected Gen1 users would have
> to use a resolution whose framebuffer size is <= 64MB, or switch to Gen2
> VMs.
> 
> [1] https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com/
> [2] https://lore.kernel.org/all/SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com/
> [3] https://lore.kernel.org/all/SA1PR21MB69213486F821CA5A2C793C81BF342@SA1PR21MB6921.namprd21.prod.outlook.com/
> [4] https://lore.kernel.org/all/SN6PR02MB415726B17D5A6027CD1717E8D4342@SN6PR02MB4157.namprd02.prod.outlook.com/
> 
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> CC: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
 
Thanks for the updated patch.  I re-tested this on a D2pdsv6 and was
able to confirm that without the patch the NIC drivers in the dump
environment didn't attach because of a PCI conflict. With the patch the
drivers attached and it was possible to successfully collect a kdump.

Tested-by: Krister Johansen <kjlx@templeofstupid.com>

-K

