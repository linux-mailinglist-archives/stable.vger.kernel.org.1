Return-Path: <stable+bounces-181446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A2B94F96
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 10:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D713A77A3
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8A531A7FE;
	Tue, 23 Sep 2025 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UATZU/Ep"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43C33101A3
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615792; cv=none; b=JrdqlWzm05v4OPqPyB4WVXfBgu4iZ4N2E4GTIPXfptiCCTDlkUCkFtzabiERUPC+j9FALdz6mztLKOv4N2ko+Vwrs5+39MXqDsSbVqZwnlSaLxKAikUH9oPRvE8b+poLYKQXsgXx2xRoihpY83Cokt3PAUCl9gPDru5RThoNfCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615792; c=relaxed/simple;
	bh=hZL8cMemp35OvsvtLi/PbzQZ983k0IxZK/KFVRezPOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRun5AgxzvI2InMRUrXZhOFDAYbB2ksK8zKEAgMlwz8sJxK6hgUXxLtot7VfdhQca9nq05BCqPd1aRFOmcqke9oKNg47xpI0E4j0eddgh4jMqAkAk6ZnTuINmPigtV8GVJ4m4E1f4d51D+v3C9o+a5TlmQ/NlUlrEuRTSprraMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UATZU/Ep; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8HBwM020668
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 08:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lHIoF9YFlreh6iJ8DpMNf8z2
	sMgb4aI7tWDoMnOWm5U=; b=UATZU/EpeZ1vemuj47fpIcgU1Xz+7dQoj49/0Yff
	K+e1VhS8Vyiw0VcCzfOBFYxjlE31+AIkYEAuL15/vh99u9NhznHxefweDKMsC0lB
	mjqUg0l7t/3FNzk05EdCxHD2dA59sV2N3Q/MZ77LMMGtr6AItWHMPJqj/soTWtMS
	kckFZs9rjlcXMzFgUVIcM9wXJEJMisodD/1aqnvnjYduhEuSapKlEbJmN/KtM8uH
	ozbSeFfjFAA8xyaDPVL44BfuaDhtJVE82cARAhzilQfePQUiCLkyQ87bSaTIyW+x
	jguOPuo/QLtBaAB2R9DqN5meit2XqhCJBZhiJQYJ7Ngk1A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjs2ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 08:23:09 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-798ab08dde5so69439766d6.2
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 01:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758615788; x=1759220588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHIoF9YFlreh6iJ8DpMNf8z2sMgb4aI7tWDoMnOWm5U=;
        b=aK4d15UnoCz9dlLlq62OafaOHcc1ybzgx9fqV37XfvOTYgBpuClLX8+G6jc+jXWzfd
         0diNWCXxGecCKqAL1Q4vlv9hWt8NtC/mn7kBUzrOhoY5QOTEAn0zux1GdsSWV7FDp7wF
         Vu/zaSorN9VbSwr+UQt/xYT1h5BMP92ovaH1FghSdhHjbX9eLraluzec0SW4MqqmGB3J
         6xl2b9F85arWASQT1j0xgv/EpRk4/ZEJDwO4eFTiud+2m2D+mUWhePnkxhF4vQ29os70
         TEqwoKXE+9jbpr+aAdcHfge9YQBQGsxVivWYr6+Yhgqsauwmb5ecoSjA7LZNFmFHFhtF
         992A==
X-Forwarded-Encrypted: i=1; AJvYcCXkNabIyRSzq0BbsK7aMoMtxhvrimSbt2HRZEPhjFT2QZr1S1deJ2C2bT4m6AUYzH06siQVV8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX14Aagc2NPsxWpJQMO+t8T/+S+o9c1KyRrm8CoQ0PtQtBFwY3
	he5IfLVShLczNcGB7SbtYHX8xBwquKLkWJpl78Y5lhLoR5vmLh6RVWM8ySytzfEqcRIDQZowzea
	hDpOoJGJRivw9ncueD/C9e/0hrTwWeDXEKwDCyLZzS1LZRQqBWmItRoCdxhs=
