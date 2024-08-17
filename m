Return-Path: <stable+bounces-69384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A74795566F
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 10:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E5A1C20DBB
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BE7144D01;
	Sat, 17 Aug 2024 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jrf2ipw+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715AA224D1;
	Sat, 17 Aug 2024 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723884174; cv=none; b=TqmRYJp7JUzg1C+AXhoQnoQ2nqm+Oet1nMWY60OXPe3qK98egLHKfQ+dOTGgxCrR4eal7zmL2qSztdPXN5JhZ6mavGcJQOQaZAIPG9a/ZNN2J2gdMBl7DPqW2TkvgBM58tedp+UOtUnt+oXZv7CYaWgQBYU0o03JdDGdkQvvLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723884174; c=relaxed/simple;
	bh=wCPDpgJU3wZjcbdksuUtn6o6BHEmcbYJwksedTAOdnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqkp+tRfGM4DqjLDNl+DzJ0RAII7TQ+2CCHrndElI+ej0xZdJpiP6vFYstrcgHdMVQZUzf0zmjnA011keeKEoqvvXD4Dr9apczbFrzbpO16mDIt1ezPwi9CiivZFkyJo2/yApVLVvxw/l0pHki4AB7pf4NI9fj0ZJnWxAiLC3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jrf2ipw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765E7C116B1;
	Sat, 17 Aug 2024 08:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723884173;
	bh=wCPDpgJU3wZjcbdksuUtn6o6BHEmcbYJwksedTAOdnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrf2ipw+XP2hHIoE9izV0sNQF5Nl4z321jHbyn0zWZPoZqPL1LR02dn/0ycdsYPSK
	 hNCp7UJ6cf+jtTaAIWFzs5JOehixXWZND8OCkVRRgV5H22njOjNNr5IZJwcoZ78M21
	 fESXQWNCsepCSQQsZRxrfoW/kfbb/ovifwsYjtxo=
Date: Sat, 17 Aug 2024 10:42:51 +0200
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
Message-ID: <2024081739-suburb-manor-e6c3@gregkh>
References: <20240730185339.543359-1-kevin@holm.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730185339.543359-1-kevin@holm.dev>

On Tue, Jul 30, 2024 at 08:53:39PM +0200, Kevin Holm wrote:
> From: Wayne Lin <wayne.lin@amd.com>
> 
> [ Upstream commit fa57924c76d995e87ca3533ec60d1d5e55769a27 ]
> 
> [Why]
> dm_dp_mst_is_port_support_mode() is a bit not following the original design rule and cause
> light up issue with multiple 4k monitors after mst dsc hub.
> 
> [How]
> Refactor function dm_dp_mst_is_port_support_mode() a bit to solve the light up issue.
> 
> Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
> Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
> Signed-off-by: Wayne Lin <wayne.lin@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> [kevin@holm.dev: Resolved merge conflict in .../amdgpu_dm_mst_types.c]
> Fixes: 4df96ba6676034 ("drm/amd/display: Add timing pixel encoding for mst mode validation")
> Link: https://lore.kernel.org/stable/d74a7768e957e6ce88c27a5bece0c64dff132e24@holm.dev/T/#u
> Signed-off-by: Kevin Holm <kevin@holm.dev>
> ---
> I resolved the merge conflict so that, after this patch is applied to the
> linux-6.10.y branch of the stable git repository, the resulting function
> dm_dp_mst_is_port_support_mode (and also the new function 
> dp_get_link_current_set_bw) is identical to the original commit.
> 
> I've confirmed that it fixes the regression I reported for my use case.

And it turns out this change breaks the arm and arm64 builds.  I tried
to fix it up by applying the fixup afterward for this file, but it's
just too much of a mess to unwind this, so I'm going to have to revert
this now, sorry.

See:
	https://lore.kernel.org/r/b27c5434-f1b1-4697-985b-91bb3e9a22df@roeck-us.net
for details.

greg k-h

