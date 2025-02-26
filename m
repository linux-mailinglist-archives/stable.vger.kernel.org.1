Return-Path: <stable+bounces-119622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E3A4569F
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 08:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3093A5480
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 07:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59E333997;
	Wed, 26 Feb 2025 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="PcDHjRNC"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC96268684;
	Wed, 26 Feb 2025 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740554870; cv=none; b=bUEmaRzcdLUjZoToMnUyRIe2aJStRcXFuTBji+WD4sLPodI3VeQI/FjsWkiYjlo/wGLUR1M3Pxj+x8q83DR3+UgvMlHLLB1Ze6nvONtHuQ4WbMst0h/0/nWvP4brgpgmdT1lU+0/sUreE9dvtzSMykDi8RQWr+cLUgPsDQM2LX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740554870; c=relaxed/simple;
	bh=FVZ11zz+9uMRbbgoxc9G6ohf2abrzH5GaK9fKCvKprQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cF8aUfrhhlBc8tmy5tXqa9MRVI2YN7+v/ysVwOTnbsCTwhj0ULKp2A8gmjpU7LiVO0Mc3cnNdxGE7yqnY6c7Olhf1LJoIhOlY9KLPgCsh6jUnYBSUZwG6RFo6VqoAorVsL2PVnvq+Go/uMAUE9065mLRlCV0e1tCgBttlDT9kik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=PcDHjRNC; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.155])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id E2CAF200C2;
	Wed, 26 Feb 2025 07:27:46 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id 0F4D020318;
	Wed, 26 Feb 2025 07:27:39 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id CBED040078;
	Wed, 26 Feb 2025 07:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1740554856; bh=FVZ11zz+9uMRbbgoxc9G6ohf2abrzH5GaK9fKCvKprQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PcDHjRNCSaB/5RifTNhwEwK0UxD0FvPgDPXQyvkDV88Du6AnI92/pD2OZl5aJR9k4
	 skHB9tc3hj22PnOUTEiPCuPXdDB2B2JgybvH2m41SCbSM6d1W+I7h/6lpvro/enS0y
	 eeGVtPp3+4ExDLlrxzE29PMWRVirCCl1kWsa9aU4=
