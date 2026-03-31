Return-Path: <stable+bounces-231412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOosHo27y2kpKAYAu9opvQ
	(envelope-from <stable+bounces-231412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:18:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A03695D8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B49C3040760
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42CD3E0C77;
	Tue, 31 Mar 2026 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pkQOni0K"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A73D8909
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959224; cv=none; b=uKmm7mPOcVbAgEHyWpxWYcCEBR3Mq0MhnZZja5I8xTju5SaPYgHk5QBMDGDmO36JS6WcaYx93cTH9VjEUvMVEMj6YU2xYbWPF8kT4FhWtZVq+hIhSQOtLAmB7XXm1B/d0M0XqSTTGZKGRjhz07UE0/HUmjzgSUJ4LgxbRCLfExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959224; c=relaxed/simple;
	bh=0Z9faOwXUmh9qLgJhY+ZBPIJVESNk4JcKVkmsZ8jSzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAQ9bcjh0OqCXBj71aJrazg52fvq7+7ZYzjHCrDOce2BZEn3RxRUXJu1odI7ndl5bsjc8gd5p9g26LnBkKsutEahGGAcAmQDJE2/8wnawlkMmmQ97YImkctKa2i4QKlZ4BvKof6bSbWEUT4S1+y8oCbouVOddjbM8+v/Yo1eTUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pkQOni0K; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 44E5D1A30B1;
	Tue, 31 Mar 2026 12:13:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 125556029D;
	Tue, 31 Mar 2026 12:13:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 501861045028C;
	Tue, 31 Mar 2026 14:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774959219; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=pQanRxNZVj5rjDHm72RB8zAUvY47FsQWhmsFM28fyzo=;
	b=pkQOni0Kzytfp/hYUnUFM0OgsFiePcP9VFooY1yzAMtgji+zUSfFbZ3pHYJ9mG9SfsMUk4
	axYh2j9+P+HGl9NlogKJRqZN+VnF0gRECRhMXWYtIEg2hztXzfwk+c9kdS8cDUu1n+BkKz
	maiD0ajt3LDA70dCZZ3a7QIcJwDfNRaHaGrrWv5qGChUS0ggrAky8BWwBHAYtj28EiI5vX
	JeYqwKSFVmNzE4kLmn+cpfw4npJf5aPnhpcv/oB0j0/zL2vJPyn9vJ5Yypcvlii5R+WKH8
	hvk7NwCV64lXjJWkIpdObcj+cGcUvA0//e9tGCOeI6o8q6fXH5i4pZAqga2vKA==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH] iio: inkern: Avoid risky abs() usage in iio_multiply_value()
Date: Tue, 31 Mar 2026 14:13:29 +0200
Message-ID: <12864533.O9o76ZdvQC@fw-rgant>
In-Reply-To: <acudGrFiD7TcAs3S@ashevche-desk.local>
References:
 <20260331-iio-multiply-abs-usage-v1-1-2ae8063e80e4@bootlin.com>
 <acuT8oTnaYujC0k6@ashevche-desk.local> <acudGrFiD7TcAs3S@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5978803.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231412-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.gantois@bootlin.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:url]
X-Rspamd-Queue-Id: CE5A03695D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--nextPart5978803.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Date: Tue, 31 Mar 2026 14:13:29 +0200
Message-ID: <12864533.O9o76ZdvQC@fw-rgant>
In-Reply-To: <acudGrFiD7TcAs3S@ashevche-desk.local>
MIME-Version: 1.0

Hello Andy,

On Tuesday, 31 March 2026 12:08:26 CEST Andy Shevchenko wrote:
> On Tue, Mar 31, 2026 at 12:29:22PM +0300, Andy Shevchenko wrote:
> > On Tue, Mar 31, 2026 at 10:49:59AM +0200, Romain Gantois wrote:
> ...
> 
> > > -		*result = multiplier * abs(val);
> > > -		*result += div_s64(multiplier * abs(val2), denominator);
> > > +		*result = multiplier * abs((s64)val);
> > > +		*result += div_s64(multiplier * abs((s64)val2), denominator);
> > 
> > Right, but here we get val and val2 from either static values from the
> > driver (when it is SCALE channel), or when channel has PROCESSED support.
> > In the latter one it might theoretically be possible to go till the
> > INT_MIN, but practically I don't know how, except for the broken driver
> > code in the first place. With that being said, I think it's better to
> > validate somewhere the multipliers (when it's SCALE or PROCESSED
> > channel). I also noted that for the _PROCESSED some drivers keep a
> > garbage in val2. That probably needs to be addressed as well (exempli
> > gratia: bmi270_read_raw() does that).
> 
> Actually the data in the val and val2 should be aligned with the returned
> type, hence the potential bugs might only come from the untested drivers.
> Which means that this patch doesn't improve the situation.

I'm a bit confused: when you say "the returned type" what returning function 
are you referring to? Also, doesn't the patch still fix the bug for potentially 
untested drivers which use PROCESSED?

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart5978803.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmnLumkACgkQKCYAIARz
eA7EpA//QF4nYAISxA0588PT9pa0oAm6cCa8txaDLpXYs0EUVlvXnBYijbK+rWy/
q/ooiddpwO6NfzNjvdt7SVjjOO5vH91nHTLTn7qlfa+0yLOgIMOBTItDzlLN15b3
lJ3z58CSkAuNO4RADkPXMbt0HJ6Jws1yy2MUH1Q/t9ju5oJ1WbynVYBrZzwLKsS/
S3ArOZfWW8yOH7emXiqkgERPoLuP+nRsl1fETWF+L3R4E+1LAk2QXBW90fcVwfbB
mCXh/0L9UdzPEua/pTt0M4A6zVpmwQOqpGAOjluGv3Kd1Ft0JTLjOaGPGOnL3jj8
Z0uekG4SfjSWjMzldzcj7+/z87pqTz2Wi3TrKy9Py0LWTHmLqcJhYtbUeEFDbB6/
bPH/lmJqQ+4QxhPTc2Bm0HTFztVkM+oydcxL+y3O8aD60IMFt4YbjPhUAYZil+DQ
yDusu/fSIV2Im88yadXjKkhiQP4BWHmqVc+j/NwY7WHeGMjRDinGSl99F0ZRt8lE
+nN+PobtLbo8+xGNXHcghA+LW3fJcMRpjbiqV/2KQJ+AErqnkq71bxuDryalWVUA
4vvheAXsibFo+kQW3L2VgygsM8DyMW3j84hCxS/qy3p0a88KdWhmo/kHPhSQaHnI
Lz3W+93s4JDVYqu8TvVEKF1EvEjwlL4Ej/sFHFa5kB/aJHjDaQo=
=4kPg
-----END PGP SIGNATURE-----

--nextPart5978803.DvuYhMxLoT--




