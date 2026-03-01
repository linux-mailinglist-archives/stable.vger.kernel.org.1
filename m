Return-Path: <stable+bounces-221553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJiAC6CYo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:38:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 396ED1CB359
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F11B3055009
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3BA2BCF4C;
	Sun,  1 Mar 2026 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mBX5+e4n"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608F32BDC0E
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328563; cv=none; b=qaDBpIjamtM0fbzmAiibiM2pJrzCvBkVn5pRDGuXV/Gz1ApHR+D+fbNVMWHqx568B/CUNeKv4f1cbFjGSQgI5tBJEo7uBCV8ky8RjatFY466m4WA1uFBDNCl5ThTD/I5VpbxV7gZcdEUBb/DwXnDpTxzFEO8yB1ndeG+xFPYXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328563; c=relaxed/simple;
	bh=uEu7dR9Uvw7QvGFddKA74Gf8SlDLsV/O8PuOIUY13R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B49R0dbfL3Twwlo+MUAvItVwhEgIcJMl586jDREWr8RdTvO6M4wXJAWkv7rSfEXt/4RzSVpGM6RzcSyCc6DcJGQwu0oTPa7HmVr7U7lQSI9hAfo4nfWG/eHXGouVu5H16b5dNQ7NX5P39tN9iiP9atHTAf0oOy2TMZU495rgDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mBX5+e4n; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4398f8403edso2617920f8f.1
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 17:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772328561; x=1772933361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JijInAiycVpYptM8wZl50nhTPo1Mz10VzFs80VPpey4=;
        b=mBX5+e4nPZLH2L+XOSt5m5Y0AqXBXk7fal8krYuMD3xuys/48yb/N44YE6LULklPPg
         jo2/k/dWn3C1BQNcpmzi6F9txajUdUUJoWr8Nr5h/0+1LA4e2jxy8dlE4VE5SiGzh2BD
         UVNS5RWBxkgqroq5J/byx3bAy7fUVn4hnoi2o2oYgQiifeZBbLRfjzcbcdn7c8dNshmS
         GI2qHUEX/DBmpMhWkkMmQTkwZ+oxE65yC6WTR20v3k98HJLk2UqKdv7Mpj8s16GdEL8m
         EJuL7g4glC5UalxrmJu7B+KKrcdgGzMvc0LetQdUDpIUU+cdFXLyxYdRfxO9Z+7ZIpkY
         oyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772328561; x=1772933361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JijInAiycVpYptM8wZl50nhTPo1Mz10VzFs80VPpey4=;
        b=nl+RcgmMFHtMPbhbU18rROfP8GdAEp4UNGAtJWlsSm0alsEaeZaFvleFcE3XUlbzwE
         mpL7olKWyhyMenZZDyL4MZ7odK3teWqY4zr75uYpY/7GEGylhMRX/pNI42yhm2W57RdV
         +aZGyUVaq2CfhqKkY6Y328XTuD4K/cJkN2hdIpJqB7Ap2mnXKPTYudwrFM52Iay6kYRq
         4HvvsU337cnxR0/r2awjvFw+PYI7BfKrCk5kL/5cf/JtMgv1MyMmh/U+GH3DS3Lg9tp3
         sgv1Sg1w24C1Zvbc/gsvEA2aGBYN6LXK49vP/HY8y9yCykiKTSdyZqLgmcwj2NsygCwu
         Cj5A==
X-Forwarded-Encrypted: i=1; AJvYcCUuvzdxAw/3NjDD8m9noWFMGHrgvY76i2Z3aflHYvAcS7u2qYS3ePBkfcmiw3MR6dUCxpZBTes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ht/jqj+VqksBnImyEpeFT/NVGu6w7T2w3kGqKDiCFnweTdx5
	OWafXlWFnonhUYMWaPY2OznziASvTBItbDHGulXjLwW+9VOT0PHz1PQ=
X-Gm-Gg: ATEYQzzlY/XRPnlAT5kC2W0EByP+4AMVfEGSsljoD4fhEUXYzqOaDF6bVx+6fxAsGEh
	uT7Ah6wwEyxBB69w+nBoLzUZsf/z52bLeRprkyu4iNWUZDc/SqyDtchj0lmDAQkYPNpmKd2eTW5
	DmxU5zifmmYx27LacF8Koe8mreVWAFMkaOTfXWbDTrYHd3/SQsaH23PtPdhnuWFHzof+js3qS/y
	2lv2AFA7qht+NXiYKCISJAuBfulfTx5veby5S5cO82fkfBsBy5t2r7DmDA9qHv2qzakr6IyTc2P
	LnGlYz+YiV+9vp5LVIRYe2X9Z5GRQTUEo3cutKWis/SeTx2FUmXnBSjrgwvqcGk8yyfseLVJ5tP
	yPPtUtfPRGhfPqiJ+asXNuKQ1GobgxfkCcdnBccbrReKbwnKPO+jq0xPGxLeOnGwHmfkv/eEHz0
	JCsKutOVU1CAn8lMDlm0VptqLevLskR92fMx2lVHQOmusWMJWIL88MSzQ2YJLU9rqVZGM8ezeHo
	y9J
X-Received: by 2002:a5d:584d:0:b0:439:94ac:c43a with SMTP id ffacd0b85a97d-4399dddba02mr13234876f8f.2.1772328560563;
        Sat, 28 Feb 2026 17:29:20 -0800 (PST)
Received: from [192.168.1.3] (p5b2acadf.dip0.t-ipconnect.de. [91.42.202.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60f8e5sm19600709f8f.4.2026.02.28.17.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 17:29:20 -0800 (PST)
Message-ID: <6f83866e-ecf1-441b-b798-e67fc6b4a801@googlemail.com>
Date: Sun, 1 Mar 2026 02:29:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/385] 6.12.75-rc1 review
Content-Language: de-DE
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260228180001.1567994-1-sashal@kernel.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260228180001.1567994-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-221553-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 396ED1CB359
X-Rspamd-Action: no action

Am 28.02.2026 um 19:00 schrieb Sasha Levin:
> 
> This is the start of the stable review cycle for the 6.12.75 release.
> There are 385 patches in this series, all will be posted as a response
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

