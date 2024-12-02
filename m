Return-Path: <stable+bounces-96106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C0D9E07E0
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCD3168DD8
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FE7209F4F;
	Mon,  2 Dec 2024 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOUNGcF+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13921200B9B;
	Mon,  2 Dec 2024 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154265; cv=none; b=JkhxF9kGhT4C6rxHv/QDkjxku+U5n4/swl+4RsKY2uKNDp1M+JOSL0MYNZ8Qy4EV2qBqj04fjX1cW7KKgURcZkutZGLAPGpUr2oBC8YdttDC0uZWK5igJVE114ZqtPsZwyNwieV59NyjJ2rDjeo0hUwb8njnxu3a6aRumsDBVag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154265; c=relaxed/simple;
	bh=DyHkmcoK/rPOrpLfO3N9/3ZQGexPIlejeLIDNVhReJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mCRD3m+Y/uAF3rju39owNUjvOezfmSZo2oKfbNG6uR0syrY1NmB/nHQMW+uC76LbetYZSNekGUJN6MwdQjV6c1+C/iq6qDscUu6y4XRlla8tz9SojhIe1HVbuewQ34OUS2a00TAxZ4hy6mVF5o1YRggRpNcYC0S6MNLEC+lol50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOUNGcF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0547AC4CED1;
	Mon,  2 Dec 2024 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733154264;
	bh=DyHkmcoK/rPOrpLfO3N9/3ZQGexPIlejeLIDNVhReJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dOUNGcF+mdb56CEPrlHyw39sLJ6Cpw3nwWs37XYq/5PCKaYPjmRFAKpj3U6FKB9qL
	 ZDraECnj/6CO8AT1hvqhljlFzcSXwo+/r2HbYd3en7lr5Lrcs8vwB2jgVLcBaNGH+W
	 3sIwJ6ex6jiS97vYpH3a+BLXNZjMncZACtVsgaI/uKjzAkuH9GzrBSiGp6zofqafe7
	 yzC3rep21BA4jxNecS1y4iug1WbwCSwjoUGkjCQPhtOV/vi8PXhp0REkXSdFToGYm3
	 MgBjhLvwIAq7I9xcIh0TUkDGhodZMeTojoiqnpM4+ieY+9Az+7a6Pv9s9tzAqVi4BL
	 8d1jUMElH1/IQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Celeste Liu <uwu@coelacanthus.name>, Oleg Nesterov <oleg@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Eric Biederman
 <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>,
 Andrea Bolognani <abologna@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ron Economos <re@w6rz.net>, Felix Yan
 <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, Shiqi Zhang
 <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>, Yao Zi
 <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org, Celeste Liu
 <uwu@coelacanthus.name>
Subject: Re: [PATCH] riscv/ptrace: add new regset to get original a0 register
In-Reply-To: <20241201-riscv-new-regset-v1-1-c83c58abcc7b@coelacanthus.name>
References: <20241201-riscv-new-regset-v1-1-c83c58abcc7b@coelacanthus.name>
Date: Mon, 02 Dec 2024 16:44:21 +0100
Message-ID: <87v7w22ip6.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for working on this!

Celeste Liu <uwu@coelacanthus.name> writes:

> The orig_a0 is missing in struct user_regs_struct of riscv, and there is
> no way to add it without breaking UAPI. (See Link tag below)
>
> Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
> access original a0 register from userspace via ptrace API.
>
> Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gm=
ail.com/
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> ---
>  arch/riscv/kernel/ptrace.c | 33 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/elf.h   |  1 +
>  2 files changed, 34 insertions(+)
>
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index ea67e9fb7a583683b922fe2c017ea61f3bc848db..faa46de9000376eb445a32d43=
a40210d7b846844 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -31,6 +31,7 @@ enum riscv_regset {
>  #ifdef CONFIG_RISCV_ISA_SUPM
>  	REGSET_TAGGED_ADDR_CTRL,
>  #endif
> +	REGSET_ORIG_A0,
>  };
>=20=20
>  static int riscv_gpr_get(struct task_struct *target,
> @@ -184,6 +185,30 @@ static int tagged_addr_ctrl_set(struct task_struct *=
target,
>  }
>  #endif
>=20=20
> +static int riscv_orig_a0_get(struct task_struct *target,
> +			     const struct user_regset *regset,
> +			     struct membuf to)

Use full 100 chars!

> +{
> +	return membuf_store(&to, task_pt_regs(target)->orig_a0);
> +}
> +
> +static int riscv_orig_a0_set(struct task_struct *target,
> +			     const struct user_regset *regset,
> +			     unsigned int pos, unsigned int count,
> +			     const void *kbuf, const void __user *ubuf)

Dito!

> +{
> +	int orig_a0 =3D task_pt_regs(target)->orig_a0;

64b regs on RV64.

> +	int ret;
> +
> +	ret =3D user_regset_copyin(&pos, &count, &kbuf, &ubuf, &orig_a0, 0, -1);
> +	if (ret)
> +		return ret;
> +
> +	task_pt_regs(target)->orig_a0 =3D orig_a0;
> +	return ret;
> +}
> +
> +

Multiple blanks.

>  static const struct user_regset riscv_user_regset[] =3D {
>  	[REGSET_X] =3D {
>  		.core_note_type =3D NT_PRSTATUS,
> @@ -224,6 +249,14 @@ static const struct user_regset riscv_user_regset[] =
=3D {
>  		.set =3D tagged_addr_ctrl_set,
>  	},
>  #endif
> +	[REGSET_ORIG_A0] =3D {
> +		.core_note_type =3D NT_RISCV_ORIG_A0,
> +		.n =3D 1,
> +		.size =3D sizeof(elf_greg_t),
> +		.align =3D sizeof(elf_greg_t),

...and sizeof(elf_greg_t) is 64b in RV64 -- mismatch above.


Bj=C3=B6rn

