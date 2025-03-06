Return-Path: <stable+bounces-121283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F25A5526D
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 18:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857AB188E62C
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7B7214A61;
	Thu,  6 Mar 2025 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF5U4w4r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F31FC7F9
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280843; cv=none; b=l7D5cxvsoGu5dCbHPa3Az2CzpDzCiCuHTK+DWfD09RNpATriQWASXSPQm3teO0eoKghNTMPbDtafmAH9EpNVm0NUr86MemKYxBx74/lP11wBD59Fuk4Ae10ETqdRXho64Zgr81h7VhT97mLgGiD8W7SOLyLD2I/kUta0Eydvt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280843; c=relaxed/simple;
	bh=dnNOlL8mvPcZAA/vHd86pBB8fPux64AxqXnGaXwTBdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfrT/xmZKZOFOyyQwS1sE/9ZahBfMvJw6rdMnkkavGDuA9RPwUIBiGqQ1wSgUdfg5LhOAehidDi1ygwCSbO7qNzZvdZZVtKj/s//PRi6fJgMpMhr7P0G3Hb9MWm3g5w2yscSQCR0G6IStRr+pgMrN5XM1cN4hzMVfzInxtZamBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF5U4w4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D433FC4AF09
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 17:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741280842;
	bh=dnNOlL8mvPcZAA/vHd86pBB8fPux64AxqXnGaXwTBdA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LF5U4w4rOuGiEXt8aznMpfBgKfkqGIPgazaPrN/c7p2KbTUUpvMhxTM+0kztecGrr
	 q6XP0d1KFQL8gHXRBydc4amWU14Bfx0rqf/YvJa13G7Hfcv7DXOvOkGvWBY3RMJvsV
	 2TJryQ0j9qYLqeLRdxU4IVf3O/6vTHjxYHgGgi24IyGy/v2fGiEjHPf7O4s87Rj0up
	 xSi2lPhgefOXEUPYE55vF5H4WxfL9P3ZubVctXT2QiSa8sSOdFknjIIxFHnqFTyluE
	 iVpo8oko7zBRE+MFNSqn6mOwYFaY8LMPFplWoFfD1TeqKyHKIpklfQiLDTsSY9PwnY
	 Ftqj2YfAmkAHw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30b936ffc51so7378301fa.2
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 09:07:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7yOtgvLXLYngfN+WZRz5X/VNmMAwx9DcRwzwDtsqo1oHgBYk+ftUEfWNXspdJ6+VO9cXrIIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSWVjGaWSpistjSBFNDCqoF2OadeNSXe9OyeOvwFWVq9odvN1M
	g7NEVuZ268cRUZUn7Zk32jT/edmTn8JbD36bfRy0SGdUi1nUsm3qLYQS+SIy/kTwsgC1i9Zn3lv
	XIILIWwIaaIlPicbJ0MeTFHzyBiE=
X-Google-Smtp-Source: AGHT+IE0Bzi3sAhf8iQFVGo/I+4OXDTB7k8CB8TyUHH8xO365g+r9EQUsuVIv+ycxeZ5wuL8R5wpmq5Cka8R0a623ZU=
X-Received: by 2002:a2e:a7ca:0:b0:30b:af47:6477 with SMTP id
 38308e7fff4ca-30bd7ae0c66mr35425381fa.25.1741280841045; Thu, 06 Mar 2025
 09:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202503041549.35913.ulrich.gemkow@ikr.uni-stuttgart.de>
 <87AE5E2B-4BD4-468E-ABD5-6E717FE925EE@zytor.com> <CAMj1kXFuC2_J9wUuJ-GnRRSBN6C2YbahxJ9PD9X26TX+smhBgA@mail.gmail.com>
 <202503061750.16147.ulrich.gemkow@ikr.uni-stuttgart.de>
In-Reply-To: <202503061750.16147.ulrich.gemkow@ikr.uni-stuttgart.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 6 Mar 2025 18:07:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFV+reviujfEEZSW5HDJjbOyuVSccoVWLf73hqBLxf4mA@mail.gmail.com>
X-Gm-Features: AQ5f1JrixDu6pR8Et_tu-m-1q0JL56YqzSuiwVqC5KWtNJcQHuIrjIdxS2NpSjU
Message-ID: <CAMj1kXFV+reviujfEEZSW5HDJjbOyuVSccoVWLf73hqBLxf4mA@mail.gmail.com>
Subject: Re: Regression for PXE boot from patch "Remove the 'bugger off'
 message" in stable 6.6.18
To: Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 17:50, Ulrich Gemkow
<ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
>
> On Thursday 06 March 2025, Ard Biesheuvel wrote:
> > On Thu, 6 Mar 2025 at 16:23, H. Peter Anvin <hpa@zytor.com> wrote:
> > >
> > > On March 6, 2025 6:44:11 AM PST, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >On Thu, 6 Mar 2025 at 15:39, H. Peter Anvin <hpa@zytor.com> wrote:
> > > >>
> > > >> On March 6, 2025 6:36:04 AM PST, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >> >(cc Peter)
> > > >> >
> > > >> >
> > > >> >I managed to track this down to a bug in syslinux, fixed by the hunk
> > > >> >below. The problem is that syslinux violates the x86 boot protocol,
> > > >> >which stipulates that the setup header (starting at 0x1f1 bytes into
> > > >> >the bzImage) must be copied into a zeroed boot_params structure, but
> > > >> >it also copies the preceding bytes, which could be any value, as they
> > > >> >overlap with the PE/COFF header or other header data. This produces a
> > > >> >command line pointer with garbage in the top 32 bits, resulting in an
> > > >> >early crash.
> > > >> >
> > ...
> > > >>
> > > >> Interesting. Embarrassing, first of all :) but also interesting, because this is exactly why we have the "sentinel" field at 0x1f0 to catch *this specific error* and work around it.
> > > >
> > > >We're crashing way earlier than the sentinel check - the bogus command
> > > >line pointer is dereferenced via
> > > >
> > > >startup_64()
> > > >  configure_5level_paging()
> > > >    cmdline_find_option_bool()
> > > >
> > > >whereas sanitize_bootparams() is only called much later, from extract_kernel().
> > >
> > > That is a bug in the kernel then. The whole point of the sentinel check is that it needs to be done before any of the fields touched by the sentinel check are accessed.
> >
> > Indeed - I have just sent out a fix for this.
> >
>
> Hello Ard,
>
> thanks for the patch! It does not apply cleanly to 6.6.80 (the includes
> are different) so I applied it manually and it helps - the systems boots.
>
> Please allow the remark regarding the patch description that in
> our kernel CONFIG_X86_5LEVEL is not set. The patch helps anyway :-)
>
> Thanks again and best regards
>

Thanks for testing. I will take this as a Tested-by.

