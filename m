Return-Path: <stable+bounces-69961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F1195CC63
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36AE1F23965
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 12:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457D318595F;
	Fri, 23 Aug 2024 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgYMYihx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41CB185945;
	Fri, 23 Aug 2024 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416394; cv=none; b=g3WmKuvS8f8Sm+hcou4y6rHfJzMl0mh6cyUYwrz78E6Yoi/pOcZTJv7P2kGmWjrT9RuxSBSd1AdHCPZHsxgVPwuXl1zJAYuejqjyic6XMFNzknsaTm6bgfHDmSRjNZ4LDAPJejSUHlIJWnhZUcxCLrv+KTMS1s5aqtP4qQmhfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416394; c=relaxed/simple;
	bh=/87uSqfnsq+m+pDh8WSFxekdTCnHE0BI0MQdveNkb34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGAe9l4zBQOh5JTwcNg2mX15POh6o+Xu1are+isyRb0UXdi52GqPJzfbtq8yNW8152Jk9/c8GQr1SWDOBp8odKs5dXQkQ2Az4d6SyttRqPE9sHyNBh9l9cUO3Es/ubGPh4kB6m1FwM1zpbbOsEtlSaJw3di9p/flmCRyxs1MNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgYMYihx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C943C4AF0B;
	Fri, 23 Aug 2024 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724416393;
	bh=/87uSqfnsq+m+pDh8WSFxekdTCnHE0BI0MQdveNkb34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgYMYihx+vCtlkh8mKPX6zZJiwiXd5YehZ2hP1eI6Q/EFPKuNuHdYiCaJ2+eMjoJY
	 LHZJJF7piz/5JQU/Dyb3hAdBSE02qDGYF+GSPDuPAd7CtnbN9LBCx0mbqpCBCTQ1f3
	 JOJF6C7UrZYXeyyYgjAgqCQ+O2YU55yCiK3dHH4dtaD34CdzHHTiufP3ioyaedA0Dq
	 Cnpa3/aHLmG34lwdcPRNh0vuqz3qEgcbLkVKrYe6fHcHJDnks2KwXLYiBwLom9RUZP
	 gbQJJ5GJAJTEjXifnohnzw4Vh0hhi7bCboDvZFp0Wwsn0amm3lnu3BIWolSQkxudcu
	 Zdz1Ke1OKg1XQ==
Date: Fri, 23 Aug 2024 08:33:12 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	"Xiao, Jack" <Jack.Xiao@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: Patch "drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET v2" has been added to the 6.6-stable tree
Message-ID: <ZsiBiPGhPXm3ooXz@sashalap>
References: <20240821133314.1666552-1-sashal@kernel.org>
 <BL1PR12MB51448BBFAAEAF8FE20E33B61F78E2@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51448BBFAAEAF8FE20E33B61F78E2@BL1PR12MB5144.namprd12.prod.outlook.com>

On Wed, Aug 21, 2024 at 03:56:53PM +0000, Deucher, Alexander wrote:
>[Public]
>
>> -----Original Message-----
>> From: Sasha Levin <sashal@kernel.org>
>> Sent: Wednesday, August 21, 2024 9:33 AM
>> To: stable-commits@vger.kernel.org; Xiao, Jack <Jack.Xiao@amd.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
>> Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>
>> Subject: Patch "drm/amdgpu/gfx11: need acquire mutex before access
>> CP_VMID_RESET v2" has been added to the 6.6-stable tree
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>     drm/amdgpu/gfx11: need acquire mutex before access CP_VMID_RESET v2
>>
>> to the 6.6-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-
>> queue.git;a=summary
>>
>> The filename of the patch is:
>>      drm-amdgpu-gfx11-need-acquire-mutex-before-access-cp.patch
>> and it can be found in the queue-6.6 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree, please let
>> <stable@vger.kernel.org> know about it.
>>
>
>This patch is not stable material.  Please drop for stable.

Will do, thanks!

-- 
Thanks,
Sasha

