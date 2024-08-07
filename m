Return-Path: <stable+bounces-65941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A9F94AED0
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 19:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23E5B29902
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C6113CA9C;
	Wed,  7 Aug 2024 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="lGEqKG9g"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02047829C;
	Wed,  7 Aug 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051415; cv=none; b=UP86OJqjxLQvEFb1Ub2bRZB7ncLsluBVXIvxrDVoQy1JI7sQpLw4moMtJfJ2mGUHLDy1xkFLesq9fGLbQ92K1dV2Qe5/WA/p7gCXwscgOb/m1MYEchGzOscGr9676yQJQSfO/tKedy/6RcF3KtZnYDlQEV41ctLmHBhrDA6lxz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051415; c=relaxed/simple;
	bh=DeHERJlAyVaAM7mD5mBWKnAuOj19JGCsB8/0dA8JQIs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iXsYNq+4IKDGBSNHXgr6OBD+OWwLlyFAZjqpkH+fqmz2mrzSEPuJH32WxsjdrWN2EXrmCNzvHpDdZv9lAS4mu0cmhiou0+P9oI2MlU+Ue0HMuwzp32Ey5h/Wajg3yR69Knm00Nqe/XDxS5Lag9kTb2LE0LXiJHA+VL8hK886RBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=lGEqKG9g; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1723051392; x=1723656192; i=christian@heusel.eu;
	bh=nsT5DPVZKkmpZvH2h/IqV+PYUy007MA2rcGXRfKet7o=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lGEqKG9gHAPutaeUlow/V/51fwngpV5VXxDJwtjV+S/OaV57MX/iQ/VfBn8INNxL
	 BKv0buAEsNbmkZOS9V4sGxaVeYckS2TekiJoJEwOn2RjawHt9jxMGxu2klr+9mtVH
	 dZZyQH22NBQEKlhDI9WQWi5yek4gvVOxJk2F28KPR8ThLHosE4kTVzGtXUPlAIrBK
	 nadtoSkDPM5jTyGlqsApyHZEaKdjlfeXACRoE0qdlYjSKWBwxKBWcpYnXoBO3Yop4
	 9N9yCGfXHn/r4hsEcyaboi9W9Aw0UD/yXkQmfvehw3D55uExFzLcowSj1u90ymtY+
	 CL47Bi7RlniRWh5OdQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.64.180]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M1INQ-1sdOH40B7i-006v2B; Wed, 07 Aug 2024 19:23:12 +0200
