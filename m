Return-Path: <stable+bounces-169578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3C3B26A39
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E601CE2F4C
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7F721B192;
	Thu, 14 Aug 2025 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alR2Dhq8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C821884B;
	Thu, 14 Aug 2025 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183049; cv=none; b=S5E6hKMrHrz065YUlgklWnX9booYMLv7Hr1E45b4KhXmWe/5PzAXWO73vGqC2HMhT2rnNdBqC7q7hDFeqFwhpHdobFlJYRPNcbcx0HTV+JP7gAN5mGgR2yjO54AlRghR4CcVJVpqJ/7QHdU91wm8MKC0RkrFSatxzOFN6+NATgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183049; c=relaxed/simple;
	bh=R1h5hI0HCu+Xju2ydiONXcIr678k3J8wRawMs1+FlMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRlvFebtbPvPES3TZSMn0Wm5+oPr3Ac1VS/cCbAM0b7x0RCPL5QtC0OEq3g/3+65AIVzFJ2rJ6iAFvJFu76uz7H/2vlEGLCxgYMySpolP/keVNPCLJrfFBndd/9JFI/M3zFcA5wB6X7Xe0sGw3YU6YN963zApvRuapt1CRk5LNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alR2Dhq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12805C4CEED;
	Thu, 14 Aug 2025 14:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755183049;
	bh=R1h5hI0HCu+Xju2ydiONXcIr678k3J8wRawMs1+FlMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=alR2Dhq8VSVA6ChI/5Elm94IcZUwFvI6z1v1NImonVMtOTINSkT292Nq5QkbXijIk
	 7VN1vk9suQLwQAwerk696t347oCquzaO3ojGEuRCs3W/D1EmlTdKNZPyZ6JeC1U+ki
	 Ao2MN0MjEZkH0dsvZYWD3TP63bzL5lKfOeS2GcWINhpkbvowLz1HSqP1ZXgxHsXrRS
	 Ta2Tb9pBEGlU8jgjFUquUnck9zk72eiZmhSRQZoHL+sLDOKGqRg4TXa1d2fodNRLsf
	 WNxk/lNzj8FENbufOXS8ZYK0zotIySo+DCPBlDO6KuBjTD2/PLUHFwYHBY0uEV4KJ4
	 lnrGgChjcx8UQ==
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
Subject: Re: [PATCH 6.15 000/480] 6.15.10-rc1 review
Date: Thu, 14 Aug 2025 16:50:35 +0200
Message-ID: <20250814145035.2342562-1-ojeda@kernel.org>
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 Aug 2025 19:43:28 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.10 release.
> There are 480 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:42:20 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

