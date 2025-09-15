Return-Path: <stable+bounces-179606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5232B57235
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 10:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDBB17A0E5
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 08:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA612E6CC0;
	Mon, 15 Sep 2025 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+Z3o74A"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9242E54BB
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923343; cv=none; b=WMxzGYk9zHGsZUBmhj/dprxKy8W/86nUQdVZ757CPUqsma4NZOZDteLb2My8vNJzcW3EWcqYmxVw5iVfuu+mC+VtUBDxZkRwXjpv8BP9HxjIrc9cHCWnQQ79sMmn3E4C+k7wEn9AZHSSeHVSKAQn8r1RoVyG4N8wVrtQ2SJIOcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923343; c=relaxed/simple;
	bh=NxN20Gn0aHENTScrUN7kSeNIZDjx6Vfsg2GuEin00cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+7JRy+mGfkcUt0+UnYRXGCMOU1QEbxY8IDGPVmmJElsUWkb0HLZWzds8E6KqwGFzbi+VimxcsBuIzYrQYlHrLQFWwg360UlInWKSNaSSuorpMwzvYerMVFo+Er9VJwX5MAKJiw2jdAQDKDzrrF7YyITv/XIeXGP9d8MUEDt/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+Z3o74A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F7I1BP013545
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 08:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZkqyB913YY3yMnVNUtYTJNCapGusGIc3uihCU//zesY=; b=E+Z3o74AcYrQCKfJ
	q++aZsY3x5gkBr3fR2bN23BcfOK6+uSrLRIhdG5hmkc0vop4MqS0u6EVdS28qPoV
	+eT3NYEddOpyIszr5MYllrQTXdzh0vkcORMBlE8tfl9aHQlbs+3InWCJjMnOmZFl
	DKhB1USPR+ni34xj1RZB9RoKUN9xGoBp4j0beyNMwJolUSIfF7idDLiR1LcH2+ai
	UC+19lTNnkzpVkzkRE5O6fuleOYJrceegAczVRj2NWSftphzWJ/zkebMejZ/E7Ws
	ZVbqUR6OZcielbTxVxBdjMFVAZMqqpYPLKNfmwZt5/5tcfzS1Vvw4RQyCgxG4boi
	K6oNpA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496da98ags-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 08:02:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f112dafeso105391081cf.1
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 01:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757923338; x=1758528138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkqyB913YY3yMnVNUtYTJNCapGusGIc3uihCU//zesY=;
        b=Zc2dWo/8AUs8r32FkkTRR6MvopYTaY+5EV4bRrDDOHLu/dGJbXby5JRbxSVElII/ZP
         AoYp+e0Kpv6shq5b/Xp5zhWTT/fPS5+pPoye/QHVgJo2SJQBD/Jevx9EPCasL3dzdzPq
         XjQFp3Ysl0Kdp/PlA8A2GuC2AksjjECJcB9dwm8uY+S7+il/tLD/AqsOk/Xfz2IzB/aS
         ZkjrYHE/WwZ76OF6/MOzxw7C4FkbZDrqO8N+RezQQhWEskgILf0xzLoNSIT+q7CnQbU8
         67JFaiQphcEwLeSyluyxvgkCHQiXAieyTfL0cSF8bkdyWjzWgFPzC7u9aPWbG+gf5hPF
         GpKw==
X-Forwarded-Encrypted: i=1; AJvYcCVBQ4kDIdKI3OSCeLJ0LHCI0XvYgsKXt4sFO7c2LSzktfjFzsYkJy301tA3Q+ScSZmZdQU9rlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/PID7mcN7J6MwlpB/8Fzo9f5g5RDLIoa4uLmT7qudlCrEyz4n
	ZvOF3I0n+WzOuTsZA6BlZk7qOYBOfRNike6fjMo/t6c+iETLScbHa+eF2WSo+2JJsG3lr1HlWnl
	KEM0ZuKm438/qe9Un6A6kEVouqeZaxWx/nNfjAHDXNnR/BhGoA0HS38Z6vlk=
X-Gm-Gg: ASbGncsJ5xQJkj7iOoJfUvyI9FneNXCloadV/wcH3hIVt6etalkc+YL6mopulaePbED
	sHOZN2djY/fgUQhp/J3drqlM7jwJp6kkqAj7HGpR+xR6QUdgQn6fVjxjn3wupeLXLbHzPg66tmR
	pcfnjWITthao+lR63v0sbGFKfUG4XIZ75ZDb0CKVv1dtwEIGlUyGq9umFX3h6xcckv8oKMS+9Er
	9pXysupyLVAxyEXgLYBB4vsM+gjrywNMIDtuN8E2XyZUTj8gcwKNWcdFCncBWU3oVW+a2X4cGwF
	CHpC6AtedqpOIrd8NGWRyZnlO/AsJceKAxPHo8C0uH97KjeMjkv3kObAmjsxxFjeQ1Q=
