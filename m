Return-Path: <stable+bounces-45446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 079788C9F8F
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 17:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015201C21BFD
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F6136E05;
	Mon, 20 May 2024 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=boehmke.net header.i=@boehmke.net header.b="Xy/SKfDg"
X-Original-To: stable@vger.kernel.org
Received: from mail.boehmke.net (elch8.fetterelch.de [159.69.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F44136E0E;
	Mon, 20 May 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.48.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218500; cv=none; b=Z4XWklbBxCZOECe4umc23NpQLd3akJiQVwmlNsZzQ/qnVGRfIxaZ5BJ8TSmwa7x35e80qvbH8yd4UblTOf49YjF6dk7zEU030TZ7vCocBFjjZ9aszdkGZzvu0tZREnc0kWlD/1gj+o2btqqpooCH4lT1qDDcLklP4IhHqraQGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218500; c=relaxed/simple;
	bh=BN60uORZsjlcDaULowDssvkw3gPfsVpDgKsK0GfhLQQ=;
	h=From:Content-Type:In-Reply-To:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=HQjEm/+xj75TrjNxJ0SSnlaf5tEo12+gH5g4/eRIlkwxuFrJoHIAMk8b0O2QkjW6iL84hQUW0DWS2MAREPZmDlcfv6VUGGzcPp6Vhmc9nHsPE5wm0b91B1Ld9KwN529pq1EoXtqRKO/GNfOeXlj9sNGvxQjFxZtgwl1K2y6GPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=boehmke.net; spf=pass smtp.mailfrom=boehmke.net; dkim=pass (2048-bit key) header.d=boehmke.net header.i=@boehmke.net header.b=Xy/SKfDg; arc=none smtp.client-ip=159.69.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=boehmke.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=boehmke.net
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id BE731811F8;
	Mon, 20 May 2024 17:12:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boehmke.net; s=dkim;
	t=1716217964; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6FgxihOOgpJm7bkPRvazUkxhISTTipSw2tHtttDtOXM=;
	b=Xy/SKfDgnqdDu4Mr4aiaYjv1zhe8wzQxTzhvL/qK6y/V8so75msqXQSzXZLbOLig9TE+1V
	DvNXa2EgTq3utPPxJps6alV1zLgLdMHvcxNEBZPl3K6bOcU/9bO1P5iJJzT5jMjuV3WQ8G
	xdRpnhk+j+wMV5tI4uM8ye2yvhlNGUf2gqgghFRx+CLTbDJjjQSSOtewWOVo5Cl1stYiHV
	d12nYFEbq7eW20OP1i+b3JPV++WsseEWzxopJnMDYZN7JNQArURMJyuvXUywFUXbr0US5B
	4aG4ANw2t0W3RhN39kYHKQf4mWankHj9BUHG63+kqINM/KMr6oGXK3RmTM3ZBQ==
From: =?utf-8?q?Benjamin_B=C3=B6hmke?= <benjamin@boehmke.net>
Content-Type: multipart/mixed; boundary="----=_=-_OpenGroupware_org_NGMime-97-1716217960.187497-2------"
In-Reply-To: <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu> <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
Date: Mon, 20 May 2024 17:12:40 +0200
Cc: "Christian Heusel" <christian@heusel.eu>, "Linux regressions mailing list" <regressions@lists.linux.dev>, "Gia" <giacomo.gio@gmail.com>, =?utf-8?q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, =?utf-8?q?stable=40vger=2Ekernel=2Eorg?= <stable@vger.kernel.org>, =?utf-8?q?kernel=40micha=2Ezone?= <kernel@micha.zone>, "Andreas Noever" <andreas.noever@gmail.com>, "Michael Jamet" <michael.jamet@intel.com>, "Mika Westerberg" <mika.westerberg@linux.intel.com>, "Yehezkel Bernat" <YehezkelShB@gmail.com>, =?utf-8?q?linux-usb=40vger=2Ekernel=2Eorg?= <linux-usb@vger.kernel.org>, =?utf-8?q?S=2C_Sanath?= <Sanath.S@amd.com>
To: "Mario Limonciello" <mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <61-664b6880-3-6826fc80@79948770>
Subject: =?utf-8?q?Re=3A?= [REGRESSION][BISECTED] =?utf-8?q?=22xHCI?= host 
 controller not =?utf-8?q?responding=2C?= assume =?utf-8?q?dead=22?= on 
 stable kernel > =?utf-8?q?6=2E8=2E7?=
User-Agent: SOGoMail 5.10.0
X-Last-TLS-Session-Version: None

------=_=-_OpenGroupware_org_NGMime-97-1716217960.187497-2------
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Length: 2400

On Monday, May 20, 2024 16:41 CEST, Mario Limonciello <mario.limonciell=
o@amd.com> wrote:

> On 5/20/2024 09:39, Christian Heusel wrote:
> > On 24/05/06 02:53PM, Linux regression tracking (Thorsten Leemhuis) =
wrote:
> >> [CCing Mario, who asked for the two suspected commits to be backpo=
rted]
> >>
> >> On 06.05.24 14:24, Gia wrote:
> >>> Hello, from 6.8.7=3D>6.8.8 I run into a similar problem with my C=
aldigit
> >>> TS3 Plus Thunderbolt 3 dock.
> >>>
> >>> After the update I see this message on boot "xHCI host controller=
 not
> >>> responding, assume dead" and the dock is not working anymore. Ker=
nel
> >>> 6.8.7 works great.
> >=20
> > We now have some further information on the matter as somebody was =
kind
> > enough to bisect the issue in the [Arch Linux Forums][0]:
> >=20
> >      cc4c94a5f6c4 ("thunderbolt: Reset topology created by the boot=
 firmware")
> >=20
> > This is a stable commit id, the relevant mainline commit is:
> >=20
> >      59a54c5f3dbd ("thunderbolt: Reset topology created by the boot=
 firmware")
> >=20
> > The other reporter created [a issue][1] in our bugtracker, which I'=
ll
> > leave here just for completeness sake.
> >=20
> > Reported-by: Benjamin B=C3=B6hmke <benjamin@boehmke.net>
> > Reported-by: Gia <giacomo.gio@gmail.com>
> > Bisected-by: Benjamin B=C3=B6hmke <benjamin@boehmke.net>
> >=20
> > The person doing the bisection also offered to chime in here if fur=
ther
> > debugging is needed!
> >=20
> > Also CC'ing the Commitauthors & Subsystem Maintainers for this repo=
rt.
> >=20
> > Cheers,
> > Christian
> >=20
> > [0]: https://bbs.archlinux.org/viewtopic.php?pid=3D2172526
> > [1]: https://gitlab.archlinux.org/archlinux/packaging/packages/linu=
x/-/issues/48
> >=20
> > #regzbot introduced: 59a54c5f3dbd
> > #regzbot link: https://gitlab.archlinux.org/archlinux/packaging/pac=
kages/linux/-/issues/48
>=20
> As I mentioned in my other email I would like to collate logs onto a=20
> kernel Bugzilla.  With these two cases:
>=20
> thunderbolt.dyndbg=3D+p
> thunderbolt.dyndbg=3D+p thunderbolt.host=5Freset=3Dfalse
>=20
> Also what is the value for:
>=20
> $ cat /sys/bus/thunderbolt/devices/domain0/iommu=5Fdma=5Fprotection

I attached the requested kernel logs as text files (hope this is ok).
In both cases I used the stable ArchLinux kernel 6.9.1

The iommu=5Fdma=5Fprotection is both cases "1".

Best Regards
Benjamin

------=_=-_OpenGroupware_org_NGMime-97-1716217960.187497-2------
Content-Type: text/plain
Content-Disposition: attachment; filename="dmesg_tb_dbg__reset_false.txt"
Content-Transfer-Encoding: quoted-printable
Content-Length: 112196

[    0.000000] Linux version 6.9.1-arch1-1 (linux@archlinux) (gcc (GCC)=
 14.1.1 20240507, GNU ld (GNU Binutils) 2.42.0) #1 SMP PREEMPT=5FDYNAMI=
C Fri, 17 May 2024 16:56:38 +0000
[    0.000000] Command line: initrd=3D\initramfs-linux.img root=3DLABEL=
=3Darch rw resume=3Dswap thunderbolt.dyndbg=3D+p thunderbolt.host=5Fres=
et=3Dfalse
[    0.000000] x86/split lock detection: #AC: crashing the kernel on ke=
rnel split=5Flocks and warning on user-space split=5Flocks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] u=
sable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] u=
sable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003f7b2fff] u=
sable
[    0.000000] BIOS-e820: [mem 0x000000003f7b3000-0x0000000042f55fff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000042f56000-0x0000000043041fff] A=
CPI data
[    0.000000] BIOS-e820: [mem 0x0000000043042000-0x0000000043170fff] A=
CPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000043171000-0x0000000043efefff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000043eff000-0x0000000043efffff] u=
sable
[    0.000000] BIOS-e820: [mem 0x0000000043f00000-0x0000000049ffffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x000000004a200000-0x000000004a3fffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x000000004b000000-0x00000000503fffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000008afbfffff] u=
sable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.8 by American Megatrends
[    0.000000] efi: ACPI=3D0x430cc000 ACPI 2.0=3D0x430cc014 SMBIOS=3D0x=
43c0f000 SMBIOS 3.0=3D0x43c0e000 MEMATTR=3D0x3b7ba018 ESRT=3D0x3bf08098=
 INITRD=3D0x38a01218 RNG=3D0x42f85018=20
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem72: MMIO range=3D[0xc0000000-0xcfffffff] =
(256MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] efi: Not removing mem73: MMIO range=3D[0xfe000000-0xfe01=
0fff] (68KB) from e820 map
[    0.000000] efi: Not removing mem74: MMIO range=3D[0xfec00000-0xfec0=
0fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem75: MMIO range=3D[0xfed00000-0xfed0=
0fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem77: MMIO range=3D[0xfee00000-0xfee0=
0fff] (4KB) from e820 map
[    0.000000] efi: Remove mem78: MMIO range=3D[0xff000000-0xffffffff] =
(16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.4.0 present.
[    0.000000] DMI: TUXEDO TUXEDO InfinityBook Pro Gen7 (MK1)/PHxARX1=5F=
PHxAQF1, BIOS N.1.05A07 11/07/2022
[    0.000000] tsc: Detected 2700.000 MHz processor
[    0.000000] tsc: Detected 2688.000 MHz TSC
[    0.000373] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> =
reserved
[    0.000375] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000380] last=5Fpfn =3D 0x8afc00 max=5Farch=5Fpfn =3D 0x400000000
[    0.000383] MTRR map: 5 entries (3 fixed + 2 variable; max 23), buil=
t from 10 variable MTRRs
[    0.000384] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC=
- WT =20
[    0.000777] last=5Fpfn =3D 0x43f00 max=5Farch=5Fpfn =3D 0x400000000
[    0.012685] esrt: Reserving ESRT space from 0x000000003bf08098 to 0x=
000000003bf08170.
[    0.012689] e820: update [mem 0x3bf08000-0x3bf08fff] usable =3D=3D> =
reserved
[    0.012699] Using GB pages for direct mapping
[    0.012699] Incomplete global flushes, disabling PCID
[    0.012847] Secure boot disabled
[    0.012847] RAMDISK: [mem 0x32aff000-0x33afdfff]
[    0.012873] ACPI: Early table checksum verification disabled
[    0.012875] ACPI: RSDP 0x00000000430CC014 000024 (v02 ALASKA)
[    0.012878] ACPI: XSDT 0x00000000430CB728 000104 (v01 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.012882] ACPI: FACP 0x000000004303F000 000114 (v06 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.012885] ACPI: DSDT 0x0000000042FC6000 078134 (v02 ALASKA A M I  =
  01072009 INTL 20200717)
[    0.012888] ACPI: FACS 0x000000004316F000 000040
[    0.012889] ACPI: FIDT 0x0000000042FC5000 00009C (v01 ALASKA A M I  =
  01072009 AMI  00010013)
[    0.012891] ACPI: SSDT 0x0000000043041000 00038C (v02 PmaxDv Pmax=5F=
Dev 00000001 INTL 20200717)
[    0.012893] ACPI: SSDT 0x0000000042FBF000 005D0B (v02 CpuRef CpuSsdt=
  00003000 INTL 20200717)
[    0.012895] ACPI: SSDT 0x0000000042FBC000 002AA1 (v02 SaSsdt SaSsdt =
  00003000 INTL 20200717)
[    0.012897] ACPI: SSDT 0x0000000042FB8000 0033D3 (v02 INTEL  IgfxSsd=
t 00003000 INTL 20200717)
[    0.012899] ACPI: SSDT 0x0000000042FAA000 00D337 (v02 INTEL  TcssSsd=
t 00001000 INTL 20200717)
[    0.012901] ACPI: HPET 0x0000000043040000 000038 (v01 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.012902] ACPI: APIC 0x0000000042FA9000 0001DC (v05 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.012904] ACPI: MCFG 0x0000000042FA8000 00003C (v01 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.012906] ACPI: SSDT 0x0000000042FA1000 00669F (v02 ALASKA AdlP=5F=
Rvp 00001000 INTL 20200717)
[    0.012908] ACPI: SSDT 0x0000000042F9F000 001E89 (v02 ALASKA Ther=5F=
Rvp 00001000 INTL 20200717)
[    0.012910] ACPI: UEFI 0x00000000430B1000 000048 (v01 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.012911] ACPI: NHLT 0x0000000042F9E000 00002D (v00 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.012913] ACPI: LPIT 0x0000000042F9D000 0000CC (v01 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.012915] ACPI: SSDT 0x0000000042F99000 002A83 (v02 ALASKA PtidDev=
c 00001000 INTL 20200717)
[    0.012917] ACPI: SSDT 0x0000000042F96000 002357 (v02 ALASKA TbtType=
C 00000000 INTL 20200717)
[    0.012919] ACPI: DBGP 0x0000000042F95000 000034 (v01 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.012920] ACPI: DBG2 0x0000000042F94000 000054 (v00 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.012922] ACPI: SSDT 0x0000000042F92000 0014F5 (v02 ALASKA UsbCTab=
l 00001000 INTL 20200717)
[    0.012924] ACPI: DMAR 0x0000000042F91000 000088 (v02 INTEL  EDK2   =
  00000002      01000013)
[    0.012926] ACPI: SSDT 0x0000000042F90000 000CAA (v02 INTEL  xh=5Fad=
lLP 00000000 INTL 20200717)
[    0.012928] ACPI: SSDT 0x0000000042F8C000 003AEA (v02 SocGpe SocGpe =
  00003000 INTL 20200717)
[    0.012930] ACPI: SSDT 0x0000000042F89000 002B2A (v02 SocCmn SocCmn =
  00003000 INTL 20200717)
[    0.012931] ACPI: BGRT 0x0000000042F88000 000038 (v01 ALASKA A M I  =
  01072009 AMI  00010013)
[    0.012933] ACPI: PHAT 0x0000000042F87000 000611 (v00 ALASKA A M I  =
  00000005 MSFT 0100000D)
[    0.012935] ACPI: WSMT 0x0000000042F9C000 000028 (v01 ALASKA A M I  =
  01072009 AMI  00010013)
[    0.012937] ACPI: FPDT 0x0000000042F86000 000044 (v01 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.012938] ACPI: Reserving FACP table memory at [mem 0x4303f000-0x4=
303f113]
[    0.012939] ACPI: Reserving DSDT table memory at [mem 0x42fc6000-0x4=
303e133]
[    0.012940] ACPI: Reserving FACS table memory at [mem 0x4316f000-0x4=
316f03f]
[    0.012940] ACPI: Reserving FIDT table memory at [mem 0x42fc5000-0x4=
2fc509b]
[    0.012941] ACPI: Reserving SSDT table memory at [mem 0x43041000-0x4=
304138b]
[    0.012941] ACPI: Reserving SSDT table memory at [mem 0x42fbf000-0x4=
2fc4d0a]
[    0.012942] ACPI: Reserving SSDT table memory at [mem 0x42fbc000-0x4=
2fbeaa0]
[    0.012942] ACPI: Reserving SSDT table memory at [mem 0x42fb8000-0x4=
2fbb3d2]
[    0.012943] ACPI: Reserving SSDT table memory at [mem 0x42faa000-0x4=
2fb7336]
[    0.012943] ACPI: Reserving HPET table memory at [mem 0x43040000-0x4=
3040037]
[    0.012944] ACPI: Reserving APIC table memory at [mem 0x42fa9000-0x4=
2fa91db]
[    0.012944] ACPI: Reserving MCFG table memory at [mem 0x42fa8000-0x4=
2fa803b]
[    0.012945] ACPI: Reserving SSDT table memory at [mem 0x42fa1000-0x4=
2fa769e]
[    0.012945] ACPI: Reserving SSDT table memory at [mem 0x42f9f000-0x4=
2fa0e88]
[    0.012946] ACPI: Reserving UEFI table memory at [mem 0x430b1000-0x4=
30b1047]
[    0.012946] ACPI: Reserving NHLT table memory at [mem 0x42f9e000-0x4=
2f9e02c]
[    0.012947] ACPI: Reserving LPIT table memory at [mem 0x42f9d000-0x4=
2f9d0cb]
[    0.012947] ACPI: Reserving SSDT table memory at [mem 0x42f99000-0x4=
2f9ba82]
[    0.012948] ACPI: Reserving SSDT table memory at [mem 0x42f96000-0x4=
2f98356]
[    0.012948] ACPI: Reserving DBGP table memory at [mem 0x42f95000-0x4=
2f95033]
[    0.012949] ACPI: Reserving DBG2 table memory at [mem 0x42f94000-0x4=
2f94053]
[    0.012949] ACPI: Reserving SSDT table memory at [mem 0x42f92000-0x4=
2f934f4]
[    0.012950] ACPI: Reserving DMAR table memory at [mem 0x42f91000-0x4=
2f91087]
[    0.012950] ACPI: Reserving SSDT table memory at [mem 0x42f90000-0x4=
2f90ca9]
[    0.012951] ACPI: Reserving SSDT table memory at [mem 0x42f8c000-0x4=
2f8fae9]
[    0.012951] ACPI: Reserving SSDT table memory at [mem 0x42f89000-0x4=
2f8bb29]
[    0.012951] ACPI: Reserving BGRT table memory at [mem 0x42f88000-0x4=
2f88037]
[    0.012952] ACPI: Reserving PHAT table memory at [mem 0x42f87000-0x4=
2f87610]
[    0.012952] ACPI: Reserving WSMT table memory at [mem 0x42f9c000-0x4=
2f9c027]
[    0.012953] ACPI: Reserving FPDT table memory at [mem 0x42f86000-0x4=
2f86043]
[    0.013331] No NUMA configuration found
[    0.013332] Faking a node at [mem 0x0000000000000000-0x00000008afbff=
fff]
[    0.013333] NODE=5FDATA(0) allocated [mem 0x8afbfb000-0x8afbfffff]
[    0.013358] Zone ranges:
[    0.013359]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.013360]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.013361]   Normal   [mem 0x0000000100000000-0x00000008afbfffff]
[    0.013361]   Device   empty
[    0.013362] Movable zone start for each node
[    0.013362] Early memory node ranges
[    0.013363]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.013363]   node   0: [mem 0x000000000009f000-0x000000000009ffff]
[    0.013364]   node   0: [mem 0x0000000000100000-0x000000003f7b2fff]
[    0.013365]   node   0: [mem 0x0000000043eff000-0x0000000043efffff]
[    0.013365]   node   0: [mem 0x0000000100000000-0x00000008afbfffff]
[    0.013367] Initmem setup node 0 [mem 0x0000000000001000-0x00000008a=
fbfffff]
[    0.013369] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.013370] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.013386] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.014591] On node 0, zone DMA32: 18252 pages in unavailable ranges
[    0.049556] On node 0, zone Normal: 16640 pages in unavailable range=
s
[    0.049563] On node 0, zone Normal: 1024 pages in unavailable ranges
[    0.049596] Reserving Intel graphics memory at [mem 0x4c800000-0x503=
fffff]
[    0.050496] ACPI: PM-Timer IO Port: 0x1808
[    0.050502] ACPI: LAPIC=5FNMI (acpi=5Fid[0x01] high edge lint[0x1])
[    0.050503] ACPI: LAPIC=5FNMI (acpi=5Fid[0x02] high edge lint[0x1])
[    0.050504] ACPI: LAPIC=5FNMI (acpi=5Fid[0x03] high edge lint[0x1])
[    0.050504] ACPI: LAPIC=5FNMI (acpi=5Fid[0x04] high edge lint[0x1])
[    0.050504] ACPI: LAPIC=5FNMI (acpi=5Fid[0x05] high edge lint[0x1])
[    0.050505] ACPI: LAPIC=5FNMI (acpi=5Fid[0x06] high edge lint[0x1])
[    0.050505] ACPI: LAPIC=5FNMI (acpi=5Fid[0x07] high edge lint[0x1])
[    0.050506] ACPI: LAPIC=5FNMI (acpi=5Fid[0x08] high edge lint[0x1])
[    0.050506] ACPI: LAPIC=5FNMI (acpi=5Fid[0x09] high edge lint[0x1])
[    0.050506] ACPI: LAPIC=5FNMI (acpi=5Fid[0x0a] high edge lint[0x1])
[    0.050507] ACPI: LAPIC=5FNMI (acpi=5Fid[0x0b] high edge lint[0x1])
[    0.050507] ACPI: LAPIC=5FNMI (acpi=5Fid[0x0c] high edge lint[0x1])
[    0.050507] ACPI: LAPIC=5FNMI (acpi=5Fid[0x0d] high edge lint[0x1])
[    0.050508] ACPI: LAPIC=5FNMI (acpi=5Fid[0x0e] high edge lint[0x1])
[    0.050508] ACPI: LAPIC=5FNMI (acpi=5Fid[0x0f] high edge lint[0x1])
[    0.050508] ACPI: LAPIC=5FNMI (acpi=5Fid[0x10] high edge lint[0x1])
[    0.050509] ACPI: LAPIC=5FNMI (acpi=5Fid[0x11] high edge lint[0x1])
[    0.050509] ACPI: LAPIC=5FNMI (acpi=5Fid[0x12] high edge lint[0x1])
[    0.050510] ACPI: LAPIC=5FNMI (acpi=5Fid[0x13] high edge lint[0x1])
[    0.050510] ACPI: LAPIC=5FNMI (acpi=5Fid[0x14] high edge lint[0x1])
[    0.050510] ACPI: LAPIC=5FNMI (acpi=5Fid[0x15] high edge lint[0x1])
[    0.050511] ACPI: LAPIC=5FNMI (acpi=5Fid[0x16] high edge lint[0x1])
[    0.050511] ACPI: LAPIC=5FNMI (acpi=5Fid[0x17] high edge lint[0x1])
[    0.050511] ACPI: LAPIC=5FNMI (acpi=5Fid[0x00] high edge lint[0x1])
[    0.050595] IOAPIC[0]: apic=5Fid 2, version 32, address 0xfec00000, =
GSI 0-119
[    0.050596] ACPI: INT=5FSRC=5FOVR (bus 0 bus=5Firq 0 global=5Firq 2 =
dfl dfl)
[    0.050598] ACPI: INT=5FSRC=5FOVR (bus 0 bus=5Firq 9 global=5Firq 9 =
high level)
[    0.050600] ACPI: Using ACPI (MADT) for SMP configuration informatio=
n
[    0.050601] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.050605] e820: update [mem 0x38a23000-0x38a9efff] usable =3D=3D> =
reserved
[    0.050612] TSC deadline timer available
[    0.050614] CPU topo: Max. logical packages:   1
[    0.050615] CPU topo: Max. logical dies:       1
[    0.050615] CPU topo: Max. dies per package:   1
[    0.050617] CPU topo: Max. threads per core:   2
[    0.050617] CPU topo: Num. cores per package:    14
[    0.050618] CPU topo: Num. threads per package:  20
[    0.050618] CPU topo: Allowing 20 present CPUs plus 0 hotplug CPUs
[    0.050628] PM: hibernation: Registered nosave memory: [mem 0x000000=
00-0x00000fff]
[    0.050629] PM: hibernation: Registered nosave memory: [mem 0x0009e0=
00-0x0009efff]
[    0.050630] PM: hibernation: Registered nosave memory: [mem 0x000a00=
00-0x000fffff]
[    0.050631] PM: hibernation: Registered nosave memory: [mem 0x38a230=
00-0x38a9efff]
[    0.050632] PM: hibernation: Registered nosave memory: [mem 0x3bf080=
00-0x3bf08fff]
[    0.050633] PM: hibernation: Registered nosave memory: [mem 0x3f7b30=
00-0x42f55fff]
[    0.050633] PM: hibernation: Registered nosave memory: [mem 0x42f560=
00-0x43041fff]
[    0.050633] PM: hibernation: Registered nosave memory: [mem 0x430420=
00-0x43170fff]
[    0.050634] PM: hibernation: Registered nosave memory: [mem 0x431710=
00-0x43efefff]
[    0.050635] PM: hibernation: Registered nosave memory: [mem 0x43f000=
00-0x49ffffff]
[    0.050635] PM: hibernation: Registered nosave memory: [mem 0x4a0000=
00-0x4a1fffff]
[    0.050635] PM: hibernation: Registered nosave memory: [mem 0x4a2000=
00-0x4a3fffff]
[    0.050636] PM: hibernation: Registered nosave memory: [mem 0x4a4000=
00-0x4affffff]
[    0.050636] PM: hibernation: Registered nosave memory: [mem 0x4b0000=
00-0x503fffff]
[    0.050636] PM: hibernation: Registered nosave memory: [mem 0x504000=
00-0xfdffffff]
[    0.050637] PM: hibernation: Registered nosave memory: [mem 0xfe0000=
00-0xfe010fff]
[    0.050637] PM: hibernation: Registered nosave memory: [mem 0xfe0110=
00-0xfebfffff]
[    0.050637] PM: hibernation: Registered nosave memory: [mem 0xfec000=
00-0xfec00fff]
[    0.050638] PM: hibernation: Registered nosave memory: [mem 0xfec010=
00-0xfecfffff]
[    0.050638] PM: hibernation: Registered nosave memory: [mem 0xfed000=
00-0xfed00fff]
[    0.050638] PM: hibernation: Registered nosave memory: [mem 0xfed010=
00-0xfed1ffff]
[    0.050639] PM: hibernation: Registered nosave memory: [mem 0xfed200=
00-0xfed7ffff]
[    0.050639] PM: hibernation: Registered nosave memory: [mem 0xfed800=
00-0xfedfffff]
[    0.050639] PM: hibernation: Registered nosave memory: [mem 0xfee000=
00-0xfee00fff]
[    0.050640] PM: hibernation: Registered nosave memory: [mem 0xfee010=
00-0xffffffff]
[    0.050641] [mem 0x50400000-0xfdffffff] available for PCI devices
[    0.050642] Booting paravirtualized kernel on bare hardware
[    0.050643] clocksource: refined-jiffies: mask: 0xffffffff max=5Fcyc=
les: 0xffffffff, max=5Fidle=5Fns: 6370452778343963 ns
[    0.054560] setup=5Fpercpu: NR=5FCPUS:320 nr=5Fcpumask=5Fbits:20 nr=5F=
cpu=5Fids:20 nr=5Fnode=5Fids:1
[    0.055438] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u5242=
88
[    0.055442] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=3D1*20971=
52
[    0.055444] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07=20
[    0.055447] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15=20
[    0.055449] pcpu-alloc: [0] 16 17 18 19=20
[    0.055459] Kernel command line: initrd=3D\initramfs-linux.img root=3D=
LABEL=3Darch rw resume=3Dswap thunderbolt.dyndbg=3D+p thunderbolt.host=5F=
reset=3Dfalse
[    0.055500] printk: log=5Fbuf=5Flen individual max cpu contribution:=
 4096 bytes
[    0.055501] printk: log=5Fbuf=5Flen total cpu=5Fextra contributions:=
 77824 bytes
[    0.055502] printk: log=5Fbuf=5Flen min size: 131072 bytes
[    0.055606] printk: log=5Fbuf=5Flen: 262144 bytes
[    0.055606] printk: early log buf free: 115272(87%)
[    0.057668] Dentry cache hash table entries: 4194304 (order: 13, 335=
54432 bytes, linear)
[    0.058710] Inode-cache hash table entries: 2097152 (order: 12, 1677=
7216 bytes, linear)
[    0.058854] Fallback order for Node 0: 0=20
[    0.058857] Built 1 zonelists, mobility grouping on.  Total pages: 8=
189669
[    0.058858] Policy zone: Normal
[    0.059009] mem auto-init: stack:all(zero), heap alloc:on, heap free=
:off
[    0.059016] software IO TLB: area num 32.
[    0.107844] Memory: 32420000K/33279304K available (18432K kernel cod=
e, 2164K rwdata, 13276K rodata, 3408K init, 3636K bss, 859044K reserved=
, 0K cma-reserved)
[    0.108001] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
20, Nodes=3D1
[    0.108032] ftrace: allocating 49689 entries in 195 pages
[    0.112440] ftrace: allocated 195 pages with 4 groups
[    0.112490] Dynamic Preempt: full
[    0.112559] rcu: Preemptible hierarchical RCU implementation.
[    0.112560] rcu: 	RCU restricting CPUs from NR=5FCPUS=3D320 to nr=5F=
cpu=5Fids=3D20.
[    0.112560] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.112561] 	Trampoline variant of Tasks RCU enabled.
[    0.112562] 	Rude variant of Tasks RCU enabled.
[    0.112562] 	Tracing variant of Tasks RCU enabled.
[    0.112563] rcu: RCU calculated value of scheduler-enlistment delay =
is 30 jiffies.
[    0.112563] rcu: Adjusting geometry for rcu=5Ffanout=5Fleaf=3D16, nr=
=5Fcpu=5Fids=3D20
[    0.112569] RCU Tasks: Setting shift to 5 and lim to 1 rcu=5Ftask=5F=
cb=5Fadjust=3D1.
[    0.112571] RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu=5Fta=
sk=5Fcb=5Fadjust=3D1.
[    0.112573] RCU Tasks Trace: Setting shift to 5 and lim to 1 rcu=5Ft=
ask=5Fcb=5Fadjust=3D1.
[    0.114979] NR=5FIRQS: 20736, nr=5Firqs: 2216, preallocated irqs: 16
[    0.115330] rcu: srcu=5Finit: Setting srcu=5Fstruct sizes based on c=
ontention.
[    0.115789] kfence: initialized - using 2097152 bytes for 255 object=
s at 0x(=5F=5F=5F=5Fptrval=5F=5F=5F=5F)-0x(=5F=5F=5F=5Fptrval=5F=5F=5F=5F=
)
[    0.115815] Console: colour dummy device 80x25
[    0.115816] printk: legacy console [tty0] enabled
[    0.115845] ACPI: Core revision 20230628
[    0.116060] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.116060] APIC: Switch to symmetric I/O mode setup
[    0.116061] DMAR: Host address width 39
[    0.116062] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.116065] DMAR: dmar0: reg=5Fbase=5Faddr fed90000 ver 4:0 cap 1c00=
00c40660462 ecap 29a00f0505e
[    0.116067] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.116071] DMAR: dmar1: reg=5Fbase=5Faddr fed91000 ver 5:0 cap d200=
8c40660462 ecap f050da
[    0.116072] DMAR: RMRR base: 0x0000004c000000 end: 0x000000503fffff
[    0.116075] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.116075] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.116076] DMAR-IR: Queued invalidation will be enabled to support =
x2apic and Intr-remapping.
[    0.120002] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.120004] x2apic enabled
[    0.120067] APIC: Switched APIC routing to: cluster x2apic
[    0.131334] clocksource: tsc-early: mask: 0xffffffffffffffff max=5Fc=
ycles: 0x26bef67878b, max=5Fidle=5Fns: 440795293631 ns
[    0.131338] Calibrating delay loop (skipped), value calculated using=
 timer frequency.. 5378.00 BogoMIPS (lpj=3D8960000)
[    0.131385] CPU0: Thermal monitoring enabled (TM1)
[    0.131386] x86/cpu: User Mode Instruction Prevention (UMIP) activat=
ed
[    0.131484] CET detected: Indirect Branch Tracking enabled
[    0.131485] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.131486] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.131487] process: using mwait in idle threads
[    0.131489] Spectre V1 : Mitigation: usercopy/swapgs barriers and =5F=
=5Fuser pointer sanitization
[    0.131490] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on =
vm exit
[    0.131490] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on =
syscall
[    0.131491] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.131491] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling=
 RSB on context switch
[    0.131492] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single C=
ALL on VMEXIT
[    0.131493] Spectre V2 : mitigation: Enabling conditional Indirect B=
ranch Prediction Barrier
[    0.131493] Speculative Store Bypass: Mitigation: Speculative Store =
Bypass disabled via prctl
[    0.131494] Register File Data Sampling: Vulnerable: No microcode
[    0.131500] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating p=
oint registers'
[    0.131501] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.131502] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.131502] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Key=
s User registers'
[    0.131503] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow U=
ser registers'
[    0.131503] x86/fpu: xstate=5Foffset[2]:  576, xstate=5Fsizes[2]:  2=
56
[    0.131504] x86/fpu: xstate=5Foffset[9]:  832, xstate=5Fsizes[9]:   =
 8
[    0.131505] x86/fpu: xstate=5Foffset[11]:  840, xstate=5Fsizes[11]: =
  16
[    0.131505] x86/fpu: Enabled xstate features 0xa07, context size is =
856 bytes, using 'compacted' format.
[    0.134670] Freeing SMP alternatives memory: 40K
[    0.134670] pid=5Fmax: default: 32768 minimum: 301
[    0.134670] LSM: initializing lsm=3Dcapability,landlock,lockdown,yam=
a,bpf
[    0.134670] landlock: Up and running.
[    0.134670] Yama: becoming mindful.
[    0.134670] LSM support for eBPF active
[    0.134670] Mount-cache hash table entries: 65536 (order: 7, 524288 =
bytes, linear)
[    0.134670] Mountpoint-cache hash table entries: 65536 (order: 7, 52=
4288 bytes, linear)
[    0.134670] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-12700H (fam=
ily: 0x6, model: 0x9a, stepping: 0x3)
[    0.134670] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-=
baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, =
full-width counters, Intel PMU driver.
[    0.134670] core: cpu=5Fcore PMU driver:=20
[    0.134670] ... version:                5
[    0.134670] ... bit width:              48
[    0.134670] ... generic registers:      8
[    0.134670] ... value mask:             0000ffffffffffff
[    0.134670] ... max period:             00007fffffffffff
[    0.134670] ... fixed-purpose events:   4
[    0.134670] ... event mask:             0001000f000000ff
[    0.134670] signal: max sigframe size: 3632
[    0.134670] Estimated ratio of average max frequency by base frequen=
cy (times 1024): 1668
[    0.134670] rcu: Hierarchical SRCU implementation.
[    0.134670] rcu: 	Max phase no-delay instances is 1000.
[    0.134670] NMI watchdog: Enabled. Permanently consumes one hw-PMU c=
ounter.
[    0.134670] smp: Bringing up secondary CPUs ...
[    0.134670] smpboot: x86: Booting SMP configuration:
[    0.134670] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #13 #=
14 #15 #16 #17 #18 #19
[    0.018965] core: cpu=5Fatom PMU driver: PEBS-via-PT=20
[    0.018965] ... version:                5
[    0.018965] ... bit width:              48
[    0.018965] ... generic registers:      6
[    0.018965] ... value mask:             0000ffffffffffff
[    0.018965] ... max period:             00007fffffffffff
[    0.018965] ... fixed-purpose events:   3
[    0.018965] ... event mask:             000000070000003f
[    0.138098]   #1  #3  #5  #7  #9 #11
[    0.144745] smp: Brought up 1 node, 20 CPUs
[    0.144745] smpboot: Total of 20 processors activated (107563.00 Bog=
oMIPS)
[    0.148869] devtmpfs: initialized
[    0.148869] x86/mm: Memory block size: 128MB
[    0.149280] ACPI: PM: Registering ACPI NVS region [mem 0x43042000-0x=
43170fff] (1241088 bytes)
[    0.149280] clocksource: jiffies: mask: 0xffffffff max=5Fcycles: 0xf=
fffffff, max=5Fidle=5Fns: 6370867519511994 ns
[    0.149280] futex hash table entries: 8192 (order: 7, 524288 bytes, =
linear)
[    0.149280] pinctrl core: initialized pinctrl subsystem
[    0.149280] PM: RTC time: 14:53:17, date: 2024-05-20
[    0.149280] NET: Registered PF=5FNETLINK/PF=5FROUTE protocol family
[    0.151694] DMA: preallocated 4096 KiB GFP=5FKERNEL pool for atomic =
allocations
[    0.151925] DMA: preallocated 4096 KiB GFP=5FKERNEL|GFP=5FDMA pool f=
or atomic allocations
[    0.152151] DMA: preallocated 4096 KiB GFP=5FKERNEL|GFP=5FDMA32 pool=
 for atomic allocations
