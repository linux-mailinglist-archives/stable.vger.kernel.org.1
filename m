Return-Path: <stable+bounces-64653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A27B941EEA
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB241F240C4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B5C18991F;
	Tue, 30 Jul 2024 17:37:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C56189503;
	Tue, 30 Jul 2024 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722361028; cv=none; b=X6NW20ilHwphOVaihIIpHDF5P7trsvt4eV6TNKtZgnmeNvWv1vIsvwZzo3XC6waf8ZKJVjQt7JnIYdLAjm1XXxPq54LIPzBlEEgor7T1Tphs9MAnYzxuosdU/7aBElBabruBC+tojPaHF3cIQHx0e1wQXZ681+xn/aiqPjvtFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722361028; c=relaxed/simple;
	bh=uMR8IFBYVi7FGt1EqN9nqUOCXPRCq+EEfHfhXrxYe7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jmxBKE0/h9fyGGnwpsFm+Rre+GThjb2hFVxo2x3o2eJGGgSmPuighFNu4ZafEzCUd01Y4x7ILtsN023DBdojz4e8Hsn0eWq/OBqFm71SpFPwZ+yI+6lR6JglPouecV2Aiiz+oKtzB38mD42WwEBwXS4RfdI5+trydGQ/N8HdVuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 30 Jul
 2024 20:36:55 +0300
Received: from [192.168.211.130] (10.0.253.138) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 30 Jul
 2024 20:36:55 +0300
Message-ID: <158d9e56-d8af-4d0f-980c-4355639f6ff8@fintech.ru>
Date: Tue, 30 Jul 2024 10:36:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon/evergreen_cs: fix int overflow errors in cs
 track offsets
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
	<alexdeucher@gmail.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, "Jerome
 Glisse" <jglisse@redhat.com>, Dave Airlie <airlied@redhat.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<stable@vger.kernel.org>
References: <20240725180950.15820-1-n.zhandarovich@fintech.ru>
 <e5199bf0-0861-4b79-8f32-d14a784b116f@amd.com>
 <CADnq5_PuzU12x=M09HaGkG7Yqg8Lk1M1nWDAut7iP09TT33D6g@mail.gmail.com>
 <fb530f45-df88-402a-9dc0-99298b88754c@amd.com>
 <e497f5cb-a3cb-477b-8947-f96276e401b7@fintech.ru>
 <1914cfcb-9700-4274-8120-9746e241cb54@amd.com>
 <cb85a5c1-526b-4024-8e8f-23c2fe0d8381@amd.com>
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
In-Reply-To: <cb85a5c1-526b-4024-8e8f-23c2fe0d8381@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)



