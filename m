Return-Path: <stable+bounces-154678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE2FADEE1E
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 15:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F03507ACEE7
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 13:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CBD2E9EAB;
	Wed, 18 Jun 2025 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="i7X1mi7M"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184BE19F135;
	Wed, 18 Jun 2025 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254128; cv=none; b=TeuAMxvrZmO3Z3cVFdWbyVwpQ5BuqlOAC7ROXIMFGo+fammdhQvV1kc7aDp12Z3DQgep0ITzZzMO5CYNjytJTMNIxncbrdOK4Vpio6Ra7LcNKQZ1n6EdJKLFWn4cDABP43QyBAiX47RU6RYpJOre2bDzdbi+lJfSy42xaHFlB9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254128; c=relaxed/simple;
	bh=U1Adh7LXT/5bB/srNjs/Q74DNy0BP80+21pefP89i9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orutxgMEB9TEhx9VBRGDGKAtPhTcq1GxjhbOmQRRJ2xchkOxxBfh1e/EQR3wnCW1tqCZPaiY8GBeRrOKnWlDrl+n1rblk6scTxu4/qaQOUd7+SF6Oge4UKqWRYT3P4uLMJjFWBlx7m0rtg+DJNBniaaoemspkmv6rIEPsQNttWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=i7X1mi7M; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1750254099; x=1750858899; i=christian@heusel.eu;
	bh=U1Adh7LXT/5bB/srNjs/Q74DNy0BP80+21pefP89i9Y=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i7X1mi7MBzJxj4siMjvOj8juLqRSYiJC1NyVgjvwE6ax9EuJGWmb1yA+qEN0qOGm
	 UMqWgK2hRAZ3niQ+HEQ6bcTD6/d0j/NnyOLIf2Y5zUCXK+TEQbd8/XubsJkHQxIli
	 HhKd/hqMeG3iy2yTSB9SZcXPvNlBi2J/6yWnafMD24wmRn2d471EHToE1BDamBhgu
	 yFo0y//Z8muvzFu2+sPxZx+AWhKuarr3gVgwvXjM6dJboClLSVYaucApK1lCLF4j0
	 9yVb42vlyPtVmA6pSHUH31Mwze4yP7kWskjVRnrUA/lQW+Olo5Idx9GsxGHdIHTzp
	 Z5AbL157ICNS1yl9xg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.65.175]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MGiAs-1uVmnQ0g2E-0065kb; Wed, 18 Jun 2025 15:41:39 +0200
Date: Wed, 18 Jun 2025 15:41:34 +0200
From: Christian Heusel <christian@heusel.eu>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, 
	Vitaly Lifshits <vitaly.lifshits@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [Intel-wired-lan] [REGRESSION] e1000e heavy packet loss on
 Meteor Lake - 6.14.2
Message-ID: <87584d6f-5a31-47aa-bba3-1aadfc18fbe6@heusel.eu>
References: <Z_-l2q9ZhszFxiqA@mail-itl>
 <d37a7c9e-7b3f-afc2-b010-e9785f39a785@intel.com>
 <aAZF0JUKCF0UvfF6@mail-itl>
 <aAZH7fpaGf7hvX6T@mail-itl>
 <e0034a96-e285-98c8-b526-fb167747aedc@intel.com>
 <aB0zLQawNrImVqPE@mail-itl>
 <c918d4f5-ee53-4f64-b152-cea0f6d99c4f@molgen.mpg.de>
 <aB0-JLSDT03fosST@mail-itl>
 <aB1JnJG_CH5vxAsw@mail-itl>
 <aFK_ExmGqmi-oQby@mail-itl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f5u6kpjicn4mlvgm"
