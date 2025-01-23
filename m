Return-Path: <stable+bounces-110252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7882A19F70
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 08:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DAA3B024F
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 07:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F95720B215;
	Thu, 23 Jan 2025 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b="i16iyMXk"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8920B7FE
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618829; cv=none; b=PuEm1j7FnSUqP0jzEpMp1H48pYWbLII5rE/HEAWaMJhBqj5IZnecgw2YYpuqULBEfyEHfcyh4f+zCT7aQ0eeXE8UtHBVL95T645IkEkxQgvsYbnxEupIXDxz1WPnNImIZw8JbyBouvwfudwP0KSQO0KIbDw07hi9P4YQp69y7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618829; c=relaxed/simple;
	bh=VXxHIUGvNM8aqMrQ0or/knJSnuAA9sn745pCc4jIX7U=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date:
	 In-Reply-To:References; b=dYIdU9I8iZhcRDWh/jW5znZc2ujqrJg2oY4UGbpZNaLuxOD+VKLHt4ZSQgizFgaHTZloLD3VOKKZGc+LmfjkVNb4zyCLdwtxK5zbN8Q6Pd2rbHsnkyJhS3Lo71GBVPHgGJDZRuGhfelAVYiQi0lj6IDblXuiWKaggA/Hd61/JP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com; spf=pass smtp.mailfrom=engineer.com; dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b=i16iyMXk; arc=none smtp.client-ip=74.208.4.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engineer.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=engineer.com;
	s=s1089575; t=1737618820; x=1738223620;
	i=rajanikantha@engineer.com;
	bh=tzDpRk1d5g96QBqPJxI1gS6FP/tHQ6t4VIpsMWPd9Kg=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i16iyMXkTXFuXtVa5DnssNeOIkR5RL7LV3bZMfkvh1eSfm7+0c4MlqBl1LlwbyjX
	 gOQnBZ/4h7VOnnjkS7xjQTla6rELsfGO4talGeBs7lsO2QpDjNiVS94h1jiAKAHpM
	 RJeHHXyijpsis8FCGtCoTt+hUWMDMD0r+vg0Rv1UJBXrPM9Pe7coyg+NTa+dcFquf
	 mf/Ir/lIySHKIXb/I4HPmeS3w2V1gSwrijF/dDQtjXeehkP3xM9vQCrTpbJ4m4CDM
	 0MdFZTg9jhMtBxdXjjRJXduyir+FKBQixf8ag0gtAP0td7eoU4ArcFBe9wmuMCvYF
	 vT5OBNsyIuF2KySJWA==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [60.247.85.88] ([60.247.85.88]) by web-mail.mail.com
 (3c-app-mailcom-lxa14.server.lan [10.76.45.15]) (via HTTP); Thu, 23 Jan
 2025 08:53:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-404e361e-8aca-42ef-b6ce-15bc7930007e-1737618820377@3c-app-mailcom-lxa14>
