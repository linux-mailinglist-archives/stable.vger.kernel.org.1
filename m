Return-Path: <stable+bounces-132892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3496A911DF
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 05:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF7D3B764A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 03:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C7DEAE7;
	Thu, 17 Apr 2025 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UTfdMA9g"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21C1A5B97
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859438; cv=none; b=d+cfbaQE94Nhv4a4LrnyQM1Q1zKtNREYxDsSh1kqmYin+RAMMyoE3gesjskRBstn4i7g6v2f8DAP4Q3N8xu+w15voxCU9V2cO29b3owYVMPqFyHHRWwNMPATvw8W0Q8fx3gjmT4V6MelE2OivYFFCfIC81TSjARVdD+MeiWXR08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859438; c=relaxed/simple;
	bh=o9y4FA3aNLZbyWWDp7aV1XEs6zzKYLSHjLT7Bv4PQUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5DEYHBuJctF9KwtTueIeOGyo8RVkcGnvD8HoUgy5QWOI3ziRLxZeJViNC67pSJZH9dEeYly0EJiHEpddpZikdAddXK3kP0xn0uUEGc26YvsgOm2atqLeiIHSvzPbeCrXc555ZPxsHckBQ7r1JADj4xuxZ8WKTBmb1VOhODOsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UTfdMA9g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GLSF3g020861
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 03:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B06cmnmKQ/e4lBuzsfgMOX3tkGNEqZOKRqnJxUEVdDQ=; b=UTfdMA9gYYxNVvnp
	j+VtBxs1trH5eaLlmwBM+bUo93KQ+UuA2hvlz94sf4jKlYyDxg7Mu0C/P2JBe/8w
	XfLrm7tYJ5PAqdHuOtJ7Jse5DVij6Bpe0/ag/G+pCs6rtQw31QP87ZXF3hPpHSkw
	fd3CQ0a0qAXmKIiP9Jo/XlSskr1e61bkY4NdNGuvj/Z2YpUuOjAPn+v/cKKPsHBM
	RozflIWv9DAeH3sITiZf7oGOjnuxe/x/1OC9HyS+VlEmc/kThbc6teX+R1QN8/xH
	fy5ND06gNXH1mOUZPbbPgJb7ShL/cfO0YuLTay/cE2eOhKsXDH+pnyxNcwDlAYpB
	qLah4w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wngbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 03:10:35 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-73c2f5c284cso307191b3a.3
        for <stable@vger.kernel.org>; Wed, 16 Apr 2025 20:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744859434; x=1745464234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B06cmnmKQ/e4lBuzsfgMOX3tkGNEqZOKRqnJxUEVdDQ=;
        b=BbfP3APELOEgDSzN+8f7XPiDOfW3NUPWotD/EVNtgPbEAGgOjrOR6sR6agYJOdBrPy
         ohbomwh5Lo1L7Q1T8CQArErhAocFqha/cugC7U0QRMhHi9IjPQ0Jf1QSibiW6Zm3ZRT1
         xeytYe3NEA2PylyGJFt9gCQHEGWPzMCeHVbIqrRS5p3XMosUpFRBV7NCZU3cybuvZX84
         9J2Yrx6ufwg55ShY46TdRNxc4rM6/hThmMkRCpo8dSgWzWvE/2vy6RMK2aMPvwPcGGCv
         Y6er/Bw5k0ff4L8PnHRcJClItHsfYENJDh26/d21akmmu8Me0h/HGZXHcNBbFEzfa9G1
         1QkA==
X-Forwarded-Encrypted: i=1; AJvYcCWZWEFqjltGnSxWcTyykmNBhiuoOZPQ4CPCPToCzvSgbH8xE70QeYpRycu54tBk4hPwINgxRQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJmcsTxgo+XdjeEvPE1Q8GZ6mY2hp4d8AfxabmCTIS+hn33y5i
	n84d78d2kDU+a24VtvXLZ0LFsfYZyhV1idFE29Tk+laYstxxWYuwM2rl1+JOsxIu5cu8aGjDlM/
	59rB1n2qF9QiFUJ+kDhsnNlw+tZC1riEvhYtX9w5b+LstbBHX8dXRZtg=
