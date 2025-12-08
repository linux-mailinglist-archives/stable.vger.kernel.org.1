Return-Path: <stable+bounces-200337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED970CACDA9
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 11:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99095303EF5B
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E68A30171F;
	Mon,  8 Dec 2025 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rp1DHBk7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TMgtCoIt"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12AB266B67
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189559; cv=none; b=hfdoo3aLu6QZVswIxOye4mV5MVJE746WTldGdqthoMBgYVhezS4EmWRoIMM8/VJw0f75+cAzypEVRwpEd7xxglRSNyXOtuXYqZaBHRXTxWyeD7jFLl+hbkS4+yZBMi0ZMrITn218QGIchYIeyjk3akevbLbV8mfpqV+MqbhRCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189559; c=relaxed/simple;
	bh=CFdVGbAK5X4m8wQ3xQyQNHxuchIc/pQWBeMbX79bX/g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E3mtvwKLnjNl7UnOdwCoKdoszBlX0+tPYLxyFwssJx2b7hsfF8hMZ73z17V8n9m/kEGN3WVCrCsZoIEPaWBlgp5IV8O+0emi8bqzA8Lrq4kwcvf5RsTLeiWjmQP8NATjIJtRBli8xIbsPkgR4wLLE2xch7lL4IJ2aYYB2dPvOaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rp1DHBk7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TMgtCoIt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B88ZPTv2899520
	for <stable@vger.kernel.org>; Mon, 8 Dec 2025 10:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ulpUzcOI0DOsr/m9KEAJ8744zQ8VdOfiauSWUgs8hgE=; b=Rp1DHBk7C2eRzrSv
	NORUK12i3AKIdww5kyw6l+rY4yA/6xy2fKPt/vXsTvikhjBXM7GqjwH6R9IYgjMd
	zmnb6pREVZgkC9D1e3P7Cr4vJSMjdHZzcscKmPkcw/DIV0G3fbBafiOlr1qAnBc1
	q96YrCyfvhc54EuYMeCMfme1BBAk28/kXRXsc4+5h05g7BRRGDWZrn8B91YBfWw7
	LWy3nlLFNUUqWO1ksXEYS+itZ7x54IHC6NpcX/QA50YmAR1xghCSdbroQ6uv00bZ
	j7tBp27r/27FHOhZEbRJZSPNHwvUkjidQJqtgl+21mGYPE9ZAAJnTKgSZAmg1Z4b
	ZfHk0Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awhaqsmwt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 08 Dec 2025 10:25:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b630753cc38so6371282a12.1
        for <stable@vger.kernel.org>; Mon, 08 Dec 2025 02:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765189555; x=1765794355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ulpUzcOI0DOsr/m9KEAJ8744zQ8VdOfiauSWUgs8hgE=;
        b=TMgtCoItgdSnSRdlPYeVnG8HwHiGD6NPQZWO3QSOeMlFxRgXR454Rj5E0NIVwwb8VD
         7XhLYmOIZaO6BxgaswRgKRUqTDePYoph8zByqU3O4iIz78h1NL9uhcCevSUSX78+M0+B
         6YSiFGVyukTy+MdNGnCRzqyJtkL2g8MUyFBVwOWopQD0RxvIBG5Sc+7jVS6IFuCwEHqe
         L55xXMjVir+Z/jQ8ja+M7u72aQL1lLqkMunvM+1cszY2wgmVxIyeQKkwZ/NZUF0XadSH
         bjIzmYoGe2ARs6WucA2k5Chln5m+E77jB7RZryv7HD5+EI9Y935PNrLE1gmXwn4RIPNr
         OaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765189555; x=1765794355;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulpUzcOI0DOsr/m9KEAJ8744zQ8VdOfiauSWUgs8hgE=;
        b=W/qYIa4PJhb19FbnkygXqedaiOjxfOfEsEz3FmJZCSKVSNcIBtqcomSnosz+EfSFPO
         +lEck4B/noxuDvq12M71/hzZrFuJIBJ+4p+XigaEDN0nN+dCgBgTJr82xVUCMXKrnwFO
         onrWg3JL6KuSGe4Am/60zEv+KTWpglSksSazJIX1FIV3gEgp6sdMOS1PTLJuDx6oKlXM
         G25uNaVUdkBvy3RERnYasIYQUW4pNFxPdHCz5g/tyabWby5DP5FjM5XrTSb/KzHa502G
         DIqWMOLSATDYBUsuY+U9es9NVKB3KuLufuSTxTvoMSTBEDd8aUVx1EgmUCV8q5S5HPGR
         lAPA==
