Return-Path: <stable+bounces-165511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B55B15FE2
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 13:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900735636D9
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AA0296165;
	Wed, 30 Jul 2025 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="crORyQp4"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002678F4C
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753876746; cv=none; b=AZ7eeKpgOw3JB8NZmVIr5QfbMMYGtYArkfA1wjqP/6DRdB8byhbpfyMalrNQbZ8R6MqEjQ38VBcv71I4neSOEBFVDjXHZ7LCDhjLIFa4BsKHqBycjNJadZNhBO4ql2p2q+bWsOvll5r6dEocbwaBvL0eylxBiTAe32R8A7ESDF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753876746; c=relaxed/simple;
	bh=HQDIFLaL7om6a5f7K5WAYN1xBKXB6S74doNDZJgGVJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3BLR+INclDmUmpk7+ixNwfRarrqVOo9OZek/gS58jbqHAIiFSEST+7NaTjnx3ZOLjL+AJfxKC7JVN4fDomzIuUWb+FL8WIz8eld5OHW/uykr/Lb2YfqqBt4DHJRolv+bHBBlGRi8G207EEJZMpPuFbIv7wkx3rFmBH2+3eFuvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=crORyQp4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U6Eipt015774
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 11:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gk5vGXil7RKOKTWhaZMiJw3ByMsUyxc9oWInTblZhxs=; b=crORyQp4VZYYq5OJ
	vXVC7Wpf33iPtrORDiTeGescorvgBNvzaX4JO8AvZP8vQDXOCg/Ow3SnuduUbFNz
	5lDV1TGFjX5DcZ5nsVlQrUMDFdelzDcKVx67ta3K2GGceIKhf68wIH6yE5v7Jssl
	vhr5j5BcVHsX7UVDX0w2HFlTruIJOVRDdbXUq64BVvHHNliW41/NnqWfsvvzDHom
	rTUCBP2VIvo7Y5edUNpOZAKSZRS4mM8ICO7mr6sLV78K2xWxEl0gsz2xVIoeYN3R
	D8Q+xHdxpbPFgeoFoqx4iVrQwUtpQKOnAws3Cr5yn0m6Ray+fyJpKE5sGd0vwHS+
	doS0Eg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbm3hwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 11:59:03 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70737a93008so2801726d6.0
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 04:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753876742; x=1754481542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk5vGXil7RKOKTWhaZMiJw3ByMsUyxc9oWInTblZhxs=;
        b=FAl59iR/3sqNofWQF83LYj8UnQuO85rmiPYbm7FCBVfJiSxmkKsB8ihrpGmj3jUcla
         bEyXlRXmN0RI9t11g5wA0xiGTtiwMYo5awSQpSE4bvjRc3GVIQH+KDea7G4ygAqHHw0b
         IavcLb/+QBUusTusxO/60KRxwUXc6m7Ue9x+SBVIOed7lym44zioA4TNZDLVCfC6v1pq
         j2j4UYbk3WHe7s0GUYIad3KXIpUOClqorOIZ2y2aHGT6aitTdzRKYXeMGS8RETPw0QRQ
         arOGBJUe+mb3LZ7gQO9pDPoOmKVvBYUaoc1HKm00DHRz9xjTo39VV3NrIrxExBoYXkG+
         N6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUO/a+680nP9HSeDtciOlQ+hc8uveQSdURMATT/7BRw1fvnN+xHSBgs+/s7HUYcfHojKt53PV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ6XVU2Ptxih6PQ5wz2+d+y31wO3jpxKbVrLh0lsvgONrJCehl
	uptz3A+wDSc8kIMDadN4FXbPFBWaGXNaI9yjCK1P71c5+JRyORvFut1XgfYet9Uwd4KsSWFTFzL
	X28d5zMtemVRU3yutjwmAXrFvaZvWrAO64uc2KtFnO5LdFbIt3zL2S8eD0bU=
