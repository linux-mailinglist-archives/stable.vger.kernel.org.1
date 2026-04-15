Return-Path: <stable+bounces-238139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHpSKI2e32kEWwAAu9opvQ
	(envelope-from <stable+bounces-238139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:19:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46565405358
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 556C230CABDA
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC513D3D12;
	Wed, 15 Apr 2026 14:16:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB83D349B
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262563; cv=none; b=MSZXiDgeYN1htwhEhpXlSiOCdKTbf1w/4Al3IuqcNPUXLPRTQZrEmYAcjQJbre2pmSunW1Va9v2zo5EAN0i9H6Uj2F4cYG1xR/yri1RHUlNOOOFAKeIX7xogNbHzcel0g+txnFBbOsz2SVmphM0zGRjqB7ao5t1uyLJ787gZyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262563; c=relaxed/simple;
	bh=Pdy7Mh+hnfOvCQDqW76dEUcz37KcOEmwFbjUwviC6ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nu1zCIKgxhJHBHET+6C6N7m9QM9TWxWbL2+CNgDz7rGnv6qe8IFQ3E7lSnJj+ab79WK9OCXO3Vwzd0F9Q5O7GrpqYLtThR8BmuH3pOMmrAn7sm6XwPCFjz+iAY49ZDaUNGGuxsijKPgCQb6DRIkkUltaV/Xq2BXj6Te+PHRemf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so7804976e87.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 07:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776262560; x=1776867360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9GVK3912ykSKoEN3+mlTPV6LfdyMXA4vXMmtRCWPRU=;
        b=H6R6cWue0cFylbt+/pQO3eAB358ZW3stBqJWF77ZjJ1IHNmTB4eqWEiBO12HDicBe+
         UFTQ6AHB1DN2IJ/hYfpbCyB8KYekZmcRnrK5wD7tZrU066OGavyx9Q/aBAf+E+GLeypb
         me2AqxEBXihi9Y5dpcrGPHhwSIISxBMIERWNDCLL5yE3k8O9Ibfv4JD2FFSCr/nDHxlw
         gZgLL1cDSuW45J3fYCGpmexV6FLL8IMSUasuu8CNFtOB5DFgaQKNq/w7j9DsI8jQS5Cd
         5f0kA9mMIVZgFt0ei9ojog7BOeO16d5288nA1TyEMM3SzZ1jM9dBOqY3qHVMi6Z5AbVl
         LRvg==
X-Forwarded-Encrypted: i=1; AFNElJ9vth/2Nqp0CUrTw/lE3JcrvbYcDM2CV7+pzWn9VT3Iw/5YKlNMPwzDniv2IrpH/uZkkn2KQHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxer97IypKYElAlekHPbbBkiDOQySXScC6FpIMvuBcS94QkywfJ
	1nJt/V4Sf3IViv0dj08xHkVF+i/66xCvmPsRTz/6NtKhGd3s2XuO1T0X
X-Gm-Gg: AeBDieswxlaoP5THgwEzB+7Ee62DToYOcQns9HQPVXuY49trYfq8Igv0PWd6vocQZoP
	o3X8n+pqVNppAJPmlr+r3rkjqrbvD264seHbYT4Jy4GVMoocPTTheco/JDRtsCqIl1yIJ06Ch2J
	a7Jl5oUi28JPA8ex1k83yPBQpY5j1WgR0LstQewnG3aoRqaxhpGQ4FqBLNBCN9SEVvdKpXYAN8j
	VW1AKSC29/NiA0qMdqOTiLIuWkDFMGHfvT7ogyXzhx1bevq9+Hit05rA0wsHJ7cUUgY2VyL8pKx
	Yjp3+YpNQg1CdR27OTKI+3O5WbS/l/BErS/HOs2HQfEBvfVfx3eYmuLcX8fUrrKq3YdaNVcUcDM
	eZTAcgopAZxIMOk3QssbtCBkncVd2KoQWCOjejGC6a/F+P2GZs6D1rs+rIYKWul0ik0r1p2bqYI
	gqTgIRdIaDI4mZxY5YXeJljKXTKTBh7cn7hBGX3mJjGthMYXB03YMpk22lZIbE/r3ME3pwAwKr+
	u6nvoI=
X-Received: by 2002:a05:6512:6cb:b0:5a4:50:ac71 with SMTP id 2adb3069b0e04-5a40050adafmr3650399e87.13.1776262559949;
        Wed, 15 Apr 2026 07:15:59 -0700 (PDT)
Received: from [10.68.32.41] (bba-86-97-226-202.alshamil.net.ae. [86.97.226.202])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a40a2e71absm503650e87.46.2026.04.15.07.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 07:15:59 -0700 (PDT)
Message-ID: <376f0e18-fae3-45d7-b3bf-885e963e6b51@linux.com>
Date: Wed, 15 Apr 2026 18:15:56 +0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: fix reference leak on platform_device_register()
 failure
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman <gregkh@suse.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260413153114.3040093-1-lgs201920130244@gmail.com>
 <8afc6b6b-399e-4f77-82e8-3c0e717f765e@linux.com>
 <CANUHTR9MQ8GGpgtGDgRCmjQL_D0jW4E-2OER4Q784xbGd+nJSw@mail.gmail.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <CANUHTR9MQ8GGpgtGDgRCmjQL_D0jW4E-2OER4Q784xbGd+nJSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238139-lists,stable=lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.com:email,linux.com:replyto,linux.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[efremov@linux.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[efremov@linux.com]
X-Rspamd-Queue-Id: 46565405358
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 15/04/2026 17:54, Guangshuo Li wrote:
> Hi Denis,
> 
> Thank you for the review.
> 
> On Wed, 15 Apr 2026 at 21:00, Denis Efremov (Oracle) <efremov@linux.com> wrote:
>>
>> 1. Let's use platform_device_put()
>>
>>>                       goto out_remove_drives;
>>> +             }
>>>
>>>               registered[drive] = true;
>>>
> 
> My understanding is:
> 
> For the platform_device_register() failure case, we should use
> platform_device_put() instead of put_device(), so the failure path
> would look like:
> 
> err = platform_device_register(&floppy_device[drive]);
> if (err) {
>         platform_device_put(&floppy_device[drive]);
>         goto out_remove_drives;
> }
> registered[drive] = true;

Yes, correct.

> 
>>                 err = device_add_disk(&floppy_device[drive].dev,
>>                                       disks[drive][0], NULL);
>>                 if (err)
>>                         goto out_remove_drives;
>>
>> 2. We also need to fix this case.
>>
>> platform_device_unregister()
>> registered[drive] = false;
>> goto ...
>>
>> Thanks,
>> Denis
> We also need to handle the device_add_disk() failure case for the
> current drive, since out_remove_drives only cleans up previously
> registered drives. So this path should explicitly unregister the
> current platform device before jumping to the common cleanup path, for
> example:
> 
> err = device_add_disk(&floppy_device[drive].dev, disks[drive][0], NULL);
> if (err) {
>         platform_device_unregister(&floppy_device[drive]);
>         registered[drive] = false;
>         goto out_remove_drives;
> }
> 
> 
> Is my understanding correct? If so, I will prepare and send a v2
> following this pattern.

Yes, correct. Please, send v2.

> 
> Thanks,
> Guangshuo


