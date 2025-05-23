Return-Path: <stable+bounces-146156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300F6AC1AFE
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 06:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F17B07AE7E9
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 04:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B252223705;
	Fri, 23 May 2025 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="VrnK9DOF"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE9D221F02;
	Fri, 23 May 2025 04:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975110; cv=none; b=fsSUo6XdyOPXxlkBg+4uCJQuT2rar0vILJKGoKVf5IO5O6iYz5za2c/4MgeBHl6HAkXktCnchG2S4QCaHRAmy6tkFtRbqKyYf3OMEnXNxmMgNljFQVSq1M7rWlCJpf/qT//UETaT4hktHQImEa3hd6c4I8Kn8WIsxouMGpXtAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975110; c=relaxed/simple;
	bh=a/JZyFcVbDdMl3wBLht2H1TNeRlXkJpXprbZXB72vPg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nMxrYmCtPU7x75FLlgNwAPlg9MEb5s89SRiYLs18MxFdCubxz3AkEkInbkASWdVcg9xzhMZ7WuSDskL8A/U+C/vh/yT9Ou99gGaaBRs4RhkwuZIypmaoA0znimDndw6V3NpOijr9JLxqOAjZnnwtvAGO1PWr7mZHSCbB3BHLK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=VrnK9DOF; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1747975099;
	bh=P3GbIFecJCf5r7y3U16vrNGC62olL5+u/CI+cmj67mU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VrnK9DOFdx7wVwvZ4le7YsuTqT6unP62HPiAzPOGFnQgQHck9y6OwpPNlPmW4SyaB
	 IajtjSItFCgXr4eisgkTObonJZYFHpJOQBw8v9GZ21CDZPhmMJp9tqjtN/e9bJyZ+X
	 7oO1mZLtC1zhqY3O6yshYKWfAeLPvDf4LCar/yUw=
Received: from [192.168.124.38] (unknown [113.200.174.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 0EE7865F62;
	Fri, 23 May 2025 00:38:17 -0400 (EDT)
Message-ID: <fa882110d20bd824aca690ba5dfea8c0bd303fc3.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Avoid using $r0/$r1 as "mask" for csrxchg
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren	
 <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang	
 <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,  WANG Rui <wangrui@loongson.cn>
Date: Fri, 23 May 2025 12:38:15 +0800
In-Reply-To: <20250522125050.2215157-1-chenhuacai@loongson.cn>
References: <20250522125050.2215157-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-22 at 20:50 +0800, Huacai Chen wrote:
> When building kernel with LLVM there are occasionally such errors:
>=20
> In file included from ./include/linux/spinlock.h:59:
> In file included from ./include/linux/irqflags.h:17:
> arch/loongarch/include/asm/irqflags.h:38:3: error: must not be $r0 or $r1
> =C2=A0=C2=A0 38 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "csrxchg %[val], %[mask], %[reg]=
\n\t"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> <inline asm>:1:16: note: instantiated into assembly here
> =C2=A0=C2=A0=C2=A0 1 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cs=
rxchg $a1, $ra, 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^
>=20
> The "mask" of the csrxchg instruction should not be $r0 or $r1, but the
> compiler cannot avoid generating such code currently.

Maybe "to prevent the compiler from allocating $r0 or $r1, the 'q'
constraint must be used but Clang < 22 does not support it.  So force to
use t0 in order to avoid using $r0/$r1 while keeping the backward
compatibility."

And Link: https://github.com/llvm/llvm-project/pull/141037

> So force to use t0
> in the inline asm, in order to avoid using $r0/$r1.
>=20
> Cc: stable@vger.kernel.org
> Suggested-by: WANG Rui <wangrui@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> =C2=A0arch/loongarch/include/asm/irqflags.h | 16 ++++++++++++----
> =C2=A01 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/loongarch/include/asm/irqflags.h b/arch/loongarch/inclu=
de/asm/irqflags.h
> index 319a8c616f1f..003172b8406b 100644
> --- a/arch/loongarch/include/asm/irqflags.h
> +++ b/arch/loongarch/include/asm/irqflags.h
> @@ -14,40 +14,48 @@
> =C2=A0static inline void arch_local_irq_enable(void)
> =C2=A0{
> =C2=A0	u32 flags =3D CSR_CRMD_IE;
> +	register u32 mask asm("t0") =3D CSR_CRMD_IE;
> +
> =C2=A0	__asm__ __volatile__(
> =C2=A0		"csrxchg %[val], %[mask], %[reg]\n\t"
> =C2=A0		: [val] "+r" (flags)
> -		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
> +		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
> =C2=A0		: "memory");
> =C2=A0}
> =C2=A0
> =C2=A0static inline void arch_local_irq_disable(void)
> =C2=A0{
> =C2=A0	u32 flags =3D 0;
> +	register u32 mask asm("t0") =3D CSR_CRMD_IE;
> +
> =C2=A0	__asm__ __volatile__(
> =C2=A0		"csrxchg %[val], %[mask], %[reg]\n\t"
> =C2=A0		: [val] "+r" (flags)
> -		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
> +		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
> =C2=A0		: "memory");
> =C2=A0}
> =C2=A0
> =C2=A0static inline unsigned long arch_local_irq_save(void)
> =C2=A0{
> =C2=A0	u32 flags =3D 0;
> +	register u32 mask asm("t0") =3D CSR_CRMD_IE;
> +
> =C2=A0	__asm__ __volatile__(
> =C2=A0		"csrxchg %[val], %[mask], %[reg]\n\t"
> =C2=A0		: [val] "+r" (flags)
> -		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
> +		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
> =C2=A0		: "memory");
> =C2=A0	return flags;
> =C2=A0}
> =C2=A0
> =C2=A0static inline void arch_local_irq_restore(unsigned long flags)
> =C2=A0{
> +	register u32 mask asm("t0") =3D CSR_CRMD_IE;
> +
> =C2=A0	__asm__ __volatile__(
> =C2=A0		"csrxchg %[val], %[mask], %[reg]\n\t"
> =C2=A0		: [val] "+r" (flags)
> -		: [mask] "r" (CSR_CRMD_IE), [reg] "i" (LOONGARCH_CSR_CRMD)
> +		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
> =C2=A0		: "memory");
> =C2=A0}
> =C2=A0

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

