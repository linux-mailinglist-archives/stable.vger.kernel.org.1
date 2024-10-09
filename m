Return-Path: <stable+bounces-83250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8259971E0
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 18:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC931F2B1D5
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6171E1E0DA5;
	Wed,  9 Oct 2024 16:37:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B1D1E00A9
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491865; cv=none; b=JQRMCgFRvAF2ni7Q4Jb2QS8Rtrw2V+Sbe1FdtoIB7+mfDiJGAClZpoR/ll/4wkpu6xpYwVev7hFVfWpXAmegZRmi7opqvuevREOmciA56ISvfIS8Cv3lyltiXJQoJnabMq98q0lSeAio2GKQKfSkQXep9aE9K8NId1mfCvMkQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491865; c=relaxed/simple;
	bh=28jugDOhquh+90spPGv5MKQk4Y8RSQb7T1bWx5XH7I4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=rkCmgxDN5xQiiwPF3ICVKZ3vlHNUuokPAiOChmVzKMh3RGG5+WgMglgM/pXcZVAOtdEgmtVRR/024A0ksCfLdnwkv0Sagydh8AoYWxxSNFNLPbmoG1gaEp0U9t+7MINDQNH8rouqjEmIVNOJGB3Obg2flkm4U0yl9lU4jV+WXxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-133-m9nfg3y3MLyW_hUkH7wLog-1; Wed, 09 Oct 2024 17:37:33 +0100
X-MC-Unique: m9nfg3y3MLyW_hUkH7wLog-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 9 Oct
 2024 17:37:32 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 9 Oct 2024 17:37:32 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Andrej Shadura' <andrew.shadura@collabora.co.uk>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>, Justin Stitt
	<justinstitt@google.com>, Aleksei Vetrov <vvvvvv@google.com>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, "kernel@collabora.com"
	<kernel@collabora.com>, George Burgess <gbiv@chromium.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] Bluetooth: Fix type of len in
 rfcomm_sock_getsockopt{,_old}()
Thread-Topic: [PATCH v2] Bluetooth: Fix type of len in
 rfcomm_sock_getsockopt{,_old}()
Thread-Index: AQHbGllm5JoAzzHp/kq/PUrt6KxIY7J+nDog
Date: Wed, 9 Oct 2024 16:37:32 +0000
Message-ID: <49c81d21778b4ef5a7ab458b359a9993@AcuMS.aculab.com>
References: <20241009121424.1472485-1-andrew.shadura@collabora.co.uk>
In-Reply-To: <20241009121424.1472485-1-andrew.shadura@collabora.co.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Andrej Shadura
> Sent: 09 October 2024 13:14
>=20
> Commit 9bf4e919ccad worked around an issue introduced after an innocuous
> optimisation change in LLVM main:
>=20
> > len is defined as an 'int' because it is assigned from
> > '__user int *optlen'. However, it is clamped against the result of
> > sizeof(), which has a type of 'size_t' ('unsigned long' for 64-bit
> > platforms). This is done with min_t() because min() requires compatible
> > types, which results in both len and the result of sizeof() being caste=
d
> > to 'unsigned int', meaning len changes signs and the result of sizeof()
> > is truncated. From there, len is passed to copy_to_user(), which has a
> > third parameter type of 'unsigned long', so it is widened and changes
> > signs again.

That can't matter because the value is a small positive integer.

> This excessive casting in combination with the KCSAN
> > instrumentation causes LLVM to fail to eliminate the __bad_copy_from()
> > call, failing the build.
>=20
> The same issue occurs in rfcomm in functions rfcomm_sock_getsockopt and
> rfcomm_sock_getsockopt_old.
>=20
> Change the type of len to size_t in both rfcomm_sock_getsockopt and
> rfcomm_sock_getsockopt_old and replace min_t() with min().

Isn't there still a problem if the application passed a negative length.
You are converting it to a very large unsigned value and then reducing
it to the structure size.
Since the structure size will be less than 2GB it makes no difference
whether the '__user int optlen' is ever converted to 64bits.
I think you are just hiding a bug in a different way.

Note that pretty much all the checks for 'optlen' have treated
negative values as 4 since well before the min() and min_t()
#defines were added.
Look at the tcp code!

I bet that globally fixing the test will cause some important
application that is passing 'on stack garbage' to fail.

=09David

>=20
> Cc: stable@vger.kernel.org
> Co-authored-by: Aleksei Vetrov <vvvvvv@google.com>
> Improves: 9bf4e919ccad ("Bluetooth: Fix type of len in {l2cap,sco}_sock_g=
etsockopt_old()")
> Link: https://github.com/ClangBuiltLinux/linux/issues/2007
> Link: https://github.com/llvm/llvm-project/issues/85647
> Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  net/bluetooth/rfcomm/sock.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index 37d63d768afb..5f9d370e09b1 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -729,7 +729,8 @@ static int rfcomm_sock_getsockopt_old(struct socket *=
sock, int optname, char __u
>  =09struct sock *l2cap_sk;
>  =09struct l2cap_conn *conn;
>  =09struct rfcomm_conninfo cinfo;
> -=09int len, err =3D 0;
> +=09int err =3D 0;
> +=09size_t len;
>  =09u32 opt;
>=20
>  =09BT_DBG("sk %p", sk);
> @@ -783,7 +784,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *=
sock, int optname, char __u
>  =09=09cinfo.hci_handle =3D conn->hcon->handle;
>  =09=09memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
>=20
> -=09=09len =3D min_t(unsigned int, len, sizeof(cinfo));
> +=09=09len =3D min(len, sizeof(cinfo));
>  =09=09if (copy_to_user(optval, (char *) &cinfo, len))
>  =09=09=09err =3D -EFAULT;
>=20
> @@ -802,7 +803,8 @@ static int rfcomm_sock_getsockopt(struct socket *sock=
, int level, int optname, c
>  {
>  =09struct sock *sk =3D sock->sk;
>  =09struct bt_security sec;
> -=09int len, err =3D 0;
> +=09int err =3D 0;
> +=09size_t len;
>=20
>  =09BT_DBG("sk %p", sk);
>=20
> @@ -827,7 +829,7 @@ static int rfcomm_sock_getsockopt(struct socket *sock=
, int level, int optname, c
>  =09=09sec.level =3D rfcomm_pi(sk)->sec_level;
>  =09=09sec.key_size =3D 0;
>=20
> -=09=09len =3D min_t(unsigned int, len, sizeof(sec));
> +=09=09len =3D min(len, sizeof(sec));
>  =09=09if (copy_to_user(optval, (char *) &sec, len))
>  =09=09=09err =3D -EFAULT;
>=20
> --
> 2.43.0
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


