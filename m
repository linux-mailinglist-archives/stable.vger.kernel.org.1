Return-Path: <stable+bounces-207987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9929BD0DE10
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 22:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B28A301F002
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 21:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C2E29D269;
	Sat, 10 Jan 2026 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj7GU6Vw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68470238C2A;
	Sat, 10 Jan 2026 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079963; cv=none; b=kvYvHFwdYvBtdx4hL/I7V7KMfxBP3KB9+/mACzsx6pbIhGRr1xoSCK8K4Pka5s/h0C8cL0la3t0mVfVDKCNgYGeqT10Tt74K4rS4FkCZutbaspEqV+mf7E2gqpwG4YQnpQlbSh4OyGs33PTvzqzzizws6XT+B5lQxtoXslZg44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079963; c=relaxed/simple;
	bh=u81CRaZdbF50+Jq5V/Yg515cCGwe5elV3Thy6GCBakg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rN+rgnyvrONvBNRDUis7w29QZ6z1wp66XV3gzHX0wtbJjpTv4/mOCRdX5RfxVXxiA2Ev9xXi8kX+wa0Uz7+bRWHJUIRmey7QxdfgYBzfZ9jnSNJIDm8TDlYSw0xRtesfEkK9Ax/EmUhDtGpb4Nz7FsKU6M+ZAZcbyrt4s+SiSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj7GU6Vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A94C4CEF1;
	Sat, 10 Jan 2026 21:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768079963;
	bh=u81CRaZdbF50+Jq5V/Yg515cCGwe5elV3Thy6GCBakg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rj7GU6VwknFchtE9extXKsCOgD+GkNf0cjJgFlcv3q6Co5gxsVVZ9qDP1DRsjn+tz
	 NUYd0pL0fXVCEMMFqJ0jZXHf9zBKRJKdD0HErZBnY04ymX5Wt7Oht4PWx7tG/ad6KW
	 ZL5UFtszB6+xU0JNsty2e+5VgBwkyb3T9NuK/4KECm9h/KgNHIoyLWgg4Snfleas+r
	 5QsF2umMGOBN90zg92AlomE2uurlFjhg34XEUJ4RsTiyWuxKICjSXU5tMLnjvqAZuU
	 OF8GEx9K9DOyUpaICZa96qi4n5x8DtGn9bsuoPU5xE1Ed7QtxWBNTEer1ZGNYE41yF
	 hlpmwaoeTMtNg==
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
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.12 00/16] 6.12.65-rc1 review
Date: Sat, 10 Jan 2026 22:19:12 +0100
Message-ID: <20260110211912.120183-1-ojeda@kernel.org>
In-Reply-To: <20260109111951.415522519@linuxfoundation.org>
References: <20260109111951.415522519@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 09 Jan 2026 12:43:41 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.65 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

