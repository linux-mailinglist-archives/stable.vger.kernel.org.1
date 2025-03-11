Return-Path: <stable+bounces-123208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156CEA5C21A
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 14:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B4016E35B
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8094A137932;
	Tue, 11 Mar 2025 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQrtOQMY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4878F52;
	Tue, 11 Mar 2025 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698830; cv=none; b=DOz2826sb7LImiW0qt/1dzQp67QRpoQDlFzjsWi0rO0Q0In1djMFjmn9aqiPh2yqE9sTOJFjvdPUqk12DwBzRva1KDBGtNCPCEcziRxIdfqMF0V+vLPpcTw0HwgLs1nkqU676shKxQ7SEcXRtj6KAnjo7otXZ1ErdMrlkmuDmJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698830; c=relaxed/simple;
	bh=W5TW3ItKe0zCXjEoHNcQyGj1KCK/QSQc7spLlCVjgow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gkbc41CZE2vAsoslzFzRZg3huXh41ulKWUTOS441U0N90CJChuxE6m3oYRmWHaqQct0ByNyF2Asm0aWwM/j1BNRlKdp+B8Vg5tkNbTi7LBymj3FeIVPJMzfPH7OD0tOXNUmkvheEPtLqCuK3+icRTmiabPnsqUthaCy66TCdNLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQrtOQMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0536C4CEEC;
	Tue, 11 Mar 2025 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741698829;
	bh=W5TW3ItKe0zCXjEoHNcQyGj1KCK/QSQc7spLlCVjgow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQrtOQMYMPMYlS/buZhQKhd0yPkZTs6SrqVzwdmGj4OUORYyFjIwCtSkrmyNRkxaU
	 hwTij4rzs46Ky1AOTB8HpRT2IG/XT7zsP/KijrhWYiRhHQ93n+jSnglTaRa93MPQEW
	 G/Qf5R2NSma/6n+KVhg0dt3fRdBTCUw2kubMbukoUaL4cUixdk0itiwLmVzWs3VVC0
	 S0qyqOhcGAN4haUtooV0AcirdKVCHJRI4FtYz3jj/ny+jfq6b9B0FJpU+fbNnaC2mL
	 oHXR8OKBUdbo/KWOKbg7E1N0EFLcYDw1ik86bkNGCLXLSDUqgSEQK8m8uQLVpmyQT2
	 8ns50s61k3GAA==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Piotr Jaroszynski <pjaroszynski@nvidia.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alistair Popple <apopple@nvidia.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	SeongJae Park <sj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] [arm64/tlb] Fix mmu notifiers for range-based invalidates
Date: Tue, 11 Mar 2025 13:13:36 +0000
Message-Id: <174169306404.278141.17801949874773526998.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250304085127.2238030-1-pjaroszynski@nvidia.com>
References: <20250304085127.2238030-1-pjaroszynski@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 04 Mar 2025 00:51:27 -0800, Piotr Jaroszynski wrote:
> Update the __flush_tlb_range_op macro not to modify its parameters as
> these are unexepcted semantics. In practice, this fixes the call to
> mmu_notifier_arch_invalidate_secondary_tlbs() in
> __flush_tlb_range_nosync() to use the correct range instead of an empty
> range with start=end. The empty range was (un)lucky as it results in
> taking the invalidate-all path that doesn't cause correctness issues,
> but can certainly result in suboptimal perf.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] Fix mmu notifiers for range-based invalidates
      https://git.kernel.org/arm64/c/f7edb07ad7c6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

