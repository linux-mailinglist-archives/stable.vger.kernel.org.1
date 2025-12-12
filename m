Return-Path: <stable+bounces-200886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9152ECB85EC
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 10:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC9C7300E3C5
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 09:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716BF31283F;
	Fri, 12 Dec 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EK9RF/6k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HNwvvS8k"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B21D31281B
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530345; cv=none; b=c3IYUvZZl1B8DG1wA5pUUvWCh4kLjIdjFLakryoF+wc+rJxfpuTN7sO+QQRcQBEz87zI5qhrc/qj6ohYht2j7iekpu0ebiotj9gyLHrU3ullsd35XjWngnSRG8/STAeCMJQPdREKTh7TTKMQDiQE0v3xLHh5FuUlBuIAVh8Rr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530345; c=relaxed/simple;
	bh=xrmgGCgFrU6vIU8uBY7JJOVp1heoUxGeVMCpOgMlZPs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JfJiZ6EdZ6rAKarFk+xql1DqPlfJG89Y1F5CNH4TdzWd6ZJuNsXW3BOmcBB2Rgs+KsRkwx5r2ac+LDlqnhDTqHwh8RizJ490EtiFRjfF5Fma32+PCPH5gEM1JvaWC3u5+BkqgyZW5QaZV/dtgIiFfXyYZpNm2Kr0KJcolP1hpqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EK9RF/6k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HNwvvS8k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBK9ic02456865
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 09:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fo1TThen4KPg9NOYuyuxZuTulH1Gx83LwJhG7LNHqcs=; b=EK9RF/6k2IDNJ+qG
	Uw/8XTS4V3VDS/+KBhHxPsVsX+BdiJjF/ernJQduUDRhIMBKN+js0mgiP//7hGXP
	tSHl7tDk4YOS4ZR+p2pqmdDc5R+ip1oGA//9IwaTsd2s+0PGOR6HMn1EnqG076FM
	ilGRiTAp4G6U6W+TLgV6OvLD8EfGOONB5eQLc1WZqqoL2oQXz5zpCT8PUbSLB75B
	ipuk83EtA4u07bKme9Rnf4zUEIQi2Ss9yIVxfZGaDGxIuXB79YpGz/VoCnzeKmIF
	F0xRFxWOmbbxuXdTcdCaRitgO6zanJ9aHEPAMqJNRxphVJZ6ZAGuVamsAWDTCShH
	ktAzNQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b04r8shs3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 09:05:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f183e4cc7bso18861311cf.0
        for <stable@vger.kernel.org>; Fri, 12 Dec 2025 01:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765530341; x=1766135141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fo1TThen4KPg9NOYuyuxZuTulH1Gx83LwJhG7LNHqcs=;
        b=HNwvvS8kSBeRtaegkFCzNFMY6bQJxD80SuHfcbvbCFde90PMMaQqtU4WTzqtZqbWf3
         j6mhePXEr8xVEDEN7rmfDP6kWIftkzERi9IZqn6d3+GyA2tbQ/DJUib7SNvP7l3k9nu+
         YmiFyhc4Z597W5fRp2OaWO/Wt1nxoUGn3A3zgwafme5qyKluV7hN29Q/z4Pn052390jg
         SURk7HY4o6intL4NuOT8dmxBM1+CPLQDd9JqubWlNRKdn03W+4eehyrYdrWFy+97bfOl
         g+51b2ng0B57AKSIzIyXEbJSDzJVH+GHNSooIp0IdtL7uaaZ2KDGNeN8qgapWn1gfKj6
         iOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765530341; x=1766135141;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo1TThen4KPg9NOYuyuxZuTulH1Gx83LwJhG7LNHqcs=;
        b=pu1VS19kFR3AwtI9OTlEDRWOJrAyPVtQ8aSJWpP3ZSJDhucsivqA4UVUa5zsBiXaoh
         8OgidCt9zIuiQ4idPPqqeGwW9btEtXJytKmkxluh6WC5xrqMPdrlyFIaydQaUA4MRBXN
         r0rkMZ2iOo0N5Wq8rP7Kh1gqoptjKkTLmBLXbmbYuDXbe49nppKL3iGwttblorgDXTkQ
         /5tLXiKudq0BZMbPWkQtjyITGfbZD7VKyMumevVKm8tdnhaU1lEP0nWpRrW6nGCg/bbA
         qgul4VrU8yXxAu296TE74bUtIqhF5Cqk2P3BPEETLBJEEgZ4IfKGwREYQQLvztHaxTkn
         BMsw==
