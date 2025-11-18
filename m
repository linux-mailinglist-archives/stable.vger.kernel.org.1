Return-Path: <stable+bounces-195095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 596E6C68BE1
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 11:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60211381163
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD95A338912;
	Tue, 18 Nov 2025 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GzmP8zWb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ol4v3Qwd"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE563358B2
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460589; cv=none; b=r4dlbGvsJvWFTuMn2gXc4liZ4GMLZKJFJEkS8EsQleCeffWpKh2rTV0qYtmzOmu4eGX2B+7B9lY3Z2t3TW24+pcm7yuJQCoE3y8rkJH9jMV3O3qL4Yt53ntzNCV1OZFAt+QwrVW3jN+NjnhRaPnFVZp3OEPo46IPIDm4K4Z5S9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460589; c=relaxed/simple;
	bh=OqUORvbTuc3X0J/VSCAu/hr2s9Hhv+URzk8dOXhc72o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJeYFanqk+3DDeUQfZJNbcvM7qsS0+CJz3m64XOraSVbm0yyu0pt7/saQUApiqaCBoJnhOSQKFVdmTgtmiYSwA63XBS6dLpVDZ9yFwAEY8zvaoLJ5/37tRNpkEXWd9cxPmurMCgvBWa9ffs4zkMR6qvBQVQM0jh3/ec0zD/3ooM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GzmP8zWb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ol4v3Qwd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI2w9FJ375768
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 10:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TpA86malWsoC8khMUULp/bosX8u9eRqCjiBugIRYxnY=; b=GzmP8zWb6LZ+TQYq
	2YlKVJKFLi6qZA9tSJfMbgKW3CE5waFIrbAsCTuu6eIScK00r33Pv233EF/Fk8Ay
	w3qTpZ+PkhXLgVtpU6kaRSZbgRJs/kylg8B5HejSwP6W2hBmhk7Hc1vKrJGZQ0Id
	7yXn2grV5te3qPGf2XFw9jSu4XSAZzgAM83S8WeMQj2U7KeJf7+wgnD3oNKmVfcc
	dlWxyJR64rI+CPrnwT4JtkHTrGClgLj2RxUo8dRBvqeXYHnaXTJDBWAhx8ePvJMd
	nJEwc3QXWs+JFonu7sDhJCo8sQHNr2bDRmiugJV9b8Qziw0tETjFFGNfXcx3lzch
	5d+unw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag76njrcm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 10:09:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee07f794fcso9793481cf.2
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 02:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763460583; x=1764065383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpA86malWsoC8khMUULp/bosX8u9eRqCjiBugIRYxnY=;
        b=Ol4v3QwdAGkWKFSrlYKqLi1aIb/Wu5vIbWIkZujYf9kiVd19iFDtLMGOUI5VsBmBFa
         mojexrhxbjY69Wz5RPPSzHa9McE1YfgjI3haoBBLPvy1ISarDul2n2qvoS7WtjrThG9Q
         Ai5JgQzrp+OJS1muAqO2EQyHdoEB+nWTSqXu3DY48N9Sc2Eq7chNpCNCBtTQhQKZs1L9
         49Xe+oPFbhOy+k6elSYPIj5yqCMRg7YQ3vPsl6P8gsJkWn72ryFcs1JN6sC5LtjedVzA
         i8/TdKu45vH3Sq+rodJIOVnvVZtV11Zh2yiB9wakbcR3gbXxPZvGY72cdqSG0XkfTTxW
         wJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763460583; x=1764065383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpA86malWsoC8khMUULp/bosX8u9eRqCjiBugIRYxnY=;
        b=rE95n0VlK1R0eQeBG1a0ArU4sQ2ofLV1WcS2b1t4ZSQiAS1WdDJf5bOZPYojbOiSRp
         jMLAD6YBcqdTIKFlm2jIXzWZn3NkxeYKw7LklOq2laIAC85CXhDS0OozImZjVLMTQVyi
         ouBa4x4MGA+i0U/BvWubI+iQkM8J7rpDVtLTT14m7A7FTW9vDm+DJUMXNuztKXIrHKbN
         VcxoTcRlMZ0z5yV7b4+Leo+kmLjcsp8iTYO55KL3BcfCkmTIFEfQZVLR4AjjeGMCDwW7
         zva07SEdIf8pMNPdXBoTAKCOTca41HmAev+Ohj7+pxNWxyvJEuo0TsnBsuNsseZGBjoI
         s+dg==
