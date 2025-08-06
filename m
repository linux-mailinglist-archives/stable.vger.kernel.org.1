Return-Path: <stable+bounces-166697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88679B1C5EA
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 14:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3638118C0B17
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623EF221F1A;
	Wed,  6 Aug 2025 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4oOWZir"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEAB1C6FE8
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483638; cv=none; b=mdTerD1hNIJYn4PxmIrYbKpqcS3Xbc+nKg6vqXI9SJalArJu0+1pT46m8A8Hc02ykX1XUq3o9lMI8gpteG1e5jRRuP+pcBRZnoJ8o8BwXoW+QwTdFUPJ0RTM+WNxib7m0PKc2ITkWWB6fb6Hm9KsRUWMghX0aWKyCzfvleRtjYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483638; c=relaxed/simple;
	bh=Sq+oD4hXBWAC8kZi9bfMIEHzmiISXYw4ZK+MjAjmhf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujnrApgIT2ErvC71HwXwqbv7itqLNlBYXf6+l9tZxR1Jgrw1bZXMwyIv04ouXxS2DNz1a3In/jpt1hWSB2Pj9X76S0wmrsAs7wFcSNtCyuoBzQJle9rlqGD4qlnrlZpunwLHYuR9OkDnHIHFTXWDHS4f+1N4nhhMntsgAFAnv2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4oOWZir; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766Pr5q022390
	for <stable@vger.kernel.org>; Wed, 6 Aug 2025 12:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8AHDD/NKlImoDbRQJz3VE6UP
	Fkw5sFqhveZWLWVU0jA=; b=g4oOWZir2+MXN+X30a5yhx6F2djWrkZxWQjdgTe+
	XPH93D1xKUiwkkMYYVEk0BQPf7Ciy+lEShcQWJk1DvBUgjT1+FvqJFO/v0IZFllx
	Hm1wVH72eEczY3hg+ZVS/FU9RHZcnfZv5/bgJMYqjk+0OKTI4vJqWLSa1nr0Fnx6
	KGlDvHpDdk0SSApByMt+IqW8M6+XEMStIcm2aVhOfdoIPwGgA6yCzMP21v1lnG1p
	prC75v7RiFn3dtKc8WhhiQ6aYlPLcFmk2aa6KSAXDNpsMck46INQffM0mA2mvlKL
	DTEx+WHAaBg6uLZolHx9XEGKlsm2S7ioUTdDoDuC+dSU/w==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy8am55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 06 Aug 2025 12:33:55 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4fe1f50e44cso1549140137.2
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 05:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754483634; x=1755088434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AHDD/NKlImoDbRQJz3VE6UPFkw5sFqhveZWLWVU0jA=;
        b=EJHMMeUbkJkwM4spaN9dptgo37pTD2RUnBQCd1M+S8rP3ceI0ZQFDRjnFPSXSixpAk
         Kk2qabWBoe+2Nc3gpf2SXCZzFGIVPf0QpTOooPPNq3+zwvI7ZYopv3W0nIAl+0Ai1Nwh
         FyqGf758ww3lg5hMYdz6YPiYx68Psu5ifzCAYfH409tKv6GA52M8CVLLdK1spgEyYmsP
         k5u8cVA4F10Ie+DxZlzx/QtiUg8EeZkpq1fD8eZxjmTpFdMwJ+mxmFo5Za/l0TaslYLk
         oh7mmPrPirGMA900L72P0kZ6XAs0ApkNG5TvvIJLjaq7gWfufyuX9tBJLuSvcqKDrwHx
         3YgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9RVizR5vHA9TBpCAqz+8ELjaMTZmRd8ncm5mkT5osuyTqhnm1b2kd3mEYOHYzwSSjb4NzPgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5NItbCgqQ4IKh7KwCBIRpVU8BR7ZmbYam6BmvZ1nhU7yrf1qW
	F4bGPUBf4BeTfp5SmCMWlTK6hwSXIJbgHiXw8ZnijWtG1EVClTw/eY2QS6Xrg2tv7P824ZhtZCw
	9PnQLt+cXu+ATTFVKhO4P3siv3rp2LfJOUphiSyy9e0s9n/OB8rFMA5uwzwY=
X-Gm-Gg: ASbGncsok0hskjklGO+zVtZJOKEv/gk3HtpixgZkDL23EOGjD2igpt6qRi+i2zelIPo
	b9ar2zqfLpm8v+umC8xWMSWkfBYsalfWElyJtt8z2SJIOAChrnrX8OJU+ehL5+03ua9QLJKuGXO
	HH59c5DXpSVfBHB3W335WwaF6/Bz/NOL7D6B3hbl249N2c0fzAAF+h+RkY0UV3ZvCm5EuwjUVmA
	gEhVMmJwAXnl0vIX9xTDsFkx0IVFAtRoTD9qZNBDZUPLooeto1fjdtkB8cszo/j5xnqJuqWKxmX
	Soe/o9SiL5J6uRfBG9x0TPx4JoiN5WMIDX6fx12Ecg38iLoEqhBfomljgwxGIRttN/dRfWdRiId
	tFmMN+st8zhVJlNGLDg/F8AC0HGejUKELUwhoyFo93a68en6rx18w
