Return-Path: <stable+bounces-118647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD46FA4067E
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 09:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B9E702BCA
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369B92063FC;
	Sat, 22 Feb 2025 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="OclUNiH3"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3B9201266
	for <stable@vger.kernel.org>; Sat, 22 Feb 2025 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740214734; cv=none; b=txxdvEPMgapyRRxu/LSZqQzne3VDO1mYnpYoDkP3E+o5+igctLUNdUuiCG9hW97UYxjLr1VikqdV3sh7tspvmHl6VcS0AGmGBF8G1wfBB29x9pcD9QfJb79E3L+egfio1l1xPeDmZCRFXdz+n5wraukCr66iuJElFDZb21jRqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740214734; c=relaxed/simple;
	bh=mh3nCFY6ECx/R7L+qv5N089tcUKlNcAdC1yqNRY2RIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwQML3nGgW0nqKhMeV37nIKuRuLT+YgQTFYvof1Lx2bpmmvkYI+2lNIIakHythF0HThwiIukDpeqHqs9zdDNY7QL0exEjph5UVWyrd4xz6skcent4ATa5TXzYpePpgNj8FGLGeIcFUIp0HuYpfn4Ko+l2q5UAOtGAmGuPfuVYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=OclUNiH3; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1740214730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zBCGz/4mccDi3wywElFAdLulgPYQyVr4aQAtH3U/r2k=;
	b=OclUNiH3+LGBquDDDnjLr+W4OHMH7zPlRvBbf7qIhxpbG7AXIgPGPJivW0dKVxIP9sHacM
	ptx+LtH9VvdhkvBNmfI34hNmPjt2MNZMCzCWmqpAbOFduexQES3e0K+bMTepz0pOuLFCcp
	CvUDWGDDmWQppOZeNmvunQdcBqRVoZI=
From: Sven Eckelmann <sven@narfation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y] batman-adv: Drop unmanaged ELP metric worker
Date: Sat, 22 Feb 2025 09:58:48 +0100
Message-ID: <3363381.aeNJFYEL58@sven-l14>
In-Reply-To: <Z7jclt4dEDLWc0te@lappy>
References:
 <20250219165644-edb7cfac3c0ce091@stable.kernel.org>
 <3614082.iIbC2pHGDl@ripper> <Z7jclt4dEDLWc0te@lappy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3369780.44csPzL39Z";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3369780.44csPzL39Z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Date: Sat, 22 Feb 2025 09:58:48 +0100
Message-ID: <3363381.aeNJFYEL58@sven-l14>
In-Reply-To: <Z7jclt4dEDLWc0te@lappy>
MIME-Version: 1.0

On Friday, 21 February 2025 21:05:42 GMT+1 Sasha Levin wrote:
> Ah, sorry, the bot only tests against "vanilla" -stable releases.
> 
> I had a backport queued up which brought in a dependency rather than
> changing the original commit, does it make sense in this case? I think
> it'll make future backports easier.

The imported changes by you are minimal and should be fine. Thank you for your 
backporting efforts.

Kind regards,
	Sven
--nextPart3369780.44csPzL39Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ7mRyAAKCRBND3cr0xT1
y2D+APwJFdtgQ+OxFtI+hWActQjXekBC8yQ9ff8G9j5GQFZ8iAEAn1gQWLMkcuAy
nEx2MSIvSOXWvKMhfcbvmIXhdWtCqg0=
=U1/y
-----END PGP SIGNATURE-----

--nextPart3369780.44csPzL39Z--




