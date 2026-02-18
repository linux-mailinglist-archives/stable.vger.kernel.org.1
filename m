Return-Path: <stable+bounces-217207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECcLE8ArlWkwMgIAu9opvQ
	(envelope-from <stable+bounces-217207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 04:02:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B48152C63
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 04:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26652303A4B7
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 03:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1912874E0;
	Wed, 18 Feb 2026 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gUXhyE1Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74519DF4F
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 03:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771383739; cv=none; b=POyl7p9F3Xv61fzjMWUdtEz/q+nqm3ioqYrG/Pavx9ZFJFj0yT5rJ3MJQoIaLBt8T1BHl4lbkHfV44hjjHxj8wsnOflE5HCcAeu+OnTLmVpVHbtSTvy5V/YNpfogyAdayO5ooMuGUpvl4XtEFoqkJT0l/slmnx8i5LnAiyo4Uvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771383739; c=relaxed/simple;
	bh=iabCyX/FazQvASx9cQ/P/1vUPgbITwBZP8883+/bhRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbN4shJxjbAsWugWKWBpP9eVVY7tuEzIE4pChm92Xie9KjjvTS7gPOjqezGZus/cPhTrEF+cPDB26nPWDzrIIJo1gUVd6tloU3VVSm4Ag3k6vi5CiIAhteeNRhioAFXmoqkH89sXHGVV+sEgCbTIoOAWEqSxHpUvJMn7wFNL0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gUXhyE1Z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4833115090dso43553325e9.3
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 19:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1771383736; x=1771988536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufKmFUfyYC4SwG+YM6+9bsmvByn4DxRB3ES5FQ8xo94=;
        b=gUXhyE1Zwwu2e96JOwWoWOHIztgPqAI+yiZ30xfbeHL+7NQvTJpkx0ZcioyDQiKRb2
         ghdmKIe6mHAZgKv8lppKv1s40MyoWqoQDH1FCub3uGsWPIizTjwmsbSCElCLnrBEpNU0
         tfQIeWoh9YE3RPoxmbsjuXoXI+ak4YeGj+iL+NW2FjyeH3mDha50tpZRc4YY3lCFIcom
         YDLb8l+h3FQnPEGg20toZmfQomqarFJYwZCoLc5PBGavhM2dY3TDeoRzk6kL38B1dqvj
         iG1ODu5GHCxPKoMWv73F02NGxHSuKAGOb7CR5XJL0DleIt8EWkAjT51/5Wu8sAcpMt/4
         951A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771383736; x=1771988536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufKmFUfyYC4SwG+YM6+9bsmvByn4DxRB3ES5FQ8xo94=;
        b=nG/+YTiv4IhiPtfSDn/mUkn9DuB6p7irC10UvSz88MdC19Eai52922ceRROHoS0mg6
         R5tc7C2G7MePmXF1o296bT/GlCUNuq3mW6b0efRSbIr/4NZyFXfZWeYOXuItPDrt6Q5D
         cXsYIUKp9UvZiAMLUpayb5FfPIh6KTZkTZHiheHQQ+rdnczpsKgM52lc8h3Rc7UXBDi4
         1xRECuuheFt67EiH5eSZrJxDvHoT1sT41lt/xJ0XCT7CFZ4rJh9axm8KUcE81lOV7DHZ
         KdT5RqvohZHAb8VXEP0udXW155oRhEGhIxuzQwuPTvnYV65f5l0sqqZod9d1Q60K76sZ
         iHyA==
X-Forwarded-Encrypted: i=1; AJvYcCUiaUgrybeI4ePIg2x6DQL/TM2bGcymb+jnC9V21m4wNXjbysLlkXCUdliNqsSkejlSqecsLcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBntqFQ9VLRHb5gwRL91G98Pja/1P+XjEllYkjLSGOJb0dEqWv
	bAa0EKC9qjT/47hrJeLWnEUOSU+1A35CIXIg9WeD2kBlEVCBRDaYvUM=
X-Gm-Gg: AZuq6aK+qMWv+JubJb/zAJMym9daE3G5ZHxmVDSSSbPHd9wixFcUjHo32XccHsOAcuz
	U9Ofp9REQ1E8M3BcqgZYMefpkxIFGHVhcJSDrRfa3LVnVbO0wO9vwQ74G6eIZDM2ji/Cg67fBj5
	xmcpD74SdZEJJqnsG4sQDf//SWQgN44Txum3w88aFBhnh+fXqXapxGMGcX7Yvj4blix4R7q7QS4
	0AnWGcK32PwcOSrbWFVZpSkw7A4Gvl9KxqmyX3WaKkKFGUaxNwRoIIwPGjPnSJWWwNvJqumPuzT
	8+CiONKT2G/hroFOdpzLTlq2qlQdz5AGROt3DO11MiiYEJFWOcAjHJafXWevoWCG11EkdgtsvYc
	yoKeUQgL5mHrQkl4AhFLgprmyZknq0D7pu9pCDUkA5glOgLMsi+uKlpy7bleSWVNil2BjTUvuli
	K0rk9vZq73W4Xij7QnuIIr+7B3ByniigtQq3iq4iZOOosIIBTjHi6KJJdA3tppho1jQI5H7NNIO
	TQ=
X-Received: by 2002:a05:600c:6992:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-48398a4978cmr6455245e9.8.1771383735812;
        Tue, 17 Feb 2026 19:02:15 -0800 (PST)
Received: from [192.168.1.3] (p5b0574ca.dip0.t-ipconnect.de. [91.5.116.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4afsm984807165e9.11.2026.02.17.19.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 19:02:15 -0800 (PST)
Message-ID: <c36c9e46-37ae-4665-a062-c5a5f85421ac@googlemail.com>
Date: Wed, 18 Feb 2026 04:02:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/42] 6.12.74-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260217200005.998240758@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260217200005.998240758@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217207-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: B6B48152C63
X-Rspamd-Action: no action

Am 17.02.2026 um 21:31 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.74 release.
> There are 42 patches in this series, all will be posted as a response
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

