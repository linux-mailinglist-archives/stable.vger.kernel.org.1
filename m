Return-Path: <stable+bounces-3814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D76802724
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 20:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87371F211AA
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 19:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CB218B00;
	Sun,  3 Dec 2023 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="fq17eXjp"
X-Original-To: stable@vger.kernel.org
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A88AA5;
	Sun,  3 Dec 2023 11:52:41 -0800 (PST)
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vulcan.natalenko.name (Postfix) with ESMTPSA id 8748B15BEF1E;
	Sun,  3 Dec 2023 20:52:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1701633157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wMVCVObgzmwcJOuu+aKIsCcHKEPTod9TuG1xyf6Axo=;
	b=fq17eXjpweF2uu7lLww9PmutjPYA8Wyp/Ed8Ze8qJK1IOdpgGtedz02tO0BGyyL+BYPqJN
	aJOTo0L5YPR9F6Ftn//saGvvwlCP0u0FVAvSGqPYGjoQ1tH6B5OyYPHrjlJhzYgG8HjPxs
	rA9010E2996tc7FG/beDjAP29lfu5RE=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Greg KH <gregkh@linuxfoundation.org>,
 "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>,
 Basavaraj Natikar <bnatikar@amd.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, stable@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev,
 linux-bluetooth@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org
Subject: Re: Regression: Inoperative bluetooth, Intel chipset,
 mainline kernel 6.6.2+
Date: Sun, 03 Dec 2023 20:52:26 +0100
Message-ID: <12335218.O9o76ZdvQC@natalenko.name>
In-Reply-To: <4c8072b9-637b-a871-4dc1-3031aa3712bd@amd.com>
References:
 <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
 <93b7d9ca-788a-53cd-efdb-6a61b583c550@amd.com>
 <4c8072b9-637b-a871-4dc1-3031aa3712bd@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5733948.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5733948.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Sun, 03 Dec 2023 20:52:26 +0100
Message-ID: <12335218.O9o76ZdvQC@natalenko.name>
In-Reply-To: <4c8072b9-637b-a871-4dc1-3031aa3712bd@amd.com>
MIME-Version: 1.0

Hello.

On ned=C4=9Ble 3. prosince 2023 17:24:28 CET Basavaraj Natikar wrote:
>=20
> On 12/3/2023 9:46 PM, Basavaraj Natikar wrote:
> > On 12/3/2023 2:08 PM, Greg KH wrote:
> >> On Sun, Dec 03, 2023 at 03:32:52AM -0500, Kris Karas (Bug Reporting) w=
rote:
> >>> Greg KH wrote:
> >>>> Thanks for testing, any chance you can try 6.6.4-rc1?  Or wait a few
> >>>> hours for me to release 6.6.4 if you don't want to mess with a -rc
> >>>> release.
> >>> As I mentioned to Greg off-list (to save wasting other peoples' bandw=
idth),
> >>> I couldn't find 6.6.4-rc1.  Looking in wrong git tree?  But 6.6.4 is =
now
> >>> out, which I have tested and am running at the moment, albeit with the
> >>> problem commit from 6.6.2 backed out.
> >>>
> >>> There is no change with respect to this bug.  The problematic patch
> >>> introduced in 6.6.2 was neither reverted nor amended.  The "opcode 0x=
0c03
> >>> failed" lines to the kernel log continue to be present.
> >>>
> >>>> Also, is this showing up in 6.7-rc3?  If so, that would be a big hel=
p in
> >>>> tracking this down.
> >>> The bug shows up in 6.7-rc3 as well, exactly as it does here in 6.6.2=
+ and
> >>> in 6.1.63+.  The problematic patch bisected earlier appears identical=
ly (and
> >>> seems to have been introduced simultaneously) in these recent release=
s.
> >> Ok, in a way, this is good as that means I haven't missed a fix, but b=
ad
> >> in that this does affect everyone more.
> >>
> >> So let's start over, you found the offending commit, and nothing has
> >> fixed it, so what do we do?  xhci/amd developers, any ideas?
> > Can we enable RPM on specific controllers for AMD xHC 1.1
> > instead to cover all AMD xHC 1.1?=20
> >
> > Please find below the proposed changes and let me know if it is OK?
> > =20
> > Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> > Date:   Sun Dec 3 18:28:27 2023 +0530
> >
> >     xhci: Remove RPM as default policy to cover AMD xHC 1.1
> >
> >     xHC 1.1 runtime PM as default policy causes issues on few AMD contr=
ollers.
> >     Hence remove RPM as default policy to cover AMD xHC 1.1 and add only
> >     AMD USB host controller (1022:43f7) which has RPM support.=20
> >
> >     Fixes: 4baf12181509 ("xhci: Loosen RPM as default policy to cover f=
or AMD xHC 1.1")
> >     Link: https://lore.kernel.org/all/2023120329-length-strum-9ee1@greg=
kh
> >     Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >
> > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > index 95ed9404f6f8..7ffd6b8227cc 100644
> > --- a/drivers/usb/host/xhci-pci.c
> > +++ b/drivers/usb/host/xhci-pci.c
> > @@ -535,7 +535,7 @@ static void xhci_pci_quirks(struct device *dev, str=
uct xhci_hcd *xhci)
> >         /* xHC spec requires PCI devices to support D3hot and D3cold */
> >         if (xhci->hci_version >=3D 0x120)
> >                 xhci->quirks |=3D XHCI_DEFAULT_PM_RUNTIME_ALLOW;
> > -       else if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD && xhci->hci_ver=
sion >=3D 0x110)
> > +       else if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD && pdev->vendor =
=3D=3D 0x43f7)
>=20
> sorry its=20
> pdev->device =3D=3D 0x43f7
>=20
> Incorrect ---> else if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD && pdev->ve=
ndor =3D=3D 0x43f7)
> correct line --> else if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD && pdev->=
device =3D=3D 0x43f7)
>=20
> >                 xhci->quirks |=3D XHCI_DEFAULT_PM_RUNTIME_ALLOW;
> >
> >         if (xhci->quirks & XHCI_RESET_ON_RESUME)

