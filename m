Return-Path: <stable+bounces-148059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC99AC792C
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 08:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334124E47E4
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 06:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C412566DF;
	Thu, 29 May 2025 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oEc/H7ae"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15FB24BC01
	for <stable@vger.kernel.org>; Thu, 29 May 2025 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748501219; cv=none; b=T42VbyGmchyhMV7Qf+cqn+ah9zKjH2c2xfh+j4jX2b4CkJmJMmN0pB5MpgVTS8uCjzeBL6/J1xn6lBmQk9x9BJTKA8DuQXbfRCZEtwe6Edi5y4hMuC7Q2LTuopp9A1h5PEBRcfsjA/EBfayH6UC/kl8Cszc3lRjdBfeQjxg3ihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748501219; c=relaxed/simple;
	bh=psTx5DnqTcqc7rdga6X9dADCvyDhDYFwQMHtamg1P1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUoQQE/boI3c4WWc7Q1HqSaDlXIi5R0o80jDyee8KZ+P40Ubw434+h9EJflTCafhxPtVr/70wxHWzsi3OaOD1NK9BquZikqnlzXINF9yb1jIlmFo9aFg/cXeRKOn9p7fIA/OQJLO4fhWOtAELuaXF31s4veIIFTkZCPFSrnvxTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oEc/H7ae; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SJB69c008744
	for <stable@vger.kernel.org>; Thu, 29 May 2025 06:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T8PGsXyBDZ5H+JaRIX2npxMFHOrT7ZZSDbAslLTPf2k=; b=oEc/H7aedWKsUc3D
	2rSog4WRZQP6dVmuO16IWE+UffwL7cHKyDWipnoKE/GreAM3eyrw32j+Eilhoxoi
	yS8wJISqBvEx9IEWJdFDZJLEyvFJwjNqy1M1EY0l/eSZ4cesxxwfRnDYdQbTjhbM
	YVuI+VvB87LcdZ/GxMLHUlmgcYNbW679a8rg6TkmXFCLdnjBCNVbAA6PqTT5UIcu
	qAAujQ3ZMjcSkK0CA1gVSGqQn5jkW2XbfmcQkHBJc0hinmQtm2lKK9q/a4qGyIKf
	gmItCi9bSKsJUCPC8LObmC2AiNj4mLJPWqDrtwmdfyN3picgfaz5AgQr9kHQEPIp
	ecLnsg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x8d79f6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 29 May 2025 06:46:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3108d54d423so1365740a91.1
        for <stable@vger.kernel.org>; Wed, 28 May 2025 23:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748501215; x=1749106015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8PGsXyBDZ5H+JaRIX2npxMFHOrT7ZZSDbAslLTPf2k=;
        b=PBqrsQVsyp3bin5O21nvYAWxALvIFUw8stlQil7KiS/NiDQNnyJlx0mSDtTueQbqFo
         8erFQaOPCnHPuB/ePGO4la7fqx4/QqlVC30pqOJ/gfNP10vjhncWLnoEDyIQb/dzDh+x
         eusxxet6+40fKo5Y4grwe4oyIaTCw8EKQLD0C8pOHkBnaWPEcHQB0Tk3CDHa4JHCEXMa
         MqgyR8C/9tasxHCM7c/2055q5dfG5OT5H7JWRFHKiyK6z7sMFS/jBUiXqcY3sSDm9nc5
         gbEYTyU89k9triN8cSlBSEki2b4PFki0sNd7nCLnPR35YKmI1QFOPsAf19GOo2tid3sb
         ByLA==
X-Gm-Message-State: AOJu0Yw3F47mLydWWGZkXM/9mU9YGHX5tzWXGpgA/X8ByLgPWzHJjBfR
	8USc/v+A9jAb1wrT3k1Sm6OS37tjXaR37szT6WMW49hOsDeNADopEL9quipvTNHSaZJqkxAYtbc
	wfWeoK8U7dIhYYN5S7QjTCRN0Vkl+s1gFAhGDTyXe65j3GdTJHorAGJ8cHQo=
