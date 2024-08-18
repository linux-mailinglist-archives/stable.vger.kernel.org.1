Return-Path: <stable+bounces-69402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD54955AF9
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 07:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2741F216C2
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 05:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74462944F;
	Sun, 18 Aug 2024 05:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bedKcfx0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26062946F;
	Sun, 18 Aug 2024 05:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723957723; cv=none; b=r4S5+axTQ8lgtL/JB3iteSYz2CLw2urvjvKAluFEPMYTknE0rQjY0UE0mUYk5EQYV0itwXHBp5wT8RG8HtwF+s6JZyVGijxyO8OYtbeZ2cAOymZkJaOfvnYjEjcTbdf7U0kqEfUxwxQG3/mx0c5s9flnhB0lYAbcM4r/W4qx4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723957723; c=relaxed/simple;
	bh=tLHjBLhxmFXEWqxbLa7VP5D2HxF8A4lSY0hSwJ/qc5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWui8rE/2NIuT2w0hWHEorZ3PBPkaUG+ZstsEi//yRnNB8IFPBcfYxI3/63VhkemNk3TcWCe4MY/0a2M2UzNe9MT0RGFs5t6SVXMhiZJK5qSnMUAy41nau1L1EFKkCHy+3N1w0/cyhoH1ntYys351L+NbLRQ3PWMn4dU8aXID3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bedKcfx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EA0C32786;
	Sun, 18 Aug 2024 05:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723957722;
	bh=tLHjBLhxmFXEWqxbLa7VP5D2HxF8A4lSY0hSwJ/qc5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bedKcfx0w9jhWw8P66djV4eyhZMxnyqdcrZTdTwp3los+uxy9iS2wKbIhVgZSnxN2
	 wYz7S4xWZIeBNhgqOpd1+omEFR6NEHTj81kA4Rd8JnFKWXNkwXbmeEjpNxCTSFGYSh
	 5M3yKvWHyUHVgBH+Ityom1j1WcaYJYdM+lVZrDlE=
Date: Sun, 18 Aug 2024 07:08:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kevin Holm <kevin@holm.dev>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	ML dri-devel <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>, Wayne Lin <wayne.lin@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 6.10] drm/amd/display: Refactor function
 dm_dp_mst_is_port_support_mode()
Message-ID: <2024081800-owl-girdle-fd89@gregkh>
References: <20240730185339.543359-1-kevin@holm.dev>
 <2024081739-suburb-manor-e6c3@gregkh>
 <e518ef00-4c7a-4719-bc58-90d782e34b30@holm.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e518ef00-4c7a-4719-bc58-90d782e34b30@holm.dev>

On Sat, Aug 17, 2024 at 10:30:41PM +0200, Kevin Holm wrote:
> 
> 
> On 17.08.24 10:42, Greg KH wrote:
> > On Tue, Jul 30, 2024 at 08:53:39PM +0200, Kevin Holm wrote:
> > > From: Wayne Lin <wayne.lin@amd.com>
> > > 
> > > [ Upstream commit fa57924c76d995e87ca3533ec60d1d5e55769a27 ]
> > > 
> > > [Why]
> > > dm_dp_mst_is_port_support_mode() is a bit not following the original design rule and cause
> > > light up issue with multiple 4k monitors after mst dsc hub.
> > > 
> > > [How]
> > > Refactor function dm_dp_mst_is_port_support_mode() a bit to solve the light up issue.
> > > 
> > > Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
> > > Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
> > > Signed-off-by: Wayne Lin <wayne.lin@amd.com>
> > > Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > [kevin@holm.dev: Resolved merge conflict in .../amdgpu_dm_mst_types.c]
> > > Fixes: 4df96ba6676034 ("drm/amd/display: Add timing pixel encoding for mst mode validation")
> > > Link: https://lore.kernel.org/stable/d74a7768e957e6ce88c27a5bece0c64dff132e24@holm.dev/T/#u
> > > Signed-off-by: Kevin Holm <kevin@holm.dev>
> > > ---
> > > I resolved the merge conflict so that, after this patch is applied to the
> > > linux-6.10.y branch of the stable git repository, the resulting function
> > > dm_dp_mst_is_port_support_mode (and also the new function
> > > dp_get_link_current_set_bw) is identical to the original commit.
> > > 
> > > I've confirmed that it fixes the regression I reported for my use case.
> > 
> > And it turns out this change breaks the arm and arm64 builds.  I tried
> > to fix it up by applying the fixup afterward for this file, but it's
> > just too much of a mess to unwind this, so I'm going to have to revert
> > this now, sorry.
> That sucks, sorry for the problems my patch caused. :(
> 
> > See:
> > 	https://lore.kernel.org/r/b27c5434-f1b1-4697-985b-91bb3e9a22df@roeck-us.net
> > for details.
> I unfortunately don't know the amdgpu driver and kernel code in general enough to help fix
> that. The back-ported patch I send was my first patch to the kernel.
> 
> In the email thread where I reported the problem I send a patch that reverts
> 4df96ba6676034 ("drm/amd/display: Add timing pixel encoding for mst mode validation") to
> fix the problem that way [1]. I've included a copy of that below.
> I've tested that it still applies to 6.10.6-rc3 without conflicts and compiles for me. I
> could not test if the 6.10.6-rc3 with the revert applied fixes the problem as I'm
> traveling and don't have access to my normal setup. I can only say that reverting it on
> v6.10.2 fixed the problem for me.
> 
> I don't know how to compile for other architectures so I did not test that.
> 
> Not sure what would be best, reverting the problem commit so the regression is fixed in
> the 6.10 stable kernel (and maybe breaking something else?) or waiting for someone at AMD
> with better knowledge of the amdgpu driver to back-port the fixing commit in a non-broken
> way.

Yes, this is up to the amd developers now, I suggest you work with them
to get this resolved please.

Or just use 6.11-rc3 and newer :)

thanks,

greg k-h

