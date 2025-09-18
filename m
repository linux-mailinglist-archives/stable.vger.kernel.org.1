Return-Path: <stable+bounces-180484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2A1B83022
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 07:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3D0620299
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 05:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E9C29BDA3;
	Thu, 18 Sep 2025 05:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WL9KdHv7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DEA29BDBC
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 05:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758173167; cv=none; b=g4IHD/wJKBz+ZGDaCSSVjQhLArpdMSv5ddkcNaKKe6003nJc0iyK576ZI52YExfKf616HurX3szn6ECq/myIhCFFxToo38aaZzhG0BLRudKL+VPCtmWgYCJfDxqdKnV+PaM+v+17ZcrRedxNAtShpLnJ8UaxlXgk3SAKFS7HoiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758173167; c=relaxed/simple;
	bh=4QtD3PPTO8FXZFLGpokMAo9A/yPWm/TWfx9Z+Fa1zRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6AV0r5B+5wQjAlGKoSX1FBODrBVCsjh2AD9+L3s5r/PpltzqzxzrojH5hmuX/M5S98XN75FwfhgN/PqJDKgseejWgBjPDE0R+88SPHhH4pOMBAbz4M0sjEhSyrKA0p2LdLkFIkOAtmRLX987LXP9f55rccIGZuZE1+Strv8Q0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WL9KdHv7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I4i4ZB017659
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 05:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TxLEQ1yAcsKflfwl/4WqUC9+qcQ3v/8QuoGR2gXv2U0=; b=WL9KdHv7HW9HW90u
	d+7MCah+mYm9FJJHBOJ4+Nra6vgICv7wWVTvka5SuO6C6vzuEvjpQEH7NJSGv+vZ
	0DMSF6G47Xc8nYoQ9k1rw5eW6+onbyyzU0zJXeZQpRNhZeETgp0T3DTwOrFl4HA1
	4FhiON6lHwfCP5vjmk4uDxAE5eLPTkQUznyNhtL3PMeAY7lDUJoK8v+eWa568lGp
	Cx8pAJBOIbyCTsX0+/ru2BNGm1gjlmHLIPTB2vU4XaLtmWUJrHAXvc9pE1eRD7nc
	Zu6gNNeoWBZ656GGX1TEVJxipOH7N+7WAMqgUKC9sh3ssOLgtfgvnJ3mr8AQqgi6
	h2W38g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982de9hsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 05:26:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445806b18aso7424125ad.1
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 22:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758173163; x=1758777963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxLEQ1yAcsKflfwl/4WqUC9+qcQ3v/8QuoGR2gXv2U0=;
        b=oAx/QXFnEDMHpIZrRgTKKkSSg81JLUInzwX4mCR0quw2V7cyB7uHIbekF54QLZOI5T
         0XEeqq1MMbRoL419QHlimONxGnioxvjdcF5jcxEYdqjcCoawg287HoeDU6x4EPdIkqQT
         7FLKYi8rcmo1F0lpnSn9oQYVlBVGjtqjnN+HQbyieyFnSSGIiCwc3dx7fHawrpjt4Tr7
         ObFGfpwsgIOL5CHb2+CepflV+rVxwfdASgymd43JeSzPQbE0asRj59MZOHSsrlgFVKRY
         8WYjTYx2N57VNYKl4NbxdBEbXhN5NgylskHYxa5c9q6xTKDcQWq30spXc/c9rY4dB5HP
         6iWg==
X-Forwarded-Encrypted: i=1; AJvYcCUG/EQcKD71m3uJF6O3bBX9q1McV49uwpMJQxHBhqz2Af8uAx6APjFuPe0HoJg7feDwN4PyzT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZt6icYIQ9M+igZLGj/xWjw+k6dum6SOqG/E+V3YSa1CGbBt/t
	A7Kw64WrO24+V/UVBh8+VqK7aSDl0LceSZglvElvF+YUgpzxzGWhmNoB3v/b8dc+yYM1Yh8npaV
	pszQx2Vc2/hU2n6cq/B0QHMLjN5tFQTgp3ryCyQWvmr0vXWp8aLciRl7ol5Q=
