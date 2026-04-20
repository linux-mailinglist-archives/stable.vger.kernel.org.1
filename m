Return-Path: <stable+bounces-238745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id m8BGMD4d5mkMsAEAu9opvQ
	(envelope-from <stable+bounces-238745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:34:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A92242AC8E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06A2D30193A0
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A7829A9E9;
	Mon, 20 Apr 2026 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E1Zt5R4+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1132249EB
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688346; cv=none; b=gGgiANReSyxxaRX7jl7lmb5YUYivs7BdZrkxBqTmEKZfHXnYBcnFAdkQrrm4KP4Vj3MznJU2o4LY017hTwsGRRNAwnzvPMXawSJTa18YVO0Z/vGaRaqddunU4NhAJrlioDq7JCLpQKXgEeCLq4xx6WtPdGb04F3bP4lXBH6XVGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688346; c=relaxed/simple;
	bh=+Fhp0VI74K3Mxurz05Ke1B9YygUkzUW34nRxkdTyiFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCs/clDqMMER21TEyKB0O9y/5nGXoNrFLEamuOk1dmbDZfJd6LjDud2jU5GSO4xTiqsnenfgDJnQRKf62NLv3z8X+FzHE3FLP0IkhBP3bu3PH1DwfuxN5NDkUOHaI62O2b5hQ9xrNX5tpADYeFbywfGrdVGrmeqmMxXaZPX71jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E1Zt5R4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D2FC19425;
	Mon, 20 Apr 2026 12:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776688346;
	bh=+Fhp0VI74K3Mxurz05Ke1B9YygUkzUW34nRxkdTyiFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1Zt5R4+E4hO4BVluVw6Q63FcZbRNfgap2IG9Q4FNhZ4++eyirjAEJd21VSzjnpIp
	 CL0rgROvvkIkLZBCxbtdMApioTS8AVkJLnbv6GxnqkFgTg+hjmhx7sp74C9knWwX/H
	 hSqpULHBAq1Q22MviHpph9jK/nYdCGK/xOL947tc=
Date: Mon, 20 Apr 2026 14:32:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 5.15.y] PCI/ACPI: Restrict program_hpx_type2() to AER bits
Message-ID: <2026042054-sandy-trolling-0cb3@gregkh>
References: <20260311171736.343422-1-haakon.bugge@oracle.com>
 <7226713B-8871-40FA-BAA1-6AC5E516AF46@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7226713B-8871-40FA-BAA1-6AC5E516AF46@oracle.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238745-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,oracle.com:email]
X-Rspamd-Queue-Id: 5A92242AC8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 12:20:05PM +0000, Haakon Bugge wrote:
> > commit 9abf79c8d7b40db0e5a34aa8c744ea60ff9a3fcf upstream.
> > 
> > Previously program_hpx_type2() applied PCIe settings unconditionally,
> > which could incorrectly change bits like Extended Tag Field Enable and
> > Enable Relaxed Ordering.
> > 
> > When _HPX was added to ACPI r3.0, the intent of the PCIe Setting
> > Record (Type 2) in sec 6.2.7.3 was to configure AER registers when the
> > OS does not own the AER Capability:
> > 
> >  The PCI Express setting record contains ... [the AER] Uncorrectable
> >  Error Mask, Uncorrectable Error Severity, Correctable Error Mask
> >  ... to be used when configuring registers in the Advanced Error
> >  Reporting Extended Capability Structure ...
> > 
> >  OSPM [1] will only evaluate _HPX with Setting Record – Type 2 if
> >  OSPM is not controlling the PCI Express Advanced Error Reporting
> >  capability.
> > 
> > ACPI r3.0b, sec 6.2.7.3, added more AER registers, including registers
> > in the PCIe Capability with AER-related bits, and the restriction that
> > the OS use this only when it owns PCIe native hotplug:
> > 
> >  ... when configuring PCI Express registers in the Advanced Error
> >  Reporting Extended Capability Structure *or PCI Express Capability
> >  Structure* ...
> > 
> >  An OS that has assumed ownership of native hot plug but does not
> >  ... have ownership of the AER register set must use ... the Type 2
> >  record to program the AER registers ...
> > 
> >  However, since the Type 2 record also includes register bits that
> >  have functions other than AER, the OS must ignore values ... that
> >  are not applicable.
> > 
> > Restrict program_hpx_type2() to only the intended purpose:
> > 
> >  - Apply settings only when OS owns PCIe native hotplug but not AER,
> > 
> >  - Only touch the AER-related bits (Error Reporting Enables) in Device
> >    Control
> > 
> >  - Don't touch Link Control at all, since nothing there seems AER-related,
> >    but log _HPX settings for debugging purposes
> > 
> > Note that Read Completion Boundary is now configured elsewhere, since it is
> > unrelated to _HPX.
> > 
> > [1] Operating System-directed configuration and Power Management
> > 
> > Fixes: 40abb96c51bb ("[PATCH] pciehp: Fix programming hotplug parameters")
> > Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Link: https://patch.msgid.link/20260129175237.727059-3-haakon.bugge@oracle.com
> > [ Conflict in drivers/pci.h because the context has changed. ]
> > Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> 
> I see this was not added to 5.15.203, hence a gentle ping on it.

The backlog for manually backported 5.15.y patches right now is over 100
patches long.  You are in good company :)

thanks,

greg k-h

