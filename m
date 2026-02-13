Return-Path: <stable+bounces-216276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KNHF6JVj2lqQQEAu9opvQ
	(envelope-from <stable+bounces-216276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:47:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 947591385DE
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC219302883F
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444F93659E9;
	Fri, 13 Feb 2026 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Pj3U2ooq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA88F49
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001146; cv=none; b=D8SFVCD1vbrZtG6hbiA0kkiWYD78Fw00BlpIK/IdGiC0kbfutnpVQ1ALop2fnbotkOZ1s9cPCQ+/UEhFcnM/0BYx3o/b+8QlpdDYgp66eVXySgXSyOnJ+Sdtr5GnGDJCg+taynp0SUJlxTJk75J//UsZPdtsX7QPa378kxIJonU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001146; c=relaxed/simple;
	bh=/jc+4+lmzS9c/BTr/Bqx2gnrK4XNe768++k2lJtwDcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISjSrJyCaVpHoHkrjBj7uzRMG3HDI3mi/hqLYKs01JdUlHjdVdYWlBRCIP3LQDSBTtbiOqS7tK5dE6sJnS6fC5C/vhMgEQwygjFw26KYnE+Yxthkpfc3RkiKrlOX5BQns2C/ZmZZ9jxLuiLSQDQsdCkePIRlnftuoqsFA+mX820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Pj3U2ooq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4807068eacbso9183535e9.2
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 08:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1771001143; x=1771605943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=88WkRtYTP0O2KMDAviJt82507UwMeh5vWMJa5+j8CU8=;
        b=Pj3U2ooqU+EpWpVb48uoZbYqA1UCWuvWvnF1x+/ehQ1e/cJkMW01YttBfd07IBdUg+
         yKZiMDbJpNSEYoZABIOu3gpX6HEhMBvp9v1iwgWEdXMv49XXGV5iUZDYnIZRl0QoXEiQ
         3X7nfe2F0hsBvcWZTLnwEqh+4M5SN6bYLHiSZRtiexoF+wy0ITnlt0kOBP6m6E3t9sw1
         OEFfNJRpUJ4MZQZY/2Tq+Doitbg9PNIXCneC7ukrGcBItJbkiDCbf7dP4ZScd4gD8Kcm
         ltkX0IwbhzySCm3aQ/qFc/FAqE3/XgfgObFcHyDwnV6DHtfvfOTTZZkWVe+ZpLT2Ctmi
         7Niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771001143; x=1771605943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88WkRtYTP0O2KMDAviJt82507UwMeh5vWMJa5+j8CU8=;
        b=ijBNABmAdUgNVqPKE+ZZc0oZfKrVA6AeSbRzaSLWB85nW4tdF66PX02DR3BYq+35Xa
         HXJJn60n2QaRQPs22yK0GmuznXtS5sSURLtunYOVdryh0IKbbh1C4+GNxqHDeEgQge9D
         Cf9xub1/JdtSqpXyJiWepcAzaq0cHnyRaNriPWNluOKXrwXXUHMb7BouUbih1LTTFhHE
         ZlsnAW+X590lUtGxUkZT72ERb8aqlKYL/BkNAukvxCpPQ0wkoMRv4HYaLE4N6J0/d+wJ
         PjpAWcmSoRb7jnPR4ALco1sGdeiP5a5MLQdpE0uNw4WSlC0CBhflfywuYGwX4M+VEA2Y
         rnTA==
X-Forwarded-Encrypted: i=1; AJvYcCWEOaJLQw+OFJvoB9KSq/x9xI+6rKwdPBZPu0yYv4p/E/wz4T/EDOvhYVJYr+vWcymgnl0HgoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX3nTBXWH1Y1jIX9enOqfMy6SA5uamKOna6QRi5VU9VxphJ5L1
	BeLcmaJ23uytbdNyLXlJOqjX6Zy5XezDGJ2ojOa8RIFYx9542/8yQPA=
X-Gm-Gg: AZuq6aLQ+Obx7Lk0omepKp/PCUdKcf53D62HQUl9Q7Cc/tQocxHyhXb9zUcMG3uzgYW
	Wy7oB2aDNx037vEu0lnAb2PyrsO7CXnVt2E3VLXbwQMV9vZzrtA3TNtfq0LOMvc9j2zyDBs4beJ
	P9lKafDlIEJn0FeVk/zeITtx40JqoLS4UlRd7826UmUaxqNaRmkDFQskpkwLc8IA/Vx3fbuez8z
	Dvq/xcpFVXCnZoTvioNSZ8YJHmlexFZUzkxMhIT/e1goPtYO60H6xPoiDOVBOsdpegwN68+ePUM
	QRk4CcSJz/c7TPtLwI5VDF8/7kJ+QvJBOiR8fEhnYCZJchF4JsFWnopTN3J0fOeO7n+6VA4s7FI
	zgqGOzz/hE5xZR2rWBUrOqYTYNY9bZP9uaKOACWSsHVgWw1L8Fj4bK2ci9yNDfdOdXNqAD3KfcZ
	f4eE8LujuTKPpRlB0QIS7MC8BncqV86lI3uoQbpGRFAUqz2R7oG1sH5L0jEAQnCp/Ia7XBNusub
	NfK
X-Received: by 2002:a05:600c:4704:b0:483:3380:ca11 with SMTP id 5b1f17b1804b1-48373a74dccmr42130645e9.33.1771001143042;
        Fri, 13 Feb 2026 08:45:43 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac4a9.dip0.t-ipconnect.de. [91.42.196.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a58721sm26380735e9.7.2026.02.13.08.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 08:45:42 -0800 (PST)
Message-ID: <c1d048c9-c662-4709-be49-0e947df31ef1@googlemail.com>
Date: Fri, 13 Feb 2026 17:45:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 00/49] 6.19.1-rc1 review
Content-Language: de-DE
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Achill Gilgenast <achill@achill.org>, helpdesk@kernel.org,
 stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 sr@sladewatkins.com
References: <20260213134708.713126210@linuxfoundation.org>
 <DGDX0HGRJJ3N.1F1EWJEDMYZND@achill.org>
 <2026021312-magma-dormitory-53af@gregkh>
 <2026021325-repacking-crumpet-5861@gregkh>
 <2026021353-perfume-drum-3776@gregkh>
 <a856f911-c493-4c48-ade8-467d9da1f628@googlemail.com>
 <20260213-manipulative-proficient-robin-fc9c06@lemur>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260213-manipulative-proficient-robin-fc9c06@lemur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216276-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[linuxfoundation.org,achill.org,kernel.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailvelope.com:url,peters-netzplatz.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: 947591385DE
X-Rspamd-Action: no action

Am 13.02.2026 um 17:41 schrieb Konstantin Ryabitsev:
> On Fri, Feb 13, 2026 at 05:26:51PM +0100, Peter Schneider wrote:
>>>> Ok, pushed again from my side, let's see if it propagates properly
>>>> now...
>>>>
>>>
>>> It's a kernel.org mirror issue, it's being worked on right now...
>>
>> It seems only the tarballs are affected?! I could git pull this RC just fine
>> some 10 minutes ago and build it. Adding Helpdesk and Konstantin in...
> 
> It's back in the world of living after a 2-disk RAID6 failure, an LVM cache
> removal gone wrong, lots of futzing with /etc/lvm/archive contents, lots of
> very heavy swearing in all languages known to me, and lots of nailbiting
> as the RAID array rebuilt over 18 hours.


That sounds like an absolute SysAdmin's nightmare. Glad you could fix it!

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

