Return-Path: <stable+bounces-66289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C989594D67F
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 20:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525741F22BA0
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54402F41;
	Fri,  9 Aug 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="NipKB8yA"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1AC155CB3;
	Fri,  9 Aug 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228973; cv=none; b=VbkzzwmtRFeQQ61QovLYxmnNvs3HkzMT1Cx2BRoZD5O+323BcqEx7sIt2kMKgSwrTtZXQF1yjVDSD28f6k2VIf3mD9mk4FgnwT13LrTOjGqb6wy8ACMfkI9zQiZ95QSZry0BH/x07alsi/tJ6w6DzSr3o9WOdQnj5jp40enDkhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228973; c=relaxed/simple;
	bh=++5Q1VYKvXtJUJscG2q3w3Xg3TXoCvLyZdPWnHS9Glo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmqmGD6zFljD29yITs0RvgVbccWaWqYOEVKpCm0RuxTCg2qYUo06ZZYXUwHYwRHyexQeU02+S1j0s5W4UfVAc3pgy10aMSJmGyjA2tIBw7jTnRma99A2KQ3L3vvWlG6LIvlatfiHrCtQEXxFyHS4R55+Pk7IWrSJWze4EA/FGRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=NipKB8yA; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1723228946; x=1723833746; i=christian@heusel.eu;
	bh=9VJxNljMRbHuWlAL33wEBRP4XdGy3G5ZfaieYxNUqSw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NipKB8yAhnraXICoVCuEKc0MRQogeun5fyMYwxHMaMMcLgo3I7HhFclggETQXu19
	 JXiKeADF4o/mAXJ+hx9ihEQyK6Iye5nSY2rcXs+6WYA/95pexlStHHame8RUpuVC8
	 bxUyuhhc9efeS5pX9Mzfu5lV67rsMtmo8LBPBT88RPBpz5PBm7b5fxGfF1pLvMp+4
	 g9sPgYA0V/GEQb6o6WP183aqC2tEJmjmZchXYa85cjJdiwCI2opqV6/hERy+wA4h9
	 j5fBfpb38vf/Dn6ULoAss17fIT+bdUwNuuSu6lazSjSZVhrD0BUOTfLWQJGJTcZ2n
	 wlRg9lBc9LlfxttmPQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([84.170.92.222]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MwPfX-1sK8nv1hjx-00wJhL; Fri, 09 Aug 2024 20:42:26 +0200
Date: Fri, 9 Aug 2024 20:42:23 +0200
From: Christian Heusel <christian@heusel.eu>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Igor Pylypiv <ipylypiv@google.com>, 
	linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>, regressions@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED][STABLE] hdparm errors since 28ab9769117c
Message-ID: <df43ed14-9762-4193-990a-daec1a320288@heusel.eu>
References: <0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu>
 <45cdf1c2-9056-4ac2-8e4d-4f07996a9267@kernel.org>
 <ZrPw5m9LwMH5NQYy@x1-carbon.lan>
 <1376f541-bc8a-4162-a814-a9146ebaf4eb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ptudwdcg6mr7zqda"
Content-Disposition: inline
In-Reply-To: <1376f541-bc8a-4162-a814-a9146ebaf4eb@kernel.org>
X-Provags-ID: V03:K1:4kPBECwcfyBekMCXJyemCQew6S6+W8u03kFT1ejrE7e9dtHWcYa
 DS7JWAc/aa5waekKra8/pzD2Ecvm12+cN368ta2A0oj2EuO/RAf7gNysQ6bDRHSxYbZGQgl
 fs3xOxO5vhsZQ3cAqVGGDQVyE+7njkZyYe8nThDOs9FWfrmu0X8C333QWgJEXyQdRaqwp0v
 HFUsvuZrnRZHY8SX7lnmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8dCMNt/qDbc=;YKd+L8XFNXrlaxOjept3pkVxcnD
 lg0aVRzlnVsYHSdGrEjbOLu/n3YMnqA129H6vZfY8u+Ro5PpkL5lC2+xIHBYQjV3FFEG2kuyr
 33HC0iDT4Dj1McEKWlKrL7IHhm8QKH8UJm3+mUefGftr7uHknUrdnkaUdrZo9sbKMzQgu86kI
 ASEWLfTPJu1idicC5Sm+DwX8IwJbqTJyBzdjn0RZVJ4xIf2CEoRyWDR4cDALqPOP16BWvpmO2
 oJxPLy7Pv5tJm23iTPuhfZUKIAmUZELay0o0fjtVHoCeIQr4z78k9hTqRiT4j+OEfCBbh38pJ
 n95z7DrJL0mhhACnH8LWLWfru9d03045LQVuoDP+6cBxjg6zfKDmlsUjyh2Bfo1dDyPtChyS0
 vyyyP9Le6xnSDnZw5nT5JvS5r2SQ7U9xRghrsWR0qKPUDoZWhLzYBCwPEedwSSdrq5UHGQLj4
 BTfB6qqVm5KU17XuD3xiFLke2Mx/QgvISfbjUn8HVdDNWsgXXjVTOBVgQaHCpoxZH0IWNcNcZ
 Rd/M7gxMhJyeMDMoZwl+B9BR54SF03UkaW9VH4XBwnp8zj6kzBFecPLqaLk/1yY/nTi2fOu1x
 skUKAxklp82Q1KL3IV3MCpIpVNcFOI7Gh4sL+Mn52eKYNm/i7C0S1O2FLqiLuGyYD+VXASuMW
 w/qMOX+vASqAVtkCmfArxB46Xs0+NaPwK339atecBUDFKrJ5PueQg7Gmkk+Sm5vQ1qz5dyQdk
 5pAqcOnazJe/+OdY8VSzulFiyzNt6adpA==


