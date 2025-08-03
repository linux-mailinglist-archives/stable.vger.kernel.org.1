Return-Path: <stable+bounces-165971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1B8B196CE
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD671744E9
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 22:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A5620E023;
	Sun,  3 Aug 2025 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OaRD/oh/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1A1917FB
	for <stable@vger.kernel.org>; Sun,  3 Aug 2025 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754261528; cv=none; b=FGeW9wALh7FQ5yii6LXsFO2XOwX6KikLqNNVNiwPe4mRQE74uRlJf71rJzYb1QbSQVQnniBYsSR3tikBW9aeWRYCSPurkbQSp105wehocIwtmm9qlFyEqcAyYeeA462kAlMqbvv8QasNREzvpA6xoOqpuwSjvIRu0AzHnNitNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754261528; c=relaxed/simple;
	bh=Pf/SzzgZyYr+FETReXK/PkNUpHPDJ7WnmAIh14cbOY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUz1/1xxHACR0pu3vzwSFPYp7vnoXWn7g3ejQVD/wIz6m1g+BDU3eEc1QuZ4CdXMN9yHLZiqOyD4ixIO2W82iSUXslKBnIAK5yMIV6AHmwanhzQEzVm75Mza/KfHltkVdieQIoCpkCu12OybgOKw5J9PXRqGpa9lh/c8A+VgBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OaRD/oh/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573MUIKV032471
	for <stable@vger.kernel.org>; Sun, 3 Aug 2025 22:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JD1bWaVWQaMuZIOSsbiapY7v
	x/fSAhiBJj0221w9hng=; b=OaRD/oh/HldFQT+r76ra5glaculHIRvoqG9PEr6+
	s4Fxh4DHfShNFZZ8biLt4GLnpcCp/rrJmWrDUSqKOdPUl7WnIVwOWWiMv/7UUDvF
	Az44Jar1g335SdvaMV9U4mmlwWT63Gtr35pTugXpE+k/hUcYqgltuzZe5LwG0XlN
	5O+C+vuP7QHDF2Nw9tXjXKBYw1niJr/DdKyCnp7y5uPMcPmkRgk9miIJw7X6LSLU
	17C21VshUDkrhQlgpTG1b+8pDf7DICT74JFD+ihleBHInUnKh355FWG6YwfKWfhG
	YKwhOYNwyuDvm+KNddxKjZWw2nHr08KxmM4VHL4VmEWqJA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489aw72we6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 03 Aug 2025 22:52:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab758aaaf3so107920821cf.2
        for <stable@vger.kernel.org>; Sun, 03 Aug 2025 15:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754261524; x=1754866324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD1bWaVWQaMuZIOSsbiapY7vx/fSAhiBJj0221w9hng=;
        b=EokZOhJawuzsMNDKsyS4fnwtUiAzeJ5PvPV7lx517yPX5/gvpNnHAjQT9eDAEzGXNM
         q8QrLtIw6R0ezZdX6AbNth3HGPWplNysr+jcruj/ZRNrA/RBqkKbUi58ibADd0GriqdU
         J6WG97nC4ZPQSDqycAammIqLxFrhmlbBPoTG00NoYms57CR1SQM2WgezvnBuqzD76/gL
         ee8tTG0BjVM1GESpUZndf3aOuq1Xgi78gBQZyhaLnXSH/pEBbNrCv1Vd66OuT54R/Try
         vr92uQMJXv38N1c1PgnagyHMX0ZNFi1I3Vh23nIYzgzD+tPtRiy3URHMGk3hX8WXBJT1
         9TWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNS5WiZpp3kA0YRtj1rr6qkNC7UJH+hJO/jTGTAUmQizvYKgUb6RVTEV0Mfjh46KFgrhxlua8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4Ls3CFa1TB/gq9Ouw2z8/eH73vmGopeo7k9HeGt7DIAoBynX
	bzmczGEylBQ6BGxFherDVohsVnRwxZuIFTjgG66fPg5+i2WGwOciEUBpJ2PJP5RMjbN9BANs2rb
	iFWhA+106SQV4jNGibEqWlYD5B9fCaK6QuMmg0BndLuDDPa3kWkGIryDRlSA=
X-Gm-Gg: ASbGncuTr1Y6oqHaW/oGsEPINc2ER/HMD6eocLvJMGXOvPMv8m6REAmFwOlvgJYmVos
	J16VtaTTKs79v1c4xFYiG5FwDyGF6FiBG3dBWUY9z9hVorCHy62tfpN1rDjdNjVUdSv6ochkHw0
	drhW3kY86OeKx21CIpTM22gFXV4sCIUD83X5GgqhLXJDbnYPFWuQ+4Zzpp86aYlBboRGOod/EfR
	MxxoWi+WOwj9v5+xXY6J3w3ZdueetFjqPhy3m14JAyVhkVKxrTdBV0B54l9TsYgvaTpT3ZMynVq
	IOFg3UrwRnLVje/nxfGP02rYds9T6dFbC1Wd8FrqMyii6sAPqpfpTzHrmA7FKay4BzYyUeyQHA4
	fK9EEfUWK3F/KiSFL8kAh84S2EG0+BygYwVXQnW0qj3YpL27pAAdR
