Return-Path: <stable+bounces-249113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMGWBdLjCWo6twQAu9opvQ
	(envelope-from <stable+bounces-249113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:50:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB71456223F
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 032523003D12
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713593B4EA5;
	Sun, 17 May 2026 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="MLM5Z8rn"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432640855;
	Sun, 17 May 2026 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779033037; cv=none; b=tUFZzahFQ+FKvnTXWZJauodCBCRGnokTFVitejMaCkKxGE9P1ru9ZPwWArQY0VwF4rv+b9+pO13hdL83SdzF9dDpq4gJbM0iem9XJOnCRtJYavlUUjWi9+TF6MgAOchV2VcRkGb9m/8KyQwiLIlNaLNrVpsX1vLyJBzn970KUdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779033037; c=relaxed/simple;
	bh=wLOYwE8WUg69XycQBoA8mmIvpN54dz1OW67T8Jk73g8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qJSJQwe4fwyovrY8y/LMeRuH19a0BfGD9OQskIHsjINlQwU9Olf65aPfMCjlU7NatbylSlK4WwjofM/ALxYo+cH3W4L2Z0d55BNxx7ahy4r8mgFV5CaSmBz1aljHvdumI3g4gjp/IAFxMKM5ZRRVulekK0hbMD2G9Imed7ouNfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=MLM5Z8rn; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1779032472;
	bh=acTPhhZ8T4/kftVIx/SIb/SY4r6jw6Sos9c0kyE9qlg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MLM5Z8rncS6vPb6+OXBQRN56srVPBuQNT1pqM52QYCt7iAkmMHZC4gYE8dxwyxYsR
	 9cPwUU0tsyZRLGnwyTUBn30yoPb/hfiIyeM+ag977u6bHs+XEy6TblgzEUqqSMlmbe
	 Hf1STzLpmfqq4bViX8Mt0ffPoVNTrUZexB8+GIZA=
Received: from [192.168.42.56] (unknown [182.102.57.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id E2A116597E;
	Sun, 17 May 2026 11:41:10 -0400 (EDT)
Message-ID: <ce45668b766e6dd58ff0eda8e7fe1c07e14ef758.camel@xry111.site>
Subject: Re: [PATCH] powerpc: define __LITTLE_ENDIAN and __BIG_ENDIAN for
 math-emu
From: Xi Ruoyao <xry111@xry111.site>
To: David Laight <david.laight.linux@gmail.com>, Mingcong Bai
 <jeffbai@aosc.io>
Cc: linux-kernel@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>, 
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>, Madhavan
 Srinivasan	 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin	 <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, 	linuxppc-dev@lists.ozlabs.org
Date: Sun, 17 May 2026 23:40:37 +0800
In-Reply-To: <20260517145421.2d1ac77c@pumpkin>
References: <20260517041423.71243-1-jeffbai@aosc.io>
	 <20260517145421.2d1ac77c@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: AB71456223F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249113-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,aosc.io];
	FREEMAIL_CC(0.00)[vger.kernel.org,aosc.io,intel.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[xry111.site:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,xry111.site:email,xry111.site:mid,xry111.site:dkim]
X-Rspamd-Action: no action

On Sun, 2026-05-17 at 14:54 +0100, David Laight wrote:
> On Sun, 17 May 2026 12:14:21 +0800
> Mingcong Bai <jeffbai@aosc.io> wrote:
>=20
> > Similar to commit b929926f01f2 ("sh: define __BIG_ENDIAN for math-emu")=
,
> > define __LITTLE_ENDIAN and __BIG_ENDIAN as 0 to mitigate build-time
> > warnings:
> >=20
> > =C2=A0 ./include/math-emu/double.h:59:21: error: =E2=80=98__BIG_ENDIAN=
=E2=80=99 is not defined, evaluates to =E2=80=980=E2=80=99 [-Werror=3Dundef=
]
> > =C2=A0=C2=A0=C2=A0=C2=A0 59 | #if __BYTE_ORDER =3D=3D __BIG_ENDIAN
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 13da9e200fe4 ("Revert "endian: #define __BYTE_ORDER"")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202507301656.7FEX6J5W-lkp=
@intel.com/
> > Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> > ---
> > =C2=A0arch/powerpc/include/asm/sfp-machine.h | 4 +++-
> > =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/incl=
ude/asm/sfp-machine.h
> > index 8b957aabb826d..db8525605c026 100644
> > --- a/arch/powerpc/include/asm/sfp-machine.h
> > +++ b/arch/powerpc/include/asm/sfp-machine.h
> > @@ -319,10 +319,12 @@
> > =C2=A0#define abort()								\
> > =C2=A0	return 0
> > =C2=A0
> > -#ifdef __BIG_ENDIAN
> > +#ifdef __BIG_ENDIAN__
> > =C2=A0#define __BYTE_ORDER __BIG_ENDIAN
> > +#define __LITTLE_ENDIAN 0
> > =C2=A0#else
> > =C2=A0#define __BYTE_ORDER __LITTLE_ENDIAN
> > +#define __BIG_ENDIAN 0
> > =C2=A0#endif
>=20
> I thought the expected/correct value for __BYTE_ORDER__ was either 1234 o=
r 4321.
> (apart from pdp11's 2143).

Should we just do

#define __BYTE_ORDER __BYTE_ORDER__
#define __LITTLE_ENDIAN __ORDER_LITTLE_ENDIAN__
#define __BIG_ENDIAN __ORDER_BIG_ENDIAN__

then?  __BYTE_ORDER__ etc. are available since gcc 4.6 and now we
requires gcc >=3D 8 to build the kernel.


--=20
Xi Ruoyao <xry111@xry111.site>

