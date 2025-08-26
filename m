Return-Path: <stable+bounces-176181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88BBB36BC5
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BD4A024B6
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BC135E4D7;
	Tue, 26 Aug 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyNPxHxH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077E9356915;
	Tue, 26 Aug 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218993; cv=none; b=oO7fmJW32z3CJreVuCjOvUIsychH0fYR3+rrnDd1FVDMIp9Hi5/xwCGC07aKhUFSZOnBQ9bF1PFJn/z+3WMTlS7awiFfI4Vci+EUXLUkVghkCdCls7D3xj/zwk2G2hEKlgiovFLppohUHO2X1+YRMrgPXIElawqGXWHPasUv8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218993; c=relaxed/simple;
	bh=rSf2OZEogZolwPgeMbZpAVxSfp8YgDedRJC+R2qBdfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVpm3mYgETOlD/0eJbwVtqjeMppQd27+uoxg8UCBrAh4bD7xxdDBPr97TAYC5te6BHwJNojVIT2G7sc740wqdfMgCQJHHM1zpGD17lD5CVpmGSFnlXPHvoUcWZVbKlW0cixfY7hiiUpJf+XugYLYWhuDHximBV+15I5Qt9WZeMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyNPxHxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9639C4CEF1;
	Tue, 26 Aug 2025 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756218992;
	bh=rSf2OZEogZolwPgeMbZpAVxSfp8YgDedRJC+R2qBdfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LyNPxHxHD3hwu204Wvnq1O/6zA+phCPhDtuEWgAB5Ke6RBLC2jL0ytzSthICaaOgP
	 6LYB7d7s3McrpsjKqAtp7unel889yOj0KxPKmMwO5bSZ6HrGjLRiP5oE1vVS0Ts+r+
	 dUFG7BfLe34jTjTfUxCcdqxjd3+zmtC5G6G+LQzpi+s2BHPt4UQwCIm3ycyfpkOsp5
	 8s7i7o/MdkLCA3gnzlqv+U5O1mPIWO8nolKiEC+nWyq6uODH271YzWBafY7LcPAnWQ
	 getZAE8h0qr464WCqTMBo2gyKZN+x5I490wFRQJT6SukHuy2n/gZmabKWqwyjKOvOF
	 6JneHiKkrWPDw==
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
Subject: Re: [PATCH 6.12 000/322] 6.12.44-rc1 review
Date: Tue, 26 Aug 2025 16:36:24 +0200
Message-ID: <20250826143624.712058-1-ojeda@kernel.org>
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 13:06:55 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.44 release.
> There are 322 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:26 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