X-Forwarded-Encrypted: i=1; AJvYcCVzn00i1fxThYorGS4JnWohzy0lrv7iYZfne5qCFUrVw8B+wxEqElTI8ergVCkgdl7DP+RDY3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbwxPZ2kXzkK813x61HZQfYcqFRWqIPIhvhsdUGdFXlxgBBgAW
	3ece58YeeMkVbNtKmVTeWVH2d7yHxWU2anBhPRTpkJIj4+bm119YSDWwlPlthBqClSC+hcso7MB
	vZMc2FP3fx0D3J31QAluIdbeMRtkQ3ME25mD2geD0QzlbUh/D3FksoreknpQ=
X-Gm-Gg: ASbGncv77hmDGLNMK/dGvR0RLvuW5iYokymqbwZk5tBAPSXPy9FT2dAQcTI1uVNx8aV
	n8Khfo7P56jTsSeloRdimsF/BeaeIXZ7GLirCAOShmuYGiLdEDgbPp1G4hVcigya/gLd1w3Hl2o
	5uopToQ7NDldQSsXslLFxeFoptyyr736OkzdT0bLHKH8QBAvgMnXYCBaa5/9jqqHS6mVsPnulkT
	O6MnTh4th2fLRt/Jei3iRoPaE2YGdqJUGVMB2xiFR3Hu4KF6pI5pFnjNJ9D0UFIL+oFMuA2rv0F
	lhE7droS8Xl3gEiONhgKtYvcYtwkgszTOzzSLEgr2b1EJWjYCxFcfBDggp1VZbhI/jGTU9wlHeu
	Xwgh/rVv+d7HeO5fV+WNergZT6IPiCOOkwRHeKR2vB84YZClNW4+WwXEdTEXwQZwarik=
X-Received: by 2002:a05:622a:10a:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4edf2087991mr148537311cf.7.1763460582662;
        Tue, 18 Nov 2025 02:09:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN59Q61Eb2CNlYDxQpBWVtF5VFujGxsR5/ckcEtaIq+KMFxkfUpWv8DK6msTFYM50HKOrU6g==
X-Received: by 2002:a05:622a:10a:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4edf2087991mr148537121cf.7.1763460582152;
        Tue, 18 Nov 2025 02:09:42 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fb11d94sm1306025766b.30.2025.11.18.02.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 02:09:41 -0800 (PST)
Message-ID: <0167a373-79e2-49f7-a765-d3a770ff2395@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 11:09:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/22] drm/msm/a6xx: Fix out of bound IO access in
 a6xx_get_gmu_registers
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
 <20251118-kaana-gpu-support-v4-1-86eeb8e93fb6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251118-kaana-gpu-support-v4-1-86eeb8e93fb6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA4MCBTYWx0ZWRfX5BF/wzCysJJP
 OVFrwRacBNqQ+NM86iBmKeZffUwbMNhlAMdne/Dsu29yPCogK8XJtmxXnYXSN1xwRW1oTf6doBE
 AfYVQ/EkNeArqA+k2KsjyKfcvLI4+WcKN1iRGxyHUmw2FwulgUTqCN7gPpqHS4+fodd0MIcOVFX
 96jGdYwx50+s8pD9Smvr2WLU8gUkU5Rj1nEfPgeezfObCEj14mW562eTc4UEmzeqAvQYeCokyA4
 vMAmlK37HU7hO1nUDeZp6WV2lNfIMvfsKVQgCqV0eFqYwR2ncDHx/TPUVf/5ujEQznL/jqNmCoU
 iyyu6jmMWu+2zY8QByp6lZi8zd2k1P2OOODDIKvf386enJnRiqipGjk1QPePDq+vbOvWiuj0kF3
 xLbmSgcBWY5KHFkfbLxFWGLqSJZVgQ==
X-Proofpoint-GUID: 5KNdXeGN1VKQhQuCXRrakdex7I0miWWR
X-Proofpoint-ORIG-GUID: 5KNdXeGN1VKQhQuCXRrakdex7I0miWWR
X-Authority-Analysis: v=2.4 cv=a4I9NESF c=1 sm=1 tr=0 ts=691c45e7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=MwKg9OkWFYoYUW3DDnkA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180080

On 11/18/25 9:50 AM, Akhil P Oommen wrote:
> REG_A6XX_GMU_AO_AHB_FENCE_CTRL register falls under GMU's register
> range. So, use gmu_write() routines to write to this register.
> 
> Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

