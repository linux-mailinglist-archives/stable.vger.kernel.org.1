Return-Path: <stable+bounces-158364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FBEAE6216
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 12:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8001889FBB
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C559428001B;
	Tue, 24 Jun 2025 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HT77GzcD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B6B1ADFFB
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760302; cv=none; b=aDD+E8dIc3G1a446OeXMRLDwdW8VQLep4LcuTwWIgIpBO3U1VhAobSdhP7fU5tPXbEfjQGXbcNdmz+uRRV/C24i8QyD9r02TlquB8k9c/gOXPfbH7lt7PiT8mGsOWtNO5FTi0LvU8LvVaLnbvznoodMqrbgpP97EtrUPE7WKza4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760302; c=relaxed/simple;
	bh=Y5MzJBXQ5X4KvmqXJEq6fl3dy5JM3XrdXo8oFqEmV4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UF3+vUx3qdlPsiEmwaB43BpH7O1VWxxZpeIOazzWjULa+1BMbYFW9qL79aQPzqVqKB7c+6r/nSdzWZRKZIqeWS04p1ZNha9xb7vcpj6R0UtnRZNWbu77K4055/2HI5bOm2PlW6syOZQw7ulKKOwGDGYlHulU+6hr2W9ouJHU8Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HT77GzcD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ade4679fba7so44106366b.2
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 03:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1750760298; x=1751365098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWqu+1LaUJ4vOaC8ZVde9RV8k83OR0Nm+TQAb21djPU=;
        b=HT77GzcDEBCywaeQJqklk6DdEh/XEnDLycVFvOvdFylJsymxeJfTV0k7rsAkd8CzIf
         Q5S3m5bM2aIsP7OUziu0wqqgaYvQaoWGelWT8LVpqzixr2kA9p6YI7ppOmVgJfky4rRY
         ZP4pmZmHzXEhC6aWyOentNxaxhjO2GeVRAICN8+x4LyHDBLGK7/3/R7O44uc2wWK2LsE
         KYekNVRWMxiqMkFQgSk1udHkyOpjqXV3oQN1myev4PkhQwCG1tjkptePcylr8+hS16sn
         p76p1JdwLwfdWXi+12Km3wsEUv0jvo1aNbZMzKv/vyL0rjSnq60cPWDdbrzDC98PrIsB
         XbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750760298; x=1751365098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWqu+1LaUJ4vOaC8ZVde9RV8k83OR0Nm+TQAb21djPU=;
        b=ejc5VUYoSWRS5MKm9EdXsINApNqqSKHu0ZjOMVpa9dQxEoCQ3UUizDkwF5QaWgkxSm
         bb4XlXF+FzxJenxIR4xFfvhjFUOUR0kA+4CNgnJ4fgsrOT9rfeiQcpHadzyqmb/Ekc8n
         C7d1owO3Q5DKFFlI3r8xMJ/w70DCQn/IVnh8QW1IghUdEhDv12rk8bTTnAsvktvuZNFr
         IUPmt0s/ELiTcXnXd5p0oX/dlEIWfABjQzfeKXeW5OWU3zfBD4J2PFpLGJWmwtDxc34Y
         Sgc1W1TudEc41kWgX6Xk63OAdRcdPtAED08kC4Ml9CJjixKlw1PeufHKNiRZWUWPxBk8
         7W6A==
X-Forwarded-Encrypted: i=1; AJvYcCXBahG7PHDFE6pRmY6nmjJ7IaNwfkbBWKz6OVCC9lkwamUPG47VYhSeoaa50YMHmHBT1Tw1TiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGl6aJi4qH04B2B304r73oKRIApBRqFwp5aokmM5uD8EOVj6g4
	HWkPjYfalX0LB0lSTCPc5eQz4tES5BlccwFJzBvhTbF6UXDM7uf/PRaDsiWRjMdJ1ehxkvRLEdY
	N5ajF3RV49jTQfPjk0VVwflBpDgxCC+fAeegG4+3rSg==
X-Gm-Gg: ASbGncuBIyPnAH8Zu0w6YLbW9SX9JHSL5KPLnQ6ewef0MMGPRJJbUxfU9qLCB1ajadr
	toFwSXcpAZIJjtB2Avhw4DfZ9Q6vathK42Qpw8k30tkyTpouj4DknGuTz6bzRcZDWDpaQq22CPY
	WHPP06sz9+sniuAQNWVFfoUiO5M4Dc2JOaEZZwektoUfYBDbapNuUwe0jPhf2c/TwAAVnGeP10P
	HJW
