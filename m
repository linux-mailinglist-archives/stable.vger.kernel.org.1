Return-Path: <stable+bounces-210771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBbKKkEIcWmPcQAAu9opvQ
	(envelope-from <stable+bounces-210771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:09:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF725A519
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D1C276D0EE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04A63D1CD3;
	Wed, 21 Jan 2026 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NtqfizRY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D421339B30;
	Wed, 21 Jan 2026 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007329; cv=none; b=lWVciuywU2+hMOWizSEepmF2CIdBEew+lEy9NvWA94Ma9jMgnBSF6BJUmvUCVmUuAeEz+OethDYEtzsL5DdvMQWtPLsEX3BBNv1xVK4RIAHROEXMjczYGLEL1gOEEszUFLczx8VHGMeJnMz32sM1XYDADfOBgZkBYhNdabUQ2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007329; c=relaxed/simple;
	bh=CXwnx1t8wyz3VfpGOXzehAEuCOrJbBBjpxzQID/HcVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr+O2b2jDLEx6LRDxmIXix+jrGLQWQqTO4OBam/84XGG9rR4wKHrCBMvto/gZdttRMcO/cVSzW9QDwz68jVineXNHWWaxKYdzYsJ80nFsezG6pKHh4TQ2MG1QX97RfvCsF9a4PlMjchsErlgPpU6eXYa50arjbchoOiHcJkDuhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NtqfizRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6B7C19421;
	Wed, 21 Jan 2026 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769007329;
	bh=CXwnx1t8wyz3VfpGOXzehAEuCOrJbBBjpxzQID/HcVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtqfizRYBdSsyCyq9fi6KoYVYQMyPZLrKZluAjqj/oIPVsw06CnuH+XQRrofRAyGR
	 ZtkCJxMdBJYjIYMENQNp+kHVl+bdFtL007y604SMZaFrRiqdeXlFSK75La1HD7YTz6
	 zyMFNz3Ctzk9TwF7PUAP8HsPaBECSKi972VxDhbE=
Date: Wed, 21 Jan 2026 15:55:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Mario Limonciello <superm1@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	regressions <regressions@lists.linux.dev>, stable@vger.kernel.org,
	iommu@lists.linux.dev, "Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"Hou, Lizhi" <lizhi.hou@amd.com>
Subject: Re: IOMMU regression in linux-6.18.y
Message-ID: <2026012113-multiple-stunned-0f64@gregkh>
References: <870872aa-28e9-412a-bac6-8020bf560e4f@amd.com>
 <c51ed4bf-ec2a-45f1-a077-8e2236076827@kernel.org>
 <3fccd233-c5cf-4252-98ea-61f240f82695@linux.intel.com>
 <2026012112-phantom-music-f6e8@gregkh>
 <da9eddb1-305a-491a-9e00-e30ec20dbef3@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da9eddb1-305a-491a-9e00-e30ec20dbef3@linux.intel.com>
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-210771-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,intel.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4BF725A519
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 03:32:42PM +0800, Baolu Lu wrote:
> On 1/21/26 15:26, Greg KH wrote:
> > On Wed, Jan 21, 2026 at 03:14:42PM +0800, Baolu Lu wrote:
> > > On 1/21/26 13:26, Mario Limonciello wrote:
> > > > 
> > > > 
> > > > On 1/20/26 8:08 PM, Mario Limonciello wrote:
> > > > > Hi,
> > > > > 
> > > > > Recently I found out that amdxdna stopped working in linux-6.18.4.
> > > > > This is because of this commit in linux-6.18.y:
> > > > > 
> > > > > commit c341dee80b5d ("iommu: disable SVA when CONFIG_X86 is set")
> > > > > 
> > > > > That was originally backported from upstream:
> > > > > 
> > > > > commit 72f98ef9a4be ("iommu: disable SVA when CONFIG_X86 is set")
> > > > > 
> > > > > ---
> > > > > 
> > > > > SVA support is a requirement for amdxdna.
> > > > > 
> > > > > The series that this commit came from was part of a larger 8 patch
> > > > > series, but this was the only commit that was CC'ed to stable.
> > > > > 
> > > > > As a result this is not broken in 6.19-rc, but it is broken in
> > > > > linux-6.18.y (and presumably any older stable kernels still around
> > > > > that picked it up).
> > > > > 
> > > > > So there are two options I see:
> > > > > 
> > > > > 1) Revert c341dee80b5d in linux-6.18.y (and any other stable kernel
> > > > > that picked it up but has amdxdna)
> > > > > 
> > > > > 2) Bring the entire 8 patch series to linux-6.18.y.
> > > > > 
> > > > > This is the entire series (I didn't look up the hashes from
> > > > > mainline, but they should have all landed):
> > > > > https://lore.kernel.org/linux-iommu/20251022082635.2462433-1-
> > > > > baolu.lu@linux.intel.com/
> > > > > 
> > > > > What should we do?
> > > > > 
> > > > 
> > > > If the decision is to take the remaining commits to 6.18.y to fix this I
> > > > did confirm they cleanly cherry pick and build.  Here are the hashes.
> > > > 
> > > > commit 27bfafac65d8 ("mm: add a ptdesc flag to mark kernel page tables")
> > > > commit 977870522af3 ("mm: actually mark kernel page table pages")
> > > > commit 412d000346ea ("x86/mm: use 'ptdesc' when freeing PMD pages")
> > > > commit 018942956723 ("mm: introduce pure page table freeing function")
> > > > commit bf9e4e30f353 ("x86/mm: use pagetable_free()")
> > > > commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
> > > > tables")
> > > > commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for
> > > > kernel address space")
> > > > 
> > > 
> > > Yes. These patches fix a security issue in iommu/sva on x86 and restore
> > > the SVA functionality.
> > 
> > So all should be backported?  If so, great, but why were they not tagged
> > as such?
> 
> Yes, they should be backported. I am sorry; we should have tagged them
> at the time we upstreamed them.

Ok, all now queued up, thanks.

greg k-h

