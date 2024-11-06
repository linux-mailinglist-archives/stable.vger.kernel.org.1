Return-Path: <stable+bounces-91680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA6A9BF23D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81BF1F2230D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED722010F0;
	Wed,  6 Nov 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtQ/J9Ii"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4672EAE0;
	Wed,  6 Nov 2024 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908410; cv=none; b=WkmEr1BCTy8D+prtPZ6SlWDy5RacvK+Ckrpcdw9TJSTXXjZrK6rmTp4ccA0EpN1j4IwKsPtAS/ixByPyy/mnEQWqKfT8tswhH5F4eftmu6whuvyz/NROY1+gvoGijUMdBZ1pZimln2mUHqOU1BYriJgttVUCnCoVroraDZGSyL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908410; c=relaxed/simple;
	bh=6/DLV0Ij3ucV/bFgMjAQCQcBgcmt5Ui1j16wxrUI0HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EazgV1nZTPDbql/deeRpRvVzxv9uI36tsSvp66iJE+Oj3tT3bgJEY7GagzgoPtxl+NG63ZnH2xm/FjzKxiSMI4AcIuUIG7CWJOoYU7VPlPwvSSAPM1XGPhViDHeqHIXqfAE30CS1s3rnGKwmqzkNCKGT5qtXbDQzy6LOBeiqW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtQ/J9Ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE83CC4CEC6;
	Wed,  6 Nov 2024 15:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908410;
	bh=6/DLV0Ij3ucV/bFgMjAQCQcBgcmt5Ui1j16wxrUI0HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DtQ/J9Ii8Xw09w+p1m7kGR6qBbFkl/7zHiQ6fuct/0LC8qmEnnHajDhM7norJNjw1
	 j33wtCQMl608Y6B2l9F9i547VX147JEBqW5A+KCy+/eEhObUoX7TA0aICb0VpmD31l
	 mxX2ESPGjiZN9nRyIOxxrfGfLE5nzJLts/BASu4M+feFsgecfTuwogBkKTMOX3sr2M
	 9DR4ulxzKGHC7U3Uz+sjfziJkNHVMLK63qR/5We98LtDUZfhG49P3j97ZWfecT3dLs
	 JzVWUchvSaL4XNUT3UY3MkdUz+HdXR3/G+StxGIrC6PwetPjJwCRtl8uOOI63Suo+Q
	 1kQZvwIsi61Jw==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64/fp: Fix missing invalidation when working with in memory FP state
Date: Wed,  6 Nov 2024 15:53:22 +0000
Message-Id: <173090098098.2905624.10744681189844988391.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241030-arm64-fpsimd-foreign-flush-v1-0-bd7bd66905a2@kernel.org>
References: <20241030-arm64-fpsimd-foreign-flush-v1-0-bd7bd66905a2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 30 Oct 2024 20:23:49 +0000, Mark Brown wrote:
> Mark Rutland identified a repeated pattern where we update the in memory
> floating point state for tasks but do not invalidate the tracking of the
> last CPU that the task's state was loaded on, meaning that we can
> incorrectly fail to load the state from memory due to the checking in
> fpsimd_thread_switch().  When we change the in-memory state we need to
> also invalidate the last CPU information so that the state is corretly
> identified as needing to be reloaded from memory.
> 
> [...]

Applied SVE patch (with updated commit message) to arm64 (for-next/fixes),
thanks!

[1/2] arm64/sve: Flush foreign register state in sve_init_regs()
      https://git.kernel.org/arm64/c/751ecf6afd65

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

