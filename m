Return-Path: <stable+bounces-139534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 185B7AA8071
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 13:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE3A9829A8
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 11:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D331EDA2C;
	Sat,  3 May 2025 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7WpISdG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69B1EB189;
	Sat,  3 May 2025 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746271372; cv=none; b=EkJO1fr9bDHAghXMhOmEIgfg2v8FeVGKgbrS4c4ZHIGDGGz/n4cLmWtYSte7KzI+6r8WLSW8GiG6mv4BJ8mc1zuoLFxkbwG5QCj2VcnGbuKH/rfvlc65UYYiS6QemJbqQzyANcdbaqD3akQKGVCjtELbrmP80DsQ5zxMVDzvXO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746271372; c=relaxed/simple;
	bh=6njSZpjLFFK801EujEb3cuL3VrsBnFkcO396PYwdH7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+uA3sRZw1hm2iy3tgOWspVS44O0evoPE8IE+yCE6l4JTp3kiBDDrjhs1ttYjSayVzaz1PCwIkf++G0kpAMnvfA7SQ/3JvVQBY87o346PFi9AYu/7uvpfF771kV7Bb6pHfjUXMQ/fjvuhT70zUg0xfxef962gKbaCGC4qHOd9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7WpISdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0DFC4AF09;
	Sat,  3 May 2025 11:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746271371;
	bh=6njSZpjLFFK801EujEb3cuL3VrsBnFkcO396PYwdH7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m7WpISdGGO3sg0pkZySqZVxhQXOrOO9sPlkZ9W5OhO0eUNb0quPvXWkiK0vca30C4
	 ZRnYFSOa2Wkz0dwE4z6Fjs3+G6MnlmmFd0qpxz4TTnKfBslQkMezvu8eFYWRwpE5lu
	 e5+AeZ3FIO5J2ejNLWWWITtCFNFxiF8JNABEJenWMHmJm04pcgjGRb5+2DGhMOt0d5
	 gvDo6p+v9mum5Bk8GcMv1YAjfOJkh0SC2760HjyaVHDVm5Woa1F6ML+R1uSM14SHsi
	 A+8taaKnDq1hWiNWgBof3ltLwLjqzUyegfdAAPgSHP4HlnhTvhdl/hU6iWV5wAwh6x
	 jalm5zxtdKmuA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54998f865b8so2988413e87.3;
        Sat, 03 May 2025 04:22:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKkN3BvOvXUZZFeTAclUWrYJ97neEi68BZQn801UAWVVhP+h6aHGoxUAdRZBm+wVGNL5O1B4Os@vger.kernel.org, AJvYcCUefbBY9EeA26wEYjl4w8NI/F2w0xeK9XRk8BybO96d1626X184FFdVS22uP73yoE7NwWreQ5pQLjPTuN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2vV46z7klbwBno+PBQMbkRrIvV//lrxG8smXZ0wq+2JDj47ks
	E+utuXZefg7LemhGYEmlabJ9MrDvcpe4OmQIQRvpGNRC4RIJrlv568qe95VEZGF1HU+XIzKEvLD
	iSVcuDWHTN/lnk4pBl/g8TyqSDL4=
X-Google-Smtp-Source: AGHT+IG/LZhJuYwd6BT5g/YapcupnN/sQf19+E1GsW+tcerWCF3qKkEN4dkhge9FjiQ1f4Ybup6+9GqTT5D7d0ujND0=
X-Received: by 2002:a05:6512:108e:b0:549:8f4a:6baa with SMTP id
 2adb3069b0e04-54eb24390c2mr671056e87.27.1746271369757; Sat, 03 May 2025
 04:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502145755.3751405-1-yeoreum.yun@arm.com> <CAMj1kXEoYcS6YPU0mBdvijDRK6ZVB7mPYZsCVpz7sYotabrxtQ@mail.gmail.com>
 <aBUHlGvZuI2O0bbs@arm.com> <aBULdGn+klwp8CEu@e129823.arm.com> <aBXqi4XpCsN3otHe@arm.com>
In-Reply-To: <aBXqi4XpCsN3otHe@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 3 May 2025 13:22:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHL5_2TM1ZTaPEgGm9uU7xvFpRxxarKpOTr=YVvj+72cQ@mail.gmail.com>
X-Gm-Features: ATxdqUG1fvw_z6UhDYuaA_GkP9ybtJKQQ9wqgeSGK9OYj_TYO1ZfClLHhMe7z3g
Message-ID: <CAMj1kXHL5_2TM1ZTaPEgGm9uU7xvFpRxxarKpOTr=YVvj+72cQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, will@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	broonie@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	frederic@kernel.org, joey.gouly@arm.com, james.morse@arm.com, 
	hardevsinh.palaniya@siliconsignals.io, shameerali.kolothum.thodi@huawei.com, 
	ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 May 2025 at 12:06, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, May 02, 2025 at 07:14:12PM +0100, Yeoreum Yun wrote:
> > > On Fri, May 02, 2025 at 06:41:33PM +0200, Ard Biesheuvel wrote:
> > > > Making arm64_use_ng_mappings __ro_after_init seems like a useful
> > > > change by itself, so I am not objecting to that. But we don't solve it
> > > > more fundamentally, please at least add a big fat comment why it is
> > > > important that the variable remains there.
> > >
> > > Maybe something like the section reference checker we use for __init -
> > > verify that the early C code does not refer anything in the BSS section.
> >
> > Maybe but it would be better to be checked at compile time (I don't
> > know it's possible) otherwise, early C code writer should check
> > mandatroy by calling is_kernel_bss_data() (not exist) for data it refers.
>
> This would be compile time (or rather final link time). See
> scripts/mod/modpost.c (the sectioncheck[] array) on how we check if, for
> example, a .text section references a .init one. We could move the whole
> pi code to its own section (e.g. .init.nommu.*) and add modpost checks
> for references to the bss or other sections.
>

We can take care of this locally in image-vars.h, where each variable
used by the startup code is made available to it explicitly.

Sending out a separate series shortly.