[    0.152155] audit: initializing netlink subsys (disabled)
[    0.152158] audit: type=3D2000 audit(1716216797.019:1): state=3Dinit=
ialized audit=5Fenabled=3D0 res=3D1
[    0.152158] thermal=5Fsys: Registered thermal governor 'fair=5Fshare=
'
[    0.152158] thermal=5Fsys: Registered thermal governor 'bang=5Fbang'
[    0.152158] thermal=5Fsys: Registered thermal governor 'step=5Fwise'
[    0.152158] thermal=5Fsys: Registered thermal governor 'user=5Fspace=
'
[    0.152158] thermal=5Fsys: Registered thermal governor 'power=5Fallo=
cator'
[    0.152158] cpuidle: using governor ladder
[    0.152158] cpuidle: using governor menu
[    0.152158] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.=
5
[    0.152158] PCI: ECAM [mem 0xc0000000-0xcfffffff] (base 0xc0000000) =
for domain 0000 [bus 00-ff]
[    0.152158] PCI: not using ECAM ([mem 0xc0000000-0xcfffffff] not res=
erved)
[    0.152158] PCI: Using configuration type 1 for base access
[    0.152158] kprobes: kprobe jump-optimization is enabled. All kprobe=
s are optimized if possible.
[    0.152158] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 =
pages
[    0.152158] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB p=
age
[    0.152158] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 =
pages
[    0.152158] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.154712] Demotion targets for Node 0: null
[    0.154894] ACPI: Added =5FOSI(Module Device)
[    0.154896] ACPI: Added =5FOSI(Processor Device)
[    0.154897] ACPI: Added =5FOSI(3.0 =5FSCP Extensions)
[    0.154898] ACPI: Added =5FOSI(Processor Aggregator Device)
[    0.263420] ACPI: 14 ACPI AML tables successfully acquired and loade=
d
[    0.283095] ACPI: USB4 =5FOSC: OS supports USB3+ DisplayPort+ PCIe+ =
XDomain+
[    0.283097] ACPI: USB4 =5FOSC: OS controls USB3+ DisplayPort+ PCIe+ =
XDomain+
[    0.284111] ACPI: Dynamic OEM Table Load:
[    0.284111] ACPI: SSDT 0xFFFF91D4C15F7800 000394 (v02 PmRef  Cpu0Cst=
  00003001 INTL 20200717)
[    0.284111] ACPI: Dynamic OEM Table Load:
[    0.284111] ACPI: SSDT 0xFFFF91D4C2322000 000626 (v02 PmRef  Cpu0Ist=
  00003000 INTL 20200717)
[    0.284468] ACPI: Dynamic OEM Table Load:
[    0.284473] ACPI: SSDT 0xFFFF91D4C2155A00 0001AB (v02 PmRef  Cpu0Psd=
  00003000 INTL 20200717)
[    0.285726] ACPI: Dynamic OEM Table Load:
[    0.285731] ACPI: SSDT 0xFFFF91D4C2321000 0004BA (v02 PmRef  Cpu0Hwp=
  00003000 INTL 20200717)
[    0.287299] ACPI: Dynamic OEM Table Load:
[    0.287307] ACPI: SSDT 0xFFFF91D4C15D4000 001BAF (v02 PmRef  ApIst  =
  00003000 INTL 20200717)
[    0.289371] ACPI: Dynamic OEM Table Load:
[    0.289377] ACPI: SSDT 0xFFFF91D4C15D2000 001038 (v02 PmRef  ApHwp  =
  00003000 INTL 20200717)
[    0.291038] ACPI: Dynamic OEM Table Load:
[    0.291044] ACPI: SSDT 0xFFFF91D4C2330000 001349 (v02 PmRef  ApPsd  =
  00003000 INTL 20200717)
[    0.292943] ACPI: Dynamic OEM Table Load:
[    0.292949] ACPI: SSDT 0xFFFF91D4C15F9000 000FBB (v02 PmRef  ApCst  =
  00003000 INTL 20200717)
[    0.302357] ACPI: =5FOSC evaluated successfully for all CPUs
[    0.302449] ACPI: EC: EC started
[    0.302450] ACPI: EC: interrupt blocked
[    0.304293] ACPI: EC: EC=5FCMD/EC=5FSC=3D0x66, EC=5FDATA=3D0x62
[    0.304295] ACPI: \=5FSB=5F.PC00.LPCB.EC0=5F: Boot DSDT EC used to h=
andle transactions
[    0.304297] ACPI: Interpreter enabled
[    0.304348] ACPI: PM: (supports S0 S3 S4 S5)
[    0.304349] ACPI: Using IOAPIC for interrupt routing
[    0.305889] PCI: ECAM [mem 0xc0000000-0xcfffffff] (base 0xc0000000) =
for domain 0000 [bus 00-ff]
[    0.307672] PCI: ECAM [mem 0xc0000000-0xcfffffff] reserved as ACPI m=
otherboard resource
[    0.307682] PCI: Using host bridge windows from ACPI; if necessary, =
use "pci=3Dnocrs" and report a bug
[    0.307683] PCI: Using E820 reservations for host bridge windows
[    0.309293] ACPI: Enabled 7 GPEs in block 00 to 7F
[    0.310293] ACPI: \=5FSB=5F.PC00.PEG1.PXP=5F: New power resource
[    0.311052] ACPI: \=5FSB=5F.PC00.PEG2.PXP=5F: New power resource
[    0.316605] ACPI: \=5FSB=5F.PC00.PEG0.PXP=5F: New power resource
[    0.321808] ACPI: \=5FSB=5F.PC00.RP05.PXP=5F: New power resource
[    0.330797] ACPI: \=5FSB=5F.PC00.XHCI.RHUB.HS10.BTRT: New power reso=
urce
[    0.342480] ACPI: \=5FSB=5F.PC00.CNVW.WRST: New power resource
[    0.351016] ACPI: \=5FSB=5F.PC00.TBT0: New power resource
[    0.351155] ACPI: \=5FSB=5F.PC00.TBT1: New power resource
[    0.351276] ACPI: \=5FSB=5F.PC00.D3C=5F: New power resource
[    0.482527] ACPI: \=5FTZ=5F.FN00: New power resource
[    0.482585] ACPI: \=5FTZ=5F.FN01: New power resource
[    0.482645] ACPI: \=5FTZ=5F.FN02: New power resource
[    0.482700] ACPI: \=5FTZ=5F.FN03: New power resource
[    0.482755] ACPI: \=5FTZ=5F.FN04: New power resource
[    0.483281] ACPI: \PIN=5F: New power resource
[    0.483590] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-fe])
[    0.483595] acpi PNP0A08:00: =5FOSC: OS supports [ExtendedConfig ASP=
M ClockPM Segments MSI EDR HPX-Type3]
[    0.485640] acpi PNP0A08:00: =5FOSC: platform does not support [AER]
[    0.489664] acpi PNP0A08:00: =5FOSC: OS now controls [PCIeHotplug SH=
PCHotplug PME PCIeCapability LTR DPC]
[    0.492143] PCI host bridge to bus 0000:00
[    0.492145] pci=5Fbus 0000:00: root bus resource [io  0x0000-0x0cf7 =
window]
[    0.492147] pci=5Fbus 0000:00: root bus resource [io  0x0d00-0xffff =
window]
[    0.492149] pci=5Fbus 0000:00: root bus resource [mem 0x000a0000-0x0=
00bffff window]
[    0.492150] pci=5Fbus 0000:00: root bus resource [mem 0x000e0000-0x0=
00fffff window]
[    0.492151] pci=5Fbus 0000:00: root bus resource [mem 0x50400000-0xb=
fffffff window]
[    0.492153] pci=5Fbus 0000:00: root bus resource [mem 0x4000000000-0=
x7fffffffff window]
[    0.492154] pci=5Fbus 0000:00: root bus resource [bus 00-fe]
[    0.608758] pci 0000:00:00.0: [8086:4641] type 00 class 0x060000 con=
ventional PCI endpoint
[    0.608961] pci 0000:00:02.0: [8086:46a6] type 00 class 0x030000 PCI=
e Root Complex Integrated Endpoint
[    0.608969] pci 0000:00:02.0: BAR 0 [mem 0x601c000000-0x601cffffff 6=
4bit]
[    0.608974] pci 0000:00:02.0: BAR 2 [mem 0x4000000000-0x400fffffff 6=
4bit pref]
[    0.608977] pci 0000:00:02.0: BAR 4 [io  0x3000-0x303f]
[    0.608992] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphic=
s
[    0.608994] pci 0000:00:02.0: Video device with shadowed ROM at [mem=
 0x000c0000-0x000dffff]
[    0.609016] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x00ffffff 64=
bit]
[    0.609017] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x06ffffff 64=
bit]: contains BAR 0 for 7 VFs
[    0.609021] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64=
bit pref]
[    0.609022] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64=
bit pref]: contains BAR 2 for 7 VFs
[    0.609164] pci 0000:00:04.0: [8086:461d] type 00 class 0x118000 con=
ventional PCI endpoint
[    0.609177] pci 0000:00:04.0: BAR 0 [mem 0x601d140000-0x601d15ffff 6=
4bit]
[    0.609546] pci 0000:00:06.0: [8086:464d] type 01 class 0x060400 PCI=
e Root Port
[    0.609592] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.609677] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.609727] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    0.610448] pci 0000:00:06.2: [8086:463d] type 01 class 0x060400 PCI=
e Root Port
[    0.610491] pci 0000:00:06.2: PCI bridge to [bus 02]
[    0.610499] pci 0000:00:06.2:   bridge window [mem 0x5e300000-0x5e3f=
ffff]
[    0.610588] pci 0000:00:06.2: PME# supported from D0 D3hot D3cold
[    0.610637] pci 0000:00:06.2: PTM enabled (root), 4ns granularity
[    0.611482] pci 0000:00:07.0: [8086:466e] type 01 class 0x060400 PCI=
e Root Port
[    0.611498] pci 0000:00:07.0: PCI bridge to [bus 03-2c]
[    0.611502] pci 0000:00:07.0:   bridge window [mem 0x52000000-0x5e1f=
ffff]
[    0.611508] pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x60=
1bffffff 64bit pref]
[    0.611528] pci 0000:00:07.0: Overriding RP PIO Log Size to 4
[    0.611592] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.611612] pci 0000:00:07.0: PTM enabled (root), 4ns granularity
[    0.612696] pci 0000:00:08.0: [8086:464f] type 00 class 0x088000 con=
ventional PCI endpoint
[    0.612704] pci 0000:00:08.0: BAR 0 [mem 0x601d199000-0x601d199fff 6=
4bit]
[    0.612798] pci 0000:00:0a.0: [8086:467d] type 00 class 0x118000 PCI=
e Root Complex Integrated Endpoint
[    0.612805] pci 0000:00:0a.0: BAR 0 [mem 0x601d180000-0x601d187fff 6=
4bit]
[    0.612822] pci 0000:00:0a.0: enabling Extended Tags
[    0.612926] pci 0000:00:0d.0: [8086:461e] type 00 class 0x0c0330 con=
ventional PCI endpoint
[    0.612935] pci 0000:00:0d.0: BAR 0 [mem 0x601d170000-0x601d17ffff 6=
4bit]
[    0.612973] pci 0000:00:0d.0: PME# supported from D3hot D3cold
[    0.613565] pci 0000:00:0d.2: [8086:463e] type 00 class 0x0c0340 con=
ventional PCI endpoint
[    0.613574] pci 0000:00:0d.2: BAR 0 [mem 0x601d100000-0x601d13ffff 6=
4bit]
[    0.613581] pci 0000:00:0d.2: BAR 2 [mem 0x601d198000-0x601d198fff 6=
4bit]
[    0.613610] pci 0000:00:0d.2: supports D1 D2
[    0.613611] pci 0000:00:0d.2: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.613904] pci 0000:00:14.0: [8086:51ed] type 00 class 0x0c0330 con=
ventional PCI endpoint
[    0.613927] pci 0000:00:14.0: BAR 0 [mem 0x601d160000-0x601d16ffff 6=
4bit]
[    0.614026] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.614807] pci 0000:00:14.2: [8086:51ef] type 00 class 0x050000 con=
ventional PCI endpoint
[    0.614829] pci 0000:00:14.2: BAR 0 [mem 0x601d190000-0x601d193fff 6=
4bit]
[    0.614843] pci 0000:00:14.2: BAR 2 [mem 0x601d197000-0x601d197fff 6=
4bit]
[    0.615066] pci 0000:00:14.3: [8086:51f0] type 00 class 0x028000 PCI=
e Root Complex Integrated Endpoint
[    0.615127] pci 0000:00:14.3: BAR 0 [mem 0x601d18c000-0x601d18ffff 6=
4bit]
[    0.615317] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.616151] pci 0000:00:15.0: [8086:51e8] type 00 class 0x0c8000 con=
ventional PCI endpoint
[    0.616883] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit=
]
[    0.620305] pci 0000:00:1f.0: [8086:5182] type 00 class 0x060100 con=
ventional PCI endpoint
[    0.620711] pci 0000:00:1f.3: [8086:51c8] type 00 class 0x040380 con=
ventional PCI endpoint
[    0.620773] pci 0000:00:1f.3: BAR 0 [mem 0x601d188000-0x601d18bfff 6=
4bit]
[    0.620846] pci 0000:00:1f.3: BAR 4 [mem 0x601d000000-0x601d0fffff 6=
4bit]
[    0.621007] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.621761] pci 0000:00:1f.4: [8086:51a3] type 00 class 0x0c0500 con=
ventional PCI endpoint
[    0.621790] pci 0000:00:1f.4: BAR 0 [mem 0x601d194000-0x601d1940ff 6=
4bit]
[    0.621815] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.622113] pci 0000:00:1f.5: [8086:51a4] type 00 class 0x0c8000 con=
ventional PCI endpoint
[    0.622134] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.622372] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.623194] pci 0000:02:00.0: [144d:a80a] type 00 class 0x010802 PCI=
e Endpoint
[    0.623208] pci 0000:02:00.0: BAR 0 [mem 0x5e300000-0x5e303fff 64bit=
]
[    0.623443] pci 0000:00:06.2: PCI bridge to [bus 02]
[    0.623512] pci 0000:03:00.0: [8086:15ef] type 01 class 0x060400 PCI=
e Switch Upstream Port
[    0.623565] pci 0000:03:00.0: PCI bridge to [bus 04-05]
[    0.623579] pci 0000:03:00.0:   bridge window [mem 0x52000000-0x520f=
ffff]
[    0.623615] pci 0000:03:00.0: enabling Extended Tags
[    0.623793] pci 0000:03:00.0: supports D1 D2
[    0.623794] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.623956] pci 0000:03:00.0: PTM enabled, 4ns granularity
[    0.624004] pci 0000:03:00.0: 8.000 Gb/s available PCIe bandwidth, l=
imited by 2.5 GT/s PCIe x4 link at 0000:00:07.0 (capable of 31.504 Gb/s=
 with 8.0 GT/s PCIe x4 link)
[    0.631383] pci 0000:00:07.0: PCI bridge to [bus 03-2c]
[    0.631515] pci 0000:04:02.0: [8086:15ef] type 01 class 0x060400 PCI=
e Switch Downstream Port
[    0.631569] pci 0000:04:02.0: PCI bridge to [bus 05]
[    0.631583] pci 0000:04:02.0:   bridge window [mem 0x52000000-0x520f=
ffff]
[    0.631624] pci 0000:04:02.0: enabling Extended Tags
[    0.631796] pci 0000:04:02.0: supports D1 D2
[    0.631797] pci 0000:04:02.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.632115] pci 0000:03:00.0: PCI bridge to [bus 04-05]
[    0.632236] pci 0000:05:00.0: [8086:15f0] type 00 class 0x0c0330 PCI=
e Endpoint
[    0.632268] pci 0000:05:00.0: BAR 0 [mem 0x52000000-0x5200ffff]
[    0.632378] pci 0000:05:00.0: enabling Extended Tags
[    0.632568] pci 0000:05:00.0: supports D1 D2
[    0.632568] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.632747] pci 0000:05:00.0: 8.000 Gb/s available PCIe bandwidth, l=
imited by 2.5 GT/s PCIe x4 link at 0000:00:07.0 (capable of 31.504 Gb/s=
 with 8.0 GT/s PCIe x4 link)
[    0.632935] pci 0000:04:02.0: PCI bridge to [bus 05]
[    0.636996] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.637104] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.637209] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.637314] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.637418] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.637523] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.637628] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.637768] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    1.157520] Low-power S0 idle used by default for system suspend
[    1.167327] ACPI: EC: interrupt unblocked
[    1.167329] ACPI: EC: event unblocked
[    1.167355] ACPI: EC: EC=5FCMD/EC=5FSC=3D0x66, EC=5FDATA=3D0x62
[    1.167356] ACPI: EC: GPE=3D0x6e
[    1.167357] ACPI: \=5FSB=5F.PC00.LPCB.EC0=5F: Boot DSDT EC initializ=
ation complete
[    1.167359] ACPI: \=5FSB=5F.PC00.LPCB.EC0=5F: EC: Used to handle tra=
nsactions and events
[    1.168022] iommu: Default domain type: Translated
[    1.168022] iommu: DMA domain TLB invalidation policy: lazy mode
[    1.168142] SCSI subsystem initialized
[    1.168150] libata version 3.00 loaded.
[    1.168150] ACPI: bus type USB registered
[    1.168150] usbcore: registered new interface driver usbfs
[    1.168150] usbcore: registered new interface driver hub
[    1.168150] usbcore: registered new device driver usb
[    1.168150] EDAC MC: Ver: 3.0.0
[    1.171452] efivars: Registered efivars operations
[    1.171674] NetLabel: Initializing
[    1.171676] NetLabel:  domain hash size =3D 128
[    1.171677] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    1.171706] NetLabel:  unlabeled traffic allowed by default
[    1.171713] mctp: management component transport protocol core
[    1.171715] NET: Registered PF=5FMCTP protocol family
[    1.171725] PCI: Using ACPI for IRQ routing
[    1.265989] PCI: pci=5Fcache=5Fline=5Fsize set to 64 bytes
[    1.266903] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can=
't claim; no compatible bridge window
[    1.267823] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    1.267825] e820: reserve RAM buffer [mem 0x38a23000-0x3bffffff]
[    1.267827] e820: reserve RAM buffer [mem 0x3bf08000-0x3bffffff]
[    1.267829] e820: reserve RAM buffer [mem 0x3f7b3000-0x3fffffff]
[    1.267830] e820: reserve RAM buffer [mem 0x43f00000-0x43ffffff]
[    1.267831] e820: reserve RAM buffer [mem 0x8afc00000-0x8afffffff]
[    1.268025] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.268025] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.268025] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio=
+mem,owns=3Dio+mem,locks=3Dnone
[    1.268025] vgaarb: loaded
[    1.268075] clocksource: Switched to clocksource tsc-early
[    1.268509] VFS: Disk quotas dquot=5F6.6.0
[    1.268521] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 =
bytes)
[    1.268587] pnp: PnP ACPI init
[    1.269723] system 00:01: [io  0x0680-0x069f] has been reserved
[    1.269725] system 00:01: [io  0x164e-0x164f] has been reserved
[    1.269938] system 00:02: [io  0x1854-0x1857] has been reserved
[    1.271271] pnp 00:03: disabling [mem 0xc0000000-0xcfffffff] because=
 it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    1.271298] system 00:03: [mem 0xfedc0000-0xfedc7fff] has been reser=
ved
[    1.271300] system 00:03: [mem 0xfeda0000-0xfeda0fff] has been reser=
ved
[    1.271302] system 00:03: [mem 0xfeda1000-0xfeda1fff] has been reser=
ved
[    1.271304] system 00:03: [mem 0xfed20000-0xfed7ffff] has been reser=
ved
[    1.271305] system 00:03: [mem 0xfed90000-0xfed93fff] could not be r=
eserved
[    1.271307] system 00:03: [mem 0xfed45000-0xfed8ffff] could not be r=
eserved
[    1.271308] system 00:03: [mem 0xfee00000-0xfeefffff] could not be r=
eserved
[    1.272819] system 00:04: [io  0x2000-0x20fe] has been reserved
[    1.274291] pnp: PnP ACPI: found 6 devices
[    1.279794] clocksource: acpi=5Fpm: mask: 0xffffff max=5Fcycles: 0xf=
fffff, max=5Fidle=5Fns: 2085701024 ns
[    1.279920] NET: Registered PF=5FINET protocol family
[    1.280090] IP idents hash table entries: 262144 (order: 9, 2097152 =
bytes, linear)
[    1.292209] tcp=5Flisten=5Fportaddr=5Fhash hash table entries: 16384=
 (order: 6, 262144 bytes, linear)
[    1.292244] Table-perturb hash table entries: 65536 (order: 6, 26214=
4 bytes, linear)
[    1.292424] TCP established hash table entries: 262144 (order: 9, 20=
97152 bytes, linear)
[    1.292822] TCP bind hash table entries: 65536 (order: 9, 2097152 by=
tes, linear)
[    1.292921] TCP: Hash tables configured (established 262144 bind 655=
36)
[    1.293185] MPTCP token hash table entries: 32768 (order: 7, 786432 =
bytes, linear)
[    1.293268] UDP hash table entries: 16384 (order: 7, 524288 bytes, l=
inear)
[    1.293343] UDP-Lite hash table entries: 16384 (order: 7, 524288 byt=
es, linear)
[    1.293420] NET: Registered PF=5FUNIX/PF=5FLOCAL protocol family
[    1.293425] NET: Registered PF=5FXDP protocol family
[    1.293433] pci 0000:00:07.0: bridge window [io  0x1000-0x0fff] to [=
bus 03-2c] add=5Fsize 1000
[    1.293442] pci 0000:00:02.0: VF BAR 2 [mem 0x4020000000-0x40fffffff=
f 64bit pref]: assigned
[    1.293446] pci 0000:00:02.0: VF BAR 0 [mem 0x4010000000-0x4016fffff=
f 64bit]: assigned
[    1.293449] pci 0000:00:07.0: bridge window [io  0x4000-0x4fff]: ass=
igned
[    1.293451] pci 0000:00:15.0: BAR 0 [mem 0x4017000000-0x4017000fff 6=
4bit]: assigned
[    1.293799] resource: avoiding allocation from e820 entry [mem 0x000=
a0000-0x000fffff]
[    1.293800] resource: avoiding allocation from e820 entry [mem 0x000=
a0000-0x000fffff]
[    1.293802] pci 0000:00:1f.5: BAR 0 [mem 0x50400000-0x50400fff]: ass=
igned
[    1.293826] pci 0000:00:06.0: PCI bridge to [bus 01]
[    1.293857] pci 0000:00:06.2: PCI bridge to [bus 02]
[    1.293865] pci 0000:00:06.2:   bridge window [mem 0x5e300000-0x5e3f=
ffff]
[    1.293873] pci 0000:04:02.0: PCI bridge to [bus 05]
[    1.293880] pci 0000:04:02.0:   bridge window [mem 0x52000000-0x520f=
ffff]
[    1.293892] pci 0000:03:00.0: PCI bridge to [bus 04-05]
[    1.293899] pci 0000:03:00.0:   bridge window [mem 0x52000000-0x520f=
ffff]
[    1.293911] pci 0000:00:07.0: PCI bridge to [bus 03-2c]
[    1.293913] pci 0000:00:07.0:   bridge window [io  0x4000-0x4fff]
[    1.293915] pci 0000:00:07.0:   bridge window [mem 0x52000000-0x5e1f=
ffff]
[    1.293918] pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x60=
1bffffff 64bit pref]
[    1.293922] pci=5Fbus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.293923] pci=5Fbus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.293925] pci=5Fbus 0000:00: resource 6 [mem 0x000a0000-0x000bffff=
 window]
[    1.293926] pci=5Fbus 0000:00: resource 7 [mem 0x000e0000-0x000fffff=
 window]
[    1.293927] pci=5Fbus 0000:00: resource 8 [mem 0x50400000-0xbfffffff=
 window]
[    1.293928] pci=5Fbus 0000:00: resource 9 [mem 0x4000000000-0x7fffff=
ffff window]
[    1.293930] pci=5Fbus 0000:02: resource 1 [mem 0x5e300000-0x5e3fffff=
]
[    1.293931] pci=5Fbus 0000:03: resource 0 [io  0x4000-0x4fff]
[    1.293932] pci=5Fbus 0000:03: resource 1 [mem 0x52000000-0x5e1fffff=
]
[    1.293933] pci=5Fbus 0000:03: resource 2 [mem 0x6000000000-0x601bff=
ffff 64bit pref]
[    1.293935] pci=5Fbus 0000:04: resource 1 [mem 0x52000000-0x520fffff=
]
[    1.293936] pci=5Fbus 0000:05: resource 1 [mem 0x52000000-0x520fffff=
]
[    1.295803] PCI: CLS 64 bytes, default 64
[    1.295812] DMAR: Intel-IOMMU force enabled due to platform opt in
[    1.295819] DMAR: No ATSR found
[    1.295820] DMAR: No SATC found
[    1.295821] DMAR: IOMMU feature fl1gp=5Fsupport inconsistent
[    1.295822] DMAR: IOMMU feature pgsel=5Finv inconsistent
[    1.295823] DMAR: IOMMU feature nwfs inconsistent
[    1.295824] DMAR: IOMMU feature dit inconsistent
[    1.295825] DMAR: IOMMU feature sc=5Fsupport inconsistent
[    1.295826] DMAR: IOMMU feature dev=5Fiotlb=5Fsupport inconsistent
[    1.295827] DMAR: dmar0: Using Queued invalidation
[    1.295830] DMAR: dmar1: Using Queued invalidation
[    1.295838] Trying to unpack rootfs image as initramfs...
[    1.296028] pci 0000:00:02.0: Adding to iommu group 0
[    1.296068] pci 0000:00:00.0: Adding to iommu group 1
[    1.296077] pci 0000:00:04.0: Adding to iommu group 2
[    1.296113] pci 0000:00:06.0: Adding to iommu group 3
[    1.296146] pci 0000:00:06.2: Adding to iommu group 4
[    1.296155] pci 0000:00:07.0: Adding to iommu group 5
[    1.296164] pci 0000:00:08.0: Adding to iommu group 6
[    1.296173] pci 0000:00:0a.0: Adding to iommu group 7
[    1.296188] pci 0000:00:0d.0: Adding to iommu group 8
[    1.296197] pci 0000:00:0d.2: Adding to iommu group 8
[    1.296212] pci 0000:00:14.0: Adding to iommu group 9
[    1.296222] pci 0000:00:14.2: Adding to iommu group 9
[    1.296230] pci 0000:00:14.3: Adding to iommu group 10
[    1.296242] pci 0000:00:15.0: Adding to iommu group 11
[    1.296262] pci 0000:00:1f.0: Adding to iommu group 12
[    1.296271] pci 0000:00:1f.3: Adding to iommu group 12
[    1.296280] pci 0000:00:1f.4: Adding to iommu group 12
[    1.296289] pci 0000:00:1f.5: Adding to iommu group 12
[    1.296322] pci 0000:02:00.0: Adding to iommu group 13
[    1.296330] pci 0000:03:00.0: Adding to iommu group 14
[    1.296340] pci 0000:04:02.0: Adding to iommu group 15
[    1.296353] pci 0000:05:00.0: Adding to iommu group 16
[    1.296673] DMAR: Intel(R) Virtualization Technology for Directed I/=
O
[    1.296674] PCI-DMA: Using software bounce buffering for IO (SWIOTLB=
)
[    1.296675] software IO TLB: mapped [mem 0x000000002c967000-0x000000=
0030967000] (64MB)
[    1.296717] clocksource: tsc: mask: 0xffffffffffffffff max=5Fcycles:=
 0x26bef67878b, max=5Fidle=5Fns: 440795293631 ns
[    1.296778] clocksource: Switched to clocksource tsc
[    1.296805] platform rtc=5Fcmos: registered platform RTC device (no =
PNP device found)
[    1.316811] Initialise system trusted keyrings
[    1.316821] Key type blacklist registered
[    1.316867] workingset: timestamp=5Fbits=3D41 max=5Forder=3D23 bucke=
t=5Forder=3D0
[    1.316874] zbud: loaded
[    1.316982] fuse: init (API version 7.40)
[    1.317061] integrity: Platform Keyring initialized
[    1.317064] integrity: Machine keyring initialized
[    1.325126] Freeing initrd memory: 16380K
[    1.327516] Key type asymmetric registered
[    1.327519] Asymmetric key parser 'x509' registered
[    1.327536] Block layer SCSI generic (bsg) driver version 0.4 loaded=
 (major 246)
[    1.327585] io scheduler mq-deadline registered
[    1.327586] io scheduler kyber registered
[    1.327595] io scheduler bfq registered
[    1.328383] pcieport 0000:00:06.0: PME: Signaling with IRQ 122
[    1.328762] pcieport 0000:00:06.2: PME: Signaling with IRQ 123
[    1.328891] pcieport 0000:00:07.0: PME: Signaling with IRQ 124
[    1.328906] pcieport 0000:00:07.0: pciehp: Slot #3 AttnBtn- PwrCtrl-=
 MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis=
- LLActRep+
[    1.329462] shpchp: Standard Hot Plug PCI Controller Driver version:=
 0.4
[    1.331647] ACPI: AC: AC Adapter [AC0] (on-line)
[    1.331685] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/=
PNP0C0E:00/input/input0
[    1.331697] ACPI: button: Sleep Button [SLPB]
[    1.331716] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/=
PNP0C0C:00/input/input1
[    1.331725] ACPI: button: Power Button [PWRB]
[    1.331741] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PN=
P0C0D:01/input/input2
[    1.331751] ACPI: button: Lid Switch [LID1]
[    1.339506] thermal LNXTHERM:00: registered as thermal=5Fzone0
[    1.339509] ACPI: thermal: Thermal Zone [ECTZ] (54 C)
[    1.348377] thermal LNXTHERM:01: registered as thermal=5Fzone1
[    1.348382] ACPI: thermal: Thermal Zone [TZ00] (54 C)
[    1.348683] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.353015] hpet=5Facpi=5Fadd: no address or irqs in =5FCRS
[    1.353049] Non-volatile memory driver v1.3
[    1.353050] Linux agpgart interface v0.103
[    1.353467] ACPI: bus type drm=5Fconnector registered
[    1.355794] usbcore: registered new interface driver usbserial=5Fgen=
eric
[    1.355799] usbserial: USB Serial support registered for generic
[    1.355854] rtc=5Fcmos rtc=5Fcmos: RTC can wake from S4
[    1.357108] rtc=5Fcmos rtc=5Fcmos: registered as rtc0
[    1.357321] rtc=5Fcmos rtc=5Fcmos: setting system clock to 2024-05-2=
0T14:53:18 UTC (1716216798)
[    1.357345] rtc=5Fcmos rtc=5Fcmos: alarms up to one month, y3k, 114 =
bytes nvram
[    1.359260] intel=5Fpstate: Intel P-state driver initializing
[    1.363075] intel=5Fpstate: HWP enabled
[    1.363709] ledtrig-cpu: registered to indicate activity on CPUs
[    1.364165] [drm] Initialized simpledrm 1.0.0 20200625 for simple-fr=
amebuffer.0 on minor 0
[    1.365607] fbcon: Deferring console take-over
[    1.365610] simple-framebuffer simple-framebuffer.0: [drm] fb0: simp=
ledrmdrmfb frame buffer device
[    1.365670] hid: raw HID events driver (C) Jiri Kosina
[    1.365740] drop=5Fmonitor: Initializing network drop monitor servic=
e
[    1.365852] NET: Registered PF=5FINET6 protocol family
[    1.366066] ACPI: battery: Slot [BAT0] (battery present)
[    1.370946] Segment Routing with IPv6
[    1.370947] RPL Segment Routing with IPv6
[    1.370954] In-situ OAM (IOAM) with IPv6
[    1.370968] NET: Registered PF=5FPACKET protocol family
[    1.373146] ENERGY=5FPERF=5FBIAS: Set to 'normal', was 'performance'
[    1.374353] microcode: Current revision: 0x00000419
[    1.375596] unchecked MSR access error: WRMSR to 0xd10 (tried to wri=
te 0x000000000000ffff) at rIP: 0xffffffffaba8c9f8 (native=5Fwrite=5Fmsr=
+0x8/0x30)
[    1.375634] Call Trace:
[    1.375636]  <TASK>
[    1.375638]  ? ex=5Fhandler=5Fmsr.isra.0.cold+0x5b/0x60
[    1.375640]  ? fixup=5Fexception+0x2c3/0x3a0
[    1.375642]  ? gp=5Ftry=5Ffixup=5Fand=5Fnotify+0x1e/0xb0
[    1.375644]  ? exc=5Fgeneral=5Fprotection+0x104/0x400
[    1.375645]  ? security=5Fkernfs=5Finit=5Fsecurity+0x35/0x50
[    1.375648]  ? asm=5Fexc=5Fgeneral=5Fprotection+0x26/0x30
[    1.375650]  ? native=5Fwrite=5Fmsr+0x8/0x30
[    1.375652]  cat=5Fwrmsr+0x49/0x70
[    1.375654]  resctrl=5Farch=5Fonline=5Fcpu+0x353/0x3a0
[    1.375655]  ? =5F=5Fpfx=5Fresctrl=5Farch=5Fonline=5Fcpu+0x10/0x10
[    1.375656]  cpuhp=5Finvoke=5Fcallback+0x11f/0x410
[    1.375658]  ? =5F=5Fpfx=5Fsmpboot=5Fthread=5Ffn+0x10/0x10
[    1.375660]  cpuhp=5Fthread=5Ffun+0xa2/0x150
[    1.375662]  smpboot=5Fthread=5Ffn+0xda/0x1d0
[    1.375664]  kthread+0xcf/0x100
[    1.375666]  ? =5F=5Fpfx=5Fkthread+0x10/0x10
[    1.375667]  ret=5Ffrom=5Ffork+0x31/0x50
[    1.375669]  ? =5F=5Fpfx=5Fkthread+0x10/0x10
[    1.375670]  ret=5Ffrom=5Ffork=5Fasm+0x1a/0x30
[    1.375672]  </TASK>
[    1.376790] resctrl: L2 allocation detected
[    1.376806] IPI shorthand broadcast: enabled
[    1.378074] sched=5Fclock: Marking stable (1361152460, 15632359)->(1=
402903977, -26119158)
[    1.378613] Timer migration: 2 hierarchy levels; 8 children per grou=
p; 2 crossnode level
[    1.379729] registered taskstats version 1
[    1.382404] Loading compiled-in X.509 certificates
[    1.385786] Loaded X.509 cert 'Build time autogenerated kernel key: =
be4bbad69eed7dd060ec4b225d099c7ad90dc57b'
[    1.389855] zswap: loaded using pool zstd/zsmalloc
[    1.390317] Key type .fscrypt registered
[    1.390319] Key type fscrypt-provisioning registered
[    1.390899] integrity: Loading X.509 certificate: UEFI:db
[    1.390916] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI=
 CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.390917] integrity: Loading X.509 certificate: UEFI:db
