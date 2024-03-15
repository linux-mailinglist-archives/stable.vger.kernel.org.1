Return-Path: <stable+bounces-28254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A642987D0EE
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 17:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691C3283188
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF9444C8C;
	Fri, 15 Mar 2024 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9P9FQZj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E81773D
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518936; cv=none; b=Pplw79j1vHhWB5VwwsIZc3c/LMayAPF2enVXOWx+QPPvWY23ocx6zNRCk141cHgDPMUBCbyDJ2H4bwie+wS4VqEAoGoUwrStscKrdLe1ksBQWuF0IJp+EB65wjMjBblL6JeUpU227sJjs+KBx1so+VS2J6zSzqsNnNKg3jKxNkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518936; c=relaxed/simple;
	bh=9M3XqZdt8V8NmlB3k0EnwmzAtIFqWTwtKHnbQ/4+5IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTmEqUT+dhlOGrXZEhOcnrD8Qiqtf077H1wXLcJ2z+AqnjIn+bRWN+iVzUATkSNh6FzDZfY7vv/zgcWCy3wsXzKxAhgNPjeTJdJBdYzM3j0DVAxsgNALqCSQfbUkVM4Gam/rLoaWGi/SwPQusKf/mv/NOxKhrMQpiqFoJkd/goY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9P9FQZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA77C433F1
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 16:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710518935;
	bh=9M3XqZdt8V8NmlB3k0EnwmzAtIFqWTwtKHnbQ/4+5IQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i9P9FQZjLDlgjgrGmK8WRxBHV9WKfaBRGCuWVCczjkVGAhajur9livWnkp0pyBL0G
	 wYoxzCIUWOl9YHvm7dZrzmhowjG+/yOiuFWIu1YGXRLiU4tK/pcBKCLSq7/ODWusin
	 ffLE0vlx8a3jkusFc3cp+g3IFp2kfpXHuwoV9iSdWvYQFWpDT1NkFsE9oc61RfP+Ip
	 JXblOR7UYuJNLCjso3ZoYv1x6lYgGoJk3Dh+76GHGpSIJtzfNS7f5jn3Ja1CtgDYRQ
	 oVJZcev8AnbkmPwaJU55ayrkcvfo/Rc9/6i+dGt+f3BI1jYXTfuwnqKtwWUPMdNYuq
	 7S2GFJPpaEFYg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51325c38d10so3036499e87.1
        for <stable@vger.kernel.org>; Fri, 15 Mar 2024 09:08:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YzjPWwCX3Rq2EfXoHiR7eYiymIS2LUtDvKHHd2rfOyPzAkM6jWr
	3xaYZW1oqtN5VM2FUsbiDeMogPrwYZVZixkPfDHI1KkHc+yjAO9ExHwbURKq8+gd96jJYgMFFA3
	n6EOy3qU9ara0CEZWOmWqG5pHtso=
X-Google-Smtp-Source: AGHT+IGMAJ14JnIicJlAEgYYRE7KA+U627IH0Dw3f+b5t/scro14K20hDnCDjV6hV6VjFqn4oS1OTvswfgCuIEgfLk4=
X-Received: by 2002:a05:6512:3134:b0:513:d1d9:9eda with SMTP id
 p20-20020a056512313400b00513d1d99edamr1879034lfd.27.1710518933916; Fri, 15
 Mar 2024 09:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz>
 <CAMj1kXF7gaaARdyN=bVuXtJb_S=-_ewAavXHgN4DS36jxK8r6A@mail.gmail.com>
 <CAMj1kXEo-y1DfY_kBhwGU0xMkGp1PhdqGFmw6ToLePiZy4YgZQ@mail.gmail.com>
 <CAMj1kXFmgba8HyZ-yO7MsQBgOGjM10hZKWESBbfrUcjdhq0XsQ@mail.gmail.com>
 <225e9c2a-9889-4c9e-865c-9ef96bb266f3@podgorny.cz> <CAMj1kXG1Vgpp+ckwDww_4q2SF+kajUaoE3+qe5FzMkGyq-Lbag@mail.gmail.com>
In-Reply-To: <CAMj1kXG1Vgpp+ckwDww_4q2SF+kajUaoE3+qe5FzMkGyq-Lbag@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 17:08:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGZLs3MdFiK9jrkmWR+YPt50L5tuCJ+rLLTjVa3Grm6tw@mail.gmail.com>
Message-ID: <CAMj1kXGZLs3MdFiK9jrkmWR+YPt50L5tuCJ+rLLTjVa3Grm6tw@mail.gmail.com>
Subject: Re: [REGRESSION] linux 6.6.18 and later fails to boot with "initramfs
 unpacking failed: invalid magic at start of compressed archive"
To: Radek Podgorny <radek@podgorny.cz>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 16:33, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 15 Mar 2024 at 15:12, Radek Podgorny <radek@podgorny.cz> wrote:
> >
> > hi ard, thanks for the effort!
> >
> > so, your first recommended patch (the memset thing), applied to current
> > mainline (6.8) DOES NOT resolve the issue.
> >
> > the second recommendation, a revert patch, applied to the same mainline
> > tree, indeed DOES resolve the problem.
> >
> > just to be sure, i'm attaching the revert patch.
> >
>
> Actually, that is not the patch I had in mind.
>
> Please revert
>
> x86/efi: Drop EFI stub .bss from .data section
>

BTW which bootloader are you using?

