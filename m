Return-Path: <stable+bounces-156139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49155AE45F2
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 16:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165141884060
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0D576410;
	Mon, 23 Jun 2025 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="KJH38pQM"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41F05FEE6;
	Mon, 23 Jun 2025 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687546; cv=none; b=M3LHEH8S1avemdTTaCJf0XXOHEZ6XhVO1ie/5mKeH+t2Njog88LNfNX4YuEP2NBD/4z5XKW576L5j/zwTZT5N45Ow2UqPjvsByXGaVND07jnw5Ek4vQ+mNt5Ve79DI0GykorkAo3LYRX0dyiscI6xo2wvsgb/bCDWgQMDydTzmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687546; c=relaxed/simple;
	bh=ospZQHAx1azzHgqpO0329Qy3iUeVF89ddO9PCGb2UkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZGZC0lzGnESJ2vIQA2jc9/zWuNemopBYTsj7WiQW3Dl+RXhAr2UbbDhN6zTQtOcSKGLqd1CcA1LnFTpxSWwBTB8k8cSE+u6doqBPQafTbIHnEAsPR7zmW03Q/i/VmrssSoEqT9fmAnHHXYh6GQ7CAhkoo4PDsfiX6gutshHR0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=KJH38pQM; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1750687537; x=1751292337; i=christian@heusel.eu;
	bh=5Onc4Y8lpnattujCyjGKi5wWqwWwEpnJ7+2O5Ajcx7A=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KJH38pQMZ93/RuQ1fKJUN4BtpisNjlsTcCWghNaotY3knfDCtqsPzZFy1MCGkKl5
	 UVBMKnEKh6tSeFQxsiC4KhvQP3uD1D/Jp5Jc/ojEhkROkxwdzxt/eTJ19roEwY4dx
	 RKm0/ZL1FfLnxHN8RZmhmtcq+slfIqBB7Ujtl8S38nibiIRQU+fh0hFlwiPVmrAh/
	 TZY4nlCSOEAs2fSyT/E+Yykn7O7MRrBnVWJN4VHYUqqeneJLF8CfO6wrwWpvMJgF3
	 iCQkkbKroV/fr6io2fwjtCLAep2mHniuxL0MUlNeGhwbc5XZrK9TVyUFB44hK9wYm
	 790NDWsRVn1tMU14qA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.247]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mzhax-1ugfyg2FZh-010Vx6; Mon, 23 Jun 2025 15:50:47 +0200
