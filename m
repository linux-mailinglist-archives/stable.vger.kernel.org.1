Return-Path: <stable+bounces-89212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84699B4C02
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 15:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97531C22984
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A010206E65;
	Tue, 29 Oct 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYjzEArB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C21E507;
	Tue, 29 Oct 2024 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211645; cv=none; b=NfGc0RRG2Ry6ohlltEJiR62ELBAebTBWGUKsVm7YXnxVKoDh/i7IkMF/28TrCLjnQCMfWpjCq5HQs8TIEtrUdEXhDDwXpZ4GJiiCru0p4J4GZR7RI2enEU8wCMv/3lt1N5FAlRbX4iV7Mk1LAQUHbUBU1BMvrMZL3Z/anzbTFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211645; c=relaxed/simple;
	bh=Ncqu84eUIoV/noeY6jmyqqV/eVZFpGTtgpv7Q0T0B5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1ZdEfdh3DUSxNU4Ie30UT9N4iAgdVED3KJe0QPnTkXfKeDdOqNzJyrLfk3IpuywPplu1yHtYHDsGh+qi6tjSmgABjQfv9TR8k+gj2uuvONteOimc11BB8UGWBJsGYclf+ceKRajCRZ3lZ65hms7S7qIgV33lrmX60oUMVm2X0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYjzEArB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D36FC4CECD;
	Tue, 29 Oct 2024 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730211643;
	bh=Ncqu84eUIoV/noeY6jmyqqV/eVZFpGTtgpv7Q0T0B5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYjzEArBIeXR63S0DAJiAxxbzhzEZIV8QivhpU5ANCtLSGwqTZ1nm45/4qn6niL0d
	 m9uEuR081kn8tzG0jdN0ZyFKyOLtRKWMAcjyVMeRMAVgogWoSvIM/r+TUy/LkyouX1
	 fnMShynZ9vA6BpE5TTeut1rS7u2olD5uvk+oYxlkBVuHcsA3sZ8bLTVD2eK3TohywQ
	 jIpt1n3IOm8zAcejWENEaSB7/D/zbPV58HCiosAAaWDTXM6KSX4LOcuCNgSb0Lzi66
	 3YYhrwc+gBGc4Bth8M2VRrK+KOjqYs+cJbO5+C2Be+/v/rYlI6pec3N7anHClUdtQB
	 blwO7HzGIiEXw==
Date: Tue, 29 Oct 2024 10:20:41 -0400
From: Sasha Levin <sashal@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
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
Message-ID: <ZyDvOdEuxYh7jK5l@sashalap>
References: <20241029133141.45335-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241029133141.45335-1-pchelkin@ispras.ru>

On Tue, Oct 29, 2024 at 04:31:40PM +0300, Fedor Pchelkin wrote:
>BTW, a question to the stable-team: what Git magic (3-way-merge?) let the
>duplicate patch be applied successfully? The patch context in stable trees
>was different to that moment so should the duplicate have been expected to
>fail to be applied?

Just plain git... Try it yourself :)

$ git checkout 282f0a482ee6
HEAD is now at 282f0a482ee61 drm/amd/display: Skip Recompute DSC Params if no Stream on Link

$ git cherry-pick 7c887efda1
Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
[detached HEAD 2a1c937960abd] drm/amd/display: Skip Recompute DSC Params if no Stream on Link
  Author: Fangzhi Zuo <Jerry.Zuo@amd.com>
  Date: Fri Jul 12 16:30:03 2024 -0400
  1 file changed, 3 insertions(+)

$ git log -2 --oneline
2a1c937960abd (HEAD) drm/amd/display: Skip Recompute DSC Params if no Stream on Link
282f0a482ee61 drm/amd/display: Skip Recompute DSC Params if no Stream on Link

-- 
Thanks,
Sasha

