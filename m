Return-Path: <stable+bounces-181549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB335B97850
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 22:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD9616ADFB
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 20:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F781F582E;
	Tue, 23 Sep 2025 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6dOf5Ze"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C58B224D6;
	Tue, 23 Sep 2025 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660414; cv=none; b=OC7913LExLWlNPvd5aFiSH3KZ04vDokwX5pxbzb62Ae5orQk0Mwxvgha8Fudv/1RJAy0IpKI/tGI4pxarYwfmrRD0SNKDY7E5uzJ6eN3aWfS2GWiKXHVQyl+MHRzipjgo5aYtIu+/gp0NIYJYwGX96x2GJUrTIniWC31vmutxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660414; c=relaxed/simple;
	bh=JXxNDYBUj7pTLBQL2Yva3Lyig2/mOxe4nlA0nI+OW4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbW0NgYjnC4GCX7e+n8DI/nmIFRkXeGXtz6qT4bVwKUBybXMQW5VBgpJn6MQ7qoyJJGCn0dqpEbmxA2t39XaneAvN6Gil2LjVKBNw1ZGBdLEUTM9enQ42DcG6jNFblLZ4WGcgSUft0ssQXe8kaRkZmPZOEL0/Pt2WRLr+6eH1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6dOf5Ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C9DC4CEF5;
	Tue, 23 Sep 2025 20:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758660414;
	bh=JXxNDYBUj7pTLBQL2Yva3Lyig2/mOxe4nlA0nI+OW4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6dOf5Ze8WZnII+H8HHnA2UcPWjcZMmRmh6PTT1Xi7UQM0ehxS5pJSFZPJzDSh5+s
	 AjKWFgAq7+GfaGZzl9yslXBGyYkPUYjgJWQKPs1ke4SjL0LBq9KdzKCU6sjVA0QTNm
	 h1kObxNgv4tTQgHT8KBXEpgLpT2WY7Cy3GfZwEUKC96Lqlrmnj05KbDhllRV6RNIIq
	 cHKo8hAsHiTorjZWD9URbz6HOpyRB0cNPf+BYHpDdmp9AHjo6KtWEzDsFyN3/ydYw5
	 G5Dv0ptiIg6S37172wJtOl7lpLcJhFPKA9hNDfKG1RABjkM7A2efdfiX9Jt1UoFgEN
	 Mj65FSyXS5M/w==
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
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.16 000/149] 6.16.9-rc1 review
Date: Tue, 23 Sep 2025 22:46:44 +0200
Message-ID: <20250923204644.692613-1-ojeda@kernel.org>
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Sep 2025 21:28:20 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.9 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for arm and loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

