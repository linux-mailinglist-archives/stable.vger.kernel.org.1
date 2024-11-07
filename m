Return-Path: <stable+bounces-91806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E6F9C0584
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 13:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2ED283272
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 12:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12121DE4F0;
	Thu,  7 Nov 2024 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8V8HpJI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616031DE4F1
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981975; cv=none; b=NAH6OJ+LOiVzFeTVDVsxmpr8uzo/mgSpEMFpG3YXC7qpm20XDEY9WZj+it1OFEX+cLLYeAnc3+whPGzJTW1FNH2ql+YVJ9jlbrmPEGO2QxLYuGSNYNgul7XZIYzR/QZ1Uzl5PGwE8e4H1QELj13FUfPVim70pcFmlOuHOzXvS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981975; c=relaxed/simple;
	bh=PMG+rqlABVBz+TqA6nHYjw0V4WbjciJIqXhw0ydeDBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1DNG8pPBDhTv0Eaw99gtQvay+itgfHR56o31Oc40UjHD+p75DaLHorB4on1gshuOrWVM4wbFh1h73VuEGSpaIz6bXocQKucTcXUzi4BK24D2Y4YFkNxwkHpe2KW7WEByzUPaaBxcx1chSe6r1mbnQFfNZ8doTRR0t0o1thct6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8V8HpJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDA1C4CECC;
	Thu,  7 Nov 2024 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730981974;
	bh=PMG+rqlABVBz+TqA6nHYjw0V4WbjciJIqXhw0ydeDBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8V8HpJITTPmja2fujD4n7zRSQFfnm6FOleJVFliFEYtzsasJyxzs8n+ITApVzsZL
	 +y+HLeswGO8p5X3x7XoCANdaked5j0Imcxpb5c+Njfa15INmW8jhLLbxo7B464PmN3
	 /dKGfdgwBA5udEd4cyTHcBNuSRN5i1uEEwryLaQ5cQNfzQZOZF9sU9DwdSEEC30GJI
	 9CxKT754rhYdr/Z6PrzgWCaOwEWEqOSHSPdInsBkjuY9ua6Mf0QMM2rlxowQRdEdL1
	 iy5nZmF2SBMVVqTGUmuVZQWJtnPEluxhpJa9XyUwuJ7Wi6JuG5y6+/qbFeUIvRajvC
	 ux9Cz3MLRwxuQ==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	ardb@kernel.org,
	broonie@kernel.org,
	maz@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Kconfig: Make SME depend on BROKEN for now
Date: Thu,  7 Nov 2024 12:19:27 +0000
Message-Id: <173097843612.164342.13696404397428904701.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241106164220.2789279-1-mark.rutland@arm.com>
References: <20241106164220.2789279-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 06 Nov 2024 16:42:20 +0000, Mark Rutland wrote:
> Although support for SME was merged in v5.19, we've since uncovered a
> number of issues with the implementation, including issues which might
> corrupt the FPSIMD/SVE/SME state of arbitrary tasks. While there are
> patches to address some of these issues, ongoing review has highlighted
> additional functional problems, and more time is necessary to analyse
> and fix these.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Kconfig: Make SME depend on BROKEN for now
      https://git.kernel.org/arm64/c/81235ae0c846

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

