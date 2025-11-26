Return-Path: <stable+bounces-197028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FEEC8A5FB
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 15:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49A7934E385
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 14:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2B1302CDF;
	Wed, 26 Nov 2025 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g8XM1HgE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DtXJM0AJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA9303A09
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167950; cv=none; b=BSfNl/36dAXblsJB29bhLlqOeEwYsRI+fT+WaqiBoEVFVlrihUSv3zgCFw2dXCuyAgEkoQQlW7qqbQIKf/uAmI2yuyFti9bZTNz7bSu5CVVpah4AP0TqqGWmpK9vmHUuxWXs4PJeQXL7xobPUVHoVYJaT3oYH4w7+nCBF3Tm9OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167950; c=relaxed/simple;
	bh=ozg/zky7pZYYhf21hDQgiq4F0XigtmY4Wqju6wrAWUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omaLNwekCaNL8UU1Jxh3bna62Vi9Ced7sLmfEumhH/1Eyb04RVAfywNzNt1xBagIrPwiLmkPVKypuqxXfvXlF7fMIFoT/+ZTVcykjx2ERg8i7p2d5f9Bth8wdOSpmQbY3Z4hdFhBLI7N1qxh40yj04q2Y2jaSDrfvo1lAkcY9sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g8XM1HgE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DtXJM0AJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQBNpcS1849469
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 14:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ih06yL3zICl3oBGO2wVm0aPZ
	B8b204IAvwsOOEb1LJ8=; b=g8XM1HgEHr1K8W8uAY4QNjDYAIOkKFvJk85GA6Z+
	niusaakNCF8kODCZI6RH14JVBEAY5/u97AWP1AYg3IHQKxBpR08intEbjYDYur1B
	hm9TIRXjdvgO+CSGt5tXU39B2n42OvR2a1ugoCrFDGULWpIhOdZ97PNSMpcSc31g
	7W+wnrw4RlcYaF3Uesq2cgBkMJSkQ7NEgNO6KGciLSnDtAHHNwzuIEV5VNND8raV
	hWQeCbkxzHGD0E2EVG3rwGL1hEWKQZSgTSK909AajpP4hOROng+NA9Tp244wr2LW
	+s5Sg/60PB+Wp5SDNROizl2evcDVCk8emY/vNWqD8lM89Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ap0msrfu1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 14:39:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b234bae2a7so1806420485a.3
        for <stable@vger.kernel.org>; Wed, 26 Nov 2025 06:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764167946; x=1764772746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ih06yL3zICl3oBGO2wVm0aPZB8b204IAvwsOOEb1LJ8=;
        b=DtXJM0AJ75fF36lL+oEnLExKCC1hB5E2uzOLQ9mKLy3aK5cVRO99jpDUA8XiEvIAR5
         aV3P/4+9iPS0QJ03KteVz4bORnaHZN2zxxahLQ7EaDlGJ3djtZvRDS08EVs/zfqTo+Nx
         lxAb6jL11iwZEA2kTDXm+7HAVfCUrH2LGmebVyahivluapbg3xg+XnyNHPw2RCzAv6oi
         qZpEyPEpWjI8JCv7a9YBMsnMPIPVs8O8VKIK23NcxaryOLdAne6piSn+5S2+kZu19stA
         R6isd1ooCroGICN8Z2c+XSnWbfCRD+CiCjc5hWv9jLWFHRHBcElr/1XhThlyvP9Q9YNh
         Qb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764167946; x=1764772746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ih06yL3zICl3oBGO2wVm0aPZB8b204IAvwsOOEb1LJ8=;
        b=girXiJbQKJ6GA5bIpv/nDf+DDZtpzVCvpEs/hvxKkd1KP7riGKQdFasWUYU6UVgdkY
         aJ9rM0L67VvYcz4JF004AeFu3dL3DpJL/WRPp9yAqWl5gpFMXt0ZxGsi4WEIerjGDGxy
         ZBvCQCn+C3pNa4g9U76Ah4GuWr35hMsRVZJXHGaoOXJw2PfkR2W9ZlYKNIPZwm0Yhi3N
         6XIRPw43jBJnSjhodzRZMtktspdYMG1errtvemGvbroN3Ex7/2aDEIiyhHfvD7bXv/Jf
         RMvZ3t/hMSJ+GazVkxkGah+9qu4XPl5em1Y3ZOauJlAZaVn3qf89RNB5g/30iQbImKgy
         ZKrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuf9EbcZPsJPtK6N1LTKDt1625XwpohnQsCOd8C2zVT208yPL1+tYcDSVAMk2vrL4tF5aEnXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH35NLGBSXQP6ugb2LMnUIJhtOMQ8FtbxbGfZUp93MFO2N7gbY
	qRXTLij/bFV4CD8X6w5I9YcA4y+reKC660NFbXRB+LTh37gw2MlThIV/7lIvRt3JGq1WvNh60ax
	zvCFK8egPTLq80yhkdAKoOb2x/OeKCmTN/6YfKjfvhCSTIBjMwKxmTJUTU4RSA+0VgyM=
