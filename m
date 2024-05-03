Return-Path: <stable+bounces-43018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A58BAE54
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 16:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501F81F23E44
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2369D154430;
	Fri,  3 May 2024 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KA9FeJbd"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A93115357A
	for <stable@vger.kernel.org>; Fri,  3 May 2024 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744866; cv=none; b=PZOkRvecmnuh3ZdLoEElav3UVNQ/XEPB1GL00LtzFRGACJmEDalGyRbsLusGy8q/PBNcwJKK9E45B6k/rsPXN4YmqQwqP97jsVL/igiXzYih+8VT/ZTjbEtUXynaC5BS+cueRF3BgBV/yzcPqNMFWYZpwMqoaYdPfHsiQs1UBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744866; c=relaxed/simple;
	bh=cEds2RNHF+78DsX31Rp6U7I80yesw39snmJ/2R9Kkvg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=TwMbTEYUzq0iMu2mB6KfgOiUPW/eaJk2hnZBJgfONAZj9kQY2/mJn52QOFpvagn82rN82SYAFDAGQK8gJ0B2ZNn+s2FHPcUXkpKoUGZzRNIo0WJY0dAujBexauPhPv+ksD22fK5pEtFd5YZkdUSOMWoSTeZZQNgUYuzHvJ4t4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KA9FeJbd; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240503140100euoutp014754e7c4dbc602fb5df861c6e7166a39~L-114vn0y0337103371euoutp01P;
	Fri,  3 May 2024 14:01:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240503140100euoutp014754e7c4dbc602fb5df861c6e7166a39~L-114vn0y0337103371euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714744860;
	bh=MUw3hvCtLQkYtH2pE/YL4VgyK4mNgvrkIb+rbR6GF1E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KA9FeJbdDsx4BtiL2qh47vEZPZ/TrSu0AGk0HWLWqdbKO/siivy7LV88VLzzN5vNT
	 nn+WnnhJBrq3CyHHXSZe3E6BTiqo11pMNwcoAghMtLcabHbIk0ysx4TFPO9sOTlKYn
	 DgJhsLwe/LRFrHNEyfYUP+U9V9jbH3Lasbem0gCo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240503140059eucas1p100b2e1b2cb8ad1728ae5c8a4577ccd5e~L-11v-M_S1656716567eucas1p1R;
	Fri,  3 May 2024 14:00:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 7F.15.09620.B1EE4366; Fri,  3
	May 2024 15:00:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240503140059eucas1p1d16ab98f20873bda3a71a448e40a9d55~L-11UXMRh2087720877eucas1p1s;
	Fri,  3 May 2024 14:00:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240503140059eusmtrp27e9f5ec727f9f0913a91d5a0e79ac4f1~L-11TxJf-1501715017eusmtrp2I;
	Fri,  3 May 2024 14:00:59 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-c4-6634ee1b67b1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id BF.93.08810.B1EE4366; Fri,  3
	May 2024 15:00:59 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240503140059eusmtip181b64bc2e61535bbab842d3024cb1774~L-11A5Zq71504015040eusmtip1y;
	Fri,  3 May 2024 14:00:59 +0000 (GMT)
Received: from localhost (106.210.248.112) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 3 May 2024 15:00:58 +0100
Date: Fri, 3 May 2024 16:00:54 +0200
From: Joel Granados <j.granados@samsung.com>
To: Eric Biggers <ebiggers@kernel.org>
CC: <fsverity@lists.linux.dev>, Luis Chamberlain <mcgrof@kernel.org>,
	<stable@vger.kernel.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] fsverity: use register_sysctl_init() to avoid kmemleak
 warning
