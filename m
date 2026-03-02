Return-Path: <stable+bounces-222515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHXQC4UqpWnY4wUAu9opvQ
	(envelope-from <stable+bounces-222515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 07:13:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2091D3625
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 07:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D81B301A288
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 06:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A47377546;
	Mon,  2 Mar 2026 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A860vboY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E137232ED42;
	Mon,  2 Mar 2026 06:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772431999; cv=none; b=rXyODCK9Khvxh93JoI0RQRrNYwZp2ZBVS3jMG7sBcajHhm2iGL/rS9KEt1ooW4ZdhOglsM/lor09rvYA3/es+RyCyy/RC29WAWWAuN0cFRDxxMkpzQ6NfxmvahA1CNGQLb4+5GYiVJmDadP3kaByyG6jIsasScO/iIWzSgiOGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772431999; c=relaxed/simple;
	bh=+vgUVOQ14mfsfjADYu/tniw6hDr7GNc8NHvApPhBDTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQxNgSqkn4AWp/F6wL+Ul6dvPeoxhLDN6ppS13GFj4yKnRwj6i/3bny3dBlhQVa03FWSvpwNuSwfjdO64ehPpht22pREu++tpMO9CPFADxT+ahvbkvrbg48R2yMjfe/YfYKx6PtpLCmrmoXglFnw/++CNMIBFHGVliP7XC+9aEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A860vboY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF1AC19423;
	Mon,  2 Mar 2026 06:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772431998;
	bh=+vgUVOQ14mfsfjADYu/tniw6hDr7GNc8NHvApPhBDTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A860vboYxTXkAWSEZQug+sATq0Dpeyqr36ehKptBr7lOcg61Ny1+dr1FTIGwLRDc9
	 Bw0kFnlNzVZc4gHb2bu7CdsHj2JijVf/9zNxZUNAQW5bcJ29RW76JkqQfcgaSu44+I
	 KBnj5TjNxNNLKCcdDIG/GjYOotiw//O55CrSqIlibtaT0FdFGxVNfkBiNUijtdDixO
	 pnSSCKDjYNmc1EhK72T60L5zpQlY0rAptKAi3qyRXUuYD5KCBcVyoFSd3zFtnKwMgf
	 LasyxORtXtAn9u+DiCPd7EJGNnGFTcB1XCMwW7F2+ZBbkG1ioQYrtWr2iZdPbLuMLO
	 Rg0wWQwHJdwrw==
Date: Mon, 2 Mar 2026 11:43:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>, 
	bhelgaas@google.com, helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com, 
	alifm@linux.ibm.com, julianr@linux.ibm.com, dtatulea@nvidia.com, 
	ionut_n2001@yahoo.com, sunlightlinux@gmail.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] PCI/IOV: Add reentrant locking in
 sriov_add_vfs/sriov_del_vfs for complete serialization
Message-ID: <vogl77sk53qas4nnqb4jrmduofxhuhpcgipdkab5meuswd3hhr@l6rfqqndskfv>
References: <20260228120138.51197-2-ionut.nechita@windriver.com>
 <20260228120138.51197-4-ionut.nechita@windriver.com>
 <mvhrbhqxnxeitx4incfykvlgtcfs2jcrlje2warhujzvbyns4e@7eyme5xdea7g>
 <20260228163955.GH13050@p1gen4-pw042f0m>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260228163955.GH13050@p1gen4-pw042f0m>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222515-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[windriver.com,google.com,kernel.org,linux.ibm.com,nvidia.com,yahoo.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,windriver.com:email]
X-Rspamd-Queue-Id: 9A2091D3625
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 05:39:55PM +0100, Benjamin Block wrote:
> On Sat, Feb 28, 2026 at 08:43:33PM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Feb 28, 2026 at 02:01:40PM +0200, Ionut Nechita (Wind River) wrote:
> > > From: Ionut Nechita <ionut.nechita@windriver.com>
> > > 
> > > After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
> > > locking when enabling/disabling SR-IOV") and moving the lock to
> > > sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
> > > or manual unbind) that calls pci_disable_sriov() directly remains
> > > unprotected against concurrent hotplug events. This affects any SR-IOV
> > > capable driver that calls pci_disable_sriov() from its .remove()
> > > callback (i40e, ice, mlx5, bnxt, etc.).
> > > 
> > > On s390, platform-generated hot-unplug events for VFs can race with
> > > sriov_del_vfs() when a PF driver is being unloaded. The platform event
> > > handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
> > > leading to double removal and list corruption.
> > > 
> > > We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
> > > be called from paths that already hold pci_rescan_remove_lock (e.g.
> > > remove_store -> pci_stop_and_remove_bus_device_locked, or
> > > sriov_numvfs_store with the lock taken by the previous patch). Using
> > > mutex_lock() in those cases would deadlock.
> > > 
> > > Instead, introduce owner tracking for pci_rescan_remove_lock via a new
> > > pci_lock_rescan_remove_reentrant() helper. This function checks if the
> > > current task already holds the lock:
> > >  - If the lock is not held: acquires it and returns true, providing
> > >    full serialization against concurrent hotplug events (including
> > >    platform-generated events on s390).
> > >  - If the lock is already held by the current task (reentrant call from
> > >    remove_store or sriov_numvfs_store paths): returns false without
> > >    re-acquiring, avoiding deadlock while the caller already provides
> > >    the necessary serialization.
> > >  - If the lock is held by another task (concurrent hotplug): blocks
> > >    until the lock is released, then acquires it, providing complete
> > >    serialization. This is the key improvement over a trylock approach.
> > 
> > Just curious. Why can't you use mutex_trylock() here?
> 
> One problem with mutex_trylock() is we don't know whether we ourself or
> someone else is holding the lock when it fails, we just know someone holds it;
> and we can't wait for someone else to release it when there is a chance we
> hold it ourself already. That was the problem with
> 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
> before it was reverted.
> 

Okay, thanks for the info. I also failed to notice the mention of 'trylock' in
the cover letter.

But I think, instead of caching the owner task struct locally, you can make use
of mutex_get_owner() to extact the embedded owner task struct.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

