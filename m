Return-Path: <stable+bounces-206334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B768D03EB6
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 692133079A15
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885F2221FC6;
	Thu,  8 Jan 2026 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X3RCdc2o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RBs3eTJq"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87C9428FD1
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874677; cv=none; b=UMZOkk2IWVJYO7Bx7LD0norJUAuH4sj9PN/3gkvtcWAXgSfZ/q5RN18tgs/0SmCarkXyfCxyzigXCIj+2u7T6O5YKRMyK2ImrgCbV2o53L+A26GaOn13y+AeuFDuwQNcx5/UrPOEq6ezJYCP47mm8yiKpZuMvfav78AjjjU7a+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874677; c=relaxed/simple;
	bh=1pHvKlOYiy9SKGzq7KPw0xXxRRfQtJO5PVfa/nYKtyo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mQ4/78lDrqL/CfT9aKc89xP6opkWt/4DvKfIXeFtDx3dQ2zfeqi7it2+RnxVhwP29zfhp6CFh0Kc5HA5fMpI1e5ZxJ+agjJUe6I2RowWhB6NUT3yP8A9dadtRtMdCSMaTREIkKCobMXDSEe8zga87B106Qc4Vj5qXfwLzsdpgEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X3RCdc2o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RBs3eTJq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6088w9qJ1570538
	for <stable@vger.kernel.org>; Thu, 8 Jan 2026 12:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8od0IsNeOtwCXTsb2g4r9h9Tj23xYKtLy14bmRisIsA=; b=X3RCdc2oErpUYx7/
	Da2TFSnk7wNdmuvNmR8r/zyZ+g0prUBfcge/y9OZGzlro6y2EYzPY8k34wccUIK5
	bafFSW+WyxeZvOjMHMbK9a8O14WLQghNlzaBsqox7zxQSm9D4frBCrqb0Lh54sk1
	x+Ny08nJCHVPDfOkjOmBSVDC06ypkUgx+CuFNix8Dvh8uiIsW7Skxw08g9NRMp+t
	4xiTpUivRSMXoVdiF3UzuVNdhklgQONFb83v7XHsGeaS55Hn4FIa8vtHaXOvCliI
	13xl6ev3EggomSJVdI4MUTrlMsES1SduIxctfQRwKZzceVL1AV+Zq3Uzwl6cD5Cn
	osTamA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj9hqrm0c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 08 Jan 2026 12:17:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8bb9f029f31so811779785a.2
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 04:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767874672; x=1768479472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8od0IsNeOtwCXTsb2g4r9h9Tj23xYKtLy14bmRisIsA=;
        b=RBs3eTJqmRC+aBPsanBZUIRAC2N7i0Epv4YVOBhmhJme1+S9lJ0xm5MWJW63XKDe5z
         Y/9EeVm/buyYBg4mV1LpMU9HnvmRmSdWpNU/8AWeT/eBSczEFqpW2M3OKGylgvsNHEnc
         jN9SI8ToXV/LhJ3ZoHlWxgRWAjCgsQi+6sRIaMkL9OC1hNriXrQjdUE/XrmQjAt1ywRl
         MrW4niiWGrnoSXqznM3EfEEyOE/hygFjGp/LEpBgYsTJTHNA1/IBbpS/Yz2AjlR9zJ6q
         rL7gruM/diPnSnr8J0E0pEoAGfajIrKlWTNC6rTKE/c85UMQhB28ME0jU/Rknlh9vldP
         eFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767874672; x=1768479472;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8od0IsNeOtwCXTsb2g4r9h9Tj23xYKtLy14bmRisIsA=;
        b=ce930aS4tUFLjrkXZS3lcx2Kj2tvwTWZkmK8mHI3rtAn92x4k1O200xibFZEadWejB
         9oxvw6IJfvb/WynjrmgEN1XFV3oXEO4HjpJ1GeMl68/2Czz0iNfqj5V4DPnnhTY59by6
         Jrwin36L1aKDKESAP9heORvo2ApxWKIlH67jb9XUWIbb3kyx37hOcraAFCScyDSmUiVn
         pD77b3BKbZBoazydZPu5oIjEGk99p5P2hiZippQE15YS2KnkjJD8gaPZ2JksDUORHapd
         k75aCXmGLwIkNrlG0NEMeAnjzh/BFoJ7KLib0q28m8o0Q5beH/A2uJpueb7X2b1G4yoA
         guJA==
