Return-Path: <stable+bounces-47770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ABD8D5C94
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 10:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0712A1F2B0B1
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 08:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348E755C29;
	Fri, 31 May 2024 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="AjKlCYrj"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4264381204;
	Fri, 31 May 2024 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143452; cv=none; b=lrrgEpwfhSbeJl2yuMhVY8MNY78FLaBSRuTIXVuy+mXN+cdCZ4t8E0wjJavo0rIhh+2r0/kWeUL6bHhdYvFDMoYx4oW1FuKlyCLIRCHJoszI7+joYQEWJj4hRKAOFKf/x4OSCJUpso45XnDeC+P2PzUIsYAeXKqo1LpTOa1x88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143452; c=relaxed/simple;
	bh=AyjNBzGyTKoQUWVadHFilnWprst3wrtcfLP0f6rfUoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSrAUDPpeTQOMY6HSE2UmUREuyKTxQt3tD3mEg2P+C7x8udJuOPgbw7ygf5NYjar+deCNEy/5l/5DdDnieq4o/Gze1zXM0k01xz41JkazrBZ9sfcmDq2xZ+qNvevDiYIe+mS/GMRtI/ACIYzJSUiKMNVFLTmOLL/Y6w+/IkhaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=AjKlCYrj; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1717143409; x=1717748209; i=christian@heusel.eu;
	bh=dUqfbiTsQcLGx+6WXbnr8+u4vK9rqwahTN4FmhY8Gyg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AjKlCYrjq+aQ+QED9uh2/nVCkZ5nQnVYQK2mR/Vk3zopAdfLtEZudMYUj2623usm
	 yO7jqF02XZf0HGnioALBpCMfL0/cyj4Y5QeT8iVdiJA3j3GcEV8KrIo5Y3WauEA5G
	 Klw/BBwuYL+rsFDgNEC0QFxQfdd88Ac45rGUlDE/TtsHEROOLUTPAJpVOtWOP5+Bh
	 zqmY7Yc6YvN1gg+sFRGy0bso0TyTN8Pq3/jSsjd2e/KksrgqFAFVC0XeHrcDzEF8u
	 9WxodoueBGEGcDp7Cbe1rwOwwmphXqbGMXDwRxMJNPEF/v0HrhUFAaojkHuy+WRx+
	 ttmNNFRG8kXG2yh3dw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mum6l-1sUlAq3aDb-00rsSh; Fri, 31
 May 2024 10:16:48 +0200
Date: Fri, 31 May 2024 10:16:44 +0200
From: Christian Heusel <christian@heusel.eu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Schneider <pschneider1968@googlemail.com>, 
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, stable@vger.kernel.org, 
	regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology
 detection
Message-ID: <20ec1c1a-b804-408f-b279-853579bffc24@heusel.eu>
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
 <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
 <87r0dj8ls4.ffs@tglx>
 <87o78n8fe2.ffs@tglx>
 <87le3r8dyw.ffs@tglx>
 <4171899b-78cb-4fe2-a0b6-e06844554ed5@heusel.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lxbuttwjsf2jgram"
Content-Disposition: inline
In-Reply-To: <4171899b-78cb-4fe2-a0b6-e06844554ed5@heusel.eu>
X-Provags-ID: V03:K1:TDquRmRpdbiwDt3MHxsfiA062jiSX0t+LoW0OeGETLKXUencKoD
 qPXlSBHHX725e79xTZoe327VhbdGkS8/DSHzv8gSq34jqmj0B3ug4PiHLYLHh8acZCcAzjF
 2KJmTqEQPdRALlN5pgqUhAfmkKZW9sj0NK7iJs3W9G1FhnRmDbP3ufU7PmrJGjTG49oVOyB
 hdJjm8HwilC04fnLuqDSg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C5yGGat5fyw=;QyRWj9o3SyOLgIzTvtygrel3PI7
 znWTXuDUrAUYC46TIcnHMGTXKfk95OOB6dCRL8vbKOaxbnFfV37/kV6e7Ec9SagH/NQ6x6ztn
 eMhBHmfj8PUkEC1jsM3SrKeQqGVQqNYPFplOVmbba/26PVUnoTWF8tENA2VRbMBwm+Q0nr8T3
 p4s/vQsVt1GFjWLewBG/Ug67K2bjgNgvREEn64fM2o9r0vW5cq+0FS8RtzZ6GhOTNo1bWDdEY
 9wMWz3xG+PGY8H7H45DogQQoCYKJXXuBQoyNrvR79vndTKWtTm/iKUqli17rTZ8YvTQTTJeFn
 0V6W63Zl+IYCaXTmfrUY+LwsAugutilcdF1lfSAOerFfuCIRQJ/+xrj/2k7jIH7oBYZguDJqp
 GFSUwEbPMHFDeOwmRDzO2aQeOKp2vt+YHYorRGoEe9nDHJUmH7kYQCwUeQ5owPeiTcMY2tzzp
 t1DjfKsIr+4sSOkisrUXVBygkuCujGn6y49xkQ/9+QPBsd2MfR+HWyfMAVUUj0vEOIHg/qsua
 iE0VogZ+d7dmk9zjy4CemoxKDJzwd3UQdwMiOt48bCGT8a2m0bgM6GpfrGNkYx3qzmSbW66sL
 Vzdn/7hhwQQyImzYUgJjBvK9PpClKTXXjH8+NyuFg3b1q8mlclebfujPLnRFTybjnHB9p98jk
 IYKAnPNkU+mgsucmGO1AYHNQiYnBAOPATKu0gK/xsNAgKH4LDUDX194Zwa73anUsplFqiw9RH
 j29X2G0F4b6efO26oKaCSoS0N2vTSJgozWbcjDE0A/l+MuEZwJg9no=


--lxbuttwjsf2jgram
Content-Type: multipart/mixed; boundary="3jjvrasvvktm7dvp"
Content-Disposition: inline


--3jjvrasvvktm7dvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/05/31 10:13AM, Christian Heusel wrote:
> On 24/05/30 06:24PM, Thomas Gleixner wrote:
> > On Thu, May 30 2024 at 17:53, Thomas Gleixner wrote:
> >
> > > Let me figure out how to fix that sanely.
> >=20
> > The proper fix is obviously to unlock CPUID on Intel _before_ anything
> > which depends on cpuid_level is evaluated.
> >=20
> > Thanks,
> >=20
> >         tglx
>=20
> Hey Thomas,
>=20
> as reported on the other mail the proposed fix broke the build (see
> below) due to get_cpu_cap() becoming static but still being used in
> other parts of the code.
>=20
> One of the reporters in the Arch Bugtracker with an Intel Core i7-7700k
> has tested a modified version of this fix[0] with the static change
> reversed on top of the 6.9.2 stable kernel and reports that the patch
> does not fix the issue for them. I have attached their output for the
> patched (dmesg6.9.2-1.5.log) and nonpatched (dmesg6.9.2-1.log) kernel.
>=20
> Should we also get them to test the mainline version or do you need any
> other debug output?
>=20
> Cheers,
> gromit
>=20
> [0]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/is=
sues/57#note_189079

Now with the logs really attached!

Cheers,
Chris

--3jjvrasvvktm7dvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg6.9.2-1.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.9.2-arch1-1.1 (linux@archlinux) (gcc (GCC) 1=
4.1.1 20240522, GNU ld (GNU Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue, 2=
8 May 2024 18:34:34 +0000
[    0.000000] Command line: ro root=3DUUID=3D9bf7c08f-ded6-4cf7-864f-9eb6b=
26c33ae resume=3DUUID=3D9bf7c08f-ded6-4cf7-864f-9eb6b26c33ae rw add_efi_mem=
map resume_offset=3D2170880 quiet split_lock_detect=3Doff loglevel=3D3 nowa=
tchdog mitigations=3Doff initrd=3D\boot\initramfs-linux.img
[    0.000000] x86/split lock detection: disabled
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000407cdfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000407ce000-0x00000000407cefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000407cf000-0x000000004244dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000004244e000-0x000000004244efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000004244f000-0x0000000071ca8fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000071ca9000-0x000000007544bfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007544c000-0x000000007553dfff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007553e000-0x0000000075619fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007561a000-0x0000000075ffefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000075fff000-0x0000000075ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000076000000-0x0000000079ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007a600000-0x000000007a7fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007ac00000-0x00000000803fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087fbfffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.8 by American Megatrends
[    0.000000] efi: ACPI=3D0x755b6000 ACPI 2.0=3D0x755b6014 TPMFinalLog=3D0=
x75585000 SMBIOS=3D0x75dae000 SMBIOS 3.0=3D0x75dad000 MEMATTR=3D0x6ecf8198 =
ESRT=3D0x6ef4a398 INITRD=3D0x6599fd98 RNG=3D0x7548a018 TPMEventLog=3D0x6660=
3018=20
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem110: MMIO range=3D[0xc0000000-0xcfffffff] (25=
6MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] efi: Not removing mem111: MMIO range=3D[0xfe000000-0xfe010ff=
f] (68KB) from e820 map
[    0.000000] efi: Not removing mem112: MMIO range=3D[0xfec00000-0xfec00ff=
f] (4KB) from e820 map
[    0.000000] efi: Not removing mem113: MMIO range=3D[0xfed00000-0xfed00ff=
f] (4KB) from e820 map
[    0.000000] efi: Not removing mem115: MMIO range=3D[0xfee00000-0xfee00ff=
f] (4KB) from e820 map
[    0.000000] efi: Remove mem116: MMIO range=3D[0xff000000-0xffffffff] (16=
MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.5.0 present.
[    0.000000] DMI: Default string Default string/Default string, BIOS GLX2=
58-A V0.0.5 07/23/2022
[    0.000000] tsc: Detected 2600.000 MHz processor
[    0.000000] tsc: Detected 2611.200 MHz TSC
[    0.000418] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000419] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000426] last_pfn =3D 0x87fc00 max_arch_pfn =3D 0x400000000
[    0.000428] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built fr=
om 10 variable MTRRs
[    0.000430] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.000764] last_pfn =3D 0x76000 max_arch_pfn =3D 0x400000000
[    0.009845] esrt: Reserving ESRT space from 0x000000006ef4a398 to 0x0000=
00006ef4a3d0.
[    0.009849] e820: update [mem 0x6ef4a000-0x6ef4afff] usable =3D=3D> rese=
rved
[    0.009862] Using GB pages for direct mapping
[    0.009863] Incomplete global flushes, disabling PCID
[    0.010183] Secure boot enabled
[    0.010183] RAMDISK: [mem 0x61b11000-0x62ceffff]
[    0.010211] ACPI: Early table checksum verification disabled
[    0.010213] ACPI: RSDP 0x00000000755B6014 000024 (v02 ALASKA)
[    0.010217] ACPI: XSDT 0x00000000755B5728 000104 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010221] ACPI: FACP 0x0000000075534000 000114 (v06 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010225] ACPI: DSDT 0x00000000754BF000 074A9A (v02 ALASKA A M I    01=
072009 INTL 20200717)
[    0.010227] ACPI: FACS 0x0000000075619000 000040
[    0.010229] ACPI: SSDT 0x0000000075535000 006C41 (v02 DptfTb DptfTabl 00=
001000 INTL 20200717)
[    0.010231] ACPI: FIDT 0x00000000754BE000 00009C (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.010233] ACPI: SSDT 0x000000007553D000 00038C (v02 PmaxDv Pmax_Dev 00=
000001 INTL 20200717)
[    0.010235] ACPI: SSDT 0x00000000754B8000 005D0B (v02 CpuRef CpuSsdt  00=
003000 INTL 20200717)
[    0.010237] ACPI: SSDT 0x00000000754B5000 002AA1 (v02 SaSsdt SaSsdt   00=
003000 INTL 20200717)
[    0.010239] ACPI: SSDT 0x00000000754B1000 0033D3 (v02 INTEL  IgfxSsdt 00=
003000 INTL 20200717)
[    0.010240] ACPI: HPET 0x000000007553C000 000038 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010242] ACPI: APIC 0x00000000754B0000 0001DC (v05 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010244] ACPI: MCFG 0x00000000754AF000 00003C (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010246] ACPI: SSDT 0x00000000754A6000 008384 (v02 ALASKA AdlP_Rvp 00=
001000 INTL 20200717)
[    0.010248] ACPI: SSDT 0x00000000754A4000 0019D1 (v02 ALASKA Ther_Rvp 00=
001000 INTL 20200717)
[    0.010250] ACPI: UEFI 0x000000007556C000 000048 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010251] ACPI: NHLT 0x00000000754A3000 00002D (v00 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010253] ACPI: LPIT 0x00000000754A2000 0000CC (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010255] ACPI: SSDT 0x000000007549E000 002A83 (v02 ALASKA PtidDevc 00=
001000 INTL 20200717)
[    0.010257] ACPI: SSDT 0x000000007549B000 002357 (v02 ALASKA TbtTypeC 00=
000000 INTL 20200717)
[    0.010259] ACPI: DBGP 0x000000007549A000 000034 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010260] ACPI: DBG2 0x0000000075499000 00005C (v00 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010262] ACPI: SSDT 0x0000000075498000 00078E (v02 INTEL  xh_adlLP 00=
000000 INTL 20200717)
[    0.010264] ACPI: SSDT 0x0000000075494000 003AEA (v02 SocGpe SocGpe   00=
003000 INTL 20200717)
[    0.010266] ACPI: SSDT 0x0000000075490000 0039DA (v02 SocCmn SocCmn   00=
003000 INTL 20200717)
[    0.010268] ACPI: SSDT 0x000000007548F000 000144 (v02 Intel  ADebTabl 00=
001000 INTL 20200717)
[    0.010270] ACPI: BGRT 0x000000007548E000 000038 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.010271] ACPI: TPM2 0x000000007548D000 00004C (v04 ALASKA A M I    00=
000001 AMI  00000000)
[    0.010273] ACPI: PHAT 0x000000007548C000 0004EA (v01 ALASKA A M I    00=
000005 MSFT 0100000D)
[    0.010275] ACPI: WSMT 0x00000000754A1000 000028 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.010277] ACPI: FPDT 0x000000007548B000 000044 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010279] ACPI: Reserving FACP table memory at [mem 0x75534000-0x75534=
113]
[    0.010280] ACPI: Reserving DSDT table memory at [mem 0x754bf000-0x75533=
a99]
[    0.010280] ACPI: Reserving FACS table memory at [mem 0x75619000-0x75619=
03f]
[    0.010281] ACPI: Reserving SSDT table memory at [mem 0x75535000-0x7553b=
c40]
[    0.010281] ACPI: Reserving FIDT table memory at [mem 0x754be000-0x754be=
09b]
[    0.010282] ACPI: Reserving SSDT table memory at [mem 0x7553d000-0x7553d=
38b]
[    0.010282] ACPI: Reserving SSDT table memory at [mem 0x754b8000-0x754bd=
d0a]
[    0.010283] ACPI: Reserving SSDT table memory at [mem 0x754b5000-0x754b7=
aa0]
[    0.010283] ACPI: Reserving SSDT table memory at [mem 0x754b1000-0x754b4=
3d2]
[    0.010284] ACPI: Reserving HPET table memory at [mem 0x7553c000-0x7553c=
037]
[    0.010284] ACPI: Reserving APIC table memory at [mem 0x754b0000-0x754b0=
1db]
[    0.010285] ACPI: Reserving MCFG table memory at [mem 0x754af000-0x754af=
03b]
[    0.010285] ACPI: Reserving SSDT table memory at [mem 0x754a6000-0x754ae=
383]
[    0.010286] ACPI: Reserving SSDT table memory at [mem 0x754a4000-0x754a5=
9d0]
[    0.010286] ACPI: Reserving UEFI table memory at [mem 0x7556c000-0x7556c=
047]
[    0.010287] ACPI: Reserving NHLT table memory at [mem 0x754a3000-0x754a3=
02c]
[    0.010287] ACPI: Reserving LPIT table memory at [mem 0x754a2000-0x754a2=
0cb]
[    0.010288] ACPI: Reserving SSDT table memory at [mem 0x7549e000-0x754a0=
a82]
[    0.010288] ACPI: Reserving SSDT table memory at [mem 0x7549b000-0x7549d=
356]
[    0.010289] ACPI: Reserving DBGP table memory at [mem 0x7549a000-0x7549a=
033]
[    0.010289] ACPI: Reserving DBG2 table memory at [mem 0x75499000-0x75499=
05b]
[    0.010290] ACPI: Reserving SSDT table memory at [mem 0x75498000-0x75498=
78d]
[    0.010290] ACPI: Reserving SSDT table memory at [mem 0x75494000-0x75497=
ae9]
[    0.010290] ACPI: Reserving SSDT table memory at [mem 0x75490000-0x75493=
9d9]
[    0.010291] ACPI: Reserving SSDT table memory at [mem 0x7548f000-0x7548f=
143]
[    0.010291] ACPI: Reserving BGRT table memory at [mem 0x7548e000-0x7548e=
037]
[    0.010292] ACPI: Reserving TPM2 table memory at [mem 0x7548d000-0x7548d=
04b]
[    0.010292] ACPI: Reserving PHAT table memory at [mem 0x7548c000-0x7548c=
4e9]
[    0.010293] ACPI: Reserving WSMT table memory at [mem 0x754a1000-0x754a1=
027]
[    0.010293] ACPI: Reserving FPDT table memory at [mem 0x7548b000-0x7548b=
043]
[    0.010420] No NUMA configuration found
[    0.010420] Faking a node at [mem 0x0000000000000000-0x000000087fbfffff]
[    0.010422] NODE_DATA(0) allocated [mem 0x87fbfb000-0x87fbfffff]
[    0.010451] Zone ranges:
[    0.010452]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.010453]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.010454]   Normal   [mem 0x0000000100000000-0x000000087fbfffff]
[    0.010455]   Device   empty
[    0.010455] Movable zone start for each node
[    0.010456] Early memory node ranges
[    0.010456]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.010457]   node   0: [mem 0x000000000009f000-0x000000000009ffff]
[    0.010457]   node   0: [mem 0x0000000000100000-0x00000000407cdfff]
[    0.010458]   node   0: [mem 0x00000000407cf000-0x000000004244dfff]
[    0.010458]   node   0: [mem 0x000000004244f000-0x0000000071ca8fff]
[    0.010459]   node   0: [mem 0x0000000075fff000-0x0000000075ffffff]
[    0.010459]   node   0: [mem 0x0000000100000000-0x000000087fbfffff]
[    0.010461] Initmem setup node 0 [mem 0x0000000000001000-0x000000087fbff=
fff]
[    0.010464] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.010465] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.010482] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.011697] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.012532] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.012626] On node 0, zone DMA32: 17238 pages in unavailable ranges
[    0.044880] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.044886] On node 0, zone Normal: 1024 pages in unavailable ranges
[    0.044905] Reserving Intel graphics memory at [mem 0x7c800000-0x803ffff=
f]
[    0.046058] ACPI: PM-Timer IO Port: 0x1808
[    0.046064] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.046065] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.046066] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.046066] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.046066] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.046067] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.046067] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.046068] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.046068] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.046068] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.046069] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.046069] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.046069] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.046070] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.046070] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.046070] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.046071] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.046071] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.046072] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.046072] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.046072] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.046073] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.046073] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.046074] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.046108] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.046109] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.046111] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.046113] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.046114] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.046119] e820: update [mem 0x6e4b1000-0x6e503fff] usable =3D=3D> rese=
rved
[    0.046127] TSC deadline timer available
[    0.046129] CPU topo: Max. logical packages:   1
[    0.046129] CPU topo: Max. logical dies:       1
[    0.046129] CPU topo: Max. dies per package:   1
[    0.046131] CPU topo: Max. threads per core:   2
[    0.046132] CPU topo: Num. cores per package:    10
[    0.046132] CPU topo: Num. threads per package:  12
[    0.046132] CPU topo: Allowing 12 present CPUs plus 0 hotplug CPUs
[    0.046145] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.046147] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0=
x0009efff]
[    0.046148] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000fffff]
[    0.046149] PM: hibernation: Registered nosave memory: [mem 0x407ce000-0=
x407cefff]
[    0.046150] PM: hibernation: Registered nosave memory: [mem 0x4244e000-0=
x4244efff]
[    0.046151] PM: hibernation: Registered nosave memory: [mem 0x6e4b1000-0=
x6e503fff]
[    0.046152] PM: hibernation: Registered nosave memory: [mem 0x6ef4a000-0=
x6ef4afff]
[    0.046152] PM: hibernation: Registered nosave memory: [mem 0x71ca9000-0=
x7544bfff]
[    0.046153] PM: hibernation: Registered nosave memory: [mem 0x7544c000-0=
x7553dfff]
[    0.046153] PM: hibernation: Registered nosave memory: [mem 0x7553e000-0=
x75619fff]
[    0.046154] PM: hibernation: Registered nosave memory: [mem 0x7561a000-0=
x75ffefff]
[    0.046155] PM: hibernation: Registered nosave memory: [mem 0x76000000-0=
x79ffffff]
[    0.046155] PM: hibernation: Registered nosave memory: [mem 0x7a000000-0=
x7a5fffff]
[    0.046155] PM: hibernation: Registered nosave memory: [mem 0x7a600000-0=
x7a7fffff]
[    0.046156] PM: hibernation: Registered nosave memory: [mem 0x7a800000-0=
x7abfffff]
[    0.046156] PM: hibernation: Registered nosave memory: [mem 0x7ac00000-0=
x803fffff]
[    0.046156] PM: hibernation: Registered nosave memory: [mem 0x80400000-0=
xfdffffff]
[    0.046157] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.046157] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.046157] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.046158] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfecfffff]
[    0.046158] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0=
xfed00fff]
[    0.046159] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0=
xfed1ffff]
[    0.046159] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0=
xfed7ffff]
[    0.046159] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0=
xfedfffff]
[    0.046160] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.046160] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.046161] [mem 0x80400000-0xfdffffff] available for PCI devices
[    0.046162] Booting paravirtualized kernel on bare hardware
[    0.046163] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.050125] setup_percpu: NR_CPUS:320 nr_cpumask_bits:12 nr_cpu_ids:12 n=
r_node_ids:1
[    0.050601] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.050605] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=3D1*2097152
[    0.050606] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07=20
[    0.050609] pcpu-alloc: [0] 08 09 10 11=20
[    0.050620] Kernel command line: ro root=3DUUID=3D9bf7c08f-ded6-4cf7-864=
f-9eb6b26c33ae resume=3DUUID=3D9bf7c08f-ded6-4cf7-864f-9eb6b26c33ae rw add_=
efi_memmap resume_offset=3D2170880 quiet split_lock_detect=3Doff loglevel=
=3D3 nowatchdog mitigations=3Doff initrd=3D\boot\initramfs-linux.img
[    0.050684] Unknown kernel command line parameters "split_lock_detect=3D=
off", will be passed to user space.
[    0.052642] Dentry cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes, linear)
[    0.053623] Inode-cache hash table entries: 2097152 (order: 12, 16777216=
 bytes, linear)
