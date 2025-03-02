Return-Path: <stable+bounces-120019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EA0A4B30C
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 17:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED01816B0E1
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 16:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E53D1E9B1D;
	Sun,  2 Mar 2025 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="xeawaxqr"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38B6AD39;
	Sun,  2 Mar 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932468; cv=none; b=KgbEStVayZ0qro/B6zxLjVEI0XBLdGuQ6sn430JRXlQ/oOnfO1JAEXt4YUbtis6I/IZEosSoWNgD7XmaC9csIXWBSphd2A+tFhg2xl/8IROiqJ6IKZGYfDVTN2PpwzjznMhtI1v6WYXyYutX2VbXjoFXq61+TEd6s8+PK4M/2mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932468; c=relaxed/simple;
	bh=XeFvcYO1xW0RYoDygaY65NVeElg+tDGA2A5xaMtjw1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5sZha+YbV+cYEHfg30Cm5MvBgZB6vnfkLnLB0qBlUJtzHb5ucSb1MO+IHY5kvgsLBdQ8GtoNsvNQsnwfcpGmCXT9E3I3CoNDuFSl2Ha+UXbOKPQDu9B4/mGnGBhVmDDMv6XPn0NrNE81qQz69obtGvt7wbpaSB7/Ryofn4qw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=xeawaxqr; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1740932451; x=1741537251; i=christian@heusel.eu;
	bh=wxjlczYOeQ0Rz29XrBvQbZzg4RqcGxTX6uX/8F3WtWU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=xeawaxqrLxrXQpOMkEv1/G8CJmSkkICX3BNiWfOknqzcq08wXfee0kUR0NjEzXB6
	 KNfIMAcPOwVvFsXbtgBZGm0TNFj37XzwuCnbFAFQXEixTzAbCv7JGYbHNyyXk11p+
	 k0woMuihukObMyRwDymDXXL/ssxWQ30jvlCNWAwfN+YCymyej1i/1U8UfadRsC0Ld
	 AIGk3P+imMf973pTKU6J8o16QEmof/VWY3LjR6r7WAVuKVyYqSA/OFG20OTSa9C7S
	 6MIU7y8PP7tjklH5FLpmRdVMA4F0mPCHSfp60zLyBSxQ7pQ3/GKHCiW7HJrj0QhV8
	 NXvI0sE9DqEU7fQK7g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M3UEW-1tpKHw3JBa-007gKk; Sun, 02
 Mar 2025 17:20:50 +0100
Date: Sun, 2 Mar 2025 17:20:48 +0100
From: Christian Heusel <christian@heusel.eu>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	Niklas Cassel <cassel@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Jian-Hong Pan <jhp@endlessos.org>, Eric Degenetais <eric.4.debian@grabatoulnz.fr>, 
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	linux-ide@vger.kernel.org
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
Message-ID: <17cd263d-c659-4cf6-b73d-61233bbe1951@heusel.eu>
References: <Z8SBZMBjvVXA7OAK@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nygsacke7dq24rl7"
Content-Disposition: inline
In-Reply-To: <Z8SBZMBjvVXA7OAK@eldamar.lan>
X-Provags-ID: V03:K1:0TtLKfLPGP8HsvgRDdBnMD25bi1sxQt93OUz7fdNdrGuGCLOxSt
 UfxvfPyFbK/2a6519HI/kjJ25qXwE25K3JSlx6fFXTib+Ph63qf2v9lNKnPoAHcB8BKO6zQ
 uz8kMYBRZRUppDkBTqmRfFpeFQBbuXc4L3/Tt0GDHoqH+Atnx4IVQ3lpLahsKQIMbjczfH3
 7M6xvSIoK2O5p0XT1bFtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:on5VDJ4shog=;Uf05YSP+qw7CwpBjnwHGUTFU84j
 ZNckiZmzM3IQgy/XcKpkxOWeWDWXw61JpuNG5XxW55BJucU2Zt0XPIAwwroKYsyyK7VUIGymA
 KAl/nQxp+6UtwYHi4NglI6R2a6PvjZy3qGvs1K+0gzylftKlUA4CODDbCYcETLCl/rUJCnv4W
 c5ShRHuOP5MtqL1805Q3feWVpTuAHEBH6cEJsZLXvDuuDZcbGvIIC8HHf1QbKacglMmvRmOyI
 wgqOowRAL2tOFaYv9Tv5N0xwtEsmckUS03KlbhpjQEm+r3RDHYnv0DmOC0NK3pspxCqs2hNdl
 f73sZ2QzxBP6eDQ6sbiBCqA0JYhdW0C9lgvzW7zTlEVZJlEkAiiAg53+QbBT+ehrWCNRwn7kZ
 LLXKMAnZ+kYB03+AH4nP+JBSP+Q1FdWyB0eaU2Q6ORNLFAfN255QYoPoN713ZktI3ewgJH2o0
 BdWqUexI0tJE85d4XqmcdJeovGuUhZGLGsFO1XDfJCFIIp1GasLiw09y/vHGM77CcPC8vJy00
 oS9RQSTnpMtivPFizuPkCtVsuLyu/RJPRArRFhuv1Bm30W5vyEkjLMPy2oyhf97shjpVu5HsU
 rGiUwg1BaJXyeUYx4mfwYKCHb9tEziQTeFjdw5oxOrSbTOAyZEqPh4qIsQOGS23xr7Q9XPj8f
 nWnYaGZj4kc2vqOSGQgToLOwYkr4uaNWzkhyLo4L0CMIjbIDtigRqYU4R7MzHuvR2v0olZspZ
 zLzVGXevqFdbQG/7YRd4uRnNEnQDVjo+pSgBqgqdog+9ZrmKm6UmwbR8nuyLM8HZ7lDmgzc9j
 f2SzOJ1YHb73tvpmvUgfYTwAET+ReyARLC2uDdZ+k36ybqzVsMYSwFCwL6jA27+niJWo4WVmx
 5/n4ZAQM21d17OBqVLdGoPbZt6EWUWs+ZZch8ho4B0vScW3+ebsoDxK9ZLEZGpi3Y7UfloW9V
 NYZSMTkE7j9BRdSyC7/8tv2yYLUMbWNvtQaiqiX8oeNc2n6twuHN4USk8wtlCxl6cZDUnQlbK
 BSSTbMtKVvJk0V/kcDG8VfDJ5xrTFq58qMIjJEFJhAkiv+WorqsJOPCD0RmxE3PL/1bnM+Ysy
 3tlsEKSuoOP99+NFK2om+LJQTWVsxXgC0EqklgnskrQiPCON3FHkcPoDIwSlgOAvPFi8CwHT8
 AswfzW1r9olXt4bYf/t4qQz6weWNLDfNgmw2oR1dMV/WG/rgao64Yngo74FE9EbU3kJh7gTqs
 +pVEIIjgKnVpCP2WupcOnPYAG0FVvZ6uxDqIGcMg+e37kcol0sJXvbZkS5gmLI4JYIE8+nGJh
 m7DBBrPWnO71PvBBGak8qndaIkSENgRp1pNCdPCAhDO+zmePWPt9dx+qg9KdHYry6HSGOwy/i
 5CM8nVEH/KZATQ1g==


