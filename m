Return-Path: <stable+bounces-93608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B13119CFA20
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 23:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA09B61301
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 22:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F91F76D5;
	Fri, 15 Nov 2024 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="QDaSXODW"
X-Original-To: stable@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE91E261E;
	Fri, 15 Nov 2024 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707401; cv=none; b=BEm326auustDiWwr6ntqjAk/VHFKA+fvSBp29wFtW+3ZMxbwKumqyYYmMy+dKAkx5H8uIse7pMeGrQwAKQdV15ycp+Jo5Zd6ASFUUe3lWkTXlbVbD6SRDQsoWmGhNrDFG4hAL9rW3kcJaG2M6AI4sDehNRop3tmfyI74SdQUuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707401; c=relaxed/simple;
	bh=RBsCvaccGcvYyCrjd7CjL4oegLTgWL9V38JUNqV3SK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2v5J7sxzAGByRw1AjHhGltNLrWWd87vefQAddvANinEE2exuuChC7UjxULoABvRpI+EmNca+EakiGVbZTr8sVfa+V51WFzAmMXKtKgvdfkgcwAm2hBovQalmvTOz9V8ngXFZ+o9ScPm2LMmE0FMoSKJbT3c1sv8wIvzxKtcYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=QDaSXODW; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=prMCeiS3C5eJ4JUpUHzaK1wSkzL+Nfbek9oMDzah4h0=; b=QDaSXODWgq8n0WBjsGY9mufYRE
	TprfLoI9CPd0FjQsYPK2yfUZzgi1tSu29V5Et0dXxfSrwlpnjVXwSdgVxuOcNaDT+B99oKycmjsmB
	DAABnDWgi07vWpOjFBUvxdqQ5eR3afnCJXEwU7k4FqxuQnDpot0lExyWy/eWu/KAqnGYpHkkW1HwM
	uylRomXHgYBtXoB6tACZYx/mNUrZ8SedBZSQqQrO19ColuLE/x9NgtXDJsy3Etgxj0mjJxwXTdMnW
	nhLSuiNcEworCLm/4gF1muA7o4RXFgXaC525GxvuC7BZ56mRTvSOlCbXWgiNhGFN+8m6bGS8lowou
	wlzpax5A==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1tC4Bl-00D5ON-36;
	Fri, 15 Nov 2024 22:49:13 +0100
Date: Fri, 15 Nov 2024 22:49:12 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>,
	Andrea Bolognani <abologna@redhat.com>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>,
	Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
	Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] riscv/entry: get correct syscall number from
 syscall_get_nr()
Message-ID: <ZzfB2LfsD0ATjLMv@aurel32.net>
Mail-Followup-To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>,
	Andrea Bolognani <abologna@redhat.com>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>,
	Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
	Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <87ldya4nv0.ffs@tglx>
 <87sesgftng.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87sesgftng.fsf@all.your.base.are.belong.to.us>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2024-10-28 02:45, Bj=C3=B6rn T=C3=B6pel wrote:
> Thanks for helping out to dissect this! Much appreciated!
>=20
> Thomas Gleixner <tglx@linutronix.de> writes:
>=20
> > Let me look at your failure analysis from your first reply:
> >
> >>  1. strace "tracing": Requires that regs->a0 is not tampered with prior
> >>     ptrace notification
> >>=20
> >>     E.g.:
> >>     | # ./strace /
> >>     | execve("/", ["/"], 0x7ffffaac3890 /* 21 vars */) =3D -1 EACCES (=
Permission denied)
> >>     | ./strace: exec: Permission denied
> >>     | +++ exited with 1 +++
> >>     | # ./disable_ptrace_get_syscall_info ./strace /
> >>     | execve(0xffffffffffffffda, ["/"], 0x7fffd893ce10 /* 21 vars */) =
=3D -1 EACCES (Permission denied)
> >>     | ./strace: exec: Permission denied
> >>     | +++ exited with 1 +++
> >>=20
> >>     In the second case, arg0 is prematurely set to -ENOSYS
> >>     (0xffffffffffffffda).
> >
> > That's expected if ptrace_get_syscall_info() is not used. Plain dumping
> > registers will give you the current value on all architectures.
> > ptrace_get_syscall_info() exist exactly for that reason.
>=20
> Noted! So this shouldn't be considered as a regression. IOW, the
> existing upstream code is OK for this scenario.

Not however that it breaks some programs, for instance I arrived on this
thread by debugging python-ptrace. I'll try to look at adding support
for ptrace_get_syscall_info(), but I am afraid we will find more broken
programs.

Regards
Aurelien

[1] https://buildd.debian.org/status/fetch.php?pkg=3Dpython-ptrace&arch=3Dr=
iscv64&ver=3D0.9.9-0.1%2Bb2&stamp=3D1731547088&raw=3D0

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