X-Received: by 2002:a05:622a:c9:b0:4ab:63b9:9bf4 with SMTP id d75a77b69052e-4af1097b2d6mr121492631cf.1.1754261523767;
        Sun, 03 Aug 2025 15:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvmz8aawgD/oGBs9k7aFMPr9BApt+fDHkdh79/grIR1SnsbvPVJ9lZL1LZ6ktrMtx82kna6Q==
X-Received: by 2002:a05:622a:c9:b0:4ab:63b9:9bf4 with SMTP id d75a77b69052e-4af1097b2d6mr121492451cf.1.1754261523353;
        Sun, 03 Aug 2025 15:52:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca3fb1sm1420184e87.136.2025.08.03.15.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 15:52:02 -0700 (PDT)
Date: Mon, 4 Aug 2025 01:51:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND] drm: Fix potential null pointer dereference
 issues in drm_managed.c
Message-ID: <mw57szw4mnmpwxj55mvqu4pvjknuh2gmqfy6gko6wicsv2emah@4is7dv2bzx6p>
References: <20250703092819.2535786-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703092819.2535786-1-haoxiang_li2024@163.com>
X-Proofpoint-GUID: FAM1DY1JgfVK2Qv0hKMv4eQfyFEGwSCN
X-Proofpoint-ORIG-GUID: FAM1DY1JgfVK2Qv0hKMv4eQfyFEGwSCN
X-Authority-Analysis: v=2.4 cv=MrZS63ae c=1 sm=1 tr=0 ts=688fe815 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=-n9UYpkImSeQm4xEVYIA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDE1NSBTYWx0ZWRfX7OWmWkvZkz8U
 cQ/yER1UMaq8a2KBkyJcjkYMKvHTanvCunjWMMxsh113ZxYIPsp0eaJEZfftO61PIIOIP8UN/4R
 k273n4mz98mxcxsLu0vTl8Ky2xni0nihArAeyXoJzUAVRjlVaCEchQyA5B3oZL9i5jlt2/c4AUB
 hbFLFbpWkTRIDNL6mUxijO+dN7ShaPo/LAJqYPb8fPQBPWLadcoKZk+QYeZ3vKPfZZnERZERQu6
 0aNQPqsAkMCA6sDlgePrbWXyApbFwcaaHzJV+JqUvIU87SSYB75Stnff7P84aBQqJ40JB9SFjyc
 v4R27K6w9qXJShvf3cqhJaSqWkYnv0VWegf2KkQ3o+VLT5tsXzNTS1GQJsDqUxphlFSXJoqT495
 vho/bLSPiVoKp5K/l076NfFKtHEIj08OxLH1GCUOHFmvJKNzEQaYxdLPxwyMuFcO47XqYlDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=836 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508030155

On Thu, Jul 03, 2025 at 05:28:19PM +0800, Haoxiang Li wrote:
> Add check for the return value of kstrdup_const() in drm_managed.c
> to prevent potential null pointer dereference.
> 
> Fixes: c6603c740e0e ("drm: add managed resources tied to drm_device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/gpu/drm/drm_managed.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_managed.c b/drivers/gpu/drm/drm_managed.c
> index cc4c463daae7..368763d4c24e 100644
> --- a/drivers/gpu/drm/drm_managed.c
> +++ b/drivers/gpu/drm/drm_managed.c
> @@ -151,6 +151,11 @@ int __drmm_add_action(struct drm_device *dev,
>  	}
>  
>  	dr->node.name = kstrdup_const(name, GFP_KERNEL);
> +	if (!dr->node.name) {
> +		kfree(dr);
> +		return -ENOMEM;
> +	}
> +
>  	if (data) {
>  		void_ptr = (void **)&dr->data;
>  		*void_ptr = data;
> @@ -236,6 +241,10 @@ void *drmm_kmalloc(struct drm_device *dev, size_t size, gfp_t gfp)
>  		return NULL;
>  	}
>  	dr->node.name = kstrdup_const("kmalloc", gfp);
> +	if (dr->node.name) {

This should be `if (!dr->node.name)`.
I think with this fixed the patch is legit and  should be picked up.

> +		kfree(dr);
> +		return NULL;
> +	}
>  
>  	add_dr(dev, dr);
>  
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

