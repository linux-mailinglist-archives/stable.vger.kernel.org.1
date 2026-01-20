Return-Path: <stable+bounces-210467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB43D3C471
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 11:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A97F16C241B
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 09:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631493D6692;
	Tue, 20 Jan 2026 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pu1b26T5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SBHG19SD"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3413C3D648E
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901307; cv=none; b=NN27bdK/PE9NGqZE4wGg0ahPUumi92XssZXJ4KVSe01Ox+T8CveS8qTcASLg5gGanROIN2FpgT7GfIBKu5vJ/HdSJFBx+T3osG1VrTv8/wACY6NP0X6/W5zzXMtXgQdTJJGVkOZrHK0C2IRb9/JwTkL4oIUKXqSrrxe/Y7ktfvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901307; c=relaxed/simple;
	bh=vEFWiIISpy/xK8sVJEKh77nQoJhAvhtGHmAuoDTfmiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irjEGjXm7kaIC8y0KVG1MNmIafY5gNTBtB+cr2VZjOBcOnJQGC4XGGa//9HYSuZlk1R2x6fXTNlWV61c77Y+GTFER+dFzLSoWYsOMQgt8Kz0ZBHlM6A6YVzXJ4wuFa+diOBTwZZ4Y4PEe92SM3auikr6APY0qYwSS4Y74XSho90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pu1b26T5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SBHG19SD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K99qEE3256421
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 09:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LDuluuRcOj3oAhAhMzTa0gmYjYkM3opUPACJ58+MEtE=; b=Pu1b26T5tSG6utZ2
	TaoC6xael9Gy22SPMpmzawqJx+4/39VDfJHLYvSLMAQrSagsK4Pblp0WGz4aiNGl
	+DgxtKBDcL42TK0WFMIcxiXxW4bOcu+q+1aqE6ExVzzc5MxMYpl00CqRWJ3wOJoa
	GoVpmDDxISgc0MFeVzYVPWOZ46CglGgnQTZo4u3vtW+uqsJPAZYCHrg80uBYOWl6
	KXfv6G+yRDDe7PH7i7DdGdgGouYtQbjfbeDioAN0IO3GKVUBB2DCMxqXD38wVUqQ
	wTf3DyWZEiApifjFg3qJUVIr/rgxpLBYMbzntJ/PAj0Hzc4/MpYfzW3E4uLIfMLL
	qIL4/g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt6u7r1qn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 09:28:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89460b02227so14183566d6.3
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 01:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768901302; x=1769506102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LDuluuRcOj3oAhAhMzTa0gmYjYkM3opUPACJ58+MEtE=;
        b=SBHG19SDJAJeAnTVYGvU0ZiIHe/HOKo3TPkmuCZRiVWTtZxbIEvgbAuuWgTIR044Z9
         FQMSXgmjPWYPyk1kyIMfL6N1vtKhl1T/Xi+BwiSvpF0RPZNVSEWcW26rpqCr0BVaDYQW
         tYQecU6uYsOkpyu233iMseU+/to1rz3DxCKCaIcL2HcX4WunbO2yUax7AX2nxYpYdfwT
         1R1+RdHP3Ner2AtbpRhLrW+afoQP19SZfkSM9dAoQ+mCPbB+t+gLHO/uU2p2QfIsm3h4
         oG3ylpj5dB2F6fVA9nybLimh3pWKS98hH61+jgxSORrbJ24kjoNeNZ3CbYgaWT6vWGsh
         or1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901302; x=1769506102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDuluuRcOj3oAhAhMzTa0gmYjYkM3opUPACJ58+MEtE=;
        b=vOzNnuwNUj8Uw4OL6oe7w3Ad0Tk48tlS2zP73PZm4WmYaRCixTz2/4erk/RSSjex+r
         wAJ08cItnhR2oTg77F6w5Y6HrNeKJAN1uabg5RRSsprK3dVrfCxCzvxx39/+GNFfWQAE
         jsUsgMFESHewgx6QSrgkCau3TUhTtP28Xqi1c6BmJaavZWs9moeFjJBlnbbPFOeNGrcO
         jK/0+XbIemr1VmIMaHNxySIvN7dEGqvdcocdISPpltmgHMsjYHGX1eZjzNEpoOeyxF3d
         bLZGNbIBVn8iUGIuWNx6kLvak604NWBtvO3yEitJDdqkCW0HpleLuTFp5Z4G/p/qKHuF
         OQBA==
