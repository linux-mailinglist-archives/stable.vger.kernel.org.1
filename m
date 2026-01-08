Return-Path: <stable+bounces-206414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C57D066E0
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 23:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D83B303898D
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 22:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F6732ED34;
	Thu,  8 Jan 2026 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWhbO4To"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A061B4223;
	Thu,  8 Jan 2026 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767911399; cv=none; b=WDOvOZtn0NbqNPWzBmTD5HecUhO3nETild6CRkIUWcvfFG35WVqh775BdIlKcIG35T3ZnMDsF0Jj2j913gRtVS/TJpCrkgkKgXKLD8DTfqQQxetbCP5agEBs5d011HbplWINtNeH4Wi1OCo38NJlf0oxnJILRJzroopGBfruGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767911399; c=relaxed/simple;
	bh=Zc539l3fQP67RQ3PA4+JN/sDBZn6/BFbAN/DKJlIfMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOYGlvxpw1zuHwmLNm6VossFjg+NMR+eru6bbv5iPM/9azhfQVgSQh4UEsC5w4Dr1i22WFTA8x9ddokushBvuXuLGjIGEEhR12832wIfL3JP1o1ViszWrFTztDwl3q5jCc9+3vrlIZNnb6yzKmEvOvYbV9c3ta2ufT3328zgSd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWhbO4To; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B069C116C6;
	Thu,  8 Jan 2026 22:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767911398;
	bh=Zc539l3fQP67RQ3PA4+JN/sDBZn6/BFbAN/DKJlIfMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NWhbO4Tojnk5cH5lfB6+pIVBs8X9zuvtraEkr/0Mxtw7iDgLp/WW9Q+0QewXqlD/f
	 zE1XfXHgWzrqcVG8P6VkWYMLKgIP82SsKLKyvl0VVfUemMrXtQTHW0/dWmX0rh7Ts1
	 6yOU90ivoSgw2xEhLwpTh0g3tawlLjNWerZGcQqCqlfBa7/MkvSgP5LSxgx4gs/75o
	 vwsPS1ek9S4Fvd4wI3rn+Erw0no46eFmnfpwMG1+ouRAk73TiM2Sj1VhV/u407ne4c
	 f4UJJ4qbi3YhgtQDn2CHLXwQ7/SzoJ6mQe3rmOszoWudR1CyNl+EKADxi/IEKFXQm0
	 Mpbd/4Esxk3dw==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Breno Leitao <leitao@debian.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	kernel-team@meta.com,
	puranjay@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Disable branch profiling for all arm64 code
Date: Thu,  8 Jan 2026 22:29:46 +0000
Message-ID: <176790876272.654154.10766231430439106278.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>
References: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 06 Jan 2026 02:16:35 -0800, Breno Leitao wrote:
> The arm64 kernel doesn't boot with annotated branches
> (PROFILE_ANNOTATED_BRANCHES) enabled and CONFIG_DEBUG_VIRTUAL together.
> 
> Bisecting it, I found that disabling branch profiling in arch/arm64/mm
> solved the problem. Narrowing down a bit further, I found that
> physaddr.c is the file that needs to have branch profiling disabled to
> get the machine to boot.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Disable branch profiling for all arm64 code
      https://git.kernel.org/arm64/c/f22c81bebf8b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

