Return-Path: <stable+bounces-123070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6C2A5A2B6
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5072B3AED3F
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4EF234966;
	Mon, 10 Mar 2025 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=ceggers@gmx.de header.b="ArICW5M5"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DDD1B395F;
	Mon, 10 Mar 2025 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630958; cv=none; b=N1trypSJdL1T2uyY77HDgh5FHqYnkP34gyn0jFN/8qbd0JShDWbPWd0tc8n+qwNTgBx3k6GSTv3pUr9d9cwrW+p7PhEFDvWERNAG60BdcJd/72X8h9iYauhyKy+nmn+lHhTcOlWDxOC5WEm4zuLWnfmR1jiTjMR1DcQ35vVQ/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630958; c=relaxed/simple;
	bh=Zx2HmYMc3XVimy/gJooeQF2i7I8bjdI1jLPVeuMiqYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQ6pf/4kXk48Ol+Rz8uOca+k5yfnHJLtFwtVnCOCPSdLyTnpFnD/OmHM4JUgeDF1FLWfLfbUbzHE9CyAZ/R3yOMv+svj9p8YY7VHi23fFgqBjg4bdUlOJNW0ZPScFHpklrM/htTE1dyFJzcUpe873K2d3trI9XD31VSkM1JsFXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=ceggers@gmx.de header.b=ArICW5M5; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741630946; x=1742235746; i=ceggers@gmx.de;
	bh=Whq6S+7iGQAr3A+cExD85fkuRzBWgcHyyOaCGKz8V8I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ArICW5M5BtIGquAGu89S/TyhTdq5d+D57/lI11xpK+75s5/lshSB5IvJzfYAzIfE
	 NK2O6wyoRUL5pcZE40gT95uXeABti1/OCxWllS3vXSttTx8CK2nYCDqidTtmIRUsf
	 xd3r2pPln42ca4vaqJcKlbYBalkNHb5LmloqAj9OOyZkSe9z5fPOrKUKQnQO9Bjbj
	 /kQ8TPtq7tfE8uv87OVi4TxL3z8ZdXX+rqBHMYiIfj1C3Nn6ODbwhMgdL6b0CI/Hc
	 IGZO5ukCkIMUfEFCnTT/Y/Q/U8qG9SGQKvVdL62CGUDuwbINs7N13p+2DLP4So8jZ
	 FQq8wao7ccIqyR3AEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from zbook-studio-g3.localnet ([95.114.251.201]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MhU5b-1tMElu3OU7-00it1J; Mon, 10 Mar 2025 19:22:25 +0100
From: Christian Eggers <ceggers@gmx.de>
To: Christian Eggers <ceggers@arri.de>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 Re: [PATCH 2/2] regulator: assert that dummy regulator has been probed before
 using it
Date: Mon, 10 Mar 2025 19:22:24 +0100
Message-ID: <4945392.OV4Wx5bFTl@zbook-studio-g3>
In-Reply-To: <3d195bf7-de99-4fe9-87b0-291e156f083c@sirena.org.uk>
References:
 <20250310163302.15276-1-ceggers@arri.de>
 <20250310163302.15276-2-ceggers@arri.de>
 <3d195bf7-de99-4fe9-87b0-291e156f083c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Provags-ID: V03:K1:mSecFvwDdmDDHNBkAxGC/N1fqI4dr2nlOihHZQSA/JKRstn18gK
 swYL9oHmWu1vgrqc/fGVbciCZKNwvi9//8+hH3K2Rt9wt97Wm6xxsOJ2Q8kuATnKIW0LWBm
 PKDj4iP0we+NLPkiiajwZonm8W5XBQweBrj+wXDs90ekJQ+pnl+d8u7fdyLBcrBUYfRz6Xv
 wh+HRTA3nsbMIt+i7FHtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RrMt41El9TA=;w5qik2fQinE+qvz+FqZmhH4srQS
 k/v/gW3aXQudlgjpYkkFuPN8hDh86fbAhDfO9zFlSQi4QG5X7xlQebArd5wU9R1MLjVXaZCEk
 cSDFGyXS6Fzw+ueGAnIkFJP/3amTb3seXVqeNmzedZEbPIqH3imPVwH0yLtfFibntvtJEGJtM
 +1U511DZbe3NgIsGnljeQBLjQk0zP80w4HWzpEdGpWd7EOuus/+OAUaD9qJynqWAFvUFaBRS3
 f8SB7lKiIzOG7pFnbmKMQp565x6tui2YZ8rKRXhkSXTJjCqBgzHOxNfVeti5HLDYQWy1LvkhE
 q/WvgdGTNdPOQX1Y6zJNOM5pAu5YzUjTamukCXtV1d35V9BQCVDFA4Kj+v99gzwpAj/CcTNle
 C0ijsg0HHmoxs5gfLSvTBEiUNp0NYYWcOCuAWxO2johmpKJAejCcHxp+/H8R0o0hCwQlCJfKj
 BzIrN4QAr+HEfHNIyutpJ6OzIgCr47t5srUDXBebLiWAXsaMW07npTtwTmj7pW0yUikhjfIG6
 xuTBVjOaTx6LorvJq7hRherwqCGIKcsZLPP+Cw4VNomAkir46ql54r/rB5WtkK3QNkwPc2Q9o
 rvpbY0pm/CvJbSKwjdHQUKTc/W299DCUN9K5ARHYPwIz7oqCTrqht8mdmrCaoweVxFvrl+Mnt
 PDuKC7PYJS7Bet9LpwQd22fjtQMXS5JK11+ut35kV2YBDNSSSDEWG1ylnbIneGPrER2/0CINe
 orO7tEchaQbhwUscr+Bllob3DMXZsv0ymHzcuV+sRW11OCPkx6BvYXXvrFM97I6htXSKMH4bV
 K+atjtWzrxcbQCixC/dYQPdSlbIIVRJCdaz1Fbb8uSPhCyT9e48df37nyxRNJ8HZ73b1+npbu
 dMj2bBl0j7xfYPwCE9jxHOlBQ7HypzXL6sIZ7kl+cF8tRcvDJlrGS+3zNfZOaOGDTEeHe5K+N
 A2a1jOh4iD5iVSxz0SnFylkzSWIJ9jZZp0VUYSKk0A8rP9NnM+yW+V7lTr/Xzz7L2ZcygsSBe
 rAD8zcu2IfxOVEUulR6Dq81TTaUynxNf30VQ+Z8usH1chy5N8ET4u9Yo+efznUs3JcDEJ69U1
 29z9KkOxRCgHQxaZGJeLlPw/DhgA+uYnUG6xMNhYPuUcjT5mXKGHDl770tv0+nPPn4xqK2qm8
 h646cPiZXLOWNM8X9im9H9hkxzA+dWf4Tc3OP8TT0W1jRtLcPPdNbusuGReOHh4VS99Iehu1Y
 7RLmvv0GzNvS/NMlRwxkoO+6WhLTs/SNzbQMuVoy4mlwmERWPbjcVbpzWBjlHQLo4hTt1IfEN
 j6mRTtqFDlmJEsKuhK/FQ0UeabTrZVNXzI3RHEcZVglItrcy37UlzrW/o+vqACdUNixObhhjo
 OIFpWF5dxb0Nx6duOSeH3aMeSs8M6zgLNGVko2kqe2c4+wdQ5Bfz6as8JAq7VTb8DfrrqJP8Z
 IPtqH7Q==

Am Montag, 10. M=E4rz 2025, 18:23:02 CET schrieb Mark Brown:
> On Mon, Mar 10, 2025 at 05:33:02PM +0100, Christian Eggers wrote:
> > Due to asynchronous driver probing there is a chance that the dummy
> > regulator hasn't already been probed when first accessing it.
> >=20
> >  		if (have_full_constraints()) {
> >  	=09
> >  			r =3D dummy_regulator_rdev;
> >=20
> > +			BUG_ON(!r);
> >=20
> >  			get_device(&r->dev);
> >  	=09
> >  		} else {
> >  	=09
> >  			dev_err(dev, "Failed to resolve %s-supply for=20
%s\n",
> >=20
> > @@ -2086,6 +2087,7 @@ static int regulator_resolve_supply(struct
> > regulator_dev *rdev)>=20
> >  			goto out;
> >  	=09
> >  		}
> >  		r =3D dummy_regulator_rdev;
> >=20
> > +		BUG_ON(!r);
>=20
> This doesn't actually help anything
My idea was to help identifying the problem (if it is reintroduced again=20
later).

> I'd expect this to trigger probe deferral.
I can check for this tomorrow.  But is it worth to use deferred probing
for a shared "NOP" driver which doesn't access any hardware?  Or would this=
=20
only introduce overhead for nothing?

regards,
Christian