Message-ID: <20240503140054.qlyfjvdbllvhzs2t@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="4bc3sbrjbqeupkd7"
Content-Disposition: inline
In-Reply-To: <20240501025331.594183-1-ebiggers@kernel.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djPc7rS70zSDE52Glis3fOH2aLz0X82
	ixsTnjJaLNj4iNHi+rlpbA6sHptWdbJ5vNg8k9Hj/b6rbB6fN8kFsERx2aSk5mSWpRbp2yVw
	ZZyfp1fwSaLiY0cLawPjatEuRk4OCQETiTUnFrJ1MXJxCAmsYJSYO/EJlPOFUWL6ov+MEM5n
	RolFh1+wwrRc+XSVGSKxnFGi9WwLQtWeSe+gMlsYJQ53zWAHaWERUJGYvP8gI4jNJqAjcf7N
	HaAiDg4RATWJY0v9QeqZBRoYJb5O3QtWIywQKrFvfyfYOl4BB4lDH2+zQdiCEidnPmEBsZkF
	KiSWTz/ECjKHWUBaYvk/DpAwp4CVxKQHvewQlypLHNk+F8qulTi15RYTyC4JgWZOiasv77FA
	JFwk1hxtYoKwhSVeHd8C1SAj8X/nfKiGyYwS+/99YIdwVjNKLGv8CtVhLdFy5QlUh6PE7b/f
	wT6TEOCTuPFWEOJQPolJ26ZDhXklOtqEIKrVJFbfe8MygVF5FpLXZiF5bRbCaxBhHYkFuz+x
	YQhrSyxb+JoZwraVWLfuPcsCRvZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgenq9L/j
	X3cwrnj1Ue8QIxMH4yFGFaDmRxtWX2CUYsnLz0tVEuHVnmycJsSbklhZlVqUH19UmpNafIhR
	moNFSZxXNUU+VUggPbEkNTs1tSC1CCbLxMEp1cC0OLN5dkv2OtM/QVyqZR+O7qlYY+bDPq9R
	aEmPzQzPjV/cr3yTN7mf0Sx/7vylywEfvjhq6+lX7qz6y3PLaMc1i7+nTtdn3C8X+9D1cM6l
	vq/m/ZUJhu/mSdk98DlTWqX7TjEtyyzdJbzl7O1/b+b/eGDo9nVHsW3Hu5zKK2bB6W+3Rbq3
	rjfLmyU+64/dxoyoKZFLOs2Opr903ynaUXSSw/QLZ/zhbenXd57TmdB+TDK91r0x1r3uUY3I
	lHt79x2PWjLzVtLBqlw3xcKjx05PKBDbqNE6Manba1tvZukuX68N0z/39n6a08IS3Ca5IfLd
	/4wz7+fItjrPNK/bN8H7UWXVuS91nTkOLNPzNXcqsRRnJBpqMRcVJwIAEYTTuNIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xu7rS70zSDDbuErFYu+cPs0Xno/9s
	FjcmPGW0WLDxEaPF9XPT2BxYPTat6mTzeLF5JqPH+31X2Tw+b5ILYInSsynKLy1JVcjILy6x
	VYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7iw/ClzwQeJimftR5gbGFeK
	djFyckgImEhc+XSVuYuRi0NIYCmjxLN3rWwQCRmJjV+uskLYwhJ/rnWxQRR9ZJS42DmREcLZ
	wihx58kWRpAqFgEVicn7D4LZbAI6Euff3AEay8EhIqAmcWypP0g9s0ADo8TXqXvBaoQFQiX2
	7e8E28Ar4CBx6ONtqA1XGCV2/epjhEgISpyc+YQFxGYWKJPYv7uJHWQos4C0xPJ/HCBhTgEr
	iUkPetkhLlWWOLJ9LpRdK/H57zPGCYzCs5BMmoVk0iyESRBhLYkb/14yYQhrSyxb+JoZwraV
	WLfuPcsCRvZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgVG77djPzTsY5736qHeIkYmD8RCj
	ClDnow2rLzBKseTl56UqifBqTzZOE+JNSaysSi3Kjy8qzUktPsRoCgzFicxSosn5wHSSVxJv
	aGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAZJIz4fZOjxNLHa1q503v
	ObNX9ImVkfLKFz+vFR/WOqxd/9qUy7x5ZnPJs8bsVc5xqww6n/97FLNXIG/a+y0vHs3MXxh1
	R9uAt+e+ZfDz71dXPd12osSArbPs2U5TYZnwML7pb+w/NqSuDgqq2nTORuLuQ1Xdhklpdtt3
	K7qt7d20a43yMxfNlWG/n3Q+jDup0tO3VDFHbkNF7uTK40uk/d483G1wtlGP0aiosDHkvUrQ
	7RdbPx8Q3VG3J6atsuzpPtYCxQte53YAPdsdU2m/46MTu9/7Clu3/30/T7y2tXVmXbz69iax
	TLsPX4os3/xtMTVn0DzKHHhM5uvLJdxycntiA3cv62/ty5y9a2KxEktxRqKhFnNRcSIAl0mt
	QW8DAAA=
