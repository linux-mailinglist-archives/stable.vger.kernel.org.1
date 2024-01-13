Return-Path: <stable+bounces-10813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AACA082CD07
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 15:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A861F22729
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844121360;
	Sat, 13 Jan 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="sS2hrnbC"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674621119
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705155860; x=1705760660; i=friedrich.vock@gmx.de;
	bh=QF0nvBK5NQV0D6KCop/JdicjZvUuumkdKzv9+ObcvRI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=sS2hrnbC0neneXIcfVlMsPej9iPq6om/ZWQ2aYcsQCVrttypNlWkcnXzKh1LOxkz
	 8mF1JtxrZm/4rpSVBsyHBu/v7NYf3LxSLV9/kMYD6Z5csKdVQ+4hI0ZOuQDbGq6t1
	 p7WTx5r1/sve0RKlUrZT2q5T9489148mdjAYPHDky59W7gCqlByTRwd9MoawYVEUV
	 v4f6wDxrGqx87k7bvxKF1fPrqwmpYeRvN59FT2qrg5xYob+gk9d4lXNhp0wUJ9umg
	 ne8pRvTH9TomLpVyBrMNagwS2C858kpjIOjkPPIv5g+OAPGlLvcCRo7q41GoWJyCa
	 aRDVzJ2iACRhZuJEsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.118.80]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKyI-1rZkmB3V4C-00Siqg; Sat, 13
 Jan 2024 15:24:19 +0100
Message-ID: <40810da1-0eb1-41c7-b161-e4f03ac0c8bc@gmx.de>
Date: Sat, 13 Jan 2024 15:24:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Mark ctx as guilty in ring_soft_recovery
 path
To: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20240113140206.2383133-1-joshua@froggi.es>
 <20240113140206.2383133-2-joshua@froggi.es>
