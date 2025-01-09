Return-Path: <stable+bounces-108143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8437BA07EEE
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 18:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3270C188D506
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 17:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A087E1991CB;
	Thu,  9 Jan 2025 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Nm90aTZr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B85196C7B
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444362; cv=none; b=LKy1aD9M58heriXD4qR5kyEz6AC7r8G0odtqkEvJcTdQCKixwCrfl+LQvljwvR8V4amEKhJJtNOhIU+PGYkDJA0SWBJvukw6rMmsiAGh65QZPzCaSLnC/H+9Eajtvd2oE1Os8um8tKNtW9PRe3Eeti96RFxxTELuVV8P4TH1T+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444362; c=relaxed/simple;
	bh=xJjyh93dyPuWvDsaUjVKUaYKqhqst1aun04qSKmXw8M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lTOEj8/VP0mq7VORcL2ktKaf+SwddxabzHf3e4Db/nImaWNY2UHzQgY9CKLC/utusQpUAN07M1iQz4iZd1ylb44PywnfpFQvAMBbQUftAWPnPemY4MWvxW73M3Rr+gZGyz6fxISZzpyF+KkBG9qH2tXtNKaby2oEiOOnWOL72Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Nm90aTZr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso13347985e9.2
        for <stable@vger.kernel.org>; Thu, 09 Jan 2025 09:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736444357; x=1737049157; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YXG0PxguO/d8CRBw8VtJ++ZPzeprgh70tilaSvwFG4=;
        b=Nm90aTZrNlmdH9YMuNbDxzYexoRH5cVVmtfbmE8x1Q0ECW7/DMPZFJvURzkpE8UoCe
         qpyfQYvqtLoh0EznyZxrKn8yQXtA60aXjjTvmjokE/98QLUeMh30bivrU9B/AfI3IpEs
         hrgFNIeFs80qKv84XqIEXCFeJVL/CmqqK+xNwmKZpJepYS2dXb8HS6VS4MuhmY16Z9Wq
         yBZ3yIeFyGAcbWyqmFaJEk292PY0yRQTuqHQ8ybz/jvDU3II4rPGHskKR1K5qfAAeaiO
         u3nfkRpTZjl+OouQu2K6Q7PYQOVFzM0+Og5ktx4IwNIxnd7XYF1nuV7iv8TORry5sNa9
         25lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736444357; x=1737049157;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YXG0PxguO/d8CRBw8VtJ++ZPzeprgh70tilaSvwFG4=;
        b=AHySr2SGbp0Bd474L2D1sKqbd6Qir2fXyOx08+wA/itxh+Fdvy86oLBYcMvCb6alWo
         LkVk7C6aqd1XA/4swSInzNRxIDb5CoFV9d2+7wN4FL4XlMagmN+IrrkaFAMk+vtbhbsH
         wpA4AnUPdaVtnGPDNAewvjIYB8b1EopSD2Ce48hJsXJ+OPj1CgGYXZNiRdBkfZFt3ClX
         99FeIGKE9HE+1aVBDZiyuv7GabZ35vVPUrU9FdhIpR98OMNIfQ9Rdlxb8GNA93qW4mWn
         sL37+cNWzWBN6VBbowqkLbePkioHYNy9RavlLPCj3+Umqbj/krg8AiLsS+J5vfVxSb4d
         56Mw==
X-Gm-Message-State: AOJu0Yx6RGcVynGrl1aYdjYEnc5dl2RJ3bXziBkt0ZSh1jqyHatpy11/
	z++R0fm6eFhbXRikRXRD3jzYtjBI6OvXnSoQALQbcgJVFk2NcPeZ8oLbtWRnB8U=
X-Gm-Gg: ASbGncuMTp3CrNFPyFjBKJtOx6CtEa92bjCYyBrbF30Yq6RVOlUg8imLEMDmQcr1Nhg
	fJMjsmIYIq6SDXs3Axft5tlHg2gY33yVLlwZxNBBZmhdtCgp6m2DiRIaEAYCskhEwWsQL7m9MmV
	7BwfAJkuaAtTZzwtMRUlwAdESfHw4XCd8CV2hTbDyuloFhf+V+lBairRLgUSGRoN3/bTv/t99/N
	HEMeP45iH9lUJh+c0luYh7XSX1PjUpiwB+Bepw8QtSBnRT5OXSAfvhaBy3eCTz3
X-Google-Smtp-Source: AGHT+IEUUeOq3YKkx8QUwzwHMooo6QncbeHbK4FND7g5C/+74EvhnXFx5YPQ/ESX1ZV7NbQMWneebg==
X-Received: by 2002:a05:600c:3149:b0:434:f297:8e78 with SMTP id 5b1f17b1804b1-436e267fbe1mr70418645e9.7.1736444357500;
        Thu, 09 Jan 2025 09:39:17 -0800 (PST)
