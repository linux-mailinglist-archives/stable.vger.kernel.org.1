Return-Path: <stable+bounces-192951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEC9C46A4E
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4775B3BA34A
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D0930F7F2;
	Mon, 10 Nov 2025 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QxerOKUe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gVnX/ANM"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF330BF77
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778355; cv=none; b=VY+289NeNtw5W8JTFArTvZYWxkbICR3jkby7a2KzulElYZaqiLt3/lKW20qPOCkf0Jp4pCqqcXpPWlOO7BVMe3JSanFxLvUYkQmVtSiQGU2qj2dOTbwvAx5w4gdH4I3VICRit/Pe6aRPWhWabpys5iiiMmpZBapaZuFqSdbmcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778355; c=relaxed/simple;
	bh=gFT+3Amm33MdGkcRdM74CB/X6g8NjdXUxYSkJHwrXKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYVbkVueBQPFDTbwrZnYBRQmSHb4VWwDMK0H2bvGIXl7quxLBXul5n8LfBWpGjvkEcJ5viRr5j4Y0mh/4tPX9c2etA9zHmXBLlLbeaw9q6V+et+hyZwxf25HuFw4PGp9Pd7LLgO29wFXiuX33uiYJUgQt+r+e1kld996tmY8GRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QxerOKUe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gVnX/ANM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AABZTOe3271011
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 12:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mu3glRqdWt9AjEDpzM9mxwbY
	vCJas7wdjM+G13lxLSI=; b=QxerOKUeZjj15a4crxY+DH4S8zzP3rWz/sO8sLwf
	sOCc0DMNDrPBJjio7zt0ZHZf0R15FgV3XeQanp+u8q6+vGmG53vze3ihn6PUiRmf
	s+pw6NrPstpg1NofLK/d18PaehVchBr3NaD3GJRQk68MOU/bobVe93QEWhzJKuej
	8UzyYtMBa3CbBczNocVTSi7OAaInx5B9wy/lsXdCI6/wVApM8oVkbQ4WukHGS1Dt
	jfarP1Ya8E6//EULG0O6O2p24ycwNdGg1vMSEfKW9x67ojiYCSHxUGdPwklM72Xu
	sgTUwKJdZ2GPBYH4ox/pCAnp5tDNpDOuy6909Qw8zdrxMw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abfafr5dq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 12:39:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edb3eeae67so45152571cf.1
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 04:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762778352; x=1763383152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mu3glRqdWt9AjEDpzM9mxwbYvCJas7wdjM+G13lxLSI=;
        b=gVnX/ANMniM9mqxpJ72ah+wuJEZGOLCMJSFnkIGI5bC6eC1i2PYzPipJEq21OwoxhE
         UgBHFU8ZEDj/5lehZytkE87VroxMWNMEX+R8fm07Lg4PMn3vnyIGbuyXc/pGlAuK+B6G
         YrQ5ltWOAL2h/NeT2UdqA/eF2Tc3IzsM5Xfn6YbTj0zbfdhBzo6R2CJpV/XDYmj3kT90
         xA+o4fdM/GWbriy+eSDxecFp94cgo06Qf3eMsdrpD+yL22G54JGFEd11jFGYyl4unkfK
         FEpBHH7VvJnY1+eKVLntCz9HBxT4p9JBblP8W6yCsWGy2aT3dbn8OlPgXUbe7xvGmi1w
         z53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778352; x=1763383152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu3glRqdWt9AjEDpzM9mxwbYvCJas7wdjM+G13lxLSI=;
        b=wJLCf5bSv7MAAQx8UNMP7AYQgH9hae5mm5M3HyJ/8UlN4+zPskgNU56v4m9ROeqorh
         x839+PvS9sG0BMj9mldYs7k44bWSY7daDS3e0I8dMMlG10o549Ulylm4R0NNfQ1cdv4e
         FOxSwtgysQucKg9mdG/tgvcmdtZSEWfSIvAEc9Y0qHKf3Lt1EOjRdWw/0heZezmJxh2Z
         BZR83+ahTyRkaNQVGfN9we/G+jB187sAWY/G/rdS5mYQ9Rp2v65zvQVjR+0ttgspWkdj
         41SbJMMvnW3ezAdG8qkMWDx6hF51DoXFK6dcVUYjfHJM760c7HbWJGgjJWXCFUZTBuTW
         AtMA==
