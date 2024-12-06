Return-Path: <stable+bounces-99986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F59F9E7A06
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 21:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB45C283CF3
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D301B1C54AD;
	Fri,  6 Dec 2024 20:31:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62BA1C5496
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517092; cv=none; b=ukMlnIPUTnQN0/7FIGYepHn39aF89X7Xe5noc/UXSxQyCfEuagXqifj3dKdHSgQsjcHvMAhS3i7OE4LwpVHtoDUUIKrXow8kinig6B5BSxjOqvNmSCAVNgwqjqFtIcOoCyAjylp12DcgTgz/AjkbC+bAV6BEitGI2w43NYMvfso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517092; c=relaxed/simple;
	bh=HYzB01v/NM3wdKIGQ7Wjz0COLwfsS1syLVt35NFSdvI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VKqLQnaMLqSEXnIPtz9Jwo01FAvAIlmuZl4cnZZcs92FQgMHxp6AxxYmSvLtvURFmKLFtgWVEfUEY1SkUyEXWC2uVJegasXuWXyWCXGjckmGah9CfAEdWcYmOt/Dg0f6AJknKo0zjBhPsxcJvcsRH5fj25QeBEbUpqq1xBFGkMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-7-1sxFTS2yM0ytUm8cZogNgQ-1; Fri, 06 Dec 2024 20:31:27 +0000
X-MC-Unique: 1sxFTS2yM0ytUm8cZogNgQ-1
X-Mimecast-MFC-AGG-ID: 1sxFTS2yM0ytUm8cZogNgQ
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 6 Dec
 2024 20:30:40 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 6 Dec 2024 20:30:40 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'SeongJae Park' <sj@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "damon@lists.linux.dev" <damon@lists.linux.dev>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, kernel test robot <lkp@intel.com>, Brendan Higgins
	<brendanhiggins@google.com>, Shuah Khan <shuah@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [PATCH 5.15.y 1/2] mm/damon/vaddr-test: split a test function
 having >1024 bytes frame size
Thread-Topic: [PATCH 5.15.y 1/2] mm/damon/vaddr-test: split a test function
 having >1024 bytes frame size
Thread-Index: AQHbSArnkIl2VsLGyUyrnUDDHJF4R7LZqsOw
Date: Fri, 6 Dec 2024 20:30:40 +0000
Message-ID: <1859ccaacd974b37a05b42371e57a061@AcuMS.aculab.com>
References: <2024120625-recycling-till-0cca@gregkh>
 <20241206181620.91603-1-sj@kernel.org> <20241206181620.91603-2-sj@kernel.org>
In-Reply-To: <20241206181620.91603-2-sj@kernel.org>
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
X-Mimecast-MFC-PROC-ID: Gep8JEE6MxR5wG887wIB12RJ0GgTrxFOy3_iB8IzymQ_1733517086
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: SeongJae Park
> Sent: 06 December 2024 18:16
>=20
> On some configuration[1], 'damon_test_split_evenly()' kunit test
> function has >1024 bytes frame size, so below build warning is
> triggered:
>=20
>       CC      mm/damon/vaddr.o
>     In file included from mm/damon/vaddr.c:672:
>     mm/damon/vaddr-test.h: In function 'damon_test_split_evenly':
>     mm/damon/vaddr-test.h:309:1: warning: the frame size of 1064 bytes is=
 larger than 1024 bytes [-
> Wframe-larger-than=3D]
>       309 | }
>           | ^
>=20
> This commit fixes the warning by separating the common logic in the
> function.

In that guaranteed to make any difference without some noinline_for_stack
attributes?

Not that I can see exactly where the stack was used.
But it tends to be clang that doesn't re-use stack space.

=09David

