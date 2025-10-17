Return-Path: <stable+bounces-187709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD08BEBE0E
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D3E04E1172
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 22:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF315238149;
	Fri, 17 Oct 2025 22:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ys7APltD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E74C1EC01B
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 22:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738570; cv=none; b=iwoAa4cWch1SXEzIPyf0m9LFVXtHIid5ruuhmkbUr4SbgwOdxp+saQ9e4KrrJvIHUNRFSMA2/FWbfADqAnLW4fSE+9cUgslnBcllJxYlXBnDjbq+YIdCc5O1RpQpPHgpshC/CiaN/TdmnP9Mp6s/TpqJp4fT/qBaSUA14Qg2Nj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738570; c=relaxed/simple;
	bh=zrSQsqa6fbhkcRzMSQ7ZfLBWUQjK9ZrUpN1wpbtVZO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gLI8w+JFA6bSg/ZSq3i9Bf7nLlE5lixx0h5EZ3TqRZiIRdFgXHLGjNGiJaFpodJAGBqMkTFD4YkBgvaKSDrWCeZeqfy61vSiab+lKmz7gJ4lAmJ6Kb3HoTIZsYfVRGbpE/PyxsIg3vxkkO1UOa+lmzx5rIEkJiefkaeTbNgtklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ys7APltD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befbbaso2874982a91.0
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 15:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760738568; x=1761343368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PKOmtt7Mf9tDnVN7q1LflXVYO3MInlOr39kg7gjuFdo=;
        b=Ys7APltDpHz0Sqnl3wqkA/iKwv5JxK/wadt+Z2jq2eoTxjmDWEA+vbkFElZRsbXIbY
         lHZSa/aWpPyGcecicllCWpMjJt66hMROsUSt6Pl+UTsBiQ5BotKuZxC9H0T886pLBF12
         2w+1HBZ1/IIwHqr4fmNNhgIYrsrHmN48/x72uI7QfRiN/v2C2oXkuKzHayoXaoBcsMPv
         6oBmGnjGyMKP+g22J+Z0B2UM7xZGSo66BmtM9wRRrD8/yWT7doCXbyj26ztzNtoa05Xx
         NDy650ogtHsQbR1H7nx+pP+k7Fa00YQDBcjklPGjnvFSNf4YUKVn3XIYE0nAk7qP0WZr
         GaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760738568; x=1761343368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKOmtt7Mf9tDnVN7q1LflXVYO3MInlOr39kg7gjuFdo=;
        b=ABWVRNXylU2uxbOnWfMbT0g5Oa6JG6sUryrPNjIc0FGN9oy79zAZaKc96LVY43RmGn
         A3x/3CfEI8tA0sHS+UcCWzw5G3sofhBx0PAnZNa00VxB6tEMt6s66YCAgqgdVHOC1eDd
         fO8yMwTDR+XfC0Acnuc0NGi2chwZNkOYJma7e7kMjZUjRXhV9iMsq865znP+q1UoQIHP
         4vv1X/EcCT6mvGG2BKbqCxuSrPksz+vwdtiFojd66Hjx72W8+ewlhw/U8nfYwOod0icp
         hJRig2GgiGnwwEFD+bmYGBHK9RZ4xH5C5qciiiXvWi94+x+l2AAZbRItZjnRaRZAsc6W
         VKng==
X-Gm-Message-State: AOJu0Yy1r3Pi9RCVvlXkL+XpqQLDFKIudyKvwq/QD4cJBojyV5Zb1V/m
	cRyHAeMOvqu7aySn7MVr/UBgW9r5PUpkfuQMpHOkB+cnUs7nHSWyjWOMLaUAS2v+TKuSVJSvRlr
	YkmI1TA==
X-Google-Smtp-Source: AGHT+IEqNWdXzNk/KDLDn7xg0AWjfUXE2wME3nO15sIHSSZyZ+ZTJzw22U6UWVqANPMIpLn7PqEvjvHRCxU=
X-Received: from pjbdy13.prod.google.com ([2002:a17:90b:6cd:b0:33b:ce80:9efc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e43:b0:339:cece:a99
 with SMTP id 98e67ed59e1d1-33bcf86c699mr7105186a91.13.1760738568449; Fri, 17
 Oct 2025 15:02:48 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:02:46 -0700
In-Reply-To: <20251013173641.3404405-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025101006-moonwalk-smilingly-3725@gregkh> <20251013173641.3404405-1-sashal@kernel.org>
Message-ID: <aPK9BiJidshyt0ib@google.com>
Subject: Re: [PATCH 5.15.y] KVM: x86: Don't (re)check L1 intercepts when
 completing userspace I/O
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, 
	syzbot+cc2032ba16cc2018ca25@syzkaller.appspotmail.com, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 13, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit e750f85391286a4c8100275516973324b621a269 ]
> 
> When completing emulation of instruction that generated a userspace exit
> for I/O, don't recheck L1 intercepts as KVM has already finished that
> phase of instruction execution, i.e. has already committed to allowing L2
> to perform I/O.  If L1 (or host userspace) modifies the I/O permission
> bitmaps during the exit to userspace,  KVM will treat the access as being
> intercepted despite already having emulated the I/O access.
> 
> Pivot on EMULTYPE_NO_DECODE to detect that KVM is completing emulation.
> Of the three users of EMULTYPE_NO_DECODE, only complete_emulated_io() (the
> intended "recipient") can reach the code in question.  gp_interception()'s
> use is mutually exclusive with is_guest_mode(), and
> complete_emulated_insn_gp() unconditionally pairs EMULTYPE_NO_DECODE with
> EMULTYPE_SKIP.
> 
> The bad behavior was detected by a syzkaller program that toggles port I/O
> interception during the userspace I/O exit, ultimately resulting in a WARN
> on vcpu->arch.pio.count being non-zero due to KVM no completing emulation
> of the I/O instruction.
> 
>   WARNING: CPU: 23 PID: 1083 at arch/x86/kvm/x86.c:8039 emulator_pio_in_out+0x154/0x170 [kvm]
>   Modules linked in: kvm_intel kvm irqbypass
>   CPU: 23 UID: 1000 PID: 1083 Comm: repro Not tainted 6.16.0-rc5-c1610d2d66b1-next-vm #74 NONE
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:emulator_pio_in_out+0x154/0x170 [kvm]
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    kvm_fast_pio+0xd6/0x1d0 [kvm]
>    vmx_handle_exit+0x149/0x610 [kvm_intel]
>    kvm_arch_vcpu_ioctl_run+0xda8/0x1ac0 [kvm]
>    kvm_vcpu_ioctl+0x244/0x8c0 [kvm]
>    __x64_sys_ioctl+0x8a/0xd0
>    do_syscall_64+0x5d/0xc60
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>    </TASK>
> 
> Reported-by: syzbot+cc2032ba16cc2018ca25@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68790db4.a00a0220.3af5df.0020.GAE@google.com
> Fixes: 8a76d7f25f8f ("KVM: x86: Add x86 callback for intercept check")
> Cc: stable@vger.kernel.org
> Cc: Jim Mattson <jmattson@google.com>
> Link: https://lore.kernel.org/r/20250715190638.1899116-1-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ is_guest_mode() was open coded ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

