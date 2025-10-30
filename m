Return-Path: <stable+bounces-191737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1CAC207CC
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 15:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E623B6AB3
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 14:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335371FDE39;
	Thu, 30 Oct 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IieA8myW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C84192B90
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832915; cv=none; b=EDX4Fe6z0Yo6kYtN4iIOTY9SPLB1OjtUeASAcOl3cW/o0QJ2DtWenbpqlX0MKvO+2vyEODZRTfOGAZsDkKTKj+LqB+0TaBIHqnLX0XfzwtCM+9/+P5umIsc5CsRseQkZJGi4FQRhW5VqoU6i7/fm+onSgoHU8rWcIqEXagOMdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832915; c=relaxed/simple;
	bh=Ez9Ck8a0vFDjWaFW7yQc/XxQm/vx9CpdxqOM5+Cz0DU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sls+ZkU0pzzgdebaWlKSHvmk8tE47Mep0izC/+AGGZpa/up/t1tSipPTO2JZzqNWyhvx3rKwU1CSRqZlDQq1LT3VgRlX/HwxA4vWk8j5g5AM3l8pi4WrtPBGZj3EnUTRxuGZg9nKouCnXX0zl+pE7QuAuAQw83gmxsXqXG0lqWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IieA8myW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so45272066b.3
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761832911; x=1762437711; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K9kue/PqLi5iz0mudeRJtK6kDoEwYvI49bfICJqSOLY=;
        b=IieA8myWdu/Dpkf2LmoO7mbEJ2XAkeT964T1IyDbrinoKqFdC20pRkj/2i6nlcFe8W
         8i5VUydkYR34bsUk3qMeXXfFjbBljDqdHv3TmY2uPxl1vmiWsiTgfRs+LpbvUKIZQPEQ
         DE1iLOnmwtc8NA8h+1srB67KfeDqpGfm9HSqrMBbIqlg2JzkR1Q15DjcroGQrvPHTbLH
         zwWfd3Jw+S/LR6jjweGDJfa0I4MJLBfPBj30VK99IF5LzOwM+d95j8A7zEyR8RxPyXsj
         u6bykVc09rfZ46FV7QeBMcW/0fLt0RZgnn+RhsZJgIsxydoufZGUI/GhFmLcihj8ZPTX
         Ta0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761832911; x=1762437711;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9kue/PqLi5iz0mudeRJtK6kDoEwYvI49bfICJqSOLY=;
        b=laLb7P55HPdVYoKKMrFMJAhtzanbatRJEHw08KLfjvMrvUj7eVEcXl4+X8cQobONrj
         GJ03ns4yBQhL4BiyS/43RoEwAn5Egw/kEOJrCoizqqAiOMltkqAMAkc4EjuT2f9KkXug
         2KDIm5t+g6NdZAFZZ96pFxZ/pPerQja2RQCthn06LaQh8SjqA7hVkF/A8phIu7/CgnyE
         4wqKfWq7IR9PHoXsD8V/kUlqPAKs6o3O2LTnWK1jLIaSW584JE3aJ05Oax9PFLv1MZcm
         n3o7l2iNeVtSFIS3deVMOWWrDMXwSCthmCCknCDlJVKQSQgpCtGtpLWnvWRCxs33bLia
         OPdw==
X-Forwarded-Encrypted: i=1; AJvYcCWBVX+CwWbro/n5C6Hp0NE18JJGVJk+R9nzZCXqgRfmJ1Lm3w8WoWZFPMW6Y3Oq7sDA6Y/FjPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvFo9j6ONH/IUpu77ebzGNpOZOrPHhWFVz9w2x1FSJyLqDnIar
	DSpOrZCmRSkmDZO5vf++5eKf2WqegVLPRpnYGKa0Fs4bukiaZzhL0IVF
X-Gm-Gg: ASbGncuZdkxxaTdsygCgrhyRAi+J3ov+kyn6i38p+fNAxvXdr0rv836wmX2I8udDlPb
	bn2ff6N5gN3T0oZHLZCqP68jHCmS+9bgfWqtVFdbCXA6Mk/tegZv5RH8GVYZmr15OkvMMvEqgjX
	GyS1j4a/9XwZq0lIzudyRsKH+rRWipdYsBDIAmKYJLwZVXQhtcO9+vgIoLsaFjCiTDPblldtW4H
	PB2opqKNjIuttA7zEUcQBbFd7WIn+wJK+XCQsp7MVXVwEz7QbyBD6p2Q8Eh4Lm+LzKOXiBls/6o
	QKIugFnXnTWL/I3I9oz2UJDsVmYPr6Z8as740nBsYuic1wcdxE8nI6f+SbO8PNPm4z2RpWX2RWd
	zWt7Kel+YMM6woEmIgc65oLsiCt3cvO22RG91ijwByQp1Z2pXKph1jdx2GMcX6RmxNclpWXB0i7
	+F95bM5MUZJ57Eg3T0OVHi9r9dQHOHfgabBkVLz0hW3fp61xCvv+h8mrvbfLug73EwnmCm+tfai
	FT7Eg==
