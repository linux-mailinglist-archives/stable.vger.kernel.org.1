Return-Path: <stable+bounces-177702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4323EB43515
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 10:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B116B1C82F89
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 08:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BB92BEC27;
	Thu,  4 Sep 2025 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PAyrJXuf"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407F2BEFF1
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973493; cv=none; b=HTLHtP7Yww9E6owNJfBqcyUUg5T92AZKAQIMoey/SRzrHYo/T1MOH9emu/w3cSbhSwgSYve+GoRuYoKG1d0Ce6waca0tqjoNNH4HDqzhZ5RrbIeIukdQRzOowZ7p//9MgoDDxHlesDThtutlg+VpRfYXErk+xwFscsACJR2Y5pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973493; c=relaxed/simple;
	bh=4h08wpz5drqqCtxh2Mgu2qUofUwO3S1QVgxWjKb5L3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXyahYxKtdTpaY+eEMQjHRUyCMD4wUKIpafMXaUPyiMYVRW4xI0+YnvK+HXa/PlU5O4YCi8TuNiZA6i1WW70+sSW1C4Gs6IEGfZd9rc3SncswXtJ3BUbbYsWf38rbR+0/I568CFPdYWBGeOZCy2XquKds1uGUkDUME9sNFWhrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PAyrJXuf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5841Pofi005058
	for <stable@vger.kernel.org>; Thu, 4 Sep 2025 08:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L7t4dwQgkA12CDBLO/H8GwQ2txzuPeZic7pjO4qLBo4=; b=PAyrJXufetwiSgVz
	uAdzS+qwhc3dwJknZKxoaGTAS+xCPuTAIIoVT2ZUmCGZD/mIlEkCe9snuoRBm53y
	/N0daTcncnqxhGRTJ0qDB1TfUMCyJXFooAVkLKE6X8stOnVO6MGvOvMP9vjcmuZA
	Z5+CTZQ5KNtG7+FDlSHessrX60NHta3TYynN+kcjyjTM/9UAiD/FxVURjzXGTPgW
	FxFYtRn/7iBHcXiZ+Qi5HW3wDSnrSRhcX4cNPcWJBd09kqLClpPabkkpMFuak1Xm
	xbHPuwTAaNlrmmB3LLoMz5G9Q4BXBPwM9nhtEj0CVOW1DhmP0mZO7qBJdomwTKZF
	vSGHBw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s6se4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 04 Sep 2025 08:11:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b33e296278so1210811cf.0
        for <stable@vger.kernel.org>; Thu, 04 Sep 2025 01:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756973489; x=1757578289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7t4dwQgkA12CDBLO/H8GwQ2txzuPeZic7pjO4qLBo4=;
        b=kPP8xAJar5flTEi3eApmDEASy5Vj4Z/4bCPnzGbssAEbPtmCK6Uj1HqqUgfNXG6u4I
         NLWPTMR/DJ5WBHozY9I9NGOLF18tKy8RZ+RRoPM8liGPHw2kmAjQS+L6jEM1Wyfp/clx
         bVz1e9s1T/XCiimCYncylfIea4OZPgLoxGeG8e+Qiu7x7yMFXTDRSLE+LLBNKHqgfHbE
         4firgIercBO9LPPHgzdSJHl2E0QsMs5a0VOarTxEFW7r6QwOGvfNOpP03l3BBAkEXcc8
         wKQzJWsoUPcahEOmXCZW2CJKlmFPhLMR8GrCgugof1+frYL/ggormqr2c8vMAsKd+s34
         o1IA==
X-Forwarded-Encrypted: i=1; AJvYcCU5+MAy6V1EbpXTKfiSUVN0+icziQqNyJiSELFSFFsNF+H0Nq5zxzCr+enOIDTl1vU50DRSdts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkshQWVelWvvYdtUNu/2T8KaOnje+GxPG+5RNF2oJS3PKqiShz
	htKY+6f3crJUTpoBwNKeYy2K1m3qGr5wNYM/cHlxBGQPqDhzO0Gm3BMrCrA0YtLzR4nugTkcrR5
	JPWg8/mseNDxmrHi3zE4glBmArwu+busOatLOVVJAPZwmdZw1YrljiWHEIdk=
