Return-Path: <stable+bounces-96000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E1F9E0135
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5960E280D9B
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536B91FE46C;
	Mon,  2 Dec 2024 12:02:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0458E17E;
	Mon,  2 Dec 2024 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140921; cv=none; b=Q6Lh9F8k1rdDsHOLIwFSu1YKNkJ47hijOrJ5diwxTZZaGBgtwEIs4HHDkKaJTBIDodqLn5vAFRSUyeW+ioFrSrPs4yunFjCCQlBPt2+/3IkepjIvoCeRF1yUfDSjs5aF0jt55a/Ypzl68ciDk//QP6A2eyeDe1NmOsD19KW6fuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140921; c=relaxed/simple;
	bh=AowdK/BgeMZk/jD7JIcpDJNoiGlMdhyY5ufT8ST5t6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk8qRbbAeiWHQik2mQajZs0piTNM3cGbPozrE1UZ7jrCu2y5r2tsVGY1j1fnJdNBP41uelyh8KsgIK/Z21xiJiTgMrafhGFLaU9zuZ+4+FPoQeyRoCDcEzlEUv9KMJWOJp4obwsenBu8A/IV/yCA+QyZA+VCbsYs4slG4iV/CTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 28BAE1C00C4; Mon,  2 Dec 2024 13:01:57 +0100 (CET)
Date: Mon, 2 Dec 2024 13:01:56 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Yuli Wang <wangyuli@uniontech.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>, chenhuacai@kernel.org,
	arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
	max.kellermann@ionos.com, loongarch@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.1 2/6] LoongArch: Define a default value for
 VM_DATA_DEFAULT_FLAGS
Message-ID: <Z02htM68lfbuxkr/@duo.ucw.cz>
References: <20241120140722.1769147-1-sashal@kernel.org>
 <20241120140722.1769147-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MCipG85vClzQOAYn"
Content-Disposition: inline
In-Reply-To: <20241120140722.1769147-2-sashal@kernel.org>


--MCipG85vClzQOAYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2024-11-20 09:07:08, Sasha Levin wrote:
> From: Yuli Wang <wangyuli@uniontech.com>
>=20
> [ Upstream commit c859900a841b0a6cd9a73d16426465e44cdde29c ]
>=20
> This is a trivial cleanup, commit c62da0c35d58518d ("mm/vma: define a
> default value for VM_DATA_DEFAULT_FLAGS") has unified default values of
> VM_DATA_DEFAULT_FLAGS across different platforms.
>=20
> Apply the same consistency to LoongArch.

Cleanup, do we need it in -stable?

BR,
								Pavel

> Suggested-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/loongarch/include/asm/page.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/a=
sm/page.h
> index bbac81dd73788..9919253804e61 100644
> --- a/arch/loongarch/include/asm/page.h
> +++ b/arch/loongarch/include/asm/page.h
> @@ -102,10 +102,7 @@ static inline int pfn_valid(unsigned long pfn)
>  extern int __virt_addr_valid(volatile void *kaddr);
>  #define virt_addr_valid(kaddr)	__virt_addr_valid((volatile void *)(kaddr=
))
> =20
> -#define VM_DATA_DEFAULT_FLAGS \
> -	(VM_READ | VM_WRITE | \
> -	 ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0) | \
> -	 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
> +#define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
> =20
>  #include <asm-generic/memory_model.h>
>  #include <asm-generic/getorder.h>

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MCipG85vClzQOAYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ02htAAKCRAw5/Bqldv6
8nQgAJwMo2NrgHsOPY+gjr9k0eq3cn7M1wCgpRzDH2FuLFy2OhEVYdo1JPjM638=
=G1OH
-----END PGP SIGNATURE-----

--MCipG85vClzQOAYn--