X-Forwarded-Encrypted: i=1; AJvYcCU9H8+thpkD2xm3NxjOts5jCnamlUMNsJkzFSHD3TiGU7Gsu3cvYy9pI3hHsxsR3FAuiBiWx8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJE5IxA6N1lMCz/7H2UpRYOf/SRsT+xmxe/zNcojsEeIQxn+H9
	AvFdHO1sig5FH+m53v/ujv2yv6smO/ssY5os5+XYFgaNFrcSUcNu6F81FZufs1fqYC5AXTVAevA
	W7Htk8W3emcI11rX/bI897AWw7WsN+J7I3AZOnf62pnAwodJUBU5YDjjPtNo=
X-Gm-Gg: ASbGnctEVvMgwCck8wYN2rviDdYyDu9xwvl/FrUB03PLUCBMPuiwN1TpVs5sXeoWm/9
	Ku5TkMJc+DgbYGQKdFsv+NhX9VT0+Cq19e8i3ukUWjWmqx6A4lHXlPI0q172VCFLp44mXkLvTD4
	elPw5tahE/ADh5spiMaE+a6OntF81u28rxGDpELOm4OSS3GW7o/KSXHZh9vq0cPyLZ90w1xw5Lg
	xTm5xJ5ih4QA1VgqrNaGez9VcP+kD+S+4LlGd1mQShB4BE69iP9d73M0+xlPwFV0Rtb0BlWm65G
	0z6yv+on/ns42WSgMS/GmY2+5yHoHNLQrsbY4ycYVku2Veb0dKzn38Y00n7Rdmjs1hEkOUyb1H2
	spAMYDGtiImIK977rFKe7AzzS/tSxRK0fvEN3nuSt3PAg97AHhH+1wEw=
X-Received: by 2002:a05:6a21:85:b0:366:19e9:f43 with SMTP id adf61e73a8af0-36619e91026mr4486314637.6.1765189555515;
        Mon, 08 Dec 2025 02:25:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHi4NgRf4xCP5w/2kWJWdtK5tmc7qqJ+20GvzzvL4l1ADN7TyD9p63Q+t6ddAUDt4M0XxPXQ==
X-Received: by 2002:a05:6a21:85:b0:366:19e9:f43 with SMTP id adf61e73a8af0-36619e91026mr4486301637.6.1765189555057;
        Mon, 08 Dec 2025 02:25:55 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6817395ccsm11711435a12.5.2025.12.08.02.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 02:25:54 -0800 (PST)
Message-ID: <cbf3e828-77c9-8291-1328-7e876a8843d1@oss.qualcomm.com>
Date: Mon, 8 Dec 2025 15:55:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: ath11k: fix qmi memory allocation logic for CALDB
 region
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, jjohnson@kernel.org,
        ath11k@lists.infradead.org, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20251206175829.2573256-1-mr.nuke.me@gmail.com>
 <01a05a49-ae5f-a3ec-7685-02a5f7cb9652@oss.qualcomm.com>
