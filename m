Return-Path: <stable+bounces-182873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B0FBAE6A6
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 21:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80A817B2EE
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 19:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489EF1553A3;
	Tue, 30 Sep 2025 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hkBZ3nWj"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE21E766E
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759259675; cv=none; b=r7pyFvwewecDa+wGKdjIGoTwgclIfnY9e3ay9qj0KHhLca7YxFs80RSXakDfdsIO0xYjvmk9zFT4/6RIB+4F03mS256SSfAObkCjJ/eD7RfrxeRceoGB0EPlBTY8Bxh3Q73ncQ91xpdb0scJXiQqF880eeloKINsxpnc8LFF5TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759259675; c=relaxed/simple;
	bh=RFw7rgPy/P4Y4yF7T5QMyWKKqbgPJOvm9kCEWIoxQTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpWr9w6mqXXVXT/v3i4aH6jRSR9dJHAa8heLb4a9NvZ+zAqBZDRl3RBo0jEEPEWEFTDnXMz6nR7tG8y1Xj0AeB1IyyqyhqW8Z8VVBSRWfWaDZCfgPaIxWMCLRpufvXy9d4Sf5AHp51dXGzOPfknuSonvfuRedwAjO3zwo2vZBFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hkBZ3nWj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBqAS1017910
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 19:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aPq1GrPwVVO+Dr1J6r/OVSsY
	OTBdmX3Nsu5MO3vxHZw=; b=hkBZ3nWjZL29Rv1MU2IlMtR/QQYsKIBbq57Wyz3T
	p12csA79Qt8gY0YpzfXNb1YIDzJs/0C6U7KtPxgXTUumhXkkmJHb0+DY1VjLIjdQ
	QyCVr7D1Cv/EYSZVTGvlZP0ch+TzYCODstwQCBdUj2i7nOL8GOmiBkqcVBtSqwTt
	dG89zeFJzxOMxCe7DMUlriVwnWdxdcL6IUW8jwbJn4IIfcKX2ntIIgr599ew+X/z
	6k9LqXcpSAz57WOgJZeuLCOnh9Ktm+nTs1BkbNgdEUu3HTpIH26reOq7/3N7Mf1c
	n/NniQ34Zti9YCLkE35/kGjj6tfJJBRjUqmwCM68YkLUtQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hhwqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 19:14:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e1f265b8b5so46288451cf.0
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 12:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759259671; x=1759864471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPq1GrPwVVO+Dr1J6r/OVSsYOTBdmX3Nsu5MO3vxHZw=;
        b=Kd3P4unJ9HP99ULUZSK2mDVWFOPXh9dw5rypLnxsxW6TtVA4dpXMvOMCqlpP7VFH0W
         /3eInfmC2DMloAJlwDvXFSXD1948M6oNPzCZ3zr9/KcHYLeGP4U7FkZO6sTunXF6SG5C
         bT2xu//SysWcUjxCKtbqkLxI9u9Hz+jaehPl70ypaTXAICMajFSGSDlwmQ5IucAjSTI+
         nz9ewwRh9GAYwATaws/4YEauEj1jTgJd2pEBMf82yPUx7E5D6vCF2LxVmD5DWcHSggL0
         +17l4VuegNze0GKwGJUpTxCGTZp0txRuaEkMb+jSddlytluSrV7paPjZ5wpFXPO++i/6
         aVJg==
X-Forwarded-Encrypted: i=1; AJvYcCXvzaC3gORXBa6oirbtUlCvCBxF+44sVypBvCeqiKliKa4shj1043zeTSNHV0ocKyvIDyfP8/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5GxB5dN9ahVcBGBV1hRmGp2LQ9T0j5yWbxwZlSvxx+/VeG4n
	n3GDFdwbM/hRf3aNNmt4t6fC6udd7+7teIOhuVHjLTRlX7D1IWkC7pj60fw9kST0Zc9HXStF3ZY
	5Ajq/3W/JKHjnPju/cpclL7HNL3zz2ccInbowz2gf0McOf8yKjjTvelfBqZDJqdpH4TIU6g==