X-Google-Smtp-Source: AGHT+IGoHjGNBLw2UhznIjvcgot2AF/xmzqMZO2PKsk0kRsLDovvlO7tvr3+kiaPBWzKsw8sClPz8rqy+ALvhUY0vaA=
X-Received: by 2002:a17:907:2d87:b0:ad5:3055:784d with SMTP id
 a640c23a62f3a-ae057acdb1amr1294331566b.34.1750760298075; Tue, 24 Jun 2025
 03:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-riscv-hsm-boot-data-array-v1-1-50b5eeafbe61@iscas.ac.cn>
In-Reply-To: <20250624-riscv-hsm-boot-data-array-v1-1-50b5eeafbe61@iscas.ac.cn>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 24 Jun 2025 12:18:06 +0200
X-Gm-Features: Ac12FXx5-WAExY0uTcNX2mBO_fMMltoVB068ipOg_KmiOsq4h6xewKGGX165q5s
Message-ID: <CAHVXubiMWcyTOa5nBgzwQ2w5W-iKUGo8-n+8xkeEvjGCFqRugA@mail.gmail.com>
Subject: Re: [PATCH] riscv: cpu_ops_sbi: Use static array for boot_data
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Atish Patra <atishp@rivosinc.com>, 
	Anup Patel <anup@brainfault.org>, Vivian Wang <uwu@dram.page>, Han Gao <rabenda.cn@gmail.com>, 
	Yao Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vivian,