X-Forwarded-Encrypted: i=1; AJvYcCVP723C7pbZXx2kqaVz8kwktDK3+9anSxy54fZpiiqhSIJq1Trg04vg1MgPP4ga4TVbg9oe1pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xQ9k5ZXSleBm569plLpLDQNw3USTo0YE2fNBemjCN+pKcttN
	D+bx3hwGqUJP6G2BAZt7A8T5Q8puCKknde4g0lNTGVMou5VrYa7g765WHqgaW+YQOOOgqER3z+P
	XTFH9QhrZlcA/J3YHHxEhfOrf8mTk5U80S8DIOkhoAVEhsyOPYi6jkTzpmh8=
X-Gm-Gg: ASbGnctOOKwHw/c8kRuWhzS83iE8HQMrLDHWz1f8OxBHS/d6RxuPHmEK5EilMx1jiLn
	gYyhT67cFOcIFM8TbklF2tyLeQ+MBYB4G0pdcy5gJFs82BVkDksvyG/CfZd64xkWymLPUvZ6Ir2
	6i0rGbKAgjkoPZ9XGhHeZdFZtpChz7asVTrpqauObpA58xT6LQjtToiAoDnkOZdztexgZM/MCKb
	wRjKE4fzMpr4JlpqRYwk9vL200VcwDIvgosC0iOpWWxreGLk5PzqmPjTViIuxtLn0K1YCCfv/vV
	k2gBGqqvkenW3VBazxDQFrsKYpEyUx41OwS5BGovWJBNdY7CfWlKbQWZ9I4mp0U+4io/oe3DlQV
	EjmWKJtHRW8BNRS2HzEzL7CiEWl1TIkPcJGsXtJE9QOM9yGGK6FgcXdiG1ftHwTGWWvSgShIJzU
	aBfBNbmyniGhMB
X-Received: by 2002:ac8:5a49:0:b0:4ec:90fc:59f4 with SMTP id d75a77b69052e-4eda4ecf7a1mr91893601cf.29.1762778352461;
        Mon, 10 Nov 2025 04:39:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc7FjOtBgPgHxkl2t4dPvZb4lKQroBgN5ujgHUpHoA0lYUguSSs9vhkQDvjQQA7BW9uWg36g==
X-Received: by 2002:ac8:5a49:0:b0:4ec:90fc:59f4 with SMTP id d75a77b69052e-4eda4ecf7a1mr91893141cf.29.1762778351861;
        Mon, 10 Nov 2025 04:39:11 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a019f21sm3973713e87.37.2025.11.10.04.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:39:11 -0800 (PST)
Date: Mon, 10 Nov 2025 14:39:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, quic_shuaz@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
Message-ID: <lr6umprjjsognsrrwaqoberofivx6redodnqwnuqtpp47axhiv@nho74vyw2p4e>
References: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: I8wNlnUefd0r7IRHGShe307iHtrvqVsk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExMCBTYWx0ZWRfXwhHzFuVz1qDf
 Zk+9YJbCrHT/N/KA8Iw+b3HtFS0KzQ5B7U96b9dk7GN49XGfKk8ClxmSOnVoeSrGzs9BfEUWyPQ
 A693/jjBon5zuW+SxG7jLqLca0FzL9/8KWmGCueCkE/gGa0vaU6hq8X8orAswFkoT0dlSsjMw9S
 EWam9b3XK3QJ+jh1pm/aawqec+I/2H4qpfd9mPbME+clhGccFyHkO/ahqU7VV0XJY2Kzo1cLhTE
 uk9fWs3U2pB9rNQ0oWxvEtfrDLm3assOf3NaPTneLIbZgF9lQWI3MZR/Dcg1P9i/igaQgiWFmk7
 Fg27oaa1UnUQk39750wc2ul2bPpnj8EJG9fw7D14SaIpljItck+S/TQlkRE4RKMEXhNOCyn9JV6
 7Nz+0EsQ7rQbs3/vmlz6+a3WI2H0FQ==
X-Authority-Analysis: v=2.4 cv=UZJciaSN c=1 sm=1 tr=0 ts=6911dcf1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=vuKYHiuAbYjNwaP7v-kA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: I8wNlnUefd0r7IRHGShe307iHtrvqVsk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100110

On Mon, Nov 10, 2025 at 11:27:09AM +0530, Wei Deng wrote:
> There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
> Bluetooth work, we need to define the necessary device tree nodes,
> including UART configuration and power supplies.
> 
> Since there is no standard M.2 binding in the device tree at present,
> the PMU is described using dedicated PMU nodes to represent the
> internal regulators required by the module.
> 
> The 3.3V supply for the module is assumed to come directly from the

Why do you need to assume anything?

> main board supply, which is 12V. To model this in the device tree, we
> add a fixed 12V regulator node as the DC-IN source and connect it to
> the 3.3V regulator node.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 115 ++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)

Why do you cc stable for this patch?

-- 
With best wishes
Dmitry

