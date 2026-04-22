Return-Path: <stable+bounces-240290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLrbKRl76GlvKwIAu9opvQ
	(envelope-from <stable+bounces-240290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:39:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF12443068
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D642306BFD3
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8AD372EFB;
	Wed, 22 Apr 2026 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ft4JlUQc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Es3QMxKc"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EDE34D38D
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843465; cv=none; b=WU2d1t2qD3YpMiH50cFcdnakUXsKxtpe7Fd3v4/KO7RG3tyES2cnAM/lGKo90p+wmTSi87PPUhIwQFUpHNVy6DBSGvbWvcLcqivzz3JBpPOnDd54GxSJe1BdFsuv46wzwSdcSve5PIQvT5TN0vhuL3/aKiOdv27mTZ+BCoQthIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843465; c=relaxed/simple;
	bh=yC9ooREPFoPevEeFC7MzV3MUhKTTHk8Dwuly7lWrnGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jum/zqdrhcDY1jUbCLIS0G5xqr/Jz8poLhf9y3UPbuUITUyPXZ7Cf50LxzLoJ2S/0AUrxhdo7ZMyrzzIu7I0kjf6T3YRqN1jOPe1oLXgoSLD0JkghGpdC6wm6YRDnAgnqR83yBG2WlijndsNWeUFHCEG1B33ZkioYnCiZIWMtc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ft4JlUQc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Es3QMxKc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M5FPFW2001071
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 07:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g710tN5HVbxOu4aj5AjgHTCieRGwwYofyR2aDtM7hfs=; b=Ft4JlUQcj8//lmDb
	NFgPRyBG7tuG4sEwV+3ofOBpu5eo1UOpO4mhhvW5tu93Oi115wWu2io/ytfiGxGF
	k9WCXGSfZJsqSE7tAg6ZVUibMf5MmlIU01cajoLQj2zSU3zIsvMUyh52HD2Lr/Jf
	J2PrdD5NFDG6mKghjj6Whgxu3KTRuEibX6dLBWTZyxsJVMCIj0ehjnhWYdhosOrb
	5iIO1Vh8GSecZa9wz//zFsKhSIc1aqy3QTza2yg0tislg68jP8abx4FKgVN+kdZG
	0wVe+SNOEZn/FElHMI6PLNelIYDyArN7XjrBAXI6lBDY4m4JUHdZ+9SPeNMivQ6+
	P4TOUg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfabmg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 07:37:42 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b62da7602a0so2536594a12.2
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 00:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776843462; x=1777448262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g710tN5HVbxOu4aj5AjgHTCieRGwwYofyR2aDtM7hfs=;
        b=Es3QMxKcBpFixC4mG2ALaFegcQZw7ghus2LVroZBiH8FZwiMQR1N0gMGdxLmDdOxPP
         8K/TlvEGfHixRrMSm6Net41fQ7wcso9ORJOTgBUlauxHlq7SeZFwL1Km/jyg+oT4PJ+b
         5Zfoh8Slyrw4QZXgfX3+w+LCvUjC3PylUKf75vL5sR8k03EIrghXsxoG9kJZ+fQtzKjD
         TxKldwmhmuEB2FcA84g0BjyJ8/vqRB5K/CgOKgUCwKuExtBP12HzbEyksiyubVwaMdY+
         5kqkxO79X/L14u6bnbcZEyJ2c1tJtknEIExqNfrP8e+qTHAwtwU8e8s01EaR5/8M3x94
         O4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776843462; x=1777448262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g710tN5HVbxOu4aj5AjgHTCieRGwwYofyR2aDtM7hfs=;
        b=TJYbTxWv01Ch2gCgTbx2RE7LK9Reo6qEi5XwyFYiaQ+8Rgo5zrVI/GbJWjBPjzAB6m
         9HQsztLvD47Cx5MNfbBo2gifDcZ5IvxiinT5uw0n5S77BE98VzCj/e8FU7G9s/vW5Vfs
         ZD8APgU3Tnm52fTQPsUpQcV9vwcOC6EAJnL4i5pYYVkhiuepZCqpj9GGiTtRoLhokxyi
         vn2KEpeWZcaqvpeFaR/8rErHXQJaLK/1Yh+XZpgORaPmS98kjN6iw0b+BTA9r+9Y7CaE
         LRkH1JlTOoNB+cc/kU9Sk7gKvOCMCg4QIaUINd+QLiK1kdrSzof7ksYlCGXwoSIJXBvh
         lrWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9k8v/tKVetfq5ah5v9i312tMqMFnE/ciZFt8965hs6ZZDLbw6LL2O9W3nN7lhJM3kL19qI5uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIjC5f/9g/aVCaTBFacocxx9N8SYh/2Lg2KZ6OT8q9OhKPrjy+
	nHf7lAJBf2zEwZ449kJBSBh2Z3aPrsGPde7xKTGWFuj+VMQJmAGHm+xoV8ZGgVs57lnOrzaT5Om
	0DIQXrDPG9Lqc+2IexrpPsuyFwo55tGg5jnD3dEtER6iKjJ+jjxRGFCyYNgM=
X-Gm-Gg: AeBDietsCv/GSUfbfQlegjJj3OlQx/KGCaAHWsCHqCXp7hfEWhB8JK9TjVf+H4uXFO6
	s4FG0A7lKDwh3bzz2JXrF/SCU47+he4nyIm68rmnP2fFT1QE876/9eez70scJlMVmKU6pOCr/uV
	+Z6/yNHM4fMK0H3liHiO4BgMR6Nbai+cfXQrhIFdiEB+O6c83GztY8YT2YBMNqRXw4wJgUZEJHu
	NDWxOgDi2oRtVDyKrJeAmms4Cs3Znpn/pbEZKYTXZb9FlnCKvj/bwMMXMTyhO9HCOipFG7ZnglM
	z5gnQb7Jf/amNMgkBNnh0YCGwhiy01ThookM0gu1KuFHeRxSRrri1BJ45myZWdb1Nkn3I55Yges
	AKzfIfO5aUxLis5O8qLehNS0OozmpYEtUiLzFJSs/GQ9wrtKexH0UVkKrIKmKeVlY
X-Received: by 2002:a05:6a20:2590:b0:3a0:bc61:62e5 with SMTP id adf61e73a8af0-3a0bc6165damr16766856637.44.1776843461665;
        Wed, 22 Apr 2026 00:37:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:2590:b0:3a0:bc61:62e5 with SMTP id adf61e73a8af0-3a0bc6165damr16766815637.44.1776843461143;
        Wed, 22 Apr 2026 00:37:41 -0700 (PDT)
Received: from [10.206.101.19] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79770512afsm12391799a12.31.2026.04.22.00.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 00:37:40 -0700 (PDT)
Message-ID: <88b38699-aa1a-42b9-8d2e-6139c1ced4fb@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 13:07:10 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] media: iris: Fix VM count passed to firmware
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, stable@vger.kernel.org
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2wvPVEwxsDq17kacRGRpa514vQKbRt-M
X-Authority-Analysis: v=2.4 cv=fozsol4f c=1 sm=1 tr=0 ts=69e87ac6 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UlvO0n_oXqfwqGaIblEA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA3MSBTYWx0ZWRfX0g76WPmKn1Ai
 koCZ7cCyPDbXJH6x8G7K0So2icFx+n4lmNshpAC+AF9GqxzRlmnDnXakXNBqLR7+DXSgF6MDtDt
 bWM3QtS/7dNPEqfNmFWDAL+Ze82kv4dQNGFm4iRoaz7T8yUpgyl/68dXnapDf/t2UttevW/cxN5
 U7DpCWdpRj/Z/BmlkmcG27Upjb2fm30b+5LyfWjcwmc0Fx5v4WWmzXpNk2RNWrZevTou8/RnW1m
 lKoRyMw452PnH/UAyhs4fDDcCwzK4amW4kIUrsJ1aSCuWQ5hvnM6avBR2A4gY+umyVj487ZkpNr
 ZTjeyPfHOfUJB/wV96k63KVRs27QsSMXz7fbgobI1AxkDmTm66abicvIHMK5xem5dkPVM1DntON
 swwUDR3FDj7CviZNm6Rcs7KWV1GJydvy22VJgzbI0tR9kmtKOuvdAjt4Oq6+IpQmURu+GqtkD89
 +c5EfFBx9dTkGWGRsAQ==
X-Proofpoint-GUID: 2wvPVEwxsDq17kacRGRpa514vQKbRt-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220071
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240290-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikash.garodia@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5DF12443068
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/14/2026 10:30 AM, Vishnu Reddy wrote:
> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
> the number of virtual machines (VMs) and internally adds 1 to it. Writing
> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
> remove this write to leave the register at its reset value of 0. This does
> not affect other platforms as only Glymur firmware uses this register,
> earlier platform firmwares ignore it.
> 
> Fixes: abf5bac63f68a ("media: iris: implement the boot sequence of the firmware")
> Cc:stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

