Return-Path: <stable+bounces-151447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C2CACE211
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AAA3A16DA
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD681624C5;
	Wed,  4 Jun 2025 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MJf2oh15"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A7339A1
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053895; cv=none; b=L38x+g5XBjtHYyJ/5sohWr6tsTPcW8rjJ0cbFBraRsui3mkv0ZENbghqgWr6OtZHmUMJfVejJWSUP0PGjhM4U5yHGQKLB02F6KGe2I+yUOIns2Twx/ypyM6ItQuLxU8mNPQo0VD+/Elr0ruxhKCYb2Gi5qG7rB+fKqwi/dgoDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053895; c=relaxed/simple;
	bh=7MowuELV49A6vO/Jfah08WGLvL3dsHGBOzLVv1nf/Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TD+xV6xlit1FSnTaTpKZ/tjkzZ3Xd1UapUFBYRZPTaYe/bR5v/v/FscQMMqQrk9DD++WtyK4q1AU8AD8tf97VJ6g0x2YYZvdXeXDD1ceyVac/tzxEcspuovRWa4mKRFfLVKx4kI8Lgr7QjqgbclgX9PjK2XA/wJsAtW6sEc7Lig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MJf2oh15; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5547gt0d013476
	for <stable@vger.kernel.org>; Wed, 4 Jun 2025 16:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/FKalLodIY+3cT9Xt0G1l7UIsgPISWBmeyASaI94Pws=; b=MJf2oh1583p/fAql
	cBM6gNOQUiQ08Q8LoFU7I679R315ixTjNItYAbyN/93DrpJbZNPHi89pnTqW8LQx
	PVQhlUmM94eVf8EEA8W/HkgjM1onIAFG0fWSyZRr5qZwT08/vO7US2WWLMQiAlEb
	rnsZ/uQZj/WVwuBGfaQi6DqT89+OLVpl4796ihbJ5SEKmYmOhrkQV98qdhrdtB0R
	NRSrfs8BqWpC+nLyuIIHEOmcJ3owTkeGiaED+8quTpLHzoR2EEj1hQQwjU+BmVRm
	a5U6CHrp/xwAoQdZB0qs82IJ5g9WDENpvSYuPEH+u0JS5cRt2DBV5wGY/ocmajRL
	0P24Pg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8npnsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Jun 2025 16:18:12 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-747fa83d81dso48718b3a.3
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 09:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749053891; x=1749658691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FKalLodIY+3cT9Xt0G1l7UIsgPISWBmeyASaI94Pws=;
        b=GXs6qpP8+Z0uBJjW7IaahLh6cMbb+RDl0Dycxj5UBAMH/SPcGMkJ8GR5CtTEC4f7LJ
         qPjV2z8WQ92ctYVi+q8VT2IYkO0WgrxDpubEbwnnZ/rhECLky4Ydx85ZxIvjP7m8QWD1
         MtdYxVdxMdlQFm3uwBDZ+QklSwjV2jmpH8YTJoNEj3hkDcGPv2DsZDBl+U7OraRrvz9L
         sXM4pSP8pFqFKZ/oBPMNR2MbIlvmJcuW0zzs5wxFLfysrJ8/OrBXLnyd13TD/TJXS4ut
         n1e3CRRmV87g5hh8gtkRmlcF304GhXEvw4LKinSnKc/AYk8CWnd+v7dehoq/vlYQ2xDs
         AHWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkGTr5++xoW3QvgR37m9sEeOsXwBCbJ/uqnp4vT5/bYBwbMIly+rSlR93O0K7uYTKNCCjzLfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjxGpAph+qeTmQT/bSY6QO+QxtmnCwH+7oNcqyiSt58QKRSuQJ
	HE589Ak/SGjNZUwm6fl0g6rX8cTcuDnrffSi/hvXiwhzur5k2mA9H8yzitLgbE7jLwR7Mmgw+NI
	+l3N+wBji2HLNDCSHnLk/xHoquR0Usjx6EmsYNcYzLKoLlnBj60zx3p1xCdGcUeLpivk=