Received: from [172.29.0.1] (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0C53840CEA;
	Wed, 26 Feb 2025 07:27:27 +0000 (UTC)
Message-ID: <c9eb3743-cd41-4ef6-bb8b-19d049edc312@aosc.io>
Date: Wed, 26 Feb 2025 15:27:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/xe/query: use PAGE_SIZE as the minimum page
 alignment
To: Matthew Brost <matthew.brost@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
 Francois Dugast <francois.dugast@intel.com>,
 Alan Previn <alan.previn.teres.alexis@intel.com>,
 Zhanjun Dong <zhanjun.dong@intel.com>, Matt Roper
 <matthew.d.roper@intel.com>, Mateusz Naklicki <mateusz.naklicki@intel.com>,
 Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>,
 =?UTF-8?Q?Zbigniew_Kempczy=C5=84ski?= <zbigniew.kempczynski@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>,
 Shang Yatsen <429839446@qq.com>, stable@vger.kernel.org,
 Haien Liang <27873200@qq.com>, Shirong Liu <lsr1024@qq.com>,
 Haofeng Wu <s2600cw2@126.com>
References: <20250226-xe-non-4k-fix-v1-0-80f23b5ee40e@aosc.io>
 <20250226-xe-non-4k-fix-v1-5-80f23b5ee40e@aosc.io>
 <Z76b3lgScK2gbtnG@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <Z76b3lgScK2gbtnG@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CBED040078
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[jeffbai.aosc.io:server fail,27873200.qq.com:server fail,stable.vger.kernel.org:server fail,lsr1024.qq.com:server fail,429839446.qq.com:server fail];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,aosc.io,qq.com,126.com];
	FREEMAIL_ENVRCPT(0.00)[126.com,gmail.com,qq.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



在 2025/2/26 12:43, Matthew Brost 写道:
> On Wed, Feb 26, 2025 at 10:00:22AM +0800, Mingcong Bai via B4 Relay wrote:
>> From: Mingcong Bai <jeffbai@aosc.io>
>>
>> As this component hooks into userspace API, it should be assumed that it
>> will play well with non-4K/64K pages.
>>
>> Use `PAGE_SIZE' as the final reference for page alignment instead.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>> Fixes: 801989b08aff ("drm/xe/uapi: Make constant comments visible in kernel doc")
>> Tested-by: Mingcong Bai <jeffbai@aosc.io>
>> Tested-by: Haien Liang <27873200@qq.com>
>> Tested-by: Shirong Liu <lsr1024@qq.com>
>> Tested-by: Haofeng Wu <s2600cw2@126.com>
>> Link: https://github.com/FanFansfan/loongson-linux/commit/22c55ab3931c32410a077b3ddb6dca3f28223360
>> Co-developed-by: Shang Yatsen <429839446@qq.com>
>> Signed-off-by: Shang Yatsen <429839446@qq.com>
>> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
>> ---
>>   drivers/gpu/drm/xe/xe_query.c | 2 +-
>>   include/uapi/drm/xe_drm.h     | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
>> index c059639613f7b548c168f808b7b7b354f1cf3c94..8a017c526942d1f2b401e8b9a4244e6083d7b1e5 100644
>> --- a/drivers/gpu/drm/xe/xe_query.c
>> +++ b/drivers/gpu/drm/xe/xe_query.c
>> @@ -336,7 +336,7 @@ static int query_config(struct xe_device *xe, struct drm_xe_device_query *query)
>>   		config->info[DRM_XE_QUERY_CONFIG_FLAGS] =
>>   			DRM_XE_QUERY_CONFIG_FLAG_HAS_VRAM;
>>   	config->info[DRM_XE_QUERY_CONFIG_MIN_ALIGNMENT] =
>> -		xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K ? SZ_64K : SZ_4K;
>> +		xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K ? SZ_64K : PAGE_SIZE;
> 
> We should probably assert or build a bug somewhere to ensure SZ_64K >=
> PAGE_SIZE for future-proofing. Otherwise, I think the patch makes sense.
> One more comment below.

Hmm, >= 64KiB kernel pages don't seem to be a thing yet but this does 
make sense for the sake of completeness. Will change in v2.

> 
>>   	config->info[DRM_XE_QUERY_CONFIG_VA_BITS] = xe->info.va_bits;
>>   	config->info[DRM_XE_QUERY_CONFIG_MAX_EXEC_QUEUE_PRIORITY] =
>>   		xe_exec_queue_device_get_max_priority(xe);
>> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
>> index f62689ca861a4673b885629460c11d6f3bc6523d..db7cf904926ebd6789a29d620161ac051e59f13f 100644
>> --- a/include/uapi/drm/xe_drm.h
>> +++ b/include/uapi/drm/xe_drm.h
>> @@ -394,7 +394,7 @@ struct drm_xe_query_mem_regions {
>>    *    - %DRM_XE_QUERY_CONFIG_FLAG_HAS_VRAM - Flag is set if the device
>>    *      has usable VRAM
>>    *  - %DRM_XE_QUERY_CONFIG_MIN_ALIGNMENT - Minimal memory alignment
>> - *    required by this device, typically SZ_4K or SZ_64K
>> + *    required by this device, typically PAGE_SIZE.
> 
> So I think the kernel doc needs bit more updating here, how about:
> 
> Minimal memory alignment required by this device and the CPU. The
> minimum page size for the device is usually SZ_4K or SZ_64K, while for
> the CPU, it is PAGE_SIZE. This value is calculated by
> max(min_gpu_page_size, PAGE_SIZE). This alignment is enforced on
> buffer object allocations and VM binds.
> 
> Again welcome others CC'd suggestion on this updated kernel doc.

Looks good to me, will revise in v2.

Best Regards,
Mingcong Bai

> 
> Matt
> 
>>    *  - %DRM_XE_QUERY_CONFIG_VA_BITS - Maximum bits of a virtual address
>>    *  - %DRM_XE_QUERY_CONFIG_MAX_EXEC_QUEUE_PRIORITY - Value of the highest
>>    *    available exec queue priority
>>
>> -- 
>> 2.48.1
>>
>>


