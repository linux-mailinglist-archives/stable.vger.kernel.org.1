Return-Path: <stable+bounces-204950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1810BCF5EB7
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 23:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0810B3039299
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 22:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE903126B8;
	Mon,  5 Jan 2026 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqZDpgzz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA3311942;
	Mon,  5 Jan 2026 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653949; cv=none; b=VgvyFpJaNxk1xnigW/7Qn9FVT8JyIAlLwszJ+gZSSSJ+FAXOQqDia97RI432qgNZ9Wi921sw/yu84U4jczVM3wEqTmnVCDCc4IQjXDd5agEXE7Nm2apCu8gzxD93MZV/e/0ZQluEw8yCHhp11V4DpATOz2Run5HqadNuq98auow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653949; c=relaxed/simple;
	bh=mjbsh5qTsWiK+bL9N+lcIzG0oeu7SbZwJAqsk6DZtZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9mgkx6BYsHq/NrEPJ57ERFeZyaDGB8/KKFnc3UV/Mmh6tQDm/v1TP8wbHG2QPlKhU91xl7iFZNpth/7fZpTyul/AmtSpCUKerkKEusEEgMnyuqphb3xZ2Qb3TB1spHM3XcugN7k6mTRjcKm8Vo1DI0k6xQ0QqIa6htdLhbi+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqZDpgzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C25C19422;
	Mon,  5 Jan 2026 22:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767653948;
	bh=mjbsh5qTsWiK+bL9N+lcIzG0oeu7SbZwJAqsk6DZtZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KqZDpgzzTWS+c/2QXiq/v/J7NmbO7ILss8exfk3eSj8L2zYvix7/ZDY6YEIknZLWe
	 FpRw1hjFCwKszZ9aNsXLyG9S3+EybZNzMCez1zXD/ipLfJj4axjzgEzaQ2vE9RHy2d
	 oNPNn72qyclj0t+0DddSe/43RKPLNjlVWd7WW53s0tygrpoOLp2uHbe9dly/4BOba0
	 pM9bOKBfSEk8vWSvwLzWwmeldPsN4pYBtXmmkENKiprTz6PI8eb0OPwrl5i5tmTZZp
	 K6ViYlHOkbkdajt65tSVHcRnqUDNp9q+RQ03aBTp/a+KaCXzlNOerzXR/iFypoPjtW
	 NnYRTs3WEDW5Q==
From: Will Deacon <will@kernel.org>
To: akpm@linux-foundation.org,
	pjw@kernel.org,
	leitao@debian.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	coxu@redhat.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: kernel: initialize missing kexec_buf->random field
Date: Mon,  5 Jan 2026 22:58:29 +0000
Message-ID: <176764846370.1457992.3931677360070887996.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251201105118.2786335-1-yeoreum.yun@arm.com>
References: <20251201105118.2786335-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 01 Dec 2025 10:51:18 +0000, Yeoreum Yun wrote:
> Commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
> introduced the kexec_buf->random field to enable random placement of
> kexec_buf.
> 
> However, this field was never properly initialized for kexec images
> that do not need to be placed randomly, leading to the following UBSAN
> warning:
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: kernel: initialize missing kexec_buf->random field
      https://git.kernel.org/arm64/c/15dd20dda979

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