Received: from smtpclient.apple ([104.28.154.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92f60sm61210315e9.40.2025.01.09.09.39.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2025 09:39:16 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH 6.6 079/222] x86, crash: wrap crash dumping code into
 crash related ifdefs
From: Ignat Korchagin <ignat@cloudflare.com>
In-Reply-To: <20250106151153.592449889@linuxfoundation.org>
Date: Thu, 9 Jan 2025 17:39:04 +0000
Cc: stable@vger.kernel.org,
 patches@lists.linux.dev,
 Al Viro <viro@zeniv.linux.org.uk>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Pingfan Liu <piliu@redhat.com>,
 Klara Modin <klarasmodin@gmail.com>,
 Michael Kelley <mhklinux@outlook.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Yang Li <yang.lee@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sasha Levin <sashal@kernel.org>,
 kernel-team@cloudflare.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3DB3A6D3-0D3A-4682-B4FA-407B2D3263B2@cloudflare.com>
References: <20250106151150.585603565@linuxfoundation.org>
 <20250106151153.592449889@linuxfoundation.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Baoquan He <bhe@redhat.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)

Hi,

> On 6 Jan 2025, at 15:14, Greg Kroah-Hartman =
<gregkh@linuxfoundation.org> wrote:
>=20
> 6.6-stable review patch.  If anyone has any objections, please let me =
know.

