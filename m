Return-Path: <stable+bounces-191791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 546CDC24221
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 10:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC9A54F674F
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 09:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C890330D24;
	Fri, 31 Oct 2025 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eOWi6KF1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sdvu7OWO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3F25A2AE
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902490; cv=none; b=sGke2BEDO+0dQW99L1jdqIhVbPIFtLE+tZZdI6UsMLud2RblGxReL+iXXhQuGc8+8L6CYLbhBMwdYoDUaDxK/sGlnWK3GNhQK1/OpDFEhqbriFc8adqhm0QjebOVgHZa1l+ri1sCH7dXqLyQY5lTG1pJHP51t2oEYzrq0vPeHEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902490; c=relaxed/simple;
	bh=w8yfOd60KDdKJreuFqthqsd4fR7/UZE2/5nBgUt6onQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjqKM7MLOgogR0xSS7D7ePMGfYl8wPKqi+Cq8hRYlbb+qZxRICVF0reK9SHuaaTEWeJi6srZhlVtmJMPgDx76Ek/f9eeidIKTCbXv+VBmVbn5xhJeDxknn+m61NCEmbajKlNJb0Mcg6cVIbBM7Y7AwE4A6N2zOwO9Iw6rAJGRzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eOWi6KF1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sdvu7OWO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V7jrsr832852
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 09:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1gAPrC5tF4vPjEpXPBO+URBh6gx1S2+j2eTdd5IbfCM=; b=eOWi6KF1gNtTSuYt
	DmYPGZ4NdfZ1wmCWN1MdjC9u/96ET7d3GSgO5A48EQyJT0xiuHJgoCfF3YlK2z6K
	0qBqUReETVN7U3lwt0MMul6+CApYb5wbWsVGkEJmNwtA+r2YqWj60u9BqHk2oxd9
	Ds6xElCR8XGK3qiNPIbuk7lGCbeGxWIHdoMFWx7561j1JGi8x+5KmCWzdve7dDYb
	BbyFXq66M7bn0UtWIWdMnu45mwcn4tc34FmvWSQE44os1du1JKVLrSMhoFybqyS1
	VHLeH+g43gZjqteDHcbHC0Hq7dzr11ZHN63JAchU4ywtHvnFWZ8xdCyiNzu5s02D
	jEuKiQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ffb1nyn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 09:21:28 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87bd2dececeso7028526d6.1
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761902487; x=1762507287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gAPrC5tF4vPjEpXPBO+URBh6gx1S2+j2eTdd5IbfCM=;
        b=Sdvu7OWOEBUOh6sEkV+23PEZoRiA0PXC4Rj+48h+qFVrjLN04KhwgCL5CZGwPPFE8D
         kFsw/gUrGa1vFDxbbIQllFhT+rijZyg72pCjf7kiyVTQnAgjc0lgywP58Z+qCYVKLSAA
         W+8hcaLErczgqpJ/vP4zODSoJ8Jp62mLk/ZApfAlngTIa2FeTHLN8V8qVre54X46V/57
         ZBRQ8ITH590gk166jmTelDo+ENHGlZyTxSfqC8Li/GLiClfK+gRn2bKItn97xoYisJBr
         DgtwKz0SMw72ohLcr+GaLNKfGzQCjOyxYuVPasWGDzIemDR1R17nHCOa/p2mLQF1Ym/q
         5Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761902487; x=1762507287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gAPrC5tF4vPjEpXPBO+URBh6gx1S2+j2eTdd5IbfCM=;
        b=VAg37/gXC5RxNsNgFn6oAlZArLyeHEEl4CmLTCgqkjeKMAPRlC3m/9gi/kMivgYtHT
         gjUv9x5189VcVc4WkCJKydz7g1dvlhWpg7P02IY6elUuhwqv1ApCrwmWFaSuAAR0XnQN
         VCVexBXSHRA+7JL9HbaTJpSgQy36FXR8s+C0XxNuDErFFy6ZkS4tpDov3+PHwhZ7VIJP
         AtEcUHz1G4s7n10UX9XU1A5M8B+rJxVoJne6srHTZ4xO3uruNtzYN8u1MpbfNvD2WF3N
         fY7q9peqeR2+ya8gtMWqRqDxePd+TVTjru4qFarwYUvZdqW3lZ8YvKUkBMHTINxC8/Lm
         xFEA==
X-Forwarded-Encrypted: i=1; AJvYcCXh1Yq05A+fMg2Z/0F39toMUaU14A8OTQLCjkRJ0h9dGXiglcjxyLNGAXrD1JgNcYwQT7xusEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypjmgeIfRHNCiLK12WL0SKOYYGbbhXmy99icS0D8cZTADv/nHp
	DC/8qb44+S7L7AcJyz2IIuTjgz3eLc3kEdf4T2SUzr2jRxMznFQsYWZnKO3NI0dd2bsYzjHF5P0
	J8yNGDOojEi9HYyXmd3TFM6LLCzlSNcpw5mfZA4B+9TfIZtHj7wKrLsPw9w0=
