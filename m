Return-Path: <stable+bounces-219654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EpvFLAbn2kzZAQAu9opvQ
	(envelope-from <stable+bounces-219654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:56:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B8219A13B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 713D43060B21
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667643DA7C6;
	Wed, 25 Feb 2026 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cfEwiare"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8AE3D9050
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033919; cv=none; b=SnHBpgwlqiaXeAWU+FY+ZRrRJsw1XjdrmqsoXR7nyFyCpSOfihXPVsoVgPWx2ve2LmUuOwL4WKwFA+lRrBEFLo/IHp+uWzqmrBirmfWBO2DN+PfChmV+6cp6BtuSuU9dFHnZo1f4pWwvYFklHOeCUI+VSYisdzaurmg7yfY8IRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033919; c=relaxed/simple;
	bh=lwA1dAaZa5R/4FI3CQlKfYG8RBjmQqFghd6x3qOPE3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjrUTu+ivBvX8iRga5O2CeP5lhYLe3Hfj6Ss72cK5JcOKznQcKCyFroQ/ZeXnEhfZs39u9Y/wPOp2pt6k1cwjc5uKAAJ4EQrPT/zDCbda+9btU6/ZAzLtP8z0Zc2Fm8jBa5NCmPzaRW3XqbKsZvS6UOvTdtQLFoXdLifeVQctHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cfEwiare; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43991064db8so661911f8f.2
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 07:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772033916; x=1772638716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R47EnWn3QFF72N0L20NhKvIfYZosIMpJW4OqVso6fwc=;
        b=cfEwiarev+T/E0LPVmpTaKWm7ET+AGsdLrDK8A8IvYkQGbSX/mzjFkbwWzfWy+v6Lk
         KFOx4KQLLyYXq3MtN2fkkgUS8fp/vplAPpcbKBWl7Olv3H0bjXYVTwN+Cb8PnRqGGCUn
         hgVGY5dZtWsgRL1e+dstKWjJrvAuLzszkF3cQIBBwcJ5jRV6BCJ8cqnq5Uc3T2akhntY
         zO3j+kKoxs70CfneDis7TPG60FpeaQY8JRI2flbdwbwoMsdZOb+czCwiYf6v0vak6Btz
         63azj1cGOnDq3cvnWn4IzFQ3pM+BJzyAM+gEW1hTdSSNfofxvPPy0d9ujAHN0cpqC12o
         1mCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772033916; x=1772638716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R47EnWn3QFF72N0L20NhKvIfYZosIMpJW4OqVso6fwc=;
        b=lUFGwOw29QbjdgZbF1Ps4Z7dSrq6KTF95wWJE7UsgFqyxeu7PgRPASnpZTXIfCfvFR
         17qqKMhGqUZCdQn/imGnLYtTlhT8B6f9cRViyEC/r2FHdn2JfeBVusxNetbWnZQwfAdN
         OLg4BqGRq9rtp1efH1GthBACLtNpWuXlUo2wNYihVkI/fhmQp/jD2m8cVXt3kvLrazXv
         pvqOiFrjNTQ5xoeKArxau+BL4QFzjiYu05GNcPs+QtMMhvRhSig06jrKDOhQdBbik8KC
         suNzP6YN+C2fAlwmrWbxofZQGHjy9C/B4qQs1aWdV8S4BHNeV1F8dVC6YO4bH04ariEo
         35MA==
X-Forwarded-Encrypted: i=1; AJvYcCV9VNXh9lA5LiPFFPO6B+xWUE7dExr1WBe8BIsHfZjbX5NnxVk8C03cBVVugsuMcPy1fwsPr/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWKaJpcLLh3JQqx3LZjNJYH/WdL6m/ZAZuLTcC5jnRSgZn2A0
	nEZZJcYMDAzCz3QSN6Mibci3FBoJOgaI7L0rX9j5M7b3q3gQWXEQwVI=
X-Gm-Gg: ATEYQzzSFUyNS6hRrTW5QvKODr2OcN8sh1p1ShLCEkhe4die5iDdzGRbrpJ2NFd14f+
	5lyYspJWjrll5slXBVPXOtHNkQqn4iO3RGdwN2K/9326SPwJIhFGXYekTWEQMcbC2wk2eJfUTTd
	PLiqsfngkEogCkaIyDJl9psJjsurLF7RFufZNUZ6+xQ6mI/1ljJEHrKocSWT5OPasd4JpB3aM72
	MnahpgbiClEEVgAEoyjhao6Gb0z0V+Io7N0PuQKUnTtf3si74pytukWTl1H6BYeRRYznIAA0XbD
	pyH45qlsqUGjuNIEFSfn+ErVUzwbgoizrvsnxelTdP9pvLINVsUbX95NCNPBW6uCgIHidumNgZm
	9AnPDiOUoaeGJtE83kgQy4JvC0NRncIpI3SQODwIcRRfRPerEpBmRmLdD149nWvQsXRovYzdbas
	MOu4dEae1zsK6Axj14l0uxWkXB55R9NyKVDOs6Jcw9uIpMRAT6N/e+zKk+UvS55UvQPcwNPm15H
	Q0=
X-Received: by 2002:a05:6000:2410:b0:439:9015:a96c with SMTP id ffacd0b85a97d-4399015ab62mr4568471f8f.35.1772033916099;
        Wed, 25 Feb 2026 07:38:36 -0800 (PST)
Received: from [192.168.1.3] (p5b2b47ea.dip0.t-ipconnect.de. [91.43.71.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff6dsm36540108f8f.25.2026.02.25.07.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 07:38:35 -0800 (PST)
Message-ID: <1f1bbab1-b67c-4a5d-a88b-2c9b9f0970a2@googlemail.com>
Date: Wed, 25 Feb 2026 16:38:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 000/781] 6.19.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260225012359.695468795@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219654-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailvelope.com:url,peters-netzplatz.de:url,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: C2B8219A13B
X-Rspamd-Action: no action

Am 25.02.2026 um 02:11 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.19.4 release.
> There are 781 patches in this series, all will be posted as a response
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