From: Rajani kantha <rajanikantha@engineer.com>
To: abelova@astralinux.ru, perry.yuan@amd.com, viresh.kumar@linaro.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] cpufreq: amd-pstate: add check for
 cpufreq_cpu_get's return value
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 08:53:40 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-4ae0c36c-d1ea-4a58-b4f1-1758e1ef242f-1737618558957@3c-app-mailcom-lxa14>
References: <trinity-4ae0c36c-d1ea-4a58-b4f1-1758e1ef242f-1737618558957@3c-app-mailcom-lxa14>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:bFnCuu/fWV4jwAF662HEFRnYp3YFoCBGsbL5AXLs0TZOPajErfFSlmhwjX7INebzJ5GJP
 TB1vnwPcz1Tqf9267nQ6AQo9t/mXFs9vdf/AtHGIGttJQIaT2p17gAsqtelitnLv0nRdXIvYugO2
 vJmPOtY043ZeCdsl1koU7cOPy8USkjyHsq8OfEKZj9gBrSjbSem+Y2MUpB0g4zSOn3znxG2RRaXC
 U40cxKd2frQ8aA1JenL3ls41WYIr+D7BA69c7own5kCGbzlmDf7Nhc7wgTD0ZccqAWZvcTX1xQKp
 cY=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4l5zw+8g21M=;ieC++NrrIZQLrukl0ncd3iutMlM
 B4zp7GPAdiWt4FCtSHVRSVw5+gASCmDwemfAEswZalsHZRqu0fXtikKXE+JtqtA2fe2iEXLms
 MyT1ToGdp/0d3AFOKPhWCsQQvlZ4kaaqw/w83q9NowP4aiel3LsfudwSiyE+7h18l3gRO6h5n
 qR2IvRD/fqR7ywO4235v5zKc+rpYJjtLaQnZ/VOUm4gNcA3YqmgMBnn539YI+BOXS4+fTddLG
 HZREeyqQgcanU36Wg0P1FqFKn3tgoP2sDi+Sj/lpUov8Rv0NHUJFwRK48cvGsUNuhPBeVjs9e
 TgrG7YOz9voy0RsKwRrJXLXv3NTU4PX68wIUpI/ypUpFVhSgRmfN/MxAkycFM8gDiIYr2ZFiT
 JQk01/qepdRLgDKzFrtVBZtmYNuMdFKCCJATxqPl92kCzAeiXWmzvhXm9BRLhuApr3Wc/o3lN
 xUfvWtFB917h5TH+iGpO7cZp+5MujZvhMUzgAsl/8/9H7v7cg6XBcH7WsBOwhh/kXeFoyjhAV
 PyknE8X63QCJ+3abUOwrUnJhDWlXPric9gVcqYvbCCrZhbq8vqWyrLk4YZEtgPeQ1ewZwpGkr
 D7zh7xK0xxdv2iIDgkFxFEI/NFa4qONGgmDBO4sGVub1ZUDDjHUHD65gPZMwq6W3Hko407mRn
 H/8uOE642kRLIvby500ee6Z5or8iB/aDt3/6apwhi5dXq7Bmqt5LSdaTp8SECe40UUjuOQfyt
 G59bClGpBRNu5TOp50X0wGYzBS437Bm31IQcuiYZCbUc9BpUUKLh55LZmMvO0KnLg0rncXY20
 Jg/0/e11XXUxs2wUgeiVbMZuVBtN25U+mCLZ8lESxDG7HQDJauV72+Fn3vPAa9jiKtXgRXhxz
 qKC57nqbVYdqbC1w/1QCAPxkSqQBXnkppZqOq0oTRWJHbN/t+zFu4LJtvOlFGSCtXLiHTuz1+
 1ZRloyptUr4TgtupU3W7M8wR0EBz08Oyn6tOBJiFazAaxW23aFIsAQH+ppSrWbdXkjFXs0AyS
 6YOGYYZYNVifPQR0ilotXeIvCz4QRcEpydoitHQNVmQwn/mAjQxMQdJ2sYLX1n7dSAOkChiRP
 h2sZQl2D3Y08ACT42YkVeobRUSQ4jveNNy2pgNft7OpusMDhogbRX2BOBO0KS9WzkgCzzEf55
 mlRC4bXBVG96UZsQkh2N6
Content-Transfer-Encoding: quoted-printable

Sorry, please discard this patch, I saw someone already sent it.

- Raj

> Sent: Thursday, January 23, 2025 at 3:49 PM
> From: "Rajani kantha" <rajanikantha@engineer.com>
> To: abelova@astralinux.ru, perry.yuan@amd.com, viresh.kumar@linaro.org, =
stable@vger.kernel.org
> Subject: [PATCH 6.6.y] cpufreq: amd-pstate: add check for cpufreq_cpu_ge=
t's return value
>
> From: Anastasia Belova <abelova@astralinux.ru>
>
> [ upstream commit 5493f9714e4cdaf0ee7cec15899a231400cb1a9f ]
>
> cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
> and return in case of error.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> <Raj: on 6.6, there don't have function amd_pstate_update_limits()
> so applied the NULL checking in amd_pstate_adjust_perf() only>
> Signed-off-by: Rajani Kantha <rajanikantha@engineer.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index cdead37d0823..a64baa97e358 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -579,8 +579,13 @@ static void amd_pstate_adjust_perf(unsigned int cpu=
,
>  	unsigned long max_perf, min_perf, des_perf,
>  		      cap_perf, lowest_nonlinear_perf, max_freq;
>  	struct cpufreq_policy *policy =3D cpufreq_cpu_get(cpu);
> -	struct amd_cpudata *cpudata =3D policy->driver_data;
>  	unsigned int target_freq;
> +	struct amd_cpudata *cpudata;
> +
> +	if (!policy)
> +		return;
> +
> +	cpudata =3D policy->driver_data;
>
>  	if (policy->min !=3D cpudata->min_limit_freq || policy->max !=3D cpuda=
ta->max_limit_freq)
>  		amd_pstate_update_min_max_limit(policy);
> --
> 2.35.3
>
>
>