Content-Disposition: inline
In-Reply-To: <aFK_ExmGqmi-oQby@mail-itl>
X-Provags-ID: V03:K1:NaeQa51SxlkdUa4Lvc/txxkbY+/R1JiRw6uUYhaNd+hzPWDnQwV
 AiLpOv6EsaDvBmaelfJtX2bnKTo7cgmxaxHdeQNcBVSsN/Cotdsi+Q5ZelPOMGv4QAQYdhK
 1nJdpGE4S5gkDp5jXBQTH8Lq5zPhT9GHSGGyBb4lpguI3jCReDXcDA28SLnvKzyexjVUTsT
 gFGcMukN9iX/CoybcwqPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FkBSYKoP0Jk=;qbLpRXiB3ysDdv67kmfvj3vb/tQ
 JrobnisDOQQJ+WZdWBQW57dZFXDYJaXjWJDAWszBZrddierzgjnTdC8I37NxVtBjIEMZuoohR
 RVv5/lcynIlMjCkFiAvv0g1PwypsGjuHwUxhbTQeV/vW4xiIxaah4GXDgxs12HgbOtRIgx1UH
 lndI6ET5Tyx4oCadcz5KFqNgCY9sjqoSzMcsf2M/8/U0inbx64+yk+hs1Kdew4W+npZyFxdwE
 RPGBVdxN9zREsdT4/Igsa5ZijjCwsvN5n36fxsKhOSXu3N3rkNK5yQ9wmMM3XOCS9kLYbiRdp
 mZxfUC0xs9CnJVb80r9lMN1WeNcOZhwf98w5KIj7eLx5OBJlQFuu7B/wkbJPiQ/HJbVqzMa0S
 jIqQS5ETUaQSYPJP5Nbtr7tYRw1w0Lcb7m01b1yl14LLR67UWAgEMQ43JOR3QjK98LkQYyZvR
 dSrExOT423zkwCZJYNu6ZjV4Zke7vNrDz++cojVfuYQDftclwX8kU0hCxMdlCglka/8kFLGgP
 9o2X8xBGS2FCu8B4a5fG7bPgXXF2GUeipiqpXWe2MbWVudbsNUlCHB6l0NlJ814+ZSfVkhVAD
 FaOoMkf8xVY/R6qrkVxvfe4iLuEhz/bjqJe1DrgwuyrIYHi06DXvIyMRGC62y/vc2xSY1KJPC
 BLRytU0JHCcurOtSg36akD/VCO1SfKQooZK4HkuTpOSXhL2600B4aWyL84okH7D9F/MfflzOx
 depH+DdK031t5PPQeAO0UrPgfuhhalat03d7M+2ft3b9wvxurmx/By1gAoBfrRjZvScvHicQE
 1hPyuPfDyi+HAQynmij+aOrFCzk1vvu0wEH14cq71Dow+TG3D1IIlgD5RYz8fRO6DLxuNjUP5
 fAfVDYrqVqcXyNexJca9j5LTRE6YgDdEtxlzMpoXtuw3j2TWuaKSvT2RolT7/hsXHGmlGOnEI
 QmFdO+qTNZA7/nb4R6UKJazneIlp/4E49DeLTJ8MiC/Q2OMBJyReJrH20SCY2xWyfUiXszt15
 RHrZ6cDSdVkNiXV7nyYIL1hqTyhOH/NQDax5Y9pJw/OO3DSVNm2AugGVrhnJUOleDGW87kI44
 tjrXhqOl2dCewTWm2/9NBxUsKaQBnPJusO9EO2eShs6w4jhxtLOQT81LxdzFhaSR+xSOd8A7c
 oGjd2fbZ7l7/DsORlqcsL5afuSc1dBQ5rPJcMXPVbvj7rpGnbZFIEG8inLU7Arfyll7oKNL+y
 9xQz7vUgWyM+1zEhQpdCwJ3Ycgyke1X6BiAuOi32BOp1GVduPxiIrlmWfzdIoN6UJXBNRWaon
 z5VB6lS625RUMPeMMPlqMhWzYrorIevJrYpaHrOTJ2xXU39KdtF4rw34eGRosOwVKQzB4Gtpt
 BlyxlVt6WiFryX3s1Urz1q5yR9WFtuMvU/bFI=