Date: Wed, 7 Aug 2024 19:23:10 +0200
From: Christian Heusel <christian@heusel.eu>
To: Igor Pylypiv <ipylypiv@google.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, regressions@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [REGRESSION][BISECTED][STABLE] hdparm errors since 28ab9769117c
Message-ID: <0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lq4zqbwcozebnqgu"
Content-Disposition: inline
X-Provags-ID: V03:K1:re/u57c9LiiKnOyxy/v/YoI96ZGo5b3UusYKY4512VsUbItP0ZV
 bE4dvipEOOfmGpVNc8QBsHKy5QTyB83NR2EHdIkhEAJ0Vlb9fYnAWmjJ97KkHw+LRGxRWM/
 BvZE9CKF3ZblB5bu91CIBMRXlPQ9KWnRU0zH70XA37W0PQWVO8tRuGc1K5H6LOmglNBrtMc
 XbTYbHxNueeEujOf4hsSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Sgj5yfUsPnI=;oWv0C/OeJkqW7tOPGUStrVRIg+/
 clEXJBTWpkSj1ib9dZnlcTP4wji5U9D1fjiMd/u6iBiUwMbKvxgO0vuL+ESDLvk3XUo9h1eDI
 YwEIwMie+mDMQEpOjxUfdPnd6gV4GD8NFKyQ7b3cidAQZYB/hZsOuQ9AKdzmPNk8JywiXwH0k
 yK9GBjVC/KKJEMVtFWEi3m5lu0M0NscHfoBrL1TGgJ+4SDJfkaNLvM1q6AdUSLTwghIKe3U5B
 8gqhtH9LE3P4b1Q+0uMj1ENYFyQI15dMAqRlCLTokkbhYfyL42iDda4K/dFmf8XZ7ZUNuzaHN
 Bct0LxO8XGKt0CwT0ZdmL3fwWZujNTOHWx+ycyS8GyyUzTiXVweZIrq2BNffUwm4jnyu0k7on
 QK8w6vCzo4ARHnWpc8Z169WhDdTjeFKXy6Zj38iicPs5IzKkQXWnq5BqZwSkGZXyQoZ/sAmqT
 a6Vd5vKV8FQGy848gqiJ+Hy1FBzsF60hKE0+DB2ia+dEMbAerPBSXuA/SPw1R9Yy9zXBcEcPI
 irt4ca9BD5u/XH7rPg8yi8WJi5ft1B8EBqr1xtb9Jja6m8C+6NkirRLe2KwIe45RiKukwTfWh
 Pfw3BQcg4Xn4dzruJ7iBtwNhODQmf5Itr9cD+9hTwXD59eOTlJ/Mr7Yv3FtFTDGuWPfkdcaOr
 vfiodr7hgCO4l2cv7KJFnuTattUVv6WGp9x8ovs3yRjLRNTrXoSZF1K68tWe079CD/o2AwpA+
 +gjyqb1zadWqWsmHaAAftOFhjgW0pODlg==


--lq4zqbwcozebnqgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Igor, hello Niklas,

on my NAS I am encountering the following issue since v6.6.44 (LTS),
when executing the hdparm command for my WD-WCC7K4NLX884 drives to get
the active or standby state:

    $ hdparm -C /dev/sda
    /dev/sda:
    SG_IO: bad/missing sense data, sb[]:  f0 00 01 00 50 40 ff 0a 00 00 78 =
00 00 1d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     drive state is:  unknown


While the expected output is the following:

    $ hdparm -C /dev/sda
    /dev/sda:
     drive state is:  active/idle

I did a bisection within the stable series and found the following
commit to be the first bad one:

    28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for CK_COND=3D1 =
and no error")

According to kernel.dance the same commit was also backported to the
v6.10.3 and v6.1.103 stable kernels and I could not find any commit or
pending patch with a "Fixes:" tag for the offending commit.

So far I have not been able to test with the mainline kernel as this is
a remote device which I couldn't rescue in case of a boot failure. Also
just for transparency it does have the out of tree ZFS module loaded,
but AFAIU this shouldn't be an issue here, as the commit seems clearly
related to the error. If needed I can test with an untainted mainline
kernel on Friday when I'm near the device.

I have attached the output of hdparm -I below and would be happy to
provide further debug information or test patches.

Cheers,
Christian

---

#regzbot introduced: 28ab9769117c
#regzbot title: ata: libata-scsi: Sense data errors breaking hdparm with WD=
 drives

---

$ pacman -Q hdparm
hdparm 9.65-2

$ hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
	Model Number:       WDC WD40EFRX-68N32N0
	Serial Number:      WD-WCC7K4NLX884
	Firmware Revision:  82.00A82
	Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev 2.5, S=
ATA Rev 2.6, SATA Rev 3.0
Standards:
	Used: unknown (minor revision code 0x006d)=20
	Supported: 10 9 8 7 6 5=20
	Likely used: 10
