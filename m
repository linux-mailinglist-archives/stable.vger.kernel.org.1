Return-Path: <stable+bounces-89215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 335FE9B4D30
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 16:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFDA1F21A33
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 15:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B59192D83;
	Tue, 29 Oct 2024 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="WfQS6wHN"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619C3192B74;
	Tue, 29 Oct 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214745; cv=none; b=ALQphbObJjGubVMsTRnzp6Ry7cxJpFH3cDkS9770WLLTRLM8i6yDORijlVcTtyPvqO7fp6muZqNc9TqrtbyzE6nibISBfz8vs5bzUOxne2+4zkIttb3QrHTycumSOEgRIzlk7gMcKvJobC3JCraY/oPNPllq8SzALs+5nGEfjQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214745; c=relaxed/simple;
	bh=sV9EiAcl9debSIMckM1OniFNc3+TnSVtWZtrqJ1NS6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2rYtOj6LJapOUh8DvA3LIBI6Qzrw5scPErNmTLnznHPZpaud5euPSVGh4tuhzTwYJkT58TwM/eWmeed3EpNSBeEpVfCyMkD7Z9O5vCSbavj9WWuR4X6jz5Lg5e6Nvwdu9dn3q/DNjNM8hvqibtclXZh88Rrqd9H21bzdjndkZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=WfQS6wHN; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id AFE8240F1DCD;
	Tue, 29 Oct 2024 15:12:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru AFE8240F1DCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1730214739;
	bh=LonMjmPRIqGLGG9lfg9x5z6q1Qjyvp/WtDaEd3VBXQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WfQS6wHN+RdgB5qYHuFBVw3AsKgJGAelOmbEmbUMUEYl3aUBtxyBzvbjxClZua+jS
	 ootzikbtwLmun25SKds7PfJ5yqeIUkn3zA1t+8qJffg9RdAs7PDh5/hCUWH2QTnXdm
	 RBkTME1KN1amfXMb461TQQAn08ZzRsq4cid8Qcb8=
Date: Tue, 29 Oct 2024 18:12:16 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>, Wayne Lin <wayne.lin@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jonathan Gray <jsg@jsg.id.au>
Subject: Re: [PATCH 0/1] On DRM -> stable process
Message-ID: <20241029-3ca95c1f41e96c39faf2e49a-pchelkin@ispras.ru>
References: <20241029133141.45335-1-pchelkin@ispras.ru>
 <ZyDvOdEuxYh7jK5l@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyDvOdEuxYh7jK5l@sashalap>

On Tue, 29. Oct 10:20, Sasha Levin wrote:
> On Tue, Oct 29, 2024 at 04:31:40PM +0300, Fedor Pchelkin wrote:
> > BTW, a question to the stable-team: what Git magic (3-way-merge?) let the
> > duplicate patch be applied successfully? The patch context in stable trees
> > was different to that moment so should the duplicate have been expected to
> > fail to be applied?
> 
> Just plain git... Try it yourself :)
> 
> $ git checkout 282f0a482ee6
> HEAD is now at 282f0a482ee61 drm/amd/display: Skip Recompute DSC Params if no Stream on Link
> 
> $ git cherry-pick 7c887efda1

7c887efda1 is the commit backported to linux-6.1.y. Of course it will apply
there.

What I mean is that the upstream commit for 7c887efda1 is 8151a6c13111b465dbabe07c19f572f7cbd16fef.

And cherry-picking 8151a6c13111b465dbabe07c19f572f7cbd16fef to linux-6.1.y
on top of 282f0a482ee6 will not result in duplicating the change, at least
with my git configuration.

I just don't understand how a duplicating if-statement could be produced in
result of those cherry-pick'ings and how the content of 7c887efda1 was
generated.

$ git checkout 282f0a482ee6
HEAD is now at 282f0a482ee6 drm/amd/display: Skip Recompute DSC Params if no Stream on Link

$ git cherry-pick 8151a6c13111b465dbabe07c19f572f7cbd16fef
Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
HEAD detached at 282f0a482ee6
You are currently cherry-picking commit 8151a6c13111.
  (all conflicts fixed: run "git cherry-pick --continue")
  (use "git cherry-pick --skip" to skip this patch)
  (use "git cherry-pick --abort" to cancel the cherry-pick operation)
The previous cherry-pick is now empty, possibly due to conflict resolution.
If you wish to commit it anyway, use:

    git commit --allow-empty

Otherwise, please use 'git cherry-pick --skip'

> Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> [detached HEAD 2a1c937960abd] drm/amd/display: Skip Recompute DSC Params if no Stream on Link
>  Author: Fangzhi Zuo <Jerry.Zuo@amd.com>
>  Date: Fri Jul 12 16:30:03 2024 -0400
>  1 file changed, 3 insertions(+)
> 
> $ git log -2 --oneline
> 2a1c937960abd (HEAD) drm/amd/display: Skip Recompute DSC Params if no Stream on Link
> 282f0a482ee61 drm/amd/display: Skip Recompute DSC Params if no Stream on Link
> 
> -- 
> Thanks,
> Sasha