--ptudwdcg6mr7zqda
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/08/09 08:34AM, Damien Le Moal wrote:
> On 2024/08/07 15:10, Niklas Cassel wrote:
> > On Wed, Aug 07, 2024 at 11:26:46AM -0700, Damien Le Moal wrote:
> >> On 2024/08/07 10:23, Christian Heusel wrote:
> >>> Hello Igor, hello Niklas,
> >>>
> >>> on my NAS I am encountering the following issue since v6.6.44 (LTS),
> >>> when executing the hdparm command for my WD-WCC7K4NLX884 drives to get
> >>> the active or standby state:
> >>>
> >>>     $ hdparm -C /dev/sda
> >>>     /dev/sda:
> >>>     SG_IO: bad/missing sense data, sb[]:  f0 00 01 00 50 40 ff 0a 00 =
00 78 00 00 1d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>>      drive state is:  unknown
> >>>
> >>>
> >>> While the expected output is the following:
> >>>
> >>>     $ hdparm -C /dev/sda
> >>>     /dev/sda:
> >>>      drive state is:  active/idle
> >>>
>=20
> Yes, indeed. I do not want to revert any of these recent patches, because=
 as you
> rightly summarize here, these fix something that has been broken for a lo=
ng
> time. We were just lucky that we did not see more application failures un=
til
> now, or rather unlucky that we did not as that would have revealed these
> problems earlier.
>=20
> So I think we will have some patching to do to hdparm at least to fix the
> problems there.

It seems like this does not only break hdparm but also hddtemp, which
does not use hdparm as dep as far as I can tell:

    # on bad kernel for the above issue
    $ hddtemp /dev/sda
    /dev/sda: WDC WD40EFRX-68N32N0                    : drive is sleeping

    # on good kernel for the above issue
    $ hddtemp /dev/sda
    /dev/sda: WDC WD40EFRX-68N32N0: 31=B0C

I didn't take the time to actually verify that this is the same issue,
but it seems very likely from what we have gathered in this thread
already.

So while I agree that it might have previously just worked by chance it
seems like there is quite some stuff depending on the previous behavior.

This was first discovered in [this thread in the Arch Linux Forums][0]
by user @GerBra.

 ~Chris

[0]: https://bbs.archlinux.org/viewtopic.php?id=3D298407

--ptudwdcg6mr7zqda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAma2Yw4ACgkQwEfU8yi1
JYXAQRAAv9TUqnuZ/OI7N3unkZfyQFbfAWEcf5ex4wpw78jUNQqd9b6JNZ5c4nVn
eF/Vn4ge+xuQAzjv2QeATsibRVY+61tENkNq06fHavugICCu8Mij/h42hgFQ0Pob
G6dtgo/P7aFl9123von4sZJevtn3YvtTfq3AcJZdGgEvivnSeQvdQ2i6E5BiGPk/
bypLY9+RUNHT5ZMix6tEmfEPsBI6Px1gzS6oRG2CFfQ2H0nGqiBK5wMLH0goijLx
sPBaHf9xgC15SDvA6q4v2LZliG2vS5OUsRX+HMDhoOGi5agFN02+L8X8Ic0iBZmK
eY5eKrMXPmDYlLxF3y2KmqMd1Fie1eQ7fnDogz6ycq2Yz1etDCJvYNqnALOTzQBi
jyLlVD3L3GH2e0dhsGraVcJynWbUdz1cbmLeYcFP6SEkLtKMrhgY8jVWuFLdxPGo
r7su1c7dCZSDg9BOrz4xuu/ELD2BRinWEh89CFDBiV1bwT5gluGMMHV2UIIhQ3hh
DbHYNzdBe+gXyYZTQi7T0sQiP86+LcTFF7He5whhtEgHRLJbrMJmd8pIdrZ/CAyS
CtDpWT+0W6NN4ZyDE5C0PxtJLus8klIVDyUWorvWwJ0qpax+Ox565Onxjf7+Hs7a
yTsvxqcGdj+Q3C+l7rqFf5+odAVWjewprtewftHUBCUAtCn+XRE=
=TnUX
-----END PGP SIGNATURE-----

--ptudwdcg6mr7zqda--

