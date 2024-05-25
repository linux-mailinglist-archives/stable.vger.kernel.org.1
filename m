Return-Path: <stable+bounces-46114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E01E8CED32
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 02:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A483B1C2110B
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 00:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A1B394;
	Sat, 25 May 2024 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="iq1JB0aB"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA5810F2;
	Sat, 25 May 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716596292; cv=none; b=pZmBYa1P40idqwX23bjZk0yg4mqObLfcZyBpAXTFrNSlvaRu2LFLP3/kBnlNTe2jS0EzpDNMWKBjoQZ1l+YKdDyPxby5GBb18a1xNeQep2Sj3dNrgjUHRbeEXE6zb/nfXE7HC4izwI3hAIuUR7+JTLGdkALwrcHTFq7ecIZyOFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716596292; c=relaxed/simple;
	bh=g2YpkCa++mWB06XQKXaQcDZv0iITlWh/+vnkh5nDjg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7+rpWhu8jcLpMfrmaokaNLojJ6On1l3Dd6A67hAF8JyVDTE1KW1In98gf1jWYbZ5zqPt8V46xa6+3XMSzmG3qo3p7R06BvbMeiUAx7l2bbuIoCXpTDlU4XJhKde+rPaC/L/aGPTWTaFJLwPJLh9J0stOabwBn+5VLNhktWioT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=iq1JB0aB; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1716596270; x=1717201070; i=christian@heusel.eu;
	bh=SUCS8V23Khio2gHmGSBe9O8TzAcnPAuFb816F8Kghvc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iq1JB0aB8h3RqSTr+3nLtSv3LqRbKOBv4v2ETzA7gqCNiipMMMmJSZGZ2Ni/gZLM
	 EMHlsLCqzUcQB7eJpBxBBpzyDlNqFfF8rxe07WVmoNnpe1N9CWRyVZlvQEUEIpSJ7
	 88Dgw/C9K6+UaNLwAvgT7AAFnyA5W8TG6LqK3+GzV1N+p64GvEJ7hVNRa7/A7qhuA
	 6C8DDkLPyw39ZVJxZSvTHvybJY8zuR34tdJxUQHMgAfZDlnNnJJlJ7dRhEB14XQRo
	 r9P81hFZVOSnBuli5HrsnQgGVC7n0vkHE1gDyVMT4HTfmVI82X4d5EanbGAo4uLj1
	 DqTQA374dCZmk/87Mg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M4K2r-1sAO2G0CO1-000P0q; Sat, 25
 May 2024 02:12:13 +0200
Date: Sat, 25 May 2024 02:12:12 +0200
From: Christian Heusel <christian@heusel.eu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: regressions@lists.linux.dev, Tim Teichmann <teichmanntim@outlook.de>, 
	x86@kernel.org, stable@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Scheduling errors with the AMD FX 8300 CPU
Message-ID: <gtgsklvltu5pzeiqn7fwaktdsywk2re75unapgbcarlmqkya5a@mt7pi4j2f7b3>
References: <7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk>
 <87r0dqdf0r.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t5o7sbkvmfmzj3pc"
Content-Disposition: inline
In-Reply-To: <87r0dqdf0r.ffs@tglx>
X-Provags-ID: V03:K1:b4XvyJRjeltDsheNFN7/9G0dvH9uKDdA2/uXMtgg3nbk2QAliau
 GMTHJfyjzv/LxYieLOLU13+jpK+9qgD3S2xNoxFDdw2dpo9Isocy0BxsU8+aHavGq7f0+K+
 nS4lDU/M+WGpsqPy9C/JNzIL/2niAbfckY1S86PRroAAxkHrKRYp17n6o7ScgU838kr8IDO
 qsQdRdtBsbLRpQ/M41CHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TrIEn7m9UZg=;1NUD6gdrsMFKGxDWOKnEtwrD5HQ
 VxptWxS3ORLNluovoqKJf+YRatgDEY9sosYB1tkoP85eBjvS0PtVTv9dvM925SZpNSaFmbvYp
 QlGOHHKF44e6+M2qIlM6tY5KvflHcqt0H4AC635RKtIbb9hXm1S0AUCIAnAamg0Evqd+Ru399
 9VDjHmU3uhx+c3bb0+rTJQjg8UHLPO5elY34jHaKN3MPiy6yYWYHdsHgHn7GSQlTIwiTZru0F
 SChP2OLyNt7vkE4+IiU8cENjoiIndVXdhMHBS7ni3W7JYBIqtt+blfUy7qOw+7XGtIj8HvGvn
 jOrQkDA97C2Azhi5wzftn26FTgH8UQpsRAZzkHcw34okJn21leQGpIYdOtKicbsKel0Yy0QeH
 aMbJFWHFSUrb+UKtWAJti5AkvQkCSjNEDZv8AfI5S6L4gpHei4vFhdtnuK8O0/a9HP9RlAx55
 sMKGprYNuaMS1ybU2iY9kFuwys5VUsmpIWHuyZ9zOZtWK5WkM9j1xbcvbSGMue1Y/iusnRlwQ
 s8Qah3CUMiFAx0nPuGW2jdqy4k8HejeUsxzLA3G6yUIkAP8pe7aWxYdbIHsEtes1gMEyawMeU
 w5SBI0XS7hngtTxlnJTx4BSeBeXpyTeU5ldQ7jwfHTpQfFYsBaYLU4VWkml0V6MR0BdE0XAfB
 GhrOE3cfd7xiCMMeHTsOzacPPejhwvlfWa8qYqfHutUcKIgn7Lxz0kKqnQ/UVjg8EoiHDu7iR
 1P5D6/g6nN5nYgLB3YYZRkh5J+RX2aV5eKxToLAKAw2ed5iTBlWO9I=


--t5o7sbkvmfmzj3pc
Content-Type: multipart/mixed; boundary="izkgikfoc2krw74l"
Content-Disposition: inline


--izkgikfoc2krw74l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/05/25 12:24AM, Thomas Gleixner wrote:
> Christian!
>=20
> On Fri, May 24 2024 at 23:23, Christian Heusel wrote:
>=20
> > May 23 23:36:49 archlinux kernel: smp: Bringing up secondary CPUs ...
>=20
> Can you please provide the full boot log as the information which leads
> up to the symptom is obviously more interesting than the symptom itself.

I have attached the full dmesg of an example of a bad boot (from doing
the bisection), sorry that I missed that when putting together the
initial report!

Also thanks for the quick response, enjoy your weekend!

Cheers,
chris

--izkgikfoc2krw74l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="dmesg_6.8.0-1-mainline-08073-g480e035fc4c7.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.8.0-1-mainline-08073-g480e035fc4c7 (linux-ma=
inline@archlinux) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU Binutils) 2.42.0)=
 #1 SMP PREEMPT_DYNAMIC Thu, 23 May 2024 21:57:23 +0000
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-linux-mainline root=3DUU=
ID=3D963daeed-0888-4658-9f17-18bd343dfb2a rw zswap.enabled=3D0 rootfstype=
=3Dext4 loglevel=3D3 quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bfdeffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bfdf0000-0x00000000bfdf2fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000bfdf3000-0x00000000bfdfffff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000bfe00000-0x00000000bfefffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000043effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. GA-78LMT-USB3 R2/GA-78LMT=
-USB3 R2, BIOS F1 11/08/2017
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3321.914 MHz processor
[    0.002877] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.002881] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.002886] last_pfn =3D 0x43f000 max_arch_pfn =3D 0x400000000
[    0.002895] total RAM covered: 3070M
[    0.003161] Found optimal setting for mtrr clean up
[    0.003162]  gran_size: 64K 	chunk_size: 4M 	num_reg: 3  	lose cover RAM=
: 0G
[    0.003168] MTRR map: 7 entries (4 fixed + 3 variable; max 21), built fr=
om 9 variable MTRRs
[    0.003170] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.004028] e820: update [mem 0xbfe00000-0xffffffff] usable =3D=3D> rese=
rved
[    0.004038] last_pfn =3D 0xbfdf0 max_arch_pfn =3D 0x400000000
[    0.006834] found SMP MP-table at [mem 0x000f5ea0-0x000f5eaf]
[    0.006854] Using GB pages for direct mapping
[    0.007124] RAMDISK: [mem 0x31caf000-0x34e4efff]
[    0.007248] ACPI: Early table checksum verification disabled
[    0.007253] ACPI: RSDP 0x00000000000F78B0 000014 (v00 GBT   )
[    0.007257] ACPI: RSDT 0x00000000BFDF3000 000040 (v01 GBT    GBTUACPI 42=
302E31 GBTU 01010101)
[    0.007263] ACPI: FACP 0x00000000BFDF3080 000074 (v01 GBT    GBTUACPI 42=
302E31 GBTU 01010101)
[    0.007269] ACPI: DSDT 0x00000000BFDF3100 0069E7 (v01 GBT    GBTUACPI 00=
001000 MSFT 03000000)
[    0.007274] ACPI: FACS 0x00000000BFDF0000 000040
[    0.007277] ACPI: MSDM 0x00000000BFDF9BC0 000055 (v03 GBT    GBTUACPI 42=
302E31 GBTU 01010101)
[    0.007281] ACPI: HPET 0x00000000BFDF9C40 000038 (v01 GBT    GBTUACPI 42=
302E31 GBTU 00000098)
[    0.007284] ACPI: MCFG 0x00000000BFDF9C80 00003C (v01 GBT    GBTUACPI 42=
302E31 GBTU 01010101)
[    0.007288] ACPI: TAMG 0x00000000BFDF9CC0 000022 (v01 GBT    GBT   B0 54=
55312E BG?? 00000101)
[    0.007291] ACPI: APIC 0x00000000BFDF9B00 0000BC (v01 GBT    GBTUACPI 42=
302E31 GBTU 01010101)
[    0.007295] ACPI: SSDT 0x00000000BFDF9D60 001714 (v01 AMD    POWERNOW 00=
000001 AMD  00000001)
[    0.007298] ACPI: Reserving FACP table memory at [mem 0xbfdf3080-0xbfdf3=
0f3]
[    0.007299] ACPI: Reserving DSDT table memory at [mem 0xbfdf3100-0xbfdf9=
ae6]
[    0.007301] ACPI: Reserving FACS table memory at [mem 0xbfdf0000-0xbfdf0=
03f]
[    0.007302] ACPI: Reserving MSDM table memory at [mem 0xbfdf9bc0-0xbfdf9=
c14]
[    0.007303] ACPI: Reserving HPET table memory at [mem 0xbfdf9c40-0xbfdf9=
c77]
[    0.007304] ACPI: Reserving MCFG table memory at [mem 0xbfdf9c80-0xbfdf9=
cbb]
[    0.007305] ACPI: Reserving TAMG table memory at [mem 0xbfdf9cc0-0xbfdf9=
ce1]
[    0.007306] ACPI: Reserving APIC table memory at [mem 0xbfdf9b00-0xbfdf9=
bbb]
[    0.007307] ACPI: Reserving SSDT table memory at [mem 0xbfdf9d60-0xbfdfb=
473]
[    0.007372] No NUMA configuration found
[    0.007373] Faking a node at [mem 0x0000000000000000-0x000000043effffff]
[    0.007376] NODE_DATA(0) allocated [mem 0x43effb000-0x43effffff]
[    0.007408] Zone ranges:
[    0.007409]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.007411]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.007413]   Normal   [mem 0x0000000100000000-0x000000043effffff]
[    0.007415]   Device   empty
[    0.007416] Movable zone start for each node
[    0.007417] Early memory node ranges
[    0.007418]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.007420]   node   0: [mem 0x0000000000100000-0x00000000bfdeffff]
[    0.007421]   node   0: [mem 0x0000000100000000-0x000000043effffff]
[    0.007424] Initmem setup node 0 [mem 0x0000000000001000-0x000000043efff=
fff]
[    0.007430] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.007466] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.054798] On node 0, zone Normal: 528 pages in unavailable ranges
[    0.054868] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.055052] ACPI: PM-Timer IO Port: 0x4008
[    0.055064] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.055066] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.055067] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.055068] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.055069] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
[    0.055070] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
[    0.055072] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
[    0.055073] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
[    0.055086] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-=
23
[    0.055089] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.055091] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.055096] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.055097] ACPI: HPET id: 0x10b9a201 base: 0xfed00000
[    0.055107] CPU topo: Max. logical packages:   1
[    0.055108] CPU topo: Max. logical dies:       1
[    0.055109] CPU topo: Max. dies per package:   1
[    0.055115] CPU topo: Max. threads per core:   2
[    0.055116] CPU topo: Num. cores per package:     4
[    0.055117] CPU topo: Num. threads per package:   8
[    0.055118] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[    0.055130] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.055132] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x0009ffff]
[    0.055133] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000effff]
[    0.055134] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0=
x000fffff]
[    0.055136] PM: hibernation: Registered nosave memory: [mem 0xbfdf0000-0=
xbfdf2fff]
[    0.055137] PM: hibernation: Registered nosave memory: [mem 0xbfdf3000-0=
xbfdfffff]
[    0.055138] PM: hibernation: Registered nosave memory: [mem 0xbfe00000-0=
xbfefffff]
[    0.055139] PM: hibernation: Registered nosave memory: [mem 0xbff00000-0=
xdfffffff]
[    0.055140] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0=
xefffffff]
[    0.055141] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0=
xfebfffff]
[    0.055142] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xffffffff]
[    0.055144] [mem 0xbff00000-0xdfffffff] available for PCI devices
[    0.055146] Booting paravirtualized kernel on bare hardware
[    0.055149] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.060898] setup_percpu: NR_CPUS:320 nr_cpumask_bits:8 nr_cpu_ids:8 nr_=
node_ids:1
[    0.061917] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.061923] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=3D1*2097152
[    0.061926] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7=20
[    0.061947] Kernel command line: BOOT_IMAGE=3D/vmlinuz-linux-mainline ro=
ot=3DUUID=3D963daeed-0888-4658-9f17-18bd343dfb2a rw zswap.enabled=3D0 rootf=
stype=3Dext4 loglevel=3D3 quiet
[    0.062035] Unknown kernel command line parameters "BOOT_IMAGE=3D/vmlinu=
z-linux-mainline", will be passed to user space.
[    0.064853] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.066267] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.066346] Fallback order for Node 0: 0=20
[    0.066352] Built 1 zonelists, mobility grouping on.  Total pages: 41239=
60
[    0.066353] Policy zone: Normal
[    0.066760] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.066766] software IO TLB: area num 8.
[    0.153391] Memory: 16303888K/16758328K available (16384K kernel code, 2=
138K rwdata, 13024K rodata, 3468K init, 3716K bss, 454180K reserved, 0K cma=
-reserved)
[    0.161590] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.161761] ftrace: allocating 49117 entries in 192 pages
[    0.172827] ftrace: allocated 192 pages with 2 groups
[    0.172994] Dynamic Preempt: full
[    0.173222] rcu: Preemptible hierarchical RCU implementation.
[    0.173223] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D8.
[    0.173225] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.173226] 	Trampoline variant of Tasks RCU enabled.
[    0.173227] 	Rude variant of Tasks RCU enabled.
[    0.173227] 	Tracing variant of Tasks RCU enabled.
[    0.173228] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.173229] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.173237] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjus=
t=3D1.
[    0.173239] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_=
adjust=3D1.
[    0.173241] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb=
_adjust=3D1.
[    0.177113] NR_IRQS: 20736, nr_irqs: 488, preallocated irqs: 16
[    0.177313] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.177401] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.177476] spurious 8259A interrupt: IRQ7.
[    0.177494] Console: colour dummy device 80x25
[    0.177497] printk: legacy console [tty0] enabled
[    0.177895] ACPI: Core revision 20230628
[    0.178130] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns
[    0.178163] APIC: Switch to symmetric I/O mode setup
[    0.178665] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.194818] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2fe22977dcd, max_idle_ns: 440795267503 ns
[    0.194823] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6646.65 BogoMIPS (lpj=3D11073046)
[    0.194847] LVT offset 1 assigned for vector 0xf9
[    0.194852] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.194853] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.194858] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.194861] Spectre V2 : Mitigation: Retpolines
[    0.194862] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.194863] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.194864] Spectre V2 : Enabling Speculation Barrier for firmware calls
[    0.194865] RETBleed: Mitigation: untrained return thunk
[    0.194867] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.194869] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.194873] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.194875] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.194876] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.194878] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.194879] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'standard' format.
[    0.218347] Freeing SMP alternatives memory: 40K
[    0.218352] pid_max: default: 32768 minimum: 301
[    0.219081] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.219939] landlock: Up and running.
[    0.219940] Yama: becoming mindful.
[    0.219947] LSM support for eBPF active
[    0.220195] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.220235] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.228216] APIC calibration not consistent with PM-Timer: 0ms instead o=
f 100ms
[    0.228222] APIC delta adjusted to PM-Timer: 1258139 (1543)
[    0.228231] smpboot: CPU0: AMD FX(tm)-8300 Eight-Core Processor (family:=
 0x15, model: 0x2, stepping: 0x0)