X-Google-Smtp-Source: AGHT+IEm/43E4DI3T9Mp95lEihYPBVcNw0U7rk31oqk75XSv6jtyEKE8zvqZTUVdwgKohlYmGEoTqA==
X-Received: by 2002:a17:906:6a2a:b0:b0a:aa7e:a191 with SMTP id a640c23a62f3a-b703d5fa89dmr803764766b.57.1761832910405;
        Thu, 30 Oct 2025 07:01:50 -0700 (PDT)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85398439sm1769963966b.36.2025.10.30.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:01:50 -0700 (PDT)
Message-ID: <40cf6de07208cdc624f71e276bfbff1e00079aef.camel@gmail.com>
Subject: Re: [PATCH v2 1/4] ASoC: cs4271: Fix cs4271 I2C and SPI drivers
 automatic module loading
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, Mark Brown <broonie@kernel.org>
Cc: David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald	
 <rf@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob
 Herring	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai	 <tiwai@suse.com>, Nikita Shubin <nikita.shubin@maquefel.me>, Axel Lin
	 <axel.lin@ingics.com>, Brian Austin <brian.austin@cirrus.com>, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni	
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Date: Thu, 30 Oct 2025 15:01:48 +0100
In-Reply-To: <1ae385ba6000fc5e90adadc6dcdc2fa8b19d5783.camel@gmail.com>
References: <20251029093921.624088-1-herve.codina@bootlin.com>
			<20251029093921.624088-2-herve.codina@bootlin.com>
			<06766cfb10fd6b7f4f606429f13432fe8b933d83.camel@gmail.com>
		 <20251030144319.671368a2@bootlin.com>
	 <1ae385ba6000fc5e90adadc6dcdc2fa8b19d5783.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Herve,

On Thu, 2025-10-30 at 14:54 +0100, Alexander Sverdlin wrote:
> > > > --- a/sound/soc/codecs/cs4271-spi.c
> > > > +++ b/sound/soc/codecs/cs4271-spi.c
> > > > @@ -23,11 +23,24 @@ static int cs4271_spi_probe(struct spi_device *=
spi)
> > > > =C2=A0	return cs4271_probe(&spi->dev, devm_regmap_init_spi(spi, &co=
nfig));
> > > > =C2=A0}
> > > > =C2=A0
> > > > +static const struct spi_device_id cs4271_id_spi[] =3D {
> > > > +	{ "cs4271", 0 },
> > > > +	{}
> > > > +};
> > > > +MODULE_DEVICE_TABLE(spi, cs4271_id_spi);
> > > > +
> > > > +static const struct of_device_id cs4271_dt_ids[] =3D {
> > > > +	{ .compatible =3D "cirrus,cs4271", },
> > > > +	{ }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, cs4271_dt_ids);=C2=A0=20
> > >=20
> > > So currently SPI core doesn't generate "of:" prefixed uevents, theref=
ore this
> > > currently doesn't help? However, imagine, you'd have both backends en=
abled
> > > as modules, -spi and -i2c. udev/modprobe currently load just one modu=
le it
> > > finds first. What is the guarantee that the loaded module for the "of=
:"
> > > prefixed I2C uevent would be the -i2c module?
> > >=20
> >=20
> > I hesitate to fully remove cs4271_dt_ids in the SPI part.
> >=20
> > I understood having it could lead to issues if both SPI and I2C parts
> > are compiled as modules but this is the pattern used in quite a lot of
> > drivers.
> >=20
> > Maybe this could be handle globally out of this series instead of intro=
ducing
> > a specific pattern in this series.
> >=20
> > But well, if you and Mark are ok to fully remove the cs4271_dt_ids from=
 the
> > SPI part and so unset the of_match_table from the cs4271_spi_driver, I =
can
> > do the modification.
> >=20
> > Let me know if I should send a new iteration with cs4271_dt_ids fully r=
emoved
> > from the SPI part.
> >=20
> > Also, last point, I don't have any cs4271 connected to a SPI bus.
> > I use only the I2C version and will not be able to check for correct
> > modifications on the SPI part.
>=20
> I'd propose to drop SPI modifications in this case, because by doing this
> you actually introduce yet another problem for the I2C case you are inter=
ested
> in (namely if you'd enable both modules).

sorry again for the confusion, I meant only to drop "MODULE_DEVICE_TABLE(of=
, "
from SPI...

But seems that Mark actually has different opinion... Indeed=20

$ grep -F "MODULE_DEVICE_TABLE(of, " *spi*.c | wc -l

currently reports "17" out of 23 SPI-capable CODECs. I just don't see how
you are helping the I2C use case by doing this...

--=20
Alexander Sverdlin.