[    0.053709] Fallback order for Node 0: 0=20
[    0.053711] Built 1 zonelists, mobility grouping on.  Total pages: 81989=
81
[    0.053712] Policy zone: Normal
[    0.053857] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.053861] software IO TLB: area num 16.
[    0.100359] Memory: 32446256K/33317144K available (18432K kernel code, 2=
164K rwdata, 13296K rodata, 3412K init, 3624K bss, 870628K reserved, 0K cma=
-reserved)
[    0.100485] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D12, =
Nodes=3D1
[    0.100513] ftrace: allocating 49852 entries in 195 pages
[    0.104788] ftrace: allocated 195 pages with 4 groups
[    0.104838] Dynamic Preempt: full
[    0.104873] rcu: Preemptible hierarchical RCU implementation.
[    0.104874] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D12.
[    0.104875] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.104875] 	Trampoline variant of Tasks RCU enabled.
[    0.104876] 	Rude variant of Tasks RCU enabled.
[    0.104876] 	Tracing variant of Tasks RCU enabled.
[    0.104877] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.104877] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D12
[    0.104881] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjus=
t=3D1.
[    0.104883] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_=
adjust=3D1.
[    0.104884] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb=
_adjust=3D1.
[    0.107196] NR_IRQS: 20736, nr_irqs: 2152, preallocated irqs: 16
[    0.107477] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.107694] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.107715] Console: colour dummy device 80x25
[    0.107717] printk: legacy console [tty0] enabled
[    0.107742] ACPI: Core revision 20230628
[    0.107938] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.107939] APIC: Switch to symmetric I/O mode setup
[    0.109251] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.109591] APIC: Switched APIC routing to: physical flat
[    0.113971] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x25a39079a08, max_idle_ns: 440795310461 ns
[    0.113977] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 5224.00 BogoMIPS (lpj=3D8704000)
[    0.114043] CPU0: Thermal monitoring enabled (TM1)
[    0.114044] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.114137] CET detected: Indirect Branch Tracking enabled
[    0.114139] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.114139] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.114142] process: using mwait in idle threads
[    0.114144] Spectre V2 : User space: Vulnerable
[    0.114145] Speculative Store Bypass: Vulnerable
[    0.114155] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.114156] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.114157] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.114157] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'
[    0.114158] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User =
registers'
[    0.114158] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.114159] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.114160] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.114160] x86/fpu: Enabled xstate features 0xa07, context size is 856 =
bytes, using 'compacted' format.
[    0.117308] Freeing SMP alternatives memory: 40K
[    0.117308] pid_max: default: 32768 minimum: 301
[    0.117308] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.117308] landlock: Up and running.
[    0.117308] Yama: becoming mindful.
[    0.117308] LSM support for eBPF active
[    0.117308] Mount-cache hash table entries: 65536 (order: 7, 524288 byte=
s, linear)
[    0.117308] Mountpoint-cache hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
[    0.117308] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1255U (family: =
0x6, model: 0x9a, stepping: 0x4)
[    0.117308] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-base=
line,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-wid=
th counters, Intel PMU driver.
[    0.117308] core: cpu_core PMU driver:=20
[    0.117308] ... version:                5
[    0.117308] ... bit width:              48
[    0.117308] ... generic registers:      8
[    0.117308] ... value mask:             0000ffffffffffff
[    0.117308] ... max period:             00007fffffffffff
[    0.117308] ... fixed-purpose events:   4
[    0.117308] ... event mask:             0001000f000000ff
[    0.117308] signal: max sigframe size: 3632
[    0.117308] Estimated ratio of average max frequency by base frequency (=
times 1024): 1614
[    0.117308] rcu: Hierarchical SRCU implementation.
[    0.117308] rcu: 	Max phase no-delay instances is 1000.
[    0.117308] smp: Bringing up secondary CPUs ...
[    0.117308] smpboot: x86: Booting SMP configuration:
[    0.117308] .... node  #0, CPUs:        #2  #4  #5  #6  #7  #8  #9 #10 #=
11
[    0.009676] [Firmware Bug]: CPU4: Topology domain 1 shift 7 !=3D 6
[    0.009676] core: cpu_atom PMU driver: PEBS-via-PT=20
[    0.009676] ... version:                5
[    0.009676] ... bit width:              48
[    0.009676] ... generic registers:      6
[    0.009676] ... value mask:             0000ffffffffffff
[    0.009676] ... max period:             00007fffffffffff
[    0.009676] ... fixed-purpose events:   3
[    0.009676] ... event mask:             000000070000003f
[    0.120712]   #1  #3
[    0.121858] smp: Brought up 1 node, 12 CPUs
[    0.121858] smpboot: Total of 12 processors activated (62693.00 BogoMIPS)
[    0.124639] devtmpfs: initialized
[    0.124639] x86/mm: Memory block size: 128MB
[    0.125126] ACPI: PM: Registering ACPI NVS region [mem 0x7553e000-0x7561=
9fff] (901120 bytes)
[    0.125126] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.125126] futex hash table entries: 4096 (order: 6, 262144 bytes, line=
ar)
[    0.125126] pinctrl core: initialized pinctrl subsystem
[    0.125126] PM: RTC time: 05:40:00, date: 2024-05-31
[    0.125126] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.125126] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.125138] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.127430] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.127435] audit: initializing netlink subsys (disabled)
[    0.127438] audit: type=3D2000 audit(1717134000.013:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.127438] thermal_sys: Registered thermal governor 'fair_share'
[    0.127438] thermal_sys: Registered thermal governor 'bang_bang'
[    0.127438] thermal_sys: Registered thermal governor 'step_wise'
[    0.127438] thermal_sys: Registered thermal governor 'user_space'
[    0.127438] thermal_sys: Registered thermal governor 'power_allocator'
[    0.127438] cpuidle: using governor ladder
[    0.127438] cpuidle: using governor menu
[    0.127438] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.127438] PCI: ECAM [mem 0xc0000000-0xcfffffff] (base 0xc0000000) for =
domain 0000 [bus 00-ff]
[    0.127438] PCI: not using ECAM ([mem 0xc0000000-0xcfffffff] not reserve=
d)
[    0.127438] PCI: Using configuration type 1 for base access
[    0.127454] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.127457] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.127457] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.127457] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.127457] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.131606] Demotion targets for Node 0: null
[    0.131606] ACPI: Added _OSI(Module Device)
[    0.131606] ACPI: Added _OSI(Processor Device)
[    0.131606] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.131606] ACPI: Added _OSI(Processor Aggregator Device)
[    0.203801] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.T=
XHC.RHUB.SS01], AE_NOT_FOUND (20230628/dswload2-162)
[    0.203807] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (202306=
28/psobject-220)
[    0.203809] ACPI: Skipping parse of AML opcode: Scope (0x0010)
[    0.203812] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.T=
XHC.RHUB.SS02], AE_NOT_FOUND (20230628/dswload2-162)
[    0.203814] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (202306=
28/psobject-220)
[    0.203815] ACPI: Skipping parse of AML opcode: Scope (0x0010)
[    0.203818] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.T=
XHC.RHUB.SS03], AE_NOT_FOUND (20230628/dswload2-162)
[    0.203820] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (202306=
28/psobject-220)
[    0.203821] ACPI: Skipping parse of AML opcode: Scope (0x0010)
[    0.203823] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.T=
XHC.RHUB.SS04], AE_NOT_FOUND (20230628/dswload2-162)
[    0.203825] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (202306=
28/psobject-220)
[    0.203826] ACPI: Skipping parse of AML opcode: Scope (0x0010)
[    0.205496] ACPI: 14 ACPI AML tables successfully acquired and loaded
[    0.220046] ACPI: Dynamic OEM Table Load:
[    0.220053] ACPI: SSDT 0xFFFF89BE40D9A800 000394 (v02 PmRef  Cpu0Cst  00=
003001 INTL 20200717)
[    0.220986] ACPI: Dynamic OEM Table Load:
[    0.220990] ACPI: SSDT 0xFFFF89BE413C3000 000605 (v02 PmRef  Cpu0Ist  00=
003000 INTL 20200717)
[    0.221947] ACPI: Dynamic OEM Table Load:
[    0.221951] ACPI: SSDT 0xFFFF89BE41284E00 0001AB (v02 PmRef  Cpu0Psd  00=
003000 INTL 20200717)
[    0.222822] ACPI: Dynamic OEM Table Load:
[    0.222826] ACPI: SSDT 0xFFFF89BE413C3800 0004BA (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20200717)
[    0.224057] ACPI: Dynamic OEM Table Load:
[    0.224064] ACPI: SSDT 0xFFFF89BE413CA000 001BAF (v02 PmRef  ApIst    00=
003000 INTL 20200717)
[    0.225643] ACPI: Dynamic OEM Table Load:
[    0.225649] ACPI: SSDT 0xFFFF89BE413C8000 001038 (v02 PmRef  ApHwp    00=
003000 INTL 20200717)
[    0.227003] ACPI: Dynamic OEM Table Load:
[    0.227009] ACPI: SSDT 0xFFFF89BE413CC000 001349 (v02 PmRef  ApPsd    00=
003000 INTL 20200717)
[    0.228430] ACPI: Dynamic OEM Table Load:
[    0.228435] ACPI: SSDT 0xFFFF89BE40D91000 000FBB (v02 PmRef  ApCst    00=
003000 INTL 20200717)
[    0.233196] ACPI: _OSC evaluated successfully for all CPUs
[    0.233241] ACPI: EC: EC started
[    0.233242] ACPI: EC: interrupt blocked
[    0.252314] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.252316] ACPI: \_SB_.PC00.LPCB.H_EC: Boot DSDT EC used to handle tran=
sactions
[    0.252317] ACPI: Interpreter enabled
[    0.252360] ACPI: PM: (supports S0 S3 S4 S5)
[    0.252361] ACPI: Using IOAPIC for interrupt routing
[    0.253479] PCI: ECAM [mem 0xc0000000-0xcfffffff] (base 0xc0000000) for =
domain 0000 [bus 00-ff]
[    0.255322] PCI: ECAM [mem 0xc0000000-0xcfffffff] reserved as ACPI mothe=
rboard resource
[    0.255331] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.255332] PCI: Using E820 reservations for host bridge windows
[    0.256776] ACPI: Enabled 7 GPEs in block 00 to 7F
[    0.257591] ACPI: \_SB_.PC00.PEG1.PXP_: New power resource
[    0.258153] ACPI: \_SB_.PC00.PEG2.PXP_: New power resource
[    0.259347] ACPI: \_SB_.PC00.PEG0.PXP_: New power resource
[    0.389396] ACPI: \_SB_.PC00.RP05.PXP_: New power resource
[    0.398137] ACPI: \_SB_.PC00.PAUD: New power resource
[    0.407338] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    0.419340] ACPI: \PIN_: New power resource
[    0.419600] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-fe])
[    0.419605] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.421319] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR DPC]
[    0.422742] PCI host bridge to bus 0000:00
[    0.422744] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.422746] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.422747] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.422749] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000ffff=
f window]
[    0.422750] pci_bus 0000:00: root bus resource [mem 0x80400000-0xbffffff=
f window]
[    0.422751] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7ffff=
fffff window]
[    0.422752] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.422926] pci 0000:00:00.0: [8086:4601] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.423054] pci 0000:00:02.0: [8086:46a8] type 00 class 0x030000 PCIe Ro=
ot Complex Integrated Endpoint
[    0.423062] pci 0000:00:02.0: BAR 0 [mem 0x6001000000-0x6001ffffff 64bit]
[    0.423067] pci 0000:00:02.0: BAR 2 [mem 0x4000000000-0x400fffffff 64bit=
 pref]
