Return-Path: <stable+bounces-66371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114BB94E1F4
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 17:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD20528157F
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B5C14B94E;
	Sun, 11 Aug 2024 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c9W9TuGV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB322615;
	Sun, 11 Aug 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723390974; cv=none; b=ljiGA6TD4eK9Wt2sIL9l5P1UC2p9gEbNZI+uk+IzAZM5VMF7Pi/Pu5vD6HzmX3Yf3tY6TKmdVN6SZR65d0Ps3ecqlaxU8gX1O4OI0WQn2yQh7w7lqek4WHaiN8eJUv0s4Vjt/byLMIhZrrlyVnULZHhcyJ9CUmxodF5UCTNCIzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723390974; c=relaxed/simple;
	bh=RfN2eLdQYRcxLEXUx5OMX2Hcrwqp3yedHcg9gDMAwX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4LDnZTg5P+zjRlWj05jIoFcjBf7rAnkjwZtSngieCbQBYrSygoglsOn+K6fd/qIDs7/2xUi+/LDz+nM46Y3Cbk2NVCmzAcU1dsR7i0DnPbQ56IGDkv4o022/Pfjh3rqnvms+yPDXdzLO3QEq0X1BZcISdzftdYeQ/HmyxplXCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c9W9TuGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4EAC32786;
	Sun, 11 Aug 2024 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723390973;
	bh=RfN2eLdQYRcxLEXUx5OMX2Hcrwqp3yedHcg9gDMAwX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c9W9TuGVjiUm39yj8GR4B27ohrI0cnV6wJgwMzUtZvbxvTquGT0cwTpRXbNJPWr37
	 ax6do0qnFkBgI1GVYuookdY/hdtekFeHzeTNOEKtlLhBpDSCMi490Ddn2GtdGWTLOU
	 khnn1saCJtLs3H184XYPpZSKiUiFaKTlLPBflT7c=
Date: Sun, 11 Aug 2024 17:42:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH for-stable] LoongArch: Define __ARCH_WANT_NEW_STAT in
 unistd.h
Message-ID: <2024081126-blubber-flaky-8219@gregkh>
References: <CAAhV-H6vXEaJf9NO9Lqh0xKoFAehtOOOLQVO4j5v+_tD7oKEXQ@mail.gmail.com>
 <20240730022542.3553255-1-chenhuacai@loongson.cn>
 <2024073059-hamstring-verbalize-91df@gregkh>
 <CAAhV-H7W-Ygn6tXySrip4k3P5xVbVf7GpjOzjXfQvCCbA4r5Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7W-Ygn6tXySrip4k3P5xVbVf7GpjOzjXfQvCCbA4r5Wg@mail.gmail.com>

On Wed, Jul 31, 2024 at 09:06:56AM +0800, Huacai Chen wrote:
> On Tue, Jul 30, 2024 at 10:24 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jul 30, 2024 at 10:25:42AM +0800, Huacai Chen wrote:
> > > Chromium sandbox apparently wants to deny statx [1] so it could properly
> > > inspect arguments after the sandboxed process later falls back to fstat.
> > > Because there's currently not a "fd-only" version of statx, so that the
> > > sandbox has no way to ensure the path argument is empty without being
> > > able to peek into the sandboxed process's memory. For architectures able
> > > to do newfstatat though, glibc falls back to newfstatat after getting
> > > -ENOSYS for statx, then the respective SIGSYS handler [2] takes care of
> > > inspecting the path argument, transforming allowed newfstatat's into
> > > fstat instead which is allowed and has the same type of return value.
> > >
> > > But, as LoongArch is the first architecture to not have fstat nor
> > > newfstatat, the LoongArch glibc does not attempt falling back at all
> > > when it gets -ENOSYS for statx -- and you see the problem there!
> > >
> > > Actually, back when the LoongArch port was under review, people were
> > > aware of the same problem with sandboxing clone3 [3], so clone was
> > > eventually kept. Unfortunately it seemed at that time no one had noticed
> > > statx, so besides restoring fstat/newfstatat to LoongArch uapi (and
> > > postponing the problem further), it seems inevitable that we would need
> > > to tackle seccomp deep argument inspection.
> > >
> > > However, this is obviously a decision that shouldn't be taken lightly,
> > > so we just restore fstat/newfstatat by defining __ARCH_WANT_NEW_STAT
> > > in unistd.h. This is the simplest solution for now, and so we hope the
> > > community will tackle the long-standing problem of seccomp deep argument
> > > inspection in the future [4][5].
> > >
> > > More infomation please reading this thread [6].
> > >
> > > [1] https://chromium-review.googlesource.com/c/chromium/src/+/2823150
> > > [2] https://chromium.googlesource.com/chromium/src/sandbox/+/c085b51940bd/linux/seccomp-bpf-helpers/sigsys_handlers.cc#355
> > > [3] https://lore.kernel.org/linux-arch/20220511211231.GG7074@brightrain.aerifal.cx/
> > > [4] https://lwn.net/Articles/799557/
> > > [5] https://lpc.events/event/4/contributions/560/attachments/397/640/deep-arg-inspection.pdf
> > > [6] https://lore.kernel.org/loongarch/20240226-granit-seilschaft-eccc2433014d@brauner/T/#t
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  arch/loongarch/include/uapi/asm/unistd.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
> > > index fcb668984f03..b344b1f91715 100644
> > > --- a/arch/loongarch/include/uapi/asm/unistd.h
> > > +++ b/arch/loongarch/include/uapi/asm/unistd.h
> > > @@ -1,4 +1,5 @@
> > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +#define __ARCH_WANT_NEW_STAT
> > >  #define __ARCH_WANT_SYS_CLONE
> > >  #define __ARCH_WANT_SYS_CLONE3
> > >
> > > --
> > > 2.43.5
> > >
> > >
> >
> > What kernel branch(s) is this for?
> For 6.1~6.10.

What is the git id of this change in Linus's tree?

