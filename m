Return-Path: <stable+bounces-247631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAIQBMjoBmpKowIAu9opvQ
	(envelope-from <stable+bounces-247631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:35:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C8954C7FD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8D3B30A630A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886C83E9F8E;
	Fri, 15 May 2026 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x8Uigb6b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3423D646D
	for <stable@vger.kernel.org>; Fri, 15 May 2026 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837028; cv=none; b=VizVLftccOh0Klm9N15y6MfU8OHUpxvXEg00NMu3vujSAutTVdBNlilGrnTQt/tNM6cp4H5vnTlEH5UuZvinz4OU+ZxkaVXkrektYtsESX/WNgAbUFThVdZ7fmBZKj7A/ElDa/X8fxCtmp55V36juEGBgNZu8hla8G1rxyN2ah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837028; c=relaxed/simple;
	bh=2ASFhG6zJSeTqCM2olEnaoaF3zHtMgGhO36m+pFCV/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTia/JZwboRlqxbL7ebQgNDZsyGiAjr7PV0LejgFAtiEtB6YsFKE7/CPpvU6fX8mkboQ/LCjYJfqh7FsX+wUyR/0VmK9AoivSjH7fVUbXfMIHmw9R/3roMaH0GeRJVXUO1HWH3vFEvjbtvsYDHIyq8dBeCKbL4nv+obWkN7djVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x8Uigb6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D70C2BCC7;
	Fri, 15 May 2026 09:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778837027;
	bh=2ASFhG6zJSeTqCM2olEnaoaF3zHtMgGhO36m+pFCV/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x8Uigb6bhBph349t2/2X3FBS4JNQlcndlNdYnenqB4UaZLqEBU2tdXFlGqFXBRDWS
	 Enu9+r4uLq1J6pZoqTgkKYvMC9RUaywucmpucILTEnHPwlfeQ5t/57p/aOBrqdrdkP
	 etgS7dAu5QGLKFj88DnRig+gbSAdRIgv3vwmQdgc=
Date: Fri, 15 May 2026 11:23:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"mjanes@netflix.com" <mjanes@netflix.com>
Subject: Re: [6.18.y] Missing TLB fix for 6.18.y
Message-ID: <2026051544-slick-reconvene-a4de@gregkh>
References: <04e60ca1-5acd-4c18-aa48-f5650b301137@amd.com>
 <BL1PR12MB51443EB4D300A93B30F97AE9F7312@BL1PR12MB5144.namprd12.prod.outlook.com>
 <2026051233-street-thieving-ddb9@gregkh>
 <BL1PR12MB51440378065158CC8EE2E267F7392@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51440378065158CC8EE2E267F7392@BL1PR12MB5144.namprd12.prod.outlook.com>
X-Rspamd-Queue-Id: A9C8954C7FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247631-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 08:53:47PM +0000, Deucher, Alexander wrote:
> Public
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, May 12, 2026 1:22 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>;
> > stable@vger.kernel.org; mjanes@netflix.com
> > Subject: Re: [6.18.y] Missing TLB fix for 6.18.y
> >
> > On Mon, May 04, 2026 at 07:52:21PM +0000, Deucher, Alexander wrote:
> > > Public
> > >
> > > > -----Original Message-----
> > > > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > > Sent: Monday, May 4, 2026 3:43 PM
> > > > To: stable@vger.kernel.org
> > > > Cc: mjanes@netflix.com; Deucher, Alexander
> > > > <Alexander.Deucher@amd.com>
> > > > Subject: [6.18.y] Missing TLB fix for 6.18.y
> > > >
> > > > Hi,
> > > >
> > > > Mark Janes noticed that commit e9f58ff991dd4 ("drm/amdgpu: rework
> > > > how we handle TLB fences") was missing from 6.18.y.
> > > >
> > > > This went into 7.0-rc5 and was backported to 6.19.y but not 6.18.y.
> > > >
> > > > This is because this was one of those cases that the "Fixed" commit
> > > > was in both 6.18 and 6.19.y as different hashes:
> > > >
> > > > b4a7f4e7ad2b120a94f3111f92a11520052c762d
> > > > f3854e04b708d73276c4488231a8bd66d30b4671
> > > >
> > > > So can you please backport e9f58ff991dd4 to 6.18.y?
> > >
> > > There are missing dependencies.  Please cherry pick all of the following:
> > >
> > > f4db9913e4d3 ("drm/amdgpu: validate the flush_gpu_tlb_pasid()")
> > > e3a6eff92bbd ("drm/amdgpu: Fix validating flush_gpu_tlb_pasid()")
> > > 9163fe4d790f ("Revert "drm/amdgpu: don't attach the tlb fence for
> > > SI"") 69c5fbd2b93b ("drm/amdgpu: rework how we handle TLB fences")
> >
> > In what order please?  Can someone provide a list of the full set?
> 
> 
> That is the full set.  Please apply the following in descending order:
> commit f4db9913e4d3 ("drm/amdgpu: validate the flush_gpu_tlb_pasid()")
> commit e3a6eff92bbd ("drm/amdgpu: Fix validating flush_gpu_tlb_pasid()")
> commit 9163fe4d790f ("Revert "drm/amdgpu: don't attach the tlb fence for SI"")
> commit 69c5fbd2b93b ("drm/amdgpu: rework how we handle TLB fences")

All now queued up, thanks!

greg k-h

