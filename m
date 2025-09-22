Return-Path: <stable+bounces-180959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEC5B91801
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DE018955AC
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB5F30E0F7;
	Mon, 22 Sep 2025 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="To0MYj2a"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51FD30E0C6
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548721; cv=none; b=pskioXtZfBOY2zBKeiexpfLiABzNIDMTks4wXRh+8HlGipiiYuN+U2opNcPAqI8OWxtEC7FyKqOB3VgS4ct2bx7duUb0PQbdqV0tdNF7cNjazWMPI7xOCSzNANA1Q5rO8U4LUZJ5KEDjtPAqEC9GsNvzaYYeeHyGuTemlR+yrpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548721; c=relaxed/simple;
	bh=uG75ywJ/N/C4VTC9ezp6AkudmGNPmDTqgRJVwd5unM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d17eRHLCM6i+Nig92HS4NAMf4tqL9Gys+ArX7sIQsxwxRr69Qm39sDnRdv4+EdUJwv5k+vabtJz1dVo+l/tkBKFqcpERgly7+xOfnsDvtmNg/TzpNuNi2u59Dz3+Ag0CbuS0SLO6P2kUuO68WKS6oL7muIY/ATDKSlOWph0GSLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=To0MYj2a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8vptb005854
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 13:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+GScQufAFT4/Jq3nDg5dsFylkF0kL3QXfWaxbdntkyU=; b=To0MYj2aNo8/9OTq
	e/rYP2cpxQIdJji9OOfwR9fV2WJBnUymGCrJW1V8SpZ0iBpVeFa6aJNau0zvFFB5
	wZl+ia0jCIQLvsCr0GkG0o7Of0HMpawOiwGHM4mJqmk2QDjEUxkAD9ZXqe+6IZm4
	06ITFC8/eUh8/GBgmNkFmCgy6a0q+EctabQ/r5fsCproGVzqF4uGOrTf67/7mbTo
	dbwRd6EXMQYlH+yqOrJN8XEt9hjA4jI+iDGWkRhUSDug818EqHikyOU8QsIvt3cJ
	qPFQK/dm/6Pg3zPKIoYB+F30z1WAkyT+EOh8+uCQje6BGgzCxEucJffJotN6Pyee
	mp/E2A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mg34w1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 13:45:19 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b550fab38e9so2778918a12.0
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 06:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548718; x=1759153518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GScQufAFT4/Jq3nDg5dsFylkF0kL3QXfWaxbdntkyU=;
        b=gQeKu/It8nDR6wGugqatloRHhE5FJhdYuRqtQr40F2zixiFicFau96nc//1hTOlWgE
         Nu1RaU8dSNxbu1ssBd0r6BCxHsA6p/vLqZ1IZ25/r/BtQLY1k6Eug1fSj2zt++4VDYBx
         eM7sK8o1lfEVXNiK3yv9Iq7zz7E5yj944spLIs9sVWag/JwIvFS3ezGoL+BXMQXPru+v
         muHRsMUrE9siyAn+xq/FzYb/PuSY8TNznUquZ3BvZNZ3icqPCrlDqOPOCRwEA4jAhg3z
         mFNx4kyVjeQWT+90Xvva/c4Zw2S1FW8CfiW6NzGaxRqOoBuisqCDg5oDxTH1i0+IA2p+
         GHTA==
X-Forwarded-Encrypted: i=1; AJvYcCUfvDsj1GfN8yl6L1o0vd1sxilrGbuuuS7B42KDiIRA4zcq25yvXXsS9Bln4wa8BP2u7Z3obhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDJMNKYdDTkNt4QBitBPEMNZq71f45e2gRn92N+ANE6seo5RwR
	zk4MG7YZg6o+Cn7GNDBimk0ICiARIQgUme9LF7V6sZQZyyH5BgeCMBnATySqSuuQPUDZmYQS6BK
	/iZGoqWcb0VRGqQSKYaMqPifFoZTe/gk5ztzZ9gMq0fllx13mAGikZXEV4WA=
X-Gm-Gg: ASbGncs3OePd0+r1NJsK9KqOTn2uvtQ6YED8XAOM2fdihRcp26NpAOkU5+e2hODYFYs
	fFTnoy2HoaOLNp6XrMk2lEMZ3/49pFwLSYeLP2h76/iU292rJub55CcHTKYTeSzBYCpNJyckxZy
	iAsfW+XWVyLqjCt+QdqWGPtQN9xbXjc9plcUcLaqUglSPnlttSPJ/nCSk1ygG+1MrGtHc91YAuO
	KnCZU3LR7/DjeTc1ElCb6jkwjyDNTmwU7WQVLLa+hkjinPKbkx1b9/4bNmk6y2r+7/7vrB5SQjx
	uwNiq0gBMDXU+j+QQ9ZMudvu+umvfUBi2k760GFCjQZPXHkcsxbfS4Wwq/FP1FgfZlj8dMGOjCt
	n0qYCzFyLJIu6dThhflCMhW+UZlxzjE4=
X-Received: by 2002:a17:903:380d:b0:246:de71:1839 with SMTP id d9443c01a7336-269ba5512ddmr154128675ad.50.1758548718064;
        Mon, 22 Sep 2025 06:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2Bxtg/WM4oSQFnOHm5vgIFDxjSmyxZZcCDz7Kx3f4NlCh9peJ1mVy6ZCZLfMSaGBLSNf2zQ==