[    0.228577] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.228583] ... version:                0
[    0.228584] ... bit width:              48
[    0.228585] ... generic registers:      6
[    0.228586] ... value mask:             0000ffffffffffff
[    0.228587] ... max period:             00007fffffffffff
[    0.228588] ... fixed-purpose events:   0
[    0.228589] ... event mask:             000000000000003f
[    0.228679] signal: max sigframe size: 1776
[    0.228728] rcu: Hierarchical SRCU implementation.
[    0.228729] rcu: 	Max phase no-delay instances is 1000.
[    0.231158] MCE: In-kernel MCE decoding enabled.
[    0.231233] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.231354] smp: Bringing up secondary CPUs ...
[    0.231487] smpboot: x86: Booting SMP configuration:
[    0.231487] .... node  #0, CPUs:      #2 #4 #6
[    0.000816] __common_interrupt: 2.55 No irq handler for vector
[    0.000816] __common_interrupt: 4.55 No irq handler for vector
[    0.000816] __common_interrupt: 6.55 No irq handler for vector
[    0.245808]  #1 #3 #5 #7
[    0.000816] ------------[ cut here ]------------
[    0.000816] WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:6482 sched_cpu=
_starting+0x183/0x250
[    0.000816] Modules linked in:
[    0.000816] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-1-mainline-0=
8073-g480e035fc4c7 #1 b5b4939a7e36e7c9543996b79d4ad983e0adb635
[    0.000816] Hardware name: Gigabyte Technology Co., Ltd. GA-78LMT-USB3 R=
2/GA-78LMT-USB3 R2, BIOS F1 11/08/2017
[    0.000816] RIP: 0010:sched_cpu_starting+0x183/0x250
[    0.000816] Code: 00 8b 0d c0 26 f0 01 39 c8 0f 83 71 ff ff ff 48 63 d0 =
48 8b 3c d5 40 62 6e ba 4c 01 e7 39 c3 75 c7 4c 89 bf 48 0d 00 00 eb c7 <0f=
> 0b eb c3 be 04 00 00 00 89 df e8 4d 5f 02 00 84 c0 0f 85 71 ff
[    0.000816] RSP: 0000:ffffb040800cfe40 EFLAGS: 00010087
[    0.000816] RAX: 0000000000000002 RBX: 0000000000000001 RCX: 00000000000=
00008
[    0.000816] RDX: 0000000000000002 RSI: fffffffffffffffc RDI: ffff8f31eeb=
36180
[    0.000816] RBP: ffff8f31eea99b00 R08: ffff8f31eea99b00 R09: 00000000000=
00000
[    0.000816] R10: ffff8f31eea99b00 R11: 0000000000000006 R12: 00000000000=
36180
[    0.000816] R13: 0000000000036180 R14: 0000000000000001 R15: ffff8f31eea=
36180
[    0.000816] FS:  0000000000000000(0000) GS:ffff8f31eea80000(0000) knlGS:=
0000000000000000
[    0.000816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000816] CR2: 0000000000000000 CR3: 00000003d0820000 CR4: 00000000000=
406f0
[    0.000816] Call Trace:
[    0.000816]  <TASK>
[    0.000816]  ? __warn+0x80/0x120
[    0.000816]  ? sched_cpu_starting+0x183/0x250
[    0.000816]  ? report_bug+0x15e/0x190
[    0.000816]  ? handle_bug+0x3c/0x80
[    0.000816]  ? exc_invalid_op+0x17/0x70
[    0.000816]  ? asm_exc_invalid_op+0x1a/0x20
[    0.000816]  ? sched_cpu_starting+0x183/0x250
[    0.000816]  ? __pfx_sched_cpu_starting+0x10/0x10
[    0.000816]  cpuhp_invoke_callback+0x122/0x410
[    0.000816]  ? mcheck_cpu_init+0x1ef/0x4b0
[    0.000816]  __cpuhp_invoke_callback_range+0x84/0x100
[    0.000816]  start_secondary+0x9c/0x140
[    0.000816]  common_startup_64+0x13e/0x141
[    0.000816]  </TASK>
[    0.000816] ---[ end trace 0000000000000000 ]---
[    0.000816] __common_interrupt: 1.55 No irq handler for vector
[    0.000816] __common_interrupt: 3.55 No irq handler for vector
[    0.000816] __common_interrupt: 5.55 No irq handler for vector
[    0.000816] __common_interrupt: 7.55 No irq handler for vector
[    0.262496] smp: Brought up 1 node, 8 CPUs
[    0.262496] smpboot: Total of 8 processors activated (53171.23 BogoMIPS)
[    0.264907] ------------[ cut here ]------------
[    0.264911] WARNING: CPU: 0 PID: 1 at kernel/sched/topology.c:2408 build=
_sched_domains+0x7b0/0x1300
[    0.264918] Modules linked in:
[    0.264921] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6=
=2E8.0-1-mainline-08073-g480e035fc4c7 #1 b5b4939a7e36e7c9543996b79d4ad983e0=
adb635
[    0.264926] Hardware name: Gigabyte Technology Co., Ltd. GA-78LMT-USB3 R=
2/GA-78LMT-USB3 R2, BIOS F1 11/08/2017
[    0.264927] RIP: 0010:build_sched_domains+0x7b0/0x1300
[    0.264932] Code: 56 5b 01 00 4c 89 ea 4c 89 e6 4c 89 e7 8b 0d f7 e6 ec =
01 e8 42 a3 52 00 e9 72 fe ff ff 41 c7 46 30 01 00 00 00 e9 0e fe ff ff <0f=
> 0b 41 be f4 ff ff ff 48 8b 5c 24 68 8b 03 85 c0 0f 84 f1 01 00
[    0.264934] RSP: 0018:ffffb0408001fe20 EFLAGS: 00010202
[    0.264936] RAX: 00000000ffffff01 RBX: 0000000000000000 RCX: 00000000fff=
fff01
[    0.264938] RDX: 00000000fffffff8 RSI: 0000000000000003 RDI: ffff8f31eea=
19b00
[    0.264939] RBP: ffff8f2ec0359200 R08: ffff8f31eea19b00 R09: 00000000000=
00000
[    0.264941] R10: ffffb0408001fde8 R11: 0000000000000000 R12: 00000000000=
00001
[    0.264942] R13: ffff8f31eea99b00 R14: 0000000000000001 R15: ffff8f2ec08=
b3b40
[    0.264944] FS:  0000000000000000(0000) GS:ffff8f31eea00000(0000) knlGS:=
0000000000000000
[    0.264946] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.264947] CR2: ffff8f3191601000 CR3: 00000003d0820000 CR4: 00000000000=
406f0
[    0.264949] Call Trace:
[    0.264952]  <TASK>
[    0.264954]  ? __warn+0x80/0x120
[    0.264958]  ? build_sched_domains+0x7b0/0x1300
[    0.264962]  ? report_bug+0x15e/0x190
[    0.264966]  ? handle_bug+0x3c/0x80
[    0.264969]  ? exc_invalid_op+0x17/0x70
[    0.264971]  ? asm_exc_invalid_op+0x1a/0x20
[    0.264974]  ? build_sched_domains+0x7b0/0x1300
[    0.264978]  ? kmalloc_trace+0x13a/0x320
[    0.264982]  sched_init_smp+0x3e/0xc0
[    0.264986]  ? stop_machine+0x30/0x40
[    0.264988]  kernel_init_freeable+0xf8/0x320
[    0.264991]  ? __pfx_kernel_init+0x10/0x10
[    0.264994]  kernel_init+0x1a/0x1c0
[    0.264997]  ret_from_fork+0x34/0x50
[    0.265000]  ? __pfx_kernel_init+0x10/0x10
[    0.265003]  ret_from_fork_asm+0x1a/0x30
[    0.265007]  </TASK>
[    0.265008] ---[ end trace 0000000000000000 ]---
[    0.265933] devtmpfs: initialized
[    0.265969] x86/mm: Memory block size: 128MB
[    0.269416] ACPI: PM: Registering ACPI NVS region [mem 0xbfdf0000-0xbfdf=
2fff] (12288 bytes)
[    0.269477] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.269499] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.270045] pinctrl core: initialized pinctrl subsystem
[    0.270179] PM: RTC time: 13:40:51, date: 2024-05-24
[    0.271179] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.271607] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.271872] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.272159] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.272180] audit: initializing netlink subsys (disabled)
[    0.272233] audit: type=3D2000 audit(1716558050.096:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.272369] thermal_sys: Registered thermal governor 'fair_share'
[    0.272371] thermal_sys: Registered thermal governor 'bang_bang'
[    0.272372] thermal_sys: Registered thermal governor 'step_wise'
[    0.272373] thermal_sys: Registered thermal governor 'user_space'
[    0.272374] thermal_sys: Registered thermal governor 'power_allocator'
[    0.272387] cpuidle: using governor ladder
[    0.272392] cpuidle: using governor menu
[    0.272421] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.272421] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for =
domain 0000 [bus 00-ff]
[    0.272421] PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as E820 entry
[    0.272421] PCI: Using configuration type 1 for base access
[    0.272421] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.278331] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.278333] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.278335] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.278336] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.288266] fbcon: Taking over console
[    0.288287] ACPI: Added _OSI(Module Device)
[    0.288288] ACPI: Added _OSI(Processor Device)
[    0.288289] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.288291] ACPI: Added _OSI(Processor Aggregator Device)
[    0.297587] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.297853] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.297860] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.297866] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.297872] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.297883] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.297889] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.297894] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.297899] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.297911] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.297916] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.297921] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.297926] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.297938] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.297943] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.297948] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.297953] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.297964] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.297970] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.297975] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.297980] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.297991] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.297997] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.298002] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.298007] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.298018] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.298024] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.298029] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.298034] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.298045] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.298051] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.298056] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.298061] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.298072] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.298077] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.298083] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.298088] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.298099] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.298104] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.298109] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.298114] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.308221] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    0.308461] ACPI: Interpreter enabled
[    0.308483] ACPI: PM: (supports S0 S3 S4 S5)
[    0.308485] ACPI: Using IOAPIC for interrupt routing
[    0.308826] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.308828] PCI: Using E820 reservations for host bridge windows
[    0.308980] ACPI: Enabled 5 GPEs in block 00 to 1F
[    0.321558] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.321566] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.321937] PCI host bridge to bus 0000:00
[    0.321939] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.321942] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.321945] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dfff=
f window]
[    0.321948] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebffff=
f window]
[    0.321950] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.321968] pci 0000:00:00.0: [1022:9600] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.321980] pci 0000:00:00.0: [Firmware Bug]: BAR 3: invalid; can't size
[    0.322056] pci 0000:00:02.0: [1022:9603] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.322069] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.322073] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.322076] pci 0000:00:02.0:   bridge window [mem 0xfb000000-0xfcffffff]
[    0.322081] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xdfffffff=
 64bit pref]
[    0.322088] pci 0000:00:02.0: enabling Extended Tags
[    0.322115] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.322220] pci 0000:00:04.0: [1022:9604] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.322233] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.322236] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.322239] pci 0000:00:04.0:   bridge window [mem 0xfda00000-0xfdafffff]
[    0.322244] pci 0000:00:04.0:   bridge window [mem 0xfdf00000-0xfdffffff=
 64bit pref]
[    0.322250] pci 0000:00:04.0: enabling Extended Tags
[    0.322275] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.322372] pci 0000:00:06.0: [1022:9606] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.322384] pci 0000:00:06.0: PCI bridge to [bus 03]
[    0.322388] pci 0000:00:06.0:   bridge window [io  0xc000-0xcfff]
[    0.322391] pci 0000:00:06.0:   bridge window [mem 0xfde00000-0xfdefffff]
[    0.322395] pci 0000:00:06.0:   bridge window [mem 0xfdd00000-0xfddfffff=
 64bit pref]
[    0.322401] pci 0000:00:06.0: enabling Extended Tags
[    0.322426] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.322543] pci 0000:00:11.0: [1002:4390] type 00 class 0x01018f convent=
ional PCI endpoint
[    0.322560] pci 0000:00:11.0: BAR 0 [io  0xff00-0xff07]
[    0.322569] pci 0000:00:11.0: BAR 1 [io  0xfe00-0xfe03]
[    0.322578] pci 0000:00:11.0: BAR 2 [io  0xfd00-0xfd07]
[    0.322587] pci 0000:00:11.0: BAR 3 [io  0xfc00-0xfc03]
[    0.322596] pci 0000:00:11.0: BAR 4 [io  0xfb00-0xfb0f]
[    0.322605] pci 0000:00:11.0: BAR 5 [mem 0xfe02f000-0xfe02f3ff]
[    0.322627] pci 0000:00:11.0: set SATA to AHCI mode
[    0.322732] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310 convent=
ional PCI endpoint
[    0.322749] pci 0000:00:12.0: BAR 0 [mem 0xfe02e000-0xfe02efff]
[    0.322885] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310 convent=
ional PCI endpoint
[    0.322901] pci 0000:00:12.1: BAR 0 [mem 0xfe02d000-0xfe02dfff]
[    0.323039] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320 convent=
ional PCI endpoint
[    0.323056] pci 0000:00:12.2: BAR 0 [mem 0xfe02c000-0xfe02c0ff]
[    0.323134] pci 0000:00:12.2: supports D1 D2
[    0.323136] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.323222] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310 convent=
ional PCI endpoint
[    0.323239] pci 0000:00:13.0: BAR 0 [mem 0xfe02b000-0xfe02bfff]
[    0.323364] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310 convent=
ional PCI endpoint
[    0.323384] pci 0000:00:13.1: BAR 0 [mem 0xfe02a000-0xfe02afff]
[    0.323517] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320 convent=
ional PCI endpoint
[    0.323534] pci 0000:00:13.2: BAR 0 [mem 0xfe029000-0xfe0290ff]
[    0.323611] pci 0000:00:13.2: supports D1 D2
[    0.323613] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.323705] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.323855] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a convent=
ional PCI endpoint
[    0.323872] pci 0000:00:14.1: BAR 0 [io  0x0000-0x0007]
[    0.323881] pci 0000:00:14.1: BAR 1 [io  0x0000-0x0003]
[    0.323890] pci 0000:00:14.1: BAR 2 [io  0x0000-0x0007]
[    0.323899] pci 0000:00:14.1: BAR 3 [io  0x0000-0x0003]
[    0.323907] pci 0000:00:14.1: BAR 4 [io  0xfa00-0xfa0f]
[    0.323927] pci 0000:00:14.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
[    0.323929] pci 0000:00:14.1: BAR 1 [io  0x03f6]: legacy IDE quirk
[    0.323930] pci 0000:00:14.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
[    0.323932] pci 0000:00:14.1: BAR 3 [io  0x0376]: legacy IDE quirk
[    0.324037] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300 convent=
ional PCI endpoint
[    0.324058] pci 0000:00:14.2: BAR 0 [mem 0xfe024000-0xfe027fff 64bit]
[    0.324123] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.324202] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.324370] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401 convent=
ional PCI bridge
[    0.324401] pci 0000:00:14.4: PCI bridge to [bus 04] (subtractive decode)
[    0.324406] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
[    0.324410] pci 0000:00:14.4:   bridge window [mem 0xfdc00000-0xfdcfffff]
[    0.324415] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff=
 pref]
