Return-Path: <stable+bounces-198044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBB5C9A67A
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 08:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3579D3A5853
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 07:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48BA25BEE7;
	Tue,  2 Dec 2025 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH/XHFeJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB2235BE2
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764659801; cv=none; b=e5dramdZquLVYR4GYRaOfvy0TK+jG0SgsCswLudghLwE5exBhR5OZ4MrtxII0B/6eGFQUy2OD6dvEqF6kHEF4/RgJtppbH19g9CmlBS4yHR4u6ZtnAD3JF7KTfHqgXqbwQvHHFI39BbA5+UUPPKEOD+KJR9mVjmCgkh07sbL9J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764659801; c=relaxed/simple;
	bh=ajNmAI0/hLMLxffqgQqqEZ1nTloLsumG92ItI9rfcXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idX9uDZBki5mfSxlzox44VIAYVs0bOB6ygiX1Y7ShwqygWd/BkDGeNxmQgAFe8xh+CLDNlHvRh+PzOdcH5yZns763p9wIzqb7ixUeLF6GCHTujyDKnjnR+W9Bx6tMU6X0t8pUnh5a2mBdvUwi4UUK9JTYKxwwlEhLTWjFKnmwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH/XHFeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C9FC2BCB7
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 07:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764659800;
	bh=ajNmAI0/hLMLxffqgQqqEZ1nTloLsumG92ItI9rfcXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FH/XHFeJvv4FBdEUheK+LH0B/ovibOmSi+9UgH9MxokV6jEaLprnt1tHVYbH2HwVF
	 fVHymn8zRYW9obg2qbVSadJ7x6RpYPMqjtrDERFIo9U76vyF0ghyEG3Pi3zs5Aa6RJ
	 2YUKnXaT5Mlcp6Pcl+xZyjkYZ5VFlR5+nC2VzuQUV/iHNGiB2HLtcM8XL3i2DCM/Us
	 46uJatRsyZjc1k3EiuETwfGNNDu8RI7i7vqsDqr0QyajOuv7T6Nuy7T/ya3902nD3R
	 njivHp5FWmEv8XGUHF7IMdax2fGuNMTjnWT8g2ueBho1o61WAv/PH+qteF7g23slkw
	 rWnUyqtK1FfBw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37a5bc6b491so43704211fa.0
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 23:16:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1VdWzfwmdaNR9UqotOrtV+b/JZrJ6IcrTtYuBicSZyc7Q6ogxP5FGunxh2SIv5vyno2rggUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNIE3EEntqXNqsMAlXTShpRrv2cPt4JzJbOcQUppB9JZw0citb
	1q6t05Y3p4py6NQbTZ1RQNtPnpRx1KOAzJqEiICiqQwQd+vXaWCTmKVOw+LNA6rhFininTCT8l+
	G4MQ91oAYK9WWRbJukP/XJw+XPYeVHHU=
X-Google-Smtp-Source: AGHT+IGjWNAb2K1nr+M2VaTdxOnuW5ebX9Qlf6W3A2Li50jpG7K8sq/QCKj0ZGG7uo09diGP1GNpDFcv9q21yFJixf8=
X-Received: by 2002:a05:651c:4087:b0:372:8962:d06d with SMTP id
 38308e7fff4ca-37cd928a64fmr99595351fa.40.1764659798987; Mon, 01 Dec 2025
 23:16:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com>
 <633a35b8-207b-4494-9a4e-24706abd3990@oracle.com> <ec3c1b29004d1be28563b20765d6a06ccdf18db5.camel@linux.ibm.com>
In-Reply-To: <ec3c1b29004d1be28563b20765d6a06ccdf18db5.camel@linux.ibm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 2 Dec 2025 08:16:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFDAypcEAAFw=O6pS5zD5aujXUvo3_95p_2fJiESsSmgQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmrHN5z09X-iJvUrNNXF_5_Z6SMZHPdE1hM5gTYHvzO1prTVvbNUyJLFHk
Message-ID: <CAMj1kXFDAypcEAAFw=O6pS5zD5aujXUvo3_95p_2fJiESsSmgQ@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: Add a sanity check on previous kernel's ima
 kexec buffer
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, henry.willard@oracle.com, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Jiri Bohac <jbohac@suse.cz>, 
	Sourabh Jain <sourabhjain@linux.ibm.com>, Guo Weikang <guoweikang.kernel@gmail.com>, 
	Joel Granados <joel.granados@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Sohil Mehta <sohil.mehta@intel.com>, Jonathan McDowell <noodles@fb.com>, linux-kernel@vger.kernel.org, 
	yifei.l.liu@oracle.com, stable@vger.kernel.org, 
	Paul Webb <paul.x.webb@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Dec 2025 at 22:43, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Mon, 2025-12-01 at 15:03 +0530, Harshit Mogalapalli wrote:
> > Hi all,
> >
> > On 13/11/25 01:00, Harshit Mogalapalli wrote:
> > > When the second-stage kernel is booted via kexec with a limiting comm=
and
> > > line such as "mem=3D<size>", the physical range that contains the car=
ried
> > > over IMA measurement list may fall outside the truncated RAM leading =
to
> > > a kernel panic.
> > >
> > >      BUG: unable to handle page fault for address: ffff97793ff47000
> > >      RIP: ima_restore_measurement_list+0xdc/0x45a
> > >      #PF: error_code(0x0000) =E2=80=93 not-present page
> > >
> > > Other architectures already validate the range with page_is_ram(), as
> > > done in commit: cbf9c4b9617b ("of: check previous kernel's
> > > ima-kexec-buffer against memory bounds") do a similar check on x86.
>
> It should be obvious that without carrying the measurement list across ke=
xec,
> that attestation will fail.  Please mentioned it here in the patch descri=
ption.
>

Couldn't we just use memremap() and be done with it? That will use the
direct map if the memory is mapped, or vmap() it otherwise.