X-Gm-Gg: ASbGncsEhZy3JY/yMixsgOjDP5WaA24iRvG3OjH/a+dYnjkNvGZtDH7gsJ6495O5Q2M
	41ctsR4B+hlRkqwP/C91fFFKMYnHglv3KB4fHGPJgiZFVB4lnxxPFy0qmBUywDCzHrHu0VCH1/n
	NndFoGRX40HOirrKdFmFABzBoEnJPiMBJVRIvSl5Vpd2JBv7k63l8iBiS7B2eDdBI/7jBEjVLrf
	MhLSinLEZRyVrnH1QF/VcXBBl9M/8mJd9TJ29HcCTt1x/mlD83jwrKnUNC9epQd3gX35eLmAd+1
	Eht+ga5EelF0zxTysSPehpf2rniZxtuZLkUz1UDw4XWSXwYHvd5InzVNp1X/VO0puY13miznFKA
	KklwwTGyELkFX25sQSEe+r9HxsZGVm2U3yWclZJvtIgQFLW2s4EX2
X-Received: by 2002:a05:6214:2a88:b0:786:8f81:42f with SMTP id 6a1803df08f44-7e71133eaabmr18299806d6.39.1758615788329;
        Tue, 23 Sep 2025 01:23:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTqf6gCEvg93UnurQ8vVB2x/PoLj6l4bFsWeAr6cog3AY0TdhZBUmDyx4Na73stVCrlcsG3A==
X-Received: by 2002:a05:6214:2a88:b0:786:8f81:42f with SMTP id 6a1803df08f44-7e71133eaabmr18299596d6.39.1758615787733;
        Tue, 23 Sep 2025 01:23:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57b3528c49dsm2473961e87.134.2025.09.23.01.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:23:07 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:23:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: srini@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.dev,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] ASoC: wcd934x: fix error handling in
 wcd934x_codec_parse_data()
Message-ID: <a5o4iivd7ph4h7hb5mhfwgijob3celkn5l5dci635a7owzga6t@pjmf37gcmai6>
References: <20250923065212.26660-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923065212.26660-1-make24@iscas.ac.cn>
X-Proofpoint-ORIG-GUID: oj_wY1PooJbrXA6MTjduJpqRDxoV5F-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfXwvqtS9M8Ov7C
 Qf7PkmhQExfCwFPWqUBaAgBG1vJP3oK6heBNieS6QbniSMo6O0/klfw2rd4QiEcKBHAvWOZTyOH
 E7BSVxKV8QvmZ+XvFSM5ELZGSMAn+zf+bH2sO/F/xNUfJN4Tn1DwPVyoNdio6fhQRk12P1z9+5b
 qvl20Nk+Kn43rm9ygIFF7e1SOt8V6mf/w/QiLgAXWvO+QbTlMCmOgTGe5jFWZoGS2SkhA0VdrOp
 MDBUMXbiIzmWfy5zPhOWnMp7I7kiweHA8L1UUocVVZW0ya4mauAk3kjud55Mno22M58mb1r8Rl1
 0PJRoGs5OqtlmlWxoKjMKb09bS84C4MHbLxjAC2rpmBPB+su1MAwz7q5UFx8ZFO5+E/UFt2y6tc
 DCLX0M+4
X-Proofpoint-GUID: oj_wY1PooJbrXA6MTjduJpqRDxoV5F-4
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d258ed cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TWLRxeszWchEVqlQ-2MA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

On Tue, Sep 23, 2025 at 02:52:12PM +0800, Ma Ke wrote:
> wcd934x_codec_parse_data() contains a device reference count leak in
> of_slim_get_device() where device_find_child() increases the reference
> count of the device but this reference is not properly decreased in
> the success path. Add put_device() in wcd934x_codec_parse_data() and
> add devm_add_action_or_reset() in the probe function, which ensures
> that the reference count of the device is correctly managed.
> 
> Memory leak in regmap_init_slimbus() as the allocated regmap is not
> released when the device is removed. Using devm_regmap_init_slimbus()
> instead of regmap_init_slimbus() to ensure automatic regmap cleanup on
> device removal.
> 
> Calling path: of_slim_get_device() -> of_find_slim_device() ->
> device_find_child(). As comment of device_find_child() says, 'NOTE:
> you will need to drop the reference with put_device() after use.'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v4:
> - removed the redundant NULL check as put_device() can handle the NULL dev;
> Changes in v3:
> - added a wrapper function due to the warning report from kernel test robot;
> Changes in v2:
> - modified the handling in the success path and fixed the memory leak for regmap as suggestions.
> ---
>  sound/soc/codecs/wcd934x.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