X-Gm-Gg: ASbGncvEtAncW/8VkTerb+iuiUzdNVeukTKvCnImBytQh3JTwhJvWQlnM7uTLdRVfRO
	UVEHSJJCmwPEzAcfqvfnB1Hp+ZvEOVGtYzwntuZqh8/9cEdGrDFg4kkIY1XeS4/vnyjIRg/bfH3
	EsOSIFSrmKkIiR75KJbF+64wZqPBZIJXMK1/pcZHVs2DmTS5/yjRSdn3RJRgJfV/EkdMS7zBWRx
	sVlSvqvtDBrlzti3yMEwSItHMiKSsc2jJjS2D0rCtILfz5hlIAgydmVf+d/gp/e6el+COcRRCsM
	sNp7hP0wNRM9cV8OJ2q5sh3DDaxGX+vbd2V0CofsMPfy5SSKOARVtvIEu+egbtbxqvKDtV0ju0x
	z2GNpPBMZaYY2qv+1BNZA5N3f4walB/CA834Y+gV+gDeWmteY0kB1Ivh+0I1cs7TGZO9PhAy6br
	/A2FYG+VUY42U6uP8HXt3pUQM=
X-Received: by 2002:a05:620a:1a04:b0:86e:21a4:4742 with SMTP id af79cd13be357-8b33d4808bdmr2719412685a.77.1764167946390;
        Wed, 26 Nov 2025 06:39:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuvwz9GZiR0vucNDwByTSixZwnlV3s+6YWSU/zh6BM6UYrhc+KLDg+561iMmnbTPrGqzYR6A==
X-Received: by 2002:a05:620a:1a04:b0:86e:21a4:4742 with SMTP id af79cd13be357-8b33d4808bdmr2719404985a.77.1764167945752;
        Wed, 26 Nov 2025 06:39:05 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbc5e07sm6013824e87.83.2025.11.26.06.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 06:39:05 -0800 (PST)
Date: Wed, 26 Nov 2025 16:39:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        manivannan.sadhasivam@oss.qualcomm.com, quic_sayalil@quicinc.com,
        nitin.rawat@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V1] arm64: dts: qcom: talos: Correct UFS clocks ordering
Message-ID: <s3eeapfrmw2smh6j76mhegeanqfq4vwa5jz7ilt2d5bf3acxc7@t6hkp3c4jjsk>
References: <20251126131146.16146-1-pradeep.pragallapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126131146.16146-1-pradeep.pragallapati@oss.qualcomm.com>
X-Proofpoint-GUID: yFtfL43bJpPuA0dOFmmG6i2cF8r1TEoD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDEyMCBTYWx0ZWRfX7Zzn0lSctYnZ
 Em+Vx8iVw/PkWA3+m0GYgzEAImLBX6jL1/Q9nmxS8ALdPKPbNxLBZklDXFoUrWGF7U+a0dRGCE2
 o2zHVBsAM+3funYm0SVDIctZM7gK39tHUrd8hg4VFuR1XTiR1bNL5v14ogDizb5ZS/T/c3/7gFs
 YJQ869oHupyU8Iax2nHVyQe7I/jmixA0vF8UKGwcYsMhzfHDrXLdlEGhWBmaujYvyQZpSG2aBjd
 fUicBKkS5KqC/lNOZg7gnGjb1pbmFieHzR/7IwMaC4cMiaSMf7n10NFN7tWca5iST9W2/bzbi/g
 wdolAQGqzGzc2nghkHjJopFElnYeE+7pD1u6RfgPg+MDgaGz9TQk9XHAKpA4KnRKE8dhGsc16sd
 ux7+2rrhNmIRTryga5EMSEogGFMkpg==
X-Authority-Analysis: v=2.4 cv=N5Qk1m9B c=1 sm=1 tr=0 ts=6927110b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=M3Igi78ymzd9_o9g02sA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: yFtfL43bJpPuA0dOFmmG6i2cF8r1TEoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260120

On Wed, Nov 26, 2025 at 06:41:46PM +0530, Pradeep P V K wrote:
> The current UFS clocks does not align with their respective names,
> causing the ref_clk to be set to an incorrect frequency as below,
> which results in command timeouts.
> 
> ufshcd-qcom 1d84000.ufshc: invalid ref_clk setting = 300000000
> 
> This commit fixes the issue by properly reordering the UFS clocks to
> match their names.
> 
> Fixes: ea172f61f4fd ("arm64: dts: qcom: qcs615: Fix up UFS clocks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/talos.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

