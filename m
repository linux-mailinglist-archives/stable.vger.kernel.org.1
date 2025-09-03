Return-Path: <stable+bounces-177624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3D8B421FB
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 15:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1558E482C80
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B4030BB87;
	Wed,  3 Sep 2025 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UpmHgTXV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D7E309DA4
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906695; cv=none; b=tBGhKqHF58T4+tM7uW049WQ52W96r8z55UjBw7tD8whOSU6kvTrq8/zSNHk4+9ZFiRNLWsrcxriBU0Fc3M78b4WJLde4lDiNZ8T1vBDE7H+i+fmddRkckiDZEvcWtreqxwm5Vjyjb04UBob8SjZK/mg8CViHU5VT8ATVq4PJgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906695; c=relaxed/simple;
	bh=LOn4lvVTz9RolUVuFrhuGbcWkHCfxy2FGtDMv4SJQ+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUu3s4VJEvpK6FKfGozErQh8cjZ9O+rgz+ZD46XeKMnmzqfTI6PQ1cwq2DwCyWUgurqsuERystnbs0uESPXhxaC1YB+saK0VMBApcn9v6Rjmw5DHm98xDk6mMUTKod+Mq34tbq9XtKwbXYgz+00TuqBFjZui2Ugb883e1CdWcFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UpmHgTXV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BZu8e024816
	for <stable@vger.kernel.org>; Wed, 3 Sep 2025 13:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+aXgx0C/TKBcTy6Wyua/O23sUvaZBDBg9e7hKnXJ9Os=; b=UpmHgTXV3+w3B4pt
	cREBVJYCxm0fGIOPXLriIEv6OMHG7Lal57rwNw+rbkwTCxBLFLJdPLdzXLiaUj35
	GcqpHQ92FITlQTgIY7urCVhiTjyJUOnmVILhH8Dgf1P7FdMZSbCIc4Nw4ancUIj/
	fDBk4mHUNyc/WTu87Kw1YwaFjssHcL1pVnnL0BYR/AK/tcJtfmfWS+sUpoc0DHsJ
	ZsVKGYTeG9J+x3KCFGj1so4SyqRvPZm/nL+IjU5Z0rJXw4BKysDU1ggGiuCGTdfR
	RjUxCgCcbI7OOwMYKFBkRQAJup95hfuAoAGVodfHlOBto5S+9tM1tB9ko0F4wBHb
	zHizJA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj0cr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 03 Sep 2025 13:38:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b10991e9c3so11777231cf.0
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 06:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756906692; x=1757511492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+aXgx0C/TKBcTy6Wyua/O23sUvaZBDBg9e7hKnXJ9Os=;
        b=bk80TngE3FKc+hT2lIml0ADBwAg1j5cXbiqke8MfEDpg3YxfBS3V2c6XFn2iUpeObR
         wst51PdySPVFsRtL6Tbw/H93h4tEJ9qdrLMP7TezpQi4T6/88WODuJSznVbQlz9+dMhl
         siMGUvATzeJMhg5kMbXHvdDAYeQB91+DbnR65PKxHWnFCa08wmBVivHYXO5ZdvefQawN
         p9mp6c5XE8CWiZLplayG1+6ccul6fOtSIl/KHnVxM5/Dwem2IQXjcSbktDTVGvQvWWVe
         d8EAkuQEMpQm9TZXbDqqZ98GSHjhbK91Mq108gg3t6M8F+uZq7IQmWfxRkVGEzf5VEaf
         xDTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUneYGgRrfVi787LH5JGMhK3KBnVNtexrYP9XD5uQMwKXwYsb4kzddBgx2/9il982jKeOS5pzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjtstKzgsLeaZRf32lhEZDMvo8sh0slxoKCQYIWzFPaeg/JrL+
	uaqN4cNTdFB/ZYJJNnDipdIM6DXuRpiMWe9BRtxt4zdbhmlYmRDtkMj20s5x0FiLPjb9olnrYCQ
	Gd/jop8SzQshp0Fn1l+XwOKiimHa5mib/Mcqo4Uzm5CzR75UqIkFLHUuhosI=
