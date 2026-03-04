Return-Path: <stable+bounces-223130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFJ0MhSGqGndvQAAu9opvQ
	(envelope-from <stable+bounces-223130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 20:20:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3AB207016
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 20:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BE693019062
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 19:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F46A3D1CC3;
	Wed,  4 Mar 2026 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aH6wgO90"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95213CD8AA
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652020; cv=none; b=eDVl3yOXf/hwPRmvovbA7iVsEvALlVwiSzAsp/U51vzt75Dp3a+R7nKFPP1DNQsuxQOXAlJpdN18dl5z00Ks1e2eQyMXi9oanu+VArvJGLVEvdugpQ/pKgZr97/rC73hJ2s2/Y/0bFnm2S07QbOgRZmu2nFLCiuK4Mm1Gq4hOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652020; c=relaxed/simple;
	bh=vtScg89VcC/p+SbiCU8r5pSBOmomJv8Ajh0rHAbpb1w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b5eVdUJyp4ybrvXdoM/tiBjDz6FDO1tasrgjtNGOhvfHDQck8/XD2y90Qo9awT1JGxj+tI4UGFFqL31CNA3cH8ambzqA7x7QpI1V1HXLhmCPpxqJMTtW5A2EQlmKBoTbxy20p3Jf79d5KsCi6dINYAo8QHimpjU4y1ajzVPvH3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aH6wgO90; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b9b190easo2420382f8f.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 11:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772652018; x=1773256818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X81VbwAnDM/rhI2P8/2GyZw+VvYVkyBxmdITtUmM+10=;
        b=aH6wgO90zcOgzYiGzx9kTw/T8lgN/4L9T1rNm3e+RAQAopdIhf5lGwG5Rv7dqF4VKV
         Ewz50mI+IPBDEcl5XCK+zBEDISve7EQqBWIBhxGPvS910ZhHABcdIglTit1g+bEZWoRH
         wG7Zyz5LmAtaRHrfPipTXdCnLMJu+Ums9IENkJnaK9r+oMqmikFroONZqJxcNJvyrTtR
         qjYOU++jQLOh94UWp1h2X8QhA347151TvnUmpva4gK6fcQOQCILZ7K1YkGvvn7/ZBw+9
         I8UktqzeVHTX8G59G3nbVUGH2EBBuj9COAfmHjRSVkZxtXCCHGA1w2V6YDC1ptJtbd9k
         8eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652018; x=1773256818;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X81VbwAnDM/rhI2P8/2GyZw+VvYVkyBxmdITtUmM+10=;
        b=AvkHbJ7xYP2E8BRu7yLxGukE6/dW7dzlXM3n94jlyXil2ACP8G0dN0puYK3M5kSzXj
         Feq74Mfe/prR4QyyBAd5NsEloh+d0fX7juHU8i1O2Oh8xi6e5uApKp+0m4SKPRb+WIK5
         +/XlYB/pjLBj/0aK0JpkyQpmnKfKrXxybZBUb5cSYmj+Gb3OtUAOGRREv73FlcKR4ert
         YvHjNQEJHq27TyBzfPzUXf/YOKTcS16Smuo7HinyaOrJjCSIr9naG+Hgt9szeIw0wvRd
         66EfJo//NWoYmKqoQRB/fxbHhEaQa+d9uj5Ntf7NSnczDnpUp1JJOjrNXEmgnNh4R3qH
         8uTA==
X-Forwarded-Encrypted: i=1; AJvYcCU6IOLelVi5+bkOB7dj4FR1q+GwwJOPv/WWLjVzl+Tbz56k0cn1KpM734BhaO6VvoEaAEazJ1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQFvwrqi5mQU/8uFbHc5Uc+fgZd4pRf/HdYKY7p1ujsaXrsi6v
	jJnet3osMSLlHmlxoj7JvTH5GXJNOAsJATHRNkH1K1+Jubx8PeqPkjM=
X-Gm-Gg: ATEYQzxb5A16JiyhEhafnjgiv255u2Nm6SnOnCqEbwPPT8OqNEWJRfZCLQUAt+UkESR
	fSZEO9NTPTkzaw6KqPjcy0RLbnm9KUTAtg2BxcrQUF4DZH5LFjLNVWWbu3FidiAlyCosDIkbHev
	80jwLL2lic/k8kosdDjn64ebVaIqCv4aVbHMXK/z/Aa11LR3diHxihrhviINGC7qadRBydpvCle
	STuIj41zJDj6ANQOcV5TmQOj82WIVeOoYwIOnzmyvJNq4d8xu3vKC566Ki0lY63Aq6OKCfiyhdK
	qDkwmIsuLvh2zDJMIcLPTJhG7zv9ezHnjNek5qSRWksipjEAW8ytG+iXZGrdj1A3/7CMJ3bkCnQ
	vGwNEhX2kvKz2Ny7LSNgwR6BN5l2+70qHmX7VbvAPtBZzPCHyWUdsy/QeBz1vBuWJsftqPdL02b
	QAWTJ1VpJVXTuobR+rEICcGAJ3V4OYiOjGeyAqQqlAv2cLmeJYdKpNzgDW1Of5u/FCrIsmvSwgB
	Q==
X-Received: by 2002:a05:6000:220f:b0:439:b31d:c4e2 with SMTP id ffacd0b85a97d-439c7f650a0mr5893381f8f.7.1772652017793;
        Wed, 04 Mar 2026 11:20:17 -0800 (PST)
Received: from [192.168.1.3] (p5b057b4d.dip0.t-ipconnect.de. [91.5.123.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b1116698sm32237999f8f.16.2026.03.04.11.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 11:20:17 -0800 (PST)
Message-ID: <291c8ed4-1b66-48bf-89ce-a2760be8e1f4@googlemail.com>
Date: Wed, 4 Mar 2026 20:20:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: Linux 6.1.165
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org
Cc: lwn@lwn.net, jslaby@suse.cz, gregkh@linuxfoundation.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20260304131525.84627-1-sashal@kernel.org>
 <c435a3c6-5952-453f-9e50-31e0c6cdd09f@googlemail.com>
 <a4e5330c-5bd5-4262-a6eb-595ff01d1af6@googlemail.com>
 <fc9c533e-d0eb-428f-9cfa-3cc014b54dc0@googlemail.com>
In-Reply-To: <fc9c533e-d0eb-428f-9cfa-3cc014b54dc0@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2F3AB207016
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223130-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailvelope.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url]
X-Rspamd-Action: no action

Am 04.03.2026 um 19:49 schrieb Peter Schneider:
> Hi Sasha,
> 
> 
> Am 04.03.2026 um 18:52 schrieb Peter Schneider:
> 
> [...]
> 
>> And it's also still (again?) in all the other 6.x stable branch releases of today:
>>
>> 6.6.128  22e460b6333a5
>> 6.12.75  f8f73bf0f8a57
>> 6.18.16  d4a132f121c59
>> 6.19.6   4d7a8f5f28187
> 
> ...and consequently, but not surprisingly, none of these build on x86 with CONFIG_WERROR=Y. All throw the same build 
> error as I already reported in [1].

I have to correct myself: the last two I screwed up myself by doing stupid things in the wrong directory :-(

Sorry for the noise!

So 6.18.16 and 6.19.6 are fine, only 6.1.165, 6.6.128 and 6.12.75 are still affected.


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com


