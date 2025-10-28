Return-Path: <stable+bounces-191461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F74C14A23
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 13:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7900046769E
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAE832D7D9;
	Tue, 28 Oct 2025 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dccYhXjw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA223A562
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654635; cv=none; b=AU+oE7C1ZB7ZWtXjqUV5hdkj+VFXD7BJQ2dezqEk3WPLlB/8tbBycm5n3lc6h/pc89gGZsq6uZ4AfJy7bcgOi1NL4p5FyiK2cPax0Df+E7VuAIRlonZ/h/LeUCBFRKNSEaaXg+ZCKkxVFKaMyaOIPRx4M56qrbDJ2OZgoZzJb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654635; c=relaxed/simple;
	bh=0f04VfYAQOkqrLpARC7cLeA4nIsQOh8qYdmJHGhMm5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xu6Pg+mRUl/NS4+aG55nL/3U8gBLfJZ5ihH3LR/Smyn8sfxNskHovyhCvXeWAdPzvVb/ityfGNDEf1xTGWbX760PruwAiJ4G85edJVQdEQRasgqLpBA/3iyXlrhKhsdIIYPA1yGRN6bO8z3B17sMax2JcAatqbpAoFEhT3hNmjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dccYhXjw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475de184058so14151855e9.2
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761654631; x=1762259431; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uM1qiGzCV5xixBDHYGWO+dT5xDst6ueuPSytOOrmsBg=;
        b=dccYhXjwNhAzvtkHDbYazUFGIeUejlLXhzUVgt77w7X90kVsTphbXChEwDvwDkRzKc
         qJSkqDZ2rLOzMn10H9/HpmmagKGj/CVQECztS1fzfD/OnF4omYBBmnNNMHb4HB0tYo76
         tAJmgOKeeNUYrytYU1DqSwCda+sgyaLhGYu3wVliD3BBHUWm7g4nNJC0nv2n/6Rr4JEy
         f+1A3a531WLoELfRaKKiR7ruBjAS+mv7LRzqkJo3K/5MKjeWlwLrltZxzRS8plHB7zoB
         up8Vggw+4dzlJC7QYyOJrCMwKRQRdvo9dbCKALxdrGySSW+8vCeimljMVbVZTDxIIQXe
         pPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761654631; x=1762259431;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uM1qiGzCV5xixBDHYGWO+dT5xDst6ueuPSytOOrmsBg=;
        b=Z40Ylk4ajJiqmm41U0B5cgcVFkN9A80uboCJCcqRNy1tUSGYm8iW9vz48tflrlQF9C
         l6TM3ioH7UVr+qdMqg4DBqW12ErWeyRTwulShYzNs3vifgdphU0RIVXRNOHO40VbY8iq
         /780iAo67bjVrz8peuC1u7plaXZhWsO9pesg8K/iT7dAz/d3zDTb8J2z/wbCwmTwSYCl
         AqWGrBsJh7COIREDHwWK0yb7RB36MlnFXNK764L/YBSZ3yjXMdxPzXbrN7bMT1o6CWvu
         7LdlQ0DIN9JyqppX61E0Fua92ApiS6jw1xCAum+rwvHt6kXI0VhfAkwX0o7QvrjVThtC
         2PqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKToGJrxysGvvAFJMCl92TkmSPZBPgyL40BBUGqN3SMxpNT07WCISJ4FDvQr/xcgbSfEMT6fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSC0+8Cr2ZU5qvMf3i1NFMSZpNgWacxKherlPIQBCL35KgWyn7
	kR8QpzxyVfVlBLhaG7GhxJOMkHwstvR/19dKbFktHyuWJTxzL4BGJxt7
X-Gm-Gg: ASbGncucq2KUWftkStFYqRp9YQXfzI7jA+hK9yAfjVZi+RpB8hsfZHwfkeDhiznzCai
	9AsEU6CoXnPAGSghIVNkr5xz8xkuVika4+QwCdJYs57X+swhr1v322xpyYKa56kn7tNpE4PAASD
	qH8PVzpr1NHO0Rk7nJlh8lwqVCUK0tl81qUxytWPUbn7dwtWwib8JUiPMYZAkHjJPpSZ0BmBTT4
	Myh+c4q2BUMcEF0ZRdelt0I3rcYtkzJEtMl6fIDFUdXEouM/MvxhnnibiQxfPmMx507XaSZ3OQo
	J4HvKIUoPuIxdud15lknqHOAueeI7z4Sw9gGR12M/uYpHFiTeCKgvWO4CSiaidRvfR2sN/PF9lq
	4YDTDpixQT/zs3B6HNf/2qHLhHGYghtE3oYZsIYLvzBCl5CJbT2BG9NbsqZluCLjPv+EqGlIP2D
	seoJDHNR7/