[    0.324498] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310 convent=
ional PCI endpoint
[    0.324514] pci 0000:00:14.5: BAR 0 [mem 0xfe028000-0xfe028fff]
[    0.324643] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.324696] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.324741] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.324786] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.324852] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.324898] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.324993] pci 0000:01:00.0: [10de:1c82] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.325006] pci 0000:01:00.0: BAR 0 [mem 0xfb000000-0xfbffffff]
[    0.325017] pci 0000:01:00.0: BAR 1 [mem 0xc0000000-0xcfffffff 64bit pre=
f]
[    0.325027] pci 0000:01:00.0: BAR 3 [mem 0xde000000-0xdfffffff 64bit pre=
f]
[    0.325035] pci 0000:01:00.0: BAR 5 [io  0xef00-0xef7f]
[    0.325042] pci 0000:01:00.0: ROM [mem 0x00000000-0x0007ffff pref]
[    0.325065] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.325149] pci 0000:01:00.0: 32.000 Gb/s available PCIe bandwidth, limi=
ted by 2.5 GT/s PCIe x16 link at 0000:00:02.0 (capable of 126.016 Gb/s with=
 8.0 GT/s PCIe x16 link)
[    0.325224] pci 0000:01:00.1: [10de:0fb9] type 00 class 0x040300 PCIe En=
dpoint
[    0.325237] pci 0000:01:00.1: BAR 0 [mem 0xfcffc000-0xfcffffff]
[    0.325384] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.325426] pci 0000:02:00.0: [1106:3483] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.325441] pci 0000:02:00.0: BAR 0 [mem 0xfdaff000-0xfdafffff 64bit]
[    0.325500] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.325570] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.325614] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000 PCIe En=
dpoint
[    0.325630] pci 0000:03:00.0: BAR 0 [io  0xce00-0xceff]
[    0.325650] pci 0000:03:00.0: BAR 2 [mem 0xfdeff000-0xfdefffff 64bit]
[    0.325663] pci 0000:03:00.0: BAR 4 [mem 0xfddfc000-0xfddfffff 64bit pre=
f]
[    0.325741] pci 0000:03:00.0: supports D1 D2
[    0.325743] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.325868] pci 0000:00:06.0: PCI bridge to [bus 03]
[    0.325883] pci_bus 0000:04: extended config space not accessible
[    0.325944] pci 0000:00:14.4: PCI bridge to [bus 04] (subtractive decode)
[    0.325953] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window]=
 (subtractive decode)
[    0.325955] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window]=
 (subtractive decode)
[    0.325957] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000dffff=
 window] (subtractive decode)
[    0.325959] pci 0000:00:14.4:   bridge window [mem 0xc0000000-0xfebfffff=
 window] (subtractive decode)
[    0.326238] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.326240] ACPI: PCI: Interrupt link LNKA disabled
[    0.326295] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.326296] ACPI: PCI: Interrupt link LNKB disabled
[    0.326350] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.326352] ACPI: PCI: Interrupt link LNKC disabled
[    0.326405] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.326407] ACPI: PCI: Interrupt link LNKD disabled
[    0.326460] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.326462] ACPI: PCI: Interrupt link LNKE disabled
[    0.326515] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.326516] ACPI: PCI: Interrupt link LNKF disabled
[    0.326569] ACPI: PCI: Interrupt link LNK0 configured for IRQ 0
[    0.326571] ACPI: PCI: Interrupt link LNK0 disabled
[    0.326624] ACPI: PCI: Interrupt link LNK1 configured for IRQ 0
[    0.326625] ACPI: PCI: Interrupt link LNK1 disabled
[    0.327453] iommu: Default domain type: Translated
[    0.327455] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.327719] SCSI subsystem initialized
[    0.327759] libata version 3.00 loaded.
[    0.327765] ACPI: bus type USB registered
[    0.327780] usbcore: registered new interface driver usbfs
[    0.327786] usbcore: registered new interface driver hub
[    0.327797] usbcore: registered new device driver usb
[    0.327828] EDAC MC: Ver: 3.0.0
[    0.328218] NetLabel: Initializing
[    0.328220] NetLabel:  domain hash size =3D 128
[    0.328221] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.328238] NetLabel:  unlabeled traffic allowed by default
[    0.328242] mctp: management component transport protocol core
[    0.328244] NET: Registered PF_MCTP protocol family
[    0.328251] PCI: Using ACPI for IRQ routing
[    0.336650] PCI: pci_cache_line_size set to 64 bytes
[    0.336704] e820: reserve RAM buffer [mem 0x0009f800-0x0009ffff]
[    0.336723] e820: reserve RAM buffer [mem 0xbfdf0000-0xbfffffff]
[    0.336724] e820: reserve RAM buffer [mem 0x43f000000-0x43fffffff]
[    0.336768] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.336770] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.336771] pci 0000:01:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    0.336774] vgaarb: loaded
[    0.336857] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.336863] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    0.338281] clocksource: Switched to clocksource tsc-early
[    0.339740] VFS: Disk quotas dquot_6.6.0
[    0.339801] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.339900] pnp: PnP ACPI init
[    0.339988] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.339992] system 00:00: [io  0x0220-0x0225] has been reserved
[    0.339994] system 00:00: [io  0x0290-0x0294] has been reserved
[    0.340295] system 00:01: [io  0x4100-0x411f] has been reserved
[    0.340299] system 00:01: [io  0x0228-0x022f] has been reserved
[    0.340301] system 00:01: [io  0x040b] has been reserved
[    0.340303] system 00:01: [io  0x04d6] has been reserved
[    0.340305] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.340307] system 00:01: [io  0x0c14] has been reserved
[    0.340309] system 00:01: [io  0x0c50-0x0c52] has been reserved
[    0.340311] system 00:01: [io  0x0c6c-0x0c6d] has been reserved
[    0.340313] system 00:01: [io  0x0c6f] has been reserved
[    0.340314] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.340316] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.340318] system 00:01: [io  0x0cd4-0x0cdf] has been reserved
[    0.340320] system 00:01: [io  0x4000-0x40fe] has been reserved
[    0.340322] system 00:01: [io  0x4210-0x4217] has been reserved
[    0.340324] system 00:01: [io  0x0b00-0x0b0f] has been reserved
[    0.340325] system 00:01: [io  0x0b10-0x0b1f] has been reserved
[    0.340327] system 00:01: [io  0x0b20-0x0b3f] has been reserved
[    0.340329] system 00:01: [mem 0x00000000-0x00000fff window] could not b=
e reserved
[    0.340332] system 00:01: [mem 0xfee00400-0xfee00fff window] has been re=
served
[    0.341258] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    0.341482] pnp 00:06: disabling [mem 0x000ce600-0x000cffff] because it =
overlaps 0000:01:00.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.341504] system 00:06: [mem 0x000f0000-0x000f7fff] could not be reser=
ved
[    0.341507] system 00:06: [mem 0x000f8000-0x000fbfff] could not be reser=
ved
[    0.341509] system 00:06: [mem 0x000fc000-0x000fffff] could not be reser=
ved
[    0.341511] system 00:06: [mem 0xbfdf0000-0xbfdfffff] could not be reser=
ved
[    0.341514] system 00:06: [mem 0xffff0000-0xffffffff] has been reserved
[    0.341516] system 00:06: [mem 0x00000000-0x0009ffff] could not be reser=
ved
[    0.341518] system 00:06: [mem 0x00100000-0xbfdeffff] could not be reser=
ved
[    0.341520] system 00:06: [mem 0xbfe00000-0xbfefffff] has been reserved
[    0.341522] system 00:06: [mem 0xbff00000-0xbfffffff] could not be reser=
ved
[    0.341524] system 00:06: [mem 0xfec00000-0xfec00fff] could not be reser=
ved
[    0.341526] system 00:06: [mem 0xfee00000-0xfee00fff] could not be reser=
ved
[    0.341528] system 00:06: [mem 0xfff80000-0xfffeffff] has been reserved
[    0.341551] pnp: PnP ACPI: found 7 devices
[    0.347675] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.347949] NET: Registered PF_INET protocol family
[    0.348240] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.365489] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.365532] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.365691] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.366117] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.366431] TCP: Hash tables configured (established 131072 bind 65536)
[    0.366657] MPTCP token hash table entries: 16384 (order: 6, 393216 byte=
s, linear)
[    0.366758] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.366824] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)
[    0.366928] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.366943] NET: Registered PF_XDP protocol family
[    0.366958] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.366962] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.366966] pci 0000:00:02.0:   bridge window [mem 0xfb000000-0xfcffffff]
[    0.366969] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xdfffffff=
 64bit pref]
[    0.366973] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.366975] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.366978] pci 0000:00:04.0:   bridge window [mem 0xfda00000-0xfdafffff]
[    0.366980] pci 0000:00:04.0:   bridge window [mem 0xfdf00000-0xfdffffff=
 64bit pref]
[    0.366984] pci 0000:00:06.0: PCI bridge to [bus 03]
[    0.366986] pci 0000:00:06.0:   bridge window [io  0xc000-0xcfff]
[    0.366989] pci 0000:00:06.0:   bridge window [mem 0xfde00000-0xfdefffff]
[    0.366991] pci 0000:00:06.0:   bridge window [mem 0xfdd00000-0xfddfffff=
 64bit pref]
[    0.366995] pci 0000:00:14.4: PCI bridge to [bus 04]
[    0.366998] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
[    0.367003] pci 0000:00:14.4:   bridge window [mem 0xfdc00000-0xfdcfffff]
[    0.367006] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff=
 pref]
[    0.367014] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.367016] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.367018] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000dffff windo=
w]
[    0.367020] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff windo=
w]
[    0.367022] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.367023] pci_bus 0000:01: resource 1 [mem 0xfb000000-0xfcffffff]
[    0.367025] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xdfffffff 64bit=
 pref]
[    0.367027] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.367029] pci_bus 0000:02: resource 1 [mem 0xfda00000-0xfdafffff]
[    0.367031] pci_bus 0000:02: resource 2 [mem 0xfdf00000-0xfdffffff 64bit=
 pref]
[    0.367033] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[    0.367034] pci_bus 0000:03: resource 1 [mem 0xfde00000-0xfdefffff]
[    0.367036] pci_bus 0000:03: resource 2 [mem 0xfdd00000-0xfddfffff 64bit=
 pref]
[    0.367038] pci_bus 0000:04: resource 0 [io  0xb000-0xbfff]
[    0.367039] pci_bus 0000:04: resource 1 [mem 0xfdc00000-0xfdcfffff]
[    0.367041] pci_bus 0000:04: resource 2 [mem 0xfdb00000-0xfdbfffff pref]
[    0.367043] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7 window]
[    0.367045] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff window]
[    0.367046] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000dffff windo=
w]
[    0.367048] pci_bus 0000:04: resource 7 [mem 0xc0000000-0xfebfffff windo=
w]
[    0.384132] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x7b0 took 166=
20 usecs
[    0.400803] pci 0000:00:12.1: quirk_usb_early_handoff+0x0/0x7b0 took 162=
62 usecs
[    0.420792] pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x7b0 took 193=
02 usecs
[    0.437489] pci 0000:00:13.1: quirk_usb_early_handoff+0x0/0x7b0 took 162=
88 usecs
[    0.457452] pci 0000:00:14.5: quirk_usb_early_handoff+0x0/0x7b0 took 192=
63 usecs
[    0.457488] pci 0000:01:00.1: extending delay after power-on from D3hot =
to 20 msec
[    0.457526] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.457731] PCI: CLS 64 bytes, default 64
[    0.457791] Trying to unpack rootfs image as initramfs...
[    0.460644] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.460648] software IO TLB: mapped [mem 0x00000000bbdf0000-0x00000000bf=
df0000] (64MB)
[    0.460698] LVT offset 0 assigned for vector 0x400
[    0.460831] perf: AMD IBS detected (0x000000ff)
[    0.462452] Initialise system trusted keyrings
[    0.462476] Key type blacklist registered
[    0.462535] workingset: timestamp_bits=3D41 max_order=3D22 bucket_order=
=3D0
[    0.462542] zbud: loaded
[    0.464233] integrity: Platform Keyring initialized
[    0.464244] integrity: Machine keyring initialized
[    0.491817] Key type asymmetric registered
[    0.491822] Asymmetric key parser 'x509' registered
[    0.491904] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.493996] io scheduler mq-deadline registered
[    0.493999] io scheduler kyber registered
[    0.494051] io scheduler bfq registered
[    0.495020] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.495120] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input0
[    0.495147] ACPI: button: Power Button [PWRB]
[    0.495187] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input1
[    0.503997] ACPI: button: Power Button [PWRF]
[    0.504047] ACPI: \_PR_.C000: Found 2 idle states
[    0.504123] ACPI: \_PR_.C001: Found 2 idle states
[    0.504195] ACPI: \_PR_.C002: Found 2 idle states
[    0.504263] ACPI: \_PR_.C003: Found 2 idle states
[    0.504333] ACPI: \_PR_.C004: Found 2 idle states
[    0.504404] ACPI: \_PR_.C005: Found 2 idle states
[    0.504473] ACPI: \_PR_.C006: Found 2 idle states
[    0.504536] ACPI: \_PR_.C007: Found 2 idle states
[    0.504807] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.504980] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    0.512096] Non-volatile memory driver v1.3
[    0.512099] Linux agpgart interface v0.103
[    0.512221] ACPI: bus type drm_connector registered
[    0.513072] ahci 0000:00:11.0: version 3.0
[    0.513290] ahci 0000:00:11.0: AHCI vers 0001.0100, 32 command slots, 3 =
Gbps, SATA mode
[    0.513294] ahci 0000:00:11.0: 4/4 ports implemented (port mask 0xf)
[    0.513296] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp=
 pio slum part ccc=20
