Return-Path: <stable+bounces-235313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAqLFnlE12ksMAgAu9opvQ
	(envelope-from <stable+bounces-235313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:17:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE72D3C6835
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 147A63008C1D
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 06:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE9D2F745D;
	Thu,  9 Apr 2026 06:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="i8XRCZam"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9402E06E6
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 06:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775715446; cv=none; b=HbZeWIE3SIJAJLu7HlJTI6vhoyem6CBNY8VAmpkWVS9+0lTQp6aIpk5RruUuYNibNO0Llo4/rYwF6d42Vl4egV1/aD2Sjt25W7XRJ3K5oY2/Du++Hxjnzq4EybYwIBDNL1YBEIHJ9jCbTAwhgsgxTtz84bXgqKIdG6sDIMR3qD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775715446; c=relaxed/simple;
	bh=dQforEOF7BqSqgvvT++yGuJY5Es/NyuByAsqgve/RdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCv2T8dLJCJUrryQXy4mCYW03Qj2NFDtBCBhBxmNqYncBogd6DunBdxD1qIbT9dMkU/VImq8ywvxKK5e6SvONjKyjfdQJG1BlyeaRQ8Lhicuu4lUTLJgIjzBd6b+0KjN5iQxe6F75cfs8qzQNsKSZ95DSTQGcMSlr6ai3B+eTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=i8XRCZam; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488c21c636dso2520355e9.2
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 23:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1775715444; x=1776320244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2hQrVv+DhlOI7y2hd6S7WfKXBRz+eTVlysGDBhkavk=;
        b=i8XRCZamRuUe4EyI6e/Izt0QIuPd7JrjwIlEj7DzcZYi1Pv3SB90YETHJu9XJk2uQJ
         Nx6aefbF+h/1A45TiGbnwrDymRm04d/KEHcvD6qrxhmcX2MGqvWp73ES/669MBrmqh/a
         EfuHD7PlgxVWqCmUCevJbWbOq3touYsYfy1TYPzPQsNYdUapiBU+UmoOD6rle+qjPEVq
         3X4mVrkcI27keLo9EesQa1fEy6U9diE12iJ7Kq+YcZRrRitNyG7AxYGwN00y/Bwjkt+1
         RyGItrzl7K5tguQMywFqAlY7RhA94vbQeky7KmUFnF/jTATv5y/64JxRqKOsDgQsMsbZ
         EG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775715444; x=1776320244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2hQrVv+DhlOI7y2hd6S7WfKXBRz+eTVlysGDBhkavk=;
        b=oCklN8/uW8uU4sUOS8seHvwVqmj+PBN46mPgYyUKzZJs4bZR0TfV6qLbKHS3UZ/fXU
         vZxnyIBTud/c/eNGnojyK3+aQ+XgzfnpBZGiwj7hS626v63BZeLzWjLk2EBlk4IWhbV/
         LibUDuzU+73f0QeA9FliSs1CdzwzqbAsxx45i5+8PV2aU2h0ge1B8cLXIQ94Sv9C1Wtj
         WdjShhpv2vT73a+ts5fxHA4/AMOWbmR5GrYZ0q2FurmH6pwYJH72YQtvwYEIohBgnfgi
         0dVw+ZsGKZ1UwgWwX1WASlpttQgZJhcBy2XtFhOuNfaQw1kWsz+JK50hwZ6d3hO5HvlL
         u0VA==
X-Forwarded-Encrypted: i=1; AJvYcCWxZYpFX++k4A2lbE4xOQAsUJH9M/iOnIiCEjCOEy4hY6aLyUUrHuTYE1Nb+Ri4k0nFWHLAjvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzccUHKF6aCqItaskg1RIQ8ZPoPbc9ibSYAzZueN5481texCvIc
	i8MUceWq1vHA8tLPbX/EVaUY4OT277NFj4mi4lsm4CwG5J83FWn4748=
X-Gm-Gg: AeBDieu8GWnfqcO8zE506kus34RElZIfHs1a0+onHUZu2UECUiHSx0IN1uBVq6wL1aA
	VPokALrr6UjgyNP8F2OnX9i3JhTq6x14WMAs0m54zpbArgybIku4JbkWpU4g/6kJPb24M/aU+9M
	XmS+ZwhjiFzO/OU53GnlhLDYCRMJh4TOQkUqTqp0AUn/4KTiF0yEG36s99FXw4826RUKXGwqJeX
	0KLHXCl5C2oy+OLFiTTp2n0mMHLLfExCbnlE+8x1I+h78mrFnYoUDKXBZeeRxHv9gMQ8e3KaG0y
	dUQLkHusmwFeMslUUu1phq9vxrYqfdz/4MOXoWAOK8FNdHuyOMvxCBKiS4QRtYgLvXHsadlVDFV
	1Y351dMIY6+CT9WZei4Go8mqBhMKRmxKjHilUiINY1XjD5PGZxuSiKCDslYWtRFwRJaRWyhmnnw
	KfLZIFMMUMU+mGWnVOR/rOeMfOJuGoOPrIsRKdY23kKatc42ztVC9TVyQmtPWJHB0zD72KX9/OF
	fC25tt76+HLvg==
X-Received: by 2002:a05:600c:3549:b0:471:700:f281 with SMTP id 5b1f17b1804b1-488997d5e5bmr311286595e9.25.1775715443585;
        Wed, 08 Apr 2026 23:17:23 -0700 (PDT)
Received: from [192.168.1.3] (p5b057c8b.dip0.t-ipconnect.de. [91.5.124.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd1d171dsm23066475e9.5.2026.04.08.23.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 23:17:23 -0700 (PDT)
Message-ID: <da824d54-1dfe-4938-b015-7f0d3eae9c4a@googlemail.com>
Date: Thu, 9 Apr 2026 08:17:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/312] 6.1.168-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260408175933.715315542@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235313-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Queue-Id: EE72D3C6835
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 08.04.2026 um 19:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.168 release.
> There are 312 patches in this series, all will be posted as a response
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

