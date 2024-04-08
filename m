Return-Path: <stable+bounces-36817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A27689C1E7
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3105F282CFB
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3BE7BAEE;
	Mon,  8 Apr 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au73L72x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10268481A6
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582432; cv=none; b=HC5J+soM56ngYCdUJKDeD+1YAW3x+UEGRgONiJtX8tq8sT0aDah4fjgEw1bMbS5Hoyvwzi3kgDphKjvb5zW+5K2O+aB+WczAjaVl+rK+kBfBqCip4gR7//8ZkeqGVmyt8+Ohf6MprQx8xYSYTM46VbtVaD2uKBa7YZl50maVqLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582432; c=relaxed/simple;
	bh=1z2i3BE68ouyOJHQBpCHofgXL5QrkRfPv3zh2ryeuxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXrP+3/1tkFS1X0ioy3SKrvQAbALhu3+zMzJJhX7FE4KFdf8JB7SeroBrTwzuGb3755DZOGFQuqhN7QmHtPBsoDGr6gQouUqcyDmrPtsnJyH5WP/j1EDHiuQrmu7etZH+A4au33KNHnG29cNVTc13SlziQFLrRFUM0AHKXeHEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au73L72x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F60DC43390
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 13:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712582430;
	bh=1z2i3BE68ouyOJHQBpCHofgXL5QrkRfPv3zh2ryeuxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Au73L72xynkbx+OD0JRlynEeX9D3sVFZE/fVx5qZ9XeHlHzrR7ze8KTuDO2ic4HfC
	 ttCR+bDOcSnKah80hREO3Zq49/lGslfRx+2l+qaG/bHyFOoFxZ6zU5IjoWK1kz2s8m
	 cio8wxf9AWDpm2QNtY084sv2AQuSrxTD51nGIQKIu4U8o+6NiwFowr/r5K4DRzw+0d
	 OOIfRzwahDKRN0iLJ7c3biCShOxUeNXfZHmIN71wTTW4K30tMmeUBdINZBBqwB1r6n
	 HxrOX+KWJJr8k4DZZSBxHodSnZOznUqquHlDJhPe3MziYKamuZ5UuGrwJurFEtwbdp
	 SKFscpb4hTLRA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d476d7972aso57763511fa.1
        for <stable@vger.kernel.org>; Mon, 08 Apr 2024 06:20:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpEKRrLQRYjIpKquphbDVVz0uT2oed2KVsDIUg/eVu9DbbBXfCzqW8QBs/8kwCBloqbdAuzl8bgyK+RQX+h7OKt2b1difV
X-Gm-Message-State: AOJu0Yz8e/7U4a2yjQsGUb2Db0qLhJA5oihJwu1/ha8DZg+GU7HzzNbH
	y8G+P7KeZay2zkDH/Bk/BvzPaM1BcGvXpfSp8x4zbimd9W+7Dpz2wFX2WIkWz96WIGchuXkRW8n
	lGSTSvNgdvQ3g01rgX9vzN04Q0jw=
X-Google-Smtp-Source: AGHT+IFVFZP1PoVr7nRIh/uhzGiwneEftnH2njOoxKpE4KZFD58hOBQA6YTDKjXhRPKynj7TWcSgRQO5c0c9qrVxTsk=
X-Received: by 2002:a2e:7d17:0:b0:2d8:3e07:5651 with SMTP id
 y23-20020a2e7d17000000b002d83e075651mr6745032ljc.34.1712582428981; Mon, 08
 Apr 2024 06:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408064917.3391405-8-ardb+git@google.com> <20240408064917.3391405-11-ardb+git@google.com>
 <2024040848-paging-jet-609e@gregkh>
