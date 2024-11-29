Return-Path: <stable+bounces-95789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9F59DC1A3
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 10:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2FE6B210F9
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 09:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC76179972;
	Fri, 29 Nov 2024 09:45:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB375156C72;
	Fri, 29 Nov 2024 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732873554; cv=none; b=Tpg6TFjCcBGf0duF2h5quNDIO7v8803CsD0moS2lAnpjVDPJA6Lz6/yc6SfIZ/pNKvhms2BCNM6fpiiSKR0rSWGtFhk9StGs3ysoCx1NRrdsRyG4PpDU7s2vgt6mjagN1UyAnxZTbtie4ruSSwrLH5X+kIJuwFswb18VNHpplG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732873554; c=relaxed/simple;
	bh=kRVfmbkioIEYPAt9J2XdL7Rrn7z9wPrcbZ/w3hGFwpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWPZ3bUb5nJW+3l46VBY6RGvOkW/l02CvLvqMLaH60Aj+TxriYB3wM5uD0NDAHkt+mfugm6B3LwQ9hVPVXsMy9V/JweEIJ23QMTkvbJSQPz8rooHnccSKyfOC5rwlxj+JVn3tyUjYB8ZAazRDKXmJydBUxjtXuLjSKyNSDEQtnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5963E1C00DE; Fri, 29 Nov 2024 10:45:49 +0100 (CET)
Date: Fri, 29 Nov 2024 10:45:48 +0100
From: Pavel Machek <pavel@denx.de>
To: Borislav Petkov <bp@alien8.de>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, puwen@hygon.cn,
	seanjc@google.com, kim.phillips@amd.com, jmattson@google.com,
	babu.moger@amd.com, peterz@infradead.org,
	rick.p.edgecombe@intel.com, brgerst@gmail.com, ashok.raj@intel.com,
	mjguzik@gmail.com, jpoimboe@kernel.org, nik.borisov@suse.com,
	aik@amd.com, vegard.nossum@oracle.com,
	daniel.sneddon@linux.intel.com, acdunlap@google.com,
	Erwan Velu <erwanaliasr1@gmail.com>, pavel@denx.de
Subject: Re: [PATCH AUTOSEL 5.15 11/12] x86/barrier: Do not serialize MSR
 accesses on AMD
Message-ID: <Z0mNTEw2vK1nJpOo@duo.ucw.cz>
References: <20240115232718.209642-1-sashal@kernel.org>
 <20240115232718.209642-11-sashal@kernel.org>
 <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local>
 <Z0iRzPpGvpeYzA4H@sashalap>
 <20241128164310.GCZ0idnhjpAV6wFWm6@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6A4yexlJK1XvHMaL"
Content-Disposition: inline
In-Reply-To: <20241128164310.GCZ0idnhjpAV6wFWm6@fat_crate.local>


--6A4yexlJK1XvHMaL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > You've missed the 5.10 mail :)
>=20
> You mean in the flood? ;-P
>=20
> > Pavel objected to it so I've dropped it: https://lore.kernel.org/all/Zb=
li7QIGVFT8EtO4@sashalap/
>=20
> So we're not backporting those anymore? But everything else? :-P
>=20
> And 5.15 has it already...
>=20
> Frankly, with the amount of stuff going into stable, I see no problem with
> backporting such patches. Especially if the people using stable kernels w=
ill
> end up backporting it themselves and thus multiply work. I.e., Erwan's ca=
se.

Well, some people would prefer -stable to only contain fixes for
critical things, as documented.

stable-kernel-rules.rst:

 - It must fix a problem that causes a build error (but not for things
   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   security issue, or some "oh, that's not good" issue.  In short, something
   critical.

Now, you are right that reality and documentation are not exactly
"aligned". I don't care much about which one is fixed, but I'd really
like them to match (because that's what our users expect).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6A4yexlJK1XvHMaL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ0mNTAAKCRAw5/Bqldv6
8mRBAJ4r9M5WBINfJRwMswB8bSpU5UYgOgCZAShF/37413beKV0T0Xvz8GvYYjw=
=QCu/
-----END PGP SIGNATURE-----

--6A4yexlJK1XvHMaL--