>=20
> [1] https://lore.kernel.org/linux-mm/202111182146.OV3C4uGr-lkp@intel.com/
>=20
> Link: https://lkml.kernel.org/r/20211201150440.1088-6-sj@kernel.org
> Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> (cherry picked from commit 044cd9750fe010170f5dc812e4824d98f5ea928c)
> ---
>  mm/damon/vaddr-test.h | 77 ++++++++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 37 deletions(-)
>=20
> diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> index 1f5c13257dba..95ec362cdc37 100644
> --- a/mm/damon/vaddr-test.h
> +++ b/mm/damon/vaddr-test.h
> @@ -252,59 +252,62 @@ static void damon_test_apply_three_regions4(struct =
kunit *test)
>  =09=09=09new_three_regions, expected, ARRAY_SIZE(expected));
>  }
>=20
> -static void damon_test_split_evenly(struct kunit *test)
> +static void damon_test_split_evenly_fail(struct kunit *test,
> +=09=09unsigned long start, unsigned long end, unsigned int nr_pieces)
>  {
> -=09struct damon_ctx *c =3D damon_new_ctx();
> -=09struct damon_target *t;
> -=09struct damon_region *r;
> -=09unsigned long i;
> -
> -=09KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(NULL, NULL, 5),
> -=09=09=09-EINVAL);
> -
> -=09t =3D damon_new_target(42);
> -=09r =3D damon_new_region(0, 100);
> -=09KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(t, r, 0), -EINVAL)=
;
> +=09struct damon_target *t =3D damon_new_target(42);
> +=09struct damon_region *r =3D damon_new_region(start, end);
>=20
>  =09damon_add_region(r, t);
> -=09KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(t, r, 10), 0);
> -=09KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 10u);
> +=09KUNIT_EXPECT_EQ(test,
> +=09=09=09damon_va_evenly_split_region(t, r, nr_pieces), -EINVAL);
> +=09KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1u);
>=20
> -=09i =3D 0;
>  =09damon_for_each_region(r, t) {
> -=09=09KUNIT_EXPECT_EQ(test, r->ar.start, i++ * 10);
> -=09=09KUNIT_EXPECT_EQ(test, r->ar.end, i * 10);
> +=09=09KUNIT_EXPECT_EQ(test, r->ar.start, start);
> +=09=09KUNIT_EXPECT_EQ(test, r->ar.end, end);
>  =09}
> +
>  =09damon_free_target(t);
> +}
> +
> +static void damon_test_split_evenly_succ(struct kunit *test,
> +=09unsigned long start, unsigned long end, unsigned int nr_pieces)
> +{
> +=09struct damon_target *t =3D damon_new_target(42);
> +=09struct damon_region *r =3D damon_new_region(start, end);
> +=09unsigned long expected_width =3D (end - start) / nr_pieces;
> +=09unsigned long i =3D 0;
>=20
> -=09t =3D damon_new_target(42);
> -=09r =3D damon_new_region(5, 59);
>  =09damon_add_region(r, t);
> -=09KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(t, r, 5), 0);
> -=09KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
> +=09KUNIT_EXPECT_EQ(test,
> +=09=09=09damon_va_evenly_split_region(t, r, nr_pieces), 0);
> +=09KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_pieces);
>=20
> -=09i =3D 0;
>  =09damon_for_each_region(r, t) {
> -=09=09if (i =3D=3D 4)
> +=09=09if (i =3D=3D nr_pieces - 1)
>  =09=09=09break;
> -=09=09KUNIT_EXPECT_EQ(test, r->ar.start, 5 + 10 * i++);
> -=09=09KUNIT_EXPECT_EQ(test, r->ar.end, 5 + 10 * i);
> +=09=09KUNIT_EXPECT_EQ(test,
> +=09=09=09=09r->ar.start, start + i++ * expected_width);
> +=09=09KUNIT_EXPECT_EQ(test, r->ar.end, start + i * expected_width);
>  =09}
> -=09KUNIT_EXPECT_EQ(test, r->ar.start, 5 + 10 * i);
> -=09KUNIT_EXPECT_EQ(test, r->ar.end, 59ul);
> +=09KUNIT_EXPECT_EQ(test, r->ar.start, start + i * expected_width);
> +=09KUNIT_EXPECT_EQ(test, r->ar.end, end);
>  =09damon_free_target(t);
> +}
>=20
> -=09t =3D damon_new_target(42);
> -=09r =3D damon_new_region(5, 6);
> -=09damon_add_region(r, t);
> -=09KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(t, r, 2), -EINVAL)=
;
> -=09KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1u);
> +static void damon_test_split_evenly(struct kunit *test)
> +{
> +=09struct damon_ctx *c =3D damon_new_ctx();
> +
> +=09KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(NULL, NULL, 5),
> +=09=09=09-EINVAL);
> +
> +=09damon_test_split_evenly_fail(test, 0, 100, 0);
> +=09damon_test_split_evenly_succ(test, 0, 100, 10);
> +=09damon_test_split_evenly_succ(test, 5, 59, 5);
> +=09damon_test_split_evenly_fail(test, 5, 6, 2);
>=20
> -=09damon_for_each_region(r, t) {
> -=09=09KUNIT_EXPECT_EQ(test, r->ar.start, 5ul);
> -=09=09KUNIT_EXPECT_EQ(test, r->ar.end, 6ul);
> -=09}
> -=09damon_free_target(t);
>  =09damon_destroy_ctx(c);
>  }
>=20
> --
> 2.39.5
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


