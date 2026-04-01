Return-Path: <stable+bounces-232684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHlZFAGbzGnHUQYAu9opvQ
	(envelope-from <stable+bounces-232684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 06:11:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D70374942
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 06:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 415B83029B62
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 04:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC29134751D;
	Wed,  1 Apr 2026 04:11:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16511DF73C;
	Wed,  1 Apr 2026 04:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775016702; cv=none; b=YURBzCAdsO14TS9JxEUbTMOGJ+2antjno9dFx7Nmv7m7Efv8hNs0bBcDJUHbJmjqVTuMX+EG1XZ7Fg7exXuZwgFxEjmkO/22jrTR+KmVO7JfpyP/5AlyhUxCX8R9CSndy2g/P3mhp6NY7JHK0p2GVs5iiTkfzY68w9TqOn2w2nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775016702; c=relaxed/simple;
	bh=sAWy1Ivi16Z/gQza1WVmjo4POjr+K6avx4D7/qC3ChA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtdCbnzDKO/wuErf0UDxZsAyzgCqVuuApXTYHJOH66iapPunE+vScu/F/2AurwAHuZeM2IeEb4tZQQjrAZgfoKANFMT82MTI8Sz5FV5LCs9AaaBkTwiLr20ockI+k9VLWG9HWM882t8Ipkx3UYvsbH425lrfz+B6o6l54Dqyc24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 28A5A10610;
	Wed, 01 Apr 2026 06:11:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 16C5D6006954; Wed,  1 Apr 2026 06:11:37 +0200 (CEST)
Date: Wed, 1 Apr 2026 06:11:37 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alex Williamson <alex@shazbot.org>
Cc: Bernd Schumacher <bernd@bschu.de>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	1131025@bugs.debian.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [6.12.y regression] Regression with 58130e7ce6cb ("PCI/ERR:
 Ensure error recoverability at all times"): echo vfio-pci >driver_override
 does not work for DVB Adapter
Message-ID: <acya-Q8_pMRRLI6j@wunner.de>
References: <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
 <acfZrlP0Ua_5D3U4@eldamar.lan>
 <acfhf-odtr0yw_py@wunner.de>
 <74bcd84500e5efcca035624f325e400dd8a21f44.camel@bschu.de>
 <acgohjvBpVcR7HcK@wunner.de>
 <5f9386146f426e2847550681cb7188471205607f.camel@bschu.de>
 <aclRwznwq6KpA2qA@wunner.de>
 <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
 <acvHjo8PKdyHshSE@wunner.de>
 <20260331170149.3ee222aa@shazbot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331170149.3ee222aa@shazbot.org>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232684-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.839];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9D70374942
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 05:01:49PM -0600, Alex Williamson wrote:
> On Tue, 31 Mar 2026 15:09:34 +0200 Lukas Wunner <lukas@wunner.de> wrote:
> > On Mon, Mar 30, 2026 at 08:14:53AM +0200, Bernd Schumacher wrote:
> > > [    0.318903] pci 0000:07:00.0: [dd01:0003] type 00 class 0x048000 PCIe Endpoint
> > > [    0.318939] pci 0000:07:00.0: BAR 0 [mem 0xfffffffffc500000-0xfffffffffc50ffff 64bit]  
> > 
> > BIOS initially sets the BAR address to an incorrect value (the top 32 bits
> > should be all zeroes instead of all ones)...
> > 
> > > [    0.339685] pci 0000:07:00.0: BAR 0 [mem 0xfffffffffc500000-0xfffffffffc50ffff 64bit]: can't claim; no compatible bridge window  
> > [...]
> > > [    0.311065] pci 0000:02:03.0: [1022:57a3] type 01 class 0x060400 PCIe Switch Downstream Port
> > > [    0.311107] pci 0000:02:03.0: PCI bridge to [bus 07]
> > > [    0.311118] pci 0000:02:03.0:   bridge window [mem 0xfc500000-0xfc5fffff]  
> > 
> > ... this doesn't fit into the window of the bridge above the DVB card,
> > which has the top 32 bits set to all zeroes...
> > 
> > > [    0.357346] pci 0000:07:00.0: BAR 0 [mem 0xfc500000-0xfc50ffff 64bit]: assigned  
> > 
> > ... the kernel fixes the incorrect BAR, but it seems there's an ordering
> > issue such that pci_save_state() is called beforehand.  It's weird that
> > this doen't occur with newer kernels and it would be good to understand why.
> > I'm not seeing the ordering issue despite staring at the code for a while.
> 
> Do we know this isn't occurring on newer kernels?

Yes, the reporter tested 6.19.8 and the issue does not occur there:
https://bugs.debian.org/1131025

> AIUI, we're saving the state via the call chain invoked by
> subsys_initcall(pcibios_init), but I think we're doing the resource
> fixes in fs_initcall(pcibios_assign_resources).  That suggests that
> the saved state would have the bogus BAR values.

Hm, seems like a valid observation.

But a call to pci_bus_add_devices() is generally preceded by a call to
pci_assign_unassigned_root_bus_resources(), see e.g. pci_host_probe()
or acpi_pci_root_add().  The latter is what's usually used on x86,
whereas pcibios_init() (actually I think you meant pci_subsys_init())
is for legacy PCI initialization on x86.

Perhaps you're right and the correction of the BAR value happens in
the fs_initcall.  We should be able to confirm that once the reporter
has tested the debug patch I provided, which inserts a dump_stack()
in the BAR correction codepath as well as in pci_save_state().

> If we toss PM runtime into that mix, pci_pm_default_resume_early() will
> call pci_restore_state() however pci_save_state() in that file is
> mostly wrapped around pci_dev->state_saved guards.

The state_saved guards only serve the purpose of recognizing whether
the driver called pci_save_state() on suspend.  If it did not,
the PCI core calls pci_save_state().

Thanks for taking a look!

Lukas

