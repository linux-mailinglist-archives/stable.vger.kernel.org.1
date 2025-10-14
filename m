Return-Path: <stable+bounces-185629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EA5BD8BD0
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 12:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF08F1898143
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EB22F5A09;
	Tue, 14 Oct 2025 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kL1xS8E5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D6F27F01E
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437405; cv=none; b=LjjC53Day9/Aj8vL5KQCJGpefTVwnlIYEVKY/q3iErFXheFcUycIMQIaLjlYWxTjM1R4EjTgs+4r8cp6/1rsFA/RquwHU74kN1Ul17OSQBbfwKkCBdB9m9JabCXMwuB57tDb3PDSTxjsZbLtsgj5tXvLgjqLnicmc6OY+7JKN4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437405; c=relaxed/simple;
	bh=dka1hLAB2FDL4jzoGIfRpvi/9wOSg9e0OUQPD939vAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZTTXepk1I06oBiIHfWccX7hL1C28qBOw4DydV8NTJ+6aog4gTvn9EyIvRPZfEHJWzJZQCPOhYcIeSf3go5hdp1V0FpjNded2bEahynXnXpcAolBxauoDbgh8aL1oauda5gq2mBiYeYjS/W9HEKOQ/FAZwWKwmEr1lvxvZkrHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kL1xS8E5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87Lhx008653
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 10:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/q6kggVv0I8zQ7jGT2QmEA7M
	QI9ZTL3uoZuqj2yT2cM=; b=kL1xS8E5F3Es/ScguvWjy7ncewgbUzmnaLwzxTTT
	VNVloJ/pWk59upqJNNFE+mKZBL9Ho0Wjx8h96ECdVr21vEHQBFllduAVWyqr1+Tc
	GIFvE6Djg8LoVF1PW1DRhYTrQdIaNoNm4Z4ZcBpvmghtbuBQdm4y7j42tQWerZwL
	LtK6ELPdy8ZIgBmRMOVH15Ok4b4S/p4iKKk9sIuuvBuuZuq9zW8yJvwJWmJsQJaj
	xWij3J+PPAmXAHBd6lT8UhJ2q7VgXrxuUqLWT3mPHJsydFbMDjfz2pqYQwSn8Pqy
	KqwHjPBGv4Yck2jc1//GOLK42IlW8gwIhK9S6OZ8H+KpkA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt4w97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 10:23:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-827061b4ca9so2400642185a.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 03:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437402; x=1761042202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q6kggVv0I8zQ7jGT2QmEA7MQI9ZTL3uoZuqj2yT2cM=;
        b=hsMkeOKiroUV20fOWLRihNEGI6KxAmVQoWZ+AJkgYxyCFBBILEn6Bg7y2iJuWgGAED
         7bozy6J0allAbLcrzPVwIqvbWWHycrybgegwysEcMQGpMT2IQBi+3PjWMSBBf91mooQE
         UHmfQ+HLxwaD1jHOxOmv9/IcTUhjJVM/DHZcT10m6L2E1917+gcoyKrwaDWTDsyAndwR
         fcE0YJ3PmkyxW3KaNofT07BOOXJLYdqxPa79d7L2eqw8Gq3y00qKnM26Ki5bUVy8guo9
         lUeI+/FNE+/gltFqGXKPO+RVkzoNi9kDd1qd/fF5DUHvzV6bhR6AgHwuWNe8xKnernS1
         NvlA==
X-Forwarded-Encrypted: i=1; AJvYcCVdRkkHRPixGFZD/sOFWd0Yus8PX4YdeNwELZfT2CJjNe99pfSqfYmZ8nlvrB14laECzFDmO/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hu8ic0Dg+bXxXJOFEni+ZfL2PwMloyZIt45J4RO5VQw127H/
	H/Nk+HSN08Tis/HvpirTzjQx6QY3I/TIfRiMwvViV0XhUwpnP933PkIV5y8gVte6APpL6uVaUDy
	tJTS76XaUomqwggerLWfWsZoGJduLxFptNm/qLkO7jNsP/jHDWRwIVDoStGQ=
