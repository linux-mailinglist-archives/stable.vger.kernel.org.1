Return-Path: <stable+bounces-118636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F4FA3FFC1
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 20:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526A017A135
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38841FBEB6;
	Fri, 21 Feb 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mhclx1gV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271DF1CD1E1
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166455; cv=none; b=FdDM2wPPJgRiezrfj4fUzy+wzn50XTHkFdxdA1RbniSrUgo5CIIe08uq90wLQRUGjnvi95jys2oJrhEMFJWlXHLQJj/MnjvOwaYwRXMBEPemA3vUbeuQk/DdqsDWVyt2WHRQbUE1z2dJDzzCX3fe3VvPmJ+lqdKboZlXlAyWVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166455; c=relaxed/simple;
	bh=u6TaScNZ/DU4r4jwpXk2osYnJ17lzPB8FM3VjxjHDuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fymd5xrdZtgRcG1wil3XzpV1uG2bkuT8qpXKHEoX1Qb9meN4q1wV66wT8Io7Y+PHcelAvfZGZdRME95WmpQO6AJL0JlzEXvtoKo+Mj7W+32Qqe1uEv5/WCC/fvqI7Mq3IoocF+8d9SkQ+QrBgeHMaMW1K2g+2L9b0F92z6nqRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mhclx1gV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LE2dHV020402
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 19:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pHtrFdX4sDiVFBmCYWlwT5oKJhWKWB+bSduK5G48vLE=; b=Mhclx1gVMAt/xjj2
	/2YSTJcRCyjP6bRzINGYRfjwmDsZcFyqmM8IHxMCaZq+LlibMpDTJlbQIyCm4RPy
	NUqKwQoQCLjr/DKSHKIYxAWMWM9p2OCMwsoWbwbtZ34mKtHvRjcMTIlPFNMxupvy
	bFPKSBx3YD96vLB7n0MdXfBtGYGnspIviVEWjSaMNUE/braRdnrne0Q4JBpBV51L
	NZEb9dWAijWzvX1htHCOIt3CSptBQuuWtACLHUs3AEtuIE9PEZP64w1BIO94soa0
	QwzF0L1itJvA8jVkZ70siueiHa3cG9oJAGKK5+T2Ls+NQPFTkPj+uLdLE3Oc9yRK
	Z4qjCQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44x06t5qh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 19:34:13 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e422f1ceadso4615316d6.0
        for <stable@vger.kernel.org>; Fri, 21 Feb 2025 11:34:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740166452; x=1740771252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHtrFdX4sDiVFBmCYWlwT5oKJhWKWB+bSduK5G48vLE=;
        b=lt/C3vf0EN6oLxS53xyqa1RFzQkQOoimbr6He1rW3MGcruEDnKLLDYCHEDFQpZsah2
         5bkwStdiv3SKci+JLMBp6j4ICgrjQTecreAY5yauTmJH8QYPWcXt6vKA4BY/yNb49TUr
         Ss/LnNrk9FVc0H8eLATg0ISiJaVf2X52V4QecUdLGAem5yfvgyZKhB8DFvEeGXhWixDc
         FvRV/sfZquluX4/2IcFKR0qxdqiCDw0pSuze8gz1G7NQL1hEqt9bO53Z3MvmlpZoD2aW
         Ntm0qv9b6BXO4mFKVQcNcs3L4DNqCy7JHrQFCHP1P5sb57imsghCZNKCWZ2Lvb5w53Zi
         61AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf23J+6fv3c7HcU5TSd+i0W15UZ+T58aqHg7YTnWi5yDBxsxwNsfjW6NCijYysBcDwWx5EI3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSOCgoTEfAwNoESxBVjhB36FsIom24RJcumB/6tyJhdDVT/oVE
	PjL1gxTIRqA9hAXrABwy4MBeUfLg13507JNsRfhIpSBsnY+Xkjix6E+pO4NO68CtYkLdtSwaV1Z
	miaIeQYJJXMwZQDrbpOfxYvzXxPsMnTim9d6wSsCFbQgPq6YX93Gi1Pk=
