Return-Path: <stable+bounces-205081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1941ACF850C
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 13:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E3B03021752
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 12:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9576E30FC2A;
	Tue,  6 Jan 2026 12:24:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01A52EBB81;
	Tue,  6 Jan 2026 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702261; cv=none; b=PFamZca7PwtoNrELmhJSZCTrYljJWpqBj5XgNBUamfPO1s2K515TtcVD+KiMijiqiluHg0DI3D7rlegamby/YOYK1F3mLXu359gTy6cSZO7yUmqYhEnpcX9cYZESp8IhOGAJJOacgTVrodR7cSs5K3yKVWkeUOAIXsaiJYYOKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702261; c=relaxed/simple;
	bh=qRf08rPWW7Nh/KW1wljqTzpHvVRUN+y7ORoKwXYPiew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtFh2yCNBvNR+80KyINYSK3dqV4f1m0k0eDY3YHxnnjgrgeDnL4MTcy00Fi3tPql3r+xL1ID5s48xNDPAm5hIJihw7PGKA3/aPxCwOtNfLWA2uj4NX1Ao2TLRs7uasM9ro+TvC9g9cBS53DKVMfCRyqLDKal5Wv/Dt6YoZ2ewCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D7A81595;
	Tue,  6 Jan 2026 04:24:12 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 242A13F5A1;
	Tue,  6 Jan 2026 04:24:16 -0800 (PST)
Date: Tue, 6 Jan 2026 12:24:09 +0000
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
Message-ID: <aVz-6WozGIxGiTUR@J2N7QTR9R3>
References: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>
 <aVz-NHMG7rSJ9u1N@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVz-NHMG7rSJ9u1N@J2N7QTR9R3>

On Tue, Jan 06, 2026 at 12:21:47PM +0000, Mark Rutland wrote:
> On Tue, Jan 06, 2026 at 02:16:35AM -0800, Breno Leitao wrote:
> > The arm64 kernel doesn't boot with annotated branches
> > (PROFILE_ANNOTATED_BRANCHES) enabled and CONFIG_DEBUG_VIRTUAL together.
> > 
> > Bisecting it, I found that disabling branch profiling in arch/arm64/mm
> > solved the problem. Narrowing down a bit further, I found that
> > physaddr.c is the file that needs to have branch profiling disabled to
> > get the machine to boot.
> > 
> > I suspect that it might invoke some ftrace helper very early in the boot
> > process and ftrace is still not enabled(!?).
> > 
> > Rather than playing whack-a-mole with individual files, disable branch
> > profiling for the entire arch/arm64 tree, similar to what x86 already
> > does in arch/x86/Kbuild.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: ec6d06efb0bac ("arm64: Add support for CONFIG_DEBUG_VIRTUAL")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> I don't think ec6d06efb0bac is to blame here, and CONFIG_DEBUG_VIRTUAL
> is unsound in a number of places, so I'd prefer to remove that Fixes tag
> and backport this for all stable trees.
> 
> Regardless, I'm in favour of disabling CONFIG_DEBUG_VIRTUAL widely, so:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Whoops; s/CONFIG_DEBUG_VIRTUAL/PROFILE_ANNOTATED_BRANCHES/ in both
places in my reply.

Mark.