[    1.390925] integrity: Loaded X.509 cert 'Microsoft Windows Producti=
on PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.390925] integrity: Loading X.509 certificate: UEFI:db
[    1.393771] integrity: Loaded X.509 cert 'UNIWILL Tech BIOS 2019 Roo=
t CA: 815e876df90e5b8b41d2d56d0c39e0b6'
[    1.394840] PM:   Magic number: 8:321:890
[    1.394874] pci 0000:00:1f.3: hash matches
[    1.397632] RAS: Correctable Errors collector initialized.
[    1.404138] clk: Disabling unused clocks
[    1.404139] PM: genpd: Disabling unused power domains
[    1.409491] Freeing unused decrypted memory: 2028K
[    1.410103] Freeing unused kernel image (initmem) memory: 3408K
[    1.410104] Write protecting the kernel read-only data: 32768k
[    1.411101] Freeing unused kernel image (rodata/data gap) memory: 10=
60K
[    1.415713] x86/mm: Checked W+X mappings: passed, no W+X pages found=
.
[    1.415716] rodata=5Ftest: all tests were successful
[    1.415719] Run /init as init process
[    1.415720]   with arguments:
[    1.415721]     /init
[    1.415722]   with environment:
[    1.415722]     HOME=3D/
[    1.415722]     TERM=3Dlinux
[    1.449718] fbcon: Taking over console
[    1.454926] Console: switching to colour frame buffer device 160x50
[    1.540097] xhci=5Fhcd 0000:00:0d.0: xHCI Host Controller
[    1.540118] xhci=5Fhcd 0000:00:0d.0: new USB bus registered, assigne=
d bus number 1
[    1.541194] xhci=5Fhcd 0000:00:0d.0: hcc params 0x20007fc1 hci versi=
on 0x120 quirks 0x0000000200009810
[    1.541565] xhci=5Fhcd 0000:00:0d.0: xHCI Host Controller
[    1.541571] xhci=5Fhcd 0000:00:0d.0: new USB bus registered, assigne=
d bus number 2
[    1.541576] xhci=5Fhcd 0000:00:0d.0: Host supports USB 3.2 Enhanced =
SuperSpeed
[    1.541704] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002, bcdDevice=3D 6.09
[    1.541711] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.541714] usb usb1: Product: xHCI Host Controller
[    1.541717] usb usb1: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
[    1.541719] usb usb1: SerialNumber: 0000:00:0d.0
[    1.541934] hub 1-0:1.0: USB hub found
[    1.541959] hub 1-0:1.0: 1 port detected
[    1.542509] usb usb2: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0003, bcdDevice=3D 6.09
[    1.542514] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.542517] usb usb2: Product: xHCI Host Controller
[    1.542520] usb usb2: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
[    1.542522] usb usb2: SerialNumber: 0000:00:0d.0
[    1.542672] hub 2-0:1.0: USB hub found
[    1.542693] hub 2-0:1.0: 1 port detected
[    1.542995] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 =
irq 1
[    1.543000] i8042: PNP: PS/2 appears to have AUX port disabled, if t=
his is incorrect please boot with i8042.nopnp
[    1.543955] xhci=5Fhcd 0000:00:14.0: xHCI Host Controller
[    1.543964] xhci=5Fhcd 0000:00:14.0: new USB bus registered, assigne=
d bus number 3
[    1.544094] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.545115] xhci=5Fhcd 0000:00:14.0: hcc params 0x20007fc1 hci versi=
on 0x120 quirks 0x0000100200009810
[    1.545597] xhci=5Fhcd 0000:00:14.0: xHCI Host Controller
[    1.545603] xhci=5Fhcd 0000:00:14.0: new USB bus registered, assigne=
d bus number 4
[    1.545608] xhci=5Fhcd 0000:00:14.0: Host supports USB 3.1 Enhanced =
SuperSpeed
[    1.545739] usb usb3: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002, bcdDevice=3D 6.09
[    1.545746] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.545749] usb usb3: Product: xHCI Host Controller
[    1.545751] usb usb3: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
[    1.545765] usb usb3: SerialNumber: 0000:00:14.0
[    1.545959] hub 3-0:1.0: USB hub found
[    1.545998] hub 3-0:1.0: 12 ports detected
[    1.549223] usb usb4: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0003, bcdDevice=3D 6.09
[    1.549230] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.549233] usb usb4: Product: xHCI Host Controller
[    1.549235] usb usb4: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
[    1.549237] usb usb4: SerialNumber: 0000:00:14.0
[    1.549392] hub 4-0:1.0: USB hub found
[    1.549424] hub 4-0:1.0: 4 ports detected
[    1.550720] usb: port power management may be unreliable
[    1.551177] xhci=5Fhcd 0000:05:00.0: xHCI Host Controller
[    1.551187] xhci=5Fhcd 0000:05:00.0: new USB bus registered, assigne=
d bus number 5
[    1.552475] xhci=5Fhcd 0000:05:00.0: hcc params 0x200077c1 hci versi=
on 0x110 quirks 0x0000000200009810
[    1.552960] xhci=5Fhcd 0000:05:00.0: xHCI Host Controller
[    1.552966] xhci=5Fhcd 0000:05:00.0: new USB bus registered, assigne=
d bus number 6
[    1.552970] xhci=5Fhcd 0000:05:00.0: Host supports USB 3.1 Enhanced =
SuperSpeed
[    1.553072] usb usb5: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002, bcdDevice=3D 6.09
[    1.553079] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.553082] usb usb5: Product: xHCI Host Controller
[    1.553085] usb usb5: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
[    1.553087] usb usb5: SerialNumber: 0000:05:00.0
[    1.553199] nvme 0000:02:00.0: platform quirk: setting simple suspen=
d
[    1.553277] hub 5-0:1.0: USB hub found
[    1.553289] nvme nvme0: pci function 0000:02:00.0
[    1.553296] hub 5-0:1.0: 2 ports detected
[    1.553520] usb usb6: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0003, bcdDevice=3D 6.09
[    1.553524] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.553527] usb usb6: Product: xHCI Host Controller
[    1.553529] usb usb6: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
[    1.553530] usb usb6: SerialNumber: 0000:05:00.0
[    1.553650] hub 6-0:1.0: USB hub found
[    1.553671] hub 6-0:1.0: 2 ports detected
[    1.566265] nvme nvme0: D3 entry latency set to 10 seconds
[    1.570587] nvme nvme0: 20/0/0 default/read/poll queues
[    1.574000]  nvme0n1: p1 p2 p3
[    1.587906] input: AT Translated Set 2 keyboard as /devices/platform=
/i8042/serio0/input/input3
[    1.787335] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    1.799103] usb 3-3: new high-speed USB device number 2 using xhci=5F=
hcd
[    1.799438] Console: switching to colour dummy device 80x25
[    1.809003] usb 5-1: new high-speed USB device number 2 using xhci=5F=
hcd
[    1.856539] i915 0000:00:02.0: vgaarb: deactivate vga console
[    1.856796] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[    1.858495] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecod=
es=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    1.865545] i915 0000:00:02.0: [drm] Finished loading DMC firmware i=
915/adlp=5Fdmc.bin (v2.20)
[    1.942577] usb 3-3: New USB device found, idVendor=3D05e3, idProduc=
t=3D0610, bcdDevice=3D23.11
[    1.942581] usb 3-3: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    1.942582] usb 3-3: Product: USB2.1 Hub
[    1.942583] usb 3-3: Manufacturer: GenesysLogic
[    1.944068] hub 3-3:1.0: USB hub found
[    1.944454] hub 3-3:1.0: 2 ports detected
[    1.957336] usb 5-1: New USB device found, idVendor=3D2188, idProduc=
t=3D0610, bcdDevice=3D70.42
[    1.957346] usb 5-1: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    1.957347] usb 5-1: Product: USB2.1 Hub
[    1.957348] usb 5-1: Manufacturer: CalDigit, Inc.
[    1.958840] hub 5-1:1.0: USB hub found
[    1.959319] hub 5-1:1.0: 4 ports detected
[    2.062679] usb 4-4: new SuperSpeed USB device number 2 using xhci=5F=
hcd
[    2.076222] usb 6-1: new SuperSpeed Plus Gen 2x1 USB device number 2=
 using xhci=5Fhcd
[    2.083416] usb 4-4: New USB device found, idVendor=3D05e3, idProduc=
t=3D0620, bcdDevice=3D23.11
[    2.083422] usb 4-4: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    2.083423] usb 4-4: Product: USB3.2 Hub
[    2.083424] usb 4-4: Manufacturer: GenesysLogic
[    2.085691] hub 4-4:1.0: USB hub found
[    2.086078] hub 4-4:1.0: 2 ports detected
[    2.098380] usb 6-1: New USB device found, idVendor=3D2188, idProduc=
t=3D0625, bcdDevice=3D70.42
[    2.098408] usb 6-1: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    2.098420] usb 6-1: Product: USB3.1 Gen2 Hub
[    2.098424] usb 6-1: Manufacturer: CalDigit, Inc.
[    2.100588] hub 6-1:1.0: USB hub found
[    2.101037] hub 6-1:1.0: 4 ports detected
[    2.202446] usb 3-10: new full-speed USB device number 3 using xhci=5F=
hcd
[    2.227786] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/adlp=5Fg=
uc=5F70.bin version 70.20.0
[    2.227792] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl=5Fhu=
c.bin version 7.9.3
[    2.248792] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all=
 workloads
[    2.249854] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[    2.249856] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[    2.250380] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[    2.251147] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protect=
ed content support initialized
[    2.265883] usb 5-1.4: new high-speed USB device number 3 using xhci=
=5Fhcd
[    2.346120] usb 3-10: New USB device found, idVendor=3D8087, idProdu=
ct=3D0026, bcdDevice=3D 0.02
[    2.346145] usb 3-10: New USB device strings: Mfr=3D0, Product=3D0, =
SerialNumber=3D0
[    2.383992] usb 5-1.4: New USB device found, idVendor=3D2188, idProd=
uct=3D0611, bcdDevice=3D93.06
[    2.384024] usb 5-1.4: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[    2.384037] usb 5-1.4: Product: USB2.1 Hub
[    2.384046] usb 5-1.4: Manufacturer: CalDigit, Inc.
[    2.386528] hub 5-1.4:1.0: USB hub found
[    2.386995] hub 5-1.4:1.0: 4 ports detected
[    2.445908] usb 3-3.2: new full-speed USB device number 4 using xhci=
=5Fhcd
[    2.456400] usb 6-1.1: new SuperSpeed USB device number 3 using xhci=
=5Fhcd
[    2.479296] usb 6-1.1: New USB device found, idVendor=3D2188, idProd=
uct=3D0754, bcdDevice=3D 0.06
[    2.479328] usb 6-1.1: New USB device strings: Mfr=3D3, Product=3D4,=
 SerialNumber=3D2
[    2.479339] usb 6-1.1: Product: USB-C Pro Card Reader
[    2.479348] usb 6-1.1: Manufacturer: CalDigit
[    2.479356] usb 6-1.1: SerialNumber: 000000000006
[    2.493437] usb-storage 6-1.1:1.0: USB Mass Storage device detected
[    2.494250] scsi host0: usb-storage 6-1.1:1.0
[    2.494341] usbcore: registered new interface driver usb-storage
[    2.497296] usbcore: registered new interface driver uas
[    2.559700] usb 6-1.4: new SuperSpeed USB device number 4 using xhci=
=5Fhcd
[    2.563887] usb 3-3.2: New USB device found, idVendor=3D046d, idProd=
uct=3Dc24d, bcdDevice=3D80.01
[    2.563921] usb 3-3.2: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[    2.563933] usb 3-3.2: Product: Logitech G710 Keyboard
[    2.563942] usb 3-3.2: Manufacturer: Logitech
[    2.580690] usb 6-1.4: New USB device found, idVendor=3D2188, idProd=
uct=3D0620, bcdDevice=3D93.06
[    2.580701] usb 6-1.4: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[    2.580705] usb 6-1.4: Product: USB3.1 Gen1 Hub
[    2.580707] usb 6-1.4: Manufacturer: CalDigit, Inc.
[    2.583857] hub 6-1.4:1.0: USB hub found
[    2.584157] hub 6-1.4:1.0: 4 ports detected
[    2.593273] usbcore: registered new interface driver usbhid
[    2.593280] usbhid: USB HID core driver
[    2.599218] input: Logitech Logitech G710 Keyboard as /devices/pci00=
00:00/0000:00:14.0/usb3/3-3/3-3.2/3-3.2:1.0/0003:046D:C24D.0001/input/i=
nput4
[    2.633027] usb 4-4.1: new SuperSpeed USB device number 3 using xhci=
=5Fhcd
[    2.656877] hid-generic 0003:046D:C24D.0001: input,hidraw0: USB HID =
v1.11 Keyboard [Logitech Logitech G710 Keyboard] on usb-0000:00:14.0-3.=
2/input0
[    2.657514] input: Logitech Logitech G710 Keyboard as /devices/pci00=
00:00/0000:00:14.0/usb3/3-3/3-3.2/3-3.2:1.1/0003:046D:C24D.0002/input/i=
nput5
[    2.665524] usb 4-4.1: New USB device found, idVendor=3D0bda, idProd=
uct=3D0316, bcdDevice=3D 2.04
[    2.665548] usb 4-4.1: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D3
[    2.665556] usb 4-4.1: Product: USB3.0-CRW
[    2.665563] usb 4-4.1: Manufacturer: Generic
[    2.665568] usb 4-4.1: SerialNumber: 20120501030900000
[    2.676856] usb-storage 4-4.1:1.0: USB Mass Storage device detected
[    2.677980] scsi host1: usb-storage 4-4.1:1.0
[    2.692597] usb 5-1.4.1: new high-speed USB device number 4 using xh=
ci=5Fhcd
[    2.713981] hid-generic 0003:046D:C24D.0002: input,hiddev96,hidraw1:=
 USB HID v1.11 Keyboard [Logitech Logitech G710 Keyboard] on usb-0000:0=
0:14.0-3.2/input1
[    3.036233] usb 6-1.4.4: new SuperSpeed USB device number 5 using xh=
ci=5Fhcd
[    3.055609] usb 6-1.4.4: New USB device found, idVendor=3D0bda, idPr=
oduct=3D8153, bcdDevice=3D31.00
[    3.055630] usb 6-1.4.4: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D6
[    3.055654] usb 6-1.4.4: Product: USB 10/100/1000 LAN
[    3.055660] usb 6-1.4.4: Manufacturer: Realtek
[    3.055664] usb 6-1.4.4: SerialNumber: 001001000
[    3.378826] [drm] Initialized i915 1.6.0 20230929 for 0000:00:02.0 o=
n minor 1
[    3.382032] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: =
no  post: no)
[    3.382675] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP=
0A08:00/LNXVIDEO:00/input/input7
[    3.518077] scsi 0:0:0:0: Direct-Access     CalDigit SD Card Reader =
  0006 PQ: 0 ANSI: 6
[    3.519579] sd 0:0:0:0: [sda] Media removed, stopped polling
[    3.520526] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    3.544226] usb 5-1.4.1: New USB device found, idVendor=3D2188, idPr=
oduct=3D4042, bcdDevice=3D 0.06
[    3.544243] usb 5-1.4.1: New USB device strings: Mfr=3D3, Product=3D=
1, SerialNumber=3D0
[    3.544251] usb 5-1.4.1: Product: CalDigit USB-C Pro Audio
[    3.544257] usb 5-1.4.1: Manufacturer: CalDigit Inc.
[    3.561025] input: CalDigit Inc. CalDigit USB-C Pro Audio as /device=
s/pci0000:00/0000:00:07.0/0000:03:00.0/0000:04:02.0/0000:05:00.0/usb5/5=
-1/5-1.4/5-1.4.1/5-1.4.1:1.3/0003:2188:4042.0003/input/input8
[    3.566217] fbcon: i915drmfb (fb0) is primary device
[    3.615757] hid-generic 0003:2188:4042.0003: input,hidraw2: USB HID =
v1.11 Device [CalDigit Inc. CalDigit USB-C Pro Audio] on usb-0000:05:00=
.0-1.4.1/input3
[    3.709064] scsi 1:0:0:0: Direct-Access     Generic- SD/MMC         =
  1.00 PQ: 0 ANSI: 6
[    3.711992] sd 1:0:0:0: [sdb] Media removed, stopped polling
[    3.712858] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[    4.898964] Console: switching to colour frame buffer device 160x50
[    5.056316] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer dev=
ice
[    5.372262] EXT4-fs (nvme0n1p2): mounted filesystem 3d3927a4-190d-4e=
14-aae4-2b44c8b74da8 r/w with ordered data mode. Quota mode: none.
[    5.426337] systemd[1]: systemd 255.6-1-arch running in system mode =
(+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +O=
PENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCR=
YPTSETUP +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ=
4 +XZ +ZLIB +ZSTD +BPF=5FFRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-h=
ierarchy=3Dunified)
[    5.426346] systemd[1]: Detected architecture x86-64.
[    5.427242] systemd[1]: Hostname set to <pandora>.
[    5.956030] systemd[1]: bpf-lsm: LSM BPF program attached
[    6.093907] systemd[1]: Queued start job for default target Graphica=
l Interface.
[    6.127212] systemd[1]: Created slice Virtual Machine and Container =
Slice.
[    6.127939] systemd[1]: Created slice Slice /system/dirmngr.
[    6.128271] systemd[1]: Created slice Slice /system/getty.
[    6.128573] systemd[1]: Created slice Slice /system/gpg-agent.
[    6.128867] systemd[1]: Created slice Slice /system/gpg-agent-browse=
r.
[    6.129179] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    6.129447] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    6.129720] systemd[1]: Created slice Slice /system/keyboxd.
[    6.129965] systemd[1]: Created slice Slice /system/modprobe.
[    6.130238] systemd[1]: Created slice Slice /system/systemd-fsck.
[    6.130417] systemd[1]: Created slice User and Session Slice.
[    6.130504] systemd[1]: Started Dispatch Password Requests to Consol=
e Directory Watch.
[    6.130576] systemd[1]: Started Forward Password Requests to Wall Di=
rectory Watch.
[    6.130753] systemd[1]: Set up automount Arbitrary Executable File F=
ormats File System Automount Point.
[    6.130821] systemd[1]: Expecting device /dev/disk/by-diskseq/1-part=
3...
[    6.130868] systemd[1]: Expecting device /dev/disk/by-uuid/3512-6C76=
...
[    6.130913] systemd[1]: Reached target Local Encrypted Volumes.
[    6.130960] systemd[1]: Reached target Login Prompts.
[    6.131003] systemd[1]: Reached target Local Integrity Protected Vol=
umes.
[    6.131060] systemd[1]: Reached target Remote File Systems.
[    6.131100] systemd[1]: Reached target Slice Units.
[    6.131146] systemd[1]: Reached target System Time Set.
[    6.131196] systemd[1]: Reached target Local Verity Protected Volume=
s.
[    6.131291] systemd[1]: Listening on Device-mapper event daemon FIFO=
s.
[    6.131434] systemd[1]: Listening on LVM2 poll daemon socket.
[    6.132591] systemd[1]: Listening on Process Core Dump Socket.
[    6.132735] systemd[1]: Listening on Journal Socket (/dev/log).
[    6.132828] systemd[1]: Listening on Journal Socket.
[    6.132884] systemd[1]: TPM2 PCR Extension (Varlink) was skipped bec=
ause of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    6.133047] systemd[1]: Listening on udev Control Socket.
[    6.133127] systemd[1]: Listening on udev Kernel Socket.
[    6.134249] systemd[1]: Mounting Huge Pages File System...
[    6.135086] systemd[1]: Mounting POSIX Message Queue File System...
[    6.135856] systemd[1]: Mounting Kernel Debug File System...
[    6.136604] systemd[1]: Mounting Kernel Trace File System...
[    6.137435] systemd[1]: Starting Create List of Static Device Nodes.=
..
[    6.138314] systemd[1]: Starting Monitoring of LVM2 mirrors, snapsho=
ts etc. using dmeventd or progress polling...
[    6.139394] systemd[1]: Starting Load Kernel Module configfs...
[    6.141335] systemd[1]: Starting Load Kernel Module dm=5Fmod...
[    6.143109] systemd[1]: Starting Load Kernel Module drm...
[    6.144487] systemd[1]: Starting Load Kernel Module fuse...
[    6.146072] systemd[1]: Starting Load Kernel Module loop...
[    6.147105] systemd[1]: File System Check on Root Device was skipped=
 because of an unmet condition check (ConditionPathIsReadWrite=3D!/).
[    6.149060] systemd[1]: Starting Journal Service...
[    6.151343] systemd[1]: Starting Load Kernel Modules...
[    6.152229] systemd[1]: TPM2 PCR Machine ID Measurement was skipped =
because of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    6.152922] systemd[1]: Starting Remount Root and Kernel File System=
s...
[    6.154041] systemd[1]: TPM2 SRK Setup (Early) was skipped because o=
f an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    6.154872] systemd[1]: Starting Coldplug All udev Devices...
[    6.157017] systemd[1]: Mounted Huge Pages File System.
[    6.158012] systemd[1]: Mounted POSIX Message Queue File System.
[    6.159176] device-mapper: uevent: version 1.0.3
[    6.159236] loop: module loaded
[    6.159309] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initiali=
sed: dm-devel@lists.linux.dev
[    6.159323] systemd[1]: Mounted Kernel Debug File System.
[    6.160983] systemd[1]: Mounted Kernel Trace File System.
[    6.162213] systemd[1]: Finished Create List of Static Device Nodes.
[    6.163523] systemd[1]: modprobe@configfs.service: Deactivated succe=
ssfully.
[    6.163654] systemd[1]: Finished Load Kernel Module configfs.
[    6.164726] systemd[1]: modprobe@dm=5Fmod.service: Deactivated succe=
ssfully.
[    6.164821] systemd[1]: Finished Load Kernel Module dm=5Fmod.
[    6.165758] systemd-journald[421]: Collecting audit messages is disa=
bled.
[    6.165833] systemd[1]: modprobe@drm.service: Deactivated successful=
ly.
[    6.165917] systemd[1]: Finished Load Kernel Module drm.
[    6.166869] systemd[1]: modprobe@fuse.service: Deactivated successfu=
lly.
[    6.166938] systemd[1]: Finished Load Kernel Module fuse.
[    6.167989] systemd[1]: modprobe@loop.service: Deactivated successfu=
lly.
[    6.168089] systemd[1]: Finished Load Kernel Module loop.
[    6.168315] i2c=5Fdev: i2c /dev entries driver
[    6.169909] systemd[1]: Mounting FUSE Control File System...
[    6.171757] systemd[1]: Mounting Kernel Configuration File System...
[    6.172742] systemd[1]: Repartition Root Disk was skipped because no=
 trigger condition checks were met.
[    6.173609] systemd[1]: Starting Create Static Device Nodes in /dev =
gracefully...
[    6.175994] systemd[1]: Mounted FUSE Control File System.
[    6.177595] systemd[1]: Mounted Kernel Configuration File System.
[    6.196308] systemd[1]: Finished Create Static Device Nodes in /dev =
gracefully.
[    6.198351] systemd[1]: Started Journal Service.
[    6.200646] cryptd: max=5Fcpu=5Fqlen set to 1000
[    6.208978] AVX2 version of gcm=5Fenc/dec engaged.
[    6.209162] AES CTR mode by8 optimization enabled
[    6.216159] EXT4-fs (nvme0n1p2): re-mounted 3d3927a4-190d-4e14-aae4-=
2b44c8b74da8 r/w. Quota mode: none.
[    6.228101] systemd-journald[421]: Received client request to flush =
runtime journal.
[    6.252616] systemd-journald[421]: /var/log/journal/4af3a1e8e01745dd=
baff38b21f2c52c6/system.journal: Journal file uses a different sequence=
 number ID, rotating.
[    6.252620] systemd-journald[421]: Rotating system journal.
[    6.341410] Key type encrypted registered
[    6.346155] mc: Linux media interface: v0.10
[    6.357455] input: Intel HID events as /devices/platform/INTC1070:00=
/input/input9
[    6.358510] intel-hid INTC1070:00: failed to enable HID power button
[    6.377389] resource: resource sanity check: requesting [mem 0x00000=
000fedc0000-0x00000000fedcffff], which spans more than pnp 00:03 [mem 0=
xfedc0000-0xfedc7fff]
[    6.377399] caller igen6=5Fprobe+0x15e/0x7c0 [igen6=5Fedac] mapping =
multiple BARs
[    6.378507] videodev: Linux video capture interface: v2.00
[    6.379737] EDAC MC0: Giving out device to module igen6=5Fedac contr=
oller Intel=5Fclient=5FSoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
[    6.384896] EDAC MC1: Giving out device to module igen6=5Fedac contr=
oller Intel=5Fclient=5FSoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
[    6.384925] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[    6.384927] EDAC igen6 MC0: ADDR 0x7fffffffe0=20
[    6.384936] EDAC igen6 MC1: HANDLING IBECC MEMORY ERROR
[    6.384938] EDAC igen6 MC1: ADDR 0x7fffffffe0=20
[    6.385006] EDAC igen6: v2.5.1
[    6.411989] intel=5Fpmc=5Fcore INT33A1:00:  initialized
[    6.413222] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.414601] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    6.440226] i801=5Fsmbus 0000:00:1f.4: enabling device (0000 -> 0003=
)
[    6.440575] i801=5Fsmbus 0000:00:1f.4: SPD Write Disable is set
[    6.440673] i801=5Fsmbus 0000:00:1f.4: SMBus using PCI interrupt
[    6.441449] ACPI: bus type thunderbolt registered
[    6.441780] thunderbolt 0000:00:0d.2: total paths: 12
[    6.441788] thunderbolt 0000:00:0d.2: IOMMU DMA protection is enable=
d
[    6.442339] asus=5Fwmi: ASUS WMI generic driver loaded
[    6.442890] thunderbolt 0000:00:0d.2: allocating TX ring 0 of size 1=
0
[    6.442921] thunderbolt 0000:00:0d.2: allocating RX ring 0 of size 1=
0
[    6.442939] thunderbolt 0000:00:0d.2: control channel created
[    6.442943] thunderbolt 0000:00:0d.2: using software connection mana=
ger
[    6.445995] Creating 1 MTD partitions on "0000:00:1f.5":
[    6.446001] 0x000000000000-0x000002000000 : "BIOS"
[    6.451159] i2c i2c-15: Successfully instantiated SPD at 0x50
[    6.455029] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    6.455559] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    6.463925] Adding 11546620k swap on /dev/nvme0n1p3.  Priority:-2 ex=
tents:1 across:11546620k SS
[    6.466235] thunderbolt 0000:00:0d.2: created link from 0000:00:0d.0
[    6.486624] iTCO=5Fvendor=5Fsupport: vendor-support=3D0
[    6.497661] thunderbolt 0000:00:0d.2: created link from 0000:00:0d.0
[    6.497855] thunderbolt 0000:00:0d.2: created link from 0000:00:07.0
[    6.501553] thunderbolt 0000:00:0d.2: NHI initialized, starting thun=
derbolt
[    6.501557] thunderbolt 0000:00:0d.2: control channel starting...
[    6.501559] thunderbolt 0000:00:0d.2: starting TX ring 0
[    6.501563] thunderbolt 0000:00:0d.2: enabling interrupt at register=
 0x38200 bit 0 (0x0 -> 0x1)
[    6.501566] thunderbolt 0000:00:0d.2: starting RX ring 0
[    6.501568] thunderbolt 0000:00:0d.2: enabling interrupt at register=
 0x38200 bit 12 (0x1 -> 0x1001)
[    6.501572] thunderbolt 0000:00:0d.2: security level set to user
[    6.502011] thunderbolt 0000:00:0d.2: current switch config:
[    6.502013] thunderbolt 0000:00:0d.2:  USB4 Switch: 8087:463e (Revis=
ion: 2, TB Version: 32)
[    6.502015] thunderbolt 0000:00:0d.2:   Max Port Number: 13
[    6.502017] thunderbolt 0000:00:0d.2:   Config:
[    6.502018] thunderbolt 0000:00:0d.2:    Upstream Port Number: 7 Dep=
th: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 254ms
[    6.502020] thunderbolt 0000:00:0d.2:    unknown1: 0x0 unknown4: 0x0
[    6.510343] thunderbolt 0000:00:0d.2: initializing Switch at 0x0 (de=
pth: 0, up port: 7)
[    6.510607] asus=5Fwmi: ASUS Management GUID not found
[    6.510650] Bluetooth: Core ver 2.22
[    6.510680] NET: Registered PF=5FBLUETOOTH protocol family
[    6.510682] Bluetooth: HCI device and connection manager initialized
[    6.510687] Bluetooth: HCI socket layer initialized
[    6.510689] Bluetooth: L2CAP socket layer initialized
[    6.510693] Bluetooth: SCO socket layer initialized
[    6.512060] thunderbolt 0000:00:0d.2: 0: credit allocation parameter=
s:
[    6.512066] thunderbolt 0000:00:0d.2: 0:  USB3: 32
[    6.512068] thunderbolt 0000:00:0d.2: 0:  DP AUX: 1
[    6.512071] thunderbolt 0000:00:0d.2: 0:  DP main: 0
[    6.512073] thunderbolt 0000:00:0d.2: 0:  PCIe: 64
[    6.512074] thunderbolt 0000:00:0d.2: 0:  DMA: 14
[    6.517379] thunderbolt 0000:00:0d.2: 0: DROM version: 3
[    6.517642] thunderbolt 0000:00:0d.2: 0: uid: 0xeeeed3e080874857
[    6.520072] thunderbolt 0000:00:0d.2:  Port 1: 8087:15ea (Revision: =
0, TB Version: 1, Type: Port (0x1))
[    6.520076] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/19
[    6.520077] thunderbolt 0000:00:0d.2:   Max counters: 16
[    6.520078] thunderbolt 0000:00:0d.2:   NFC Credits: 0x47800000
[    6.520080] thunderbolt 0000:00:0d.2:   Credits (total/control): 120=
/2
[    6.522599] thunderbolt 0000:00:0d.2:  Port 2: 8087:15ea (Revision: =
0, TB Version: 1, Type: Port (0x1))
[    6.522602] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/19
[    6.522604] thunderbolt 0000:00:0d.2:   Max counters: 16
[    6.522605] thunderbolt 0000:00:0d.2:   NFC Credits: 0x80000000
[    6.522606] thunderbolt 0000:00:0d.2:   Credits (total/control): 0/2
[    6.524455] thunderbolt 0000:00:0d.2:  Port 3: 8087:15ea (Revision: =
0, TB Version: 1, Type: Port (0x1))
[    6.524457] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/19
[    6.524459] thunderbolt 0000:00:0d.2:   Max counters: 16
[    6.524460] thunderbolt 0000:00:0d.2:   NFC Credits: 0x83c00000
[    6.524461] thunderbolt 0000:00:0d.2:   Credits (total/control): 60/=
2
[    6.526989] thunderbolt 0000:00:0d.2:  Port 4: 8087:15ea (Revision: =
0, TB Version: 1, Type: Port (0x1))
[    6.526992] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/19
[    6.526993] thunderbolt 0000:00:0d.2:   Max counters: 16
[    6.526995] thunderbolt 0000:00:0d.2:   NFC Credits: 0x83c00000
[    6.526996] thunderbolt 0000:00:0d.2:   Credits (total/control): 60/=
2
[    6.527258] thunderbolt 0000:00:0d.2:  Port 5: 8087:15ea (Revision: =
0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    6.527262] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 9/9
[    6.527264] thunderbolt 0000:00:0d.2:   Max counters: 2
[    6.527265] thunderbolt 0000:00:0d.2:   NFC Credits: 0x100000c
[    6.527267] thunderbolt 0000:00:0d.2:   Credits (total/control): 16/=
0
[    6.527526] thunderbolt 0000:00:0d.2:  Port 6: 8087:15ea (Revision: =
0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    6.527530] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 9/9
[    6.527532] thunderbolt 0000:00:0d.2:   Max counters: 2
[    6.527534] thunderbolt 0000:00:0d.2:   NFC Credits: 0x100000c
[    6.527536] thunderbolt 0000:00:0d.2:   Credits (total/control): 16/=
0
[    6.528865] thunderbolt 0000:00:0d.2:  Port 7: 8086:15ea (Revision: =
0, TB Version: 1, Type: NHI (0x2))
[    6.528869] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 11/11
[    6.528871] thunderbolt 0000:00:0d.2:   Max counters: 16
[    6.528873] thunderbolt 0000:00:0d.2:   NFC Credits: 0x1c00000
[    6.528875] thunderbolt 0000:00:0d.2:   Credits (total/control): 28/=
0
[    6.529658] thunderbolt 0000:00:0d.2:  Port 8: 8087:15ea (Revision: =
0, TB Version: 1, Type: PCIe (0x100101))
[    6.529663] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    6.529666] thunderbolt 0000:00:0d.2:   Max counters: 2
[    6.529668] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    6.529671] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    6.529924] thunderbolt 0000:00:0d.2:  Port 9: 8087:15ea (Revision: =
0, TB Version: 1, Type: PCIe (0x100101))
[    6.529928] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    6.529931] thunderbolt 0000:00:0d.2:   Max counters: 2
[    6.529933] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    6.529936] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    6.530058] thunderbolt 0000:00:0d.2:  Port 10: not implemented
[    6.530191] thunderbolt 0000:00:0d.2:  Port 11: not implemented
[    6.530998] thunderbolt 0000:00:0d.2:  Port 12: 8087:0 (Revision: 0,=
 TB Version: 1, Type: USB (0x200101))
[    6.531003] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    6.531005] thunderbolt 0000:00:0d.2:   Max counters: 2
[    6.531007] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    6.531009] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    6.531264] thunderbolt 0000:00:0d.2:  Port 13: 8087:0 (Revision: 0,=
 TB Version: 1, Type: USB (0x200101))
[    6.531268] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    6.531270] thunderbolt 0000:00:0d.2:   Max counters: 2
[    6.531272] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    6.531274] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    6.531277] thunderbolt 0000:00:0d.2: 0: running quirk=5Fusb3=5Fmaxi=
mum=5Fbandwidth [thunderbolt]
[    6.531336] thunderbolt 0000:00:0d.2: 0:12: USB3 maximum bandwidth l=
imited to 16376 Mb/s
[    6.531340] thunderbolt 0000:00:0d.2: 0:13: USB3 maximum bandwidth l=
imited to 16376 Mb/s
[    6.531343] thunderbolt 0000:00:0d.2: 0: linked ports 1 <-> 2
[    6.531346] thunderbolt 0000:00:0d.2: 0: linked ports 3 <-> 4
[    6.537690] cfg80211: Loading compiled-in X.509 certificates for reg=
ulatory database
[    6.537855] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    6.537983] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c724=
8db18c600'
[    6.538161] ee1004 15-0050: 512 byte EE1004-compliant SPD EEPROM, re=
ad-only
[    6.538442] platform regulatory.0: Direct firmware load for regulato=
ry.db failed with error -2
[    6.538445] cfg80211: failed to load regulatory.db
[    6.540805] thunderbolt 0000:00:0d.2: 0: TMU: supports uni-direction=
al mode
[    6.540915] thunderbolt 0000:00:0d.2: 0: TMU: current mode: off
[    6.545193] thunderbolt 0000:00:0d.2: 0: TMU: mode change off -> uni=
-directional, LowRes requested
[    6.545661] thunderbolt 0000:00:0d.2: 0: TMU: mode set to: uni-direc=
tional, LowRes
[    6.546569] thunderbolt 0000:00:0d.2: 0:1: is connected, link is up =
(state: 2)
[    6.547966] thunderbolt 0000:00:0d.2: 0:1: reading NVM authenticatio=
n status of retimers
[    6.637293] input: UNIW0001:00 093A:0274 Mouse as /devices/pci0000:0=
0/0000:00:15.0/i2c=5Fdesignware.0/i2c-16/i2c-UNIW0001:00/0018:093A:0274=
.0004/input/input10
[    6.637527] input: UNIW0001:00 093A:0274 Touchpad as /devices/pci000=
0:00/0000:00:15.0/i2c=5Fdesignware.0/i2c-16/i2c-UNIW0001:00/0018:093A:0=
274.0004/input/input11
[    6.637794] hid-generic 0018:093A:0274.0004: input,hidraw3: I2C HID =
v1.00 Mouse [UNIW0001:00 093A:0274] on i2c-UNIW0001:00
[    6.648825] usbcore: registered new device driver r8152-cfgselector
[    6.649864] iTCO=5Fwdt iTCO=5Fwdt: Found a Intel PCH TCO device (Ver=
sion=3D6, TCOBASE=3D0x0400)
[    6.650081] iTCO=5Fwdt iTCO=5Fwdt: initialized. heartbeat=3D30 sec (=
nowayout=3D0)
[    6.651912] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 65=
5360 ms ovfl timer
[    6.651916] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    6.651917] RAPL PMU: hw unit of domain package 2^-14 Joules
[    6.651918] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    6.651919] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    6.651974] intel=5Frapl=5Fmsr: PL4 support detected.
[    6.652409] intel=5Frapl=5Fcommon: Found RAPL domain package
[    6.652413] intel=5Frapl=5Fcommon: Found RAPL domain core
[    6.652415] intel=5Frapl=5Fcommon: Found RAPL domain uncore
[    6.652417] intel=5Frapl=5Fcommon: Found RAPL domain psys
[    6.663446] Intel(R) Wireless WiFi driver for Linux
[    6.663986] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    6.668489] iwlwifi 0000:00:14.3: Detected crf-id 0x1300504, cnv-id =
0x80400 wfpm id 0x80000030
[    6.668545] iwlwifi 0000:00:14.3: PCI dev 51f0/0074, rev=3D0x370, rf=
id=3D0x10a100
[    6.675150] proc=5Fthermal=5Fpci 0000:00:04.0: enabling device (0000=
 -> 0002)
[    6.675447] intel=5Frapl=5Fcommon: Found RAPL domain package
[    6.676700] iwlwifi 0000:00:14.3: TLV=5FFW=5FFSEQ=5FVERSION: FSEQ Ve=
rsion: 0.0.2.42
[    6.677050] iwlwifi 0000:00:14.3: loaded firmware version 89.e9cec78=
e.0 so-a0-hr-b0-89.ucode op=5Fmode iwlmvm
[    6.678418] proc=5Fthermal=5Fpci 0000:00:04.0: error: proc=5Fthermal=
=5Fadd, will continue
[    6.679985] Consider using thermal netlink events interface
[    6.683509] pps=5Fcore: LinuxPPS API ver. 1 registered
[    6.683513] pps=5Fcore: Software ver. 5.3.6 - Copyright 2005-2007 Ro=
dolfo Giometti <giometti@linux.it>
[    6.688142] PTP clock support registered
[    6.704202] snd=5Fhda=5Fintel 0000:00:1f.3: DSP detected with PCI cl=
ass/subclass/prog-if info 0x040380
[    6.704406] snd=5Fhda=5Fintel 0000:00:1f.3: enabling device (0000 ->=
 0002)
