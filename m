Return-Path: <stable+bounces-114894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3F3A30882
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4D2165AF7
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006B11F4262;
	Tue, 11 Feb 2025 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT7wZxHr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24081F37BC
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739269766; cv=none; b=HX+fJP5+yCzXS7g6ZyTOdomtMxSeKLgwVplHIC5yJ3HzOM7o+koOSGZhs+hiCupy9wigGktOs+oT4ZEM3w2b8kotqw6ornls73qIREJ3aATg02kziFWZuXsvMR8fDWlLH3K+HIpRMDhqIawK4rBdL1sMlwGmtNukR2r1qfBF7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739269766; c=relaxed/simple;
	bh=HaHabSl+wxC8yeelHmSr2+qIEdKDU6K4yefBEnZQXy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+0z4HefrZMVY3IPeg/qqyT20xtz8hb51dZ9HYEMQ9VFkyz8ChRlW0w63Qn/nE1KgGbZqlDzm+5qHHCcH2VdWgs1LGIVezed+MP9O5zg0NKEgQwAEpcS8OXlBVbW/VF5plfbZof4Jy8aQ3hXPSK5bhr4Yqr24uhLjnP2QaxTvaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT7wZxHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17ECC4CEDD;
	Tue, 11 Feb 2025 10:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739269766;
	bh=HaHabSl+wxC8yeelHmSr2+qIEdKDU6K4yefBEnZQXy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HT7wZxHrLIu2yMUWmOIWFnrP7uTpA6e1zrfjmnBecJYeZzPHp4RnYchuY8B9yLQV3
	 rGR3bQZPj4Ik5esTM/eyWiJlLvf8SGl4bDmT+pJ7cXrSWbXEPeJSiTprCzigx6Z/7c
	 UpZ74U6s6A3iK+l8+3nLoG5thLel7eiamb4mdJXvfKcThJ1U+0kv1P0ARw2m9zqreS
	 0eTHJkiiJXc0Q2SKFVfrQgAlrm12f5kCkBPu4zQVANIrrrMxxihp5ytLVAquFObbxK
	 TAr9UUjHMjOfLuXfBbaw/K3X839Dfq67ToIN6UNCk9yC1qE6v4a3E4/uhZOvOgZpCk
	 q0s4nehs9XTgA==
Date: Tue, 11 Feb 2025 10:29:19 +0000
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Message-ID: <20250211102918.GA8653@willie-the-truck>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-9-mark.rutland@arm.com>
 <20250210165325.GI7568@willie-the-truck>
 <Z6o1t7ys2qVaZ-7n@J2N7QTR9R3>
 <20250210182009.GB7926@willie-the-truck>
 <Z6pL81_yi98o2vtS@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6pL81_yi98o2vtS@J2N7QTR9R3>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 10, 2025 at 06:56:51PM +0000, Mark Rutland wrote:
> On Mon, Feb 10, 2025 at 06:20:09PM +0000, Will Deacon wrote:
> > On Mon, Feb 10, 2025 at 05:21:59PM +0000, Mark Rutland wrote:
> > > On Mon, Feb 10, 2025 at 04:53:27PM +0000, Will Deacon wrote:
> > > > On Thu, Feb 06, 2025 at 02:11:02PM +0000, Mark Rutland wrote:
> > > Sorry, I had meant to add a comment here that this relies upon a
> > > subtlety that avoids the need for the ISB.
> > 
> > Ah yes, it really all hinges on guest_owns_fp_regs() and so I think a
> > comment would be helpful, thanks.
> > 
> > Just on this, though:
> > 
> > > When the guest owns the FP regs here, we know:
> > > 
> > > * If the guest doesn't have SVE, then we're not poking anything, and so
> > >   no ISB is necessary.
> > > 
> > > * If the guest has SVE, then either:
> > > 
> > >   - The guest owned the FP regs when it was entered.
> > > 
> > >   - The guest *didn't* own the FP regs when it was entered, but acquired
> > >     ownership via a trap which executed kvm_hyp_handle_fpsimd().
> > > 
> > >   ... and in either case, *after* disabling the traps there's been an
> > >   ERET to the guest and an exception back to hyp, either of which
> > >   provides the necessary context synchronization such that the traps are
> > >   disabled here.
> > 
> > What about the case where we find that there's an interrupt pending on
> > return to the guest? In that case, I think we elide the ERET and go back
> > to the host (see the check of isr_el1 in hyp/entry.S).
> 
> Ah; I had missed that, and evidently I had not looked at the entry code.
> 
> Given that, I think the options are:
> 
> (a) Add an ISB after disabling the traps, before returning to the guest.
> 
> (b) Add an ISB in fpsimd_lazy_switch_to_host() above.
> 
> (c) Add an ISB in that sequence in hyp/entry.S, just before the ret, to
>     ensure that __guest_enter() always provides a context
>     synchronization event even when it doesn't enter the guest,
>     regardless of ARM64_HAS_RAS_EXTN.
> 
> I think (c) is probably the nicest, since that avoids the need for
> redundant barriers in the common case, and those short-circuited exits
> are hopefully rare.

(c) sounds like the most robust thing to do and, even though the ISB
might be expensive, we're still avoiding an ERET+IRQ.

> Obviously that would mean adding comments in both __guest_enter() and
> fpsimd_lazy_switch_to_host().

Yup.

Cheers,

Will

