Return-Path: <stable+bounces-204463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A68CEE6BB
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 12:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCC1B3009C28
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 11:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C4F239E79;
	Fri,  2 Jan 2026 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dHefxxyw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hTDE5zXt"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B01531C1
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767354498; cv=none; b=ekTcu5Q+EWh5fQ3dbRGUy3/tmfwX4O+k9uwNw65P3B9Vp4nKr0e+CmQxWDD3mg/LvqGKL9hs+aL9nT+nUvel9qc3nFtZHSolFmutF1wSEFAgwc0HygeXXrQuQaA2sboviacqXHWXc4hY+IUglXLe7sXodwI7AWanX3eD/i2ddb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767354498; c=relaxed/simple;
	bh=Lamw3DKXd+EDOviZ694M+MoTo/Zzuhu3p+ZsGdJlG3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/tzfxB7iA+wKzJLGuQ74QTxpLaJb83IRo8zpMkEMOwj9z5afibnZrnIWr7gDQYAnh/pMR0Zg+olWhaHLDlcPV8yE8QfvtS8dOl2DVHVc321sgFZoIR150yZWebPq8ouMTUbTdHlZk5bxrYR5AqGiY1kY4+TqTGeeTDEQcOR5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dHefxxyw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hTDE5zXt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029W2BK824410
	for <stable@vger.kernel.org>; Fri, 2 Jan 2026 11:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kIO0EifCFwMkzSgGMHO+rCSEYMs7exKLpIp2wnkEVM0=; b=dHefxxywzlSevP0J
	7eFgtmERywp2yfD/gg8h9bG3eYaECvOT+/gAYoD/dkoFUMy2jeme2Ug4LMobT7oH
	xYKjCZTXM+DCtjmQMIb0++ySxvmhQJspuOVjutYvW4kMrMDUGNU4GynicWYcMg0k
	yYlkYPR0mPDHh9IFnsj3wAyfQq4RXA5zKhZXe9jBQB+iNO4e/1VUdIBGjQHbEFcf
	IxCyVNUvHMY1KBuPv1/KtsbWG62++s/U554ZEg2Xgu4ojuiCdZF4WqrDiWtOJwUg
	dS0gU1hFCAPdSPelF0DYjBykmW3Ws2d8zEpFithWVoQMiadx80W/1tIyGMN8J74g
	lVSYcw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd85338pf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Jan 2026 11:48:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ef4b1f8f7so2219729a91.1
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 03:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767354495; x=1767959295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIO0EifCFwMkzSgGMHO+rCSEYMs7exKLpIp2wnkEVM0=;
        b=hTDE5zXtwwzBmsgqoNsHMc9ZK4DwHijbjwncq4YQzuooO1gjGaWvU85miGX3Fgq/96
         AlbYuEoYbTlyuUoz/Yn14pasPoeqsHReRNvW3DfPyTheD4lo4q7hl8svKdiVs3ibUq04
         tu7kJFospRu3fTWN2as0oTYJytzg+aJ//7gxyDikclALI9yc1NiB/90E3nx+H6sW/oZ0
         5+q0uQaEoatquDp+xV1Bl29Bxz/+KjX4GUNgHp0m+78SuVYmOe5PYlNWIBK581aOOYQ9
         5woOuxYApU86voWAzCNQzTQ8LGqZPoYaU/f6CP79eZtXsNxVBn9zPzdrlq5Ek89jpMEn
         UuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767354495; x=1767959295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIO0EifCFwMkzSgGMHO+rCSEYMs7exKLpIp2wnkEVM0=;
        b=N309nLDTayk9DmA0aOeZTgfeWo8JwtAzeVhTOrPCOyjdTqZPvdzCR3iaiGlpIZyhUv
         3fhKtDFGBlirCvukMRTBGxgMTlZN0fSE+r86yIn1FLQlsFxyTnawXFaNKQ3TzuIw1z4R
         hwpaM16RoNSzfVebeGm/uVfb2U+Up9U+QXhekEcapeY532R0t0J2Vp3uuf10IqteMDUN
         FLz3mq8a6+XueqOQV1D45i1lXE40sijhSYaVR/EerwkefDCTGF4irtqIPErwdS2p8pHJ
         lOjut3ZRjym4FERh1U1QUebS48XizaMcUCU2T8rpdSU54wY4p2/mhbE9BqHrh3Mw4W/m
         hxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqRNNS6opLjO/RLEYu7i9Krv5PZf0vgpn82rnYiRqrkKsLXUlkBRW9qVYj9da79r2nWnnbNyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7C45ROst2AZaKex2eK0/cUyjEm4f5ci+Qq6COc1oSRAX8mp4
	Zm5rA57AS0UJoArAIdGygEN3rGu8nVNbiK0iwPh8OyiQmc1SbPQ8hANIsxboe9oJ2FpVPG7jlZL
	KhOQELo4akQF+tnXCZHkrBlgVA3tt8oki8/ugf06/ojdRLl77uqzAGeyAywBQz5lod4M=
