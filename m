Return-Path: <stable+bounces-83221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CB0996CC9
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8954C28161C
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F349819924E;
	Wed,  9 Oct 2024 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b="SG17PTYf";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="M1wTx2Sc"
X-Original-To: stable@vger.kernel.org
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EBB38DE5;
	Wed,  9 Oct 2024 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.152.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482031; cv=none; b=A+xHGW+2gopcWkq4LeWiRukBK/If7OKWaQAFr4vGD2rxI7Gvt83ZtzNm38OvMwAaMVx+0k9onKNWgvNxIoB21Vx+bBYO+jR+6+24DGe48ZjNHmLSjdvDltrivFHLdFHShrpNjFx1Mr3TO7B9qOSYiEpsVF/Ffy2sSrj20RpIWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482031; c=relaxed/simple;
	bh=5XpzL+C41ruwKeHQeQXScxtkrBTKWe8j/b804iT3pfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8oWXZnCUXmErrPoX2QghwbNeFYOsTqDYdKvE+JqgvqKeAtwjXtw3F6iadrCS2NK2HoRT9O21tVcieBy1ePzHfGhRM6bkQsOZE0BizoU3E9W+u50jvN1ET9ElTPpFJYVYXxEmN4hAOG/H+8x+d7MgN5LxKoCmIm/NNf23qd2OHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=damsy.net; spf=pass smtp.mailfrom=damsy.net; dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b=SG17PTYf; dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b=M1wTx2Sc; arc=none smtp.client-ip=51.159.152.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=damsy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damsy.net
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1728481940; bh=y3vCb8lJ1Emv2BjETJYSa0m
	f3wOwiCfAIlM3SGQVcTU=; b=SG17PTYfsJLrf+a9nco/vi8u78T2X/Us3sBVLRhbu4IIcfUY5H
	yUkt7o3D5dLXXt27SvzEnc97pk3iUzfxfn1kkGnf9zmvcHijMw1y7Ss5XO3O5J8FwkcO/6M9rcx
	t4wqkyPi/cgKJ6eOcJaY2JGRSEDwcugdNKeaQHIIb8Iqd2i3jrwjZyKG8XmmqFf4tcjB/3H0fxY
	LCcL1hW0Ordt/a5wfbKfmFpbz/JCsJ2wrH+yMzjz1o9mmjATA7tcF8PH3MGfcU4UkMXtQ/pPCiT
	qHjEppVY6e8A98DRLfJID8o6BGrPP3Aar7cXy7LBbdbK2NwUBkXUopIIFjTI5oJ0UTg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1728481940; bh=y3vCb8lJ1Emv2BjETJYSa0m
	f3wOwiCfAIlM3SGQVcTU=; b=M1wTx2ScrOP5wwUz4o7ImRLQ7lmcSGBc/71hYvs1Xz499ga30L
	0ZY5s7SPIMlOilFB4Cq0LwdubBT5Z4L5w5CA==;
Message-ID: <dc319be0-af47-4053-bdd2-8a4d53ec4679@damsy.net>
Date: Wed, 9 Oct 2024 15:52:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: prevent BO_HANDLES error from being
 overwritten
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mohammed Anees <pvmohammedanees2003@gmail.com>, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch,
 srinivasan.shanmugam@amd.com, David.Wu3@amd.com, felix.kuehling@amd.com,
 YuanShang.Mao@amd.com, pierre-eric.pelloux-prayer@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241009122831.109809-1-pvmohammedanees2003@gmail.com>
 <6426b779-bd4d-4c85-b99d-4ddedf75d837@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <6426b779-bd4d-4c85-b99d-4ddedf75d837@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the updated patch, looks good to me.

Le 09/10/2024 à 14:31, Christian König a écrit :
> Am 09.10.24 um 14:28 schrieb Mohammed Anees:
>> Before this patch, if multiple BO_HANDLES chunks were submitted,
>> the error -EINVAL would be correctly set but could be overwritten
>> by the return value from amdgpu_cs_p1_bo_handles(). This patch
>> ensures that if there are multiple BO_HANDLES, we stop.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: fec5f8e8c6bc ("drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit")
>> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> @Pierre-Eric can you pick that one up and push to amd-staging-drm-next?
> 
> Alex is currently on XDC and I'm a bit busy as well.

Sure, will do.

Pierre-Eric

> 
> Thanks,
> Christian.
> 
>> ---
>> v2:
>> - Switched to goto free_partial_kdata for error handling, following the existing pattern.
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 1e475eb01417..d891ab779ca7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -265,7 +265,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>>               /* Only a single BO list is allowed to simplify handling. */
>>               if (p->bo_list)
>> -                ret = -EINVAL;
>> +                goto free_partial_kdata;
>>               ret = amdgpu_cs_p1_bo_handles(p, p->chunks[i].kdata);
>>               if (ret)


