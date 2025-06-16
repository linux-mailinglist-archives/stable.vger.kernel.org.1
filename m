Return-Path: <stable+bounces-152716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE57ADB314
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 16:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BDD188D044
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B351F37D4;
	Mon, 16 Jun 2025 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lI40D6PB"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839FE1E9B1A
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082780; cv=none; b=S0CdM/H1saskao595hPnxCeAYeM4n2C9Sad7EyeuNeORrYFeaeB9Qu58B+zlPCingOgfcmBVXTG5TkXNadWFdrTD4sC9yGGgdBM5V5FHM4P5RCQzoRYOMpdD6Ypv+6Mo3Z+2X3Tdg9ShP0+5KboME1qoqzCD8Ca4hquBle28aAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082780; c=relaxed/simple;
	bh=xLc9ItWh5tpODOaZ69PPZ9EYd++GnaUzUK7aTCACc2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7hVScXaBAycNGLJl27TMI5Fg3pyKo+fCpTWyMKVRCpTxJ/XRv4Z5YM+x4KPdGyq1FE8ZcgncX5QJRqnZfdc25kOxS32Pej24fOzzxfpkT3jHTeYjtaSUGnmpIRxFcA0wPvumuFv4YDdRp2L7LAbGBtc9rtz+QfZDbcCLzLIWXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lI40D6PB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8Scck019267
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 14:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vh4hjv26x4W/Itf7e2ntHRGf
	CMDWqmAVMqTQ3fn4agY=; b=lI40D6PBuR/dA9dRvhU0KaCtNGb5cKaTtRJsWh/u
	QOCUul2h2ihPSphz1uWTsDL4tP/hP6vSOlhllZyo1WIeOgTTxm7N3P5yEaEjarJv
	//Ja0t10utkJQj5u1/YGdT7WT/g2KhDK/+MLs7Gx+t+mXO0JPpJHYM0aphm6hsDt
	8nPkuGUI25pOBgeVAkXOmie7PU6ZcBt7hx0acp6XQVtbbjvpuKV8Ggbz7pFqcu1N
	9l0zAzVw8sZxEsr/9sN1WeIE2RFlbbF45TwYxufz5Dir+jmg1B+jWbqSJcvKX5VP
	MMfsyqPdAYPsKxaldL7l5AvEMqD/QBvkpqtMb0OzWUEWTA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hcvrh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 14:06:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5cd0f8961so1036036285a.1
        for <stable@vger.kernel.org>; Mon, 16 Jun 2025 07:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082774; x=1750687574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vh4hjv26x4W/Itf7e2ntHRGfCMDWqmAVMqTQ3fn4agY=;
        b=GeUMT9+n11JgEU7T0TG4tCbfC+3twQ4E4vPIK5+uJ5BJ7rvhYtlwo9VqmTsXBeUdhO
         SITMu/AyfhLD0VH89Peb3G4y8HeEbei5WSDBfWIgI8MneHAbmjKGWs9JjiLBnhqM+T2c
         1sGfbwzHbORJ7DP26PQJ/2OZpa5k5+3yc2lKVzU3e+qlVUXxK3HSvxt+RRvs2xAcwRxM
         GrN0YFCapeo760mHNuVbJoJgjDjWUur5pNYqhSQ7CIh2cDFFtTU0BG0momiAJkSJCEh2
         e73NLF8h+ZszOmRd+nCIy/WH8wgBXfJViIJJ4HbfXa8eSJdbb34F8LmBwnWkSB11pxC/
         KDoA==
X-Forwarded-Encrypted: i=1; AJvYcCVSd9LuYs0TBLAuA1gwplVolRPWS6IoRPvAfLHIhCvJtDwDbcN+Mzdcbb00M81S6biXpWLd8bM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxejnnzw0661Pn7WE1AmVAJy4Yplirvzu75jRvqTkcv9jHlbbGp
	ywLiLKzvlP/JN865XBH58su/ijyxhGx4qHoQYgMAj94ADQxpRbZEAdZSX5LwdN/tT4CRL8dAJr5
	n87fZsVAaWD+yp5HpDVgVLxDqrPwF0or45Qdl8pLCB4SFpipr7YVNF9Jg9qU=
