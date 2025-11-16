Return-Path: <stable+bounces-194866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C213AC613A3
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 12:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70B3D355222
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 11:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764CE2BE7AB;
	Sun, 16 Nov 2025 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MorxaGdu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hp3OBCRE"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B8248F62
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763293138; cv=none; b=j03t5cmqKeajJ24tFFn9GpjkIcvdQZf2UnF2+MBRewXesjT5spt0nhSwA1cIww3rbl+N7PEJCXeoM+RgBoo8arcwKjwdJuJivzW3LBIdkyXy6Y1s9e6kTnO3NKhPt0l+q9Vhq06YgP2l03NLJXaLydEXzgVCcaS1zwuyFc1Oo18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763293138; c=relaxed/simple;
	bh=UZkZxW6oDJLp+w4C8bfan78Ipn16wj0YBwH8H8f1BLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIIG+geupg3ntTuVxBusDGZH1jDWJgXXHw67GmnTJP9NMI5gdpZy9Omi9JopH5PNSkDFVAblI4fyeoV42RGhMidkwS5Yfyno+jHZn4O0vdQuaBpD/MmYrpvYTrk7KfwXM4nbJHLa26m2jkdiA36XKzbonXQ/z+NIwVphZeNv9ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MorxaGdu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hp3OBCRE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AG9S0Jf279212
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 11:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gpMNilTiqKZvFerSznNOMiBk
	SRtg39dU1DzYkv9O/M8=; b=MorxaGduOY0TCy9sMgYn8YWDPVfCfyM3zsQnT0cX
	0h3hgtsxLQv0r0zLfLPOlWKSqvsoh+9u523i+0GWKT47EjggrN7c13PKq42cnS41
	c2I1HXJHXa+gQOOSE1oh6tiB3jOCpa2fxMW/VFCM0+ZSH1lpN67GMDBmZgbCrsvM
	jVie0+7KSYAQUdfBDN/1MDrrrf0q52w00htKo3fx8JKJfFp7wKhHdFI127oomGMs
	jtzv66WCzI2MIViOXVNrQYZatxOZskQY2LuYr3KBQrlRjNZftN/dwkX4Lcw9mtVd
	Eo1Hsn+jtSHL3GLgwRiy54AvJZX/KIKXIqel66pGDeqmeQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejph21vq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 11:38:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed74e6c468so49565701cf.3
        for <stable@vger.kernel.org>; Sun, 16 Nov 2025 03:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763293134; x=1763897934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpMNilTiqKZvFerSznNOMiBkSRtg39dU1DzYkv9O/M8=;
        b=Hp3OBCRELAUHCrC9f4cz3tTN61kmyxBdHmn7uDM7NbFY2f5cMZJ6s28PqmPRghmmkL
         4SAHShIn2/QSSbvtAJPPWGxIWj5rYIx7DhAazXme1cymuy4GIDgKPSsZHcd83FakrGVp
         t7J3JRvvPjG/OPPFp3TfAAs7zSOg+jSJqcimpSxREQlpGgc3L8vRURRIX72wLI96qGb8
         vnS3SvG3YP3p/jsXaLKWTE9IDOX0jaE+8EB5mdpUQwUWRvUma1oz1TfF0nHK6YKcPtOq
         UnX6HP5lnWfCeSFio9L3WR1gVUd30CWwVbyAmT1zEDOrVVRKGLKKTRuMruIlhh+UdZWB
         3nNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763293134; x=1763897934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpMNilTiqKZvFerSznNOMiBkSRtg39dU1DzYkv9O/M8=;
        b=S7Ww4m1ZSyfG/OT6IjKe9Fy+VPvK9afJSFAWpzXH9E1o0MDhYI2jDphSt587ZLTyLD
         Y+qqCm2B72vFqXoXFPwsH6tWi5OTChPme0s5bNip3CZBkeoKlJ7LUtbzPyxOx3lJcLRK
         Dw2RJj+yOJc+8Ce29Gxp8591A84X57kdeGYrsc86NmTOhWXufb+I715lPtzjoi/vZV6f
         DSK0u436wFHMmn7nyYlRCtX9WpMDa/OwioTJUVbDoA85M+FyEt7dnUpsjLJebV1K3Yn+
         0KUsvj0EkJ0lg8DC9tZog2hu8FbwssrBiuVMvqSNrk/Q9lqrpGiCruT2nQqAYcBEyOoW
         8V5Q==
X-Forwarded-Encrypted: i=1; AJvYcCURwJP20A5V5B41eqUmGbILM0GcDFaDtd2nC/MlRi1Yo1tKtYrmnGRWS1LgL5PhRxY/7G9aD5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFqBDvxAOdD3Cdl+TUbJBtz6acbnCrvhhdI8nLh9B3IcYX4+nS
	E9WLf35eI/w5f1ZjEtEKiffM5imfTZGCZ3LUUKAa+ro/MT1y/MdpN+koQoz7K7G1GWnrOl0NIKS
	AVWkFr/+rPgySecBryFzDv2E/llYq6ebdDO6Jvn4eLLhw6GvP1R2OYO6ioCE=
