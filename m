Return-Path: <stable+bounces-196569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B03E1C7BE83
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 23:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CBBFC36189D
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 22:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BCD30CDA1;
	Fri, 21 Nov 2025 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jzJZS4fX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TXbhOGke"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE7306B02
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763765573; cv=none; b=hirDi/qX5vxpGiiATAEWuIJsvnT4ekSELCtTrFaG8+K6x5P5gBHw9o/DFP4jVTF03h6aAmmyrll/36U71vLwJ45hFs7ZmyhjO7k4UoiA+LNE6m8PmjerAzIXaqeYfEGD4VOx1hWqy6hJS2Amseocg1nP2qbUBpNQyx+maEgo5pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763765573; c=relaxed/simple;
	bh=lE2Y4rxoGGpJUBovNGt4Zb4GKu+3YtYgDckjy0zhE+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5GyCwW9zRrLxkOrt5uoq0xQRq+GLstr58F+OQTAA3Fub4AQOaFM8CZVCV1IdYFaRvOcPy8aiyk1N2EimCcQPuW3BwZHyxgPwNrit9e9JA6Xm2/6/qFZEos4CwMVemmkSBbKhyfzEMXPrRAF9dfqIMAVwcIIYf9lB8yUWyaX36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jzJZS4fX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TXbhOGke; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ALJkmPX394738
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 22:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2etO1CJNtpNIPe+HOa0WpqfB
	qr/+g9F6UdlSM1ZdxJQ=; b=jzJZS4fX5y7pYNvKK11iZHHL5+4nqDZXgr3QEVUz
	o3tFCpcTvUaJuQPdrNDiE8C78eBWcOkpXPWmdseLoMti2LxlaMRMJzw9bEkfMnB3
	+23FBecTiSkJYQfloTP/UO9WoGtu30UJbYJdiN/ejDgri+wkRzvwExQbfE3vigEm
	BqKxWkjLAxKQGwAYv6iiXxlg92cH6JyWknTCUs2LZH18Ktp454vkhTz4EGe49Imw
	jDt+f8xe3cSARZUhYpxN9Fustx65F3fDoy2lDV0yIPFYQcz8sC8cQva3zxMtTs39
	wfxjjwnBcm9U30HZqOgWN5HefauN2cFIZ76ZyugEwtgJ/g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ajxhqgcqt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 22:52:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b1d8f56e24so739086685a.2
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 14:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763765569; x=1764370369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2etO1CJNtpNIPe+HOa0WpqfBqr/+g9F6UdlSM1ZdxJQ=;
        b=TXbhOGkeLrkfFyi7fHa4zUDnNADyiBRwE4XzxAXGEy+/n9OQuM+DDdhPPrnAMf0Zbf
         CRpyCcJCc199490EVqdsUo9gmOKl2EfHqSwY2R229y3JnwLz6XupnD1jZr2zO1Mr8uqu
         5Qf4lG/87gACxkYUYhHp4ewxDtrl6hk5CQoH8mYzpsfh/ZIn81qlJSdDUZNk42RBFRvn
         EAm7pMxDZ6Nvprah0VrAGbg5qmOXuGH0jntkPf8eok0HcsrNJiQ861u0yBhX8LlqiU8x
         71sdZYxNnuNnpfOTi1BietI4FF/TOwnT3D1QZI+ZkFz/jNnFi2QouDZ5dC5SeK6FI1ur
         2jSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763765569; x=1764370369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2etO1CJNtpNIPe+HOa0WpqfBqr/+g9F6UdlSM1ZdxJQ=;
        b=Qre9IoyIsa9UektSAwLltSGKKUTFMqfFscWhpsrN3bM8qNXhS1ZhOYnb1npp4fAnlo
         fRrAOSRCaN9B40bIPs50PbW7DZoF02uiw/DRN9JTcdKL1cAxo9xpdjRNEHx2aOAjPvBk
         jxbfUM2E3VpoL2kf65IHGgjDfWajCSsgIlcynNHPMh5BcFFTyeS3eZOHVv7nmtaP3UpN
         0A/73RZUgtPnBjPAFSqEZXIsEp7XLRdZww2sf8jVNXI++m2qjH6uhEasd5yfeFrCK1fU
         dVSHENit67Qd4+sMB02XluzZeSJ3vXuRJJyoMhd4jDMyFXr/tT3hgAFOpoE1amsIMrgg
         Zdgg==
X-Forwarded-Encrypted: i=1; AJvYcCXaOu2FSkiTpwr1+Etxvad6/wJ9KaJbHz4Lnp1j3kn65WnY4kj3Z7myXK7nIei5n3gg87K0034=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk6jxoB9aFwkiYuOPhBLe4ro6sWY1MQgLtrbHYKqG54doeq2fS
	5poS6Ldioa2O8/44frx6d0i0C/TpfOYckph8060H1V542m2dzyNE2ZUfyG+mWejvDCJl5JcRYqn
	NpQ9FyrdleF8fNTTBNsXGxhfvlo6Y1AWihvnJW8nUGxYj/H5l7Foj+gWrHT8=
