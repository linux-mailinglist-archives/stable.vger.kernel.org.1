Return-Path: <stable+bounces-67747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B85952AE7
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 10:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032461C2133D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 08:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9FD1AED52;
	Thu, 15 Aug 2024 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ein1RbFd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E226717625E;
	Thu, 15 Aug 2024 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710140; cv=none; b=YRFmL+5S7GFCAFiOUNsZhsODik49HnDFT159vWLP9Bz/WoRVbDUaOxBt0yOYaHOUX3Kx2LSkGfq3qej7irGT6a3s2J2OPaXrCYludG3q97PUx8EwHrpu193bV05Vj2I18K2+6pwD6Ts6gVCzLvRlgXsNeFnhVHizTi8AokuyCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710140; c=relaxed/simple;
	bh=8KRb+FzFzuh+a8cFQJg8U/5W8v8p3+oLbqlARzXcDuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/dQlh8BBSMO/RZHiNm+1svgeYwzkGmKaSUhxxcM4IDWB5vhub3GebyBi/w/T6fNdDVvXL2zPxJXpg47RpAm5fpJncUng4AE4pIwrXdC7BZfciErsvB4wGNhfclAsrfsc5cO6VpS+5QYAG4nCQ9eeT+MG9p+2Rxlqhsjkj9nK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ein1RbFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DF1C32786;
	Thu, 15 Aug 2024 08:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723710139;
	bh=8KRb+FzFzuh+a8cFQJg8U/5W8v8p3+oLbqlARzXcDuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ein1RbFdiNIjgtbL9IPns94n5kybDo7kop73QOwY2Y8D7JY3DGiaDbr3EjxBu7gAm
	 dUw4ViJjoefOFBO8TaQPp1xpDSR7IdQASmR8AJH4Z7JpAzVWWB0VBNFlE0OQjisRNG
	 /nc2Fr9RP/eD02bWnAXv4LzcD48A4Z/mJhi6YGi8=
Date: Thu, 15 Aug 2024 10:22:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH for-stable] LoongArch: Define __ARCH_WANT_NEW_STAT in
 unistd.h
Message-ID: <2024081509-hurry-subsonic-466d@gregkh>
References: <CAAhV-H6vXEaJf9NO9Lqh0xKoFAehtOOOLQVO4j5v+_tD7oKEXQ@mail.gmail.com>
 <20240730022542.3553255-1-chenhuacai@loongson.cn>
 <2024073059-hamstring-verbalize-91df@gregkh>
 <CAAhV-H7W-Ygn6tXySrip4k3P5xVbVf7GpjOzjXfQvCCbA4r5Wg@mail.gmail.com>
 <2024081126-blubber-flaky-8219@gregkh>
 <5aa26f6b0365ebf6b7e3c5b3d1c0a345b46431d3.camel@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5aa26f6b0365ebf6b7e3c5b3d1c0a345b46431d3.camel@xry111.site>

On Wed, Aug 14, 2024 at 05:18:29PM +0800, Xi Ruoyao wrote:
> On Sun, 2024-08-11 at 17:42 +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jul 31, 2024 at 09:06:56AM +0800, Huacai Chen wrote:
> > > On Tue, Jul 30, 2024 at 10:24 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > On Tue, Jul 30, 2024 at 10:25:42AM +0800, Huacai Chen wrote:
> > > > > Chromium sandbox apparently wants to deny statx [1] so it could properly
> > > > > inspect arguments after the sandboxed process later falls back to fstat.
> > > > > Because there's currently not a "fd-only" version of statx, so that the
> > > > > sandbox has no way to ensure the path argument is empty without being
> > > > > able to peek into the sandboxed process's memory. For architectures able
> > > > > to do newfstatat though, glibc falls back to newfstatat after getting
> > > > > -ENOSYS for statx, then the respective SIGSYS handler [2] takes care of
> > > > > inspecting the path argument, transforming allowed newfstatat's into
> > > > > fstat instead which is allowed and has the same type of return value.
> > > > > 
> > > > > But, as LoongArch is the first architecture to not have fstat nor
> > > > > newfstatat, the LoongArch glibc does not attempt falling back at all
> > > > > when it gets -ENOSYS for statx -- and you see the problem there!
> > > > > 
> > > > > Actually, back when the LoongArch port was under review, people were
> > > > > aware of the same problem with sandboxing clone3 [3], so clone was
> > > > > eventually kept. Unfortunately it seemed at that time no one had noticed
> > > > > statx, so besides restoring fstat/newfstatat to LoongArch uapi (and
> > > > > postponing the problem further), it seems inevitable that we would need
> > > > > to tackle seccomp deep argument inspection.
> > > > > 
> > > > > However, this is obviously a decision that shouldn't be taken lightly,
> > > > > so we just restore fstat/newfstatat by defining __ARCH_WANT_NEW_STAT
> > > > > in unistd.h. This is the simplest solution for now, and so we hope the
> > > > > community will tackle the long-standing problem of seccomp deep argument
> > > > > inspection in the future [4][5].
> > > > > 
> > > > > More infomation please reading this thread [6].
> > > > > 
> > > > > [1] https://chromium-review.googlesource.com/c/chromium/src/+/2823150
> > > > > [2] https://chromium.googlesource.com/chromium/src/sandbox/+/c085b51940bd/linux/seccomp-bpf-helpers/sigsys_handlers.cc#355
> > > > > [3] https://lore.kernel.org/linux-arch/20220511211231.GG7074@brightrain.aerifal.cx/
> > > > > [4] https://lwn.net/Articles/799557/
> > > > > [5] https://lpc.events/event/4/contributions/560/attachments/397/640/deep-arg-inspection.pdf
> > > > > [6] https://lore.kernel.org/loongarch/20240226-granit-seilschaft-eccc2433014d@brauner/T/#t
> > > > > 
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > ---
> > > > >  arch/loongarch/include/uapi/asm/unistd.h | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
> > > > > index fcb668984f03..b344b1f91715 100644
> > > > > --- a/arch/loongarch/include/uapi/asm/unistd.h
> > > > > +++ b/arch/loongarch/include/uapi/asm/unistd.h
> > > > > @@ -1,4 +1,5 @@
> > > > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > > +#define __ARCH_WANT_NEW_STAT
> > > > >  #define __ARCH_WANT_SYS_CLONE
> > > > >  #define __ARCH_WANT_SYS_CLONE3
> > > > > 
> > > > > --
> > > > > 2.43.5
> > > > > 
> > > > > 
> > > > 
> > > > What kernel branch(s) is this for?
> > > For 6.1~6.10.
> > 
> > What is the git id of this change in Linus's tree?
> 
> https://git.kernel.org/torvalds/c/7697a0fe0154

Thanks, now queued up.

greg k-h