[    0.513777] scsi host0: ahci
[    0.513930] scsi host1: ahci
[    0.514042] scsi host2: ahci
[    0.514132] scsi host3: ahci
[    0.514175] ata1: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f10=
0 irq 22 lpm-pol 3
[    0.514178] ata2: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f18=
0 irq 22 lpm-pol 3
[    0.514180] ata3: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f20=
0 irq 22 lpm-pol 3
[    0.514182] ata4: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f28=
0 irq 22 lpm-pol 3
[    0.514382] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    0.514388] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus =
number 1
[    0.514419] ohci-pci 0000:00:12.0: irq 16, io mem 0xfe02e000
[    0.577359] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 6.08
[    0.577366] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.577368] usb usb1: Product: OHCI PCI host controller
[    0.577370] usb usb1: Manufacturer: Linux 6.8.0-1-mainline-08073-g480e03=
5fc4c7 ohci_hcd
[    0.577372] usb usb1: SerialNumber: 0000:00:12.0
[    0.577515] hub 1-0:1.0: USB hub found
[    0.577524] hub 1-0:1.0: 3 ports detected
[    0.577751] ehci-pci 0000:00:12.2: EHCI Host Controller
[    0.577756] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus =
number 2
[    0.577760] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    0.577770] ehci-pci 0000:00:12.2: debug port 1
[    0.577823] ehci-pci 0000:00:12.2: irq 17, io mem 0xfe02c000
[    0.582498] Freeing initrd memory: 50816K
[    0.590678] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    0.590829] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.08
[    0.590838] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.590843] usb usb2: Product: EHCI Host Controller
[    0.590847] usb usb2: Manufacturer: Linux 6.8.0-1-mainline-08073-g480e03=
5fc4c7 ehci_hcd
[    0.590851] usb usb2: SerialNumber: 0000:00:12.2
[    0.591006] hub 2-0:1.0: USB hub found
[    0.591020] hub 2-0:1.0: 6 ports detected
[    0.657450] hub 1-0:1.0: USB hub found
[    0.657475] hub 1-0:1.0: 3 ports detected
[    0.657626] ehci-pci 0000:00:13.2: EHCI Host Controller
[    0.657632] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus =
number 3
[    0.657636] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    0.657646] ehci-pci 0000:00:13.2: debug port 1
[    0.657694] ehci-pci 0000:00:13.2: irq 19, io mem 0xfe029000
[    0.670663] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    0.670814] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.08
[    0.670822] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.670827] usb usb3: Product: EHCI Host Controller
[    0.670832] usb usb3: Manufacturer: Linux 6.8.0-1-mainline-08073-g480e03=
5fc4c7 ehci_hcd
[    0.670836] usb usb3: SerialNumber: 0000:00:13.2
[    0.670973] hub 3-0:1.0: USB hub found
[    0.670979] hub 3-0:1.0: 6 ports detected
[    0.671114] ohci-pci 0000:00:12.1: OHCI PCI host controller
[    0.671119] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus =
number 4
[    0.671136] ohci-pci 0000:00:12.1: irq 16, io mem 0xfe02d000
[    0.731385] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 6.08
[    0.731389] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.731391] usb usb4: Product: OHCI PCI host controller
[    0.731393] usb usb4: Manufacturer: Linux 6.8.0-1-mainline-08073-g480e03=
5fc4c7 ohci_hcd
[    0.731394] usb usb4: SerialNumber: 0000:00:12.1
[    0.731483] hub 4-0:1.0: USB hub found
[    0.731492] hub 4-0:1.0: 3 ports detected
[    0.731739] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    0.731743] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus =
number 5
[    0.731776] ohci-pci 0000:00:13.0: irq 18, io mem 0xfe02b000
[    0.791385] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 6.08
[    0.791389] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.791391] usb usb5: Product: OHCI PCI host controller
[    0.791393] usb usb5: Manufacturer: Linux 6.8.0-1-mainline-08073-g480e03=
5fc4c7 ohci_hcd
[    0.791394] usb usb5: SerialNumber: 0000:00:13.0
[    0.791489] hub 5-0:1.0: USB hub found
[    0.791497] hub 5-0:1.0: 3 ports detected
[    0.791721] ohci-pci 0000:00:13.1: OHCI PCI host controller
[    0.791728] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus =
number 6
[    0.791744] ohci-pci 0000:00:13.1: irq 18, io mem 0xfe02a000
[    0.830654] ata1: SATA link down (SStatus 0 SControl 300)
[    0.830737] ata4: SATA link down (SStatus 0 SControl 300)
[    0.840634] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    0.851374] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 6.08
[    0.851378] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.851380] usb usb6: Product: OHCI PCI host controller
[    0.851382] usb usb6: Manufacturer: Linux 6.8.0-1-mainline-08073-g480e03=
5fc4c7 ohci_hcd
[    0.851383] usb usb6: SerialNumber: 0000:00:13.1
[    0.851474] hub 6-0:1.0: USB hub found
[    0.851482] hub 6-0:1.0: 3 ports detected
[    0.851702] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    0.851707] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus =
number 7
[    0.851723] ohci-pci 0000:00:14.5: irq 18, io mem 0xfe028000
[    0.911350] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 6.08
[    0.911354] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.911356] usb usb7: Product: OHCI PCI host controller
[    0.911358] usb usb7: Manufacturer: Linux 6.8.0-1-mainline-08073-g480e03=
5fc4c7 ohci_hcd
[    0.911360] usb usb7: SerialNumber: 0000:00:14.5
[    0.911448] hub 7-0:1.0: USB hub found
[    0.911456] hub 7-0:1.0: 2 ports detected
[    0.911593] usbcore: registered new interface driver usbserial_generic
[    0.911598] usbserial: USB Serial support registered for generic
[    0.911665] rtc_cmos 00:02: RTC can wake from S4
[    0.911871] rtc_cmos 00:02: registered as rtc0
[    0.911896] rtc_cmos 00:02: setting system clock to 2024-05-24T13:40:52 =
UTC (1716558052)
[    0.911923] rtc_cmos 00:02: alarms up to one month, 242 bytes nvram, hpe=
t irqs
[    0.911963] amd_pstate: the _CPC object is not present in SBIOS or ACPI =
disabled
[    0.912257] ledtrig-cpu: registered to indicate activity on CPUs
[    0.912741] [drm] Initialized simpledrm 1.0.0 20200625 for simple-frameb=
uffer.0 on minor 0
[    0.917478] Console: switching to colour frame buffer device 160x64
[    0.923496] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.923546] hid: raw HID events driver (C) Jiri Kosina
[    0.923649] drop_monitor: Initializing network drop monitor service
[    0.923997] NET: Registered PF_INET6 protocol family
[    0.930194] Segment Routing with IPv6
[    0.930197] RPL Segment Routing with IPv6
[    0.930212] In-situ OAM (IOAM) with IPv6
[    0.930238] NET: Registered PF_PACKET protocol family
[    0.930276] x86/pm: family 0x15 cpu detected, MSR saving is needed durin=
g suspending.
[    0.930966] microcode: Current revision: 0x06000852
[    0.930968] microcode: Updated early from: 0x06000822
[    0.931118] IPI shorthand broadcast: enabled
[    0.933593] sched_clock: Marking stable (933611202, -2516524)->(21587054=
31, -1227610753)
[    0.933785] Timer migration: 1 hierarchy levels; 8 children per group; 1=
 crossnode level
[    0.933924] registered taskstats version 1
[    0.934271] Loading compiled-in X.509 certificates
[    0.938631] Loaded X.509 cert 'Build time autogenerated kernel key: ba55=
771f1c59367dcf377aa29b9b4f7948b6e0ec'
[    0.941067] Key type .fscrypt registered
[    0.941068] Key type fscrypt-provisioning registered
[    0.941445] PM:   Magic number: 8:309:686
[    0.945194] RAS: Correctable Errors collector initialized.
[    0.958652] clk: Disabling unused clocks
[    0.958655] PM: genpd: Disabling unused power domains
[    0.991707] usb 2-1: New USB device found, idVendor=3D0bda, idProduct=3D=
b812, bcdDevice=3D 2.10
[    0.991711] usb 2-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    0.991713] usb 2-1: Product: USB3.0 802.11ac 1200M Adapter
[    0.991715] usb 2-1: Manufacturer: Realtek
[    0.991716] usb 2-1: SerialNumber: 123456
[    0.993952] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    0.993990] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    0.994127] ata2.00: ATA-11: Apacer AS340 120GB, AP612PE0, max UDMA/133
[    0.994171] ata2.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 32), =
AA
[    0.994361] ata2.00: configured for UDMA/133
[    0.994793] ata3.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
[    0.995062] ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32),=
 AA
[    0.996129] ata3.00: configured for UDMA/133
[    1.020864] scsi 1:0:0:0: Direct-Access     ATA      Apacer AS340 120 2P=
E0 PQ: 0 ANSI: 5
[    1.021144] sd 1:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB=
/112 GiB)
[    1.021154] sd 1:0:0:0: [sda] Write Protect is off
[    1.021156] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.021170] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.021189] sd 1:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    1.021602] scsi 2:0:0:0: Direct-Access     ATA      TOSHIBA HDWD110  A8=
J0 PQ: 0 ANSI: 5
[    1.021734]  sda: sda1 sda2
[    1.021800] sd 1:0:0:0: [sda] Attached SCSI disk
[    1.021950] sd 2:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 =
TB/932 GiB)
[    1.021952] sd 2:0:0:0: [sdb] 4096-byte physical blocks
[    1.021960] sd 2:0:0:0: [sdb] Write Protect is off
[    1.021962] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.021975] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.021994] sd 2:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
[    1.031122]  sdb: sdb1 sdb2
[    1.031208] sd 2:0:0:0: [sdb] Attached SCSI disk
[    1.034340] Freeing unused decrypted memory: 2028K
[    1.035063] Freeing unused kernel image (initmem) memory: 3468K
[    1.037297] Write protecting the kernel read-only data: 30720k
[    1.037971] Freeing unused kernel image (rodata/data gap) memory: 1312K
[    1.078468] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.078472] rodata_test: all tests were successful
[    1.078477] Run /init as init process
[    1.078478]   with arguments:
[    1.078479]     /init
[    1.078480]   with environment:
[    1.078481]     HOME=3D/
[    1.078482]     TERM=3Dlinux
[    1.078483]     BOOT_IMAGE=3D/vmlinuz-linux-mainline
[    1.313649] scsi host4: pata_atiixp
[    1.313761] scsi host5: pata_atiixp
[    1.313792] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq=
 14 lpm-pol 0
[    1.313794] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq=
 15 lpm-pol 0
[    1.330836] usb 1-3: new low-speed USB device number 2 using ohci-pci
[    1.330865] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    1.330873] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 8
[    1.330949] xhci_hcd 0000:02:00.0: hcc params 0x002841eb hci version 0x1=
00 quirks 0x0000000000000890
[    1.331106] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    1.331110] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 9
[    1.331113] xhci_hcd 0000:02:00.0: Host supports USB 3.0 SuperSpeed
[    1.331419] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.08
[    1.331422] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.331424] usb usb8: Product: xHCI Host Controller
[    1.331426] usb usb8: Manufacturer: Linux 6.8.0-1-mainline-08073-g480e03=
5fc4c7 xhci-hcd
[    1.331428] usb usb8: SerialNumber: 0000:02:00.0
[    1.331538] hub 8-0:1.0: USB hub found
[    1.331546] hub 8-0:1.0: 1 port detected
[    1.331754] usb usb9: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.08
[    1.331757] usb usb9: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.331760] usb usb9: Product: xHCI Host Controller
[    1.331761] usb usb9: Manufacturer: Linux 6.8.0-1-mainline-08073-g480e03=
5fc4c7 xhci-hcd
[    1.331763] usb usb9: SerialNumber: 0000:02:00.0
[    1.331937] hub 9-0:1.0: USB hub found
[    1.331947] hub 9-0:1.0: 4 ports detected
[    1.490437] tsc: Refined TSC clocksource calibration: 3322.065 MHz
[    1.490458] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2fe=
2b83769a, max_idle_ns: 440795214495 ns
[    1.490542] clocksource: Switched to clocksource tsc
[    1.514930] usb 1-3: New USB device found, idVendor=3D0c45, idProduct=3D=
7603, bcdDevice=3D 1.06
[    1.514934] usb 1-3: New USB device strings: Mfr=3D0, Product=3D2, Seria=
lNumber=3D0
[    1.514936] usb 1-3: Product: USB Keyboard
[    1.538363] usbcore: registered new interface driver usbhid
[    1.538366] usbhid: USB HID core driver
[    1.544886] input: USB Keyboard as /devices/pci0000:00/0000:00:12.0/usb1=
/1-3/1-3:1.0/0003:0C45:7603.0001/input/input2
[    1.580908] usb 8-1: new high-speed USB device number 2 using xhci_hcd
[    1.601675] hid-generic 0003:0C45:7603.0001: input,hidraw0: USB HID v1.1=
1 Keyboard [USB Keyboard] on usb-0000:00:12.0-3/input0
[    1.602220] input: USB Keyboard Consumer Control as /devices/pci0000:00/=
0000:00:12.0/usb1/1-3/1-3:1.1/0003:0C45:7603.0002/input/input3
[    1.657557] input: USB Keyboard System Control as /devices/pci0000:00/00=
00:00:12.0/usb1/1-3/1-3:1.1/0003:0C45:7603.0002/input/input4
[    1.657685] input: USB Keyboard as /devices/pci0000:00/0000:00:12.0/usb1=
/1-3/1-3:1.1/0003:0C45:7603.0002/input/input6
[    1.657834] hid-generic 0003:0C45:7603.0002: input,hiddev96,hidraw1: USB=
 HID v1.11 Keyboard [USB Keyboard] on usb-0000:00:12.0-3/input1
[    1.722148] usb 8-1: New USB device found, idVendor=3D2109, idProduct=3D=
3431, bcdDevice=3D 4.20
[    1.722153] usb 8-1: New USB device strings: Mfr=3D0, Product=3D1, Seria=
lNumber=3D0
[    1.722155] usb 8-1: Product: USB2.0 Hub
[    1.722853] hub 8-1:1.0: USB hub found
[    1.723047] hub 8-1:1.0: 4 ports detected
[    2.154223] usb 4-1: new full-speed USB device number 2 using ohci-pci
[    2.294237] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.294597] ata2.00: configured for UDMA/133
[    2.348953] usb 4-1: New USB device found, idVendor=3D04d9, idProduct=3D=
a088, bcdDevice=3D 1.00
[    2.348959] usb 4-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.348961] usb 4-1: Product: USB Gaming Mouse
[    2.348964] usb 4-1: Manufacturer: RH
[    2.356258] input: RH USB Gaming Mouse as /devices/pci0000:00/0000:00:12=
=2E1/usb4/4-1/4-1:1.0/0003:04D9:A088.0003/input/input7
[    2.411290] hid-generic 0003:04D9:A088.0003: input,hidraw2: USB HID v1.1=
0 Keyboard [RH USB Gaming Mouse] on usb-0000:00:12.1-1/input0
[    2.417688] input: RH USB Gaming Mouse as /devices/pci0000:00/0000:00:12=
=2E1/usb4/4-1/4-1:1.1/0003:04D9:A088.0004/input/input8
[    2.417770] input: RH USB Gaming Mouse System Control as /devices/pci000=
0:00/0000:00:12.1/usb4/4-1/4-1:1.1/0003:04D9:A088.0004/input/input9
[    2.474486] input: RH USB Gaming Mouse Consumer Control as /devices/pci0=
000:00/0000:00:12.1/usb4/4-1/4-1:1.1/0003:04D9:A088.0004/input/input10
[    2.474633] hid-generic 0003:04D9:A088.0004: input,hiddev97,hidraw3: USB=
 HID v1.10 Mouse [RH USB Gaming Mouse] on usb-0000:00:12.1-1/input1
