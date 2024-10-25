Return-Path: <stable+bounces-88142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3F59B00DA
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 13:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79A31F235D6
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 11:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE591DAC88;
	Fri, 25 Oct 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlLXtjF0"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17331CFEB5
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854314; cv=none; b=hEbh19z3ZU3wmHrbGTa9eTBfKYcSut+0rnt2RBMp29gXTk54hbfHKR0Y74Wxp/mxT+QCCjFVjob7+Xfd0kWOvZfwZegV9zknKu1jWpY85PAIN02gPpDqNaYh15b7TJcI62wrXjZ5I5c+1HUBe1B1b8ft269SghWBdHCNHaTuxTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854314; c=relaxed/simple;
	bh=TYXGy47aTmQ+8lM1/A7b5cCqKr9Na80GePDVaBMMd2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Emq1k3yCOSoVGaNZsDPSthsalaaLSCVTdXK3fhy+YpzzpPxx+i/W4OP6b+DB4Z0Cpt0Iz0Bh3ShzlKjdKLSetrIKP8TpacbYWf+kBpoEKHDzqnCi34Q5iTT/qNNFSZJxqo51HGV3sjJ0kVdD/sZM1mRdNfXBUKZDdX067VSGU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GlLXtjF0; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso1810626e87.1
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 04:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729854310; x=1730459110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuomQA4el8BSAut2vwLq507qc8/7nzyKhdkv644V4tk=;
        b=GlLXtjF0ZfnVjLh8Wfb3kDgVC5AXxkgflHq5KsX3CTGVw3B6poapiL1zL2jA18YEk2
         uQJONfd1OY01BpRs+G6TPqDUiqI9d/lKSLmP5Bl3lXy+GkOCVbjr8W/FMVCs7bDup6Xu
         CHRMNujap0cxD6+s1Uqv7401ZFXeoCrKHDIaypiIFARZL4LHq3AZGVrSCDC07zYXH/V1
         lRramMtkfJdqsgYQwH2nTv1ri0wgFFyzVUX/tf9K2LgXEDO7yMAhEro3sa3STR15ucWX
         ABQVFxByY0ENvR9O7T4OvQAtybT9lNYW62uerLC54cIhKrNs2DeZvAbh51rJKLQaUoh/
         N1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729854310; x=1730459110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuomQA4el8BSAut2vwLq507qc8/7nzyKhdkv644V4tk=;
        b=dYAV8QNXDSFpadsN9YIVXkb11WlBKthrqFcnGZvgoQqUp5uv1tNCFbzQCiLjCHDg82
         4ByNr8BrZ4YlKmeydcTDZXgS6Cl9V2HJSipsfm+uszBJIFJY8j2DCXdBInQS0db+LhDn
         bVqQQnbyDLgqqqjkCYs9Y5djtznWWXi25kzIsApWtZfRGyah2cTkWOtyjpUcdhlTcWiH
         xHNXamV1fDBlsfYNYL5XcoNpw1nhgRlxPyOI5Ig0MsAhg0nFtPa04iJxNilVERDKaGLE
         3rho5ptEWkhqptT/5VOhlvqt5QpR1InsLJNn7VPLAZDw6NENPC7pQ0+Z82d5epJGJALs
         GX/g==
X-Forwarded-Encrypted: i=1; AJvYcCVjc41AM2tKanSEh1tRwDMH24lsFKJ7/gc3ambJbvY5ekKQpN+RZiy44Ir/WHP9MoOOSwnXx8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym0v6g6G4TwzGG/gGhxG3zHJMzQB8/dn8lWwxlqiZc3aN6Lnwk
	CKT6fSzEOT6CotFYj6qmI9J0YqrMbImMy5YH3AV+A9vximq7uGWVRO0ZXB449hQ1w0hByS0msyp
	ruTthBZ+tAECudQNqb3T8iMbDIdRrLOMGdqsBig==
X-Google-Smtp-Source: AGHT+IE3hHhqGmpopThdU7fUZ90CNqImMKu3l7SDYMnc1DU7abvZQL9XTwbVyoLLrq2iIOMeoYVGfYC3GvxR504MoZA=
X-Received: by 2002:a05:6512:3996:b0:539:f593:c19e with SMTP id
 2adb3069b0e04-53b1a3b018amr5062359e87.60.1729854309787; Fri, 25 Oct 2024
 04:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-arm-kasan-vmalloc-crash-v3-0-d2a34cd5b663@linaro.org>
 <20241017-arm-kasan-vmalloc-crash-v3-1-d2a34cd5b663@linaro.org>
 <69f71ac8-4ba6-46ed-b2ab-e575dcada47b@foss.st.com> <CACRpkdYvgZj1R4gAmzFhf4GmFOxZXhpHVTOio+hVP52OBAJP0A@mail.gmail.com>
 <46336aba-e7dd-49dd-aa1c-c5f765006e3c@foss.st.com> <CACRpkdY2=qdY_0GA1gB03yHODPEvxum+4YBjzsXRVnhLaf++6Q@mail.gmail.com>
 <f3856158-10e6-4ee8-b4d5-b7f2fe6d1097@foss.st.com>
