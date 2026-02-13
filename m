Return-Path: <stable+bounces-216266-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGMeEH5Uj2lqQQEAu9opvQ
	(envelope-from <stable+bounces-216266-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:42:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1369138519
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56978302F710
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1CF26FD9A;
	Fri, 13 Feb 2026 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UVCBcOHe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D2248176
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000430; cv=none; b=nuvLee7UJE9HF9IiFTOIA302RY56Fix367OxM7LuyVZUa9ZQiZlLO/hSHYFXNU9CxblT5yk+Zs0ruGUMbRcvXG8tT7MEdw5oNgFq8QGmg5uxaraRqCobxDc5e+s7zsSNHOQ5/TpyDxlzu8X3/DIVB2n4F4a4IyWEZPYfhABeQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000430; c=relaxed/simple;
	bh=dtorZ1eXQQYnzmmxUntRXWIAuA0jPyHcXFUhhi5qYlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFx8htFbfJCqmoHwP5ADy1MdWTKXPfJS4a6Gl3r+1dVIjsFKl8p/b9nfhIyBszFxG2Z+QfvPAZP9XOJyfle38776cjhMDSzHhLfEyFtQwam/BwL+zE6cp8GECOCFbF5EM27GE2qXCO8LSqw8Ha9ES7kb8IUVkOKkg0/RSVDFDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UVCBcOHe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4807068eacbso9088175e9.2
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 08:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1771000427; x=1771605227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTI7f0FcYtvFBidqNRRmKjcaE9y96AbIePq1Ojynhzs=;
        b=UVCBcOHeS1l6IO1cK41OgMuWltPhT926qUxajlI9rcBjD2WFVyL6fniQoHlKPSC8Qz
         Smng+t7tzsomWuZUMtGq6plRmxbuXLdKW1sGJmV5DUKH7rKb0ZClnb3Af1E4i94Oz/VJ
         PTP9oEWkwleDyz6ERPq7mLx6TvCkEpr9NXk0NPhWH6ytRzdEa34xL1at1tp6NsQbc7Gq
         cplx78vqxpRMPrWrUv2TpRQzfGS9CxY2HuwCn4OeaA4KJK0g+wBiSwHxgI/9w50FGZti
         62LUkN0UHQoWpxEpEKTN/e0WsdBHbMaWubwfVOR+WwA5FxV+89z+gjy0ZC6DjG+4tH2g
         CuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771000427; x=1771605227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTI7f0FcYtvFBidqNRRmKjcaE9y96AbIePq1Ojynhzs=;
        b=mmbYTU6G3WL0JIZ9x1mGKonYneD+APtNjz6kUn+b2GuNJ+LGhSLTZ1UPgRx/pCz1px
         dhxxDmra+8EG/Sj6J/d3npSdNhM3hRi/i2V99DEA1RQ6fPP5QyZf+DBSPOU1unMXzSvr
         bNaqqqH7wcFo1+Y/OwyZNfFBfhV4904vqOnfUMnDfHnfUwY1mloQOq753Xe2uhFabF2u
         23NvRX+lmzj1HX0YoRgeI12Gtfx8drWzHv7dzzMROLz96FOz5gSjs9OscDyPXB3VOt8K
         Y56LEssDj5EdBIrgIA7VOZ4J+4kuavfH9GbaWD2nYH/u+RrVeh2cYrKAZepyACQ51bmA
         00TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW0y3AonXjTP3qmwDXcd3yUX1FArynwvFoX1RP3wq4eaXV5MPv/aCB4m+TsQZcN5IH61xiUzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkXdD9AbOBqMZffp5mKXVUR8Xba25NQUAFO5pNxUor0TtOm8L5
	B8U+SRy5RI/naptElWx46K09tpGW2ys0C9Dv5PfNntFSFGGohBxj7hs=
X-Gm-Gg: AZuq6aIspx9DdsLP5M6kUG7s8CAi4G+OPStZBFTMemQbQ55FhJkxe8UDkbi/XD57TPi
	3ruFW/4rD2acRj/6vhj6T1syRcthQvqNd5a6YQ79uD7A/DXB7J5N81efOGyD1DqaKndCC1rQY1V
	d+POV2QXSTXQbwwQ3mePemZmD5Vne9OhIVVexfqLKb8hcRxNUVQBbcjNhq2ZWCVSiEECpHU2sHw
	FdXwDvsEwHKgMgu+dyFscjdTBs8YWFigXLFnN8lAbRAqoR/hddEzLAvQsTpAPV2PdpsAdl4G8nI
	ubghixwLsG36hC4YCy6slnz47J/o5TYKBhGSOxDAZppMB9C0sxMDEgt/9GLYeJm5Jcv1bYqTkQo
	Sy74xo7nIVMy6pkyp9cl3ODviIU1IWT/YreX+tlKlE49ii2TANt5ry7Mvce7R/HWihKMiJM47tJ
	xVIcpAy+An6l0LG0XfpjFrXW/0VH5u4L7rpCqZWwoqNOAQlhMVbGmKsRIRVSQEnMkR1svKtnM0z
	q2w
X-Received: by 2002:a05:600c:3d87:b0:480:3ad0:93c0 with SMTP id 5b1f17b1804b1-48373a5d6d5mr35181365e9.23.1771000426741;
        Fri, 13 Feb 2026 08:33:46 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac4a9.dip0.t-ipconnect.de. [91.42.196.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a29982sm19392215e9.15.2026.02.13.08.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 08:33:46 -0800 (PST)
Message-ID: <db18bbc8-2e47-48a3-ba53-9b6939cd33ac@googlemail.com>
Date: Fri, 13 Feb 2026 17:33:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 00/49] 6.19.1-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260213134708.713126210@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260213134708.713126210@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216266-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailvelope.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,peters-netzplatz.de:url,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: B1369138519
X-Rspamd-Action: no action

Am 13.02.2026 um 14:47 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.19.1 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

