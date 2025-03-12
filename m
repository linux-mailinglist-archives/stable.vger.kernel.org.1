Return-Path: <stable+bounces-124125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C1A5D7A4
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 08:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E827A48FD
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153922D7BB;
	Wed, 12 Mar 2025 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY8CV2/f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDBE22D7A3
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766106; cv=none; b=d5cusMUZkU//3QWo63rwN4d6cZVtznXzNyAm4JcrLIU44Dmj2bj59jCWhZo3LdfzAenVBMT4lB6nJ5uZoaDXxV5hiAZfBk/mmfxTHnrOE98YxARHY24pnnmTqX9mb8hx7QXBx3NqGHa1rObtmb3lm+eqDIXxoaW4QSmbizps+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766106; c=relaxed/simple;
	bh=h2yszBlft9w0W0lfus/BAbnguOtEljz4K6kpAn+dE70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtvkDNTE8+fxDWSlGxOKnz4y+//2GN0NRtXjxPsZoixTAXjb97COsi9jFmdowEkoLY52aD1rWfG5dmD+hUOKnAScfiGSoCxjrcjjjCmQYep+HzB20ZOhnNvq/Dx+M1wiM5/mVfnOqwJmIXnCk+0YtxbBmbfqe0mmF5BoZrJ1/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY8CV2/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83F9C4CEED
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 07:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741766105;
	bh=h2yszBlft9w0W0lfus/BAbnguOtEljz4K6kpAn+dE70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AY8CV2/fMlIHAexCGnBZw4yj3ipiYhHku/2qLmxQwQ7r0dvTcqD5xTDL4EJsmcYYF
	 jFrmBauXiq9FzheLF2gTgPiEDo+6GOyY6wNS6pGoT702eohXpVFGvXvxJGkMhmysG6
	 f8ZtljS4C/FL6fe8LrIliQ9oBDpkX3i1jbaToUNIS41t3dCUQzs2k5X/61vELANECE
	 Z9sF3xZjlsHI//mvtF3BRTQye3LxoBSfSU0FWB5Wpfy+4xidOxzq4rllKEw6BiJ3c/
	 cFXjm9vUYNPfXPiOkl+hU0zJNGQ69magRogteRLgjmkZ/HLMsQoN/JGHu1iYPgydbG
	 MGYAVwdpbnBGQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so50373091fa.2
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 00:55:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXy6agoPk2jXxX3Ev+2a2EeoJSaNvBIy/ROOSa1AO/VL2RaVfF2zUhTbisOH/A4gio5kyRB6j0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7MD2BL6C3wZfPEknNqzxTyUpd3Zubu0gxTWZAAAmxyA9sBiA6
	Dg0V9imyNQgO/chuaxuXk6A7SWab1DkpkwSvkGLyjoj0Ekzc5gnR4jQ1rJs4lVmagAjC3jYyDOa
	rIJaBgQfYVTmN68szQLvwrDieAL8=
X-Google-Smtp-Source: AGHT+IFQ9XrHjp2gqV9ob8Y0l00i8VsXk764ENJISMUi1IJeoLCF6/rUtyL/LZti+kXAsAL+VHMhtP1EVbAQVf89W4w=
X-Received: by 2002:a2e:a78a:0:b0:30c:2e21:9958 with SMTP id
 38308e7fff4ca-30c2e219ca6mr10528511fa.32.1741766104260; Wed, 12 Mar 2025
 00:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213142440.609878115@linuxfoundation.org> <20250213142444.044525855@linuxfoundation.org>
 <c4a1af46f7edcdf20274e384ec3b48781a350aaa.camel@infradead.org> <2025031203-scoring-overpass-0e1a@gregkh>
In-Reply-To: <2025031203-scoring-overpass-0e1a@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 12 Mar 2025 08:54:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH6oWVkUeU6+JYCuarzc5+AQxfyBzehfmLFRdKXg86qaA@mail.gmail.com>
X-Gm-Features: AQ5f1Jpdj6vU0gsVURehdCeS-elQRRDPafyIXk8k4SqEihBGm8ZJNnumXX6NTzQ
Message-ID: <CAMj1kXH6oWVkUeU6+JYCuarzc5+AQxfyBzehfmLFRdKXg86qaA@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH 6.13 089/443] x86/kexec: Allocate PGD for
 x86_64 transition page tables separately
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>, stable@vger.kernel.org, patches@lists.linux.dev, 
	Ingo Molnar <mingo@kernel.org>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Mar 2025 at 08:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 11, 2025 at 04:45:26PM +0100, David Woodhouse wrote:
> > On Thu, 2025-02-13 at 15:24 +0100, Greg Kroah-Hartman wrote:
> > > 6.13-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > >
> > > [ Upstream commit 4b5bc2ec9a239bce261ffeafdd63571134102323 ]
> > >
> > > Now that the following fix:
> > >
> > >   d0ceea662d45 ("x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page tables")
> > >
> > > stops kernel_ident_mapping_init() from scribbling over the end of a
> > > 4KiB PGD by assuming the following 4KiB will be a userspace PGD,
> > > there's no good reason for the kexec PGD to be part of a single
> > > 8KiB allocation with the control_code_page.
> > >
> > > ( It's not clear that that was the reason for x86_64 kexec doing it that
> > >   way in the first place either; there were no comments to that effect and
> > >   it seems to have been the case even before PTI came along. It looks like
> > >   it was just a happy accident which prevented memory corruption on kexec. )
> > >
> > > Either way, it definitely isn't needed now. Just allocate the PGD
> > > separately on x86_64, like i386 already does.
> >
> > No objection (which is just as well given how late I am in replying)
> > but I'm just not sure *why*. This doesn't fix a real bug; it's just a
> > cleanup.
> >
> > Does this mean I should have written my original commit message better,
> > to make it clearer that this *isn't* a bugfix?
>
> Yes, that's why it was picked up.
>

The patch has no fixes: tag and no cc:stable. The burden shouldn't be
on the patch author to sprinkle enough of the right keywords over the
commit log to convince the bot that this is not a suitable stable
candidate, just because it happens to apply without conflicts.

