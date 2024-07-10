Return-Path: <stable+bounces-59044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBE592DB43
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 23:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3A61C212EF
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 21:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D136613C3C9;
	Wed, 10 Jul 2024 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyOXKoQO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2B03AC0C;
	Wed, 10 Jul 2024 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720648256; cv=none; b=ZS8MEEVKe6ZzSKYA30iOUGgmn/7H+JL9orC+ZirDzca1UDupyrWi/J0e/OhC2/iHo6vIwi03W1pKGUvHQUT84U7/0aUCH79nj/BUcgNy0kyTiGnCTNhC1g+waANpK9/IvALcLLWA/QcXkeEeNahg+gR0Vnyyf31mGhL+ql3xDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720648256; c=relaxed/simple;
	bh=7AEMTmeXOOaIqvd4DiMGX4i5CTo3vLpW0bIbfdFRyK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OatuJ1ffPdapNIXxI59OjqbxWtU6ULxvfOsrWOzGV/BdzZOEubIsgOzrFFVB2wheo7LWzPhoBrBVT9r3+MQeKu71Fy0HoRrMCJFwFBJyisfHpXK9poijpmCiIi3Rs7LpZgFYej17NroRtG2MQwXJztIuG7opFDrtI0Vi4GXO1iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyOXKoQO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36798e62aeeso82354f8f.1;
        Wed, 10 Jul 2024 14:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720648253; x=1721253053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JeLU84OFusCIZ6nm+2Cz7jRYkdRS1DgJBvgZZI1L2Mw=;
        b=HyOXKoQOPS+GgE/c6AdlmE/AUC9fB1q0R1/SxEZilhNnJcPR1vCNdsdj7CpAiF9kiJ
         e5LAbipBt7isjr9uE28xlwc4Dm11h6cRTjQvf1G9iI5wLzFpvv8kwkl9ZKko/JZz+AvI
         zQp10I8IUd+0s2d1QlZuM5c5sXaQ76J4MS53VBqANxK1pOKhpZeNZl8z0GMoepR6qF5W
         ZfB71nD1Nlp1iSxhlO/PCxD4vN2T9xEtAst9oQCOK+FRRJywpC4AZ6cfeMczVvuD2Cpe
         JiMZdcKbcyE8cgxajls5W9QO5ZOOHcNmFw9cEpx+HircTpMoFOZ20TCLf/sz4CFHomNl
         flBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720648253; x=1721253053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeLU84OFusCIZ6nm+2Cz7jRYkdRS1DgJBvgZZI1L2Mw=;
        b=QwvEbQigUEkPYsAanHdXW/3k96VwOeqs/EDzecP7XBKiDl0kQ/s2cRUNMtkdebjaFi
         lQmwcKGvFNuQnbvoOpCpiSXmWNT2FfPHjGSQlSEFna8gmD2kcJXTUHPGmgYYJoUA4oX7
         +QMkChCPT4iNnYh03Br5UmBW4BcvRcNmB5JmZ6FfxluwQfkZrfL/Q/+GP5P8s2rRF3yM
         gCdJWwDH3Vi0maUzLaJcgVeA7a6p0BJ02kO9GeUmyGZl4U8qc9ejyUA4tPBmDHWq91XS
         1wQNAd7TW8o8IF+flatqZLzfzMf3V3Kim9Jd21lOykM/dg4xO01ltTE4NiGiok5gzq+D
         PeIA==
X-Forwarded-Encrypted: i=1; AJvYcCVjAyKN1rqaIij6Fme/lmhXDSktZkMzwARXX1CKAqCcKiGNFKjfkPokW1dsYHM/0ksWxN7+i3GonfDTF2K8r1FCw0+1HQ6k
X-Gm-Message-State: AOJu0YzZ+thWI1nVSLWJuTbBLrr4z0ojgr0iRTw0L3Xl+61noFbjCli3
	MfxgwcVMRdvB3HCHm8y7Xn4a+Q0stbVOxUMREtRSHVENKK+17T8G
