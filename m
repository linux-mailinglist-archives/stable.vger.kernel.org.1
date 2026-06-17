Return-Path: <stable+bounces-266616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iGXmBaX9MWrftQUAu9opvQ
	(envelope-from <stable+bounces-266616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 03:51:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A31F1696025
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 03:51:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=PCf6peN7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266616-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266616-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16C3430E0D5B
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 01:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897182E739B;
	Wed, 17 Jun 2026 01:51:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B7D2BEFEF
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 01:51:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661078; cv=none; b=OQJoQ/1mNJgRWdngR9P2LY+s2xzbpJFNuaOPH/yMxOBroRyTIVEn0IrcOdSfcgwyXAwOfHih7iopu+Ze4/sfOwzGNXNoP4Re8lfpn+tKNaBp36zN5Bp0tIb4+OcjPPdTXcO1B4HxEzOo4I1zXnLzereQPCa1MaaxVmzv42rdyRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661078; c=relaxed/simple;
	bh=VCchtsxVM2fH38qZB1msSHANcaGuRLHfHBHW5cUJ7m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPHVfbeaiCVF1PaH4j3D5FMHf8KB/1P81CDqdZrZoj7vJNkWHqJxNekR1kgzw/zwwB7snQ11XZ+1p6ypdtxagjHZqgS76XdCr/STzLSj1dqGXpG0KKarwshrIcJ7yAm8onuV+pqFCQWvlaHYg9ImApHF4MFFd5tyQ8na+R1nZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PCf6peN7; arc=none smtp.client-ip=209.85.218.48
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec429c2bb1so752596066b.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 18:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781661075; x=1782265875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4VyfNlebK/GSH3qwV5tDtdqyj4VFoDsHhNLx6q8FQw=;
        b=PCf6peN7uX8R28d+WRBN21ui9TvtzeYqbT3LGL8ryfwaD4wPr8wj09h8rp/IPITR6c
         BjPvUJGsOHZEGhQdo7Nookj+VHX5y0T7r5MRRBN2I8Tct+NQPhr6Qsq+Yg6sAonYXWeD
         Awx5gT7spmX9X3k6G2/FtFoGB6/Z9sJWNodLYWbUPUSHiIhMflX0iaruLB/A+tO7jLeE
         X0fn3V6LjOwq/5GllS51ZQ6pB/21c4IbIyns89Lz8q6xCux+bLFCpr9yppW2VPJFRzhg
         nT1X7+w06mkN1pqF6Abp62GVLvHhKLNkCI7uL5AWpghrXxg58GPgLS1pvA3NgV0zsMFv
         jKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781661075; x=1782265875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4VyfNlebK/GSH3qwV5tDtdqyj4VFoDsHhNLx6q8FQw=;
        b=ikevbg4ki9PqEpHrtrtxySRd2VxcOLDKjV9IlArVVlMZBGJIt0mzh9Xbq+2b6PGVq6
         vdnun4+g5/77SLo4vIgcclZASL6nGOGbXIbct+moBCoqleYGEGy7ZGykbT8BzcKITly9
         Js5FiuuMjGw0hl2GNcmc7AuZ/WCUm2i+t/zh+Yedpfi8Kl2/GZkvuG06dPrvZNX28LZi
         hL43akJp95KYj6e8ur2FUd2gE63S8lzlfvf21jh/EV4mnOEovd8bX/Zpd8+cWUtW0JCz
         dJBYPRbYwRgVcKf6Oq5vpQ6+1i1dhBA+E9lOgYCZoXvMgXh8gR9tMtTwKvjDhvLcsh1n
         7e3w==
X-Gm-Message-State: AOJu0YyID5W+PA54APCSq0CrFq7OM/Po+1aI2fHmwgnIqueFXD6gMm5p
	NXaUTRO0c2cu2H1tLetwUfg8FVqt8nUpaFlSlJM2qXJgcBe99Ec/l3EW0h1wz4Mg6H8=
X-Gm-Gg: Acq92OE3CX8iHDMdwvXYV1alvJ+Hrt434kVpbttuc1/q5fPIvsHM9fof/KruQT+zeoQ
	spUeXAYBVf2bQMWgCr9DrhRHs8l5ou1xnyHe421cDM5RRf5mLevcr9s94wUi1yFCmiwTOqeGXPV
	CUvYjgPBjXN58dYG0c5iIboAXMOZsmHUuU0Jksd442ri2suKBrtS59maqVRAXRPBGFB8jwW7Zx+
	Gtelxl87PEFkKjG0vFquDicI1AlV8yQt7eD66kRgzuBtVwtz1K+kDzZ6PYqyW7rBeXXpNsuSrSd
	czLcKoFI0DY9ftvHinDr29HNPfpLf1ssRS/971aUkd7Wa5oYgFas0lFDt72E/WjOifOjNQ3KANn
	nbZyV9bnRmaeu07qTjEETeuI0BvgF0nGp+ezl7Assl/bdXXyFDR+BRlKxTTH1aNAPkDgaryXdyK
	igefA4bVBmdr3/mxjVmvHUr8HA1RnvlrjOHy3Ohg==
X-Received: by 2002:a17:906:cc52:b0:bed:e0b:5b0d with SMTP id a640c23a62f3a-c05a4c16e03mr77326366b.13.1781661074914;
        Tue, 16 Jun 2026 18:51:14 -0700 (PDT)
Received: from u94a (27-240-202-183.adsl.fetnet.net. [27.240.202.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac794sm146042435ad.46.2026.06.16.18.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 18:51:13 -0700 (PDT)
Date: Wed, 17 Jun 2026 09:51:06 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/261] 6.12.94-rc1 review
Message-ID: <ajH9eYhd2AN06ROT@u94a>
References: <20260616145044.869532709@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266616-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:from_mime,vger.kernel.org:from_smtp,u94a:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A31F1696025

On Tue, Jun 16, 2026 at 08:27:18PM +0530, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.94 release.
> There are 261 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/27647340765/job/81762433321

[...]