[    6.704747] snd=5Fhda=5Fintel 0000:00:1f.3: bound 0000:00:02.0 (ops =
i915=5Faudio=5Fcomponent=5Fbind=5Fops [i915])
[    6.734008] input: UNIW0001:00 093A:0274 Mouse as /devices/pci0000:0=
0/0000:00:15.0/i2c=5Fdesignware.0/i2c-16/i2c-UNIW0001:00/0018:093A:0274=
.0004/input/input12
[    6.734223] input: UNIW0001:00 093A:0274 Touchpad as /devices/pci000=
0:00/0000:00:15.0/i2c=5Fdesignware.0/i2c-16/i2c-UNIW0001:00/0018:093A:0=
274.0004/input/input13
[    6.734281] hid-multitouch 0018:093A:0274.0004: input,hidraw3: I2C H=
ID v1.00 Mouse [UNIW0001:00 093A:0274] on i2c-UNIW0001:00
[    6.736083] r8152-cfgselector 6-1.4.4: reset SuperSpeed USB device n=
umber 5 using xhci=5Fhcd
[    6.773224] r8152 6-1.4.4:1.0: load rtl8153b-2 v2 04/27/23 successfu=
lly
[    6.786048] usbcore: registered new interface driver btusb
[    6.788155] Bluetooth: hci0: Device revision is 2
[    6.788161] Bluetooth: hci0: Secure boot is enabled
[    6.788163] Bluetooth: hci0: OTP lock is enabled
[    6.788164] Bluetooth: hci0: API lock is enabled
[    6.788166] Bluetooth: hci0: Debug lock is disabled
[    6.788167] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    6.788169] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype =
1 build 38
[    6.788247] ACPI Warning: \=5FSB.PC00.XHCI.RHUB.HS10.=5FDSM: Argumen=
t #4 type mismatch - Found [Integer], ACPI requires [Package] (20230628=
/nsarguments-61)
[    6.788333] Bluetooth: hci0: DSM reset method type: 0x00
[    6.792713] mousedev: PS/2 mouse device common for all mice
[    6.793686] Bluetooth: hci0: Found device firmware: intel/ibt-0040-4=
150.sfi
[    6.793707] Bluetooth: hci0: Boot Address: 0x100800
[    6.793710] Bluetooth: hci0: Firmware Version: 46-14.24
[    6.815742] r8152 6-1.4.4:1.0 eth0: v1.12.13
[    6.815790] usbcore: registered new interface driver r8152
[    6.822538] snd=5Fhda=5Fcodec=5Frealtek hdaudioC1D0: autoconfig for =
ALC256: line=5Fouts=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    6.822546] snd=5Fhda=5Fcodec=5Frealtek hdaudioC1D0:    speaker=5Fou=
ts=3D0 (0x0/0x0/0x0/0x0/0x0)
[    6.822549] snd=5Fhda=5Fcodec=5Frealtek hdaudioC1D0:    hp=5Fouts=3D=
1 (0x21/0x0/0x0/0x0/0x0)
[    6.822552] snd=5Fhda=5Fcodec=5Frealtek hdaudioC1D0:    mono: mono=5F=
out=3D0x0
[    6.822554] snd=5Fhda=5Fcodec=5Frealtek hdaudioC1D0:    inputs:
[    6.822555] snd=5Fhda=5Fcodec=5Frealtek hdaudioC1D0:      Mic=3D0x19
[    6.822557] snd=5Fhda=5Fcodec=5Frealtek hdaudioC1D0:      Internal M=
ic=3D0x12
[    6.841011] usbcore: registered new interface driver cdc=5Fether
[    6.845479] usbcore: registered new interface driver r8153=5Fecm
[    6.848534] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 16=
0MHz, REV=3D0x370
[    6.848591] thermal thermal=5Fzone3: failed to read out thermal zone=
 (-61)
[    6.858385] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[    6.860970] intel=5Ftcc=5Fcooling: Programmable TCC Offset detected
[    6.922782] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:=
1f.3/sound/card1/input14
[    6.922849] input: HDA Intel PCH Headphone as /devices/pci0000:00/00=
00:00:1f.3/sound/card1/input15
[    6.922889] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000=
:00/0000:00:1f.3/sound/card1/input16
[    6.922929] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000=
:00/0000:00:1f.3/sound/card1/input17
[    6.922969] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000=
:00/0000:00:1f.3/sound/card1/input18
[    6.923033] input: HDA Intel PCH HDMI/DP,pcm=3D9 as /devices/pci0000=
:00/0000:00:1f.3/sound/card1/input19
[    6.963134] iwlwifi 0000:00:14.3: WFPM=5FUMAC=5FPD=5FNOTIFICATION: 0=
x20
[    6.963193] iwlwifi 0000:00:14.3: WFPM=5FLMAC2=5FPD=5FNOTIFICATION: =
0x1f
[    6.963254] iwlwifi 0000:00:14.3: WFPM=5FAUTH=5FKEY=5F0: 0x90
[    6.963265] iwlwifi 0000:00:14.3: CNVI=5FSCU=5FSEQ=5FDATA=5FDW9: 0x1=
0
[    6.963391] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=3D0x10a100
[    6.964556] iwlwifi 0000:00:14.3: RFIm is deactivated, reason =3D 5
[    7.031049] iwlwifi 0000:00:14.3: base HW address: 7c:21:4a:40:58:49
[    7.051156] r8152 6-1.4.4:1.0 enp5s0u1u4u4: renamed from eth0
[    7.052814] iwlwifi 0000:00:14.3 wlo1: renamed from wlan0
[    7.162236] thunderbolt 0000:00:0d.2: 0:1: disabling sideband transa=
ctions
[    7.321368] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    7.321374] Bluetooth: BNEP filters: protocol multicast
[    7.321378] Bluetooth: BNEP socket layer initialized
[    7.394815] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[    7.494263] iwlwifi 0000:00:14.3: WFPM=5FUMAC=5FPD=5FNOTIFICATION: 0=
x20
[    7.494321] iwlwifi 0000:00:14.3: WFPM=5FLMAC2=5FPD=5FNOTIFICATION: =
0x1f
[    7.494373] iwlwifi 0000:00:14.3: WFPM=5FAUTH=5FKEY=5F0: 0x90
[    7.494432] iwlwifi 0000:00:14.3: CNVI=5FSCU=5FSEQ=5FDATA=5FDW9: 0x1=
0
[    7.495564] iwlwifi 0000:00:14.3: RFIm is deactivated, reason =3D 5
[    7.496285] typec port0: bound usb3-port2 (ops connector=5Fops)
[    7.496308] typec port0: bound usb2-port1 (ops connector=5Fops)
[    7.566748] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP,=
 with index: 0
[    7.652302] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[    7.676093] usbcore: registered new interface driver snd-usb-audio
[    7.691357] thunderbolt 0-0:1.1: NVM version 7.0
[    7.691363] thunderbolt 0-0:1.1: new retimer found, vendor=3D0x8087 =
device=3D0x15ee
[    7.692415] thunderbolt 0000:00:0d.2: current switch config:
[    7.692418] thunderbolt 0000:00:0d.2:  Thunderbolt 3 Switch: 8086:15=
ef (Revision: 6, TB Version: 16)
[    7.692422] thunderbolt 0000:00:0d.2:   Max Port Number: 13
[    7.692424] thunderbolt 0000:00:0d.2:   Config:
[    7.692425] thunderbolt 0000:00:0d.2:    Upstream Port Number: 1 Dep=
th: 1 Route String: 0x1 Enabled: 1, PlugEventsDelay: 254ms
[    7.692428] thunderbolt 0000:00:0d.2:    unknown1: 0x0 unknown4: 0x0
[    7.700953] thunderbolt 0000:00:0d.2: initializing Switch at 0x1 (de=
pth: 1, up port: 1)
[    7.731529] thunderbolt 0000:00:0d.2: 1: reading DROM (length: 0x6d)
[    7.751570] iwlwifi 0000:00:14.3: WFPM=5FUMAC=5FPD=5FNOTIFICATION: 0=
x20
[    7.751627] iwlwifi 0000:00:14.3: WFPM=5FLMAC2=5FPD=5FNOTIFICATION: =
0x1f
[    7.751688] iwlwifi 0000:00:14.3: WFPM=5FAUTH=5FKEY=5F0: 0x90
[    7.751748] iwlwifi 0000:00:14.3: CNVI=5FSCU=5FSEQ=5FDATA=5FDW9: 0x1=
0
[    7.752959] iwlwifi 0000:00:14.3: RFIm is deactivated, reason =3D 5
[    8.338834] thunderbolt 0000:00:0d.2: 1: DROM version: 1
[    8.340158] thunderbolt 0000:00:0d.2: 1: uid: 0x3d600630c86400
[    8.343223] thunderbolt 0000:00:0d.2:  Port 1: 8086:15ef (Revision: =
6, TB Version: 1, Type: Port (0x1))
[    8.343226] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/19
[    8.343228] thunderbolt 0000:00:0d.2:   Max counters: 16
[    8.343229] thunderbolt 0000:00:0d.2:   NFC Credits: 0x780000e
[    8.343231] thunderbolt 0000:00:0d.2:   Credits (total/control): 120=
/2
[    8.346836] thunderbolt 0000:00:0d.2:  Port 2: 8086:15ef (Revision: =
6, TB Version: 1, Type: Port (0x1))
[    8.346840] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/19
[    8.346841] thunderbolt 0000:00:0d.2:   Max counters: 16
[    8.346842] thunderbolt 0000:00:0d.2:   NFC Credits: 0x0
[    8.346843] thunderbolt 0000:00:0d.2:   Credits (total/control): 0/2
[    8.346844] thunderbolt 0000:00:0d.2: 1:3: disabled by eeprom
[    8.346845] thunderbolt 0000:00:0d.2: 1:4: disabled by eeprom
[    8.346846] thunderbolt 0000:00:0d.2: 1:5: disabled by eeprom
[    8.346847] thunderbolt 0000:00:0d.2: 1:6: disabled by eeprom
[    8.346848] thunderbolt 0000:00:0d.2: 1:7: disabled by eeprom
[    8.347100] thunderbolt 0000:00:0d.2:  Port 8: 8086:15ef (Revision: =
6, TB Version: 1, Type: PCIe (0x100102))
[    8.347102] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    8.347103] thunderbolt 0000:00:0d.2:   Max counters: 2
[    8.347104] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    8.347105] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    8.347365] thunderbolt 0000:00:0d.2:  Port 9: 8086:15ef (Revision: =
6, TB Version: 1, Type: PCIe (0x100101))
[    8.347367] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    8.347368] thunderbolt 0000:00:0d.2:   Max counters: 2
[    8.347369] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    8.347370] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    8.348426] thunderbolt 0000:00:0d.2:  Port 10: 8086:15ef (Revision:=
 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[    8.348428] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 9/9
[    8.348429] thunderbolt 0000:00:0d.2:   Max counters: 2
[    8.348429] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    8.348430] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    8.348959] thunderbolt 0000:00:0d.2:  Port 11: 8086:15ef (Revision:=
 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[    8.348962] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 9/9
[    8.348967] thunderbolt 0000:00:0d.2:   Max counters: 2
[    8.348969] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    8.348970] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    8.349777] thunderbolt 0000:00:0d.2:  Port 12: 8086:15ea (Revision:=
 6, TB Version: 1, Type: Inactive (0x0))
[    8.349780] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    8.349781] thunderbolt 0000:00:0d.2:   Max counters: 2
[    8.349782] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    8.349783] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    8.350047] thunderbolt 0000:00:0d.2:  Port 13: 8086:15ea (Revision:=
 6, TB Version: 1, Type: Inactive (0x0))
[    8.350049] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    8.350050] thunderbolt 0000:00:0d.2:   Max counters: 2
[    8.350051] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    8.350052] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    8.350312] thunderbolt 0000:00:0d.2: 1: current link speed 10.0 Gb/=
s
[    8.350314] thunderbolt 0000:00:0d.2: 1: current link width symmetri=
c, dual lanes
[    8.352974] thunderbolt 0000:00:0d.2: 1: CLx: current mode: disabled
[    8.358198] thunderbolt 0000:00:0d.2: 1: TMU: supports uni-direction=
al mode
[    8.358469] thunderbolt 0000:00:0d.2: 1: TMU: current mode: bi-direc=
tional, HiFi
[    8.358503] thunderbolt 0-1: new device found, vendor=3D0x3d device=3D=
0x18
[    8.358505] thunderbolt 0-1: CalDigit, Inc. USB-C Pro Dock
[    8.361074] thunderbolt 0000:00:0d.2: 1: NVM version 43.0
[    8.362313] thunderbolt 0000:00:0d.2: 1: discovery, not touching CL =
states
[    8.362977] thunderbolt 0000:00:0d.2: 0:3: is unplugged (state: 7)
[    8.363921] thunderbolt 0000:00:0d.2: discovering Video path startin=
g from 0:5
[    8.364055] thunderbolt 0000:00:0d.2: 0:5:  In HopID: 9 =3D> Out por=
t: 1 Out HopID: 11
[    8.364057] thunderbolt 0000:00:0d.2: 0:5:   Weight: 1 Priority: 1 C=
redits: 5 Drop: 0 PM: 0
[    8.364059] thunderbolt 0000:00:0d.2: 0:5:    Counter enabled: 0 Cou=
nter index: 0
[    8.364061] thunderbolt 0000:00:0d.2: 0:5:   Flow Control (In/Eg): 0=
/0 Shared Buffer (In/Eg): 0/0
[    8.364062] thunderbolt 0000:00:0d.2: 0:5:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.364189] thunderbolt 0000:00:0d.2: 1:1:  In HopID: 11 =3D> Out po=
rt: 11 Out HopID: 9
[    8.364190] thunderbolt 0000:00:0d.2: 1:1:   Weight: 1 Priority: 1 C=
redits: 26 Drop: 0 PM: 0
[    8.364192] thunderbolt 0000:00:0d.2: 1:1:    Counter enabled: 0 Cou=
nter index: 0
[    8.364194] thunderbolt 0000:00:0d.2: 1:1:   Flow Control (In/Eg): 0=
/0 Shared Buffer (In/Eg): 0/0
[    8.364195] thunderbolt 0000:00:0d.2: 1:1:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.364197] thunderbolt 0000:00:0d.2: path discovery complete
[    8.364454] thunderbolt 0000:00:0d.2: discovering AUX TX path starti=
ng from 0:5
[    8.365114] thunderbolt 0000:00:0d.2: 0:5:  In HopID: 8 =3D> Out por=
t: 1 Out HopID: 10
[    8.365115] thunderbolt 0000:00:0d.2: 0:5:   Weight: 1 Priority: 2 C=
redits: 4 Drop: 0 PM: 0
[    8.365117] thunderbolt 0000:00:0d.2: 0:5:    Counter enabled: 0 Cou=
nter index: 0
[    8.365118] thunderbolt 0000:00:0d.2: 0:5:   Flow Control (In/Eg): 1=
/1 Shared Buffer (In/Eg): 0/0
[    8.365120] thunderbolt 0000:00:0d.2: 0:5:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.365247] thunderbolt 0000:00:0d.2: 1:1:  In HopID: 10 =3D> Out po=
rt: 11 Out HopID: 8
[    8.365248] thunderbolt 0000:00:0d.2: 1:1:   Weight: 1 Priority: 2 C=
redits: 1 Drop: 0 PM: 0
[    8.365250] thunderbolt 0000:00:0d.2: 1:1:    Counter enabled: 0 Cou=
nter index: 0
[    8.365251] thunderbolt 0000:00:0d.2: 1:1:   Flow Control (In/Eg): 1=
/1 Shared Buffer (In/Eg): 0/0
[    8.365252] thunderbolt 0000:00:0d.2: 1:1:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.365254] thunderbolt 0000:00:0d.2: path discovery complete
[    8.365783] thunderbolt 0000:00:0d.2: discovering AUX RX path starti=
ng from 1:11
[    8.366480] thunderbolt 0000:00:0d.2: 1:11:  In HopID: 8 =3D> Out po=
rt: 1 Out HopID: 10
[    8.366491] thunderbolt 0000:00:0d.2: 1:11:   Weight: 1 Priority: 2 =
Credits: 4 Drop: 0 PM: 0
[    8.366501] thunderbolt 0000:00:0d.2: 1:11:    Counter enabled: 0 Co=
unter index: 0
[    8.366507] thunderbolt 0000:00:0d.2: 1:11:   Flow Control (In/Eg): =
1/1 Shared Buffer (In/Eg): 0/0
[    8.366509] thunderbolt 0000:00:0d.2: 1:11:   Unknown1: 0x0 Unknown2=
: 0x0 Unknown3: 0x0
[    8.366629] thunderbolt 0000:00:0d.2: 0:1:  In HopID: 10 =3D> Out po=
rt: 5 Out HopID: 8
[    8.366631] thunderbolt 0000:00:0d.2: 0:1:   Weight: 1 Priority: 2 C=
redits: 1 Drop: 0 PM: 0
[    8.366633] thunderbolt 0000:00:0d.2: 0:1:    Counter enabled: 0 Cou=
nter index: 0
[    8.366634] thunderbolt 0000:00:0d.2: 0:1:   Flow Control (In/Eg): 1=
/1 Shared Buffer (In/Eg): 0/0
[    8.366636] thunderbolt 0000:00:0d.2: 0:1:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.366637] thunderbolt 0000:00:0d.2: path discovery complete
[    8.367029] thunderbolt 0000:00:0d.2: 0:5 <-> 1:11 (DP): DP IN maxim=
um supported bandwidth 2700 Mb/s x4 =3D 8640 Mb/s
[    8.367159] thunderbolt 0000:00:0d.2: 0:5 <-> 1:11 (DP): DP OUT maxi=
mum supported bandwidth 5400 Mb/s x4 =3D 17280 Mb/s
[    8.367853] thunderbolt 0000:00:0d.2: 0:5 <-> 1:11 (DP): reduced ban=
dwidth 5400 Mb/s x4 =3D 17280 Mb/s
[    8.367856] thunderbolt 0000:00:0d.2: 0:5 <-> 1:11 (DP): discovered
[    8.368253] thunderbolt 0000:00:0d.2: discovering Video path startin=
g from 0:6
[    8.368387] thunderbolt 0000:00:0d.2: 0:6:  In HopID: 9 =3D> Out por=
t: 1 Out HopID: 13
[    8.368389] thunderbolt 0000:00:0d.2: 0:6:   Weight: 1 Priority: 1 C=
redits: 5 Drop: 0 PM: 0
[    8.368391] thunderbolt 0000:00:0d.2: 0:6:    Counter enabled: 0 Cou=
nter index: 0
[    8.368392] thunderbolt 0000:00:0d.2: 0:6:   Flow Control (In/Eg): 0=
/0 Shared Buffer (In/Eg): 0/0
[    8.368394] thunderbolt 0000:00:0d.2: 0:6:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.368520] thunderbolt 0000:00:0d.2: 1:1:  In HopID: 13 =3D> Out po=
rt: 10 Out HopID: 9
[    8.368522] thunderbolt 0000:00:0d.2: 1:1:   Weight: 1 Priority: 1 C=
redits: 26 Drop: 0 PM: 0
[    8.368523] thunderbolt 0000:00:0d.2: 1:1:    Counter enabled: 0 Cou=
nter index: 0
[    8.368525] thunderbolt 0000:00:0d.2: 1:1:   Flow Control (In/Eg): 0=
/0 Shared Buffer (In/Eg): 0/0
[    8.368526] thunderbolt 0000:00:0d.2: 1:1:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.368528] thunderbolt 0000:00:0d.2: path discovery complete
[    8.369314] thunderbolt 0000:00:0d.2: discovering AUX TX path starti=
ng from 0:6
[    8.369448] thunderbolt 0000:00:0d.2: 0:6:  In HopID: 8 =3D> Out por=
t: 1 Out HopID: 12
[    8.369450] thunderbolt 0000:00:0d.2: 0:6:   Weight: 1 Priority: 2 C=
redits: 4 Drop: 0 PM: 0
[    8.369452] thunderbolt 0000:00:0d.2: 0:6:    Counter enabled: 0 Cou=
nter index: 0
[    8.369453] thunderbolt 0000:00:0d.2: 0:6:   Flow Control (In/Eg): 1=
/1 Shared Buffer (In/Eg): 0/0
[    8.369455] thunderbolt 0000:00:0d.2: 0:6:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.369581] thunderbolt 0000:00:0d.2: 1:1:  In HopID: 12 =3D> Out po=
rt: 10 Out HopID: 8
[    8.369583] thunderbolt 0000:00:0d.2: 1:1:   Weight: 1 Priority: 2 C=
redits: 1 Drop: 0 PM: 0
[    8.369585] thunderbolt 0000:00:0d.2: 1:1:    Counter enabled: 0 Cou=
nter index: 0
[    8.369587] thunderbolt 0000:00:0d.2: 1:1:   Flow Control (In/Eg): 1=
/1 Shared Buffer (In/Eg): 0/0
[    8.369588] thunderbolt 0000:00:0d.2: 1:1:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.369590] thunderbolt 0000:00:0d.2: path discovery complete
[    8.370718] thunderbolt 0000:00:0d.2: discovering AUX RX path starti=
ng from 1:10
[    8.370883] thunderbolt 0000:00:0d.2: 1:10:  In HopID: 8 =3D> Out po=
rt: 1 Out HopID: 11
[    8.370888] thunderbolt 0000:00:0d.2: 1:10:   Weight: 1 Priority: 2 =
Credits: 4 Drop: 0 PM: 0
[    8.370891] thunderbolt 0000:00:0d.2: 1:10:    Counter enabled: 0 Co=
unter index: 0
[    8.370893] thunderbolt 0000:00:0d.2: 1:10:   Flow Control (In/Eg): =
1/1 Shared Buffer (In/Eg): 0/0
[    8.370895] thunderbolt 0000:00:0d.2: 1:10:   Unknown1: 0x0 Unknown2=
: 0x0 Unknown3: 0x0
[    8.371092] thunderbolt 0000:00:0d.2: 0:1:  In HopID: 11 =3D> Out po=
rt: 6 Out HopID: 8
[    8.371096] thunderbolt 0000:00:0d.2: 0:1:   Weight: 1 Priority: 2 C=
redits: 1 Drop: 0 PM: 0
[    8.371099] thunderbolt 0000:00:0d.2: 0:1:    Counter enabled: 0 Cou=
nter index: 0
[    8.371101] thunderbolt 0000:00:0d.2: 0:1:   Flow Control (In/Eg): 1=
/1 Shared Buffer (In/Eg): 0/0
[    8.371103] thunderbolt 0000:00:0d.2: 0:1:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.371105] thunderbolt 0000:00:0d.2: path discovery complete
[    8.371445] thunderbolt 0000:00:0d.2: 0:6 <-> 1:10 (DP): DP IN maxim=
um supported bandwidth 5400 Mb/s x4 =3D 17280 Mb/s
[    8.372109] thunderbolt 0000:00:0d.2: 0:6 <-> 1:10 (DP): DP OUT maxi=
mum supported bandwidth 5400 Mb/s x4 =3D 17280 Mb/s
[    8.372243] thunderbolt 0000:00:0d.2: 0:6 <-> 1:10 (DP): reduced ban=
dwidth 5400 Mb/s x4 =3D 17280 Mb/s
[    8.372244] thunderbolt 0000:00:0d.2: 0:6 <-> 1:10 (DP): discovered
[    8.372837] thunderbolt 0000:00:0d.2: discovering PCIe Up path start=
ing from 0:8
[    8.373560] thunderbolt 0000:00:0d.2: 0:8:  In HopID: 8 =3D> Out por=
t: 1 Out HopID: 8
[    8.373565] thunderbolt 0000:00:0d.2: 0:8:   Weight: 1 Priority: 3 C=
redits: 7 Drop: 0 PM: 0
[    8.373567] thunderbolt 0000:00:0d.2: 0:8:    Counter enabled: 0 Cou=
nter index: 0
[    8.373569] thunderbolt 0000:00:0d.2: 0:8:   Flow Control (In/Eg): 1=
/1 Shared Buffer (In/Eg): 0/0
[    8.373571] thunderbolt 0000:00:0d.2: 0:8:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.373679] thunderbolt 0000:00:0d.2: 1:1:  In HopID: 8 =3D> Out por=
t: 8 Out HopID: 8
[    8.373681] thunderbolt 0000:00:0d.2: 1:1:   Weight: 1 Priority: 3 C=
redits: 24 Drop: 0 PM: 0
[    8.373683] thunderbolt 0000:00:0d.2: 1:1:    Counter enabled: 0 Cou=
nter index: 0
[    8.373684] thunderbolt 0000:00:0d.2: 1:1:   Flow Control (In/Eg): 1=
/0 Shared Buffer (In/Eg): 0/0
[    8.373686] thunderbolt 0000:00:0d.2: 1:1:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.373688] thunderbolt 0000:00:0d.2: path discovery complete
[    8.374204] thunderbolt 0000:00:0d.2: discovering PCIe Down path sta=
rting from 1:8
[    8.374899] thunderbolt 0000:00:0d.2: 1:8:  In HopID: 8 =3D> Out por=
t: 1 Out HopID: 8
[    8.374901] thunderbolt 0000:00:0d.2: 1:8:   Weight: 1 Priority: 3 C=
redits: 7 Drop: 0 PM: 0
[    8.374902] thunderbolt 0000:00:0d.2: 1:8:    Counter enabled: 0 Cou=
nter index: 0
[    8.374903] thunderbolt 0000:00:0d.2: 1:8:   Flow Control (In/Eg): 1=
/1 Shared Buffer (In/Eg): 0/0
[    8.374905] thunderbolt 0000:00:0d.2: 1:8:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.375033] thunderbolt 0000:00:0d.2: 0:1:  In HopID: 8 =3D> Out por=
t: 8 Out HopID: 8
[    8.375034] thunderbolt 0000:00:0d.2: 0:1:   Weight: 1 Priority: 3 C=
redits: 24 Drop: 0 PM: 0
[    8.375035] thunderbolt 0000:00:0d.2: 0:1:    Counter enabled: 0 Cou=
nter index: 0
[    8.375037] thunderbolt 0000:00:0d.2: 0:1:   Flow Control (In/Eg): 1=
/0 Shared Buffer (In/Eg): 0/0
[    8.375038] thunderbolt 0000:00:0d.2: 0:1:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.375039] thunderbolt 0000:00:0d.2: path discovery complete
[    8.375166] thunderbolt 0000:00:0d.2: 0:8 <-> 1:8 (PCI): discovered
[    8.376373] thunderbolt 0000:00:0d.2: 0:5: attached to bandwidth gro=
up 1
[    8.376505] thunderbolt 0000:00:0d.2: 0:6: attached to bandwidth gro=
up 1
[    8.376507] thunderbolt 0000:00:0d.2: 1:11: DP OUT resource availabl=
e discovered
[    8.376508] thunderbolt 0000:00:0d.2: 1:10: DP OUT resource availabl=
e discovered
[    8.377958] thunderbolt 0000:00:0d.2: 0:5: DP IN resource available
[    8.379354] thunderbolt 0000:00:0d.2: 0:6: DP IN resource available
[    8.418502] Bluetooth: hci0: Waiting for firmware download to comple=
te
[    8.420059] Bluetooth: hci0: Firmware loaded in 1588251 usecs
[    8.420187] Bluetooth: hci0: Waiting for device to boot
[    8.435097] Bluetooth: hci0: Device booted in 14657 usecs
[    8.435174] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    8.435303] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0=
040-4150.ddc
[    8.438117] Bluetooth: hci0: Applying Intel DDC parameters completed
[    8.441183] Bluetooth: hci0: Firmware timestamp 2024.14 buildtype 1 =
build 81454
[    8.441187] Bluetooth: hci0: Firmware SHA1: 0xdfd62093
[    8.445141] Bluetooth: hci0: Fseq status: Success (0x00)
[    8.445145] Bluetooth: hci0: Fseq executed: 00.00.02.41
[    8.445146] Bluetooth: hci0: Fseq BT Top: 00.00.02.41
[    8.525756] Bluetooth: MGMT ver 1.22
[    8.530897] NET: Registered PF=5FALG protocol family
[    9.467447] Bluetooth: RFCOMM TTY layer initialized
[    9.467454] Bluetooth: RFCOMM socket layer initialized
[    9.467457] Bluetooth: RFCOMM ver 1.11
[   10.229343] r8152 6-1.4.4:1.0 enp5s0u1u4u4: carrier on
[   39.239566] ACPI BIOS Error (bug): Could not resolve symbol [^^^^NPC=
F.ACBT], AE=5FNOT=5FFOUND (20230628/psargs-330)
[   39.239800] ACPI Error: Aborting method \=5FSB.PC00.LPCB.EC0.=5FQ83 =
due to previous error (AE=5FNOT=5FFOUND) (20230628/psparse-529)


------=_=-_OpenGroupware_org_NGMime-97-1716217960.187497-2------
Content-Type: text/plain
Content-Disposition: attachment; filename="dmesg_tb_dbg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Length: 133582

[    0.000000] Linux version 6.9.1-arch1-1 (linux@archlinux) (gcc (GCC)=
 14.1.1 20240507, GNU ld (GNU Binutils) 2.42.0) #1 SMP PREEMPT=5FDYNAMI=
