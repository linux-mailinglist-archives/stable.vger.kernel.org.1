Return-Path: <stable+bounces-249097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIGDI5bICWropQQAu9opvQ
	(envelope-from <stable+bounces-249097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:54:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A83561555
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D5CD30039B2
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B003A271450;
	Sun, 17 May 2026 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZllJxf05"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3788526E165
	for <stable@vger.kernel.org>; Sun, 17 May 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779026067; cv=none; b=mhR+xMSBIdw27a5ClmXcGY2/OlsNaj3RYKZH1C8kQBX7Mid8XBH+venWjabaMjltiWKnQruwPgbXlS5ZdeFlDY8tP/YmV5cdE1gXCG3DFpAXEK9HzfX7uo+sn+hJyktkL8v5ltJ4/CdsKGczaPOLgW5bkHRbPT/kA+H/CFrjDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779026067; c=relaxed/simple;
	bh=YbQLRrWkp8woT6noIkN8JFge1QfEm+EnvuLpmYJvGB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slerH0Sa8TzxQ6+3ogfBiK9uGDl5VuE3+cVTxMMVph2TNNRP2n6+gcLTwwj68HiRd6VJMeBhAMI/CFBlolP3u4uyiVvVxB2nS+BC7uqbWOk0s5cQ7pcSC58XSQ69SjbNDMytsfZmooxRcBgvDKNKThv7mEorhL8hEZp8+mNJsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZllJxf05; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so1480719f8f.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779026064; x=1779630864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCmNoyXACxi7HeEYBB30N/6mk1BYNcK6sHffQdI0OFI=;
        b=ZllJxf05exQ35V9kJNbCa6kXgPnbPXGRFeP7tQASncY3fo4wmU5hXUO2Z2zNGNga4h
         wAhGkbWMHCMIwdurQwnWYfBMsCoWfPFCHbQUrx6/jEuTeyRy5+Au1qv5Sokl3miBUkIT
         jx0kHjWtKGEHBREHjPYcLjT7j1Xs/SOYh3edWxpYkBUAwOqCmPNR+FhYsrjo5AxfEzHy
         zry/tU8fa5kBF4s2ZboFpxldjEN8aGkO+Sq2YovSfIqg+WXiHFP7JV0FS6A0BAAmRsTM
         fDMA5idiBMU2mn4EZbybYwwy8HtLzkzBjVcEaG2stSSWobhs9DRvMYJlqEy4W4rfVS6B
         rKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779026064; x=1779630864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uCmNoyXACxi7HeEYBB30N/6mk1BYNcK6sHffQdI0OFI=;
        b=PFPKR0EScNbV1Nkkzn88wddx8g0d9VpPYj/VqOez8fXDzyyWkRyVi7+1hU4JLwYO0f
         e+wt3303zAVMB4NBSJSOQlJtVH3ewy9ZdArp553TyKLx7bJX8qpNpZSm9rJTtQ8P7YLU
         6txIkmICAEuBWPcYA2qM4sD7+Ki+3HheUc4BQIw88sUI7lQYBGMtxkcBmMDVQxqooNxB
         XsjdG0r0FrEvVv/RmClZic7TdxQmuXlnU2SyT/dgj3ZDG4FEOynn4g8erAtt/LyX4T2C
         z2QX2DQZ4BmGJE87iLWVGtIbL1H5uJs4QBEA5ZLLsTwT4inmblvRPR+E7XGfzuXz2zko
         Bq5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8poqsIzffKEA41DhqHYIZrJa1wSZ8PRsqUFdzBk0wmOHuRDGv0uqWiuplwnZasYJCy/E3KNIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/G00+SfTIey7x+f04MuV+ZqvVaKUQk5s5BTX+Ylac5C6oubXi
	H2PisQ5JxnRfUmVEJS90nKXC4DS4QSoUpITqC2dqZojg2Px/+nO/3yPf
X-Gm-Gg: Acq92OEm09mzfUvG/RaJVn4VTAoFTT2GmRIhtRI+/aXi3eqV2o2ilRpi5S9EDWaEM27
	UOddT5yqnprVnqy3IUHINIUjCzkc3mfs4ADTPQc7WXnAVWPpHz9LgDB6+RQmY1elrHIC7kwWoLJ
	iwpeQP9yKqk3jp5iIi51Q5AgZbIh1E1lyW48Ufo4ADtSisOiKdSDYl6Oy7JLsSfDcwGlGuMTFcp
	KUaT1Ut+r0/Tya5bvEaJGOiLft8isJwWKhPPqJTOyB/C5Xumwi8FeGJDZc2ycw41vGoC+wCsvaQ
	pS7gNJcd6FEzzTfmmpWFsSuDEt7Mzgb9mRfGZvkYsz7rolfTtDcAxa2WZJSir6+aVZ4WejioppJ
	6grsDlg8NXE3Polcki1r72bNl/zCih2u+xHRHggfOFhmtT1Sg/QhKjxq0Aa6DR1t5/jkH47YlZ7
	B2njkZSP9suaLVMCGdozfewZT+UnOdoFWDuBBAmWUAMQOsSXNKwNWWiPkiVJH+V06wm6GwG5lIz
	n5G8fXmDlVg2w==
X-Received: by 2002:a05:600c:5010:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48fe5388407mr154115835e9.12.1779026064317;
        Sun, 17 May 2026 06:54:24 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4dac000sm196019465e9.0.2026.05.17.06.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:54:24 -0700 (PDT)
Date: Sun, 17 May 2026 14:54:21 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mingcong Bai <jeffbai@aosc.io>
Cc: linux-kernel@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, Kexy
 Biscuit <kexybiscuit@aosc.io>, stable@vger.kernel.org, kernel test robot
 <lkp@intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: define __LITTLE_ENDIAN and __BIG_ENDIAN for
 math-emu
Message-ID: <20260517145421.2d1ac77c@pumpkin>
In-Reply-To: <20260517041423.71243-1-jeffbai@aosc.io>
References: <20260517041423.71243-1-jeffbai@aosc.io>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 35A83561555
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249097-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,xry111.site,aosc.io,intel.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

On Sun, 17 May 2026 12:14:21 +0800
Mingcong Bai <jeffbai@aosc.io> wrote:

> Similar to commit b929926f01f2 ("sh: define __BIG_ENDIAN for math-emu"),
> define __LITTLE_ENDIAN and __BIG_ENDIAN as 0 to mitigate build-time
> warnings:
>=20
>   ./include/math-emu/double.h:59:21: error: =E2=80=98__BIG_ENDIAN=E2=80=
=99 is not defined, evaluates to =E2=80=980=E2=80=99 [-Werror=3Dundef]
>      59 | #if __BYTE_ORDER =3D=3D __BIG_ENDIAN
>         |
>=20
> Cc: stable@vger.kernel.org
> Fixes: 13da9e200fe4 ("Revert "endian: #define __BYTE_ORDER"")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507301656.7FEX6J5W-lkp@i=
ntel.com/
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> ---
>  arch/powerpc/include/asm/sfp-machine.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/includ=
e/asm/sfp-machine.h
> index 8b957aabb826d..db8525605c026 100644
> --- a/arch/powerpc/include/asm/sfp-machine.h
> +++ b/arch/powerpc/include/asm/sfp-machine.h
> @@ -319,10 +319,12 @@
>  #define abort()								\
>  	return 0
> =20
> -#ifdef __BIG_ENDIAN
> +#ifdef __BIG_ENDIAN__
>  #define __BYTE_ORDER __BIG_ENDIAN
> +#define __LITTLE_ENDIAN 0
>  #else
>  #define __BYTE_ORDER __LITTLE_ENDIAN
> +#define __BIG_ENDIAN 0
>  #endif

I thought the expected/correct value for __BYTE_ORDER__ was either 1234 or =
4321.
(apart from pdp11's 2143).

-- David

> =20
>  /* Exception flags. */


