Return-Path: <stable+bounces-210425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D67ED3BDDE
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 04:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAC144E30BC
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 03:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A780C3164C5;
	Tue, 20 Jan 2026 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c0/kiv4j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NrTzu42a"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10743315D31
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 03:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768878771; cv=none; b=GWv8YryBcpmiLadWvqnp4PQqmCppyHFm9AjSr2A5bpbWtCJP7oF7wUSo9a/nG3DRxK7O0rhQ11FGxL5p0cKuA63cHpSKNdPtFn72toy2BybVdFa9AJr5gIP4Ramn7ZDv6XbYVIRxnKNfvSmxocO5hrMWKlLQXVJv4wjIph6WnTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768878771; c=relaxed/simple;
	bh=MTjNB7ZJIahkgtov3KyJ+R1+wFsY+oYdvJjDcs1fkH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDB+pPvg99MNmMS6cNTgKwDUU+ViUuxgeKZZnnBsigI8k8bniDfKBaEiKrDE8pkbL5utJgWBfn/Pag/ZScNhxd/2PZCroIP3jjpWNZaUUl77J8iJj/jtXf0FzzQ28l7FyjFys0hjjoct0oHiiUOD5E56VCNEwFaKZFN5XFE8HzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c0/kiv4j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NrTzu42a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K17xYU3365640
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 03:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dN6GrBjm9j5/FKfXJYdfLqyzUS7aQVthNgblFux+x3c=; b=c0/kiv4jXP4i9kD8
	u3m1KHN1KVFyQJV8+vuAQ+GeueFvEBfVcSN2cF/iTDMOGBZ+rQjjtPeP5v90gC7Y
	gpfLTI7gkr0mkZmLxboVFI7P6Lyhuf2qVO9UgCQiT5gC+nDF1HwO5OCRu+5VbVyJ
	CmDWn1DObZDvuvv426G0ZOuR/c/rbm4+gGDqEFzYyhf07v02r5jN0zENom9q3B2F
	NKeDyvRoYMZHSw+0kMwABAUzUAlnUR82BqcSXOD+oq2eQJ7mUWC3VN4nmWSpRf+9
	oymdFzhvDZCkEuniHlqCR6a0r0hfx/J9xXKJdzD1iqoQAFZrckCq+ouJdmiEau2w
	2JM61w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsysb094c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 03:12:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c530da0691so1065446385a.3
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 19:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768878768; x=1769483568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dN6GrBjm9j5/FKfXJYdfLqyzUS7aQVthNgblFux+x3c=;
        b=NrTzu42a+Z1vSopczYjJpkD4vSxOcQETnV+tWpWBaF98ejuaB66zDMAUJX+HB2bd+o
         3YJi0HWNw++qHwdKQlhOQk1ip7rWjacy8dyqZADtbGi/znp/0EaHfz20H2g+16j57rDm
         5W8D8XgdpwK6xElF2W4ek8HvU0puV3ofGCFokXKEdINZqcKgft27w1Pggcyg+QOyLrIM
         PW8lCDRQbu716qTaRM7yFHg3q8IRwnzuSojvXv1/FQaOuO7I2meJPRGenybZVprqx5nb
         eAFoO/p4mZ5+MbaBkMQv7Ka3SAuFgbCVsbn43+Dusn/msEBuo/jSfMC1tkPrxjrDmPWW
         vWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768878768; x=1769483568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dN6GrBjm9j5/FKfXJYdfLqyzUS7aQVthNgblFux+x3c=;
        b=ZgkD/VCmiHZYKHH94PaTbN6ZNqZdTl8vwS3porhr4gLstDG6yhnGasZDJQ3layIxYr
         xzFVnYJeOyVV3w6oXRY+4wTBFILhPb1iUxF9mrR6nt/7xvn6jYbSEo9oUEATv219f+Op
         fMTQm312+M2LC+7P2UPUmFE/mmsQXfewceYra72gmmN/kG2V/zqTE1bfkIC34PCp8Szv
         4fxtLgR16s4FVvABiuLjZQsliGS/eMrt/QN08aDXMeikoKYmPygDj2O9xPmGP5iVBQ7c
         /H3ZKB+v2dyn6EAjqV4tlPczvN+vCawUYZ4+tJrIZ4e2D8npeNbLYzKX9fC7rql4YVxF
         NsAg==
X-Forwarded-Encrypted: i=1; AJvYcCWKtNAFCKN00b2Voo6I5XX6Eo37FjXkWaQjbGb5HIYf7PnyMoAEW+mx6OwEmeJgZsAm7a9qz/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Od1wTr6esAfzH4++8o9FAIw4ghmC8lJJdaynRYVBjHPigw8a
	GY59cdg3cOjd303R3B+kEXWXBUPjOrQvvGX5zsxcJJyCb4CENWagyjh4XAUJ2NBY5iRierFKqbP
	DS4S4zHDoHrDMx6R4Ll5PMLGsEsrdQmdo7WWtp9LOScbpZZTtj2/+XsEIhIE=
