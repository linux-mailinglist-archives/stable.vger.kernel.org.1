Return-Path: <stable+bounces-204519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E90D3CEF747
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 00:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42B9A300289A
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 23:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0D22D63EF;
	Fri,  2 Jan 2026 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YogeuQGi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB8F229B12
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767395139; cv=none; b=Wk2ofOzmjadzJhhMgagnIj5X154MqMkr5UCGAoicMctI9f3xme7+ihDT+OyFgDzeiN2sr77bJP9fm/qq30iv/bL7e567EgfhGsAm8PpAcHG8pbQphxfEPxhi/H7IJ0qYM2oofR21ORvOx/Ih8Tk1iBPB4ngh6AcPHLBC/GKI4fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767395139; c=relaxed/simple;
	bh=zN6ndZGvkiNHADlj/UU03wS0UCkcDL6Fte98pyU5dUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAnjzzXb/qAQ3kjsz7N0eqAKDMwDG9S1JIXxEo5+aU2th02YU9Pma/M++0IPGUoLHaw7zYyM+9zGi13tzazyTQQK8I2kW+/1++B5kMFQ0rVO7iHu3HmAQvLo000Un32Heb5NPXUTJwZKSIHq/EMyzZeWlZ8nnvBRxlKHdKT/YYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YogeuQGi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso40215105e9.1
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 15:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767395136; x=1767999936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gATuC38XoDqmbs1Y0VN60Xh8p2YBvlk1d2ihfjSJrZM=;
        b=YogeuQGivcC5qzhq0j3ioAPEk1i5zfHMpabSxKDXKwpN0LlFjBF9DI1i2MakPaE1cr
         Id1ela4IzWjRebzHWigDPWs8ZZPPCHZHjYQEouaQQNRIDhoyktWRPjQXR/bz4W4FXqXj
         Q45+eCTSqq343sdWjr1UwsJT0dXVy4GvkIZjUlHmR2mdMBdaa7xbNq0mNrDzh+nRbPTG
         RrAy+lmkW7mHgONja210mnS0yUmk2DO/SPCCHi/JDh1vJcfgU7ziRteBze8YxF4PNnd5
         rT5qpt+0JMRvBq53LAtEeYDFe2kDI8akeHededh+go/j4lI7AnKGqCJinEo/8C9qrtDm
         QkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767395136; x=1767999936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gATuC38XoDqmbs1Y0VN60Xh8p2YBvlk1d2ihfjSJrZM=;
        b=k/qDl4NBDumhDzvejgZ8bDMoL219xKzuXS6uRHz9SKiMLW/6eAZD+G56JBsYu8h7pL
         wsQnGTlE6FCAIXjMjozAawWGYE1gvQs6Il5voxRCgKkVEc7zMhoJi3k0c2bBDv9cP71J
         cRTVbpGJzSCNpkdol8KAXXGQsP1ziXoLkIsat8pznB+XlEX1PYJdhbj9ZC4eCTSTLzRE
         sbZN3vvzjC0f4DtuCeDTRW0dRNUPfgnIL6DPqrDo+SBW+/crIYkT2duq9fcqUYoNWyu9
         qZPRmGyEPNdwksbxHOYehDi1ZS6Eo65Q5HQKdvwoRYxI0LB7Q4cZENaX74cViaHkKEXl
         qr6A==
X-Forwarded-Encrypted: i=1; AJvYcCUCXw8MDkrraSGvYAELaGAmabTYqMuwDarRIUyW6GDC9OUHi0GVKnqpnXoQHWCcJmyB499y3jA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPrmjzvYy3TC+9M8a2oPd0kNdNRYATHnejn/iOAoFSyIdeLMbX
	TRRNLuKfOSzeJoN4Y//blnEtNlPdB/j/N2mUdzYFSkSAmH197yckfldC
X-Gm-Gg: AY/fxX7cPnLaEzKCqqx8C+b83NHSbuafL7IBbivDfRYjCWr6VN53vggGkefkMpQR7zD
	1g/Y4Je4bTbZCGkxbsY85MhrLqNtquoLQOWLMF66aBqB+7UCOnFHYILgavR7y6NF8R34WUtd4xG
	xRy5FxEloxGZigNhIZH8O28X69r7xlojGJgRXFPmibZr3zySRnq7THLWJytuN5TtrfW+TzQ03GB
	js0KOU+Hv+COGeFd7+dwp7n6d+NtTwH7ZFyAInE7K4Jdd0VEyvbLeeaT1qD3KIQNYMNjhobYsX+
	haykwsL6iOEjnG/EgBWNwmm5XaNahqXSKjr65Vni9MQHgvAjJpSaOfrpVgrd5uaGp+h47ps8Ytp
	me4QKK4Mzb+S+lQbbb0vWwx/0NakiHVxA6vezANdLg8KC1mhHngwQGst2+uQ50UplzoV8gs5bw+
	F8CHuGBMSyzgJZRlZRnU/uC2qcCa9umkZ2yKMJtvWtM+5tRI/SgXjM
X-Google-Smtp-Source: AGHT+IH496nx63x7Ywh5WtJLuS+N+LqIyhglkqM7MecPJHigBzdkDAY96pkr8teZzNbzWf1tn9XsUA==
X-Received: by 2002:a05:600d:108:20b0:477:214f:bd95 with SMTP id 5b1f17b1804b1-47d1c036d6cmr411887275e9.23.1767395136005;
        Fri, 02 Jan 2026 15:05:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2278dsm88571673f8f.18.2026.01.02.15.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 15:05:35 -0800 (PST)
Date: Fri, 2 Jan 2026 23:05:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>,
 Russell King <linux@armlinux.org.uk>, Andrew Morton
 <akpm@linux-foundation.org>, Russell King <rmk+kernel@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>, stable@vger.kernel.org
Subject: Re: [PATCH] ARM: fix memset64() on big-endian
Message-ID: <20260102230533.4fb1d8ef@pumpkin>
In-Reply-To: <aVfirJvsYt0-jDRD@casper.infradead.org>
References: <20260102-armeb-memset64-v1-1-9aa15fb8e820@linutronix.de>
	<aVfirJvsYt0-jDRD@casper.infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Jan 2026 15:22:20 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Jan 02, 2026 at 08:15:46AM +0100, Thomas Wei=C3=9Fschuh wrote:
> > On big-endian systems the 32-bit low and high halves need to be swapped,
> > for the underlying assembly implemenation to work correctly. =20
>=20
> Heh.  In my heart, ARM will always be a litte-endian architecture.
> I'm not really surprised this bug took, er, 8 years to show up; big-endian
> arm is rare enough and memset64() isn't much used on 32-bit systems.
> And it turns out that many of the users pass a constant 0 as the value,
> which was kind of not the point, but it seems to be an easier API to
> use than memset, so whatever ;-)

I'd have thought that part of the point of memset64() was to remove
all the 'alignment' and 'tail handling' that a normal memset() has.
Clearly someone thought otherwise :-)

	David

>=20
> > Fixes: fd1d362600e2 ("ARM: implement memset32 & memset64")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> =
=20
>=20
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>=20


