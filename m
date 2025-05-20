Return-Path: <stable+bounces-145721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF4BABE605
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 23:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8961884667
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 21:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784AF25E440;
	Tue, 20 May 2025 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qau5RWUG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40242586ED
	for <stable@vger.kernel.org>; Tue, 20 May 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747776432; cv=none; b=PIkaCf2foe8Eq8ta4CsPWuAdSJ1DQxaCOe2EjpxrGqOWMd2zTTt3Emh/IvZWK8neHThmCiDmwPZY+sfUKCMhgXFVKGBywQBUxSNgNQyClHWK2M/NpFKHteaHby8/ZpmlHIZ3CCsxsd3iSM7TSZKqALnyNFhYV0xv5TP4vUIuD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747776432; c=relaxed/simple;
	bh=Tlres75UciCPZpHtQqwkcdqZyqlwkclBJ7jmGOa+Q2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3jRA69AKUCYkzAdvnteH4z2CtekxeUQaTA77Y/fYvoTC9vNw85xsU5HcEa0xqYCDY8825aaAZ/LcpP6nY5Uy0Xas4dlh/pF6h4dsMZnadTnhlteJXXe/X/K9ERkuYuAcjwKrySJlMZdrqZr8koytJDggPR8kC8W4Cd7KvfBMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qau5RWUG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KGgFOO006851
	for <stable@vger.kernel.org>; Tue, 20 May 2025 21:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tG/XW2Eqw3SoJlBkat+rQXZC
	WBPW6ciZKTyIRU1D/7Y=; b=Qau5RWUGBWsuY1V0sLQ0UJo3+PA/1aZ2EOK1E2TD
	80D/kMZWHeGddDhMa/GJTCC4JLehietYdJlEwMpS1A3RMNZMpR/IiA/l0SBdj5LG
	3m8++4sooJcMdAaHlKlFzkKOsxOeWoojDouaclpuahjiBKlv6FgEkos3wlNvSUsG
	7AgO/jRT3jJzPyG75hUckhKEAxFrk9DpCs8jdiHfJUWmb39am/dcznMSrO9NJ4NA
	TGZ7aVLQrDkuCeugZ2DtV8eMQwjyli6PngXQ4xBekMVFnShanK69Jx3F6UfoFxqr
	zaM/hOErf1arN8t6JcS139mbPOk6jA88DeALHQlkQWwKsQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf0gnrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 May 2025 21:27:08 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6f8b14d49a4so58566346d6.2
        for <stable@vger.kernel.org>; Tue, 20 May 2025 14:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747776427; x=1748381227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG/XW2Eqw3SoJlBkat+rQXZCWBPW6ciZKTyIRU1D/7Y=;
        b=Z23a/OGpZaTl/5wiPqjmKw9igZEswTNlLvO6ZdqyjJ8jTTyJ3OiJ8tDBMXF3mS57j8
         ZYXhRCkMa3C7YCx97DgaDuRZlGpaWM3SCAJepVYiOeTqCnJ2sudkpZpbcD5HI7zLowBt
         JwAxsdIx+uLRR+ev5hJOq4p770LjbFJ422aYIdzXvCmfpoP80RDHpXm16HjtfS6Vxf3s
         I2kUaLmLW+/z/9lBUwC0OanngVomYyLUoCkELlffQePrN77xsFa4X8loITApQc98Mi+6
         S8m7A3tSUjFy8kkMqvJ0BCXe72C9Xc/WpQN+gHNcsFiFUhibE6iiZReOr4w5wnzq8gSg
         Qeww==
X-Forwarded-Encrypted: i=1; AJvYcCXWQEjfghopUICi7hidIKy5gUrX5IxpG7oo1Ydjr/QRdAVXhWL7Tcyngj3fBn5aFZRJWPVYMMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwQFtZ0bFmdUFYv48PaFz2ay8OwqJW8gthwBKAe8qOngunEEWR
	HUeQCL+04JWSaDM38VJvqgrszMZMSXaZEKOfZf6bOt1tc8yytGbEB4m6cBcv0PYarZAC7MI1IKu
	i5VLQbPE2bSEAGWP5St+rI7+cthaFN6Q7Awz2C7EzrxxZLaYqIDEEMAee/TU=
