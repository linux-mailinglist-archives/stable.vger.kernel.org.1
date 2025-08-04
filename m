Return-Path: <stable+bounces-166436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B7AB19AEC
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 06:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7250174295
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 04:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1432F1FECB1;
	Mon,  4 Aug 2025 04:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bo7617qy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D510E4
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754283567; cv=none; b=UDQRfQixiK8ce7ccYMpGHNTinWHHbZjGQMlG9xhitvwLIg84VLvB1c9VPEEufSphgWA5wP9u/S6ZVq6Qn3JD8khdIQViNjnyJFA6EfPWKLS2AAi+4Ei9YCOYMfR/W9xospM3iOXu5QosDycbjaD+7HcMICsfLbdjkvljeW3dcYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754283567; c=relaxed/simple;
	bh=5OCS7EVJ035go6kQQg0qlr0yXYaMviIjU0BO7hW86uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXmsmI/DJyvpdW4xg4+38ggVgCatwog0kdxdqs/veE4iaDm3HZ0VKdBw2UUHRukQRb+CocE3Yg6gO6fYHzd8LXQmZlBM7gbinmLq565F55iF4nGUnjPBHUJ2ZMRsV4edJeEyAmzWlJNIU0CHjLhjKQi1AHHTRvsIVws60h32yl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bo7617qy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5740BvTL005156
	for <stable@vger.kernel.org>; Mon, 4 Aug 2025 04:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yeGhNT6CpWXNeXfNa1CkflGC
	25gJ2duSKHQEY7KN6SY=; b=bo7617qyml3M3oHt4aEetrcNFwAT1BVfLs/RKZov
	3jnztyUX6lOxcGf5IgAjuWpv9s67PZsnGbCv0JvrvaEoL32n1zVbXReY0HlVuba5
	NNHNnB9QWEIVkcwm4ek4gNaVsB38+MnJlDPVMWz1Y/uigbzBjM9ok1wo7FxAW7WP
	x2MBUoeKyKkh7E+RGPuakgL5ex6KvfIDCR+oK+LcVn+WnqtobRqi7VLZGZGcysVA
	OZpEeBPneqWs+BSy62jZV9AAb4yfkzE1oPL+9Gy2RHMaAVV65fPXA9ee7lkO2IRr
	dUuEZ6BsLI5VvQDQ6EDLcaYsfb+r2LnWKD+7nzhUi9VgNA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4898cjkr6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 04 Aug 2025 04:59:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab758aaaf3so114984441cf.2
        for <stable@vger.kernel.org>; Sun, 03 Aug 2025 21:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754283564; x=1754888364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeGhNT6CpWXNeXfNa1CkflGC25gJ2duSKHQEY7KN6SY=;
        b=pSGzW5GynbcHcYNvcTxLDkftR4yMwz2mrwVKw+DDwZRlIx3pA4s+L9C6vsW3bhFlCC
         CkMADHmc6jbwPNbfXepfA2UOm2rJPYl+6O3eNeNTxGxVFEWWQTSDSva1gu76YT7Rrg57
         tzBSvUIMQ/nRu5G9ArHyygzzZZPfX1WJB6Eo31YNWvwp1PrbgRIKn7MhvHN11iKZjecY
         Ib7UFLu5MLmjt2GKDVCpY886x6dgzV/gpFPvV/DuJXbTWPM4E3YIk2zmLyDlpM9OavTZ
         kilM2pC5yUkaGMAZ/za4GdCYoDBOBxA9ZIhriB37yAxOJBByU3qobETFcMM+bMeEI8RO
         62vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUjE+rddPD5fIZR4ki6+Tcv1M0v2HHtJggB7uwYgIHy9k0iXwk0VZRJ06B8tqmxe4qg1a+DWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZdbBTk6qtTu1/BpnyLFjVvsbKffFTT5l19K7aQdUgsqEFzgMn
	zG3qkSLSFoB3dyaSANH3glPH5TTV/dNVfPNZJAkhqUmrwhfmTgdjyzNfaqdbAVNMjXrijvdwVlF
	b3l86YjE1LFRg9sEXLUbE3xMiXTsp+uz4fLU4UAeHCVKlEXy685XXOWyMMTY=
