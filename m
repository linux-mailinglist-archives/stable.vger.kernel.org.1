Return-Path: <stable+bounces-88117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF86D9AF4E7
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 23:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C1C1F22B99
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 21:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46B82178F4;
	Thu, 24 Oct 2024 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8Ky9Q9N"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7581D63E5
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729807136; cv=none; b=rxTpuhD7UhsHC1fABOr7oXStwWHxoldGSnHTAs6gjeQCGhh1lyDj6D4D5yfH3v70Chop05ILI8ijY/u74ume3pQMUQeIlWcX0ep9Po+IDYObIi4tWd5MjkO6aJIeQNuycNG2xb2vUGhDgKbdSV6xzwT6i6pv6WISOpiJAsap8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729807136; c=relaxed/simple;
	bh=iHgWbyh1Z8P0slQ/OAXr5E+kHEXUQubuI7OdQK6Vy0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTzkjfaZ4XQzYrAhgFwI9B2dni7K0bSmENJRXQYL7s1Lvi8oA2MT73X6Dqt9JrFqrl39TqcOfL2JgOAMn92fQCSNnLnf0JGCf3L4x2Dwc0nk82fzKPSp+8e/qNJGXMmnFsBS2ICHb7Tzeo9kUuRVWZjDMIFYKilV40G0C2x5E58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e8Ky9Q9N; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb587d0436so15365061fa.2
        for <stable@vger.kernel.org>; Thu, 24 Oct 2024 14:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729807132; x=1730411932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFVxrWwlGXu7xwVCAmBNg01QSRfDgCIGYPTLM5Loo7A=;
        b=e8Ky9Q9N+NLL/xAoMKP3CMsiXxQQE5TvFw61s3eUnc3od73gC+OXh9mEYkpNHZReR9
         MGWdudiXSMM+7GsmPuIKgRZ0FEe/VHZjTU1VVUvAioGJaZrUwh5pa5O0POU1xV/Az3t6
         m82uCr2YlhFbbicNpkZxNENP0hdRYcUcKVYhu5VJcsmdb4eNxtu32FuULxWaN7FVSHwx
         cCwZ/Dt7lBMXSwKiB931SPLPjhr3ZSr9FkbAnr+w6ETqu576sTuIVUDMcJejm0SJQzyh
         VjFv/heaBbJv9SxsNY9Zk20oe4IXeMmGkO3GY3XjE+dCGmxoRW6GyZH+nHpY9U+PfV5R
         4eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729807132; x=1730411932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFVxrWwlGXu7xwVCAmBNg01QSRfDgCIGYPTLM5Loo7A=;
        b=Lq9PSUe2biEF8MEx4VsWW+60kxkjbiOWeai9jx+nRtMgpUJOFyfOGbJfqGlCNHJe4a
         EDkD7VZkblBTd55AH4grSiUx0y0mJZG9KYz7t/bPgUtCjIA6tXtADS5L0CGtl8kGFEoo
         ZYIQFMLGwewtcsPyT5BRn4xAy6DirHFbXiI7r29yLit2t7jlgYMmpLBosByvgaYPMwNR
         LTdBC8JLoBOTkza99kKAtoCQZJsffRIAEuPouV7w06OUiYxs04YQuXasx+h2Pc+wx/R4
         SCYqF9nMZNm/FN+ZJzCL2eMeJKuimS+SOk9n2O5KLAXSx38q83R6iF9giYdvSklCJrco
         yWMg==
X-Forwarded-Encrypted: i=1; AJvYcCXOA0r6Xc4MAVrALZZVh6PJ2Pz4N8/s78oAVRBGjo1VxwrbZnIj2Aa1D7vskRDI41FsxYazazc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybH+DlUz1BQF1TfUFTjm++greNZ3EBqCV4b1zQZg6mm5HRJWSX
	+roC5mlerMpgb4KZSQbKvQ7GOjZkUAXCwuA4DK7KFWs0qKioEalwbiDH52j/vFxJWjauWe4UEHD
	CTErWj6f2wwK+Ddy+uTb1+eTE1mXFB4ek0VcLDA==
