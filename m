Return-Path: <stable+bounces-250021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMccBOPkDWpz4gUAu9opvQ
	(envelope-from <stable+bounces-250021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:44:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AB75925B1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0724032C73AD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE40933ADB3;
	Wed, 20 May 2026 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="cCu+f08v"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1B03033E9
	for <stable@vger.kernel.org>; Wed, 20 May 2026 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292073; cv=none; b=f7wLSJ6c1Pay7xLVuJew01so4IXG6ajV/y+uY/EqMjqk1pMCf2c3VNQhNn9sxjaRaS43Vgaph0XoDskkTz8mfB8OybrTNU0zoCug2+khf9rHFsWOrmk+F5WOMW/FBEFXWAWgjQ+wxwSbDouHPy+hWAfd5fTlN+F77S4WLztGIzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292073; c=relaxed/simple;
	bh=rHC5P5m+kVX2/RR5vNGRdSYzB3pEDmt1AWf01SLhSsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ligo0Qg+G4Za/iw4vz3IvhI7OHevCuzyqkVW2v6PKuEqLthmp2x9rgBRnLtjDLJwdjqF9aiV6OvQ64vzRfQwJ+Kwz6NUP940rVK0v+aKuFv5Gh7yFrPH8GOpBjutoy6+0oWvlaECqbwzmO2h+eb3wVKgffsDxZr1hjbWSYXBfds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=cCu+f08v; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7cfc382d896so16302967b3.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1779292070; x=1779896870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JubydVUqW/P7ynT150P3sJMigiSm7SSOwcsE79mSJn4=;
        b=cCu+f08vNNiHUIHwzPF+hSAA/Qnboh/o/dyASgKANvTYyRomVNAMBZ8BJvCiMBJE9M
         PnYVXw8QzY4O82Hmc873jCuQUKTDZI3foSUr1HIhbis8oWAYQTDs3LvvGzpVwHvbdm43
         xfMDlgUoXSJobckkLATSTcfomuG+uwyKVegOYCyC1Y8FdY2j6jODr949O4tC/+gnE9kd
         /aVltmdEANHFmf7UDeGC6sd+j2wCWwYTjwKBFAY+wsaQk3jypCMzfkdjtuKm0jwFIEdq
         wTzqJYpn/SGWgqr4Y/whjD4wwR2E2aCcBuJ6EZAwgCidP2Y690CYMZ2aJcPRd2n+viZk
         rarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292070; x=1779896870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JubydVUqW/P7ynT150P3sJMigiSm7SSOwcsE79mSJn4=;
        b=shJBaUdd5/bWCFfb+G84VKwfoTIv54j/+2aAjS3u35/OZIXVXLHqXwwjC2i5cW7/WA
         XpVQRQ/tN2ujFqlOqv1nt1baA6t2mNP2SsLUgfsLnJ/OWx4wL6wzPh8ZJh0aK1kiSP/r
         ucXhMBdvESVD7J+T78EunraUSVaXI4GvrrhvKTaF1cy0KiR0tixeTea6HCf9mno1snmw
         wWOZKL6NdmHK44FhtHOUcPbRghl8/ND8Aq9FvonqDACOwbJDVWg9hG1T9QXGOdu7pgV6
         E9Ug8nSeZ3EtF2rcZw24XDhWG5oaHkvMT1JwNSMpWAbC9d1VtBPp9ldjesbhfcqFPGwE
         rceg==
X-Forwarded-Encrypted: i=1; AFNElJ8zNaG80pBTfI94QDWgwuNQG2fTD1EmeEn9HV9M1i+VUdviv3LsQO6rHns/Ds+gj2qn5AdE+fI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1d3ec+QUfkAydfl6ETQIkT51z7YnXIYk1MlBpMvaX7j5VlknZ
	NiB1+f33VH2kIPphDQ2siHxPxGvH94lbZeGwgsCR7TGvdqRhNFNm4diNmA1O1tJBLcE=
X-Gm-Gg: Acq92OHyiOpzQo9558tc9nbVggL/XW5JBpLqGDvJBE0ttAx6EnkwwbpAR0NEGEcMIoh
	S20/o0NyyZaDrZkRZwBwABnVo334FPR/oN6UBKKU/w4WfNIH7ADFlnlmadGr8hiGZt9j2fWf/+o
	hcyY2v5/MN3KbhzjlKFwn4GNdRpwFOxbHHxUOrM2LKAisOsD8ewxKwzNzLfJw2399/dckzMX6Pw
	SAcQGaXuy1w8ceZ5hcYNcbE2qRu19W9i5SPHz6UbPzxALivAlJnNSlU5BU484GZVmDt43bOvyNJ
	8Thv1jHm+jxyrR5uCh+idCxz4/Y1wl4x6DJlEvwaDR73lGAnoJUM8M4sYc73lTWG9NifJ1SIYoG
	QNzOoqSCqZbVx2c1qcxIc0ADC5h/bsAomMZ+Q8lUMz/1R1y9ie6i5+0pHoG32LHDKVm1iXDaBSV
	EsrAEoH++pcOPe/RRK3+Fk4cLbuOzUvkswvsDjTrN2JsIQOkBif95Ti1+Ycq0jAh0=
X-Received: by 2002:a05:690c:6c87:b0:7c0:8028:11f7 with SMTP id 00721157ae682-7c959b9720amr280334897b3.6.1779292070323;
        Wed, 20 May 2026 08:47:50 -0700 (PDT)
Received: from toolbox ([12.55.13.134])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0ccf7sm55086957b3.25.2026.05.20.08.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:47:49 -0700 (PDT)
Date: Wed, 20 May 2026 10:47:35 -0500
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>, Paul Walmsley <pjw@kernel.org>
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Songsong Zhang <U2FsdGVkX1@gmail.com>, 
	Michael Ellerman <mpe@kernel.org>, Drew Fustini <fustini@kernel.org>
Subject: Re: [PATCH v2] riscv: misaligned: Make enabling delegation depend on
 NONPORTABLE
Message-ID: <nrvt74qnojaubiwjo37ums4lnclu466hovwrhmtbag6f5uhrql@q6msoe2oto4b>
References: <20260401-riscv-misaligned-dont-delegate-v2-1-5014a288c097@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-riscv-misaligned-dont-delegate-v2-1-5014a288c097@iscas.ac.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tenstorrent.com,reject];
	R_DKIM_ALLOW(-0.20)[tenstorrent.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250021-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[rivosinc.com,kernel.org,dabbelt.com,ghiti.fr,ventanamicro.com,lists.infradead.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[tenstorrent.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asrinivasan@oss.tenstorrent.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tenstorrent.com:dkim]
X-Rspamd-Queue-Id: 91AB75925B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vivian, Paul

On Wed, Apr 01, 2026 at 09:53:17AM +0800, Vivian Wang wrote:
> The unaligned access emulation code in Linux has various deficiencies.
> For example, it doesn't emulate vector instructions [1] [2], and doesn't
> emulate KVM guest accesses. Therefore, requesting misaligned exception
> delegation with SBI FWFT actually regresses vector instructions' and KVM
> guests' behavior.
> 
> Until Linux can handle it properly, guard these sbi_fwft_set() calls
> behind RISCV_SBI_FWFT_DELEGATE_MISALIGNED, which in turn depends on
> NONPORTABLE. Those who are sure that this wouldn't be a problem can
> enable this option, perhaps getting better performance.
> 
> The rest of the existing code proceeds as before, except as if
> SBI_FWFT_MISALIGNED_EXC_DELEG is not available, to handle any remaining
> address misaligned exceptions on a best-effort basis. The KVM SBI FWFT
> implementation is also not touched, but it is disabled if the firmware
> emulates unaligned accesses.

On a Tenstorrent Blackhole with SiFive x280 cores, with OpenSBI 1.7 and
defconfig kernel, I'm seeing a bunch of hangs/opensbi prints at boot time.
Without this patch, the boot prints this and continues on.

[    0.226339] SBI misaligned access exception delegation ok

With this patch, I see a bunch of lines like this

[    0.432225] cpu1: scalar unaligned word access speed is 0.01x byte access speed (slow)
[    0.432232] cpu0: scalar unaligned word access speed is 0.01x byte access speed (slow)
[    0.432232] cpu3: scalar unaligned word access speed is 0.01x byte access speed (slow)
[    0.432232] cpu2: scalar unaligned word access speed is 0.01x byte access speed (slow)

and depending on the boot I either see

sbi_trap_error: hart1: trap1: store fault handler failed (error -3)
sbi_trap_error: hart1: trap1: mcause=0x0000000000000007 mtval=0x0000000000000000
sbi_trap_error: hart1: trap1: mepc=0x00004000300241ec mstatus=0x0000000a00001920
sbi_trap_error: hart1: trap1: ra=0x00004000300241ec sp=0x000040003004ad40
sbi_trap_error: hart1: trap1: gp=0xffffffff81a2b090 tp=0xffffaf800227e400
sbi_trap_error: hart1: trap1: s0=0x000040003004ac80 s1=0x000040003000ef42
sbi_trap_error: hart1: trap1: a0=0x000040003004ceb0 a1=0x000040003004ad18
sbi_trap_error: hart1: trap1: a2=0x0000000000000000 a3=0xffffaf8002944089
sbi_trap_error: hart1: trap1: a4=0x00004000300241ec a5=0x0000000000000004
sbi_trap_error: hart1: trap1: a6=0x000040003004cdf0 a7=0x0000400030010d64
sbi_trap_error: hart1: trap1: s2=0x0000000000000001 s3=0x0000000000000000
sbi_trap_error: hart1: trap1: s4=0x000040003004aeb0 s5=0x0000000000000c01
sbi_trap_error: hart1: trap1: s6=0x0000000000000000 s7=0xffff8f800029b988
sbi_trap_error: hart1: trap1: s8=0xffffffff812b2fb0 s9=0xffff8f800029bae8
sbi_trap_error: hart1: trap1: s10=0x0000000000000000 s11=0x0000000000000000
sbi_trap_error: hart1: trap1: t0=0x0000040000000000 t1=0xffff8f800029bae8
sbi_trap_error: hart1: trap1: t2=0xffffffff810015e0 t3=0xffffffff819e5cb0
sbi_trap_error: hart1: trap1: t4=0x0000000000000007 t5=0x0000000000000003
sbi_trap_error: hart1: trap1: t6=0xffffffff81811d08
sbi_trap_error: hart1: trap0: mcause=0x0000000000000002 mtval=0x00000000c0102573
sbi_trap_error: hart1: trap0: mepc=0xffffffff8091f898 mstatus=0x0000000a00000920
sbi_trap_error: hart1: trap0: ra=0xffffffff800dd346 sp=0xffff8f800029b8f0
sbi_trap_error: hart1: trap0: gp=0xffffffff81a2b090 tp=0xffffaf800227e400
sbi_trap_error: hart1: trap0: s0=0xffff8f800029b900 s1=0xffffffff81897e08
sbi_trap_error: hart1: trap0: a0=0x0000000000000000 a1=0xffffffffffffffff
sbi_trap_error: hart1: trap0: a2=0x0000000000000000 a3=0xffffffff812b2fb0
sbi_trap_error: hart1: trap0: a4=0x0000000000000003 a5=0xffffffff8091f890
sbi_trap_error: hart1: trap0: a6=0x0000000000000000 a7=0xffffffff819e5ca0
sbi_trap_error: hart1: trap0: s2=0xffffaf80fe3b03a8 s3=0x0000000000000004
sbi_trap_error: hart1: trap0: s4=0xffffffff81897e08 s5=0x0000000000000000
sbi_trap_error: hart1: trap0: s6=0x0000000000000000 s7=0xffff8f800029b988
sbi_trap_error: hart1: trap0: s8=0xffffffff812b2fb0 s9=0xffff8f800029bae8
sbi_trap_error: hart1: trap0: s10=0x0000000000000000 s11=0x0000000000000000
sbi_trap_error: hart1: trap0: t0=0xffffffff81001548 t1=0xffff8f800029bae8
sbi_trap_error: hart1: trap0: t2=0xffffffff810015e0 t3=0xffffffff819e5cb0
sbi_trap_error: hart1: trap0: t4=0x0000000000000007 t5=0x0000000000000003
sbi_trap_error: hart1: trap0: t6=0xffffffff81811d08

or

[    0.252142] Oops - instruction access fault [#1]
[    0.252150] Modules linked in:
[    0.252160] CPU: 2 UID: 0 PID: 63 Comm: kworker/2:1 Not tainted 7.1.0-rc4-next-20260519 #1 PREEMPTLAZY 
[    0.252167] Hardware name: Tenstorrent Blackhole (DT)
[    0.252172] Workqueue: events check_vector_unaligned_access
[    0.252186] epc : __riscv_copy_vec_words_unaligned+0xe/0x24
[    0.252192]  ra : measure_cycles.constprop.0+0x5e/0xac
[    0.252197] epc : ffffffff8001a92e ra : ffffffff8001a3f2 sp : ffff8f80002fbca0
[    0.252201]  gp : ffffffff81a2b090 tp : ffffaf8002a41900 t0 : 0000000000000008
[    0.252204]  t1 : ffff8d80000ab708 t2 : 0000000000000008 s0 : ffff8f80002fbce0
[    0.252208]  s1 : 000000001fb5c27a a0 : ffffaf8002add561 a1 : ffffaf8002adf563
[    0.252211]  a2 : 0000000000001f80 a3 : ffffaf8002adff83 a4 : 0000000000001f80
[    0.252214]  a5 : 0000000000000072 a6 : ffffffff81036d70 a7 : ffffffff819e5ca0
[    0.252217]  s2 : ffffffffffffffff s3 : 000000000f37f1cc s4 : ffffffff8001a920
[    0.252220]  s5 : ffffaf8002adc001 s6 : ffffaf8002ade003 s7 : 0000000000000402
[    0.252223]  s8 : ffffaf80fe3c2080 s9 : 0000000000000000 s10: 0000000000000000
[    0.252227]  s11: 0000000000000000 t3 : ffffffff819e5cb0 t4 : 0000000000000007
[    0.252230]  t5 : 0000000000200b20 t6 : 0000000000000001 ssp : 0000000000000000
[    0.252233] status: 8000000200000720 badaddr: 0000400030048d30 cause: 0000000000000001
[    0.252237] [<ffffffff8001a92e>] __riscv_copy_vec_words_unaligned+0xe/0x24
[    0.252243] [<ffffffff8001a46c>] compare_unaligned_access+0x2c/0xac
[    0.252248] [<ffffffff8001a6bc>] check_vector_unaligned_access+0xb4/0x138
[    0.252253] [<ffffffff80047f6a>] process_one_work+0x10e/0x354
[    0.252258] [<ffffffff80048826>] worker_thread+0x136/0x280
[    0.252263] [<ffffffff800500ca>] kthread+0xda/0xfc
[    0.252271] [<ffffffff8001358e>] ret_from_fork_kernel+0x1a/0x154
[    0.252279] [<ffffffff80bb3d9a>] ret_from_fork_kernel_asm+0x16/0x18
[    0.252291] Code: eee3 fad5 8082 7713 fe06 cf19 86b3 00e5 72d7 cd34 (e007) 0205 
[    0.252298] ---[ end trace 0000000000000000 ]---


Sounds like previously we were relying on misaligned trap delegation
without knowing it, and now there seem to be some issues in opensbi
causing these errors.

Has anyone tested this patch on other HW? Paul, any chance you could
test this on other SiFive boards?

Regards
Anirudh Srinivasan