X-Gm-Gg: ASbGnctvgS+E45GLUK16N/MBgbHqGRIViMakpAhm+n3dH8x1UnYx3TekAYAAkqnNdwr
	MbSW1S9zkaVLnxno805gbY+Fc/rbhUnialHM7E1EJ2hvupAyBdNS+ToAI5Kju4E7X2NUxnZcfr4
	FGKSQ1qF9dHw/WvlP6tfAF8So2YWDM6tKg6qzrDdJ3q8ihmYw8l2APS+UzAJVQ/JqBhAngS9/CW
	pzg4qmOW+H8DnVbxKnorKpsyNV1NA2ynbcDKWFA6ShXZbkzPRrWn6OwqC8Rs9ESsQRNQDdBpWjL
	5gUe1X4GwnZhNG2G0Ni2HtNtVWP/bp1P1gdSdecoYXXdPpmhUB7wlJIdM60ch5IHrxeMVw==
X-Received: by 2002:a05:6214:4005:b0:6e4:4f27:7754 with SMTP id 6a1803df08f44-6e6ae8019b7mr20341046d6.4.1740166451825;
        Fri, 21 Feb 2025 11:34:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMRtFP8L9pwSmUTIIxeADi+goeh9v8A2IJATffBawES3MorlO92k2n4DJ2B9zsNBuYEj7soA==
X-Received: by 2002:a05:6214:4005:b0:6e4:4f27:7754 with SMTP id 6a1803df08f44-6e6ae8019b7mr20340816d6.4.1740166451399;
        Fri, 21 Feb 2025 11:34:11 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb93874686sm1091861166b.0.2025.02.21.11.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 11:34:10 -0800 (PST)
Message-ID: <9d330824-58b4-4c19-b778-9b000eb4d20a@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 20:34:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: rgb: leds-qcom-lpg: Fix pwm resolution for Hi-Res
 PWMs
To: Abel Vesa <abel.vesa@linaro.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Cc: Kamal Wadhwa <quic_kamalw@quicinc.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johan Hovold <johan@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lJWg1D0meUn2dPJ9E4MEBAWull42ijV8
X-Proofpoint-GUID: lJWg1D0meUn2dPJ9E4MEBAWull42ijV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxlogscore=840 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210134

On 20.02.2025 11:31 AM, Abel Vesa wrote:
> Currently, for the high resolution PWMs, the resolution, clock,
> pre-divider and exponent are being selected based on period. Basically,
> the implementation loops over each one of these and tries to find the
> closest (higher) period based on the following formula:
> 
>                           period * refclk
> prediv_exp = log2 -------------------------------------
>                     NSEC_PER_SEC * pre_div * resolution
> 
> Since the resolution is power of 2, the actual period resulting is
> usually higher than what the resolution allows. That's why the duty
> cycle requested needs to be capped to the maximum value allowed by the
> resolution (known as PWM size).
> 
> Here is an example of how this can happen:
> 
> For a requested period of 5000000, the best clock is 19.2MHz, the best
> prediv is 5, the best exponent is 6 and the best resolution is 256.
> 
> Then, the pwm value is determined based on requested period and duty
> cycle, best prediv, best exponent and best clock, using the following
> formula:
> 
>                             duty * refclk
> pwm_value = ----------------------------------------------
>                 NSEC_PER_SEC * prediv * (1 << prediv_exp)
> 
> So in this specific scenario:
> 
> (5000000 * 19200000) / (1000000000 * 5 * (1 << 64)) = 300
> 
> With a resolution of 8 bits, this pwm value obviously goes over.
> 
> Therefore, the max pwm value allowed needs to be 255.
> 
> If not, the PMIC internal logic will only value that is under the set PWM
> size, resulting in a wrapped around PWM value.
> 
> This has been observed on Lenovo Thinkpad T14s Gen6 (LCD panel version)
> which uses one of the PMK8550 to control the LCD backlight.
> 
> Fix the value of the PWM by capping to a max based on the chosen
> resolution (PWM size).
> 
> Cc: stable@vger.kernel.org    # 6.4
> Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high resolution PWM")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Maybe Anjelique would know better, but the computer tells me PMK8550 has
a 1*4*(not 15)-bit PWM controller.. I don't know if it's related, but
something to keep in mind

Konrad