X-Google-Smtp-Source: AGHT+IHvsIXQR72a7B+0VLm11VGicY9C2xyjpGaCCytBMfZbl/D5DRFsNMPKYNptUhXB3YcX5jP4S4kynK/SQjQw+0o=
X-Received: by 2002:a2e:9010:0:b0:2fb:3e01:b2bd with SMTP id
 38308e7fff4ca-2fc9d35a589mr34560231fa.21.1729807132380; Thu, 24 Oct 2024
 14:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-arm-kasan-vmalloc-crash-v3-0-d2a34cd5b663@linaro.org>
 <20241017-arm-kasan-vmalloc-crash-v3-1-d2a34cd5b663@linaro.org>
 <69f71ac8-4ba6-46ed-b2ab-e575dcada47b@foss.st.com> <CACRpkdYvgZj1R4gAmzFhf4GmFOxZXhpHVTOio+hVP52OBAJP0A@mail.gmail.com>
 <46336aba-e7dd-49dd-aa1c-c5f765006e3c@foss.st.com>
In-Reply-To: <46336aba-e7dd-49dd-aa1c-c5f765006e3c@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 Oct 2024 23:58:40 +0200
Message-ID: <CACRpkdY2=qdY_0GA1gB03yHODPEvxum+4YBjzsXRVnhLaf++6Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ARM: ioremap: Sync PGDs for VMALLOC shadow
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Antonio Borneo <antonio.borneo@foss.st.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Clement,

I saw I missed to look closer at the new bug found in ext4
on the STM32:

On Mon, Oct 21, 2024 at 2:12=E2=80=AFPM Clement LE GOFFIC
<clement.legoffic@foss.st.com> wrote:

> Perhaps not related with this topic but as in the backtrace I am getting
> some keyword from our start exchange, I dump the crash below.
> If this backtrace is somehow related with our issue, please have a look.
(...)
> [ 1439.351945] PC is at __read_once_word_nocheck+0x0/0x8
> [ 1439.356965] LR is at unwind_exec_insn+0x364/0x658
(...)
> [ 1440.333183]  __read_once_word_nocheck from unwind_exec_insn+0x364/0x65=
8
> [ 1440.339726]  unwind_exec_insn from unwind_frame+0x270/0x618
> [ 1440.345352]  unwind_frame from arch_stack_walk+0x6c/0xe0
> [ 1440.350674]  arch_stack_walk from stack_trace_save+0x90/0xc0
> [ 1440.356308]  stack_trace_save from kasan_save_stack+0x30/0x4c
> [ 1440.362042]  kasan_save_stack from __kasan_record_aux_stack+0x84/0x8c
> [ 1440.368473]  __kasan_record_aux_stack from task_work_add+0x90/0x210
> [ 1440.374706]  task_work_add from scheduler_tick+0x18c/0x250
> [ 1440.380245]  scheduler_tick from update_process_times+0x124/0x148
> [ 1440.386287]  update_process_times from tick_sched_handle+0x64/0x88
> [ 1440.392521]  tick_sched_handle from tick_sched_timer+0x60/0xcc
> [ 1440.398341]  tick_sched_timer from __hrtimer_run_queues+0x2c4/0x59c
> [ 1440.404572]  __hrtimer_run_queues from hrtimer_interrupt+0x1bc/0x3a0
> [ 1440.411009]  hrtimer_interrupt from arch_timer_handler_virt+0x34/0x3c
> [ 1440.417447]  arch_timer_handler_virt from
> handle_percpu_devid_irq+0xf4/0x368
> [ 1440.424480]  handle_percpu_devid_irq from
> generic_handle_domain_irq+0x38/0x48
> [ 1440.431618]  generic_handle_domain_irq from gic_handle_irq+0x90/0xa8
> [ 1440.437953]  gic_handle_irq from generic_handle_arch_irq+0x30/0x40
> [ 1440.444094]  generic_handle_arch_irq from __irq_svc+0x88/0xc8
> [ 1440.449920] Exception stack(0xde803a30 to 0xde803a78)
> [ 1440.454914] 3a20:                                     de803b00
> 00000000 00000001 000000c0
> [ 1440.463141] 3a40: e5333f40 de803ba0 de803bd0 00000001 e5333f40
> de803b00 c1241d90 bad0075c
> [ 1440.471262] 3a60: c20584b8 de803a7c c0114114 c0113850 200f0013 fffffff=
f
> [ 1440.477959]  __irq_svc from unwind_exec_insn+0x4/0x658
> [ 1440.483078]  unwind_exec_insn from call_with_stack+0x18/0x20

This is hard to analyze without being able to reproduce it, but it talks
about the stack and Kasan and unwinding, so could it (also) be related to t=
he
VMAP:ed stack?

Did you try to revert (or check out the commit before and after)
b6506981f880 ARM: unwind: support unwinding across multiple stacks
to see if this is again fixing the issue?

Yours,
Linus Walleij

