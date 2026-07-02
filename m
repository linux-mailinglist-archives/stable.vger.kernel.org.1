Return-Path: <stable+bounces-271565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4M/RJ1HORmrWdwsAu9opvQ
	(envelope-from <stable+bounces-271565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 22:47:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E56BD6FCD16
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 22:47:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=googlemail.com header.s=20251104 header.b=nh6zGeuA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271565-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271565-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C961D30680F2
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 20:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ABF30675F;
	Thu,  2 Jul 2026 20:46:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D649F352C3F
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 20:46:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783025208; cv=none; b=jgg3I+o3gc8bOEZxZyTOQTrXQH+Rn+PjqZ7a38tYBncJf755xFknoVnU/HD25GrrjTaaZTHKat56flXMHXVO5zPBfMkFOxLLiuqUd1AnNBYqBVNnLvObLgUNmsxs8Q9Fg953427dwqFXRqWwUSpKycOTy29h4oVEHWu/xUMCOV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783025208; c=relaxed/simple;
	bh=mzfMrKegHTcQ3RSy166F0rX9swRFELx8+9bHvnCtMOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9vhAkVdA+qF5fXgwUXjuorJyfu/7xAZoZS4PgkT/CfHcFpfr55jGpCqVddm/ePBgig8onnhZ7eWenkyzIy7sKMi0JYJQxi1KdPqfCsSHkNaPsS4ZLYWuWGDXTjd2h+Qm+URfo2zu02fU4wRDKlf2GV9ye+MdhpWu3gOX3Nhwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nh6zGeuA; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-473ba028d46so2282516f8f.1
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783025205; x=1783630005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJVX8JRPAX+8aFg3xElLxvZtOlGVWEW18wH1utQChXk=;
        b=nh6zGeuAG73uWr3tqE4IJoByS9VihA+/hYHgNc0KJ04ZCNYXOoLE+OSWzFKMBrhKKI
         npV6UBggpPfoHWcbpHre6J+PIQ2q8JauZWn4HIZVnmI3WVMZVpxYocWaE9J3i2BurnGi
         z2HlKVrIXGlMcPop7VwTgisEdAf6LBWUxGS0h8ZdJ8bNuitjuzglgTgzTj6BumBzxYbc
         stV48uu0aL4fw6/W2Dhthrmz/ILnl6dhCkV/TK0dVygHB7s5B1xq+es5kVcTou9xsf1R
         s/vHniRFKllCpCrTZ+aZix7DiKFpr2IrkZlzh0h8KIRgVD/TwMFURUrgDcSuvweEfM+f
         Tawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783025205; x=1783630005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJVX8JRPAX+8aFg3xElLxvZtOlGVWEW18wH1utQChXk=;
        b=mZsZcz5XHJ7x2Sn9bKytevKnPabd2czFCb+KQI8D3qj90TPibGUvVZZHBzle6YkWtN
         s7BPaSS859yF+zDeZaLN9usDYE65iH0WvIaBZ+1jtiwZFjQUS8j4oO96+uvO3axYJSzr
         q1DHibI3bv78yieQB3Le2b/FArkGpBPEElfsXfYPzzKK3ywHh7nkJcIPSNFzG/tQaOgr
         r+SJXkMuf+q7DRtwc1Wa2iok+GqQAq5wLyKb6EU1uz+tbFJunNN5JKeQ1PPx7j5Upk8v
         RwsLF3drma9qzDrFMFgIJTWSrfAaR7isWo3Y3H7X6Rtj0OOKaBqXjHR8qiEeJA6V+kzv
         Hb5w==
X-Forwarded-Encrypted: i=1; AHgh+RoBOb1k6RyHbt/iIgxlNlJ8+B3DtNPPcLMWpDmwcBNRZxVOEMuU3iFq+CBDGqHHvSs9rhbypX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfsh0ViFkYNR5KgdydQOqducLlMMy2GOj1H3ry1soosN7mnJ+
	c9KBEDWn4XQylNoQFW7q3M9WiRZ6D8uZ5cQb63ppoL4SuXxXVA2H6O4=
X-Gm-Gg: AfdE7ckD47JhP7J4v3SSwl9upSUsf8iZMWJ205cZ6wEkcL+3P+jaLXNOid+j37Vdg7x
	mR02kb4B+Gb062qmNsd566sH6MU2a4w4nNYNCvjkrlmmVYDcGzwfwWb4aZPQV4lqAu4ik0vAUTr
	5bYAd6kh1wAwWY89snWn6L1i1MplpS1PnKpo5hlBewwZ46xl3mneA1jJZM7pH1mqMbSK4ZaoO0X
	C53paE/52f6xKx/am6AF4rQ1t7YHwBXSnXog+9fRg9srmUckJSsP1NFa9aQ98EeIVwl8/xx6tGi
	STg9mIP463iqm3kcJry5cdWEVsMbPPxhrk6ovPHYkFE0mmeIPZP/McArHmHoJ82O/CxjXa+8+Vh
	N/v0e90ounxPk62hmO0Yf3kuuH1FtiaUJmSITKDWQz2JEn0n7jEy2NIiLvmfCP4YirROm6qHf55
	0tM//sCTw7TpSbklXpQkVU6B2upYqrIut9zJXLiaz9DZSqrdSXvL4GAa3y1zYLP9o=
X-Received: by 2002:a05:6000:2203:b0:470:c049:b444 with SMTP id ffacd0b85a97d-477550090a8mr11611351f8f.0.1783025205255;
        Thu, 02 Jul 2026 13:46:45 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac307.dip0.t-ipconnect.de. [91.42.195.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dde1a4fdsm12963775f8f.26.2026.07.02.13.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 13:46:44 -0700 (PDT)
Message-ID: <becf13e8-600c-4f10-ba82-e8bcc972d8ca@googlemail.com>
Date: Thu, 2 Jul 2026 22:46:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/175] 6.6.144-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260702155115.766838875@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pschneider1968@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	TAGGED_FROM(0.00)[bounces-271565-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailvelope.com:url,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E56BD6FCD16

Am 02.07.2026 um 18:18 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.144 release.
> There are 175 patches in this series, all will be posted as a response
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