In-Reply-To: <f3856158-10e6-4ee8-b4d5-b7f2fe6d1097@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Oct 2024 13:04:57 +0200
Message-ID: <CACRpkdZa5x6NvUg0kU6F0+HaFhKhVswvK2WaaCSBx3-JCVFcag@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ARM: ioremap: Sync PGDs for VMALLOC shadow
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev <kasan-dev@googlegroups.com>, Russell King <linux@armlinux.org.uk>, 
	Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Antonio Borneo <antonio.borneo@foss.st.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 11:27=E2=80=AFAM Clement LE GOFFIC
<clement.legoffic@foss.st.com> wrote:
> On 10/24/24 23:58, Linus Walleij wrote:
> > Hi Clement,
> >
> > I saw I missed to look closer at the new bug found in ext4
> > on the STM32:
> >
> > On Mon, Oct 21, 2024 at 2:12=E2=80=AFPM Clement LE GOFFIC
> > <clement.legoffic@foss.st.com> wrote:
> >
> >> Perhaps not related with this topic but as in the backtrace I am getti=
ng
> >> some keyword from our start exchange, I dump the crash below.
> >> If this backtrace is somehow related with our issue, please have a loo=
k.
> > (...)
> >> [ 1439.351945] PC is at __read_once_word_nocheck+0x0/0x8
> >> [ 1439.356965] LR is at unwind_exec_insn+0x364/0x658
> > (...)
> >> [ 1440.333183]  __read_once_word_nocheck from unwind_exec_insn+0x364/0=
x658
> >> [ 1440.339726]  unwind_exec_insn from unwind_frame+0x270/0x618
> >> [ 1440.345352]  unwind_frame from arch_stack_walk+0x6c/0xe0
> >> [ 1440.350674]  arch_stack_walk from stack_trace_save+0x90/0xc0
> >> [ 1440.356308]  stack_trace_save from kasan_save_stack+0x30/0x4c
> >> [ 1440.362042]  kasan_save_stack from __kasan_record_aux_stack+0x84/0x=
8c
> >> [ 1440.368473]  __kasan_record_aux_stack from task_work_add+0x90/0x210
> >> [ 1440.374706]  task_work_add from scheduler_tick+0x18c/0x250
> >> [ 1440.380245]  scheduler_tick from update_process_times+0x124/0x148
> >> [ 1440.386287]  update_process_times from tick_sched_handle+0x64/0x88
> >> [ 1440.392521]  tick_sched_handle from tick_sched_timer+0x60/0xcc
> >> [ 1440.398341]  tick_sched_timer from __hrtimer_run_queues+0x2c4/0x59c
> >> [ 1440.404572]  __hrtimer_run_queues from hrtimer_interrupt+0x1bc/0x3a=
0
> >> [ 1440.411009]  hrtimer_interrupt from arch_timer_handler_virt+0x34/0x=
3c
> >> [ 1440.417447]  arch_timer_handler_virt from
> >> handle_percpu_devid_irq+0xf4/0x368
> >> [ 1440.424480]  handle_percpu_devid_irq from
> >> generic_handle_domain_irq+0x38/0x48
> >> [ 1440.431618]  generic_handle_domain_irq from gic_handle_irq+0x90/0xa=
8
> >> [ 1440.437953]  gic_handle_irq from generic_handle_arch_irq+0x30/0x40
> >> [ 1440.444094]  generic_handle_arch_irq from __irq_svc+0x88/0xc8
> >> [ 1440.449920] Exception stack(0xde803a30 to 0xde803a78)
> >> [ 1440.454914] 3a20:                                     de803b00
> >> 00000000 00000001 000000c0
> >> [ 1440.463141] 3a40: e5333f40 de803ba0 de803bd0 00000001 e5333f40
> >> de803b00 c1241d90 bad0075c
> >> [ 1440.471262] 3a60: c20584b8 de803a7c c0114114 c0113850 200f0013 ffff=
ffff
> >> [ 1440.477959]  __irq_svc from unwind_exec_insn+0x4/0x658
> >> [ 1440.483078]  unwind_exec_insn from call_with_stack+0x18/0x20
> >
> > This is hard to analyze without being able to reproduce it, but it talk=
s
> > about the stack and Kasan and unwinding, so could it (also) be related =
to the
> > VMAP:ed stack?
> >
> > Did you try to revert (or check out the commit before and after)
> > b6506981f880 ARM: unwind: support unwinding across multiple stacks
> > to see if this is again fixing the issue?
> I Linus,
>
> Yes, I've tried to revert this particular commit on top of your last
> patches but I have some conflicts inside arch/arm/kernel/unwind.c

What happens if you just

git checkout b6506981f880^

And build and boot that? It's just running the commit right before the
unwinding patch.

Yours,
Linus Walleij

