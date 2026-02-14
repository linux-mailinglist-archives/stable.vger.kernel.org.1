Return-Path: <stable+bounces-216415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMuoIFDLj2nMTgEAu9opvQ
	(envelope-from <stable+bounces-216415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 02:09:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2894F13A91D
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 02:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBFE330A57E8
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB362222D0;
	Sat, 14 Feb 2026 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EFf4L2QN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC52217704
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771031162; cv=none; b=LkXJk2lPF+DzteTZBsj/yDpxzYnvfuWHmV7j/xE0844WfxvwPYONdClHk75OZ9q6orz9/L+W7S/8n/pD2SDLruNbbBu7GYeZZuf/wXSm3cflcbUUdq/wjX+UqqtiYZtqQnNlZBIuP1V6j/I1ct7RKk1fqfmOxTIhlPx6x0IpWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771031162; c=relaxed/simple;
	bh=FEmd0AKqUxl0fXw2shyi1YhQuDt7hoHaK3mkhmqaYiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kb08fYvhyJ1FDWobAoIUoS2f7nwx7ZpB6p2zjBAqnKWCg79hFR89O4d0P/h8lInToxNlJFpDVl7yZZ03injJs6Ft88FN5lr+l9EDDNhuXxzoDg9zp4fyIkAFb8EL/Gk+m3rk2np9jWOJfWjmkVF24pjTTnOR/VC9qifMquWLKLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EFf4L2QN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so13189875e9.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 17:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1771031159; x=1771635959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7lM/++ZWcxxWntKLxyYjecJbGQkBr43eWhSpcYnMls=;
        b=EFf4L2QNMQBIJMLByfqkwDaCWZ45WkfmMzZhIiq7hHTFBCoNBzC0ygfoRPrvz0JaF0
         puw7dMeAr/kvQc/d/Ld0x/WriFEP3xUjNhwp5qbFe5Y3FZ2HOLnIfoADQ0aNKUT8iMAJ
         5UZ4GcaRrWxkOqAgth0H0VH9J0qV6/MgVJV0JrXQZ3Y5zrJq2LRRXjnUWthGnxUhgZCV
         f4lqmuLCLZ97n9Fopo0I8vt5huYNJFaMrHP/ZxgD/H0RWsLa/oOadCvmy1nhIDeMJLp7
         LMVg44VM5P9jwUKNUibfT5gr2OS97oZ002rA0W2SQn4NGqbYfeWHv4Ooi0g+i6d51pyc
         8u8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771031159; x=1771635959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7lM/++ZWcxxWntKLxyYjecJbGQkBr43eWhSpcYnMls=;
        b=CgnuFjGoCU3j6CwnQ7/gjRsvsYZZq6tJ0nxIRTxtITVqDZ3/Ce3/iRjMDCq6MkMEzJ
         sVx1sk3rbzX2P9tuaeOSBYCfpIrP/JU+bu7/ILqXAhrDhb8E2Nt4S9FIcoCgjYjKaNqm
         ikcGSPKG5x7oZKIas0D1wJK198YKNqM1sIPqYj8rTdDpiEvTK2PAO27cUm9vargznL7z
         zXnPvtym4vERmniKij2m29XB6NGm0CJqrcYO1zEkh7BdtpHVdXta9zEcR/uCVObh5YO7
         RL17yNo5LjclDoQ/1A9Oh/ZWPaILfDdlyD1YstbsnFD5dbAKF43MzgQTy6hSbQykr3p+
         COuw==
X-Forwarded-Encrypted: i=1; AJvYcCWrJ+dDGFVi68L/tHIIBf1NvM6FthE1svc3yODNI5Pd15ZleSaiO7o6EqVy4Cc2+9+Naz5YqQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkhWkkGonuchG3sO2VGy7svuhY7CToe7RDmAmWG3hZ5AjL92+
	cM33a+XgGdC9Wo+y0EjXC8W0+CkaQzD9q98jOUuM32xKtURWl6Cq9gg=
X-Gm-Gg: AZuq6aKbYe7HH9ZTMtUArScaawBvUUy6Jf8ceEtGHhMZ3QpgX4QTpeOsznBfOLCyxks
	1m4nxNJPP0n9ezAZNUih3f2Qyft342r3fSxm2tafx9xtYFU86I6JJ+LtIdpd4EvpD3CLcndFdvp
	etqL+IoU1mcIEOqSAvdsvIopGh1oLndfN4URX2sQ5p7Q9fdE4PPmZyvuWSHvUeugttx4q2dzdZg
	RGDB+sUNCptk+L8TJa/SUmpL9bCwkbECTeulKIGMn0JTfC+WARlqJj1hdU6bJllm96fOrXd0TPf
	21MSZL1lDrUv6hj8H+m2TaffJn56X8zGZwpKMu2cano+Q74TxAth9y7PQj8ACPZPhs2L+3eyAvN
	G+uWL3SMdp/tP0H7yMTletCHbYOo2U0fYXcnLvE0ysRYHiQAaAP34k8iUceOexwMYyPrbPf1wxr
	hG2ATMRETT58xx/rP3rfbh5W2nCbY+ND2pTVYsh/EXymb8Mm5r4RCqWr8XQAi3MbnX42gGz7w/W
	Tek
X-Received: by 2002:a05:600c:4e92:b0:480:1c53:208b with SMTP id 5b1f17b1804b1-48373a7bbf2mr67553285e9.36.1771031158546;
        Fri, 13 Feb 2026 17:05:58 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac4a9.dip0.t-ipconnect.de. [91.42.196.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a3647asm26346165e9.22.2026.02.13.17.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 17:05:58 -0800 (PST)
Message-ID: <db777a81-1611-47d2-bf01-c6cced29a019@googlemail.com>
Date: Sat, 14 Feb 2026 02:05:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/25] 6.6.125-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260213134703.882698935@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260213134703.882698935@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216415-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[peters-netzplatz.de:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,mailvelope.com:url]
X-Rspamd-Queue-Id: 2894F13A91D
X-Rspamd-Action: no action

Am 13.02.2026 um 14:48 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.125 release.
> There are 25 patches in this series, all will be posted as a response
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

