Return-Path: <stable+bounces-139532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E780AA8003
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 12:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888FA463785
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EC01D6DB4;
	Sat,  3 May 2025 10:16:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0141413957E;
	Sat,  3 May 2025 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746267382; cv=none; b=DHXEHmZwCCKIOSJhwpc7IYbte4T1fPXB7ESZhheqFYE5Q8YshLRiZYXXJ5Ex/xvBa3x8xV76igCHkJlDytA4WF2ua2V2zKPhqvg8a+GHxGPADD/7XjjjxKatIt3yMZN5zPtM8NcLE+cQOBlOPow1eF4+tYKgY9Bm7GdrMLzjlMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746267382; c=relaxed/simple;
	bh=2DpO9NIzq1fZPUFDPLtGVAUc7vLdpoXi9YTxUeefCGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9c5SPc2ZaTxk26YMlELLL/+6hvWqhcE0bj7kbBYrd1UAZ8D9/z8vTLMX8jnNhuVoNeG2UExo10k00ptLzFTb5BHWZvlrItfMkWigjxMbt5I7dDGMGnbjegm8TGphO7jFDzkiB0FirIW/YkhhXKDpnYPxZ2jxj1Qcic8TPZS7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE61C4CEE3;
	Sat,  3 May 2025 10:16:14 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	broonie@kernel.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	shameerali.kolothum.thodi@huawei.com,
	james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io,
	ardb@kernel.org,
	ryan.roberts@arm.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
Date: Sat,  3 May 2025 11:16:12 +0100
Message-Id: <174626735218.2189871.10298017577558632540.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250502180412.3774883-1-yeoreum.yun@arm.com>
References: <20250502180412.3774883-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 02 May 2025 19:04:12 +0100, Yeoreum Yun wrote:
> create_init_idmap() could be called before .bss section initialization
> which is done in early_map_kernel().
> Therefore, data/test_prot could be set incorrectly by PTE_MAYBE_NG macro.
> 
> PTE_MAYBE_NG macro set NG bit according to value of "arm64_use_ng_mappings".
> and this variable places in .bss section.
> 
> [...]

Applied to arm64 (for-next/fixes), with some slight tweaking of the
comment, thanks!

[1/1] arm64/cpufeature: annotate arm64_use_ng_mappings with ro_after_init to prevent wrong idmap generation
      https://git.kernel.org/arm64/c/12657bcd1835

-- 
Catalin


