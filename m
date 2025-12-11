Return-Path: <stable+bounces-200785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E369CB56DC
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 10:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D78C33009FC5
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 09:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B755D2FD7A4;
	Thu, 11 Dec 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LGMORa3h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dyWCfJCG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5852F7AD6
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765447041; cv=none; b=qX1I1pfhTXZTU0/oODGquel3I9zVJAqTDVu02xioNS8LQfi/v8UVdr9v7FBj9z8EAqOsNy/gxD/yWvF2ebxkk0iGckXYtmmI11xgmanS+AIJZFxk1zxtdPhnS1xWKPeWKfNwS49L/G8IZkJj2GTrlS+4V0QXn8shADrieCxn4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765447041; c=relaxed/simple;
	bh=eaaCpyMI5gJRIY0y8iNjNydTK5JRo+vQyoZhOeho9zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjQObUcnTTVtHN1ZBA9I8qQalM7he+SuC7cWYU+SIQ8iNXWFct4DFxqmSNqfJsptcTnRBSZnGEB0me7CpjiAFAdvoa26MVs7Dk/scwPkzXAb7/s/FISKBf7U55YNkOx7zTYRQG7R5wE1isn0St5COsOfnf8QimCvvcuv1L8sgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LGMORa3h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dyWCfJCG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BB9ZRv2898988
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 09:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2YjurWD8jh8UqL9X0F1WKQTe
	/Sb7eB2QeGBD5SBBMi4=; b=LGMORa3hIe0vRuX9KJi4+Vn1SOBH5IGz4RmQag6W
	h1EX1o3Ga3xKpb+G8FkdG1MbCFtO0bxLygomtve2Nsc4XZk/DydoTYmRtPBP/imw
	qqmarpbO0fOo7DHkT6c9qu8GvsFJuNpAldoE3ozfYkYjaRtXv6Lj0/3828V+3IAU
	NYuetnZjYgc1TeYBX5abJXlKZrkvdpsOIRMdSSS0RZjzc3yJlE/B0ErftH6Lqd0a
	ZTd4B+k5axibE9SmIOEEhXtBeaRs0Yc3ZTm1s7Be+x6YRGwier4GcNKQtXqrVcnI
	tJgP6pY8JMlFkTOBmAW8qYNfGt4lpiuQKTqTiU3GlITuaQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ayrpagn6p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 09:57:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed79dd4a47so15585841cf.3
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 01:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765447038; x=1766051838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2YjurWD8jh8UqL9X0F1WKQTe/Sb7eB2QeGBD5SBBMi4=;
        b=dyWCfJCGqYLYtsGeuJqt7tRGpg4qp24CH2fiWmZ5avk8xolctjyAxG8ifkvBBREdwd
         2Uomb9h4/2B08ESJ4lKka7cnN6TmFig5HDMo3meXtkv3QHK//un9RYi/ScTtwvYTuDY8
         dEoi3C0OdJYalb4BR8wH1w/RHbyPFfdyH1yQ+dZCsTcS+/72FiIEHjSON93w4AiK+Vxl
         XAnP+cD4dCCtIT/SFdi9vasuXRCOpOpb0SvdzHyzXq0+/WmvF2309MZTx1fofVUIRi5m
         +UpxpQnoQow+knhVo0QlhxZex9G/KRdrgHREj/BDS2ca1JerwnkwKhyDtACIROUfklBY
         5sRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765447038; x=1766051838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YjurWD8jh8UqL9X0F1WKQTe/Sb7eB2QeGBD5SBBMi4=;
        b=Y0ecYc1vvTz0BwD66w4k5Vha47WBAdCRTdSTjGq1fGmWxy95sd0oFArdAk3xanhn/z
         Lf2JZSj3W4rT2mZY2RFTV8+dGWD7GvgGVAv1PaPxYt6McfofKo2kmoWNauIGfMV2qPXr
         zqllqn4V3tpPT6xCWqdAlWxUxjm5hlK9tZ7fVu3nSpvpYj/kHDO4z55vxHV7n/buZbrf
         RgNb7driqgoDp06+W088fD+rRvlcKs/52jCvsILsqxwVz6WySXGONchfc+K+TViYLuQm
         jBYf5rdJDBHK86KS5wmPK2fDaLPHfinSoTwg/pEjNaHxSh0UV+8J/8cWR470Q9xKLuO3
         /Kag==