[    2.478402] hid-generic 0003:04D9:A088.0005: hiddev98,hidraw4: USB HID v=
1.10 Device [RH USB Gaming Mouse] on usb-0000:00:12.1-1/input2
[    3.050908] ata2.00: exception Emask 0x10 SAct 0x20000 SErr 0x40d0002 ac=
tion 0xe frozen
[    3.050921] ata2.00: irq_stat 0x00000040, connection status changed
[    3.050925] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[    3.050933] ata2.00: failed command: READ FPDMA QUEUED
[    3.050936] ata2.00: cmd 60/08:88:80:ff:f1/00:00:0d:00:00/40 tag 17 ncq =
dma 4096 in
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[    3.050953] ata2.00: status: { DRDY }
[    3.050959] ata2: hard resetting link
[    3.947573] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.947965] ata2.00: configured for UDMA/133
[    3.958113] sd 1:0:0:0: [sda] tag#17 FAILED Result: hostbyte=3DDID_OK dr=
iverbyte=3DDRIVER_OK cmd_age=3D0s
[    3.958116] sd 1:0:0:0: [sda] tag#17 Sense Key : Illegal Request [curren=
t]=20
[    3.958118] sd 1:0:0:0: [sda] tag#17 Add. Sense: Unaligned write command
[    3.958121] sd 1:0:0:0: [sda] tag#17 CDB: Read(10) 28 00 0d f1 ff 80 00 =
00 08 00
[    3.958122] I/O error, dev sda, sector 233963392 op 0x0:(READ) flags 0x8=
0700 phys_seg 1 prio class 0
[    3.958131] ata2: EH complete
[    4.119758] EXT4-fs (sda2): mounted filesystem 963daeed-0888-4658-9f17-1=
8bd343dfb2a r/w with ordered data mode. Quota mode: none.
[    4.289536] systemd[1]: systemd 255.6-2-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZST=
D +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    4.289542] systemd[1]: Detected architecture x86-64.
[    4.804287] systemd[1]: bpf-lsm: LSM BPF program attached
[    4.860959] ata2.00: exception Emask 0x10 SAct 0x200000 SErr 0x40d0002 a=
ction 0xe frozen
[    4.860971] ata2.00: irq_stat 0x00000040, connection status changed
[    4.860976] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[    4.860984] ata2.00: failed command: READ FPDMA QUEUED
[    4.860987] ata2.00: cmd 60/08:a8:50:f9:08/00:00:07:00:00/40 tag 21 ncq =
dma 4096 in
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[    4.861003] ata2.00: status: { DRDY }
[    4.861010] ata2: hard resetting link
[    5.907577] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.908058] ata2.00: configured for UDMA/133
[    5.918213] ata2: EH complete
[    6.032337] systemd-fstab-generator[269]: Mount point  is not a valid pa=
th, ignoring.
[    6.033616] systemd-fstab-generator[269]: Mount point  is not a valid pa=
th, ignoring.
[    6.657546] random: crng init done
[    6.730961] ata2: limiting SATA link speed to 1.5 Gbps
[    6.730971] ata2.00: exception Emask 0x10 SAct 0x30 SErr 0x40d0002 actio=
n 0xe frozen
[    6.730978] ata2.00: irq_stat 0x00000040, connection status changed
[    6.730982] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[    6.730989] ata2.00: failed command: READ FPDMA QUEUED
[    6.730993] ata2.00: cmd 60/40:20:28:3d:9c/00:00:01:00:00/40 tag 4 ncq d=
ma 32768 in
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[    6.731008] ata2.00: status: { DRDY }
[    6.731013] ata2.00: failed command: READ FPDMA QUEUED
[    6.731016] ata2.00: cmd 60/08:28:30:04:ad/00:00:01:00:00/40 tag 5 ncq d=
ma 4096 in
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[    6.731029] ata2.00: status: { DRDY }
[    6.731036] ata2: hard resetting link
[    7.910908] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    7.911335] ata2.00: configured for UDMA/133
[    7.921433] sd 1:0:0:0: [sda] tag#4 FAILED Result: hostbyte=3DDID_OK dri=
verbyte=3DDRIVER_OK cmd_age=3D1s
[    7.921437] sd 1:0:0:0: [sda] tag#4 Sense Key : Illegal Request [current=
]=20
[    7.921439] sd 1:0:0:0: [sda] tag#4 Add. Sense: Unaligned write command
[    7.921441] sd 1:0:0:0: [sda] tag#4 CDB: Read(10) 28 00 01 9c 3d 28 00 0=
0 40 00
[    7.921443] I/O error, dev sda, sector 27016488 op 0x0:(READ) flags 0x80=
700 phys_seg 8 prio class 0
[    7.921451] sd 1:0:0:0: [sda] tag#5 FAILED Result: hostbyte=3DDID_OK dri=
verbyte=3DDRIVER_OK cmd_age=3D1s
[    7.921453] sd 1:0:0:0: [sda] tag#5 Sense Key : Illegal Request [current=
]=20
[    7.921455] sd 1:0:0:0: [sda] tag#5 Add. Sense: Unaligned write command
[    7.921456] sd 1:0:0:0: [sda] tag#5 CDB: Read(10) 28 00 01 ad 04 30 00 0=
0 08 00
[    7.921457] I/O error, dev sda, sector 28116016 op 0x0:(READ) flags 0x80=
700 phys_seg 1 prio class 0
[    7.921463] ata2: EH complete
[    7.935697] zram: Added device: zram0
[    8.102998] systemd[1]: Queued start job for default target Graphical In=
terface.
[    8.132197] systemd[1]: Created slice Slice /system/dirmngr.
[    8.132587] systemd[1]: Created slice Slice /system/getty.
[    8.132925] systemd[1]: Created slice Slice /system/gpg-agent.
[    8.133237] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    8.133545] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    8.133851] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    8.134193] systemd[1]: Created slice Slice /system/keyboxd.
[    8.134508] systemd[1]: Created slice Slice /system/modprobe.
[    8.134816] systemd[1]: Created slice Slice /system/systemd-fsck.
[    8.135128] systemd[1]: Created slice Slice /system/systemd-zram-setup.
[    8.135353] systemd[1]: Created slice User and Session Slice.
[    8.135412] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    8.135456] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    8.135604] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    8.135624] systemd[1]: Expecting device /dev/disk/by-uuid/03ce297b-4be8=
-4886-953d-2d2cc4bd0862...
[    8.135631] systemd[1]: Expecting device /dev/disk/by-uuid/6BB1-1CFA...
[    8.135638] systemd[1]: Expecting device /dev/zram0...
[    8.135648] systemd[1]: Reached target Local Encrypted Volumes.
[    8.135666] systemd[1]: Reached target Local Integrity Protected Volumes.
[    8.135695] systemd[1]: Reached target Path Units.
[    8.135708] systemd[1]: Reached target Remote File Systems.
[    8.135719] systemd[1]: Reached target Slice Units.
[    8.135747] systemd[1]: Reached target Local Verity Protected Volumes.
[    8.135816] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    8.136163] systemd[1]: Listening on LVM2 poll daemon socket.
[    8.137672] systemd[1]: Listening on Process Core Dump Socket.
[    8.137780] systemd[1]: Listening on Journal Socket (/dev/log).
[    8.137886] systemd[1]: Listening on Journal Socket.
[    8.138019] systemd[1]: Listening on Network Service Netlink Socket.
[    8.138038] systemd[1]: TPM2 PCR Extension (Varlink) was skipped because=
 of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    8.138393] systemd[1]: Listening on udev Control Socket.
[    8.138476] systemd[1]: Listening on udev Kernel Socket.
[    8.139578] systemd[1]: Mounting Huge Pages File System...
[    8.140139] systemd[1]: Mounting POSIX Message Queue File System...
[    8.150911] systemd[1]: Mounting Kernel Debug File System...
[    8.151557] systemd[1]: Mounting Kernel Trace File System...
[    8.162835] systemd[1]: Starting Create List of Static Device Nodes...
[    8.167975] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[    8.175823] systemd[1]: Starting Load Kernel Module configfs...
[    8.183121] systemd[1]: Starting Load Kernel Module dm_mod...
[    8.191347] systemd[1]: Starting Load Kernel Module drm...
[    8.193922] systemd[1]: Starting Load Kernel Module fuse...
[    8.197959] systemd[1]: Starting Load Kernel Module loop...
[    8.198007] systemd[1]: File System Check on Root Device was skipped bec=
ause of an unmet condition check (ConditionPathIsReadWrite=3D!/).
[    8.217879] systemd[1]: Starting Journal Service...
[    8.230249] systemd[1]: Starting Load Kernel Modules...
[    8.238614] device-mapper: uevent: version 1.0.3
[    8.239723] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@lists.linux.dev
[    8.240277] systemd[1]: Starting Generate network units from Kernel comm=
and line...
[    8.240308] systemd[1]: TPM2 PCR Machine ID Measurement was skipped beca=
use of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    8.270833] loop: module loaded
[    8.288807] systemd[1]: Starting Remount Root and Kernel File Systems...
[    8.288879] systemd[1]: TPM2 SRK Setup (Early) was skipped because of an=
 unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    8.290376] fuse: init (API version 7.39)
[    8.290559] systemd[1]: Starting Coldplug All udev Devices...
[    8.291954] systemd[1]: Mounted Huge Pages File System.
[    8.292046] systemd[1]: Mounted POSIX Message Queue File System.
[    8.292119] systemd[1]: Mounted Kernel Debug File System.
[    8.292194] systemd[1]: Mounted Kernel Trace File System.
[    8.292378] systemd[1]: Finished Create List of Static Device Nodes.
[    8.292642] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    8.292772] systemd[1]: Finished Load Kernel Module configfs.
[    8.292999] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[    8.293125] systemd[1]: Finished Load Kernel Module dm_mod.
[    8.293347] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    8.293473] systemd[1]: Finished Load Kernel Module drm.
[    8.293696] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    8.293820] systemd[1]: Finished Load Kernel Module loop.
[    8.308367] systemd[1]: Mounting Kernel Configuration File System...
[    8.308668] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[    8.314378] systemd-journald[293]: Collecting audit messages is disabled.
[    8.320785] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    8.320886] sd 2:0:0:0: Attached scsi generic sg1 type 0
[    8.343920] Asymmetric key parser 'pkcs8' registered
[    8.344099] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[    8.344554] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling.
[    8.344827] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    8.344979] systemd[1]: Finished Load Kernel Module fuse.
[    8.345222] systemd[1]: Finished Generate network units from Kernel comm=
and line.
[    8.350872] systemd[1]: Mounting FUSE Control File System...
[    8.351080] systemd[1]: Finished Load Kernel Modules.
[    8.377541] EXT4-fs (sda2): re-mounted 963daeed-0888-4658-9f17-18bd343df=
b2a r/w. Quota mode: none.
[    8.384289] systemd[1]: Starting Apply Kernel Variables...
[    8.385229] systemd[1]: Finished Remount Root and Kernel File Systems.
[    8.385361] systemd[1]: Mounted Kernel Configuration File System.
[    8.391551] systemd[1]: Rebuild Hardware Database was skipped because of=
 an unmet condition check (ConditionNeedsUpdate=3D/etc).
[    8.401061] systemd[1]: Starting Load/Save OS Random Seed...
[    8.405640] systemd[1]: TPM2 SRK Setup was skipped because of an unmet c=
ondition check (ConditionSecurity=3Dmeasured-uki).
[    8.411230] systemd[1]: Mounted FUSE Control File System.
[    8.424941] systemd[1]: Finished Apply Kernel Variables.
[    8.442480] systemd[1]: Finished Load/Save OS Random Seed.
[    8.454415] systemd[1]: Finished Create Static Device Nodes in /dev grac=
efully.
[    8.454520] systemd[1]: Create System Users was skipped because no trigg=
er condition checks were met.
[    8.481070] systemd[1]: Starting Create Static Device Nodes in /dev...
[    8.483168] systemd[1]: Started Journal Service.
[    8.516388] systemd-journald[293]: Received client request to flush runt=
ime journal.
[    8.525883] systemd-journald[293]: /var/log/journal/ca3d73a04dc345538c99=
04a96756e41e/system.journal: Journal file uses a different sequence number =
ID, rotating.
[    8.525887] systemd-journald[293]: Rotating system journal.
[    8.709389] zram0: detected capacity change from 0 to 8388608
[    8.912770] Adding 4194300k swap on /dev/zram0.  Priority:100 extents:1 =
across:4194300k SSDsc
[    8.988845] mousedev: PS/2 mouse device common for all mice
[    9.373138] acpi_cpufreq: overriding BIOS provided _PSD data
[    9.388627] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000=
000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\SOR1=
) (20230628/utaddress-204)
[    9.388636] ACPI: OSL: Resource conflict; ACPI support missing from driv=
er?
[    9.422698] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    9.423211] sp5100-tco sp5100-tco: Failed to reserve MMIO or alternate M=
MIO region
[    9.423214] sp5100-tco: probe of sp5100-tco failed with error -16
[    9.471108] input: PC Speaker as /devices/platform/pcspkr/input/input12
[    9.480563] parport_pc 00:04: reported by Plug and Play ACPI
[    9.484174] cryptd: max_cpu_qlen set to 1000
[    9.484462] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    9.558944] AVX version of gcm_enc/dec engaged.
[    9.558995] AES CTR mode by8 optimization enabled
[    9.573845] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    9.589925] r8169 0000:03:00.0 eth0: RTL8168g/8111g, e0:d5:5e:3b:15:1f, =
XID 4c0, IRQ 28
[    9.589930] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    9.612035] r8169 0000:03:00.0 enp3s0: renamed from eth0
[    9.631260] ppdev: user-space parallel port driver
[    9.635755] EXT4-fs (sdb1): mounted filesystem 03ce297b-4be8-4886-953d-2=
d2cc4bd0862 r/w with ordered data mode. Quota mode: none.
[    9.751020] snd_hda_intel 0000:01:00.1: Disabling MSI
[    9.751032] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio clie=
nt
[    9.815753] input: HDA NVidia HDMI/DP,pcm=3D3 as /devices/pci0000:00/000=
0:00:02.0/0000:01:00.1/sound/card1/input13
[    9.815849] input: HDA NVidia HDMI/DP,pcm=3D7 as /devices/pci0000:00/000=
0:00:02.0/0000:01:00.1/sound/card1/input14
[    9.815900] input: HDA NVidia HDMI/DP,pcm=3D8 as /devices/pci0000:00/000=
0:00:02.0/0000:01:00.1/sound/card1/input15
[    9.815946] input: HDA NVidia HDMI/DP,pcm=3D9 as /devices/pci0000:00/000=
0:00:02.0/0000:01:00.1/sound/card1/input16
[    9.831879] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC892: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:line
[    9.831885] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    9.831887] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x1b/0x0/=
0x0/0x0/0x0)
[    9.831890] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[    9.831891] snd_hda_codec_realtek hdaudioC0D0:    dig-out=3D0x11/0x0
[    9.831893] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    9.831894] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=3D0x19
[    9.831896] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=3D0x18
[    9.831898] snd_hda_codec_realtek hdaudioC0D0:      Line=3D0x1a
[    9.856717] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:1=
4.2/sound/card0/input17
[    9.856773] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14=
=2E2/sound/card0/input18
[    9.856826] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/s=
ound/card0/input19
[    9.856873] input: HDA ATI SB Line Out as /devices/pci0000:00/0000:00:14=
=2E2/sound/card0/input20
[    9.856920] input: HDA ATI SB Front Headphone as /devices/pci0000:00/000=
0:00:14.2/sound/card0/input21
[   10.190847] kvm_amd: TSC scaling supported
[   10.190851] kvm_amd: Nested Virtualization enabled
[   10.190852] kvm_amd: Nested Paging enabled
[   10.190859] kvm_amd: LBR virtualization supported
[   10.904084] NET: Registered PF_ALG protocol family
[   11.034359] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)
[   11.224242] r8169 0000:03:00.0 enp3s0: Link is Down
[   14.387628] ata2.00: exception Emask 0x10 SAct 0x1000 SErr 0x40d0002 act=
ion 0xe frozen
[   14.387642] ata2.00: irq_stat 0x00000040, connection status changed
[   14.387646] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   14.387654] ata2.00: failed command: READ FPDMA QUEUED
[   14.387658] ata2.00: cmd 60/00:60:00:f9:d5/0a:00:0b:00:00/40 tag 12 ncq =
dma 1310720 in
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   14.387674] ata2.00: status: { DRDY }
[   14.387681] ata2: hard resetting link
[   15.284181] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   15.284596] ata2.00: configured for UDMA/133
[   15.294755] sd 1:0:0:0: [sda] tag#12 FAILED Result: hostbyte=3DDID_OK dr=
iverbyte=3DDRIVER_OK cmd_age=3D0s
[   15.294760] sd 1:0:0:0: [sda] tag#12 Sense Key : Illegal Request [curren=
t]=20
[   15.294764] sd 1:0:0:0: [sda] tag#12 Add. Sense: Unaligned write command
[   15.294768] sd 1:0:0:0: [sda] tag#12 CDB: Read(10) 28 00 0b d5 f9 00 00 =
0a 00 00
[   15.294770] I/O error, dev sda, sector 198572288 op 0x0:(READ) flags 0x8=
0700 phys_seg 21 prio class 0
[   15.294792] ata2: EH complete
[   15.654295] ata2.00: exception Emask 0x10 SAct 0x40000 SErr 0x40d0002 ac=
tion 0xe frozen
[   15.654309] ata2.00: irq_stat 0x00000040, connection status changed
[   15.654313] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   15.654321] ata2.00: failed command: WRITE FPDMA QUEUED
[   15.654325] ata2.00: cmd 61/08:90:00:97:a2/00:00:08:00:00/40 tag 18 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   15.654341] ata2.00: status: { DRDY }
[   15.654348] ata2: hard resetting link
[   16.550910] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   16.551386] ata2.00: configured for UDMA/133
[   16.561567] ata2: EH complete
[   18.974248] ata2.00: exception Emask 0x10 SAct 0x20000 SErr 0x40d0002 ac=
tion 0xe frozen
[   18.974261] ata2.00: irq_stat 0x00000040, connection status changed
[   18.974266] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   18.974274] ata2.00: failed command: READ FPDMA QUEUED
[   18.974277] ata2.00: cmd 60/10:88:48:a8:04/00:00:0b:00:00/40 tag 17 ncq =
dma 8192 in
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   18.974293] ata2.00: status: { DRDY }
[   18.974300] ata2: hard resetting link
[   19.877569] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   19.878012] ata2.00: configured for UDMA/133
[   19.888161] sd 1:0:0:0: [sda] tag#17 FAILED Result: hostbyte=3DDID_OK dr=
iverbyte=3DDRIVER_OK cmd_age=3D1s
[   19.888172] sd 1:0:0:0: [sda] tag#17 Sense Key : Illegal Request [curren=
t]=20
[   19.888178] sd 1:0:0:0: [sda] tag#17 Add. Sense: Unaligned write command
[   19.888184] sd 1:0:0:0: [sda] tag#17 CDB: Read(10) 28 00 0b 04 a8 48 00 =
00 10 00
[   19.888188] I/O error, dev sda, sector 184854600 op 0x0:(READ) flags 0x8=
0700 phys_seg 2 prio class 0
[   19.888213] ata2: EH complete
[   20.061541] systemd-journald[293]: /var/log/journal/ca3d73a04dc345538c99=
04a96756e41e/user-1000.journal: Journal file uses a different sequence numb=
er ID, rotating.
[   21.624296] ata2.00: limiting speed to UDMA/100:PIO4
[   21.624307] ata2.00: exception Emask 0x10 SAct 0x2000 SErr 0x40d0002 act=
ion 0xe frozen
[   21.624314] ata2.00: irq_stat 0x00000040, connection status changed
[   21.624318] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   21.624325] ata2.00: failed command: READ FPDMA QUEUED
[   21.624328] ata2.00: cmd 60/00:68:60:07:49/01:00:02:00:00/40 tag 13 ncq =
dma 131072 in
                        res 40/00:58:00:00:00/00:00:00:00:00/40 Emask 0x10 =
