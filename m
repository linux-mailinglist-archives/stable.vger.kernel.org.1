Return-Path: <stable+bounces-142912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A96AB0122
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 19:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C635027FB
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 17:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004E928688E;
	Thu,  8 May 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NpDcB/Yq"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC6D28642F
	for <stable@vger.kernel.org>; Thu,  8 May 2025 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724383; cv=none; b=ZS1ozCA4Kce/Gl7z5QmhaIj89TQkwL2viYe+8cDcgtDoSEt04DS+3iB+8ezFed0Q/8ATZnS/ZmZgVBRgR38Iy6jOFU2U3MTcjX028FjiWjeQ3KO6DHZACxK5RCydm9UHwexaXpDhQ4NC3JuxLr66QoN4mShws6uyTVzm2aReBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724383; c=relaxed/simple;
	bh=kplQ/oOJvA0YG6pIrZr8gYPWx1aw2fbKAIZHQ0YCzCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f36w4Bs601s3N2WDtsSe3kRAS9z5jFELFf8G0CXNX9WD9TQ56jdc1O4gnb/a24WB0od1pZUrrmpg3UxJ+SeRJJ0mz6PcmktOOQbRK5GmBV19FTBgnoKK0lF/JK/wWUT3vkPN0nSE2GqMA6AU0j0AO3Jr0iUHnX2y01sk/getRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NpDcB/Yq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ViC3Vp7dErVibjpIJ8GsP8Af1EHoNwDVFisWnZ+tltY=;
	t=1746724382; x=1747933982; b=NpDcB/YqoMzHAJDp7WCp5ZGtjHvDOhgWMKbGzhTpz85Vnbr
	8EdnCaWaPzuXA1rK8pq/WJmzPq5RxfRHJc2p5dmr4OqZiV2JFdiRNAFyixstfsCGYSD2l1w2o361v
	vKq/DlsTTlgbES+jYSA5NFEt0oO1/iwv6SKnd5zLcp5kkS2U7bNfVAPXHa5o2vAPPyT+G6FL77bYl
	lqZwMVI2W0FP/iUyyemzCz0tG0sfoVJZAfq3qYOpBB5Fi2NBtcc6UTDPd65AiS5Ei82LeV3n8H11H
	CGHCUCFk2THc3rfB0Fs04Jk9UNeOguPDAvTfH2ioeilrjgy4VaguUvjJ8k4mnYqA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uD4nq-0000000Apcs-3tlu;
	Thu, 08 May 2025 19:12:59 +0200
Message-ID: <8ce0b6056a9726e540f61bce77311278654219eb.camel@sipsolutions.net>
Subject: Re: Missing patch in 6.12.27 - breaks UM target builds
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>, 
	linux-um@lists.infradead.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 08 May 2025 19:12:57 +0200
In-Reply-To: <0df8de9f-d24a-4ffb-8234-7d7bbe1660a4@isd.uni-stuttgart.de>
References: <20250314130815.226872-1-benjamin@sipsolutions.net>
	 <0df8de9f-d24a-4ffb-8234-7d7bbe1660a4@isd.uni-stuttgart.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

