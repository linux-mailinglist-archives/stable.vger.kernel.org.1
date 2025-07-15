Return-Path: <stable+bounces-163051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB309B069FA
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 01:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED4C4A5265
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 23:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D012BE656;
	Tue, 15 Jul 2025 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IaYCSLOO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFDE2D77E4
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622802; cv=none; b=LDdcNSqQvnG3vMWtPio/xXQ8uUQ6qugcl5XiJnSMdFWv0U7K5yLSm+/VKEZhJBvKz+z1Ep3WK1es+18yXZzqQHGVTOB3Y3NPYWQwsCV96tJFoZGTeYI5Qp1kOy7pWi5qaxasyLhb74SatpF2Xfag5ZsJ7d16OtZuiRLoC9dmdHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622802; c=relaxed/simple;
	bh=svz0OAuyUwTJj9o6zAsDikYQeCg6mNOHNGiQpMViUMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUtSp46AaQPWJpWkwcJOMyY+Lp9tiNsxwRDuC/aUAN/EoXDlsX2Xn5E6d6FePPJKZOAtGjK7Nt6oavKtr0VUp4NlW3GwdbrRFfflY0wYYkFOckVdhDW2a/28ERMmstKdRulk3K3d0V5Om8A0+w66Seo/sOnayjRq5/TmKNAKVAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IaYCSLOO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDOpB018184
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 23:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RJPlRCoQzcnkdT0dHLtH3H9tpyaccIIMXOn4F1lvVCg=; b=IaYCSLOOLEaD7LrN
	c+4qWtRQIwr9PbsPWTZao3TgCymOOJOmZECQEhAnPDrIM6rlecqc/gzA17hAKjgG
	VnhgYvgvLRa2DAyMv+gUj9QQYFILDfXiW0q473s1UBcR5ZBMr21PyVcIC2rIwF2I
	KxhYX+8Rwkw+YSCi65/ugOgmCrDQgtCjd2k7eYoGmr95nqmJy1CocCi99FtNEwcN
	tCEaPdzpnNh/A4frAfIW7sxs3lu/eXagbkYSXErqXrjFbUHH2N/1fZKxpjpPMeMA
	A/2Gduk5qR2x0fRKHt4IMfd83iPC1GzodJsnGj1EF+85DhqkHvzacrNWyUGxfZNz
	Y/Ug2Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug3821tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 23:39:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b362d101243so4976655a12.0
        for <stable@vger.kernel.org>; Tue, 15 Jul 2025 16:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752622798; x=1753227598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJPlRCoQzcnkdT0dHLtH3H9tpyaccIIMXOn4F1lvVCg=;
        b=pqiiiH8yPCLJSbFsKyJsypZMtJ4iFxNx1F72YlTSN1fysgSqng7zxlt9W88LPnx5lr
         nlkucvlptTKmL76GJW1Y2SEZqLSGWAf+cQtnxyrCTRuH9XqI8FYhrosVbQgZLUhQiiGK
         EIsvdBFQmzSMOPZmv+5ZKWvJLO+OvhpBSi1ChophBHOvLOl6SIojqNbP1tfCKYASef9c
         1y39vhu5A2Mei5Dj7gQ5GqV02FQJtWqrm9wdXINB/AKaXA2eoWsmBXT5agGf3eQ0V8wD
         k0sIna/IkOdCV9yLpRr2c1LGv7rN61IXytj8OQq6cl7JQns/4wDZZlB2InzOAXVUejbN
         3ARg==
X-Forwarded-Encrypted: i=1; AJvYcCW7memjeJ3D/jb7DV+PY9A5xsqCZC52w4b8Twy4v6q/FRsMH6VeuuxWGwXevULv74weqnptitg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAhP2H8evjV6RtsTmC8qIRBAcN3ct9Q8wrw61ut8Lt580OYxwW
	5fmUrRwt/vtvs/s4emvDDwYnQiHjPY3SNKJ2O0IujJWqs1iCGRkBLZd4dVcFP4g/xoesVcy038a
	V04Iq60f0RSY6+Nc8CKiHtWO7wqBkW6YP4n0U67BKib9HmT/5W6HrbRPUBjQ=
X-Gm-Gg: ASbGncvAwzG/F76g5jP7Y0tm2soNr0R94DHeAmWPCz2kCpNPVu1W35n6NG5BOf2wAat
	zsx40d23qitJJg8/2l1QKxr0azi102boo7yLonRRQrix3aMBu0KqqxG8qTpUUK6xu+MQG+CmmnA
	zJhwwEtl7BD//TzCjQ8KgbpBZhs4+5HPiNN6ClPQmyr/Xs8FfVDpUGwhYOD/kJMS6meBKP2SXTe
	vuVBdh7+5toyKLE0zor0HJvZGXmbXCM4erGEJgbFrLz+qVtdD5tz4CCuQ9wwQc1hftL8Z1lArt8
	Vb85ncGEfhlyA7cNIAlpCOJk/7g/XJkgy94wGfbzC6Z2Nq31diHHaBrlrbz8yPhPY3AE1jr+ATC
	Fypt32RKDMgUYgkVmGffL3g==
