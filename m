Return-Path: <stable+bounces-214748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPj/LbCYhmmnPAQAu9opvQ
	(envelope-from <stable+bounces-214748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 02:43:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2991048BE
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 02:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09440301D31B
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 01:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965CC315D37;
	Sat,  7 Feb 2026 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="jAMr3by3"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F517D2
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770428583; cv=none; b=cSDeWYNopJLIGHIpSzP/DqYg/rN/QSf08SImUcjIVTa5n9KQ3h2Q8TaxY+emY7/AZRXxrYuTiXJJX7YP46ZBXGH3BhCrt5okDVHM1CtTFGqXBpFx4Tlh+8MnOGG3trK58Y5r5UtxBWqxhkPbE8nq8cMUuEofim0m66uh2HLkr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770428583; c=relaxed/simple;
	bh=nM4TD51nEBf9Es1Jv5dwYF+TQVv1NWVTHW6DIlxuT+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyE6+p5kOX7DKz77oNlhrsYy+wywad8iFH31q0dX5XvCO1n8bZjQYtwzBL61n4EulcV/6kPSksmFF5FicH5IA4UUa6p14jmbsffcEduCI+U5m5wkKhEmue9E7JzQJ74FuMgS0RxRyJyk51l1ghcG0ZVtNlp4xUABDfKC2fIAaNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=jAMr3by3; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Date: Fri, 6 Feb 2026 17:42:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=key1; t=1770428580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ou9hbR74SGxtKKIfWKPL/WEcI3zRLMFpkLgLFcBQ8WM=;
	b=jAMr3by3JeHTHRSWKFUyWYAaxfafIDQFWmxMOKFPSWTcw7pSnEXrrZvMO7NE3KITl8WCIp
	DMvSySHVxlMQeGlNRLw71YfuvE/oUIBkYj/Q97g6ZfGpPXqguxcm6ZoQYRR6VlTHNnBjWa
	8dGi53yw1epYaFB0NtRJ76XBOekuHlbq7mci4FvX6QCtCMWcaCF1v9JY/mzpSsrTXJagcR
	8MXHuCk8dZ3uaoly2YvokbfIt3WAeWsXYzsD9GW9tPNqSbkqXpQ2TneZEuQ2y5+XFzC6+4
	JFXewfkRTy2Oonrjr7ISuX7bjr+CuluHXjsXRdK0pttFYdmzfj2R33y0DPOeAA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Krister Johansen <kjlx@templeofstupid.com>
To: Matthew Ruffell <matthew.ruffell@canonical.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: "DECUI@microsoft.com" <DECUI@microsoft.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"jakeo@microsoft.com" <jakeo@microsoft.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Message-ID: <aYaYnMYik3SC45bb@templeofstupid.com>
References: <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260123053909.95584-1-matthew.ruffell@canonical.com>
 <SN6PR02MB41573CD2EA6CD82A0C238F66D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41573CD2EA6CD82A0C238F66D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[templeofstupid.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[templeofstupid.com:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214748-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[canonical.com,outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[templeofstupid.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kjlx@templeofstupid.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[templeofstupid.com:email,templeofstupid.com:dkim,templeofstupid.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B2991048BE
X-Rspamd-Action: no action

Hi Matthew and Michael,

On Fri, Jan 23, 2026 at 06:39:24AM +0000, Michael Kelley wrote:
> From: Matthew Ruffell <matthew.ruffell@canonical.com> Sent: Thursday, January 22, 2026 9:39 PM
> > > > There's a parameter to the kexec() command that governs whether it uses the
> > > > kexec_file_load() system call or the kexec_load() system call.
> > > > I wonder if that parameter makes a difference in the problem described for this
> > > > patch.
> > 
> > Yes, it does indeed make a difference. I have been debugging this the past few
> > days, and my colleague Melissa noticed that the problem reproduces when secure
> > boot is disabled, but it does not reproduce when secure boot is enabled.
> > Additionally, it reproduces on jammy, but not noble. It turns out that
> > kexec-tools on jammy defaults to kexec_load() when secure boot is disabled,
> > and when enabled, it instead uses kexec_file_load(). On noble, it defaults to
> > first trying kexec_file_load() before falling back to kexec_load(), so the
> > issue does not reproduce.
> 
> This is good info, and definitely a clue. So to be clear, the problem repros
> only when kexec_load() is used. With kexec_file_load(), it does not repro. Is that
> right? I saw a similar distinction when working on commit 304386373007,
> though in the opposite direction!

Just to muddy the waters here, I have a team on the Noble 6.8 kernel
train that's running into this issue on Standard_D#pds_v6 with secure
boot disabled. I've validated via strace(8) that kexec(8) is calling
kexec_file_load(2), but in this case the problem Dexuan describes in the
cover letter occurs but affects NIC attachment instead of the NVMe
storage device. (e.g. pci_hyperv attach of the NIC reports the
pass-through error instead of successfully attaching).


> > > > >  	/*
> > > > >  	 * Set up a region of MMIO space to use for accessing configuration
> > > > > -	 * space.
> > > > > +	 * space. Use the high MMIO range to not conflict with the hyperv_drm
> > > > > +	 * driver (which normally gets MMIO from the low MMIO range) in the
> > > > > +	 * kdump kernel of a Gen2 VM, which fails to reserve the framebuffer
> > > > > +	 * MMIO range in vmbus_reserve_fb() due to screen_info.lfb_base being
> > > > > +	 * zero in the kdump kernel.
> > > > >  	 */
> > > > > -	ret = vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, 0, -1,
> > > > > +	ret = vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, SZ_4G, -1,
> > > > >  				  PCI_CONFIG_MMIO_LENGTH, 0x1000, false);
> > > > >  	if (ret)
> > > > >  		return ret;
> > > > > --
> > 
> > Thank you for the patch Dexuan.
> > 
> > This patch fixes the problem on Ubuntu 5.15, and 6.8 based kernels
> > booting V6 instance types on Azure with Gen 2 images.
> 
> Are you seeing the problem on x86/64 or arm64 instances in Azure?
> "V6 instance types" could be either, I think, but I'm guessing you
> are on x86/64.
> 
> And just to confirm: are you seeing the problem with the
> Hyper-V DRM driver, or the Hyper-V FB driver? This patch mentions
> the DRM driver, so I assume that's the problematic config.

It's been arm64 and not x86 for the case I've seen.  They're currently
running with the hyperv_drm driver, but they've also tried swapping to
the fb driver without any change in results.

> > Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>

All of the above said, I also tested Dexuan's fix on these instances and
found that with the patch applied kdump did work again.

Tested-by: Krister Johansen <johansen@templeofstupid.com>

-K