X-Gm-Gg: ASbGncsna1+cRgU0QV/QUq6oTyHgUkBPYGp3gjaDVxYhDrvE395ewnR02wxNb1PFRTU
	cd3rbQsg/eQLUqgFkWV2e7I1I9oPqCg2hsm6kZrqKJu3tg3Q+Ep2TP4rTpXUYb7KSWh311NXh+1
	KcyGlw27tHx8CX9W76uXd87GDvvCVEx8uWV1acV25hVRf87bDgXECH5JIIN64s4DL58SCLbJYWO
	NBUsok2GeUgsdkH+t01kSkitUKzTCSKhoK96KqB2vzCFme+BDS2FgTvNZVy8oFOJPb6myfyK5it
	4Sh+NnxtovYH8fIAQUKbaXO6YQm29vKNX9mdi1iCd6YHAURUDHP88NJ/QgqEuEuRycrTwm8Tsuv
	sKvMuPulbvvnC28KuWWae9qFwGfP50zmLuZTgidvAtQWTxleKmegVsTLbxW8q1dhHC2PwAWrcf2
	NIVzGRhheUcm1ZrimqIp4ErCY=
X-Received: by 2002:a05:620a:4404:b0:8b2:ed71:ded3 with SMTP id af79cd13be357-8b33d4a01a3mr524688585a.67.1763765569313;
        Fri, 21 Nov 2025 14:52:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb23lCKZ23glBp74IiVfz/K6muOGBwS6W382uq1fVOh0KAzZTTZ0BY7nggZa+sLLASNUkjfg==
X-Received: by 2002:a05:620a:4404:b0:8b2:ed71:ded3 with SMTP id af79cd13be357-8b33d4a01a3mr524686285a.67.1763765568941;
        Fri, 21 Nov 2025 14:52:48 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbcc90asm1975272e87.90.2025.11.21.14.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 14:52:48 -0800 (PST)
Date: Sat, 22 Nov 2025 00:52:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Anusha Srivatsa <asrivats@redhat.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH REGRESSION] drm/panel: simple: restore connector_type
 fallback
Message-ID: <4am5nvb4ldzvvaavkdu2o36viltoxxyxwybrmj3h35wtdhfcpa@53t4zahc3y6c>
References: <20251121-lcd_panel_connector_type_fix-v1-1-fdbbef34a1a4@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-lcd_panel_connector_type_fix-v1-1-fdbbef34a1a4@microchip.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDE3NiBTYWx0ZWRfX2l0+UqlrhFak
 oVBZoHds492KIX85tIclCXAWDnjQ0GW+S++GJyR0Y1TwzFqyJSbr3oVNBPagH6G/XNet+rme8xM
 TAphf1GPawed9J1bNzK3xVypjktfuXaWatsAwQqgcYGCrRD3wgc8CuljAjaJgHUdXfSHM2jSJb5
 og5foBmoJmFiAcVrCyWorJn/BZl+XGnjOwwvka/sAyDtQxvdjwe9YALP4dOBnWUcpu2p4by9xTL
 bkwnw8qzl4aP6yCBm1/IKWhwSlTClwgWCiknujPoNlYZOPIRejFFaFQWTBfZ4ZRI4B2FsmgRfuB
 f1rIG16pBfzjh1V1JBrdvtMrOZ9Lae/yDy8PfLEdk8BEQZSchu/t9h7kzHfjd6xiE7wPpIIJzzc
 vqtBB3N0zRy64eyHRlIk2iPuSxZ2iA==
X-Proofpoint-GUID: QHrjYmQXdbsvJ2uO7KSK5dJ5w1gfTrUT
X-Proofpoint-ORIG-GUID: QHrjYmQXdbsvJ2uO7KSK5dJ5w1gfTrUT
X-Authority-Analysis: v=2.4 cv=I+Fohdgg c=1 sm=1 tr=0 ts=6920ed42 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XYAwZIGsAAAA:8 a=255BHluu6XS_bZfolTkA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_07,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210176

On Fri, Nov 21, 2025 at 02:20:48PM +0100, Ludovic Desroches wrote:
> The switch from devm_kzalloc() + drm_panel_init() to
> devm_drm_panel_alloc() introduced a regression.
> 
> Several panel descriptors do not set connector_type. For those panels,
> panel_simple_probe() used to compute a connector type (currently DPI as a
> fallback) and pass that value to drm_panel_init(). After the conversion
> to devm_drm_panel_alloc(), the call unconditionally used
> desc->connector_type instead, ignoring the computed fallback and
> potentially passing DRM_MODE_CONNECTOR_Unknown, which
> drm_panel_bridge_add() does not allow.
> 
> Move the connector_type validation / fallback logic before the
> devm_drm_panel_alloc() call and pass the computed connector_type to
> devm_drm_panel_alloc(), so panels without an explicit connector_type
> once again get the DPI default.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Fixes: de04bb0089a9 ("drm/panel/panel-simple: Use the new allocation in place of devm_kzalloc()")
> ---
> Hi,
> 
> I am not sure whether this regression has already been reported or
> addressed. If it has, please feel free to drop this patch.

Would it be better to fix those panels instead? In the end, the panel
usually has only one bus.

> ---
>  drivers/gpu/drm/panel/panel-simple.c | 86 ++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)

-- 
With best wishes
Dmitry