C Fri, 17 May 2024 16:56:38 +0000
[    0.000000] Command line: initrd=3D\initramfs-linux.img root=3DLABEL=
=3Darch rw resume=3Dswap thunderbolt.dyndbg=3D+p
[    0.000000] x86/split lock detection: #AC: crashing the kernel on ke=
rnel split=5Flocks and warning on user-space split=5Flocks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] u=
sable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] u=
sable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003f7b2fff] u=
sable
[    0.000000] BIOS-e820: [mem 0x000000003f7b3000-0x0000000042f55fff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000042f56000-0x0000000043041fff] A=
CPI data
[    0.000000] BIOS-e820: [mem 0x0000000043042000-0x0000000043170fff] A=
CPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000043171000-0x0000000043efefff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000043eff000-0x0000000043efffff] u=
sable
[    0.000000] BIOS-e820: [mem 0x0000000043f00000-0x0000000049ffffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x000000004a200000-0x000000004a3fffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x000000004b000000-0x00000000503fffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] r=
eserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000008afbfffff] u=
sable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.8 by American Megatrends
[    0.000000] efi: ACPI=3D0x430cc000 ACPI 2.0=3D0x430cc014 SMBIOS=3D0x=
43c0f000 SMBIOS 3.0=3D0x43c0e000 MEMATTR=3D0x3b7ba018 ESRT=3D0x3bf08098=
 INITRD=3D0x38a09b98 RNG=3D0x42f85018=20
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem73: MMIO range=3D[0xc0000000-0xcfffffff] =
(256MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] efi: Not removing mem74: MMIO range=3D[0xfe000000-0xfe01=
0fff] (68KB) from e820 map
[    0.000000] efi: Not removing mem75: MMIO range=3D[0xfec00000-0xfec0=
0fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem76: MMIO range=3D[0xfed00000-0xfed0=
0fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem78: MMIO range=3D[0xfee00000-0xfee0=
0fff] (4KB) from e820 map
[    0.000000] efi: Remove mem79: MMIO range=3D[0xff000000-0xffffffff] =
(16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.4.0 present.
[    0.000000] DMI: TUXEDO TUXEDO InfinityBook Pro Gen7 (MK1)/PHxARX1=5F=
PHxAQF1, BIOS N.1.05A07 11/07/2022
[    0.000000] tsc: Detected 2700.000 MHz processor
[    0.000000] tsc: Detected 2688.000 MHz TSC
[    0.000376] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> =
reserved
[    0.000378] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000384] last=5Fpfn =3D 0x8afc00 max=5Farch=5Fpfn =3D 0x400000000
[    0.000387] MTRR map: 5 entries (3 fixed + 2 variable; max 23), buil=
t from 10 variable MTRRs
[    0.000390] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC=
- WT =20
[    0.000761] last=5Fpfn =3D 0x43f00 max=5Farch=5Fpfn =3D 0x400000000
[    0.013111] esrt: Reserving ESRT space from 0x000000003bf08098 to 0x=
000000003bf08170.
[    0.013114] e820: update [mem 0x3bf08000-0x3bf08fff] usable =3D=3D> =
reserved
[    0.013124] Using GB pages for direct mapping
[    0.013125] Incomplete global flushes, disabling PCID
[    0.013233] Secure boot disabled
[    0.013233] RAMDISK: [mem 0x32aff000-0x33afdfff]
[    0.013260] ACPI: Early table checksum verification disabled
[    0.013262] ACPI: RSDP 0x00000000430CC014 000024 (v02 ALASKA)
[    0.013265] ACPI: XSDT 0x00000000430CB728 000104 (v01 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.013268] ACPI: FACP 0x000000004303F000 000114 (v06 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.013271] ACPI: DSDT 0x0000000042FC6000 078134 (v02 ALASKA A M I  =
  01072009 INTL 20200717)
[    0.013273] ACPI: FACS 0x000000004316F000 000040
[    0.013275] ACPI: FIDT 0x0000000042FC5000 00009C (v01 ALASKA A M I  =
  01072009 AMI  00010013)
[    0.013277] ACPI: SSDT 0x0000000043041000 00038C (v02 PmaxDv Pmax=5F=
Dev 00000001 INTL 20200717)
[    0.013279] ACPI: SSDT 0x0000000042FBF000 005D0B (v02 CpuRef CpuSsdt=
  00003000 INTL 20200717)
[    0.013281] ACPI: SSDT 0x0000000042FBC000 002AA1 (v02 SaSsdt SaSsdt =
  00003000 INTL 20200717)
[    0.013283] ACPI: SSDT 0x0000000042FB8000 0033D3 (v02 INTEL  IgfxSsd=
t 00003000 INTL 20200717)
[    0.013284] ACPI: SSDT 0x0000000042FAA000 00D337 (v02 INTEL  TcssSsd=
t 00001000 INTL 20200717)
[    0.013286] ACPI: HPET 0x0000000043040000 000038 (v01 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.013288] ACPI: APIC 0x0000000042FA9000 0001DC (v05 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.013290] ACPI: MCFG 0x0000000042FA8000 00003C (v01 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.013291] ACPI: SSDT 0x0000000042FA1000 00669F (v02 ALASKA AdlP=5F=
Rvp 00001000 INTL 20200717)
[    0.013293] ACPI: SSDT 0x0000000042F9F000 001E89 (v02 ALASKA Ther=5F=
Rvp 00001000 INTL 20200717)
[    0.013295] ACPI: UEFI 0x00000000430B1000 000048 (v01 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.013296] ACPI: NHLT 0x0000000042F9E000 00002D (v00 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.013298] ACPI: LPIT 0x0000000042F9D000 0000CC (v01 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.013300] ACPI: SSDT 0x0000000042F99000 002A83 (v02 ALASKA PtidDev=
c 00001000 INTL 20200717)
[    0.013302] ACPI: SSDT 0x0000000042F96000 002357 (v02 ALASKA TbtType=
C 00000000 INTL 20200717)
[    0.013304] ACPI: DBGP 0x0000000042F95000 000034 (v01 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.013305] ACPI: DBG2 0x0000000042F94000 000054 (v00 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.013307] ACPI: SSDT 0x0000000042F92000 0014F5 (v02 ALASKA UsbCTab=
l 00001000 INTL 20200717)
[    0.013309] ACPI: DMAR 0x0000000042F91000 000088 (v02 INTEL  EDK2   =
  00000002      01000013)
[    0.013311] ACPI: SSDT 0x0000000042F90000 000CAA (v02 INTEL  xh=5Fad=
lLP 00000000 INTL 20200717)
[    0.013312] ACPI: SSDT 0x0000000042F8C000 003AEA (v02 SocGpe SocGpe =
  00003000 INTL 20200717)
[    0.013314] ACPI: SSDT 0x0000000042F89000 002B2A (v02 SocCmn SocCmn =
  00003000 INTL 20200717)
[    0.013316] ACPI: BGRT 0x0000000042F88000 000038 (v01 ALASKA A M I  =
  01072009 AMI  00010013)
[    0.013318] ACPI: PHAT 0x0000000042F87000 000611 (v00 ALASKA A M I  =
  00000005 MSFT 0100000D)
[    0.013319] ACPI: WSMT 0x0000000042F9C000 000028 (v01 ALASKA A M I  =
  01072009 AMI  00010013)
[    0.013321] ACPI: FPDT 0x0000000042F86000 000044 (v01 ALASKA A M I  =
  01072009 AMI  01000013)
[    0.013323] ACPI: Reserving FACP table memory at [mem 0x4303f000-0x4=
303f113]
[    0.013324] ACPI: Reserving DSDT table memory at [mem 0x42fc6000-0x4=
303e133]
[    0.013324] ACPI: Reserving FACS table memory at [mem 0x4316f000-0x4=
316f03f]
[    0.013325] ACPI: Reserving FIDT table memory at [mem 0x42fc5000-0x4=
2fc509b]
[    0.013325] ACPI: Reserving SSDT table memory at [mem 0x43041000-0x4=
304138b]
[    0.013326] ACPI: Reserving SSDT table memory at [mem 0x42fbf000-0x4=
2fc4d0a]
[    0.013326] ACPI: Reserving SSDT table memory at [mem 0x42fbc000-0x4=
2fbeaa0]
[    0.013327] ACPI: Reserving SSDT table memory at [mem 0x42fb8000-0x4=
2fbb3d2]
[    0.013327] ACPI: Reserving SSDT table memory at [mem 0x42faa000-0x4=
2fb7336]
[    0.013328] ACPI: Reserving HPET table memory at [mem 0x43040000-0x4=
3040037]
[    0.013328] ACPI: Reserving APIC table memory at [mem 0x42fa9000-0x4=
2fa91db]
[    0.013329] ACPI: Reserving MCFG table memory at [mem 0x42fa8000-0x4=
2fa803b]
[    0.013329] ACPI: Reserving SSDT table memory at [mem 0x42fa1000-0x4=
2fa769e]
[    0.013330] ACPI: Reserving SSDT table memory at [mem 0x42f9f000-0x4=
2fa0e88]
[    0.013330] ACPI: Reserving UEFI table memory at [mem 0x430b1000-0x4=
30b1047]
[    0.013331] ACPI: Reserving NHLT table memory at [mem 0x42f9e000-0x4=
2f9e02c]
[    0.013331] ACPI: Reserving LPIT table memory at [mem 0x42f9d000-0x4=
2f9d0cb]
[    0.013331] ACPI: Reserving SSDT table memory at [mem 0x42f99000-0x4=
2f9ba82]
[    0.013332] ACPI: Reserving SSDT table memory at [mem 0x42f96000-0x4=
2f98356]
[    0.013332] ACPI: Reserving DBGP table memory at [mem 0x42f95000-0x4=
2f95033]
[    0.013333] ACPI: Reserving DBG2 table memory at [mem 0x42f94000-0x4=
2f94053]
[    0.013333] ACPI: Reserving SSDT table memory at [mem 0x42f92000-0x4=
2f934f4]
[    0.013334] ACPI: Reserving DMAR table memory at [mem 0x42f91000-0x4=
2f91087]
[    0.013334] ACPI: Reserving SSDT table memory at [mem 0x42f90000-0x4=
2f90ca9]
[    0.013335] ACPI: Reserving SSDT table memory at [mem 0x42f8c000-0x4=
2f8fae9]
[    0.013335] ACPI: Reserving SSDT table memory at [mem 0x42f89000-0x4=
2f8bb29]
[    0.013336] ACPI: Reserving BGRT table memory at [mem 0x42f88000-0x4=
2f88037]
[    0.013336] ACPI: Reserving PHAT table memory at [mem 0x42f87000-0x4=
2f87610]
[    0.013337] ACPI: Reserving WSMT table memory at [mem 0x42f9c000-0x4=
2f9c027]
[    0.013337] ACPI: Reserving FPDT table memory at [mem 0x42f86000-0x4=
2f86043]
[    0.013716] No NUMA configuration found
[    0.013716] Faking a node at [mem 0x0000000000000000-0x00000008afbff=
fff]
[    0.013718] NODE=5FDATA(0) allocated [mem 0x8afbfa000-0x8afbfefff]
[    0.013743] Zone ranges:
[    0.013744]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.013745]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.013746]   Normal   [mem 0x0000000100000000-0x00000008afbfffff]
[    0.013747]   Device   empty
[    0.013747] Movable zone start for each node
[    0.013748] Early memory node ranges
[    0.013748]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.013749]   node   0: [mem 0x000000000009f000-0x000000000009ffff]
[    0.013749]   node   0: [mem 0x0000000000100000-0x000000003f7b2fff]
[    0.013750]   node   0: [mem 0x0000000043eff000-0x0000000043efffff]
[    0.013750]   node   0: [mem 0x0000000100000000-0x00000008afbfffff]
[    0.013753] Initmem setup node 0 [mem 0x0000000000001000-0x00000008a=
fbfffff]
[    0.013755] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.013756] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.013772] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.014945] On node 0, zone DMA32: 18252 pages in unavailable ranges
[    0.049947] On node 0, zone Normal: 16640 pages in unavailable range=
s
[    0.049954] On node 0, zone Normal: 1024 pages in unavailable ranges
[    0.049986] Reserving Intel graphics memory at [mem 0x4c800000-0x503=
fffff]
[    0.050886] ACPI: PM-Timer IO Port: 0x1808
[    0.050892] ACPI: LAPIC=5FNMI (acpi=5Fid[0x01] high edge lint[0x1])
[    0.050894] ACPI: LAPIC=5FNMI (acpi=5Fid[0x02] high edge lint[0x1])
[    0.050894] ACPI: LAPIC=5FNMI (acpi=5Fid[0x03] high edge lint[0x1])
[    0.050894] ACPI: LAPIC=5FNMI (acpi=5Fid[0x04] high edge lint[0x1])
[    0.050895] ACPI: LAPIC=5FNMI (acpi=5Fid[0x05] high edge lint[0x1])
[    0.050895] ACPI: LAPIC=5FNMI (acpi=5Fid[0x06] high edge lint[0x1])
[    0.050896] ACPI: LAPIC=5FNMI (acpi=5Fid[0x07] high edge lint[0x1])
[    0.050896] ACPI: LAPIC=5FNMI (acpi=5Fid[0x08] high edge lint[0x1])
[    0.050896] ACPI: LAPIC=5FNMI (acpi=5Fid[0x09] high edge lint[0x1])
[    0.050897] ACPI: LAPIC=5FNMI (acpi=5Fid[0x0a] high edge lint[0x1])
[    0.050897] ACPI: LAPIC=5FNMI (acpi=5Fid[0x0b] high edge lint[0x1])
[    0.050897] ACPI: LAPIC=5FNMI (acpi=5Fid[0x0c] high edge lint[0x1])
[    0.050898] ACPI: LAPIC=5FNMI (acpi=5Fid[0x0d] high edge lint[0x1])
[    0.050898] ACPI: LAPIC=5FNMI (acpi=5Fid[0x0e] high edge lint[0x1])
[    0.050898] ACPI: LAPIC=5FNMI (acpi=5Fid[0x0f] high edge lint[0x1])
[    0.050899] ACPI: LAPIC=5FNMI (acpi=5Fid[0x10] high edge lint[0x1])
[    0.050899] ACPI: LAPIC=5FNMI (acpi=5Fid[0x11] high edge lint[0x1])
[    0.050900] ACPI: LAPIC=5FNMI (acpi=5Fid[0x12] high edge lint[0x1])
[    0.050900] ACPI: LAPIC=5FNMI (acpi=5Fid[0x13] high edge lint[0x1])
[    0.050900] ACPI: LAPIC=5FNMI (acpi=5Fid[0x14] high edge lint[0x1])
[    0.050901] ACPI: LAPIC=5FNMI (acpi=5Fid[0x15] high edge lint[0x1])
[    0.050901] ACPI: LAPIC=5FNMI (acpi=5Fid[0x16] high edge lint[0x1])
[    0.050902] ACPI: LAPIC=5FNMI (acpi=5Fid[0x17] high edge lint[0x1])
[    0.050902] ACPI: LAPIC=5FNMI (acpi=5Fid[0x00] high edge lint[0x1])
[    0.050984] IOAPIC[0]: apic=5Fid 2, version 32, address 0xfec00000, =
GSI 0-119
[    0.050986] ACPI: INT=5FSRC=5FOVR (bus 0 bus=5Firq 0 global=5Firq 2 =
dfl dfl)
[    0.050987] ACPI: INT=5FSRC=5FOVR (bus 0 bus=5Firq 9 global=5Firq 9 =
high level)
[    0.050989] ACPI: Using ACPI (MADT) for SMP configuration informatio=
n
[    0.050990] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.050995] e820: update [mem 0x38a23000-0x38a9efff] usable =3D=3D> =
reserved
[    0.051002] TSC deadline timer available
[    0.051004] CPU topo: Max. logical packages:   1
[    0.051004] CPU topo: Max. logical dies:       1
[    0.051005] CPU topo: Max. dies per package:   1
[    0.051006] CPU topo: Max. threads per core:   2
[    0.051007] CPU topo: Num. cores per package:    14
[    0.051007] CPU topo: Num. threads per package:  20
[    0.051008] CPU topo: Allowing 20 present CPUs plus 0 hotplug CPUs
[    0.051017] PM: hibernation: Registered nosave memory: [mem 0x000000=
00-0x00000fff]
[    0.051018] PM: hibernation: Registered nosave memory: [mem 0x0009e0=
00-0x0009efff]
[    0.051019] PM: hibernation: Registered nosave memory: [mem 0x000a00=
00-0x000fffff]
[    0.051020] PM: hibernation: Registered nosave memory: [mem 0x38a230=
00-0x38a9efff]
[    0.051021] PM: hibernation: Registered nosave memory: [mem 0x3bf080=
00-0x3bf08fff]
[    0.051022] PM: hibernation: Registered nosave memory: [mem 0x3f7b30=
00-0x42f55fff]
[    0.051022] PM: hibernation: Registered nosave memory: [mem 0x42f560=
00-0x43041fff]
[    0.051022] PM: hibernation: Registered nosave memory: [mem 0x430420=
00-0x43170fff]
[    0.051023] PM: hibernation: Registered nosave memory: [mem 0x431710=
00-0x43efefff]
[    0.051024] PM: hibernation: Registered nosave memory: [mem 0x43f000=
00-0x49ffffff]
[    0.051024] PM: hibernation: Registered nosave memory: [mem 0x4a0000=
00-0x4a1fffff]
[    0.051024] PM: hibernation: Registered nosave memory: [mem 0x4a2000=
00-0x4a3fffff]
[    0.051025] PM: hibernation: Registered nosave memory: [mem 0x4a4000=
00-0x4affffff]
[    0.051025] PM: hibernation: Registered nosave memory: [mem 0x4b0000=
00-0x503fffff]
[    0.051026] PM: hibernation: Registered nosave memory: [mem 0x504000=
00-0xfdffffff]
[    0.051026] PM: hibernation: Registered nosave memory: [mem 0xfe0000=
00-0xfe010fff]
[    0.051026] PM: hibernation: Registered nosave memory: [mem 0xfe0110=
00-0xfebfffff]
[    0.051027] PM: hibernation: Registered nosave memory: [mem 0xfec000=
00-0xfec00fff]
[    0.051027] PM: hibernation: Registered nosave memory: [mem 0xfec010=
00-0xfecfffff]
[    0.051027] PM: hibernation: Registered nosave memory: [mem 0xfed000=
00-0xfed00fff]
[    0.051028] PM: hibernation: Registered nosave memory: [mem 0xfed010=
00-0xfed1ffff]
[    0.051028] PM: hibernation: Registered nosave memory: [mem 0xfed200=
00-0xfed7ffff]
[    0.051028] PM: hibernation: Registered nosave memory: [mem 0xfed800=
00-0xfedfffff]
[    0.051029] PM: hibernation: Registered nosave memory: [mem 0xfee000=
00-0xfee00fff]
[    0.051029] PM: hibernation: Registered nosave memory: [mem 0xfee010=
00-0xffffffff]
[    0.051030] [mem 0x50400000-0xfdffffff] available for PCI devices
[    0.051031] Booting paravirtualized kernel on bare hardware
[    0.051032] clocksource: refined-jiffies: mask: 0xffffffff max=5Fcyc=
les: 0xffffffff, max=5Fidle=5Fns: 6370452778343963 ns
[    0.054966] setup=5Fpercpu: NR=5FCPUS:320 nr=5Fcpumask=5Fbits:20 nr=5F=
cpu=5Fids:20 nr=5Fnode=5Fids:1
[    0.055819] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u5242=
88
[    0.055823] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=3D1*20971=
52
[    0.055824] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07=20
[    0.055827] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15=20
[    0.055830] pcpu-alloc: [0] 16 17 18 19=20
[    0.055839] Kernel command line: initrd=3D\initramfs-linux.img root=3D=
LABEL=3Darch rw resume=3Dswap thunderbolt.dyndbg=3D+p
[    0.055874] printk: log=5Fbuf=5Flen individual max cpu contribution:=
 4096 bytes
[    0.055874] printk: log=5Fbuf=5Flen total cpu=5Fextra contributions:=
 77824 bytes
[    0.055875] printk: log=5Fbuf=5Flen min size: 131072 bytes
[    0.056004] printk: log=5Fbuf=5Flen: 262144 bytes
[    0.056005] printk: early log buf free: 115336(87%)
[    0.058085] Dentry cache hash table entries: 4194304 (order: 13, 335=
54432 bytes, linear)
[    0.059124] Inode-cache hash table entries: 2097152 (order: 12, 1677=
7216 bytes, linear)
[    0.059259] Fallback order for Node 0: 0=20
[    0.059262] Built 1 zonelists, mobility grouping on.  Total pages: 8=
189669
[    0.059263] Policy zone: Normal
[    0.059438] mem auto-init: stack:all(zero), heap alloc:on, heap free=
:off
[    0.059445] software IO TLB: area num 32.
[    0.108297] Memory: 32419976K/33279304K available (18432K kernel cod=
e, 2164K rwdata, 13276K rodata, 3408K init, 3636K bss, 859068K reserved=
, 0K cma-reserved)
[    0.108453] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
20, Nodes=3D1
[    0.108481] ftrace: allocating 49689 entries in 195 pages
[    0.112957] ftrace: allocated 195 pages with 4 groups
[    0.113008] Dynamic Preempt: full
[    0.113060] rcu: Preemptible hierarchical RCU implementation.
[    0.113061] rcu: 	RCU restricting CPUs from NR=5FCPUS=3D320 to nr=5F=
cpu=5Fids=3D20.
[    0.113061] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.113062] 	Trampoline variant of Tasks RCU enabled.
[    0.113063] 	Rude variant of Tasks RCU enabled.
[    0.113063] 	Tracing variant of Tasks RCU enabled.
[    0.113063] rcu: RCU calculated value of scheduler-enlistment delay =
is 30 jiffies.
[    0.113064] rcu: Adjusting geometry for rcu=5Ffanout=5Fleaf=3D16, nr=
=5Fcpu=5Fids=3D20
[    0.113071] RCU Tasks: Setting shift to 5 and lim to 1 rcu=5Ftask=5F=
cb=5Fadjust=3D1.
[    0.113073] RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu=5Fta=
sk=5Fcb=5Fadjust=3D1.
[    0.113074] RCU Tasks Trace: Setting shift to 5 and lim to 1 rcu=5Ft=
ask=5Fcb=5Fadjust=3D1.
[    0.115452] NR=5FIRQS: 20736, nr=5Firqs: 2216, preallocated irqs: 16
[    0.115798] rcu: srcu=5Finit: Setting srcu=5Fstruct sizes based on c=
ontention.
[    0.116238] kfence: initialized - using 2097152 bytes for 255 object=
s at 0x(=5F=5F=5F=5Fptrval=5F=5F=5F=5F)-0x(=5F=5F=5F=5Fptrval=5F=5F=5F=5F=
)
[    0.116265] Console: colour dummy device 80x25
[    0.116267] printk: legacy console [tty0] enabled
[    0.116296] ACPI: Core revision 20230628
[    0.116531] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.116532] APIC: Switch to symmetric I/O mode setup
[    0.116533] DMAR: Host address width 39
[    0.116533] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.116537] DMAR: dmar0: reg=5Fbase=5Faddr fed90000 ver 4:0 cap 1c00=
00c40660462 ecap 29a00f0505e
[    0.116538] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.116542] DMAR: dmar1: reg=5Fbase=5Faddr fed91000 ver 5:0 cap d200=
8c40660462 ecap f050da
[    0.116544] DMAR: RMRR base: 0x0000004c000000 end: 0x000000503fffff
[    0.116546] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.116547] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.116547] DMAR-IR: Queued invalidation will be enabled to support =
x2apic and Intr-remapping.
[    0.120467] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.120469] x2apic enabled
[    0.120535] APIC: Switched APIC routing to: cluster x2apic
[    0.131818] clocksource: tsc-early: mask: 0xffffffffffffffff max=5Fc=
ycles: 0x26bef67878b, max=5Fidle=5Fns: 440795293631 ns
[    0.131822] Calibrating delay loop (skipped), value calculated using=
 timer frequency.. 5378.00 BogoMIPS (lpj=3D8960000)
[    0.131868] CPU0: Thermal monitoring enabled (TM1)
[    0.131870] x86/cpu: User Mode Instruction Prevention (UMIP) activat=
ed
[    0.131968] CET detected: Indirect Branch Tracking enabled
[    0.131969] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.131970] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.131971] process: using mwait in idle threads
[    0.131973] Spectre V1 : Mitigation: usercopy/swapgs barriers and =5F=
=5Fuser pointer sanitization
[    0.131974] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on =
vm exit
[    0.131974] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on =
syscall
[    0.131975] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.131975] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling=
 RSB on context switch
[    0.131976] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single C=
ALL on VMEXIT
[    0.131977] Spectre V2 : mitigation: Enabling conditional Indirect B=
ranch Prediction Barrier
[    0.131977] Speculative Store Bypass: Mitigation: Speculative Store =
Bypass disabled via prctl
[    0.131978] Register File Data Sampling: Vulnerable: No microcode
[    0.131984] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating p=
oint registers'
[    0.131985] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.131986] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.131986] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Key=
s User registers'
[    0.131987] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow U=
ser registers'
[    0.131987] x86/fpu: xstate=5Foffset[2]:  576, xstate=5Fsizes[2]:  2=
56
[    0.131988] x86/fpu: xstate=5Foffset[9]:  832, xstate=5Fsizes[9]:   =
 8
[    0.131989] x86/fpu: xstate=5Foffset[11]:  840, xstate=5Fsizes[11]: =
  16
[    0.131989] x86/fpu: Enabled xstate features 0xa07, context size is =
856 bytes, using 'compacted' format.
[    0.135154] Freeing SMP alternatives memory: 40K
[    0.135154] pid=5Fmax: default: 32768 minimum: 301
[    0.135154] LSM: initializing lsm=3Dcapability,landlock,lockdown,yam=
a,bpf
[    0.135154] landlock: Up and running.
[    0.135154] Yama: becoming mindful.
[    0.135154] LSM support for eBPF active
[    0.135154] Mount-cache hash table entries: 65536 (order: 7, 524288 =
bytes, linear)
[    0.135154] Mountpoint-cache hash table entries: 65536 (order: 7, 52=
4288 bytes, linear)
[    0.135154] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-12700H (fam=
ily: 0x6, model: 0x9a, stepping: 0x3)
[    0.135154] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-=
baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, =
full-width counters, Intel PMU driver.
[    0.135154] core: cpu=5Fcore PMU driver:=20
[    0.135154] ... version:                5
[    0.135154] ... bit width:              48
[    0.135154] ... generic registers:      8
[    0.135154] ... value mask:             0000ffffffffffff
[    0.135154] ... max period:             00007fffffffffff
[    0.135154] ... fixed-purpose events:   4
[    0.135154] ... event mask:             0001000f000000ff
[    0.135154] signal: max sigframe size: 3632
[    0.135154] Estimated ratio of average max frequency by base frequen=
cy (times 1024): 1668
[    0.135154] rcu: Hierarchical SRCU implementation.
[    0.135154] rcu: 	Max phase no-delay instances is 1000.
[    0.135154] NMI watchdog: Enabled. Permanently consumes one hw-PMU c=
ounter.
[    0.135154] smp: Bringing up secondary CPUs ...
[    0.135154] smpboot: x86: Booting SMP configuration:
[    0.135154] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #13 #=
14 #15 #16 #17 #18 #19
[    0.018982] core: cpu=5Fatom PMU driver: PEBS-via-PT=20
[    0.018982] ... version:                5
[    0.018982] ... bit width:              48
[    0.018982] ... generic registers:      6
[    0.018982] ... value mask:             0000ffffffffffff
[    0.018982] ... max period:             00007fffffffffff
[    0.018982] ... fixed-purpose events:   3
[    0.018982] ... event mask:             000000070000003f
[    0.138587]   #1  #3  #5  #7  #9 #11
[    0.145227] smp: Brought up 1 node, 20 CPUs
[    0.145227] smpboot: Total of 20 processors activated (107563.00 Bog=
oMIPS)
[    0.149376] devtmpfs: initialized
[    0.149376] x86/mm: Memory block size: 128MB
[    0.149771] ACPI: PM: Registering ACPI NVS region [mem 0x43042000-0x=
43170fff] (1241088 bytes)
[    0.149771] clocksource: jiffies: mask: 0xffffffff max=5Fcycles: 0xf=
fffffff, max=5Fidle=5Fns: 6370867519511994 ns
[    0.149771] futex hash table entries: 8192 (order: 7, 524288 bytes, =
linear)
[    0.149771] pinctrl core: initialized pinctrl subsystem
[    0.149771] PM: RTC time: 14:48:36, date: 2024-05-20
[    0.149771] NET: Registered PF=5FNETLINK/PF=5FROUTE protocol family
[    0.152173] DMA: preallocated 4096 KiB GFP=5FKERNEL pool for atomic =
allocations
[    0.152397] DMA: preallocated 4096 KiB GFP=5FKERNEL|GFP=5FDMA pool f=
or atomic allocations
[    0.152651] DMA: preallocated 4096 KiB GFP=5FKERNEL|GFP=5FDMA32 pool=
 for atomic allocations
[    0.152655] audit: initializing netlink subsys (disabled)
[    0.152658] audit: type=3D2000 audit(1716216516.019:1): state=3Dinit=
ialized audit=5Fenabled=3D0 res=3D1
[    0.152658] thermal=5Fsys: Registered thermal governor 'fair=5Fshare=
'
[    0.152658] thermal=5Fsys: Registered thermal governor 'bang=5Fbang'
[    0.152658] thermal=5Fsys: Registered thermal governor 'step=5Fwise'
[    0.152658] thermal=5Fsys: Registered thermal governor 'user=5Fspace=
'
[    0.152658] thermal=5Fsys: Registered thermal governor 'power=5Fallo=
cator'
[    0.152658] cpuidle: using governor ladder
[    0.152658] cpuidle: using governor menu
[    0.152658] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.=
5
[    0.152658] PCI: ECAM [mem 0xc0000000-0xcfffffff] (base 0xc0000000) =
for domain 0000 [bus 00-ff]
[    0.152658] PCI: not using ECAM ([mem 0xc0000000-0xcfffffff] not res=
erved)
[    0.152658] PCI: Using configuration type 1 for base access
[    0.152658] kprobes: kprobe jump-optimization is enabled. All kprobe=
s are optimized if possible.
[    0.152658] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 =
pages
[    0.152658] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB p=
age
[    0.152658] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 =
pages
[    0.152658] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.152658] Demotion targets for Node 0: null
[    0.152658] ACPI: Added =5FOSI(Module Device)
[    0.152658] ACPI: Added =5FOSI(Processor Device)
[    0.152658] ACPI: Added =5FOSI(3.0 =5FSCP Extensions)
[    0.152658] ACPI: Added =5FOSI(Processor Aggregator Device)
[    0.236903] ACPI: 14 ACPI AML tables successfully acquired and loade=
d
[    0.253559] ACPI: USB4 =5FOSC: OS supports USB3+ DisplayPort+ PCIe+ =
XDomain+
[    0.253562] ACPI: USB4 =5FOSC: OS controls USB3+ DisplayPort+ PCIe+ =
XDomain+
[    0.255246] ACPI: Dynamic OEM Table Load:
[    0.255264] ACPI: SSDT 0xFFFF97F0017F5400 000394 (v02 PmRef  Cpu0Cst=
  00003001 INTL 20200717)
[    0.256538] ACPI: Dynamic OEM Table Load:
[    0.256543] ACPI: SSDT 0xFFFF97F0017EA000 000626 (v02 PmRef  Cpu0Ist=
  00003000 INTL 20200717)
[    0.257732] ACPI: Dynamic OEM Table Load:
[    0.257736] ACPI: SSDT 0xFFFF97F002834A00 0001AB (v02 PmRef  Cpu0Psd=
  00003000 INTL 20200717)
[    0.258935] ACPI: Dynamic OEM Table Load:
[    0.258939] ACPI: SSDT 0xFFFF97F0017EE000 0004BA (v02 PmRef  Cpu0Hwp=
  00003000 INTL 20200717)
[    0.260462] ACPI: Dynamic OEM Table Load:
[    0.260470] ACPI: SSDT 0xFFFF97F0017E4000 001BAF (v02 PmRef  ApIst  =
  00003000 INTL 20200717)
[    0.262495] ACPI: Dynamic OEM Table Load:
[    0.262501] ACPI: SSDT 0xFFFF97F0017E2000 001038 (v02 PmRef  ApHwp  =
  00003000 INTL 20200717)
[    0.264140] ACPI: Dynamic OEM Table Load:
[    0.264146] ACPI: SSDT 0xFFFF97F0017E6000 001349 (v02 PmRef  ApPsd  =
  00003000 INTL 20200717)
[    0.265984] ACPI: Dynamic OEM Table Load:
[    0.265990] ACPI: SSDT 0xFFFF97F0017FE000 000FBB (v02 PmRef  ApCst  =
  00003000 INTL 20200717)
[    0.274949] ACPI: =5FOSC evaluated successfully for all CPUs
[    0.275041] ACPI: EC: EC started
[    0.275042] ACPI: EC: interrupt blocked
[    0.276827] ACPI: EC: EC=5FCMD/EC=5FSC=3D0x66, EC=5FDATA=3D0x62
[    0.276830] ACPI: \=5FSB=5F.PC00.LPCB.EC0=5F: Boot DSDT EC used to h=
andle transactions
[    0.276831] ACPI: Interpreter enabled
[    0.276879] ACPI: PM: (supports S0 S3 S4 S5)
[    0.276880] ACPI: Using IOAPIC for interrupt routing
[    0.278291] PCI: ECAM [mem 0xc0000000-0xcfffffff] (base 0xc0000000) =
for domain 0000 [bus 00-ff]
[    0.280202] PCI: ECAM [mem 0xc0000000-0xcfffffff] reserved as ACPI m=
otherboard resource
[    0.280213] PCI: Using host bridge windows from ACPI; if necessary, =
use "pci=3Dnocrs" and report a bug
[    0.280214] PCI: Using E820 reservations for host bridge windows
[    0.281659] ACPI: Enabled 7 GPEs in block 00 to 7F
[    0.282788] ACPI: \=5FSB=5F.PC00.PEG1.PXP=5F: New power resource
[    0.283522] ACPI: \=5FSB=5F.PC00.PEG2.PXP=5F: New power resource
[    0.286107] ACPI: \=5FSB=5F.PC00.PEG0.PXP=5F: New power resource
[    0.291010] ACPI: \=5FSB=5F.PC00.RP05.PXP=5F: New power resource
[    0.299911] ACPI: \=5FSB=5F.PC00.XHCI.RHUB.HS10.BTRT: New power reso=
urce
[    0.311292] ACPI: \=5FSB=5F.PC00.CNVW.WRST: New power resource
[    0.319799] ACPI: \=5FSB=5F.PC00.TBT0: New power resource
[    0.319885] ACPI: \=5FSB=5F.PC00.TBT1: New power resource
[    0.319965] ACPI: \=5FSB=5F.PC00.D3C=5F: New power resource
[    0.449158] ACPI: \=5FTZ=5F.FN00: New power resource
[    0.449216] ACPI: \=5FTZ=5F.FN01: New power resource
[    0.449273] ACPI: \=5FTZ=5F.FN02: New power resource
[    0.449328] ACPI: \=5FTZ=5F.FN03: New power resource
[    0.449387] ACPI: \=5FTZ=5F.FN04: New power resource
[    0.449913] ACPI: \PIN=5F: New power resource
[    0.450223] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-fe])
[    0.450233] acpi PNP0A08:00: =5FOSC: OS supports [ExtendedConfig ASP=
M ClockPM Segments MSI EDR HPX-Type3]
[    0.452222] acpi PNP0A08:00: =5FOSC: platform does not support [AER]
[    0.456151] acpi PNP0A08:00: =5FOSC: OS now controls [PCIeHotplug SH=
PCHotplug PME PCIeCapability LTR DPC]
[    0.458636] PCI host bridge to bus 0000:00
[    0.458638] pci=5Fbus 0000:00: root bus resource [io  0x0000-0x0cf7 =
window]
[    0.458640] pci=5Fbus 0000:00: root bus resource [io  0x0d00-0xffff =
window]
[    0.458641] pci=5Fbus 0000:00: root bus resource [mem 0x000a0000-0x0=
00bffff window]
[    0.458643] pci=5Fbus 0000:00: root bus resource [mem 0x000e0000-0x0=
00fffff window]
[    0.458644] pci=5Fbus 0000:00: root bus resource [mem 0x50400000-0xb=
fffffff window]
[    0.458646] pci=5Fbus 0000:00: root bus resource [mem 0x4000000000-0=
x7fffffffff window]
[    0.458647] pci=5Fbus 0000:00: root bus resource [bus 00-fe]
[    0.575919] pci 0000:00:00.0: [8086:4641] type 00 class 0x060000 con=
ventional PCI endpoint
[    0.576123] pci 0000:00:02.0: [8086:46a6] type 00 class 0x030000 PCI=
e Root Complex Integrated Endpoint
[    0.576130] pci 0000:00:02.0: BAR 0 [mem 0x601c000000-0x601cffffff 6=
4bit]
[    0.576135] pci 0000:00:02.0: BAR 2 [mem 0x4000000000-0x400fffffff 6=
4bit pref]
[    0.576139] pci 0000:00:02.0: BAR 4 [io  0x3000-0x303f]
[    0.576153] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphic=
s
[    0.576156] pci 0000:00:02.0: Video device with shadowed ROM at [mem=
 0x000c0000-0x000dffff]
[    0.576177] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x00ffffff 64=
bit]
[    0.576178] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x06ffffff 64=
bit]: contains BAR 0 for 7 VFs
[    0.576183] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64=
bit pref]
[    0.576184] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64=
bit pref]: contains BAR 2 for 7 VFs
[    0.576325] pci 0000:00:04.0: [8086:461d] type 00 class 0x118000 con=
ventional PCI endpoint
[    0.576337] pci 0000:00:04.0: BAR 0 [mem 0x601d140000-0x601d15ffff 6=
4bit]
[    0.576701] pci 0000:00:06.0: [8086:464d] type 01 class 0x060400 PCI=
e Root Port
[    0.576747] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.576832] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.576883] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    0.577601] pci 0000:00:06.2: [8086:463d] type 01 class 0x060400 PCI=
e Root Port
[    0.577644] pci 0000:00:06.2: PCI bridge to [bus 02]
[    0.577651] pci 0000:00:06.2:   bridge window [mem 0x5e300000-0x5e3f=
ffff]
[    0.577741] pci 0000:00:06.2: PME# supported from D0 D3hot D3cold
[    0.577789] pci 0000:00:06.2: PTM enabled (root), 4ns granularity
[    0.578505] pci 0000:00:07.0: [8086:466e] type 01 class 0x060400 PCI=
e Root Port
[    0.578526] pci 0000:00:07.0: PCI bridge to [bus 03-2c]
[    0.578531] pci 0000:00:07.0:   bridge window [mem 0x52000000-0x5e1f=
ffff]
[    0.578538] pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x60=
1bffffff 64bit pref]
[    0.578564] pci 0000:00:07.0: Overriding RP PIO Log Size to 4
[    0.578653] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.578676] pci 0000:00:07.0: PTM enabled (root), 4ns granularity
[    0.579748] pci 0000:00:08.0: [8086:464f] type 00 class 0x088000 con=
ventional PCI endpoint
[    0.579757] pci 0000:00:08.0: BAR 0 [mem 0x601d199000-0x601d199fff 6=
4bit]
[    0.579851] pci 0000:00:0a.0: [8086:467d] type 00 class 0x118000 PCI=
e Root Complex Integrated Endpoint
[    0.579857] pci 0000:00:0a.0: BAR 0 [mem 0x601d180000-0x601d187fff 6=
4bit]
[    0.579874] pci 0000:00:0a.0: enabling Extended Tags
[    0.579978] pci 0000:00:0d.0: [8086:461e] type 00 class 0x0c0330 con=
ventional PCI endpoint
[    0.579988] pci 0000:00:0d.0: BAR 0 [mem 0x601d170000-0x601d17ffff 6=
4bit]
[    0.580027] pci 0000:00:0d.0: PME# supported from D3hot D3cold
[    0.580604] pci 0000:00:0d.2: [8086:463e] type 00 class 0x0c0340 con=
ventional PCI endpoint
[    0.580613] pci 0000:00:0d.2: BAR 0 [mem 0x601d100000-0x601d13ffff 6=
4bit]
[    0.580620] pci 0000:00:0d.2: BAR 2 [mem 0x601d198000-0x601d198fff 6=
4bit]
[    0.580649] pci 0000:00:0d.2: supports D1 D2
[    0.580650] pci 0000:00:0d.2: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.580944] pci 0000:00:14.0: [8086:51ed] type 00 class 0x0c0330 con=
ventional PCI endpoint
[    0.580968] pci 0000:00:14.0: BAR 0 [mem 0x601d160000-0x601d16ffff 6=
4bit]
[    0.581066] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.581683] pci 0000:00:14.2: [8086:51ef] type 00 class 0x050000 con=
ventional PCI endpoint
[    0.581711] pci 0000:00:14.2: BAR 0 [mem 0x601d190000-0x601d193fff 6=
4bit]
[    0.581731] pci 0000:00:14.2: BAR 2 [mem 0x601d197000-0x601d197fff 6=
4bit]
[    0.582018] pci 0000:00:14.3: [8086:51f0] type 00 class 0x028000 PCI=
e Root Complex Integrated Endpoint
[    0.582082] pci 0000:00:14.3: BAR 0 [mem 0x601d18c000-0x601d18ffff 6=
4bit]
[    0.582228] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.583080] pci 0000:00:15.0: [8086:51e8] type 00 class 0x0c8000 con=
ventional PCI endpoint
[    0.583812] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit=
]
[    0.587201] pci 0000:00:1f.0: [8086:5182] type 00 class 0x060100 con=
ventional PCI endpoint
[    0.587606] pci 0000:00:1f.3: [8086:51c8] type 00 class 0x040380 con=
ventional PCI endpoint
[    0.587666] pci 0000:00:1f.3: BAR 0 [mem 0x601d188000-0x601d18bfff 6=
4bit]
[    0.587736] pci 0000:00:1f.3: BAR 4 [mem 0x601d000000-0x601d0fffff 6=
4bit]
[    0.587896] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.588575] pci 0000:00:1f.4: [8086:51a3] type 00 class 0x0c0500 con=
ventional PCI endpoint
[    0.588620] pci 0000:00:1f.4: BAR 0 [mem 0x601d194000-0x601d1940ff 6=
4bit]
[    0.588663] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.588982] pci 0000:00:1f.5: [8086:51a4] type 00 class 0x0c8000 con=
ventional PCI endpoint
[    0.589003] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.589244] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.590066] pci 0000:02:00.0: [144d:a80a] type 00 class 0x010802 PCI=
e Endpoint
[    0.590080] pci 0000:02:00.0: BAR 0 [mem 0x5e300000-0x5e303fff 64bit=
]
[    0.590311] pci 0000:00:06.2: PCI bridge to [bus 02]
[    0.590380] pci 0000:03:00.0: [8086:15ef] type 01 class 0x060400 PCI=
e Switch Upstream Port
[    0.590433] pci 0000:03:00.0: PCI bridge to [bus 04-05]
[    0.590448] pci 0000:03:00.0:   bridge window [mem 0x52000000-0x520f=
ffff]
[    0.590484] pci 0000:03:00.0: enabling Extended Tags
[    0.590662] pci 0000:03:00.0: supports D1 D2
[    0.590663] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.590826] pci 0000:03:00.0: PTM enabled, 4ns granularity
[    0.590874] pci 0000:03:00.0: 8.000 Gb/s available PCIe bandwidth, l=
imited by 2.5 GT/s PCIe x4 link at 0000:00:07.0 (capable of 31.504 Gb/s=
 with 8.0 GT/s PCIe x4 link)
