Return-Path: <stable+bounces-192735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C8FC40451
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 15:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A75C84E3D44
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 14:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEA4328612;
	Fri,  7 Nov 2025 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bjh5494M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c+hYZNX/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECEE31AF1A
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524884; cv=none; b=HvKZEDQRbQDnY6vfO84mLXtiv0U09zNGpVf4VfTlOlF/1bnKhxoW2sAitOUSMqK5DeK0StsksM1m06zq99tj20lfcmgptakNxo2faL8+AGZm6xz8NX2ULAmSojZxYOvIa10wfjxP/t1cFPdTKOBOLcgCH8Vyw2HgDQ8Z75VSPqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524884; c=relaxed/simple;
	bh=RvPQxgIgtwop9B2He8NTdcqhJ7VIGmyJd05aqc1U+Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQc8iE/nGjvGiMyLhQDrcpap4yzQ1lLLfCOLH+bLFXcWRrikIojuvSzIiE6Qz+hScr8YJZNQP0ZWcs3RtVwtUkerqAIWYl2jDv5vf624qEIy8SpEt6fzdLBHmZJrGhwIdquZCklfIYzd1CZ5A0Ih+w8R2WPnSgnk8YDmrKscDU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bjh5494M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c+hYZNX/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A77CGwm630895
	for <stable@vger.kernel.org>; Fri, 7 Nov 2025 14:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SmS3Q7L4A3dg/6fm+d7u4/uz
	7vXGdzANJKFOfiokV5I=; b=Bjh5494MsS6Sk0DJGfkDLCDoysY3bFCW5F2R/eRK
	Iyu39AzYTmWDp6Key2rEag9eNZYJSm/zVM1W7uOxcHJMzmYRgflBckSSsvPOyqcD
	i0vgzH8Y3diCVQzO6X03IorfVO6LQK5sTqLNLcUl3CSWLYqT0Zsb2Fq9VkiehWDv
	qBrXyfMtwGfNeXj+AW2xvGiefDPGczF5axJCS/oiXxahnUlmWcVU/A+GlClU3I5F
	sk3HGkvbc49koe0zSIGarEpycMHqtQ7OTrKDVHrjaAY6yJFkVqqPmh0oJkp/lG43
	6c+rw5CBEEfGTEvZ3fUkO/NLBM5sBU+O80YkFCJ2f8Lprg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a92232uad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Nov 2025 14:14:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8b33c1d8eso21889431cf.2
        for <stable@vger.kernel.org>; Fri, 07 Nov 2025 06:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762524881; x=1763129681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmS3Q7L4A3dg/6fm+d7u4/uz7vXGdzANJKFOfiokV5I=;
        b=c+hYZNX/slc8NsKT93h8pFbTk2VFZG1K3fUchLbNAO4OcotXCEBmPO5MA7ge5SOaVf
         pi6jIV6nWiNrxddXLLXIeV0+QNiwBWUDOOYOiP5cNvsOVThD36NjBfNohoZn472utLzA
         kYeyGnqUA2nhub/W9KY45DXBVb2oqi7kRSzy+Aoe4PJA475GM5glJTvr76owLag/nGhh
         G7uGeslYyhPYKUBz7AaYwkiTV5Emx6mcJhGnImVOiXWnXqG1KcGy68NVzz77WsreJPek
         Q6fzqP6UnP+t3fJT3D1d83pA/cCzqwXVXCFIu4vxbsT367l57ceim5na2fXUh7SZKqz+
         3Q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524881; x=1763129681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmS3Q7L4A3dg/6fm+d7u4/uz7vXGdzANJKFOfiokV5I=;
        b=vjo8Bw56Kk//W3V06owtfFzLz3bRsGnXASG4B2inMfpsNGR+6peo8ZlHGNj1mfn6pg
         USAne2r1TkDJ5GTHaFgUlEWiPZGxXT9I1NfEaUsMjxzCXJIumpr+ZhXYEbPnrR7rqBWb
         HXx9nwPBWSH2jEmlxw5HFnPs1QOOJ7L4zuRnWS7hI4cCzZNcBLnUfUn8MS8fzSPt6ZOl
         uu1kw/mzo6ATNwqBhfDr5DB7fDqeDYpOUHenDebXch4Y2tZTEHOZ880NuVlvz8/xO9vg
         RM2bHq5k0lEsndvA/pxZ2ObOQ90QU2KOgJdS/2kVk/WmqGXI4jQ90sOAmBaq/pa/ZHla
         I4vA==
X-Forwarded-Encrypted: i=1; AJvYcCW+1mzMi8Tmgg4XBv8y1eYsNDGlnldfgjfKQNYzXaYP68A8Sh+f4ryBPOrXd8TzDmtN/TfR0Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYMEORr46VudAjUdR/NLOY824ywBt/wzaKwdeb+Z6d9GIaKGMI
	NZfkn8BTXuRF3rF3W6mLnY7DmPQf6NgygtEWtiCTiyUICqkohXhVE8aGNQChgiNU2kYPYIcbs2v
	7CmQYphAW+s/30EM7Ktl4z0uct2ziUblnRpMLdjGW9lZMcSDECOWj1o9nZ9Y=
