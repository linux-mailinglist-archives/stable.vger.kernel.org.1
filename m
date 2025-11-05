Return-Path: <stable+bounces-192495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0066BC35706
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 12:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6E134FAAA3
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA24531195D;
	Wed,  5 Nov 2025 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XRYe8JjT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IkvOSa7r"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E903101AA
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343019; cv=none; b=XPX5Oy9pzgWnTdDjEcb8aBVwqrpGAFqnDX3odpDaX/3v9UREXzqqs+YoSmkzEuO6POCTaHdWTx6sV8KWbaFsncnaLYvXqbJ/jRex8GNIcptg1bT9P/dYVj0LGOGWRCWbTbdLZWNp4j0B5ym30noZg59cAiJnTh1fHUjW77pBFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343019; c=relaxed/simple;
	bh=BdMm81xYZiuBh40gc0Ua6efd+2dzC13cTYSHrMpRHXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7R5AIc98EzlRGMRP11gO+arudZ4D4vOuioTrAAzQM3TTolbkk0UjjW47SlsxNyeGkzh9TRfrC2yvAj529bvy4yUqu0QX/XD1OcNmlFF3yNKpZCEv+lQncyA2MEYEheOqs4An0CGspd35wVxKFd80k/3n3DhQwDTpWRk8n7Efrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XRYe8JjT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IkvOSa7r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5B33li655065
	for <stable@vger.kernel.org>; Wed, 5 Nov 2025 11:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BdMm81xYZiuBh40gc0Ua6efd+2dzC13cTYSHrMpRHXs=; b=XRYe8JjTZQm1XQ36
	tOSvxyaCtjVUS+hp0JU7p//fVMX4o814+BAQqNrsA/OAtHGZyUJBRdCsRgXMrQ92
	SWKAfVFYjftXjI1DEN7w12Hs0wqpeQuVd23XPILKiQv8XgfpcsKT6tw4arsBDu5B
	1tsyCDJ/uZLfkzHlXqZgU4RiMOPgkvSFgcWFFR3E1OHiRwXKT2RATUwViNnBrjwo
	imVZbC1C6wDZ88co3jBOqeEuuGqk1BvQC4kwmhkTFkt+P/rQs/rmxn5dkTqblIoI
	492cEHvrFBrIIbs3v1c1ApiSRId2Zb/TSg9lSTEkga3awJ28WKRKok5kWO6Q8b72
	8kh+xg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a85c8g2wj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 05 Nov 2025 11:43:36 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b9d73d57328so2924333a12.1
        for <stable@vger.kernel.org>; Wed, 05 Nov 2025 03:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762343014; x=1762947814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdMm81xYZiuBh40gc0Ua6efd+2dzC13cTYSHrMpRHXs=;
        b=IkvOSa7rdK/5qjP/opy4dQuLCC7xg9tY48bEIT/PGJL9k/2xkN7IxRjtWaR444rD+p
         tRwioC5M4JNfa+wQmttuPxudsPJgV0TGpEs2LkOoqZ5tLDeVe1G/dsNPckzXb5rk2QVu
         2fBtKUhJUTldzxSv9MmEUaR7DRmgzc0QxczEyMyWUhvsPZaiJfzMpElIHvlY6A+iY0EN
         sZvFlVWG1iacTXbPgGzVYsVcNCW3QZ/2yOIrwhf7Sm77hiRhymCLHd8BiQk1E3ew7PWo
         s2Z0R7Dp/Qhi1olSnPzKIoUHto4I2RCOGXaZr5/J3Pfsv6mfVbmlc/VqRTG4wvZ+9I0R
         /cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762343014; x=1762947814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdMm81xYZiuBh40gc0Ua6efd+2dzC13cTYSHrMpRHXs=;
        b=IkBkA5cSMrBb1KCliluwummw+TURrABK1OvPHJCCfNZDRrCB1XJml3RPoSbG3SRW0Y
         uADA5pzJmSufJolqKdzlbtSWWR11Rt24EDYp/UAYc4rajRu0Fm2ShHZiLlO00HKeDmrB
         ejyow+ERcv/ljGJJM2eejxLzQWofHtWW0uVj67sbaVJlIH6IEXDkoPJGKczS1cjNYZEJ
         RqiLwJzL8fJ98twzRYVUra8reUbNSRV2WQz+PbGta7eI3etqLxhmmABKnOG3rY+N8sax
         mdrl4tuigPpd6m66NksTKYIJROHzhOAx9zuJhDxITcJk4wAfTBBcR+Orxq+twlq2x7Se
         MTzw==
X-Forwarded-Encrypted: i=1; AJvYcCUelPHd6AbKRP5hXThhnVe/U1Wqe+sBO4z+JpAx+OhMDl+H+P6GwwkBkjdiC4TC8BlDbAEIXIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlJdggtT43+WBYQ75NftcPQ59Zo5KfhpsfCB8gGixVV4Wmj7sP
	42KSJ5AKdiFCLXnHw9vdAWOpz4azfob4IPrHO6zxFMHSVLojGbQ7UYnSo8Nf4pXRI/Oe6J4mZur
	LB6RpiWOL3hXNd91KWIv42UR6RMB+q27toctCFz91icZ71wDJrgmeu4X8l1M=
