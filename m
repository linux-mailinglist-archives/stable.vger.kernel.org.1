Return-Path: <stable+bounces-188313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EABBF55D4
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 10:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BF83B269F
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 08:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63603328B7B;
	Tue, 21 Oct 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hO+9qRbk"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7930BBA3
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036713; cv=none; b=t2YUfgajLv0n0h89evI8NMUcGmI5iLOsiGXBnWoc3NltlBDqcTkLgPGhOzZkjB34sn19FTYL4yq+msuCVV8+/2luVWf0k5zvB5yM1fq5jwIq95mqW8LBVKN23hOziZtdeLG+KrXX+7WmalNvXAnmVjfJjX/C7NvhAcB7C/YX2v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036713; c=relaxed/simple;
	bh=3Wm+qPQCGhquC1sqPqCbWcCtKdc8Ariy7FO9EDJ0/ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FS1PL2eIwFxjVXAmWgVEYzDiFQJakKO7o70uCu7QKwOiI9PexXP8Qqqsp2xahOucQzPs5Z/r02L0aLcc15tzeAEhf7VAN04jxyfmzrVRCqPHZiivyfpaEkQYTvpIb4i1JBD60Xv/vsVdsnCNswzRKJ0P06kzJ1iLe1gAKP5aUAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hO+9qRbk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8OYAS029835
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 08:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Cu3mLCBx8dTdYk1x4AduwRqyoGHAAaN2BS60IdnX4E=; b=hO+9qRbk+V+obYOn
	rHu3WRM36xGZHGHQPFTz52aBhWND7Yx0cUDCMo+8rB9fa215pPpgpBLiHI1yQfMl
	9CirO5aTGBFSPQEmNqN5ZEs2yfes55/mQbR7RN+vAwiKnBbWbItzuqgpcRbtW+jH
	aAJOmQ5UBLbzpCa+wDally34XZJYFaPbtF+ZBHdqKnyh5boIEctDUwy/02/H/Ovj
	aE1dttX6JgHoo15iO3TZioTT6jk6I74+JeCgBxD1R840IzHglJp05PRd4ZDL7wVs
	ohj/8TI9knQa+pd0Eo1TaQ0sRytdbT2925yDRzcE9GENSous3wcsVDS9BuEyzj8C
	C2OfgA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2gdyyy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 08:51:50 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c0e043c87so24079076d6.2
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 01:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761036709; x=1761641509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Cu3mLCBx8dTdYk1x4AduwRqyoGHAAaN2BS60IdnX4E=;
        b=OKBGuFS51QzF27xCveoK0hUWa0aleI7g/rpcsuCjPs5XS54ZSWJ/6FkAhz/Cww+uXF
         tZx5yAFDqs6Vy00L++SoPChWN7d06qEatxgd5ca+71lsBnI2rxwCBVaodXj33yOME8Yx
         TalECgTQ+y3/YyqfxnUdoskDqs/gJeQwePKreAErQovVp/Lh9J/cFLuh9oughKJQbi4D
         3/9Pl8fhAmUvblHFFLuV8a25MgRKdf8FgL7zWEDnZQucbQY9uRwuwp9+JGgTqh2fNKcO
         S5BKyNB3tZtJfCkKDGgCn2INRZmyqZRRq+x4Kp1Y8hm6BDLJpAs79xhFQYr5oSCvP5ez
         0k9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5aOp/WKsksZMwB8VG2Pv6RMpv3Y7Vx+P3oolJWjt9aYBz47WrzN0omdoNjka79jUZQt99HS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8PWf8C0NDnkCm/2Vi3WqMhyVqccvqtc+E31u7i+fayBmOKCzI
	Vbd/AJMYGarZbYFmHU0vM/YiF5Q1gnU+fvbJyevo203+QGbvP2QzqnRXOXIka/qJJ/cz+m1Ha2t
	7RbHmPZokypButvJLS4/VohbMdLKHYnf7SKXgPWgaIRqrkgI+fwusQ9lHFuOUI01zfx8=
