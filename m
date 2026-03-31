Return-Path: <stable+bounces-231409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOICLqa3y2mCKgYAu9opvQ
	(envelope-from <stable+bounces-231409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:01:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDA53693DA
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47A043019B85
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 11:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2CB3D8909;
	Tue, 31 Mar 2026 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Pj8D0Bb7"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301C2C0F6C;
	Tue, 31 Mar 2026 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958308; cv=none; b=Yi4plVkzn3E5IGCHQ93g6ssOnzi7fQb3XJUnWNfEqMXZuZA5Ca+y/GDmZbwtjlB4qq3nLgOgmtBnSmWt456Hh8ajnlOaYcGaaAA4eXfJVyo83bwnf0tLRL6fnvZWhAvZuzKZ5acS9YBpAu5Q8FA1LYAJ1lXLfOJlmaDE0x1MM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958308; c=relaxed/simple;
	bh=3mf8dvG+9rFVnKzVa1OC9tPsr+jcRYU4szsDa0j10BI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=opd4Ej3jc6pfKpohRDcGVT9LziZ4GavTvbjq0E/uY+RFDz2DARnUELupUHhzn5KHon7BAI2ICYyS6MufModIGP0q54PkJU39RXXE2tv97w84nrYDueAJdcq+Rrtt87H2XWU3rfBoyuFxM2RiJmZqbkFUJYwTr5Kfx9lI2tjmn8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Pj8D0Bb7; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1774958298;
	bh=Q+6Na3CE55bhXWEE7x8LaGzTN9Zx6l20lYyfBDEpFeM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Pj8D0Bb7H+eyChHPT6p55yxWqElVcZmbxgfg3dZT2gXwe13I+9gKA9DoUhWp2+CjO
	 yVMPfTukcAn0ZyMgp5MRBM1pQYvmMbQXoGDulbKVRqPGoTCjmrvaPVP+Dr8jLHHBn6
	 3Hyc0IDOe8bUTflTTArhuDkD/8m4k2paYcw9eLgg=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 17C0865992;
	Tue, 31 Mar 2026 07:58:16 -0400 (EDT)
Message-ID: <42ab19d20e572c61587728350b5f1ca900632322.camel@xry111.site>
Subject: Re: [PATCH for 6.6] LoongArch: vDSO: Emit GNU_EH_FRAME correctly
From: Xi Ruoyao <xry111@xry111.site>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huacai Chen
	 <chenhuacai@loongson.cn>
Cc: Sasha Levin <sashal@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	loongarch@lists.linux.dev
Date: Tue, 31 Mar 2026 19:58:15 +0800
In-Reply-To: <2026033148-expletive-many-cd82@gregkh>
References: <20260330100133.3955364-1-chenhuacai@loongson.cn>
	 <2026033148-expletive-many-cd82@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231409-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[xry111.site:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xry111.site:dkim,xry111.site:email,xry111.site:mid]
X-Rspamd-Queue-Id: 7FDA53693DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-03-31 at 13:10 +0200, Greg Kroah-Hartman wrote:
> On Mon, Mar 30, 2026 at 06:01:33PM +0800, Huacai Chen wrote:
> > From: Xi Ruoyao <xry111@xry111.site>
> >=20
> > commit e4878c37f6679fdea91b27a0f4e60a871f0b7bad upstream.
> >=20
> > With -fno-asynchronous-unwind-tables and --no-eh-frame-hdr (the default
> > of the linker), the GNU_EH_FRAME segment (specified by vdso.lds.S) is
> > empty.=C2=A0 This is not valid, as the current DWARF specification mand=
ates
> > the first byte of the EH frame to be the version number 1.=C2=A0 It cau=
ses
> > some unwinders to complain, for example the ClickHouse query profiler
> > spams the log with messages:
> >=20
> > =C2=A0=C2=A0=C2=A0 clickhouse-server[365854]: libunwind: unsupported .e=
h_frame_hdr
> > =C2=A0=C2=A0=C2=A0 version: 127 at 7ffffffb0000
> >=20
> > Here "127" is just the byte located at the p_vaddr (0, i.e. the
> > beginning of the vDSO) of the empty GNU_EH_FRAME segment. Cross-
> > checking with /proc/365854/maps has also proven 7ffffffb0000 is the
> > start of vDSO in the process VM image.
> >=20
> > In LoongArch the -fno-asynchronous-unwind-tables option seems just a
> > MIPS legacy, and MIPS only uses this option to satisfy the MIPS-specifi=
c
> > "genvdso" program, per the commit cfd75c2db17e ("MIPS: VDSO: Explicitly
> > use -fno-asynchronous-unwind-tables").=C2=A0 IIRC it indicates some inh=
erent
> > limitation of the MIPS ELF ABI and has nothing to do with LoongArch.=C2=
=A0 So
> > we can simply flip it over to -fasynchronous-unwind-tables and pass
> > --eh-frame-hdr for linking the vDSO, allowing the profilers to unwind t=
he
> > stack for statistics even if the sample point is taken when the PC is i=
n
> > the vDSO.
> >=20
> > However simply adjusting the options above would exploit an issue: when
> > the libgcc unwinder saw the invalid GNU_EH_FRAME segment, it silently
> > falled back to a machine-specific routine to match the code pattern of
> > rt_sigreturn() and extract the registers saved in the sigframe if the
> > code pattern is matched.=C2=A0 As unwinding from signal handlers is vit=
al for
> > libgcc to support pthread cancellation etc., the fall-back routine had
> > been silently keeping the LoongArch Linux systems functioning since
> > Linux 5.19.=C2=A0 But when we start to emit GNU_EH_FRAME with the corre=
ct
> > format, fall-back routine will no longer be used and libgcc will fail
> > to unwind the sigframe, and unwinding from signal handlers will no
> > longer work, causing dozens of glibc test failures.=C2=A0 To make it po=
ssible
> > to unwind from signal handlers again, it's necessary to code the unwind
> > info in __vdso_rt_sigreturn via .cfi_* directives.
> >=20
> > The offsets in the .cfi_* directives depend on the layout of struct
> > sigframe, notably the offset of sigcontext in the sigframe.=C2=A0 To us=
e the
> > offset in the assembly file, factor out struct sigframe into a header t=
o
> > allow asm-offsets.c to output the offset for assembly.
> >=20
> > To work around a long-term issue in the libgcc unwinder (the pc is
> > unconditionally substracted by 1: doing so is technically incorrect for
> > a signal frame), a nop instruction is included with the two real
> > instructions in __vdso_rt_sigreturn in the same FDE PC range.=C2=A0 The=
 same
> > hack has been used on x86 for a long time.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: c6b99bed6b8f ("LoongArch: Add VDSO and VSYSCALL support")
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
>=20
> Does not apply cleanly on the latest 6.12.y queue :(

This is for 6.6.  Maybe your agent is malfunctioning?

--=20
Xi Ruoyao <xry111@xry111.site>

