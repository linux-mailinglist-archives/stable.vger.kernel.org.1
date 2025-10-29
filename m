Return-Path: <stable+bounces-191580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2427C1921D
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 09:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17ED546660B
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3AE313E1D;
	Wed, 29 Oct 2025 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q/MSmyNE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE32EBBB0
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725677; cv=none; b=bv+pYq8rQMiEvIolx7qJIL+rGC9lYMQvuObzFKECr4bRzPoHpk5YLZPtwQ26wPKEjJ2pU319h2yEw3SKX9N2cy5NAeOuRHoj74IxsoMB+qYI+wDlD4kES8/PI75U9/mqVJ8W+6wf2L3tYCc4XnP0ENlulEUg6WQHdslAXzD4Z7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725677; c=relaxed/simple;
	bh=N8+rq+xZPmi2I8g0y9aIjmTjbWxMyaupeqzQVgZxcEI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=udAQ/1nvLX7Z9hXjy/vRTPMr3fD655tPpvRN9co7kb0y8zgEGcqIBWeF3PaIWAbqpaCPtG6M5WVxxJXlN8inffQxejTSAUVgE0XcT7io+vPcWl4N6iKpyYM1Dt3JESolALIHN4mio5SAZCq+hWwGjcpvNM0Z5QCmVX8udDgDiJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q/MSmyNE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so6948648f8f.3
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761725673; x=1762330473; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N8+rq+xZPmi2I8g0y9aIjmTjbWxMyaupeqzQVgZxcEI=;
        b=q/MSmyNErSG3WrJuo8/S4qizy8/Mkzrlj/B7AzKZIy7NEkcpvM/f4ISfNOTyUnyQzT
         i+4TIwCi68sSruMXfSTxunglgueGWKTOgmsajVc5L37vhEj3h5UR6CzIJHDrV147VZDm
         +PPAm/jSQZNCOjFA4AGlkzHU0kq5sduBUe6brCmjZWQ1K4+tkvKYmB13b0YgdRnCk3lN
         gc5KZcE5Tn+DC7Ve0toGHwd3eAFKzq20ZLwc2OxJ8reXsbhjiXJkKQk1FR+WJg1XNWTk
         yTThh1FpCY2GoexZYjIm3umvwGarOwVk7B6AnhpHreWwy7vho0ShK+5Y5eegCOAGyIM7
         NsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725673; x=1762330473;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8+rq+xZPmi2I8g0y9aIjmTjbWxMyaupeqzQVgZxcEI=;
        b=DMYR3y28Wt+hwx0XJD+A3RklwfiXZWhBLwZGt2cznejaRH6Luy7qNyZBV8lpMHGtfp
         dlX+RQEdm2Di6Ncq0DFtA1z/JbH2LGnRR+kv8Dca/UEC8YurIYViSfuM69AukIFW6BFw
         ZngWSRG+RB0sCMPi3ly4QvmQomzHSC45vTlTY+dCh8M2qc3ULSqoKoCCdA8bMSgMy8rQ
         yO9rNJpnR1JyJ1WpYolc1ecKfeYRKEvo1kow94G76MP4VuR1LtqmlgPP5IpYgVy4+Z2T
         STC2ooyZqb4tP2YTGmgFTSq1OQxpQU+Mlk8V36CI7Yn+4WZfQeSxqcvOvR6UC56VRLJl
         fFBg==
X-Gm-Message-State: AOJu0YzWGxrzsFXMw2ALqZ/Z1uXbjIQHt/rJJPZKdox5faDRDrrp/FUl
	yvadvFJZRsqxTTCo+zpCFQvLG8gt09dQ+0hMiWuCySW1uzHblos8SB2ZcCyPF+OlxAU=
X-Gm-Gg: ASbGncsthqOAfJpOwxhP/1TnZHlXFtDeXTZwe0ML2iK33eE/GNC1DSNZ48W4sQ0fGsf
	JG6zpPTKspoyixJpMKJTmBkHio7M3CNlPju7/F5yiZX2i7+MUgrvzSpqwbMCFUfRCb2Hi9x3ECG
	VFCITmrV1B94Mm4L6l977f0kgYJPbOUcrTko8DZnjfeXqH0rMHC4J521x20j86gY9ew3SkGtGDe
	PEiBBccT3BsBt3mwmQlbJe4T7lSuNlSH6UtZGY0Sgp/JRy5iL96ahJ/UHVyeaCmjRQi65jvGds4
	4QMMcvVgDTGuMC4Jm0KMSbGE1uTUzWIaqVL+VIwr+4rIr3J65w299J2N8nIe7JQMKbmLV+jattq
	dfF9D5nnePBxYfO2B91KnP2LwfRSW4OXssbX7Y5l2XLrxmfHp/8vl0I1CRLbWEgZF3qAMjhvQFb
	kKjuw=
X-Google-Smtp-Source: AGHT+IEwzzvxzDwy2hXfDTMyKk2u3q3b4WDeoC3Cd1r42aF64N8QkWqyq5rTqATRPlQPagJ+AbKIrw==
X-Received: by 2002:a05:6000:240f:b0:428:52d1:73ab with SMTP id ffacd0b85a97d-429aefcd0f0mr1311537f8f.58.1761725672718;
        Wed, 29 Oct 2025 01:14:32 -0700 (PDT)
Received: from localhost ([195.52.63.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df6b9sm25774340f8f.44.2025.10.29.01.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=47d5f61bca1ab14c9eafcd8930ddd77eb5a3992e8bb0bd44140ee03f8bb9;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 29 Oct 2025 09:14:23 +0100
Message-Id: <DDUNMKXD4HRX.DXUT67S354TJ@baylibre.com>
To: "Miaoqian Lin" <linmq006@gmail.com>, "Chun-Kuang Hu"
 <chunkuang.hu@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>, "CK Hu" <ck.hu@mediatek.com>, "Dmitry Osipenko"
 <dmitry.osipenko@collabora.com>, "Guillaume Ranquet"
 <granquet@baylibre.com>, <dri-devel@lists.freedesktop.org>,
 <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Cc: <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: Fix device node reference leak in
 mtk_dp_dt_parse()
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251029072307.10955-1-linmq006@gmail.com>
In-Reply-To: <20251029072307.10955-1-linmq006@gmail.com>

--47d5f61bca1ab14c9eafcd8930ddd77eb5a3992e8bb0bd44140ee03f8bb9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Oct 29, 2025 at 8:23 AM CET, Miaoqian Lin wrote:
> The function mtk_dp_dt_parse() calls of_graph_get_endpoint_by_regs()
> to get the endpoint device node, but fails to call of_node_put() to relea=
se
> the reference when the function returns. This results in a device node
> reference leak.
>
> Fix this by adding the missing of_node_put() call before returning from
> the function.
>
> Found via static analysis and code review.
>
> Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort drive=
r")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best
Markus

--47d5f61bca1ab14c9eafcd8930ddd77eb5a3992e8bb0bd44140ee03f8bb9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaQHM3xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMY
BQEAuHoHmQztjd0qDVochaQgMwU/UDAYYFg9Pt2qLtKUZoIA/RVh2U8TuEbNs/4U
K3J+cqEkOl1LVK9aUjFYUv90UyQJ
=nF+A
-----END PGP SIGNATURE-----

--47d5f61bca1ab14c9eafcd8930ddd77eb5a3992e8bb0bd44140ee03f8bb9--

