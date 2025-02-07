Return-Path: <stable+bounces-114238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9D9A2C1BA
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 12:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243143A63E5
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 11:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E7C1DE4C9;
	Fri,  7 Feb 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVl4Krz3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5A2417ED;
	Fri,  7 Feb 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928266; cv=none; b=V1+YLM7EBZqcRp3gL8gb929Se/eVC4C60vghAk+qT3mw0nYuAVcKXnkH2iESZrZGGSSwykPilC1SLXFu0Hm29sabCUWbdziIIGTfG9+TbnUHslIH3Z2x5xBx3726G1wO4VdL58bRE2CJaams0TzZA6JnVHWftuO5pwo+XOdl1J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928266; c=relaxed/simple;
	bh=PW0sMWesSWW0COshS2HtpPEqlkHX2KN+bsrSyyccYLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaQvwO4VoZjRBUxhwPJThHaJ7gh5XGIznmKQ6jTYaowG1x1gMYWgcUmgGFDv8MccgaS1vqujtjG+Z8IF0wOlPKyE+AZLEbFfqingVjZSPFP8vXgaoQ0QXqFqptT6M6aOmJit7rqI2av+zoI+RdQWo3MwhsAzroLppQ3KztzUSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVl4Krz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB11CC4CED1;
	Fri,  7 Feb 2025 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738928265;
	bh=PW0sMWesSWW0COshS2HtpPEqlkHX2KN+bsrSyyccYLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gVl4Krz3+XnL1SeqcqHb81BW0B/ih8XsjD3jG5Bh2NMdzG/6Zo4fxNBSduiSnyFLr
	 tYtE/ub84yX7LBFyPK9XXHYPMJxNXYOxzRwtMXTG1Td9h7Q41BNWWUY7O2YGmMqd22
	 jKmrEENZbMwjj/ouxfl15EbqSFa0x+URrW8mkFi+s1R+I4yLD9iRIjqYPFBMyGooSz
	 GMVc6nuUiu6BcjTx/q3hTh5D5tO21MtgfrdxGW3YJLa6Pe+3Y8/nergtaL13ePLxz4
	 RwROxzhp5cXAIBXnLv4g4m9ao/giO4Roy2LVr6CqgB2dgPktNN2l1m7xYsgq+ksv0T
	 w1styqH4xol8Q==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] arm64: Handle .ARM.attributes section in linker scripts
Date: Fri,  7 Feb 2025 11:37:39 +0000
Message-Id: <173892221767.1467001.15470830254553080217.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250206-arm64-handle-arm-attributes-in-linker-script-v3-1-d53d169913eb@kernel.org>
References: <20250206-arm64-handle-arm-attributes-in-linker-script-v3-1-d53d169913eb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 06 Feb 2025 10:21:38 -0700, Nathan Chancellor wrote:
> A recent LLVM commit [1] started generating an .ARM.attributes section
> similar to the one that exists for 32-bit, which results in orphan
> section warnings (or errors if CONFIG_WERROR is enabled) from the linker
> because it is not handled in the arm64 linker scripts.
> 
>   ld.lld: error: arch/arm64/kernel/vdso/vgettimeofday.o:(.ARM.attributes) is being placed in '.ARM.attributes'
>   ld.lld: error: arch/arm64/kernel/vdso/vgetrandom.o:(.ARM.attributes) is being placed in '.ARM.attributes'
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Handle .ARM.attributes section in linker scripts
      https://git.kernel.org/arm64/c/ca0f4fe7cf71

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

