Return-Path: <stable+bounces-2786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95FB7FA82F
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 18:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068C21C20B49
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 17:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A17439FFB;
	Mon, 27 Nov 2023 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Jmk1zmjM"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B29671BD
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 09:36:36 -0800 (PST)
Received: from pwmachine.localnet (85-170-33-133.rev.numericable.fr [85.170.33.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8D10320B74C0;
	Mon, 27 Nov 2023 09:36:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D10320B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701106596;
	bh=KZSrPZS4GnBXet7XQH5E8T01IHn4hgHrPfxUSKwdoT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jmk1zmjMfJg7yz/MlpTpSkkavuIbfWEtWxyMVs41MHKcl/urClGYPn/Iq0d7XewOI
	 St4g0oUr1+zWAxtACmIXKzEv1DHIE2iQDS5HarYPkAMFBJ545zFLprlxPW3imueAXg
	 Rju52jpncMRLDkK4P1UzTvSQew71icgK3VPuyGgs=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 4.19.y] tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
Date: Mon, 27 Nov 2023 18:36:32 +0100
Message-ID: <2305896.ElGaqSPkdT@pwmachine>
In-Reply-To: <2023112701-comfy-resemble-4e42@gregkh>
References: <2023102138-riverbed-senator-e356@gregkh> <5993767.lOV4Wx5bFT@pwmachine> <2023112701-comfy-resemble-4e42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi!


Le lundi 27 novembre 2023, 16:44:22 CET Greg KH a =C3=A9crit :
> On Mon, Nov 27, 2023 at 03:41:31PM +0100, Francis Laniel wrote:
> > Hi!
> >=20
> > Le vendredi 24 novembre 2023, 17:17:04 CET Greg KH a =C3=A9crit :
> > > On Fri, Nov 24, 2023 at 01:24:13PM +0100, Francis Laniel wrote:
> > > > When a kprobe is attached to a function that's name is not unique (=
is
> > > > static and shares the name with other functions in the kernel), the
> > > > kprobe is attached to the first function it finds. This is a bug as
> > > > the
> > > > function that it is attaching to is not necessarily the one that the
> > > > user wants to attach to.
> > > >=20
> > > > Instead of blindly picking a function to attach to what is ambiguou=
s,
> > > > error with EADDRNOTAVAIL to let the user know that this function is
> > > > not
> > > > unique, and that the user must use another unique function with an
> > > > address offset to get to the function they want to attach to.
> > > >=20
> > > > Link:
> > > > https://lore.kernel.org/all/20231020104250.9537-2-flaniel@linux.mic=
ros
> > > > oft
> > > > .com/
> > > >=20
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 413d37d1eb69 ("tracing: Add kprobe-based event tracer")
> > > > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > > > Link:
> > > > https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea74=
2@k
> > > > ern
> > > > el.org/ Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > (cherry picked from commit b022f0c7e404887a7c5229788fc99eff9f9a80d5)
> > > > ---
> > > >=20
> > > >  kernel/trace/trace_kprobe.c | 48
> > > >  +++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 48 insertions(+)
> > >=20
> > > Again, we need a version for 5.4.y as well before we can take this
> > > version.
> >=20
> > I sent the 5.4.y patch some times ago, you can find it here:
> > https://lore.kernel.org/stable/20231023113623.36423-2-flaniel@linux.mic=
ros
> > oft.com/
> >=20
> > With the recent batch I sent, I should have cover all the stable kernel=
s.
> > In case I miss one, please indicate it to me so I can fix this problem =
and
> > ensure all stable kernels have a corresponding patch.
>=20
> I only see the following in my stable mbox right now:
>=20
>    1   C Nov 27 Francis Laniel  (4.4K) =E2=94=AC=E2=94=80>[PATCH 5.10.y] =
tracing/kprobes:
> Return EADDRNOTAVAIL when func matches several symbols 2 r C Nov 24 Franc=
is
> Laniel  (4.4K) =E2=94=94=E2=94=80>[PATCH 5.10.y] tracing/kprobes: Return =
EADDRNOTAVAIL when
> func matches several symbols 3   F Nov 24 To Francis Lani (1.5K)   =E2=94=
=94=E2=94=80>
>    4 r T Nov 27 Francis Laniel  (1.9K)     =E2=94=94=E2=94=80>
>    5   F Nov 27 To Francis Lani (2.0K)       =E2=94=94=E2=94=80>
>   23 r C Nov 24 Francis Laniel  (2.7K) [PATCH 4.19.y] tracing/kprobes:
> Return EADDRNOTAVAIL when func matches several symbols 24 r + Nov 27
> Francis Laniel  (2.0K) =E2=94=94=E2=94=80>
>=20
> So could you resend them all just to be sure I have all of the latest
> versions that you wish to have applied?

I normally sent again the patch for version 4.14 to 5.15 (it was already=20
present in 6.1 and 6.6).
I tested all of them by building the corresponding kernel with the patch=20
applied before sending, so they should not break compilation or testing.

Can you please confirm me you received them?

> thanks,
>=20
> greg "drowning in patches" k-h

*throws a buoy at greg k-h*


Best regards.



