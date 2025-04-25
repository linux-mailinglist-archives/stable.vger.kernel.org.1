Return-Path: <stable+bounces-136641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5463A9BB9A
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 02:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109CC7A965B
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 00:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC725819;
	Fri, 25 Apr 2025 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE9Z1p+K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647A7748F;
	Fri, 25 Apr 2025 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745539964; cv=none; b=fMsgLo16mphgz9aaacJmcAB9tM0rRhauAFYyx1wYiSv6htnKclPXDMOzE+0uJXhZoeL25QlsBOrqfM76knJVtOq5apmiAsTCBBedzDMd285ijKnF27lYOJa8Tc0+pqzRiLjGm7pFYi1Hj1nY4WJC/eciQGAVQnDjZoHUln98mj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745539964; c=relaxed/simple;
	bh=3yYGKKJIccm6KMwelyXSan4frHVE41xmN3TXdDeAQrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=su9ldmRTLf7kgx1kA4ZA+ehjSElsYXIyCbwlKxOqZQwssk1ZjYe7Hrh8nGZxgX8MOlX6PGCZ2NMvspj7qqAo+C1Fw1/nscO4Rp7xiVB1ePDrOedI1XXUx+LIif2XM+MFZNvpbQjx4fk22q/YyffvLun/W180KF8YR5HElcDfCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE9Z1p+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1B3C4CEE3;
	Fri, 25 Apr 2025 00:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745539964;
	bh=3yYGKKJIccm6KMwelyXSan4frHVE41xmN3TXdDeAQrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JE9Z1p+KnB4/hgVluiQC7jObTH82gupf4IpN+IYPEYd6asun6PrMt47Ju7WfxRKS4
	 +LwFfYv5Fl9eUolOm0yVQmlW3pCRIUBz7WyNs2qTweYnIx9Zq/lC1pv9noWT/yK2qZ
	 rmgQ2J+s3SLwi6rYqb2cSBqzdL5XJCnH9C6YaH7i03DwztD8aaLGSewTQTnf1ouQ10
	 jEpree4SL4uWAc2JOwUgg1kF/cxVryqMritIebBfGk/+JrO0PluFfaixkLTPGQPWo9
	 RgtC/na6p7zBcWX7zJX7M4OSVtTMsxPXC9cba2uMQgnbZRQlsLSPG9TyAAtOqgfvGv
	 9HALniOZqsSqw==
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
Subject: Re: [PATCH 6.14 000/241] 6.14.4-rc1 review
Date: Fri, 25 Apr 2025 02:12:12 +0200
Message-ID: <20250425001212.62011-1-ojeda@kernel.org>
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Apr 2025 16:41:04 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.4 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

