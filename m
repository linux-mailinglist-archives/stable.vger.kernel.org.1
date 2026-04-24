Return-Path: <stable+bounces-241057-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7IxVHmvk62muSgAAu9opvQ
	(envelope-from <stable+bounces-241057-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:45:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D50964638E7
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F6023013731
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49BF382290;
	Fri, 24 Apr 2026 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hHp26quO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C9135F197
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777067109; cv=none; b=mV9UVErz9HO/X3EKehBB0ROK+iiibSTZOZz3RKelifi85Vk2l5gRh2Ks25Lq5kG2Gb0cI1vy/hZ7f/PhCgZjuC02o3ylP7XICWJLnTygkR6D1cTjjX4z1k5KnXNA1qfHQfahqX89sGXkjBr2hjqZj2/8xpAZV7yIKoED5Gb28OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777067109; c=relaxed/simple;
	bh=VYmtfYUDxWUTjpyf+Tzlir8naKamfgNhl8+b6UQyOHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmKayDjlfZ5RZP6ynijc8FQK7nUukdGIR0X2dKRvlnkdMaZnX9legqGMLK9AVQaFP4iAkrzPAVr/F44heX4mFBiqiA9hSxVegV2EOkHx8CUaDsHL7TTvwXYgvGoI6/gfyGLbCltlmEuAciTfMtqVeCkjUj4bkxA+7ZtG3g9VxXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hHp26quO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso40304995e9.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1777067106; x=1777671906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2aI81L5chyLWW9Y8pZFgdge3TQIZkIab3J5jWZXj7s=;
        b=hHp26quOK8nk9+X8z1H7Cc3hrO8jzNwRafFjYcPaMw6sUZWPp5RbyAId59d1W8/fDE
         arB3iLiLXV6yUIorJU6zRhEcwRyc3K6uSGp3vtN5ykHk/M4SWln9ThiEOSu2ftdswuLn
         FZvX2u30YgUYCZ177cvTWcmHf7jGt/Tnglavkg/2fTbYBKsQpSZAmeVAWV/z5vWkw7RY
         57nZIce5baBAHEbEVJApKjT73cm5mmB2N+uNM6y/tRE1B4kw3LoLYLR9UG/6OIxqPIDI
         +OwKyDob3hG1LzrZ60Zjc3vV6R5RJ15gu/4vuwSt5bPo8oNP1LLjh+7WnuxhuaBjCIVt
         HBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777067106; x=1777671906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2aI81L5chyLWW9Y8pZFgdge3TQIZkIab3J5jWZXj7s=;
        b=OwiNf75SN4gCYQBS9WLnIUEjV+W52OqJo9ZU0QnQTi5ly5Ow9/UFQ7RU8FbgvXUlYo
         jtXyVpBxOfQ1w0kDgsUIeVxxCd8FPs4cZ+F5bl4XS6k0RSqn1v+/9kGrLELb5cIwDCT0
         vPydnLBP8U+Fue/kgrbYOHTzMBY0/62f7RPJ2uY84GQ1eoH3ACvhGRQ05qJoFjGXcvAc
         lVYoSsC7hJa2C8IdTqUWNdgH0mQ4rov1s1e3YFJ7lj26a5TlZoAsTwltL8gVtQmplHhy
         bMibHJq9Rr718J0X3qD0JYSqW5bqjN5NWFM8G/cC4C1BjPwE1iraK2Qb4CLf9BP53zfL
         sO5g==
X-Forwarded-Encrypted: i=1; AFNElJ+234uKZ25rXNOYny5DyXEE4ZZuUGiUSNtaSAdPwDeQPFlRinYS1npiEa0y6KsrQKb6pjy3+BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxldLywfuJzwYH5ttGWJMMH9yc11eHsRqx9WBf683fQKzZlQEzE
	kCIL4yAHj66qbrp76DXPy6xWXcyMiG6yocWiUXCNYnu8np8XBCu1iqE=
X-Gm-Gg: AeBDiesSo4kV6TVQA96EfCCpXbMmIf2CYQFgJrPnYHu09t2NPlDgDA4eNR5hK7f2lq4
	smsFnjGATXunlg4XIaB+PPdX/8KNjhgG44Hen4fuDysJhccIWLK5FELVw48z66BOxQnc1Z01TWz
	3LyjbOv5vn4cXQBfsKktPNDsLajh/M14W8vt2GveFdPLrExM95ic801ex0cOrjFjXv3VW4ZmDPp
	g7MDh57Q0L77yAK3aKc22t9pW9dUjp6duQJ0O603IEFW1NNAInqG02zJn/bmj0BFSQx4w4BJJQ7
	pj/8j8EEekM6XRCz6ZtfiL9bb37BnuDB0GrxZ9p7NRpntrk5QM57UkehB8iKt+QqGR6UTMy12w2
	tsBnFlk1/YTMB/q747Z5uN0XkOI27HgQv5lR0IRJsnT99Tsed2wvRekoVKzV153s/tfENtcTFBd
	kY5bx6L9bw6g7a3xlxdW5NTNyUVqE79T0bgonS1cJqaV1CXf+HYPVO9OfWLdb55LQW/JQIG6i70
	4YWIbezf4wm
X-Received: by 2002:a05:600c:8b8c:b0:489:1d74:56d with SMTP id 5b1f17b1804b1-4891d7406famr365430635e9.29.1777067106240;
        Fri, 24 Apr 2026 14:45:06 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4e21.dip0.t-ipconnect.de. [91.43.78.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb77b001sm295762485e9.3.2026.04.24.14.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 14:45:05 -0700 (PDT)
Message-ID: <60cd58c5-26e7-46f6-8071-08e2fb0705ba@googlemail.com>
Date: Fri, 24 Apr 2026 23:45:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 00/55] 6.18.25-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260424132430.006424517@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260424132430.006424517@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D50964638E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241057-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid]

Am 24.04.2026 um 15:30 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.25 release.
> There are 55 patches in this series, all will be posted as a response
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