X-Gm-Gg: ASbGncuSi4LhpC3VSFDeiYCBEV26GLih7ujVcCMi7X/8qvZ1ulDoFFWL8/F0eJtl1Mc
	ennWRi5IBin30Zn0EOVi9z8WZk1kYJnJ860HihRQta8MtKjfMyiaiQtQ5b5RqZy784PdvqtbDiq
	krNuEIZe+Jp6kWHiLBeHKxz1keszjgUrvCKJiLyGTdKApKwXHAOR5MrnxhtAKUk2gskDnp4D68E
	g0OqDj06eeEdZjhVocmQAe5Q5urYvDacUQ0lDzWAJRICdBA4ojqb0+u8h2NH8shfjGngXKoI/bV
	tqNVDVTpvbcUvHGR3QYj71PVt59XxwFTHUUtWxTQ6IIijZUpBM9sMH6HWz7G3nbfmRo50Bn8sHX
	r
X-Received: by 2002:a17:90a:ec8f:b0:30e:5c74:53c9 with SMTP id 98e67ed59e1d1-31214e70c6fmr3707567a91.11.1748501215074;
        Wed, 28 May 2025 23:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3+tA0etXLR8LyoSKB3yEpu2iofzywi/K5UpRcAuWOpAuxadNSDcNeFAVT33hT++YFoC4ufA==
X-Received: by 2002:a17:90a:ec8f:b0:30e:5c74:53c9 with SMTP id 98e67ed59e1d1-31214e70c6fmr3707541a91.11.1748501214650;
        Wed, 28 May 2025 23:46:54 -0700 (PDT)
Received: from [10.133.33.104] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3121b91b063sm710878a91.21.2025.05.28.23.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 23:46:54 -0700 (PDT)
Message-ID: <a9f260e1-c632-4955-b7d4-98fb024e2989@oss.qualcomm.com>
Date: Thu, 29 May 2025 14:46:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] leds: flash: leds-qcom-flash: Fix registry access
 after re-bind
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        fenglin.wu@oss.qualcomm.com
Cc: stable@vger.kernel.org
References: <20250529063335.8785-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <20250529063335.8785-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Sc4tPewkFmN2Q_-SemkPbrkOG1ICCNWo
X-Proofpoint-ORIG-GUID: Sc4tPewkFmN2Q_-SemkPbrkOG1ICCNWo
X-Authority-Analysis: v=2.4 cv=X8pSKHTe c=1 sm=1 tr=0 ts=683802e0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=nBHSmvIfuyYwa36IIZEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA2NCBTYWx0ZWRfX0tciit7j+Sdp
 eGExFf6cIHPRRsToFpEpZCrPVHqnn8iJ2ptrQ0b/iI67FB+axNh+Ep8wyjRrU0Fq4vZ3sqO+ML/
 gV4WMtu0gZYEGsjgakSP8CgqduAGZlwzPF3PacMDbsjPI1K9QWIx2swqBiWyrSfVFhw7e6/DCrI
 i2CfABxi6rHH9NahhBWcYlm8gKGMq6aLwli3N2YAH/05eUEHklEQd0sGL7wyJAaR87B1R187MR9
 c58A/PPHExdmBz4pYPdQeHVkG3+DEz5smaVTH8Zw8U+faEM6Pxq3nYKCPP6Hfg+t0KapvqkPtGZ
 OcwNfFnHAOTSJqSVus8h9FAoiHztCDxvZlFVFmmwkP/kCbm2BwVzmZxPqTdHQMpBY0LoS4H1usV
 kj/+4zuNdnagDYG9o0mrgq6CpEcLF+h6CB/19Bb2jOGVsojh4WVCU8a8xpVEbTSQDiip3upb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=534 suspectscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290064



On 5/29/2025 2:33 PM, Krzysztof Kozlowski wrote:
> Driver in probe() updates each of 'reg_field' with 'reg_base':
> 
> 	for (i = 0; i < REG_MAX_COUNT; i++)
> 		regs[i].reg += reg_base;
> 
> 'reg_field' array (under variable 'regs' above) is statically allocated,
> thus each re-bind would add another 'reg_base' leading to bogus
> register addresses.  Constify the local 'reg_field' array and duplicate
> it in probe to solve this.
> 
> Fixes: 96a2e242a5dc ("leds: flash: Add driver to support flash LED module in QCOM PMICs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Reviewed-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>