X-Gm-Gg: ASbGnctPeVLKkYpMZN9DQgomMyZ58yE97B/+uPV4DjA0qAPTOqVwadhKsfvfn9yKsgB
	HY6aNAHvtwmm+cUegnIKURc9Z9RG3LKusls737hR8ic2skYODXMOAVuYgTCT50JNjooSvi9s23o
	M1XqYid7QGR881CZ1XMGvNU6viE+cXOzeCjs0LgWerQUy+e0C+nlAkViCIC3ooxyD3YKg9MwELY
	hRduBG613n9KqTNXdOumGDyKsUq8kQN489e7mK3Oz2CE5lUbVJaZfBHcjAoO5d6//G88nMNblwx
	MsrVZXCad3RN4hc55Z8CP1bv2X9QkP3O4Vb8TjSMQtqRyTQu3/CnvXJYaQXa/IQUnXFmkAceMK4
	iX/mSEFE/ZBGqu+3lh3eytA==
X-Received: by 2002:ac8:5e06:0:b0:4b2:f5a8:21da with SMTP id d75a77b69052e-4b313e1a3c7mr154164661cf.5.1756906691941;
        Wed, 03 Sep 2025 06:38:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHctp8klVVlJwh/I9Cv1/2OINdIX9gzROyxCMvF3SPTjSmgb2xzFihn2uTLcDdSBJMQgIRRKA==
X-Received: by 2002:ac8:5e06:0:b0:4b2:f5a8:21da with SMTP id d75a77b69052e-4b313e1a3c7mr154164281cf.5.1756906691437;
        Wed, 03 Sep 2025 06:38:11 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046aa92242sm149794966b.59.2025.09.03.06.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 06:38:10 -0700 (PDT)
Message-ID: <e6761fbc-9f32-4fb6-afc8-7f76b591453f@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 15:38:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] phy: qcom: edp: Make the number of clocks flexible
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
 <20250903-phy-qcom-edp-add-missing-refclk-v2-2-d88c1b0cdc1b@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-phy-qcom-edp-add-missing-refclk-v2-2-d88c1b0cdc1b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX+3O8hjiRniCm
 wGMOqxxgpfKd/ExNkj235d8Qt0t80G9tLjtyTs/iNYzYu2HW9BdgyDVufXGcx+UrBDdOxNujQTl
 KlehE3LBUl7iIhmPtiIWPOjv5LkTkMtZ7yxnGoNbi2edP0zOXQdRwITPJu4KdRBD4tJ5AvOA3iq
 QskSrcNrm4PK1LxKoki+oKbxpIdeDgHanXNlzV78CNr7S7WUwbUpkM6S9kvMO23LNyNcQGFe5X+
 0vh5De6HZkBmN16Zxm6DhvDGglJQ6H74+T/t9xDL4hFh3OOH0+t6aq8PYHBP0NvbpTGCM5A0gXs
 yJaYfv4rGDn1Z5rXiNn09cv3uLOUNrluwgNsvRgKUO5k+AesupvnO3xOV8wnxClciSg6+MLqhiF
 pg73XfEF
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b844c5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=JahnCVLux6B-E1IX8mMA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gpDz5Exijq6xbpHQpE7ut5PvUP584WkE
X-Proofpoint-ORIG-GUID: gpDz5Exijq6xbpHQpE7ut5PvUP584WkE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On 9/3/25 2:37 PM, Abel Vesa wrote:
> On X Elite, the DP PHY needs another clock called refclk,
> while all other platforms do not. So get all the clocks
> regardless of how many there are provided.
> 
> Cc: stable@vger.kernel.org # v6.10
> Fixes: db83c107dc29 ("phy: qcom: edp: Add v6 specific ops and X1E80100 platform support")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

[...]


> @@ -1092,11 +1094,11 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>  	if (IS_ERR(edp->pll))
>  		return PTR_ERR(edp->pll);
>  
> -	edp->clks[0].id = "aux";
> -	edp->clks[1].id = "cfg_ahb";
> -	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(edp->clks), edp->clks);
> -	if (ret)
> -		return ret;
> +	edp->num_clks = devm_clk_bulk_get_all(dev, &edp->clks);
> +	if (edp->num_clks < 0) {
> +		dev_err(dev, "Failed to get clocks\n");
> +		return edp->num_clks;

return dev_err_probe(), also please print the ret code

Konrad

