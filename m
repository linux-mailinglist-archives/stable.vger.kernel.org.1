Return-Path: <stable+bounces-166548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B152DB1B235
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 12:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EE01805E1
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922021D31B9;
	Tue,  5 Aug 2025 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UkUY+mZ/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F7202963
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390819; cv=none; b=Gw/3z8EkZsBv1osNS3qr5cRYqwX+IjXz3BuvqhGF9/Z2pmWh9PouZKFm/eHgVslQATqhjbNbBe4LzGegysIeA1gpo19QKjJpf+EE+xYi+Ax7RHOsWIxUr6jhPVSOIfKQQ5KMspURvUXIJo/SYcvX9plqAoUMPVaw3EYByNS/sGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390819; c=relaxed/simple;
	bh=ih53cvpWLeeZmEFmSxic219SrBPO0TFUmikG1HVV4Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkPMdNg+LkzVVVyvQ4BZh9m3/A0z2Stenw9kTu9j/4O78SDLVsKo6ufT0nkzauuuTGfXewwPlCXejGIp30E7Nm5xSPYojQXYgDQxWZ+HMRTOXOqtHuLzzf5e7mqvmYxWtZ9mDGVfdu2AZufiH+8izFenzMhCXHG0wPG6JysWEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UkUY+mZ/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57578Mrn027684
	for <stable@vger.kernel.org>; Tue, 5 Aug 2025 10:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6MqyqJWNT+su2i0PV9Dq1jib
	VxeVp+m7xarMv4uNdaM=; b=UkUY+mZ/do5d/LOeZT1b2eMvT8zMlRbivn4pPtf2
	xKW49RajL0IVJr+uYEbm8YKJoiMB1JNYFQ4EeZ3r0dBt2eMq3r9r8fuj3eS+k8gK
	lizM3E10wX6NbggpEcTK5P696eHp4MmAirEPZH5ct9DdE9+8IjMaVSXePnxE7gVl
	572oFeV76r/uZKS65Lm4VMi5Xbv+oy1IkvjPDncpOKomjrhrSwXzxjGvgkAWHTJY
	gCp2U9U+5DKa3O5JjnCzGlQrcQi28ceZsHdQSIpb/rjmiwi/xIjvi7GDbzXoyKbg
	ubrNu6m6jN0O9efbc52gMHgAMpddcDDVA9oINLDznIU2Uw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bd9w8me2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 05 Aug 2025 10:46:56 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-707648b885aso74391056d6.1
        for <stable@vger.kernel.org>; Tue, 05 Aug 2025 03:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754390815; x=1754995615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MqyqJWNT+su2i0PV9Dq1jibVxeVp+m7xarMv4uNdaM=;
        b=RHlTYBzgwaM76R3ezF9D6eAIZ3tBThi3PaQRvgb3zn9LR5OZ41Usni+5ICwCZITdbd
         yzHeHPPLKR4SLNGvQzMqMDtF/KTRfA06DLdj9yUAwMsAnOcNagvzSj3DQQ6Dd5PSR/fX
         KYik+Pmi6uq2MXqmUoF0y6gex1MWm0DywdhmWYcE7sC/R2jYRX8yRVz0wUIaAk86vzci
         baSiiC54gJt5ePDw613OKxdmN/4PFsRMCKzRizHiVWINUKm2lpGG9ob5rrYzKBEwjmYu
         7fU6HnRtsAUpOy9LPG6xm3vQj7A1AbX/BLB1X8mxAZSZxqaBwBuE/8Nwd8dq7iK59M3r
         ZTxg==
X-Gm-Message-State: AOJu0YzmI8Qw2B0RyHbdx7yMC6MIS7a+O5B0M+2bMKqK9E6i4R3mUobZ
	vO5ji2T/pvXDEGHHlZ4d+v11D4hvw5Af/Q+bTfoqsgWeqGwkryMfHLncQd/0a50J4l26Wb6JFOS
	14eq2o40FJLQzVmeQSB+Q2h3kdM5ppLWq51JVA5GtruGqU+ms0dVuV0kETJs=
X-Gm-Gg: ASbGncvYhBNUtLKaJq2AlaxiIJJb70+5PvSBG3e5fOg6ey4bax4RyhbfHN8m64q8uqJ
	wzubsC5+S+uGwEqaUPDIEN2ZlhaLgbkGphWIQV2Qh6UXx2D5SUoB4GWgaI33RsfZ5k30oXxUgEn
	9f8DJ4QL3S04dsGcm4ssnBWiErkv8tW0hJeky9A4p3mbA8d55ucA1+poydBPApu9frJlc8foL7G
	+TbYvCjnPg+RzUR6h/FLGUXcWKp9M+nvrl2/FyTifCyxaia6VLZlYWfXtBmIHEDxs7NqYdsdBnM
	HBlCZM4dkMF+pjQ4bllnHauuqAJYwxQHTLG1++qD/y5byqO1cQTxlHHfTlqthAQBFKssG+zxLAf
	Ai8AmLzdrlOK76Z5RtLUGa/7CWG6YokZvBF3LGgL8gJZJuyOaoEgS
