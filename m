Return-Path: <stable+bounces-28232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D2687C96C
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 08:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19951C21585
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4AF14016;
	Fri, 15 Mar 2024 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUfPQ0HB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50215E86
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710488570; cv=none; b=hYYTffFFGq7Z3lux6obCeNP9x65JL78iR65FaYfObk7+e6TlRoR4HUjBOziMY9m3G2jCa9VceFsOQR4IdI4Wrshmbp38X6mKP6MN0rG80wtFFCz/ytUQLy7R18AWySrwnWZY7akPjmIUeoyqiUrRfSdR/G9rcmfFQm+a58+Q+EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710488570; c=relaxed/simple;
	bh=h/f5ESWWg1khulKlvhfC7njLq4tTvWTBE1YoW2cB7eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJh9qBIVN+ZjfnwqIkyZP5S+0Z4qmlO8Kgi2JBXQfd7rqilB5RFrsVvpme2c6U+FASjM7JK0Pf38ZD+ctFQySTVmTeSYvGJb0gtm49vFxrPgf+RSZJaBxBmZTteNxfv8bZtOBqWyrDyrkWv9rirIONnLklQAoLI7NzwrcDGIrhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUfPQ0HB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2738C433A6
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 07:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710488569;
	bh=h/f5ESWWg1khulKlvhfC7njLq4tTvWTBE1YoW2cB7eo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TUfPQ0HBwSR1dlUlcQchJQcTC+6p86wtSiasLFEh+MYdxon8OcdoeJAztVwus94G4
	 hKS0acLK4RV89kOESfzSIW7XbOCCcua3zDJHKxcteVvQOMA99RGt6H9wr+b3TpucYi
	 JOlS93pv0kaYfplbsBYymv4aXZbG8rOIU1OXyYwwNYnQfFY0NDXj6QeSCXg0OiwNfJ
	 T8+Lhvv68lXo+6VuMTFVBAEqb9amLZmZHvZ+mYoBVZ+xD5PpgS6gYdZc4qrfdjtTII
	 J8PCNJxcnfpw+qAJhRD9Gb+mtJp1KoKvXMLbtoad54L6qHm4XWsSQQ6jkjStC8Tsyx
	 3NO6pTGWlkcIA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513a6416058so2640691e87.1
        for <stable@vger.kernel.org>; Fri, 15 Mar 2024 00:42:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YzXeT3C8XkD1dCtaBESoouE37fcNm0JpxICN2lSaryUKg+pq4V/
	gHvURIT7VPyojpHHe4Q5hEEA3q7Du70QYQfnfPkdFtMRrB7w2AEapstkacA4RoJB7BFK5PwD2yt
	2P9WC+UkyzAdUDPvj1NTsV//7FjE=
X-Google-Smtp-Source: AGHT+IES/miE1OTdOQaIt2m+nRHWVXJyR72iEscXgrf4MHn9EJ5I0acml2jlSFbFC/73UB9a+npubGTuyBq2s7YptFU=
X-Received: by 2002:a19:7702:0:b0:513:d797:58a with SMTP id
 s2-20020a197702000000b00513d797058amr1086365lfc.26.1710488568220; Fri, 15 Mar
 2024 00:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz>
 <CAMj1kXF7gaaARdyN=bVuXtJb_S=-_ewAavXHgN4DS36jxK8r6A@mail.gmail.com> <CAMj1kXEo-y1DfY_kBhwGU0xMkGp1PhdqGFmw6ToLePiZy4YgZQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEo-y1DfY_kBhwGU0xMkGp1PhdqGFmw6ToLePiZy4YgZQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 08:42:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFmgba8HyZ-yO7MsQBgOGjM10hZKWESBbfrUcjdhq0XsQ@mail.gmail.com>
Message-ID: <CAMj1kXFmgba8HyZ-yO7MsQBgOGjM10hZKWESBbfrUcjdhq0XsQ@mail.gmail.com>
Subject: Re: [REGRESSION] linux 6.6.18 and later fails to boot with "initramfs
 unpacking failed: invalid magic at start of compressed archive"
To: Radek Podgorny <radek@podgorny.cz>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 22:53, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 14 Mar 2024 at 20:35, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 14 Mar 2024 at 19:32, Radek Podgorny <radek@podgorny.cz> wrote:
> > >
> > > hi,
> > >
> > > i seem to be the only one in the world to have this problem. :-(
> > >
> > > on one of my machines, updating to 6.6.18 and later (including mainline
> > > branch) leads to unbootable system. all other computers are unaffected.
> > >
> > > bisecting the history leads to:
> > >
> > > commit 8117961d98fb2d335ab6de2cad7afb8b6171f5fe
> > > Author: Ard Biesheuvel <ardb@kernel.org>
> > >
> >
> > Thanks for the report.
> >
> > I'd like to get to the bottom of this if we can.
> >
> > Please share as much information as you can about the system
> > - boot logs
> > - DMI data to identify the system and firmware etc
> > - distro version
> > - versions of boot components (shim, grub, systemd-boot, etc including
> > config files)
> > - other information that might help narrow this down.
>
> Also, please check whether the below change makes a difference or not
>
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -477,6 +477,8 @@
>                 efi_exit(handle, status);
>         }
>
> +       memset(&boot_params, 0, sizeof(boot_params));
> +
>         /* Assign the setup_header fields that the kernel actually
> cares about */
>         hdr->root_flags = 1;
>         hdr->vid_mode   = 0xffff;

Another thing you might try is reverting commit

commit 5f51c5d0e905608ba7be126737f7c84a793ae1aa
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Tue Sep 12 09:00:52 2023 +0000

    x86/efi: Drop EFI stub .bss from .data section

(in v6.6 the commit id is fa244085025f4a8fb38ec67af635aed04297758d)

