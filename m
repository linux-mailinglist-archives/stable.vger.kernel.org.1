Return-Path: <stable+bounces-176386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C5B36CE2
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FBA1C45C92
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18355231856;
	Tue, 26 Aug 2025 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYcN0Qgf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B264B229B02;
	Tue, 26 Aug 2025 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219540; cv=none; b=a6S/fTOYdcH85V9zTAzGbmeQNC0Lo2N9sj98N3NUFhndPcFBN9YBxq1zlIrpJJhhtg2fAUy+8fis3B17aVTcX0m6v4Uqhz/snwi4GAInLBX3q+bp4oi29VzFv29qF8CA6ZbVA56LVxH1MJcN+x3IfrpTksBlAXEVeCwmqsYa5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219540; c=relaxed/simple;
	bh=pHvdiww41qjOcxOEVjcfcQ7mwE8MnxtZUWKvkmRLJF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3jgrUeY6InHRYRDRWbiBEfqqCh8jrIKy7DvYAct0ziDpVbP+KmnHhnqPbOKp6hrn0iJLmizkeVJ766w8X80joCb5uIgEOprgor0EuZRX9wSjKpoizajcxowPP03VaCLRqhRJ/zBUxyg4OFYkAxe35DMC9WjcpO+Z59tZ1Lu1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYcN0Qgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D44C116B1;
	Tue, 26 Aug 2025 14:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756219540;
	bh=pHvdiww41qjOcxOEVjcfcQ7mwE8MnxtZUWKvkmRLJF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fYcN0QgfPWZS1aNbzJlBkVeaqxFvKDMdNGlLFfw9w0RR0+SZQRIGjS5QJpmL6wYRn
	 AvlIygddy4ZjHmOhknsViNrcNpCopT7fo07rXKguEh2nLVcDSwRMDpxJ6PmLxSHwZE
	 XQnHiLpuKaRC09HiD+VziQUJ3/vZN9lZoDpLnpUTLQZFq8vYWRzYYsgsi7i8f2Azct
	 G5CLZR9I+gx28Q/U2poq0htiKIiFNMb3/VtD9dy8xc80zd84FxMpSCygcTlj0JGz0K
	 i9smCUps5/WAXhRlt/+TPhcnJr3b7yUnRYolXzIO6xzq3NyJoSsI7SK1HrqsibmxG0
	 hzhTBXiW51Ouw==
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
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
Date: Tue, 26 Aug 2025 16:45:27 +0200
Message-ID: <20250826144527.712511-1-ojeda@kernel.org>
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 13:04:44 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.4 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:27 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

(By the way, this one builds cleanly for arm 32-bit too -- I normally
don't report on it since it is not clean, but it is nice to see it may
be getting there).

Thanks!

Cheers,
Miguel

