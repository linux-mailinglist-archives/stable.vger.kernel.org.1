Return-Path: <stable+bounces-71325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C23D9613C1
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079F11F2433E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2499C1C93AF;
	Tue, 27 Aug 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZWVv48bg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99F1A0B13
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775218; cv=none; b=pxP2fpQCl6+KD7cteYpd61+4BeJ1974eDvg5G9NSWuaMW+uZIv/mHRbgTPrjEgoqH02HuGWzapJlJfWG1fXGWWgmUmtGrO6lYB03nEsjMFI/oWf8CDktr8b46CrXRvag9mfCYfIlIGLYH5u3N88JY2fQ/yNTbj4LTRuGaTVz7n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775218; c=relaxed/simple;
	bh=N1U0C8ab2h45FWIcOFzWL8LthVcbCZSCs8Dh2JBqz5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/e+4bscJjQUAkoMSgo28VNkERnU10cb7NVvifrggCoDunTo2RyfU5r4Huf1ShWay7ZjBbmU4i6tyyCmvQ+4ZCGL/csfU4EAKgiuGdxpLnjiXdLLStS9ny2akrouy74pqcNFWk0v8rJDklQBwnj6wkcDxSLetDpSAfv86YfINjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZWVv48bg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DC1C4FEBB;
	Tue, 27 Aug 2024 16:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724775218;
	bh=N1U0C8ab2h45FWIcOFzWL8LthVcbCZSCs8Dh2JBqz5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZWVv48bgP56ztEj3dwoTqawXiuFbjOfejGkgKkXolC1S4TbMPTz2HQ7bIRfIIrKJS
	 dsJcfQcDLFmwXgFBQVm0LvBfPfxRuMGjKSrTuYwkZIle9oV7QzA46YJTRTLnRfC5f/
	 OIVWASZ/zHrmGvTAWeJzjL8DigMAP2JSRE3mhmZ4=
Date: Tue, 27 Aug 2024 18:13:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"Xiao, Jack" <Jack.Xiao@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
Message-ID: <2024082743-corset-cloud-338c@gregkh>
References: <20240827141025.1329567-1-alexander.deucher@amd.com>
 <2024082746-amendment-unread-593d@gregkh>
 <BL1PR12MB514422F9FA07573AC2A2759BF7942@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB514422F9FA07573AC2A2759BF7942@BL1PR12MB5144.namprd12.prod.outlook.com>

On Tue, Aug 27, 2024 at 03:01:54PM +0000, Deucher, Alexander wrote:
> [Public]
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, August 27, 2024 10:21 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: stable@vger.kernel.org; sashal@kernel.org; Xiao, Jack
> > <Jack.Xiao@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
> >
> > On Tue, Aug 27, 2024 at 10:10:25AM -0400, Alex Deucher wrote:
> > > From: Jack Xiao <Jack.Xiao@amd.com>
> > >
> > > wait memory room until enough before writing mes packets to avoid ring
> > > buffer overflow.
> > >
> > > v2: squash in sched_hw_submission fix
> > >
> > > Backport from 6.11.
> > >
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3571
> > > Fixes: de3246254156 ("drm/amdgpu: cleanup MES11 command
> > submission")
> > > Fixes: fffe347e1478 ("drm/amdgpu: cleanup MES12 command submission")
> >
> > These commits are in 6.11-rc1.
> 
> de3246254156 ("drm/amdgpu: cleanup MES11 command submission")
> was ported to 6.10 as well:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c?h=linux-6.10.y&id=e356d321d0240663a09b139fa3658ddbca163e27
> So this fix is applicable there.

No, commit e356d321d024 ("drm/amdgpu: cleanup MES11 command submission")
is in the 6.10 release, but commit de3246254156 ("drm/amdgpu: cleanup
MES11 command submission") is in 6.11-rc1!

So how in the world are we supposed to know anything here?

See how broken this all is?

I give up.

If you all want any AMD patches applied to stable trees, manually send
us a set of backported patches, AND be sure to get the git ids right.

I'll leave what I have right now in the queues, but after this round of
-rc releases, all AMD patches with cc: stable are going to be
automatically dropped and ignored.  I NEED you all to manually send them
to me now as this is just insane.

Time to go buy a Intel gpu card as there's no way this is going to work
out well over time...

{sigh}

greg k-h

