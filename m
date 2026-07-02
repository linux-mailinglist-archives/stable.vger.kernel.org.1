Return-Path: <stable+bounces-271587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A5xXLAj5RmpkgAsAu9opvQ
	(envelope-from <stable+bounces-271587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 01:49:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 011B06FD7E6
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 01:49:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=D5D+DfKV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271587-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271587-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10F7E302FB50
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 23:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99303C5552;
	Thu,  2 Jul 2026 23:49:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC55381E93;
	Thu,  2 Jul 2026 23:49:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783036163; cv=none; b=Lh2Rzip/J396XYIyYSjmXHicgl1a+33c2kGWOtWSwk717PHlZb8qfnLfXQRU4k5EwJrMDnnb6OO10bZlX5FtkaZOjymf95TlHCty/NroWFlhXQGbdPmcgldILo/3kVoy8WOpv6SOpa7Ha5JIMq6gDI+Gm5BqcAdsLdDEtpV7YQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783036163; c=relaxed/simple;
	bh=88bjTaIy0nYS/N9xsw61y7gnsY6w1e/C5OMyYLD0sFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PK44r5pBKKy5sUIFIRj/Ht6fHClXjtDrdKTe4hDoUVxBafybjyrRMb35CDRTo2KjuirOqJiyRhBhf8IoRSPHKbQdMlU/m5RP++JFvCvzlaD9gARjZeHPw+vuKdCLCw9iPW0uebtcRfYJKqv1Hobs3LM1f/jX3LsiQPPwm/MkH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5D+DfKV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013691F000E9;
	Thu,  2 Jul 2026 23:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783036162;
	bh=lvBv7HKuh2G8iToAeVa9VFcQknvxHMZfZvSeA1gOkEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D5D+DfKVzk6oTD497luLenG2hLZhGi9e3fZcyDHdX0xF5aaKEqrmp0OokHlpVjiyK
	 iojfQV0jo23NBdxqrIyuiqbzytzJgiXUhDCmf9GYcRrhEpeAoAJ8UN91MTKIqUmMLP
	 crBZftS5w6DULt9gq4MhjqCzfXmt7O9kPb2CKxjkzyOzU6mGvN00L7UkUfFGXO6AJA
	 JQx5RukDddhaxFF3wb4IDozY/Yd+62xRNHygyFQ/UJ2LY/4R0rlSUgJx/oo2A5pLpB
	 7GixdauRPEJXUzYbGZk2sOtpZ4zEpLv9d6ir37G3DEc5vffCXyvEXVey0ZvyVssi6q
	 l38O11koKVhSA==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.6 000/175] 6.6.144-rc1 review
Date: Fri,  3 Jul 2026 01:49:12 +0200
Message-ID: <20260702234912.10972-1-ojeda@kernel.org>
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271587-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:achill@achill.org,m:akpm@linux-foundation.org,m:broonie@kernel.org,m:conor@kernel.org,m:f.fainelli@gmail.com,m:hargar@microsoft.com,m:jonathanh@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux@roeck-us.net,m:lkft-triage@lists.linaro.org,m:patches@kernelci.org,m:patches@lists.linux.dev,m:pavel@nabladev.com,m:rwarsow@gmx.de,m:shuah@kernel.org,m:sr@sladewatkins.com,m:stable@vger.kernel.org,m:sudipm.mukherjee@gmail.com,m:torvalds@linux-foundation.org,m:ojeda@kernel.org,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 011B06FD7E6

On Thu, 02 Jul 2026 18:18:21 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.144 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

