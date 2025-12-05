Return-Path: <stable+bounces-200171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FCACA80C4
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 15:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1B47302D64D
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4E8331236;
	Fri,  5 Dec 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OpZw7yFl"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A730E0DC
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946762; cv=none; b=oJYsaGtBZVkLtxDVUebuqYvWTtQG/bqo5Rzcg7/1SuM+TqvMIWNEjwJb0aJYvXRfnWErmbvWgTqfZf/o1AaiHxZL23gDDGdNNEGNPGpt63I+FJdXiPhAi8o002nDnonfh0aWRZ8knptzk+yD9fLrhF1NyhuhX4dDPgQtUZLAVVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946762; c=relaxed/simple;
	bh=JLWoNbTWRBPshyR5I8VfoQ9ozgNpcHp8UuGAVjZNPy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOCeh6KoYf8GOL0+oDTT+bTckIuZEduqjmUSroTmf1z0mNKea1TpmlyNoBAIJY9mzQykyYFQJDxvA3mNL2UNgy9p1U+punmmBNvy+5YTcat715+4MjIFsFBnXB1v5XoCU3BcywCyattz7w5pb/FNWMSGHFKa/Zi5M/SaziN+vc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OpZw7yFl; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/8O8y8OFGChvLHPl2IEtGRFHN+bEuHIZc5HhPicAhtQ=; b=OpZw7yFluLNXYJ3Rp3OwUiK3D4
	XaxLOm2nNqd7/ndtWzqWr6IfBGgYzUsKGuTQeFpfJoVbMdaSyB1svnpIRlnxGaF4NpnKUE6QVb6Zj
	mi15jRF6CAIYSCbI0LTYTQWFKrfS0NrrXzR/ZlYOLv/LZX+bBQ5nhGRzqOwtWM4xRXjSlZ5RLejCJ
	kp/9uMTsS2oqafEHbpHQrrfcnht3s+E3ytjigCeH0lZtxvEfJ8wOffp7SYp5vJcou8qbIxG929SjX
	XWeCeG6SacrZa2qrZck9kyoXHWG9TCsWRs/oq6y0CsxjLUo6j5E17XClRzK3q+w7aHCp7VdsV79gT
	9LDnI4VQ==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vRXGz-0097LY-Ri; Fri, 05 Dec 2025 15:59:05 +0100
Message-ID: <25e5c8bd-7c8e-4170-8912-45f616163013@igalia.com>
Date: Fri, 5 Dec 2025 14:59:04 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu/userq: Fix reference leak in
 amdgpu_userq_wait_ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
 <20251205134035.91551-2-tvrtko.ursulin@igalia.com>
 <562c2fcd-d99f-4072-b005-31a26f85448e@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <562c2fcd-d99f-4072-b005-31a26f85448e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 05/12/2025 14:46, Christian König wrote:
> On 12/5/25 14:40, Tvrtko Ursulin wrote:
>> Drop reference to syncobj and timeline fence when aborting the ioctl due
>> output array being too small.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: <stable@vger.kernel.org> # v6.16+
> 
> I need to double check the code when I have time, but of hand looks legitimate to me.
> 
> Where are patches #3-#12 from this series?

On amd-gfx only, since 3-12 only contains cleanups I thought not pollute 
the inboxes too much.

Regards,

Tvrtko

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index eba9fb359047..13c5d4462be6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -865,6 +865,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   				dma_fence_unwrap_for_each(f, &iter, fence) {
>>   					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>>   						r = -EINVAL;
>> +						dma_fence_put(fence);
>>   						goto free_fences;
>>   					}
>>   
>> @@ -889,6 +890,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   
>>   			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>>   				r = -EINVAL;
>> +				dma_fence_put(fence);
>>   				goto free_fences;
>>   			}
>>   
> 


