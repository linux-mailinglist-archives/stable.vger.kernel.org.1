Return-Path: <stable+bounces-163035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF5EB06860
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 23:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF213A7DF3
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 21:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB0A2BE628;
	Tue, 15 Jul 2025 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnpMXBM4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B21B042E;
	Tue, 15 Jul 2025 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613874; cv=none; b=LMU+76htOrdN17EXnl1kfhs7JlANBBTamzIhb1VKBfI/IO/bRgzKn9MSIns7hMzbDmEKpcR8k7OjK1CCwikr8MQpgkXmJf499L5SSVIxR+4DNkLvt2d7JCNBLlavJMtefajdgw9fYgwx6syQk0+C9cSxUI7HIg3QE9WCXgFlrHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613874; c=relaxed/simple;
	bh=uVdxvUgXmfYpajn/gcYFfyv05jqndqI66hvc6if6wXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcMZKgWcCR2B9oZdDkGH/gqLXVxAHDldFAY/kz0xGfbaC2z/inz8DIo0pNVENseV0KPb9iq5YvItxTsQKgpwWQex1+V6tSOMKVZKRyzC3Bk0ZYnsNBjFtG/QiSI35kUNdGIci1PESanSJw6zVX7ilusy6p30Gd4Ld5RfMI5KXcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnpMXBM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4077AC4CEE3;
	Tue, 15 Jul 2025 21:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752613873;
	bh=uVdxvUgXmfYpajn/gcYFfyv05jqndqI66hvc6if6wXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RnpMXBM4dUtV91EIlOkd6YBXWiy0uW2gNzfFFIXOrRm7srxVSo1zXgg0u6YA8QBea
	 bK3un/Ye+bt2GyHF/35svqPJAUbSCl1htyTJmeZYaHXIVAUAXk9N0GhmpqYGP2Uu/b
	 cCSkxefpiCUxiR6/pBer/YHH9gFkozSYqpK/kjXujrsJR30/eeyenVN52p0AYXfIQC
	 x8AairzwLSitDtnrBYy6K9N8//hLfiwnhpUicnEhAimU7exD4QRlE4PwAbijeG+f95
	 Eu1RzfP0LvFxp/a7+gLkgltpwe/zb7IEWmtVOBLlFmd1cOYcyqtw3q7wRjRjNhy5wk
	 zyJRDuxWm+HBA==
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
Subject: Re: [PATCH 6.12 000/165] 6.12.39-rc2 review
Date: Tue, 15 Jul 2025 23:09:20 +0200
Message-ID: <20250715210920.2341188-1-ojeda@kernel.org>
In-Reply-To: <20250715163544.327647627@linuxfoundation.org>
References: <20250715163544.327647627@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Jul 2025 18:37:19 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.39 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 16:35:06 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