X-Forwarded-Encrypted: i=1; AJvYcCX5UZpMK8cbvJlz4FIVqjF2buafafxNHn6AkZCFV5CwD919kmHs4inIwAp/PrMPpuyKI+Mi8oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzniXLsWrqFXVjgvEXS2f8jNnXIfz18BASPwr+joI4ikaY6Xzte
	/m6i9shJUMc/By+/05HaOJ+P+YBuImc0Dnyf0wDSyidJ4nQXqrIh3625Mc1oTuVSW+sgYxotQ+C
	WNntZAbEkuL7i6ZO+pFPjbrIVWiZ3rtwKq27jfa7sKyQ1TT+V1CgzfN4Mirc=
X-Gm-Gg: AZuq6aLKBeenIZQqgABU16sUr1YeR1s6MwTfP8PkDxzs9tHKz2rv9ZE4r51jFaaQ579
	fBZQlG5xiQRXvNlDSdMSm5ezTO/5fuTFUCHWZAhqU+sk3Em0pAeYalk8+gcZaw2BXuTG2dLdJTy
	sA8vOVoI6OxMO7nb7imRtZGK+DD/BXucQzCSRZtTE9k0PS8qyvlu/Seubn2DphBxbyLfZOHPc6K
	IW1X7uEgbmDzgrQB5WEV2ZpW636syMx/atrI7ncwa7bbaCjoJziAZUkYhNYF22JJ1c+m0tU+iOI
	dRJvEE0H0AesvutrisRdlrw2UnMjAg+rH1FiULeOn3eEV+Z72KwSoxFHLHndqjnhV8MywKc9RwR
	afFhC/Dsj3TXC+5FYJBtdgzNzXAtyqDNtRyAKZIKZhU1fCOcZko+chOCNHjzpEr0Dfk8lr14jIG
	gUfPK9t9I/hNGfoZpcFFHhvS8=
X-Received: by 2002:a05:6214:194f:b0:786:8f81:42f with SMTP id 6a1803df08f44-894638dca24mr16257476d6.39.1768901302415;
        Tue, 20 Jan 2026 01:28:22 -0800 (PST)
X-Received: by 2002:a05:6214:194f:b0:786:8f81:42f with SMTP id 6a1803df08f44-894638dca24mr16257396d6.39.1768901301998;
        Tue, 20 Jan 2026 01:28:21 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59bfce7da74sm3120178e87.40.2026.01.20.01.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:28:21 -0800 (PST)
Date: Tue, 20 Jan 2026 11:28:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v2] drm/msm/dp: Correct LeMans/Monaco DP phy
 Swing/Emphasis setting
