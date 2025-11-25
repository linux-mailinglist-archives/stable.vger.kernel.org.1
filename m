Return-Path: <stable+bounces-196852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF91C83582
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 05:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C90734E109A
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 04:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DFB284884;
	Tue, 25 Nov 2025 04:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UYY97Ywd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZyW1uLz+"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BA922D4C8
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 04:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764045595; cv=none; b=JbThYuTup702fYqEpQAbbZgwonJxJo1RAj1UMwnGDNQjtBCkeL+mA7Giw7ziz15SVz6XoGO8LbGKM6ftab725moOnHo7pv+jw8VWlJ/5AvMKurZdcB2L+vav5pQ+Ah7oNbs2BbLbsw5jO4OnX04w4pfGm8YVvrTpQ95ZVKljQJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764045595; c=relaxed/simple;
	bh=PqhXoX6syIlr7YWSSRKqka0qQvPciO+riWeEDaFK1Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWGGPXnhYjKUKvKtigrjSMnqVtbSN6ujkCDqkKwqNJ7kh+bELCkT98/Sf4pd59qovgt4bgPGl8gLXkKVZIsvHQupLnMXz8m5aZJUAz8G5n3rtICaZYfpYeJr0VQMfvC+hQoQTr3+dSln76kHNeEMRLB0QZO2zfOpXqT/M1L/HtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UYY97Ywd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZyW1uLz+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP2givT1741153
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 04:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WKGJQRmKN668jJatHPk6H0FjYzmlIbNO0WQvdoTrBI0=; b=UYY97Ywd6nInmUh+
	Ae7VAqZjm7cH3iRelQK59JIKMEHz9vuWtLRz/Z2dKseSxz5ijYXJbOmxM/OHU4EB
	PBZAOCrWjC8Ex0qxSOp2to0WXoDlmyrDJ0xyt99Auzn9TqpxYx4ir97BmQ8BCofz
	GRWzfE2/m6K3MA7c+jdfzKN1ZicVxr8e00NYByWaIwBJsrWMf3QcKKMIv7jQ84hv
	ZY5Z9dbORWKVsYPY4dR8wqBodnW7F7U57wJaxm1bkCNFJByNzt+yHORgZLvj+Pus
	xtpnWdlm3O31+jYFSZe+JQ3yuptr7o+YsUnyyZPTFvASQp/++oGYh3ubCZmdZE08
	GiWPqg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amteb9vtq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 04:39:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2956f09f382so30851745ad.1
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 20:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764045593; x=1764650393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WKGJQRmKN668jJatHPk6H0FjYzmlIbNO0WQvdoTrBI0=;
        b=ZyW1uLz+TNYpXfS9nljYLDQy6Aj98sXpp0mDkjpPPc9De0Asa38eWj5IJG+5prqf7W
         /u0D2nRNr5LxvF4p072njzfAqcPHxzLqbqxAvQO7Q1LA6NAkr9lIV/0AkWzdVuMhIxZG
         +y9R6H9RZX8c7IEOPanv52WyJGHeGoeJOTXPQBOH4boLP6VHIHSr/87oo7EOH6bzA8kK
         bJ79TAOkCh/HFKDAmIgs1ZSnSv/j2ZFZO6pKPg6jKOZWqE80fIFlscjXf9JvTTWYjY6c
         JYBOxcG3XOCXG5nQuY2iZApx2XrKOgdI5XH4pX+VbpJEnBCzw8ky0o4IKH1hlhDfL9q6
         +htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764045593; x=1764650393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKGJQRmKN668jJatHPk6H0FjYzmlIbNO0WQvdoTrBI0=;
        b=gauT71W/9T4Vh3/xO5luOn9N0uXg6OEdCcSXusFG86yfHoO95RqCuNLhXu1tpuCO+F
         vBtzEeyjycxRZOi1Ent6cPS9O480cCqEYsBcf44LxlrWziYn+inQQM17V6UyxnYV4005
         Q/uGzII/cgouOSt0UgMTBd9HJeAd1p3cq4kb2x+p6NNdSSH0/PH1ofa42DDJNR1j0byI
         dad9Y6NiK87e6hXoLLNuLbLa0rgZ/4OWJrk8gq5zS5aNvkx0GHMOva0dynj5Avum0KXk
         COJso0p956ShO8ailysfYLab17jRCQVkAg5ndK84e5umYG4066S8LPmK7Zr9nRhujldi
         jktA==
X-Forwarded-Encrypted: i=1; AJvYcCWAU+iLI+mlr283jtwY1UvAbyPv0GKvUl8VHP311VRAXnYJeuepHFFjZWYecF0njnJxIo/MNs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEsYXX7snKGWC8GQz0NAWq5qtZfDerawE72fg8xCMfZxRCbHik
	Zmb/REhMsmiEkdhEn8Iaoxu4whlR+EeCUPlZvueRoxfUWdjYdzuHDXDLPQeQt8JNwEtsCOM+sxF
	ix5k31vhIqe9xwqptVJw0L0pLVLKPeSXtA7wOZW0hgECD8ks4SpFsS7E+dKE=