In-Reply-To: <2024040848-paging-jet-609e@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 8 Apr 2024 15:20:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGmS=heQ3BoKXQHagmFE1uvdb+72wc_gR9wTRMwpODaew@mail.gmail.com>
Message-ID: <CAMj1kXGmS=heQ3BoKXQHagmFE1uvdb+72wc_gR9wTRMwpODaew@mail.gmail.com>
Subject: Re: [PATCH -for-stable-v6.6+ 3/6] x86/boot: Move mem_encrypt= parsing
 to the decompressor
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 14:37, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Apr 08, 2024 at 08:49:21AM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > [ Commit cd0d9d92c8bb46e77de62efd7df13069ddd61e7d upstream ]
> >
> > The early SME/SEV code parses the command line very early, in order to
> > decide whether or not memory encryption should be enabled, which needs
> > to occur even before the initial page tables are created.
> >
> > This is problematic for a number of reasons:
> > - this early code runs from the 1:1 mapping provided by the decompressor
> >   or firmware, which uses a different translation than the one assumed by
> >   the linker, and so the code needs to be built in a special way;
> > - parsing external input while the entire kernel image is still mapped
> >   writable is a bad idea in general, and really does not belong in
> >   security minded code;
> > - the current code ignores the built-in command line entirely (although
> >   this appears to be the case for the entire decompressor)
> >
> > Given that the decompressor/EFI stub is an intrinsic part of the x86
> > bootable kernel image, move the command line parsing there and out of
> > the core kernel. This removes the need to build lib/cmdline.o in a
> > special way, or to use RIP-relative LEA instructions in inline asm
> > blocks.
> >
> > This involves a new xloadflag in the setup header to indicate
> > that mem_encrypt=on appeared on the kernel command line.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
> > Link: https://lore.kernel.org/r/20240227151907.387873-17-ardb+git@google.com
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/misc.c         | 15 +++++++++
> >  arch/x86/include/uapi/asm/bootparam.h   |  1 +
> >  arch/x86/lib/Makefile                   | 13 --------
> >  arch/x86/mm/mem_encrypt_identity.c      | 32 ++------------------
> >  drivers/firmware/efi/libstub/x86-stub.c |  3 ++
> >  5 files changed, 22 insertions(+), 42 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> > index f711f2a85862..c6136a1be283 100644
> > --- a/arch/x86/boot/compressed/misc.c
> > +++ b/arch/x86/boot/compressed/misc.c
> > @@ -357,6 +357,19 @@ unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
> >       return entry;
> >  }
> >
> > +/*
> > + * Set the memory encryption xloadflag based on the mem_encrypt= command line
> > + * parameter, if provided.
> > + */
> > +static void parse_mem_encrypt(struct setup_header *hdr)
> > +{
> > +     int on = cmdline_find_option_bool("mem_encrypt=on");
> > +     int off = cmdline_find_option_bool("mem_encrypt=off");
> > +
> > +     if (on > off)
> > +             hdr->xloadflags |= XLF_MEM_ENCRYPTION;
> > +}
> > +
> >  /*
> >   * The compressed kernel image (ZO), has been moved so that its position
> >   * is against the end of the buffer used to hold the uncompressed kernel
> > @@ -387,6 +400,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
> >       /* Clear flags intended for solely in-kernel use. */
> >       boot_params->hdr.loadflags &= ~KASLR_FLAG;
> >
> > +     parse_mem_encrypt(&boot_params->hdr);
> > +
> >       sanitize_boot_params(boot_params);
> >
> >       if (boot_params->screen_info.orig_video_mode == 7) {
>
> This patch didn't apply on 6.6.y, so I applied it by hand, but it turns
> out there is no "boot_parms" on 6.6.y, so it breaks the build.
>

If you apply it by hand, it will be called boot_params_ptr, and that
indeed does not exist yet on 6.6.y. The patch accounts for that.

However, it is bizarre that this fails to apply, given that I
generated the patches from a tree based on 6.6.25. Does it conflict
with something else you have queued up?

> So I've dropped this one from the 6.6.y tree now, if you can submit it
> in a form that at least compiles, I'll take it :)
>

Happy to do so, but I'll need another base if 6.6.25 is not sufficient.