--f5u6kpjicn4mlvgm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Intel-wired-lan] [REGRESSION] e1000e heavy packet loss on
 Meteor Lake - 6.14.2
MIME-Version: 1.0

On 25/06/18 03:28PM, Marek Marczykowski-G=C3=B3recki wrote:
> On Fri, May 09, 2025 at 02:17:32AM +0200, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > On Fri, May 09, 2025 at 01:28:36AM +0200, Marek Marczykowski-G=C3=B3rec=
ki wrote:
> > > On Fri, May 09, 2025 at 01:13:28AM +0200, Paul Menzel wrote:
> > > > Dear Marek, dear Vitaly,
> > > >=20
> > > >=20
> > > > Am 09.05.25 um 00:41 schrieb Marek Marczykowski-G=C3=B3recki:
> > > > > On Thu, May 08, 2025 at 09:26:18AM +0300, Lifshits, Vitaly
> > > > > > On 4/21/2025 4:28 PM, Marek Marczykowski-G=C3=B3recki wrote:
> > > > > > > On Mon, Apr 21, 2025 at 03:19:12PM +0200, Marek Marczykowski-=
G=C3=B3recki wrote:
> > > > > > > > On Mon, Apr 21, 2025 at 03:44:02PM +0300, Lifshits, Vitaly =
wrote:
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > On 4/16/2025 3:43 PM, Marek Marczykowski-G=C3=B3recki wro=
te:
> > > > > > > > > > On Wed, Apr 16, 2025 at 03:09:39PM +0300, Lifshits, Vit=
aly wrote:
> > > > > > > > > > > Can you please also share the output of ethtool -i? I=
 would like to know the
> > > > > > > > > > > NVM version that you have on your device.
> > > > > > > > > >=20
> > > > > > > > > > driver: e1000e
> > > > > > > > > > version: 6.14.1+
> > > > > > > > > > firmware-version: 1.1-4
> > > > > > > > > > expansion-rom-version:
> > > > > > > > > > bus-info: 0000:00:1f.6
> > > > > > > > > > supports-statistics: yes
> > > > > > > > > > supports-test: yes
> > > > > > > > > > supports-eeprom-access: yes
> > > > > > > > > > supports-register-dump: yes
> > > > > > > > > > supports-priv-flags: yes
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Your firmware version is not the latest, can you check wi=
th the board
> > > > > > > > > manufacturer if there is a BIOS update to your system?
> > > > > > > >=20
> > > > > > > > I can check, but still, it's a regression in the Linux driv=
er - old
> > > > > > > > kernel did work perfectly well on this hw. Maybe new driver=
 tries to use
> > > > > > > > some feature that is missing (or broken) in the old firmwar=
e?
> > > > > > >=20
> > > > > > > A little bit of context: I'm maintaining the kernel package f=
or a Qubes
> > > > > > > OS distribution. While I can try to update firmware on my tes=
t system, I
> > > > > > > have no influence on what hardware users will use this kernel=
, and
> > > > > > > which firmware version they will use (and whether all the ven=
dors
> > > > > > > provide newer firmware at all). I cannot ship a kernel that i=
s known
> > > > > > > to break network on some devices.
> > > > > > >=20
> > > > > > > > > Also, you mentioned that on another system this issue doe=
sn't reproduce, do
> > > > > > > > > they have the same firmware version?
> > > > > > > >=20
> > > > > > > > The other one has also 1.1-4 firmware. And I re-checked, e1=
000e from
> > > > > > > > 6.14.2 works fine there.
> > > >=20
> > > > > > Thank you for your detailed feedback and for providing the requ=
ested
> > > > > > information.
> > > > > >=20
> > > > > > We have conducted extensive testing of this patch across multip=
le systems
> > > > > > and have not observed any packet loss issues. Upon comparing th=
e mentioned
> > > > > > setups, we noted that while the LAN controller is similar, the =
CPU differs.
> > > > > > We believe that the issue may be related to transitions in the =
CPU's low
> > > > > > power states.
> > > > > >=20
> > > > > > Consequently, we kindly request that you disable the CPU low po=
wer state
> > > > > > transitions in the S0 system state and verify if the issue pers=
ists. You can
> > > > > > disable this in the kernel parameters on the command line with =
idle=3Dpoll.
> > > > > > Please note that this command is intended for debugging purpose=
s only, as it
> > > > > > may result in higher power consumption.
> > > > >=20
> > > > > I tried with idle=3Dpoll, and it didn't help, I still see a lot o=
f packet
> > > > > losses. But I can also confirm that idle=3Dpoll makes the system =
use
> > > > > significantly more power (previously at 25-30W, with this option =
stays
> > > > > at about 42W).
> > > > >=20
> > > > > Is there any other info I can provide, enable some debug features=
 or
