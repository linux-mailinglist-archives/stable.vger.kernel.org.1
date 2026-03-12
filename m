Return-Path: <stable+bounces-224829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGq+N+uBsmm6NAAAu9opvQ
	(envelope-from <stable+bounces-224829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 10:05:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7C626F58F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 10:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B5163027378
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350D93AA504;
	Thu, 12 Mar 2026 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwCOehY9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8AC3876C5;
	Thu, 12 Mar 2026 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306336; cv=none; b=RRhFSAhNoMqMJJGTsDvijBQduQvxc0YXXUkwacqnJc/oG9AdraARQZkOwrANEwmFM7WeyS6E1plI6KLMLmmFRGnHDL7gfbKLkUsIDsURx90j/kYhVNJU/M6DN8XpTioxSo/0PUQARMKosSoCuZE9Hu0yBhGxpp/fqRtvpJ2YJjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306336; c=relaxed/simple;
	bh=xgLXqgkYV+RSF6h2MuiylYskHHoupd2DfCcfAbo+zw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJ7ACMSHHnkwwzdm/1XtBjke3T2+vsEZRe7Vzv+gW3FKB/OTgdo55T4UzbfL2x4JQLKuNZuNKFZJ/KkyWP3jNZRrdUgEtj515b+WxGRfowlVsF6CaCNW8TpOhqDlfi+wlimqvOaesd1xcQ2Cym/3HjPAzUMoTq7KyW8vUHfuscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwCOehY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E535C4CEF7;
	Thu, 12 Mar 2026 09:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773306335;
	bh=xgLXqgkYV+RSF6h2MuiylYskHHoupd2DfCcfAbo+zw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FwCOehY9YCp9YUcSS16Zvj8355iGHcyoCD6JZgnaZUJpzDWLPM79y/7lj0k8GcqhT
	 FuFh+vMLYlL1snTQJBFyQXLaTp6WVD2zCgtlZJHlWcJxUkd/AHGEmMUq3gXFj5hRv2
	 IqGHOsXmCqrVJN6Q0pIz0KXXO2xGzgafdedhq/IHBL+UYycqfEdAO55Uom5yrhCkq5
	 3PWVwUcD8DFRN6RzAKwYuUDJQ/zPc/rO7ijZDEYtHPbf+cslWt9EdzvkZ4qTnXSb/x
	 +2VqsjE4+YJ5LMU5rqOHkbpi/WBiERM+fYieQ60yiibXm5K0EGshJDOgG5zLslvr+3
	 SvfC7FUWYh0RQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: sashal@kernel.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	gregkh@linuxfoundation.org,
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
Subject: Re: [PATCH 6.19 000/311] 6.19.7-rc1 review
Date: Thu, 12 Mar 2026 10:05:25 +0100
Message-ID: <20260312090525.57500-1-ojeda@kernel.org>
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,linuxfoundation.org,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224829-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E7C626F58F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 10 Mar 2026 07:05:54 -0400 Sasha Levin <sashal@kernel.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.7 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 12 11:04:16 AM UTC 2026.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

