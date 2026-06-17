Return-Path: <stable+bounces-266716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2CzECGCBMmpE1AUAu9opvQ
	(envelope-from <stable+bounces-266716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 13:13:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E19E698DEB
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 13:13:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=V6Smc0vS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266716-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266716-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E07D31522C6
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932813A542F;
	Wed, 17 Jun 2026 10:52:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2838A70A;
	Wed, 17 Jun 2026 10:52:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693558; cv=none; b=LUZQzyUnYcs8HV7it93aNnvM6Uea6PEGtWcZ+DNXHOBFC1zZjBoI8Abu3EAzZN6JXFdmJHWa3srUfIfl8vno7aKb+EP38DG+fTkxxVTdaD6uHEGlUBc3u7sqtKquRyvjh0UOHZVxeyAD4K23ARTujvDgfmU1zgOJEEsa8W/KhzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693558; c=relaxed/simple;
	bh=RzyRnT+ZdGYv8bl8mIGHHM0FXc9NpkE4ljb9Ulg+sPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwpcQhAYVvLpNt8HJM7Ls5S6sRRcIQsSE1mdUam2OZc5FBeTnRmb6LeO0zq9oZYfEzO1O+aWUBENHhVLIf2SjndJmCGeWGErn9Np+mAJI6vsctFkeWlWXvTcIs4Db1LQ5j/4/dRHjpvOgJd+F65J+pS4A9T5wYPMzfGqh0AM7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6Smc0vS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC61A1F000E9;
	Wed, 17 Jun 2026 10:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781693557;
	bh=JZbqZkhOUyoGmziemqJI68Q1d31jAqXsJS2bmYS07Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V6Smc0vSQ3yi2/gOE1t21X4E9plY3brvOYc4sauTy0VS0I8Bc4jQJqj7egk+3/6g4
	 vPOyiASec3QFFQWv2EaRhKuCC6VGgklr8ELnUefRU9TIjTI2cMCUtzn0gRh4F4BvjX
	 SfnL7ncz4R5ATdIFpxKJ1kIYAWMGUj0vaOL/GgKDd90eizPzfcvcL6ai1emaS9wO+8
	 tLQVxJlZx/K0qxQhg/6aqF9UT9bLIrMc19fsLCJOUDYWdnZTLw1QxRBUGNEIbSE9EU
	 aYmcObPRbIfP7AXm8khvNMHSdKSpmXrx6lZTE+RXpeYk4phH3O7CunwEWT8JqRzbHc
	 F5hMR6z+35XCQ==
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
Subject: Re: [PATCH 7.1 0/8] 7.1.1-rc1 review
Date: Wed, 17 Jun 2026 12:52:24 +0200
Message-ID: <20260617105224.64682-1-ojeda@kernel.org>
In-Reply-To: <20260616145523.335696673@linuxfoundation.org>
References: <20260616145523.335696673@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266716-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E19E698DEB

On Tue, 16 Jun 2026 20:28:45 +0530 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.1 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jun 2026 14:55:16 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

arm32 looks fine in a couple build tests apart from the known `rustdoc`
1.85.0-only issue. UML looks OK in build testing apart from its known
warnings.

Thanks!

Cheers,
Miguel

