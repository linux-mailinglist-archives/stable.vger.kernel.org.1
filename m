Return-Path: <stable+bounces-194867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B70C613A9
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 12:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E56E34E3EBB
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 11:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291352BE644;
	Sun, 16 Nov 2025 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NBvzxI4i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fvm6xb9k"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F291A3165
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763293155; cv=none; b=sMRKOwC1Ve5DaWa6pEPIbI+6QnKUmCc9awgg+2Vb8SC/JANjbpzoqBLQIf59Z/yi5LAKgXSy1hP841Dqssr6GZ4EGM0NaQ56TQ+lfd4BaTvLbPyQMiz6j9yN/aNibKosOs9DTnV3Zr8o2nr6JfJQqlJ2Qx3spJIA21L2CIcRKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763293155; c=relaxed/simple;
	bh=cto4Ub/2nyqc9FagqD8NMWlayyDAnzS2+RVFu4RyuQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8ggqZ3CEHAYgWo4bVCFDJZDqaQI8YP+Yctuk/YT9oujPlavTaT3INBp5yZ+O6hJ2pjnv+LzC6sUZy6Ou/llXjlcJ9P+5xGurJV+qSBffev9ziJs0/OaqdIvhcPwjQEWkGXiD1FjhXeF5QAy3VDAI6H4CyTbpsmzzJOfmuzBHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NBvzxI4i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fvm6xb9k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AGAkEej434222
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 11:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=p6WIHRv8rfGamZstjZ0Ji7f7
	SCFoQSnIYUIXkBtNh0w=; b=NBvzxI4itPZtUOZz0gkYAw4i9vbOf6UmTiMvjb5X
	yK+LHbZ5XTSM12AzsRl/y817L1Cr667dpNewAtilt8ua+G0s8CY2AKj/XXoZ+LMd
	Q+leIfX5TmCUR2NJ5ohew/VAcUohwI8gqhZ17B9lr2zIHFCleiEEB/XmOAohBmDz
	jufVx4btN6hhJ0K1Dq78T7cnMrBWYH4vi6PAB5HkGJ/9kOCiRFWWLzslKj3/eQAT
	JLSjagilWFuzcuOgQGmCcEtUiHZelqwPHT8PtIikD6pV2nywploz7NqXh21WgKie
	jfosdGHHrXz48xBrGQNkciwBkgmwlJ5nIDr2frlCfzVPBA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejph21we-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 11:39:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e884663b25so94579121cf.0
        for <stable@vger.kernel.org>; Sun, 16 Nov 2025 03:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763293152; x=1763897952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6WIHRv8rfGamZstjZ0Ji7f7SCFoQSnIYUIXkBtNh0w=;
        b=Fvm6xb9kK7cx8cgvs34wFzT/XYUgMZUFVrRrj7FExCXGJJaRdZacO0Z+1YApPCLDJ8
         zVikhHYTUNzW9P6JoCqrCTIEnbl7qwqSvYabU08POB21HMSBPl0AsNFgDnOFi6F/26/D
         iUbQKuITTWVWfOupH8DxVb/QDm9W0lnihGTzx3/0smhJyZ8TLwnALpxxoRD0HIo0BmFb
         ix0MHOFWq3kuoVPkSZhuJXG+3G1Z1F1AsaqkxffxpyY3N7w412atg9hS7SfVjAW50dSX
         UkIwsjir8E6IpSRiOd9QkcLn1XZ5VlL8yoP+Z3r0BWM5AeHPx4dCiTiO38MhhyrSoMmv
         1L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763293152; x=1763897952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6WIHRv8rfGamZstjZ0Ji7f7SCFoQSnIYUIXkBtNh0w=;
        b=G+MxdRtShaVflDvb8oadCICNi/GmcdzqAQx2Cy662LU8DCRwLLniWNRUHDtwpB4up8
         tAocDkIdEQE1SP4wWlAd9E2e3ZN0Uz1CaorrMfSOGSSbFZPoJ1Kz7/x9aj7qVoHmTFpX
         7fW7fJROCfGNWL7kv6zoXZ++O7npCUoY06E9NW0kYlTQg974k4pPL1RZisCxjmFxUU0m
         7iT+Alm1+3cadIbI+fnbvnJwQijpA2CL0t9XmrFePKAEPZQACXkYyk1EuuNwwtfctFZi
         And37feXtUg2k5ozx3NjCdR15We5cgjzOdF0px/7v/fMGy4Ks1VkWSQWdt8aWB8hker6
         THhA==
X-Forwarded-Encrypted: i=1; AJvYcCVqOUYB5gcw4fwr2TKwFDhQRSOYal6kZDRWwD0AGsQoZJqehbpM5LbAuxA43OnD88X6sizDBEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOoj8+HgZJBfrjhzo1kNmR1MQBTUf5VCWo8FqsM9K3rZ3KpKrq
	cX+eZgAnuF/2ennbLEJ6ceLL5MmvBgHEgDy7U8fcXHfGRg5kZVeNK6wofqs/vJFp5/mirCkS4/5
	XKbMlzztXFCBqWgSnb/zUeckYgRuP1xHGiD0UsGi2vb5lYR+mfNZXy9ZzmAI=
