Return-Path: <stable+bounces-177622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E238B421EC
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 15:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EBC77B5F1B
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 13:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0550C3093AA;
	Wed,  3 Sep 2025 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LsmQHOXI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398C280CF6
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906651; cv=none; b=Ldbu2rLCt1y3OQ1F3ZR4ExDcsuQZ56W5eDnRlSOkDDxgpcXQlgfX5Jp6cfwItDuTdhfoBk5++Z8aag6uqGMipXEe2VOr3ANRQjOYAYneXsJEiqvixoR0TrcxTuFKxan+3jPkjxLHBtEE+s8LJ/CF+/PbD/sIA6M9vJuzBOKjhJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906651; c=relaxed/simple;
	bh=tacXb3I7sD82JjGMbS8Dqgx1hL17l0hk8fOJ6PMQcq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjwyKbHbjWEbR+djp11kr6Yn1qe1SDA6mh5Wr2kMgjJ+1CjYPRME9AROCdTK2FKJwIUdIJW5S0LgvUluZJ0B1Aadm1l6UovY15AfCJPN4cj7gUuQqx1tyPX2HWFNR2cHEmzE2UYQqZh1xvZIjPCM6+aS/5MRBP6UMLSnqV5J9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LsmQHOXI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEtGq001969
	for <stable@vger.kernel.org>; Wed, 3 Sep 2025 13:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G6WxjVs+4qB1wpptnxje/lLl2BWE/gnMjf/dmXAtLn4=; b=LsmQHOXIM/ofd/2i
	Gk9P9qYur8B8+LvatykrcBUBrN7ecmvdxnI4IekSsM26hRqjzhy0Q4lcw0+tH2XD
	D0PU7/PjIpqbMxMLzKkpC765oMelSfI3HaSgloqXsqrIyKinaOLLokmJdTPcMf5a
	Mfi3nl5T1UWSQQeyjQ+wTjpwGnIEYFwcg0YqaCkrNjGZseUL9enRcIWi1FubdYzY
	WY7iS4wDK+vvi9vkP4fmqzngE8oZDbgSc6mlCDJNA0ee4UAyr/Ju+GF01dZ0jd6Z
	Sl6Q5jJxYrn6RWgNABOffNV1vPKQA3BtkXIUt9Z6N5mWZjCBQeQwpTsNk+qIGdXx
	VlKBnw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw03vnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 03 Sep 2025 13:37:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b10991e9c3so11775231cf.0
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 06:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756906648; x=1757511448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6WxjVs+4qB1wpptnxje/lLl2BWE/gnMjf/dmXAtLn4=;
        b=j731WCVy1vZ7nK7ERaAnoiIBj7l6CcRz3nDzPkLh2wWJ2qqp8fftpQ5wolJNPg2twR
         aC2Xi09u06y5ys3uZUDSbiv1c7piVe9bv8EAEUVEFiEtwq0DXJUbnW3wKX8/zvS1cNcp
         Qhv72GLbQ0sl5h+6LWWY0QKq1lzPol/Vd3aiZ+3hV13711HqtU3dwvYbAE2KUjSlA5K7
         Er53crWYil9VW8pE8lSYZEYtcDN2Z53eFcJlzotlMyu0c92icgsNqZptmc0l7qQ457Lq
         ombYvS/IDvIfRqXX0F3C8XbRzETdK5NadusDJVsLL0f6AfVkMywHBSqDqTTQD9GqvS1u
         ooeA==
X-Forwarded-Encrypted: i=1; AJvYcCVrLOtqzpkxE8sG5rl3czvFfLm/a8YTM+4fnzqeKGKMXAfLq2fGubkiUz2e9Of+yYEyI8BXk7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54dNb4BWzw/5UGks2NXkWvHsfL8CWG7tkZXP/9lYL/jx/P4W4
	wpmo5Cd/W31zl3nYa5vGepsC1EpD+YuzOd3LtkOS0cEzgeK6jzpIOXMZJGhdbVWJ+0gJp9N6yed
	QibYvXjAMXmLIktq/9VFfnCDDsKP8ci84CAY0erb8rwzJJCSg3oTSvRXLzmI=