On Tue, Jun 24, 2025 at 10:05=E2=80=AFAM Vivian Wang <wangruikang@iscas.ac.=
cn> wrote:
>
> Since commit 6b9f29b81b15 ("riscv: Enable pcpu page first chunk
> allocator"), if NUMA is enabled, the page percpu allocator may be used
> on very sparse configurations, or when requested on boot with
> percpu_alloc=3Dpage.
>
> In that case, percpu data gets put in the vmalloc area. However,
> sbi_hsm_hart_start() needs the physical address of a sbi_hart_boot_data,
> and simply assumes that __pa() would work. This causes the just started
> hart to immediately access an invalid address and hang.
>
> Fortunately, struct sbi_hart_boot_data is not too large, so we can
> simply allocate an array for boot_data statically, putting it in the
> kernel image.
>
> This fixes NUMA=3Dy SMP boot on Sophgo SG2042.
>
> To reproduce on QEMU: Set CONFIG_NUMA=3Dy and CONFIG_DEBUG_VIRTUAL=3Dy, t=
hen
> run with:
>
>   qemu-system-riscv64 -M virt -smp 2 -nographic \
>     -kernel arch/riscv/boot/Image \
>     -append "percpu_alloc=3Dpage"
>
> Kernel output:
>
> [    0.000000] Booting Linux on hartid 0
> [    0.000000] Linux version 6.16.0-rc1 (dram@sakuya) (riscv64-unknown-li=
nux-gnu-gcc (GCC) 14.2.1 20250322, GNU ld (GNU Binutils) 2.44) #11 SMP Tue =
Jun 24 14:56:22 CST 2025
> ...
> [    0.000000] percpu: 28 4K pages/cpu s85784 r8192 d20712
> ...
> [    0.083192] smp: Bringing up secondary CPUs ...
> [    0.086722] ------------[ cut here ]------------
> [    0.086849] virt_to_phys used for non-linear address: (____ptrval____)=
 (0xff2000000001d080)
> [    0.088001] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/physaddr.c:14 __vi=
rt_to_phys+0xae/0xe8
> [    0.088376] Modules linked in:
> [    0.088656] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-rc=
1 #11 NONE
> [    0.088833] Hardware name: riscv-virtio,qemu (DT)
> [    0.088948] epc : __virt_to_phys+0xae/0xe8
> [    0.089001]  ra : __virt_to_phys+0xae/0xe8
> [    0.089037] epc : ffffffff80021eaa ra : ffffffff80021eaa sp : ff200000=
0004bbc0
> [    0.089057]  gp : ffffffff817f49c0 tp : ff60000001d60000 t0 : 5f6f745f=
74726976
> [    0.089076]  t1 : 0000000000000076 t2 : 705f6f745f747269 s0 : ff200000=
0004bbe0
> [    0.089095]  s1 : ff2000000001d080 a0 : 0000000000000000 a1 : 00000000=
00000000
> [    0.089113]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 00000000=
00000000
> [    0.089131]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 00000000=
00000000
> [    0.089155]  s2 : ffffffff8130dc00 s3 : 0000000000000001 s4 : 00000000=
00000001
> [    0.089174]  s5 : ffffffff8185eff8 s6 : ff2000007f1eb000 s7 : ffffffff=
8002a2ec
> [    0.089193]  s8 : 0000000000000001 s9 : 0000000000000001 s10: 00000000=
00000000
> [    0.089211]  s11: 0000000000000000 t3 : ffffffff8180a9f7 t4 : ffffffff=
8180a9f7
> [    0.089960]  t5 : ffffffff8180a9f8 t6 : ff2000000004b9d8
> [    0.089984] status: 0000000200000120 badaddr: ffffffff80021eaa cause: =
0000000000000003
> [    0.090101] [<ffffffff80021eaa>] __virt_to_phys+0xae/0xe8
> [    0.090228] [<ffffffff8001d796>] sbi_cpu_start+0x6e/0xe8
> [    0.090247] [<ffffffff8001a5da>] __cpu_up+0x1e/0x8c
> [    0.090260] [<ffffffff8002a32e>] bringup_cpu+0x42/0x258
> [    0.090277] [<ffffffff8002914c>] cpuhp_invoke_callback+0xe0/0x40c
> [    0.090292] [<ffffffff800294e0>] __cpuhp_invoke_callback_range+0x68/0x=
fc
> [    0.090320] [<ffffffff8002a96a>] _cpu_up+0x11a/0x244
> [    0.090334] [<ffffffff8002aae6>] cpu_up+0x52/0x90
> [    0.090384] [<ffffffff80c09350>] bringup_nonboot_cpus+0x78/0x118
> [    0.090411] [<ffffffff80c11060>] smp_init+0x34/0xb8
> [    0.090425] [<ffffffff80c01220>] kernel_init_freeable+0x148/0x2e4
> [    0.090442] [<ffffffff80b83802>] kernel_init+0x1e/0x14c
> [    0.090455] [<ffffffff800124ca>] ret_from_fork_kernel+0xe/0xf0
> [    0.090471] [<ffffffff80b8d9c2>] ret_from_fork_kernel_asm+0x16/0x18
> [    0.090560] ---[ end trace 0000000000000000 ]---
> [    1.179875] CPU1: failed to come online
> [    1.190324] smp: Brought up 1 node, 1 CPU
>
> Cc: stable@vger.kernel.org
> Reported-by: Han Gao <rabenda.cn@gmail.com>
> Fixes: 9a2451f18663 ("RISC-V: Avoid using per cpu array for ordered booti=
ng")

The Fixes should point to commit 6b9f29b81b15 ("riscv: Enable pcpu
page first chunk allocator"), but no need to send it back, I fixed it
when I merged it in my fixes branch.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

That's a good catch, thanks,

Alex

> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
>  arch/riscv/kernel/cpu_ops_sbi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_=
sbi.c
> index e6fbaaf549562d6e9ca63a66371441fe8b230cb3..87d6559448039cdd2e8a604a1=
9bd832ab5a98fc2 100644
> --- a/arch/riscv/kernel/cpu_ops_sbi.c
> +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> @@ -18,10 +18,10 @@ const struct cpu_operations cpu_ops_sbi;
>
>  /*
>   * Ordered booting via HSM brings one cpu at a time. However, cpu hotplu=
g can
> - * be invoked from multiple threads in parallel. Define a per cpu data
> + * be invoked from multiple threads in parallel. Define an array of boot=
 data
>   * to handle that.
>   */
> -static DEFINE_PER_CPU(struct sbi_hart_boot_data, boot_data);
> +static struct sbi_hart_boot_data boot_data[NR_CPUS];
>
>  static int sbi_hsm_hart_start(unsigned long hartid, unsigned long saddr,
>                               unsigned long priv)
> @@ -67,7 +67,7 @@ static int sbi_cpu_start(unsigned int cpuid, struct tas=
k_struct *tidle)
>         unsigned long boot_addr =3D __pa_symbol(secondary_start_sbi);
>         unsigned long hartid =3D cpuid_to_hartid_map(cpuid);
>         unsigned long hsm_data;
> -       struct sbi_hart_boot_data *bdata =3D &per_cpu(boot_data, cpuid);
> +       struct sbi_hart_boot_data *bdata =3D &boot_data[cpuid];
>
>         /* Make sure tidle is updated */
>         smp_mb();
>
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250624-riscv-hsm-boot-data-array-1d392098bd22
>
> Best regards,
> --
> Vivian "dramforever" Wang
>