Date: Mon, 23 Jun 2025 15:50:45 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 000/592] 6.15.4-rc1 review
Message-ID: <a0ebb389-f088-417b-9fd4-ac8c100d206f@heusel.eu>
References: <20250623130700.210182694@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bzrlzjrxqd77i3z3"
Content-Disposition: inline
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
X-Provags-ID: V03:K1:xQORCzsKcY/1G5rTjYyoobOjvK/C4mp5jHpyY05xgU6Q1cU5+rf
 SdLTMzVMQbqPNHLQSd9PILqzuj1kIEd4kkBfMjYulFb4t0V2tG2jF/0sWWUTqI38ygcKg5t
 /y4es4dWDGbMZHAEuHjwxJG0te6c91gdeLK2A4K8WATYD2BKmMDe8YPeRSeRJ1DaMmzgZIT
 lMxq2jG81BTI5GYFyzE2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AJeAl+Q5zUE=;Q/QspzaRZZY1dQGQ5kwICTS3l7L
 cGRv+pjsh3/3lbDJsqqHQWoJEQ8DM+JR7t4VUkyV3rBKfWR+9j3x/ZHkIFHwAEqTlVAGayGNU
 cfuUFSnCmDS6TjzYZ967+FCqL/XxQlgCrtWrojD8z/kqaEuMS641cc3bu2FbsfsKpnpMVbTK0
 eTtIwp0mGyNKbdUiDnXHmQjMISdvPxkUQhaIIq/Gk7L6tXSCMNDclwRULfe+LqiWzgyctqzJD
 B482PS/pN7D3u6LHzv3K6ecr1kaXh0V7/R0tvUqY4FvPpfHpIGVUf+VasdRiX2zol7cR54VH4
 rQC0Wa03ouwhh1c4AMaI9Gl651G4VeYW4T5cAK8NXEI4OKQO1Ib8sVBBUELoPsyEzAfGjUvsy
 6xsbHP/idDUMZiu2/zsjlaHQxYc96krb55jPnuTadW8kns4wqPyTc0cpyHF0aR/4e0heMe7MV
 YaQLALcZbag8X554sY7cIUpWHxdwZnypU/fVTT9DgcLvFD/i5QxaiEIym2gRMjq24V+z5GXVB
 +n77tt7ykN1GjOvZ6hovuHJXBSoUaWmO8aqSrlyLF6ynzrGNP7CGbTEIbGtC50pQDnPfxE2Om
 M1XO4sxEGlrH8j+dyf/2SIdgS9/vSNiBuWq/gmiCrHatMjW3LurnrTvHUEgGKQg4mX0wd+LSP
 yHs5aojXiQjc4HyHvy3iKJJYX8MJBRy++uHH2xWAE4BHKoegGizrJSVo17h2zd4ia3IzKc/50
 p5zKX4NU9MQ7+VyLRH8pEHy42BL+RsB4Iojz4CIswzjbbsuGo3NC5qTUwtpnMXkqKeaR6XPDx
 rT0CBAAo/bu+oZbokkYfCrhuhQawuWSrOtRBK4OSVnwcR0nCBiRxklVhdv6oWe18b7rudCl42
 D1QZ54N5wrj6AEXnaLEoYZQyoxB9vkVoSpXpF45JalZdjXDUi6AumOLHCYVif/J1bJy7ePcoQ
 qsppv/e+6w6gKM8b/cueZf3wwpCvH8rkS8RXr6p8YDief/rSJAKwQWYJjROd0ZsI5hf6ahriN
 5UEXvpRRAf0snGsV7dnCTUEcl7IFYokeT8ZmJ3Y35edb6TJfqN4oemUA/6xW0GFxY1rEFSbOP
 I+9YivKXGPUfN1sRkJ0LbUcgc9/QD4MifsAsfHUk+pyq33gITf3JuId6TfExjqqrTc7qO0oG0
 xP38FMVRkd8WcEANGrOr7FObjzRkiLwNGuUBYv1Z2NV8KIDEVh6YWjc/AV3LAsFkaCTDRCd7x
 H+ec+c+XfpWc2Sg8V1zXz2d+no5Ypj3YIdmdbvSWiaKFXCD8DyY/CguBzLp7ZPzvyDVAQfVPw
 rf+i6WwURNiIkU3LiMGgZxsbMD+QELGk/6ZofU6LNUyJZVQXyOLWKjbF4Z/o/MnWF78VRu27l
 OR6gj0wGmmRHOQQe+hfaJoK7LE0DekGHbdyuNgN2CPvWzVmfxQ4AczEEwRUKkigeAlOxfTlrS
 OGCWkbQ==


--bzrlzjrxqd77i3z3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.15 000/592] 6.15.4-rc1 review
MIME-Version: 1.0

On 25/06/23 02:59PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.4 release.
> There are 592 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 25 Jun 2025 13:05:55 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.4-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.15.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

Hey Greg,

this stable release candidate does not build for me as-is on x86:

error[E0432]: unresolved import `crate::sync::Completion`
  --> rust/kernel/devres.rs:16:22
   |
16 |     sync::{rcu, Arc, Completion},
   |                      ^^^^^^^^^^ no `Completion` in `sync`

error[E0412]: cannot find type `Bound` in this scope
   --> rust/kernel/devres.rs:226:49
    |