> > > > > something?
> > > > >=20
> > > > > I see the problem is with receiving packets - in my simple ping t=
est,
> > > > > the ping target sees all the echo requests (and respond to them),=
 but
> > > > > the responses aren't reaching ping back (and are not visible on t=
cpdump
> > > > > on the problematic system either).
> > > >=20
> > > > As the cause is still unclear, can the commit please be reverted in=
 the
> > > > master branch due adhere to Linux=E2=80=99 no-regression policy, so=
 that it can be
> > > > reverted from the stable series?
> > > >=20
> > > > Marek, did you also test 6.15 release candidates?
> > >=20
> > > The last test I did was on 6.15-rc3. I can re-test on -rc5.
> >=20
> > Same with 6.15-rc5.
>=20
> And the same issue still applies to 6.16-rc2. FWIW Qubes OS kernel has
> this buggy patch revered and nobody complained (contrary to the version
> with the patch included). Should I submit the revert patch?

Just submit a revert then =F0=9F=91=8D I have no authority here, but had go=
od
experience with just sending a revert patch in the past =F0=9F=A4=97

Cheers,
Chris

--f5u6kpjicn4mlvgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmhSwg4ACgkQwEfU8yi1
JYWccw/+K8uI558Nsi8UvcuVv0R4kgDY52VMb6rsW48vr5s6XE2PvdAngPESVbdH
6DHPqDSTl4aqXRMvpe7Ep3HEgYrCPiWUyM0po3CBJLvUiQ8xmhOQ1S5SEhiYZxaV
TAWWcJKMfuLdIJAbi8ZZi++gKP4U94+xm9lWWDQuGHJriebqWkQnNw6JgKCiYIuf
3ALKLYeooFUR5eBpWMwMXtBfU3L1RZBiBtV0JluC443SdI2fGpxQRLLdMZd9QLZH
mTSA8rTRldwCCm9HxxprbPM05EPjXhzAghRbWqlV0wFoCtUEOnErMK5HDT1heyiu
gcgWL+ZmG/zSp7gF1zyTS8aSrEX3Z87K1jeeNWpRn0G3q1SE7/PaFqbwHsAolb5v
zZmAZIDb6F6ZmzAMrsrIP77KsIYy9jSGPWq48za1ytznZB5uRBTDPAIC2HlZEG3m
DOgDryAfQn/DIhirE0Ao0EmWRLKdGa53cPBqTFoE9/N7CR1mhSK4bi/d0bbsnC7M
OT8IDgIO4z2MZhZJbo0oYPOUOeiyddcJhKoQZ0FetvfOtRuYugU993W4ZkBdm9vs
veRIy5m+cqu7jm7zO8f+5rqRviRPY8qzlLUMLHJUp7C+HPDVyVdyGDuqC2SHDiSr
VY0P6C7UiEbu9zZwMziLpRvBdRs67F6H50Uv3ifxGrs5yuL6Gh0=
=yH9B
-----END PGP SIGNATURE-----

--f5u6kpjicn4mlvgm--

