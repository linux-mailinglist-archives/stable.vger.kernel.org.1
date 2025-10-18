Return-Path: <stable+bounces-187852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E8BED3B6
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 18:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB27D4EB44D
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 16:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30553246335;
	Sat, 18 Oct 2025 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVf+2Htb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA743245033;
	Sat, 18 Oct 2025 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760804083; cv=none; b=GfVbr+lClGQjJgAOmvPJ4WD6Js4eUuQ9yi4EQ8beysedmiAiJtIM83vLnXn/XZ7mnvTP+ojHpp47OsUsZ77nhiXXNTHxEVBAOHXcdiAN1c7+Ougwx8mBEKEBKQPO4y/WU8bFx+wAEAtEgdXH9pV0p1cRdF4XUbT8epihr3bedGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760804083; c=relaxed/simple;
	bh=dcYga3fnhFMVG42fIiYDxyJEP7Rg4Y4WaNPkCYJ+AkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNEfF/fTmCA25OlDe9Xr7bfIJmQXpzamFLXK8jYbEgbOnJO6PqpykQ6wW8wboSTEepvUwj8ONyFeiugaAdh5hGFYWT5+wIeB8QGWNBBz3cXGtUsM8MReCAMcKGbB8OoBZQ0IQI6Azq6GGOkYxQ30+8qTPZ8tAzY6/PqltGVSsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVf+2Htb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6729C4CEF9;
	Sat, 18 Oct 2025 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760804082;
	bh=dcYga3fnhFMVG42fIiYDxyJEP7Rg4Y4WaNPkCYJ+AkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVf+2Htbd71lWLpLAq9b4S2GgMZF+vdGf7fm/P/Z/8+LVCTZ9iExR8fkKpToDQxsn
	 +/mdg+BzALqRpjg0aYiHvwY/AVBUL2BanRWYHsbbSjO9QRnGL9LbEXl5UUJkzU5yc4
	 Ub+QePAnlApRPnxn/06UjEZFALep2fkpdvUuLjO14PlebPKG9sblK+Z7v7erEFSHS1
	 +yYimGo4pE/S2eULUjScaFO0ENbcgpe8q029F84Fl9CVhfiOoxswrvL4iriOMHBDrA
	 VHqi3Wqnf7A1a7rlYDW7L446bSYWc2fevsw9HJQLPLB3pOnl7MGPcrp27sUvajWFeG
	 C+pvfDNYBbLdQ==
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
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.12 000/277] 6.12.54-rc1 review
Date: Sat, 18 Oct 2025 18:14:32 +0200
Message-ID: <20251018161432.1550017-1-ojeda@kernel.org>
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 17 Oct 2025 16:50:07 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.54 release.
> There are 277 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