I think it is better to just not backport
0b8b2668f9981c1fefc2ef892bd915288ef01f33 ("um: insert scheduler ticks
when userspace does not yield").

Benjamin

On Thu, 2025-05-08 at 19:00 +0200, Christian Lamparter wrote:
> Hi,
>=20
> On 3/14/25 2:08 PM, Benjamin Berg wrote:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> > =C2=A0=C2=A0=C2=A0 um: work around sched_yield not yielding in time-tra=
vel mode
> >=20
> > sched_yield by a userspace may not actually cause scheduling in
> > time-travel mode as no time has passed. In the case seen it appears
> > to
> > be a badly implemented userspace spinlock in ASAN. Unfortunately,
> > with
> > time-travel it causes an extreme slowdown or even deadlock
> > depending on
> > the kernel configuration (CONFIG_UML_MAX_USERSPACE_ITERATIONS).
> >=20
> > Work around it by accounting time to the process whenever it
> > executes a
> > sched_yield syscall.
> >=20
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
>=20
> =C2=A0From what I can tell the patch mentioned above was backported to
> 6.12.27 by:
> <
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commi
> t/arch/um?id=3D887c5c12e80c8424bd471122d2e8b6b462e12874>
>=20
> but without the upstream
> > Commit 0b8b2668f9981c1fefc2ef892bd915288ef01f33
> > Author: Benjamin Berg <benjamin.berg@intel.com>
> > Date: =C2=A0=C2=A0Thu Oct 10 16:25:37 2024 +0200
> > =C2=A0 um: insert scheduler ticks when userspace does not yield
> >=20
> > =C2=A0=C2=A0 In time-travel mode userspace can do a lot of work without=
 any
> > time
> > =C2=A0=C2=A0 passing. Unfortunately, this can result in OOM situations =
as the
> > RCU
> > =C2=A0 core code will never be run. [...]
>=20
> the kernel build for 6.12.27 for the UM-Target will fail:
>=20
> > /usr/bin/ld: arch/um/kernel/skas/syscall.o: in function
> > `handle_syscall': linux-
> > 6.12.27/arch/um/kernel/skas/syscall.c:43:(.text+0xa2): undefined
> > reference to `tt_extra_sched_jiffies'
> > collect2: error: ld returned 1 exit status
>=20
> is it possible to backport 0b8b2668f9981c1fefc2ef892bd915288ef01f33
> too?
> Or is it better to revert 887c5c12e80c8424bd471122d2e8b6b462e12874
> again
> in the stable releases?
>=20
> Best Regards,
> Christian Lamparter
>=20
> >=20
> > ---
> >=20
> > I suspect it is this code in ASAN that uses sched_yield
> > =C2=A0=C2=A0
> > https://github.com/llvm/llvm-project/blob/main/compiler-rt/lib/sanitize=
r_common/sanitizer_mutex.cpp
> > though there are also some other places that use sched_yield.
> >=20
> > I doubt that code is reasonable. At the same time, not sure that
> > sched_yield is behaving as advertised either as it obviously is not
> > necessarily relinquishing the CPU.
> > ---
> > =C2=A0 arch/um/include/linux/time-internal.h |=C2=A0 2 ++
> > =C2=A0 arch/um/kernel/skas/syscall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 11 +++++++++++
> > =C2=A0 2 files changed, 13 insertions(+)
> >=20
> > diff --git a/arch/um/include/linux/time-internal.h
> > b/arch/um/include/linux/time-internal.h
> > index b22226634ff6..138908b999d7 100644
> > --- a/arch/um/include/linux/time-internal.h
> > +++ b/arch/um/include/linux/time-internal.h
> > @@ -83,6 +83,8 @@ extern void time_travel_not_configured(void);
> > =C2=A0 #define time_travel_del_event(...) time_travel_not_configured()
> > =C2=A0 #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
> > =C2=A0=20
> > +extern unsigned long tt_extra_sched_jiffies;
> > +
> > =C2=A0 /*
> > =C2=A0=C2=A0 * Without CONFIG_UML_TIME_TRAVEL_SUPPORT this is a linker =
error
> > if used,
> > =C2=A0=C2=A0 * which is intentional since we really shouldn't link it i=
n that
> > case.
> > diff --git a/arch/um/kernel/skas/syscall.c
> > b/arch/um/kernel/skas/syscall.c
> > index b09e85279d2b..a5beaea2967e 100644
> > --- a/arch/um/kernel/skas/syscall.c
> > +++ b/arch/um/kernel/skas/syscall.c
> > @@ -31,6 +31,17 @@ void handle_syscall(struct uml_pt_regs *r)
> > =C2=A0=C2=A0		goto out;
> > =C2=A0=20
> > =C2=A0=C2=A0	syscall =3D UPT_SYSCALL_NR(r);
> > +
> > +	/*
> > +	 * If no time passes, then sched_yield may not actually
> > yield, causing
> > +	 * broken spinlock implementations in userspace (ASAN) to
> > hang for long
> > +	 * periods of time.
> > +	 */
> > +	if ((time_travel_mode =3D=3D TT_MODE_INFCPU ||
> > +	=C2=A0=C2=A0=C2=A0=C2=A0 time_travel_mode =3D=3D TT_MODE_EXTERNAL) &&
> > +	=C2=A0=C2=A0=C2=A0 syscall =3D=3D __NR_sched_yield)
> > +		tt_extra_sched_jiffies +=3D 1;
> > +
> > =C2=A0=C2=A0	if (syscall >=3D 0 && syscall < __NR_syscalls) {
> > =C2=A0=C2=A0		unsigned long ret =3D EXECUTE_SYSCALL(syscall,
> > regs);
> > =C2=A0=20
>=20
>=20