[    0.598504] pci 0000:00:07.0: PCI bridge to [bus 03-2c]
[    0.598641] pci 0000:04:02.0: [8086:15ef] type 01 class 0x060400 PCI=
e Switch Downstream Port
[    0.598699] pci 0000:04:02.0: PCI bridge to [bus 05]
[    0.598715] pci 0000:04:02.0:   bridge window [mem 0x52000000-0x520f=
ffff]
[    0.598755] pci 0000:04:02.0: enabling Extended Tags
[    0.598928] pci 0000:04:02.0: supports D1 D2
[    0.598929] pci 0000:04:02.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.599250] pci 0000:03:00.0: PCI bridge to [bus 04-05]
[    0.599371] pci 0000:05:00.0: [8086:15f0] type 00 class 0x0c0330 PCI=
e Endpoint
[    0.599402] pci 0000:05:00.0: BAR 0 [mem 0x52000000-0x5200ffff]
[    0.599513] pci 0000:05:00.0: enabling Extended Tags
[    0.599703] pci 0000:05:00.0: supports D1 D2
[    0.599704] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.599884] pci 0000:05:00.0: 8.000 Gb/s available PCIe bandwidth, l=
imited by 2.5 GT/s PCIe x4 link at 0000:00:07.0 (capable of 31.504 Gb/s=
 with 8.0 GT/s PCIe x4 link)
[    0.600073] pci 0000:04:02.0: PCI bridge to [bus 05]
[    0.604070] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.604174] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.604276] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.604378] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.604480] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.604581] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.604682] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.604783] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    1.127903] Low-power S0 idle used by default for system suspend
[    1.137567] ACPI: EC: interrupt unblocked
[    1.137568] ACPI: EC: event unblocked
[    1.137595] ACPI: EC: EC=5FCMD/EC=5FSC=3D0x66, EC=5FDATA=3D0x62
[    1.137596] ACPI: EC: GPE=3D0x6e
[    1.137597] ACPI: \=5FSB=5F.PC00.LPCB.EC0=5F: Boot DSDT EC initializ=
ation complete
[    1.137598] ACPI: \=5FSB=5F.PC00.LPCB.EC0=5F: EC: Used to handle tra=
nsactions and events
[    1.138526] iommu: Default domain type: Translated
[    1.138526] iommu: DMA domain TLB invalidation policy: lazy mode
[    1.138649] SCSI subsystem initialized
[    1.138657] libata version 3.00 loaded.
[    1.138657] ACPI: bus type USB registered
[    1.138657] usbcore: registered new interface driver usbfs
[    1.138657] usbcore: registered new interface driver hub
[    1.138657] usbcore: registered new device driver usb
[    1.138657] EDAC MC: Ver: 3.0.0
[    1.141931] efivars: Registered efivars operations
[    1.142157] NetLabel: Initializing
[    1.142159] NetLabel:  domain hash size =3D 128
[    1.142161] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    1.142189] NetLabel:  unlabeled traffic allowed by default
[    1.142196] mctp: management component transport protocol core
[    1.142198] NET: Registered PF=5FMCTP protocol family
[    1.142203] PCI: Using ACPI for IRQ routing
[    1.236450] PCI: pci=5Fcache=5Fline=5Fsize set to 64 bytes
[    1.237361] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can=
't claim; no compatible bridge window
[    1.238282] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    1.238283] e820: reserve RAM buffer [mem 0x38a23000-0x3bffffff]
[    1.238284] e820: reserve RAM buffer [mem 0x3bf08000-0x3bffffff]
[    1.238285] e820: reserve RAM buffer [mem 0x3f7b3000-0x3fffffff]
[    1.238286] e820: reserve RAM buffer [mem 0x43f00000-0x43ffffff]
[    1.238287] e820: reserve RAM buffer [mem 0x8afc00000-0x8afffffff]
[    1.238584] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.238584] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.238584] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio=
+mem,owns=3Dio+mem,locks=3Dnone
[    1.238584] vgaarb: loaded
[    1.238586] clocksource: Switched to clocksource tsc-early
[    1.239042] VFS: Disk quotas dquot=5F6.6.0
[    1.239054] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 =
bytes)
[    1.239119] pnp: PnP ACPI init
[    1.240230] system 00:01: [io  0x0680-0x069f] has been reserved
[    1.240232] system 00:01: [io  0x164e-0x164f] has been reserved
[    1.240352] system 00:02: [io  0x1854-0x1857] has been reserved
[    1.241424] pnp 00:03: disabling [mem 0xc0000000-0xcfffffff] because=
 it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    1.241447] system 00:03: [mem 0xfedc0000-0xfedc7fff] has been reser=
ved
[    1.241449] system 00:03: [mem 0xfeda0000-0xfeda0fff] has been reser=
ved
[    1.241450] system 00:03: [mem 0xfeda1000-0xfeda1fff] has been reser=
ved
[    1.241452] system 00:03: [mem 0xfed20000-0xfed7ffff] has been reser=
ved
[    1.241453] system 00:03: [mem 0xfed90000-0xfed93fff] could not be r=
eserved
[    1.241454] system 00:03: [mem 0xfed45000-0xfed8ffff] could not be r=
eserved
[    1.241456] system 00:03: [mem 0xfee00000-0xfeefffff] could not be r=
eserved
[    1.243049] system 00:04: [io  0x2000-0x20fe] has been reserved
[    1.244514] pnp: PnP ACPI: found 6 devices
[    1.250212] clocksource: acpi=5Fpm: mask: 0xffffff max=5Fcycles: 0xf=
fffff, max=5Fidle=5Fns: 2085701024 ns
[    1.250342] NET: Registered PF=5FINET protocol family
[    1.250540] IP idents hash table entries: 262144 (order: 9, 2097152 =
bytes, linear)
[    1.262514] tcp=5Flisten=5Fportaddr=5Fhash hash table entries: 16384=
 (order: 6, 262144 bytes, linear)
[    1.262554] Table-perturb hash table entries: 65536 (order: 6, 26214=
4 bytes, linear)
[    1.262727] TCP established hash table entries: 262144 (order: 9, 20=
97152 bytes, linear)
[    1.263101] TCP bind hash table entries: 65536 (order: 9, 2097152 by=
tes, linear)
[    1.263201] TCP: Hash tables configured (established 262144 bind 655=
36)
[    1.263310] MPTCP token hash table entries: 32768 (order: 7, 786432 =
bytes, linear)
[    1.263390] UDP hash table entries: 16384 (order: 7, 524288 bytes, l=
inear)
[    1.263463] UDP-Lite hash table entries: 16384 (order: 7, 524288 byt=
es, linear)
[    1.263537] NET: Registered PF=5FUNIX/PF=5FLOCAL protocol family
[    1.263543] NET: Registered PF=5FXDP protocol family
[    1.263549] pci 0000:00:07.0: bridge window [io  0x1000-0x0fff] to [=
bus 03-2c] add=5Fsize 1000
[    1.263559] pci 0000:00:02.0: VF BAR 2 [mem 0x4020000000-0x40fffffff=
f 64bit pref]: assigned
[    1.263565] pci 0000:00:02.0: VF BAR 0 [mem 0x4010000000-0x4016fffff=
f 64bit]: assigned
[    1.263568] pci 0000:00:07.0: bridge window [io  0x4000-0x4fff]: ass=
igned
[    1.263570] pci 0000:00:15.0: BAR 0 [mem 0x4017000000-0x4017000fff 6=
4bit]: assigned
[    1.263918] resource: avoiding allocation from e820 entry [mem 0x000=
a0000-0x000fffff]
[    1.263920] resource: avoiding allocation from e820 entry [mem 0x000=
a0000-0x000fffff]
[    1.263921] pci 0000:00:1f.5: BAR 0 [mem 0x50400000-0x50400fff]: ass=
igned
[    1.263946] pci 0000:00:06.0: PCI bridge to [bus 01]
[    1.263977] pci 0000:00:06.2: PCI bridge to [bus 02]
[    1.263985] pci 0000:00:06.2:   bridge window [mem 0x5e300000-0x5e3f=
ffff]
[    1.263993] pci 0000:04:02.0: PCI bridge to [bus 05]
[    1.264000] pci 0000:04:02.0:   bridge window [mem 0x52000000-0x520f=
ffff]
[    1.264013] pci 0000:03:00.0: PCI bridge to [bus 04-05]
[    1.264019] pci 0000:03:00.0:   bridge window [mem 0x52000000-0x520f=
ffff]
[    1.264031] pci 0000:00:07.0: PCI bridge to [bus 03-2c]
[    1.264033] pci 0000:00:07.0:   bridge window [io  0x4000-0x4fff]
[    1.264035] pci 0000:00:07.0:   bridge window [mem 0x52000000-0x5e1f=
ffff]
[    1.264037] pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x60=
1bffffff 64bit pref]
[    1.264041] pci=5Fbus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.264043] pci=5Fbus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.264044] pci=5Fbus 0000:00: resource 6 [mem 0x000a0000-0x000bffff=
 window]
[    1.264045] pci=5Fbus 0000:00: resource 7 [mem 0x000e0000-0x000fffff=
 window]
[    1.264047] pci=5Fbus 0000:00: resource 8 [mem 0x50400000-0xbfffffff=
 window]
[    1.264048] pci=5Fbus 0000:00: resource 9 [mem 0x4000000000-0x7fffff=
ffff window]
[    1.264049] pci=5Fbus 0000:02: resource 1 [mem 0x5e300000-0x5e3fffff=
]
[    1.264050] pci=5Fbus 0000:03: resource 0 [io  0x4000-0x4fff]
[    1.264052] pci=5Fbus 0000:03: resource 1 [mem 0x52000000-0x5e1fffff=
]
[    1.264053] pci=5Fbus 0000:03: resource 2 [mem 0x6000000000-0x601bff=
ffff 64bit pref]
[    1.264054] pci=5Fbus 0000:04: resource 1 [mem 0x52000000-0x520fffff=
]
[    1.264055] pci=5Fbus 0000:05: resource 1 [mem 0x52000000-0x520fffff=
]
[    1.266083] PCI: CLS 64 bytes, default 64
[    1.266091] DMAR: Intel-IOMMU force enabled due to platform opt in
[    1.266098] DMAR: No ATSR found
[    1.266099] DMAR: No SATC found
[    1.266100] DMAR: IOMMU feature fl1gp=5Fsupport inconsistent
[    1.266101] DMAR: IOMMU feature pgsel=5Finv inconsistent
[    1.266102] DMAR: IOMMU feature nwfs inconsistent
[    1.266102] DMAR: IOMMU feature dit inconsistent
[    1.266103] DMAR: IOMMU feature sc=5Fsupport inconsistent
[    1.266104] DMAR: IOMMU feature dev=5Fiotlb=5Fsupport inconsistent
[    1.266105] DMAR: dmar0: Using Queued invalidation
[    1.266108] DMAR: dmar1: Using Queued invalidation
[    1.266164] Trying to unpack rootfs image as initramfs...
[    1.266347] pci 0000:00:02.0: Adding to iommu group 0
[    1.266399] pci 0000:00:00.0: Adding to iommu group 1
[    1.266408] pci 0000:00:04.0: Adding to iommu group 2
[    1.266443] pci 0000:00:06.0: Adding to iommu group 3
[    1.266476] pci 0000:00:06.2: Adding to iommu group 4
[    1.266485] pci 0000:00:07.0: Adding to iommu group 5
[    1.266492] pci 0000:00:08.0: Adding to iommu group 6
[    1.266500] pci 0000:00:0a.0: Adding to iommu group 7
[    1.266515] pci 0000:00:0d.0: Adding to iommu group 8
[    1.266523] pci 0000:00:0d.2: Adding to iommu group 8
[    1.266536] pci 0000:00:14.0: Adding to iommu group 9
[    1.266545] pci 0000:00:14.2: Adding to iommu group 9
[    1.266555] pci 0000:00:14.3: Adding to iommu group 10
[    1.266566] pci 0000:00:15.0: Adding to iommu group 11
[    1.266586] pci 0000:00:1f.0: Adding to iommu group 12
[    1.266594] pci 0000:00:1f.3: Adding to iommu group 12
[    1.266609] pci 0000:00:1f.4: Adding to iommu group 12
[    1.266617] pci 0000:00:1f.5: Adding to iommu group 12
[    1.266649] pci 0000:02:00.0: Adding to iommu group 13
[    1.266658] pci 0000:03:00.0: Adding to iommu group 14
[    1.266667] pci 0000:04:02.0: Adding to iommu group 15
[    1.266685] pci 0000:05:00.0: Adding to iommu group 16
[    1.266983] DMAR: Intel(R) Virtualization Technology for Directed I/=
O
[    1.266984] PCI-DMA: Using software bounce buffering for IO (SWIOTLB=
)
[    1.266985] software IO TLB: mapped [mem 0x000000002c967000-0x000000=
0030967000] (64MB)
[    1.267021] clocksource: tsc: mask: 0xffffffffffffffff max=5Fcycles:=
 0x26bef67878b, max=5Fidle=5Fns: 440795293631 ns
[    1.267098] clocksource: Switched to clocksource tsc
[    1.267126] platform rtc=5Fcmos: registered platform RTC device (no =
PNP device found)
[    1.283499] Initialise system trusted keyrings
[    1.283508] Key type blacklist registered
[    1.283612] workingset: timestamp=5Fbits=3D41 max=5Forder=3D23 bucke=
t=5Forder=3D0
[    1.283620] zbud: loaded
[    1.283764] fuse: init (API version 7.40)
[    1.283853] integrity: Platform Keyring initialized
[    1.283856] integrity: Machine keyring initialized
[    1.294563] Key type asymmetric registered
[    1.294565] Asymmetric key parser 'x509' registered
[    1.294582] Block layer SCSI generic (bsg) driver version 0.4 loaded=
 (major 246)
[    1.294666] io scheduler mq-deadline registered
[    1.294668] io scheduler kyber registered
[    1.294676] io scheduler bfq registered
[    1.296318] Freeing initrd memory: 16380K
[    1.296498] pcieport 0000:00:06.0: PME: Signaling with IRQ 122
[    1.296871] pcieport 0000:00:06.2: PME: Signaling with IRQ 123
[    1.297001] pcieport 0000:00:07.0: PME: Signaling with IRQ 124
[    1.297014] pcieport 0000:00:07.0: pciehp: Slot #3 AttnBtn- PwrCtrl-=
 MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis=
- LLActRep+
[    1.297580] shpchp: Standard Hot Plug PCI Controller Driver version:=
 0.4
[    1.300204] ACPI: AC: AC Adapter [AC0] (on-line)
[    1.300241] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/=
PNP0C0E:00/input/input0
[    1.300253] ACPI: button: Sleep Button [SLPB]
[    1.300272] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/=
PNP0C0C:00/input/input1
[    1.300281] ACPI: button: Power Button [PWRB]
[    1.300297] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PN=
P0C0D:01/input/input2
[    1.300307] ACPI: button: Lid Switch [LID1]
[    1.305826] thermal LNXTHERM:00: registered as thermal=5Fzone0
[    1.305828] ACPI: thermal: Thermal Zone [ECTZ] (50 C)
[    1.311301] thermal LNXTHERM:01: registered as thermal=5Fzone1
[    1.311304] ACPI: thermal: Thermal Zone [TZ00] (50 C)
[    1.311746] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.316141] hpet=5Facpi=5Fadd: no address or irqs in =5FCRS
[    1.316196] Non-volatile memory driver v1.3
[    1.316198] Linux agpgart interface v0.103
[    1.316577] ACPI: bus type drm=5Fconnector registered
[    1.318638] usbcore: registered new interface driver usbserial=5Fgen=
eric
[    1.318642] usbserial: USB Serial support registered for generic
[    1.318692] rtc=5Fcmos rtc=5Fcmos: RTC can wake from S4
[    1.320163] rtc=5Fcmos rtc=5Fcmos: registered as rtc0
[    1.320482] rtc=5Fcmos rtc=5Fcmos: setting system clock to 2024-05-2=
0T14:48:37 UTC (1716216517)
[    1.320509] rtc=5Fcmos rtc=5Fcmos: alarms up to one month, y3k, 114 =
bytes nvram
[    1.322006] intel=5Fpstate: Intel P-state driver initializing
[    1.324714] intel=5Fpstate: HWP enabled
[    1.325411] ledtrig-cpu: registered to indicate activity on CPUs
[    1.325731] [drm] Initialized simpledrm 1.0.0 20200625 for simple-fr=
amebuffer.0 on minor 0
[    1.327067] fbcon: Deferring console take-over
[    1.327069] simple-framebuffer simple-framebuffer.0: [drm] fb0: simp=
ledrmdrmfb frame buffer device
[    1.327130] hid: raw HID events driver (C) Jiri Kosina
[    1.327200] drop=5Fmonitor: Initializing network drop monitor servic=
e
[    1.327275] NET: Registered PF=5FINET6 protocol family
[    1.332452] Segment Routing with IPv6
[    1.332455] RPL Segment Routing with IPv6
[    1.332469] In-situ OAM (IOAM) with IPv6
[    1.332499] NET: Registered PF=5FPACKET protocol family
[    1.334574] ACPI: battery: Slot [BAT0] (battery present)
[    1.335009] ENERGY=5FPERF=5FBIAS: Set to 'normal', was 'performance'
[    1.336144] microcode: Current revision: 0x00000419
[    1.337271] unchecked MSR access error: WRMSR to 0xd10 (tried to wri=
te 0x000000000000ffff) at rIP: 0xffffffff82e8c9f8 (native=5Fwrite=5Fmsr=
+0x8/0x30)
[    1.337310] Call Trace:
[    1.337320]  <TASK>
[    1.337322]  ? ex=5Fhandler=5Fmsr.isra.0.cold+0x5b/0x60
[    1.337324]  ? fixup=5Fexception+0x2c3/0x3a0
[    1.337326]  ? gp=5Ftry=5Ffixup=5Fand=5Fnotify+0x1e/0xb0
[    1.337327]  ? exc=5Fgeneral=5Fprotection+0x104/0x400
[    1.337329]  ? security=5Fkernfs=5Finit=5Fsecurity+0x35/0x50
[    1.337331]  ? asm=5Fexc=5Fgeneral=5Fprotection+0x26/0x30
[    1.337333]  ? native=5Fwrite=5Fmsr+0x8/0x30
[    1.337335]  cat=5Fwrmsr+0x49/0x70
[    1.337336]  resctrl=5Farch=5Fonline=5Fcpu+0x353/0x3a0
[    1.337337]  ? =5F=5Fpfx=5Fresctrl=5Farch=5Fonline=5Fcpu+0x10/0x10
[    1.337338]  cpuhp=5Finvoke=5Fcallback+0x11f/0x410
[    1.337340]  ? =5F=5Fpfx=5Fsmpboot=5Fthread=5Ffn+0x10/0x10
[    1.337342]  cpuhp=5Fthread=5Ffun+0xa2/0x150
[    1.337344]  smpboot=5Fthread=5Ffn+0xda/0x1d0
[    1.337346]  kthread+0xcf/0x100
[    1.337347]  ? =5F=5Fpfx=5Fkthread+0x10/0x10
[    1.337348]  ret=5Ffrom=5Ffork+0x31/0x50
[    1.337350]  ? =5F=5Fpfx=5Fkthread+0x10/0x10
[    1.337351]  ret=5Ffrom=5Ffork=5Fasm+0x1a/0x30
[    1.337353]  </TASK>
[    1.338565] resctrl: L2 allocation detected
[    1.338587] IPI shorthand broadcast: enabled
[    1.339854] sched=5Fclock: Marking stable (1323334086, 15649198)->(1=
364478794, -25495510)
[    1.340342] Timer migration: 2 hierarchy levels; 8 children per grou=
p; 2 crossnode level
[    1.341405] registered taskstats version 1
[    1.344053] Loading compiled-in X.509 certificates
[    1.346800] Loaded X.509 cert 'Build time autogenerated kernel key: =
be4bbad69eed7dd060ec4b225d099c7ad90dc57b'
[    1.351349] zswap: loaded using pool zstd/zsmalloc
[    1.351695] Key type .fscrypt registered
[    1.351698] Key type fscrypt-provisioning registered
[    1.352178] integrity: Loading X.509 certificate: UEFI:db
[    1.352198] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI=
 CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.352199] integrity: Loading X.509 certificate: UEFI:db
[    1.352211] integrity: Loaded X.509 cert 'Microsoft Windows Producti=
on PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.352211] integrity: Loading X.509 certificate: UEFI:db
[    1.356937] integrity: Loaded X.509 cert 'UNIWILL Tech BIOS 2019 Roo=
t CA: 815e876df90e5b8b41d2d56d0c39e0b6'
[    1.358771] PM:   Magic number: 8:768:839
[    1.358804] acpi OVTI01AS:00: hash matches
[    1.362546] RAS: Correctable Errors collector initialized.
[    1.371608] clk: Disabling unused clocks
[    1.371609] PM: genpd: Disabling unused power domains
[    1.376922] Freeing unused decrypted memory: 2028K
[    1.377534] Freeing unused kernel image (initmem) memory: 3408K
[    1.377535] Write protecting the kernel read-only data: 32768k
[    1.378507] Freeing unused kernel image (rodata/data gap) memory: 10=
60K
[    1.383157] x86/mm: Checked W+X mappings: passed, no W+X pages found=
.
[    1.383159] rodata=5Ftest: all tests were successful
[    1.383161] Run /init as init process
[    1.383162]   with arguments:
[    1.383162]     /init
[    1.383163]   with environment:
[    1.383163]     HOME=3D/
[    1.383164]     TERM=3Dlinux
[    1.414865] fbcon: Taking over console
[    1.420349] Console: switching to colour frame buffer device 160x50
[    1.498675] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 =
irq 1
[    1.498680] i8042: PNP: PS/2 appears to have AUX port disabled, if t=
his is incorrect please boot with i8042.nopnp
[    1.500798] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.501012] xhci=5Fhcd 0000:00:0d.0: xHCI Host Controller
[    1.501021] xhci=5Fhcd 0000:00:0d.0: new USB bus registered, assigne=
d bus number 1
[    1.502082] xhci=5Fhcd 0000:00:0d.0: hcc params 0x20007fc1 hci versi=
on 0x120 quirks 0x0000000200009810
[    1.502433] xhci=5Fhcd 0000:00:0d.0: xHCI Host Controller
[    1.502438] xhci=5Fhcd 0000:00:0d.0: new USB bus registered, assigne=
d bus number 2
[    1.502441] xhci=5Fhcd 0000:00:0d.0: Host supports USB 3.2 Enhanced =
SuperSpeed
[    1.502598] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002, bcdDevice=3D 6.09
[    1.502606] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.502610] usb usb1: Product: xHCI Host Controller
[    1.502612] usb usb1: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
[    1.502615] usb usb1: SerialNumber: 0000:00:0d.0
[    1.502763] hub 1-0:1.0: USB hub found
[    1.502783] hub 1-0:1.0: 1 port detected
[    1.503400] usb usb2: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0003, bcdDevice=3D 6.09
[    1.503410] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.503414] usb usb2: Product: xHCI Host Controller
[    1.503416] usb usb2: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
[    1.503418] usb usb2: SerialNumber: 0000:00:0d.0
[    1.503565] hub 2-0:1.0: USB hub found
[    1.503583] hub 2-0:1.0: 1 port detected
[    1.504931] xhci=5Fhcd 0000:00:14.0: xHCI Host Controller
[    1.504940] xhci=5Fhcd 0000:00:14.0: new USB bus registered, assigne=
d bus number 3
[    1.506112] xhci=5Fhcd 0000:00:14.0: hcc params 0x20007fc1 hci versi=
on 0x120 quirks 0x0000100200009810
[    1.506679] xhci=5Fhcd 0000:00:14.0: xHCI Host Controller
[    1.506685] xhci=5Fhcd 0000:00:14.0: new USB bus registered, assigne=
d bus number 4
[    1.506689] xhci=5Fhcd 0000:00:14.0: Host supports USB 3.1 Enhanced =
SuperSpeed
[    1.506808] usb usb3: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002, bcdDevice=3D 6.09
[    1.506813] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.506816] usb usb3: Product: xHCI Host Controller
[    1.506818] usb usb3: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
[    1.506820] usb usb3: SerialNumber: 0000:00:14.0
[    1.507000] hub 3-0:1.0: USB hub found
[    1.507053] hub 3-0:1.0: 12 ports detected
[    1.509874] usb usb4: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0003, bcdDevice=3D 6.09
[    1.509882] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.509885] usb usb4: Product: xHCI Host Controller
[    1.509888] usb usb4: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
[    1.509890] usb usb4: SerialNumber: 0000:00:14.0
[    1.510047] hub 4-0:1.0: USB hub found
[    1.510079] hub 4-0:1.0: 4 ports detected
[    1.511132] usb: port power management may be unreliable
[    1.511526] xhci=5Fhcd 0000:05:00.0: xHCI Host Controller
[    1.511534] xhci=5Fhcd 0000:05:00.0: new USB bus registered, assigne=
d bus number 5
[    1.512788] xhci=5Fhcd 0000:05:00.0: hcc params 0x200077c1 hci versi=
on 0x110 quirks 0x0000000200009810
[    1.512865] nvme 0000:02:00.0: platform quirk: setting simple suspen=
d
[    1.512958] nvme nvme0: pci function 0000:02:00.0
[    1.513237] xhci=5Fhcd 0000:05:00.0: xHCI Host Controller
[    1.513240] xhci=5Fhcd 0000:05:00.0: new USB bus registered, assigne=
d bus number 6
[    1.513244] xhci=5Fhcd 0000:05:00.0: Host supports USB 3.1 Enhanced =
SuperSpeed
[    1.513346] usb usb5: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002, bcdDevice=3D 6.09
[    1.513352] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.513355] usb usb5: Product: xHCI Host Controller
[    1.513357] usb usb5: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
[    1.513359] usb usb5: SerialNumber: 0000:05:00.0
[    1.513487] hub 5-0:1.0: USB hub found
[    1.513507] hub 5-0:1.0: 2 ports detected
[    1.513727] usb usb6: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0003, bcdDevice=3D 6.09
[    1.513731] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.513734] usb usb6: Product: xHCI Host Controller
[    1.513736] usb usb6: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
[    1.513738] usb usb6: SerialNumber: 0000:05:00.0
[    1.513856] hub 6-0:1.0: USB hub found
[    1.513873] hub 6-0:1.0: 2 ports detected
[    1.526176] nvme nvme0: D3 entry latency set to 10 seconds
[    1.530417] nvme nvme0: 20/0/0 default/read/poll queues
[    1.533324]  nvme0n1: p1 p2 p3
[    1.545615] input: AT Translated Set 2 keyboard as /devices/platform=
/i8042/serio0/input/input3
[    1.746060] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    1.759333] Console: switching to colour dummy device 80x25
[    1.765695] usb 3-3: new high-speed USB device number 2 using xhci=5F=
hcd
[    1.769036] usb 5-1: new high-speed USB device number 2 using xhci=5F=
hcd
[    1.819043] i915 0000:00:02.0: vgaarb: deactivate vga console
[    1.819267] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[    1.820928] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecod=
es=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    1.827686] i915 0000:00:02.0: [drm] Finished loading DMC firmware i=
915/adlp=5Fdmc.bin (v2.20)
[    1.913031] usb 3-3: New USB device found, idVendor=3D05e3, idProduc=
t=3D0610, bcdDevice=3D23.11
[    1.913034] usb 3-3: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    1.913034] usb 3-3: Product: USB2.1 Hub
[    1.913035] usb 3-3: Manufacturer: GenesysLogic
[    1.914011] usb 5-1: New USB device found, idVendor=3D2188, idProduc=
t=3D0610, bcdDevice=3D70.42
[    1.914014] usb 5-1: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    1.914015] usb 5-1: Product: USB2.1 Hub
[    1.914016] usb 5-1: Manufacturer: CalDigit, Inc.
[    1.914934] hub 3-3:1.0: USB hub found
[    1.915349] hub 3-3:1.0: 2 ports detected
[    1.915501] hub 5-1:1.0: USB hub found
[    1.915807] hub 5-1:1.0: 4 ports detected
[    2.032721] usb 6-1: new SuperSpeed Plus Gen 2x1 USB device number 2=
 using xhci=5Fhcd
[    2.032742] usb 4-4: new SuperSpeed USB device number 2 using xhci=5F=
hcd
[    2.053858] usb 6-1: New USB device found, idVendor=3D2188, idProduc=
t=3D0625, bcdDevice=3D70.42
[    2.053861] usb 6-1: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    2.053862] usb 6-1: Product: USB3.1 Gen2 Hub
[    2.053863] usb 6-1: Manufacturer: CalDigit, Inc.
[    2.054081] usb 4-4: New USB device found, idVendor=3D05e3, idProduc=
t=3D0620, bcdDevice=3D23.11
[    2.054083] usb 4-4: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[    2.054084] usb 4-4: Product: USB3.2 Hub
[    2.054084] usb 4-4: Manufacturer: GenesysLogic
[    2.055508] hub 6-1:1.0: USB hub found
[    2.055865] hub 4-4:1.0: USB hub found
[    2.055881] hub 6-1:1.0: 4 ports detected
[    2.056213] hub 4-4:1.0: 2 ports detected
[    2.172318] usb 3-10: new full-speed USB device number 3 using xhci=5F=
hcd
[    2.191435] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/adlp=5Fg=
uc=5F70.bin version 70.20.0
[    2.191439] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl=5Fhu=
c.bin version 7.9.3
[    2.212087] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all=
 workloads
[    2.213196] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[    2.213199] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[    2.213688] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[    2.214488] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protect=
ed content support initialized
[    2.219210] usb 5-1.4: new high-speed USB device number 3 using xhci=
=5Fhcd
[    2.316532] usb 3-10: New USB device found, idVendor=3D8087, idProdu=
ct=3D0026, bcdDevice=3D 0.02
[    2.316553] usb 3-10: New USB device strings: Mfr=3D0, Product=3D0, =
SerialNumber=3D0
[    2.337260] usb 5-1.4: New USB device found, idVendor=3D2188, idProd=
uct=3D0611, bcdDevice=3D93.06
[    2.337282] usb 5-1.4: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[    2.337289] usb 5-1.4: Product: USB2.1 Hub
[    2.337294] usb 5-1.4: Manufacturer: CalDigit, Inc.
[    2.340244] hub 5-1.4:1.0: USB hub found
[    2.340707] hub 5-1.4:1.0: 4 ports detected
[    2.409925] usb 6-1.1: new SuperSpeed USB device number 3 using xhci=
=5Fhcd
[    2.415955] usb 3-3.2: new full-speed USB device number 4 using xhci=
=5Fhcd
[    2.432707] usb 6-1.1: New USB device found, idVendor=3D2188, idProd=
uct=3D0754, bcdDevice=3D 0.06
[    2.432732] usb 6-1.1: New USB device strings: Mfr=3D3, Product=3D4,=
 SerialNumber=3D2
[    2.432740] usb 6-1.1: Product: USB-C Pro Card Reader
[    2.432746] usb 6-1.1: Manufacturer: CalDigit
[    2.432751] usb 6-1.1: SerialNumber: 000000000006
[    2.449922] usb-storage 6-1.1:1.0: USB Mass Storage device detected
[    2.450522] scsi host0: usb-storage 6-1.1:1.0
[    2.450639] usbcore: registered new interface driver usb-storage
[    2.456828] usbcore: registered new interface driver uas
[    2.516254] usb 6-1.4: new SuperSpeed USB device number 4 using xhci=
=5Fhcd
[    2.537570] usb 3-3.2: New USB device found, idVendor=3D046d, idProd=
uct=3Dc24d, bcdDevice=3D80.01
[    2.537594] usb 3-3.2: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[    2.537602] usb 3-3.2: Product: Logitech G710 Keyboard
[    2.537608] usb 3-3.2: Manufacturer: Logitech
[    2.538369] usb 6-1.4: New USB device found, idVendor=3D2188, idProd=
uct=3D0620, bcdDevice=3D93.06
[    2.538380] usb 6-1.4: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[    2.538386] usb 6-1.4: Product: USB3.1 Gen1 Hub
[    2.538391] usb 6-1.4: Manufacturer: CalDigit, Inc.
[    2.542300] hub 6-1.4:1.0: USB hub found
[    2.542765] hub 6-1.4:1.0: 4 ports detected
[    2.567826] usbcore: registered new interface driver usbhid
[    2.567834] usbhid: USB HID core driver
[    2.575376] input: Logitech Logitech G710 Keyboard as /devices/pci00=
00:00/0000:00:14.0/usb3/3-3/3-3.2/3-3.2:1.0/0003:046D:C24D.0001/input/i=
nput4
[    2.609704] usb 4-4.1: new SuperSpeed USB device number 3 using xhci=
=5Fhcd
[    2.630133] hid-generic 0003:046D:C24D.0001: input,hidraw0: USB HID =
v1.11 Keyboard [Logitech Logitech G710 Keyboard] on usb-0000:00:14.0-3.=
2/input0
[    2.630814] input: Logitech Logitech G710 Keyboard as /devices/pci00=
00:00/0000:00:14.0/usb3/3-3/3-3.2/3-3.2:1.1/0003:046D:C24D.0002/input/i=
nput5
[    2.641917] usb 4-4.1: New USB device found, idVendor=3D0bda, idProd=
uct=3D0316, bcdDevice=3D 2.04
[    2.641942] usb 4-4.1: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D3
[    2.641950] usb 4-4.1: Product: USB3.0-CRW
[    2.641957] usb 4-4.1: Manufacturer: Generic
[    2.641962] usb 4-4.1: SerialNumber: 20120501030900000
[    2.645719] usb 5-1.4.1: new high-speed USB device number 4 using xh=
ci=5Fhcd
[    2.652697] usb-storage 4-4.1:1.0: USB Mass Storage device detected
[    2.654211] scsi host1: usb-storage 4-4.1:1.0
[    2.687022] hid-generic 0003:046D:C24D.0002: input,hiddev96,hidraw1:=
 USB HID v1.11 Keyboard [Logitech Logitech G710 Keyboard] on usb-0000:0=
0:14.0-3.2/input1
[    2.989513] usb 6-1.4.4: new SuperSpeed USB device number 5 using xh=
ci=5Fhcd
[    3.008820] usb 6-1.4.4: New USB device found, idVendor=3D0bda, idPr=
oduct=3D8153, bcdDevice=3D31.00
[    3.008839] usb 6-1.4.4: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D6
[    3.008844] usb 6-1.4.4: Product: USB 10/100/1000 LAN
[    3.008849] usb 6-1.4.4: Manufacturer: Realtek
[    3.008852] usb 6-1.4.4: SerialNumber: 001001000
[    3.325888] [drm] Initialized i915 1.6.0 20230929 for 0000:00:02.0 o=
n minor 1
[    3.328689] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: =
no  post: no)
[    3.329329] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP=
0A08:00/LNXVIDEO:00/input/input7
[    3.464756] scsi 0:0:0:0: Direct-Access     CalDigit SD Card Reader =
  0006 PQ: 0 ANSI: 6
[    3.466450] sd 0:0:0:0: [sda] Media removed, stopped polling
[    3.467471] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    3.497199] usb 5-1.4.1: New USB device found, idVendor=3D2188, idPr=
oduct=3D4042, bcdDevice=3D 0.06
[    3.497214] usb 5-1.4.1: New USB device strings: Mfr=3D3, Product=3D=
1, SerialNumber=3D0
[    3.497219] usb 5-1.4.1: Product: CalDigit USB-C Pro Audio
[    3.497222] usb 5-1.4.1: Manufacturer: CalDigit Inc.
[    3.509516] fbcon: i915drmfb (fb0) is primary device
[    3.513756] input: CalDigit Inc. CalDigit USB-C Pro Audio as /device=
s/pci0000:00/0000:00:07.0/0000:03:00.0/0000:04:02.0/0000:05:00.0/usb5/5=
-1/5-1.4/5-1.4.1/5-1.4.1:1.3/0003:2188:4042.0003/input/input8
[    3.569547] hid-generic 0003:2188:4042.0003: input,hidraw2: USB HID =
v1.11 Device [CalDigit Inc. CalDigit USB-C Pro Audio] on usb-0000:05:00=
.0-1.4.1/input3
[    3.683028] scsi 1:0:0:0: Direct-Access     Generic- SD/MMC         =
  1.00 PQ: 0 ANSI: 6
