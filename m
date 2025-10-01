Return-Path: <stable+bounces-182899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A8DBAF595
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 09:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B151883A55
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 07:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BE01F152D;
	Wed,  1 Oct 2025 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NUL7WSz8"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD81E7261E
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759302275; cv=none; b=Nf1Fvx127MRfrr5Xe+2t6dMri4yXch/+S9rsx50Pny9u4n/6XSyai8nawI6/ymv5BaHB1xpjUOrsUarVTYWCe5S2WRO/DHYSdnEePl4FFNZOGFhZyqyaEIXSC7TDey27wI+aklovRgopbAo7n1du6elUt9Mnrksa+CvdmEvFNdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759302275; c=relaxed/simple;
	bh=We2BKF/GHnXH5YX/6E9v5kprJ6brDvpihZaj/zsbNOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdzorA3fy1q1n2G9cmmwE36R4Ao8/yMR2tkD1uUY/EXGXSRLDFZuvTS5E+3LO98tAUFF9ulzTQdk7PeY/3/KnWsYBtb3b1Ke73ZwgFvCPZfJoV/a36AGY9aTS0WhPwpFLungr+GDu0W/aZ2gXQt5YeCW5Fn8QzGpKRxBMZOM13g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NUL7WSz8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKYNLn010699
	for <stable@vger.kernel.org>; Wed, 1 Oct 2025 07:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rajT27AwFunrMNV7n/DU+VYrepqPJvpfTRDT7Uk8rjA=; b=NUL7WSz8Lq0J2Yug
	iwphD+paud8YRd/GQRn/PNIrIY8X54TBs0eq29v9iHTUJkzpL04BQqWpRhZu/3wd
	py3S09QvkmwZQpuQE6vOI76HWMZrLKJdqEdrPKKvliTdlplwHppaTzNCsUCQtEMK
	NGKkKau+Oyc7jxRqU6b+U4OY/TvR2zVrpyuIabqyb9Q7UgodAQ3G0mad+zl32/TO
	IujM2q5oaGekfT1RUXPDf4ZL9wmNQKwsvRyx/wm3T6C3nv79fpMsR+Gqm3QnbALQ
	tb9+YNE00NRWCkdPtWLYIwW1+Wpb5pJOtzFn+CFp837ax8kCK0NSnxjxSOKmGPPE
	nNU2iQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e5mcv1eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 01 Oct 2025 07:04:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28bd8b3fa67so30445765ad.2
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 00:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759302272; x=1759907072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rajT27AwFunrMNV7n/DU+VYrepqPJvpfTRDT7Uk8rjA=;
        b=DlrKwpSM1MJGZrM42ysV4jM0HKkHyLZBTLkLe//Bo0b8u35NkI24itYF0Wabc7zNx0
         Yrf75xUrprYPKaPjKirSAITJ6O2i3vqy8IaKaVt2rFibz5DWDTDDJrHK2S7Pbiqg9O73
         pRwqso0fQ1/sAid5PLyJaP1ldjFNa7piJpVFjUOueWMfq/5MTAt5LmYm7q5fBHvXAhbu
         neLLwwc+6VaZmJ4Rp+vt7Mbx468b4ICjRB4w5BriiZOdVtD1ezvMccM5vYsURQ+2dqtc
         jGrqVnpCJQikktt1JTBgq/BmW4jZeHFCBYKTJnFoUJ9OPWHtCQbMjCnbxeX4QJn6fkQn
         DbMA==
X-Forwarded-Encrypted: i=1; AJvYcCUU0ooEOwDQTpUjxLBKX342+GWIDUV/t0OeCS15qkOk/osAu6MtWzkdeiGEUYhjcO9Qff+UXr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4JoieFUu7sS4bVyrq2oBQEoq8/Xi31/rpTPDG1YSfF29bkwKM
	jMWoxmawJhIyh5SDnOhbUqqj2mrkxWWcVNjtu8qZJ7XwbP1OVKlID3Wu3k2WdZ2HFaqwWd+5CR4
	cjYQB2vZ5K63xZTKWjJnUUCmWwwVtPcvwfiVdECK/+7XvOayyiXErUHIAG1o=