X-Gm-Gg: ASbGncs0wYTel/RsFakkCmU73D3Qs7ICdNJf4kAal5xpS6pRoQNuEvP7i5j3qtUoavO
	WCaWbjiwXemVWO4kWGVlwHHXtUzXTclTU1KSZCMOo2WKdkH6YIgWbi69BUgV1LXE964nWb/BdH2
	SQzytVTBYB9TDmc548pUnfA+B3/1amULJyhdMiJr39Ny6eNzR2zyLrKBrXK+lw4QUdYSyBktSzu
	t/YQt0ElYbM1M+aXoPffzYr25N2TvsNP0n39iu4tJxhqkTvtfoZwhoDSQ0GLdMFhFTL48BNG9OI
	nTPap8CQRkXDV4aTD+4FWTBxGHPogbMsZRBRc98iAxSadBZHLXJjvDI93x7mq8VA74uA0mJcMg+
	a4D/cmZ28+otbeYrJg7Pj1BY9ELoTEFibie3kczyDeJ1Ps7YmesVGQeuQC8hxWyw5Sf0vtqQucN
	N06NymNk2raHNH
X-Received: by 2002:a05:622a:15c1:b0:4ed:43fe:f51e with SMTP id d75a77b69052e-4edf212ec7fmr124675691cf.39.1763293152573;
        Sun, 16 Nov 2025 03:39:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPrMInqhMZ4+KRdgGZhYex78MCfrP1MiAAfpMXp57UExj1gFUHeNmPMlzp3zBUfVDgO+Dt4A==
X-Received: by 2002:a05:622a:15c1:b0:4ed:43fe:f51e with SMTP id d75a77b69052e-4edf212ec7fmr124675411cf.39.1763293152157;
        Sun, 16 Nov 2025 03:39:12 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59580405688sm2368719e87.77.2025.11.16.03.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 03:39:11 -0800 (PST)
Date: Sun, 16 Nov 2025 13:39:08 +0200
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
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm630: Add missing MDSS reset
Message-ID: <x6p3me4zf26y23loq7mvveuoqp6xbqj4nea2wbveghxd7yrh6d@6nkjp56o5z4a>
References: <20251116-sdm660-mdss-reset-v2-0-6219bec0a97f@postmarketos.org>
 <20251116-sdm660-mdss-reset-v2-3-6219bec0a97f@postmarketos.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116-sdm660-mdss-reset-v2-3-6219bec0a97f@postmarketos.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE2MDA5NyBTYWx0ZWRfX4nmKx/UZAIU1
 rfUEurASVHnVrybgr6aCJ6VBSXdRns1vJPtFXTZMjd1j0fCcBeBWlom9SMZHzpxPpeBX/5Zv+uK
 zY52qghfBlGL/jTL8kh6rSE9tJBjNQ68IEGLzjywDX6p0invSZm675piKL9MDIU0+50oVVgYU6i
 OcrCStTbE4anbjRpUKB4wktE5wCPrZBH3MYbX0fb1ersfwAgnYQBfsOfgNBF+5ewwEfY9x6Fy/P
 lBD0wTiRuuTEhhtajbswSvGO2i3Tm2jSnbryS0uEe8N6qhO7CXlcn0hB3yDFeyJxBKo91+imele
 gyLdd4myLRQAmwOKcXxHQwG+NtcbInN4sOqAm5Ibr8CMDMctg3qk16Tji6Qmphp86xbCmFmGaP5
 SUU4MSCF4fZw7X38O+g9FULKnfwFYQ==
X-Proofpoint-GUID: TlMVavx65J2X-sm1EcMk3EdzS3SCsOYw
X-Authority-Analysis: v=2.4 cv=E4vAZKdl c=1 sm=1 tr=0 ts=6919b7e1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Gbw9aFdXAAAA:8 a=EUspDBNiAAAA:8 a=9sNXwbGNSHJSXmLFv6gA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-ORIG-GUID: TlMVavx65J2X-sm1EcMk3EdzS3SCsOYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-16_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511160097

On Sun, Nov 16, 2025 at 04:12:35AM +0300, Alexey Minnekhanov wrote:
> If the OS does not support recovering the state left by the
> bootloader it needs a way to reset display hardware, so that it can
> start from a clean state. Add a reference to the relevant reset.
> 
> It fixes display init issue appeared in Linux v6.17: without reset
> device boots into black screen and you need to turn display off/on
> to "fix" it. Also sometimes it can boot into solid blue color
> with these messages in kernel log:
> 
>   hw recovery is not complete for ctl:2
>   [drm:dpu_encoder_phys_vid_prepare_for_kickoff:569] [dpu error]enc33
>       intf1 ctl 2 reset failure: -22
>   [drm:dpu_encoder_frame_done_timeout:2727] [dpu error]enc33 frame
>       done timeout
> 
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Cc: <stable@vger.kernel.org> # 6.17
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