X-Gm-Gg: ASbGnctRgaR7UZziQX+eLaSd4uG16YawElHnb2qhRlSCQVKV6CvGEiRDrrlHQI9+SsG
	BLLXHjwyNdkzPjnG0rWbwE9x9FDNFKLEaqLY82IpasT0oBcl4By0BDVFekkfzC3/J+LiAg4WDkX
	hzgclQcur1Ev7UXNF4qzuUQTGyVmvDBexxgqV+q3Yxd0ByRieHtLwuM94jbKu0Sojyl5ga0CX6Y
	+9UsxLUG7sz14yrNQFjIYXlgyrOFcPQszkmNAJALDWNVoysZgXWzNBsWU7kyYGC6/sqDQ3jWeWa
	+XZpAde55hcOQsRKN5oFvs+zn5J9oMZcR5n/pp2fW7NoGa8HcsdCmtgNkJWHMj7OozDghkkKKyX
	440P0gebPslf4CZ/+gBsgAfhUmNgOsNV7oSMt6e9Z9g==
X-Received: by 2002:a17:903:3c67:b0:29a:69d:acdc with SMTP id d9443c01a7336-29b6bffd87amr128408285ad.25.1764045592778;
        Mon, 24 Nov 2025 20:39:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrUh65gzF34YTtoe7WZeNXxWSJVbbsWN2fH6U/+v9lEO6lwtOlTOXkPO/OwueK9HnEl8fClw==
X-Received: by 2002:a17:903:3c67:b0:29a:69d:acdc with SMTP id d9443c01a7336-29b6bffd87amr128407905ad.25.1764045592070;
        Mon, 24 Nov 2025 20:39:52 -0800 (PST)
Received: from [10.0.0.3] ([106.222.230.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b1077e9sm154734895ad.15.2025.11.24.20.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 20:39:51 -0800 (PST)
Message-ID: <563d673a-19e8-f161-ab2f-6e8acd420531@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 10:09:46 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: venus: vdec: restrict EOS addr quirk to IRIS2 only
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Viswanath Boma <quic_vboma@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Renjiang Han <renjiang.han@oss.qualcomm.com>,
        Mecid Urganci <mecid@mecomediagroup.de>
References: <20251124-venus-vp9-fix-v1-1-2ff36d9f2374@oss.qualcomm.com>
 <2622656e-9abd-4407-b1fa-228da9959d60@oss.qualcomm.com>
Content-Language: en-US
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <2622656e-9abd-4407-b1fa-228da9959d60@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BF2SPUmZJSgBxC3nOSiHL8tDer9qo2IB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDAzNSBTYWx0ZWRfX710dnVNf6rf6
 FHo7nkau6gHaWoLfkm8GEiPcUoEb8dpkh8k0QAqHz1LNZt+/aBqjaJLyQEf0rYuNn+hD5PDf2DT
 2Uw1kiEd14K0+VpLNZDZ/AkTIezPb/LMTMh7dR6x2oV2tkj30PwNqQ7Mac5QtKlyBHaWbYU7BEp
 LD3Xzf6aCuKi6y11aRc8WWiuAhWwtawY7bD18kyDFYLyRJf0yG6l97NhAxD4GFSocmODpCo86fS
 HwcQtLfjmF0Zy/XhoVX2CU75Gt1xlBVoadVwXCXVpvvuLeBmu9uetx9lKX2Rgt9bpxGlQU990v0
 t88V0t2isKTQxve7z5UwpNy/8ws34goIZZki6PVN0HSazshsJ4fofi4qyjgArB/OEXUzXlDcTSY
 4ARvoKGf6llA6AkXki1xGYhZLgJQig==
X-Proofpoint-ORIG-GUID: BF2SPUmZJSgBxC3nOSiHL8tDer9qo2IB
X-Authority-Analysis: v=2.4 cv=d7f4CBjE c=1 sm=1 tr=0 ts=69253319 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=12FOtvgV4D2gsqRYbU+y8g==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
 a=9Av3R2nQW4dSFDgMc8UA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250035



On 11/24/2025 4:36 PM, Konrad Dybcio wrote:
> On 11/24/25 11:58 AM, Dikshita Agarwal wrote:
>> On SM8250 (IRIS2) with firmware older than 1.0.087, the firmware could
>> not handle a dummy device address for EOS buffers, so a NULL device
>> address is sent instead. The existing check used IS_V6() alongside a
>> firmware version gate:
>>
>>     if (IS_V6(core) && is_fw_rev_or_older(core, 1, 0, 87))
>>         fdata.device_addr = 0;
>>     else
>> 	fdata.device_addr = 0xdeadb000;
>>
>> However, SC7280 which is also V6, uses a firmware string of the form
>> "1.0.<commit-hash>", which the version parser translates to 1.0.0. This
>> unintentionally satisfies the `is_fw_rev_or_older(..., 1, 0, 87)`
>> condition on SC7280. Combined with IS_V6() matching there as well, the
>> quirk is incorrectly applied to SC7280, causing VP9 decode failures.
>>
>> Constrain the check to IRIS2 (SM8250) only, which is the only platform
>> that needed this quirk, by replacing IS_V6() with IS_IRIS2(). This
>> restores correct behavior on SC7280 (no forced NULL EOS buffer address).
> 
> This really needs an inline comment, since you provided a long backstory
> explaining how fragile this check is

Sure, will add.

> 
>> Fixes: 47f867cb1b63 ("media: venus: fix EOS handling in decoder stop command")
>> Cc: stable@vger.kernel.org
>> Reported-by: Mecid <notifications@github.com>
> 
> This is certainly not a correct email to use... it will at best bounce
> or get ignored and at worst cause some unintended interactions with gh if
> you have an account registered with the email you're sending from 
> 
> I opened that person's GH profile and grabbed the git identify of a recent
> commit made attributed to this account:
> 
> Mecid Urganci <mecid@mecomediagroup.de>

Thanks for this, I tried but couldn't find the proper id, will fix in v2.

Regards,
Dikshita
> 
> (+CC Mecid, -CC github, fwiw)
> 
> Konrad

