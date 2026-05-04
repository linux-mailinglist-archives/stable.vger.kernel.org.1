Return-Path: <stable+bounces-242847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAURFQE8+GkArwIAu9opvQ
	(envelope-from <stable+bounces-242847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 08:26:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E21774B8DD9
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 08:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D182C3024A62
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 06:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C6329DB6C;
	Mon,  4 May 2026 06:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j9makQ2V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cCcLpQjZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E3292B2E
	for <stable@vger.kernel.org>; Mon,  4 May 2026 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777875865; cv=none; b=TMhQbFuOskD0G/pLBSgfshwmrWTRMzcM5PzsTkXlRWUocX0PS9COz2WEYr4Gwaajy92WF7LAGoFVMwSOMMxdhXf6UHpqzY3YfNVGNeX9zuPRkGzDzEqAd2RVNZ+hRzoX4Zlmh47QrTAiz5Ldqtygrl7lkYl02yJjz0w14ys8mo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777875865; c=relaxed/simple;
	bh=bcTkj7z6FKGNVOHa6c1rxzRLMWKib6fRDMdYaX8gzSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZsVXNwkx1Xpz+1sWKbMoXHLa9Zyg37qw7dcjJ4oEDTqdPM6Wxl7XtM//lvIZ8ddHooac3kPtoRqCXoE7oaOlUW2Xr+E9MDseJ6xjoORp4kFHjWZ6FJKbDSUnnf1oFznGvAnQhBTOGQGrjA6DCEvljGApxXFNO5y4zYdy+ocQxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j9makQ2V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cCcLpQjZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446DC034174286
	for <stable@vger.kernel.org>; Mon, 4 May 2026 06:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TNyRR0rELfmD0/XXE4YuZsBRKd2/cuC3uluE9QU1vLU=; b=j9makQ2VCl7+a92H
	Ms359avakOcDGNz8ZJfzNQmBfTNA946xGHczlH1u6/6vSkDQkPY4jefB3GjtSIq6
	Fh5DSTC7ycKn6SYkIHN2O3x6Dwj0VrrEMzuSoFvLnbA/UPcfXrWszK3c5D7KRTjY
	Cx6xeG4+uRVJUIvkKPeEExDpqxzA0YMDmG327Qu4oWSloLysl6GNdZaKgDDiCC3l
	WZM+2VX2q7wO99Q+4pB7Z11FKIpnDxh1adEAU3VWQspVaSeg4OTyHKaQmwnFNfpn
	PcYy93sNJBnQV91mpvmhR1VGVZ/M+V+aKqRZxAKtyjJwOcmyRwUIg94RIpbMPHb4
	oCfZ7A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw9n8ccwq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 04 May 2026 06:24:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2d83e7461so72409115ad.3
        for <stable@vger.kernel.org>; Sun, 03 May 2026 23:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777875862; x=1778480662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNyRR0rELfmD0/XXE4YuZsBRKd2/cuC3uluE9QU1vLU=;
        b=cCcLpQjZEdw1EPmTIsL0A2oMoXIAq3oKwkn01qeiiU4fVaELGnxBzqlOgZrSqs96Rk
         yR9nvlVNwuX8ExbxXzqY4JpQ4WVoDn5vpGcGVCX5cOL5I6iHkOXtfWf34cXuFWTIxjbF
         nyUdt/nef5tmzikwCstoFPFm7bj8otOf26CdtPO3gtlO8NmytUesmO/iDevboV2kSA80
         c+P2g++ywOA6mVHapWyu+av6zkJPHt53nzBV2aTIThjD146gK5N10kOkgR/cKx48UBAm
         P1N72cbqE9/sZmXXX6SYxbKNv/iD+qVhZy90ksPmFaexGYW4QyWYH5HUrkhu8F3AC35u
         G4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777875862; x=1778480662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNyRR0rELfmD0/XXE4YuZsBRKd2/cuC3uluE9QU1vLU=;
        b=KScUT452sLoH9TdOkpT9mIWBkBQ0c0toTbIedYTDk8oJH1T2ywO+cWfSm4rT+Htnrz
         ySmaxq7OLpZyIA9TsbeKySLLhtKjscpkbvK1bOYo9+07kYWy4WxallAS3oKRwJPfPf1T
         GUTBl6rKqjtVxrCGzevxkp2gHVlZeKl0DLpQAOL1dO//U8l8eEYm8DUPw0M4LT0mXqoW
         HGsn/arIhAlKvJabJc1ZXe6b530llofa4SxyrSI/ahFGUsSuxDebE9b0ZCvqiB9ho/Hp
         kGVPTCegIkLeILUgRGADykaV4r6vgFM5uVmFnS4Nw77ge5umvX3pOjELWfqqnGEmL5IX
         xNLw==
X-Gm-Message-State: AOJu0YwvC2OebwZAxbUhGbNgiaSdb41bS9wOEgKZ+TaPoHTnhjNb1U4q
	yNhpy2B3zKavC3tWBQR4wviDD/KGKNacH1oFu4fYKLDcCENZ57H7PuEEKHac4qPMNwIHlZBrPio
	H9xqYqeT5Vk+pyn0nSa9MGRhHfcZhJYLsaafYzjgSJS7CHj+/eGRh9zpjq+A=
X-Gm-Gg: AeBDiev0V1FDlplTNY+cDMCOfvrEX7gH3WgQ2RkkLbLk8pzXYnQszbIOmAuCzO9L1jJ
	J/9rRPXMK2l+QiPMcfwPR1YkBAIYAcHBVfsms0mOJSyjdZQB7phskBSO3mPXKyge5NZKOWCgnlA
	ZrdqH53C50KEqvYsPbUAl4BNmpvIwSO4ElYY0VKSiRJk8N68Pnw5nK+fKZr03UGr4cvOa+6sVgN
	7ToqBDMN+rE88oPHgzzGEl0Mq9Qg68KJ7InfMLqqZEUa5bQx6g2WWb/9HDXDuixx3SnRAY2C2km
	ZBMv5SI65KWjAe9umWt2ibgde/s3zlQmgUT9SBMVEPvzRykz5dNCecdmQOMJDIvZHZ0JJgDSF6M
	yg57pf8iW56zkIBCUFndbKr6XkhTx5FSvw1L2koAlTBFGwsgPxuatX4TiB3YyOFzAPOO7FosRQg
	Q+7hmSw/UwnB1ALDlqCz6K
X-Received: by 2002:a17:902:d506:b0:2b2:4d36:7aa with SMTP id d9443c01a7336-2b9f280fe1emr84277345ad.35.1777875862064;
        Sun, 03 May 2026 23:24:22 -0700 (PDT)
X-Received: by 2002:a17:902:d506:b0:2b2:4d36:7aa with SMTP id d9443c01a7336-2b9f280fe1emr84277065ad.35.1777875861559;
        Sun, 03 May 2026 23:24:21 -0700 (PDT)
Received: from ?IPV6:240e:400:e18:23b6:48a3:6006:2608:1239? ([240e:400:e18:23b6:48a3:6006:2608:1239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0f67esm96626775ad.51.2026.05.03.23.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 23:24:21 -0700 (PDT)
Message-ID: <ff263bb6-1e0b-4cd8-a1c3-82ee162427bf@oss.qualcomm.com>
Date: Mon, 4 May 2026 14:24:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-hw: Fix possible double free
To: Guangshuo Li <lgs201920130244@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260501190005.504962-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260501190005.504962-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iB23p7V-KxQyZ5VTanekENwsAIuuNn6t
X-Proofpoint-ORIG-GUID: iB23p7V-KxQyZ5VTanekENwsAIuuNn6t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA2NiBTYWx0ZWRfXweQXe+iSrRS2
 23aW5nzjWgoWfd6EtkTy2mtac0HLaYgDryMkPl8HAv0F7lrS6bJtLud05+enTqV4vKYFEVR55Kf
 Hvi5n55Zg24nKbmSIoNdhJgy3A64WxbPmCDLQI4wLoqTf+clRj3ASc/X7BF43h3DMi8jw1Ukd+U
 gF/e9+06YMwqHGzog2bX6uZFdEIvaXDMAdrWIfylCNXZa+DQvA70m/v/ko3qvT3Im79yuRjy1NF
 MOFQtWyWvyktaS3EKHugzsvTgqmQxKRNIhgmGmsYZsp+85cFhOAZ5Yl5fTeWs5vV7iMtANQekIg
 5QY8Vt6NLBPr3u1paTaiVhfUh3u6lnwpole2bIs68VnrmIMPllqGzjIJhGoVP1jrsoEWDAaPuOu
 nfVyNeJzbBa399O8V+Pmvjtki0wbgK5wm5yDtd269jRlsBXs/F3AMUZ3pvRWQ2Yg+Jg7C1p2tZd
 DGI87nIK9PI5eHp+kTw==
X-Authority-Analysis: v=2.4 cv=ScjHsPRu c=1 sm=1 tr=0 ts=69f83b97 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=c92rfblmAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=g1ydD-XOTWB8Hi5v_0UA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040066
X-Rspamd-Queue-Id: E21774B8DD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-242847-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linaro.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhongqiu.han@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/2/2026 3:00 AM, Guangshuo Li wrote:
> qcom_cpufreq.data is allocated with devm_kzalloc() in probe() as an
> array of per-domain data. qcom_cpufreq_hw_cpu_init() stores a pointer to
> one element of this array in policy->driver_data.
> 
> qcom_cpufreq_hw_cpu_exit() currently calls kfree() on policy->driver_data.
> This is not valid because the memory is devm-managed. For the first
> domain, this can free the devm-managed allocation while the devres entry
> is still active, leading to a possible double free when the platform
> device is later detached. For other domains, the pointer may refer to an
> element inside the array rather than the allocation base.
> 
> Remove the kfree(data) call and let devres release qcom_cpufreq.data.
> 
> This issue was found by a static analysis tool I am developing.
> 
> Fixes: 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>


Hi Guangshuo,

Thanks for fixing this.

Yes, qcom_cpufreq.data is devm-managed and policy->driver_data
points into that per-domain array, so freeing it from ->exit() is
invalid (and for non-zero domains it can even be a non-base pointer).
Dropping kfree(data) is the correct fix.


Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


Regarding the sashiko.dev AI-generated review comments[1]: all four
issues raised are pre-existing possible problems in the driver and were
not introduced by this patch.

- The data->policy dangling pointer via the clock provider path
- The race window in qcom_cpufreq_hw_cpu_offline() between
   cancel_delayed_work_sync() and disable_irq_nosync()
- The unowned IRQ operations when request_threaded_irq() fails
- The freq_table/OPP leak on cpu_init() error paths

They are potentially valid observations worth addressing, but should be
handled as separate follow-up patches.

[1]https://sashiko.dev/#/patchset/20260501190005.504962-1-lgs201920130244%40gmail.com







> ---
>   drivers/cpufreq/qcom-cpufreq-hw.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index ea9a20d27b8f..ef19faedbfec 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -578,7 +578,6 @@ static void qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>   	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
>   	qcom_cpufreq_hw_lmh_exit(data);
>   	kfree(policy->freq_table);
> -	kfree(data);
>   }
>   
>   static void qcom_cpufreq_ready(struct cpufreq_policy *policy)


-- 
Thx and BRs,
Zhongqiu Han

