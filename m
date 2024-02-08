Return-Path: <stable+bounces-19328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F3884EA24
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 22:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28231F307EB
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 21:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4B4C3BF;
	Thu,  8 Feb 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="rRb+LW6X";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="S9ZROpvd";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="xE1PUwcQ"
X-Original-To: stable@vger.kernel.org
Received: from e2i605.smtp2go.com (e2i605.smtp2go.com [103.2.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFBC4C3A9
	for <stable@vger.kernel.org>; Thu,  8 Feb 2024 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707426760; cv=none; b=PZIrYF3cEty1ET9mZ915sPE1N74MgsYx0QHvIQla/wtT/Took9/6ds1L/QpNUnDLTcG8m6AFkipxOe3B5GVy+FqaKtj6nEblaqgWwaAhyR09wZ+fMDchUz0kzwWHzlAQvPAgIDDAR9rI1cgNhsEo1rzveWIvbteXCArTlj+dQ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707426760; c=relaxed/simple;
	bh=gzAJXh0AuWP2Tj6EfnlN6wMOTN9/0yYV+XNsGIOcsSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfqXXZ9wj7hdS+KM9u9vSq3isy5v6ufNKSluV/yOvJ6rUcf9chkE07F/ewLocP5pmejQBBRw9iSQcf5JAKN6soj099VG3YbVTDgnaJdZ001r7gLPjIqOcYtYhtMMalY+8BmTEVDMEgYII75xScKMd9Bm/9R3wMIw6EQHp259mLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=rRb+LW6X; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=S9ZROpvd; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=xE1PUwcQ; arc=none smtp.client-ip=103.2.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1707427654; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe; bh=AkSd+9ljsMOd7NA01/E1CL+KQikkc5RfKtKGGSWOSqg=; b=rRb+LW6X
	CuFNl9yUlc3AHA6FZjNkXWuwMjJhPibD1b28CJG7D7CiEFoF+d0fxNw7Od/K5kEdx5VGYJFycfNE+
	ITvXeMHchzds1hZCDD+PzV3StLXxOC4GtGltdIppupji7LHiPTo3YT8HOIzuyAZSK6gTZPEOgTpwJ
	13oQbKNcPmUatIAaikFNFXnB62sV++gr3MxkrWzZ8LNY79VrARYwsIcbyaD2CU7HQl1IbKy8rYQGm
	c0D5sLUV82MWHlg3TftKXYuYl3rFZxYI/2R2FwWfid4fiuWu4yO/BIBFMKlqOzgEFjhnxaUs4kZCj
	CaQY5ztmIDsH+K3vfdFkncZGQg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1707426754; h=from : subject :
 to : message-id : date;
 bh=AkSd+9ljsMOd7NA01/E1CL+KQikkc5RfKtKGGSWOSqg=;
 b=S9ZROpvdQGXC9zR0R00IZa/5iPZtqFXrKcyQ94vM/SwoUiPdM8YRv9Sp5f2i9aqlxgaPS
 au7rdOip5Ij/fQDg7FfUk7pYyH/RZ3zsNSlDflDrHLRJ30m9xGIt6MvRQjBeHOJJAlZ/AtI
 d8CBVQnUVWlRrl+7UUaxBjPiLSOkzNc8ebUjyTs01zkolmfxbkqaDnud+SW6/bhS9Yiqcqt
 F3F1K1QqGCDyNEJtowzL42wwzrJaNi1ipx14iirkYUAXJoF8n7viLWMTtqSJp9jsR/upCoL
 oy9Ygd91vdPi9Rz73gb5lBzyFmyVsbM6pl7n9zlt188IwIcJElmeIC1N8yvw==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1rYBfe-qt4Jyo-EJ; Thu, 08 Feb 2024 21:10:59 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1rYBfd-4XfCcG-2o; Thu, 08 Feb 2024 21:10:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1707426655; bh=gzAJXh0AuWP2Tj6EfnlN6wMOTN9/0yYV+XNsGIOcsSc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xE1PUwcQLvNxCpxh2E6tXBVZCGwTH6W4SofQhNfO6QGaZrwyPYKNp0LHyiECrVfjS
 z3S63tY/aF5luf6wbL+jrpE8KUX1t/P/3lnOAc2c16HyIPn9i0MxhtoaTtdkb+045B
 YfNihq/0HaPCRfZ8EG+CKZTSNlMDr38HVeO1S7Ec=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id EDEF03E8DB; Thu,  8 Feb 2024 22:10:54 +0100 (CET)
Date: Thu, 8 Feb 2024 22:10:54 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Nathan Chancellor <nathan@kernel.org>
Cc: masahiroy@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, keescook@chromium.org, maskray@google.com,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] kbuild: Fix changing ELF file type for output of gen_btf
 for big endian
Message-ID: <ZcVDXhFQB1tzka3C@fjasle.eu>
References: <20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-v1-1-cb3112491edc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zTk1qaPnG2VuQe0/"
Content-Disposition: inline
In-Reply-To: <20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-v1-1-cb3112491edc@kernel.org>
X-Smtpcorp-Track: 1rYUfd4bfCcG2o.xZNt1KhvmUfuu
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sYq_OVzP5R
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>


--zTk1qaPnG2VuQe0/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 01:21:06PM -0700 Nathan Chancellor wrote:
> Commit 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> changed the ELF type of .btf.vmlinux.bin.o from ET_EXEC to ET_REL via
> dd, which works fine for little endian platforms:
>=20
>    00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00  |.ELF.....=
=2E......|
>   -00000010  03 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |.........=
=2E......|
>   +00000010  01 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |.........=
=2E......|
>=20
> However, for big endian platforms, it changes the wrong byte, resulting
> in an invalid ELF file type, which ld.lld rejects:
>=20
>    00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF.....=
=2E......|
>   -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.........=
=2E......|
>   +00000010  01 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.........=
=2E......|
>=20
>   Type:                              <unknown>: 103
>=20
>   ld.lld: error: .btf.vmlinux.bin.o: unknown file type
>=20
> Fix this by using a different seek value for dd when targeting big
> endian, so that the correct byte gets changed and everything works
> correctly for all linkers.
>=20
>    00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF.....=
=2E......|
>   -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.........=
=2E......|
>   +00000010  00 01 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |.........=
=2E......|
>=20
>   Type:                              REL (Relocatable file)
>=20
> Cc: stable@vger.kernel.org
> Fixes: 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> Link: https://github.com/llvm/llvm-project/pull/75643
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  scripts/link-vmlinux.sh | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index a432b171be82..8a9f48b3cb32 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -135,8 +135,15 @@ gen_btf()
>  	${OBJCOPY} --only-section=3D.BTF --set-section-flags .BTF=3Dalloc,reado=
nly \
>  		--strip-all ${1} ${2} 2>/dev/null
>  	# Change e_type to ET_REL so that it can be used to link final vmlinux.
> -	# Unlike GNU ld, lld does not allow an ET_EXEC input.
> -	printf '\1' | dd of=3D${2} conv=3Dnotrunc bs=3D1 seek=3D16 status=3Dnone
> +	# Unlike GNU ld, lld does not allow an ET_EXEC input. Make sure the cor=
rect
> +	# byte gets changed with big endian platforms, otherwise e_type may be =
an
> +	# invalid value.
> +	if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> +		seek=3D17
> +	else
> +		seek=3D16
> +	fi
> +	printf '\1' | dd of=3D${2} conv=3Dnotrunc bs=3D1 seek=3D${seek} status=
=3Dnone
>  }
> =20
>  # Create ${2} .S file with all symbols from the ${1} object file
>=20
> ---
> base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
> change-id: 20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-dbc55a1e1296
>=20
> Best regards,
> --=20
> Nathan Chancellor <nathan@kernel.org>
>=20

