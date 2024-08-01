Return-Path: <stable+bounces-65246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE00944EF4
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1365E1F23843
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 15:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36113BC2F;
	Thu,  1 Aug 2024 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="juBQ5Auu"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41B1369AE
	for <stable@vger.kernel.org>; Thu,  1 Aug 2024 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525479; cv=none; b=jePTm4honWmvD2X5DVbH+DOb8s5onx4jXDKSuxUqxSeSVaPM2XZZ2mKS4QbCxBFeqcu5TdLcddDqJUonquxvLzYARq/44ZZnT+W5jU0YDORCOadDiO3NmPlzFSe8k3WBdsMVVy0IbZwzYUyE+GiH00Zf+2xp0fiQ0MbdjncMbPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525479; c=relaxed/simple;
	bh=BGVJPebnq8UwEOe9CaxzMtb96nncel6ZuVxq0Oxfjdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPwgq7dO55fD4x2Kq2r2dcxWuO1grAfQoV8lr1CwQ13WconBFGcr5Mkt0ksQJwEPCe/hwzPyk6fqsnfQh41C/Kib86d4K7m0e3Azrdj59AHKsbTGq8g2y+akpuDzLLqcgnICF6jFmRk9s6jqginRjy9ipdO0IFDZBebHobkmuc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b=juBQ5Auu; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1722525455; x=1723130255; i=friedrich.vock@gmx.de;
	bh=BGVJPebnq8UwEOe9CaxzMtb96nncel6ZuVxq0Oxfjdk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=juBQ5Auu6bzKuxOBAIAb/9o94BimCz45q2Eq19N1D6C7i1MWXng30D0BRKQ2xwXT
	 3R7bn/pDBhc+Xct/0SUyfO8+FuoxIFeUWeTOM/E5PH3XxYRnGL6HWBYVpazf+yYo/
	 wUVojFW+ZBpe+v+dL8sAv2kZRs7f4xVtZCSXixJLqvTchY8S4QUQW2Ay2hmv6m6ST
	 RrU1dfEkEXYAk8PhDMMe9PFctxc9goy0I7W5Qxrk1lnTay5bPHarfgKbtcwRCuUEf
	 cHKd5w91wx1Vgivw6/fXYamGTdKs8Pf+2bXXd8UGmxVbyJILp1bfLJCQdo5fgSuAC
	 yt4lQ0lGj7EyYmSAng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.114.245]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1sTCRU1e6p-008uFA; Thu, 01
 Aug 2024 17:17:35 +0200
Message-ID: <641ce39c-a6a6-4448-bb2a-9c12d2873c1c@gmx.de>
Date: Thu, 1 Aug 2024 17:17:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Forward soft recovery errors to userspace
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org,
 "Olsak, Marek" <Marek.Olsak@amd.com>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
References: <20240307190447.33423-1-joshua@froggi.es>
 <d9632885-35da-4e4a-b952-2b6a0c38c35b@amd.com>
Content-Language: en-US
From: Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <d9632885-35da-4e4a-b952-2b6a0c38c35b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nTvKfMWnEvLQDe4yB1AZcdH5YcD3YIM3gAFv9uO57UybLg2FahP
 5NyA8tkBsks/haeG+uXfbz4UDtJzWThrclSG1NEgjF4q02xkyf2NEj+2Iih9UbqviHatM3x
 bJLMwx9tcF7hIfFPVPzTBJ8GMih47FFQDjcgsZ4eeppwLDwQABys8FzhV0LyQarVvWOzsgw
 Q4VMOcu1avIIJdsY/PDsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jmEL+whHZxY=;OL0ECRSvzzyzvKprZ7tBVwuh9h0
 abR6gk4L9IvBSyL3JS3h4972xHcH4x0UksA+T+jXZeo/BGr9/6T3zYAKanWsqjy0ls310XkqZ
 fg6S/ACHBHFy3mFFnvdwZ1/6appm5ZmshUM7JjaogSbLxY1LKUb9dMQH4fQBvQTP5w8w6UCq+
 E3sFUjvkrjrJHZ5yEb6yBMqWZJvrWEsa0F4IMru5MBc8GvSP5Iy6bAFpr2SrUZ7l6SxSadXuK
 RhGUZH+stfEis4d+MEV9HjM3upOF4mlKVxY87ER+wNhiG1KkD2h2MPhU1LAl0KyeapKtTWDOl
 Q8n/ZytzWVnHk+IEdcqWdhZ70PNybJUM9KCMDgO4602xV9uq6fO6V7OylKR26XaGJADJOgLgF
 xpw4ntYmRaTfvAzqVQVtU1FSSRkHGnUVfwHjgzmVngCnWlS9n8qyC9G9rbdrthxBAcrimoiwF
 AWQS3VwLoNKxnxJFvITFPNtiT1360PThZgTdamziaBebtVKZh0uhE7K6N230wNlRY4TjoiymF
 NM82sBpArqucgo6YMniex0hXrKX2Fct+rV40vRL3N9wvETw4fjzLkdwVer4w9FeLa5bQLOTlT
 BtCtQ5YHtTRcYXPduScHp9WeE2mntkEyTc1rDgVJpb4WZKWr5yCC3E4DwiWYRT5TxM3xXtmd5
 egoDvKI8nEM2qASfYGddvqOheI4qKU9b2Uce03RhNG7IWB+aRCOG323v/bt7kyxvQ0YcxySXa
 Yn7ZOueG2XQ28gLwb2nuSaagv27i+FMrGhcN+70QF7o6b4ge1hu7D/JeKXR/5EtDnCP6Hz/h3
 8oQFWGUCTYKktGI5Li4Ltt7lYVABPIvxR0L1rC5gTraVo=

Hi,

I happened to come across an issue just now again where soft recovery
fails to get reported to userspace properly, causing apps to submit
hanging work in a loop (which ended up hanging the entire machine) - it
seems like this patch never made it into amd-staging-drm-next. Given
that it has a Reviewed-by and everything, was this just an oversight or
are there some blockers to pushing it that I missed?

If not, I'd be grateful if the patch could get merged.

Thanks,
Friedrich

On 08.03.24 09:33, Christian K=C3=B6nig wrote:
> Am 07.03.24 um 20:04 schrieb Joshua Ashton:
>> As we discussed before[1], soft recovery should be
>> forwarded to userspace, or we can get into a really
>> bad state where apps will keep submitting hanging
>> command buffers cascading us to a hard reset.
>
> Marek you are in favor of this like forever.=C2=A0 So I would like to re=
quest
> you to put your Reviewed-by on it and I will just push it into our
> internal kernel branch.
>
> Regards,
> Christian.
>
>>
>> 1:
>> https://lore.kernel.org/all/bf23d5ed-9a6b-43e7-84ee-8cbfd0d60f18@froggi=
.es/
>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>
>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
>> Cc: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>> Cc: stable@vger.kernel.org
>> ---
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +--
>> =C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index 4b3000c21ef2..aebf59855e9f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -262,9 +262,8 @@ amdgpu_job_prepare_job(struct drm_sched_job
>> *sched_job,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_fence *fence =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int r;
>> -=C2=A0=C2=A0=C2=A0 /* Ignore soft recovered fences here */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D drm_sched_entity_error(s_entity);
>> -=C2=A0=C2=A0=C2=A0 if (r && r !=3D -ENODATA)
>> +=C2=A0=C2=A0=C2=A0 if (r)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!fence && job->gang_submit)
>