--nygsacke7dq24rl7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
MIME-Version: 1.0

On 25/03/02 05:03PM, Salvatore Bonaccorso wrote:
> Hi Mario et al,

Hey Salvatore,

> Eric Degenetais reported in Debian (cf. https://bugs.debian.org/1091696) =
for
> his report, that after 7627a0edef54 ("ata: ahci: Drop low power policy  b=
oard
> type") rebooting the system fails (but system boots fine if cold booted).
>=20
> His report mentions that the SSD is not seen on warm reboots anymore.
>=20
> Does this ring some bell which might be caused by the above bisected[1] c=
ommit?

just FYI that we have recently bisected an issue to the same commit:
https://lore.kernel.org/all/e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu/

> What information to you could be helpful to identify the problem?

The other thread also has some debugging steps that could be interesting
for this problem aswell!

Cheers,
Chris

--nygsacke7dq24rl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmfEhWAACgkQwEfU8yi1
JYUJkg//U53jsCXbUJR7e4TgedGCsg1qdL/P3/J//zCliiZXYQh9FiaJH/VzLdUd
XFaes0H1FT2iym6nTiXg3ez+ewYRDhdyj+fY8vfnNOtO39W5eURoS/uvW2DU88h2
/+F+yHsSvTzuyKgO4jUozX4ydpQD3YChE4GzOGtkLEKp3452bSYFH/uOA7rTyo0j
iwVrnoS4FaQnWngXzBxUt8a9wLXFNBd0sd24gVNjQYwIJnUfwY9cD0mGhKr2Q5qj
BkkjQ8ype3YOmWJjvHK2hMicCLKyYqUnKDcJ2/5vnRTVJlBixSh/h+9BjXwF6k55
se8JZY4JqhYnmYw/dlbFPmvSNbQB/LoMHmDSYtc4byuxorkgL9miWFQ1w5B4zGkK
htLTcEj4J+Kq7TYKY0FSjJfjqnmu0y59BGkpZBiCjvPLIX44eppx8WdZBPaFMSlq
Ac0kqCaSI224QuVyLxNVReVJStPSaiWpy5zQedkSl6j7/32uCIQEa4CWD0B2b0Ff
quK1+sk/rJdIEv6dcW50Z4X4p6Siev7fkklp2ZT7NQRnyHTrFBxgOlkGXBmE7B+n
pMhHvpIsM9gC5RQG0m8mvFdqPV9OMt/f4PaI8Kmbu9fTXzgKyxCjl711CxfZAW9V
rI+XQHAsVSQxkc/3Ra+m0zi6NuWG0Mc1Dd9xU0jVb/vtEzeYM48=
=5XFo
-----END PGP SIGNATURE-----

--nygsacke7dq24rl7--

