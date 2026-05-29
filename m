Return-Path: <stable+bounces-256590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GMCMOFpGWrGwQgAu9opvQ
	(envelope-from <stable+bounces-256590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:26:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43573600C9C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60F6630D93DF
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27E73B4404;
	Fri, 29 May 2026 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kfIOb9i6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CDE3A987B
	for <stable@vger.kernel.org>; Fri, 29 May 2026 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050009; cv=none; b=T/BVB3Cr9ksOHfo5BmfwQG0jx8T6xdFFg3KMMha2bdM8nHUrlyW6V7hva1+8Lo6QX/jYfsSf1sU8Fz0VyKAEomeuW4srYXTk8aTG6R25rCCqJaJlBuuqwY/OlYS3NITfr/aEMfDhvDVm7B5WbAYSHY5tYQ7Dx8FP0fM6ym+Vago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050009; c=relaxed/simple;
	bh=5GkvrOEVrrgj4xkZo2YTg97BZwgNf6jIcim4o42INkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEMs0355F75wn3xRM2VwjGNw1xdIP5PcmsoCURE/k6fLgpesGmHkOtrRm+i+5LjQufvhsLomgu57fMoT36cbT2iwKk1yHsPJesJdMjkWfcJkzxErUGP6FIWy+nLKGG9UVzblUjM0yFUj3tQLStI2+WvGY51yeiy266K/YBwhEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kfIOb9i6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48d146705b4so145508155e9.3
        for <stable@vger.kernel.org>; Fri, 29 May 2026 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1780050007; x=1780654807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gy1s+h/9sykmj9i9LJ1q2CWHRar8R4Mwrtm99ecVF4E=;
        b=kfIOb9i6Ce3o0mX0MOWBpMP7fSt6Sji+7ipODRR/7vMDobhrH2xnkhLseTVzaA4V+f
         1f7kVh45FoA6FMdMBpWzRY6eCyyjjnlcJs1IHqhWLBrXNgHZ1CqIJS+TZbBEn1rRq03D
         oFZEhcGDVX+AQDl7hoheiO9N/+/GmJ9IbTrXXRQnzWYPIQNZ0c1Z73NLuDcJqVphYpMh
         Ipl8IKMIEwW4lznIfrtmkkfh6YDeXpHOWhmcqbVcQg7gHCGGKFSbW/133m1ZYU4BDnPG
         v/9nJvSx51pDbkURtenOFw3cHyQb5AWprcuqDfHErY7tsY0JAtiTiAYcTquTLohwpS8l
         cIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780050007; x=1780654807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gy1s+h/9sykmj9i9LJ1q2CWHRar8R4Mwrtm99ecVF4E=;
        b=nHQ3pvzLSTor+WrflPYlRmeWsImzBjY8D19gQQungyWlsEMdUwdsNWeaoMHRnoLFsr
         glblQee8NQBPCSbNslp4gCzk3SWPQGMXF1lJWCqMQkBp5Ra6239UbrtyM8LwXPkYTDxY
         TuJjqgAWUoZR+M27DfgrJak+nd2ueNNmK2qIBBkfMEpqZHhEZ9utKRIPSwSY5LcRBg+L
         vvRWuW1NmdGIJ3JnQ0JTUlB9ggRyqbpzhideF3OfSiFOmODhGlrMFOfXw5ri7x9gB9cm
         6sObDLVCfBqExurmaHVBp4AJe4OdiMjuAbyeOu/mj3blm6gfC2EhHD2W0ILx9sqreulf
         5NrA==
X-Forwarded-Encrypted: i=1; AFNElJ/T9MJxCaCrsvSlr6heVIFJRnHXLNOuFLlrMFGGXWh7Cge5mFRsej7Ye5y1zy0sKuCAKvzjAms=@vger.kernel.org
X-Gm-Message-State: AOJu0YykSDGOaRJWymLlkODJhFgjJqHMfNVh9HWCFtBBPa0SzTUFiqKR
	V5+1IfbEby5m1GKCE85gMi1hLQsELwzVmtDtJev1lcxOSXbh3CQIRZM=
X-Gm-Gg: Acq92OEpDhXvanYzbvzXAy87SMakFxsxtm8IAjBF76aYeo+NihoBzD+vNwlSROeuxTS
	NJMu6csJrxEPn186JrT87uxsS/EM+eP295OxTugj6xUB6yIMFlWSVMY8qN7zT+bdzeLkv9cwESY
	voJqQqRsGA7bVwxRRzwY67vmnUAlpn6iL24ufKjg1xvdimUguol/54RCcb6L8p8uAlTrC3sHVWh
	qBe6g0TUq8VEgW6aDUoISbEGqUBARkPGZCooj2vb422pfPX+TqZ3xH4nw3j8d7lZh+I1mjlrnt4
	ZonLzjwuT7vB5l8zP4Fcga26SZjWjLJ+W8OyFwTe5EgK73CCbh4KgjYV4zZlXgdfuVBEchU9tFl
	QIcDHlnpYq6I6DUAKyQO0FEU6FY0ZqNjM6ENjFLWB4bZXZHYMhB2A/tHzWJsLEPhw+xKeKHrpul
	yCM/Ccf4ZvZQga52VtlMQNi5D4CobZJuNiw/n1vJ1ZfvXX8s2rJ73ODv6j1F9fwqyKbyo2yEGV7
	D+thYZWpUvk8A==
X-Received: by 2002:a05:600c:1605:b0:490:50c5:8153 with SMTP id 5b1f17b1804b1-4909c0915a7mr27933515e9.2.1780050006496;
        Fri, 29 May 2026 03:20:06 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4ac5.dip0.t-ipconnect.de. [91.43.74.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909ca6575csm57437315e9.4.2026.05.29.03.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 03:20:06 -0700 (PDT)
Message-ID: <8e0b1caf-0fda-485a-9d06-529ba18ea79f@googlemail.com>
Date: Fri, 29 May 2026 12:20:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/186] 6.6.142-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260528194928.941004471@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-256590-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[peters-netzplatz.de:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: 43573600C9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 28.05.2026 um 21:48 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.142 release.
> There are 186 patches in this series, all will be posted as a response
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