X-Forwarded-Encrypted: i=1; AJvYcCW03wMnuk+8G1FOe4uow6e+8GOY/a/WTeFqWocekuyCevSE1raSrEHOkT4rhKIARaW7dD/Wd3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy+t4buYkzPZSu1axRZcUfM05rUnoZ/23U0Ha1KR+e0V3IoPwa
	3pxovICnvPAT+K9c28ToldGSc5zjayHiauUgAbwUHJ/34kupHv3nLuXIXAovLxbHy0GkydtYM5t
	JGQi70taMbZbdqGikJIrMPrkkSdvjn0F3lkuO5ibrXoQRifhLh+/FZFjmw8k=
X-Gm-Gg: AY/fxX6hSdAq77z1n9Siv5WOE+y/3Jjwvc5P5ouopJ7uwrcZyT+YiQFr3e29Cg3yjb4
	fOazIWr3VtNdJcZS4UqNu1gZ1fMTjPN7KeIzwounQqO+kV4B/5rpOOFWaHC4JskftNBTEeT9NPi
	SMgV9MLHY+MGte3W3XrVzsUyFx24vQ+D7K/YU8C3YT659UpM+Xs6A2f+hndJN0YwecsE/AWKLv/
	v37DbmTGAkmbJPavY6v84jYjwMbCSlYRlJWWog2QYKYYvb5kkCo/fx/b/oLq8CNdfKmLWO4tOgX
	WiqdMqcFn46xkVIEp6+fLa+RoB16oYG2bYA0hkLhwluIim1n3zAloU1AaKqzKT5lWkvdkIqQ8Bj
	wywQnIsllrFDgX15wn5vrYjeUnXMok31XwvfzrWXjoAtRB6uPalU6oWpVr5uGn3A3M+xh8XJBFP
	g8XLYRT4jpy9MdTdvKeuwjfHtd1AUM8FFdpkBJjH1xzXheYvNpmhHTYywVPPuOP97qbec+TPZmm
	nLn
X-Received: by 2002:a05:622a:1b8f:b0:4ee:18b8:2ddf with SMTP id d75a77b69052e-4f1d053d070mr14512371cf.37.1765530341218;
        Fri, 12 Dec 2025 01:05:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF45/TKRNUTsb/SJSuVbiwJAVpjK9l6qeZ2d/7lwqJrXeEQvFwBOPm2wY3dpRBRzuXBoD95GA==
X-Received: by 2002:a05:622a:1b8f:b0:4ee:18b8:2ddf with SMTP id d75a77b69052e-4f1d053d070mr14511961cf.37.1765530340603;
        Fri, 12 Dec 2025 01:05:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64981fa5514sm4684243a12.0.2025.12.12.01.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 01:05:40 -0800 (PST)
Message-ID: <585dc6a5-64e3-4f54-8ff3-9b9f1fc3d54d@oss.qualcomm.com>
Date: Fri, 12 Dec 2025 10:05:39 +0100
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
To: Sebastian Reichel <sre@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        linux-leds@vger.kernel.org, stable@vger.kernel.org
References: <20251211163727.366441-1-johannes.goede@oss.qualcomm.com>
 <2bbtf7out2t52pge4hezfc7dryu6te2qstfm5kzez7zrw3dvqq@wxvqnjbulxc4>
Content-Language: en-US, nl
In-Reply-To: <2bbtf7out2t52pge4hezfc7dryu6te2qstfm5kzez7zrw3dvqq@wxvqnjbulxc4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=e/ULiKp/ c=1 sm=1 tr=0 ts=693bdae6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=zz-1Wuj_SYMfJuCV:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=1w4XLJb60M6FLaDUVvQA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: tgj7knwQVU2HgkaKZfbYwCzpCBD0fqqd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDA2OCBTYWx0ZWRfXyDJ5RBwhyODz
 e2EogA9ptperd0obxhVa5wP78WkuOfIiODDXBM7jmVC+Iy8/+9kZE9wMqifngzVCybPWtu69PS8
 EZlRiwle4eUf3nWKPVQTrMdB9FtH5/risnEhiM3qmMd8I2cgIMefC2fpQG+3UVVHqirxHtUoBNS
 a2sbA04GgkCVtssBArEDeaOfj5iSeu4mnAFqyAcssqYIqrBVxJACnw7cbGy8a+BXUbJkvnkyvJl
 6uWcFkmJfR27n0QF8nwR45NBqgsNRoOFEZzf5ou/gCQisB+ZchgDxNsyYt+r0KMNYikcI97RzHt
 YaWf+E04aspjU3lNSogw+07aTX3sn0WvCeFHhqNhPK+/VALAKWXtoHSTOkqjS1ZLdQ6f7hNuiQq
 tCF89v7N3//LzDGhfUGs3TUxMUOJPw==