X-Gm-Gg: ASbGnctBKO2cIjqo9TX37RF5AyIPczfIVBZAU/lSjNusCUvc13Q37rbyjFE4DFoE2eu
	smbxSy0e12N1j/Opf4kbJz3m8ydQAox8hNYGCfBgtZsglLME31cRMTDVa+50vykdk9IwJ5eYf4L
	DBSQvHA0TrcoWOC2ZzjlYy92BzitcfYs/lj82o8be0ATvi8pIizL51/1hU7nXT8092rvmX1DI75
	EkYosBrpI8WOfO7sm/eceyN4KDZXrfBs1IT9w74rfryGhVpIYCjk3UAVKasrEk7pPWEGJP0ViM8
	OgU8aHSpNd9gWu3yzuJUPIg8JblzoCNUHiahGvk7D2FZQaD+ATZ7fzjqH0QLzmUOIQh6TSUwCV6
	TNouxJaANDJQEZd48sagS0g==
X-Received: by 2002:ac8:5d12:0:b0:472:1d00:1fc3 with SMTP id d75a77b69052e-4b313f0e6e7mr174091041cf.8.1756973489303;
        Thu, 04 Sep 2025 01:11:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETRY11wlgI/tWg0eDPS0dRUFiv1L7olBCrkOPdcF5xbIyJYVEuM11SwnRqh3KhtLOSUAXIXw==
X-Received: by 2002:ac8:5d12:0:b0:472:1d00:1fc3 with SMTP id d75a77b69052e-4b313f0e6e7mr174090681cf.8.1756973488627;
        Thu, 04 Sep 2025 01:11:28 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b041770913fsm1097170666b.107.2025.09.04.01.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 01:11:28 -0700 (PDT)
Message-ID: <1b92fe18-67bd-4fda-b7c2-952ed96aaa61@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 10:11:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom-edp: Add missing clock for
 X Elite
To: Rob Herring <robh@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org>
 <20250903-phy-qcom-edp-add-missing-refclk-v2-1-d88c1b0cdc1b@linaro.org>
 <11155d6c-cc11-4c5b-839b-2456e88fbb7f@oss.qualcomm.com>
 <20250903235138.GA3348310-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903235138.GA3348310-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX0bnexrVGMx9w
 M0GnNy/SlQiVmhrwhvmI5kqHZnfGIFh/B/EwVTiQC3nDdeu6O6ibqRp4LkKLE+VKSuIlRB1BCF3
 yLOxhVFRgApSJSUgXfnsXrcs+S+VRz33J5sy5bIbnWErREHZbVdVwHY+vNDakNkMl8qyK/5fjem
 zCLP5ktgDFXnYUMyeZnpdnzioXHAsMIlSdtBmUpe5mdAdAaZJp2+JkjUxNRFY1BjNilaCqKK/aA
 9SR2ZUxLifOyvdNgkzprXHvljktY/Al09+Ip2ITyTshB8wyY7Y4wEzgV+BikjyutwM1OVHeLESc
 xC+VilRvmhZEUVjZoHIgRqiVZdoemOSEAiGLh3IraXPt72s671+wstq7ku5oA0gY0iIhS1lMkWg
 YCU/9gDS
X-Proofpoint-GUID: 5-W7YUoE5sqpMG4YUGJ9eL-cz0YOjijb
X-Proofpoint-ORIG-GUID: 5-W7YUoE5sqpMG4YUGJ9eL-cz0YOjijb
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b949b2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=_W-1yxQpv4NGZoZ9-g4A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 9/4/25 1:51 AM, Rob Herring wrote:
> On Wed, Sep 03, 2025 at 03:37:25PM +0200, Konrad Dybcio wrote:
>> On 9/3/25 2:37 PM, Abel Vesa wrote:
>>> On X Elite platform, the eDP PHY uses one more clock called
>>> refclk. Add it to the schema.
>>>
>>> Cc: stable@vger.kernel.org # v6.10
>>> Fixes: 5d5607861350 ("dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles")
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>  .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 28 +++++++++++++++++++++-
>>>  1 file changed, 27 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
>>> index eb97181cbb9579893b4ee26a39c3559ad87b2fba..a8ba0aa9ff9d83f317bd897a7d564f7e13f6a1e2 100644
>>> --- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
>>> @@ -37,12 +37,15 @@ properties:
>>>        - description: PLL register block
>>>  
>>>    clocks:
>>> -    maxItems: 2
>>> +    minItems: 2
>>> +    maxItems: 3
>>>  
>>>    clock-names:
>>> +    minItems: 2
>>>      items:
>>>        - const: aux
>>>        - const: cfg_ahb
>>> +      - const: refclk
>>
>> "ref"?
> 
> Certainly more consistent with other QCom phy bindings.

That, and the name of a clock-names entry ending in 'clk' is simply
superfluous

Konrad

