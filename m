Return-Path: <stable+bounces-203116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6744BCD1EFE
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 22:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24559305657A
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 21:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466B9342538;
	Fri, 19 Dec 2025 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWIJJN6k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227F33DED1;
	Fri, 19 Dec 2025 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766178714; cv=none; b=JKX0Uin9AWIhk7k9CH3Vfd+ygyGyb+QaeCdpElxP6EkE6H2Dq8/8DhExxlBIus5dxNDdH/WvE+fBZVz+0+LBYZ3hbixQrRYVGjq0C4wkIr5u3QTvCDKTaOSslhZYVifJ9DdUu9F6ifCpbD0VkyJQ1dg3R2KzylbjuYIxSAOAekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766178714; c=relaxed/simple;
	bh=ASdLTBHxfVhR+QLvDMriea/AWjGZgarCbTh+dIQY7FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brBqfEqQAmL9QNPEsFonZzb2K8+y0f77j8G9KhKTAqhUqN0hJsPBzwNlclwl/5JlkqqoPuUbztxEmB9JP0qscj7mVq2sr71KQ60ZNQg6oNHu01vj7BEuN6bw17RKu19rJ01JJQfF9R2tlc6p7WFwlAjJlypZdbkQi0gNq8MIAS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWIJJN6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A98AC4CEF1;
	Fri, 19 Dec 2025 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766178713;
	bh=ASdLTBHxfVhR+QLvDMriea/AWjGZgarCbTh+dIQY7FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWIJJN6kykX4+qu0rIPmop1UUvYrEVR87Y49ASr7DkkQqNWPTjXxYKgVp4M67DgLb
	 GWUXcPBYrax9EaDfSCGvc+6xjRRMk9c+mEJRCDISXIuO8xdbVjKxWK5mZfGQ1WBH3d
	 z1ca2ItL9ML6XVHFMMlxlWGgReXJ6Z2yxsSKjBoKUupGENydLu0wWUM4aO9a9A5H27
	 QMtk6U1VaACvwVDF+NrcthzSVakeFgRQfCBS3iZ5xvneK0nD4UAf+36mfZyNNvFr98
	 ddbsq3rZVGW1I2xqpfYShpUXBuFlQh7pyWlxmJJAcmHMVEJENnJTRtcZbg3bxX74aI
	 Ez+pV8UTCdabQ==
Date: Fri, 19 Dec 2025 14:11:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Rudraksha Gupta <guptarud@gmail.com>
Cc: Christian Schrefl <chrisi.schrefl@gmail.com>, stable@vger.kernel.org,
	regressions@lists.linux.dev, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, llvm@lists.linux.dev,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Subject: Re: ARMv7 Linux + Rust doesn't boot when compiling with only LLVM=1
Message-ID: <20251219211147.GA1407372@ax162>
References: <1286af8e-f908-45db-af7c-d9c5d592abfd@gmail.com>
 <0705db10-3cbb-4958-a116-112457f9af6c@gmail.com>
 <1910f4b6-db74-4c86-9010-28ab4462c5a7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1910f4b6-db74-4c86-9010-28ab4462c5a7@gmail.com>

Hi Rudraksha,

On Wed, Dec 17, 2025 at 02:21:11AM -0800, Rudraksha Gupta wrote:
> On 12/16/25 06:41, Christian Schrefl wrote:
> > On 12/14/25 12:54 AM, Rudraksha Gupta wrote:
> > > Hello all,
> > > 
> > > 
> > > I have the following problem: https://gitlab.postmarketos.org/postmarketOS/pmbootstrap/-/issues/2635
> > > 
> > > 
> > > In short, what is happening is the following:
> > > 
> > > 
> > > - The kernel boots and outputs via UART when I build the kernel with the following:
> > > 
> > > make LLVM=1 ARCH="$arm" CC="${CC:-gcc}"
> > > 
> > > 
> > > - The kernel doesn't boot and there is no output via UART when I build the kernel with the following:
> > > 
> > > make LLVM=1 ARCH="$arm"
> > > 
> > > 
> > > The only difference being: CC="${CC:-gcc}". Is this expected? I think this was present in the Linux kernel ever since Rust was enabled for ARMv7, and I never encountered it because postmarketOS was originally building the first way.
> > 
> > I've managed to the get the build setup for qemu-armv7. For some reason
> > I could not get past the initrd even on kernels that are supposed to work,
> > but I think that is unrelated (and not a kernel issue).
> 
> Yep, I just got qemu-arm working to drop into a debug shell for now. I have
> to look into why other things aren't behaving nicely (but that's a problem
> for later me :P). For now, it seems to demonstrate the problem nicely:
> 
> https://gitlab.postmarketos.org/postmarketOS/pmbootstrap/-/issues/2635#note_521740
> 
> 
> > On the linux-next kernel I didn't get any output on the console from qemu so I
> > think I've reproduced the issue. Changing CONFIG_RUST=n did not change the behavior.
> > 
> > So I this is almost certainly a LLVM/clang issue and not a Rust issue. I'll try to
> > do a bit more digging, but I'm not sure how much I'll get done.
> 
> Did a little more testing in addition to the testing in the gitlab issue
> mentioned above:
> 
> - Removed Rust configs from linux-next/pmos.config -> didn't boot on
> qemu-arm and my phone
> 
> - Then I removed Rust dependencies from linux-next/APKBUILD -> didn't boot
> on qemu-arm and my phone
> 
> - used linux-stable instead of linux-next -> booted on qemu-arm to a debug
> shell
> 
> linux-stable is built via gcc:
> https://gitlab.alpinelinux.org/alpine/aports/-/blob/master/community/linux-stable/APKBUILD#L179
> 
> linux-next is built via clang:
> https://gitlab.postmarketos.org/postmarketOS/pmaports/-/blob/master/device/testing/linux-next/APKBUILD#L68

It certainly seems like LLVM / clang is a factor here based on the fact
that LLVM binutils were being used with GCC based on the original report
using 'LLVM=1 CC=gcc'. A few additional ideas for narrowing this down:

  * Does this reproduce with GNU binutils + clang (i.e.,
    CROSS_COMPILE=... CC=clang)? This would further confirm that clang
    is the cuplrit since GNU binutils and GCC are confirmed working with
    linux-stable, correct?

  * Does this reproduce when linux-stable is built with clang / LLVM=1?
    This would rule out a -next specific regression as well as allow
    diffing the linux-stable GCC configuration with the clang
    configuration to see if there are any configurations that get
    enabled only with clang, which could be another reason no issue is
    seen with GCC.

  * Our continuous integration boot tests several ARM configurations in
    QEMU, including Alpine Linux's:

    https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/20379046102/job/58575229973

    So it is possible that a postmarketOS configuration option
    introduces this?

The results of that testing might give us a more obvious direction to go
for troubleshooting, especially since this appears to reproduce in QEMU,
which should make debugging in gdb possible.

Also, what version of clang is this?

Cheers,
Nathan