X-Forwarded-Encrypted: i=1; AJvYcCVlL+GAhS10ZHJfj53W7BJcVSew3eJGuC+8AMjcmpxfIqGeevNibpcIsKfPdjTOxHBDVZnGces=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1hukp6KSLzSb697nk685GP6jw2Q1yPitEYU9ju5jhWdNLL+9D
	nvZrwaJW3toWI5Ngge1xC5t+Vcak69V3S6iN3bH0ZCo+ScSSR9rUB8H9DWf76UsM/WdYOTpl7HJ
	xPOQiZC2Au0WCd8EhqpRNXya2v8IJNZrerGERRSQS0H0IhXmneB+vz4022mw=
X-Gm-Gg: AY/fxX4zVitvCWabkrtTeozccWO/fmoqsvy4jMKezQwCjAAW9LBsN757BSEr+VzJb+v
	+/SROWPHapKk70AJ7VRk9Et5WUOtabq1S8VncjemPkY3pt3+AEHvsqgV5KL8Lfq8hL3QbGCPqO7
	YK4r+AmcJyro9IWdYAmbY9lTN7wwErWrWeq1Umx1Yv1MxGFHUdJdvSRkXEYKfXaGhWQvrNiTZj5
	v+pXxR2/8WnOCkMU3sPyzYmlXJKHkMtZZ4rHTR+NyKb+7THS5fH8P97sswcoOVvtRBsvE6Alifg
	HKEL6QzM/nSvlKtKE19lDCihAgFEDdhh5dUuwOi+YNXtlvbsoCbSBxjimm6D+lPo1nuKLM6+I6x
	YLRXLD/ii909F8mRG62eMMk1nY5mJvwx5V5gJXZQRDAEeyAg7G5Vju/k2hPyZwvWj4Vle+Lx8+j
	eISZNcU46b/e2h56CiA0R4XVEGDI2aDJZT2jtKkrB/Q0H2o5Wrc/3B4tzUzl/3na/fdW7kRaO/3
	teL
X-Received: by 2002:a05:620a:7014:b0:88f:ee0a:3d55 with SMTP id af79cd13be357-8c3893f987amr725046185a.66.1767874672416;
        Thu, 08 Jan 2026 04:17:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDEaC5ONEYTYXI/3fNxaIJxPaP5dsxNP7eaPyiNM0TOCVXA4tLR68/+kJPAZOln/4RgPRrcQ==
X-Received: by 2002:a05:620a:7014:b0:88f:ee0a:3d55 with SMTP id af79cd13be357-8c3893f987amr725042485a.66.1767874671901;
        Thu, 08 Jan 2026 04:17:51 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf661fesm8134751a12.25.2026.01.08.04.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 04:17:51 -0800 (PST)
Message-ID: <70e4dec3-e4d9-409d-9ac3-aec814aec3bb@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 13:17:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH] leds: led-class: Only Add LED to leds_list when it is
 fully ready
To: Lee Jones <lee@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@kernel.org>,
        linux-leds@vger.kernel.org, stable@vger.kernel.org
References: <20251211163727.366441-1-johannes.goede@oss.qualcomm.com>
 <2bbtf7out2t52pge4hezfc7dryu6te2qstfm5kzez7zrw3dvqq@wxvqnjbulxc4>
 <585dc6a5-64e3-4f54-8ff3-9b9f1fc3d54d@oss.qualcomm.com>
 <20260108121142.GI302752@google.com>
Content-Language: en-US, nl
In-Reply-To: <20260108121142.GI302752@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GN8F0+NK c=1 sm=1 tr=0 ts=695fa071 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=zz-1Wuj_SYMfJuCV:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=3zLez3-RG3cE2hjYFfUA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: X_ipZM1oWvgRqv_17mnE95mtkLFY9ssA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA4NiBTYWx0ZWRfX0k4u7+92Ujjo
 1CuT6Xa8bMuyUqoy5rSlaGgGM1PjMLGDkZwcUERFVuKunb/c/neA9bmq/WCaqqx6K+t8yrO7EfE
 FAvvsIYgSpmWjb3w1z3e08Jcf0dMxKg9zTTDIx/AnMOmbZIXw2XJt2R+s92wpR+X5C7ETxh/W8G
 wv18TtO/v9MN5P13Ye5vDRliwiCwYFF63qoR1LsQbMH6q4aIk6d7HTTPmuTd8o9aMEN1Yqdz07i
 eqAE2AkfNayevbxRBfan54spqYSWUH/Vi3/X61ExbZB7jxhu6hFSqo0eQDAJRFZGPq4I8v5mbS9
 giNNFDV1xGwRu4+mjlcfn9EfJFQTcy63FXJkQyjMKw87tzkjbekHZXDj/IazWI6UFzUrkCswRpU
 gpfs/BHiOSw0FSr3xP5c4lWuazxOrwyczj9zMgtmIEAEFMEf0d0P58exdMYO0Otpvn63OkHmeD2
 v5ken4PzxKrfv9CWm/w==