[    0.423071] pci 0000:00:02.0: BAR 4 [io  0x4000-0x403f]
[    0.423085] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.423087] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.423111] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x00ffffff 64bit]
[    0.423112] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x06ffffff 64bit]=
: contains BAR 0 for 7 VFs
[    0.423116] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit =
pref]
[    0.423117] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit =
pref]: contains BAR 2 for 7 VFs
[    0.423243] pci 0000:00:04.0: [8086:461d] type 00 class 0x118000 convent=
ional PCI endpoint
[    0.423255] pci 0000:00:04.0: BAR 0 [mem 0x6002100000-0x600211ffff 64bit]
[    0.423603] pci 0000:00:06.0: [8086:464d] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.423633] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.423640] pci 0000:00:06.0:   bridge window [mem 0x80500000-0x805fffff]
[    0.423724] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.423761] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    0.424392] pci 0000:00:14.0: [8086:51ed] type 00 class 0x0c0330 convent=
ional PCI endpoint
[    0.424415] pci 0000:00:14.0: BAR 0 [mem 0x6002120000-0x600212ffff 64bit]
[    0.424499] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.426276] pci 0000:00:14.2: [8086:51ef] type 00 class 0x050000 convent=
ional PCI endpoint
[    0.426296] pci 0000:00:14.2: BAR 0 [mem 0x6002134000-0x6002137fff 64bit]
[    0.426309] pci 0000:00:14.2: BAR 2 [mem 0x600213b000-0x600213bfff 64bit]
[    0.426426] pci 0000:00:15.0: [8086:51e8] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.426448] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.426820] pci 0000:00:16.0: [8086:51e0] type 00 class 0x078000 convent=
ional PCI endpoint
[    0.426843] pci 0000:00:16.0: BAR 0 [mem 0x6002139000-0x6002139fff 64bit]
[    0.426930] pci 0000:00:16.0: PME# supported from D3hot
[    0.427231] pci 0000:00:17.0: [8086:51d3] type 00 class 0x010601 convent=
ional PCI endpoint
[    0.427247] pci 0000:00:17.0: BAR 0 [mem 0x80600000-0x80601fff]
[    0.427256] pci 0000:00:17.0: BAR 1 [mem 0x80603000-0x806030ff]
[    0.427265] pci 0000:00:17.0: BAR 2 [io  0x4090-0x4097]
[    0.427274] pci 0000:00:17.0: BAR 3 [io  0x4080-0x4083]
[    0.427283] pci 0000:00:17.0: BAR 4 [io  0x4060-0x407f]
[    0.427291] pci 0000:00:17.0: BAR 5 [mem 0x80602000-0x806027ff]
[    0.427339] pci 0000:00:17.0: PME# supported from D3hot
[    0.427632] pci 0000:00:1d.0: [8086:51b0] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.427659] pci 0000:00:1d.0: PCI bridge to [bus 02]
[    0.427665] pci 0000:00:1d.0:   bridge window [mem 0x80400000-0x804fffff]
[    0.427746] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.427777] pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
[    0.428327] pci 0000:00:1d.1: [8086:51b1] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.428354] pci 0000:00:1d.1: PCI bridge to [bus 03]
[    0.428358] pci 0000:00:1d.1:   bridge window [io  0x3000-0x3fff]
[    0.428369] pci 0000:00:1d.1:   bridge window [mem 0x6000000000-0x60000f=
ffff 64bit pref]
[    0.428440] pci 0000:00:1d.1: PME# supported from D0 D3hot D3cold
[    0.428471] pci 0000:00:1d.1: PTM enabled (root), 4ns granularity
[    0.429046] pci 0000:00:1f.0: [8086:5182] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.429436] pci 0000:00:1f.3: [8086:51c8] type 00 class 0x040100 convent=
ional PCI endpoint
[    0.429477] pci 0000:00:1f.3: BAR 0 [mem 0x6002130000-0x6002133fff 64bit]
[    0.429531] pci 0000:00:1f.3: BAR 4 [mem 0x6002000000-0x60020fffff 64bit]
[    0.429636] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.429937] pci 0000:00:1f.4: [8086:51a3] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.429958] pci 0000:00:1f.4: BAR 0 [mem 0x6002138000-0x60021380ff 64bit]
[    0.429980] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.430262] pci 0000:00:1f.5: [8086:51a4] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.430281] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.433998] pci 0000:01:00.0: [1987:5013] type 00 class 0x010802 PCIe En=
dpoint
[    0.434014] pci 0000:01:00.0: BAR 0 [mem 0x80500000-0x80503fff 64bit]
[    0.434940] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.435189] pci 0000:02:00.0: [8086:095a] type 00 class 0x028000 PCIe En=
dpoint
[    0.435276] pci 0000:02:00.0: BAR 0 [mem 0x80400000-0x80401fff 64bit]
[    0.435621] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.436601] pci 0000:00:1d.0: PCI bridge to [bus 02]
[    0.436671] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000 PCIe En=
dpoint
[    0.436690] pci 0000:03:00.0: BAR 0 [io  0x3000-0x30ff]
[    0.436713] pci 0000:03:00.0: BAR 2 [mem 0x6000004000-0x6000004fff 64bit=
 pref]
[    0.436729] pci 0000:03:00.0: BAR 4 [mem 0x6000000000-0x6000003fff 64bit=
 pref]
[    0.436841] pci 0000:03:00.0: supports D1 D2
[    0.436841] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.437009] pci 0000:00:1d.1: PCI bridge to [bus 03]
[    0.441053] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.441142] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.441228] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.441315] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.441402] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.441488] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.441574] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.441661] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.449100] ACPI: EC: interrupt unblocked
[    0.449101] ACPI: EC: event unblocked
[    0.449122] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.449123] ACPI: EC: GPE=3D0x6e
[    0.449124] ACPI: \_SB_.PC00.LPCB.H_EC: Boot DSDT EC initialization comp=
lete
[    0.449126] ACPI: \_SB_.PC00.LPCB.H_EC: EC: Used to handle transactions =
and events
[    0.449185] iommu: Default domain type: Translated
[    0.449185] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.449185] SCSI subsystem initialized
[    0.449185] libata version 3.00 loaded.
[    0.449185] ACPI: bus type USB registered
[    0.449185] usbcore: registered new interface driver usbfs
[    0.449185] usbcore: registered new interface driver hub
[    0.449185] usbcore: registered new device driver usb
[    0.449185] EDAC MC: Ver: 3.0.0
[    0.450708] efivars: Registered efivars operations
[    0.450824] NetLabel: Initializing
[    0.450825] NetLabel:  domain hash size =3D 128
[    0.450826] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.450840] NetLabel:  unlabeled traffic allowed by default
[    0.450844] mctp: management component transport protocol core
[    0.450845] NET: Registered PF_MCTP protocol family
[    0.450847] PCI: Using ACPI for IRQ routing
[    0.470601] PCI: pci_cache_line_size set to 64 bytes
[    0.474172] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can't c=
laim; no compatible bridge window
[    0.475089] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.475090] e820: reserve RAM buffer [mem 0x407ce000-0x43ffffff]
[    0.475091] e820: reserve RAM buffer [mem 0x4244e000-0x43ffffff]
[    0.475092] e820: reserve RAM buffer [mem 0x6e4b1000-0x6fffffff]
[    0.475093] e820: reserve RAM buffer [mem 0x6ef4a000-0x6fffffff]
[    0.475093] e820: reserve RAM buffer [mem 0x71ca9000-0x73ffffff]
[    0.475094] e820: reserve RAM buffer [mem 0x76000000-0x77ffffff]
[    0.475095] e820: reserve RAM buffer [mem 0x87fc00000-0x87fffffff]
[    0.475120] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.475120] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.475120] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    0.475120] vgaarb: loaded
[    0.475120] clocksource: Switched to clocksource tsc-early
[    0.475120] VFS: Disk quotas dquot_6.6.0
[    0.475120] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.475120] pnp: PnP ACPI init
[    0.475801] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.475803] system 00:00: [io  0x164e-0x164f] has been reserved
[    0.475907] system 00:01: [io  0x1854-0x1857] has been reserved
[    0.477695] pnp 00:02: disabling [mem 0xc0000000-0xcfffffff] because it =
overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.477714] system 00:02: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.477716] system 00:02: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.477717] system 00:02: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.477719] system 00:02: [mem 0xfed20000-0xfed7ffff] could not be reser=
ved
[    0.477720] system 00:02: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.477721] system 00:02: [mem 0xfed45000-0xfed8ffff] could not be reser=
ved
[    0.477722] system 00:02: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    0.478428] system 00:04: [io  0x2000-0x20fe] has been reserved
[    0.478822] system 00:05: [mem 0xfe03e008-0xfe03efff] has been reserved
[    0.478824] system 00:05: [mem 0xfe03f000-0xfe03ffff] has been reserved
[    0.479189] pnp: PnP ACPI: found 6 devices
[    0.484501] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.484571] NET: Registered PF_INET protocol family
[    0.484736] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.495851] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6=
, 262144 bytes, linear)
[    0.495880] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.496017] TCP established hash table entries: 262144 (order: 9, 209715=
2 bytes, linear)
[    0.496335] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.496448] TCP: Hash tables configured (established 262144 bind 65536)
[    0.496562] MPTCP token hash table entries: 32768 (order: 7, 786432 byte=
s, linear)
[    0.496627] UDP hash table entries: 16384 (order: 7, 524288 bytes, linea=
r)
[    0.496696] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, =
linear)
[    0.496766] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.496772] NET: Registered PF_XDP protocol family
[    0.496786] pci 0000:00:02.0: VF BAR 2 [mem 0x4020000000-0x40ffffffff 64=
bit pref]: assigned
[    0.496791] pci 0000:00:02.0: VF BAR 0 [mem 0x4010000000-0x4016ffffff 64=
bit]: assigned
[    0.496793] pci 0000:00:15.0: BAR 0 [mem 0x4017000000-0x4017000fff 64bit=
]: assigned
[    0.496808] resource: avoiding allocation from e820 entry [mem 0x000a000=
0-0x000fffff]
[    0.496810] resource: avoiding allocation from e820 entry [mem 0x000a000=
0-0x000fffff]
[    0.496811] pci 0000:00:1f.5: BAR 0 [mem 0x80604000-0x80604fff]: assigned
[    0.496822] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.496837] pci 0000:00:06.0:   bridge window [mem 0x80500000-0x805fffff]
[    0.496856] pci 0000:00:1d.0: PCI bridge to [bus 02]
[    0.496861] pci 0000:00:1d.0:   bridge window [mem 0x80400000-0x804fffff]
[    0.496868] pci 0000:00:1d.1: PCI bridge to [bus 03]
[    0.496869] pci 0000:00:1d.1:   bridge window [io  0x3000-0x3fff]
[    0.496875] pci 0000:00:1d.1:   bridge window [mem 0x6000000000-0x60000f=
ffff 64bit pref]
[    0.496880] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.496882] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.496883] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.496884] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000fffff windo=
w]
[    0.496885] pci_bus 0000:00: resource 8 [mem 0x80400000-0xbfffffff windo=
w]
[    0.496886] pci_bus 0000:00: resource 9 [mem 0x4000000000-0x7fffffffff w=
indow]
[    0.496887] pci_bus 0000:01: resource 1 [mem 0x80500000-0x805fffff]
[    0.496889] pci_bus 0000:02: resource 1 [mem 0x80400000-0x804fffff]
[    0.496890] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
[    0.496891] pci_bus 0000:03: resource 2 [mem 0x6000000000-0x60000fffff 6=
4bit pref]
[    0.498233] PCI: CLS 64 bytes, default 64
[    0.498241] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.498242] software IO TLB: mapped [mem 0x000000005db11000-0x0000000061=
b11000] (64MB)
[    0.498291] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x25a=
39079a08, max_idle_ns: 440795310461 ns
[    0.498333] Trying to unpack rootfs image as initramfs...
[    0.498434] clocksource: Switched to clocksource tsc
[    0.498459] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[    0.507038] Initialise system trusted keyrings
[    0.507048] Key type blacklist registered
[    0.507113] workingset: timestamp_bits=3D41 max_order=3D23 bucket_order=
=3D0
[    0.507121] zbud: loaded
[    0.507200] fuse: init (API version 7.40)
[    0.507258] integrity: Platform Keyring initialized
[    0.507260] integrity: Machine keyring initialized
[    0.514792] Key type asymmetric registered
[    0.514794] Asymmetric key parser 'x509' registered
[    0.514811] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.514873] io scheduler mq-deadline registered
[    0.514874] io scheduler kyber registered
[    0.514881] io scheduler bfq registered
[    0.515333] pcieport 0000:00:06.0: PME: Signaling with IRQ 120
[    0.515545] pcieport 0000:00:1d.0: PME: Signaling with IRQ 121
[    0.515730] pcieport 0000:00:1d.1: PME: Signaling with IRQ 122
[    0.515803] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.516875] ACPI: AC: AC Adapter [ADP1] (on-line)
[    0.516910] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A0=
8:00/device:0b/PNP0C09:00/PNP0C0D:00/input/input0
[    0.516922] ACPI: button: Lid Switch [LID0]
[    0.516945] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[    0.516959] ACPI: button: Power Button [PWRB]
[    0.516977] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input2
[    0.516986] ACPI: button: Sleep Button [SLPB]
[    0.517004] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input3
[    0.517137] ACPI: button: Power Button [PWRF]
[    0.519716] thermal LNXTHERM:00: registered as thermal_zone0
[    0.519719] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    0.519900] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.522642] hpet_acpi_add: no address or irqs in _CRS
[    0.522672] Non-volatile memory driver v1.3
[    0.522673] Linux agpgart interface v0.103
[    0.529637] ACPI: bus type drm_connector registered
[    0.530435] ahci 0000:00:17.0: version 3.0
[    0.531778] ACPI: battery: Slot [BAT0] (battery present)
[    0.538733] Freeing initrd memory: 18300K
[    0.540861] ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    0.540866] ahci 0000:00:17.0: 1/2 ports implemented (port mask 0x2)
[    0.540868] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio=
 slum part deso sadm sds=20
[    0.541666] scsi host0: ahci
[    0.541918] scsi host1: ahci
[    0.541939] ata1: DUMMY
[    0.541945] ata2: SATA max UDMA/133 abar m2048@0x80602000 port 0x8060218=
0 irq 123 lpm-pol 3
[    0.542017] usbcore: registered new interface driver usbserial_generic
[    0.542020] usbserial: USB Serial support registered for generic
[    0.542402] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.543387] rtc_cmos rtc_cmos: registered as rtc0
[    0.543559] rtc_cmos rtc_cmos: setting system clock to 2024-05-31T05:40:=
00 UTC (1717134000)
[    0.543586] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nv=
ram
[    0.544265] intel_pstate: Intel P-state driver initializing
[    0.545548] intel_pstate: HWP enabled
[    0.545629] ledtrig-cpu: registered to indicate activity on CPUs
[    0.545810] [drm] Initialized simpledrm 1.0.0 20200625 for simple-frameb=
uffer.0 on minor 0
[    0.546019] fbcon: Deferring console take-over
[    0.546021] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.546157] hid: raw HID events driver (C) Jiri Kosina
[    0.546234] drop_monitor: Initializing network drop monitor service
[    0.546307] NET: Registered PF_INET6 protocol family
[    0.550318] Segment Routing with IPv6
[    0.550319] RPL Segment Routing with IPv6
[    0.550326] In-situ OAM (IOAM) with IPv6
[    0.550342] NET: Registered PF_PACKET protocol family
[    0.551245] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.551637] microcode: Current revision: 0x00000433
[    0.551638] microcode: Updated early from: 0x0000041b
[    0.552235] unchecked MSR access error: WRMSR to 0xd10 (tried to write 0=
x000000000000ffff) at rIP: 0xffffffff8828e9f8 (native_write_msr+0x8/0x30)
[    0.552241] Call Trace:
[    0.552242]  <TASK>
[    0.552244]  ? ex_handler_msr.isra.0.cold+0x5b/0x60
[    0.552246]  ? fixup_exception+0x2c3/0x3a0
[    0.552247]  ? gp_try_fixup_and_notify+0x1e/0xb0
[    0.552249]  ? exc_general_protection+0x104/0x400
[    0.552251]  ? security_kernfs_init_security+0x35/0x50
[    0.552253]  ? asm_exc_general_protection+0x26/0x30
[    0.552255]  ? native_write_msr+0x8/0x30
[    0.552257]  cat_wrmsr+0x49/0x70
[    0.552258]  resctrl_arch_online_cpu+0x353/0x3a0
[    0.552259]  ? __pfx_resctrl_arch_online_cpu+0x10/0x10
[    0.552260]  cpuhp_invoke_callback+0x11f/0x410
[    0.552262]  ? __pfx_smpboot_thread_fn+0x10/0x10
[    0.552263]  cpuhp_thread_fun+0xa2/0x150
[    0.552265]  smpboot_thread_fn+0xda/0x1d0
[    0.552266]  kthread+0xcf/0x100
[    0.552268]  ? __pfx_kthread+0x10/0x10
[    0.552269]  ret_from_fork+0x31/0x50
[    0.552271]  ? __pfx_kthread+0x10/0x10
[    0.552272]  ret_from_fork_asm+0x1a/0x30
[    0.552274]  </TASK>
[    0.552635] resctrl: L2 allocation detected
[    0.552647] IPI shorthand broadcast: enabled
[    0.553827] sched_clock: Marking stable (546667786, 6343343)->(573923308=
, -20912179)
[    0.554092] Timer migration: 2 hierarchy levels; 8 children per group; 2=
 crossnode level
[    0.554364] registered taskstats version 1
[    0.554939] Loading compiled-in X.509 certificates
[    0.557154] Loaded X.509 cert 'Build time autogenerated kernel key: bd14=
c5ac06e9945e7ac85a5a6ffb0ea3f667d519'
[    0.559789] zswap: loaded using pool zstd/zsmalloc
[    0.559948] Key type .fscrypt registered
[    0.559949] Key type fscrypt-provisioning registered
[    0.560206] integrity: Loading X.509 certificate: UEFI:db
[    0.560220] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.560220] integrity: Loading X.509 certificate: UEFI:db
[    0.560229] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.560229] integrity: Loading X.509 certificate: UEFI:db
[    0.562767] integrity: Loaded X.509 cert 'my Signature Database key: f55=
742b17ee4c75ecb4f66293e2fbceddefed102'
[    0.563548] PM:   Magic number: 8:983:669
[    0.565744] RAS: Correctable Errors collector initialized.
[    0.855342] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.858419] ata2.00: ATA-10: Hanstor M.2 1TB, U0510A0, max UDMA/133
[    0.859954] ata2.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth 32), =
AA
[    0.866812] ata2.00: configured for UDMA/133
[    0.877812] scsi 1:0:0:0: Direct-Access     ATA      Hanstor M.2 1TB  0A=
0  PQ: 0 ANSI: 5
[    0.880524] sd 1:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/932 GiB)
[    0.880707] sd 1:0:0:0: [sda] Write Protect is off
[    0.880728] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.880863] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.881443] sd 1:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    0.887384]  sda: sda1
[    0.887727] sd 1:0:0:0: [sda] Attached SCSI disk
[    0.888014] clk: Disabling unused clocks
[    0.888030] PM: genpd: Disabling unused power domains
[    0.893534] Freeing unused decrypted memory: 2028K
[    0.894057] Freeing unused kernel image (initmem) memory: 3412K
[    0.894059] Write protecting the kernel read-only data: 32768k
[    0.894651] Freeing unused kernel image (rodata/data gap) memory: 1040K
[    0.903096] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.903101] rodata_test: all tests were successful
[    0.903105] Run /init as init process
[    0.903106]   with arguments:
[    0.903107]     /init
[    0.903108]   with environment:
[    0.903108]     HOME=3D/
[    0.903109]     TERM=3Dlinux
[    0.903109]     split_lock_detect=3Doff
[    0.921884] systemd[1]: systemd 255.7-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZST=
D +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    0.921888] systemd[1]: Detected architecture x86-64.
[    0.921889] systemd[1]: Running in initrd.
[    0.921945] systemd[1]: Initializing machine ID from random generator.
[    1.004634] systemd[1]: Queued start job for default target Initrd Defau=
lt Target.
[    1.064849] systemd[1]: Expecting device /dev/disk/by-uuid/9bf7c08f-ded6=
-4cf7-864f-9eb6b26c33ae...
[    1.065116] systemd[1]: Reached target Path Units.
[    1.065181] systemd[1]: Reached target Slice Units.
[    1.065233] systemd[1]: Reached target Swaps.
[    1.065279] systemd[1]: Reached target Timer Units.
[    1.065628] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.065843] systemd[1]: Listening on Journal Socket.
[    1.066097] systemd[1]: Listening on udev Control Socket.
[    1.066278] systemd[1]: Listening on udev Kernel Socket.
[    1.066314] systemd[1]: Reached target Socket Units.
[    1.066448] systemd[1]: Create List of Static Device Nodes was skipped b=
ecause of an unmet condition check (ConditionFileNotEmpty=3D/lib/modules/6.=
9.2-arch1-1.1/modules.devname).
[    1.069293] systemd[1]: Starting Check battery level during early boot...
[    1.073467] systemd[1]: Starting Journal Service...
[    1.075594] systemd[1]: Starting Load Kernel Modules...
[    1.075669] systemd[1]: TPM2 PCR Barrier (initrd) was skipped because of=
 an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    1.076986] systemd[1]: Starting Create Static Device Nodes in /dev...