X-Forwarded-Encrypted: i=1; AJvYcCXbWOjABsnKOzjLExDRzzK/NNJeyRtKRIZbmVI8YJLDbr5RLNxQ2va0ogHzG1xLBQJzt9ds5fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1sxUPXKBaCX7GCVmBTxNqatj50CCU+NXOv6gR2EdE2NDosmb
	DUMZlub0mxj2lWNuBpCqm2FMb3qK7BKL5qPfwt3kVDlH5EvcBXwGgEodTJ4X+BWef3xLW4p6N9w
	1gx1GieM0YLhh2M6Lf+gJBprXxY/AzIklYt+bPlsBivBVzsYqt4KqOV672/w=
X-Gm-Gg: AY/fxX677ztCWppI5HreeM11MmPMDKOrV46G7vCXgVQZ8IFzPymrvfmNW1BjjHTpbwk
	PePyY3AvCDtl+bfcbwM1NjSL9ZJatqRomrPnkIHOHBRKUxyS5OogxxfVwLN/CB10OMxF8TtLr3w
	9V27rzt2IX5au7qy4z231gTA6DCgloTTqwmNPO5sMftgMCwzfQJg5cSyPMPTyF6Gkg/ydKGNWV1
	xkz3YYRb6H7WaJd1hJl8RT0fNQZaRVd+yutcTbrvQMjixHcSOj0Rmr/yT3qL5I29MuSn8xiwRda
	GlhImhebJweZHrxLMfAB4BoxO1KxMQbz0JBl7CkhhrmVeAQ+eQUbnyc0v2jaVS/1SSaDxCoqNI3
	zp7+0sEJkMr63xUpkzDHjh0lm9K1DMr43zqooi8jcnSQnGCyRWzJOfjvfLgTzfR9Vlg4VzK84Sm
	jP46brBiS+Ekmjgg9sgmMThSM=
X-Received: by 2002:ac8:5987:0:b0:4ee:43e1:e591 with SMTP id d75a77b69052e-4f1b1b4813fmr74174121cf.58.1765447038318;
        Thu, 11 Dec 2025 01:57:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb5hUtfkJ4sz6QcApdznwiz9dx/Ohc/0AOpeR1lWkGWc4CTx0nRmG0uVUSAUkJYXAcmZnc8g==
X-Received: by 2002:ac8:5987:0:b0:4ee:43e1:e591 with SMTP id d75a77b69052e-4f1b1b4813fmr74173931cf.58.1765447037842;
        Thu, 11 Dec 2025 01:57:17 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f2f379bdsm724574e87.2.2025.12.11.01.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 01:57:16 -0800 (PST)
Date: Thu, 11 Dec 2025 11:57:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, Jessica Zhang <jesszhan0024@gmail.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Add missing NULL pointer check for pingpong
 interface
Message-ID: <72epnkogfsguqyoefmfawqw7gr2molejceqe6rvunpcfrw3s6r@75wvtvd3btjd>
References: <20251211093630.171014-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211093630.171014-1-kniv@yandex-team.ru>
X-Proofpoint-ORIG-GUID: 8z0JfK79fwP8O124snIiORElihDaHMP4
X-Proofpoint-GUID: 8z0JfK79fwP8O124snIiORElihDaHMP4
X-Authority-Analysis: v=2.4 cv=G9sR0tk5 c=1 sm=1 tr=0 ts=693a957f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=6R7veym_AAAA:8 a=EUspDBNiAAAA:8 a=q4VHR2A0D8CO_ZJfzXEA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA3NSBTYWx0ZWRfX6IisLnvEd2N0
 DGwnMCLZ0dQKuYMp+n2UQCMd2aXvQWsUzGA8zkUv2723tIWWEHpC30NGIF1U8gS1IMx3a6o1FZy
 CaK0ywhUwuO6nJIU5acUyfBK9TN4A3j7Z+8SUOeN7UeVfXOBpg0KXyK+JkF9NouG62ZAc8dTyvc
 RcOVP3plac6Tdduh80hieFyw6cvXSVKS3yyEYyFQc70xj9PT75PRQP5XBUJ74dvy2DU1ezrvF0I
 cR5PxjjwwOb+mNq9Qp8AkGdTnB37Cc8eEihaam2nTs4LYpiYxAGG5Y8WXnMP+znVufzPMTaWx6P
 qe1VL0uCqi8tH5r7v0T0ityUt6Bo8hnGfyh/SPJjWHAgw+QFt6u1nbRuORHK25qzTy3Ama9bVDF
 N8Rht+cTC3Mg3Vv5HvX3FAGF8P0CcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110075

On Thu, Dec 11, 2025 at 12:36:30PM +0300, Nikolay Kuratov wrote:
> It is checked almost always in dpu_encoder_phys_wb_setup_ctl(), but in a
> single place the check is missing.
> Also use convenient locals instead of phys_enc->* where available.
> 
> Cc: stable@vger.kernel.org
> Fixes: d7d0e73f7de33 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback")
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