On 7/29/24 11:12, Christian König wrote:
> Am 29.07.24 um 20:04 schrieb Christian König:
>> Am 29.07.24 um 19:26 schrieb Nikita Zhandarovich:
>>> Hi,
>>>
>>> On 7/29/24 02:23, Christian König wrote:
>>>> Am 26.07.24 um 14:52 schrieb Alex Deucher:
>>>>> On Fri, Jul 26, 2024 at 3:05 AM Christian König
>>>>> <christian.koenig@amd.com> wrote:
>>>>>> Am 25.07.24 um 20:09 schrieb Nikita Zhandarovich:
>>>>>>> Several cs track offsets (such as 'track->db_s_read_offset')
>>>>>>> either are initialized with or plainly take big enough values that,
>>>>>>> once shifted 8 bits left, may be hit with integer overflow if the
>>>>>>> resulting values end up going over u32 limit.
>>>>>>>
>>>>>>> Some debug prints take this into account (see according
>>>>>>> dev_warn() in
>>>>>>> evergreen_cs_track_validate_stencil()), even if the actual
>>>>>>> calculated value assigned to local 'offset' variable is missing
>>>>>>> similar proper expansion.
>>>>>>>
>>>>>>> Mitigate the problem by casting the type of right operands to the
>>>>>>> wider type of corresponding left ones in all such cases.
>>>>>>>
>>>>>>> Found by Linux Verification Center (linuxtesting.org) with static
>>>>>>> analysis tool SVACE.
>>>>>>>
>>>>>>> Fixes: 285484e2d55e ("drm/radeon: add support for evergreen/ni
>>>>>>> tiling informations v11")
>>>>>>> Cc: stable@vger.kernel.org
>>>>>> Well first of all the long cast doesn't makes the value 64bit, it
>>>>>> depends on the architecture.
>>>>>>
>>>>>> Then IIRC the underlying hw can only handle a 32bit address space so
>>>>>> having the offset as long is incorrect to begin with.
>>>>> Evergreen chips support a 36 bit internal address space and NI and
>>>>> newer support a 40 bit one, so this is applicable.
>>>> In that case I strongly suggest that we replace the unsigned long with
>>>> u64 or otherwise we get different behavior on 32 and 64bit machines.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>> To be clear, I'll prepare v2 patch that changes 'offset' to u64 as well
>>> as the cast of 'track->db_z_read_offset' (and the likes) to u64 too.
>>>
>>> On the other note, should I also include casting to wider type of the
>>> expression surf.layer_size * mslice (example down below) in
>>> evergreen_cs_track_validate_cb() and other similar functions? I can't
>>> properly gauge if the result will definitively fit into u32, maybe it
>>> makes sense to expand it as well?
>>
>> The integer overflows caused by shifts are irrelevant and doesn't need
>> any fixing in the first place.
> 
> Wait a second.
> 
> Thinking more about it the integer overflows are actually necessary
> because that is exactly what happens in the hardware as well.
> 
> If you don't overflow those shifts you actually create a security
> problem because the HW the might access at a different offset then you
> calculated here.
> 
> We need to use something like a mask or use lower_32_bits() here.

Christian,

My apologies, I may be getting a bit confused here.

If integer overflows caused by shifts are predictable and constitute
normal behavior in this case, and there is no need to "fix" them, does
it still make sense to use any mitigations at all, i.e. masks or macros?
Leaving these shifts to u32 variables as they are now will achieve the
same result as, for example, doing something along the lines of:

offset = lower_32_bits((u64)track->cb_color_bo_offset[id] << 8);

which seems clunky and unnecessary, even if it suppresses some static
analyzer triggers (and that seems overboard).
Or am I missing something obvious here?
> 
> Regards,
> Christian.
> 
>>
>> The point is rather that we need to avoid multiplication overflows and
>> the security problems which come with those.
>>
>>>
>>> 441         }
>>> 442
>>> 443         offset += surf.layer_size * mslice;
>>
>> In other words that here needs to be validated correctly.
>>

Agreed, I think either casting right operand to u64 (once 'offset' is
also changed from unsigned long to u64) or using mul_u32_u32() here and
in other places should suffice.