X-Gm-Gg: ASbGncv1Vr70jiegc0k0CeO0MlSrpGf72XeP0vFOEaI4mAYTK9u/rmS6MOjC1uhRMd4
	Jdreyyemrfqd5PyqiqbHqkOhh/uItCqIbtDRpEOTnZvZB+tHgowk4BHMjD/9KV5/lLGhp+q8uqo
	2HOfxTqLA9n8GitsiguSrBIQRS82pOxhWCymdqK/vrnop46C0mySA8iTzp+QP1eCUVNGTk1cP6l
	xdEtRzPAvvkdmLTd1zM3G/eOcvJoHQa4z1LGGeggMHJXIRrQ3efb51GI8fNQAkuWN/oVJasaq5E
	MhEo9qKApoJsY0+yQLCtIIV2rgRsmqexO47jIPhZBY+esWugH331YLUHJyERjgMJ1BSbPEAx2dR
	A1W3fmZPEStbmfwP2EssejKWHAd9PlD/9nJ6MALKLiSShbpjSVtWtpp31CQOsKCq/7kIwdbWyfj
	P1fRhQNw5fyWj5
X-Received: by 2002:a05:622a:206:b0:4ed:66bd:95ea with SMTP id d75a77b69052e-4ed94963e22mr44319071cf.29.1762524881200;
        Fri, 07 Nov 2025 06:14:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBnY5MD4wdoLvWeRk7iLw84FFclEfzHbsf58yd7Jn6ByFyHQib5KMoXl14FvsPrPr2Dh2gbA==
X-Received: by 2002:a05:622a:206:b0:4ed:66bd:95ea with SMTP id d75a77b69052e-4ed94963e22mr44317521cf.29.1762524879844;
        Fri, 07 Nov 2025 06:14:39 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a013cf3sm1484499e87.12.2025.11.07.06.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:14:39 -0800 (PST)
Date: Fri, 7 Nov 2025 16:14:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: kernel test robot <lkp@intel.com>
Cc: Shuai Zhang <quic_shuaz@quicinc.com>, stable@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/1] Bluetooth: btusb: add new custom firmwares
Message-ID: <66bjkpos6ul2gnh4ezmtidjguv3qx6bedhlihbg4vtdkmnvsrb@jmojegj6ijf3>
References: <20251107125405.1632663-2-quic_shuaz@quicinc.com>
 <aQ3sbHDGL4DQAE8J@4b976af397a4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ3sbHDGL4DQAE8J@4b976af397a4>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDExNyBTYWx0ZWRfX3gZmFuRQHDaw
 kSOBFVIf+ifIzODnejtpsgSn9rNduJy4RQ6Lf+UrwMRwmvZTJVmCj+Hs/EvQSnrNnv3E4+P5FjY
 z8PdsHe/GMFkkQhRMC345ypZQ26nn/SxY9mwVNDY1yD40FARjseU4lEn08AyL/PRKq0USY2E8Xa
 euoTyK0gcdig3dJHWBNx2JZFqWcnJ3i1JBfYnAYIFknDvyNa/ymmqMKRVSpTMLCCn4CUIKdRgSv
 LoUeyUjJEFDlhMuB2A7UqYUvg008kxccWdaPFhQZ/45WeW1Nt4TqnJfuticPSF3MVSe99znPhoX
 YNtYJzlBJRth1HdLaN01Y98n490W6n16cy9dF6ZAUC99BUNugUnfFfFXrHkMqpwDVP0dE6YccXG
 EI95hiXgrPLnztQNMIUmWCllUWVQSQ==
X-Authority-Analysis: v=2.4 cv=Csmys34D c=1 sm=1 tr=0 ts=690dfed1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=zWZEkmIZHcL_vKng5HoA:9 a=CjuIK1q_8ugA:10
 a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: vYg5DL_gZy-nABc7UTKblve1fRLf-4_M
X-Proofpoint-ORIG-GUID: vYg5DL_gZy-nABc7UTKblve1fRLf-4_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070117

On Fri, Nov 07, 2025 at 08:56:12PM +0800, kernel test robot wrote:
> Hi,
> 
> Thanks for your patch.
> 
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
> 
> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> 
> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> Subject: [PATCH v2 1/1] Bluetooth: btusb: add new custom firmwares
> Link: https://lore.kernel.org/stable/20251107125405.1632663-2-quic_shuaz%40quicinc.com

Shuai, why are you sending a patch which is not a fix for inclusion into
the stable tree? Why do you cc:stable in your headers? Do you understand
what stable kernels are for?

-- 
With best wishes
Dmitry

