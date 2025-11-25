Return-Path: <stable+bounces-196928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAA0C868E9
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 19:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37989350E70
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A8632B98C;
	Tue, 25 Nov 2025 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJjL6Tfk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAE27FD7C
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094765; cv=none; b=AvlCQ4QBjLsMro3lU1KCGcp11guN8NDL4dyabvaMMgGAX6qtGYI9+BzMDYlwIgBLEk6uQgiePEg6VxkGXoxqD8G5yVt7+H1mNMsvzVXk/ISkyfMJ60U+/AEjgfmh2eGnUqJVuoxMgq3P8S5GeO+a0KePfZ9aGtN3uajLxt2UvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094765; c=relaxed/simple;
	bh=3FhC+kXH3B5AzVMbeuWeYDSaWr81HEASC/43OOHPKHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiljUj2RljV/iEkEPfenRScpuIo6JFjqQXokKjDd7joJFZMWd4DRu2JMf10o95usorJihqg4t8i+jCj0VrSRyoOUcuJcOGQFrBTOB+u8wCr3u5aS2+xfJqHOojXUGMehGY6GbvgURDNXHxHfsf7aTsADmFiDPw+0RcJq6yXmI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJjL6Tfk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so3418223f8f.2
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764094762; x=1764699562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QD1CCAPcssLzpZsS6Mj5rvSwQ5nCelYbF5aDvpoGo1o=;
        b=dJjL6TfkgDfu7E+COhTjOmcA3NmQLyspkdKwIyuxvH6JigElOF5NSq2zlxWbFLrdTk
         sE3TeLNCgYAcJjFAGqXK5ltydlWoDM281bH81EwcYq28hXcM5TrP5qjnf/xIxqMmGZtj
         cTjUuC+h/MuCq5JWGGb3lSlz/04TO3GCl0yJnQGtF34FBTjFJdaF2+UqRLS9IyKmh3Xu
         AjeFBkjVJE7L7jxT1zvMabsEH+w15ij7FfZ6GcY1UnlfMWEF+bRMFmHsTCdo5A1fMPu7
         ucdS/F6xvcmWaBl8bzSb/sgZxRdloFSv9QLPzT1q5Teee1rQCZXAXNQg9gqU5cVH6xpW
         Hwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764094762; x=1764699562;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QD1CCAPcssLzpZsS6Mj5rvSwQ5nCelYbF5aDvpoGo1o=;
        b=RoMQjwtWp3XIeIy4zj6X87JCGGC16On2wR4qCx2NXHX7CiQeyYM+FCuWnRQecdudgS
         vwthkbLpKCY61Muhp3JumDIhf1MA8J+8323umpJmZxqRUK7Es0cHhqfi3DAprU+7BLWg
         iy/8GS5VpbFdmG+scnBnzred/Lo79f2SAPcQ/iDv7ysloOCx5k5Na+BdMRndJvFvvDRn
         1lXevzvw941TWJClpDkZmEwPuXPelyLQWO2fGZz2YjvyC/xg3uH1TntDwZ4DI2VgPE1R
         Ve6OIikFvYgFCGGu4GojcOgU4w0Tx2yi2FExV0GswqVr9UnpsE5NsXM7G0Pfz3ekaWB7
         3ZsA==
X-Forwarded-Encrypted: i=1; AJvYcCU3sfa4iTvgjR54hV/oZ2444yvQqNZc89ZOkSFrbHTDr0XcQNFnDJe0/VS5gb7pfF7hM17pOMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyT16fcq9zANUyY6G6gbWAwUZ0YJBVX1cDZnunudNQ+muH0Lov
	ECw3TOMLtjxB2IkBs+sWk90H5dCGAHn5/IKQbSqC/at7NypjXDNYqm1f
