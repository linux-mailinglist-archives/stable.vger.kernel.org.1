Return-Path: <stable+bounces-105413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474139F9033
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 11:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9703C16158A
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18331C4604;
	Fri, 20 Dec 2024 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ne/R+R9T"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2868F1C3F27
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734690513; cv=none; b=r/IU4zHSnjslcW6/2rnn4hCELT1jveW9GStH8zLu/fmxQ8TVPiOBcrW5Wy4Ip2/Bi04HAw1ScHEnqayJXFz4DBUk5KPoNPRW9gG6l7gyu7ypKT5nd+JSSDcnCHT1k7gMHyOTkOGm4WP6bRJaIq4/b2CtxoxmjSLXnDrYwavtGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734690513; c=relaxed/simple;
	bh=1hjBVCcUS89gAYDyc+pvRL1kdXckem1XTkgZ8bCc7Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LB32050X0TDjFQP4y4xUQfBBvw6fZjwaY0ZFmOAvWuxengPBa2MU+OJEgB1Rj3FEemgo/IBcxHXTXfReQKGpzTIqbcj10VJSeoQHVeFsnxNg7+6relBFXUSnna0BqMeyoLKNFSbhwbAyMFvyILOk8tyn0uPJVpyLuxW4hoSsGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ne/R+R9T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK6lbFU001448
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 10:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XjQWa0qd5X0wQZSFo1zpsnnF4GInUf2OufuV4F6Rxo8=; b=Ne/R+R9TGe/rAt4I
	8gdnZL4m4HNlcU9vDI6/Ao4tHqnlb540+ToYBxs5hqao/bIZXxtmuLi5jLVgOsqH
	YnqhlXYHA6bpYaoTbceHUL1MLjfefiRnkOJ5HBKPge0auYoohHSYCyIcqwtShuBU
	E3k4gKG4QLblChNktt38+wVswowx9ZTTvnNu5tEeIS3dNN3JCA33xXSZHC1XMjLR
	Npg2MrdhWwHspL+aWMjdQrGvqLRAQuDKdHvt7kkZJKWwRd9g7LFyQH8Za+TgqkC5
	uyktPWL1XzB5iN6iCZQ4arfaQURLuOa05BhtvNfwte4/ijFLL+j/lB0QOGAjKUz4
	3e/Ccg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n3mfrkxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 10:28:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-469059f07e2so4001681cf.3
        for <stable@vger.kernel.org>; Fri, 20 Dec 2024 02:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734690510; x=1735295310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjQWa0qd5X0wQZSFo1zpsnnF4GInUf2OufuV4F6Rxo8=;
        b=ju2fBOT1GXvGrqFDnas5Vk5qelavtov5F7eBTKkGLrf8RxiL8cdO5yyoOl8u37e8Rr
         ukNEmy54Xl+jpODUaVW8iuupRqJOaJ87Sf8xBj5olHyLJMl79OViPNg09e9kdW5pos36
         +/v0fgPYZsBmTLGZyat9YKjRHCIuqtrmpD3mKkE2OKaL0qqbl5gr4VLoZloN7fcZ1vOK
         iT7V1VW1OZRwxFaBPTgLf/kMP6mybtWxnCjVztD5HTElHb6GXLzuQs0EX9k9n+C1bB8w
         BoCN1VZLHBEgDM7ViRlFD3/fE9utvDgcs/9IAdUd3njAvAdKDPp/OfnvoGP+eNqV2b6s
         2cmA==
X-Forwarded-Encrypted: i=1; AJvYcCVPsqcnRjwS+/NWf4xvlLl5RY1BKg+HzDa3/Wk/JW/1lkRJaAUUyexew1Q7clffMb5gaC6E2Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxS54VqvgLj/8Viy8lcFlE4//FikXyOlicp+Ky2rvSQVbkkjwp
	IqTomG8Q7OygmHfoR5uQyzzaalr8TsGODWKMy9+AeBhuQOiUfzIK1spHflIE88PiCowMbt5vNc4
	O2WV/KG82qdmwi2fY67V4kroS5KFw0Y/2M1Qqv3LO/b81mxkdK3lnaSc=
X-Gm-Gg: ASbGncvq3WUetHGXZhtRSHDSPMib1Rq1v7wZUIt7xpUNFKtpHIlodholnK3yW8e/Rax
	6f9XCqHVqsSHFzUISGWBrqVRyQZLLS8sL+xAGrB1zzFMEX1pFsdJXqAGGJlk0YLO8H42Je3Aq7P
	2M/tDJOttez5QerAqtccsNVhs/3Pg8Xnn3oDAsTf8dnjN0jJQAFQbcYKelvg/1Jhp7P4EWqnNXq
	pMSOzn/Tq0e2IAW4E5fAmOX1nsNwFatI6Dt2FvG4u/nbglh4piAk1L9bHxiO97JdJa7vVZZ85DS
	LzgzMLPUAgfq6BSEC9gEJr42I6ANVuw0v40=
X-Received: by 2002:a05:622a:4e:b0:469:dcc0:9b23 with SMTP id d75a77b69052e-46a4a9a3eecmr15332281cf.13.1734690509599;
        Fri, 20 Dec 2024 02:28:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMtjaKvTFUsh9ZDwXASae8DAiBKh90dcboQDUxU8iSgVq6zGvdYVzXhh/z0oYYZdIkXxgu7Q==
X-Received: by 2002:a05:622a:4e:b0:469:dcc0:9b23 with SMTP id d75a77b69052e-46a4a9a3eecmr15332111cf.13.1734690509230;
        Fri, 20 Dec 2024 02:28:29 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f06cf19sm160882366b.198.2024.12.20.02.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 02:28:28 -0800 (PST)
Message-ID: <0f5f07f8-dc6a-4162-b9b4-82e40b9ca526@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 11:28:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: qcom: gcc-sm6350: Add missing parent_map for two
 clocks
To: Luca Weiss <luca.weiss@fairphone.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241220-sm6350-parent_map-v1-0-64f3d04cb2eb@fairphone.com>
 <20241220-sm6350-parent_map-v1-1-64f3d04cb2eb@fairphone.com>
 <e909ac59-b2d6-4626-8d4e-8279a691f98a@oss.qualcomm.com>
 <D6GGBPC4V5XV.YU8Z2KASBH07@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <D6GGBPC4V5XV.YU8Z2KASBH07@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zJgnZqMkxVPpHJz-q5oJqEFP2tPGoXK5
X-Proofpoint-ORIG-GUID: zJgnZqMkxVPpHJz-q5oJqEFP2tPGoXK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 mlxlogscore=948 impostorscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200086

On 20.12.2024 11:21 AM, Luca Weiss wrote:
> On Fri Dec 20, 2024 at 10:42 AM CET, Konrad Dybcio wrote:
>> On 20.12.2024 10:03 AM, Luca Weiss wrote:
>>> If a clk_rcg2 has a parent, it should also have parent_map defined,
>>
>>                       ^
>>                         freq_tbl
> 
> I was basing this on that part of the clk-rcg2.c, so for every parent
> there also needs to be a parent_map specified.
> 
>     int num_parents = clk_hw_get_num_parents(hw);
>     [...]
>     for (i = 0; i < num_parents; i++)
>         if (cfg == rcg->parent_map[i].cfg)
>             [...]
> 
> Should I still change the commit message? I guess there's no clk_rcg2
> without a parent at all?
> 
> I guess I could reword it like that also or something?
> 
>   A clk_rcg2 needs to have a parent_map entry for every parent it has,
>   otherwise [...]
> 
> Regards
> Luca

Okay I suppose it's fine as-is

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