X-Gm-Gg: AY/fxX60LP635RPUog5y/xMi2wA5WF8hBSI869kKOeViRD6wO1NCmysAMPNUVNOTnE1
	+D0eaymWrC1GCAyuwBbyzTFcFbrrXEAPJW9t/XxDey7BR2K/LF923PjHjNAkgJiwNdSPEwjKxPf
	523r3t9SdflKigegsymWjkmpTI3T8DhkBLF2SSvM5gflYLoUu0uKVkqURD8YJzFAYkyHYO68kl3
	gXddIXU4Mj8DtKklgodbwZoaHLQquqjad9S4S7ch3aFNX1XS6alakMoTomvTBYTMS8lhph9CGvj
	0K7/tRNFj1u4DK4yhUDoCBabXO5b/f2p8MebIHS9ZIOPK0RdBsA3OATWwP9+vqcGJ0KP6yTqwU7
	iP5lXHgtQTUCdGctbVxcAUSmSJsvjmZySaveUYXkDRnpnCcX11H7XbwjglTgLOS5RY+APmWVUMV
	KKah/5qJnylnARR5MgF1HFXlU=
X-Received: by 2002:a05:620a:280b:b0:8a4:6ac1:aeb with SMTP id af79cd13be357-8c6a69499a1mr1727921785a.74.1768878767801;
        Mon, 19 Jan 2026 19:12:47 -0800 (PST)
X-Received: by 2002:a05:620a:280b:b0:8a4:6ac1:aeb with SMTP id af79cd13be357-8c6a69499a1mr1727920085a.74.1768878767336;
        Mon, 19 Jan 2026 19:12:47 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf39c453sm3825512e87.76.2026.01.19.19.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 19:12:45 -0800 (PST)
Date: Tue, 20 Jan 2026 05:12:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v2] drm/msm/dp: Correct LeMans/Monaco DP phy
 Swing/Emphasis setting
Message-ID: <5ytgf7saw6yfvqzqmy4gtjygo4cx52vomi7mwswc7hgedzz3rb@eiqxiqs2cjmb>
References: <20260119-klm_dpphy-v2-1-52252190940b@oss.qualcomm.com>
 <47skckagggxijdhinmmibtrd3dydixtj6pccrgjwyczs7bj2te@2rq2iprmzvyf>
 <749e716e-a6cb-4adb-8ffc-0d6f4c6d56c4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <749e716e-a6cb-4adb-8ffc-0d6f4c6d56c4@oss.qualcomm.com>
X-Proofpoint-GUID: Y_nARamRjBtib-_VoLNc0tt8mlZFiP56
X-Authority-Analysis: v=2.4 cv=XJ89iAhE c=1 sm=1 tr=0 ts=696ef2b1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JfrnYn6hAAAA:8 a=fMMN0vGI0iEnj70k6hcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: Y_nARamRjBtib-_VoLNc0tt8mlZFiP56
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAyNCBTYWx0ZWRfX/2QIdT/XWAbW
 Gz+rROt11JiTLO6YtDkteQZQByV1jI3yryrfZofVzomeQ27lYG6YEimjTyqhpdpaxiv0PRuYZsE
 T/IiDSQfrPR+GxZ6vf8R7g2tJ+sTXwMvZHJXcCH6Asg81+FOtpTRB3850814GeBukHfZqr8mYhj
 AjY3UewHqKBM4uq7xiOK3vyFMDEEOR/uMQI4d80kS5Sr6F5zMDF9pvOxnTFVtFhVKwO2M/mpmvb
 xDxZxD5ah5UBBwt4qOGDqMwqHzgZirjBod0NAIYH0lk62RdqXOXJJ1L/UZ/lz3SdyaS/MVR6pzy
 B6HGNZDmTWUl6iSBb+s9zoYjEa/BJjewv7P6rINHI8c5bCAkckf7cr5JUEg0EFryyx9tHZDkz/D
 ZSSsMTh82xXU0SRxUavm47F1DjuFuffEVy0w9/yz/aAJJ7LwhUrZWjuFFxV6Yj7Sk9MbJQj/j63
 vLMTR4oX3p7/L/21law==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200024

On Tue, Jan 20, 2026 at 10:43:46AM +0800, Yongxing Mou wrote:
> 
> 
> On 1/19/2026 8:55 PM, Dmitry Baryshkov wrote:
> > On Mon, Jan 19, 2026 at 08:37:20PM +0800, Yongxing Mou wrote:
> > > Currently, the LeMans/Monaco devices and their derivative platforms
> > > operate in DP mode rather than eDP mode. Per the PHY HPG, the Swing and
> > > Emphasis settings need to be corrected to the proper values.
> > 
> > No, they need to be configured dynamically. I wrote earlier that the
> > driver needs refactoring.
> > 
> Hi, Dmitry. I plan to submit them in this order: this patch → LDO patch →
> refactor.
> Since the refactor involves more platforms and may take some time, I’d like
> to get this patch merged first.

This patch is incorrect. It trades working on some platforms (DP) vs
working of someo ther platforms (eDP). I don't think it is a proper fix
for any problem.

> > > 
> > > This will help achieve successful link training on some dongles.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: 3f12bf16213c ("phy: qcom: edp: Add support for eDP PHY on SA8775P")
> > > Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > > Changes in v2:
> > > - Separate the LDO change out.[Konrad][Dmitry]
> > > - Modify the commit message.[Dmitry]
> > > - Link to v1: https://lore.kernel.org/r/20260109-klm_dpphy-v1-1-a6b6abe382de@oss.qualcomm.com
> > > ---
> > >   drivers/phy/qualcomm/phy-qcom-edp.c | 23 ++++++++++++++++++++++-
> > >   1 file changed, 22 insertions(+), 1 deletion(-)
> > > 
> > 
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

