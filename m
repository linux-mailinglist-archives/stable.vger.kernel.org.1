Return-Path: <stable+bounces-134763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E005EA94E06
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 10:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3847188DCCA
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4E6202C44;
	Mon, 21 Apr 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NLw130jc"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14571D5178
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745223716; cv=none; b=cXIITf6Wjpo0gPxbJF1iZD2mesYvNM19hm8xJRl/ROl6O8yhcyg/uXQWADu9ZRt8YF91nhiwduG35TZ0WfVTt15/YUqYoboMxA2HyaE/ohFDJMOLQp9W/2Lz94NMNmKA8zh3U3LO7+/4IO823ZmFfSuRd6weBklHiK4NSgMwqoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745223716; c=relaxed/simple;
	bh=rfBDcIm653IrfaI7zELXpLUcNIgBnt6pj9hB8cCMYuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X67X+V8fBNqeOL9V4bTnGaPBS+70HW5Nlh0wrzDEySqeve5BZwFiquoMCvFKxWdJCFKRrLByijugpPLf2UkU2pAwJfc8YtTNnHfQHbLEwV54MNh+QevKBEghLmQ24dHmsumJB1OLXVLlxi2uA0f1V0jEA8NqBWegYbvjlEu+3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NLw130jc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KNj1Ma014718
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 08:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3dOV6TefbQJrNU5fY48fEav9
	8ivZ7YhZXWg/363uaxY=; b=NLw130jc/sr36xMO9dNl/g6IyD7ilOeIFbzF9qus
	2Q7pUhbsYma/bac/sVzWK5N6bHxtztyQWebdcv+txHS2qXQZLFBms/JUBq92ePYR
	uXqk1gr+l78B6NM7yF0DPGmVeBKi+/Tdbh8inaRYfXem5SvLJCnLXwInhQGg76rt
	oaeCoSPiAPzkxaFv89Sz5D3IUicTS3oVwj9/pMJxRvGnbpf4PSxZPao/wZC0MHHX
	W+LS9vx3ajkiHkhSP381maBSwCBBPqHpT1LE1LzQhes87umsssD/O1mU/4m2tUWp
	N/AaESjzu5o9/61s05AVsqSWT+q5yd2MIjKF4HCjoOeMGw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46454bkddr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 08:21:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c54e9f6e00so712529885a.0
        for <stable@vger.kernel.org>; Mon, 21 Apr 2025 01:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745223713; x=1745828513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dOV6TefbQJrNU5fY48fEav98ivZ7YhZXWg/363uaxY=;
        b=G2azuE7fhJNjvySrLYNU5iHijdBvwxE1F7dtJ1XiwclQd3dZBMbfA2O51nJ5aAqf+W
         DForbxtlzMFsynh7s1sjFKUnBr6+hxzwNdPUhAomJfVNbn2cB1SCEXHSP0fLRaRtOZxs
         xgia6xqUiOPc3MFfqK/3K5p8Q7qLyZSMAa8SvJkJpCcFI1esT2v7UUquC1tHNvn1HBMP
         K36+daInsQIAThLh7mNN8F+Hwtq9AlUFx/T9XufNRj8CVeOGi/XTb4POP93VM7lgnOWI
         ywKP6hn1luCzRUaYvcKtfn/pI+fqkimDIvedvUz14LrvSdemiKapxX8v2G8opqTDpA7e
         +1iA==
X-Forwarded-Encrypted: i=1; AJvYcCW5dqzNJALxycM1vY//ovp26aJf+JjF482Jd+4Az5IDIETIm+dHXLJjFKujpgiHZ7jKgUD5cAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcDCpjlJfFSrGlX9+sT4EApAbnour8t2fUC4Bss4DH+02SUWM9
	gUzepfkDm+UzIM+64mf2DkWl638GYG9diTsy5iQXVshxYVQJoeMJKcc9tlCeaxl7jubyuF5AO94
	68JhD38ROtwKCr/QCGhTZv5xuPal0pUejIAqmThUCsyPWr1W5oNT0czc=
X-Gm-Gg: ASbGncsSbosiwPkKQbruhqsi3KRxBxyTPl8dLe5vUd6P3EAFOLalGKCnV8GjdHlPiT/
	IEkU/muE1yTcUEYzz3hp496q0X8HkIDPav/flGXUuTPmY9X2yJ3EBjzP+kcCYUWzbEHcoLr0Vvk
	/Hur8TYJ/KbAy4nnS0a5YRik1sooWhXxGE7HlTv7T7+DmhYfIKy4c4WuaI7zcwNmcljfRTrRSlX
	rCrWJBt1AdkBwXTYjL1rJekaOPZSEtV8t6g/tXfkwyrbwrW8s9V/vpG8GXRbvi+73J/+rIcz/rw
	qCo9bSP6FxpPzb97DejG0weuK0KzTieTJNe8zTXW7uBHnNppecT7SeZuPN/bb67nKvo91gGgBGk
	=
X-Received: by 2002:a05:6214:2505:b0:6e8:903c:6e5b with SMTP id 6a1803df08f44-6f2c26db1fdmr178470816d6.9.1745223712768;
        Mon, 21 Apr 2025 01:21:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiFDbAU4iG+kC4GnIeIE42J3FEGXYRJXXp4pFCBWX4GU50la+M9HKv+Oo+djrzzh+vCDGc+A==
X-Received: by 2002:a05:6214:2505:b0:6e8:903c:6e5b with SMTP id 6a1803df08f44-6f2c26db1fdmr178470656d6.9.1745223712436;
        Mon, 21 Apr 2025 01:21:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e5f4cf2sm864754e87.215.2025.04.21.01.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 01:21:51 -0700 (PDT)
Date: Mon, 21 Apr 2025 11:21:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: webgeek1234@gmail.com
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: Assign plane type before registration
Message-ID: <nxp2vzmushnkigmyk2yv5vz2j7pc7fghtvn4uielhaqqn2dcnv@eq37j45mqpng>
References: <20250419-tegra-drm-primary-v1-1-b91054fb413f@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419-tegra-drm-primary-v1-1-b91054fb413f@gmail.com>
X-Authority-Analysis: v=2.4 cv=cdrSrmDM c=1 sm=1 tr=0 ts=68060022 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ONaZQ3SXXcwgrymDYLYA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: yWaX0-wEHY1fTDrwRO8IpE0Gee0djMTI
X-Proofpoint-GUID: yWaX0-wEHY1fTDrwRO8IpE0Gee0djMTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=615 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210064

On Sat, Apr 19, 2025 at 07:30:02PM -0500, Aaron Kling via B4 Relay wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Changes to a plane's type after it has been registered aren't propagated
> to userspace automatically. This could possibly be achieved by updating
> the property, but since we can already determine which type this should
> be before the registration, passing in the right type from the start is
> a much better solution.
> 
> Suggested-by: Aaron Kling <webgeek1234@gmail.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Cc: stable@vger.kernel.org
> ---
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>

Your tag should come after other tags, without any separation between
those. Also, if you consider this to be a bug, please add the Fixes tag
as described in Documentation/process/submitting-patches.rst .

> ---
>  drivers/gpu/drm/tegra/dc.c  | 12 ++++++++----
>  drivers/gpu/drm/tegra/hub.c |  4 ++--
>  drivers/gpu/drm/tegra/hub.h |  3 ++-
>  3 files changed, 12 insertions(+), 7 deletions(-)
> 

-- 
With best wishes
Dmitry

