Return-Path: <stable+bounces-89790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF75C9BC658
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 08:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24AF3B22CD4
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 07:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548741FDF96;
	Tue,  5 Nov 2024 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OL2Jl9NH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C50A200BBA;
	Tue,  5 Nov 2024 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789874; cv=none; b=I19P8Ho0GquiH76Qop151tNY3tJcU7tRMeV6YTTM2ZGmYcPntD4iFuTZ9y0Z6NkCyCwIw4dYMDmL18mVVmjfpSW9jP8Ng1BwtQD8NAGqg3FXbE4eOkQJFz1H3jcvfLvQZHA9MrbGRrX64O9UnHba6AxCDqKmQKhpWyQWLGEBqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789874; c=relaxed/simple;
	bh=ZicFVzCAyAFd8O++kgwqNs2srV+tu6OcfDWzbCh+PLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MANZmg5XKLxzUwXd/Hy6L8FZqsPExEsVJhD6nyNmxC4tAeNz5M9gXR/JzC5vfnwI7q/NwOjCvzAuJDUsMjiNVSnW6LbKzQiXAINAvt5VpNhPJkTcEYkQiDbNrVkuPy0Km/n61I+JgxhCcNbjABotxablRngjmdODUmI1pW5s8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OL2Jl9NH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED70DC4CECF;
	Tue,  5 Nov 2024 06:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730789873;
	bh=ZicFVzCAyAFd8O++kgwqNs2srV+tu6OcfDWzbCh+PLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OL2Jl9NHeOaYSKo1ZmaacuRsI9yF04ia7wa/ohx7HyUN+Ec88CaVktvCHoeDHbDeu
	 prCV59YJ4XI3UnDrLwkNXL8go1+GNEXc/J+yrfS4tfM0BC82NStS6G/b3KS0j94we4
	 TY+VJJ0647OkPJXidt/oVYe0wJTQoMtamZ38SWT8=
Date: Tue, 5 Nov 2024 07:57:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>, Wayne Lin <wayne.lin@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jonathan Gray <jsg@jsg.id.au>
Subject: Re: [PATCH 0/1] On DRM -> stable process
Message-ID: <2024110521-mummify-unloved-4f5d@gregkh>
References: <20241029133141.45335-1-pchelkin@ispras.ru>
 <ZyDvOdEuxYh7jK5l@sashalap>
 <20241029-3ca95c1f41e96c39faf2e49a-pchelkin@ispras.ru>
 <20241104-61da90a19c561bb5ed63141b-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104-61da90a19c561bb5ed63141b-pchelkin@ispras.ru>

On Mon, Nov 04, 2024 at 05:55:28PM +0300, Fedor Pchelkin wrote:
> On Tue, 29. Oct 18:12, Fedor Pchelkin wrote:
> > On Tue, 29. Oct 10:20, Sasha Levin wrote:
> > > On Tue, Oct 29, 2024 at 04:31:40PM +0300, Fedor Pchelkin wrote:
> > > > BTW, a question to the stable-team: what Git magic (3-way-merge?) let the
> > > > duplicate patch be applied successfully? The patch context in stable trees
> > > > was different to that moment so should the duplicate have been expected to
> > > > fail to be applied?
> > > 
> > > Just plain git... Try it yourself :)
> > > 
> > > $ git checkout 282f0a482ee6
> > > HEAD is now at 282f0a482ee61 drm/amd/display: Skip Recompute DSC Params if no Stream on Link
> > > 
> > > $ git cherry-pick 7c887efda1
> > 
> > 7c887efda1 is the commit backported to linux-6.1.y. Of course it will apply
> > there.
> > 
> > What I mean is that the upstream commit for 7c887efda1 is 8151a6c13111b465dbabe07c19f572f7cbd16fef.
> > 
> > And cherry-picking 8151a6c13111b465dbabe07c19f572f7cbd16fef to linux-6.1.y
> > on top of 282f0a482ee6 will not result in duplicating the change, at least
> > with my git configuration.
> > 
> > I just don't understand how a duplicating if-statement could be produced in
> > result of those cherry-pick'ings and how the content of 7c887efda1 was
> > generated.
> > 
> > $ git checkout 282f0a482ee6
> > HEAD is now at 282f0a482ee6 drm/amd/display: Skip Recompute DSC Params if no Stream on Link
> > 
> > $ git cherry-pick 8151a6c13111b465dbabe07c19f572f7cbd16fef
> > Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > HEAD detached at 282f0a482ee6
> > You are currently cherry-picking commit 8151a6c13111.
> >   (all conflicts fixed: run "git cherry-pick --continue")
> >   (use "git cherry-pick --skip" to skip this patch)
> >   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
> > The previous cherry-pick is now empty, possibly due to conflict resolution.
> > If you wish to commit it anyway, use:
> > 
> >     git commit --allow-empty
> > 
> > Otherwise, please use 'git cherry-pick --skip'
> 
> Sasha,
> 
> my concern is that maybe there is some issue with the scripts used for the
> preparation of backport patches.
> 
> There are two different upstream commits performing the exact same change:
> - 50e376f1fe3bf571d0645ddf48ad37eb58323919
> - 8151a6c13111b465dbabe07c19f572f7cbd16fef
> 
> 50e376f1fe3bf571d0645ddf48ad37eb58323919 was backported to stable kernels
> at first. After that, attempts to backport 8151a6c13111b465dbabe07c19f572f7cbd16fef
> to those stables should be expected to fail, no? Git would have complained
> about this - the patch was already applied.
> 
> It is just strange that the (exact same) change made by the commits is
> duplicated by backporting tools. As it is not the first case where DRM
> patches are involved per Greg's statement [1], I wonder if something can be
> done on stable-team's side to avoid such odd behavior in future.

No, all of this mess needs to be fixed up on the drm developer's side,
they are the ones doing this type of crazy "let's commit the same patch
to multiple branches and then reference a commit that will show up at an
unknown time in the future and hope for the best!" workflow.

I'm amazed it works at all, they get to keep fixing up this mess as this
is entirely self-inflicted.

greg k-h