(ATA bus error)
[   21.624345] ata2.00: status: { DRDY }
[   21.624352] ata2: hard resetting link
[   22.520957] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   22.521405] ata2.00: configured for UDMA/100
[   22.531593] sd 1:0:0:0: [sda] tag#13 FAILED Result: hostbyte=3DDID_OK dr=
iverbyte=3DDRIVER_OK cmd_age=3D0s
[   22.531603] sd 1:0:0:0: [sda] tag#13 Sense Key : Illegal Request [curren=
t]=20
[   22.531610] sd 1:0:0:0: [sda] tag#13 Add. Sense: Unaligned write command
[   22.531616] sd 1:0:0:0: [sda] tag#13 CDB: Read(10) 28 00 02 49 07 60 00 =
01 00 00
[   22.531620] I/O error, dev sda, sector 38340448 op 0x0:(READ) flags 0x80=
700 phys_seg 4 prio class 0
[   22.531648] ata2: EH complete
[   25.257673] ata2.00: exception Emask 0x10 SAct 0x80cff01f SErr 0x40d0002=
 action 0xe frozen
[   25.257686] ata2.00: irq_stat 0x00000040, connection status changed
[   25.257690] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   25.257698] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257701] ata2.00: cmd 61/08:00:80:f8:07/00:00:02:00:00/40 tag 0 ncq d=
ma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.257717] ata2.00: status: { DRDY }
[   25.257722] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257725] ata2.00: cmd 61/08:08:08:f9:07/00:00:02:00:00/40 tag 1 ncq d=
ma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.257737] ata2.00: status: { DRDY }
[   25.257742] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257745] ata2.00: cmd 61/10:10:28:f9:07/00:00:02:00:00/40 tag 2 ncq d=
ma 8192 out
                        res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.257757] ata2.00: status: { DRDY }
[   25.257761] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257764] ata2.00: cmd 61/08:18:40:fb:07/00:00:02:00:00/40 tag 3 ncq d=
ma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.257776] ata2.00: status: { DRDY }
[   25.257780] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257783] ata2.00: cmd 61/08:20:30:fa:08/00:00:02:00:00/40 tag 4 ncq d=
ma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.257795] ata2.00: status: { DRDY }
[   25.257800] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257802] ata2.00: cmd 61/18:60:08:f8:07/00:00:00:00:00/40 tag 12 ncq =
dma 12288 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.257815] ata2.00: status: { DRDY }
[   25.257819] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257821] ata2.00: cmd 61/10:68:28:f8:07/00:00:00:00:00/40 tag 13 ncq =
dma 8192 out
                        res 40/00:58:00:00:00/00:00:00:00:00/40 Emask 0x10 =
(ATA bus error)
[   25.257834] ata2.00: status: { DRDY }
[   25.257838] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257841] ata2.00: cmd 61/08:70:40:f8:07/00:00:00:00:00/40 tag 14 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.257853] ata2.00: status: { DRDY }
[   25.257857] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257860] ata2.00: cmd 61/18:78:50:f8:07/00:00:00:00:00/40 tag 15 ncq =
dma 12288 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.257872] ata2.00: status: { DRDY }
[   25.257876] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257878] ata2.00: cmd 61/08:80:78:18:08/00:00:00:00:00/40 tag 16 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.257891] ata2.00: status: { DRDY }
[   25.257895] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257897] ata2.00: cmd 61/08:88:80:1c:09/00:00:00:00:00/40 tag 17 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.257910] ata2.00: status: { DRDY }
[   25.257914] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257916] ata2.00: cmd 61/08:90:28:f8:c7/00:00:00:00:00/40 tag 18 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.257929] ata2.00: status: { DRDY }
[   25.257932] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257935] ata2.00: cmd 61/08:98:08:f8:07/00:00:01:00:00/40 tag 19 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.257947] ata2.00: status: { DRDY }
[   25.257951] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257954] ata2.00: cmd 61/08:b0:70:f8:47/00:00:01:00:00/40 tag 22 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.257966] ata2.00: status: { DRDY }
[   25.257970] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257973] ata2.00: cmd 61/08:b8:d8:fa:c7/00:00:01:00:00/40 tag 23 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.257985] ata2.00: status: { DRDY }
[   25.257989] ata2.00: failed command: WRITE FPDMA QUEUED
[   25.257992] ata2.00: cmd 61/08:f8:08:f8:07/00:00:02:00:00/40 tag 31 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   25.258004] ata2.00: status: { DRDY }
[   25.258010] ata2: hard resetting link
[   26.414238] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   26.414746] ata2.00: configured for UDMA/100
[   26.424980] ata2: EH complete
[   28.677624] ata2.00: exception Emask 0x10 SAct 0x8000000 SErr 0x40d0002 =
action 0xe frozen
[   28.677636] ata2.00: irq_stat 0x00000040, connection status changed
[   28.677641] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   28.677649] ata2.00: failed command: WRITE FPDMA QUEUED
[   28.677652] ata2.00: cmd 61/18:d8:90:87:cd/00:00:06:00:00/40 tag 27 ncq =
dma 12288 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   28.677668] ata2.00: status: { DRDY }
[   28.677675] ata2: hard resetting link
[   29.574245] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   29.574735] ata2.00: configured for UDMA/100
[   29.584915] ata2: EH complete
[   34.644289] ata2.00: exception Emask 0x10 SAct 0x2000 SErr 0x40d0002 act=
ion 0xe frozen
[   34.644302] ata2.00: irq_stat 0x00000040, connection status changed
[   34.644306] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   34.644313] ata2.00: failed command: WRITE FPDMA QUEUED
[   34.644317] ata2.00: cmd 61/20:68:b0:87:cd/00:00:06:00:00/40 tag 13 ncq =
dma 16384 out
                        res 40/00:58:00:00:00/00:00:00:00:00/40 Emask 0x10 =
(ATA bus error)
[   34.644333] ata2.00: status: { DRDY }
[   34.644340] ata2: hard resetting link
[   35.540892] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   35.541384] ata2.00: configured for UDMA/100
[   35.551566] ata2: EH complete
[   36.570957] ata2.00: limiting speed to UDMA/33:PIO4
[   36.570967] ata2.00: exception Emask 0x10 SAct 0x200000 SErr 0x40d0002 a=
ction 0xe frozen
[   36.570974] ata2.00: irq_stat 0x00000040, connection status changed
[   36.570978] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   36.570985] ata2.00: failed command: READ FPDMA QUEUED
[   36.570988] ata2.00: cmd 60/58:a8:a8:b3:50/04:00:05:00:00/40 tag 21 ncq =
dma 569344 in
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   36.571004] ata2.00: status: { DRDY }
[   36.571010] ata2: hard resetting link
[   37.467572] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   37.467989] ata2.00: configured for UDMA/33
[   37.478179] sd 1:0:0:0: [sda] tag#21 FAILED Result: hostbyte=3DDID_OK dr=
iverbyte=3DDRIVER_OK cmd_age=3D0s
[   37.478189] sd 1:0:0:0: [sda] tag#21 Sense Key : Illegal Request [curren=
t]=20
[   37.478196] sd 1:0:0:0: [sda] tag#21 Add. Sense: Unaligned write command
[   37.478202] sd 1:0:0:0: [sda] tag#21 CDB: Read(10) 28 00 05 50 b3 a8 00 =
04 58 00
[   37.478206] I/O error, dev sda, sector 89174952 op 0x0:(READ) flags 0x80=
700 phys_seg 131 prio class 0
[   37.478237] ata2: EH complete
[   40.320952] ata2.00: exception Emask 0x10 SAct 0x4 SErr 0x40d0002 action=
 0xe frozen
[   40.320965] ata2.00: irq_stat 0x00000040, connection status changed
[   40.320969] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   40.320976] ata2.00: failed command: READ FPDMA QUEUED
[   40.320980] ata2.00: cmd 60/00:10:40:9b:86/01:00:06:00:00/40 tag 2 ncq d=
ma 131072 in
                        res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   40.320995] ata2.00: status: { DRDY }
[   40.321002] ata2: hard resetting link
[   41.187566] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   41.188054] ata2.00: configured for UDMA/33
[   41.198241] sd 1:0:0:0: [sda] tag#2 FAILED Result: hostbyte=3DDID_OK dri=
verbyte=3DDRIVER_OK cmd_age=3D0s
[   41.198250] sd 1:0:0:0: [sda] tag#2 Sense Key : Illegal Request [current=
]=20
[   41.198256] sd 1:0:0:0: [sda] tag#2 Add. Sense: Unaligned write command
[   41.198262] sd 1:0:0:0: [sda] tag#2 CDB: Read(10) 28 00 06 86 9b 40 00 0=
1 00 00
[   41.198265] I/O error, dev sda, sector 109484864 op 0x0:(READ) flags 0x8=
0700 phys_seg 31 prio class 0
[   41.198293] ata2: EH complete
[   45.137574] ata2.00: exception Emask 0x10 SAct 0x200 SErr 0x40d0002 acti=
on 0xe frozen
[   45.137588] ata2.00: irq_stat 0x00000040, connection status changed
[   45.137592] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   45.137600] ata2.00: failed command: READ FPDMA QUEUED
[   45.137604] ata2.00: cmd 60/20:48:28:5d:0d/00:00:07:00:00/40 tag 9 ncq d=
ma 16384 in
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   45.137619] ata2.00: status: { DRDY }
[   45.137627] ata2: hard resetting link
[   46.034230] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   46.034722] ata2.00: configured for UDMA/33
[   46.044912] sd 1:0:0:0: [sda] tag#9 FAILED Result: hostbyte=3DDID_OK dri=
verbyte=3DDRIVER_OK cmd_age=3D0s
[   46.044922] sd 1:0:0:0: [sda] tag#9 Sense Key : Illegal Request [current=
]=20
[   46.044929] sd 1:0:0:0: [sda] tag#9 Add. Sense: Unaligned write command
[   46.044935] sd 1:0:0:0: [sda] tag#9 CDB: Read(10) 28 00 07 0d 5d 28 00 0=
0 20 00
[   46.044939] I/O error, dev sda, sector 118316328 op 0x0:(READ) flags 0x8=
0700 phys_seg 4 prio class 0
[   46.044964] ata2: EH complete
[   47.007566] ata2.00: exception Emask 0x10 SAct 0x4000 SErr 0x40d0002 act=
ion 0xe frozen
[   47.007579] ata2.00: irq_stat 0x00000040, connection status changed
[   47.007583] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   47.007591] ata2.00: failed command: READ FPDMA QUEUED
[   47.007594] ata2.00: cmd 60/20:70:00:bc:0c/00:00:07:00:00/40 tag 14 ncq =
dma 16384 in
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   47.007610] ata2.00: status: { DRDY }
[   47.007617] ata2: hard resetting link
[   47.904231] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   47.904703] ata2.00: configured for UDMA/33
[   47.914902] sd 1:0:0:0: [sda] tag#14 FAILED Result: hostbyte=3DDID_OK dr=
iverbyte=3DDRIVER_OK cmd_age=3D0s
[   47.914919] sd 1:0:0:0: [sda] tag#14 Sense Key : Illegal Request [curren=
t]=20
[   47.914926] sd 1:0:0:0: [sda] tag#14 Add. Sense: Unaligned write command
[   47.914933] sd 1:0:0:0: [sda] tag#14 CDB: Read(10) 28 00 07 0c bc 00 00 =
00 20 00
[   47.914937] I/O error, dev sda, sector 118275072 op 0x0:(READ) flags 0x8=
0700 phys_seg 4 prio class 0
[   47.914962] ata2: EH complete
[   51.717622] ata2.00: exception Emask 0x10 SAct 0x4000 SErr 0x40d0002 act=
ion 0xe frozen
[   51.717635] ata2.00: irq_stat 0x00000040, connection status changed
[   51.717639] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   51.717647] ata2.00: failed command: WRITE FPDMA QUEUED
[   51.717651] ata2.00: cmd 61/20:70:88:88:cd/00:00:06:00:00/40 tag 14 ncq =
dma 16384 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   51.717667] ata2.00: status: { DRDY }
[   51.717675] ata2: hard resetting link
[   52.614228] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   52.614681] ata2.00: configured for UDMA/33
[   52.624862] ata2: EH complete
[   54.697626] ata2.00: exception Emask 0x10 SAct 0x80e00000 SErr 0x40d0002=
 action 0xe frozen
