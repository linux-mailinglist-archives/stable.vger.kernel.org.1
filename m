Return-Path: <stable+bounces-161498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DEDAFF45A
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 00:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDD55A3E9A
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 22:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F6242D94;
	Wed,  9 Jul 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="MsdcqVJW"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ADF21C9F4;
	Wed,  9 Jul 2025 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098691; cv=none; b=dZQMPuB/gu6MlrEHC0oa3ODb0H/xPWX9yhsehpeT9Xk4R1hSwlK/nCnfA2WPpmgZUeiwBBaG7md/OGUWxwJXOc7Qp4pUIvzwmsfyNUT+5Wk0dyL73XtdIupSO78g0Q6DGGVIC/cD4SWSpvwCwoWZDomLywzly2WmjseejfYF6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098691; c=relaxed/simple;
	bh=BCKdLwnKOpH2DZRNMpBYqQ3w8IBLQXrWCCBMIu39cbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITNGKOZ2GMmbH5bcHmgv4+hRhkPnnAGdvYMIFIJsaRmT6zbq72761xY9KqdQtqU27feWopYb7PnvvXxFe51uGlskr/vQqh3J0lhyk0F+IfRvRww1O3MkVj7A8gfmXWHBeOuCncGQz6UpiMxVzpNgNqpFxRDZDrkEZ52Y9v70j/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=MsdcqVJW; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1752098681; x=1752703481; i=christian@heusel.eu;
	bh=sm4GwRQAXXIghgdM1jOWOzQwfMi+m+j+boo2hCKzLs4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MsdcqVJWQYC8YDSEp+3gIMrQm1nyw0a2IKJdH2UWWaQuF2ZTe4tD6NLFOL93wrQm
	 ik3WG9quTQJgherivMh2xHhtX0/HQJRRCMypjHb9ElZQvmOLd/6HRRXQoK7/zhtBu
	 582/qdLJx+mBqyNIjkAftOgveyCGyl1bHf7/NHWgIVoGxcRX0W41N0BNaZE9JnyP7
	 2T1heR/GAIvQH5SaRlqt2dXDGze5O01ZajCDaPKkYAGFIzl4/kJwxrVSUPfLVAi4v
	 9VUxq4HCseRoJymvm7WQc9IqYv2cQ9Q5RVQXH1RpKgzt1ik7xR0MFWiB2WHT0rcBA
	 5Rs2n/RTtnuWvYJUhw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([89.244.90.33]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MTiHb-1u66gd3xu9-00QNYE; Wed, 09 Jul 2025 23:36:55 +0200
Date: Wed, 9 Jul 2025 23:36:48 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, linux@frame.work
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
Message-ID: <ea43ef36-a5ba-47c7-a0d8-f1cd920c1dde@heusel.eu>
References: <20250708162236.549307806@linuxfoundation.org>
 <75a83214-9cc4-4420-9c0c-69d1e871ceff@heusel.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w57c5ejiz6ileb2l"
Content-Disposition: inline
In-Reply-To: <75a83214-9cc4-4420-9c0c-69d1e871ceff@heusel.eu>
X-Provags-ID: V03:K1:4sj1eLiCZ7i4ecolP+0YvYlw2Ukzge7jowpjvkjOQSorsqJK9Q0
 R1r0mt1vwMPDtWejFI2Xq14knikpGnY7VaguDjxiq+uYq6f68xEibAxvQfLfGlGTgUZ5l00
 tGAZOi5LO07uGRo8yj0uWrLJiFl7h4/7yosMk23MtWrkrGl1ALguKX6RbLI0zPIXthET1Da
 KLUH30WyEuBM1Sew1Bmxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k3QMiuqNzLk=;4/6OHHDdHz0Ull2XadIePrKZzUW
 i8KryPym0leV/1x5KeGBo6t1Sqba9krYAz7c6Dv3C3vhJ18oPwNq5zTro6Qj+RYAgA/BFvAgN
 o3vtds8I/gtkBhkYiMyiSX/mk4mmCEcQhGQ7wSeNstC+cL2jjPhqxGZTVvGCKdPQ2Xu0bUMbU
 1uhN/ANxs+FaNE6fLBmU8TCYhcW2MqgjDiTasKcFhazZioRbkRCxBBYDhPhHF3kgePHd16RuG
 jNZlKngmgU5Fgb3Bj8LfUyYBqRHxYtZ2jLAwgFqE4EaLUQ0bw0O0SH+OfRtI3+DPo+CPQrk4H
 YA2ctJ+JBCOhSlrQjUHT+/cQjoOWG/mQ5nBXfCASXjQniFmiJ3jvo/inkouYirFzkyddB1WXO
 borV1/jbQfsT7GpcwKx/IUdrroqoGCt0CFXWN7kcrb4YDoU/+B6982wPsggTbXo/NBxifmVHn
 CnvxbeBKuxUMcRAv8uVLyF/G+FPQrJLbXkqldZkbO/A4gs8xhBKd9VHLViK1gw2Dhg+JupUCH
 NSVTaZ/NH0TuQmdKtfifH/jL0FBnS0hlqLozXv0sS/k3Q+L/8gvaQ+j3SjxerGLPOrsGG4A9u
 wmaqlhJ3DHKpd01x6ii6lBUsKxYY9dwA40a186bv6FdYL+XI+NV4Rx63saiwJAwqtNKgrkfqa
 L29ASOZbkC6xTgQciw92mikOSkXh7JMk0Fv/WTDOfT4NBy7h/GQWnKg0a5QVmaW05trS+NxrX
 T8Cgoe7GQILStpPaSUuMqWntDokzF0oHOLgdHqkGlVbfuBpfYSl1rkGMc5ALcII+D264UxV7r
 Y2Gvx5dWJfmHfQghbfLjC2N+hNIt9WZ7dqGKLnPxsEDHOc7+LVcr4gT72pbMz09dgfbSwsJK/
 I+wxvs2+BoXRtBVxBetdWMbCL2jAhbpFXmo7rswZ6miDheREebH3sdwz4Soj/E2IL5/mpDaXx
 hz7cECMwYz9N7ofUq4rrQxM4yxIL+MwMKzE6m5DNbg+8hfrth+dISnQjilEP5X5SJJJoFDvOQ
 BAxGXefzcvpwmKUJ+2Cy7yN8UXPerRFHUQ+xMqLs7QqsKabc9RqGPBQdj8gksEUN15VFikIIu
 9Zsey3oxOMXfyJ7pTV9uImUNUYOOyCo8nXn4nXi9BUjqwHRDneuE//Ov+8r8YMB+646Jg4EXZ
 LUijoGyn0eRYRPtzgCRomMfiA9Y+0g4f27uvbALX/HHuzAfOX9yb7LGE3dewdK2siSnmS6BUA
 lsnoRI5/O7A2e1cZRO9t4ku62tLbscMpRZcqj3krDA5wMQslNDCai9uElJ7YPhKwJaSp85v0k
 C6V4uNAkwRaQzWxpRek/4EtihaUB/FOBJacStof9eFkjF40o7Dnqlh3Fm/Q0XbtgwNfrvQUzl
 8gDk4CoERTxj3QWHTRpsOd9P3mP1/wSi3zss7EoC6CnV/5DxHMXu9opzX/YvNYwLQBbuM+QZD
 tAU5Fwgp6aVeAZtyD+cB0z4fL91KaOyp43vLtpVmny67CuY6I1NdVoWPdNSP9s0IFsA2o9Xxw
 vSrOBfmbbp4x5/WQjx7m467BIA7l/3+Voiv2M/7jLUV5uZC685SYVaNAF355jg==


--w57c5ejiz6ileb2l
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
MIME-Version: 1.0

On 25/07/09 07:19PM, Christian Heusel wrote:
> On 25/07/08 06:20PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.15.6 release.
> > There are 178 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> > Anything received after that time might be too late.
>=20
> Hey Greg,
>=20
> on the Framework Desktop I'm getting a new regression / error message
> within dmesg on 6.15.6-rc1 which was not present in previous versions of
> the stable kernel series:
>=20
>     $ journalctl -b-1 --dmesg | grep "PPM init"
>     Jul 09 14:48:44 arch-external kernel: ucsi_acpi USBC000:00: error -ET=
IMEDOUT: PPM init failed
>=20
> Maybe I can free some time to debug this tomorrow, otherwise the
> Framework folks are in CC of this mail.

Since we have now concluded that the above is just a red herring:

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and a
Framework Desktop.

--w57c5ejiz6ileb2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmhu4PAACgkQwEfU8yi1
JYVF+xAAvZQ4RKLhuSEVhEpwMf90OaWn6nLqbwp3ixxDEL7TsOceiAVauTamnoLX
s1Zby231m8sR4JAfSQ7+zQcY1l+P3+OTk97u4ajs+tGkCOT8eCE93msUL2ggxnqL
ZtVz48f0dA+87lUnPwCARgJHiurIgMZOUT9/37+RvuuGULawE51Ip/SZO6wRNhCw
2d6jztwVDZZI5BB9JMeLhx3ahxvbCaJZsGiwteibsbPLU+QGm1rjZ8RZs8b/mSiN
KqKAo7j9MJ7URggsPZVDCNtNPUTlFZ9m5PUXWnbtrRURhVY8maBGzlyRgiS28KJB
pq3pS6R3rqb+W/yg+WvhcCkv/AcsmAPHGrUQG/x6PyvF9QKdEVov6YV+6UnlnIdV
Y4Bpv2Z2n1YyjxRKEaWQx85zxcmkyMZcIqu+FutOy99rRcJiIzRNbT5ACrrFGmB3
EFMPY4HL/vmTSVCyCSay1ow8bD2jZk4Uq66qmjyXs0BjeMWcfLnt5NeV4Y61pMOf
bGjYfT7lbpyG0LMTfRrMRaEkRsFr4C9iXZz8408yZX+vItETVsv454jSFY9/gxDt
DqkeVliQfhXNpetk809RCyVNYn27LaahO30+TnB9p1VYsBV89n5W9koR6q7lDCCC
d89ZI3JrVdniKe/aDXP5Es/HgaX9xx6iD/q8UKGz6Z0Er6Z2rxM=
=M3JH
-----END PGP SIGNATURE-----

--w57c5ejiz6ileb2l--

