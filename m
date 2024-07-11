Return-Path: <stable+bounces-59070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B84692E25C
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 10:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8811F21224
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 08:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8926778283;
	Thu, 11 Jul 2024 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV+LeAcO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF71509AC;
	Thu, 11 Jul 2024 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686649; cv=none; b=ljZjeEySv6D3WRxKUIJ07HJxUe1Yp38emAyPv/fvCG9dbQYuclejAj9RKt71GLg3pMFJbMYXUdEnI1NVKzyDaq2FCCUiN/OgQ9Ns1H7u0YTDelU2S2UuA3VW2ylhTZ5mrFfz8xPqwZoymmsqeJ5PDlTCQUcKnznQBYUWs2uA6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686649; c=relaxed/simple;
	bh=BBY6p/OnnThuQ0/kFCP5kwpZvlEInSPcfxsX1DVKjbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9aNWC4fLcCx9n8IL5IUFbyPjY0e3kjwNMRcGU7aHspUmnMa2j2tik+g/H2ZQTMGGyuhELey4Xi5cNiTx2/C0k4EcfFJB6oPOLQnvNNOWK1F56UzUiXI92j9b0lM6gYzhNu1B3GYEjsXM646w7Y0WB+OBg3p9zvH6atkSfvgX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV+LeAcO; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eec7e43229so5580941fa.3;
        Thu, 11 Jul 2024 01:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686645; x=1721291445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7DvO8SR7YUFHI1YLMykozVU7TF2QocsdME4ztFCu3A=;
        b=eV+LeAcOFRklD1+GJl40Thfu7yHxQWZBnkw1ttqsRnvH2aLw2IkQEixJiZq42EydU1
         ex3KJEyadtaQmF2fMJf50cmFU4KnIBDG/hy6LJ7mQivTnGlGY5f//cXLDDbt8tCq03kQ
         gZnjsJFn8+kwnj/czI2rE/muYCGG/J2bU1VilkLnESl5h5rmSaM4naJNRguPtBDDTA8K
         JkM/EFIjr7ZFtuNtE+3NI1z79L9ayeCCwFkevlDQ6Zbt8mcAu60HmjatvO8V+CH1EnKM
         ZKCqEMrVbX04oTOXvOP4pD4gWk6TS5l/r5KFk+TfKa9seeo8yYxjYkIqEbiJM+AhKHhJ
         IvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686645; x=1721291445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7DvO8SR7YUFHI1YLMykozVU7TF2QocsdME4ztFCu3A=;
        b=DlKLoTd5yBJGXyRmlj/fVtmRXAonToEQPhZuFpjvfANIbpfKhL1oxDzlewRDrkAAtz
         u1HwrT3Yg1uJF99zkjd4TEwiv6UJI863FhiX/9WEQ8OB16hWt5wcQxn8oWe/GghE3POj
         Z1Jvonp4BT1MXMS/PTKa+cKX1MoDV0u/6HjmJmxAJQDvM58kWfxE/dazxLgdES9IXtOd
         dMUuqNqEF4AEiLsI2gPtmu2V5Es34QpHXQnp6BhUziXFONibEw3LqhvmnBHqgPK9G8lA
         GK4AuF2dztwDJ3Aw2T3qHYxSpeKD7MEqWkOGEhHcQaztGTbu1JGEaTifUMWym3mfw5j8
         XVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLvGzGeqSgGhRo+iu+X/Y5pK/JbHq+88kTlCVVSwKd+VmlqgRgVhkpjnKQJxt0R/DHGKL1XxvJEUM/mfZ6swQcD9T89QXbfD6B9VU4ef2XpZwyKQCrZizGgRuelauZPdIOK7m6
X-Gm-Message-State: AOJu0YwK2j5IJ9LvU6rDgv6zRzg9Jeh05KjUI4AbQ6lr95NzV/ZVXQwA
	iJw192wwCpP8KP7DmokWLe3QK+5LsXU+zwA/pBC9VYTowKSp7KIivYdr+oMenZmDGb8MiTrjVZi
	fZyhFbajuwsm2UvI7mnD3ALmiMsI=
X-Google-Smtp-Source: AGHT+IFrhEugYbWZAFibgULNEbCzs37adif4N4FPeUP2r37hvQXtRjN1LbKI4OVDW5mVdzZiYo59x802JyzlKvpW+/k=
X-Received: by 2002:a2e:8688:0:b0:2ec:61b5:2162 with SMTP id
 38308e7fff4ca-2eeb30fe7c6mr51947841fa.25.1720686644281; Thu, 11 Jul 2024
 01:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com>
 <8551ef61-71fb-18f3-a8a8-6c7c3ed731e6@gmail.com> <20240710231609.rbxd7m5mjk53rthl@desk>
In-Reply-To: <20240710231609.rbxd7m5mjk53rthl@desk>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 11 Jul 2024 10:30:31 +0200
Message-ID: <CAFULd4bhpTKZ5k=hSpitoFQk=U0njuacFhKrvpvcNqbA5ryV9A@mail.gmail.com>
Subject: Re: [PATCH v4] x86/entry_32: Use stack segment selector for VERW operand
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Robert Gill <rtgill82@gmail.com>, Jari Ruusu <jariruusu@protonmail.com>, 
	Brian Gerst <brgerst@gmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, antonio.gomez.iglesias@linux.intel.com, 
	daniel.sneddon@linux.intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 1:16=E2=80=AFAM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Wed, Jul 10, 2024 at 11:50:50PM +0200, Uros Bizjak wrote:
> >
> >
> > On 10. 07. 24 21:06, Pawan Gupta wrote:
> > > Robert Gill reported below #GP when dosemu software was executing vm8=
6()
> > > system call:
> > >
> > >    general protection fault: 0000 [#1] PREEMPT SMP
> > >    CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
> > >    Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2=
010
> > >    EIP: restore_all_switch_stack+0xbe/0xcf
> > >    EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> > >    ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
> > >    DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
> > >    CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
> > >    Call Trace:
> > >     show_regs+0x70/0x78
> > >     die_addr+0x29/0x70
> > >     exc_general_protection+0x13c/0x348
> > >     exc_bounds+0x98/0x98
> > >     handle_exception+0x14d/0x14d
> > >     exc_bounds+0x98/0x98
> > >     restore_all_switch_stack+0xbe/0xcf
> > >     exc_bounds+0x98/0x98
> > >     restore_all_switch_stack+0xbe/0xcf
> > >
> > > This only happens when VERW based mitigations like MDS/RFDS are enabl=
ed.
> > > This is because segment registers with an arbitrary user value can re=
sult
> > > in #GP when executing VERW. Intel SDM vol. 2C documents the following
> > > behavior for VERW instruction:
> > >
> > >    #GP(0) - If a memory operand effective address is outside the CS, =
DS, ES,
> > >        FS, or GS segment limit.
> > >
> > > CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to=
 user
> > > space. Replace CLEAR_CPU_BUFFERS with a safer version that uses %ss t=
o
> > > refer VERW operand mds_verw_sel. This ensures VERW will not #GP for a=
n
> > > arbitrary user %ds. Also, in NMI return path, move VERW to after
> > > RESTORE_ALL_NMI that touches GPRs.
> > >
> > > For clarity, below are the locations where the new CLEAR_CPU_BUFFERS_=
SAFE
> > > version is being used:
> > >
> > > * entry_INT80_32(), entry_SYSENTER_32() and interrupts (via
> > >    handle_exception_return) do:
> > >
> > > restore_all_switch_stack:
> > >    [...]
> > >     mov    %esi,%esi
> > >     verw   %ss:0xc0fc92c0  <-------------
> > >     iret
> > >
> > > * Opportunistic SYSEXIT:
> > >
> > >     [...]
> > >     verw   %ss:0xc0fc92c0  <-------------
> > >     btrl   $0x9,(%esp)
> > >     popf
> > >     pop    %eax
> > >     sti
> > >     sysexit
> > >
> > > *  nmi_return and nmi_from_espfix:
> > >     mov    %esi,%esi
> > >     verw   %ss:0xc0fc92c0  <-------------
> > >     jmp     .Lirq_return
> > >
> > > Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace tr=
ansition")
> > > Cc: stable@vger.kernel.org # 5.10+
> > > Reported-by: Robert Gill <rtgill82@gmail.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218707
> > > Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7=
a58@leemhuis.info/
> > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Suggested-by: Brian Gerst <brgerst@gmail.com> # Use %ss
> > > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > ---
> > > v4:
> > > - Further simplify the patch by using %ss for all VERW calls in 32-bi=
t mode (Brian).
> > > - In NMI exit path move VERW after RESTORE_ALL_NMI that touches GPRs =
(Dave).
> > >
> > > v3: https://lore.kernel.org/r/20240701-fix-dosemu-vm86-v3-1-b1969532c=
75a@linux.intel.com
> > > - Simplify CLEAR_CPU_BUFFERS_SAFE by using %ss instead of %ds (Brian)=
.
> > > - Do verw before popf in SYSEXIT path (Jari).
> > >
> > > v2: https://lore.kernel.org/r/20240627-fix-dosemu-vm86-v2-1-d5579f698=
e77@linux.intel.com
> > > - Safe guard against any other system calls like vm86() that might ch=
ange %ds (Dave).
> > >
> > > v1: https://lore.kernel.org/r/20240426-fix-dosemu-vm86-v1-1-88c826a3f=
378@linux.intel.com
> > > ---
> > >
> > > ---
> > >   arch/x86/entry/entry_32.S | 18 +++++++++++++++---
> > >   1 file changed, 15 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> > > index d3a814efbff6..d54f6002e5a0 100644
> > > --- a/arch/x86/entry/entry_32.S
> > > +++ b/arch/x86/entry/entry_32.S
> > > @@ -253,6 +253,16 @@
> > >   .Lend_\@:
> > >   .endm
> > > +/*
> > > + * Safer version of CLEAR_CPU_BUFFERS that uses %ss to reference VER=
W operand
> > > + * mds_verw_sel. This ensures VERW will not #GP for an arbitrary use=
r %ds.
> > > + */
> > > +.macro CLEAR_CPU_BUFFERS_SAFE
> > > +   ALTERNATIVE "jmp .Lskip_verw\@", "", X86_FEATURE_CLEAR_CPU_BUF
> > > +   verw    %ss:_ASM_RIP(mds_verw_sel)
> > > +.Lskip_verw\@:
> > > +.endm
> >
> > Why not simply:
> >
> > .macro CLEAR_CPU_BUFFERS_SAFE
> >       ALTERNATIVE "", __stringify(verw %ss:_ASM_RIP(mds_verw_sel)),
> > X86_FEATURE_CLEAR_CPU_BUF
> > .endm
>
> We can do it this way as well. But, there are stable kernels that don't
> support relocations in ALTERNATIVEs. The way it is done in current patch
> can be backported without worrying about which kernels support relocation=
s.

Then you could use absolute reference in backports to kernels that
don't support relocations in ALTERNATIVEs, "verw %ss:mds_verw_sel"
works as well, but the relocation is one byte larger.

Uros.