X-Received: by 2002:a05:6102:510e:b0:4e2:ecd8:a27 with SMTP id ada2fe7eead31-503722a411emr930582137.4.1754483634268;
        Wed, 06 Aug 2025 05:33:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNJX4tx8SpHG3lADuY3nNb7/BMPnvxP9KNmFPf+zkE8bPI7eisHRRpHKlq6+Dmvm+dlyGPlw==
X-Received: by 2002:a05:6102:510e:b0:4e2:ecd8:a27 with SMTP id ada2fe7eead31-503722a411emr930555137.4.1754483633745;
        Wed, 06 Aug 2025 05:33:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bde5sm2331438e87.3.2025.08.06.05.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:33:52 -0700 (PDT)
Date: Wed, 6 Aug 2025 15:33:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "nicusor.huhulea@siemens.com" <nicusor.huhulea@siemens.com>
Cc: "imre.deak@intel.com" <imre.deak@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
        "jouni.hogander@intel.com" <jouni.hogander@intel.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "laurentiu.palcu@oss.nxp.com" <laurentiu.palcu@oss.nxp.com>,
        "cedric.hombourger@siemens.com" <cedric.hombourger@siemens.com>,
        "shrikant.bobade@siemens.com" <shrikant.bobade@siemens.com>
Subject: Re: [PATCH] drm/probe-helper: fix output polling not resuming after
 HPD IRQ storm
Message-ID: <n5qe3zmeekirddlt7hff2tgdyhe5bysaubwpndtmsqmkgyc4lq@2agvowbjuvuo>
References: <20250804201359.112764-1-nicusor.huhulea@siemens.com>
 <z4jxkrseavbeblgji4cnbyeohkjv4ar3mbbdvothao6abfu6nf@nqlhcegwtwzf>
 <aJIhCyP2mwaaiS22@ideak-desk>
 <DB3PR10MB69081B925B54BB906DAD0D20E62DA@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR10MB69081B925B54BB906DAD0D20E62DA@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
X-Proofpoint-GUID: 8A8DgJsIsGvvPbSuJITK6C1GBqSrawoL
X-Proofpoint-ORIG-GUID: 8A8DgJsIsGvvPbSuJITK6C1GBqSrawoL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXyBGyBazHQR2R
 7db2/8fMJa7S1xVMLBncNPcAcB/zx0wPb2A3InsieQ5MbItv7WqU9DHrnAuh5LUl7f4IDrn9Rvu
 LXvCdHyo6/hjdNIuz5IiCk08MSPnYLAehG8fsOU145T3F0kM7uqWO9sLT+DOHaANm19eiABFvh+
 HXurVig++YGAFfs81LF3heahk/mKOya1ezE/RzMNgjyGRe9cWMpkDP/K2ohh+OxVNMWtXIvQqe3
 GWGUTMHaBu5LFar5plTmArHci5Iush6zRjQOQC8yvA2fQhfz6UjMr16QOOtQ1AIi5GABNigXZmV
 u8wKGrXkP8P66FT3BjmCX4dug4Zj5WMVvHjdJXQwJIdV+j87bKmTluJ4llxTg2VCRrcCMJmdjyS
 RtyQW+F0
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=68934bb3 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=a_U1oVfrAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=0Kn4FdKhAAAA:8 a=yMhMjlubAAAA:8
 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=8AirrxEcAAAA:8 a=oW7bPyNFJPXsfEDiif8A:9
 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=iYA3lCpbqa-fO8tTHbho:22 a=cvBusfyB2V15izCimMoJ:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On Wed, Aug 06, 2025 at 12:02:02PM +0000, nicusor.huhulea@siemens.com wrote:
