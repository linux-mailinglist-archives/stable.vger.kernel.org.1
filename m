Return-Path: <stable+bounces-194884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E79C619FF
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 18:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E693B7F2A
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ED430FC3A;
	Sun, 16 Nov 2025 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEGwZjgH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D55430F7E3
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763315413; cv=none; b=TGhYOqLmZshr4LU9JTN9m7hnHLExifQCu+qtSmW+OYsSvQkNGilR1zVYRH/1XNWlRoRJS2ZUWfTwbovjMVaVG3sSJ7J/RuYsaWIAYLoIWAYt2Z4sn8Zr1sN8fjCl1s/E7ePc4/DftBwjvxHJlm0MH0x2e4/ef7dr3luchtRSuYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763315413; c=relaxed/simple;
	bh=QP7jspNMzyTvkGv06BWTHIjJjU1oOmLPoesgjcHxeRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WA/7o18UO19wHR7h7trOf9janrT3tXD/XINQsaZKwiBL/dFBTb2vtbjP/GiasNVSyAKxpIheOPZJvjybKQAkkOfrIBRyikFA70a0OveOse7bjKICcwyraLlbB2MWbey90geEwb4mOpLgzWrmX94NnkcNfUAH8xxBb0e0Z+P/VqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEGwZjgH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b728a43e410so585521866b.1
        for <stable@vger.kernel.org>; Sun, 16 Nov 2025 09:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763315409; x=1763920209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP7jspNMzyTvkGv06BWTHIjJjU1oOmLPoesgjcHxeRo=;
        b=cEGwZjgHJrnW5n6GJ5zi0t6emQHqYc2EN7FzgHa7VOIpWYCgV/XkSKH6f+myoOgy7a
         QKABIKtnd6EQXdlnZBZgTKndkhn/wRUg5ZhbMJyB4toXaWi4wbwdi+aly3cKfyFbxozo
         rQ4iCzm0F4K0OedHm9IQtIxvzfEIoVzhT89QCX3Qf7CLRdKLDnYxZwt7DEdSC8pXqEHb
         OixieAAeRrcUj6aoLu6eXr5aGropaZU8HLNcDhNPxIyn4R2YMYfJpI18B26kvkgCQ/Z+
         GqQXAf8Dr7R+bm4+T2nXllCUa6RcK/Mre7VZ7vdM6E8lPyv9vRzJJYD9GLoBO/LDPvaE
         AcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763315409; x=1763920209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QP7jspNMzyTvkGv06BWTHIjJjU1oOmLPoesgjcHxeRo=;
        b=TudF+ME6GVeA7oJPeDtaGEMQIBBfdTTfrnNeLnzuY6DK/P4nfC6xxrBKKOKbFfBfSh
         WT3B8PHumXO2TOA4D+w4CTxvgMf3GzbXG/2xMznLRuSSwOj5Lhubm2b3EuWZTyShXYXq
         lV3PquSkhBRUMKDj5rqQORIg4z34OeyRh5iDkhSb8XDq4vp3SSK3/oklGKxqIIntqKoj
         T102CFotKNDjcdPN4ZIMb4VkN5UhkF8xR9/i7E7NrpkYra6M4eTK311J+33WNUvyw6xo
         hwfTXfmUYGgVPcJDEDoG1cYpvckj/52eePZQRZZMh6RTJ/HEHaj5wMZ2ZfJJPz5a2xWm
         dIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkd9PfaI+O2NzChdDW1w+ivgDFvxh6Ge+pCgUs7Er+mtje6bEmu7TRswtTr2ab469qsMiK+UI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7r5DLIUr+73pKaYPO4k/0S+wRYI89S5bzVixX+EAF74ZbsmFK
	I2gQTany/DtwmI3oFzVUEwJebu4xa41vXfd2ZrhXpjvekGgDw+Ulwp6f