[   54.697638] ata2.00: irq_stat 0x00000040, connection status changed
[   54.697643] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   54.697650] ata2.00: failed command: WRITE FPDMA QUEUED
[   54.697654] ata2.00: cmd 61/00:a8:20:78:de/02:00:0a:00:00/40 tag 21 ncq =
dma 262144 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   54.697669] ata2.00: status: { DRDY }
[   54.697674] ata2.00: failed command: WRITE FPDMA QUEUED
[   54.697677] ata2.00: cmd 61/d8:b0:68:fb:e4/01:00:0a:00:00/40 tag 22 ncq =
dma 241664 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   54.697691] ata2.00: status: { DRDY }
[   54.697695] ata2.00: failed command: WRITE FPDMA QUEUED
[   54.697698] ata2.00: cmd 61/08:b8:10:68:f1/00:00:07:00:00/40 tag 23 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   54.697711] ata2.00: status: { DRDY }
[   54.697715] ata2.00: failed command: WRITE FPDMA QUEUED
[   54.697718] ata2.00: cmd 61/08:f8:18:68:f1/00:00:07:00:00/40 tag 31 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   54.697730] ata2.00: status: { DRDY }
[   54.697736] ata2: hard resetting link
[   55.594236] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   55.594739] ata2.00: configured for UDMA/33
[   55.604929] ata2: EH complete
[   57.690952] ata2.00: exception Emask 0x10 SAct 0x1000 SErr 0x40d0002 act=
ion 0xe frozen
[   57.690965] ata2.00: irq_stat 0x00000040, connection status changed
[   57.690969] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   57.690977] ata2.00: failed command: WRITE FPDMA QUEUED
[   57.690980] ata2.00: cmd 61/18:60:b0:88:cd/00:00:06:00:00/40 tag 12 ncq =
dma 12288 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   57.690996] ata2.00: status: { DRDY }
[   57.691003] ata2: hard resetting link
[   58.587576] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   58.588069] ata2.00: configured for UDMA/33
[   58.598248] ata2: EH complete
[   60.097622] ata2.00: exception Emask 0x10 SAct 0xc000 SErr 0x40d0002 act=
ion 0xe frozen
[   60.097635] ata2.00: irq_stat 0x00000040, connection status changed
[   60.097639] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   60.097648] ata2.00: failed command: READ FPDMA QUEUED
[   60.097651] ata2.00: cmd 60/20:70:70:9a:94/00:00:01:00:00/40 tag 14 ncq =
dma 16384 in
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   60.097667] ata2.00: status: { DRDY }
[   60.097672] ata2.00: failed command: READ FPDMA QUEUED
[   60.097675] ata2.00: cmd 60/20:78:f8:47:bc/00:00:0b:00:00/40 tag 15 ncq =
dma 16384 in
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   60.097688] ata2.00: status: { DRDY }
[   60.097695] ata2: hard resetting link
[   60.994215] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   60.994716] ata2.00: configured for UDMA/33
[   61.004915] sd 1:0:0:0: [sda] tag#14 FAILED Result: hostbyte=3DDID_OK dr=
iverbyte=3DDRIVER_OK cmd_age=3D0s
[   61.004932] sd 1:0:0:0: [sda] tag#14 Sense Key : Illegal Request [curren=
t]=20
[   61.004939] sd 1:0:0:0: [sda] tag#14 Add. Sense: Unaligned write command
[   61.004946] sd 1:0:0:0: [sda] tag#14 CDB: Read(10) 28 00 01 94 9a 70 00 =
00 20 00
[   61.004950] I/O error, dev sda, sector 26516080 op 0x0:(READ) flags 0x80=
700 phys_seg 3 prio class 0
[   61.004980] sd 1:0:0:0: [sda] tag#15 FAILED Result: hostbyte=3DDID_OK dr=
iverbyte=3DDRIVER_OK cmd_age=3D0s
[   61.004987] sd 1:0:0:0: [sda] tag#15 Sense Key : Illegal Request [curren=
t]=20
[   61.004994] sd 1:0:0:0: [sda] tag#15 Add. Sense: Unaligned write command
[   61.005001] sd 1:0:0:0: [sda] tag#15 CDB: Read(10) 28 00 0b bc 47 f8 00 =
00 20 00
[   61.005005] I/O error, dev sda, sector 196888568 op 0x0:(READ) flags 0x8=
0700 phys_seg 4 prio class 0
[   61.005025] ata2: EH complete
[   63.210907] ata2.00: exception Emask 0x10 SAct 0x60000 SErr 0x40d0002 ac=
tion 0xe frozen
[   63.210922] ata2.00: irq_stat 0x00000040, connection status changed
[   63.210926] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   63.210934] ata2.00: failed command: WRITE FPDMA QUEUED
[   63.210938] ata2.00: cmd 61/28:88:d0:88:cd/00:00:06:00:00/40 tag 17 ncq =
dma 20480 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   63.210954] ata2.00: status: { DRDY }
[   63.210958] ata2.00: failed command: READ FPDMA QUEUED
[   63.210961] ata2.00: cmd 60/20:90:f8:3c:35/00:00:02:00:00/40 tag 18 ncq =
dma 16384 in
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   63.210975] ata2.00: status: { DRDY }
[   63.210982] ata2: hard resetting link
[   64.107561] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   64.108048] ata2.00: configured for UDMA/33
[   64.118241] sd 1:0:0:0: [sda] tag#18 FAILED Result: hostbyte=3DDID_OK dr=
iverbyte=3DDRIVER_OK cmd_age=3D0s
[   64.118251] sd 1:0:0:0: [sda] tag#18 Sense Key : Illegal Request [curren=
t]=20
[   64.118257] sd 1:0:0:0: [sda] tag#18 Add. Sense: Unaligned write command
[   64.118264] sd 1:0:0:0: [sda] tag#18 CDB: Read(10) 28 00 02 35 3c f8 00 =
00 20 00
[   64.118267] I/O error, dev sda, sector 37043448 op 0x0:(READ) flags 0x80=
700 phys_seg 1 prio class 0
[   64.118289] ata2: EH complete
[   64.944302] ata2.00: exception Emask 0x10 SAct 0x3fc SErr 0x40d0002 acti=
on 0xe frozen
[   64.944316] ata2.00: irq_stat 0x00000040, connection status changed
[   64.944321] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   64.944329] ata2.00: failed command: WRITE FPDMA QUEUED
[   64.944332] ata2.00: cmd 61/08:10:10:68:f1/00:00:07:00:00/40 tag 2 ncq d=
ma 4096 out
                        res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   64.944348] ata2.00: status: { DRDY }
[   64.944353] ata2.00: failed command: WRITE FPDMA QUEUED
[   64.944356] ata2.00: cmd 61/10:18:28:78:de/00:00:0a:00:00/40 tag 3 ncq d=
ma 8192 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   64.944369] ata2.00: status: { DRDY }
[   64.944373] ata2.00: failed command: WRITE FPDMA QUEUED
[   64.944376] ata2.00: cmd 61/08:20:40:78:de/00:00:0a:00:00/40 tag 4 ncq d=
ma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   64.944389] ata2.00: status: { DRDY }
[   64.944393] ata2.00: failed command: WRITE FPDMA QUEUED
[   64.944396] ata2.00: cmd 61/18:28:50:78:de/00:00:0a:00:00/40 tag 5 ncq d=
ma 12288 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   64.944409] ata2.00: status: { DRDY }
[   64.944413] ata2.00: failed command: WRITE FPDMA QUEUED
[   64.944415] ata2.00: cmd 61/c0:30:70:78:de/00:00:0a:00:00/40 tag 6 ncq d=
ma 98304 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   64.944428] ata2.00: status: { DRDY }
[   64.944432] ata2.00: failed command: WRITE FPDMA QUEUED
[   64.944435] ata2.00: cmd 61/50:38:40:79:de/00:00:0a:00:00/40 tag 7 ncq d=
ma 40960 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   64.944447] ata2.00: status: { DRDY }
[   64.944451] ata2.00: failed command: WRITE FPDMA QUEUED
[   64.944454] ata2.00: cmd 61/38:40:98:79:de/00:00:0a:00:00/40 tag 8 ncq d=
ma 28672 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   64.944466] ata2.00: status: { DRDY }
[   64.944470] ata2.00: failed command: WRITE FPDMA QUEUED
[   64.944473] ata2.00: cmd 61/70:48:e0:79:de/00:00:0a:00:00/40 tag 9 ncq d=
ma 57344 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   64.944485] ata2.00: status: { DRDY }
[   64.944492] ata2: hard resetting link
[   65.840950] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   65.841434] ata2.00: configured for UDMA/33
[   65.851631] ata2: EH complete
[   66.437655] ata2.00: exception Emask 0x10 SAct 0x1fff80 SErr 0x40d0002 a=
ction 0xe frozen
[   66.437668] ata2.00: irq_stat 0x00000040, connection status changed
[   66.437672] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   66.437679] ata2.00: failed command: WRITE FPDMA QUEUED
[   66.437683] ata2.00: cmd 61/08:38:10:f8:07/00:00:00:00:00/40 tag 7 ncq d=
ma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   66.437698] ata2.00: status: { DRDY }
[   66.437703] ata2.00: failed command: WRITE FPDMA QUEUED
[   66.437706] ata2.00: cmd 61/08:40:28:f8:07/00:00:00:00:00/40 tag 8 ncq d=
ma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   66.437719] ata2.00: status: { DRDY }
[   66.437723] ata2.00: failed command: WRITE FPDMA QUEUED
[   66.437726] ata2.00: cmd 61/08:48:80:1c:09/00:00:00:00:00/40 tag 9 ncq d=
ma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   66.437739] ata2.00: status: { DRDY }
[   66.437743] ata2.00: failed command: WRITE FPDMA QUEUED
[   66.437746] ata2.00: cmd 61/08:50:00:f8:c7/00:00:01:00:00/40 tag 10 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   66.437759] ata2.00: status: { DRDY }
[   66.437763] ata2.00: failed command: WRITE FPDMA QUEUED
[   66.437766] ata2.00: cmd 61/08:58:98:f8:c7/00:00:01:00:00/40 tag 11 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   66.437778] ata2.00: status: { DRDY }
[   66.437782] ata2.00: failed command: WRITE FPDMA QUEUED
[   66.437785] ata2.00: cmd 61/08:60:a0:f9:c7/00:00:01:00:00/40 tag 12 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   66.437797] ata2.00: status: { DRDY }
[   66.437801] ata2.00: failed command: WRITE FPDMA QUEUED
[   66.437804] ata2.00: cmd 61/10:68:08:29:c8/00:00:01:00:00/40 tag 13 ncq =
dma 8192 out
                        res 40/00:58:00:00:00/00:00:00:00:00/40 Emask 0x10 =
(ATA bus error)
[   66.437817] ata2.00: status: { DRDY }
[   66.437821] ata2.00: failed command: WRITE FPDMA QUEUED
[   66.437824] ata2.00: cmd 61/08:70:b8:f9:c8/00:00:01:00:00/40 tag 14 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   66.437836] ata2.00: status: { DRDY }
[   66.437840] ata2.00: failed command: WRITE FPDMA QUEUED
[   66.437843] ata2.00: cmd 61/08:78:40:fb:07/00:00:02:00:00/40 tag 15 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   66.437855] ata2.00: status: { DRDY }
[   66.437859] ata2.00: failed command: WRITE FPDMA QUEUED
[   66.437862] ata2.00: cmd 61/08:80:80:f8:87/00:00:04:00:00/40 tag 16 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   66.437874] ata2.00: status: { DRDY }
[   66.437878] ata2.00: failed command: WRITE FPDMA QUEUED
[   66.437881] ata2.00: cmd 61/08:88:00:f9:87/00:00:04:00:00/40 tag 17 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   66.437893] ata2.00: status: { DRDY }
[   66.437897] ata2.00: failed command: WRITE FPDMA QUEUED
[   66.437900] ata2.00: cmd 61/08:90:10:06:88/00:00:04:00:00/40 tag 18 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   66.437912] ata2.00: status: { DRDY }
[   66.437916] ata2.00: failed command: WRITE FPDMA QUEUED
[   66.437919] ata2.00: cmd 61/08:98:70:0b:88/00:00:04:00:00/40 tag 19 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   66.437931] ata2.00: status: { DRDY }
[   66.437935] ata2.00: failed command: WRITE FPDMA QUEUED
[   66.437937] ata2.00: cmd 61/08:a0:08:f9:88/00:00:04:00:00/40 tag 20 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   66.437949] ata2.00: status: { DRDY }
[   66.437956] ata2: hard resetting link
[   67.304240] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   67.304708] ata2.00: configured for UDMA/33
[   67.314934] ata2: EH complete
[   68.784289] ata2.00: exception Emask 0x10 SAct 0x2000000 SErr 0x40d0002 =
action 0xe frozen
[   68.784304] ata2.00: irq_stat 0x00000040, connection status changed
[   68.784308] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   68.784317] ata2.00: failed command: WRITE FPDMA QUEUED
[   68.784320] ata2.00: cmd 61/18:c8:00:89:cd/00:00:06:00:00/40 tag 25 ncq =
dma 12288 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   68.784336] ata2.00: status: { DRDY }
[   68.784343] ata2: hard resetting link
[   69.650880] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   69.651470] ata2.00: configured for UDMA/33
[   69.661614] ata2: EH complete
[   74.750955] ata2.00: exception Emask 0x10 SAct 0x40 SErr 0x40d0002 actio=
n 0xe frozen
[   74.750969] ata2.00: irq_stat 0x00000040, connection status changed
[   74.750974] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   74.750982] ata2.00: failed command: WRITE FPDMA QUEUED
[   74.750986] ata2.00: cmd 61/20:30:20:89:cd/00:00:06:00:00/40 tag 6 ncq d=
ma 16384 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   74.751002] ata2.00: status: { DRDY }
[   74.751009] ata2: hard resetting link
[   75.647558] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   75.648029] ata2.00: configured for UDMA/33
[   75.658163] ata2: EH complete
[   80.720952] ata2.00: exception Emask 0x10 SAct 0x4000 SErr 0x40d0002 act=
ion 0xe frozen
[   80.720966] ata2.00: irq_stat 0x00000040, connection status changed
[   80.720970] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   80.720978] ata2.00: failed command: WRITE FPDMA QUEUED
[   80.720982] ata2.00: cmd 61/18:70:48:89:cd/00:00:06:00:00/40 tag 14 ncq =
dma 12288 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   80.720998] ata2.00: status: { DRDY }
[   80.721005] ata2: hard resetting link
[   81.617571] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   81.618081] ata2.00: configured for UDMA/33
[   81.628267] ata2: EH complete
[   86.694285] ata2.00: exception Emask 0x10 SAct 0x400000 SErr 0x40d0002 a=
ction 0xe frozen
[   86.694299] ata2.00: irq_stat 0x00000040, connection status changed
[   86.694304] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   86.694312] ata2.00: failed command: WRITE FPDMA QUEUED
[   86.694315] ata2.00: cmd 61/18:b0:68:89:cd/00:00:06:00:00/40 tag 22 ncq =
dma 12288 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   86.694331] ata2.00: status: { DRDY }
[   86.694339] ata2: hard resetting link
[   87.570903] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   87.571405] ata2.00: configured for UDMA/33
[   87.581630] ata2: EH complete
[   92.677619] ata2.00: exception Emask 0x10 SAct 0x80 SErr 0x40d0002 actio=
n 0xe frozen
[   92.677634] ata2.00: irq_stat 0x00000040, connection status changed
[   92.677639] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   92.677647] ata2.00: failed command: WRITE FPDMA QUEUED
[   92.677651] ata2.00: cmd 61/18:38:88:89:cd/00:00:06:00:00/40 tag 7 ncq d=
ma 12288 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   92.677667] ata2.00: status: { DRDY }
[   92.677675] ata2: hard resetting link
[   93.547571] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   93.548074] ata2.00: configured for UDMA/33
[   93.558258] ata2: EH complete
[   95.314326] ata2.00: exception Emask 0x10 SAct 0x800000 SErr 0x40d0002 a=
ction 0xe frozen
[   95.314340] ata2.00: irq_stat 0x00000040, connection status changed
[   95.314346] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   95.314355] ata2.00: failed command: READ FPDMA QUEUED
[   95.314359] ata2.00: cmd 60/60:b8:f8:73:c2/00:00:0b:00:00/40 tag 23 ncq =
dma 49152 in
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   95.314379] ata2.00: status: { DRDY }
[   95.314387] ata2: hard resetting link
[   96.397573] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   96.398071] ata2.00: configured for UDMA/33
[   96.408278] sd 1:0:0:0: [sda] tag#23 FAILED Result: hostbyte=3DDID_OK dr=
iverbyte=3DDRIVER_OK cmd_age=3D1s
[   96.408296] sd 1:0:0:0: [sda] tag#23 Sense Key : Illegal Request [curren=
t]=20
[   96.408303] sd 1:0:0:0: [sda] tag#23 Add. Sense: Unaligned write command
[   96.408309] sd 1:0:0:0: [sda] tag#23 CDB: Read(10) 28 00 0b c2 73 f8 00 =
00 60 00
[   96.408313] I/O error, dev sda, sector 197293048 op 0x0:(READ) flags 0x8=
0700 phys_seg 12 prio class 0
[   96.408341] ata2: EH complete
[   96.730959] ata2.00: exception Emask 0x10 SAct 0x3e SErr 0x40d0002 actio=
n 0xe frozen
[   96.730974] ata2.00: irq_stat 0x00000040, connection status changed
[   96.730979] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   96.730987] ata2.00: failed command: WRITE FPDMA QUEUED
[   96.730991] ata2.00: cmd 61/98:08:20:78:de/01:00:0a:00:00/40 tag 1 ncq d=
ma 208896 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   96.731007] ata2.00: status: { DRDY }
[   96.731012] ata2.00: failed command: WRITE FPDMA QUEUED
[   96.731015] ata2.00: cmd 61/08:10:c8:79:de/00:00:0a:00:00/40 tag 2 ncq d=
ma 4096 out
                        res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   96.731028] ata2.00: status: { DRDY }