X-Gm-Gg: ASbGncvdaOsTVgNH3IhVP+96Sys26TTL2SOk7ZwFjuN/cAUcO34aOdKc3wYKekujs8j
	c4P7YE3EtIHmpS76fEyoGKjWrxgvd9aokfMGUeRMMB80I5ch/NKm85+gjhDoRiek6tZ0dst1fsT
	gMRwUhE9TTa8/EykHJzhpN82Q4VAljv34xbs8kcjQmCk2T0q4StGMhPsw0RxLyROS9qiRMpJ/Uv
	7Bp/5xaN3fXCWL9MAcGgpWXghwmeYR/WTslnsj6r0sGbgxgkb0gV0y3b5Q4pu/gJ8tPm9RtUNYT
	Y3GAWO6jdi8xZRddlB+SfCHK/h3nRC1Wzi3psSc5SjdwWWL/FDVMMpuYx/Ux9JLOGvSwfPjUl4Q
	+p91UPzDGmETDiiolA54kPx5KruFDNfpmXKo=
X-Received: by 2002:a05:620a:1a0c:b0:7d3:b8d7:a9a3 with SMTP id af79cd13be357-7d3c6cd8471mr1278004785a.29.1750082774063;
        Mon, 16 Jun 2025 07:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErsy0AzGP7wZvoQHWt0vDtH88N24PAi2+rnq1/4b7VJfb7Qwiz2c7LeWxv+Fli4AzjyHe3og==
X-Received: by 2002:a05:620a:1a0c:b0:7d3:b8d7:a9a3 with SMTP id af79cd13be357-7d3c6cd8471mr1278000885a.29.1750082773641;
        Mon, 16 Jun 2025 07:06:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac135d8bsm1570805e87.70.2025.06.16.07.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:06:12 -0700 (PDT)
Date: Mon, 16 Jun 2025 17:06:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Doug Anderson <dianders@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] soc: qcom: mdt_loader: Ensure we don't read past
 the ELF header
Message-ID: <5u4vb4wjqvc7zlcwtyeixfhb6qnx5vppgnscvt3ypft5olcnig@rmbscleivq3u>
References: <20250610-mdt-loader-validation-and-fixes-v2-0-f7073e9ab899@oss.qualcomm.com>
 <20250610-mdt-loader-validation-and-fixes-v2-1-f7073e9ab899@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-mdt-loader-validation-and-fixes-v2-1-f7073e9ab899@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA4OSBTYWx0ZWRfX4C3N9VdI6q5j
 FY+4sjBZHYYVFnl5C8AQa9XCKKAyx53v6avRQOd2sqjaq0738huJQ/dF6Wx+dN3UlDU29YEpUQf
 HxR0CSYWIAOZGI0FqldMNNKV2WundM04H1Zpxt8+rFMjIuj/u1FaS9bNXsu38hmsy7/6K4Q9uX/
 U3kH4+EuL2WiwJEqpfxL9gvpnZ5eyjtwUvb614WsbDzhqQXeQV2HL1akX0ZyakSkqVc+Cv+xqRr
 pzNa6087Wz41z8G8kgPS9YO6nSUkVJ7B7w/MBu1fbpE9O6QrXMI4UZOyS3pbIIm4j/xZiZtjTq6
 3qpiLpbLOMWxQzbriI0mijn0/WkRbveHctkEQ8iqTFIPCRGd8gfVKK8P9w/nE6BSJ/mxgGoBWmF
 X8gSrt1yyJE/97c7zkVnyOTCxipma3H8X35dRnL9L1yaJ4eYH5GMFtVeX6Tch0Q9f6VRA+TA
X-Authority-Analysis: v=2.4 cv=PtaTbxM3 c=1 sm=1 tr=0 ts=685024d7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8
 a=_mC99nTGYcsxCmVRH_sA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: eEKQfLzRYYsDtBNElj1vt73T0-KemzTR
X-Proofpoint-GUID: eEKQfLzRYYsDtBNElj1vt73T0-KemzTR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160089

On Tue, Jun 10, 2025 at 09:58:28PM -0500, Bjorn Andersson wrote:
> When the MDT loader is used in remoteproc, the ELF header is sanitized
> beforehand, but that's not necessary the case for other clients.
> 
> Validate the size of the firmware buffer to ensure that we don't read
> past the end as we iterate over the header. e_phentsize and e_shentsize
> are validated as well, to ensure that the assumptions about step size in
> the traversal are valid.
> 
> Fixes: 2aad40d911ee ("remoteproc: Move qcom_mdt_loader into drivers/soc/qcom")
> Cc: <stable@vger.kernel.org>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/mdt_loader.c | 43 +++++++++++++++++++++++++++++++++++++++++++

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Nit: in theory we don't need to validate section headers since we don't
use them in the loader. However it's better be safe than sorry.

>  1 file changed, 43 insertions(+)
> 

-- 
With best wishes
Dmitry