X-Proofpoint-ORIG-GUID: X_ipZM1oWvgRqv_17mnE95mtkLFY9ssA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080086

Hi Lee,

On 8-Jan-26 13:11, Lee Jones wrote:
> On Fri, 12 Dec 2025, Hans de Goede wrote:
> 
>> Hi,
>>
>> On 12-Dec-25 07:49, Sebastian Reichel wrote:
>>> Hi,
>>>
>>> On Thu, Dec 11, 2025 at 05:37:27PM +0100, Hans de Goede wrote:
>>>> Before this change the LED was added to leds_list before led_init_core()
>>>> gets called adding it the list before led_classdev.set_brightness_work gets
>>>> initialized.
>>>>
>>>> This leaves a window where led_trigger_register() of a LED's default
>>>> trigger will call led_trigger_set() which calls led_set_brightness()
>>>> which in turn will end up queueing the *uninitialized*
>>>> led_classdev.set_brightness_work.
>>>>
>>>> This race gets hit by the lenovo-thinkpad-t14s EC driver which registers
>>>> 2 LEDs with a default trigger provided by snd_ctl_led.ko in quick
>>>> succession. The first led_classdev_register() causes an async modprobe of
>>>> snd_ctl_led to run and that async modprobe manages to exactly hit
>>>> the window where the second LED is on the leds_list without led_init_core()
>>>> being called for it, resulting in:
>>>>
>>>>  ------------[ cut here ]------------
>>>>  WARNING: CPU: 11 PID: 5608 at kernel/workqueue.c:4234 __flush_work+0x344/0x390
>>>>  Hardware name: LENOVO 21N2S01F0B/21N2S01F0B, BIOS N42ET93W (2.23 ) 09/01/2025
>>>>  ...
>>>>  Call trace:
>>>>   __flush_work+0x344/0x390 (P)
>>>>   flush_work+0x2c/0x50
>>>>   led_trigger_set+0x1c8/0x340
>>>>   led_trigger_register+0x17c/0x1c0
>>>>   led_trigger_register_simple+0x84/0xe8
>>>>   snd_ctl_led_init+0x40/0xf88 [snd_ctl_led]
>>>>   do_one_initcall+0x5c/0x318
>>>>   do_init_module+0x9c/0x2b8
>>>>   load_module+0x7e0/0x998
>>>>
>>>> Close the race window by moving the adding of the LED to leds_list to
>>>> after the led_init_core() call.
>>>>
>>>> Cc: Sebastian Reichel <sre@kernel.org>
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>>>> ---
>>>
>>> heh, I've never hit this. But I guess that is not too surprising
>>> considering it is a race condition. The change looks good to me:
>>>
>>> Reviewed-by: Sebastian Reichel <sre@kernel.org>
>>
>> Thx.
>>  
>>>> Note no Fixes tag as this problem has been around for a long long time,
>>>> so I could not really find a good commit for the Fixes tag.
>>>
>>> My suggestion would be:
>>>
>>> Fixes: d23a22a74fde ("leds: delay led_set_brightness if stopping soft-blink")
>>
>> Ack, that works for me.
>>
>> Lee can you add this Fixes tag while merging ?
>>
>> Also (in case it is not obvious) this is a bugfix so it would be
>> nice if this could go in a fixes pull-request for 6.19.
> 
> Yes, I can add the Fixes: tag and no, I have no plans to send this for
> -fixes.  As you rightly mentioned, this issue has been around for a long
> time already.  I tend to only send -fixes pull-requests for things that
> broke in -rc1 of the same release.

Even though this has been around for a long time, it would be good
to get this in as a fix for 6.19-rc# because as described in the commit
msg the lenovo-thinkpad-t14s embedded-controller driver, which is new in
6.19-rc1 manages to reliably trigger the race (for me, with a Fedora
kernel distconfig).

I was surprised I could hit the race pretty reliably, but it did make
debugging this easier.

Hitting the race also leads to a crash due to a NULL ptr deref after
the WARN(). I did not elaborate on this in the commit msg, because
the WARN() is the first sign of trying to use uninitialized mem.

IMHO having a reproducable race which causes a crash is
a good reason to submit this as a fix for 6.19 .

Regards,

Hans