Thanks for the verbose examples!
Looks good to me.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--zTk1qaPnG2VuQe0/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmXFQ1AACgkQB1IKcBYm
EmnYTw//fDS4aaPzwOImLhpKzX3i1BC6Qx2THMdosxC72mSxiGL2TPRWRq/eGRln
ywqA6ZiSICotXS+vXCQHVgycTKquxjTybXb0OxNaV1Tx3RrE3NfgKZ1+KtrMePoy
bjbU5SYJ6kYKUOR3laTcc0YcSbAH0GgAL6S43ZyWjtuJKha6puzXvQdz5H6SvfiT
eKsXy/nQvy+7vuWxWhT+sgx9KGLMPisSqVtrTiC5XjoKB6KH8Emn7xOx6SQEL/12
NfV5ESzVOeXrQjgkUaYPm8dHlseZynIr5F4FPsAB6jGJUg7o/Y2Ye7S5e/dqxLWL
haddv3lmmVeuKWOcLl2LWQEK2EWOfqNMDAYrjWSruuQqNIuVtuUwmBkdVvq+H1Lt
oPXt4A/qScMAjWjBQAp382jx952rzBnSlQ5t7tXsuff0XE+JWslZZHzn4l11G4C6
p0DCERyQkCEP8aOf1NKdn9NILmlT76ecy4koe44/V/eVWtybLeQWVMN9O/nwNFBK
fJkJ+gPRn+PajfYeorZk3sBnPSKQMHGw1x2+1C0rFKSdxVgVuRsyuBgQse/wVWWW
aCRm/K27PwfJAhW3WplFUlzjMm7ejN8DHhDTUrlLN9yswke46jY3NhDLQJQMeMUx
XthcV13qCT75e9GfpZuO1hgO26my+rHV/kkt0nuGNl0Fx8wHmv0=
=OENS
-----END PGP SIGNATURE-----

--zTk1qaPnG2VuQe0/--