Content-Language: en-US
From: Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 xsDNBGPTxTYBDACuXf97Zpb1IttAOHjNRHW77R759ueDHfkZT/SkWjtlwa4rMPoVdJIte9ZY
 +5Ht5+MLdq+Pjd/cbvfqrS8Q+BBwONaVzjDP35lQdim5sJ/xBqm/sozQbGVLJ/szoYhGY+va
 my9lym47Z14xVGH1rhHcXLgZ0FHbughbxmwX77P/BvdI1YrjIk/0LJReph27Uko8WRa3zh6N
 vAxNk6YKsQj4UEO30idkjmpw6jIN2qU7SyqKmsI+XnB9RrUyisV/IUGGuQ4RN0Rjtqd8Nyhy
 2qQGr8tnbDWEQOcdSCvE/bnSrhaX/yrGzwKoJZ8pMyWbkkAycD72EamXH13PU7A3RTCrzNJa
 AKiCvSA9kti4MRkoIbE+wnv1sxM+8dkDmqEY1MsXLTJ4gAkCnmsdGYz80AQ2uyXD06D8x/jR
 RcwbRbsQM5LMSrXA0CDmNXbt5pst7isDbuoBu1zerqy2ba+rf6sxnSnCzQR6SuE0GB7NYV8A
 lrNVyQlMModwmrY2AO3rxxcAEQEAAc0mRnJpZWRyaWNoIFZvY2sgPGZyaWVkcmljaC52b2Nr
 QGdteC5kZT7CwQ4EEwEIADgWIQT3VIkd33wSl/TfALOvWjJVL7qFrgUCY9PFNgIbAwULCQgH
 AgYVCgkICwIEFgIDAQIeAQIXgAAKCRCvWjJVL7qFro7GC/9PfV0ICDbxBoILGLM6OXXwqgoC
 HkAsBEXE/5cS68TT++YXMHCetXpFfBIwTe8FlBcbhtylSYIUhFLmjiGfgoXy5S87l9osOp1G
 y3+RNbFoz4OJvqcXX5BqFK5KHh7iL/Q6BaZB9u3es0ifFt5YMwhDgcCbYaLUlTPbl+5m+/ie
 Eori0ASylvhz3EdB11sMqN9CmoKvBEVnkdiydDMuFvpEi08WB8ZC8qckiuwrLOIa4/JB54E2
 QyGw0KgBT4ApeMmkKurS3UOsrAwoKKP/0rgWsBFVnXrBIOEL+7/HGqSSDboLAjt1qE967yxM
 3Qzt1FUBU9db2biFW7O3TmXP31SyPwVYWfeETa4MT9A8EyjfWF66+sfPXREsBvqRTin3kEst
 IlbMdSNijCjKZz9XPCaKwx3hJaD5VEs3gPsKa9qXOQftfTqt+SI0nYBw3sdT2+wWJCeyZ3aE
 L0Us8uMILncTxVAhX2a8pUvGrbtuyW2qqEFId1OSfWlrLZEuv8+631fOwM0EY9PFNgEMAKx2
 G48lrQ1bLAWgjq3syyswS80e70M+/Fbxb2aBKRHw5XbpSPYr9FLE3MPdgvUtt+fiK2xA69bk
 i86sfSV2KNhRuiS2rb1h/jfmTlxfimBezHv6xnzVuHJNd87vL35lqd0D6B5zvnzzP9CjpXq/
 o7isfiA2FMSOI1OnrHEw9pbEd1B26cgS+mIGhDf/gBI6MtsPuN8xMUyybtpUSSVi3b4oRkge
 +vwwbMn+vwvhN39kjcISAT+jFWNupDybFIs8cYNWA7MkWJAIuqSjMydE0l1+c8eF7nnvzY2o
 2GGarFmxNO4CHuh3JoMFfY4wlKjmDlk+FJ5UfIFelVmOiVPLGrSL8ggcubnOS75VjDvDTQgY
 tjDvLuUmOj1vYSmPSE9PjDMhrpx1LcSOHyV+aX0NQeHP869A/YLjwQbOJBJVIN+XdsGlnwG5
 teXXxU9uwFDqYPAneHp4As5OKovOCIzNj6EB4MIZIpTGgYQBIN4xrwL0YsjvPm2i1RyBPTpf
 UKvjVQARAQABwsD2BBgBCAAgFiEE91SJHd98Epf03wCzr1oyVS+6ha4FAmPTxTYCGwwACgkQ
 r1oyVS+6ha4Hlgv/Z2q6pSxeCjK/g20vub8Gvg09jNYAle3FTaJD2Jd/MhUs6s9Y5StWtiDf
 hw27O8bhJan1W4hrngQceR2EcvKxejroVhu3UI2b9ElM5aphD2IolOWqfwPXeUetIgaMNqTl
 GJ9rGx+k8HCpchW4QVZfWn7yM+IymCwOYov+36vMMHd8gdQ0BxMiT2WLDzCWwDb+/PYMfOiq
 AoPBV5EQ2K3x85wl9N4OxiQdGWi9+/0KJyMPYoGlFqCdPdvvbpFe4XD6YOBr3HmVOFCWtLcW
 Bm+BCucpo93VhjNVqZ+cuN/tlS+Px8kl0qW9J3Q8fwWhgz69v5YdiOczQza/zQu3YrcYapBD
 kQXSmDju1Yd4jIGeZ8vf+dnmbX78mpj3nBmYLhIs5lszAH634uoWyJqMLs77WG1pkk0utvwh
 Zvq4r6fbLIuofLsboYKQxUJuX5uRSK4/hWXEETUTxxvkA/hiuhsdMbDWIZWFp8yuoZvR2itT
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <20240113140206.2383133-2-joshua@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GZi1a+G//DER2QtwR5xOXBq9LO7WlrMJNmH/9GFU9zhcmyY/svN
 Ho4tOe0xdvNRuslUDImPN5Yjxkvwkn6j/EM7sPZOeA9jTNqmHO9iEgcoTXfs3mOTzwdv7dp
 s8oxmjL1Y3CrFrU3zfsaHVoZkoUrkCweVffNjeplW9H/Qep41cG/jwKDjK5PYRdMtnyK45M
 DnSvXAJr+UtJuRs/zEAHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QJSXyKr6qZs=;FphhK9fAYNdxpCFbSWgKtaU5JHq
 LIwPnfFKhtfccR9kbjEPTJJMd4+6F++GYw34LqLEzpvQSG2NIAgFYUhHJG2EwekZP54OKY/ez
 N+GJEFwmyLBuQHLyvqUBvfKFNFI+NPEmPx0uyHAMLC6inkFx1fZbPQJ+5sI2Iity9eA/1Sg7w
 ELYjr5cg2JbkobAsmuJRUP9yN5d8VHxG9GH+Q/1TST6Dm8tMPb430OPxHDQHfD4+cHwJsMfZI
 Va8wW+5fshX25g30n7bLebFCuytDAQnrHTPPe8tx15Nvphallb9ZYbt/1oqLC3o2tlVa8IWMw
 +7SOxRXJ2uUmII+wT+1xr1RYteC5eILoORTSdch+CN+merqcv78GBIt/U8HJud8Vzobafi8nl
 0+G5eOd08bNJCi5JEV/MhZBT2/wlZrVe4DhrYTDNhhWwbGC6F+U/Ra+iR4D/NsJIk8G9T/Npj
 k4O3MomSUfRTXm5I4sXZX8tpgRe/74ymLWc1mfTUhSz54dAe2Kh3smCohDIJqjhmALeKZyDYp
 QCsqQey+9eplKZxLTQAG2HkWzh6JC6g6tC+JunbB+2JJuhluJuorZe1C9YUBu9I3JJhGJaQy4
 UaKymREmNSiut1pw4tkCQWPyohAXpsZfLUrB1jL0YW6KUruW4QPquirAGa6Q6KWj7MHGDDxgL
 K8eL83qmekWxLrbKcuAOPjgBq4nt9DIMI8b8qRMHqatQf0+eRt5fU4PmFEv9grGH/YOoZHBjW
 NdZIXCcXNkQZefOdsZlwXVYGYmLNTewJJwGjz9YDhkZUzpYRmHbOZHu8k/2Ef5FRnxs88AvCg
 CS5HuqFKVb/pQxu7Zhr93Q+Mlbg4VkmyA9Ow/IcFnLlluLJw53alOiv7APzhRH5RZG/oVLLVj
 WwDRba472Ov60Kb5foZghGhqQBrU/My24/oA6RObMlQf7OjV/y4pwt8L+XOHgBNR1RGDl8ZUS
 kqFTw64yHW3Wex78ExtV058m1OQ=

