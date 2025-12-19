Return-Path: <stable+bounces-203066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D783CCCF603
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 11:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12A273021769
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABC3302CC0;
	Fri, 19 Dec 2025 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUMo/AUp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3730103A;
	Fri, 19 Dec 2025 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766139864; cv=none; b=PX0Ow9IR16yfYH7RGof3kIn7Xbgv0s5dRD7WXFde9328rnJcqV7svZmTcw7ReyCw73dURGE5OOowVPiJgjMWmvEDAuEvRixDvWd5iCN+M868bJ8aW9tuoUn4sPzlLzixsOKnIs+ry3Ywesxmm7tGvxYXyOEF8h40UOSeXSRtAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766139864; c=relaxed/simple;
	bh=wSKyNDjvJgFlUPvhdLHb2g9n4p3P5THT9cDaRQbeVSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJj2zitYQpyoAvgZHv9mu8PeOA4NM5yBSiliZxSSB4ZhOBlBbvkiMNuIv+MK4ibr1NM6RzcMUOjjqncuY18kJDcqzYaN/UXuTgAYP6ysJkmP7u6sqakMJzBub2H57ipqrD7leX5rYPr411syaYf55JtNjiF9aeK/3L2P3An/h+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUMo/AUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36205C4CEF1;
	Fri, 19 Dec 2025 10:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766139863;
	bh=wSKyNDjvJgFlUPvhdLHb2g9n4p3P5THT9cDaRQbeVSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUMo/AUpvVpAFy1KTUsg7PvXaoMEBcFUrPgpZBC9Ppwd0s99fKyVTyXuCVqZHPxAI
	 0YkLbof3icPfyqRzHnqcRxL7XHFackIskpce4KYhsyfK1eFmegYxUGAQbyklT9qSLH
	 PISJivxpp83eRhOwfuUipQryFrsAi2OBWbe27qJpfaIyF09OL8RDAAnvr54xEl7cHL
	 u3t41FLJ54D2hAzjnNBtJd9q9oLpTG2M+2g1B1gJc+UZG90u4OMsJvhPvNCCJCx3Iw
	 VV7UhhpZQcS8vaONezygjg9DwG2nOc3gPQf4aQap80yrKzeMVMBHcfKYflJYNZcN5f
	 ckSrm48aOxeDg==
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
Subject: Re: [PATCH 6.18 000/614] 6.18.2-rc1 review
Date: Fri, 19 Dec 2025 11:24:08 +0100
Message-ID: <20251219102408.96358-1-ojeda@kernel.org>
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Dec 2025 12:06:07 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.2 release.
> There are 614 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Dec 2025 11:12:22 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

