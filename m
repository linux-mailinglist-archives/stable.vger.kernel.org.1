Return-Path: <stable+bounces-115067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18FAA32B41
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 17:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBE31883586
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9FF212B06;
	Wed, 12 Feb 2025 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SgZcGpe9"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AE921127F
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376816; cv=none; b=hITBjddQropTPZmXk5YtLAoIYXX07o4NenFprsKFQSiISCfilaaI3l8VDaVrL+2a6YWnVLs49+dqzZ51muhKxLHG8AhPP+MeC4ANmovS5xfjHdtv9L8W6U8eWfIVtZSd2y7AK8wOCdoCRGppk07ORnZGR4yG6xp6aerngFv612E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376816; c=relaxed/simple;
	bh=80ekF0izsJI++qv/1xH74L7dJLq+6w8MrPpsyjQMmOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJNIRO03W68kDe1TJAYhhTluSlohAqHriL+lgj71mLWifey/HqEcA6lomGRcEry5UTFnnw1JiLMUaGKvFTfSwc41BMBizfKoBOvjmYQ4xGTMdyyg/ga2zR47gyIsEVcgF3xIA1t4HefCZLfirlF9FdO8BE6yG6S7ECvWhj3Bnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SgZcGpe9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C9Ysut011426
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 16:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=m6Zh2vn1ljsfh172oD9RbBFC
	E7vn6VZybrnfut1DXnw=; b=SgZcGpe9OU5Tp8C7tQhPBW32rgA6otFDUSaDaaoV
	2HIeUUIf1rZPt0JlwutaztR3Zk/LZUhzeBej2X5S24o0LgqfZd1a5uIqU+u9zPhA
	YAtgU8kdEsw0CSmraOVsttw73Fa+pUpfClZoAzlnYBKdTTQVqHAL+TWULSbVMT/a
	kr/+PHCwdpEMoywHRxMiO0dC+TVbY/X05h1TCBZ+LDXzNBQbq8KKgl55lwtHA/8d
	f9queqkVj4UCdRa+yrlQAnYWnJkosIjJCLVWkf+b2dDldFc51Q/+H3+xG/fvTwIz
	CIN4SR3K+5wxB0xzVvujWKxAHv3E5YV/BgPMQDRkFfUTVw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qxv3we7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 16:13:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fbfa786aa4so1817717a91.0
        for <stable@vger.kernel.org>; Wed, 12 Feb 2025 08:13:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739376813; x=1739981613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6Zh2vn1ljsfh172oD9RbBFCE7vn6VZybrnfut1DXnw=;
        b=eBOXDRgEyKYp+TlLs9nh8xNYWiZ58gcYQiBi0Y+0oUoWJksdWG3h9GJOKgW5x4ma2a
         k4BmEM1uKfKUXt+xRHhoRvvKXhlp4tlyF7wHJ12glIj3EQxql4mukyvdvAC72OJHozw9
         IDgZuk5Zv/Zx3clySA+BGO1JmvGFPC4DaoAir0WyGQoap9p/+gaHK5FDk9btSn0klmuh
         peGyu4ULPh5/1Tcpkvj6Rr1heo5MwyOAbWlYcdAHyOtgA4m9qzufDkXgl1rNCRUXAnHn
         fYXPWH0OACIn2bbfLCg4t7lDyjJW/QJ2q7iYVCVDW9hoRPmp4IAPGpXT7F1OdsbhmJCo
         aYBA==
X-Forwarded-Encrypted: i=1; AJvYcCUiKTIWRUl3EJAU/gy2QbbitOA5aSnVo4V7QsiTXlbpkGGxn/Id9aTRXKbRv0mBWmAHasoqrf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fO9ynjLu4c21eQcS498F99++ZM2+GwyE95LKCa3RvFApJkDb
	SARjQOtF7hxQaEhdzmtlfAPZToJ9JQLEi6pfKFKQj7u9VBmCgl2RLzrpUr5/6YKqOjockUMdCvs
	wNnzcK/eow/VarwBEI9Oq1HFsxtxJovCTYjyzJLd1WgyJvMBjSpLqmXo=
X-Gm-Gg: ASbGncupmfpKuq2sg9y9ZauBXAdliQyGgKshjJrmEmT7M76xBR28oKU3gJ2u7prjTRX
	jDQBYmZTEKY355ve76jVhxsZxJdOkkaOzEUokjle7ELsOsYE4+s8iy374MCZY+TkVEBpt/XJLLA
	ZN6ba2lT66rHVk5ANSQmNBMHbIPm/ULGBMgGbmROqwFToBZt9N/AjqEK+VFLNNc6P9aohgq+Lt0
	njfrtdTemL/MjeWBtoZ088STVPnDtoygoGxV3cjkVi2a+WleIUhJnIRLR0wMyPEZpXPqQacqQlF
	goiBA0yw3gOfAONFZ+neFR81qlUhgCGU
X-Received: by 2002:a17:90b:1f81:b0:2fa:4926:d18d with SMTP id 98e67ed59e1d1-2faa0982d50mr13003884a91.13.1739376812656;
        Wed, 12 Feb 2025 08:13:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXS9GeexUtgjKmnddattp7uEgbRq+tXnjW66DhGPRPBEcNWpdaDXy+oRX9gNRBnjFd6OU6fA==
