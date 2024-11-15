Return-Path: <stable+bounces-93494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE379CDB52
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 10:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842A2B23652
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457AA18E750;
	Fri, 15 Nov 2024 09:17:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [195.16.41.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2318B470
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.16.41.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662264; cv=none; b=fqS/ww1YJ9RVcnWStXosS49jm9CbVlbvejurkGcZi6CXFoE6Fzz6VSGu4cuwrgxuU3JyKIv8qoFyLhJClLrxv9kUL0t0+hE4cPMWjY87h6Lu/6vGKOz/nvGtOLdiOlYvE2vqpBtOIQ/Th9zzE6i1l1Pgo9sgPwzTJZgNv77ZuJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662264; c=relaxed/simple;
	bh=Cm/2UAxXJzcO+vC5gRIMbL/rz5ZYeqwz6F4iVRw3C80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sShODveD/Kefl5yYEI9ZITofkeKOo/Nl/Sfq5JHWt4D7/F35KToZgEEGMquFxNy3bS6K1L3v82hEg+KTsBmzxOpWpOfmm6axHmslN5pAaNGp/CDCt30ytmnn3w/gcZQfWfA36irKYdNqbfs7je+e0VgGeL1uzVBiw5NAUGGL35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=195.16.41.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 0D05F1F9F2;
	Fri, 15 Nov 2024 12:17:29 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail05.astralinux.ru [10.177.185.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Fri, 15 Nov 2024 12:17:19 +0300 (MSK)
Received: from [10.198.18.90] (unknown [10.198.18.90])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XqWch5fCNz1c0sJ;
	Fri, 15 Nov 2024 12:17:06 +0300 (MSK)
Message-ID: <bfad2b5e-4d7b-4083-afc8-a40d25ed9917@astralinux.ru>
Date: Fri, 15 Nov 2024 12:16:30 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6] cpufreq: amd-pstate: add check for cpufreq_cpu_get's
 return value
Content-Language: ru
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>, perry.yuan@amd.com,
 gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
References: <20241115083338.3469784-1-xiangyu.chen@eng.windriver.com>
 <20241115083338.3469784-2-xiangyu.chen@eng.windriver.com>
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <20241115083338.3469784-2-xiangyu.chen@eng.windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2024/11/15 08:44:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 189200 [Nov 15 2024]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2024/11/15 06:07:00 #26858754
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2024/11/15 08:44:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

Hi!

If I'm not mistaken, the line From: should contain the name of the original
commit author. Also I’ve already sent same back-port [1].
However, I didn’t get an answer yet.

[1] 
https://lore.kernel.org/lkml/20241106182000.40167-2-abelova@astralinux.ru/

Anastasia Belova

15.11.2024 11:33, Xiangyu Chen пишет:
> From: Xiangyu Chen <xiangyu.chen@windriver.com>
>
> [ Upstream commit 5493f9714e4cdaf0ee7cec15899a231400cb1a9f ]
>
> cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
> and return in case of error.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> [Xiangyu:  Bp to fix CVE: CVE-2024-50009 resolved minor conflicts]
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8c16d67b98bf..0fc5495c935a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -579,9 +579,14 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>   	unsigned long max_perf, min_perf, des_perf,
>   		      cap_perf, lowest_nonlinear_perf, max_freq;
>   	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> -	struct amd_cpudata *cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata;
>   	unsigned int target_freq;
>   
> +	if (!policy)
> +		return;
> +
> +	cpudata = policy->driver_data;
> +
>   	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
>   		amd_pstate_update_min_max_limit(policy);
>   

