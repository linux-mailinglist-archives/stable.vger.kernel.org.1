Return-Path: <stable+bounces-127524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC80A7A3AE
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248BC188BB65
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 13:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8724E4B7;
	Thu,  3 Apr 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f2laoKAe"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE0222561
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743686820; cv=none; b=DwFVpsSoe+/w92MT+ApoPhiEGVD/rM0c0gdGfGXp4XCsvYSfyL8T6pDqGqJTPOm4v0QlHNl1iDapj2MAfSW5kRqdem4u+vQ55Zkrw18YVs3C24e0CKYo/Xkjr/hVNLuXPNYvhmj6t9yslHNPQ+JW4ZVyyqW5Trw0JvH+VovkVKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743686820; c=relaxed/simple;
	bh=4UXV55D5E+H6TMtvnN0wpDmx34Ixoq6zIgrCe9ek8Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqnJd7XtaDh7DAgsFTe9HuxoI5uqFPRmHvmXMJdK4r+sXnfvsarA/Pu4xuVHK2VZ8QVjLT3WRURJb2DXalyw8QBfqItXtwIP9qm9be8Ikl1KvHn1uqRn032ATnvEz1oWK2AGDd3NSiWCdftLR93ufgyiU1kKBzjVkakd1xSW4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f2laoKAe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5339s0fX025698
	for <stable@vger.kernel.org>; Thu, 3 Apr 2025 13:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LB70BJhIJ9nick3PUS819gLe
	WF3jTLiD0aFEbtE48eY=; b=f2laoKAetenZ7mjOf0TW1z061ADqfahMoXmT/0k2
	r4xQ9skOcFUsYllGMxni4nuN/6Pbv0IvEfq+lIcOmq8NxvNbe3cXpOa9K7JQeBCC
	+tamh8qTVbOq4aRi4feT6k+6KTGyPkpc0XBe/wAWjH+0iz6SUrAdEOi82KVfVGiG
	nYg5C3uf++NPYTmP7ZfZ4R8HzIsDHGgWVkOS+GPOSicPNNxa8YB+59GsI+DPrrmJ
	0tiT2BPstRoTepEl+stV4LLnnZ4tlD2u4yJxzinmxAIawHjsVUZqQ33DUl2pC/4V
	KujDl/pu7iZa2jyjtYkkZgS5cp8cuCT68qyKjnOGay9bUg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45sc7x267f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 03 Apr 2025 13:26:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5ba3b91b1so182225285a.0
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 06:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743686816; x=1744291616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LB70BJhIJ9nick3PUS819gLeWF3jTLiD0aFEbtE48eY=;
        b=bqEOLGe23rgWEMYreFzNBVqiR+i8LFczW/ajqibjwkpIZLAQERJ/WXRmT9aa0eZ5oi
         DThbP7Xc47pU65x/a+85H9ThbS7yeAB4T5G+9UbvoLB9SmWh38ZgvtEDV0R0czGNHIn5
         OaDvhwEicGC3ooP+6uoz0xOvvdPQk9qXcuZvfwQdQTA+0puNFGlWHvmHT1d12jRL7ECP
         +kDzBqueZzR/1QcSyeMWPTGinAntNSvk1BBTdw/F7wsexZwRxoKYSvPBlMprxjkjYr0V
         vvsY5QyttFmJXDUkhYGMA5EchDMlaP7Jtz17WZ7X6M4Vl2EfXafGHFmhhF1XsxfqufsR
         Vw4A==
X-Forwarded-Encrypted: i=1; AJvYcCWQTHU6rgEVaRhQaJA8CmM7L/7ql423MAhSWh9bux+EQboZaNZk9VlL78f2ENq/9mRW64LPF80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf7OhaNNmzAHFHaDoAC3Xk+VseWdYOtNtGeQKWykPTQYZCyUXF
	rRPPl3L1mjlu56wVvVME8SBkLsBqWsjdCWkx6jipejxUq13OCms9qChV8dtDtpkpG1AY2cds2c2
	aVCRie9Qea6UG/JRAKTcKENcmNhhwKUNUrfbVcFPIQjNDAd8YJEVAcwI=
X-Gm-Gg: ASbGnctom2X4yTV2vMrGv9Upbu9vVb7qjHv+1+I0rC+1gYeNSDlrFX5RPTWnij9PS5K
	wCUgzhbKVh2/wBqUIrLWA68YgKiXtBuXx5DSYshBeDsprVz7QRX17qc065150pkG+F6K5D7Cg1G
	MO3/CPt1CQ0RggLHPJy139dX34wv+VzSu0EjfCQ8AxTQpr4f58m8SvQBPvoWOZyF9erpo5AHzFm
	ir2YKP6zpdAPrqrUgXBecJ/9lDj5G4z3EZKCTtmND3DbndUBF+HpGoWGlIJcVaSNfM2yU+nmU8k
	2v2Wyqpx2PjrOkDY1ZqNGdAXAKRYZP7gc3rT7iMI88OCgjefKBBrjdwuUgRppaE/Zg+xZu5NYlX
	+Cd4=
X-Received: by 2002:a05:620a:f14:b0:7b6:cb3c:cb81 with SMTP id af79cd13be357-7c76c9c0c8bmr527678885a.18.1743686816451;
        Thu, 03 Apr 2025 06:26:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFatznasd8BW/kd0W0ZZtY8M0I+aTh8Ks7eY6cLGkHy+GyZA2Kdm0ociaqWKYTfTkDL5hrKAg==
X-Received: by 2002:a05:620a:f14:b0:7b6:cb3c:cb81 with SMTP id af79cd13be357-7c76c9c0c8bmr527675385a.18.1743686816087;
        Thu, 03 Apr 2025 06:26:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f0314c62bsm2134281fa.61.2025.04.03.06.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 06:26:55 -0700 (PDT)
Date: Thu, 3 Apr 2025 16:26:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.dev, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ASoC: codecs:lpass-wsa-macro: Fix vi feedback rate
Message-ID: <ggullym7srgx7ucnrsi6vhtdmhesgsxaxsnijywfpxo6uclnwz@vamc36efaxr3>
References: <20250403124247.7313-1-srinivas.kandagatla@linaro.org>
 <20250403124247.7313-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403124247.7313-2-srinivas.kandagatla@linaro.org>
X-Proofpoint-GUID: nCqfm4avK0N3mqU4zF6t3pGR25qigbSX
X-Authority-Analysis: v=2.4 cv=XamJzJ55 c=1 sm=1 tr=0 ts=67ee8ca1 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7saLMaS6oewID-XHOwYA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nCqfm4avK0N3mqU4zF6t3pGR25qigbSX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_05,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=853
 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030060

On Thu, Apr 03, 2025 at 01:42:46PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Currently the VI feedback rate is set to fixed 8K, fix this by getting
> the correct rate from params_rate.
> 
> Without this patch incorrect rate will be set on the VI feedback
> recording resulting in rate miss match and audio artifacts.
> 
> Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/codecs/lpass-wsa-macro.c | 39 +++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