X-Received: by 2002:a17:903:8cc:b0:23e:1a6e:171e with SMTP id d9443c01a7336-23e25789d06mr7514945ad.51.1752622798183;
        Tue, 15 Jul 2025 16:39:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf12jj/HXthN2xljhqv21Hmol41Hu+5CcS5uDGOfODnO8leUZVdIm61q3dSm6XrZYdYl3Kww==
X-Received: by 2002:a17:903:8cc:b0:23e:1a6e:171e with SMTP id d9443c01a7336-23e25789d06mr7514655ad.51.1752622797749;
        Tue, 15 Jul 2025 16:39:57 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4333e6csm118928995ad.162.2025.07.15.16.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 16:39:57 -0700 (PDT)
Message-ID: <03f4b74e-9231-43f7-aac1-b2ec1b6cf8ed@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 16:39:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: Initialize crtc_state to NULL in
 dpu_plane_virtual_atomic_check()
To: Nathan Chancellor <nathan@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, stable@vger.kernel.org
References: <20250715-drm-msm-fix-const-uninit-warning-v1-1-d6a366fd9a32@kernel.org>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <20250715-drm-msm-fix-const-uninit-warning-v1-1-d6a366fd9a32@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDIxOSBTYWx0ZWRfX17r7RM+Ex3Dh
 c9AXMBmRw48xcT2H7nOGvQmF7sP8QJAfZyvxyuBwZNYXeBwVkmlKRHw+bZAiCVZg7RvQK6sma2t
 y26hyTALAk+dkqjyUEui+1prr13sANA8HpPS/jbBx/4phGEKxUiLzR0TFg67osDWVtlZi5NHU19
 XxIIZsoNWX5GVZdcKBsLIb45irJF1iL5Y2zZ3yZOsv0tjBoVMkzaF+5fGlobiFuNkFwN4sa4SE2
 QlFACTu42Wry3I64ZWIF+4SNtJaYSIAdwxK2eeyumCZm4zT4eXM7zb0YQCUU02Rb+E7EdqKneIt
 s58+9IAWMNxOHn+c8/EAh4DzD9d6yavc9c4jVeDCYcvfLfx1K61gdu+iKr6a7SCaVCgNRCBaIsw
 Pcr5WXhnXGxHnmVY2x0iicmXl8eECRc548fYteEVcH9G8gMh5biHlBsFVk1sVNKYnpfII5MG
X-Proofpoint-GUID: ScLjMXyNeBy4ZMG7BEpWgej7adK_Dldr
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6876e6cf cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=5QVS9psdCSE4z-izM1AA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: ScLjMXyNeBy4ZMG7BEpWgej7adK_Dldr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150219



On 7/15/2025 4:27 PM, Nathan Chancellor wrote:
> After a recent change in clang to expose uninitialized warnings from
> const variables and pointers [1], there is a warning around crtc_state
> in dpu_plane_virtual_atomic_check():
> 
>    drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1145:6: error: variable 'crtc_state' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>     1145 |         if (plane_state->crtc)
>          |             ^~~~~~~~~~~~~~~~~
>    drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1149:58: note: uninitialized use occurs here
>     1149 |         ret = dpu_plane_atomic_check_nosspp(plane, plane_state, crtc_state);
>          |                                                                 ^~~~~~~~~~
>    drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1145:2: note: remove the 'if' if its condition is always true
>     1145 |         if (plane_state->crtc)
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>     1146 |                 crtc_state = drm_atomic_get_new_crtc_state(state,
>    drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1139:35: note: initialize the variable 'crtc_state' to silence this warning
>     1139 |         struct drm_crtc_state *crtc_state;
>          |                                          ^
>          |                                           = NULL
> 
> Initialize crtc_state to NULL like other places in the driver do, so
> that it is consistently initialized.
> 
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2106
> Fixes: 774bcfb73176 ("drm/msm/dpu: add support for virtual planes")
> Link: https://github.com/llvm/llvm-project/commit/2464313eef01c5b1edf0eccf57a32cdee01472c7 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 421138bc3cb7..30ff21c01a36 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -1136,7 +1136,7 @@ static int dpu_plane_virtual_atomic_check(struct drm_plane *plane,
>   	struct drm_plane_state *old_plane_state =
>   		drm_atomic_get_old_plane_state(state, plane);
>   	struct dpu_plane_state *pstate = to_dpu_plane_state(plane_state);
> -	struct drm_crtc_state *crtc_state;
> +	struct drm_crtc_state *crtc_state = NULL;
>   	int ret;
>   
>   	if (IS_ERR(plane_state))
> 
> ---
> base-commit: d3deabe4c619875714b9a844b1a3d9752dbae1dd
> change-id: 20250715-drm-msm-fix-const-uninit-warning-2b93cef9f1c6
> 
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
> 


