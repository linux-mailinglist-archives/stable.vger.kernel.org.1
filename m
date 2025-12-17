Return-Path: <stable+bounces-202876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF218CC8E85
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 17:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 650E8314F013
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF08A3644DC;
	Wed, 17 Dec 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lbF3bc9m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FIuqTkvY"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0383644BB
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765989556; cv=none; b=gQvtAXtqQydpEUcJa98QIQlnmVrhYEQBBCyDHmj+cqtdT7u3qH8158o5V9p1g014HahpfGnCWORpMPx6Nd6coZOa4qDYwh/3nYG6Y14w4D2IOjhSlOSvBmYRLhZzIUR2OsEC5avPQv656THC0ZnoEISQJBFRasKWVO5IfK1ZaGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765989556; c=relaxed/simple;
	bh=soiyuErOHrQWwGcRoQLZMYPjUB61b2Oe1ux0JFTmlog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0V6Hutymmdj3rLHpzoxudpQeoDET7KskBPw0bfgYZAXwYTxqsplBjEb3zOWKJ1Ubv0YF9Mu73Iag8PSsK37ZdN12XYQRZRu+cuwVqHK4tLdDY9TKeolMXGqogrDxpw6uuJAuuufnJJl2VnQFAWavZFyxrdDd1chDfSluZhsJo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lbF3bc9m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FIuqTkvY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCKwOH2674092
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 16:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	amJpM2YHEkng7+w0/TWKpsNMkdbaFFgaot8SL7gZo7E=; b=lbF3bc9myFvJpVST
	8ayIrzZDBIQXtYIiian4hz/ciOn732Pm3YRJ+lQYzblSQagUnAZQUHthqibAq2/G
	zZPx397b5eISkM9n6jlNlGUDKR1NA6hc0zn1SKrqOkewj0n85AH/uJV1dREOM3X6
	5Z5kPO5dAzD/aWzkP19xaEzgOEwwQPEgYLj5KSHfnJfRCYjK+JLtDe0pfNTlnI0g
	9YnYfRW3u4xIQlWY0eICNlr/OuH3sWjchKtp6iE5RQOlLglcK4QRugOa9GK68sva
	ICCDiVg+QCHMaQrfJj87jrqjcV3F8VZ/xhAr1qKEgmgYpkLdInKqhL7QDCUATgT/
	2cVbyg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3myj2dw5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 16:39:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edb6a94873so109193621cf.0
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 08:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765989553; x=1766594353; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=amJpM2YHEkng7+w0/TWKpsNMkdbaFFgaot8SL7gZo7E=;
        b=FIuqTkvYgIe/11K98YpyE81h116WMPQNKZ+C3eVNHX03ukdInnIYpK5fz1+dLDsPX9
         PGu2ln5b3ev9EMeLCHRfzCE1mHjYix1GTWvk6gQQD46uP6XIeayu6ycjAGMQmfLOOXFy
         vcizSsGJ5j+Qy2AuhrzvnzmGWh/Tnr34mQ7zdSBVWdgyn6njw4dTviLk2NtkMfDbMC97
         rQVbZlj3NGK62SaYVmXQEAxGMGk8mLI5pVxyDLkI62gyUkoKQYY4AxNqb7b9Y8pRrOjk
         +bX4andzNE1HBEQzVW+jrjYSeJzMaOcArRpDJBh18xjta+AD8VM9FVcI8ektxz1OOhou
         BPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765989553; x=1766594353;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amJpM2YHEkng7+w0/TWKpsNMkdbaFFgaot8SL7gZo7E=;
        b=Brxfa08GTX80GRyrHGPdjnYzukl0wVPXruTc6EvmEbpj9jk1jeChXgRzpdJJaW+vDI
         OQjEAiFi0CWfRNa0vhrPnvsK4vf3NHmEj598TYQVQlqEavGvWYum8lFFO7UBovUWsmZX
         mh+bxKOVWGtXqbFozlAOKeDX7IdH4sYlmcVkucGq+Au3ZDvknwkqQ6Z4UZZy/hiCqoMg
         HbEPUxGWzEb23/gMr+W4ZeB+RS0atWHNt5NfeW2GyF1fXmks0tKWUiwzBxoK53pXsqQJ
         uFocvPeGf8U7hkFieo8H7ej1s++xFV4D7JC1oZxnFAAwbpPgCwXPsR4nbHstx1+UACVd
         Lp6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW70StCq59fF/cdkWnV4WcDz83uskgBeNeJ1mMMc2OjGCg0u5vpQbSUf+1/E003OJ6Zf2MGSB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy/AldUQ4bpTAh2Uv7UFUBtUgMeJzBgoV1imDcy2ky33I2f4Lh
	QqcG2R7qZEzFO57C5x5EXUvFyaCDVMETHale4eeDYMZ0J7nbz4Y5thtSVT1xO/ZC85X3qHEB3cX
	t+0nBnXGRsMQyDxfgf3fsBsQzNpIOAG9GsZEE7WU6XqmNZ2H1p94Sksvifis=
