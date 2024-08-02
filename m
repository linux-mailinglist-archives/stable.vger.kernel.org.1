Return-Path: <stable+bounces-65289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B589459A8
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 10:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F29B4B224F0
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 08:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5DA1C2334;
	Fri,  2 Aug 2024 08:10:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD01C0DF1
	for <stable@vger.kernel.org>; Fri,  2 Aug 2024 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586254; cv=none; b=l4a1KayqvunbQB3HQKIizJhUUf/IVAuvPJQPD/gg2KeU3K+hg9MX6F/TzLgOrFPqht46jXlm5Wu0g829oGkXKGquHaOG7WJm45i1RtOrCoxagKp5tcOdrkiddHIiiiYUXTt8mUZGfLmLdJeMVBHuBL/B8qsFtKer8h/ckak+j00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586254; c=relaxed/simple;
	bh=CuMgTyhRiXFGu/Wk31+CzmYjkWa9oQ3VXwtvzg+PBI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=WaKOeHsBrgK/ioQv+HANKRN1P+GeeQ9W68csL+RZmpWmpSnZI1jwPUWA4D4ctpUSMiaNudTmTT6kBtAacyU+HlIKsNAUzMLie/EkRMR4mVAkRYZOZU+46V1CZP2BQ0B2ARMRstruoch05IBOazLwIGf74GPvRcW2PimWex9BIB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-80-s7rDkYwSMoizWbYGjzwnMg-1; Fri, 02 Aug 2024 09:10:42 +0100
X-MC-Unique: s7rDkYwSMoizWbYGjzwnMg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 2 Aug
 2024 09:10:02 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 2 Aug 2024 09:10:02 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Simon Horman' <horms@kernel.org>, Herve Codina <herve.codina@bootlin.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net v1] net: wan: fsl_qmc_hdlc: Discard received CRC
Thread-Topic: [PATCH net v1] net: wan: fsl_qmc_hdlc: Discard received CRC
Thread-Index: AQHa4yXTTA/3x7b/50KM7uMtkj8Gw7ITnhqw
Date: Fri, 2 Aug 2024 08:10:02 +0000
Message-ID: <7659191688194f099cba22cc367c4eda@AcuMS.aculab.com>
References: <20240730063133.179598-1-herve.codina@bootlin.com>
 <20240731084443.GL1967603@kernel.org>
In-Reply-To: <20240731084443.GL1967603@kernel.org>
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

From: Simon Horman
> Sent: 31 July 2024 09:45
>=20
> On Tue, Jul 30, 2024 at 08:31:33AM +0200, Herve Codina wrote:
> > Received frame from QMC contains the CRC.
> > Upper layers don't need this CRC and tcpdump mentioned trailing junk
> > data due to this CRC presence.
> >
> > As some other HDLC driver, simply discard this CRC.
>=20
> It might be nice to specifically site an example.
> But yes, I see this pattern in hdlc_rx_done().

Pretty much the only reason you'd want the received CRC is to do
error recovery assuming a single short error burst.
Not that I've ever seen a driver contain the required code.
'Back of envelope' calculation: 32bit crc, 2kbyte frame, so 18bits
of crc per data bit, sqrt for 'birthday paradox' - I bet you can
recover 8-bit error bursts.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