Configuration:
	Logical		max	current
	cylinders	16383	0
	heads		16	0
	sectors/track	63	0
	--
	LBA    user addressable sectors:   268435455
	LBA48  user addressable sectors:  7814037168
	Logical  Sector size:                   512 bytes
	Physical Sector size:                  4096 bytes
	Logical Sector-0 offset:                  0 bytes
	device size with M =3D 1024*1024:     3815447 MBytes
	device size with M =3D 1000*1000:     4000787 MBytes (4000 GB)
	cache/buffer size  =3D unknown
	Form Factor: 3.5 inch
	Nominal Media Rotation Rate: 5400
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max =3D 16	Current =3D 16
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6=20
	     Cycle time: min=3D120ns recommended=3D120ns
	PIO: pio0 pio1 pio2 pio3 pio4=20
	     Cycle time: no flow control=3D120ns  IORDY flow control=3D120ns
Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	NOP cmd
	   *	DOWNLOAD_MICROCODE
	    	Power-Up In Standby feature set
	   *	SET_FEATURES required to spinup after power up
	    	SET_MAX security extension
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	General Purpose Logging feature set
	   *	64-bit World wide name
	   *	IDLE_IMMEDIATE with UNLOAD
	   *	WRITE_UNCORRECTABLE_EXT command
	   *	{READ,WRITE}_DMA_EXT_GPL commands
	   *	Segmented DOWNLOAD_MICROCODE
	   *	Gen1 signaling speed (1.5Gb/s)
	   *	Gen2 signaling speed (3.0Gb/s)
	   *	Gen3 signaling speed (6.0Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Host-initiated interface power management
	   *	Phy event counters
	   *	Idle-Unload when NCQ is active
	   *	NCQ priority information
	   *	READ_LOG_DMA_EXT equivalent to READ_LOG_EXT
	   *	DMA Setup Auto-Activate optimization
	   *	Device-initiated interface power management
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
	   *	SCT Write Same (AC2)
	   *	SCT Error Recovery Control (AC3)
	   *	SCT Features Control (AC4)
	   *	SCT Data Tables (AC5)
	    	unknown 206[12] (vendor specific)
	    	unknown 206[13] (vendor specific)
	   *	DOWNLOAD MICROCODE DMA command
	   *	WRITE BUFFER DMA command
	   *	READ BUFFER DMA command
Security:=20
	Master password revision code =3D 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
		supported: enhanced erase
	504min for SECURITY ERASE UNIT. 504min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 50014ee2647735a1
	NAA		: 5
	IEEE OUI	: 0014ee
	Unique ID	: 2647735a1
Checksum: correct

--lq4zqbwcozebnqgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmazrX4ACgkQwEfU8yi1
JYWKRBAAuWTcdMItCNZaRa8QUD3EXBVDf23VX0879nToFEt5rbGnBXEH/SCvhhJ5
uiM59L6kCsOFMhqFruuCglkKooxrR30aHMNRBj2F4UMYXBvrfgAoI1aWp4EgE+WC
mBC5w87QzOHoVh9edDinqSmuu8upFB5Fl6xSrIpg8+Sk8Nx5gL3Lj3nzPD4NLF9W
rgMxX7OQEWMyEN9IFvVQd/IfOdt3JFTo7RZTxmvFK8j9b3m8LXxGDqJzcUHS5ytE
aXFtcoiQxE3NXkU11p9rHvjDeSVsF4SakJ+a6HX+pGMCQhauvydW2ap9cIhhFPww
I/7TdHa1cZit3FMDVsSI8aAnO8L5FsPCL806Q3uqqpp+UePVH1YXcIT6HCudiyEI
s8qgTsQlscaDHTpjZG71dHMRZxod4IZ9XL/fYvD0RD/566/Pf65Aks0/O44ahcH6
Y6opytCJ3hlgtocu3hMSqGF0vrwITSB0nVxJANixYjxhLMQTChVxien2znoD6uqx
A3eIU6x6s1DqyFJZLdn6B76XqwVPgLSGvshHNET4mEpMmEcvF4YymAmhT871rcAP
f2rOtfEBU1sp7Tr3C2uWU19oOES2JPyRGVlPoFofcZE1PAdaJozWZwzMnzy34lYb
qUA2JNqkGVbBDPIytlwjtIXiwcnh7yulkSSxn+PgQcmGFHhU/uk=
=Lqj2
-----END PGP SIGNATURE-----

--lq4zqbwcozebnqgu--