X-Gm-Gg: ASbGncuNRNRlZjRZvjbcT9/3c4TITilMv0Mz0chrSEYRcxIus7Ncx3pdevj4u2yucPw
	2y2cbw3uE8sXWQS0HDRXjTw31pTTzn8gkQIc624obdf2LUWfyQY3uExNnza+HHGNB+MFuSbAHm8
	FyZHvK3Q1Atw80Lj1K6B5XsGq1bf8POZf+VlBUD7wH/C31OXo2DX+moyP+rXGL1pDDGSOxS+luS
	MxIndZlmjapKYkDBICWiekMANanznFa+V/yG50RlrjHgVTGlJicbc19VaAH8/jvVz/TKH9zq77l
	SLqVe2EWfZmffgfp4sb5XkY/bRR4ZcDv31lnxSPiEJR9m6v/xFHxjNphVqu/SjovRIOJdOdc2Ki
	o3emaBAONXoKN1RMQu1um2TwUPX3L+DJsezWTSS6DQvAv/UsrP5x8YhDR
X-Received: by 2002:a05:622a:548:b0:4e8:b910:3a7f with SMTP id d75a77b69052e-4e8b9103edemr75870121cf.13.1761036709404;
        Tue, 21 Oct 2025 01:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo/ceLdhKb/3TFYDA9gwxyTc8Bl+sCozFYSPjysEgI4X636LoRjzay/S1WPzMNJ3XSR/vJZA==
X-Received: by 2002:a05:622a:548:b0:4e8:b910:3a7f with SMTP id d75a77b69052e-4e8b9103edemr75870041cf.13.1761036708945;
        Tue, 21 Oct 2025 01:51:48 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48a91e86sm8907155a12.1.2025.10.21.01.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 01:51:48 -0700 (PDT)
Message-ID: <1b25aca6-da6a-4f83-a0d0-b1766110f83d@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 10:51:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: gsbi: fix double disable caused by devm
To: Haotian Zhang <vulab@iscas.ac.cn>, Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20251020160215.523-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251020160215.523-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX3RLXoXupZor3
 XKCLvNxXtoQpVfc32I5x/eVQ7UHd91xUoF0vfP+nvB3BNxx1IqjphrBYsK+8jufjGhGPpCN1T6C
 OKV+FAgIvC8kvCLyaUyaeBOlPG3xDVh8Lfsym1GRT7QtzXqJJDBzRU0WgdbvKChNPVtfOfN9Qo9
 7fmtRsUi0cWYq/8cz6Vka4Cqhb3RaaXl7FrAMI8vetHNVHzpK+pGoGxU7RstuDZpp7wUrvVrfc5
 yjmeg0z8EGS4RabJgGUQjh1yExNBsCud0YJUu36KwhZILAWGm1RRDpgyNp8wgdqrjHeEuaVuR9r
 4myQp2ly/oN9qMHJK0J/R0N4SG2didH8VHs1YjyTKTtsiA139bO91UoTvEJAImCTM9j4TzKJfyg
 OhiTlUyvPaWFs4q7EIVaStg/ZQf8Jw==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f749a6 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=b-gHXUNBb4A4jDXHR08A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: IOdNiq1n2YL3p4UoVNfa7p11AoMWLonh
X-Proofpoint-ORIG-GUID: IOdNiq1n2YL3p4UoVNfa7p11AoMWLonh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

On 10/20/25 6:02 PM, Haotian Zhang wrote:
> In the commit referenced by the Fixes tag, devm_clk_get_enabled() was
> introduced to replace devm_clk_get() and clk_prepare_enable(). While
> the clk_disable_unprepare() call in the error path was correctly
> removed, the one in the remove function was overlooked, leading to a
> double disable issue.
> 
> Remove the redundant clk_disable_unprepare() call from gsbi_remove()
> to fix this issue. Since all resources are now managed by devres
> and will be automatically released, the remove function serves no purpose
> and can be deleted entirely.
> 
> Fixes: 489d7a8cc286 ("soc: qcom: use devm_clk_get_enabled() in gsbi_probe()")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