[   96.731032] ata2.00: failed command: WRITE FPDMA QUEUED
[   96.731035] ata2.00: cmd 61/60:18:e0:79:de/00:00:0a:00:00/40 tag 3 ncq d=
ma 49152 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   96.731048] ata2.00: status: { DRDY }
[   96.731052] ata2.00: failed command: WRITE FPDMA QUEUED
[   96.731055] ata2.00: cmd 61/80:20:48:7a:de/00:00:0a:00:00/40 tag 4 ncq d=
ma 65536 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   96.731067] ata2.00: status: { DRDY }
[   96.731071] ata2.00: failed command: WRITE FPDMA QUEUED
[   96.731074] ata2.00: cmd 61/08:28:10:68:f1/00:00:07:00:00/40 tag 5 ncq d=
ma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   96.731087] ata2.00: status: { DRDY }
[   96.731093] ata2: hard resetting link
[   97.607572] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   97.608049] ata2.00: configured for UDMA/33
[   97.618240] ata2: EH complete
[   98.067617] ata2.00: exception Emask 0x10 SAct 0x80000 SErr 0x40d0002 ac=
tion 0xe frozen
[   98.067633] ata2.00: irq_stat 0x00000040, connection status changed
[   98.067637] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[   98.067646] ata2.00: failed command: WRITE FPDMA QUEUED
[   98.067649] ata2.00: cmd 61/18:98:a8:89:cd/00:00:06:00:00/40 tag 19 ncq =
dma 12288 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[   98.067665] ata2.00: status: { DRDY }
[   98.067673] ata2: hard resetting link
[   98.950901] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   98.951378] ata2.00: configured for UDMA/33
[   98.961572] ata2: EH complete
[  103.770948] ata2.00: exception Emask 0x10 SAct 0x1 SErr 0x40d0002 action=
 0xe frozen
[  103.770962] ata2.00: irq_stat 0x00000040, connection status changed
[  103.770966] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[  103.770974] ata2.00: failed command: WRITE FPDMA QUEUED
[  103.770978] ata2.00: cmd 61/18:00:c8:89:cd/00:00:06:00:00/40 tag 0 ncq d=
ma 12288 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  103.770993] ata2.00: status: { DRDY }
[  103.771001] ata2: hard resetting link
[  104.644223] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  104.644733] ata2.00: configured for UDMA/33
[  104.654915] ata2: EH complete
[  105.074277] ata2.00: exception Emask 0x10 SAct 0x1000000 SErr 0x40d0002 =
action 0xe frozen
[  105.074290] ata2.00: irq_stat 0x00000040, connection status changed
[  105.074294] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[  105.074302] ata2.00: failed command: READ FPDMA QUEUED
[  105.074305] ata2.00: cmd 60/00:c0:b0:8e:2a/01:00:04:00:00/40 tag 24 ncq =
dma 131072 in
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  105.074321] ata2.00: status: { DRDY }
[  105.074327] ata2: hard resetting link
[  105.970888] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  105.971346] ata2.00: configured for UDMA/33
[  105.981533] sd 1:0:0:0: [sda] tag#24 FAILED Result: hostbyte=3DDID_OK dr=
iverbyte=3DDRIVER_OK cmd_age=3D0s
[  105.981544] sd 1:0:0:0: [sda] tag#24 Sense Key : Illegal Request [curren=
t]=20
[  105.981550] sd 1:0:0:0: [sda] tag#24 Add. Sense: Unaligned write command
[  105.981556] sd 1:0:0:0: [sda] tag#24 CDB: Read(10) 28 00 04 2a 8e b0 00 =
01 00 00
[  105.981560] I/O error, dev sda, sector 69897904 op 0x0:(READ) flags 0x80=
700 phys_seg 31 prio class 0
[  105.981586] ata2: EH complete
[  106.544280] ata2.00: exception Emask 0x10 SAct 0x400000 SErr 0x40d0002 a=
ction 0xe frozen
[  106.544294] ata2.00: irq_stat 0x00000040, connection status changed
[  106.544299] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[  106.544307] ata2.00: failed command: WRITE FPDMA QUEUED
[  106.544310] ata2.00: cmd 61/08:b0:48:fb:07/00:00:02:00:00/40 tag 22 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  106.544326] ata2.00: status: { DRDY }
[  106.544333] ata2: hard resetting link
[  107.410951] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  107.411376] ata2.00: configured for UDMA/33
[  107.421558] ata2: EH complete
[  109.744281] ata2.00: exception Emask 0x10 SAct 0x800000 SErr 0x40d0002 a=
ction 0xe frozen
[  109.744294] ata2.00: irq_stat 0x00000040, connection status changed
[  109.744299] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[  109.744307] ata2.00: failed command: WRITE FPDMA QUEUED
[  109.744310] ata2.00: cmd 61/18:b8:e8:89:cd/00:00:06:00:00/40 tag 23 ncq =
dma 12288 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  109.744326] ata2.00: status: { DRDY }
[  109.744333] ata2: hard resetting link
[  110.640888] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  110.641391] ata2.00: configured for UDMA/33
[  110.651573] ata2: EH complete
[  113.434232] ata2.00: exception Emask 0x10 SAct 0x200 SErr 0x40d0002 acti=
on 0xe frozen
[  113.434246] ata2.00: irq_stat 0x00000040, connection status changed
[  113.434250] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[  113.434266] ata2.00: failed command: WRITE FPDMA QUEUED
[  113.434268] ata2.00: cmd 61/08:48:00:b8:f1/00:00:07:00:00/40 tag 9 ncq d=
ma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  113.434280] ata2.00: status: { DRDY }
[  113.434286] ata2: hard resetting link
[  114.330891] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  114.331341] ata2.00: configured for UDMA/33
[  114.341481] ata2: EH complete
[  115.717609] ata2.00: exception Emask 0x10 SAct 0x2000 SErr 0x40d0002 act=
ion 0xe frozen
[  115.717622] ata2.00: irq_stat 0x00000040, connection status changed
[  115.717626] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[  115.717634] ata2.00: failed command: WRITE FPDMA QUEUED
[  115.717637] ata2.00: cmd 61/60:68:08:8a:cd/00:00:06:00:00/40 tag 13 ncq =
dma 49152 out
                        res 40/00:58:00:00:00/00:00:00:00:00/40 Emask 0x10 =
(ATA bus error)
[  115.717653] ata2.00: status: { DRDY }
[  115.717660] ata2: hard resetting link
[  116.614208] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  116.614644] ata2.00: configured for UDMA/33
[  116.624824] ata2: EH complete
[  117.637624] ata2.00: exception Emask 0x10 SAct 0x7c000007 SErr 0x40d0002=
 action 0xe frozen
[  117.637637] ata2.00: irq_stat 0x00000040, connection status changed
[  117.637641] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[  117.637648] ata2.00: failed command: WRITE FPDMA QUEUED
[  117.637651] ata2.00: cmd 61/08:00:c8:78:de/00:00:0a:00:00/40 tag 0 ncq d=
ma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  117.637667] ata2.00: status: { DRDY }
[  117.637671] ata2.00: failed command: WRITE FPDMA QUEUED
[  117.637674] ata2.00: cmd 61/38:08:d8:78:de/00:00:0a:00:00/40 tag 1 ncq d=
ma 28672 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  117.637688] ata2.00: status: { DRDY }
[  117.637692] ata2.00: failed command: WRITE FPDMA QUEUED
[  117.637695] ata2.00: cmd 61/10:10:18:79:de/00:00:0a:00:00/40 tag 2 ncq d=
ma 8192 out
                        res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  117.637708] ata2.00: status: { DRDY }
[  117.637712] ata2.00: failed command: WRITE FPDMA QUEUED
[  117.637715] ata2.00: cmd 61/08:d0:20:78:de/00:00:0a:00:00/40 tag 26 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  117.637728] ata2.00: status: { DRDY }
[  117.637732] ata2.00: failed command: WRITE FPDMA QUEUED
[  117.637735] ata2.00: cmd 61/20:d8:40:78:de/00:00:0a:00:00/40 tag 27 ncq =
dma 16384 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  117.637747] ata2.00: status: { DRDY }
[  117.637751] ata2.00: failed command: WRITE FPDMA QUEUED
[  117.637754] ata2.00: cmd 61/08:e0:70:78:de/00:00:0a:00:00/40 tag 28 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  117.637766] ata2.00: status: { DRDY }
[  117.637771] ata2.00: failed command: WRITE FPDMA QUEUED
[  117.637773] ata2.00: cmd 61/08:e8:a8:78:de/00:00:0a:00:00/40 tag 29 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  117.637786] ata2.00: status: { DRDY }
[  117.637790] ata2.00: failed command: WRITE FPDMA QUEUED
[  117.637793] ata2.00: cmd 61/08:f0:b8:78:de/00:00:0a:00:00/40 tag 30 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  117.637805] ata2.00: status: { DRDY }
[  117.637811] ata2: hard resetting link
[  118.534229] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  118.534689] ata2.00: configured for UDMA/33
[  118.544884] ata2: EH complete
[  121.690945] ata2.00: exception Emask 0x10 SAct 0x400 SErr 0x40d0002 acti=
on 0xe frozen
[  121.690959] ata2.00: irq_stat 0x00000040, connection status changed
[  121.690964] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[  121.690972] ata2.00: failed command: WRITE FPDMA QUEUED
[  121.690975] ata2.00: cmd 61/18:50:70:8a:cd/00:00:06:00:00/40 tag 10 ncq =
dma 12288 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  121.690991] ata2.00: status: { DRDY }
[  121.690999] ata2: hard resetting link
[  122.587560] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  122.588014] ata2.00: configured for UDMA/33
[  122.598196] ata2: EH complete
[  123.824246] ata2.00: exception Emask 0x10 SAct 0x80dc0003 SErr 0x40d0002=
 action 0xe frozen
[  123.824259] ata2.00: irq_stat 0x00000040, connection status changed
[  123.824263] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B DevExch }
[  123.824271] ata2.00: failed command: WRITE FPDMA QUEUED
[  123.824274] ata2.00: cmd 61/50:00:f0:78:de/00:00:0a:00:00/40 tag 0 ncq d=
ma 40960 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  123.824290] ata2.00: status: { DRDY }
[  123.824294] ata2.00: failed command: WRITE FPDMA QUEUED
[  123.824297] ata2.00: cmd 61/30:08:48:79:de/00:00:0a:00:00/40 tag 1 ncq d=
ma 24576 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  123.824311] ata2.00: status: { DRDY }
[  123.824316] ata2.00: failed command: WRITE FPDMA QUEUED
[  123.824319] ata2.00: cmd 61/40:90:20:78:de/00:00:0a:00:00/40 tag 18 ncq =
dma 32768 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  123.824332] ata2.00: status: { DRDY }
[  123.824336] ata2.00: failed command: WRITE FPDMA QUEUED
[  123.824339] ata2.00: cmd 61/08:98:68:78:de/00:00:0a:00:00/40 tag 19 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  123.824352] ata2.00: status: { DRDY }
[  123.824356] ata2.00: failed command: WRITE FPDMA QUEUED
[  123.824359] ata2.00: cmd 61/20:a0:88:78:de/00:00:0a:00:00/40 tag 20 ncq =
dma 16384 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  123.824371] ata2.00: status: { DRDY }
[  123.824375] ata2.00: failed command: WRITE FPDMA QUEUED
[  123.824378] ata2.00: cmd 61/18:b0:b0:78:de/00:00:0a:00:00/40 tag 22 ncq =
dma 12288 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  123.824390] ata2.00: status: { DRDY }
[  123.824394] ata2.00: failed command: WRITE FPDMA QUEUED
[  123.824397] ata2.00: cmd 61/08:b8:d0:78:de/00:00:0a:00:00/40 tag 23 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  123.824410] ata2.00: status: { DRDY }
[  123.824414] ata2.00: failed command: WRITE FPDMA QUEUED
[  123.824417] ata2.00: cmd 61/08:f8:e0:78:de/00:00:0a:00:00/40 tag 31 ncq =
dma 4096 out
                        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 =
(ATA bus error)
[  123.824429] ata2.00: status: { DRDY }
[  123.824435] ata2: hard resetting link
[  124.720950] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  124.721388] ata2.00: configured for UDMA/33
[  124.731585] ata2: EH complete

--izkgikfoc2krw74l--

--t5o7sbkvmfmzj3pc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmZRLNwACgkQwEfU8yi1
JYWyXRAA5o66YEEfu+qLhd/NbZYgTmG/1Ipw4J7dctHqJ8o5NcfLjUWUfWJ3kZQP
O9CXCsP1VvekFrAV+9GXwco5K8XytOydRivxhz2z7GjlVpiwQMgiWsj6OsRMboWy
xQCSkv9vW7dNJ2Oky1x4jpNGcQNI9kZpEZWAqct+tuR37hhWMIC/W9El4NtDfWG1
exQPP1UhIAL23UKY4tiKlih0hyHbRTjacrcIxr8wZGLVqmqalRop+Emi020Tc6AY
/wFtLzooT5HKI0g+6xxN1QW9upAUvWQXSrEkn6+1LfM9k237NTl1CCu8aXArc6ho
8n9tFYkBX9LuCZCgwimSDZDC64HJa5fETlBC9F2RzjZS9jms5aLufjncC6+h/sXC
H5QzaGWtK9muIRQHjHtGp2UNwp6RIDXSt5U35dDuBfmCIgGVswpznkRO6ZhlqOml
Bor2onJ8lo0+vilpvmR4Z9bO8HQGqhVA9O9LoGnEP/K7W0Vdq9jn5wdEcT9ON8YM
rfipZXY/PYdMUpHO+ksRTq5ltYW1Vy7EySWaSEsLW9L+/qWX/uhwgNjQ5pF8nLGi
h1yHX6JIr7SRw+ehEeydDqGmYc6wPwbaqGs5DcykzFIQ8KpwKfjpuyxiyGDzqWlE
K05ZD+X04YP/hjPm0DQmYXV3Tvw/NcCegEQw26ASMOFiuK76Nx0=
=PhGW
-----END PGP SIGNATURE-----

--t5o7sbkvmfmzj3pc--

