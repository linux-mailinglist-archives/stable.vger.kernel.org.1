Return-Path: <stable+bounces-56338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CEB923AEB
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 11:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21B91F24403
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 09:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548E7158DC0;
	Tue,  2 Jul 2024 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n+WrJ0Vc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335D156F5D
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914205; cv=none; b=FYERSE5cJTboJ47kF7l334Rg1S0JdrY/KB6twVtvuBeHs1ipy/VIsQEr0rosE5KQhJajvtdMVihdYYU5ZtQwqx9wv425dh5whSsr8WZFJIYZp7s3ag/EcixTqyNaKnWexp6LTmby1CgrujPAgWFXMA8yvyv3t/Y7Xsilb6GcaIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914205; c=relaxed/simple;
	bh=RvXygVoyCYG11d6tmyOOXt+UMY0FLIqUPlJkvbsgXpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9YwOINdyO2yQXqL0uPHHmJeWgi22j/Zr6DuhUY8Q7iHCG08sdAsDVc7GG6CtHCeLDiTnyu+jUqcZNGlIQT8nt40C41Ca927bz5A357eOD4LlYGm1ULP8ozPRjVB47shUJNUyUqC9pgNlOPr85EWZWVjHiGbTLYEGQ0/brKyljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n+WrJ0Vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485FBC116B1;
	Tue,  2 Jul 2024 09:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719914204;
	bh=RvXygVoyCYG11d6tmyOOXt+UMY0FLIqUPlJkvbsgXpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+WrJ0VcAiiZNuhGGItd1lugWXfYdLdk8sjkzo34ijLCO3VhY1oKrbdh5mYB5kJAF
	 jCRA5mgsycnk3799AsX1cSFj5It0ZmgfZ/NxNO1hJ6PY8NTv/V6+ATWZ/6VS6Esbu9
	 gnXx51qkhSv0g2X8t8ZJzAP11C/ZhH9HgfeQm5ec=
Date: Tue, 2 Jul 2024 11:56:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ashish.Kalra@amd.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] efi/x86: Free EFI memory map only when
 installing a new one." failed to apply to 6.1-stable tree
Message-ID: <2024070229-molasses-jolly-6230@gregkh>
References: <2024062442-bonfire-detonator-1b17@gregkh>
 <CAMj1kXF5dosTmitMvCiYCb8Xo=+a23zrUd1F7cyWfpMFba0SXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF5dosTmitMvCiYCb8Xo=+a23zrUd1F7cyWfpMFba0SXg@mail.gmail.com>

On Sat, Jun 29, 2024 at 04:50:50PM +0200, Ard Biesheuvel wrote:
> On Mon, 24 Jun 2024 at 18:41, <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 75dde792d6f6c2d0af50278bd374bf0c512fe196
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062442-bonfire-detonator-1b17@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> >
> > Possible dependencies:
> >
> > 75dde792d6f6 ("efi/x86: Free EFI memory map only when installing a new one.")
> > d85e3e349407 ("efi: xen: Set EFI_PARAVIRT for Xen dom0 boot on all architectures")
> > fdc6d38d64a2 ("efi: memmap: Move manipulation routines into x86 arch tree")
> >
> 
> Please apply these dependencies (in reverse order) as stable
> prerequisites. I build and boot tested the result, and it works as
> expected.

That worked, thanks!

greg k-h

