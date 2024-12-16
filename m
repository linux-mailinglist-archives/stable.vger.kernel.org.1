Return-Path: <stable+bounces-104388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC679F3792
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 18:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D4F188C3C5
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31CB205E01;
	Mon, 16 Dec 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="rry198nb"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811CA81ACA;
	Mon, 16 Dec 2024 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370190; cv=none; b=TgbueM4CGbYAh8Gc/aMhsQWn672lE4vYLupQTBtHxf/0tIj6BNam6jJdIEbxlBxSFPtYoTzswAljBKkiQCqmtCcvclvU3sBwN5nOTeWEmQKiB3+4GlnCa49dGms3VhKC/Dq4ZY8MQMKxtiuln+K6y+WzlitxDt1nw+d7vwDTkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370190; c=relaxed/simple;
	bh=Aqp5JQUyar1Nhsh0hfXQQWR7hCjBN5RQcuO1OxMhWjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFCpq2dJlemgXpKzPZ6pGbdEAIaoJOjYBu/zQgLi0UhitIeE2ZA/2QoLNin859t5sEwSgpoYqBGnKUZoqEkBYS6LRC46jlMn0eujlxgzdPKdHoKNW7ajXY/PBJyFmBT1ttQ8nCGOuU7GDdPNu7HYscunXxKFZB00QkT6OkCeoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=rry198nb; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1734370177; x=1734974977; i=christian@heusel.eu;
	bh=XHTOXjtFzX3uG72tT/c/v8D3oa+Tv+PlZ4tb+OBu6SE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rry198nbYYNUczk4IXoU18rtgSqHKRPjeQT7UEbLNhhCXMzvAOzTNS8yZ1l2fWBf
	 rmsTRU+vwXBsoCEyiX0w4rJnPA9xCVpUVQiKnmjXc66ewv96wUoLKCl5ufPdHJG36
	 Jb4nqHCkB7kGwxIqjGPmo9M6H5eY5NS0pbwhou0VfpMdG4UUbu/HyEdV4B2POOfGP
	 jkFg2TngwwU2ycN+jNRI3TFr/eM0K3P72q5PnKK0KGHA/zfbuexRCiJKP31kaJuCr
	 /3zucgXuOJO5nBQUo6mVllEk9OaB4OnTXlfQ/FJv6y2nvX7kEbOsQTP+ZFKXvUHII
	 +vB8Q6LGdaGotk3yQw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MNbtD-1tD1GE2qRH-00YQQJ; Mon, 16
 Dec 2024 18:29:37 +0100
Date: Mon, 16 Dec 2024 18:29:36 +0100
From: Christian Heusel <christian@heusel.eu>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Philip =?utf-8?Q?M=C3=BCller?= <philm@manjaro.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [Regression] 6.1.120, 6.6.66 and 6.12.5 crashes on Vega with a
 Null pointer deference
Message-ID: <0ad783ab-3066-4c99-b6f7-51b2c6d02f70@heusel.eu>
References: <719b5eb1-a5a9-4dbe-b3b1-399fb299bafb@manjaro.org>
 <0d681c5a-a138-4f8a-865e-a192458ae893@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="73enmikddozleb3t"
