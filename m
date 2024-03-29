Return-Path: <stable+bounces-33680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85C6892029
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 16:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D051B2B498
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45D8152DE8;
	Fri, 29 Mar 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="cj5lXTd7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jHvsg9HZ"
X-Original-To: stable@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6E816E366
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716617; cv=none; b=f4d7t65F2ehMQraKvxeJ6V+c/W/gR3SVDlK58Z96Mji0f2g5opBxmgJh4pnNFRdpr9tsSbrEl9pijxxvoy2Bl3LYFLM20qfhZaPz8yEZlXAaFHTVamjUCbZSOh7cHHPcaLWmJEBGSHqY/7ZIlgqRlymld2v9rxL16YLceHMUO7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716617; c=relaxed/simple;
	bh=aMv1M3YGrMhFfNoZ0XWI4FqZ4x07anzRJkA/d80HLwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkC4/UnM7zFKyVqgb5ywHKDbSFbKsWJPSHztFkZVrUUm3pVI8nU1PWn4uGc3RTaSP/jkskxNUtXjdtwdIpgGNGKvCJhd2V/Y/KRuPhHIsRAZGM5VR/oxKWDf5JMrHTs6xCz+JKcklD31LzGr4Jc8WQG/5XUwVLZeRq7cgxI9Jlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=cj5lXTd7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jHvsg9HZ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9943C1140111;
	Fri, 29 Mar 2024 08:50:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 29 Mar 2024 08:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711716614; x=1711803014; bh=7QyNL6424O
	gl1TaPakgjjVFhcQgCWLSU0VmpEdenQIg=; b=cj5lXTd7HIhylqWlksKxQs1mPb
	Gx6a6wGlu3O49qBHHBI1xnuF64jk57nEKegr/l2+WkeSf9PZGuF6wlGgPRZqwjMz
	jB1q8XGgvXXQ7Q3Mt2k6TgFrj5nPJHYMRepk6KFZi1QXVV0Kj2g9DynvuBB3/Iq5
	FvOdxZGplQQ9PWXjECCavpESn/QW//u6W6rSfB/GEDfsc93PSoBOiZPzfTU7ncpo
	xRyrsL8aE/CnpqhsRy3G/jWkQW/rKlkN3BbA+adVayFV6ga2WnJCNpAu78ajcNTs
	RsIw49gb7sfBGzcRbGio/ySXWYTznIS4v2NeM3Zb7Xf9a3uojr4Vt7ad7ExQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711716614; x=1711803014; bh=7QyNL6424Ogl1TaPakgjjVFhcQgC
	WLSU0VmpEdenQIg=; b=jHvsg9HZeqjX3c+ea26WbMI03vo0APA2rGqHp3NJC/S4
	zyDN8lKt+Jp4xRWoPAlH9EE/oSGj1rFIqzaKPzVf3IXjgo5bQ3dHz2CJaqXIMGtA
	i0IqWL9OwCcSqxha3lsjnfYjag5QmTL2Vt0lQ21N7Hr9HiGUD/OwhrDa6LcnfdOi
	ERjJaKXFtU7ZJ9LBZru64vaVoeW/SWVGZETqGO+N87naaKsP0avhBd5oLNt6/aeX
	xl9GUjolSGv1QBz7UyDydUPNlyqGM84oxQeYsXUqxbpnuI8aroWu6Mgp0U7eLOWw
	9HRsUEOFuvH4/AT2IfxoSyQeiZInITAIZ5HRjVNaDg==
X-ME-Sender: <xms:BrkGZjx8pvW9wzeiYixIm2uOy5q-7xcacwudBRHKfbynaVjEqrImVQ>
    <xme:BrkGZrTpxgJRR_y0lda0mSLn29j5orC4qahGAOaRAo2B692uTumRKTrb0GP1IbCFJ
    kd9kgD4d3IWtg>
X-ME-Received: <xmr:BrkGZtWR-WXwHATCpyGTwC2Bf9lPWLqe6zKkdcoMW3UZ0fwwTwlJeraPAh3ItlBsIZtISJJfX9Rwbd43_1V4txBwNC14_B3q_gXxWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvvddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:BrkGZtjhhw84qmP5M03oBDsTgR4FW6_FfxgFkbSO73hjtAC1InsxlA>
    <xmx:BrkGZlD9JnHaoX_kgll_A9-cllcTX8EuVfg8YF_SYKuRuyl043tNJA>
    <xmx:BrkGZmJX1psUx_gU6SdlGlQREDeLB3gZvOSXe9PcpVPs7LoBQ5kb8w>
    <xmx:BrkGZkDSuumoQXAqvda3tx9j63m9TfS6f7fQ2O4eh9s3iZGU4YsRsA>
    <xmx:BrkGZtzsVtQ-jEpJDOE6mQMeWLN5PnQJK8wpuR4uyQcpL3dhoaDSjw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Mar 2024 08:50:13 -0400 (EDT)
Date: Fri, 29 Mar 2024 13:50:11 +0100
From: Greg KH <greg@kroah.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, kernel-dev@igalia.com
Subject: Re: [PATCH 5.15 v2 0/3] Support static calls with LLVM-built kernels
Message-ID: <2024032948-oversight-spoiler-b1e6@gregkh>
References: <20240318133907.2108491-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318133907.2108491-1-cascardo@igalia.com>

On Mon, Mar 18, 2024 at 10:39:04AM -0300, Thadeu Lima de Souza Cascardo wrote:
> Otherwise, we see warnings like this:
> 
> [    0.000000][    T0] ------------[ cut here ]------------
> [    0.000000][    T0] unexpected static_call insn opcode 0xf at kvm_vcpu_reload_apic_access_page+0x17/0x30
> [    0.000000][    T0] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/static_call.c:88 __static_call_validate+0x68/0x70
> [    0.000000][    T0] Modules linked in:
> [    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.151-00083-gf200c7260296 #68 fe3cb25cf78cb710722bb5acd1cadddd35172924
> [    0.000000][    T0] RIP: 0010:__static_call_validate+0x68/0x70
> [    0.000000][    T0] Code: 0f b6 4a 04 81 f1 c0 00 00 00 09 c1 74 cc 80 3d be 2c 02 02 00 75 c3 c6 05 b5 2c 02 02 01 48 c7 c7 38 4f c3 82 e8 e8 c8 09 00 <0f> 0b c3 00 00 cc cc 00 53 48 89 fb 48 63 15 31 71 06 02
> e8 b0 b8
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
> 
> 
> Peter Zijlstra (3):
>   x86/alternatives: Introduce int3_emulate_jcc()
>   x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
>   x86/static_call: Add support for Jcc tail-calls
> 
>  arch/x86/include/asm/text-patching.h | 31 +++++++++++++++
>  arch/x86/kernel/alternative.c        | 56 +++++++++++++++++++++++-----
>  arch/x86/kernel/kprobes/core.c       | 38 ++++---------------
>  arch/x86/kernel/static_call.c        | 49 ++++++++++++++++++++++--
>  4 files changed, 132 insertions(+), 42 deletions(-)

Why is there a v2 series here?  Are the ones I just took not correct?

confused,

greg k-h

