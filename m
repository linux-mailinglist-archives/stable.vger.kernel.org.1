Return-Path: <stable+bounces-217335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFn9J0ZXlmkzeAIAu9opvQ
	(envelope-from <stable+bounces-217335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 01:20:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4496D15B1B8
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 01:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0602A303FF2D
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2CF1DF25F;
	Thu, 19 Feb 2026 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dblDJYyh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C87E4C6C;
	Thu, 19 Feb 2026 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771460413; cv=none; b=WxfoiRxK3k+wkAsOrhL9uBZRmcMT1eBla0hvSjg5aHiREUdhdx4RZzNJhewltuaTZoJz6GKv3gnCMwPW7CMb1hulz4ysWcukQdsPk2acAzGopG7MGjtyThMuNVbcf47hk0imwp/dat/7StveN61VLQxrdTeVGscT00EHsixpHow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771460413; c=relaxed/simple;
	bh=j4+CdOq089kq8ors8bfwZelUDW7nhSN3xs5Ct6WNwpg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dfpRbR71iGvnFxDBkLssrvUfCBFAhQfTURKnm/Go+aiWaIXyhSO5ffwqerqi/3figoZzdjgdkE77BzUjQW/k7DPNi4L83pce4TS74nsHvtxcIQNMhhgnoJts1w/6WwzjsQWEROo0+uX2hClMpEjb7zwMz5vT19afZ7ybDYlwPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dblDJYyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F8BC116D0;
	Thu, 19 Feb 2026 00:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771460412;
	bh=j4+CdOq089kq8ors8bfwZelUDW7nhSN3xs5Ct6WNwpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dblDJYyhpOnRvCnseeP7c61wCNYMNxWfDwiywOncI8L8j4jwlHlfJB+MVRdXrKOf/
	 BosnuMkGJFxbADxAdhUe2MUYgJ75FGDiwj2LhNxl20XLfIj5XzLvYWLJTxhUmD1a7E
	 7LBqkqx3t+r6DEL25obQAZzxL4hPBeGFu9JhIDJLS6buHyMmFMv5qZ7kgjmlfGjDlC
	 tl7rLzbkquJEXWDX7PdI6ZoGEH4J/30NadeI16PWfmPUFC3eJa6vWTie97j4C4kJ9b
	 STA2ZsHjdY3FrRhMTuK+Dpevm161qZfr/SLFVgx5MyuvgpG9gyYXtbcAsnySTJMTd+
	 EQgK/gsYuxZGg==
Date: Wed, 18 Feb 2026 18:20:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lukas@wunner.de, Alex Williamson <alex@shazbot.org>, clg@redhat.com,
	stable@vger.kernel.org, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v9 3/9] PCI: Avoid saving config space state in reset path
Message-ID: <20260219002010.GA3445930@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7259dc94-b8b1-42f6-852d-76519f1eb262@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217335-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4496D15B1B8
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 01:48:57PM -0800, Farhan Ali wrote:
> On 2/18/2026 11:35 AM, Bjorn Helgaas wrote:
> > On Wed, Feb 18, 2026 at 12:02:01PM -0700, Keith Busch wrote:
> > > On Tue, Feb 17, 2026 at 11:55:43AM -0800, Farhan Ali wrote:
> > > > Yes I think you are right, with this change the PCI Command
> > > > register gets restored to state at enumeration. So we will
> > > > lose the updated state after pci_clear_master() and
> > > > pci_enable_device(). I think we can update the vfio driver to
> > > > call pci_save_state() after pci_enable_device()?
> > >
> > > Either that, or move the pci_enable_device() call to after the
> > > function reset.
> >
> > I kind of like the latter idea because it seems a little simpler
> > for the rule of thumb to be that a reset done by the PCI core
> > returns the device to the same state as when the driver first
> > probed the device.  Drivers would generally not use
> > pci_save_state() at all, and they could share some initialization
> > logic between probe and post-reset recovery.
> 
> I think the vfio-pci driver was intentionally doing the
> pci_enable_device() before doing the reset. As per commit
> 9a92c5091a42 ("vfio-pci: Enable device before attempting reset") it
> was done to handle devices using PM reset, that were getting
> incorrectly identified not supporting PM reset due to current state
> of the device not being D0. It looks like pci_pm_reset() still
> returns -EINVAL if current power state is not D0. So I think we
> can't move pci_enable_device() after reset. Unless we want to update
> pci_pm_reset() to not use cached value of current_state and read it
> directly from register?

Devices are generally disabled at .probe() time, so that will be the
default saved state.  But every driver will expect the device to be
enabled after the reset.  Skipping the save state at reset time seems
like it would need a lot of work first and maybe it wouldn't ever be
practical.  It wasn't really thought out; I was just hoping we could
simplify the save-state model and maybe unify driver reset and error
recovery paths.  I think we need to drop this patch at least for now.

9a92c5091a42 ("vfio-pci: Enable device before attempting reset") was
mostly done to make pci_pm_reset() work, which requires the device to
be in D0.  The main purpose of pci_enable_device() is to make device
BARs accessible; it *does* also put the device in D0 because BARs are
only accessible in D0, but pci_pm_reset() itself doesn't need the
BARs.

Other reset methods, e.g., FLR, don't seem to require the device to be
in D0, so I'm not sure why pci_pm_reset() requires that.  I think the
critical piece is the D3->D0 transition, and maybe we could arrange
for that to happen even if the device is already in D1/D2/D3hot or
even D3cold.