Given the following hardware:

[~]> lspci -nn | grep -i usb
06:00.4 USB controller [0c03]: Realtek Semiconductor Co., Ltd. RTL811x EHCI=
 host controller [10ec:816d] (rev 1a)
07:00.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse U=
SB 3.0 Host Controller [1022:149c]
07:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse U=
SB 3.0 Host Controller [1022:149c]
0f:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse U=
SB 3.0 Host Controller [1022:149c]

and v6.6.4 kernel, without this patch:

[~]> LC_TIME=3DC jctl -kb -1 --grep 'hci version'
Dec 03 13:22:03 archlinux kernel: xhci_hcd 0000:07:00.1: hcc params 0x0278f=
fe5 hci version 0x110 quirks 0x0000000200000410
Dec 03 13:22:03 archlinux kernel: xhci_hcd 0000:07:00.3: hcc params 0x0278f=
fe5 hci version 0x110 quirks 0x0000000200000410
Dec 03 13:22:03 archlinux kernel: xhci_hcd 0000:0f:00.3: hcc params 0x0278f=
fe5 hci version 0x110 quirks 0x0000000200000410

With the patch applied:

[~]> LC_TIME=3DC jctl -kb --grep 'hci version'
Dec 03 20:46:59 archlinux kernel: xhci_hcd 0000:07:00.1: hcc params 0x0278f=
fe5 hci version 0x110 quirks 0x0000000000000410
Dec 03 20:46:59 archlinux kernel: xhci_hcd 0000:07:00.3: hcc params 0x0278f=
fe5 hci version 0x110 quirks 0x0000000000000410
Dec 03 20:46:59 archlinux kernel: xhci_hcd 0000:0f:00.3: hcc params 0x0278f=
fe5 hci version 0x110 quirks 0x0000000000000410

(note the difference in `quirks` as expected)

Hence, feel free to add:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Link: https://lore.kernel.org/lkml/5993222.lOV4Wx5bFT@natalenko.name/

Thank you.

> >
> > Thanks,
> > --
> > Basavaraj
> >
> >> thanks,
> >>
> >> greg k-h
>=20
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5733948.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmVs3HoACgkQil/iNcg8
M0vXgxAAnCuDbSTJjvqeMrlLQN9AR7j2d3d+p+pxye+TJs8stCZsuDnx2hRHBKKk
8ELfC1MekYFRV+z8bGHH9GrZ5I+coJH2/Wu0oCljzZ5eYJgDoqkbgMIUYpV5szF4
UHnn8jeaPAWNylB+YWXiapr94LmLEJmaInIgQdcN8QKB4XJWWlCzM8XCpkHocp6Q
5aObF6YE3c0Bw6pm/qRmTzYsYWvhkKgc01jmpHdavVjVIebwdaBf0Smnp3xZNE0Z
iprlBujByKSaGSRaOccRSnu2hJ/IlOB1ccRzJJ5iXTbih2m6d483+VVtphKTiCSc
GsPE+vdGjfh6UFXiLi19OoBc4AlzPVAOMDz2yR1L61RMBiIpKK4C3ZnoNRTPHSbu
CLdud76hl0jIDocB8/0mkYKap5OOFg62Ksm0V1TvKoAk2Br1B6uu9RmkrSsOW3oN
2JM6vqc0IjqD0EbRLGHZa9LhFQTcQR0+wD24Zq5zQAizQLo1R8PTUrd/avwo48Kv
bmY/Wh5B5gaVxvfUdgtZnGSbMIBcNIGndzEQic38qw068LgtbZoxUbuvR5eIzu8u
CxUcMg4oZFujQz4XD8VUkAdwfVFbaABehIomhF2U+IU2RVjq0hnZPgL3G3ZUNx/O
Dl7/Y0NGkbG+31ELB+cMgJeR1XZV1szcfV8ydb4WirwLUQ+CTSI=
=UPkH
-----END PGP SIGNATURE-----

--nextPart5733948.DvuYhMxLoT--




