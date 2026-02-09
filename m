Return-Path: <stable+bounces-215571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAsdKOJZimnnJgAAu9opvQ
	(envelope-from <stable+bounces-215571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 23:04:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B75114F4C
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 23:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45C323006802
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 22:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8409330E82C;
	Mon,  9 Feb 2026 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iYb2aJP7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B432E764D
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770674653; cv=none; b=fn3ResvtVRTh3AsLgOJrUDl3xiDha4l655VYC3bu//U7rJ4ii0G9QeIy1LxtdjYZ3Fd1rohMn2hGKUsbyWtiGyxx4Nd8p76r6Ile2sTsUz82bzlIyg5V6IeTOzT6pfTcaRz7z+fYCHwdHh7SOWUaBr06fuzIIHpbVH4JdI8mZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770674653; c=relaxed/simple;
	bh=3x8AAsHfz48he51RVQ/eEzf4Joxph77j0tttP4mDhPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrmnvFFjpZLvOQUGJ8qxZtulc4ThPZzgU0xfhDB8AnhRe0ATqcj4cyP7LUIvZ2dXXekUIUirZla9Jpfc8jy6fLUzSQaFru6uz+e37OVK225Qp0vdiL0YDFabVJzgqln6RyerEze0nh/yddmcl8q7Kz7/E88d99PVGgcrTpFzaKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iYb2aJP7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43621bf67ceso2094295f8f.2
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 14:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1770674650; x=1771279450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBqcKC3wfnXy65yCZ/Dqr7YWpQyYvOy83IsALMdIYww=;
        b=iYb2aJP74xu7fSiGG3E7qIXtuTf8sJW0MN24aWJJI1mk+BCEROSQAEO76YBrE8IhSL
         gFcHfbVMebkBnpxonrAyfpDolvRVkc5h9MXkUvLUPz6PJlAJtcb/6nFbGcB2gOmtRf3E
         VHC3Jtzdvap+MmgfSAQUAlaZ2kW3tr3FRXo/NWURQbzrSFpt9F/6fe7DMkIqzEn29a6p
         7zCTQ7ABynePgW84HxeJzJm8DpN/zun+z91iLYPTZ3An2hKuJmOaVzF6jsrb4xH56wEH
         LEz6MzCh5vRSpW+QhCRROsBt6Xik2xvpk87OAM1a5QfyXIMKeE8foI3PAqfO3f8lQeXU
         HKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770674650; x=1771279450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBqcKC3wfnXy65yCZ/Dqr7YWpQyYvOy83IsALMdIYww=;
        b=UYh4UMtz3uVshj81R9jv+ftPzWc7s2GVUhzSoUWfvXPXPZ8OpzEcHldslQkNO864Vt
         fruoz4NmDPYomlobybNd9nxKfX+9O4Y/AsqHCUBlHAcLjCgOoDmw+hSbVLRfAlN1C+s1
         ZszPVH3RCdUnbAxxTiIPW2sbr/Wv/+fGL1+bAlRQ4Z3DaKlovJ3gp2T68OJOeiGDcjqD
         67KdPFxqrZheoVWUOAEjseLedC9YsU1z3OkSg/c1GSOE9rV8ODwxu+/YnDkZqR11LDXi
         BsAupAb8YbWZA1kzj7XYSI5L3uPnE5ISZZIcZvL5+QEcmNqGMKj2aRD7XrsuR/dSJ2Fj
         STzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqBFsQZhfggFT0C27dHcbUl91I2aPRwIEBtFu4YTm0i5xkNfFYkBiWvtlzdXaSEHiDdhg0MVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiuNSF4KzBvMx+XSUxZxfSfY6HzZIYq/Zh2E5+59S5XVvU+SEI
	SBDfGOH801Llufcyq4AZtdMmkMbafQh446l1b+TOwKbD1ELjwOGifFA=
X-Gm-Gg: AZuq6aISwapz/lP5Ufq8S085JjYVv4o6e1RY4oD8f8c5tmpu6uQg08u/qCpKZrZoFJv
	Px4WLAkvDfp3wcH3h245JKYGfNFAUlrwPvVrXl3lVV+PftAD2ehbzNSDl8cwEj10INyBJ54g7qB
	+stdesqQKlDBoRIugTE+VLR5t69QV/T4Re3sWgYOjZlbAo2goLe0HjQlOp1Nbx3lCRJaLkOIRRh
	ioOQmoQhgK5v0LU5lYLcof/tqwMtLMufXB4L1cf4FBrq5c3getEbPEkFGTqpvg7Wdx5JbSLvfna
	+K2OiCAQLDZ2yUFAd9jDahph9NIugLd9MdnzJB4nZE9bRAgwOO+eDglZjUmWwBUxhHYpvnPOHrl
	77jBLDw0H1krUMQmLm/PPciZ+H1U6p6xZgTZuszFCNt9bbw//GdbtyOqH7hVc+B6cMVcT02HePe
	1S8MSNGKZyEFmIJnYpA0lC5cxCLj3UWit44FksizoX481hKwoBgFvaMIK+e9w4hiClzrPshmBbA
	g==
X-Received: by 2002:a05:6000:2585:b0:436:1a2e:9f1c with SMTP id ffacd0b85a97d-4362937847emr19223698f8f.19.1770674650438;
        Mon, 09 Feb 2026 14:04:10 -0800 (PST)
Received: from [192.168.1.3] (p5b2b41e3.dip0.t-ipconnect.de. [91.43.65.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b20fasm29227652f8f.6.2026.02.09.14.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 14:04:10 -0800 (PST)
Message-ID: <fc5a15e2-773a-49ea-8b2c-f896a197f7a4@googlemail.com>
Date: Mon, 9 Feb 2026 23:04:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/69] 6.1.163-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260209142301.913348974@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260209142301.913348974@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215571-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[peters-netzplatz.de:url,mailvelope.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: C1B75114F4C
X-Rspamd-Action: no action

Am 09.02.2026 um 15:23 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.163 release.
> There are 69 patches in this series, all will be posted as a response
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