X-Google-Smtp-Source: AGHT+IHs2K124hGmsNfrSgFSKepfKJjx6rwBz5PuQ4AO5O4uwv/m5OE/1tgbWlkvhpj+JI3EOqHMQA==
X-Received: by 2002:a05:6000:c08:b0:367:4d9d:568b with SMTP id ffacd0b85a97d-367ceadc9eemr4069207f8f.68.1720648252855;
        Wed, 10 Jul 2024 14:50:52 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e095sm6180892f8f.23.2024.07.10.14.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 14:50:52 -0700 (PDT)
Message-ID: <8551ef61-71fb-18f3-a8a8-6c7c3ed731e6@gmail.com>
Date: Wed, 10 Jul 2024 23:50:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] x86/entry_32: Use stack segment selector for VERW
 operand
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Robert Gill <rtgill82@gmail.com>, Jari Ruusu <jariruusu@protonmail.com>,
 Brian Gerst <brgerst@gmail.com>,
 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
 antonio.gomez.iglesias@linux.intel.com, daniel.sneddon@linux.intel.com,
 stable@vger.kernel.org
References: <20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10. 07. 24 21:06, Pawan Gupta wrote:
> Robert Gill reported below #GP when dosemu software was executing vm86()
> system call:
> 
>    general protection fault: 0000 [#1] PREEMPT SMP
>    CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
>    Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
>    EIP: restore_all_switch_stack+0xbe/0xcf
>    EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
>    ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
>    DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
>    CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
>    Call Trace:
>     show_regs+0x70/0x78
>     die_addr+0x29/0x70
>     exc_general_protection+0x13c/0x348
>     exc_bounds+0x98/0x98
>     handle_exception+0x14d/0x14d
>     exc_bounds+0x98/0x98
>     restore_all_switch_stack+0xbe/0xcf
>     exc_bounds+0x98/0x98
>     restore_all_switch_stack+0xbe/0xcf
> 
> This only happens when VERW based mitigations like MDS/RFDS are enabled.
> This is because segment registers with an arbitrary user value can result
> in #GP when executing VERW. Intel SDM vol. 2C documents the following
> behavior for VERW instruction:
> 
>    #GP(0) - If a memory operand effective address is outside the CS, DS, ES,
> 	   FS, or GS segment limit.
> 
> CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to user
> space. Replace CLEAR_CPU_BUFFERS with a safer version that uses %ss to
> refer VERW operand mds_verw_sel. This ensures VERW will not #GP for an
> arbitrary user %ds. Also, in NMI return path, move VERW to after
> RESTORE_ALL_NMI that touches GPRs.
> 
> For clarity, below are the locations where the new CLEAR_CPU_BUFFERS_SAFE
> version is being used:
> 
> * entry_INT80_32(), entry_SYSENTER_32() and interrupts (via
>    handle_exception_return) do:
> 
> restore_all_switch_stack:
>    [...]
>     mov    %esi,%esi
>     verw   %ss:0xc0fc92c0  <-------------
>     iret
> 
> * Opportunistic SYSEXIT:
> 
>     [...]
>     verw   %ss:0xc0fc92c0  <-------------
>     btrl   $0x9,(%esp)
>     popf
>     pop    %eax
>     sti
>     sysexit
> 
> *  nmi_return and nmi_from_espfix:
>     mov    %esi,%esi
>     verw   %ss:0xc0fc92c0  <-------------
>     jmp     .Lirq_return
> 
> Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
> Cc: stable@vger.kernel.org # 5.10+
> Reported-by: Robert Gill <rtgill82@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
> Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Brian Gerst <brgerst@gmail.com> # Use %ss
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
> v4:
> - Further simplify the patch by using %ss for all VERW calls in 32-bit mode (Brian).
> - In NMI exit path move VERW after RESTORE_ALL_NMI that touches GPRs (Dave).
> 
> v3: https://lore.kernel.org/r/20240701-fix-dosemu-vm86-v3-1-b1969532c75a@linux.intel.com
> - Simplify CLEAR_CPU_BUFFERS_SAFE by using %ss instead of %ds (Brian).
> - Do verw before popf in SYSEXIT path (Jari).
> 
> v2: https://lore.kernel.org/r/20240627-fix-dosemu-vm86-v2-1-d5579f698e77@linux.intel.com
> - Safe guard against any other system calls like vm86() that might change %ds (Dave).
> 
> v1: https://lore.kernel.org/r/20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com
> ---
> 
> ---
>   arch/x86/entry/entry_32.S | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index d3a814efbff6..d54f6002e5a0 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -253,6 +253,16 @@
>   .Lend_\@:
>   .endm
>   
> +/*
> + * Safer version of CLEAR_CPU_BUFFERS that uses %ss to reference VERW operand
> + * mds_verw_sel. This ensures VERW will not #GP for an arbitrary user %ds.
> + */
> +.macro CLEAR_CPU_BUFFERS_SAFE
> +	ALTERNATIVE "jmp .Lskip_verw\@", "", X86_FEATURE_CLEAR_CPU_BUF
> +	verw	%ss:_ASM_RIP(mds_verw_sel)
> +.Lskip_verw\@:
> +.endm

Why not simply:

.macro CLEAR_CPU_BUFFERS_SAFE
	ALTERNATIVE "", __stringify(verw %ss:_ASM_RIP(mds_verw_sel)), 
X86_FEATURE_CLEAR_CPU_BUF
.endm

This is how CLEAR_CPU_BUFFERS .macro is defined in nospec-branch.h.

Uros.

> +
>   .macro RESTORE_INT_REGS
>   	popl	%ebx
>   	popl	%ecx
> @@ -871,6 +881,8 @@ SYM_FUNC_START(entry_SYSENTER_32)
>   
>   	/* Now ready to switch the cr3 */
>   	SWITCH_TO_USER_CR3 scratch_reg=%eax
> +	/* Clobbers ZF */
> +	CLEAR_CPU_BUFFERS_SAFE
>   
>   	/*
>   	 * Restore all flags except IF. (We restore IF separately because
> @@ -881,7 +893,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
>   	BUG_IF_WRONG_CR3 no_user_check=1
>   	popfl
>   	popl	%eax
> -	CLEAR_CPU_BUFFERS
>   
>   	/*
>   	 * Return back to the vDSO, which will pop ecx and edx.
> @@ -951,7 +962,7 @@ restore_all_switch_stack:
>   
>   	/* Restore user state */
>   	RESTORE_REGS pop=4			# skip orig_eax/error_code
> -	CLEAR_CPU_BUFFERS
> +	CLEAR_CPU_BUFFERS_SAFE
>   .Lirq_return:
>   	/*
>   	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
> @@ -1144,7 +1155,6 @@ SYM_CODE_START(asm_exc_nmi)
>   
>   	/* Not on SYSENTER stack. */
>   	call	exc_nmi
> -	CLEAR_CPU_BUFFERS
>   	jmp	.Lnmi_return
>   
>   .Lnmi_from_sysenter_stack:
> @@ -1165,6 +1175,7 @@ SYM_CODE_START(asm_exc_nmi)
>   
>   	CHECK_AND_APPLY_ESPFIX
>   	RESTORE_ALL_NMI cr3_reg=%edi pop=4
> +	CLEAR_CPU_BUFFERS_SAFE
>   	jmp	.Lirq_return
>   
>   #ifdef CONFIG_X86_ESPFIX32
> @@ -1206,6 +1217,7 @@ SYM_CODE_START(asm_exc_nmi)
>   	 *  1 - orig_ax
>   	 */
>   	lss	(1+5+6)*4(%esp), %esp			# back to espfix stack
> +	CLEAR_CPU_BUFFERS_SAFE
>   	jmp	.Lirq_return
>   #endif
>   SYM_CODE_END(asm_exc_nmi)
> 
> ---
> base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
> change-id: 20240426-fix-dosemu-vm86-dd111a01737e
> 
> 
> 