[    3.686279] sd 1:0:0:0: [sdb] Media removed, stopped polling
[    3.687241] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[    4.846365] Console: switching to colour frame buffer device 160x50
[    5.004575] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer dev=
ice
[    5.317474] EXT4-fs (nvme0n1p2): mounted filesystem 3d3927a4-190d-4e=
14-aae4-2b44c8b74da8 r/w with ordered data mode. Quota mode: none.
[    5.373941] systemd[1]: systemd 255.6-1-arch running in system mode =
(+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +O=
PENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCR=
YPTSETUP +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ=
4 +XZ +ZLIB +ZSTD +BPF=5FFRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-h=
ierarchy=3Dunified)
[    5.373945] systemd[1]: Detected architecture x86-64.
[    5.374538] systemd[1]: Hostname set to <pandora>.
[    6.039381] systemd[1]: bpf-lsm: LSM BPF program attached
[    6.185024] systemd[1]: Queued start job for default target Graphica=
l Interface.
[    6.265440] systemd[1]: Created slice Virtual Machine and Container =
Slice.
[    6.266989] systemd[1]: Created slice Slice /system/dirmngr.
[    6.267649] systemd[1]: Created slice Slice /system/getty.
[    6.268240] systemd[1]: Created slice Slice /system/gpg-agent.
[    6.268431] systemd[1]: Created slice Slice /system/gpg-agent-browse=
r.
[    6.268568] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    6.268701] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    6.268841] systemd[1]: Created slice Slice /system/keyboxd.
[    6.268979] systemd[1]: Created slice Slice /system/modprobe.
[    6.269251] systemd[1]: Created slice Slice /system/systemd-fsck.
[    6.269367] systemd[1]: Created slice User and Session Slice.
[    6.269433] systemd[1]: Started Dispatch Password Requests to Consol=
e Directory Watch.
[    6.269496] systemd[1]: Started Forward Password Requests to Wall Di=
rectory Watch.
[    6.269621] systemd[1]: Set up automount Arbitrary Executable File F=
ormats File System Automount Point.
[    6.269680] systemd[1]: Expecting device /dev/disk/by-diskseq/1-part=
3...
[    6.269721] systemd[1]: Expecting device /dev/disk/by-uuid/3512-6C76=
...
[    6.269762] systemd[1]: Reached target Local Encrypted Volumes.
[    6.269803] systemd[1]: Reached target Login Prompts.
[    6.269842] systemd[1]: Reached target Local Integrity Protected Vol=
umes.
[    6.269894] systemd[1]: Reached target Remote File Systems.
[    6.269935] systemd[1]: Reached target Slice Units.
[    6.269981] systemd[1]: Reached target System Time Set.
[    6.270027] systemd[1]: Reached target Local Verity Protected Volume=
s.
[    6.270096] systemd[1]: Listening on Device-mapper event daemon FIFO=
s.
[    6.270210] systemd[1]: Listening on LVM2 poll daemon socket.
[    6.270891] systemd[1]: Listening on Process Core Dump Socket.
[    6.270979] systemd[1]: Listening on Journal Socket (/dev/log).
[    6.271053] systemd[1]: Listening on Journal Socket.
[    6.271110] systemd[1]: TPM2 PCR Extension (Varlink) was skipped bec=
ause of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    6.271235] systemd[1]: Listening on udev Control Socket.
[    6.271301] systemd[1]: Listening on udev Kernel Socket.
[    6.272173] systemd[1]: Mounting Huge Pages File System...
[    6.272848] systemd[1]: Mounting POSIX Message Queue File System...
[    6.273560] systemd[1]: Mounting Kernel Debug File System...
[    6.274192] systemd[1]: Mounting Kernel Trace File System...
[    6.275178] systemd[1]: Starting Create List of Static Device Nodes.=
..
[    6.276111] systemd[1]: Starting Monitoring of LVM2 mirrors, snapsho=
ts etc. using dmeventd or progress polling...
[    6.277116] systemd[1]: Starting Load Kernel Module configfs...
[    6.278981] systemd[1]: Starting Load Kernel Module dm=5Fmod...
[    6.281246] systemd[1]: Starting Load Kernel Module drm...
[    6.282804] systemd[1]: Starting Load Kernel Module fuse...
[    6.284434] systemd[1]: Starting Load Kernel Module loop...
[    6.285496] systemd[1]: File System Check on Root Device was skipped=
 because of an unmet condition check (ConditionPathIsReadWrite=3D!/).
[    6.288003] systemd[1]: Starting Journal Service...
[    6.290119] systemd[1]: Starting Load Kernel Modules...
[    6.291019] systemd[1]: TPM2 PCR Machine ID Measurement was skipped =
because of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    6.291718] systemd[1]: Starting Remount Root and Kernel File System=
s...
[    6.292745] systemd[1]: TPM2 SRK Setup (Early) was skipped because o=
f an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    6.293580] systemd[1]: Starting Coldplug All udev Devices...
[    6.295955] systemd[1]: Mounted Huge Pages File System.
[    6.296154] device-mapper: uevent: version 1.0.3
[    6.296194] loop: module loaded
[    6.296283] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initiali=
sed: dm-devel@lists.linux.dev
[    6.297603] systemd[1]: Mounted POSIX Message Queue File System.
[    6.298870] systemd[1]: Mounted Kernel Debug File System.
[    6.300161] systemd[1]: Mounted Kernel Trace File System.
[    6.301484] systemd[1]: Finished Create List of Static Device Nodes.
[    6.302857] systemd[1]: modprobe@configfs.service: Deactivated succe=
ssfully.
[    6.302977] systemd[1]: Finished Load Kernel Module configfs.
[    6.304175] systemd[1]: modprobe@dm=5Fmod.service: Deactivated succe=
ssfully.
[    6.304284] systemd[1]: Finished Load Kernel Module dm=5Fmod.
[    6.305260] systemd[1]: modprobe@drm.service: Deactivated successful=
ly.
[    6.305337] systemd[1]: Finished Load Kernel Module drm.
[    6.306308] systemd[1]: modprobe@fuse.service: Deactivated successfu=
lly.
[    6.306378] systemd[1]: Finished Load Kernel Module fuse.
[    6.306727] systemd-journald[441]: Collecting audit messages is disa=
bled.
[    6.307300] systemd[1]: modprobe@loop.service: Deactivated successfu=
lly.
[    6.307369] systemd[1]: Finished Load Kernel Module loop.
[    6.307853] i2c=5Fdev: i2c /dev entries driver
[    6.309206] systemd[1]: Mounting FUSE Control File System...
[    6.310724] systemd[1]: Mounting Kernel Configuration File System...
[    6.311850] systemd[1]: Repartition Root Disk was skipped because no=
 trigger condition checks were met.
[    6.312869] systemd[1]: Starting Create Static Device Nodes in /dev =
gracefully...
[    6.315227] systemd[1]: Mounted FUSE Control File System.
[    6.318239] systemd[1]: Mounted Kernel Configuration File System.
[    6.322943] EXT4-fs (nvme0n1p2): re-mounted 3d3927a4-190d-4e14-aae4-=
2b44c8b74da8 r/w. Quota mode: none.
[    6.323952] systemd[1]: Finished Remount Root and Kernel File System=
s.
[    6.325747] systemd[1]: Rebuild Hardware Database was skipped becaus=
e no trigger condition checks were met.
[    6.326540] systemd[1]: Starting Load/Save OS Random Seed...
[    6.327537] systemd[1]: TPM2 SRK Setup was skipped because of an unm=
et condition check (ConditionSecurity=3Dmeasured-uki).
[    6.339287] systemd[1]: Started Journal Service.
[    6.342070] cryptd: max=5Fcpu=5Fqlen set to 1000
[    6.351924] AVX2 version of gcm=5Fenc/dec engaged.
[    6.352048] AES CTR mode by8 optimization enabled
[    6.355889] systemd-journald[441]: Received client request to flush =
runtime journal.
[    6.374135] systemd-journald[441]: /var/log/journal/4af3a1e8e01745dd=
baff38b21f2c52c6/system.journal: Journal file uses a different sequence=
 number ID, rotating.
[    6.374138] systemd-journald[441]: Rotating system journal.
[    6.507542] Key type encrypted registered
[    6.509567] mc: Linux media interface: v0.10
[    6.519754] input: Intel HID events as /devices/platform/INTC1070:00=
/input/input9
[    6.519760] resource: resource sanity check: requesting [mem 0x00000=
000fedc0000-0x00000000fedcffff], which spans more than pnp 00:03 [mem 0=
xfedc0000-0xfedc7fff]
[    6.519770] caller igen6=5Fprobe+0x15e/0x7c0 [igen6=5Fedac] mapping =
multiple BARs
[    6.522601] intel-hid INTC1070:00: failed to enable HID power button
[    6.523044] EDAC MC0: Giving out device to module igen6=5Fedac contr=
oller Intel=5Fclient=5FSoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
[    6.526298] EDAC MC1: Giving out device to module igen6=5Fedac contr=
oller Intel=5Fclient=5FSoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
[    6.526333] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[    6.526335] EDAC igen6 MC0: ADDR 0x7fffffffe0=20
[    6.526783] EDAC igen6 MC1: HANDLING IBECC MEMORY ERROR
[    6.526787] EDAC igen6 MC1: ADDR 0x7fffffffe0=20
[    6.529895] EDAC igen6: v2.5.1
[    6.532106] videodev: Linux video capture interface: v2.00
[    6.558955] intel=5Fpmc=5Fcore INT33A1:00:  initialized
[    6.599992] Adding 11546620k swap on /dev/nvme0n1p3.  Priority:-2 ex=
tents:1 across:11546620k SS
[    6.621232] ACPI: bus type thunderbolt registered
[    6.621334] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.622374] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    6.625223] thunderbolt 0000:00:0d.2: total paths: 12
[    6.625245] thunderbolt 0000:00:0d.2: IOMMU DMA protection is enable=
d
[    6.627508] i801=5Fsmbus 0000:00:1f.4: enabling device (0000 -> 0003=
)
[    6.627842] i801=5Fsmbus 0000:00:1f.4: SPD Write Disable is set
[    6.627935] i801=5Fsmbus 0000:00:1f.4: SMBus using PCI interrupt
[    6.638702] i2c i2c-15: Successfully instantiated SPD at 0x50
[    6.646155] thunderbolt 0000:00:0d.2: allocating TX ring 0 of size 1=
0
[    6.646196] thunderbolt 0000:00:0d.2: allocating RX ring 0 of size 1=
0
[    6.646219] thunderbolt 0000:00:0d.2: control channel created
[    6.646224] thunderbolt 0000:00:0d.2: using software connection mana=
ger
[    6.649925] asus=5Fwmi: ASUS WMI generic driver loaded
[    6.651090] Creating 1 MTD partitions on "0000:00:1f.5":
[    6.651095] 0x000000000000-0x000002000000 : "BIOS"
[    6.659027] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    6.659665] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    6.664634] thunderbolt 0000:00:0d.2: created link from 0000:00:0d.0
[    6.694238] thunderbolt 0000:00:0d.2: created link from 0000:00:0d.0
[    6.694372] thunderbolt 0000:00:0d.2: created link from 0000:00:07.0
[    6.696946] thunderbolt 0000:00:0d.2: NHI initialized, starting thun=
derbolt
[    6.696952] thunderbolt 0000:00:0d.2: control channel starting...
[    6.696955] thunderbolt 0000:00:0d.2: starting TX ring 0
[    6.696961] thunderbolt 0000:00:0d.2: enabling interrupt at register=
 0x38200 bit 0 (0x0 -> 0x1)
[    6.696965] thunderbolt 0000:00:0d.2: starting RX ring 0
[    6.696969] thunderbolt 0000:00:0d.2: enabling interrupt at register=
 0x38200 bit 12 (0x1 -> 0x1001)
[    6.696976] thunderbolt 0000:00:0d.2: security level set to user
[    6.697254] thunderbolt 0000:00:0d.2: current switch config:
[    6.697259] thunderbolt 0000:00:0d.2:  USB4 Switch: 8087:463e (Revis=
ion: 2, TB Version: 32)
[    6.697264] thunderbolt 0000:00:0d.2:   Max Port Number: 13
[    6.697267] thunderbolt 0000:00:0d.2:   Config:
[    6.697268] thunderbolt 0000:00:0d.2:    Upstream Port Number: 7 Dep=
th: 0 Route String: 0x0 Enabled: 1, PlugEventsDelay: 254ms
[    6.697272] thunderbolt 0000:00:0d.2:    unknown1: 0x0 unknown4: 0x0
[    6.704032] thunderbolt 0000:00:0d.2: initializing Switch at 0x0 (de=
pth: 0, up port: 7)
[    6.705889] thunderbolt 0000:00:0d.2: 0: credit allocation parameter=
s:
[    6.705893] thunderbolt 0000:00:0d.2: 0:  USB3: 32
[    6.705895] thunderbolt 0000:00:0d.2: 0:  DP AUX: 1
[    6.705898] thunderbolt 0000:00:0d.2: 0:  DP main: 0
[    6.705900] thunderbolt 0000:00:0d.2: 0:  PCIe: 64
[    6.705902] thunderbolt 0000:00:0d.2: 0:  DMA: 14
[    6.711626] thunderbolt 0000:00:0d.2: 0: DROM version: 3
[    6.712454] thunderbolt 0000:00:0d.2: 0: uid: 0x6cacd6008087a2d6
[    6.714503] thunderbolt 0000:00:0d.2:  Port 1: 8087:15ea (Revision: =
0, TB Version: 1, Type: Port (0x1))
[    6.714510] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/19
[    6.714513] thunderbolt 0000:00:0d.2:   Max counters: 16
[    6.714516] thunderbolt 0000:00:0d.2:   NFC Credits: 0x47800000
[    6.714519] thunderbolt 0000:00:0d.2:   Credits (total/control): 120=
/2
[    6.717035] thunderbolt 0000:00:0d.2:  Port 2: 8087:15ea (Revision: =
0, TB Version: 1, Type: Port (0x1))
[    6.717041] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/19
[    6.717044] thunderbolt 0000:00:0d.2:   Max counters: 16
[    6.717047] thunderbolt 0000:00:0d.2:   NFC Credits: 0x80000000
[    6.717050] thunderbolt 0000:00:0d.2:   Credits (total/control): 0/2
[    6.719437] thunderbolt 0000:00:0d.2:  Port 3: 8087:15ea (Revision: =
0, TB Version: 1, Type: Port (0x1))
[    6.719442] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/19
[    6.719445] thunderbolt 0000:00:0d.2:   Max counters: 16
[    6.719448] thunderbolt 0000:00:0d.2:   NFC Credits: 0x83c00000
[    6.719451] thunderbolt 0000:00:0d.2:   Credits (total/control): 60/=
2
[    6.721028] iTCO=5Fvendor=5Fsupport: vendor-support=3D0
[    6.721166] intel=5Frapl=5Fmsr: PL4 support detected.
[    6.721180] usbcore: registered new device driver r8152-cfgselector
[    6.721205] intel=5Frapl=5Fcommon: Found RAPL domain package
[    6.721209] intel=5Frapl=5Fcommon: Found RAPL domain core
[    6.721210] intel=5Frapl=5Fcommon: Found RAPL domain uncore
[    6.721212] intel=5Frapl=5Fcommon: Found RAPL domain psys
[    6.721220] asus=5Fwmi: ASUS Management GUID not found
[    6.721445] thunderbolt 0000:00:0d.2:  Port 4: 8087:15ea (Revision: =
0, TB Version: 1, Type: Port (0x1))
[    6.721453] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/19
[    6.721472] thunderbolt 0000:00:0d.2:   Max counters: 16
[    6.721476] thunderbolt 0000:00:0d.2:   NFC Credits: 0x83c00000
[    6.721479] thunderbolt 0000:00:0d.2:   Credits (total/control): 60/=
2
[    6.722314] thunderbolt 0000:00:0d.2:  Port 5: 8087:15ea (Revision: =
0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    6.722388] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 9/9
[    6.722390] thunderbolt 0000:00:0d.2:   Max counters: 2
[    6.722391] thunderbolt 0000:00:0d.2:   NFC Credits: 0x100000c
[    6.722393] thunderbolt 0000:00:0d.2:   Credits (total/control): 16/=
0
[    6.722676] thunderbolt 0000:00:0d.2:  Port 6: 8087:15ea (Revision: =
0, TB Version: 1, Type: DP/HDMI (0xe0101))
[    6.722684] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 9/9
[    6.722697] thunderbolt 0000:00:0d.2:   Max counters: 2
[    6.722700] thunderbolt 0000:00:0d.2:   NFC Credits: 0x100000c
[    6.722702] thunderbolt 0000:00:0d.2:   Credits (total/control): 16/=
0
[    6.723563] cfg80211: Loading compiled-in X.509 certificates for reg=
ulatory database
[    6.723764] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    6.723950] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c724=
8db18c600'
[    6.724027] thunderbolt 0000:00:0d.2:  Port 7: 8086:15ea (Revision: =
0, TB Version: 1, Type: NHI (0x2))
[    6.724035] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 11/11
[    6.724038] thunderbolt 0000:00:0d.2:   Max counters: 16
[    6.724040] thunderbolt 0000:00:0d.2:   NFC Credits: 0x1c00000
[    6.724042] thunderbolt 0000:00:0d.2:   Credits (total/control): 28/=
0
[    6.724295] thunderbolt 0000:00:0d.2:  Port 8: 8087:15ea (Revision: =
0, TB Version: 1, Type: PCIe (0x100101))
[    6.724303] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    6.724305] thunderbolt 0000:00:0d.2:   Max counters: 2
[    6.724307] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    6.724309] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    6.724520] ee1004 15-0050: 512 byte EE1004-compliant SPD EEPROM, re=
ad-only
[    6.724910] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 65=
5360 ms ovfl timer
[    6.724915] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    6.724917] RAPL PMU: hw unit of domain package 2^-14 Joules
[    6.724919] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    6.724920] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    6.725099] thunderbolt 0000:00:0d.2:  Port 9: 8087:15ea (Revision: =
0, TB Version: 1, Type: PCIe (0x100101))
[    6.725104] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    6.725106] thunderbolt 0000:00:0d.2:   Max counters: 2
[    6.725108] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    6.725110] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    6.725232] thunderbolt 0000:00:0d.2:  Port 10: not implemented
[    6.725368] thunderbolt 0000:00:0d.2:  Port 11: not implemented
[    6.725632] thunderbolt 0000:00:0d.2:  Port 12: 8087:0 (Revision: 0,=
 TB Version: 1, Type: USB (0x200101))
[    6.725635] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    6.725637] thunderbolt 0000:00:0d.2:   Max counters: 2
[    6.725638] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    6.725639] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    6.726445] thunderbolt 0000:00:0d.2:  Port 13: 8087:0 (Revision: 0,=
 TB Version: 1, Type: USB (0x200101))
[    6.726459] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    6.726466] thunderbolt 0000:00:0d.2:   Max counters: 2
[    6.726473] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    6.726479] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    6.726482] thunderbolt 0000:00:0d.2: 0: running quirk=5Fusb3=5Fmaxi=
mum=5Fbandwidth [thunderbolt]
[    6.726529] thunderbolt 0000:00:0d.2: 0:12: USB3 maximum bandwidth l=
imited to 16376 Mb/s
[    6.726531] thunderbolt 0000:00:0d.2: 0:13: USB3 maximum bandwidth l=
imited to 16376 Mb/s
[    6.726533] thunderbolt 0000:00:0d.2: 0: linked ports 1 <-> 2
[    6.726535] thunderbolt 0000:00:0d.2: 0: linked ports 3 <-> 4
[    6.729001] platform regulatory.0: Direct firmware load for regulato=
ry.db failed with error -2
[    6.729004] cfg80211: failed to load regulatory.db
[    6.735417] thunderbolt 0000:00:0d.2: 0: TMU: supports uni-direction=
al mode
[    6.735550] thunderbolt 0000:00:0d.2: 0: TMU: current mode: off
[    6.738302] Bluetooth: Core ver 2.22
[    6.738316] NET: Registered PF=5FBLUETOOTH protocol family
[    6.738317] Bluetooth: HCI device and connection manager initialized
[    6.738320] Bluetooth: HCI socket layer initialized
[    6.738323] Bluetooth: L2CAP socket layer initialized
[    6.738325] Bluetooth: SCO socket layer initialized
[    6.739648] thunderbolt 0000:00:0d.2: 0: TMU: mode change off -> uni=
-directional, LowRes requested
[    6.740677] thunderbolt 0000:00:0d.2: 0: TMU: mode set to: uni-direc=
tional, LowRes
[    6.741068] thunderbolt 0000:00:0d.2: 0: resetting
[    6.743473] thunderbolt 0000:00:0d.2: acking hot unplug event on 0:1
[    6.767472] pcieport 0000:00:07.0: pciehp: Slot(3): Link Down
[    6.767475] pcieport 0000:00:07.0: pciehp: Slot(3): Card not present
[    6.767485] xhci=5Fhcd 0000:05:00.0: remove, state 1
[    6.767494] usb usb6: USB disconnect, device number 1
[    6.767495] usb 6-1: USB disconnect, device number 2
[    6.767496] usb 6-1.1: USB disconnect, device number 3
[    6.792433] thunderbolt 0000:00:0d.2: 0:5: DP IN resource available
[    6.793826] thunderbolt 0000:00:0d.2: 0:6: DP IN resource available
[    6.793958] thunderbolt 0000:00:0d.2: 0:1: got unplug event for disc=
onnected port, ignoring
[    6.832566] input: UNIW0001:00 093A:0274 Mouse as /devices/pci0000:0=
0/0000:00:15.0/i2c=5Fdesignware.0/i2c-16/i2c-UNIW0001:00/0018:093A:0274=
.0004/input/input10
[    6.832696] input: UNIW0001:00 093A:0274 Touchpad as /devices/pci000=
0:00/0000:00:15.0/i2c=5Fdesignware.0/i2c-16/i2c-UNIW0001:00/0018:093A:0=
274.0004/input/input11
[    6.832892] hid-generic 0018:093A:0274.0004: input,hidraw3: I2C HID =
v1.00 Mouse [UNIW0001:00 093A:0274] on i2c-UNIW0001:00
[    6.847494] iTCO=5Fwdt iTCO=5Fwdt: Found a Intel PCH TCO device (Ver=
sion=3D6, TCOBASE=3D0x0400)
[    6.847647] iTCO=5Fwdt iTCO=5Fwdt: initialized. heartbeat=3D30 sec (=
nowayout=3D0)
[    6.861711] proc=5Fthermal=5Fpci 0000:00:04.0: enabling device (0000=
 -> 0002)
[    6.861936] intel=5Frapl=5Fcommon: Found RAPL domain package
[    6.865796] proc=5Fthermal=5Fpci 0000:00:04.0: error: proc=5Fthermal=
=5Fadd, will continue
[    6.867010] Consider using thermal netlink events interface
[    6.870206] Intel(R) Wireless WiFi driver for Linux
[    6.870638] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    6.874324] iwlwifi 0000:00:14.3: Detected crf-id 0x1300504, cnv-id =
0x80400 wfpm id 0x80000030
[    6.874385] iwlwifi 0000:00:14.3: PCI dev 51f0/0074, rev=3D0x370, rf=
id=3D0x10a100
[    6.880665] iwlwifi 0000:00:14.3: TLV=5FFW=5FFSEQ=5FVERSION: FSEQ Ve=
rsion: 0.0.2.42
[    6.881102] iwlwifi 0000:00:14.3: loaded firmware version 89.e9cec78=
e.0 so-a0-hr-b0-89.ucode op=5Fmode iwlmvm
[    6.886604] snd=5Fhda=5Fintel 0000:00:1f.3: DSP detected with PCI cl=
ass/subclass/prog-if info 0x040380
[    6.886805] snd=5Fhda=5Fintel 0000:00:1f.3: enabling device (0000 ->=
 0002)
[    6.887512] pps=5Fcore: LinuxPPS API ver. 1 registered
[    6.887515] pps=5Fcore: Software ver. 5.3.6 - Copyright 2005-2007 Ro=
dolfo Giometti <giometti@linux.it>
[    6.889570] usb 6-1.4: USB disconnect, device number 4
[    6.895037] PTP clock support registered
[    6.928173] input: UNIW0001:00 093A:0274 Mouse as /devices/pci0000:0=
0/0000:00:15.0/i2c=5Fdesignware.0/i2c-16/i2c-UNIW0001:00/0018:093A:0274=
.0004/input/input12
[    6.928368] input: UNIW0001:00 093A:0274 Touchpad as /devices/pci000=
0:00/0000:00:15.0/i2c=5Fdesignware.0/i2c-16/i2c-UNIW0001:00/0018:093A:0=
274.0004/input/input13
[    6.928455] hid-multitouch 0018:093A:0274.0004: input,hidraw3: I2C H=
ID v1.00 Mouse [UNIW0001:00 093A:0274] on i2c-UNIW0001:00
[    6.989536] usbcore: registered new interface driver btusb
[    6.991648] Bluetooth: hci0: Device revision is 2
[    6.991653] Bluetooth: hci0: Secure boot is enabled
[    6.991655] Bluetooth: hci0: OTP lock is enabled
[    6.991656] Bluetooth: hci0: API lock is enabled
[    6.991657] Bluetooth: hci0: Debug lock is disabled
[    6.991658] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    6.991661] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype =
1 build 38
[    6.991749] ACPI Warning: \=5FSB.PC00.XHCI.RHUB.HS10.=5FDSM: Argumen=
t #4 type mismatch - Found [Integer], ACPI requires [Package] (20230628=
/nsarguments-61)
[    6.991791] Bluetooth: hci0: DSM reset method type: 0x00
[    6.994261] mousedev: PS/2 mouse device common for all mice
[    6.996976] Bluetooth: hci0: Found device firmware: intel/ibt-0040-4=
150.sfi
[    6.996991] Bluetooth: hci0: Boot Address: 0x100800
[    6.996993] Bluetooth: hci0: Firmware Version: 46-14.24
[    7.033665] intel=5Ftcc=5Fcooling: Programmable TCC Offset detected
[    7.081129] thunderbolt 0000:00:0d.2: acking hot plug event on 0:1
[    7.081145] thunderbolt 0000:00:0d.2: 0:1: hotplug: scanning
[    7.081367] thunderbolt 0000:00:0d.2: 0:1: is connected, link is up =
(state: 2)
[    7.083150] thunderbolt 0000:00:0d.2: 0:1: reading NVM authenticatio=
n status of retimers
[    7.088608] thunderbolt 0000:00:0d.2: acking hot plug event on 0:2
[    7.545056] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    7.545059] Bluetooth: BNEP filters: protocol multicast
[    7.545062] Bluetooth: BNEP socket layer initialized
[    7.696075] thunderbolt 0000:00:0d.2: 0:1: disabling sideband transa=
ctions
[    7.782517] xhci=5Fhcd 0000:05:00.0: xHCI host controller not respon=
ding, assume dead
[    7.785109] r8152 6-1.4.4:1.0 (unnamed net=5Fdevice) (uninitialized)=
: Get ether addr fail
[    7.785211] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.785279] r8152-cfgselector 6-1.4.4: USB disconnect, device number=
 5
[    7.787953] usb 5-1.4.1: Not enough bandwidth for altsetting 1
[    7.787959] usb 5-1.4.1: 1:1: cannot set freq 44100 to ep 0x81
[    7.788469] r8152 6-1.4.4:1.0 eth0: v1.12.13
[    7.789887] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.789892] usb 5-1.4.1: Not enough bandwidth for altsetting 2
[    7.789896] usb 5-1.4.1: 1:2: cannot set freq 44100 to ep 0x81
[    7.790019] usbcore: registered new interface driver r8152
[    7.791617] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.791638] usb 5-1.4.1: Not enough bandwidth for altsetting 3
[    7.791644] usb 5-1.4.1: 1:3: cannot set freq 44100 to ep 0x81
[    7.793774] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.793783] usb 5-1.4.1: Not enough bandwidth for altsetting 4
[    7.793789] usb 5-1.4.1: 1:4: cannot set freq 48000 to ep 0x81
[    7.795758] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.795767] usb 5-1.4.1: Not enough bandwidth for altsetting 5
[    7.795774] usb 5-1.4.1: 1:5: cannot set freq 48000 to ep 0x81
[    7.797792] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.797798] usb 5-1.4.1: Not enough bandwidth for altsetting 6
[    7.797802] usb 5-1.4.1: 1:6: cannot set freq 48000 to ep 0x81
[    7.799894] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.799905] usb 5-1.4.1: Not enough bandwidth for altsetting 7
[    7.799911] usb 5-1.4.1: 1:7: cannot set freq 96000 to ep 0x81
[    7.801572] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.801575] usb 5-1.4.1: Not enough bandwidth for altsetting 8
[    7.801577] usb 5-1.4.1: 1:8: cannot set freq 96000 to ep 0x81
[    7.803218] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.803220] usb 5-1.4.1: Not enough bandwidth for altsetting 9
[    7.803222] usb 5-1.4.1: 1:9: cannot set freq 96000 to ep 0x81
[    7.804684] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.804685] usb 5-1.4.1: Not enough bandwidth for altsetting 10
[    7.804687] usb 5-1.4.1: 1:10: cannot set freq 192000 to ep 0x81
[    7.805955] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.805956] usb 5-1.4.1: Not enough bandwidth for altsetting 11
[    7.805958] usb 5-1.4.1: 1:11: cannot set freq 192000 to ep 0x81
[    7.807055] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.807056] usb 5-1.4.1: Not enough bandwidth for altsetting 12
[    7.807057] usb 5-1.4.1: 1:12: cannot set freq 192000 to ep 0x81
[    7.808118] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.808153] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.808155] usb 5-1.4.1: Not enough bandwidth for altsetting 1
[    7.808156] usb 5-1.4.1: 2:1: cannot set freq 44100 to ep 0x4
[    7.809232] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.809235] usb 5-1.4.1: Not enough bandwidth for altsetting 2
[    7.809238] usb 5-1.4.1: 2:2: cannot set freq 44100 to ep 0x4
[    7.810294] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.810295] usb 5-1.4.1: Not enough bandwidth for altsetting 3
[    7.810296] usb 5-1.4.1: 2:3: cannot set freq 44100 to ep 0x4
[    7.811328] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.811329] usb 5-1.4.1: Not enough bandwidth for altsetting 4
[    7.811330] usb 5-1.4.1: 2:4: cannot set freq 48000 to ep 0x4
[    7.812301] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.812302] usb 5-1.4.1: Not enough bandwidth for altsetting 5
[    7.812303] usb 5-1.4.1: 2:5: cannot set freq 48000 to ep 0x4
[    7.813339] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.813340] usb 5-1.4.1: Not enough bandwidth for altsetting 6
[    7.813341] usb 5-1.4.1: 2:6: cannot set freq 48000 to ep 0x4
[    7.814381] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.814383] usb 5-1.4.1: Not enough bandwidth for altsetting 7
[    7.814384] usb 5-1.4.1: 2:7: cannot set freq 96000 to ep 0x4
[    7.815426] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.815428] usb 5-1.4.1: Not enough bandwidth for altsetting 8
[    7.815429] usb 5-1.4.1: 2:8: cannot set freq 96000 to ep 0x4
[    7.816398] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.816399] usb 5-1.4.1: Not enough bandwidth for altsetting 9
[    7.816400] usb 5-1.4.1: 2:9: cannot set freq 96000 to ep 0x4
[    7.817337] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.817339] usb 5-1.4.1: Not enough bandwidth for altsetting 10
[    7.817340] usb 5-1.4.1: 2:10: cannot set freq 192000 to ep 0x4
[    7.818266] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.818267] usb 5-1.4.1: Not enough bandwidth for altsetting 11
[    7.818268] usb 5-1.4.1: 2:11: cannot set freq 192000 to ep 0x4
[    7.818497] usbcore: registered new interface driver cdc=5Fether
[    7.819225] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.819231] usb 5-1.4.1: Not enough bandwidth for altsetting 12
[    7.819236] usb 5-1.4.1: 2:12: cannot set freq 192000 to ep 0x4
[    7.820314] usb 5-1.4.1: Not enough bandwidth for altsetting 0
[    7.820444] usb 5-1.4.1: 19:0: failed to get current value for ch 0 =
(-22)
[    7.820534] usb 5-1.4.1: 19:0: cannot get min/max values for control=
 2 (id 19)
[    7.821504] usb 5-1.4.1: 25:0: failed to get current value for ch 0 =
(-22)
[    7.821648] usb 5-1.4.1: 22:0: failed to get current value for ch 0 =
(-22)
[    7.821731] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.822838] usbcore: registered new interface driver snd-usb-audio
[    7.828978] usbcore: registered new interface driver r8153=5Fecm
[    7.839263] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 16=
0MHz, REV=3D0x370
[    7.839326] thermal thermal=5Fzone4: failed to read out thermal zone=
 (-61)
[    7.840997] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.841842] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.842722] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.843559] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.844365] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.845183] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.846638] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.847712] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.848702] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.849700] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.850022] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[    7.850667] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.912659] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.913663] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.914542] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.915365] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.916198] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.916273] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.917716] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.917801] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.917889] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.917997] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.918181] usb 5-1.4.1: 22:0: cannot get min/max values for control=
 2 (id 22)
[    7.954774] iwlwifi 0000:00:14.3: WFPM=5FUMAC=5FPD=5FNOTIFICATION: 0=
x20
[    7.954824] iwlwifi 0000:00:14.3: WFPM=5FLMAC2=5FPD=5FNOTIFICATION: =
0x1f
[    7.954884] iwlwifi 0000:00:14.3: WFPM=5FAUTH=5FKEY=5F0: 0x90
[    7.954943] iwlwifi 0000:00:14.3: CNVI=5FSCU=5FSEQ=5FDATA=5FDW9: 0x1=
0
[    7.955180] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=3D0x10a100
[    7.956179] iwlwifi 0000:00:14.3: RFIm is deactivated, reason =3D 5
[    8.012936] snd=5Fhda=5Fintel 0000:00:1f.3: bound 0000:00:02.0 (ops =
i915=5Faudio=5Fcomponent=5Fbind=5Fops [i915])
[    8.013562] typec port0: bound usb3-port2 (ops connector=5Fops)
[    8.013598] typec port0: bound usb2-port1 (ops connector=5Fops)
[    8.019969] xhci=5Fhcd 0000:05:00.0: USB bus 6 deregistered
[    8.020019] xhci=5Fhcd 0000:05:00.0: remove, state 1
[    8.020030] usb usb5: USB disconnect, device number 1
[    8.020034] usb 5-1: USB disconnect, device number 2
[    8.020037] usb 5-1.4: USB disconnect, device number 3
[    8.020040] usb 5-1.4.1: USB disconnect, device number 4
[    8.022303] iwlwifi 0000:00:14.3: base HW address: 7c:21:4a:40:58:49
[    8.040572] iwlwifi 0000:00:14.3 wlo1: renamed from wlan0
[    8.057245] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[    8.062253] snd=5Fhda=5Fcodec=5Frealtek hdaudioC0D0: autoconfig for =
ALC256: line=5Fouts=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    8.062259] snd=5Fhda=5Fcodec=5Frealtek hdaudioC0D0:    speaker=5Fou=
ts=3D0 (0x0/0x0/0x0/0x0/0x0)
[    8.062261] snd=5Fhda=5Fcodec=5Frealtek hdaudioC0D0:    hp=5Fouts=3D=
1 (0x21/0x0/0x0/0x0/0x0)
[    8.062263] snd=5Fhda=5Fcodec=5Frealtek hdaudioC0D0:    mono: mono=5F=
out=3D0x0
[    8.062264] snd=5Fhda=5Fcodec=5Frealtek hdaudioC0D0:    inputs:
[    8.062265] snd=5Fhda=5Fcodec=5Frealtek hdaudioC0D0:      Mic=3D0x19
[    8.062266] snd=5Fhda=5Fcodec=5Frealtek hdaudioC0D0:      Internal M=
ic=3D0x12
[    8.142670] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:=
1f.3/sound/card0/input14
[    8.156389] iwlwifi 0000:00:14.3: WFPM=5FUMAC=5FPD=5FNOTIFICATION: 0=
x20
[    8.156446] iwlwifi 0000:00:14.3: WFPM=5FLMAC2=5FPD=5FNOTIFICATION: =
0x1f
[    8.156498] iwlwifi 0000:00:14.3: WFPM=5FAUTH=5FKEY=5F0: 0x90
[    8.156509] iwlwifi 0000:00:14.3: CNVI=5FSCU=5FSEQ=5FDATA=5FDW9: 0x1=
0
[    8.157841] iwlwifi 0000:00:14.3: RFIm is deactivated, reason =3D 5
[    8.209287] input: HDA Intel PCH Headphone as /devices/pci0000:00/00=
00:00:1f.3/sound/card0/input15
[    8.209468] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000=
:00/0000:00:1f.3/sound/card0/input16
[    8.209937] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000=
:00/0000:00:1f.3/sound/card0/input17
[    8.210776] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000=
:00/0000:00:1f.3/sound/card0/input18
[    8.211660] input: HDA Intel PCH HDMI/DP,pcm=3D9 as /devices/pci0000=
:00/0000:00:1f.3/sound/card0/input19
[    8.220510] xhci=5Fhcd 0000:05:00.0: Host halt failed, -19
[    8.220515] xhci=5Fhcd 0000:05:00.0: Host not accessible, reset fail=
ed.
[    8.221020] xhci=5Fhcd 0000:05:00.0: USB bus 5 deregistered
[    8.222153] pci=5Fbus 0000:05: busn=5Fres: [bus 05] is released
[    8.222753] pci=5Fbus 0000:04: busn=5Fres: [bus 04-05] is released
[    8.225355] thunderbolt 0-0:1.1: NVM version 7.0
[    8.225360] thunderbolt 0-0:1.1: new retimer found, vendor=3D0x8087 =
device=3D0x15ee
[    8.226410] thunderbolt 0000:00:0d.2: current switch config:
[    8.226413] thunderbolt 0000:00:0d.2:  Thunderbolt 3 Switch: 8086:15=
ef (Revision: 6, TB Version: 16)
[    8.226417] thunderbolt 0000:00:0d.2:   Max Port Number: 13
[    8.226420] thunderbolt 0000:00:0d.2:   Config:
[    8.226421] thunderbolt 0000:00:0d.2:    Upstream Port Number: 0 Dep=
th: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
[    8.226424] thunderbolt 0000:00:0d.2:    unknown1: 0x0 unknown4: 0x0
[    8.227755] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP,=
 with index: 0