X-Proofpoint-GUID: tgj7knwQVU2HgkaKZfbYwCzpCBD0fqqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_02,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512120068

Hi,

On 12-Dec-25 07:49, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Dec 11, 2025 at 05:37:27PM +0100, Hans de Goede wrote:
>> Before this change the LED was added to leds_list before led_init_core()
>> gets called adding it the list before led_classdev.set_brightness_work gets
>> initialized.
>>
>> This leaves a window where led_trigger_register() of a LED's default
>> trigger will call led_trigger_set() which calls led_set_brightness()
>> which in turn will end up queueing the *uninitialized*
>> led_classdev.set_brightness_work.
>>
>> This race gets hit by the lenovo-thinkpad-t14s EC driver which registers
>> 2 LEDs with a default trigger provided by snd_ctl_led.ko in quick
>> succession. The first led_classdev_register() causes an async modprobe of
>> snd_ctl_led to run and that async modprobe manages to exactly hit
>> the window where the second LED is on the leds_list without led_init_core()
>> being called for it, resulting in:
>>
>>  ------------[ cut here ]------------
>>  WARNING: CPU: 11 PID: 5608 at kernel/workqueue.c:4234 __flush_work+0x344/0x390
>>  Hardware name: LENOVO 21N2S01F0B/21N2S01F0B, BIOS N42ET93W (2.23 ) 09/01/2025
>>  ...
>>  Call trace:
>>   __flush_work+0x344/0x390 (P)
>>   flush_work+0x2c/0x50
>>   led_trigger_set+0x1c8/0x340
>>   led_trigger_register+0x17c/0x1c0
>>   led_trigger_register_simple+0x84/0xe8
>>   snd_ctl_led_init+0x40/0xf88 [snd_ctl_led]
>>   do_one_initcall+0x5c/0x318
>>   do_init_module+0x9c/0x2b8
>>   load_module+0x7e0/0x998
>>
>> Close the race window by moving the adding of the LED to leds_list to
>> after the led_init_core() call.
>>
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>> ---
> 
> heh, I've never hit this. But I guess that is not too surprising
> considering it is a race condition. The change looks good to me:
> 
> Reviewed-by: Sebastian Reichel <sre@kernel.org>

Thx.
 
>> Note no Fixes tag as this problem has been around for a long long time,
>> so I could not really find a good commit for the Fixes tag.
> 
> My suggestion would be:
> 
> Fixes: d23a22a74fde ("leds: delay led_set_brightness if stopping soft-blink")

Ack, that works for me.

Lee can you add this Fixes tag while merging ?

Also (in case it is not obvious) this is a bugfix so it would be
nice if this could go in a fixes pull-request for 6.19.
 
Regards,

Hans




> It introduces the set_brightness_work with the INIT_WORK at the
> wrong position (after the list addition).
> 
> Greetings,
> 
> -- Sebastian
> 
>>  drivers/leds/led-class.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
>> index f3faf37f9a08..6b9fa060c3a1 100644
>> --- a/drivers/leds/led-class.c
>> +++ b/drivers/leds/led-class.c
>> @@ -560,11 +560,6 @@ int led_classdev_register_ext(struct device *parent,
>>  #ifdef CONFIG_LEDS_BRIGHTNESS_HW_CHANGED
>>  	led_cdev->brightness_hw_changed = -1;
>>  #endif
>> -	/* add to the list of leds */
>> -	down_write(&leds_list_lock);
>> -	list_add_tail(&led_cdev->node, &leds_list);
>> -	up_write(&leds_list_lock);
>> -
>>  	if (!led_cdev->max_brightness)
>>  		led_cdev->max_brightness = LED_FULL;
>>  
>> @@ -574,6 +569,11 @@ int led_classdev_register_ext(struct device *parent,
>>  
>>  	led_init_core(led_cdev);
>>  
>> +	/* add to the list of leds */
>> +	down_write(&leds_list_lock);
>> +	list_add_tail(&led_cdev->node, &leds_list);
>> +	up_write(&leds_list_lock);
>> +
>>  #ifdef CONFIG_LEDS_TRIGGERS
>>  	led_trigger_set_default(led_cdev);
>>  #endif
>> -- 
>> 2.52.0
>>


