Return-Path: <stable+bounces-159135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0049CAEF68D
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 13:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348BB440BC5
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1FA272E74;
	Tue,  1 Jul 2025 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dIOPd/uU"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C19242D8C
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369391; cv=none; b=SrwjAtlWZGwSohajRCIyQxw2chutkU0vdscdCXsTYU5lSfjChZrb4X01tJn8KGMzFGVr5EvAfOk3D5IGHvPRr66a6lw68afKZ4bz7cDT6X0N0L7lmis0DH9zFOjB/VVPVAjL9Cy9EioPAzqgydOvBacWpYIc3SakJ7jWLybAeps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369391; c=relaxed/simple;
	bh=aecfqIgcgMS8NEZYswyAdEeWrhP/4nJk5uApShw52ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLBBnnsx1udJa/y4b/cFHQumd4MUxybhzpI8VczI61bVv4PUctmYwZiNsUqjhJ5ysXfn2StWQVY6ZgN5m5AEegun1a7iO+E4RqUzVEHOi51Z/DIAhH8P0KSL8iDRbTdCVDCiRuiSEEu1dMnp/7TtbPw0WMsd1SMJ+xJcicdzjHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dIOPd/uU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561A6xEH008169
	for <stable@vger.kernel.org>; Tue, 1 Jul 2025 11:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HeCUTIvo2J1PhAD2wDzz5Zb5
	XHzZC9YruSB6ZaOdH04=; b=dIOPd/uUrm1KFxuvaymajs9D5M53DEntgx/u9nzu
	yQbOgJ1n5XwxciyfA5G3aTNFJwP314unQHYkGGGdAd2w3e+YFUwp1wjNOe7yuQys
	mwPB4uMJCR242jdy9hjaWPvRRi/7p6yiSADi+3EY5WU6NGy+3RzQo+BRosJKQmfB
	pnKXC9sTCSedMq4zLhi5gKQcKVGxPaBYlNRuUn4U1OR0uGamvj0PlV0i//3ZYgv8
	pmDcdocRb1gQlxbUnmRD8SGB/B/LyXtUiQnI5c3Q73pNXKGJcZ/qUMduPtHsnaIN
	tCjbEZlJC3RBixAoY6Pa2Z9AegRiSw7Qf+r6oMe9TRNpeg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kkfmwcju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 01 Jul 2025 11:29:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7ceb5b5140eso816809285a.2
        for <stable@vger.kernel.org>; Tue, 01 Jul 2025 04:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751369387; x=1751974187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeCUTIvo2J1PhAD2wDzz5Zb5XHzZC9YruSB6ZaOdH04=;
        b=SJiU1lfE/Zwt/Vy6/ucE063+K0HF/61lIvTKr144nvFC8ecEupIRLbAhGTlVi8JpZ9
         zVO1sN+7MBel40pUzMygpOvbGlaU9kYx59Nz8MqptNdEia5KeAOWgFWTKnkoRoJ2qcKf
         1h/Kurpz2MqL2BVoPc6AIKAars8cLwzQoNd/t/ErzJmQviXjEkWEgWgxfSe8GxBdLWB5
         aGHlwksaXfhc8Jq+QsZwTEtepqhWNEBf+1Cl6ovsWngujcGK4vkSIO6edQzJJVde4kxe
         pb5O2X5qgLqvbR0ZHyktNBT6sRdOYZ0T/PMCZS7KQ9cPVXcipPLI9ZC9muLqzsPLD0NN
         tDEw==
X-Forwarded-Encrypted: i=1; AJvYcCVcHlZUVSirzW59Iom2GnnPULU6kgVzscZmblDmPyiZ2TK8dG4ndaHMCfnIg9xZ/VY3FO32vz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyypiNxEZtbPp2EoDY9q58bYnGFTtUxRrYANCSfMpil5V0Fuvbx
	EDzD08GQY/tf5rNX/+s/i92Yt0EOR4Cnl2NhqwZU0lzhoW3+ash2yrE0wca8G94BGcVPmVLZrYS
	JIUE20CbzAkUW0ufWhIMGwPhkLBKmy1fyxRJzpjtmhNpmWAxUfsTM2RUB5Eo=
