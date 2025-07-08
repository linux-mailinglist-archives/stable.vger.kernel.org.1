Return-Path: <stable+bounces-161361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED84AFD888
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 22:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46D67A2B16
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 20:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801E020E328;
	Tue,  8 Jul 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="YDSwSr8c"
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F714A60D;
	Tue,  8 Jul 2025 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007150; cv=none; b=RJyhZsMAfRgJJZ1KboSyrFypnY8HbndjvEe+0QvifaeBxpwUegzQvsigypjjvCO2a6Cc70oiuWz4zADl6LUE8prO5XwaAv4mIBrlBdhXMzhrLECjVuTnR632+9xwipb4n9gAN6lBqVe0lWYfJG7UEKa/Q0ikFcYCgm6lJRFe+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007150; c=relaxed/simple;
	bh=hFJlKK5s+ALlx1bxUBj6AFGvaG27SvapXd8EvpxnuyU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CogfL1SfNMNJgf9D1Jfy/PPc6N9Z4Eq5zPALbV6v7LDad6Z22zibcvxBy7VS/ABQzVUtFXfm0rtvmPQGpJ4lWhLHRBaj1VbEK+ItKXfFLEgiY8yj2RbAzfFO/ot4yUQSPkew4eRYAfYNRtE89YsH7kSWJXXcdG5q7IwYYOGVuVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=YDSwSr8c; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5A2641C00AE; Tue,  8 Jul 2025 22:39:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752007146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=6B24c+iWxH0lEoo0Udm6wtaxcKxHvRUW1I9/BvE7FQY=;
	b=YDSwSr8cY+v7lga5P+BgQihnsWnvGUbDfuZ0O7uA1DbvCKyysjgeA7j/Sc5pNZBQyZFpr8
	QMdSd3cfZHyfywTuB88WWCmiH0Aggkj7keNsIE3gczdD1OyKcyyjsgfRAcQyu7PViib1GC
	vRRgPGS9vUAme+PT+YeCoL/CEb5YCEs=
Date: Tue, 8 Jul 2025 22:39:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: sashal@kernel.org, stable@vger.kernel.org,
	kernel list <linux-kernel@vger.kernel.org>, conduct@kernel.org,
	ebiederm@xmission.com
Subject: Sasha Levin is halucinating, non human entity, has no ethics and no
 memory
Message-ID: <aG2B6UDvk2WB7RWx@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UqJsqgXlndxKvP+/"
Content-Disposition: inline


--UqJsqgXlndxKvP+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

So... I'm afraid subject is pretty accurate. I assume there's actual
human being called "Sasha Levin" somewhere, but I interact with him
via email, and while some interactions may be by human, some are
written by LLM but not clearly marked as such.

And that's not okay -- because LLMs lie, have no ethics, and no
memory, so there's no point arguing with them. Its just wasting
everyone's time. People are not very thrilled by 'Markus Elfring' on
the lists, as he seems to ignore feedback, but at least that's actual
human, not a damn LLM that interacts as human but then ignores
everything.

Do we need bot rules on the list?

Oh, and if you find my email offensive, feel free to ask LLM to change
the tone.

Best regards,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--UqJsqgXlndxKvP+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG2B6QAKCRAw5/Bqldv6
8vFnAJ0YkenuTbBos/T2I2qxGD9w/CRoyACdGNiVJmEJWzVPgWKNnK7ZvsoE5Xk=
=K5CU
-----END PGP SIGNATURE-----

--UqJsqgXlndxKvP+/--

