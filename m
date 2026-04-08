Return-Path: <stable+bounces-233904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNdaKFBZ1mnLEQgAu9opvQ
	(envelope-from <stable+bounces-233904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:34:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E923BCFCF
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 638653037D74
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC723CEB8F;
	Wed,  8 Apr 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W+HlFzxk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F743B8D7E;
	Wed,  8 Apr 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655027; cv=none; b=LEPlSJOaA7Upgiy5G+XPMohhJq/kt/G+N+DM+5m8ZezcBO8LVaPgETQzd8mJHY64+DTCkGb6bxcQe3487i13v3j911rNjVS/w96JGNth7+gA/xGF1sOzp/A+VKpxZ3I7hGzldNHwgXH5uD7ATifQzlt87+Q1pXZ9MnCiDJf6Jw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655027; c=relaxed/simple;
	bh=gWnLM12LSVMcTwFvGt4Fq3BcuLWqVA9N2Y5OmDY4wak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOC45Som3TwoaU3obUShEI5tKCNp4jtQUgFWXNKRYv9ISvrhglGlQopAD+BDhA9EMJip4w4CnFkk9g4OSQXqLsDKuV+B+Fy2ElKQflvnXckDkaLx2tpbUFpY41dv7MIo3iRvP52KsmBFflgrNGc73Y1H49kqfZPdDOA/hUvFZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W+HlFzxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5588C19421;
	Wed,  8 Apr 2026 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775655027;
	bh=gWnLM12LSVMcTwFvGt4Fq3BcuLWqVA9N2Y5OmDY4wak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+HlFzxk9KF6qgMzwG5BepaAa1pyhjiF9Cflg75Mo/cUfrUG/+BcKcbOQgcIPqBsT
	 BOqT2FhWBzTs46E3IJfzYhyia72c9tTDiW3p4t1qv6NEfpCGdTkpvVIZ9cRSVD4lOL
	 dHXUe8QiaTjVPzkckO0Su79o39HN9USyXiLq4w1s=
Date: Wed, 8 Apr 2026 15:30:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Sasha Levin <sashal@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH for 6.1] LoongArch: vDSO: Emit GNU_EH_FRAME correctly
Message-ID: <2026040816-yapping-gonad-2248@gregkh>
References: <20260330100205.3955389-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330100205.3955389-1-chenhuacai@loongson.cn>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233904-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 04E923BCFCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 06:02:05PM +0800, Huacai Chen wrote:
> From: Xi Ruoyao <xry111@xry111.site>
> 
> commit e4878c37f6679fdea91b27a0f4e60a871f0b7bad upstream.
> 
> With -fno-asynchronous-unwind-tables and --no-eh-frame-hdr (the default
> of the linker), the GNU_EH_FRAME segment (specified by vdso.lds.S) is
> empty.  This is not valid, as the current DWARF specification mandates
> the first byte of the EH frame to be the version number 1.  It causes
> some unwinders to complain, for example the ClickHouse query profiler
> spams the log with messages:
> 
>     clickhouse-server[365854]: libunwind: unsupported .eh_frame_hdr
>     version: 127 at 7ffffffb0000
> 
> Here "127" is just the byte located at the p_vaddr (0, i.e. the
> beginning of the vDSO) of the empty GNU_EH_FRAME segment. Cross-
> checking with /proc/365854/maps has also proven 7ffffffb0000 is the
> start of vDSO in the process VM image.
> 
> In LoongArch the -fno-asynchronous-unwind-tables option seems just a
> MIPS legacy, and MIPS only uses this option to satisfy the MIPS-specific
> "genvdso" program, per the commit cfd75c2db17e ("MIPS: VDSO: Explicitly
> use -fno-asynchronous-unwind-tables").  IIRC it indicates some inherent
> limitation of the MIPS ELF ABI and has nothing to do with LoongArch.  So
> we can simply flip it over to -fasynchronous-unwind-tables and pass
> --eh-frame-hdr for linking the vDSO, allowing the profilers to unwind the
> stack for statistics even if the sample point is taken when the PC is in
> the vDSO.
> 
> However simply adjusting the options above would exploit an issue: when
> the libgcc unwinder saw the invalid GNU_EH_FRAME segment, it silently
> falled back to a machine-specific routine to match the code pattern of
> rt_sigreturn() and extract the registers saved in the sigframe if the
> code pattern is matched.  As unwinding from signal handlers is vital for
> libgcc to support pthread cancellation etc., the fall-back routine had
> been silently keeping the LoongArch Linux systems functioning since
> Linux 5.19.  But when we start to emit GNU_EH_FRAME with the correct
> format, fall-back routine will no longer be used and libgcc will fail
> to unwind the sigframe, and unwinding from signal handlers will no
> longer work, causing dozens of glibc test failures.  To make it possible
> to unwind from signal handlers again, it's necessary to code the unwind
> info in __vdso_rt_sigreturn via .cfi_* directives.
> 
> The offsets in the .cfi_* directives depend on the layout of struct
> sigframe, notably the offset of sigcontext in the sigframe.  To use the
> offset in the assembly file, factor out struct sigframe into a header to
> allow asm-offsets.c to output the offset for assembly.
> 
> To work around a long-term issue in the libgcc unwinder (the pc is
> unconditionally substracted by 1: doing so is technically incorrect for
> a signal frame), a nop instruction is included with the two real
> instructions in __vdso_rt_sigreturn in the same FDE PC range.  The same
> hack has been used on x86 for a long time.
> 
> Cc: stable@vger.kernel.org
> Fixes: c6b99bed6b8f ("LoongArch: Add VDSO and VSYSCALL support")
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/linkage.h  | 36 +++++++++++++++++++++++++++
>  arch/loongarch/include/asm/sigframe.h |  9 +++++++
>  arch/loongarch/kernel/asm-offsets.c   |  2 ++
>  arch/loongarch/kernel/signal.c        |  6 +----
>  arch/loongarch/vdso/Makefile          |  4 +--
>  arch/loongarch/vdso/sigreturn.S       |  6 ++---
>  6 files changed, 53 insertions(+), 10 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/sigframe.h

Does not apply to the 6.1.y queue :(

