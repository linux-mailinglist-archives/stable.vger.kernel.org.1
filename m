Return-Path: <stable+bounces-33491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBE7891CD5
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E5D1C242FC
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4FF1A4344;
	Fri, 29 Mar 2024 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wH32wfwm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B50E1A38F0
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716231; cv=none; b=L+fiwI9Lxu9TDDVHW06G5jMBSHU1YcJ41xw6utjXoKaOtBkTzTZtgMbBcaCNPyLDxyK79JsnJy3A7lmvjB9MofFwv39gF3Rad+Zzu5sLWlOOPpScugIGoGQlcFQ9Bznv/J9tmzlUYNojn6w3xuU4LBHCarSai0Xu8gIoPI0tq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716231; c=relaxed/simple;
	bh=gAJlPCL2QPpnU3Mp5oOSjKNNs3jyLnx5Eu4tGNFnFGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+lfxO2XkCXHVgf94/w1j2bRwB+sRT/MQqFZebqkZ+2WcCA006fre7X0YmgvhHNaFXi+bAOg1vOkDSZ7FdpqCMG4UqwvnIye/TJIneDVPoGXTRh+j5gjVLuS7r5WTYUXk8l7Bk1BQk2qfKZrnXtTkJorxwVx+mIdgiq2ogxYms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wH32wfwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4240C433B1;
	Fri, 29 Mar 2024 12:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711716231;
	bh=gAJlPCL2QPpnU3Mp5oOSjKNNs3jyLnx5Eu4tGNFnFGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wH32wfwm7yB2bPaxCyHycIcu5pOhforkFnVRuS2N0pOcxQLf8wmdwUukh3DDSqDQZ
	 HIBdFGIsHfWqzlcsuxFp3Xq8F/G6tEoGgmrSWJ6WZyknUBOs+q3HKlLnXf85DjDOdt
	 4+uB2bEgR8651GJ7NK7P6YSsTlkpqoZOkqLHaFbw=
Date: Fri, 29 Mar 2024 13:43:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, kernel-dev@igalia.com
Subject: Re: [PATCH 5.15 0/5] Support static calls with LLVM-built kernels
Message-ID: <2024032931-ascent-delicious-4466@gregkh>
References: <20240313104255.1083365-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313104255.1083365-1-cascardo@igalia.com>

On Wed, Mar 13, 2024 at 07:42:50AM -0300, Thadeu Lima de Souza Cascardo wrote:
> Otherwise, we see warnings like this:
> 
> [    0.000000][    T0] ------------[ cut here ]------------
> [    0.000000][    T0] unexpected static_call insn opcode 0xf at kvm_vcpu_reload_apic_access_page+0x17/0x30
> [    0.000000][    T0] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/static_call.c:88 __static_call_validate+0x68/0x70
> [    0.000000][    T0] Modules linked in:
> [    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.151-00083-gf200c7260296 #68 fe3cb25cf78cb710722bb5acd1cadddd35172924
> [    0.000000][    T0] RIP: 0010:__static_call_validate+0x68/0x70
> [    0.000000][    T0] Code: 0f b6 4a 04 81 f1 c0 00 00 00 09 c1 74 cc 80 3d be 2c 02 02 00 75 c3 c6 05 b5 2c 02 02 01 48 c7 c7 38 4f c3 82 e8 e8 c8 09 00 <0f> 0b c3 00 00 cc cc 00 53 48 89 fb 48 63 15 31 71 06 02 e8 b0 b8
> [    0.000000][    T0] RSP: 0000:ffffffff82e03e70 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
> [    0.000000][    T0] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
> [    0.000000][    T0] RDX: 0000000000000000 RSI: ffffffff82e03ce0 RDI: 0000000000000001
> [    0.000000][    T0] RBP: 0000000000000001 R08: 00000000ffffffff R09: ffffffff82eaab70
> [    0.000000][    T0] R10: ffffffff82e2e900 R11: 205d305420202020 R12: ffffffff82e51960
> [    0.000000][    T0] R13: ffffffff81038987 R14: ffffffff81038987 R15: 0000000000000001
> [    0.000000][    T0] FS:  0000000000000000(0000) GS:ffffffff83726000(0000) knlGS:0000000000000000
> [    0.000000][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.000000][    T0] CR2: ffff888000014be8 CR3: 00000000037b2000 CR4: 00000000000000a0
> [    0.000000][    T0] Call Trace:
> [    0.000000][    T0]  <TASK>
> [    0.000000][    T0]  ? __warn+0x75/0xe0
> [    0.000000][    T0]  ? report_bug+0x81/0xe0
> [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> [    0.000000][    T0]  ? early_fixup_exception+0x44/0xa0
> [    0.000000][    T0]  ? early_idt_handler_common+0x2f/0x40
> [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> [    0.000000][    T0]  ? __static_call_validate+0x68/0x70
> [    0.000000][    T0]  ? arch_static_call_transform+0x5c/0x90
> [    0.000000][    T0]  ? __static_call_init+0x1ec/0x230
> [    0.000000][    T0]  ? static_call_init+0x32/0x70
> [    0.000000][    T0]  ? setup_arch+0x36/0x4f0
> [    0.000000][    T0]  ? start_kernel+0x67/0x400
> [    0.000000][    T0]  ? secondary_startup_64_no_verify+0xb1/0xbb
> [    0.000000][    T0]  </TASK>
> [    0.000000][    T0] ---[ end trace 8c8589c01f370686 ]---
> 

Now queued up, thanks.

greg k-h

