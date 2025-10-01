Return-Path: <stable+bounces-182898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05F4BAF58E
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 09:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98977A1267
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 07:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2A47261E;
	Wed,  1 Oct 2025 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JXFWvd3d"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE91C861E
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759302223; cv=none; b=Wxk6LsMtXPfclJ/F6Gy7DtM8Z+wwZzZOF0VSXQs2p7EA5zAG89zqB8tCO/vxGghzqAlel+LqOsYVGqUeb4lSDYTCm5aAutcZpGwuF9PSTvAXS5ct9631nb1SYLDjTFtr3SFsFFu43Ji6zosm4fYzJ3zZdw60YYNopsMbWm1d3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759302223; c=relaxed/simple;
	bh=4bLqWv0MA1lGdWx51FlMH1Tx6y0z0yBtkAGpBUXY+LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3VRXIvyFmEsEoTS7R+MnB/iEWN8pwfqAyyKjCUTI4Bu5/bLGLOGBgt1Y/erxrwmrCMe6emaNTG3tqFyWXuIpRXGhiohsSJ97fJubaFqlrkxTihpPyXiqBFGx9+Udt924aQEgg6VyZh0B8VayHE6bbGPNDp5rqJNuPmpV54sXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JXFWvd3d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKeC48009336
	for <stable@vger.kernel.org>; Wed, 1 Oct 2025 07:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+XxcaZX2taq9qV4nbICxRulbIsspEUNYK0zzuhWUhKI=; b=JXFWvd3d+3uTuOmA
	4a6s4Cs/hDMd0qUUjLAsWeOf2W6m5mmWJgFGTrqPXZmrZ0wQCOkwLRDh2Pt2RPsv
	E1dUL6YbLqk84VSGhpEU0tvfQVrQfNVw1e78H+R70W94RQwtb5Y9wxvv1xi9a0v5
	QOQecuHZZxoHpw+DlzfR0Pd2heuPRB9zBySSZBB94wZ/kYgdjgIycGwCba+vopJw
	cWgXPCQU5WuVl/e6n6bYW4Guqq3T83X00eAS5N22b7lEqle2NeGCaVT6fygMShU3
	eGE7dl3iP0lH0rRxQDrm3LrF0SoPNuOsik8ZQ7baCcWWx32jBzcSI+7hmiWq4Lhx
	889oRA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977uevx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 01 Oct 2025 07:03:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77f2466eeb5so6133763b3a.2
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 00:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759302221; x=1759907021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XxcaZX2taq9qV4nbICxRulbIsspEUNYK0zzuhWUhKI=;
        b=o0pqU62d4ouhDsb5G26n0NpSt47RWvTfAYPHLWF1ucqcwIqrzMt6W/TjQGNdYFtzLY
         +OTE3ijwELjS5j6YamV/QMbD+XPuLPAfBC+mDWREtgVqcjA0UG9Lsm9HE1lQG/BGZZv2
         bvClxjOIV7zWVSlSXzACq121YPBmteK04bFd5mOVYmNGEgXVtHE5cCjkDxZbfDMoW5z4
         Ay4Ig3dWimk4i+kkQl/bjtM6dB7NfiLWdTl9FjtEC/8FX5iQ4ynSqe5ybqu1NoqCODTO
         5j64IK87XkH0olf2LsIH9TxCCh9d/tRQSBVgj7UyAaCNPPyUlOcQb5p11t3sQLdlmChZ
         +4Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVjPQM6j47KGGz6eSJnUO5fqUFNuuTo4Q/w+F6O2BnAPBJoxcFJnGUzXZ0/W7n5WMVjzKvSbqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRaXDbF4Xq4/UM8JLgnnunBOC5ipNXr/UPwqbF0Vzo7tZPcqva
	QrEuunv2JknzEg4jtUfBoBTURZdeQGMCu8svE4URafDO4mWzgM1wMvdQ7geBcPowkQPO5sDpzuc
	f7L25Z8jOfxGcoKs919EAVrjXbiGjdYym96IJt2SESpb2kTNwogJxTeZnRKk=
