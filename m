Return-Path: <stable+bounces-69957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3719E95CB44
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 13:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C871F23C1D
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 11:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A40186E57;
	Fri, 23 Aug 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwqpLhDM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18BF18787D
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412103; cv=none; b=JGrM8K52xk0wNJFglWzpHd1csBRwMKA20lPV/1fo3c3SZAGIrP5EgmX2tBuV0pe/BsXEz7nYwQfPbzonT8v4vSl3e+bdviZZtAevvBrDsSTA4HPSts/Aiq3PikQxid2KwG/E0JfGRsYEJwQ6KuLt/DoC/gnHhuNH9HuHb70/o10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412103; c=relaxed/simple;
	bh=s0Sdvp1GPV7tUhn/wk1LMCNXfjS/LklaSnF6D1i1POE=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=Fpt6CwWhIjIwI6Oz5h2AhzZmpwOrgnHfnw8u/DcDFrXktqzAL5a3oTca3jFE9ccw0ltm29wzMzyfgxNODV6prMjZA65kFgVWZ261gfWxU1mkbrrxXp3hnwcadfFcfTiaRXsfLXxZrlvDUUGGfcl0p0QXLQ/YsvI7SYLyWiRuuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwqpLhDM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso15935281fa.1
        for <stable@vger.kernel.org>; Fri, 23 Aug 2024 04:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724412096; x=1725016896; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9wuRibdu8eIuQVucCG8SxuN0E+1ZpfPoRefT5dd5AvM=;
        b=OwqpLhDMUQC+Jf1tzLhbKbV/WTAZ/kaVVxbRTzK3uKZpPWYpL+gSwY3tmUWzxEsA3w
         eIyieXsgHn2BXuc0rsMoAfnuzLihgUzqo7LNeBq3V/EDryuEqDkJ8AcwQ0WhcejCdqj/
         i6080TpeSc23HQKuLOeCmMayreNPLaFyiwLKdtdX26lkWZScxPg0J1wqd8Aq01fnLxaZ
         T5l1S/lX8YzUX1ztAOASRyAB8YKlRBdJ3tqp2UBuLyTi8uwkbKXOnz0BnlYLisCReUTb
         +/dPnmXOPA00GX1HftVDpzn0SrDKSWvsvf3cdf5SSAIbBJN3cpUFlqAtqEpAuRXbY+In
         nnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724412096; x=1725016896;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wuRibdu8eIuQVucCG8SxuN0E+1ZpfPoRefT5dd5AvM=;
        b=NfthBKt4tEKSV0xr4Kna/j82i68H3tyLz/nIgfqBSsfrRgqyvpwEjU/jZ8qi8dnflr
         vQJQtaR8r+gIQVIHSAmO4YjcXjMCSFJ15j0v/btSMzpSZIN94IypHnOaSI/l+IPJwkiN
         L/dZteGs7jnGRPHcwUJ/Zs0M8i4hE4Z9v7jDBqsok/xdbJ/9d8/Tp3Y6iBVn2x1Oom9T
         9be5H9sySzRjAfCfvSBOk9o6L847xuznweQuD63yHzzMeWN11coxaUH2A3Fb9AVFSIpT
         5tuDK+LtiKkbs259j1nwbS7NHVAbfVGrgwYFnSm7uoF7rYt4tYjLJ8/+RQHQT62GDDh6
         lkHQ==
X-Gm-Message-State: AOJu0Yy/rt+v3S6dqWnSGA9KWzJcJ4szWZRbLSTVnWugOcGFjgyo8z/w
	XRHz0efDik/jEJcEnRkrh/VXXeuL8mwq+6pYeqohQPW1E6TWD8FjjyR+PQ==
X-Google-Smtp-Source: AGHT+IF9YADpfdgteNpijuuq7l4kXSfLAyDeucB6rvp32MuX13MKeY1GS/ZldgRntg6YP3IPpBND/Q==
X-Received: by 2002:a2e:1302:0:b0:2f3:f5bb:5f0d with SMTP id 38308e7fff4ca-2f4f4905e55mr10005081fa.18.1724412091965;
        Fri, 23 Aug 2024 04:21:31 -0700 (PDT)
Received: from smtpclient.apple (89-73-96-21.dynamic.chello.pl. [89.73.96.21])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4048ae27fsm4552571fa.132.2024.08.23.04.21.30
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2024 04:21:31 -0700 (PDT)
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: 6.8.2->vanilla 6.10.6: regression: oops on heavy compiltons
Message-Id: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
Date: Fri, 23 Aug 2024 13:21:19 +0200
To: stable@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51)

Hi,

In my development i=E2=80=99m using ryzen9 based builder machine.
OS is ArchLinux.
It worked perfectly stable with 6.8.2 kernel.

Recently I updated to 6.10.6  kernel and=E2=80=A6.started to have =
regular oops at heavy compilations (12c/24t loaded 8..12h constantly =
compiling)

Only single change is kernel: 6.8.2->6.10.6
6.10.6 is vanilla mainline (no any ArchLinux patches)

When i have ooops - dmesg is like below.

For me this looks like regression...
 =20

[root@minimyth2-x8664 piotro]# dmesg
[    0.000000] Linux version 6.10.6-12 (linux@archlinux) (gcc (GCC) =
13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC =
Mon, 19 Aug 2024 11:27:15 +0000
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-linux-nvme =
root=3DUUID=3D78029aac-358d-4ce1-b48f-0c910bc10436 rw =
rootflags=3Drw,noatime cgroup_disable=3Dmemory mitigations=3Doff
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d3ff] =
usable
[    0.000000] BIOS-e820: [mem 0x000000000009d400-0x000000000009ffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009bfefff] =
usable
[    0.000000] BIOS-e820: [mem 0x0000000009bff000-0x0000000009ffffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] =
usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a210fff] =
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a211000-0x000000000affffff] =
usable
[    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x000000000b020000-0x00000000bb3f7fff] =
usable
[    0.000000] BIOS-e820: [mem 0x00000000bb3f8000-0x00000000bcbaafff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000bcbab000-0x00000000bcbdcfff] =
ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bcbdd000-0x00000000bd28afff] =
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bd28b000-0x00000000bddfefff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000bddff000-0x00000000beffffff] =
usable
[    0.000000] BIOS-e820: [mem 0x00000000bf000000-0x00000000bfffffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd100000-0x00000000fd1fffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd500000-0x00000000fd6fffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000fea0ffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec30000-0x00000000fec30fff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedcffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedd4000-0x00000000fedd5fff] =
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] =
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000043f2fffff] =
usable
[    0.000000] BIOS-e820: [mem 0x000000043f300000-0x000000043fffffff] =
reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: To Be Filled By O.E.M. B450M Pro4-F R2.0/B450M =
Pro4-F R2.0, BIOS P10.08 01/19/2024
[    0.000000] DMI: Memory slots populated: 2/4
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 4099.961 MHz processor
[    0.000527] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> =
reserved
[    0.000529] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000538] last_pfn =3D 0x43f300 max_arch_pfn =3D 0x400000000
[    0.000544] total RAM covered: 3071M
[    0.000729] Found optimal setting for mtrr clean up
[    0.000729]  gran_size: 64K 	chunk_size: 64M 	num_reg: 3  	=
lose cover RAM: 0G
[    0.000732] MTRR map: 7 entries (3 fixed + 4 variable; max 20), built =
from 9 variable MTRRs
[    0.000733] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- =
WT
[    0.001245] e820: update [mem 0xbcd40000-0xbcd4ffff] usable =3D=3D> =
reserved
[    0.001250] e820: update [mem 0xc0000000-0xffffffff] usable =3D=3D> =
reserved
[    0.001254] last_pfn =3D 0xbf000 max_arch_pfn =3D 0x400000000
[    0.004712] Using GB pages for direct mapping
[    0.004906] RAMDISK: [mem 0x21f2b000-0x2cf8cfff]
[    0.004909] ACPI: Early table checksum verification disabled
[    0.004912] ACPI: RSDP 0x00000000000F05B0 000024 (v02 ALASKA)
[    0.004915] ACPI: XSDT 0x00000000BD273728 0000B4 (v01 ALASKA A M I    =
01072009 AMI  01000013)
[    0.004920] ACPI: FACP 0x00000000BCBD6000 000114 (v06 ALASKA A M I    =
01072009 AMI  00010013)
[    0.004924] ACPI: DSDT 0x00000000BCBCF000 00643E (v02 ALASKA A M I    =
01072009 INTL 20120913)
[    0.004926] ACPI: FACS 0x00000000BD26E000 000040
[    0.004928] ACPI: SSDT 0x00000000BCBDC000 00092A (v02 AMD    AmdTable =
00000002 MSFT 04000000)
[    0.004930] ACPI: SSDT 0x00000000BCBD8000 003CB6 (v02 AMD    AMD AOD  =
00000001 INTL 20120913)
[    0.004933] ACPI: SSDT 0x00000000BCBD7000 000164 (v02 ALASKA CPUSSDT  =
01072009 AMI  01072009)
[    0.004935] ACPI: FIDT 0x00000000BCBCE000 00009C (v01 ALASKA A M I    =
01072009 AMI  00010013)
[    0.004937] ACPI: MCFG 0x00000000BCBCD000 00003C (v01 ALASKA A M I    =
01072009 MSFT 00010013)
[    0.004939] ACPI: AAFT 0x00000000BCBCC000 0000C9 (v01 ALASKA OEMAAFT  =
01072009 MSFT 00000097)
[    0.004941] ACPI: HPET 0x00000000BCBCB000 000038 (v01 ALASKA A M I    =
01072009 AMI  00000005)
[    0.004944] ACPI: PCCT 0x00000000BCBCA000 00006E (v02 AMD    AmdTable =
00000001 AMD  00000001)
[    0.004946] ACPI: SSDT 0x00000000BCBC3000 00603B (v02 AMD    AmdTable =
00000001 AMD  00000001)
[    0.004948] ACPI: CRAT 0x00000000BCBC1000 0016D0 (v01 AMD    AmdTable =
00000001 AMD  00000001)
[    0.004950] ACPI: CDIT 0x00000000BCBC0000 000029 (v01 AMD    AmdTable =
00000001 AMD  00000001)
[    0.004952] ACPI: SSDT 0x00000000BCBBC000 0037C4 (v02 AMD    MYRTLE   =
00000001 INTL 20120913)
[    0.004954] ACPI: SSDT 0x00000000BCBBB000 0000BF (v01 AMD    AmdTable =
00001000 INTL 20120913)
[    0.004956] ACPI: WSMT 0x00000000BCBBA000 000028 (v01 ALASKA A M I    =
01072009 AMI  00010013)
[    0.004958] ACPI: APIC 0x00000000BCBB9000 00015E (v03 ALASKA A M I    =
01072009 AMI  00010013)
[    0.004961] ACPI: SSDT 0x00000000BCBB7000 0010AF (v02 AMD    MYRTLE   =
00000001 INTL 20120913)
[    0.004963] ACPI: FPDT 0x00000000BCBB6000 000044 (v01 ALASKA A M I    =
01072009 AMI  01000013)
[    0.004964] ACPI: Reserving FACP table memory at [mem =
0xbcbd6000-0xbcbd6113]
[    0.004965] ACPI: Reserving DSDT table memory at [mem =
0xbcbcf000-0xbcbd543d]
[    0.004966] ACPI: Reserving FACS table memory at [mem =
0xbd26e000-0xbd26e03f]
[    0.004967] ACPI: Reserving SSDT table memory at [mem =
0xbcbdc000-0xbcbdc929]
[    0.004967] ACPI: Reserving SSDT table memory at [mem =
0xbcbd8000-0xbcbdbcb5]
[    0.004968] ACPI: Reserving SSDT table memory at [mem =
0xbcbd7000-0xbcbd7163]
[    0.004969] ACPI: Reserving FIDT table memory at [mem =
0xbcbce000-0xbcbce09b]
[    0.004969] ACPI: Reserving MCFG table memory at [mem =
0xbcbcd000-0xbcbcd03b]
[    0.004970] ACPI: Reserving AAFT table memory at [mem =
0xbcbcc000-0xbcbcc0c8]
[    0.004971] ACPI: Reserving HPET table memory at [mem =
0xbcbcb000-0xbcbcb037]
[    0.004971] ACPI: Reserving PCCT table memory at [mem =
0xbcbca000-0xbcbca06d]
[    0.004972] ACPI: Reserving SSDT table memory at [mem =
0xbcbc3000-0xbcbc903a]
[    0.004973] ACPI: Reserving CRAT table memory at [mem =
0xbcbc1000-0xbcbc26cf]
[    0.004973] ACPI: Reserving CDIT table memory at [mem =
0xbcbc0000-0xbcbc0028]
[    0.004974] ACPI: Reserving SSDT table memory at [mem =
0xbcbbc000-0xbcbbf7c3]
[    0.004975] ACPI: Reserving SSDT table memory at [mem =
0xbcbbb000-0xbcbbb0be]
[    0.004975] ACPI: Reserving WSMT table memory at [mem =
0xbcbba000-0xbcbba027]
[    0.004976] ACPI: Reserving APIC table memory at [mem =
0xbcbb9000-0xbcbb915d]
[    0.004977] ACPI: Reserving SSDT table memory at [mem =
0xbcbb7000-0xbcbb80ae]
[    0.004977] ACPI: Reserving FPDT table memory at [mem =
0xbcbb6000-0xbcbb6043]
[    0.005026] No NUMA configuration found
[    0.005027] Faking a node at [mem =
0x0000000000000000-0x000000043f2fffff]
[    0.005029] NODE_DATA(0) allocated [mem 0x43f2fb000-0x43f2fffff]
[    0.005050] Zone ranges:
[    0.005051]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005052]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005053]   Normal   [mem 0x0000000100000000-0x000000043f2fffff]
[    0.005054]   Device   empty
[    0.005055] Movable zone start for each node
[    0.005055] Early memory node ranges
[    0.005056]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.005057]   node   0: [mem 0x0000000000100000-0x0000000009bfefff]
[    0.005058]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.005059]   node   0: [mem 0x000000000a211000-0x000000000affffff]
[    0.005059]   node   0: [mem 0x000000000b020000-0x00000000bb3f7fff]
[    0.005060]   node   0: [mem 0x00000000bddff000-0x00000000beffffff]
[    0.005061]   node   0: [mem 0x0000000100000000-0x000000043f2fffff]
[    0.005063] Initmem setup node 0 [mem =
0x0000000000001000-0x000000043f2fffff]
[    0.005067] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.005083] On node 0, zone DMA: 99 pages in unavailable ranges
[    0.005222] On node 0, zone DMA32: 1025 pages in unavailable ranges
[    0.005236] On node 0, zone DMA32: 17 pages in unavailable ranges
[    0.008749] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.008854] On node 0, zone DMA32: 10759 pages in unavailable ranges
[    0.026310] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.026338] On node 0, zone Normal: 3328 pages in unavailable ranges
[    0.026708] ACPI: PM-Timer IO Port: 0x808
[    0.026714] CPU topo: Ignoring hot-pluggable APIC ID 0 in present =
package.
[    0.026718] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.026729] IOAPIC[0]: apic_id 25, version 33, address 0xfec00000, =
GSI 0-23
[    0.026735] IOAPIC[1]: apic_id 26, version 33, address 0xfec01000, =
GSI 24-55
[    0.026736] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.026738] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low =
level)
[    0.026741] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.026742] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.026749] CPU topo: Max. logical packages:   1
[    0.026749] CPU topo: Max. logical dies:       1
[    0.026750] CPU topo: Max. dies per package:   1
[    0.026754] CPU topo: Max. threads per core:   2
[    0.026754] CPU topo: Num. cores per package:    12
[    0.026755] CPU topo: Num. threads per package:  24
[    0.026756] CPU topo: Allowing 24 present CPUs plus 0 hotplug CPUs
[    0.026756] CPU topo: Rejected CPUs 8
[    0.026775] PM: hibernation: Registered nosave memory: [mem =
0x00000000-0x00000fff]
[    0.026777] PM: hibernation: Registered nosave memory: [mem =
0x0009d000-0x0009dfff]
[    0.026777] PM: hibernation: Registered nosave memory: [mem =
0x0009e000-0x0009ffff]
[    0.026778] PM: hibernation: Registered nosave memory: [mem =
0x000a0000-0x000dffff]
[    0.026779] PM: hibernation: Registered nosave memory: [mem =
0x000e0000-0x000fffff]
[    0.026780] PM: hibernation: Registered nosave memory: [mem =
0x09bff000-0x09ffffff]
[    0.026781] PM: hibernation: Registered nosave memory: [mem =
0x0a200000-0x0a210fff]
[    0.026783] PM: hibernation: Registered nosave memory: [mem =
0x0b000000-0x0b01ffff]
[    0.026784] PM: hibernation: Registered nosave memory: [mem =
0xbb3f8000-0xbcbaafff]
[    0.026784] PM: hibernation: Registered nosave memory: [mem =
0xbcbab000-0xbcbdcfff]
[    0.026785] PM: hibernation: Registered nosave memory: [mem =
0xbcbdd000-0xbd28afff]
[    0.026786] PM: hibernation: Registered nosave memory: [mem =
0xbd28b000-0xbddfefff]
[    0.026787] PM: hibernation: Registered nosave memory: [mem =
0xbf000000-0xbfffffff]
[    0.026788] PM: hibernation: Registered nosave memory: [mem =
0xc0000000-0xefffffff]
[    0.026788] PM: hibernation: Registered nosave memory: [mem =
0xf0000000-0xf7ffffff]
[    0.026789] PM: hibernation: Registered nosave memory: [mem =
0xf8000000-0xfd0fffff]
[    0.026789] PM: hibernation: Registered nosave memory: [mem =
0xfd100000-0xfd1fffff]
[    0.026790] PM: hibernation: Registered nosave memory: [mem =
0xfd200000-0xfd4fffff]
[    0.026790] PM: hibernation: Registered nosave memory: [mem =
0xfd500000-0xfd6fffff]
[    0.026791] PM: hibernation: Registered nosave memory: [mem =
0xfd700000-0xfe9fffff]
[    0.026792] PM: hibernation: Registered nosave memory: [mem =
0xfea00000-0xfea0ffff]
[    0.026792] PM: hibernation: Registered nosave memory: [mem =
0xfea10000-0xfeb7ffff]
[    0.026793] PM: hibernation: Registered nosave memory: [mem =
0xfeb80000-0xfec01fff]
[    0.026793] PM: hibernation: Registered nosave memory: [mem =
0xfec02000-0xfec0ffff]
[    0.026794] PM: hibernation: Registered nosave memory: [mem =
0xfec10000-0xfec10fff]
[    0.026794] PM: hibernation: Registered nosave memory: [mem =
0xfec11000-0xfec2ffff]
[    0.026795] PM: hibernation: Registered nosave memory: [mem =
0xfec30000-0xfec30fff]
[    0.026795] PM: hibernation: Registered nosave memory: [mem =
0xfec31000-0xfecfffff]
[    0.026796] PM: hibernation: Registered nosave memory: [mem =
0xfed00000-0xfed00fff]
[    0.026797] PM: hibernation: Registered nosave memory: [mem =
0xfed01000-0xfed3ffff]
[    0.026797] PM: hibernation: Registered nosave memory: [mem =
0xfed40000-0xfed44fff]
[    0.026798] PM: hibernation: Registered nosave memory: [mem =
0xfed45000-0xfed7ffff]
[    0.026798] PM: hibernation: Registered nosave memory: [mem =
0xfed80000-0xfed8ffff]
[    0.026799] PM: hibernation: Registered nosave memory: [mem =
0xfed90000-0xfedc1fff]
[    0.026799] PM: hibernation: Registered nosave memory: [mem =
0xfedc2000-0xfedcffff]
[    0.026800] PM: hibernation: Registered nosave memory: [mem =
0xfedd0000-0xfedd3fff]
[    0.026801] PM: hibernation: Registered nosave memory: [mem =
0xfedd4000-0xfedd5fff]
[    0.026801] PM: hibernation: Registered nosave memory: [mem =
0xfedd6000-0xfeffffff]
[    0.026802] PM: hibernation: Registered nosave memory: [mem =
0xff000000-0xffffffff]
[    0.026803] [mem 0xc0000000-0xefffffff] available for PCI devices
[    0.026804] Booting paravirtualized kernel on bare hardware
[    0.026806] clocksource: refined-jiffies: mask: 0xffffffff =
max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.031310] setup_percpu: NR_CPUS:320 nr_cpumask_bits:24 =
nr_cpu_ids:24 nr_node_ids:1
[    0.032484] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 =
u524288
[    0.032489] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=3D1*2097152
[    0.032491] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
[    0.032495] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
[    0.032499] pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23
[    0.032513] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-linux-nvme =
root=3DUUID=3D78029aac-358d-4ce1-b48f-0c910bc10436 rw =
rootflags=3Drw,noatime cgroup_disable=3Dmemory mitigations=3Doff
[    0.032610] cgroup: Disabling memory control group subsystem
[    0.032623] Unknown kernel command line parameters =
"BOOT_IMAGE=3D/boot/vmlinuz-linux-nvme", will be passed to user space.
[    0.032639] random: crng init done
[    0.032640] printk: log_buf_len individual max cpu contribution: 4096 =
bytes
[    0.032640] printk: log_buf_len total cpu_extra contributions: 94208 =
bytes
[    0.032641] printk: log_buf_len min size: 131072 bytes
[    0.032785] printk: log_buf_len: 262144 bytes
[    0.032786] printk: early log buf free: 116968(89%)
[    0.034095] Dentry cache hash table entries: 2097152 (order: 12, =
16777216 bytes, linear)
[    0.034775] Inode-cache hash table entries: 1048576 (order: 11, =
8388608 bytes, linear)
[    0.034906] Fallback order for Node 0: 0
[    0.034912] Built 1 zonelists, mobility grouping on.  Total pages: =
4174947
[    0.034913] Policy zone: Normal
[    0.035122] mem auto-init: stack:all(zero), heap alloc:on, heap =
free:off
[    0.035128] software IO TLB: area num 32.
[    0.072942] Memory: 16108000K/16699788K available (18432K kernel =
code, 2197K rwdata, 13412K rodata, 3500K init, 3552K bss, 591528K =
reserved, 0K cma-reserved)
[    0.073133] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D24,=
 Nodes=3D1
