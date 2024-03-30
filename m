Return-Path: <stable+bounces-33834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA1A892A52
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 11:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336142834C7
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B07421344;
	Sat, 30 Mar 2024 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="TLwDuDYN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X6Agm4CJ"
X-Original-To: stable@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C116E25740
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711793487; cv=none; b=OVMxsoKH7otBg3QDYsNJRKoCXiG737oOKEG7PgxD8APV5b7d4Tfx3kWsA1TtNWYHYqThnZkLsvMIKiqyDg/NirwTy7JUJnwxYXY+xTImvePYsRlUL6+ttGxvncCg+nqdOSHClO2cX4c4LCbvIre8kOT5yl8jnCUCoJ7CbjtglVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711793487; c=relaxed/simple;
	bh=dYq2otpxf+JY2ShjJLHehhiw1JaANH7wMjRjZXvGNgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M84Tkw3r80oJLHDVD8kykxjwOmUFV/xsrzIEhl6j74cPiFZiCVeyXgpiZ1RQYxwlT9yL0F6EO12KgSKqW9yenoy1ckEVooDFry5TOstZfXwqzDCUIrhpz2VHqkhPwmzmUN58hTtMq4AKJd77fWdpE1htrCs74n62f55MHpw2A4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=TLwDuDYN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X6Agm4CJ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B96BB11400A3;
	Sat, 30 Mar 2024 06:11:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 30 Mar 2024 06:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711793483; x=1711879883; bh=H1RDfmAk/m
	yLMLhSvGE/Y/a54lEZgIJzBS1RvxLkxfM=; b=TLwDuDYNPNjmBJVki4+k3xsD4I
	tunEfGHs4z2LVUFY6oe3M32xEUHPhBM+eFoFmNAig/kwUxamIlycphwjrDgF+sRS
	gJjPqr1IOik64x+EzckU6pvs97JzOd+6yeE4s9x7jrno6GrTdRSPx6PuDzMq9q8D
	bxjDxNk1BgfgCsWm2sYGoPswI2tKW8yHgHi2ZvJ/nI9ivrDIuV+D1ucQyggBV+PY
	SzMJmGX/xxC2MBVqXDvciWPYIArLAo7aK8WuxiFLlkKmhn/zqqmnHtPVFjX4EtUa
	EmQyv99f8/Ec4e724PlNwQMlukgF/5/TnXK3XJ8KqWKvy2xhkhME1CnpxuUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711793483; x=1711879883; bh=H1RDfmAk/myLMLhSvGE/Y/a54lEZ
	gIJzBS1RvxLkxfM=; b=X6Agm4CJ8a0q2n4c12A1uIGCiK4ltDwMoj7jYN1yEuAj
	Vzts5O8vR0cVTajkpruuwIfu98ljGqsNLiMjX8v5g2CmXNAFvpFUzNqwdIQktV7h
	+tXFF8PEbIOrlB72cSVLbORqLAh+24ePlIaX0He1rThf2t6OATo/sz4SFtsW1k57
	VLP/J9q1zZEF2Oi4kolPImeP/k8k2TUGKTy5bsUtB3aLNm97pEwYlvDFUorLhJwi
	Xvi9VVS7b8tC9tBSoaNeHQ6Ki7O/AWs25ZFpxzVJ+cw97zPRiy4hgUqv60UMO8rb
	QnsIswwjISHdxnigwRfqtycqwgk5Dti2PTqX9cS6iw==
X-ME-Sender: <xms:S-UHZmUBrt1Yvh_ALwp76DzOQC1uNGwEGpwPFqgaqGQJ0GfhX8Xr1g>
    <xme:S-UHZilyad8S15Zxx1GKjsLfyimoWveNDVf3tNG8pBZlxcz79CEqKAUvyAk28FPMJ
    D4_vz2Uy6-qeg>
X-ME-Received: <xmr:S-UHZqbJop9kQrB6HP5D98Jxb5Q1zcvSiY32p5BZ3QNNd1ztlW4SUvnvD9iyBDtAQsQuMT6JNdmqOWrwfLnYq6FHljCnHaCHu6pDeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:S-UHZtVrZlcIXDvpyO7uw3f1Rz5gfsJM2NxxfYukJ8CVazN4_y1Uow>
    <xmx:S-UHZgkMHZaSZvzGBkc1r9VjWR1ctSM8evJwNjX4gAiE2hnYn6P6Xg>
    <xmx:S-UHZifSYGpt6dY04FRM_g7xyDr17AgZRdf38C5ubYYgXNBD9pKfNg>
    <xmx:S-UHZiEWmkhmp_bn9DUC7tarJi3ywqBhkWG9a-g7dBXBfiuDO3NEaA>
    <xmx:S-UHZunGz3ybCuyslaCMVNL-hf4CtvotwWJanescOTvqMXjmRKg50A>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Mar 2024 06:11:22 -0400 (EDT)
