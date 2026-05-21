Return-Path: <stable+bounces-253495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLYANDjXDmr2CQYAu9opvQ
	(envelope-from <stable+bounces-253495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:58:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3395A2D04
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43ECB303D549
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1090370AC1;
	Thu, 21 May 2026 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lUCSX6jN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30654352C4F
	for <stable@vger.kernel.org>; Thu, 21 May 2026 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357164; cv=none; b=cMSYAw3SRNHgYDtHXZAJ0YYpaJHTe/VuEjfTP5dMchjxKCofVqSNqGx0u/anrWURS4/+wpX+24S9wtbEJ2dhWjr8gGn9eOwKkGTvlp1UBS/qy4JjT36H5OaPyWJWnhQ/Z8jyYWX1rDVNDAPZfZa08zBbLPnnctEzNj7ckcGZA/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357164; c=relaxed/simple;
	bh=0QyioV7LZG/XafwqGzx1VCMm/RXybvPP5wY/7llNAPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOpn+Ic8C4kZphOOZd3OupzNU4pgYE9g4phJN4LLzd2QaOPd1tGZ+hAgMl1xHPFEky3Az5CBMoDltM+FR/v/EDq63a5u9hO3miqBbXEmPYHzdggrM8QoIS/IwCILrIPD/UuvtzLAJ6lJMlDe8jSS+ODzm3xTKqwxc5w1zfWH7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lUCSX6jN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48896199cbaso46053625e9.1
        for <stable@vger.kernel.org>; Thu, 21 May 2026 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1779357161; x=1779961961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHV1Tr2qVkGaZPG2Ty6FXE6k+T/1YKEQK/jgqv8RQxo=;
        b=lUCSX6jNUGAw7qsED5YInsBzcLIKGeWhpaOvniuvZWHY9xXqWKW+Flc2V2aQNqB262
         z6M/JXoNmym0W1mf/ATWbg3rR6sFjWmUMNgSvcMXg2+Bzbi4kRKAK8zLIfPknhi4HdzY
         cLXJ+0CIxunmVxoW3fnmDA1EDuOcr2KD/awKodzkE/gsPNSBU9a2jfWxg7fjPic6OZmL
         ZrKYDhBul33/JZ4S3xANmyDMnJ8vZnwXQCYF8EdYh9JxqHkDcftcHFrcDySWiCjwRDAn
         FfIx4/+3avE8znqpyB+Wo48EaePrpVpCP4/aBOsalZgKrCi6DbUp5lKfdMvFNHdLppHx
         Mr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779357161; x=1779961961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHV1Tr2qVkGaZPG2Ty6FXE6k+T/1YKEQK/jgqv8RQxo=;
        b=kKU0s2qr69WNypxa2lnPN6xysZLqqY78bkHQqHWPj7ixIW5nO4qA25jjCwn8nHNGl3
         MKbXhG6sEn6tLo6nufWhYJUbKafarUA2OvPerehoNyvKciQFWqrl73i0yllSAsAlw3nT
         nrYfUZ0pjXG8rYg0YGQqBiQVobuIDDZfcXjHQ/nFv0ER4/cGuURJ6IH01tJDJuRpYu+J
         JO2Ai9c3MPp3XUoWRIM2+l8uaXMIaHs5mGQUmh98SGmAnnOMIQsmXILaxAyPJx0l5vJ+
         nfQAeeZdT2wymxx1IA3f7A8IJwqjgSYQK4NOSSq0HZomhoMs6dLcTQV2Sh0T2zzS7Q0u
         wZHg==
X-Forwarded-Encrypted: i=1; AFNElJ/ky+ew18S+/902I3rlcOkwq+S6hI0be1NoHVuEHV+yje8VwAgducNurUvuQ4YPYTSS2bWJXu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlSFH932o4jVSAmR6ZmB8Tx17NxflVvzUcY/46OFIsAQS0bydC
	TRHjFzz/B+wYVbPj3AgUaSoWlsAxz60hnR2cR6K0Tpl8B6s5P3IjesGaGlZu
X-Gm-Gg: Acq92OHDRwSpQqli5Ypj41nQtReRrB0hmpdeyCeTfJE7SSaUnCvR1Ns4ci642vRCSj7
	PmbVElolBuYnrBVa6SAhTckI7CY0pVJoRwchauCKfhu6V7/XDbVNjNYLILQPhJSgO/AJiVGk+nl
	7BLV6K+KnDxdc8sBTa15lJtkpuNhHuNEYa2TRbQD65SZe3NQpioZGIuVnl2KafM9/iUjPiVGomY
	OnQ7fHKHFO3wI3SyQK/9ISWOwxJ6HU5GQ62nsEYGSt3PCnJC0T+xhPlCnqdH8vGJ0ZPNsIvUU7x
	mcoPkjCech+7gc2czxAUI4qUkXOXJmXlEKabAQGNTjgIl9uEPS1NuUQeIU/2cBJE5HK0UuoUTii
	olmgABXzvJz0te9tapjTkxhh3f3fXYTyHtFqJijiEkzs0j8EC9I/9ZcnMsxaVDKk2yw9fKJ4jYC
	DOEmZmI6+7krpZEUF7nx1ETfMehp1MvmH3Se/zG3iXqHxd+KsDvaHrXcUDc93EiOxcBvbjRyj+4
	TirEZVedhVMGQ==
X-Received: by 2002:a05:600c:2d8b:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-490360a53dbmr17287135e9.20.1779357161328;
        Thu, 21 May 2026 02:52:41 -0700 (PDT)
Received: from [192.168.1.3] (p5b05786a.dip0.t-ipconnect.de. [91.5.120.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa93d29csm1604352f8f.37.2026.05.21.02.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 02:52:41 -0700 (PDT)
Message-ID: <7014b6c8-ed0e-45bb-876a-93ce4511fbbc@googlemail.com>
Date: Thu, 21 May 2026 11:52:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/957] 6.18.32-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260520162134.554764788@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253495-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,googlemail.com:mid,googlemail.com:dkim,mailvelope.com:url,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: 5F3395A2D04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 20.05.2026 um 18:08 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.32 release.
> There are 957 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

6.18.33-rc1 builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions 
found.

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

