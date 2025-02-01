Return-Path: <stable+bounces-111870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCE6A24801
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 10:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29783A8321
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 09:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EAD1474A2;
	Sat,  1 Feb 2025 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="abSGzcQq"
X-Original-To: stable@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086A2B9A9;
	Sat,  1 Feb 2025 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738403220; cv=none; b=kp2qXb3IA/oIrfwKnHxOxyheo5tBG1zWPGDgzJiJ9ZLQkfIbkEkOTSj4Rc4bZWMh0qCmIOf84lejqOCJu7f9sKR0QJKJ6+ZsjXaaEtEjmKIq6Cbx/FT4NJyVKMUzUim/qO0Ysrc7Tzw4zBFrpaJwMOi83PxIsh/3jTUCzk8G5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738403220; c=relaxed/simple;
	bh=wfax+lSmFiE6bZtjfNXjyj28adDok+Vk7tISnKd5ys4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jftbT24HkjxqdZtQzixxyNplTn/zD/JEIYorDqH0SvzQ198obMmR3gVi9M44+/yJng++tiZ7l4aYeHv1/UBLZwhbLTrjUungKwK1N8sFbQ8JwK2gPiRwQqKBEq44oPkMyD6FZVwlW8l3I3lYY3py/pKABUoX2rpRb4ETYMZdTbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=abSGzcQq; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HJfXHZ/A+sz+crqL6J+AkJgO1M7+g8HZDeac0KQl+5w=; t=1738403216; x=1739008016; 
	b=abSGzcQqVNUyih8GSyQphGJE7149RiSJhrR+peK3ezcdcv9dchLQ6jI2cxs1wFdQ2jdrnBeccOr
	q97hn6AjFv65heKKnG/YqQ8FIVVU8l7v3Kbn5u7cDzLT+SDrY2vMwpmk6KQ6wbawkRPcm99cLT/Sn
	Jpo3tOEDEyUb9eTFkg+udWBMSnMIv2JTOlcnDH4wkjxAvnXlB93aYJPcbf1aOGSdyCzzvMLDScatO
	DRLOfgVQOT8I3cc+TOToYb1SIPsg+dxRVujxNBxROh/IgGHNRZSRZ8nz6O5YzEe7mkQC/OmETi9UZ
	0lbPyBTkSt5K2vBwuWcMWRqconYY3QoBmR4A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1teA5N-00000003lAb-0Pcg; Sat, 01 Feb 2025 10:46:45 +0100
Received: from [164.15.244.49] (helo=[10.93.216.17])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1teA5M-00000000ews-3fpJ; Sat, 01 Feb 2025 10:46:45 +0100
Message-ID: <6cb712c1c338d3ce5313e05a054ea9de21025ff0.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 0/4] alpha: stack fixes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ivan Kokshaysky <ink@unseen.parts>, Richard Henderson	
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Oleg
 Nesterov	 <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd
 Bergmann	 <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Magnus Lindholm
 <linmag7@gmail.com>, 	linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
Date: Sat, 01 Feb 2025 10:46:43 +0100
In-Reply-To: <20250131104129.11052-1-ink@unseen.parts>
References: <20250131104129.11052-1-ink@unseen.parts>
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

Hi Ivan,

On Fri, 2025-01-31 at 11:41 +0100, Ivan Kokshaysky wrote:
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
> Patches 1-2 are preparatory; 3 - the main fix; 4 - fixes remaining
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
> ---
> Ivan Kokshaysky (4):
>   alpha/uapi: do not expose kernel-only stack frame structures
>   alpha: replace hardcoded stack offsets with autogenerated ones
>   alpha: make stack 16-byte aligned (most cases)
>   alpha: align stack for page fault and user unaligned trap handlers
>=20
>  arch/alpha/include/asm/ptrace.h      | 64 ++++++++++++++++++++++++++-
>  arch/alpha/include/uapi/asm/ptrace.h | 65 ++--------------------------
>  arch/alpha/kernel/asm-offsets.c      |  4 ++
>  arch/alpha/kernel/entry.S            | 24 +++++-----
>  arch/alpha/kernel/traps.c            |  2 +-
>  arch/alpha/mm/fault.c                |  4 +-
>  6 files changed, 83 insertions(+), 80 deletions(-)

Thanks, I'm testing the v2 series of the patches now.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