[    1.078106] systemd[1]: Starting Coldplug All udev Devices...
[    1.082900] systemd[1]: Finished Check battery level during early boot.
[    1.083627] systemd[1]: Started Displays emergency message in full scree=
n..
[    1.084682] systemd[1]: Finished Load Kernel Modules.
[    1.085996] systemd[1]: Finished Create Static Device Nodes in /dev.
[    1.086719] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[    1.088983] systemd-journald[158]: Collecting audit messages is disabled.
[    1.097496] systemd[1]: Started Rule-based Manager for Device Events and=
 Files.
[    1.099597] systemd[1]: Started Journal Service.
[    1.152804] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.152812] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    1.153916] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x1=
20 quirks 0x0000100200009810
[    1.154167] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.154173] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    1.154175] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    1.154239] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.09
[    1.154243] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.154244] usb usb1: Product: xHCI Host Controller
[    1.154245] usb usb1: Manufacturer: Linux 6.9.2-arch1-1.1 xhci-hcd
[    1.154246] usb usb1: SerialNumber: 0000:00:14.0
[    1.154342] hub 1-0:1.0: USB hub found
[    1.154367] hub 1-0:1.0: 12 ports detected
[    1.155099] nvme 0000:01:00.0: platform quirk: setting simple suspend
[    1.155153] nvme nvme0: pci function 0000:01:00.0
[    1.156044] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.09
[    1.156047] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.156048] usb usb2: Product: xHCI Host Controller
[    1.156049] usb usb2: Manufacturer: Linux 6.9.2-arch1-1.1 xhci-hcd
[    1.156049] usb usb2: SerialNumber: 0000:00:14.0
[    1.156125] hub 2-0:1.0: USB hub found
[    1.156139] hub 2-0:1.0: 4 ports detected
[    1.156556] usb: port power management may be unreliable
[    1.177070] nvme nvme0: missing or invalid SUBNQN field.
[    1.219016] nvme nvme0: allocated 128 MiB host memory buffer.
[    1.220004] nvme nvme0: 8/0/0 default/read/poll queues
[    1.222571]  nvme0n1: p1 p2 p3 p4 p5 p6 p7 p8 p9
[    1.261673] PM: Image not found (code -22)
[    1.406350] usb 1-4: new full-speed USB device number 2 using xhci_hcd
[    1.466628] EXT4-fs (nvme0n1p8): mounted filesystem 9bf7c08f-ded6-4cf7-8=
64f-9eb6b26c33ae r/w with ordered data mode. Quota mode: none.
[    1.483315] i915 0000:00:02.0: vgaarb: deactivate vga console
[    1.483366] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[    1.483990] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    1.486130] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/=
adlp_dmc.bin (v2.20)
[    1.503261] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/adlp_guc_70.=
bin version 70.20.0
[    1.503266] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin =
version 7.9.3
[    1.520567] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all wor=
kloads
[    1.521193] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[    1.521195] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[    1.521545] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[    1.522148] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected c=
ontent support initialized
[    1.559000] usb 1-4: New USB device found, idVendor=3D8087, idProduct=3D=
0a2a, bcdDevice=3D 0.01
[    1.559017] usb 1-4: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    1.683209] usb 1-5: new high-speed USB device number 3 using xhci_hcd
[    1.852803] usb 1-5: New USB device found, idVendor=3D0c45, idProduct=3D=
6711, bcdDevice=3D40.24
[    1.852822] usb 1-5: New USB device strings: Mfr=3D2, Product=3D1, Seria=
lNumber=3D0
[    1.852829] usb 1-5: Product: USB 2.0 Camera
[    1.852834] usb 1-5: Manufacturer: Sonix Technology Co., Ltd.
[    2.731020] [drm] Initialized i915 1.6.0 20230929 for 0000:00:02.0 on mi=
nor 1
[    2.734031] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  =
post: no)
[    2.734190] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input4
[    2.760031] fbcon: i915drmfb (fb0) is primary device
[    2.760035] fbcon: Deferring console take-over
[    2.760039] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    3.019867] systemd-journald[158]: Received SIGTERM from PID 1 (systemd).
[    3.099826] systemd[1]: systemd 255.7-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZST=
D +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    3.099831] systemd[1]: Detected architecture x86-64.
[    3.100716] systemd[1]: Hostname set to <FIRE>.
[    3.500014] systemd[1]: bpf-lsm: LSM BPF program attached
[    3.632915] systemd[1]: initrd-switch-root.service: Deactivated successf=
ully.
[    3.632967] systemd[1]: Stopped Switch Root.
[    3.633277] systemd[1]: systemd-journald.service: Scheduled restart job,=
 restart counter is at 1.
[    3.633420] systemd[1]: Created slice Slice /system/dirmngr.
[    3.633525] systemd[1]: Created slice Slice /system/getty.
[    3.633626] systemd[1]: Created slice Slice /system/gpg-agent.
[    3.633725] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    3.633822] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    3.633919] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    3.634015] systemd[1]: Created slice Slice /system/keyboxd.
[    3.634115] systemd[1]: Created slice Slice /system/modprobe.
[    3.634214] systemd[1]: Created slice Slice /system/systemd-fsck.
[    3.634281] systemd[1]: Created slice User and Session Slice.
[    3.634306] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    3.634321] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    3.634385] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    3.634391] systemd[1]: Expecting device /dev/disk/by-uuid/d3fa04da-cb55=
-4ff4-a93b-92256084412c...
[    3.634396] systemd[1]: Reached target Local Encrypted Volumes.
[    3.634404] systemd[1]: Stopped target Switch Root.
[    3.634410] systemd[1]: Stopped target Initrd File Systems.
[    3.634414] systemd[1]: Stopped target Initrd Root File System.
[    3.634420] systemd[1]: Reached target Local Integrity Protected Volumes.
[    3.634430] systemd[1]: Reached target Remote File Systems.
[    3.634435] systemd[1]: Reached target Slice Units.
[    3.634449] systemd[1]: Reached target Local Verity Protected Volumes.
[    3.634478] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.636082] systemd[1]: Listening on Process Core Dump Socket.
[    3.636099] systemd[1]: TPM2 PCR Extension (Varlink) was skipped because=
 of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.636206] systemd[1]: Listening on udev Control Socket.
[    3.636234] systemd[1]: Listening on udev Kernel Socket.
[    3.687120] systemd[1]: Mounting Huge Pages File System...
[    3.688851] systemd[1]: Mounting POSIX Message Queue File System...
[    3.690024] systemd[1]: Mounting Kernel Debug File System...
[    3.691227] systemd[1]: Mounting Kernel Trace File System...
[    3.692452] systemd[1]: Starting Create List of Static Device Nodes...
[    3.692961] systemd[1]: Starting Load Kernel Module configfs...
[    3.693490] systemd[1]: Starting Load Kernel Module dm_mod...
[    3.693925] systemd[1]: Starting Load Kernel Module drm...
[    3.694265] systemd[1]: Starting Load Kernel Module fuse...
[    3.694903] systemd[1]: Starting Load Kernel Module loop...
[    3.696080] systemd[1]: Starting Journal Service...
[    3.696994] systemd[1]: Starting Load Kernel Modules...
[    3.697014] systemd[1]: TPM2 PCR Machine ID Measurement was skipped beca=
use of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.697579] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.697620] systemd[1]: TPM2 SRK Setup (Early) was skipped because of an=
 unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.698129] systemd[1]: Starting Coldplug All udev Devices...
[    3.698922] systemd[1]: Mounted Huge Pages File System.
[    3.698992] systemd[1]: Mounted POSIX Message Queue File System.
[    3.699050] systemd[1]: Mounted Kernel Debug File System.
[    3.699103] systemd[1]: Mounted Kernel Trace File System.
[    3.699238] systemd[1]: Finished Create List of Static Device Nodes.
[    3.699408] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    3.699500] systemd[1]: Finished Load Kernel Module configfs.
[    3.699673] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    3.699770] systemd[1]: Finished Load Kernel Module drm.
[    3.699942] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    3.700022] systemd[1]: Finished Load Kernel Module fuse.
[    3.700616] systemd[1]: Mounting FUSE Control File System...
[    3.701071] systemd[1]: Mounting Kernel Configuration File System...
[    3.701589] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[    3.702637] loop: module loaded
[    3.702948] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    3.703077] systemd[1]: Finished Load Kernel Module loop.
[    3.704659] systemd[1]: Mounted FUSE Control File System.
[    3.705231] systemd[1]: Mounted Kernel Configuration File System.
[    3.706131] device-mapper: uevent: version 1.0.3
[    3.706201] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@lists.linux.dev
[    3.706238] systemd-journald[281]: Collecting audit messages is disabled.
[    3.706621] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[    3.706720] systemd[1]: Finished Load Kernel Module dm_mod.
[    3.706842] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[    3.710160] systemd[1]: Started Journal Service.
[    3.712538] i2c_dev: i2c /dev entries driver
[    3.736734] EXT4-fs (nvme0n1p8): re-mounted 9bf7c08f-ded6-4cf7-864f-9eb6=
b26c33ae r/w. Quota mode: none.
[    3.745112] systemd-journald[281]: Received client request to flush runt=
ime journal.
[    3.830613] systemd-journald[281]: /var/log/journal/bd024c881a1f4958a55e=
8145fab6de4c/system.journal: Journal file uses a different sequence number =
ID, rotating.
[    3.830628] systemd-journald[281]: Rotating system journal.
[    4.539806] Adding 4194300k swap on /swapfile.  Priority:-2 extents:192 =
across:59072512k SSDsc
[    4.662987] input: Intel HID events as /devices/platform/INTC1070:00/inp=
ut/input5
[    4.663962] intel-hid INTC1070:00: platform supports 5 button array
[    4.668287] input: Intel HID 5 button array as /devices/platform/INTC107=
0:00/input/input6
[    4.668461] Consider using thermal netlink events interface
[    4.669878] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.L=
PCB.H_EC.CHRG.PPSS.FCHG], AE_NOT_FOUND (20230628/psargs-330)
[    4.669886] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.CHRG.PPSS du=
e to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    4.670734] intel_pmc_core INT33A1:00:  initialized
[    4.674094] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    4.674098] i8042: PNP: PS/2 appears to have AUX port disabled, if this =
is incorrect please boot with i8042.nopnp
[    4.675794] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.683940] resource: resource sanity check: requesting [mem 0x00000000f=
edc0000-0x00000000fedcffff], which spans more than pnp 00:02 [mem 0xfedc000=
0-0xfedc7fff]
[    4.683946] caller igen6_probe+0x15e/0x7c0 [igen6_edac] mapping multiple=
 BARs
[    4.684780] EDAC MC0: Giving out device to module igen6_edac controller =
Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
[    4.691666] EDAC MC1: Giving out device to module igen6_edac controller =
Intel_client_SoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
[    4.691708] EDAC igen6 MC1: HANDLING IBECC MEMORY ERROR
[    4.691710] EDAC igen6 MC1: ADDR 0x7fffffffe0=20
[    4.691711] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[    4.691712] EDAC igen6 MC0: ADDR 0x7fffffffe0=20
[    4.692310] EDAC igen6: v2.5.1
[    4.694099] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    4.694225] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    4.694261] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    4.694866] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    4.698697] mei_me 0000:00:16.0: hbm: dma setup response: failure =3D 3 =
REJECTED
[    4.704407] i2c i2c-10: Successfully instantiated SPD at 0x50
[    4.705900] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    4.706152] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    4.734125] mc: Linux media interface: v0.10
[    4.746289] EXT4-fs (nvme0n1p9): mounted filesystem d3fa04da-cb55-4ff4-a=
93b-92256084412c r/w with ordered data mode. Quota mode: none.
[    4.785342] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/261)
[    4.786358] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/33030)
[    4.787340] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/1157)
[    4.788333] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/2309)
[    4.789338] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/405)
[    4.790332] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/661)
[    4.791314] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/4213)
[    4.792331] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/9474)
[    4.793312] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/897)
[    4.794082] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    4.794190] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: =
bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[    4.794251] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.794337] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/49154)
[    4.794395] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[    4.794804] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: b=
ound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
[    4.794984] ee1004 10-0050: 512 byte EE1004-compliant SPD EEPROM, read-o=
nly
[    4.795331] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/33105)
[    4.796315] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/9731)
[    4.797329] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/38160)
[    4.798328] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/1941)
[    4.799318] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/38145)
[    4.800343] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/49154)
[    4.801327] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/3593)
[    4.804893] intel_rapl_msr: PL4 support detected.
[    4.804920] intel_rapl_common: Found RAPL domain package
[    4.804921] intel_rapl_common: Found RAPL domain core
[    4.804922] intel_rapl_common: Found RAPL domain uncore
[    4.804924] intel_rapl_common: Found RAPL domain psys
[    4.805111] Bluetooth: Core ver 2.22
[    4.805122] NET: Registered PF_BLUETOOTH protocol family
[    4.805123] Bluetooth: HCI device and connection manager initialized
[    4.805126] Bluetooth: HCI socket layer initialized
[    4.805128] Bluetooth: L2CAP socket layer initialized
[    4.805133] Bluetooth: SCO socket layer initialized
[    4.986697] r8169 0000:03:00.0: enabling device (0000 -> 0003)
[    4.989574] Creating 1 MTD partitions on "0000:00:1f.5":
[    4.989578] 0x000000000000-0x000002000000 : "BIOS"
[    4.991920] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input7
[    4.993144] r8169 0000:03:00.0 eth0: RTL8168evl/8111evl, 00:00:00:00:00:=
03, XID 2c9, IRQ 136
[    4.993148] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    4.995845] Intel(R) Wireless WiFi driver for Linux
[    4.997003] r8169 0000:03:00.0 enp3s0: renamed from eth0
[    4.998918] proc_thermal_pci 0000:00:04.0: enabling device (0000 -> 0002)
[    4.999074] input: XXXX0000:01 0911:5288 Mouse as /devices/pci0000:00/00=
00:00:15.0/i2c_designware.0/i2c-11/i2c-XXXX0000:01/0018:0911:5288.0001/inpu=
t/input8
[    4.999110] videodev: Linux video capture interface: v2.00
[    4.999146] input: XXXX0000:01 0911:5288 Touchpad as /devices/pci0000:00=
/0000:00:15.0/i2c_designware.0/i2c-11/i2c-XXXX0000:01/0018:0911:5288.0001/i=
nput/input9
[    4.999217] hid-generic 0018:0911:5288.0001: input,hidraw0: I2C HID v1.0=
0 Mouse [XXXX0000:01 0911:5288] on i2c-XXXX0000:01
[    5.003037] intel_rapl_common: Found RAPL domain package
[    5.003080] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360=
 ms ovfl timer
[    5.003083] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    5.003084] RAPL PMU: hw unit of domain package 2^-14 Joules
[    5.003085] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    5.003086] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    5.005506] cryptd: max_cpu_qlen set to 1000
[    5.006993] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
[    5.008888] iwlwifi 0000:02:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm i=
d 0x0
[    5.008993] iwlwifi 0000:02:00.0: PCI dev 095a/5410, rev=3D0x210, rfid=
=3D0xd55555d5
[    5.013783] iwlwifi 0000:02:00.0: Found debug destination: EXTERNAL_DRAM
[    5.013785] iwlwifi 0000:02:00.0: Found debug configuration: 0
[    5.013899] iwlwifi 0000:02:00.0: loaded firmware version 29.4063824552.=
0 7265D-29.ucode op_mode iwlmvm
[    5.017823] AVX2 version of gcm_enc/dec engaged.
[    5.017853] AES CTR mode by8 optimization enabled
[    5.020782] pps_core: LinuxPPS API ver. 1 registered
[    5.020785] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    5.021653] usb 1-5: Found UVC 1.00 device USB 2.0 Camera (0c45:6711)
[    5.025177] PTP clock support registered
[    5.029108] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subc=
lass/prog-if info 0x040100
[    5.029214] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[    5.029415] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_aud=
io_component_bind_ops [i915])
[    5.049879] usbcore: registered new interface driver uvcvideo
[    5.080011] RTL8211E Gigabit Ethernet r8169-0-300:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)
[    5.116116] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless A=
C 7265, REV=3D0x210
[    5.116168] thermal thermal_zone4: failed to read out thermal zone (-61)
[    5.117880] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269VB: =
line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    5.117887] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    5.117888] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    5.117890] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[    5.117890] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    5.117891] snd_hda_codec_realtek hdaudioC0D0:      Mic=3D0x18
[    5.117892] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D0x19
[    5.117893] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D0x12
[    5.119980] usbcore: registered new interface driver btusb
[    5.135126] Bluetooth: hci0: Legacy ROM 2.5 revision 1.0 build 3 week 17=
 2014
[    5.135131] Bluetooth: hci0: Intel device is already patched. patch num:=
 39
