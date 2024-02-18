Return-Path: <stable+bounces-20447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DCE859621
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 11:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9C8282EFC
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 10:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C48014A86;
	Sun, 18 Feb 2024 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl7UlZrJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A51FBE1
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708250824; cv=none; b=ReCuUQwa531X+0eVoKsQ1A9GHdlzNEzeAZpn5TYyiI/gJ/tEKGp+M/8Rfka9GPWPupZusOKuZqRtFbROWpBZEp/7cf/WygmXw+dusycEn+kJsqmKkNOP+Gu7p+0UTUjuIl1TCZa7DvUrMJGcHoGtFsKqOwBbzphkh0Y2Xns+mL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708250824; c=relaxed/simple;
	bh=7S6R3xnRVPhUzIOuy5OM9zirAK9yA/RevlLMlD3sEx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSO3i5NVHPlAXZ4JJ6dhb86FQDK1CnU+GuJ6k0bLm9jDYFe5Wx6KagYKOGGJ79jVK+gGj0Q3lMjDE2ynQQca2aPPo7Ga/EcOQR/fKt15uX1gWxXigeISattIoGaH1fUNIPCIkpycaXJi1qXrX9NM6bPQbm8QqT9DWdbtahmwvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl7UlZrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377DCC43399
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 10:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708250824;
	bh=7S6R3xnRVPhUzIOuy5OM9zirAK9yA/RevlLMlD3sEx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bl7UlZrJ3B+dfoIKOpIkMAd6cRBi6I0g/BD1l9cDgWhuMjQugaXKt3Z4L4pKPocA5
	 mvalOS8YJmQWGBMQgKlmYcuL86BRBqK0yXIKdm+aSXyVedMp7QsczSQtsoQ+i8rDZI
	 EPK9TGVm1gFfV93YUk4ZYqfTwVOebnzDcFBSNpU41DhWIEML8y/HJs7QRUJcIhcN/b
	 3C0/HrLyGl7T7BNsQj5SbW6Dc4YI/wEsBPCJemn0IXW3t1DjbS0eV9U+c+Rn0voVw+
	 4MNWITkmGtlOsYKnzjaYoLmqSLCylLB9mlOqHLEXLlW3WH3W+CkPx7OPm0E4nsBU02
	 NS2hjj7D271sA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d23114b19dso6062301fa.3
        for <stable@vger.kernel.org>; Sun, 18 Feb 2024 02:07:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdrw5++iXu6jbyfLz4YRV61KxpgIiSLhsDGhXD6KXdKG9+ZeCR4C63M1KDFU5D1/7VunGCAH04RqO5tSfCXjXzMwhsaJ6D
X-Gm-Message-State: AOJu0Yz04H/TyQDafNnhO3urluHZThXzqo3rZm/EtoKjvsjWcEEyk1aa
	/DbB26hSrfVHVnbUJezaVW4qcPUHsdT28GMZUb+xjozI5Ar6a5sNZsN0wAyqbAw9rRL1YxC0ZJb
	MMFvXdhCRZ4rh5HmOxOMreFrYgGo=
X-Google-Smtp-Source: AGHT+IGSBVfv2g47+kEjUkP+8d4FtM3o9G2Fy80YiP86wcj1CjqVYKynzMXjTqbFk9X7kU9KFtANFmM6TkygS0JvvCA=
X-Received: by 2002:a2e:80d2:0:b0:2d2:318e:788d with SMTP id
 r18-20020a2e80d2000000b002d2318e788dmr1476573ljg.25.1708250822358; Sun, 18
 Feb 2024 02:07:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218023055.145519-1-xiangyang3@huawei.com>
In-Reply-To: <20240218023055.145519-1-xiangyang3@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 18 Feb 2024 11:06:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFbveXgHvk1jEs1Q4kE=Tak08cDYpebwEgKehhwYf9j4A@mail.gmail.com>
Message-ID: <CAMj1kXFbveXgHvk1jEs1Q4kE=Tak08cDYpebwEgKehhwYf9j4A@mail.gmail.com>
Subject: Re: [PATCH 5.10.y 0/5] Backport call_on_irq_stack to fix scs
 overwritten in irq_stack_entry
To: Xiang Yang <xiangyang3@huawei.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, 
	keescook@chromium.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org, gregkh@linuxfoundation.org, xiujianfeng@huawei.com, 
	liaochang1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Feb 2024 at 03:33, Xiang Yang <xiangyang3@huawei.com> wrote:
>
> The shadow call stack for irq now stored in current task's thread info
> may restored incorrectly, so backport call_on_irq_stack from mainline to
> fix it.
>
> Ard Biesheuvel (1):
>   arm64: Stash shadow stack pointer in the task struct on interrupt
>
> Mark Rutland (3):
>   arm64: entry: move arm64_preempt_schedule_irq to entry-common.c
>   arm64: entry: add a call_on_irq_stack helper
>   arm64: entry: convert IRQ+FIQ handlers to C
>
> Xiang Yang (1):
>   Revert "arm64: Stash shadow stack pointer in the task struct on
>     interrupt"
>

Backporting this was a mistake. Not only was the backport flawed, the
original issue (stashing the shadow call stack pointer onto the normal
stack) was not even present, at least not to the same extent.

Stashing the shadow call stack pointer in register X24 works around
the original issue, except for the case where a hardirq is taken while
softirqs are being processed. In this case, X24 will be preserved on
the stack by the hardirq handling logic, and restored after.
Theoretically, that creates a window where the shadow call stack
pointer could be corrupted deliberately, but it seems unlikely to me
that this is exploitable in practice.

So in the light of this, I think doing only the revert here should be
sufficient, and there is no need for the other backports in this
series.

