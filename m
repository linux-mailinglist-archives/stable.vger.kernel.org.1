Return-Path: <stable+bounces-225391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI3oC+B/tGmuowAAu9opvQ
	(envelope-from <stable+bounces-225391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 22:21:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C70928A1CA
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 22:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A44B30B00F4
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6331F382398;
	Fri, 13 Mar 2026 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YivqIXA4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482C35F192;
	Fri, 13 Mar 2026 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436806; cv=none; b=LN2HuaVnaBuMEd8HqIM/PqlJfcavq0hYyInpV84n4u1OHHc0IT1Fy8PILDwwyBoKDcZ9AjmV8oustAKy+8jvOQCfaN7JXwhHqrR+uUfWtgo88C90FIgdJBpEwP0vY4Gf+dSMA3DRysg5V1p0EnJm5VthvGu1VmOMRZT5vmWIEoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436806; c=relaxed/simple;
	bh=Qnz2PJ5ZFY9Ad7ZBNgyMEzqRaeAiEVNsmjk69km6ZQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2hkU+bQG4YQ1etZZDAV9TbHjK74BRzGlhcEgsFVtvQfhezVV1O3+edps3tYPQM4ftJhqWAZvEkNITyKJLM81WlyFdWGOOPQRGSOpvbAvIlBpze8KSGZLPphRFEjNi84KjbK9yppuPS9YH7da0vUU/Rlkru0hGETPmbTw8Cc7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YivqIXA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3709C19421;
	Fri, 13 Mar 2026 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773436805;
	bh=Qnz2PJ5ZFY9Ad7ZBNgyMEzqRaeAiEVNsmjk69km6ZQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YivqIXA4lATJybHZs2BdrxuJRyt+H2rrj3QdvlsykqWKgGQ2kfUw0aF69HzkA6ljw
	 Vt4q6eEucHNOa0D+fWv30fWoDlcK3KYpS53yESl1+5K2wGwEQlVnxww1mG9ycDAsOH
	 WsSFpLEJyf1iKO480jUpsjXna8Wlo7aJB+ztlE16IFMnfNS7zXGZfhQFnbcn6ygd0Q
	 eOm5s8q5SuBVwKky8PiqpHbPHGTeEI6uDQlFOenvIf8z6Fdp4dpUXR12w/rF3Yscmm
	 RhZK/h7ot2nKVrsol3jnDJeJ65uevdXnwf8NuE6PQFiZrIwTlMVQ2qlulj9QMOjMQ8
	 j7T3XdRrybTiA==
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
Subject: Re: [PATCH 6.19 00/13] 6.19.8-rc1 review
Date: Fri, 13 Mar 2026 22:19:56 +0100
Message-ID: <20260313211956.184457-1-ojeda@kernel.org>
In-Reply-To: <20260312200321.671986598@linuxfoundation.org>
References: <20260312200321.671986598@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-225391-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 7C70928A1CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 21:03:32 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.8 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 13 Mar 2026 20:03:10 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

