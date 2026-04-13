Return-Path: <stable+bounces-235880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBRpMdxe3Gk9QAkAu9opvQ
	(envelope-from <stable+bounces-235880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:11:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A823E6E4C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14E55300F53E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 03:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C9723D291;
	Mon, 13 Apr 2026 03:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUs0RGc5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464DB23B612
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 03:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776049875; cv=none; b=Wyp51cIZ1Ay6FBUSeCvDywHXaA0eKC/lOZDsRJkelcl3LPUqQRZ3x6HAdYEJfH85F1kk5nMGuP6eT3Vs3nvoFnUj1X3XepLP1J0q1JRhv0YT7aRB9JpQwYfxG/T9o7LlJxRAznXF3yHjj5e7yPsgem2EnPhwR5dbtDbDbnCauro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776049875; c=relaxed/simple;
	bh=uYPbvxDIHzaKyG7V2bESecXb3X04h+3d1tP/Kd+6zI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bja2BAIvIvO1zB+QIXCgRegmPrqKCVNobMPGJcNFnbX0F2GJiL93W1fFzytcqOB422fZBNeaFVyNlHFmOT3w24AL5Bh7eYmCZbiw3kVEZVcpXgo+lgyuck49nq6d132Nh8fSkDHIm3yiH6ESDAKp0Dzc/kKZcVPJjJ7L80Wn4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUs0RGc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D1BC2BCB4
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 03:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776049875;
	bh=uYPbvxDIHzaKyG7V2bESecXb3X04h+3d1tP/Kd+6zI8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hUs0RGc5YAQh9GhTKgejN9KdLDsY81BeXt8uKktG7LdgY+MRvmEXbBwBopLQiJj8h
	 E3U6kWxYHzEwFm2Up2jmP5L5/TfUmm649sdv0eXtDCl2w1DT+2wchFRvcnZQqtHye5
	 gFC3+V22qDNCUZwm1xzJA1KKisClXANgHwW0xoThf/r+05f8gfg6iVsNTy7G84FhVO
	 +76FhAGX/sL4sojrWMsT5VtllwUTacyo3GbXBdPHU6ZHwjpCqEqX7+UY6gOsWTnLYp
	 /h+2EV4K7e7dve33M71QWYc/iThGgkz8ClVBzeZOcEcb5PfR3T2xaliKOqln1S0ZcO
	 /n1X7fslp0P6w==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so5468084a12.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 20:11:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwQ1oxMe+aINJ8SLCPAZpKqgiiMkgjqiBlAg9/5rtslZzskYeRE899gQ1TtkoTfca6l7qhvy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtDZcRgdsS9aSibUUaG8M444VAIFNxNAUL+8+wA6owN+7vHg9
	Bv6kN7SPHR5Q9dpyDgqt8EE1yWa29VxYf1ztJ/Bj2bzPx2mXlz2yAfAdi7xOiriwEg6/SwFD6yn
	+J7jnD02YzrjJ4Oqcj4VnhoLg+5qSmU0=
X-Received: by 2002:a17:907:9611:b0:b9c:cb04:9fe6 with SMTP id
 a640c23a62f3a-b9d7248afc8mr616444566b.14.1776049872642; Sun, 12 Apr 2026
 20:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251227012712.2921408-1-lixianglai@loongson.cn>
 <20251227012712.2921408-3-lixianglai@loongson.cn> <08143343-cb10-9376-e7df-68ad854b9275@loongson.cn>
 <9e1a8d4f-251f-f78e-01a3-5c483249fac8@loongson.cn> <dec5cb06-6858-20f2-facb-d5e7f44f5d16@loongson.cn>
 <df8f52e3-fea5-763a-d5fd-629308dc6fcc@loongson.cn> <a1009e1e-34de-68b4-7680-d2a99a06a71c@loongson.cn>
 <efa4ef2d-aef7-0f64-07bc-55d0c4d1d6d2@loongson.cn> <ebd5a137-1bee-8fab-71bf-5f359dabe5d8@loongson.cn>
 <4ad5180d-cb4d-b916-3872-b24c5a2cd1d8@loongson.cn> <aeb75309-61eb-a3fa-fdaa-544978d2534a@loongson.cn>
 <f6d9b67f-451f-6881-cfc0-c37df96de087@loongson.cn> <CAAhV-H4xPKOYqH+=4A+NpWraF7SkuVN7FUBsNZfxgCBFLDNO_Q@mail.gmail.com>
 <698b1746-b6d5-e234-65f0-30ee22d7e81b@loongson.cn>
In-Reply-To: <698b1746-b6d5-e234-65f0-30ee22d7e81b@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 13 Apr 2026 11:11:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7D801S5SRvQzWYv0m3b-HYz-P_AfGwQdaXZvOfXVEhCA@mail.gmail.com>
X-Gm-Features: AQROBzDN2S8L2bzBpBVZSwfRSlVZkludIoapJyNsOw-Go6GFCC1kefL9w6sjhas
Message-ID: <CAAhV-H7D801S5SRvQzWYv0m3b-HYz-P_AfGwQdaXZvOfXVEhCA@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] LoongArch: KVM: fix "unreliable stack" issue
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jinyang He <hejinyang@loongson.cn>, lixianglai <lixianglai@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org, 
	WANG Xuerui <kernel@xen0n.name>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Charlie Jenkins <charlie@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235880-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 29A823E6E4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 9:01=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2026/4/11 =E4=B8=8B=E5=8D=8810:24, Huacai Chen wrote:
> > On Wed, Apr 8, 2026 at 9:26=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> w=
rote:
> >>
> >>
> >>
> >> On 2025/12/30 =E4=B8=8B=E5=8D=881:53, Jinyang He wrote:
> >>> On 2025-12-30 12:03, Bibo Mao wrote:
> >>>
> >>>>
> >>>>
> >>>> On 2025/12/30 =E4=B8=8A=E5=8D=8811:36, Jinyang He wrote:
> >>>>> On 2025-12-30 10:24, Bibo Mao wrote:
> >>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2025/12/29 =E4=B8=8B=E5=8D=886:41, Jinyang He wrote:
> >>>>>>> On 2025-12-29 18:11, lixianglai wrote:
> >>>>>>>
> >>>>>>>> Hi Jinyang:
> >>>>>>>>>
> >>>>>>>>> On 2025-12-29 11:53, lixianglai wrote:
> >>>>>>>>>> Hi Jinyang:
> >>>>>>>>>>> On 2025-12-27 09:27, Xianglai Li wrote:
> >>>>>>>>>>>
> >>>>>>>>>>>> Insert the appropriate UNWIND macro definition into the
> >>>>>>>>>>>> kvm_exc_entry in
> >>>>>>>>>>>> the assembly function to guide the generation of correct ORC
> >>>>>>>>>>>> table entries,
> >>>>>>>>>>>> thereby solving the timeout problem of loading the
> >>>>>>>>>>>> livepatch-sample module
> >>>>>>>>>>>> on a physical machine running multiple vcpus virtual machine=
s.
> >>>>>>>>>>>>
> >>>>>>>>>>>> While solving the above problems, we have gained an addition=
al
> >>>>>>>>>>>> benefit,
> >>>>>>>>>>>> that is, we can obtain more call stack information
> >>>>>>>>>>>>
> >>>>>>>>>>>> Stack information that can be obtained before the problem is
> >>>>>>>>>>>> fixed:
> >>>>>>>>>>>> [<0>] kvm_vcpu_block+0x88/0x120 [kvm]
> >>>>>>>>>>>> [<0>] kvm_vcpu_halt+0x68/0x580 [kvm]
> >>>>>>>>>>>> [<0>] kvm_emu_idle+0xd4/0xf0 [kvm]
> >>>>>>>>>>>> [<0>] kvm_handle_gspr+0x7c/0x700 [kvm]
> >>>>>>>>>>>> [<0>] kvm_handle_exit+0x160/0x270 [kvm]
> >>>>>>>>>>>> [<0>] kvm_exc_entry+0x100/0x1e0
> >>>>>>>>>>>>
> >>>>>>>>>>>> Stack information that can be obtained after the problem is
> >>>>>>>>>>>> fixed:
> >>>>>>>>>>>> [<0>] kvm_vcpu_block+0x88/0x120 [kvm]
> >>>>>>>>>>>> [<0>] kvm_vcpu_halt+0x68/0x580 [kvm]
> >>>>>>>>>>>> [<0>] kvm_emu_idle+0xd4/0xf0 [kvm]
> >>>>>>>>>>>> [<0>] kvm_handle_gspr+0x7c/0x700 [kvm]
> >>>>>>>>>>>> [<0>] kvm_handle_exit+0x160/0x270 [kvm]
> >>>>>>>>>>>> [<0>] kvm_exc_entry+0x104/0x1e4
> >>>>>>>>>>>> [<0>] kvm_enter_guest+0x38/0x11c
> >>>>>>>>>>>> [<0>] kvm_arch_vcpu_ioctl_run+0x26c/0x498 [kvm]
> >>>>>>>>>>>> [<0>] kvm_vcpu_ioctl+0x200/0xcf8 [kvm]
> >>>>>>>>>>>> [<0>] sys_ioctl+0x498/0xf00
> >>>>>>>>>>>> [<0>] do_syscall+0x98/0x1d0
> >>>>>>>>>>>> [<0>] handle_syscall+0xb8/0x158
> >>>>>>>>>>>>
> >>>>>>>>>>>> Cc: stable@vger.kernel.org
> >>>>>>>>>>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>> Cc: Huacai Chen <chenhuacai@kernel.org>
> >>>>>>>>>>>> Cc: WANG Xuerui <kernel@xen0n.name>
> >>>>>>>>>>>> Cc: Tianrui Zhao <zhaotianrui@loongson.cn>
> >>>>>>>>>>>> Cc: Bibo Mao <maobibo@loongson.cn>
> >>>>>>>>>>>> Cc: Charlie Jenkins <charlie@rivosinc.com>
> >>>>>>>>>>>> Cc: Xianglai Li <lixianglai@loongson.cn>
> >>>>>>>>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>>>>>>>>>>> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> >>>>>>>>>>>>
> >>>>>>>>>>>>    arch/loongarch/kvm/switch.S | 28 +++++++++++++++++++-----=
----
> >>>>>>>>>>>>    1 file changed, 19 insertions(+), 9 deletions(-)
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/arch/loongarch/kvm/switch.S
> >>>>>>>>>>>> b/arch/loongarch/kvm/switch.S
> >>>>>>>>>>>> index 93845ce53651..a3ea9567dbe5 100644
> >>>>>>>>>>>> --- a/arch/loongarch/kvm/switch.S
> >>>>>>>>>>>> +++ b/arch/loongarch/kvm/switch.S
> >>>>>>>>>>>> @@ -10,6 +10,7 @@
> >>>>>>>>>>>>    #include <asm/loongarch.h>
> >>>>>>>>>>>>    #include <asm/regdef.h>
> >>>>>>>>>>>>    #include <asm/unwind_hints.h>
> >>>>>>>>>>>> +#include <linux/kvm_types.h>
> >>>>>>>>>>>>      #define HGPR_OFFSET(x)        (PT_R0 + 8*x)
> >>>>>>>>>>>>    #define GGPR_OFFSET(x)        (KVM_ARCH_GGPR + 8*x)
> >>>>>>>>>>>> @@ -110,9 +111,9 @@
> >>>>>>>>>>>>         * need to copy world switch code to DMW area.
> >>>>>>>>>>>>         */
> >>>>>>>>>>>>        .text
> >>>>>>>>>>>> +    .p2align PAGE_SHIFT
> >>>>>>>>>>>>        .cfi_sections    .debug_frame
> >>>>>>>>>>>>    SYM_CODE_START(kvm_exc_entry)
> >>>>>>>>>>>> -    .p2align PAGE_SHIFT
> >>>>>>>>>>>>        UNWIND_HINT_UNDEFINED
> >>>>>>>>>>>>        csrwr    a2,   KVM_TEMP_KS
> >>>>>>>>>>>>        csrrd    a2,   KVM_VCPU_KS
> >>>>>>>>>>>> @@ -170,6 +171,7 @@ SYM_CODE_START(kvm_exc_entry)
> >>>>>>>>>>>>        /* restore per cpu register */
> >>>>>>>>>>>>        ld.d    u0, a2, KVM_ARCH_HPERCPU
> >>>>>>>>>>>>        addi.d    sp, sp, -PT_SIZE
> >>>>>>>>>>>> +    UNWIND_HINT_REGS
> >>>>>>>>>>>>          /* Prepare handle exception */
> >>>>>>>>>>>>        or    a0, s0, zero
> >>>>>>>>>>>> @@ -200,7 +202,7 @@ ret_to_host:
> >>>>>>>>>>>>        jr      ra
> >>>>>>>>>>>>      SYM_CODE_END(kvm_exc_entry)
> >>>>>>>>>>>> -EXPORT_SYMBOL(kvm_exc_entry)
> >>>>>>>>>>>> +EXPORT_SYMBOL_FOR_KVM(kvm_exc_entry)
> >>>>>>>>>>>>      /*
> >>>>>>>>>>>>     * int kvm_enter_guest(struct kvm_run *run, struct kvm_vc=
pu
> >>>>>>>>>>>> *vcpu)
> >>>>>>>>>>>> @@ -215,6 +217,14 @@ SYM_FUNC_START(kvm_enter_guest)
> >>>>>>>>>>>>        /* Save host GPRs */
> >>>>>>>>>>>>        kvm_save_host_gpr a2
> >>>>>>>>>>>>    +    /*
> >>>>>>>>>>>> +     * The csr_era member variable of the pt_regs structure
> >>>>>>>>>>>> is required
> >>>>>>>>>>>> +     * for unwinding orc to perform stack traceback, so we
> >>>>>>>>>>>> need to put
> >>>>>>>>>>>> +     * pc into csr_era member variable here.
> >>>>>>>>>>>> +     */
> >>>>>>>>>>>> +    pcaddi    t0, 0
> >>>>>>>>>>>> +    st.d    t0, a2, PT_ERA
> >>>>>>>>>>> Hi, Xianglai,
> >>>>>>>>>>>
> >>>>>>>>>>> It should use `SYM_CODE_START` to mark the `kvm_enter_guest`
> >>>>>>>>>>> rather than
> >>>>>>>>>>> `SYM_FUNC_START`, since the `SYM_FUNC_START` is used to mark
> >>>>>>>>>>> "C-likely"
> >>>>>>>>>>> asm functionw.
> >>>>>>>>>>
> >>>>>>>>>> Ok, I will use SYM_CODE_START to mark kvm_enter_guest in the
> >>>>>>>>>> next version.
> >>>>>>>>>>
> >>>>>>>>>>> I guess the kvm_enter_guest is something like exception
> >>>>>>>>>>> handler becuase the last instruction is "ertn". So usually it
> >>>>>>>>>>> should
> >>>>>>>>>>> mark UNWIND_HINT_REGS where can find last frame info by "$sp"=
.
> >>>>>>>>>>> However, all info is store to "$a2", this mark should be
> >>>>>>>>>>>    `UNWIND_HINT sp_reg=3DORC_REG_A2(???) type=3DUNWIND_HINT_T=
YPE_REGS`.
> >>>>>>>>>>> I don't konw why save this function internal PC here by `pcad=
di
> >>>>>>>>>>> t0, 0`,
> >>>>>>>>>>> and I think it is no meaning(, for exception handler, they sa=
ve
> >>>>>>>>>>> last PC
> >>>>>>>>>>> by read CSR.ERA). The `kvm_enter_guest` saves registers by
> >>>>>>>>>>> "$a2"("$sp" - PT_REGS) beyond stack ("$sp"), it is dangerous =
if IE
> >>>>>>>>>>> is enable. So I wonder if there is really a stacktrace throug=
h
> >>>>>>>>>>> this function?
> >>>>>>>>>>>
> >>>>>>>>>> The stack backtracking issue in switch.S is rather complex
> >>>>>>>>>> because it involves the switching between cpu root-mode and
> >>>>>>>>>> guest-mode:
> >>>>>>>>>> Real stack backtracking should be divided into two parts:
> >>>>>>>>>> part 1:
> >>>>>>>>>>      [<0>] kvm_enter_guest+0x38/0x11c
> >>>>>>>>>>      [<0>] kvm_arch_vcpu_ioctl_run+0x26c/0x498 [kvm]
> >>>>>>>>>>      [<0>] kvm_vcpu_ioctl+0x200/0xcf8 [kvm]
> >>>>>>>>>>      [<0>] sys_ioctl+0x498/0xf00
> >>>>>>>>>>      [<0>] do_syscall+0x98/0x1d0
> >>>>>>>>>>      [<0>] handle_syscall+0xb8/0x158
> >>>>>>>>>>
> >>>>>>>>>> part 2:
> >>>>>>>>>>      [<0>] kvm_vcpu_block+0x88/0x120 [kvm]
> >>>>>>>>>>      [<0>] kvm_vcpu_halt+0x68/0x580 [kvm]
> >>>>>>>>>>      [<0>] kvm_emu_idle+0xd4/0xf0 [kvm]
> >>>>>>>>>>      [<0>] kvm_handle_gspr+0x7c/0x700 [kvm]
> >>>>>>>>>>      [<0>] kvm_handle_exit+0x160/0x270 [kvm]
> >>>>>>>>>>      [<0>] kvm_exc_entry+0x104/0x1e4
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> In "part 1", after executing kvm_enter_guest, the cpu switches
> >>>>>>>>>> from root-mode to guest-mode.
> >>>>>>>>>> In this case, stack backtracking is indeed very rare.
> >>>>>>>>>>
> >>>>>>>>>> In "part 2", the cpu switches from the guest-mode to the root-=
mode,
> >>>>>>>>>> and most of the stack backtracking occurs during this phase.
> >>>>>>>>>>
> >>>>>>>>>> To obtain the longest call chain, we save pc in kvm_enter_gues=
t
> >>>>>>>>>> to pt_regs.csr_era,
> >>>>>>>>>> and after restoring the sp of the root-mode cpu in kvm_exc_ent=
ry,
> >>>>>>>>>> The ORC entry was re-established using "UNWIND_HINT_REGS",
> >>>>>>>>>>   and then we obtained the following stack backtrace as we wan=
ted:
> >>>>>>>>>>
> >>>>>>>>>>      [<0>] kvm_vcpu_block+0x88/0x120 [kvm]
> >>>>>>>>>>      [<0>] kvm_vcpu_halt+0x68/0x580 [kvm]
> >>>>>>>>>>      [<0>] kvm_emu_idle+0xd4/0xf0 [kvm]
> >>>>>>>>>>      [<0>] kvm_handle_gspr+0x7c/0x700 [kvm]
> >>>>>>>>>>      [<0>] kvm_handle_exit+0x160/0x270 [kvm]
> >>>>>>>>>>      [<0>] kvm_exc_entry+0x104/0x1e4
> >>>>>>>>> I found this might be a coincidence=E2=80=94correct behavior du=
e to the
> >>>>>>>>> incorrect
> >>>>>>>>> UNWIND_HINT_REGS mark and unusual stack adjustment.
> >>>>>>>>>
> >>>>>>>>> First, the kvm_enter_guest contains only a single branch
> >>>>>>>>> instruction, ertn.
> >>>>>>>>> It hardware-jump to the CSR.ERA address directly, jump into
> >>>>>>>>> kvm_exc_entry.
> >>>>>>>>>
> >>>>>>>>> At this point, the stack layout looks like this:
> >>>>>>>>> -------------------------------
> >>>>>>>>>    frame from call to `kvm_enter_guest`
> >>>>>>>>> -------------------------------  <- $sp
> >>>>>>>>>    PT_REGS
> >>>>>>>>> -------------------------------  <- $a2
> >>>>>>>>>
> >>>>>>>>> Then kvm_exc_entry adjust stack without save any register (e.g.
> >>>>>>>>> $ra, $sp)
> >>>>>>>>> but still marked UNWIND_HINT_REGS.
> >>>>>>>>> After the adjustment:
> >>>>>>>>> -------------------------------
> >>>>>>>>>    frame from call to `kvm_enter_guest`
> >>>>>>>>> -------------------------------
> >>>>>>>>>    PT_REGS
> >>>>>>>>> -------------------------------  <- $a2, new $sp
> >>>>>>>>>
> >>>>>>>>> During unwinding, when the unwinder reaches kvm_exc_entry,
> >>>>>>>>> it meets the mark of PT_REGS and correctly recovers
> >>>>>>>>>   pc =3D regs.csr_era, sp =3D regs.sp, ra =3D regs.ra
> >>>>>>>>>
> >>>>>>>> Yes, here unwinder does work as you say.
> >>>>>>>>
> >>>>>>>>> a) Can we avoid "ertn" rather than `jr reg (or jirl ra, reg, 0)=
`
> >>>>>>>>> instead, like call?
> >>>>>>>> No,  we need to rely on the 'ertn instruction return PIE to CRMD=
 IE,
> >>>>>>>> at the same time to ensure that its atomic,
> >>>>>>>> there should be no other instruction than' ertn 'more appropriat=
e
> >>>>>>>> here.
> >>>>>>> You are right! I got it.
> >>>>>>>>
> >>>>>>>>> The kvm_exc_entry cannot back to kvm_enter_guest
> >>>>>>>>> if we use "ertn", so should the kvm_enter_guest appear on the
> >>>>>>>>> stacktrace?
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> It is flexible. As I mentioned above, the cpu completes the swit=
ch
> >>>>>>>> from host-mode to guest mode through kvm_enter_guest,
> >>>>>>>> and then the switch from guest mode to host-mode through
> >>>>>>>> kvm_exc_entry. When we ignore the details of the host-mode
> >>>>>>>> and guest-mode switching in the middle, we can understand that t=
he
> >>>>>>>> host cpu has completed kvm_enter_guest->kvm_exc_entry.
> >>>>>>>>  From this perspective, I think it can exist in the call stack, =
and
> >>>>>>>> at the same time, we have obtained the maximum call stack
> >>>>>>>> information.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> b) Can we adjust $sp before entering kvm_exc_entry? Then we can=
 mark
> >>>>>>>>> UNWIND_HINT_REGS at the beginning of kvm_exc_entry, which somet=
hing
> >>>>>>>>> like ret_from_kernel_thread_asm.
> >>>>>>>>>
> >>>>>>>> The following command can be used to dump the orc entries of the
> >>>>>>>> kernel:
> >>>>>>>> ./tools/objtool/objtool --dump vmlinux
> >>>>>>>>
> >>>>>>>> You can observe that not all orc entries are generated at the
> >>>>>>>> beginning of the function.
> >>>>>>>> For example:
> >>>>>>>> handle_tlb_protect
> >>>>>>>> ftrace_stub
> >>>>>>>> handle_reserved
> >>>>>>>>
> >>>>>>>> So, is it unnecessary for us to modify UNWIND_HINT_REGS in order
> >>>>>>>> to place it at the beginning of the function.
> >>>>>>>>
> >>>>>>>> If you have a better solution, could you provide an example of t=
he
> >>>>>>>> modification?
> >>>>>>>> I can test the feasibility of the solution.
> >>>>>>>>
> >>>>>>> The expression at the beginning of the function is incorrect
> >>>>>>> (feeling sorry).
> >>>>>>> It should be marked where have all stacktrace info.
> >>>>>>> Thanks for all the explaining, since I'm unfamiliar with kvm, I
> >>>>>>> need these to help my understanding.
> >>>>>>>
> >>>>>>> Can you try with follows, with save regs by $sp, set more precise
> >>>>>>> era to pt_regs, and more unwind hint.
> >>>>>>>
> >>>>>>>
> >>>>>>> diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/swi=
tch.S
> >>>>>>> index f1768b7a6194..8ed1d7b72c54 100644
> >>>>>>> --- a/arch/loongarch/kvm/switch.S
> >>>>>>> +++ b/arch/loongarch/kvm/switch.S
> >>>>>>> @@ -14,13 +14,13 @@
> >>>>>>>    #define GGPR_OFFSET(x)        (KVM_ARCH_GGPR + 8*x)
> >>>>>>>
> >>>>>>>    .macro kvm_save_host_gpr base
> >>>>>>> -    .irp n,1,2,3,22,23,24,25,26,27,28,29,30,31
> >>>>>>> +    .irp n,1,2,22,23,24,25,26,27,28,29,30,31
> >>>>>>>        st.d    $r\n, \base, HGPR_OFFSET(\n)
> >>>>>>>        .endr
> >>>>>>>    .endm
> >>>>>>>
> >>>>>>>    .macro kvm_restore_host_gpr base
> >>>>>>> -    .irp n,1,2,3,22,23,24,25,26,27,28,29,30,31
> >>>>>>> +    .irp n,1,2,22,23,24,25,26,27,28,29,30,31
> >>>>>>>        ld.d    $r\n, \base, HGPR_OFFSET(\n)
> >>>>>>>        .endr
> >>>>>>>    .endm
> >>>>>>> @@ -88,6 +88,7 @@
> >>>>>>>        /* Load KVM_ARCH register */
> >>>>>>>        ld.d    a2, a2,    (KVM_ARCH_GGPR + 8 * REG_A2)
> >>>>>>>
> >>>>>>> +111:
> >>>>>>>        ertn /* Switch to guest: GSTAT.PGM =3D 1, ERRCTL.ISERR =3D=
 0,
> >>>>>>> TLBRPRMD.ISTLBR =3D 0 */
> >>>>>>>    .endm
> >>>>>>>
> >>>>>>> @@ -158,9 +159,10 @@ SYM_CODE_START(kvm_exc_entry)
> >>>>>>>        csrwr    t0, LOONGARCH_CSR_GTLBC
> >>>>>>>        ld.d    tp, a2, KVM_ARCH_HTP
> >>>>>>>        ld.d    sp, a2, KVM_ARCH_HSP
> >>>>>>> +    UNWIND_HINT_REGS
> >>>>>>> +
> >>>>>>>        /* restore per cpu register */
> >>>>>>>        ld.d    u0, a2, KVM_ARCH_HPERCPU
> >>>>>>> -    addi.d    sp, sp, -PT_SIZE
> >>>>>>>
> >>>>>>>        /* Prepare handle exception */
> >>>>>>>        or    a0, s0, zero
> >>>>>>> @@ -184,10 +186,11 @@ SYM_CODE_START(kvm_exc_entry)
> >>>>>>>        csrwr    s1, KVM_VCPU_KS
> >>>>>>>        kvm_switch_to_guest
> >>>>>>>
> >>>>>>> +    UNWIND_HINT_UNDEFINED
> >>>>>>>    ret_to_host:
> >>>>>>> -    ld.d    a2, a2, KVM_ARCH_HSP
> >>>>>>> -    addi.d  a2, a2, -PT_SIZE
> >>>>>>> -    kvm_restore_host_gpr    a2
> >>>>>>> +    ld.d    sp, a2, KVM_ARCH_HSP
> >>>>>>> +    kvm_restore_host_gpr    sp
> >>>>>>> +    addi.d    sp, sp, PT_SIZE
> >>>>>>>        jr      ra
> >>>>>>>
> >>>>>>>    SYM_INNER_LABEL(kvm_exc_entry_end, SYM_L_LOCAL)
> >>>>>>> @@ -200,11 +203,15 @@ SYM_CODE_END(kvm_exc_entry)
> >>>>>>>     *  a0: kvm_run* run
> >>>>>>>     *  a1: kvm_vcpu* vcpu
> >>>>>>>     */
> >>>>>>> -SYM_FUNC_START(kvm_enter_guest)
> >>>>>>> +SYM_CODE_START(kvm_enter_guest)
> >>>>>>> +    UNWIND_HINT_UNDEFINED
> >>>>>>>        /* Allocate space in stack bottom */
> >>>>>>> -    addi.d    a2, sp, -PT_SIZE
> >>>>>>> +    addi.d    sp, sp, -PT_SIZE
> >>>>>>>        /* Save host GPRs */
> >>>>>>> -    kvm_save_host_gpr a2
> >>>>>>> +    kvm_save_host_gpr sp
> >>>>>>> +    la.pcrel a2, 111f
> >>>>>>> +    st.d     a2, sp, PT_ERA
> >>>>>>> +    UNWIND_HINT_REGS
> >>>>>>>
> >>>>>> why the label 111f is more accurate?  Supposing there is hw
> >>>>>> breakpoint here and backtrace is called, what is the call trace
> >>>>>> stack then? obvious label 111f is not executed instead.
> >>>>> Xianglai said marking it as regs can get more stack infos, so I use
> >>>>> UNWIND_HINT_REGS marked here, though it not called. Remove
> >>>>> UNWIND_HINT_REGS thenforbid unwind from here.
> >>>>> This function is called and should usually be marked as "call",
> >>>>> but it is complex by switching the stack and use `ertn` calls
> >>>>> another function.
> >>>>>
> >>>>>
> >>>>>>
> >>>>>> UNWIND_HINT_REGS is used for nested kernel stack, is that right?
> >>>>>> With nested interrupt and exception handlers on LoongArch kernel, =
is
> >>>>>> UNWIND_HINT_REGS used?
> >>>>>>
> >>>>>> SYM_CODE_START(ret_from_fork_asm)
> >>>>>>          UNWIND_HINT_REGS
> >>>>>>          move            a1, sp
> >>>>>>          bl              ret_from_fork
> >>>>>>          STACKLEAK_ERASE
> >>>>>>          RESTORE_STATIC
> >>>>>>          RESTORE_SOME
> >>>>>>          RESTORE_SP_AND_RET
> >>>>>> SYM_CODE_END(ret_from_fork_asm)
> >>>>>> With this piece of code, what is contents of pt_regs? In generic i=
t
> >>>>>> is called from sys_clone, era is user PC address, is that right? I=
f so,
> >>>>>> what is detailed usage in the beginning of ret_from_fork_asm?
> >>>>> The stacktrace shows the control flow where the PC will go back, so
> >>>>> it is right because when PC is in ret_from_fork_asm, it is already
> >>>>> another thread. The era means it will go back user mode.
> >>>> The problem is that user mode era shows unwind with error, and
> >>>> user_mode(regs) is not accurate. here is piece of code.
> >>>>                  pc =3D regs->csr_era;
> >>>>                  if (!__kernel_text_address(pc))
> >>>>                          goto err;
> >>>> will UNWIND_HINT_END_OF_STACK be better than UNWIND_HINT_REGS?
> >>>
> >>> You are right. And the reason why current the unwinder does not cause
> >>> error is in case ORC_TYPE_REGS we process it by user_mode(regs).
> >> Any process about UNWIND_HINT_REGS usage, is nested exception unwind
> >> supported now?
> >>
> >> Talking without any actions seems not be style of Loongson :)
> >  From my point of view, Tiezhu's simple solution is acceptable...
> is nested exception/interrupt unwind supported now?  IIRC only nested
> interrupt with stack switch is supported, nested exception/interrupt
> unwind without stack switch is not supported. Is that right?
Nested exception is supported, but it doesn't switch stack; only
interrupt need switch stack.


Huacai

>
> Regards
> Bibo Mao
>
> >
> > Huacai
> >
> >>
> >> Regards
> >> Bibo Mao
> >>>
> >>> Jinyang
> >>>
> >>
>