X-Gm-Gg: ASbGncu9oFyAmyJUS9vXKuOGorH6mppPYar5vMvvX7opmbZm7KNiPJFVWO3cSkdaS8S
	mQkeCSQcCPeU5VWsOWAgMnTy8LjDCXfKa8TlIgdRcq14nd25J7N72+Z9xQTSjboMHI91+mkPqs+
	NcIzHPyQVlAlsH0yT/Io6KSq3bZ9JE0JAsdSU2/s4VyaV6icwM3LmKVbEq27tjZ6McDoC3b9d1G
	t07KgHyYg1HxhwYSz22Ad0ORvaeYWTvQAAxIn8fKlwo2f62lAYrKUb9yxeHuxrU8r+/fFN7tnw6
	NXFgyaNHOEmlF+UetKhif7jw0/6uRm/gq95E1dTm3ubS0NZTEKsIkOWSleJy0hEh0pZz8cdQ1EJ
	zulTZUTsu65+wtQJVXpb8RYivS3uBq0/LInNNMgjy8eX099xlv4Ki
X-Received: by 2002:a05:622a:450:b0:4a9:cd88:2ce5 with SMTP id d75a77b69052e-4af10d09751mr121949671cf.43.1754283564348;
        Sun, 03 Aug 2025 21:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmwHf8jvLAtm/gyRWNMuLZ9kuudQb+4jLxAHzs9hy9eB9XwniHX4P/UvGkhGHloFivD0TmCA==
X-Received: by 2002:a05:622a:450:b0:4a9:cd88:2ce5 with SMTP id d75a77b69052e-4af10d09751mr121949571cf.43.1754283563888;
        Sun, 03 Aug 2025 21:59:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898beb4sm1514807e87.30.2025.08.03.21.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 21:59:23 -0700 (PDT)
Date: Mon, 4 Aug 2025 07:59:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] drm: Fix potential null pointer dereference issues in
 drm_managed.c
Message-ID: <lkpoiqz6crzief6exijz4khb5liptodcoo75hkvc6dqzacn2i3@uz2rekanykf4>
References: <20250804022021.78571-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804022021.78571-1-haoxiang_li2024@163.com>
X-Authority-Analysis: v=2.4 cv=MNBgmNZl c=1 sm=1 tr=0 ts=68903e2d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8
 a=bfg20SR7mBSTREqmtXgA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: jWAWDOqMDPzj0Zk9f7nGzYCeVJKe0uJd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAyMyBTYWx0ZWRfX9026+12AWV+t
 BL8iUPcLna/fXSPF/uzcn/HeT7K6ODYtV91vmNHq6nNtt0869wVbHLhfSC5HGCYoZZIQMUKpoXm
 WkH4gUrlwvPJBCrSYx0zTvc7oRItxiV8dH+cjkkUO7ZMAorgFBANCLd/s9VFfhgpRsPYArngK5Z
 cCvJ9cpwJ3WZyClx/QFcrFpyGI03VFbQZwwgQZEH8uOXgUdOP6UAhY5eyI/srBOT3Qt5rf9cND4
 nWbUk+1pxDxFAIbVapYbEdX7vyqJwt/tGvmlK3u6mONsQAOuiT/eT23lVnHv+sC6LpVSjBqBc1i
 4nXMpb1TeXYKHK+pSbAXlV5p4ComVR4dBxLCoOHh7W2BOYU5nj/HAWAZuFdyqcK2/OBc+T8tVhN
 shaGw8tbr2rnxz+JWONkVQq2hoZtac5DlNmVwDPziJI3wi1Kzh6TlmmXEJEnYJXwZ47HVDwh
X-Proofpoint-GUID: jWAWDOqMDPzj0Zk9f7nGzYCeVJKe0uJd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=735 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040023

On Mon, Aug 04, 2025 at 10:20:21AM +0800, Haoxiang Li wrote:
> Add check for the return value of kstrdup_const() in drm_managed.c
> to prevent potential null pointer dereference.
> 
> Fixes: c6603c740e0e ("drm: add managed resources tied to drm_device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - Modify a fix error. Thanks, Dmitry!
> ---
>  drivers/gpu/drm/drm_managed.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