X-Gm-Gg: ASbGncuH3GVltlpCVBuEHztKDnXfcJmLIz+ZLMfk0cEmaJqcbXDQVO3r0bxXJOkPNyv
	V8UKSZl+oXoq223H8ry+ohWbvo5o7wKLMi3WWE2s8pR8SmLp8yCo8nf0M0wzvmSGGLXA2ZTDkZO
	8RGX6gPzGLekQcc3It47zSg8ea04TkvcjPvUHPloVPrOziO6Gq9P+5qRHH6X+sW3oVCS80OCtB5
	rZ5nBLWZYNBN+nSXez/h1BxiyigwB5ejSVcAGRIFg2W6KfCxCBbN8R1RchOSi85zGwPvHozhgft
	XLPdIRQ+6orOp3NXUGs1G4wjbFZ/A0CikzgDuzPPihfMj6a4Fz3SbDUlo85pq2mxPLzJoE4snlO
	9eys9sUdn/ty+kP8S/6t9uw/EtvVO9Uapb79qvzmcXB1bFwpzjSte
X-Received: by 2002:a05:620a:bc5:b0:85f:d78c:579f with SMTP id af79cd13be357-88354019979mr3300405885a.80.1760437402464;
        Tue, 14 Oct 2025 03:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWXH1WiqeKRdg/ZhH41/VhdoA1bJDjANkssxaTXJhlGef6O0WTcMGo77Oq7bI7MfQwSpsR+A==
X-Received: by 2002:a05:620a:bc5:b0:85f:d78c:579f with SMTP id af79cd13be357-88354019979mr3300402785a.80.1760437401998;
        Tue, 14 Oct 2025 03:23:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f92casm5118341e87.43.2025.10.14.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:23:21 -0700 (PDT)
Date: Tue, 14 Oct 2025 13:23:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND v3 3/3] arm64: dts: qcom: Add missing TCSR ref
 clock to the DP PHYs
Message-ID: <ivigimfa6lp5rbjdw26t5witdpnlghvbnlljc2aspst457hadu@4yuudxoxx26x>
References: <20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org>
 <20251014-phy-qcom-edp-add-missing-refclk-v3-3-078be041d06f@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-phy-qcom-edp-add-missing-refclk-v3-3-078be041d06f@linaro.org>
X-Proofpoint-ORIG-GUID: nLJDISUyYyJ9mKOpwc4HpNpgSN47Ml5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX9GZLjvH+pOuB
 lOpSzUbCheaaA418pLJ6/t2hoNSOJ2c1qE0sQDRMEuAoOTYRdyNiDBaWzLMbuM1aYgUB274i4QD
 mp0uob/Ki8z1CK87kRycKo+MmImOun4y6aiMk7XDz7tRhL3jeo2Lub58oRUz+Pl4BTWbtC7l5yS
 qDpQKYQOi5hfLsojXK71pS3NA+iKsp0QxlZ776NSx1XGUEPqdCz0X3QBx49WPBUupK8KS95T+1H
 C6IvGd7lwm7Vn9cDo9sKLazT/oC3X9mT4Kh8i4m2G3kD/jueo3ClqZwC/Cpzvz5AvI4rWBa/5dB
 +GxjPwEUFZ/+voS2w+UYhKnOGZBXaNiYBlVNo/v+tEDhYd+3k31Qb1zlRq3g07SEsOurUi+FYEm
 pNi3mOPWBvSlN/yDIe82C8eJdF3CdA==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ee249b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=bvtlJ27tT1nIeLj7f_gA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nLJDISUyYyJ9mKOpwc4HpNpgSN47Ml5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

On Tue, Oct 14, 2025 at 12:46:05PM +0300, Abel Vesa wrote:
> The DP PHYs on X1E80100 need the ref clock which is provided by the
> TCSR CC.
> 
> The current X Elite devices supported upstream work fine without this
> clock, because the boot firmware leaves this clock enabled. But we should
> not rely on that. Also, even though this change breaks the ABI, it is
> needed in order to make the driver disables this clock along with the
> other ones, for a proper bring-down of the entire PHY.
> 
> So lets attach it to each of the DP PHYs in order to do that.
> 
> Cc: stable@vger.kernel.org # v6.9
> Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