X-Google-Smtp-Source: AGHT+IGEqnfB8W17Zq9R3EW1M/jbofJiBPGzUMdTs8hOW1t438UzjJB1DB8v/cUw7rTmUqtKI8cQFw==
X-Received: by 2002:a05:600c:3e16:b0:476:a25f:6a4d with SMTP id 5b1f17b1804b1-47717df7f6dmr30430845e9.1.1761654630419;
        Tue, 28 Oct 2025 05:30:30 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475de57b156sm184073395e9.13.2025.10.28.05.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 05:30:29 -0700 (PDT)
Message-ID: <071e3da4d69e10d64c54a18b7dd34ae11ab68f58.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in
 ad3552r_hs_write_data_source
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Miaoqian Lin
	 <linmq006@gmail.com>, Markus Burri <markus.burri@mt.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>, Angelo Dureghello
 <adureghello@baylibre.com>, 	linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 28 Oct 2025 12:31:04 +0000
In-Reply-To: <aQCHt9JL0Bc4Pduv@smile.fi.intel.com>
References: <20251027150713.59067-1-linmq006@gmail.com>
	 <aQB8PRlaBY_9-L8d@smile.fi.intel.com> <aQB8j7Hc3b9vAT5_@smile.fi.intel.com>
	 <aQCHt9JL0Bc4Pduv@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-28 at 11:07 +0200, Andy Shevchenko wrote:
> On Tue, Oct 28, 2025 at 10:19:27AM +0200, Andy Shevchenko wrote:
> > On Tue, Oct 28, 2025 at 10:18:05AM +0200, Andy Shevchenko wrote:
> > > On Mon, Oct 27, 2025 at 11:07:13PM +0800, Miaoqian Lin wrote:
>=20
> +Cc: Markus Burri for the da9374819eb3
>=20
> ...
>=20
> > > > +	if (count >=3D sizeof(buf))
> > > > +		return -ENOSPC;
> > >=20
> > > But this makes the validation too strict now.
> > >=20
> > > > =C2=A0	ret =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
> > > > userbuf,
> > > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 count);
> > >=20
> > > You definitely failed to read the code that implements the above.
> > >=20
> > > > =C2=A0	if (ret < 0)
> > > > =C2=A0		return ret;
> >=20
> > > > -	buf[count] =3D '\0';
> > > > +	buf[ret] =3D '\0';
> >=20
> > Maybe this line is what we might need, but I haven't checked deeper if =
it's
> > a
> > problem.
>=20
> So, copy_to_user() and copy_from_user() are always inlined macros.
> The simple_write_to_buffer() is not. The question here is how
> the __builit_object_size() will behave on the address given as a paramete=
r to
> copy_from_user() in simple_write_to_buffer().
>=20
> If it may detect reliably that the buffer is the size it has. I believe i=
t's
> easy for the byte arrays on stack.
>=20

I think the above does not make sense (unless I'm missing your point which =
might
very well be). So, __builit_object_size() is for things known at compile ti=
me.
Moreover, simple_write_to_buffer() already has all of the gymnastics to mak=
e
sure copy_from_user() has the proper parameters. The thing is that it does =
it in
a "silent" way which means that if your buffer is not big enough you'll get=
 a
concatenated string. Sure, you'll likely get an error down the road (due to=
 an
invalid value) but I do see some value in returning back the root cause of =
the
issue.

So, the preliminary check while not being a big deal, it's also not complet=
ely
useless IMO. I do not have any strong feeling though. However, I think the =
below
is very much needed...

> That said, without proof that compiler is unable to determine the destina=
tion
> buffer size, this patch and the one by Markus are simple noise which actu=
ally
> changes an error code on the overflow condition.
>=20
> The only line that assigns NUL character might be useful in some cases
> (definitely when buffer comes through indirect calls from a heap, etc).

I think you can easily pass a string >=3D than 64 bytes (from userspace). A=
FAIR,
you don't really set a size into debugfs files. For sure you can mess thing=
s
with zero sized binary attributes so I have some confidence you have the sa=
me
with debugfs.

And even if all the above is not reproducible I'm still of the opinion that

buf[ret] =3D '\0';

is semantically the correct code.

- Nuno S=C3=A1


