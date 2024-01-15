Return-Path: <stable+bounces-10878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF82882D83F
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 12:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67131C21942
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 11:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11A82575F;
	Mon, 15 Jan 2024 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="uCGtIxvq"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29381219E1
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705317581; x=1705922381; i=friedrich.vock@gmx.de;
	bh=Zfci03ZVVyDlxWE+6PmufB1R4hxifBBzUHUc/2VqNiw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=uCGtIxvqiXYBynJGrIXHo+D76N3TXvGt2Smh/kV12Hgxm1Nb/ir/zFXi0dn4pG7p
	 yufK9hbm30m45OibpFlgTXPFtL9TGfJGYcF6/jOvDI2/dIJRkfS7dzbCKUtax69sN
	 6uCGnLQpP/EPlPGuGyXU0BCVG81q7O9QcHqdmBCTlbhPbwjqWi8ri0BTW59/RZ2O4
	 ZgzYCRhPrXDsRtH5UZuP/zBMA9dVZBHtpcbxNQt6rI0PvRJ2Z9wDLVNIxkdamo/K/
	 35QsjbpBRs4w5di6TESy5tihvH8WbOO0JVF54eV6H5O4r1x2KiUBWCKdH20p6g6Gx
	 HRmVoiUtMmJBXsvtsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.95.157] ([134.34.7.10]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DJv-1rQATo02X7-003bCV; Mon, 15
 Jan 2024 12:19:41 +0100
Message-ID: <8e81fd02-c5e3-4c0c-bb8f-b81217863ce2@gmx.de>
Date: Mon, 15 Jan 2024 12:19:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Process fences on IH overflow
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Joshua Ashton
 <joshua@froggi.es>, stable@vger.kernel.org
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <20240114130008.868941-2-friedrich.vock@gmx.de>
 <ef01b29e-8529-43d2-befc-a3e3d8eaccf9@gmail.com>
Content-Language: en-US
From: Friedrich Vock <friedrich.vock@gmx.de>
In-Reply-To: <ef01b29e-8529-43d2-befc-a3e3d8eaccf9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZpJ9QTCsijTrh4lu7DrAaUL1PXlw9LyVsicXM1BTIM5NXMMvsU1
 +7WoQKeiycECz8Mzk6MTzELdoZriLoQdA7rKbuCPtSDLcN1M3LX8CkNfTHx/wiVqazcW5NQ
 H3mwYJchflqLnI100r18OFQGz7UvTpSls7hh2HZZwLgFNYkmJeNwTdMNITXWgP+6SX4TG68
 sXxCI51Hh7KTBtxRJqyCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b0zBoBhZ9a0=;o5rs9Cc/T5jZQx8K7y2DSJk9eLs
 n2fsZxIMj1YRGorXzr+YiXKzQw1xvy3i5PAFbsxr2/igl1C33f484vmP2Lrglh9jeTzaWZ6qh
 xMTmzbQqQ8DgVVaL4K2DUvWbKcV49ih2krahaQABZmeMc3qbmZ/ThI05w4xuOBwzb9OFqgAQZ
 2vyyWXpx1o7OsvXw5hS2HZEH3VuSyl4LJfftmXEdSP2nzSIMZAwwEGc4WcaC9/avu6klO0vtR
 JTlqYrl5EIyC3gARDh2jAlSSHXYbGYhfxPvMg8Ypes6e/eZIJZZ9smvHGQcp5Vn9V6r6qP0oi
 7uky7D0NXrUXlzY1b07ZKS/Qhgr453IV7sqFJdG/iITUue11iODPWTSMYl0b87XrOFHIK8cee
 W1hDUDf9JMcByXI/tEachA03KFqYETqX9o3mRMdUAodGz6wsx08TBpgt3qn4sZ8cEcLFKLMmU
 fH2QinGJT4gEx/XOYD/d8/D6jPoDln3pG9PTTWVUHikQ7AtrsdnWEQo8p05DgNNdd49liBmEj
 k0bnex0Acyzu5xL3Sdwm8Ex6d+5YqNfvrNs8Jcy+YjzfqzBQ4loMLH/d0LB/+TmtXDIwwg6ca
 g8knNA/6CLfvzgiE7xpW2x95hJG4IGy91LdjY38iTKq89r2Bk52RPxgXHl/ppK2F2Foh1BP58
 RgGjGAT6dJhwUC8Hw5SuyYz9LEUem09gzGVSXIyrzEMD5oaA8asfzmSPi9kz6TSbar5iWwSIk
 Gsr2mHxxKDAwWxVLlQO+4PCi/DG0ffjKHAIe3HzudHI82KOlnULu7eQn8h42mUzYqYnvjvQuk
 vnbEPe+x8h/j5QNMJoLeNu0/LSq+5c/Q0cYG8dFRidyurw+V81/MUXj2uaPQHn7MP6peFuCL0
 3vQh5je1cV44BxiVVx5pvU4Anv+r2QFcMgMxFMAkHkEMIYNX25XV8PZQYeMri0ZuXhe3IRsob
 FAhn6A==

On 15.01.24 11:26, Christian K=C3=B6nig wrote:
> Am 14.01.24 um 14:00 schrieb Friedrich Vock:
>> If the IH ring buffer overflows, it's possible that fence signal events
>> were lost. Check each ring for progress to prevent job timeouts/GPU
>> hangs due to the fences staying unsignaled despite the work being done.
>
> That's completely unnecessary and in some cases even harmful.
How is it harmful? The only effect it can have is prevent unnecessary
GPU hangs, no? It's not like it hides any legitimate errors that you'd
otherwise see.
>
> We already have a timeout handler for that and overflows point to
> severe system problem so they should never occur in a production system.

IH ring buffer overflows are pretty reliably reproducible if you trigger
a lot of page faults, at least on Deck. Why shouldn't enough page faults
in quick succession be able to overflow the IH ring buffer?

The fence fallback timer as it is now is useless for this because it
only gets triggered once after 0.5s. I guess an alternative approach
would be to make a timer trigger for each work item in flight every
0.5s, but why should that be better than just handling overflow errors
as they occur?

Regards,
Friedrich

>
> Regards,
> Christian.
>
>>
>> Cc: Joshua Ashton <joshua@froggi.es>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: stable@vger.kernel.org
>>
>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>> ---
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 15 +++++++++++++++
>> =C2=A0 1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>> index f3b0aaf3ebc6..2a246db1d3a7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
>> @@ -209,6 +209,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev,
>> struct amdgpu_ih_ring *ih)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int count;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 wptr;
>> +=C2=A0=C2=A0=C2=A0 int i;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ih->enabled || adev->shutdown)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IRQ_NONE;
>> @@ -227,6 +228,20 @@ int amdgpu_ih_process(struct amdgpu_device
>> *adev, struct amdgpu_ih_ring *ih)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ih->rptr &=3D ih=
->ptr_mask;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0 /* If the ring buffer overflowed, we might have los=
t some fence
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * signal interrupts. Check if there was any a=
ctivity so the signal
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * doesn't get lost.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (ih->overflow) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < AMDGPU_MA=
X_RINGS; ++i) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str=
uct amdgpu_ring *ring =3D adev->rings[i];
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(!ring || !ring->fence_drv.initialized)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amd=
gpu_fence_process(ring);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_ih_set_rptr(adev, ih);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wake_up_all(&ih->wait_process);
>>
>> --
>> 2.43.0
>>
>

