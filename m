Return-Path: <stable+bounces-183397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EA6BB98AF
	for <lists+stable@lfdr.de>; Sun, 05 Oct 2025 16:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20105345356
	for <lists+stable@lfdr.de>; Sun,  5 Oct 2025 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D1828A705;
	Sun,  5 Oct 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIHuPo7n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E9A258EEF
	for <stable@vger.kernel.org>; Sun,  5 Oct 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759676231; cv=none; b=Zr/Kc5YbjFV6+XbLoes6n8XND6VgLyKWIY1+jBPJgLDCTguh0cOTPOsvLz8neqO0qj3elAvzd/BmqjfGksCtRP+4YfgiTk9iR9qQh9VJN2eQ2zb3+xYURw9QGCHGSpzLX2aC5a8jzkQ45ECd0fqz4ZZOMN0AL4RDd2TkptTHhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759676231; c=relaxed/simple;
	bh=OfxBuX2NG6qRYHgT4owtNmha9ytoyldyaEdP+EyW59o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iA+FK4zGzn9sSY8/wJNhnQVJy1EXMsd76MfJnrpEdBdpBrt5Eq6USsXA5j1IcXLqt2pDDdmD2BsuUkTAAlmPlG+KNY7rd+022QaEhNKP/oVoCsB78Ph6GLMpfFpM1783sIFI7+TtOpvqY5x4rgWgleYWGUprDDxauONo28PZAk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIHuPo7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6BCC113D0
	for <stable@vger.kernel.org>; Sun,  5 Oct 2025 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759676231;
	bh=OfxBuX2NG6qRYHgT4owtNmha9ytoyldyaEdP+EyW59o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hIHuPo7nD/q6+vT/w6NqUCxbffUHAqbz+zHUQOObboqixR5e07MZnIo2dnIeK7lrR
	 REGdcmTP4HqQrYRyXZ1doZjbTkaKHNFdIESi6j/tK82CYv/7+n3T4vX+3PTrNHUMrj
	 ZfGpSSEcyDOnvKw6ULvk6GhulAvUCZfxueiw6x93KqSXKKb6U9Hc/UD5axNH1FXGYB
	 Z5Bs24H9PYv66JynSqQ/W22oPytOMqLk1usm97IlBtpYtg4WwGH0MvVKlkqH7ALAuT
	 AciCHqcq5xwjfRRoodYba8iVgblVx0DK7nJtFC4Eck60xAy1bIQLeK7iUcUEgc+HX6
	 AKJcyCr0Qww9A==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-373a5376d0bso40402051fa.0
        for <stable@vger.kernel.org>; Sun, 05 Oct 2025 07:57:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YwcEnlEVkjJ2sXbLMxHZH1P6utBndvO71rr7QLIZuB/9Z+7ltoY
	zz7Tebw41CKmSn5Ek7E0XNKjdsZcr/OSBSGNDBPc+nVtKyEXkGmBAjMV2OG+8zLk8MkCv3YQKze
	QBsQcI6l8tOEhft59h75hcTGWGsU42wk=
X-Google-Smtp-Source: AGHT+IFdUUomsft5E8FUnkormYOwKRzYQeKZmO/G18QMqhFbnT5zgoA+GQiOMmDzGpZq09lHMaM7alUM8i7Yu8aR1j4=
X-Received: by 2002:a05:651c:12c1:b0:36a:878b:6e34 with SMTP id
 38308e7fff4ca-374c3434da7mr21926661fa.0.1759676229581; Sun, 05 Oct 2025
 07:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003184018.4264-1-will@kernel.org>
In-Reply-To: <20251003184018.4264-1-will@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 5 Oct 2025 16:56:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEo-4Rw=Nttbfnf2Bjv7zSomw1FAnNwbCe97i5UmQ7EVA@mail.gmail.com>
X-Gm-Features: AS18NWAWBJWNYFeWaecMOW4SEUuN_L3lqjI9wswzCjVaIi0JK_wVGUBis0E81yk
Message-ID: <CAMj1kXEo-4Rw=Nttbfnf2Bjv7zSomw1FAnNwbCe97i5UmQ7EVA@mail.gmail.com>
Subject: Re: [STABLE 6.1.y] [PATCH] KVM: arm64: Fix softirq masking in FPSIMD
 register saving sequence
To: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kenneth Van Alstyne <kvanals@kvanals.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 20:40, Will Deacon <will@kernel.org> wrote:
>
> Stable commit 8f4dc4e54eed ("KVM: arm64: Fix kernel BUG() due to bad
> backport of FPSIMD/SVE/SME fix") fixed a kernel BUG() caused by a bad
> backport of upstream commit fbc7e61195e2 ("KVM: arm64: Unconditionally
> save+flush host FPSIMD/SVE/SME state") by ensuring that softirqs are
> disabled/enabled across the fpsimd register save operation.
>
> Unfortunately, although this fixes the original issue, it can now lead
> to deadlock when re-enabling softirqs causes pending softirqs to be
> handled with locks already held:
>
>  | BUG: spinlock recursion on CPU#7, CPU 3/KVM/57616
>  |  lock: 0xffff3045ef850240, .magic: dead4ead, .owner: CPU 3/KVM/57616, .owner_cpu: 7
>  | CPU: 7 PID: 57616 Comm: CPU 3/KVM Tainted: G           O       6.1.152 #1
>  | Hardware name: SoftIron SoftIron Platform Mainboard/SoftIron Platform Mainboard, BIOS 1.31 May 11 2023
>  | Call trace:
>  |  dump_backtrace+0xe4/0x110
>  |  show_stack+0x20/0x30
>  |  dump_stack_lvl+0x6c/0x88
>  |  dump_stack+0x18/0x34
>  |  spin_dump+0x98/0xac
>  |  do_raw_spin_lock+0x70/0x128
>  |  _raw_spin_lock+0x18/0x28
>  |  raw_spin_rq_lock_nested+0x18/0x28
>  |  update_blocked_averages+0x70/0x550
>  |  run_rebalance_domains+0x50/0x70
>  |  handle_softirqs+0x198/0x328
>  |  __do_softirq+0x1c/0x28
>  |  ____do_softirq+0x18/0x28
>  |  call_on_irq_stack+0x30/0x48
>  |  do_softirq_own_stack+0x24/0x30
>  |  do_softirq+0x74/0x90
>  |  __local_bh_enable_ip+0x64/0x80
>  |  fpsimd_save_and_flush_cpu_state+0x5c/0x68
>  |  kvm_arch_vcpu_put_fp+0x4c/0x88
>  |  kvm_arch_vcpu_put+0x28/0x88
>  |  kvm_sched_out+0x38/0x58
>  |  __schedule+0x55c/0x6c8
>  |  schedule+0x60/0xa8
>
> Take a tiny step towards the upstream fix in 9b19700e623f ("arm64:
> fpsimd: Drop unneeded 'busy' flag") by additionally disabling hardirqs
> while saving the fpsimd registers.
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: <stable@vger.kernel.org> # 6.1.y
> Fixes: 8f4dc4e54eed ("KVM: arm64: Fix kernel BUG() due to bad backport of FPSIMD/SVE/SME fix")
> Reported-by: Kenneth Van Alstyne <kvanals@kvanals.org>
> Link: https://lore.kernel.org/r/010001999bae0958-4d80d25d-8dda-4006-a6b9-798f3e774f6c-000000@email.amazonses.com
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