Content-Disposition: inline
In-Reply-To: <0d681c5a-a138-4f8a-865e-a192458ae893@amd.com>
X-Provags-ID: V03:K1:uEjS9MqKaiciOhoq9KHT7ZFxhxVxy36lLpdcAlvdDq8M46wSsXi
 yABn8OSLny/Fp9mTqnQKO37Wyn9GohuvtnrmdIMLxCUDGtDJE2ZcHC3ekkUUjjirr9uxxZG
 V605u4fpARvL5NqHtdteA1zx1OkSOQD4kD0njQMcAbEr6QxVobtlKDt1y1GLNik+i+UgoGL
 K2DBqrz5jHZTLpYI+m+cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BHfzC8pRETU=;hDEmawdYHb+ixlxbeseMLrl4i5M
 F7ZW5VDz+7p5h7hQrAjxdhIaNxOV3PqSCB/zyzV+i+/qITmqeu+AH+05TgzaX1KD54c5541rX
 SY27BAauuRuHmvrN++qdlzLaxg2uWY74SRXCzHJgDAB+uw+FNbTdZ0vSv1RpZZLrpvcLlLugk
 ftYI4sDn8vbHDBiA6tH/MtfiZyq7GP10NaP42447H5jEOGn0ZPhVZiSe9O+kfc+sdWn/wVT5b
 wY523X8UaVYuNUNxx8diJ8yiRMeDs0nCg/ueuohIhuIqI2Q8ykgjG9zXaEV2m4n7u7IIpQ6f2
 n8gQSdywhIPCcZ3GbOPJSQxSn2JaXNmLI2jp41UjdCFqj+s2Q87Q50FxTWRjLTtZxW0DrfZkg
 yxT8EVBruxLLX6/+WXZZ7iMrJmou8eehrfcmJkaYLKv3NB7Ud2yPZUyS2KMydCorEEpX79BSr
 vY4RYjxmJ30lad6AwMU5QyXThPL+U3yINpCOaLvM+pX2uNzgebzYPUycAO2b+vYGM7CflH2MC
 ox/IVx+wBtvjpsXtMwZtfceOpCUl1TFNE1hU/6h3FYlXDUeQFqiK0PiSHfii7DF7E8URVVfsu
 ThY9Ma4k2SlTimfSqvoRbCh+fMTs+XuwJk5SdiJ7XAcIn0ZhlFgir1Rls7yJYRA7pjPpvR8PZ
 t+wFR10F9X1roCsbWPtoq4CWAv096lNF587KRT/azzzoyX1tPfAu4Oe2J5oktGOIEorR1PIDk
 S9VSfqFaLc5fiqtjCMVh0Vx54eWaz0ZjGFq8dzwr8pB7o/mk0eBCNiggiVN2rBwsyyA+jrV4Z
 gSgd0cyMeB+ga61fXBqpn4lOIkLRzY0oHlPB1rDbx7E/9D76fUvaQ58zi0UZu1FmdvsEq5+gN
 6SefzcWjQpkwzonCeZtBz+lEgW63Ob6cQ0AXFIM8BMxBJFYWtJ5PwVwVfcs86t5UCMq7VFI6N
 vVpI9xqtrXenCUBosFemB82QqXzc9u5qHCCSu6T8h6WYJeh3ytTpuF7zkb5vNZa/9iInuUS2d
 GsDVbE6Uz+ISi9qZYsjhpJZjDvgpUkSGXyPXCRW


--73enmikddozleb3t
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Regression] 6.1.120, 6.6.66 and 6.12.5 crashes on Vega with a
 Null pointer deference
MIME-Version: 1.0

On 24/12/16 08:13AM, Mario Limonciello wrote:
> On 12/15/2024 10:37, Philip M=FCller wrote:
> > Hi Greg,
> >=20
> > Due to backporting 2320c9e of to 6.1.120, 6.6.66 and 6.12.5 kernel
> > series we have the following bug report: https://gitlab.freedesktop.org/
> > drm/amd/-/issues/3831
> >=20
> > The commit 47f402a3e08113e0f5d8e1e6fcc197667a16022f should be backported
> > to 6.1, 6.6 and 6.12 stable branches.
> >=20
>=20
> Add regressions list to keep track of this.
>=20
> Add Sasha for awareness.  It looks like this is a case that autosel picked
> the commit, but the "fix" hasn't been picked for it.
>=20
> Either the original commit should revert or the fix should pick up too.

ignore the three backport proposals that were sent as an answer to the
initial report, it seems like sasha has already picked these up without
me noticing!

Cheers,
Chris

--73enmikddozleb3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmdgY4AACgkQwEfU8yi1
JYV6PQ//a4/OcGCZu+jMlIV1PzDlZPlssUgs6ZVxBqsYqyqHfqU2Kg9B2uKobjyE
MfFGRQLk4kmKb38iNwvTk9MzznOye1Au92lNiZ62aJ1RvIVbwEJzVJmYP5aJbDht
G1W7DJLAiJQO0+MtBUiTNn62elL4LQzY/qt97MLfvDekKXw1EMLRVrTHl4zqfOL4
yQDdo6MMhHdYAnXwwvCJIEgRnKyRa+kRVX3x90Wj8uanm/qu+EFe/tKc+0j4EApu
xcmmlAMLUWKsOXhoVZrCDUis/fO5TnmIS3jZ1Uy4aYjfwJ15VP+bRgHJLN8UGOma
Yf+gVs5b6ZKkQRn4L9DmGP6jRhj/Qbqd1e3LPsWRTpYHz7nfvuu51gEFSN+fMgpr
EDON6r7YUPjgTcloX55kke6NJp1gFqxCHjvXUyhNae8K/TcesaGvEpApZk0KbzoR
fZ2dqLSHoeILuL9J/ug5DvcoWXeK/f8gXyJ7Iqzk9MHmnParUoxQFBbrYKB4Itlj
XsaWN7nQCleKIQaUnV8O1UOEoEljVlKYmxhmdoFHr8WKv8AQ8OItW3x7vp/RxClk
VRRwAu1Qs7IRWcX9Z6OGtc5tFNmFk02pc9vWamoZhzt6CHAtm0be+hYpaH1R9qTn
laP/FDgswrpeZH8VF6IlWRQN8HO+lTP2fT/gYMHhNTEa8xiit8A=
=6NJu
-----END PGP SIGNATURE-----

--73enmikddozleb3t--

