Return-Path: <stable+bounces-222612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mxv2AHmdpWlvCAAAu9opvQ
	(envelope-from <stable+bounces-222612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:23:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CC11DAB56
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7A083056157
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8590407562;
	Mon,  2 Mar 2026 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bsg2aane"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9A3DA7FC;
	Mon,  2 Mar 2026 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460955; cv=none; b=RjiPaCAx3ueP+HXkJHi1ghHRJZc9swtrF8fvlZ491MzmVLnn5V7vp9+Xud1J5bhnYBzkt7teBEUS981M6eEFJP9vLqb23DIQ2jCggWcoNi4hqkQ6QwAzLfy1sEL4utojZFYnV+Fi0Zb6peaJXniIGjf0vD+QwcmEXbwcWq1nmtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460955; c=relaxed/simple;
	bh=pQQsCniROcPjC6d+VRj/iFcR4pZ8qZujZDbz/KpKee8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvCATGaYuNi2yAGzuo+kF1GEuJ8oyo6bbEWtZbO7lVxH2y2IH6dtZO32QY8RRvHEgzrbCpYrZH2fW//Y/pRVaktmMiEf113Sjj4B8gwolMI/n7HmbHkML2gL+hmExS/vZTUNlEXgthAiR7ix0hzqL5roAPpITPD+hxJJPFib5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bsg2aane; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C88C2BC86;
	Mon,  2 Mar 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772460955;
	bh=pQQsCniROcPjC6d+VRj/iFcR4pZ8qZujZDbz/KpKee8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bsg2aaneh+3q8BefK6Jsi2wEgucNOHaYa8a06q2komNGlfraeKdCFTjY+IHZSo/Gn
	 AdsxiOeZPty9MnwabnEgDyKkeSU+Tt0sJy+g7UXQIn+xnf24OLUYqYfK+/EnvHce/U
	 kHA7O4/K6bNIGKwnng0Qi6TcryMAUGYJWpzVR+ROmFACA18mQEdloQa3KxU08yh987
	 ZL7/cCUu8TnPWXcn0Pd747kq8wS46+zta2YC/1BUW2CZMzrZf1IqfY7GmWwrbdB076
	 BaWzT9j8ddwvEqeiWxYDzxTiwUK6db6a7ExqTO5SuxuihZwk1kbRIrz7k8NYRy79DN
	 LyUnIVPoNqSSQ==
Date: Mon, 2 Mar 2026 19:45:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Benjamin Block <bblock@linux.ibm.com>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>, 
	bhelgaas@google.com, helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com, 
	alifm@linux.ibm.com, julianr@linux.ibm.com, dtatulea@nvidia.com, 
	ionut_n2001@yahoo.com, sunlightlinux@gmail.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] PCI/IOV: Add reentrant locking in
 sriov_add_vfs/sriov_del_vfs for complete serialization
Message-ID: <cq3z34gmevzczk6gpvqfz5whevsjdodq4ls2j2jhxqx2apgngu@sowonwmqy6ol>
References: <20260228120138.51197-2-ionut.nechita@windriver.com>
 <20260228120138.51197-4-ionut.nechita@windriver.com>
 <mvhrbhqxnxeitx4incfykvlgtcfs2jcrlje2warhujzvbyns4e@7eyme5xdea7g>
 <20260228163955.GH13050@p1gen4-pw042f0m>
 <vogl77sk53qas4nnqb4jrmduofxhuhpcgipdkab5meuswd3hhr@l6rfqqndskfv>
 <20260302101105.GA1971507@p1gen4-pw042f0m>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302101105.GA1971507@p1gen4-pw042f0m>
X-Rspamd-Queue-Id: 84CC11DAB56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[172.234.253.10:from];
	FREEMAIL_CC(0.00)[windriver.com,google.com,kernel.org,linux.ibm.com,nvidia.com,yahoo.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-222612-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DNSWL_BLOCKED(0.00)[100.90.174.1:received,10.30.226.201:received,172.234.253.10:from];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[10.30.226.201:received,100.90.174.1:received];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,windriver.com:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:11:05AM +0100, Benjamin Block wrote:
> On Mon, Mar 02, 2026 at 11:43:04AM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Feb 28, 2026 at 05:39:55PM +0100, Benjamin Block wrote:
> > > On Sat, Feb 28, 2026 at 08:43:33PM +0530, Manivannan Sadhasivam wrote:
> > > > On Sat, Feb 28, 2026 at 02:01:40PM +0200, Ionut Nechita (Wind River) wrote:
> > > > > From: Ionut Nechita <ionut.nechita@windriver.com>
> > > > > Instead, introduce owner tracking for pci_rescan_remove_lock via a new
> > > > > pci_lock_rescan_remove_reentrant() helper. This function checks if the
> > > > > current task already holds the lock:
> > > > >  - If the lock is not held: acquires it and returns true, providing
> > > > >    full serialization against concurrent hotplug events (including
> > > > >    platform-generated events on s390).
> > > > >  - If the lock is already held by the current task (reentrant call from
> > > > >    remove_store or sriov_numvfs_store paths): returns false without
> > > > >    re-acquiring, avoiding deadlock while the caller already provides
> > > > >    the necessary serialization.
> > > > >  - If the lock is held by another task (concurrent hotplug): blocks
> > > > >    until the lock is released, then acquires it, providing complete
> > > > >    serialization. This is the key improvement over a trylock approach.
> > > > 
> > > > Just curious. Why can't you use mutex_trylock() here?
> > > 
> > > One problem with mutex_trylock() is we don't know whether we ourself or
> > > someone else is holding the lock when it fails, we just know someone holds it;
> > > and we can't wait for someone else to release it when there is a chance we
> > > hold it ourself already. That was the problem with
> > > 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
> > > before it was reverted.
> > 
> > Okay, thanks for the info. I also failed to notice the mention of 'trylock' in
> > the cover letter.
> > 
> > But I think, instead of caching the owner task struct locally, you can make use
> > of mutex_get_owner() to extact the embedded owner task struct.
> 
> True. Didn't know/see that one, yet. We'd have to treat the return value as
> `struct task_struct *` to compare it, but I see debug_show_blocker() already
> does that effectively (when I saw the function returns ulong, I thought it was
> meant to be treated as transparent value).

Yeah, I don't know the reasoning behind it. But atleast it avoids caching the
task struct pointer locally.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