X-Gm-Gg: ASbGnctKGdW35L81T471R62rufDXxHFGlePdRPusOlRd5XXtD7D+oqqDw2LMwvyf9ZV
	JryofXSUYEitr1oRmia/f+v/Z/Q2g3YP2k4gs+VeQ8o7pafSem6jBMXnz0PbpJrZ/VxjUDqeCZO
	iO5PDV6x3JSLxGGjlyCHBYENihtHfWKx5xJoZNi5YYbyh3mVMIIXLesY6kF/fYEAXz9HjJ+HUMG
	PVSTI/C+v5SLni9fsnTqp/3lyhCpUDgnvN9z29c29h+921nXuMBE/fdVKjUhCS1pUXA/+MF0ATA
	yz692O1pEclPjz5eNSp8AWurtSNqIADfpOv7YXsCY/7I8ZBkR9t0w74ccrhrgvtBL+N8QBMmKTI
	=
X-Received: by 2002:a05:6214:194c:b0:6e6:5bd5:f3c3 with SMTP id 6a1803df08f44-6f8b096e039mr276434226d6.44.1747776427458;
        Tue, 20 May 2025 14:27:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXQvCXDN9w2FBtdGnI+rkan1fAQ9YM0ciJNl1Yj+gIlZexf465oAOPMwNVhIxArargpBSedw==
X-Received: by 2002:a05:6214:194c:b0:6e6:5bd5:f3c3 with SMTP id 6a1803df08f44-6f8b096e039mr276433866d6.44.1747776427125;
        Tue, 20 May 2025 14:27:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551f8493043sm821758e87.210.2025.05.20.14.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 14:27:06 -0700 (PDT)
Date: Wed, 21 May 2025 00:27:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v6] clk: qcom: dispcc-sm8750: Fix setting rate byte and
 pixel clocks
Message-ID: <ipdt2r25de4zi7zovntb7vopah23on4dr7l2ui3ieevapzdveq@3dtvuhtrdlww>
References: <20250520090741.45820-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520090741.45820-2-krzysztof.kozlowski@linaro.org>
X-Proofpoint-GUID: jCYCtQ0YVSREsehNpFCcmZHpWoHDo4XC
X-Authority-Analysis: v=2.4 cv=J/Sq7BnS c=1 sm=1 tr=0 ts=682cf3ac cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=ZhXjtQkuzpVzWrVPaUMA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: jCYCtQ0YVSREsehNpFCcmZHpWoHDo4XC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE3MyBTYWx0ZWRfX1VxOjtbi58qW
 gtR1ZKmtjHw5S+yhZ/wT2ERSG3FIEEf2eaeNJohokJLyj0JWDu1QWqruJ394WrAa7p+as0xyuCK
 ycmUjQwutTGXw1p2J7WWo4mZQohNZlk8ZoQC2SIgiX+f1gD6EgwVqHO6feeJnKwoQt2//Icx5tK
 jLEs+KeaeVo97LvAQY17SuK7dL5j0HfHROrFTenqJw5gLxnHXK/7i3vPyIkvdihm6C6mmXXqmmJ
 L5lgrFVzn8L+H0FB1tARcWQkv22B9yIjTbWQni0qCt/aZCDCAG7D0i2owH+6fyS7rSCzdVTJZ16
 B5acxQcr8x1fnwM2R/CLVrWVCuObENzLnbEdE7ozawd/nTPK31z3BRUL8NUXeQmVxQVDxkUbH6y
 /iiZmwjtNz7MdcVk8SM9neS11heNd/7hfKT7c+6GrexaLoPEpMO0ImQyCmshawu4fy7wYgel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_09,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 mlxlogscore=508 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505200173

On Tue, May 20, 2025 at 11:07:42AM +0200, Krzysztof Kozlowski wrote:
> On SM8750 the setting rate of pixel and byte clocks, while the parent
> DSI PHY PLL, fails with:
> 
>   disp_cc_mdss_byte0_clk_src: rcg didn't update its configuration.
> 
> DSI PHY PLL has to be unprepared and its "PLL Power Down" bits in
> CMN_CTRL_0 asserted.
> 
> Mark these clocks with CLK_OPS_PARENT_ENABLE to ensure the parent is
> enabled during rate changes.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: f1080d8dab0f ("clk: qcom: dispcc-sm8750: Add SM8750 Display clock controller")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v6:
> 1. Add CLK_OPS_PARENT_ENABLE also to pclk1, pclk2 and byte1.
> 2. Add Fixes tag and cc-stable
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

