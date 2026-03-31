Return-Path: <stable+bounces-231411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNF4IXm5y2kpKAYAu9opvQ
	(envelope-from <stable+bounces-231411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:09:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2509B3694A1
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E34AC306C503
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F91E3E0C62;
	Tue, 31 Mar 2026 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t1IJid3X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09543AA1B3;
	Tue, 31 Mar 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958726; cv=none; b=FMZmgjuxwZ+xCZd0zITXfa8hWbVLnJGOsBv0LYg4QpHaGQXmr60MF/aDftylzf05DyaGF3NcU95qDpD1TDcnAcrezsGvgF+vBTrtdb9gIM9jf/jiynWSaPDF9vPot3yCPHNGSn5X3KvegUmpbYbkG8MMjWP7OZ4kQzhVPQtIPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958726; c=relaxed/simple;
	bh=ZnYn9SXB+cSuaLtUlp0PUYQKlgEkBtGwy2wu2MkfQTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgsR/FN54WY22K34d2lBHV4w1dvGrwxFW+Jiz1SROhidPIgk43nDJyCuKCz0lm/SWcqETnHaAPlJCCw9dxBI/arFcpe/+qFXNzxGEm9dLIUKv8Xo3SRyNCXJF89JgHCyMU9x/HCtZXyZFEc6SXvcyONmI+ZulQx++3zsjMWdZhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t1IJid3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A695FC19423;
	Tue, 31 Mar 2026 12:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774958726;
	bh=ZnYn9SXB+cSuaLtUlp0PUYQKlgEkBtGwy2wu2MkfQTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t1IJid3Xwd0N876DcLM2okNrLAUhqms9HAdy0mUzbIY7cAxXdwrWywmDqqCH+MruW
	 xPRJqL5uNW6PQJtUV5nMdK1d6N1kTAbGbxAQYqRVsnT8pFXLhzc+EMtJuEoCtF416/
	 sF2aFkZ3C7JxW+nZTtvNhnX8oqOQYhvFCAlRaFH0=
Date: Tue, 31 Mar 2026 14:05:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Sasha Levin <sashal@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH for 6.6] LoongArch: vDSO: Emit GNU_EH_FRAME correctly
Message-ID: <2026033143-gumball-handcraft-5656@gregkh>
References: <20260330100133.3955364-1-chenhuacai@loongson.cn>
 <2026033148-expletive-many-cd82@gregkh>
 <42ab19d20e572c61587728350b5f1ca900632322.camel@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42ab19d20e572c61587728350b5f1ca900632322.camel@xry111.site>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231411-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[linuxfoundation.org:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,xry111.site:email,loongson.cn:email]
X-Rspamd-Queue-Id: 2509B3694A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 07:58:15PM +0800, Xi Ruoyao wrote:
> On Tue, 2026-03-31 at 13:10 +0200, Greg Kroah-Hartman wrote:
> > On Mon, Mar 30, 2026 at 06:01:33PM +0800, Huacai Chen wrote:
> > > From: Xi Ruoyao <xry111@xry111.site>
> > > 
> > > commit e4878c37f6679fdea91b27a0f4e60a871f0b7bad upstream.
> > > 
> > > With -fno-asynchronous-unwind-tables and --no-eh-frame-hdr (the default
> > > of the linker), the GNU_EH_FRAME segment (specified by vdso.lds.S) is
> > > empty.  This is not valid, as the current DWARF specification mandates
> > > the first byte of the EH frame to be the version number 1.  It causes
> > > some unwinders to complain, for example the ClickHouse query profiler
> > > spams the log with messages:
> > > 
> > >     clickhouse-server[365854]: libunwind: unsupported .eh_frame_hdr
> > >     version: 127 at 7ffffffb0000
> > > 
> > > Here "127" is just the byte located at the p_vaddr (0, i.e. the
> > > beginning of the vDSO) of the empty GNU_EH_FRAME segment. Cross-
> > > checking with /proc/365854/maps has also proven 7ffffffb0000 is the
> > > start of vDSO in the process VM image.
> > > 
> > > In LoongArch the -fno-asynchronous-unwind-tables option seems just a
> > > MIPS legacy, and MIPS only uses this option to satisfy the MIPS-specific
> > > "genvdso" program, per the commit cfd75c2db17e ("MIPS: VDSO: Explicitly
> > > use -fno-asynchronous-unwind-tables").  IIRC it indicates some inherent
> > > limitation of the MIPS ELF ABI and has nothing to do with LoongArch.  So
> > > we can simply flip it over to -fasynchronous-unwind-tables and pass
> > > --eh-frame-hdr for linking the vDSO, allowing the profilers to unwind the
> > > stack for statistics even if the sample point is taken when the PC is in
> > > the vDSO.
> > > 
> > > However simply adjusting the options above would exploit an issue: when
> > > the libgcc unwinder saw the invalid GNU_EH_FRAME segment, it silently
> > > falled back to a machine-specific routine to match the code pattern of
> > > rt_sigreturn() and extract the registers saved in the sigframe if the
> > > code pattern is matched.  As unwinding from signal handlers is vital for
> > > libgcc to support pthread cancellation etc., the fall-back routine had
> > > been silently keeping the LoongArch Linux systems functioning since
> > > Linux 5.19.  But when we start to emit GNU_EH_FRAME with the correct
> > > format, fall-back routine will no longer be used and libgcc will fail
> > > to unwind the sigframe, and unwinding from signal handlers will no
> > > longer work, causing dozens of glibc test failures.  To make it possible
> > > to unwind from signal handlers again, it's necessary to code the unwind
> > > info in __vdso_rt_sigreturn via .cfi_* directives.
> > > 
> > > The offsets in the .cfi_* directives depend on the layout of struct
> > > sigframe, notably the offset of sigcontext in the sigframe.  To use the
> > > offset in the assembly file, factor out struct sigframe into a header to
> > > allow asm-offsets.c to output the offset for assembly.
> > > 
> > > To work around a long-term issue in the libgcc unwinder (the pc is
> > > unconditionally substracted by 1: doing so is technically incorrect for
> > > a signal frame), a nop instruction is included with the two real
> > > instructions in __vdso_rt_sigreturn in the same FDE PC range.  The same
> > > hack has been used on x86 for a long time.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: c6b99bed6b8f ("LoongArch: Add VDSO and VSYSCALL support")
> > > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > 
> > Does not apply cleanly on the latest 6.12.y queue :(
> 
> This is for 6.6.  Maybe your agent is malfunctioning?

Sorry, that was me malfunctioning, I meant to say this failed for 6.6.y:

	Applying loongarch-vdso-emit-gnu_eh_frame-correctly.patch to linux-6.6.y
	Applying patch loongarch-vdso-emit-gnu_eh_frame-correctly.patch
	patching file arch/loongarch/include/asm/linkage.h
	patching file arch/loongarch/include/asm/sigframe.h
	patching file arch/loongarch/kernel/asm-offsets.c
	patching file arch/loongarch/kernel/signal.c
	Hunk #2 succeeded at 72 with fuzz 2 (offset 21 lines).
	patching file arch/loongarch/vdso/Makefile
	Hunk #1 succeeded at 24 (offset -1 lines).
	Hunk #2 FAILED at 36.
	1 out of 2 hunks FAILED -- rejects in file arch/loongarch/vdso/Makefile
	patching file arch/loongarch/vdso/sigreturn.S
	Patch loongarch-vdso-emit-gnu_eh_frame-correctly.patch does not apply (enforce with -f)

too many kernel branches...

thanks,

greg k-h

