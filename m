Return-Path: <stable+bounces-240362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLtjM6T16GnaSAIAu9opvQ
	(envelope-from <stable+bounces-240362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 18:21:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF11448841
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 18:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB0E63029630
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE8037475D;
	Wed, 22 Apr 2026 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LV9AA43H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VLrq4cTs"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6437C923
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874485; cv=none; b=Nk12PRryWwbxgg0jgINByKJTuld5HVNKQ/9huSONSf0l2x2R4E1UdUFEKkbztOfnRSjdbgobPYKcBQ7OTmnKZvnYwTz9PSuVIaFjRHAIsgZcWJfsvAi3Bt+t8bOsY0fNR37ftRJwOYnTVv2uTxV7vAGiE9uQGWNaeAGpS7n+A48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874485; c=relaxed/simple;
	bh=B6PM+rc3ebo/0dAtIJcbE3ZVdBi/0OqnBbMeWPBoJwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqmMLznAV1nceK2FKnJfEBNOydNKOVOblaNhXKCWO8PZWHlO0TAdq3HHXj0SrzW/4HsHmfd/PIDoJ75gzh3gsA3b8jmIyKwNLGFPngQyD4YSk9G/CchGvj70Ek1123WUx57amEkVM+ef8W0dcbgJCO+Omai/lsFrhO0O4GibTdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LV9AA43H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VLrq4cTs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MG4kp31587779
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 16:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Zr/OzAZHUEuVH/4CQJOqAS3f
	r+2nHg7o7uvxIJddDDM=; b=LV9AA43HCxX+LXH7HcMvG1vWdWjb/lPHuKSelBQ8
	t+BGNlbCCd+Ib1eqoLkxIrFBmUyY7qyqWbXUXCasNfBSJC4I5NPPqBPCShewKYUb
	nmGeWOaPXirzQP7jeY7ayhUm5YRR4HVLAAY4wpISSiBa2KXy3z2jW0C8Ce19kwte
	oPQsTb+4z+Uq4/9cqO74LB9RfxwPZ6Dpn4L/DsTg0SH36Gakdh/McPWE7h4sKuKN
	VoaMpwvGwMKjXxCsAVlF7Qrnv835FPYR5n22F8njzD9bDHVlP4Ev9SmoXdfo8Fp0
	wQkxd0jTMoN5OD3rDNJtO92OZx8C92U2AoZG6rVl8iW+gw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1hq0195-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 16:14:43 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-956a188d7baso8512303241.1
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776874483; x=1777479283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zr/OzAZHUEuVH/4CQJOqAS3fr+2nHg7o7uvxIJddDDM=;
        b=VLrq4cTsURXdCdviUoeknjRkdVwOzATev1O0iuNmjw8YVCXzPRc9THEcy1ryOBKjCu
         nMvE6xwNsuWP+x2iFKg/beSFCvQ8ZS2wtd5y2XGWWF5BDiEdZZUeddYSMx1m6DY4b3BK
         SjnT7c5lGtofE5DFLl+LfzlmjMQxVK2Dne/fqan+f4NU4l/QOHURz2M3FVPAuwwZEVLQ
         kJ20FCdjrWI3XuoaK8Ce5ycWUr8G6/8yc3LcDIebhP6f1tEepqR8IFIoUJIZvgB2Fs2S
         MUmiDdi/5/ygbt7iqJWUf9zzBXnuglcdb8vgiJeprMSq8EoDOTVkJ2uybCJzoZ3XZfql
         cT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776874483; x=1777479283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zr/OzAZHUEuVH/4CQJOqAS3fr+2nHg7o7uvxIJddDDM=;
        b=DxSSTLEu4O6MRZq9TuSC5cupVWtUzLjQwHIiRRCo06Y7S6aQ87u+pPJ5HrUS8CIeJL
         AsWWmqGCoDFqWOSAuqP1rTNBdmxl9upe4wJPepx3z7TFndq67G81VxtItrxDS8vHtRVS
         Sn1AI6l5PCOrsvUbyoxWaXuA1gBwrV6isEi3DOOxetDEQDXEFdRgt08EBbXIqbhiNmZe
         LFTP/bHpJ5k4vObsGfK4WZg0OXDLJ7QuirJa/e+Lmwzivgq6WqwLm83EZUm+Xwsh+tdi
         ovD3nlNQqRiN6DXay5CeU/pXzwWggck6wzSYVIVwATZThMl1OhDQGZZ005gYAkxJLg/S
         Ewjg==
X-Forwarded-Encrypted: i=1; AFNElJ+yKaj/01AouG6s1QmiiT33FCBOKf8NgjmKc/bhwWy+g+IyDvQgfzvdgjlesyUeEcLWGT0BIys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK+UsxflytQnOVlDDzAjHDbvCuBi+Ht5YrQwkzsk1lhycjXRO/
	R3g0/aALT18ADL0SZZ/GzypXwWRAZ0H/f4N+4R+RHuOZESP9jAzwiKIRRT2Z+kEMtgB3Em9XVm7
	e6tsqKAykEfRJiKSFtCaq5T/GOuUEBuvfwYTvB+jU5K93VzSob49E/dtMOP0=
X-Gm-Gg: AeBDietq9h1ilIN0fjFz3JFVsKDRM/LUzVZF44UzjCv/Jau6A64cMlvuwtGj2m7BcTe
	Vb2zLfE73LULPHnkdmKaOTp9eEgoEv6WuTJzHPUevmm63zMV1TuSoOwDUW5ei2DneaVO9cLi3/9
	2aocfuqp8bhGr4EsKTPaHkthSO2/9huvd0l8I92ykMex5mvVE0PSdrq6KatY6SYrDlo75LGIHJa
	wk0XKXEn0rzScMDCKjwJW0gJPcs8Wg5oXxg8ELQ1plOrfPcQbEaSx2JxfV7BKaDqwYfAWORQwB8
	NkEHfCAvq8dIPagoD6W+28oBVRtlJZXS7gA6RmUo7nuWGYSBmYglhIGVYDBkfixcXqWLNElMfgs
	F306GmS6HXgpSSILa6LrAoc8+7xiXpyonnZS7dyIvfM+8slHCeaNHFCtTZ3FnCBR3terNTbBQ13
	C4ckZMqyC05Udj6n03WB7iAQQI9PnPDP0e6PUH4duva2cErw==
X-Received: by 2002:a05:6102:4422:b0:5f5:3739:100d with SMTP id ada2fe7eead31-616f87a1362mr8339110137.0.1776874482865;
        Wed, 22 Apr 2026 09:14:42 -0700 (PDT)
X-Received: by 2002:a05:6102:4422:b0:5f5:3739:100d with SMTP id ada2fe7eead31-616f87a1362mr8339094137.0.1776874482451;
        Wed, 22 Apr 2026 09:14:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb6f0b88sm37661441fa.27.2026.04.22.09.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:14:41 -0700 (PDT)
Date: Wed, 22 Apr 2026 19:14:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/5] phy: qcom: edp: Add eDP/DP mode switch support
Message-ID: <2cyvdtnnmrfz4zffhikfxl2goyby73gybgm3ih52rfpyvbhnzk@37x3g26o2t33>
References: <20260422-edp_phy-v4-0-c38bef2d027b@oss.qualcomm.com>
 <20260422-edp_phy-v4-2-c38bef2d027b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-edp_phy-v4-2-c38bef2d027b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE1NyBTYWx0ZWRfX29+M52BSsq7b
 qlhmNS/E5GSt/2kTORwYApm+3Bw3LUkR4ak3nnBiiV0VuH1CgbxmRF2sJFLsTraItQ1PDd/ZovX
 aBjgdGiVlBSMfvF6hRAhE7GEIRCZvdouQfpnRfjAQMBG9jCfS5XlwMp6JHvRARjDzdCkzWgroxA
 O0XTuPK9cDAZKtrT709sRM+7zdinqb+fWdUnsOBK7wj0qdyC3Do5QqkKJQzta2yhCih3D/m+hcP
 XPPeSNavyaqiBtZ9sVCwdIoPUb8v0EaUxDSE28l3cJuthWRPNeb9zyXmVG0xTo/T2kX5CyO472a
 no1emlYFjGZTIp8RBKhCM5s3Q3sMeIjUeJayWtwleEKqAFOcKBjlOLN6zxR4/eGxHR4XKeGNDML
 iOli9BoCpBJtfKg5CJyCvc1PscEfBc0ieYvcmgemm6WMiXjYtDOw+PySnUcV7HMvUgm/eRDf7u6
 ywB4w9ONUSY9ltpoKhg==