X-Gm-Gg: AY/fxX6H35Z4nwWcPZjdMZoNCmU/y6OqsMT19zR7AkOCOcxgGS8mRAaPLo8yxC3LXKf
	5hCP7yn9+hVD2apR9Pd5rOT0W6gSHmBwY17yiHALG2uEKcv++WsLKHGNpL6i1ICGALEQZTCHuBw
	pWpEHNCgD28IHENWG6HgKwQOZLU7WHCYLdV4DIGHdFGWhGq3NB6LxJIyO64Ywr5ImXvu9IkLPXO
	Ytlk6aqzGAl4woAtjPGy086a0+PksrBG5yWc5jC4AKBNfk6/knNG5vF6ZJbmjNeOCiBApnqXrBJ
	JkYKgLJKtkOnrAKR6BFQHnG30vrN5o/f2Tako4wklIjilPEvL8Kdza8bDi/Q8M6YxK0S8Fn4I41
	B5y3Jeuzc6kgF0vp/o6zDaCoueDi2dzX9aql1A8EmQsSX2wh++KK6IThp2axHAosKTrVMhWhFat
	lgw2T8Gq8KEN+ovvnPps9fZOo=
X-Received: by 2002:ac8:7d0a:0:b0:4eb:a4fc:6095 with SMTP id d75a77b69052e-4f1d05effbbmr244284541cf.68.1765989553167;
        Wed, 17 Dec 2025 08:39:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IET9aFYsiEVU6hfPco0LfnWypGzAaPMZ2Xjfeyk9H1vv7maax1IIK3NhIxBm4nPZQHJExoDUA==
X-Received: by 2002:ac8:7d0a:0:b0:4eb:a4fc:6095 with SMTP id d75a77b69052e-4f1d05effbbmr244284051cf.68.1765989552685;
        Wed, 17 Dec 2025 08:39:12 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da1a332sm2511839e87.29.2025.12.17.08.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:39:10 -0800 (PST)
Date: Wed, 17 Dec 2025 18:39:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Christopher Obbard <christopher.obbard@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] Revert "clk: qcom: cpu-8996: simplify the
 cpu_clk_notifier_cb"
Message-ID: <e2eg3zk2sc7pzzlybf6wlauw7fsks3oe6jy3wvbxkgicbo3s2g@tks2pgigtbza>
References: <20251202-wip-obbardc-qcom-msm8096-clk-cpu-fix-downclock-v1-1-90208427e6b1@linaro.org>
 <8d769fb3-cd2a-492c-8aa3-064ebbc5eee4@oss.qualcomm.com>
 <CACr-zFD_Nd=r1Giu2A0h9GHgh-GYPbT1PrwBq7n7JN2AWkXMrw@mail.gmail.com>
 <CACr-zFA=4_wye-uf3NP6bOGTnV7_Cz3-S3eM_TYrg=HDShbkKg@mail.gmail.com>
 <f902ebd4-4b4a-47c3-afd7-2018facdaad6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f902ebd4-4b4a-47c3-afd7-2018facdaad6@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEzMSBTYWx0ZWRfX1gi5DcBypVqx
 PcatJd21NYvBHCWX0oK7S/L9wK6bfyTu9fg9ua2a5OwyUzZ2540BkXf3kdWYIY2TOSrdwgewnZp
 vxfDFzzhsqrr3P9leqsKCNXWXqXVniNcrpeTshJTUiP947r3ymom9oeRXYgRXr0yC+cHmtJLqEg
 9nOiDMOAb8ZfixHT/FdNUjGiK2AaGZft04f2sMt8Bd0xvuXM8CCF18/2MGkK6OIpL6JG0y9UZaQ
 2KO2hxXVcTledpY/u4cNvYaQZk6DfvW74OCzhehBVO5cmcc5T/kF899X+Vd4NN9DNkCqVj1L6US
 MsUYc5bD8oq/I1ySZRtqiIKOSkM4+vsNs3zUw3T5I93bfi+tibVinGl2IPm17ruG7nQTcV+NcSM
 zhui8mm2cw+SCVKAR+Q5tLeMR94yjg==
X-Proofpoint-ORIG-GUID: 3DCg9UQvL6QzdBCrZU-HIfZ3FVVyII2R
X-Authority-Analysis: v=2.4 cv=CtOys34D c=1 sm=1 tr=0 ts=6942dcb2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=exSi5k-EmiMfGQjk_D4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 3DCg9UQvL6QzdBCrZU-HIfZ3FVVyII2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170131

On Wed, Dec 17, 2025 at 01:22:59PM +0100, Konrad Dybcio wrote:
> On 12/14/25 8:26 PM, Christopher Obbard wrote:
> > Hi Konrad,
> > 
> > On Mon, 8 Dec 2025 at 22:36, Christopher Obbard
> > <christopher.obbard@linaro.org> wrote:
> >> Apologies for the late response, I was in the process of setting some
> >> more msm8096 boards up again in my new workspace to test this
> >> properly.
> >>
> >>
> >>> It may be that your board really has a MSM/APQ8x96*SG* which is another
> >>> name for the PRO SKU, which happens to have a 2 times wider divider, try
> >>>
> >>> `cat /sys/bus/soc/devices/soc0/soc_id`
> >>
> >> I read the soc_id from both of the msm8096 boards I have:
> >>
> >> Open-Q™ 820 µSOM Development Kit (APQ8096)
> >> ```
> >> $ cat /sys/bus/soc/devices/soc0/soc_id
> >> 291
> >> ```
> >> (FWIW this board is not in mainline yet; but boots with a DT similar
> >> enough to the db820c. I have a patch in my upstream backlog enabling
> >> that board; watch this space)
> >>
> >> DragonBoard™ 820c (APQ8096)
> >> ```
> >> $ cat /sys/bus/soc/devices/soc0/soc_id
> >> 291
> >> ```
> > 
> > Sorry to nag, but are you able to look into this soc_id and see if
> > it's the PRO SKU ?
> 
> No, it's the "normal" one
> 
> Maybe Dmitry would know a little more what's going on

Unfortunately, no.

Maybe, the best option would be to really land the revert.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

