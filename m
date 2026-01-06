Return-Path: <stable+bounces-205112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81791CF9281
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 794F9308952C
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5141E23A9AD;
	Tue,  6 Jan 2026 15:31:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7043E6FC5;
	Tue,  6 Jan 2026 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713517; cv=none; b=aXSmB1FTXzm03gzbd/zpCLsK30IT0G5vkbii2wDr3sf5R5NokATRZ1tCl0imOG8ykH1NAbjaQTfc8IidQcBc7gtnOK4h1wki1uNFlPiXEQiFpuqUv7UCkHj2ydoydMhEXFC3kl2Rs59A1fJ6lBAl7GD2/5wBxcACjnd1Natx118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713517; c=relaxed/simple;
	bh=wJ868SthR8cJ99tIgLhHTd2k4GKn7vnQkbfuQpLaouo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSlyy8bbGodErDdCdMxZtes8j8rwh9BjRakesYVnjf4/1g/DWTH0LVNREiwEJ9pjGykcOBz6YueL9V833AuNWzd1y9KjZRpRUWFr7gV+4GKj479AY9ImxgIkKtyIcyVbuOugt67fLbf2LOEztLym2meaeLgr9iGimXxJ2HnnV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06DC5497;
	Tue,  6 Jan 2026 07:31:48 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 958933F5A1;
	Tue,  6 Jan 2026 07:31:52 -0800 (PST)
Date: Tue, 6 Jan 2026 15:31:16 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Laura Abbott <labbott@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@meta.com,
	puranjay@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Disable branch profiling for all arm64 code
Message-ID: <aV0qxGioAXxkh6QD@J2N7QTR9R3>
References: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>
 <aVz-NHMG7rSJ9u1N@J2N7QTR9R3>
 <tj43kozcibuidfzoqzrvk6gsxylddfpyftkdiy7xb2zm7yncx5@z33xu7tavuts>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tj43kozcibuidfzoqzrvk6gsxylddfpyftkdiy7xb2zm7yncx5@z33xu7tavuts>

On Tue, Jan 06, 2026 at 06:05:37AM -0800, Breno Leitao wrote:
> On Tue, Jan 06, 2026 at 12:21:47PM +0000, Mark Rutland wrote:
> > On Tue, Jan 06, 2026 at 02:16:35AM -0800, Breno Leitao wrote:
> > > The arm64 kernel doesn't boot with annotated branches
> > > (PROFILE_ANNOTATED_BRANCHES) enabled and CONFIG_DEBUG_VIRTUAL together.
> > > 
> > > Bisecting it, I found that disabling branch profiling in arch/arm64/mm
> > > solved the problem. Narrowing down a bit further, I found that
> > > physaddr.c is the file that needs to have branch profiling disabled to
> > > get the machine to boot.
> > > 
> > > I suspect that it might invoke some ftrace helper very early in the boot
> > > process and ftrace is still not enabled(!?).
> > > 
> > > Rather than playing whack-a-mole with individual files, disable branch
> > > profiling for the entire arch/arm64 tree, similar to what x86 already
> > > does in arch/x86/Kbuild.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: ec6d06efb0bac ("arm64: Add support for CONFIG_DEBUG_VIRTUAL")
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > I don't think ec6d06efb0bac is to blame here, and CONFIG_DEBUG_VIRTUAL
> > is unsound in a number of places, so I'd prefer to remove that Fixes tag
> > and backport this for all stable trees.
> 
> That is fair, thanks for the review.
> 
> Should I submit a new version without the fixes tag, or, do you guys do
> it while merging the patch?

I assume that Catalin or Will can handle that when applying (if they
agree with me); no need to respin.

Mark.

