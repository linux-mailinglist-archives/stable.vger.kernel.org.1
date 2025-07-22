Return-Path: <stable+bounces-164309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9B1B0E61F
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 00:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4789CAA48B0
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 22:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DFE286D5B;
	Tue, 22 Jul 2025 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ9k734w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E427F160;
	Tue, 22 Jul 2025 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222294; cv=none; b=T4tkP7ftFPZ/k52tgyGV3KscZHBM+voeemTDxrKf0/whY1BiX3yGUR/3/rKka5OduOEmoPJbuD77b2yFLoK+T+8ydA5Oozn2AoUseOi+IPVbn9pGA+WMQ5cUjS6mjhZqLVQlVWGuxYvHE+Gol1EfpbJSWmS15MJDWUeme0grbPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222294; c=relaxed/simple;
	bh=4/euw1w5JIk5wNaRROV6TgPUNswUsUiIgLasGCq7DoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9eNqszRc+8K7UPSTt6QNmEbfUz9wi37cjwY4fzEv7m+CoqGORA/bG9HupifYC30UmO9MRQeJOu8IGj4VDsbPpEWy6nMi1hP5klpb9I4x/8HRZxUF0aCr5uSKrBiHC6TN3AZ/GdqBqYhzVp8oaIV+gXDiCwfOGFFJUxmTqSTUSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ9k734w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEC4C4CEEB;
	Tue, 22 Jul 2025 22:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753222293;
	bh=4/euw1w5JIk5wNaRROV6TgPUNswUsUiIgLasGCq7DoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQ9k734w5rnCTm8Wn0T/G48mcwXB48xlE0KypVOCr13mow5HaaOrw21hcNMTUR97/
	 ibUDABvvHKH7o+vaaolA8VrVNTlljr108L0/oeWSKlc6tbERur9DzWp53HkPCRWcah
	 D7mfMuzPwjI3gg15sxtw9NmIz0UgmXw5ffovkPMBri5AueoGYX8hWrjBf0Ez0GLSpJ
	 l5+eAfrjODe0oatSSsnv4LLUZ+2cbF8Iqmp8qDfHPvTsMFMgzH0nPvftItmcNizjMG
	 Mz+ctbC4wyazylEXpQ3jiJzLYno5Ac/SYb4brvkGVpHSVk8Z31n5Uj7f0cqE1k8QZw
	 hwiysPFiA8jwQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
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
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.1 00/79] 6.1.147-rc1 review
Date: Wed, 23 Jul 2025 00:11:24 +0200
Message-ID: <20250722221124.1684154-1-ojeda@kernel.org>
In-Reply-To: <20250722134328.384139905@linuxfoundation.org>
References: <20250722134328.384139905@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 22 Jul 2025 15:43:56 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.147 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