X-Gm-Gg: ASbGncsvysI0z1MCuJz8Zpq8utUWXE1o1KGAzYH4TZjVUrD7hg6lsuvUDTqlE/uTkuE
	UlxUlmlH0Sj0eMWmXcpCgR3pOT5+bqVMsGUaG2+xfNRIzc18t6hhtn/WOS+N7rMcHsuraP94buA
	OShmOcV2ba7F0LRe1/ETENEOECuiGGLz/eZIOZYMdSD3iuDM8EBz38C3/bDy9HN6noRTQ4XjUhR
	dGb2Y58rrwILFPF2dLnv6nh6iuIti87PQgT2Rx0vRnuCV10BWB2ScTYyHEe5YAHYVu3vnnEdYVq
	CdQHQbHXu3W/ih5xhLO1zJVnhMWcUFQoWDKSa1brGcbgV8dC+UKLJARLuaa9Lo+wo2CNwBvzlqt
	fLCzMnBXUobF8aLuJb+fXCWGq7Gu0PjDDN2VrH51M2ZMIHaPp29cg516f9ZMVg6rYe5qZU3Hoxh
	YOm8VA+SNhnbfOGGRq00ZZ+Djnit0TmUSCiymPO9izM4wBl6QRII1wTImuBRpyr6H1auea+4DxV
	lybNQ==
X-Google-Smtp-Source: AGHT+IHnJ3o0lU2xLaeiHwgSeukdwtR1KGCz5g9vsnkLKv/heK41BVWAROvmPtIvPoJ/A4s01hmsSQ==
X-Received: by 2002:a17:907:1b1d:b0:b3c:3c8e:189d with SMTP id a640c23a62f3a-b7367b8dd38mr1112936266b.32.1763315408563;
        Sun, 16 Nov 2025 09:50:08 -0800 (PST)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fed9e9fsm879409766b.69.2025.11.16.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 09:50:08 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
 Maxime Ripard <mripard@kernel.org>, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Thomas =?UTF-8?B?TcO8aGxiYWNoZXI=?= <tmuehlbacher@posteo.net>
Subject:
 Re: [PATCH can] can: sun4i_can: sun4i_can_interrupt(): fix max irq loop
 handling
Date: Sun, 16 Nov 2025 18:46:51 +0100
Message-ID: <5938604.DvuYhMxLoT@jernej-laptop>
In-Reply-To:
 <20251116-mysterious-delightful-spaniel-18d220-mkl@pengutronix.de>
References:
 <20251116-sun4i-fix-loop-v1-1-3d76d3f81950@pengutronix.de>
 <2804881.mvXUDI8C0e@jernej-laptop>
 <20251116-mysterious-delightful-spaniel-18d220-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi!

Dne nedelja, 16. november 2025 ob 17:26:07 Srednjeevropski standardni =C4=
=8Das je Marc Kleine-Budde napisal(a):
> On 16.11.2025 17:20:37, Jernej =C5=A0krabec wrote:
> > Dne nedelja, 16. november 2025 ob 16:55:26 Srednjeevropski standardni =
=C4=8Das je Marc Kleine-Budde napisal(a):
> > > Reading the interrupt register `SUN4I_REG_INT_ADDR` causes all of its=
 bits
> > > to be reset. If we ever reach the condition of handling more than
> > > `SUN4I_CAN_MAX_IRQ` IRQs, we will have read the register and reset al=
l its
> > > bits but without actually handling the interrupt inside of the loop b=
ody.
> > >
> > > This may, among other issues, cause us to never `netif_wake_queue()` =
again
> > > after a transmission interrupt.
> > >
> > > Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support -=
 Kernel module")
> > > Cc: stable@vger.kernel.org
> > > Co-developed-by: Thomas M=C3=BChlbacher <tmuehlbacher@posteo.net>
> > > Signed-off-by: Thomas M=C3=BChlbacher <tmuehlbacher@posteo.net>
> > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > ---
> > > I've ported the fix from the sja1000 driver to the sun4i_can, which b=
ased
> > > on the sja1000 driver.
> >
> > Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
> Thank you very much! I have seen a lot of feedback from you about the
> sun4i driver. Would you like to become the maintainer of the driver?

As a Allwinner (sunxi) maintainer, it is somehow implied that I help with
reviewing such drivers, right?

However, while I never used sun4i_can driver, I know CAN protocol well
as I work with SJA1000 compatible controllers at work, so I can help with
maintaining it.

Best regards,
Jernej



