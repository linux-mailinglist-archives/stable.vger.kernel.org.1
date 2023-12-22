Return-Path: <stable+bounces-8317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC4681C6DD
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 09:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F761C22055
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 08:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BEAC8F7;
	Fri, 22 Dec 2023 08:50:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FD5C8D4
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-158-bnoF6U_lN_2qL4OFa7d0DQ-1; Fri, 22 Dec 2023 08:50:33 +0000
X-MC-Unique: bnoF6U_lN_2qL4OFa7d0DQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 22 Dec
 2023 08:50:19 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 22 Dec 2023 08:50:19 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Anthony Brennan' <a2brenna@hatguy.io>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] netfs: Fix missing xas_retry() calls in xarray iteration
Thread-Topic: [PATCH] netfs: Fix missing xas_retry() calls in xarray iteration
Thread-Index: AQHaNGv45jI0mpzsk0Ws+tCnq8Ow6rC0/tYw
Date: Fri, 22 Dec 2023 08:50:18 +0000
Message-ID: <1e199de1e466440c8fe91b0a806e5fad@AcuMS.aculab.com>
References: <20231222001522.GA32730@hatguy.io>
In-Reply-To: <20231222001522.GA32730@hatguy.io>
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

From: Anthony Brennan
> Sent: 22 December 2023 00:15
>=20
> commit 59d0d52c30d4991ac4b329f049cc37118e00f5b0 upstream
>=20
> Stops kernel from crashing when encountering an XAS retry entry. Patch mo=
dified
> from upstream to work with pages instead of folios, and omits fixes to "d=
odgy
> maths" as unrelated to fixing the crash.
>=20
> Signed-off-by: Anthony Brennan <a2brenna@hatguy.io>
> ---
>  fs/netfs/read_helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index 242f8bcb34a4..4de15555bceb 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -248,6 +248,9 @@ static void netfs_rreq_unmark_after_write(struct netf=
s_read_request *rreq,
>  =09=09XA_STATE(xas, &rreq->mapping->i_pages, subreq->start / PAGE_SIZE);
>=20
>  =09=09xas_for_each(&xas, page, (subreq->start + subreq->len - 1) / PAGE_=
SIZE) {
> +=09=09=09if(xas_retry(&xas, page))

'if' is not a function.

> +=09=09=09=09continue;
> +
>  =09=09=09/* We might have multiple writes from the same huge
>  =09=09=09 * page, but we mustn't unlock a page more than once.
>  =09=09=09 */
> @@ -403,6 +406,9 @@ static void netfs_rreq_unlock(struct netfs_read_reque=
st *rreq)
>  =09=09unsigned int pgend =3D pgpos + thp_size(page);
>  =09=09bool pg_failed =3D false;
>=20
> +=09=09if(xas_retry(&xas, page))
> +=09=09=09continue;
> +
>  =09=09for (;;) {
>  =09=09=09if (!subreq) {
>  =09=09=09=09pg_failed =3D true;
> --
> 2.30.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