X-Proofpoint-ORIG-GUID: hQeXfz37GjtFQcrnRMSLesJPKdplqVi3
X-Proofpoint-GUID: hQeXfz37GjtFQcrnRMSLesJPKdplqVi3
X-Authority-Analysis: v=2.4 cv=TJt1jVla c=1 sm=1 tr=0 ts=69e8f3f3 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=cJcfiVH-KbuR3wWgFHsA:9 a=CjuIK1q_8ugA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220157
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240362-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4AF11448841
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 02:01:52PM +0800, Yongxing Mou wrote:
> The eDP PHY supports both eDP/DP modes, each requires a different table.
> The current driver doesn't support both modes and use either the eDP or
> DP table when enable the platform.

This is not quite true. The driver supports both modes, but it uses a
fixed static table for eDP programming.

Other than the commit message, LGTM.


> Add a separate set of tables for eDP
> and DP modes, and select the appropriate table based on the current mode.
> 
> Glymur's DP mode table differs from the other platforms, add a dedicated
> table for it.
> 
> Since both modes are supported, so also fixes the table mismatch for
> X1E80100(eDP) and SA8775P(DP).
> 
> Cc: stable@vger.kernel.org
> Fixes: 3f12bf16213c ("phy: qcom: edp: Add support for eDP PHY on SA8775P")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 46 +++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 12 deletions(-)
> 

-- 
With best wishes
Dmitry

