Return-Path: <stable+bounces-217838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Li7AiDknGn4LwQAu9opvQ
	(envelope-from <stable+bounces-217838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 00:34:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBF417F9A4
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 00:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 440FB30DCCF3
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 23:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F137F8BF;
	Mon, 23 Feb 2026 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cN8RJqsz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CJ3dqWkn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06B37D101
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889604; cv=none; b=bAbJheRGTamSQ6U/7mZKxlxW9vkMy8VTx7F97N9bcT1L+HmEUkipjEWWup3b9wxjJaafYgSaHKQMw3/m0FeME0OfMSb1+hTaAxcuBY0wE3f7aE7y2a97XZpSgqZObSunbsbtMaick4kkflIEFy0bi4fwDGfmLzsEso67q/p2O30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889604; c=relaxed/simple;
	bh=S9B0zGS5tGyITzgCtwm552xX1CH1pBBnL0nY+GO3AVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG6/EMzcHGzepdIqzVit5kK1YQ+FXhomCHqbrQOXSiXQKbAmShHqPGixU4/aT1C9deRBnRb1deaIJy01P6y9RPRoxW8Tykit3WaAsd3wDFxiGZ18FQ02Chon6WMsArezhQRM1gnmQInc0xEjbg9MH7YyyzQUiR6Guq5VsqgnVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cN8RJqsz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CJ3dqWkn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NGFHLX3936125
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 23:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xEZRaWaTYLmfpgMyGlakvruL
	p3dxSVDm+gJQSXU8gwg=; b=cN8RJqszRqybxYKAhu3zPVhqw/RSlOZK3MOiyPaR
	n8FNsXTpTOeH8DFgE/CSATNS7Dp63+J3xnlOc5jVpCu8l0i6aBO+9UP3lG8djhZl
	0QAe8X7muxbOM7SluzWZyIOiu2Z1Eo+Bwt4w2dcwCcjxyE+RAibBeIFY/OiJffgj
	1pXEfOficE1oMwVh6C2WKufbkmAqA3Iv3+0fVqsSKDPO8aJdbdPC3DORNt59YSh0
	g4AbkypOHYrhwBgNvX/bqP9eNgq57BdgEXFaAVIT8LbMWBF1KtI3zffy9wnWDw4G
	GKtnWMPjzut45ID61nDr0FiiBC2+s3lx/1JMpfenOXnzyg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgt8mh66n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 23:33:22 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-896f96458f3so151010766d6.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 15:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771889602; x=1772494402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xEZRaWaTYLmfpgMyGlakvruLp3dxSVDm+gJQSXU8gwg=;
        b=CJ3dqWknSCvCgM6IgpUIioAZ8DNbiQMDtGvPSc1akb/YV2T8IixwypE0P21MPm31UU
         2lJ9Tm9gIV3rWa7W34FmJHF/NxMXibATp1IyVRc+J9EjHQ7e8HGs6YpgGbtTI55u+oJ6
         ORgPjdWtQ4vcrN/7cfty198jGuFo4CMmV+2nRRch1wyBAF0CLwV0q+fNagREIw3fZ3hy
         bTYSN3ztECIy4uBTIZdW/wdDjzP0V78NFNYqPGcqKQXvAKDk/0lAJrJ/ZRsbnl4CLVZM
         lrU/h/5HpVPeG63j1vuhLSVUzANWoseijaApa4rU+ZHSDr2m1JWYgZC65f0LeuoGgGOY
         9lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771889602; x=1772494402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEZRaWaTYLmfpgMyGlakvruLp3dxSVDm+gJQSXU8gwg=;
        b=KAmXmyfeNg5RaJLVWOn8qh3WH0vQfIYweSdUI+cJfOlW8wJORjP8VSf1MqirPUUKNo
         Yk8wDlos3EW0e8hUrwX/kfKLiV7EqmcvmkGN6cQjwrtc0V7vx4A6zmM8809cq7GuJIH9
         QcWNSggimCOJSC+pwKOijria/6roY5AiceJD6g95859oFBbObOW1xHSzF+qQk/EZJY1P
         IdvWt8jcwgKB2BJi042aNJObShmJNRTUhDnRYwUN0K+n7meyIDIQ242ZhS35RZoDsc0Q
         gb7zDsJpwbrAugWkib4AWS5v4UMUcbvCfBOH+B47GCIpaVzUlG0cQOUd7zCl0Qv1TFJZ
         KaSg==
X-Gm-Message-State: AOJu0YxQp93V2fdqYSXgxjlcuLxmWi654BublMbUin+4+9LlHMwda6dy
	27XUgpmrRkYFbFZewqr8LZVROqjlxy982C4ro2TjjFXsfsnzh8DNmXfJ5mTmNZaVLWE7ref5aoA
	qqYGUO5GrE0s5FnLEJkxGMdbB1SvzlQOIkR2ys7/wZiH23ElFQf5rdwoH8Oq9QFb/6ik=
X-Gm-Gg: AZuq6aIG12J+ErE9VxsJ996LgwYfito9Tp4nus/7Sk0AOQ+MQd6pApC4JjGyF73D9ME
	tO7zW7FN9F77IYuGShoQUhpDR+hqwkqEbre8o9AB3eauh9ujBrp2tr0W6xFs8nwL9i8SK2q66QY
	6lXVOtZclgsAell0GRiRlTfdVYAXOL7ibGlGfQE6lLWfUvsHlFKhYgjCjETRxLb+NPeozQkPtp+
	tPeLxCAiTVmzqlQoxq4S7r/SBitom0DlwfyhTBjbSy8CLbTsbh30olsG8BLSzNF542nFUkPuemz
	CAvX74eo09f53GqVSc5b5TxeYp1O05Q3pMW3jgY5wBaOyDLKcgAycMlBt67tE0h3NlqiNFISvuF
	qp6lh/SGYAGgIjG5Gpva9zTrsIEm39sKo6CTKPW/R6XPM8SMKOR+RXdjBat4DrBDWxmKAOhmV1K
	h/BqGRd2VYnaodGvIU+c4Z1jhsukpE55cKtd0=
X-Received: by 2002:a05:620a:45ab:b0:8cb:4d64:e993 with SMTP id af79cd13be357-8cb8ca09dd1mr1373763985a.26.1771889601855;
        Mon, 23 Feb 2026 15:33:21 -0800 (PST)
X-Received: by 2002:a05:620a:45ab:b0:8cb:4d64:e993 with SMTP id af79cd13be357-8cb8ca09dd1mr1373760685a.26.1771889601309;
        Mon, 23 Feb 2026 15:33:21 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb47617sm1867293e87.75.2026.02.23.15.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 15:33:20 -0800 (PST)
Date: Tue, 24 Feb 2026 01:33:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel/qaic: Fix dma_free_attrs() buffer size
Message-ID: <w537ptifelockziyyn2lufdmkv2puwrwdjnydsyiqn7tuefs3g@lobsudoe33qq>
References: <20260210083529.22059-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210083529.22059-2-fourier.thomas@gmail.com>
X-Authority-Analysis: v=2.4 cv=J/unLQnS c=1 sm=1 tr=0 ts=699ce3c2 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=h6-xzC9InjtDQXJTJ98A:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: PiHnzdDyWCFDyxpLlwnFY11DI-GcNk0c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNSBTYWx0ZWRfX8lD2YitThdyV
 JeTuGQrmFgsfUjXEY/1il04trO1fC6Hc1hy8PurEzyV7P7RpuPhDoMH1PWPsrv4fBNvJj8mdXHi
 G2LUJBmg1Jgb/uUkumSAD46X/UcnXu3J9pRbHKHAKLNm7jwhUf4kC+G7sFS7XkWHfDyqwA0N+c4
 bPP1lU4SABs7MXsH247YwJz1dbonk1t7KAWrh1LK3amE3IR9krikOv2KSRzJ9BLtc0H6fS/LB9J
 5sw7XgOVX47/u04uy/mCBXM1hBXXhWTZUeS50cLcNO+TqAV55/x8/zJz632jQ6FNuAFNkc0EjBU
 PCxp96KCJiBLmWzpAqoOgSjxuZ4bELeKY38X5EqI6lhmBj0ZpTus3OcsP2g4uDBp0Wfen9xr1tc
 kn5Ed0fc5TLUt+fOk1qONwdzDLVUCYnMPbjtNynAl8ob2KaYUqDBqvNsYHr3BCzX0gu75C3AzIE
 GmCETmnHKA8aFyuIyNA==
X-Proofpoint-GUID: PiHnzdDyWCFDyxpLlwnFY11DI-GcNk0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230205
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217838-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,oss.qualcomm.com,poorly.run,kernel.org,linux.dev,gmail.com,somainline.org,ffwll.ch,marek.ca,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3DBF417F9A4
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 09:35:27AM +0100, Thomas Fourier wrote:
> The gpummu->table buffer is alloc'd with size TABLE_SIZE + 32 in
> a2xx_gpummu_new() but freed with size TABLE_SIZE in
> a2xx_gpummu_destroy().
> 
> Change the free size to match the allocation.
> 
> Fixes: c2052a4e5c99 ("drm/msm: implement a2xx mmu")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a2xx_gpummu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Note, your subject is preffix is wrong. Could you please correct it?

> diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpummu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpummu.c
> index 0407c9bc8c1b..4467b04527cd 100644
> --- a/drivers/gpu/drm/msm/adreno/a2xx_gpummu.c
> +++ b/drivers/gpu/drm/msm/adreno/a2xx_gpummu.c
> @@ -78,7 +78,7 @@ static void a2xx_gpummu_destroy(struct msm_mmu *mmu)
>  {
>  	struct a2xx_gpummu *gpummu = to_a2xx_gpummu(mmu);
>  
> -	dma_free_attrs(mmu->dev, TABLE_SIZE, gpummu->table, gpummu->pt_base,
> +	dma_free_attrs(mmu->dev, TABLE_SIZE + 32, gpummu->table, gpummu->pt_base,
>  		DMA_ATTR_FORCE_CONTIGUOUS);
>  
>  	kfree(gpummu);
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

