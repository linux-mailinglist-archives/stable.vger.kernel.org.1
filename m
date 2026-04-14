Return-Path: <stable+bounces-237767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCQ6Ff4D3mkQmQkAu9opvQ
	(envelope-from <stable+bounces-237767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:08:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E813F7A96
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7635305EA87
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1A43BA248;
	Tue, 14 Apr 2026 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XhJpCGTB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60B3A5457
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157591; cv=none; b=BcwHpvVNl1Dvtop/i2uiNEDHsfZJgqrE59Xot1AU8KSg5FCzharNynfYeekqqRwQVGXf7FAbxmRmIhP3UufCNc/WA91CEno6VkXs+3bF2km8lGQ9kyzWdpHlU+5ln45fDKM96dY+lHWOw/wlEYtH98Q5djiUlRdasXbSnn5mlB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157591; c=relaxed/simple;
	bh=Q5J0zlhfhkrzNkUstl27167is2h5vfjGuXbjcpI33rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5TJPoA6zm5E4KAB+KgiI8XsoA7yvhfHNO3CSOZdLVLVO8clAXbz5MKR03MYSAB+qrYxwnWyIlL7N+YG55PUu13/ZiiX+B99pgOM6tK9p5IEC5Y+Ma6m3tVaS4nnHDBXp8mcykrw4wIxNTTdNwlJZFh2+RcpHgr5Kgy0stHa35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=XhJpCGTB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a29e6110so57887615e9.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 02:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1776157588; x=1776762388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0eplFA0Em8ZfHMeUXX0Tyv2xByYPMHNk2Benk7DSSSo=;
        b=XhJpCGTBrc9mIn8sKE+TP6CDojQbxhZPKd6wNQUWB3MfmcBnNyw9XcBNeGHcyB6api
         qz/4yChpgQjxgAZ9baWHxOxkayX8+Zr2rarscyAdwjXLtG3AKTNBel9g92zMl08Y0NTl
         +KEjNJDKeO7jCvcWaax/B4chHp/9oIbs4nDcJD0AhqKJtirEjBt9OMIlkv7SX7usWeXo
         xik6NX8S8M9oNrTfNy4Fl8AJQ/QDuLrAjboXpFmYZk17QTKK9BUgFXfdXApNuL/DjbBl
         AjjORYjsZcLzgb+NGPxA+K1GOfdvZyrm32iU58q/C9MOT2wliF9sfD3Q03Ak+wryL4kl
         AcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157588; x=1776762388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eplFA0Em8ZfHMeUXX0Tyv2xByYPMHNk2Benk7DSSSo=;
        b=bzufqpe5uwooc5KKjz3WvButztq2SsqvrPd5nBLBv6ycMv8ceyyt7vlj7xSAq69Gvj
         gtZPIyyS7AlAYr6McGfiQPdnFsJV4x5PKmF1dJCyVM8G7pED1TvC/KI/y1YFWJpvw+Lu
         xcqdSHhEiG6vAN4SKysyb/AONKWuO1HQc9iZVhpAMKytAoavYn1wHWV5LJkXMRHn17B+
         Q6bVTCfOvLc6nsN15ANT970PQ6MYeXAGXnWCWnjsfCCLcRj59kcolOwHjUN9VF/N5CSy
         Cmn7ItdoFTi1o9j/he+dMYNXGz6vGF1T5XX0byFhrMTyXxLQj9NJeUbb+RFA7YG6EVKe
         TAvw==
X-Forwarded-Encrypted: i=1; AFNElJ8TANqTy+1Xfy9EgmS2wccBukUCRw6e20/yoiwhV/ZjFfjkxwOhTO+QmnYbcuW/do4Y8uwRIH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDzANZEm29FOinlkNkvOW9clXzpbLSo1FXGT+t5LfMnC74KcpA
	ucLQGEKszcPnGXYFGwxE3OFnO/8gYDd/3BwR141w5lhQxYeOyGNDJfUcfDpZ
X-Gm-Gg: AeBDieuTJe4ZHnizCoXP1pZtewUA3tzmJ1tto/Xb0/ej3xNq1llbZM8qZL2f2+6+PC7
	DRZn6NACz/t1w2hieqT5Wgk1uaR1Bkq3qcAgKxpW3BWiOmGQ0k8f7lGun4eZmV1XKqgGhmy3reG
	JE2bayF4yuFW8HEBcUh+HhPfmriWPLdPaENddsO3zf34scwsdgC3qX44iRmnL1/QQ9TL68sfjNq
	bVzfZUdmP8ofDY6NEYCI1XgaTPHhGBpwGr4OD5VR4+gohyxcmKa7dQVKKIXK7kmupNDIg4gF9FU
	gNmLCT0+WWjgYkbGIqD0IohOfiJd8NJNIjZXmhhns2gBHIGMnvzXXVeP4sKI5DEpCyucRh+5aIV
	ql5uUzzAZrURU1KtZjUZXUMRi6gPGoG1IrtUl5yhMYFATrdj6GXGAA7x4pIEDQsCSLH2jcID4BL
	PuFxoxUVDHgKTn7QQqP4YFSlbI3SO8eca6SiYXMqQJPBJU/5msWlHqnCnUGXFUTvYe13/nTDL1z
	K7AqJD3aiOv+g==
X-Received: by 2002:a05:600c:a11c:b0:488:af14:f1da with SMTP id 5b1f17b1804b1-488d67f9a25mr164346855e9.7.1776157587980;
        Tue, 14 Apr 2026 02:06:27 -0700 (PDT)
Received: from [192.168.1.3] (p5b05757c.dip0.t-ipconnect.de. [91.5.117.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d70891sm123063205e9.2.2026.04.14.02.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:06:27 -0700 (PDT)
Message-ID: <fc073cc5-fde6-4601-b36e-4778202016ee@googlemail.com>
Date: Tue, 14 Apr 2026 11:06:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/55] 6.1.169-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260413155724.820472494@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260413155724.820472494@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237767-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid,mailvelope.com:url,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: A0E813F7A96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 13.04.2026 um 18:00 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.169 release.
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

