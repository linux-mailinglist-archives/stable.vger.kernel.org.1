Return-Path: <stable+bounces-214522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDBUOonRhGk45QMAu9opvQ
	(envelope-from <stable+bounces-214522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:21:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5010AF5D4D
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A430302A513
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257D530B513;
	Thu,  5 Feb 2026 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WMeoipy6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921042FB962
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311764; cv=none; b=XqIea7Y7lMRfZ93dGAIBOmQvCgGpFhxGmK4FZeo7VJMnHSZezGb/6aOHmAtYtEbwLSK6HVWdtS2Qu4CQWsL/CEfW9sJAJS+XgnWN8QV10it39VVd2AT9/iAZcyHeR4qj6aXutI+3Ui67oSLz4Vxbr+vwfdg6J2Zh5PKHuj0V4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311764; c=relaxed/simple;
	bh=Y9chVdlRm5dlGX9ll/yHkLGxWhe/sOAvh3c5XBl0KKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oz81r7ByxfjGUwe6wM6bIlc2D9/dh6WXhCxjshhxez8J9bQjfVhlkLm3Cn7nwDfWw+zBJWn2tMAnOniXPoMlbV4zZLoW0Oqma0ctSiIb9yWYQCctXFOr2G7ZOaD4VBCBuBl0P2BqqIjVJF0ldpnk0EN4Gn+yHFYdimSYH5911sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WMeoipy6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43284ed32a0so738923f8f.3
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 09:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1770311763; x=1770916563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VuTdoeIFEQQxdGJ/pGJTNfdx1P6qKodRDn3ipSVF6S0=;
        b=WMeoipy6o83GobBBr3y51K/1VDbnxpqiLJ6n+fDy7A2fWN73X3jVWGgq8tk7DE40lD
         e6dR1noDGN99ELqSdRNm5PXuMvcApKLtMptbpswurB8mIao9Tlp0VvTjy+NRje9B/KyC
         lYZAippopZdfYhmaO55OkYeFo4C1XHeJo4pL2RaX2EX9txb+NDevhUiMJwkuxPdFTmq9
         XrfqY/Dj6PBuEHmcu/vyj7ZukMeau5wVA9V2rH9PL1o94q86AksziGluI1pyicnSwGv/
         fkYHtsXa6G45QvIe2h+o5U5ZQF/DiGjxUT3cs+IYV3wINyqRyobSzwYCAK01X0O7IgZy
         XpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770311763; x=1770916563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VuTdoeIFEQQxdGJ/pGJTNfdx1P6qKodRDn3ipSVF6S0=;
        b=rqjmkPdBaoOgAjbMKXMLobrDR0IojVcsmvQh72XOCtsdnn4UKGeNealMLTsUMxtzQi
         Afp9VADB/ryDZKuvKNB0enCucx/B/quUSurL4UgCp+dU+A8Lw4TX60VZiSeK0+OeCEyI
         dmPcXyZH1ThHIxiM/icDTud1VxSUghaRc9o5f4UHrtLjH8rNkZ1zuyqKCqd8A7sl2wce
         3G4O0wUU+nMlQfb2114j6cqCM+gQ9pl4lHCZBb14nwVpSTzvvRHpYcDRgrjPg3nxa94m
         5nQRhYBOcPBhZySZIPMju/G9hiT8Kz0KWNJTvU5Qqp/TMe+k1mXvfY7MGXHlgR80K10P
         lywg==
X-Forwarded-Encrypted: i=1; AJvYcCXLgkYUKBHTJ/g8nNHRkwix3mWMJ4D/JpRMkBYKOLZ91Ww4HR2U61A+jeOslfH+lvuQ7dDHP6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhf+TQr63FlQgxLzQt8VB09UMtsX+EYyF94KOOAITadEI8E591
	F8vmaEem3ua0sYqxgIaXmGx6q0d4UND+TvtcswBhrkaQq5rFJu5hO2U=
X-Gm-Gg: AZuq6aL79ceWZFOFukSjZytGCab1WEWmKU0m/yJds2ZbWayP57PVjvwRbqIRqE9H9SP
	/gUDxLy5HIiuhGlHqZzqNqQ+oAxhbSHC0/EsmrR0LOMDbvRz5fqSrc2TYXfvgRxwNy+VHXNSQ5s
	WNJcD0m2oop4qz6LYRPdWQMYPZkrwMSrKeuyiuIGicgVDtnx7HRr1KzVQFSb3jvxDuUh9CItt10
	uS/DhbaBZ0gn5vL9tLI1djOwa/zMDF7vLw00vLBDAbu6+OUdTzRgRb0nd964wjcSGKWLdwBTawl
	kriBDWYwV0PeX838m9dF/kZOztK03sVfpXBw8pOk28tS2GyhwMWcPaKZDv+tjmSaCQu5JMMCk7B
	dmbJ8bPnOU/n2/V25UZbwS29YoIhZClQdwlrSNQxqb8Rf9Mmz+vvkry28Uew0BYHAmYZsMlnsPt
	v1nCWCS/wENcWR9KqI98Hh7EOd7JG6xZq4R2ojbOqDEcA7nBLu5Ls0huKUlzYi/xdnwzmxOfLlo
	g==
X-Received: by 2002:a05:6000:4211:b0:432:c05b:d8c7 with SMTP id ffacd0b85a97d-4361805955amr10788309f8f.49.1770311762606;
        Thu, 05 Feb 2026 09:16:02 -0800 (PST)
Received: from [192.168.1.3] (p5b2b46dc.dip0.t-ipconnect.de. [91.43.70.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e38ec5sm16378551f8f.14.2026.02.05.09.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 09:16:02 -0800 (PST)
Message-ID: <08291da9-90cd-4303-9250-905f5c7afbd0@googlemail.com>
Date: Thu, 5 Feb 2026 18:16:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/276] 6.1.162-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260205143450.492803005@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260205143450.492803005@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214522-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailvelope.com:url,peters-netzplatz.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: 5010AF5D4D
X-Rspamd-Action: no action

Am 05.02.2026 um 15:44 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.162 release.
> There are 276 patches in this series, all will be posted as a response
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