X-Gm-Gg: ASbGncu9OLjrzpDoH37r5tS1TYszvfvjcJedlTKkJVliuoy/522/CTYPkpGRHwlpjo+
	u3JcPB1EplVW7upGHzqHt0jiSgkooMqcCRLeC7dnaxGX0L3maAVhh35NRdyJ0j7gvmxwnTUk+u7
	WVKUlu0ohfRxEKLC/xGWp4TRIdXG+995pE1oCxxITvN859edT+xujUxx/LRRkbdVvxsktGS31y8
	lT/UWfoC7u/k/kekRd81FAQGQb6ocHCE9Tia2RSJaB43Sf0EXDU1sOrSPzwAB1kNx1fxZiQ8kDc
	geJ3pffb/jr7W7kvVO67eA8t6JJi+3CVr3cklbn5AjXSwYQWTIru7tVrkxZLckDOwdackuv6E+n
	pUSxqD3la+3lZukFwfqBvmTSWeqlD/V8z8S3goC8lTwORC4EbjFwmnqPF6dsN6TOfp12aKZkGhv
	KJVH0HHQg=
X-Google-Smtp-Source: AGHT+IFHbDwkp2CaWm16Z6NarVIxFHbx8YbHfm4wnApcclc+Vfg/xfl2pHmCg5MNHh57zJw7P8OF0Q==
X-Received: by 2002:a5d:5f44:0:b0:42b:41dc:1b58 with SMTP id ffacd0b85a97d-42cc1d19957mr16662352f8f.45.1764094762096;
        Tue, 25 Nov 2025 10:19:22 -0800 (PST)
Received: from [192.168.1.12] ([41.34.101.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8c47sm37081312f8f.38.2025.11.25.10.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 10:19:21 -0800 (PST)
Message-ID: <f67a5702-4b44-41bb-9538-19063bc28b41@gmail.com>
Date: Tue, 25 Nov 2025 20:19:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] HID: memory leak in dualshock4_get_calibration_data
To: Max Staudt <max@enpas.org>, Jiri Slaby <jirislaby@kernel.org>,
 roderick.colenbrander@sony.com, jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+4f5f81e1456a1f645bf8@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20251122173712.76397-1-eslam.medhat1993@gmail.com>
 <6251f6df-d4ac-4681-8e8b-6df2514e655b@kernel.org>
 <44eb6401-e021-4c69-96af-0554f4f31e57@enpas.org>
Content-Language: en-US
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
In-Reply-To: <44eb6401-e021-4c69-96af-0554f4f31e57@enpas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/24/25 16:06, Max Staudt wrote:
> On 11/24/25 3:32 PM, Jiri Slaby wrote:
>> Isn't this fixed already by:
>> commit 8513c154f8ad7097653dd9bf43d6155e5aad4ab3
>> Author: Abdun Nihaal <nihaal@cse.iitm.ac.in>
>> Date:   Mon Nov 10 22:45:50 2025 +0530
>>
>>      HID: playstation: Fix memory leak in 
>> dualshock4_get_calibration_data()
>> ?
>
> As far as I can see, that patch does indeed fix the same issue, and it 
> is already upstream.
>
> Thanks for the hint - Abdun's patch has been upstreamed quite 
> recently, hence I guess Eslam missed it by accident. But maybe I'm 
> wrong and Eslam can chime in himself?
Thank's Max & Jiri,
sorry i was sick the past couple of days i missed your replies.
yes. that patch fixes it. I guess i missed it because it wasn't merged 
yet when i submitted v1.
So please ignore this patch.
>
>
>> Anyway, this is a typical use-case for __free(). Why not to use that?
>
> Wow, there's been a lot of interesting stuff happening around 
> cleanup.h. I've been out of the kernel for too long, this looks like 
> fun. Thanks for pointing it out :)
>
>
> Max 
Lastly, One question to max,
at the beginning of the function  dualshock4_get_calibration_data
buf = kzalloc(DS4_FEATURE_REPORT_CALIBRATION_SIZE, GFP_KERNEL); if 
(!buf) { ret = -ENOMEM; goto transfer_failed; }
if the allocation fails. can't we just return here . or do we need to go 
the the end of the function and do sanity checks at the end?