X-Gm-Gg: ASbGnct5BeNUxAvDwGDW3w5YYjOS+29eOgIFcWbwTi190X50HZ1jXR2eDZJJ8bMUILj
	VD9vFHw3mRzPQBJ6dCSdiuE8tO0mkTd4PGgiP4RWRmhkEW71aYRNo5oJlBUbYNCT0Sk9fwP4jzK
	yIEkzytHhp42V82dpbJiEQG8P0iN2J2Pev0PTL8peHIWTgyZ8+6gcZ8eaay6D51gnRVZhsvyMLn
	0CmTSlyjbLbboQW1TEKnAGJ/05kmUs0jt5IcyaHCDoEhYpSYYoFnjTl3UsOKOS6ZBaphfadbLXe
	gLhiYV2jx/2tUSINksVCON5FlUvV/zFgr4OFMNgAGLh2i5V5hfPq0iyA3qWg291dw9hvu+XxUt+
	rTYUaBJgMV3p9Pjuocrn9+I8vJ1j4mEwy
X-Received: by 2002:a05:6a21:338a:b0:344:97a7:8c68 with SMTP id adf61e73a8af0-34f86114a51mr3703180637.54.1762343014254;
        Wed, 05 Nov 2025 03:43:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq1fw6AQRlBdqYRnyUSOmKR0xWysU4bHGiCWZGyF2QQLzwtoZWe/qua4VlMjRvlHnlxSRLyw==
X-Received: by 2002:a05:6a21:338a:b0:344:97a7:8c68 with SMTP id adf61e73a8af0-34f86114a51mr3703149637.54.1762343013781;
        Wed, 05 Nov 2025 03:43:33 -0800 (PST)
Received: from [192.168.0.171] ([49.205.248.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f765eda9sm5265961a12.18.2025.11.05.03.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 03:43:33 -0800 (PST)
Message-ID: <ba589a5d-65b8-4980-937a-29598e891dd8@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 17:13:27 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] media: iris: Refine internal buffer reconfiguration
 logic for resolution change
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Val Packett <val@packett.cool>
References: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Mt4SKunn4geU2XzS47GRSIljw-A0U1vi
X-Proofpoint-GUID: Mt4SKunn4geU2XzS47GRSIljw-A0U1vi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA4OCBTYWx0ZWRfX4rrrVVgKnxjz
 vSmrf2ZpN/S6WXyrcmPf8ET8EBUdbLnQ2b9LzOTnQ2yTgDz7Zim1n64YbGTB9vot5qG5kDDyfM5
 1Q4wM6EGCo6RfK6LredEHcJTUP37kBS+nK1GR9d1IFUTbc4jlnxeNlGn2yvsWQoJZE17EEBH0mW
 tu31ZrhQ2I8+k46OLeZoWALeyMXyADKyPd3zoSq1pc4LVs+oZJUx/1phQJ0Qdy6Bf8nR7BI6yIG
 uFBcRuhinI3703X1qzdUjgVS9c7fnJfZQwd7AJSdFVNKyCBDpxfCX4R/8pKTz7rmbF2mVA9//h+
 iiLi2qEvpDs4EQHGsyZgc177XtU1/VdDghOv4RH29qwmd0ZUmEQKVWcD8ouSh9xpaWpSUtHg4ci
 MS6fmAo54wdQIlgyK49ScI/H/pFMOw==
X-Authority-Analysis: v=2.4 cv=apS/yCZV c=1 sm=1 tr=0 ts=690b3868 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=AzyGrR4UViKNxLVuAS9Z9g==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=srhs0GdQF8B2Dv3X-aYA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050088

On 11/5/2025 11:17 AM, Dikshita Agarwal wrote:
> Improve the condition used to determine when input internal buffers need
> to be reconfigured during streamon on the capture port. Previously, the
> check relied on the INPUT_PAUSE sub-state, which was also being set
> during seek operations. This led to input buffers being queued multiple
> times to the firmware, causing session errors due to duplicate buffer
> submissions.
>
> This change introduces a more accurate check using the FIRST_IPSC and
> DRC sub-states to ensure that input buffer reconfiguration is triggered
> only during resolution change scenarios, such as streamoff/on on the
> capture port. This avoids duplicate buffer queuing during seek
> operations.
>
> Fixes: c1f8b2cc72ec ("media: iris: handle streamoff/on from client in dynamic resolution change")
> Cc:stable@vger.kernel.org
> Reported-by: Val Packett<val@packett.cool>
> Closes:https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4700
> Signed-off-by: Dikshita Agarwal<dikshita.agarwal@oss.qualcomm.com>

Reviewed-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>



