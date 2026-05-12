Return-Path: <stable+bounces-245849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONdKD3tiA2oq5gEAu9opvQ
	(envelope-from <stable+bounces-245849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:25:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4641525C86
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA65230BB396
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218A93D5C1B;
	Tue, 12 May 2026 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z9rMay3i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63B73DB971
	for <stable@vger.kernel.org>; Tue, 12 May 2026 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606507; cv=none; b=jj6puZRXtKz0eRiTnQ+pLI9Ew6kWDoNOnvnZg1WgsLoAlGr0JdEEtXfNg0PEoia6JhZ7HGyUgVXRqJewvLKzLzGOh+eegA+C22za4WZGF/eGiXS2oEBQpXU5bgMsWisVWHEaZjQ80QiwC3FilMzm2NCcar+4QNHWRglxsGojq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606507; c=relaxed/simple;
	bh=iEBVj17BAwXKz3kmflPygGWFwvZsHUYgEZWpZJIgzM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/EUfOGJfRgd5E9KUef0/eGD53Fkc6SM5sVJ0nGNk5Beb6R7S+xcV6TcQpTk8O4NzdCc7oXAaCk9ajVTM+aPQVylvBkECy7euXm0sRSX6HpHHQqMxbb3xuaLakjPgWu1bQSLMCnqNFVMwsxtaWCNCSa2dmwSr/O6LAR+g0MO25s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z9rMay3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE07C2BCFF;
	Tue, 12 May 2026 17:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778606507;
	bh=iEBVj17BAwXKz3kmflPygGWFwvZsHUYgEZWpZJIgzM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9rMay3im/GNvCUfNXZRS0PfTehYUMK+D8LhbJmKcgez+JBjBNWDdE0sPhLjxZlMy
	 wNcATJfRFxXOgiVk3IihQng2eBhJWsumUuIn/0Rms9p44EJSZrhuPw/Q7/g47GQ89z
	 45WmfOsANNqZoItDyaG1ZDr6ESzz1Ia5rxdKpTSQ=
Date: Tue, 12 May 2026 19:21:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"mjanes@netflix.com" <mjanes@netflix.com>
Subject: Re: [6.18.y] Missing TLB fix for 6.18.y
Message-ID: <2026051233-street-thieving-ddb9@gregkh>
References: <04e60ca1-5acd-4c18-aa48-f5650b301137@amd.com>
 <BL1PR12MB51443EB4D300A93B30F97AE9F7312@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51443EB4D300A93B30F97AE9F7312@BL1PR12MB5144.namprd12.prod.outlook.com>
X-Rspamd-Queue-Id: B4641525C86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245849-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,amd.com:email]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 07:52:21PM +0000, Deucher, Alexander wrote:
> Public
> 
> > -----Original Message-----
> > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Sent: Monday, May 4, 2026 3:43 PM
> > To: stable@vger.kernel.org
> > Cc: mjanes@netflix.com; Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [6.18.y] Missing TLB fix for 6.18.y
> >
> > Hi,
> >
> > Mark Janes noticed that commit e9f58ff991dd4 ("drm/amdgpu: rework how
> > we handle TLB fences") was missing from 6.18.y.
> >
> > This went into 7.0-rc5 and was backported to 6.19.y but not 6.18.y.
> >
> > This is because this was one of those cases that the "Fixed" commit was in
> > both 6.18 and 6.19.y as different hashes:
> >
> > b4a7f4e7ad2b120a94f3111f92a11520052c762d
> > f3854e04b708d73276c4488231a8bd66d30b4671
> >
> > So can you please backport e9f58ff991dd4 to 6.18.y?
> 
> There are missing dependencies.  Please cherry pick all of the following:
> 
> f4db9913e4d3 ("drm/amdgpu: validate the flush_gpu_tlb_pasid()")
> e3a6eff92bbd ("drm/amdgpu: Fix validating flush_gpu_tlb_pasid()")
> 9163fe4d790f ("Revert "drm/amdgpu: don't attach the tlb fence for SI"")
> 69c5fbd2b93b ("drm/amdgpu: rework how we handle TLB fences")

In what order please?  Can someone provide a list of the full set?

confused,

greg k-h