X-Gm-Gg: ASbGncuENyZynY7lO4ilc7y75GpjGjxec6jEulXORSrUK/wBJdQYZdlWNaS/oE7XMzt
	NvZA3sCUgBsTiDJMOWDGoh/teAoUcewkEeHVrT7Y+n2c3DxR+erhm+GKC4ry0dV684qb7HLyTta
	Vpm6aXlacAoeSUk0KuAPmQHywg0OaYjiWNxo27cdShRy6TjZHhWNTJ235L3dEpTf8zZ5Cyow4aC
	zfo58gtRcC477uMWMb6qr4DvdmUTR+b+2xOjNjJN2MAECZdPxQWjNpZglmw//AJl95TTFoO4K1v
	ZD1LXpsrZVe9c1IO+EHzkm2tJivjQTEMGMg7alYRCpoebcZedwDxF10vFSH44GNC8gjLxcfN17T
	ZJFUDqC/Ec+/fPq4ocxM09JQT9GhVtNR//hV/iRIGH3pTB3D0EaO6VBUBH+m10P1JCjKfUihfSk
	Y5MP35pN49hD6h
X-Received: by 2002:ac8:5c90:0:b0:4ee:1365:ba71 with SMTP id d75a77b69052e-4ee1365bf2emr37920401cf.9.1763293133623;
        Sun, 16 Nov 2025 03:38:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0+9gZPhHgtYyt7zLD6HaVCVgBxPCKeg233JhdH4Sb2vjhtKBMn9il8vin0Sn3yAQM/ExGHA==
X-Received: by 2002:ac8:5c90:0:b0:4ee:1365:ba71 with SMTP id d75a77b69052e-4ee1365bf2emr37920121cf.9.1763293133096;
        Sun, 16 Nov 2025 03:38:53 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595804057b0sm2301873e87.85.2025.11.16.03.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 03:38:51 -0800 (PST)
Date: Sun, 16 Nov 2025 13:38:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/3] clk: qcom: mmcc-sdm660: Add missing MDSS reset
Message-ID: <iqljxclxt63ncwllj4n34inffb2bn7qidlj3tlupfeqo3ltbob@mfaf6nbtvevr>
References: <20251116-sdm660-mdss-reset-v2-0-6219bec0a97f@postmarketos.org>
 <20251116-sdm660-mdss-reset-v2-2-6219bec0a97f@postmarketos.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116-sdm660-mdss-reset-v2-2-6219bec0a97f@postmarketos.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE2MDA5NyBTYWx0ZWRfX0dlfDeuz6NCe
 0c1lGS/waQovjA971CgzHlhm+4AlLtwFCh5haOx8+05C70tDVMUIzXF2ZZFoQQSzYYoJcnWPzmb
 hK8UtqRkgICcdH6RF5dUUgN6nOzTBt2gJX0FLHcJgm66PweMCQALDtqBP7cO8aUsqS7wyraHP0Z
 ftvuFtndDNh0JJ5awSeLtc4jyWV7WvdvN+wjSsxJtbicVgx/R5jo2g1O40rTr+HkHxq8LGJ9vhv
 P6CKq4SH1ZFc5g2wgTEQY5m0redrT6Bkdn0BAXu/huL6OozUoDTgsisml0ha8TQq84my6hkAaZ7
 hBOR/q2zL61AF1/POB4P2jBJuEZ9bHieYz49FF0yo67WEKAH52duhVeYEFMQh+hs4oOxhme338i
 8W/RBppcz95eVLUjIxn1LZT/IjlglQ==
X-Proofpoint-GUID: i4cZQhjIRc-OxJBMrDIT_guXsTtWuWsZ
X-Authority-Analysis: v=2.4 cv=E4vAZKdl c=1 sm=1 tr=0 ts=6919b7ce cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Gbw9aFdXAAAA:8 a=EUspDBNiAAAA:8 a=10pTUH41BiadPyba3gEA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-ORIG-GUID: i4cZQhjIRc-OxJBMrDIT_guXsTtWuWsZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-16_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511160097

On Sun, Nov 16, 2025 at 04:12:34AM +0300, Alexey Minnekhanov wrote:
> Add offset for display subsystem reset in multimedia clock controller
> block, which is necessary to reset display when there is some
> configuration in display controller left by previous stock (Android)
> bootloader to provide continuous splash functionaluty.
> 
> Before 6.17 power domains were turned off for long enough to clear
> registers, now this is not the case and a proper reset is needed to
> have functioning display.
> 
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Cc: <stable@vger.kernel.org> # 6.17
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
> ---
>  drivers/clk/qcom/mmcc-sdm660.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