X-Received: by 2002:a17:90b:1f81:b0:2fa:4926:d18d with SMTP id 98e67ed59e1d1-2faa0982d50mr13003843a91.13.1739376812212;
        Wed, 12 Feb 2025 08:13:32 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2faa4aeb7cbsm2264432a91.0.2025.02.12.08.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:13:28 -0800 (PST)
Date: Wed, 12 Feb 2025 21:43:11 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Saranya R <quic_sarar@quicinc.com>,
        Frank Oltmanns <frank@oltmanns.dev>
Subject: Re: [PATCH v2] soc: qcom: pdr: Fix the potential deadlock
Message-ID: <Z6zIl/6s2XfSvm71@hu-mojha-hyd.qualcomm.com>
References: <20250129155544.1864854-1-mukesh.ojha@oss.qualcomm.com>
 <nqsuml3jcblwkp6mcriiekfiz5wlxjypooiygvgd5fjtmfnvdc@zfoaolcjecpl>
 <Z6nE0kxF2ipItB2r@hu-mojha-hyd.qualcomm.com>
 <Z6nKOz97Neb1zZOa@hovoldconsulting.com>
 <Z6uDv3c3DkmgumnM@hu-mojha-hyd.qualcomm.com>
 <Z6xr3ylNSC6iYf-C@hovoldconsulting.com>
 <Z6x_GJg92ddzoRwQ@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6x_GJg92ddzoRwQ@hovoldconsulting.com>
X-Proofpoint-GUID: 6XlCsdTQmE4O1LXOsGScXAi_PNR1oCsF
X-Proofpoint-ORIG-GUID: 6XlCsdTQmE4O1LXOsGScXAi_PNR1oCsF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502120120

On Wed, Feb 12, 2025 at 11:59:36AM +0100, Johan Hovold wrote:
> On Wed, Feb 12, 2025 at 10:37:35AM +0100, Johan Hovold wrote:
> > On Tue, Feb 11, 2025 at 10:37:11PM +0530, Mukesh Ojha wrote:
> > > On Mon, Feb 10, 2025 at 10:43:23AM +0100, Johan Hovold wrote:
> 
> > > > A Link tag to my report would be good to have as well if this fixes the
> > > > audio regression.
> > > 
> > > I see this is somehow matching the logs you have reported, but this deadlock
> > > is there from the very first day of pdr_interface driver.
> > > 
> > > [   14.565059] PDR: avs/audio get domain list txn wait failed: -110
> > > [   14.571943] PDR: service lookup for avs/audio failed: -110
> > 
> > Yes, but using the in-kernel pd-mapper has exposed a number of existing
> > bugs since it changes the timing of events enough to make it easier to
> > hit them.
> > 
> > The audio regression is a very real regression for users of Snapdragon
> > based laptops like, for example, the Lenovo Yoga Slim 7x.
> > 
> > If Bjorn has confirmed that this is the same issue (I can try to
> > instrument the code based on your analysis to confirm this too), then I
> > think it would be good to mention this in the commit message and link to
> > the report, for example:
> > 
> > 	This specifically also fixes an audio regression when using the
> > 	in-kernel pd-mapper as that makes it easier to hit this race. [1]
> > 
> > 	Link: https://lore.kernel.org/lkml/Zqet8iInnDhnxkT9@hovoldconsulting.com/ # [1]
> > 
> > or similar.
> 
> I can confirm that audio regression with the in-kernel pd-mapper appears
> to be caused by the race that this patch fixes.
> 
> If I insert a short (100-200 ms) sleep before taking the list lock in
> pdr_locator_new_server() to increase the race window, I see the audio
> service failing to register on both the X1E CRD and Lenovo ThinkPad
> X13s:
> 
> [   11.118557] pdr_add_lookup - tms/servreg / msm/adsp/charger_pd
> [   11.443632] pdr_locator_new_server
> [   11.558122] pdr_locator_new_server - taking list lock
> [   11.563939] pdr_locator_new_server - releasing list lock
> [   11.582178] pdr_locator_work - taking list lock
> [   11.594468] pdr_locator_work - releasing list lock
> [   11.992018] pdr_add_lookup - avs/audio / msm/adsp/audio_pd
> [   11.992034] pdr_add_lookup - avs/audio / msm/adsp/audio_pd
> [   11.992224] pdr_locator_new_server
>     < 100 ms sleep inserted before taking lock in pdr_locator_new_server() >
> [   11.997937] pdr_locator_work - taking list lock
> [   12.093984] pdr_locator_new_server - taking list lock
> [   17.120169] PDR: avs/audio get domain list txn wait failed: -110
> [   17.127066] PDR: service lookup for avs/audio failed: -110
> [   17.132893] pdr_locator_work - releasing list lock
> [   17.139885] pdr_locator_new_server - releasing list lock
> 
> [ On the X13s, where I have not hit this issue with the in-kernel
>   pd-mapper, I had to make sure to insert the sleep only on the second
>   call, possibly because of interaction with the charger_pd registration
>   which happened closer to the audio registration. ]
> 
> Please add a comment and link to the audio regression report as I
> suggested above, and feel free to include my:
> 
> 	Tested-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Thanks for fixing this!

Thanks for putting extra effort in reproducing the issue and testing.

-Mukesh
> 
> Johan