[    0.073191] ftrace: allocating 49905 entries in 195 pages
[    0.079639] ftrace: allocated 195 pages with 4 groups
[    0.079709] Dynamic Preempt: full
[    0.079780] rcu: Preemptible hierarchical RCU implementation.
[    0.079780] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to =
nr_cpu_ids=3D24.
[    0.079781] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.079782] 	Trampoline variant of Tasks RCU enabled.
[    0.079782] 	Rude variant of Tasks RCU enabled.
[    0.079783] 	Tracing variant of Tasks RCU enabled.
[    0.079783] rcu: RCU calculated value of scheduler-enlistment delay =
is 30 jiffies.
[    0.079784] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, =
nr_cpu_ids=3D24
[    0.079798] RCU Tasks: Setting shift to 5 and lim to 1 =
rcu_task_cb_adjust=3D1.
[    0.079800] RCU Tasks Rude: Setting shift to 5 and lim to 1 =
rcu_task_cb_adjust=3D1.
[    0.079802] RCU Tasks Trace: Setting shift to 5 and lim to 1 =
rcu_task_cb_adjust=3D1.
[    0.081836] NR_IRQS: 20736, nr_irqs: 1160, preallocated irqs: 16
[    0.082022] rcu: srcu_init: Setting srcu_struct sizes based on =
contention.
[    0.082129] kfence: initialized - using 2097152 bytes for 255 objects =
at 0x(____ptrval____)-0x(____ptrval____)
[    0.082156] spurious 8259A interrupt: IRQ7.
[    0.082171] Console: colour dummy device 80x25
[    0.082172] printk: legacy console [tty0] enabled
[    0.082211] ACPI: Core revision 20240322
[    0.082312] clocksource: hpet: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 133484873504 ns
[    0.082326] APIC: Switch to symmetric I/O mode setup
[    0.082457] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.082519] APIC: Switched APIC routing to: physical flat
[    0.083117] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 =
pin2=3D-1
[    0.098994] clocksource: tsc-early: mask: 0xffffffffffffffff =
max_cycles: 0x3b193a2cd8f, max_idle_ns: 440795361324 ns
[    0.098997] Calibrating delay loop (skipped), value calculated using =
timer frequency.. 8203.58 BogoMIPS (lpj=3D13666536)
[    0.099007] Zenbleed: please update your microcode for the most =
optimal fix
[    0.099010] x86/cpu: User Mode Instruction Prevention (UMIP) =
activated
[    0.099052] LVT offset 1 assigned for vector 0xf9
[    0.099177] LVT offset 2 assigned for vector 0xf4
[    0.099212] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.099213] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, =
1GB 0
[    0.099215] process: using mwait in idle threads
[    0.099217] Spectre V2 : User space: Vulnerable
[    0.099218] Speculative Store Bypass: Vulnerable
[    0.099221] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating =
point registers'
[    0.099222] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.099222] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.099223] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.099224] x86/fpu: Enabled xstate features 0x7, context size is 832 =
bytes, using 'compacted' format.
[    0.116939] Freeing SMP alternatives memory: 40K
[    0.116940] pid_max: default: 32768 minimum: 301
[    0.116969] LSM: initializing =
lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.116983] landlock: Up and running.
[    0.116984] Yama: becoming mindful.
[    0.116987] LSM support for eBPF active
[    0.117015] Mount-cache hash table entries: 32768 (order: 6, 262144 =
bytes, linear)
[    0.117030] Mountpoint-cache hash table entries: 32768 (order: 6, =
262144 bytes, linear)
[    0.224562] smpboot: CPU0: AMD Ryzen 9 3900 12-Core Processor =
(family: 0x17, model: 0x71, stepping: 0x0)
[    0.224699] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.224702] ... version:                0
[    0.224703] ... bit width:              48
[    0.224703] ... generic registers:      6
[    0.224704] ... value mask:             0000ffffffffffff
[    0.224705] ... max period:             00007fffffffffff
[    0.224705] ... fixed-purpose events:   0
[    0.224705] ... event mask:             000000000000003f
[    0.224767] signal: max sigframe size: 1776
[    0.224781] rcu: Hierarchical SRCU implementation.
[    0.224781] rcu: 	Max phase no-delay instances is 1000.
[    0.225002] NMI watchdog: Enabled. Permanently consumes one hw-PMU =
counter.
[    0.225122] smp: Bringing up secondary CPUs ...
[    0.225177] smpboot: x86: Booting SMP configuration:
[    0.225178] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  =
#8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
[    0.272357] smp: Brought up 1 node, 24 CPUs
[    0.272357] smpboot: Total of 24 processors activated (196876.04 =
BogoMIPS)
[    0.276059] devtmpfs: initialized
[    0.276059] x86/mm: Memory block size: 128MB
[    0.276676] ACPI: PM: Registering ACPI NVS region [mem =
0x0a200000-0x0a210fff] (69632 bytes)
[    0.276676] ACPI: PM: Registering ACPI NVS region [mem =
0xbcbdd000-0xbd28afff] (7004160 bytes)
[    0.276676] clocksource: jiffies: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.276676] futex hash table entries: 8192 (order: 7, 524288 bytes, =
linear)
[    0.276676] pinctrl core: initialized pinctrl subsystem
[    0.276676] PM: RTC time: 18:06:09, date: 2024-08-20
[    0.276676] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.276676] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic =
allocations
[    0.276676] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for =
atomic allocations
[    0.276676] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for =
atomic allocations
[    0.276676] audit: initializing netlink subsys (disabled)
[    0.276676] audit: type=3D2000 audit(1724177169.193:1): =
state=3Dinitialized audit_enabled=3D0 res=3D1
[    0.276676] thermal_sys: Registered thermal governor 'fair_share'
[    0.276676] thermal_sys: Registered thermal governor 'bang_bang'
[    0.276676] thermal_sys: Registered thermal governor 'step_wise'
[    0.276676] thermal_sys: Registered thermal governor 'user_space'
[    0.276676] thermal_sys: Registered thermal governor =
'power_allocator'
[    0.276676] cpuidle: using governor ladder
[    0.276676] cpuidle: using governor menu
[    0.276676] Detected 1 PCC Subspaces
[    0.276676] Registering PCC driver as Mailbox controller
[    0.276676] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.279005] PCI: ECAM [mem 0xf0000000-0xf7ffffff] (base 0xf0000000) =
for domain 0000 [bus 00-7f]
[    0.279012] PCI: Using configuration type 1 for base access
[    0.279098] kprobes: kprobe jump-optimization is enabled. All kprobes =
are optimized if possible.
[    0.279104] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 =
pages
[    0.279104] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB =
page
[    0.279104] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 =
pages
[    0.279104] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.279104] Demotion targets for Node 0: null
[    0.279104] ACPI: Added _OSI(Module Device)
[    0.279104] ACPI: Added _OSI(Processor Device)
[    0.279104] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.279104] ACPI: Added _OSI(Processor Aggregator Device)
[    0.283937] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    0.285919] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.286660] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    0.286660] ACPI: Interpreter enabled
[    0.286660] ACPI: PM: (supports S0 S3 S4 S5)
[    0.286660] ACPI: Using IOAPIC for interrupt routing
[    0.286660] PCI: Using host bridge windows from ACPI; if necessary, =
use "pci=3Dnocrs" and report a bug
[    0.286660] PCI: Ignoring E820 reservations for host bridge windows
[    0.286660] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.294651] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.294656] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM =
ClockPM Segments MSI EDR HPX-Type3]
[    0.294710] acpi PNP0A08:00: _OSC: platform does not support =
[SHPCHotplug LTR DPC]
[    0.294805] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME =
AER PCIeCapability]
[    0.294812] acpi PNP0A08:00: [Firmware Info]: ECAM [mem =
0xf0000000-0xf7ffffff] for domain 0000 [bus 00-7f] only partially covers =
this bridge
[    0.295065] PCI host bridge to bus 0000:00
[    0.295066] pci_bus 0000:00: root bus resource [io  0x0000-0x03af =
window]
[    0.295068] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 =
window]
[    0.295070] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df =
window]
[    0.295070] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff =
window]
[    0.295071] pci_bus 0000:00: root bus resource [mem =
0x000a0000-0x000dffff window]
[    0.295072] pci_bus 0000:00: root bus resource [mem =
0xc0000000-0xfec2ffff window]
[    0.295073] pci_bus 0000:00: root bus resource [mem =
0xfee00000-0xffffffff window]
[    0.295074] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.295086] pci 0000:00:00.0: [1022:1480] type 00 class 0x060000 =
conventional PCI endpoint
[    0.295167] pci 0000:00:01.0: [1022:1482] type 00 class 0x060000 =
conventional PCI endpoint
[    0.295219] pci 0000:00:01.1: [1022:1483] type 01 class 0x060400 PCIe =
Root Port
[    0.295237] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.295243] pci 0000:00:01.1:   bridge window [mem =
0xfc700000-0xfc7fffff]
[    0.295308] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.295429] pci 0000:00:01.3: [1022:1483] type 01 class 0x060400 PCIe =
Root Port
[    0.295447] pci 0000:00:01.3: PCI bridge to [bus 02-06]
[    0.295451] pci 0000:00:01.3:   bridge window [io  0xf000-0xffff]
[    0.295453] pci 0000:00:01.3:   bridge window [mem =
0xfc500000-0xfc6fffff]
[    0.295466] pci 0000:00:01.3: enabling Extended Tags
[    0.295518] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
[    0.295647] pci 0000:00:02.0: [1022:1482] type 00 class 0x060000 =
conventional PCI endpoint
[    0.295701] pci 0000:00:03.0: [1022:1482] type 00 class 0x060000 =
conventional PCI endpoint
[    0.295749] pci 0000:00:03.1: [1022:1483] type 01 class 0x060400 PCIe =
Root Port
[    0.295767] pci 0000:00:03.1: PCI bridge to [bus 07]
[    0.295772] pci 0000:00:03.1:   bridge window [mem =
0xfa000000-0xfc0fffff]
[    0.295779] pci 0000:00:03.1:   bridge window [mem =
0xe0000000-0xefffffff 64bit pref]
[    0.295787] pci 0000:00:03.1: enabling Extended Tags
[    0.295839] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.295955] pci 0000:00:04.0: [1022:1482] type 00 class 0x060000 =
conventional PCI endpoint
[    0.296007] pci 0000:00:05.0: [1022:1482] type 00 class 0x060000 =
conventional PCI endpoint
[    0.296060] pci 0000:00:07.0: [1022:1482] type 00 class 0x060000 =
conventional PCI endpoint
[    0.296106] pci 0000:00:07.1: [1022:1484] type 01 class 0x060400 PCIe =
Root Port
[    0.296121] pci 0000:00:07.1: PCI bridge to [bus 08]
[    0.296135] pci 0000:00:07.1: enabling Extended Tags
[    0.296175] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
[    0.296264] pci 0000:00:08.0: [1022:1482] type 00 class 0x060000 =
conventional PCI endpoint
[    0.296311] pci 0000:00:08.1: [1022:1484] type 01 class 0x060400 PCIe =
Root Port
[    0.296327] pci 0000:00:08.1: PCI bridge to [bus 09]
[    0.296331] pci 0000:00:08.1:   bridge window [mem =
0xfc200000-0xfc4fffff]
[    0.296342] pci 0000:00:08.1: enabling Extended Tags
[    0.296386] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.296495] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 =
conventional PCI endpoint
[    0.296590] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 =
conventional PCI endpoint
[    0.296691] pci 0000:00:18.0: [1022:1440] type 00 class 0x060000 =
conventional PCI endpoint
[    0.296713] pci 0000:00:18.1: [1022:1441] type 00 class 0x060000 =
conventional PCI endpoint
[    0.296734] pci 0000:00:18.2: [1022:1442] type 00 class 0x060000 =
conventional PCI endpoint
[    0.296754] pci 0000:00:18.3: [1022:1443] type 00 class 0x060000 =
conventional PCI endpoint
[    0.296774] pci 0000:00:18.4: [1022:1444] type 00 class 0x060000 =
conventional PCI endpoint
[    0.296794] pci 0000:00:18.5: [1022:1445] type 00 class 0x060000 =
conventional PCI endpoint
[    0.296814] pci 0000:00:18.6: [1022:1446] type 00 class 0x060000 =
conventional PCI endpoint
[    0.296834] pci 0000:00:18.7: [1022:1447] type 00 class 0x060000 =
conventional PCI endpoint
[    0.297074] pci 0000:01:00.0: [2646:5013] type 00 class 0x010802 PCIe =
Endpoint
[    0.297122] pci 0000:01:00.0: BAR 0 [mem 0xfc700000-0xfc703fff 64bit]
[    0.297723] pci 0000:01:00.0: 31.504 Gb/s available PCIe bandwidth, =
limited by 8.0 GT/s PCIe x4 link at 0000:00:01.1 (capable of 63.012 Gb/s =
with 16.0 GT/s PCIe x4 link)
[    0.298140] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.298197] pci 0000:02:00.0: [1022:43d5] type 00 class 0x0c0330 PCIe =
Legacy Endpoint
[    0.298216] pci 0000:02:00.0: BAR 0 [mem 0xfc6a0000-0xfc6a7fff 64bit]
[    0.298259] pci 0000:02:00.0: enabling Extended Tags
[    0.298320] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.298462] pci 0000:02:00.1: [1022:43c8] type 00 class 0x010601 PCIe =
Legacy Endpoint
[    0.298512] pci 0000:02:00.1: BAR 5 [mem 0xfc680000-0xfc69ffff]
[    0.298521] pci 0000:02:00.1: ROM [mem 0xfc600000-0xfc67ffff pref]
[    0.298527] pci 0000:02:00.1: enabling Extended Tags
[    0.298571] pci 0000:02:00.1: PME# supported from D3hot D3cold
[    0.298655] pci 0000:02:00.2: [1022:43c6] type 01 class 0x060400 PCIe =
Switch Upstream Port
[    0.298686] pci 0000:02:00.2: PCI bridge to [bus 03-06]
[    0.298692] pci 0000:02:00.2:   bridge window [io  0xf000-0xffff]
[    0.298694] pci 0000:02:00.2:   bridge window [mem =
0xfc500000-0xfc5fffff]
[    0.298717] pci 0000:02:00.2: enabling Extended Tags
[    0.298766] pci 0000:02:00.2: PME# supported from D3hot D3cold
[    0.298869] pci 0000:00:01.3: PCI bridge to [bus 02-06]
[    0.298954] pci 0000:03:00.0: [1022:43c7] type 01 class 0x060400 PCIe =
Switch Downstream Port
[    0.298985] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.299019] pci 0000:03:00.0: enabling Extended Tags
[    0.299086] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    0.299197] pci 0000:03:01.0: [1022:43c7] type 01 class 0x060400 PCIe =
Switch Downstream Port
[    0.299228] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.299235] pci 0000:03:01.0:   bridge window [io  0xf000-0xffff]
[    0.299238] pci 0000:03:01.0:   bridge window [mem =
0xfc500000-0xfc5fffff]
[    0.299262] pci 0000:03:01.0: enabling Extended Tags
[    0.299329] pci 0000:03:01.0: PME# supported from D3hot D3cold
[    0.299439] pci 0000:03:04.0: [1022:43c7] type 01 class 0x060400 PCIe =
Switch Downstream Port
[    0.299471] pci 0000:03:04.0: PCI bridge to [bus 06]
[    0.299503] pci 0000:03:04.0: enabling Extended Tags
[    0.299569] pci 0000:03:04.0: PME# supported from D3hot D3cold
[    0.299691] pci 0000:02:00.2: PCI bridge to [bus 03-06]
[    0.299738] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.299816] pci 0000:05:00.0: [10ec:8168] type 00 class 0x020000 PCIe =
Endpoint
[    0.299845] pci 0000:05:00.0: BAR 0 [io  0xf000-0xf0ff]
[    0.299883] pci 0000:05:00.0: BAR 2 [mem 0xfc504000-0xfc504fff 64bit]
[    0.299907] pci 0000:05:00.0: BAR 4 [mem 0xfc500000-0xfc503fff 64bit]
[    0.300072] pci 0000:05:00.0: supports D1 D2
[    0.300072] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot =
D3cold
[    0.300342] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.300390] pci 0000:03:04.0: PCI bridge to [bus 06]
[    0.300468] pci 0000:07:00.0: [10de:01d1] type 00 class 0x030000 PCIe =
Endpoint
[    0.300480] pci 0000:07:00.0: BAR 0 [mem 0xfb000000-0xfbffffff]
[    0.300490] pci 0000:07:00.0: BAR 1 [mem 0xe0000000-0xefffffff 64bit =
pref]
[    0.300500] pci 0000:07:00.0: BAR 3 [mem 0xfa000000-0xfaffffff 64bit]
[    0.300513] pci 0000:07:00.0: ROM [mem 0xfc000000-0xfc01ffff pref]
[    0.300528] pci 0000:07:00.0: Video device with shadowed ROM at [mem =
0x000c0000-0x000dffff]
[    0.300624] pci 0000:07:00.0: disabling ASPM on pre-1.1 PCIe device.  =
You can enable it with 'pcie_aspm=3Dforce'
[    0.300632] pci 0000:00:03.1: PCI bridge to [bus 07]
[    0.300673] pci 0000:08:00.0: [1022:148a] type 00 class 0x130000 PCIe =
Endpoint
[    0.300708] pci 0000:08:00.0: enabling Extended Tags
[    0.300842] pci 0000:00:07.1: PCI bridge to [bus 08]
[    0.300887] pci 0000:09:00.0: [1022:1485] type 00 class 0x130000 PCIe =
Endpoint
[    0.300929] pci 0000:09:00.0: enabling Extended Tags
[    0.301077] pci 0000:09:00.1: [1022:1486] type 00 class 0x108000 PCIe =
Endpoint
[    0.301097] pci 0000:09:00.1: BAR 2 [mem 0xfc300000-0xfc3fffff]
[    0.301112] pci 0000:09:00.1: BAR 5 [mem 0xfc400000-0xfc401fff]
[    0.301121] pci 0000:09:00.1: enabling Extended Tags
[    0.301242] pci 0000:09:00.3: [1022:149c] type 00 class 0x0c0330 PCIe =
Endpoint
[    0.301254] pci 0000:09:00.3: BAR 0 [mem 0xfc200000-0xfc2fffff 64bit]
[    0.301283] pci 0000:09:00.3: enabling Extended Tags
[    0.301328] pci 0000:09:00.3: PME# supported from D0 D3hot D3cold
[    0.301424] pci 0000:00:08.1: PCI bridge to [bus 09]
[    0.301699] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.301733] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.301762] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.301798] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.301831] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.301857] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.301884] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.301910] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.302340] iommu: Default domain type: Translated
[    0.302340] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.302429] SCSI subsystem initialized
[    0.302435] libata version 3.00 loaded.
[    0.302435] ACPI: bus type USB registered
[    0.302435] usbcore: registered new interface driver usbfs
[    0.302435] usbcore: registered new interface driver hub
[    0.302435] usbcore: registered new device driver usb
[    0.302435] pps_core: LinuxPPS API ver. 1 registered
[    0.302435] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>
[    0.302435] PTP clock support registered
[    0.302435] EDAC MC: Ver: 3.0.0
[    0.302592] NetLabel: Initializing
[    0.302592] NetLabel:  domain hash size =3D 128
[    0.302592] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.302592] NetLabel:  unlabeled traffic allowed by default
[    0.302592] mctp: management component transport protocol core
[    0.302592] NET: Registered PF_MCTP protocol family
[    0.302592] PCI: Using ACPI for IRQ routing
[    0.306769] PCI: pci_cache_line_size set to 64 bytes
[    0.307148] e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
[    0.307149] e820: reserve RAM buffer [mem 0x09bff000-0x0bffffff]
[    0.307150] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.307151] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.307151] e820: reserve RAM buffer [mem 0xbb3f8000-0xbbffffff]
[    0.307152] e820: reserve RAM buffer [mem 0xbf000000-0xbfffffff]
[    0.307153] e820: reserve RAM buffer [mem 0x43f300000-0x43fffffff]
[    0.307162] pci 0000:07:00.0: vgaarb: setting as boot VGA device
[    0.307162] pci 0000:07:00.0: vgaarb: bridge control possible
[    0.307162] pci 0000:07:00.0: vgaarb: VGA device added: =
decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.307162] vgaarb: loaded
[    0.307162] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.307162] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.309045] clocksource: Switched to clocksource tsc-early
[    0.309129] VFS: Disk quotas dquot_6.6.0
[    0.309136] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 =
bytes)
[    0.309176] pnp: PnP ACPI init
[    0.309228] system 00:00: [mem 0xf0000000-0xf7ffffff] has been =
reserved
[    0.309248] system 00:01: [mem 0xfeb80000-0xfebfffff] has been =
reserved
[    0.309292] system 00:02: [mem 0xfd100000-0xfd1fffff] has been =
reserved
[    0.309428] system 00:04: [io  0x0280-0x028f] has been reserved
[    0.309429] system 00:04: [io  0x0290-0x029f] has been reserved
[    0.309430] system 00:04: [io  0x02a0-0x02af] has been reserved
[    0.309431] system 00:04: [io  0x02b0-0x02bf] has been reserved
[    0.309595] pnp 00:05: [dma 0 disabled]
[    0.309755] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.309756] system 00:06: [io  0x040b] has been reserved
[    0.309757] system 00:06: [io  0x04d6] has been reserved
[    0.309758] system 00:06: [io  0x0c00-0x0c01] has been reserved
[    0.309758] system 00:06: [io  0x0c14] has been reserved
[    0.309759] system 00:06: [io  0x0c50-0x0c51] has been reserved
[    0.309760] system 00:06: [io  0x0c52] has been reserved
[    0.309761] system 00:06: [io  0x0c6c] has been reserved
[    0.309762] system 00:06: [io  0x0c6f] has been reserved
[    0.309762] system 00:06: [io  0x0cd8-0x0cdf] has been reserved
[    0.309763] system 00:06: [io  0x0800-0x089f] has been reserved
[    0.309764] system 00:06: [io  0x0b00-0x0b0f] has been reserved
[    0.309765] system 00:06: [io  0x0b20-0x0b3f] has been reserved
[    0.309766] system 00:06: [io  0x0900-0x090f] has been reserved
[    0.309767] system 00:06: [io  0x0910-0x091f] has been reserved
[    0.309768] system 00:06: [mem 0xfec00000-0xfec00fff] could not be =
reserved
[    0.309769] system 00:06: [mem 0xfec01000-0xfec01fff] could not be =
reserved
[    0.309770] system 00:06: [mem 0xfedc0000-0xfedc0fff] has been =
reserved
[    0.309772] system 00:06: [mem 0xfee00000-0xfee00fff] has been =
reserved
[    0.309772] system 00:06: [mem 0xfed80000-0xfed8ffff] could not be =
reserved
[    0.309774] system 00:06: [mem 0xfec10000-0xfec10fff] has been =
reserved
[    0.309775] system 00:06: [mem 0xff000000-0xffffffff] has been =
reserved
[    0.310078] pnp: PnP ACPI: found 7 devices
[    0.315286] clocksource: acpi_pm: mask: 0xffffff max_cycles: =
0xffffff, max_idle_ns: 2085701024 ns
[    0.315327] NET: Registered PF_INET protocol family
[    0.315450] IP idents hash table entries: 262144 (order: 9, 2097152 =
bytes, linear)
[    0.325182] tcp_listen_portaddr_hash hash table entries: 8192 (order: =
5, 131072 bytes, linear)
[    0.325198] Table-perturb hash table entries: 65536 (order: 6, 262144 =
bytes, linear)
[    0.325255] TCP established hash table entries: 131072 (order: 8, =
1048576 bytes, linear)
[    0.325462] TCP bind hash table entries: 65536 (order: 9, 2097152 =
bytes, linear)
[    0.325561] TCP: Hash tables configured (established 131072 bind =
65536)
[    0.325609] MPTCP token hash table entries: 16384 (order: 6, 393216 =
bytes, linear)
[    0.325643] UDP hash table entries: 8192 (order: 6, 262144 bytes, =
linear)
[    0.325673] UDP-Lite hash table entries: 8192 (order: 6, 262144 =
bytes, linear)
[    0.325718] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.325724] NET: Registered PF_XDP protocol family
[    0.325734] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.325737] pci 0000:00:01.1:   bridge window [mem =
0xfc700000-0xfc7fffff]
[    0.325743] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.325754] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.325756] pci 0000:03:01.0:   bridge window [io  0xf000-0xffff]
[    0.325760] pci 0000:03:01.0:   bridge window [mem =
0xfc500000-0xfc5fffff]
[    0.325768] pci 0000:03:04.0: PCI bridge to [bus 06]
[    0.325778] pci 0000:02:00.2: PCI bridge to [bus 03-06]
[    0.325780] pci 0000:02:00.2:   bridge window [io  0xf000-0xffff]
[    0.325784] pci 0000:02:00.2:   bridge window [mem =
0xfc500000-0xfc5fffff]
[    0.325791] pci 0000:00:01.3: PCI bridge to [bus 02-06]
[    0.325793] pci 0000:00:01.3:   bridge window [io  0xf000-0xffff]
[    0.325795] pci 0000:00:01.3:   bridge window [mem =
0xfc500000-0xfc6fffff]
[    0.325801] pci 0000:00:03.1: PCI bridge to [bus 07]
[    0.325803] pci 0000:00:03.1:   bridge window [mem =
0xfa000000-0xfc0fffff]
[    0.325805] pci 0000:00:03.1:   bridge window [mem =
0xe0000000-0xefffffff 64bit pref]
[    0.325809] pci 0000:00:07.1: PCI bridge to [bus 08]
[    0.325815] pci 0000:00:08.1: PCI bridge to [bus 09]
[    0.325817] pci 0000:00:08.1:   bridge window [mem =
0xfc200000-0xfc4fffff]
[    0.325822] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.325823] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.325824] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.325825] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.325826] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff =
window]
[    0.325827] pci_bus 0000:00: resource 9 [mem 0xc0000000-0xfec2ffff =
window]
[    0.325828] pci_bus 0000:00: resource 10 [mem 0xfee00000-0xffffffff =
window]
[    0.325829] pci_bus 0000:01: resource 1 [mem 0xfc700000-0xfc7fffff]
[    0.325830] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
[    0.325830] pci_bus 0000:02: resource 1 [mem 0xfc500000-0xfc6fffff]
[    0.325831] pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
[    0.325832] pci_bus 0000:03: resource 1 [mem 0xfc500000-0xfc5fffff]
[    0.325833] pci_bus 0000:05: resource 0 [io  0xf000-0xffff]
[    0.325834] pci_bus 0000:05: resource 1 [mem 0xfc500000-0xfc5fffff]
[    0.325835] pci_bus 0000:07: resource 1 [mem 0xfa000000-0xfc0fffff]
[    0.325835] pci_bus 0000:07: resource 2 [mem 0xe0000000-0xefffffff =
64bit pref]
[    0.325836] pci_bus 0000:09: resource 1 [mem 0xfc200000-0xfc4fffff]
[    0.326214] PCI: CLS 64 bytes, default 64
[    0.326225] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.326226] software IO TLB: mapped [mem =
0x00000000b73f8000-0x00000000bb3f8000] (64MB)
[    0.326256] LVT offset 0 assigned for vector 0x400
[    0.326258] Trying to unpack rootfs image as initramfs...
[    0.330895] perf: AMD IBS detected (0x000003ff)
[    0.332400] Initialise system trusted keyrings
[    0.332408] Key type blacklist registered
[    0.332434] workingset: timestamp_bits=3D41 max_order=3D22 =
bucket_order=3D0
[    0.332439] zbud: loaded
[    0.332545] integrity: Platform Keyring initialized
[    0.332547] integrity: Machine keyring initialized
[    0.340673] Key type asymmetric registered
[    0.340675] Asymmetric key parser 'x509' registered
[    0.340833] Block layer SCSI generic (bsg) driver version 0.4 loaded =
(major 242)
[    0.340872] io scheduler mq-deadline registered
[    0.340873] io scheduler kyber registered
[    0.340883] io scheduler bfq registered
[    0.341928] pcieport 0000:00:01.1: PME: Signaling with IRQ 26
[    0.341969] pcieport 0000:00:01.1: AER: enabled with IRQ 26
[    0.342065] pcieport 0000:00:01.3: PME: Signaling with IRQ 27
[    0.342106] pcieport 0000:00:01.3: AER: enabled with IRQ 27
[    0.342197] pcieport 0000:00:03.1: PME: Signaling with IRQ 28
[    0.342233] pcieport 0000:00:03.1: AER: enabled with IRQ 28
[    0.342365] pcieport 0000:00:07.1: PME: Signaling with IRQ 30
[    0.342398] pcieport 0000:00:07.1: AER: enabled with IRQ 30
[    0.342472] pcieport 0000:00:08.1: PME: Signaling with IRQ 31
[    0.342513] pcieport 0000:00:08.1: AER: enabled with IRQ 31
[    0.342969] shpchp: Standard Hot Plug PCI Controller Driver version: =
0.4
[    0.343044] input: Power Button as =
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.343059] ACPI: button: Power Button [PWRB]
[    0.343075] input: Power Button as =
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.345501] ACPI: button: Power Button [PWRF]
[    0.348832] Estimated ratio of average max frequency by base =
frequency (times 1024): 1232
[    0.348846] Monitor-Mwait will be used to enter C-1 state
[    0.348851] ACPI: \_PR_.C000: Found 2 idle states
[    0.348921] ACPI: \_PR_.C002: Found 2 idle states
[    0.348993] ACPI: \_PR_.C004: Found 2 idle states
[    0.349043] ACPI: \_PR_.C006: Found 2 idle states
[    0.349091] ACPI: \_PR_.C008: Found 2 idle states
[    0.349141] ACPI: \_PR_.C00A: Found 2 idle states
[    0.349211] ACPI: \_PR_.C00C: Found 2 idle states
[    0.349282] ACPI: \_PR_.C00E: Found 2 idle states
[    0.349349] ACPI: \_PR_.C010: Found 2 idle states
[    0.349418] ACPI: \_PR_.C012: Found 2 idle states
[    0.349492] ACPI: \_PR_.C014: Found 2 idle states
[    0.349562] ACPI: \_PR_.C016: Found 2 idle states
[    0.349611] ACPI: \_PR_.C001: Found 2 idle states
[    0.349659] ACPI: \_PR_.C003: Found 2 idle states
[    0.349727] ACPI: \_PR_.C005: Found 2 idle states
[    0.349795] ACPI: \_PR_.C007: Found 2 idle states
[    0.349860] ACPI: \_PR_.C009: Found 2 idle states
[    0.349946] ACPI: \_PR_.C00B: Found 2 idle states
[    0.350021] ACPI: \_PR_.C00D: Found 2 idle states
[    0.350087] ACPI: \_PR_.C00F: Found 2 idle states
[    0.350154] ACPI: \_PR_.C011: Found 2 idle states
[    0.350218] ACPI: \_PR_.C013: Found 2 idle states
[    0.350281] ACPI: \_PR_.C015: Found 2 idle states
[    0.350343] ACPI: \_PR_.C017: Found 2 idle states
[    0.350506] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.350656] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[    0.352195] Non-volatile memory driver v1.3
[    0.352196] Linux agpgart interface v0.103
[    0.352232] ACPI: bus type drm_connector registered
[    0.353115] ahci 0000:02:00.1: version 3.0
[    0.353228] ahci 0000:02:00.1: SSS flag set, parallel bus scan =
disabled
[    0.353271] ahci 0000:02:00.1: AHCI vers 0001.0301, 32 command slots, =
6 Gbps, SATA mode
[    0.353273] ahci 0000:02:00.1: 4/8 ports implemented (port mask 0x33)
[    0.353274] ahci 0000:02:00.1: flags: 64bit ncq sntf stag pm led clo =
only pmp pio slum part sxs deso sadm sds apst
[    0.353572] scsi host0: ahci
[    0.353635] scsi host1: ahci
[    0.353687] scsi host2: ahci
[    0.353746] scsi host3: ahci
[    0.353791] scsi host4: ahci
[    0.353847] scsi host5: ahci
[    0.353896] scsi host6: ahci
[    0.353947] scsi host7: ahci
[    0.353963] ata1: SATA max UDMA/133 abar m131072@0xfc680000 port =
0xfc680100 irq 37 lpm-pol 3
[    0.353965] ata2: SATA max UDMA/133 abar m131072@0xfc680000 port =
0xfc680180 irq 37 lpm-pol 3
[    0.353966] ata3: DUMMY
[    0.353966] ata4: DUMMY
[    0.353968] ata5: SATA max UDMA/133 abar m131072@0xfc680000 port =
0xfc680300 irq 37 lpm-pol 3
[    0.353969] ata6: SATA max UDMA/133 abar m131072@0xfc680000 port =
0xfc680380 irq 37 lpm-pol 3
[    0.353970] ata7: DUMMY
[    0.353970] ata8: DUMMY
[    0.354035] usbcore: registered new interface driver =
usbserial_generic
[    0.354038] usbserial: USB Serial support registered for generic
[    0.354075] rtc_cmos 00:03: RTC can wake from S4
[    0.354252] rtc_cmos 00:03: registered as rtc0
[    0.354279] rtc_cmos 00:03: setting system clock to =
2024-08-20T18:06:09 UTC (1724177169)
[    0.354298] rtc_cmos 00:03: alarms up to one month, y3k, 114 bytes =
nvram
[    0.354326] amd_pstate: driver load is disabled, boot with specific =
mode to enable this
[    0.354436] ledtrig-cpu: registered to indicate activity on CPUs
[    0.354502] vesafb: mode is 640x480x32, linelength=3D2560, pages=3D0
[    0.354503] vesafb: scrolling: redraw
[    0.354504] vesafb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.354510] vesafb: framebuffer at 0xe0000000, mapped to =
0x000000002650fc98, using 1216k, total 1216k
[    0.354529] fbcon: Deferring console take-over
[    0.354529] fb0: VESA VGA frame buffer device
[    0.354537] hid: raw HID events driver (C) Jiri Kosina
[    0.354575] drop_monitor: Initializing network drop monitor service
[    0.354633] Initializing XFRM netlink socket
[    0.354652] NET: Registered PF_INET6 protocol family
[    0.452105] Freeing initrd memory: 180616K
[    0.454777] Segment Routing with IPv6
[    0.454779] RPL Segment Routing with IPv6
[    0.454790] In-situ OAM (IOAM) with IPv6
[    0.454814] NET: Registered PF_PACKET protocol family
[    0.455609] microcode: Current revision: 0x08701030
[    0.455889] resctrl: L3 allocation detected
[    0.455890] resctrl: MB allocation detected
[    0.455890] resctrl: L3 monitoring detected
[    0.455908] IPI shorthand broadcast: enabled
[    0.456871] sched_clock: Marking stable (455603833, =
280415)->(458727803, -2843555)
[    0.456945] Timer migration: 2 hierarchy levels; 8 children per =
group; 2 crossnode level
[    0.457050] registered taskstats version 1
[    0.457399] Loading compiled-in X.509 certificates
[    0.459726] Loaded X.509 cert 'Build time autogenerated kernel key: =
95ece764cfce3af14865b3218c7a308c3720a6eb'
[    0.462211] zswap: loaded using pool lz4/z3fold
[    0.462238] Demotion targets for Node 0: null
[    0.462369] Key type .fscrypt registered
[    0.462370] Key type fscrypt-provisioning registered
[    0.462570] PM:   Magic number: 4:490:140
[    0.462634] acpi device:11: hash matches
[    0.462713] RAS: Correctable Errors collector initialized.
[    0.470364] clk: Disabling unused clocks
[    0.470366] PM: genpd: Disabling unused power domains
[    0.831843] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.832472] ata1.00: ATA-9: ADATA SU800, 02K0S86D, max UDMA/133
[    0.832490] ata1.00: 1000215216 sectors, multi 1: LBA48 NCQ (depth =
32), AA
[    0.832852] ata1.00: Features: Dev-Sleep
[    0.833307] ata1.00: configured for UDMA/133
[    0.845169] ahci 0000:02:00.1: port does not support device sleep
[    0.845260] scsi 0:0:0:0: Direct-Access     ATA      ADATA SU800      =
S86D PQ: 0 ANSI: 5
[    0.845395] sd 0:0:0:0: [sda] 1000215216 512-byte logical blocks: =
(512 GB/477 GiB)
[    0.845401] sd 0:0:0:0: [sda] Write Protect is off
[    0.845402] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.845407] sd 0:0:0:0: [sda] Write cache: enabled, read cache: =
enabled, doesn't support DPO or FUA
[    0.845416] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    0.846320]  sda: sda1 sda2 sda3
[    0.846366] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.157224] ata2: SATA link down (SStatus 0 SControl 300)
[    1.334043] tsc: Refined TSC clocksource calibration: 4099.997 MHz
[    1.334052] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: =
0x3b195c4884e, max_idle_ns: 440795370048 ns
[    1.334137] clocksource: Switched to clocksource tsc
[    1.471596] ata5: SATA link down (SStatus 0 SControl 330)
[    1.783765] ata6: SATA link down (SStatus 0 SControl 330)
[    1.784892] Freeing unused decrypted memory: 2028K
[    1.785158] Freeing unused kernel image (initmem) memory: 3500K
[    1.785169] Write protecting the kernel read-only data: 32768k
[    1.785391] Freeing unused kernel image (rodata/data gap) memory: =
924K
[    1.795786] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.795790] rodata_test: all tests were successful
[    1.795793] Run /init as init process
[    1.795794]   with arguments:
[    1.795795]     /init
[    1.795796]   with environment:
[    1.795796]     HOME=3D/
[    1.795797]     TERM=3Dlinux
[    1.795797]     BOOT_IMAGE=3D/boot/vmlinuz-linux-nvme
[    1.800790] fbcon: Taking over console
[    1.800836] Console: switching to colour frame buffer device 80x30
[    1.906539] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    1.906546] xhci_hcd 0000:02:00.0: new USB bus registered, assigned =
bus number 1
[    1.910104] nvme nvme0: pci function 0000:01:00.0
[    1.915230] nvme nvme0: D3 entry latency set to 10 seconds
[    1.917840] nvme nvme0: 24/0/0 default/read/poll queues
[    1.920256]  nvme0n1: p1 p2 p3
[    1.961860] xhci_hcd 0000:02:00.0: hcc params 0x0200ef81 hci version =
0x110 quirks 0x0000000000000010
[    1.962019] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    1.962021] xhci_hcd 0000:02:00.0: new USB bus registered, assigned =
bus number 2
[    1.962023] xhci_hcd 0000:02:00.0: Host supports USB 3.1 Enhanced =
SuperSpeed
[    1.962078] usb usb1: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.10
[    1.962080] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.962081] usb usb1: Product: xHCI Host Controller
[    1.962082] usb usb1: Manufacturer: Linux 6.10.6-12 xhci-hcd
[    1.962083] usb usb1: SerialNumber: 0000:02:00.0
[    1.962164] hub 1-0:1.0: USB hub found
[    1.962177] hub 1-0:1.0: 10 ports detected
[    1.962384] usb usb2: We don't know the algorithms for LPM for this =
host, disabling LPM.
[    1.962397] usb usb2: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.10
[    1.962398] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.962399] usb usb2: Product: xHCI Host Controller
[    1.962400] usb usb2: Manufacturer: Linux 6.10.6-12 xhci-hcd
[    1.962401] usb usb2: SerialNumber: 0000:02:00.0
[    1.962441] hub 2-0:1.0: USB hub found
[    1.962448] hub 2-0:1.0: 4 ports detected
[    1.962499] usb: port power management may be unreliable
[    1.962604] xhci_hcd 0000:09:00.3: xHCI Host Controller
[    1.962607] xhci_hcd 0000:09:00.3: new USB bus registered, assigned =
bus number 3
[    1.962704] xhci_hcd 0000:09:00.3: hcc params 0x0278ffe5 hci version =
0x110 quirks 0x0000000000000010
[    1.962847] xhci_hcd 0000:09:00.3: xHCI Host Controller
[    1.962848] xhci_hcd 0000:09:00.3: new USB bus registered, assigned =
bus number 4
[    1.962850] xhci_hcd 0000:09:00.3: Host supports USB 3.1 Enhanced =
SuperSpeed
[    1.962868] usb usb3: New USB device found, idVendor=3D1d6b, =
idProduct=3D0002, bcdDevice=3D 6.10
[    1.962869] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.962870] usb usb3: Product: xHCI Host Controller
[    1.962871] usb usb3: Manufacturer: Linux 6.10.6-12 xhci-hcd
[    1.962872] usb usb3: SerialNumber: 0000:09:00.3
[    1.962908] hub 3-0:1.0: USB hub found
[    1.962913] hub 3-0:1.0: 4 ports detected
[    1.963006] usb usb4: We don't know the algorithms for LPM for this =
host, disabling LPM.
[    1.963016] usb usb4: New USB device found, idVendor=3D1d6b, =
idProduct=3D0003, bcdDevice=3D 6.10
[    1.963017] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    1.963018] usb usb4: Product: xHCI Host Controller
[    1.963019] usb usb4: Manufacturer: Linux 6.10.6-12 xhci-hcd
[    1.963019] usb usb4: SerialNumber: 0000:09:00.3
[    1.963057] hub 4-0:1.0: USB hub found
[    1.963062] hub 4-0:1.0: 4 ports detected
[    2.205258] Console: switching to colour dummy device 80x25
[    2.205272] nouveau 0000:07:00.0: vgaarb: deactivate vga console
[    2.205298] nouveau 0000:07:00.0: NVIDIA G72 (046100a3)
[    2.415140] nouveau 0000:07:00.0: bios: version 05.72.22.43.35
[    2.415405] nouveau 0000:07:00.0: fb: 128 MiB DDR2
[    2.469167] nouveau 0000:07:00.0: DRM: VRAM: 124 MiB
[    2.469168] nouveau 0000:07:00.0: DRM: GART: 512 MiB
[    2.469169] nouveau 0000:07:00.0: DRM: TMDS table version 1.1
[    2.469170] nouveau 0000:07:00.0: DRM: TMDS table script pointers not =
stubbed
[    2.469171] nouveau 0000:07:00.0: DRM: DCB version 3.0
[    2.469172] nouveau 0000:07:00.0: DRM: DCB outp 00: 01000300 00000028
[    2.469173] nouveau 0000:07:00.0: DRM: DCB outp 01: 02011310 00000028
[    2.469174] nouveau 0000:07:00.0: DRM: DCB outp 02: 01011312 00000000
[    2.469175] nouveau 0000:07:00.0: DRM: DCB outp 03: 020223f1 00c0c080
[    2.469176] nouveau 0000:07:00.0: DRM: DCB conn 00: 0000
[    2.469177] nouveau 0000:07:00.0: DRM: DCB conn 01: 2130
[    2.469178] nouveau 0000:07:00.0: DRM: DCB conn 02: 0210
[    2.469178] nouveau 0000:07:00.0: DRM: DCB conn 03: 0211
[    2.469179] nouveau 0000:07:00.0: DRM: DCB conn 04: 0213
[    2.469699] nouveau 0000:07:00.0: DRM: MM: using M2MF for buffer =
copies
[    2.475140] [drm] Initialized nouveau 1.4.0 20120801 for 0000:07:00.0 =
on minor 0
[    2.475159] nouveau 0000:07:00.0: DRM: Setting dpms mode 3 on TV =
encoder (output 3)
[    2.583625] nouveau 0000:07:00.0: [drm] Cannot find any crtc or sizes
[    2.693635] nouveau 0000:07:00.0: [drm] Cannot find any crtc or sizes
[    2.806972] nouveau 0000:07:00.0: [drm] Cannot find any crtc or sizes
[    2.923646] nouveau 0000:07:00.0: [drm] Cannot find any crtc or sizes
[    3.001689] SGI XFS with ACLs, security attributes, realtime, scrub, =
repair, quota, no debug enabled
[    3.008914] XFS (nvme0n1p2): Mounting V5 Filesystem =
78029aac-358d-4ce1-b48f-0c910bc10436
[    3.018967] XFS (nvme0n1p2): Ending clean mount
[    3.036959] nouveau 0000:07:00.0: [drm] Cannot find any crtc or sizes
[    3.075285] systemd[1]: systemd 255-1-arch running in system mode =
(+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS =
+OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD =
+LIBCRYPTSETUP +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 =
+BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT =
default-hierarchy=3Dunified)
[    3.075289] systemd[1]: Detected architecture x86-64.
[    3.075905] systemd[1]: Hostname set to <minimyth2-aarch64-next>.
[    3.310464] systemd[1]: bpf-lsm: LSM BPF program attached
[    3.377445] systemd[1]: =
/etc/systemd/system/sleep-on-inactivity.service:6: Failed to parse =
service type, ignoring: daemon
[    3.387664] systemd[1]: Queued start job for default target Graphical =
Interface.
[    3.430634] systemd[1]: Created slice Slice /system/getty.
[    3.430786] systemd[1]: Created slice Slice /system/modprobe.
[    3.430902] systemd[1]: Created slice Slice /system/systemd-fsck.
[    3.431019] systemd[1]: Created slice Slice /system/tmux.
[    3.431098] systemd[1]: Created slice User and Session Slice.
[    3.431139] systemd[1]: Started Dispatch Password Requests to Console =
Directory Watch.
[    3.431170] systemd[1]: Started Forward Password Requests to Wall =
Directory Watch.
[    3.431258] systemd[1]: Set up automount Arbitrary Executable File =
Formats File System Automount Point.
[    3.431288] systemd[1]: Reached target Local Encrypted Volumes.
[    3.431305] systemd[1]: Reached target Local Integrity Protected =
Volumes.
[    3.431326] systemd[1]: Reached target Host and Network Name Lookups.
[    3.431340] systemd[1]: Reached target Path Units.
[    3.431356] systemd[1]: Reached target Remote File Systems.
[    3.431373] systemd[1]: Reached target Slice Units.
[    3.431395] systemd[1]: Reached target Local Verity Protected =
Volumes.
[    3.431436] systemd[1]: Listening on Device-mapper event daemon =
FIFOs.
[    3.431703] systemd[1]: Listening on LVM2 poll daemon socket.
[    3.433732] systemd[1]: Listening on RPCbind Server Activation =
Socket.
[    3.433777] systemd[1]: Reached target RPC Port Mapper.
[    3.434505] systemd[1]: Listening on Process Core Dump Socket.
[    3.434584] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.434645] systemd[1]: Listening on Journal Socket.
[    3.434869] systemd[1]: Listening on Network Service Netlink Socket.
[    3.434907] systemd[1]: TPM2 PCR Extension (Varlink) was skipped =
because of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.435321] systemd[1]: Listening on udev Control Socket.
[    3.435391] systemd[1]: Listening on udev Kernel Socket.
[    3.435975] systemd[1]: Mounting Huge Pages File System...
[    3.436279] systemd[1]: Mounting POSIX Message Queue File System...
[    3.436538] systemd[1]: Mounting NFSD configuration filesystem...
[    3.436808] systemd[1]: Mounting Kernel Debug File System...
[    3.437086] systemd[1]: Mounting Kernel Trace File System...
[    3.437125] systemd[1]: Kernel Module supporting RPCSEC_GSS was =
skipped because of an unmet condition check =
(ConditionPathExists=3D/etc/krb5.keytab).
[    3.437457] systemd[1]: Starting Create List of Static Device =
Nodes...
[    3.437763] systemd[1]: Starting Monitoring of LVM2 mirrors, =
snapshots etc. using dmeventd or progress polling...
[    3.438071] systemd[1]: Starting Load Kernel Module configfs...
[    3.438401] systemd[1]: Starting Load Kernel Module dm_mod...
[    3.438723] systemd[1]: Starting Load Kernel Module drm...
[    3.439207] systemd[1]: Starting Load Kernel Module fuse...
[    3.439538] systemd[1]: Starting Load Kernel Module loop...
[    3.439620] systemd[1]: File System Check on Root Device was skipped =
because of an unmet condition check (ConditionPathIsReadWrite=3D!/).
[    3.440337] systemd[1]: Starting Journal Service...
[    3.440915] systemd[1]: Starting Load Kernel Modules...
[    3.441337] systemd[1]: Starting Generate network units from Kernel =
command line...
[    3.441383] systemd[1]: TPM2 PCR Machine ID Measurement was skipped =
because of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.441775] systemd[1]: Starting Remount Root and Kernel File =
Systems...
[    3.441831] systemd[1]: TPM2 SRK Setup (Early) was skipped because of =
an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.442213] systemd[1]: Starting Coldplug All udev Devices...
[    3.442990] systemd[1]: Mounted Huge Pages File System.
[    3.443083] systemd[1]: Mounted POSIX Message Queue File System.
[    3.443150] systemd[1]: Mounted Kernel Debug File System.
[    3.443216] systemd[1]: Mounted Kernel Trace File System.
[    3.443349] systemd[1]: Finished Create List of Static Device Nodes.
[    3.443534] systemd[1]: modprobe@configfs.service: Deactivated =
successfully.
[    3.443605] systemd[1]: Finished Load Kernel Module configfs.
[    3.443773] systemd[1]: modprobe@drm.service: Deactivated =
successfully.
[    3.443822] systemd[1]: Finished Load Kernel Module drm.
[    3.444207] systemd[1]: Mounting Kernel Configuration File System...
[    3.444519] systemd[1]: Starting Create Static Device Nodes in /dev =
gracefully...
[    3.445620] systemd[1]: Finished Generate network units from Kernel =
command line.
[    3.445676] systemd[1]: Reached target Preparation for Network.
[    3.445980] loop: module loaded
[    3.446215] systemd[1]: modprobe@loop.service: Deactivated =
successfully.
[    3.446270] systemd[1]: Finished Load Kernel Module loop.
[    3.446764] systemd[1]: Finished Remount Root and Kernel File =
Systems.
[    3.447242] systemd[1]: Rebuild Hardware Database was skipped because =
of an unmet condition check (ConditionNeedsUpdate=3D/etc).
[    3.447577] systemd[1]: Starting Load/Save OS Random Seed...
[    3.447602] systemd[1]: TPM2 SRK Setup was skipped because of an =
unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    3.447816] systemd[1]: Mounted Kernel Configuration File System.
[    3.449700] systemd-journald[483]: Collecting audit messages is =
disabled.
[    3.451114] device-mapper: uevent: version 1.0.3
[    3.451200] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) =
initialised: dm-devel@lists.linux.dev
[    3.451287] fuse: init (API version 7.40)
[    3.451539] systemd[1]: modprobe@dm_mod.service: Deactivated =
successfully.
[    3.451597] systemd[1]: Finished Load Kernel Module dm_mod.
[    3.451744] systemd[1]: modprobe@fuse.service: Deactivated =
successfully.
[    3.451795] systemd[1]: Finished Load Kernel Module fuse.
[    3.452157] systemd[1]: Mounting FUSE Control File System...
[    3.452195] systemd[1]: Repartition Root Disk was skipped because no =
trigger condition checks were met.
[    3.453918] systemd[1]: Finished Load/Save OS Random Seed.
[    3.454982] systemd[1]: Mounted FUSE Control File System.
[    3.455999] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.462659] systemd[1]: Finished Create Static Device Nodes in /dev =
gracefully.
[    3.462745] systemd[1]: Create System Users was skipped because no =
trigger condition checks were met.
[    3.463073] systemd[1]: Starting Create Static Device Nodes in =
/dev...
[    3.469292] systemd[1]: Started Journal Service.
[    3.473672] systemd-journald[483]: Received client request to flush =
runtime journal.
[    3.476629] systemd-journald[483]: =
/var/log/journal/1a15c5c01ee34ffb8beb42df7c18ff94/system.journal: =
Journal file uses a different sequence number ID, rotating.
[    3.476633] systemd-journald[483]: Rotating system journal.
[    3.483888] RPC: Registered named UNIX socket transport module.
[    3.483891] RPC: Registered udp transport module.
[    3.483892] RPC: Registered tcp transport module.
[    3.483892] RPC: Registered tcp-with-tls transport module.
[    3.483893] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.484834] nct6775: Found NCT6779D or compatible chip at 0x2e:0x290
[    3.545102] ryzen_smu: CPUID: family 0x17, model 0x71, stepping 0x0, =
package 0x2
[    3.545142] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, =
revision 0
[    3.545147] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus =
port selection
[    3.545167] input: PC Speaker as =
/devices/platform/pcspkr/input/input2
[    3.545281] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller =
at 0xb20
[    3.545285] ryzen_smu: SMU v46.73.0
[    3.546291] acpi_cpufreq: overriding BIOS provided _PSD data
[    3.551915] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, =
163840 ms ovfl timer
[    3.551917] RAPL PMU: hw unit of domain package 2^-16 Joules
[    3.553285] ccp 0000:09:00.1: ccp: unable to access the device: you =
might be running a broken BIOS.
[    3.553298] ccp 0000:09:00.1: psp enabled
[    3.558005] cryptd: max_cpu_qlen set to 1000
[    3.563149] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    3.563215] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO =
address
[    3.563443] sp5100-tco sp5100-tco: initialized. heartbeat=3D60 sec =
(nowayout=3D0)
[    3.572167] AVX2 version of gcm_enc/dec engaged.
[    3.572209] AES CTR mode by8 optimization enabled
[    3.634695] Adding 16776188k swap on /dev/nvme0n1p3.  Priority:-2 =
extents:1 across:16776188k SS
[    3.636579] r8169 0000:05:00.0 eth0: RTL8168h/8111h, =
9c:6b:00:00:6d:71, XID 541, IRQ 79
[    3.636585] r8169 0000:05:00.0 eth0: jumbo features [frames: 9194 =
bytes, tx checksumming: ko]
[    3.644292] r8169 0000:05:00.0 enp5s0: renamed from eth0
[    3.721283] kvm_amd: TSC scaling supported
[    3.721286] kvm_amd: Nested Virtualization enabled
[    3.721287] kvm_amd: Nested Paging enabled
[    3.721288] kvm_amd: LBR virtualization supported
[    3.721289] kvm_amd: SEV enabled (ASIDs 1 - 509)
[    3.721289] kvm_amd: SEV-ES disabled (ASIDs 0 - 0)
[    3.721312] kvm_amd: Virtual VMLOAD VMSAVE supported
[    3.721313] kvm_amd: Virtual GIF supported
[    3.729283] MCE: In-kernel MCE decoding enabled.
[    3.765212] AMD Address Translation Library initialized
[    3.765252] intel_rapl_common: Found RAPL domain package
[    3.765257] intel_rapl_common: Found RAPL domain core
[    3.766513] cfg80211: Loading compiled-in X.509 certificates for =
regulatory database
[    3.768252] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.768356] Loaded X.509 cert 'wens: =
61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    3.768582] platform regulatory.0: Direct firmware load for =
regulatory.db failed with error -2
[    3.768585] cfg80211: failed to load regulatory.db
[    4.564164] EXT4-fs (sda2): mounted filesystem =
b6d62eed-a5ba-4cf0-a2d7-6404683db3e3 r/w with ordered data mode. Quota =
mode: none.
[    4.659302] bridge: filtering via arp/ip/ip6tables is no longer =
available by default. Update your scripts to load br_netfilter if you =
need this.
[    4.696961] Generic FE-GE Realtek PHY r8169-0-500:00: attached PHY =
driver (mii_bus:phy_addr=3Dr8169-0-500:00, irq=3DMAC)
[    4.887113] r8169 0000:05:00.0 enp5s0: Link is Down
[    4.917880] br0: port 1(enp5s0) entered blocking state
[    4.917883] br0: port 1(enp5s0) entered disabled state
[    4.917889] r8169 0000:05:00.0 enp5s0: entered allmulticast mode
[    4.917970] r8169 0000:05:00.0 enp5s0: entered promiscuous mode
[    4.929839] tun: Universal TUN/TAP device driver, 1.6
[    5.965626] br0: port 2(tap0) entered blocking state
[    5.965631] br0: port 2(tap0) entered disabled state
[    5.965641] tap0: entered allmulticast mode
[    5.965683] tap0: entered promiscuous mode
[    5.965710] br0: port 2(tap0) entered blocking state
[    5.965711] br0: port 2(tap0) entered forwarding state
[    5.986178] Bridge firewalling registered
[    6.077746] RPC: Registered rdma transport module.
[    6.077749] RPC: Registered rdma backchannel transport module.
[    6.201067] NFSD: Using nfsdcld client tracking operations.
[    6.201069] NFSD: no clients to reclaim, skipping NFSv4 grace period =
(net f0000000)
[    8.035190] r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full - flow =
control rx/tx
[    8.035240] br0: port 1(enp5s0) entered blocking state
[    8.035244] br0: port 1(enp5s0) entered forwarding state
[   11.275932] netfs: FS-Cache loaded
[   11.313446] Key type dns_resolver registered
[   11.468243] NFS: Registering the id_resolver key type
[   11.468249] Key type id_resolver registered
[   11.468250] Key type id_legacy registered
[  619.427729] nouveau 0000:07:00.0: fifo: CACHE_ERROR - ch 0 =
[(udev-worker)[348]] subc 4 mthd 0000 data 00000039
[  619.427757] nouveau 0000:07:00.0: fifo: CACHE_ERROR - ch 0 =
[(udev-worker)[348]] subc 4 mthd 0180 data 80000006
[  622.607683] PM: suspend entry (deep)
[  622.612781] Filesystems sync: 0.005 seconds
[  622.613128] Freezing user space processes
[  622.614262] Freezing user space processes completed (elapsed 0.001 =
seconds)
[  622.614265] OOM killer disabled.
[  622.614266] Freezing remaining freezable tasks
[  622.615362] Freezing remaining freezable tasks completed (elapsed =
0.001 seconds)
[  622.615391] printk: Suspending console(s) (use no_console_suspend to =
debug)
[  622.618100] serial 00:05: disabled
[  622.618143] r8169 0000:05:00.0 enp5s0: Link is Down
[  622.653931] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  622.654096] ata1.00: Entering standby power mode
[  622.717981] ACPI: PM: Preparing to enter system sleep state S3
[  623.247496] ACPI: PM: Saving platform NVS memory
[  623.247597] Disabling non-boot CPUs ...
[  623.249082] smpboot: CPU 1 is now offline
[  623.250726] smpboot: CPU 2 is now offline
[  623.252344] smpboot: CPU 3 is now offline
[  623.254070] smpboot: CPU 4 is now offline
[  623.255710] smpboot: CPU 5 is now offline
[  623.257304] smpboot: CPU 6 is now offline
[  623.259019] smpboot: CPU 7 is now offline
[  623.260713] smpboot: CPU 8 is now offline
[  623.262291] smpboot: CPU 9 is now offline
[  623.263847] smpboot: CPU 10 is now offline
[  623.265360] smpboot: CPU 11 is now offline
[  623.266966] smpboot: CPU 12 is now offline
[  623.268544] smpboot: CPU 13 is now offline
[  623.270111] smpboot: CPU 14 is now offline
[  623.271657] smpboot: CPU 15 is now offline
[  623.273135] smpboot: CPU 16 is now offline
[  623.274750] smpboot: CPU 17 is now offline
[  623.276257] smpboot: CPU 18 is now offline
[  623.277731] smpboot: CPU 19 is now offline
[  623.279351] smpboot: CPU 20 is now offline
[  623.280835] smpboot: CPU 21 is now offline
[  623.282273] smpboot: CPU 22 is now offline
[  623.283897] smpboot: CPU 23 is now offline
[  623.284335] ACPI: PM: Low-level resume complete
[  623.284354] ACPI: PM: Restoring platform NVS memory
[  623.284413] LVT offset 0 assigned for vector 0x400
[  623.284914] Enabling non-boot CPUs ...
[  623.284961] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  623.287428] ACPI: \_PR_.C002: Found 2 idle states
[  623.287895] CPU1 is up
[  623.287919] smpboot: Booting Node 0 Processor 2 APIC 0x4
[  623.290265] ACPI: \_PR_.C004: Found 2 idle states
[  623.291326] CPU2 is up
[  623.291342] smpboot: Booting Node 0 Processor 3 APIC 0x8
[  623.293803] ACPI: \_PR_.C006: Found 2 idle states
[  623.294532] CPU3 is up
[  623.294549] smpboot: Booting Node 0 Processor 4 APIC 0xa
[  623.296931] ACPI: \_PR_.C008: Found 2 idle states
[  623.297604] CPU4 is up
[  623.297622] smpboot: Booting Node 0 Processor 5 APIC 0xc
[  623.300009] ACPI: \_PR_.C00A: Found 2 idle states
[  623.300825] CPU5 is up
[  623.300842] smpboot: Booting Node 0 Processor 6 APIC 0x10
[  623.303308] ACPI: \_PR_.C00C: Found 2 idle states
[  623.304162] CPU6 is up
[  623.304180] smpboot: Booting Node 0 Processor 7 APIC 0x12
[  623.306577] ACPI: \_PR_.C00E: Found 2 idle states
[  623.307493] CPU7 is up
[  623.307512] smpboot: Booting Node 0 Processor 8 APIC 0x14
[  623.309918] ACPI: \_PR_.C010: Found 2 idle states
[  623.310831] CPU8 is up
[  623.310849] smpboot: Booting Node 0 Processor 9 APIC 0x18
[  623.313337] ACPI: \_PR_.C012: Found 2 idle states
[  623.314177] CPU9 is up
[  623.314196] smpboot: Booting Node 0 Processor 10 APIC 0x1a
[  623.316611] ACPI: \_PR_.C014: Found 2 idle states
[  623.317508] CPU10 is up
[  623.317528] smpboot: Booting Node 0 Processor 11 APIC 0x1c
[  623.319936] ACPI: \_PR_.C016: Found 2 idle states
[  623.320847] CPU11 is up
[  623.320863] smpboot: Booting Node 0 Processor 12 APIC 0x1
[  623.323316] ACPI: \_PR_.C001: Found 2 idle states
[  623.324222] CPU12 is up
[  623.324256] smpboot: Booting Node 0 Processor 13 APIC 0x3
[  623.326660] ACPI: \_PR_.C003: Found 2 idle states
[  623.327530] CPU13 is up
[  623.327549] smpboot: Booting Node 0 Processor 14 APIC 0x5
[  623.329935] ACPI: \_PR_.C005: Found 2 idle states
[  623.330858] CPU14 is up
[  623.330876] smpboot: Booting Node 0 Processor 15 APIC 0x9
[  623.333278] ACPI: \_PR_.C007: Found 2 idle states
[  623.334209] CPU15 is up
[  623.334230] smpboot: Booting Node 0 Processor 16 APIC 0xb
[  623.336655] ACPI: \_PR_.C009: Found 2 idle states
[  623.337538] CPU16 is up
[  623.337556] smpboot: Booting Node 0 Processor 17 APIC 0xd
[  623.339984] ACPI: \_PR_.C00B: Found 2 idle states
[  623.340870] CPU17 is up
[  623.340888] smpboot: Booting Node 0 Processor 18 APIC 0x11
[  623.343311] ACPI: \_PR_.C00D: Found 2 idle states
[  623.344217] CPU18 is up
[  623.344238] smpboot: Booting Node 0 Processor 19 APIC 0x13
[  623.346664] ACPI: \_PR_.C00F: Found 2 idle states
[  623.347547] CPU19 is up
[  623.347567] smpboot: Booting Node 0 Processor 20 APIC 0x15
[  623.349994] ACPI: \_PR_.C011: Found 2 idle states
[  623.350883] CPU20 is up
[  623.350900] smpboot: Booting Node 0 Processor 21 APIC 0x19
[  623.353338] ACPI: \_PR_.C013: Found 2 idle states
[  623.354237] CPU21 is up
[  623.354260] smpboot: Booting Node 0 Processor 22 APIC 0x1b
[  623.356699] ACPI: \_PR_.C015: Found 2 idle states
[  623.357561] CPU22 is up
[  623.357576] smpboot: Booting Node 0 Processor 23 APIC 0x1d
[  623.360011] ACPI: \_PR_.C017: Found 2 idle states
[  623.360897] CPU23 is up
[  623.362651] ACPI: PM: Waking up from system sleep state S3
[  623.364743] xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, =
Reinit
[  623.364746] usb usb1: root hub lost power or was reset
[  623.364747] usb usb2: root hub lost power or was reset
[  623.365217] serial 00:05: activated
[  623.422418] nvme nvme0: D3 entry latency set to 10 seconds
[  623.423896] nvme nvme0: 24/0/0 default/read/poll queues
[  623.564151] r8169 0000:05:00.0 enp5s0: Link is Down
[  623.564446] OOM killer enabled.
[  623.564447] Restarting tasks ... done.
[  623.564748] random: crng reseeded on system resumption
[  623.565010] PM: suspend exit
[  623.630810] br0: port 1(enp5s0) entered disabled state
[  623.680471] ata5: SATA link down (SStatus 0 SControl 330)
[  623.680496] ata6: SATA link down (SStatus 0 SControl 330)
[  623.680521] ata2: SATA link down (SStatus 0 SControl 300)
[  623.834259] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  623.836103] sd 0:0:0:0: [sda] Starting disk
[  623.836969] ata1.00: configured for UDMA/133
[  623.847173] ahci 0000:02:00.1: port does not support device sleep
[  626.666788] r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full - flow =
control rx/tx
[  626.666812] br0: port 1(enp5s0) entered blocking state
[  626.666815] br0: port 1(enp5s0) entered forwarding state
[  628.418137] systemd-journald[483]: =
/var/log/journal/1a15c5c01ee34ffb8beb42df7c18ff94/user-1000.journal: =
Journal file uses a different sequence number ID, rotating.
[ 5156.157003] r8169 0000:05:00.0 enp5s0: Link is Down
[ 5156.157055] br0: port 1(enp5s0) entered disabled state
[ 5171.228350] nfs: server 192.168.1.254 not responding, timed out
[ 5171.384430] r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full - flow =
control rx/tx
[ 5171.384449] br0: port 1(enp5s0) entered blocking state
[ 5171.384453] br0: port 1(enp5s0) entered forwarding state
[ 5171.760464] r8169 0000:05:00.0 enp5s0: Link is Down
[ 5172.399804] br0: port 1(enp5s0) entered disabled state
[ 5173.253100] nfs: server 192.168.1.254 not responding, timed out
[ 5175.003514] r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full - flow =
control rx/tx
[ 5175.003552] br0: port 1(enp5s0) entered blocking state
[ 5175.003558] br0: port 1(enp5s0) entered forwarding state
[ 5175.283114] nfs: server 192.168.1.254 not responding, timed out
[ 5177.306424] nfs: server 192.168.1.254 not responding, timed out
[ 5179.333093] nfs: server 192.168.1.254 not responding, timed out
[ 5181.359766] nfs: server 192.168.1.254 not responding, timed out
[ 5183.386423] nfs: server 192.168.1.254 not responding, timed out
[ 5183.410951] r8169 0000:05:00.0 enp5s0: Link is Down
[ 5183.410995] br0: port 1(enp5s0) entered disabled state
[ 5185.413101] nfs: server 192.168.1.254 not responding, timed out
[ 5186.590549] r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full - flow =
control rx/tx
[ 5186.590566] br0: port 1(enp5s0) entered blocking state
[ 5186.590570] br0: port 1(enp5s0) entered forwarding state
[ 5187.439771] nfs: server 192.168.1.254 not responding, timed out
[ 5189.468715] nfs: server 192.168.1.254 not responding, timed out
[ 5191.496418] nfs: server 192.168.1.254 not responding, timed out
[ 5193.519762] nfs: server 192.168.1.254 not responding, timed out
[ 5195.546419] nfs: server 192.168.1.254 not responding, timed out
[ 5197.576429] nfs: server 192.168.1.254 not responding, timed out
[ 5199.599761] nfs: server 192.168.1.254 not responding, timed out
[ 5201.626429] nfs: server 192.168.1.254 not responding, timed out
[ 5203.174817] r8169 0000:05:00.0 enp5s0: Link is Down
[ 5203.174868] br0: port 1(enp5s0) entered disabled state
[ 5203.653086] nfs: server 192.168.1.254 not responding, timed out
[ 5205.679768] nfs: server 192.168.1.254 not responding, timed out
[ 5206.322990] r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full - flow =
control rx/tx
[ 5206.323024] br0: port 1(enp5s0) entered blocking state
[ 5206.323027] br0: port 1(enp5s0) entered forwarding state
[ 5207.706426] nfs: server 192.168.1.254 not responding, timed out
[ 5209.733086] nfs: server 192.168.1.254 not responding, timed out
[ 5211.759747] nfs: server 192.168.1.254 not responding, timed out
[ 5215.066419] nfs: server 192.168.1.254 not responding, timed out
[ 5218.266424] nfs: server 192.168.1.254 not responding, timed out
[ 5221.469748] nfs: server 192.168.1.254 not responding, timed out
[ 5224.666438] nfs: server 192.168.1.254 not responding, timed out
[ 5227.866414] nfs: server 192.168.1.254 not responding, timed out
[ 5231.069775] nfs: server 192.168.1.254 not responding, timed out
[ 5234.266419] nfs: server 192.168.1.254 not responding, timed out
[ 5237.466416] nfs: server 192.168.1.254 not responding, timed out
[ 5240.666428] nfs: server 192.168.1.254 not responding, timed out
[ 5243.866414] nfs: server 192.168.1.254 not responding, timed out
[ 5247.066413] nfs: server 192.168.1.254 not responding, timed out
[ 5250.269761] nfs: server 192.168.1.254 not responding, timed out
[ 5253.466428] nfs: server 192.168.1.254 not responding, timed out
[ 5256.666411] nfs: server 192.168.1.254 not responding, timed out
[ 5259.866413] nfs: server 192.168.1.254 not responding, timed out
[ 5263.066423] nfs: server 192.168.1.254 not responding, timed out
[ 5266.266415] nfs: server 192.168.1.254 not responding, timed out
[ 5269.466403] nfs: server 192.168.1.254 not responding, timed out
[ 5272.666810] nfs: server 192.168.1.254 not responding, timed out
[ 5275.869734] nfs: server 192.168.1.254 not responding, timed out
[ 5279.066401] nfs: server 192.168.1.254 not responding, timed out
[ 5282.266406] nfs: server 192.168.1.254 not responding, timed out
[ 5285.469740] nfs: server 192.168.1.254 not responding, timed out
[ 5288.669735] nfs: server 192.168.1.254 not responding, timed out
[ 5291.866410] nfs: server 192.168.1.254 not responding, timed out
[ 5295.069727] nfs: server 192.168.1.254 not responding, timed out
[ 5298.266401] nfs: server 192.168.1.254 not responding, timed out
[ 5301.466399] nfs: server 192.168.1.254 not responding, timed out
[ 5304.669731] nfs: server 192.168.1.254 not responding, timed out
[ 5307.866402] nfs: server 192.168.1.254 not responding, timed out
[ 5311.066411] nfs: server 192.168.1.254 not responding, timed out
[ 5314.266398] nfs: server 192.168.1.254 not responding, timed out
[ 5317.466413] nfs: server 192.168.1.254 not responding, timed out
[ 5320.666398] nfs: server 192.168.1.254 not responding, timed out
[ 5323.869759] nfs: server 192.168.1.254 not responding, timed out
[ 5327.066392] nfs: server 192.168.1.254 not responding, timed out
[12205.194840] hrtimer: interrupt took 9891 ns
[75056.352583] PM: suspend entry (deep)
[75056.360356] Filesystems sync: 0.007 seconds
[75056.360576] Freezing user space processes
[75056.361699] Freezing user space processes completed (elapsed 0.001 =
seconds)
[75056.361701] OOM killer disabled.
[75056.361701] Freezing remaining freezable tasks
[75056.362790] Freezing remaining freezable tasks completed (elapsed =
0.001 seconds)
[75056.362806] printk: Suspending console(s) (use no_console_suspend to =
debug)
[75056.365493] serial 00:05: disabled
[75056.365545] r8169 0000:05:00.0 enp5s0: Link is Down
[75056.397790] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[75056.397935] ata1.00: Entering standby power mode
[75056.467281] ACPI: PM: Preparing to enter system sleep state S3
[75056.991314] ACPI: PM: Saving platform NVS memory
[75056.991416] Disabling non-boot CPUs ...
[75056.992892] smpboot: CPU 1 is now offline
[75056.994740] smpboot: CPU 2 is now offline
[75056.996410] smpboot: CPU 3 is now offline
[75056.998198] smpboot: CPU 4 is now offline
[75056.999862] smpboot: CPU 5 is now offline
[75057.001498] smpboot: CPU 6 is now offline
[75057.003243] smpboot: CPU 7 is now offline
[75057.004888] smpboot: CPU 8 is now offline
[75057.006604] smpboot: CPU 9 is now offline
[75057.008250] smpboot: CPU 10 is now offline
[75057.009916] smpboot: CPU 11 is now offline
[75057.011616] smpboot: CPU 12 is now offline
[75057.013213] smpboot: CPU 13 is now offline
[75057.014746] smpboot: CPU 14 is now offline
[75057.016319] smpboot: CPU 15 is now offline
[75057.017912] smpboot: CPU 16 is now offline
[75057.019635] smpboot: CPU 17 is now offline
[75057.021170] smpboot: CPU 18 is now offline
[75057.022666] smpboot: CPU 19 is now offline
[75057.024356] smpboot: CPU 20 is now offline
[75057.025938] smpboot: CPU 21 is now offline
[75057.028006] smpboot: CPU 22 is now offline
[75057.029565] smpboot: CPU 23 is now offline
[75057.030071] ACPI: PM: Low-level resume complete
[75057.030089] ACPI: PM: Restoring platform NVS memory
[75057.030148] LVT offset 0 assigned for vector 0x400
[75057.030650] Enabling non-boot CPUs ...
[75057.030700] smpboot: Booting Node 0 Processor 1 APIC 0x2
[75057.033526] ACPI: \_PR_.C002: Found 2 idle states
[75057.034714] CPU1 is up
[75057.034731] smpboot: Booting Node 0 Processor 2 APIC 0x4
[75057.037094] ACPI: \_PR_.C004: Found 2 idle states
[75057.038026] CPU2 is up
[75057.038041] smpboot: Booting Node 0 Processor 3 APIC 0x8
[75057.040492] ACPI: \_PR_.C006: Found 2 idle states
[75057.041397] CPU3 is up
[75057.041421] smpboot: Booting Node 0 Processor 4 APIC 0xa
[75057.043808] ACPI: \_PR_.C008: Found 2 idle states
[75057.044712] CPU4 is up
[75057.044730] smpboot: Booting Node 0 Processor 5 APIC 0xc
[75057.047125] ACPI: \_PR_.C00A: Found 2 idle states
[75057.048037] CPU5 is up
[75057.048060] smpboot: Booting Node 0 Processor 6 APIC 0x10
[75057.050536] ACPI: \_PR_.C00C: Found 2 idle states
[75057.051388] CPU6 is up
[75057.051407] smpboot: Booting Node 0 Processor 7 APIC 0x12
[75057.053811] ACPI: \_PR_.C00E: Found 2 idle states
[75057.054717] CPU7 is up
[75057.054734] smpboot: Booting Node 0 Processor 8 APIC 0x14
[75057.057150] ACPI: \_PR_.C010: Found 2 idle states
[75057.058059] CPU8 is up
[75057.058077] smpboot: Booting Node 0 Processor 9 APIC 0x18
[75057.060560] ACPI: \_PR_.C012: Found 2 idle states
[75057.061401] CPU9 is up
[75057.061418] smpboot: Booting Node 0 Processor 10 APIC 0x1a
[75057.063827] ACPI: \_PR_.C014: Found 2 idle states
[75057.064731] CPU10 is up
[75057.064750] smpboot: Booting Node 0 Processor 11 APIC 0x1c
[75057.067166] ACPI: \_PR_.C016: Found 2 idle states
[75057.068071] CPU11 is up
[75057.068090] smpboot: Booting Node 0 Processor 12 APIC 0x1
[75057.070526] ACPI: \_PR_.C001: Found 2 idle states
[75057.071447] CPU12 is up
[75057.071484] smpboot: Booting Node 0 Processor 13 APIC 0x3
[75057.073879] ACPI: \_PR_.C003: Found 2 idle states
[75057.074754] CPU13 is up
[75057.074772] smpboot: Booting Node 0 Processor 14 APIC 0x5
[75057.077156] ACPI: \_PR_.C005: Found 2 idle states
[75057.078081] CPU14 is up
[75057.078099] smpboot: Booting Node 0 Processor 15 APIC 0x9
[75057.080501] ACPI: \_PR_.C007: Found 2 idle states
[75057.081435] CPU15 is up
[75057.081457] smpboot: Booting Node 0 Processor 16 APIC 0xb
[75057.083875] ACPI: \_PR_.C009: Found 2 idle states
[75057.084764] CPU16 is up
[75057.084780] smpboot: Booting Node 0 Processor 17 APIC 0xd
[75057.087196] ACPI: \_PR_.C00B: Found 2 idle states
[75057.088110] CPU17 is up
[75057.088128] smpboot: Booting Node 0 Processor 18 APIC 0x11
[75057.090536] ACPI: \_PR_.C00D: Found 2 idle states
[75057.091448] CPU18 is up
[75057.091465] smpboot: Booting Node 0 Processor 19 APIC 0x13
[75057.093881] ACPI: \_PR_.C00F: Found 2 idle states
[75057.094779] CPU19 is up
[75057.094796] smpboot: Booting Node 0 Processor 20 APIC 0x15
[75057.097225] ACPI: \_PR_.C011: Found 2 idle states
[75057.098121] CPU20 is up
[75057.098161] smpboot: Booting Node 0 Processor 21 APIC 0x19
[75057.100580] ACPI: \_PR_.C013: Found 2 idle states
[75057.101466] CPU21 is up
[75057.101484] smpboot: Booting Node 0 Processor 22 APIC 0x1b
[75057.103928] ACPI: \_PR_.C015: Found 2 idle states
[75057.104797] CPU22 is up
[75057.104819] smpboot: Booting Node 0 Processor 23 APIC 0x1d
[75057.107262] ACPI: \_PR_.C017: Found 2 idle states
[75057.108145] CPU23 is up
[75057.109940] ACPI: PM: Waking up from system sleep state S3
[75057.112374] xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, =
Reinit
[75057.112379] usb usb1: root hub lost power or was reset
[75057.112380] usb usb2: root hub lost power or was reset
[75057.112874] serial 00:05: activated
[75057.170027] nvme nvme0: D3 entry latency set to 10 seconds
[75057.171504] nvme nvme0: 24/0/0 default/read/poll queues
[75057.281384] r8169 0000:05:00.0 enp5s0: Link is Down
[75057.284773] OOM killer enabled.
[75057.284774] Restarting tasks ... done.
[75057.285005] random: crng reseeded on system resumption
[75057.285023] PM: suspend exit
[75057.398045] br0: port 1(enp5s0) entered disabled state
[75057.424388] ata5: SATA link down (SStatus 0 SControl 330)
[75057.424414] ata6: SATA link down (SStatus 0 SControl 330)
[75057.424439] ata2: SATA link down (SStatus 0 SControl 300)
[75057.581459] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[75057.583307] sd 0:0:0:0: [sda] Starting disk
[75057.584229] ata1.00: configured for UDMA/133
[75057.594442] ahci 0000:02:00.1: port does not support device sleep
[75060.372242] r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full - flow =
control rx/tx
[75060.372266] br0: port 1(enp5s0) entered blocking state
[75060.372269] br0: port 1(enp5s0) entered forwarding state
[75860.665039] PM: suspend entry (deep)
[75860.683829] Filesystems sync: 0.018 seconds
[75860.684080] Freezing user space processes
[75860.685216] Freezing user space processes completed (elapsed 0.001 =
seconds)
[75860.685218] OOM killer disabled.
[75860.685218] Freezing remaining freezable tasks
[75860.686305] Freezing remaining freezable tasks completed (elapsed =
0.001 seconds)
[75860.686325] printk: Suspending console(s) (use no_console_suspend to =
debug)
[75860.688973] serial 00:05: disabled
[75860.689113] r8169 0000:05:00.0 enp5s0: Link is Down
[75860.711191] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[75860.711309] ata1.00: Entering standby power mode
[75860.775098] ACPI: PM: Preparing to enter system sleep state S3
[75861.311474] ACPI: PM: Saving platform NVS memory
[75861.311568] Disabling non-boot CPUs ...
[75861.313034] smpboot: CPU 1 is now offline
[75861.314741] smpboot: CPU 2 is now offline
[75861.316431] smpboot: CPU 3 is now offline
[75861.318020] smpboot: CPU 4 is now offline
[75861.319647] smpboot: CPU 5 is now offline
[75861.321225] smpboot: CPU 6 is now offline
[75861.322861] smpboot: CPU 7 is now offline
[75861.324575] smpboot: CPU 8 is now offline
[75861.326157] smpboot: CPU 9 is now offline
[75861.327669] smpboot: CPU 10 is now offline
[75861.329244] smpboot: CPU 11 is now offline
[75861.330891] smpboot: CPU 12 is now offline
[75861.332412] smpboot: CPU 13 is now offline
[75861.333886] smpboot: CPU 14 is now offline
[75861.335405] smpboot: CPU 15 is now offline
[75861.336907] smpboot: CPU 16 is now offline
[75861.338481] smpboot: CPU 17 is now offline
[75861.339952] smpboot: CPU 18 is now offline
[75861.341446] smpboot: CPU 19 is now offline
[75861.343097] smpboot: CPU 20 is now offline
[75861.344578] smpboot: CPU 21 is now offline
[75861.346499] smpboot: CPU 22 is now offline
[75861.348026] smpboot: CPU 23 is now offline
[75861.348456] ACPI: PM: Low-level resume complete
[75861.348475] ACPI: PM: Restoring platform NVS memory
[75861.348534] LVT offset 0 assigned for vector 0x400
[75861.349037] Enabling non-boot CPUs ...
[75861.349087] smpboot: Booting Node 0 Processor 1 APIC 0x2
[75861.351551] ACPI: \_PR_.C002: Found 2 idle states
[75861.352276] CPU1 is up
[75861.352291] smpboot: Booting Node 0 Processor 2 APIC 0x4
[75861.354667] ACPI: \_PR_.C004: Found 2 idle states
[75861.355335] CPU2 is up
[75861.355351] smpboot: Booting Node 0 Processor 3 APIC 0x8
[75861.357813] ACPI: \_PR_.C006: Found 2 idle states
[75861.358510] CPU3 is up
[75861.358527] smpboot: Booting Node 0 Processor 4 APIC 0xa
[75861.360917] ACPI: \_PR_.C008: Found 2 idle states
[75861.361813] CPU4 is up
[75861.361832] smpboot: Booting Node 0 Processor 5 APIC 0xc
[75861.364234] ACPI: \_PR_.C00A: Found 2 idle states
[75861.365154] CPU5 is up
[75861.365172] smpboot: Booting Node 0 Processor 6 APIC 0x10
[75861.367652] ACPI: \_PR_.C00C: Found 2 idle states
[75861.368500] CPU6 is up
[75861.368517] smpboot: Booting Node 0 Processor 7 APIC 0x12
[75861.370927] ACPI: \_PR_.C00E: Found 2 idle states
[75861.371830] CPU7 is up
[75861.371848] smpboot: Booting Node 0 Processor 8 APIC 0x14
[75861.374262] ACPI: \_PR_.C010: Found 2 idle states
[75861.375169] CPU8 is up
[75861.375186] smpboot: Booting Node 0 Processor 9 APIC 0x18
[75861.377671] ACPI: \_PR_.C012: Found 2 idle states
[75861.378512] CPU9 is up
[75861.378528] smpboot: Booting Node 0 Processor 10 APIC 0x1a
[75861.380949] ACPI: \_PR_.C014: Found 2 idle states
[75861.381842] CPU10 is up
[75861.381858] smpboot: Booting Node 0 Processor 11 APIC 0x1c
[75861.384278] ACPI: \_PR_.C016: Found 2 idle states
[75861.385180] CPU11 is up
[75861.385200] smpboot: Booting Node 0 Processor 12 APIC 0x1
[75861.387643] ACPI: \_PR_.C001: Found 2 idle states
[75861.388560] CPU12 is up
[75861.388602] smpboot: Booting Node 0 Processor 13 APIC 0x3
[75861.391005] ACPI: \_PR_.C003: Found 2 idle states
[75861.391863] CPU13 is up
[75861.391880] smpboot: Booting Node 0 Processor 14 APIC 0x5
[75861.394265] ACPI: \_PR_.C005: Found 2 idle states
[75861.395193] CPU14 is up
[75861.395209] smpboot: Booting Node 0 Processor 15 APIC 0x9
[75861.397613] ACPI: \_PR_.C007: Found 2 idle states
[75861.398544] CPU15 is up
[75861.398563] smpboot: Booting Node 0 Processor 16 APIC 0xb
[75861.400975] ACPI: \_PR_.C009: Found 2 idle states
[75861.401874] CPU16 is up
[75861.401915] smpboot: Booting Node 0 Processor 17 APIC 0xd
[75861.404341] ACPI: \_PR_.C00B: Found 2 idle states
[75861.405223] CPU17 is up
[75861.405248] smpboot: Booting Node 0 Processor 18 APIC 0x11
[75861.407671] ACPI: \_PR_.C00D: Found 2 idle states
[75861.408572] CPU18 is up
[75861.408594] smpboot: Booting Node 0 Processor 19 APIC 0x13
[75861.411029] ACPI: \_PR_.C00F: Found 2 idle states
[75861.411898] CPU19 is up
[75861.411922] smpboot: Booting Node 0 Processor 20 APIC 0x15
[75861.414359] ACPI: \_PR_.C011: Found 2 idle states
[75861.415241] CPU20 is up
[75861.415264] smpboot: Booting Node 0 Processor 21 APIC 0x19
[75861.417703] ACPI: \_PR_.C013: Found 2 idle states
[75861.418595] CPU21 is up
[75861.418617] smpboot: Booting Node 0 Processor 22 APIC 0x1b
[75861.421070] ACPI: \_PR_.C015: Found 2 idle states
[75861.421911] CPU22 is up
[75861.421935] smpboot: Booting Node 0 Processor 23 APIC 0x1d
[75861.424382] ACPI: \_PR_.C017: Found 2 idle states
[75861.425257] CPU23 is up
[75861.427033] ACPI: PM: Waking up from system sleep state S3
[75861.429340] xhci_hcd 0000:02:00.0: xHC error in resume, USBSTS 0x401, =
Reinit
[75861.429344] usb usb1: root hub lost power or was reset
[75861.429345] usb usb2: root hub lost power or was reset
[75861.429734] serial 00:05: activated
[75861.486937] nvme nvme0: D3 entry latency set to 10 seconds
[75861.488395] nvme nvme0: 24/0/0 default/read/poll queues
[75861.621838] r8169 0000:05:00.0 enp5s0: Link is Down
[75861.622169] OOM killer enabled.
[75861.622171] Restarting tasks ... done.
[75861.622401] random: crng reseeded on system resumption
[75861.622421] PM: suspend exit
[75861.718489] br0: port 1(enp5s0) entered disabled state
[75861.741232] ata5: SATA link down (SStatus 0 SControl 330)
[75861.741258] ata6: SATA link down (SStatus 0 SControl 330)
[75861.741490] ata2: SATA link down (SStatus 0 SControl 300)
[75861.898589] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[75861.900341] sd 0:0:0:0: [sda] Starting disk
[75861.901250] ata1.00: configured for UDMA/133
[75861.911447] ahci 0000:02:00.1: port does not support device sleep
[75864.693199] r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full - flow =
control rx/tx
[75864.693223] br0: port 1(enp5s0) entered blocking state
[75864.693226] br0: port 1(enp5s0) entered forwarding state
[86041.349844] ------------[ cut here ]------------
[86041.349850] kernel BUG at mm/zswap.c:1005!
[86041.349862] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[86041.349867] CPU: 5 PID: 2798071 Comm: llvm-tblgen Not tainted =
6.10.6-12 #1 349ceb515693b41153483eac7819a5fb2832d2bf
[86041.349872] Hardware name: To Be Filled By O.E.M. B450M Pro4-F =
R2.0/B450M Pro4-F R2.0, BIOS P10.08 01/19/2024
[86041.349876] RIP: 0010:zswap_decompress+0x1ef/0x200
[86041.349884] Code: ef e8 95 2a ce ff 84 c0 0f 85 1f ff ff ff e9 fb fe =
ff ff 0f 0b 48 8d 7b 10 e8 0d a9 a4 00 c7 43 10 00 00 00 00 8b 43 30 eb =
86 <0f> 0b 0f 0b e8 f8 9b a3 00 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[86041.349889] RSP: 0000:ffffb98f823ebb90 EFLAGS: 00010282
[86041.349892] RAX: 00000000ffffffea RBX: ffff9bf22e8c1e08 RCX: =
ffff9bef137774ba
[86041.349894] RDX: 0000000000000002 RSI: 0000000000000438 RDI: =
ffff9bf22e8b2af0
[86041.349897] RBP: ffff9bef58cd2b98 R08: ffff9bee8baf07e0 R09: =
ffff9bef13777080
[86041.349899] R10: 0000000000000022 R11: ffff9bee8baf1000 R12: =
fffff782422ebc00
[86041.349902] R13: ffff9bef13777080 R14: ffff9bef01e3d6e0 R15: =
ffff9bf22e8c1e48
[86041.349904] FS:  00007f4bda31d280(0000) GS:ffff9bf22e880000(0000) =
knlGS:0000000000000000
[86041.349908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[86041.349910] CR2: 000000001665d010 CR3: 0000000191a2c000 CR4: =
0000000000350ef0
[86041.349914] Call Trace:
[86041.349918]  <TASK>
[86041.349920]  ? die+0x36/0x90
[86041.349925]  ? do_trap+0xdd/0x100
[86041.349929]  ? zswap_decompress+0x1ef/0x200
[86041.349932]  ? do_error_trap+0x6a/0x90
[86041.349935]  ? zswap_decompress+0x1ef/0x200
[86041.349938]  ? exc_invalid_op+0x50/0x70
[86041.349943]  ? zswap_decompress+0x1ef/0x200
[86041.349946]  ? asm_exc_invalid_op+0x1a/0x20
[86041.349951]  ? zswap_decompress+0x1ef/0x200
[86041.349955]  zswap_load+0x109/0x120
[86041.349958]  swap_read_folio+0x64/0x450
[86041.349963]  swapin_readahead+0x463/0x4e0
[86041.349967]  do_swap_page+0x436/0xd70
[86041.349972]  ? __pte_offset_map+0x1b/0x180
[86041.349976]  __handle_mm_fault+0x85d/0x1070
[86041.349979]  ? sched_tick+0xee/0x2f0
[86041.349985]  handle_mm_fault+0x18d/0x320
[86041.349988]  do_user_addr_fault+0x177/0x6a0
[86041.349993]  exc_page_fault+0x7e/0x180
[86041.349996]  asm_exc_page_fault+0x26/0x30
[86041.350000] RIP: 0033:0x7453b9
[86041.350019] Code: 00 48 8d 0c 49 4c 8d 04 ca 48 8b 0f 4c 39 c2 75 19 =
e9 7f 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 48 83 c2 18 49 39 d0 74 =
6b <48> 39 0a 75 f2 48 89 84 24 90 00 00 00 4c 39 73 10 0f 84 2f 02 00
[86041.350024] RSP: 002b:00007ffe67b93c80 EFLAGS: 00010206
[86041.350027] RAX: 0000000016659250 RBX: 00007ffe67b93db0 RCX: =
000000000f1aad40
[86041.350030] RDX: 000000001665d010 RSI: 00007ffe67b93cd8 RDI: =
00007ffe67b93cd0
[86041.350032] RBP: 0000000000000001 R08: 000000001665d088 R09: =
0000000000000000
[86041.350035] R10: 00007f4bda030610 R11: 00007f4bda0d6200 R12: =
0000000016661210
[86041.350038] R13: 00007ffe67b94a58 R14: 000000000ba280a8 R15: =
0000000000000006
[86041.350041]  </TASK>
[86041.350043] Modules linked in: tls rpcsec_gss_krb5 nfsv4 dns_resolver =
nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core br_netfilter =
iptable_filter xt_physdev tun bridge stp llc ext4 crc16 mbcache jbd2 =
amd_atl intel_rapl_msr intel_rapl_common cfg80211 edac_mce_amd kvm_amd =
rfkill kvm crct10dif_pclmul crc32_pclmul polyval_clmulni r8169 =
polyval_generic gf128mul ghash_clmulni_intel sha512_ssse3 realtek =
sha256_ssse3 sha1_ssse3 aesni_intel mdio_devres crypto_simd sp5100_tco =
k10temp gpio_amdpt cryptd wmi_bmof pcspkr ccp libphy i2c_piix4 =
acpi_cpufreq rapl zenpower ryzen_smu gpio_generic mac_hid nfsd =
auth_rpcgss nfs_acl lockd grace nct6775 nct6775_core hwmon_vid sg sunrpc =
crypto_user fuse dm_mod loop nfnetlink bpf_preload ip_tables x_tables =
xfs libcrc32c crc32c_generic drm_ttm_helper ttm video gpu_sched =
i2c_algo_bit drm_gpuvm drm_exec mxm_wmi nvme crc32c_intel =
drm_display_helper xhci_pci nvme_core xhci_pci_renesas wmi virtio_net =
net_failover failover dimlib virtio_blk virtio_pci virtio_pci_legacy_dev =
virtio_pci_modern_dev
[86041.350106]  [last unloaded: nouveau]
[86041.350125] ---[ end trace 0000000000000000 ]---
[86041.350128] RIP: 0010:zswap_decompress+0x1ef/0x200
[86041.350131] Code: ef e8 95 2a ce ff 84 c0 0f 85 1f ff ff ff e9 fb fe =
ff ff 0f 0b 48 8d 7b 10 e8 0d a9 a4 00 c7 43 10 00 00 00 00 8b 43 30 eb =
86 <0f> 0b 0f 0b e8 f8 9b a3 00 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[86041.350137] RSP: 0000:ffffb98f823ebb90 EFLAGS: 00010282
[86041.350139] RAX: 00000000ffffffea RBX: ffff9bf22e8c1e08 RCX: =
ffff9bef137774ba
[86041.350142] RDX: 0000000000000002 RSI: 0000000000000438 RDI: =
ffff9bf22e8b2af0
[86041.350145] RBP: ffff9bef58cd2b98 R08: ffff9bee8baf07e0 R09: =
ffff9bef13777080
[86041.350147] R10: 0000000000000022 R11: ffff9bee8baf1000 R12: =
fffff782422ebc00
[86041.350150] R13: ffff9bef13777080 R14: ffff9bef01e3d6e0 R15: =
ffff9bf22e8c1e48
[86041.350152] FS:  00007f4bda31d280(0000) GS:ffff9bf22e880000(0000) =
knlGS:0000000000000000
[86041.350156] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[86041.350158] CR2: 000000001665d010 CR3: 0000000191a2c000 CR4: =
0000000000350ef0
[86041.350162] ------------[ cut here ]------------
[86041.350164] WARNING: CPU: 5 PID: 2798071 at kernel/exit.c:825 =
do_exit+0x88b/0xac0
[86041.350170] Modules linked in: tls rpcsec_gss_krb5 nfsv4 dns_resolver =
nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core br_netfilter =
iptable_filter xt_physdev tun bridge stp llc ext4 crc16 mbcache jbd2 =
amd_atl intel_rapl_msr intel_rapl_common cfg80211 edac_mce_amd kvm_amd =
rfkill kvm crct10dif_pclmul crc32_pclmul polyval_clmulni r8169 =
polyval_generic gf128mul ghash_clmulni_intel sha512_ssse3 realtek =
sha256_ssse3 sha1_ssse3 aesni_intel mdio_devres crypto_simd sp5100_tco =
k10temp gpio_amdpt cryptd wmi_bmof pcspkr ccp libphy i2c_piix4 =
acpi_cpufreq rapl zenpower ryzen_smu gpio_generic mac_hid nfsd =
auth_rpcgss nfs_acl lockd grace nct6775 nct6775_core hwmon_vid sg sunrpc =
crypto_user fuse dm_mod loop nfnetlink bpf_preload ip_tables x_tables =
xfs libcrc32c crc32c_generic drm_ttm_helper ttm video gpu_sched =
i2c_algo_bit drm_gpuvm drm_exec mxm_wmi nvme crc32c_intel =
drm_display_helper xhci_pci nvme_core xhci_pci_renesas wmi virtio_net =
net_failover failover dimlib virtio_blk virtio_pci virtio_pci_legacy_dev =
virtio_pci_modern_dev
[86041.350211]  [last unloaded: nouveau]
[86041.350231] CPU: 5 PID: 2798071 Comm: llvm-tblgen Tainted: G      D   =
         6.10.6-12 #1 349ceb515693b41153483eac7819a5fb2832d2bf
[86041.350236] Hardware name: To Be Filled By O.E.M. B450M Pro4-F =
R2.0/B450M Pro4-F R2.0, BIOS P10.08 01/19/2024
[86041.350239] RIP: 0010:do_exit+0x88b/0xac0
[86041.350242] Code: 89 a3 48 06 00 00 48 89 6c 24 10 48 8b 83 68 08 00 =
00 e9 ff fd ff ff 48 8b bb 28 06 00 00 31 f6 e8 da e1 ff ff e9 a1 fd ff =
ff <0f> 0b e9 eb f7 ff ff 4c 89 e6 bf 05 06 00 00 e8 c1 2b 01 00 e9 66
[86041.350248] RSP: 0000:ffffb98f823ebed8 EFLAGS: 00010282
[86041.350250] RAX: 0000000400000000 RBX: ffff9bf042adc100 RCX: =
0000000000000000
[86041.350252] RDX: 0000000000000001 RSI: 0000000000002710 RDI: =
ffff9bef09907380
[86041.350255] RBP: ffff9bef81c55580 R08: 0000000000000000 R09: =
0000000000000003
[86041.350258] R10: ffffb98f823eb850 R11: ffff9bf23f2ad7a8 R12: =
000000000000000b
[86041.350261] R13: ffff9bef09907380 R14: ffffffffa65fa463 R15: =
ffffb98f823ebae8
[86041.350263] FS:  00007f4bda31d280(0000) GS:ffff9bf22e880000(0000) =
knlGS:0000000000000000
[86041.350267] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[86041.350269] CR2: 000000001665d010 CR3: 0000000191a2c000 CR4: =
0000000000350ef0
[86041.350272] Call Trace:
[86041.350274]  <TASK>
[86041.350276]  ? __warn+0x80/0x120
[86041.350280]  ? do_exit+0x88b/0xac0
[86041.350283]  ? report_bug+0x164/0x190
[86041.350288]  ? handle_bug+0x3c/0x80
[86041.350291]  ? exc_invalid_op+0x17/0x70
[86041.350294]  ? asm_exc_invalid_op+0x1a/0x20
[86041.350297]  ? do_exit+0x88b/0xac0
[86041.350300]  ? do_exit+0x6f/0xac0
[86041.350303]  ? do_user_addr_fault+0x177/0x6a0
[86041.350307]  make_task_dead+0x81/0x170
[86041.350310]  rewind_stack_and_make_dead+0x16/0x20
[86041.350314] RIP: 0033:0x7453b9
[86041.350319] Code: 00 48 8d 0c 49 4c 8d 04 ca 48 8b 0f 4c 39 c2 75 19 =
e9 7f 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 48 83 c2 18 49 39 d0 74 =
6b <48> 39 0a 75 f2 48 89 84 24 90 00 00 00 4c 39 73 10 0f 84 2f 02 00
[86041.350324] RSP: 002b:00007ffe67b93c80 EFLAGS: 00010206
[86041.350327] RAX: 0000000016659250 RBX: 00007ffe67b93db0 RCX: =
000000000f1aad40
[86041.350330] RDX: 000000001665d010 RSI: 00007ffe67b93cd8 RDI: =
00007ffe67b93cd0
[86041.350332] RBP: 0000000000000001 R08: 000000001665d088 R09: =
0000000000000000
[86041.350335] R10: 00007f4bda030610 R11: 00007f4bda0d6200 R12: =
0000000016661210
[86041.350337] R13: 00007ffe67b94a58 R14: 000000000ba280a8 R15: =
0000000000000006
[86041.350341]  </TASK>
[86041.350342] ---[ end trace 0000000000000000 ]---
[86041.579617] BUG: kernel NULL pointer dereference, address: =
0000000000000008
[86041.579627] #PF: supervisor write access in kernel mode
[86041.579630] #PF: error_code(0x0002) - not-present page
[86041.579632] PGD 0 P4D 0
[86041.579636] Oops: Oops: 0002 [#2] PREEMPT SMP NOPTI
[86041.579640] CPU: 5 PID: 2798071 Comm: llvm-tblgen Tainted: G      D W =
         6.10.6-12 #1 349ceb515693b41153483eac7819a5fb2832d2bf
[86041.579645] Hardware name: To Be Filled By O.E.M. B450M Pro4-F =
R2.0/B450M Pro4-F R2.0, BIOS P10.08 01/19/2024
[86041.579649] RIP: 0010:__blk_flush_plug+0x89/0x150
[86041.579655] Code: de 48 89 5c 24 08 48 89 5c 24 10 48 39 c1 74 7c 49 =
8b 46 20 48 8b 34 24 48 39 c6 74 5b 49 8b 4e 20 49 8b 56 28 48 8b 44 24 =
08 <48> 89 59 08 48 89 4c 24 08 48 89 02 48 89 50 08 49 89 76 20 49 89
[86041.579660] RSP: 0018:ffffb98f823ebc30 EFLAGS: 00010286
[86041.579662] RAX: ffffb98f823ebc38 RBX: ffffb98f823ebc38 RCX: =
0000000000000000
[86041.579665] RDX: 0000000101887e59 RSI: ffffb98f823ebce8 RDI: =
ffffb98f823ebcc8
[86041.579667] RBP: 0000000000000001 R08: ffff9bef14e7c248 R09: =
0000000000000050
[86041.579669] R10: 0000000000400023 R11: 0000000000000001 R12: =
dead000000000122
[86041.579672] R13: dead000000000100 R14: ffffb98f823ebcc8 R15: =
0000000000000000
[86041.579674] FS:  0000000000000000(0000) GS:ffff9bf22e880000(0000) =
knlGS:0000000000000000
[86041.579677] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[86041.579679] CR2: 0000000000000008 CR3: 0000000103bfe000 CR4: =
0000000000350ef0
[86041.579682] Call Trace:
[86041.579685]  <TASK>
[86041.579689]  ? __die+0x23/0x70
[86041.579694]  ? page_fault_oops+0x173/0x5a0
[86041.579698]  ? exc_page_fault+0x7e/0x180
[86041.579702]  ? asm_exc_page_fault+0x26/0x30
[86041.579706]  ? __blk_flush_plug+0x89/0x150
[86041.579709]  schedule+0x99/0xf0
[86041.579714]  schedule_preempt_disabled+0x15/0x30
[86041.579716]  rwsem_down_write_slowpath+0x1eb/0x640
[86041.579720]  down_write+0x5a/0x60
[86041.579723]  free_pgtables+0xc6/0x1e0
[86041.579728]  exit_mmap+0x16b/0x3a0
[86041.579733]  __mmput+0x3e/0x130
[86041.579736]  do_exit+0x2ac/0xac0
[86041.579741]  ? do_user_addr_fault+0x177/0x6a0
[86041.579743]  make_task_dead+0x81/0x170
[86041.579746]  rewind_stack_and_make_dead+0x16/0x20
[86041.579750] RIP: 0033:0x7453b9
[86041.579768] Code: Unable to access opcode bytes at 0x74538f.
[86041.579770] RSP: 002b:00007ffe67b93c80 EFLAGS: 00010206
[86041.579772] RAX: 0000000016659250 RBX: 00007ffe67b93db0 RCX: =
000000000f1aad40
[86041.579774] RDX: 000000001665d010 RSI: 00007ffe67b93cd8 RDI: =
00007ffe67b93cd0
[86041.579776] RBP: 0000000000000001 R08: 000000001665d088 R09: =
0000000000000000
[86041.579778] R10: 00007f4bda030610 R11: 00007f4bda0d6200 R12: =
0000000016661210
[86041.579781] R13: 00007ffe67b94a58 R14: 000000000ba280a8 R15: =
0000000000000006
[86041.579784]  </TASK>
[86041.579785] Modules linked in: tls rpcsec_gss_krb5 nfsv4 dns_resolver =
nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core br_netfilter =
iptable_filter xt_physdev tun bridge stp llc ext4 crc16 mbcache jbd2 =
amd_atl intel_rapl_msr intel_rapl_common cfg80211 edac_mce_amd kvm_amd =
rfkill kvm crct10dif_pclmul crc32_pclmul polyval_clmulni r8169 =
polyval_generic gf128mul ghash_clmulni_intel sha512_ssse3 realtek =
sha256_ssse3 sha1_ssse3 aesni_intel mdio_devres crypto_simd sp5100_tco =
k10temp gpio_amdpt cryptd wmi_bmof pcspkr ccp libphy i2c_piix4 =
acpi_cpufreq rapl zenpower ryzen_smu gpio_generic mac_hid nfsd =
auth_rpcgss nfs_acl lockd grace nct6775 nct6775_core hwmon_vid sg sunrpc =
crypto_user fuse dm_mod loop nfnetlink bpf_preload ip_tables x_tables =
xfs libcrc32c crc32c_generic drm_ttm_helper ttm video gpu_sched =
i2c_algo_bit drm_gpuvm drm_exec mxm_wmi nvme crc32c_intel =
drm_display_helper xhci_pci nvme_core xhci_pci_renesas wmi virtio_net =
net_failover failover dimlib virtio_blk virtio_pci virtio_pci_legacy_dev =
virtio_pci_modern_dev
[86041.579842]  [last unloaded: nouveau]
[86041.579858] CR2: 0000000000000008
[86041.579861] ---[ end trace 0000000000000000 ]---
[86041.579863] RIP: 0010:zswap_decompress+0x1ef/0x200
[86041.579867] Code: ef e8 95 2a ce ff 84 c0 0f 85 1f ff ff ff e9 fb fe =
ff ff 0f 0b 48 8d 7b 10 e8 0d a9 a4 00 c7 43 10 00 00 00 00 8b 43 30 eb =
86 <0f> 0b 0f 0b e8 f8 9b a3 00 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[86041.579872] RSP: 0000:ffffb98f823ebb90 EFLAGS: 00010282
[86041.579875] RAX: 00000000ffffffea RBX: ffff9bf22e8c1e08 RCX: =
ffff9bef137774ba
[86041.579877] RDX: 0000000000000002 RSI: 0000000000000438 RDI: =
ffff9bf22e8b2af0
[86041.579880] RBP: ffff9bef58cd2b98 R08: ffff9bee8baf07e0 R09: =
ffff9bef13777080
[86041.579882] R10: 0000000000000022 R11: ffff9bee8baf1000 R12: =
fffff782422ebc00
[86041.579884] R13: ffff9bef13777080 R14: ffff9bef01e3d6e0 R15: =
ffff9bf22e8c1e48
[86041.579886] FS:  0000000000000000(0000) GS:ffff9bf22e880000(0000) =
knlGS:0000000000000000
[86041.579889] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[86041.579891] CR2: 0000000000000008 CR3: 0000000103bfe000 CR4: =
0000000000350ef0
[86041.579893] note: llvm-tblgen[2798071] exited with irqs disabled
[86041.579895] Fixing recursive fault but reboot is needed!
[86041.579897] BUG: scheduling while atomic: =
llvm-tblgen/2798071/0x00000000
[86041.579899] Modules linked in: tls rpcsec_gss_krb5 nfsv4 dns_resolver =
nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core br_netfilter =
iptable_filter xt_physdev tun bridge stp llc ext4 crc16 mbcache jbd2 =
amd_atl intel_rapl_msr intel_rapl_common cfg80211 edac_mce_amd kvm_amd =
rfkill kvm crct10dif_pclmul crc32_pclmul polyval_clmulni r8169 =
polyval_generic gf128mul ghash_clmulni_intel sha512_ssse3 realtek =
sha256_ssse3 sha1_ssse3 aesni_intel mdio_devres crypto_simd sp5100_tco =
k10temp gpio_amdpt cryptd wmi_bmof pcspkr ccp libphy i2c_piix4 =
acpi_cpufreq rapl zenpower ryzen_smu gpio_generic mac_hid nfsd =
auth_rpcgss nfs_acl lockd grace nct6775 nct6775_core hwmon_vid sg sunrpc =
crypto_user fuse dm_mod loop nfnetlink bpf_preload ip_tables x_tables =
xfs libcrc32c crc32c_generic drm_ttm_helper ttm video gpu_sched =
i2c_algo_bit drm_gpuvm drm_exec mxm_wmi nvme crc32c_intel =
drm_display_helper xhci_pci nvme_core xhci_pci_renesas wmi virtio_net =
net_failover failover dimlib virtio_blk virtio_pci virtio_pci_legacy_dev =
virtio_pci_modern_dev
[86041.579933]  [last unloaded: nouveau]
[86041.579950] CPU: 5 PID: 2798071 Comm: llvm-tblgen Tainted: G      D W =
         6.10.6-12 #1 349ceb515693b41153483eac7819a5fb2832d2bf
[86041.579954] Hardware name: To Be Filled By O.E.M. B450M Pro4-F =
R2.0/B450M Pro4-F R2.0, BIOS P10.08 01/19/2024
[86041.579957] Call Trace:
[86041.579959]  <TASK>
[86041.579960]  dump_stack_lvl+0x64/0x80
[86041.579965]  __schedule_bug+0x56/0x70
[86041.579970]  __schedule+0x10d1/0x1520
[86041.579973]  ? __wake_up_klogd.part.0+0x3c/0x60
[86041.579978]  ? vprintk_emit+0x176/0x2a0
[86041.579981]  ? _printk+0x64/0x80
[86041.579984]  do_task_dead+0x42/0x50
[86041.579988]  make_task_dead+0x149/0x170
[86041.579991]  rewind_stack_and_make_dead+0x16/0x20
[86041.579994] RIP: 0033:0x7453b9
[86041.579997] Code: Unable to access opcode bytes at 0x74538f.
[86041.579999] RSP: 002b:00007ffe67b93c80 EFLAGS: 00010206
[86041.580002] RAX: 0000000016659250 RBX: 00007ffe67b93db0 RCX: =
000000000f1aad40
[86041.580004] RDX: 000000001665d010 RSI: 00007ffe67b93cd8 RDI: =
00007ffe67b93cd0
[86041.580006] RBP: 0000000000000001 R08: 000000001665d088 R09: =
0000000000000000
[86041.580008] R10: 00007f4bda030610 R11: 00007f4bda0d6200 R12: =
0000000016661210
[86041.580011] R13: 00007ffe67b94a58 R14: 000000000ba280a8 R15: =
0000000000000006
[86041.580014]  </TASK>
[86260.530317] systemd[1]: systemd-journald.service: State =
'stop-watchdog' timed out. Killing.
[86260.530377] systemd[1]: systemd-journald.service: Killing process 483 =
(systemd-journal) with signal SIGKILL.
[86350.780590] systemd[1]: systemd-journald.service: Processes still =
around after SIGKILL. Ignoring.
[86441.030515] systemd[1]: systemd-journald.service: State =
'final-sigterm' timed out. Killing.
[86441.030574] systemd[1]: systemd-journald.service: Killing process 483 =
(systemd-journal) with signal SIGKILL.
[86531.280569] systemd[1]: systemd-journald.service: Processes still =
around after final SIGKILL. Entering failed mode.
[86531.280585] systemd[1]: systemd-journald.service: Failed with result =
'watchdog'.
[86531.280685] systemd[1]: systemd-journald.service: Unit process 483 =
(systemd-journal) remains running after unit stopped.
[86531.289108] systemd[1]: systemd-journald.service: Scheduled restart =
job, restart counter is at 1.
[86531.289280] systemd[1]: systemd-journald.service: Found left-over =
process 483 (systemd-journal) in control group while starting unit. =
Ignoring.
[86531.289285] systemd[1]: systemd-journald.service: This usually =
indicates unclean termination of a previous run, or service =
implementation deficiencies.
[86531.323344] systemd[1]: Starting Journal Service...
[86531.330820] systemd-journald[2799374]: Collecting audit messages is =
disabled.
[86531.331902] systemd-journald[2799374]: File =
/var/log/journal/1a15c5c01ee34ffb8beb42df7c18ff94/system.journal =
corrupted or uncleanly shut down, renaming and replacing.
[86531.338702] systemd[1]: Started Journal Service.
[root@minimyth2-x8664 piotro]#=