X-Gm-Gg: ASbGncu2SUhqpMCR1SKw29wyjP1kT3xyDGpLzSLZoS7jdKihvdJYNReSsIOx6NQOX/E
	UatsDgxwGAbVzytlySxmu0/m4w3hzZWE7iVKrmYj6OUl7yRkpqFpGn98IdNAdIhwNMKG/L7yfg/
	MyRYy3+sS8zJRdDEJ+1x5b2JnDbIyYPZoy2evu6QtwIuvH1XwXE4HSH25hS9KpvRyNJjFI8Ks5n
	fmCYlYM4enpGuzUm6HczzPWGodAro/mF21BBmZLj6yOaJs8yp9XdQ0fc9iSIR/5My/MDF2L+Tmp
	fayVS6JcSZjf8fvLr8rlNrhqxmx0yDBcsxrBTG6Sh/oxzaCOkdAJsJrAU3KJXy/SMbQKNxpxpTP
	SCcp8u1dHAoCdR1K/HYmXtvbhDIg/WF0HgCGi5X289K2ZBqu+JYp2Y3pQpA==
X-Received: by 2002:a05:622a:1cca:b0:4b5:e871:2402 with SMTP id d75a77b69052e-4e41cb1502emr12326381cf.18.1759259671409;
        Tue, 30 Sep 2025 12:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLNJlxjerynVd1dTh9zDT0y9I+Z5SHJ6Y4L40ldD5RmBgpMxLSvRCK4B+vCuq5/baX+cnaLw==
X-Received: by 2002:a05:622a:1cca:b0:4b5:e871:2402 with SMTP id d75a77b69052e-4e41cb1502emr12325961cf.18.1759259670924;
        Tue, 30 Sep 2025 12:14:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb4e39107sm36070581fa.17.2025.09.30.12.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:14:28 -0700 (PDT)
Date: Tue, 30 Sep 2025 22:14:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: Fix dependencies of
 QCS_{DISP,GPU,VIDEO}CC_615
Message-ID: <t3rzsvmepjoyhlmyldvttn3dopxfgoqcz63os44by7iu4r4cgr@crkpcwpaetgo>
References: <20250930-clk-qcom-kconfig-fixes-arm-v1-0-15ae1ae9ec9f@kernel.org>
 <20250930-clk-qcom-kconfig-fixes-arm-v1-2-15ae1ae9ec9f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-clk-qcom-kconfig-fixes-arm-v1-2-15ae1ae9ec9f@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfXw20+c+uoILo1
 k/BoiR0jo0lAqGR5gSD02lC5SCy/pEUrt6yX3Uz3uy6ENDSneKB/+mdg3bHHTk4i+NdknhujW5I
 9MUR0DoAvm3Oij0URhbSnGBP6awBLzQIjA1c0LbWwOQ/1d7GPLWdPYEA7AQueWmZDhYQ9m2l6jE
 GLVsDoiC3uOLO53j4/eobNfD/UkKPPbj0bdfdU185DGzfa4SaHY9nCio8vV+fPMnASuYVigM0nd
 RNLhQLh6XplRISpX46306gmN/XdBBs1W7CyysW8QiQaiZ5zDry2ehj315gED8btzfylZiLYkN+D
 FRevSUJAM/0juEG8GbLflp2MqyOlEhpq8qkIDD3Ahekt2fffHxT3SBHCAA6RI7qk+L4XlIkiPq+
 Vr3c9KHR88l/x79Rf79qnoYEUy8dQw==
X-Proofpoint-GUID: Qpq-jnFIZ0Nyijh1uOQmCvJzHDilCIoW
X-Proofpoint-ORIG-GUID: Qpq-jnFIZ0Nyijh1uOQmCvJzHDilCIoW
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68dc2c19 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zds2va5xP088SW_5QeoA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On Tue, Sep 30, 2025 at 11:56:09AM -0700, Nathan Chancellor wrote:
> It is possible to select CONFIG_QCS_{DISP,GPU,VIDEO}CC_615 when
> targeting ARCH=arm, causing a Kconfig warning when selecting
> CONFIG_QCS_GCC_615 without its dependencies, CONFIG_ARM64 or
> CONFIG_COMPILE_TEST.
> 
>   WARNING: unmet direct dependencies detected for QCS_GCC_615
>     Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
>     Selected by [m]:
>     - QCS_DISPCC_615 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
>     - QCS_GPUCC_615 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
>     - QCS_VIDEOCC_615 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
> 
> Add the same dependency to these configurations to clear up the
> warnings.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9b47105f5434 ("clk: qcom: dispcc-qcs615: Add QCS615 display clock controller driver")
> Fixes: f4b5b40805ab ("clk: qcom: gpucc-qcs615: Add QCS615 graphics clock controller driver")
> Fixes: f6a8abe0cc16 ("clk: qcom: videocc-qcs615: Add QCS615 video clock controller driver")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/clk/qcom/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