X-Received: by 2002:a05:622a:247:b0:4b6:3178:b253 with SMTP id d75a77b69052e-4b77d06a1f4mr163367801cf.58.1757923338455;
        Mon, 15 Sep 2025 01:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNw31LJSCp0juE0c9doaAiFovtWcdc7NGc8wtk3ZUQMcSD0QCoI0uGjhTOyxUVgoOmvnfINA==
X-Received: by 2002:a05:622a:247:b0:4b6:3178:b253 with SMTP id d75a77b69052e-4b77d06a1f4mr163367321cf.58.1757923337914;
        Mon, 15 Sep 2025 01:02:17 -0700 (PDT)
Received: from [192.168.68.120] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e9fd89af70sm4863751f8f.43.2025.09.15.01.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 01:02:17 -0700 (PDT)
Message-ID: <f13c79a7-9595-4795-bd74-ea440f74a12f@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 09:02:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ASoC: qcom: sc8280xp: Fix sound card driver name match
 data for QCS8275
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com,
        stable@vger.kernel.org
References: <20250914131549.1198740-1-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250914131549.1198740-1-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M+5NKzws c=1 sm=1 tr=0 ts=68c7c80b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=3r9HinHMD_fb42oTSBcA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: zHIZ8O7ECLylpCDUOsMEbv1GJA4B0MmV
X-Proofpoint-ORIG-GUID: zHIZ8O7ECLylpCDUOsMEbv1GJA4B0MmV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA1NiBTYWx0ZWRfXy6LvBzRE+gNG
 GFoMPo51xnuxZiWWgqB3qT98A0aurc/Kj3GHDbwpsJNM5QT10scOaKyYke7mKecKIY8wJ5vElkY
 100KjbIbrB9TZvgMHBuZev9YOkcIBxZYbSmTUJUiLl+6QT9byXxcpsQ+xcZ4+nv74U/2L8U/wvK
 loBbS6GwBrKQiWDx5eQY7g041lkDSic8wvj7Yxr/Ly7JiOM7cIiDnnyLxrUCsqp6qRF4InxK8f4
 TrNDbCHGdf2Q9Srhh453hNggdtea2zJh+QVIyWOuAgxiu59OyAbZ5fSCFzUBMVS++yvt4Lt5LdA
 gYW+VOamysBqt6hMLz7S0NQZEMY6I6SEfBlLJk8PKN8DbfHV0Y4kPhU1CwFP0+ovqvSxOzClhWP
 XHF8aJft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509150056



On 9/14/25 2:15 PM, Mohammad Rafi Shaik wrote:
> The QCS8275 board is based on Qualcomm's QCS8300 SoC family, and all
I guess you meant SoC instead of board here.

> supported firmware files are located in the qcs8300 directory. The
> sound topology and ALSA UCM configuration files have also been migrated
> from the qcs8275 directory to the actual SoC qcs8300 directory in
> linux-firmware. With the current setup, the sound topology fails
> to load, resulting in sound card registration failure.
> 
> This patch updates the driver match data to use the correct driver name
> qcs8300 for the qcs8275-sndcard, ensuring that the sound card driver
> correctly loads the sound topology and ALSA UCM configuration files
> from the qcs8300 directory.
> 
> Fixes: 34d340d48e595 ("ASoC: qcom: sc8280xp: Add support for QCS8275")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>

LGTM,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>


--srini
> ---
>  sound/soc/qcom/sc8280xp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index 73f9f82c4e25..db48168b7d3f 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -186,7 +186,7 @@ static int sc8280xp_platform_probe(struct platform_device *pdev)
>  static const struct of_device_id snd_sc8280xp_dt_match[] = {
>  	{.compatible = "qcom,qcm6490-idp-sndcard", "qcm6490"},
>  	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},
> -	{.compatible = "qcom,qcs8275-sndcard", "qcs8275"},
> +	{.compatible = "qcom,qcs8275-sndcard", "qcs8300"},
>  	{.compatible = "qcom,qcs9075-sndcard", "qcs9075"},
>  	{.compatible = "qcom,qcs9100-sndcard", "qcs9100"},
>  	{.compatible = "qcom,sc8280xp-sndcard", "sc8280xp"},


