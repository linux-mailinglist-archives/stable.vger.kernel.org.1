Return-Path: <stable+bounces-3209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1957FEE9A
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 13:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284F3B20DDC
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894C45BE6;
	Thu, 30 Nov 2023 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncyBQiNT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B5184
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 04:07:16 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b472f98b1so6758305e9.3
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 04:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701346035; x=1701950835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biEY9+8Tb07WJt0NiFiN/4G6xbQRZfkGA93WnoulE44=;
        b=ncyBQiNTKf/gf4d+dp8bbwCLFiE4VRBThUFelS2tXlmlxURkeKxFte1a9uDQcf18lt
         jdl+V8tLfougq2emibo0pr4wXn7tRGj/l6B9omGWG/0Uoo5C0xRqM+zeqo9aeEZ1bYnN
         7F40A5hp3Gp6C6SsrQtE6d/f1PNlZCKgOZREocXWh/4Uqm2NEr4VRicUmaGAO6xnB/nD
         ROaqCH6MuR2uXHkurF4+Ea81fGK+PhL5VIPgxd6I3szg5Npp9Zq3nsepaT2B87wSblYq
         4kMvaHaduH7CzMX9zTlY5HRnAZ8PLgYRv8tS13vyQ2buugqroZR8k4g2YxtSeUXM26pJ
         0Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701346035; x=1701950835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biEY9+8Tb07WJt0NiFiN/4G6xbQRZfkGA93WnoulE44=;
        b=ZKJNMjS2c7GykulZ3qGRHAbZ1QhSNTURb7QXhqRvs9DjYMV9Jm4IEswLDn+0Ij3FMp
         tHwfX4yh4eU771Ob53BZKvF3pNFkaLuKiEqHbv+NYc4H/HMgYyVYdlUkFG5iKYhQidnD
         KpuhsGfDR+2q8PowvEfr2RxQW6D0qE/3GCCfwkQpkvuz053UYEfV+Z9Q0XxZO7blhgZ3
         nGk9fSn4LTf02rN5/ouyXb9vYw8fFyNbTiRn/3YMh/T3nU9MLM5Vp9Epimzqaw81xY8Z
         IIXJksPhPE6CYdEmbODNWzaa32qD+TEaYdUTAg5m93QLzSl8EVuz++q861+DsL0462+g
         zCEw==
X-Gm-Message-State: AOJu0Ywf/UuOo+VfoTeRs6Iy/BSe5y+F0zt0WQE5Keo593lfrQtvKmxq
	jGfYd+w4NlZLmiDjYUDMsI1hYv++hcbaXEtkFQiquZm2Mn4=
X-Google-Smtp-Source: AGHT+IGXo3MX08+L9Ad0RtPS5baiguxhlQVzIDEkTPTNTt5eK9F7MLgK+KyXUmNxN2JbGLW+JK0J9FIvYo/PER+is1c=
X-Received: by 2002:a05:600c:1d17:b0:401:eb0:a974 with SMTP id
 l23-20020a05600c1d1700b004010eb0a974mr17555775wms.3.1701346035081; Thu, 30
 Nov 2023 04:07:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALk6Uxo5ymxu_P_7=LnLZwTgjYbrdE7gzwyeQVxeR431SPuxyw@mail.gmail.com>
 <2023112431-matching-imperfect-1b76@gregkh> <CALk6UxqZtm_MR9cYyN2UvTF_7xPH0D-zQ_uUjZKjNGfU-JOX-A@mail.gmail.com>
In-Reply-To: <CALk6UxqZtm_MR9cYyN2UvTF_7xPH0D-zQ_uUjZKjNGfU-JOX-A@mail.gmail.com>
From: Ronald Monthero <debug.penguin32@gmail.com>
Date: Thu, 30 Nov 2023 22:07:03 +1000
Message-ID: <CALk6Uxoq=f7ews1Beve3qW_38w0sw1fnpJvmwMDfxy9eM+1AmA@mail.gmail.com>
Subject: Re: Backport submission - rcu: Avoid tracing a few functions executed
 in stop machine
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 12:08=E2=80=AFAM Ronald Monthero
<debug.penguin32@gmail.com> wrote:
>
> On Sat, Nov 25, 2023 at 2:10=E2=80=AFAM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Tue, Nov 21, 2023 at 12:09:38AM +1000, Ronald Monthero wrote:
> > > Dear stable maintainers,
> > > I like to indicate the oops encountered and request the below patch t=
o
> > > be backported to v 5.15. The fix is important to avoid recurring oops
> > > in context of rcu detected stalls.
> > >
> > > subject: rcu: Avoid tracing a few functions executed in stop machine
> > > commit  48f8070f5dd8
> > > Target kernel version   v 5.15
> > > Reason for Application: To avoid oops due to rcu_prempt detect stalls
> > > on cpus/tasks
> > >
> > > Environment and oops context: Issue was observed in my environment on
> > > 5.15.193 kernel (arm platform). The patch is helpful to avoid the
> > > below oops indicated in [1] and [2]
> >
> > As the patch does not apply cleanly, we need a working and tested
> > backport so we know to apply the correct version.
> >
> > Can you please provide that as you've obviously already done this?
>
> Hi Greg,
> Sorry I notice my typo error 193 instead of 93. I have tested on the
> 5.15.93-rt58  kernel.

Hi Greg,
I used a 5.15.93 kernel
- on arm32 bit platform I tested with 5.15.93-rt58 (rt kernel) ,  on
real hardware - Freescale LS1021A, 32 bit Cortex A7 processor
- on x86_64 platform I tested non rt kernel 5.15.93  -  virtual
machine - qemu platform

Below is the build log after patch to kernel/rcu/tree.h on x86_64

linux-5.15.93$ make
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND objtool
  DESCEND bpf/resolve_btfids
  CHK     include/generated/compile.h
  CC      kernel/rcu/tree.o                         <<<
  AR      kernel/rcu/built-in.a                     <<<
  AR      kernel/built-in.a
  CHK     kernel/kheaders_data.tar.xz
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  LD      vmlinux.o
  MODPOST vmlinux.symvers
  MODINFO modules.builtin.modinfo
  GEN     modules.builtin
  LD      .tmp_vmlinux.btf
  BTF     .btf.vmlinux.bin.o
  LD      .tmp_vmlinux.kallsyms1

< snipped >

  BTF [M] sound/usb/usx2y/snd-usb-usx2y.ko
  BTF [M] sound/virtio/virtio_snd.ko
  BTF [M] sound/x86/snd-hdmi-lpe-audio.ko
  BTF [M] sound/xen/snd_xen_front.ko
  BTF [M] virt/lib/irqbypass.ko
linux-5.15.93$

BR,
ronald