X-Gm-Gg: ASbGncvEx2/rLWx/C0sPOR2WxFze/ChNad63FWiHnoH2ftpofQFJkxTul42Y4bVCDnb
	hZiQKwFLuvW7VRqnlBAPe6tuuEoWnAPwDJteMSbC+tPR0ODgxx24xQD/1XeUhX8vIkcxSjyE7jj
	jIgfURTyhYLNV1NTXCaEZugnrTpNj5ppRG+ENpTQRdRza2NVgS4M+lHvBIQiO/YiJLIDmaLuzMV
	uw7/ZN5XNw0rO3bKAdxPZFuwxNEux287h4eZ2mpsuI52b3C44zdFJY41J/DaNAJkEiMAQn9GL1q
	IgaPiNeuuqb93hRb+QkjBR/pV+t/jK73pr1lA77BeF72yoN5AhN2O4zDUPl5L56rTmrm5t6Z
X-Received: by 2002:a05:6a00:23cc:b0:76e:885a:c332 with SMTP id d2e1a72fcca58-78af41d3f6dmr2859549b3a.32.1759302220569;
        Wed, 01 Oct 2025 00:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcl451PK1NkVZh3OLUUPJtnf8fNN5lOQqjF+yrOzMLlH+aNHUtU9sxDhsiuCyHZkM54X0sUg==
X-Received: by 2002:a05:6a00:23cc:b0:76e:885a:c332 with SMTP id d2e1a72fcca58-78af41d3f6dmr2859475b3a.32.1759302219829;
        Wed, 01 Oct 2025 00:03:39 -0700 (PDT)
Received: from [10.218.33.29] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238e9a9sm15587378b3a.15.2025.10.01.00.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 00:03:39 -0700 (PDT)
Message-ID: <9bfa3478-00b5-49f6-a808-7d60de5d2f39@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 12:33:03 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: qcom: Fix SM_VIDEOCC_6350 dependencies
To: Nathan Chancellor <nathan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, stable@vger.kernel.org
References: <20250930-clk-qcom-kconfig-fixes-arm-v1-0-15ae1ae9ec9f@kernel.org>
 <20250930-clk-qcom-kconfig-fixes-arm-v1-1-15ae1ae9ec9f@kernel.org>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <20250930-clk-qcom-kconfig-fixes-arm-v1-1-15ae1ae9ec9f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nNhKtNRckZFpNy20_r_fkWRlHcFMlEyH
X-Proofpoint-ORIG-GUID: nNhKtNRckZFpNy20_r_fkWRlHcFMlEyH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfXzWl4nLKYTm+O
 Lba+XemqBc48pc8KTwVi9YYyjK/bH7dljtm/XxybwZor3LfcyAaGn9NNQZ/8+nKUXaX3msFpLtC
 huHVN68LenNlK/6iiUNw8V+NGDsmKtuwmgStbgQ0FjXa/H3iGHrM8W1MTw/zDp2dE2181V2p8Zb
 uo2qdRnwzQsFXGbkfny+gFutt9ldH7IMMi0j3XZk1guTDbSV+VV+cCb04Cs6S8kJ6kiTfA4d4z/
 6FJw4gEOafMSB+iEIHNzFG4qX0XR66fxH3fP6q3FOQgpvS2MSvLejGCUFzfTxQbkk8F1jyiOz+A
 XSe3afUfTGV3W4IIyLNpXTVWEAmx5gp4Ylqo1NI6CcNUuw0eYxBexHuxUcYBhBehseQbQUf4F14
 0PPit8t2na5mWiPkyrepg7xZPldceA==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68dcd24d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=oRYDs8KJhtz7EUiVKSMA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043



On 10/1/2025 12:26 AM, Nathan Chancellor wrote:
> It is possible to select CONFIG_SM_GCC_6350 when targeting ARCH=arm,
> causing a Kconfig warning when selecting CONFIG_SM_GCC_6350 without
> its dependencies, CONFIG_ARM64 or CONFIG_COMPILE_TEST.
> 
>   WARNING: unmet direct dependencies detected for SM_GCC_6350
>     Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
>     Selected by [m]:
>     - SM_VIDEOCC_6350 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
> 
> Add the same dependency to clear up the warning.
> 
> Cc: stable@vger.kernel.org
> Fixes: 720b1e8f2004 ("clk: qcom: Add video clock controller driver for SM6350")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/clk/qcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 78a303842613..ec7d1a9b578e 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -1448,6 +1448,7 @@ config SA_VIDEOCC_8775P
>  
>  config SM_VIDEOCC_6350
>  	tristate "SM6350 Video Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
>  	select SM_GCC_6350
>  	select QCOM_GDSC
>  	help
> 

Reviewed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>

Thanks,
Imran