X-CMS-MailID: 20240503140059eucas1p1d16ab98f20873bda3a71a448e40a9d55
X-Msg-Generator: CA
X-RootMTR: 20240501025435eucas1p2f74b16c622aacba09d8913422905d419
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240501025435eucas1p2f74b16c622aacba09d8913422905d419
References: <CAHj4cs8oYFcN6ptCdLjc3vLWRgNHiS8X06OVj_HLbX-wPoT_Mg@mail.gmail.com>
	<CGME20240501025435eucas1p2f74b16c622aacba09d8913422905d419@eucas1p2.samsung.com>
	<20240501025331.594183-1-ebiggers@kernel.org>

--4bc3sbrjbqeupkd7
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 07:53:31PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>=20
> Since the fsverity sysctl registration runs as a builtin initcall, there
> is no corresponding sysctl deregistration and the resulting struct
> ctl_table_header is not used.  This can cause a kmemleak warning just
> after the system boots up.  (A pointer to the ctl_table_header is stored
> in the fsverity_sysctl_header static variable, which kmemleak should
> detect; however, the compiler can optimize out that variable.)  Avoid
> the kmemleak warning by using register_sysctl_init() which is intended
> for use by builtin initcalls and uses kmemleak_not_leak().
>=20
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/r/CAHj4cs8DTSvR698UE040rs_pX1k-WVe7aR6N2O=
oXXuhXJPDC-w@mail.gmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/verity/init.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/fs/verity/init.c b/fs/verity/init.c
> index cb2c9aac61ed..f440f0e61e3e 100644
> --- a/fs/verity/init.c
> +++ b/fs/verity/init.c
> @@ -8,12 +8,10 @@
>  #include "fsverity_private.h"
> =20
>  #include <linux/ratelimit.h>
> =20
>  #ifdef CONFIG_SYSCTL
> -static struct ctl_table_header *fsverity_sysctl_header;
> -
>  static struct ctl_table fsverity_sysctl_table[] =3D {
>  #ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
>  	{
>  		.procname       =3D "require_signatures",
>  		.data           =3D &fsverity_require_signatures,
> @@ -26,14 +24,11 @@ static struct ctl_table fsverity_sysctl_table[] =3D {
>  #endif
>  };
> =20
>  static void __init fsverity_init_sysctl(void)
>  {
> -	fsverity_sysctl_header =3D register_sysctl("fs/verity",
> -						 fsverity_sysctl_table);
> -	if (!fsverity_sysctl_header)
> -		panic("fsverity sysctl registration failed");
> +	register_sysctl_init("fs/verity", fsverity_sysctl_table);
>  }
>  #else /* CONFIG_SYSCTL */
>  static inline void fsverity_init_sysctl(void)
>  {
>  }
>=20
> base-commit: 18daea77cca626f590fb140fc11e3a43c5d41354
> --=20
> 2.45.0
>=20
LGTM

Reviewed-by: Joel Granados <j.granados@samsung.com>

--=20

Joel Granados

--4bc3sbrjbqeupkd7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmY07hUACgkQupfNUreW
QU++eQv/cF4BTI8zzkeQRsDMrZ3sozONUGT1nRV81NRIv8vF9V2RGYGmeXg1Y7j7
8oNDb0FgU3PG8xio+jaX/B1Yqerxl471WjM6EdYfRZ2mQz76TVuwlGcNbxA2PM3K
Ue59dPv3p1Uo+jfKtTimaZyCcAQmbVJj4WKavK3d1QmiAIqyCjAy5doE/23S1j+e
GJu72sbszmJIUuaAwl/lWeSrA0q54F9mHUk1UynbPd6+5ZaiIWcYw258C9DF2AF3
yU3RHsn7poVdS9n4xjS4P6dlMZgaFgqnZzOCV5xlKosU20YulEi3eLZLXnnlrNFw
8btj6xhHHP2352f/txS/VM2WKhuSgdFIbA2NgJslQfd4qCP3tgvXHjkagF3Wx5Mm
tjDL2PmCa5wNw13eqmdEUmdIrdngPMmiAtl88abHEffipBx+ibaKjApMTgcEjeqZ
pN+8Hs++Gu6LjLhWnsao0138JdGsFWFTMMP9OJChTBxHiSGWyBAxeADwlCUPQeOR
cKzoCuQS
=2xwg
-----END PGP SIGNATURE-----

--4bc3sbrjbqeupkd7--