> 
> 
> >>-----Original Message-----
> >>From: Imre Deak <imre.deak@intel.com>
> >>Sent: Tuesday, August 5, 2025 6:20 PM
> >>To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >>Cc: Huhulea, Nicusor Liviu (FT FDS CES LX PBU 1)
> >><nicusor.huhulea@siemens.com>; stable@vger.kernel.org; dri-
> >>devel@lists.freedesktop.org; intel-gfx@lists.freedesktop.org; cip-dev@lists.cip-
> >>project.org; shradhagupta@linux.microsoft.com; jouni.hogander@intel.com;
> >>neil.armstrong@linaro.org; jani.nikula@linux.intel.com;
> >>maarten.lankhorst@linux.intel.com; mripard@kernel.org; tzimmermann@suse.de;
> >>airlied@gmail.com; daniel@ffwll.ch; joonas.lahtinen@linux.intel.com;
> >>rodrigo.vivi@intel.com; laurentiu.palcu@oss.nxp.com; Hombourger, Cedric (FT
> >>FDS CES LX) <cedric.hombourger@siemens.com>; Bobade, Shrikant Krishnarao
> >>(FT FDS CES LX PBU 1) <shrikant.bobade@siemens.com>
> >>Subject: Re: [PATCH] drm/probe-helper: fix output polling not resuming after HPD
> >>IRQ storm
> >>
> >>On Tue, Aug 05, 2025 at 01:46:51PM +0300, Dmitry Baryshkov wrote:
> >>> On Mon, Aug 04, 2025 at 11:13:59PM +0300, Nicusor Huhulea wrote:
> >>> > A regression in output polling was introduced by commit
> >>> > 4ad8d57d902fbc7c82507cfc1b031f3a07c3de6e
> >>> > ("drm: Check output polling initialized before disabling") in the 6.1.y stable
> >>tree.
> >>> > As a result, when the i915 driver detects an HPD IRQ storm and
> >>> > attempts to switch from IRQ-based hotplug detection to polling, output polling
> >>fails to resume.
> >>> >
> >>> > The root cause is the use of dev->mode_config.poll_running. Once
> >>> > poll_running is set (during the first connector detection) the calls
> >>> > to drm_kms_helper_poll_enable(), such as
> >>> > intel_hpd_irq_storm_switch_to_polling() fails to schedule output_poll_work as
> >>expected.
> >>> > Therefore, after an IRQ storm disables HPD IRQs, polling does not start,
> >>breaking hotplug detection.
> >>>
> >>> Why doesn't disable path use drm_kms_helper_poll_disable() ?
> >>
> >>In general i915 doesn't disable polling as a whole after an IRQ storm and a 2
> >>minute delay (or runtime resuming), since on some other connectors the polling
> >>may be still required.
> >>
> >>Also, in the 6.1.y stable tree drm_kms_helper_poll_disable() is:
> >>
> >>        if (drm_WARN_ON(dev, !dev->mode_config.poll_enabled))
> >>                return;
> >>
> >>        cancel_delayed_work_sync(&dev->mode_config.output_poll_work);
> >>
> >>so calling that wouldn't really fix the problem, which is clearly just an incorrect
> >>backport of the upstream commit 5abffb66d12bcac8 ("drm:
> >>Check output polling initialized before disabling") to the v6.1.y stable tree by
> >>commit 4ad8d57d902f ("drm: Check output polling initialized before disabling") in
> >>v6.1.y.
> >>
> >>The upstream commit did not add the check for
> >>dev->mode_config.poll_running in drm_kms_helper_poll_enable(), the
> >>condition was only part of the diff context in the commit. Hence adding the
> >>condition in the 4ad8d57d902f backport commit was incorrect.
> >>
> >>> > The fix is to remove the dev->mode_config.poll_running in the check
> >>> > condition, ensuring polling is always scheduled as requested.
> I'm not a full-time kernel developer, but I spent some time trying to really understand both the rationale and the effects of commit "Check output polling initialized before disabling."
> Here's how I see the issue:
> That commit was introduced mainly as a defensive measure, to protect
> drivers such as hyperv-drm that do not initialize connector polling.
> In those drivers, calling drm_kms_helper_poll_disable() without proper
> polling setup could trigger warnings or even stack traces, since there
> are no outputs to poll and the polling helpers don't apply.  From what
> I understand, the poll_running variable was added to prevent cases
> where polling was accidentally disabled for drivers that were never
> set up for it. However, this fix ended up creating a new class of
> breakage, which I have observed and describe here.


It was added to implement the very simple logic: If something isn't
initialized, enabling or disabling it is an error. If something isn't
enabled, disabling it is an error. If something isn't disabled, enabling
it is an error.

> 
> To me, the core logic should be simple: if polling is needed, then we should allow it to proceed (regardless of whether it's been scheduled previously).
> 
> Looking at the  drm_kms_helper_poll_disable()
> if (drm_WARN_ON(dev, !dev->mode_config.poll_enabled))
>     return;
> 
> If the driver never enabled polling (that is, drm_kms_helper_poll_enable() was never called), then the disable operation is effectively a no-op-totally safe for drivers like hyperv-drm.
> 
> And in the enable function drm_kms_helper_poll_enable(..):
>         if (drm_WARN_ON_ONCE(dev, !dev->mode_config.poll_enabled) ||
> -           !drm_kms_helper_poll || dev->mode_config.poll_running)
> +           !drm_kms_helper_poll)
>                 return;

Why?

> The main thing being guarded here is whether polling has actually been initialized:
> 1.For polling drivers like i915, removing poll_running from the enable path is both safe and necessary: it fixes the regression with HPD polling after IRQ storms

I believe in paired calls. If you want to use
drm_kms_helper_poll_enable(), it should be previously
drm_kms_helper_poll_disable()d. If you have manually disabled the IRQ,
it should also be manually enabled.

Pairing the calls makes life much much easier.

> 2.For non-polling drivers like hyperv-drm, the existing checks on poll_enabled in both enable and disable functions are sufficient. Removing poll_running doesn't affect these drivers-they don't go through the polling code paths, so no polling gets scheduled or canceled by mistake
> 
> Therefore based on my understanding and testing removing poll_running guard not only fixes a real bug but also does not introduce new regressions for drivers that don't use output polling.

-- 
With best wishes
Dmitry