>> Regards,
>> Christian.
>>
>>> 444         if (offset > radeon_bo_size(track->cb_color_bo[id])) {
>>> 445                 /* old ddx are broken they allocate bo with w*h*bpp
>>>
>>> Regards,
>>> Nikita
>>>>> Alex
>>>>>
>>>>>> And finally that is absolutely not material for stable.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>>>>>>> ---
>>>>>>> P.S. While I am not certain that track->cb_color_bo_offset[id]
>>>>>>> actually ends up taking values high enough to cause an overflow,
>>>>>>> nonetheless I thought it prudent to cast it to ulong as well.
>>>>>>>
>>>>>>>     drivers/gpu/drm/radeon/evergreen_cs.c | 18 +++++++++---------
>>>>>>>     1 file changed, 9 insertions(+), 9 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c
>>>>>>> b/drivers/gpu/drm/radeon/evergreen_cs.c
>>>>>>> index 1fe6e0d883c7..d734d221e2da 100644
>>>>>>> --- a/drivers/gpu/drm/radeon/evergreen_cs.c
>>>>>>> +++ b/drivers/gpu/drm/radeon/evergreen_cs.c
>>>>>>> @@ -433,7 +433,7 @@ static int evergreen_cs_track_validate_cb(struct
>>>>>>> radeon_cs_parser *p, unsigned i
>>>>>>>                 return r;
>>>>>>>         }
>>>>>>>
>>>>>>> -     offset = track->cb_color_bo_offset[id] << 8;
>>>>>>> +     offset = (unsigned long)track->cb_color_bo_offset[id] << 8;
>>>>>>>         if (offset & (surf.base_align - 1)) {
>>>>>>>                 dev_warn(p->dev, "%s:%d cb[%d] bo base %ld not
>>>>>>> aligned with %ld\n",
>>>>>>>                          __func__, __LINE__, id, offset,
>>>>>>> surf.base_align);
>>>>>>> @@ -455,7 +455,7 @@ static int evergreen_cs_track_validate_cb(struct
>>>>>>> radeon_cs_parser *p, unsigned i
>>>>>>>                                 min = surf.nby - 8;
>>>>>>>                         }
>>>>>>>                         bsize =
>>>>>>> radeon_bo_size(track->cb_color_bo[id]);
>>>>>>> -                     tmp = track->cb_color_bo_offset[id] << 8;
>>>>>>> +                     tmp = (unsigned
>>>>>>> long)track->cb_color_bo_offset[id] << 8;
>>>>>>>                         for (nby = surf.nby; nby > min; nby--) {
>>>>>>>                                 size = nby * surf.nbx * surf.bpe *
>>>>>>> surf.nsamples;
>>>>>>>                                 if ((tmp + size * mslice) <=
>>>>>>> bsize) {
>>>>>>> @@ -476,10 +476,10 @@ static int
>>>>>>> evergreen_cs_track_validate_cb(struct radeon_cs_parser *p,
>>>>>>> unsigned i
>>>>>>>                         }
>>>>>>>                 }
>>>>>>>                 dev_warn(p->dev, "%s:%d cb[%d] bo too small (layer
>>>>>>> size %d, "
>>>>>>> -                      "offset %d, max layer %d, bo size %ld, slice
>>>>>>> %d)\n",
>>>>>>> +                      "offset %ld, max layer %d, bo size %ld, slice
>>>>>>> %d)\n",
>>>>>>>                          __func__, __LINE__, id, surf.layer_size,
>>>>>>> -                     track->cb_color_bo_offset[id] << 8, mslice,
>>>>>>> - radeon_bo_size(track->cb_color_bo[id]), slice);
>>>>>>> +                     (unsigned long)track->cb_color_bo_offset[id]
>>>>>>> << 8,
>>>>>>> +                     mslice,
>>>>>>> radeon_bo_size(track->cb_color_bo[id]), slice);
>>>>>>>                 dev_warn(p->dev, "%s:%d problematic surf: (%d %d)
>>>>>>> (%d
>>>>>>> %d %d %d %d %d %d)\n",
>>>>>>>                          __func__, __LINE__, surf.nbx, surf.nby,
>>>>>>>                         surf.mode, surf.bpe, surf.nsamples,
>>>>>>> @@ -608,7 +608,7 @@ static int
>>>>>>> evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
>>>>>>>                 return r;
>>>>>>>         }
>>>>>>>
>>>>>>> -     offset = track->db_s_read_offset << 8;
>>>>>>> +     offset = (unsigned long)track->db_s_read_offset << 8;
>>>>>>>         if (offset & (surf.base_align - 1)) {
>>>>>>>                 dev_warn(p->dev, "%s:%d stencil read bo base %ld not
>>>>>>> aligned with %ld\n",
>>>>>>>                          __func__, __LINE__, offset,
>>>>>>> surf.base_align);
>>>>>>> @@ -627,7 +627,7 @@ static int
>>>>>>> evergreen_cs_track_validate_stencil(struct radeon_cs_parser *p)
>>>>>>>                 return -EINVAL;
>>>>>>>         }
>>>>>>>
>>>>>>> -     offset = track->db_s_write_offset << 8;
>>>>>>> +     offset = (unsigned long)track->db_s_write_offset << 8;
>>>>>>>         if (offset & (surf.base_align - 1)) {
>>>>>>>                 dev_warn(p->dev, "%s:%d stencil write bo base %ld
>>>>>>> not
>>>>>>> aligned with %ld\n",
>>>>>>>                          __func__, __LINE__, offset,
>>>>>>> surf.base_align);
>>>>>>> @@ -706,7 +706,7 @@ static int
>>>>>>> evergreen_cs_track_validate_depth(struct radeon_cs_parser *p)
>>>>>>>                 return r;
>>>>>>>         }
>>>>>>>
>>>>>>> -     offset = track->db_z_read_offset << 8;
>>>>>>> +     offset = (unsigned long)track->db_z_read_offset << 8;
>>>>>>>         if (offset & (surf.base_align - 1)) {
>>>>>>>                 dev_warn(p->dev, "%s:%d stencil read bo base %ld not
>>>>>>> aligned with %ld\n",
>>>>>>>                          __func__, __LINE__, offset,
>>>>>>> surf.base_align);
>>>>>>> @@ -722,7 +722,7 @@ static int
>>>>>>> evergreen_cs_track_validate_depth(struct radeon_cs_parser *p)
>>>>>>>                 return -EINVAL;
>>>>>>>         }
>>>>>>>
>>>>>>> -     offset = track->db_z_write_offset << 8;
>>>>>>> +     offset = (unsigned long)track->db_z_write_offset << 8;
>>>>>>>         if (offset & (surf.base_align - 1)) {
>>>>>>>                 dev_warn(p->dev, "%s:%d stencil write bo base %ld
>>>>>>> not
>>>>>>> aligned with %ld\n",
>>>>>>>                          __func__, __LINE__, offset,
>>>>>>> surf.base_align);
>>
> 

