Return-Path: <stable+bounces-232669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOPeFh+RzGk7UAYAu9opvQ
	(envelope-from <stable+bounces-232669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:29:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02912374640
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6D4F3017787
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 03:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA0735DA43;
	Wed,  1 Apr 2026 03:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p3aLDvpH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VoilB1Q0"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4AF2D061C
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 03:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013969; cv=none; b=Ke/1CME0n3ks48oR+Nz1k6LesjoXgAImGvnu7WtysOUduzB+Hp8PXpVfSJVVShseyKz/ryrf0Wnjy8xoVzNpdBbkIMVkbAmgf7f2HKgDS+ZKOJT90MDAdyu01BYiew5V0CvNVh47DVDYO6Y6xtIe/zGQpM9C3YW4oSPt+4hWs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013969; c=relaxed/simple;
	bh=+JA44hGFxujuGOu9N44cb5QAbDdj4eN5FYBuv2SeAeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKEZntVTgHXyOifwW1n1Pvl297L7hJNdkWbbN6UvcMrliS6bwFcwOpQHVgJ6mwzFHYLEYOZKl1bxb/YE1fcxpbT9i5caB9Wn17HWMKgklx8ZE++6SbA6l1J1IMx8TZ9VlYoFmBbFbj8e5eD6Z+cOwuD70FuQPdIiTgPJHK7TMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p3aLDvpH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VoilB1Q0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6312JAuW1006686
	for <stable@vger.kernel.org>; Wed, 1 Apr 2026 03:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9bFm59bSKTWB6QfcDL5i7O4Qbe5adgX1gyEfBxo1Yds=; b=p3aLDvpHrKuMqXrK
	Prk59awqUw2Rd4XMliPxGED1Zagn7TJCkEaStVOu3mwWuNUkW/RefgJOr22LBkYb
	LD3EMjxd12GRspFz/L+ll1xT7i/7L4IWMSDoVtF6DLVZiHEtfb5kCgVF8nO1GBQe
	RVMxZjytXJawnN9NFxcDsc/mdhYO7ZbgqurMCJ9TGqBz780RNDxdsvsSjWfeDze4
	/CLKD+n5bo2adS4NmyvhRuNcFN7nyOZ0qJoWkIvW9p1esUPj66yJ/x2XfST1EVHm
	nWgfRsh1ytZ2EKwWkE9Beg7Cd+TmYs8e9jGmOM0nC4Ml7w5F9oJgKeCqzxrOf+30
	yw7DXA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8tfjg7b6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 01 Apr 2026 03:26:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b242b9359aso39852855ad.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 20:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775013967; x=1775618767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bFm59bSKTWB6QfcDL5i7O4Qbe5adgX1gyEfBxo1Yds=;
        b=VoilB1Q0fK97p07DeUB/g+K0xmjOsedY9EU/iKtiZ1yDFBbPS1M+3Zmesslhws67lH
         lO9BL6+L7I8WjeLpLs7tCL9OB4wH1L+kELHFdZ+sUGUxlmbweyp1yWd9I/O+FAsLRAir
         3WftfJCKUyVuCLEnPEGl8E2c0RhrizWFJ3c5kZjBT8zYHykvXhYtJsDg2Toc9POGlRp0
         viZ77YK6MfZInxMfVsfHrbuCI4gEIjOg2T0NoLmSm82RZnx32qKFg6TIqJe5lpEizm2h
         kCRawLSDJFcpqgtzjmKSfqvwB2ymi55t550qaAKAGJdvPNNqAJn5Dm0yMpnRnzMqvM9W
         x0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775013967; x=1775618767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bFm59bSKTWB6QfcDL5i7O4Qbe5adgX1gyEfBxo1Yds=;
        b=CYpTBqPz48PbUTitBtPdODIIJq4ezXJ990TIeviRQTImoe1coqTCEtNGS7ZoZSwNRI
         e7uZvpnIxsqMFvaPKDBUsWxywL+9CyUkwcYhVQvcaHetyyWeAICCiH8J63/oC6FS6uAs
         //tycUS3oN7SnUWFV0EEpHs/69BUSrRctQhokopAKykG1abBY1QvHA387tpXdmlSdxAn
         YMvTIkTf6NkAevR6RgQklqy2wsr91O/oRk84hnjxx/JxWThJCf0ZtrCY2K0CaF6pBrvk
         0D0wOeOoMYp1mCtj7mPYND9q6lI0IUC56rCq131g0HiI6wt6bKo/B0NoTRzW5CKttbtr
         tmeg==
X-Gm-Message-State: AOJu0YwSgsXufwMRubzgvIJCSwER5krNQ98GiGNGHtOgvTzhoYNc8DrA
	cpp0uv2fcedpMsgdlb3JcIrjgWyPknPHC6rtOGRy921YGHjmubWbgScTPgoUy3oTQB+FXbILjXH
	rZ6uUx+Ai/BDxG7aXrP7HDTTjYeBitkhxWVmyqQxZXYpLYxQPSufOmXZwvu0=
X-Gm-Gg: ATEYQzxKkn4/sRGR1vHpAxHJz1s+G9h5L/zfjPJ6fuRRpko9p+0qXn2j4DDQXl8Vbwi
	fnK06LsEvD8ZkD/eCVcAde2ujPQvM6qUP/5bw8KdwznpQH9znMo+tfwamLsLtshVAa3s8miPevY
	hulBpmV5vUal9RT6X95t9cQ0xiIn7NqzslKcRkxka7kTmOyl0aA5T4JN7Zn0B07C8CmTdc2CTzR
	1GmKe54pVCLXpqqxTAYSIkJIy3yvcSOCousSNzKpDjtEovAGSMnrRfH0a0mp/HIFk6oZiMGiK4P
	XriakY4XxwyVULFJ0SThdPho3QLNzjnlYb7oaV7syTlSYUXjH9onf46Q872ZwP0eSRSacbPNUjb
	W4EwPAXZ0F90iOiTTbndF8ZX3+RUYg1idyJys+tccFelda7dsFho9s5peVHH9kI5+BTZgGyzow+
	RRJzXSAKXbxfUuQ48eWA==
X-Received: by 2002:a17:903:1a88:b0:2b0:c451:aea8 with SMTP id d9443c01a7336-2b269ad376dmr16365955ad.14.1775013966737;
        Tue, 31 Mar 2026 20:26:06 -0700 (PDT)
X-Received: by 2002:a17:903:1a88:b0:2b0:c451:aea8 with SMTP id d9443c01a7336-2b269ad376dmr16365685ad.14.1775013966244;
        Tue, 31 Mar 2026 20:26:06 -0700 (PDT)
Received: from [10.133.33.151] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242643381sm138942035ad.5.2026.03.31.20.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 20:26:05 -0700 (PDT)
Message-ID: <d86bf817-dbc2-4839-a490-8e332ec3308d@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 11:26:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: governor: fix double free in
 cpufreq_dbs_governor_init() error path
To: Guangshuo Li <lgs201920130244@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Tobin C. Harding"
 <tobin@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260401024535.1395801-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260401024535.1395801-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aGr6O4IFqHP1U6h22DibrSLenoyq7jax
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAyNCBTYWx0ZWRfX1EV6l1AzvGvy
 WnUQB6/wHk1VdqHc4BxsnFBvJqrqiXExTZNtxJzYbL7BHJxH6j4wJtaDKPKfAbYopilrVzZAPjN
 vhU9+ve6K8uG0KCQUEi+yiyoXh1mkaepuBNChFu90BSy2+WBFDike/c9/l5d6ZSozh3H1S6TQSN
 yOSewnobVuvtyO5PdwCvx7ofhgvKSGQhhvjFRvSiqkv45hZMW1UjkmxGJ2nNOlAvpXAVXwyWKtn
 xXkHHSrw0zaPUv+HvDRw3f8Lt7RuUHYftJAXf73gDAQIyBCNL8NCvXUu1YYKuQvkwkzfI2UtUKs
 eXz4Wrna8Pld4UYRDFICPem30Y4Yl5OOFV5+QorsoR+qBCLlp1HNwHpFjkV81kicVU3RO/Cedn9
 Ru+63isIYtdCs4UCulb5agt9UzeodjHyHotmvJA5tnklqNSnVelHPOY3wtAhlG/4CmSVYFXU6qR
 8+QhLnFNdUqHNNfsrKQ==
X-Authority-Analysis: v=2.4 cv=fJc0HJae c=1 sm=1 tr=0 ts=69cc904f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8TCDpgoCb24ZIsg9E1YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: aGr6O4IFqHP1U6h22DibrSLenoyq7jax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010024
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-232669-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 02912374640
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/2026 10:45 AM, Guangshuo Li wrote:
> When kobject_init_and_add() fails, cpufreq_dbs_governor_init() calls
> kobject_put(&dbs_data->attr_set.kobj).
> 
> The kobject release callback cpufreq_dbs_data_release() calls
> gov->exit(dbs_data) and kfree(dbs_data), but the current error path
> then calls gov->exit(dbs_data) and kfree(dbs_data) again, causing a
> double free.
> 
> Keep the direct kfree(dbs_data) for the gov->init() failure path, but
> after kobject_init_and_add() has been called, let kobject_put() handle
> the cleanup through cpufreq_dbs_data_release().
> 
> Fixes: 4ebe36c94aed ("cpufreq: Fix kobject memleak")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Thanks for the good catch and fix — this aligns with an issue I noticed
recently and looks reasonable to me.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/cpufreq/cpufreq_governor.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 1a7fcaf39cc9..3ad51a986781 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -468,13 +468,13 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>   	/* Failure, so roll back. */
>   	pr_err("initialization failed (dbs_data kobject init error %d)\n", ret);
>   
> -	kobject_put(&dbs_data->attr_set.kobj);
> -
>   	policy->governor_data = NULL;
>   
>   	if (!have_governor_per_policy())
>   		gov->gdbs_data = NULL;
> -	gov->exit(dbs_data);
> +
> +	kobject_put(&dbs_data->attr_set.kobj);
> +	goto free_policy_dbs_info;
>   
>   free_dbs_data:
>   	kfree(dbs_data);


-- 
Thx and BRs,
Zhongqiu Han