[    8.234944] thunderbolt 0000:00:0d.2: initializing Switch at 0x1 (de=
pth: 1, up port: 1)
[    8.246755] thunderbolt 0000:00:0d.2: acking hot plug event on 1:2
[    8.267378] thunderbolt 0000:00:0d.2: 1: reading DROM (length: 0x6d)
[    8.285368] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[    8.384782] iwlwifi 0000:00:14.3: WFPM=5FUMAC=5FPD=5FNOTIFICATION: 0=
x20
[    8.384841] iwlwifi 0000:00:14.3: WFPM=5FLMAC2=5FPD=5FNOTIFICATION: =
0x1f
[    8.384889] iwlwifi 0000:00:14.3: WFPM=5FAUTH=5FKEY=5F0: 0x90
[    8.384896] iwlwifi 0000:00:14.3: CNVI=5FSCU=5FSEQ=5FDATA=5FDW9: 0x1=
0
[    8.386037] iwlwifi 0000:00:14.3: RFIm is deactivated, reason =3D 5
[    8.626423] Bluetooth: hci0: Waiting for firmware download to comple=
te
[    8.626662] Bluetooth: hci0: Firmware loaded in 1591486 usecs
[    8.626783] Bluetooth: hci0: Waiting for device to boot
[    8.641868] Bluetooth: hci0: Device booted in 14816 usecs
[    8.641890] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    8.642100] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0=
040-4150.ddc
[    8.644920] Bluetooth: hci0: Applying Intel DDC parameters completed
[    8.647936] Bluetooth: hci0: Firmware timestamp 2024.14 buildtype 1 =
build 81454
[    8.647942] Bluetooth: hci0: Firmware SHA1: 0xdfd62093
[    8.651882] Bluetooth: hci0: Fseq status: Success (0x00)
[    8.651887] Bluetooth: hci0: Fseq executed: 00.00.02.41
[    8.651889] Bluetooth: hci0: Fseq BT Top: 00.00.02.41
[    8.733410] Bluetooth: MGMT ver 1.22
[    8.740425] NET: Registered PF=5FALG protocol family
[    8.879296] thunderbolt 0000:00:0d.2: 1: DROM version: 1
[    8.880631] thunderbolt 0000:00:0d.2: 1: uid: 0x3d600630c86400
[    8.884540] thunderbolt 0000:00:0d.2:  Port 1: 8086:15ef (Revision: =
6, TB Version: 1, Type: Port (0x1))
[    8.884562] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/19
[    8.884564] thunderbolt 0000:00:0d.2:   Max counters: 16
[    8.884566] thunderbolt 0000:00:0d.2:   NFC Credits: 0x3c00000
[    8.884567] thunderbolt 0000:00:0d.2:   Credits (total/control): 60/=
2
[    8.887782] thunderbolt 0000:00:0d.2:  Port 2: 8086:15ef (Revision: =
6, TB Version: 1, Type: Port (0x1))
[    8.887787] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/19
[    8.887789] thunderbolt 0000:00:0d.2:   Max counters: 16
[    8.887791] thunderbolt 0000:00:0d.2:   NFC Credits: 0x3c00000
[    8.887792] thunderbolt 0000:00:0d.2:   Credits (total/control): 60/=
2
[    8.887794] thunderbolt 0000:00:0d.2: 1:3: disabled by eeprom
[    8.887795] thunderbolt 0000:00:0d.2: 1:4: disabled by eeprom
[    8.887796] thunderbolt 0000:00:0d.2: 1:5: disabled by eeprom
[    8.887797] thunderbolt 0000:00:0d.2: 1:6: disabled by eeprom
[    8.887798] thunderbolt 0000:00:0d.2: 1:7: disabled by eeprom
[    8.888053] thunderbolt 0000:00:0d.2:  Port 8: 8086:15ef (Revision: =
6, TB Version: 1, Type: PCIe (0x100102))
[    8.888056] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    8.888057] thunderbolt 0000:00:0d.2:   Max counters: 2
[    8.888058] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    8.888059] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    8.888848] thunderbolt 0000:00:0d.2:  Port 9: 8086:15ef (Revision: =
6, TB Version: 1, Type: PCIe (0x100101))
[    8.888850] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    8.888851] thunderbolt 0000:00:0d.2:   Max counters: 2
[    8.888852] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    8.888852] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    8.889379] thunderbolt 0000:00:0d.2:  Port 10: 8086:15ef (Revision:=
 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[    8.889381] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 9/9
[    8.889382] thunderbolt 0000:00:0d.2:   Max counters: 2
[    8.889383] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    8.889384] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    8.890457] thunderbolt 0000:00:0d.2:  Port 11: 8086:15ef (Revision:=
 6, TB Version: 1, Type: DP/HDMI (0xe0102))
[    8.890459] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 9/9
[    8.890460] thunderbolt 0000:00:0d.2:   Max counters: 2
[    8.890461] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    8.890462] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    8.890721] thunderbolt 0000:00:0d.2:  Port 12: 8086:15ea (Revision:=
 6, TB Version: 1, Type: Inactive (0x0))
[    8.890723] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    8.890724] thunderbolt 0000:00:0d.2:   Max counters: 2
[    8.890725] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    8.890726] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    8.891534] thunderbolt 0000:00:0d.2:  Port 13: 8086:15ea (Revision:=
 6, TB Version: 1, Type: Inactive (0x0))
[    8.891545] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
[    8.891551] thunderbolt 0000:00:0d.2:   Max counters: 2
[    8.891557] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
[    8.891564] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
[    8.891825] thunderbolt 0000:00:0d.2: 1: current link speed 10.0 Gb/=
s
[    8.891827] thunderbolt 0000:00:0d.2: 1: current link width symmetri=
c, single lane
[    8.892224] thunderbolt 0000:00:0d.2: 0:1: total credits changed 120=
 -> 60
[    8.892938] thunderbolt 0000:00:0d.2: 0:2: total credits changed 0 -=
> 60
[    8.893048] thunderbolt 0000:00:0d.2: 1: CLx: current mode: disabled
[    8.897789] thunderbolt 0000:00:0d.2: 1: TMU: supports uni-direction=
al mode
[    8.898596] thunderbolt 0000:00:0d.2: 1: TMU: current mode: bi-direc=
tional, HiFi
[    8.898660] thunderbolt 0-1: new device found, vendor=3D0x3d device=3D=
0x18
[    8.898663] thunderbolt 0-1: CalDigit, Inc. USB-C Pro Dock
[    8.900686] thunderbolt 0000:00:0d.2: 1: NVM version 43.0
[    8.901856] thunderbolt 0000:00:0d.2: 0:2: is connected, link is up =
(state: 2)
[    8.905863] thunderbolt 0000:00:0d.2: acking hot unplug event on 0:2
[    8.905873] thunderbolt 0000:00:0d.2: acking hot unplug event on 1:2
[    8.906143] thunderbolt 0000:00:0d.2: 0:1: total credits changed 60 =
-> 120
[    8.906275] thunderbolt 0000:00:0d.2: 0:2: total credits changed 60 =
-> 0
[    8.906957] thunderbolt 0000:00:0d.2: 1:1: total credits changed 60 =
-> 120
[    8.907069] thunderbolt 0000:00:0d.2: 1:2: total credits changed 60 =
-> 0
[    8.907344] thunderbolt 0000:00:0d.2: 1: link width set to symmetric=
, dual lanes
[    8.910266] thunderbolt 0000:00:0d.2: 1:1: CLx: CL0s/CL1 supported
[    8.910268] thunderbolt 0000:00:0d.2: 0:1: CLx: CL0s/CL1 supported
[    8.911725] thunderbolt 0000:00:0d.2: 1: CLx: CL0s/CL1 enabled
[    8.911727] thunderbolt 0000:00:0d.2: 1: TMU: mode change bi-directi=
onal, HiFi -> uni-directional, LowRes requested
[    8.913071] thunderbolt 0000:00:0d.2: 1: TMU: disabled
[    8.917344] thunderbolt 0000:00:0d.2: 1: TMU: mode set to: uni-direc=
tional, LowRes
[    8.918406] thunderbolt 0000:00:0d.2: 1:10: DP adapter HPD set, queu=
ing hotplug
[    8.918669] thunderbolt 0000:00:0d.2: 1:11: DP adapter HPD set, queu=
ing hotplug
[    8.918814] thunderbolt 0000:00:0d.2: 0:8 <-> 1:8 (PCI): activating
[    8.918819] thunderbolt 0000:00:0d.2: activating PCIe Down path from=
 0:8 to 1:8
[    8.919491] thunderbolt 0000:00:0d.2: 1:1: Writing hop 1
[    8.919493] thunderbolt 0000:00:0d.2: 1:1:  In HopID: 8 =3D> Out por=
t: 8 Out HopID: 8
[    8.919496] thunderbolt 0000:00:0d.2: 1:1:   Weight: 1 Priority: 3 C=
redits: 32 Drop: 0 PM: 0
[    8.919498] thunderbolt 0000:00:0d.2: 1:1:    Counter enabled: 0 Cou=
nter index: 2047
[    8.919500] thunderbolt 0000:00:0d.2: 1:1:   Flow Control (In/Eg): 1=
/0 Shared Buffer (In/Eg): 0/0
[    8.919502] thunderbolt 0000:00:0d.2: 1:1:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.919804] thunderbolt 0000:00:0d.2: 0:8: Writing hop 0
[    8.919806] thunderbolt 0000:00:0d.2: 0:8:  In HopID: 8 =3D> Out por=
t: 1 Out HopID: 8
[    8.919808] thunderbolt 0000:00:0d.2: 0:8:   Weight: 1 Priority: 3 C=
redits: 7 Drop: 0 PM: 0
[    8.919810] thunderbolt 0000:00:0d.2: 0:8:    Counter enabled: 0 Cou=
nter index: 2047
[    8.919812] thunderbolt 0000:00:0d.2: 0:8:   Flow Control (In/Eg): 1=
/1 Shared Buffer (In/Eg): 0/0
[    8.919814] thunderbolt 0000:00:0d.2: 0:8:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.919936] thunderbolt 0000:00:0d.2: path activation complete
[    8.919938] thunderbolt 0000:00:0d.2: activating PCIe Up path from 1=
:8 to 0:8
[    8.920069] thunderbolt 0000:00:0d.2: 0:1: Writing hop 1
[    8.920071] thunderbolt 0000:00:0d.2: 0:1:  In HopID: 8 =3D> Out por=
t: 8 Out HopID: 8
[    8.920073] thunderbolt 0000:00:0d.2: 0:1:   Weight: 1 Priority: 3 C=
redits: 64 Drop: 0 PM: 0
[    8.920075] thunderbolt 0000:00:0d.2: 0:1:    Counter enabled: 0 Cou=
nter index: 2047
[    8.920077] thunderbolt 0000:00:0d.2: 0:1:   Flow Control (In/Eg): 1=
/0 Shared Buffer (In/Eg): 0/0
[    8.920080] thunderbolt 0000:00:0d.2: 0:1:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.920339] thunderbolt 0000:00:0d.2: 1:8: Writing hop 0
[    8.920342] thunderbolt 0000:00:0d.2: 1:8:  In HopID: 8 =3D> Out por=
t: 1 Out HopID: 8
[    8.920344] thunderbolt 0000:00:0d.2: 1:8:   Weight: 1 Priority: 3 C=
redits: 7 Drop: 0 PM: 0
[    8.920346] thunderbolt 0000:00:0d.2: 1:8:    Counter enabled: 0 Cou=
nter index: 2047
[    8.920348] thunderbolt 0000:00:0d.2: 1:8:   Flow Control (In/Eg): 1=
/1 Shared Buffer (In/Eg): 0/0
[    8.920350] thunderbolt 0000:00:0d.2: 1:8:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.920978] thunderbolt 0000:00:0d.2: path activation complete
[    8.923786] thunderbolt 0000:00:0d.2: 1:1: xHCI connected
[    8.924173] thunderbolt 0000:00:0d.2: 1:3: xHCI connected
[    8.924197] thunderbolt 0000:00:0d.2: 0:2: got plug event for connec=
ted port, ignoring
[    8.924210] thunderbolt 0000:00:0d.2: hotplug event for upstream por=
t 1:2 (unplug: 0)
[    8.924213] thunderbolt 0000:00:0d.2: 0:2: got unplug event for disc=
onnected port, ignoring
[    8.924216] thunderbolt 0000:00:0d.2: hotplug event for upstream por=
t 1:2 (unplug: 1)
[    8.924308] thunderbolt 0000:00:0d.2: 1:10: DP OUT resource availabl=
e after hotplug
[    8.924311] thunderbolt 0000:00:0d.2: looking for DP IN <-> DP OUT p=
airs:
[    8.924444] thunderbolt 0000:00:0d.2: 0:5: DP IN available
[    8.925561] thunderbolt 0000:00:0d.2: 1:10: DP OUT available
[    8.927238] thunderbolt 0000:00:0d.2: 0: allocated DP resource for p=
ort 5
[    8.927244] thunderbolt 0000:00:0d.2: 0:5: attached to bandwidth gro=
up 1
[    8.928190] thunderbolt 0000:00:0d.2: 0:1: link maximum bandwidth 18=
000/18000 Mb/s
[    8.928454] thunderbolt 0000:00:0d.2: 1:1: link maximum bandwidth 18=
000/18000 Mb/s
[    8.928589] thunderbolt 0000:00:0d.2: available bandwidth for new DP=
 tunnel 18000/18000 Mb/s
[    8.928596] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): activating
[    8.930748] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): DP IN maxim=
um supported bandwidth 8100 Mb/s x4 =3D 25920 Mb/s
[    8.930754] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): DP OUT maxi=
mum supported bandwidth 5400 Mb/s x4 =3D 17280 Mb/s
[    8.930758] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): disabling L=
TTPR
[    8.930992] thunderbolt 0000:00:0d.2: activating Video path from 0:5=
 to 1:10
[    8.930994] thunderbolt 0000:00:0d.2: 1:1: adding 12 NFC credits to =
0
[    8.931256] thunderbolt 0000:00:0d.2: 1:1: Writing hop 1
[    8.931258] thunderbolt 0000:00:0d.2: 1:1:  In HopID: 9 =3D> Out por=
t: 10 Out HopID: 9
[    8.931261] thunderbolt 0000:00:0d.2: 1:1:   Weight: 1 Priority: 1 C=
redits: 0 Drop: 0 PM: 0
[    8.931263] thunderbolt 0000:00:0d.2: 1:1:    Counter enabled: 0 Cou=
nter index: 2047
[    8.931265] thunderbolt 0000:00:0d.2: 1:1:   Flow Control (In/Eg): 0=
/0 Shared Buffer (In/Eg): 0/0
[    8.931267] thunderbolt 0000:00:0d.2: 1:1:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.932088] thunderbolt 0000:00:0d.2: 0:5: Writing hop 0
[    8.932092] thunderbolt 0000:00:0d.2: 0:5:  In HopID: 9 =3D> Out por=
t: 1 Out HopID: 9
[    8.932095] thunderbolt 0000:00:0d.2: 0:5:   Weight: 1 Priority: 1 C=
redits: 0 Drop: 0 PM: 0
[    8.932098] thunderbolt 0000:00:0d.2: 0:5:    Counter enabled: 0 Cou=
nter index: 2047
[    8.932100] thunderbolt 0000:00:0d.2: 0:5:   Flow Control (In/Eg): 0=
/0 Shared Buffer (In/Eg): 0/0
[    8.932102] thunderbolt 0000:00:0d.2: 0:5:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.932218] thunderbolt 0000:00:0d.2: path activation complete
[    8.932221] thunderbolt 0000:00:0d.2: activating AUX TX path from 0:=
5 to 1:10
[    8.932480] thunderbolt 0000:00:0d.2: 1:1: Writing hop 1
[    8.932485] thunderbolt 0000:00:0d.2: 1:1:  In HopID: 10 =3D> Out po=
rt: 10 Out HopID: 8
[    8.932488] thunderbolt 0000:00:0d.2: 1:1:   Weight: 1 Priority: 2 C=
redits: 1 Drop: 0 PM: 0
[    8.932490] thunderbolt 0000:00:0d.2: 1:1:    Counter enabled: 0 Cou=
nter index: 2047
[    8.932491] thunderbolt 0000:00:0d.2: 1:1:   Flow Control (In/Eg): 1=
/0 Shared Buffer (In/Eg): 0/0
[    8.932493] thunderbolt 0000:00:0d.2: 1:1:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.932929] thunderbolt 0000:00:0d.2: 0:5: Writing hop 0
[    8.932934] thunderbolt 0000:00:0d.2: 0:5:  In HopID: 8 =3D> Out por=
t: 1 Out HopID: 10
[    8.932936] thunderbolt 0000:00:0d.2: 0:5:   Weight: 1 Priority: 2 C=
redits: 1 Drop: 0 PM: 0
[    8.932937] thunderbolt 0000:00:0d.2: 0:5:    Counter enabled: 0 Cou=
nter index: 2047
[    8.932939] thunderbolt 0000:00:0d.2: 0:5:   Flow Control (In/Eg): 1=
/1 Shared Buffer (In/Eg): 0/0
[    8.932941] thunderbolt 0000:00:0d.2: 0:5:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.933620] thunderbolt 0000:00:0d.2: path activation complete
[    8.933624] thunderbolt 0000:00:0d.2: activating AUX RX path from 1:=
10 to 0:5
[    8.933795] thunderbolt 0000:00:0d.2: 0:1: Writing hop 1
[    8.933800] thunderbolt 0000:00:0d.2: 0:1:  In HopID: 9 =3D> Out por=
t: 5 Out HopID: 8
[    8.933802] thunderbolt 0000:00:0d.2: 0:1:   Weight: 1 Priority: 2 C=
redits: 1 Drop: 0 PM: 0
[    8.933804] thunderbolt 0000:00:0d.2: 0:1:    Counter enabled: 0 Cou=
nter index: 2047
[    8.933806] thunderbolt 0000:00:0d.2: 0:1:   Flow Control (In/Eg): 1=
/0 Shared Buffer (In/Eg): 0/0
[    8.933808] thunderbolt 0000:00:0d.2: 0:1:   Unknown1: 0x0 Unknown2:=
 0x0 Unknown3: 0x0
[    8.934033] thunderbolt 0000:00:0d.2: 1:10: Writing hop 0
[    8.934035] thunderbolt 0000:00:0d.2: 1:10:  In HopID: 8 =3D> Out po=
rt: 1 Out HopID: 9
[    8.934037] thunderbolt 0000:00:0d.2: 1:10:   Weight: 1 Priority: 2 =
Credits: 1 Drop: 0 PM: 0
[    8.934038] thunderbolt 0000:00:0d.2: 1:10:    Counter enabled: 0 Co=
unter index: 2047
[    8.934040] thunderbolt 0000:00:0d.2: 1:10:   Flow Control (In/Eg): =
1/1 Shared Buffer (In/Eg): 0/0
[    8.934041] thunderbolt 0000:00:0d.2: 1:10:   Unknown1: 0x0 Unknown2=
: 0x0 Unknown3: 0x0
[    8.934167] thunderbolt 0000:00:0d.2: path activation complete
[    9.002042] thunderbolt 0000:00:0d.2: acking hot plug event on 1:11
[    9.003036] thunderbolt 0000:00:0d.2: acking hot plug event on 1:10
[    9.149361] pcieport 0000:00:07.0: pciehp: Slot(3): Card present
[    9.149367] pcieport 0000:00:07.0: pciehp: Slot(3): Link Up
[    9.218482] Bluetooth: RFCOMM TTY layer initialized
[    9.218491] Bluetooth: RFCOMM socket layer initialized
[    9.218497] Bluetooth: RFCOMM ver 1.11
[    9.285792] pci 0000:03:00.0: [8086:15ef] type 01 class 0x060400 PCI=
e Switch Upstream Port
[    9.285877] pci 0000:03:00.0: PCI bridge to [bus 00]
[    9.285902] pci 0000:03:00.0:   bridge window [io  0x0000-0x0fff]
[    9.285914] pci 0000:03:00.0:   bridge window [mem 0x00000000-0x000f=
ffff]
[    9.285946] pci 0000:03:00.0:   bridge window [mem 0x00000000-0x000f=
ffff 64bit pref]
[    9.285982] pci 0000:03:00.0: enabling Extended Tags
[    9.286310] pci 0000:03:00.0: supports D1 D2
[    9.286314] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    9.286524] pci 0000:03:00.0: PTM enabled, 4ns granularity
[    9.286645] pci 0000:03:00.0: 8.000 Gb/s available PCIe bandwidth, l=
imited by 2.5 GT/s PCIe x4 link at 0000:00:07.0 (capable of 31.504 Gb/s=
 with 8.0 GT/s PCIe x4 link)
[    9.287139] pci 0000:03:00.0: Adding to iommu group 14
[    9.287373] pcieport 0000:00:07.0: ASPM: current common clock config=
uration is inconsistent, reconfiguring
[    9.295791] pci 0000:03:00.0: bridge configuration invalid ([bus 00-=
00]), reconfiguring
[    9.295987] pci 0000:04:02.0: [8086:15ef] type 01 class 0x060400 PCI=
e Switch Downstream Port
[    9.296044] pci 0000:04:02.0: PCI bridge to [bus 00]
[    9.296059] pci 0000:04:02.0:   bridge window [io  0x0000-0x0fff]
[    9.296066] pci 0000:04:02.0:   bridge window [mem 0x00000000-0x000f=
ffff]
[    9.296090] pci 0000:04:02.0:   bridge window [mem 0x00000000-0x000f=
ffff 64bit pref]
[    9.296120] pci 0000:04:02.0: enabling Extended Tags
[    9.296378] pci 0000:04:02.0: supports D1 D2
[    9.296381] pci 0000:04:02.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    9.296723] pci 0000:04:02.0: Adding to iommu group 15
[    9.296915] pci 0000:03:00.0: PCI bridge to [bus 04-2c]
[    9.296945] pci 0000:04:02.0: bridge configuration invalid ([bus 00-=
00]), reconfiguring
[    9.297112] pci 0000:05:00.0: [8086:15f0] type 00 class 0x0c0330 PCI=
e Endpoint
[    9.297146] pci 0000:05:00.0: BAR 0 [mem 0x00000000-0x0000ffff]
[    9.297249] pci 0000:05:00.0: enabling Extended Tags
[    9.297479] pci 0000:05:00.0: supports D1 D2
[    9.297481] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    9.297717] pci 0000:05:00.0: 8.000 Gb/s available PCIe bandwidth, l=
imited by 2.5 GT/s PCIe x4 link at 0000:00:07.0 (capable of 31.504 Gb/s=
 with 8.0 GT/s PCIe x4 link)
[    9.297894] pci 0000:05:00.0: Adding to iommu group 16
[    9.298058] pci 0000:04:02.0: PCI bridge to [bus 05-2c]
[    9.298085] pci=5Fbus 0000:05: busn=5Fres: [bus 05-2c] end is update=
d to 05
[    9.298094] pci=5Fbus 0000:04: busn=5Fres: [bus 04-2c] end is update=
d to 05
[    9.298110] pci 0000:03:00.0: bridge window [mem 0x52000000-0x5e1fff=
ff]: assigned
[    9.298113] pci 0000:03:00.0: bridge window [mem 0x6000000000-0x601b=
ffffff 64bit pref]: assigned
[    9.298116] pci 0000:03:00.0: bridge window [io  0x4000-0x4fff]: ass=
igned
[    9.298120] pci 0000:04:02.0: bridge window [mem 0x52000000-0x5e1fff=
ff]: assigned
[    9.298122] pci 0000:04:02.0: bridge window [mem 0x6000000000-0x601b=
ffffff 64bit pref]: assigned
[    9.298125] pci 0000:04:02.0: bridge window [io  0x4000-0x4fff]: ass=
igned
[    9.298127] pci 0000:05:00.0: BAR 0 [mem 0x52000000-0x5200ffff]: ass=
igned
[    9.298135] pci 0000:04:02.0: PCI bridge to [bus 05]
[    9.298139] pci 0000:04:02.0:   bridge window [io  0x4000-0x4fff]
[    9.298148] pci 0000:04:02.0:   bridge window [mem 0x52000000-0x5e1f=
ffff]
[    9.298155] pci 0000:04:02.0:   bridge window [mem 0x6000000000-0x60=
1bffffff 64bit pref]
[    9.298166] pci 0000:03:00.0: PCI bridge to [bus 04-05]
[    9.298170] pci 0000:03:00.0:   bridge window [io  0x4000-0x4fff]
[    9.298179] pci 0000:03:00.0:   bridge window [mem 0x52000000-0x5e1f=
ffff]
[    9.298186] pci 0000:03:00.0:   bridge window [mem 0x6000000000-0x60=
1bffffff 64bit pref]
[    9.298197] pcieport 0000:00:07.0: PCI bridge to [bus 03-2c]
[    9.298200] pcieport 0000:00:07.0:   bridge window [io  0x4000-0x4ff=
f]
[    9.298205] pcieport 0000:00:07.0:   bridge window [mem 0x52000000-0=
x5e1fffff]
[    9.298209] pcieport 0000:00:07.0:   bridge window [mem 0x6000000000=
-0x601bffffff 64bit pref]
[    9.298375] pcieport 0000:03:00.0: enabling device (0000 -> 0003)
[    9.298722] pcieport 0000:04:02.0: enabling device (0000 -> 0003)
[    9.299784] pci 0000:05:00.0: enabling device (0000 -> 0002)
[    9.300388] xhci=5Fhcd 0000:05:00.0: xHCI Host Controller
[    9.300397] xhci=5Fhcd 0000:05:00.0: new USB bus registered, assigne=
d bus number 5
[    9.301802] xhci=5Fhcd 0000:05:00.0: hcc params 0x200077c1 hci versi=
on 0x110 quirks 0x0000000200009810
[    9.302393] xhci=5Fhcd 0000:05:00.0: xHCI Host Controller
[    9.302398] xhci=5Fhcd 0000:05:00.0: new USB bus registered, assigne=
d bus number 6
[    9.302401] xhci=5Fhcd 0000:05:00.0: Host supports USB 3.1 Enhanced =
SuperSpeed
[    9.302459] usb usb5: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002, bcdDevice=3D 6.09
[    9.302462] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    9.302465] usb usb5: Product: xHCI Host Controller
[    9.302466] usb usb5: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
[    9.302468] usb usb5: SerialNumber: 0000:05:00.0
[    9.302783] hub 5-0:1.0: USB hub found
[    9.302794] hub 5-0:1.0: 2 ports detected
[    9.302992] usb usb6: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0003, bcdDevice=3D 6.09
[    9.302995] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    9.302997] usb usb6: Product: xHCI Host Controller
[    9.302998] usb usb6: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
[    9.303000] usb usb6: SerialNumber: 0000:05:00.0
[    9.303557] hub 6-0:1.0: USB hub found
[    9.303567] hub 6-0:1.0: 2 ports detected
[    9.552443] usb 5-1: new high-speed USB device number 2 using xhci=5F=
hcd
[   10.130905] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): DPRX read d=
one
[   10.131029] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): consumed ba=
ndwidth 0/17280 Mb/s
[   10.131047] thunderbolt 0000:00:0d.2: bandwidth consumption changed,=
 re-calculating estimated bandwidth
[   10.131051] thunderbolt 0000:00:0d.2: re-calculating bandwidth estim=
ation for group 1
[   10.131198] thunderbolt 0000:00:0d.2: bandwidth estimation for group=
 1 done
[   10.131206] thunderbolt 0000:00:0d.2: bandwidth re-calculation done
[   10.131212] thunderbolt 0000:00:0d.2: 1: TMU: mode change uni-direct=
ional, LowRes -> uni-directional, HiFi requested
[   10.135515] thunderbolt 0000:00:0d.2: 1: TMU: mode set to: uni-direc=
tional, HiFi
[   10.136473] thunderbolt 0000:00:0d.2: 0:6: DP IN available
[   10.136606] thunderbolt 0000:00:0d.2: 1:10: DP OUT in use
[   10.136610] thunderbolt 0000:00:0d.2: 0:6: no suitable DP OUT adapte=
r available, not tunneling
[   10.136743] thunderbolt 0000:00:0d.2: 1:11: DP OUT resource availabl=
e after hotplug
[   10.136748] thunderbolt 0000:00:0d.2: looking for DP IN <-> DP OUT p=
airs:
[   10.136876] thunderbolt 0000:00:0d.2: 0:5: DP IN in use
[   10.137568] thunderbolt 0000:00:0d.2: 0:6: DP IN available
[   10.137687] thunderbolt 0000:00:0d.2: 1:10: DP OUT in use
[   10.137820] thunderbolt 0000:00:0d.2: 1:11: DP OUT available
[   10.139280] thunderbolt 0000:00:0d.2: 0: allocated DP resource for p=
ort 6
[   10.139286] thunderbolt 0000:00:0d.2: 0:6: attached to bandwidth gro=
up 1
[   10.139694] thunderbolt 0000:00:0d.2: 0:1: link maximum bandwidth 18=
000/18000 Mb/s
[   10.140680] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): DPRX read d=
one
[   10.140829] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): consumed ba=
ndwidth 0/17280 Mb/s
[   10.140963] thunderbolt 0000:00:0d.2: 1:1: link maximum bandwidth 18=
000/18000 Mb/s
[   10.141892] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): DPRX read d=
one
[   10.142027] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): consumed ba=
ndwidth 0/17280 Mb/s
[   10.142033] thunderbolt 0000:00:0d.2: available bandwidth for new DP=
 tunnel 18000/720 Mb/s
[   10.142052] thunderbolt 0000:00:0d.2: 0:6 <-> 1:11 (DP): activating
[   10.143353] thunderbolt 0000:00:0d.2: 0:6 <-> 1:11 (DP): DP IN maxim=
um supported bandwidth 8100 Mb/s x4 =3D 25920 Mb/s
[   10.143360] thunderbolt 0000:00:0d.2: 0:6 <-> 1:11 (DP): DP OUT maxi=
mum supported bandwidth 5400 Mb/s x4 =3D 17280 Mb/s
[   10.143366] thunderbolt 0000:00:0d.2: 0:6 <-> 1:11 (DP): not enough =
bandwidth
[   10.143371] thunderbolt 0000:00:0d.2: 1:11: DP tunnel activation fai=
led, aborting
[   10.143489] thunderbolt 0000:00:0d.2: 0:6: detached from bandwidth g=
roup 1
[   10.144883] thunderbolt 0000:00:0d.2: 0: released DP resource for po=
rt 6
[   14.902955] usb 5-1: unable to get BOS descriptor set
[   14.906143] usb 5-1: New USB device found, idVendor=3D2188, idProduc=
t=3D0610, bcdDevice=3D70.42
[   14.906167] usb 5-1: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[   14.906175] usb 5-1: Product: USB2.1 Hub
[   14.906183] usb 5-1: Manufacturer: CalDigit, Inc.
[   14.908660] hub 5-1:1.0: USB hub found
[   14.909135] hub 5-1:1.0: 4 ports detected
[   15.026182] usb 6-1: new SuperSpeed Plus Gen 2x1 USB device number 2=
 using xhci=5Fhcd
[   15.050199] usb 6-1: New USB device found, idVendor=3D2188, idProduc=
t=3D0625, bcdDevice=3D70.42
[   15.050223] usb 6-1: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[   15.050231] usb 6-1: Product: USB3.1 Gen2 Hub
[   15.050237] usb 6-1: Manufacturer: CalDigit, Inc.
[   15.053712] hub 6-1:1.0: USB hub found
[   15.054279] hub 6-1:1.0: 4 ports detected
[   15.215877] usb 5-1.4: new high-speed USB device number 3 using xhci=
=5Fhcd
[   15.333676] usb 5-1.4: New USB device found, idVendor=3D2188, idProd=
uct=3D0611, bcdDevice=3D93.06
[   15.333703] usb 5-1.4: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[   15.333711] usb 5-1.4: Product: USB2.1 Hub
[   15.333718] usb 5-1.4: Manufacturer: CalDigit, Inc.
[   15.336484] hub 5-1.4:1.0: USB hub found
[   15.336797] hub 5-1.4:1.0: 4 ports detected
[   15.402943] usb 6-1.1: new SuperSpeed USB device number 3 using xhci=
=5Fhcd
[   15.425589] usb 6-1.1: New USB device found, idVendor=3D2188, idProd=
uct=3D0754, bcdDevice=3D 0.06
[   15.425615] usb 6-1.1: New USB device strings: Mfr=3D3, Product=3D4,=
 SerialNumber=3D2
[   15.425623] usb 6-1.1: Product: USB-C Pro Card Reader
[   15.425691] usb 6-1.1: Manufacturer: CalDigit
[   15.425697] usb 6-1.1: SerialNumber: 000000000006
[   15.432231] usb-storage 6-1.1:1.0: USB Mass Storage device detected
[   15.433690] scsi host0: usb-storage 6-1.1:1.0
[   15.506218] usb 6-1.4: new SuperSpeed USB device number 4 using xhci=
=5Fhcd
[   15.528220] usb 6-1.4: New USB device found, idVendor=3D2188, idProd=
uct=3D0620, bcdDevice=3D93.06
[   15.528237] usb 6-1.4: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[   15.528241] usb 6-1.4: Product: USB3.1 Gen1 Hub
[   15.528244] usb 6-1.4: Manufacturer: CalDigit, Inc.
[   15.531198] hub 6-1.4:1.0: USB hub found
[   15.531506] hub 6-1.4:1.0: 4 ports detected
[   15.649217] usb 5-1.4.1: new high-speed USB device number 4 using xh=
ci=5Fhcd
[   15.989548] usb 6-1.4.4: new SuperSpeed USB device number 5 using xh=
ci=5Fhcd
[   16.007996] usb 6-1.4.4: New USB device found, idVendor=3D0bda, idPr=
oduct=3D8153, bcdDevice=3D31.00
[   16.008021] usb 6-1.4.4: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D6
[   16.008029] usb 6-1.4.4: Product: USB 10/100/1000 LAN
[   16.008035] usb 6-1.4.4: Manufacturer: Realtek
[   16.008040] usb 6-1.4.4: SerialNumber: 001001000
[   16.090287] r8152-cfgselector 6-1.4.4: reset SuperSpeed USB device n=
umber 5 using xhci=5Fhcd
[   16.136796] r8152 6-1.4.4:1.0: load rtl8153b-2 v2 04/27/23 successfu=
lly
[   16.171430] r8152 6-1.4.4:1.0 eth0: v1.12.13
[   16.209513] r8152 6-1.4.4:1.0 enp5s0u1u4u4: renamed from eth0
[   16.453330] scsi 0:0:0:0: Direct-Access     CalDigit SD Card Reader =
  0006 PQ: 0 ANSI: 6
[   16.454420] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   16.455908] sd 0:0:0:0: [sda] Media removed, stopped polling
[   16.457173] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   16.497559] usb 5-1.4.1: New USB device found, idVendor=3D2188, idPr=
oduct=3D4042, bcdDevice=3D 0.06
[   16.497567] usb 5-1.4.1: New USB device strings: Mfr=3D3, Product=3D=
1, SerialNumber=3D0
[   16.497570] usb 5-1.4.1: Product: CalDigit USB-C Pro Audio
[   16.497572] usb 5-1.4.1: Manufacturer: CalDigit Inc.
[   16.920216] ucsi=5Facpi USBC000:00: possible UCSI driver bug 1
[   17.494492] input: CalDigit Inc. CalDigit USB-C Pro Audio as /device=
s/pci0000:00/0000:00:07.0/0000:03:00.0/0000:04:02.0/0000:05:00.0/usb5/5=
-1/5-1.4/5-1.4.1/5-1.4.1:1.3/0003:2188:4042.0005/input/input20
[   17.550258] hid-generic 0003:2188:4042.0005: input,hidraw2: USB HID =
v1.11 Device [CalDigit Inc. CalDigit USB-C Pro Audio] on usb-0000:05:00=
.0-1.4.1/input3
[   19.609816] r8152 6-1.4.4:1.0 enp5s0u1u4u4: carrier on
[   39.990148] ACPI BIOS Error (bug): Could not resolve symbol [^^^^NPC=
F.ACBT], AE=5FNOT=5FFOUND (20230628/psargs-330)
[   39.994211] ACPI Error: Aborting method \=5FSB.PC00.LPCB.EC0.=5FQ83 =
due to previous error (AE=5FNOT=5FFOUND) (20230628/psparse-529)


------=_=-_OpenGroupware_org_NGMime-97-1716217960.187497-2--------


