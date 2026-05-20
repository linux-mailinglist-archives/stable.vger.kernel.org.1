Return-Path: <stable+bounces-253170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOubGnEFDmp25gUAu9opvQ
	(envelope-from <stable+bounces-253170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:03:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E992D597A34
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABECE3292B85
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F15407CC8;
	Wed, 20 May 2026 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roIEY48L"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9721407CC1
	for <stable@vger.kernel.org>; Wed, 20 May 2026 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302588; cv=none; b=ZoVfoI01rNMSDrhZJN0uXDvmZvCbSVTPjHlwpsqLHj9fTTit9dOvWgoC0tIRYZHKVt2qs2Us+8I+N9rHCoFCYmt751WfV5rysUOKX4q0t+N3QtazmYVHFxzLzYryWKz7JuwMkSlJ2AV9rKtsn/QD0dJ3N8H5mu3e6+oFVxcN/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302588; c=relaxed/simple;
	bh=DIKI5Nm6s9PPo3166FMrcG7uxPadujqDPWzGeZjWJ2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d53eSTEIbK9KvCy5qz9iUCUDUoLUd1eJ6fekM/LNlH6IKgerYWci4dcZ0oD6zYTMRB+zpRXsb/dCrW3CLgwJHDcHnM/e9ThK9w9cLCgGTAPabr+W7I21Fvd2SYrluJkDqS8o06PZtq8FrTIDhnc9SVaH+MAjGLPQIT5PFinHY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=roIEY48L; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so42944635e9.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779302585; x=1779907385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whgB6y4RP4kwglDuYRFO52mBrV4vFUKUBeiqdJotODU=;
        b=roIEY48LbGbHDFdP098yaGDPE1L3mCPkZYE8GBoQL+c0pCJyKCFt3OuC7GuMH8MXWB
         o/kvyre5yDRENbVno/ZvO3IxHfdNG9GQ0eyNLejWGsvcg9y0f97VALlQpwwRwYUrC8k1
         5ucaqfY5385ArGWdgrbs4eyOKiyh5a0B+bA16tVcg9A/nYxCYvn3HTPnv08C9EWsznGK
         pK9anZztw96OesxXUc/5bBD/9UrQHwlKvlN0HGKJ8OlnVoEUoprjRRAUYkoX48ixZuxY
         N5KYl8kkO1Vv3yo8SWSCKMUreDHM9/TTJbL0NKR+R94Tq/Sr/Dde4Z0ACyjT7kXBS0/l
         ZCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779302585; x=1779907385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=whgB6y4RP4kwglDuYRFO52mBrV4vFUKUBeiqdJotODU=;
        b=EKvX6stxol6rVNYL75qrZ/xqPsjKC9GqMaZ6S34x9fwSLg8owXRo53Up/3GamXfUw+
         8rzVHbnEcXdpUqkbicV6U5wMxJD4qpukyHbiYJINA9zpMmQhXQnhRg+Z/HediGsO04fw
         rr43QRIiDn5olTUQ9aXNo2PBLBlbF9S370DCUObgYwYzZ8jRkxt7F9qm2GFXaRPhBNli
         7DN+BLf2WfbsDIORnCKsqoppTbqaGG6/zAUMXaGgVkeBqQlVKElOop0YyJZ1MPn6f5yu
         YUUD+j+PBSJHSR9Aelws/0oKboxjsZpRRwWEIFfgZ3pX5mZzx4Bxa2qcWm7oaxCyhZxy
         3HTg==
X-Forwarded-Encrypted: i=1; AFNElJ+EpbfEYQBB2DqqIxuA8956zgeaThlr+Hs+JuJf4r9g9zCb1WNHi5fHgwfKHpHRlI2usmVVIxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM6ir3Gi8sWWXk3pkoUEZUCIBDGphQb0Qy1z7UIyErusGUw3EL
	YquE5XaY7oHhCZ8t0McyRDNjim8+O4u3gDeELspukbEjeSfcpfn8q/NZ
X-Gm-Gg: Acq92OH5IO8tPi+aevxNrlbc0N+FgpunTU20uqHwBqKDNOiBhDMWiYYTAXf71ulRqKj
	QSmWDlnv5pQvXIyVNYIbIKWq8fFkIJLfv/OFg1PhjxpbGL88vjOiicqN+KnHZw09PqpLmzep2rO
	UgYyvLzj4TLIT8T9FM6/Z2a/l3kieZpW2d5T9nIjKtqgC6zuBqfy/5j9XX2bOFWmurvzh6bitAO
	43SfACb0g6jySNziqLBFK4kz0bOnGsaBiy+hmWYxl7m5EJMkXcbrI9WGmDIwrGTsPv+eZz+1p+/
	7TrOFlp7Jb6DzYuXTVS4qMC/6p1SXI5ykZSZBFjgt0AgcXOaccMlC5JM7PdFj/PUgF+LsdeK0tf
	wgMzM4fRFGYRyIUQ5TRehKQR91hnndZ8oXGyJJ8mO0w99NX/9qQy5+XmWpoOJ52XR/GzVDuh34G
	KJdNTTBgQzxyCBKbvPwofvMBjNzlWPAK6ZrVcFru9YRwpIIg7pmJVz78AfFYmuxKBy
X-Received: by 2002:a05:600c:4e46:b0:48f:e230:8cab with SMTP id 5b1f17b1804b1-48fe6626cfbmr386484735e9.31.1779302584904;
        Wed, 20 May 2026 11:43:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d3f99csm16504725e9.6.2026.05.20.11.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:43:04 -0700 (PDT)
Date: Wed, 20 May 2026 19:43:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Mingcong Bai <jeffbai@aosc.io>, linux-kernel@vger.kernel.org, Xi Ruoyao
 <xry111@xry111.site>, Kexy Biscuit <kexybiscuit@aosc.io>,
 stable@vger.kernel.org, kernel test robot <lkp@intel.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: define __LITTLE_ENDIAN and __BIG_ENDIAN for
 math-emu
Message-ID: <20260520194301.06d96a5f@pumpkin>
In-Reply-To: <eb93d563-7042-458e-a5c0-b5389343d41b@kernel.org>
References: <20260517041423.71243-1-jeffbai@aosc.io>
	<20260517145421.2d1ac77c@pumpkin>
	<eb93d563-7042-458e-a5c0-b5389343d41b@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253170-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[aosc.io,vger.kernel.org,xry111.site,intel.com,linux.ibm.com,ellerman.id.au,gmail.com,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,aosc.io:email,outlook.com:url,gnu.org:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E992D597A34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 15:14:40 +0200
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Le 17/05/2026 =C3=A0 15:54, David Laight a =C3=A9crit=C2=A0:
> > On Sun, 17 May 2026 12:14:21 +0800
> > Mingcong Bai <jeffbai@aosc.io> wrote:
> >  =20
> >> Similar to commit b929926f01f2 ("sh: define __BIG_ENDIAN for math-emu"=
),
> >> define __LITTLE_ENDIAN and __BIG_ENDIAN as 0 to mitigate build-time
> >> warnings:
> >>
> >>    ./include/math-emu/double.h:59:21: error: =E2=80=98__BIG_ENDIAN=E2=
=80=99 is not defined, evaluates to =E2=80=980=E2=80=99 [-Werror=3Dundef]
> >>       59 | #if __BYTE_ORDER =3D=3D __BIG_ENDIAN
> >>          |
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 13da9e200fe4 ("Revert "endian: #define __BYTE_ORDER"")
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Closes: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Flore.kernel.org%2Foe-kbuild-all%2F202507301656.7FEX6J5W-lkp%40intel.c=
om%2F&data=3D05%7C02%7Cchristophe.leroy%40csgroup.eu%7C08977974fb1c495e9bd5=
08deb41bd275%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C63914622876869373=
0%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiO=
iJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D4qGulR%2BL=
7i7inksEbEH9jNGZS8HG80uvm3I9IyYzZww%3D&reserved=3D0
> >> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> >> ---
> >>   arch/powerpc/include/asm/sfp-machine.h | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/inc=
lude/asm/sfp-machine.h
> >> index 8b957aabb826d..db8525605c026 100644
> >> --- a/arch/powerpc/include/asm/sfp-machine.h
> >> +++ b/arch/powerpc/include/asm/sfp-machine.h
> >> @@ -319,10 +319,12 @@
> >>   #define abort()								\
> >>   	return 0
> >>  =20
> >> -#ifdef __BIG_ENDIAN
> >> +#ifdef __BIG_ENDIAN__
> >>   #define __BYTE_ORDER __BIG_ENDIAN
> >> +#define __LITTLE_ENDIAN 0
> >>   #else
> >>   #define __BYTE_ORDER __LITTLE_ENDIAN
> >> +#define __BIG_ENDIAN 0
> >>   #endif =20
> >=20
> > I thought the expected/correct value for __BYTE_ORDER__ was either 1234=
 or 4321.
> > (apart from pdp11's 2143). =20
>=20
> That's the case, in include/linux/kconfig.h we have:
>=20
> #ifdef CONFIG_CPU_BIG_ENDIAN
> #define __BIG_ENDIAN 4321
> #else
> #define __LITTLE_ENDIAN 1234
> #endif
>=20
> But as far as I understand the problem is that math-emu expects=20
> __BIG_ENDIAN to be defined at all time as it has tests like:
>=20
> #if __BYTE_ORDER =3D=3D __BIG_ENDIAN

The gcc docs have (https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Mac=
ros.html):
    =20
__BYTE_ORDER__
__ORDER_LITTLE_ENDIAN__
__ORDER_BIG_ENDIAN__
__ORDER_PDP_ENDIAN__

    __BYTE_ORDER__ is defined to one of the values __ORDER_LITTLE_ENDIAN__,=
 __ORDER_BIG_ENDIAN__, or __ORDER_PDP_ENDIAN__ to reflect the layout of mul=
ti-byte and multi-word quantities in memory. If __BYTE_ORDER__ is equal to =
__ORDER_LITTLE_ENDIAN__ or __ORDER_BIG_ENDIAN__, then multi-byte and multi-=
word quantities are laid out identically: the byte (word) at the lowest add=
ress is the least significant or most significant byte (word) of the quanti=
ty, respectively. If __BYTE_ORDER__ is equal to __ORDER_PDP_ENDIAN__, then =
bytes in 16-bit words are laid out in a little-endian fashion, whereas the =
16-bit subwords of a 32-bit quantity are laid out in big-endian fashion.

    You should use these macros for testing like this:

    /* Test for a little-endian machine */
    #if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__

The doc doesn't mention the value, but __ORDER_BIG_ENDIAN__ is 4321 (decima=
l).

So the math-emu code is neither following gcc's rules or the kernel ones.

Your change will break anything that currently does:
#ifdef __BIG_ENDIAN

Any change would have to be limited to code that is implementing math-emu.

-- David

>=20
> Christophe
>=20