X-Gm-Gg: ASbGncvoHm6D1UYl4sN2j0/94RVgTrGQDTu8IlIlpzY1kXdPbBsov12xAXLPKVCEf2R
	g21A7D1Q0i208bQSp7LslwrcCqOcMXIWVqVmX4os5+FCi8SQk/9BFCHF7zaXBren1iGQE2Ia/4+
	Tcgo97n28pJcohuGUQCcSzsJ/5H7jGYTUX30yq4xtYBB5dkRnxvzIwOH8CDNjwkCrJQbN1TVigc
	H+Jg8wbg2CFV7EVj2w6UZHhQKjE50NIyR/y0/GpRbBp2z8ysxXy8aL7qfno6xMticrHLgITv0D5
	Cmfk37bJp325OeNiY7brHBMJMbvFRD5tGonvNEl/Mm3NZznM3Ov75FODmSvgPUWaF3NSQ9vIl+b
	0aG+THxeqPwe92nVEjg==
X-Received: by 2002:a05:620a:2546:b0:7e6:39a2:3ebe with SMTP id af79cd13be357-7e66ef831b1mr218065285a.1.1753876742512;
        Wed, 30 Jul 2025 04:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy3Ac2RJmbNiBhetSgsrV4zyrjPh4J4l/19B5GXz/9xAxchLE62srybp1Dcr/TAc04N6REnA==
X-Received: by 2002:a05:620a:2546:b0:7e6:39a2:3ebe with SMTP id af79cd13be357-7e66ef831b1mr218063685a.1.1753876742082;
        Wed, 30 Jul 2025 04:59:02 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635ad9cb9sm741180666b.123.2025.07.30.04.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 04:59:01 -0700 (PDT)
Message-ID: <e7952a9e-23db-45fc-9abf-0373fa26f2ee@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 13:58:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] phy: qcom: edp: Add missing refclk for X1E80100
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
References: <20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org>
 <20250730-phy-qcom-edp-add-missing-refclk-v1-2-6f78afeadbcf@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250730-phy-qcom-edp-add-missing-refclk-v1-2-6f78afeadbcf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=688a0907 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=C9jaBoPFOhspESL_4l8A:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA4NSBTYWx0ZWRfX26f/1tj/QJo+
 9P70IUBnyZLStJNw6xFqQoat4MnZCmw9o6/JgFKi+OfWBvfqvRIq4YD03xC3/TgMt4yIiZ95Akw
 iO8vspPJ/OHDmV/LA9L5QxpG5Xvwz2i9WP2CFN/+/y8KN4vrffTb1RWm100UIIxWdNJhnSgsvvS
 8htQva6cZpHjBWC1tJ6PK/F1t1yFiF4JR3in2X4gzm2+VnAcTTCV9dsQMLjcbUemuNt3GFhy6qX
 ARX5b6v6LcXOg6ItOiTw7xSn0RDR4MU3JVxNPCaXlnlz4HjuNlF9sD+Ld7jvoU2aRaxljMPXmec
 xSjXsG12JD4PbYfGuwZogRGCqcF6Bhud0CTFq5q1ECGYhC8lVnKx21bMxSNhICLdqb489wjkW2T
 eSkCavsH3ZEffmUwIo5iw42vo7wtTpJ7x/Ogi05l8FdXvJ47OhDkid0gv7uxR2Q9QG3MhD7b
X-Proofpoint-ORIG-GUID: kUOz5i8SQSCVmq7alj_MdfBygqdpqtuA
X-Proofpoint-GUID: kUOz5i8SQSCVmq7alj_MdfBygqdpqtuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=718 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300085

On 7/30/25 1:46 PM, Abel Vesa wrote:
> On X Elite, the DP PHY needs another clock called refclk.
> Rework the match data to allow passing different number of clocks and
> add the refclk to the X1E80100 config data.
> 
> Cc: stable@vger.kernel.org # v6.10
> Fixes: db83c107dc29 ("phy: qcom: edp: Add v6 specific ops and X1E80100 platform support")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

[...]

> +	edp->num_clks = edp->cfg->num_clks;
> +
> +	ret = devm_clk_bulk_get(dev, edp->num_clks, edp->clks);

Go with devm_clk_bulk_get_all() instead, no need to be so stringent

Konrad