Message-ID: <bq4usuzu7dl42ruduy4whbgnfamgnmyj7wuyd2oa472qet6tyv@pdku43m6e45x>
References: <20260119-klm_dpphy-v2-1-52252190940b@oss.qualcomm.com>
 <47skckagggxijdhinmmibtrd3dydixtj6pccrgjwyczs7bj2te@2rq2iprmzvyf>
 <749e716e-a6cb-4adb-8ffc-0d6f4c6d56c4@oss.qualcomm.com>
 <5ytgf7saw6yfvqzqmy4gtjygo4cx52vomi7mwswc7hgedzz3rb@eiqxiqs2cjmb>
 <8c63a77c-1676-461a-bfcf-55202e723718@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c63a77c-1676-461a-bfcf-55202e723718@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=P/w3RyAu c=1 sm=1 tr=0 ts=696f4ab7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JfrnYn6hAAAA:8 a=SNWZ2FZe9L-OGZU4zVUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA3OCBTYWx0ZWRfX4rJIkRRQyZAk
 F54qRhbzdx6cpaTX9XqYz6EI6Xe/LS4r/PV036+Fzjhxph+lyVFlKoHaI1X5GfFKRn8Fo6vdYuW
 mbN5S+FycZY+DGpUroIkgJxm85hgaum2/QYcncveZy7z+BaPCVVBEWqmFxfNqqvooNONmKFSMRv
 AJopD1M9+1Fg05yIzemah7pHSoTw30q9eiMjybp8kFoCmfvPg+2QycCltB1qipuKBJbcrwDng1b
 GtKeJteatLgxKE1PcVXe5KRUUEI+jLH5MIoeKBe6hOKP3pg+jh16ml92V7UBN2+suC5Srq+w+I6
 WIoG8LUqoNsQVegn1t5ve1s4+RY5E2ieicZ9vdju2/WLV7DLAW7Xff2Xb5nJR7kpn8XvVmsecG0
 JKvfDEBjzl1v9EGu44JXJqROP6G35Wrg43BF0bk12MAx13zVQwzwL0TTCFgv9lr8i0QBWcSDaQg
 7Ol7519Ct+WtR60iX0w==
X-Proofpoint-ORIG-GUID: JFh-PcfXs_f4DUAf-7v4DZEhekKj5c-8
X-Proofpoint-GUID: JFh-PcfXs_f4DUAf-7v4DZEhekKj5c-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200078

On Tue, Jan 20, 2026 at 03:56:10PM +0800, Yongxing Mou wrote:
> 
> 
> On 1/20/2026 11:12 AM, Dmitry Baryshkov wrote:
> > On Tue, Jan 20, 2026 at 10:43:46AM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 1/19/2026 8:55 PM, Dmitry Baryshkov wrote:
> > > > On Mon, Jan 19, 2026 at 08:37:20PM +0800, Yongxing Mou wrote:
> > > > > Currently, the LeMans/Monaco devices and their derivative platforms
> > > > > operate in DP mode rather than eDP mode. Per the PHY HPG, the Swing and
> > > > > Emphasis settings need to be corrected to the proper values.
> > > > 
> > > > No, they need to be configured dynamically. I wrote earlier that the
> > > > driver needs refactoring.
> > > > 
> > > Hi, Dmitry. I plan to submit them in this order: this patch → LDO patch →
> > > refactor.
> > > Since the refactor involves more platforms and may take some time, I’d like
> > > to get this patch merged first.
> > 
> > This patch is incorrect. It trades working on some platforms (DP) vs
> > working of someo ther platforms (eDP). I don't think it is a proper fix
> > for any problem.
> > 
> Got it.. will post refactor series.

Thanks! I don't see a good way to fix your issue without restructuring
the driver.

Note, the driver has to support both older DT (which used separate -edp
and -dp compats) and the current one.

> > > > > 
> > > > > This will help achieve successful link training on some dongles.
> > > > > 
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 3f12bf16213c ("phy: qcom: edp: Add support for eDP PHY on SA8775P")
> > > > > Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > - Separate the LDO change out.[Konrad][Dmitry]
> > > > > - Modify the commit message.[Dmitry]
> > > > > - Link to v1: https://lore.kernel.org/r/20260109-klm_dpphy-v1-1-a6b6abe382de@oss.qualcomm.com
> > > > > ---
> > > > >    drivers/phy/qualcomm/phy-qcom-edp.c | 23 ++++++++++++++++++++++-
> > > > >    1 file changed, 22 insertions(+), 1 deletion(-)
> > > > > 
> > > > 
> > > 
> > > 
> > > -- 
> > > linux-phy mailing list
> > > linux-phy@lists.infradead.org
> > > https://lists.infradead.org/mailman/listinfo/linux-phy
> > 
> 

-- 
With best wishes
Dmitry

