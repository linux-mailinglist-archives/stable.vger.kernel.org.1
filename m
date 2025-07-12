Return-Path: <stable+bounces-161751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E90FB02D03
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 23:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6D21893A4E
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 21:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5F713AA20;
	Sat, 12 Jul 2025 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vVg6U6mn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1657C2E0
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752354022; cv=none; b=YYqa32F7f/Z+HgdoArkPFDQv3MB/Aqi4clQ8k1F9gnT1wZvpZxiBCx42v9PJwM0P0gpdlm0q0lYWkG/mFt9g/M8ZBAKd0ZYXpMEy1UpyVaolB+VyQN+6b/4PpymqHVRChT/Vxm1Od06bNUvE35DAU47GoPMdM521BJS7oG+4J20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752354022; c=relaxed/simple;
	bh=YOCye7RNjet2KuZ0zkUQtl7/kruqqFZuzgc6rzdtHcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgAfzaXK72OvVXf5ITbEP3WYRDU7pRbKqbmzaYzZpWm4owRsMd/D221tuhAcl9E9uGc8OGaOpXYsJHcLZ53OJINNaARhIVXts7+jOn30Qon3sCB0oFXvRQtfmEJvE2Ap3M+CiK/bmEZNI6APljcWoJLNSsw9mQK4jilP5CwTMpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vVg6U6mn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so650095966b.2
        for <stable@vger.kernel.org>; Sat, 12 Jul 2025 14:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752354018; x=1752958818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YOCye7RNjet2KuZ0zkUQtl7/kruqqFZuzgc6rzdtHcQ=;
        b=vVg6U6mn7trzjlW09ZPjwHqHanXUUjLwa5wQXIszmxLhpi0xrLBejIh5JjDT4fHrsp
         HQJ6kJXlf1Ztmfdv3jK2+n/Z/dkGhFGI+b476j24ga/Or0WtzPTEe3k6U8VmfIbNmPyj
         /zOHBbPgtB4/TW31unL7HVHTqa1nMtSSNchvg+fdj0tLl6owpXtuFxzIPfScF7ZbytJw
         gnViFTNI0zB0gotwnWSgTGcaHdhhOPT11OUj70axaBXH38Whj4hhWrhz1uwlACvzRmZf
         g1IxTcaHZ0Wi9U1d5EHTfXIeJQRYPgkAe1TVG7E7Ir1USIwldxmlaYYuXkEATi9CQQXC
         kF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752354018; x=1752958818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOCye7RNjet2KuZ0zkUQtl7/kruqqFZuzgc6rzdtHcQ=;
        b=D3mXa4gSg+UlP5rwDoijbxZW9q6uxhKjiTipvNql8EvRJ3yqRWPR2fGocO1i7mTaOm
         AVaTn+JoEfr7SBJZzyS3z4niDqnJbfDK7V+vj3NgyR2kO6c9tLaolmx+Ryf0BILiUlRx
         QJIto8RJ4mP+vzwMMq+Ed+fBcb1emnIQ6LEybYIDVcb5/RKOKxDxBITTX6VhzfpUOgO0
         KVUuPijQXf31c8sNeTVdHcx54iyRgnM+uD2HH98LgOeiD6Cp2KaNi8MHd1CRheHRT5gC
         L/lu5KkNprwvBfYhmZ6+0iWxBv5dSdf2J9HbKhYQzNGccOt7LCYz/vsY1oC53XCusIdz
         Czfg==
X-Gm-Message-State: AOJu0YxaiIyagZWM7WeYWKNdABY+diM/oJCkqbOJV6w43ayBc6xH7wW4
	UJUoHMlkVONhJ4h4NGzV0SIoMeSVnl/5+MhS+CVGiUBJAQwekUrMzVzb1n10SMybagEXO3pd9do
	razb3
X-Gm-Gg: ASbGnctMwe3lVPVN4CxB3Bu1dSKF38bM6WdcaIvI9Ej3oc51G8PuN/GjG+64yij43EU
	wAgVc7T9k0ztgDPl2B3QF96AhXn5hxV5zj2v+o2CtPj95x5vFRdKsi3oPoARes5gPuo+j04Iees
	BEZcSlTliQ134r1mikXieLcuby3Klxf4U5udyDBOoLZDQ+B7tIcslfMBhgA0gspE77T7YcL42Ml
	1KWh52hXXrbVB939cIPZKkbBV5jvaZSUtfmeQmSzVrpXyqlobiwI/nfmVk+Hn6eeTxmYmf7PRHa
	J5W8Ul/qO2uvrNT26saXheoCcuuOGiPqSWxPykNaGgLh27SftWqrNmGDcz0eTSv7RuHkODNECgT
	d0qifufbaNiB+TFzcdjepWwo2jg21bXDybPWL3Q==
X-Google-Smtp-Source: AGHT+IG4L5XJGQEMfpp4bV3gSTypOeiSD6KhIOVKFRU37Ym9v0AcAjVDKxsQvJ3hA5yaJxG1DayS9Q==
X-Received: by 2002:a17:907:cd07:b0:ae3:64ec:5eb0 with SMTP id a640c23a62f3a-ae6fbc55069mr796640766b.11.1752354017921;
        Sat, 12 Jul 2025 14:00:17 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae6e8264663sm538692066b.87.2025.07.12.14.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:00:17 -0700 (PDT)
Date: Sat, 12 Jul 2025 23:00:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] pwm: mediatek: Ensure to disable clocks
 in error path" failed to apply to 5.4-stable tree
Message-ID: <ensabnoqktuudz4ohh3kyi57p7us2f3td3vascmtkvknspnpyg@jqpgnwokd3tu>
References: <2025071236-generous-jazz-41e4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b3sqpfgpkoduj444"
Content-Disposition: inline
In-Reply-To: <2025071236-generous-jazz-41e4@gregkh>


--b3sqpfgpkoduj444
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: FAILED: patch "[PATCH] pwm: mediatek: Ensure to disable clocks
 in error path" failed to apply to 5.4-stable tree
MIME-Version: 1.0

Hello,

On Sat, Jul 12, 2025 at 04:00:36PM +0200, gregkh@linuxfoundation.org wrote:
>=20
> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-5.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x 505b730ede7f5c4083ff212aa955155b5b92e574
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071236-=
generous-jazz-41e4@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

the patch I just sent for 5.15 applies fine on 5.4.y. I assume this is
good enough and someone will tell me if not.

Best regards
Uwe

--b3sqpfgpkoduj444
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhyzN0ACgkQj4D7WH0S
/k7JVAgAgIkzqhleT7R1lcucTlt7lCEXJB4xWsnpB5d4KZqZcmS8uiYjCDCeGzvg
a/ydHAwc6Obdl+wBMAEIbtwArohb8OXjpgwE3xIIhnVkS++OfxXsW3z9gqwJPgi2
JJqc8U25gYxi3k8Ep6vFO405hG7Nf6sPqupPVBBFIT0U2oGH2aqndLX1d876sYDj
7nb4Q4WPhbg/Hb1i1L7MHUh7KqOn+nuVrzHQngHj4w1D4aOZ9dzW3iwZKVIlr0PR
uInCPMBJJNdaWuYh8maJNkxoqJhJX45+ASzfNhK/GGESJyV6w0k9rgqud2misi0n
DiNxwEDBTMqRYvISELKjKyMjtzlK0Q==
=Df+v
-----END PGP SIGNATURE-----

--b3sqpfgpkoduj444--