X-Gm-Gg: AY/fxX7mi0pKPd+SuSQfWxkjlLo20jNdSGmYbdtl9NYWVqPqpYrWKB0J4q4YD2KcN/i
	ROIdFr5C+8WaS9XNCNZHVo7H03tXikREx7yBSx0IvBnvY6R787hVtJfhtf2yi9Dm/r67Z0l60g0
	2LNrQH/aZl+bLlkQpLxlnATVjvUQrXq7oZC++A/k3jSRiJiFRKel3pcpxZCbDAfdDeDFqiuzd3p
	7Gl5z2wUtPzqOYV0+OL38whxoD2RiqOsp30izzuvEeuRCqg5J7rKdbF4QNGutJxBPwCGvZZ7Ou5
	YXEFgn73//tx8jrLiITYnQDG+cMg1/Sc33Fq5I9Pnwu4JvLAZuspA2jnNbO2SpguL41AfHIeCbk
	xQjn40PPRn+mF7NSyT/6njRQmG6Q80arQHmjf2GygXVdRvyS6vPzPnD4HA2X0kONt3w==
X-Received: by 2002:a17:90b:2585:b0:343:653d:318 with SMTP id 98e67ed59e1d1-34e91d70676mr27573888a91.0.1767354495349;
        Fri, 02 Jan 2026 03:48:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqC7FQ6GbGdskiziKH9KoPRNUzbvPPHDM7UoIxaE7VEz2xVwqVZu1iN1rEGBXjnHPl0XojIw==
X-Received: by 2002:a05:622a:4d:b0:4f1:b3c1:20f8 with SMTP id d75a77b69052e-4f4abd30b01mr485697951cf.4.1767353999041;
        Fri, 02 Jan 2026 03:39:59 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8350268f86sm2242554966b.16.2026.01.02.03.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 03:39:58 -0800 (PST)
Message-ID: <500313f1-51fd-450e-877e-e4626b7652bc@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 12:39:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] clk: qcom: gcc: Do not turn off PCIe GDSCs during
 gdsc_disable()
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski
 <brgl@kernel.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        manivannan.sadhasivam@oss.qualcomm.com, stable@vger.kernel.org
References: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
 <a42f963f-a869-4789-a353-e574ba22eca8@oss.qualcomm.com>
 <edca97aa-429e-4a6b-95a0-2a6dfe510ef2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <edca97aa-429e-4a6b-95a0-2a6dfe510ef2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QEU1h-3tWXFsdhmnSdFnB0uvd9dD3lWH
X-Authority-Analysis: v=2.4 cv=fL80HJae c=1 sm=1 tr=0 ts=6957b080 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7LOYavHzeLgoFMqDmi4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: QEU1h-3tWXFsdhmnSdFnB0uvd9dD3lWH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDEwNCBTYWx0ZWRfX9YIEzxM6Ot4e
 TCVYHZIUNJH0ReSIsZqI5gCUmqGwH6/v8lQP/28TKrc7uGkbdsYzt5aAfGUrBlF6jpd73uh2Lhh
 obeWflaoleDBgqs546QoR6VCUZXD797SsK8A3Men1ZlLNojGb1ppysyLSFS5kQIzh++ohJ3aX9v
 JtQ/HTYRK8v771Xz58QyefAru1t2yTJ3qBQwsbZzeq/m0FhMCEV5ZChE3OSz99IccwiLR5fcKP5
 z9AUqTY41yw1Q15WEaW2vNyLAFlW4jN5moY6YoQnL0aoDZu9BSXuwm2Q1WmutlqLaUvA3VVqnU5
 qsjnDXrASJj+PGaSApQhaJBNxPYcgI2Gt3DrwW7Su78M2np8wIab+TTHaCd03aH5QssdiPk+hyN
 KmyDXakzELycDWXZkQtHt9alQXh6KZryeZYp3Ecu1gq06QR6POk9nC6PtQtK5E0OmR2kkUG8gNg
 DEtC7GKXyuEBZlh/e0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601020104

On 1/2/26 12:36 PM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 1/2/2026 5:04 PM, Konrad Dybcio wrote:
>> On 1/2/26 10:43 AM, Krishna Chaitanya Chundru wrote:
>>> With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
>>> can happen during scenarios such as system suspend and breaks the resume
>>> of PCIe controllers from suspend.
>> Isn't turning the GDSCs off what we want though? At least during system
>> suspend?
> If we are keeping link in D3cold it makes sense, but currently we are not keeping in D3cold
> so we don't expect them to get off.

Since we seem to be tackling that in parallel, it seems to make sense
that adding a mechanism to let the PCIe driver select "on" vs "ret" vs
"off" could be useful for us

FWIW I recall I could turn off the GDSCs on at least makena with the old
suspend patches and the controllers would come back to life afterwards

Konrad