[    5.135688] intel_tcc_cooling: TCC Offset locked
[    5.136467] input: XXXX0000:01 0911:5288 Mouse as /devices/pci0000:00/00=
00:00:15.0/i2c_designware.0/i2c-11/i2c-XXXX0000:01/0018:0911:5288.0001/inpu=
t/input12
[    5.136513] input: XXXX0000:01 0911:5288 Touchpad as /devices/pci0000:00=
/0000:00:15.0/i2c_designware.0/i2c-11/i2c-XXXX0000:01/0018:0911:5288.0001/i=
nput/input13
[    5.136546] hid-multitouch 0018:0911:5288.0001: input,hidraw0: I2C HID v=
1.00 Mouse [XXXX0000:01 0911:5288] on i2c-XXXX0000:01
[    5.143057] mousedev: PS/2 mouse device common for all mice
[    5.150526] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3=
/sound/card0/input10
[    5.150566] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:0=
0:1f.3/sound/card0/input11
[    5.150606] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input14
[    5.150635] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input15
[    5.150661] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input16
[    5.150686] input: HDA Intel PCH HDMI/DP,pcm=3D9 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input17
[    5.180431] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.180435] Bluetooth: BNEP filters: protocol multicast
[    5.180439] Bluetooth: BNEP socket layer initialized
[    5.186259] Bluetooth: MGMT ver 1.22
[    5.186302] Bluetooth: ISO socket layer initialized
[    5.189744] NET: Registered PF_ALG protocol family
[    5.328707] r8169 0000:03:00.0 enp3s0: Link is Down
[    5.343860] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    5.345250] iwlwifi 0000:02:00.0: Allocated 0x00400000 bytes for firmwar=
e monitor.
[    5.358011] iwlwifi 0000:02:00.0: base HW address: 18:5e:0f:5e:3b:66, OT=
P minor version: 0x0
[    5.421099] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    5.427658] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
[    5.450928] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    5.530285] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    5.532460] iwlwifi 0000:02:00.0: FW already configured (0) - re-configu=
ring
[    5.540759] iwlwifi 0000:02:00.0: Registered PHC clock: iwlwifi-PTP, wit=
h index: 0
[    5.607588] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    5.687804] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    5.689850] iwlwifi 0000:02:00.0: FW already configured (0) - re-configu=
ring
[    5.695206] fbcon: Taking over console
[    5.707988] Console: switching to colour frame buffer device 240x67
[    8.314817] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   10.602121] input: Baseus F02 Mouse  Keyboard as /devices/virtual/misc/u=
hid/0005:045E:0040.0002/input/input18
[   10.602694] input: Baseus F02 Mouse  Mouse as /devices/virtual/misc/uhid=
/0005:045E:0040.0002/input/input19
[   10.602985] hid-generic 0005:045E:0040.0002: input,hidraw1: BLUETOOTH HI=
D v3.00 Keyboard [Baseus F02 Mouse ] on 18:5e:0f:5e:3b:6a
[   12.672816] systemd-journald[281]: /var/log/journal/bd024c881a1f4958a55e=
8145fab6de4c/user-1000.journal: Journal file uses a different sequence numb=
er ID, rotating.
[   25.316229] ntfs3: Max link count 4000
[   25.316233] ntfs3: Enabled Linux POSIX ACLs support
[   25.316235] ntfs3: Read-only LZX/Xpress compression included
[   25.405381] Bluetooth: RFCOMM TTY layer initialized
[   25.405389] Bluetooth: RFCOMM socket layer initialized
[   25.405393] Bluetooth: RFCOMM ver 1.11
[   25.617720] warning: `crow' uses wireless extensions which will stop wor=
king for Wi-Fi 7 hardware; use nl80211

--3jjvrasvvktm7dvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg6.9.2-1.5.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.9.2-arch1-1.5 (linux@archlinux) (gcc (GCC) 1=
4.1.1 20240522, GNU ld (GNU Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Thu, 3=
0 May 2024 17:09:45 +0000
[    0.000000] Command line: ro root=3DUUID=3D9bf7c08f-ded6-4cf7-864f-9eb6b=
26c33ae resume=3DUUID=3D9bf7c08f-ded6-4cf7-864f-9eb6b26c33ae rw add_efi_mem=
map resume_offset=3D2170880 quiet split_lock_detect=3Doff loglevel=3D3 nowa=
tchdog mitigations=3Doff initrd=3D\boot\initramfs-linux.img
[    0.000000] x86/split lock detection: disabled
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000407cdfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000407ce000-0x00000000407cefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000407cf000-0x000000004244dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000004244e000-0x000000004244efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000004244f000-0x0000000071ca8fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000071ca9000-0x000000007544bfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007544c000-0x000000007553dfff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007553e000-0x0000000075619fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007561a000-0x0000000075ffefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000075fff000-0x0000000075ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000076000000-0x0000000079ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007a600000-0x000000007a7fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007ac00000-0x00000000803fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087fbfffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.8 by American Megatrends
[    0.000000] efi: ACPI=3D0x755b6000 ACPI 2.0=3D0x755b6014 TPMFinalLog=3D0=
x75585000 SMBIOS=3D0x75dae000 SMBIOS 3.0=3D0x75dad000 MEMATTR=3D0x6ecf8198 =
ESRT=3D0x6ef4a398 INITRD=3D0x6599fd98 RNG=3D0x7548a018 TPMEventLog=3D0x6660=
3018=20
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem110: MMIO range=3D[0xc0000000-0xcfffffff] (25=
6MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] efi: Not removing mem111: MMIO range=3D[0xfe000000-0xfe010ff=
f] (68KB) from e820 map
[    0.000000] efi: Not removing mem112: MMIO range=3D[0xfec00000-0xfec00ff=
f] (4KB) from e820 map
[    0.000000] efi: Not removing mem113: MMIO range=3D[0xfed00000-0xfed00ff=
f] (4KB) from e820 map
[    0.000000] efi: Not removing mem115: MMIO range=3D[0xfee00000-0xfee00ff=
f] (4KB) from e820 map
[    0.000000] efi: Remove mem116: MMIO range=3D[0xff000000-0xffffffff] (16=
MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.5.0 present.
[    0.000000] DMI: Default string Default string/Default string, BIOS GLX2=
58-A V0.0.5 07/23/2022
[    0.000000] tsc: Detected 2600.000 MHz processor
[    0.000000] tsc: Detected 2611.200 MHz TSC
[    0.000392] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000394] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000401] last_pfn =3D 0x87fc00 max_arch_pfn =3D 0x400000000
[    0.000403] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built fr=
om 10 variable MTRRs
[    0.000405] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.000745] last_pfn =3D 0x76000 max_arch_pfn =3D 0x400000000
[    0.009801] esrt: Reserving ESRT space from 0x000000006ef4a398 to 0x0000=
00006ef4a3d0.
[    0.009805] e820: update [mem 0x6ef4a000-0x6ef4afff] usable =3D=3D> rese=
rved
[    0.009819] Using GB pages for direct mapping
[    0.009819] Incomplete global flushes, disabling PCID
[    0.010072] Secure boot enabled
[    0.010073] RAMDISK: [mem 0x61b10000-0x62ceefff]
[    0.010099] ACPI: Early table checksum verification disabled
[    0.010102] ACPI: RSDP 0x00000000755B6014 000024 (v02 ALASKA)
[    0.010104] ACPI: XSDT 0x00000000755B5728 000104 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010108] ACPI: FACP 0x0000000075534000 000114 (v06 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010112] ACPI: DSDT 0x00000000754BF000 074A9A (v02 ALASKA A M I    01=
072009 INTL 20200717)
[    0.010114] ACPI: FACS 0x0000000075619000 000040
[    0.010115] ACPI: SSDT 0x0000000075535000 006C41 (v02 DptfTb DptfTabl 00=
001000 INTL 20200717)
[    0.010118] ACPI: FIDT 0x00000000754BE000 00009C (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.010119] ACPI: SSDT 0x000000007553D000 00038C (v02 PmaxDv Pmax_Dev 00=
000001 INTL 20200717)
[    0.010121] ACPI: SSDT 0x00000000754B8000 005D0B (v02 CpuRef CpuSsdt  00=
003000 INTL 20200717)
[    0.010123] ACPI: SSDT 0x00000000754B5000 002AA1 (v02 SaSsdt SaSsdt   00=
003000 INTL 20200717)
[    0.010125] ACPI: SSDT 0x00000000754B1000 0033D3 (v02 INTEL  IgfxSsdt 00=
003000 INTL 20200717)
[    0.010127] ACPI: HPET 0x000000007553C000 000038 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010129] ACPI: APIC 0x00000000754B0000 0001DC (v05 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010130] ACPI: MCFG 0x00000000754AF000 00003C (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010132] ACPI: SSDT 0x00000000754A6000 008384 (v02 ALASKA AdlP_Rvp 00=
001000 INTL 20200717)
[    0.010134] ACPI: SSDT 0x00000000754A4000 0019D1 (v02 ALASKA Ther_Rvp 00=
001000 INTL 20200717)
[    0.010136] ACPI: UEFI 0x000000007556C000 000048 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010138] ACPI: NHLT 0x00000000754A3000 00002D (v00 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010139] ACPI: LPIT 0x00000000754A2000 0000CC (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010141] ACPI: SSDT 0x000000007549E000 002A83 (v02 ALASKA PtidDevc 00=
001000 INTL 20200717)
[    0.010143] ACPI: SSDT 0x000000007549B000 002357 (v02 ALASKA TbtTypeC 00=
000000 INTL 20200717)
[    0.010145] ACPI: DBGP 0x000000007549A000 000034 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010146] ACPI: DBG2 0x0000000075499000 00005C (v00 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010148] ACPI: SSDT 0x0000000075498000 00078E (v02 INTEL  xh_adlLP 00=
000000 INTL 20200717)
[    0.010150] ACPI: SSDT 0x0000000075494000 003AEA (v02 SocGpe SocGpe   00=
003000 INTL 20200717)
[    0.010152] ACPI: SSDT 0x0000000075490000 0039DA (v02 SocCmn SocCmn   00=
003000 INTL 20200717)
[    0.010154] ACPI: SSDT 0x000000007548F000 000144 (v02 Intel  ADebTabl 00=
001000 INTL 20200717)
[    0.010156] ACPI: BGRT 0x000000007548E000 000038 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.010157] ACPI: TPM2 0x000000007548D000 00004C (v04 ALASKA A M I    00=
000001 AMI  00000000)
[    0.010159] ACPI: PHAT 0x000000007548C000 0004EA (v01 ALASKA A M I    00=
000005 MSFT 0100000D)
[    0.010161] ACPI: WSMT 0x00000000754A1000 000028 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.010163] ACPI: FPDT 0x000000007548B000 000044 (v01 ALASKA A M I    01=
072009 AMI  01000013)
[    0.010164] ACPI: Reserving FACP table memory at [mem 0x75534000-0x75534=
113]
[    0.010165] ACPI: Reserving DSDT table memory at [mem 0x754bf000-0x75533=
a99]
[    0.010166] ACPI: Reserving FACS table memory at [mem 0x75619000-0x75619=
03f]
[    0.010166] ACPI: Reserving SSDT table memory at [mem 0x75535000-0x7553b=
c40]
[    0.010167] ACPI: Reserving FIDT table memory at [mem 0x754be000-0x754be=
09b]
[    0.010167] ACPI: Reserving SSDT table memory at [mem 0x7553d000-0x7553d=
38b]
[    0.010168] ACPI: Reserving SSDT table memory at [mem 0x754b8000-0x754bd=
d0a]
[    0.010168] ACPI: Reserving SSDT table memory at [mem 0x754b5000-0x754b7=
aa0]
[    0.010169] ACPI: Reserving SSDT table memory at [mem 0x754b1000-0x754b4=
3d2]
[    0.010169] ACPI: Reserving HPET table memory at [mem 0x7553c000-0x7553c=
037]
[    0.010170] ACPI: Reserving APIC table memory at [mem 0x754b0000-0x754b0=
1db]
[    0.010170] ACPI: Reserving MCFG table memory at [mem 0x754af000-0x754af=
03b]
[    0.010171] ACPI: Reserving SSDT table memory at [mem 0x754a6000-0x754ae=
383]
[    0.010171] ACPI: Reserving SSDT table memory at [mem 0x754a4000-0x754a5=
9d0]
[    0.010172] ACPI: Reserving UEFI table memory at [mem 0x7556c000-0x7556c=
047]
[    0.010172] ACPI: Reserving NHLT table memory at [mem 0x754a3000-0x754a3=
02c]
[    0.010173] ACPI: Reserving LPIT table memory at [mem 0x754a2000-0x754a2=
0cb]
[    0.010173] ACPI: Reserving SSDT table memory at [mem 0x7549e000-0x754a0=
a82]
[    0.010174] ACPI: Reserving SSDT table memory at [mem 0x7549b000-0x7549d=
356]
[    0.010174] ACPI: Reserving DBGP table memory at [mem 0x7549a000-0x7549a=
033]
[    0.010175] ACPI: Reserving DBG2 table memory at [mem 0x75499000-0x75499=
05b]
[    0.010175] ACPI: Reserving SSDT table memory at [mem 0x75498000-0x75498=
78d]
[    0.010176] ACPI: Reserving SSDT table memory at [mem 0x75494000-0x75497=
ae9]
[    0.010176] ACPI: Reserving SSDT table memory at [mem 0x75490000-0x75493=
9d9]
[    0.010177] ACPI: Reserving SSDT table memory at [mem 0x7548f000-0x7548f=
143]
[    0.010177] ACPI: Reserving BGRT table memory at [mem 0x7548e000-0x7548e=
037]
[    0.010178] ACPI: Reserving TPM2 table memory at [mem 0x7548d000-0x7548d=
04b]
[    0.010178] ACPI: Reserving PHAT table memory at [mem 0x7548c000-0x7548c=
4e9]
[    0.010179] ACPI: Reserving WSMT table memory at [mem 0x754a1000-0x754a1=
027]
[    0.010179] ACPI: Reserving FPDT table memory at [mem 0x7548b000-0x7548b=
043]
[    0.010303] No NUMA configuration found
[    0.010303] Faking a node at [mem 0x0000000000000000-0x000000087fbfffff]
[    0.010305] NODE_DATA(0) allocated [mem 0x87fbfb000-0x87fbfffff]
[    0.010335] Zone ranges:
[    0.010335]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.010336]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.010338]   Normal   [mem 0x0000000100000000-0x000000087fbfffff]
[    0.010339]   Device   empty
[    0.010339] Movable zone start for each node
[    0.010340] Early memory node ranges
[    0.010340]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.010341]   node   0: [mem 0x000000000009f000-0x000000000009ffff]
[    0.010341]   node   0: [mem 0x0000000000100000-0x00000000407cdfff]
[    0.010342]   node   0: [mem 0x00000000407cf000-0x000000004244dfff]
[    0.010342]   node   0: [mem 0x000000004244f000-0x0000000071ca8fff]
[    0.010343]   node   0: [mem 0x0000000075fff000-0x0000000075ffffff]
[    0.010343]   node   0: [mem 0x0000000100000000-0x000000087fbfffff]
[    0.010345] Initmem setup node 0 [mem 0x0000000000001000-0x000000087fbff=
fff]
[    0.010348] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.010349] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.010366] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.011690] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.012489] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.012582] On node 0, zone DMA32: 17238 pages in unavailable ranges
[    0.044879] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.044885] On node 0, zone Normal: 1024 pages in unavailable ranges
[    0.044904] Reserving Intel graphics memory at [mem 0x7c800000-0x803ffff=
f]
[    0.045328] ACPI: PM-Timer IO Port: 0x1808
[    0.045334] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.045335] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.045336] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.045336] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.045337] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.045337] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.045337] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.045338] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.045338] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.045338] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.045339] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.045339] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.045340] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.045340] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.045340] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.045341] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.045341] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.045342] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.045342] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.045342] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.045343] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.045343] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.045343] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.045344] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.045378] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.045380] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.045381] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.045384] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.045384] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.045389] e820: update [mem 0x6e4b1000-0x6e503fff] usable =3D=3D> rese=
rved
[    0.045397] TSC deadline timer available
[    0.045399] CPU topo: Max. logical packages:   1
[    0.045399] CPU topo: Max. logical dies:       1
[    0.045399] CPU topo: Max. dies per package:   1
[    0.045401] CPU topo: Max. threads per core:   2
[    0.045402] CPU topo: Num. cores per package:    10
[    0.045402] CPU topo: Num. threads per package:  12
[    0.045403] CPU topo: Allowing 12 present CPUs plus 0 hotplug CPUs
[    0.045416] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.045418] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0=
x0009efff]
[    0.045419] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000fffff]
[    0.045420] PM: hibernation: Registered nosave memory: [mem 0x407ce000-0=
x407cefff]
[    0.045420] PM: hibernation: Registered nosave memory: [mem 0x4244e000-0=
x4244efff]
[    0.045421] PM: hibernation: Registered nosave memory: [mem 0x6e4b1000-0=
x6e503fff]
[    0.045422] PM: hibernation: Registered nosave memory: [mem 0x6ef4a000-0=
x6ef4afff]
[    0.045423] PM: hibernation: Registered nosave memory: [mem 0x71ca9000-0=
x7544bfff]
[    0.045423] PM: hibernation: Registered nosave memory: [mem 0x7544c000-0=
x7553dfff]
[    0.045424] PM: hibernation: Registered nosave memory: [mem 0x7553e000-0=
x75619fff]
[    0.045424] PM: hibernation: Registered nosave memory: [mem 0x7561a000-0=
x75ffefff]
[    0.045425] PM: hibernation: Registered nosave memory: [mem 0x76000000-0=
x79ffffff]
[    0.045425] PM: hibernation: Registered nosave memory: [mem 0x7a000000-0=
x7a5fffff]
[    0.045426] PM: hibernation: Registered nosave memory: [mem 0x7a600000-0=
x7a7fffff]
[    0.045426] PM: hibernation: Registered nosave memory: [mem 0x7a800000-0=
x7abfffff]
[    0.045426] PM: hibernation: Registered nosave memory: [mem 0x7ac00000-0=
x803fffff]
[    0.045427] PM: hibernation: Registered nosave memory: [mem 0x80400000-0=
xfdffffff]
[    0.045427] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.045428] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.045428] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.045428] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfecfffff]
[    0.045429] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0=
xfed00fff]
[    0.045429] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0=
xfed1ffff]
[    0.045429] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0=
xfed7ffff]
[    0.045430] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0=
xfedfffff]
[    0.045430] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.045430] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xffffffff]
[    0.045431] [mem 0x80400000-0xfdffffff] available for PCI devices
[    0.045432] Booting paravirtualized kernel on bare hardware
[    0.045434] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.049310] setup_percpu: NR_CPUS:320 nr_cpumask_bits:12 nr_cpu_ids:12 n=
r_node_ids:1
[    0.049786] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.049789] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=3D1*2097152
[    0.049791] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07=20
[    0.049794] pcpu-alloc: [0] 08 09 10 11=20
[    0.049804] Kernel command line: ro root=3DUUID=3D9bf7c08f-ded6-4cf7-864=
f-9eb6b26c33ae resume=3DUUID=3D9bf7c08f-ded6-4cf7-864f-9eb6b26c33ae rw add_=
efi_memmap resume_offset=3D2170880 quiet split_lock_detect=3Doff loglevel=
=3D3 nowatchdog mitigations=3Doff initrd=3D\boot\initramfs-linux.img
[    0.049868] Unknown kernel command line parameters "split_lock_detect=3D=
off", will be passed to user space.
[    0.051824] Dentry cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes, linear)
[    0.052803] Inode-cache hash table entries: 2097152 (order: 12, 16777216=
 bytes, linear)
[    0.052887] Fallback order for Node 0: 0=20
[    0.052889] Built 1 zonelists, mobility grouping on.  Total pages: 81989=
81
[    0.052890] Policy zone: Normal
[    0.053031] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.053035] software IO TLB: area num 16.
[    0.099526] Memory: 32446260K/33317144K available (18432K kernel code, 2=
164K rwdata, 13296K rodata, 3412K init, 3624K bss, 870624K reserved, 0K cma=
-reserved)
[    0.099663] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D12, =
Nodes=3D1
[    0.099693] ftrace: allocating 49853 entries in 195 pages
[    0.103962] ftrace: allocated 195 pages with 4 groups
[    0.104015] Dynamic Preempt: full
[    0.104051] rcu: Preemptible hierarchical RCU implementation.
[    0.104052] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D12.
[    0.104053] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.104054] 	Trampoline variant of Tasks RCU enabled.
[    0.104054] 	Rude variant of Tasks RCU enabled.
[    0.104054] 	Tracing variant of Tasks RCU enabled.
[    0.104055] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.104056] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D12
[    0.104062] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjus=
t=3D1.
[    0.104063] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_=
adjust=3D1.
[    0.104064] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb=
_adjust=3D1.
[    0.106481] NR_IRQS: 20736, nr_irqs: 2152, preallocated irqs: 16
[    0.106764] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.107006] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.107027] Console: colour dummy device 80x25
[    0.107029] printk: legacy console [tty0] enabled
[    0.107056] ACPI: Core revision 20230628
[    0.107265] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.107266] APIC: Switch to symmetric I/O mode setup
[    0.108577] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.108918] APIC: Switched APIC routing to: physical flat
[    0.113284] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x25a39079a08, max_idle_ns: 440795310461 ns
[    0.113289] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 5224.00 BogoMIPS (lpj=3D8704000)
[    0.113353] CPU0: Thermal monitoring enabled (TM1)
[    0.113354] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.113447] CET detected: Indirect Branch Tracking enabled
[    0.113449] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.113449] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.113452] process: using mwait in idle threads
[    0.113454] Spectre V2 : User space: Vulnerable
[    0.113455] Speculative Store Bypass: Vulnerable
[    0.113465] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.113466] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.113466] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.113467] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'
[    0.113467] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User =
registers'
[    0.113468] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.113469] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.113469] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.113470] x86/fpu: Enabled xstate features 0xa07, context size is 856 =
bytes, using 'compacted' format.
[    0.116620] Freeing SMP alternatives memory: 40K
[    0.116620] pid_max: default: 32768 minimum: 301
[    0.116620] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.116620] landlock: Up and running.
[    0.116620] Yama: becoming mindful.
[    0.116620] LSM support for eBPF active
[    0.116620] Mount-cache hash table entries: 65536 (order: 7, 524288 byte=
s, linear)
[    0.116620] Mountpoint-cache hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
[    0.116620] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1255U (family: =
0x6, model: 0x9a, stepping: 0x4)
[    0.116620] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-base=
line,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-wid=
th counters, Intel PMU driver.
[    0.116620] core: cpu_core PMU driver:=20
[    0.116620] ... version:                5
[    0.116620] ... bit width:              48
[    0.116620] ... generic registers:      8
[    0.116620] ... value mask:             0000ffffffffffff
[    0.116620] ... max period:             00007fffffffffff
[    0.116620] ... fixed-purpose events:   4
[    0.116620] ... event mask:             0001000f000000ff
[    0.116620] signal: max sigframe size: 3632
[    0.116620] Estimated ratio of average max frequency by base frequency (=
times 1024): 1614
[    0.116620] rcu: Hierarchical SRCU implementation.
[    0.116620] rcu: 	Max phase no-delay instances is 1000.
[    0.116620] smp: Bringing up secondary CPUs ...
[    0.116620] smpboot: x86: Booting SMP configuration:
[    0.116620] .... node  #0, CPUs:        #2  #4  #5  #6  #7  #8  #9 #10 #=
11
[    0.009676] [Firmware Bug]: CPU4: Topology domain 1 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU4: Topology domain 2 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU4: Topology domain 3 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU4: Topology domain 4 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU4: Topology domain 5 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU4: Topology domain 6 shift 7 !=3D 6
[    0.009676] core: cpu_atom PMU driver: PEBS-via-PT=20
[    0.009676] ... version:                5
[    0.009676] ... bit width:              48
[    0.009676] ... generic registers:      6
[    0.009676] ... value mask:             0000ffffffffffff
[    0.009676] ... max period:             00007fffffffffff
[    0.009676] ... fixed-purpose events:   3
[    0.009676] ... event mask:             000000070000003f
[    0.009676] [Firmware Bug]: CPU5: Topology domain 1 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU5: Topology domain 2 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU5: Topology domain 3 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU5: Topology domain 4 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU5: Topology domain 5 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU5: Topology domain 6 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU6: Topology domain 1 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU6: Topology domain 2 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU6: Topology domain 3 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU6: Topology domain 4 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU6: Topology domain 5 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU6: Topology domain 6 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU7: Topology domain 1 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU7: Topology domain 2 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU7: Topology domain 3 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU7: Topology domain 4 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU7: Topology domain 5 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU7: Topology domain 6 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU8: Topology domain 1 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU8: Topology domain 2 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU8: Topology domain 3 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU8: Topology domain 4 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU8: Topology domain 5 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU8: Topology domain 6 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU9: Topology domain 1 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU9: Topology domain 2 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU9: Topology domain 3 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU9: Topology domain 4 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU9: Topology domain 5 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU9: Topology domain 6 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU10: Topology domain 1 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU10: Topology domain 2 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU10: Topology domain 3 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU10: Topology domain 4 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU10: Topology domain 5 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU10: Topology domain 6 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU11: Topology domain 1 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU11: Topology domain 2 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU11: Topology domain 3 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU11: Topology domain 4 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU11: Topology domain 5 shift 7 !=3D 6
[    0.009676] [Firmware Bug]: CPU11: Topology domain 6 shift 7 !=3D 6
[    0.120017]   #1  #3
[    0.121153] smp: Brought up 1 node, 12 CPUs
[    0.121153] smpboot: Total of 12 processors activated (62693.00 BogoMIPS)
[    0.123865] devtmpfs: initialized
[    0.123865] x86/mm: Memory block size: 128MB
[    0.124414] ACPI: PM: Registering ACPI NVS region [mem 0x7553e000-0x7561=
9fff] (901120 bytes)
[    0.124414] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.124414] futex hash table entries: 4096 (order: 6, 262144 bytes, line=
ar)
[    0.124414] pinctrl core: initialized pinctrl subsystem
[    0.124414] PM: RTC time: 05:47:18, date: 2024-05-31
[    0.124414] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.124414] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.124445] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.126649] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.126655] audit: initializing netlink subsys (disabled)
[    0.126674] audit: type=3D2000 audit(1717134438.013:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.126675] thermal_sys: Registered thermal governor 'fair_share'
[    0.126675] thermal_sys: Registered thermal governor 'bang_bang'
[    0.126676] thermal_sys: Registered thermal governor 'step_wise'
[    0.126676] thermal_sys: Registered thermal governor 'user_space'
[    0.126677] thermal_sys: Registered thermal governor 'power_allocator'
[    0.126683] cpuidle: using governor ladder
[    0.126685] cpuidle: using governor menu
[    0.126709] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.126709] PCI: ECAM [mem 0xc0000000-0xcfffffff] (base 0xc0000000) for =
domain 0000 [bus 00-ff]
[    0.126709] PCI: not using ECAM ([mem 0xc0000000-0xcfffffff] not reserve=
d)
[    0.126709] PCI: Using configuration type 1 for base access
[    0.126778] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.126781] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.126781] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.126781] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.126781] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.126794] Demotion targets for Node 0: null
[    0.126864] ACPI: Added _OSI(Module Device)
[    0.126864] ACPI: Added _OSI(Processor Device)
[    0.126864] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.126864] ACPI: Added _OSI(Processor Aggregator Device)
[    0.199620] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.T=
XHC.RHUB.SS01], AE_NOT_FOUND (20230628/dswload2-162)
[    0.199626] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (202306=
28/psobject-220)
[    0.199628] ACPI: Skipping parse of AML opcode: Scope (0x0010)
[    0.199630] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.T=
XHC.RHUB.SS02], AE_NOT_FOUND (20230628/dswload2-162)
[    0.199633] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (202306=
28/psobject-220)
[    0.199634] ACPI: Skipping parse of AML opcode: Scope (0x0010)
[    0.199636] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.T=
XHC.RHUB.SS03], AE_NOT_FOUND (20230628/dswload2-162)
[    0.199638] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (202306=
28/psobject-220)
[    0.199640] ACPI: Skipping parse of AML opcode: Scope (0x0010)
[    0.199642] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.T=
XHC.RHUB.SS04], AE_NOT_FOUND (20230628/dswload2-162)
[    0.199644] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (202306=
28/psobject-220)
[    0.199645] ACPI: Skipping parse of AML opcode: Scope (0x0010)
[    0.201314] ACPI: 14 ACPI AML tables successfully acquired and loaded
[    0.215758] ACPI: Dynamic OEM Table Load:
[    0.215766] ACPI: SSDT 0xFFFF9B5AC135E400 000394 (v02 PmRef  Cpu0Cst  00=
003001 INTL 20200717)
[    0.216692] ACPI: Dynamic OEM Table Load:
[    0.216697] ACPI: SSDT 0xFFFF9B5AC1386800 000605 (v02 PmRef  Cpu0Ist  00=
003000 INTL 20200717)
[    0.217654] ACPI: Dynamic OEM Table Load:
[    0.217658] ACPI: SSDT 0xFFFF9B5AC12C0600 0001AB (v02 PmRef  Cpu0Psd  00=
003000 INTL 20200717)
[    0.218528] ACPI: Dynamic OEM Table Load:
[    0.218532] ACPI: SSDT 0xFFFF9B5AC1380000 0004BA (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20200717)
[    0.219763] ACPI: Dynamic OEM Table Load:
[    0.219770] ACPI: SSDT 0xFFFF9B5AC1388000 001BAF (v02 PmRef  ApIst    00=
003000 INTL 20200717)
[    0.221325] ACPI: Dynamic OEM Table Load:
[    0.221331] ACPI: SSDT 0xFFFF9B5AC138C000 001038 (v02 PmRef  ApHwp    00=
003000 INTL 20200717)
[    0.222676] ACPI: Dynamic OEM Table Load:
[    0.222682] ACPI: SSDT 0xFFFF9B5AC138A000 001349 (v02 PmRef  ApPsd    00=
003000 INTL 20200717)
[    0.224102] ACPI: Dynamic OEM Table Load:
[    0.224108] ACPI: SSDT 0xFFFF9B5AC1365000 000FBB (v02 PmRef  ApCst    00=
003000 INTL 20200717)
[    0.228846] ACPI: _OSC evaluated successfully for all CPUs
[    0.228883] ACPI: EC: EC started
[    0.228884] ACPI: EC: interrupt blocked
[    0.234254] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.234256] ACPI: \_SB_.PC00.LPCB.H_EC: Boot DSDT EC used to handle tran=
sactions
[    0.234258] ACPI: Interpreter enabled
[    0.234302] ACPI: PM: (supports S0 S3 S4 S5)
[    0.234302] ACPI: Using IOAPIC for interrupt routing
[    0.235420] PCI: ECAM [mem 0xc0000000-0xcfffffff] (base 0xc0000000) for =
domain 0000 [bus 00-ff]
[    0.237249] PCI: ECAM [mem 0xc0000000-0xcfffffff] reserved as ACPI mothe=
rboard resource
[    0.237257] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.237258] PCI: Using E820 reservations for host bridge windows
[    0.238695] ACPI: Enabled 7 GPEs in block 00 to 7F
[    0.239495] ACPI: \_SB_.PC00.PEG1.PXP_: New power resource
[    0.240053] ACPI: \_SB_.PC00.PEG2.PXP_: New power resource
[    0.241237] ACPI: \_SB_.PC00.PEG0.PXP_: New power resource
[    0.372036] ACPI: \_SB_.PC00.RP05.PXP_: New power resource
[    0.380752] ACPI: \_SB_.PC00.PAUD: New power resource
[    0.389920] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    0.401851] ACPI: \PIN_: New power resource
[    0.402111] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-fe])
[    0.402116] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.403805] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR DPC]
[    0.405228] PCI host bridge to bus 0000:00
[    0.405230] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.405232] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.405234] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.405235] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000ffff=
f window]
[    0.405236] pci_bus 0000:00: root bus resource [mem 0x80400000-0xbffffff=
f window]
[    0.405237] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7ffff=
fffff window]
[    0.405239] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.405403] pci 0000:00:00.0: [8086:4601] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.405526] pci 0000:00:02.0: [8086:46a8] type 00 class 0x030000 PCIe Ro=
ot Complex Integrated Endpoint
[    0.405534] pci 0000:00:02.0: BAR 0 [mem 0x6001000000-0x6001ffffff 64bit]
[    0.405539] pci 0000:00:02.0: BAR 2 [mem 0x4000000000-0x400fffffff 64bit=
 pref]
[    0.405542] pci 0000:00:02.0: BAR 4 [io  0x4000-0x403f]
[    0.405556] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.405558] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.405582] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x00ffffff 64bit]
[    0.405583] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x06ffffff 64bit]=
: contains BAR 0 for 7 VFs
[    0.405587] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit =
pref]
[    0.405588] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit =
pref]: contains BAR 2 for 7 VFs
[    0.405714] pci 0000:00:04.0: [8086:461d] type 00 class 0x118000 convent=
ional PCI endpoint
[    0.405726] pci 0000:00:04.0: BAR 0 [mem 0x6002100000-0x600211ffff 64bit]
[    0.406071] pci 0000:00:06.0: [8086:464d] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.406101] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.406109] pci 0000:00:06.0:   bridge window [mem 0x80500000-0x805fffff]
[    0.406192] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.406229] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    0.406842] pci 0000:00:14.0: [8086:51ed] type 00 class 0x0c0330 convent=
ional PCI endpoint
[    0.406863] pci 0000:00:14.0: BAR 0 [mem 0x6002120000-0x600212ffff 64bit]
[    0.406947] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.408726] pci 0000:00:14.2: [8086:51ef] type 00 class 0x050000 convent=
ional PCI endpoint
[    0.408747] pci 0000:00:14.2: BAR 0 [mem 0x6002134000-0x6002137fff 64bit]
[    0.408760] pci 0000:00:14.2: BAR 2 [mem 0x600213b000-0x600213bfff 64bit]
[    0.408875] pci 0000:00:15.0: [8086:51e8] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.408897] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.409265] pci 0000:00:16.0: [8086:51e0] type 00 class 0x078000 convent=
ional PCI endpoint
[    0.409289] pci 0000:00:16.0: BAR 0 [mem 0x6002139000-0x6002139fff 64bit]
[    0.409374] pci 0000:00:16.0: PME# supported from D3hot
[    0.409674] pci 0000:00:17.0: [8086:51d3] type 00 class 0x010601 convent=
ional PCI endpoint
[    0.409690] pci 0000:00:17.0: BAR 0 [mem 0x80600000-0x80601fff]
[    0.409700] pci 0000:00:17.0: BAR 1 [mem 0x80603000-0x806030ff]
[    0.409708] pci 0000:00:17.0: BAR 2 [io  0x4090-0x4097]
[    0.409717] pci 0000:00:17.0: BAR 3 [io  0x4080-0x4083]
[    0.409726] pci 0000:00:17.0: BAR 4 [io  0x4060-0x407f]
[    0.409734] pci 0000:00:17.0: BAR 5 [mem 0x80602000-0x806027ff]
[    0.409782] pci 0000:00:17.0: PME# supported from D3hot
[    0.410077] pci 0000:00:1d.0: [8086:51b0] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.410104] pci 0000:00:1d.0: PCI bridge to [bus 02]
[    0.410109] pci 0000:00:1d.0:   bridge window [mem 0x80400000-0x804fffff]
[    0.410189] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.410220] pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
[    0.410769] pci 0000:00:1d.1: [8086:51b1] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.410796] pci 0000:00:1d.1: PCI bridge to [bus 03]
[    0.410800] pci 0000:00:1d.1:   bridge window [io  0x3000-0x3fff]
[    0.410811] pci 0000:00:1d.1:   bridge window [mem 0x6000000000-0x60000f=
ffff 64bit pref]
[    0.410882] pci 0000:00:1d.1: PME# supported from D0 D3hot D3cold
[    0.410913] pci 0000:00:1d.1: PTM enabled (root), 4ns granularity
[    0.411478] pci 0000:00:1f.0: [8086:5182] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.411869] pci 0000:00:1f.3: [8086:51c8] type 00 class 0x040100 convent=
ional PCI endpoint
[    0.411911] pci 0000:00:1f.3: BAR 0 [mem 0x6002130000-0x6002133fff 64bit]
[    0.411965] pci 0000:00:1f.3: BAR 4 [mem 0x6002000000-0x60020fffff 64bit]
[    0.412069] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.412365] pci 0000:00:1f.4: [8086:51a3] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.412386] pci 0000:00:1f.4: BAR 0 [mem 0x6002138000-0x60021380ff 64bit]
[    0.412408] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.412690] pci 0000:00:1f.5: [8086:51a4] type 00 class 0x0c8000 convent=
ional PCI endpoint
[    0.412709] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.416642] pci 0000:01:00.0: [1987:5013] type 00 class 0x010802 PCIe En=
dpoint
[    0.416658] pci 0000:01:00.0: BAR 0 [mem 0x80500000-0x80503fff 64bit]
[    0.417584] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.417834] pci 0000:02:00.0: [8086:095a] type 00 class 0x028000 PCIe En=
dpoint
[    0.417921] pci 0000:02:00.0: BAR 0 [mem 0x80400000-0x80401fff 64bit]
[    0.418266] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.419243] pci 0000:00:1d.0: PCI bridge to [bus 02]
[    0.419314] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000 PCIe En=
dpoint
[    0.419333] pci 0000:03:00.0: BAR 0 [io  0x3000-0x30ff]
[    0.419357] pci 0000:03:00.0: BAR 2 [mem 0x6000004000-0x6000004fff 64bit=
 pref]
[    0.419373] pci 0000:03:00.0: BAR 4 [mem 0x6000000000-0x6000003fff 64bit=
 pref]
[    0.419484] pci 0000:03:00.0: supports D1 D2
[    0.419485] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.419651] pci 0000:00:1d.1: PCI bridge to [bus 03]
[    0.423690] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.423778] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.423864] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.423950] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.424036] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.424122] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.424208] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.424294] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.431684] ACPI: EC: interrupt unblocked
[    0.431685] ACPI: EC: event unblocked
[    0.431707] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.431708] ACPI: EC: GPE=3D0x6e
[    0.431709] ACPI: \_SB_.PC00.LPCB.H_EC: Boot DSDT EC initialization comp=
lete
[    0.431710] ACPI: \_SB_.PC00.LPCB.H_EC: EC: Used to handle transactions =
and events
[    0.431760] iommu: Default domain type: Translated
[    0.431760] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.431760] SCSI subsystem initialized
[    0.431760] libata version 3.00 loaded.
[    0.431760] ACPI: bus type USB registered
[    0.431760] usbcore: registered new interface driver usbfs
[    0.431760] usbcore: registered new interface driver hub
[    0.431760] usbcore: registered new device driver usb
[    0.431760] EDAC MC: Ver: 3.0.0
[    0.431760] efivars: Registered efivars operations
[    0.433471] NetLabel: Initializing
[    0.433472] NetLabel:  domain hash size =3D 128
[    0.433473] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.433487] NetLabel:  unlabeled traffic allowed by default
[    0.433491] mctp: management component transport protocol core
[    0.433491] NET: Registered PF_MCTP protocol family
[    0.433494] PCI: Using ACPI for IRQ routing
[    0.453044] PCI: pci_cache_line_size set to 64 bytes
[    0.456819] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can't c=
laim; no compatible bridge window
[    0.457738] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.457739] e820: reserve RAM buffer [mem 0x407ce000-0x43ffffff]
[    0.457740] e820: reserve RAM buffer [mem 0x4244e000-0x43ffffff]
[    0.457741] e820: reserve RAM buffer [mem 0x6e4b1000-0x6fffffff]
[    0.457742] e820: reserve RAM buffer [mem 0x6ef4a000-0x6fffffff]
[    0.457742] e820: reserve RAM buffer [mem 0x71ca9000-0x73ffffff]
[    0.457743] e820: reserve RAM buffer [mem 0x76000000-0x77ffffff]
[    0.457744] e820: reserve RAM buffer [mem 0x87fc00000-0x87fffffff]
[    0.457769] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.457769] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.457769] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    0.457769] vgaarb: loaded
[    0.457769] clocksource: Switched to clocksource tsc-early
[    0.457769] VFS: Disk quotas dquot_6.6.0
[    0.457769] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.457769] pnp: PnP ACPI init
[    0.458605] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.458608] system 00:00: [io  0x164e-0x164f] has been reserved
[    0.458716] system 00:01: [io  0x1854-0x1857] has been reserved
[    0.460494] pnp 00:02: disabling [mem 0xc0000000-0xcfffffff] because it =
overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.460513] system 00:02: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.460515] system 00:02: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.460517] system 00:02: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.460518] system 00:02: [mem 0xfed20000-0xfed7ffff] could not be reser=
ved
[    0.460519] system 00:02: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.460520] system 00:02: [mem 0xfed45000-0xfed8ffff] could not be reser=
ved
[    0.460521] system 00:02: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    0.461221] system 00:04: [io  0x2000-0x20fe] has been reserved
[    0.461614] system 00:05: [mem 0xfe03e008-0xfe03efff] has been reserved
[    0.461616] system 00:05: [mem 0xfe03f000-0xfe03ffff] has been reserved
[    0.461981] pnp: PnP ACPI: found 6 devices
[    0.467279] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.467347] NET: Registered PF_INET protocol family
[    0.467550] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.478627] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6=
, 262144 bytes, linear)
[    0.478655] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.478803] TCP established hash table entries: 262144 (order: 9, 209715=
2 bytes, linear)
[    0.479084] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.479169] TCP: Hash tables configured (established 262144 bind 65536)
[    0.479286] MPTCP token hash table entries: 32768 (order: 7, 786432 byte=
s, linear)
[    0.479358] UDP hash table entries: 16384 (order: 7, 524288 bytes, linea=
r)
[    0.479422] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, =
linear)
[    0.479481] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.479487] NET: Registered PF_XDP protocol family
[    0.479501] pci 0000:00:02.0: VF BAR 2 [mem 0x4020000000-0x40ffffffff 64=
bit pref]: assigned
[    0.479506] pci 0000:00:02.0: VF BAR 0 [mem 0x4010000000-0x4016ffffff 64=
bit]: assigned
[    0.479508] pci 0000:00:15.0: BAR 0 [mem 0x4017000000-0x4017000fff 64bit=
]: assigned
[    0.479522] resource: avoiding allocation from e820 entry [mem 0x000a000=
0-0x000fffff]
[    0.479523] resource: avoiding allocation from e820 entry [mem 0x000a000=
0-0x000fffff]
[    0.479525] pci 0000:00:1f.5: BAR 0 [mem 0x80604000-0x80604fff]: assigned
[    0.479531] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.479546] pci 0000:00:06.0:   bridge window [mem 0x80500000-0x805fffff]
[    0.479565] pci 0000:00:1d.0: PCI bridge to [bus 02]
[    0.479570] pci 0000:00:1d.0:   bridge window [mem 0x80400000-0x804fffff]
[    0.479577] pci 0000:00:1d.1: PCI bridge to [bus 03]
[    0.479578] pci 0000:00:1d.1:   bridge window [io  0x3000-0x3fff]
[    0.479584] pci 0000:00:1d.1:   bridge window [mem 0x6000000000-0x60000f=
ffff 64bit pref]
[    0.479589] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.479591] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.479592] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.479593] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000fffff windo=
w]
[    0.479594] pci_bus 0000:00: resource 8 [mem 0x80400000-0xbfffffff windo=
w]
[    0.479595] pci_bus 0000:00: resource 9 [mem 0x4000000000-0x7fffffffff w=
indow]
[    0.479596] pci_bus 0000:01: resource 1 [mem 0x80500000-0x805fffff]
[    0.479597] pci_bus 0000:02: resource 1 [mem 0x80400000-0x804fffff]
[    0.479598] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
[    0.479599] pci_bus 0000:03: resource 2 [mem 0x6000000000-0x60000fffff 6=
4bit pref]
[    0.480958] PCI: CLS 64 bytes, default 64
[    0.480965] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.480965] software IO TLB: mapped [mem 0x000000005db10000-0x0000000061=
b10000] (64MB)
[    0.481017] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x25a=
39079a08, max_idle_ns: 440795310461 ns
[    0.481063] Trying to unpack rootfs image as initramfs...
[    0.481173] clocksource: Switched to clocksource tsc
[    0.481195] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)
[    0.487335] Initialise system trusted keyrings
[    0.487342] Key type blacklist registered
[    0.487401] workingset: timestamp_bits=3D41 max_order=3D23 bucket_order=
=3D0
[    0.487407] zbud: loaded
[    0.487478] fuse: init (API version 7.40)
[    0.487533] integrity: Platform Keyring initialized
[    0.487535] integrity: Machine keyring initialized
[    0.495079] Key type asymmetric registered
[    0.495081] Asymmetric key parser 'x509' registered
[    0.495095] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.495157] io scheduler mq-deadline registered
[    0.495158] io scheduler kyber registered
[    0.495164] io scheduler bfq registered
[    0.495533] pcieport 0000:00:06.0: PME: Signaling with IRQ 120
[    0.495741] pcieport 0000:00:1d.0: PME: Signaling with IRQ 121
[    0.495926] pcieport 0000:00:1d.1: PME: Signaling with IRQ 122
[    0.495997] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.497933] ACPI: AC: AC Adapter [ADP1] (on-line)
[    0.497968] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A0=
8:00/device:0b/PNP0C09:00/PNP0C0D:00/input/input0
[    0.497978] ACPI: button: Lid Switch [LID0]
[    0.498002] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[    0.498012] ACPI: button: Power Button [PWRB]
[    0.498029] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input2
[    0.498038] ACPI: button: Sleep Button [SLPB]
[    0.498057] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input3
[    0.498090] ACPI: button: Power Button [PWRF]
[    0.500781] thermal LNXTHERM:00: registered as thermal_zone0
[    0.500783] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    0.500949] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.504528] hpet_acpi_add: no address or irqs in _CRS
[    0.504557] Non-volatile memory driver v1.3
[    0.504558] Linux agpgart interface v0.103
[    0.511966] ACPI: bus type drm_connector registered
[    0.512658] ahci 0000:00:17.0: version 3.0
[    0.512805] ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 =
Gbps, SATA mode
[    0.512807] ahci 0000:00:17.0: 1/2 ports implemented (port mask 0x2)
[    0.512808] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio=
 slum part deso sadm sds=20
[    0.512971] scsi host0: ahci
[    0.513029] scsi host1: ahci
[    0.513045] ata1: DUMMY
[    0.513046] ata2: SATA max UDMA/133 abar m2048@0x80602000 port 0x8060218=
0 irq 123 lpm-pol 3
[    0.513092] usbcore: registered new interface driver usbserial_generic
[    0.513095] usbserial: USB Serial support registered for generic
[    0.513175] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.513202] ACPI: battery: Slot [BAT0] (battery present)
[    0.513337] Freeing initrd memory: 18300K
[    0.513985] rtc_cmos rtc_cmos: registered as rtc0
[    0.514150] rtc_cmos rtc_cmos: setting system clock to 2024-05-31T05:47:=
19 UTC (1717134439)
[    0.514169] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nv=
ram
[    0.514526] intel_pstate: Intel P-state driver initializing
[    0.515271] intel_pstate: HWP enabled
[    0.515327] ledtrig-cpu: registered to indicate activity on CPUs
[    0.515488] [drm] Initialized simpledrm 1.0.0 20200625 for simple-frameb=
uffer.0 on minor 0
[    0.515759] fbcon: Deferring console take-over
[    0.515761] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.515789] hid: raw HID events driver (C) Jiri Kosina
[    0.515842] drop_monitor: Initializing network drop monitor service
[    0.515919] NET: Registered PF_INET6 protocol family
[    0.519909] Segment Routing with IPv6
[    0.519911] RPL Segment Routing with IPv6
[    0.519916] In-situ OAM (IOAM) with IPv6
[    0.519933] NET: Registered PF_PACKET protocol family
[    0.520538] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.520784] microcode: Current revision: 0x00000433
[    0.520784] microcode: Updated early from: 0x0000041b
[    0.521033] resctrl: L2 allocation detected
[    0.521042] IPI shorthand broadcast: enabled
[    0.521914] sched_clock: Marking stable (514686506, 6343531)->(542413923=
, -21383886)
[    0.522031] Timer migration: 2 hierarchy levels; 8 children per group; 2=
 crossnode level
[    0.522134] registered taskstats version 1
[    0.522398] Loading compiled-in X.509 certificates
[    0.523934] Loaded X.509 cert 'Build time autogenerated kernel key: eba0=
468f1bde3ca892316281e0e049bc0db5b106'
[    0.526616] zswap: loaded using pool zstd/zsmalloc
[    0.526782] Key type .fscrypt registered
[    0.526782] Key type fscrypt-provisioning registered
[    0.527014] integrity: Loading X.509 certificate: UEFI:db
[    0.527028] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.527029] integrity: Loading X.509 certificate: UEFI:db
[    0.527039] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.527040] integrity: Loading X.509 certificate: UEFI:db
[    0.529193] integrity: Loaded X.509 cert 'my Signature Database key: f55=
742b17ee4c75ecb4f66293e2fbceddefed102'
[    0.529943] PM:   Magic number: 8:89:771
[    0.531587] RAS: Correctable Errors collector initialized.
[    0.825519] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.828720] ata2.00: ATA-10: Hanstor M.2 1TB, U0510A0, max UDMA/133
[    0.830242] ata2.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth 32), =
AA
[    0.837166] ata2.00: configured for UDMA/133
[    0.848231] scsi 1:0:0:0: Direct-Access     ATA      Hanstor M.2 1TB  0A=
0  PQ: 0 ANSI: 5
[    0.851365] sd 1:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/932 GiB)
[    0.851400] sd 1:0:0:0: [sda] Write Protect is off
[    0.851406] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.851431] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.851478] sd 1:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    0.856137]  sda: sda1
[    0.856551] sd 1:0:0:0: [sda] Attached SCSI disk
[    0.856827] clk: Disabling unused clocks
[    0.856838] PM: genpd: Disabling unused power domains
[    0.866251] Freeing unused decrypted memory: 2028K
[    0.866613] Freeing unused kernel image (initmem) memory: 3412K
[    0.866614] Write protecting the kernel read-only data: 32768k
[    0.867150] Freeing unused kernel image (rodata/data gap) memory: 1040K
[    0.872252] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.872255] rodata_test: all tests were successful
[    0.872258] Run /init as init process
[    0.872259]   with arguments:
[    0.872260]     /init
[    0.872260]   with environment:
[    0.872261]     HOME=3D/
[    0.872261]     TERM=3Dlinux
[    0.872262]     split_lock_detect=3Doff
[    0.891199] systemd[1]: systemd 255.7-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZST=
D +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    0.891204] systemd[1]: Detected architecture x86-64.
[    0.891206] systemd[1]: Running in initrd.
[    0.891305] systemd[1]: Initializing machine ID from random generator.
[    0.946042] systemd[1]: Queued start job for default target Initrd Defau=
lt Target.
[    0.948536] systemd[1]: Expecting device /dev/disk/by-uuid/9bf7c08f-ded6=
-4cf7-864f-9eb6b26c33ae...
[    0.948574] systemd[1]: Reached target Path Units.
[    0.948582] systemd[1]: Reached target Slice Units.
[    0.948588] systemd[1]: Reached target Swaps.
[    0.948594] systemd[1]: Reached target Timer Units.
[    0.948645] systemd[1]: Listening on Journal Socket (/dev/log).
[    0.948678] systemd[1]: Listening on Journal Socket.
[    0.948715] systemd[1]: Listening on udev Control Socket.
[    0.948739] systemd[1]: Listening on udev Kernel Socket.
[    0.948744] systemd[1]: Reached target Socket Units.
[    0.948758] systemd[1]: Create List of Static Device Nodes was skipped b=
ecause of an unmet condition check (ConditionFileNotEmpty=3D/lib/modules/6.=
9.2-arch1-1.5/modules.devname).
[    0.949222] systemd[1]: Starting Check battery level during early boot...
[    0.950071] systemd[1]: Starting Journal Service...
[    0.950435] systemd[1]: Starting Load Kernel Modules...
[    0.950456] systemd[1]: TPM2 PCR Barrier (initrd) was skipped because of=
 an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    0.950836] systemd[1]: Starting Create Static Device Nodes in /dev...
[    0.951184] systemd[1]: Starting Coldplug All udev Devices...
[    0.955417] systemd[1]: Finished Load Kernel Modules.
[    0.956884] systemd[1]: Finished Create Static Device Nodes in /dev.
[    0.957686] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
[    0.958793] systemd-journald[159]: Collecting audit messages is disabled.
[    0.966792] systemd[1]: Finished Check battery level during early boot.
[    0.967324] systemd[1]: Started Displays emergency message in full scree=
n..
[    0.967614] systemd[1]: Started Journal Service.
[    1.026871] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.026879] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    1.027977] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x1=
20 quirks 0x0000100200009810
[    1.028223] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.028226] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    1.028229] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    1.028292] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.09
[    1.028295] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.028296] usb usb1: Product: xHCI Host Controller
[    1.028297] usb usb1: Manufacturer: Linux 6.9.2-arch1-1.5 xhci-hcd
[    1.028298] usb usb1: SerialNumber: 0000:00:14.0
[    1.028425] hub 1-0:1.0: USB hub found
[    1.028460] hub 1-0:1.0: 12 ports detected
[    1.029548] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.09
[    1.029550] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.029551] usb usb2: Product: xHCI Host Controller
[    1.029552] usb usb2: Manufacturer: Linux 6.9.2-arch1-1.5 xhci-hcd
[    1.029553] usb usb2: SerialNumber: 0000:00:14.0
[    1.029602] hub 2-0:1.0: USB hub found
[    1.029614] hub 2-0:1.0: 4 ports detected
[    1.030003] usb: port power management may be unreliable
[    1.036792] nvme 0000:01:00.0: platform quirk: setting simple suspend
[    1.036849] nvme nvme0: pci function 0000:01:00.0
[    1.059182] nvme nvme0: missing or invalid SUBNQN field.
[    1.104650] nvme nvme0: allocated 128 MiB host memory buffer.
[    1.105572] nvme nvme0: 8/0/0 default/read/poll queues
[    1.108706]  nvme0n1: p1 p2 p3 p4 p5 p6 p7 p8 p9
[    1.274020] PM: Image not found (code -22)
[    1.279840] usb 1-4: new full-speed USB device number 2 using xhci_hcd
[    1.326702] i915 0000:00:02.0: vgaarb: deactivate vga console
[    1.326765] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[    1.327329] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    1.329445] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/=
adlp_dmc.bin (v2.20)
[    1.334609] EXT4-fs (nvme0n1p8): mounted filesystem 9bf7c08f-ded6-4cf7-8=
64f-9eb6b26c33ae r/w with ordered data mode. Quota mode: none.
[    1.344753] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/adlp_guc_70.=
bin version 70.20.0
[    1.344758] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin =
version 7.9.3
[    1.360660] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all wor=
kloads
[    1.361356] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[    1.361358] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[    1.361712] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[    1.362281] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected c=
ontent support initialized
[    1.425715] usb 1-4: New USB device found, idVendor=3D8087, idProduct=3D=
0a2a, bcdDevice=3D 0.01
[    1.425732] usb 1-4: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    1.549849] usb 1-5: new high-speed USB device number 3 using xhci_hcd
[    1.715895] usb 1-5: New USB device found, idVendor=3D0c45, idProduct=3D=
6711, bcdDevice=3D40.24
[    1.715925] usb 1-5: New USB device strings: Mfr=3D2, Product=3D1, Seria=
lNumber=3D0
[    1.715937] usb 1-5: Product: USB 2.0 Camera
[    1.715945] usb 1-5: Manufacturer: Sonix Technology Co., Ltd.
[    2.572682] [drm] Initialized i915 1.6.0 20230929 for 0000:00:02.0 on mi=
nor 1
[    2.578964] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  =
post: no)
[    2.580238] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input4
[    2.597131] fbcon: i915drmfb (fb0) is primary device
[    2.597145] fbcon: Deferring console take-over
[    2.597156] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    2.852282] systemd-journald[159]: Received SIGTERM from PID 1 (systemd).
[    2.936207] systemd[1]: systemd 255.7-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZST=
D +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    2.936212] systemd[1]: Detected architecture x86-64.
[    2.936983] systemd[1]: Hostname set to <FIRE>.
[    3.366825] systemd[1]: bpf-lsm: LSM BPF program attached
[    3.502058] systemd[1]: initrd-switch-root.service: Deactivated successf=
ully.
[    3.502125] systemd[1]: Stopped Switch Root.
[    3.502488] systemd[1]: systemd-journald.service: Scheduled restart job,=
 restart counter is at 1.
[    3.502666] systemd[1]: Created slice Slice /system/dirmngr.
[    3.502783] systemd[1]: Created slice Slice /system/getty.
[    3.502895] systemd[1]: Created slice Slice /system/gpg-agent.
[    3.503007] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    3.503127] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    3.503224] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    3.503322] systemd[1]: Created slice Slice /system/keyboxd.
[    3.503420] systemd[1]: Created slice Slice /system/modprobe.
[    3.503516] systemd[1]: Created slice Slice /system/systemd-fsck.
[    3.503582] systemd[1]: Created slice User and Session Slice.
[    3.503605] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    3.503621] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    3.503690] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    3.503697] systemd[1]: Expecting device /dev/disk/by-uuid/d3fa04da-cb55=
-4ff4-a93b-92256084412c...
[    3.503701] systemd[1]: Reached target Local Encrypted Volumes.
[    3.503713] systemd[1]: Stopped target Switch Root.
[    3.503719] systemd[1]: Stopped target Initrd File Systems.
[    3.503723] systemd[1]: Stopped target Initrd Root File System.
[    3.503729] systemd[1]: Reached target Local Integrity Protected Volumes.
[    3.503740] systemd[1]: Reached target Remote File Systems.
[    3.503746] systemd[1]: Reached target Slice Units.
[    3.503761] systemd[1]: Reached target Local Verity Protected Volumes.
[    3.503791] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.505455] systemd[1]: Listening on Process Core Dump Socket.
[    3.505471] systemd[1]: TPM2 PCR Extension (Varlink) was skipped because=
 of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.505581] systemd[1]: Listening on udev Control Socket.
[    3.505608] systemd[1]: Listening on udev Kernel Socket.
[    3.543585] systemd[1]: Mounting Huge Pages File System...
[    3.545205] systemd[1]: Mounting POSIX Message Queue File System...
[    3.546304] systemd[1]: Mounting Kernel Debug File System...
[    3.547491] systemd[1]: Mounting Kernel Trace File System...
[    3.548585] systemd[1]: Starting Create List of Static Device Nodes...
[    3.549256] systemd[1]: Starting Load Kernel Module configfs...
[    3.549847] systemd[1]: Starting Load Kernel Module dm_mod...
[    3.550458] systemd[1]: Starting Load Kernel Module drm...
[    3.551055] systemd[1]: Starting Load Kernel Module fuse...
[    3.551455] systemd[1]: Starting Load Kernel Module loop...
[    3.552374] systemd[1]: Starting Journal Service...
[    3.553182] systemd[1]: Starting Load Kernel Modules...
[    3.553198] systemd[1]: TPM2 PCR Machine ID Measurement was skipped beca=
use of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.553821] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.553865] systemd[1]: TPM2 SRK Setup (Early) was skipped because of an=
 unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.554445] systemd[1]: Starting Coldplug All udev Devices...
[    3.555259] systemd[1]: Mounted Huge Pages File System.
[    3.555334] systemd[1]: Mounted POSIX Message Queue File System.
[    3.555396] systemd[1]: Mounted Kernel Debug File System.
[    3.555454] systemd[1]: Mounted Kernel Trace File System.
[    3.555586] systemd[1]: Finished Create List of Static Device Nodes.
[    3.555752] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    3.555841] systemd[1]: Finished Load Kernel Module configfs.
[    3.556005] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    3.556085] systemd[1]: Finished Load Kernel Module drm.
[    3.556236] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    3.556315] systemd[1]: Finished Load Kernel Module fuse.
[    3.556997] systemd[1]: Mounting FUSE Control File System...
[    3.557235] loop: module loaded
[    3.557539] systemd[1]: Mounting Kernel Configuration File System...
[    3.558107] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[    3.558347] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    3.558455] systemd[1]: Finished Load Kernel Module loop.
[    3.561138] systemd[1]: Mounted FUSE Control File System.
[    3.561313] systemd[1]: Mounted Kernel Configuration File System.
[    3.562630] device-mapper: uevent: version 1.0.3
[    3.562699] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@lists.linux.dev
[    3.563505] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[    3.563696] systemd[1]: Finished Load Kernel Module dm_mod.
[    3.563834] systemd-journald[286]: Collecting audit messages is disabled.
[    3.563841] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[    3.565832] i2c_dev: i2c /dev entries driver
[    3.567875] systemd[1]: Started Journal Service.
[    3.579892] EXT4-fs (nvme0n1p8): re-mounted 9bf7c08f-ded6-4cf7-864f-9eb6=
b26c33ae r/w. Quota mode: none.
[    3.587820] systemd-journald[286]: Received client request to flush runt=
ime journal.
[    3.703576] systemd-journald[286]: /var/log/journal/bd024c881a1f4958a55e=
8145fab6de4c/system.journal: Journal file uses a different sequence number =
ID, rotating.
[    3.703598] systemd-journald[286]: Rotating system journal.
[    4.386978] Adding 4194300k swap on /swapfile.  Priority:-2 extents:192 =
across:59072512k SSDsc
[    4.429025] Consider using thermal netlink events interface
[    4.430972] input: Intel HID events as /devices/platform/INTC1070:00/inp=
ut/input5
[    4.432088] intel-hid INTC1070:00: platform supports 5 button array
[    4.433976] input: Intel HID 5 button array as /devices/platform/INTC107=
0:00/input/input6
[    4.439206] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    4.439209] i8042: PNP: PS/2 appears to have AUX port disabled, if this =
is incorrect please boot with i8042.nopnp
[    4.441089] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.441235] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.L=
PCB.H_EC.CHRG.PPSS.FCHG], AE_NOT_FOUND (20230628/psargs-330)
[    4.441244] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.CHRG.PPSS du=
e to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    4.444127] intel_pmc_core INT33A1:00:  initialized
[    4.456124] resource: resource sanity check: requesting [mem 0x00000000f=
edc0000-0x00000000fedcffff], which spans more than pnp 00:02 [mem 0xfedc000=
0-0xfedc7fff]
[    4.456130] caller igen6_probe+0x15e/0x7c0 [igen6_edac] mapping multiple=
 BARs
[    4.458241] EDAC MC0: Giving out device to module igen6_edac controller =
Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
[    4.458686] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    4.458876] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    4.458920] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    4.461071] EDAC MC1: Giving out device to module igen6_edac controller =
Intel_client_SoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
[    4.461093] EDAC igen6 MC1: HANDLING IBECC MEMORY ERROR
[    4.461095] EDAC igen6 MC1: ADDR 0x7fffffffe0=20
[    4.461096] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[    4.461097] EDAC igen6 MC0: ADDR 0x7fffffffe0=20
[    4.461969] EDAC igen6: v2.5.1
[    4.464866] i2c i2c-10: Successfully instantiated SPD at 0x50
[    4.473864] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    4.479697] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    4.480053] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    4.492867] mei_me 0000:00:16.0: hbm: dma setup response: failure =3D 3 =
REJECTED
[    4.551117] intel_rapl_msr: PL4 support detected.
[    4.551220] intel_rapl_common: Found RAPL domain package
[    4.551227] intel_rapl_common: Found RAPL domain core
[    4.551229] intel_rapl_common: Found RAPL domain uncore
[    4.551232] intel_rapl_common: Found RAPL domain psys
[    4.552031] ee1004 10-0050: 512 byte EE1004-compliant SPD EEPROM, read-o=
nly
[    4.552284] EXT4-fs (nvme0n1p9): mounted filesystem d3fa04da-cb55-4ff4-a=
93b-92256084412c r/w with ordered data mode. Quota mode: none.
[    4.552479] mc: Linux media interface: v0.10
[    4.558644] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/261)
[    4.559720] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/33030)
[    4.560705] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/1157)
[    4.561705] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/2309)
[    4.562732] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/405)
[    4.563748] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/661)
[    4.564751] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/4213)
[    4.565789] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/9474)
[    4.566793] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/897)
[    4.567830] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/49154)
[    4.568832] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/33105)
[    4.569842] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/9731)
[    4.570853] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/38160)
[    4.571861] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/1941)
[    4.572862] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/38145)
[    4.573896] i2c_hid_acpi i2c-XXXX0000:01: i2c_hid_get_input: incomplete =
report (27/49154)
[    4.587651] Bluetooth: Core ver 2.22
[    4.587667] NET: Registered PF_BLUETOOTH protocol family
[    4.587668] Bluetooth: HCI device and connection manager initialized
[    4.587671] Bluetooth: HCI socket layer initialized
[    4.587673] Bluetooth: L2CAP socket layer initialized
[    4.587676] Bluetooth: SCO socket layer initialized
[    4.588295] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    4.588468] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.588589] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db1=
8c600'
[    4.756705] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: =
bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[    4.760537] input: XXXX0000:01 0911:5288 Mouse as /devices/pci0000:00/00=
00:00:15.0/i2c_designware.0/i2c-11/i2c-XXXX0000:01/0018:0911:5288.0001/inpu=
t/input7
[    4.761150] input: XXXX0000:01 0911:5288 Touchpad as /devices/pci0000:00=
/0000:00:15.0/i2c_designware.0/i2c-11/i2c-XXXX0000:01/0018:0911:5288.0001/i=
nput/input8
[    4.761283] hid-generic 0018:0911:5288.0001: input,hidraw0: I2C HID v1.0=
0 Mouse [XXXX0000:01 0911:5288] on i2c-XXXX0000:01
[    4.761225] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: b=
ound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
[    4.763467] r8169 0000:03:00.0: enabling device (0000 -> 0003)
[    4.763608] Creating 1 MTD partitions on "0000:00:1f.5":
[    4.763612] 0x000000000000-0x000002000000 : "BIOS"
[    4.763686] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input9
[    4.767314] r8169 0000:03:00.0 eth0: RTL8168evl/8111evl, 00:00:00:00:00:=
03, XID 2c9, IRQ 136
[    4.767319] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    4.769524] Intel(R) Wireless WiFi driver for Linux
[    4.770780] r8169 0000:03:00.0 enp3s0: renamed from eth0
[    4.772922] videodev: Linux video capture interface: v2.00
[    4.773086] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360=
 ms ovfl timer
[    4.773095] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    4.773096] RAPL PMU: hw unit of domain package 2^-14 Joules
[    4.773097] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    4.773098] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    4.776052] proc_thermal_pci 0000:00:04.0: enabling device (0000 -> 0002)
[    4.776248] intel_rapl_common: Found RAPL domain package
[    4.776298] cryptd: max_cpu_qlen set to 1000
[    4.782195] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
[    4.783954] iwlwifi 0000:02:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm i=
d 0x0
[    4.784012] iwlwifi 0000:02:00.0: PCI dev 095a/5410, rev=3D0x210, rfid=
=3D0xd55555d5
[    4.785666] AVX2 version of gcm_enc/dec engaged.
[    4.785706] AES CTR mode by8 optimization enabled
[    4.790755] iwlwifi 0000:02:00.0: Found debug destination: EXTERNAL_DRAM
[    4.790758] iwlwifi 0000:02:00.0: Found debug configuration: 0
[    4.790902] iwlwifi 0000:02:00.0: loaded firmware version 29.4063824552.=
0 7265D-29.ucode op_mode iwlmvm
[    4.792801] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subc=
lass/prog-if info 0x040100
[    4.792898] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[    4.793074] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_aud=
io_component_bind_ops [i915])
[    4.796184] pps_core: LinuxPPS API ver. 1 registered
[    4.796186] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    4.798892] usb 1-5: Found UVC 1.00 device USB 2.0 Camera (0c45:6711)
[    4.800514] PTP clock support registered
[    4.827283] usbcore: registered new interface driver uvcvideo
[    4.839865] input: XXXX0000:01 0911:5288 Mouse as /devices/pci0000:00/00=
00:00:15.0/i2c_designware.0/i2c-11/i2c-XXXX0000:01/0018:0911:5288.0001/inpu=
t/input10
[    4.839939] input: XXXX0000:01 0911:5288 Touchpad as /devices/pci0000:00=
/0000:00:15.0/i2c_designware.0/i2c-11/i2c-XXXX0000:01/0018:0911:5288.0001/i=
nput/input11
[    4.840060] hid-multitouch 0018:0911:5288.0001: input,hidraw0: I2C HID v=
1.00 Mouse [XXXX0000:01 0911:5288] on i2c-XXXX0000:01
[    4.887415] mousedev: PS/2 mouse device common for all mice
[    4.890030] usbcore: registered new interface driver btusb
[    4.893692] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269VB: =
line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    4.893697] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    4.893699] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)
[    4.893701] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[    4.893702] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    4.893703] snd_hda_codec_realtek hdaudioC0D0:      Mic=3D0x18
[    4.893704] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D0x19
[    4.893705] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=3D0x12
[    4.905174] Bluetooth: hci0: Legacy ROM 2.5 revision 1.0 build 3 week 17=
 2014
[    4.905178] Bluetooth: hci0: Intel device is already patched. patch num:=
 39
[    4.909354] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless A=
C 7265, REV=3D0x210
[    4.909398] thermal thermal_zone4: failed to read out thermal zone (-61)
[    4.918625] intel_tcc_cooling: TCC Offset locked
[    4.923210] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    4.923672] iwlwifi 0000:02:00.0: Allocated 0x00400000 bytes for firmwar=
e monitor.
[    4.928550] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3=
/sound/card0/input12
[    4.928581] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:0=
0:1f.3/sound/card0/input13
[    4.928606] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input14
[    4.928639] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input15
[    4.928662] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input16
[    4.928685] input: HDA Intel PCH HDMI/DP,pcm=3D9 as /devices/pci0000:00/=
0000:00:1f.3/sound/card0/input17
[    4.929806] iwlwifi 0000:02:00.0: base HW address: 18:5e:0f:5e:3b:66, OT=
P minor version: 0x0
[    4.991243] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    4.992788] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
[    5.054063] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.054065] Bluetooth: BNEP filters: protocol multicast
[    5.054068] Bluetooth: BNEP socket layer initialized
[    5.055183] Bluetooth: MGMT ver 1.22
[    5.055254] Bluetooth: ISO socket layer initialized
[    5.060623] NET: Registered PF_ALG protocol family
[    5.167026] RTL8211E Gigabit Ethernet r8169-0-300:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)
[    5.392203] r8169 0000:03:00.0 enp3s0: Link is Down
[    5.411876] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    5.492949] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    5.495521] iwlwifi 0000:02:00.0: FW already configured (0) - re-configu=
ring
[    5.511063] iwlwifi 0000:02:00.0: Registered PHC clock: iwlwifi-PTP, wit=
h index: 0
[    5.585991] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    5.670127] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DR=
AM
[    5.673758] iwlwifi 0000:02:00.0: FW already configured (0) - re-configu=
ring
[    5.971943] fbcon: Taking over console
[    5.985774] Console: switching to colour frame buffer device 240x67
[    8.394847] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow co=
ntrol rx/tx
[   10.045280] input: Baseus F02 Mouse  Keyboard as /devices/virtual/misc/u=
hid/0005:045E:0040.0002/input/input18
[   10.045835] input: Baseus F02 Mouse  Mouse as /devices/virtual/misc/uhid=
/0005:045E:0040.0002/input/input19
[   10.046036] hid-generic 0005:045E:0040.0002: input,hidraw1: BLUETOOTH HI=
D v3.00 Keyboard [Baseus F02 Mouse ] on 18:5e:0f:5e:3b:6a
[   15.474181] systemd-journald[286]: /var/log/journal/bd024c881a1f4958a55e=
8145fab6de4c/user-1000.journal: Journal file uses a different sequence numb=
er ID, rotating.
[   20.092180] ntfs3: Max link count 4000
[   20.092184] ntfs3: Enabled Linux POSIX ACLs support
[   20.092185] ntfs3: Read-only LZX/Xpress compression included
[   20.168589] Bluetooth: RFCOMM TTY layer initialized
[   20.168597] Bluetooth: RFCOMM socket layer initialized
[   20.168600] Bluetooth: RFCOMM ver 1.11
[   20.371050] warning: `crow' uses wireless extensions which will stop wor=
king for Wi-Fi 7 hardware; use nl80211