X-Gm-Gg: ASbGnctM4EiIHogYYGw6+05AwRpbM5J6TaSGYWTUEVU5V3/jb7VDn3J3YX1gkq0PXXP
	bKQFN+oh7jBVU+M/TdBwOMSGT0BVIq+Ox2IdGMafWpJc0LF9wEBP1z4fdiS3mN0UnSLynwBPT6J
	zXZmJyq1za+b4rkNpSObDDkMSGOS1I2w5eyMcWS4wqPRba82RyvP7cEpnoWErUECj62Gli1UNc0
	98B3CH9dSDqTK4wnApKI0US344H3H+WcT/46bVm3CXksGV3YOtiGktXwE5186lSY67mPetu8x0/
	MuRVCtnfKDYixY2mjEUAoagPW7aNplhzKDCwGKaOPQGiISrwqsY5BG5lII/IxZtvTflavS2u
X-Received: by 2002:a17:902:e74a:b0:27f:1c1a:ee43 with SMTP id d9443c01a7336-28e7f32ff11mr31042315ad.29.1759302272016;
        Wed, 01 Oct 2025 00:04:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv94nJISy/926rdHvVX5QYfH6D1YpTXMM4MBF8t63Ks9MFaXihh5qMTzyo0mDLv3bcRsz5VQ==
X-Received: by 2002:a17:902:e74a:b0:27f:1c1a:ee43 with SMTP id d9443c01a7336-28e7f32ff11mr31041995ad.29.1759302271554;
        Wed, 01 Oct 2025 00:04:31 -0700 (PDT)
Received: from [10.218.33.29] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bd869sm179517665ad.120.2025.10.01.00.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 00:04:31 -0700 (PDT)
Message-ID: <58d76b7f-843d-4439-a987-7895e0b52441@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 12:34:26 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: qcom: Fix dependencies of
 QCS_{DISP,GPU,VIDEO}CC_615
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
 <20250930-clk-qcom-kconfig-fixes-arm-v1-2-15ae1ae9ec9f@kernel.org>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <20250930-clk-qcom-kconfig-fixes-arm-v1-2-15ae1ae9ec9f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=68dcd281 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=zds2va5xP088SW_5QeoA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: jrN0y5_Hmr327YwWmhzaL0-YbgphDEjA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwNCBTYWx0ZWRfX2EAZ+mliWqnX
 B+OqKKU7sSSNbOBtxdsx1kRi7jvd7SMI+pWUSReE+TurXTKYTNkm5cToTsWNdB9P87ot6NB2//p
 38hcZXTVwf8Rq9Bm4juW8guHUKqUv1AapGUkYsMwT/4BC6I7ZwQ9E3F9bDhjbRtlChjvU0Ufbbu
 eEDQpPtwdcORQhpZNWsZyPyW/RwKsjKs6s5ADd1xOzd4I9gB0gUKbkomQs7bRdlTG45eZSPk4rN
 2ttJ1r12+X6RyGXwHeOBUPRx5p4aP5tJm/xwmfGJ8ePPXWFD6EPnl814C7xPQShQ/1p14Aj8uDF
 9PQW7upENw6bGDOfRUdo2/yNhhemTNC8g59C9VdaitRoT0ImWVMGJu1ysDU9CetdD3YHlOxCxyR
 r0YrJDjF4qceY7RMc35su/Q/v1h21g==
X-Proofpoint-GUID: jrN0y5_Hmr327YwWmhzaL0-YbgphDEjA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270004



On 10/1/2025 12:26 AM, Nathan Chancellor wrote:
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

Reviewed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>

Thanks,
Imran

