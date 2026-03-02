Return-Path: <stable+bounces-222744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCeIF5UjpmlrLAAAu9opvQ
	(envelope-from <stable+bounces-222744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 00:56:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2421E6DE1
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 00:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C38B305DAB6
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 23:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76934359A83;
	Mon,  2 Mar 2026 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hyA0+O8C"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D1E282F05
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495760; cv=none; b=e2KwRFh4u2d9GcMkc0F8rr7p4v81CIV+29Uhb1gcFCXNFuWNKLkBX9g7D/JrzvGS40dAdDN6Akte4k/Fqovnd5fjDCbHyl2rpQbSIu8CEelRSxSl517yhN4R46pdbNMBZ5pt6k0pMAiFw8/dXQskWOgc5Gra70RKycTVIw/cDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495760; c=relaxed/simple;
	bh=FCf7Dkpi8cnZTKK+jHl+AKVpHFnuufe5M9zYul4nTBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nA8EduO5bOYb130QG9697uR/kk67rx5eoMdXpaDpSnLwTvDvh9M7oGEG0fpygv9ecED5v2y4Mq9CQ+vE1ghgXo28NViUYux8/4AcDyIHseqKrC+wbTUfQCfq41r7cjFcqf+51PYgdGopBGSlkl/k2Ju5rDtDwxxiTF6fDaGsBWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hyA0+O8C; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso43200195e9.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 15:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772495757; x=1773100557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++LctVCNk1Uw/H5oAQpRvLtdGEwkmdXKLvnmKGe4Ffg=;
        b=hyA0+O8CQBF9VuQ3c6w7pzptb0szjAqii6EIxHBg14vPn6RPIWQAQmuqM1L65eADdA
         qXyxxZjLq9q3ZVkL87QprCbpCl1Fcv6kMosVNMIM2G+/m0bpkGlxDYNN7t61aTfCOgvE
         uy8yFJoiNaG04x/jilNJHssHIDiEa+0+KPDHekIqCkzARipCbhgVVP4AYeTqnWDSMfpd
         wq0tSjSv1jC7blZl16p1uAo4TyynmSREIwkuCjS+KVcV/bIY5N3n0zsgDD/bnE9lOjRQ
         A4Wy99xXjFa123CNuF2vfYgcIS8Aqk9AGsCxE9b7fuVURtDwIGFPaABzfRVPHNLMKI90
         /TkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772495757; x=1773100557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++LctVCNk1Uw/H5oAQpRvLtdGEwkmdXKLvnmKGe4Ffg=;
        b=gAw0qgn2pRWG5lv78PG14Bcpk3WyhOyLe8zgiyj84wEDqUeVwJUFD9Q3NXx7Nzz6Za
         fCOzTJXlpJXFj54Som8DM7yZ3hGFAcMzrEyDO2aase5kUZP8T4gaMD4jYovvA/EVNGER
         zOch0luzpLMdFuoHQ8V3vs9KKAoIpY8BGnJf/A5ryy3EzeLFUJQJkbB+2aaRPUGlDSbO
         DAYwbw8L7tMxAuDXZE3v5Jr5B2gsp9DuLsllVbkBqqi4NSFJs7aX9zpFZLbyVJcIlFu6
         JKGLnQzr8bp11CInGp7b3C5Yl4ABETWz5LICIiiVcfADxV4J1lPbqojBJ1ltRW6shFnL
         e3eA==
X-Forwarded-Encrypted: i=1; AJvYcCURtJ20yDkWSLWjZT/1Gd0CYEXr5JCMuHSSRecQyjKm3k9EVy9o4Axid8pCJm+dBF+xkbrcK6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzssveHlYG63wRziwOZNsWUeX8wqlAS883+bBbe6zcV3HLn9Akw
	J1W5Lr7AJJIRZ8vGP0A8phgPZ6nGEhVDjgPFXMJFJg2y03haRmHcGEI=
X-Gm-Gg: ATEYQzxYx2Ko651ROGCl8cYRfmCG/umjlSGf7cK+8WKT7JdWPulQzHgCJkDlAh/DzOt
	qkz+79Y9Nh4esVyrE5dCR1fywFBq4WPrQGSRCO9DmzHiam8mT3ByGpn3PBWiiD7YrN5rWmo+igb
	lGLVrzoQ27h0/gEBZo+0FJGdqfjgCZdupBwoJuSV72sn7BIdKaZcyIZ8wUczNVapJKEMHGt01yc
	R/gmBVcITflE/NWHzyIceMEvMhGxooHBMlVUfGMKBbne1xxrjOXSnltZjKwC/nUk2QJJTJzjp9A
	UjxFn6dQoHnsAZURPt1VYIL7mDrXBKueSxuANM9BYq/mbmEaGrx5EgQSNK6S8k31R4kO20RO9Dl
	QwmsLB4T7Kov1gAbBMTMDRnLevcsrOf/1iiqzGM6zYuevy9vmMJDwivdRokZHAUkdRr9H1Y1GX7
	mCMCQ6QNGpq/mBzqWVc0SLnaoqDULihBQOrQDw7iRYT+M8XzAmBCXlBVTxlvW8vW/2ME5b+1qYO
	Q==
X-Received: by 2002:a05:600c:4fc8:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-483c9beaca0mr294617855e9.19.1772495757381;
        Mon, 02 Mar 2026 15:55:57 -0800 (PST)
Received: from [192.168.1.3] (p5b2b433d.dip0.t-ipconnect.de. [91.43.67.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7507adsm470843425e9.9.2026.03.02.15.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 15:55:57 -0800 (PST)
Message-ID: <46b36e3a-5999-42a9-911d-3396f4b324a5@googlemail.com>
Date: Tue, 3 Mar 2026 00:55:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/757] 6.18.16-rc2 review
Content-Language: de-DE
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260302160853.2519610-1-sashal@kernel.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260302160853.2519610-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF2421E6DE1
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
	TAGGED_FROM(0.00)[bounces-222744-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailvelope.com:url,googlemail.com:dkim,googlemail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Am 02.03.2026 um 17:08 schrieb Sasha Levin:
> 
> This is the start of the stable review cycle for the 6.18.16 release.
> There are 757 patches in this series, all will be posted as a response
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

