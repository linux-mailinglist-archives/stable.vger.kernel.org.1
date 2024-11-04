Return-Path: <stable+bounces-89708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784F59BB84D
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 15:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3181F22656
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659D21B78F3;
	Mon,  4 Nov 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="FqwULYlI"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6E7469D;
	Mon,  4 Nov 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730732150; cv=none; b=AoeUaJ2IXG2ac/1gQVbHg9Or/3xg/Z1BWoRzX3yyUFImvaMY1MAF+jaS0GkGT8zk2xmbyrQX8c5cyCanKvtmkD0QILj8TPR/bkP18OFU99du+escJh/CWhNtfvy8xk7HlzkQk7kMFt92qzy+EQD6EpbPChcsWMTCIFaSHxgHBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730732150; c=relaxed/simple;
	bh=V0jgllGgZmm6Kp+PmaD8+4sijmHzf3cLV8m5VMtEABU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seO2OuGjhY4TUgEclTTvHk6By0p7PyGs5bMOOme6P78FIO8MnccDcIJ7fSmZCqsqWvlXgwKfpl9WjkHD9bR1z+JuapbTqHH0eVykr+pb6Vx8NcBmYs3KZfhrT40tM2p7jK1PQYoAQes9DlF4dG1xFz9BQAVAop8XD66ciufDSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=FqwULYlI; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedor-21d0 (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id EDEAC4076195;
	Mon,  4 Nov 2024 14:55:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EDEAC4076195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1730732138;
	bh=CSbvc+gThKkBZ6ST0m7Xg9yF/waamWCgdZJDDqCcszU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqwULYlIsQwt9sR/7oxHCSMAeLjwsdslWD/2WwY6beRZ2tQUaT8cNUhzWHqaKBwMp
	 DuEVezOKbzAtX8NJEEr0ZdEuBensR4iOp5SQRHTBFErouDq6iFnlbf6vDtuL3NkE/c
	 YFeeZT3goxzKermyi2KtNZdLd1bhbRi+zYwNxlLk=
Date: Mon, 4 Nov 2024 17:55:28 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Fangzhi Zuo <Jerry.Zuo@amd.com>, Wayne Lin <wayne.lin@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	Mario Limonciello <mario.limonciello@amd.com>, Jonathan Gray <jsg@jsg.id.au>
Subject: Re: [PATCH 0/1] On DRM -> stable process
Message-ID: <20241104-61da90a19c561bb5ed63141b-pchelkin@ispras.ru>
References: <20241029133141.45335-1-pchelkin@ispras.ru>
 <ZyDvOdEuxYh7jK5l@sashalap>
 <20241029-3ca95c1f41e96c39faf2e49a-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029-3ca95c1f41e96c39faf2e49a-pchelkin@ispras.ru>

On Tue, 29. Oct 18:12, Fedor Pchelkin wrote:
> On Tue, 29. Oct 10:20, Sasha Levin wrote:
> > On Tue, Oct 29, 2024 at 04:31:40PM +0300, Fedor Pchelkin wrote:
> > > BTW, a question to the stable-team: what Git magic (3-way-merge?) let the
> > > duplicate patch be applied successfully? The patch context in stable trees
> > > was different to that moment so should the duplicate have been expected to
> > > fail to be applied?
> > 
> > Just plain git... Try it yourself :)
> > 
> > $ git checkout 282f0a482ee6
> > HEAD is now at 282f0a482ee61 drm/amd/display: Skip Recompute DSC Params if no Stream on Link
> > 
> > $ git cherry-pick 7c887efda1
> 
> 7c887efda1 is the commit backported to linux-6.1.y. Of course it will apply
> there.
> 
> What I mean is that the upstream commit for 7c887efda1 is 8151a6c13111b465dbabe07c19f572f7cbd16fef.
> 
> And cherry-picking 8151a6c13111b465dbabe07c19f572f7cbd16fef to linux-6.1.y
> on top of 282f0a482ee6 will not result in duplicating the change, at least
> with my git configuration.
> 
> I just don't understand how a duplicating if-statement could be produced in
> result of those cherry-pick'ings and how the content of 7c887efda1 was
> generated.
> 
> $ git checkout 282f0a482ee6
> HEAD is now at 282f0a482ee6 drm/amd/display: Skip Recompute DSC Params if no Stream on Link
> 
> $ git cherry-pick 8151a6c13111b465dbabe07c19f572f7cbd16fef
> Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> HEAD detached at 282f0a482ee6
> You are currently cherry-picking commit 8151a6c13111.
>   (all conflicts fixed: run "git cherry-pick --continue")
>   (use "git cherry-pick --skip" to skip this patch)
>   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
> The previous cherry-pick is now empty, possibly due to conflict resolution.
> If you wish to commit it anyway, use:
> 
>     git commit --allow-empty
> 
> Otherwise, please use 'git cherry-pick --skip'

Sasha,

my concern is that maybe there is some issue with the scripts used for the
preparation of backport patches.

There are two different upstream commits performing the exact same change:
- 50e376f1fe3bf571d0645ddf48ad37eb58323919
- 8151a6c13111b465dbabe07c19f572f7cbd16fef

50e376f1fe3bf571d0645ddf48ad37eb58323919 was backported to stable kernels
at first. After that, attempts to backport 8151a6c13111b465dbabe07c19f572f7cbd16fef
to those stables should be expected to fail, no? Git would have complained
about this - the patch was already applied.

It is just strange that the (exact same) change made by the commits is
duplicated by backporting tools. As it is not the first case where DRM
patches are involved per Greg's statement [1], I wonder if something can be
done on stable-team's side to avoid such odd behavior in future.

[1]: https://lore.kernel.org/stable/20241007035711.46624-1-jsg@jsg.id.au/T/#u

--
Thanks,
Fedor