X-Gm-Gg: ASbGnct5dnxX8INYLjrut9U96QZi2IddmTr89T4V/2Sp47x2D/vSlVhOi5sHte9+cdR
	2MSV/jp3qTqpyASitgxdrC5hUSbL+8qIZDsAV6ELqY+g795IUdUBw5ZJdQ9gBgb7DXNOefjotop
	2sGmXYP19jin6b8AGcqMjyCLtnYeI8GfSRIBXSlnCwfCSqXgI+QFDdJUpp8CbyjEvgA2FiBHLhr
	+jo6vSrGo6zuTfrjKra/AVk7E5YPUPw6lfFkXmuntkvnE7MiSxgOmzUhAosQmIn+F1hytMSLrYR
	Bp5tEjlzapgm9soI/FoJLt9FG05xmSG2ChJNrFr5USX1DS7+lKmIg0l9Yjt71+/hw+0lNkW/Zmn
	9Kn/sThSBrgFPG9/YNHVNDu3f0zVYWuS00E8=
X-Received: by 2002:a05:620a:29ca:b0:7d3:9025:5db7 with SMTP id af79cd13be357-7d44390de6cmr2236947085a.20.1751369387462;
        Tue, 01 Jul 2025 04:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlEPq2TzJvQkQhhpGX0KRHwjYHWsll+9h6ewOO18Z+pocOSxBGiQFARtIuoG0qr8FCuX/VUA==
X-Received: by 2002:a05:620a:29ca:b0:7d3:9025:5db7 with SMTP id af79cd13be357-7d44390de6cmr2236942285a.20.1751369386888;
        Tue, 01 Jul 2025 04:29:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2da80dsm1785087e87.220.2025.07.01.04.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:29:45 -0700 (PDT)
Date: Tue, 1 Jul 2025 14:29:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: qcs615: add missing dt property in
 QUP SEs
Message-ID: <3qji4ppbdd5lvalx6qmbr6f7jsvyhyulfshchlya3ajsykbkel@rlu5uwvc2biz>
References: <20250630064338.2487409-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630064338.2487409-1-viken.dadhaniya@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 9Djkv5Sem4tdAaw1IdTN6C5aju_J3KX6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA3MCBTYWx0ZWRfX2uqjjKqOcur9
 8dvXrVLKY+6H1ljYdTe+SCgw36ou5MlwRnY2vLv0g8IlfbhKrHh8vRGSl30NOY9RPe48+dy+OxR
 GmPMkniYabEugeLYgED5viXUzktAFqbFjXGc6whdEKhHBTUcWsiiF4cPYCJPmZRSXVe/nXUK/I7
 zBpadxd9gMG0VCjU/w899OyYu70vDal8z4NF6b24+Mg94xorgD1jqdPad3TrZMWdVlXTHOsQkP3
 96gQZxZDH6mjRUEXsrGghOadDFzzKTtqV9Cuo6qkpFU8l3qRplH5PPSbMRX0rKKgLOdslaSJ+N8
 bO0Esvkd5yXSCUsnGIfvmApR+0GS7/4UWKz8zxKPkm7UhHtYN4h86IU8dkBJmFzpCgae+nue7N0
 uODpWZpqu1uMxh/rTBf7PGWimrrN7j/SFo19cp5YgYMnOC5AF9bh3xx3kQiRHfxLWKNvRaKB
X-Authority-Analysis: v=2.4 cv=L9sdQ/T8 c=1 sm=1 tr=0 ts=6863c6ac cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mQHHEpzZ3wyIVHhDumQA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 9Djkv5Sem4tdAaw1IdTN6C5aju_J3KX6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=673
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010070

On Mon, Jun 30, 2025 at 12:13:38PM +0530, Viken Dadhaniya wrote:
> Add the missing required-opps and operating-points-v2 properties to
> several I2C, SPI, and UART nodes in the QUP SEs.
> 
> Fixes: f6746dc9e379 ("arm64: dts: qcom: qcs615: Add QUPv3 configuration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
> 
> v1 -> v2:
> 
> - Added Fixes and Cc tag.
> 
> v1 Link: https://lore.kernel.org/all/20250626102826.3422984-1-viken.dadhaniya@oss.qualcomm.com/
> ---
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