X-Gm-Gg: ASbGncviwTYTTRTMR7odRpX0i5hKh/rNOVzcLrG7UqJ5TvX387fscBf70MzymRMOIji
	lAQOHGA7q8bw6I+AOY8oWDfHv9qjKTkhxUjNImsnnlg8KILqMCHDM4aEO8h86k5xGMAQHM/x8Va
	iFCbNmMURBcVAtvhzbNy8/CI8kldVBq5shM4cpBwgCGFgXqyAuKXulRz2IYFrt7t4Z1WS8YUKvz
	zWnUIC7yHF5Uqj4REtlD6lwywmm71hZuQ0usWX3sgv3z9Bo/s+vW9apAA3Yjz+yomYX+eWavSH9
	uwbnnKlicb2dHA6UnNEtiVnPrZiKO4N9kqXPGA/EWift0mzkl3RRJkNyCJ20RKgANJhE2zbxZYQ
	n+n/wvL2JxfV5N0q7dok0z2UxALiPN0/rSWYOXjL4DWjd0xnOAilm21It
X-Received: by 2002:a05:6214:2aa2:b0:880:1eb1:fdfb with SMTP id 6a1803df08f44-8802ec2ef50mr21081166d6.0.1761902487463;
        Fri, 31 Oct 2025 02:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNUAdNYmumEqNj+QhWtcRqw7r8QN5GKfMaLwnY2Fp+tH9FpwHXyXjINbqWk1YR3C2goLdtzw==
X-Received: by 2002:a05:6214:2aa2:b0:880:1eb1:fdfb with SMTP id 6a1803df08f44-8802ec2ef50mr21081026d6.0.1761902486985;
        Fri, 31 Oct 2025 02:21:26 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b438b05sm1120434a12.27.2025.10.31.02.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 02:21:26 -0700 (PDT)
Message-ID: <25579815-5727-41e8-a858-5cddcc2897b7@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 10:21:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] SDM630/660: Add missing MDSS reset
To: Alexey@web.codeaurora.org, Minnekhanov@web.codeaurora.org,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
References: <20251031-sdm660-mdss-reset-v1-0-14cb4e6836f2@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251031-sdm660-mdss-reset-v1-0-14cb4e6836f2@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OArdVLyvdKKcckmIc0F_0rOhAcm4XqtI
X-Authority-Analysis: v=2.4 cv=fpjRpV4f c=1 sm=1 tr=0 ts=69047f98 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=LpQP-O61AAAA:8 a=Gbw9aFdXAAAA:8
 a=QdJS1fbVFv8XyC4bU-YA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=pioyyrs4ZptJ924tMmac:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-ORIG-GUID: OArdVLyvdKKcckmIc0F_0rOhAcm4XqtI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA4NCBTYWx0ZWRfX9EPrSKllGR2C
 yS7zNGeOcBTSZK7FGjaWoHSb/ZR7QFiDKq3PilbrhgMdAjm03W9bbDP9AwZ+sNMimbyomxSl6cb
 PjEi+HOAC1S/+myxSKz68C1vMCbt7BM8SlTwyUVa1H80/T8+zCPjMbHvz9PJu04liZlD56yBY3L
 3IfXuqjdD4bxDGejwZTT3Jl8Z4WTJL6WSXyKEn0ObnAPjk2p0J5GdK52J+yrjHKzSAq8tAtyVvz
 uDckUsWhM746opJKavXMCaA2Fr1Fz7Z2o4YUs44iW2eRfxaLakWuUhcXSt+LyuwxIdbWiTzTLMA
 Wq6rEhj+N/tBvoytwjjyB6oosxYzsrMSyPpIggb62zyioOAXo2dhgSAOmMXeYiHM+bOxm3jzZXu
 355CaT6IFCi+jHn4PIQiDd8hsVqQVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310084

On 10/31/25 3:27 AM, Alexey@web.codeaurora.org wrote:
> Since kernel 6.17 display stack needs to reset the hardware properly to
> ensure that we don't run into issues with the hardware configured by the
> bootloader. MDSS reset is necessary to have working display when the
> bootloader has already initialized it for the boot splash screen.
> 
> Signed-off-by: Alexey Minnekhanov <<alexeymin@postmarketos.org>>

You git identity has two less/greater than symbols

Also.. thunderbird argues there's two of you:


Alexey@web.codeaurora.org
Minnekhanov@web.codeaurora.org

plus.. I thought codeaurora was long dead!?

My DNS certainly doesn't know about web.codeaurora.org specifically

Konrad

