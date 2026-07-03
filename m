Return-Path: <stable+bounces-271787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FddnGvzCR2qMewAAu9opvQ
	(envelope-from <stable+bounces-271787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:11:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5916670346F
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:11:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=googlemail.com header.s=20251104 header.b=VwUYJxVm;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271787-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271787-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1923730ABCE9
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 13:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8DA3EDACC;
	Fri,  3 Jul 2026 13:49:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A57F3EC2CD
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 13:49:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086544; cv=none; b=c/L2PPYI7cABSeILNxAqxwK/4e5c18JDC+CPbZWyM8FH/Xi7tiw4vxSae6LNvBogCf2T6eGszeNJsY7PPe50DuPrw5wvkmJkXKEj/dzrgxKy/uB/aZRFLZuTKhG81cU/F4aDoSwoTTquGcc+9+VGbXs+SabOtt5qWAxAkbrSFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086544; c=relaxed/simple;
	bh=DGx4vEaPXlRsV0Jufda/RTMpdGu8s+ujTJH63UEZenU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r936IXRZvP+qXPX+GDkLuqlNNszwVeLX+eT1jSwQfu7JHyn6KdK8lveMMFcxakplPDKkZIf27kDDSBzZiN9h1kGYDr8Y5YJj2HKx6mlzY4j1/C+foTuzbAMPBtYiVpp1+tM8jqVHqaaZIcZXFjjS9ckPmEfcb1SGZTeLku9pFRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VwUYJxVm; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so4224525e9.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783086541; x=1783691341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EHqQvNTeoc/2FSNLhGlqtEhHUBfU/vNEgSrulvmASEE=;
        b=VwUYJxVm2IJ+ZNHwtf8nsxJe5Mb8nPdVX+AHsv8eqQ+5Kn1qvo06PHZ7iZKjI+OhWc
         CXef/Qy5URJ2emxSr29uLA+EK6PXg2J/mIOJaGz7fWEcnIUAMu68QkkhDIM6SXvU9MW7
         DIsByokJ/oiJNqPaWrKRLTFErSeOsZsiHcCJyPT1sOzDW9rdmC2Y3O8CFUT+F79ME7HD
         j5pUT5z2QgYB5JVbhq3QmTYxbEp93zj185WFDZURfr57G1twZlhWJ26zeZG0fNw1lGZO
         3TT9UGh0BfkvfnE5NOHGp+PzAZNetb7xJA9++uegQq7hHGPbbamEt1YF9s58/x6hGGa5
         8yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086541; x=1783691341;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EHqQvNTeoc/2FSNLhGlqtEhHUBfU/vNEgSrulvmASEE=;
        b=gOtYioUzZW+fWMBsds9OM6ex/iMET74DDzfEIed80gw//w+cs/zrbFcV4bWnMpeMCF
         EVQAaQuA8HlBVNkQrGOAca2gumAPp9m0ee8TKh818sHsykPavrput6jn7R9uWljoqKhH
         0k77b9X+m6fDz7yf/kewwP8cSz5OVENeOcUJsSa34YUhk9IyaV3t71ID8DQ+ZrHuTofI
         /rXt+6Ey1/wXwBjCF0YaCX0XjCHa2JGY2b6rxb7bjNsqNFWjIQzsXfY0YmDJT70yAoHn
         2m5j79O7zI5A3kDB3e6qkiuJZLJU5mHOzAZDPcyaVmgiZ4OYviZ2tnkbRPltbKxBbvLp
         LERg==
X-Forwarded-Encrypted: i=1; AFNElJ+jnjmZlhpP005ANygWq5E+7vsbkX6drOB7wsAZ37cBfbzDH+cgiC3EkOn0wdeA0UXzFpfhtNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1P4VBH8OUFECgv5KClM/c/yd4KdwBZrtmZpa4rpDGpwRU9vGR
	zoECpTFmV8OQGADt4l4lgl5GnQnqab2Oy9o/wvfpCP18kP/Nxb4G5KE=
X-Gm-Gg: AfdE7ckCLTQjpfDPelRMoa8qh7pLGyvK8bhbzbboAk6Mcl2dh67Uin9idl1iPKnTLYC
	lXlQ20IvTnXlupqyghbBSQYzKaZTgpNOG5tosfs50yX3IULDZHp7i5BB1VH3nKKlYpXkg86XjLp
	vjVdHOO9FYnN7Q1hxWCu77FIWBTMySsugR4+MdiuxGjtCeFQnxSq+oXxeI02CiTi9qJuCGphadr
	+zSsJX7ZKoxmvJ2jPZLI/hezssQwN5ZORldN5n41aUSnZw0ajxqhTDt3nKMOpj4K/kgBcAoRHSb
	0KTPMkxpJZ8UqfOUKEw5y9R195ZaPZRBnvMsEok8TzJ7IWznArNxoXFBJNPyvS6kS9kgtjqtGwj
	CC5+vkOymzj+FKEquC7rJ9VYb3OMIftGO6Zu/MT+TWcwCfZTQEqa4xJVw3XYBPrS24SiMpZOIeV
	Ee3ttrIzCZf8N6kxqogfKZv15Ny7ehShTF8FBgD0q0xnkhwExGXx7h/ZIvQF1gP0s=
X-Received: by 2002:a05:600d:15a:10b0:493:b92d:9166 with SMTP id 5b1f17b1804b1-493c3cdb264mr104350135e9.12.1783086541264;
        Fri, 03 Jul 2026 06:49:01 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b474a.dip0.t-ipconnect.de. [91.43.71.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdb62d3sm58976105e9.8.2026.07.03.06.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 06:49:00 -0700 (PDT)
Message-ID: <5e332084-340e-4450-b416-ba9be05da503@googlemail.com>
Date: Fri, 3 Jul 2026 15:49:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/204] 6.12.95-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260703072825.068705122@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260703072825.068705122@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-271787-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailvelope.com:url,googlemail.com:mid,googlemail.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,peters-netzplatz.de:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5916670346F

Am 03.07.2026 um 09:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.95 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or 
regressions found.

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