--3jjvrasvvktm7dvp--

--lxbuttwjsf2jgram
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmZZh2wACgkQwEfU8yi1
JYULvA/+N/ufZ+NsCZRibGmvKwQO5yRS8H+d2V6D2/WEcIUZNDVnCrsjMH48ktkk
158U/Qg+mky3mSC0rW+ngKyLGGxic675OgHJe1hQWanhODbICw2gSVLSwPfh7Xme
cJGqhfupf2yvpr57rUTgDF5Y9p9fzL5twMBC2kJRAAjuY78MxqkNMZwIfppbXHC4
fuNNSdGtyGD7hSM61qG6/Cy6g9yiNxfGGqxBjLe6ALiWn6nscipXOp41A6ID4W02
B1SfqKc1giRspy+ivKazjNxErSZlyWcSc3Qft9cHWccX2WOXFrijTFq9G90TUswG
eHCsfg4ZaQTa5PcruB7Uf8E6nR0Jfy6K7Eyx/v7roHsq7tyiT4ohUMDKBUpnSUrX
Wb2ei/G+GDQPIZVuEDMkWMzf0r1vo3ypUb0YvhBKqzbPhqLBxpUUKRjB2tpYC+Fr
RG1jTeHN5JoHdxq1J1ZSFmBaouE1daxT6I62VTQUe8bSqdLLbH6k+/vy0KbErNSI
uiZSeWkqzVIai6zgeuLG3tgskmgblmF2wqcOhFvHEY8umD9MG9H5+AyvkS1uykOo
YhIRlxObhEWUTi1MLtpcilNljmEwhtxAXqZkjhFjknADSbdR+6h5d66y+7punLQM
iloS0OEKi0nAarpS6zZGtxpTtDuEi8jMkVbR2JQ1Jjd/5/KYGu4=
=otBF
-----END PGP SIGNATURE-----

--lxbuttwjsf2jgram--

