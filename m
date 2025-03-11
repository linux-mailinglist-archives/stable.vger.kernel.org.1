Return-Path: <stable+bounces-123209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17ABA5C221
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 14:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FD73B1D1D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 13:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75431B6D06;
	Tue, 11 Mar 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYoDqYaX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73C81ADC86;
	Tue, 11 Mar 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698833; cv=none; b=NyPBRCsVV9QbFaOdMDzcryTZErx6znbvZEsziJTv/C4CRy3BGjj/Kgg44WY7ysVGhnmm3CL03TcKYf//Cx5AqOpsEekD11w6yIrf3kphxqXii6UHiRXuNyS0tZgM74aZKdVdJBif+h7Zl62Wnvb060E28sKCcOjQpr/9rjtAzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698833; c=relaxed/simple;
	bh=9mLY5RPTw27hiwcuML8iH9RHXhIJmFi/AX1Jr9j1JCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emzWXD0s90TrGASP5PsE8muH8Q2FWJhLTfeKrURmK7kPlk5VohLgz0Vx9Ys7BG3X13YRuiM5m1jGiDK5DXE/zxEqqhkVFIIAS4dgHUgOhaXc30uUgCn9vTBv9Q5Uo+Lq0KSjn5Z0oj1hrtqQ4jgaPuNimhAz76g9/mu35rquxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYoDqYaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BB1C4CEF1;
	Tue, 11 Mar 2025 13:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741698833;
	bh=9mLY5RPTw27hiwcuML8iH9RHXhIJmFi/AX1Jr9j1JCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DYoDqYaXzESca1O7TObIN8QSpxSi/xD2PB5a7T8nvZu0sEJsCWrrsMoJXaXy3Fb+N
	 X7A95Kqrb5awRQksIXyMSoiLCNYjl0o+kx7k8Wk5RKYDfjkxNQOzqlvA7yM6ZtDsn4
	 deqaqfMz09WXH5uLgU5IFZs3P7QKPkNn9njuibwzmyoJAo8UxOdeuW+VrQOPoOs1D3
	 yefAl2q65NMfEp+6AiAcunyhBorOrlsEdQ0MYRyOukfnB8uyTxezqeLid6YukzwDx2
	 mlh1HRPPRSA4aa+gJgZwu2yExKSzdcr09E2E1wrHuSihYDNTez4BmfZFnvmIM2izCO
	 Jk/h5MDUhypdw==
From: Will Deacon <will@kernel.org>
To: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	david@redhat.com,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	ardb@kernel.org,
	ryan.roberts@arm.com,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	dave.hansen@linux.intel.com,
	akpm@linux-foundation.org,
	chenfeiyang@loongson.cn,
	chenhuacai@kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quic_tingweiz@quicinc.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v9] arm64: mm: Populate vmemmap at the page level if not section aligned
Date: Tue, 11 Mar 2025 13:13:37 +0000
Message-Id: <174169292046.277676.9363571702356367812.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250304072700.3405036-1-quic_zhenhuah@quicinc.com>
References: <20250304072700.3405036-1-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 04 Mar 2025 15:27:00 +0800, Zhenhua Huang wrote:
> On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
> to 27, making one section 128M. The related page struct which vmemmap
> points to is 2M then.
> Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
> vmemmap to populate at the PMD section level which was suitable
> initially since hot plug granule is always one section(128M). However,
> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
> existing arm64 assumptions.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: mm: Populate vmemmap at the page level if not section aligned
      https://git.kernel.org/arm64/c/d4234d131b0a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

