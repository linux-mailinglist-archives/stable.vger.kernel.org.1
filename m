Return-Path: <stable+bounces-197638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA366C93BE9
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 11:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8978A3A7BA4
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09062268688;
	Sat, 29 Nov 2025 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="cB30Igpb"
X-Original-To: stable@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4C5149C6F
	for <stable@vger.kernel.org>; Sat, 29 Nov 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764411482; cv=none; b=b1ZTjXaBJ73OU5zuaeVxnCUiQupcRof+79JFOWaMN6cfahWOIHmqAY0lOknmF0hMoUlb6nT43crGrZ08Q7GifCHBX8zv/e7Zj9+OxvJK1X4YtisKD0ikS8rY3iPezmsmNbbk5nmTvcBNukrclim2fXvtA4/MwjlHoSvLhBOOZgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764411482; c=relaxed/simple;
	bh=9+f90tlUxzLaz0pPOC4jzL7gQQG0MPBSKqED34YCL2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3u+U7y5j7via+Le4+Do3h0RTePXCpmeZPeJvK4qMxIAW1v6XxZrihX9X7AFt5aT47ePc6cQ/nF3iG15r0HA6aHxyjFi+h0/H7838pVtzQhtZwuo30HB2n4a1QOBihw7QjPH5BEYqPn3kdlxXCveeEY+NVPqXsVg24cKjZfzgOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=cB30Igpb; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vPI1a-001HSQ-V5; Sat, 29 Nov 2025 11:17:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=qA/6oh073nOg8GIV5pu86nLou0SogFYedJB+cFU2PS4=; b=cB30IgpbsFX6AeLQKyjz8QZMMC
	r6w3Y3mZtKsiWkNDSj5tXrUjdY8Bot7AyGdw+ylunO527dZMIPls/lzRdWh/ysTBrZbDa9dc1q/SY
	QAV9latXtJEBE+j/EHsWr1/WfCioo3aXA0XCepVjd+gyOCEVET0Ru5BGC90ZUmHzwy3VpmM2xjtIY
	C4TGbvVMyNcSGFk4VMplSM0WVV0r9pQ3e/xTudprBvgJS7UJutLdisd6qUiTezkvW52cJGGD95XLy
	tv/3j7KzHOhJLjIMkmkZ+DOLsTaarRAYoe9ohoXXB2wluUPzNz9DrldF10a1OcPtMvBT9e4I2fTDL
	1dgmengQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vPI1a-0003uo-CK; Sat, 29 Nov 2025 11:17:54 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vPI1K-002sD5-22; Sat, 29 Nov 2025 11:17:38 +0100
Date: Sat, 29 Nov 2025 10:17:36 +0000
From: david laight <david.laight@runbox.com>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: linux@roeck-us.net, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (w83l786ng) Convert macros to functions to avoid
 TOCTOU
Message-ID: <20251129101736.000fac82@pumpkin>
In-Reply-To: <CALbr=LbYY-_-Uc_45fXDYzOMiYTJpwbNpuj41q2nHmdfangcBQ@mail.gmail.com>
References: <20251128123816.3670-1-hanguidong02@gmail.com>
	<20251128193720.0716cc6d@pumpkin>
	<CALbr=LbYY-_-Uc_45fXDYzOMiYTJpwbNpuj41q2nHmdfangcBQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 29 Nov 2025 08:33:42 +0800
Gui-Dong Han <hanguidong02@gmail.com> wrote:

> On Sat, Nov 29, 2025 at 3:37=E2=80=AFAM david laight <david.laight@runbox=
.com> wrote:
> >
> > On Fri, 28 Nov 2025 20:38:16 +0800
> > Gui-Dong Han <hanguidong02@gmail.com> wrote:
> > =20
> > > The macros FAN_FROM_REG and TEMP_FROM_REG evaluate their arguments
> > > multiple times. When used in lockless contexts involving shared driver
> > > data, this causes Time-of-Check to Time-of-Use (TOCTOU) race
> > > conditions.
> > >
> > > Convert the macros to static functions. This guarantees that arguments
> > > are evaluated only once (pass-by-value), preventing the race
> > > conditions.
> > >
> > > Adhere to the principle of minimal changes by only converting macros
> > > that evaluate arguments multiple times and are used in lockless
> > > contexts.
> > >
> > > Link: https://lore.kernel.org/all/CALbr=3DLYJ_ehtp53HXEVkSpYoub+XYSTU=
8Rg=3Do1xxMJ8=3D5z8B-g@mail.gmail.com/
> > > Fixes: 85f03bccd6e0 ("hwmon: Add support for Winbond W83L786NG/NR")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> > > ---
> > > Based on the discussion in the link, I will submit a series of patche=
s to
> > > address TOCTOU issues in the hwmon subsystem by converting macros to
> > > functions or adjusting locking where appropriate.
> > > ---
> > >  drivers/hwmon/w83l786ng.c | 26 ++++++++++++++++++--------
> > >  1 file changed, 18 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/hwmon/w83l786ng.c b/drivers/hwmon/w83l786ng.c
> > > index 9b81bd406e05..1d9109ca1585 100644
> > > --- a/drivers/hwmon/w83l786ng.c
> > > +++ b/drivers/hwmon/w83l786ng.c
> > > @@ -76,15 +76,25 @@ FAN_TO_REG(long rpm, int div)
> > >       return clamp_val((1350000 + rpm * div / 2) / (rpm * div), 1, 25=
4);
> > >  }
> > >
> > > -#define FAN_FROM_REG(val, div)       ((val) =3D=3D 0   ? -1 : \
> > > -                             ((val) =3D=3D 255 ? 0 : \
> > > -                             1350000 / ((val) * (div))))
> > > +static int fan_from_reg(int val, int div)
> > > +{
> > > +     if (val =3D=3D 0)
> > > +             return -1;
> > > +     if (val =3D=3D 255)
> > > +             return 0;
> > > +     return 1350000 / (val * div);
> > > +}
> > >
> > >  /* for temp */
> > >  #define TEMP_TO_REG(val)     (clamp_val(((val) < 0 ? (val) + 0x100 *=
 1000 \
> > >                                                     : (val)) / 1000, =
0, 0xff)) =20
> >
> > Can you change TEMP_TO_REG() as well.
> > And just use plain clamp() while you are at it.
> > Both these temperature conversion functions have to work with negative =
temperatures.
> > But the signed-ness gets passed through from the parameter - which may =
not be right.
> > IIRC some come from FIELD_GET() and will be 'unsigned long' unless cast=
 somewhere.
> > The function parameter 'corrects' the type to a signed one.
> >
> > So you are fixing potential bugs as well. =20
>=20
> Hi David,
>=20
> Thanks for your feedback on TEMP_TO_REG and the detailed explanation
> regarding macro risks.
>=20
> Guenter has already applied this patch.

Patches are supposed to be posted for review and applied a few days later.

> Since the primary scope here
> was strictly addressing TOCTOU race conditions (and TEMP_TO_REG is not
> used in lockless contexts), it wasn't included.
>=20
> However, I appreciate your point regarding type safety. I will look
> into addressing that in a future separate patch.

It's not just type safety, and #define that evaluates an argument more
than one is just a bug waiting to happen.
We've been removing (or trying not to write) those since the 1980s.

You also just didn't read the code:

-#define TEMP_FROM_REG(val)	(((val) & 0x80 ? \
-				  (val) - 0x100 : (val)) * 1000)
+
+static int temp_from_reg(int val)
+{
+	if (val & 0x80)
+		return (val - 0x100) * 1000;
+	return val * 1000;
+}

Both those only work if 'val' is 8 bits.
They are just ((s8)(val) * 1000) and generate a milli-centigrade
value from the 8-bit signed centigrade value the hardware provides.

TEMP_TO_REG() is the opposite, so is:
	(u8)clamp((val) / 1000, -128, 127)
That is subtly different since it truncates negative values towards
zero rather than -infinity.
The more complicated:
		(u8)(clamp(((val) + 128 * 1000)/1000, 0, 0xff) - 128)
would exactly match the original (and generate less code) but I suspect
it doesn't matter here.

	David

>=20
> Best regards,
> Gui-Dong Han
>=20