X-Received: by 2002:a17:903:380d:b0:246:de71:1839 with SMTP id d9443c01a7336-269ba5512ddmr154128115ad.50.1758548717036;
        Mon, 22 Sep 2025 06:45:17 -0700 (PDT)
Received: from [10.133.33.135] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df852sm134515585ad.87.2025.09.22.06.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 06:45:16 -0700 (PDT)
Message-ID: <1dd930a0-b975-4302-9e1f-f06904d8a25c@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 21:45:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: Handle CPUFREQ_ETERNAL with a default
 transition latency
To: Shawn Guo <shawnguo2@yeah.net>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20250922125929.453444-1-shawnguo2@yeah.net>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20250922125929.453444-1-shawnguo2@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMiBTYWx0ZWRfXxtJGZ8TrcFOI
 NOcgobhB3oa6zZJ2S3gCuo1LF4f2X8IV+B4SBmkQiuLTjMu451f5ycR8M2cmHiYTEqE3ez/6IaR
 7hAHQem0G4mWHzGClmKNernbRXRu3Wo4dCY+9hnXqFg0JqNEAlas+pmxsM5+MbNZ/IHUKRBRVQG
 vvCt7lvQvUNdodoZG218DQfE/N/B0cE3uIvjcQaF1tt99qj4FmjZS3rX6bpB8M3CsYZZIk0vYxN
 svIq2BYS1/Kyj5bt5+xhfzn51H8itv7yUGE6eYRcOQW3cUvK36KrH7L6Wv28Vf1CW6heY1aUGHT
 eLDSM013H4sJDQaU/limuNeWx/Q7DYl2uoC5I+KnNgYp5BawKb1uBKpDXtYz9bzCMcFDWJRToEQ
 6e50hUhe
X-Proofpoint-GUID: NnlE-WrEw7esoH_e04ofid9x9ms4JgaZ
X-Authority-Analysis: v=2.4 cv=UvtjN/wB c=1 sm=1 tr=0 ts=68d152ef cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8
 a=IMh0YCEmi6Npu7LhsKAA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-ORIG-GUID: NnlE-WrEw7esoH_e04ofid9x9ms4JgaZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200032

On 9/22/2025 8:59 PM, Shawn Guo wrote:
> From: Shawn Guo <shawnguo@kernel.org>
> 
> A regression is seen with 6.6 -> 6.12 kernel upgrade on platforms where
> cpufreq-dt driver sets cpuinfo.transition_latency as CPUFREQ_ETERNAL (-1),
> due to that platform's DT doesn't provide the optional property
> 'clock-latency-ns'.  The dbs sampling_rate was 10000 us on 6.6 and
> suddently becomes 6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these
> platforms, because the default transition delay was dropped by the commits
> below.
> 
>    commit 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
>    commit a755d0e2d41b ("cpufreq: Honour transition_latency over transition_delay_us")
Hello Shawn,

Reported by checkpatch.pl:
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit
description?)
#12:
   commit a755d0e2d41b ("cpufreq: Honour transition_latency over
transition_delay_us")


>    commit e13aa799c2a6 ("cpufreq: Change default transition delay to 2ms")
> 
> It slows down dbs governor's reacting to CPU loading change
> dramatically.  Also, as transition_delay_us is used by schedutil governor
> as rate_limit_us, it shows a negative impact on device idle power
> consumption, because the device gets slightly less time in the lowest OPP.
> 
> Fix the regressions by defining a default transition latency for
> handling the case of CPUFREQ_ETERNAL.
> 
> Cc: stable@vger.kernel.org
> Fixes: 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
> Changes for v2:
> - Follow Rafael's suggestion to define a default transition latency for
>    handling CPUFREQ_ETERNAL, and pave the way to get rid of
>    CPUFREQ_ETERNAL completely later.
> 
> v1: https://lkml.org/lkml/2025/9/10/294
> 
>   drivers/cpufreq/cpufreq.c | 3 +++
>   include/linux/cpufreq.h   | 2 ++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fc7eace8b65b..c69d10f0e8ec 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -549,6 +549,9 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>   	if (policy->transition_delay_us)
>   		return policy->transition_delay_us;
>   
> +	if (policy->cpuinfo.transition_latency == CPUFREQ_ETERNAL)
> +		policy->cpuinfo.transition_latency = CPUFREQ_DEFAULT_TANSITION_LATENCY_NS;

For the fallback case, May we print a dbg info in dmesg to inform
developers that the device tree is missing the clock-latency-ns
property? (Rafael can help comment~)


> +
>   	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
>   	if (latency)
>   		/* Give a 50% breathing room between updates */
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 95f3807c8c55..935e9a660039 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -36,6 +36,8 @@
>   /* Print length for names. Extra 1 space for accommodating '\n' in prints */
>   #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
>   
> +#define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS	NSEC_PER_MSEC
> +

TANSITION --> TRANSITION ?


>   struct cpufreq_governor;
>   
>   enum cpufreq_table_sorting {


-- 
Thx and BRs,
Zhongqiu Han

