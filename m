Return-Path: <stable+bounces-114846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6306EA30464
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DB33A70AA
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0130A1EEA3B;
	Tue, 11 Feb 2025 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Nko3S0IT"
X-Original-To: stable@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30601EDA37;
	Tue, 11 Feb 2025 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739258612; cv=none; b=PZXpsmvZNZO+IEKuCJxbmhaQr2kjtvjpQ2TtMmCTDGGF7HzZuDb6/BeJynYQAHmoRFs8pSdMOqOIYfI7RMRg9zoiCdMf9wvICObEezLEr6ZkggIYzmEosmY7g/0sEsJyPtmgMSdNpTGv/sOlbyPT+9epEcJ2mvCkq2+POf5slcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739258612; c=relaxed/simple;
	bh=UWJM5C0X6jg73GF3CAKzpkI5JGcapvJ3PDDVYAlgRc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tkir7h7cQCfySEbXYU/7bmWXDgCq/BYSOzS26CjtLbX0J/pJ9fX3rzMJbYJuGhCVj6J3Aq/uSgvQjmnpTc5dShiM8Emb28+nZTXIIvykCrjf2hHbSat49syVyG0Qh3daEUKJ+qFtd8GFPzvw0EoGhSAYUcikHkpmjn7E6dpe/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Nko3S0IT; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gXAxZaL3ngoWD1PltbbXQgbkIXLOLON/P4Nk8X4kGkY=; t=1739258609; x=1739863409; 
	b=Nko3S0ITgh1+CDQWxBwJuX7fcsmQAsjjDSbVVOPkaADjdY4HQjuzqObLaiLxMkkzgLQIhUGotE+
	VcDvMgG6x/aU0zsbmvnI1g/sy2rc173GpBrHy1IdusOXTxAD5c8s6CbyMkUwRzZsVCU0w4tUB0jXZ
	yy1K6bQpMI13KuXC8ib8kxCI30x1G/7auP1mQqmjVW1kzKkGT+mPfEFcKOIjbgd7by2lS8C5QEsiD
	K2ec8MLyHO5eodrIq2ffIOtGPvT2vo5+CnBF17ueM+keeH4Y+AFlLDZvMdhq5T2FYeM6i/vmJ7NE2
	o6rdlp57BPqc7h+A+PN0xYoA+mo0FsA8Y4rg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1thkYo-00000003Hlj-0Vvt; Tue, 11 Feb 2025 08:19:58 +0100
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1thkYn-00000000VEl-3bs6; Tue, 11 Feb 2025 08:19:58 +0100
Message-ID: <9a70a5806083499db5649f8c76167a1a61cde058.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 0/3] alpha: stack fixes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ivan Kokshaysky <ink@unseen.parts>, Richard Henderson	
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Oleg
 Nesterov	 <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd
 Bergmann	 <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Magnus Lindholm
 <linmag7@gmail.com>, 	linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
Date: Tue, 11 Feb 2025 08:19:57 +0100
In-Reply-To: <20250204223524.6207-1-ink@unseen.parts>
References: <20250204223524.6207-1-ink@unseen.parts>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

On Tue, 2025-02-04 at 23:35 +0100, Ivan Kokshaysky wrote:
> This series fixes oopses on Alpha/SMP observed since kernel v6.9. [1]
> Thanks to Magnus Lindholm for identifying that remarkably longstanding
> bug.
>=20
> The problem is that GCC expects 16-byte alignment of the incoming stack
> since early 2004, as Maciej found out [2]:
>   Having actually dug speculatively I can see that the psABI was changed =
in
>  GCC 3.5 with commit e5e10fb4a350 ("re PR target/14539 (128-bit long doub=
le
>  improperly aligned)") back in Mar 2004, when the stack pointer alignment
>  was increased from 8 bytes to 16 bytes, and arch/alpha/kernel/entry.S ha=
s
>  various suspicious stack pointer adjustments, starting with SP_OFF which
>  is not a whole multiple of 16.
>=20
> Also, as Magnus noted, "ALPHA Calling Standard" [3] required the same:
>  D.3.1 Stack Alignment
>   This standard requires that stacks be octaword aligned at the time a
>   new procedure is invoked.
>=20
> However:
> - the "normal" kernel stack is always misaligned by 8 bytes, thanks to
>   the odd number of 64-bit words in 'struct pt_regs', which is the very
>   first thing pushed onto the kernel thread stack;
> - syscall, fault, interrupt etc. handlers may, or may not, receive aligne=
d
>   stack depending on numerous factors.
>=20
> Somehow we got away with it until recently, when we ended up with
> a stack corruption in kernel/smp.c:smp_call_function_single() due to
> its use of 32-byte aligned local data and the compiler doing clever
> things allocating it on the stack.
>=20
> Patche 1 is preparatory; 2 - the main fix; 3 - fixes remaining
> special cases.
>=20
> Ivan.
>=20
> [1] https://lore.kernel.org/rcu/CA+=3DFv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=3D=
Ei90G98ukRcRJA@mail.gmail.com/#r
> [2] https://lore.kernel.org/rcu/alpine.DEB.2.21.2501130248010.18889@angie=
.orcam.me.uk/
> [3] https://bitsavers.org/pdf/dec/alpha/Alpha_Calling_Standard_Rev_2.0_19=
900427.pdf
> ---
> Changes in v2:
> - patch #1: provide empty 'struct pt_regs' to fix compile failure in libb=
pf,
>   reported by John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>;
>   update comment and commit message accordingly;
> - cc'ed <stable@vger.kernel.org> as older kernels ought to be fixed as we=
ll.
>=20
> Changes in v3:
> - patch #1 dropped for the time being;
> - updated commit messages as Maciej suggested.
> ---
> Ivan Kokshaysky (3):
>   alpha: replace hardcoded stack offsets with autogenerated ones
>   alpha: make stack 16-byte aligned (most cases)
>   alpha: align stack for page fault and user unaligned trap handlers
>=20
>  arch/alpha/include/uapi/asm/ptrace.h |  2 ++
>  arch/alpha/kernel/asm-offsets.c      |  4 ++++
>  arch/alpha/kernel/entry.S            | 24 ++++++++++--------------
>  arch/alpha/kernel/traps.c            |  2 +-
>  arch/alpha/mm/fault.c                |  4 ++--
>  5 files changed, 19 insertions(+), 17 deletions(-)

Can we get this landed this week, maybe for v6.14-rc3? This way it will qui=
ckly
backported to various stable kernels which means it will reach Debian unsta=
ble
within a few days.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