Date: Sat, 30 Mar 2024 11:11:14 +0100
From: Greg KH <greg@kroah.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, kernel-dev@igalia.com
Subject: Re: [PATCH 5.15 v2 0/3] Support static calls with LLVM-built kernels
Message-ID: <2024033003-unplug-anthem-a453@gregkh>
References: <20240318133907.2108491-1-cascardo@igalia.com>
 <2024032948-oversight-spoiler-b1e6@gregkh>
 <Zgfh8t49ySdA6dTW@quatroqueijos.cascardo.eti.br>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zgfh8t49ySdA6dTW@quatroqueijos.cascardo.eti.br>

On Sat, Mar 30, 2024 at 06:57:06AM -0300, Thadeu Lima de Souza Cascardo wrote:
> On Fri, Mar 29, 2024 at 01:50:11PM +0100, Greg KH wrote:
> > On Mon, Mar 18, 2024 at 10:39:04AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > > Otherwise, we see warnings like this:
> > > 
> > > [    0.000000][    T0] ------------[ cut here ]------------
> > > [    0.000000][    T0] unexpected static_call insn opcode 0xf at kvm_vcpu_reload_apic_access_page+0x17/0x30
> > > [    0.000000][    T0] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/static_call.c:88 __static_call_validate+0x68/0x70
> > > [    0.000000][    T0] Modules linked in:
> > > [    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.151-00083-gf200c7260296 #68 fe3cb25cf78cb710722bb5acd1cadddd35172924
> > > [    0.000000][    T0] RIP: 0010:__static_call_validate+0x68/0x70
> > > [    0.000000][    T0] Code: 0f b6 4a 04 81 f1 c0 00 00 00 09 c1 74 cc 80 3d be 2c 02 02 00 75 c3 c6 05 b5 2c 02 02 01 48 c7 c7 38 4f c3 82 e8 e8 c8 09 00 <0f> 0b c3 00 00 cc cc 00 53 48 89 fb 48 63 15 31 71 06 02
> > > e8 b0 b8
> > > [    0.000000][    T0] RSP: 0000:ffffffff82e03e70 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
> > > [    0.000000][    T0] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
> > > [    0.000000][    T0] RDX: 0000000000000000 RSI: ffffffff82e03ce0 RDI: 0000000000000001
> > > [    0.000000][    T0] RBP: 0000000000000001 R08: 00000000ffffffff R09: ffffffff82eaab70
> > > [    0.000000][    T0] R10: ffffffff82e2e900 R11: 205d305420202020 R12: ffffffff82e51960
> > > [    0.000000][    T0] R13: ffffffff81038987 R14: ffffffff81038987 R15: 0000000000000001
> > > [    0.000000][    T0] FS:  0000000000000000(0000) GS:ffffffff83726000(0000) knlGS:0000000000000000
> > > [    0.000000][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    0.000000][    T0] CR2: ffff888000014be8 CR3: 00000000037b2000 CR4: 00000000000000a0
> > > [    0.000000][    T0] Call Trace:
> > > [    0.000000][    T0]  <TASK>
> > > [    0.000000][    T0]  ? __warn+0x75/0xe0
> > > [    0.000000][    T0]  ? report_bug+0x81/0xe0
> > > [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> > > [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> > > [    0.000000][    T0]  ? early_fixup_exception+0x44/0xa0
> > > [    0.000000][    T0]  ? early_idt_handler_common+0x2f/0x40
> > > [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> > > [    0.000000][    T0]  ? kvm_vcpu_reload_apic_access_page+0x17/0x30
> > > [    0.000000][    T0]  ? __static_call_validate+0x68/0x70
> > > [    0.000000][    T0]  ? arch_static_call_transform+0x5c/0x90
> > > [    0.000000][    T0]  ? __static_call_init+0x1ec/0x230
> > > [    0.000000][    T0]  ? static_call_init+0x32/0x70
> > > [    0.000000][    T0]  ? setup_arch+0x36/0x4f0
> > > [    0.000000][    T0]  ? start_kernel+0x67/0x400
> > > [    0.000000][    T0]  ? secondary_startup_64_no_verify+0xb1/0xbb
> > > [    0.000000][    T0]  </TASK>
> > > [    0.000000][    T0] ---[ end trace 8c8589c01f370686 ]---
> > > 
> > > 
> > > 
> > > Peter Zijlstra (3):
> > >   x86/alternatives: Introduce int3_emulate_jcc()
> > >   x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
> > >   x86/static_call: Add support for Jcc tail-calls
> > > 
> > >  arch/x86/include/asm/text-patching.h | 31 +++++++++++++++
> > >  arch/x86/kernel/alternative.c        | 56 +++++++++++++++++++++++-----
> > >  arch/x86/kernel/kprobes/core.c       | 38 ++++---------------
> > >  arch/x86/kernel/static_call.c        | 49 ++++++++++++++++++++++--
> > >  4 files changed, 132 insertions(+), 42 deletions(-)
> > 
> > Why is there a v2 series here?  Are the ones I just took not correct?
> > 
> > confused,
> > 
> > greg k-h
> 
> Because Sasha questioned the presence of the first 2 patches in the series
> while they were not backported to 6.1. Then, I looked at the 6.1 backport for
> reference and determined they were not really necessary if I picked the same
> changes that the 6.1 backport applied.

So is what I queued up correct or not?

still confused,

greg k-h

