Return-Path: <stable+bounces-208090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80310D11F5A
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 112EC301F01D
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6F131AA9B;
	Mon, 12 Jan 2026 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TPG+AbAh"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED3B264609
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214424; cv=none; b=AnriCJZWBZk0V3c4rudne/iEmzb+A2vYmnegLRxO2S5R3NAwv3TcLXvV7m7aDv6N1pOba+N3VEbbzFLfFBuyjB5dbu9Wsw6yEt5YAdi+3JfrDzqXsHgim83U1d3E9A7BoWSpikxq8wbFzFSLquWMzv5AcaPWwcIRzM96VBhNcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214424; c=relaxed/simple;
	bh=DePi4Q6bHXl3MW17puoh4QbeT80ReZrEYpnLzLjJal8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RJvbDxsvYajH/liA1LM7XN1Ob/7z7b/CN5yghr876KzzFlLJuFNvRK4pZEngAYAFls5N7ShvET9FBJQN4jDvwyBIVDb3dS6zzzoyua0aI4I2UO5CY/dpXnCpPol1+oCPxfYmdNKTbxrUlFHe6INGeQ8ydsDAWXXSDraiHyQhajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TPG+AbAh; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=j7G8Ykw+xVXU/Y+bwKknohLYeS2hofhESkp1Cg8jQHM=; b=TPG+AbAh8JWq62RhEXTVN1wYqx
	d5bylRs9PmeycNB+b15qdwkzwcwax5EOeA4rrG2A8ax9B+Ndm3nqFUmdBs3U7V/SkajBYRwYVmfoP
	LW+jmTol3HzP1QteUH02pQnAPusOEnAhzV+TW8Nur1I/Ayf4rpHVgrH50DKKbwOeTbQgorVlKdEVC
	XDQtzb05MzePqu2DqgkkF4H4pjcaGTvS2aMZIfNoMt/hbxoT2tZTne1Di06Hz0SaSNhnRxPYHqUD8
	6ISXw+R/mtJA/yZwPOwo63gd0hL4YxPbPwQ19N/Ce7oysjb+JuhOO2wyHbr8lY35pl1Mb7HiySCej
	OPVNjBbQ==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vfFLE-004MDe-3Y; Mon, 12 Jan 2026 11:40:08 +0100
Message-ID: <6e89511e-3056-49ca-8de6-433e9e635921@igalia.com>
Date: Mon, 12 Jan 2026 10:40:07 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu/userq: Fix reference leak in
 amdgpu_userq_wait_ioctl
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
 <20251205134035.91551-2-tvrtko.ursulin@igalia.com>
 <562c2fcd-d99f-4072-b005-31a26f85448e@amd.com>
 <25e5c8bd-7c8e-4170-8912-45f616163013@igalia.com>
Content-Language: en-GB
In-Reply-To: <25e5c8bd-7c8e-4170-8912-45f616163013@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 05/12/2025 14:59, Tvrtko Ursulin wrote:
> 
> On 05/12/2025 14:46, Christian König wrote:
>> On 12/5/25 14:40, Tvrtko Ursulin wrote:
>>> Drop reference to syncobj and timeline fence when aborting the ioctl due
>>> output array being too small.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait 
>>> IOCTL")
>>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: <stable@vger.kernel.org> # v6.16+
>>
>> I need to double check the code when I have time, but of hand looks 
>> legitimate to me.

Gentle reminder that there is this memory leak fix pending.

>> Where are patches #3-#12 from this series?
> 
> On amd-gfx only, since 3-12 only contains cleanups I thought not pollute 
> the inboxes too much.

Should I re-send the series and copy you on all patches explicitly?

Regards,

Tvrtko
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/ 
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index eba9fb359047..13c5d4462be6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -865,6 +865,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>> *dev, void *data,
>>>                   dma_fence_unwrap_for_each(f, &iter, fence) {
>>>                       if (WARN_ON_ONCE(num_fences >= wait_info- 
>>> >num_fences)) {
>>>                           r = -EINVAL;
>>> +                        dma_fence_put(fence);
>>>                           goto free_fences;
>>>                       }
>>> @@ -889,6 +890,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>> *dev, void *data,
>>>               if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>>>                   r = -EINVAL;
>>> +                dma_fence_put(fence);
>>>                   goto free_fences;
>>>               }
>>
> 