X-Gm-Gg: ASbGncvivMVls46eTP7lNtbUAqoL6ZuKvRe7wpXR9sazyZouZiLGM+AF+gS8fczIRHK
	aAOEtod6tu2BGMSxJwcwBO6El3b2vx5eqPqqJNMRUezu9dWajYWuETGsWUNfN0QS79dMS/CfuqD
	beFGJXzQjXxmpuemUd8FrVV1Vu7YZgt7SIoSCltWpf5d7SSkTvME86+C3uW1HISl7AgUPWChW98
	Ql0wxS9WPhvX9aiHeQkkL/aZ3VRgg7QbmNJRvf/HWNuwYUtlWavCn2Ec0Sr0WSz5IrYDvSYpQBE
	6tRQddvCcXxWxrfl7d2SxXYnVGtBtfFkxiNKkjCsocqHMsT7/tg7+l5ZZmRHsJQnRW4Bjrp0svR
	zJjvRLQ==
X-Received: by 2002:a17:902:d2ca:b0:250:b622:c750 with SMTP id d9443c01a7336-26812382744mr59356165ad.27.1758173163189;
        Wed, 17 Sep 2025 22:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2eKaVeUCfIArMi6p8GZxEhLIWooff9a8Rntl8i99RgFCyRT1yLmP+U1U71pJsFcKLBylAJg==
X-Received: by 2002:a17:902:d2ca:b0:250:b622:c750 with SMTP id d9443c01a7336-26812382744mr59355985ad.27.1758173162768;
        Wed, 17 Sep 2025 22:26:02 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de963sm12704935ad.77.2025.09.17.22.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 22:26:02 -0700 (PDT)
Message-ID: <36e9b150-fcf4-db45-54d8-a157201e516a@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 10:55:58 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath11k: fix NULL derefence in ath11k_qmi_m3_load()
Content-Language: en-US
To: Matvey Kovalev <matvey.kovalev@ispras.ru>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
References: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cb97ec cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8
 a=xjQjg--fAAAA:8 a=EUspDBNiAAAA:8 a=nfJR6hy_ZLdhEb8FW4cA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22 a=QM_-zKB-Ew0MsOlNKMB5:22
 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-GUID: Zp3wtUnZUucSwwDqde6rRbWW0D3V4g_z
X-Proofpoint-ORIG-GUID: Zp3wtUnZUucSwwDqde6rRbWW0D3V4g_z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfX212YsCpyNny2
 hQ/N7b+tT7Ircu4POHu7zuW2zph0Fy47WJoRqMoumrOS9J1oTSZ0o7b1YF5+ka0X6rP/kuxZk83
 eLKYhh1cRd2FPDs24joSb8Epi7DtKgnO7V0jDlQSRD1rgNNJ9jPQcLePXxp1zY8g57Il9hSFWLK
 mBwXDqT989oyHjlrJnHwhmGgNIygiSy0LqtEYAGeq9bQNQF8o/Rfbfwf4e4KWKEgiekQiTC9E+E
 RyAMGOtg6g4wogpmqiLZdiT8MI4QXIIMIDjWzm6nig0h8r+ZtlKNBxvlzGwcKeMczlLXwxBYUcN
 m+l+XLBvkSOskZ2oA6V9IID8fvUrHm/fxXb2VZ9hzNeIde31kvTCh11SAY8hTfboNaAcD0uBPvf
 N0QjIIkC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182



On 9/18/2025 12:50 AM, Matvey Kovalev wrote:
> If ab->fw.m3_data points to data, then fw pointer remains null.
> Further, if m3_mem is not allocated, then fw is dereferenced to be
> passed to ath11k_err function.
> 
> Replace fw->size by m3_len.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 7db88b962f06 ("wifi: ath11k: add firmware-2.bin support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

