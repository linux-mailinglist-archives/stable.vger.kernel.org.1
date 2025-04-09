Return-Path: <stable+bounces-131972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99A8A82BB8
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 18:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B951E9A5E73
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 15:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E746926B966;
	Wed,  9 Apr 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmD99qMI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6BC26B948;
	Wed,  9 Apr 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213680; cv=none; b=oZYXx166flF/91Q/fZd4P4Q+XcnprWmfpSoQBFaCBIIxqmn5ow+HR1G5zqqt8akl8oU8z+YG+BiE+7a+Gwu31I5cQW2IUgmyzKZYGnjnIT8R0wTZH2Vo/NDjO+jmsl22emwZBF2OJ3qisswzysJZcOU1TOjwjm0bqR4yMh5w9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213680; c=relaxed/simple;
	bh=UmuDN18MktFopw1Z5xqO1NY2q6NRs0IlbVmb4P+d4Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyJycWQzm2isPq2wABgfotoEDY8EHKkoyorT6s5HRNaJLvAuW6lbnPvXcuO19uCxu39SXgEdonlScdEUnkoB+ibNFMNOwrpAcmDy67vn0BNROFjmP77Pa6QBVzC6g8w4a8A+uqBEt8umlSbsURHTV2B3YJ/l/hWnXB5Bn7Z9+IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmD99qMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E55AC4CEE2;
	Wed,  9 Apr 2025 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744213679;
	bh=UmuDN18MktFopw1Z5xqO1NY2q6NRs0IlbVmb4P+d4Nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BmD99qMISwWJql2hnIVO8tgetqjk/J/WuFA3+3PDsFdPh1TklLHcmvJEm2rOSTpNF
	 MzwQBY3YytNDnillH7JQGnFs51VFN6oy23DsHcTTxKnWHt88P2lkAmi7/UU6ELfk0v
	 aOOmChW04tGlZ0dCVtPz8jD0rUmU5kAYj4SL+74q/jDdjukCqf3ghCju0GqPmF8DFH
	 GnjSZb8/z4RcOJ9kCqKRTLpKfgQlcprqoBgtn5Eii0SMC+QIa/sXEM6vHUgrwUKMeM
	 YnrXCNSWQGR9FYg5IDjfLU183z6IS8TqWFIowBm0j0JT61zcm7h2o6rk4IEfMj+EyW
	 +E5I+5hGfK04A==
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
Subject: Re: [PATCH 6.12 000/426] 6.12.23-rc3 review
Date: Wed,  9 Apr 2025 17:47:48 +0200
Message-ID: <20250409154748.1233729-1-ojeda@kernel.org>
In-Reply-To: <20250409115859.721906906@linuxfoundation.org>
References: <20250409115859.721906906@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 09 Apr 2025 14:02:59 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.23 release.
> There are 426 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Apr 2025 11:58:05 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

