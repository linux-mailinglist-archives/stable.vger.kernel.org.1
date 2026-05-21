Return-Path: <stable+bounces-253640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J/UJ+J1D2pEMgYAu9opvQ
	(envelope-from <stable+bounces-253640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 23:15:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE15E5AC11D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 23:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12F09302A537
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 21:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F2D394463;
	Thu, 21 May 2026 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hEgVo4h3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505432C92D
	for <stable@vger.kernel.org>; Thu, 21 May 2026 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779398033; cv=none; b=TMsWVGBH/rKaegjKkc492uOyplHVBzS9ZOwLoCLEkEuXr+MW94/R655Vd45mdLpyMVLNlObMAgVw+k1asfXgB9PvMoGTl5VRnOPvy1QLjyETlKi4ysxKTJ4XFzDbTxq9Yk9l1DoPk1sVh+ezUfDoVedDi1pVu2k176/fYcG7pKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779398033; c=relaxed/simple;
	bh=FKbR2oAGHLXhTjrwaBOGgE9yH95Bw7MiIRRtQf3R9sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AguRxPzpaMjjL1LbsXhvdPQ3du2/U1eBrU0ynZg9d5nR0p85RpblUucy38xT0caGib4Uw6yuCDSAk7cwO74ckLD2CIU4JYHAFfGP5AyCB1j/kZa6jFUUrKsSyb6779QqviidHQluHGybrbbIDgmzBjlznJQGELX/KGZWqI0cQPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hEgVo4h3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso48850015e9.2
        for <stable@vger.kernel.org>; Thu, 21 May 2026 14:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1779398030; x=1780002830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9x4Q9BYj16KKtLOYDLA0JMcsK0w7ejKE2qpPDsfxfXA=;
        b=hEgVo4h35GOWYnNebq0U6BpIGdG7PJieZ1k7i74PuW9O8fNavOOpuGACEAkwRfNQF1
         MKq7ONcVVNt4UT9WxN9P277Yvky0M70/25xkrfpeZXTK+rcP2svXw1WYSOyw/Ns6dkyK
         hjT+5UxWGkNBum6ihUJqKpL6YDU7AeVkpjcVyKTqEbO4Z0rKAAGIcWERkEnQX8ctMkBh
         tpCGrSSEmw22VEhW/hkjWvfOoZC2CxPeWAx4Kd5EBoL8kd2rfKrmM+ib/faE145h2CbP
         0dOzQ7Z/rEzdYB5qKLEb+sM0VdYJbujVK6FSObgQO/0Mvpcw62c85y3ql1aPE0kLt0Qw
         Zu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779398030; x=1780002830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9x4Q9BYj16KKtLOYDLA0JMcsK0w7ejKE2qpPDsfxfXA=;
        b=jj4iiUxXFvb9VvjkUfTKxD4WqdAVK3RDu0wiAWaiHbRLM7rLMhRD7acdESNbhlqAnx
         ldrQOLUHzUOcU4z8y8PgC2d5NUEnyyo1+MwmJGssA/C/jfo//Ryn4NgsvJzWy5YGn22f
         4KU4IlcQfXBdRfUHyfM+CBGgoAe/brIXc9929KIWoJy8xEJiPoaflT1sfeIi+ph0D5Jr
         YA6moiUS2HZ84AvHaI7dcdr+90GkNqrrNxrjB+74AFT+aWafQyhdjEubsM/O/v9WCrT6
         dRiAbl7rTVNphVrZizvujxWbZv2Js4k47Vj64F3HbqoN5IpNdzWj5klcoxWvopQCS2Ry
         5S3Q==
X-Gm-Message-State: AOJu0Yzqndv4j4AYazZ/HrZmXrtSpMMaOHTASyHxHAcwCp2zI5UtrTwt
	nDNyQu30Rt77webIXJLMGh7JJedpR97ePPDPtGQudiCZ2ATQEz+u7xY=
X-Gm-Gg: Acq92OH6BealX46p7CWHXUgUHZELVJ9aWvdluYelYot/n0/3eXfs6KBoLrY4KX45OQE
	jxwc94eEo7kWucB84fuKwFluMU6OOiHkCurNWX1k8Eb05ZOT4aLdlLvULkiVGryNN1AbsEs5d1n
	xqdZzrIlN/i/p4V5pFVVTg5xDjOGLlZJYVzK8Fr+BkiKPXBWPz3Z54XQ321rjk272wljd0AwG3k
	A+VEfGMedRYAaT20Q6HY5HQBSEZMV9orLojhqx/OLNEfb+tvFo5T5pbUEuW8bNma4kNgg0wyFHQ
	492CkZbDDluuCSIzesVpMr+ysvcXe/AwAnw/5wPfIlDsRdhZI4UCjkguhbiNlVJGzsEcQjlQQLN
	llmn2Ueq0lmzTOVW5aaj8AKDId6IIuKt+7g7gwfCvs1mHpNy7JDOWdhji05xuBM1/a9HvBW+Dza
	K87PTkZ/i34xOSRE3KhVRNGtcpe7eo8U4TTbZ232ib3jQ4IzW3KFxO0PJ3EziOOiKThSo8T3zxA
	Gnph+sEQIMFHg==
X-Received: by 2002:a05:600c:4fc9:b0:490:3893:c71 with SMTP id 5b1f17b1804b1-4904248839emr5370295e9.5.1779398029819;
        Thu, 21 May 2026 14:13:49 -0700 (PDT)
Received: from [192.168.1.3] (p5b05786a.dip0.t-ipconnect.de. [91.5.120.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d3514esm99284585e9.3.2026.05.21.14.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 14:13:49 -0700 (PDT)
Message-ID: <1b10f085-9eaf-4291-bb00-7baaff61627d@googlemail.com>
Date: Thu, 21 May 2026 23:13:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 354/666] libbpf: Stringify errno in log messages in
 libbpf.c
To: Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Mykyta Yatsenko <yatsenko@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Salvatore Bonaccorso <carnil@debian.org>
References: <20260520162111.222830634@linuxfoundation.org>
 <20260520162118.906982302@linuxfoundation.org> <ag4vSWzIUCsRlpKv@eldamar.lan>
 <20260521-libbpf-stringify-drop-sashal@kernel.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260521-libbpf-stringify-drop-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253640-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: EE15E5AC11D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sasha,

Am 21.05.2026 um 14:55 schrieb Sasha Levin:
> On Thu, May 21, 2026 at 12:01:45AM +0200, Salvatore Bonaccorso wrote:
>> This commit caused a build failure while testing 6.12.91-rc1 to
>> prepare it for Debian:
>> [...]
>> libbpf.c:1538:76: error: implicit declaration of function 'errstr';
>> did you mean 'strstr'? [-Werror=implicit-function-declaration]
> 
> Dropped from the 6.12 queue along with its two dep-of companions:
> 
>    - libbpf: Stringify errno in log messages in libbpf.c
>    - libbpf: Prevent double close and leak of btf objects
>    - libbpf: Change log level of btf loading error message
> 
> The errstr() helper would need a larger libbpf refactor (c68b6fdc3600
> and its prerequisites) to come along, which doesn't apply cleanly.
> Thanks for the report.
> 
> --
> Thanks,
> Sasha


I get the same build error. I tried, as you suggested, to revert

2e81d08459c32c57d037ad160e755bcfe6d5003b (libbpf: Stringify errno in log messages in libbpf.c)
5c758117c381172ccb60fe9a0313705794ccdce2 (libbpf: Prevent double close and leak of btf objects)
a8061c6ed62cc94a5e19f0e31d03d23ff65d638a (libbpf: Change log level of btf loading error message)

but no matter how I do the revert, I get a conflict and I can't figure out how to resolve that.

Will wait to retest an -rc2 once it's pushed out...

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