X-Gm-Gg: ASbGnctqnlklvvlGf188DVuyhrAR8pBpv1ADFYkB6EWmbwT5TnCpm+Xq/BlUqreOS40
	3GgHPeupyycRH5AAfSRM39WhleBO8/TA9/p5tVQ05B1vb41uN+jLnT535LvP9r31ipH0x3iO0b5
	PlDVjQE/+5iccARf3WkpwjQZJJCQ+mAwcAE21qKIVCvjPLe/PjuVvoahgedD0a9EiCmZP/rMPJA
	MwxCMVKtV3YmbZM3LgujNB3MWV54M8vHiFV8J2syY61vLHVyovz8HwYqek0ruuWN4oV9SFlMOcP
	NQ09gtQRkJGTgAgU6oNefkpnWfiZ1JGrijzPO1/EVPZOKAC2LbnitwKpr9uBxwbwsmbADVRt
X-Received: by 2002:a05:6a21:338f:b0:1f5:92ac:d6a1 with SMTP id adf61e73a8af0-21d22a6d399mr5102658637.4.1749053891319;
        Wed, 04 Jun 2025 09:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHso7G09k9UvuycvraO1NDz4fm/Vag8N+EPM5/nbAn3PNvuV5tem1zGbbXZtmexx1nDcVU5uQ==
X-Received: by 2002:a05:6a21:338f:b0:1f5:92ac:d6a1 with SMTP id adf61e73a8af0-21d22a6d399mr5102616637.4.1749053890774;
        Wed, 04 Jun 2025 09:18:10 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb02e93sm8956129a12.16.2025.06.04.09.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 09:18:10 -0700 (PDT)
Message-ID: <0423ac43-0a12-4f0f-ade3-61364d4abf93@oss.qualcomm.com>
Date: Wed, 4 Jun 2025 10:18:08 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Reorder doorbell unregister and command queue
 destruction
To: Maciej Falkowski <maciej.falkowski@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jacek.lawrynowicz@linux.intel.com,
        lizhi.hou@amd.com, Karol Wachowski <karol.wachowski@intel.com>,
        stable@vger.kernel.org
References: <20250604154450.1209596-1-maciej.falkowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250604154450.1209596-1-maciej.falkowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vsK-WVmJkgy1okLHB8ROc-6qvNqPSN5m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEyMyBTYWx0ZWRfX3l5dXZ2BugmW
 5xZLvhrVRQhLZ3CXlJPh6qR3h/wApkF9Ztsa/ChfxCv3b8shpmTFMc7AS6+N3BazZDjxIXiy+WD
 oSReBQuQAhsSetOlynijP0a6ILzepnYnVOk/m+MxC6twCxdRxn2ts4nZUNO8tyFmkQ+eVcoZsFZ
 02TWdN7HgVwCAufIUAvIyP/fZ2LDCV+m3iWElF9NC8kk1yRbID4BI8fc4LVURxLrBsirBi0wKmi
 gNjTR6I3rzRh6QwCYD3kK/9RcGMrpjLw7ywgMO9TRe70qYpLV33WhvPsa65VavZBTVV9ZiPbjI8
 Aw4guvlwqjJ1BJQpSOI1GUF9Mp6uxIGzJlt/+qJLuibylIrfDLC+B8vkeiv9AymPLfvCItctNoI
 iMZpjtIF3P370x850TtbAEULOEqRuumOh0/4JbY7pSqUcSacYuk5yFnurZXrGM0DRqA5qSoz
X-Proofpoint-ORIG-GUID: vsK-WVmJkgy1okLHB8ROc-6qvNqPSN5m
X-Authority-Analysis: v=2.4 cv=UphjN/wB c=1 sm=1 tr=0 ts=684071c4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=XIlkvbPez1Y0lOnEMrgA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040123

On 6/4/2025 9:44 AM, Maciej Falkowski wrote:
> From: Karol Wachowski <karol.wachowski@intel.com>
> 
> Refactor ivpu_cmdq_unregister() to ensure the doorbell is unregistered
> before destroying the command queue. The NPU firmware requires doorbells
> to be unregistered prior to command queue destruction.
> 
> If doorbell remains registered when command queue destroy command is sent
> firmware will automatically unregister the doorbell, making subsequent
> unregister attempts no-operations (NOPs).
> 
> Ensure compliance with firmware expectations by moving the doorbell
> unregister call ahead of the command queue destruction logic,
> thus preventing unnecessary NOP operation.
> 
> Fixes: 2a18ceff9482 ("accel/ivpu: Implement support for hardware scheduler")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
> Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>

Huh?  This was posted to the list on May 15th, and Jacek applied it to 
drm-misc-fixes on May 28th.

-Jeff