X-Gm-Gg: ASbGncuqkUdph8tI856qtYqKbwXTmlq9zgSdD370ZOpWQemOcUSEtTAsaNJE00HDaDZ
	2+ApQfQqoKo4PQOB0DR410enQJXL6K4lROEh6c6yJwfKleY+nCKxKzRkdW8cMsN+YTtiMSy/EHd
	7RyXuGQqIEDbFT3w2q2xebH/xYkbivovzSDjg4mz1NJST5LHw2r0Sdlx/Hc+HJRBmnTil6Bx4HK
	YbyJSlDWTi2QXMsvHyHDndxFV6JBsE0I4U4RiKF9KV0TKu7O1/9QJaAbTiwZx4Jr1uSUUEJxT8F
	qIR92fLvfMg+8o/XFbnBcWqkQchUP2DPjiiFF/Ovz6Yv3C5rW1QVLQitYnUgen7lQuY0P5JdGA3
	nEamltaPxLWA4fhjDDfQyCQ==
X-Received: by 2002:a05:622a:5f0c:b0:4b4:9655:9343 with SMTP id d75a77b69052e-4b49655aba8mr8680461cf.3.1756906648235;
        Wed, 03 Sep 2025 06:37:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9aESjDi7u3ikl+t7p2SljGJv1hsVA1MO3GfCrupQw910Ny+G82IIly/jBPP+7T98Yksz3kw==
X-Received: by 2002:a05:622a:5f0c:b0:4b4:9655:9343 with SMTP id d75a77b69052e-4b49655aba8mr8680251cf.3.1756906647585;
        Wed, 03 Sep 2025 06:37:27 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0431832a98sm699384166b.80.2025.09.03.06.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 06:37:27 -0700 (PDT)
Message-ID: <11155d6c-cc11-4c5b-839b-2456e88fbb7f@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 15:37:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom-edp: Add missing clock for
 X Elite
To: Abel Vesa <abel.vesa@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org>
 <20250903-phy-qcom-edp-add-missing-refclk-v2-1-d88c1b0cdc1b@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-phy-qcom-edp-add-missing-refclk-v2-1-d88c1b0cdc1b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: d1H71awXi7LR08rH2bf4Vem-jC2FSTDr
X-Proofpoint-ORIG-GUID: d1H71awXi7LR08rH2bf4Vem-jC2FSTDr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXxzZMc4mYSPvj
 S8uV8KCQhAi8+1QYKPIFQYEdZ8wtKX+fldKKIN21ISECgIGARQZp0OpGoEwwlIkfSiPLCsN6ZuI
 e+tlx+AiflaLwMdEd0Ssdj9+No89NnX4j5hp78Js/8Wb0+wPXMnIQJXHHXr1h/cBvxW65bOfGfu
 4qbKm90AM32XCgBK/iLAKG1R+3mrkImcQ4LMMX/zwMym2B5VLpC+2Nv8g0nCNZZYoPDMTG2YN7j
 ypI0Zx0WoCSVC0WqM49lhBL8Jm4WQYtErKio4+PBV/dFVcl1PUsunzuxWm1wPOGeVFdBp4i7C7d
 M5EC/CYrMKQq489whqyMbXg37HpkTa25Cxm8FeUEkCxgOljW6qs06n3hl09Y5ACwLXevu5H52Pe
 Fe71qj+a
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b84499 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=D1QSBg5h22RYVcxFYwcA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On 9/3/25 2:37 PM, Abel Vesa wrote:
> On X Elite platform, the eDP PHY uses one more clock called
> refclk. Add it to the schema.
> 
> Cc: stable@vger.kernel.org # v6.10
> Fixes: 5d5607861350 ("dt-bindings: phy: qcom-edp: Add X1E80100 PHY compatibles")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 28 +++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> index eb97181cbb9579893b4ee26a39c3559ad87b2fba..a8ba0aa9ff9d83f317bd897a7d564f7e13f6a1e2 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> @@ -37,12 +37,15 @@ properties:
>        - description: PLL register block
>  
>    clocks:
> -    maxItems: 2
> +    minItems: 2
> +    maxItems: 3
>  
>    clock-names:
> +    minItems: 2
>      items:
>        - const: aux
>        - const: cfg_ahb
> +      - const: refclk

"ref"?

Konrad