226 |     pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a=
 T> {
    |                                                 ^^^^^ not found in th=
is scope
    |
help: consider importing this enum
    |
8   + use core::range::Bound;
    |

error[E0107]: struct takes 0 generic arguments but 1 generic argument was s=
upplied
   --> rust/kernel/devres.rs:226:42
    |
226 |     pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a=
 T> {
    |                                          ^^^^^^------- help: remove t=
he unnecessary generics
    |                                          |
    |                                          expected 0 generic arguments
    |
note: struct defined here, with 0 generic parameters
   --> rust/kernel/device.rs:45:12
    |
45  | pub struct Device(Opaque<bindings::device>);
    |            ^^^^^^

error[E0600]: cannot apply unary operator `!` to type `()`
   --> rust/kernel/devres.rs:172:12
    |
172 |         if !inner.data.revoke() {
    |            ^^^^^^^^^^^^^^^^^^^^ cannot apply unary operator `!`

error[E0599]: no method named `access` found for struct `Revocable` in the =
current scope
   --> rust/kernel/devres.rs:234:33
    |
234 |         Ok(unsafe { self.0.data.access() })
    |                                 ^^^^^^
    |
   ::: rust/kernel/revocable.rs:64:1
    |
64  | #[pin_data(PinnedDrop)]
    | ----------------------- method `access` not found for this struct
    |
help: there is a method `try_access` with a similar name
    |
234 |         Ok(unsafe { self.0.data.try_access() })
    |                                 ++++

error[E0599]: no method named `try_access_with` found for struct `Revocable=
` in the current scope
   --> rust/kernel/devres.rs:244:21
    |
244 |         self.0.data.try_access_with(f)
    |                     ^^^^^^^^^^^^^^^
    |
   ::: rust/kernel/revocable.rs:64:1
    |
64  | #[pin_data(PinnedDrop)]
    | ----------------------- method `try_access_with` not found for this s=
truct
    |
help: there is a method `try_access` with a similar name, but with differen=
t arguments
   --> rust/kernel/revocable.rs:97:5
    |
97  |     pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
    |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

error[E0308]: mismatched types
   --> rust/kernel/devres.rs:257:21
    |
257 |         if unsafe { self.0.data.revoke_nosync() } {
    |                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^ expected `bool`, foun=
d `()`

error: aborting due to 7 previous errors

Some errors have detailed explanations: E0107, E0308, E0412, E0432, E0599, =
E0600.
For more information about an error, try `rustc --explain E0107`.
make[2]: *** [rust/Makefile:536: rust/kernel.o] Error 1
make[1]: *** [/build/linux/src/linux-6.15.3/Makefile:1280: prepare] Error 2
make: *** [Makefile:248: __sub-make] Error 2


--bzrlzjrxqd77i3z3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmhZW7UACgkQwEfU8yi1
JYV7pBAAoLezFTzYpDLyAa2Xg8+9dwvSN121/S9xM+EPfrq72KeTvU+H0emNmKa+
+nr5DxoIlE5ywlPMu759wMoS0sv2vdCSO4Fo9u0RYLwY8igZO3F7gNCtzLTOl5w3
m54Dg0zKeKt+YljwZbXOeFiBVW6SGCzBXfRIukYzZU8Lx+6iDfQgAYVuTuBpe8Dg
RodEzxKyw4W83yxbU9X7h/uNWc3HNmHu+YtPsvEnBLMlIXQ8m/gUSB7nDmLRlLW3
HoJxDx1122V3vcZKhiNJYVScKqXtYI3jAVuzsnq+5s/HF3IEBQPiVr/ouHO1Lpkx
JaRt1xv/rpLSAO2M9Zbmhhz7QFj7sJ0WpcIVYnixJQxjSGAL/GQ4cVKGfDVIYPL2
yQPmI1aVQ7d7pGS5RD64SXXtTrl2+7UAdbvDuFxjTlCeY6ZkGreGuGiy+L4eB9vc
n9pvVjAJSC6FkE3ICvS3OFxIF2KrSsQS7d3kDQ5GFqoQfVsFJtb0DLsOkhylUitm
wF3pP+42RKUSPcsEdYJe7PCTAeCAWQVcaBtnM2KjctQGkTW5QcfX0to55W1y9xiM
upVPaxdCoSUOGlpSYQuapIe39B4VyQad9qN7OdYe/4iJWbbto8rg0IqOS9JYbdJf
w1/Cv1HYzowFUdxT5TKlPLCPQNaLC9VYSleec/iOUC2ig0VN5MA=
=Nnoh
-----END PGP SIGNATURE-----

--bzrlzjrxqd77i3z3--