X-Received: by 2002:a05:6214:762:b0:704:7b9a:8515 with SMTP id 6a1803df08f44-70936313db4mr165964706d6.38.1754390814919;
        Tue, 05 Aug 2025 03:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmShMkZ4kKSVeaIHraWH/PlAWlX7H2EEZv0YV6qAruKBuxlJC4H8uILodqhzr6oCtQ73Ww0w==
X-Received: by 2002:a05:6214:762:b0:704:7b9a:8515 with SMTP id 6a1803df08f44-70936313db4mr165964346d6.38.1754390814481;
        Tue, 05 Aug 2025 03:46:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ac71esm1875211e87.66.2025.08.05.03.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:46:53 -0700 (PDT)
Date: Tue, 5 Aug 2025 13:46:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nicusor Huhulea <nicusor.huhulea@siemens.com>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, cip-dev@lists.cip-project.org,
        shradhagupta@linux.microsoft.com, imre.deak@intel.com,
        jouni.hogander@intel.com, neil.armstrong@linaro.org,
        jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, laurentiu.palcu@oss.nxp.com,
        cedric.hombourger@siemens.com, shrikant.bobade@siemens.com
Subject: Re: [PATCH] drm/probe-helper: fix output polling not resuming after
 HPD IRQ storm
Message-ID: <z4jxkrseavbeblgji4cnbyeohkjv4ar3mbbdvothao6abfu6nf@nqlhcegwtwzf>
References: <20250804201359.112764-1-nicusor.huhulea@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804201359.112764-1-nicusor.huhulea@siemens.com>
X-Authority-Analysis: v=2.4 cv=NN7V+16g c=1 sm=1 tr=0 ts=6891e120 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Lu6GMi6qvROXTdHYmRoA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: -cVwGsZtWfPC6XYz07sv2kJh_7ZsYyBE
X-Proofpoint-ORIG-GUID: -cVwGsZtWfPC6XYz07sv2kJh_7ZsYyBE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA3OCBTYWx0ZWRfX0OjbrtYEHJFf
 6eb2+okyGRBFhGf2jOccObaHgzo7flY0DNekcuVurII1Clbbj5iIEZLssBv/F8BrPZJ+04hwLxy
 /YgigIGOvdJMCOE5qt4mojiTjzxhKHXLzvLEC54Qmzd1Nz5V+YXWuQWmw0rZQWXkH46QUVmbHQH
 Ut6GhqSvUqlQjI4l0hiVeW3Hs32xBCeUkA59sNabvs43xYXbyi08io6rMf/NZyNp1eV1WbDgJIF
 IlRHMb2Lewt0MsqshIs8qrY2EPODdayik0qLAWlFprzycQ+WzCIDNcF5whXnNUg5m6fenKYyl5Z
 GfiXxDI4VrX8mh/GkxViAw8lUfLKXILq+9Lo5g4R5qERa3M+6Riehdv7iGqlNhQ/79V3sj2kpxc
 P3EzczeuomnIhYFsT+dqYxPIA41nZIqVy9/yZ9ZVMg1fXHq0lpnPn0pW3nXn4vuL/SXZmjdc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050078

On Mon, Aug 04, 2025 at 11:13:59PM +0300, Nicusor Huhulea wrote:
> A regression in output polling was introduced by commit 4ad8d57d902fbc7c82507cfc1b031f3a07c3de6e
> ("drm: Check output polling initialized before disabling") in the 6.1.y stable tree.
> As a result, when the i915 driver detects an HPD IRQ storm and attempts to switch
> from IRQ-based hotplug detection to polling, output polling fails to resume.
> 
> The root cause is the use of dev->mode_config.poll_running. Once poll_running is set
> (during the first connector detection) the calls to drm_kms_helper_poll_enable(), such as
> intel_hpd_irq_storm_switch_to_polling() fails to schedule output_poll_work as expected.
> Therefore, after an IRQ storm disables HPD IRQs, polling does not start, breaking hotplug detection.

Why doesn't disable path use drm_kms_helper_poll_disable() ?

> 
> The fix is to remove the dev->mode_config.poll_running in the check condition, ensuring polling
> is always scheduled as requested.
> 
> Notes:
>  Initial analysis, assumptions, device testing details, the correct fix and detailed rationale
>  were discussed here https://lore.kernel.org/stable/aI32HUzrT95nS_H9@ideak-desk/
> 

-- 
With best wishes
Dmitry