In-Reply-To: <01a05a49-ae5f-a3ec-7685-02a5f7cb9652@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDA4OCBTYWx0ZWRfXysfWPQns+PQr
 3O4fhEb+IFMbjzbgeb9vVAD5mTAnxntQ4TNFVjTc8PP11gATBD4R/3QAkp+pwj/AWiuiCVzLRdM
 ODV9xNaw5XJ3VMzEe+Ga/Y2Yrdt14fJfCEhkggqEmsynkoIw5qxsFaa+VQBsfMF8KE6DW4fscWb
 89cYVXLKgMJyQCJ2WHV8YYVXvneD+33+XbAmqVFXnguwUAtDiLHQWB7QWNC/TJAPGW2kPk+TlRW
 yzd+YXKXRahcFqRLHWGWy9SDEQ2LEAguxmIceTZGrz/Jjzwxn9FgYsS+DOH5ZxZfhf2/psENX9/
 oY4bI270si66auRhD6BOgxCgOY/5kYhk1yekZVtG2P5fBGpMmDFmvghccBbSqyEc4ibT6WwmCoN
 TC7BmwC+xQTHWzBWjRulNCqgdv3csg==
X-Proofpoint-GUID: YYV7wh5aVwPueAyb6olxNtC-QYMnywoo
X-Authority-Analysis: v=2.4 cv=ItUTsb/g c=1 sm=1 tr=0 ts=6936a7b4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=cJq7uKxvQhbKIWGweLgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: YYV7wh5aVwPueAyb6olxNtC-QYMnywoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080088



On 12/8/2025 3:38 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 12/6/2025 11:28 PM, Alexandru Gagniuc wrote:
>> Memory region assignment in ath11k_qmi_assign_target_mem_chunk()
>> assumes that:
>>    1. firmware will make a HOST_DDR_REGION_TYPE request, and
>>    2. this request is processed before CALDB_MEM_REGION_TYPE
>>
>> In this case CALDB_MEM_REGION_TYPE, can safely be assigned immediately
>> after the host region.
>>
>> However, if the HOST_DDR_REGION_TYPE request is not made, or the
> 
> AFAICT, this is highly unlikely as HOST_DDR_REGION_TYPE will always be before
> CALDB_MEM_REGION_TYPE. >
>> reserved-memory node is not present, then res.start and res.end are 0,
>> and host_ddr_sz remains uninitialized. The physical address should
>> fall back to ATH11K_QMI_CALDB_ADDRESS. That doesn't happen:
>>
>> resource_size(&res) returns 1 for an empty resource, and thus the if
>> clause never takes the fallback path. ab->qmi.target_mem[idx].paddr
>> is assigned the uninitialized value of host_ddr_sz + 0 (res.start).
>>
>> Use "if (res.end > res.start)" for the predicate, which correctly
>> falls back to ATH11K_QMI_CALDB_ADDRESS.
>>
>> Fixes: 900730dc4705 ("wifi: ath: Use of_reserved_mem_region_to_resource() for 
>> "memory-region"")
>>
>> Cc: stable@vger.kernel.org # v6.18
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/qmi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
>> index aea56c38bf8f3..6cc26d1c1e2a4 100644
>> --- a/drivers/net/wireless/ath/ath11k/qmi.c
>> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
>> @@ -2054,7 +2054,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
>>                   return ret;
>>               }
>> -            if (res.end - res.start + 1 < ab->qmi.target_mem[i].size) {
>> +            if (resource_size(&res) < ab->qmi.target_mem[i].size) {
>>                   ath11k_dbg(ab, ATH11K_DBG_QMI,
>>                          "fail to assign memory of sz\n");
>>                   return -EINVAL;
>> @@ -2086,7 +2086,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
>>               }
>>               if (ath11k_core_coldboot_cal_support(ab)) {
>> -                if (resource_size(&res)) {
>> +                if (res.end > res.start) {
>>                       ab->qmi.target_mem[idx].paddr =
>>                               res.start + host_ddr_sz;
>>                       ab->qmi.target_mem[idx].iaddr =
> 
> The rest looks good.
> 
> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
> 

Well, since CALDB_MEM_REGION_TYPE will always come only after HOST_DDR_REGION_TYPE we'll 
not be running into this issue in real deployment with ath11k firmware binaries available 
in public.