I think this back port breaks 6.6 build (namely vmlinux.o link stage):
  LD [M]  net/netfilter/xt_nat.ko
  LD [M]  net/netfilter/xt_addrtype.ko
  LD [M]  net/ipv4/netfilter/iptable_nat.ko
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  LD      .tmp_vmlinux.kallsyms1
ld: vmlinux.o: in function `__crash_kexec':
(.text+0x15a93a): undefined reference to `machine_crash_shutdown'
ld: vmlinux.o: in function `__do_sys_kexec_file_load':
kexec_file.c:(.text+0x15cef1): undefined reference to =
`arch_kexec_protect_crashkres'
ld: kexec_file.c:(.text+0x15cf28): undefined reference to =
`arch_kexec_unprotect_crashkres'
make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
make[1]: *** [/home/ignat/git/test/mainline/linux-6.6.70/Makefile:1164: =
vmlinux] Error 2
make: *** [Makefile:234: __sub-make] Error 2

The KEXEC config setup, which triggers above:

# Kexec and crash features
#
CONFIG_CRASH_CORE=3Dy
CONFIG_KEXEC_CORE=3Dy
# CONFIG_KEXEC is not set
CONFIG_KEXEC_FILE=3Dy
# CONFIG_KEXEC_SIG is not set
# CONFIG_CRASH_DUMP is not set
# end of Kexec and crash features
# end of General setup

>=20
> ------------------
>=20
> From: Baoquan He <bhe@redhat.com>
>=20
> [ Upstream commit a4eeb2176d89fdf2785851521577b94b31690a60 ]
>=20
> Now crash codes under kernel/ folder has been split out from kexec
> code, crash dumping can be separated from kexec reboot in config
> items on x86 with some adjustments.
>=20
> Here, also change some ifdefs or IS_ENABLED() check to more =
appropriate
> ones, e,g
> - #ifdef CONFIG_KEXEC_CORE -> #ifdef CONFIG_CRASH_DUMP
> - (!IS_ENABLED(CONFIG_KEXEC_CORE)) - > =
(!IS_ENABLED(CONFIG_CRASH_RESERVE))
>=20
> [bhe@redhat.com: don't nest CONFIG_CRASH_DUMP ifdef inside =
CONFIG_KEXEC_CODE ifdef scope]
>  Link: =
https://lore.kernel.org/all/SN6PR02MB4157931105FA68D72E3D3DB8D47B2@SN6PR02=
MB4157.namprd02.prod.outlook.com/T/#u
> Link: https://lkml.kernel.org/r/20240124051254.67105-7-bhe@redhat.com
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Pingfan Liu <piliu@redhat.com>
> Cc: Klara Modin <klarasmodin@gmail.com>
> Cc: Michael Kelley <mhklinux@outlook.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Yang Li <yang.lee@linux.alibaba.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: bcc80dec91ee ("x86/hyperv: Fix hv tsc page based =
sched_clock for hibernation")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> arch/x86/kernel/Makefile           |  4 ++--
> arch/x86/kernel/cpu/mshyperv.c     | 10 ++++++++--
> arch/x86/kernel/kexec-bzimage64.c  |  4 ++++
> arch/x86/kernel/kvm.c              |  4 ++--
> arch/x86/kernel/machine_kexec_64.c |  3 +++
> arch/x86/kernel/reboot.c           |  4 ++--
> arch/x86/kernel/setup.c            |  2 +-
> arch/x86/kernel/smp.c              |  2 +-
> arch/x86/xen/enlighten_hvm.c       |  4 ++++
> arch/x86/xen/mmu_pv.c              |  2 +-
> 10 files changed, 28 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 3269a0e23d3a..15fc9fc3dcf0 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -99,9 +99,9 @@ obj-$(CONFIG_TRACING) +=3D trace.o
> obj-$(CONFIG_RETHOOK) +=3D rethook.o
> obj-$(CONFIG_CRASH_CORE) +=3D crash_core_$(BITS).o
> obj-$(CONFIG_KEXEC_CORE) +=3D machine_kexec_$(BITS).o
> -obj-$(CONFIG_KEXEC_CORE) +=3D relocate_kernel_$(BITS).o crash.o
> +obj-$(CONFIG_KEXEC_CORE) +=3D relocate_kernel_$(BITS).o
> obj-$(CONFIG_KEXEC_FILE) +=3D kexec-bzimage64.o
> -obj-$(CONFIG_CRASH_DUMP) +=3D crash_dump_$(BITS).o
> +obj-$(CONFIG_CRASH_DUMP) +=3D crash_dump_$(BITS).o crash.o
> obj-y +=3D kprobes/
> obj-$(CONFIG_MODULES) +=3D module.o
> obj-$(CONFIG_X86_32) +=3D doublefault_32.o
> diff --git a/arch/x86/kernel/cpu/mshyperv.c =
b/arch/x86/kernel/cpu/mshyperv.c
> index bcb2d640a0cd..93e1cb4f7ff1 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -209,7 +209,9 @@ static void hv_machine_shutdown(void)
> if (kexec_in_progress)
> hyperv_cleanup();
> }
> +#endif /* CONFIG_KEXEC_CORE */
>=20
> +#ifdef CONFIG_CRASH_DUMP
> static void hv_machine_crash_shutdown(struct pt_regs *regs)
> {
> if (hv_crash_handler)
> @@ -221,7 +223,7 @@ static void hv_machine_crash_shutdown(struct =
pt_regs *regs)
> /* Disable the hypercall page when there is only 1 active CPU. */
> hyperv_cleanup();
> }
> -#endif /* CONFIG_KEXEC_CORE */
> +#endif /* CONFIG_CRASH_DUMP */
> #endif /* CONFIG_HYPERV */
>=20
> static uint32_t  __init ms_hyperv_platform(void)
> @@ -493,9 +495,13 @@ static void __init ms_hyperv_init_platform(void)
> no_timer_check =3D 1;
> #endif
>=20
> -#if IS_ENABLED(CONFIG_HYPERV) && defined(CONFIG_KEXEC_CORE)
> +#if IS_ENABLED(CONFIG_HYPERV)
> +#if defined(CONFIG_KEXEC_CORE)
> machine_ops.shutdown =3D hv_machine_shutdown;
> +#endif
> +#if defined(CONFIG_CRASH_DUMP)
> machine_ops.crash_shutdown =3D hv_machine_crash_shutdown;
> +#endif
> #endif
> if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
> /*
> diff --git a/arch/x86/kernel/kexec-bzimage64.c =
b/arch/x86/kernel/kexec-bzimage64.c
> index a61c12c01270..0de509c02d18 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -263,11 +263,13 @@ setup_boot_parameters(struct kimage *image, =
struct boot_params *params,
> memset(&params->hd0_info, 0, sizeof(params->hd0_info));
> memset(&params->hd1_info, 0, sizeof(params->hd1_info));
>=20
> +#ifdef CONFIG_CRASH_DUMP
> if (image->type =3D=3D KEXEC_TYPE_CRASH) {
> ret =3D crash_setup_memmap_entries(image, params);
> if (ret)
> return ret;
> } else
> +#endif
> setup_e820_entries(params);
>=20
> nr_e820_entries =3D params->e820_entries;
> @@ -428,12 +430,14 @@ static void *bzImage64_load(struct kimage =
*image, char *kernel,
> return ERR_PTR(-EINVAL);
> }
>=20
> +#ifdef CONFIG_CRASH_DUMP
> /* Allocate and load backup region */
> if (image->type =3D=3D KEXEC_TYPE_CRASH) {
> ret =3D crash_load_segments(image);
> if (ret)
> return ERR_PTR(ret);
> }
> +#endif
>=20
> /*
> * Load purgatory. For 64bit entry point, purgatory  code can be
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index b8ab9ee5896c..38d88c8b56ec 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -769,7 +769,7 @@ static struct notifier_block kvm_pv_reboot_nb =3D =
{
>  * won't be valid. In cases like kexec, in which you install a new =
kernel, this
>  * means a random memory location will be kept being written.
>  */
> -#ifdef CONFIG_KEXEC_CORE
> +#ifdef CONFIG_CRASH_DUMP
> static void kvm_crash_shutdown(struct pt_regs *regs)
> {
> kvm_guest_cpu_offline(true);
> @@ -852,7 +852,7 @@ static void __init kvm_guest_init(void)
> kvm_guest_cpu_init();
> #endif
>=20
> -#ifdef CONFIG_KEXEC_CORE
> +#ifdef CONFIG_CRASH_DUMP
> machine_ops.crash_shutdown =3D kvm_crash_shutdown;
> #endif
>=20
> diff --git a/arch/x86/kernel/machine_kexec_64.c =
b/arch/x86/kernel/machine_kexec_64.c
> index 2fa12d1dc676..aaeac2deb85d 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -545,6 +545,8 @@ int arch_kimage_file_post_load_cleanup(struct =
kimage *image)
> }
> #endif /* CONFIG_KEXEC_FILE */
>=20
> +#ifdef CONFIG_CRASH_DUMP
> +
> static int
> kexec_mark_range(unsigned long start, unsigned long end, bool protect)
> {
> @@ -589,6 +591,7 @@ void arch_kexec_unprotect_crashkres(void)
> {
> kexec_mark_crashkres(false);
> }
> +#endif
>=20
> /*
>  * During a traditional boot under SME, SME will encrypt the kernel,
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 830425e6d38e..f3130f762784 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -796,7 +796,7 @@ struct machine_ops machine_ops __ro_after_init =3D =
{
> .emergency_restart =3D native_machine_emergency_restart,
> .restart =3D native_machine_restart,
> .halt =3D native_machine_halt,
> -#ifdef CONFIG_KEXEC_CORE
> +#ifdef CONFIG_CRASH_DUMP
> .crash_shutdown =3D native_machine_crash_shutdown,
> #endif
> };
> @@ -826,7 +826,7 @@ void machine_halt(void)
> machine_ops.halt();
> }
>=20
> -#ifdef CONFIG_KEXEC_CORE
> +#ifdef CONFIG_CRASH_DUMP
> void machine_crash_shutdown(struct pt_regs *regs)
> {
> machine_ops.crash_shutdown(regs);
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index eb129277dcdd..8bcecabd475b 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -547,7 +547,7 @@ static void __init reserve_crashkernel(void)
> bool high =3D false;
> int ret;
>=20
> - if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> + if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
> return;
>=20
> total_mem =3D memblock_phys_mem_size();
> diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
> index 96a771f9f930..52c3823b7211 100644
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -282,7 +282,7 @@ struct smp_ops smp_ops =3D {
> .smp_cpus_done =3D native_smp_cpus_done,
>=20
> .stop_other_cpus =3D native_stop_other_cpus,
> -#if defined(CONFIG_KEXEC_CORE)
> +#if defined(CONFIG_CRASH_DUMP)
> .crash_stop_other_cpus =3D kdump_nmi_shootdown_cpus,
> #endif
> .smp_send_reschedule =3D native_smp_send_reschedule,
> diff --git a/arch/x86/xen/enlighten_hvm.c =
b/arch/x86/xen/enlighten_hvm.c
> index 70be57e8f51c..ade22feee7ae 100644
> --- a/arch/x86/xen/enlighten_hvm.c
> +++ b/arch/x86/xen/enlighten_hvm.c
> @@ -141,7 +141,9 @@ static void xen_hvm_shutdown(void)
> if (kexec_in_progress)
> xen_reboot(SHUTDOWN_soft_reset);
> }
> +#endif
>=20
> +#ifdef CONFIG_CRASH_DUMP
> static void xen_hvm_crash_shutdown(struct pt_regs *regs)
> {
> native_machine_crash_shutdown(regs);
> @@ -229,6 +231,8 @@ static void __init xen_hvm_guest_init(void)
>=20
> #ifdef CONFIG_KEXEC_CORE
> machine_ops.shutdown =3D xen_hvm_shutdown;
> +#endif
> +#ifdef CONFIG_CRASH_DUMP
> machine_ops.crash_shutdown =3D xen_hvm_crash_shutdown;
> #endif
> }
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index 6b201e64d8ab..bfd57d07f4b5 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -2517,7 +2517,7 @@ int xen_remap_pfn(struct vm_area_struct *vma, =
unsigned long addr,
> }
> EXPORT_SYMBOL_GPL(xen_remap_pfn);
>=20
> -#ifdef CONFIG_KEXEC_CORE
> +#ifdef CONFIG_VMCORE_INFO
> phys_addr_t paddr_vmcoreinfo_note(void)
> {
> if (xen_pv_domain())
> --=20
> 2.39.5
>=20
>=20
>=20
>=20


