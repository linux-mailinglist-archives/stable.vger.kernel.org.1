Return-Path: <stable+bounces-145793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922AAABEFC9
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 11:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005BE3AA646
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057071DF968;
	Wed, 21 May 2025 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="NSP7QviM"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1C241CA4
	for <stable@vger.kernel.org>; Wed, 21 May 2025 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819812; cv=none; b=FOy/1WI84lPk+KsQCoVoHYUWX/i8CycRmwH5Ng1ESAoocYk/9uNZg4KLBpaTNdx/bJe0hMHDp1UzfpKKVmAN8GxTa+lNG2Yj/RHYRG3PvXkYrVlDdsm0s8WkCGsms/JTCHiJxWEW3JJnyq8ngNVxDetNYL7bv5eEVFbhtnqlnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819812; c=relaxed/simple;
	bh=V6GdxtXVUeojkuAjWHVJOy8gkheN7K6txvTOICJ4Tj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5XgGA2Xh+rpfaOCxFHl+V3TQX2GROBlZlyHmmbUX71fP9l1UmEmpv3mX8aV409ZZyxnACR/GEcYaMWSGK/ocw7weeB3l3kT2SXlgCSIVbVwqQmxBvtHoVvcWi9QTSYZDli9zrFEMNuXep38P/uISJGivkSGOlzOgHDHjHGZu/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=NSP7QviM; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1747819792; x=1748424592; i=christian@heusel.eu;
	bh=V6GdxtXVUeojkuAjWHVJOy8gkheN7K6txvTOICJ4Tj8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NSP7QviM+foLGL6H2BmSE2yxvQwkApVwcyuB4o7Vs+ENdE8FQTKx+PrbD20CYIBR
	 9b2PaMmCycY8dupdsfLha5TdxVLiyaCXASufg0R9gBD5ky6SZpi2LEiwmCkgz2H+T
	 gZwb0toVEviWlgQbO22XEKQqSKcP/bnce1B48f3ZcNg8+ZjENJzQ5s0mM1K+s8OKE
	 DiIS17laETfJvceztguCnK61oqdvBESPWmiXwJsJsHSV28A74XPydZyKkYH1f0xCj
	 HF9VyvwgvCSJI37mIxvSCXnqKlzv587deoLJ7kERr38TH5d1HQcRHVe4oqqcXM7Vn
	 fHWc5A/VGYMpzaow/A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([89.244.90.42]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MlbPO-1uiWLN3Rkg-00ffiw; Wed, 21 May 2025 11:29:51 +0200
Date: Wed, 21 May 2025 11:29:50 +0200
From: Christian Heusel <christian@heusel.eu>
To: Maud Spierings <maud_spierings@hotmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	denis.ciocca@st.com, linus.walleij@linaro.org
Subject: Re: Panic with a lis2dw12 accelerometer
Message-ID: <8d249485-61f6-4081-82e0-63ae280c98c1@heusel.eu>
References: <AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nr44ii4xtaa5iejv"
Content-Disposition: inline
In-Reply-To: <AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
X-Provags-ID: V03:K1:JRCKjE2UBGLxVcMcum/FlkG3B4K6aY6NkE+NZh8+6VjsW9gqwFc
 7ZljW+Z/SjTZNfiDnoeISSd5+LQ5y6XWzfSgLfay15WhXtbVFKgLeTKcuw89HaQ/EZFF6Vz
 Slwu8cE8o4YoYA3iZnRCwNJ7EUl69COcrUhnFWjGgnTkO+Z6F6LyufYSXVHfpKiczT04YUf
 FrsxkN89xWfyi8H2ftXmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KrJlx6TpXCo=;aeX4e4PlgFb1nC6sR+kOkDcu5SV
 DHHw5Sr8XKMMDlz81mtDyxl6ef9xXNrcL7jBPUyFyWK9Y/y3cFnh2gnMVKzTWKl34/1fxSRJ0
 LsqzwtD5NxuPcstf3rp6g3amzYD6U6pFwJDZ25aP2PU8JS+mxukzbIDuHKMQdDhuIcDdFTaEs
 sPgvm9RwSfxtdFJLjTfxakwsgRuZmdq8cxBHgrJYsS5JHkk2r94jQdvOSEZWalQ7vp/qizdwO
 Besfo5llgTrxxEwRe9kmu788i2p62DIbhm0X+r+HodOffEdswT6fAG4ZsbyviVR3bxz8sU1mL
 bu6mbRxkyZGnSxdFYxlJ8ubDH80A5JhXJc5hYp+pNVLmEGktmhXkStAYi4CdBzp2wl1538ByK
 xgfCDz2qj1mPPBY6A+rAy7m/pXn3dp/0Gn9EX8c5+4qJlPyL2xBxU9tJf3ZKfWczuUvabnF09
 2l1B4qSy8ctSB3HCy4OdXC/G5qmrR/hoOXaKo3pWlmG09KvzvEYQiLlth1l0Ewkn5By/Y0AVI
 UD2d5beBDqJgxH/3+Tvi/W4UukE1oG9f7tuA16HBzYTIb4dt28v/O0lqt5Ytn3c6C5GdEzazW
 n//VNYK1EB2vHUnqU+zx9gbsZqk6aDujj1ZJ1DZP/GMuuHjI50AkKQ+zWujNJLkksfQd2y55q
 feuNDXabg9EwkINhL7+ucCXmBTEwG7+qhE7kUldsh7UtAsra/35P6S8xstHrSnsTgnoeqC/sq
 Qsg6UeoAF/5iHTgfS9MXJmj7KAbKb0eWyWTUF+2Mi2lhmFcfo4+/f67ejIr54MYx/9DJX4Qls
 I5RjX1nyCYyKij1IYFusC2o/+j+hXf4p2f6Xb8ILUDB6yZVJ+beozPHz/ksLGULFkUhQO7rfU
 Zz5WKcH1y7IWulwpcay0SUZP5GT5K+ppjuUFve6cdzZmlvNsx6TYmnv+6qo+a+87V1F1MlO96
 xq7hhfr7qOA0ct65vkhtvTW125trtV3IlErvJbHcBXk/i00sJoCp2JwBu4mt4Pj+Cp3sOQS+m
 4wTfkIXnipXiVSwvhj2J1w2jy5u+T4QRAAZAVADPubC1oLeI8CdnVjYugJey7YLVrle58RXYy
 qSnFl091sTeMgvaBZE4r6NZeQ3xRsqU7W4hXhcliftLRpNT1207Mmiz6/fIcivqDECm07g7iT
 JXbFvpCWqLogD4qrkDJOH1cMJD6Z7stROqoUtKGaz11UFRuqYXLJI+mCfzcriA6rzCeMY8UMR
 fKd4cDPk/8wtyg8Gp7NYKNkm6BE3ndtVAJH18OTPHpnmpdwp34Ef1r6y+XSmQcdHi/rCPOiU/
 fBx+TKg93R6l9tbWiItnDUGJIUae2zdc1eGlMtVuK9ZZhhN9YaPtzk8g/WanUCWc3FBeT1WNh
 eK06bVd1es+o6ALVTDSRnX+tsfq6jiMuLr8JwKyogz6xvlmwj5fYrfHwl1


--nr44ii4xtaa5iejv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Panic with a lis2dw12 accelerometer
MIME-Version: 1.0

On 25/05/21 10:53AM, Maud Spierings wrote:
> I've just experienced an Issue that I think may be a regression.
>=20
> I'm enabling a device which incorporates a lis2dw12 accelerometer, curren=
tly
> I am running 6.12 lts, so 6.12.29 as of typing this message.

Could you check whether the latest mainline release (at the time this is
v6.15-rc7) is also affected? If that's not the case the bug might
already be fixed ^_^

Also as you said that this is a regression, what is the last revision
that the accelerometer worked with?

> This is where my ability to fix thing fizzles out and so here I am asking
> for assistance.
>
> Kind regards,
> Maud

Cheers,
Chris

--nr44ii4xtaa5iejv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmgtnQ4ACgkQwEfU8yi1
JYXdNg//fMbGKt//IwRv+yj3t0dttbSJB2RACcdfJ4Ws5bYvC6UiUiOEtvFItqMJ
5XdPftDlpLiS+lwlKhRo8SwVaBRXe2eXZf/84AWt6X3s0Wtw+6LpytH+LV4Liose
H77qldOjS1Or1UjOyvrWoDtpV2ZSUngwB0M37rUJYdXP+n8nZ+RfqTHr3yFTWllS
wY8tH6M3pPBjvFjwe1XNWAFRZq59tuhz9cBb5pphvESCO5MSyzCQ6sPN9sbaxm3l
+evb54XV7SoNgw7MvI5JhGF/faMcJ+WDzC6Rlh8E0UaFhxc7Yv4pyah8ulxwjwCS
EL6tiJf2JLQlryFnM3RyO8e2L9Peue46Rp325mWblPCiS7XZd9bb2E2GZNU+JDrx
lGQza3zglfhOZGrSjktOUVOfacQHpuelKt1X0ThjHkd96PNKsbmij5ywBDywbXBx
FWR7YDIdSnjc06Havo2fVTF81sCEQ2aQXLG2mdFEbqYMdtvmjJGQ3z4zuTkQBR1i
uQGp2JkSzq8xWPmKRR9xB6vANSXjoLMx6oYyJe7Ry8oTcfFwxWn5CiTseAS8Wc1v
Xj7jFeo9srBoju1plkcinnN36ogFQeNAywWF7buD3J7gtbCZ7oXYCYKCRZQHo1qx
Y82Nla8Aay88KBiyzAzG2QnLwMHDEm3sS5dYddEQxB10YQ2b7D8=
=spif
-----END PGP SIGNATURE-----

--nr44ii4xtaa5iejv--