X-Gm-Gg: ASbGncuOqWjaTN2v1HBjgT3eW2gn3nTN2UGH4laWSEG9BL0Xf50t+KJDJ9N80cnZQBl
	y8RoYzZUsa/TbN+8/RXOwjiObxgKAHQtSm/YWXIaA16go96pOgkmaiASM+Ywt2f0araCX3nPcD1
	wUQy6uNDIvpzjgm/iwlnyl9V7iH6xejMBRiCK9I4ujP2N0XI0vuuu6fC3856e3+m7IssK/6NrBw
	/JzxefH4bitf9h0HNHyY1jzI89PE/LDUij7NEFwvW6D1z278vGFLOjDPa8cmY01pkVBm2mz/f9l
	QAF0bMmvqSXg+Yp4HsFmFnByQ65fQ88+/lmL404LpEHpdNsdakieFxzERfJgcYmjhnd0Ttj1QHw
	=
X-Received: by 2002:a05:6a00:aa8d:b0:736:5dc6:a14f with SMTP id d2e1a72fcca58-73c267f5570mr6280119b3a.23.1744859434526;
        Wed, 16 Apr 2025 20:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+DXP8JMSvGrHZjJsmoeGenB3qJ6DAEmao0itPYYQeugkAmnDao/XushMt4kTACYRmrh9dMw==
X-Received: by 2002:a05:6a00:aa8d:b0:736:5dc6:a14f with SMTP id d2e1a72fcca58-73c267f5570mr6280079b3a.23.1744859434064;
        Wed, 16 Apr 2025 20:10:34 -0700 (PDT)
Received: from [10.133.33.156] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230ea65sm11240920b3a.154.2025.04.16.20.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 20:10:33 -0700 (PDT)
Message-ID: <bb3248f1-3a7d-4a60-8e3a-68c0595ea50a@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 11:10:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 084/731] wifi: ath11k: update channel list in reg
 notifier instead reg worker
To: Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc: patches@lists.linux.dev, Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Sasha Levin
 <sashal@kernel.org>, quic_bqiang@quicinc.com
References: <20250408104914.247897328@linuxfoundation.org>
 <20250408104916.224926328@linuxfoundation.org>
 <5cd9db3f-4abf-4b66-b401-633508e905ac@kernel.org>
 <49b98882-6a69-48b8-af0c-01f78373d0ef@quicinc.com>
 <4c5f9d38-ae5d-4599-bd9d-785f6eff48f9@oss.qualcomm.com>
 <ff6d7143-33e3-4df5-ada2-df8c99d1993d@kernel.org>
Content-Language: en-US
From: Kang Yang <kang.yang@oss.qualcomm.com>
In-Reply-To: <ff6d7143-33e3-4df5-ada2-df8c99d1993d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=6800712b cx=c_pps a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=71oygjJcY_BwH7B_oqQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: WyO1ttZ5UQxggP8UsvP5DR7FoqDnMCEb
X-Proofpoint-GUID: WyO1ttZ5UQxggP8UsvP5DR7FoqDnMCEb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170023


On 4/16/2025 4:03 PM, Jiri Slaby wrote:
> On 16. 04. 25, 9:31, Kang Yang wrote:
>>>> Ah, what about:
>>>> commit 02aae8e2f957adc1b15b6b8055316f8a154ac3f5
>>>> Author: Wen Gong <quic_wgong@quicinc.com>
>>>> Date:   Fri Jan 17 14:17:37 2025 +0800
>>>>
>>>>      wifi: ath11k: update channel list in worker when wait flag is set
>>>>
>>>> ?
>>>
>>>
>>> Yes, please add this patch. It will minimize the occupation time of 
>>> rtnl_lock.
>>>
>>> You can retry and check if this warning will show again.
>>>
>>>
>>
>> Hi, Jiri, Greg:
>>
>>      Have you added this patch and verified it?
>
> Yes, it works for me for a couple of days already.


Got it. So do you know when they will backport this patch into 6.14?

Do we need to do something?