On 13.01.24 15:02, Joshua Ashton wrote:
> We need to bump the karma of the drm_sched job in order for the context
> that we just recovered to get correct feedback that it is guilty of
> hanging.
>
> Without this feedback, the application may keep pushing through the soft
> recoveries, continually hanging the system with jobs that timeout.
>
> There is an accompanying Mesa/RADV patch here
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27050
> to properly handle device loss state when VRAM is not lost.
>
> With these, I was able to run Counter-Strike 2 and launch an application
> which can fault the GPU in a variety of ways, and still have Steam +
> Counter-Strike 2 + Gamescope (compositor) stay up and continue
> functioning on Steam Deck.
>
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
Tested-by: Friedrich Vock <friedrich.vock@gmx.de>
>
> Cc: Friedrich Vock <friedrich.vock@gmx.de>
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ring.c
> index 25209ce54552..e87cafb5b1c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -448,6 +448,8 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *r=
ing, struct amdgpu_job *job)
>   		dma_fence_set_error(fence, -ENODATA);
>   	spin_unlock_irqrestore(fence->lock, flags);
>
> +	if (job->vm)
> +		drm_sched_increase_karma(&job->base);
>   	atomic_inc(&ring->adev->gpu_reset_counter);
>   	while (!dma_fence_is_signaled(fence) &&
>   	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)

