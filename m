Return-Path: <stable+bounces-145937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F55EABFDEB
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 22:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57689E6549
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 20:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26B6299953;
	Wed, 21 May 2025 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEGfg+pU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD08C296D20
	for <stable@vger.kernel.org>; Wed, 21 May 2025 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859444; cv=none; b=jnDGQpmdoSCWlkJX9QNnpJaxVOdKoIenx0ZOUVLs8/PvR6928ftHvO8OVbhuHG8vwXoG1ERIzzE8dGqocp7nxnImUanEa12Jq7PCoHHHH4Jg3OyHOYdDqAj1lO6XTAPHLzEwuyRI/vxGY9bK3NsoLyM70IiYrXT+/M8H+BlkhgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859444; c=relaxed/simple;
	bh=xgjKo/aHl9SLU8m3GQqpUNCzJF/AYs3fSj/nkXOzo/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK/I1RuhY0Jtsda4/N5pA7ERb5+HmRvuWUt6jjXue9YoYno1bv6HGaOr/Op5eosoA6cXWB/jGctrWM3ae+PIAMyeOa1c5z4ScTcvXZ6ObjwRzfOCiL6YO8kl1HVCBN9aAE09yccVrievVf4AGu28pina3/mQRTWFUjprIxre02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEGfg+pU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-602346b1997so2135200a12.3
        for <stable@vger.kernel.org>; Wed, 21 May 2025 13:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747859411; x=1748464211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0RmpD95eYFdsV27Sm7Xs7N547rco2uh24pZZgeYaco=;
        b=UEGfg+pUqTZ9ozwFxZGnofe7U44+VOF97G3uZXZEfcUC1qJWxzysZImxV1OYogeGYz
         G2SA9EHrPsqV05zabQk6eaEETPuThHcT+g6dHHLJtmIW9dRvsyNBpNwobPfpHtaPJoP7
         yqZFFpvsprbnwj3ngw9Z0mDh+jU5htqW8CFwo34V8xrEcWISWMFOUWHBXPas1Vnv53Z9
         QWvu9AsffPXhA0DEx1q8irk1Gdn2nXf1pMaxpv2d2tAi4nbUuIrgH4XZ6Tw29dGtzYVq
         lPHs939dzgyjW79kVqra8kZpPg32TxLHwWzfTiCJaRmeYYUx0M/o1jAedst8bsqrIiCt
         8LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747859411; x=1748464211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0RmpD95eYFdsV27Sm7Xs7N547rco2uh24pZZgeYaco=;
        b=fg7HkEOXB4WMmzA2mEXhlGJJaYjGlnK4axeK/nl8DnoMdgU3BekliLI5nTOVX6cvOE
         KL3RV5+QMQfSwRVvwiKKsQX7CguoAlnZCFiUVSE67XCmd4yStjr6bNYbEtQe2Wf3/bsD
         penfdqCmqfccuOlq91Dc4knUXw3gUh2awtkRpohyO+JqEUc7fMnbInaSEAyo085gRhhC
         7KPkf63QX7tddAgwhXC8MmE+tl+R7QOxMlJS7u1/Ccxser8v0M1/r0RWFqytKAYA3JoU
         c/lR+v6qRuTKa5cyg9zKv2XyRFPDPFRMf0mBMj00jl68xXTIBNN95e2Zxsl3wPJJ1c2t
         DQqA==
X-Gm-Message-State: AOJu0YypEQLTFZe6uZ33cXUKGzShp3IkZ04Q1OKDSAmhxKR+1Jnh7A2t
	PKEWsUv0Nu+3R8tfaPuOcr/34QhxaJsXglV979aCDiYQ5x33l35Ce4n+
X-Gm-Gg: ASbGncvnlawniyv4KQVbZiMipl1T7n58rmafxNhyyUDfvI42GDI5zHVTAai1dboeOgv
	3wckeGApzxzTrGxodAJgVWL0Whh1tvBf3vDrOrSZXyUVknJAflOgaxScD2UD42D5j8XZyTptJJB
	161r2PwY3UL9GToq0+XCn5t9F5hRBuMpIFzQa9Zq13kNtk+QxzXKXPpQCPb8/05wmXfBueRT3fc
	hGaeLLmUAyTHyrOmN2e2oV1uABuWOV+3xEq+/um+7YheQa3vdVYK/mp9LQFHjoS+b14C0zixa45
	Yrz2LQb1hsTcHWkAx7N8dNl7CE0DsXJ+JvCqzNoIImTqUlfkXrVlFZ2e5k6TVoUgiobnd4Okfuz
	rJARKJVw6
X-Google-Smtp-Source: AGHT+IFUvME/oy74u3l+JWtz+PwWmckDmdozdOTWy0MT/40b8BNifwCq9Y91yY95RujiKbVXTZIrzw==
X-Received: by 2002:a05:6402:4315:b0:602:1832:c18b with SMTP id 4fb4d7f45d1cf-6021832d6a8mr6094011a12.24.1747859409122;
        Wed, 21 May 2025 13:30:09 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60231eece31sm1844364a12.51.2025.05.21.13.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 13:30:07 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 88C6FBE2DE0; Wed, 21 May 2025 22:30:05 +0200 (CEST)
Date: Wed, 21 May 2025 22:30:05 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Moritz =?iso-8859-1?Q?M=FChlenhoff?= <mmuhlenhoff@wikimedia.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	alexandre.chartre@oracle.com,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: Regression between 6.1.135 and 6.1.139, possibly related to ITS
 mitigations
Message-ID: <aC43zcG1v0A0J9Hp@eldamar.lan>
References: <aC3R_CCacqN9XmiL@pastis.westfalen.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aC3R_CCacqN9XmiL@pastis.westfalen.local>

hi Moritz,

On Wed, May 21, 2025 at 03:15:40PM +0200, Moritz M=C3=BChlenhoff wrote:
> Hi,
> I'd like to report a regression which seems related to the latest
> ITS mitigations in Linux 6.1.x:
>=20
> The server in question is a Supermicro SYS-120C-TN10R with
> a "Intel(R) Xeon(R) Silver 4310 CPU @ 2.10GHz" CPU, running
> Debian Bookworm. The full output of /proc/cpuinfo is attached
> as cpuinfo.txt
>=20
> In addition to the kernel changes between 6.1.135 and 6.1.139
> there is also some additional invariant, namely the Intel microcode
> loaded at early boot:
>=20
> On Linux 6.1.135 every works fine with both the 20250211 and
> 20250512 microcode releases (kern.log is attached as
> 6.1.135-feb-microcode.log and 6.1.135-may-microcode.log)
>=20
> With 6.1.139 and the February microcode, oopses appear related
> to clear_bhb_loop() (which may be related to "x86/its: Align
> RETs in BHB clear sequence to avoid thunking"?). This is
> captured in 6.1.139-feb-microcode.log.
>=20
> With 6.1.139 and the May microcode, the system mostly
> crashes on bootup (in my tests it crashed in three out of
> four attempts). I've captured both the crash
> (6.1.139-may-microcode-crash.log) and a working boot
> (6.1.139-may-microcode-noncrash.log).
>=20
> If you need any additional information, please let me know!

After looking at your crash logs in more detail, I suspect that your
issue is the same root cause as spotted as well for the 5.15 series in
https://lore.kernel.org/all/81cd1d38-8856-4b27-921d-839d9e385942@oracle.com/

I assume you can confirm as well that disabling the ITS mitigation
with indirect_target_selection=3Doff makes the system boot?

Regards,
Salvatore

(keeping the logs for context below)

> 2025-05-21T10:59:23.311954+00:00 mc-misc2002 kernel: [    0.000000] micro=
code: microcode updated early to revision 0xd0003f5, date =3D 2024-08-02
> 2025-05-21T10:59:23.312105+00:00 mc-misc2002 kernel: [    0.000000] Linux=
 version 6.1.0-34-amd64 (debian-kernel@lists.debian.org) (gcc-12 (Debian 12=
=2E2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PR=
EEMPT_DYNAMIC Debian 6.1.135-1 (2025-04-25)
> 2025-05-21T10:59:23.312111+00:00 mc-misc2002 kernel: [    0.000000] Comma=
nd line: BOOT_IMAGE=3D/boot/vmlinuz-6.1.0-34-amd64 root=3D/dev/mapper/vg0-r=
oot ro console=3DttyS1,115200n8 raid0.default_layout=3D2 elevator=3Ddeadline
> 2025-05-21T10:59:23.312112+00:00 mc-misc2002 kernel: [    0.000000] x86/t=
me: not enabled by BIOS
> 2025-05-21T10:59:23.312115+00:00 mc-misc2002 kernel: [    0.000000] x86/s=
plit lock detection: #AC: crashing the kernel on kernel split_locks and war=
ning on user-space split_locks
> 2025-05-21T10:59:23.312116+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
provided physical RAM map:
> 2025-05-21T10:59:23.312116+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000000000000-0x00000000000987ff] usable
> 2025-05-21T10:59:23.312119+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000000098800-0x000000000009ffff] reserved
> 2025-05-21T10:59:23.312120+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> 2025-05-21T10:59:23.312120+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000000100000-0x00000000645fefff] usable
> 2025-05-21T10:59:23.312121+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000645ff000-0x0000000066ffefff] reserved
> 2025-05-21T10:59:23.312121+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000066fff000-0x00000000678fefff] ACPI data
> 2025-05-21T10:59:23.312122+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000678ff000-0x0000000067dfefff] ACPI NVS
> 2025-05-21T10:59:23.312124+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000067dff000-0x000000006c1fefff] reserved
> 2025-05-21T10:59:23.312125+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x000000006c1ff000-0x000000006f7fffff] usable
> 2025-05-21T10:59:23.312126+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x000000006f800000-0x000000008fffffff] reserved
> 2025-05-21T10:59:23.312126+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
> 2025-05-21T10:59:23.312126+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000fed20000-0x00000000fed44fff] reserved
> 2025-05-21T10:59:23.312127+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> 2025-05-21T10:59:23.312127+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000100000000-0x000000407fffffff] usable
> 2025-05-21T10:59:23.312131+00:00 mc-misc2002 kernel: [    0.000000] NX (E=
xecute Disable) protection: active
> 2025-05-21T10:59:23.312132+00:00 mc-misc2002 kernel: [    0.000000] SMBIO=
S 3.3.0 present.
> 2025-05-21T10:59:23.312132+00:00 mc-misc2002 kernel: [    0.000000] DMI: =
Supermicro SYS-120C-TN10R/X12DDW-A6, BIOS 1.9 01/11/2024
> 2025-05-21T10:59:23.312133+00:00 mc-misc2002 kernel: [    0.000000] tsc: =
Detected 2100.000 MHz processor
> 2025-05-21T10:59:23.312134+00:00 mc-misc2002 kernel: [    0.035819] e820:=
 update [mem 0x00000000-0x00000fff] usable =3D=3D> reserved
> 2025-05-21T10:59:23.312135+00:00 mc-misc2002 kernel: [    0.035916] e820:=
 remove [mem 0x000a0000-0x000fffff] usable
> 2025-05-21T10:59:23.312138+00:00 mc-misc2002 kernel: [    0.036203] last_=
pfn =3D 0x4080000 max_arch_pfn =3D 0x10000000000
> 2025-05-21T10:59:23.312138+00:00 mc-misc2002 kernel: [    0.040350] x86/P=
AT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT =20
> 2025-05-21T10:59:23.312153+00:00 mc-misc2002 kernel: [    0.064518] e820:=
 update [mem 0x7f000000-0xffffffff] usable =3D=3D> reserved
> 2025-05-21T10:59:23.312154+00:00 mc-misc2002 kernel: [    0.064665] last_=
pfn =3D 0x6f800 max_arch_pfn =3D 0x10000000000
> 2025-05-21T10:59:23.312154+00:00 mc-misc2002 kernel: [    0.091726] Using=
 GB pages for direct mapping
> 2025-05-21T10:59:23.312154+00:00 mc-misc2002 kernel: [    0.092037] RAMDI=
SK: [mem 0x32d75000-0x356b1fff]
> 2025-05-21T10:59:23.312157+00:00 mc-misc2002 kernel: [    0.092043] ACPI:=
 Early table checksum verification disabled
> 2025-05-21T10:59:23.312158+00:00 mc-misc2002 kernel: [    0.092048] ACPI:=
 RSDP 0x00000000000F05B0 000024 (v02 SUPERM)
> 2025-05-21T10:59:23.312158+00:00 mc-misc2002 kernel: [    0.092054] ACPI:=
 XSDT 0x0000000067AC4728 0000FC (v01 SUPERM SMCI--MB 01072009 AMI  01000013)
> 2025-05-21T10:59:23.312158+00:00 mc-misc2002 kernel: [    0.092062] ACPI:=
 FACP 0x00000000678FC000 000114 (v06 SUPERM SMCI--MB 01072009 INTL 20091013)
> 2025-05-21T10:59:23.312159+00:00 mc-misc2002 kernel: [    0.092069] ACPI:=
 DSDT 0x0000000067893000 067849 (v02 SUPERM SMCI--MB 01072009 INTL 20091013)
> 2025-05-21T10:59:23.312159+00:00 mc-misc2002 kernel: [    0.092074] ACPI:=
 FACS 0x0000000067DFD000 000040
> 2025-05-21T10:59:23.312160+00:00 mc-misc2002 kernel: [    0.092077] ACPI:=
 SPMI 0x00000000678FB000 000041 (v05 SUPERM SMCI--MB 00000000 AMI. 00000000)
> 2025-05-21T10:59:23.312162+00:00 mc-misc2002 kernel: [    0.092082] ACPI:=
 FIDT 0x0000000067892000 00009C (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
> 2025-05-21T10:59:23.312163+00:00 mc-misc2002 kernel: [    0.092085] ACPI:=
 SSDT 0x00000000678FE000 000704 (v02 INTEL  RAS_ACPI 00000001 INTL 20200925)
> 2025-05-21T10:59:23.312163+00:00 mc-misc2002 kernel: [    0.092090] ACPI:=
 EINJ 0x00000000678FD000 000150 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
> 2025-05-21T10:59:23.312164+00:00 mc-misc2002 kernel: [    0.092094] ACPI:=
 ERST 0x0000000067891000 000230 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
> 2025-05-21T10:59:23.312166+00:00 mc-misc2002 kernel: [    0.092097] ACPI:=
 BERT 0x0000000067890000 000030 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
> 2025-05-21T10:59:23.312166+00:00 mc-misc2002 kernel: [    0.092101] ACPI:=
 SSDT 0x000000006788F000 000745 (v02 INTEL  ADDRXLAT 00000001 INTL 20200925)
> 2025-05-21T10:59:23.312169+00:00 mc-misc2002 kernel: [    0.092105] ACPI:=
 MCFG 0x000000006788E000 00003C (v01 SUPERM SMCI--MB 01072009 MSFT 00000097)
> 2025-05-21T10:59:23.312169+00:00 mc-misc2002 kernel: [    0.092109] ACPI:=
 BDAT 0x000000006788D000 000030 (v01 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T10:59:23.312170+00:00 mc-misc2002 kernel: [    0.092113] ACPI:=
 HMAT 0x000000006788C000 000180 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
> 2025-05-21T10:59:23.312178+00:00 mc-misc2002 kernel: [    0.092117] ACPI:=
 HPET 0x000000006788B000 000038 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
> 2025-05-21T10:59:23.312179+00:00 mc-misc2002 kernel: [    0.092121] ACPI:=
 MIGT 0x000000006788A000 000040 (v01 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T10:59:23.312180+00:00 mc-misc2002 kernel: [    0.092124] ACPI:=
 MSCT 0x0000000067889000 000090 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
> 2025-05-21T10:59:23.312180+00:00 mc-misc2002 kernel: [    0.092128] ACPI:=
 WDDT 0x0000000067888000 000040 (v01 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T10:59:23.312183+00:00 mc-misc2002 kernel: [    0.092132] ACPI:=
 APIC 0x0000000067886000 0001DE (v04 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T10:59:23.312184+00:00 mc-misc2002 kernel: [    0.092136] ACPI:=
 SLIT 0x0000000067885000 000030 (v01 SUPERM SMCI--MB 00000001 AMI  01000013)
> 2025-05-21T10:59:23.312184+00:00 mc-misc2002 kernel: [    0.092140] ACPI:=
 SRAT 0x000000006787E000 006430 (v03 SUPERM SMCI--MB 00000002 AMI  01000013)
> 2025-05-21T10:59:23.312185+00:00 mc-misc2002 kernel: [    0.092144] ACPI:=
 OEM4 0x00000000676F6000 187A61 (v02 INTEL  CPU  CST 00003000 INTL 20200925)
> 2025-05-21T10:59:23.312187+00:00 mc-misc2002 kernel: [    0.092148] ACPI:=
 OEM1 0x00000000675E2000 113489 (v02 INTEL  CPU EIST 00003000 INTL 20200925)
> 2025-05-21T10:59:23.312188+00:00 mc-misc2002 kernel: [    0.092152] ACPI:=
 SSDT 0x000000006756B000 0764A5 (v02 INTEL  SSDT  PM 00004000 INTL 20200925)
> 2025-05-21T10:59:23.312190+00:00 mc-misc2002 kernel: [    0.092156] ACPI:=
 HEST 0x0000000067569000 00013C (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
> 2025-05-21T10:59:23.312192+00:00 mc-misc2002 kernel: [    0.092159] ACPI:=
 DMAR 0x0000000067568000 0002F8 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
> 2025-05-21T10:59:23.312193+00:00 mc-misc2002 kernel: [    0.092163] ACPI:=
 SSDT 0x0000000067560000 0078BA (v02 INTEL  SpsNm    00000002 INTL 20200925)
> 2025-05-21T10:59:23.312193+00:00 mc-misc2002 kernel: [    0.092167] ACPI:=
 SSDT 0x000000006755E000 001744 (v01 SUPERM SMCCDN   00000000 INTL 20181221)
> 2025-05-21T10:59:23.312194+00:00 mc-misc2002 kernel: [    0.092171] ACPI:=
 WSMT 0x0000000067887000 000028 (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
> 2025-05-21T10:59:23.312194+00:00 mc-misc2002 kernel: [    0.092175] ACPI:=
 SSDT 0x000000006756A000 0009B3 (v02 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T10:59:23.312196+00:00 mc-misc2002 kernel: [    0.092178] ACPI:=
 Reserving FACP table memory at [mem 0x678fc000-0x678fc113]
> 2025-05-21T10:59:23.312197+00:00 mc-misc2002 kernel: [    0.092180] ACPI:=
 Reserving DSDT table memory at [mem 0x67893000-0x678fa848]
> 2025-05-21T10:59:23.312198+00:00 mc-misc2002 kernel: [    0.092181] ACPI:=
 Reserving FACS table memory at [mem 0x67dfd000-0x67dfd03f]
> 2025-05-21T10:59:23.312199+00:00 mc-misc2002 kernel: [    0.092182] ACPI:=
 Reserving SPMI table memory at [mem 0x678fb000-0x678fb040]
> 2025-05-21T10:59:23.312200+00:00 mc-misc2002 kernel: [    0.092183] ACPI:=
 Reserving FIDT table memory at [mem 0x67892000-0x6789209b]
> 2025-05-21T10:59:23.312201+00:00 mc-misc2002 kernel: [    0.092184] ACPI:=
 Reserving SSDT table memory at [mem 0x678fe000-0x678fe703]
> 2025-05-21T10:59:23.312201+00:00 mc-misc2002 kernel: [    0.092185] ACPI:=
 Reserving EINJ table memory at [mem 0x678fd000-0x678fd14f]
> 2025-05-21T10:59:23.312328+00:00 mc-misc2002 kernel: [    0.092186] ACPI:=
 Reserving ERST table memory at [mem 0x67891000-0x6789122f]
> 2025-05-21T10:59:23.312336+00:00 mc-misc2002 kernel: [    0.092187] ACPI:=
 Reserving BERT table memory at [mem 0x67890000-0x6789002f]
> 2025-05-21T10:59:23.312337+00:00 mc-misc2002 kernel: [    0.092187] ACPI:=
 Reserving SSDT table memory at [mem 0x6788f000-0x6788f744]
> 2025-05-21T10:59:23.312338+00:00 mc-misc2002 kernel: [    0.092188] ACPI:=
 Reserving MCFG table memory at [mem 0x6788e000-0x6788e03b]
> 2025-05-21T10:59:23.312338+00:00 mc-misc2002 kernel: [    0.092189] ACPI:=
 Reserving BDAT table memory at [mem 0x6788d000-0x6788d02f]
> 2025-05-21T10:59:23.312339+00:00 mc-misc2002 kernel: [    0.092190] ACPI:=
 Reserving HMAT table memory at [mem 0x6788c000-0x6788c17f]
> 2025-05-21T10:59:23.312519+00:00 mc-misc2002 kernel: [    0.092191] ACPI:=
 Reserving HPET table memory at [mem 0x6788b000-0x6788b037]
> 2025-05-21T10:59:23.312530+00:00 mc-misc2002 kernel: [    0.092192] ACPI:=
 Reserving MIGT table memory at [mem 0x6788a000-0x6788a03f]
> 2025-05-21T10:59:23.312531+00:00 mc-misc2002 kernel: [    0.092193] ACPI:=
 Reserving MSCT table memory at [mem 0x67889000-0x6788908f]
> 2025-05-21T10:59:23.312532+00:00 mc-misc2002 kernel: [    0.092194] ACPI:=
 Reserving WDDT table memory at [mem 0x67888000-0x6788803f]
> 2025-05-21T10:59:23.312532+00:00 mc-misc2002 kernel: [    0.092195] ACPI:=
 Reserving APIC table memory at [mem 0x67886000-0x678861dd]
> 2025-05-21T10:59:23.312533+00:00 mc-misc2002 kernel: [    0.092196] ACPI:=
 Reserving SLIT table memory at [mem 0x67885000-0x6788502f]
> 2025-05-21T10:59:23.312533+00:00 mc-misc2002 kernel: [    0.092197] ACPI:=
 Reserving SRAT table memory at [mem 0x6787e000-0x6788442f]
> 2025-05-21T10:59:23.312537+00:00 mc-misc2002 kernel: [    0.092198] ACPI:=
 Reserving OEM4 table memory at [mem 0x676f6000-0x6787da60]
> 2025-05-21T10:59:23.312539+00:00 mc-misc2002 kernel: [    0.092199] ACPI:=
 Reserving OEM1 table memory at [mem 0x675e2000-0x676f5488]
> 2025-05-21T10:59:23.312539+00:00 mc-misc2002 kernel: [    0.092200] ACPI:=
 Reserving SSDT table memory at [mem 0x6756b000-0x675e14a4]
> 2025-05-21T10:59:23.312540+00:00 mc-misc2002 kernel: [    0.092201] ACPI:=
 Reserving HEST table memory at [mem 0x67569000-0x6756913b]
> 2025-05-21T10:59:23.312541+00:00 mc-misc2002 kernel: [    0.092202] ACPI:=
 Reserving DMAR table memory at [mem 0x67568000-0x675682f7]
> 2025-05-21T10:59:23.312541+00:00 mc-misc2002 kernel: [    0.092203] ACPI:=
 Reserving SSDT table memory at [mem 0x67560000-0x675678b9]
> 2025-05-21T10:59:23.312547+00:00 mc-misc2002 kernel: [    0.092204] ACPI:=
 Reserving SSDT table memory at [mem 0x6755e000-0x6755f743]
> 2025-05-21T10:59:23.312547+00:00 mc-misc2002 kernel: [    0.092205] ACPI:=
 Reserving WSMT table memory at [mem 0x67887000-0x67887027]
> 2025-05-21T10:59:23.312548+00:00 mc-misc2002 kernel: [    0.092206] ACPI:=
 Reserving SSDT table memory at [mem 0x6756a000-0x6756a9b2]
> 2025-05-21T10:59:23.312550+00:00 mc-misc2002 kernel: [    0.092245] SRAT:=
 PXM 0 -> APIC 0x00 -> Node 0
> 2025-05-21T10:59:23.312550+00:00 mc-misc2002 kernel: [    0.092247] SRAT:=
 PXM 0 -> APIC 0x01 -> Node 0
> 2025-05-21T10:59:23.312551+00:00 mc-misc2002 kernel: [    0.092248] SRAT:=
 PXM 0 -> APIC 0x02 -> Node 0
> 2025-05-21T10:59:23.312585+00:00 mc-misc2002 kernel: [    0.092249] SRAT:=
 PXM 0 -> APIC 0x03 -> Node 0
> 2025-05-21T10:59:23.312588+00:00 mc-misc2002 kernel: [    0.092249] SRAT:=
 PXM 0 -> APIC 0x04 -> Node 0
> 2025-05-21T10:59:23.312588+00:00 mc-misc2002 kernel: [    0.092250] SRAT:=
 PXM 0 -> APIC 0x05 -> Node 0
> 2025-05-21T10:59:23.312589+00:00 mc-misc2002 kernel: [    0.092251] SRAT:=
 PXM 0 -> APIC 0x06 -> Node 0
> 2025-05-21T10:59:23.312589+00:00 mc-misc2002 kernel: [    0.092252] SRAT:=
 PXM 0 -> APIC 0x07 -> Node 0
> 2025-05-21T10:59:23.312589+00:00 mc-misc2002 kernel: [    0.092253] SRAT:=
 PXM 0 -> APIC 0x08 -> Node 0
> 2025-05-21T10:59:23.312590+00:00 mc-misc2002 kernel: [    0.092253] SRAT:=
 PXM 0 -> APIC 0x09 -> Node 0
> 2025-05-21T10:59:23.312774+00:00 mc-misc2002 kernel: [    0.092254] SRAT:=
 PXM 0 -> APIC 0x0a -> Node 0
> 2025-05-21T10:59:23.312785+00:00 mc-misc2002 kernel: [    0.092255] SRAT:=
 PXM 0 -> APIC 0x0b -> Node 0
> 2025-05-21T10:59:23.312786+00:00 mc-misc2002 kernel: [    0.092256] SRAT:=
 PXM 0 -> APIC 0x0c -> Node 0
> 2025-05-21T10:59:23.312787+00:00 mc-misc2002 kernel: [    0.092256] SRAT:=
 PXM 0 -> APIC 0x0d -> Node 0
> 2025-05-21T10:59:23.312787+00:00 mc-misc2002 kernel: [    0.092257] SRAT:=
 PXM 0 -> APIC 0x0e -> Node 0
> 2025-05-21T10:59:23.312788+00:00 mc-misc2002 kernel: [    0.092258] SRAT:=
 PXM 0 -> APIC 0x0f -> Node 0
> 2025-05-21T10:59:23.312791+00:00 mc-misc2002 kernel: [    0.092259] SRAT:=
 PXM 0 -> APIC 0x10 -> Node 0
> 2025-05-21T10:59:23.312792+00:00 mc-misc2002 kernel: [    0.092260] SRAT:=
 PXM 0 -> APIC 0x11 -> Node 0
> 2025-05-21T10:59:23.312792+00:00 mc-misc2002 kernel: [    0.092260] SRAT:=
 PXM 0 -> APIC 0x12 -> Node 0
> 2025-05-21T10:59:23.312793+00:00 mc-misc2002 kernel: [    0.092261] SRAT:=
 PXM 0 -> APIC 0x13 -> Node 0
> 2025-05-21T10:59:23.312793+00:00 mc-misc2002 kernel: [    0.092262] SRAT:=
 PXM 0 -> APIC 0x14 -> Node 0
> 2025-05-21T10:59:23.312794+00:00 mc-misc2002 kernel: [    0.092263] SRAT:=
 PXM 0 -> APIC 0x15 -> Node 0
> 2025-05-21T10:59:23.312794+00:00 mc-misc2002 kernel: [    0.092263] SRAT:=
 PXM 0 -> APIC 0x16 -> Node 0
> 2025-05-21T10:59:23.312797+00:00 mc-misc2002 kernel: [    0.092264] SRAT:=
 PXM 0 -> APIC 0x17 -> Node 0
> 2025-05-21T10:59:23.312799+00:00 mc-misc2002 kernel: [    0.092265] SRAT:=
 PXM 1 -> APIC 0x40 -> Node 1
> 2025-05-21T10:59:23.312815+00:00 mc-misc2002 kernel: [    0.092266] SRAT:=
 PXM 1 -> APIC 0x41 -> Node 1
> 2025-05-21T10:59:23.312815+00:00 mc-misc2002 kernel: [    0.092267] SRAT:=
 PXM 1 -> APIC 0x42 -> Node 1
> 2025-05-21T10:59:23.312816+00:00 mc-misc2002 kernel: [    0.092267] SRAT:=
 PXM 1 -> APIC 0x43 -> Node 1
> 2025-05-21T10:59:23.312816+00:00 mc-misc2002 kernel: [    0.092268] SRAT:=
 PXM 1 -> APIC 0x44 -> Node 1
> 2025-05-21T10:59:23.312819+00:00 mc-misc2002 kernel: [    0.092269] SRAT:=
 PXM 1 -> APIC 0x45 -> Node 1
> 2025-05-21T10:59:23.312820+00:00 mc-misc2002 kernel: [    0.092270] SRAT:=
 PXM 1 -> APIC 0x46 -> Node 1
> 2025-05-21T10:59:23.312820+00:00 mc-misc2002 kernel: [    0.092270] SRAT:=
 PXM 1 -> APIC 0x47 -> Node 1
> 2025-05-21T10:59:23.312821+00:00 mc-misc2002 kernel: [    0.092271] SRAT:=
 PXM 1 -> APIC 0x48 -> Node 1
> 2025-05-21T10:59:23.312821+00:00 mc-misc2002 kernel: [    0.092272] SRAT:=
 PXM 1 -> APIC 0x49 -> Node 1
> 2025-05-21T10:59:23.312821+00:00 mc-misc2002 kernel: [    0.092273] SRAT:=
 PXM 1 -> APIC 0x4a -> Node 1
> 2025-05-21T10:59:23.312824+00:00 mc-misc2002 kernel: [    0.092274] SRAT:=
 PXM 1 -> APIC 0x4b -> Node 1
> 2025-05-21T10:59:23.312825+00:00 mc-misc2002 kernel: [    0.092275] SRAT:=
 PXM 1 -> APIC 0x4c -> Node 1
> 2025-05-21T10:59:23.312825+00:00 mc-misc2002 kernel: [    0.092276] SRAT:=
 PXM 1 -> APIC 0x4d -> Node 1
> 2025-05-21T10:59:23.312825+00:00 mc-misc2002 kernel: [    0.092276] SRAT:=
 PXM 1 -> APIC 0x4e -> Node 1
> 2025-05-21T10:59:23.312826+00:00 mc-misc2002 kernel: [    0.092277] SRAT:=
 PXM 1 -> APIC 0x4f -> Node 1
> 2025-05-21T10:59:23.312826+00:00 mc-misc2002 kernel: [    0.092278] SRAT:=
 PXM 1 -> APIC 0x50 -> Node 1
> 2025-05-21T10:59:23.312827+00:00 mc-misc2002 kernel: [    0.092279] SRAT:=
 PXM 1 -> APIC 0x51 -> Node 1
> 2025-05-21T10:59:23.312829+00:00 mc-misc2002 kernel: [    0.092280] SRAT:=
 PXM 1 -> APIC 0x52 -> Node 1
> 2025-05-21T10:59:23.312830+00:00 mc-misc2002 kernel: [    0.092281] SRAT:=
 PXM 1 -> APIC 0x53 -> Node 1
> 2025-05-21T10:59:23.312830+00:00 mc-misc2002 kernel: [    0.092281] SRAT:=
 PXM 1 -> APIC 0x54 -> Node 1
> 2025-05-21T10:59:23.312831+00:00 mc-misc2002 kernel: [    0.092282] SRAT:=
 PXM 1 -> APIC 0x55 -> Node 1
> 2025-05-21T10:59:23.312831+00:00 mc-misc2002 kernel: [    0.092283] SRAT:=
 PXM 1 -> APIC 0x56 -> Node 1
> 2025-05-21T10:59:23.312831+00:00 mc-misc2002 kernel: [    0.092284] SRAT:=
 PXM 1 -> APIC 0x57 -> Node 1
> 2025-05-21T10:59:23.312842+00:00 mc-misc2002 kernel: [    0.092336] ACPI:=
 SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> 2025-05-21T10:59:23.312854+00:00 mc-misc2002 kernel: [    0.092338] ACPI:=
 SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
> 2025-05-21T10:59:23.312855+00:00 mc-misc2002 kernel: [    0.092340] ACPI:=
 SRAT: Node 1 PXM 1 [mem 0x2080000000-0x407fffffff]
> 2025-05-21T10:59:23.312855+00:00 mc-misc2002 kernel: [    0.092354] NUMA:=
 Initialized distance table, cnt=3D2
> 2025-05-21T10:59:23.312856+00:00 mc-misc2002 kernel: [    0.092358] NUMA:=
 Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-0x207fffffff] -> [me=
m 0x00000000-0x207fffffff]
> 2025-05-21T10:59:23.312856+00:00 mc-misc2002 kernel: [    0.092371] NODE_=
DATA(0) allocated [mem 0x207ffd5000-0x207fffffff]
> 2025-05-21T10:59:23.312859+00:00 mc-misc2002 kernel: [    0.092389] NODE_=
DATA(1) allocated [mem 0x407ffd4000-0x407fffefff]
> 2025-05-21T10:59:23.312860+00:00 mc-misc2002 kernel: [    0.093177] Zone =
ranges:
> 2025-05-21T10:59:23.312860+00:00 mc-misc2002 kernel: [    0.093178]   DMA=
      [mem 0x0000000000001000-0x0000000000ffffff]
> 2025-05-21T10:59:23.312860+00:00 mc-misc2002 kernel: [    0.093180]   DMA=
32    [mem 0x0000000001000000-0x00000000ffffffff]
> 2025-05-21T10:59:23.312861+00:00 mc-misc2002 kernel: [    0.093182]   Nor=
mal   [mem 0x0000000100000000-0x000000407fffffff]
> 2025-05-21T10:59:23.312866+00:00 mc-misc2002 kernel: [    0.093184]   Dev=
ice   empty
> 2025-05-21T10:59:23.312867+00:00 mc-misc2002 kernel: [    0.093185] Movab=
le zone start for each node
> 2025-05-21T10:59:23.312893+00:00 mc-misc2002 kernel: [    0.093190] Early=
 memory node ranges
> 2025-05-21T10:59:23.312894+00:00 mc-misc2002 kernel: [    0.093190]   nod=
e   0: [mem 0x0000000000001000-0x0000000000097fff]
> 2025-05-21T10:59:23.312894+00:00 mc-misc2002 kernel: [    0.093192]   nod=
e   0: [mem 0x0000000000100000-0x00000000645fefff]
> 2025-05-21T10:59:23.312900+00:00 mc-misc2002 kernel: [    0.093194]   nod=
e   0: [mem 0x000000006c1ff000-0x000000006f7fffff]
> 2025-05-21T10:59:23.312900+00:00 mc-misc2002 kernel: [    0.093195]   nod=
e   0: [mem 0x0000000100000000-0x000000207fffffff]
> 2025-05-21T10:59:23.312902+00:00 mc-misc2002 kernel: [    0.093209]   nod=
e   1: [mem 0x0000002080000000-0x000000407fffffff]
> 2025-05-21T10:59:23.312905+00:00 mc-misc2002 kernel: [    0.093224] Initm=
em setup node 0 [mem 0x0000000000001000-0x000000207fffffff]
> 2025-05-21T10:59:23.312905+00:00 mc-misc2002 kernel: [    0.093228] Initm=
em setup node 1 [mem 0x0000002080000000-0x000000407fffffff]
> 2025-05-21T10:59:23.312906+00:00 mc-misc2002 kernel: [    0.093233] On no=
de 0, zone DMA: 1 pages in unavailable ranges
> 2025-05-21T10:59:23.312908+00:00 mc-misc2002 kernel: [    0.093271] On no=
de 0, zone DMA: 104 pages in unavailable ranges
> 2025-05-21T10:59:23.312909+00:00 mc-misc2002 kernel: [    0.097511] On no=
de 0, zone DMA32: 31744 pages in unavailable ranges
> 2025-05-21T10:59:23.312909+00:00 mc-misc2002 kernel: [    0.097873] On no=
de 0, zone Normal: 2048 pages in unavailable ranges
> 2025-05-21T10:59:23.312910+00:00 mc-misc2002 kernel: [    0.098365] ACPI:=
 PM-Timer IO Port: 0x508
> 2025-05-21T10:59:23.312914+00:00 mc-misc2002 kernel: [    0.098380] ACPI:=
 X2APIC_NMI (uid[0xffffffff] high edge lint[0x1])
> 2025-05-21T10:59:23.312915+00:00 mc-misc2002 kernel: [    0.098384] ACPI:=
 LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> 2025-05-21T10:59:23.312915+00:00 mc-misc2002 kernel: [    0.098402] IOAPI=
C[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-119
> 2025-05-21T10:59:23.312916+00:00 mc-misc2002 kernel: [    0.098406] ACPI:=
 INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> 2025-05-21T10:59:23.312922+00:00 mc-misc2002 kernel: [    0.098409] ACPI:=
 INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> 2025-05-21T10:59:23.312923+00:00 mc-misc2002 kernel: [    0.098415] ACPI:=
 Using ACPI (MADT) for SMP configuration information
> 2025-05-21T10:59:23.312925+00:00 mc-misc2002 kernel: [    0.098416] ACPI:=
 HPET id: 0x8086a701 base: 0xfed00000
> 2025-05-21T10:59:23.312926+00:00 mc-misc2002 kernel: [    0.098422] TSC d=
eadline timer available
> 2025-05-21T10:59:23.312926+00:00 mc-misc2002 kernel: [    0.098424] smpbo=
ot: Allowing 48 CPUs, 0 hotplug CPUs
> 2025-05-21T10:59:23.312927+00:00 mc-misc2002 kernel: [    0.098443] PM: h=
ibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> 2025-05-21T10:59:23.312927+00:00 mc-misc2002 kernel: [    0.098446] PM: h=
ibernation: Registered nosave memory: [mem 0x00098000-0x000fffff]
> 2025-05-21T10:59:23.312928+00:00 mc-misc2002 kernel: [    0.098448] PM: h=
ibernation: Registered nosave memory: [mem 0x645ff000-0x6c1fefff]
> 2025-05-21T10:59:23.312930+00:00 mc-misc2002 kernel: [    0.098450] PM: h=
ibernation: Registered nosave memory: [mem 0x6f800000-0xffffffff]
> 2025-05-21T10:59:23.312931+00:00 mc-misc2002 kernel: [    0.098452] [mem =
0x90000000-0xfcffffff] available for PCI devices
> 2025-05-21T10:59:23.312936+00:00 mc-misc2002 kernel: [    0.098454] Booti=
ng paravirtualized kernel on bare hardware
> 2025-05-21T10:59:23.312943+00:00 mc-misc2002 kernel: [    0.098457] clock=
source: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_=
ns: 7645519600211568 ns
> 2025-05-21T10:59:23.312950+00:00 mc-misc2002 kernel: [    0.104857] setup=
_percpu: NR_CPUS:8192 nr_cpumask_bits:48 nr_cpu_ids:48 nr_node_ids:2
> 2025-05-21T10:59:23.312956+00:00 mc-misc2002 kernel: [    0.106947] percp=
u: Embedded 61 pages/cpu s212992 r8192 d28672 u262144
> 2025-05-21T10:59:23.312957+00:00 mc-misc2002 kernel: [    0.106957] pcpu-=
alloc: s212992 r8192 d28672 u262144 alloc=3D1*2097152
> 2025-05-21T10:59:23.312959+00:00 mc-misc2002 kernel: [    0.106960] pcpu-=
alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 24 25 26 27=20
> 2025-05-21T10:59:23.312966+00:00 mc-misc2002 kernel: [    0.106971] pcpu-=
alloc: [0] 28 29 30 31 32 33 34 35 [1] 12 13 14 15 16 17 18 19=20
> 2025-05-21T10:59:23.312967+00:00 mc-misc2002 kernel: [    0.106981] pcpu-=
alloc: [1] 20 21 22 23 36 37 38 39 [1] 40 41 42 43 44 45 46 47=20
> 2025-05-21T10:59:23.312967+00:00 mc-misc2002 kernel: [    0.107027] Fallb=
ack order for Node 0: 0 1=20
> 2025-05-21T10:59:23.312968+00:00 mc-misc2002 kernel: [    0.107030] Fallb=
ack order for Node 1: 1 0=20
> 2025-05-21T10:59:23.312968+00:00 mc-misc2002 kernel: [    0.107035] Built=
 2 zonelists, mobility grouping on.  Total pages: 65962256
> 2025-05-21T10:59:23.313008+00:00 mc-misc2002 kernel: [    0.107037] Polic=
y zone: Normal
> 2025-05-21T10:59:23.313008+00:00 mc-misc2002 kernel: [    0.107039] Kerne=
l command line: BOOT_IMAGE=3D/boot/vmlinuz-6.1.0-34-amd64 root=3D/dev/mappe=
r/vg0-root ro console=3DttyS1,115200n8 raid0.default_layout=3D2 elevator=3D=
deadline
> 2025-05-21T10:59:23.313009+00:00 mc-misc2002 kernel: [    0.107121] Kerne=
l parameter elevator=3D does not have any effect anymore.
> 2025-05-21T10:59:23.313019+00:00 mc-misc2002 kernel: [    0.107121] Pleas=
e use sysfs to set IO scheduler for individual devices.
> 2025-05-21T10:59:23.313020+00:00 mc-misc2002 kernel: [    0.107125] Unkno=
wn kernel command line parameters "BOOT_IMAGE=3D/boot/vmlinuz-6.1.0-34-amd6=
4", will be passed to user space.
> 2025-05-21T10:59:23.313021+00:00 mc-misc2002 kernel: [    0.107136] rando=
m: crng init done
> 2025-05-21T10:59:23.313031+00:00 mc-misc2002 kernel: [    0.107138] print=
k: log_buf_len individual max cpu contribution: 4096 bytes
> 2025-05-21T10:59:23.313032+00:00 mc-misc2002 kernel: [    0.107139] print=
k: log_buf_len total cpu_extra contributions: 192512 bytes
> 2025-05-21T10:59:23.313033+00:00 mc-misc2002 kernel: [    0.107140] print=
k: log_buf_len min size: 131072 bytes
> 2025-05-21T10:59:23.313033+00:00 mc-misc2002 kernel: [    0.107594] print=
k: log_buf_len: 524288 bytes
> 2025-05-21T10:59:23.313034+00:00 mc-misc2002 kernel: [    0.107595] print=
k: early log buf free: 117400(89%)
> 2025-05-21T10:59:23.313034+00:00 mc-misc2002 kernel: [    0.108403] mem a=
uto-init: stack:all(zero), heap alloc:on, heap free:off
> 2025-05-21T10:59:23.313048+00:00 mc-misc2002 kernel: [    0.108427] softw=
are IO TLB: area num 64.
> 2025-05-21T10:59:23.313049+00:00 mc-misc2002 kernel: [    0.234438] Memor=
y: 1852992K/268037724K available (14342K kernel code, 2339K rwdata, 9092K r=
odata, 2800K init, 17380K bss, 4369320K reserved, 0K cma-reserved)
> 2025-05-21T10:59:23.313050+00:00 mc-misc2002 kernel: [    0.234772] SLUB:=
 HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D48, Nodes=3D2
> 2025-05-21T10:59:23.313052+00:00 mc-misc2002 kernel: [    0.234809] ftrac=
e: allocating 40336 entries in 158 pages
> 2025-05-21T10:59:23.313053+00:00 mc-misc2002 kernel: [    0.244238] ftrac=
e: allocated 158 pages with 5 groups
> 2025-05-21T10:59:23.313053+00:00 mc-misc2002 kernel: [    0.245269] Dynam=
ic Preempt: voluntary
> 2025-05-21T10:59:23.313057+00:00 mc-misc2002 kernel: [    0.245419] rcu: =
Preemptible hierarchical RCU implementation.
> 2025-05-21T10:59:23.313059+00:00 mc-misc2002 kernel: [    0.245420] rcu: =
	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=3D48.
> 2025-05-21T10:59:23.313060+00:00 mc-misc2002 kernel: [    0.245422] 	Tram=
poline variant of Tasks RCU enabled.
> 2025-05-21T10:59:23.313061+00:00 mc-misc2002 kernel: [    0.245423] 	Rude=
 variant of Tasks RCU enabled.
> 2025-05-21T10:59:23.313061+00:00 mc-misc2002 kernel: [    0.245423] 	Trac=
ing variant of Tasks RCU enabled.
> 2025-05-21T10:59:23.313062+00:00 mc-misc2002 kernel: [    0.245425] rcu: =
RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> 2025-05-21T10:59:23.313062+00:00 mc-misc2002 kernel: [    0.245426] rcu: =
Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D48
> 2025-05-21T10:59:23.313075+00:00 mc-misc2002 kernel: [    0.251157] NR_IR=
QS: 524544, nr_irqs: 2440, preallocated irqs: 16
> 2025-05-21T10:59:23.313076+00:00 mc-misc2002 kernel: [    0.251401] rcu: =
srcu_init: Setting srcu_struct sizes based on contention.
> 2025-05-21T10:59:23.313076+00:00 mc-misc2002 kernel: [    0.252039] Conso=
le: colour dummy device 80x25
> 2025-05-21T10:59:23.313077+00:00 mc-misc2002 kernel: [    1.761591] print=
k: console [ttyS1] enabled
> 2025-05-21T10:59:23.313077+00:00 mc-misc2002 kernel: [    1.766337] mempo=
licy: Enabling automatic NUMA balancing. Configure with numa_balancing=3D o=
r the kernel.numa_balancing sysctl
> 2025-05-21T10:59:23.313078+00:00 mc-misc2002 kernel: [    1.778932] ACPI:=
 Core revision 20220331
> 2025-05-21T10:59:23.313082+00:00 mc-misc2002 kernel: [    1.786151] clock=
source: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7963585=
5245 ns
> 2025-05-21T10:59:23.313083+00:00 mc-misc2002 kernel: [    1.796355] APIC:=
 Switch to symmetric I/O mode setup
> 2025-05-21T10:59:23.313083+00:00 mc-misc2002 kernel: [    1.801944] DMAR:=
 Host address width 46
> 2025-05-21T10:59:23.313084+00:00 mc-misc2002 kernel: [    1.806261] DMAR:=
 DRHD base: 0x000000d0ffc000 flags: 0x0
> 2025-05-21T10:59:23.313084+00:00 mc-misc2002 kernel: [    1.812241] DMAR:=
 dmar0: reg_base_addr d0ffc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:59:23.313085+00:00 mc-misc2002 kernel: [    1.821726] DMAR:=
 DRHD base: 0x000000dbbfc000 flags: 0x0
> 2025-05-21T10:59:23.313089+00:00 mc-misc2002 kernel: [    1.827705] DMAR:=
 dmar1: reg_base_addr dbbfc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:59:23.313090+00:00 mc-misc2002 kernel: [    1.837190] DMAR:=
 DRHD base: 0x000000e67fc000 flags: 0x0
> 2025-05-21T10:59:23.313090+00:00 mc-misc2002 kernel: [    1.843168] DMAR:=
 dmar2: reg_base_addr e67fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:59:23.313091+00:00 mc-misc2002 kernel: [    1.852652] DMAR:=
 DRHD base: 0x000000f13fc000 flags: 0x0
> 2025-05-21T10:59:23.313091+00:00 mc-misc2002 kernel: [    1.858634] DMAR:=
 dmar3: reg_base_addr f13fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:59:23.313091+00:00 mc-misc2002 kernel: [    1.868120] DMAR:=
 DRHD base: 0x000000fb7fc000 flags: 0x0
> 2025-05-21T10:59:23.313092+00:00 mc-misc2002 kernel: [    1.874097] DMAR:=
 dmar4: reg_base_addr fb7fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:59:23.313097+00:00 mc-misc2002 kernel: [    1.883583] DMAR:=
 DRHD base: 0x000000a63fc000 flags: 0x0
> 2025-05-21T10:59:23.313101+00:00 mc-misc2002 kernel: [    1.889559] DMAR:=
 dmar5: reg_base_addr a63fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:59:23.313101+00:00 mc-misc2002 kernel: [    1.899044] DMAR:=
 DRHD base: 0x000000b0ffc000 flags: 0x0
> 2025-05-21T10:59:23.313102+00:00 mc-misc2002 kernel: [    1.905021] DMAR:=
 dmar6: reg_base_addr b0ffc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:59:23.313102+00:00 mc-misc2002 kernel: [    1.914506] DMAR:=
 DRHD base: 0x000000bbbfc000 flags: 0x0
> 2025-05-21T10:59:23.313102+00:00 mc-misc2002 kernel: [    1.920483] DMAR:=
 dmar7: reg_base_addr bbbfc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:59:23.313107+00:00 mc-misc2002 kernel: [    1.929968] DMAR:=
 DRHD base: 0x000000c5ffc000 flags: 0x0
> 2025-05-21T10:59:23.313109+00:00 mc-misc2002 kernel: [    1.935945] DMAR:=
 dmar8: reg_base_addr c5ffc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:59:23.313110+00:00 mc-misc2002 kernel: [    1.945431] DMAR:=
 DRHD base: 0x0000009b7fc000 flags: 0x1
> 2025-05-21T10:59:23.313111+00:00 mc-misc2002 kernel: [    1.951409] DMAR:=
 dmar9: reg_base_addr 9b7fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:59:23.313111+00:00 mc-misc2002 kernel: [    1.960894] DMAR:=
 RMRR base: 0x0000006b985000 end: 0x0000006b9a8fff
> 2025-05-21T10:59:23.313112+00:00 mc-misc2002 kernel: [    1.967943] DMAR:=
 RMRR base: 0x0000006a3d8000 end: 0x0000006a621fff
> 2025-05-21T10:59:23.313117+00:00 mc-misc2002 kernel: [    1.974991] DMAR:=
 ATSR flags: 0x0
> 2025-05-21T10:59:23.313119+00:00 mc-misc2002 kernel: [    1.978723] DMAR:=
 ATSR flags: 0x0
> 2025-05-21T10:59:23.313119+00:00 mc-misc2002 kernel: [    1.982456] DMAR:=
 RHSA base: 0x0000009b7fc000 proximity domain: 0x0
> 2025-05-21T10:59:23.313120+00:00 mc-misc2002 kernel: [    1.989503] DMAR:=
 RHSA base: 0x000000a63fc000 proximity domain: 0x0
> 2025-05-21T10:59:23.313120+00:00 mc-misc2002 kernel: [    1.996550] DMAR:=
 RHSA base: 0x000000b0ffc000 proximity domain: 0x0
> 2025-05-21T10:59:23.313121+00:00 mc-misc2002 kernel: [    2.003597] DMAR:=
 RHSA base: 0x000000bbbfc000 proximity domain: 0x0
> 2025-05-21T10:59:23.313121+00:00 mc-misc2002 kernel: [    2.010643] DMAR:=
 RHSA base: 0x000000c5ffc000 proximity domain: 0x0
> 2025-05-21T10:59:23.313126+00:00 mc-misc2002 kernel: [    2.017691] DMAR:=
 RHSA base: 0x000000d0ffc000 proximity domain: 0x1
> 2025-05-21T10:59:23.313127+00:00 mc-misc2002 kernel: [    2.024738] DMAR:=
 RHSA base: 0x000000dbbfc000 proximity domain: 0x1
> 2025-05-21T10:59:23.313128+00:00 mc-misc2002 kernel: [    2.031785] DMAR:=
 RHSA base: 0x000000e67fc000 proximity domain: 0x1
> 2025-05-21T10:59:23.313128+00:00 mc-misc2002 kernel: [    2.038831] DMAR:=
 RHSA base: 0x000000f13fc000 proximity domain: 0x1
> 2025-05-21T10:59:23.313129+00:00 mc-misc2002 kernel: [    2.045878] DMAR:=
 RHSA base: 0x000000fb7fc000 proximity domain: 0x1
> 2025-05-21T10:59:23.313130+00:00 mc-misc2002 kernel: [    2.052929] DMAR-=
IR: IOAPIC id 8 under DRHD base  0x9b7fc000 IOMMU 9
> 2025-05-21T10:59:23.313136+00:00 mc-misc2002 kernel: [    2.060074] DMAR-=
IR: HPET id 0 under DRHD base 0x9b7fc000
> 2025-05-21T10:59:23.313137+00:00 mc-misc2002 kernel: [    2.066148] DMAR-=
IR: Queued invalidation will be enabled to support x2apic and Intr-remappin=
g.
> 2025-05-21T10:59:23.313138+00:00 mc-misc2002 kernel: [    2.078908] DMAR-=
IR: Enabled IRQ remapping in x2apic mode
> 2025-05-21T10:59:23.313140+00:00 mc-misc2002 kernel: [    2.084970] x2api=
c enabled
> 2025-05-21T10:59:23.313140+00:00 mc-misc2002 kernel: [    2.088033] Switc=
hed APIC routing to cluster x2apic.
> 2025-05-21T10:59:23.313141+00:00 mc-misc2002 kernel: [    2.096243] ..TIM=
ER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
> 2025-05-21T10:59:23.313141+00:00 mc-misc2002 kernel: [    2.120331] clock=
source: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e4530a99b6, max_=
idle_ns: 440795257976 ns
> 2025-05-21T10:59:23.313146+00:00 mc-misc2002 kernel: [    2.132150] Calib=
rating delay loop (skipped), value calculated using timer frequency.. 4200.=
00 BogoMIPS (lpj=3D8400000)
> 2025-05-21T10:59:23.313146+00:00 mc-misc2002 kernel: [    2.136182] x86/c=
pu: VMX (outside TXT) disabled by BIOS
> 2025-05-21T10:59:23.313147+00:00 mc-misc2002 kernel: [    2.140148] x86/c=
pu: SGX disabled by BIOS.
> 2025-05-21T10:59:23.313147+00:00 mc-misc2002 kernel: [    2.144157] CPU0:=
 Thermal monitoring enabled (TM1)
> 2025-05-21T10:59:23.313148+00:00 mc-misc2002 kernel: [    2.148149] x86/c=
pu: User Mode Instruction Prevention (UMIP) activated
> 2025-05-21T10:59:23.313148+00:00 mc-misc2002 kernel: [    2.152508] proce=
ss: using mwait in idle threads
> 2025-05-21T10:59:23.313155+00:00 mc-misc2002 kernel: [    2.156150] Last =
level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> 2025-05-21T10:59:23.313156+00:00 mc-misc2002 kernel: [    2.160148] Last =
level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> 2025-05-21T10:59:23.313156+00:00 mc-misc2002 kernel: [    2.164153] Spect=
re V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> 2025-05-21T10:59:23.313157+00:00 mc-misc2002 kernel: [    2.168149] Spect=
re V2 : Spectre BHI mitigation: SW BHB clearing on vm exit
> 2025-05-21T10:59:23.313157+00:00 mc-misc2002 kernel: [    2.172147] Spect=
re V2 : Spectre BHI mitigation: SW BHB clearing on syscall
> 2025-05-21T10:59:23.313157+00:00 mc-misc2002 kernel: [    2.176148] Spect=
re V2 : Mitigation: Enhanced / Automatic IBRS
> 2025-05-21T10:59:23.313164+00:00 mc-misc2002 kernel: [    2.180148] Spect=
re V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> 2025-05-21T10:59:23.313166+00:00 mc-misc2002 kernel: [    2.184147] Spect=
re V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
> 2025-05-21T10:59:23.313168+00:00 mc-misc2002 kernel: [    2.188149] Spect=
re V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> 2025-05-21T10:59:23.313168+00:00 mc-misc2002 kernel: [    2.192148] Specu=
lative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> 2025-05-21T10:59:23.313169+00:00 mc-misc2002 kernel: [    2.196151] MMIO =
Stale Data: Mitigation: Clear CPU buffers
> 2025-05-21T10:59:23.313169+00:00 mc-misc2002 kernel: [    2.200149] GDS: =
Mitigation: Microcode
> 2025-05-21T10:59:23.313175+00:00 mc-misc2002 kernel: [    2.204157] x86/f=
pu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> 2025-05-21T10:59:23.313176+00:00 mc-misc2002 kernel: [    2.208148] x86/f=
pu: Supporting XSAVE feature 0x002: 'SSE registers'
> 2025-05-21T10:59:23.313176+00:00 mc-misc2002 kernel: [    2.212147] x86/f=
pu: Supporting XSAVE feature 0x004: 'AVX registers'
> 2025-05-21T10:59:23.313177+00:00 mc-misc2002 kernel: [    2.216148] x86/f=
pu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
> 2025-05-21T10:59:23.313183+00:00 mc-misc2002 kernel: [    2.220148] x86/f=
pu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
> 2025-05-21T10:59:23.313184+00:00 mc-misc2002 kernel: [    2.224148] x86/f=
pu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
> 2025-05-21T10:59:23.313184+00:00 mc-misc2002 kernel: [    2.228148] x86/f=
pu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
> 2025-05-21T10:59:23.313200+00:00 mc-misc2002 kernel: [    2.232148] x86/f=
pu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> 2025-05-21T10:59:23.313201+00:00 mc-misc2002 kernel: [    2.236148] x86/f=
pu: xstate_offset[5]:  832, xstate_sizes[5]:   64
> 2025-05-21T10:59:23.313209+00:00 mc-misc2002 kernel: [    2.240148] x86/f=
pu: xstate_offset[6]:  896, xstate_sizes[6]:  512
> 2025-05-21T10:59:23.313210+00:00 mc-misc2002 kernel: [    2.244148] x86/f=
pu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
> 2025-05-21T10:59:23.313210+00:00 mc-misc2002 kernel: [    2.248148] x86/f=
pu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
> 2025-05-21T10:59:23.313211+00:00 mc-misc2002 kernel: [    2.252148] x86/f=
pu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compa=
cted' format.
> 2025-05-21T10:59:23.313216+00:00 mc-misc2002 kernel: [    2.280495] Freei=
ng SMP alternatives memory: 36K
> 2025-05-21T10:59:23.313222+00:00 mc-misc2002 kernel: [    2.284148] pid_m=
ax: default: 49152 minimum: 384
> 2025-05-21T10:59:23.313229+00:00 mc-misc2002 kernel: [    2.288224] LSM: =
Security Framework initializing
> 2025-05-21T10:59:23.313239+00:00 mc-misc2002 kernel: [    2.292168] landl=
ock: Up and running.
> 2025-05-21T10:59:23.313240+00:00 mc-misc2002 kernel: [    2.296147] Yama:=
 disabled by default; enable with sysctl kernel.yama.*
> 2025-05-21T10:59:23.313241+00:00 mc-misc2002 kernel: [    2.300177] AppAr=
mor: AppArmor initialized
> 2025-05-21T10:59:23.313252+00:00 mc-misc2002 kernel: [    2.304149] TOMOY=
O Linux initialized
> 2025-05-21T10:59:23.313253+00:00 mc-misc2002 kernel: [    2.308153] LSM s=
upport for eBPF active
> 2025-05-21T10:59:23.313253+00:00 mc-misc2002 kernel: [    2.330894] Dentr=
y cache hash table entries: 16777216 (order: 15, 134217728 bytes, vmalloc h=
ugepage)
> 2025-05-21T10:59:23.313254+00:00 mc-misc2002 kernel: [    2.342354] Inode=
-cache hash table entries: 8388608 (order: 14, 67108864 bytes, vmalloc huge=
page)
> 2025-05-21T10:59:23.313255+00:00 mc-misc2002 kernel: [    2.344505] Mount=
-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T10:59:23.313256+00:00 mc-misc2002 kernel: [    2.348459] Mount=
point-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T10:59:23.313261+00:00 mc-misc2002 kernel: [    2.352921] smpbo=
ot: CPU0: Intel(R) Xeon(R) Silver 4310 CPU @ 2.10GHz (family: 0x6, model: 0=
x6a, stepping: 0x6)
> 2025-05-21T10:59:23.313266+00:00 mc-misc2002 kernel: [    2.356309] cblis=
t_init_generic: Setting adjustable number of callback queues.
> 2025-05-21T10:59:23.313267+00:00 mc-misc2002 kernel: [    2.360148] cblis=
t_init_generic: Setting shift to 6 and lim to 1.
> 2025-05-21T10:59:23.313267+00:00 mc-misc2002 kernel: [    2.364167] cblis=
t_init_generic: Setting adjustable number of callback queues.
> 2025-05-21T10:59:23.313268+00:00 mc-misc2002 kernel: [    2.368148] cblis=
t_init_generic: Setting shift to 6 and lim to 1.
> 2025-05-21T10:59:23.313268+00:00 mc-misc2002 kernel: [    2.372171] cblis=
t_init_generic: Setting adjustable number of callback queues.
> 2025-05-21T10:59:23.313268+00:00 mc-misc2002 kernel: [    2.376148] cblis=
t_init_generic: Setting shift to 6 and lim to 1.
> 2025-05-21T10:59:23.313274+00:00 mc-misc2002 kernel: [    2.380161] Perfo=
rmance Events: PEBS fmt4+-baseline,  AnyThread deprecated, Icelake events, =
32-deep LBR, full-width counters, Intel PMU driver.
> 2025-05-21T10:59:23.313275+00:00 mc-misc2002 kernel: [    2.384148] ... v=
ersion:                5
> 2025-05-21T10:59:23.313275+00:00 mc-misc2002 kernel: [    2.388147] ... b=
it width:              48
> 2025-05-21T10:59:23.313276+00:00 mc-misc2002 kernel: [    2.392147] ... g=
eneric registers:      8
> 2025-05-21T10:59:23.313276+00:00 mc-misc2002 kernel: [    2.396147] ... v=
alue mask:             0000ffffffffffff
> 2025-05-21T10:59:23.313276+00:00 mc-misc2002 kernel: [    2.400147] ... m=
ax period:             00007fffffffffff
> 2025-05-21T10:59:23.313282+00:00 mc-misc2002 kernel: [    2.404147] ... f=
ixed-purpose events:   4
> 2025-05-21T10:59:23.313283+00:00 mc-misc2002 kernel: [    2.408147] ... e=
vent mask:             0001000f000000ff
> 2025-05-21T10:59:23.313283+00:00 mc-misc2002 kernel: [    2.412292] signa=
l: max sigframe size: 3632
> 2025-05-21T10:59:23.313284+00:00 mc-misc2002 kernel: [    2.416166] Estim=
ated ratio of average max frequency by base frequency (times 1024): 1316
> 2025-05-21T10:59:23.313290+00:00 mc-misc2002 kernel: [    2.420168] rcu: =
Hierarchical SRCU implementation.
> 2025-05-21T10:59:23.313291+00:00 mc-misc2002 kernel: [    2.424148] rcu: =
	Max phase no-delay instances is 1000.
> 2025-05-21T10:59:23.313296+00:00 mc-misc2002 kernel: [    2.431507] NMI w=
atchdog: Enabled. Permanently consumes one hw-PMU counter.
> 2025-05-21T10:59:23.313297+00:00 mc-misc2002 kernel: [    2.432638] smp: =
Bringing up secondary CPUs ...
> 2025-05-21T10:59:23.313297+00:00 mc-misc2002 kernel: [    2.436248] x86: =
Booting SMP configuration:
> 2025-05-21T10:59:23.313300+00:00 mc-misc2002 kernel: [    2.440151] .... =
node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11
> 2025-05-21T10:59:23.313301+00:00 mc-misc2002 kernel: [    2.552149] .... =
node  #1, CPUs:   #12
> 2025-05-21T10:59:23.313301+00:00 mc-misc2002 kernel: [    1.688672] smpbo=
ot: CPU 12 Converting physical 0 to logical die 1
> 2025-05-21T10:59:23.313302+00:00 mc-misc2002 kernel: [    2.698290]  #13 =
#14 #15 #16 #17 #18 #19 #20 #21 #22 #23
> 2025-05-21T10:59:23.313306+00:00 mc-misc2002 kernel: [    2.904148] .... =
node  #0, CPUs:   #24
> 2025-05-21T10:59:23.313307+00:00 mc-misc2002 kernel: [    2.906495] MMIO =
Stale Data CPU bug present and SMT on, data leak possible. See https://www.=
kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.ht=
ml for more details.
> 2025-05-21T10:59:23.313308+00:00 mc-misc2002 kernel: [    2.912276]  #25 =
#26 #27 #28 #29 #30 #31 #32 #33 #34 #35
> 2025-05-21T10:59:23.313308+00:00 mc-misc2002 kernel: [    2.940150] .... =
node  #1, CPUs:   #36 #37 #38 #39 #40 #41 #42 #43 #44 #45 #46 #47
> 2025-05-21T10:59:23.313309+00:00 mc-misc2002 kernel: [    2.969101] smp: =
Brought up 2 nodes, 48 CPUs
> 2025-05-21T10:59:23.313309+00:00 mc-misc2002 kernel: [    2.976150] smpbo=
ot: Max logical packages: 2
> 2025-05-21T10:59:23.313316+00:00 mc-misc2002 kernel: [    2.980149] smpbo=
ot: Total of 48 processors activated (202169.96 BogoMIPS)
> 2025-05-21T10:59:23.313317+00:00 mc-misc2002 kernel: [    3.044198] node =
0 deferred pages initialised in 56ms
> 2025-05-21T10:59:23.313317+00:00 mc-misc2002 kernel: [    3.048160] node =
1 deferred pages initialised in 60ms
> 2025-05-21T10:59:23.313318+00:00 mc-misc2002 kernel: [    3.065542] devtm=
pfs: initialized
> 2025-05-21T10:59:23.313318+00:00 mc-misc2002 kernel: [    3.068230] x86/m=
m: Memory block size: 2048MB
> 2025-05-21T10:59:23.313319+00:00 mc-misc2002 kernel: [    3.073381] ACPI:=
 PM: Registering ACPI NVS region [mem 0x678ff000-0x67dfefff] (5242880 bytes)
> 2025-05-21T10:59:23.313324+00:00 mc-misc2002 kernel: [    3.076290] clock=
source: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645=
041785100000 ns
> 2025-05-21T10:59:23.313325+00:00 mc-misc2002 kernel: [    3.080314] futex=
 hash table entries: 16384 (order: 8, 1048576 bytes, vmalloc)
> 2025-05-21T10:59:23.313328+00:00 mc-misc2002 kernel: [    3.084319] pinct=
rl core: initialized pinctrl subsystem
> 2025-05-21T10:59:23.313328+00:00 mc-misc2002 kernel: [    3.089565] NET: =
Registered PF_NETLINK/PF_ROUTE protocol family
> 2025-05-21T10:59:23.313329+00:00 mc-misc2002 kernel: [    3.092947] DMA: =
preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
> 2025-05-21T10:59:23.313335+00:00 mc-misc2002 kernel: [    3.096629] DMA: =
preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> 2025-05-21T10:59:23.313340+00:00 mc-misc2002 kernel: [    3.100625] DMA: =
preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> 2025-05-21T10:59:23.313341+00:00 mc-misc2002 kernel: [    3.104159] audit=
: initializing netlink subsys (disabled)
> 2025-05-21T10:59:23.313341+00:00 mc-misc2002 kernel: [    3.108178] audit=
: type=3D2000 audit(1747825139.172:1): state=3Dinitialized audit_enabled=3D=
0 res=3D1
> 2025-05-21T10:59:23.313342+00:00 mc-misc2002 kernel: [    3.108323] therm=
al_sys: Registered thermal governor 'fair_share'
> 2025-05-21T10:59:23.313342+00:00 mc-misc2002 kernel: [    3.112149] therm=
al_sys: Registered thermal governor 'bang_bang'
> 2025-05-21T10:59:23.313342+00:00 mc-misc2002 kernel: [    3.116149] therm=
al_sys: Registered thermal governor 'step_wise'
> 2025-05-21T10:59:23.313343+00:00 mc-misc2002 kernel: [    3.120148] therm=
al_sys: Registered thermal governor 'user_space'
> 2025-05-21T10:59:23.313350+00:00 mc-misc2002 kernel: [    3.124148] therm=
al_sys: Registered thermal governor 'power_allocator'
> 2025-05-21T10:59:23.313351+00:00 mc-misc2002 kernel: [    3.128189] cpuid=
le: using governor ladder
> 2025-05-21T10:59:23.313352+00:00 mc-misc2002 kernel: [    3.140174] cpuid=
le: using governor menu
> 2025-05-21T10:59:23.313352+00:00 mc-misc2002 kernel: [    3.144185] ACPI =
FADT declares the system doesn't support PCIe ASPM, so disable it
> 2025-05-21T10:59:23.313352+00:00 mc-misc2002 kernel: [    3.148150] acpip=
hp: ACPI Hot Plug PCI Controller Driver version: 0.5
> 2025-05-21T10:59:23.313353+00:00 mc-misc2002 kernel: [    3.152253] PCI: =
MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0=
x80000000)
> 2025-05-21T10:59:23.313368+00:00 mc-misc2002 kernel: [    3.156151] PCI: =
MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
> 2025-05-21T10:59:23.313368+00:00 mc-misc2002 kernel: [    3.160161] pmd_s=
et_huge: Cannot satisfy [mem 0x80000000-0x80200000] with a huge-page mappin=
g due to MTRR override.
> 2025-05-21T10:59:23.313369+00:00 mc-misc2002 kernel: [    3.164415] PCI: =
Using configuration type 1 for base access
> 2025-05-21T10:59:23.313369+00:00 mc-misc2002 kernel: [    3.169276] ENERG=
Y_PERF_BIAS: Set to 'normal', was 'performance'
> 2025-05-21T10:59:23.313370+00:00 mc-misc2002 kernel: [    3.173053] kprob=
es: kprobe jump-optimization is enabled. All kprobes are optimized if possi=
ble.
> 2025-05-21T10:59:23.313370+00:00 mc-misc2002 kernel: [    3.184201] HugeT=
LB: registered 1.00 GiB page size, pre-allocated 0 pages
> 2025-05-21T10:59:23.313377+00:00 mc-misc2002 kernel: [    3.188148] HugeT=
LB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> 2025-05-21T10:59:23.313378+00:00 mc-misc2002 kernel: [    3.196148] HugeT=
LB: registered 2.00 MiB page size, pre-allocated 0 pages
> 2025-05-21T10:59:23.313385+00:00 mc-misc2002 kernel: [    3.204148] HugeT=
LB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> 2025-05-21T10:59:23.313390+00:00 mc-misc2002 kernel: [    3.212281] ACPI:=
 Added _OSI(Module Device)
> 2025-05-21T10:59:23.313392+00:00 mc-misc2002 kernel: [    3.216149] ACPI:=
 Added _OSI(Processor Device)
> 2025-05-21T10:59:23.313392+00:00 mc-misc2002 kernel: [    3.224148] ACPI:=
 Added _OSI(3.0 _SCP Extensions)
> 2025-05-21T10:59:23.313393+00:00 mc-misc2002 kernel: [    3.228149] ACPI:=
 Added _OSI(Processor Aggregator Device)
> 2025-05-21T10:59:23.313398+00:00 mc-misc2002 kernel: [    3.379528] ACPI:=
 7 ACPI AML tables successfully acquired and loaded
> 2025-05-21T10:59:23.313399+00:00 mc-misc2002 kernel: [    3.401609] ACPI:=
 Dynamic OEM Table Load:
> 2025-05-21T10:59:23.313400+00:00 mc-misc2002 kernel: [    3.538103] ACPI:=
 Dynamic OEM Table Load:
> 2025-05-21T10:59:23.313400+00:00 mc-misc2002 kernel: [    3.786711] ACPI:=
 Interpreter enabled
> 2025-05-21T10:59:23.313400+00:00 mc-misc2002 kernel: [    3.788173] ACPI:=
 PM: (supports S0 S5)
> 2025-05-21T10:59:23.313401+00:00 mc-misc2002 kernel: [    3.792148] ACPI:=
 Using IOAPIC for interrupt routing
> 2025-05-21T10:59:23.313407+00:00 mc-misc2002 kernel: [    3.800248] HEST:=
 Table parsing has been initialized.
> 2025-05-21T10:59:23.313407+00:00 mc-misc2002 kernel: [    3.804254] GHES:=
 APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
> 2025-05-21T10:59:23.313408+00:00 mc-misc2002 kernel: [    3.812150] PCI: =
Using host bridge windows from ACPI; if necessary, use "pci=3Dnocrs" and re=
port a bug
> 2025-05-21T10:59:23.313408+00:00 mc-misc2002 kernel: [    3.824148] PCI: =
Ignoring E820 reservations for host bridge windows
> 2025-05-21T10:59:23.313409+00:00 mc-misc2002 kernel: [    3.848678] ACPI:=
 Enabled 5 GPEs in block 00 to 7F
> 2025-05-21T10:59:23.313409+00:00 mc-misc2002 kernel: [    3.945186] ACPI:=
 PCI Root Bridge [PC00] (domain 0000 [bus 00-15])
> 2025-05-21T10:59:23.313414+00:00 mc-misc2002 kernel: [    3.952154] acpi =
PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:59:23.313416+00:00 mc-misc2002 kernel: [    3.964455] acpi =
PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T10:59:23.313417+00:00 mc-misc2002 kernel: [    3.972356] acpi =
PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T10:59:23.313417+00:00 mc-misc2002 kernel: [    3.980148] acpi =
PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:59:23.313418+00:00 mc-misc2002 kernel: [    3.988867] PCI h=
ost bridge to bus 0000:00
> 2025-05-21T10:59:23.313418+00:00 mc-misc2002 kernel: [    3.996149] pci_b=
us 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> 2025-05-21T10:59:23.313425+00:00 mc-misc2002 kernel: [    4.000148] pci_b=
us 0000:00: root bus resource [io  0x1000-0x4fff window]
> 2025-05-21T10:59:23.313426+00:00 mc-misc2002 kernel: [    4.008148] pci_b=
us 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> 2025-05-21T10:59:23.313426+00:00 mc-misc2002 kernel: [    4.016149] pci_b=
us 0000:00: root bus resource [mem 0x000c8000-0x000cffff window]
> 2025-05-21T10:59:23.313427+00:00 mc-misc2002 kernel: [    4.028148] pci_b=
us 0000:00: root bus resource [mem 0xfe010000-0xfe010fff window]
> 2025-05-21T10:59:23.313427+00:00 mc-misc2002 kernel: [    4.036148] pci_b=
us 0000:00: root bus resource [mem 0x90000000-0x9b7fffff window]
> 2025-05-21T10:59:23.313428+00:00 mc-misc2002 kernel: [    4.044148] pci_b=
us 0000:00: root bus resource [mem 0x200000000000-0x200fffffffff window]
> 2025-05-21T10:59:23.313428+00:00 mc-misc2002 kernel: [    4.052148] pci_b=
us 0000:00: root bus resource [bus 00-15]
> 2025-05-21T10:59:23.313433+00:00 mc-misc2002 kernel: [    4.060171] pci 0=
000:00:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:59:23.313434+00:00 mc-misc2002 kernel: [    4.064257] pci 0=
000:00:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:59:23.313435+00:00 mc-misc2002 kernel: [    4.072224] pci 0=
000:00:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:59:23.313435+00:00 mc-misc2002 kernel: [    4.080229] pci 0=
000:00:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:59:23.313436+00:00 mc-misc2002 kernel: [    4.084228] pci 0=
000:00:01.0: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313436+00:00 mc-misc2002 kernel: [    4.092158] pci 0=
000:00:01.0: reg 0x10: [mem 0x200ffff50000-0x200ffff53fff 64bit]
> 2025-05-21T10:59:23.313446+00:00 mc-misc2002 kernel: [    4.100252] pci 0=
000:00:01.1: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313447+00:00 mc-misc2002 kernel: [    4.108157] pci 0=
000:00:01.1: reg 0x10: [mem 0x200ffff4c000-0x200ffff4ffff 64bit]
> 2025-05-21T10:59:23.313448+00:00 mc-misc2002 kernel: [    4.116251] pci 0=
000:00:01.2: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313448+00:00 mc-misc2002 kernel: [    4.124157] pci 0=
000:00:01.2: reg 0x10: [mem 0x200ffff48000-0x200ffff4bfff 64bit]
> 2025-05-21T10:59:23.313450+00:00 mc-misc2002 kernel: [    4.132249] pci 0=
000:00:01.3: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313451+00:00 mc-misc2002 kernel: [    4.140158] pci 0=
000:00:01.3: reg 0x10: [mem 0x200ffff44000-0x200ffff47fff 64bit]
> 2025-05-21T10:59:23.313451+00:00 mc-misc2002 kernel: [    4.148248] pci 0=
000:00:01.4: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313470+00:00 mc-misc2002 kernel: [    4.152157] pci 0=
000:00:01.4: reg 0x10: [mem 0x200ffff40000-0x200ffff43fff 64bit]
> 2025-05-21T10:59:23.313472+00:00 mc-misc2002 kernel: [    4.160248] pci 0=
000:00:01.5: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313472+00:00 mc-misc2002 kernel: [    4.168157] pci 0=
000:00:01.5: reg 0x10: [mem 0x200ffff3c000-0x200ffff3ffff 64bit]
> 2025-05-21T10:59:23.313473+00:00 mc-misc2002 kernel: [    4.176244] pci 0=
000:00:01.6: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313473+00:00 mc-misc2002 kernel: [    4.184157] pci 0=
000:00:01.6: reg 0x10: [mem 0x200ffff38000-0x200ffff3bfff 64bit]
> 2025-05-21T10:59:23.313473+00:00 mc-misc2002 kernel: [    4.192249] pci 0=
000:00:01.7: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313478+00:00 mc-misc2002 kernel: [    4.200158] pci 0=
000:00:01.7: reg 0x10: [mem 0x200ffff34000-0x200ffff37fff 64bit]
> 2025-05-21T10:59:23.313479+00:00 mc-misc2002 kernel: [    4.208245] pci 0=
000:00:02.0: [8086:09a6] type 00 class 0x088000
> 2025-05-21T10:59:23.313480+00:00 mc-misc2002 kernel: [    4.216156] pci 0=
000:00:02.0: reg 0x10: [mem 0x9b388000-0x9b389fff]
> 2025-05-21T10:59:23.313480+00:00 mc-misc2002 kernel: [    4.220225] pci 0=
000:00:02.1: [8086:09a7] type 00 class 0x088000
> 2025-05-21T10:59:23.313480+00:00 mc-misc2002 kernel: [    4.228155] pci 0=
000:00:02.1: reg 0x10: [mem 0x9b300000-0x9b37ffff]
> 2025-05-21T10:59:23.313481+00:00 mc-misc2002 kernel: [    4.236152] pci 0=
000:00:02.1: reg 0x14: [mem 0x9b280000-0x9b2fffff]
> 2025-05-21T10:59:23.313486+00:00 mc-misc2002 kernel: [    4.244224] pci 0=
000:00:02.4: [8086:3456] type 00 class 0x130000
> 2025-05-21T10:59:23.313487+00:00 mc-misc2002 kernel: [    4.248157] pci 0=
000:00:02.4: reg 0x10: [mem 0x200fffe00000-0x200fffefffff 64bit]
> 2025-05-21T10:59:23.313487+00:00 mc-misc2002 kernel: [    4.256154] pci 0=
000:00:02.4: reg 0x18: [mem 0x200ffff30000-0x200ffff33fff 64bit]
> 2025-05-21T10:59:23.313488+00:00 mc-misc2002 kernel: [    4.264154] pci 0=
000:00:02.4: reg 0x20: [mem 0x200ffff00000-0x200ffff1ffff 64bit]
> 2025-05-21T10:59:23.313488+00:00 mc-misc2002 kernel: [    4.276240] pci 0=
000:00:11.0: [8086:a1ec] type 00 class 0xff0000
> 2025-05-21T10:59:23.313489+00:00 mc-misc2002 kernel: [    4.280149] pci 0=
000:00:11.0: device has non-compliant BARs; disabling IO/MEM decoding
> 2025-05-21T10:59:23.313489+00:00 mc-misc2002 kernel: [    4.292246] pci 0=
000:00:11.5: [8086:a1d2] type 00 class 0x010601
> 2025-05-21T10:59:23.313497+00:00 mc-misc2002 kernel: [    4.296160] pci 0=
000:00:11.5: reg 0x10: [mem 0x9b386000-0x9b387fff]
> 2025-05-21T10:59:23.313497+00:00 mc-misc2002 kernel: [    4.304154] pci 0=
000:00:11.5: reg 0x14: [mem 0x9b38b000-0x9b38b0ff]
> 2025-05-21T10:59:23.313498+00:00 mc-misc2002 kernel: [    4.312155] pci 0=
000:00:11.5: reg 0x18: [io  0x4070-0x4077]
> 2025-05-21T10:59:23.313498+00:00 mc-misc2002 kernel: [    4.316154] pci 0=
000:00:11.5: reg 0x1c: [io  0x4060-0x4063]
> 2025-05-21T10:59:23.313498+00:00 mc-misc2002 kernel: [    4.324155] pci 0=
000:00:11.5: reg 0x20: [io  0x4020-0x403f]
> 2025-05-21T10:59:23.313499+00:00 mc-misc2002 kernel: [    4.328154] pci 0=
000:00:11.5: reg 0x24: [mem 0x9b180000-0x9b1fffff]
> 2025-05-21T10:59:23.313504+00:00 mc-misc2002 kernel: [    4.336189] pci 0=
000:00:11.5: PME# supported from D3hot
> 2025-05-21T10:59:23.313504+00:00 mc-misc2002 kernel: [    4.344370] pci 0=
000:00:14.0: [8086:a1af] type 00 class 0x0c0330
> 2025-05-21T10:59:23.313505+00:00 mc-misc2002 kernel: [    4.348165] pci 0=
000:00:14.0: reg 0x10: [mem 0x200ffff20000-0x200ffff2ffff 64bit]
> 2025-05-21T10:59:23.313505+00:00 mc-misc2002 kernel: [    4.360213] pci 0=
000:00:14.0: PME# supported from D3hot D3cold
> 2025-05-21T10:59:23.313506+00:00 mc-misc2002 kernel: [    4.364378] pci 0=
000:00:14.2: [8086:a1b1] type 00 class 0x118000
> 2025-05-21T10:59:23.313506+00:00 mc-misc2002 kernel: [    4.372164] pci 0=
000:00:14.2: reg 0x10: [mem 0x200ffff57000-0x200ffff57fff 64bit]
> 2025-05-21T10:59:23.313507+00:00 mc-misc2002 kernel: [    4.380280] pci 0=
000:00:16.0: [8086:a1ba] type 00 class 0x078000
> 2025-05-21T10:59:23.313511+00:00 mc-misc2002 kernel: [    4.388171] pci 0=
000:00:16.0: reg 0x10: [mem 0x200ffff56000-0x200ffff56fff 64bit]
> 2025-05-21T10:59:23.313511+00:00 mc-misc2002 kernel: [    4.396234] pci 0=
000:00:16.0: PME# supported from D3hot
> 2025-05-21T10:59:23.313512+00:00 mc-misc2002 kernel: [    4.400216] pci 0=
000:00:16.1: [8086:a1bb] type 00 class 0x078000
> 2025-05-21T10:59:23.313512+00:00 mc-misc2002 kernel: [    4.408171] pci 0=
000:00:16.1: reg 0x10: [mem 0x200ffff55000-0x200ffff55fff 64bit]
> 2025-05-21T10:59:23.313512+00:00 mc-misc2002 kernel: [    4.416233] pci 0=
000:00:16.1: PME# supported from D3hot
> 2025-05-21T10:59:23.313513+00:00 mc-misc2002 kernel: [    4.424219] pci 0=
000:00:16.4: [8086:a1be] type 00 class 0x078000
> 2025-05-21T10:59:23.313517+00:00 mc-misc2002 kernel: [    4.428171] pci 0=
000:00:16.4: reg 0x10: [mem 0x200ffff54000-0x200ffff54fff 64bit]
> 2025-05-21T10:59:23.313518+00:00 mc-misc2002 kernel: [    4.436233] pci 0=
000:00:16.4: PME# supported from D3hot
> 2025-05-21T10:59:23.313518+00:00 mc-misc2002 kernel: [    4.444218] pci 0=
000:00:17.0: [8086:a182] type 00 class 0x010601
> 2025-05-21T10:59:23.313518+00:00 mc-misc2002 kernel: [    4.452161] pci 0=
000:00:17.0: reg 0x10: [mem 0x9b384000-0x9b385fff]
> 2025-05-21T10:59:23.313519+00:00 mc-misc2002 kernel: [    4.456154] pci 0=
000:00:17.0: reg 0x14: [mem 0x9b38a000-0x9b38a0ff]
> 2025-05-21T10:59:23.313519+00:00 mc-misc2002 kernel: [    4.464154] pci 0=
000:00:17.0: reg 0x18: [io  0x4050-0x4057]
> 2025-05-21T10:59:23.313524+00:00 mc-misc2002 kernel: [    4.472154] pci 0=
000:00:17.0: reg 0x1c: [io  0x4040-0x4043]
> 2025-05-21T10:59:23.313525+00:00 mc-misc2002 kernel: [    4.476154] pci 0=
000:00:17.0: reg 0x20: [io  0x4000-0x401f]
> 2025-05-21T10:59:23.313525+00:00 mc-misc2002 kernel: [    4.484154] pci 0=
000:00:17.0: reg 0x24: [mem 0x9b100000-0x9b17ffff]
> 2025-05-21T10:59:23.313525+00:00 mc-misc2002 kernel: [    4.492189] pci 0=
000:00:17.0: PME# supported from D3hot
> 2025-05-21T10:59:23.313526+00:00 mc-misc2002 kernel: [    4.496360] pci 0=
000:00:1c.0: [8086:a190] type 01 class 0x060400
> 2025-05-21T10:59:23.313526+00:00 mc-misc2002 kernel: [    4.504222] pci 0=
000:00:1c.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313527+00:00 mc-misc2002 kernel: [    4.512229] pci 0=
000:00:1c.4: [8086:a194] type 01 class 0x060400
> 2025-05-21T10:59:23.313531+00:00 mc-misc2002 kernel: [    4.516222] pci 0=
000:00:1c.4: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313531+00:00 mc-misc2002 kernel: [    4.524249] pci 0=
000:00:1c.5: [8086:a195] type 01 class 0x060400
> 2025-05-21T10:59:23.313532+00:00 mc-misc2002 kernel: [    4.532221] pci 0=
000:00:1c.5: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313532+00:00 mc-misc2002 kernel: [    4.536247] pci 0=
000:00:1f.0: [8086:a1cb] type 00 class 0x060100
> 2025-05-21T10:59:23.313533+00:00 mc-misc2002 kernel: [    4.544408] pci 0=
000:00:1f.2: [8086:a1a1] type 00 class 0x058000
> 2025-05-21T10:59:23.313533+00:00 mc-misc2002 kernel: [    4.552162] pci 0=
000:00:1f.2: reg 0x10: [mem 0x9b380000-0x9b383fff]
> 2025-05-21T10:59:23.313537+00:00 mc-misc2002 kernel: [    4.560375] pci 0=
000:00:1f.4: [8086:a1a3] type 00 class 0x0c0500
> 2025-05-21T10:59:23.313538+00:00 mc-misc2002 kernel: [    4.564167] pci 0=
000:00:1f.4: reg 0x10: [mem 0x00000000-0x000000ff 64bit]
> 2025-05-21T10:59:23.313538+00:00 mc-misc2002 kernel: [    4.572171] pci 0=
000:00:1f.4: reg 0x20: [io  0x0780-0x079f]
> 2025-05-21T10:59:23.313538+00:00 mc-misc2002 kernel: [    4.580222] pci 0=
000:00:1f.5: [8086:a1a4] type 00 class 0x0c8000
> 2025-05-21T10:59:23.313539+00:00 mc-misc2002 kernel: [    4.588162] pci 0=
000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
> 2025-05-21T10:59:23.313539+00:00 mc-misc2002 kernel: [    4.592286] pci 0=
000:00:1c.0: PCI bridge to [bus 01]
> 2025-05-21T10:59:23.313540+00:00 mc-misc2002 kernel: [    4.600202] pci 0=
000:00:1c.4: PCI bridge to [bus 02]
> 2025-05-21T10:59:23.313544+00:00 mc-misc2002 kernel: [    4.604214] pci 0=
000:03:00.0: [1a03:1150] type 01 class 0x060400
> 2025-05-21T10:59:23.313544+00:00 mc-misc2002 kernel: [    4.612204] pci 0=
000:03:00.0: enabling Extended Tags
> 2025-05-21T10:59:23.313545+00:00 mc-misc2002 kernel: [    4.616220] pci 0=
000:03:00.0: supports D1 D2
> 2025-05-21T10:59:23.313545+00:00 mc-misc2002 kernel: [    4.620148] pci 0=
000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> 2025-05-21T10:59:23.313546+00:00 mc-misc2002 kernel: [    4.628286] pci 0=
000:00:1c.5: PCI bridge to [bus 03-04]
> 2025-05-21T10:59:23.313546+00:00 mc-misc2002 kernel: [    4.636150] pci 0=
000:00:1c.5:   bridge window [io  0x3000-0x3fff]
> 2025-05-21T10:59:23.313550+00:00 mc-misc2002 kernel: [    4.644149] pci 0=
000:00:1c.5:   bridge window [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T10:59:23.313551+00:00 mc-misc2002 kernel: [    4.648188] pci_b=
us 0000:04: extended config space not accessible
> 2025-05-21T10:59:23.313551+00:00 mc-misc2002 kernel: [    4.656174] pci 0=
000:04:00.0: [1a03:2000] type 00 class 0x030000
> 2025-05-21T10:59:23.313551+00:00 mc-misc2002 kernel: [    4.664165] pci 0=
000:04:00.0: reg 0x10: [mem 0x9a000000-0x9affffff]
> 2025-05-21T10:59:23.313552+00:00 mc-misc2002 kernel: [    4.672157] pci 0=
000:04:00.0: reg 0x14: [mem 0x9b000000-0x9b03ffff]
> 2025-05-21T10:59:23.313552+00:00 mc-misc2002 kernel: [    4.676157] pci 0=
000:04:00.0: reg 0x18: [io  0x3000-0x307f]
> 2025-05-21T10:59:23.313556+00:00 mc-misc2002 kernel: [    4.684228] pci 0=
000:04:00.0: supports D1 D2
> 2025-05-21T10:59:23.313557+00:00 mc-misc2002 kernel: [    4.688148] pci 0=
000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> 2025-05-21T10:59:23.313557+00:00 mc-misc2002 kernel: [    4.696244] pci 0=
000:03:00.0: PCI bridge to [bus 04]
> 2025-05-21T10:59:23.313557+00:00 mc-misc2002 kernel: [    4.700153] pci 0=
000:03:00.0:   bridge window [io  0x3000-0x3fff]
> 2025-05-21T10:59:23.313558+00:00 mc-misc2002 kernel: [    4.708150] pci 0=
000:03:00.0:   bridge window [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T10:59:23.313558+00:00 mc-misc2002 kernel: [    4.716173] pci_b=
us 0000:00: on NUMA node 0
> 2025-05-21T10:59:23.313559+00:00 mc-misc2002 kernel: [    4.716872] ACPI:=
 PCI Root Bridge [PC01] (domain 0000 [bus 16-2f])
> 2025-05-21T10:59:23.313563+00:00 mc-misc2002 kernel: [    4.724150] acpi =
PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:59:23.313563+00:00 mc-misc2002 kernel: [    4.732749] acpi =
PNP0A08:01: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:59:23.313564+00:00 mc-misc2002 kernel: [    4.744635] acpi =
PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:59:23.313564+00:00 mc-misc2002 kernel: [    4.752152] acpi =
PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:59:23.313565+00:00 mc-misc2002 kernel: [    4.760282] PCI h=
ost bridge to bus 0000:16
> 2025-05-21T10:59:23.313565+00:00 mc-misc2002 kernel: [    4.768148] pci_b=
us 0000:16: root bus resource [io  0x5000-0x6fff window]
> 2025-05-21T10:59:23.313569+00:00 mc-misc2002 kernel: [    4.772148] pci_b=
us 0000:16: root bus resource [mem 0x9b800000-0xa63fffff window]
> 2025-05-21T10:59:23.313569+00:00 mc-misc2002 kernel: [    4.784148] pci_b=
us 0000:16: root bus resource [mem 0x201000000000-0x201fffffffff window]
> 2025-05-21T10:59:23.313570+00:00 mc-misc2002 kernel: [    4.792148] pci_b=
us 0000:16: root bus resource [bus 16-2f]
> 2025-05-21T10:59:23.313570+00:00 mc-misc2002 kernel: [    4.796158] pci 0=
000:16:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:59:23.313571+00:00 mc-misc2002 kernel: [    4.804220] pci 0=
000:16:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:59:23.313571+00:00 mc-misc2002 kernel: [    4.812216] pci 0=
000:16:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:59:23.313573+00:00 mc-misc2002 kernel: [    4.816220] pci 0=
000:16:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:59:23.313576+00:00 mc-misc2002 kernel: [    4.824228] pci_b=
us 0000:16: on NUMA node 0
> 2025-05-21T10:59:23.313576+00:00 mc-misc2002 kernel: [    4.824320] ACPI:=
 PCI Root Bridge [PC02] (domain 0000 [bus 30-49])
> 2025-05-21T10:59:23.313576+00:00 mc-misc2002 kernel: [    4.832149] acpi =
PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:59:23.313577+00:00 mc-misc2002 kernel: [    4.840919] acpi =
PNP0A08:02: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:59:23.313577+00:00 mc-misc2002 kernel: [    4.852401] acpi =
PNP0A08:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:59:23.313578+00:00 mc-misc2002 kernel: [    4.860148] acpi =
PNP0A08:02: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:59:23.313582+00:00 mc-misc2002 kernel: [    4.868269] PCI h=
ost bridge to bus 0000:30
> 2025-05-21T10:59:23.313582+00:00 mc-misc2002 kernel: [    4.872148] pci_b=
us 0000:30: root bus resource [io  0x7000-0x8fff window]
> 2025-05-21T10:59:23.313583+00:00 mc-misc2002 kernel: [    4.880148] pci_b=
us 0000:30: root bus resource [mem 0xa6400000-0xb0ffffff window]
> 2025-05-21T10:59:23.313583+00:00 mc-misc2002 kernel: [    4.888149] pci_b=
us 0000:30: root bus resource [mem 0x202000000000-0x202fffffffff window]
> 2025-05-21T10:59:23.313584+00:00 mc-misc2002 kernel: [    4.900148] pci_b=
us 0000:30: root bus resource [bus 30-49]
> 2025-05-21T10:59:23.313584+00:00 mc-misc2002 kernel: [    4.904157] pci 0=
000:30:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:59:23.313588+00:00 mc-misc2002 kernel: [    4.912216] pci 0=
000:30:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:59:23.313588+00:00 mc-misc2002 kernel: [    4.920214] pci 0=
000:30:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:59:23.313589+00:00 mc-misc2002 kernel: [    4.924221] pci 0=
000:30:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:59:23.313589+00:00 mc-misc2002 kernel: [    4.932223] pci_b=
us 0000:30: on NUMA node 0
> 2025-05-21T10:59:23.313590+00:00 mc-misc2002 kernel: [    4.932329] ACPI:=
 PCI Root Bridge [PC04] (domain 0000 [bus 4a-63])
> 2025-05-21T10:59:23.313590+00:00 mc-misc2002 kernel: [    4.940149] acpi =
PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:59:23.313594+00:00 mc-misc2002 kernel: [    4.949108] acpi =
PNP0A08:04: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:59:23.313594+00:00 mc-misc2002 kernel: [    4.960404] acpi =
PNP0A08:04: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:59:23.313595+00:00 mc-misc2002 kernel: [    4.968148] acpi =
PNP0A08:04: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:59:23.313595+00:00 mc-misc2002 kernel: [    4.976266] PCI h=
ost bridge to bus 0000:4a
> 2025-05-21T10:59:23.313596+00:00 mc-misc2002 kernel: [    4.980148] pci_b=
us 0000:4a: root bus resource [io  0x9000-0x9fff window]
> 2025-05-21T10:59:23.313596+00:00 mc-misc2002 kernel: [    4.988148] pci_b=
us 0000:4a: root bus resource [mem 0xb1000000-0xbbbfffff window]
> 2025-05-21T10:59:23.313597+00:00 mc-misc2002 kernel: [    4.996148] pci_b=
us 0000:4a: root bus resource [mem 0x203000000000-0x203fffffffff window]
> 2025-05-21T10:59:23.313602+00:00 mc-misc2002 kernel: [    5.008149] pci_b=
us 0000:4a: root bus resource [bus 4a-63]
> 2025-05-21T10:59:23.313603+00:00 mc-misc2002 kernel: [    5.012157] pci 0=
000:4a:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:59:23.313603+00:00 mc-misc2002 kernel: [    5.020217] pci 0=
000:4a:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:59:23.313603+00:00 mc-misc2002 kernel: [    5.028215] pci 0=
000:4a:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:59:23.313604+00:00 mc-misc2002 kernel: [    5.032219] pci 0=
000:4a:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:59:23.313604+00:00 mc-misc2002 kernel: [    5.040222] pci 0=
000:4a:05.0: [8086:347d] type 01 class 0x060400
> 2025-05-21T10:59:23.313608+00:00 mc-misc2002 kernel: [    5.048157] pci 0=
000:4a:05.0: reg 0x10: [mem 0x203ffff00000-0x203ffff1ffff 64bit]
> 2025-05-21T10:59:23.313609+00:00 mc-misc2002 kernel: [    5.056159] pci 0=
000:4a:05.0: enabling Extended Tags
> 2025-05-21T10:59:23.313609+00:00 mc-misc2002 kernel: [    5.060177] pci 0=
000:4a:05.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313609+00:00 mc-misc2002 kernel: [    5.068547] pci 0=
000:4b:00.0: [8086:1521] type 00 class 0x020000
> 2025-05-21T10:59:23.313610+00:00 mc-misc2002 kernel: [    5.076162] pci 0=
000:4b:00.0: reg 0x10: [mem 0xbba20000-0xbba3ffff]
> 2025-05-21T10:59:23.313610+00:00 mc-misc2002 kernel: [    5.084164] pci 0=
000:4b:00.0: reg 0x18: [io  0x9020-0x903f]
> 2025-05-21T10:59:23.313611+00:00 mc-misc2002 kernel: [    5.088154] pci 0=
000:4b:00.0: reg 0x1c: [mem 0xbba44000-0xbba47fff]
> 2025-05-21T10:59:23.313615+00:00 mc-misc2002 kernel: [    5.096230] pci 0=
000:4b:00.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313615+00:00 mc-misc2002 kernel: [    5.104175] pci 0=
000:4b:00.0: reg 0x184: [mem 0x203fffe60000-0x203fffe63fff 64bit pref]
> 2025-05-21T10:59:23.313616+00:00 mc-misc2002 kernel: [    5.112148] pci 0=
000:4b:00.0: VF(n) BAR0 space: [mem 0x203fffe60000-0x203fffe7ffff 64bit pre=
f] (contains BAR0 for 8 VFs)
> 2025-05-21T10:59:23.313616+00:00 mc-misc2002 kernel: [    5.124162] pci 0=
000:4b:00.0: reg 0x190: [mem 0x203fffe40000-0x203fffe43fff 64bit pref]
> 2025-05-21T10:59:23.313617+00:00 mc-misc2002 kernel: [    5.132148] pci 0=
000:4b:00.0: VF(n) BAR3 space: [mem 0x203fffe40000-0x203fffe5ffff 64bit pre=
f] (contains BAR3 for 8 VFs)
> 2025-05-21T10:59:23.313619+00:00 mc-misc2002 kernel: [    5.144331] pci 0=
000:4b:00.1: [8086:1521] type 00 class 0x020000
> 2025-05-21T10:59:23.313621+00:00 mc-misc2002 kernel: [    5.152160] pci 0=
000:4b:00.1: reg 0x10: [mem 0xbba00000-0xbba1ffff]
> 2025-05-21T10:59:23.313622+00:00 mc-misc2002 kernel: [    5.160160] pci 0=
000:4b:00.1: reg 0x18: [io  0x9000-0x901f]
> 2025-05-21T10:59:23.313622+00:00 mc-misc2002 kernel: [    5.164154] pci 0=
000:4b:00.1: reg 0x1c: [mem 0xbba40000-0xbba43fff]
> 2025-05-21T10:59:23.313623+00:00 mc-misc2002 kernel: [    5.172233] pci 0=
000:4b:00.1: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313623+00:00 mc-misc2002 kernel: [    5.180171] pci 0=
000:4b:00.1: reg 0x184: [mem 0x203fffe20000-0x203fffe23fff 64bit pref]
> 2025-05-21T10:59:23.313623+00:00 mc-misc2002 kernel: [    5.188148] pci 0=
000:4b:00.1: VF(n) BAR0 space: [mem 0x203fffe20000-0x203fffe3ffff 64bit pre=
f] (contains BAR0 for 8 VFs)
> 2025-05-21T10:59:23.313627+00:00 mc-misc2002 kernel: [    5.200161] pci 0=
000:4b:00.1: reg 0x190: [mem 0x203fffe00000-0x203fffe03fff 64bit pref]
> 2025-05-21T10:59:23.313628+00:00 mc-misc2002 kernel: [    5.208148] pci 0=
000:4b:00.1: VF(n) BAR3 space: [mem 0x203fffe00000-0x203fffe1ffff 64bit pre=
f] (contains BAR3 for 8 VFs)
> 2025-05-21T10:59:23.313628+00:00 mc-misc2002 kernel: [    5.220276] pci 0=
000:4a:05.0: PCI bridge to [bus 4b]
> 2025-05-21T10:59:23.313629+00:00 mc-misc2002 kernel: [    5.228149] pci 0=
000:4a:05.0:   bridge window [io  0x9000-0x9fff]
> 2025-05-21T10:59:23.313629+00:00 mc-misc2002 kernel: [    5.232149] pci 0=
000:4a:05.0:   bridge window [mem 0xbba00000-0xbbafffff]
> 2025-05-21T10:59:23.313630+00:00 mc-misc2002 kernel: [    5.240150] pci 0=
000:4a:05.0:   bridge window [mem 0x203fffe00000-0x203fffefffff 64bit pref]
> 2025-05-21T10:59:23.313634+00:00 mc-misc2002 kernel: [    5.252154] pci_b=
us 0000:4a: on NUMA node 0
> 2025-05-21T10:59:23.313634+00:00 mc-misc2002 kernel: [    5.252263] ACPI:=
 PCI Root Bridge [PC05] (domain 0000 [bus 64-7d])
> 2025-05-21T10:59:23.313635+00:00 mc-misc2002 kernel: [    5.260149] acpi =
PNP0A08:05: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:59:23.313635+00:00 mc-misc2002 kernel: [    5.269562] acpi =
PNP0A08:05: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:59:23.313635+00:00 mc-misc2002 kernel: [    5.276632] acpi =
PNP0A08:05: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:59:23.313636+00:00 mc-misc2002 kernel: [    5.288148] acpi =
PNP0A08:05: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:59:23.313640+00:00 mc-misc2002 kernel: [    5.296272] PCI h=
ost bridge to bus 0000:64
> 2025-05-21T10:59:23.313640+00:00 mc-misc2002 kernel: [    5.300148] pci_b=
us 0000:64: root bus resource [io  0xa000-0xafff window]
> 2025-05-21T10:59:23.313641+00:00 mc-misc2002 kernel: [    5.308149] pci_b=
us 0000:64: root bus resource [mem 0xbbc00000-0xc5ffffff window]
> 2025-05-21T10:59:23.313641+00:00 mc-misc2002 kernel: [    5.316149] pci_b=
us 0000:64: root bus resource [mem 0x204000000000-0x204fffffffff window]
> 2025-05-21T10:59:23.313641+00:00 mc-misc2002 kernel: [    5.328148] pci_b=
us 0000:64: root bus resource [bus 64-7d]
> 2025-05-21T10:59:23.313642+00:00 mc-misc2002 kernel: [    5.332157] pci 0=
000:64:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:59:23.313646+00:00 mc-misc2002 kernel: [    5.340221] pci 0=
000:64:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:59:23.313646+00:00 mc-misc2002 kernel: [    5.344216] pci 0=
000:64:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:59:23.313647+00:00 mc-misc2002 kernel: [    5.352217] pci 0=
000:64:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:59:23.313647+00:00 mc-misc2002 kernel: [    5.360222] pci 0=
000:64:02.0: [8086:347a] type 01 class 0x060400
> 2025-05-21T10:59:23.313648+00:00 mc-misc2002 kernel: [    5.368157] pci 0=
000:64:02.0: reg 0x10: [mem 0x204ffff60000-0x204ffff7ffff 64bit]
> 2025-05-21T10:59:23.313648+00:00 mc-misc2002 kernel: [    5.376190] pci 0=
000:64:02.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313648+00:00 mc-misc2002 kernel: [    5.380391] pci 0=
000:64:03.0: [8086:347b] type 01 class 0x060400
> 2025-05-21T10:59:23.313653+00:00 mc-misc2002 kernel: [    5.388160] pci 0=
000:64:03.0: reg 0x10: [mem 0x204ffff40000-0x204ffff5ffff 64bit]
> 2025-05-21T10:59:23.313653+00:00 mc-misc2002 kernel: [    5.396164] pci 0=
000:64:03.0: enabling Extended Tags
> 2025-05-21T10:59:23.313654+00:00 mc-misc2002 kernel: [    5.404207] pci 0=
000:64:03.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313654+00:00 mc-misc2002 kernel: [    5.408384] pci 0=
000:64:04.0: [8086:347c] type 01 class 0x060400
> 2025-05-21T10:59:23.313654+00:00 mc-misc2002 kernel: [    5.416158] pci 0=
000:64:04.0: reg 0x10: [mem 0x204ffff20000-0x204ffff3ffff 64bit]
> 2025-05-21T10:59:23.313655+00:00 mc-misc2002 kernel: [    5.424160] pci 0=
000:64:04.0: enabling Extended Tags
> 2025-05-21T10:59:23.313659+00:00 mc-misc2002 kernel: [    5.432179] pci 0=
000:64:04.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313659+00:00 mc-misc2002 kernel: [    5.436385] pci 0=
000:64:05.0: [8086:347d] type 01 class 0x060400
> 2025-05-21T10:59:23.313660+00:00 mc-misc2002 kernel: [    5.444158] pci 0=
000:64:05.0: reg 0x10: [mem 0x204ffff00000-0x204ffff1ffff 64bit]
> 2025-05-21T10:59:23.313660+00:00 mc-misc2002 kernel: [    5.452159] pci 0=
000:64:05.0: enabling Extended Tags
> 2025-05-21T10:59:23.313660+00:00 mc-misc2002 kernel: [    5.460185] pci 0=
000:64:05.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313661+00:00 mc-misc2002 kernel: [    5.464518] pci 0=
000:65:00.0: [1344:51c4] type 00 class 0x010802
> 2025-05-21T10:59:23.313661+00:00 mc-misc2002 kernel: [    5.472161] pci 0=
000:65:00.0: reg 0x10: [mem 0xc5e40000-0xc5e7ffff 64bit]
> 2025-05-21T10:59:23.313665+00:00 mc-misc2002 kernel: [    5.480172] pci 0=
000:65:00.0: reg 0x30: [mem 0xc5e00000-0xc5e3ffff pref]
> 2025-05-21T10:59:23.313666+00:00 mc-misc2002 kernel: [    5.488195] pci 0=
000:65:00.0: PME# supported from D0 D1 D3hot
> 2025-05-21T10:59:23.313666+00:00 mc-misc2002 kernel: [    5.492238] pci 0=
000:64:02.0: PCI bridge to [bus 65]
> 2025-05-21T10:59:23.313667+00:00 mc-misc2002 kernel: [    5.500151] pci 0=
000:64:02.0:   bridge window [mem 0xc5e00000-0xc5efffff]
> 2025-05-21T10:59:23.313667+00:00 mc-misc2002 kernel: [    5.508273] pci 0=
000:64:03.0: PCI bridge to [bus 66]
> 2025-05-21T10:59:23.313667+00:00 mc-misc2002 kernel: [    5.512150] pci 0=
000:64:03.0:   bridge window [mem 0xc5d00000-0xc5dfffff]
> 2025-05-21T10:59:23.313671+00:00 mc-misc2002 kernel: [    5.520272] pci 0=
000:64:04.0: PCI bridge to [bus 67]
> 2025-05-21T10:59:23.313672+00:00 mc-misc2002 kernel: [    5.528150] pci 0=
000:64:04.0:   bridge window [mem 0xc5c00000-0xc5cfffff]
> 2025-05-21T10:59:23.313672+00:00 mc-misc2002 kernel: [    5.532271] pci 0=
000:64:05.0: PCI bridge to [bus 68]
> 2025-05-21T10:59:23.313673+00:00 mc-misc2002 kernel: [    5.540150] pci 0=
000:64:05.0:   bridge window [mem 0xc5b00000-0xc5bfffff]
> 2025-05-21T10:59:23.313673+00:00 mc-misc2002 kernel: [    5.548165] pci_b=
us 0000:64: on NUMA node 0
> 2025-05-21T10:59:23.313673+00:00 mc-misc2002 kernel: [    5.548259] ACPI:=
 PCI Root Bridge [UC06] (domain 0000 [bus 7e])
> 2025-05-21T10:59:23.313678+00:00 mc-misc2002 kernel: [    5.552149] acpi =
PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:59:23.313678+00:00 mc-misc2002 kernel: [    5.564219] acpi =
PNP0A08:06: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T10:59:23.313679+00:00 mc-misc2002 kernel: [    5.572270] acpi =
PNP0A08:06: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T10:59:23.313679+00:00 mc-misc2002 kernel: [    5.580148] acpi =
PNP0A08:06: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:59:23.313680+00:00 mc-misc2002 kernel: [    5.592257] PCI h=
ost bridge to bus 0000:7e
> 2025-05-21T10:59:23.313680+00:00 mc-misc2002 kernel: [    5.596148] pci_b=
us 0000:7e: root bus resource [bus 7e]
> 2025-05-21T10:59:23.313680+00:00 mc-misc2002 kernel: [    5.600157] pci 0=
000:7e:00.0: [8086:3450] type 00 class 0x088000
> 2025-05-21T10:59:23.313684+00:00 mc-misc2002 kernel: [    5.608223] pci 0=
000:7e:00.1: [8086:3451] type 00 class 0x088000
> 2025-05-21T10:59:23.313685+00:00 mc-misc2002 kernel: [    5.616208] pci 0=
000:7e:00.2: [8086:3452] type 00 class 0x088000
> 2025-05-21T10:59:23.313685+00:00 mc-misc2002 kernel: [    5.620205] pci 0=
000:7e:00.3: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:59:23.313686+00:00 mc-misc2002 kernel: [    5.628216] pci 0=
000:7e:00.5: [8086:3455] type 00 class 0x088000
> 2025-05-21T10:59:23.313686+00:00 mc-misc2002 kernel: [    5.636214] pci 0=
000:7e:02.0: [8086:3440] type 00 class 0x088000
> 2025-05-21T10:59:23.313686+00:00 mc-misc2002 kernel: [    5.640287] pci 0=
000:7e:02.1: [8086:3441] type 00 class 0x088000
> 2025-05-21T10:59:23.313690+00:00 mc-misc2002 kernel: [    5.648263] pci 0=
000:7e:02.2: [8086:3442] type 00 class 0x088000
> 2025-05-21T10:59:23.313691+00:00 mc-misc2002 kernel: [    5.656268] pci 0=
000:7e:04.0: [8086:3440] type 00 class 0x088000
> 2025-05-21T10:59:23.313691+00:00 mc-misc2002 kernel: [    5.664276] pci 0=
000:7e:04.1: [8086:3441] type 00 class 0x088000
> 2025-05-21T10:59:23.313692+00:00 mc-misc2002 kernel: [    5.668271] pci 0=
000:7e:04.2: [8086:3442] type 00 class 0x088000
> 2025-05-21T10:59:23.313692+00:00 mc-misc2002 kernel: [    5.676271] pci 0=
000:7e:04.3: [8086:3443] type 00 class 0x088000
> 2025-05-21T10:59:23.313692+00:00 mc-misc2002 kernel: [    5.684274] pci 0=
000:7e:05.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T10:59:23.313694+00:00 mc-misc2002 kernel: [    5.688282] pci 0=
000:7e:05.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T10:59:23.313698+00:00 mc-misc2002 kernel: [    5.696270] pci 0=
000:7e:05.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T10:59:23.313699+00:00 mc-misc2002 kernel: [    5.704266] pci 0=
000:7e:06.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T10:59:23.313699+00:00 mc-misc2002 kernel: [    5.712245] pci 0=
000:7e:06.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T10:59:23.313699+00:00 mc-misc2002 kernel: [    5.716230] pci 0=
000:7e:06.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T10:59:23.313700+00:00 mc-misc2002 kernel: [    5.724239] pci 0=
000:7e:07.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T10:59:23.313700+00:00 mc-misc2002 kernel: [    5.732289] pci 0=
000:7e:07.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T10:59:23.313704+00:00 mc-misc2002 kernel: [    5.736275] pci 0=
000:7e:07.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T10:59:23.313705+00:00 mc-misc2002 kernel: [    5.744276] pci 0=
000:7e:0b.0: [8086:3448] type 00 class 0x088000
> 2025-05-21T10:59:23.313705+00:00 mc-misc2002 kernel: [    5.752234] pci 0=
000:7e:0b.1: [8086:3448] type 00 class 0x088000
> 2025-05-21T10:59:23.313706+00:00 mc-misc2002 kernel: [    5.760212] pci 0=
000:7e:0b.2: [8086:344b] type 00 class 0x088000
> 2025-05-21T10:59:23.313706+00:00 mc-misc2002 kernel: [    5.764219] pci 0=
000:7e:0c.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:59:23.313707+00:00 mc-misc2002 kernel: [    5.772258] pci 0=
000:7e:0d.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:59:23.313710+00:00 mc-misc2002 kernel: [    5.780251] pci 0=
000:7e:0e.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:59:23.313711+00:00 mc-misc2002 kernel: [    5.784289] pci 0=
000:7e:0f.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:59:23.313711+00:00 mc-misc2002 kernel: [    5.792304] pci 0=
000:7e:1a.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:59:23.313712+00:00 mc-misc2002 kernel: [    5.800255] pci 0=
000:7e:1b.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:59:23.313712+00:00 mc-misc2002 kernel: [    5.808253] pci 0=
000:7e:1c.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:59:23.313713+00:00 mc-misc2002 kernel: [    5.812298] pci 0=
000:7e:1d.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:59:23.313713+00:00 mc-misc2002 kernel: [    5.820294] pci_b=
us 0000:7e: on NUMA node 0
> 2025-05-21T10:59:23.313717+00:00 mc-misc2002 kernel: [    5.820367] ACPI:=
 PCI Root Bridge [UC07] (domain 0000 [bus 7f])
> 2025-05-21T10:59:23.313717+00:00 mc-misc2002 kernel: [    5.828150] acpi =
PNP0A08:07: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:59:23.313718+00:00 mc-misc2002 kernel: [    5.836216] acpi =
PNP0A08:07: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T10:59:23.313718+00:00 mc-misc2002 kernel: [    5.844267] acpi =
PNP0A08:07: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T10:59:23.313719+00:00 mc-misc2002 kernel: [    5.856148] acpi =
PNP0A08:07: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:59:23.313719+00:00 mc-misc2002 kernel: [    5.864266] PCI h=
ost bridge to bus 0000:7f
> 2025-05-21T10:59:23.313723+00:00 mc-misc2002 kernel: [    5.868148] pci_b=
us 0000:7f: root bus resource [bus 7f]
> 2025-05-21T10:59:23.313724+00:00 mc-misc2002 kernel: [    5.876163] pci 0=
000:7f:00.0: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.313724+00:00 mc-misc2002 kernel: [    5.880268] pci 0=
000:7f:00.1: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.313725+00:00 mc-misc2002 kernel: [    5.888263] pci 0=
000:7f:00.2: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.313725+00:00 mc-misc2002 kernel: [    5.896248] pci 0=
000:7f:00.3: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.313726+00:00 mc-misc2002 kernel: [    5.900272] pci 0=
000:7f:00.4: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.313730+00:00 mc-misc2002 kernel: [    5.908271] pci 0=
000:7f:00.5: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.313730+00:00 mc-misc2002 kernel: [    5.916244] pci 0=
000:7f:00.6: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.313731+00:00 mc-misc2002 kernel: [    5.920274] pci 0=
000:7f:00.7: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.313731+00:00 mc-misc2002 kernel: [    5.928282] pci 0=
000:7f:01.0: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.313732+00:00 mc-misc2002 kernel: [    5.936294] pci 0=
000:7f:01.1: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.313732+00:00 mc-misc2002 kernel: [    5.944283] pci 0=
000:7f:01.2: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.313732+00:00 mc-misc2002 kernel: [    5.948293] pci 0=
000:7f:01.3: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.313737+00:00 mc-misc2002 kernel: [    5.956300] pci 0=
000:7f:0a.0: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.313737+00:00 mc-misc2002 kernel: [    5.964273] pci 0=
000:7f:0a.1: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.313738+00:00 mc-misc2002 kernel: [    5.972270] pci 0=
000:7f:0a.2: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.313738+00:00 mc-misc2002 kernel: [    5.976249] pci 0=
000:7f:0a.3: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.313739+00:00 mc-misc2002 kernel: [    5.984271] pci 0=
000:7f:0a.4: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.313739+00:00 mc-misc2002 kernel: [    5.992271] pci 0=
000:7f:0a.5: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.313743+00:00 mc-misc2002 kernel: [    5.996237] pci 0=
000:7f:0a.6: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.313744+00:00 mc-misc2002 kernel: [    6.004273] pci 0=
000:7f:0a.7: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.313744+00:00 mc-misc2002 kernel: [    6.012278] pci 0=
000:7f:0b.0: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.313744+00:00 mc-misc2002 kernel: [    6.020294] pci 0=
000:7f:0b.1: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.313745+00:00 mc-misc2002 kernel: [    6.024291] pci 0=
000:7f:0b.2: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.313745+00:00 mc-misc2002 kernel: [    6.032293] pci 0=
000:7f:0b.3: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.313746+00:00 mc-misc2002 kernel: [    6.040308] pci 0=
000:7f:1d.0: [8086:344f] type 00 class 0x088000
> 2025-05-21T10:59:23.313750+00:00 mc-misc2002 kernel: [    6.044275] pci 0=
000:7f:1d.1: [8086:3457] type 00 class 0x088000
> 2025-05-21T10:59:23.313750+00:00 mc-misc2002 kernel: [    6.052259] pci 0=
000:7f:1e.0: [8086:3458] type 00 class 0x088000
> 2025-05-21T10:59:23.313751+00:00 mc-misc2002 kernel: [    6.060228] pci 0=
000:7f:1e.1: [8086:3459] type 00 class 0x088000
> 2025-05-21T10:59:23.313751+00:00 mc-misc2002 kernel: [    6.068213] pci 0=
000:7f:1e.2: [8086:345a] type 00 class 0x088000
> 2025-05-21T10:59:23.313751+00:00 mc-misc2002 kernel: [    6.072211] pci 0=
000:7f:1e.3: [8086:345b] type 00 class 0x088000
> 2025-05-21T10:59:23.313752+00:00 mc-misc2002 kernel: [    6.080215] pci 0=
000:7f:1e.4: [8086:345c] type 00 class 0x088000
> 2025-05-21T10:59:23.313756+00:00 mc-misc2002 kernel: [    6.088211] pci 0=
000:7f:1e.5: [8086:345d] type 00 class 0x088000
> 2025-05-21T10:59:23.313756+00:00 mc-misc2002 kernel: [    6.092210] pci 0=
000:7f:1e.6: [8086:345e] type 00 class 0x088000
> 2025-05-21T10:59:23.313757+00:00 mc-misc2002 kernel: [    6.100212] pci 0=
000:7f:1e.7: [8086:345f] type 00 class 0x088000
> 2025-05-21T10:59:23.313757+00:00 mc-misc2002 kernel: [    6.108207] pci_b=
us 0000:7f: on NUMA node 0
> 2025-05-21T10:59:23.313758+00:00 mc-misc2002 kernel: [    6.108283] ACPI:=
 PCI Root Bridge [PC06] (domain 0000 [bus 80-96])
> 2025-05-21T10:59:23.313758+00:00 mc-misc2002 kernel: [    6.116149] acpi =
PNP0A08:08: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:59:23.313771+00:00 mc-misc2002 kernel: [    6.124709] acpi =
PNP0A08:08: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:59:23.313772+00:00 mc-misc2002 kernel: [    6.132343] acpi =
PNP0A08:08: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:59:23.313773+00:00 mc-misc2002 kernel: [    6.144148] acpi =
PNP0A08:08: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:59:23.313773+00:00 mc-misc2002 kernel: [    6.152266] PCI h=
ost bridge to bus 0000:80
> 2025-05-21T10:59:23.313773+00:00 mc-misc2002 kernel: [    6.156148] pci_b=
us 0000:80: root bus resource [io  0xb000-0xbfff window]
> 2025-05-21T10:59:23.313774+00:00 mc-misc2002 kernel: [    6.164148] pci_b=
us 0000:80: root bus resource [mem 0xc6800000-0xd0ffffff window]
> 2025-05-21T10:59:23.313774+00:00 mc-misc2002 kernel: [    6.172149] pci_b=
us 0000:80: root bus resource [mem 0x205000000000-0x205fffffffff window]
> 2025-05-21T10:59:23.313796+00:00 mc-misc2002 kernel: [    6.180148] pci_b=
us 0000:80: root bus resource [bus 80-96]
> 2025-05-21T10:59:23.313797+00:00 mc-misc2002 kernel: [    6.188159] pci 0=
000:80:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:59:23.313797+00:00 mc-misc2002 kernel: [    6.196238] pci 0=
000:80:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:59:23.313798+00:00 mc-misc2002 kernel: [    6.200222] pci 0=
000:80:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:59:23.313798+00:00 mc-misc2002 kernel: [    6.208225] pci 0=
000:80:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:59:23.313798+00:00 mc-misc2002 kernel: [    6.216229] pci 0=
000:80:01.0: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313807+00:00 mc-misc2002 kernel: [    6.220158] pci 0=
000:80:01.0: reg 0x10: [mem 0x205ffff40000-0x205ffff43fff 64bit]
> 2025-05-21T10:59:23.313808+00:00 mc-misc2002 kernel: [    6.228252] pci 0=
000:80:01.1: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313808+00:00 mc-misc2002 kernel: [    6.236158] pci 0=
000:80:01.1: reg 0x10: [mem 0x205ffff3c000-0x205ffff3ffff 64bit]
> 2025-05-21T10:59:23.313808+00:00 mc-misc2002 kernel: [    6.244249] pci 0=
000:80:01.2: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313809+00:00 mc-misc2002 kernel: [    6.252159] pci 0=
000:80:01.2: reg 0x10: [mem 0x205ffff38000-0x205ffff3bfff 64bit]
> 2025-05-21T10:59:23.313809+00:00 mc-misc2002 kernel: [    6.260249] pci 0=
000:80:01.3: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313814+00:00 mc-misc2002 kernel: [    6.268158] pci 0=
000:80:01.3: reg 0x10: [mem 0x205ffff34000-0x205ffff37fff 64bit]
> 2025-05-21T10:59:23.313815+00:00 mc-misc2002 kernel: [    6.276252] pci 0=
000:80:01.4: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313815+00:00 mc-misc2002 kernel: [    6.284158] pci 0=
000:80:01.4: reg 0x10: [mem 0x205ffff30000-0x205ffff33fff 64bit]
> 2025-05-21T10:59:23.313816+00:00 mc-misc2002 kernel: [    6.292251] pci 0=
000:80:01.5: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313816+00:00 mc-misc2002 kernel: [    6.296158] pci 0=
000:80:01.5: reg 0x10: [mem 0x205ffff2c000-0x205ffff2ffff 64bit]
> 2025-05-21T10:59:23.313816+00:00 mc-misc2002 kernel: [    6.304248] pci 0=
000:80:01.6: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313817+00:00 mc-misc2002 kernel: [    6.312159] pci 0=
000:80:01.6: reg 0x10: [mem 0x205ffff28000-0x205ffff2bfff 64bit]
> 2025-05-21T10:59:23.313821+00:00 mc-misc2002 kernel: [    6.320248] pci 0=
000:80:01.7: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:59:23.313821+00:00 mc-misc2002 kernel: [    6.328158] pci 0=
000:80:01.7: reg 0x10: [mem 0x205ffff24000-0x205ffff27fff 64bit]
> 2025-05-21T10:59:23.313822+00:00 mc-misc2002 kernel: [    6.336252] pci 0=
000:80:02.0: [8086:09a6] type 00 class 0x088000
> 2025-05-21T10:59:23.313822+00:00 mc-misc2002 kernel: [    6.344156] pci 0=
000:80:02.0: reg 0x10: [mem 0xd0f80000-0xd0f81fff]
> 2025-05-21T10:59:23.313823+00:00 mc-misc2002 kernel: [    6.352210] pci 0=
000:80:02.1: [8086:09a7] type 00 class 0x088000
> 2025-05-21T10:59:23.313823+00:00 mc-misc2002 kernel: [    6.356156] pci 0=
000:80:02.1: reg 0x10: [mem 0xd0f00000-0xd0f7ffff]
> 2025-05-21T10:59:23.313829+00:00 mc-misc2002 kernel: [    6.364152] pci 0=
000:80:02.1: reg 0x14: [mem 0xd0e80000-0xd0efffff]
> 2025-05-21T10:59:23.313829+00:00 mc-misc2002 kernel: [    6.372208] pci 0=
000:80:02.4: [8086:3456] type 00 class 0x130000
> 2025-05-21T10:59:23.313830+00:00 mc-misc2002 kernel: [    6.376158] pci 0=
000:80:02.4: reg 0x10: [mem 0x205fffe00000-0x205fffefffff 64bit]
> 2025-05-21T10:59:23.313830+00:00 mc-misc2002 kernel: [    6.388155] pci 0=
000:80:02.4: reg 0x18: [mem 0x205ffff20000-0x205ffff23fff 64bit]
> 2025-05-21T10:59:23.313831+00:00 mc-misc2002 kernel: [    6.396155] pci 0=
000:80:02.4: reg 0x20: [mem 0x205ffff00000-0x205ffff1ffff 64bit]
> 2025-05-21T10:59:23.313831+00:00 mc-misc2002 kernel: [    6.404219] pci_b=
us 0000:80: on NUMA node 1
> 2025-05-21T10:59:23.313831+00:00 mc-misc2002 kernel: [    6.404286] ACPI:=
 PCI Root Bridge [PC07] (domain 0000 [bus 97-af])
> 2025-05-21T10:59:23.313836+00:00 mc-misc2002 kernel: [    6.412149] acpi =
PNP0A08:09: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:59:23.313836+00:00 mc-misc2002 kernel: [    6.421099] acpi =
PNP0A08:09: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:59:23.313837+00:00 mc-misc2002 kernel: [    6.428404] acpi =
PNP0A08:09: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:59:23.313837+00:00 mc-misc2002 kernel: [    6.440149] acpi =
PNP0A08:09: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:59:23.313838+00:00 mc-misc2002 kernel: [    6.448268] PCI h=
ost bridge to bus 0000:97
> 2025-05-21T10:59:23.313838+00:00 mc-misc2002 kernel: [    6.452148] pci_b=
us 0000:97: root bus resource [io  0xc000-0xcfff window]
> 2025-05-21T10:59:23.313842+00:00 mc-misc2002 kernel: [    6.460149] pci_b=
us 0000:97: root bus resource [mem 0xd1000000-0xdbbfffff window]
> 2025-05-21T10:59:23.313843+00:00 mc-misc2002 kernel: [    6.468148] pci_b=
us 0000:97: root bus resource [mem 0x206000000000-0x206fffffffff window]
> 2025-05-21T10:59:23.313843+00:00 mc-misc2002 kernel: [    6.476148] pci_b=
us 0000:97: root bus resource [bus 97-af]
> 2025-05-21T10:59:23.313844+00:00 mc-misc2002 kernel: [    6.484165] pci 0=
000:97:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:59:23.313844+00:00 mc-misc2002 kernel: [    6.492226] pci 0=
000:97:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:59:23.313844+00:00 mc-misc2002 kernel: [    6.496233] pci 0=
000:97:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:59:23.313848+00:00 mc-misc2002 kernel: [    6.504223] pci 0=
000:97:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:59:23.313849+00:00 mc-misc2002 kernel: [    6.512228] pci 0=
000:97:04.0: [8086:347c] type 01 class 0x060400
> 2025-05-21T10:59:23.313849+00:00 mc-misc2002 kernel: [    6.516158] pci 0=
000:97:04.0: reg 0x10: [mem 0x206ffff00000-0x206ffff1ffff 64bit]
> 2025-05-21T10:59:23.313850+00:00 mc-misc2002 kernel: [    6.528194] pci 0=
000:97:04.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313850+00:00 mc-misc2002 kernel: [    6.532543] acpip=
hp: Slot [0-2] registered
> 2025-05-21T10:59:23.313850+00:00 mc-misc2002 kernel: [    6.540183] pci 0=
000:98:00.0: [14e4:16d7] type 00 class 0x020000
> 2025-05-21T10:59:23.313851+00:00 mc-misc2002 kernel: [    6.544164] pci 0=
000:98:00.0: reg 0x10: [mem 0x206fffe10000-0x206fffe1ffff 64bit pref]
> 2025-05-21T10:59:23.313855+00:00 mc-misc2002 kernel: [    6.552158] pci 0=
000:98:00.0: reg 0x18: [mem 0x206fffd00000-0x206fffdfffff 64bit pref]
> 2025-05-21T10:59:23.313856+00:00 mc-misc2002 kernel: [    6.564159] pci 0=
000:98:00.0: reg 0x20: [mem 0x206fffe22000-0x206fffe23fff 64bit pref]
> 2025-05-21T10:59:23.313856+00:00 mc-misc2002 kernel: [    6.572154] pci 0=
000:98:00.0: reg 0x30: [mem 0xdba40000-0xdba7ffff pref]
> 2025-05-21T10:59:23.313856+00:00 mc-misc2002 kernel: [    6.580229] pci 0=
000:98:00.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313857+00:00 mc-misc2002 kernel: [    6.588331] pci 0=
000:98:00.1: [14e4:16d7] type 00 class 0x020000
> 2025-05-21T10:59:23.313857+00:00 mc-misc2002 kernel: [    6.592164] pci 0=
000:98:00.1: reg 0x10: [mem 0x206fffe00000-0x206fffe0ffff 64bit pref]
> 2025-05-21T10:59:23.313861+00:00 mc-misc2002 kernel: [    6.600158] pci 0=
000:98:00.1: reg 0x18: [mem 0x206fffc00000-0x206fffcfffff 64bit pref]
> 2025-05-21T10:59:23.313862+00:00 mc-misc2002 kernel: [    6.612158] pci 0=
000:98:00.1: reg 0x20: [mem 0x206fffe20000-0x206fffe21fff 64bit pref]
> 2025-05-21T10:59:23.313862+00:00 mc-misc2002 kernel: [    6.620154] pci 0=
000:98:00.1: reg 0x30: [mem 0xdba00000-0xdba3ffff pref]
> 2025-05-21T10:59:23.313863+00:00 mc-misc2002 kernel: [    6.628217] pci 0=
000:98:00.1: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313863+00:00 mc-misc2002 kernel: [    6.636270] pci 0=
000:97:04.0: PCI bridge to [bus 98]
> 2025-05-21T10:59:23.313863+00:00 mc-misc2002 kernel: [    6.640150] pci 0=
000:97:04.0:   bridge window [mem 0xdba00000-0xdbafffff]
> 2025-05-21T10:59:23.313867+00:00 mc-misc2002 kernel: [    6.648150] pci 0=
000:97:04.0:   bridge window [mem 0x206fffc00000-0x206fffefffff 64bit pref]
> 2025-05-21T10:59:23.313868+00:00 mc-misc2002 kernel: [    6.656153] pci_b=
us 0000:97: on NUMA node 1
> 2025-05-21T10:59:23.313868+00:00 mc-misc2002 kernel: [    6.656255] ACPI:=
 PCI Root Bridge [PC08] (domain 0000 [bus b0-c8])
> 2025-05-21T10:59:23.313869+00:00 mc-misc2002 kernel: [    6.664149] acpi =
PNP0A08:0a: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:59:23.313869+00:00 mc-misc2002 kernel: [    6.676917] acpi =
PNP0A08:0a: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:59:23.313870+00:00 mc-misc2002 kernel: [    6.684400] acpi =
PNP0A08:0a: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:59:23.313870+00:00 mc-misc2002 kernel: [    6.692149] acpi =
PNP0A08:0a: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:59:23.313874+00:00 mc-misc2002 kernel: [    6.700269] PCI h=
ost bridge to bus 0000:b0
> 2025-05-21T10:59:23.313874+00:00 mc-misc2002 kernel: [    6.708148] pci_b=
us 0000:b0: root bus resource [io  0xd000-0xdfff window]
> 2025-05-21T10:59:23.313875+00:00 mc-misc2002 kernel: [    6.712149] pci_b=
us 0000:b0: root bus resource [mem 0xdbc00000-0xe67fffff window]
> 2025-05-21T10:59:23.313875+00:00 mc-misc2002 kernel: [    6.724149] pci_b=
us 0000:b0: root bus resource [mem 0x207000000000-0x207fffffffff window]
> 2025-05-21T10:59:23.313876+00:00 mc-misc2002 kernel: [    6.732149] pci_b=
us 0000:b0: root bus resource [bus b0-c8]
> 2025-05-21T10:59:23.313876+00:00 mc-misc2002 kernel: [    6.736158] pci 0=
000:b0:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:59:23.313880+00:00 mc-misc2002 kernel: [    6.744222] pci 0=
000:b0:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:59:23.313881+00:00 mc-misc2002 kernel: [    6.752223] pci 0=
000:b0:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:59:23.313881+00:00 mc-misc2002 kernel: [    6.756222] pci 0=
000:b0:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:59:23.313881+00:00 mc-misc2002 kernel: [    6.764231] pci_b=
us 0000:b0: on NUMA node 1
> 2025-05-21T10:59:23.313882+00:00 mc-misc2002 kernel: [    6.764348] ACPI:=
 PCI Root Bridge [PC10] (domain 0000 [bus c9-e1])
> 2025-05-21T10:59:23.313882+00:00 mc-misc2002 kernel: [    6.772149] acpi =
PNP0A08:0c: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:59:23.313886+00:00 mc-misc2002 kernel: [    6.781246] acpi =
PNP0A08:0c: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:59:23.313887+00:00 mc-misc2002 kernel: [    6.792403] acpi =
PNP0A08:0c: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:59:23.313887+00:00 mc-misc2002 kernel: [    6.800148] acpi =
PNP0A08:0c: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:59:23.313888+00:00 mc-misc2002 kernel: [    6.808270] PCI h=
ost bridge to bus 0000:c9
> 2025-05-21T10:59:23.313888+00:00 mc-misc2002 kernel: [    6.816149] pci_b=
us 0000:c9: root bus resource [io  0xe000-0xefff window]
> 2025-05-21T10:59:23.313888+00:00 mc-misc2002 kernel: [    6.820149] pci_b=
us 0000:c9: root bus resource [mem 0xe6800000-0xf13fffff window]
> 2025-05-21T10:59:23.313889+00:00 mc-misc2002 kernel: [    6.832148] pci_b=
us 0000:c9: root bus resource [mem 0x208000000000-0x208fffffffff window]
> 2025-05-21T10:59:23.313893+00:00 mc-misc2002 kernel: [    6.840148] pci_b=
us 0000:c9: root bus resource [bus c9-e1]
> 2025-05-21T10:59:23.313893+00:00 mc-misc2002 kernel: [    6.844158] pci 0=
000:c9:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:59:23.313894+00:00 mc-misc2002 kernel: [    6.852222] pci 0=
000:c9:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:59:23.313894+00:00 mc-misc2002 kernel: [    6.860226] pci 0=
000:c9:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:59:23.313895+00:00 mc-misc2002 kernel: [    6.864222] pci 0=
000:c9:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:59:23.313895+00:00 mc-misc2002 kernel: [    6.872227] pci 0=
000:c9:02.0: [8086:347a] type 01 class 0x060400
> 2025-05-21T10:59:23.313899+00:00 mc-misc2002 kernel: [    6.880158] pci 0=
000:c9:02.0: reg 0x10: [mem 0x208ffff20000-0x208ffff3ffff 64bit]
> 2025-05-21T10:59:23.313900+00:00 mc-misc2002 kernel: [    6.888161] pci 0=
000:c9:02.0: enabling Extended Tags
> 2025-05-21T10:59:23.313900+00:00 mc-misc2002 kernel: [    6.892184] pci 0=
000:c9:02.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313901+00:00 mc-misc2002 kernel: [    6.900403] pci 0=
000:c9:03.0: [8086:347b] type 01 class 0x060400
> 2025-05-21T10:59:23.313901+00:00 mc-misc2002 kernel: [    6.908160] pci 0=
000:c9:03.0: reg 0x10: [mem 0x208ffff00000-0x208ffff1ffff 64bit]
> 2025-05-21T10:59:23.313902+00:00 mc-misc2002 kernel: [    6.916167] pci 0=
000:c9:03.0: enabling Extended Tags
> 2025-05-21T10:59:23.313905+00:00 mc-misc2002 kernel: [    6.920203] pci 0=
000:c9:03.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313906+00:00 mc-misc2002 kernel: [    6.928526] pci 0=
000:c9:02.0: PCI bridge to [bus ca]
> 2025-05-21T10:59:23.313906+00:00 mc-misc2002 kernel: [    6.936150] pci 0=
000:c9:02.0:   bridge window [mem 0xf1200000-0xf12fffff]
> 2025-05-21T10:59:23.313907+00:00 mc-misc2002 kernel: [    6.940276] pci 0=
000:c9:03.0: PCI bridge to [bus cb]
> 2025-05-21T10:59:23.313907+00:00 mc-misc2002 kernel: [    6.948150] pci 0=
000:c9:03.0:   bridge window [mem 0xf1100000-0xf11fffff]
> 2025-05-21T10:59:23.313908+00:00 mc-misc2002 kernel: [    6.956160] pci_b=
us 0000:c9: on NUMA node 1
> 2025-05-21T10:59:23.313908+00:00 mc-misc2002 kernel: [    6.956264] ACPI:=
 PCI Root Bridge [PC11] (domain 0000 [bus e2-fa])
> 2025-05-21T10:59:23.313912+00:00 mc-misc2002 kernel: [    6.964149] acpi =
PNP0A08:0d: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:59:23.313913+00:00 mc-misc2002 kernel: [    6.973579] acpi =
PNP0A08:0d: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:59:23.313913+00:00 mc-misc2002 kernel: [    6.980622] acpi =
PNP0A08:0d: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:59:23.313914+00:00 mc-misc2002 kernel: [    6.992148] acpi =
PNP0A08:0d: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:59:23.313914+00:00 mc-misc2002 kernel: [    7.000273] PCI h=
ost bridge to bus 0000:e2
> 2025-05-21T10:59:23.313914+00:00 mc-misc2002 kernel: [    7.004148] pci_b=
us 0000:e2: root bus resource [io  0xf000-0xffff window]
> 2025-05-21T10:59:23.313918+00:00 mc-misc2002 kernel: [    7.012148] pci_b=
us 0000:e2: root bus resource [mem 0xf1400000-0xfb7fffff window]
> 2025-05-21T10:59:23.313919+00:00 mc-misc2002 kernel: [    7.020148] pci_b=
us 0000:e2: root bus resource [mem 0x209000000000-0x209fffffffff window]
> 2025-05-21T10:59:23.313919+00:00 mc-misc2002 kernel: [    7.032148] pci_b=
us 0000:e2: root bus resource [bus e2-fa]
> 2025-05-21T10:59:23.313920+00:00 mc-misc2002 kernel: [    7.036158] pci 0=
000:e2:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:59:23.313920+00:00 mc-misc2002 kernel: [    7.044227] pci 0=
000:e2:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:59:23.313921+00:00 mc-misc2002 kernel: [    7.052224] pci 0=
000:e2:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:59:23.313925+00:00 mc-misc2002 kernel: [    7.056222] pci 0=
000:e2:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:59:23.313926+00:00 mc-misc2002 kernel: [    7.064232] pci 0=
000:e2:02.0: [8086:347a] type 01 class 0x060400
> 2025-05-21T10:59:23.313926+00:00 mc-misc2002 kernel: [    7.072158] pci 0=
000:e2:02.0: reg 0x10: [mem 0x209ffff60000-0x209ffff7ffff 64bit]
> 2025-05-21T10:59:23.313927+00:00 mc-misc2002 kernel: [    7.080161] pci 0=
000:e2:02.0: enabling Extended Tags
> 2025-05-21T10:59:23.313927+00:00 mc-misc2002 kernel: [    7.084185] pci 0=
000:e2:02.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313928+00:00 mc-misc2002 kernel: [    7.092404] pci 0=
000:e2:03.0: [8086:347b] type 01 class 0x060400
> 2025-05-21T10:59:23.313928+00:00 mc-misc2002 kernel: [    7.100160] pci 0=
000:e2:03.0: reg 0x10: [mem 0x209ffff40000-0x209ffff5ffff 64bit]
> 2025-05-21T10:59:23.313932+00:00 mc-misc2002 kernel: [    7.108164] pci 0=
000:e2:03.0: enabling Extended Tags
> 2025-05-21T10:59:23.313933+00:00 mc-misc2002 kernel: [    7.112211] pci 0=
000:e2:03.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313933+00:00 mc-misc2002 kernel: [    7.120396] pci 0=
000:e2:04.0: [8086:347c] type 01 class 0x060400
> 2025-05-21T10:59:23.313934+00:00 mc-misc2002 kernel: [    7.128159] pci 0=
000:e2:04.0: reg 0x10: [mem 0x209ffff20000-0x209ffff3ffff 64bit]
> 2025-05-21T10:59:23.313934+00:00 mc-misc2002 kernel: [    7.136161] pci 0=
000:e2:04.0: enabling Extended Tags
> 2025-05-21T10:59:23.313934+00:00 mc-misc2002 kernel: [    7.140185] pci 0=
000:e2:04.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313939+00:00 mc-misc2002 kernel: [    7.148391] pci 0=
000:e2:05.0: [8086:347d] type 01 class 0x060400
> 2025-05-21T10:59:23.313939+00:00 mc-misc2002 kernel: [    7.156158] pci 0=
000:e2:05.0: reg 0x10: [mem 0x209ffff00000-0x209ffff1ffff 64bit]
> 2025-05-21T10:59:23.313939+00:00 mc-misc2002 kernel: [    7.164161] pci 0=
000:e2:05.0: enabling Extended Tags
> 2025-05-21T10:59:23.313940+00:00 mc-misc2002 kernel: [    7.168185] pci 0=
000:e2:05.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:59:23.313940+00:00 mc-misc2002 kernel: [    7.176521] pci 0=
000:e2:02.0: PCI bridge to [bus e3]
> 2025-05-21T10:59:23.313941+00:00 mc-misc2002 kernel: [    7.180150] pci 0=
000:e2:02.0:   bridge window [mem 0xfb600000-0xfb6fffff]
> 2025-05-21T10:59:23.313941+00:00 mc-misc2002 kernel: [    7.188278] pci 0=
000:e2:03.0: PCI bridge to [bus e4]
> 2025-05-21T10:59:23.313945+00:00 mc-misc2002 kernel: [    7.196150] pci 0=
000:e2:03.0:   bridge window [mem 0xfb500000-0xfb5fffff]
> 2025-05-21T10:59:23.313946+00:00 mc-misc2002 kernel: [    7.200277] pci 0=
000:e2:04.0: PCI bridge to [bus e5]
> 2025-05-21T10:59:23.313946+00:00 mc-misc2002 kernel: [    7.208150] pci 0=
000:e2:04.0:   bridge window [mem 0xfb400000-0xfb4fffff]
> 2025-05-21T10:59:23.313949+00:00 mc-misc2002 kernel: [    7.216275] pci 0=
000:e2:05.0: PCI bridge to [bus e6]
> 2025-05-21T10:59:23.313949+00:00 mc-misc2002 kernel: [    7.220150] pci 0=
000:e2:05.0:   bridge window [mem 0xfb300000-0xfb3fffff]
> 2025-05-21T10:59:23.313949+00:00 mc-misc2002 kernel: [    7.228168] pci_b=
us 0000:e2: on NUMA node 1
> 2025-05-21T10:59:23.313953+00:00 mc-misc2002 kernel: [    7.228273] ACPI:=
 PCI Root Bridge [UC16] (domain 0000 [bus fe])
> 2025-05-21T10:59:23.313954+00:00 mc-misc2002 kernel: [    7.236149] acpi =
PNP0A08:0e: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:59:23.313954+00:00 mc-misc2002 kernel: [    7.244217] acpi =
PNP0A08:0e: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T10:59:23.313955+00:00 mc-misc2002 kernel: [    7.256271] acpi =
PNP0A08:0e: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T10:59:23.313955+00:00 mc-misc2002 kernel: [    7.264148] acpi =
PNP0A08:0e: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:59:23.313956+00:00 mc-misc2002 kernel: [    7.272257] PCI h=
ost bridge to bus 0000:fe
> 2025-05-21T10:59:23.313959+00:00 mc-misc2002 kernel: [    7.276148] pci_b=
us 0000:fe: root bus resource [bus fe]
> 2025-05-21T10:59:23.313960+00:00 mc-misc2002 kernel: [    7.284158] pci 0=
000:fe:00.0: [8086:3450] type 00 class 0x088000
> 2025-05-21T10:59:23.313960+00:00 mc-misc2002 kernel: [    7.288231] pci 0=
000:fe:00.1: [8086:3451] type 00 class 0x088000
> 2025-05-21T10:59:23.313961+00:00 mc-misc2002 kernel: [    7.296212] pci 0=
000:fe:00.2: [8086:3452] type 00 class 0x088000
> 2025-05-21T10:59:23.313961+00:00 mc-misc2002 kernel: [    7.304214] pci 0=
000:fe:00.3: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:59:23.313962+00:00 mc-misc2002 kernel: [    7.308219] pci 0=
000:fe:00.5: [8086:3455] type 00 class 0x088000
> 2025-05-21T10:59:23.313962+00:00 mc-misc2002 kernel: [    7.316221] pci 0=
000:fe:02.0: [8086:3440] type 00 class 0x088000
> 2025-05-21T10:59:23.313966+00:00 mc-misc2002 kernel: [    7.324290] pci 0=
000:fe:02.1: [8086:3441] type 00 class 0x088000
> 2025-05-21T10:59:23.313966+00:00 mc-misc2002 kernel: [    7.332269] pci 0=
000:fe:02.2: [8086:3442] type 00 class 0x088000
> 2025-05-21T10:59:23.313967+00:00 mc-misc2002 kernel: [    7.336276] pci 0=
000:fe:04.0: [8086:3440] type 00 class 0x088000
> 2025-05-21T10:59:23.313967+00:00 mc-misc2002 kernel: [    7.344282] pci 0=
000:fe:04.1: [8086:3441] type 00 class 0x088000
> 2025-05-21T10:59:23.313967+00:00 mc-misc2002 kernel: [    7.352277] pci 0=
000:fe:04.2: [8086:3442] type 00 class 0x088000
> 2025-05-21T10:59:23.313968+00:00 mc-misc2002 kernel: [    7.356279] pci 0=
000:fe:04.3: [8086:3443] type 00 class 0x088000
> 2025-05-21T10:59:23.313972+00:00 mc-misc2002 kernel: [    7.364285] pci 0=
000:fe:05.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T10:59:23.314329+00:00 mc-misc2002 kernel: [    7.372289] pci 0=
000:fe:05.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T10:59:23.314329+00:00 mc-misc2002 kernel: [    7.380273] pci 0=
000:fe:05.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T10:59:23.314330+00:00 mc-misc2002 kernel: [    7.384275] pci 0=
000:fe:06.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T10:59:23.314330+00:00 mc-misc2002 kernel: [    7.392252] pci 0=
000:fe:06.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T10:59:23.314330+00:00 mc-misc2002 kernel: [    7.400236] pci 0=
000:fe:06.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T10:59:23.314335+00:00 mc-misc2002 kernel: [    7.404246] pci 0=
000:fe:07.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T10:59:23.314336+00:00 mc-misc2002 kernel: [    7.412298] pci 0=
000:fe:07.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T10:59:23.314336+00:00 mc-misc2002 kernel: [    7.420288] pci 0=
000:fe:07.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T10:59:23.314337+00:00 mc-misc2002 kernel: [    7.428279] pci 0=
000:fe:0b.0: [8086:3448] type 00 class 0x088000
> 2025-05-21T10:59:23.314337+00:00 mc-misc2002 kernel: [    7.432233] pci 0=
000:fe:0b.1: [8086:3448] type 00 class 0x088000
> 2025-05-21T10:59:23.314337+00:00 mc-misc2002 kernel: [    7.440216] pci 0=
000:fe:0b.2: [8086:344b] type 00 class 0x088000
> 2025-05-21T10:59:23.314338+00:00 mc-misc2002 kernel: [    7.448224] pci 0=
000:fe:0c.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:59:23.314342+00:00 mc-misc2002 kernel: [    7.452265] pci 0=
000:fe:0d.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:59:23.314343+00:00 mc-misc2002 kernel: [    7.460260] pci 0=
000:fe:0e.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:59:23.314343+00:00 mc-misc2002 kernel: [    7.468296] pci 0=
000:fe:0f.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:59:23.314344+00:00 mc-misc2002 kernel: [    7.476334] pci 0=
000:fe:1a.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:59:23.314344+00:00 mc-misc2002 kernel: [    7.480263] pci 0=
000:fe:1b.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:59:23.314344+00:00 mc-misc2002 kernel: [    7.488257] pci 0=
000:fe:1c.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:59:23.314348+00:00 mc-misc2002 kernel: [    7.496305] pci 0=
000:fe:1d.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:59:23.314349+00:00 mc-misc2002 kernel: [    7.500301] pci_b=
us 0000:fe: on NUMA node 1
> 2025-05-21T10:59:23.314349+00:00 mc-misc2002 kernel: [    7.500377] ACPI:=
 PCI Root Bridge [UC17] (domain 0000 [bus ff])
> 2025-05-21T10:59:23.314350+00:00 mc-misc2002 kernel: [    7.508149] acpi =
PNP0A08:0f: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:59:23.314350+00:00 mc-misc2002 kernel: [    7.520214] acpi =
PNP0A08:0f: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T10:59:23.314351+00:00 mc-misc2002 kernel: [    7.528267] acpi =
PNP0A08:0f: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T10:59:23.314353+00:00 mc-misc2002 kernel: [    7.536148] acpi =
PNP0A08:0f: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:59:23.314355+00:00 mc-misc2002 kernel: [    7.544276] PCI h=
ost bridge to bus 0000:ff
> 2025-05-21T10:59:23.314356+00:00 mc-misc2002 kernel: [    7.548148] pci_b=
us 0000:ff: root bus resource [bus ff]
> 2025-05-21T10:59:23.314356+00:00 mc-misc2002 kernel: [    7.556169] pci 0=
000:ff:00.0: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.314356+00:00 mc-misc2002 kernel: [    7.564286] pci 0=
000:ff:00.1: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.314357+00:00 mc-misc2002 kernel: [    7.568255] pci 0=
000:ff:00.2: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.314357+00:00 mc-misc2002 kernel: [    7.576276] pci 0=
000:ff:00.3: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.314361+00:00 mc-misc2002 kernel: [    7.584256] pci 0=
000:ff:00.4: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.314362+00:00 mc-misc2002 kernel: [    7.588278] pci 0=
000:ff:00.5: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.314362+00:00 mc-misc2002 kernel: [    7.596242] pci 0=
000:ff:00.6: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.314363+00:00 mc-misc2002 kernel: [    7.604280] pci 0=
000:ff:00.7: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.314363+00:00 mc-misc2002 kernel: [    7.612292] pci 0=
000:ff:01.0: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.314364+00:00 mc-misc2002 kernel: [    7.616314] pci 0=
000:ff:01.1: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.314368+00:00 mc-misc2002 kernel: [    7.624299] pci 0=
000:ff:01.2: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.314368+00:00 mc-misc2002 kernel: [    7.632296] pci 0=
000:ff:01.3: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:59:23.314369+00:00 mc-misc2002 kernel: [    7.640316] pci 0=
000:ff:0a.0: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.314369+00:00 mc-misc2002 kernel: [    7.644284] pci 0=
000:ff:0a.1: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.314369+00:00 mc-misc2002 kernel: [    7.652255] pci 0=
000:ff:0a.2: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.314370+00:00 mc-misc2002 kernel: [    7.660273] pci 0=
000:ff:0a.3: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.314370+00:00 mc-misc2002 kernel: [    7.664249] pci 0=
000:ff:0a.4: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.314376+00:00 mc-misc2002 kernel: [    7.672278] pci 0=
000:ff:0a.5: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.314376+00:00 mc-misc2002 kernel: [    7.680241] pci 0=
000:ff:0a.6: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.314377+00:00 mc-misc2002 kernel: [    7.688280] pci 0=
000:ff:0a.7: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.314377+00:00 mc-misc2002 kernel: [    7.692297] pci 0=
000:ff:0b.0: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.314378+00:00 mc-misc2002 kernel: [    7.700315] pci 0=
000:ff:0b.1: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.314378+00:00 mc-misc2002 kernel: [    7.708298] pci 0=
000:ff:0b.2: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.314382+00:00 mc-misc2002 kernel: [    7.712296] pci 0=
000:ff:0b.3: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:59:23.314382+00:00 mc-misc2002 kernel: [    7.720315] pci 0=
000:ff:1d.0: [8086:344f] type 00 class 0x088000
> 2025-05-21T10:59:23.314383+00:00 mc-misc2002 kernel: [    7.728293] pci 0=
000:ff:1d.1: [8086:3457] type 00 class 0x088000
> 2025-05-21T10:59:23.314383+00:00 mc-misc2002 kernel: [    7.736274] pci 0=
000:ff:1e.0: [8086:3458] type 00 class 0x088000
> 2025-05-21T10:59:23.314384+00:00 mc-misc2002 kernel: [    7.740231] pci 0=
000:ff:1e.1: [8086:3459] type 00 class 0x088000
> 2025-05-21T10:59:23.314384+00:00 mc-misc2002 kernel: [    7.748220] pci 0=
000:ff:1e.2: [8086:345a] type 00 class 0x088000
> 2025-05-21T10:59:23.314386+00:00 mc-misc2002 kernel: [    7.756215] pci 0=
000:ff:1e.3: [8086:345b] type 00 class 0x088000
> 2025-05-21T10:59:23.314389+00:00 mc-misc2002 kernel: [    7.760215] pci 0=
000:ff:1e.4: [8086:345c] type 00 class 0x088000
> 2025-05-21T10:59:23.314389+00:00 mc-misc2002 kernel: [    7.768216] pci 0=
000:ff:1e.5: [8086:345d] type 00 class 0x088000
> 2025-05-21T10:59:23.314389+00:00 mc-misc2002 kernel: [    7.776214] pci 0=
000:ff:1e.6: [8086:345e] type 00 class 0x088000
> 2025-05-21T10:59:23.314390+00:00 mc-misc2002 kernel: [    7.784219] pci 0=
000:ff:1e.7: [8086:345f] type 00 class 0x088000
> 2025-05-21T10:59:23.314390+00:00 mc-misc2002 kernel: [    7.788210] pci_b=
us 0000:ff: on NUMA node 1
> 2025-05-21T10:59:23.314391+00:00 mc-misc2002 kernel: [    7.788485] ACPI:=
 PCI: Interrupt link LNKA configured for IRQ 11
> 2025-05-21T10:59:23.314404+00:00 mc-misc2002 kernel: [    7.796187] ACPI:=
 PCI: Interrupt link LNKB configured for IRQ 10
> 2025-05-21T10:59:23.314404+00:00 mc-misc2002 kernel: [    7.804184] ACPI:=
 PCI: Interrupt link LNKC configured for IRQ 11
> 2025-05-21T10:59:23.314405+00:00 mc-misc2002 kernel: [    7.808185] ACPI:=
 PCI: Interrupt link LNKD configured for IRQ 11
> 2025-05-21T10:59:23.314405+00:00 mc-misc2002 kernel: [    7.816185] ACPI:=
 PCI: Interrupt link LNKE configured for IRQ 11
> 2025-05-21T10:59:23.314406+00:00 mc-misc2002 kernel: [    7.824184] ACPI:=
 PCI: Interrupt link LNKF configured for IRQ 11
> 2025-05-21T10:59:23.314406+00:00 mc-misc2002 kernel: [    7.828184] ACPI:=
 PCI: Interrupt link LNKG configured for IRQ 11
> 2025-05-21T10:59:23.314410+00:00 mc-misc2002 kernel: [    7.836184] ACPI:=
 PCI: Interrupt link LNKH configured for IRQ 11
> 2025-05-21T10:59:23.314411+00:00 mc-misc2002 kernel: [    7.844690] iommu=
: Default domain type: Translated=20
> 2025-05-21T10:59:23.314411+00:00 mc-misc2002 kernel: [    7.848148] iommu=
: DMA domain TLB invalidation policy: lazy mode=20
> 2025-05-21T10:59:23.314412+00:00 mc-misc2002 kernel: [    7.856250] pps_c=
ore: LinuxPPS API ver. 1 registered
> 2025-05-21T10:59:23.314412+00:00 mc-misc2002 kernel: [    7.860148] pps_c=
ore: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@l=
inux.it>
> 2025-05-21T10:59:23.314412+00:00 mc-misc2002 kernel: [    7.872150] PTP c=
lock support registered
> 2025-05-21T10:59:23.314413+00:00 mc-misc2002 kernel: [    7.876177] EDAC =
MC: Ver: 3.0.0
> 2025-05-21T10:59:23.314417+00:00 mc-misc2002 kernel: [    7.880361] NetLa=
bel: Initializing
> 2025-05-21T10:59:23.314418+00:00 mc-misc2002 kernel: [    7.884148] NetLa=
bel:  domain hash size =3D 128
> 2025-05-21T10:59:23.314418+00:00 mc-misc2002 kernel: [    7.888148] NetLa=
bel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
> 2025-05-21T10:59:23.314419+00:00 mc-misc2002 kernel: [    7.896166] NetLa=
bel:  unlabeled traffic allowed by default
> 2025-05-21T10:59:23.314419+00:00 mc-misc2002 kernel: [    7.904148] PCI: =
Using ACPI for IRQ routing
> 2025-05-21T10:59:23.314419+00:00 mc-misc2002 kernel: [    7.911730] PCI: =
pci_cache_line_size set to 64 bytes
> 2025-05-21T10:59:23.314424+00:00 mc-misc2002 kernel: [    7.912164] e820:=
 reserve RAM buffer [mem 0x00098800-0x0009ffff]
> 2025-05-21T10:59:23.314424+00:00 mc-misc2002 kernel: [    7.912166] e820:=
 reserve RAM buffer [mem 0x645ff000-0x67ffffff]
> 2025-05-21T10:59:23.314425+00:00 mc-misc2002 kernel: [    7.912168] e820:=
 reserve RAM buffer [mem 0x6f800000-0x6fffffff]
> 2025-05-21T10:59:23.314425+00:00 mc-misc2002 kernel: [    7.912184] pci 0=
000:04:00.0: vgaarb: setting as boot VGA device
> 2025-05-21T10:59:23.314425+00:00 mc-misc2002 kernel: [    7.916147] pci 0=
000:04:00.0: vgaarb: bridge control possible
> 2025-05-21T10:59:23.314426+00:00 mc-misc2002 kernel: [    7.916147] pci 0=
000:04:00.0: vgaarb: VGA device added: decodes=3Dio+mem,owns=3Dnone,locks=
=3Dnone
> 2025-05-21T10:59:23.314430+00:00 mc-misc2002 kernel: [    7.932173] vgaar=
b: loaded
> 2025-05-21T10:59:23.314431+00:00 mc-misc2002 kernel: [    7.937126] hpet0=
: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> 2025-05-21T10:59:23.314431+00:00 mc-misc2002 kernel: [    7.944148] hpet0=
: 8 comparators, 64-bit 24.000000 MHz counter
> 2025-05-21T10:59:23.314431+00:00 mc-misc2002 kernel: [    7.956148] clock=
source: Switched to clocksource tsc-early
> 2025-05-21T10:59:23.314432+00:00 mc-misc2002 kernel: [    7.962513] VFS: =
Disk quotas dquot_6.6.0
> 2025-05-21T10:59:23.314432+00:00 mc-misc2002 kernel: [    7.966941] VFS: =
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> 2025-05-21T10:59:23.314433+00:00 mc-misc2002 kernel: [    7.974807] AppAr=
mor: AppArmor Filesystem Enabled
> 2025-05-21T10:59:23.314437+00:00 mc-misc2002 kernel: [    7.980108] pnp: =
PnP ACPI init
> 2025-05-21T10:59:23.314437+00:00 mc-misc2002 kernel: [    7.991994] syste=
m 00:01: [io  0x0500-0x05fe] has been reserved
> 2025-05-21T10:59:23.314438+00:00 mc-misc2002 kernel: [    7.998647] syste=
m 00:01: [io  0x0400-0x041f] has been reserved
> 2025-05-21T10:59:23.314438+00:00 mc-misc2002 kernel: [    8.005298] syste=
m 00:01: [mem 0xff000000-0xffffffff] has been reserved
> 2025-05-21T10:59:23.314438+00:00 mc-misc2002 kernel: [    8.013006] syste=
m 00:02: [io  0x0600-0x063f] has been reserved
> 2025-05-21T10:59:23.314439+00:00 mc-misc2002 kernel: [    8.019652] syste=
m 00:02: [io  0x0a40-0x0a5f] has been reserved
> 2025-05-21T10:59:23.314443+00:00 mc-misc2002 kernel: [    8.026289] syste=
m 00:02: [io  0x0a60-0x0a6f] has been reserved
> 2025-05-21T10:59:23.314443+00:00 mc-misc2002 kernel: [    8.032934] syste=
m 00:02: [io  0x0a70-0x0a7f] has been reserved
> 2025-05-21T10:59:23.314444+00:00 mc-misc2002 kernel: [    8.039794] pnp 0=
0:03: [dma 0 disabled]
> 2025-05-21T10:59:23.314444+00:00 mc-misc2002 kernel: [    8.040021] pnp 0=
0:04: [dma 0 disabled]
> 2025-05-21T10:59:23.314445+00:00 mc-misc2002 kernel: [    8.040194] syste=
m 00:05: [mem 0xfd000000-0xfdabffff] has been reserved
> 2025-05-21T10:59:23.314445+00:00 mc-misc2002 kernel: [    8.047623] syste=
m 00:05: [mem 0xfdad0000-0xfdadffff] has been reserved
> 2025-05-21T10:59:23.314445+00:00 mc-misc2002 kernel: [    8.055051] syste=
m 00:05: [mem 0xfdb00000-0xfdffffff] has been reserved
> 2025-05-21T10:59:23.314450+00:00 mc-misc2002 kernel: [    8.062478] syste=
m 00:05: [mem 0xfe000000-0xfe00ffff] has been reserved
> 2025-05-21T10:59:23.314450+00:00 mc-misc2002 kernel: [    8.069907] syste=
m 00:05: [mem 0xfe011000-0xfe01ffff] has been reserved
> 2025-05-21T10:59:23.314451+00:00 mc-misc2002 kernel: [    8.077335] syste=
m 00:05: [mem 0xfe036000-0xfe03bfff] has been reserved
> 2025-05-21T10:59:23.314451+00:00 mc-misc2002 kernel: [    8.084763] syste=
m 00:05: [mem 0xfe03d000-0xfe3fffff] has been reserved
> 2025-05-21T10:59:23.314451+00:00 mc-misc2002 kernel: [    8.092190] syste=
m 00:05: [mem 0xfe410000-0xfe7fffff] has been reserved
> 2025-05-21T10:59:23.314452+00:00 mc-misc2002 kernel: [    8.099902] syste=
m 00:06: [io  0x0f00-0x0ffe] has been reserved
> 2025-05-21T10:59:23.314456+00:00 mc-misc2002 kernel: [    8.107397] pnp: =
PnP ACPI: found 7 devices
> 2025-05-21T10:59:23.314457+00:00 mc-misc2002 kernel: [    8.118022] clock=
source: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 20857010=
24 ns
> 2025-05-21T10:59:23.314457+00:00 mc-misc2002 kernel: [    8.128069] NET: =
Registered PF_INET protocol family
> 2025-05-21T10:59:23.314458+00:00 mc-misc2002 kernel: [    8.133887] IP id=
ents hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T10:59:23.314458+00:00 mc-misc2002 kernel: [    8.146939] tcp_l=
isten_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, vma=
lloc)
> 2025-05-21T10:59:23.314459+00:00 mc-misc2002 kernel: [    8.157055] Table=
-perturb hash table entries: 65536 (order: 6, 262144 bytes, vmalloc)
> 2025-05-21T10:59:23.314463+00:00 mc-misc2002 kernel: [    8.166448] TCP e=
stablished hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc hu=
gepage)
> 2025-05-21T10:59:23.314463+00:00 mc-misc2002 kernel: [    8.177472] TCP b=
ind hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T10:59:23.314464+00:00 mc-misc2002 kernel: [    8.186083] TCP: =
Hash tables configured (established 524288 bind 65536)
> 2025-05-21T10:59:23.314464+00:00 mc-misc2002 kernel: [    8.193863] MPTCP=
 token hash table entries: 65536 (order: 8, 1572864 bytes, vmalloc)
> 2025-05-21T10:59:23.314465+00:00 mc-misc2002 kernel: [    8.203030] UDP h=
ash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T10:59:23.314465+00:00 mc-misc2002 kernel: [    8.211475] UDP-L=
ite hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T10:59:23.314465+00:00 mc-misc2002 kernel: [    8.220183] NET: =
Registered PF_UNIX/PF_LOCAL protocol family
> 2025-05-21T10:59:23.314470+00:00 mc-misc2002 kernel: [    8.226544] NET: =
Registered PF_XDP protocol family
> 2025-05-21T10:59:23.314470+00:00 mc-misc2002 kernel: [    8.231943] pci 0=
000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
> 2025-05-21T10:59:23.314471+00:00 mc-misc2002 kernel: [    8.241126] pci 0=
000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 0=
1] add_size 200000 add_align 100000
> 2025-05-21T10:59:23.314471+00:00 mc-misc2002 kernel: [    8.254016] pci 0=
000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 01] add_size=
 200000 add_align 100000
> 2025-05-21T10:59:23.314472+00:00 mc-misc2002 kernel: [    8.265841] pci 0=
000:00:1c.0: BAR 14: assigned [mem 0x90000000-0x901fffff]
> 2025-05-21T10:59:23.314472+00:00 mc-misc2002 kernel: [    8.273562] pci 0=
000:00:1c.0: BAR 15: assigned [mem 0x200000000000-0x2000001fffff 64bit pref]
> 2025-05-21T10:59:23.314476+00:00 mc-misc2002 kernel: [    8.283136] pci 0=
000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
> 2025-05-21T10:59:23.314477+00:00 mc-misc2002 kernel: [    8.290076] pci 0=
000:00:1f.4: BAR 0: assigned [mem 0x200000200000-0x2000002000ff 64bit]
> 2025-05-21T10:59:23.314477+00:00 mc-misc2002 kernel: [    8.299073] pci 0=
000:00:1c.0: PCI bridge to [bus 01]
> 2025-05-21T10:59:23.314477+00:00 mc-misc2002 kernel: [    8.304647] pci 0=
000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> 2025-05-21T10:59:23.314478+00:00 mc-misc2002 kernel: [    8.311490] pci 0=
000:00:1c.0:   bridge window [mem 0x90000000-0x901fffff]
> 2025-05-21T10:59:23.314478+00:00 mc-misc2002 kernel: [    8.319112] pci 0=
000:00:1c.0:   bridge window [mem 0x200000000000-0x2000001fffff 64bit pref]
> 2025-05-21T10:59:23.314483+00:00 mc-misc2002 kernel: [    8.328588] pci 0=
000:00:1c.4: PCI bridge to [bus 02]
> 2025-05-21T10:59:23.314484+00:00 mc-misc2002 kernel: [    8.334168] pci 0=
000:03:00.0: PCI bridge to [bus 04]
> 2025-05-21T10:59:23.314484+00:00 mc-misc2002 kernel: [    8.339743] pci 0=
000:03:00.0:   bridge window [io  0x3000-0x3fff]
> 2025-05-21T10:59:23.314485+00:00 mc-misc2002 kernel: [    8.346587] pci 0=
000:03:00.0:   bridge window [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T10:59:23.314485+00:00 mc-misc2002 kernel: [    8.354214] pci 0=
000:00:1c.5: PCI bridge to [bus 03-04]
> 2025-05-21T10:59:23.314486+00:00 mc-misc2002 kernel: [    8.360083] pci 0=
000:00:1c.5:   bridge window [io  0x3000-0x3fff]
> 2025-05-21T10:59:23.314490+00:00 mc-misc2002 kernel: [    8.366927] pci 0=
000:00:1c.5:   bridge window [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T10:59:23.314491+00:00 mc-misc2002 kernel: [    8.374553] pci_b=
us 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> 2025-05-21T10:59:23.314491+00:00 mc-misc2002 kernel: [    8.381494] pci_b=
us 0000:00: resource 5 [io  0x1000-0x4fff window]
> 2025-05-21T10:59:23.314491+00:00 mc-misc2002 kernel: [    8.388431] pci_b=
us 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> 2025-05-21T10:59:23.314492+00:00 mc-misc2002 kernel: [    8.396149] pci_b=
us 0000:00: resource 7 [mem 0x000c8000-0x000cffff window]
> 2025-05-21T10:59:23.314492+00:00 mc-misc2002 kernel: [    8.403860] pci_b=
us 0000:00: resource 8 [mem 0xfe010000-0xfe010fff window]
> 2025-05-21T10:59:23.314493+00:00 mc-misc2002 kernel: [    8.411578] pci_b=
us 0000:00: resource 9 [mem 0x90000000-0x9b7fffff window]
> 2025-05-21T10:59:23.314497+00:00 mc-misc2002 kernel: [    8.419295] pci_b=
us 0000:00: resource 10 [mem 0x200000000000-0x200fffffffff window]
> 2025-05-21T10:59:23.314497+00:00 mc-misc2002 kernel: [    8.427891] pci_b=
us 0000:01: resource 0 [io  0x1000-0x1fff]
> 2025-05-21T10:59:23.314498+00:00 mc-misc2002 kernel: [    8.434147] pci_b=
us 0000:01: resource 1 [mem 0x90000000-0x901fffff]
> 2025-05-21T10:59:23.314498+00:00 mc-misc2002 kernel: [    8.441183] pci_b=
us 0000:01: resource 2 [mem 0x200000000000-0x2000001fffff 64bit pref]
> 2025-05-21T10:59:23.314498+00:00 mc-misc2002 kernel: [    8.450073] pci_b=
us 0000:03: resource 0 [io  0x3000-0x3fff]
> 2025-05-21T10:59:23.314499+00:00 mc-misc2002 kernel: [    8.456329] pci_b=
us 0000:03: resource 1 [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T10:59:23.314503+00:00 mc-misc2002 kernel: [    8.463367] pci_b=
us 0000:04: resource 0 [io  0x3000-0x3fff]
> 2025-05-21T10:59:23.314504+00:00 mc-misc2002 kernel: [    8.469625] pci_b=
us 0000:04: resource 1 [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T10:59:23.314504+00:00 mc-misc2002 kernel: [    8.476745] pci_b=
us 0000:16: resource 4 [io  0x5000-0x6fff window]
> 2025-05-21T10:59:23.314504+00:00 mc-misc2002 kernel: [    8.483688] pci_b=
us 0000:16: resource 5 [mem 0x9b800000-0xa63fffff window]
> 2025-05-21T10:59:23.314505+00:00 mc-misc2002 kernel: [    8.491406] pci_b=
us 0000:16: resource 6 [mem 0x201000000000-0x201fffffffff window]
> 2025-05-21T10:59:23.314505+00:00 mc-misc2002 kernel: [    8.499924] pci_b=
us 0000:30: resource 4 [io  0x7000-0x8fff window]
> 2025-05-21T10:59:23.314506+00:00 mc-misc2002 kernel: [    8.506864] pci_b=
us 0000:30: resource 5 [mem 0xa6400000-0xb0ffffff window]
> 2025-05-21T10:59:23.314510+00:00 mc-misc2002 kernel: [    8.514584] pci_b=
us 0000:30: resource 6 [mem 0x202000000000-0x202fffffffff window]
> 2025-05-21T10:59:23.314510+00:00 mc-misc2002 kernel: [    8.523105] pci 0=
000:4a:05.0: PCI bridge to [bus 4b]
> 2025-05-21T10:59:23.314511+00:00 mc-misc2002 kernel: [    8.528678] pci 0=
000:4a:05.0:   bridge window [io  0x9000-0x9fff]
> 2025-05-21T10:59:23.314511+00:00 mc-misc2002 kernel: [    8.535522] pci 0=
000:4a:05.0:   bridge window [mem 0xbba00000-0xbbafffff]
> 2025-05-21T10:59:23.314512+00:00 mc-misc2002 kernel: [    8.543144] pci 0=
000:4a:05.0:   bridge window [mem 0x203fffe00000-0x203fffefffff 64bit pref]
> 2025-05-21T10:59:23.314512+00:00 mc-misc2002 kernel: [    8.552622] pci_b=
us 0000:4a: resource 4 [io  0x9000-0x9fff window]
> 2025-05-21T10:59:23.314516+00:00 mc-misc2002 kernel: [    8.559559] pci_b=
us 0000:4a: resource 5 [mem 0xb1000000-0xbbbfffff window]
> 2025-05-21T10:59:23.314517+00:00 mc-misc2002 kernel: [    8.567278] pci_b=
us 0000:4a: resource 6 [mem 0x203000000000-0x203fffffffff window]
> 2025-05-21T10:59:23.314517+00:00 mc-misc2002 kernel: [    8.575776] pci_b=
us 0000:4b: resource 0 [io  0x9000-0x9fff]
> 2025-05-21T10:59:23.314518+00:00 mc-misc2002 kernel: [    8.582024] pci_b=
us 0000:4b: resource 1 [mem 0xbba00000-0xbbafffff]
> 2025-05-21T10:59:23.314518+00:00 mc-misc2002 kernel: [    8.589061] pci_b=
us 0000:4b: resource 2 [mem 0x203fffe00000-0x203fffefffff 64bit pref]
> 2025-05-21T10:59:23.314519+00:00 mc-misc2002 kernel: [    8.597971] pci 0=
000:64:02.0: bridge window [io  0x1000-0x0fff] to [bus 65] add_size 1000
> 2025-05-21T10:59:23.314523+00:00 mc-misc2002 kernel: [    8.607154] pci 0=
000:64:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6=
5] add_size 200000 add_align 100000
> 2025-05-21T10:59:23.314523+00:00 mc-misc2002 kernel: [    8.620041] pci 0=
000:64:03.0: bridge window [io  0x1000-0x0fff] to [bus 66] add_size 1000
> 2025-05-21T10:59:23.314524+00:00 mc-misc2002 kernel: [    8.629222] pci 0=
000:64:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6=
6] add_size 200000 add_align 100000
> 2025-05-21T10:59:23.314524+00:00 mc-misc2002 kernel: [    8.642110] pci 0=
000:64:04.0: bridge window [io  0x1000-0x0fff] to [bus 67] add_size 1000
> 2025-05-21T10:59:23.314525+00:00 mc-misc2002 kernel: [    8.651292] pci 0=
000:64:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6=
7] add_size 200000 add_align 100000
> 2025-05-21T10:59:23.314525+00:00 mc-misc2002 kernel: [    8.664179] pci 0=
000:64:05.0: bridge window [io  0x1000-0x0fff] to [bus 68] add_size 1000
> 2025-05-21T10:59:23.314529+00:00 mc-misc2002 kernel: [    8.673360] pci 0=
000:64:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6=
8] add_size 200000 add_align 100000
> 2025-05-21T10:59:23.314530+00:00 mc-misc2002 kernel: [    8.686253] pci 0=
000:64:02.0: BAR 15: assigned [mem 0x204000000000-0x2040001fffff 64bit pref]
> 2025-05-21T10:59:23.314530+00:00 mc-misc2002 kernel: [    8.695824] pci 0=
000:64:03.0: BAR 15: assigned [mem 0x204000200000-0x2040003fffff 64bit pref]
> 2025-05-21T10:59:23.314531+00:00 mc-misc2002 kernel: [    8.705397] pci 0=
000:64:04.0: BAR 15: assigned [mem 0x204000400000-0x2040005fffff 64bit pref]
> 2025-05-21T10:59:23.314531+00:00 mc-misc2002 kernel: [    8.714969] pci 0=
000:64:05.0: BAR 15: assigned [mem 0x204000600000-0x2040007fffff 64bit pref]
> 2025-05-21T10:59:23.314532+00:00 mc-misc2002 kernel: [    8.724539] pci 0=
000:64:02.0: BAR 13: assigned [io  0xa000-0xafff]
> 2025-05-21T10:59:23.314536+00:00 mc-misc2002 kernel: [    8.731476] pci 0=
000:64:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:59:23.314536+00:00 mc-misc2002 kernel: [    8.738608] pci 0=
000:64:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:59:23.314537+00:00 mc-misc2002 kernel: [    8.746123] pci 0=
000:64:04.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:59:23.314537+00:00 mc-misc2002 kernel: [    8.753251] pci 0=
000:64:04.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:59:23.314537+00:00 mc-misc2002 kernel: [    8.760787] pci 0=
000:64:05.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:59:23.314538+00:00 mc-misc2002 kernel: [    8.767919] pci 0=
000:64:05.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:59:23.314538+00:00 mc-misc2002 kernel: [    8.775445] pci 0=
000:64:05.0: BAR 13: assigned [io  0xa000-0xafff]
> 2025-05-21T10:59:23.314542+00:00 mc-misc2002 kernel: [    8.782383] pci 0=
000:64:04.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:59:23.314543+00:00 mc-misc2002 kernel: [    8.789517] pci 0=
000:64:04.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:59:23.314543+00:00 mc-misc2002 kernel: [    8.797031] pci 0=
000:64:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:59:23.314543+00:00 mc-misc2002 kernel: [    8.804154] pci 0=
000:64:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:59:23.314544+00:00 mc-misc2002 kernel: [    8.811677] pci 0=
000:64:02.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:59:23.314544+00:00 mc-misc2002 kernel: [    8.818810] pci 0=
000:64:02.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:59:23.314549+00:00 mc-misc2002 kernel: [    8.826337] pci 0=
000:64:02.0: PCI bridge to [bus 65]
> 2025-05-21T10:59:23.314549+00:00 mc-misc2002 kernel: [    8.831914] pci 0=
000:64:02.0:   bridge window [mem 0xc5e00000-0xc5efffff]
> 2025-05-21T10:59:23.314550+00:00 mc-misc2002 kernel: [    8.839536] pci 0=
000:64:02.0:   bridge window [mem 0x204000000000-0x2040001fffff 64bit pref]
> 2025-05-21T10:59:23.314550+00:00 mc-misc2002 kernel: [    8.849013] pci 0=
000:64:03.0: PCI bridge to [bus 66]
> 2025-05-21T10:59:23.314551+00:00 mc-misc2002 kernel: [    8.854587] pci 0=
000:64:03.0:   bridge window [mem 0xc5d00000-0xc5dfffff]
> 2025-05-21T10:59:23.314551+00:00 mc-misc2002 kernel: [    8.862209] pci 0=
000:64:03.0:   bridge window [mem 0x204000200000-0x2040003fffff 64bit pref]
> 2025-05-21T10:59:23.314555+00:00 mc-misc2002 kernel: [    8.871683] pci 0=
000:64:04.0: PCI bridge to [bus 67]
> 2025-05-21T10:59:23.314555+00:00 mc-misc2002 kernel: [    8.877257] pci 0=
000:64:04.0:   bridge window [mem 0xc5c00000-0xc5cfffff]
> 2025-05-21T10:59:23.314556+00:00 mc-misc2002 kernel: [    8.884879] pci 0=
000:64:04.0:   bridge window [mem 0x204000400000-0x2040005fffff 64bit pref]
> 2025-05-21T10:59:23.314556+00:00 mc-misc2002 kernel: [    8.894356] pci 0=
000:64:05.0: PCI bridge to [bus 68]
> 2025-05-21T10:59:23.314557+00:00 mc-misc2002 kernel: [    8.899929] pci 0=
000:64:05.0:   bridge window [io  0xa000-0xafff]
> 2025-05-21T10:59:23.314557+00:00 mc-misc2002 kernel: [    8.906770] pci 0=
000:64:05.0:   bridge window [mem 0xc5b00000-0xc5bfffff]
> 2025-05-21T10:59:23.314557+00:00 mc-misc2002 kernel: [    8.914392] pci 0=
000:64:05.0:   bridge window [mem 0x204000600000-0x2040007fffff 64bit pref]
> 2025-05-21T10:59:23.314561+00:00 mc-misc2002 kernel: [    8.923869] pci_b=
us 0000:64: resource 4 [io  0xa000-0xafff window]
> 2025-05-21T10:59:23.314562+00:00 mc-misc2002 kernel: [    8.930807] pci_b=
us 0000:64: resource 5 [mem 0xbbc00000-0xc5ffffff window]
> 2025-05-21T10:59:23.314562+00:00 mc-misc2002 kernel: [    8.938526] pci_b=
us 0000:64: resource 6 [mem 0x204000000000-0x204fffffffff window]
> 2025-05-21T10:59:23.314563+00:00 mc-misc2002 kernel: [    8.947025] pci_b=
us 0000:65: resource 1 [mem 0xc5e00000-0xc5efffff]
> 2025-05-21T10:59:23.314563+00:00 mc-misc2002 kernel: [    8.954060] pci_b=
us 0000:65: resource 2 [mem 0x204000000000-0x2040001fffff 64bit pref]
> 2025-05-21T10:59:23.314563+00:00 mc-misc2002 kernel: [    8.962939] pci_b=
us 0000:66: resource 1 [mem 0xc5d00000-0xc5dfffff]
> 2025-05-21T10:59:23.314567+00:00 mc-misc2002 kernel: [    8.969975] pci_b=
us 0000:66: resource 2 [mem 0x204000200000-0x2040003fffff 64bit pref]
> 2025-05-21T10:59:23.314568+00:00 mc-misc2002 kernel: [    8.978862] pci_b=
us 0000:67: resource 1 [mem 0xc5c00000-0xc5cfffff]
> 2025-05-21T10:59:23.314568+00:00 mc-misc2002 kernel: [    8.985896] pci_b=
us 0000:67: resource 2 [mem 0x204000400000-0x2040005fffff 64bit pref]
> 2025-05-21T10:59:23.314569+00:00 mc-misc2002 kernel: [    8.994783] pci_b=
us 0000:68: resource 0 [io  0xa000-0xafff]
> 2025-05-21T10:59:23.314569+00:00 mc-misc2002 kernel: [    9.001039] pci_b=
us 0000:68: resource 1 [mem 0xc5b00000-0xc5bfffff]
> 2025-05-21T10:59:23.314569+00:00 mc-misc2002 kernel: [    9.008075] pci_b=
us 0000:68: resource 2 [mem 0x204000600000-0x2040007fffff 64bit pref]
> 2025-05-21T10:59:23.314570+00:00 mc-misc2002 kernel: [    9.017017] pci_b=
us 0000:80: resource 4 [io  0xb000-0xbfff window]
> 2025-05-21T10:59:23.314574+00:00 mc-misc2002 kernel: [    9.023955] pci_b=
us 0000:80: resource 5 [mem 0xc6800000-0xd0ffffff window]
> 2025-05-21T10:59:23.314574+00:00 mc-misc2002 kernel: [    9.031672] pci_b=
us 0000:80: resource 6 [mem 0x205000000000-0x205fffffffff window]
> 2025-05-21T10:59:23.314575+00:00 mc-misc2002 kernel: [    9.040170] pci 0=
000:97:04.0: PCI bridge to [bus 98]
> 2025-05-21T10:59:23.314575+00:00 mc-misc2002 kernel: [    9.045746] pci 0=
000:97:04.0:   bridge window [mem 0xdba00000-0xdbafffff]
> 2025-05-21T10:59:23.314575+00:00 mc-misc2002 kernel: [    9.053369] pci 0=
000:97:04.0:   bridge window [mem 0x206fffc00000-0x206fffefffff 64bit pref]
> 2025-05-21T10:59:23.314576+00:00 mc-misc2002 kernel: [    9.062844] pci_b=
us 0000:97: resource 4 [io  0xc000-0xcfff window]
> 2025-05-21T10:59:23.314581+00:00 mc-misc2002 kernel: [    9.069784] pci_b=
us 0000:97: resource 5 [mem 0xd1000000-0xdbbfffff window]
> 2025-05-21T10:59:23.314581+00:00 mc-misc2002 kernel: [    9.077502] pci_b=
us 0000:97: resource 6 [mem 0x206000000000-0x206fffffffff window]
> 2025-05-21T10:59:23.314582+00:00 mc-misc2002 kernel: [    9.086002] pci_b=
us 0000:98: resource 1 [mem 0xdba00000-0xdbafffff]
> 2025-05-21T10:59:23.314582+00:00 mc-misc2002 kernel: [    9.093038] pci_b=
us 0000:98: resource 2 [mem 0x206fffc00000-0x206fffefffff 64bit pref]
> 2025-05-21T10:59:23.314583+00:00 mc-misc2002 kernel: [    9.101947] pci_b=
us 0000:b0: resource 4 [io  0xd000-0xdfff window]
> 2025-05-21T10:59:23.314583+00:00 mc-misc2002 kernel: [    9.108886] pci_b=
us 0000:b0: resource 5 [mem 0xdbc00000-0xe67fffff window]
> 2025-05-21T10:59:23.314587+00:00 mc-misc2002 kernel: [    9.116606] pci_b=
us 0000:b0: resource 6 [mem 0x207000000000-0x207fffffffff window]
> 2025-05-21T10:59:23.314587+00:00 mc-misc2002 kernel: [    9.125123] pci 0=
000:c9:02.0: bridge window [io  0x1000-0x0fff] to [bus ca] add_size 1000
> 2025-05-21T10:59:23.314588+00:00 mc-misc2002 kernel: [    9.134306] pci 0=
000:c9:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus c=
a] add_size 200000 add_align 100000
> 2025-05-21T10:59:23.314588+00:00 mc-misc2002 kernel: [    9.147193] pci 0=
000:c9:03.0: bridge window [io  0x1000-0x0fff] to [bus cb] add_size 1000
> 2025-05-21T10:59:23.314589+00:00 mc-misc2002 kernel: [    9.156374] pci 0=
000:c9:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus c=
b] add_size 200000 add_align 100000
> 2025-05-21T10:59:23.314589+00:00 mc-misc2002 kernel: [    9.169264] pci 0=
000:c9:02.0: BAR 15: assigned [mem 0x208000000000-0x2080001fffff 64bit pref]
> 2025-05-21T10:59:23.314594+00:00 mc-misc2002 kernel: [    9.178834] pci 0=
000:c9:03.0: BAR 15: assigned [mem 0x208000200000-0x2080003fffff 64bit pref]
> 2025-05-21T10:59:23.314594+00:00 mc-misc2002 kernel: [    9.188396] pci 0=
000:c9:02.0: BAR 13: assigned [io  0xe000-0xefff]
> 2025-05-21T10:59:23.314595+00:00 mc-misc2002 kernel: [    9.195326] pci 0=
000:c9:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:59:23.314595+00:00 mc-misc2002 kernel: [    9.202461] pci 0=
000:c9:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:59:23.314595+00:00 mc-misc2002 kernel: [    9.209986] pci 0=
000:c9:03.0: BAR 13: assigned [io  0xe000-0xefff]
> 2025-05-21T10:59:23.314596+00:00 mc-misc2002 kernel: [    9.216925] pci 0=
000:c9:02.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:59:23.314596+00:00 mc-misc2002 kernel: [    9.224057] pci 0=
000:c9:02.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:59:23.314600+00:00 mc-misc2002 kernel: [    9.231581] pci 0=
000:c9:02.0: PCI bridge to [bus ca]
> 2025-05-21T10:59:23.314601+00:00 mc-misc2002 kernel: [    9.237155] pci 0=
000:c9:02.0:   bridge window [mem 0xf1200000-0xf12fffff]
> 2025-05-21T10:59:23.314601+00:00 mc-misc2002 kernel: [    9.244776] pci 0=
000:c9:02.0:   bridge window [mem 0x208000000000-0x2080001fffff 64bit pref]
> 2025-05-21T10:59:23.314602+00:00 mc-misc2002 kernel: [    9.254252] pci 0=
000:c9:03.0: PCI bridge to [bus cb]
> 2025-05-21T10:59:23.314602+00:00 mc-misc2002 kernel: [    9.259825] pci 0=
000:c9:03.0:   bridge window [io  0xe000-0xefff]
> 2025-05-21T10:59:23.314602+00:00 mc-misc2002 kernel: [    9.266660] pci 0=
000:c9:03.0:   bridge window [mem 0xf1100000-0xf11fffff]
> 2025-05-21T10:59:23.314606+00:00 mc-misc2002 kernel: [    9.274282] pci 0=
000:c9:03.0:   bridge window [mem 0x208000200000-0x2080003fffff 64bit pref]
> 2025-05-21T10:59:23.314607+00:00 mc-misc2002 kernel: [    9.283758] pci_b=
us 0000:c9: resource 4 [io  0xe000-0xefff window]
> 2025-05-21T10:59:23.314607+00:00 mc-misc2002 kernel: [    9.290698] pci_b=
us 0000:c9: resource 5 [mem 0xe6800000-0xf13fffff window]
> 2025-05-21T10:59:23.314607+00:00 mc-misc2002 kernel: [    9.298417] pci_b=
us 0000:c9: resource 6 [mem 0x208000000000-0x208fffffffff window]
> 2025-05-21T10:59:23.314608+00:00 mc-misc2002 kernel: [    9.306914] pci_b=
us 0000:ca: resource 1 [mem 0xf1200000-0xf12fffff]
> 2025-05-21T10:59:23.314608+00:00 mc-misc2002 kernel: [    9.313940] pci_b=
us 0000:ca: resource 2 [mem 0x208000000000-0x2080001fffff 64bit pref]
> 2025-05-21T10:59:23.314609+00:00 mc-misc2002 kernel: [    9.322828] pci_b=
us 0000:cb: resource 0 [io  0xe000-0xefff]
> 2025-05-21T10:59:23.314613+00:00 mc-misc2002 kernel: [    9.329083] pci_b=
us 0000:cb: resource 1 [mem 0xf1100000-0xf11fffff]
> 2025-05-21T10:59:23.314613+00:00 mc-misc2002 kernel: [    9.336119] pci_b=
us 0000:cb: resource 2 [mem 0x208000200000-0x2080003fffff 64bit pref]
> 2025-05-21T10:59:23.314613+00:00 mc-misc2002 kernel: [    9.345027] pci 0=
000:e2:02.0: bridge window [io  0x1000-0x0fff] to [bus e3] add_size 1000
> 2025-05-21T10:59:23.314614+00:00 mc-misc2002 kernel: [    9.354208] pci 0=
000:e2:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus e=
3] add_size 200000 add_align 100000
> 2025-05-21T10:59:23.314614+00:00 mc-misc2002 kernel: [    9.367095] pci 0=
000:e2:03.0: bridge window [io  0x1000-0x0fff] to [bus e4] add_size 1000
> 2025-05-21T10:59:23.314615+00:00 mc-misc2002 kernel: [    9.376275] pci 0=
000:e2:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus e=
4] add_size 200000 add_align 100000
> 2025-05-21T10:59:23.314619+00:00 mc-misc2002 kernel: [    9.389162] pci 0=
000:e2:04.0: bridge window [io  0x1000-0x0fff] to [bus e5] add_size 1000
> 2025-05-21T10:59:23.314619+00:00 mc-misc2002 kernel: [    9.398342] pci 0=
000:e2:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus e=
5] add_size 200000 add_align 100000
> 2025-05-21T10:59:23.314620+00:00 mc-misc2002 kernel: [    9.411228] pci 0=
000:e2:05.0: bridge window [io  0x1000-0x0fff] to [bus e6] add_size 1000
> 2025-05-21T10:59:23.314620+00:00 mc-misc2002 kernel: [    9.420408] pci 0=
000:e2:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus e=
6] add_size 200000 add_align 100000
> 2025-05-21T10:59:23.314621+00:00 mc-misc2002 kernel: [    9.433298] pci 0=
000:e2:02.0: BAR 15: assigned [mem 0x209000000000-0x2090001fffff 64bit pref]
> 2025-05-21T10:59:23.314624+00:00 mc-misc2002 kernel: [    9.442868] pci 0=
000:e2:03.0: BAR 15: assigned [mem 0x209000200000-0x2090003fffff 64bit pref]
> 2025-05-21T10:59:23.314625+00:00 mc-misc2002 kernel: [    9.452432] pci 0=
000:e2:04.0: BAR 15: assigned [mem 0x209000400000-0x2090005fffff 64bit pref]
> 2025-05-21T10:59:23.314625+00:00 mc-misc2002 kernel: [    9.462003] pci 0=
000:e2:05.0: BAR 15: assigned [mem 0x209000600000-0x2090007fffff 64bit pref]
> 2025-05-21T10:59:23.314626+00:00 mc-misc2002 kernel: [    9.471573] pci 0=
000:e2:02.0: BAR 13: assigned [io  0xf000-0xffff]
> 2025-05-21T10:59:23.314626+00:00 mc-misc2002 kernel: [    9.478510] pci 0=
000:e2:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:59:23.314627+00:00 mc-misc2002 kernel: [    9.485643] pci 0=
000:e2:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:59:23.314627+00:00 mc-misc2002 kernel: [    9.493167] pci 0=
000:e2:04.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:59:23.314631+00:00 mc-misc2002 kernel: [    9.500301] pci 0=
000:e2:04.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:59:23.314632+00:00 mc-misc2002 kernel: [    9.507823] pci 0=
000:e2:05.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:59:23.314632+00:00 mc-misc2002 kernel: [    9.514956] pci 0=
000:e2:05.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:59:23.314632+00:00 mc-misc2002 kernel: [    9.522481] pci 0=
000:e2:05.0: BAR 13: assigned [io  0xf000-0xffff]
> 2025-05-21T10:59:23.314633+00:00 mc-misc2002 kernel: [    9.529419] pci 0=
000:e2:04.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:59:23.314633+00:00 mc-misc2002 kernel: [    9.536551] pci 0=
000:e2:04.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:59:23.314637+00:00 mc-misc2002 kernel: [    9.544074] pci 0=
000:e2:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:59:23.314638+00:00 mc-misc2002 kernel: [    9.551208] pci 0=
000:e2:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:59:23.314638+00:00 mc-misc2002 kernel: [    9.558730] pci 0=
000:e2:02.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:59:23.314639+00:00 mc-misc2002 kernel: [    9.565854] pci 0=
000:e2:02.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:59:23.314639+00:00 mc-misc2002 kernel: [    9.573370] pci 0=
000:e2:02.0: PCI bridge to [bus e3]
> 2025-05-21T10:59:23.314639+00:00 mc-misc2002 kernel: [    9.578946] pci 0=
000:e2:02.0:   bridge window [mem 0xfb600000-0xfb6fffff]
> 2025-05-21T10:59:23.314640+00:00 mc-misc2002 kernel: [    9.586569] pci 0=
000:e2:02.0:   bridge window [mem 0x209000000000-0x2090001fffff 64bit pref]
> 2025-05-21T10:59:23.314644+00:00 mc-misc2002 kernel: [    9.596047] pci 0=
000:e2:03.0: PCI bridge to [bus e4]
> 2025-05-21T10:59:23.314644+00:00 mc-misc2002 kernel: [    9.601622] pci 0=
000:e2:03.0:   bridge window [mem 0xfb500000-0xfb5fffff]
> 2025-05-21T10:59:23.314645+00:00 mc-misc2002 kernel: [    9.609244] pci 0=
000:e2:03.0:   bridge window [mem 0x209000200000-0x2090003fffff 64bit pref]
> 2025-05-21T10:59:23.314645+00:00 mc-misc2002 kernel: [    9.618720] pci 0=
000:e2:04.0: PCI bridge to [bus e5]
> 2025-05-21T10:59:23.314645+00:00 mc-misc2002 kernel: [    9.624296] pci 0=
000:e2:04.0:   bridge window [mem 0xfb400000-0xfb4fffff]
> 2025-05-21T10:59:23.314646+00:00 mc-misc2002 kernel: [    9.631919] pci 0=
000:e2:04.0:   bridge window [mem 0x209000400000-0x2090005fffff 64bit pref]
> 2025-05-21T10:59:23.314650+00:00 mc-misc2002 kernel: [    9.641396] pci 0=
000:e2:05.0: PCI bridge to [bus e6]
> 2025-05-21T10:59:23.314650+00:00 mc-misc2002 kernel: [    9.646968] pci 0=
000:e2:05.0:   bridge window [io  0xf000-0xffff]
> 2025-05-21T10:59:23.314651+00:00 mc-misc2002 kernel: [    9.653802] pci 0=
000:e2:05.0:   bridge window [mem 0xfb300000-0xfb3fffff]
> 2025-05-21T10:59:23.314651+00:00 mc-misc2002 kernel: [    9.661424] pci 0=
000:e2:05.0:   bridge window [mem 0x209000600000-0x2090007fffff 64bit pref]
> 2025-05-21T10:59:23.314651+00:00 mc-misc2002 kernel: [    9.670898] pci_b=
us 0000:e2: resource 4 [io  0xf000-0xffff window]
> 2025-05-21T10:59:23.314652+00:00 mc-misc2002 kernel: [    9.677835] pci_b=
us 0000:e2: resource 5 [mem 0xf1400000-0xfb7fffff window]
> 2025-05-21T10:59:23.314656+00:00 mc-misc2002 kernel: [    9.685544] pci_b=
us 0000:e2: resource 6 [mem 0x209000000000-0x209fffffffff window]
> 2025-05-21T10:59:23.314656+00:00 mc-misc2002 kernel: [    9.694035] pci_b=
us 0000:e3: resource 1 [mem 0xfb600000-0xfb6fffff]
> 2025-05-21T10:59:23.314657+00:00 mc-misc2002 kernel: [    9.701068] pci_b=
us 0000:e3: resource 2 [mem 0x209000000000-0x2090001fffff 64bit pref]
> 2025-05-21T10:59:23.314657+00:00 mc-misc2002 kernel: [    9.709958] pci_b=
us 0000:e4: resource 1 [mem 0xfb500000-0xfb5fffff]
> 2025-05-21T10:59:23.314658+00:00 mc-misc2002 kernel: [    9.716995] pci_b=
us 0000:e4: resource 2 [mem 0x209000200000-0x2090003fffff 64bit pref]
> 2025-05-21T10:59:23.314658+00:00 mc-misc2002 kernel: [    9.725884] pci_b=
us 0000:e5: resource 1 [mem 0xfb400000-0xfb4fffff]
> 2025-05-21T10:59:23.314658+00:00 mc-misc2002 kernel: [    9.732920] pci_b=
us 0000:e5: resource 2 [mem 0x209000400000-0x2090005fffff 64bit pref]
> 2025-05-21T10:59:23.314662+00:00 mc-misc2002 kernel: [    9.741809] pci_b=
us 0000:e6: resource 0 [io  0xf000-0xffff]
> 2025-05-21T10:59:23.314663+00:00 mc-misc2002 kernel: [    9.748064] pci_b=
us 0000:e6: resource 1 [mem 0xfb300000-0xfb3fffff]
> 2025-05-21T10:59:23.314663+00:00 mc-misc2002 kernel: [    9.755100] pci_b=
us 0000:e6: resource 2 [mem 0x209000600000-0x2090007fffff 64bit pref]
> 2025-05-21T10:59:23.314664+00:00 mc-misc2002 kernel: [    9.765098] pci 0=
000:4b:00.0: CLS mismatch (64 !=3D 32), using 64 bytes
> 2025-05-21T10:59:23.314664+00:00 mc-misc2002 kernel: [    9.772519] pci 0=
000:00:1f.1: [8086:a1a0] type 00 class 0x058000
> 2025-05-21T10:59:23.314664+00:00 mc-misc2002 kernel: [    9.779278] pci 0=
000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64bit]
> 2025-05-21T10:59:23.314669+00:00 mc-misc2002 kernel: [    9.787204] Tryin=
g to unpack rootfs image as initramfs...
> 2025-05-21T10:59:23.314669+00:00 mc-misc2002 kernel: [    9.787228] DMAR:=
 No SATC found
> 2025-05-21T10:59:23.314670+00:00 mc-misc2002 kernel: [    9.796799] DMAR:=
 dmar8: Using Queued invalidation
> 2025-05-21T10:59:23.314670+00:00 mc-misc2002 kernel: [    9.802179] DMAR:=
 dmar7: Using Queued invalidation
> 2025-05-21T10:59:23.314670+00:00 mc-misc2002 kernel: [    9.807559] DMAR:=
 dmar4: Using Queued invalidation
> 2025-05-21T10:59:23.314671+00:00 mc-misc2002 kernel: [    9.812945] DMAR:=
 dmar3: Using Queued invalidation
> 2025-05-21T10:59:23.314671+00:00 mc-misc2002 kernel: [    9.818318] DMAR:=
 dmar1: Using Queued invalidation
> 2025-05-21T10:59:23.314677+00:00 mc-misc2002 kernel: [    9.823702] DMAR:=
 dmar0: Using Queued invalidation
> 2025-05-21T10:59:23.314677+00:00 mc-misc2002 kernel: [    9.829081] DMAR:=
 dmar9: Using Queued invalidation
> 2025-05-21T10:59:23.314678+00:00 mc-misc2002 kernel: [    9.834585] pci 0=
000:64:02.0: Adding to iommu group 0
> 2025-05-21T10:59:23.314678+00:00 mc-misc2002 kernel: [    9.840289] pci 0=
000:64:03.0: Adding to iommu group 1
> 2025-05-21T10:59:23.314679+00:00 mc-misc2002 kernel: [    9.845992] pci 0=
000:64:04.0: Adding to iommu group 2
> 2025-05-21T10:59:23.314679+00:00 mc-misc2002 kernel: [    9.851697] pci 0=
000:64:05.0: Adding to iommu group 3
> 2025-05-21T10:59:23.314683+00:00 mc-misc2002 kernel: [    9.857403] pci 0=
000:65:00.0: Adding to iommu group 4
> 2025-05-21T10:59:23.314684+00:00 mc-misc2002 kernel: [    9.864708] pci 0=
000:4a:05.0: Adding to iommu group 5
> 2025-05-21T10:59:23.314684+00:00 mc-misc2002 kernel: [    9.870418] pci 0=
000:4b:00.0: Adding to iommu group 6
> 2025-05-21T10:59:23.314684+00:00 mc-misc2002 kernel: [    9.876122] pci 0=
000:4b:00.1: Adding to iommu group 7
> 2025-05-21T10:59:23.314685+00:00 mc-misc2002 kernel: [    9.882796] pci 0=
000:e2:02.0: Adding to iommu group 8
> 2025-05-21T10:59:23.314685+00:00 mc-misc2002 kernel: [    9.888491] pci 0=
000:e2:03.0: Adding to iommu group 9
> 2025-05-21T10:59:23.314689+00:00 mc-misc2002 kernel: [    9.894191] pci 0=
000:e2:04.0: Adding to iommu group 10
> 2025-05-21T10:59:23.314690+00:00 mc-misc2002 kernel: [    9.899990] pci 0=
000:e2:05.0: Adding to iommu group 11
> 2025-05-21T10:59:23.314690+00:00 mc-misc2002 kernel: [    9.906921] pci 0=
000:c9:02.0: Adding to iommu group 12
> 2025-05-21T10:59:23.314690+00:00 mc-misc2002 kernel: [    9.912727] pci 0=
000:c9:03.0: Adding to iommu group 13
> 2025-05-21T10:59:23.314691+00:00 mc-misc2002 kernel: [    9.919149] pci 0=
000:97:04.0: Adding to iommu group 14
> 2025-05-21T10:59:23.314691+00:00 mc-misc2002 kernel: [    9.924955] pci 0=
000:98:00.0: Adding to iommu group 15
> 2025-05-21T10:59:23.314692+00:00 mc-misc2002 kernel: [    9.930756] pci 0=
000:98:00.1: Adding to iommu group 16
> 2025-05-21T10:59:23.314696+00:00 mc-misc2002 kernel: [    9.937462] pci 0=
000:80:01.0: Adding to iommu group 17
> 2025-05-21T10:59:23.314696+00:00 mc-misc2002 kernel: [    9.943261] pci 0=
000:80:01.1: Adding to iommu group 18
> 2025-05-21T10:59:23.314696+00:00 mc-misc2002 kernel: [    9.949059] pci 0=
000:80:01.2: Adding to iommu group 19
> 2025-05-21T10:59:23.314697+00:00 mc-misc2002 kernel: [    9.954859] pci 0=
000:80:01.3: Adding to iommu group 20
> 2025-05-21T10:59:23.314697+00:00 mc-misc2002 kernel: [    9.960658] pci 0=
000:80:01.4: Adding to iommu group 21
> 2025-05-21T10:59:23.314698+00:00 mc-misc2002 kernel: [    9.966458] pci 0=
000:80:01.5: Adding to iommu group 22
> 2025-05-21T10:59:23.314702+00:00 mc-misc2002 kernel: [    9.972259] pci 0=
000:80:01.6: Adding to iommu group 23
> 2025-05-21T10:59:23.314702+00:00 mc-misc2002 kernel: [    9.978058] pci 0=
000:80:01.7: Adding to iommu group 24
> 2025-05-21T10:59:23.314703+00:00 mc-misc2002 kernel: [    9.986050] pci 0=
000:00:00.0: Adding to iommu group 25
> 2025-05-21T10:59:23.314703+00:00 mc-misc2002 kernel: [    9.991855] pci 0=
000:00:00.1: Adding to iommu group 26
> 2025-05-21T10:59:23.314704+00:00 mc-misc2002 kernel: [    9.997690] pci 0=
000:00:00.2: Adding to iommu group 27
> 2025-05-21T10:59:23.314704+00:00 mc-misc2002 kernel: [   10.003496] pci 0=
000:00:00.4: Adding to iommu group 28
> 2025-05-21T10:59:23.314704+00:00 mc-misc2002 kernel: [   10.009295] pci 0=
000:00:01.0: Adding to iommu group 29
> 2025-05-21T10:59:23.314708+00:00 mc-misc2002 kernel: [   10.015093] pci 0=
000:00:01.1: Adding to iommu group 30
> 2025-05-21T10:59:23.314709+00:00 mc-misc2002 kernel: [   10.020893] pci 0=
000:00:01.2: Adding to iommu group 31
> 2025-05-21T10:59:23.314709+00:00 mc-misc2002 kernel: [   10.026693] pci 0=
000:00:01.3: Adding to iommu group 32
> 2025-05-21T10:59:23.314710+00:00 mc-misc2002 kernel: [   10.032493] pci 0=
000:00:01.4: Adding to iommu group 33
> 2025-05-21T10:59:23.314710+00:00 mc-misc2002 kernel: [   10.038290] pci 0=
000:00:01.5: Adding to iommu group 34
> 2025-05-21T10:59:23.314711+00:00 mc-misc2002 kernel: [   10.044089] pci 0=
000:00:01.6: Adding to iommu group 35
> 2025-05-21T10:59:23.314715+00:00 mc-misc2002 kernel: [   10.049890] pci 0=
000:00:01.7: Adding to iommu group 36
> 2025-05-21T10:59:23.314715+00:00 mc-misc2002 kernel: [   10.055767] pci 0=
000:00:02.0: Adding to iommu group 37
> 2025-05-21T10:59:23.314716+00:00 mc-misc2002 kernel: [   10.061567] pci 0=
000:00:02.1: Adding to iommu group 37
> 2025-05-21T10:59:23.314716+00:00 mc-misc2002 kernel: [   10.067364] pci 0=
000:00:02.4: Adding to iommu group 37
> 2025-05-21T10:59:23.314717+00:00 mc-misc2002 kernel: [   10.073217] pci 0=
000:00:11.0: Adding to iommu group 38
> 2025-05-21T10:59:23.314717+00:00 mc-misc2002 kernel: [   10.078401] Freei=
ng initrd memory: 42228K
> 2025-05-21T10:59:23.314721+00:00 mc-misc2002 kernel: [   10.079018] pci 0=
000:00:11.5: Adding to iommu group 38
> 2025-05-21T10:59:23.314721+00:00 mc-misc2002 kernel: [   10.089327] pci 0=
000:00:14.0: Adding to iommu group 39
> 2025-05-21T10:59:23.314722+00:00 mc-misc2002 kernel: [   10.095126] pci 0=
000:00:14.2: Adding to iommu group 39
> 2025-05-21T10:59:23.314722+00:00 mc-misc2002 kernel: [   10.101001] pci 0=
000:00:16.0: Adding to iommu group 40
> 2025-05-21T10:59:23.314723+00:00 mc-misc2002 kernel: [   10.106802] pci 0=
000:00:16.1: Adding to iommu group 40
> 2025-05-21T10:59:23.314723+00:00 mc-misc2002 kernel: [   10.112602] pci 0=
000:00:16.4: Adding to iommu group 40
> 2025-05-21T10:59:23.314723+00:00 mc-misc2002 kernel: [   10.118399] pci 0=
000:00:17.0: Adding to iommu group 41
> 2025-05-21T10:59:23.314727+00:00 mc-misc2002 kernel: [   10.124230] pci 0=
000:00:1c.0: Adding to iommu group 42
> 2025-05-21T10:59:23.314728+00:00 mc-misc2002 kernel: [   10.130029] pci 0=
000:00:1c.4: Adding to iommu group 43
> 2025-05-21T10:59:23.314728+00:00 mc-misc2002 kernel: [   10.135828] pci 0=
000:00:1c.5: Adding to iommu group 44
> 2025-05-21T10:59:23.314729+00:00 mc-misc2002 kernel: [   10.141727] pci 0=
000:00:1f.0: Adding to iommu group 45
> 2025-05-21T10:59:23.314729+00:00 mc-misc2002 kernel: [   10.147530] pci 0=
000:00:1f.2: Adding to iommu group 45
> 2025-05-21T10:59:23.314730+00:00 mc-misc2002 kernel: [   10.153331] pci 0=
000:00:1f.4: Adding to iommu group 45
> 2025-05-21T10:59:23.314734+00:00 mc-misc2002 kernel: [   10.159131] pci 0=
000:00:1f.5: Adding to iommu group 45
> 2025-05-21T10:59:23.314734+00:00 mc-misc2002 kernel: [   10.164931] pci 0=
000:03:00.0: Adding to iommu group 46
> 2025-05-21T10:59:23.314735+00:00 mc-misc2002 kernel: [   10.170703] pci 0=
000:04:00.0: Adding to iommu group 46
> 2025-05-21T10:59:23.314735+00:00 mc-misc2002 kernel: [   10.176501] pci 0=
000:16:00.0: Adding to iommu group 47
> 2025-05-21T10:59:23.314735+00:00 mc-misc2002 kernel: [   10.182299] pci 0=
000:16:00.1: Adding to iommu group 48
> 2025-05-21T10:59:23.314736+00:00 mc-misc2002 kernel: [   10.188099] pci 0=
000:16:00.2: Adding to iommu group 49
> 2025-05-21T10:59:23.314736+00:00 mc-misc2002 kernel: [   10.193898] pci 0=
000:16:00.4: Adding to iommu group 50
> 2025-05-21T10:59:23.314740+00:00 mc-misc2002 kernel: [   10.199699] pci 0=
000:30:00.0: Adding to iommu group 51
> 2025-05-21T10:59:23.314741+00:00 mc-misc2002 kernel: [   10.205498] pci 0=
000:30:00.1: Adding to iommu group 52
> 2025-05-21T10:59:23.314741+00:00 mc-misc2002 kernel: [   10.211296] pci 0=
000:30:00.2: Adding to iommu group 53
> 2025-05-21T10:59:23.314742+00:00 mc-misc2002 kernel: [   10.217096] pci 0=
000:30:00.4: Adding to iommu group 54
> 2025-05-21T10:59:23.314742+00:00 mc-misc2002 kernel: [   10.222897] pci 0=
000:4a:00.0: Adding to iommu group 55
> 2025-05-21T10:59:23.314742+00:00 mc-misc2002 kernel: [   10.228705] pci 0=
000:4a:00.1: Adding to iommu group 56
> 2025-05-21T10:59:23.314747+00:00 mc-misc2002 kernel: [   10.234504] pci 0=
000:4a:00.2: Adding to iommu group 57
> 2025-05-21T10:59:23.314747+00:00 mc-misc2002 kernel: [   10.240303] pci 0=
000:4a:00.4: Adding to iommu group 58
> 2025-05-21T10:59:23.314748+00:00 mc-misc2002 kernel: [   10.246104] pci 0=
000:64:00.0: Adding to iommu group 59
> 2025-05-21T10:59:23.314748+00:00 mc-misc2002 kernel: [   10.251907] pci 0=
000:64:00.1: Adding to iommu group 60
> 2025-05-21T10:59:23.314748+00:00 mc-misc2002 kernel: [   10.257705] pci 0=
000:64:00.2: Adding to iommu group 61
> 2025-05-21T10:59:23.314749+00:00 mc-misc2002 kernel: [   10.263504] pci 0=
000:64:00.4: Adding to iommu group 62
> 2025-05-21T10:59:23.314753+00:00 mc-misc2002 kernel: [   10.269305] pci 0=
000:7e:00.0: Adding to iommu group 63
> 2025-05-21T10:59:23.314754+00:00 mc-misc2002 kernel: [   10.275105] pci 0=
000:7e:00.1: Adding to iommu group 64
> 2025-05-21T10:59:23.314754+00:00 mc-misc2002 kernel: [   10.280905] pci 0=
000:7e:00.2: Adding to iommu group 65
> 2025-05-21T10:59:23.314754+00:00 mc-misc2002 kernel: [   10.286703] pci 0=
000:7e:00.3: Adding to iommu group 66
> 2025-05-21T10:59:23.314755+00:00 mc-misc2002 kernel: [   10.292501] pci 0=
000:7e:00.5: Adding to iommu group 67
> 2025-05-21T10:59:23.314755+00:00 mc-misc2002 kernel: [   10.298299] pci 0=
000:7e:02.0: Adding to iommu group 68
> 2025-05-21T10:59:23.314756+00:00 mc-misc2002 kernel: [   10.304099] pci 0=
000:7e:02.1: Adding to iommu group 69
> 2025-05-21T10:59:23.314764+00:00 mc-misc2002 kernel: [   10.309898] pci 0=
000:7e:02.2: Adding to iommu group 70
> 2025-05-21T10:59:23.314764+00:00 mc-misc2002 kernel: [   10.315698] pci 0=
000:7e:04.0: Adding to iommu group 71
> 2025-05-21T10:59:23.314765+00:00 mc-misc2002 kernel: [   10.321495] pci 0=
000:7e:04.1: Adding to iommu group 72
> 2025-05-21T10:59:23.314765+00:00 mc-misc2002 kernel: [   10.327294] pci 0=
000:7e:04.2: Adding to iommu group 73
> 2025-05-21T10:59:23.314765+00:00 mc-misc2002 kernel: [   10.333090] pci 0=
000:7e:04.3: Adding to iommu group 74
> 2025-05-21T10:59:23.314766+00:00 mc-misc2002 kernel: [   10.338890] pci 0=
000:7e:05.0: Adding to iommu group 75
> 2025-05-21T10:59:23.314770+00:00 mc-misc2002 kernel: [   10.344691] pci 0=
000:7e:05.1: Adding to iommu group 76
> 2025-05-21T10:59:23.314771+00:00 mc-misc2002 kernel: [   10.350489] pci 0=
000:7e:05.2: Adding to iommu group 77
> 2025-05-21T10:59:23.314771+00:00 mc-misc2002 kernel: [   10.356288] pci 0=
000:7e:06.0: Adding to iommu group 78
> 2025-05-21T10:59:23.314771+00:00 mc-misc2002 kernel: [   10.362086] pci 0=
000:7e:06.1: Adding to iommu group 79
> 2025-05-21T10:59:23.314772+00:00 mc-misc2002 kernel: [   10.367884] pci 0=
000:7e:06.2: Adding to iommu group 80
> 2025-05-21T10:59:23.314772+00:00 mc-misc2002 kernel: [   10.373681] pci 0=
000:7e:07.0: Adding to iommu group 81
> 2025-05-21T10:59:23.314773+00:00 mc-misc2002 kernel: [   10.379480] pci 0=
000:7e:07.1: Adding to iommu group 82
> 2025-05-21T10:59:23.314778+00:00 mc-misc2002 kernel: [   10.385276] pci 0=
000:7e:07.2: Adding to iommu group 83
> 2025-05-21T10:59:23.314778+00:00 mc-misc2002 kernel: [   10.391151] pci 0=
000:7e:0b.0: Adding to iommu group 84
> 2025-05-21T10:59:23.314779+00:00 mc-misc2002 kernel: [   10.396957] pci 0=
000:7e:0b.1: Adding to iommu group 84
> 2025-05-21T10:59:23.314779+00:00 mc-misc2002 kernel: [   10.402761] pci 0=
000:7e:0b.2: Adding to iommu group 84
> 2025-05-21T10:59:23.314779+00:00 mc-misc2002 kernel: [   10.408560] pci 0=
000:7e:0c.0: Adding to iommu group 85
> 2025-05-21T10:59:23.314780+00:00 mc-misc2002 kernel: [   10.414360] pci 0=
000:7e:0d.0: Adding to iommu group 86
> 2025-05-21T10:59:23.314784+00:00 mc-misc2002 kernel: [   10.420159] pci 0=
000:7e:0e.0: Adding to iommu group 87
> 2025-05-21T10:59:23.314785+00:00 mc-misc2002 kernel: [   10.425958] pci 0=
000:7e:0f.0: Adding to iommu group 88
> 2025-05-21T10:59:23.314785+00:00 mc-misc2002 kernel: [   10.431757] pci 0=
000:7e:1a.0: Adding to iommu group 89
> 2025-05-21T10:59:23.314785+00:00 mc-misc2002 kernel: [   10.437556] pci 0=
000:7e:1b.0: Adding to iommu group 90
> 2025-05-21T10:59:23.314786+00:00 mc-misc2002 kernel: [   10.443354] pci 0=
000:7e:1c.0: Adding to iommu group 91
> 2025-05-21T10:59:23.314786+00:00 mc-misc2002 kernel: [   10.449155] pci 0=
000:7e:1d.0: Adding to iommu group 92
> 2025-05-21T10:59:23.314790+00:00 mc-misc2002 kernel: [   10.454952] pci 0=
000:7f:00.0: Adding to iommu group 93
> 2025-05-21T10:59:23.314791+00:00 mc-misc2002 kernel: [   10.460756] pci 0=
000:7f:00.1: Adding to iommu group 94
> 2025-05-21T10:59:23.314791+00:00 mc-misc2002 kernel: [   10.466555] pci 0=
000:7f:00.2: Adding to iommu group 95
> 2025-05-21T10:59:23.314792+00:00 mc-misc2002 kernel: [   10.472352] pci 0=
000:7f:00.3: Adding to iommu group 96
> 2025-05-21T10:59:23.314792+00:00 mc-misc2002 kernel: [   10.478150] pci 0=
000:7f:00.4: Adding to iommu group 97
> 2025-05-21T10:59:23.314792+00:00 mc-misc2002 kernel: [   10.483948] pci 0=
000:7f:00.5: Adding to iommu group 98
> 2025-05-21T10:59:23.314793+00:00 mc-misc2002 kernel: [   10.489749] pci 0=
000:7f:00.6: Adding to iommu group 99
> 2025-05-21T10:59:23.314797+00:00 mc-misc2002 kernel: [   10.495549] pci 0=
000:7f:00.7: Adding to iommu group 100
> 2025-05-21T10:59:23.314797+00:00 mc-misc2002 kernel: [   10.501446] pci 0=
000:7f:01.0: Adding to iommu group 101
> 2025-05-21T10:59:23.314798+00:00 mc-misc2002 kernel: [   10.507343] pci 0=
000:7f:01.1: Adding to iommu group 102
> 2025-05-21T10:59:23.314798+00:00 mc-misc2002 kernel: [   10.513239] pci 0=
000:7f:01.2: Adding to iommu group 103
> 2025-05-21T10:59:23.314799+00:00 mc-misc2002 kernel: [   10.519133] pci 0=
000:7f:01.3: Adding to iommu group 104
> 2025-05-21T10:59:23.314799+00:00 mc-misc2002 kernel: [   10.525029] pci 0=
000:7f:0a.0: Adding to iommu group 105
> 2025-05-21T10:59:23.314803+00:00 mc-misc2002 kernel: [   10.530924] pci 0=
000:7f:0a.1: Adding to iommu group 106
> 2025-05-21T10:59:23.314804+00:00 mc-misc2002 kernel: [   10.536822] pci 0=
000:7f:0a.2: Adding to iommu group 107
> 2025-05-21T10:59:23.314804+00:00 mc-misc2002 kernel: [   10.542718] pci 0=
000:7f:0a.3: Adding to iommu group 108
> 2025-05-21T10:59:23.314804+00:00 mc-misc2002 kernel: [   10.548613] pci 0=
000:7f:0a.4: Adding to iommu group 109
> 2025-05-21T10:59:23.314805+00:00 mc-misc2002 kernel: [   10.554508] pci 0=
000:7f:0a.5: Adding to iommu group 110
> 2025-05-21T10:59:23.314805+00:00 mc-misc2002 kernel: [   10.560403] pci 0=
000:7f:0a.6: Adding to iommu group 111
> 2025-05-21T10:59:23.314806+00:00 mc-misc2002 kernel: [   10.566300] pci 0=
000:7f:0a.7: Adding to iommu group 112
> 2025-05-21T10:59:23.314809+00:00 mc-misc2002 kernel: [   10.572196] pci 0=
000:7f:0b.0: Adding to iommu group 113
> 2025-05-21T10:59:23.314810+00:00 mc-misc2002 kernel: [   10.578091] pci 0=
000:7f:0b.1: Adding to iommu group 114
> 2025-05-21T10:59:23.314810+00:00 mc-misc2002 kernel: [   10.583990] pci 0=
000:7f:0b.2: Adding to iommu group 115
> 2025-05-21T10:59:23.314811+00:00 mc-misc2002 kernel: [   10.589885] pci 0=
000:7f:0b.3: Adding to iommu group 116
> 2025-05-21T10:59:23.314811+00:00 mc-misc2002 kernel: [   10.595780] pci 0=
000:7f:1d.0: Adding to iommu group 117
> 2025-05-21T10:59:23.314812+00:00 mc-misc2002 kernel: [   10.601678] pci 0=
000:7f:1d.1: Adding to iommu group 118
> 2025-05-21T10:59:23.314815+00:00 mc-misc2002 kernel: [   10.607777] pci 0=
000:7f:1e.0: Adding to iommu group 119
> 2025-05-21T10:59:23.314816+00:00 mc-misc2002 kernel: [   10.613683] pci 0=
000:7f:1e.1: Adding to iommu group 119
> 2025-05-21T10:59:23.314816+00:00 mc-misc2002 kernel: [   10.619590] pci 0=
000:7f:1e.2: Adding to iommu group 119
> 2025-05-21T10:59:23.314817+00:00 mc-misc2002 kernel: [   10.625497] pci 0=
000:7f:1e.3: Adding to iommu group 119
> 2025-05-21T10:59:23.314817+00:00 mc-misc2002 kernel: [   10.631404] pci 0=
000:7f:1e.4: Adding to iommu group 119
> 2025-05-21T10:59:23.314818+00:00 mc-misc2002 kernel: [   10.637311] pci 0=
000:7f:1e.5: Adding to iommu group 119
> 2025-05-21T10:59:23.314822+00:00 mc-misc2002 kernel: [   10.643216] pci 0=
000:7f:1e.6: Adding to iommu group 119
> 2025-05-21T10:59:23.314822+00:00 mc-misc2002 kernel: [   10.649124] pci 0=
000:7f:1e.7: Adding to iommu group 119
> 2025-05-21T10:59:23.314823+00:00 mc-misc2002 kernel: [   10.655011] pci 0=
000:80:00.0: Adding to iommu group 120
> 2025-05-21T10:59:23.314823+00:00 mc-misc2002 kernel: [   10.660908] pci 0=
000:80:00.1: Adding to iommu group 121
> 2025-05-21T10:59:23.314823+00:00 mc-misc2002 kernel: [   10.666803] pci 0=
000:80:00.2: Adding to iommu group 122
> 2025-05-21T10:59:23.314824+00:00 mc-misc2002 kernel: [   10.672702] pci 0=
000:80:00.4: Adding to iommu group 123
> 2025-05-21T10:59:23.314824+00:00 mc-misc2002 kernel: [   10.678679] pci 0=
000:80:02.0: Adding to iommu group 124
> 2025-05-21T10:59:23.314828+00:00 mc-misc2002 kernel: [   10.684587] pci 0=
000:80:02.1: Adding to iommu group 124
> 2025-05-21T10:59:23.314829+00:00 mc-misc2002 kernel: [   10.690489] pci 0=
000:80:02.4: Adding to iommu group 124
> 2025-05-21T10:59:23.314829+00:00 mc-misc2002 kernel: [   10.696383] pci 0=
000:97:00.0: Adding to iommu group 125
> 2025-05-21T10:59:23.314830+00:00 mc-misc2002 kernel: [   10.702281] pci 0=
000:97:00.1: Adding to iommu group 126
> 2025-05-21T10:59:23.314830+00:00 mc-misc2002 kernel: [   10.708177] pci 0=
000:97:00.2: Adding to iommu group 127
> 2025-05-21T10:59:23.314830+00:00 mc-misc2002 kernel: [   10.714073] pci 0=
000:97:00.4: Adding to iommu group 128
> 2025-05-21T10:59:23.314835+00:00 mc-misc2002 kernel: [   10.719971] pci 0=
000:b0:00.0: Adding to iommu group 129
> 2025-05-21T10:59:23.314836+00:00 mc-misc2002 kernel: [   10.725869] pci 0=
000:b0:00.1: Adding to iommu group 130
> 2025-05-21T10:59:23.314836+00:00 mc-misc2002 kernel: [   10.731763] pci 0=
000:b0:00.2: Adding to iommu group 131
> 2025-05-21T10:59:23.314837+00:00 mc-misc2002 kernel: [   10.737660] pci 0=
000:b0:00.4: Adding to iommu group 132
> 2025-05-21T10:59:23.314837+00:00 mc-misc2002 kernel: [   10.743557] pci 0=
000:c9:00.0: Adding to iommu group 133
> 2025-05-21T10:59:23.314838+00:00 mc-misc2002 kernel: [   10.749454] pci 0=
000:c9:00.1: Adding to iommu group 134
> 2025-05-21T10:59:23.314838+00:00 mc-misc2002 kernel: [   10.755348] pci 0=
000:c9:00.2: Adding to iommu group 135
> 2025-05-21T10:59:23.314849+00:00 mc-misc2002 kernel: [   10.761242] pci 0=
000:c9:00.4: Adding to iommu group 136
> 2025-05-21T10:59:23.314849+00:00 mc-misc2002 kernel: [   10.767139] pci 0=
000:e2:00.0: Adding to iommu group 137
> 2025-05-21T10:59:23.314850+00:00 mc-misc2002 kernel: [   10.773039] pci 0=
000:e2:00.1: Adding to iommu group 138
> 2025-05-21T10:59:23.314850+00:00 mc-misc2002 kernel: [   10.778937] pci 0=
000:e2:00.2: Adding to iommu group 139
> 2025-05-21T10:59:23.314851+00:00 mc-misc2002 kernel: [   10.784831] pci 0=
000:e2:00.4: Adding to iommu group 140
> 2025-05-21T10:59:23.314851+00:00 mc-misc2002 kernel: [   10.790728] pci 0=
000:fe:00.0: Adding to iommu group 141
> 2025-05-21T10:59:23.314855+00:00 mc-misc2002 kernel: [   10.796623] pci 0=
000:fe:00.1: Adding to iommu group 142
> 2025-05-21T10:59:23.314856+00:00 mc-misc2002 kernel: [   10.802519] pci 0=
000:fe:00.2: Adding to iommu group 143
> 2025-05-21T10:59:23.314856+00:00 mc-misc2002 kernel: [   10.808417] pci 0=
000:fe:00.3: Adding to iommu group 144
> 2025-05-21T10:59:23.314857+00:00 mc-misc2002 kernel: [   10.814314] pci 0=
000:fe:00.5: Adding to iommu group 145
> 2025-05-21T10:59:23.314857+00:00 mc-misc2002 kernel: [   10.820212] pci 0=
000:fe:02.0: Adding to iommu group 146
> 2025-05-21T10:59:23.314858+00:00 mc-misc2002 kernel: [   10.826108] pci 0=
000:fe:02.1: Adding to iommu group 147
> 2025-05-21T10:59:23.314862+00:00 mc-misc2002 kernel: [   10.832004] pci 0=
000:fe:02.2: Adding to iommu group 148
> 2025-05-21T10:59:23.314862+00:00 mc-misc2002 kernel: [   10.837901] pci 0=
000:fe:04.0: Adding to iommu group 149
> 2025-05-21T10:59:23.314863+00:00 mc-misc2002 kernel: [   10.843798] pci 0=
000:fe:04.1: Adding to iommu group 150
> 2025-05-21T10:59:23.314863+00:00 mc-misc2002 kernel: [   10.849693] pci 0=
000:fe:04.2: Adding to iommu group 151
> 2025-05-21T10:59:23.314863+00:00 mc-misc2002 kernel: [   10.855589] pci 0=
000:fe:04.3: Adding to iommu group 152
> 2025-05-21T10:59:23.314864+00:00 mc-misc2002 kernel: [   10.861485] pci 0=
000:fe:05.0: Adding to iommu group 153
> 2025-05-21T10:59:23.314864+00:00 mc-misc2002 kernel: [   10.867382] pci 0=
000:fe:05.1: Adding to iommu group 154
> 2025-05-21T10:59:23.314868+00:00 mc-misc2002 kernel: [   10.873278] pci 0=
000:fe:05.2: Adding to iommu group 155
> 2025-05-21T10:59:23.314869+00:00 mc-misc2002 kernel: [   10.879177] pci 0=
000:fe:06.0: Adding to iommu group 156
> 2025-05-21T10:59:23.314869+00:00 mc-misc2002 kernel: [   10.885072] pci 0=
000:fe:06.1: Adding to iommu group 157
> 2025-05-21T10:59:23.314869+00:00 mc-misc2002 kernel: [   10.890969] pci 0=
000:fe:06.2: Adding to iommu group 158
> 2025-05-21T10:59:23.314870+00:00 mc-misc2002 kernel: [   10.896867] pci 0=
000:fe:07.0: Adding to iommu group 159
> 2025-05-21T10:59:23.314870+00:00 mc-misc2002 kernel: [   10.902764] pci 0=
000:fe:07.1: Adding to iommu group 160
> 2025-05-21T10:59:23.314876+00:00 mc-misc2002 kernel: [   10.908659] pci 0=
000:fe:07.2: Adding to iommu group 161
> 2025-05-21T10:59:23.314877+00:00 mc-misc2002 kernel: [   10.914630] pci 0=
000:fe:0b.0: Adding to iommu group 162
> 2025-05-21T10:59:23.314877+00:00 mc-misc2002 kernel: [   10.920544] pci 0=
000:fe:0b.1: Adding to iommu group 162
> 2025-05-21T10:59:23.314877+00:00 mc-misc2002 kernel: [   10.926460] pci 0=
000:fe:0b.2: Adding to iommu group 162
> 2025-05-21T10:59:23.314878+00:00 mc-misc2002 kernel: [   10.932353] pci 0=
000:fe:0c.0: Adding to iommu group 163
> 2025-05-21T10:59:23.314878+00:00 mc-misc2002 kernel: [   10.938249] pci 0=
000:fe:0d.0: Adding to iommu group 164
> 2025-05-21T10:59:23.314879+00:00 mc-misc2002 kernel: [   10.944148] pci 0=
000:fe:0e.0: Adding to iommu group 165
> 2025-05-21T10:59:23.314883+00:00 mc-misc2002 kernel: [   10.950043] pci 0=
000:fe:0f.0: Adding to iommu group 166
> 2025-05-21T10:59:23.314883+00:00 mc-misc2002 kernel: [   10.955941] pci 0=
000:fe:1a.0: Adding to iommu group 167
> 2025-05-21T10:59:23.314884+00:00 mc-misc2002 kernel: [   10.961838] pci 0=
000:fe:1b.0: Adding to iommu group 168
> 2025-05-21T10:59:23.314884+00:00 mc-misc2002 kernel: [   10.967736] pci 0=
000:fe:1c.0: Adding to iommu group 169
> 2025-05-21T10:59:23.314884+00:00 mc-misc2002 kernel: [   10.973634] pci 0=
000:fe:1d.0: Adding to iommu group 170
> 2025-05-21T10:59:23.314885+00:00 mc-misc2002 kernel: [   10.979533] pci 0=
000:ff:00.0: Adding to iommu group 171
> 2025-05-21T10:59:23.314889+00:00 mc-misc2002 kernel: [   10.985429] pci 0=
000:ff:00.1: Adding to iommu group 172
> 2025-05-21T10:59:23.314889+00:00 mc-misc2002 kernel: [   10.991326] pci 0=
000:ff:00.2: Adding to iommu group 173
> 2025-05-21T10:59:23.314890+00:00 mc-misc2002 kernel: [   10.997221] pci 0=
000:ff:00.3: Adding to iommu group 174
> 2025-05-21T10:59:23.314890+00:00 mc-misc2002 kernel: [   11.003117] pci 0=
000:ff:00.4: Adding to iommu group 175
> 2025-05-21T10:59:23.314890+00:00 mc-misc2002 kernel: [   11.009014] pci 0=
000:ff:00.5: Adding to iommu group 176
> 2025-05-21T10:59:23.314891+00:00 mc-misc2002 kernel: [   11.014911] pci 0=
000:ff:00.6: Adding to iommu group 177
> 2025-05-21T10:59:23.314895+00:00 mc-misc2002 kernel: [   11.020806] pci 0=
000:ff:00.7: Adding to iommu group 178
> 2025-05-21T10:59:23.314895+00:00 mc-misc2002 kernel: [   11.026703] pci 0=
000:ff:01.0: Adding to iommu group 179
> 2025-05-21T10:59:23.314896+00:00 mc-misc2002 kernel: [   11.032599] pci 0=
000:ff:01.1: Adding to iommu group 180
> 2025-05-21T10:59:23.314896+00:00 mc-misc2002 kernel: [   11.038494] pci 0=
000:ff:01.2: Adding to iommu group 181
> 2025-05-21T10:59:23.314897+00:00 mc-misc2002 kernel: [   11.044391] pci 0=
000:ff:01.3: Adding to iommu group 182
> 2025-05-21T10:59:23.314897+00:00 mc-misc2002 kernel: [   11.050288] pci 0=
000:ff:0a.0: Adding to iommu group 183
> 2025-05-21T10:59:23.314897+00:00 mc-misc2002 kernel: [   11.056184] pci 0=
000:ff:0a.1: Adding to iommu group 184
> 2025-05-21T10:59:23.314901+00:00 mc-misc2002 kernel: [   11.062083] pci 0=
000:ff:0a.2: Adding to iommu group 185
> 2025-05-21T10:59:23.314902+00:00 mc-misc2002 kernel: [   11.067979] pci 0=
000:ff:0a.3: Adding to iommu group 186
> 2025-05-21T10:59:23.314902+00:00 mc-misc2002 kernel: [   11.073873] pci 0=
000:ff:0a.4: Adding to iommu group 187
> 2025-05-21T10:59:23.314903+00:00 mc-misc2002 kernel: [   11.079772] pci 0=
000:ff:0a.5: Adding to iommu group 188
> 2025-05-21T10:59:23.314903+00:00 mc-misc2002 kernel: [   11.085668] pci 0=
000:ff:0a.6: Adding to iommu group 189
> 2025-05-21T10:59:23.314904+00:00 mc-misc2002 kernel: [   11.091565] pci 0=
000:ff:0a.7: Adding to iommu group 190
> 2025-05-21T10:59:23.314908+00:00 mc-misc2002 kernel: [   11.097461] pci 0=
000:ff:0b.0: Adding to iommu group 191
> 2025-05-21T10:59:23.314908+00:00 mc-misc2002 kernel: [   11.103359] pci 0=
000:ff:0b.1: Adding to iommu group 192
> 2025-05-21T10:59:23.314909+00:00 mc-misc2002 kernel: [   11.109262] pci 0=
000:ff:0b.2: Adding to iommu group 193
> 2025-05-21T10:59:23.314909+00:00 mc-misc2002 kernel: [   11.115157] pci 0=
000:ff:0b.3: Adding to iommu group 194
> 2025-05-21T10:59:23.314910+00:00 mc-misc2002 kernel: [   11.121051] pci 0=
000:ff:1d.0: Adding to iommu group 195
> 2025-05-21T10:59:23.314910+00:00 mc-misc2002 kernel: [   11.126948] pci 0=
000:ff:1d.1: Adding to iommu group 196
> 2025-05-21T10:59:23.314910+00:00 mc-misc2002 kernel: [   11.133049] pci 0=
000:ff:1e.0: Adding to iommu group 197
> 2025-05-21T10:59:23.314914+00:00 mc-misc2002 kernel: [   11.138966] pci 0=
000:ff:1e.1: Adding to iommu group 197
> 2025-05-21T10:59:23.314915+00:00 mc-misc2002 kernel: [   11.144877] pci 0=
000:ff:1e.2: Adding to iommu group 197
> 2025-05-21T10:59:23.314915+00:00 mc-misc2002 kernel: [   11.150796] pci 0=
000:ff:1e.3: Adding to iommu group 197
> 2025-05-21T10:59:23.314916+00:00 mc-misc2002 kernel: [   11.156716] pci 0=
000:ff:1e.4: Adding to iommu group 197
> 2025-05-21T10:59:23.314916+00:00 mc-misc2002 kernel: [   11.162634] pci 0=
000:ff:1e.5: Adding to iommu group 197
> 2025-05-21T10:59:23.314917+00:00 mc-misc2002 kernel: [   11.168552] pci 0=
000:ff:1e.6: Adding to iommu group 197
> 2025-05-21T10:59:23.314921+00:00 mc-misc2002 kernel: [   11.174469] pci 0=
000:ff:1e.7: Adding to iommu group 197
> 2025-05-21T10:59:23.314921+00:00 mc-misc2002 kernel: [   11.228467] DMAR:=
 Intel(R) Virtualization Technology for Directed I/O
> 2025-05-21T10:59:23.314922+00:00 mc-misc2002 kernel: [   11.235704] PCI-D=
MA: Using software bounce buffering for IO (SWIOTLB)
> 2025-05-21T10:59:23.314922+00:00 mc-misc2002 kernel: [   11.242935] softw=
are IO TLB: mapped [mem 0x00000000605ff000-0x00000000645ff000] (64MB)
> 2025-05-21T10:59:23.314923+00:00 mc-misc2002 kernel: [   11.252778] Initi=
alise system trusted keyrings
> 2025-05-21T10:59:23.314923+00:00 mc-misc2002 kernel: [   11.257778] Key t=
ype blacklist registered
> 2025-05-21T10:59:23.314927+00:00 mc-misc2002 kernel: [   11.262360] worki=
ngset: timestamp_bits=3D36 max_order=3D26 bucket_order=3D0
> 2025-05-21T10:59:23.314927+00:00 mc-misc2002 kernel: [   11.270681] zbud:=
 loaded
> 2025-05-21T10:59:23.314928+00:00 mc-misc2002 kernel: [   11.273814] integ=
rity: Platform Keyring initialized
> 2025-05-21T10:59:23.314928+00:00 mc-misc2002 kernel: [   11.279296] integ=
rity: Machine keyring initialized
> 2025-05-21T10:59:23.314929+00:00 mc-misc2002 kernel: [   11.284676] Key t=
ype asymmetric registered
> 2025-05-21T10:59:23.314929+00:00 mc-misc2002 kernel: [   11.289275] Asymm=
etric key parser 'x509' registered
> 2025-05-21T10:59:23.314930+00:00 mc-misc2002 kernel: [   11.299517] alg: =
self-tests for CTR-KDF (hmac(sha256)) passed
> 2025-05-21T10:59:23.314934+00:00 mc-misc2002 kernel: [   11.305994] Block=
 layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
> 2025-05-21T10:59:23.314934+00:00 mc-misc2002 kernel: [   11.314362] io sc=
heduler mq-deadline registered
> 2025-05-21T10:59:23.314935+00:00 mc-misc2002 kernel: [   11.320899] pciep=
ort 0000:00:1c.0: PME: Signaling with IRQ 130
> 2025-05-21T10:59:23.314935+00:00 mc-misc2002 kernel: [   11.327472] pciep=
ort 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- H=
otPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> 2025-05-21T10:59:23.314936+00:00 mc-misc2002 kernel: [   11.342847] pciep=
ort 0000:00:1c.4: PME: Signaling with IRQ 131
> 2025-05-21T10:59:23.314936+00:00 mc-misc2002 kernel: [   11.349580] pciep=
ort 0000:00:1c.5: PME: Signaling with IRQ 132
> 2025-05-21T10:59:23.314940+00:00 mc-misc2002 kernel: [   11.356280] pciep=
ort 0000:4a:05.0: PME: Signaling with IRQ 133
> 2025-05-21T10:59:23.314940+00:00 mc-misc2002 kernel: [   11.362963] pciep=
ort 0000:64:02.0: PME: Signaling with IRQ 134
> 2025-05-21T10:59:23.314941+00:00 mc-misc2002 kernel: [   11.369529] pciep=
ort 0000:64:02.0: pciehp: Slot #48 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:59:23.314941+00:00 mc-misc2002 kernel: [   11.387386] pciep=
ort 0000:64:03.0: PME: Signaling with IRQ 135
> 2025-05-21T10:59:23.314942+00:00 mc-misc2002 kernel: [   11.393950] pciep=
ort 0000:64:03.0: pciehp: Slot #49 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:59:23.314942+00:00 mc-misc2002 kernel: [   11.411805] pciep=
ort 0000:64:04.0: PME: Signaling with IRQ 136
> 2025-05-21T10:59:23.314946+00:00 mc-misc2002 kernel: [   11.418369] pciep=
ort 0000:64:04.0: pciehp: Slot #50 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:59:23.314947+00:00 mc-misc2002 kernel: [   11.436210] pciep=
ort 0000:64:05.0: PME: Signaling with IRQ 137
> 2025-05-21T10:59:23.314947+00:00 mc-misc2002 kernel: [   11.442774] pciep=
ort 0000:64:05.0: pciehp: Slot #51 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:59:23.314948+00:00 mc-misc2002 kernel: [   11.460784] pciep=
ort 0000:97:04.0: PME: Signaling with IRQ 138
> 2025-05-21T10:59:23.314948+00:00 mc-misc2002 kernel: [   11.467503] pciep=
ort 0000:c9:02.0: PME: Signaling with IRQ 139
> 2025-05-21T10:59:23.314949+00:00 mc-misc2002 kernel: [   11.474076] pciep=
ort 0000:c9:02.0: pciehp: Slot #52 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:59:23.314953+00:00 mc-misc2002 kernel: [   11.491935] pciep=
ort 0000:c9:03.0: PME: Signaling with IRQ 140
> 2025-05-21T10:59:23.314953+00:00 mc-misc2002 kernel: [   11.498502] pciep=
ort 0000:c9:03.0: pciehp: Slot #53 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:59:23.314954+00:00 mc-misc2002 kernel: [   11.516358] pciep=
ort 0000:e2:02.0: PME: Signaling with IRQ 141
> 2025-05-21T10:59:23.314954+00:00 mc-misc2002 kernel: [   11.522930] pciep=
ort 0000:e2:02.0: pciehp: Slot #54 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:59:23.314955+00:00 mc-misc2002 kernel: [   11.540768] pciep=
ort 0000:e2:03.0: PME: Signaling with IRQ 142
> 2025-05-21T10:59:23.314959+00:00 mc-misc2002 kernel: [   11.547332] pciep=
ort 0000:e2:03.0: pciehp: Slot #55 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:59:23.314959+00:00 mc-misc2002 kernel: [   11.565178] pciep=
ort 0000:e2:04.0: PME: Signaling with IRQ 143
> 2025-05-21T10:59:23.314960+00:00 mc-misc2002 kernel: [   11.571734] pciep=
ort 0000:e2:04.0: pciehp: Slot #56 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:59:23.314960+00:00 mc-misc2002 kernel: [   11.589578] pciep=
ort 0000:e2:05.0: PME: Signaling with IRQ 144
> 2025-05-21T10:59:23.314961+00:00 mc-misc2002 kernel: [   11.596143] pciep=
ort 0000:e2:05.0: pciehp: Slot #57 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:59:23.314961+00:00 mc-misc2002 kernel: [   11.614123] shpch=
p: Standard Hot Plug PCI Controller Driver version: 0.4
> 2025-05-21T10:59:23.314965+00:00 mc-misc2002 kernel: [   11.621788] Monit=
or-Mwait will be used to enter C-1 state
> 2025-05-21T10:59:23.314966+00:00 mc-misc2002 kernel: [   11.621796] Monit=
or-Mwait will be used to enter C-2 state
> 2025-05-21T10:59:23.314966+00:00 mc-misc2002 kernel: [   11.621801] ACPI:=
 \_SB_.SCK0.C000: Found 2 idle states
> 2025-05-21T10:59:23.314967+00:00 mc-misc2002 kernel: [   11.631239] acpi/=
hmat: Memory (0x0 length 0x80000000) Flags:0003 Processor Domain:0 Memory D=
omain:0
> 2025-05-21T10:59:23.314967+00:00 mc-misc2002 kernel: [   11.641403] acpi/=
hmat: Memory (0x100000000 length 0x1f80000000) Flags:0003 Processor Domain:=
0 Memory Domain:0
> 2025-05-21T10:59:23.314968+00:00 mc-misc2002 kernel: [   11.652534] acpi/=
hmat: Memory (0x2080000000 length 0x2000000000) Flags:0003 Processor Domain=
:1 Memory Domain:1
> 2025-05-21T10:59:23.314973+00:00 mc-misc2002 kernel: [   11.663764] acpi/=
hmat: Locality: Flags:00 Type:Read Latency Initiator Domains:2 Target Domai=
ns:2 Base:100
> 2025-05-21T10:59:23.314974+00:00 mc-misc2002 kernel: [   11.674506] acpi/=
hmat:   Initiator-Target[0-0]:7600 nsec
> 2025-05-21T10:59:23.314974+00:00 mc-misc2002 kernel: [   11.680468] acpi/=
hmat:   Initiator-Target[0-1]:13560 nsec
> 2025-05-21T10:59:23.314975+00:00 mc-misc2002 kernel: [   11.686530] acpi/=
hmat:   Initiator-Target[1-0]:13560 nsec
> 2025-05-21T10:59:23.314975+00:00 mc-misc2002 kernel: [   11.692591] acpi/=
hmat:   Initiator-Target[1-1]:7600 nsec
> 2025-05-21T10:59:23.314976+00:00 mc-misc2002 kernel: [   11.698553] acpi/=
hmat: Locality: Flags:00 Type:Write Latency Initiator Domains:2 Target Doma=
ins:2 Base:100
> 2025-05-21T10:59:23.314980+00:00 mc-misc2002 kernel: [   11.709382] acpi/=
hmat:   Initiator-Target[0-0]:7600 nsec
> 2025-05-21T10:59:23.314980+00:00 mc-misc2002 kernel: [   11.715345] acpi/=
hmat:   Initiator-Target[0-1]:13560 nsec
> 2025-05-21T10:59:23.314981+00:00 mc-misc2002 kernel: [   11.721405] acpi/=
hmat:   Initiator-Target[1-0]:13560 nsec
> 2025-05-21T10:59:23.314981+00:00 mc-misc2002 kernel: [   11.727466] acpi/=
hmat:   Initiator-Target[1-1]:7600 nsec
> 2025-05-21T10:59:23.314982+00:00 mc-misc2002 kernel: [   11.733428] acpi/=
hmat: Locality: Flags:00 Type:Read Bandwidth Initiator Domains:2 Target Dom=
ains:2 Base:1
> 2025-05-21T10:59:23.314982+00:00 mc-misc2002 kernel: [   11.744167] acpi/=
hmat:   Initiator-Target[0-0]:1790 MB/s
> 2025-05-21T10:59:23.314986+00:00 mc-misc2002 kernel: [   11.750129] acpi/=
hmat:   Initiator-Target[0-1]:1790 MB/s
> 2025-05-21T10:59:23.314987+00:00 mc-misc2002 kernel: [   11.756084] acpi/=
hmat:   Initiator-Target[1-0]:1790 MB/s
> 2025-05-21T10:59:23.314987+00:00 mc-misc2002 kernel: [   11.762049] acpi/=
hmat:   Initiator-Target[1-1]:1790 MB/s
> 2025-05-21T10:59:23.314988+00:00 mc-misc2002 kernel: [   11.768016] acpi/=
hmat: Locality: Flags:00 Type:Write Bandwidth Initiator Domains:2 Target Do=
mains:2 Base:1
> 2025-05-21T10:59:23.314988+00:00 mc-misc2002 kernel: [   11.778856] acpi/=
hmat:   Initiator-Target[0-0]:1910 MB/s
> 2025-05-21T10:59:23.314989+00:00 mc-misc2002 kernel: [   11.784818] acpi/=
hmat:   Initiator-Target[0-1]:1910 MB/s
> 2025-05-21T10:59:23.314993+00:00 mc-misc2002 kernel: [   11.790771] acpi/=
hmat:   Initiator-Target[1-0]:1910 MB/s
> 2025-05-21T10:59:23.314993+00:00 mc-misc2002 kernel: [   11.796733] acpi/=
hmat:   Initiator-Target[1-1]:1910 MB/s
> 2025-05-21T10:59:23.314994+00:00 mc-misc2002 kernel: [   11.802959] ERST:=
 Error Record Serialization Table (ERST) support is initialized.
> 2025-05-21T10:59:23.314994+00:00 mc-misc2002 kernel: [   11.811364] pstor=
e: Registered erst as persistent store backend
> 2025-05-21T10:59:23.314994+00:00 mc-misc2002 kernel: [   11.818309] Seria=
l: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 2025-05-21T10:59:23.314995+00:00 mc-misc2002 kernel: [   11.825594] 00:03=
: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) is a 16550A
> 2025-05-21T10:59:23.314999+00:00 mc-misc2002 kernel: [   11.847881] 00:04=
: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) is a 16550A
> 2025-05-21T10:59:23.314999+00:00 mc-misc2002 kernel: [   11.869898] Linux=
 agpgart interface v0.103
> 2025-05-21T10:59:23.315000+00:00 mc-misc2002 kernel: [   11.874696] AMD-V=
i: AMD IOMMUv2 functionality not available on this system - This is not a b=
ug.
> 2025-05-21T10:59:23.315000+00:00 mc-misc2002 kernel: [   11.887964] i8042=
: PNP: No PS/2 controller found.
> 2025-05-21T10:59:23.315001+00:00 mc-misc2002 kernel: [   11.893323] mouse=
dev: PS/2 mouse device common for all mice
> 2025-05-21T10:59:23.315001+00:00 mc-misc2002 kernel: [   11.899602] rtc_c=
mos 00:00: RTC can wake from S4
> 2025-05-21T10:59:23.315001+00:00 mc-misc2002 kernel: [   11.905228] rtc_c=
mos 00:00: registered as rtc0
> 2025-05-21T10:59:23.315005+00:00 mc-misc2002 kernel: [   11.910297] rtc_c=
mos 00:00: setting system clock to 2025-05-21T10:59:10 UTC (1747825150)
> 2025-05-21T10:59:23.315006+00:00 mc-misc2002 kernel: [   11.919404] rtc_c=
mos 00:00: alarms up to one month, y3k, 114 bytes nvram
> 2025-05-21T10:59:23.315006+00:00 mc-misc2002 kernel: [   11.928757] intel=
_pstate: Intel P-state driver initializing
> 2025-05-21T10:59:23.315007+00:00 mc-misc2002 kernel: [   11.945564] ledtr=
ig-cpu: registered to indicate activity on CPUs
> 2025-05-21T10:59:23.315007+00:00 mc-misc2002 kernel: [   11.961878] NET: =
Registered PF_INET6 protocol family
> 2025-05-21T10:59:23.315007+00:00 mc-misc2002 kernel: [   11.974803] Segme=
nt Routing with IPv6
> 2025-05-21T10:59:23.315012+00:00 mc-misc2002 kernel: [   11.978923] In-si=
tu OAM (IOAM) with IPv6
> 2025-05-21T10:59:23.315012+00:00 mc-misc2002 kernel: [   11.983342] mip6:=
 Mobile IPv6
> 2025-05-21T10:59:23.315013+00:00 mc-misc2002 kernel: [   11.986674] NET: =
Registered PF_PACKET protocol family
> 2025-05-21T10:59:23.315013+00:00 mc-misc2002 kernel: [   11.992510] mpls_=
gso: MPLS GSO support
> 2025-05-21T10:59:23.315014+00:00 mc-misc2002 kernel: [   12.009874] micro=
code: sig=3D0x606a6, pf=3D0x1, revision=3D0xd0003f5
> 2025-05-21T10:59:23.315014+00:00 mc-misc2002 kernel: [   12.017160] micro=
code: Microcode Update Driver: v2.2.
> 2025-05-21T10:59:23.315018+00:00 mc-misc2002 kernel: [   12.018144] resct=
rl: L3 allocation detected
> 2025-05-21T10:59:23.315019+00:00 mc-misc2002 kernel: [   12.028510] resct=
rl: MB allocation detected
> 2025-05-21T10:59:23.315019+00:00 mc-misc2002 kernel: [   12.033205] resct=
rl: L3 monitoring detected
> 2025-05-21T10:59:23.315020+00:00 mc-misc2002 kernel: [   12.037903] IPI s=
horthand broadcast: enabled
> 2025-05-21T10:59:23.315020+00:00 mc-misc2002 kernel: [   12.042719] sched=
_clock: Marking stable (10358021617, 1684672688)->(12661722107, -619027802)
> 2025-05-21T10:59:23.315020+00:00 mc-misc2002 kernel: [   12.053502] regis=
tered taskstats version 1
> 2025-05-21T10:59:23.315021+00:00 mc-misc2002 kernel: [   12.058113] Loadi=
ng compiled-in X.509 certificates
> 2025-05-21T10:59:23.315025+00:00 mc-misc2002 kernel: [   12.084913] Loade=
d X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419e=
a1'
> 2025-05-21T10:59:23.315025+00:00 mc-misc2002 kernel: [   12.094693] Loade=
d X.509 cert 'Debian Secure Boot Signer 2022 - linux: 14011249c2675ea8e5148=
542202005810584b25f'
> 2025-05-21T10:59:23.315026+00:00 mc-misc2002 kernel: [   12.110344] zswap=
: loaded using pool lzo/zbud
> 2025-05-21T10:59:23.315026+00:00 mc-misc2002 kernel: [   12.115653] Key t=
ype .fscrypt registered
> 2025-05-21T10:59:23.315027+00:00 mc-misc2002 kernel: [   12.120056] Key t=
ype fscrypt-provisioning registered
> 2025-05-21T10:59:23.315027+00:00 mc-misc2002 kernel: [   12.125933] pstor=
e: Using crash dump compression: deflate
> 2025-05-21T10:59:23.315031+00:00 mc-misc2002 kernel: [   12.137246] Key t=
ype encrypted registered
> 2025-05-21T10:59:23.315031+00:00 mc-misc2002 kernel: [   12.141754] AppAr=
mor: AppArmor sha1 policy hashing enabled
> 2025-05-21T10:59:23.315032+00:00 mc-misc2002 kernel: [   12.147920] ima: =
No TPM chip found, activating TPM-bypass!
> 2025-05-21T10:59:23.315032+00:00 mc-misc2002 kernel: [   12.154068] ima: =
Allocated hash algorithm: sha256
> 2025-05-21T10:59:23.315033+00:00 mc-misc2002 kernel: [   12.159354] ima: =
No architecture policies found
> 2025-05-21T10:59:23.315033+00:00 mc-misc2002 kernel: [   12.164447] evm: =
Initialising EVM extended attributes:
> 2025-05-21T10:59:23.315037+00:00 mc-misc2002 kernel: [   12.170216] evm: =
security.selinux
> 2025-05-21T10:59:23.315038+00:00 mc-misc2002 kernel: [   12.173936] evm: =
security.SMACK64 (disabled)
> 2025-05-21T10:59:23.315038+00:00 mc-misc2002 kernel: [   12.178718] evm: =
security.SMACK64EXEC (disabled)
> 2025-05-21T10:59:23.315039+00:00 mc-misc2002 kernel: [   12.183902] evm: =
security.SMACK64TRANSMUTE (disabled)
> 2025-05-21T10:59:23.315039+00:00 mc-misc2002 kernel: [   12.189571] evm: =
security.SMACK64MMAP (disabled)
> 2025-05-21T10:59:23.315039+00:00 mc-misc2002 kernel: [   12.194752] evm: =
security.apparmor
> 2025-05-21T10:59:23.315040+00:00 mc-misc2002 kernel: [   12.198571] evm: =
security.ima
> 2025-05-21T10:59:23.315044+00:00 mc-misc2002 kernel: [   12.201901] evm: =
security.capability
> 2025-05-21T10:59:23.315044+00:00 mc-misc2002 kernel: [   12.205913] evm: =
HMAC attrs: 0x1
> 2025-05-21T10:59:23.315045+00:00 mc-misc2002 kernel: [   12.268719] tsc: =
Refined TSC clocksource calibration: 2100.000 MHz
> 2025-05-21T10:59:23.315045+00:00 mc-misc2002 kernel: [   12.275685] clock=
source: tsc: mask: 0xffffffffffffffff max_cycles: 0x1e4530a99b6, max_idle_n=
s: 440795257976 ns
> 2025-05-21T10:59:23.315046+00:00 mc-misc2002 kernel: [   12.287053] clock=
source: Switched to clocksource tsc
> 2025-05-21T10:59:23.315046+00:00 mc-misc2002 kernel: [   12.297381] clk: =
Disabling unused clocks
> 2025-05-21T10:59:23.315050+00:00 mc-misc2002 kernel: [   12.305835] Freei=
ng unused decrypted memory: 2036K
> 2025-05-21T10:59:23.315051+00:00 mc-misc2002 kernel: [   12.311746] Freei=
ng unused kernel image (initmem) memory: 2800K
> 2025-05-21T10:59:23.315051+00:00 mc-misc2002 kernel: [   12.318396] Write=
 protecting the kernel read-only data: 26624k
> 2025-05-21T10:59:23.315051+00:00 mc-misc2002 kernel: [   12.325541] Freei=
ng unused kernel image (text/rodata gap) memory: 2040K
> 2025-05-21T10:59:23.315052+00:00 mc-misc2002 kernel: [   12.333219] Freei=
ng unused kernel image (rodata/data gap) memory: 1148K
> 2025-05-21T10:59:23.315052+00:00 mc-misc2002 kernel: [   12.349641] x86/m=
m: Checked W+X mappings: passed, no W+X pages found.
> 2025-05-21T10:59:23.315056+00:00 mc-misc2002 kernel: [   12.356880] Run /=
init as init process
> 2025-05-21T10:59:23.315057+00:00 mc-misc2002 kernel: [   12.360989]   wit=
h arguments:
> 2025-05-21T10:59:23.315057+00:00 mc-misc2002 kernel: [   12.360990]     /=
init
> 2025-05-21T10:59:23.315058+00:00 mc-misc2002 kernel: [   12.360991]   wit=
h environment:
> 2025-05-21T10:59:23.315058+00:00 mc-misc2002 kernel: [   12.360992]     H=
OME=3D/
> 2025-05-21T10:59:23.315058+00:00 mc-misc2002 kernel: [   12.360992]     T=
ERM=3Dlinux
> 2025-05-21T10:59:23.315059+00:00 mc-misc2002 kernel: [   12.360993]     B=
OOT_IMAGE=3D/boot/vmlinuz-6.1.0-34-amd64
> 2025-05-21T10:59:23.315063+00:00 mc-misc2002 kernel: [   12.558362] dca s=
ervice started, version 1.12.1
> 2025-05-21T10:59:23.315064+00:00 mc-misc2002 kernel: [   12.564034] i801_=
smbus 0000:00:1f.4: enabling device (0001 -> 0003)
> 2025-05-21T10:59:23.315064+00:00 mc-misc2002 kernel: [   12.571216] i801_=
smbus 0000:00:1f.4: SPD Write Disable is set
> 2025-05-21T10:59:23.315065+00:00 mc-misc2002 kernel: [   12.577714] i801_=
smbus 0000:00:1f.4: SMBus using PCI interrupt
> 2025-05-21T10:59:23.315065+00:00 mc-misc2002 kernel: [   12.588387] ACPI:=
 bus type USB registered
> 2025-05-21T10:59:23.315065+00:00 mc-misc2002 kernel: [   12.592916] usbco=
re: registered new interface driver usbfs
> 2025-05-21T10:59:23.315071+00:00 mc-misc2002 kernel: [   12.597906] i2c i=
2c-0: 16/16 memory slots populated (from DMI)
> 2025-05-21T10:59:23.315071+00:00 mc-misc2002 kernel: [   12.599084] usbco=
re: registered new interface driver hub
> 2025-05-21T10:59:23.315072+00:00 mc-misc2002 kernel: [   12.605613] i2c i=
2c-0: Systems with more than 4 memory slots not supported yet, not instanti=
ating SPD
> 2025-05-21T10:59:23.315072+00:00 mc-misc2002 kernel: [   12.611601] usbco=
re: registered new device driver usb
> 2025-05-21T10:59:23.315073+00:00 mc-misc2002 kernel: [   12.628603] ACPI =
Warning: \_SB.PC07.QR1C._PRT: Return Package has no elements (empty) (20220=
331/nsprepkg-94)
> 2025-05-21T10:59:23.315073+00:00 mc-misc2002 kernel: [   12.628632] SCSI =
subsystem initialized
> 2025-05-21T10:59:23.315077+00:00 mc-misc2002 kernel: [   12.639787] bnxt_=
en 0000:98:00.0 (unnamed net_device) (uninitialized): Device requests max t=
imeout of 100 seconds, may trigger hung task watchdog
> 2025-05-21T10:59:23.315078+00:00 mc-misc2002 kernel: [   12.662668] igb: =
Intel(R) Gigabit Ethernet Network Driver
> 2025-05-21T10:59:23.315078+00:00 mc-misc2002 kernel: [   12.668725] igb: =
Copyright (c) 2007-2014 Intel Corporation.
> 2025-05-21T10:59:23.315079+00:00 mc-misc2002 kernel: [   12.675113] ACPI =
Warning: \_SB.PC04.BR4D._PRT: Return Package has no elements (empty) (20220=
331/nsprepkg-94)
> 2025-05-21T10:59:23.315079+00:00 mc-misc2002 kernel: [   12.678593] bnxt_=
en 0000:98:00.0 eth0: Broadcom BCM57414 NetXtreme-E 10Gb/25Gb Ethernet foun=
d at mem 206fffe10000, node addr 90:5a:08:00:b7:aa
> 2025-05-21T10:59:23.315079+00:00 mc-misc2002 kernel: [   12.700519] bnxt_=
en 0000:98:00.0: 63.008 Gb/s available PCIe bandwidth (8.0 GT/s PCIe x8 lin=
k)
> 2025-05-21T10:59:23.315083+00:00 mc-misc2002 kernel: [   12.710333] ACPI =
Warning: \_SB.PC07.QR1C._PRT: Return Package has no elements (empty) (20220=
331/nsprepkg-94)
> 2025-05-21T10:59:23.315084+00:00 mc-misc2002 kernel: [   12.710564] xhci_=
hcd 0000:00:14.0: xHCI Host Controller
> 2025-05-21T10:59:23.315085+00:00 mc-misc2002 kernel: [   12.721505] bnxt_=
en 0000:98:00.1 (unnamed net_device) (uninitialized): Device requests max t=
imeout of 100 seconds, may trigger hung task watchdog
> 2025-05-21T10:59:23.315085+00:00 mc-misc2002 kernel: [   12.727276] xhci_=
hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> 2025-05-21T10:59:23.315085+00:00 mc-misc2002 kernel: [   12.752020] xhci_=
hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00000000=
00009810
> 2025-05-21T10:59:23.315086+00:00 mc-misc2002 kernel: [   12.762684] xhci_=
hcd 0000:00:14.0: xHCI Host Controller
> 2025-05-21T10:59:23.315090+00:00 mc-misc2002 kernel: [   12.764638] bnxt_=
en 0000:98:00.1 eth1: Broadcom BCM57414 NetXtreme-E 10Gb/25Gb Ethernet foun=
d at mem 206fffe00000, node addr 90:5a:08:00:b7:ab
> 2025-05-21T10:59:23.315090+00:00 mc-misc2002 kernel: [   12.770629] xhci_=
hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> 2025-05-21T10:59:23.315091+00:00 mc-misc2002 kernel: [   12.782909] bnxt_=
en 0000:98:00.1: 63.008 Gb/s available PCIe bandwidth (8.0 GT/s PCIe x8 lin=
k)
> 2025-05-21T10:59:23.315091+00:00 mc-misc2002 kernel: [   12.791726] xhci_=
hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> 2025-05-21T10:59:23.315092+00:00 mc-misc2002 kernel: [   12.807938] igb 0=
000:4b:00.0: added PHC on eth2
> 2025-05-21T10:59:23.315092+00:00 mc-misc2002 kernel: [   12.813041] igb 0=
000:4b:00.0: Intel(R) Gigabit Ethernet Network Connection
> 2025-05-21T10:59:23.315096+00:00 mc-misc2002 kernel: [   12.820754] igb 0=
000:4b:00.0: eth2: (PCIe:5.0Gb/s:Width x4) 90:5a:08:10:40:a8
> 2025-05-21T10:59:23.315097+00:00 mc-misc2002 kernel: [   12.828846] igb 0=
000:4b:00.0: eth2: PBA No: 010300-000
> 2025-05-21T10:59:23.315097+00:00 mc-misc2002 kernel: [   12.834616] igb 0=
000:4b:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> 2025-05-21T10:59:23.315098+00:00 mc-misc2002 kernel: [   12.843156] usb u=
sb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002, bcdDevice=3D =
6.01
> 2025-05-21T10:59:23.315098+00:00 mc-misc2002 kernel: [   12.852436] usb u=
sb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> 2025-05-21T10:59:23.315098+00:00 mc-misc2002 kernel: [   12.860546] usb u=
sb1: Product: xHCI Host Controller
> 2025-05-21T10:59:23.315102+00:00 mc-misc2002 kernel: [   12.866024] usb u=
sb1: Manufacturer: Linux 6.1.0-34-amd64 xhci-hcd
> 2025-05-21T10:59:23.315103+00:00 mc-misc2002 kernel: [   12.872866] usb u=
sb1: SerialNumber: 0000:00:14.0
> 2025-05-21T10:59:23.315103+00:00 mc-misc2002 kernel: [   12.878137] ACPI =
Warning: \_SB.PC04.BR4D._PRT: Return Package has no elements (empty) (20220=
331/nsprepkg-94)
> 2025-05-21T10:59:23.315104+00:00 mc-misc2002 kernel: [   12.889720] hub 1=
-0:1.0: USB hub found
> 2025-05-21T10:59:23.315104+00:00 mc-misc2002 kernel: [   12.893948] hub 1=
-0:1.0: 16 ports detected
> 2025-05-21T10:59:23.315105+00:00 mc-misc2002 kernel: [   12.900310] libat=
a version 3.00 loaded.
> 2025-05-21T10:59:23.315109+00:00 mc-misc2002 kernel: [   12.900770] usb u=
sb2: New USB device found, idVendor=3D1d6b, idProduct=3D0003, bcdDevice=3D =
6.01
> 2025-05-21T10:59:23.315109+00:00 mc-misc2002 kernel: [   12.910056] usb u=
sb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> 2025-05-21T10:59:23.315110+00:00 mc-misc2002 kernel: [   12.918168] usb u=
sb2: Product: xHCI Host Controller
> 2025-05-21T10:59:23.315110+00:00 mc-misc2002 kernel: [   12.923646] usb u=
sb2: Manufacturer: Linux 6.1.0-34-amd64 xhci-hcd
> 2025-05-21T10:59:23.315110+00:00 mc-misc2002 kernel: [   12.930489] usb u=
sb2: SerialNumber: 0000:00:14.0
> 2025-05-21T10:59:23.315111+00:00 mc-misc2002 kernel: [   12.945399] nvme =
nvme0: pci function 0000:65:00.0
> 2025-05-21T10:59:23.315111+00:00 mc-misc2002 kernel: [   12.950709] hub 2=
-0:1.0: USB hub found
> 2025-05-21T10:59:23.315115+00:00 mc-misc2002 kernel: [   12.952696] bnxt_=
en 0000:98:00.1 enp152s0f1np1: renamed from eth1
> 2025-05-21T10:59:23.315116+00:00 mc-misc2002 kernel: [   12.954952] hub 2=
-0:1.0: 10 ports detected
> 2025-05-21T10:59:23.315116+00:00 mc-misc2002 kernel: [   12.956911] nvme =
nvme0: 48/0/0 default/read/poll queues
> 2025-05-21T10:59:23.315117+00:00 mc-misc2002 kernel: [   12.973266] ahci =
0000:00:11.5: version 3.0
> 2025-05-21T10:59:23.315117+00:00 mc-misc2002 kernel: [   12.973452] ahci =
0000:00:11.5: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
> 2025-05-21T10:59:23.315117+00:00 mc-misc2002 kernel: [   12.982638] ahci =
0000:00:11.5: flags: 64bit ncq sntf led clo only pio slum part ems deso sad=
m sds apst=20
> 2025-05-21T10:59:23.315121+00:00 mc-misc2002 kernel: [   13.021087] igb 0=
000:4b:00.1: added PHC on eth1
> 2025-05-21T10:59:23.315122+00:00 mc-misc2002 kernel: [   13.026189] igb 0=
000:4b:00.1: Intel(R) Gigabit Ethernet Network Connection
> 2025-05-21T10:59:23.315122+00:00 mc-misc2002 kernel: [   13.033909] igb 0=
000:4b:00.1: eth1: (PCIe:5.0Gb/s:Width x4) 90:5a:08:10:40:a9
> 2025-05-21T10:59:23.315123+00:00 mc-misc2002 kernel: [   13.041992] igb 0=
000:4b:00.1: eth1: PBA No: 010300-000
> 2025-05-21T10:59:23.315123+00:00 mc-misc2002 kernel: [   13.047761] igb 0=
000:4b:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> 2025-05-21T10:59:23.315124+00:00 mc-misc2002 kernel: [   13.060746] bnxt_=
en 0000:98:00.0 enp152s0f0np0: renamed from eth0
> 2025-05-21T10:59:23.315127+00:00 mc-misc2002 kernel: [   13.077096] scsi =
host0: ahci
> 2025-05-21T10:59:23.315128+00:00 mc-misc2002 kernel: [   13.080464] scsi =
host1: ahci
> 2025-05-21T10:59:23.315128+00:00 mc-misc2002 kernel: [   13.083901] scsi =
host2: ahci
> 2025-05-21T10:59:23.315129+00:00 mc-misc2002 kernel: [   13.087281] scsi =
host3: ahci
> 2025-05-21T10:59:23.315129+00:00 mc-misc2002 kernel: [   13.090601] scsi =
host4: ahci
> 2025-05-21T10:59:23.315130+00:00 mc-misc2002 kernel: [   13.094026] scsi =
host5: ahci
> 2025-05-21T10:59:23.315130+00:00 mc-misc2002 kernel: [   13.097289] ata1:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180100 irq 237
> 2025-05-21T10:59:23.315134+00:00 mc-misc2002 kernel: [   13.105894] ata2:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180180 irq 237
> 2025-05-21T10:59:23.315135+00:00 mc-misc2002 kernel: [   13.114484] ata3:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180200 irq 237
> 2025-05-21T10:59:23.315135+00:00 mc-misc2002 kernel: [   13.123087] ata4:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180280 irq 237
> 2025-05-21T10:59:23.315135+00:00 mc-misc2002 kernel: [   13.131682] ata5:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180300 irq 237
> 2025-05-21T10:59:23.315136+00:00 mc-misc2002 kernel: [   13.140271] ata6:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180380 irq 237
> 2025-05-21T10:59:23.315136+00:00 mc-misc2002 kernel: [   13.149149] ahci =
0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
> 2025-05-21T10:59:23.315140+00:00 mc-misc2002 kernel: [   13.158334] ahci =
0000:00:17.0: flags: 64bit ncq sntf led clo only pio slum part ems deso sad=
m sds apst=20
> 2025-05-21T10:59:23.315141+00:00 mc-misc2002 kernel: [   13.180719] igb 0=
000:4b:00.1 enp75s0f1: renamed from eth1
> 2025-05-21T10:59:23.315141+00:00 mc-misc2002 kernel: [   13.208692] usb 1=
-1: new high-speed USB device number 2 using xhci_hcd
> 2025-05-21T10:59:23.315142+00:00 mc-misc2002 kernel: [   13.248705] igb 0=
000:4b:00.0 enp75s0f0: renamed from eth2
> 2025-05-21T10:59:23.315142+00:00 mc-misc2002 kernel: [   13.265483] scsi =
host6: ahci
> 2025-05-21T10:59:23.315143+00:00 mc-misc2002 kernel: [   13.268985] scsi =
host7: ahci
> 2025-05-21T10:59:23.315147+00:00 mc-misc2002 kernel: [   13.272479] scsi =
host8: ahci
> 2025-05-21T10:59:23.315148+00:00 mc-misc2002 kernel: [   13.275975] scsi =
host9: ahci
> 2025-05-21T10:59:23.315148+00:00 mc-misc2002 kernel: [   13.279635] scsi =
host10: ahci
> 2025-05-21T10:59:23.315149+00:00 mc-misc2002 kernel: [   13.283203] scsi =
host11: ahci
> 2025-05-21T10:59:23.315149+00:00 mc-misc2002 kernel: [   13.286777] scsi =
host12: ahci
> 2025-05-21T10:59:23.315150+00:00 mc-misc2002 kernel: [   13.290367] scsi =
host13: ahci
> 2025-05-21T10:59:23.315150+00:00 mc-misc2002 kernel: [   13.293784] ata7:=
 SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100100 irq 238
> 2025-05-21T10:59:23.315154+00:00 mc-misc2002 kernel: [   13.302387] ata8:=
 SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100180 irq 238
> 2025-05-21T10:59:23.315154+00:00 mc-misc2002 kernel: [   13.310989] ata9:=
 SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100200 irq 238
> 2025-05-21T10:59:23.315155+00:00 mc-misc2002 kernel: [   13.319590] ata10=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100280 irq 238
> 2025-05-21T10:59:23.315155+00:00 mc-misc2002 kernel: [   13.328289] ata11=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100300 irq 238
> 2025-05-21T10:59:23.315156+00:00 mc-misc2002 kernel: [   13.336988] ata12=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100380 irq 238
> 2025-05-21T10:59:23.315156+00:00 mc-misc2002 kernel: [   13.345685] ata13=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100400 irq 238
> 2025-05-21T10:59:23.315160+00:00 mc-misc2002 kernel: [   13.354382] ata14=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100480 irq 238
> 2025-05-21T10:59:23.315160+00:00 mc-misc2002 kernel: [   13.381469] usb 1=
-1: New USB device found, idVendor=3D1d6b, idProduct=3D0107, bcdDevice=3D 1=
=2E00
> 2025-05-21T10:59:23.315161+00:00 mc-misc2002 kernel: [   13.390655] usb 1=
-1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> 2025-05-21T10:59:23.315161+00:00 mc-misc2002 kernel: [   13.398665] usb 1=
-1: Product: USB Virtual Hub
> 2025-05-21T10:59:23.315162+00:00 mc-misc2002 kernel: [   13.403553] usb 1=
-1: Manufacturer: Aspeed
> 2025-05-21T10:59:23.315162+00:00 mc-misc2002 kernel: [   13.408051] usb 1=
-1: SerialNumber: 00000000
> 2025-05-21T10:59:23.315163+00:00 mc-misc2002 kernel: [   13.413504] hub 1=
-1:1.0: USB hub found
> 2025-05-21T10:59:23.315168+00:00 mc-misc2002 kernel: [   13.417915] hub 1=
-1:1.0: 7 ports detected
> 2025-05-21T10:59:23.315168+00:00 mc-misc2002 kernel: [   13.462954] ata5:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:59:23.315169+00:00 mc-misc2002 kernel: [   13.469052] ata4:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:59:23.315169+00:00 mc-misc2002 kernel: [   13.475147] ata6:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:59:23.315169+00:00 mc-misc2002 kernel: [   13.481243] ata2:=
 SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 2025-05-21T10:59:23.315170+00:00 mc-misc2002 kernel: [   13.488219] ata1:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:59:23.315177+00:00 mc-misc2002 kernel: [   13.494315] ata3:=
 SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 2025-05-21T10:59:23.315178+00:00 mc-misc2002 kernel: [   13.501335] ata2.=
00: ATA-11: Micron_5400_MTFDDAK1T9TGA,  D4MU002, max UDMA/133
> 2025-05-21T10:59:23.315178+00:00 mc-misc2002 kernel: [   13.509492] ata3.=
00: ATA-11: Micron_5400_MTFDDAK1T9TGA,  D4MU002, max UDMA/133
> 2025-05-21T10:59:23.315179+00:00 mc-misc2002 kernel: [   13.521119] ata2.=
00: 3750748848 sectors, multi 16: LBA48 NCQ (depth 32), AA
> 2025-05-21T10:59:23.315179+00:00 mc-misc2002 kernel: [   13.528967] ata3.=
00: 3750748848 sectors, multi 16: LBA48 NCQ (depth 32), AA
> 2025-05-21T10:59:23.315179+00:00 mc-misc2002 kernel: [   13.536806] ata2.=
00: Features: NCQ-prio
> 2025-05-21T10:59:23.315184+00:00 mc-misc2002 kernel: [   13.541151] ata3.=
00: Features: NCQ-prio
> 2025-05-21T10:59:23.315184+00:00 mc-misc2002 kernel: [   13.551252] ata2.=
00: configured for UDMA/133
> 2025-05-21T10:59:23.315185+00:00 mc-misc2002 kernel: [   13.556087] ata3.=
00: configured for UDMA/133
> 2025-05-21T10:59:23.315185+00:00 mc-misc2002 kernel: [   13.556531] scsi =
1:0:0:0: Direct-Access     ATA      Micron_5400_MTFD U002 PQ: 0 ANSI: 5
> 2025-05-21T10:59:23.315186+00:00 mc-misc2002 kernel: [   13.571104] scsi =
2:0:0:0: Direct-Access     ATA      Micron_5400_MTFD U002 PQ: 0 ANSI: 5
> 2025-05-21T10:59:23.315186+00:00 mc-misc2002 kernel: [   13.674952] ata10=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:59:23.315186+00:00 mc-misc2002 kernel: [   13.681154] ata8:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:59:23.315190+00:00 mc-misc2002 kernel: [   13.687249] ata9:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:59:23.315191+00:00 mc-misc2002 kernel: [   13.693342] ata12=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:59:23.315191+00:00 mc-misc2002 kernel: [   13.699529] ata11=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:59:23.315192+00:00 mc-misc2002 kernel: [   13.705722] ata7:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:59:23.315192+00:00 mc-misc2002 kernel: [   13.711811] ata14=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:59:23.315193+00:00 mc-misc2002 kernel: [   13.712694] usb 1=
-1.1: new high-speed USB device number 3 using xhci_hcd
> 2025-05-21T10:59:23.315196+00:00 mc-misc2002 kernel: [   13.718031] ata13=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:59:23.315197+00:00 mc-misc2002 kernel: [   13.739830] ata2.=
00: Enabling discard_zeroes_data
> 2025-05-21T10:59:23.315197+00:00 mc-misc2002 kernel: [   13.745136] ata3.=
00: Enabling discard_zeroes_data
> 2025-05-21T10:59:23.315198+00:00 mc-misc2002 kernel: [   13.745139] sd 1:=
0:0:0: [sda] 3750748848 512-byte logical blocks: (1.92 TB/1.75 TiB)
> 2025-05-21T10:59:23.315198+00:00 mc-misc2002 kernel: [   13.750436] sd 2:=
0:0:0: [sdb] 3750748848 512-byte logical blocks: (1.92 TB/1.75 TiB)
> 2025-05-21T10:59:23.315199+00:00 mc-misc2002 kernel: [   13.759124] sd 1:=
0:0:0: [sda] 4096-byte physical blocks
> 2025-05-21T10:59:23.315199+00:00 mc-misc2002 kernel: [   13.767840] sd 2:=
0:0:0: [sdb] 4096-byte physical blocks
> 2025-05-21T10:59:23.315203+00:00 mc-misc2002 kernel: [   13.773701] sd 1:=
0:0:0: [sda] Write Protect is off
> 2025-05-21T10:59:23.315204+00:00 mc-misc2002 kernel: [   13.779565] sd 2:=
0:0:0: [sdb] Write Protect is off
> 2025-05-21T10:59:23.315204+00:00 mc-misc2002 kernel: [   13.784945] sd 1:=
0:0:0: [sda] Mode Sense: 00 3a 00 00
> 2025-05-21T10:59:23.315204+00:00 mc-misc2002 kernel: [   13.790332] sd 2:=
0:0:0: [sdb] Mode Sense: 00 3a 00 00
> 2025-05-21T10:59:23.315205+00:00 mc-misc2002 kernel: [   13.790343] sd 2:=
0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO=
 or FUA
> 2025-05-21T10:59:23.315205+00:00 mc-misc2002 kernel: [   13.790346] sd 1:=
0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO=
 or FUA
> 2025-05-21T10:59:23.315209+00:00 mc-misc2002 kernel: [   13.800516] sd 2:=
0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
> 2025-05-21T10:59:23.315210+00:00 mc-misc2002 kernel: [   13.810674] sd 1:=
0:0:0: [sda] Preferred minimum I/O size 4096 bytes
> 2025-05-21T10:59:23.315210+00:00 mc-misc2002 kernel: [   13.818115] ata3.=
00: Enabling discard_zeroes_data
> 2025-05-21T10:59:23.315211+00:00 mc-misc2002 kernel: [   13.830021] ata2.=
00: Enabling discard_zeroes_data
> 2025-05-21T10:59:23.315211+00:00 mc-misc2002 kernel: [   13.837213]  sdb:=
 sdb1 sdb2
> 2025-05-21T10:59:23.315211+00:00 mc-misc2002 kernel: [   13.837692]  sda:=
 sda1 sda2
> 2025-05-21T10:59:23.315215+00:00 mc-misc2002 kernel: [   13.838440] usb 1=
-1.1: New USB device found, idVendor=3D0557, idProduct=3D9241, bcdDevice=3D=
 5.04
> 2025-05-21T10:59:23.315216+00:00 mc-misc2002 kernel: [   13.838450] usb 1=
-1.1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
> 2025-05-21T10:59:23.315216+00:00 mc-misc2002 kernel: [   13.838455] usb 1=
-1.1: Product: SMCI HID KM
> 2025-05-21T10:59:23.315217+00:00 mc-misc2002 kernel: [   13.838458] usb 1=
-1.1: Manufacturer: Linux 5.4.62 with aspeed_vhub
> 2025-05-21T10:59:23.315217+00:00 mc-misc2002 kernel: [   13.840464] sd 2:=
0:0:0: [sdb] Attached SCSI disk
> 2025-05-21T10:59:23.315218+00:00 mc-misc2002 kernel: [   13.843625] sd 1:=
0:0:0: [sda] Attached SCSI disk
> 2025-05-21T10:59:23.315220+00:00 mc-misc2002 kernel: [   13.884251] hid: =
raw HID events driver (C) Jiri Kosina
> 2025-05-21T10:59:23.315222+00:00 mc-misc2002 kernel: [   13.895805] usbco=
re: registered new interface driver usbhid
> 2025-05-21T10:59:23.315223+00:00 mc-misc2002 kernel: [   13.902113] usbhi=
d: USB HID core driver
> 2025-05-21T10:59:23.315223+00:00 mc-misc2002 kernel: [   13.909264] input=
: Linux 5.4.62 with aspeed_vhub SMCI HID KM as /devices/pci0000:00/0000:00:=
14.0/usb1/1-1/1-1.1/1-1.1:1.0/0003:0557:9241.0001/input/input0
> 2025-05-21T10:59:23.315224+00:00 mc-misc2002 kernel: [   13.916696] usb 1=
-1.2: new high-speed USB device number 4 using xhci_hcd
> 2025-05-21T10:59:23.315224+00:00 mc-misc2002 kernel: [   13.943477] md/ra=
id1:md0: active with 2 out of 2 mirrors
> 2025-05-21T10:59:23.315225+00:00 mc-misc2002 kernel: [   13.949932] md0: =
detected capacity change from 0 to 3749898240
> 2025-05-21T10:59:23.315229+00:00 mc-misc2002 kernel: [   14.030397] usb 1=
-1.2: New USB device found, idVendor=3D0b1f, idProduct=3D03ee, bcdDevice=3D=
 5.04
> 2025-05-21T10:59:23.315229+00:00 mc-misc2002 kernel: [   14.039785] usb 1=
-1.2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
> 2025-05-21T10:59:23.315230+00:00 mc-misc2002 kernel: [   14.047998] usb 1=
-1.2: Product: RNDIS/Ethernet Gadget
> 2025-05-21T10:59:23.315230+00:00 mc-misc2002 kernel: [   14.053675] usb 1=
-1.2: Manufacturer: Linux 5.4.62 with aspeed_vhub
> 2025-05-21T10:59:23.315231+00:00 mc-misc2002 kernel: [   14.063405] devic=
e-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measur=
ements will not be recorded in the IMA log.
> 2025-05-21T10:59:23.315231+00:00 mc-misc2002 kernel: [   14.077132] devic=
e-mapper: uevent: version 1.0.3
> 2025-05-21T10:59:23.315235+00:00 mc-misc2002 kernel: [   14.082399] devic=
e-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
> 2025-05-21T10:59:23.315235+00:00 mc-misc2002 kernel: [   14.101799] usbco=
re: registered new interface driver cdc_ether
> 2025-05-21T10:59:23.315236+00:00 mc-misc2002 kernel: [   14.112873] rndis=
_host 1-1.2:2.0 usb0: register 'rndis_host' at usb-0000:00:14.0-1.2, RNDIS =
device, be:3a:f2:b6:05:9f
> 2025-05-21T10:59:23.315236+00:00 mc-misc2002 kernel: [   14.124823] usbco=
re: registered new interface driver rndis_host
> 2025-05-21T10:59:23.315237+00:00 mc-misc2002 kernel: [   14.134072] rndis=
_host 1-1.2:2.0 enxbe3af2b6059f: renamed from usb0
> 2025-05-21T10:59:23.315237+00:00 mc-misc2002 kernel: [   14.136858] hid-g=
eneric 0003:0557:9241.0001: input,hidraw0: USB HID v1.00 Keyboard [Linux 5.=
4.62 with aspeed_vhub SMCI HID KM] on usb-0000:00:14.0-1.1/input0
> 2025-05-21T10:59:23.315241+00:00 mc-misc2002 kernel: [   14.157173] input=
: Linux 5.4.62 with aspeed_vhub SMCI HID KM as /devices/pci0000:00/0000:00:=
14.0/usb1/1-1/1-1.1/1-1.1:1.1/0003:0557:9241.0002/input/input1
> 2025-05-21T10:59:23.315242+00:00 mc-misc2002 kernel: [   14.172958] hid-g=
eneric 0003:0557:9241.0002: input,hidraw1: USB HID v1.00 Mouse [Linux 5.4.6=
2 with aspeed_vhub SMCI HID KM] on usb-0000:00:14.0-1.1/input1
> 2025-05-21T10:59:23.315243+00:00 mc-misc2002 kernel: [   14.300676] raid6=
: avx512x4 gen() 32874 MB/s
> 2025-05-21T10:59:23.315243+00:00 mc-misc2002 kernel: [   14.372675] raid6=
: avx512x2 gen() 36817 MB/s
> 2025-05-21T10:59:23.315243+00:00 mc-misc2002 kernel: [   14.444675] raid6=
: avx512x1 gen() 33860 MB/s
> 2025-05-21T10:59:23.315244+00:00 mc-misc2002 kernel: [   14.516676] raid6=
: avx2x4   gen() 26748 MB/s
> 2025-05-21T10:59:23.315248+00:00 mc-misc2002 kernel: [   14.588676] raid6=
: avx2x2   gen() 26924 MB/s
> 2025-05-21T10:59:23.315248+00:00 mc-misc2002 kernel: [   14.660675] raid6=
: avx2x1   gen() 22844 MB/s
> 2025-05-21T10:59:23.315249+00:00 mc-misc2002 kernel: [   14.665470] raid6=
: using algorithm avx512x2 gen() 36817 MB/s
> 2025-05-21T10:59:23.315249+00:00 mc-misc2002 kernel: [   14.736676] raid6=
: .... xor() 20151 MB/s, rmw enabled
> 2025-05-21T10:59:23.315249+00:00 mc-misc2002 kernel: [   14.742349] raid6=
: using avx512x2 recovery algorithm
> 2025-05-21T10:59:23.315250+00:00 mc-misc2002 kernel: [   14.749195] xor: =
automatically using best checksumming function   avx      =20
> 2025-05-21T10:59:23.315254+00:00 mc-misc2002 kernel: [   14.758134] async=
_tx: api initialized (async)
> 2025-05-21T10:59:23.315254+00:00 mc-misc2002 kernel: [   19.911373] PM: I=
mage not found (code -22)
> 2025-05-21T10:59:23.315255+00:00 mc-misc2002 kernel: [   20.039407] EXT4-=
fs (dm-1): mounted filesystem with ordered data mode. Quota mode: none.
> 2025-05-21T10:59:23.315255+00:00 mc-misc2002 kernel: [   20.110128] Not a=
ctivating Mandatory Access Control as /sbin/tomoyo-init does not exist.
> 2025-05-21T10:59:23.315301+00:00 mc-misc2002 kernel: [   21.634991] ACPI:=
 bus type drm_connector registered
> 2025-05-21T10:59:23.315302+00:00 mc-misc2002 kernel: [   21.673449] fuse:=
 init (API version 7.38)
> 2025-05-21T10:59:23.315307+00:00 mc-misc2002 kernel: [   21.698253] loop:=
 module loaded
> 2025-05-21T10:59:23.315307+00:00 mc-misc2002 kernel: [   21.816108] EXT4-=
fs (dm-1): re-mounted. Quota mode: none.
> 2025-05-21T10:59:23.315308+00:00 mc-misc2002 kernel: [   21.825028] IPMI =
message handler: version 39.2
> 2025-05-21T10:59:23.315308+00:00 mc-misc2002 kernel: [   21.832329] ipmi =
device interface
> 2025-05-21T10:59:23.315309+00:00 mc-misc2002 kernel: [   22.722953] input=
: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> 2025-05-21T10:59:23.315309+00:00 mc-misc2002 kernel: [   22.723068] ACPI:=
 button: Power Button [PWRF]
> 2025-05-21T10:59:23.315310+00:00 mc-misc2002 kernel: [   22.723815] sd 1:=
0:0:0: Attached scsi generic sg0 type 0
> 2025-05-21T10:59:23.315315+00:00 mc-misc2002 kernel: [   22.723869] sd 2:=
0:0:0: Attached scsi generic sg1 type 0
> 2025-05-21T10:59:23.315315+00:00 mc-misc2002 kernel: [   22.763374] ipmi_=
si: IPMI System Interface driver
> 2025-05-21T10:59:23.315316+00:00 mc-misc2002 kernel: [   22.763409] ipmi_=
si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> 2025-05-21T10:59:23.315316+00:00 mc-misc2002 kernel: [   22.763412] ipmi_=
platform: ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
> 2025-05-21T10:59:23.315316+00:00 mc-misc2002 kernel: [   22.763416] ipmi_=
si: Adding SMBIOS-specified kcs state machine
> 2025-05-21T10:59:23.315317+00:00 mc-misc2002 kernel: [   22.764503] ipmi_=
si IPI0001:00: ipmi_platform: probing via ACPI
> 2025-05-21T10:59:23.315322+00:00 mc-misc2002 kernel: [   22.764663] ipmi_=
si IPI0001:00: ipmi_platform: [io  0x0ca2] regsize 1 spacing 1 irq 0
> 2025-05-21T10:59:23.315322+00:00 mc-misc2002 kernel: [   22.783519] ipmi_=
si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of A=
CPI
> 2025-05-21T10:59:23.315323+00:00 mc-misc2002 kernel: [   22.783525] ipmi_=
si: Adding ACPI-specified kcs state machine
> 2025-05-21T10:59:23.315323+00:00 mc-misc2002 kernel: [   22.783675] ipmi_=
si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave add=
ress 0x20, irq 0
> 2025-05-21T10:59:23.315324+00:00 mc-misc2002 kernel: [   22.797043] ioatd=
ma: Intel(R) QuickData Technology Driver 5.00
> 2025-05-21T10:59:23.315324+00:00 mc-misc2002 kernel: [   22.804798] iTCO_=
vendor_support: vendor-support=3D0
> 2025-05-21T10:59:23.315335+00:00 mc-misc2002 kernel: [   22.807168] mei_m=
e 0000:00:16.0: Device doesn't have valid ME Interface
> 2025-05-21T10:59:23.315335+00:00 mc-misc2002 kernel: [   22.829664] iTCO_=
wdt iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/B=
IOS
> 2025-05-21T10:59:23.315336+00:00 mc-misc2002 kernel: [   22.877926] input=
: PC Speaker as /devices/platform/pcspkr/input/input3
> 2025-05-21T10:59:23.315336+00:00 mc-misc2002 kernel: [   22.885873] RAPL =
PMU: API unit is 2^-32 Joules, 2 fixed counters, 655360 ms ovfl timer
> 2025-05-21T10:59:23.315337+00:00 mc-misc2002 kernel: [   22.885877] RAPL =
PMU: hw unit of domain package 2^-14 Joules
> 2025-05-21T10:59:23.315337+00:00 mc-misc2002 kernel: [   22.885878] RAPL =
PMU: hw unit of domain dram 2^-16 Joules
> 2025-05-21T10:59:23.315337+00:00 mc-misc2002 kernel: [   22.909995] Addin=
g 999420k swap on /dev/mapper/vg0-swap.  Priority:-2 extents:1 across:99942=
0k SSFS
> 2025-05-21T10:59:23.315342+00:00 mc-misc2002 kernel: [   22.938336] crypt=
d: max_cpu_qlen set to 1000
> 2025-05-21T10:59:23.315342+00:00 mc-misc2002 kernel: [   22.954517] AVX2 =
version of gcm_enc/dec engaged.
> 2025-05-21T10:59:23.315343+00:00 mc-misc2002 kernel: [   22.954605] AES C=
TR mode by8 optimization enabled
> 2025-05-21T10:59:23.315343+00:00 mc-misc2002 kernel: [   22.968264] ast 0=
000:04:00.0: [drm] P2A bridge disabled, using default configuration
> 2025-05-21T10:59:23.315343+00:00 mc-misc2002 kernel: [   22.968268] ast 0=
000:04:00.0: [drm] AST 2600 detected
> 2025-05-21T10:59:23.315344+00:00 mc-misc2002 kernel: [   23.051315] EXT4-=
fs (dm-2): mounted filesystem with ordered data mode. Quota mode: none.
> 2025-05-21T10:59:23.315348+00:00 mc-misc2002 kernel: [   23.076692] ast 0=
000:04:00.0: [drm] Using analog VGA
> 2025-05-21T10:59:23.315349+00:00 mc-misc2002 kernel: [   23.076695] ast 0=
000:04:00.0: [drm] dram MCLK=3D396 Mhz type=3D1 bus_width=3D16
> 2025-05-21T10:59:23.315349+00:00 mc-misc2002 kernel: [   23.077101] [drm]=
 Initialized ast 0.1.0 20120228 for 0000:04:00.0 on minor 0
> 2025-05-21T10:59:23.315350+00:00 mc-misc2002 kernel: [   23.080057] fbcon=
: astdrmfb (fb0) is primary device
> 2025-05-21T10:59:23.315350+00:00 mc-misc2002 kernel: [   23.091229] Conso=
le: switching to colour frame buffer device 128x48
> 2025-05-21T10:59:23.315351+00:00 mc-misc2002 kernel: [   23.091873] ast 0=
000:04:00.0: [drm] fb0: astdrmfb frame buffer device
> 2025-05-21T10:59:23.315354+00:00 mc-misc2002 kernel: [   23.100280] EDAC =
i10nm: No hbm memory
> 2025-05-21T10:59:23.315355+00:00 mc-misc2002 kernel: [   23.100328] EDAC =
MC0: Giving out device to module i10nm_edac controller Intel_10nm Socket#0 =
IMC#0: DEV 0000:7e:0c.0 (INTERRUPT)
> 2025-05-21T10:59:23.315356+00:00 mc-misc2002 kernel: [   23.100359] EDAC =
MC1: Giving out device to module i10nm_edac controller Intel_10nm Socket#0 =
IMC#1: DEV 0000:7e:0d.0 (INTERRUPT)
> 2025-05-21T10:59:23.315356+00:00 mc-misc2002 kernel: [   23.100396] EDAC =
MC2: Giving out device to module i10nm_edac controller Intel_10nm Socket#0 =
IMC#2: DEV 0000:7e:0e.0 (INTERRUPT)
> 2025-05-21T10:59:23.315356+00:00 mc-misc2002 kernel: [   23.100432] EDAC =
MC3: Giving out device to module i10nm_edac controller Intel_10nm Socket#0 =
IMC#3: DEV 0000:7e:0f.0 (INTERRUPT)
> 2025-05-21T10:59:23.315357+00:00 mc-misc2002 kernel: [   23.100468] EDAC =
MC4: Giving out device to module i10nm_edac controller Intel_10nm Socket#1 =
IMC#0: DEV 0000:fe:0c.0 (INTERRUPT)
> 2025-05-21T10:59:23.315361+00:00 mc-misc2002 kernel: [   23.100496] EDAC =
MC5: Giving out device to module i10nm_edac controller Intel_10nm Socket#1 =
IMC#1: DEV 0000:fe:0d.0 (INTERRUPT)
> 2025-05-21T10:59:23.315361+00:00 mc-misc2002 kernel: [   23.100531] EDAC =
MC6: Giving out device to module i10nm_edac controller Intel_10nm Socket#1 =
IMC#2: DEV 0000:fe:0e.0 (INTERRUPT)
> 2025-05-21T10:59:23.315362+00:00 mc-misc2002 kernel: [   23.100566] EDAC =
MC7: Giving out device to module i10nm_edac controller Intel_10nm Socket#1 =
IMC#3: DEV 0000:fe:0f.0 (INTERRUPT)
> 2025-05-21T10:59:23.315362+00:00 mc-misc2002 kernel: [   23.100569] EDAC =
i10nm: v0.0.5
> 2025-05-21T10:59:23.315363+00:00 mc-misc2002 kernel: [   23.107258] intel=
_rapl_common: Found RAPL domain package
> 2025-05-21T10:59:23.315367+00:00 mc-misc2002 kernel: [   23.107265] intel=
_rapl_common: Found RAPL domain dram
> 2025-05-21T10:59:23.315367+00:00 mc-misc2002 kernel: [   23.107268] intel=
_rapl_common: DRAM domain energy unit 15300pj
> 2025-05-21T10:59:23.315368+00:00 mc-misc2002 kernel: [   23.107492] intel=
_rapl_common: Found RAPL domain package
> 2025-05-21T10:59:23.315368+00:00 mc-misc2002 kernel: [   23.107506] intel=
_rapl_common: Found RAPL domain dram
> 2025-05-21T10:59:23.315369+00:00 mc-misc2002 kernel: [   23.107510] intel=
_rapl_common: DRAM domain energy unit 15300pj
> 2025-05-21T10:59:23.315369+00:00 mc-misc2002 kernel: [   23.140703] ipmi_=
si IPI0001:00: The BMC does not support clearing the recv irq bit, compensa=
ting, but the BMC needs to be fixed.
> 2025-05-21T10:59:23.315370+00:00 mc-misc2002 kernel: [   23.195662] bnxt_=
en 0000:98:00.0 enp152s0f0np0: NIC Link is Up, 10000 Mbps (NRZ) full duplex=
, Flow control: none
> 2025-05-21T10:59:23.315374+00:00 mc-misc2002 kernel: [   23.195667] bnxt_=
en 0000:98:00.0 enp152s0f0np0: FEC autoneg off encoding: None
> 2025-05-21T10:59:23.315374+00:00 mc-misc2002 kernel: [   23.222192] ipmi_=
si IPI0001:00: IPMI message handler: Found new BMC (man_id: 0x002a7c, prod_=
id: 0x1b58, dev_id: 0x20)
> 2025-05-21T10:59:23.315375+00:00 mc-misc2002 kernel: [   23.272103] ipmi_=
si IPI0001:00: IPMI kcs interface initialized
> 2025-05-21T10:59:23.315375+00:00 mc-misc2002 kernel: [   23.274774] ipmi_=
ssif: IPMI SSIF Interface driver
> 2025-05-21T10:59:23.315375+00:00 mc-misc2002 kernel: [   24.361541] Proce=
ss accounting resumed

> Linux 6.1.135 and running the May Intel microcode:
>=20
> 2025-05-21T10:35:36.854845+00:00 mc-misc2002 kernel: [    0.000000] micro=
code: microcode updated early to revision 0xd000404, date =3D 2025-01-07
> 2025-05-21T10:35:36.854855+00:00 mc-misc2002 kernel: [    0.000000] Linux=
 version 6.1.0-34-amd64 (debian-kernel@lists.debian.org) (gcc-12 (Debian 12=
=2E2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PR=
EEMPT_DYNAMIC Debian 6.1.135-1 (2025-04-25)
> 2025-05-21T10:35:36.854856+00:00 mc-misc2002 kernel: [    0.000000] Comma=
nd line: BOOT_IMAGE=3D/boot/vmlinuz-6.1.0-34-amd64 root=3D/dev/mapper/vg0-r=
oot ro console=3DttyS1,115200n8 raid0.default_layout=3D2 elevator=3Ddeadline
> 2025-05-21T10:35:36.854856+00:00 mc-misc2002 kernel: [    0.000000] x86/t=
me: not enabled by BIOS
> 2025-05-21T10:35:36.854856+00:00 mc-misc2002 kernel: [    0.000000] x86/s=
plit lock detection: #AC: crashing the kernel on kernel split_locks and war=
ning on user-space split_locks
> 2025-05-21T10:35:36.854857+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
provided physical RAM map:
> 2025-05-21T10:35:36.854857+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000000000000-0x00000000000987ff] usable
> 2025-05-21T10:35:36.854866+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000000098800-0x000000000009ffff] reserved
> 2025-05-21T10:35:36.854867+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> 2025-05-21T10:35:36.854868+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000000100000-0x00000000645fefff] usable
> 2025-05-21T10:35:36.854868+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000645ff000-0x0000000066ffefff] reserved
> 2025-05-21T10:35:36.854868+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000066fff000-0x00000000678fefff] ACPI data
> 2025-05-21T10:35:36.854868+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000678ff000-0x0000000067dfefff] ACPI NVS
> 2025-05-21T10:35:36.854872+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000067dff000-0x000000006c1fefff] reserved
> 2025-05-21T10:35:36.854883+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x000000006c1ff000-0x000000006f7fffff] usable
> 2025-05-21T10:35:36.854883+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x000000006f800000-0x000000008fffffff] reserved
> 2025-05-21T10:35:36.854891+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
> 2025-05-21T10:35:36.854891+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000fed20000-0x00000000fed44fff] reserved
> 2025-05-21T10:35:36.854892+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> 2025-05-21T10:35:36.854892+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000100000000-0x000000407fffffff] usable
> 2025-05-21T10:35:36.854894+00:00 mc-misc2002 kernel: [    0.000000] NX (E=
xecute Disable) protection: active
> 2025-05-21T10:35:36.854894+00:00 mc-misc2002 kernel: [    0.000000] SMBIO=
S 3.3.0 present.
> 2025-05-21T10:35:36.854895+00:00 mc-misc2002 kernel: [    0.000000] DMI: =
Supermicro SYS-120C-TN10R/X12DDW-A6, BIOS 1.9 01/11/2024
> 2025-05-21T10:35:36.854895+00:00 mc-misc2002 kernel: [    0.000000] tsc: =
Detected 2100.000 MHz processor
> 2025-05-21T10:35:36.854895+00:00 mc-misc2002 kernel: [    0.035973] e820:=
 update [mem 0x00000000-0x00000fff] usable =3D=3D> reserved
> 2025-05-21T10:35:36.854895+00:00 mc-misc2002 kernel: [    0.036071] e820:=
 remove [mem 0x000a0000-0x000fffff] usable
> 2025-05-21T10:35:36.854898+00:00 mc-misc2002 kernel: [    0.036356] last_=
pfn =3D 0x4080000 max_arch_pfn =3D 0x10000000000
> 2025-05-21T10:35:36.854899+00:00 mc-misc2002 kernel: [    0.040454] x86/P=
AT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT =20
> 2025-05-21T10:35:36.854899+00:00 mc-misc2002 kernel: [    0.064591] e820:=
 update [mem 0x7f000000-0xffffffff] usable =3D=3D> reserved
> 2025-05-21T10:35:36.854899+00:00 mc-misc2002 kernel: [    0.064736] last_=
pfn =3D 0x6f800 max_arch_pfn =3D 0x10000000000
> 2025-05-21T10:35:36.854900+00:00 mc-misc2002 kernel: [    0.219035] Using=
 GB pages for direct mapping
> 2025-05-21T10:35:36.854900+00:00 mc-misc2002 kernel: [    0.219328] RAMDI=
SK: [mem 0x32695000-0x35341fff]
> 2025-05-21T10:35:36.854902+00:00 mc-misc2002 kernel: [    0.219335] ACPI:=
 Early table checksum verification disabled
> 2025-05-21T10:35:36.854902+00:00 mc-misc2002 kernel: [    0.219341] ACPI:=
 RSDP 0x00000000000F05B0 000024 (v02 SUPERM)
> 2025-05-21T10:35:36.854902+00:00 mc-misc2002 kernel: [    0.219346] ACPI:=
 XSDT 0x0000000067AC4728 0000FC (v01 SUPERM SMCI--MB 01072009 AMI  01000013)
> 2025-05-21T10:35:36.854902+00:00 mc-misc2002 kernel: [    0.219354] ACPI:=
 FACP 0x00000000678FC000 000114 (v06 SUPERM SMCI--MB 01072009 INTL 20091013)
> 2025-05-21T10:35:36.854903+00:00 mc-misc2002 kernel: [    0.219361] ACPI:=
 DSDT 0x0000000067893000 067849 (v02 SUPERM SMCI--MB 01072009 INTL 20091013)
> 2025-05-21T10:35:36.854903+00:00 mc-misc2002 kernel: [    0.219366] ACPI:=
 FACS 0x0000000067DFD000 000040
> 2025-05-21T10:35:36.854903+00:00 mc-misc2002 kernel: [    0.219369] ACPI:=
 SPMI 0x00000000678FB000 000041 (v05 SUPERM SMCI--MB 00000000 AMI. 00000000)
> 2025-05-21T10:35:36.854906+00:00 mc-misc2002 kernel: [    0.219373] ACPI:=
 FIDT 0x0000000067892000 00009C (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
> 2025-05-21T10:35:36.854908+00:00 mc-misc2002 kernel: [    0.219377] ACPI:=
 SSDT 0x00000000678FE000 000704 (v02 INTEL  RAS_ACPI 00000001 INTL 20200925)
> 2025-05-21T10:35:36.854908+00:00 mc-misc2002 kernel: [    0.219381] ACPI:=
 EINJ 0x00000000678FD000 000150 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
> 2025-05-21T10:35:36.854908+00:00 mc-misc2002 kernel: [    0.219385] ACPI:=
 ERST 0x0000000067891000 000230 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
> 2025-05-21T10:35:36.854909+00:00 mc-misc2002 kernel: [    0.219389] ACPI:=
 BERT 0x0000000067890000 000030 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
> 2025-05-21T10:35:36.854909+00:00 mc-misc2002 kernel: [    0.219393] ACPI:=
 SSDT 0x000000006788F000 000745 (v02 INTEL  ADDRXLAT 00000001 INTL 20200925)
> 2025-05-21T10:35:36.854911+00:00 mc-misc2002 kernel: [    0.219397] ACPI:=
 MCFG 0x000000006788E000 00003C (v01 SUPERM SMCI--MB 01072009 MSFT 00000097)
> 2025-05-21T10:35:36.854911+00:00 mc-misc2002 kernel: [    0.219401] ACPI:=
 BDAT 0x000000006788D000 000030 (v01 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T10:35:36.854912+00:00 mc-misc2002 kernel: [    0.219405] ACPI:=
 HMAT 0x000000006788C000 000180 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
> 2025-05-21T10:35:36.854912+00:00 mc-misc2002 kernel: [    0.219409] ACPI:=
 HPET 0x000000006788B000 000038 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
> 2025-05-21T10:35:36.854912+00:00 mc-misc2002 kernel: [    0.219413] ACPI:=
 MIGT 0x000000006788A000 000040 (v01 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T10:35:36.854912+00:00 mc-misc2002 kernel: [    0.219416] ACPI:=
 MSCT 0x0000000067889000 000090 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
> 2025-05-21T10:35:36.854913+00:00 mc-misc2002 kernel: [    0.219420] ACPI:=
 WDDT 0x0000000067888000 000040 (v01 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T10:35:36.854915+00:00 mc-misc2002 kernel: [    0.219424] ACPI:=
 APIC 0x0000000067886000 0001DE (v04 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T10:35:36.854916+00:00 mc-misc2002 kernel: [    0.219428] ACPI:=
 SLIT 0x0000000067885000 000030 (v01 SUPERM SMCI--MB 00000001 AMI  01000013)
> 2025-05-21T10:35:36.854917+00:00 mc-misc2002 kernel: [    0.219432] ACPI:=
 SRAT 0x000000006787E000 006430 (v03 SUPERM SMCI--MB 00000002 AMI  01000013)
> 2025-05-21T10:35:36.854917+00:00 mc-misc2002 kernel: [    0.219436] ACPI:=
 OEM4 0x00000000676F6000 187A61 (v02 INTEL  CPU  CST 00003000 INTL 20200925)
> 2025-05-21T10:35:36.854919+00:00 mc-misc2002 kernel: [    0.219441] ACPI:=
 OEM1 0x00000000675E2000 113489 (v02 INTEL  CPU EIST 00003000 INTL 20200925)
> 2025-05-21T10:35:36.854920+00:00 mc-misc2002 kernel: [    0.219445] ACPI:=
 SSDT 0x000000006756B000 0764A5 (v02 INTEL  SSDT  PM 00004000 INTL 20200925)
> 2025-05-21T10:35:36.854921+00:00 mc-misc2002 kernel: [    0.219448] ACPI:=
 HEST 0x0000000067569000 00013C (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
> 2025-05-21T10:35:36.854922+00:00 mc-misc2002 kernel: [    0.219452] ACPI:=
 DMAR 0x0000000067568000 0002F8 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
> 2025-05-21T10:35:36.854922+00:00 mc-misc2002 kernel: [    0.219457] ACPI:=
 SSDT 0x0000000067560000 0078BA (v02 INTEL  SpsNm    00000002 INTL 20200925)
> 2025-05-21T10:35:36.854923+00:00 mc-misc2002 kernel: [    0.219461] ACPI:=
 SSDT 0x000000006755E000 001744 (v01 SUPERM SMCCDN   00000000 INTL 20181221)
> 2025-05-21T10:35:36.854923+00:00 mc-misc2002 kernel: [    0.219465] ACPI:=
 WSMT 0x0000000067887000 000028 (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
> 2025-05-21T10:35:36.854923+00:00 mc-misc2002 kernel: [    0.219469] ACPI:=
 SSDT 0x000000006756A000 0009B3 (v02 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T10:35:36.854925+00:00 mc-misc2002 kernel: [    0.219472] ACPI:=
 Reserving FACP table memory at [mem 0x678fc000-0x678fc113]
> 2025-05-21T10:35:36.854925+00:00 mc-misc2002 kernel: [    0.219473] ACPI:=
 Reserving DSDT table memory at [mem 0x67893000-0x678fa848]
> 2025-05-21T10:35:36.854926+00:00 mc-misc2002 kernel: [    0.219474] ACPI:=
 Reserving FACS table memory at [mem 0x67dfd000-0x67dfd03f]
> 2025-05-21T10:35:36.854926+00:00 mc-misc2002 kernel: [    0.219475] ACPI:=
 Reserving SPMI table memory at [mem 0x678fb000-0x678fb040]
> 2025-05-21T10:35:36.854926+00:00 mc-misc2002 kernel: [    0.219476] ACPI:=
 Reserving FIDT table memory at [mem 0x67892000-0x6789209b]
> 2025-05-21T10:35:36.854927+00:00 mc-misc2002 kernel: [    0.219477] ACPI:=
 Reserving SSDT table memory at [mem 0x678fe000-0x678fe703]
> 2025-05-21T10:35:36.854927+00:00 mc-misc2002 kernel: [    0.219478] ACPI:=
 Reserving EINJ table memory at [mem 0x678fd000-0x678fd14f]
> 2025-05-21T10:35:36.854941+00:00 mc-misc2002 kernel: [    0.219479] ACPI:=
 Reserving ERST table memory at [mem 0x67891000-0x6789122f]
> 2025-05-21T10:35:36.854942+00:00 mc-misc2002 kernel: [    0.219480] ACPI:=
 Reserving BERT table memory at [mem 0x67890000-0x6789002f]
> 2025-05-21T10:35:36.854942+00:00 mc-misc2002 kernel: [    0.219481] ACPI:=
 Reserving SSDT table memory at [mem 0x6788f000-0x6788f744]
> 2025-05-21T10:35:36.854943+00:00 mc-misc2002 kernel: [    0.219482] ACPI:=
 Reserving MCFG table memory at [mem 0x6788e000-0x6788e03b]
> 2025-05-21T10:35:36.854943+00:00 mc-misc2002 kernel: [    0.219483] ACPI:=
 Reserving BDAT table memory at [mem 0x6788d000-0x6788d02f]
> 2025-05-21T10:35:36.854943+00:00 mc-misc2002 kernel: [    0.219484] ACPI:=
 Reserving HMAT table memory at [mem 0x6788c000-0x6788c17f]
> 2025-05-21T10:35:36.854945+00:00 mc-misc2002 kernel: [    0.219485] ACPI:=
 Reserving HPET table memory at [mem 0x6788b000-0x6788b037]
> 2025-05-21T10:35:36.854945+00:00 mc-misc2002 kernel: [    0.219486] ACPI:=
 Reserving MIGT table memory at [mem 0x6788a000-0x6788a03f]
> 2025-05-21T10:35:36.854946+00:00 mc-misc2002 kernel: [    0.219487] ACPI:=
 Reserving MSCT table memory at [mem 0x67889000-0x6788908f]
> 2025-05-21T10:35:36.854946+00:00 mc-misc2002 kernel: [    0.219488] ACPI:=
 Reserving WDDT table memory at [mem 0x67888000-0x6788803f]
> 2025-05-21T10:35:36.854946+00:00 mc-misc2002 kernel: [    0.219488] ACPI:=
 Reserving APIC table memory at [mem 0x67886000-0x678861dd]
> 2025-05-21T10:35:36.854947+00:00 mc-misc2002 kernel: [    0.219489] ACPI:=
 Reserving SLIT table memory at [mem 0x67885000-0x6788502f]
> 2025-05-21T10:35:36.854947+00:00 mc-misc2002 kernel: [    0.219490] ACPI:=
 Reserving SRAT table memory at [mem 0x6787e000-0x6788442f]
> 2025-05-21T10:35:36.854949+00:00 mc-misc2002 kernel: [    0.219491] ACPI:=
 Reserving OEM4 table memory at [mem 0x676f6000-0x6787da60]
> 2025-05-21T10:35:36.854949+00:00 mc-misc2002 kernel: [    0.219492] ACPI:=
 Reserving OEM1 table memory at [mem 0x675e2000-0x676f5488]
> 2025-05-21T10:35:36.854949+00:00 mc-misc2002 kernel: [    0.219493] ACPI:=
 Reserving SSDT table memory at [mem 0x6756b000-0x675e14a4]
> 2025-05-21T10:35:36.854950+00:00 mc-misc2002 kernel: [    0.219494] ACPI:=
 Reserving HEST table memory at [mem 0x67569000-0x6756913b]
> 2025-05-21T10:35:36.854950+00:00 mc-misc2002 kernel: [    0.219495] ACPI:=
 Reserving DMAR table memory at [mem 0x67568000-0x675682f7]
> 2025-05-21T10:35:36.854950+00:00 mc-misc2002 kernel: [    0.219496] ACPI:=
 Reserving SSDT table memory at [mem 0x67560000-0x675678b9]
> 2025-05-21T10:35:36.855026+00:00 mc-misc2002 kernel: [    0.219497] ACPI:=
 Reserving SSDT table memory at [mem 0x6755e000-0x6755f743]
> 2025-05-21T10:35:36.855027+00:00 mc-misc2002 kernel: [    0.219498] ACPI:=
 Reserving WSMT table memory at [mem 0x67887000-0x67887027]
> 2025-05-21T10:35:36.855027+00:00 mc-misc2002 kernel: [    0.219499] ACPI:=
 Reserving SSDT table memory at [mem 0x6756a000-0x6756a9b2]
> 2025-05-21T10:35:36.855028+00:00 mc-misc2002 kernel: [    0.219544] SRAT:=
 PXM 0 -> APIC 0x00 -> Node 0
> 2025-05-21T10:35:36.855028+00:00 mc-misc2002 kernel: [    0.219546] SRAT:=
 PXM 0 -> APIC 0x01 -> Node 0
> 2025-05-21T10:35:36.855028+00:00 mc-misc2002 kernel: [    0.219547] SRAT:=
 PXM 0 -> APIC 0x02 -> Node 0
> 2025-05-21T10:35:36.855055+00:00 mc-misc2002 kernel: [    0.219548] SRAT:=
 PXM 0 -> APIC 0x03 -> Node 0
> 2025-05-21T10:35:36.855056+00:00 mc-misc2002 kernel: [    0.219548] SRAT:=
 PXM 0 -> APIC 0x04 -> Node 0
> 2025-05-21T10:35:36.855056+00:00 mc-misc2002 kernel: [    0.219549] SRAT:=
 PXM 0 -> APIC 0x05 -> Node 0
> 2025-05-21T10:35:36.855056+00:00 mc-misc2002 kernel: [    0.219550] SRAT:=
 PXM 0 -> APIC 0x06 -> Node 0
> 2025-05-21T10:35:36.855057+00:00 mc-misc2002 kernel: [    0.219551] SRAT:=
 PXM 0 -> APIC 0x07 -> Node 0
> 2025-05-21T10:35:36.855057+00:00 mc-misc2002 kernel: [    0.219552] SRAT:=
 PXM 0 -> APIC 0x08 -> Node 0
> 2025-05-21T10:35:36.855057+00:00 mc-misc2002 kernel: [    0.219552] SRAT:=
 PXM 0 -> APIC 0x09 -> Node 0
> 2025-05-21T10:35:36.855059+00:00 mc-misc2002 kernel: [    0.219553] SRAT:=
 PXM 0 -> APIC 0x0a -> Node 0
> 2025-05-21T10:35:36.855060+00:00 mc-misc2002 kernel: [    0.219554] SRAT:=
 PXM 0 -> APIC 0x0b -> Node 0
> 2025-05-21T10:35:36.855060+00:00 mc-misc2002 kernel: [    0.219555] SRAT:=
 PXM 0 -> APIC 0x0c -> Node 0
> 2025-05-21T10:35:36.855060+00:00 mc-misc2002 kernel: [    0.219555] SRAT:=
 PXM 0 -> APIC 0x0d -> Node 0
> 2025-05-21T10:35:36.855061+00:00 mc-misc2002 kernel: [    0.219556] SRAT:=
 PXM 0 -> APIC 0x0e -> Node 0
> 2025-05-21T10:35:36.855061+00:00 mc-misc2002 kernel: [    0.219557] SRAT:=
 PXM 0 -> APIC 0x0f -> Node 0
> 2025-05-21T10:35:36.855063+00:00 mc-misc2002 kernel: [    0.219558] SRAT:=
 PXM 0 -> APIC 0x10 -> Node 0
> 2025-05-21T10:35:36.855063+00:00 mc-misc2002 kernel: [    0.219559] SRAT:=
 PXM 0 -> APIC 0x11 -> Node 0
> 2025-05-21T10:35:36.855063+00:00 mc-misc2002 kernel: [    0.219559] SRAT:=
 PXM 0 -> APIC 0x12 -> Node 0
> 2025-05-21T10:35:36.855064+00:00 mc-misc2002 kernel: [    0.219560] SRAT:=
 PXM 0 -> APIC 0x13 -> Node 0
> 2025-05-21T10:35:36.855064+00:00 mc-misc2002 kernel: [    0.219561] SRAT:=
 PXM 0 -> APIC 0x14 -> Node 0
> 2025-05-21T10:35:36.855064+00:00 mc-misc2002 kernel: [    0.219562] SRAT:=
 PXM 0 -> APIC 0x15 -> Node 0
> 2025-05-21T10:35:36.855064+00:00 mc-misc2002 kernel: [    0.219563] SRAT:=
 PXM 0 -> APIC 0x16 -> Node 0
> 2025-05-21T10:35:36.855066+00:00 mc-misc2002 kernel: [    0.219563] SRAT:=
 PXM 0 -> APIC 0x17 -> Node 0
> 2025-05-21T10:35:36.855067+00:00 mc-misc2002 kernel: [    0.219564] SRAT:=
 PXM 1 -> APIC 0x40 -> Node 1
> 2025-05-21T10:35:36.855067+00:00 mc-misc2002 kernel: [    0.219565] SRAT:=
 PXM 1 -> APIC 0x41 -> Node 1
> 2025-05-21T10:35:36.855067+00:00 mc-misc2002 kernel: [    0.219566] SRAT:=
 PXM 1 -> APIC 0x42 -> Node 1
> 2025-05-21T10:35:36.855068+00:00 mc-misc2002 kernel: [    0.219566] SRAT:=
 PXM 1 -> APIC 0x43 -> Node 1
> 2025-05-21T10:35:36.855068+00:00 mc-misc2002 kernel: [    0.219567] SRAT:=
 PXM 1 -> APIC 0x44 -> Node 1
> 2025-05-21T10:35:36.855070+00:00 mc-misc2002 kernel: [    0.219568] SRAT:=
 PXM 1 -> APIC 0x45 -> Node 1
> 2025-05-21T10:35:36.855070+00:00 mc-misc2002 kernel: [    0.219569] SRAT:=
 PXM 1 -> APIC 0x46 -> Node 1
> 2025-05-21T10:35:36.855070+00:00 mc-misc2002 kernel: [    0.219570] SRAT:=
 PXM 1 -> APIC 0x47 -> Node 1
> 2025-05-21T10:35:36.855071+00:00 mc-misc2002 kernel: [    0.219570] SRAT:=
 PXM 1 -> APIC 0x48 -> Node 1
> 2025-05-21T10:35:36.855071+00:00 mc-misc2002 kernel: [    0.219571] SRAT:=
 PXM 1 -> APIC 0x49 -> Node 1
> 2025-05-21T10:35:36.855071+00:00 mc-misc2002 kernel: [    0.219572] SRAT:=
 PXM 1 -> APIC 0x4a -> Node 1
> 2025-05-21T10:35:36.855073+00:00 mc-misc2002 kernel: [    0.219573] SRAT:=
 PXM 1 -> APIC 0x4b -> Node 1
> 2025-05-21T10:35:36.855074+00:00 mc-misc2002 kernel: [    0.219574] SRAT:=
 PXM 1 -> APIC 0x4c -> Node 1
> 2025-05-21T10:35:36.855074+00:00 mc-misc2002 kernel: [    0.219575] SRAT:=
 PXM 1 -> APIC 0x4d -> Node 1
> 2025-05-21T10:35:36.855074+00:00 mc-misc2002 kernel: [    0.219576] SRAT:=
 PXM 1 -> APIC 0x4e -> Node 1
> 2025-05-21T10:35:36.855074+00:00 mc-misc2002 kernel: [    0.219577] SRAT:=
 PXM 1 -> APIC 0x4f -> Node 1
> 2025-05-21T10:35:36.855075+00:00 mc-misc2002 kernel: [    0.219577] SRAT:=
 PXM 1 -> APIC 0x50 -> Node 1
> 2025-05-21T10:35:36.855075+00:00 mc-misc2002 kernel: [    0.219578] SRAT:=
 PXM 1 -> APIC 0x51 -> Node 1
> 2025-05-21T10:35:36.855077+00:00 mc-misc2002 kernel: [    0.219579] SRAT:=
 PXM 1 -> APIC 0x52 -> Node 1
> 2025-05-21T10:35:36.855077+00:00 mc-misc2002 kernel: [    0.219580] SRAT:=
 PXM 1 -> APIC 0x53 -> Node 1
> 2025-05-21T10:35:36.855077+00:00 mc-misc2002 kernel: [    0.219581] SRAT:=
 PXM 1 -> APIC 0x54 -> Node 1
> 2025-05-21T10:35:36.855078+00:00 mc-misc2002 kernel: [    0.219581] SRAT:=
 PXM 1 -> APIC 0x55 -> Node 1
> 2025-05-21T10:35:36.855078+00:00 mc-misc2002 kernel: [    0.219582] SRAT:=
 PXM 1 -> APIC 0x56 -> Node 1
> 2025-05-21T10:35:36.855078+00:00 mc-misc2002 kernel: [    0.219583] SRAT:=
 PXM 1 -> APIC 0x57 -> Node 1
> 2025-05-21T10:35:36.855080+00:00 mc-misc2002 kernel: [    0.219636] ACPI:=
 SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> 2025-05-21T10:35:36.855080+00:00 mc-misc2002 kernel: [    0.219639] ACPI:=
 SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
> 2025-05-21T10:35:36.855089+00:00 mc-misc2002 kernel: [    0.219640] ACPI:=
 SRAT: Node 1 PXM 1 [mem 0x2080000000-0x407fffffff]
> 2025-05-21T10:35:36.855090+00:00 mc-misc2002 kernel: [    0.219655] NUMA:=
 Initialized distance table, cnt=3D2
> 2025-05-21T10:35:36.855090+00:00 mc-misc2002 kernel: [    0.219658] NUMA:=
 Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-0x207fffffff] -> [me=
m 0x00000000-0x207fffffff]
> 2025-05-21T10:35:36.855090+00:00 mc-misc2002 kernel: [    0.219670] NODE_=
DATA(0) allocated [mem 0x207ffd5000-0x207fffffff]
> 2025-05-21T10:35:36.855092+00:00 mc-misc2002 kernel: [    0.219687] NODE_=
DATA(1) allocated [mem 0x407ffd4000-0x407fffefff]
> 2025-05-21T10:35:36.855092+00:00 mc-misc2002 kernel: [    0.220468] Zone =
ranges:
> 2025-05-21T10:35:36.855093+00:00 mc-misc2002 kernel: [    0.220469]   DMA=
      [mem 0x0000000000001000-0x0000000000ffffff]
> 2025-05-21T10:35:36.855093+00:00 mc-misc2002 kernel: [    0.220471]   DMA=
32    [mem 0x0000000001000000-0x00000000ffffffff]
> 2025-05-21T10:35:36.855102+00:00 mc-misc2002 kernel: [    0.220473]   Nor=
mal   [mem 0x0000000100000000-0x000000407fffffff]
> 2025-05-21T10:35:36.855102+00:00 mc-misc2002 kernel: [    0.220475]   Dev=
ice   empty
> 2025-05-21T10:35:36.855103+00:00 mc-misc2002 kernel: [    0.220476] Movab=
le zone start for each node
> 2025-05-21T10:35:36.855105+00:00 mc-misc2002 kernel: [    0.220480] Early=
 memory node ranges
> 2025-05-21T10:35:36.855105+00:00 mc-misc2002 kernel: [    0.220481]   nod=
e   0: [mem 0x0000000000001000-0x0000000000097fff]
> 2025-05-21T10:35:36.855106+00:00 mc-misc2002 kernel: [    0.220483]   nod=
e   0: [mem 0x0000000000100000-0x00000000645fefff]
> 2025-05-21T10:35:36.855106+00:00 mc-misc2002 kernel: [    0.220484]   nod=
e   0: [mem 0x000000006c1ff000-0x000000006f7fffff]
> 2025-05-21T10:35:36.855116+00:00 mc-misc2002 kernel: [    0.220485]   nod=
e   0: [mem 0x0000000100000000-0x000000207fffffff]
> 2025-05-21T10:35:36.855117+00:00 mc-misc2002 kernel: [    0.220499]   nod=
e   1: [mem 0x0000002080000000-0x000000407fffffff]
> 2025-05-21T10:35:36.855119+00:00 mc-misc2002 kernel: [    0.220514] Initm=
em setup node 0 [mem 0x0000000000001000-0x000000207fffffff]
> 2025-05-21T10:35:36.855120+00:00 mc-misc2002 kernel: [    0.220519] Initm=
em setup node 1 [mem 0x0000002080000000-0x000000407fffffff]
> 2025-05-21T10:35:36.855120+00:00 mc-misc2002 kernel: [    0.220523] On no=
de 0, zone DMA: 1 pages in unavailable ranges
> 2025-05-21T10:35:36.855120+00:00 mc-misc2002 kernel: [    0.220563] On no=
de 0, zone DMA: 104 pages in unavailable ranges
> 2025-05-21T10:35:36.855121+00:00 mc-misc2002 kernel: [    0.224784] On no=
de 0, zone DMA32: 31744 pages in unavailable ranges
> 2025-05-21T10:35:36.855121+00:00 mc-misc2002 kernel: [    0.225146] On no=
de 0, zone Normal: 2048 pages in unavailable ranges
> 2025-05-21T10:35:36.855121+00:00 mc-misc2002 kernel: [    0.225642] ACPI:=
 PM-Timer IO Port: 0x508
> 2025-05-21T10:35:36.855124+00:00 mc-misc2002 kernel: [    0.225657] ACPI:=
 X2APIC_NMI (uid[0xffffffff] high edge lint[0x1])
> 2025-05-21T10:35:36.855133+00:00 mc-misc2002 kernel: [    0.225661] ACPI:=
 LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> 2025-05-21T10:35:36.855133+00:00 mc-misc2002 kernel: [    0.225680] IOAPI=
C[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-119
> 2025-05-21T10:35:36.855133+00:00 mc-misc2002 kernel: [    0.225684] ACPI:=
 INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> 2025-05-21T10:35:36.855134+00:00 mc-misc2002 kernel: [    0.225686] ACPI:=
 INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> 2025-05-21T10:35:36.855134+00:00 mc-misc2002 kernel: [    0.225692] ACPI:=
 Using ACPI (MADT) for SMP configuration information
> 2025-05-21T10:35:36.855136+00:00 mc-misc2002 kernel: [    0.225693] ACPI:=
 HPET id: 0x8086a701 base: 0xfed00000
> 2025-05-21T10:35:36.855137+00:00 mc-misc2002 kernel: [    0.225699] TSC d=
eadline timer available
> 2025-05-21T10:35:36.855138+00:00 mc-misc2002 kernel: [    0.225701] smpbo=
ot: Allowing 48 CPUs, 0 hotplug CPUs
> 2025-05-21T10:35:36.855138+00:00 mc-misc2002 kernel: [    0.225721] PM: h=
ibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> 2025-05-21T10:35:36.855139+00:00 mc-misc2002 kernel: [    0.225723] PM: h=
ibernation: Registered nosave memory: [mem 0x00098000-0x000fffff]
> 2025-05-21T10:35:36.855139+00:00 mc-misc2002 kernel: [    0.225725] PM: h=
ibernation: Registered nosave memory: [mem 0x645ff000-0x6c1fefff]
> 2025-05-21T10:35:36.855140+00:00 mc-misc2002 kernel: [    0.225727] PM: h=
ibernation: Registered nosave memory: [mem 0x6f800000-0xffffffff]
> 2025-05-21T10:35:36.855141+00:00 mc-misc2002 kernel: [    0.225730] [mem =
0x90000000-0xfcffffff] available for PCI devices
> 2025-05-21T10:35:36.855141+00:00 mc-misc2002 kernel: [    0.225732] Booti=
ng paravirtualized kernel on bare hardware
> 2025-05-21T10:35:36.855141+00:00 mc-misc2002 kernel: [    0.225735] clock=
source: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_=
ns: 7645519600211568 ns
> 2025-05-21T10:35:36.855142+00:00 mc-misc2002 kernel: [    0.231976] setup=
_percpu: NR_CPUS:8192 nr_cpumask_bits:48 nr_cpu_ids:48 nr_node_ids:2
> 2025-05-21T10:35:36.855142+00:00 mc-misc2002 kernel: [    0.234086] percp=
u: Embedded 61 pages/cpu s212992 r8192 d28672 u262144
> 2025-05-21T10:35:36.855142+00:00 mc-misc2002 kernel: [    0.234096] pcpu-=
alloc: s212992 r8192 d28672 u262144 alloc=3D1*2097152
> 2025-05-21T10:35:36.855145+00:00 mc-misc2002 kernel: [    0.234098] pcpu-=
alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 24 25 26 27=20
> 2025-05-21T10:35:36.855145+00:00 mc-misc2002 kernel: [    0.234109] pcpu-=
alloc: [0] 28 29 30 31 32 33 34 35 [1] 12 13 14 15 16 17 18 19=20
> 2025-05-21T10:35:36.855145+00:00 mc-misc2002 kernel: [    0.234119] pcpu-=
alloc: [1] 20 21 22 23 36 37 38 39 [1] 40 41 42 43 44 45 46 47=20
> 2025-05-21T10:35:36.855146+00:00 mc-misc2002 kernel: [    0.234166] Fallb=
ack order for Node 0: 0 1=20
> 2025-05-21T10:35:36.855146+00:00 mc-misc2002 kernel: [    0.234169] Fallb=
ack order for Node 1: 1 0=20
> 2025-05-21T10:35:36.855146+00:00 mc-misc2002 kernel: [    0.234174] Built=
 2 zonelists, mobility grouping on.  Total pages: 65962256
> 2025-05-21T10:35:36.855148+00:00 mc-misc2002 kernel: [    0.234176] Polic=
y zone: Normal
> 2025-05-21T10:35:36.855148+00:00 mc-misc2002 kernel: [    0.234177] Kerne=
l command line: BOOT_IMAGE=3D/boot/vmlinuz-6.1.0-34-amd64 root=3D/dev/mappe=
r/vg0-root ro console=3DttyS1,115200n8 raid0.default_layout=3D2 elevator=3D=
deadline
> 2025-05-21T10:35:36.855158+00:00 mc-misc2002 kernel: [    0.234260] Kerne=
l parameter elevator=3D does not have any effect anymore.
> 2025-05-21T10:35:36.855158+00:00 mc-misc2002 kernel: [    0.234260] Pleas=
e use sysfs to set IO scheduler for individual devices.
> 2025-05-21T10:35:36.855169+00:00 mc-misc2002 kernel: [    0.234264] Unkno=
wn kernel command line parameters "BOOT_IMAGE=3D/boot/vmlinuz-6.1.0-34-amd6=
4", will be passed to user space.
> 2025-05-21T10:35:36.855170+00:00 mc-misc2002 kernel: [    0.234276] rando=
m: crng init done
> 2025-05-21T10:35:36.855173+00:00 mc-misc2002 kernel: [    0.234277] print=
k: log_buf_len individual max cpu contribution: 4096 bytes
> 2025-05-21T10:35:36.855173+00:00 mc-misc2002 kernel: [    0.234279] print=
k: log_buf_len total cpu_extra contributions: 192512 bytes
> 2025-05-21T10:35:36.855173+00:00 mc-misc2002 kernel: [    0.234279] print=
k: log_buf_len min size: 131072 bytes
> 2025-05-21T10:35:36.855174+00:00 mc-misc2002 kernel: [    0.234731] print=
k: log_buf_len: 524288 bytes
> 2025-05-21T10:35:36.855174+00:00 mc-misc2002 kernel: [    0.234732] print=
k: early log buf free: 117400(89%)
> 2025-05-21T10:35:36.855175+00:00 mc-misc2002 kernel: [    0.235540] mem a=
uto-init: stack:all(zero), heap alloc:on, heap free:off
> 2025-05-21T10:35:36.855198+00:00 mc-misc2002 kernel: [    0.235563] softw=
are IO TLB: area num 64.
> 2025-05-21T10:35:36.855200+00:00 mc-misc2002 kernel: [    0.360968] Memor=
y: 1849472K/268037724K available (14342K kernel code, 2339K rwdata, 9092K r=
odata, 2800K init, 17380K bss, 4372840K reserved, 0K cma-reserved)
> 2025-05-21T10:35:36.855200+00:00 mc-misc2002 kernel: [    0.361289] SLUB:=
 HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D48, Nodes=3D2
> 2025-05-21T10:35:36.855200+00:00 mc-misc2002 kernel: [    0.361328] ftrac=
e: allocating 40336 entries in 158 pages
> 2025-05-21T10:35:36.855201+00:00 mc-misc2002 kernel: [    0.370821] ftrac=
e: allocated 158 pages with 5 groups
> 2025-05-21T10:35:36.855201+00:00 mc-misc2002 kernel: [    0.371845] Dynam=
ic Preempt: voluntary
> 2025-05-21T10:35:36.855213+00:00 mc-misc2002 kernel: [    0.371994] rcu: =
Preemptible hierarchical RCU implementation.
> 2025-05-21T10:35:36.855214+00:00 mc-misc2002 kernel: [    0.371995] rcu: =
	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=3D48.
> 2025-05-21T10:35:36.855214+00:00 mc-misc2002 kernel: [    0.371997] 	Tram=
poline variant of Tasks RCU enabled.
> 2025-05-21T10:35:36.855215+00:00 mc-misc2002 kernel: [    0.371998] 	Rude=
 variant of Tasks RCU enabled.
> 2025-05-21T10:35:36.855215+00:00 mc-misc2002 kernel: [    0.371999] 	Trac=
ing variant of Tasks RCU enabled.
> 2025-05-21T10:35:36.855215+00:00 mc-misc2002 kernel: [    0.372000] rcu: =
RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> 2025-05-21T10:35:36.855216+00:00 mc-misc2002 kernel: [    0.372001] rcu: =
Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D48
> 2025-05-21T10:35:36.855219+00:00 mc-misc2002 kernel: [    0.377725] NR_IR=
QS: 524544, nr_irqs: 2440, preallocated irqs: 16
> 2025-05-21T10:35:36.855220+00:00 mc-misc2002 kernel: [    0.377970] rcu: =
srcu_init: Setting srcu_struct sizes based on contention.
> 2025-05-21T10:35:36.855220+00:00 mc-misc2002 kernel: [    0.378605] Conso=
le: colour dummy device 80x25
> 2025-05-21T10:35:36.855221+00:00 mc-misc2002 kernel: [    1.888139] print=
k: console [ttyS1] enabled
> 2025-05-21T10:35:36.855221+00:00 mc-misc2002 kernel: [    1.892884] mempo=
licy: Enabling automatic NUMA balancing. Configure with numa_balancing=3D o=
r the kernel.numa_balancing sysctl
> 2025-05-21T10:35:36.855222+00:00 mc-misc2002 kernel: [    1.905479] ACPI:=
 Core revision 20220331
> 2025-05-21T10:35:36.855225+00:00 mc-misc2002 kernel: [    1.912694] clock=
source: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7963585=
5245 ns
> 2025-05-21T10:35:36.855226+00:00 mc-misc2002 kernel: [    1.922899] APIC:=
 Switch to symmetric I/O mode setup
> 2025-05-21T10:35:36.855226+00:00 mc-misc2002 kernel: [    1.928488] DMAR:=
 Host address width 46
> 2025-05-21T10:35:36.855227+00:00 mc-misc2002 kernel: [    1.932805] DMAR:=
 DRHD base: 0x000000d0ffc000 flags: 0x0
> 2025-05-21T10:35:36.855236+00:00 mc-misc2002 kernel: [    1.938788] DMAR:=
 dmar0: reg_base_addr d0ffc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:35:36.855237+00:00 mc-misc2002 kernel: [    1.948274] DMAR:=
 DRHD base: 0x000000dbbfc000 flags: 0x0
> 2025-05-21T10:35:36.855240+00:00 mc-misc2002 kernel: [    1.954255] DMAR:=
 dmar1: reg_base_addr dbbfc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:35:36.855241+00:00 mc-misc2002 kernel: [    1.963743] DMAR:=
 DRHD base: 0x000000e67fc000 flags: 0x0
> 2025-05-21T10:35:36.855242+00:00 mc-misc2002 kernel: [    1.969721] DMAR:=
 dmar2: reg_base_addr e67fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:35:36.855242+00:00 mc-misc2002 kernel: [    1.979208] DMAR:=
 DRHD base: 0x000000f13fc000 flags: 0x0
> 2025-05-21T10:35:36.855242+00:00 mc-misc2002 kernel: [    1.985190] DMAR:=
 dmar3: reg_base_addr f13fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:35:36.855243+00:00 mc-misc2002 kernel: [    1.994677] DMAR:=
 DRHD base: 0x000000fb7fc000 flags: 0x0
> 2025-05-21T10:35:36.855243+00:00 mc-misc2002 kernel: [    2.000656] DMAR:=
 dmar4: reg_base_addr fb7fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:35:36.855246+00:00 mc-misc2002 kernel: [    2.010142] DMAR:=
 DRHD base: 0x000000a63fc000 flags: 0x0
> 2025-05-21T10:35:36.855247+00:00 mc-misc2002 kernel: [    2.016121] DMAR:=
 dmar5: reg_base_addr a63fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:35:36.855247+00:00 mc-misc2002 kernel: [    2.025607] DMAR:=
 DRHD base: 0x000000b0ffc000 flags: 0x0
> 2025-05-21T10:35:36.855248+00:00 mc-misc2002 kernel: [    2.031584] DMAR:=
 dmar6: reg_base_addr b0ffc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:35:36.855248+00:00 mc-misc2002 kernel: [    2.041069] DMAR:=
 DRHD base: 0x000000bbbfc000 flags: 0x0
> 2025-05-21T10:35:36.855248+00:00 mc-misc2002 kernel: [    2.047046] DMAR:=
 dmar7: reg_base_addr bbbfc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:35:36.855251+00:00 mc-misc2002 kernel: [    2.056531] DMAR:=
 DRHD base: 0x000000c5ffc000 flags: 0x0
> 2025-05-21T10:35:36.855252+00:00 mc-misc2002 kernel: [    2.062507] DMAR:=
 dmar8: reg_base_addr c5ffc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:35:36.855253+00:00 mc-misc2002 kernel: [    2.071994] DMAR:=
 DRHD base: 0x0000009b7fc000 flags: 0x1
> 2025-05-21T10:35:36.855254+00:00 mc-misc2002 kernel: [    2.077970] DMAR:=
 dmar9: reg_base_addr 9b7fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T10:35:36.855254+00:00 mc-misc2002 kernel: [    2.087456] DMAR:=
 RMRR base: 0x0000006b985000 end: 0x0000006b9a8fff
> 2025-05-21T10:35:36.855254+00:00 mc-misc2002 kernel: [    2.094504] DMAR:=
 RMRR base: 0x0000006a3d8000 end: 0x0000006a621fff
> 2025-05-21T10:35:36.855264+00:00 mc-misc2002 kernel: [    2.101551] DMAR:=
 ATSR flags: 0x0
> 2025-05-21T10:35:36.855265+00:00 mc-misc2002 kernel: [    2.105283] DMAR:=
 ATSR flags: 0x0
> 2025-05-21T10:35:36.855265+00:00 mc-misc2002 kernel: [    2.109016] DMAR:=
 RHSA base: 0x0000009b7fc000 proximity domain: 0x0
> 2025-05-21T10:35:36.855265+00:00 mc-misc2002 kernel: [    2.116063] DMAR:=
 RHSA base: 0x000000a63fc000 proximity domain: 0x0
> 2025-05-21T10:35:36.855266+00:00 mc-misc2002 kernel: [    2.123111] DMAR:=
 RHSA base: 0x000000b0ffc000 proximity domain: 0x0
> 2025-05-21T10:35:36.855266+00:00 mc-misc2002 kernel: [    2.130158] DMAR:=
 RHSA base: 0x000000bbbfc000 proximity domain: 0x0
> 2025-05-21T10:35:36.855266+00:00 mc-misc2002 kernel: [    2.137205] DMAR:=
 RHSA base: 0x000000c5ffc000 proximity domain: 0x0
> 2025-05-21T10:35:36.855269+00:00 mc-misc2002 kernel: [    2.144253] DMAR:=
 RHSA base: 0x000000d0ffc000 proximity domain: 0x1
> 2025-05-21T10:35:36.855271+00:00 mc-misc2002 kernel: [    2.151300] DMAR:=
 RHSA base: 0x000000dbbfc000 proximity domain: 0x1
> 2025-05-21T10:35:36.855271+00:00 mc-misc2002 kernel: [    2.158346] DMAR:=
 RHSA base: 0x000000e67fc000 proximity domain: 0x1
> 2025-05-21T10:35:36.855271+00:00 mc-misc2002 kernel: [    2.165393] DMAR:=
 RHSA base: 0x000000f13fc000 proximity domain: 0x1
> 2025-05-21T10:35:36.855272+00:00 mc-misc2002 kernel: [    2.172441] DMAR:=
 RHSA base: 0x000000fb7fc000 proximity domain: 0x1
> 2025-05-21T10:35:36.855272+00:00 mc-misc2002 kernel: [    2.179490] DMAR-=
IR: IOAPIC id 8 under DRHD base  0x9b7fc000 IOMMU 9
> 2025-05-21T10:35:36.855276+00:00 mc-misc2002 kernel: [    2.186635] DMAR-=
IR: HPET id 0 under DRHD base 0x9b7fc000
> 2025-05-21T10:35:36.855285+00:00 mc-misc2002 kernel: [    2.192708] DMAR-=
IR: Queued invalidation will be enabled to support x2apic and Intr-remappin=
g.
> 2025-05-21T10:35:36.855285+00:00 mc-misc2002 kernel: [    2.205448] DMAR-=
IR: Enabled IRQ remapping in x2apic mode
> 2025-05-21T10:35:36.855286+00:00 mc-misc2002 kernel: [    2.211510] x2api=
c enabled
> 2025-05-21T10:35:36.855289+00:00 mc-misc2002 kernel: [    2.214572] Switc=
hed APIC routing to cluster x2apic.
> 2025-05-21T10:35:36.855296+00:00 mc-misc2002 kernel: [    2.222785] ..TIM=
ER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
> 2025-05-21T10:35:36.855297+00:00 mc-misc2002 kernel: [    2.246874] clock=
source: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e4530a99b6, max_=
idle_ns: 440795257976 ns
> 2025-05-21T10:35:36.855301+00:00 mc-misc2002 kernel: [    2.258694] Calib=
rating delay loop (skipped), value calculated using timer frequency.. 4200.=
00 BogoMIPS (lpj=3D8400000)
> 2025-05-21T10:35:36.855302+00:00 mc-misc2002 kernel: [    2.262728] x86/c=
pu: VMX (outside TXT) disabled by BIOS
> 2025-05-21T10:35:36.855302+00:00 mc-misc2002 kernel: [    2.266693] x86/c=
pu: SGX disabled by BIOS.
> 2025-05-21T10:35:36.855303+00:00 mc-misc2002 kernel: [    2.270702] CPU0:=
 Thermal monitoring enabled (TM1)
> 2025-05-21T10:35:36.855303+00:00 mc-misc2002 kernel: [    2.274694] x86/c=
pu: User Mode Instruction Prevention (UMIP) activated
> 2025-05-21T10:35:36.855303+00:00 mc-misc2002 kernel: [    2.279052] proce=
ss: using mwait in idle threads
> 2025-05-21T10:35:36.855308+00:00 mc-misc2002 kernel: [    2.282694] Last =
level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> 2025-05-21T10:35:36.855308+00:00 mc-misc2002 kernel: [    2.286692] Last =
level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> 2025-05-21T10:35:36.855318+00:00 mc-misc2002 kernel: [    2.290698] Spect=
re V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> 2025-05-21T10:35:36.855318+00:00 mc-misc2002 kernel: [    2.294694] Spect=
re V2 : Spectre BHI mitigation: SW BHB clearing on vm exit
> 2025-05-21T10:35:36.855319+00:00 mc-misc2002 kernel: [    2.298692] Spect=
re V2 : Spectre BHI mitigation: SW BHB clearing on syscall
> 2025-05-21T10:35:36.855319+00:00 mc-misc2002 kernel: [    2.302692] Spect=
re V2 : Mitigation: Enhanced / Automatic IBRS
> 2025-05-21T10:35:36.855326+00:00 mc-misc2002 kernel: [    2.306692] Spect=
re V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> 2025-05-21T10:35:36.855327+00:00 mc-misc2002 kernel: [    2.310692] Spect=
re V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
> 2025-05-21T10:35:36.855327+00:00 mc-misc2002 kernel: [    2.314693] Spect=
re V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> 2025-05-21T10:35:36.855328+00:00 mc-misc2002 kernel: [    2.318693] Specu=
lative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> 2025-05-21T10:35:36.855328+00:00 mc-misc2002 kernel: [    2.322696] MMIO =
Stale Data: Mitigation: Clear CPU buffers
> 2025-05-21T10:35:36.855328+00:00 mc-misc2002 kernel: [    2.326694] GDS: =
Mitigation: Microcode
> 2025-05-21T10:35:36.855332+00:00 mc-misc2002 kernel: [    2.330702] x86/f=
pu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> 2025-05-21T10:35:36.855333+00:00 mc-misc2002 kernel: [    2.334692] x86/f=
pu: Supporting XSAVE feature 0x002: 'SSE registers'
> 2025-05-21T10:35:36.855333+00:00 mc-misc2002 kernel: [    2.338692] x86/f=
pu: Supporting XSAVE feature 0x004: 'AVX registers'
> 2025-05-21T10:35:36.855334+00:00 mc-misc2002 kernel: [    2.342692] x86/f=
pu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
> 2025-05-21T10:35:36.855334+00:00 mc-misc2002 kernel: [    2.346692] x86/f=
pu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
> 2025-05-21T10:35:36.855335+00:00 mc-misc2002 kernel: [    2.350692] x86/f=
pu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
> 2025-05-21T10:35:36.855335+00:00 mc-misc2002 kernel: [    2.354692] x86/f=
pu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
> 2025-05-21T10:35:36.855338+00:00 mc-misc2002 kernel: [    2.358692] x86/f=
pu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> 2025-05-21T10:35:36.855347+00:00 mc-misc2002 kernel: [    2.362692] x86/f=
pu: xstate_offset[5]:  832, xstate_sizes[5]:   64
> 2025-05-21T10:35:36.855348+00:00 mc-misc2002 kernel: [    2.366692] x86/f=
pu: xstate_offset[6]:  896, xstate_sizes[6]:  512
> 2025-05-21T10:35:36.855348+00:00 mc-misc2002 kernel: [    2.370692] x86/f=
pu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
> 2025-05-21T10:35:36.855350+00:00 mc-misc2002 kernel: [    2.374692] x86/f=
pu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
> 2025-05-21T10:35:36.855352+00:00 mc-misc2002 kernel: [    2.378692] x86/f=
pu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compa=
cted' format.
> 2025-05-21T10:35:36.855356+00:00 mc-misc2002 kernel: [    2.407058] Freei=
ng SMP alternatives memory: 36K
> 2025-05-21T10:35:36.855357+00:00 mc-misc2002 kernel: [    2.410693] pid_m=
ax: default: 49152 minimum: 384
> 2025-05-21T10:35:36.855358+00:00 mc-misc2002 kernel: [    2.414765] LSM: =
Security Framework initializing
> 2025-05-21T10:35:36.855358+00:00 mc-misc2002 kernel: [    2.422694] landl=
ock: Up and running.
> 2025-05-21T10:35:36.855358+00:00 mc-misc2002 kernel: [    2.426692] Yama:=
 disabled by default; enable with sysctl kernel.yama.*
> 2025-05-21T10:35:36.855359+00:00 mc-misc2002 kernel: [    2.430721] AppAr=
mor: AppArmor initialized
> 2025-05-21T10:35:36.855362+00:00 mc-misc2002 kernel: [    2.434693] TOMOY=
O Linux initialized
> 2025-05-21T10:35:36.855362+00:00 mc-misc2002 kernel: [    2.438698] LSM s=
upport for eBPF active
> 2025-05-21T10:35:36.855363+00:00 mc-misc2002 kernel: [    2.461483] Dentr=
y cache hash table entries: 16777216 (order: 15, 134217728 bytes, vmalloc h=
ugepage)
> 2025-05-21T10:35:36.855371+00:00 mc-misc2002 kernel: [    2.472923] Inode=
-cache hash table entries: 8388608 (order: 14, 67108864 bytes, vmalloc huge=
page)
> 2025-05-21T10:35:36.855372+00:00 mc-misc2002 kernel: [    2.475055] Mount=
-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T10:35:36.855373+00:00 mc-misc2002 kernel: [    2.479007] Mount=
point-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T10:35:36.855374+00:00 mc-misc2002 kernel: [    2.483462] smpbo=
ot: CPU0: Intel(R) Xeon(R) Silver 4310 CPU @ 2.10GHz (family: 0x6, model: 0=
x6a, stepping: 0x6)
> 2025-05-21T10:35:36.855382+00:00 mc-misc2002 kernel: [    2.486853] cblis=
t_init_generic: Setting adjustable number of callback queues.
> 2025-05-21T10:35:36.855382+00:00 mc-misc2002 kernel: [    2.490693] cblis=
t_init_generic: Setting shift to 6 and lim to 1.
> 2025-05-21T10:35:36.855382+00:00 mc-misc2002 kernel: [    2.494713] cblis=
t_init_generic: Setting adjustable number of callback queues.
> 2025-05-21T10:35:36.855383+00:00 mc-misc2002 kernel: [    2.498692] cblis=
t_init_generic: Setting shift to 6 and lim to 1.
> 2025-05-21T10:35:36.855383+00:00 mc-misc2002 kernel: [    2.502715] cblis=
t_init_generic: Setting adjustable number of callback queues.
> 2025-05-21T10:35:36.855384+00:00 mc-misc2002 kernel: [    2.506692] cblis=
t_init_generic: Setting shift to 6 and lim to 1.
> 2025-05-21T10:35:36.855398+00:00 mc-misc2002 kernel: [    2.510705] Perfo=
rmance Events: PEBS fmt4+-baseline,  AnyThread deprecated, Icelake events, =
32-deep LBR, full-width counters, Intel PMU driver.
> 2025-05-21T10:35:36.855399+00:00 mc-misc2002 kernel: [    2.514693] ... v=
ersion:                5
> 2025-05-21T10:35:36.855400+00:00 mc-misc2002 kernel: [    2.518692] ... b=
it width:              48
> 2025-05-21T10:35:36.855400+00:00 mc-misc2002 kernel: [    2.522692] ... g=
eneric registers:      8
> 2025-05-21T10:35:36.855400+00:00 mc-misc2002 kernel: [    2.526692] ... v=
alue mask:             0000ffffffffffff
> 2025-05-21T10:35:36.855401+00:00 mc-misc2002 kernel: [    2.530692] ... m=
ax period:             00007fffffffffff
> 2025-05-21T10:35:36.855425+00:00 mc-misc2002 kernel: [    2.534692] ... f=
ixed-purpose events:   4
> 2025-05-21T10:35:36.855427+00:00 mc-misc2002 kernel: [    2.538692] ... e=
vent mask:             0001000f000000ff
> 2025-05-21T10:35:36.855427+00:00 mc-misc2002 kernel: [    2.542838] signa=
l: max sigframe size: 3632
> 2025-05-21T10:35:36.855427+00:00 mc-misc2002 kernel: [    2.546710] Estim=
ated ratio of average max frequency by base frequency (times 1024): 1316
> 2025-05-21T10:35:36.855428+00:00 mc-misc2002 kernel: [    2.550713] rcu: =
Hierarchical SRCU implementation.
> 2025-05-21T10:35:36.855428+00:00 mc-misc2002 kernel: [    2.554692] rcu: =
	Max phase no-delay instances is 1000.
> 2025-05-21T10:35:36.855442+00:00 mc-misc2002 kernel: [    2.562062] NMI w=
atchdog: Enabled. Permanently consumes one hw-PMU counter.
> 2025-05-21T10:35:36.855444+00:00 mc-misc2002 kernel: [    2.563185] smp: =
Bringing up secondary CPUs ...
> 2025-05-21T10:35:36.855444+00:00 mc-misc2002 kernel: [    2.566793] x86: =
Booting SMP configuration:
> 2025-05-21T10:35:36.855446+00:00 mc-misc2002 kernel: [    2.570696] .... =
node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11
> 2025-05-21T10:35:36.855446+00:00 mc-misc2002 kernel: [    2.682694] .... =
node  #1, CPUs:   #12
> 2025-05-21T10:35:36.855447+00:00 mc-misc2002 kernel: [    1.688648] smpbo=
ot: CPU 12 Converting physical 0 to logical die 1
> 2025-05-21T10:35:36.855447+00:00 mc-misc2002 kernel: [    2.822785]  #13 =
#14 #15 #16 #17 #18 #19 #20 #21 #22 #23
> 2025-05-21T10:35:36.855457+00:00 mc-misc2002 kernel: [    2.934693] .... =
node  #0, CPUs:   #24
> 2025-05-21T10:35:36.855458+00:00 mc-misc2002 kernel: [    2.937327] MMIO =
Stale Data CPU bug present and SMT on, data leak possible. See https://www.=
kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.ht=
ml for more details.
> 2025-05-21T10:35:36.855459+00:00 mc-misc2002 kernel: [    2.942825]  #25 =
#26 #27 #28 #29 #30 #31 #32 #33 #34 #35
> 2025-05-21T10:35:36.855459+00:00 mc-misc2002 kernel: [    2.970694] .... =
node  #1, CPUs:   #36 #37 #38 #39 #40 #41 #42 #43 #44 #45 #46 #47
> 2025-05-21T10:35:36.855459+00:00 mc-misc2002 kernel: [    3.000090] smp: =
Brought up 2 nodes, 48 CPUs
> 2025-05-21T10:35:36.855459+00:00 mc-misc2002 kernel: [    3.006694] smpbo=
ot: Max logical packages: 2
> 2025-05-21T10:35:36.855462+00:00 mc-misc2002 kernel: [    3.010694] smpbo=
ot: Total of 48 processors activated (201643.94 BogoMIPS)
> 2025-05-21T10:35:36.855463+00:00 mc-misc2002 kernel: [    3.074742] node =
0 deferred pages initialised in 56ms
> 2025-05-21T10:35:36.855464+00:00 mc-misc2002 kernel: [    3.078701] node =
1 deferred pages initialised in 60ms
> 2025-05-21T10:35:36.855474+00:00 mc-misc2002 kernel: [    3.096653] devtm=
pfs: initialized
> 2025-05-21T10:35:36.855475+00:00 mc-misc2002 kernel: [    3.098768] x86/m=
m: Memory block size: 2048MB
> 2025-05-21T10:35:36.855476+00:00 mc-misc2002 kernel: [    3.103906] ACPI:=
 PM: Registering ACPI NVS region [mem 0x678ff000-0x67dfefff] (5242880 bytes)
> 2025-05-21T10:35:36.855479+00:00 mc-misc2002 kernel: [    3.106843] clock=
source: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645=
041785100000 ns
> 2025-05-21T10:35:36.855480+00:00 mc-misc2002 kernel: [    3.110855] futex=
 hash table entries: 16384 (order: 8, 1048576 bytes, vmalloc)
> 2025-05-21T10:35:36.855480+00:00 mc-misc2002 kernel: [    3.114856] pinct=
rl core: initialized pinctrl subsystem
> 2025-05-21T10:35:36.855481+00:00 mc-misc2002 kernel: [    3.120124] NET: =
Registered PF_NETLINK/PF_ROUTE protocol family
> 2025-05-21T10:35:36.855481+00:00 mc-misc2002 kernel: [    3.123478] DMA: =
preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
> 2025-05-21T10:35:36.855481+00:00 mc-misc2002 kernel: [    3.127172] DMA: =
preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> 2025-05-21T10:35:36.855485+00:00 mc-misc2002 kernel: [    3.131162] DMA: =
preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> 2025-05-21T10:35:36.855485+00:00 mc-misc2002 kernel: [    3.134704] audit=
: initializing netlink subsys (disabled)
> 2025-05-21T10:35:36.855486+00:00 mc-misc2002 kernel: [    3.138713] audit=
: type=3D2000 audit(1747823712.076:1): state=3Dinitialized audit_enabled=3D=
0 res=3D1
> 2025-05-21T10:35:36.855486+00:00 mc-misc2002 kernel: [    3.138855] therm=
al_sys: Registered thermal governor 'fair_share'
> 2025-05-21T10:35:36.855487+00:00 mc-misc2002 kernel: [    3.142694] therm=
al_sys: Registered thermal governor 'bang_bang'
> 2025-05-21T10:35:36.855487+00:00 mc-misc2002 kernel: [    3.146693] therm=
al_sys: Registered thermal governor 'step_wise'
> 2025-05-21T10:35:36.855488+00:00 mc-misc2002 kernel: [    3.150692] therm=
al_sys: Registered thermal governor 'user_space'
> 2025-05-21T10:35:36.855492+00:00 mc-misc2002 kernel: [    3.154692] therm=
al_sys: Registered thermal governor 'power_allocator'
> 2025-05-21T10:35:36.855493+00:00 mc-misc2002 kernel: [    3.158720] cpuid=
le: using governor ladder
> 2025-05-21T10:35:36.855493+00:00 mc-misc2002 kernel: [    3.170705] cpuid=
le: using governor menu
> 2025-05-21T10:35:36.855494+00:00 mc-misc2002 kernel: [    3.174730] ACPI =
FADT declares the system doesn't support PCIe ASPM, so disable it
> 2025-05-21T10:35:36.855494+00:00 mc-misc2002 kernel: [    3.178694] acpip=
hp: ACPI Hot Plug PCI Controller Driver version: 0.5
> 2025-05-21T10:35:36.855494+00:00 mc-misc2002 kernel: [    3.182802] PCI: =
MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0=
x80000000)
> 2025-05-21T10:35:36.855498+00:00 mc-misc2002 kernel: [    3.186696] PCI: =
MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
> 2025-05-21T10:35:36.855498+00:00 mc-misc2002 kernel: [    3.190704] pmd_s=
et_huge: Cannot satisfy [mem 0x80000000-0x80200000] with a huge-page mappin=
g due to MTRR override.
> 2025-05-21T10:35:36.855499+00:00 mc-misc2002 kernel: [    3.194991] PCI: =
Using configuration type 1 for base access
> 2025-05-21T10:35:36.855501+00:00 mc-misc2002 kernel: [    3.199823] ENERG=
Y_PERF_BIAS: Set to 'normal', was 'performance'
> 2025-05-21T10:35:36.855510+00:00 mc-misc2002 kernel: [    3.202920] kprob=
es: kprobe jump-optimization is enabled. All kprobes are optimized if possi=
ble.
> 2025-05-21T10:35:36.855510+00:00 mc-misc2002 kernel: [    3.214742] HugeT=
LB: registered 1.00 GiB page size, pre-allocated 0 pages
> 2025-05-21T10:35:36.855514+00:00 mc-misc2002 kernel: [    3.218694] HugeT=
LB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> 2025-05-21T10:35:36.855516+00:00 mc-misc2002 kernel: [    3.226693] HugeT=
LB: registered 2.00 MiB page size, pre-allocated 0 pages
> 2025-05-21T10:35:36.855516+00:00 mc-misc2002 kernel: [    3.234692] HugeT=
LB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> 2025-05-21T10:35:36.855516+00:00 mc-misc2002 kernel: [    3.242848] ACPI:=
 Added _OSI(Module Device)
> 2025-05-21T10:35:36.855517+00:00 mc-misc2002 kernel: [    3.246694] ACPI:=
 Added _OSI(Processor Device)
> 2025-05-21T10:35:36.855517+00:00 mc-misc2002 kernel: [    3.254693] ACPI:=
 Added _OSI(3.0 _SCP Extensions)
> 2025-05-21T10:35:36.855517+00:00 mc-misc2002 kernel: [    3.258693] ACPI:=
 Added _OSI(Processor Aggregator Device)
> 2025-05-21T10:35:36.855521+00:00 mc-misc2002 kernel: [    3.408431] ACPI:=
 7 ACPI AML tables successfully acquired and loaded
> 2025-05-21T10:35:36.855521+00:00 mc-misc2002 kernel: [    3.431719] ACPI:=
 Dynamic OEM Table Load:
> 2025-05-21T10:35:36.855522+00:00 mc-misc2002 kernel: [    3.568309] ACPI:=
 Dynamic OEM Table Load:
> 2025-05-21T10:35:36.855522+00:00 mc-misc2002 kernel: [    3.816116] ACPI:=
 Interpreter enabled
> 2025-05-21T10:35:36.855522+00:00 mc-misc2002 kernel: [    3.818718] ACPI:=
 PM: (supports S0 S5)
> 2025-05-21T10:35:36.855523+00:00 mc-misc2002 kernel: [    3.822693] ACPI:=
 Using IOAPIC for interrupt routing
> 2025-05-21T10:35:36.855528+00:00 mc-misc2002 kernel: [    3.826791] HEST:=
 Table parsing has been initialized.
> 2025-05-21T10:35:36.855529+00:00 mc-misc2002 kernel: [    3.834794] GHES:=
 APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
> 2025-05-21T10:35:36.855529+00:00 mc-misc2002 kernel: [    3.842695] PCI: =
Using host bridge windows from ACPI; if necessary, use "pci=3Dnocrs" and re=
port a bug
> 2025-05-21T10:35:36.855529+00:00 mc-misc2002 kernel: [    3.850693] PCI: =
Ignoring E820 reservations for host bridge windows
> 2025-05-21T10:35:36.855530+00:00 mc-misc2002 kernel: [    3.875229] ACPI:=
 Enabled 5 GPEs in block 00 to 7F
> 2025-05-21T10:35:36.855530+00:00 mc-misc2002 kernel: [    3.976255] ACPI:=
 PCI Root Bridge [PC00] (domain 0000 [bus 00-15])
> 2025-05-21T10:35:36.855533+00:00 mc-misc2002 kernel: [    3.982697] acpi =
PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:35:36.855534+00:00 mc-misc2002 kernel: [    3.991007] acpi =
PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T10:35:36.855534+00:00 mc-misc2002 kernel: [    4.002901] acpi =
PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T10:35:36.855535+00:00 mc-misc2002 kernel: [    4.010692] acpi =
PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:35:36.855535+00:00 mc-misc2002 kernel: [    4.019421] PCI h=
ost bridge to bus 0000:00
> 2025-05-21T10:35:36.855544+00:00 mc-misc2002 kernel: [    4.022693] pci_b=
us 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> 2025-05-21T10:35:36.855547+00:00 mc-misc2002 kernel: [    4.030694] pci_b=
us 0000:00: root bus resource [io  0x1000-0x4fff window]
> 2025-05-21T10:35:36.855549+00:00 mc-misc2002 kernel: [    4.038692] pci_b=
us 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> 2025-05-21T10:35:36.855549+00:00 mc-misc2002 kernel: [    4.046692] pci_b=
us 0000:00: root bus resource [mem 0x000c8000-0x000cffff window]
> 2025-05-21T10:35:36.855549+00:00 mc-misc2002 kernel: [    4.054692] pci_b=
us 0000:00: root bus resource [mem 0xfe010000-0xfe010fff window]
> 2025-05-21T10:35:36.855550+00:00 mc-misc2002 kernel: [    4.062693] pci_b=
us 0000:00: root bus resource [mem 0x90000000-0x9b7fffff window]
> 2025-05-21T10:35:36.855550+00:00 mc-misc2002 kernel: [    4.074692] pci_b=
us 0000:00: root bus resource [mem 0x200000000000-0x200fffffffff window]
> 2025-05-21T10:35:36.855550+00:00 mc-misc2002 kernel: [    4.082693] pci_b=
us 0000:00: root bus resource [bus 00-15]
> 2025-05-21T10:35:36.855554+00:00 mc-misc2002 kernel: [    4.086715] pci 0=
000:00:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:35:36.855555+00:00 mc-misc2002 kernel: [    4.094805] pci 0=
000:00:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:35:36.855555+00:00 mc-misc2002 kernel: [    4.102777] pci 0=
000:00:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:35:36.855556+00:00 mc-misc2002 kernel: [    4.106774] pci 0=
000:00:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:35:36.855556+00:00 mc-misc2002 kernel: [    4.114778] pci 0=
000:00:01.0: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.855556+00:00 mc-misc2002 kernel: [    4.122703] pci 0=
000:00:01.0: reg 0x10: [mem 0x200ffff50000-0x200ffff53fff 64bit]
> 2025-05-21T10:35:36.855560+00:00 mc-misc2002 kernel: [    4.130806] pci 0=
000:00:01.1: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.855561+00:00 mc-misc2002 kernel: [    4.138703] pci 0=
000:00:01.1: reg 0x10: [mem 0x200ffff4c000-0x200ffff4ffff 64bit]
> 2025-05-21T10:35:36.855561+00:00 mc-misc2002 kernel: [    4.146803] pci 0=
000:00:01.2: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.855561+00:00 mc-misc2002 kernel: [    4.154703] pci 0=
000:00:01.2: reg 0x10: [mem 0x200ffff48000-0x200ffff4bfff 64bit]
> 2025-05-21T10:35:36.855562+00:00 mc-misc2002 kernel: [    4.162799] pci 0=
000:00:01.3: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.855562+00:00 mc-misc2002 kernel: [    4.166703] pci 0=
000:00:01.3: reg 0x10: [mem 0x200ffff44000-0x200ffff47fff 64bit]
> 2025-05-21T10:35:36.855564+00:00 mc-misc2002 kernel: [    4.174811] pci 0=
000:00:01.4: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.855567+00:00 mc-misc2002 kernel: [    4.182703] pci 0=
000:00:01.4: reg 0x10: [mem 0x200ffff40000-0x200ffff43fff 64bit]
> 2025-05-21T10:35:36.855568+00:00 mc-misc2002 kernel: [    4.190805] pci 0=
000:00:01.5: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.855568+00:00 mc-misc2002 kernel: [    4.198703] pci 0=
000:00:01.5: reg 0x10: [mem 0x200ffff3c000-0x200ffff3ffff 64bit]
> 2025-05-21T10:35:36.855568+00:00 mc-misc2002 kernel: [    4.206798] pci 0=
000:00:01.6: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.855569+00:00 mc-misc2002 kernel: [    4.214703] pci 0=
000:00:01.6: reg 0x10: [mem 0x200ffff38000-0x200ffff3bfff 64bit]
> 2025-05-21T10:35:36.855569+00:00 mc-misc2002 kernel: [    4.222799] pci 0=
000:00:01.7: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.855573+00:00 mc-misc2002 kernel: [    4.230703] pci 0=
000:00:01.7: reg 0x10: [mem 0x200ffff34000-0x200ffff37fff 64bit]
> 2025-05-21T10:35:36.855575+00:00 mc-misc2002 kernel: [    4.238796] pci 0=
000:00:02.0: [8086:09a6] type 00 class 0x088000
> 2025-05-21T10:35:36.855575+00:00 mc-misc2002 kernel: [    4.242700] pci 0=
000:00:02.0: reg 0x10: [mem 0x9b388000-0x9b389fff]
> 2025-05-21T10:35:36.855576+00:00 mc-misc2002 kernel: [    4.250777] pci 0=
000:00:02.1: [8086:09a7] type 00 class 0x088000
> 2025-05-21T10:35:36.855576+00:00 mc-misc2002 kernel: [    4.258701] pci 0=
000:00:02.1: reg 0x10: [mem 0x9b300000-0x9b37ffff]
> 2025-05-21T10:35:36.855576+00:00 mc-misc2002 kernel: [    4.266697] pci 0=
000:00:02.1: reg 0x14: [mem 0x9b280000-0x9b2fffff]
> 2025-05-21T10:35:36.855581+00:00 mc-misc2002 kernel: [    4.270774] pci 0=
000:00:02.4: [8086:3456] type 00 class 0x130000
> 2025-05-21T10:35:36.855581+00:00 mc-misc2002 kernel: [    4.278703] pci 0=
000:00:02.4: reg 0x10: [mem 0x200fffe00000-0x200fffefffff 64bit]
> 2025-05-21T10:35:36.855582+00:00 mc-misc2002 kernel: [    4.286699] pci 0=
000:00:02.4: reg 0x18: [mem 0x200ffff30000-0x200ffff33fff 64bit]
> 2025-05-21T10:35:36.855582+00:00 mc-misc2002 kernel: [    4.294699] pci 0=
000:00:02.4: reg 0x20: [mem 0x200ffff00000-0x200ffff1ffff 64bit]
> 2025-05-21T10:35:36.855584+00:00 mc-misc2002 kernel: [    4.302784] pci 0=
000:00:11.0: [8086:a1ec] type 00 class 0xff0000
> 2025-05-21T10:35:36.855585+00:00 mc-misc2002 kernel: [    4.310694] pci 0=
000:00:11.0: device has non-compliant BARs; disabling IO/MEM decoding
> 2025-05-21T10:35:36.855585+00:00 mc-misc2002 kernel: [    4.318803] pci 0=
000:00:11.5: [8086:a1d2] type 00 class 0x010601
> 2025-05-21T10:35:36.855589+00:00 mc-misc2002 kernel: [    4.326705] pci 0=
000:00:11.5: reg 0x10: [mem 0x9b386000-0x9b387fff]
> 2025-05-21T10:35:36.855590+00:00 mc-misc2002 kernel: [    4.334699] pci 0=
000:00:11.5: reg 0x14: [mem 0x9b38b000-0x9b38b0ff]
> 2025-05-21T10:35:36.855590+00:00 mc-misc2002 kernel: [    4.342700] pci 0=
000:00:11.5: reg 0x18: [io  0x4070-0x4077]
> 2025-05-21T10:35:36.855590+00:00 mc-misc2002 kernel: [    4.346699] pci 0=
000:00:11.5: reg 0x1c: [io  0x4060-0x4063]
> 2025-05-21T10:35:36.855591+00:00 mc-misc2002 kernel: [    4.354699] pci 0=
000:00:11.5: reg 0x20: [io  0x4020-0x403f]
> 2025-05-21T10:35:36.855592+00:00 mc-misc2002 kernel: [    4.358699] pci 0=
000:00:11.5: reg 0x24: [mem 0x9b180000-0x9b1fffff]
> 2025-05-21T10:35:36.855596+00:00 mc-misc2002 kernel: [    4.366736] pci 0=
000:00:11.5: PME# supported from D3hot
> 2025-05-21T10:35:36.855601+00:00 mc-misc2002 kernel: [    4.370915] pci 0=
000:00:14.0: [8086:a1af] type 00 class 0x0c0330
> 2025-05-21T10:35:36.855602+00:00 mc-misc2002 kernel: [    4.378710] pci 0=
000:00:14.0: reg 0x10: [mem 0x200ffff20000-0x200ffff2ffff 64bit]
> 2025-05-21T10:35:36.855602+00:00 mc-misc2002 kernel: [    4.386761] pci 0=
000:00:14.0: PME# supported from D3hot D3cold
> 2025-05-21T10:35:36.855603+00:00 mc-misc2002 kernel: [    4.394926] pci 0=
000:00:14.2: [8086:a1b1] type 00 class 0x118000
> 2025-05-21T10:35:36.855603+00:00 mc-misc2002 kernel: [    4.402711] pci 0=
000:00:14.2: reg 0x10: [mem 0x200ffff57000-0x200ffff57fff 64bit]
> 2025-05-21T10:35:36.855603+00:00 mc-misc2002 kernel: [    4.410829] pci 0=
000:00:16.0: [8086:a1ba] type 00 class 0x078000
> 2025-05-21T10:35:36.855606+00:00 mc-misc2002 kernel: [    4.418716] pci 0=
000:00:16.0: reg 0x10: [mem 0x200ffff56000-0x200ffff56fff 64bit]
> 2025-05-21T10:35:36.855607+00:00 mc-misc2002 kernel: [    4.426782] pci 0=
000:00:16.0: PME# supported from D3hot
> 2025-05-21T10:35:36.855607+00:00 mc-misc2002 kernel: [    4.430765] pci 0=
000:00:16.1: [8086:a1bb] type 00 class 0x078000
> 2025-05-21T10:35:36.855608+00:00 mc-misc2002 kernel: [    4.438716] pci 0=
000:00:16.1: reg 0x10: [mem 0x200ffff55000-0x200ffff55fff 64bit]
> 2025-05-21T10:35:36.855608+00:00 mc-misc2002 kernel: [    4.446782] pci 0=
000:00:16.1: PME# supported from D3hot
> 2025-05-21T10:35:36.855608+00:00 mc-misc2002 kernel: [    4.450768] pci 0=
000:00:16.4: [8086:a1be] type 00 class 0x078000
> 2025-05-21T10:35:36.855611+00:00 mc-misc2002 kernel: [    4.458716] pci 0=
000:00:16.4: reg 0x10: [mem 0x200ffff54000-0x200ffff54fff 64bit]
> 2025-05-21T10:35:36.855612+00:00 mc-misc2002 kernel: [    4.466783] pci 0=
000:00:16.4: PME# supported from D3hot
> 2025-05-21T10:35:36.855613+00:00 mc-misc2002 kernel: [    4.474766] pci 0=
000:00:17.0: [8086:a182] type 00 class 0x010601
> 2025-05-21T10:35:36.855613+00:00 mc-misc2002 kernel: [    4.478705] pci 0=
000:00:17.0: reg 0x10: [mem 0x9b384000-0x9b385fff]
> 2025-05-21T10:35:36.855613+00:00 mc-misc2002 kernel: [    4.486699] pci 0=
000:00:17.0: reg 0x14: [mem 0x9b38a000-0x9b38a0ff]
> 2025-05-21T10:35:36.855613+00:00 mc-misc2002 kernel: [    4.494699] pci 0=
000:00:17.0: reg 0x18: [io  0x4050-0x4057]
> 2025-05-21T10:35:36.855616+00:00 mc-misc2002 kernel: [    4.502699] pci 0=
000:00:17.0: reg 0x1c: [io  0x4040-0x4043]
> 2025-05-21T10:35:36.855619+00:00 mc-misc2002 kernel: [    4.506699] pci 0=
000:00:17.0: reg 0x20: [io  0x4000-0x401f]
> 2025-05-21T10:35:36.855619+00:00 mc-misc2002 kernel: [    4.514699] pci 0=
000:00:17.0: reg 0x24: [mem 0x9b100000-0x9b17ffff]
> 2025-05-21T10:35:36.855620+00:00 mc-misc2002 kernel: [    4.518736] pci 0=
000:00:17.0: PME# supported from D3hot
> 2025-05-21T10:35:36.855620+00:00 mc-misc2002 kernel: [    4.526902] pci 0=
000:00:1c.0: [8086:a190] type 01 class 0x060400
> 2025-05-21T10:35:36.855621+00:00 mc-misc2002 kernel: [    4.534771] pci 0=
000:00:1c.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.855621+00:00 mc-misc2002 kernel: [    4.538780] pci 0=
000:00:1c.4: [8086:a194] type 01 class 0x060400
> 2025-05-21T10:35:36.855624+00:00 mc-misc2002 kernel: [    4.546772] pci 0=
000:00:1c.4: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.855625+00:00 mc-misc2002 kernel: [    4.554796] pci 0=
000:00:1c.5: [8086:a195] type 01 class 0x060400
> 2025-05-21T10:35:36.855625+00:00 mc-misc2002 kernel: [    4.558771] pci 0=
000:00:1c.5: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.855625+00:00 mc-misc2002 kernel: [    4.566795] pci 0=
000:00:1f.0: [8086:a1cb] type 00 class 0x060100
> 2025-05-21T10:35:36.855626+00:00 mc-misc2002 kernel: [    4.574954] pci 0=
000:00:1f.2: [8086:a1a1] type 00 class 0x058000
> 2025-05-21T10:35:36.855626+00:00 mc-misc2002 kernel: [    4.582707] pci 0=
000:00:1f.2: reg 0x10: [mem 0x9b380000-0x9b383fff]
> 2025-05-21T10:35:36.855629+00:00 mc-misc2002 kernel: [    4.586921] pci 0=
000:00:1f.4: [8086:a1a3] type 00 class 0x0c0500
> 2025-05-21T10:35:36.855630+00:00 mc-misc2002 kernel: [    4.594712] pci 0=
000:00:1f.4: reg 0x10: [mem 0x00000000-0x000000ff 64bit]
> 2025-05-21T10:35:36.855630+00:00 mc-misc2002 kernel: [    4.602716] pci 0=
000:00:1f.4: reg 0x20: [io  0x0780-0x079f]
> 2025-05-21T10:35:36.855630+00:00 mc-misc2002 kernel: [    4.610764] pci 0=
000:00:1f.5: [8086:a1a4] type 00 class 0x0c8000
> 2025-05-21T10:35:36.855631+00:00 mc-misc2002 kernel: [    4.614708] pci 0=
000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
> 2025-05-21T10:35:36.855631+00:00 mc-misc2002 kernel: [    4.622836] pci 0=
000:00:1c.0: PCI bridge to [bus 01]
> 2025-05-21T10:35:36.855631+00:00 mc-misc2002 kernel: [    4.630737] pci 0=
000:00:1c.4: PCI bridge to [bus 02]
> 2025-05-21T10:35:36.855634+00:00 mc-misc2002 kernel: [    4.634758] pci 0=
000:03:00.0: [1a03:1150] type 01 class 0x060400
> 2025-05-21T10:35:36.855635+00:00 mc-misc2002 kernel: [    4.642751] pci 0=
000:03:00.0: enabling Extended Tags
> 2025-05-21T10:35:36.855635+00:00 mc-misc2002 kernel: [    4.646769] pci 0=
000:03:00.0: supports D1 D2
> 2025-05-21T10:35:36.855636+00:00 mc-misc2002 kernel: [    4.650692] pci 0=
000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> 2025-05-21T10:35:36.855636+00:00 mc-misc2002 kernel: [    4.658829] pci 0=
000:00:1c.5: PCI bridge to [bus 03-04]
> 2025-05-21T10:35:36.855636+00:00 mc-misc2002 kernel: [    4.666694] pci 0=
000:00:1c.5:   bridge window [io  0x3000-0x3fff]
> 2025-05-21T10:35:36.855641+00:00 mc-misc2002 kernel: [    4.670694] pci 0=
000:00:1c.5:   bridge window [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T10:35:36.855642+00:00 mc-misc2002 kernel: [    4.678735] pci_b=
us 0000:04: extended config space not accessible
> 2025-05-21T10:35:36.855643+00:00 mc-misc2002 kernel: [    4.686718] pci 0=
000:04:00.0: [1a03:2000] type 00 class 0x030000
> 2025-05-21T10:35:36.855643+00:00 mc-misc2002 kernel: [    4.694711] pci 0=
000:04:00.0: reg 0x10: [mem 0x9a000000-0x9affffff]
> 2025-05-21T10:35:36.855643+00:00 mc-misc2002 kernel: [    4.698703] pci 0=
000:04:00.0: reg 0x14: [mem 0x9b000000-0x9b03ffff]
> 2025-05-21T10:35:36.855644+00:00 mc-misc2002 kernel: [    4.706703] pci 0=
000:04:00.0: reg 0x18: [io  0x3000-0x307f]
> 2025-05-21T10:35:36.855647+00:00 mc-misc2002 kernel: [    4.714775] pci 0=
000:04:00.0: supports D1 D2
> 2025-05-21T10:35:36.855648+00:00 mc-misc2002 kernel: [    4.718696] pci 0=
000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> 2025-05-21T10:35:36.855648+00:00 mc-misc2002 kernel: [    4.726805] pci 0=
000:03:00.0: PCI bridge to [bus 04]
> 2025-05-21T10:35:36.855648+00:00 mc-misc2002 kernel: [    4.730698] pci 0=
000:03:00.0:   bridge window [io  0x3000-0x3fff]
> 2025-05-21T10:35:36.855650+00:00 mc-misc2002 kernel: [    4.738695] pci 0=
000:03:00.0:   bridge window [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T10:35:36.855657+00:00 mc-misc2002 kernel: [    4.746719] pci_b=
us 0000:00: on NUMA node 0
> 2025-05-21T10:35:36.855659+00:00 mc-misc2002 kernel: [    4.747430] ACPI:=
 PCI Root Bridge [PC01] (domain 0000 [bus 16-2f])
> 2025-05-21T10:35:36.855662+00:00 mc-misc2002 kernel: [    4.754695] acpi =
PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:35:36.855663+00:00 mc-misc2002 kernel: [    4.763300] acpi =
PNP0A08:01: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:35:36.855664+00:00 mc-misc2002 kernel: [    4.770949] acpi =
PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:35:36.855664+00:00 mc-misc2002 kernel: [    4.782692] acpi =
PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:35:36.855664+00:00 mc-misc2002 kernel: [    4.790822] PCI h=
ost bridge to bus 0000:16
> 2025-05-21T10:35:36.855665+00:00 mc-misc2002 kernel: [    4.794693] pci_b=
us 0000:16: root bus resource [io  0x5000-0x6fff window]
> 2025-05-21T10:35:36.855671+00:00 mc-misc2002 kernel: [    4.802692] pci_b=
us 0000:16: root bus resource [mem 0x9b800000-0xa63fffff window]
> 2025-05-21T10:35:36.855672+00:00 mc-misc2002 kernel: [    4.810692] pci_b=
us 0000:16: root bus resource [mem 0x201000000000-0x201fffffffff window]
> 2025-05-21T10:35:36.855672+00:00 mc-misc2002 kernel: [    4.822693] pci_b=
us 0000:16: root bus resource [bus 16-2f]
> 2025-05-21T10:35:36.855673+00:00 mc-misc2002 kernel: [    4.826703] pci 0=
000:16:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:35:36.855673+00:00 mc-misc2002 kernel: [    4.834773] pci 0=
000:16:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:35:36.855673+00:00 mc-misc2002 kernel: [    4.838766] pci 0=
000:16:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:35:36.855676+00:00 mc-misc2002 kernel: [    4.846767] pci 0=
000:16:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:35:36.855678+00:00 mc-misc2002 kernel: [    4.854777] pci_b=
us 0000:16: on NUMA node 0
> 2025-05-21T10:35:36.855680+00:00 mc-misc2002 kernel: [    4.854867] ACPI:=
 PCI Root Bridge [PC02] (domain 0000 [bus 30-49])
> 2025-05-21T10:35:36.855688+00:00 mc-misc2002 kernel: [    4.862694] acpi =
PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:35:36.855689+00:00 mc-misc2002 kernel: [    4.871467] acpi =
PNP0A08:02: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:35:36.855689+00:00 mc-misc2002 kernel: [    4.878946] acpi =
PNP0A08:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:35:36.855689+00:00 mc-misc2002 kernel: [    4.890693] acpi =
PNP0A08:02: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:35:36.855699+00:00 mc-misc2002 kernel: [    4.898814] PCI h=
ost bridge to bus 0000:30
> 2025-05-21T10:35:36.855700+00:00 mc-misc2002 kernel: [    4.902693] pci_b=
us 0000:30: root bus resource [io  0x7000-0x8fff window]
> 2025-05-21T10:35:36.855700+00:00 mc-misc2002 kernel: [    4.910692] pci_b=
us 0000:30: root bus resource [mem 0xa6400000-0xb0ffffff window]
> 2025-05-21T10:35:36.855701+00:00 mc-misc2002 kernel: [    4.918693] pci_b=
us 0000:30: root bus resource [mem 0x202000000000-0x202fffffffff window]
> 2025-05-21T10:35:36.855701+00:00 mc-misc2002 kernel: [    4.930692] pci_b=
us 0000:30: root bus resource [bus 30-49]
> 2025-05-21T10:35:36.855701+00:00 mc-misc2002 kernel: [    4.934702] pci 0=
000:30:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:35:36.855706+00:00 mc-misc2002 kernel: [    4.942768] pci 0=
000:30:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:35:36.855706+00:00 mc-misc2002 kernel: [    4.946764] pci 0=
000:30:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:35:36.855706+00:00 mc-misc2002 kernel: [    4.954765] pci 0=
000:30:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:35:36.855707+00:00 mc-misc2002 kernel: [    4.962785] pci_b=
us 0000:30: on NUMA node 0
> 2025-05-21T10:35:36.855707+00:00 mc-misc2002 kernel: [    4.962892] ACPI:=
 PCI Root Bridge [PC04] (domain 0000 [bus 4a-63])
> 2025-05-21T10:35:36.855707+00:00 mc-misc2002 kernel: [    4.970694] acpi =
PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:35:36.855712+00:00 mc-misc2002 kernel: [    4.979638] acpi =
PNP0A08:04: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:35:36.855713+00:00 mc-misc2002 kernel: [    4.986952] acpi =
PNP0A08:04: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:35:36.855713+00:00 mc-misc2002 kernel: [    4.998693] acpi =
PNP0A08:04: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:35:36.855714+00:00 mc-misc2002 kernel: [    5.006809] PCI h=
ost bridge to bus 0000:4a
> 2025-05-21T10:35:36.855714+00:00 mc-misc2002 kernel: [    5.010693] pci_b=
us 0000:4a: root bus resource [io  0x9000-0x9fff window]
> 2025-05-21T10:35:36.855723+00:00 mc-misc2002 kernel: [    5.018692] pci_b=
us 0000:4a: root bus resource [mem 0xb1000000-0xbbbfffff window]
> 2025-05-21T10:35:36.855730+00:00 mc-misc2002 kernel: [    5.026694] pci_b=
us 0000:4a: root bus resource [mem 0x203000000000-0x203fffffffff window]
> 2025-05-21T10:35:36.855736+00:00 mc-misc2002 kernel: [    5.034692] pci_b=
us 0000:4a: root bus resource [bus 4a-63]
> 2025-05-21T10:35:36.855738+00:00 mc-misc2002 kernel: [    5.042703] pci 0=
000:4a:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:35:36.855739+00:00 mc-misc2002 kernel: [    5.050768] pci 0=
000:4a:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:35:36.855739+00:00 mc-misc2002 kernel: [    5.054766] pci 0=
000:4a:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:35:36.855740+00:00 mc-misc2002 kernel: [    5.062766] pci 0=
000:4a:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:35:36.855740+00:00 mc-misc2002 kernel: [    5.070774] pci 0=
000:4a:05.0: [8086:347d] type 01 class 0x060400
> 2025-05-21T10:35:36.855745+00:00 mc-misc2002 kernel: [    5.078702] pci 0=
000:4a:05.0: reg 0x10: [mem 0x203ffff00000-0x203ffff1ffff 64bit]
> 2025-05-21T10:35:36.855745+00:00 mc-misc2002 kernel: [    5.086706] pci 0=
000:4a:05.0: enabling Extended Tags
> 2025-05-21T10:35:36.855745+00:00 mc-misc2002 kernel: [    5.090727] pci 0=
000:4a:05.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.855746+00:00 mc-misc2002 kernel: [    5.099103] pci 0=
000:4b:00.0: [8086:1521] type 00 class 0x020000
> 2025-05-21T10:35:36.855746+00:00 mc-misc2002 kernel: [    5.106707] pci 0=
000:4b:00.0: reg 0x10: [mem 0xbba20000-0xbba3ffff]
> 2025-05-21T10:35:36.855747+00:00 mc-misc2002 kernel: [    5.110709] pci 0=
000:4b:00.0: reg 0x18: [io  0x9020-0x903f]
> 2025-05-21T10:35:36.855747+00:00 mc-misc2002 kernel: [    5.118699] pci 0=
000:4b:00.0: reg 0x1c: [mem 0xbba44000-0xbba47fff]
> 2025-05-21T10:35:36.855751+00:00 mc-misc2002 kernel: [    5.126771] pci 0=
000:4b:00.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.855752+00:00 mc-misc2002 kernel: [    5.130722] pci 0=
000:4b:00.0: reg 0x184: [mem 0x203fffe60000-0x203fffe63fff 64bit pref]
> 2025-05-21T10:35:36.855752+00:00 mc-misc2002 kernel: [    5.142693] pci 0=
000:4b:00.0: VF(n) BAR0 space: [mem 0x203fffe60000-0x203fffe7ffff 64bit pre=
f] (contains BAR0 for 8 VFs)
> 2025-05-21T10:35:36.855759+00:00 mc-misc2002 kernel: [    5.154707] pci 0=
000:4b:00.0: reg 0x190: [mem 0x203fffe40000-0x203fffe43fff 64bit pref]
> 2025-05-21T10:35:36.855760+00:00 mc-misc2002 kernel: [    5.162692] pci 0=
000:4b:00.0: VF(n) BAR3 space: [mem 0x203fffe40000-0x203fffe5ffff 64bit pre=
f] (contains BAR3 for 8 VFs)
> 2025-05-21T10:35:36.855763+00:00 mc-misc2002 kernel: [    5.174885] pci 0=
000:4b:00.1: [8086:1521] type 00 class 0x020000
> 2025-05-21T10:35:36.855771+00:00 mc-misc2002 kernel: [    5.182705] pci 0=
000:4b:00.1: reg 0x10: [mem 0xbba00000-0xbba1ffff]
> 2025-05-21T10:35:36.855772+00:00 mc-misc2002 kernel: [    5.186706] pci 0=
000:4b:00.1: reg 0x18: [io  0x9000-0x901f]
> 2025-05-21T10:35:36.855772+00:00 mc-misc2002 kernel: [    5.194699] pci 0=
000:4b:00.1: reg 0x1c: [mem 0xbba40000-0xbba43fff]
> 2025-05-21T10:35:36.855773+00:00 mc-misc2002 kernel: [    5.202784] pci 0=
000:4b:00.1: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.855773+00:00 mc-misc2002 kernel: [    5.210717] pci 0=
000:4b:00.1: reg 0x184: [mem 0x203fffe20000-0x203fffe23fff 64bit pref]
> 2025-05-21T10:35:36.855773+00:00 mc-misc2002 kernel: [    5.218693] pci 0=
000:4b:00.1: VF(n) BAR0 space: [mem 0x203fffe20000-0x203fffe3ffff 64bit pre=
f] (contains BAR0 for 8 VFs)
> 2025-05-21T10:35:36.855782+00:00 mc-misc2002 kernel: [    5.230706] pci 0=
000:4b:00.1: reg 0x190: [mem 0x203fffe00000-0x203fffe03fff 64bit pref]
> 2025-05-21T10:35:36.855783+00:00 mc-misc2002 kernel: [    5.238692] pci 0=
000:4b:00.1: VF(n) BAR3 space: [mem 0x203fffe00000-0x203fffe1ffff 64bit pre=
f] (contains BAR3 for 8 VFs)
> 2025-05-21T10:35:36.855783+00:00 mc-misc2002 kernel: [    5.250829] pci 0=
000:4a:05.0: PCI bridge to [bus 4b]
> 2025-05-21T10:35:36.855783+00:00 mc-misc2002 kernel: [    5.258693] pci 0=
000:4a:05.0:   bridge window [io  0x9000-0x9fff]
> 2025-05-21T10:35:36.855784+00:00 mc-misc2002 kernel: [    5.262693] pci 0=
000:4a:05.0:   bridge window [mem 0xbba00000-0xbbafffff]
> 2025-05-21T10:35:36.855784+00:00 mc-misc2002 kernel: [    5.270694] pci 0=
000:4a:05.0:   bridge window [mem 0x203fffe00000-0x203fffefffff 64bit pref]
> 2025-05-21T10:35:36.855791+00:00 mc-misc2002 kernel: [    5.282699] pci_b=
us 0000:4a: on NUMA node 0
> 2025-05-21T10:35:36.855792+00:00 mc-misc2002 kernel: [    5.282804] ACPI:=
 PCI Root Bridge [PC05] (domain 0000 [bus 64-7d])
> 2025-05-21T10:35:36.855792+00:00 mc-misc2002 kernel: [    5.286694] acpi =
PNP0A08:05: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:35:36.855794+00:00 mc-misc2002 kernel: [    5.300109] acpi =
PNP0A08:05: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:35:36.855801+00:00 mc-misc2002 kernel: [    5.307176] acpi =
PNP0A08:05: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:35:36.855801+00:00 mc-misc2002 kernel: [    5.318693] acpi =
PNP0A08:05: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:35:36.855806+00:00 mc-misc2002 kernel: [    5.326822] PCI h=
ost bridge to bus 0000:64
> 2025-05-21T10:35:36.855807+00:00 mc-misc2002 kernel: [    5.330693] pci_b=
us 0000:64: root bus resource [io  0xa000-0xafff window]
> 2025-05-21T10:35:36.855815+00:00 mc-misc2002 kernel: [    5.338692] pci_b=
us 0000:64: root bus resource [mem 0xbbc00000-0xc5ffffff window]
> 2025-05-21T10:35:36.855815+00:00 mc-misc2002 kernel: [    5.346694] pci_b=
us 0000:64: root bus resource [mem 0x204000000000-0x204fffffffff window]
> 2025-05-21T10:35:36.855816+00:00 mc-misc2002 kernel: [    5.354692] pci_b=
us 0000:64: root bus resource [bus 64-7d]
> 2025-05-21T10:35:36.855816+00:00 mc-misc2002 kernel: [    5.362703] pci 0=
000:64:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:35:36.855836+00:00 mc-misc2002 kernel: [    5.370774] pci 0=
000:64:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:35:36.855837+00:00 mc-misc2002 kernel: [    5.374767] pci 0=
000:64:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:35:36.855837+00:00 mc-misc2002 kernel: [    5.382767] pci 0=
000:64:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:35:36.855838+00:00 mc-misc2002 kernel: [    5.390782] pci 0=
000:64:02.0: [8086:347a] type 01 class 0x060400
> 2025-05-21T10:35:36.855839+00:00 mc-misc2002 kernel: [    5.394702] pci 0=
000:64:02.0: reg 0x10: [mem 0x204ffff60000-0x204ffff7ffff 64bit]
> 2025-05-21T10:35:36.855846+00:00 mc-misc2002 kernel: [    5.402740] pci 0=
000:64:02.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.855853+00:00 mc-misc2002 kernel: [    5.410951] pci 0=
000:64:03.0: [8086:347b] type 01 class 0x060400
> 2025-05-21T10:35:36.855862+00:00 mc-misc2002 kernel: [    5.418703] pci 0=
000:64:03.0: reg 0x10: [mem 0x204ffff40000-0x204ffff5ffff 64bit]
> 2025-05-21T10:35:36.855863+00:00 mc-misc2002 kernel: [    5.426705] pci 0=
000:64:03.0: enabling Extended Tags
> 2025-05-21T10:35:36.855870+00:00 mc-misc2002 kernel: [    5.430729] pci 0=
000:64:03.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.855871+00:00 mc-misc2002 kernel: [    5.438938] pci 0=
000:64:04.0: [8086:347c] type 01 class 0x060400
> 2025-05-21T10:35:36.855871+00:00 mc-misc2002 kernel: [    5.446708] pci 0=
000:64:04.0: reg 0x10: [mem 0x204ffff20000-0x204ffff3ffff 64bit]
> 2025-05-21T10:35:36.855871+00:00 mc-misc2002 kernel: [    5.454706] pci 0=
000:64:04.0: enabling Extended Tags
> 2025-05-21T10:35:36.855876+00:00 mc-misc2002 kernel: [    5.458730] pci 0=
000:64:04.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.855877+00:00 mc-misc2002 kernel: [    5.466945] pci 0=
000:64:05.0: [8086:347d] type 01 class 0x060400
> 2025-05-21T10:35:36.855877+00:00 mc-misc2002 kernel: [    5.474703] pci 0=
000:64:05.0: reg 0x10: [mem 0x204ffff00000-0x204ffff1ffff 64bit]
> 2025-05-21T10:35:36.855878+00:00 mc-misc2002 kernel: [    5.482705] pci 0=
000:64:05.0: enabling Extended Tags
> 2025-05-21T10:35:36.855878+00:00 mc-misc2002 kernel: [    5.486729] pci 0=
000:64:05.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.855878+00:00 mc-misc2002 kernel: [    5.495079] pci 0=
000:65:00.0: [1344:51c4] type 00 class 0x010802
> 2025-05-21T10:35:36.855878+00:00 mc-misc2002 kernel: [    5.502705] pci 0=
000:65:00.0: reg 0x10: [mem 0xc5e40000-0xc5e7ffff 64bit]
> 2025-05-21T10:35:36.855885+00:00 mc-misc2002 kernel: [    5.510719] pci 0=
000:65:00.0: reg 0x30: [mem 0xc5e00000-0xc5e3ffff pref]
> 2025-05-21T10:35:36.855886+00:00 mc-misc2002 kernel: [    5.518745] pci 0=
000:65:00.0: PME# supported from D0 D1 D3hot
> 2025-05-21T10:35:36.855886+00:00 mc-misc2002 kernel: [    5.522794] pci 0=
000:64:02.0: PCI bridge to [bus 65]
> 2025-05-21T10:35:36.855887+00:00 mc-misc2002 kernel: [    5.530695] pci 0=
000:64:02.0:   bridge window [mem 0xc5e00000-0xc5efffff]
> 2025-05-21T10:35:36.855891+00:00 mc-misc2002 kernel: [    5.538823] pci 0=
000:64:03.0: PCI bridge to [bus 66]
> 2025-05-21T10:35:36.855892+00:00 mc-misc2002 kernel: [    5.542695] pci 0=
000:64:03.0:   bridge window [mem 0xc5d00000-0xc5dfffff]
> 2025-05-21T10:35:36.855895+00:00 mc-misc2002 kernel: [    5.550820] pci 0=
000:64:04.0: PCI bridge to [bus 67]
> 2025-05-21T10:35:36.855895+00:00 mc-misc2002 kernel: [    5.554694] pci 0=
000:64:04.0:   bridge window [mem 0xc5c00000-0xc5cfffff]
> 2025-05-21T10:35:36.855896+00:00 mc-misc2002 kernel: [    5.562820] pci 0=
000:64:05.0: PCI bridge to [bus 68]
> 2025-05-21T10:35:36.855896+00:00 mc-misc2002 kernel: [    5.570695] pci 0=
000:64:05.0:   bridge window [mem 0xc5b00000-0xc5bfffff]
> 2025-05-21T10:35:36.855896+00:00 mc-misc2002 kernel: [    5.578712] pci_b=
us 0000:64: on NUMA node 0
> 2025-05-21T10:35:36.855897+00:00 mc-misc2002 kernel: [    5.578809] ACPI:=
 PCI Root Bridge [UC06] (domain 0000 [bus 7e])
> 2025-05-21T10:35:36.855900+00:00 mc-misc2002 kernel: [    5.582694] acpi =
PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:35:36.855901+00:00 mc-misc2002 kernel: [    5.594763] acpi =
PNP0A08:06: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T10:35:36.855901+00:00 mc-misc2002 kernel: [    5.602814] acpi =
PNP0A08:06: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T10:35:36.855902+00:00 mc-misc2002 kernel: [    5.610693] acpi =
PNP0A08:06: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:35:36.855902+00:00 mc-misc2002 kernel: [    5.618804] PCI h=
ost bridge to bus 0000:7e
> 2025-05-21T10:35:36.855902+00:00 mc-misc2002 kernel: [    5.626693] pci_b=
us 0000:7e: root bus resource [bus 7e]
> 2025-05-21T10:35:36.855903+00:00 mc-misc2002 kernel: [    5.630703] pci 0=
000:7e:00.0: [8086:3450] type 00 class 0x088000
> 2025-05-21T10:35:36.855906+00:00 mc-misc2002 kernel: [    5.638776] pci 0=
000:7e:00.1: [8086:3451] type 00 class 0x088000
> 2025-05-21T10:35:36.855906+00:00 mc-misc2002 kernel: [    5.642758] pci 0=
000:7e:00.2: [8086:3452] type 00 class 0x088000
> 2025-05-21T10:35:36.855907+00:00 mc-misc2002 kernel: [    5.650757] pci 0=
000:7e:00.3: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:35:36.855909+00:00 mc-misc2002 kernel: [    5.658758] pci 0=
000:7e:00.5: [8086:3455] type 00 class 0x088000
> 2025-05-21T10:35:36.855909+00:00 mc-misc2002 kernel: [    5.666766] pci 0=
000:7e:02.0: [8086:3440] type 00 class 0x088000
> 2025-05-21T10:35:36.855910+00:00 mc-misc2002 kernel: [    5.670837] pci 0=
000:7e:02.1: [8086:3441] type 00 class 0x088000
> 2025-05-21T10:35:36.855919+00:00 mc-misc2002 kernel: [    5.678816] pci 0=
000:7e:02.2: [8086:3442] type 00 class 0x088000
> 2025-05-21T10:35:36.855920+00:00 mc-misc2002 kernel: [    5.686824] pci 0=
000:7e:04.0: [8086:3440] type 00 class 0x088000
> 2025-05-21T10:35:36.855920+00:00 mc-misc2002 kernel: [    5.690826] pci 0=
000:7e:04.1: [8086:3441] type 00 class 0x088000
> 2025-05-21T10:35:36.855921+00:00 mc-misc2002 kernel: [    5.698823] pci 0=
000:7e:04.2: [8086:3442] type 00 class 0x088000
> 2025-05-21T10:35:36.855921+00:00 mc-misc2002 kernel: [    5.706822] pci 0=
000:7e:04.3: [8086:3443] type 00 class 0x088000
> 2025-05-21T10:35:36.855921+00:00 mc-misc2002 kernel: [    5.714826] pci 0=
000:7e:05.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T10:35:36.855923+00:00 mc-misc2002 kernel: [    5.718833] pci 0=
000:7e:05.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T10:35:36.855926+00:00 mc-misc2002 kernel: [    5.726819] pci 0=
000:7e:05.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T10:35:36.855934+00:00 mc-misc2002 kernel: [    5.734820] pci 0=
000:7e:06.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T10:35:36.855935+00:00 mc-misc2002 kernel: [    5.738801] pci 0=
000:7e:06.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T10:35:36.855935+00:00 mc-misc2002 kernel: [    5.746789] pci 0=
000:7e:06.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T10:35:36.855935+00:00 mc-misc2002 kernel: [    5.754792] pci 0=
000:7e:07.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T10:35:36.855936+00:00 mc-misc2002 kernel: [    5.762842] pci 0=
000:7e:07.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T10:35:36.855941+00:00 mc-misc2002 kernel: [    5.766827] pci 0=
000:7e:07.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T10:35:36.855944+00:00 mc-misc2002 kernel: [    5.774824] pci 0=
000:7e:0b.0: [8086:3448] type 00 class 0x088000
> 2025-05-21T10:35:36.855945+00:00 mc-misc2002 kernel: [    5.782775] pci 0=
000:7e:0b.1: [8086:3448] type 00 class 0x088000
> 2025-05-21T10:35:36.855945+00:00 mc-misc2002 kernel: [    5.786764] pci 0=
000:7e:0b.2: [8086:344b] type 00 class 0x088000
> 2025-05-21T10:35:36.855945+00:00 mc-misc2002 kernel: [    5.794775] pci 0=
000:7e:0c.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:35:36.855946+00:00 mc-misc2002 kernel: [    5.802809] pci 0=
000:7e:0d.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:35:36.855949+00:00 mc-misc2002 kernel: [    5.810801] pci 0=
000:7e:0e.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:35:36.855949+00:00 mc-misc2002 kernel: [    5.814842] pci 0=
000:7e:0f.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:35:36.855950+00:00 mc-misc2002 kernel: [    5.822855] pci 0=
000:7e:1a.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:35:36.855950+00:00 mc-misc2002 kernel: [    5.830806] pci 0=
000:7e:1b.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:35:36.855950+00:00 mc-misc2002 kernel: [    5.834808] pci 0=
000:7e:1c.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:35:36.855951+00:00 mc-misc2002 kernel: [    5.842849] pci 0=
000:7e:1d.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:35:36.855951+00:00 mc-misc2002 kernel: [    5.850851] pci_b=
us 0000:7e: on NUMA node 0
> 2025-05-21T10:35:36.855958+00:00 mc-misc2002 kernel: [    5.850921] ACPI:=
 PCI Root Bridge [UC07] (domain 0000 [bus 7f])
> 2025-05-21T10:35:36.855958+00:00 mc-misc2002 kernel: [    5.858694] acpi =
PNP0A08:07: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:35:36.855959+00:00 mc-misc2002 kernel: [    5.866762] acpi =
PNP0A08:07: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T10:35:36.855959+00:00 mc-misc2002 kernel: [    5.874813] acpi =
PNP0A08:07: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T10:35:36.855960+00:00 mc-misc2002 kernel: [    5.882692] acpi =
PNP0A08:07: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:35:36.855960+00:00 mc-misc2002 kernel: [    5.894813] PCI h=
ost bridge to bus 0000:7f
> 2025-05-21T10:35:36.855967+00:00 mc-misc2002 kernel: [    5.898693] pci_b=
us 0000:7f: root bus resource [bus 7f]
> 2025-05-21T10:35:36.855968+00:00 mc-misc2002 kernel: [    5.902708] pci 0=
000:7f:00.0: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.855968+00:00 mc-misc2002 kernel: [    5.910818] pci 0=
000:7f:00.1: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.855969+00:00 mc-misc2002 kernel: [    5.918815] pci 0=
000:7f:00.2: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.855970+00:00 mc-misc2002 kernel: [    5.922798] pci 0=
000:7f:00.3: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.855974+00:00 mc-misc2002 kernel: [    5.930823] pci 0=
000:7f:00.4: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.855977+00:00 mc-misc2002 kernel: [    5.938823] pci 0=
000:7f:00.5: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.855977+00:00 mc-misc2002 kernel: [    5.946814] pci 0=
000:7f:00.6: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.855977+00:00 mc-misc2002 kernel: [    5.950823] pci 0=
000:7f:00.7: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.855978+00:00 mc-misc2002 kernel: [    5.958834] pci 0=
000:7f:01.0: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.855986+00:00 mc-misc2002 kernel: [    5.966843] pci 0=
000:7f:01.1: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.855987+00:00 mc-misc2002 kernel: [    5.970833] pci 0=
000:7f:01.2: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.855988+00:00 mc-misc2002 kernel: [    5.978844] pci 0=
000:7f:01.3: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.856001+00:00 mc-misc2002 kernel: [    5.986853] pci 0=
000:7f:0a.0: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856002+00:00 mc-misc2002 kernel: [    5.994818] pci 0=
000:7f:0a.1: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856002+00:00 mc-misc2002 kernel: [    5.998815] pci 0=
000:7f:0a.2: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856002+00:00 mc-misc2002 kernel: [    6.006798] pci 0=
000:7f:0a.3: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856003+00:00 mc-misc2002 kernel: [    6.014828] pci 0=
000:7f:0a.4: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856003+00:00 mc-misc2002 kernel: [    6.022822] pci 0=
000:7f:0a.5: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856014+00:00 mc-misc2002 kernel: [    6.026786] pci 0=
000:7f:0a.6: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856015+00:00 mc-misc2002 kernel: [    6.034824] pci 0=
000:7f:0a.7: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856017+00:00 mc-misc2002 kernel: [    6.042830] pci 0=
000:7f:0b.0: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856018+00:00 mc-misc2002 kernel: [    6.046843] pci 0=
000:7f:0b.1: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856018+00:00 mc-misc2002 kernel: [    6.054835] pci 0=
000:7f:0b.2: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856019+00:00 mc-misc2002 kernel: [    6.062843] pci 0=
000:7f:0b.3: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856019+00:00 mc-misc2002 kernel: [    6.070865] pci 0=
000:7f:1d.0: [8086:344f] type 00 class 0x088000
> 2025-05-21T10:35:36.856022+00:00 mc-misc2002 kernel: [    6.074825] pci 0=
000:7f:1d.1: [8086:3457] type 00 class 0x088000
> 2025-05-21T10:35:36.856023+00:00 mc-misc2002 kernel: [    6.082815] pci 0=
000:7f:1e.0: [8086:3458] type 00 class 0x088000
> 2025-05-21T10:35:36.856024+00:00 mc-misc2002 kernel: [    6.090777] pci 0=
000:7f:1e.1: [8086:3459] type 00 class 0x088000
> 2025-05-21T10:35:36.856024+00:00 mc-misc2002 kernel: [    6.094760] pci 0=
000:7f:1e.2: [8086:345a] type 00 class 0x088000
> 2025-05-21T10:35:36.856030+00:00 mc-misc2002 kernel: [    6.102760] pci 0=
000:7f:1e.3: [8086:345b] type 00 class 0x088000
> 2025-05-21T10:35:36.856037+00:00 mc-misc2002 kernel: [    6.110763] pci 0=
000:7f:1e.4: [8086:345c] type 00 class 0x088000
> 2025-05-21T10:35:36.856043+00:00 mc-misc2002 kernel: [    6.118759] pci 0=
000:7f:1e.5: [8086:345d] type 00 class 0x088000
> 2025-05-21T10:35:36.856043+00:00 mc-misc2002 kernel: [    6.122764] pci 0=
000:7f:1e.6: [8086:345e] type 00 class 0x088000
> 2025-05-21T10:35:36.856044+00:00 mc-misc2002 kernel: [    6.130759] pci 0=
000:7f:1e.7: [8086:345f] type 00 class 0x088000
> 2025-05-21T10:35:36.856044+00:00 mc-misc2002 kernel: [    6.138756] pci_b=
us 0000:7f: on NUMA node 0
> 2025-05-21T10:35:36.856044+00:00 mc-misc2002 kernel: [    6.138835] ACPI:=
 PCI Root Bridge [PC06] (domain 0000 [bus 80-96])
> 2025-05-21T10:35:36.856045+00:00 mc-misc2002 kernel: [    6.142694] acpi =
PNP0A08:08: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:35:36.856049+00:00 mc-misc2002 kernel: [    6.155258] acpi =
PNP0A08:08: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:35:36.856050+00:00 mc-misc2002 kernel: [    6.162888] acpi =
PNP0A08:08: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:35:36.856050+00:00 mc-misc2002 kernel: [    6.170692] acpi =
PNP0A08:08: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:35:36.856051+00:00 mc-misc2002 kernel: [    6.182811] PCI h=
ost bridge to bus 0000:80
> 2025-05-21T10:35:36.856051+00:00 mc-misc2002 kernel: [    6.186693] pci_b=
us 0000:80: root bus resource [io  0xb000-0xbfff window]
> 2025-05-21T10:35:36.856059+00:00 mc-misc2002 kernel: [    6.194692] pci_b=
us 0000:80: root bus resource [mem 0xc6800000-0xd0ffffff window]
> 2025-05-21T10:35:36.856060+00:00 mc-misc2002 kernel: [    6.202692] pci_b=
us 0000:80: root bus resource [mem 0x205000000000-0x205fffffffff window]
> 2025-05-21T10:35:36.856064+00:00 mc-misc2002 kernel: [    6.210693] pci_b=
us 0000:80: root bus resource [bus 80-96]
> 2025-05-21T10:35:36.856065+00:00 mc-misc2002 kernel: [    6.218702] pci 0=
000:80:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:35:36.856065+00:00 mc-misc2002 kernel: [    6.222778] pci 0=
000:80:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:35:36.856065+00:00 mc-misc2002 kernel: [    6.230761] pci 0=
000:80:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:35:36.856066+00:00 mc-misc2002 kernel: [    6.238762] pci 0=
000:80:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:35:36.856066+00:00 mc-misc2002 kernel: [    6.242764] pci 0=
000:80:01.0: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.856069+00:00 mc-misc2002 kernel: [    6.250702] pci 0=
000:80:01.0: reg 0x10: [mem 0x205ffff40000-0x205ffff43fff 64bit]
> 2025-05-21T10:35:36.856070+00:00 mc-misc2002 kernel: [    6.258789] pci 0=
000:80:01.1: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.856070+00:00 mc-misc2002 kernel: [    6.266702] pci 0=
000:80:01.1: reg 0x10: [mem 0x205ffff3c000-0x205ffff3ffff 64bit]
> 2025-05-21T10:35:36.856071+00:00 mc-misc2002 kernel: [    6.274793] pci 0=
000:80:01.2: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.856071+00:00 mc-misc2002 kernel: [    6.282702] pci 0=
000:80:01.2: reg 0x10: [mem 0x205ffff38000-0x205ffff3bfff 64bit]
> 2025-05-21T10:35:36.856071+00:00 mc-misc2002 kernel: [    6.290787] pci 0=
000:80:01.3: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.856077+00:00 mc-misc2002 kernel: [    6.298701] pci 0=
000:80:01.3: reg 0x10: [mem 0x205ffff34000-0x205ffff37fff 64bit]
> 2025-05-21T10:35:36.856077+00:00 mc-misc2002 kernel: [    6.306788] pci 0=
000:80:01.4: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.856078+00:00 mc-misc2002 kernel: [    6.310701] pci 0=
000:80:01.4: reg 0x10: [mem 0x205ffff30000-0x205ffff33fff 64bit]
> 2025-05-21T10:35:36.856078+00:00 mc-misc2002 kernel: [    6.322785] pci 0=
000:80:01.5: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.856078+00:00 mc-misc2002 kernel: [    6.326701] pci 0=
000:80:01.5: reg 0x10: [mem 0x205ffff2c000-0x205ffff2ffff 64bit]
> 2025-05-21T10:35:36.856078+00:00 mc-misc2002 kernel: [    6.334786] pci 0=
000:80:01.6: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.856079+00:00 mc-misc2002 kernel: [    6.342702] pci 0=
000:80:01.6: reg 0x10: [mem 0x205ffff28000-0x205ffff2bfff 64bit]
> 2025-05-21T10:35:36.856085+00:00 mc-misc2002 kernel: [    6.350785] pci 0=
000:80:01.7: [8086:0b00] type 00 class 0x088000
> 2025-05-21T10:35:36.856085+00:00 mc-misc2002 kernel: [    6.358701] pci 0=
000:80:01.7: reg 0x10: [mem 0x205ffff24000-0x205ffff27fff 64bit]
> 2025-05-21T10:35:36.856086+00:00 mc-misc2002 kernel: [    6.366783] pci 0=
000:80:02.0: [8086:09a6] type 00 class 0x088000
> 2025-05-21T10:35:36.856086+00:00 mc-misc2002 kernel: [    6.374700] pci 0=
000:80:02.0: reg 0x10: [mem 0xd0f80000-0xd0f81fff]
> 2025-05-21T10:35:36.856086+00:00 mc-misc2002 kernel: [    6.378750] pci 0=
000:80:02.1: [8086:09a7] type 00 class 0x088000
> 2025-05-21T10:35:36.856087+00:00 mc-misc2002 kernel: [    6.386700] pci 0=
000:80:02.1: reg 0x10: [mem 0xd0f00000-0xd0f7ffff]
> 2025-05-21T10:35:36.856093+00:00 mc-misc2002 kernel: [    6.394697] pci 0=
000:80:02.1: reg 0x14: [mem 0xd0e80000-0xd0efffff]
> 2025-05-21T10:35:36.856103+00:00 mc-misc2002 kernel: [    6.402752] pci 0=
000:80:02.4: [8086:3456] type 00 class 0x130000
> 2025-05-21T10:35:36.856104+00:00 mc-misc2002 kernel: [    6.406701] pci 0=
000:80:02.4: reg 0x10: [mem 0x205fffe00000-0x205fffefffff 64bit]
> 2025-05-21T10:35:36.856104+00:00 mc-misc2002 kernel: [    6.414698] pci 0=
000:80:02.4: reg 0x18: [mem 0x205ffff20000-0x205ffff23fff 64bit]
> 2025-05-21T10:35:36.856105+00:00 mc-misc2002 kernel: [    6.426699] pci 0=
000:80:02.4: reg 0x20: [mem 0x205ffff00000-0x205ffff1ffff 64bit]
> 2025-05-21T10:35:36.856105+00:00 mc-misc2002 kernel: [    6.434761] pci_b=
us 0000:80: on NUMA node 1
> 2025-05-21T10:35:36.856105+00:00 mc-misc2002 kernel: [    6.434830] ACPI:=
 PCI Root Bridge [PC07] (domain 0000 [bus 97-af])
> 2025-05-21T10:35:36.856134+00:00 mc-misc2002 kernel: [    6.438694] acpi =
PNP0A08:09: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:35:36.856135+00:00 mc-misc2002 kernel: [    6.451650] acpi =
PNP0A08:09: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:35:36.856135+00:00 mc-misc2002 kernel: [    6.458950] acpi =
PNP0A08:09: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:35:36.856135+00:00 mc-misc2002 kernel: [    6.466694] acpi =
PNP0A08:09: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:35:36.856136+00:00 mc-misc2002 kernel: [    6.478820] PCI h=
ost bridge to bus 0000:97
> 2025-05-21T10:35:36.856136+00:00 mc-misc2002 kernel: [    6.482693] pci_b=
us 0000:97: root bus resource [io  0xc000-0xcfff window]
> 2025-05-21T10:35:36.856140+00:00 mc-misc2002 kernel: [    6.490692] pci_b=
us 0000:97: root bus resource [mem 0xd1000000-0xdbbfffff window]
> 2025-05-21T10:35:36.856141+00:00 mc-misc2002 kernel: [    6.498692] pci_b=
us 0000:97: root bus resource [mem 0x206000000000-0x206fffffffff window]
> 2025-05-21T10:35:36.856141+00:00 mc-misc2002 kernel: [    6.506692] pci_b=
us 0000:97: root bus resource [bus 97-af]
> 2025-05-21T10:35:36.856141+00:00 mc-misc2002 kernel: [    6.514702] pci 0=
000:97:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:35:36.856142+00:00 mc-misc2002 kernel: [    6.518762] pci 0=
000:97:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:35:36.856142+00:00 mc-misc2002 kernel: [    6.526760] pci 0=
000:97:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:35:36.856146+00:00 mc-misc2002 kernel: [    6.534761] pci 0=
000:97:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:35:36.856146+00:00 mc-misc2002 kernel: [    6.542766] pci 0=
000:97:04.0: [8086:347c] type 01 class 0x060400
> 2025-05-21T10:35:36.856155+00:00 mc-misc2002 kernel: [    6.546701] pci 0=
000:97:04.0: reg 0x10: [mem 0x206ffff00000-0x206ffff1ffff 64bit]
> 2025-05-21T10:35:36.856161+00:00 mc-misc2002 kernel: [    6.554733] pci 0=
000:97:04.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.856162+00:00 mc-misc2002 kernel: [    6.563077] acpip=
hp: Slot [0-2] registered
> 2025-05-21T10:35:36.856162+00:00 mc-misc2002 kernel: [    6.566726] pci 0=
000:98:00.0: [14e4:16d7] type 00 class 0x020000
> 2025-05-21T10:35:36.856162+00:00 mc-misc2002 kernel: [    6.574710] pci 0=
000:98:00.0: reg 0x10: [mem 0x206fffe10000-0x206fffe1ffff 64bit pref]
> 2025-05-21T10:35:36.856168+00:00 mc-misc2002 kernel: [    6.582705] pci 0=
000:98:00.0: reg 0x18: [mem 0x206fffd00000-0x206fffdfffff 64bit pref]
> 2025-05-21T10:35:36.856168+00:00 mc-misc2002 kernel: [    6.594704] pci 0=
000:98:00.0: reg 0x20: [mem 0x206fffe22000-0x206fffe23fff 64bit pref]
> 2025-05-21T10:35:36.856168+00:00 mc-misc2002 kernel: [    6.602699] pci 0=
000:98:00.0: reg 0x30: [mem 0xdba40000-0xdba7ffff pref]
> 2025-05-21T10:35:36.856169+00:00 mc-misc2002 kernel: [    6.610759] pci 0=
000:98:00.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.856169+00:00 mc-misc2002 kernel: [    6.614874] pci 0=
000:98:00.1: [14e4:16d7] type 00 class 0x020000
> 2025-05-21T10:35:36.856169+00:00 mc-misc2002 kernel: [    6.622708] pci 0=
000:98:00.1: reg 0x10: [mem 0x206fffe00000-0x206fffe0ffff 64bit pref]
> 2025-05-21T10:35:36.856175+00:00 mc-misc2002 kernel: [    6.630702] pci 0=
000:98:00.1: reg 0x18: [mem 0x206fffc00000-0x206fffcfffff 64bit pref]
> 2025-05-21T10:35:36.856176+00:00 mc-misc2002 kernel: [    6.642703] pci 0=
000:98:00.1: reg 0x20: [mem 0x206fffe20000-0x206fffe21fff 64bit pref]
> 2025-05-21T10:35:36.856176+00:00 mc-misc2002 kernel: [    6.650698] pci 0=
000:98:00.1: reg 0x30: [mem 0xdba00000-0xdba3ffff pref]
> 2025-05-21T10:35:36.856176+00:00 mc-misc2002 kernel: [    6.658757] pci 0=
000:98:00.1: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.856177+00:00 mc-misc2002 kernel: [    6.662805] pci 0=
000:97:04.0: PCI bridge to [bus 98]
> 2025-05-21T10:35:36.856185+00:00 mc-misc2002 kernel: [    6.670694] pci 0=
000:97:04.0:   bridge window [mem 0xdba00000-0xdbafffff]
> 2025-05-21T10:35:36.856189+00:00 mc-misc2002 kernel: [    6.678694] pci 0=
000:97:04.0:   bridge window [mem 0x206fffc00000-0x206fffefffff 64bit pref]
> 2025-05-21T10:35:36.856190+00:00 mc-misc2002 kernel: [    6.686697] pci_b=
us 0000:97: on NUMA node 1
> 2025-05-21T10:35:36.856190+00:00 mc-misc2002 kernel: [    6.686801] ACPI:=
 PCI Root Bridge [PC08] (domain 0000 [bus b0-c8])
> 2025-05-21T10:35:36.856191+00:00 mc-misc2002 kernel: [    6.694694] acpi =
PNP0A08:0a: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:35:36.856199+00:00 mc-misc2002 kernel: [    6.703473] acpi =
PNP0A08:0a: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:35:36.856200+00:00 mc-misc2002 kernel: [    6.714947] acpi =
PNP0A08:0a: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:35:36.856200+00:00 mc-misc2002 kernel: [    6.722692] acpi =
PNP0A08:0a: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:35:36.856204+00:00 mc-misc2002 kernel: [    6.730815] PCI h=
ost bridge to bus 0000:b0
> 2025-05-21T10:35:36.856205+00:00 mc-misc2002 kernel: [    6.734693] pci_b=
us 0000:b0: root bus resource [io  0xd000-0xdfff window]
> 2025-05-21T10:35:36.856206+00:00 mc-misc2002 kernel: [    6.742692] pci_b=
us 0000:b0: root bus resource [mem 0xdbc00000-0xe67fffff window]
> 2025-05-21T10:35:36.856206+00:00 mc-misc2002 kernel: [    6.750692] pci_b=
us 0000:b0: root bus resource [mem 0x207000000000-0x207fffffffff window]
> 2025-05-21T10:35:36.856206+00:00 mc-misc2002 kernel: [    6.762694] pci_b=
us 0000:b0: root bus resource [bus b0-c8]
> 2025-05-21T10:35:36.856207+00:00 mc-misc2002 kernel: [    6.766702] pci 0=
000:b0:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:35:36.856211+00:00 mc-misc2002 kernel: [    6.774762] pci 0=
000:b0:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:35:36.856214+00:00 mc-misc2002 kernel: [    6.782760] pci 0=
000:b0:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:35:36.856215+00:00 mc-misc2002 kernel: [    6.786760] pci 0=
000:b0:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:35:36.856216+00:00 mc-misc2002 kernel: [    6.794770] pci_b=
us 0000:b0: on NUMA node 1
> 2025-05-21T10:35:36.856216+00:00 mc-misc2002 kernel: [    6.794889] ACPI:=
 PCI Root Bridge [PC10] (domain 0000 [bus c9-e1])
> 2025-05-21T10:35:36.856216+00:00 mc-misc2002 kernel: [    6.802694] acpi =
PNP0A08:0c: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:35:36.856220+00:00 mc-misc2002 kernel: [    6.811791] acpi =
PNP0A08:0c: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:35:36.856220+00:00 mc-misc2002 kernel: [    6.822952] acpi =
PNP0A08:0c: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:35:36.856221+00:00 mc-misc2002 kernel: [    6.830693] acpi =
PNP0A08:0c: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:35:36.856221+00:00 mc-misc2002 kernel: [    6.838817] PCI h=
ost bridge to bus 0000:c9
> 2025-05-21T10:35:36.856221+00:00 mc-misc2002 kernel: [    6.842693] pci_b=
us 0000:c9: root bus resource [io  0xe000-0xefff window]
> 2025-05-21T10:35:36.856230+00:00 mc-misc2002 kernel: [    6.850692] pci_b=
us 0000:c9: root bus resource [mem 0xe6800000-0xf13fffff window]
> 2025-05-21T10:35:36.856231+00:00 mc-misc2002 kernel: [    6.858692] pci_b=
us 0000:c9: root bus resource [mem 0x208000000000-0x208fffffffff window]
> 2025-05-21T10:35:36.856239+00:00 mc-misc2002 kernel: [    6.870693] pci_b=
us 0000:c9: root bus resource [bus c9-e1]
> 2025-05-21T10:35:36.856239+00:00 mc-misc2002 kernel: [    6.874702] pci 0=
000:c9:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:35:36.856239+00:00 mc-misc2002 kernel: [    6.882762] pci 0=
000:c9:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:35:36.856240+00:00 mc-misc2002 kernel: [    6.890760] pci 0=
000:c9:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:35:36.856240+00:00 mc-misc2002 kernel: [    6.894781] pci 0=
000:c9:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:35:36.856240+00:00 mc-misc2002 kernel: [    6.902777] pci 0=
000:c9:02.0: [8086:347a] type 01 class 0x060400
> 2025-05-21T10:35:36.856246+00:00 mc-misc2002 kernel: [    6.910705] pci 0=
000:c9:02.0: reg 0x10: [mem 0x208ffff20000-0x208ffff3ffff 64bit]
> 2025-05-21T10:35:36.856247+00:00 mc-misc2002 kernel: [    6.918705] pci 0=
000:c9:02.0: enabling Extended Tags
> 2025-05-21T10:35:36.856247+00:00 mc-misc2002 kernel: [    6.922726] pci 0=
000:c9:02.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.856248+00:00 mc-misc2002 kernel: [    6.930948] pci 0=
000:c9:03.0: [8086:347b] type 01 class 0x060400
> 2025-05-21T10:35:36.856248+00:00 mc-misc2002 kernel: [    6.938702] pci 0=
000:c9:03.0: reg 0x10: [mem 0x208ffff00000-0x208ffff1ffff 64bit]
> 2025-05-21T10:35:36.856256+00:00 mc-misc2002 kernel: [    6.946704] pci 0=
000:c9:03.0: enabling Extended Tags
> 2025-05-21T10:35:36.856260+00:00 mc-misc2002 kernel: [    6.950725] pci 0=
000:c9:03.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.856261+00:00 mc-misc2002 kernel: [    6.959065] pci 0=
000:c9:02.0: PCI bridge to [bus ca]
> 2025-05-21T10:35:36.856262+00:00 mc-misc2002 kernel: [    6.962695] pci 0=
000:c9:02.0:   bridge window [mem 0xf1200000-0xf12fffff]
> 2025-05-21T10:35:36.856262+00:00 mc-misc2002 kernel: [    6.970816] pci 0=
000:c9:03.0: PCI bridge to [bus cb]
> 2025-05-21T10:35:36.856262+00:00 mc-misc2002 kernel: [    6.978694] pci 0=
000:c9:03.0:   bridge window [mem 0xf1100000-0xf11fffff]
> 2025-05-21T10:35:36.856263+00:00 mc-misc2002 kernel: [    6.986703] pci_b=
us 0000:c9: on NUMA node 1
> 2025-05-21T10:35:36.856263+00:00 mc-misc2002 kernel: [    6.986811] ACPI:=
 PCI Root Bridge [PC11] (domain 0000 [bus e2-fa])
> 2025-05-21T10:35:36.856268+00:00 mc-misc2002 kernel: [    6.990694] acpi =
PNP0A08:0d: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:35:36.856269+00:00 mc-misc2002 kernel: [    7.004134] acpi =
PNP0A08:0d: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T10:35:36.856269+00:00 mc-misc2002 kernel: [    7.010952] acpi =
PNP0A08:0d: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T10:35:36.856270+00:00 mc-misc2002 kernel: [    7.022693] acpi =
PNP0A08:0d: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:35:36.856270+00:00 mc-misc2002 kernel: [    7.030820] PCI h=
ost bridge to bus 0000:e2
> 2025-05-21T10:35:36.856270+00:00 mc-misc2002 kernel: [    7.034693] pci_b=
us 0000:e2: root bus resource [io  0xf000-0xffff window]
> 2025-05-21T10:35:36.856275+00:00 mc-misc2002 kernel: [    7.042692] pci_b=
us 0000:e2: root bus resource [mem 0xf1400000-0xfb7fffff window]
> 2025-05-21T10:35:36.856276+00:00 mc-misc2002 kernel: [    7.050692] pci_b=
us 0000:e2: root bus resource [mem 0x209000000000-0x209fffffffff window]
> 2025-05-21T10:35:36.856276+00:00 mc-misc2002 kernel: [    7.058693] pci_b=
us 0000:e2: root bus resource [bus e2-fa]
> 2025-05-21T10:35:36.856276+00:00 mc-misc2002 kernel: [    7.066703] pci 0=
000:e2:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T10:35:36.856277+00:00 mc-misc2002 kernel: [    7.074767] pci 0=
000:e2:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T10:35:36.856277+00:00 mc-misc2002 kernel: [    7.078762] pci 0=
000:e2:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T10:35:36.856283+00:00 mc-misc2002 kernel: [    7.086761] pci 0=
000:e2:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:35:36.856284+00:00 mc-misc2002 kernel: [    7.094769] pci 0=
000:e2:02.0: [8086:347a] type 01 class 0x060400
> 2025-05-21T10:35:36.856284+00:00 mc-misc2002 kernel: [    7.098702] pci 0=
000:e2:02.0: reg 0x10: [mem 0x209ffff60000-0x209ffff7ffff 64bit]
> 2025-05-21T10:35:36.856284+00:00 mc-misc2002 kernel: [    7.106704] pci 0=
000:e2:02.0: enabling Extended Tags
> 2025-05-21T10:35:36.856287+00:00 mc-misc2002 kernel: [    7.114725] pci 0=
000:e2:02.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.856287+00:00 mc-misc2002 kernel: [    7.122941] pci 0=
000:e2:03.0: [8086:347b] type 01 class 0x060400
> 2025-05-21T10:35:36.856288+00:00 mc-misc2002 kernel: [    7.126704] pci 0=
000:e2:03.0: reg 0x10: [mem 0x209ffff40000-0x209ffff5ffff 64bit]
> 2025-05-21T10:35:36.856291+00:00 mc-misc2002 kernel: [    7.134708] pci 0=
000:e2:03.0: enabling Extended Tags
> 2025-05-21T10:35:36.856293+00:00 mc-misc2002 kernel: [    7.142753] pci 0=
000:e2:03.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.856294+00:00 mc-misc2002 kernel: [    7.150931] pci 0=
000:e2:04.0: [8086:347c] type 01 class 0x060400
> 2025-05-21T10:35:36.856294+00:00 mc-misc2002 kernel: [    7.154702] pci 0=
000:e2:04.0: reg 0x10: [mem 0x209ffff20000-0x209ffff3ffff 64bit]
> 2025-05-21T10:35:36.856294+00:00 mc-misc2002 kernel: [    7.162704] pci 0=
000:e2:04.0: enabling Extended Tags
> 2025-05-21T10:35:36.856295+00:00 mc-misc2002 kernel: [    7.170724] pci 0=
000:e2:04.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.856298+00:00 mc-misc2002 kernel: [    7.178926] pci 0=
000:e2:05.0: [8086:347d] type 01 class 0x060400
> 2025-05-21T10:35:36.856299+00:00 mc-misc2002 kernel: [    7.182702] pci 0=
000:e2:05.0: reg 0x10: [mem 0x209ffff00000-0x209ffff1ffff 64bit]
> 2025-05-21T10:35:36.856308+00:00 mc-misc2002 kernel: [    7.190704] pci 0=
000:e2:05.0: enabling Extended Tags
> 2025-05-21T10:35:36.856308+00:00 mc-misc2002 kernel: [    7.198726] pci 0=
000:e2:05.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T10:35:36.856309+00:00 mc-misc2002 kernel: [    7.203057] pci 0=
000:e2:02.0: PCI bridge to [bus e3]
> 2025-05-21T10:35:36.856309+00:00 mc-misc2002 kernel: [    7.210695] pci 0=
000:e2:02.0:   bridge window [mem 0xfb600000-0xfb6fffff]
> 2025-05-21T10:35:36.856309+00:00 mc-misc2002 kernel: [    7.218819] pci 0=
000:e2:03.0: PCI bridge to [bus e4]
> 2025-05-21T10:35:36.856316+00:00 mc-misc2002 kernel: [    7.222694] pci 0=
000:e2:03.0:   bridge window [mem 0xfb500000-0xfb5fffff]
> 2025-05-21T10:35:36.856316+00:00 mc-misc2002 kernel: [    7.230817] pci 0=
000:e2:04.0: PCI bridge to [bus e5]
> 2025-05-21T10:35:36.856316+00:00 mc-misc2002 kernel: [    7.238694] pci 0=
000:e2:04.0:   bridge window [mem 0xfb400000-0xfb4fffff]
> 2025-05-21T10:35:36.856317+00:00 mc-misc2002 kernel: [    7.246821] pci 0=
000:e2:05.0: PCI bridge to [bus e6]
> 2025-05-21T10:35:36.856317+00:00 mc-misc2002 kernel: [    7.250694] pci 0=
000:e2:05.0:   bridge window [mem 0xfb300000-0xfb3fffff]
> 2025-05-21T10:35:36.856318+00:00 mc-misc2002 kernel: [    7.258711] pci_b=
us 0000:e2: on NUMA node 1
> 2025-05-21T10:35:36.856323+00:00 mc-misc2002 kernel: [    7.258811] ACPI:=
 PCI Root Bridge [UC16] (domain 0000 [bus fe])
> 2025-05-21T10:35:36.856323+00:00 mc-misc2002 kernel: [    7.266694] acpi =
PNP0A08:0e: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:35:36.856329+00:00 mc-misc2002 kernel: [    7.274760] acpi =
PNP0A08:0e: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T10:35:36.856330+00:00 mc-misc2002 kernel: [    7.282812] acpi =
PNP0A08:0e: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T10:35:36.856341+00:00 mc-misc2002 kernel: [    7.290693] acpi =
PNP0A08:0e: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:35:36.856342+00:00 mc-misc2002 kernel: [    7.302801] PCI h=
ost bridge to bus 0000:fe
> 2025-05-21T10:35:36.856348+00:00 mc-misc2002 kernel: [    7.306693] pci_b=
us 0000:fe: root bus resource [bus fe]
> 2025-05-21T10:35:36.856348+00:00 mc-misc2002 kernel: [    7.310702] pci 0=
000:fe:00.0: [8086:3450] type 00 class 0x088000
> 2025-05-21T10:35:36.856349+00:00 mc-misc2002 kernel: [    7.318774] pci 0=
000:fe:00.1: [8086:3451] type 00 class 0x088000
> 2025-05-21T10:35:36.856349+00:00 mc-misc2002 kernel: [    7.326751] pci 0=
000:fe:00.2: [8086:3452] type 00 class 0x088000
> 2025-05-21T10:35:36.856352+00:00 mc-misc2002 kernel: [    7.330750] pci 0=
000:fe:00.3: [8086:0998] type 00 class 0x060000
> 2025-05-21T10:35:36.856352+00:00 mc-misc2002 kernel: [    7.338753] pci 0=
000:fe:00.5: [8086:3455] type 00 class 0x088000
> 2025-05-21T10:35:36.856353+00:00 mc-misc2002 kernel: [    7.346761] pci 0=
000:fe:02.0: [8086:3440] type 00 class 0x088000
> 2025-05-21T10:35:36.856356+00:00 mc-misc2002 kernel: [    7.350828] pci 0=
000:fe:02.1: [8086:3441] type 00 class 0x088000
> 2025-05-21T10:35:36.856356+00:00 mc-misc2002 kernel: [    7.358808] pci 0=
000:fe:02.2: [8086:3442] type 00 class 0x088000
> 2025-05-21T10:35:36.856356+00:00 mc-misc2002 kernel: [    7.366819] pci 0=
000:fe:04.0: [8086:3440] type 00 class 0x088000
> 2025-05-21T10:35:36.856363+00:00 mc-misc2002 kernel: [    7.374820] pci 0=
000:fe:04.1: [8086:3441] type 00 class 0x088000
> 2025-05-21T10:35:36.856364+00:00 mc-misc2002 kernel: [    7.378816] pci 0=
000:fe:04.2: [8086:3442] type 00 class 0x088000
> 2025-05-21T10:35:36.856364+00:00 mc-misc2002 kernel: [    7.386817] pci 0=
000:fe:04.3: [8086:3443] type 00 class 0x088000
> 2025-05-21T10:35:36.856375+00:00 mc-misc2002 kernel: [    7.394819] pci 0=
000:fe:05.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T10:35:36.856633+00:00 mc-misc2002 kernel: [    7.402834] pci 0=
000:fe:05.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T10:35:36.856634+00:00 mc-misc2002 kernel: [    7.406813] pci 0=
000:fe:05.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T10:35:36.856635+00:00 mc-misc2002 kernel: [    7.414812] pci 0=
000:fe:06.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T10:35:36.856635+00:00 mc-misc2002 kernel: [    7.422798] pci 0=
000:fe:06.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T10:35:36.856635+00:00 mc-misc2002 kernel: [    7.426775] pci 0=
000:fe:06.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T10:35:36.856639+00:00 mc-misc2002 kernel: [    7.434783] pci 0=
000:fe:07.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T10:35:36.856639+00:00 mc-misc2002 kernel: [    7.442836] pci 0=
000:fe:07.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T10:35:36.856639+00:00 mc-misc2002 kernel: [    7.450821] pci 0=
000:fe:07.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T10:35:36.856640+00:00 mc-misc2002 kernel: [    7.454822] pci 0=
000:fe:0b.0: [8086:3448] type 00 class 0x088000
> 2025-05-21T10:35:36.856640+00:00 mc-misc2002 kernel: [    7.462773] pci 0=
000:fe:0b.1: [8086:3448] type 00 class 0x088000
> 2025-05-21T10:35:36.856641+00:00 mc-misc2002 kernel: [    7.470757] pci 0=
000:fe:0b.2: [8086:344b] type 00 class 0x088000
> 2025-05-21T10:35:36.856641+00:00 mc-misc2002 kernel: [    7.474770] pci 0=
000:fe:0c.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:35:36.856644+00:00 mc-misc2002 kernel: [    7.482803] pci 0=
000:fe:0d.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:35:36.856644+00:00 mc-misc2002 kernel: [    7.490796] pci 0=
000:fe:0e.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:35:36.856645+00:00 mc-misc2002 kernel: [    7.494835] pci 0=
000:fe:0f.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T10:35:36.856645+00:00 mc-misc2002 kernel: [    7.502850] pci 0=
000:fe:1a.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:35:36.856645+00:00 mc-misc2002 kernel: [    7.510800] pci 0=
000:fe:1b.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:35:36.856646+00:00 mc-misc2002 kernel: [    7.518795] pci 0=
000:fe:1c.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:35:36.856648+00:00 mc-misc2002 kernel: [    7.522842] pci 0=
000:fe:1d.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T10:35:36.856649+00:00 mc-misc2002 kernel: [    7.530844] pci_b=
us 0000:fe: on NUMA node 1
> 2025-05-21T10:35:36.856649+00:00 mc-misc2002 kernel: [    7.530916] ACPI:=
 PCI Root Bridge [UC17] (domain 0000 [bus ff])
> 2025-05-21T10:35:36.856649+00:00 mc-misc2002 kernel: [    7.538694] acpi =
PNP0A08:0f: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T10:35:36.856650+00:00 mc-misc2002 kernel: [    7.546760] acpi =
PNP0A08:0f: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T10:35:36.856650+00:00 mc-misc2002 kernel: [    7.554811] acpi =
PNP0A08:0f: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T10:35:36.856652+00:00 mc-misc2002 kernel: [    7.566693] acpi =
PNP0A08:0f: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T10:35:36.856654+00:00 mc-misc2002 kernel: [    7.574813] PCI h=
ost bridge to bus 0000:ff
> 2025-05-21T10:35:36.856654+00:00 mc-misc2002 kernel: [    7.578693] pci_b=
us 0000:ff: root bus resource [bus ff]
> 2025-05-21T10:35:36.856654+00:00 mc-misc2002 kernel: [    7.586708] pci 0=
000:ff:00.0: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.856655+00:00 mc-misc2002 kernel: [    7.590825] pci 0=
000:ff:00.1: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.856655+00:00 mc-misc2002 kernel: [    7.598793] pci 0=
000:ff:00.2: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.856655+00:00 mc-misc2002 kernel: [    7.606814] pci 0=
000:ff:00.3: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.856658+00:00 mc-misc2002 kernel: [    7.610789] pci 0=
000:ff:00.4: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.856659+00:00 mc-misc2002 kernel: [    7.618817] pci 0=
000:ff:00.5: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.856659+00:00 mc-misc2002 kernel: [    7.626781] pci 0=
000:ff:00.6: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.856659+00:00 mc-misc2002 kernel: [    7.634819] pci 0=
000:ff:00.7: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.856660+00:00 mc-misc2002 kernel: [    7.638837] pci 0=
000:ff:01.0: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.856660+00:00 mc-misc2002 kernel: [    7.646854] pci 0=
000:ff:01.1: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.856663+00:00 mc-misc2002 kernel: [    7.654836] pci 0=
000:ff:01.2: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.856663+00:00 mc-misc2002 kernel: [    7.658835] pci 0=
000:ff:01.3: [8086:344c] type 00 class 0x088000
> 2025-05-21T10:35:36.856664+00:00 mc-misc2002 kernel: [    7.666846] pci 0=
000:ff:0a.0: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856664+00:00 mc-misc2002 kernel: [    7.674829] pci 0=
000:ff:0a.1: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856664+00:00 mc-misc2002 kernel: [    7.682793] pci 0=
000:ff:0a.2: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856664+00:00 mc-misc2002 kernel: [    7.686814] pci 0=
000:ff:0a.3: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856665+00:00 mc-misc2002 kernel: [    7.694793] pci 0=
000:ff:0a.4: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856668+00:00 mc-misc2002 kernel: [    7.702816] pci 0=
000:ff:0a.5: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856668+00:00 mc-misc2002 kernel: [    7.706781] pci 0=
000:ff:0a.6: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856668+00:00 mc-misc2002 kernel: [    7.714819] pci 0=
000:ff:0a.7: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856669+00:00 mc-misc2002 kernel: [    7.722830] pci 0=
000:ff:0b.0: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856669+00:00 mc-misc2002 kernel: [    7.730861] pci 0=
000:ff:0b.1: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856669+00:00 mc-misc2002 kernel: [    7.734842] pci 0=
000:ff:0b.2: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856673+00:00 mc-misc2002 kernel: [    7.742835] pci 0=
000:ff:0b.3: [8086:344d] type 00 class 0x088000
> 2025-05-21T10:35:36.856674+00:00 mc-misc2002 kernel: [    7.750858] pci 0=
000:ff:1d.0: [8086:344f] type 00 class 0x088000
> 2025-05-21T10:35:36.856674+00:00 mc-misc2002 kernel: [    7.754831] pci 0=
000:ff:1d.1: [8086:3457] type 00 class 0x088000
> 2025-05-21T10:35:36.856675+00:00 mc-misc2002 kernel: [    7.762818] pci 0=
000:ff:1e.0: [8086:3458] type 00 class 0x088000
> 2025-05-21T10:35:36.856675+00:00 mc-misc2002 kernel: [    7.770773] pci 0=
000:ff:1e.1: [8086:3459] type 00 class 0x088000
> 2025-05-21T10:35:36.856675+00:00 mc-misc2002 kernel: [    7.778757] pci 0=
000:ff:1e.2: [8086:345a] type 00 class 0x088000
> 2025-05-21T10:35:36.856677+00:00 mc-misc2002 kernel: [    7.782756] pci 0=
000:ff:1e.3: [8086:345b] type 00 class 0x088000
> 2025-05-21T10:35:36.856679+00:00 mc-misc2002 kernel: [    7.790757] pci 0=
000:ff:1e.4: [8086:345c] type 00 class 0x088000
> 2025-05-21T10:35:36.856679+00:00 mc-misc2002 kernel: [    7.798757] pci 0=
000:ff:1e.5: [8086:345d] type 00 class 0x088000
> 2025-05-21T10:35:36.856680+00:00 mc-misc2002 kernel: [    7.802761] pci 0=
000:ff:1e.6: [8086:345e] type 00 class 0x088000
> 2025-05-21T10:35:36.856680+00:00 mc-misc2002 kernel: [    7.810756] pci 0=
000:ff:1e.7: [8086:345f] type 00 class 0x088000
> 2025-05-21T10:35:36.856680+00:00 mc-misc2002 kernel: [    7.818752] pci_b=
us 0000:ff: on NUMA node 1
> 2025-05-21T10:35:36.856680+00:00 mc-misc2002 kernel: [    7.819025] ACPI:=
 PCI: Interrupt link LNKA configured for IRQ 11
> 2025-05-21T10:35:36.856684+00:00 mc-misc2002 kernel: [    7.826731] ACPI:=
 PCI: Interrupt link LNKB configured for IRQ 10
> 2025-05-21T10:35:36.856684+00:00 mc-misc2002 kernel: [    7.830730] ACPI:=
 PCI: Interrupt link LNKC configured for IRQ 11
> 2025-05-21T10:35:36.856684+00:00 mc-misc2002 kernel: [    7.838729] ACPI:=
 PCI: Interrupt link LNKD configured for IRQ 11
> 2025-05-21T10:35:36.856685+00:00 mc-misc2002 kernel: [    7.846730] ACPI:=
 PCI: Interrupt link LNKE configured for IRQ 11
> 2025-05-21T10:35:36.856685+00:00 mc-misc2002 kernel: [    7.850729] ACPI:=
 PCI: Interrupt link LNKF configured for IRQ 11
> 2025-05-21T10:35:36.856685+00:00 mc-misc2002 kernel: [    7.858729] ACPI:=
 PCI: Interrupt link LNKG configured for IRQ 11
> 2025-05-21T10:35:36.856688+00:00 mc-misc2002 kernel: [    7.866730] ACPI:=
 PCI: Interrupt link LNKH configured for IRQ 11
> 2025-05-21T10:35:36.856689+00:00 mc-misc2002 kernel: [    7.874708] iommu=
: Default domain type: Translated=20
> 2025-05-21T10:35:36.856689+00:00 mc-misc2002 kernel: [    7.878693] iommu=
: DMA domain TLB invalidation policy: lazy mode=20
> 2025-05-21T10:35:36.856689+00:00 mc-misc2002 kernel: [    7.886795] pps_c=
ore: LinuxPPS API ver. 1 registered
> 2025-05-21T10:35:36.856690+00:00 mc-misc2002 kernel: [    7.890692] pps_c=
ore: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@l=
inux.it>
> 2025-05-21T10:35:36.856690+00:00 mc-misc2002 kernel: [    7.902694] PTP c=
lock support registered
> 2025-05-21T10:35:36.856690+00:00 mc-misc2002 kernel: [    7.906724] EDAC =
MC: Ver: 3.0.0
> 2025-05-21T10:35:36.856694+00:00 mc-misc2002 kernel: [    7.910898] NetLa=
bel: Initializing
> 2025-05-21T10:35:36.856694+00:00 mc-misc2002 kernel: [    7.914693] NetLa=
bel:  domain hash size =3D 128
> 2025-05-21T10:35:36.856694+00:00 mc-misc2002 kernel: [    7.918692] NetLa=
bel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
> 2025-05-21T10:35:36.856695+00:00 mc-misc2002 kernel: [    7.926708] NetLa=
bel:  unlabeled traffic allowed by default
> 2025-05-21T10:35:36.856695+00:00 mc-misc2002 kernel: [    7.930694] PCI: =
Using ACPI for IRQ routing
> 2025-05-21T10:35:36.856695+00:00 mc-misc2002 kernel: [    7.938282] PCI: =
pci_cache_line_size set to 64 bytes
> 2025-05-21T10:35:36.856698+00:00 mc-misc2002 kernel: [    7.938721] e820:=
 reserve RAM buffer [mem 0x00098800-0x0009ffff]
> 2025-05-21T10:35:36.856699+00:00 mc-misc2002 kernel: [    7.938723] e820:=
 reserve RAM buffer [mem 0x645ff000-0x67ffffff]
> 2025-05-21T10:35:36.856699+00:00 mc-misc2002 kernel: [    7.938725] e820:=
 reserve RAM buffer [mem 0x6f800000-0x6fffffff]
> 2025-05-21T10:35:36.856699+00:00 mc-misc2002 kernel: [    7.938739] pci 0=
000:04:00.0: vgaarb: setting as boot VGA device
> 2025-05-21T10:35:36.856700+00:00 mc-misc2002 kernel: [    7.942691] pci 0=
000:04:00.0: vgaarb: bridge control possible
> 2025-05-21T10:35:36.856700+00:00 mc-misc2002 kernel: [    7.942691] pci 0=
000:04:00.0: vgaarb: VGA device added: decodes=3Dio+mem,owns=3Dnone,locks=
=3Dnone
> 2025-05-21T10:35:36.856703+00:00 mc-misc2002 kernel: [    7.962717] vgaar=
b: loaded
> 2025-05-21T10:35:36.856704+00:00 mc-misc2002 kernel: [    7.968622] hpet0=
: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> 2025-05-21T10:35:36.856704+00:00 mc-misc2002 kernel: [    7.974692] hpet0=
: 8 comparators, 64-bit 24.000000 MHz counter
> 2025-05-21T10:35:36.856704+00:00 mc-misc2002 kernel: [    7.984802] clock=
source: Switched to clocksource tsc-early
> 2025-05-21T10:35:36.856705+00:00 mc-misc2002 kernel: [    7.989057] VFS: =
Disk quotas dquot_6.6.0
> 2025-05-21T10:35:36.856705+00:00 mc-misc2002 kernel: [    7.993486] VFS: =
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> 2025-05-21T10:35:36.856705+00:00 mc-misc2002 kernel: [    8.001359] AppAr=
mor: AppArmor Filesystem Enabled
> 2025-05-21T10:35:36.856709+00:00 mc-misc2002 kernel: [    8.006663] pnp: =
PnP ACPI init
> 2025-05-21T10:35:36.856709+00:00 mc-misc2002 kernel: [    8.018610] syste=
m 00:01: [io  0x0500-0x05fe] has been reserved
> 2025-05-21T10:35:36.856709+00:00 mc-misc2002 kernel: [    8.025260] syste=
m 00:01: [io  0x0400-0x041f] has been reserved
> 2025-05-21T10:35:36.856710+00:00 mc-misc2002 kernel: [    8.031909] syste=
m 00:01: [mem 0xff000000-0xffffffff] has been reserved
> 2025-05-21T10:35:36.856710+00:00 mc-misc2002 kernel: [    8.039625] syste=
m 00:02: [io  0x0600-0x063f] has been reserved
> 2025-05-21T10:35:36.856710+00:00 mc-misc2002 kernel: [    8.046272] syste=
m 00:02: [io  0x0a40-0x0a5f] has been reserved
> 2025-05-21T10:35:36.856714+00:00 mc-misc2002 kernel: [    8.052922] syste=
m 00:02: [io  0x0a60-0x0a6f] has been reserved
> 2025-05-21T10:35:36.856714+00:00 mc-misc2002 kernel: [    8.059569] syste=
m 00:02: [io  0x0a70-0x0a7f] has been reserved
> 2025-05-21T10:35:36.856714+00:00 mc-misc2002 kernel: [    8.066433] pnp 0=
0:03: [dma 0 disabled]
> 2025-05-21T10:35:36.856715+00:00 mc-misc2002 kernel: [    8.066659] pnp 0=
0:04: [dma 0 disabled]
> 2025-05-21T10:35:36.856715+00:00 mc-misc2002 kernel: [    8.066834] syste=
m 00:05: [mem 0xfd000000-0xfdabffff] has been reserved
> 2025-05-21T10:35:36.856715+00:00 mc-misc2002 kernel: [    8.074265] syste=
m 00:05: [mem 0xfdad0000-0xfdadffff] has been reserved
> 2025-05-21T10:35:36.856716+00:00 mc-misc2002 kernel: [    8.081691] syste=
m 00:05: [mem 0xfdb00000-0xfdffffff] has been reserved
> 2025-05-21T10:35:36.856720+00:00 mc-misc2002 kernel: [    8.089118] syste=
m 00:05: [mem 0xfe000000-0xfe00ffff] has been reserved
> 2025-05-21T10:35:36.856720+00:00 mc-misc2002 kernel: [    8.096546] syste=
m 00:05: [mem 0xfe011000-0xfe01ffff] has been reserved
> 2025-05-21T10:35:36.856721+00:00 mc-misc2002 kernel: [    8.103973] syste=
m 00:05: [mem 0xfe036000-0xfe03bfff] has been reserved
> 2025-05-21T10:35:36.856721+00:00 mc-misc2002 kernel: [    8.111401] syste=
m 00:05: [mem 0xfe03d000-0xfe3fffff] has been reserved
> 2025-05-21T10:35:36.856721+00:00 mc-misc2002 kernel: [    8.118828] syste=
m 00:05: [mem 0xfe410000-0xfe7fffff] has been reserved
> 2025-05-21T10:35:36.856722+00:00 mc-misc2002 kernel: [    8.126535] syste=
m 00:06: [io  0x0f00-0x0ffe] has been reserved
> 2025-05-21T10:35:36.856727+00:00 mc-misc2002 kernel: [    8.134047] pnp: =
PnP ACPI: found 7 devices
> 2025-05-21T10:35:36.856728+00:00 mc-misc2002 kernel: [    8.144679] clock=
source: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 20857010=
24 ns
> 2025-05-21T10:35:36.856728+00:00 mc-misc2002 kernel: [    8.154717] NET: =
Registered PF_INET protocol family
> 2025-05-21T10:35:36.856728+00:00 mc-misc2002 kernel: [    8.160536] IP id=
ents hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T10:35:36.856729+00:00 mc-misc2002 kernel: [    8.173585] tcp_l=
isten_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, vma=
lloc)
> 2025-05-21T10:35:36.856729+00:00 mc-misc2002 kernel: [    8.183698] Table=
-perturb hash table entries: 65536 (order: 6, 262144 bytes, vmalloc)
> 2025-05-21T10:35:36.856733+00:00 mc-misc2002 kernel: [    8.193078] TCP e=
stablished hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc hu=
gepage)
> 2025-05-21T10:35:36.856733+00:00 mc-misc2002 kernel: [    8.204085] TCP b=
ind hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T10:35:36.856734+00:00 mc-misc2002 kernel: [    8.212705] TCP: =
Hash tables configured (established 524288 bind 65536)
> 2025-05-21T10:35:36.856734+00:00 mc-misc2002 kernel: [    8.220487] MPTCP=
 token hash table entries: 65536 (order: 8, 1572864 bytes, vmalloc)
> 2025-05-21T10:35:36.856734+00:00 mc-misc2002 kernel: [    8.229656] UDP h=
ash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T10:35:36.856735+00:00 mc-misc2002 kernel: [    8.238099] UDP-L=
ite hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T10:35:36.856735+00:00 mc-misc2002 kernel: [    8.246813] NET: =
Registered PF_UNIX/PF_LOCAL protocol family
> 2025-05-21T10:35:36.856739+00:00 mc-misc2002 kernel: [    8.253175] NET: =
Registered PF_XDP protocol family
> 2025-05-21T10:35:36.856739+00:00 mc-misc2002 kernel: [    8.258573] pci 0=
000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
> 2025-05-21T10:35:36.856739+00:00 mc-misc2002 kernel: [    8.267754] pci 0=
000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 0=
1] add_size 200000 add_align 100000
> 2025-05-21T10:35:36.856740+00:00 mc-misc2002 kernel: [    8.280643] pci 0=
000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 01] add_size=
 200000 add_align 100000
> 2025-05-21T10:35:36.856740+00:00 mc-misc2002 kernel: [    8.292465] pci 0=
000:00:1c.0: BAR 14: assigned [mem 0x90000000-0x901fffff]
> 2025-05-21T10:35:36.856740+00:00 mc-misc2002 kernel: [    8.300186] pci 0=
000:00:1c.0: BAR 15: assigned [mem 0x200000000000-0x2000001fffff 64bit pref]
> 2025-05-21T10:35:36.856744+00:00 mc-misc2002 kernel: [    8.309759] pci 0=
000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
> 2025-05-21T10:35:36.856745+00:00 mc-misc2002 kernel: [    8.316699] pci 0=
000:00:1f.4: BAR 0: assigned [mem 0x200000200000-0x2000002000ff 64bit]
> 2025-05-21T10:35:36.856745+00:00 mc-misc2002 kernel: [    8.325695] pci 0=
000:00:1c.0: PCI bridge to [bus 01]
> 2025-05-21T10:35:36.856745+00:00 mc-misc2002 kernel: [    8.331269] pci 0=
000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> 2025-05-21T10:35:36.856746+00:00 mc-misc2002 kernel: [    8.338114] pci 0=
000:00:1c.0:   bridge window [mem 0x90000000-0x901fffff]
> 2025-05-21T10:35:36.856746+00:00 mc-misc2002 kernel: [    8.345735] pci 0=
000:00:1c.0:   bridge window [mem 0x200000000000-0x2000001fffff 64bit pref]
> 2025-05-21T10:35:36.856750+00:00 mc-misc2002 kernel: [    8.355214] pci 0=
000:00:1c.4: PCI bridge to [bus 02]
> 2025-05-21T10:35:36.856750+00:00 mc-misc2002 kernel: [    8.360797] pci 0=
000:03:00.0: PCI bridge to [bus 04]
> 2025-05-21T10:35:36.856750+00:00 mc-misc2002 kernel: [    8.366372] pci 0=
000:03:00.0:   bridge window [io  0x3000-0x3fff]
> 2025-05-21T10:35:36.856751+00:00 mc-misc2002 kernel: [    8.373216] pci 0=
000:03:00.0:   bridge window [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T10:35:36.856751+00:00 mc-misc2002 kernel: [    8.380847] pci 0=
000:00:1c.5: PCI bridge to [bus 03-04]
> 2025-05-21T10:35:36.856751+00:00 mc-misc2002 kernel: [    8.386713] pci 0=
000:00:1c.5:   bridge window [io  0x3000-0x3fff]
> 2025-05-21T10:35:36.856756+00:00 mc-misc2002 kernel: [    8.393555] pci 0=
000:00:1c.5:   bridge window [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T10:35:36.856756+00:00 mc-misc2002 kernel: [    8.401181] pci_b=
us 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> 2025-05-21T10:35:36.856756+00:00 mc-misc2002 kernel: [    8.408123] pci_b=
us 0000:00: resource 5 [io  0x1000-0x4fff window]
> 2025-05-21T10:35:36.856757+00:00 mc-misc2002 kernel: [    8.415061] pci_b=
us 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> 2025-05-21T10:35:36.856757+00:00 mc-misc2002 kernel: [    8.422779] pci_b=
us 0000:00: resource 7 [mem 0x000c8000-0x000cffff window]
> 2025-05-21T10:35:36.856757+00:00 mc-misc2002 kernel: [    8.430489] pci_b=
us 0000:00: resource 8 [mem 0xfe010000-0xfe010fff window]
> 2025-05-21T10:35:36.856758+00:00 mc-misc2002 kernel: [    8.438210] pci_b=
us 0000:00: resource 9 [mem 0x90000000-0x9b7fffff window]
> 2025-05-21T10:35:36.856764+00:00 mc-misc2002 kernel: [    8.445929] pci_b=
us 0000:00: resource 10 [mem 0x200000000000-0x200fffffffff window]
> 2025-05-21T10:35:36.856764+00:00 mc-misc2002 kernel: [    8.454527] pci_b=
us 0000:01: resource 0 [io  0x1000-0x1fff]
> 2025-05-21T10:35:36.856764+00:00 mc-misc2002 kernel: [    8.460781] pci_b=
us 0000:01: resource 1 [mem 0x90000000-0x901fffff]
> 2025-05-21T10:35:36.856765+00:00 mc-misc2002 kernel: [    8.467818] pci_b=
us 0000:01: resource 2 [mem 0x200000000000-0x2000001fffff 64bit pref]
> 2025-05-21T10:35:36.856765+00:00 mc-misc2002 kernel: [    8.476707] pci_b=
us 0000:03: resource 0 [io  0x3000-0x3fff]
> 2025-05-21T10:35:36.856765+00:00 mc-misc2002 kernel: [    8.482965] pci_b=
us 0000:03: resource 1 [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T10:35:36.856768+00:00 mc-misc2002 kernel: [    8.490004] pci_b=
us 0000:04: resource 0 [io  0x3000-0x3fff]
> 2025-05-21T10:35:36.856769+00:00 mc-misc2002 kernel: [    8.496260] pci_b=
us 0000:04: resource 1 [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T10:35:36.856769+00:00 mc-misc2002 kernel: [    8.503354] pci_b=
us 0000:16: resource 4 [io  0x5000-0x6fff window]
> 2025-05-21T10:35:36.856769+00:00 mc-misc2002 kernel: [    8.510292] pci_b=
us 0000:16: resource 5 [mem 0x9b800000-0xa63fffff window]
> 2025-05-21T10:35:36.856770+00:00 mc-misc2002 kernel: [    8.518010] pci_b=
us 0000:16: resource 6 [mem 0x201000000000-0x201fffffffff window]
> 2025-05-21T10:35:36.856770+00:00 mc-misc2002 kernel: [    8.526520] pci_b=
us 0000:30: resource 4 [io  0x7000-0x8fff window]
> 2025-05-21T10:35:36.856770+00:00 mc-misc2002 kernel: [    8.533460] pci_b=
us 0000:30: resource 5 [mem 0xa6400000-0xb0ffffff window]
> 2025-05-21T10:35:36.856773+00:00 mc-misc2002 kernel: [    8.541178] pci_b=
us 0000:30: resource 6 [mem 0x202000000000-0x202fffffffff window]
> 2025-05-21T10:35:36.856774+00:00 mc-misc2002 kernel: [    8.549698] pci 0=
000:4a:05.0: PCI bridge to [bus 4b]
> 2025-05-21T10:35:36.856774+00:00 mc-misc2002 kernel: [    8.555272] pci 0=
000:4a:05.0:   bridge window [io  0x9000-0x9fff]
> 2025-05-21T10:35:36.856775+00:00 mc-misc2002 kernel: [    8.562118] pci 0=
000:4a:05.0:   bridge window [mem 0xbba00000-0xbbafffff]
> 2025-05-21T10:35:36.856775+00:00 mc-misc2002 kernel: [    8.569742] pci 0=
000:4a:05.0:   bridge window [mem 0x203fffe00000-0x203fffefffff 64bit pref]
> 2025-05-21T10:35:36.856775+00:00 mc-misc2002 kernel: [    8.579217] pci_b=
us 0000:4a: resource 4 [io  0x9000-0x9fff window]
> 2025-05-21T10:35:36.856780+00:00 mc-misc2002 kernel: [    8.586157] pci_b=
us 0000:4a: resource 5 [mem 0xb1000000-0xbbbfffff window]
> 2025-05-21T10:35:36.856781+00:00 mc-misc2002 kernel: [    8.593878] pci_b=
us 0000:4a: resource 6 [mem 0x203000000000-0x203fffffffff window]
> 2025-05-21T10:35:36.856781+00:00 mc-misc2002 kernel: [    8.602377] pci_b=
us 0000:4b: resource 0 [io  0x9000-0x9fff]
> 2025-05-21T10:35:36.856781+00:00 mc-misc2002 kernel: [    8.608633] pci_b=
us 0000:4b: resource 1 [mem 0xbba00000-0xbbafffff]
> 2025-05-21T10:35:36.856782+00:00 mc-misc2002 kernel: [    8.615667] pci_b=
us 0000:4b: resource 2 [mem 0x203fffe00000-0x203fffefffff 64bit pref]
> 2025-05-21T10:35:36.856782+00:00 mc-misc2002 kernel: [    8.624576] pci 0=
000:64:02.0: bridge window [io  0x1000-0x0fff] to [bus 65] add_size 1000
> 2025-05-21T10:35:36.856785+00:00 mc-misc2002 kernel: [    8.633757] pci 0=
000:64:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6=
5] add_size 200000 add_align 100000
> 2025-05-21T10:35:36.856785+00:00 mc-misc2002 kernel: [    8.646643] pci 0=
000:64:03.0: bridge window [io  0x1000-0x0fff] to [bus 66] add_size 1000
> 2025-05-21T10:35:36.856786+00:00 mc-misc2002 kernel: [    8.655823] pci 0=
000:64:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6=
6] add_size 200000 add_align 100000
> 2025-05-21T10:35:36.856786+00:00 mc-misc2002 kernel: [    8.668703] pci 0=
000:64:04.0: bridge window [io  0x1000-0x0fff] to [bus 67] add_size 1000
> 2025-05-21T10:35:36.856786+00:00 mc-misc2002 kernel: [    8.677886] pci 0=
000:64:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6=
7] add_size 200000 add_align 100000
> 2025-05-21T10:35:36.856787+00:00 mc-misc2002 kernel: [    8.690774] pci 0=
000:64:05.0: bridge window [io  0x1000-0x0fff] to [bus 68] add_size 1000
> 2025-05-21T10:35:36.856790+00:00 mc-misc2002 kernel: [    8.699956] pci 0=
000:64:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6=
8] add_size 200000 add_align 100000
> 2025-05-21T10:35:36.856790+00:00 mc-misc2002 kernel: [    8.712849] pci 0=
000:64:02.0: BAR 15: assigned [mem 0x204000000000-0x2040001fffff 64bit pref]
> 2025-05-21T10:35:36.856791+00:00 mc-misc2002 kernel: [    8.722425] pci 0=
000:64:03.0: BAR 15: assigned [mem 0x204000200000-0x2040003fffff 64bit pref]
> 2025-05-21T10:35:36.856791+00:00 mc-misc2002 kernel: [    8.731998] pci 0=
000:64:04.0: BAR 15: assigned [mem 0x204000400000-0x2040005fffff 64bit pref]
> 2025-05-21T10:35:36.856791+00:00 mc-misc2002 kernel: [    8.741573] pci 0=
000:64:05.0: BAR 15: assigned [mem 0x204000600000-0x2040007fffff 64bit pref]
> 2025-05-21T10:35:36.856792+00:00 mc-misc2002 kernel: [    8.751151] pci 0=
000:64:02.0: BAR 13: assigned [io  0xa000-0xafff]
> 2025-05-21T10:35:36.856794+00:00 mc-misc2002 kernel: [    8.758091] pci 0=
000:64:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:35:36.856795+00:00 mc-misc2002 kernel: [    8.765227] pci 0=
000:64:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:35:36.856795+00:00 mc-misc2002 kernel: [    8.772765] pci 0=
000:64:04.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:35:36.856795+00:00 mc-misc2002 kernel: [    8.779906] pci 0=
000:64:04.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:35:36.856796+00:00 mc-misc2002 kernel: [    8.787437] pci 0=
000:64:05.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:35:36.856796+00:00 mc-misc2002 kernel: [    8.794565] pci 0=
000:64:05.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:35:36.856796+00:00 mc-misc2002 kernel: [    8.802091] pci 0=
000:64:05.0: BAR 13: assigned [io  0xa000-0xafff]
> 2025-05-21T10:35:36.856799+00:00 mc-misc2002 kernel: [    8.809031] pci 0=
000:64:04.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:35:36.856800+00:00 mc-misc2002 kernel: [    8.816164] pci 0=
000:64:04.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:35:36.856800+00:00 mc-misc2002 kernel: [    8.823687] pci 0=
000:64:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:35:36.856800+00:00 mc-misc2002 kernel: [    8.830820] pci 0=
000:64:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:35:36.856801+00:00 mc-misc2002 kernel: [    8.838344] pci 0=
000:64:02.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:35:36.856801+00:00 mc-misc2002 kernel: [    8.845479] pci 0=
000:64:02.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:35:36.856804+00:00 mc-misc2002 kernel: [    8.853003] pci 0=
000:64:02.0: PCI bridge to [bus 65]
> 2025-05-21T10:35:36.856804+00:00 mc-misc2002 kernel: [    8.858580] pci 0=
000:64:02.0:   bridge window [mem 0xc5e00000-0xc5efffff]
> 2025-05-21T10:35:36.856805+00:00 mc-misc2002 kernel: [    8.866202] pci 0=
000:64:02.0:   bridge window [mem 0x204000000000-0x2040001fffff 64bit pref]
> 2025-05-21T10:35:36.856805+00:00 mc-misc2002 kernel: [    8.875679] pci 0=
000:64:03.0: PCI bridge to [bus 66]
> 2025-05-21T10:35:36.856805+00:00 mc-misc2002 kernel: [    8.881253] pci 0=
000:64:03.0:   bridge window [mem 0xc5d00000-0xc5dfffff]
> 2025-05-21T10:35:36.856806+00:00 mc-misc2002 kernel: [    8.888874] pci 0=
000:64:03.0:   bridge window [mem 0x204000200000-0x2040003fffff 64bit pref]
> 2025-05-21T10:35:36.856809+00:00 mc-misc2002 kernel: [    8.898352] pci 0=
000:64:04.0: PCI bridge to [bus 67]
> 2025-05-21T10:35:36.856809+00:00 mc-misc2002 kernel: [    8.903928] pci 0=
000:64:04.0:   bridge window [mem 0xc5c00000-0xc5cfffff]
> 2025-05-21T10:35:36.856810+00:00 mc-misc2002 kernel: [    8.911551] pci 0=
000:64:04.0:   bridge window [mem 0x204000400000-0x2040005fffff 64bit pref]
> 2025-05-21T10:35:36.856810+00:00 mc-misc2002 kernel: [    8.921029] pci 0=
000:64:05.0: PCI bridge to [bus 68]
> 2025-05-21T10:35:36.856810+00:00 mc-misc2002 kernel: [    8.926601] pci 0=
000:64:05.0:   bridge window [io  0xa000-0xafff]
> 2025-05-21T10:35:36.856811+00:00 mc-misc2002 kernel: [    8.933446] pci 0=
000:64:05.0:   bridge window [mem 0xc5b00000-0xc5bfffff]
> 2025-05-21T10:35:36.856811+00:00 mc-misc2002 kernel: [    8.941070] pci 0=
000:64:05.0:   bridge window [mem 0x204000600000-0x2040007fffff 64bit pref]
> 2025-05-21T10:35:36.856814+00:00 mc-misc2002 kernel: [    8.950546] pci_b=
us 0000:64: resource 4 [io  0xa000-0xafff window]
> 2025-05-21T10:35:36.856814+00:00 mc-misc2002 kernel: [    8.957484] pci_b=
us 0000:64: resource 5 [mem 0xbbc00000-0xc5ffffff window]
> 2025-05-21T10:35:36.856814+00:00 mc-misc2002 kernel: [    8.965193] pci_b=
us 0000:64: resource 6 [mem 0x204000000000-0x204fffffffff window]
> 2025-05-21T10:35:36.856815+00:00 mc-misc2002 kernel: [    8.973682] pci_b=
us 0000:65: resource 1 [mem 0xc5e00000-0xc5efffff]
> 2025-05-21T10:35:36.856815+00:00 mc-misc2002 kernel: [    8.980710] pci_b=
us 0000:65: resource 2 [mem 0x204000000000-0x2040001fffff 64bit pref]
> 2025-05-21T10:35:36.856815+00:00 mc-misc2002 kernel: [    8.989598] pci_b=
us 0000:66: resource 1 [mem 0xc5d00000-0xc5dfffff]
> 2025-05-21T10:35:36.856818+00:00 mc-misc2002 kernel: [    8.996635] pci_b=
us 0000:66: resource 2 [mem 0x204000200000-0x2040003fffff 64bit pref]
> 2025-05-21T10:35:36.856819+00:00 mc-misc2002 kernel: [    9.005522] pci_b=
us 0000:67: resource 1 [mem 0xc5c00000-0xc5cfffff]
> 2025-05-21T10:35:36.856819+00:00 mc-misc2002 kernel: [    9.012558] pci_b=
us 0000:67: resource 2 [mem 0x204000400000-0x2040005fffff 64bit pref]
> 2025-05-21T10:35:36.856819+00:00 mc-misc2002 kernel: [    9.021449] pci_b=
us 0000:68: resource 0 [io  0xa000-0xafff]
> 2025-05-21T10:35:36.856820+00:00 mc-misc2002 kernel: [    9.027704] pci_b=
us 0000:68: resource 1 [mem 0xc5b00000-0xc5bfffff]
> 2025-05-21T10:35:36.856820+00:00 mc-misc2002 kernel: [    9.034730] pci_b=
us 0000:68: resource 2 [mem 0x204000600000-0x2040007fffff 64bit pref]
> 2025-05-21T10:35:36.856820+00:00 mc-misc2002 kernel: [    9.043652] pci_b=
us 0000:80: resource 4 [io  0xb000-0xbfff window]
> 2025-05-21T10:35:36.856823+00:00 mc-misc2002 kernel: [    9.050590] pci_b=
us 0000:80: resource 5 [mem 0xc6800000-0xd0ffffff window]
> 2025-05-21T10:35:36.856823+00:00 mc-misc2002 kernel: [    9.058300] pci_b=
us 0000:80: resource 6 [mem 0x205000000000-0x205fffffffff window]
> 2025-05-21T10:35:36.856824+00:00 mc-misc2002 kernel: [    9.066806] pci 0=
000:97:04.0: PCI bridge to [bus 98]
> 2025-05-21T10:35:36.856824+00:00 mc-misc2002 kernel: [    9.072382] pci 0=
000:97:04.0:   bridge window [mem 0xdba00000-0xdbafffff]
> 2025-05-21T10:35:36.856824+00:00 mc-misc2002 kernel: [    9.080004] pci 0=
000:97:04.0:   bridge window [mem 0x206fffc00000-0x206fffefffff 64bit pref]
> 2025-05-21T10:35:36.856825+00:00 mc-misc2002 kernel: [    9.089481] pci_b=
us 0000:97: resource 4 [io  0xc000-0xcfff window]
> 2025-05-21T10:35:36.856828+00:00 mc-misc2002 kernel: [    9.096420] pci_b=
us 0000:97: resource 5 [mem 0xd1000000-0xdbbfffff window]
> 2025-05-21T10:35:36.856828+00:00 mc-misc2002 kernel: [    9.104140] pci_b=
us 0000:97: resource 6 [mem 0x206000000000-0x206fffffffff window]
> 2025-05-21T10:35:36.856828+00:00 mc-misc2002 kernel: [    9.112638] pci_b=
us 0000:98: resource 1 [mem 0xdba00000-0xdbafffff]
> 2025-05-21T10:35:36.856829+00:00 mc-misc2002 kernel: [    9.119673] pci_b=
us 0000:98: resource 2 [mem 0x206fffc00000-0x206fffefffff 64bit pref]
> 2025-05-21T10:35:36.856829+00:00 mc-misc2002 kernel: [    9.128573] pci_b=
us 0000:b0: resource 4 [io  0xd000-0xdfff window]
> 2025-05-21T10:35:36.856829+00:00 mc-misc2002 kernel: [    9.135512] pci_b=
us 0000:b0: resource 5 [mem 0xdbc00000-0xe67fffff window]
> 2025-05-21T10:35:36.856833+00:00 mc-misc2002 kernel: [    9.143230] pci_b=
us 0000:b0: resource 6 [mem 0x207000000000-0x207fffffffff window]
> 2025-05-21T10:35:36.856833+00:00 mc-misc2002 kernel: [    9.151749] pci 0=
000:c9:02.0: bridge window [io  0x1000-0x0fff] to [bus ca] add_size 1000
> 2025-05-21T10:35:36.856834+00:00 mc-misc2002 kernel: [    9.160930] pci 0=
000:c9:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus c=
a] add_size 200000 add_align 100000
> 2025-05-21T10:35:36.856834+00:00 mc-misc2002 kernel: [    9.173819] pci 0=
000:c9:03.0: bridge window [io  0x1000-0x0fff] to [bus cb] add_size 1000
> 2025-05-21T10:35:36.856835+00:00 mc-misc2002 kernel: [    9.182999] pci 0=
000:c9:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus c=
b] add_size 200000 add_align 100000
> 2025-05-21T10:35:36.856835+00:00 mc-misc2002 kernel: [    9.195888] pci 0=
000:c9:02.0: BAR 15: assigned [mem 0x208000000000-0x2080001fffff 64bit pref]
> 2025-05-21T10:35:36.856838+00:00 mc-misc2002 kernel: [    9.205459] pci 0=
000:c9:03.0: BAR 15: assigned [mem 0x208000200000-0x2080003fffff 64bit pref]
> 2025-05-21T10:35:36.856838+00:00 mc-misc2002 kernel: [    9.215030] pci 0=
000:c9:02.0: BAR 13: assigned [io  0xe000-0xefff]
> 2025-05-21T10:35:36.856839+00:00 mc-misc2002 kernel: [    9.221959] pci 0=
000:c9:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:35:36.856839+00:00 mc-misc2002 kernel: [    9.229082] pci 0=
000:c9:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:35:36.856839+00:00 mc-misc2002 kernel: [    9.236608] pci 0=
000:c9:03.0: BAR 13: assigned [io  0xe000-0xefff]
> 2025-05-21T10:35:36.856839+00:00 mc-misc2002 kernel: [    9.243546] pci 0=
000:c9:02.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:35:36.856840+00:00 mc-misc2002 kernel: [    9.250681] pci 0=
000:c9:02.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:35:36.856843+00:00 mc-misc2002 kernel: [    9.258207] pci 0=
000:c9:02.0: PCI bridge to [bus ca]
> 2025-05-21T10:35:36.856843+00:00 mc-misc2002 kernel: [    9.263783] pci 0=
000:c9:02.0:   bridge window [mem 0xf1200000-0xf12fffff]
> 2025-05-21T10:35:36.856844+00:00 mc-misc2002 kernel: [    9.271406] pci 0=
000:c9:02.0:   bridge window [mem 0x208000000000-0x2080001fffff 64bit pref]
> 2025-05-21T10:35:36.856844+00:00 mc-misc2002 kernel: [    9.280882] pci 0=
000:c9:03.0: PCI bridge to [bus cb]
> 2025-05-21T10:35:36.856844+00:00 mc-misc2002 kernel: [    9.286456] pci 0=
000:c9:03.0:   bridge window [io  0xe000-0xefff]
> 2025-05-21T10:35:36.856845+00:00 mc-misc2002 kernel: [    9.293297] pci 0=
000:c9:03.0:   bridge window [mem 0xf1100000-0xf11fffff]
> 2025-05-21T10:35:36.856848+00:00 mc-misc2002 kernel: [    9.300918] pci 0=
000:c9:03.0:   bridge window [mem 0x208000200000-0x2080003fffff 64bit pref]
> 2025-05-21T10:35:36.856848+00:00 mc-misc2002 kernel: [    9.310395] pci_b=
us 0000:c9: resource 4 [io  0xe000-0xefff window]
> 2025-05-21T10:35:36.856848+00:00 mc-misc2002 kernel: [    9.317333] pci_b=
us 0000:c9: resource 5 [mem 0xe6800000-0xf13fffff window]
> 2025-05-21T10:35:36.856849+00:00 mc-misc2002 kernel: [    9.325052] pci_b=
us 0000:c9: resource 6 [mem 0x208000000000-0x208fffffffff window]
> 2025-05-21T10:35:36.856849+00:00 mc-misc2002 kernel: [    9.333552] pci_b=
us 0000:ca: resource 1 [mem 0xf1200000-0xf12fffff]
> 2025-05-21T10:35:36.856849+00:00 mc-misc2002 kernel: [    9.340587] pci_b=
us 0000:ca: resource 2 [mem 0x208000000000-0x2080001fffff 64bit pref]
> 2025-05-21T10:35:36.856850+00:00 mc-misc2002 kernel: [    9.349468] pci_b=
us 0000:cb: resource 0 [io  0xe000-0xefff]
> 2025-05-21T10:35:36.856852+00:00 mc-misc2002 kernel: [    9.355723] pci_b=
us 0000:cb: resource 1 [mem 0xf1100000-0xf11fffff]
> 2025-05-21T10:35:36.856853+00:00 mc-misc2002 kernel: [    9.362751] pci_b=
us 0000:cb: resource 2 [mem 0x208000200000-0x2080003fffff 64bit pref]
> 2025-05-21T10:35:36.856853+00:00 mc-misc2002 kernel: [    9.371658] pci 0=
000:e2:02.0: bridge window [io  0x1000-0x0fff] to [bus e3] add_size 1000
> 2025-05-21T10:35:36.856854+00:00 mc-misc2002 kernel: [    9.380839] pci 0=
000:e2:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus e=
3] add_size 200000 add_align 100000
> 2025-05-21T10:35:36.856854+00:00 mc-misc2002 kernel: [    9.393726] pci 0=
000:e2:03.0: bridge window [io  0x1000-0x0fff] to [bus e4] add_size 1000
> 2025-05-21T10:35:36.856854+00:00 mc-misc2002 kernel: [    9.402908] pci 0=
000:e2:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus e=
4] add_size 200000 add_align 100000
> 2025-05-21T10:35:36.856857+00:00 mc-misc2002 kernel: [    9.415794] pci 0=
000:e2:04.0: bridge window [io  0x1000-0x0fff] to [bus e5] add_size 1000
> 2025-05-21T10:35:36.856857+00:00 mc-misc2002 kernel: [    9.424975] pci 0=
000:e2:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus e=
5] add_size 200000 add_align 100000
> 2025-05-21T10:35:36.856858+00:00 mc-misc2002 kernel: [    9.437862] pci 0=
000:e2:05.0: bridge window [io  0x1000-0x0fff] to [bus e6] add_size 1000
> 2025-05-21T10:35:36.856858+00:00 mc-misc2002 kernel: [    9.447042] pci 0=
000:e2:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus e=
6] add_size 200000 add_align 100000
> 2025-05-21T10:35:36.856858+00:00 mc-misc2002 kernel: [    9.459931] pci 0=
000:e2:02.0: BAR 15: assigned [mem 0x209000000000-0x2090001fffff 64bit pref]
> 2025-05-21T10:35:36.856861+00:00 mc-misc2002 kernel: [    9.469503] pci 0=
000:e2:03.0: BAR 15: assigned [mem 0x209000200000-0x2090003fffff 64bit pref]
> 2025-05-21T10:35:36.856862+00:00 mc-misc2002 kernel: [    9.479078] pci 0=
000:e2:04.0: BAR 15: assigned [mem 0x209000400000-0x2090005fffff 64bit pref]
> 2025-05-21T10:35:36.856862+00:00 mc-misc2002 kernel: [    9.488651] pci 0=
000:e2:05.0: BAR 15: assigned [mem 0x209000600000-0x2090007fffff 64bit pref]
> 2025-05-21T10:35:36.856862+00:00 mc-misc2002 kernel: [    9.498222] pci 0=
000:e2:02.0: BAR 13: assigned [io  0xf000-0xffff]
> 2025-05-21T10:35:36.856863+00:00 mc-misc2002 kernel: [    9.505162] pci 0=
000:e2:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:35:36.856863+00:00 mc-misc2002 kernel: [    9.512296] pci 0=
000:e2:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:35:36.856863+00:00 mc-misc2002 kernel: [    9.519821] pci 0=
000:e2:04.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:35:36.856866+00:00 mc-misc2002 kernel: [    9.526953] pci 0=
000:e2:04.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:35:36.856867+00:00 mc-misc2002 kernel: [    9.534467] pci 0=
000:e2:05.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:35:36.856867+00:00 mc-misc2002 kernel: [    9.541601] pci 0=
000:e2:05.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:35:36.856867+00:00 mc-misc2002 kernel: [    9.549125] pci 0=
000:e2:05.0: BAR 13: assigned [io  0xf000-0xffff]
> 2025-05-21T10:35:36.856868+00:00 mc-misc2002 kernel: [    9.556063] pci 0=
000:e2:04.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:35:36.856868+00:00 mc-misc2002 kernel: [    9.563198] pci 0=
000:e2:04.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:35:36.856871+00:00 mc-misc2002 kernel: [    9.570722] pci 0=
000:e2:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:35:36.856871+00:00 mc-misc2002 kernel: [    9.577856] pci 0=
000:e2:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:35:36.856872+00:00 mc-misc2002 kernel: [    9.585378] pci 0=
000:e2:02.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T10:35:36.856872+00:00 mc-misc2002 kernel: [    9.592504] pci 0=
000:e2:02.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T10:35:36.856872+00:00 mc-misc2002 kernel: [    9.600028] pci 0=
000:e2:02.0: PCI bridge to [bus e3]
> 2025-05-21T10:35:36.856872+00:00 mc-misc2002 kernel: [    9.605603] pci 0=
000:e2:02.0:   bridge window [mem 0xfb600000-0xfb6fffff]
> 2025-05-21T10:35:36.856873+00:00 mc-misc2002 kernel: [    9.613225] pci 0=
000:e2:02.0:   bridge window [mem 0x209000000000-0x2090001fffff 64bit pref]
> 2025-05-21T10:35:36.856876+00:00 mc-misc2002 kernel: [    9.622699] pci 0=
000:e2:03.0: PCI bridge to [bus e4]
> 2025-05-21T10:35:36.856876+00:00 mc-misc2002 kernel: [    9.628275] pci 0=
000:e2:03.0:   bridge window [mem 0xfb500000-0xfb5fffff]
> 2025-05-21T10:35:36.856877+00:00 mc-misc2002 kernel: [    9.635897] pci 0=
000:e2:03.0:   bridge window [mem 0x209000200000-0x2090003fffff 64bit pref]
> 2025-05-21T10:35:36.856877+00:00 mc-misc2002 kernel: [    9.645372] pci 0=
000:e2:04.0: PCI bridge to [bus e5]
> 2025-05-21T10:35:36.856877+00:00 mc-misc2002 kernel: [    9.650946] pci 0=
000:e2:04.0:   bridge window [mem 0xfb400000-0xfb4fffff]
> 2025-05-21T10:35:36.856877+00:00 mc-misc2002 kernel: [    9.658567] pci 0=
000:e2:04.0:   bridge window [mem 0x209000400000-0x2090005fffff 64bit pref]
> 2025-05-21T10:35:36.856881+00:00 mc-misc2002 kernel: [    9.668045] pci 0=
000:e2:05.0: PCI bridge to [bus e6]
> 2025-05-21T10:35:36.856881+00:00 mc-misc2002 kernel: [    9.673619] pci 0=
000:e2:05.0:   bridge window [io  0xf000-0xffff]
> 2025-05-21T10:35:36.856881+00:00 mc-misc2002 kernel: [    9.680461] pci 0=
000:e2:05.0:   bridge window [mem 0xfb300000-0xfb3fffff]
> 2025-05-21T10:35:36.856882+00:00 mc-misc2002 kernel: [    9.688082] pci 0=
000:e2:05.0:   bridge window [mem 0x209000600000-0x2090007fffff 64bit pref]
> 2025-05-21T10:35:36.856882+00:00 mc-misc2002 kernel: [    9.697556] pci_b=
us 0000:e2: resource 4 [io  0xf000-0xffff window]
> 2025-05-21T10:35:36.856882+00:00 mc-misc2002 kernel: [    9.704494] pci_b=
us 0000:e2: resource 5 [mem 0xf1400000-0xfb7fffff window]
> 2025-05-21T10:35:36.856885+00:00 mc-misc2002 kernel: [    9.712205] pci_b=
us 0000:e2: resource 6 [mem 0x209000000000-0x209fffffffff window]
> 2025-05-21T10:35:36.856886+00:00 mc-misc2002 kernel: [    9.720704] pci_b=
us 0000:e3: resource 1 [mem 0xfb600000-0xfb6fffff]
> 2025-05-21T10:35:36.856886+00:00 mc-misc2002 kernel: [    9.727739] pci_b=
us 0000:e3: resource 2 [mem 0x209000000000-0x2090001fffff 64bit pref]
> 2025-05-21T10:35:36.856887+00:00 mc-misc2002 kernel: [    9.736619] pci_b=
us 0000:e4: resource 1 [mem 0xfb500000-0xfb5fffff]
> 2025-05-21T10:35:36.856887+00:00 mc-misc2002 kernel: [    9.743645] pci_b=
us 0000:e4: resource 2 [mem 0x209000200000-0x2090003fffff 64bit pref]
> 2025-05-21T10:35:36.856887+00:00 mc-misc2002 kernel: [    9.752535] pci_b=
us 0000:e5: resource 1 [mem 0xfb400000-0xfb4fffff]
> 2025-05-21T10:35:36.856887+00:00 mc-misc2002 kernel: [    9.759571] pci_b=
us 0000:e5: resource 2 [mem 0x209000400000-0x2090005fffff 64bit pref]
> 2025-05-21T10:35:36.856891+00:00 mc-misc2002 kernel: [    9.768460] pci_b=
us 0000:e6: resource 0 [io  0xf000-0xffff]
> 2025-05-21T10:35:36.856891+00:00 mc-misc2002 kernel: [    9.774716] pci_b=
us 0000:e6: resource 1 [mem 0xfb300000-0xfb3fffff]
> 2025-05-21T10:35:36.856892+00:00 mc-misc2002 kernel: [    9.781754] pci_b=
us 0000:e6: resource 2 [mem 0x209000600000-0x2090007fffff 64bit pref]
> 2025-05-21T10:35:36.856892+00:00 mc-misc2002 kernel: [    9.791780] pci 0=
000:4b:00.0: CLS mismatch (64 !=3D 32), using 64 bytes
> 2025-05-21T10:35:36.856892+00:00 mc-misc2002 kernel: [    9.799205] pci 0=
000:00:1f.1: [8086:a1a0] type 00 class 0x058000
> 2025-05-21T10:35:36.856893+00:00 mc-misc2002 kernel: [    9.805975] pci 0=
000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64bit]
> 2025-05-21T10:35:36.856896+00:00 mc-misc2002 kernel: [    9.813881] Tryin=
g to unpack rootfs image as initramfs...
> 2025-05-21T10:35:36.856896+00:00 mc-misc2002 kernel: [    9.813929] DMAR:=
 No SATC found
> 2025-05-21T10:35:36.856897+00:00 mc-misc2002 kernel: [    9.823481] DMAR:=
 dmar8: Using Queued invalidation
> 2025-05-21T10:35:36.856897+00:00 mc-misc2002 kernel: [    9.828863] DMAR:=
 dmar7: Using Queued invalidation
> 2025-05-21T10:35:36.856897+00:00 mc-misc2002 kernel: [    9.834246] DMAR:=
 dmar4: Using Queued invalidation
> 2025-05-21T10:35:36.856898+00:00 mc-misc2002 kernel: [    9.839627] DMAR:=
 dmar3: Using Queued invalidation
> 2025-05-21T10:35:36.856898+00:00 mc-misc2002 kernel: [    9.845009] DMAR:=
 dmar1: Using Queued invalidation
> 2025-05-21T10:35:36.856901+00:00 mc-misc2002 kernel: [    9.850397] DMAR:=
 dmar0: Using Queued invalidation
> 2025-05-21T10:35:36.856902+00:00 mc-misc2002 kernel: [    9.855777] DMAR:=
 dmar9: Using Queued invalidation
> 2025-05-21T10:35:36.856902+00:00 mc-misc2002 kernel: [    9.861269] pci 0=
000:64:02.0: Adding to iommu group 0
> 2025-05-21T10:35:36.856902+00:00 mc-misc2002 kernel: [    9.866973] pci 0=
000:64:03.0: Adding to iommu group 1
> 2025-05-21T10:35:36.856903+00:00 mc-misc2002 kernel: [    9.872679] pci 0=
000:64:04.0: Adding to iommu group 2
> 2025-05-21T10:35:36.856903+00:00 mc-misc2002 kernel: [    9.878383] pci 0=
000:64:05.0: Adding to iommu group 3
> 2025-05-21T10:35:36.856907+00:00 mc-misc2002 kernel: [    9.884088] pci 0=
000:65:00.0: Adding to iommu group 4
> 2025-05-21T10:35:36.856907+00:00 mc-misc2002 kernel: [    9.891301] pci 0=
000:4a:05.0: Adding to iommu group 5
> 2025-05-21T10:35:36.856908+00:00 mc-misc2002 kernel: [    9.897014] pci 0=
000:4b:00.0: Adding to iommu group 6
> 2025-05-21T10:35:36.856908+00:00 mc-misc2002 kernel: [    9.902720] pci 0=
000:4b:00.1: Adding to iommu group 7
> 2025-05-21T10:35:36.856908+00:00 mc-misc2002 kernel: [    9.909442] pci 0=
000:e2:02.0: Adding to iommu group 8
> 2025-05-21T10:35:36.856909+00:00 mc-misc2002 kernel: [    9.915149] pci 0=
000:e2:03.0: Adding to iommu group 9
> 2025-05-21T10:35:36.856912+00:00 mc-misc2002 kernel: [    9.920853] pci 0=
000:e2:04.0: Adding to iommu group 10
> 2025-05-21T10:35:36.856912+00:00 mc-misc2002 kernel: [    9.926653] pci 0=
000:e2:05.0: Adding to iommu group 11
> 2025-05-21T10:35:36.856912+00:00 mc-misc2002 kernel: [    9.933528] pci 0=
000:c9:02.0: Adding to iommu group 12
> 2025-05-21T10:35:36.856913+00:00 mc-misc2002 kernel: [    9.939332] pci 0=
000:c9:03.0: Adding to iommu group 13
> 2025-05-21T10:35:36.856913+00:00 mc-misc2002 kernel: [    9.945778] pci 0=
000:97:04.0: Adding to iommu group 14
> 2025-05-21T10:35:36.856913+00:00 mc-misc2002 kernel: [    9.951584] pci 0=
000:98:00.0: Adding to iommu group 15
> 2025-05-21T10:35:36.856914+00:00 mc-misc2002 kernel: [    9.957384] pci 0=
000:98:00.1: Adding to iommu group 16
> 2025-05-21T10:35:36.856917+00:00 mc-misc2002 kernel: [    9.964102] pci 0=
000:80:01.0: Adding to iommu group 17
> 2025-05-21T10:35:36.856917+00:00 mc-misc2002 kernel: [    9.969905] pci 0=
000:80:01.1: Adding to iommu group 18
> 2025-05-21T10:35:36.856918+00:00 mc-misc2002 kernel: [    9.975697] pci 0=
000:80:01.2: Adding to iommu group 19
> 2025-05-21T10:35:36.856918+00:00 mc-misc2002 kernel: [    9.981497] pci 0=
000:80:01.3: Adding to iommu group 20
> 2025-05-21T10:35:36.856918+00:00 mc-misc2002 kernel: [    9.987297] pci 0=
000:80:01.4: Adding to iommu group 21
> 2025-05-21T10:35:36.856919+00:00 mc-misc2002 kernel: [    9.993099] pci 0=
000:80:01.5: Adding to iommu group 22
> 2025-05-21T10:35:36.856923+00:00 mc-misc2002 kernel: [    9.998900] pci 0=
000:80:01.6: Adding to iommu group 23
> 2025-05-21T10:35:36.856924+00:00 mc-misc2002 kernel: [   10.004701] pci 0=
000:80:01.7: Adding to iommu group 24
> 2025-05-21T10:35:36.856924+00:00 mc-misc2002 kernel: [   10.012888] pci 0=
000:00:00.0: Adding to iommu group 25
> 2025-05-21T10:35:36.856924+00:00 mc-misc2002 kernel: [   10.018694] pci 0=
000:00:00.1: Adding to iommu group 26
> 2025-05-21T10:35:36.856925+00:00 mc-misc2002 kernel: [   10.024494] pci 0=
000:00:00.2: Adding to iommu group 27
> 2025-05-21T10:35:36.856925+00:00 mc-misc2002 kernel: [   10.030299] pci 0=
000:00:00.4: Adding to iommu group 28
> 2025-05-21T10:35:36.856925+00:00 mc-misc2002 kernel: [   10.036101] pci 0=
000:00:01.0: Adding to iommu group 29
> 2025-05-21T10:35:36.856928+00:00 mc-misc2002 kernel: [   10.041903] pci 0=
000:00:01.1: Adding to iommu group 30
> 2025-05-21T10:35:36.856929+00:00 mc-misc2002 kernel: [   10.047703] pci 0=
000:00:01.2: Adding to iommu group 31
> 2025-05-21T10:35:36.856929+00:00 mc-misc2002 kernel: [   10.053506] pci 0=
000:00:01.3: Adding to iommu group 32
> 2025-05-21T10:35:36.856929+00:00 mc-misc2002 kernel: [   10.059309] pci 0=
000:00:01.4: Adding to iommu group 33
> 2025-05-21T10:35:36.856930+00:00 mc-misc2002 kernel: [   10.065110] pci 0=
000:00:01.5: Adding to iommu group 34
> 2025-05-21T10:35:36.856930+00:00 mc-misc2002 kernel: [   10.070909] pci 0=
000:00:01.6: Adding to iommu group 35
> 2025-05-21T10:35:36.856933+00:00 mc-misc2002 kernel: [   10.076708] pci 0=
000:00:01.7: Adding to iommu group 36
> 2025-05-21T10:35:36.856933+00:00 mc-misc2002 kernel: [   10.082589] pci 0=
000:00:02.0: Adding to iommu group 37
> 2025-05-21T10:35:36.856934+00:00 mc-misc2002 kernel: [   10.088389] pci 0=
000:00:02.1: Adding to iommu group 37
> 2025-05-21T10:35:36.856934+00:00 mc-misc2002 kernel: [   10.094192] pci 0=
000:00:02.4: Adding to iommu group 37
> 2025-05-21T10:35:36.856934+00:00 mc-misc2002 kernel: [   10.100046] pci 0=
000:00:11.0: Adding to iommu group 38
> 2025-05-21T10:35:36.856935+00:00 mc-misc2002 kernel: [   10.105842] pci 0=
000:00:11.5: Adding to iommu group 38
> 2025-05-21T10:35:36.856938+00:00 mc-misc2002 kernel: [   10.107385] Freei=
ng initrd memory: 45748K
> 2025-05-21T10:35:36.856938+00:00 mc-misc2002 kernel: [   10.111697] pci 0=
000:00:14.0: Adding to iommu group 39
> 2025-05-21T10:35:36.856938+00:00 mc-misc2002 kernel: [   10.121921] pci 0=
000:00:14.2: Adding to iommu group 39
> 2025-05-21T10:35:36.856939+00:00 mc-misc2002 kernel: [   10.127799] pci 0=
000:00:16.0: Adding to iommu group 40
> 2025-05-21T10:35:36.856939+00:00 mc-misc2002 kernel: [   10.133600] pci 0=
000:00:16.1: Adding to iommu group 40
> 2025-05-21T10:35:36.856939+00:00 mc-misc2002 kernel: [   10.139400] pci 0=
000:00:16.4: Adding to iommu group 40
> 2025-05-21T10:35:36.856940+00:00 mc-misc2002 kernel: [   10.145200] pci 0=
000:00:17.0: Adding to iommu group 41
> 2025-05-21T10:35:36.856942+00:00 mc-misc2002 kernel: [   10.151035] pci 0=
000:00:1c.0: Adding to iommu group 42
> 2025-05-21T10:35:36.856943+00:00 mc-misc2002 kernel: [   10.156837] pci 0=
000:00:1c.4: Adding to iommu group 43
> 2025-05-21T10:35:36.856943+00:00 mc-misc2002 kernel: [   10.162640] pci 0=
000:00:1c.5: Adding to iommu group 44
> 2025-05-21T10:35:36.856943+00:00 mc-misc2002 kernel: [   10.168542] pci 0=
000:00:1f.0: Adding to iommu group 45
> 2025-05-21T10:35:36.856944+00:00 mc-misc2002 kernel: [   10.174345] pci 0=
000:00:1f.2: Adding to iommu group 45
> 2025-05-21T10:35:36.856944+00:00 mc-misc2002 kernel: [   10.180148] pci 0=
000:00:1f.4: Adding to iommu group 45
> 2025-05-21T10:35:36.856947+00:00 mc-misc2002 kernel: [   10.185950] pci 0=
000:00:1f.5: Adding to iommu group 45
> 2025-05-21T10:35:36.856947+00:00 mc-misc2002 kernel: [   10.191743] pci 0=
000:03:00.0: Adding to iommu group 46
> 2025-05-21T10:35:36.856948+00:00 mc-misc2002 kernel: [   10.197517] pci 0=
000:04:00.0: Adding to iommu group 46
> 2025-05-21T10:35:36.856948+00:00 mc-misc2002 kernel: [   10.203317] pci 0=
000:16:00.0: Adding to iommu group 47
> 2025-05-21T10:35:36.856948+00:00 mc-misc2002 kernel: [   10.209119] pci 0=
000:16:00.1: Adding to iommu group 48
> 2025-05-21T10:35:36.856949+00:00 mc-misc2002 kernel: [   10.214912] pci 0=
000:16:00.2: Adding to iommu group 49
> 2025-05-21T10:35:36.856949+00:00 mc-misc2002 kernel: [   10.220713] pci 0=
000:16:00.4: Adding to iommu group 50
> 2025-05-21T10:35:36.856952+00:00 mc-misc2002 kernel: [   10.226513] pci 0=
000:30:00.0: Adding to iommu group 51
> 2025-05-21T10:35:36.856952+00:00 mc-misc2002 kernel: [   10.232315] pci 0=
000:30:00.1: Adding to iommu group 52
> 2025-05-21T10:35:36.856952+00:00 mc-misc2002 kernel: [   10.238108] pci 0=
000:30:00.2: Adding to iommu group 53
> 2025-05-21T10:35:36.856953+00:00 mc-misc2002 kernel: [   10.243908] pci 0=
000:30:00.4: Adding to iommu group 54
> 2025-05-21T10:35:36.856953+00:00 mc-misc2002 kernel: [   10.249711] pci 0=
000:4a:00.0: Adding to iommu group 55
> 2025-05-21T10:35:36.856953+00:00 mc-misc2002 kernel: [   10.255504] pci 0=
000:4a:00.1: Adding to iommu group 56
> 2025-05-21T10:35:36.856956+00:00 mc-misc2002 kernel: [   10.261303] pci 0=
000:4a:00.2: Adding to iommu group 57
> 2025-05-21T10:35:36.856957+00:00 mc-misc2002 kernel: [   10.267104] pci 0=
000:4a:00.4: Adding to iommu group 58
> 2025-05-21T10:35:36.856957+00:00 mc-misc2002 kernel: [   10.272905] pci 0=
000:64:00.0: Adding to iommu group 59
> 2025-05-21T10:35:36.856957+00:00 mc-misc2002 kernel: [   10.278707] pci 0=
000:64:00.1: Adding to iommu group 60
> 2025-05-21T10:35:36.856958+00:00 mc-misc2002 kernel: [   10.284510] pci 0=
000:64:00.2: Adding to iommu group 61
> 2025-05-21T10:35:36.856958+00:00 mc-misc2002 kernel: [   10.290310] pci 0=
000:64:00.4: Adding to iommu group 62
> 2025-05-21T10:35:36.856961+00:00 mc-misc2002 kernel: [   10.296112] pci 0=
000:7e:00.0: Adding to iommu group 63
> 2025-05-21T10:35:36.856961+00:00 mc-misc2002 kernel: [   10.301914] pci 0=
000:7e:00.1: Adding to iommu group 64
> 2025-05-21T10:35:36.856961+00:00 mc-misc2002 kernel: [   10.307716] pci 0=
000:7e:00.2: Adding to iommu group 65
> 2025-05-21T10:35:36.856962+00:00 mc-misc2002 kernel: [   10.313508] pci 0=
000:7e:00.3: Adding to iommu group 66
> 2025-05-21T10:35:36.856962+00:00 mc-misc2002 kernel: [   10.319306] pci 0=
000:7e:00.5: Adding to iommu group 67
> 2025-05-21T10:35:36.856962+00:00 mc-misc2002 kernel: [   10.325107] pci 0=
000:7e:02.0: Adding to iommu group 68
> 2025-05-21T10:35:36.856963+00:00 mc-misc2002 kernel: [   10.330906] pci 0=
000:7e:02.1: Adding to iommu group 69
> 2025-05-21T10:35:36.856966+00:00 mc-misc2002 kernel: [   10.336707] pci 0=
000:7e:02.2: Adding to iommu group 70
> 2025-05-21T10:35:36.856966+00:00 mc-misc2002 kernel: [   10.342508] pci 0=
000:7e:04.0: Adding to iommu group 71
> 2025-05-21T10:35:36.856966+00:00 mc-misc2002 kernel: [   10.348310] pci 0=
000:7e:04.1: Adding to iommu group 72
> 2025-05-21T10:35:36.856967+00:00 mc-misc2002 kernel: [   10.354100] pci 0=
000:7e:04.2: Adding to iommu group 73
> 2025-05-21T10:35:36.856967+00:00 mc-misc2002 kernel: [   10.359900] pci 0=
000:7e:04.3: Adding to iommu group 74
> 2025-05-21T10:35:36.856967+00:00 mc-misc2002 kernel: [   10.365697] pci 0=
000:7e:05.0: Adding to iommu group 75
> 2025-05-21T10:35:36.856970+00:00 mc-misc2002 kernel: [   10.371497] pci 0=
000:7e:05.1: Adding to iommu group 76
> 2025-05-21T10:35:36.856970+00:00 mc-misc2002 kernel: [   10.377294] pci 0=
000:7e:05.2: Adding to iommu group 77
> 2025-05-21T10:35:36.856971+00:00 mc-misc2002 kernel: [   10.383094] pci 0=
000:7e:06.0: Adding to iommu group 78
> 2025-05-21T10:35:36.856971+00:00 mc-misc2002 kernel: [   10.388891] pci 0=
000:7e:06.1: Adding to iommu group 79
> 2025-05-21T10:35:36.856971+00:00 mc-misc2002 kernel: [   10.394691] pci 0=
000:7e:06.2: Adding to iommu group 80
> 2025-05-21T10:35:36.856972+00:00 mc-misc2002 kernel: [   10.400488] pci 0=
000:7e:07.0: Adding to iommu group 81
> 2025-05-21T10:35:36.856972+00:00 mc-misc2002 kernel: [   10.406288] pci 0=
000:7e:07.1: Adding to iommu group 82
> 2025-05-21T10:35:36.856975+00:00 mc-misc2002 kernel: [   10.412086] pci 0=
000:7e:07.2: Adding to iommu group 83
> 2025-05-21T10:35:36.856975+00:00 mc-misc2002 kernel: [   10.417962] pci 0=
000:7e:0b.0: Adding to iommu group 84
> 2025-05-21T10:35:36.856976+00:00 mc-misc2002 kernel: [   10.423768] pci 0=
000:7e:0b.1: Adding to iommu group 84
> 2025-05-21T10:35:36.856976+00:00 mc-misc2002 kernel: [   10.429574] pci 0=
000:7e:0b.2: Adding to iommu group 84
> 2025-05-21T10:35:36.856976+00:00 mc-misc2002 kernel: [   10.435373] pci 0=
000:7e:0c.0: Adding to iommu group 85
> 2025-05-21T10:35:36.856976+00:00 mc-misc2002 kernel: [   10.441171] pci 0=
000:7e:0d.0: Adding to iommu group 86
> 2025-05-21T10:35:36.856980+00:00 mc-misc2002 kernel: [   10.446981] pci 0=
000:7e:0e.0: Adding to iommu group 87
> 2025-05-21T10:35:36.856981+00:00 mc-misc2002 kernel: [   10.452781] pci 0=
000:7e:0f.0: Adding to iommu group 88
> 2025-05-21T10:35:36.856981+00:00 mc-misc2002 kernel: [   10.458580] pci 0=
000:7e:1a.0: Adding to iommu group 89
> 2025-05-21T10:35:36.856982+00:00 mc-misc2002 kernel: [   10.464380] pci 0=
000:7e:1b.0: Adding to iommu group 90
> 2025-05-21T10:35:36.856982+00:00 mc-misc2002 kernel: [   10.470181] pci 0=
000:7e:1c.0: Adding to iommu group 91
> 2025-05-21T10:35:36.856982+00:00 mc-misc2002 kernel: [   10.475979] pci 0=
000:7e:1d.0: Adding to iommu group 92
> 2025-05-21T10:35:36.856985+00:00 mc-misc2002 kernel: [   10.481779] pci 0=
000:7f:00.0: Adding to iommu group 93
> 2025-05-21T10:35:36.856985+00:00 mc-misc2002 kernel: [   10.487578] pci 0=
000:7f:00.1: Adding to iommu group 94
> 2025-05-21T10:35:36.856986+00:00 mc-misc2002 kernel: [   10.493376] pci 0=
000:7f:00.2: Adding to iommu group 95
> 2025-05-21T10:35:36.856986+00:00 mc-misc2002 kernel: [   10.499176] pci 0=
000:7f:00.3: Adding to iommu group 96
> 2025-05-21T10:35:36.856986+00:00 mc-misc2002 kernel: [   10.504975] pci 0=
000:7f:00.4: Adding to iommu group 97
> 2025-05-21T10:35:36.856987+00:00 mc-misc2002 kernel: [   10.510774] pci 0=
000:7f:00.5: Adding to iommu group 98
> 2025-05-21T10:35:36.856987+00:00 mc-misc2002 kernel: [   10.516575] pci 0=
000:7f:00.6: Adding to iommu group 99
> 2025-05-21T10:35:36.856990+00:00 mc-misc2002 kernel: [   10.522374] pci 0=
000:7f:00.7: Adding to iommu group 100
> 2025-05-21T10:35:36.856990+00:00 mc-misc2002 kernel: [   10.528271] pci 0=
000:7f:01.0: Adding to iommu group 101
> 2025-05-21T10:35:36.856991+00:00 mc-misc2002 kernel: [   10.534169] pci 0=
000:7f:01.1: Adding to iommu group 102
> 2025-05-21T10:35:36.856991+00:00 mc-misc2002 kernel: [   10.540066] pci 0=
000:7f:01.2: Adding to iommu group 103
> 2025-05-21T10:35:36.856991+00:00 mc-misc2002 kernel: [   10.545962] pci 0=
000:7f:01.3: Adding to iommu group 104
> 2025-05-21T10:35:36.856991+00:00 mc-misc2002 kernel: [   10.551860] pci 0=
000:7f:0a.0: Adding to iommu group 105
> 2025-05-21T10:35:36.856994+00:00 mc-misc2002 kernel: [   10.557757] pci 0=
000:7f:0a.1: Adding to iommu group 106
> 2025-05-21T10:35:36.856995+00:00 mc-misc2002 kernel: [   10.563653] pci 0=
000:7f:0a.2: Adding to iommu group 107
> 2025-05-21T10:35:36.856995+00:00 mc-misc2002 kernel: [   10.569550] pci 0=
000:7f:0a.3: Adding to iommu group 108
> 2025-05-21T10:35:36.856995+00:00 mc-misc2002 kernel: [   10.575447] pci 0=
000:7f:0a.4: Adding to iommu group 109
> 2025-05-21T10:35:36.856996+00:00 mc-misc2002 kernel: [   10.581341] pci 0=
000:7f:0a.5: Adding to iommu group 110
> 2025-05-21T10:35:36.856996+00:00 mc-misc2002 kernel: [   10.587238] pci 0=
000:7f:0a.6: Adding to iommu group 111
> 2025-05-21T10:35:36.856996+00:00 mc-misc2002 kernel: [   10.593135] pci 0=
000:7f:0a.7: Adding to iommu group 112
> 2025-05-21T10:35:36.856999+00:00 mc-misc2002 kernel: [   10.599032] pci 0=
000:7f:0b.0: Adding to iommu group 113
> 2025-05-21T10:35:36.856999+00:00 mc-misc2002 kernel: [   10.604928] pci 0=
000:7f:0b.1: Adding to iommu group 114
> 2025-05-21T10:35:36.857000+00:00 mc-misc2002 kernel: [   10.610827] pci 0=
000:7f:0b.2: Adding to iommu group 115
> 2025-05-21T10:35:36.857000+00:00 mc-misc2002 kernel: [   10.616724] pci 0=
000:7f:0b.3: Adding to iommu group 116
> 2025-05-21T10:35:36.857000+00:00 mc-misc2002 kernel: [   10.622619] pci 0=
000:7f:1d.0: Adding to iommu group 117
> 2025-05-21T10:35:36.857001+00:00 mc-misc2002 kernel: [   10.628514] pci 0=
000:7f:1d.1: Adding to iommu group 118
> 2025-05-21T10:35:36.857004+00:00 mc-misc2002 kernel: [   10.634618] pci 0=
000:7f:1e.0: Adding to iommu group 119
> 2025-05-21T10:35:36.857004+00:00 mc-misc2002 kernel: [   10.640525] pci 0=
000:7f:1e.1: Adding to iommu group 119
> 2025-05-21T10:35:36.857005+00:00 mc-misc2002 kernel: [   10.646433] pci 0=
000:7f:1e.2: Adding to iommu group 119
> 2025-05-21T10:35:36.857005+00:00 mc-misc2002 kernel: [   10.652342] pci 0=
000:7f:1e.3: Adding to iommu group 119
> 2025-05-21T10:35:36.857005+00:00 mc-misc2002 kernel: [   10.658251] pci 0=
000:7f:1e.4: Adding to iommu group 119
> 2025-05-21T10:35:36.857006+00:00 mc-misc2002 kernel: [   10.664161] pci 0=
000:7f:1e.5: Adding to iommu group 119
> 2025-05-21T10:35:36.857009+00:00 mc-misc2002 kernel: [   10.670068] pci 0=
000:7f:1e.6: Adding to iommu group 119
> 2025-05-21T10:35:36.857009+00:00 mc-misc2002 kernel: [   10.675980] pci 0=
000:7f:1e.7: Adding to iommu group 119
> 2025-05-21T10:35:36.857009+00:00 mc-misc2002 kernel: [   10.681880] pci 0=
000:80:00.0: Adding to iommu group 120
> 2025-05-21T10:35:36.857009+00:00 mc-misc2002 kernel: [   10.687776] pci 0=
000:80:00.1: Adding to iommu group 121
> 2025-05-21T10:35:36.857010+00:00 mc-misc2002 kernel: [   10.693671] pci 0=
000:80:00.2: Adding to iommu group 122
> 2025-05-21T10:35:36.857010+00:00 mc-misc2002 kernel: [   10.699568] pci 0=
000:80:00.4: Adding to iommu group 123
> 2025-05-21T10:35:36.857010+00:00 mc-misc2002 kernel: [   10.705544] pci 0=
000:80:02.0: Adding to iommu group 124
> 2025-05-21T10:35:36.857013+00:00 mc-misc2002 kernel: [   10.711455] pci 0=
000:80:02.1: Adding to iommu group 124
> 2025-05-21T10:35:36.857013+00:00 mc-misc2002 kernel: [   10.717364] pci 0=
000:80:02.4: Adding to iommu group 124
> 2025-05-21T10:35:36.857014+00:00 mc-misc2002 kernel: [   10.723252] pci 0=
000:97:00.0: Adding to iommu group 125
> 2025-05-21T10:35:36.857014+00:00 mc-misc2002 kernel: [   10.729149] pci 0=
000:97:00.1: Adding to iommu group 126
> 2025-05-21T10:35:36.857014+00:00 mc-misc2002 kernel: [   10.735047] pci 0=
000:97:00.2: Adding to iommu group 127
> 2025-05-21T10:35:36.857014+00:00 mc-misc2002 kernel: [   10.740943] pci 0=
000:97:00.4: Adding to iommu group 128
> 2025-05-21T10:35:36.857017+00:00 mc-misc2002 kernel: [   10.746840] pci 0=
000:b0:00.0: Adding to iommu group 129
> 2025-05-21T10:35:36.857017+00:00 mc-misc2002 kernel: [   10.752739] pci 0=
000:b0:00.1: Adding to iommu group 130
> 2025-05-21T10:35:36.857018+00:00 mc-misc2002 kernel: [   10.758634] pci 0=
000:b0:00.2: Adding to iommu group 131
> 2025-05-21T10:35:36.857018+00:00 mc-misc2002 kernel: [   10.764529] pci 0=
000:b0:00.4: Adding to iommu group 132
> 2025-05-21T10:35:36.857018+00:00 mc-misc2002 kernel: [   10.770425] pci 0=
000:c9:00.0: Adding to iommu group 133
> 2025-05-21T10:35:36.857018+00:00 mc-misc2002 kernel: [   10.776323] pci 0=
000:c9:00.1: Adding to iommu group 134
> 2025-05-21T10:35:36.857019+00:00 mc-misc2002 kernel: [   10.782222] pci 0=
000:c9:00.2: Adding to iommu group 135
> 2025-05-21T10:35:36.857021+00:00 mc-misc2002 kernel: [   10.788117] pci 0=
000:c9:00.4: Adding to iommu group 136
> 2025-05-21T10:35:36.857023+00:00 mc-misc2002 kernel: [   10.794013] pci 0=
000:e2:00.0: Adding to iommu group 137
> 2025-05-21T10:35:36.857023+00:00 mc-misc2002 kernel: [   10.799910] pci 0=
000:e2:00.1: Adding to iommu group 138
> 2025-05-21T10:35:36.857024+00:00 mc-misc2002 kernel: [   10.805806] pci 0=
000:e2:00.2: Adding to iommu group 139
> 2025-05-21T10:35:36.857024+00:00 mc-misc2002 kernel: [   10.811701] pci 0=
000:e2:00.4: Adding to iommu group 140
> 2025-05-21T10:35:36.857024+00:00 mc-misc2002 kernel: [   10.817599] pci 0=
000:fe:00.0: Adding to iommu group 141
> 2025-05-21T10:35:36.857027+00:00 mc-misc2002 kernel: [   10.823497] pci 0=
000:fe:00.1: Adding to iommu group 142
> 2025-05-21T10:35:36.857028+00:00 mc-misc2002 kernel: [   10.829394] pci 0=
000:fe:00.2: Adding to iommu group 143
> 2025-05-21T10:35:36.857028+00:00 mc-misc2002 kernel: [   10.835291] pci 0=
000:fe:00.3: Adding to iommu group 144
> 2025-05-21T10:35:36.857028+00:00 mc-misc2002 kernel: [   10.841189] pci 0=
000:fe:00.5: Adding to iommu group 145
> 2025-05-21T10:35:36.857029+00:00 mc-misc2002 kernel: [   10.847088] pci 0=
000:fe:02.0: Adding to iommu group 146
> 2025-05-21T10:35:36.857029+00:00 mc-misc2002 kernel: [   10.852985] pci 0=
000:fe:02.1: Adding to iommu group 147
> 2025-05-21T10:35:36.857032+00:00 mc-misc2002 kernel: [   10.858881] pci 0=
000:fe:02.2: Adding to iommu group 148
> 2025-05-21T10:35:36.857032+00:00 mc-misc2002 kernel: [   10.864778] pci 0=
000:fe:04.0: Adding to iommu group 149
> 2025-05-21T10:35:36.857032+00:00 mc-misc2002 kernel: [   10.870678] pci 0=
000:fe:04.1: Adding to iommu group 150
> 2025-05-21T10:35:36.857033+00:00 mc-misc2002 kernel: [   10.876566] pci 0=
000:fe:04.2: Adding to iommu group 151
> 2025-05-21T10:35:36.857033+00:00 mc-misc2002 kernel: [   10.882464] pci 0=
000:fe:04.3: Adding to iommu group 152
> 2025-05-21T10:35:36.857033+00:00 mc-misc2002 kernel: [   10.888361] pci 0=
000:fe:05.0: Adding to iommu group 153
> 2025-05-21T10:35:36.857033+00:00 mc-misc2002 kernel: [   10.894260] pci 0=
000:fe:05.1: Adding to iommu group 154
> 2025-05-21T10:35:36.857036+00:00 mc-misc2002 kernel: [   10.900154] pci 0=
000:fe:05.2: Adding to iommu group 155
> 2025-05-21T10:35:36.857037+00:00 mc-misc2002 kernel: [   10.906052] pci 0=
000:fe:06.0: Adding to iommu group 156
> 2025-05-21T10:35:36.857037+00:00 mc-misc2002 kernel: [   10.911949] pci 0=
000:fe:06.1: Adding to iommu group 157
> 2025-05-21T10:35:36.857037+00:00 mc-misc2002 kernel: [   10.917846] pci 0=
000:fe:06.2: Adding to iommu group 158
> 2025-05-21T10:35:36.857038+00:00 mc-misc2002 kernel: [   10.923742] pci 0=
000:fe:07.0: Adding to iommu group 159
> 2025-05-21T10:35:36.857038+00:00 mc-misc2002 kernel: [   10.929638] pci 0=
000:fe:07.1: Adding to iommu group 160
> 2025-05-21T10:35:36.857041+00:00 mc-misc2002 kernel: [   10.935536] pci 0=
000:fe:07.2: Adding to iommu group 161
> 2025-05-21T10:35:36.857041+00:00 mc-misc2002 kernel: [   10.941513] pci 0=
000:fe:0b.0: Adding to iommu group 162
> 2025-05-21T10:35:36.857041+00:00 mc-misc2002 kernel: [   10.947429] pci 0=
000:fe:0b.1: Adding to iommu group 162
> 2025-05-21T10:35:36.857042+00:00 mc-misc2002 kernel: [   10.953345] pci 0=
000:fe:0b.2: Adding to iommu group 162
> 2025-05-21T10:35:36.857042+00:00 mc-misc2002 kernel: [   10.959241] pci 0=
000:fe:0c.0: Adding to iommu group 163
> 2025-05-21T10:35:36.857042+00:00 mc-misc2002 kernel: [   10.965140] pci 0=
000:fe:0d.0: Adding to iommu group 164
> 2025-05-21T10:35:36.857043+00:00 mc-misc2002 kernel: [   10.971029] pci 0=
000:fe:0e.0: Adding to iommu group 165
> 2025-05-21T10:35:36.857046+00:00 mc-misc2002 kernel: [   10.976932] pci 0=
000:fe:0f.0: Adding to iommu group 166
> 2025-05-21T10:35:36.857047+00:00 mc-misc2002 kernel: [   10.982828] pci 0=
000:fe:1a.0: Adding to iommu group 167
> 2025-05-21T10:35:36.857047+00:00 mc-misc2002 kernel: [   10.988725] pci 0=
000:fe:1b.0: Adding to iommu group 168
> 2025-05-21T10:35:36.857047+00:00 mc-misc2002 kernel: [   10.994624] pci 0=
000:fe:1c.0: Adding to iommu group 169
> 2025-05-21T10:35:36.857048+00:00 mc-misc2002 kernel: [   11.000519] pci 0=
000:fe:1d.0: Adding to iommu group 170
> 2025-05-21T10:35:36.857048+00:00 mc-misc2002 kernel: [   11.006416] pci 0=
000:ff:00.0: Adding to iommu group 171
> 2025-05-21T10:35:36.857051+00:00 mc-misc2002 kernel: [   11.012313] pci 0=
000:ff:00.1: Adding to iommu group 172
> 2025-05-21T10:35:36.857051+00:00 mc-misc2002 kernel: [   11.018212] pci 0=
000:ff:00.2: Adding to iommu group 173
> 2025-05-21T10:35:36.857051+00:00 mc-misc2002 kernel: [   11.024109] pci 0=
000:ff:00.3: Adding to iommu group 174
> 2025-05-21T10:35:36.857052+00:00 mc-misc2002 kernel: [   11.030005] pci 0=
000:ff:00.4: Adding to iommu group 175
> 2025-05-21T10:35:36.857052+00:00 mc-misc2002 kernel: [   11.035903] pci 0=
000:ff:00.5: Adding to iommu group 176
> 2025-05-21T10:35:36.857052+00:00 mc-misc2002 kernel: [   11.041803] pci 0=
000:ff:00.6: Adding to iommu group 177
> 2025-05-21T10:35:36.857055+00:00 mc-misc2002 kernel: [   11.047698] pci 0=
000:ff:00.7: Adding to iommu group 178
> 2025-05-21T10:35:36.857056+00:00 mc-misc2002 kernel: [   11.053595] pci 0=
000:ff:01.0: Adding to iommu group 179
> 2025-05-21T10:35:36.857056+00:00 mc-misc2002 kernel: [   11.059493] pci 0=
000:ff:01.1: Adding to iommu group 180
> 2025-05-21T10:35:36.857056+00:00 mc-misc2002 kernel: [   11.065393] pci 0=
000:ff:01.2: Adding to iommu group 181
> 2025-05-21T10:35:36.857056+00:00 mc-misc2002 kernel: [   11.071288] pci 0=
000:ff:01.3: Adding to iommu group 182
> 2025-05-21T10:35:36.857057+00:00 mc-misc2002 kernel: [   11.077185] pci 0=
000:ff:0a.0: Adding to iommu group 183
> 2025-05-21T10:35:36.857057+00:00 mc-misc2002 kernel: [   11.083084] pci 0=
000:ff:0a.1: Adding to iommu group 184
> 2025-05-21T10:35:36.857060+00:00 mc-misc2002 kernel: [   11.088984] pci 0=
000:ff:0a.2: Adding to iommu group 185
> 2025-05-21T10:35:36.857060+00:00 mc-misc2002 kernel: [   11.094881] pci 0=
000:ff:0a.3: Adding to iommu group 186
> 2025-05-21T10:35:36.857061+00:00 mc-misc2002 kernel: [   11.100776] pci 0=
000:ff:0a.4: Adding to iommu group 187
> 2025-05-21T10:35:36.857061+00:00 mc-misc2002 kernel: [   11.106672] pci 0=
000:ff:0a.5: Adding to iommu group 188
> 2025-05-21T10:35:36.857061+00:00 mc-misc2002 kernel: [   11.112570] pci 0=
000:ff:0a.6: Adding to iommu group 189
> 2025-05-21T10:35:36.857061+00:00 mc-misc2002 kernel: [   11.118465] pci 0=
000:ff:0a.7: Adding to iommu group 190
> 2025-05-21T10:35:36.857064+00:00 mc-misc2002 kernel: [   11.124362] pci 0=
000:ff:0b.0: Adding to iommu group 191
> 2025-05-21T10:35:36.857065+00:00 mc-misc2002 kernel: [   11.130259] pci 0=
000:ff:0b.1: Adding to iommu group 192
> 2025-05-21T10:35:36.857065+00:00 mc-misc2002 kernel: [   11.136156] pci 0=
000:ff:0b.2: Adding to iommu group 193
> 2025-05-21T10:35:36.857065+00:00 mc-misc2002 kernel: [   11.142053] pci 0=
000:ff:0b.3: Adding to iommu group 194
> 2025-05-21T10:35:36.857066+00:00 mc-misc2002 kernel: [   11.147951] pci 0=
000:ff:1d.0: Adding to iommu group 195
> 2025-05-21T10:35:36.857066+00:00 mc-misc2002 kernel: [   11.153849] pci 0=
000:ff:1d.1: Adding to iommu group 196
> 2025-05-21T10:35:36.857066+00:00 mc-misc2002 kernel: [   11.159950] pci 0=
000:ff:1e.0: Adding to iommu group 197
> 2025-05-21T10:35:36.857069+00:00 mc-misc2002 kernel: [   11.165869] pci 0=
000:ff:1e.1: Adding to iommu group 197
> 2025-05-21T10:35:36.857070+00:00 mc-misc2002 kernel: [   11.171788] pci 0=
000:ff:1e.2: Adding to iommu group 197
> 2025-05-21T10:35:36.857070+00:00 mc-misc2002 kernel: [   11.177706] pci 0=
000:ff:1e.3: Adding to iommu group 197
> 2025-05-21T10:35:36.857070+00:00 mc-misc2002 kernel: [   11.183614] pci 0=
000:ff:1e.4: Adding to iommu group 197
> 2025-05-21T10:35:36.857071+00:00 mc-misc2002 kernel: [   11.189533] pci 0=
000:ff:1e.5: Adding to iommu group 197
> 2025-05-21T10:35:36.857071+00:00 mc-misc2002 kernel: [   11.195453] pci 0=
000:ff:1e.6: Adding to iommu group 197
> 2025-05-21T10:35:36.857075+00:00 mc-misc2002 kernel: [   11.201372] pci 0=
000:ff:1e.7: Adding to iommu group 197
> 2025-05-21T10:35:36.857075+00:00 mc-misc2002 kernel: [   11.256638] DMAR:=
 Intel(R) Virtualization Technology for Directed I/O
> 2025-05-21T10:35:36.857076+00:00 mc-misc2002 kernel: [   11.263877] PCI-D=
MA: Using software bounce buffering for IO (SWIOTLB)
> 2025-05-21T10:35:36.857076+00:00 mc-misc2002 kernel: [   11.271108] softw=
are IO TLB: mapped [mem 0x00000000605ff000-0x00000000645ff000] (64MB)
> 2025-05-21T10:35:36.857076+00:00 mc-misc2002 kernel: [   11.280897] Initi=
alise system trusted keyrings
> 2025-05-21T10:35:36.857077+00:00 mc-misc2002 kernel: [   11.285896] Key t=
ype blacklist registered
> 2025-05-21T10:35:36.857081+00:00 mc-misc2002 kernel: [   11.290483] worki=
ngset: timestamp_bits=3D36 max_order=3D26 bucket_order=3D0
> 2025-05-21T10:35:36.857081+00:00 mc-misc2002 kernel: [   11.298826] zbud:=
 loaded
> 2025-05-21T10:35:36.857081+00:00 mc-misc2002 kernel: [   11.301947] integ=
rity: Platform Keyring initialized
> 2025-05-21T10:35:36.857082+00:00 mc-misc2002 kernel: [   11.307430] integ=
rity: Machine keyring initialized
> 2025-05-21T10:35:36.857082+00:00 mc-misc2002 kernel: [   11.312810] Key t=
ype asymmetric registered
> 2025-05-21T10:35:36.857082+00:00 mc-misc2002 kernel: [   11.317411] Asymm=
etric key parser 'x509' registered
> 2025-05-21T10:35:36.857083+00:00 mc-misc2002 kernel: [   11.327666] alg: =
self-tests for CTR-KDF (hmac(sha256)) passed
> 2025-05-21T10:35:36.857085+00:00 mc-misc2002 kernel: [   11.334140] Block=
 layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
> 2025-05-21T10:35:36.857086+00:00 mc-misc2002 kernel: [   11.342505] io sc=
heduler mq-deadline registered
> 2025-05-21T10:35:36.857086+00:00 mc-misc2002 kernel: [   11.349023] pciep=
ort 0000:00:1c.0: PME: Signaling with IRQ 130
> 2025-05-21T10:35:36.857086+00:00 mc-misc2002 kernel: [   11.355607] pciep=
ort 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- H=
otPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> 2025-05-21T10:35:36.857087+00:00 mc-misc2002 kernel: [   11.370985] pciep=
ort 0000:00:1c.4: PME: Signaling with IRQ 131
> 2025-05-21T10:35:36.857087+00:00 mc-misc2002 kernel: [   11.377741] pciep=
ort 0000:00:1c.5: PME: Signaling with IRQ 132
> 2025-05-21T10:35:36.857090+00:00 mc-misc2002 kernel: [   11.384456] pciep=
ort 0000:4a:05.0: PME: Signaling with IRQ 133
> 2025-05-21T10:35:36.857090+00:00 mc-misc2002 kernel: [   11.391161] pciep=
ort 0000:64:02.0: PME: Signaling with IRQ 134
> 2025-05-21T10:35:36.857090+00:00 mc-misc2002 kernel: [   11.397725] pciep=
ort 0000:64:02.0: pciehp: Slot #48 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:35:36.857091+00:00 mc-misc2002 kernel: [   11.415582] pciep=
ort 0000:64:03.0: PME: Signaling with IRQ 135
> 2025-05-21T10:35:36.857091+00:00 mc-misc2002 kernel: [   11.422147] pciep=
ort 0000:64:03.0: pciehp: Slot #49 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:35:36.857091+00:00 mc-misc2002 kernel: [   11.439992] pciep=
ort 0000:64:04.0: PME: Signaling with IRQ 136
> 2025-05-21T10:35:36.857094+00:00 mc-misc2002 kernel: [   11.446557] pciep=
ort 0000:64:04.0: pciehp: Slot #50 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:35:36.857095+00:00 mc-misc2002 kernel: [   11.464405] pciep=
ort 0000:64:05.0: PME: Signaling with IRQ 137
> 2025-05-21T10:35:36.857095+00:00 mc-misc2002 kernel: [   11.470969] pciep=
ort 0000:64:05.0: pciehp: Slot #51 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:35:36.857095+00:00 mc-misc2002 kernel: [   11.488956] pciep=
ort 0000:97:04.0: PME: Signaling with IRQ 138
> 2025-05-21T10:35:36.857096+00:00 mc-misc2002 kernel: [   11.495660] pciep=
ort 0000:c9:02.0: PME: Signaling with IRQ 139
> 2025-05-21T10:35:36.857096+00:00 mc-misc2002 kernel: [   11.502232] pciep=
ort 0000:c9:02.0: pciehp: Slot #52 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:35:36.857099+00:00 mc-misc2002 kernel: [   11.520089] pciep=
ort 0000:c9:03.0: PME: Signaling with IRQ 140
> 2025-05-21T10:35:36.857099+00:00 mc-misc2002 kernel: [   11.526655] pciep=
ort 0000:c9:03.0: pciehp: Slot #53 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:35:36.857099+00:00 mc-misc2002 kernel: [   11.544518] pciep=
ort 0000:e2:02.0: PME: Signaling with IRQ 141
> 2025-05-21T10:35:36.857100+00:00 mc-misc2002 kernel: [   11.551077] pciep=
ort 0000:e2:02.0: pciehp: Slot #54 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:35:36.857100+00:00 mc-misc2002 kernel: [   11.568925] pciep=
ort 0000:e2:03.0: PME: Signaling with IRQ 142
> 2025-05-21T10:35:36.857103+00:00 mc-misc2002 kernel: [   11.575489] pciep=
ort 0000:e2:03.0: pciehp: Slot #55 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:35:36.857103+00:00 mc-misc2002 kernel: [   11.593334] pciep=
ort 0000:e2:04.0: PME: Signaling with IRQ 143
> 2025-05-21T10:35:36.857103+00:00 mc-misc2002 kernel: [   11.599892] pciep=
ort 0000:e2:04.0: pciehp: Slot #56 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:35:36.857104+00:00 mc-misc2002 kernel: [   11.617739] pciep=
ort 0000:e2:05.0: PME: Signaling with IRQ 144
> 2025-05-21T10:35:36.857104+00:00 mc-misc2002 kernel: [   11.624303] pciep=
ort 0000:e2:05.0: pciehp: Slot #57 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T10:35:36.857104+00:00 mc-misc2002 kernel: [   11.642321] shpch=
p: Standard Hot Plug PCI Controller Driver version: 0.4
> 2025-05-21T10:35:36.857107+00:00 mc-misc2002 kernel: [   11.649972] Monit=
or-Mwait will be used to enter C-1 state
> 2025-05-21T10:35:36.857107+00:00 mc-misc2002 kernel: [   11.649984] Monit=
or-Mwait will be used to enter C-2 state
> 2025-05-21T10:35:36.857107+00:00 mc-misc2002 kernel: [   11.649991] ACPI:=
 \_SB_.SCK0.C000: Found 2 idle states
> 2025-05-21T10:35:36.857108+00:00 mc-misc2002 kernel: [   11.659940] acpi/=
hmat: Memory (0x0 length 0x80000000) Flags:0003 Processor Domain:0 Memory D=
omain:0
> 2025-05-21T10:35:36.857108+00:00 mc-misc2002 kernel: [   11.670103] acpi/=
hmat: Memory (0x100000000 length 0x1f80000000) Flags:0003 Processor Domain:=
0 Memory Domain:0
> 2025-05-21T10:35:36.857108+00:00 mc-misc2002 kernel: [   11.681234] acpi/=
hmat: Memory (0x2080000000 length 0x2000000000) Flags:0003 Processor Domain=
:1 Memory Domain:1
> 2025-05-21T10:35:36.857111+00:00 mc-misc2002 kernel: [   11.692466] acpi/=
hmat: Locality: Flags:00 Type:Read Latency Initiator Domains:2 Target Domai=
ns:2 Base:100
> 2025-05-21T10:35:36.857112+00:00 mc-misc2002 kernel: [   11.703208] acpi/=
hmat:   Initiator-Target[0-0]:7600 nsec
> 2025-05-21T10:35:36.857112+00:00 mc-misc2002 kernel: [   11.709172] acpi/=
hmat:   Initiator-Target[0-1]:13560 nsec
> 2025-05-21T10:35:36.857112+00:00 mc-misc2002 kernel: [   11.715234] acpi/=
hmat:   Initiator-Target[1-0]:13560 nsec
> 2025-05-21T10:35:36.857113+00:00 mc-misc2002 kernel: [   11.721294] acpi/=
hmat:   Initiator-Target[1-1]:7600 nsec
> 2025-05-21T10:35:36.857113+00:00 mc-misc2002 kernel: [   11.727258] acpi/=
hmat: Locality: Flags:00 Type:Write Latency Initiator Domains:2 Target Doma=
ins:2 Base:100
> 2025-05-21T10:35:36.857116+00:00 mc-misc2002 kernel: [   11.738097] acpi/=
hmat:   Initiator-Target[0-0]:7600 nsec
> 2025-05-21T10:35:36.857117+00:00 mc-misc2002 kernel: [   11.744061] acpi/=
hmat:   Initiator-Target[0-1]:13560 nsec
> 2025-05-21T10:35:36.857117+00:00 mc-misc2002 kernel: [   11.750123] acpi/=
hmat:   Initiator-Target[1-0]:13560 nsec
> 2025-05-21T10:35:36.857117+00:00 mc-misc2002 kernel: [   11.756185] acpi/=
hmat:   Initiator-Target[1-1]:7600 nsec
> 2025-05-21T10:35:36.857117+00:00 mc-misc2002 kernel: [   11.762151] acpi/=
hmat: Locality: Flags:00 Type:Read Bandwidth Initiator Domains:2 Target Dom=
ains:2 Base:1
> 2025-05-21T10:35:36.857118+00:00 mc-misc2002 kernel: [   11.772894] acpi/=
hmat:   Initiator-Target[0-0]:1790 MB/s
> 2025-05-21T10:35:36.857121+00:00 mc-misc2002 kernel: [   11.778858] acpi/=
hmat:   Initiator-Target[0-1]:1790 MB/s
> 2025-05-21T10:35:36.857121+00:00 mc-misc2002 kernel: [   11.784820] acpi/=
hmat:   Initiator-Target[1-0]:1790 MB/s
> 2025-05-21T10:35:36.857121+00:00 mc-misc2002 kernel: [   11.790785] acpi/=
hmat:   Initiator-Target[1-1]:1790 MB/s
> 2025-05-21T10:35:36.857122+00:00 mc-misc2002 kernel: [   11.796748] acpi/=
hmat: Locality: Flags:00 Type:Write Bandwidth Initiator Domains:2 Target Do=
mains:2 Base:1
> 2025-05-21T10:35:36.857122+00:00 mc-misc2002 kernel: [   11.807587] acpi/=
hmat:   Initiator-Target[0-0]:1910 MB/s
> 2025-05-21T10:35:36.857122+00:00 mc-misc2002 kernel: [   11.813549] acpi/=
hmat:   Initiator-Target[0-1]:1910 MB/s
> 2025-05-21T10:35:36.857125+00:00 mc-misc2002 kernel: [   11.819512] acpi/=
hmat:   Initiator-Target[1-0]:1910 MB/s
> 2025-05-21T10:35:36.857125+00:00 mc-misc2002 kernel: [   11.825466] acpi/=
hmat:   Initiator-Target[1-1]:1910 MB/s
> 2025-05-21T10:35:36.857125+00:00 mc-misc2002 kernel: [   11.831673] ERST:=
 Error Record Serialization Table (ERST) support is initialized.
> 2025-05-21T10:35:36.857126+00:00 mc-misc2002 kernel: [   11.840078] pstor=
e: Registered erst as persistent store backend
> 2025-05-21T10:35:36.857126+00:00 mc-misc2002 kernel: [   11.847014] Seria=
l: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 2025-05-21T10:35:36.857126+00:00 mc-misc2002 kernel: [   11.854301] 00:03=
: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) is a 16550A
> 2025-05-21T10:35:36.857129+00:00 mc-misc2002 kernel: [   11.876606] 00:04=
: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) is a 16550A
> 2025-05-21T10:35:36.857130+00:00 mc-misc2002 kernel: [   11.898595] Linux=
 agpgart interface v0.103
> 2025-05-21T10:35:36.857130+00:00 mc-misc2002 kernel: [   11.903391] AMD-V=
i: AMD IOMMUv2 functionality not available on this system - This is not a b=
ug.
> 2025-05-21T10:35:36.857130+00:00 mc-misc2002 kernel: [   11.916777] i8042=
: PNP: No PS/2 controller found.
> 2025-05-21T10:35:36.857131+00:00 mc-misc2002 kernel: [   11.922128] mouse=
dev: PS/2 mouse device common for all mice
> 2025-05-21T10:35:36.857131+00:00 mc-misc2002 kernel: [   11.928396] rtc_c=
mos 00:00: RTC can wake from S4
> 2025-05-21T10:35:36.857131+00:00 mc-misc2002 kernel: [   11.934025] rtc_c=
mos 00:00: registered as rtc0
> 2025-05-21T10:35:36.857134+00:00 mc-misc2002 kernel: [   11.939097] rtc_c=
mos 00:00: setting system clock to 2025-05-21T10:35:23 UTC (1747823723)
> 2025-05-21T10:35:36.857134+00:00 mc-misc2002 kernel: [   11.948211] rtc_c=
mos 00:00: alarms up to one month, y3k, 114 bytes nvram
> 2025-05-21T10:35:36.857134+00:00 mc-misc2002 kernel: [   11.957597] intel=
_pstate: Intel P-state driver initializing
> 2025-05-21T10:35:36.857135+00:00 mc-misc2002 kernel: [   11.974138] ledtr=
ig-cpu: registered to indicate activity on CPUs
> 2025-05-21T10:35:36.857135+00:00 mc-misc2002 kernel: [   11.990271] NET: =
Registered PF_INET6 protocol family
> 2025-05-21T10:35:36.857135+00:00 mc-misc2002 kernel: [   12.002887] Segme=
nt Routing with IPv6
> 2025-05-21T10:35:36.857138+00:00 mc-misc2002 kernel: [   12.007010] In-si=
tu OAM (IOAM) with IPv6
> 2025-05-21T10:35:36.857138+00:00 mc-misc2002 kernel: [   12.011429] mip6:=
 Mobile IPv6
> 2025-05-21T10:35:36.857139+00:00 mc-misc2002 kernel: [   12.014760] NET: =
Registered PF_PACKET protocol family
> 2025-05-21T10:35:36.857139+00:00 mc-misc2002 kernel: [   12.020578] mpls_=
gso: MPLS GSO support
> 2025-05-21T10:35:36.857139+00:00 mc-misc2002 kernel: [   12.037886] micro=
code: sig=3D0x606a6, pf=3D0x1, revision=3D0xd000404
> 2025-05-21T10:35:36.857139+00:00 mc-misc2002 kernel: [   12.045366] micro=
code: Microcode Update Driver: v2.2.
> 2025-05-21T10:35:36.857142+00:00 mc-misc2002 kernel: [   12.046337] resct=
rl: L3 allocation detected
> 2025-05-21T10:35:36.857142+00:00 mc-misc2002 kernel: [   12.056713] resct=
rl: MB allocation detected
> 2025-05-21T10:35:36.857143+00:00 mc-misc2002 kernel: [   12.061410] resct=
rl: L3 monitoring detected
> 2025-05-21T10:35:36.857143+00:00 mc-misc2002 kernel: [   12.066110] IPI s=
horthand broadcast: enabled
> 2025-05-21T10:35:36.857143+00:00 mc-misc2002 kernel: [   12.070928] sched=
_clock: Marking stable (10386253391, 1684648975)->(12691726091, -620823725)
> 2025-05-21T10:35:36.857144+00:00 mc-misc2002 kernel: [   12.081725] regis=
tered taskstats version 1
> 2025-05-21T10:35:36.857144+00:00 mc-misc2002 kernel: [   12.086337] Loadi=
ng compiled-in X.509 certificates
> 2025-05-21T10:35:36.857146+00:00 mc-misc2002 kernel: [   12.113099] Loade=
d X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419e=
a1'
> 2025-05-21T10:35:36.857147+00:00 mc-misc2002 kernel: [   12.122890] Loade=
d X.509 cert 'Debian Secure Boot Signer 2022 - linux: 14011249c2675ea8e5148=
542202005810584b25f'
> 2025-05-21T10:35:36.857147+00:00 mc-misc2002 kernel: [   12.139274] zswap=
: loaded using pool lzo/zbud
> 2025-05-21T10:35:36.857147+00:00 mc-misc2002 kernel: [   12.144679] Key t=
ype .fscrypt registered
> 2025-05-21T10:35:36.857148+00:00 mc-misc2002 kernel: [   12.149085] Key t=
ype fscrypt-provisioning registered
> 2025-05-21T10:35:36.857148+00:00 mc-misc2002 kernel: [   12.155052] pstor=
e: Using crash dump compression: deflate
> 2025-05-21T10:35:36.857151+00:00 mc-misc2002 kernel: [   12.166333] Key t=
ype encrypted registered
> 2025-05-21T10:35:36.857151+00:00 mc-misc2002 kernel: [   12.170839] AppAr=
mor: AppArmor sha1 policy hashing enabled
> 2025-05-21T10:35:36.857151+00:00 mc-misc2002 kernel: [   12.177006] ima: =
No TPM chip found, activating TPM-bypass!
> 2025-05-21T10:35:36.857151+00:00 mc-misc2002 kernel: [   12.183159] ima: =
Allocated hash algorithm: sha256
> 2025-05-21T10:35:36.857152+00:00 mc-misc2002 kernel: [   12.188447] ima: =
No architecture policies found
> 2025-05-21T10:35:36.857152+00:00 mc-misc2002 kernel: [   12.193538] evm: =
Initialising EVM extended attributes:
> 2025-05-21T10:35:36.857155+00:00 mc-misc2002 kernel: [   12.199306] evm: =
security.selinux
> 2025-05-21T10:35:36.857155+00:00 mc-misc2002 kernel: [   12.203026] evm: =
security.SMACK64 (disabled)
> 2025-05-21T10:35:36.857155+00:00 mc-misc2002 kernel: [   12.207811] evm: =
security.SMACK64EXEC (disabled)
> 2025-05-21T10:35:36.857156+00:00 mc-misc2002 kernel: [   12.212996] evm: =
security.SMACK64TRANSMUTE (disabled)
> 2025-05-21T10:35:36.857156+00:00 mc-misc2002 kernel: [   12.218667] evm: =
security.SMACK64MMAP (disabled)
> 2025-05-21T10:35:36.857156+00:00 mc-misc2002 kernel: [   12.223849] evm: =
security.apparmor
> 2025-05-21T10:35:36.857156+00:00 mc-misc2002 kernel: [   12.227671] evm: =
security.ima
> 2025-05-21T10:35:36.857159+00:00 mc-misc2002 kernel: [   12.231003] evm: =
security.capability
> 2025-05-21T10:35:36.857159+00:00 mc-misc2002 kernel: [   12.235015] evm: =
HMAC attrs: 0x1
> 2025-05-21T10:35:36.857160+00:00 mc-misc2002 kernel: [   12.300675] tsc: =
Refined TSC clocksource calibration: 2100.000 MHz
> 2025-05-21T10:35:36.857160+00:00 mc-misc2002 kernel: [   12.307634] clock=
source: tsc: mask: 0xffffffffffffffff max_cycles: 0x1e4530a99b6, max_idle_n=
s: 440795257976 ns
> 2025-05-21T10:35:36.857160+00:00 mc-misc2002 kernel: [   12.319012] clock=
source: Switched to clocksource tsc
> 2025-05-21T10:35:36.857161+00:00 mc-misc2002 kernel: [   12.324952] clk: =
Disabling unused clocks
> 2025-05-21T10:35:36.857163+00:00 mc-misc2002 kernel: [   12.333425] Freei=
ng unused decrypted memory: 2036K
> 2025-05-21T10:35:36.857164+00:00 mc-misc2002 kernel: [   12.339259] Freei=
ng unused kernel image (initmem) memory: 2800K
> 2025-05-21T10:35:36.857164+00:00 mc-misc2002 kernel: [   12.345909] Write=
 protecting the kernel read-only data: 26624k
> 2025-05-21T10:35:36.857164+00:00 mc-misc2002 kernel: [   12.352976] Freei=
ng unused kernel image (text/rodata gap) memory: 2040K
> 2025-05-21T10:35:36.857165+00:00 mc-misc2002 kernel: [   12.360618] Freei=
ng unused kernel image (rodata/data gap) memory: 1148K
> 2025-05-21T10:35:36.857165+00:00 mc-misc2002 kernel: [   12.376672] x86/m=
m: Checked W+X mappings: passed, no W+X pages found.
> 2025-05-21T10:35:36.857168+00:00 mc-misc2002 kernel: [   12.383909] Run /=
init as init process
> 2025-05-21T10:35:36.857168+00:00 mc-misc2002 kernel: [   12.388018]   wit=
h arguments:
> 2025-05-21T10:35:36.857168+00:00 mc-misc2002 kernel: [   12.388019]     /=
init
> 2025-05-21T10:35:36.857169+00:00 mc-misc2002 kernel: [   12.388020]   wit=
h environment:
> 2025-05-21T10:35:36.857169+00:00 mc-misc2002 kernel: [   12.388020]     H=
OME=3D/
> 2025-05-21T10:35:36.857169+00:00 mc-misc2002 kernel: [   12.388021]     T=
ERM=3Dlinux
> 2025-05-21T10:35:36.857170+00:00 mc-misc2002 kernel: [   12.388021]     B=
OOT_IMAGE=3D/boot/vmlinuz-6.1.0-34-amd64
> 2025-05-21T10:35:36.857172+00:00 mc-misc2002 kernel: [   12.577122] dca s=
ervice started, version 1.12.1
> 2025-05-21T10:35:36.857172+00:00 mc-misc2002 kernel: [   12.583595] i801_=
smbus 0000:00:1f.4: enabling device (0001 -> 0003)
> 2025-05-21T10:35:36.857173+00:00 mc-misc2002 kernel: [   12.590771] i801_=
smbus 0000:00:1f.4: SPD Write Disable is set
> 2025-05-21T10:35:36.857173+00:00 mc-misc2002 kernel: [   12.597274] i801_=
smbus 0000:00:1f.4: SMBus using PCI interrupt
> 2025-05-21T10:35:36.857173+00:00 mc-misc2002 kernel: [   12.606425] SCSI =
subsystem initialized
> 2025-05-21T10:35:36.857174+00:00 mc-misc2002 kernel: [   12.611046] igb: =
Intel(R) Gigabit Ethernet Network Driver
> 2025-05-21T10:35:36.857177+00:00 mc-misc2002 kernel: [   12.615396] i2c i=
2c-0: 16/16 memory slots populated (from DMI)
> 2025-05-21T10:35:36.857177+00:00 mc-misc2002 kernel: [   12.617110] igb: =
Copyright (c) 2007-2014 Intel Corporation.
> 2025-05-21T10:35:36.857177+00:00 mc-misc2002 kernel: [   12.629929] i2c i=
2c-0: Systems with more than 4 memory slots not supported yet, not instanti=
ating SPD
> 2025-05-21T10:35:36.857178+00:00 mc-misc2002 kernel: [   12.640389] ACPI =
Warning: \_SB.PC04.BR4D._PRT: Return Package has no elements (empty) (20220=
331/nsprepkg-94)
> 2025-05-21T10:35:36.857178+00:00 mc-misc2002 kernel: [   12.652449] ACPI:=
 bus type USB registered
> 2025-05-21T10:35:36.857178+00:00 mc-misc2002 kernel: [   12.652591] ACPI =
Warning: \_SB.PC07.QR1C._PRT: Return Package has no elements (empty) (20220=
331/nsprepkg-94)
> 2025-05-21T10:35:36.857182+00:00 mc-misc2002 kernel: [   12.656980] usbco=
re: registered new interface driver usbfs
> 2025-05-21T10:35:36.857182+00:00 mc-misc2002 kernel: [   12.668136] bnxt_=
en 0000:98:00.0 (unnamed net_device) (uninitialized): Device requests max t=
imeout of 100 seconds, may trigger hung task watchdog
> 2025-05-21T10:35:36.857183+00:00 mc-misc2002 kernel: [   12.674165] usbco=
re: registered new interface driver hub
> 2025-05-21T10:35:36.857183+00:00 mc-misc2002 kernel: [   12.694789] usbco=
re: registered new device driver usb
> 2025-05-21T10:35:36.857183+00:00 mc-misc2002 kernel: [   12.705296] igb 0=
000:4b:00.0: added PHC on eth0
> 2025-05-21T10:35:36.857183+00:00 mc-misc2002 kernel: [   12.710252] bnxt_=
en 0000:98:00.0 eth1: Broadcom BCM57414 NetXtreme-E 10Gb/25Gb Ethernet foun=
d at mem 206fffe10000, node addr 90:5a:08:00:b7:aa
> 2025-05-21T10:35:36.857187+00:00 mc-misc2002 kernel: [   12.710401] igb 0=
000:4b:00.0: Intel(R) Gigabit Ethernet Network Connection
> 2025-05-21T10:35:36.857187+00:00 mc-misc2002 kernel: [   12.724739] bnxt_=
en 0000:98:00.0: 63.008 Gb/s available PCIe bandwidth (8.0 GT/s PCIe x8 lin=
k)
> 2025-05-21T10:35:36.857187+00:00 mc-misc2002 kernel: [   12.732453] igb 0=
000:4b:00.0: eth0: (PCIe:5.0Gb/s:Width x4) 90:5a:08:10:40:a8
> 2025-05-21T10:35:36.857188+00:00 mc-misc2002 kernel: [   12.742245] ACPI =
Warning: \_SB.PC07.QR1C._PRT: Return Package has no elements (empty) (20220=
331/nsprepkg-94)
> 2025-05-21T10:35:36.857188+00:00 mc-misc2002 kernel: [   12.750208] igb 0=
000:4b:00.0: eth0: PBA No: 010300-000
> 2025-05-21T10:35:36.857188+00:00 mc-misc2002 kernel: [   12.761291] bnxt_=
en 0000:98:00.1 (unnamed net_device) (uninitialized): Device requests max t=
imeout of 100 seconds, may trigger hung task watchdog
> 2025-05-21T10:35:36.857191+00:00 mc-misc2002 kernel: [   12.766950] igb 0=
000:4b:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> 2025-05-21T10:35:36.857191+00:00 mc-misc2002 kernel: [   12.790181] ACPI =
Warning: \_SB.PC04.BR4D._PRT: Return Package has no elements (empty) (20220=
331/nsprepkg-94)
> 2025-05-21T10:35:36.857192+00:00 mc-misc2002 kernel: [   12.802993] libat=
a version 3.00 loaded.
> 2025-05-21T10:35:36.857192+00:00 mc-misc2002 kernel: [   12.804481] bnxt_=
en 0000:98:00.1 eth2: Broadcom BCM57414 NetXtreme-E 10Gb/25Gb Ethernet foun=
d at mem 206fffe00000, node addr 90:5a:08:00:b7:ab
> 2025-05-21T10:35:36.857192+00:00 mc-misc2002 kernel: [   12.818840] bnxt_=
en 0000:98:00.1: 63.008 Gb/s available PCIe bandwidth (8.0 GT/s PCIe x8 lin=
k)
> 2025-05-21T10:35:36.857193+00:00 mc-misc2002 kernel: [   12.831725] xhci_=
hcd 0000:00:14.0: xHCI Host Controller
> 2025-05-21T10:35:36.857196+00:00 mc-misc2002 kernel: [   12.837609] xhci_=
hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> 2025-05-21T10:35:36.857196+00:00 mc-misc2002 kernel: [   12.847197] xhci_=
hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00000000=
00009810
> 2025-05-21T10:35:36.857196+00:00 mc-misc2002 kernel: [   12.858419] xhci_=
hcd 0000:00:14.0: xHCI Host Controller
> 2025-05-21T10:35:36.857197+00:00 mc-misc2002 kernel: [   12.864296] xhci_=
hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> 2025-05-21T10:35:36.857197+00:00 mc-misc2002 kernel: [   12.874682] xhci_=
hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> 2025-05-21T10:35:36.857197+00:00 mc-misc2002 kernel: [   12.881890] usb u=
sb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002, bcdDevice=3D =
6.01
> 2025-05-21T10:35:36.857200+00:00 mc-misc2002 kernel: [   12.891172] usb u=
sb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> 2025-05-21T10:35:36.857200+00:00 mc-misc2002 kernel: [   12.899282] usb u=
sb1: Product: xHCI Host Controller
> 2025-05-21T10:35:36.857201+00:00 mc-misc2002 kernel: [   12.904759] usb u=
sb1: Manufacturer: Linux 6.1.0-34-amd64 xhci-hcd
> 2025-05-21T10:35:36.857201+00:00 mc-misc2002 kernel: [   12.911603] usb u=
sb1: SerialNumber: 0000:00:14.0
> 2025-05-21T10:35:36.857201+00:00 mc-misc2002 kernel: [   12.917109] hub 1=
-0:1.0: USB hub found
> 2025-05-21T10:35:36.857202+00:00 mc-misc2002 kernel: [   12.921336] hub 1=
-0:1.0: 16 ports detected
> 2025-05-21T10:35:36.857205+00:00 mc-misc2002 kernel: [   12.924678] bnxt_=
en 0000:98:00.1 enp152s0f1np1: renamed from eth2
> 2025-05-21T10:35:36.857205+00:00 mc-misc2002 kernel: [   12.927486] usb u=
sb2: New USB device found, idVendor=3D1d6b, idProduct=3D0003, bcdDevice=3D =
6.01
> 2025-05-21T10:35:36.857205+00:00 mc-misc2002 kernel: [   12.942060] usb u=
sb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> 2025-05-21T10:35:36.857206+00:00 mc-misc2002 kernel: [   12.950171] usb u=
sb2: Product: xHCI Host Controller
> 2025-05-21T10:35:36.857206+00:00 mc-misc2002 kernel: [   12.955647] usb u=
sb2: Manufacturer: Linux 6.1.0-34-amd64 xhci-hcd
> 2025-05-21T10:35:36.857206+00:00 mc-misc2002 kernel: [   12.962487] usb u=
sb2: SerialNumber: 0000:00:14.0
> 2025-05-21T10:35:36.857206+00:00 mc-misc2002 kernel: [   12.967814] ahci =
0000:00:11.5: version 3.0
> 2025-05-21T10:35:36.857210+00:00 mc-misc2002 kernel: [   12.967995] ahci =
0000:00:11.5: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
> 2025-05-21T10:35:36.857210+00:00 mc-misc2002 kernel: [   12.977178] ahci =
0000:00:11.5: flags: 64bit ncq sntf led clo only pio slum part ems deso sad=
m sds apst=20
> 2025-05-21T10:35:36.857211+00:00 mc-misc2002 kernel: [   12.987931] bnxt_=
en 0000:98:00.0 enp152s0f0np0: renamed from eth1
> 2025-05-21T10:35:36.857211+00:00 mc-misc2002 kernel: [   12.987939] igb 0=
000:4b:00.1: added PHC on eth2
> 2025-05-21T10:35:36.857211+00:00 mc-misc2002 kernel: [   12.999870] igb 0=
000:4b:00.1: Intel(R) Gigabit Ethernet Network Connection
> 2025-05-21T10:35:36.857211+00:00 mc-misc2002 kernel: [   13.007589] igb 0=
000:4b:00.1: eth2: (PCIe:5.0Gb/s:Width x4) 90:5a:08:10:40:a9
> 2025-05-21T10:35:36.857215+00:00 mc-misc2002 kernel: [   13.015673] igb 0=
000:4b:00.1: eth2: PBA No: 010300-000
> 2025-05-21T10:35:36.857215+00:00 mc-misc2002 kernel: [   13.021439] igb 0=
000:4b:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> 2025-05-21T10:35:36.857215+00:00 mc-misc2002 kernel: [   13.029959] hub 2=
-0:1.0: USB hub found
> 2025-05-21T10:35:36.857216+00:00 mc-misc2002 kernel: [   13.034182] hub 2=
-0:1.0: 10 ports detected
> 2025-05-21T10:35:36.857216+00:00 mc-misc2002 kernel: [   13.039811] nvme =
nvme0: pci function 0000:65:00.0
> 2025-05-21T10:35:36.857216+00:00 mc-misc2002 kernel: [   13.051788] nvme =
nvme0: 48/0/0 default/read/poll queues
> 2025-05-21T10:35:36.857220+00:00 mc-misc2002 kernel: [   13.084715] igb 0=
000:4b:00.1 enp75s0f1: renamed from eth2
> 2025-05-21T10:35:36.857220+00:00 mc-misc2002 kernel: [   13.097344] scsi =
host0: ahci
> 2025-05-21T10:35:36.857221+00:00 mc-misc2002 kernel: [   13.100811] scsi =
host1: ahci
> 2025-05-21T10:35:36.857221+00:00 mc-misc2002 kernel: [   13.104196] scsi =
host2: ahci
> 2025-05-21T10:35:36.857221+00:00 mc-misc2002 kernel: [   13.107573] scsi =
host3: ahci
> 2025-05-21T10:35:36.857222+00:00 mc-misc2002 kernel: [   13.111048] scsi =
host4: ahci
> 2025-05-21T10:35:36.857222+00:00 mc-misc2002 kernel: [   13.114540] scsi =
host5: ahci
> 2025-05-21T10:35:36.857225+00:00 mc-misc2002 kernel: [   13.117812] ata1:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180100 irq 188
> 2025-05-21T10:35:36.857225+00:00 mc-misc2002 kernel: [   13.126414] ata2:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180180 irq 188
> 2025-05-21T10:35:36.857225+00:00 mc-misc2002 kernel: [   13.135032] ata3:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180200 irq 188
> 2025-05-21T10:35:36.857226+00:00 mc-misc2002 kernel: [   13.143631] ata4:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180280 irq 188
> 2025-05-21T10:35:36.857226+00:00 mc-misc2002 kernel: [   13.152227] ata5:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180300 irq 188
> 2025-05-21T10:35:36.857226+00:00 mc-misc2002 kernel: [   13.160825] ata6:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180380 irq 188
> 2025-05-21T10:35:36.857229+00:00 mc-misc2002 kernel: [   13.169839] ahci =
0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
> 2025-05-21T10:35:36.857229+00:00 mc-misc2002 kernel: [   13.179039] ahci =
0000:00:17.0: flags: 64bit ncq sntf led clo only pio slum part ems deso sad=
m sds apst=20
> 2025-05-21T10:35:36.857230+00:00 mc-misc2002 kernel: [   13.184667] igb 0=
000:4b:00.0 enp75s0f0: renamed from eth0
> 2025-05-21T10:35:36.857230+00:00 mc-misc2002 kernel: [   13.274088] scsi =
host6: ahci
> 2025-05-21T10:35:36.857230+00:00 mc-misc2002 kernel: [   13.277675] scsi =
host7: ahci
> 2025-05-21T10:35:36.857230+00:00 mc-misc2002 kernel: [   13.281214] scsi =
host8: ahci
> 2025-05-21T10:35:36.857233+00:00 mc-misc2002 kernel: [   13.284743] scsi =
host9: ahci
> 2025-05-21T10:35:36.857234+00:00 mc-misc2002 kernel: [   13.288292] scsi =
host10: ahci
> 2025-05-21T10:35:36.857234+00:00 mc-misc2002 kernel: [   13.291889] scsi =
host11: ahci
> 2025-05-21T10:35:36.857234+00:00 mc-misc2002 kernel: [   13.295441] scsi =
host12: ahci
> 2025-05-21T10:35:36.857234+00:00 mc-misc2002 kernel: [   13.298779] usb 1=
-1: new high-speed USB device number 2 using xhci_hcd
> 2025-05-21T10:35:36.857235+00:00 mc-misc2002 kernel: [   13.306498] scsi =
host13: ahci
> 2025-05-21T10:35:36.857235+00:00 mc-misc2002 kernel: [   13.309887] ata7:=
 SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100100 irq 238
> 2025-05-21T10:35:36.857238+00:00 mc-misc2002 kernel: [   13.318487] ata8:=
 SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100180 irq 238
> 2025-05-21T10:35:36.857238+00:00 mc-misc2002 kernel: [   13.327105] ata9:=
 SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100200 irq 238
> 2025-05-21T10:35:36.857238+00:00 mc-misc2002 kernel: [   13.335704] ata10=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100280 irq 238
> 2025-05-21T10:35:36.857239+00:00 mc-misc2002 kernel: [   13.344401] ata11=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100300 irq 238
> 2025-05-21T10:35:36.857239+00:00 mc-misc2002 kernel: [   13.353099] ata12=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100380 irq 238
> 2025-05-21T10:35:36.857239+00:00 mc-misc2002 kernel: [   13.361795] ata13=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100400 irq 238
> 2025-05-21T10:35:36.857242+00:00 mc-misc2002 kernel: [   13.370490] ata14=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100480 irq 238
> 2025-05-21T10:35:36.857242+00:00 mc-misc2002 kernel: [   13.457618] usb 1=
-1: New USB device found, idVendor=3D1d6b, idProduct=3D0107, bcdDevice=3D 1=
=2E00
> 2025-05-21T10:35:36.857242+00:00 mc-misc2002 kernel: [   13.466822] usb 1=
-1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> 2025-05-21T10:35:36.857243+00:00 mc-misc2002 kernel: [   13.474836] usb 1=
-1: Product: USB Virtual Hub
> 2025-05-21T10:35:36.857243+00:00 mc-misc2002 kernel: [   13.479733] usb 1=
-1: Manufacturer: Aspeed
> 2025-05-21T10:35:36.857243+00:00 mc-misc2002 kernel: [   13.482955] ata4:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:35:36.857244+00:00 mc-misc2002 kernel: [   13.484240] usb 1=
-1: SerialNumber: 00000000
> 2025-05-21T10:35:36.857246+00:00 mc-misc2002 kernel: [   13.490351] ata1:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:35:36.857246+00:00 mc-misc2002 kernel: [   13.495791] hub 1=
-1:1.0: USB hub found
> 2025-05-21T10:35:36.857247+00:00 mc-misc2002 kernel: [   13.501115] ata6:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:35:36.857247+00:00 mc-misc2002 kernel: [   13.505530] hub 1=
-1:1.0: 7 ports detected
> 2025-05-21T10:35:36.857247+00:00 mc-misc2002 kernel: [   13.511402] ata3:=
 SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 2025-05-21T10:35:36.857248+00:00 mc-misc2002 kernel: [   13.522842] ata2:=
 SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 2025-05-21T10:35:36.857252+00:00 mc-misc2002 kernel: [   13.529820] ata5:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:35:36.857252+00:00 mc-misc2002 kernel: [   13.535924] ata3.=
00: ATA-11: Micron_5400_MTFDDAK1T9TGA,  D4MU002, max UDMA/133
> 2025-05-21T10:35:36.857252+00:00 mc-misc2002 kernel: [   13.544075] ata2.=
00: ATA-11: Micron_5400_MTFDDAK1T9TGA,  D4MU002, max UDMA/133
> 2025-05-21T10:35:36.857253+00:00 mc-misc2002 kernel: [   13.555539] ata3.=
00: 3750748848 sectors, multi 16: LBA48 NCQ (depth 32), AA
> 2025-05-21T10:35:36.857253+00:00 mc-misc2002 kernel: [   13.563381] ata2.=
00: 3750748848 sectors, multi 16: LBA48 NCQ (depth 32), AA
> 2025-05-21T10:35:36.857253+00:00 mc-misc2002 kernel: [   13.571218] ata3.=
00: Features: NCQ-prio
> 2025-05-21T10:35:36.857256+00:00 mc-misc2002 kernel: [   13.575545] ata2.=
00: Features: NCQ-prio
> 2025-05-21T10:35:36.857256+00:00 mc-misc2002 kernel: [   13.585620] ata3.=
00: configured for UDMA/133
> 2025-05-21T10:35:36.857256+00:00 mc-misc2002 kernel: [   13.590443] ata2.=
00: configured for UDMA/133
> 2025-05-21T10:35:36.857257+00:00 mc-misc2002 kernel: [   13.595540] scsi =
1:0:0:0: Direct-Access     ATA      Micron_5400_MTFD U002 PQ: 0 ANSI: 5
> 2025-05-21T10:35:36.857257+00:00 mc-misc2002 kernel: [   13.605759] scsi =
2:0:0:0: Direct-Access     ATA      Micron_5400_MTFD U002 PQ: 0 ANSI: 5
> 2025-05-21T10:35:36.857257+00:00 mc-misc2002 kernel: [   13.691136] ata8:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:35:36.857258+00:00 mc-misc2002 kernel: [   13.697236] ata11=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:35:36.857260+00:00 mc-misc2002 kernel: [   13.703428] ata13=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:35:36.857260+00:00 mc-misc2002 kernel: [   13.709622] ata7:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:35:36.857261+00:00 mc-misc2002 kernel: [   13.715720] ata9:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:35:36.857261+00:00 mc-misc2002 kernel: [   13.721819] ata10=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:35:36.857261+00:00 mc-misc2002 kernel: [   13.728019] ata12=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:35:36.857262+00:00 mc-misc2002 kernel: [   13.734220] ata14=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T10:35:36.857264+00:00 mc-misc2002 kernel: [   13.751869] ata2.=
00: Enabling discard_zeroes_data
> 2025-05-21T10:35:36.857264+00:00 mc-misc2002 kernel: [   13.757187] sd 1:=
0:0:0: [sda] 3750748848 512-byte logical blocks: (1.92 TB/1.75 TiB)
> 2025-05-21T10:35:36.857265+00:00 mc-misc2002 kernel: [   13.757195] ata3.=
00: Enabling discard_zeroes_data
> 2025-05-21T10:35:36.857265+00:00 mc-misc2002 kernel: [   13.765889] sd 1:=
0:0:0: [sda] 4096-byte physical blocks
> 2025-05-21T10:35:36.857265+00:00 mc-misc2002 kernel: [   13.771199] sd 2:=
0:0:0: [sdb] 3750748848 512-byte logical blocks: (1.92 TB/1.75 TiB)
> 2025-05-21T10:35:36.857266+00:00 mc-misc2002 kernel: [   13.777054] sd 1:=
0:0:0: [sda] Write Protect is off
> 2025-05-21T10:35:36.857266+00:00 mc-misc2002 kernel: [   13.785743] sd 2:=
0:0:0: [sdb] 4096-byte physical blocks
> 2025-05-21T10:35:36.857269+00:00 mc-misc2002 kernel: [   13.791122] sd 1:=
0:0:0: [sda] Mode Sense: 00 3a 00 00
> 2025-05-21T10:35:36.857269+00:00 mc-misc2002 kernel: [   13.791137] sd 1:=
0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO=
 or FUA
> 2025-05-21T10:35:36.857269+00:00 mc-misc2002 kernel: [   13.797007] sd 2:=
0:0:0: [sdb] Write Protect is off
> 2025-05-21T10:35:36.857270+00:00 mc-misc2002 kernel: [   13.804663] usb 1=
-1.1: new high-speed USB device number 3 using xhci_hcd
> 2025-05-21T10:35:36.857270+00:00 mc-misc2002 kernel: [   13.807169] sd 1:=
0:0:0: [sda] Preferred minimum I/O size 4096 bytes
> 2025-05-21T10:35:36.857270+00:00 mc-misc2002 kernel: [   13.812541] sd 2:=
0:0:0: [sdb] Mode Sense: 00 3a 00 00
> 2025-05-21T10:35:36.857273+00:00 mc-misc2002 kernel: [   13.820502] ata2.=
00: Enabling discard_zeroes_data
> 2025-05-21T10:35:36.857273+00:00 mc-misc2002 kernel: [   13.832404] sd 2:=
0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO=
 or FUA
> 2025-05-21T10:35:36.857273+00:00 mc-misc2002 kernel: [   13.833839]  sda:=
 sda1 sda2
> 2025-05-21T10:35:36.857274+00:00 mc-misc2002 kernel: [   13.842580] sd 2:=
0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
> 2025-05-21T10:35:36.857274+00:00 mc-misc2002 kernel: [   13.845819] sd 1:=
0:0:0: [sda] Attached SCSI disk
> 2025-05-21T10:35:36.857274+00:00 mc-misc2002 kernel: [   13.853051] ata3.=
00: Enabling discard_zeroes_data
> 2025-05-21T10:35:36.857277+00:00 mc-misc2002 kernel: [   13.864591]  sdb:=
 sdb1 sdb2
> 2025-05-21T10:35:36.857277+00:00 mc-misc2002 kernel: [   13.867903] sd 2:=
0:0:0: [sdb] Attached SCSI disk
> 2025-05-21T10:35:36.857278+00:00 mc-misc2002 kernel: [   13.905684] usb 1=
-1.1: New USB device found, idVendor=3D0557, idProduct=3D9241, bcdDevice=3D=
 5.04
> 2025-05-21T10:35:36.857278+00:00 mc-misc2002 kernel: [   13.915086] usb 1=
-1.1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
> 2025-05-21T10:35:36.857278+00:00 mc-misc2002 kernel: [   13.923313] usb 1=
-1.1: Product: SMCI HID KM
> 2025-05-21T10:35:36.857278+00:00 mc-misc2002 kernel: [   13.928026] usb 1=
-1.1: Manufacturer: Linux 5.4.62 with aspeed_vhub
> 2025-05-21T10:35:36.857280+00:00 mc-misc2002 kernel: [   13.946110] hid: =
raw HID events driver (C) Jiri Kosina
> 2025-05-21T10:35:36.857281+00:00 mc-misc2002 kernel: [   13.952173] md/ra=
id1:md0: active with 2 out of 2 mirrors
> 2025-05-21T10:35:36.857282+00:00 mc-misc2002 kernel: [   13.958905] md0: =
detected capacity change from 0 to 3749898240
> 2025-05-21T10:35:36.857282+00:00 mc-misc2002 kernel: [   13.966783] usbco=
re: registered new interface driver usbhid
> 2025-05-21T10:35:36.857282+00:00 mc-misc2002 kernel: [   13.973056] usbhi=
d: USB HID core driver
> 2025-05-21T10:35:36.857283+00:00 mc-misc2002 kernel: [   13.981181] input=
: Linux 5.4.62 with aspeed_vhub SMCI HID KM as /devices/pci0000:00/0000:00:=
14.0/usb1/1-1/1-1.1/1-1.1:1.0/0003:0557:9241.0001/input/input0
> 2025-05-21T10:35:36.857283+00:00 mc-misc2002 kernel: [   14.020677] usb 1=
-1.2: new high-speed USB device number 4 using xhci_hcd
> 2025-05-21T10:35:36.857286+00:00 mc-misc2002 kernel: [   14.073886] devic=
e-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measur=
ements will not be recorded in the IMA log.
> 2025-05-21T10:35:36.857286+00:00 mc-misc2002 kernel: [   14.087631] devic=
e-mapper: uevent: version 1.0.3
> 2025-05-21T10:35:36.857286+00:00 mc-misc2002 kernel: [   14.093043] devic=
e-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
> 2025-05-21T10:35:36.857287+00:00 mc-misc2002 kernel: [   14.130418] usb 1=
-1.2: New USB device found, idVendor=3D0b1f, idProduct=3D03ee, bcdDevice=3D=
 5.04
> 2025-05-21T10:35:36.857287+00:00 mc-misc2002 kernel: [   14.139816] usb 1=
-1.2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
> 2025-05-21T10:35:36.857287+00:00 mc-misc2002 kernel: [   14.148030] usb 1=
-1.2: Product: RNDIS/Ethernet Gadget
> 2025-05-21T10:35:36.857290+00:00 mc-misc2002 kernel: [   14.153706] usb 1=
-1.2: Manufacturer: Linux 5.4.62 with aspeed_vhub
> 2025-05-21T10:35:36.857290+00:00 mc-misc2002 kernel: [   14.167725] usbco=
re: registered new interface driver cdc_ether
> 2025-05-21T10:35:36.857290+00:00 mc-misc2002 kernel: [   14.177582] rndis=
_host 1-1.2:2.0 usb0: register 'rndis_host' at usb-0000:00:14.0-1.2, RNDIS =
device, be:3a:f2:b6:05:9f
> 2025-05-21T10:35:36.857291+00:00 mc-misc2002 kernel: [   14.180808] hid-g=
eneric 0003:0557:9241.0001: input,hidraw0: USB HID v1.00 Keyboard [Linux 5.=
4.62 with aspeed_vhub SMCI HID KM] on usb-0000:00:14.0-1.1/input0
> 2025-05-21T10:35:36.857291+00:00 mc-misc2002 kernel: [   14.189523] usbco=
re: registered new interface driver rndis_host
> 2025-05-21T10:35:36.857291+00:00 mc-misc2002 kernel: [   14.205424] input=
: Linux 5.4.62 with aspeed_vhub SMCI HID KM as /devices/pci0000:00/0000:00:=
14.0/usb1/1-1/1-1.1/1-1.1:1.1/0003:0557:9241.0002/input/input1
> 2025-05-21T10:35:36.857294+00:00 mc-misc2002 kernel: [   14.227759] hid-g=
eneric 0003:0557:9241.0002: input,hidraw1: USB HID v1.00 Mouse [Linux 5.4.6=
2 with aspeed_vhub SMCI HID KM] on usb-0000:00:14.0-1.1/input1
> 2025-05-21T10:35:36.857294+00:00 mc-misc2002 kernel: [   14.230592] rndis=
_host 1-1.2:2.0 enxbe3af2b6059f: renamed from usb0
> 2025-05-21T10:35:36.857295+00:00 mc-misc2002 kernel: [   14.364667] raid6=
: avx512x4 gen() 32941 MB/s
> 2025-05-21T10:35:36.857295+00:00 mc-misc2002 kernel: [   14.436667] raid6=
: avx512x2 gen() 36986 MB/s
> 2025-05-21T10:35:36.857295+00:00 mc-misc2002 kernel: [   14.508656] raid6=
: avx512x1 gen() 34160 MB/s
> 2025-05-21T10:35:36.857296+00:00 mc-misc2002 kernel: [   14.580663] raid6=
: avx2x4   gen() 27092 MB/s
> 2025-05-21T10:35:36.857298+00:00 mc-misc2002 kernel: [   14.652655] raid6=
: avx2x2   gen() 26986 MB/s
> 2025-05-21T10:35:36.857299+00:00 mc-misc2002 kernel: [   14.724667] raid6=
: avx2x1   gen() 22974 MB/s
> 2025-05-21T10:35:36.857299+00:00 mc-misc2002 kernel: [   14.729462] raid6=
: using algorithm avx512x2 gen() 36986 MB/s
> 2025-05-21T10:35:36.857299+00:00 mc-misc2002 kernel: [   14.800653] raid6=
: .... xor() 20154 MB/s, rmw enabled
> 2025-05-21T10:35:36.857299+00:00 mc-misc2002 kernel: [   14.806324] raid6=
: using avx512x2 recovery algorithm
> 2025-05-21T10:35:36.857300+00:00 mc-misc2002 kernel: [   14.812871] xor: =
automatically using best checksumming function   avx      =20
> 2025-05-21T10:35:36.857302+00:00 mc-misc2002 kernel: [   14.822078] async=
_tx: api initialized (async)
> 2025-05-21T10:35:36.857303+00:00 mc-misc2002 kernel: [   19.977809] PM: I=
mage not found (code -22)
> 2025-05-21T10:35:36.857303+00:00 mc-misc2002 kernel: [   20.103022] EXT4-=
fs (dm-1): mounted filesystem with ordered data mode. Quota mode: none.
> 2025-05-21T10:35:36.857303+00:00 mc-misc2002 kernel: [   20.157899] Not a=
ctivating Mandatory Access Control as /sbin/tomoyo-init does not exist.
> 2025-05-21T10:35:36.857333+00:00 mc-misc2002 kernel: [   21.687103] ACPI:=
 bus type drm_connector registered
> 2025-05-21T10:35:36.857334+00:00 mc-misc2002 kernel: [   21.716549] fuse:=
 init (API version 7.38)
> 2025-05-21T10:35:36.857336+00:00 mc-misc2002 kernel: [   21.740385] loop:=
 module loaded
> 2025-05-21T10:35:36.857337+00:00 mc-misc2002 kernel: [   21.863894] IPMI =
message handler: version 39.2
> 2025-05-21T10:35:36.857337+00:00 mc-misc2002 kernel: [   21.867514] EXT4-=
fs (dm-1): re-mounted. Quota mode: none.
> 2025-05-21T10:35:36.857337+00:00 mc-misc2002 kernel: [   21.878079] ipmi =
device interface
> 2025-05-21T10:35:36.857338+00:00 mc-misc2002 kernel: [   22.755395] input=
: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> 2025-05-21T10:35:36.857338+00:00 mc-misc2002 kernel: [   22.755571] ACPI:=
 button: Power Button [PWRF]
> 2025-05-21T10:35:36.857338+00:00 mc-misc2002 kernel: [   22.755836] sd 1:=
0:0:0: Attached scsi generic sg0 type 0
> 2025-05-21T10:35:36.857341+00:00 mc-misc2002 kernel: [   22.755875] sd 2:=
0:0:0: Attached scsi generic sg1 type 0
> 2025-05-21T10:35:36.857341+00:00 mc-misc2002 kernel: [   22.801870] ipmi_=
si: IPMI System Interface driver
> 2025-05-21T10:35:36.857341+00:00 mc-misc2002 kernel: [   22.801903] ipmi_=
si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> 2025-05-21T10:35:36.857342+00:00 mc-misc2002 kernel: [   22.801906] ipmi_=
platform: ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
> 2025-05-21T10:35:36.857342+00:00 mc-misc2002 kernel: [   22.801909] ipmi_=
si: Adding SMBIOS-specified kcs state machine
> 2025-05-21T10:35:36.857342+00:00 mc-misc2002 kernel: [   22.801982] ipmi_=
si IPI0001:00: ipmi_platform: probing via ACPI
> 2025-05-21T10:35:36.857346+00:00 mc-misc2002 kernel: [   22.802136] ipmi_=
si IPI0001:00: ipmi_platform: [io  0x0ca2] regsize 1 spacing 1 irq 0
> 2025-05-21T10:35:36.857346+00:00 mc-misc2002 kernel: [   22.821300] ipmi_=
si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of A=
CPI
> 2025-05-21T10:35:36.857346+00:00 mc-misc2002 kernel: [   22.821306] ipmi_=
si: Adding ACPI-specified kcs state machine
> 2025-05-21T10:35:36.857347+00:00 mc-misc2002 kernel: [   22.821455] ipmi_=
si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave add=
ress 0x20, irq 0
> 2025-05-21T10:35:36.857347+00:00 mc-misc2002 kernel: [   22.828551] ioatd=
ma: Intel(R) QuickData Technology Driver 5.00
> 2025-05-21T10:35:36.857347+00:00 mc-misc2002 kernel: [   22.835323] iTCO_=
vendor_support: vendor-support=3D0
> 2025-05-21T10:35:36.857350+00:00 mc-misc2002 kernel: [   22.843264] input=
: PC Speaker as /devices/platform/pcspkr/input/input3
> 2025-05-21T10:35:36.857350+00:00 mc-misc2002 kernel: [   22.843641] iTCO_=
wdt iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/B=
IOS
> 2025-05-21T10:35:36.857351+00:00 mc-misc2002 kernel: [   22.849673] mei_m=
e 0000:00:16.0: Device doesn't have valid ME Interface
> 2025-05-21T10:35:36.857351+00:00 mc-misc2002 kernel: [   22.921725] Addin=
g 999420k swap on /dev/mapper/vg0-swap.  Priority:-2 extents:1 across:99942=
0k SSFS
> 2025-05-21T10:35:36.857351+00:00 mc-misc2002 kernel: [   22.937313] RAPL =
PMU: API unit is 2^-32 Joules, 2 fixed counters, 655360 ms ovfl timer
> 2025-05-21T10:35:36.857352+00:00 mc-misc2002 kernel: [   22.937321] RAPL =
PMU: hw unit of domain package 2^-14 Joules
> 2025-05-21T10:35:36.857352+00:00 mc-misc2002 kernel: [   22.937324] RAPL =
PMU: hw unit of domain dram 2^-16 Joules
> 2025-05-21T10:35:36.857355+00:00 mc-misc2002 kernel: [   22.960769] crypt=
d: max_cpu_qlen set to 1000
> 2025-05-21T10:35:36.857355+00:00 mc-misc2002 kernel: [   22.976189] ast 0=
000:04:00.0: [drm] P2A bridge disabled, using default configuration
> 2025-05-21T10:35:36.857356+00:00 mc-misc2002 kernel: [   22.976194] ast 0=
000:04:00.0: [drm] AST 2600 detected
> 2025-05-21T10:35:36.857356+00:00 mc-misc2002 kernel: [   22.981035] AVX2 =
version of gcm_enc/dec engaged.
> 2025-05-21T10:35:36.857356+00:00 mc-misc2002 kernel: [   22.981138] AES C=
TR mode by8 optimization enabled
> 2025-05-21T10:35:36.857356+00:00 mc-misc2002 kernel: [   23.063509] EDAC =
i10nm: No hbm memory
> 2025-05-21T10:35:36.857359+00:00 mc-misc2002 kernel: [   23.063555] EDAC =
MC0: Giving out device to module i10nm_edac controller Intel_10nm Socket#0 =
IMC#0: DEV 0000:7e:0c.0 (INTERRUPT)
> 2025-05-21T10:35:36.857360+00:00 mc-misc2002 kernel: [   23.063586] EDAC =
MC1: Giving out device to module i10nm_edac controller Intel_10nm Socket#0 =
IMC#1: DEV 0000:7e:0d.0 (INTERRUPT)
> 2025-05-21T10:35:36.857360+00:00 mc-misc2002 kernel: [   23.063620] EDAC =
MC2: Giving out device to module i10nm_edac controller Intel_10nm Socket#0 =
IMC#2: DEV 0000:7e:0e.0 (INTERRUPT)
> 2025-05-21T10:35:36.857361+00:00 mc-misc2002 kernel: [   23.063656] EDAC =
MC3: Giving out device to module i10nm_edac controller Intel_10nm Socket#0 =
IMC#3: DEV 0000:7e:0f.0 (INTERRUPT)
> 2025-05-21T10:35:36.857361+00:00 mc-misc2002 kernel: [   23.063686] EDAC =
MC4: Giving out device to module i10nm_edac controller Intel_10nm Socket#1 =
IMC#0: DEV 0000:fe:0c.0 (INTERRUPT)
> 2025-05-21T10:35:36.857364+00:00 mc-misc2002 kernel: [   23.063714] EDAC =
MC5: Giving out device to module i10nm_edac controller Intel_10nm Socket#1 =
IMC#1: DEV 0000:fe:0d.0 (INTERRUPT)
> 2025-05-21T10:35:36.857364+00:00 mc-misc2002 kernel: [   23.063751] EDAC =
MC6: Giving out device to module i10nm_edac controller Intel_10nm Socket#1 =
IMC#2: DEV 0000:fe:0e.0 (INTERRUPT)
> 2025-05-21T10:35:36.857364+00:00 mc-misc2002 kernel: [   23.063787] EDAC =
MC7: Giving out device to module i10nm_edac controller Intel_10nm Socket#1 =
IMC#3: DEV 0000:fe:0f.0 (INTERRUPT)
> 2025-05-21T10:35:36.857365+00:00 mc-misc2002 kernel: [   23.063790] EDAC =
i10nm: v0.0.5
> 2025-05-21T10:35:36.857365+00:00 mc-misc2002 kernel: [   23.070365] intel=
_rapl_common: Found RAPL domain package
> 2025-05-21T10:35:36.857365+00:00 mc-misc2002 kernel: [   23.070373] intel=
_rapl_common: Found RAPL domain dram
> 2025-05-21T10:35:36.857368+00:00 mc-misc2002 kernel: [   23.070376] intel=
_rapl_common: DRAM domain energy unit 15300pj
> 2025-05-21T10:35:36.857368+00:00 mc-misc2002 kernel: [   23.070546] intel=
_rapl_common: Found RAPL domain package
> 2025-05-21T10:35:36.857369+00:00 mc-misc2002 kernel: [   23.070554] intel=
_rapl_common: Found RAPL domain dram
> 2025-05-21T10:35:36.857369+00:00 mc-misc2002 kernel: [   23.070557] intel=
_rapl_common: DRAM domain energy unit 15300pj
> 2025-05-21T10:35:36.857369+00:00 mc-misc2002 kernel: [   23.084670] ast 0=
000:04:00.0: [drm] Using analog VGA
> 2025-05-21T10:35:36.857370+00:00 mc-misc2002 kernel: [   23.084674] ast 0=
000:04:00.0: [drm] dram MCLK=3D396 Mhz type=3D1 bus_width=3D16
> 2025-05-21T10:35:36.857372+00:00 mc-misc2002 kernel: [   23.085087] [drm]=
 Initialized ast 0.1.0 20120228 for 0000:04:00.0 on minor 0
> 2025-05-21T10:35:36.857373+00:00 mc-misc2002 kernel: [   23.088051] fbcon=
: astdrmfb (fb0) is primary device
> 2025-05-21T10:35:36.857373+00:00 mc-misc2002 kernel: [   23.099214] Conso=
le: switching to colour frame buffer device 128x48
> 2025-05-21T10:35:36.857373+00:00 mc-misc2002 kernel: [   23.099856] ast 0=
000:04:00.0: [drm] fb0: astdrmfb frame buffer device
> 2025-05-21T10:35:36.857374+00:00 mc-misc2002 kernel: [   23.100595] EXT4-=
fs (dm-2): mounted filesystem with ordered data mode. Quota mode: none.
> 2025-05-21T10:35:36.857374+00:00 mc-misc2002 kernel: [   23.192702] ipmi_=
si IPI0001:00: The BMC does not support clearing the recv irq bit, compensa=
ting, but the BMC needs to be fixed.
> 2025-05-21T10:35:36.857374+00:00 mc-misc2002 kernel: [   23.215773] bnxt_=
en 0000:98:00.0 enp152s0f0np0: NIC Link is Up, 10000 Mbps (NRZ) full duplex=
, Flow control: none
> 2025-05-21T10:35:36.857377+00:00 mc-misc2002 kernel: [   23.215780] bnxt_=
en 0000:98:00.0 enp152s0f0np0: FEC autoneg off encoding: None
> 2025-05-21T10:35:36.857377+00:00 mc-misc2002 kernel: [   23.277994] ipmi_=
si IPI0001:00: IPMI message handler: Found new BMC (man_id: 0x002a7c, prod_=
id: 0x1b58, dev_id: 0x20)
> 2025-05-21T10:35:36.857378+00:00 mc-misc2002 kernel: [   23.337204] ipmi_=
si IPI0001:00: IPMI kcs interface initialized
> 2025-05-21T10:35:36.857378+00:00 mc-misc2002 kernel: [   23.339546] ipmi_=
ssif: IPMI SSIF Interface driver
> 2025-05-21T10:35:36.857378+00:00 mc-misc2002 kernel: [   24.447656] Proce=
ss accounting resumed

>=20
> Booted with 6.1.139 and intel-microcode 20250211 (reports as "microcode: =
0xd0003f5 in cpuinfo)
>=20
> 2025-05-21T09:18:23.199024+00:00 mc-misc2002 kernel: [    0.000000] micro=
code: microcode updated early to revision 0xd0003f5, date =3D 2024-08-02
> 2025-05-21T09:18:23.199031+00:00 mc-misc2002 kernel: [    0.000000] Linux=
 version 6.1.0-36-amd64 (debian-kernel@lists.debian.org) (gcc-12 (Debian 12=
=2E2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PR=
EEMPT_DYNAMIC Debian 6.1.139-1 (2025-05-18)
> 2025-05-21T09:18:23.199031+00:00 mc-misc2002 kernel: [    0.000000] Comma=
nd line: BOOT_IMAGE=3D/boot/vmlinuz-6.1.0-36-amd64 root=3D/dev/mapper/vg0-r=
oot ro console=3DttyS1,115200n8 raid0.default_layout=3D2 elevator=3Ddeadline
> 2025-05-21T09:18:23.199032+00:00 mc-misc2002 kernel: [    0.000000] x86/t=
me: not enabled by BIOS
> 2025-05-21T09:18:23.199035+00:00 mc-misc2002 kernel: [    0.000000] x86/s=
plit lock detection: #AC: crashing the kernel on kernel split_locks and war=
ning on user-space split_locks
> 2025-05-21T09:18:23.199035+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
provided physical RAM map:
> 2025-05-21T09:18:23.199036+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000000000000-0x00000000000987ff] usable
> 2025-05-21T09:18:23.199037+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000000098800-0x000000000009ffff] reserved
> 2025-05-21T09:18:23.199038+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> 2025-05-21T09:18:23.199038+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000000100000-0x00000000645fefff] usable
> 2025-05-21T09:18:23.199038+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000645ff000-0x0000000066ffefff] reserved
> 2025-05-21T09:18:23.199039+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000066fff000-0x00000000678fefff] ACPI data
> 2025-05-21T09:18:23.199044+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000678ff000-0x0000000067dfefff] ACPI NVS
> 2025-05-21T09:18:23.199045+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000067dff000-0x000000006c1fefff] reserved
> 2025-05-21T09:18:23.199046+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x000000006c1ff000-0x000000006f7fffff] usable
> 2025-05-21T09:18:23.199046+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x000000006f800000-0x000000008fffffff] reserved
> 2025-05-21T09:18:23.199046+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
> 2025-05-21T09:18:23.199047+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000fed20000-0x00000000fed44fff] reserved
> 2025-05-21T09:18:23.199047+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> 2025-05-21T09:18:23.199047+00:00 mc-misc2002 kernel: [    0.000000] BIOS-=
e820: [mem 0x0000000100000000-0x000000407fffffff] usable
> 2025-05-21T09:18:23.199049+00:00 mc-misc2002 kernel: [    0.000000] NX (E=
xecute Disable) protection: active
> 2025-05-21T09:18:23.199049+00:00 mc-misc2002 kernel: [    0.000000] SMBIO=
S 3.3.0 present.
> 2025-05-21T09:18:23.199049+00:00 mc-misc2002 kernel: [    0.000000] DMI: =
Supermicro SYS-120C-TN10R/X12DDW-A6, BIOS 1.9 01/11/2024
> 2025-05-21T09:18:23.199050+00:00 mc-misc2002 kernel: [    0.000000] tsc: =
Detected 2100.000 MHz processor
> 2025-05-21T09:18:23.199050+00:00 mc-misc2002 kernel: [    0.035960] e820:=
 update [mem 0x00000000-0x00000fff] usable =3D=3D> reserved
> 2025-05-21T09:18:23.199050+00:00 mc-misc2002 kernel: [    0.036056] e820:=
 remove [mem 0x000a0000-0x000fffff] usable
> 2025-05-21T09:18:23.199052+00:00 mc-misc2002 kernel: [    0.036338] last_=
pfn =3D 0x4080000 max_arch_pfn =3D 0x10000000000
> 2025-05-21T09:18:23.199052+00:00 mc-misc2002 kernel: [    0.040483] x86/P=
AT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT =20
> 2025-05-21T09:18:23.199053+00:00 mc-misc2002 kernel: [    0.064800] e820:=
 update [mem 0x7f000000-0xffffffff] usable =3D=3D> reserved
> 2025-05-21T09:18:23.199054+00:00 mc-misc2002 kernel: [    0.064945] last_=
pfn =3D 0x6f800 max_arch_pfn =3D 0x10000000000
> 2025-05-21T09:18:23.199055+00:00 mc-misc2002 kernel: [    0.297572] Using=
 GB pages for direct mapping
> 2025-05-21T09:18:23.199055+00:00 mc-misc2002 kernel: [    0.297909] RAMDI=
SK: [mem 0x32d71000-0x356affff]
> 2025-05-21T09:18:23.199057+00:00 mc-misc2002 kernel: [    0.297916] ACPI:=
 Early table checksum verification disabled
> 2025-05-21T09:18:23.199057+00:00 mc-misc2002 kernel: [    0.297921] ACPI:=
 RSDP 0x00000000000F05B0 000024 (v02 SUPERM)
> 2025-05-21T09:18:23.199057+00:00 mc-misc2002 kernel: [    0.297927] ACPI:=
 XSDT 0x0000000067AC4728 0000FC (v01 SUPERM SMCI--MB 01072009 AMI  01000013)
> 2025-05-21T09:18:23.199058+00:00 mc-misc2002 kernel: [    0.297934] ACPI:=
 FACP 0x00000000678FC000 000114 (v06 SUPERM SMCI--MB 01072009 INTL 20091013)
> 2025-05-21T09:18:23.199058+00:00 mc-misc2002 kernel: [    0.297941] ACPI:=
 DSDT 0x0000000067893000 067849 (v02 SUPERM SMCI--MB 01072009 INTL 20091013)
> 2025-05-21T09:18:23.199058+00:00 mc-misc2002 kernel: [    0.297946] ACPI:=
 FACS 0x0000000067DFD000 000040
> 2025-05-21T09:18:23.199059+00:00 mc-misc2002 kernel: [    0.297950] ACPI:=
 SPMI 0x00000000678FB000 000041 (v05 SUPERM SMCI--MB 00000000 AMI. 00000000)
> 2025-05-21T09:18:23.199060+00:00 mc-misc2002 kernel: [    0.297954] ACPI:=
 FIDT 0x0000000067892000 00009C (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
> 2025-05-21T09:18:23.199061+00:00 mc-misc2002 kernel: [    0.297958] ACPI:=
 SSDT 0x00000000678FE000 000704 (v02 INTEL  RAS_ACPI 00000001 INTL 20200925)
> 2025-05-21T09:18:23.199061+00:00 mc-misc2002 kernel: [    0.297963] ACPI:=
 EINJ 0x00000000678FD000 000150 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
> 2025-05-21T09:18:23.199062+00:00 mc-misc2002 kernel: [    0.297967] ACPI:=
 ERST 0x0000000067891000 000230 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
> 2025-05-21T09:18:23.199062+00:00 mc-misc2002 kernel: [    0.297971] ACPI:=
 BERT 0x0000000067890000 000030 (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
> 2025-05-21T09:18:23.199062+00:00 mc-misc2002 kernel: [    0.297975] ACPI:=
 SSDT 0x000000006788F000 000745 (v02 INTEL  ADDRXLAT 00000001 INTL 20200925)
> 2025-05-21T09:18:23.199064+00:00 mc-misc2002 kernel: [    0.297979] ACPI:=
 MCFG 0x000000006788E000 00003C (v01 SUPERM SMCI--MB 01072009 MSFT 00000097)
> 2025-05-21T09:18:23.199064+00:00 mc-misc2002 kernel: [    0.297983] ACPI:=
 BDAT 0x000000006788D000 000030 (v01 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T09:18:23.199064+00:00 mc-misc2002 kernel: [    0.297987] ACPI:=
 HMAT 0x000000006788C000 000180 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
> 2025-05-21T09:18:23.199064+00:00 mc-misc2002 kernel: [    0.297991] ACPI:=
 HPET 0x000000006788B000 000038 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
> 2025-05-21T09:18:23.199065+00:00 mc-misc2002 kernel: [    0.297995] ACPI:=
 MIGT 0x000000006788A000 000040 (v01 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T09:18:23.199065+00:00 mc-misc2002 kernel: [    0.297999] ACPI:=
 MSCT 0x0000000067889000 000090 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
> 2025-05-21T09:18:23.199065+00:00 mc-misc2002 kernel: [    0.298003] ACPI:=
 WDDT 0x0000000067888000 000040 (v01 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T09:18:23.199067+00:00 mc-misc2002 kernel: [    0.298007] ACPI:=
 APIC 0x0000000067886000 0001DE (v04 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T09:18:23.199068+00:00 mc-misc2002 kernel: [    0.298011] ACPI:=
 SLIT 0x0000000067885000 000030 (v01 SUPERM SMCI--MB 00000001 AMI  01000013)
> 2025-05-21T09:18:23.199069+00:00 mc-misc2002 kernel: [    0.298015] ACPI:=
 SRAT 0x000000006787E000 006430 (v03 SUPERM SMCI--MB 00000002 AMI  01000013)
> 2025-05-21T09:18:23.199069+00:00 mc-misc2002 kernel: [    0.298019] ACPI:=
 OEM4 0x00000000676F6000 187A61 (v02 INTEL  CPU  CST 00003000 INTL 20200925)
> 2025-05-21T09:18:23.199069+00:00 mc-misc2002 kernel: [    0.298023] ACPI:=
 OEM1 0x00000000675E2000 113489 (v02 INTEL  CPU EIST 00003000 INTL 20200925)
> 2025-05-21T09:18:23.199070+00:00 mc-misc2002 kernel: [    0.298027] ACPI:=
 SSDT 0x000000006756B000 0764A5 (v02 INTEL  SSDT  PM 00004000 INTL 20200925)
> 2025-05-21T09:18:23.199071+00:00 mc-misc2002 kernel: [    0.298031] ACPI:=
 HEST 0x0000000067569000 00013C (v01 SUPERM SMCI--MB 00000001 INTL 00000001)
> 2025-05-21T09:18:23.199072+00:00 mc-misc2002 kernel: [    0.298035] ACPI:=
 DMAR 0x0000000067568000 0002F8 (v01 SUPERM SMCI--MB 00000001 INTL 20091013)
> 2025-05-21T09:18:23.199073+00:00 mc-misc2002 kernel: [    0.298039] ACPI:=
 SSDT 0x0000000067560000 0078BA (v02 INTEL  SpsNm    00000002 INTL 20200925)
> 2025-05-21T09:18:23.199073+00:00 mc-misc2002 kernel: [    0.298043] ACPI:=
 SSDT 0x000000006755E000 001744 (v01 SUPERM SMCCDN   00000000 INTL 20181221)
> 2025-05-21T09:18:23.199073+00:00 mc-misc2002 kernel: [    0.298047] ACPI:=
 WSMT 0x0000000067887000 000028 (v01 SUPERM SMCI--MB 01072009 AMI  00010013)
> 2025-05-21T09:18:23.199074+00:00 mc-misc2002 kernel: [    0.298051] ACPI:=
 SSDT 0x000000006756A000 0009B3 (v02 SUPERM SMCI--MB 00000000 INTL 20091013)
> 2025-05-21T09:18:23.199076+00:00 mc-misc2002 kernel: [    0.298054] ACPI:=
 Reserving FACP table memory at [mem 0x678fc000-0x678fc113]
> 2025-05-21T09:18:23.199076+00:00 mc-misc2002 kernel: [    0.298056] ACPI:=
 Reserving DSDT table memory at [mem 0x67893000-0x678fa848]
> 2025-05-21T09:18:23.199076+00:00 mc-misc2002 kernel: [    0.298057] ACPI:=
 Reserving FACS table memory at [mem 0x67dfd000-0x67dfd03f]
> 2025-05-21T09:18:23.199077+00:00 mc-misc2002 kernel: [    0.298058] ACPI:=
 Reserving SPMI table memory at [mem 0x678fb000-0x678fb040]
> 2025-05-21T09:18:23.199077+00:00 mc-misc2002 kernel: [    0.298059] ACPI:=
 Reserving FIDT table memory at [mem 0x67892000-0x6789209b]
> 2025-05-21T09:18:23.199077+00:00 mc-misc2002 kernel: [    0.298060] ACPI:=
 Reserving SSDT table memory at [mem 0x678fe000-0x678fe703]
> 2025-05-21T09:18:23.199078+00:00 mc-misc2002 kernel: [    0.298061] ACPI:=
 Reserving EINJ table memory at [mem 0x678fd000-0x678fd14f]
> 2025-05-21T09:18:23.199081+00:00 mc-misc2002 kernel: [    0.298061] ACPI:=
 Reserving ERST table memory at [mem 0x67891000-0x6789122f]
> 2025-05-21T09:18:23.199081+00:00 mc-misc2002 kernel: [    0.298062] ACPI:=
 Reserving BERT table memory at [mem 0x67890000-0x6789002f]
> 2025-05-21T09:18:23.199081+00:00 mc-misc2002 kernel: [    0.298063] ACPI:=
 Reserving SSDT table memory at [mem 0x6788f000-0x6788f744]
> 2025-05-21T09:18:23.199082+00:00 mc-misc2002 kernel: [    0.298064] ACPI:=
 Reserving MCFG table memory at [mem 0x6788e000-0x6788e03b]
> 2025-05-21T09:18:23.199082+00:00 mc-misc2002 kernel: [    0.298065] ACPI:=
 Reserving BDAT table memory at [mem 0x6788d000-0x6788d02f]
> 2025-05-21T09:18:23.199082+00:00 mc-misc2002 kernel: [    0.298066] ACPI:=
 Reserving HMAT table memory at [mem 0x6788c000-0x6788c17f]
> 2025-05-21T09:18:23.199084+00:00 mc-misc2002 kernel: [    0.298067] ACPI:=
 Reserving HPET table memory at [mem 0x6788b000-0x6788b037]
> 2025-05-21T09:18:23.199084+00:00 mc-misc2002 kernel: [    0.298068] ACPI:=
 Reserving MIGT table memory at [mem 0x6788a000-0x6788a03f]
> 2025-05-21T09:18:23.199085+00:00 mc-misc2002 kernel: [    0.298069] ACPI:=
 Reserving MSCT table memory at [mem 0x67889000-0x6788908f]
> 2025-05-21T09:18:23.199085+00:00 mc-misc2002 kernel: [    0.298070] ACPI:=
 Reserving WDDT table memory at [mem 0x67888000-0x6788803f]
> 2025-05-21T09:18:23.199085+00:00 mc-misc2002 kernel: [    0.298071] ACPI:=
 Reserving APIC table memory at [mem 0x67886000-0x678861dd]
> 2025-05-21T09:18:23.199085+00:00 mc-misc2002 kernel: [    0.298072] ACPI:=
 Reserving SLIT table memory at [mem 0x67885000-0x6788502f]
> 2025-05-21T09:18:23.199086+00:00 mc-misc2002 kernel: [    0.298073] ACPI:=
 Reserving SRAT table memory at [mem 0x6787e000-0x6788442f]
> 2025-05-21T09:18:23.199088+00:00 mc-misc2002 kernel: [    0.298074] ACPI:=
 Reserving OEM4 table memory at [mem 0x676f6000-0x6787da60]
> 2025-05-21T09:18:23.199088+00:00 mc-misc2002 kernel: [    0.298075] ACPI:=
 Reserving OEM1 table memory at [mem 0x675e2000-0x676f5488]
> 2025-05-21T09:18:23.199088+00:00 mc-misc2002 kernel: [    0.298076] ACPI:=
 Reserving SSDT table memory at [mem 0x6756b000-0x675e14a4]
> 2025-05-21T09:18:23.199089+00:00 mc-misc2002 kernel: [    0.298077] ACPI:=
 Reserving HEST table memory at [mem 0x67569000-0x6756913b]
> 2025-05-21T09:18:23.199089+00:00 mc-misc2002 kernel: [    0.298078] ACPI:=
 Reserving DMAR table memory at [mem 0x67568000-0x675682f7]
> 2025-05-21T09:18:23.199089+00:00 mc-misc2002 kernel: [    0.298079] ACPI:=
 Reserving SSDT table memory at [mem 0x67560000-0x675678b9]
> 2025-05-21T09:18:23.199091+00:00 mc-misc2002 kernel: [    0.298080] ACPI:=
 Reserving SSDT table memory at [mem 0x6755e000-0x6755f743]
> 2025-05-21T09:18:23.199092+00:00 mc-misc2002 kernel: [    0.298081] ACPI:=
 Reserving WSMT table memory at [mem 0x67887000-0x67887027]
> 2025-05-21T09:18:23.199092+00:00 mc-misc2002 kernel: [    0.298082] ACPI:=
 Reserving SSDT table memory at [mem 0x6756a000-0x6756a9b2]
> 2025-05-21T09:18:23.199093+00:00 mc-misc2002 kernel: [    0.298123] SRAT:=
 PXM 0 -> APIC 0x00 -> Node 0
> 2025-05-21T09:18:23.199093+00:00 mc-misc2002 kernel: [    0.298125] SRAT:=
 PXM 0 -> APIC 0x01 -> Node 0
> 2025-05-21T09:18:23.199094+00:00 mc-misc2002 kernel: [    0.298126] SRAT:=
 PXM 0 -> APIC 0x02 -> Node 0
> 2025-05-21T09:18:23.199096+00:00 mc-misc2002 kernel: [    0.298127] SRAT:=
 PXM 0 -> APIC 0x03 -> Node 0
> 2025-05-21T09:18:23.199096+00:00 mc-misc2002 kernel: [    0.298127] SRAT:=
 PXM 0 -> APIC 0x04 -> Node 0
> 2025-05-21T09:18:23.199096+00:00 mc-misc2002 kernel: [    0.298128] SRAT:=
 PXM 0 -> APIC 0x05 -> Node 0
> 2025-05-21T09:18:23.199097+00:00 mc-misc2002 kernel: [    0.298129] SRAT:=
 PXM 0 -> APIC 0x06 -> Node 0
> 2025-05-21T09:18:23.199097+00:00 mc-misc2002 kernel: [    0.298130] SRAT:=
 PXM 0 -> APIC 0x07 -> Node 0
> 2025-05-21T09:18:23.199097+00:00 mc-misc2002 kernel: [    0.298130] SRAT:=
 PXM 0 -> APIC 0x08 -> Node 0
> 2025-05-21T09:18:23.199097+00:00 mc-misc2002 kernel: [    0.298131] SRAT:=
 PXM 0 -> APIC 0x09 -> Node 0
> 2025-05-21T09:18:23.199099+00:00 mc-misc2002 kernel: [    0.298132] SRAT:=
 PXM 0 -> APIC 0x0a -> Node 0
> 2025-05-21T09:18:23.199100+00:00 mc-misc2002 kernel: [    0.298133] SRAT:=
 PXM 0 -> APIC 0x0b -> Node 0
> 2025-05-21T09:18:23.199100+00:00 mc-misc2002 kernel: [    0.298134] SRAT:=
 PXM 0 -> APIC 0x0c -> Node 0
> 2025-05-21T09:18:23.199100+00:00 mc-misc2002 kernel: [    0.298134] SRAT:=
 PXM 0 -> APIC 0x0d -> Node 0
> 2025-05-21T09:18:23.199101+00:00 mc-misc2002 kernel: [    0.298135] SRAT:=
 PXM 0 -> APIC 0x0e -> Node 0
> 2025-05-21T09:18:23.199101+00:00 mc-misc2002 kernel: [    0.298136] SRAT:=
 PXM 0 -> APIC 0x0f -> Node 0
> 2025-05-21T09:18:23.199102+00:00 mc-misc2002 kernel: [    0.298137] SRAT:=
 PXM 0 -> APIC 0x10 -> Node 0
> 2025-05-21T09:18:23.199103+00:00 mc-misc2002 kernel: [    0.298138] SRAT:=
 PXM 0 -> APIC 0x11 -> Node 0
> 2025-05-21T09:18:23.199104+00:00 mc-misc2002 kernel: [    0.298138] SRAT:=
 PXM 0 -> APIC 0x12 -> Node 0
> 2025-05-21T09:18:23.199105+00:00 mc-misc2002 kernel: [    0.298139] SRAT:=
 PXM 0 -> APIC 0x13 -> Node 0
> 2025-05-21T09:18:23.199105+00:00 mc-misc2002 kernel: [    0.298140] SRAT:=
 PXM 0 -> APIC 0x14 -> Node 0
> 2025-05-21T09:18:23.199105+00:00 mc-misc2002 kernel: [    0.298141] SRAT:=
 PXM 0 -> APIC 0x15 -> Node 0
> 2025-05-21T09:18:23.199105+00:00 mc-misc2002 kernel: [    0.298141] SRAT:=
 PXM 0 -> APIC 0x16 -> Node 0
> 2025-05-21T09:18:23.199107+00:00 mc-misc2002 kernel: [    0.298142] SRAT:=
 PXM 0 -> APIC 0x17 -> Node 0
> 2025-05-21T09:18:23.199108+00:00 mc-misc2002 kernel: [    0.298143] SRAT:=
 PXM 1 -> APIC 0x40 -> Node 1
> 2025-05-21T09:18:23.199108+00:00 mc-misc2002 kernel: [    0.298144] SRAT:=
 PXM 1 -> APIC 0x41 -> Node 1
> 2025-05-21T09:18:23.199108+00:00 mc-misc2002 kernel: [    0.298145] SRAT:=
 PXM 1 -> APIC 0x42 -> Node 1
> 2025-05-21T09:18:23.199109+00:00 mc-misc2002 kernel: [    0.298146] SRAT:=
 PXM 1 -> APIC 0x43 -> Node 1
> 2025-05-21T09:18:23.199110+00:00 mc-misc2002 kernel: [    0.298146] SRAT:=
 PXM 1 -> APIC 0x44 -> Node 1
> 2025-05-21T09:18:23.199111+00:00 mc-misc2002 kernel: [    0.298147] SRAT:=
 PXM 1 -> APIC 0x45 -> Node 1
> 2025-05-21T09:18:23.199111+00:00 mc-misc2002 kernel: [    0.298148] SRAT:=
 PXM 1 -> APIC 0x46 -> Node 1
> 2025-05-21T09:18:23.199112+00:00 mc-misc2002 kernel: [    0.298149] SRAT:=
 PXM 1 -> APIC 0x47 -> Node 1
> 2025-05-21T09:18:23.199112+00:00 mc-misc2002 kernel: [    0.298149] SRAT:=
 PXM 1 -> APIC 0x48 -> Node 1
> 2025-05-21T09:18:23.199112+00:00 mc-misc2002 kernel: [    0.298150] SRAT:=
 PXM 1 -> APIC 0x49 -> Node 1
> 2025-05-21T09:18:23.199113+00:00 mc-misc2002 kernel: [    0.298151] SRAT:=
 PXM 1 -> APIC 0x4a -> Node 1
> 2025-05-21T09:18:23.199115+00:00 mc-misc2002 kernel: [    0.298152] SRAT:=
 PXM 1 -> APIC 0x4b -> Node 1
> 2025-05-21T09:18:23.199115+00:00 mc-misc2002 kernel: [    0.298153] SRAT:=
 PXM 1 -> APIC 0x4c -> Node 1
> 2025-05-21T09:18:23.199116+00:00 mc-misc2002 kernel: [    0.298154] SRAT:=
 PXM 1 -> APIC 0x4d -> Node 1
> 2025-05-21T09:18:23.199116+00:00 mc-misc2002 kernel: [    0.298155] SRAT:=
 PXM 1 -> APIC 0x4e -> Node 1
> 2025-05-21T09:18:23.199116+00:00 mc-misc2002 kernel: [    0.298156] SRAT:=
 PXM 1 -> APIC 0x4f -> Node 1
> 2025-05-21T09:18:23.199117+00:00 mc-misc2002 kernel: [    0.298157] SRAT:=
 PXM 1 -> APIC 0x50 -> Node 1
> 2025-05-21T09:18:23.199117+00:00 mc-misc2002 kernel: [    0.298158] SRAT:=
 PXM 1 -> APIC 0x51 -> Node 1
> 2025-05-21T09:18:23.199118+00:00 mc-misc2002 kernel: [    0.298159] SRAT:=
 PXM 1 -> APIC 0x52 -> Node 1
> 2025-05-21T09:18:23.199119+00:00 mc-misc2002 kernel: [    0.298159] SRAT:=
 PXM 1 -> APIC 0x53 -> Node 1
> 2025-05-21T09:18:23.199119+00:00 mc-misc2002 kernel: [    0.298160] SRAT:=
 PXM 1 -> APIC 0x54 -> Node 1
> 2025-05-21T09:18:23.199119+00:00 mc-misc2002 kernel: [    0.298161] SRAT:=
 PXM 1 -> APIC 0x55 -> Node 1
> 2025-05-21T09:18:23.199119+00:00 mc-misc2002 kernel: [    0.298162] SRAT:=
 PXM 1 -> APIC 0x56 -> Node 1
> 2025-05-21T09:18:23.199120+00:00 mc-misc2002 kernel: [    0.298163] SRAT:=
 PXM 1 -> APIC 0x57 -> Node 1
> 2025-05-21T09:18:23.199121+00:00 mc-misc2002 kernel: [    0.298217] ACPI:=
 SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> 2025-05-21T09:18:23.199122+00:00 mc-misc2002 kernel: [    0.298219] ACPI:=
 SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
> 2025-05-21T09:18:23.199125+00:00 mc-misc2002 kernel: [    0.298221] ACPI:=
 SRAT: Node 1 PXM 1 [mem 0x2080000000-0x407fffffff]
> 2025-05-21T09:18:23.199126+00:00 mc-misc2002 kernel: [    0.298236] NUMA:=
 Initialized distance table, cnt=3D2
> 2025-05-21T09:18:23.199126+00:00 mc-misc2002 kernel: [    0.298240] NUMA:=
 Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-0x207fffffff] -> [me=
m 0x00000000-0x207fffffff]
> 2025-05-21T09:18:23.199126+00:00 mc-misc2002 kernel: [    0.298253] NODE_=
DATA(0) allocated [mem 0x207ffd5000-0x207fffffff]
> 2025-05-21T09:18:23.199128+00:00 mc-misc2002 kernel: [    0.298272] NODE_=
DATA(1) allocated [mem 0x407ffd4000-0x407fffefff]
> 2025-05-21T09:18:23.199128+00:00 mc-misc2002 kernel: [    0.299072] Zone =
ranges:
> 2025-05-21T09:18:23.199129+00:00 mc-misc2002 kernel: [    0.299073]   DMA=
      [mem 0x0000000000001000-0x0000000000ffffff]
> 2025-05-21T09:18:23.199129+00:00 mc-misc2002 kernel: [    0.299075]   DMA=
32    [mem 0x0000000001000000-0x00000000ffffffff]
> 2025-05-21T09:18:23.199129+00:00 mc-misc2002 kernel: [    0.299077]   Nor=
mal   [mem 0x0000000100000000-0x000000407fffffff]
> 2025-05-21T09:18:23.199130+00:00 mc-misc2002 kernel: [    0.299079]   Dev=
ice   empty
> 2025-05-21T09:18:23.199130+00:00 mc-misc2002 kernel: [    0.299080] Movab=
le zone start for each node
> 2025-05-21T09:18:23.199132+00:00 mc-misc2002 kernel: [    0.299085] Early=
 memory node ranges
> 2025-05-21T09:18:23.199132+00:00 mc-misc2002 kernel: [    0.299085]   nod=
e   0: [mem 0x0000000000001000-0x0000000000097fff]
> 2025-05-21T09:18:23.199132+00:00 mc-misc2002 kernel: [    0.299087]   nod=
e   0: [mem 0x0000000000100000-0x00000000645fefff]
> 2025-05-21T09:18:23.199133+00:00 mc-misc2002 kernel: [    0.299089]   nod=
e   0: [mem 0x000000006c1ff000-0x000000006f7fffff]
> 2025-05-21T09:18:23.199133+00:00 mc-misc2002 kernel: [    0.299090]   nod=
e   0: [mem 0x0000000100000000-0x000000207fffffff]
> 2025-05-21T09:18:23.199133+00:00 mc-misc2002 kernel: [    0.299104]   nod=
e   1: [mem 0x0000002080000000-0x000000407fffffff]
> 2025-05-21T09:18:23.199134+00:00 mc-misc2002 kernel: [    0.299119] Initm=
em setup node 0 [mem 0x0000000000001000-0x000000207fffffff]
> 2025-05-21T09:18:23.199135+00:00 mc-misc2002 kernel: [    0.299123] Initm=
em setup node 1 [mem 0x0000002080000000-0x000000407fffffff]
> 2025-05-21T09:18:23.199135+00:00 mc-misc2002 kernel: [    0.299127] On no=
de 0, zone DMA: 1 pages in unavailable ranges
> 2025-05-21T09:18:23.199136+00:00 mc-misc2002 kernel: [    0.299167] On no=
de 0, zone DMA: 104 pages in unavailable ranges
> 2025-05-21T09:18:23.199136+00:00 mc-misc2002 kernel: [    0.303356] On no=
de 0, zone DMA32: 31744 pages in unavailable ranges
> 2025-05-21T09:18:23.199136+00:00 mc-misc2002 kernel: [    0.303718] On no=
de 0, zone Normal: 2048 pages in unavailable ranges
> 2025-05-21T09:18:23.199136+00:00 mc-misc2002 kernel: [    0.304211] ACPI:=
 PM-Timer IO Port: 0x508
> 2025-05-21T09:18:23.199139+00:00 mc-misc2002 kernel: [    0.304225] ACPI:=
 X2APIC_NMI (uid[0xffffffff] high edge lint[0x1])
> 2025-05-21T09:18:23.199139+00:00 mc-misc2002 kernel: [    0.304229] ACPI:=
 LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> 2025-05-21T09:18:23.199140+00:00 mc-misc2002 kernel: [    0.304248] IOAPI=
C[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-119
> 2025-05-21T09:18:23.199143+00:00 mc-misc2002 kernel: [    0.304252] ACPI:=
 INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> 2025-05-21T09:18:23.199144+00:00 mc-misc2002 kernel: [    0.304254] ACPI:=
 INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> 2025-05-21T09:18:23.199144+00:00 mc-misc2002 kernel: [    0.304260] ACPI:=
 Using ACPI (MADT) for SMP configuration information
> 2025-05-21T09:18:23.199146+00:00 mc-misc2002 kernel: [    0.304262] ACPI:=
 HPET id: 0x8086a701 base: 0xfed00000
> 2025-05-21T09:18:23.199147+00:00 mc-misc2002 kernel: [    0.304267] TSC d=
eadline timer available
> 2025-05-21T09:18:23.199151+00:00 mc-misc2002 kernel: [    0.304269] smpbo=
ot: Allowing 48 CPUs, 0 hotplug CPUs
> 2025-05-21T09:18:23.199151+00:00 mc-misc2002 kernel: [    0.304288] PM: h=
ibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> 2025-05-21T09:18:23.199152+00:00 mc-misc2002 kernel: [    0.304291] PM: h=
ibernation: Registered nosave memory: [mem 0x00098000-0x000fffff]
> 2025-05-21T09:18:23.199152+00:00 mc-misc2002 kernel: [    0.304293] PM: h=
ibernation: Registered nosave memory: [mem 0x645ff000-0x6c1fefff]
> 2025-05-21T09:18:23.199165+00:00 mc-misc2002 kernel: [    0.304295] PM: h=
ibernation: Registered nosave memory: [mem 0x6f800000-0xffffffff]
> 2025-05-21T09:18:23.199166+00:00 mc-misc2002 kernel: [    0.304297] [mem =
0x90000000-0xfcffffff] available for PCI devices
> 2025-05-21T09:18:23.199166+00:00 mc-misc2002 kernel: [    0.304299] Booti=
ng paravirtualized kernel on bare hardware
> 2025-05-21T09:18:23.199166+00:00 mc-misc2002 kernel: [    0.304302] clock=
source: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_=
ns: 7645519600211568 ns
> 2025-05-21T09:18:23.199167+00:00 mc-misc2002 kernel: [    0.310578] setup=
_percpu: NR_CPUS:8192 nr_cpumask_bits:48 nr_cpu_ids:48 nr_node_ids:2
> 2025-05-21T09:18:23.199167+00:00 mc-misc2002 kernel: [    0.312698] percp=
u: Embedded 61 pages/cpu s212992 r8192 d28672 u262144
> 2025-05-21T09:18:23.199167+00:00 mc-misc2002 kernel: [    0.312708] pcpu-=
alloc: s212992 r8192 d28672 u262144 alloc=3D1*2097152
> 2025-05-21T09:18:23.199169+00:00 mc-misc2002 kernel: [    0.312711] pcpu-=
alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 24 25 26 27=20
> 2025-05-21T09:18:23.199169+00:00 mc-misc2002 kernel: [    0.312723] pcpu-=
alloc: [0] 28 29 30 31 32 33 34 35 [1] 12 13 14 15 16 17 18 19=20
> 2025-05-21T09:18:23.199170+00:00 mc-misc2002 kernel: [    0.312733] pcpu-=
alloc: [1] 20 21 22 23 36 37 38 39 [1] 40 41 42 43 44 45 46 47=20
> 2025-05-21T09:18:23.199170+00:00 mc-misc2002 kernel: [    0.312779] Fallb=
ack order for Node 0: 0 1=20
> 2025-05-21T09:18:23.199170+00:00 mc-misc2002 kernel: [    0.312782] Fallb=
ack order for Node 1: 1 0=20
> 2025-05-21T09:18:23.199171+00:00 mc-misc2002 kernel: [    0.312787] Built=
 2 zonelists, mobility grouping on.  Total pages: 65962256
> 2025-05-21T09:18:23.199191+00:00 mc-misc2002 kernel: [    0.312789] Polic=
y zone: Normal
> 2025-05-21T09:18:23.199192+00:00 mc-misc2002 kernel: [    0.312791] Kerne=
l command line: BOOT_IMAGE=3D/boot/vmlinuz-6.1.0-36-amd64 root=3D/dev/mappe=
r/vg0-root ro console=3DttyS1,115200n8 raid0.default_layout=3D2 elevator=3D=
deadline
> 2025-05-21T09:18:23.199193+00:00 mc-misc2002 kernel: [    0.312874] Kerne=
l parameter elevator=3D does not have any effect anymore.
> 2025-05-21T09:18:23.199193+00:00 mc-misc2002 kernel: [    0.312874] Pleas=
e use sysfs to set IO scheduler for individual devices.
> 2025-05-21T09:18:23.199194+00:00 mc-misc2002 kernel: [    0.312878] Unkno=
wn kernel command line parameters "BOOT_IMAGE=3D/boot/vmlinuz-6.1.0-36-amd6=
4", will be passed to user space.
> 2025-05-21T09:18:23.199195+00:00 mc-misc2002 kernel: [    0.312890] rando=
m: crng init done
> 2025-05-21T09:18:23.199196+00:00 mc-misc2002 kernel: [    0.312891] print=
k: log_buf_len individual max cpu contribution: 4096 bytes
> 2025-05-21T09:18:23.199196+00:00 mc-misc2002 kernel: [    0.312893] print=
k: log_buf_len total cpu_extra contributions: 192512 bytes
> 2025-05-21T09:18:23.199197+00:00 mc-misc2002 kernel: [    0.312894] print=
k: log_buf_len min size: 131072 bytes
> 2025-05-21T09:18:23.199197+00:00 mc-misc2002 kernel: [    0.313351] print=
k: log_buf_len: 524288 bytes
> 2025-05-21T09:18:23.199197+00:00 mc-misc2002 kernel: [    0.313352] print=
k: early log buf free: 117400(89%)
> 2025-05-21T09:18:23.199198+00:00 mc-misc2002 kernel: [    0.314170] mem a=
uto-init: stack:all(zero), heap alloc:on, heap free:off
> 2025-05-21T09:18:23.199203+00:00 mc-misc2002 kernel: [    0.314191] softw=
are IO TLB: area num 64.
> 2025-05-21T09:18:23.199203+00:00 mc-misc2002 kernel: [    0.439868] Memor=
y: 1852984K/268037724K available (14343K kernel code, 2339K rwdata, 9096K r=
odata, 2800K init, 17380K bss, 4369328K reserved, 0K cma-reserved)
> 2025-05-21T09:18:23.199204+00:00 mc-misc2002 kernel: [    0.440187] SLUB:=
 HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D48, Nodes=3D2
> 2025-05-21T09:18:23.199204+00:00 mc-misc2002 kernel: [    0.440223] ftrac=
e: allocating 40346 entries in 158 pages
> 2025-05-21T09:18:23.199204+00:00 mc-misc2002 kernel: [    0.449652] ftrac=
e: allocated 158 pages with 5 groups
> 2025-05-21T09:18:23.199205+00:00 mc-misc2002 kernel: [    0.450677] Dynam=
ic Preempt: voluntary
> 2025-05-21T09:18:23.199211+00:00 mc-misc2002 kernel: [    0.450823] rcu: =
Preemptible hierarchical RCU implementation.
> 2025-05-21T09:18:23.199211+00:00 mc-misc2002 kernel: [    0.450824] rcu: =
	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=3D48.
> 2025-05-21T09:18:23.199212+00:00 mc-misc2002 kernel: [    0.450826] 	Tram=
poline variant of Tasks RCU enabled.
> 2025-05-21T09:18:23.199212+00:00 mc-misc2002 kernel: [    0.450827] 	Rude=
 variant of Tasks RCU enabled.
> 2025-05-21T09:18:23.199212+00:00 mc-misc2002 kernel: [    0.450827] 	Trac=
ing variant of Tasks RCU enabled.
> 2025-05-21T09:18:23.199213+00:00 mc-misc2002 kernel: [    0.450828] rcu: =
RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> 2025-05-21T09:18:23.199213+00:00 mc-misc2002 kernel: [    0.450830] rcu: =
Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D48
> 2025-05-21T09:18:23.199216+00:00 mc-misc2002 kernel: [    0.456499] NR_IR=
QS: 524544, nr_irqs: 2440, preallocated irqs: 16
> 2025-05-21T09:18:23.199217+00:00 mc-misc2002 kernel: [    0.456744] rcu: =
srcu_init: Setting srcu_struct sizes based on contention.
> 2025-05-21T09:18:23.199217+00:00 mc-misc2002 kernel: [    0.457385] Conso=
le: colour dummy device 80x25
> 2025-05-21T09:18:23.199217+00:00 mc-misc2002 kernel: [    1.966984] print=
k: console [ttyS1] enabled
> 2025-05-21T09:18:23.199218+00:00 mc-misc2002 kernel: [    1.971732] mempo=
licy: Enabling automatic NUMA balancing. Configure with numa_balancing=3D o=
r the kernel.numa_balancing sysctl
> 2025-05-21T09:18:23.199218+00:00 mc-misc2002 kernel: [    1.984326] ACPI:=
 Core revision 20220331
> 2025-05-21T09:18:23.199221+00:00 mc-misc2002 kernel: [    1.991554] clock=
source: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7963585=
5245 ns
> 2025-05-21T09:18:23.199222+00:00 mc-misc2002 kernel: [    2.001759] APIC:=
 Switch to symmetric I/O mode setup
> 2025-05-21T09:18:23.199222+00:00 mc-misc2002 kernel: [    2.007347] DMAR:=
 Host address width 46
> 2025-05-21T09:18:23.199222+00:00 mc-misc2002 kernel: [    2.011665] DMAR:=
 DRHD base: 0x000000d0ffc000 flags: 0x0
> 2025-05-21T09:18:23.199223+00:00 mc-misc2002 kernel: [    2.017648] DMAR:=
 dmar0: reg_base_addr d0ffc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T09:18:23.199223+00:00 mc-misc2002 kernel: [    2.027136] DMAR:=
 DRHD base: 0x000000dbbfc000 flags: 0x0
> 2025-05-21T09:18:23.199225+00:00 mc-misc2002 kernel: [    2.033116] DMAR:=
 dmar1: reg_base_addr dbbfc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T09:18:23.199226+00:00 mc-misc2002 kernel: [    2.042603] DMAR:=
 DRHD base: 0x000000e67fc000 flags: 0x0
> 2025-05-21T09:18:23.199227+00:00 mc-misc2002 kernel: [    2.048581] DMAR:=
 dmar2: reg_base_addr e67fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T09:18:23.199228+00:00 mc-misc2002 kernel: [    2.058067] DMAR:=
 DRHD base: 0x000000f13fc000 flags: 0x0
> 2025-05-21T09:18:23.199228+00:00 mc-misc2002 kernel: [    2.064048] DMAR:=
 dmar3: reg_base_addr f13fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T09:18:23.199228+00:00 mc-misc2002 kernel: [    2.073532] DMAR:=
 DRHD base: 0x000000fb7fc000 flags: 0x0
> 2025-05-21T09:18:23.199229+00:00 mc-misc2002 kernel: [    2.079510] DMAR:=
 dmar4: reg_base_addr fb7fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T09:18:23.199231+00:00 mc-misc2002 kernel: [    2.088998] DMAR:=
 DRHD base: 0x000000a63fc000 flags: 0x0
> 2025-05-21T09:18:23.199232+00:00 mc-misc2002 kernel: [    2.094975] DMAR:=
 dmar5: reg_base_addr a63fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T09:18:23.199232+00:00 mc-misc2002 kernel: [    2.104460] DMAR:=
 DRHD base: 0x000000b0ffc000 flags: 0x0
> 2025-05-21T09:18:23.199232+00:00 mc-misc2002 kernel: [    2.110438] DMAR:=
 dmar6: reg_base_addr b0ffc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T09:18:23.199233+00:00 mc-misc2002 kernel: [    2.119925] DMAR:=
 DRHD base: 0x000000bbbfc000 flags: 0x0
> 2025-05-21T09:18:23.199233+00:00 mc-misc2002 kernel: [    2.125903] DMAR:=
 dmar7: reg_base_addr bbbfc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T09:18:23.199235+00:00 mc-misc2002 kernel: [    2.135389] DMAR:=
 DRHD base: 0x000000c5ffc000 flags: 0x0
> 2025-05-21T09:18:23.199236+00:00 mc-misc2002 kernel: [    2.141366] DMAR:=
 dmar8: reg_base_addr c5ffc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T09:18:23.199236+00:00 mc-misc2002 kernel: [    2.150851] DMAR:=
 DRHD base: 0x0000009b7fc000 flags: 0x1
> 2025-05-21T09:18:23.199236+00:00 mc-misc2002 kernel: [    2.156830] DMAR:=
 dmar9: reg_base_addr 9b7fc000 ver 4:0 cap 8ed008c40780466 ecap 60000f050df
> 2025-05-21T09:18:23.199236+00:00 mc-misc2002 kernel: [    2.166314] DMAR:=
 RMRR base: 0x0000006b985000 end: 0x0000006b9a8fff
> 2025-05-21T09:18:23.199237+00:00 mc-misc2002 kernel: [    2.173362] DMAR:=
 RMRR base: 0x0000006a3d8000 end: 0x0000006a621fff
> 2025-05-21T09:18:23.199239+00:00 mc-misc2002 kernel: [    2.180409] DMAR:=
 ATSR flags: 0x0
> 2025-05-21T09:18:23.199240+00:00 mc-misc2002 kernel: [    2.184141] DMAR:=
 ATSR flags: 0x0
> 2025-05-21T09:18:23.199240+00:00 mc-misc2002 kernel: [    2.187874] DMAR:=
 RHSA base: 0x0000009b7fc000 proximity domain: 0x0
> 2025-05-21T09:18:23.199240+00:00 mc-misc2002 kernel: [    2.194922] DMAR:=
 RHSA base: 0x000000a63fc000 proximity domain: 0x0
> 2025-05-21T09:18:23.199241+00:00 mc-misc2002 kernel: [    2.201970] DMAR:=
 RHSA base: 0x000000b0ffc000 proximity domain: 0x0
> 2025-05-21T09:18:23.199241+00:00 mc-misc2002 kernel: [    2.209017] DMAR:=
 RHSA base: 0x000000bbbfc000 proximity domain: 0x0
> 2025-05-21T09:18:23.199241+00:00 mc-misc2002 kernel: [    2.216063] DMAR:=
 RHSA base: 0x000000c5ffc000 proximity domain: 0x0
> 2025-05-21T09:18:23.199244+00:00 mc-misc2002 kernel: [    2.223111] DMAR:=
 RHSA base: 0x000000d0ffc000 proximity domain: 0x1
> 2025-05-21T09:18:23.199244+00:00 mc-misc2002 kernel: [    2.230159] DMAR:=
 RHSA base: 0x000000dbbfc000 proximity domain: 0x1
> 2025-05-21T09:18:23.199245+00:00 mc-misc2002 kernel: [    2.237206] DMAR:=
 RHSA base: 0x000000e67fc000 proximity domain: 0x1
> 2025-05-21T09:18:23.199245+00:00 mc-misc2002 kernel: [    2.244253] DMAR:=
 RHSA base: 0x000000f13fc000 proximity domain: 0x1
> 2025-05-21T09:18:23.199245+00:00 mc-misc2002 kernel: [    2.251301] DMAR:=
 RHSA base: 0x000000fb7fc000 proximity domain: 0x1
> 2025-05-21T09:18:23.199245+00:00 mc-misc2002 kernel: [    2.258349] DMAR-=
IR: IOAPIC id 8 under DRHD base  0x9b7fc000 IOMMU 9
> 2025-05-21T09:18:23.199249+00:00 mc-misc2002 kernel: [    2.265496] DMAR-=
IR: HPET id 0 under DRHD base 0x9b7fc000
> 2025-05-21T09:18:23.199249+00:00 mc-misc2002 kernel: [    2.271569] DMAR-=
IR: Queued invalidation will be enabled to support x2apic and Intr-remappin=
g.
> 2025-05-21T09:18:23.199250+00:00 mc-misc2002 kernel: [    2.284324] DMAR-=
IR: Enabled IRQ remapping in x2apic mode
> 2025-05-21T09:18:23.199250+00:00 mc-misc2002 kernel: [    2.290386] x2api=
c enabled
> 2025-05-21T09:18:23.199251+00:00 mc-misc2002 kernel: [    2.293439] Switc=
hed APIC routing to cluster x2apic.
> 2025-05-21T09:18:23.199251+00:00 mc-misc2002 kernel: [    2.301655] ..TIM=
ER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
> 2025-05-21T09:18:23.199252+00:00 mc-misc2002 kernel: [    2.325735] clock=
source: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e4530a99b6, max_=
idle_ns: 440795257976 ns
> 2025-05-21T09:18:23.199255+00:00 mc-misc2002 kernel: [    2.337554] Calib=
rating delay loop (skipped), value calculated using timer frequency.. 4200.=
00 BogoMIPS (lpj=3D8400000)
> 2025-05-21T09:18:23.199255+00:00 mc-misc2002 kernel: [    2.341587] x86/c=
pu: VMX (outside TXT) disabled by BIOS
> 2025-05-21T09:18:23.199255+00:00 mc-misc2002 kernel: [    2.345552] x86/c=
pu: SGX disabled by BIOS.
> 2025-05-21T09:18:23.199256+00:00 mc-misc2002 kernel: [    2.349562] CPU0:=
 Thermal monitoring enabled (TM1)
> 2025-05-21T09:18:23.199256+00:00 mc-misc2002 kernel: [    2.353553] x86/c=
pu: User Mode Instruction Prevention (UMIP) activated
> 2025-05-21T09:18:23.199260+00:00 mc-misc2002 kernel: [    2.357913] proce=
ss: using mwait in idle threads
> 2025-05-21T09:18:23.199262+00:00 mc-misc2002 kernel: [    2.361554] Last =
level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> 2025-05-21T09:18:23.199263+00:00 mc-misc2002 kernel: [    2.365551] Last =
level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> 2025-05-21T09:18:23.199263+00:00 mc-misc2002 kernel: [    2.369557] Spect=
re V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> 2025-05-21T09:18:23.199264+00:00 mc-misc2002 kernel: [    2.373553] Spect=
re V2 : Spectre BHI mitigation: SW BHB clearing on vm exit
> 2025-05-21T09:18:23.199264+00:00 mc-misc2002 kernel: [    2.377551] Spect=
re V2 : Spectre BHI mitigation: SW BHB clearing on syscall
> 2025-05-21T09:18:23.199264+00:00 mc-misc2002 kernel: [    2.381551] Spect=
re V2 : Mitigation: Enhanced / Automatic IBRS
> 2025-05-21T09:18:23.199267+00:00 mc-misc2002 kernel: [    2.385551] Spect=
re V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
> 2025-05-21T09:18:23.199267+00:00 mc-misc2002 kernel: [    2.389552] Spect=
re V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> 2025-05-21T09:18:23.199267+00:00 mc-misc2002 kernel: [    2.393552] Specu=
lative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
> 2025-05-21T09:18:23.199268+00:00 mc-misc2002 kernel: [    2.397555] MMIO =
Stale Data: Mitigation: Clear CPU buffers
> 2025-05-21T09:18:23.199268+00:00 mc-misc2002 kernel: [    2.401553] GDS: =
Mitigation: Microcode
> 2025-05-21T09:18:23.199269+00:00 mc-misc2002 kernel: [    2.405552] ITS: =
Mitigation: Aligned branch/return thunks
> 2025-05-21T09:18:23.199271+00:00 mc-misc2002 kernel: [    2.409560] x86/f=
pu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> 2025-05-21T09:18:23.199272+00:00 mc-misc2002 kernel: [    2.413551] x86/f=
pu: Supporting XSAVE feature 0x002: 'SSE registers'
> 2025-05-21T09:18:23.199272+00:00 mc-misc2002 kernel: [    2.417551] x86/f=
pu: Supporting XSAVE feature 0x004: 'AVX registers'
> 2025-05-21T09:18:23.199272+00:00 mc-misc2002 kernel: [    2.421552] x86/f=
pu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
> 2025-05-21T09:18:23.199273+00:00 mc-misc2002 kernel: [    2.425551] x86/f=
pu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
> 2025-05-21T09:18:23.199273+00:00 mc-misc2002 kernel: [    2.429551] x86/f=
pu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
> 2025-05-21T09:18:23.199274+00:00 mc-misc2002 kernel: [    2.433551] x86/f=
pu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
> 2025-05-21T09:18:23.199278+00:00 mc-misc2002 kernel: [    2.437552] x86/f=
pu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> 2025-05-21T09:18:23.199278+00:00 mc-misc2002 kernel: [    2.441551] x86/f=
pu: xstate_offset[5]:  832, xstate_sizes[5]:   64
> 2025-05-21T09:18:23.199279+00:00 mc-misc2002 kernel: [    2.445551] x86/f=
pu: xstate_offset[6]:  896, xstate_sizes[6]:  512
> 2025-05-21T09:18:23.199280+00:00 mc-misc2002 kernel: [    2.449551] x86/f=
pu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
> 2025-05-21T09:18:23.199280+00:00 mc-misc2002 kernel: [    2.453551] x86/f=
pu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
> 2025-05-21T09:18:23.199281+00:00 mc-misc2002 kernel: [    2.457551] x86/f=
pu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compa=
cted' format.
> 2025-05-21T09:18:23.199283+00:00 mc-misc2002 kernel: [    2.508781] Freei=
ng SMP alternatives memory: 36K
> 2025-05-21T09:18:23.199284+00:00 mc-misc2002 kernel: [    2.509552] pid_m=
ax: default: 49152 minimum: 384
> 2025-05-21T09:18:23.199284+00:00 mc-misc2002 kernel: [    2.513622] LSM: =
Security Framework initializing
> 2025-05-21T09:18:23.199285+00:00 mc-misc2002 kernel: [    2.517572] landl=
ock: Up and running.
> 2025-05-21T09:18:23.199286+00:00 mc-misc2002 kernel: [    2.521551] Yama:=
 disabled by default; enable with sysctl kernel.yama.*
> 2025-05-21T09:18:23.199286+00:00 mc-misc2002 kernel: [    2.525580] AppAr=
mor: AppArmor initialized
> 2025-05-21T09:18:23.199288+00:00 mc-misc2002 kernel: [    2.529553] TOMOY=
O Linux initialized
> 2025-05-21T09:18:23.199289+00:00 mc-misc2002 kernel: [    2.533558] LSM s=
upport for eBPF active
> 2025-05-21T09:18:23.199289+00:00 mc-misc2002 kernel: [    2.559345] Dentr=
y cache hash table entries: 16777216 (order: 15, 134217728 bytes, vmalloc h=
ugepage)
> 2025-05-21T09:18:23.199290+00:00 mc-misc2002 kernel: [    2.570810] Inode=
-cache hash table entries: 8388608 (order: 14, 67108864 bytes, vmalloc huge=
page)
> 2025-05-21T09:18:23.199290+00:00 mc-misc2002 kernel: [    2.573916] Mount=
-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T09:18:23.199291+00:00 mc-misc2002 kernel: [    2.577869] Mount=
point-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T09:18:23.199292+00:00 mc-misc2002 kernel: [    2.582330] smpbo=
ot: CPU0: Intel(R) Xeon(R) Silver 4310 CPU @ 2.10GHz (family: 0x6, model: 0=
x6a, stepping: 0x6)
> 2025-05-21T09:18:23.199295+00:00 mc-misc2002 kernel: [    2.585711] cblis=
t_init_generic: Setting adjustable number of callback queues.
> 2025-05-21T09:18:23.199295+00:00 mc-misc2002 kernel: [    2.589552] cblis=
t_init_generic: Setting shift to 6 and lim to 1.
> 2025-05-21T09:18:23.199296+00:00 mc-misc2002 kernel: [    2.593571] cblis=
t_init_generic: Setting adjustable number of callback queues.
> 2025-05-21T09:18:23.199297+00:00 mc-misc2002 kernel: [    2.597552] cblis=
t_init_generic: Setting shift to 6 and lim to 1.
> 2025-05-21T09:18:23.199297+00:00 mc-misc2002 kernel: [    2.601574] cblis=
t_init_generic: Setting adjustable number of callback queues.
> 2025-05-21T09:18:23.199301+00:00 mc-misc2002 kernel: [    2.605551] cblis=
t_init_generic: Setting shift to 6 and lim to 1.
> 2025-05-21T09:18:23.199304+00:00 mc-misc2002 kernel: [    2.609566] Perfo=
rmance Events: PEBS fmt4+-baseline,  AnyThread deprecated, Icelake events, =
32-deep LBR, full-width counters, Intel PMU driver.
> 2025-05-21T09:18:23.199304+00:00 mc-misc2002 kernel: [    2.613552] ... v=
ersion:                5
> 2025-05-21T09:18:23.199305+00:00 mc-misc2002 kernel: [    2.617551] ... b=
it width:              48
> 2025-05-21T09:18:23.199305+00:00 mc-misc2002 kernel: [    2.621551] ... g=
eneric registers:      8
> 2025-05-21T09:18:23.199305+00:00 mc-misc2002 kernel: [    2.625551] ... v=
alue mask:             0000ffffffffffff
> 2025-05-21T09:18:23.199306+00:00 mc-misc2002 kernel: [    2.629551] ... m=
ax period:             00007fffffffffff
> 2025-05-21T09:18:23.199308+00:00 mc-misc2002 kernel: [    2.633551] ... f=
ixed-purpose events:   4
> 2025-05-21T09:18:23.199309+00:00 mc-misc2002 kernel: [    2.637551] ... e=
vent mask:             0001000f000000ff
> 2025-05-21T09:18:23.199309+00:00 mc-misc2002 kernel: [    2.641698] signa=
l: max sigframe size: 3632
> 2025-05-21T09:18:23.199309+00:00 mc-misc2002 kernel: [    2.645570] Estim=
ated ratio of average max frequency by base frequency (times 1024): 1316
> 2025-05-21T09:18:23.199310+00:00 mc-misc2002 kernel: [    2.649572] rcu: =
Hierarchical SRCU implementation.
> 2025-05-21T09:18:23.199310+00:00 mc-misc2002 kernel: [    2.653552] rcu: =
	Max phase no-delay instances is 1000.
> 2025-05-21T09:18:23.199312+00:00 mc-misc2002 kernel: [    2.661188] NMI w=
atchdog: Enabled. Permanently consumes one hw-PMU counter.
> 2025-05-21T09:18:23.199313+00:00 mc-misc2002 kernel: [    2.662058] smp: =
Bringing up secondary CPUs ...
> 2025-05-21T09:18:23.199313+00:00 mc-misc2002 kernel: [    2.665653] x86: =
Booting SMP configuration:
> 2025-05-21T09:18:23.199313+00:00 mc-misc2002 kernel: [    2.669555] .... =
node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11
> 2025-05-21T09:18:23.199318+00:00 mc-misc2002 kernel: [    2.781554] .... =
node  #1, CPUs:   #12
> 2025-05-21T09:18:23.199319+00:00 mc-misc2002 kernel: [    1.688734] smpbo=
ot: CPU 12 Converting physical 0 to logical die 1
> 2025-05-21T09:18:23.199319+00:00 mc-misc2002 kernel: [    2.927886]  #13 =
#14 #15 #16 #17 #18 #19 #20 #21 #22 #23
> 2025-05-21T09:18:23.199321+00:00 mc-misc2002 kernel: [    3.285553] .... =
node  #0, CPUs:   #24
> 2025-05-21T09:18:23.199322+00:00 mc-misc2002 kernel: [    3.287910] MMIO =
Stale Data CPU bug present and SMT on, data leak possible. See https://www.=
kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.ht=
ml for more details.
> 2025-05-21T09:18:23.199322+00:00 mc-misc2002 kernel: [    3.293685]  #25 =
#26 #27 #28 #29 #30 #31 #32 #33 #34 #35
> 2025-05-21T09:18:23.199323+00:00 mc-misc2002 kernel: [    3.321554] .... =
node  #1, CPUs:   #36 #37 #38 #39 #40 #41 #42 #43 #44 #45 #46 #47
> 2025-05-21T09:18:23.199323+00:00 mc-misc2002 kernel: [    3.350545] smp: =
Brought up 2 nodes, 48 CPUs
> 2025-05-21T09:18:23.199323+00:00 mc-misc2002 kernel: [    3.357553] smpbo=
ot: Max logical packages: 2
> 2025-05-21T09:18:23.199326+00:00 mc-misc2002 kernel: [    3.361553] smpbo=
ot: Total of 48 processors activated (202220.43 BogoMIPS)
> 2025-05-21T09:18:23.199326+00:00 mc-misc2002 kernel: [    3.425600] node =
0 deferred pages initialised in 56ms
> 2025-05-21T09:18:23.199327+00:00 mc-misc2002 kernel: [    3.429563] node =
1 deferred pages initialised in 60ms
> 2025-05-21T09:18:23.199327+00:00 mc-misc2002 kernel: [    3.447081] devtm=
pfs: initialized
> 2025-05-21T09:18:23.199327+00:00 mc-misc2002 kernel: [    3.449632] x86/m=
m: Memory block size: 2048MB
> 2025-05-21T09:18:23.199327+00:00 mc-misc2002 kernel: [    3.454799] ACPI:=
 PM: Registering ACPI NVS region [mem 0x678ff000-0x67dfefff] (5242880 bytes)
> 2025-05-21T09:18:23.199333+00:00 mc-misc2002 kernel: [    3.457704] clock=
source: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645=
041785100000 ns
> 2025-05-21T09:18:23.199333+00:00 mc-misc2002 kernel: [    3.461725] futex=
 hash table entries: 16384 (order: 8, 1048576 bytes, vmalloc)
> 2025-05-21T09:18:23.199333+00:00 mc-misc2002 kernel: [    3.465714] pinct=
rl core: initialized pinctrl subsystem
> 2025-05-21T09:18:23.199334+00:00 mc-misc2002 kernel: [    3.470950] NET: =
Registered PF_NETLINK/PF_ROUTE protocol family
> 2025-05-21T09:18:23.199334+00:00 mc-misc2002 kernel: [    3.474156] DMA: =
preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
> 2025-05-21T09:18:23.199334+00:00 mc-misc2002 kernel: [    3.478036] DMA: =
preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> 2025-05-21T09:18:23.199338+00:00 mc-misc2002 kernel: [    3.482028] DMA: =
preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> 2025-05-21T09:18:23.199338+00:00 mc-misc2002 kernel: [    3.485564] audit=
: initializing netlink subsys (disabled)
> 2025-05-21T09:18:23.199338+00:00 mc-misc2002 kernel: [    3.489580] audit=
: type=3D2000 audit(1747819077.348:1): state=3Dinitialized audit_enabled=3D=
0 res=3D1
> 2025-05-21T09:18:23.199339+00:00 mc-misc2002 kernel: [    3.489721] therm=
al_sys: Registered thermal governor 'fair_share'
> 2025-05-21T09:18:23.199340+00:00 mc-misc2002 kernel: [    3.493553] therm=
al_sys: Registered thermal governor 'bang_bang'
> 2025-05-21T09:18:23.199340+00:00 mc-misc2002 kernel: [    3.497553] therm=
al_sys: Registered thermal governor 'step_wise'
> 2025-05-21T09:18:23.199341+00:00 mc-misc2002 kernel: [    3.501552] therm=
al_sys: Registered thermal governor 'user_space'
> 2025-05-21T09:18:23.199343+00:00 mc-misc2002 kernel: [    3.505552] therm=
al_sys: Registered thermal governor 'power_allocator'
> 2025-05-21T09:18:23.199344+00:00 mc-misc2002 kernel: [    3.509592] cpuid=
le: using governor ladder
> 2025-05-21T09:18:23.199344+00:00 mc-misc2002 kernel: [    3.521585] cpuid=
le: using governor menu
> 2025-05-21T09:18:23.199344+00:00 mc-misc2002 kernel: [    3.525589] ACPI =
FADT declares the system doesn't support PCIe ASPM, so disable it
> 2025-05-21T09:18:23.199344+00:00 mc-misc2002 kernel: [    3.529554] acpip=
hp: ACPI Hot Plug PCI Controller Driver version: 0.5
> 2025-05-21T09:18:23.199345+00:00 mc-misc2002 kernel: [    3.533650] PCI: =
MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0=
x80000000)
> 2025-05-21T09:18:23.199347+00:00 mc-misc2002 kernel: [    3.537555] PCI: =
MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
> 2025-05-21T09:18:23.199348+00:00 mc-misc2002 kernel: [    3.541566] pmd_s=
et_huge: Cannot satisfy [mem 0x80000000-0x80200000] with a huge-page mappin=
g due to MTRR override.
> 2025-05-21T09:18:23.199348+00:00 mc-misc2002 kernel: [    3.545836] PCI: =
Using configuration type 1 for base access
> 2025-05-21T09:18:23.199349+00:00 mc-misc2002 kernel: [    3.550701] ENERG=
Y_PERF_BIAS: Set to 'normal', was 'performance'
> 2025-05-21T09:18:23.199349+00:00 mc-misc2002 kernel: [    3.554468] kprob=
es: kprobe jump-optimization is enabled. All kprobes are optimized if possi=
ble.
> 2025-05-21T09:18:23.199350+00:00 mc-misc2002 kernel: [    3.565611] HugeT=
LB: registered 1.00 GiB page size, pre-allocated 0 pages
> 2025-05-21T09:18:23.199357+00:00 mc-misc2002 kernel: [    3.569552] HugeT=
LB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> 2025-05-21T09:18:23.199358+00:00 mc-misc2002 kernel: [    3.577552] HugeT=
LB: registered 2.00 MiB page size, pre-allocated 0 pages
> 2025-05-21T09:18:23.199358+00:00 mc-misc2002 kernel: [    3.585551] HugeT=
LB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> 2025-05-21T09:18:23.199358+00:00 mc-misc2002 kernel: [    3.593684] ACPI:=
 Added _OSI(Module Device)
> 2025-05-21T09:18:23.199358+00:00 mc-misc2002 kernel: [    3.597553] ACPI:=
 Added _OSI(Processor Device)
> 2025-05-21T09:18:23.199359+00:00 mc-misc2002 kernel: [    3.605552] ACPI:=
 Added _OSI(3.0 _SCP Extensions)
> 2025-05-21T09:18:23.199363+00:00 mc-misc2002 kernel: [    3.609553] ACPI:=
 Added _OSI(Processor Aggregator Device)
> 2025-05-21T09:18:23.199366+00:00 mc-misc2002 kernel: [    3.764714] ACPI:=
 7 ACPI AML tables successfully acquired and loaded
> 2025-05-21T09:18:23.199366+00:00 mc-misc2002 kernel: [    3.787024] ACPI:=
 Dynamic OEM Table Load:
> 2025-05-21T09:18:23.199366+00:00 mc-misc2002 kernel: [    3.928131] ACPI:=
 Dynamic OEM Table Load:
> 2025-05-21T09:18:23.199367+00:00 mc-misc2002 kernel: [    4.182366] ACPI:=
 Interpreter enabled
> 2025-05-21T09:18:23.199367+00:00 mc-misc2002 kernel: [    4.185578] ACPI:=
 PM: (supports S0 S5)
> 2025-05-21T09:18:23.199368+00:00 mc-misc2002 kernel: [    4.189552] ACPI:=
 Using IOAPIC for interrupt routing
> 2025-05-21T09:18:23.199371+00:00 mc-misc2002 kernel: [    4.193650] HEST:=
 Table parsing has been initialized.
> 2025-05-21T09:18:23.199371+00:00 mc-misc2002 kernel: [    4.201661] GHES:=
 APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
> 2025-05-21T09:18:23.199372+00:00 mc-misc2002 kernel: [    4.209556] PCI: =
Using host bridge windows from ACPI; if necessary, use "pci=3Dnocrs" and re=
port a bug
> 2025-05-21T09:18:23.199372+00:00 mc-misc2002 kernel: [    4.221552] PCI: =
Ignoring E820 reservations for host bridge windows
> 2025-05-21T09:18:23.199373+00:00 mc-misc2002 kernel: [    4.242650] ACPI:=
 Enabled 5 GPEs in block 00 to 7F
> 2025-05-21T09:18:23.199373+00:00 mc-misc2002 kernel: [    4.345195] ACPI:=
 PCI Root Bridge [PC00] (domain 0000 [bus 00-15])
> 2025-05-21T09:18:23.199375+00:00 mc-misc2002 kernel: [    4.353557] acpi =
PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T09:18:23.199376+00:00 mc-misc2002 kernel: [    4.361867] acpi =
PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T09:18:23.199376+00:00 mc-misc2002 kernel: [    4.369769] acpi =
PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T09:18:23.199377+00:00 mc-misc2002 kernel: [    4.377552] acpi =
PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T09:18:23.199377+00:00 mc-misc2002 kernel: [    4.390300] PCI h=
ost bridge to bus 0000:00
> 2025-05-21T09:18:23.199377+00:00 mc-misc2002 kernel: [    4.393553] pci_b=
us 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> 2025-05-21T09:18:23.199382+00:00 mc-misc2002 kernel: [    4.401552] pci_b=
us 0000:00: root bus resource [io  0x1000-0x4fff window]
> 2025-05-21T09:18:23.199382+00:00 mc-misc2002 kernel: [    4.409552] pci_b=
us 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> 2025-05-21T09:18:23.199382+00:00 mc-misc2002 kernel: [    4.417552] pci_b=
us 0000:00: root bus resource [mem 0x000c8000-0x000cffff window]
> 2025-05-21T09:18:23.199382+00:00 mc-misc2002 kernel: [    4.425552] pci_b=
us 0000:00: root bus resource [mem 0xfe010000-0xfe010fff window]
> 2025-05-21T09:18:23.199383+00:00 mc-misc2002 kernel: [    4.433552] pci_b=
us 0000:00: root bus resource [mem 0x90000000-0x9b7fffff window]
> 2025-05-21T09:18:23.199383+00:00 mc-misc2002 kernel: [    4.441552] pci_b=
us 0000:00: root bus resource [mem 0x200000000000-0x200fffffffff window]
> 2025-05-21T09:18:23.199383+00:00 mc-misc2002 kernel: [    4.453553] pci_b=
us 0000:00: root bus resource [bus 00-15]
> 2025-05-21T09:18:23.199388+00:00 mc-misc2002 kernel: [    4.457576] pci 0=
000:00:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T09:18:23.199389+00:00 mc-misc2002 kernel: [    4.465663] pci 0=
000:00:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T09:18:23.199389+00:00 mc-misc2002 kernel: [    4.473628] pci 0=
000:00:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T09:18:23.199389+00:00 mc-misc2002 kernel: [    4.477628] pci 0=
000:00:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T09:18:23.199390+00:00 mc-misc2002 kernel: [    4.485632] pci 0=
000:00:01.0: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199390+00:00 mc-misc2002 kernel: [    4.493561] pci 0=
000:00:01.0: reg 0x10: [mem 0x200ffff50000-0x200ffff53fff 64bit]
> 2025-05-21T09:18:23.199392+00:00 mc-misc2002 kernel: [    4.501657] pci 0=
000:00:01.1: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199393+00:00 mc-misc2002 kernel: [    4.505561] pci 0=
000:00:01.1: reg 0x10: [mem 0x200ffff4c000-0x200ffff4ffff 64bit]
> 2025-05-21T09:18:23.199393+00:00 mc-misc2002 kernel: [    4.517658] pci 0=
000:00:01.2: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199393+00:00 mc-misc2002 kernel: [    4.521561] pci 0=
000:00:01.2: reg 0x10: [mem 0x200ffff48000-0x200ffff4bfff 64bit]
> 2025-05-21T09:18:23.199393+00:00 mc-misc2002 kernel: [    4.529656] pci 0=
000:00:01.3: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199394+00:00 mc-misc2002 kernel: [    4.537561] pci 0=
000:00:01.3: reg 0x10: [mem 0x200ffff44000-0x200ffff47fff 64bit]
> 2025-05-21T09:18:23.199394+00:00 mc-misc2002 kernel: [    4.545650] pci 0=
000:00:01.4: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199396+00:00 mc-misc2002 kernel: [    4.553561] pci 0=
000:00:01.4: reg 0x10: [mem 0x200ffff40000-0x200ffff43fff 64bit]
> 2025-05-21T09:18:23.199397+00:00 mc-misc2002 kernel: [    4.561653] pci 0=
000:00:01.5: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199397+00:00 mc-misc2002 kernel: [    4.569561] pci 0=
000:00:01.5: reg 0x10: [mem 0x200ffff3c000-0x200ffff3ffff 64bit]
> 2025-05-21T09:18:23.199397+00:00 mc-misc2002 kernel: [    4.577651] pci 0=
000:00:01.6: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199398+00:00 mc-misc2002 kernel: [    4.585561] pci 0=
000:00:01.6: reg 0x10: [mem 0x200ffff38000-0x200ffff3bfff 64bit]
> 2025-05-21T09:18:23.199398+00:00 mc-misc2002 kernel: [    4.593655] pci 0=
000:00:01.7: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199404+00:00 mc-misc2002 kernel: [    4.597561] pci 0=
000:00:01.7: reg 0x10: [mem 0x200ffff34000-0x200ffff37fff 64bit]
> 2025-05-21T09:18:23.199405+00:00 mc-misc2002 kernel: [    4.605655] pci 0=
000:00:02.0: [8086:09a6] type 00 class 0x088000
> 2025-05-21T09:18:23.199406+00:00 mc-misc2002 kernel: [    4.613559] pci 0=
000:00:02.0: reg 0x10: [mem 0x9b388000-0x9b389fff]
> 2025-05-21T09:18:23.199406+00:00 mc-misc2002 kernel: [    4.621631] pci 0=
000:00:02.1: [8086:09a7] type 00 class 0x088000
> 2025-05-21T09:18:23.199407+00:00 mc-misc2002 kernel: [    4.629559] pci 0=
000:00:02.1: reg 0x10: [mem 0x9b300000-0x9b37ffff]
> 2025-05-21T09:18:23.199407+00:00 mc-misc2002 kernel: [    4.633556] pci 0=
000:00:02.1: reg 0x14: [mem 0x9b280000-0x9b2fffff]
> 2025-05-21T09:18:23.199410+00:00 mc-misc2002 kernel: [    4.641630] pci 0=
000:00:02.4: [8086:3456] type 00 class 0x130000
> 2025-05-21T09:18:23.199410+00:00 mc-misc2002 kernel: [    4.649561] pci 0=
000:00:02.4: reg 0x10: [mem 0x200fffe00000-0x200fffefffff 64bit]
> 2025-05-21T09:18:23.199410+00:00 mc-misc2002 kernel: [    4.657558] pci 0=
000:00:02.4: reg 0x18: [mem 0x200ffff30000-0x200ffff33fff 64bit]
> 2025-05-21T09:18:23.199411+00:00 mc-misc2002 kernel: [    4.665558] pci 0=
000:00:02.4: reg 0x20: [mem 0x200ffff00000-0x200ffff1ffff 64bit]
> 2025-05-21T09:18:23.199411+00:00 mc-misc2002 kernel: [    4.673647] pci 0=
000:00:11.0: [8086:a1ec] type 00 class 0xff0000
> 2025-05-21T09:18:23.199411+00:00 mc-misc2002 kernel: [    4.681553] pci 0=
000:00:11.0: device has non-compliant BARs; disabling IO/MEM decoding
> 2025-05-21T09:18:23.199411+00:00 mc-misc2002 kernel: [    4.689652] pci 0=
000:00:11.5: [8086:a1d2] type 00 class 0x010601
> 2025-05-21T09:18:23.199416+00:00 mc-misc2002 kernel: [    4.697564] pci 0=
000:00:11.5: reg 0x10: [mem 0x9b386000-0x9b387fff]
> 2025-05-21T09:18:23.199416+00:00 mc-misc2002 kernel: [    4.705559] pci 0=
000:00:11.5: reg 0x14: [mem 0x9b38b000-0x9b38b0ff]
> 2025-05-21T09:18:23.199417+00:00 mc-misc2002 kernel: [    4.709558] pci 0=
000:00:11.5: reg 0x18: [io  0x4070-0x4077]
> 2025-05-21T09:18:23.199417+00:00 mc-misc2002 kernel: [    4.717558] pci 0=
000:00:11.5: reg 0x1c: [io  0x4060-0x4063]
> 2025-05-21T09:18:23.199417+00:00 mc-misc2002 kernel: [    4.721558] pci 0=
000:00:11.5: reg 0x20: [io  0x4020-0x403f]
> 2025-05-21T09:18:23.199417+00:00 mc-misc2002 kernel: [    4.729558] pci 0=
000:00:11.5: reg 0x24: [mem 0x9b180000-0x9b1fffff]
> 2025-05-21T09:18:23.199421+00:00 mc-misc2002 kernel: [    4.737594] pci 0=
000:00:11.5: PME# supported from D3hot
> 2025-05-21T09:18:23.199422+00:00 mc-misc2002 kernel: [    4.741778] pci 0=
000:00:14.0: [8086:a1af] type 00 class 0x0c0330
> 2025-05-21T09:18:23.199422+00:00 mc-misc2002 kernel: [    4.749569] pci 0=
000:00:14.0: reg 0x10: [mem 0x200ffff20000-0x200ffff2ffff 64bit]
> 2025-05-21T09:18:23.199423+00:00 mc-misc2002 kernel: [    4.757617] pci 0=
000:00:14.0: PME# supported from D3hot D3cold
> 2025-05-21T09:18:23.199423+00:00 mc-misc2002 kernel: [    4.765788] pci 0=
000:00:14.2: [8086:a1b1] type 00 class 0x118000
> 2025-05-21T09:18:23.199423+00:00 mc-misc2002 kernel: [    4.769568] pci 0=
000:00:14.2: reg 0x10: [mem 0x200ffff57000-0x200ffff57fff 64bit]
> 2025-05-21T09:18:23.199423+00:00 mc-misc2002 kernel: [    4.781685] pci 0=
000:00:16.0: [8086:a1ba] type 00 class 0x078000
> 2025-05-21T09:18:23.199426+00:00 mc-misc2002 kernel: [    4.785574] pci 0=
000:00:16.0: reg 0x10: [mem 0x200ffff56000-0x200ffff56fff 64bit]
> 2025-05-21T09:18:23.199427+00:00 mc-misc2002 kernel: [    4.793638] pci 0=
000:00:16.0: PME# supported from D3hot
> 2025-05-21T09:18:23.199427+00:00 mc-misc2002 kernel: [    4.801621] pci 0=
000:00:16.1: [8086:a1bb] type 00 class 0x078000
> 2025-05-21T09:18:23.199428+00:00 mc-misc2002 kernel: [    4.809574] pci 0=
000:00:16.1: reg 0x10: [mem 0x200ffff55000-0x200ffff55fff 64bit]
> 2025-05-21T09:18:23.199429+00:00 mc-misc2002 kernel: [    4.817637] pci 0=
000:00:16.1: PME# supported from D3hot
> 2025-05-21T09:18:23.199429+00:00 mc-misc2002 kernel: [    4.821623] pci 0=
000:00:16.4: [8086:a1be] type 00 class 0x078000
> 2025-05-21T09:18:23.199432+00:00 mc-misc2002 kernel: [    4.829575] pci 0=
000:00:16.4: reg 0x10: [mem 0x200ffff54000-0x200ffff54fff 64bit]
> 2025-05-21T09:18:23.199432+00:00 mc-misc2002 kernel: [    4.837638] pci 0=
000:00:16.4: PME# supported from D3hot
> 2025-05-21T09:18:23.199432+00:00 mc-misc2002 kernel: [    4.841623] pci 0=
000:00:17.0: [8086:a182] type 00 class 0x010601
> 2025-05-21T09:18:23.199433+00:00 mc-misc2002 kernel: [    4.849564] pci 0=
000:00:17.0: reg 0x10: [mem 0x9b384000-0x9b385fff]
> 2025-05-21T09:18:23.199433+00:00 mc-misc2002 kernel: [    4.857558] pci 0=
000:00:17.0: reg 0x14: [mem 0x9b38a000-0x9b38a0ff]
> 2025-05-21T09:18:23.199433+00:00 mc-misc2002 kernel: [    4.865558] pci 0=
000:00:17.0: reg 0x18: [io  0x4050-0x4057]
> 2025-05-21T09:18:23.199440+00:00 mc-misc2002 kernel: [    4.869558] pci 0=
000:00:17.0: reg 0x1c: [io  0x4040-0x4043]
> 2025-05-21T09:18:23.199441+00:00 mc-misc2002 kernel: [    4.877558] pci 0=
000:00:17.0: reg 0x20: [io  0x4000-0x401f]
> 2025-05-21T09:18:23.199441+00:00 mc-misc2002 kernel: [    4.881558] pci 0=
000:00:17.0: reg 0x24: [mem 0x9b100000-0x9b17ffff]
> 2025-05-21T09:18:23.199441+00:00 mc-misc2002 kernel: [    4.889595] pci 0=
000:00:17.0: PME# supported from D3hot
> 2025-05-21T09:18:23.199442+00:00 mc-misc2002 kernel: [    4.897770] pci 0=
000:00:1c.0: [8086:a190] type 01 class 0x060400
> 2025-05-21T09:18:23.199442+00:00 mc-misc2002 kernel: [    4.901626] pci 0=
000:00:1c.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199442+00:00 mc-misc2002 kernel: [    4.909633] pci 0=
000:00:1c.4: [8086:a194] type 01 class 0x060400
> 2025-05-21T09:18:23.199444+00:00 mc-misc2002 kernel: [    4.917626] pci 0=
000:00:1c.4: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199445+00:00 mc-misc2002 kernel: [    4.925656] pci 0=
000:00:1c.5: [8086:a195] type 01 class 0x060400
> 2025-05-21T09:18:23.199445+00:00 mc-misc2002 kernel: [    4.929625] pci 0=
000:00:1c.5: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199446+00:00 mc-misc2002 kernel: [    4.937651] pci 0=
000:00:1f.0: [8086:a1cb] type 00 class 0x060100
> 2025-05-21T09:18:23.199446+00:00 mc-misc2002 kernel: [    4.945813] pci 0=
000:00:1f.2: [8086:a1a1] type 00 class 0x058000
> 2025-05-21T09:18:23.199447+00:00 mc-misc2002 kernel: [    4.949567] pci 0=
000:00:1f.2: reg 0x10: [mem 0x9b380000-0x9b383fff]
> 2025-05-21T09:18:23.199449+00:00 mc-misc2002 kernel: [    4.957790] pci 0=
000:00:1f.4: [8086:a1a3] type 00 class 0x0c0500
> 2025-05-21T09:18:23.199451+00:00 mc-misc2002 kernel: [    4.965571] pci 0=
000:00:1f.4: reg 0x10: [mem 0x00000000-0x000000ff 64bit]
> 2025-05-21T09:18:23.199451+00:00 mc-misc2002 kernel: [    4.973574] pci 0=
000:00:1f.4: reg 0x20: [io  0x0780-0x079f]
> 2025-05-21T09:18:23.199451+00:00 mc-misc2002 kernel: [    4.977623] pci 0=
000:00:1f.5: [8086:a1a4] type 00 class 0x0c8000
> 2025-05-21T09:18:23.199451+00:00 mc-misc2002 kernel: [    4.985567] pci 0=
000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
> 2025-05-21T09:18:23.199452+00:00 mc-misc2002 kernel: [    4.993692] pci 0=
000:00:1c.0: PCI bridge to [bus 01]
> 2025-05-21T09:18:23.199452+00:00 mc-misc2002 kernel: [    4.997594] pci 0=
000:00:1c.4: PCI bridge to [bus 02]
> 2025-05-21T09:18:23.199454+00:00 mc-misc2002 kernel: [    5.005617] pci 0=
000:03:00.0: [1a03:1150] type 01 class 0x060400
> 2025-05-21T09:18:23.199455+00:00 mc-misc2002 kernel: [    5.009609] pci 0=
000:03:00.0: enabling Extended Tags
> 2025-05-21T09:18:23.199455+00:00 mc-misc2002 kernel: [    5.017624] pci 0=
000:03:00.0: supports D1 D2
> 2025-05-21T09:18:23.199456+00:00 mc-misc2002 kernel: [    5.021552] pci 0=
000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> 2025-05-21T09:18:23.199456+00:00 mc-misc2002 kernel: [    5.029689] pci 0=
000:00:1c.5: PCI bridge to [bus 03-04]
> 2025-05-21T09:18:23.199456+00:00 mc-misc2002 kernel: [    5.033554] pci 0=
000:00:1c.5:   bridge window [io  0x3000-0x3fff]
> 2025-05-21T09:18:23.199461+00:00 mc-misc2002 kernel: [    5.041553] pci 0=
000:00:1c.5:   bridge window [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T09:18:23.199461+00:00 mc-misc2002 kernel: [    5.049592] pci_b=
us 0000:04: extended config space not accessible
> 2025-05-21T09:18:23.199461+00:00 mc-misc2002 kernel: [    5.057578] pci 0=
000:04:00.0: [1a03:2000] type 00 class 0x030000
> 2025-05-21T09:18:23.199462+00:00 mc-misc2002 kernel: [    5.061570] pci 0=
000:04:00.0: reg 0x10: [mem 0x9a000000-0x9affffff]
> 2025-05-21T09:18:23.199462+00:00 mc-misc2002 kernel: [    5.069562] pci 0=
000:04:00.0: reg 0x14: [mem 0x9b000000-0x9b03ffff]
> 2025-05-21T09:18:23.199462+00:00 mc-misc2002 kernel: [    5.077561] pci 0=
000:04:00.0: reg 0x18: [io  0x3000-0x307f]
> 2025-05-21T09:18:23.199465+00:00 mc-misc2002 kernel: [    5.081632] pci 0=
000:04:00.0: supports D1 D2
> 2025-05-21T09:18:23.199465+00:00 mc-misc2002 kernel: [    5.089552] pci 0=
000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> 2025-05-21T09:18:23.199465+00:00 mc-misc2002 kernel: [    5.097646] pci 0=
000:03:00.0: PCI bridge to [bus 04]
> 2025-05-21T09:18:23.199466+00:00 mc-misc2002 kernel: [    5.101557] pci 0=
000:03:00.0:   bridge window [io  0x3000-0x3fff]
> 2025-05-21T09:18:23.199466+00:00 mc-misc2002 kernel: [    5.109554] pci 0=
000:03:00.0:   bridge window [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T09:18:23.199466+00:00 mc-misc2002 kernel: [    5.117577] pci_b=
us 0000:00: on NUMA node 0
> 2025-05-21T09:18:23.199467+00:00 mc-misc2002 kernel: [    5.118294] ACPI:=
 PCI Root Bridge [PC01] (domain 0000 [bus 16-2f])
> 2025-05-21T09:18:23.199470+00:00 mc-misc2002 kernel: [    5.121554] acpi =
PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T09:18:23.199471+00:00 mc-misc2002 kernel: [    5.134175] acpi =
PNP0A08:01: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T09:18:23.199471+00:00 mc-misc2002 kernel: [    5.141817] acpi =
PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T09:18:23.199471+00:00 mc-misc2002 kernel: [    5.153552] acpi =
PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T09:18:23.199472+00:00 mc-misc2002 kernel: [    5.161679] PCI h=
ost bridge to bus 0000:16
> 2025-05-21T09:18:23.199472+00:00 mc-misc2002 kernel: [    5.165552] pci_b=
us 0000:16: root bus resource [io  0x5000-0x6fff window]
> 2025-05-21T09:18:23.199474+00:00 mc-misc2002 kernel: [    5.173552] pci_b=
us 0000:16: root bus resource [mem 0x9b800000-0xa63fffff window]
> 2025-05-21T09:18:23.199475+00:00 mc-misc2002 kernel: [    5.181552] pci_b=
us 0000:16: root bus resource [mem 0x201000000000-0x201fffffffff window]
> 2025-05-21T09:18:23.199475+00:00 mc-misc2002 kernel: [    5.189552] pci_b=
us 0000:16: root bus resource [bus 16-2f]
> 2025-05-21T09:18:23.199476+00:00 mc-misc2002 kernel: [    5.197562] pci 0=
000:16:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T09:18:23.199477+00:00 mc-misc2002 kernel: [    5.205625] pci 0=
000:16:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T09:18:23.199477+00:00 mc-misc2002 kernel: [    5.209620] pci 0=
000:16:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T09:18:23.199479+00:00 mc-misc2002 kernel: [    5.217623] pci 0=
000:16:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T09:18:23.199484+00:00 mc-misc2002 kernel: [    5.225630] pci_b=
us 0000:16: on NUMA node 0
> 2025-05-21T09:18:23.199485+00:00 mc-misc2002 kernel: [    5.225723] ACPI:=
 PCI Root Bridge [PC02] (domain 0000 [bus 30-49])
> 2025-05-21T09:18:23.199485+00:00 mc-misc2002 kernel: [    5.229553] acpi =
PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T09:18:23.199486+00:00 mc-misc2002 kernel: [    5.242350] acpi =
PNP0A08:02: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T09:18:23.199486+00:00 mc-misc2002 kernel: [    5.249813] acpi =
PNP0A08:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T09:18:23.199486+00:00 mc-misc2002 kernel: [    5.257553] acpi =
PNP0A08:02: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T09:18:23.199489+00:00 mc-misc2002 kernel: [    5.269672] PCI h=
ost bridge to bus 0000:30
> 2025-05-21T09:18:23.199489+00:00 mc-misc2002 kernel: [    5.273552] pci_b=
us 0000:30: root bus resource [io  0x7000-0x8fff window]
> 2025-05-21T09:18:23.199493+00:00 mc-misc2002 kernel: [    5.281552] pci_b=
us 0000:30: root bus resource [mem 0xa6400000-0xb0ffffff window]
> 2025-05-21T09:18:23.199494+00:00 mc-misc2002 kernel: [    5.289552] pci_b=
us 0000:30: root bus resource [mem 0x202000000000-0x202fffffffff window]
> 2025-05-21T09:18:23.199495+00:00 mc-misc2002 kernel: [    5.297552] pci_b=
us 0000:30: root bus resource [bus 30-49]
> 2025-05-21T09:18:23.199496+00:00 mc-misc2002 kernel: [    5.305561] pci 0=
000:30:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T09:18:23.199547+00:00 mc-misc2002 kernel: [    5.309621] pci 0=
000:30:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T09:18:23.199548+00:00 mc-misc2002 kernel: [    5.317619] pci 0=
000:30:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T09:18:23.199548+00:00 mc-misc2002 kernel: [    5.325624] pci 0=
000:30:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T09:18:23.199548+00:00 mc-misc2002 kernel: [    5.333632] pci_b=
us 0000:30: on NUMA node 0
> 2025-05-21T09:18:23.199548+00:00 mc-misc2002 kernel: [    5.333742] ACPI:=
 PCI Root Bridge [PC04] (domain 0000 [bus 4a-63])
> 2025-05-21T09:18:23.199549+00:00 mc-misc2002 kernel: [    5.337553] acpi =
PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T09:18:23.199591+00:00 mc-misc2002 kernel: [    5.350526] acpi =
PNP0A08:04: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T09:18:23.199591+00:00 mc-misc2002 kernel: [    5.357818] acpi =
PNP0A08:04: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T09:18:23.199591+00:00 mc-misc2002 kernel: [    5.365552] acpi =
PNP0A08:04: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T09:18:23.199592+00:00 mc-misc2002 kernel: [    5.377673] PCI h=
ost bridge to bus 0000:4a
> 2025-05-21T09:18:23.199592+00:00 mc-misc2002 kernel: [    5.381552] pci_b=
us 0000:4a: root bus resource [io  0x9000-0x9fff window]
> 2025-05-21T09:18:23.199592+00:00 mc-misc2002 kernel: [    5.389552] pci_b=
us 0000:4a: root bus resource [mem 0xb1000000-0xbbbfffff window]
> 2025-05-21T09:18:23.199593+00:00 mc-misc2002 kernel: [    5.397552] pci_b=
us 0000:4a: root bus resource [mem 0x203000000000-0x203fffffffff window]
> 2025-05-21T09:18:23.199597+00:00 mc-misc2002 kernel: [    5.405552] pci_b=
us 0000:4a: root bus resource [bus 4a-63]
> 2025-05-21T09:18:23.199597+00:00 mc-misc2002 kernel: [    5.413561] pci 0=
000:4a:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T09:18:23.199598+00:00 mc-misc2002 kernel: [    5.417622] pci 0=
000:4a:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T09:18:23.199598+00:00 mc-misc2002 kernel: [    5.425619] pci 0=
000:4a:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T09:18:23.199598+00:00 mc-misc2002 kernel: [    5.433622] pci 0=
000:4a:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T09:18:23.199599+00:00 mc-misc2002 kernel: [    5.441627] pci 0=
000:4a:05.0: [8086:347d] type 01 class 0x060400
> 2025-05-21T09:18:23.199602+00:00 mc-misc2002 kernel: [    5.445561] pci 0=
000:4a:05.0: reg 0x10: [mem 0x203ffff00000-0x203ffff1ffff 64bit]
> 2025-05-21T09:18:23.199602+00:00 mc-misc2002 kernel: [    5.453563] pci 0=
000:4a:05.0: enabling Extended Tags
> 2025-05-21T09:18:23.199603+00:00 mc-misc2002 kernel: [    5.461583] pci 0=
000:4a:05.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199603+00:00 mc-misc2002 kernel: [    5.465968] pci 0=
000:4b:00.0: [8086:1521] type 00 class 0x020000
> 2025-05-21T09:18:23.199603+00:00 mc-misc2002 kernel: [    5.473568] pci 0=
000:4b:00.0: reg 0x10: [mem 0xbba20000-0xbba3ffff]
> 2025-05-21T09:18:23.199604+00:00 mc-misc2002 kernel: [    5.481565] pci 0=
000:4b:00.0: reg 0x18: [io  0x9020-0x903f]
> 2025-05-21T09:18:23.199605+00:00 mc-misc2002 kernel: [    5.489558] pci 0=
000:4b:00.0: reg 0x1c: [mem 0xbba44000-0xbba47fff]
> 2025-05-21T09:18:23.199607+00:00 mc-misc2002 kernel: [    5.493630] pci 0=
000:4b:00.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199608+00:00 mc-misc2002 kernel: [    5.501579] pci 0=
000:4b:00.0: reg 0x184: [mem 0x203fffe60000-0x203fffe63fff 64bit pref]
> 2025-05-21T09:18:23.199608+00:00 mc-misc2002 kernel: [    5.509552] pci 0=
000:4b:00.0: VF(n) BAR0 space: [mem 0x203fffe60000-0x203fffe7ffff 64bit pre=
f] (contains BAR0 for 8 VFs)
> 2025-05-21T09:18:23.199609+00:00 mc-misc2002 kernel: [    5.521566] pci 0=
000:4b:00.0: reg 0x190: [mem 0x203fffe40000-0x203fffe43fff 64bit pref]
> 2025-05-21T09:18:23.199609+00:00 mc-misc2002 kernel: [    5.533552] pci 0=
000:4b:00.0: VF(n) BAR3 space: [mem 0x203fffe40000-0x203fffe5ffff 64bit pre=
f] (contains BAR3 for 8 VFs)
> 2025-05-21T09:18:23.199610+00:00 mc-misc2002 kernel: [    5.545731] pci 0=
000:4b:00.1: [8086:1521] type 00 class 0x020000
> 2025-05-21T09:18:23.199612+00:00 mc-misc2002 kernel: [    5.549563] pci 0=
000:4b:00.1: reg 0x10: [mem 0xbba00000-0xbba1ffff]
> 2025-05-21T09:18:23.199613+00:00 mc-misc2002 kernel: [    5.557564] pci 0=
000:4b:00.1: reg 0x18: [io  0x9000-0x901f]
> 2025-05-21T09:18:23.199613+00:00 mc-misc2002 kernel: [    5.565559] pci 0=
000:4b:00.1: reg 0x1c: [mem 0xbba40000-0xbba43fff]
> 2025-05-21T09:18:23.199614+00:00 mc-misc2002 kernel: [    5.573637] pci 0=
000:4b:00.1: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199614+00:00 mc-misc2002 kernel: [    5.577574] pci 0=
000:4b:00.1: reg 0x184: [mem 0x203fffe20000-0x203fffe23fff 64bit pref]
> 2025-05-21T09:18:23.199614+00:00 mc-misc2002 kernel: [    5.585552] pci 0=
000:4b:00.1: VF(n) BAR0 space: [mem 0x203fffe20000-0x203fffe3ffff 64bit pre=
f] (contains BAR0 for 8 VFs)
> 2025-05-21T09:18:23.199621+00:00 mc-misc2002 kernel: [    5.601565] pci 0=
000:4b:00.1: reg 0x190: [mem 0x203fffe00000-0x203fffe03fff 64bit pref]
> 2025-05-21T09:18:23.199622+00:00 mc-misc2002 kernel: [    5.609552] pci 0=
000:4b:00.1: VF(n) BAR3 space: [mem 0x203fffe00000-0x203fffe1ffff 64bit pre=
f] (contains BAR3 for 8 VFs)
> 2025-05-21T09:18:23.199622+00:00 mc-misc2002 kernel: [    5.621679] pci 0=
000:4a:05.0: PCI bridge to [bus 4b]
> 2025-05-21T09:18:23.199623+00:00 mc-misc2002 kernel: [    5.625553] pci 0=
000:4a:05.0:   bridge window [io  0x9000-0x9fff]
> 2025-05-21T09:18:23.199624+00:00 mc-misc2002 kernel: [    5.633553] pci 0=
000:4a:05.0:   bridge window [mem 0xbba00000-0xbbafffff]
> 2025-05-21T09:18:23.199624+00:00 mc-misc2002 kernel: [    5.641554] pci 0=
000:4a:05.0:   bridge window [mem 0x203fffe00000-0x203fffefffff 64bit pref]
> 2025-05-21T09:18:23.199627+00:00 mc-misc2002 kernel: [    5.649558] pci_b=
us 0000:4a: on NUMA node 0
> 2025-05-21T09:18:23.199628+00:00 mc-misc2002 kernel: [    5.649665] ACPI:=
 PCI Root Bridge [PC05] (domain 0000 [bus 64-7d])
> 2025-05-21T09:18:23.199629+00:00 mc-misc2002 kernel: [    5.657554] acpi =
PNP0A08:05: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T09:18:23.199629+00:00 mc-misc2002 kernel: [    5.671015] acpi =
PNP0A08:05: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T09:18:23.199629+00:00 mc-misc2002 kernel: [    5.677820] acpi =
PNP0A08:05: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T09:18:23.199630+00:00 mc-misc2002 kernel: [    5.685552] acpi =
PNP0A08:05: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T09:18:23.199632+00:00 mc-misc2002 kernel: [    5.697687] PCI h=
ost bridge to bus 0000:64
> 2025-05-21T09:18:23.199633+00:00 mc-misc2002 kernel: [    5.701552] pci_b=
us 0000:64: root bus resource [io  0xa000-0xafff window]
> 2025-05-21T09:18:23.199633+00:00 mc-misc2002 kernel: [    5.709553] pci_b=
us 0000:64: root bus resource [mem 0xbbc00000-0xc5ffffff window]
> 2025-05-21T09:18:23.199633+00:00 mc-misc2002 kernel: [    5.717552] pci_b=
us 0000:64: root bus resource [mem 0x204000000000-0x204fffffffff window]
> 2025-05-21T09:18:23.199634+00:00 mc-misc2002 kernel: [    5.725552] pci_b=
us 0000:64: root bus resource [bus 64-7d]
> 2025-05-21T09:18:23.199634+00:00 mc-misc2002 kernel: [    5.733562] pci 0=
000:64:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T09:18:23.199636+00:00 mc-misc2002 kernel: [    5.737626] pci 0=
000:64:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T09:18:23.199637+00:00 mc-misc2002 kernel: [    5.745620] pci 0=
000:64:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T09:18:23.199637+00:00 mc-misc2002 kernel: [    5.753622] pci 0=
000:64:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T09:18:23.199638+00:00 mc-misc2002 kernel: [    5.757628] pci 0=
000:64:02.0: [8086:347a] type 01 class 0x060400
> 2025-05-21T09:18:23.199638+00:00 mc-misc2002 kernel: [    5.765561] pci 0=
000:64:02.0: reg 0x10: [mem 0x204ffff60000-0x204ffff7ffff 64bit]
> 2025-05-21T09:18:23.199638+00:00 mc-misc2002 kernel: [    5.773594] pci 0=
000:64:02.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199638+00:00 mc-misc2002 kernel: [    5.781805] pci 0=
000:64:03.0: [8086:347b] type 01 class 0x060400
> 2025-05-21T09:18:23.199642+00:00 mc-misc2002 kernel: [    5.789563] pci 0=
000:64:03.0: reg 0x10: [mem 0x204ffff40000-0x204ffff5ffff 64bit]
> 2025-05-21T09:18:23.199642+00:00 mc-misc2002 kernel: [    5.797567] pci 0=
000:64:03.0: enabling Extended Tags
> 2025-05-21T09:18:23.199642+00:00 mc-misc2002 kernel: [    5.801612] pci 0=
000:64:03.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199643+00:00 mc-misc2002 kernel: [    5.809796] pci 0=
000:64:04.0: [8086:347c] type 01 class 0x060400
> 2025-05-21T09:18:23.199643+00:00 mc-misc2002 kernel: [    5.817561] pci 0=
000:64:04.0: reg 0x10: [mem 0x204ffff20000-0x204ffff3ffff 64bit]
> 2025-05-21T09:18:23.199643+00:00 mc-misc2002 kernel: [    5.825563] pci 0=
000:64:04.0: enabling Extended Tags
> 2025-05-21T09:18:23.199647+00:00 mc-misc2002 kernel: [    5.829583] pci 0=
000:64:04.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199647+00:00 mc-misc2002 kernel: [    5.837796] pci 0=
000:64:05.0: [8086:347d] type 01 class 0x060400
> 2025-05-21T09:18:23.199648+00:00 mc-misc2002 kernel: [    5.845561] pci 0=
000:64:05.0: reg 0x10: [mem 0x204ffff00000-0x204ffff1ffff 64bit]
> 2025-05-21T09:18:23.199648+00:00 mc-misc2002 kernel: [    5.853564] pci 0=
000:64:05.0: enabling Extended Tags
> 2025-05-21T09:18:23.199648+00:00 mc-misc2002 kernel: [    5.857583] pci 0=
000:64:05.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199648+00:00 mc-misc2002 kernel: [    5.865932] pci 0=
000:65:00.0: [1344:51c4] type 00 class 0x010802
> 2025-05-21T09:18:23.199649+00:00 mc-misc2002 kernel: [    5.873564] pci 0=
000:65:00.0: reg 0x10: [mem 0xc5e40000-0xc5e7ffff 64bit]
> 2025-05-21T09:18:23.199652+00:00 mc-misc2002 kernel: [    5.877576] pci 0=
000:65:00.0: reg 0x30: [mem 0xc5e00000-0xc5e3ffff pref]
> 2025-05-21T09:18:23.199652+00:00 mc-misc2002 kernel: [    5.885599] pci 0=
000:65:00.0: PME# supported from D0 D1 D3hot
> 2025-05-21T09:18:23.199653+00:00 mc-misc2002 kernel: [    5.893644] pci 0=
000:64:02.0: PCI bridge to [bus 65]
> 2025-05-21T09:18:23.199653+00:00 mc-misc2002 kernel: [    5.897555] pci 0=
000:64:02.0:   bridge window [mem 0xc5e00000-0xc5efffff]
> 2025-05-21T09:18:23.199653+00:00 mc-misc2002 kernel: [    5.905680] pci 0=
000:64:03.0: PCI bridge to [bus 66]
> 2025-05-21T09:18:23.199654+00:00 mc-misc2002 kernel: [    5.913554] pci 0=
000:64:03.0:   bridge window [mem 0xc5d00000-0xc5dfffff]
> 2025-05-21T09:18:23.199657+00:00 mc-misc2002 kernel: [    5.921680] pci 0=
000:64:04.0: PCI bridge to [bus 67]
> 2025-05-21T09:18:23.199657+00:00 mc-misc2002 kernel: [    5.925554] pci 0=
000:64:04.0:   bridge window [mem 0xc5c00000-0xc5cfffff]
> 2025-05-21T09:18:23.199657+00:00 mc-misc2002 kernel: [    5.933679] pci 0=
000:64:05.0: PCI bridge to [bus 68]
> 2025-05-21T09:18:23.199658+00:00 mc-misc2002 kernel: [    5.937554] pci 0=
000:64:05.0:   bridge window [mem 0xc5b00000-0xc5bfffff]
> 2025-05-21T09:18:23.199658+00:00 mc-misc2002 kernel: [    5.945570] pci_b=
us 0000:64: on NUMA node 0
> 2025-05-21T09:18:23.199658+00:00 mc-misc2002 kernel: [    5.945664] ACPI:=
 PCI Root Bridge [UC06] (domain 0000 [bus 7e])
> 2025-05-21T09:18:23.199662+00:00 mc-misc2002 kernel: [    5.953553] acpi =
PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T09:18:23.199663+00:00 mc-misc2002 kernel: [    5.961623] acpi =
PNP0A08:06: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T09:18:23.199663+00:00 mc-misc2002 kernel: [    5.973676] acpi =
PNP0A08:06: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T09:18:23.199663+00:00 mc-misc2002 kernel: [    5.981552] acpi =
PNP0A08:06: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T09:18:23.199664+00:00 mc-misc2002 kernel: [    5.989666] PCI h=
ost bridge to bus 0000:7e
> 2025-05-21T09:18:23.199664+00:00 mc-misc2002 kernel: [    5.993552] pci_b=
us 0000:7e: root bus resource [bus 7e]
> 2025-05-21T09:18:23.199664+00:00 mc-misc2002 kernel: [    6.001561] pci 0=
000:7e:00.0: [8086:3450] type 00 class 0x088000
> 2025-05-21T09:18:23.199667+00:00 mc-misc2002 kernel: [    6.005628] pci 0=
000:7e:00.1: [8086:3451] type 00 class 0x088000
> 2025-05-21T09:18:23.199667+00:00 mc-misc2002 kernel: [    6.013613] pci 0=
000:7e:00.2: [8086:3452] type 00 class 0x088000
> 2025-05-21T09:18:23.199668+00:00 mc-misc2002 kernel: [    6.021611] pci 0=
000:7e:00.3: [8086:0998] type 00 class 0x060000
> 2025-05-21T09:18:23.199668+00:00 mc-misc2002 kernel: [    6.029620] pci 0=
000:7e:00.5: [8086:3455] type 00 class 0x088000
> 2025-05-21T09:18:23.199668+00:00 mc-misc2002 kernel: [    6.033619] pci 0=
000:7e:02.0: [8086:3440] type 00 class 0x088000
> 2025-05-21T09:18:23.199668+00:00 mc-misc2002 kernel: [    6.041693] pci 0=
000:7e:02.1: [8086:3441] type 00 class 0x088000
> 2025-05-21T09:18:23.199676+00:00 mc-misc2002 kernel: [    6.049667] pci 0=
000:7e:02.2: [8086:3442] type 00 class 0x088000
> 2025-05-21T09:18:23.199676+00:00 mc-misc2002 kernel: [    6.053672] pci 0=
000:7e:04.0: [8086:3440] type 00 class 0x088000
> 2025-05-21T09:18:23.199677+00:00 mc-misc2002 kernel: [    6.061680] pci 0=
000:7e:04.1: [8086:3441] type 00 class 0x088000
> 2025-05-21T09:18:23.199677+00:00 mc-misc2002 kernel: [    6.069676] pci 0=
000:7e:04.2: [8086:3442] type 00 class 0x088000
> 2025-05-21T09:18:23.199678+00:00 mc-misc2002 kernel: [    6.077676] pci 0=
000:7e:04.3: [8086:3443] type 00 class 0x088000
> 2025-05-21T09:18:23.199678+00:00 mc-misc2002 kernel: [    6.081679] pci 0=
000:7e:05.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T09:18:23.199680+00:00 mc-misc2002 kernel: [    6.089687] pci 0=
000:7e:05.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T09:18:23.199683+00:00 mc-misc2002 kernel: [    6.097674] pci 0=
000:7e:05.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T09:18:23.199683+00:00 mc-misc2002 kernel: [    6.101669] pci 0=
000:7e:06.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T09:18:23.199684+00:00 mc-misc2002 kernel: [    6.109650] pci 0=
000:7e:06.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T09:18:23.199684+00:00 mc-misc2002 kernel: [    6.117635] pci 0=
000:7e:06.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T09:18:23.199685+00:00 mc-misc2002 kernel: [    6.125643] pci 0=
000:7e:07.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T09:18:23.199686+00:00 mc-misc2002 kernel: [    6.129694] pci 0=
000:7e:07.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T09:18:23.199689+00:00 mc-misc2002 kernel: [    6.137680] pci 0=
000:7e:07.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T09:18:23.199695+00:00 mc-misc2002 kernel: [    6.145679] pci 0=
000:7e:0b.0: [8086:3448] type 00 class 0x088000
> 2025-05-21T09:18:23.199696+00:00 mc-misc2002 kernel: [    6.149637] pci 0=
000:7e:0b.1: [8086:3448] type 00 class 0x088000
> 2025-05-21T09:18:23.199696+00:00 mc-misc2002 kernel: [    6.157616] pci 0=
000:7e:0b.2: [8086:344b] type 00 class 0x088000
> 2025-05-21T09:18:23.199696+00:00 mc-misc2002 kernel: [    6.165623] pci 0=
000:7e:0c.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T09:18:23.199697+00:00 mc-misc2002 kernel: [    6.169663] pci 0=
000:7e:0d.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T09:18:23.199701+00:00 mc-misc2002 kernel: [    6.177655] pci 0=
000:7e:0e.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T09:18:23.199701+00:00 mc-misc2002 kernel: [    6.185694] pci 0=
000:7e:0f.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T09:18:23.199701+00:00 mc-misc2002 kernel: [    6.193708] pci 0=
000:7e:1a.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T09:18:23.199702+00:00 mc-misc2002 kernel: [    6.197661] pci 0=
000:7e:1b.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T09:18:23.199702+00:00 mc-misc2002 kernel: [    6.205660] pci 0=
000:7e:1c.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T09:18:23.199702+00:00 mc-misc2002 kernel: [    6.213702] pci 0=
000:7e:1d.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T09:18:23.199702+00:00 mc-misc2002 kernel: [    6.221698] pci_b=
us 0000:7e: on NUMA node 0
> 2025-05-21T09:18:23.199705+00:00 mc-misc2002 kernel: [    6.221774] ACPI:=
 PCI Root Bridge [UC07] (domain 0000 [bus 7f])
> 2025-05-21T09:18:23.199705+00:00 mc-misc2002 kernel: [    6.225553] acpi =
PNP0A08:07: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T09:18:23.199706+00:00 mc-misc2002 kernel: [    6.237626] acpi =
PNP0A08:07: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T09:18:23.199707+00:00 mc-misc2002 kernel: [    6.245678] acpi =
PNP0A08:07: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T09:18:23.199713+00:00 mc-misc2002 kernel: [    6.253552] acpi =
PNP0A08:07: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T09:18:23.199713+00:00 mc-misc2002 kernel: [    6.261676] PCI h=
ost bridge to bus 0000:7f
> 2025-05-21T09:18:23.199716+00:00 mc-misc2002 kernel: [    6.269553] pci_b=
us 0000:7f: root bus resource [bus 7f]
> 2025-05-21T09:18:23.199716+00:00 mc-misc2002 kernel: [    6.273567] pci 0=
000:7f:00.0: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.199717+00:00 mc-misc2002 kernel: [    6.281674] pci 0=
000:7f:00.1: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.199718+00:00 mc-misc2002 kernel: [    6.285668] pci 0=
000:7f:00.2: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.199718+00:00 mc-misc2002 kernel: [    6.293653] pci 0=
000:7f:00.3: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.199719+00:00 mc-misc2002 kernel: [    6.301677] pci 0=
000:7f:00.4: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.199721+00:00 mc-misc2002 kernel: [    6.309676] pci 0=
000:7f:00.5: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.199722+00:00 mc-misc2002 kernel: [    6.313648] pci 0=
000:7f:00.6: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.199722+00:00 mc-misc2002 kernel: [    6.321678] pci 0=
000:7f:00.7: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.199722+00:00 mc-misc2002 kernel: [    6.329690] pci 0=
000:7f:01.0: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.199722+00:00 mc-misc2002 kernel: [    6.333730] pci 0=
000:7f:01.1: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.199723+00:00 mc-misc2002 kernel: [    6.341688] pci 0=
000:7f:01.2: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.199723+00:00 mc-misc2002 kernel: [    6.349697] pci 0=
000:7f:01.3: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.199728+00:00 mc-misc2002 kernel: [    6.357704] pci 0=
000:7f:0a.0: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.199728+00:00 mc-misc2002 kernel: [    6.361677] pci 0=
000:7f:0a.1: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.199728+00:00 mc-misc2002 kernel: [    6.369672] pci 0=
000:7f:0a.2: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.199728+00:00 mc-misc2002 kernel: [    6.377653] pci 0=
000:7f:0a.3: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.199729+00:00 mc-misc2002 kernel: [    6.381676] pci 0=
000:7f:0a.4: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.199729+00:00 mc-misc2002 kernel: [    6.389676] pci 0=
000:7f:0a.5: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.199732+00:00 mc-misc2002 kernel: [    6.397640] pci 0=
000:7f:0a.6: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.199732+00:00 mc-misc2002 kernel: [    6.405678] pci 0=
000:7f:0a.7: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.199732+00:00 mc-misc2002 kernel: [    6.409683] pci 0=
000:7f:0b.0: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.199733+00:00 mc-misc2002 kernel: [    6.417723] pci 0=
000:7f:0b.1: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.199733+00:00 mc-misc2002 kernel: [    6.425695] pci 0=
000:7f:0b.2: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.199733+00:00 mc-misc2002 kernel: [    6.429697] pci 0=
000:7f:0b.3: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.199734+00:00 mc-misc2002 kernel: [    6.437712] pci 0=
000:7f:1d.0: [8086:344f] type 00 class 0x088000
> 2025-05-21T09:18:23.199737+00:00 mc-misc2002 kernel: [    6.445678] pci 0=
000:7f:1d.1: [8086:3457] type 00 class 0x088000
> 2025-05-21T09:18:23.199738+00:00 mc-misc2002 kernel: [    6.453664] pci 0=
000:7f:1e.0: [8086:3458] type 00 class 0x088000
> 2025-05-21T09:18:23.199738+00:00 mc-misc2002 kernel: [    6.457631] pci 0=
000:7f:1e.1: [8086:3459] type 00 class 0x088000
> 2025-05-21T09:18:23.199738+00:00 mc-misc2002 kernel: [    6.465617] pci 0=
000:7f:1e.2: [8086:345a] type 00 class 0x088000
> 2025-05-21T09:18:23.199739+00:00 mc-misc2002 kernel: [    6.473615] pci 0=
000:7f:1e.3: [8086:345b] type 00 class 0x088000
> 2025-05-21T09:18:23.199739+00:00 mc-misc2002 kernel: [    6.477619] pci 0=
000:7f:1e.4: [8086:345c] type 00 class 0x088000
> 2025-05-21T09:18:23.199741+00:00 mc-misc2002 kernel: [    6.485615] pci 0=
000:7f:1e.5: [8086:345d] type 00 class 0x088000
> 2025-05-21T09:18:23.199742+00:00 mc-misc2002 kernel: [    6.493615] pci 0=
000:7f:1e.6: [8086:345e] type 00 class 0x088000
> 2025-05-21T09:18:23.199742+00:00 mc-misc2002 kernel: [    6.501616] pci 0=
000:7f:1e.7: [8086:345f] type 00 class 0x088000
> 2025-05-21T09:18:23.199742+00:00 mc-misc2002 kernel: [    6.505611] pci_b=
us 0000:7f: on NUMA node 0
> 2025-05-21T09:18:23.199743+00:00 mc-misc2002 kernel: [    6.505688] ACPI:=
 PCI Root Bridge [PC06] (domain 0000 [bus 80-96])
> 2025-05-21T09:18:23.199744+00:00 mc-misc2002 kernel: [    6.513554] acpi =
PNP0A08:08: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T09:18:23.199746+00:00 mc-misc2002 kernel: [    6.526132] acpi =
PNP0A08:08: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T09:18:23.199747+00:00 mc-misc2002 kernel: [    6.533754] acpi =
PNP0A08:08: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T09:18:23.199747+00:00 mc-misc2002 kernel: [    6.541552] acpi =
PNP0A08:08: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T09:18:23.199748+00:00 mc-misc2002 kernel: [    6.549674] PCI h=
ost bridge to bus 0000:80
> 2025-05-21T09:18:23.199748+00:00 mc-misc2002 kernel: [    6.557552] pci_b=
us 0000:80: root bus resource [io  0xb000-0xbfff window]
> 2025-05-21T09:18:23.199748+00:00 mc-misc2002 kernel: [    6.561552] pci_b=
us 0000:80: root bus resource [mem 0xc6800000-0xd0ffffff window]
> 2025-05-21T09:18:23.199749+00:00 mc-misc2002 kernel: [    6.573552] pci_b=
us 0000:80: root bus resource [mem 0x205000000000-0x205fffffffff window]
> 2025-05-21T09:18:23.199756+00:00 mc-misc2002 kernel: [    6.581552] pci_b=
us 0000:80: root bus resource [bus 80-96]
> 2025-05-21T09:18:23.199756+00:00 mc-misc2002 kernel: [    6.585563] pci 0=
000:80:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T09:18:23.199757+00:00 mc-misc2002 kernel: [    6.593644] pci 0=
000:80:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T09:18:23.199757+00:00 mc-misc2002 kernel: [    6.601627] pci 0=
000:80:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T09:18:23.199757+00:00 mc-misc2002 kernel: [    6.605628] pci 0=
000:80:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T09:18:23.199757+00:00 mc-misc2002 kernel: [    6.613633] pci 0=
000:80:01.0: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199760+00:00 mc-misc2002 kernel: [    6.621562] pci 0=
000:80:01.0: reg 0x10: [mem 0x205ffff40000-0x205ffff43fff 64bit]
> 2025-05-21T09:18:23.199761+00:00 mc-misc2002 kernel: [    6.629660] pci 0=
000:80:01.1: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199762+00:00 mc-misc2002 kernel: [    6.637563] pci 0=
000:80:01.1: reg 0x10: [mem 0x205ffff3c000-0x205ffff3ffff 64bit]
> 2025-05-21T09:18:23.199762+00:00 mc-misc2002 kernel: [    6.645654] pci 0=
000:80:01.2: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199762+00:00 mc-misc2002 kernel: [    6.649562] pci 0=
000:80:01.2: reg 0x10: [mem 0x205ffff38000-0x205ffff3bfff 64bit]
> 2025-05-21T09:18:23.199763+00:00 mc-misc2002 kernel: [    6.661653] pci 0=
000:80:01.3: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199765+00:00 mc-misc2002 kernel: [    6.665562] pci 0=
000:80:01.3: reg 0x10: [mem 0x205ffff34000-0x205ffff37fff 64bit]
> 2025-05-21T09:18:23.199765+00:00 mc-misc2002 kernel: [    6.673691] pci 0=
000:80:01.4: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199766+00:00 mc-misc2002 kernel: [    6.681562] pci 0=
000:80:01.4: reg 0x10: [mem 0x205ffff30000-0x205ffff33fff 64bit]
> 2025-05-21T09:18:23.199766+00:00 mc-misc2002 kernel: [    6.689667] pci 0=
000:80:01.5: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199766+00:00 mc-misc2002 kernel: [    6.697563] pci 0=
000:80:01.5: reg 0x10: [mem 0x205ffff2c000-0x205ffff2ffff 64bit]
> 2025-05-21T09:18:23.199766+00:00 mc-misc2002 kernel: [    6.705654] pci 0=
000:80:01.6: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199767+00:00 mc-misc2002 kernel: [    6.713563] pci 0=
000:80:01.6: reg 0x10: [mem 0x205ffff28000-0x205ffff2bfff 64bit]
> 2025-05-21T09:18:23.199769+00:00 mc-misc2002 kernel: [    6.721654] pci 0=
000:80:01.7: [8086:0b00] type 00 class 0x088000
> 2025-05-21T09:18:23.199769+00:00 mc-misc2002 kernel: [    6.729562] pci 0=
000:80:01.7: reg 0x10: [mem 0x205ffff24000-0x205ffff27fff 64bit]
> 2025-05-21T09:18:23.199769+00:00 mc-misc2002 kernel: [    6.737657] pci 0=
000:80:02.0: [8086:09a6] type 00 class 0x088000
> 2025-05-21T09:18:23.199770+00:00 mc-misc2002 kernel: [    6.741560] pci 0=
000:80:02.0: reg 0x10: [mem 0xd0f80000-0xd0f81fff]
> 2025-05-21T09:18:23.199770+00:00 mc-misc2002 kernel: [    6.749614] pci 0=
000:80:02.1: [8086:09a7] type 00 class 0x088000
> 2025-05-21T09:18:23.199770+00:00 mc-misc2002 kernel: [    6.757560] pci 0=
000:80:02.1: reg 0x10: [mem 0xd0f00000-0xd0f7ffff]
> 2025-05-21T09:18:23.199773+00:00 mc-misc2002 kernel: [    6.765556] pci 0=
000:80:02.1: reg 0x14: [mem 0xd0e80000-0xd0efffff]
> 2025-05-21T09:18:23.199774+00:00 mc-misc2002 kernel: [    6.769612] pci 0=
000:80:02.4: [8086:3456] type 00 class 0x130000
> 2025-05-21T09:18:23.199774+00:00 mc-misc2002 kernel: [    6.777562] pci 0=
000:80:02.4: reg 0x10: [mem 0x205fffe00000-0x205fffefffff 64bit]
> 2025-05-21T09:18:23.199774+00:00 mc-misc2002 kernel: [    6.785559] pci 0=
000:80:02.4: reg 0x18: [mem 0x205ffff20000-0x205ffff23fff 64bit]
> 2025-05-21T09:18:23.199775+00:00 mc-misc2002 kernel: [    6.793559] pci 0=
000:80:02.4: reg 0x20: [mem 0x205ffff00000-0x205ffff1ffff 64bit]
> 2025-05-21T09:18:23.199775+00:00 mc-misc2002 kernel: [    6.801624] pci_b=
us 0000:80: on NUMA node 1
> 2025-05-21T09:18:23.199775+00:00 mc-misc2002 kernel: [    6.801696] ACPI:=
 PCI Root Bridge [PC07] (domain 0000 [bus 97-af])
> 2025-05-21T09:18:23.199777+00:00 mc-misc2002 kernel: [    6.809553] acpi =
PNP0A08:09: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T09:18:23.199778+00:00 mc-misc2002 kernel: [    6.822539] acpi =
PNP0A08:09: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T09:18:23.199778+00:00 mc-misc2002 kernel: [    6.830073] acpi =
PNP0A08:09: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T09:18:23.199778+00:00 mc-misc2002 kernel: [    6.837553] acpi =
PNP0A08:09: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T09:18:23.199779+00:00 mc-misc2002 kernel: [    6.849676] PCI h=
ost bridge to bus 0000:97
> 2025-05-21T09:18:23.199779+00:00 mc-misc2002 kernel: [    6.853552] pci_b=
us 0000:97: root bus resource [io  0xc000-0xcfff window]
> 2025-05-21T09:18:23.199781+00:00 mc-misc2002 kernel: [    6.861552] pci_b=
us 0000:97: root bus resource [mem 0xd1000000-0xdbbfffff window]
> 2025-05-21T09:18:23.199782+00:00 mc-misc2002 kernel: [    6.869552] pci_b=
us 0000:97: root bus resource [mem 0x206000000000-0x206fffffffff window]
> 2025-05-21T09:18:23.199782+00:00 mc-misc2002 kernel: [    6.877552] pci_b=
us 0000:97: root bus resource [bus 97-af]
> 2025-05-21T09:18:23.199782+00:00 mc-misc2002 kernel: [    6.885563] pci 0=
000:97:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T09:18:23.199783+00:00 mc-misc2002 kernel: [    6.889630] pci 0=
000:97:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T09:18:23.199783+00:00 mc-misc2002 kernel: [    6.897627] pci 0=
000:97:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T09:18:23.199785+00:00 mc-misc2002 kernel: [    6.905626] pci 0=
000:97:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T09:18:23.199786+00:00 mc-misc2002 kernel: [    6.909632] pci 0=
000:97:04.0: [8086:347c] type 01 class 0x060400
> 2025-05-21T09:18:23.199786+00:00 mc-misc2002 kernel: [    6.917562] pci 0=
000:97:04.0: reg 0x10: [mem 0x206ffff00000-0x206ffff1ffff 64bit]
> 2025-05-21T09:18:23.199786+00:00 mc-misc2002 kernel: [    6.925598] pci 0=
000:97:04.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199786+00:00 mc-misc2002 kernel: [    6.933960] acpip=
hp: Slot [0-2] registered
> 2025-05-21T09:18:23.199787+00:00 mc-misc2002 kernel: [    6.937589] pci 0=
000:98:00.0: [14e4:16d7] type 00 class 0x020000
> 2025-05-21T09:18:23.199787+00:00 mc-misc2002 kernel: [    6.945571] pci 0=
000:98:00.0: reg 0x10: [mem 0x206fffe10000-0x206fffe1ffff 64bit pref]
> 2025-05-21T09:18:23.199789+00:00 mc-misc2002 kernel: [    6.953562] pci 0=
000:98:00.0: reg 0x18: [mem 0x206fffd00000-0x206fffdfffff 64bit pref]
> 2025-05-21T09:18:23.199790+00:00 mc-misc2002 kernel: [    6.961562] pci 0=
000:98:00.0: reg 0x20: [mem 0x206fffe22000-0x206fffe23fff 64bit pref]
> 2025-05-21T09:18:23.199790+00:00 mc-misc2002 kernel: [    6.973569] pci 0=
000:98:00.0: reg 0x30: [mem 0xdba40000-0xdba7ffff pref]
> 2025-05-21T09:18:23.199790+00:00 mc-misc2002 kernel: [    6.977623] pci 0=
000:98:00.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199791+00:00 mc-misc2002 kernel: [    6.985744] pci 0=
000:98:00.1: [14e4:16d7] type 00 class 0x020000
> 2025-05-21T09:18:23.199791+00:00 mc-misc2002 kernel: [    6.993568] pci 0=
000:98:00.1: reg 0x10: [mem 0x206fffe00000-0x206fffe0ffff 64bit pref]
> 2025-05-21T09:18:23.199793+00:00 mc-misc2002 kernel: [    7.001562] pci 0=
000:98:00.1: reg 0x18: [mem 0x206fffc00000-0x206fffcfffff 64bit pref]
> 2025-05-21T09:18:23.199794+00:00 mc-misc2002 kernel: [    7.009563] pci 0=
000:98:00.1: reg 0x20: [mem 0x206fffe20000-0x206fffe21fff 64bit pref]
> 2025-05-21T09:18:23.199794+00:00 mc-misc2002 kernel: [    7.021558] pci 0=
000:98:00.1: reg 0x30: [mem 0xdba00000-0xdba3ffff pref]
> 2025-05-21T09:18:23.199794+00:00 mc-misc2002 kernel: [    7.025621] pci 0=
000:98:00.1: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199795+00:00 mc-misc2002 kernel: [    7.033678] pci 0=
000:97:04.0: PCI bridge to [bus 98]
> 2025-05-21T09:18:23.199795+00:00 mc-misc2002 kernel: [    7.041554] pci 0=
000:97:04.0:   bridge window [mem 0xdba00000-0xdbafffff]
> 2025-05-21T09:18:23.199797+00:00 mc-misc2002 kernel: [    7.045554] pci 0=
000:97:04.0:   bridge window [mem 0x206fffc00000-0x206fffefffff 64bit pref]
> 2025-05-21T09:18:23.199798+00:00 mc-misc2002 kernel: [    7.057558] pci_b=
us 0000:97: on NUMA node 1
> 2025-05-21T09:18:23.199798+00:00 mc-misc2002 kernel: [    7.057665] ACPI:=
 PCI Root Bridge [PC08] (domain 0000 [bus b0-c8])
> 2025-05-21T09:18:23.199798+00:00 mc-misc2002 kernel: [    7.065553] acpi =
PNP0A08:0a: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T09:18:23.199798+00:00 mc-misc2002 kernel: [    7.074358] acpi =
PNP0A08:0a: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T09:18:23.199799+00:00 mc-misc2002 kernel: [    7.081818] acpi =
PNP0A08:0a: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T09:18:23.199799+00:00 mc-misc2002 kernel: [    7.093553] acpi =
PNP0A08:0a: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T09:18:23.199801+00:00 mc-misc2002 kernel: [    7.101682] PCI h=
ost bridge to bus 0000:b0
> 2025-05-21T09:18:23.199802+00:00 mc-misc2002 kernel: [    7.105552] pci_b=
us 0000:b0: root bus resource [io  0xd000-0xdfff window]
> 2025-05-21T09:18:23.199802+00:00 mc-misc2002 kernel: [    7.113552] pci_b=
us 0000:b0: root bus resource [mem 0xdbc00000-0xe67fffff window]
> 2025-05-21T09:18:23.199802+00:00 mc-misc2002 kernel: [    7.121552] pci_b=
us 0000:b0: root bus resource [mem 0x207000000000-0x207fffffffff window]
> 2025-05-21T09:18:23.199802+00:00 mc-misc2002 kernel: [    7.129552] pci_b=
us 0000:b0: root bus resource [bus b0-c8]
> 2025-05-21T09:18:23.199803+00:00 mc-misc2002 kernel: [    7.137563] pci 0=
000:b0:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T09:18:23.199805+00:00 mc-misc2002 kernel: [    7.145630] pci 0=
000:b0:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T09:18:23.199806+00:00 mc-misc2002 kernel: [    7.149626] pci 0=
000:b0:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T09:18:23.199806+00:00 mc-misc2002 kernel: [    7.157626] pci 0=
000:b0:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T09:18:23.199806+00:00 mc-misc2002 kernel: [    7.165636] pci_b=
us 0000:b0: on NUMA node 1
> 2025-05-21T09:18:23.199806+00:00 mc-misc2002 kernel: [    7.165758] ACPI:=
 PCI Root Bridge [PC10] (domain 0000 [bus c9-e1])
> 2025-05-21T09:18:23.199807+00:00 mc-misc2002 kernel: [    7.173553] acpi =
PNP0A08:0c: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T09:18:23.199809+00:00 mc-misc2002 kernel: [    7.183289] acpi =
PNP0A08:0c: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T09:18:23.199809+00:00 mc-misc2002 kernel: [    7.193820] acpi =
PNP0A08:0c: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T09:18:23.199810+00:00 mc-misc2002 kernel: [    7.201553] acpi =
PNP0A08:0c: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T09:18:23.199810+00:00 mc-misc2002 kernel: [    7.209681] PCI h=
ost bridge to bus 0000:c9
> 2025-05-21T09:18:23.199810+00:00 mc-misc2002 kernel: [    7.213552] pci_b=
us 0000:c9: root bus resource [io  0xe000-0xefff window]
> 2025-05-21T09:18:23.199811+00:00 mc-misc2002 kernel: [    7.221552] pci_b=
us 0000:c9: root bus resource [mem 0xe6800000-0xf13fffff window]
> 2025-05-21T09:18:23.199811+00:00 mc-misc2002 kernel: [    7.229552] pci_b=
us 0000:c9: root bus resource [mem 0x208000000000-0x208fffffffff window]
> 2025-05-21T09:18:23.199813+00:00 mc-misc2002 kernel: [    7.241552] pci_b=
us 0000:c9: root bus resource [bus c9-e1]
> 2025-05-21T09:18:23.199814+00:00 mc-misc2002 kernel: [    7.245562] pci 0=
000:c9:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T09:18:23.199814+00:00 mc-misc2002 kernel: [    7.253628] pci 0=
000:c9:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T09:18:23.199814+00:00 mc-misc2002 kernel: [    7.261626] pci 0=
000:c9:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T09:18:23.199815+00:00 mc-misc2002 kernel: [    7.265626] pci 0=
000:c9:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T09:18:23.199815+00:00 mc-misc2002 kernel: [    7.273638] pci 0=
000:c9:02.0: [8086:347a] type 01 class 0x060400
> 2025-05-21T09:18:23.199817+00:00 mc-misc2002 kernel: [    7.281562] pci 0=
000:c9:02.0: reg 0x10: [mem 0x208ffff20000-0x208ffff3ffff 64bit]
> 2025-05-21T09:18:23.199818+00:00 mc-misc2002 kernel: [    7.289565] pci 0=
000:c9:02.0: enabling Extended Tags
> 2025-05-21T09:18:23.199818+00:00 mc-misc2002 kernel: [    7.293589] pci 0=
000:c9:02.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199818+00:00 mc-misc2002 kernel: [    7.301818] pci 0=
000:c9:03.0: [8086:347b] type 01 class 0x060400
> 2025-05-21T09:18:23.199819+00:00 mc-misc2002 kernel: [    7.309565] pci 0=
000:c9:03.0: reg 0x10: [mem 0x208ffff00000-0x208ffff1ffff 64bit]
> 2025-05-21T09:18:23.199819+00:00 mc-misc2002 kernel: [    7.317568] pci 0=
000:c9:03.0: enabling Extended Tags
> 2025-05-21T09:18:23.199821+00:00 mc-misc2002 kernel: [    7.321609] pci 0=
000:c9:03.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199821+00:00 mc-misc2002 kernel: [    7.329942] pci 0=
000:c9:02.0: PCI bridge to [bus ca]
> 2025-05-21T09:18:23.199822+00:00 mc-misc2002 kernel: [    7.333554] pci 0=
000:c9:02.0:   bridge window [mem 0xf1200000-0xf12fffff]
> 2025-05-21T09:18:23.199822+00:00 mc-misc2002 kernel: [    7.341684] pci 0=
000:c9:03.0: PCI bridge to [bus cb]
> 2025-05-21T09:18:23.199822+00:00 mc-misc2002 kernel: [    7.349554] pci 0=
000:c9:03.0:   bridge window [mem 0xf1100000-0xf11fffff]
> 2025-05-21T09:18:23.199823+00:00 mc-misc2002 kernel: [    7.357563] pci_b=
us 0000:c9: on NUMA node 1
> 2025-05-21T09:18:23.199823+00:00 mc-misc2002 kernel: [    7.357678] ACPI:=
 PCI Root Bridge [PC11] (domain 0000 [bus e2-fa])
> 2025-05-21T09:18:23.199825+00:00 mc-misc2002 kernel: [    7.361553] acpi =
PNP0A08:0d: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T09:18:23.199826+00:00 mc-misc2002 kernel: [    7.375027] acpi =
PNP0A08:0d: _OSC: platform does not support [SHPCHotplug AER]
> 2025-05-21T09:18:23.199826+00:00 mc-misc2002 kernel: [    7.381824] acpi =
PNP0A08:0d: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> 2025-05-21T09:18:23.199826+00:00 mc-misc2002 kernel: [    7.393553] acpi =
PNP0A08:0d: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T09:18:23.199826+00:00 mc-misc2002 kernel: [    7.401683] PCI h=
ost bridge to bus 0000:e2
> 2025-05-21T09:18:23.199827+00:00 mc-misc2002 kernel: [    7.405552] pci_b=
us 0000:e2: root bus resource [io  0xf000-0xffff window]
> 2025-05-21T09:18:23.199829+00:00 mc-misc2002 kernel: [    7.413552] pci_b=
us 0000:e2: root bus resource [mem 0xf1400000-0xfb7fffff window]
> 2025-05-21T09:18:23.199830+00:00 mc-misc2002 kernel: [    7.421552] pci_b=
us 0000:e2: root bus resource [mem 0x209000000000-0x209fffffffff window]
> 2025-05-21T09:18:23.199830+00:00 mc-misc2002 kernel: [    7.429552] pci_b=
us 0000:e2: root bus resource [bus e2-fa]
> 2025-05-21T09:18:23.199830+00:00 mc-misc2002 kernel: [    7.437562] pci 0=
000:e2:00.0: [8086:09a2] type 00 class 0x088000
> 2025-05-21T09:18:23.199831+00:00 mc-misc2002 kernel: [    7.445630] pci 0=
000:e2:00.1: [8086:09a4] type 00 class 0x088000
> 2025-05-21T09:18:23.199831+00:00 mc-misc2002 kernel: [    7.449627] pci 0=
000:e2:00.2: [8086:09a3] type 00 class 0x088000
> 2025-05-21T09:18:23.199834+00:00 mc-misc2002 kernel: [    7.457628] pci 0=
000:e2:00.4: [8086:0998] type 00 class 0x060000
> 2025-05-21T09:18:23.199834+00:00 mc-misc2002 kernel: [    7.465633] pci 0=
000:e2:02.0: [8086:347a] type 01 class 0x060400
> 2025-05-21T09:18:23.199835+00:00 mc-misc2002 kernel: [    7.469562] pci 0=
000:e2:02.0: reg 0x10: [mem 0x209ffff60000-0x209ffff7ffff 64bit]
> 2025-05-21T09:18:23.199835+00:00 mc-misc2002 kernel: [    7.481565] pci 0=
000:e2:02.0: enabling Extended Tags
> 2025-05-21T09:18:23.199835+00:00 mc-misc2002 kernel: [    7.485590] pci 0=
000:e2:02.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199836+00:00 mc-misc2002 kernel: [    7.493813] pci 0=
000:e2:03.0: [8086:347b] type 01 class 0x060400
> 2025-05-21T09:18:23.199836+00:00 mc-misc2002 kernel: [    7.497565] pci 0=
000:e2:03.0: reg 0x10: [mem 0x209ffff40000-0x209ffff5ffff 64bit]
> 2025-05-21T09:18:23.199838+00:00 mc-misc2002 kernel: [    7.509565] pci 0=
000:e2:03.0: enabling Extended Tags
> 2025-05-21T09:18:23.199839+00:00 mc-misc2002 kernel: [    7.513591] pci 0=
000:e2:03.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199839+00:00 mc-misc2002 kernel: [    7.521821] pci 0=
000:e2:04.0: [8086:347c] type 01 class 0x060400
> 2025-05-21T09:18:23.199839+00:00 mc-misc2002 kernel: [    7.525563] pci 0=
000:e2:04.0: reg 0x10: [mem 0x209ffff20000-0x209ffff3ffff 64bit]
> 2025-05-21T09:18:23.199840+00:00 mc-misc2002 kernel: [    7.533565] pci 0=
000:e2:04.0: enabling Extended Tags
> 2025-05-21T09:18:23.199840+00:00 mc-misc2002 kernel: [    7.541590] pci 0=
000:e2:04.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199843+00:00 mc-misc2002 kernel: [    7.549812] pci 0=
000:e2:05.0: [8086:347d] type 01 class 0x060400
> 2025-05-21T09:18:23.199843+00:00 mc-misc2002 kernel: [    7.553562] pci 0=
000:e2:05.0: reg 0x10: [mem 0x209ffff00000-0x209ffff1ffff 64bit]
> 2025-05-21T09:18:23.199843+00:00 mc-misc2002 kernel: [    7.561565] pci 0=
000:e2:05.0: enabling Extended Tags
> 2025-05-21T09:18:23.199844+00:00 mc-misc2002 kernel: [    7.569589] pci 0=
000:e2:05.0: PME# supported from D0 D3hot D3cold
> 2025-05-21T09:18:23.199844+00:00 mc-misc2002 kernel: [    7.577939] pci 0=
000:e2:02.0: PCI bridge to [bus e3]
> 2025-05-21T09:18:23.199844+00:00 mc-misc2002 kernel: [    7.581556] pci 0=
000:e2:02.0:   bridge window [mem 0xfb600000-0xfb6fffff]
> 2025-05-21T09:18:23.199844+00:00 mc-misc2002 kernel: [    7.589685] pci 0=
000:e2:03.0: PCI bridge to [bus e4]
> 2025-05-21T09:18:23.199847+00:00 mc-misc2002 kernel: [    7.593554] pci 0=
000:e2:03.0:   bridge window [mem 0xfb500000-0xfb5fffff]
> 2025-05-21T09:18:23.199847+00:00 mc-misc2002 kernel: [    7.601686] pci 0=
000:e2:04.0: PCI bridge to [bus e5]
> 2025-05-21T09:18:23.199849+00:00 mc-misc2002 kernel: [    7.609554] pci 0=
000:e2:04.0:   bridge window [mem 0xfb400000-0xfb4fffff]
> 2025-05-21T09:18:23.199850+00:00 mc-misc2002 kernel: [    7.617684] pci 0=
000:e2:05.0: PCI bridge to [bus e6]
> 2025-05-21T09:18:23.199850+00:00 mc-misc2002 kernel: [    7.621554] pci 0=
000:e2:05.0:   bridge window [mem 0xfb300000-0xfb3fffff]
> 2025-05-21T09:18:23.199850+00:00 mc-misc2002 kernel: [    7.629572] pci_b=
us 0000:e2: on NUMA node 1
> 2025-05-21T09:18:23.199853+00:00 mc-misc2002 kernel: [    7.629675] ACPI:=
 PCI Root Bridge [UC16] (domain 0000 [bus fe])
> 2025-05-21T09:18:23.199853+00:00 mc-misc2002 kernel: [    7.637553] acpi =
PNP0A08:0e: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T09:18:23.199853+00:00 mc-misc2002 kernel: [    7.645622] acpi =
PNP0A08:0e: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T09:18:23.199854+00:00 mc-misc2002 kernel: [    7.653679] acpi =
PNP0A08:0e: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T09:18:23.199854+00:00 mc-misc2002 kernel: [    7.665552] acpi =
PNP0A08:0e: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T09:18:23.199854+00:00 mc-misc2002 kernel: [    7.673671] PCI h=
ost bridge to bus 0000:fe
> 2025-05-21T09:18:23.199857+00:00 mc-misc2002 kernel: [    7.677555] pci_b=
us 0000:fe: root bus resource [bus fe]
> 2025-05-21T09:18:23.199857+00:00 mc-misc2002 kernel: [    7.681567] pci 0=
000:fe:00.0: [8086:3450] type 00 class 0x088000
> 2025-05-21T09:18:23.199858+00:00 mc-misc2002 kernel: [    7.689637] pci 0=
000:fe:00.1: [8086:3451] type 00 class 0x088000
> 2025-05-21T09:18:23.199861+00:00 mc-misc2002 kernel: [    7.697618] pci 0=
000:fe:00.2: [8086:3452] type 00 class 0x088000
> 2025-05-21T09:18:23.199861+00:00 mc-misc2002 kernel: [    7.705618] pci 0=
000:fe:00.3: [8086:0998] type 00 class 0x060000
> 2025-05-21T09:18:23.199862+00:00 mc-misc2002 kernel: [    7.709618] pci 0=
000:fe:00.5: [8086:3455] type 00 class 0x088000
> 2025-05-21T09:18:23.199862+00:00 mc-misc2002 kernel: [    7.717632] pci 0=
000:fe:02.0: [8086:3440] type 00 class 0x088000
> 2025-05-21T09:18:23.199864+00:00 mc-misc2002 kernel: [    7.725694] pci 0=
000:fe:02.1: [8086:3441] type 00 class 0x088000
> 2025-05-21T09:18:23.199865+00:00 mc-misc2002 kernel: [    7.729674] pci 0=
000:fe:02.2: [8086:3442] type 00 class 0x088000
> 2025-05-21T09:18:23.199865+00:00 mc-misc2002 kernel: [    7.737679] pci 0=
000:fe:04.0: [8086:3440] type 00 class 0x088000
> 2025-05-21T09:18:23.199865+00:00 mc-misc2002 kernel: [    7.745686] pci 0=
000:fe:04.1: [8086:3441] type 00 class 0x088000
> 2025-05-21T09:18:23.199866+00:00 mc-misc2002 kernel: [    7.753683] pci 0=
000:fe:04.2: [8086:3442] type 00 class 0x088000
> 2025-05-21T09:18:23.199866+00:00 mc-misc2002 kernel: [    7.757682] pci 0=
000:fe:04.3: [8086:3443] type 00 class 0x088000
> 2025-05-21T09:18:23.199868+00:00 mc-misc2002 kernel: [    7.765686] pci 0=
000:fe:05.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T09:18:23.199869+00:00 mc-misc2002 kernel: [    7.773698] pci 0=
000:fe:05.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T09:18:23.200112+00:00 mc-misc2002 kernel: [    7.777678] pci 0=
000:fe:05.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T09:18:23.200113+00:00 mc-misc2002 kernel: [    7.785681] pci 0=
000:fe:06.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T09:18:23.200113+00:00 mc-misc2002 kernel: [    7.793658] pci 0=
000:fe:06.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T09:18:23.200113+00:00 mc-misc2002 kernel: [    7.801641] pci 0=
000:fe:06.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T09:18:23.200116+00:00 mc-misc2002 kernel: [    7.805651] pci 0=
000:fe:07.0: [8086:3445] type 00 class 0x088000
> 2025-05-21T09:18:23.200116+00:00 mc-misc2002 kernel: [    7.813703] pci 0=
000:fe:07.1: [8086:3446] type 00 class 0x088000
> 2025-05-21T09:18:23.200117+00:00 mc-misc2002 kernel: [    7.821686] pci 0=
000:fe:07.2: [8086:3447] type 00 class 0x088000
> 2025-05-21T09:18:23.200117+00:00 mc-misc2002 kernel: [    7.825690] pci 0=
000:fe:0b.0: [8086:3448] type 00 class 0x088000
> 2025-05-21T09:18:23.200117+00:00 mc-misc2002 kernel: [    7.833639] pci 0=
000:fe:0b.1: [8086:3448] type 00 class 0x088000
> 2025-05-21T09:18:23.200117+00:00 mc-misc2002 kernel: [    7.841620] pci 0=
000:fe:0b.2: [8086:344b] type 00 class 0x088000
> 2025-05-21T09:18:23.200118+00:00 mc-misc2002 kernel: [    7.849630] pci 0=
000:fe:0c.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T09:18:23.200120+00:00 mc-misc2002 kernel: [    7.853669] pci 0=
000:fe:0d.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T09:18:23.200121+00:00 mc-misc2002 kernel: [    7.861664] pci 0=
000:fe:0e.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T09:18:23.200121+00:00 mc-misc2002 kernel: [    7.869701] pci 0=
000:fe:0f.0: [8086:344a] type 00 class 0x110100
> 2025-05-21T09:18:23.200121+00:00 mc-misc2002 kernel: [    7.873716] pci 0=
000:fe:1a.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T09:18:23.200122+00:00 mc-misc2002 kernel: [    7.881672] pci 0=
000:fe:1b.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T09:18:23.200122+00:00 mc-misc2002 kernel: [    7.889662] pci 0=
000:fe:1c.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T09:18:23.200124+00:00 mc-misc2002 kernel: [    7.897709] pci 0=
000:fe:1d.0: [8086:2880] type 00 class 0x110100
> 2025-05-21T09:18:23.200125+00:00 mc-misc2002 kernel: [    7.901707] pci_b=
us 0000:fe: on NUMA node 1
> 2025-05-21T09:18:23.200125+00:00 mc-misc2002 kernel: [    7.901780] ACPI:=
 PCI Root Bridge [UC17] (domain 0000 [bus ff])
> 2025-05-21T09:18:23.200125+00:00 mc-misc2002 kernel: [    7.909554] acpi =
PNP0A08:0f: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX=
-Type3]
> 2025-05-21T09:18:23.200125+00:00 mc-misc2002 kernel: [    7.921624] acpi =
PNP0A08:0f: _OSC: platform does not support [SHPCHotplug AER LTR]
> 2025-05-21T09:18:23.200126+00:00 mc-misc2002 kernel: [    7.929680] acpi =
PNP0A08:0f: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> 2025-05-21T09:18:23.200127+00:00 mc-misc2002 kernel: [    7.937552] acpi =
PNP0A08:0f: FADT indicates ASPM is unsupported, using BIOS configuration
> 2025-05-21T09:18:23.200128+00:00 mc-misc2002 kernel: [    7.945677] PCI h=
ost bridge to bus 0000:ff
> 2025-05-21T09:18:23.200129+00:00 mc-misc2002 kernel: [    7.949552] pci_b=
us 0000:ff: root bus resource [bus ff]
> 2025-05-21T09:18:23.200129+00:00 mc-misc2002 kernel: [    7.957569] pci 0=
000:ff:00.0: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.200129+00:00 mc-misc2002 kernel: [    7.961691] pci 0=
000:ff:00.1: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.200130+00:00 mc-misc2002 kernel: [    7.969662] pci 0=
000:ff:00.2: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.200130+00:00 mc-misc2002 kernel: [    7.977678] pci 0=
000:ff:00.3: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.200132+00:00 mc-misc2002 kernel: [    7.985654] pci 0=
000:ff:00.4: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.200133+00:00 mc-misc2002 kernel: [    7.989690] pci 0=
000:ff:00.5: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.200133+00:00 mc-misc2002 kernel: [    7.997645] pci 0=
000:ff:00.6: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.200133+00:00 mc-misc2002 kernel: [    8.005682] pci 0=
000:ff:00.7: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.200134+00:00 mc-misc2002 kernel: [    8.009700] pci 0=
000:ff:01.0: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.200134+00:00 mc-misc2002 kernel: [    8.017720] pci 0=
000:ff:01.1: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.200136+00:00 mc-misc2002 kernel: [    8.025703] pci 0=
000:ff:01.2: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.200137+00:00 mc-misc2002 kernel: [    8.033701] pci 0=
000:ff:01.3: [8086:344c] type 00 class 0x088000
> 2025-05-21T09:18:23.200137+00:00 mc-misc2002 kernel: [    8.037712] pci 0=
000:ff:0a.0: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.200137+00:00 mc-misc2002 kernel: [    8.045698] pci 0=
000:ff:0a.1: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.200137+00:00 mc-misc2002 kernel: [    8.053658] pci 0=
000:ff:0a.2: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.200138+00:00 mc-misc2002 kernel: [    8.061678] pci 0=
000:ff:0a.3: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.200138+00:00 mc-misc2002 kernel: [    8.065655] pci 0=
000:ff:0a.4: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.200141+00:00 mc-misc2002 kernel: [    8.073683] pci 0=
000:ff:0a.5: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.200142+00:00 mc-misc2002 kernel: [    8.081649] pci 0=
000:ff:0a.6: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.200142+00:00 mc-misc2002 kernel: [    8.085685] pci 0=
000:ff:0a.7: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.200142+00:00 mc-misc2002 kernel: [    8.093697] pci 0=
000:ff:0b.0: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.200142+00:00 mc-misc2002 kernel: [    8.101724] pci 0=
000:ff:0b.1: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.200143+00:00 mc-misc2002 kernel: [    8.109705] pci 0=
000:ff:0b.2: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.200145+00:00 mc-misc2002 kernel: [    8.113702] pci 0=
000:ff:0b.3: [8086:344d] type 00 class 0x088000
> 2025-05-21T09:18:23.200145+00:00 mc-misc2002 kernel: [    8.121719] pci 0=
000:ff:1d.0: [8086:344f] type 00 class 0x088000
> 2025-05-21T09:18:23.200146+00:00 mc-misc2002 kernel: [    8.129698] pci 0=
000:ff:1d.1: [8086:3457] type 00 class 0x088000
> 2025-05-21T09:18:23.200146+00:00 mc-misc2002 kernel: [    8.133679] pci 0=
000:ff:1e.0: [8086:3458] type 00 class 0x088000
> 2025-05-21T09:18:23.200146+00:00 mc-misc2002 kernel: [    8.141638] pci 0=
000:ff:1e.1: [8086:3459] type 00 class 0x088000
> 2025-05-21T09:18:23.200146+00:00 mc-misc2002 kernel: [    8.149620] pci 0=
000:ff:1e.2: [8086:345a] type 00 class 0x088000
> 2025-05-21T09:18:23.200148+00:00 mc-misc2002 kernel: [    8.157625] pci 0=
000:ff:1e.3: [8086:345b] type 00 class 0x088000
> 2025-05-21T09:18:23.200149+00:00 mc-misc2002 kernel: [    8.161620] pci 0=
000:ff:1e.4: [8086:345c] type 00 class 0x088000
> 2025-05-21T09:18:23.200149+00:00 mc-misc2002 kernel: [    8.169618] pci 0=
000:ff:1e.5: [8086:345d] type 00 class 0x088000
> 2025-05-21T09:18:23.200150+00:00 mc-misc2002 kernel: [    8.177618] pci 0=
000:ff:1e.6: [8086:345e] type 00 class 0x088000
> 2025-05-21T09:18:23.200150+00:00 mc-misc2002 kernel: [    8.181619] pci 0=
000:ff:1e.7: [8086:345f] type 00 class 0x088000
> 2025-05-21T09:18:23.200150+00:00 mc-misc2002 kernel: [    8.189615] pci_b=
us 0000:ff: on NUMA node 1
> 2025-05-21T09:18:23.200151+00:00 mc-misc2002 kernel: [    8.189907] ACPI:=
 PCI: Interrupt link LNKA configured for IRQ 11
> 2025-05-21T09:18:23.200153+00:00 mc-misc2002 kernel: [    8.197591] ACPI:=
 PCI: Interrupt link LNKB configured for IRQ 10
> 2025-05-21T09:18:23.200153+00:00 mc-misc2002 kernel: [    8.205590] ACPI:=
 PCI: Interrupt link LNKC configured for IRQ 11
> 2025-05-21T09:18:23.200154+00:00 mc-misc2002 kernel: [    8.209590] ACPI:=
 PCI: Interrupt link LNKD configured for IRQ 11
> 2025-05-21T09:18:23.200154+00:00 mc-misc2002 kernel: [    8.217591] ACPI:=
 PCI: Interrupt link LNKE configured for IRQ 11
> 2025-05-21T09:18:23.200154+00:00 mc-misc2002 kernel: [    8.225590] ACPI:=
 PCI: Interrupt link LNKF configured for IRQ 11
> 2025-05-21T09:18:23.200155+00:00 mc-misc2002 kernel: [    8.229591] ACPI:=
 PCI: Interrupt link LNKG configured for IRQ 11
> 2025-05-21T09:18:23.200157+00:00 mc-misc2002 kernel: [    8.237589] ACPI:=
 PCI: Interrupt link LNKH configured for IRQ 11
> 2025-05-21T09:18:23.200157+00:00 mc-misc2002 kernel: [    8.246131] iommu=
: Default domain type: Translated=20
> 2025-05-21T09:18:23.200158+00:00 mc-misc2002 kernel: [    8.249552] iommu=
: DMA domain TLB invalidation policy: lazy mode=20
> 2025-05-21T09:18:23.200158+00:00 mc-misc2002 kernel: [    8.257653] pps_c=
ore: LinuxPPS API ver. 1 registered
> 2025-05-21T09:18:23.200158+00:00 mc-misc2002 kernel: [    8.261552] pps_c=
ore: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@l=
inux.it>
> 2025-05-21T09:18:23.200159+00:00 mc-misc2002 kernel: [    8.273554] PTP c=
lock support registered
> 2025-05-21T09:18:23.200159+00:00 mc-misc2002 kernel: [    8.277584] EDAC =
MC: Ver: 3.0.0
> 2025-05-21T09:18:23.200161+00:00 mc-misc2002 kernel: [    8.281776] NetLa=
bel: Initializing
> 2025-05-21T09:18:23.200162+00:00 mc-misc2002 kernel: [    8.285552] NetLa=
bel:  domain hash size =3D 128
> 2025-05-21T09:18:23.200162+00:00 mc-misc2002 kernel: [    8.289551] NetLa=
bel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
> 2025-05-21T09:18:23.200162+00:00 mc-misc2002 kernel: [    8.297570] NetLa=
bel:  unlabeled traffic allowed by default
> 2025-05-21T09:18:23.200163+00:00 mc-misc2002 kernel: [    8.301552] PCI: =
Using ACPI for IRQ routing
> 2025-05-21T09:18:23.200163+00:00 mc-misc2002 kernel: [    8.313132] PCI: =
pci_cache_line_size set to 64 bytes
> 2025-05-21T09:18:23.200165+00:00 mc-misc2002 kernel: [    8.313572] e820:=
 reserve RAM buffer [mem 0x00098800-0x0009ffff]
> 2025-05-21T09:18:23.200166+00:00 mc-misc2002 kernel: [    8.313575] e820:=
 reserve RAM buffer [mem 0x645ff000-0x67ffffff]
> 2025-05-21T09:18:23.200166+00:00 mc-misc2002 kernel: [    8.313576] e820:=
 reserve RAM buffer [mem 0x6f800000-0x6fffffff]
> 2025-05-21T09:18:23.200166+00:00 mc-misc2002 kernel: [    8.313592] pci 0=
000:04:00.0: vgaarb: setting as boot VGA device
> 2025-05-21T09:18:23.200166+00:00 mc-misc2002 kernel: [    8.317551] pci 0=
000:04:00.0: vgaarb: bridge control possible
> 2025-05-21T09:18:23.200167+00:00 mc-misc2002 kernel: [    8.317551] pci 0=
000:04:00.0: vgaarb: VGA device added: decodes=3Dio+mem,owns=3Dnone,locks=
=3Dnone
> 2025-05-21T09:18:23.200169+00:00 mc-misc2002 kernel: [    8.333579] vgaar=
b: loaded
> 2025-05-21T09:18:23.200169+00:00 mc-misc2002 kernel: [    8.338537] hpet0=
: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> 2025-05-21T09:18:23.200170+00:00 mc-misc2002 kernel: [    8.345552] hpet0=
: 8 comparators, 64-bit 24.000000 MHz counter
> 2025-05-21T09:18:23.200170+00:00 mc-misc2002 kernel: [    8.355664] clock=
source: Switched to clocksource tsc-early
> 2025-05-21T09:18:23.200170+00:00 mc-misc2002 kernel: [    8.359917] VFS: =
Disk quotas dquot_6.6.0
> 2025-05-21T09:18:23.200171+00:00 mc-misc2002 kernel: [    8.364347] VFS: =
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> 2025-05-21T09:18:23.200171+00:00 mc-misc2002 kernel: [    8.372224] AppAr=
mor: AppArmor Filesystem Enabled
> 2025-05-21T09:18:23.200173+00:00 mc-misc2002 kernel: [    8.377528] pnp: =
PnP ACPI init
> 2025-05-21T09:18:23.200174+00:00 mc-misc2002 kernel: [    8.389704] syste=
m 00:01: [io  0x0500-0x05fe] has been reserved
> 2025-05-21T09:18:23.200174+00:00 mc-misc2002 kernel: [    8.396354] syste=
m 00:01: [io  0x0400-0x041f] has been reserved
> 2025-05-21T09:18:23.200174+00:00 mc-misc2002 kernel: [    8.403005] syste=
m 00:01: [mem 0xff000000-0xffffffff] has been reserved
> 2025-05-21T09:18:23.200174+00:00 mc-misc2002 kernel: [    8.410724] syste=
m 00:02: [io  0x0600-0x063f] has been reserved
> 2025-05-21T09:18:23.200175+00:00 mc-misc2002 kernel: [    8.417372] syste=
m 00:02: [io  0x0a40-0x0a5f] has been reserved
> 2025-05-21T09:18:23.200177+00:00 mc-misc2002 kernel: [    8.424017] syste=
m 00:02: [io  0x0a60-0x0a6f] has been reserved
> 2025-05-21T09:18:23.200178+00:00 mc-misc2002 kernel: [    8.430662] syste=
m 00:02: [io  0x0a70-0x0a7f] has been reserved
> 2025-05-21T09:18:23.200178+00:00 mc-misc2002 kernel: [    8.437519] pnp 0=
0:03: [dma 0 disabled]
> 2025-05-21T09:18:23.200178+00:00 mc-misc2002 kernel: [    8.437749] pnp 0=
0:04: [dma 0 disabled]
> 2025-05-21T09:18:23.200178+00:00 mc-misc2002 kernel: [    8.437925] syste=
m 00:05: [mem 0xfd000000-0xfdabffff] has been reserved
> 2025-05-21T09:18:23.200179+00:00 mc-misc2002 kernel: [    8.445354] syste=
m 00:05: [mem 0xfdad0000-0xfdadffff] has been reserved
> 2025-05-21T09:18:23.200179+00:00 mc-misc2002 kernel: [    8.452780] syste=
m 00:05: [mem 0xfdb00000-0xfdffffff] has been reserved
> 2025-05-21T09:18:23.200181+00:00 mc-misc2002 kernel: [    8.460208] syste=
m 00:05: [mem 0xfe000000-0xfe00ffff] has been reserved
> 2025-05-21T09:18:23.200182+00:00 mc-misc2002 kernel: [    8.467636] syste=
m 00:05: [mem 0xfe011000-0xfe01ffff] has been reserved
> 2025-05-21T09:18:23.200182+00:00 mc-misc2002 kernel: [    8.475062] syste=
m 00:05: [mem 0xfe036000-0xfe03bfff] has been reserved
> 2025-05-21T09:18:23.200182+00:00 mc-misc2002 kernel: [    8.482488] syste=
m 00:05: [mem 0xfe03d000-0xfe3fffff] has been reserved
> 2025-05-21T09:18:23.200183+00:00 mc-misc2002 kernel: [    8.489915] syste=
m 00:05: [mem 0xfe410000-0xfe7fffff] has been reserved
> 2025-05-21T09:18:23.200183+00:00 mc-misc2002 kernel: [    8.497633] syste=
m 00:06: [io  0x0f00-0x0ffe] has been reserved
> 2025-05-21T09:18:23.200185+00:00 mc-misc2002 kernel: [    8.505147] pnp: =
PnP ACPI: found 7 devices
> 2025-05-21T09:18:23.200186+00:00 mc-misc2002 kernel: [    8.515786] clock=
source: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 20857010=
24 ns
> 2025-05-21T09:18:23.200186+00:00 mc-misc2002 kernel: [    8.525832] NET: =
Registered PF_INET protocol family
> 2025-05-21T09:18:23.200186+00:00 mc-misc2002 kernel: [    8.531639] IP id=
ents hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T09:18:23.200186+00:00 mc-misc2002 kernel: [    8.544660] tcp_l=
isten_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, vma=
lloc)
> 2025-05-21T09:18:23.200187+00:00 mc-misc2002 kernel: [    8.554774] Table=
-perturb hash table entries: 65536 (order: 6, 262144 bytes, vmalloc)
> 2025-05-21T09:18:23.200189+00:00 mc-misc2002 kernel: [    8.564154] TCP e=
stablished hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc hu=
gepage)
> 2025-05-21T09:18:23.200189+00:00 mc-misc2002 kernel: [    8.575165] TCP b=
ind hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T09:18:23.200190+00:00 mc-misc2002 kernel: [    8.583769] TCP: =
Hash tables configured (established 524288 bind 65536)
> 2025-05-21T09:18:23.200190+00:00 mc-misc2002 kernel: [    8.591559] MPTCP=
 token hash table entries: 65536 (order: 8, 1572864 bytes, vmalloc)
> 2025-05-21T09:18:23.200190+00:00 mc-misc2002 kernel: [    8.600743] UDP h=
ash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T09:18:23.200191+00:00 mc-misc2002 kernel: [    8.609191] UDP-L=
ite hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> 2025-05-21T09:18:23.200191+00:00 mc-misc2002 kernel: [    8.617908] NET: =
Registered PF_UNIX/PF_LOCAL protocol family
> 2025-05-21T09:18:23.200193+00:00 mc-misc2002 kernel: [    8.624271] NET: =
Registered PF_XDP protocol family
> 2025-05-21T09:18:23.200194+00:00 mc-misc2002 kernel: [    8.629668] pci 0=
000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
> 2025-05-21T09:18:23.200194+00:00 mc-misc2002 kernel: [    8.638850] pci 0=
000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 0=
1] add_size 200000 add_align 100000
> 2025-05-21T09:18:23.200194+00:00 mc-misc2002 kernel: [    8.651743] pci 0=
000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 01] add_size=
 200000 add_align 100000
> 2025-05-21T09:18:23.200195+00:00 mc-misc2002 kernel: [    8.663565] pci 0=
000:00:1c.0: BAR 14: assigned [mem 0x90000000-0x901fffff]
> 2025-05-21T09:18:23.200195+00:00 mc-misc2002 kernel: [    8.671287] pci 0=
000:00:1c.0: BAR 15: assigned [mem 0x200000000000-0x2000001fffff 64bit pref]
> 2025-05-21T09:18:23.200197+00:00 mc-misc2002 kernel: [    8.680863] pci 0=
000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
> 2025-05-21T09:18:23.200198+00:00 mc-misc2002 kernel: [    8.687805] pci 0=
000:00:1f.4: BAR 0: assigned [mem 0x200000200000-0x2000002000ff 64bit]
> 2025-05-21T09:18:23.200198+00:00 mc-misc2002 kernel: [    8.696802] pci 0=
000:00:1c.0: PCI bridge to [bus 01]
> 2025-05-21T09:18:23.200198+00:00 mc-misc2002 kernel: [    8.702376] pci 0=
000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> 2025-05-21T09:18:23.200199+00:00 mc-misc2002 kernel: [    8.709221] pci 0=
000:00:1c.0:   bridge window [mem 0x90000000-0x901fffff]
> 2025-05-21T09:18:23.200199+00:00 mc-misc2002 kernel: [    8.716843] pci 0=
000:00:1c.0:   bridge window [mem 0x200000000000-0x2000001fffff 64bit pref]
> 2025-05-21T09:18:23.200202+00:00 mc-misc2002 kernel: [    8.726321] pci 0=
000:00:1c.4: PCI bridge to [bus 02]
> 2025-05-21T09:18:23.200202+00:00 mc-misc2002 kernel: [    8.731902] pci 0=
000:03:00.0: PCI bridge to [bus 04]
> 2025-05-21T09:18:23.200203+00:00 mc-misc2002 kernel: [    8.737477] pci 0=
000:03:00.0:   bridge window [io  0x3000-0x3fff]
> 2025-05-21T09:18:23.200203+00:00 mc-misc2002 kernel: [    8.744323] pci 0=
000:03:00.0:   bridge window [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T09:18:23.200203+00:00 mc-misc2002 kernel: [    8.751952] pci 0=
000:00:1c.5: PCI bridge to [bus 03-04]
> 2025-05-21T09:18:23.200204+00:00 mc-misc2002 kernel: [    8.757820] pci 0=
000:00:1c.5:   bridge window [io  0x3000-0x3fff]
> 2025-05-21T09:18:23.200206+00:00 mc-misc2002 kernel: [    8.764663] pci 0=
000:00:1c.5:   bridge window [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T09:18:23.200207+00:00 mc-misc2002 kernel: [    8.772291] pci_b=
us 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> 2025-05-21T09:18:23.200207+00:00 mc-misc2002 kernel: [    8.779229] pci_b=
us 0000:00: resource 5 [io  0x1000-0x4fff window]
> 2025-05-21T09:18:23.200207+00:00 mc-misc2002 kernel: [    8.786158] pci_b=
us 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> 2025-05-21T09:18:23.200207+00:00 mc-misc2002 kernel: [    8.793867] pci_b=
us 0000:00: resource 7 [mem 0x000c8000-0x000cffff window]
> 2025-05-21T09:18:23.200208+00:00 mc-misc2002 kernel: [    8.801575] pci_b=
us 0000:00: resource 8 [mem 0xfe010000-0xfe010fff window]
> 2025-05-21T09:18:23.200208+00:00 mc-misc2002 kernel: [    8.809295] pci_b=
us 0000:00: resource 9 [mem 0x90000000-0x9b7fffff window]
> 2025-05-21T09:18:23.200210+00:00 mc-misc2002 kernel: [    8.817013] pci_b=
us 0000:00: resource 10 [mem 0x200000000000-0x200fffffffff window]
> 2025-05-21T09:18:23.200211+00:00 mc-misc2002 kernel: [    8.825611] pci_b=
us 0000:01: resource 0 [io  0x1000-0x1fff]
> 2025-05-21T09:18:23.200211+00:00 mc-misc2002 kernel: [    8.831867] pci_b=
us 0000:01: resource 1 [mem 0x90000000-0x901fffff]
> 2025-05-21T09:18:23.200211+00:00 mc-misc2002 kernel: [    8.838904] pci_b=
us 0000:01: resource 2 [mem 0x200000000000-0x2000001fffff 64bit pref]
> 2025-05-21T09:18:23.200212+00:00 mc-misc2002 kernel: [    8.847795] pci_b=
us 0000:03: resource 0 [io  0x3000-0x3fff]
> 2025-05-21T09:18:23.200212+00:00 mc-misc2002 kernel: [    8.854051] pci_b=
us 0000:03: resource 1 [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T09:18:23.200214+00:00 mc-misc2002 kernel: [    8.861087] pci_b=
us 0000:04: resource 0 [io  0x3000-0x3fff]
> 2025-05-21T09:18:23.200215+00:00 mc-misc2002 kernel: [    8.867344] pci_b=
us 0000:04: resource 1 [mem 0x9a000000-0x9b0fffff]
> 2025-05-21T09:18:23.200215+00:00 mc-misc2002 kernel: [    8.874463] pci_b=
us 0000:16: resource 4 [io  0x5000-0x6fff window]
> 2025-05-21T09:18:23.200215+00:00 mc-misc2002 kernel: [    8.881405] pci_b=
us 0000:16: resource 5 [mem 0x9b800000-0xa63fffff window]
> 2025-05-21T09:18:23.200216+00:00 mc-misc2002 kernel: [    8.889125] pci_b=
us 0000:16: resource 6 [mem 0x201000000000-0x201fffffffff window]
> 2025-05-21T09:18:23.200216+00:00 mc-misc2002 kernel: [    8.897644] pci_b=
us 0000:30: resource 4 [io  0x7000-0x8fff window]
> 2025-05-21T09:18:23.200216+00:00 mc-misc2002 kernel: [    8.904584] pci_b=
us 0000:30: resource 5 [mem 0xa6400000-0xb0ffffff window]
> 2025-05-21T09:18:23.200218+00:00 mc-misc2002 kernel: [    8.912302] pci_b=
us 0000:30: resource 6 [mem 0x202000000000-0x202fffffffff window]
> 2025-05-21T09:18:23.200219+00:00 mc-misc2002 kernel: [    8.920812] pci 0=
000:4a:05.0: PCI bridge to [bus 4b]
> 2025-05-21T09:18:23.200219+00:00 mc-misc2002 kernel: [    8.926387] pci 0=
000:4a:05.0:   bridge window [io  0x9000-0x9fff]
> 2025-05-21T09:18:23.200219+00:00 mc-misc2002 kernel: [    8.933229] pci 0=
000:4a:05.0:   bridge window [mem 0xbba00000-0xbbafffff]
> 2025-05-21T09:18:23.200220+00:00 mc-misc2002 kernel: [    8.940850] pci 0=
000:4a:05.0:   bridge window [mem 0x203fffe00000-0x203fffefffff 64bit pref]
> 2025-05-21T09:18:23.200220+00:00 mc-misc2002 kernel: [    8.950327] pci_b=
us 0000:4a: resource 4 [io  0x9000-0x9fff window]
> 2025-05-21T09:18:23.200222+00:00 mc-misc2002 kernel: [    8.957266] pci_b=
us 0000:4a: resource 5 [mem 0xb1000000-0xbbbfffff window]
> 2025-05-21T09:18:23.200223+00:00 mc-misc2002 kernel: [    8.964987] pci_b=
us 0000:4a: resource 6 [mem 0x203000000000-0x203fffffffff window]
> 2025-05-21T09:18:23.200223+00:00 mc-misc2002 kernel: [    8.973486] pci_b=
us 0000:4b: resource 0 [io  0x9000-0x9fff]
> 2025-05-21T09:18:23.200223+00:00 mc-misc2002 kernel: [    8.979744] pci_b=
us 0000:4b: resource 1 [mem 0xbba00000-0xbbafffff]
> 2025-05-21T09:18:23.200224+00:00 mc-misc2002 kernel: [    8.986779] pci_b=
us 0000:4b: resource 2 [mem 0x203fffe00000-0x203fffefffff 64bit pref]
> 2025-05-21T09:18:23.200224+00:00 mc-misc2002 kernel: [    8.995707] pci 0=
000:64:02.0: bridge window [io  0x1000-0x0fff] to [bus 65] add_size 1000
> 2025-05-21T09:18:23.200226+00:00 mc-misc2002 kernel: [    9.004896] pci 0=
000:64:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6=
5] add_size 200000 add_align 100000
> 2025-05-21T09:18:23.200227+00:00 mc-misc2002 kernel: [    9.017784] pci 0=
000:64:03.0: bridge window [io  0x1000-0x0fff] to [bus 66] add_size 1000
> 2025-05-21T09:18:23.200227+00:00 mc-misc2002 kernel: [    9.026966] pci 0=
000:64:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6=
6] add_size 200000 add_align 100000
> 2025-05-21T09:18:23.200227+00:00 mc-misc2002 kernel: [    9.039854] pci 0=
000:64:04.0: bridge window [io  0x1000-0x0fff] to [bus 67] add_size 1000
> 2025-05-21T09:18:23.200228+00:00 mc-misc2002 kernel: [    9.049034] pci 0=
000:64:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6=
7] add_size 200000 add_align 100000
> 2025-05-21T09:18:23.200228+00:00 mc-misc2002 kernel: [    9.061913] pci 0=
000:64:05.0: bridge window [io  0x1000-0x0fff] to [bus 68] add_size 1000
> 2025-05-21T09:18:23.200230+00:00 mc-misc2002 kernel: [    9.071096] pci 0=
000:64:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 6=
8] add_size 200000 add_align 100000
> 2025-05-21T09:18:23.200231+00:00 mc-misc2002 kernel: [    9.083987] pci 0=
000:64:02.0: BAR 15: assigned [mem 0x204000000000-0x2040001fffff 64bit pref]
> 2025-05-21T09:18:23.200231+00:00 mc-misc2002 kernel: [    9.093561] pci 0=
000:64:03.0: BAR 15: assigned [mem 0x204000200000-0x2040003fffff 64bit pref]
> 2025-05-21T09:18:23.200231+00:00 mc-misc2002 kernel: [    9.103133] pci 0=
000:64:04.0: BAR 15: assigned [mem 0x204000400000-0x2040005fffff 64bit pref]
> 2025-05-21T09:18:23.200232+00:00 mc-misc2002 kernel: [    9.112704] pci 0=
000:64:05.0: BAR 15: assigned [mem 0x204000600000-0x2040007fffff 64bit pref]
> 2025-05-21T09:18:23.200232+00:00 mc-misc2002 kernel: [    9.122275] pci 0=
000:64:02.0: BAR 13: assigned [io  0xa000-0xafff]
> 2025-05-21T09:18:23.200234+00:00 mc-misc2002 kernel: [    9.129215] pci 0=
000:64:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T09:18:23.200235+00:00 mc-misc2002 kernel: [    9.136350] pci 0=
000:64:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T09:18:23.200235+00:00 mc-misc2002 kernel: [    9.143873] pci 0=
000:64:04.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T09:18:23.200235+00:00 mc-misc2002 kernel: [    9.151008] pci 0=
000:64:04.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T09:18:23.200236+00:00 mc-misc2002 kernel: [    9.158531] pci 0=
000:64:05.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T09:18:23.200236+00:00 mc-misc2002 kernel: [    9.165664] pci 0=
000:64:05.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T09:18:23.200236+00:00 mc-misc2002 kernel: [    9.173187] pci 0=
000:64:05.0: BAR 13: assigned [io  0xa000-0xafff]
> 2025-05-21T09:18:23.200238+00:00 mc-misc2002 kernel: [    9.180125] pci 0=
000:64:04.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T09:18:23.200239+00:00 mc-misc2002 kernel: [    9.187258] pci 0=
000:64:04.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T09:18:23.200239+00:00 mc-misc2002 kernel: [    9.194780] pci 0=
000:64:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T09:18:23.200239+00:00 mc-misc2002 kernel: [    9.201912] pci 0=
000:64:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T09:18:23.200240+00:00 mc-misc2002 kernel: [    9.209436] pci 0=
000:64:02.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T09:18:23.200240+00:00 mc-misc2002 kernel: [    9.216569] pci 0=
000:64:02.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T09:18:23.200243+00:00 mc-misc2002 kernel: [    9.224094] pci 0=
000:64:02.0: PCI bridge to [bus 65]
> 2025-05-21T09:18:23.200243+00:00 mc-misc2002 kernel: [    9.229670] pci 0=
000:64:02.0:   bridge window [mem 0xc5e00000-0xc5efffff]
> 2025-05-21T09:18:23.200243+00:00 mc-misc2002 kernel: [    9.237294] pci 0=
000:64:02.0:   bridge window [mem 0x204000000000-0x2040001fffff 64bit pref]
> 2025-05-21T09:18:23.200269+00:00 mc-misc2002 kernel: [    9.246771] pci 0=
000:64:03.0: PCI bridge to [bus 66]
> 2025-05-21T09:18:23.200269+00:00 mc-misc2002 kernel: [    9.252345] pci 0=
000:64:03.0:   bridge window [mem 0xc5d00000-0xc5dfffff]
> 2025-05-21T09:18:23.200270+00:00 mc-misc2002 kernel: [    9.259967] pci 0=
000:64:03.0:   bridge window [mem 0x204000200000-0x2040003fffff 64bit pref]
> 2025-05-21T09:18:23.200273+00:00 mc-misc2002 kernel: [    9.269443] pci 0=
000:64:04.0: PCI bridge to [bus 67]
> 2025-05-21T09:18:23.200273+00:00 mc-misc2002 kernel: [    9.275017] pci 0=
000:64:04.0:   bridge window [mem 0xc5c00000-0xc5cfffff]
> 2025-05-21T09:18:23.200273+00:00 mc-misc2002 kernel: [    9.282638] pci 0=
000:64:04.0:   bridge window [mem 0x204000400000-0x2040005fffff 64bit pref]
> 2025-05-21T09:18:23.200274+00:00 mc-misc2002 kernel: [    9.292114] pci 0=
000:64:05.0: PCI bridge to [bus 68]
> 2025-05-21T09:18:23.200274+00:00 mc-misc2002 kernel: [    9.297687] pci 0=
000:64:05.0:   bridge window [io  0xa000-0xafff]
> 2025-05-21T09:18:23.200274+00:00 mc-misc2002 kernel: [    9.304529] pci 0=
000:64:05.0:   bridge window [mem 0xc5b00000-0xc5bfffff]
> 2025-05-21T09:18:23.200274+00:00 mc-misc2002 kernel: [    9.312151] pci 0=
000:64:05.0:   bridge window [mem 0x204000600000-0x2040007fffff 64bit pref]
> 2025-05-21T09:18:23.200277+00:00 mc-misc2002 kernel: [    9.321627] pci_b=
us 0000:64: resource 4 [io  0xa000-0xafff window]
> 2025-05-21T09:18:23.200277+00:00 mc-misc2002 kernel: [    9.328565] pci_b=
us 0000:64: resource 5 [mem 0xbbc00000-0xc5ffffff window]
> 2025-05-21T09:18:23.200277+00:00 mc-misc2002 kernel: [    9.336274] pci_b=
us 0000:64: resource 6 [mem 0x204000000000-0x204fffffffff window]
> 2025-05-21T09:18:23.200278+00:00 mc-misc2002 kernel: [    9.344773] pci_b=
us 0000:65: resource 1 [mem 0xc5e00000-0xc5efffff]
> 2025-05-21T09:18:23.200278+00:00 mc-misc2002 kernel: [    9.351808] pci_b=
us 0000:65: resource 2 [mem 0x204000000000-0x2040001fffff 64bit pref]
> 2025-05-21T09:18:23.200278+00:00 mc-misc2002 kernel: [    9.360696] pci_b=
us 0000:66: resource 1 [mem 0xc5d00000-0xc5dfffff]
> 2025-05-21T09:18:23.200281+00:00 mc-misc2002 kernel: [    9.367731] pci_b=
us 0000:66: resource 2 [mem 0x204000200000-0x2040003fffff 64bit pref]
> 2025-05-21T09:18:23.200281+00:00 mc-misc2002 kernel: [    9.376612] pci_b=
us 0000:67: resource 1 [mem 0xc5c00000-0xc5cfffff]
> 2025-05-21T09:18:23.200281+00:00 mc-misc2002 kernel: [    9.383647] pci_b=
us 0000:67: resource 2 [mem 0x204000400000-0x2040005fffff 64bit pref]
> 2025-05-21T09:18:23.200282+00:00 mc-misc2002 kernel: [    9.392527] pci_b=
us 0000:68: resource 0 [io  0xa000-0xafff]
> 2025-05-21T09:18:23.200282+00:00 mc-misc2002 kernel: [    9.398783] pci_b=
us 0000:68: resource 1 [mem 0xc5b00000-0xc5bfffff]
> 2025-05-21T09:18:23.200282+00:00 mc-misc2002 kernel: [    9.405819] pci_b=
us 0000:68: resource 2 [mem 0x204000600000-0x2040007fffff 64bit pref]
> 2025-05-21T09:18:23.200283+00:00 mc-misc2002 kernel: [    9.414753] pci_b=
us 0000:80: resource 4 [io  0xb000-0xbfff window]
> 2025-05-21T09:18:23.200285+00:00 mc-misc2002 kernel: [    9.421693] pci_b=
us 0000:80: resource 5 [mem 0xc6800000-0xd0ffffff window]
> 2025-05-21T09:18:23.200285+00:00 mc-misc2002 kernel: [    9.429410] pci_b=
us 0000:80: resource 6 [mem 0x205000000000-0x205fffffffff window]
> 2025-05-21T09:18:23.200286+00:00 mc-misc2002 kernel: [    9.437917] pci 0=
000:97:04.0: PCI bridge to [bus 98]
> 2025-05-21T09:18:23.200286+00:00 mc-misc2002 kernel: [    9.443492] pci 0=
000:97:04.0:   bridge window [mem 0xdba00000-0xdbafffff]
> 2025-05-21T09:18:23.200286+00:00 mc-misc2002 kernel: [    9.451115] pci 0=
000:97:04.0:   bridge window [mem 0x206fffc00000-0x206fffefffff 64bit pref]
> 2025-05-21T09:18:23.200287+00:00 mc-misc2002 kernel: [    9.460590] pci_b=
us 0000:97: resource 4 [io  0xc000-0xcfff window]
> 2025-05-21T09:18:23.200290+00:00 mc-misc2002 kernel: [    9.467530] pci_b=
us 0000:97: resource 5 [mem 0xd1000000-0xdbbfffff window]
> 2025-05-21T09:18:23.200290+00:00 mc-misc2002 kernel: [    9.475249] pci_b=
us 0000:97: resource 6 [mem 0x206000000000-0x206fffffffff window]
> 2025-05-21T09:18:23.200290+00:00 mc-misc2002 kernel: [    9.483748] pci_b=
us 0000:98: resource 1 [mem 0xdba00000-0xdbafffff]
> 2025-05-21T09:18:23.200291+00:00 mc-misc2002 kernel: [    9.490783] pci_b=
us 0000:98: resource 2 [mem 0x206fffc00000-0x206fffefffff 64bit pref]
> 2025-05-21T09:18:23.200291+00:00 mc-misc2002 kernel: [    9.499693] pci_b=
us 0000:b0: resource 4 [io  0xd000-0xdfff window]
> 2025-05-21T09:18:23.200291+00:00 mc-misc2002 kernel: [    9.506630] pci_b=
us 0000:b0: resource 5 [mem 0xdbc00000-0xe67fffff window]
> 2025-05-21T09:18:23.200294+00:00 mc-misc2002 kernel: [    9.514339] pci_b=
us 0000:b0: resource 6 [mem 0x207000000000-0x207fffffffff window]
> 2025-05-21T09:18:23.200294+00:00 mc-misc2002 kernel: [    9.522856] pci 0=
000:c9:02.0: bridge window [io  0x1000-0x0fff] to [bus ca] add_size 1000
> 2025-05-21T09:18:23.200294+00:00 mc-misc2002 kernel: [    9.532037] pci 0=
000:c9:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus c=
a] add_size 200000 add_align 100000
> 2025-05-21T09:18:23.200295+00:00 mc-misc2002 kernel: [    9.544923] pci 0=
000:c9:03.0: bridge window [io  0x1000-0x0fff] to [bus cb] add_size 1000
> 2025-05-21T09:18:23.200295+00:00 mc-misc2002 kernel: [    9.554097] pci 0=
000:c9:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus c=
b] add_size 200000 add_align 100000
> 2025-05-21T09:18:23.200295+00:00 mc-misc2002 kernel: [    9.566985] pci 0=
000:c9:02.0: BAR 15: assigned [mem 0x208000000000-0x2080001fffff 64bit pref]
> 2025-05-21T09:18:23.200298+00:00 mc-misc2002 kernel: [    9.576558] pci 0=
000:c9:03.0: BAR 15: assigned [mem 0x208000200000-0x2080003fffff 64bit pref]
> 2025-05-21T09:18:23.200298+00:00 mc-misc2002 kernel: [    9.586130] pci 0=
000:c9:02.0: BAR 13: assigned [io  0xe000-0xefff]
> 2025-05-21T09:18:23.200299+00:00 mc-misc2002 kernel: [    9.593069] pci 0=
000:c9:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T09:18:23.200299+00:00 mc-misc2002 kernel: [    9.600202] pci 0=
000:c9:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T09:18:23.200299+00:00 mc-misc2002 kernel: [    9.607725] pci 0=
000:c9:03.0: BAR 13: assigned [io  0xe000-0xefff]
> 2025-05-21T09:18:23.200299+00:00 mc-misc2002 kernel: [    9.614664] pci 0=
000:c9:02.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T09:18:23.200300+00:00 mc-misc2002 kernel: [    9.621796] pci 0=
000:c9:02.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T09:18:23.200321+00:00 mc-misc2002 kernel: [    9.629320] pci 0=
000:c9:02.0: PCI bridge to [bus ca]
> 2025-05-21T09:18:23.200322+00:00 mc-misc2002 kernel: [    9.634895] pci 0=
000:c9:02.0:   bridge window [mem 0xf1200000-0xf12fffff]
> 2025-05-21T09:18:23.200322+00:00 mc-misc2002 kernel: [    9.642516] pci 0=
000:c9:02.0:   bridge window [mem 0x208000000000-0x2080001fffff 64bit pref]
> 2025-05-21T09:18:23.200322+00:00 mc-misc2002 kernel: [    9.651992] pci 0=
000:c9:03.0: PCI bridge to [bus cb]
> 2025-05-21T09:18:23.200323+00:00 mc-misc2002 kernel: [    9.657567] pci 0=
000:c9:03.0:   bridge window [io  0xe000-0xefff]
> 2025-05-21T09:18:23.200323+00:00 mc-misc2002 kernel: [    9.664410] pci 0=
000:c9:03.0:   bridge window [mem 0xf1100000-0xf11fffff]
> 2025-05-21T09:18:23.200340+00:00 mc-misc2002 kernel: [    9.672032] pci 0=
000:c9:03.0:   bridge window [mem 0x208000200000-0x2080003fffff 64bit pref]
> 2025-05-21T09:18:23.200340+00:00 mc-misc2002 kernel: [    9.681507] pci_b=
us 0000:c9: resource 4 [io  0xe000-0xefff window]
> 2025-05-21T09:18:23.200340+00:00 mc-misc2002 kernel: [    9.688444] pci_b=
us 0000:c9: resource 5 [mem 0xe6800000-0xf13fffff window]
> 2025-05-21T09:18:23.200341+00:00 mc-misc2002 kernel: [    9.696162] pci_b=
us 0000:c9: resource 6 [mem 0x208000000000-0x208fffffffff window]
> 2025-05-21T09:18:23.200341+00:00 mc-misc2002 kernel: [    9.704652] pci_b=
us 0000:ca: resource 1 [mem 0xf1200000-0xf12fffff]
> 2025-05-21T09:18:23.200341+00:00 mc-misc2002 kernel: [    9.711687] pci_b=
us 0000:ca: resource 2 [mem 0x208000000000-0x2080001fffff 64bit pref]
> 2025-05-21T09:18:23.200342+00:00 mc-misc2002 kernel: [    9.720574] pci_b=
us 0000:cb: resource 0 [io  0xe000-0xefff]
> 2025-05-21T09:18:23.200344+00:00 mc-misc2002 kernel: [    9.726828] pci_b=
us 0000:cb: resource 1 [mem 0xf1100000-0xf11fffff]
> 2025-05-21T09:18:23.200345+00:00 mc-misc2002 kernel: [    9.733863] pci_b=
us 0000:cb: resource 2 [mem 0x208000200000-0x2080003fffff 64bit pref]
> 2025-05-21T09:18:23.200345+00:00 mc-misc2002 kernel: [    9.742771] pci 0=
000:e2:02.0: bridge window [io  0x1000-0x0fff] to [bus e3] add_size 1000
> 2025-05-21T09:18:23.200345+00:00 mc-misc2002 kernel: [    9.751953] pci 0=
000:e2:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus e=
3] add_size 200000 add_align 100000
> 2025-05-21T09:18:23.200345+00:00 mc-misc2002 kernel: [    9.764842] pci 0=
000:e2:03.0: bridge window [io  0x1000-0x0fff] to [bus e4] add_size 1000
> 2025-05-21T09:18:23.200346+00:00 mc-misc2002 kernel: [    9.774022] pci 0=
000:e2:03.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus e=
4] add_size 200000 add_align 100000
> 2025-05-21T09:18:23.200348+00:00 mc-misc2002 kernel: [    9.786907] pci 0=
000:e2:04.0: bridge window [io  0x1000-0x0fff] to [bus e5] add_size 1000
> 2025-05-21T09:18:23.200349+00:00 mc-misc2002 kernel: [    9.796078] pci 0=
000:e2:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus e=
5] add_size 200000 add_align 100000
> 2025-05-21T09:18:23.200349+00:00 mc-misc2002 kernel: [    9.808956] pci 0=
000:e2:05.0: bridge window [io  0x1000-0x0fff] to [bus e6] add_size 1000
> 2025-05-21T09:18:23.200349+00:00 mc-misc2002 kernel: [    9.818137] pci 0=
000:e2:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus e=
6] add_size 200000 add_align 100000
> 2025-05-21T09:18:23.200350+00:00 mc-misc2002 kernel: [    9.831026] pci 0=
000:e2:02.0: BAR 15: assigned [mem 0x209000000000-0x2090001fffff 64bit pref]
> 2025-05-21T09:18:23.200352+00:00 mc-misc2002 kernel: [    9.840598] pci 0=
000:e2:03.0: BAR 15: assigned [mem 0x209000200000-0x2090003fffff 64bit pref]
> 2025-05-21T09:18:23.200352+00:00 mc-misc2002 kernel: [    9.850169] pci 0=
000:e2:04.0: BAR 15: assigned [mem 0x209000400000-0x2090005fffff 64bit pref]
> 2025-05-21T09:18:23.200353+00:00 mc-misc2002 kernel: [    9.859742] pci 0=
000:e2:05.0: BAR 15: assigned [mem 0x209000600000-0x2090007fffff 64bit pref]
> 2025-05-21T09:18:23.200353+00:00 mc-misc2002 kernel: [    9.869314] pci 0=
000:e2:02.0: BAR 13: assigned [io  0xf000-0xffff]
> 2025-05-21T09:18:23.200353+00:00 mc-misc2002 kernel: [    9.876251] pci 0=
000:e2:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T09:18:23.200354+00:00 mc-misc2002 kernel: [    9.883383] pci 0=
000:e2:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T09:18:23.200354+00:00 mc-misc2002 kernel: [    9.890898] pci 0=
000:e2:04.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T09:18:23.200356+00:00 mc-misc2002 kernel: [    9.898030] pci 0=
000:e2:04.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T09:18:23.200357+00:00 mc-misc2002 kernel: [    9.905554] pci 0=
000:e2:05.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T09:18:23.200357+00:00 mc-misc2002 kernel: [    9.912688] pci 0=
000:e2:05.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T09:18:23.200357+00:00 mc-misc2002 kernel: [    9.920214] pci 0=
000:e2:05.0: BAR 13: assigned [io  0xf000-0xffff]
> 2025-05-21T09:18:23.200358+00:00 mc-misc2002 kernel: [    9.927154] pci 0=
000:e2:04.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T09:18:23.200358+00:00 mc-misc2002 kernel: [    9.934287] pci 0=
000:e2:04.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T09:18:23.200360+00:00 mc-misc2002 kernel: [    9.941811] pci 0=
000:e2:03.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T09:18:23.200361+00:00 mc-misc2002 kernel: [    9.948943] pci 0=
000:e2:03.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T09:18:23.200361+00:00 mc-misc2002 kernel: [    9.956465] pci 0=
000:e2:02.0: BAR 13: no space for [io  size 0x1000]
> 2025-05-21T09:18:23.200361+00:00 mc-misc2002 kernel: [    9.963599] pci 0=
000:e2:02.0: BAR 13: failed to assign [io  size 0x1000]
> 2025-05-21T09:18:23.200361+00:00 mc-misc2002 kernel: [    9.971121] pci 0=
000:e2:02.0: PCI bridge to [bus e3]
> 2025-05-21T09:18:23.200362+00:00 mc-misc2002 kernel: [    9.976695] pci 0=
000:e2:02.0:   bridge window [mem 0xfb600000-0xfb6fffff]
> 2025-05-21T09:18:23.200362+00:00 mc-misc2002 kernel: [    9.984318] pci 0=
000:e2:02.0:   bridge window [mem 0x209000000000-0x2090001fffff 64bit pref]
> 2025-05-21T09:18:23.200365+00:00 mc-misc2002 kernel: [    9.993795] pci 0=
000:e2:03.0: PCI bridge to [bus e4]
> 2025-05-21T09:18:23.200365+00:00 mc-misc2002 kernel: [    9.999369] pci 0=
000:e2:03.0:   bridge window [mem 0xfb500000-0xfb5fffff]
> 2025-05-21T09:18:23.200365+00:00 mc-misc2002 kernel: [   10.006990] pci 0=
000:e2:03.0:   bridge window [mem 0x209000200000-0x2090003fffff 64bit pref]
> 2025-05-21T09:18:23.200365+00:00 mc-misc2002 kernel: [   10.016466] pci 0=
000:e2:04.0: PCI bridge to [bus e5]
> 2025-05-21T09:18:23.200366+00:00 mc-misc2002 kernel: [   10.022040] pci 0=
000:e2:04.0:   bridge window [mem 0xfb400000-0xfb4fffff]
> 2025-05-21T09:18:23.200366+00:00 mc-misc2002 kernel: [   10.029661] pci 0=
000:e2:04.0:   bridge window [mem 0x209000400000-0x2090005fffff 64bit pref]
> 2025-05-21T09:18:23.200369+00:00 mc-misc2002 kernel: [   10.039136] pci 0=
000:e2:05.0: PCI bridge to [bus e6]
> 2025-05-21T09:18:23.200369+00:00 mc-misc2002 kernel: [   10.044708] pci 0=
000:e2:05.0:   bridge window [io  0xf000-0xffff]
> 2025-05-21T09:18:23.200369+00:00 mc-misc2002 kernel: [   10.051542] pci 0=
000:e2:05.0:   bridge window [mem 0xfb300000-0xfb3fffff]
> 2025-05-21T09:18:23.200369+00:00 mc-misc2002 kernel: [   10.059164] pci 0=
000:e2:05.0:   bridge window [mem 0x209000600000-0x2090007fffff 64bit pref]
> 2025-05-21T09:18:23.200370+00:00 mc-misc2002 kernel: [   10.068639] pci_b=
us 0000:e2: resource 4 [io  0xf000-0xffff window]
> 2025-05-21T09:18:23.200370+00:00 mc-misc2002 kernel: [   10.075579] pci_b=
us 0000:e2: resource 5 [mem 0xf1400000-0xfb7fffff window]
> 2025-05-21T09:18:23.200373+00:00 mc-misc2002 kernel: [   10.083296] pci_b=
us 0000:e2: resource 6 [mem 0x209000000000-0x209fffffffff window]
> 2025-05-21T09:18:23.200373+00:00 mc-misc2002 kernel: [   10.091795] pci_b=
us 0000:e3: resource 1 [mem 0xfb600000-0xfb6fffff]
> 2025-05-21T09:18:23.200373+00:00 mc-misc2002 kernel: [   10.098829] pci_b=
us 0000:e3: resource 2 [mem 0x209000000000-0x2090001fffff 64bit pref]
> 2025-05-21T09:18:23.200373+00:00 mc-misc2002 kernel: [   10.107717] pci_b=
us 0000:e4: resource 1 [mem 0xfb500000-0xfb5fffff]
> 2025-05-21T09:18:23.200374+00:00 mc-misc2002 kernel: [   10.114743] pci_b=
us 0000:e4: resource 2 [mem 0x209000200000-0x2090003fffff 64bit pref]
> 2025-05-21T09:18:23.200374+00:00 mc-misc2002 kernel: [   10.123631] pci_b=
us 0000:e5: resource 1 [mem 0xfb400000-0xfb4fffff]
> 2025-05-21T09:18:23.200374+00:00 mc-misc2002 kernel: [   10.130667] pci_b=
us 0000:e5: resource 2 [mem 0x209000400000-0x2090005fffff 64bit pref]
> 2025-05-21T09:18:23.200377+00:00 mc-misc2002 kernel: [   10.139555] pci_b=
us 0000:e6: resource 0 [io  0xf000-0xffff]
> 2025-05-21T09:18:23.200377+00:00 mc-misc2002 kernel: [   10.145810] pci_b=
us 0000:e6: resource 1 [mem 0xfb300000-0xfb3fffff]
> 2025-05-21T09:18:23.200377+00:00 mc-misc2002 kernel: [   10.152838] pci_b=
us 0000:e6: resource 2 [mem 0x209000600000-0x2090007fffff 64bit pref]
> 2025-05-21T09:18:23.200378+00:00 mc-misc2002 kernel: [   10.172826] pci 0=
000:00:14.0: quirk_usb_early_handoff+0x0/0x760 took 10768 usecs
> 2025-05-21T09:18:23.200378+00:00 mc-misc2002 kernel: [   10.181197] pci 0=
000:4b:00.0: CLS mismatch (64 !=3D 32), using 64 bytes
> 2025-05-21T09:18:23.200378+00:00 mc-misc2002 kernel: [   10.188625] pci 0=
000:00:1f.1: [8086:a1a0] type 00 class 0x058000
> 2025-05-21T09:18:23.200381+00:00 mc-misc2002 kernel: [   10.195393] pci 0=
000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64bit]
> 2025-05-21T09:18:23.200381+00:00 mc-misc2002 kernel: [   10.203347] Tryin=
g to unpack rootfs image as initramfs...
> 2025-05-21T09:18:23.200381+00:00 mc-misc2002 kernel: [   10.203395] DMAR:=
 No SATC found
> 2025-05-21T09:18:23.200382+00:00 mc-misc2002 kernel: [   10.212956] DMAR:=
 dmar8: Using Queued invalidation
> 2025-05-21T09:18:23.200382+00:00 mc-misc2002 kernel: [   10.218357] DMAR:=
 dmar7: Using Queued invalidation
> 2025-05-21T09:18:23.200382+00:00 mc-misc2002 kernel: [   10.223746] DMAR:=
 dmar4: Using Queued invalidation
> 2025-05-21T09:18:23.200382+00:00 mc-misc2002 kernel: [   10.229119] DMAR:=
 dmar3: Using Queued invalidation
> 2025-05-21T09:18:23.200386+00:00 mc-misc2002 kernel: [   10.234499] DMAR:=
 dmar1: Using Queued invalidation
> 2025-05-21T09:18:23.200386+00:00 mc-misc2002 kernel: [   10.239886] DMAR:=
 dmar0: Using Queued invalidation
> 2025-05-21T09:18:23.200386+00:00 mc-misc2002 kernel: [   10.245268] DMAR:=
 dmar9: Using Queued invalidation
> 2025-05-21T09:18:23.200387+00:00 mc-misc2002 kernel: [   10.250834] pci 0=
000:64:02.0: Adding to iommu group 0
> 2025-05-21T09:18:23.200387+00:00 mc-misc2002 kernel: [   10.256532] pci 0=
000:64:03.0: Adding to iommu group 1
> 2025-05-21T09:18:23.200387+00:00 mc-misc2002 kernel: [   10.262226] pci 0=
000:64:04.0: Adding to iommu group 2
> 2025-05-21T09:18:23.200390+00:00 mc-misc2002 kernel: [   10.267928] pci 0=
000:64:05.0: Adding to iommu group 3
> 2025-05-21T09:18:23.200390+00:00 mc-misc2002 kernel: [   10.273635] pci 0=
000:65:00.0: Adding to iommu group 4
> 2025-05-21T09:18:23.200390+00:00 mc-misc2002 kernel: [   10.280870] pci 0=
000:4a:05.0: Adding to iommu group 5
> 2025-05-21T09:18:23.200391+00:00 mc-misc2002 kernel: [   10.286580] pci 0=
000:4b:00.0: Adding to iommu group 6
> 2025-05-21T09:18:23.200391+00:00 mc-misc2002 kernel: [   10.292281] pci 0=
000:4b:00.1: Adding to iommu group 7
> 2025-05-21T09:18:23.200391+00:00 mc-misc2002 kernel: [   10.299079] pci 0=
000:e2:02.0: Adding to iommu group 8
> 2025-05-21T09:18:23.200394+00:00 mc-misc2002 kernel: [   10.304785] pci 0=
000:e2:03.0: Adding to iommu group 9
> 2025-05-21T09:18:23.200394+00:00 mc-misc2002 kernel: [   10.310480] pci 0=
000:e2:04.0: Adding to iommu group 10
> 2025-05-21T09:18:23.200394+00:00 mc-misc2002 kernel: [   10.316282] pci 0=
000:e2:05.0: Adding to iommu group 11
> 2025-05-21T09:18:23.200395+00:00 mc-misc2002 kernel: [   10.323255] pci 0=
000:c9:02.0: Adding to iommu group 12
> 2025-05-21T09:18:23.200395+00:00 mc-misc2002 kernel: [   10.329060] pci 0=
000:c9:03.0: Adding to iommu group 13
> 2025-05-21T09:18:23.200395+00:00 mc-misc2002 kernel: [   10.335453] pci 0=
000:97:04.0: Adding to iommu group 14
> 2025-05-21T09:18:23.200395+00:00 mc-misc2002 kernel: [   10.341260] pci 0=
000:98:00.0: Adding to iommu group 15
> 2025-05-21T09:18:23.200398+00:00 mc-misc2002 kernel: [   10.347061] pci 0=
000:98:00.1: Adding to iommu group 16
> 2025-05-21T09:18:23.200398+00:00 mc-misc2002 kernel: [   10.353747] pci 0=
000:80:01.0: Adding to iommu group 17
> 2025-05-21T09:18:23.200398+00:00 mc-misc2002 kernel: [   10.359538] pci 0=
000:80:01.1: Adding to iommu group 18
> 2025-05-21T09:18:23.200399+00:00 mc-misc2002 kernel: [   10.365339] pci 0=
000:80:01.2: Adding to iommu group 19
> 2025-05-21T09:18:23.200399+00:00 mc-misc2002 kernel: [   10.371137] pci 0=
000:80:01.3: Adding to iommu group 20
> 2025-05-21T09:18:23.200399+00:00 mc-misc2002 kernel: [   10.376936] pci 0=
000:80:01.4: Adding to iommu group 21
> 2025-05-21T09:18:23.200402+00:00 mc-misc2002 kernel: [   10.382736] pci 0=
000:80:01.5: Adding to iommu group 22
> 2025-05-21T09:18:23.200402+00:00 mc-misc2002 kernel: [   10.388538] pci 0=
000:80:01.6: Adding to iommu group 23
> 2025-05-21T09:18:23.200402+00:00 mc-misc2002 kernel: [   10.394330] pci 0=
000:80:01.7: Adding to iommu group 24
> 2025-05-21T09:18:23.200403+00:00 mc-misc2002 kernel: [   10.402578] pci 0=
000:00:00.0: Adding to iommu group 25
> 2025-05-21T09:18:23.200403+00:00 mc-misc2002 kernel: [   10.408383] pci 0=
000:00:00.1: Adding to iommu group 26
> 2025-05-21T09:18:23.200403+00:00 mc-misc2002 kernel: [   10.414173] pci 0=
000:00:00.2: Adding to iommu group 27
> 2025-05-21T09:18:23.200403+00:00 mc-misc2002 kernel: [   10.419975] pci 0=
000:00:00.4: Adding to iommu group 28
> 2025-05-21T09:18:23.200406+00:00 mc-misc2002 kernel: [   10.425775] pci 0=
000:00:01.0: Adding to iommu group 29
> 2025-05-21T09:18:23.200406+00:00 mc-misc2002 kernel: [   10.431576] pci 0=
000:00:01.1: Adding to iommu group 30
> 2025-05-21T09:18:23.200406+00:00 mc-misc2002 kernel: [   10.437376] pci 0=
000:00:01.2: Adding to iommu group 31
> 2025-05-21T09:18:23.200407+00:00 mc-misc2002 kernel: [   10.443178] pci 0=
000:00:01.3: Adding to iommu group 32
> 2025-05-21T09:18:23.200407+00:00 mc-misc2002 kernel: [   10.448979] pci 0=
000:00:01.4: Adding to iommu group 33
> 2025-05-21T09:18:23.200407+00:00 mc-misc2002 kernel: [   10.454779] pci 0=
000:00:01.5: Adding to iommu group 34
> 2025-05-21T09:18:23.200410+00:00 mc-misc2002 kernel: [   10.460580] pci 0=
000:00:01.6: Adding to iommu group 35
> 2025-05-21T09:18:23.200410+00:00 mc-misc2002 kernel: [   10.466384] pci 0=
000:00:01.7: Adding to iommu group 36
> 2025-05-21T09:18:23.200411+00:00 mc-misc2002 kernel: [   10.472261] pci 0=
000:00:02.0: Adding to iommu group 37
> 2025-05-21T09:18:23.200411+00:00 mc-misc2002 kernel: [   10.478060] pci 0=
000:00:02.1: Adding to iommu group 37
> 2025-05-21T09:18:23.200411+00:00 mc-misc2002 kernel: [   10.483860] pci 0=
000:00:02.4: Adding to iommu group 37
> 2025-05-21T09:18:23.200411+00:00 mc-misc2002 kernel: [   10.489715] pci 0=
000:00:11.0: Adding to iommu group 38
> 2025-05-21T09:18:23.200414+00:00 mc-misc2002 kernel: [   10.495510] pci 0=
000:00:11.5: Adding to iommu group 38
> 2025-05-21T09:18:23.200414+00:00 mc-misc2002 kernel: [   10.496040] Freei=
ng initrd memory: 42236K
> 2025-05-21T09:18:23.200414+00:00 mc-misc2002 kernel: [   10.501365] pci 0=
000:00:14.0: Adding to iommu group 39
> 2025-05-21T09:18:23.200415+00:00 mc-misc2002 kernel: [   10.511586] pci 0=
000:00:14.2: Adding to iommu group 39
> 2025-05-21T09:18:23.200415+00:00 mc-misc2002 kernel: [   10.517458] pci 0=
000:00:16.0: Adding to iommu group 40
> 2025-05-21T09:18:23.200415+00:00 mc-misc2002 kernel: [   10.523251] pci 0=
000:00:16.1: Adding to iommu group 40
> 2025-05-21T09:18:23.200415+00:00 mc-misc2002 kernel: [   10.529053] pci 0=
000:00:16.4: Adding to iommu group 40
> 2025-05-21T09:18:23.200418+00:00 mc-misc2002 kernel: [   10.534844] pci 0=
000:00:17.0: Adding to iommu group 41
> 2025-05-21T09:18:23.200418+00:00 mc-misc2002 kernel: [   10.540673] pci 0=
000:00:1c.0: Adding to iommu group 42
> 2025-05-21T09:18:23.200418+00:00 mc-misc2002 kernel: [   10.546475] pci 0=
000:00:1c.4: Adding to iommu group 43
> 2025-05-21T09:18:23.200419+00:00 mc-misc2002 kernel: [   10.552266] pci 0=
000:00:1c.5: Adding to iommu group 44
> 2025-05-21T09:18:23.200419+00:00 mc-misc2002 kernel: [   10.558167] pci 0=
000:00:1f.0: Adding to iommu group 45
> 2025-05-21T09:18:23.200419+00:00 mc-misc2002 kernel: [   10.563967] pci 0=
000:00:1f.2: Adding to iommu group 45
> 2025-05-21T09:18:23.200422+00:00 mc-misc2002 kernel: [   10.569768] pci 0=
000:00:1f.4: Adding to iommu group 45
> 2025-05-21T09:18:23.200422+00:00 mc-misc2002 kernel: [   10.575568] pci 0=
000:00:1f.5: Adding to iommu group 45
> 2025-05-21T09:18:23.200422+00:00 mc-misc2002 kernel: [   10.581368] pci 0=
000:03:00.0: Adding to iommu group 46
> 2025-05-21T09:18:23.200423+00:00 mc-misc2002 kernel: [   10.587140] pci 0=
000:04:00.0: Adding to iommu group 46
> 2025-05-21T09:18:23.200423+00:00 mc-misc2002 kernel: [   10.592942] pci 0=
000:16:00.0: Adding to iommu group 47
> 2025-05-21T09:18:23.200423+00:00 mc-misc2002 kernel: [   10.598732] pci 0=
000:16:00.1: Adding to iommu group 48
> 2025-05-21T09:18:23.200424+00:00 mc-misc2002 kernel: [   10.604531] pci 0=
000:16:00.2: Adding to iommu group 49
> 2025-05-21T09:18:23.200426+00:00 mc-misc2002 kernel: [   10.610332] pci 0=
000:16:00.4: Adding to iommu group 50
> 2025-05-21T09:18:23.200426+00:00 mc-misc2002 kernel: [   10.616133] pci 0=
000:30:00.0: Adding to iommu group 51
> 2025-05-21T09:18:23.200427+00:00 mc-misc2002 kernel: [   10.621931] pci 0=
000:30:00.1: Adding to iommu group 52
> 2025-05-21T09:18:23.200427+00:00 mc-misc2002 kernel: [   10.627731] pci 0=
000:30:00.2: Adding to iommu group 53
> 2025-05-21T09:18:23.200427+00:00 mc-misc2002 kernel: [   10.633528] pci 0=
000:30:00.4: Adding to iommu group 54
> 2025-05-21T09:18:23.200427+00:00 mc-misc2002 kernel: [   10.639329] pci 0=
000:4a:00.0: Adding to iommu group 55
> 2025-05-21T09:18:23.200430+00:00 mc-misc2002 kernel: [   10.645127] pci 0=
000:4a:00.1: Adding to iommu group 56
> 2025-05-21T09:18:23.200430+00:00 mc-misc2002 kernel: [   10.650929] pci 0=
000:4a:00.2: Adding to iommu group 57
> 2025-05-21T09:18:23.200431+00:00 mc-misc2002 kernel: [   10.656730] pci 0=
000:4a:00.4: Adding to iommu group 58
> 2025-05-21T09:18:23.200431+00:00 mc-misc2002 kernel: [   10.662531] pci 0=
000:64:00.0: Adding to iommu group 59
> 2025-05-21T09:18:23.200431+00:00 mc-misc2002 kernel: [   10.668331] pci 0=
000:64:00.1: Adding to iommu group 60
> 2025-05-21T09:18:23.200431+00:00 mc-misc2002 kernel: [   10.674131] pci 0=
000:64:00.2: Adding to iommu group 61
> 2025-05-21T09:18:23.200434+00:00 mc-misc2002 kernel: [   10.679930] pci 0=
000:64:00.4: Adding to iommu group 62
> 2025-05-21T09:18:23.200434+00:00 mc-misc2002 kernel: [   10.685735] pci 0=
000:7e:00.0: Adding to iommu group 63
> 2025-05-21T09:18:23.200435+00:00 mc-misc2002 kernel: [   10.691535] pci 0=
000:7e:00.1: Adding to iommu group 64
> 2025-05-21T09:18:23.200435+00:00 mc-misc2002 kernel: [   10.697335] pci 0=
000:7e:00.2: Adding to iommu group 65
> 2025-05-21T09:18:23.200435+00:00 mc-misc2002 kernel: [   10.703143] pci 0=
000:7e:00.3: Adding to iommu group 66
> 2025-05-21T09:18:23.200435+00:00 mc-misc2002 kernel: [   10.708948] pci 0=
000:7e:00.5: Adding to iommu group 67
> 2025-05-21T09:18:23.200436+00:00 mc-misc2002 kernel: [   10.714749] pci 0=
000:7e:02.0: Adding to iommu group 68
> 2025-05-21T09:18:23.200438+00:00 mc-misc2002 kernel: [   10.720548] pci 0=
000:7e:02.1: Adding to iommu group 69
> 2025-05-21T09:18:23.200439+00:00 mc-misc2002 kernel: [   10.726346] pci 0=
000:7e:02.2: Adding to iommu group 70
> 2025-05-21T09:18:23.200439+00:00 mc-misc2002 kernel: [   10.732145] pci 0=
000:7e:04.0: Adding to iommu group 71
> 2025-05-21T09:18:23.200439+00:00 mc-misc2002 kernel: [   10.737943] pci 0=
000:7e:04.1: Adding to iommu group 72
> 2025-05-21T09:18:23.200440+00:00 mc-misc2002 kernel: [   10.743741] pci 0=
000:7e:04.2: Adding to iommu group 73
> 2025-05-21T09:18:23.200440+00:00 mc-misc2002 kernel: [   10.749540] pci 0=
000:7e:04.3: Adding to iommu group 74
> 2025-05-21T09:18:23.200442+00:00 mc-misc2002 kernel: [   10.755340] pci 0=
000:7e:05.0: Adding to iommu group 75
> 2025-05-21T09:18:23.200442+00:00 mc-misc2002 kernel: [   10.761138] pci 0=
000:7e:05.1: Adding to iommu group 76
> 2025-05-21T09:18:23.200443+00:00 mc-misc2002 kernel: [   10.766935] pci 0=
000:7e:05.2: Adding to iommu group 77
> 2025-05-21T09:18:23.200443+00:00 mc-misc2002 kernel: [   10.772737] pci 0=
000:7e:06.0: Adding to iommu group 78
> 2025-05-21T09:18:23.200443+00:00 mc-misc2002 kernel: [   10.778536] pci 0=
000:7e:06.1: Adding to iommu group 79
> 2025-05-21T09:18:23.200444+00:00 mc-misc2002 kernel: [   10.784334] pci 0=
000:7e:06.2: Adding to iommu group 80
> 2025-05-21T09:18:23.200444+00:00 mc-misc2002 kernel: [   10.790132] pci 0=
000:7e:07.0: Adding to iommu group 81
> 2025-05-21T09:18:23.200447+00:00 mc-misc2002 kernel: [   10.795929] pci 0=
000:7e:07.1: Adding to iommu group 82
> 2025-05-21T09:18:23.200448+00:00 mc-misc2002 kernel: [   10.801728] pci 0=
000:7e:07.2: Adding to iommu group 83
> 2025-05-21T09:18:23.200448+00:00 mc-misc2002 kernel: [   10.807602] pci 0=
000:7e:0b.0: Adding to iommu group 84
> 2025-05-21T09:18:23.200448+00:00 mc-misc2002 kernel: [   10.813407] pci 0=
000:7e:0b.1: Adding to iommu group 84
> 2025-05-21T09:18:23.200448+00:00 mc-misc2002 kernel: [   10.819211] pci 0=
000:7e:0b.2: Adding to iommu group 84
> 2025-05-21T09:18:23.200449+00:00 mc-misc2002 kernel: [   10.825008] pci 0=
000:7e:0c.0: Adding to iommu group 85
> 2025-05-21T09:18:23.200451+00:00 mc-misc2002 kernel: [   10.830808] pci 0=
000:7e:0d.0: Adding to iommu group 86
> 2025-05-21T09:18:23.200451+00:00 mc-misc2002 kernel: [   10.836607] pci 0=
000:7e:0e.0: Adding to iommu group 87
> 2025-05-21T09:18:23.200452+00:00 mc-misc2002 kernel: [   10.842405] pci 0=
000:7e:0f.0: Adding to iommu group 88
> 2025-05-21T09:18:23.200452+00:00 mc-misc2002 kernel: [   10.848206] pci 0=
000:7e:1a.0: Adding to iommu group 89
> 2025-05-21T09:18:23.200452+00:00 mc-misc2002 kernel: [   10.854005] pci 0=
000:7e:1b.0: Adding to iommu group 90
> 2025-05-21T09:18:23.200452+00:00 mc-misc2002 kernel: [   10.859804] pci 0=
000:7e:1c.0: Adding to iommu group 91
> 2025-05-21T09:18:23.200455+00:00 mc-misc2002 kernel: [   10.865603] pci 0=
000:7e:1d.0: Adding to iommu group 92
> 2025-05-21T09:18:23.200455+00:00 mc-misc2002 kernel: [   10.871404] pci 0=
000:7f:00.0: Adding to iommu group 93
> 2025-05-21T09:18:23.200456+00:00 mc-misc2002 kernel: [   10.877203] pci 0=
000:7f:00.1: Adding to iommu group 94
> 2025-05-21T09:18:23.200456+00:00 mc-misc2002 kernel: [   10.883003] pci 0=
000:7f:00.2: Adding to iommu group 95
> 2025-05-21T09:18:23.200456+00:00 mc-misc2002 kernel: [   10.888802] pci 0=
000:7f:00.3: Adding to iommu group 96
> 2025-05-21T09:18:23.200457+00:00 mc-misc2002 kernel: [   10.894601] pci 0=
000:7f:00.4: Adding to iommu group 97
> 2025-05-21T09:18:23.200457+00:00 mc-misc2002 kernel: [   10.900402] pci 0=
000:7f:00.5: Adding to iommu group 98
> 2025-05-21T09:18:23.200459+00:00 mc-misc2002 kernel: [   10.906202] pci 0=
000:7f:00.6: Adding to iommu group 99
> 2025-05-21T09:18:23.200459+00:00 mc-misc2002 kernel: [   10.912000] pci 0=
000:7f:00.7: Adding to iommu group 100
> 2025-05-21T09:18:23.200460+00:00 mc-misc2002 kernel: [   10.917896] pci 0=
000:7f:01.0: Adding to iommu group 101
> 2025-05-21T09:18:23.200460+00:00 mc-misc2002 kernel: [   10.923793] pci 0=
000:7f:01.1: Adding to iommu group 102
> 2025-05-21T09:18:23.200460+00:00 mc-misc2002 kernel: [   10.929689] pci 0=
000:7f:01.2: Adding to iommu group 103
> 2025-05-21T09:18:23.200461+00:00 mc-misc2002 kernel: [   10.935586] pci 0=
000:7f:01.3: Adding to iommu group 104
> 2025-05-21T09:18:23.200463+00:00 mc-misc2002 kernel: [   10.941482] pci 0=
000:7f:0a.0: Adding to iommu group 105
> 2025-05-21T09:18:23.200463+00:00 mc-misc2002 kernel: [   10.947380] pci 0=
000:7f:0a.1: Adding to iommu group 106
> 2025-05-21T09:18:23.200464+00:00 mc-misc2002 kernel: [   10.953278] pci 0=
000:7f:0a.2: Adding to iommu group 107
> 2025-05-21T09:18:23.200464+00:00 mc-misc2002 kernel: [   10.959172] pci 0=
000:7f:0a.3: Adding to iommu group 108
> 2025-05-21T09:18:23.200464+00:00 mc-misc2002 kernel: [   10.965070] pci 0=
000:7f:0a.4: Adding to iommu group 109
> 2025-05-21T09:18:23.200464+00:00 mc-misc2002 kernel: [   10.970967] pci 0=
000:7f:0a.5: Adding to iommu group 110
> 2025-05-21T09:18:23.200465+00:00 mc-misc2002 kernel: [   10.976864] pci 0=
000:7f:0a.6: Adding to iommu group 111
> 2025-05-21T09:18:23.200467+00:00 mc-misc2002 kernel: [   10.982759] pci 0=
000:7f:0a.7: Adding to iommu group 112
> 2025-05-21T09:18:23.200467+00:00 mc-misc2002 kernel: [   10.988655] pci 0=
000:7f:0b.0: Adding to iommu group 113
> 2025-05-21T09:18:23.200468+00:00 mc-misc2002 kernel: [   10.994552] pci 0=
000:7f:0b.1: Adding to iommu group 114
> 2025-05-21T09:18:23.200468+00:00 mc-misc2002 kernel: [   11.000449] pci 0=
000:7f:0b.2: Adding to iommu group 115
> 2025-05-21T09:18:23.200468+00:00 mc-misc2002 kernel: [   11.006346] pci 0=
000:7f:0b.3: Adding to iommu group 116
> 2025-05-21T09:18:23.200469+00:00 mc-misc2002 kernel: [   11.012244] pci 0=
000:7f:1d.0: Adding to iommu group 117
> 2025-05-21T09:18:23.200471+00:00 mc-misc2002 kernel: [   11.018142] pci 0=
000:7f:1d.1: Adding to iommu group 118
> 2025-05-21T09:18:23.200471+00:00 mc-misc2002 kernel: [   11.024242] pci 0=
000:7f:1e.0: Adding to iommu group 119
> 2025-05-21T09:18:23.200472+00:00 mc-misc2002 kernel: [   11.030149] pci 0=
000:7f:1e.1: Adding to iommu group 119
> 2025-05-21T09:18:23.200472+00:00 mc-misc2002 kernel: [   11.036055] pci 0=
000:7f:1e.2: Adding to iommu group 119
> 2025-05-21T09:18:23.200472+00:00 mc-misc2002 kernel: [   11.041961] pci 0=
000:7f:1e.3: Adding to iommu group 119
> 2025-05-21T09:18:23.200473+00:00 mc-misc2002 kernel: [   11.047870] pci 0=
000:7f:1e.4: Adding to iommu group 119
> 2025-05-21T09:18:23.200475+00:00 mc-misc2002 kernel: [   11.053779] pci 0=
000:7f:1e.5: Adding to iommu group 119
> 2025-05-21T09:18:23.200475+00:00 mc-misc2002 kernel: [   11.059678] pci 0=
000:7f:1e.6: Adding to iommu group 119
> 2025-05-21T09:18:23.200476+00:00 mc-misc2002 kernel: [   11.065584] pci 0=
000:7f:1e.7: Adding to iommu group 119
> 2025-05-21T09:18:23.200476+00:00 mc-misc2002 kernel: [   11.071481] pci 0=
000:80:00.0: Adding to iommu group 120
> 2025-05-21T09:18:23.200476+00:00 mc-misc2002 kernel: [   11.077378] pci 0=
000:80:00.1: Adding to iommu group 121
> 2025-05-21T09:18:23.200476+00:00 mc-misc2002 kernel: [   11.083274] pci 0=
000:80:00.2: Adding to iommu group 122
> 2025-05-21T09:18:23.200477+00:00 mc-misc2002 kernel: [   11.089172] pci 0=
000:80:00.4: Adding to iommu group 123
> 2025-05-21T09:18:23.200479+00:00 mc-misc2002 kernel: [   11.095146] pci 0=
000:80:02.0: Adding to iommu group 124
> 2025-05-21T09:18:23.200479+00:00 mc-misc2002 kernel: [   11.101055] pci 0=
000:80:02.1: Adding to iommu group 124
> 2025-05-21T09:18:23.200480+00:00 mc-misc2002 kernel: [   11.106955] pci 0=
000:80:02.4: Adding to iommu group 124
> 2025-05-21T09:18:23.200480+00:00 mc-misc2002 kernel: [   11.112853] pci 0=
000:97:00.0: Adding to iommu group 125
> 2025-05-21T09:18:23.200480+00:00 mc-misc2002 kernel: [   11.118750] pci 0=
000:97:00.1: Adding to iommu group 126
> 2025-05-21T09:18:23.200480+00:00 mc-misc2002 kernel: [   11.124648] pci 0=
000:97:00.2: Adding to iommu group 127
> 2025-05-21T09:18:23.200483+00:00 mc-misc2002 kernel: [   11.130546] pci 0=
000:97:00.4: Adding to iommu group 128
> 2025-05-21T09:18:23.200483+00:00 mc-misc2002 kernel: [   11.136445] pci 0=
000:b0:00.0: Adding to iommu group 129
> 2025-05-21T09:18:23.200483+00:00 mc-misc2002 kernel: [   11.142344] pci 0=
000:b0:00.1: Adding to iommu group 130
> 2025-05-21T09:18:23.200484+00:00 mc-misc2002 kernel: [   11.148239] pci 0=
000:b0:00.2: Adding to iommu group 131
> 2025-05-21T09:18:23.200485+00:00 mc-misc2002 kernel: [   11.154135] pci 0=
000:b0:00.4: Adding to iommu group 132
> 2025-05-21T09:18:23.200486+00:00 mc-misc2002 kernel: [   11.160032] pci 0=
000:c9:00.0: Adding to iommu group 133
> 2025-05-21T09:18:23.200486+00:00 mc-misc2002 kernel: [   11.165928] pci 0=
000:c9:00.1: Adding to iommu group 134
> 2025-05-21T09:18:23.200488+00:00 mc-misc2002 kernel: [   11.171824] pci 0=
000:c9:00.2: Adding to iommu group 135
> 2025-05-21T09:18:23.200489+00:00 mc-misc2002 kernel: [   11.177719] pci 0=
000:c9:00.4: Adding to iommu group 136
> 2025-05-21T09:18:23.200489+00:00 mc-misc2002 kernel: [   11.183616] pci 0=
000:e2:00.0: Adding to iommu group 137
> 2025-05-21T09:18:23.200489+00:00 mc-misc2002 kernel: [   11.189515] pci 0=
000:e2:00.1: Adding to iommu group 138
> 2025-05-21T09:18:23.200489+00:00 mc-misc2002 kernel: [   11.195411] pci 0=
000:e2:00.2: Adding to iommu group 139
> 2025-05-21T09:18:23.200490+00:00 mc-misc2002 kernel: [   11.201307] pci 0=
000:e2:00.4: Adding to iommu group 140
> 2025-05-21T09:18:23.200492+00:00 mc-misc2002 kernel: [   11.207207] pci 0=
000:fe:00.0: Adding to iommu group 141
> 2025-05-21T09:18:23.200492+00:00 mc-misc2002 kernel: [   11.213105] pci 0=
000:fe:00.1: Adding to iommu group 142
> 2025-05-21T09:18:23.200493+00:00 mc-misc2002 kernel: [   11.219002] pci 0=
000:fe:00.2: Adding to iommu group 143
> 2025-05-21T09:18:23.200493+00:00 mc-misc2002 kernel: [   11.224898] pci 0=
000:fe:00.3: Adding to iommu group 144
> 2025-05-21T09:18:23.200493+00:00 mc-misc2002 kernel: [   11.230792] pci 0=
000:fe:00.5: Adding to iommu group 145
> 2025-05-21T09:18:23.200493+00:00 mc-misc2002 kernel: [   11.236690] pci 0=
000:fe:02.0: Adding to iommu group 146
> 2025-05-21T09:18:23.200496+00:00 mc-misc2002 kernel: [   11.242587] pci 0=
000:fe:02.1: Adding to iommu group 147
> 2025-05-21T09:18:23.200496+00:00 mc-misc2002 kernel: [   11.248481] pci 0=
000:fe:02.2: Adding to iommu group 148
> 2025-05-21T09:18:23.200496+00:00 mc-misc2002 kernel: [   11.254377] pci 0=
000:fe:04.0: Adding to iommu group 149
> 2025-05-21T09:18:23.200497+00:00 mc-misc2002 kernel: [   11.260276] pci 0=
000:fe:04.1: Adding to iommu group 150
> 2025-05-21T09:18:23.200497+00:00 mc-misc2002 kernel: [   11.266172] pci 0=
000:fe:04.2: Adding to iommu group 151
> 2025-05-21T09:18:23.200497+00:00 mc-misc2002 kernel: [   11.272067] pci 0=
000:fe:04.3: Adding to iommu group 152
> 2025-05-21T09:18:23.200497+00:00 mc-misc2002 kernel: [   11.277967] pci 0=
000:fe:05.0: Adding to iommu group 153
> 2025-05-21T09:18:23.200500+00:00 mc-misc2002 kernel: [   11.283857] pci 0=
000:fe:05.1: Adding to iommu group 154
> 2025-05-21T09:18:23.200500+00:00 mc-misc2002 kernel: [   11.289755] pci 0=
000:fe:05.2: Adding to iommu group 155
> 2025-05-21T09:18:23.200501+00:00 mc-misc2002 kernel: [   11.295652] pci 0=
000:fe:06.0: Adding to iommu group 156
> 2025-05-21T09:18:23.200501+00:00 mc-misc2002 kernel: [   11.301550] pci 0=
000:fe:06.1: Adding to iommu group 157
> 2025-05-21T09:18:23.200501+00:00 mc-misc2002 kernel: [   11.307445] pci 0=
000:fe:06.2: Adding to iommu group 158
> 2025-05-21T09:18:23.200501+00:00 mc-misc2002 kernel: [   11.313342] pci 0=
000:fe:07.0: Adding to iommu group 159
> 2025-05-21T09:18:23.200504+00:00 mc-misc2002 kernel: [   11.319239] pci 0=
000:fe:07.1: Adding to iommu group 160
> 2025-05-21T09:18:23.200505+00:00 mc-misc2002 kernel: [   11.325138] pci 0=
000:fe:07.2: Adding to iommu group 161
> 2025-05-21T09:18:23.200505+00:00 mc-misc2002 kernel: [   11.331114] pci 0=
000:fe:0b.0: Adding to iommu group 162
> 2025-05-21T09:18:23.200505+00:00 mc-misc2002 kernel: [   11.337031] pci 0=
000:fe:0b.1: Adding to iommu group 162
> 2025-05-21T09:18:23.200506+00:00 mc-misc2002 kernel: [   11.342938] pci 0=
000:fe:0b.2: Adding to iommu group 162
> 2025-05-21T09:18:23.200506+00:00 mc-misc2002 kernel: [   11.348834] pci 0=
000:fe:0c.0: Adding to iommu group 163
> 2025-05-21T09:18:23.200506+00:00 mc-misc2002 kernel: [   11.354732] pci 0=
000:fe:0d.0: Adding to iommu group 164
> 2025-05-21T09:18:23.200509+00:00 mc-misc2002 kernel: [   11.360630] pci 0=
000:fe:0e.0: Adding to iommu group 165
> 2025-05-21T09:18:23.200509+00:00 mc-misc2002 kernel: [   11.366529] pci 0=
000:fe:0f.0: Adding to iommu group 166
> 2025-05-21T09:18:23.200509+00:00 mc-misc2002 kernel: [   11.372427] pci 0=
000:fe:1a.0: Adding to iommu group 167
> 2025-05-21T09:18:23.200510+00:00 mc-misc2002 kernel: [   11.378322] pci 0=
000:fe:1b.0: Adding to iommu group 168
> 2025-05-21T09:18:23.200510+00:00 mc-misc2002 kernel: [   11.384220] pci 0=
000:fe:1c.0: Adding to iommu group 169
> 2025-05-21T09:18:23.200510+00:00 mc-misc2002 kernel: [   11.390116] pci 0=
000:fe:1d.0: Adding to iommu group 170
> 2025-05-21T09:18:23.200513+00:00 mc-misc2002 kernel: [   11.396013] pci 0=
000:ff:00.0: Adding to iommu group 171
> 2025-05-21T09:18:23.200513+00:00 mc-misc2002 kernel: [   11.401909] pci 0=
000:ff:00.1: Adding to iommu group 172
> 2025-05-21T09:18:23.200513+00:00 mc-misc2002 kernel: [   11.407811] pci 0=
000:ff:00.2: Adding to iommu group 173
> 2025-05-21T09:18:23.200513+00:00 mc-misc2002 kernel: [   11.413706] pci 0=
000:ff:00.3: Adding to iommu group 174
> 2025-05-21T09:18:23.200514+00:00 mc-misc2002 kernel: [   11.419602] pci 0=
000:ff:00.4: Adding to iommu group 175
> 2025-05-21T09:18:23.200514+00:00 mc-misc2002 kernel: [   11.425498] pci 0=
000:ff:00.5: Adding to iommu group 176
> 2025-05-21T09:18:23.200516+00:00 mc-misc2002 kernel: [   11.431396] pci 0=
000:ff:00.6: Adding to iommu group 177
> 2025-05-21T09:18:23.200517+00:00 mc-misc2002 kernel: [   11.437291] pci 0=
000:ff:00.7: Adding to iommu group 178
> 2025-05-21T09:18:23.200517+00:00 mc-misc2002 kernel: [   11.443188] pci 0=
000:ff:01.0: Adding to iommu group 179
> 2025-05-21T09:18:23.200517+00:00 mc-misc2002 kernel: [   11.449085] pci 0=
000:ff:01.1: Adding to iommu group 180
> 2025-05-21T09:18:23.200517+00:00 mc-misc2002 kernel: [   11.454983] pci 0=
000:ff:01.2: Adding to iommu group 181
> 2025-05-21T09:18:23.200518+00:00 mc-misc2002 kernel: [   11.460879] pci 0=
000:ff:01.3: Adding to iommu group 182
> 2025-05-21T09:18:23.200518+00:00 mc-misc2002 kernel: [   11.466777] pci 0=
000:ff:0a.0: Adding to iommu group 183
> 2025-05-21T09:18:23.200520+00:00 mc-misc2002 kernel: [   11.472672] pci 0=
000:ff:0a.1: Adding to iommu group 184
> 2025-05-21T09:18:23.200521+00:00 mc-misc2002 kernel: [   11.478570] pci 0=
000:ff:0a.2: Adding to iommu group 185
> 2025-05-21T09:18:23.200521+00:00 mc-misc2002 kernel: [   11.484466] pci 0=
000:ff:0a.3: Adding to iommu group 186
> 2025-05-21T09:18:23.200521+00:00 mc-misc2002 kernel: [   11.490361] pci 0=
000:ff:0a.4: Adding to iommu group 187
> 2025-05-21T09:18:23.200522+00:00 mc-misc2002 kernel: [   11.496259] pci 0=
000:ff:0a.5: Adding to iommu group 188
> 2025-05-21T09:18:23.200522+00:00 mc-misc2002 kernel: [   11.502155] pci 0=
000:ff:0a.6: Adding to iommu group 189
> 2025-05-21T09:18:23.200524+00:00 mc-misc2002 kernel: [   11.508050] pci 0=
000:ff:0a.7: Adding to iommu group 190
> 2025-05-21T09:18:23.200524+00:00 mc-misc2002 kernel: [   11.513947] pci 0=
000:ff:0b.0: Adding to iommu group 191
> 2025-05-21T09:18:23.200525+00:00 mc-misc2002 kernel: [   11.519843] pci 0=
000:ff:0b.1: Adding to iommu group 192
> 2025-05-21T09:18:23.200525+00:00 mc-misc2002 kernel: [   11.525745] pci 0=
000:ff:0b.2: Adding to iommu group 193
> 2025-05-21T09:18:23.200525+00:00 mc-misc2002 kernel: [   11.531640] pci 0=
000:ff:0b.3: Adding to iommu group 194
> 2025-05-21T09:18:23.200526+00:00 mc-misc2002 kernel: [   11.537536] pci 0=
000:ff:1d.0: Adding to iommu group 195
> 2025-05-21T09:18:23.200526+00:00 mc-misc2002 kernel: [   11.543431] pci 0=
000:ff:1d.1: Adding to iommu group 196
> 2025-05-21T09:18:23.200528+00:00 mc-misc2002 kernel: [   11.549535] pci 0=
000:ff:1e.0: Adding to iommu group 197
> 2025-05-21T09:18:23.200529+00:00 mc-misc2002 kernel: [   11.555452] pci 0=
000:ff:1e.1: Adding to iommu group 197
> 2025-05-21T09:18:23.200529+00:00 mc-misc2002 kernel: [   11.561362] pci 0=
000:ff:1e.2: Adding to iommu group 197
> 2025-05-21T09:18:23.200529+00:00 mc-misc2002 kernel: [   11.567282] pci 0=
000:ff:1e.3: Adding to iommu group 197
> 2025-05-21T09:18:23.200529+00:00 mc-misc2002 kernel: [   11.573201] pci 0=
000:ff:1e.4: Adding to iommu group 197
> 2025-05-21T09:18:23.200530+00:00 mc-misc2002 kernel: [   11.579121] pci 0=
000:ff:1e.5: Adding to iommu group 197
> 2025-05-21T09:18:23.200532+00:00 mc-misc2002 kernel: [   11.585039] pci 0=
000:ff:1e.6: Adding to iommu group 197
> 2025-05-21T09:18:23.200533+00:00 mc-misc2002 kernel: [   11.590960] pci 0=
000:ff:1e.7: Adding to iommu group 197
> 2025-05-21T09:18:23.200533+00:00 mc-misc2002 kernel: [   11.645721] DMAR:=
 Intel(R) Virtualization Technology for Directed I/O
> 2025-05-21T09:18:23.200533+00:00 mc-misc2002 kernel: [   11.652956] PCI-D=
MA: Using software bounce buffering for IO (SWIOTLB)
> 2025-05-21T09:18:23.200533+00:00 mc-misc2002 kernel: [   11.660186] softw=
are IO TLB: mapped [mem 0x00000000605ff000-0x00000000645ff000] (64MB)
> 2025-05-21T09:18:23.200534+00:00 mc-misc2002 kernel: [   11.670051] Initi=
alise system trusted keyrings
> 2025-05-21T09:18:23.200536+00:00 mc-misc2002 kernel: [   11.675055] Key t=
ype blacklist registered
> 2025-05-21T09:18:23.200537+00:00 mc-misc2002 kernel: [   11.679634] worki=
ngset: timestamp_bits=3D36 max_order=3D26 bucket_order=3D0
> 2025-05-21T09:18:23.200537+00:00 mc-misc2002 kernel: [   11.687960] zbud:=
 loaded
> 2025-05-21T09:18:23.200537+00:00 mc-misc2002 kernel: [   11.691116] integ=
rity: Platform Keyring initialized
> 2025-05-21T09:18:23.200538+00:00 mc-misc2002 kernel: [   11.696599] integ=
rity: Machine keyring initialized
> 2025-05-21T09:18:23.200538+00:00 mc-misc2002 kernel: [   11.701980] Key t=
ype asymmetric registered
> 2025-05-21T09:18:23.200538+00:00 mc-misc2002 kernel: [   11.706582] Asymm=
etric key parser 'x509' registered
> 2025-05-21T09:18:23.200541+00:00 mc-misc2002 kernel: [   11.716860] alg: =
self-tests for CTR-KDF (hmac(sha256)) passed
> 2025-05-21T09:18:23.200541+00:00 mc-misc2002 kernel: [   11.723333] Block=
 layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
> 2025-05-21T09:18:23.200541+00:00 mc-misc2002 kernel: [   11.731705] io sc=
heduler mq-deadline registered
> 2025-05-21T09:18:23.200542+00:00 mc-misc2002 kernel: [   11.738255] pciep=
ort 0000:00:1c.0: PME: Signaling with IRQ 130
> 2025-05-21T09:18:23.200542+00:00 mc-misc2002 kernel: [   11.744839] pciep=
ort 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- H=
otPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
> 2025-05-21T09:18:23.200542+00:00 mc-misc2002 kernel: [   11.760226] pciep=
ort 0000:00:1c.4: PME: Signaling with IRQ 131
> 2025-05-21T09:18:23.200545+00:00 mc-misc2002 kernel: [   11.766963] pciep=
ort 0000:00:1c.5: PME: Signaling with IRQ 132
> 2025-05-21T09:18:23.200545+00:00 mc-misc2002 kernel: [   11.773667] pciep=
ort 0000:4a:05.0: PME: Signaling with IRQ 133
> 2025-05-21T09:18:23.200546+00:00 mc-misc2002 kernel: [   11.780344] pciep=
ort 0000:64:02.0: PME: Signaling with IRQ 134
> 2025-05-21T09:18:23.200546+00:00 mc-misc2002 kernel: [   11.786907] pciep=
ort 0000:64:02.0: pciehp: Slot #48 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T09:18:23.200546+00:00 mc-misc2002 kernel: [   11.804770] pciep=
ort 0000:64:03.0: PME: Signaling with IRQ 135
> 2025-05-21T09:18:23.200546+00:00 mc-misc2002 kernel: [   11.811324] pciep=
ort 0000:64:03.0: pciehp: Slot #49 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T09:18:23.200549+00:00 mc-misc2002 kernel: [   11.829178] pciep=
ort 0000:64:04.0: PME: Signaling with IRQ 136
> 2025-05-21T09:18:23.200549+00:00 mc-misc2002 kernel: [   11.835744] pciep=
ort 0000:64:04.0: pciehp: Slot #50 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T09:18:23.200550+00:00 mc-misc2002 kernel: [   11.853588] pciep=
ort 0000:64:05.0: PME: Signaling with IRQ 137
> 2025-05-21T09:18:23.200550+00:00 mc-misc2002 kernel: [   11.860153] pciep=
ort 0000:64:05.0: pciehp: Slot #51 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T09:18:23.200550+00:00 mc-misc2002 kernel: [   11.878160] pciep=
ort 0000:97:04.0: PME: Signaling with IRQ 138
> 2025-05-21T09:18:23.200551+00:00 mc-misc2002 kernel: [   11.884870] pciep=
ort 0000:c9:02.0: PME: Signaling with IRQ 139
> 2025-05-21T09:18:23.200553+00:00 mc-misc2002 kernel: [   11.891441] pciep=
ort 0000:c9:02.0: pciehp: Slot #52 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T09:18:23.200553+00:00 mc-misc2002 kernel: [   11.909306] pciep=
ort 0000:c9:03.0: PME: Signaling with IRQ 140
> 2025-05-21T09:18:23.200554+00:00 mc-misc2002 kernel: [   11.915875] pciep=
ort 0000:c9:03.0: pciehp: Slot #53 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T09:18:23.200554+00:00 mc-misc2002 kernel: [   11.933720] pciep=
ort 0000:e2:02.0: PME: Signaling with IRQ 141
> 2025-05-21T09:18:23.200554+00:00 mc-misc2002 kernel: [   11.940291] pciep=
ort 0000:e2:02.0: pciehp: Slot #54 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T09:18:23.200557+00:00 mc-misc2002 kernel: [   11.958143] pciep=
ort 0000:e2:03.0: PME: Signaling with IRQ 142
> 2025-05-21T09:18:23.200557+00:00 mc-misc2002 kernel: [   11.964708] pciep=
ort 0000:e2:03.0: pciehp: Slot #55 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T09:18:23.200557+00:00 mc-misc2002 kernel: [   11.982545] pciep=
ort 0000:e2:04.0: PME: Signaling with IRQ 143
> 2025-05-21T09:18:23.200557+00:00 mc-misc2002 kernel: [   11.989111] pciep=
ort 0000:e2:04.0: pciehp: Slot #56 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T09:18:23.200558+00:00 mc-misc2002 kernel: [   12.006954] pciep=
ort 0000:e2:05.0: PME: Signaling with IRQ 144
> 2025-05-21T09:18:23.200558+00:00 mc-misc2002 kernel: [   12.013521] pciep=
ort 0000:e2:05.0: pciehp: Slot #57 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ =
HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl=
 erratum)
> 2025-05-21T09:18:23.200561+00:00 mc-misc2002 kernel: [   12.031537] shpch=
p: Standard Hot Plug PCI Controller Driver version: 0.4
> 2025-05-21T09:18:23.200561+00:00 mc-misc2002 kernel: [   12.039203] Monit=
or-Mwait will be used to enter C-1 state
> 2025-05-21T09:18:23.200561+00:00 mc-misc2002 kernel: [   12.039212] Monit=
or-Mwait will be used to enter C-2 state
> 2025-05-21T09:18:23.200561+00:00 mc-misc2002 kernel: [   12.039217] ACPI:=
 \_SB_.SCK0.C000: Found 2 idle states
> 2025-05-21T09:18:23.200562+00:00 mc-misc2002 kernel: [   12.048635] acpi/=
hmat: Memory (0x0 length 0x80000000) Flags:0003 Processor Domain:0 Memory D=
omain:0
> 2025-05-21T09:18:23.200562+00:00 mc-misc2002 kernel: [   12.058798] acpi/=
hmat: Memory (0x100000000 length 0x1f80000000) Flags:0003 Processor Domain:=
0 Memory Domain:0
> 2025-05-21T09:18:23.200566+00:00 mc-misc2002 kernel: [   12.069931] acpi/=
hmat: Memory (0x2080000000 length 0x2000000000) Flags:0003 Processor Domain=
:1 Memory Domain:1
> 2025-05-21T09:18:23.200566+00:00 mc-misc2002 kernel: [   12.081159] acpi/=
hmat: Locality: Flags:00 Type:Read Latency Initiator Domains:2 Target Domai=
ns:2 Base:100
> 2025-05-21T09:18:23.200566+00:00 mc-misc2002 kernel: [   12.091900] acpi/=
hmat:   Initiator-Target[0-0]:7600 nsec
> 2025-05-21T09:18:23.200567+00:00 mc-misc2002 kernel: [   12.097865] acpi/=
hmat:   Initiator-Target[0-1]:13560 nsec
> 2025-05-21T09:18:23.200567+00:00 mc-misc2002 kernel: [   12.103925] acpi/=
hmat:   Initiator-Target[1-0]:13560 nsec
> 2025-05-21T09:18:23.200567+00:00 mc-misc2002 kernel: [   12.109976] acpi/=
hmat:   Initiator-Target[1-1]:7600 nsec
> 2025-05-21T09:18:23.200570+00:00 mc-misc2002 kernel: [   12.115940] acpi/=
hmat: Locality: Flags:00 Type:Write Latency Initiator Domains:2 Target Doma=
ins:2 Base:100
> 2025-05-21T09:18:23.200570+00:00 mc-misc2002 kernel: [   12.126779] acpi/=
hmat:   Initiator-Target[0-0]:7600 nsec
> 2025-05-21T09:18:23.200570+00:00 mc-misc2002 kernel: [   12.132741] acpi/=
hmat:   Initiator-Target[0-1]:13560 nsec
> 2025-05-21T09:18:23.200570+00:00 mc-misc2002 kernel: [   12.138802] acpi/=
hmat:   Initiator-Target[1-0]:13560 nsec
> 2025-05-21T09:18:23.200571+00:00 mc-misc2002 kernel: [   12.144863] acpi/=
hmat:   Initiator-Target[1-1]:7600 nsec
> 2025-05-21T09:18:23.200571+00:00 mc-misc2002 kernel: [   12.150816] acpi/=
hmat: Locality: Flags:00 Type:Read Bandwidth Initiator Domains:2 Target Dom=
ains:2 Base:1
> 2025-05-21T09:18:23.200573+00:00 mc-misc2002 kernel: [   12.161548] acpi/=
hmat:   Initiator-Target[0-0]:1790 MB/s
> 2025-05-21T09:18:23.200574+00:00 mc-misc2002 kernel: [   12.167502] acpi/=
hmat:   Initiator-Target[0-1]:1790 MB/s
> 2025-05-21T09:18:23.200574+00:00 mc-misc2002 kernel: [   12.173465] acpi/=
hmat:   Initiator-Target[1-0]:1790 MB/s
> 2025-05-21T09:18:23.200574+00:00 mc-misc2002 kernel: [   12.179429] acpi/=
hmat:   Initiator-Target[1-1]:1790 MB/s
> 2025-05-21T09:18:23.200575+00:00 mc-misc2002 kernel: [   12.185391] acpi/=
hmat: Locality: Flags:00 Type:Write Bandwidth Initiator Domains:2 Target Do=
mains:2 Base:1
> 2025-05-21T09:18:23.200575+00:00 mc-misc2002 kernel: [   12.196230] acpi/=
hmat:   Initiator-Target[0-0]:1910 MB/s
> 2025-05-21T09:18:23.200577+00:00 mc-misc2002 kernel: [   12.202193] acpi/=
hmat:   Initiator-Target[0-1]:1910 MB/s
> 2025-05-21T09:18:23.200578+00:00 mc-misc2002 kernel: [   12.208157] acpi/=
hmat:   Initiator-Target[1-0]:1910 MB/s
> 2025-05-21T09:18:23.200578+00:00 mc-misc2002 kernel: [   12.214118] acpi/=
hmat:   Initiator-Target[1-1]:1910 MB/s
> 2025-05-21T09:18:23.200578+00:00 mc-misc2002 kernel: [   12.220329] ERST:=
 Error Record Serialization Table (ERST) support is initialized.
> 2025-05-21T09:18:23.200579+00:00 mc-misc2002 kernel: [   12.228733] pstor=
e: Registered erst as persistent store backend
> 2025-05-21T09:18:23.200579+00:00 mc-misc2002 kernel: [   12.235686] Seria=
l: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 2025-05-21T09:18:23.200581+00:00 mc-misc2002 kernel: [   12.242974] 00:03=
: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) is a 16550A
> 2025-05-21T09:18:23.200582+00:00 mc-misc2002 kernel: [   12.265672] 00:04=
: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) is a 16550A
> 2025-05-21T09:18:23.200582+00:00 mc-misc2002 kernel: [   12.288088] Linux=
 agpgart interface v0.103
> 2025-05-21T09:18:23.200582+00:00 mc-misc2002 kernel: [   12.292888] AMD-V=
i: AMD IOMMUv2 functionality not available on this system - This is not a b=
ug.
> 2025-05-21T09:18:23.200583+00:00 mc-misc2002 kernel: [   12.306236] i8042=
: PNP: No PS/2 controller found.
> 2025-05-21T09:18:23.200583+00:00 mc-misc2002 kernel: [   12.311600] mouse=
dev: PS/2 mouse device common for all mice
> 2025-05-21T09:18:23.200583+00:00 mc-misc2002 kernel: [   12.317875] rtc_c=
mos 00:00: RTC can wake from S4
> 2025-05-21T09:18:23.200586+00:00 mc-misc2002 kernel: [   12.323498] rtc_c=
mos 00:00: registered as rtc0
> 2025-05-21T09:18:23.200586+00:00 mc-misc2002 kernel: [   12.328570] rtc_c=
mos 00:00: setting system clock to 2025-05-21T09:18:08 UTC (1747819088)
> 2025-05-21T09:18:23.200586+00:00 mc-misc2002 kernel: [   12.337679] rtc_c=
mos 00:00: alarms up to one month, y3k, 114 bytes nvram
> 2025-05-21T09:18:23.200587+00:00 mc-misc2002 kernel: [   12.346997] intel=
_pstate: Intel P-state driver initializing
> 2025-05-21T09:18:23.200587+00:00 mc-misc2002 kernel: [   12.364018] ledtr=
ig-cpu: registered to indicate activity on CPUs
> 2025-05-21T09:18:23.200587+00:00 mc-misc2002 kernel: [   12.379830] NET: =
Registered PF_INET6 protocol family
> 2025-05-21T09:18:23.200590+00:00 mc-misc2002 kernel: [   12.394552] Segme=
nt Routing with IPv6
> 2025-05-21T09:18:23.200590+00:00 mc-misc2002 kernel: [   12.398675] In-si=
tu OAM (IOAM) with IPv6
> 2025-05-21T09:18:23.200590+00:00 mc-misc2002 kernel: [   12.403094] mip6:=
 Mobile IPv6
> 2025-05-21T09:18:23.200591+00:00 mc-misc2002 kernel: [   12.406425] NET: =
Registered PF_PACKET protocol family
> 2025-05-21T09:18:23.200591+00:00 mc-misc2002 kernel: [   12.412260] mpls_=
gso: MPLS GSO support
> 2025-05-21T09:18:23.200591+00:00 mc-misc2002 kernel: [   12.429644] micro=
code: sig=3D0x606a6, pf=3D0x1, revision=3D0xd0003f5
> 2025-05-21T09:18:23.200594+00:00 mc-misc2002 kernel: [   12.436955] micro=
code: Microcode Update Driver: v2.2.
> 2025-05-21T09:18:23.200594+00:00 mc-misc2002 kernel: [   12.437957] resct=
rl: L3 allocation detected
> 2025-05-21T09:18:23.200595+00:00 mc-misc2002 kernel: [   12.448315] resct=
rl: MB allocation detected
> 2025-05-21T09:18:23.200595+00:00 mc-misc2002 kernel: [   12.453009] resct=
rl: L3 monitoring detected
> 2025-05-21T09:18:23.200595+00:00 mc-misc2002 kernel: [   12.457706] IPI s=
horthand broadcast: enabled
> 2025-05-21T09:18:23.200596+00:00 mc-misc2002 kernel: [   12.462525] sched=
_clock: Marking stable (10777764883, 1684734102)->(13066440236, -603941251)
> 2025-05-21T09:18:23.200596+00:00 mc-misc2002 kernel: [   12.473322] regis=
tered taskstats version 1
> 2025-05-21T09:18:23.200598+00:00 mc-misc2002 kernel: [   12.477935] Loadi=
ng compiled-in X.509 certificates
> 2025-05-21T09:18:23.200598+00:00 mc-misc2002 kernel: [   12.504998] Loade=
d X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419e=
a1'
> 2025-05-21T09:18:23.200599+00:00 mc-misc2002 kernel: [   12.514780] Loade=
d X.509 cert 'Debian Secure Boot Signer 2022 - linux: 14011249c2675ea8e5148=
542202005810584b25f'
> 2025-05-21T09:18:23.200599+00:00 mc-misc2002 kernel: [   12.531141] zswap=
: loaded using pool lzo/zbud
> 2025-05-21T09:18:23.200599+00:00 mc-misc2002 kernel: [   12.536575] Key t=
ype .fscrypt registered
> 2025-05-21T09:18:23.200600+00:00 mc-misc2002 kernel: [   12.540983] Key t=
ype fscrypt-provisioning registered
> 2025-05-21T09:18:23.200602+00:00 mc-misc2002 kernel: [   12.546849] pstor=
e: Using crash dump compression: deflate
> 2025-05-21T09:18:23.200602+00:00 mc-misc2002 kernel: [   12.557559] Key t=
ype encrypted registered
> 2025-05-21T09:18:23.200603+00:00 mc-misc2002 kernel: [   12.562066] AppAr=
mor: AppArmor sha1 policy hashing enabled
> 2025-05-21T09:18:23.200603+00:00 mc-misc2002 kernel: [   12.568233] ima: =
No TPM chip found, activating TPM-bypass!
> 2025-05-21T09:18:23.200603+00:00 mc-misc2002 kernel: [   12.574393] ima: =
Allocated hash algorithm: sha256
> 2025-05-21T09:18:23.200603+00:00 mc-misc2002 kernel: [   12.579679] ima: =
No architecture policies found
> 2025-05-21T09:18:23.200606+00:00 mc-misc2002 kernel: [   12.584771] evm: =
Initialising EVM extended attributes:
> 2025-05-21T09:18:23.200606+00:00 mc-misc2002 kernel: [   12.590539] evm: =
security.selinux
> 2025-05-21T09:18:23.200606+00:00 mc-misc2002 kernel: [   12.594259] evm: =
security.SMACK64 (disabled)
> 2025-05-21T09:18:23.200607+00:00 mc-misc2002 kernel: [   12.599053] evm: =
security.SMACK64EXEC (disabled)
> 2025-05-21T09:18:23.200607+00:00 mc-misc2002 kernel: [   12.604234] evm: =
security.SMACK64TRANSMUTE (disabled)
> 2025-05-21T09:18:23.200607+00:00 mc-misc2002 kernel: [   12.609905] evm: =
security.SMACK64MMAP (disabled)
> 2025-05-21T09:18:23.200607+00:00 mc-misc2002 kernel: [   12.615087] evm: =
security.apparmor
> 2025-05-21T09:18:23.200610+00:00 mc-misc2002 kernel: [   12.618898] evm: =
security.ima
> 2025-05-21T09:18:23.200610+00:00 mc-misc2002 kernel: [   12.622229] evm: =
security.capability
> 2025-05-21T09:18:23.200610+00:00 mc-misc2002 kernel: [   12.626241] evm: =
HMAC attrs: 0x1
> 2025-05-21T09:18:23.200611+00:00 mc-misc2002 kernel: [   12.672765] tsc: =
Refined TSC clocksource calibration: 2099.999 MHz
> 2025-05-21T09:18:23.200611+00:00 mc-misc2002 kernel: [   12.679752] clock=
source: tsc: mask: 0xffffffffffffffff max_cycles: 0x1e452fc488e, max_idle_n=
s: 440795307124 ns
> 2025-05-21T09:18:23.200611+00:00 mc-misc2002 kernel: [   12.691128] clock=
source: Switched to clocksource tsc
> 2025-05-21T09:18:23.200614+00:00 mc-misc2002 kernel: [   12.720763] clk: =
Disabling unused clocks
> 2025-05-21T09:18:23.200614+00:00 mc-misc2002 kernel: [   12.729643] Freei=
ng unused decrypted memory: 2036K
> 2025-05-21T09:18:23.200614+00:00 mc-misc2002 kernel: [   12.735584] Freei=
ng unused kernel image (initmem) memory: 2800K
> 2025-05-21T09:18:23.200615+00:00 mc-misc2002 kernel: [   12.742230] Write=
 protecting the kernel read-only data: 26624k
> 2025-05-21T09:18:23.200615+00:00 mc-misc2002 kernel: [   12.749404] Freei=
ng unused kernel image (text/rodata gap) memory: 2040K
> 2025-05-21T09:18:23.200615+00:00 mc-misc2002 kernel: [   12.757104] Freei=
ng unused kernel image (rodata/data gap) memory: 1144K
> 2025-05-21T09:18:23.200618+00:00 mc-misc2002 kernel: [   12.775071] x86/m=
m: Checked W+X mappings: passed, no W+X pages found.
> 2025-05-21T09:18:23.200618+00:00 mc-misc2002 kernel: [   12.782309] Run /=
init as init process
> 2025-05-21T09:18:23.200618+00:00 mc-misc2002 kernel: [   12.786423]   wit=
h arguments:
> 2025-05-21T09:18:23.200619+00:00 mc-misc2002 kernel: [   12.786424]     /=
init
> 2025-05-21T09:18:23.200619+00:00 mc-misc2002 kernel: [   12.786425]   wit=
h environment:
> 2025-05-21T09:18:23.200619+00:00 mc-misc2002 kernel: [   12.786425]     H=
OME=3D/
> 2025-05-21T09:18:23.200620+00:00 mc-misc2002 kernel: [   12.786426]     T=
ERM=3Dlinux
> 2025-05-21T09:18:23.200622+00:00 mc-misc2002 kernel: [   12.786426]     B=
OOT_IMAGE=3D/boot/vmlinuz-6.1.0-36-amd64
> 2025-05-21T09:18:23.200622+00:00 mc-misc2002 kernel: [   12.981475] dca s=
ervice started, version 1.12.1
> 2025-05-21T09:18:23.200623+00:00 mc-misc2002 kernel: [   12.988341] i801_=
smbus 0000:00:1f.4: enabling device (0001 -> 0003)
> 2025-05-21T09:18:23.200623+00:00 mc-misc2002 kernel: [   12.995554] i801_=
smbus 0000:00:1f.4: SPD Write Disable is set
> 2025-05-21T09:18:23.200623+00:00 mc-misc2002 kernel: [   13.002051] i801_=
smbus 0000:00:1f.4: SMBus using PCI interrupt
> 2025-05-21T09:18:23.200623+00:00 mc-misc2002 kernel: [   13.012909] SCSI =
subsystem initialized
> 2025-05-21T09:18:23.200627+00:00 mc-misc2002 kernel: [   13.017559] ACPI:=
 bus type USB registered
> 2025-05-21T09:18:23.200627+00:00 mc-misc2002 kernel: [   13.020902] i2c i=
2c-0: 16/16 memory slots populated (from DMI)
> 2025-05-21T09:18:23.200627+00:00 mc-misc2002 kernel: [   13.022082] usbco=
re: registered new interface driver usbfs
> 2025-05-21T09:18:23.200628+00:00 mc-misc2002 kernel: [   13.028611] i2c i=
2c-0: Systems with more than 4 memory slots not supported yet, not instanti=
ating SPD
> 2025-05-21T09:18:23.200628+00:00 mc-misc2002 kernel: [   13.034779] usbco=
re: registered new interface driver hub
> 2025-05-21T09:18:23.200628+00:00 mc-misc2002 kernel: [   13.051128] usbco=
re: registered new device driver usb
> 2025-05-21T09:18:23.200631+00:00 mc-misc2002 kernel: [   13.057387] ACPI =
Warning: \_SB.PC07.QR1C._PRT: Return Package has no elements (empty) (20220=
331/nsprepkg-94)
> 2025-05-21T09:18:23.200631+00:00 mc-misc2002 kernel: [   13.068635] bnxt_=
en 0000:98:00.0 (unnamed net_device) (uninitialized): Device requests max t=
imeout of 100 seconds, may trigger hung task watchdog
> 2025-05-21T09:18:23.200631+00:00 mc-misc2002 kernel: [   13.091333] igb: =
Intel(R) Gigabit Ethernet Network Driver
> 2025-05-21T09:18:23.200632+00:00 mc-misc2002 kernel: [   13.097397] igb: =
Copyright (c) 2007-2014 Intel Corporation.
> 2025-05-21T09:18:23.200632+00:00 mc-misc2002 kernel: [   13.103359] bnxt_=
en 0000:98:00.0 eth0: Broadcom BCM57414 NetXtreme-E 10Gb/25Gb Ethernet foun=
d at mem 206fffe10000, node addr 90:5a:08:00:b7:aa
> 2025-05-21T09:18:23.200632+00:00 mc-misc2002 kernel: [   13.103720] ACPI =
Warning: \_SB.PC04.BR4D._PRT: Return Package has no elements (empty) (20220=
331/nsprepkg-94)
> 2025-05-21T09:18:23.200635+00:00 mc-misc2002 kernel: [   13.118012] bnxt_=
en 0000:98:00.0: 63.008 Gb/s available PCIe bandwidth (8.0 GT/s PCIe x8 lin=
k)
> 2025-05-21T09:18:23.200635+00:00 mc-misc2002 kernel: [   13.138933] ACPI =
Warning: \_SB.PC07.QR1C._PRT: Return Package has no elements (empty) (20220=
331/nsprepkg-94)
> 2025-05-21T09:18:23.200635+00:00 mc-misc2002 kernel: [   13.150112] bnxt_=
en 0000:98:00.1 (unnamed net_device) (uninitialized): Device requests max t=
imeout of 100 seconds, may trigger hung task watchdog
> 2025-05-21T09:18:23.200636+00:00 mc-misc2002 kernel: [   13.171091] libat=
a version 3.00 loaded.
> 2025-05-21T09:18:23.200636+00:00 mc-misc2002 kernel: [   13.171959] xhci_=
hcd 0000:00:14.0: xHCI Host Controller
> 2025-05-21T09:18:23.200636+00:00 mc-misc2002 kernel: [   13.177843] xhci_=
hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> 2025-05-21T09:18:23.200639+00:00 mc-misc2002 kernel: [   13.186797] bnxt_=
en 0000:98:00.1 eth1: Broadcom BCM57414 NetXtreme-E 10Gb/25Gb Ethernet foun=
d at mem 206fffe00000, node addr 90:5a:08:00:b7:ab
> 2025-05-21T09:18:23.200639+00:00 mc-misc2002 kernel: [   13.189399] xhci_=
hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00000000=
00009810
> 2025-05-21T09:18:23.200639+00:00 mc-misc2002 kernel: [   13.201155] bnxt_=
en 0000:98:00.1: 63.008 Gb/s available PCIe bandwidth (8.0 GT/s PCIe x8 lin=
k)
> 2025-05-21T09:18:23.200640+00:00 mc-misc2002 kernel: [   13.211971] igb 0=
000:4b:00.0: added PHC on eth2
> 2025-05-21T09:18:23.200640+00:00 mc-misc2002 kernel: [   13.226175] igb 0=
000:4b:00.0: Intel(R) Gigabit Ethernet Network Connection
> 2025-05-21T09:18:23.200640+00:00 mc-misc2002 kernel: [   13.233897] igb 0=
000:4b:00.0: eth2: (PCIe:5.0Gb/s:Width x4) 90:5a:08:10:40:a8
> 2025-05-21T09:18:23.200643+00:00 mc-misc2002 kernel: [   13.241989] igb 0=
000:4b:00.0: eth2: PBA No: 010300-000
> 2025-05-21T09:18:23.200643+00:00 mc-misc2002 kernel: [   13.247760] igb 0=
000:4b:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> 2025-05-21T09:18:23.200643+00:00 mc-misc2002 kernel: [   13.256574] xhci_=
hcd 0000:00:14.0: xHCI Host Controller
> 2025-05-21T09:18:23.200644+00:00 mc-misc2002 kernel: [   13.262451] xhci_=
hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> 2025-05-21T09:18:23.200644+00:00 mc-misc2002 kernel: [   13.270759] xhci_=
hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> 2025-05-21T09:18:23.200644+00:00 mc-misc2002 kernel: [   13.277831] usb u=
sb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002, bcdDevice=3D =
6.01
> 2025-05-21T09:18:23.200647+00:00 mc-misc2002 kernel: [   13.287112] usb u=
sb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> 2025-05-21T09:18:23.200647+00:00 mc-misc2002 kernel: [   13.295224] usb u=
sb1: Product: xHCI Host Controller
> 2025-05-21T09:18:23.200647+00:00 mc-misc2002 kernel: [   13.300703] usb u=
sb1: Manufacturer: Linux 6.1.0-36-amd64 xhci-hcd
> 2025-05-21T09:18:23.200648+00:00 mc-misc2002 kernel: [   13.307547] usb u=
sb1: SerialNumber: 0000:00:14.0
> 2025-05-21T09:18:23.200648+00:00 mc-misc2002 kernel: [   13.312796] ahci =
0000:00:11.5: version 3.0
> 2025-05-21T09:18:23.200648+00:00 mc-misc2002 kernel: [   13.313014] ahci =
0000:00:11.5: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
> 2025-05-21T09:18:23.200648+00:00 mc-misc2002 kernel: [   13.322201] ahci =
0000:00:11.5: flags: 64bit ncq sntf led clo only pio slum part ems deso sad=
m sds apst=20
> 2025-05-21T09:18:23.200651+00:00 mc-misc2002 kernel: [   13.332843] hub 1=
-0:1.0: USB hub found
> 2025-05-21T09:18:23.200651+00:00 mc-misc2002 kernel: [   13.337071] hub 1=
-0:1.0: 16 ports detected
> 2025-05-21T09:18:23.200652+00:00 mc-misc2002 kernel: [   13.343255] usb u=
sb2: New USB device found, idVendor=3D1d6b, idProduct=3D0003, bcdDevice=3D =
6.01
> 2025-05-21T09:18:23.200652+00:00 mc-misc2002 kernel: [   13.352539] usb u=
sb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> 2025-05-21T09:18:23.200652+00:00 mc-misc2002 kernel: [   13.360654] usb u=
sb2: Product: xHCI Host Controller
> 2025-05-21T09:18:23.200653+00:00 mc-misc2002 kernel: [   13.366133] usb u=
sb2: Manufacturer: Linux 6.1.0-36-amd64 xhci-hcd
> 2025-05-21T09:18:23.200658+00:00 mc-misc2002 kernel: [   13.372972] usb u=
sb2: SerialNumber: 0000:00:14.0
> 2025-05-21T09:18:23.200658+00:00 mc-misc2002 kernel: [   13.378289] ACPI =
Warning: \_SB.PC04.BR4D._PRT: Return Package has no elements (empty) (20220=
331/nsprepkg-94)
> 2025-05-21T09:18:23.200658+00:00 mc-misc2002 kernel: [   13.389798] hub 2=
-0:1.0: USB hub found
> 2025-05-21T09:18:23.200659+00:00 mc-misc2002 kernel: [   13.394030] hub 2=
-0:1.0: 10 ports detected
> 2025-05-21T09:18:23.200659+00:00 mc-misc2002 kernel: [   13.396804] bnxt_=
en 0000:98:00.0 enp152s0f0np0: renamed from eth0
> 2025-05-21T09:18:23.200659+00:00 mc-misc2002 kernel: [   13.399725] nvme =
nvme0: pci function 0000:65:00.0
> 2025-05-21T09:18:23.200665+00:00 mc-misc2002 kernel: [   13.417032] nvme =
nvme0: 48/0/0 default/read/poll queues
> 2025-05-21T09:18:23.200666+00:00 mc-misc2002 kernel: [   13.441113] scsi =
host0: ahci
> 2025-05-21T09:18:23.200666+00:00 mc-misc2002 kernel: [   13.444593] scsi =
host1: ahci
> 2025-05-21T09:18:23.200666+00:00 mc-misc2002 kernel: [   13.448059] scsi =
host2: ahci
> 2025-05-21T09:18:23.200666+00:00 mc-misc2002 kernel: [   13.453559] scsi =
host3: ahci
> 2025-05-21T09:18:23.200667+00:00 mc-misc2002 kernel: [   13.457018] scsi =
host4: ahci
> 2025-05-21T09:18:23.200675+00:00 mc-misc2002 kernel: [   13.460393] scsi =
host5: ahci
> 2025-05-21T09:18:23.200675+00:00 mc-misc2002 kernel: [   13.463672] ata1:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180100 irq 179
> 2025-05-21T09:18:23.200676+00:00 mc-misc2002 kernel: [   13.472271] ata2:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180180 irq 179
> 2025-05-21T09:18:23.200676+00:00 mc-misc2002 kernel: [   13.480871] ata3:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180200 irq 179
> 2025-05-21T09:18:23.200676+00:00 mc-misc2002 kernel: [   13.489466] ata4:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180280 irq 179
> 2025-05-21T09:18:23.200676+00:00 mc-misc2002 kernel: [   13.498061] ata5:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180300 irq 179
> 2025-05-21T09:18:23.200677+00:00 mc-misc2002 kernel: [   13.506657] ata6:=
 SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b180380 irq 179
> 2025-05-21T09:18:23.200680+00:00 mc-misc2002 kernel: [   13.515601] ahci =
0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
> 2025-05-21T09:18:23.200680+00:00 mc-misc2002 kernel: [   13.524805] ahci =
0000:00:17.0: flags: 64bit ncq sntf led clo only pio slum part ems deso sad=
m sds apst=20
> 2025-05-21T09:18:23.200680+00:00 mc-misc2002 kernel: [   13.528760] bnxt_=
en 0000:98:00.1 enp152s0f1np1: renamed from eth1
> 2025-05-21T09:18:23.200680+00:00 mc-misc2002 kernel: [   13.589171] igb 0=
000:4b:00.1: added PHC on eth0
> 2025-05-21T09:18:23.200681+00:00 mc-misc2002 kernel: [   13.594280] igb 0=
000:4b:00.1: Intel(R) Gigabit Ethernet Network Connection
> 2025-05-21T09:18:23.200681+00:00 mc-misc2002 kernel: [   13.602004] igb 0=
000:4b:00.1: eth0: (PCIe:5.0Gb/s:Width x4) 90:5a:08:10:40:a9
> 2025-05-21T09:18:23.200684+00:00 mc-misc2002 kernel: [   13.610096] igb 0=
000:4b:00.1: eth0: PBA No: 010300-000
> 2025-05-21T09:18:23.200684+00:00 mc-misc2002 kernel: [   13.615869] igb 0=
000:4b:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
> 2025-05-21T09:18:23.200685+00:00 mc-misc2002 kernel: [   13.649280] scsi =
host6: ahci
> 2025-05-21T09:18:23.200685+00:00 mc-misc2002 kernel: [   13.652652] scsi =
host7: ahci
> 2025-05-21T09:18:23.200685+00:00 mc-misc2002 kernel: [   13.656046] scsi =
host8: ahci
> 2025-05-21T09:18:23.200686+00:00 mc-misc2002 kernel: [   13.659409] scsi =
host9: ahci
> 2025-05-21T09:18:23.200688+00:00 mc-misc2002 kernel: [   13.662790] scsi =
host10: ahci
> 2025-05-21T09:18:23.200688+00:00 mc-misc2002 kernel: [   13.666370] scsi =
host11: ahci
> 2025-05-21T09:18:23.200689+00:00 mc-misc2002 kernel: [   13.669840] scsi =
host12: ahci
> 2025-05-21T09:18:23.200689+00:00 mc-misc2002 kernel: [   13.673311] scsi =
host13: ahci
> 2025-05-21T09:18:23.200689+00:00 mc-misc2002 kernel: [   13.676680] ata7:=
 SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100100 irq 238
> 2025-05-21T09:18:23.200689+00:00 mc-misc2002 kernel: [   13.685285] ata8:=
 SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100180 irq 238
> 2025-05-21T09:18:23.200690+00:00 mc-misc2002 kernel: [   13.693885] ata9:=
 SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100200 irq 238
> 2025-05-21T09:18:23.200693+00:00 mc-misc2002 kernel: [   13.702483] ata10=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100280 irq 238
> 2025-05-21T09:18:23.200694+00:00 mc-misc2002 kernel: [   13.711190] ata11=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100300 irq 238
> 2025-05-21T09:18:23.200694+00:00 mc-misc2002 kernel: [   13.719885] ata12=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100380 irq 238
> 2025-05-21T09:18:23.200694+00:00 mc-misc2002 kernel: [   13.728580] ata13=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100400 irq 238
> 2025-05-21T09:18:23.200694+00:00 mc-misc2002 kernel: [   13.737275] ata14=
: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b100480 irq 238
> 2025-05-21T09:18:23.200695+00:00 mc-misc2002 kernel: [   13.745992] usb 1=
-1: new high-speed USB device number 2 using xhci_hcd
> 2025-05-21T09:18:23.200697+00:00 mc-misc2002 kernel: [   13.827022] ata3:=
 SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 2025-05-21T09:18:23.200698+00:00 mc-misc2002 kernel: [   13.834006] ata2:=
 SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 2025-05-21T09:18:23.200698+00:00 mc-misc2002 kernel: [   13.840985] ata1:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T09:18:23.200698+00:00 mc-misc2002 kernel: [   13.847080] ata6:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T09:18:23.200698+00:00 mc-misc2002 kernel: [   13.853167] ata5:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T09:18:23.200699+00:00 mc-misc2002 kernel: [   13.859265] ata4:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T09:18:23.200699+00:00 mc-misc2002 kernel: [   13.865372] ata3.=
00: ATA-11: Micron_5400_MTFDDAK1T9TGA,  D4MU002, max UDMA/133
> 2025-05-21T09:18:23.200702+00:00 mc-misc2002 kernel: [   13.873514] ata2.=
00: ATA-11: Micron_5400_MTFDDAK1T9TGA,  D4MU002, max UDMA/133
> 2025-05-21T09:18:23.200703+00:00 mc-misc2002 kernel: [   13.884963] ata3.=
00: 3750748848 sectors, multi 16: LBA48 NCQ (depth 32), AA
> 2025-05-21T09:18:23.200703+00:00 mc-misc2002 kernel: [   13.892810] ata2.=
00: 3750748848 sectors, multi 16: LBA48 NCQ (depth 32), AA
> 2025-05-21T09:18:23.200703+00:00 mc-misc2002 kernel: [   13.900630] ata3.=
00: Features: NCQ-prio
> 2025-05-21T09:18:23.200704+00:00 mc-misc2002 kernel: [   13.904955] ata2.=
00: Features: NCQ-prio
> 2025-05-21T09:18:23.200704+00:00 mc-misc2002 kernel: [   13.909937] usb 1=
-1: New USB device found, idVendor=3D1d6b, idProduct=3D0107, bcdDevice=3D 1=
=2E00
> 2025-05-21T09:18:23.200712+00:00 mc-misc2002 kernel: [   13.914614] ata3.=
00: configured for UDMA/133
> 2025-05-21T09:18:23.200712+00:00 mc-misc2002 kernel: [   13.919138] usb 1=
-1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> 2025-05-21T09:18:23.200712+00:00 mc-misc2002 kernel: [   13.919143] usb 1=
-1: Product: USB Virtual Hub
> 2025-05-21T09:18:23.200713+00:00 mc-misc2002 kernel: [   13.919146] usb 1=
-1: Manufacturer: Aspeed
> 2025-05-21T09:18:23.200713+00:00 mc-misc2002 kernel: [   13.919149] usb 1=
-1: SerialNumber: 00000000
> 2025-05-21T09:18:23.200713+00:00 mc-misc2002 kernel: [   13.920283] hub 1=
-1:1.0: USB hub found
> 2025-05-21T09:18:23.200717+00:00 mc-misc2002 kernel: [   13.923957] ata2.=
00: configured for UDMA/133
> 2025-05-21T09:18:23.200717+00:00 mc-misc2002 kernel: [   13.932164] hub 1=
-1:1.0: 7 ports detected
> 2025-05-21T09:18:23.200718+00:00 mc-misc2002 kernel: [   13.937269] scsi =
1:0:0:0: Direct-Access     ATA      Micron_5400_MTFD U002 PQ: 0 ANSI: 5
> 2025-05-21T09:18:23.200718+00:00 mc-misc2002 kernel: [   13.969571] scsi =
2:0:0:0: Direct-Access     ATA      Micron_5400_MTFD U002 PQ: 0 ANSI: 5
> 2025-05-21T09:18:23.200718+00:00 mc-misc2002 kernel: [   14.058962] ata13=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T09:18:23.200719+00:00 mc-misc2002 kernel: [   14.065152] ata7:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T09:18:23.200719+00:00 mc-misc2002 kernel: [   14.071247] ata10=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T09:18:23.200724+00:00 mc-misc2002 kernel: [   14.077440] ata8:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T09:18:23.200725+00:00 mc-misc2002 kernel: [   14.083535] ata14=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T09:18:23.200725+00:00 mc-misc2002 kernel: [   14.089732] ata12=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T09:18:23.200725+00:00 mc-misc2002 kernel: [   14.095929] ata9:=
 SATA link down (SStatus 0 SControl 300)
> 2025-05-21T09:18:23.200726+00:00 mc-misc2002 kernel: [   14.102028] ata11=
: SATA link down (SStatus 0 SControl 300)
> 2025-05-21T09:18:23.200726+00:00 mc-misc2002 kernel: [   14.117176] ata2.=
00: Enabling discard_zeroes_data
> 2025-05-21T09:18:23.200729+00:00 mc-misc2002 kernel: [   14.122499] sd 1:=
0:0:0: [sda] 3750748848 512-byte logical blocks: (1.92 TB/1.75 TiB)
> 2025-05-21T09:18:23.200729+00:00 mc-misc2002 kernel: [   14.122504] ata3.=
00: Enabling discard_zeroes_data
> 2025-05-21T09:18:23.200729+00:00 mc-misc2002 kernel: [   14.131208] sd 1:=
0:0:0: [sda] 4096-byte physical blocks
> 2025-05-21T09:18:23.200730+00:00 mc-misc2002 kernel: [   14.136507] sd 2:=
0:0:0: [sdb] 3750748848 512-byte logical blocks: (1.92 TB/1.75 TiB)
> 2025-05-21T09:18:23.200730+00:00 mc-misc2002 kernel: [   14.140806] igb 0=
000:4b:00.0 enp75s0f0: renamed from eth2
> 2025-05-21T09:18:23.200730+00:00 mc-misc2002 kernel: [   14.142377] sd 1:=
0:0:0: [sda] Write Protect is off
> 2025-05-21T09:18:23.200731+00:00 mc-misc2002 kernel: [   14.151066] sd 2:=
0:0:0: [sdb] 4096-byte physical blocks
> 2025-05-21T09:18:23.200733+00:00 mc-misc2002 kernel: [   14.157133] sd 1:=
0:0:0: [sda] Mode Sense: 00 3a 00 00
> 2025-05-21T09:18:23.200734+00:00 mc-misc2002 kernel: [   14.162524] sd 2:=
0:0:0: [sdb] Write Protect is off
> 2025-05-21T09:18:23.200734+00:00 mc-misc2002 kernel: [   14.168397] sd 1:=
0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO=
 or FUA
> 2025-05-21T09:18:23.200734+00:00 mc-misc2002 kernel: [   14.173763] sd 2:=
0:0:0: [sdb] Mode Sense: 00 3a 00 00
> 2025-05-21T09:18:23.200734+00:00 mc-misc2002 kernel: [   14.183936] sd 1:=
0:0:0: [sda] Preferred minimum I/O size 4096 bytes
> 2025-05-21T09:18:23.200735+00:00 mc-misc2002 kernel: [   14.184533] ata2.=
00: Enabling discard_zeroes_data
> 2025-05-21T09:18:23.200740+00:00 mc-misc2002 kernel: [   14.196265] sd 2:=
0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO=
 or FUA
> 2025-05-21T09:18:23.200741+00:00 mc-misc2002 kernel: [   14.197704]  sda:=
 sda1 sda2
> 2025-05-21T09:18:23.200741+00:00 mc-misc2002 kernel: [   14.206435] sd 2:=
0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
> 2025-05-21T09:18:23.200741+00:00 mc-misc2002 kernel: [   14.209804] sd 1:=
0:0:0: [sda] Attached SCSI disk
> 2025-05-21T09:18:23.200742+00:00 mc-misc2002 kernel: [   14.216926] ata3.=
00: Enabling discard_zeroes_data
> 2025-05-21T09:18:23.200742+00:00 mc-misc2002 kernel: [   14.228299]  sdb:=
 sdb1 sdb2
> 2025-05-21T09:18:23.200744+00:00 mc-misc2002 kernel: [   14.231543] sd 2:=
0:0:0: [sdb] Attached SCSI disk
> 2025-05-21T09:18:23.200745+00:00 mc-misc2002 kernel: [   14.240745] usb 1=
-1.1: new high-speed USB device number 3 using xhci_hcd
> 2025-05-21T09:18:23.200745+00:00 mc-misc2002 kernel: [   14.244770] igb 0=
000:4b:00.1 enp75s0f1: renamed from eth0
> 2025-05-21T09:18:23.200745+00:00 mc-misc2002 kernel: [   14.264430] md/ra=
id1:md0: active with 2 out of 2 mirrors
> 2025-05-21T09:18:23.200745+00:00 mc-misc2002 kernel: [   14.270927] md0: =
detected capacity change from 0 to 3749898240
> 2025-05-21T09:18:23.200746+00:00 mc-misc2002 kernel: [   14.353815] usb 1=
-1.1: New USB device found, idVendor=3D0557, idProduct=3D9241, bcdDevice=3D=
 5.04
> 2025-05-21T09:18:23.200747+00:00 mc-misc2002 kernel: [   14.363212] usb 1=
-1.1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
> 2025-05-21T09:18:23.200749+00:00 mc-misc2002 kernel: [   14.371427] usb 1=
-1.1: Product: SMCI HID KM
> 2025-05-21T09:18:23.200749+00:00 mc-misc2002 kernel: [   14.376132] usb 1=
-1.1: Manufacturer: Linux 5.4.62 with aspeed_vhub
> 2025-05-21T09:18:23.200749+00:00 mc-misc2002 kernel: [   14.388018] devic=
e-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measur=
ements will not be recorded in the IMA log.
> 2025-05-21T09:18:23.200750+00:00 mc-misc2002 kernel: [   14.401752] devic=
e-mapper: uevent: version 1.0.3
> 2025-05-21T09:18:23.200750+00:00 mc-misc2002 kernel: [   14.407007] devic=
e-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
> 2025-05-21T09:18:23.200750+00:00 mc-misc2002 kernel: [   14.421474] hid: =
raw HID events driver (C) Jiri Kosina
> 2025-05-21T09:18:23.200753+00:00 mc-misc2002 kernel: [   14.435686] usbco=
re: registered new interface driver usbhid
> 2025-05-21T09:18:23.200753+00:00 mc-misc2002 kernel: [   14.441987] usbhi=
d: USB HID core driver
> 2025-05-21T09:18:23.200753+00:00 mc-misc2002 kernel: [   14.448476] input=
: Linux 5.4.62 with aspeed_vhub SMCI HID KM as /devices/pci0000:00/0000:00:=
14.0/usb1/1-1/1-1.1/1-1.1:1.0/0003:0557:9241.0001/input/input0
> 2025-05-21T09:18:23.200754+00:00 mc-misc2002 kernel: [   14.468782] usb 1=
-1.2: new high-speed USB device number 4 using xhci_hcd
> 2025-05-21T09:18:23.200754+00:00 mc-misc2002 kernel: [   14.574300] usb 1=
-1.2: New USB device found, idVendor=3D0b1f, idProduct=3D03ee, bcdDevice=3D=
 5.04
> 2025-05-21T09:18:23.200754+00:00 mc-misc2002 kernel: [   14.583699] usb 1=
-1.2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
> 2025-05-21T09:18:23.200757+00:00 mc-misc2002 kernel: [   14.591904] usb 1=
-1.2: Product: RNDIS/Ethernet Gadget
> 2025-05-21T09:18:23.200757+00:00 mc-misc2002 kernel: [   14.597580] usb 1=
-1.2: Manufacturer: Linux 5.4.62 with aspeed_vhub
> 2025-05-21T09:18:23.200758+00:00 mc-misc2002 kernel: [   14.608950] hid-g=
eneric 0003:0557:9241.0001: input,hidraw0: USB HID v1.00 Keyboard [Linux 5.=
4.62 with aspeed_vhub SMCI HID KM] on usb-0000:00:14.0-1.1/input0
> 2025-05-21T09:18:23.200758+00:00 mc-misc2002 kernel: [   14.624844] input=
: Linux 5.4.62 with aspeed_vhub SMCI HID KM as /devices/pci0000:00/0000:00:=
14.0/usb1/1-1/1-1.1/1-1.1:1.1/0003:0557:9241.0002/input/input1
> 2025-05-21T09:18:23.200758+00:00 mc-misc2002 kernel: [   14.640528] hid-g=
eneric 0003:0557:9241.0002: input,hidraw1: USB HID v1.00 Mouse [Linux 5.4.6=
2 with aspeed_vhub SMCI HID KM] on usb-0000:00:14.0-1.1/input1
> 2025-05-21T09:18:23.200761+00:00 mc-misc2002 kernel: [   14.666474] usbco=
re: registered new interface driver cdc_ether
> 2025-05-21T09:18:23.200761+00:00 mc-misc2002 kernel: [   14.677017] rndis=
_host 1-1.2:2.0 usb0: register 'rndis_host' at usb-0000:00:14.0-1.2, RNDIS =
device, be:3a:f2:b6:05:9f
> 2025-05-21T09:18:23.200761+00:00 mc-misc2002 kernel: [   14.688960] usbco=
re: registered new interface driver rndis_host
> 2025-05-21T09:18:23.200762+00:00 mc-misc2002 kernel: [   14.698106] rndis=
_host 1-1.2:2.0 enxbe3af2b6059f: renamed from usb0
> 2025-05-21T09:18:23.200762+00:00 mc-misc2002 kernel: [   14.840739] raid6=
: avx512x4 gen() 32130 MB/s
> 2025-05-21T09:18:23.200762+00:00 mc-misc2002 kernel: [   14.912737] raid6=
: avx512x2 gen() 34424 MB/s
> 2025-05-21T09:18:23.200763+00:00 mc-misc2002 kernel: [   14.984740] raid6=
: avx512x1 gen() 29871 MB/s
> 2025-05-21T09:18:23.200765+00:00 mc-misc2002 kernel: [   15.056739] raid6=
: avx2x4   gen() 23407 MB/s
> 2025-05-21T09:18:23.200765+00:00 mc-misc2002 kernel: [   15.128739] raid6=
: avx2x2   gen() 22510 MB/s
> 2025-05-21T09:18:23.200765+00:00 mc-misc2002 kernel: [   15.200739] raid6=
: avx2x1   gen() 17053 MB/s
> 2025-05-21T09:18:23.200766+00:00 mc-misc2002 kernel: [   15.205535] raid6=
: using algorithm avx512x2 gen() 34424 MB/s
> 2025-05-21T09:18:23.200766+00:00 mc-misc2002 kernel: [   15.276740] raid6=
: .... xor() 20138 MB/s, rmw enabled
> 2025-05-21T09:18:23.200766+00:00 mc-misc2002 kernel: [   15.282413] raid6=
: using avx512x2 recovery algorithm
> 2025-05-21T09:18:23.200769+00:00 mc-misc2002 kernel: [   15.289242] xor: =
automatically using best checksumming function   avx      =20
> 2025-05-21T09:18:23.200769+00:00 mc-misc2002 kernel: [   15.298072] async=
_tx: api initialized (async)
> 2025-05-21T09:18:23.200769+00:00 mc-misc2002 kernel: [   20.443919] PM: I=
mage not found (code -22)
> 2025-05-21T09:18:23.200770+00:00 mc-misc2002 kernel: [   20.566276] EXT4-=
fs (dm-1): mounted filesystem with ordered data mode. Quota mode: none.
> 2025-05-21T09:18:23.200770+00:00 mc-misc2002 kernel: [   20.617623] Not a=
ctivating Mandatory Access Control as /sbin/tomoyo-init does not exist.
> 2025-05-21T09:18:23.200840+00:00 mc-misc2002 kernel: [   22.141152] ACPI:=
 bus type drm_connector registered
> 2025-05-21T09:18:23.200844+00:00 mc-misc2002 kernel: [   22.141277] fuse:=
 init (API version 7.38)
> 2025-05-21T09:18:23.200844+00:00 mc-misc2002 kernel: [   22.168885] loop:=
 module loaded
> 2025-05-21T09:18:23.200844+00:00 mc-misc2002 kernel: [   22.279136] EXT4-=
fs (dm-1): re-mounted. Quota mode: none.
> 2025-05-21T09:18:23.200845+00:00 mc-misc2002 kernel: [   22.288529] IPMI =
message handler: version 39.2
> 2025-05-21T09:18:23.200845+00:00 mc-misc2002 kernel: [   22.296570] ipmi =
device interface
> 2025-05-21T09:18:23.200845+00:00 mc-misc2002 kernel: [   23.155904] input=
: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> 2025-05-21T09:18:23.200846+00:00 mc-misc2002 kernel: [   23.156049] ACPI:=
 button: Power Button [PWRF]
> 2025-05-21T09:18:23.200849+00:00 mc-misc2002 kernel: [   23.156965] sd 1:=
0:0:0: Attached scsi generic sg0 type 0
> 2025-05-21T09:18:23.200849+00:00 mc-misc2002 kernel: [   23.157000] sd 2:=
0:0:0: Attached scsi generic sg1 type 0
> 2025-05-21T09:18:23.200849+00:00 mc-misc2002 kernel: [   23.158538] BUG: =
unable to handle page fault for address: ff409f1411c83000
> 2025-05-21T09:18:23.200850+00:00 mc-misc2002 kernel: [   23.167679] #PF: =
supervisor write access in kernel mode
> 2025-05-21T09:18:23.200850+00:00 mc-misc2002 kernel: [   23.173554] #PF: =
error_code(0x0003) - permissions violation
> 2025-05-21T09:18:23.200850+00:00 mc-misc2002 kernel: [   23.181359] PGD 2=
267801067 P4D 2267802067 PUD 208002d063 PMD 111c06063 PTE 8000000111c83161
> 2025-05-21T09:18:23.200853+00:00 mc-misc2002 kernel: [   23.190741] Oops:=
 0003 [#1] PREEMPT SMP NOPTI
> 2025-05-21T09:18:23.200853+00:00 mc-misc2002 kernel: [   23.197092] CPU: =
30 PID: 843 Comm: (udev-worker) Not tainted 6.1.0-36-amd64 #1  Debian 6.1.1=
39-1
> 2025-05-21T09:18:23.200853+00:00 mc-misc2002 kernel: [   23.206960] Hardw=
are name: Supermicro SYS-120C-TN10R/X12DDW-A6, BIOS 1.9 01/11/2024
> 2025-05-21T09:18:23.200854+00:00 mc-misc2002 kernel: [   23.215555] RIP: =
0010:clear_page_erms+0x7/0x10
> 2025-05-21T09:18:23.200854+00:00 mc-misc2002 kernel: [   23.229817] Code:=
 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75=
 d9 90 e9 c3 c3 41 00 0f 1f 00 b9 00 10 00 00 31 c0 <f3> aa c3 cc cc cc cc =
66 90 89 c8 48 c1 e9 03 74 18 0f 1f 84 00 00
> 2025-05-21T09:18:23.200854+00:00 mc-misc2002 kernel: [   23.250898] RSP: =
0018:ff5a1475ced77b48 EFLAGS: 00010246
> 2025-05-21T09:18:23.200857+00:00 mc-misc2002 kernel: [   23.256770] RAX: =
0000000000000000 RBX: ff409f33000b78c0 RCX: 0000000000001000
> 2025-05-21T09:18:23.200857+00:00 mc-misc2002 kernel: [   23.256772] RDX: =
ffa371c686f7d248 RSI: ffa371c6844720c8 RDI: ff409f1411c83000
> 2025-05-21T09:18:23.200857+00:00 mc-misc2002 kernel: [   23.256773] RBP: =
0000000000000005 R08: 0000000000000000 R09: ff409f337ffd6e00
> 2025-05-21T09:18:23.200857+00:00 mc-misc2002 kernel: [   23.256775] R10: =
0000000000000000 R11: ffffffffffffffff R12: ffa371c6844720c8
> 2025-05-21T09:18:23.200858+00:00 mc-misc2002 kernel: [   23.256776] R13: =
ff409f33000b78c0 R14: ffa371c6844720c0 R15: ff409f14bf2cf8a0
> 2025-05-21T09:18:23.200858+00:00 mc-misc2002 kernel: [   23.306102] FS:  =
00007f21805cf8c0(0000) GS:ff409f3300080000(0000) knlGS:0000000000000000
> 2025-05-21T09:18:23.200858+00:00 mc-misc2002 kernel: [   23.315188] CS:  =
0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2025-05-21T09:18:23.200861+00:00 mc-misc2002 kernel: [   23.321643] CR2: =
ff409f1411c83000 CR3: 00000001be5b2001 CR4: 0000000000771ee0
> 2025-05-21T09:18:23.200861+00:00 mc-misc2002 kernel: [   23.329655] DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 2025-05-21T09:18:23.200861+00:00 mc-misc2002 kernel: [   23.337669] DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 2025-05-21T09:18:23.200862+00:00 mc-misc2002 kernel: [   23.345683] PKRU:=
 55555554
> 2025-05-21T09:18:23.200862+00:00 mc-misc2002 kernel: [   23.348724] Call =
Trace:
> 2025-05-21T09:18:23.200862+00:00 mc-misc2002 kernel: [   23.351475]  <TAS=
K>
> 2025-05-21T09:18:23.200865+00:00 mc-misc2002 kernel: [   23.353831]  __al=
loc_pages_bulk+0x5bd/0x6b0
> 2025-05-21T09:18:23.200865+00:00 mc-misc2002 kernel: [   23.358537]  __vm=
alloc_node_range+0x264/0x880
> 2025-05-21T09:18:23.200865+00:00 mc-misc2002 kernel: [   23.363433]  ? ke=
rnel_read_file+0x2ba/0x330
> 2025-05-21T09:18:23.200866+00:00 mc-misc2002 kernel: [   23.368127]  __vm=
alloc_node+0x4a/0x60
> 2025-05-21T09:18:23.200866+00:00 mc-misc2002 kernel: [   23.372243]  ? ke=
rnel_read_file+0x2ba/0x330
> 2025-05-21T09:18:23.200866+00:00 mc-misc2002 kernel: [   23.376941]  kern=
el_read_file+0x2ba/0x330
> 2025-05-21T09:18:23.200869+00:00 mc-misc2002 kernel: [   23.381445]  kern=
el_read_file_from_fd+0x56/0xa0
> 2025-05-21T09:18:23.200869+00:00 mc-misc2002 kernel: [   23.386535]  __do=
_sys_finit_module+0x86/0x120
> 2025-05-21T09:18:23.200869+00:00 mc-misc2002 kernel: [   23.391435]  do_s=
yscall_64+0x55/0xb0
> 2025-05-21T09:18:23.200869+00:00 mc-misc2002 kernel: [   23.395462]  ? ex=
it_to_user_mode_prepare+0x40/0x1e0
> 2025-05-21T09:18:23.200870+00:00 mc-misc2002 kernel: [   23.400942]  ? sy=
scall_exit_to_user_mode+0x1e/0x40
> 2025-05-21T09:18:23.200870+00:00 mc-misc2002 kernel: [   23.406325]  ? do=
_syscall_64+0x61/0xb0
> 2025-05-21T09:18:23.200870+00:00 mc-misc2002 kernel: [   23.410539]  ? cl=
ear_bhb_loop+0x30/0x80
> 2025-05-21T09:18:23.200873+00:00 mc-misc2002 kernel: [   23.414856]  ? cl=
ear_bhb_loop+0x30/0x80
> 2025-05-21T09:18:23.200873+00:00 mc-misc2002 kernel: [   23.419164]  ? cl=
ear_bhb_loop+0x30/0x80
> 2025-05-21T09:18:23.200873+00:00 mc-misc2002 kernel: [   23.423476]  ? cl=
ear_bhb_loop+0x30/0x80
> 2025-05-21T09:18:23.200874+00:00 mc-misc2002 kernel: [   23.427784]  ? cl=
ear_bhb_loop+0x30/0x80
> 2025-05-21T09:18:23.200874+00:00 mc-misc2002 kernel: [   23.432095]  entr=
y_SYSCALL_64_after_hwframe+0x6e/0xd8
> 2025-05-21T09:18:23.200874+00:00 mc-misc2002 kernel: [   23.437769] RIP: =
0033:0x7f218085a7d9
> 2025-05-21T09:18:23.200877+00:00 mc-misc2002 kernel: [   23.441787] Code:=
 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89=
 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 =
01 c3 48 8b 0d f7 05 0d 00 f7 d8 64 89 01 48
> 2025-05-21T09:18:23.200877+00:00 mc-misc2002 kernel: [   23.462869] RSP: =
002b:00007ffce77a5858 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> 2025-05-21T09:18:23.200877+00:00 mc-misc2002 kernel: [   23.471371] RAX: =
ffffffffffffffda RBX: 000055b4f54faf70 RCX: 00007f218085a7d9
> 2025-05-21T09:18:23.200878+00:00 mc-misc2002 kernel: [   23.479383] RDX: =
0000000000000000 RSI: 00007f21809edefd RDI: 0000000000000006
> 2025-05-21T09:18:23.200878+00:00 mc-misc2002 kernel: [   23.487397] RBP: =
00007f21809edefd R08: 0000000000000000 R09: 0000000000000000
> 2025-05-21T09:18:23.200878+00:00 mc-misc2002 kernel: [   23.495411] R10: =
0000000000000006 R11: 0000000000000246 R12: 0000000000020000
> 2025-05-21T09:18:23.200881+00:00 mc-misc2002 kernel: [   23.503425] R13: =
0000000000000000 R14: 000055b4f54ecf10 R15: 00007ffce77a5a90
> 2025-05-21T09:18:23.200881+00:00 mc-misc2002 kernel: [   23.511441]  </TA=
SK>
> 2025-05-21T09:18:23.200881+00:00 mc-misc2002 kernel: [   23.513895] Modul=
es linked in: sg button ipmi_devintf ipmi_msghandler nf_conntrack nf_defrag=
_ipv6 nf_defrag_ipv4 loop fuse efi_pstore drm configfs ip_tables x_tables a=
utofs4 ext4 crc16 mbcache jbd2 raid10 raid456 async_raid6_recov async_memcp=
y async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid0 m=
ultipath linear rndis_host cdc_ether usbnet mii hid_generic usbhid hid dm_m=
od raid1 md_mod sd_mod nvme nvme_core ahci t10_pi libahci xhci_pci crc64_ro=
cksoft crc64 crc_t10dif libata xhci_hcd igb crct10dif_generic bnxt_en usbco=
re scsi_mod crc32_pclmul i2c_algo_bit crct10dif_pclmul crc32c_intel i2c_i80=
1 crct10dif_common dca i2c_smbus usb_common scsi_common
> 2025-05-21T09:18:23.200882+00:00 mc-misc2002 kernel: [   23.579965] CR2: =
ff409f1411c83000
> 2025-05-21T09:18:23.200882+00:00 mc-misc2002 kernel: [   23.583694] ---[ =
end trace 0000000000000000 ]---
> 2025-05-21T09:18:23.200882+00:00 mc-misc2002 kernel: [   24.212129] RIP: =
0010:clear_page_erms+0x7/0x10
> 2025-05-21T09:18:23.200885+00:00 mc-misc2002 kernel: [   24.217120] Code:=
 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75=
 d9 90 e9 c3 c3 41 00 0f 1f 00 b9 00 10 00 00 31 c0 <f3> aa c3 cc cc cc cc =
66 90 89 c8 48 c1 e9 03 74 18 0f 1f 84 00 00
> 2025-05-21T09:18:23.200885+00:00 mc-misc2002 kernel: [   24.238199] RSP: =
0018:ff5a1475ced77b48 EFLAGS: 00010246
> 2025-05-21T09:18:23.200885+00:00 mc-misc2002 kernel: [   24.244067] RAX: =
0000000000000000 RBX: ff409f33000b78c0 RCX: 0000000000001000
> 2025-05-21T09:18:23.200886+00:00 mc-misc2002 kernel: [   24.252079] RDX: =
ffa371c686f7d248 RSI: ffa371c6844720c8 RDI: ff409f1411c83000
> 2025-05-21T09:18:23.200886+00:00 mc-misc2002 kernel: [   24.260091] RBP: =
0000000000000005 R08: 0000000000000000 R09: ff409f337ffd6e00
> 2025-05-21T09:18:23.200886+00:00 mc-misc2002 kernel: [   24.268105] R10: =
0000000000000000 R11: ffffffffffffffff R12: ffa371c6844720c8
> 2025-05-21T09:18:23.200889+00:00 mc-misc2002 kernel: [   24.276117] R13: =
ff409f33000b78c0 R14: ffa371c6844720c0 R15: ff409f14bf2cf8a0
> 2025-05-21T09:18:23.200889+00:00 mc-misc2002 kernel: [   24.284131] FS:  =
00007f21805cf8c0(0000) GS:ff409f3300080000(0000) knlGS:0000000000000000
> 2025-05-21T09:18:23.200889+00:00 mc-misc2002 kernel: [   24.293218] CS:  =
0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2025-05-21T09:18:23.200890+00:00 mc-misc2002 kernel: [   24.299671] CR2: =
ff409f1411c83000 CR3: 00000001be5b2001 CR4: 0000000000771ee0
> 2025-05-21T09:18:23.200890+00:00 mc-misc2002 kernel: [   24.307684] DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 2025-05-21T09:18:23.200890+00:00 mc-misc2002 kernel: [   24.315696] DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 2025-05-21T09:18:23.200892+00:00 mc-misc2002 kernel: [   24.323709] PKRU:=
 55555554
> 2025-05-21T09:18:23.200893+00:00 mc-misc2002 kernel: [   24.326749] note:=
 (udev-worker)[843] exited with irqs disabled
> 2025-05-21T09:18:23.200893+00:00 mc-misc2002 kernel: [   24.333316] note:=
 (udev-worker)[843] exited with preempt_count 2
> 2025-05-21T09:18:23.200893+00:00 mc-misc2002 kernel: [   24.343143] ioatd=
ma: Intel(R) QuickData Technology Driver 5.00
> 2025-05-21T09:18:23.200894+00:00 mc-misc2002 kernel: [   24.351747] ipmi_=
si: IPMI System Interface driver
> 2025-05-21T09:18:23.200894+00:00 mc-misc2002 kernel: [   24.357060] ipmi_=
si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> 2025-05-21T09:18:23.200896+00:00 mc-misc2002 kernel: [   24.364199] ipmi_=
platform: ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
> 2025-05-21T09:18:23.200897+00:00 mc-misc2002 kernel: [   24.372326] ipmi_=
si: Adding SMBIOS-specified kcs state machine
> 2025-05-21T09:18:23.200897+00:00 mc-misc2002 kernel: [   24.372466] RAPL =
PMU: API unit is 2^-32 Joules, 2 fixed counters, 655360 ms ovfl timer
> 2025-05-21T09:18:23.200897+00:00 mc-misc2002 kernel: [   24.378946] ipmi_=
si IPI0001:00: ipmi_platform: probing via ACPI
> 2025-05-21T09:18:23.200898+00:00 mc-misc2002 kernel: [   24.387780] RAPL =
PMU: hw unit of domain package 2^-14 Joules
> 2025-05-21T09:18:23.200898+00:00 mc-misc2002 kernel: [   24.387782] RAPL =
PMU: hw unit of domain dram 2^-16 Joules
> 2025-05-21T09:18:23.200898+00:00 mc-misc2002 kernel: [   24.394557] ipmi_=
si IPI0001:00: ipmi_platform: [io  0x0ca2] regsize 1 spacing 1 irq 0
> 2025-05-21T09:18:23.200900+00:00 mc-misc2002 kernel: [   24.418975] input=
: PC Speaker as /devices/platform/pcspkr/input/input3
> 2025-05-21T09:18:23.200901+00:00 mc-misc2002 kernel: [   24.426897] crypt=
d: max_cpu_qlen set to 1000
> 2025-05-21T09:18:23.200901+00:00 mc-misc2002 kernel: [   24.432534] iTCO_=
vendor_support: vendor-support=3D0
> 2025-05-21T09:18:23.200901+00:00 mc-misc2002 kernel: [   24.441586] Addin=
g 999420k swap on /dev/mapper/vg0-swap.  Priority:-2 extents:1 across:99942=
0k SSFS
> 2025-05-21T09:18:23.200902+00:00 mc-misc2002 kernel: [   24.453241] mei_m=
e 0000:00:16.0: Device doesn't have valid ME Interface
> 2025-05-21T09:18:23.200902+00:00 mc-misc2002 kernel: [   24.469642] AVX2 =
version of gcm_enc/dec engaged.
> 2025-05-21T09:18:23.200904+00:00 mc-misc2002 kernel: [   24.476011] AES C=
TR mode by8 optimization enabled
> 2025-05-21T09:18:23.200905+00:00 mc-misc2002 kernel: [   24.476215] ipmi_=
si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of A=
CPI
> 2025-05-21T09:18:23.200905+00:00 mc-misc2002 kernel: [   24.494013] ipmi_=
si: Adding ACPI-specified kcs state machine
> 2025-05-21T09:18:23.200905+00:00 mc-misc2002 kernel: [   24.494143] ipmi_=
si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave add=
ress 0x20, irq 0
> 2025-05-21T09:18:23.200906+00:00 mc-misc2002 kernel: [   24.561781] BUG: =
unable to handle page fault for address: ff409f14bef9e000
> 2025-05-21T09:18:23.200906+00:00 mc-misc2002 kernel: [   24.569503] #PF: =
supervisor write access in kernel mode
> 2025-05-21T09:18:23.200909+00:00 mc-misc2002 kernel: [   24.569505] #PF: =
error_code(0x0003) - permissions violation
> 2025-05-21T09:18:23.200909+00:00 mc-misc2002 kernel: [   24.569507] PGD 2=
267801067=20
> 2025-05-21T09:18:23.200910+00:00 mc-misc2002 kernel: [   24.580800] iTCO_=
wdt iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/B=
IOS
> 2025-05-21T09:18:23.200910+00:00 mc-misc2002 kernel: [   24.581616] P4D 2=
267802067 PUD 11148b063 PMD 10871b063 PTE 80000001bef9e161
> 2025-05-21T09:18:23.200910+00:00 mc-misc2002 kernel: [   24.603883] Oops:=
 0003 [#2] PREEMPT SMP NOPTI
> 2025-05-21T09:18:23.200910+00:00 mc-misc2002 kernel: [   24.608779] CPU: =
3 PID: 840 Comm: (udev-worker) Tainted: G      D            6.1.0-36-amd64 =
#1  Debian 6.1.139-1
> 2025-05-21T09:18:23.200913+00:00 mc-misc2002 kernel: [   24.620302] Hardw=
are name: Supermicro SYS-120C-TN10R/X12DDW-A6, BIOS 1.9 01/11/2024
> 2025-05-21T09:18:23.200913+00:00 mc-misc2002 kernel: [   24.628900] RIP: =
0010:clear_page_erms+0x7/0x10
> 2025-05-21T09:18:23.200914+00:00 mc-misc2002 kernel: [   24.638577] Code:=
 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75=
 d9 90 e9 c3 c3 41 00 0f 1f 00 b9 00 10 00 00 31 c0 <f3> aa c3 cc cc cc cc =
66 90 89 c8 48 c1 e9 03 74 18 0f 1f 84 00 00
> 2025-05-21T09:18:23.200914+00:00 mc-misc2002 kernel: [   24.659652] RSP: =
0018:ff5a1475ced67910 EFLAGS: 00010246
> 2025-05-21T09:18:23.200914+00:00 mc-misc2002 kernel: [   24.665508] RAX: =
0000000000000000 RBX: ff409f32ffcf78c0 RCX: 0000000000001000
> 2025-05-21T09:18:23.200914+00:00 mc-misc2002 kernel: [   24.665510] RDX: =
ffa371c686ec0288 RSI: ffa371c686fbe788 RDI: ff409f14bef9e000
> 2025-05-21T09:18:23.200917+00:00 mc-misc2002 kernel: [   24.665511] RBP: =
0000000000000004 R08: 0000000000000000 R09: ff409f337ffd6e00
> 2025-05-21T09:18:23.200917+00:00 mc-misc2002 kernel: [   24.665511] R10: =
0000000000000000 R11: fffffffffffff000 R12: ffa371c686fbe788
> 2025-05-21T09:18:23.200917+00:00 mc-misc2002 kernel: [   24.665512] R13: =
ff409f32ffcf78c0 R14: ffa371c686fbe780 R15: ff409f14bb00f1d8
> 2025-05-21T09:18:23.200918+00:00 mc-misc2002 kernel: [   24.665513] FS:  =
00007f21805cf8c0(0000) GS:ff409f32ffcc0000(0000) knlGS:0000000000000000
> 2025-05-21T09:18:23.200920+00:00 mc-misc2002 kernel: [   24.681269] EXT4-=
fs (dm-2): mounted filesystem with ordered data mode. Quota mode: none.
> 2025-05-21T09:18:23.200920+00:00 mc-misc2002 kernel: [   24.681530] CS:  =
0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2025-05-21T09:18:23.200921+00:00 mc-misc2002 kernel: [   24.681531] CR2: =
ff409f14bef9e000 CR3: 00000001be5ac004 CR4: 0000000000771ee0
> 2025-05-21T09:18:23.200923+00:00 mc-misc2002 kernel: [   24.738278] DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 2025-05-21T09:18:23.200923+00:00 mc-misc2002 kernel: [   24.746288] DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 2025-05-21T09:18:23.200924+00:00 mc-misc2002 kernel: [   24.754287] PKRU:=
 55555554
> 2025-05-21T09:18:23.200924+00:00 mc-misc2002 kernel: [   24.757321] Call =
Trace:
> 2025-05-21T09:18:23.200924+00:00 mc-misc2002 kernel: [   24.760066]  <TAS=
K>
> 2025-05-21T09:18:23.200925+00:00 mc-misc2002 kernel: [   24.762418]  __al=
loc_pages_bulk+0x5bd/0x6b0
> 2025-05-21T09:18:23.200927+00:00 mc-misc2002 kernel: [   24.767117]  __vm=
alloc_node_range+0x264/0x880
> 2025-05-21T09:18:23.200927+00:00 mc-misc2002 kernel: [   24.772009]  ? lo=
ad_module+0xbf1/0x2220
> 2025-05-21T09:18:23.200928+00:00 mc-misc2002 kernel: [   24.776319]  ? lo=
ad_module+0xbf1/0x2220
> 2025-05-21T09:18:23.200928+00:00 mc-misc2002 kernel: [   24.780625]  modu=
le_alloc+0x7e/0xe0
> 2025-05-21T09:18:23.200928+00:00 mc-misc2002 kernel: [   24.784544]  ? lo=
ad_module+0xbf1/0x2220
> 2025-05-21T09:18:23.200928+00:00 mc-misc2002 kernel: [   24.788851]  load=
_module+0xbf1/0x2220
> 2025-05-21T09:18:23.200929+00:00 mc-misc2002 kernel: [   24.792962]  ? im=
a_post_read_file+0xd6/0xf0
> 2025-05-21T09:18:23.200931+00:00 mc-misc2002 kernel: [   24.797661]  ? ke=
rnel_read_file+0x2a8/0x330
> 2025-05-21T09:18:23.200932+00:00 mc-misc2002 kernel: [   24.802357]  ? __=
do_sys_finit_module+0xac/0x120
> 2025-05-21T09:18:23.200932+00:00 mc-misc2002 kernel: [   24.807435]  __do=
_sys_finit_module+0xac/0x120
> 2025-05-21T09:18:23.200932+00:00 mc-misc2002 kernel: [   24.812327]  do_s=
yscall_64+0x55/0xb0
> 2025-05-21T09:18:23.200932+00:00 mc-misc2002 kernel: [   24.816343]  ? do=
_syscall_64+0x61/0xb0
> 2025-05-21T09:18:23.200933+00:00 mc-misc2002 kernel: [   24.820540]  ? ks=
ys_read+0x6b/0xf0
> 2025-05-21T09:18:23.200935+00:00 mc-misc2002 kernel: [   24.824361]  ? ex=
it_to_user_mode_prepare+0x40/0x1e0
> 2025-05-21T09:18:23.200935+00:00 mc-misc2002 kernel: [   24.829836]  ? sy=
scall_exit_to_user_mode+0x1e/0x40
> 2025-05-21T09:18:23.200936+00:00 mc-misc2002 kernel: [   24.835205]  ? do=
_syscall_64+0x61/0xb0
> 2025-05-21T09:18:23.200936+00:00 mc-misc2002 kernel: [   24.839407]  ? __=
seccomp_filter+0x32a/0x4e0
> 2025-05-21T09:18:23.200936+00:00 mc-misc2002 kernel: [   24.845662]  ? km=
em_cache_free+0x15/0x310
> 2025-05-21T09:18:23.200936+00:00 mc-misc2002 kernel: [   24.850165]  ? ex=
it_to_user_mode_prepare+0x40/0x1e0
> 2025-05-21T09:18:23.200939+00:00 mc-misc2002 kernel: [   24.855640]  ? sy=
scall_exit_to_user_mode+0x1e/0x40
> 2025-05-21T09:18:23.200939+00:00 mc-misc2002 kernel: [   24.861017]  ? do=
_syscall_64+0x61/0xb0
> 2025-05-21T09:18:23.200939+00:00 mc-misc2002 kernel: [   24.865223]  ? ha=
ndle_mm_fault+0xdb/0x2d0
> 2025-05-21T09:18:23.200940+00:00 mc-misc2002 kernel: [   24.869726]  ? fl=
ush_tlb_one_kernel+0xa/0x20
> 2025-05-21T09:18:23.200940+00:00 mc-misc2002 kernel: [   24.874520]  ? do=
_kernel_range_flush+0x23/0x30
> 2025-05-21T09:18:23.200940+00:00 mc-misc2002 kernel: [   24.879509]  ? __=
flush_smp_call_function_queue+0x117/0x1a0
> 2025-05-21T09:18:23.200941+00:00 mc-misc2002 kernel: [   24.884751] ipmi_=
si IPI0001:00: The BMC does not support clearing the recv irq bit, compensa=
ting, but the BMC needs to be fixed.
> 2025-05-21T09:18:23.200943+00:00 mc-misc2002 kernel: [   24.885670]  ? cl=
ear_bhb_loop+0x30/0x80
> 2025-05-21T09:18:23.200943+00:00 mc-misc2002 kernel: [   24.902952]  ? cl=
ear_bhb_loop+0x30/0x80
> 2025-05-21T09:18:23.200944+00:00 mc-misc2002 kernel: [   24.907257]  ? cl=
ear_bhb_loop+0x30/0x80
> 2025-05-21T09:18:23.200944+00:00 mc-misc2002 kernel: [   24.911563]  ? cl=
ear_bhb_loop+0x30/0x80
> 2025-05-21T09:18:23.200944+00:00 mc-misc2002 kernel: [   24.915869]  ? cl=
ear_bhb_loop+0x30/0x80
> 2025-05-21T09:18:23.200945+00:00 mc-misc2002 kernel: [   24.920174]  entr=
y_SYSCALL_64_after_hwframe+0x6e/0xd8
> 2025-05-21T09:18:23.200947+00:00 mc-misc2002 kernel: [   24.925844] RIP: =
0033:0x7f218085a7d9
> 2025-05-21T09:18:23.200947+00:00 mc-misc2002 kernel: [   24.929856] Code:=
 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89=
 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 =
01 c3 48 8b 0d f7 05 0d 00 f7 d8 64 89 01 48
> 2025-05-21T09:18:23.200948+00:00 mc-misc2002 kernel: [   24.950929] RSP: =
002b:00007ffce77a5858 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> 2025-05-21T09:18:23.200948+00:00 mc-misc2002 kernel: [   24.959428] RAX: =
ffffffffffffffda RBX: 000055b4f54fb1b0 RCX: 00007f218085a7d9
> 2025-05-21T09:18:23.200948+00:00 mc-misc2002 kernel: [   24.967429] RDX: =
0000000000000000 RSI: 00007f21809edefd RDI: 000000000000000d
> 2025-05-21T09:18:23.200949+00:00 mc-misc2002 kernel: [   24.975437] RBP: =
00007f21809edefd R08: 0000000000000000 R09: 0000000000000000
> 2025-05-21T09:18:23.200951+00:00 mc-misc2002 kernel: [   24.983446] R10: =
000000000000000d R11: 0000000000000246 R12: 0000000000020000
> 2025-05-21T09:18:23.200952+00:00 mc-misc2002 kernel: [   24.991457] R13: =
0000000000000000 R14: 000055b4f54fbd70 R15: 00007ffce77a5a90
> 2025-05-21T09:18:23.200952+00:00 mc-misc2002 kernel: [   24.999458]  </TA=
SK>
> 2025-05-21T09:18:23.200952+00:00 mc-misc2002 kernel: [   25.001900] Modul=
es linked in: drm_ttm_helper iTCO_wdt aesni_intel intel_th_gth ttm intel_pm=
c_bxt crypto_simd iTCO_vendor_support acpi_ipmi mei_me cryptd intel_th_pci =
isst_if_mbox_pci isst_if_mmio pcc_cpufreq(-) rapl pcspkr drm_kms_helper mei=
 watchdog isst_if_common ioatdma intel_pch_thermal intel_th intel_vsec ipmi=
_si(+) acpi_pad evdev joydev sg button ipmi_devintf ipmi_msghandler nf_conn=
track nf_defrag_ipv6 nf_defrag_ipv4 loop fuse efi_pstore drm configfs ip_ta=
bles x_tables autofs4 ext4 crc16 mbcache jbd2 raid10 raid456 async_raid6_re=
cov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_=
generic raid0 multipath linear rndis_host cdc_ether usbnet mii hid_generic =
usbhid hid dm_mod raid1 md_mod sd_mod nvme nvme_core ahci t10_pi libahci xh=
ci_pci crc64_rocksoft crc64 crc_t10dif libata xhci_hcd igb crct10dif_generi=
c bnxt_en usbcore scsi_mod crc32_pclmul i2c_algo_bit crct10dif_pclmul crc32=
c_intel i2c_i801 crct10dif_common dca i2c_smbus usb_common scsi_common
> 2025-05-21T09:18:23.200953+00:00 mc-misc2002 kernel: [   25.006224] ipmi_=
si IPI0001:00: IPMI message handler: Found new BMC (man_id: 0x002a7c, prod_=
id: 0x1b58, dev_id: 0x20)
> 2025-05-21T09:18:23.200955+00:00 mc-misc2002 kernel: [   25.098694] CR2: =
ff409f14bef9e000
> 2025-05-21T09:18:23.200955+00:00 mc-misc2002 kernel: [   25.098696] ---[ =
end trace 0000000000000000 ]---
> 2025-05-21T09:18:23.200956+00:00 mc-misc2002 kernel: [   25.157064] RIP: =
0010:clear_page_erms+0x7/0x10
> 2025-05-21T09:18:23.200956+00:00 mc-misc2002 kernel: [   25.179729] Code:=
 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75=
 d9 90 e9 c3 c3 41 00 0f 1f 00 b9 00 10 00 00 31 c0 <f3> aa c3 cc cc cc cc =
66 90 89 c8 48 c1 e9 03 74 18 0f 1f 84 00 00
> 2025-05-21T09:18:23.200956+00:00 mc-misc2002 kernel: [   25.200804] RSP: =
0018:ff5a1475ced77b48 EFLAGS: 00010246
> 2025-05-21T09:18:23.200957+00:00 mc-misc2002 kernel: [   25.206661] RAX: =
0000000000000000 RBX: ff409f33000b78c0 RCX: 0000000000001000
> 2025-05-21T09:18:23.200959+00:00 mc-misc2002 kernel: [   25.214671] RDX: =
ffa371c686f7d248 RSI: ffa371c6844720c8 RDI: ff409f1411c83000
> 2025-05-21T09:18:23.200960+00:00 mc-misc2002 kernel: [   25.215433] ipmi_=
si IPI0001:00: IPMI kcs interface initialized
> 2025-05-21T09:18:23.200960+00:00 mc-misc2002 kernel: [   25.222679] RBP: =
0000000000000005 R08: 0000000000000000 R09: ff409f337ffd6e00
> 2025-05-21T09:18:23.200960+00:00 mc-misc2002 kernel: [   25.222680] R10: =
0000000000000000 R11: ffffffffffffffff R12: ffa371c6844720c8
> 2025-05-21T09:18:23.200960+00:00 mc-misc2002 kernel: [   25.222681] R13: =
ff409f33000b78c0 R14: ffa371c6844720c0 R15: ff409f14bf2cf8a0
> 2025-05-21T09:18:23.200961+00:00 mc-misc2002 kernel: [   25.222682] FS:  =
00007f21805cf8c0(0000) GS:ff409f32ffcc0000(0000) knlGS:0000000000000000
> 2025-05-21T09:18:23.200963+00:00 mc-misc2002 kernel: [   25.262337] CS:  =
0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2025-05-21T09:18:23.200963+00:00 mc-misc2002 kernel: [   25.268788] CR2: =
ff409f14bef9e000 CR3: 00000001be5ac004 CR4: 0000000000771ee0
> 2025-05-21T09:18:23.200964+00:00 mc-misc2002 kernel: [   25.276788] DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 2025-05-21T09:18:23.200964+00:00 mc-misc2002 kernel: [   25.284798] DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 2025-05-21T09:18:23.200964+00:00 mc-misc2002 kernel: [   25.292798] PKRU:=
 55555554
> 2025-05-21T09:18:23.200965+00:00 mc-misc2002 kernel: [   25.295836] note:=
 (udev-worker)[840] exited with irqs disabled
> 2025-05-21T09:18:23.200965+00:00 mc-misc2002 kernel: [   25.302397] note:=
 (udev-worker)[840] exited with preempt_count 2
> 2025-05-21T09:18:23.200968+00:00 mc-misc2002 kernel: [   25.347588] ipmi_=
ssif: IPMI SSIF Interface driver
> 2025-05-21T09:18:23.200968+00:00 mc-misc2002 kernel: [   25.354838] ast 0=
000:04:00.0: [drm] P2A bridge disabled, using default configuration
> 2025-05-21T09:18:23.200969+00:00 mc-misc2002 kernel: [   25.363543] ast 0=
000:04:00.0: [drm] AST 2600 detected
> 2025-05-21T09:18:23.200969+00:00 mc-misc2002 kernel: [   25.404755] EDAC =
i10nm: No hbm memory
> 2025-05-21T09:18:23.200969+00:00 mc-misc2002 kernel: [   25.408930] EDAC =
MC0: Giving out device to module i10nm_edac controller Intel_10nm Socket#0 =
IMC#0: DEV 0000:7e:0c.0 (INTERRUPT)
> 2025-05-21T09:18:23.200970+00:00 mc-misc2002 kernel: [   25.421846] EDAC =
MC1: Giving out device to module i10nm_edac controller Intel_10nm Socket#0 =
IMC#1: DEV 0000:7e:0d.0 (INTERRUPT)
> 2025-05-21T09:18:23.200972+00:00 mc-misc2002 kernel: [   25.434789] EDAC =
MC2: Giving out device to module i10nm_edac controller Intel_10nm Socket#0 =
IMC#2: DEV 0000:7e:0e.0 (INTERRUPT)
> 2025-05-21T09:18:23.200972+00:00 mc-misc2002 kernel: [   25.446592] bnxt_=
en 0000:98:00.0 enp152s0f0np0: NIC Link is Up, 10000 Mbps (NRZ) full duplex=
, Flow control: none
> 2025-05-21T09:18:23.200973+00:00 mc-misc2002 kernel: [   25.449268] EDAC =
MC3: Giving out device to module i10nm_edac controller Intel_10nm Socket#0 =
IMC#3: DEV 0000:7e:0f.0 (INTERRUPT)
> 2025-05-21T09:18:23.200973+00:00 mc-misc2002 kernel: [   25.460655] bnxt_=
en 0000:98:00.0 enp152s0f0np0: FEC autoneg off encoding: None
> 2025-05-21T09:18:23.200973+00:00 mc-misc2002 kernel: [   25.476745] ast 0=
000:04:00.0: [drm] Using analog VGA
> 2025-05-21T09:18:23.200976+00:00 mc-misc2002 kernel: [   25.483242] EDAC =
MC4: Giving out device to module i10nm_edac controller Intel_10nm Socket#1 =
IMC#0: DEV 0000:fe:0c.0 (INTERRUPT)
> 2025-05-21T09:18:23.200976+00:00 mc-misc2002 kernel: [   25.488789] ast 0=
000:04:00.0: [drm] dram MCLK=3D396 Mhz type=3D1 bus_width=3D16
> 2025-05-21T09:18:23.200976+00:00 mc-misc2002 kernel: [   25.503261] EDAC =
MC5: Giving out device to module i10nm_edac controller Intel_10nm Socket#1 =
IMC#1: DEV 0000:fe:0d.0 (INTERRUPT)
> 2025-05-21T09:18:23.200977+00:00 mc-misc2002 kernel: [   25.511134] [drm]=
 Initialized ast 0.1.0 20120228 for 0000:04:00.0 on minor 0
> 2025-05-21T09:18:23.200977+00:00 mc-misc2002 kernel: [   25.525343] EDAC =
MC6: Giving out device to module i10nm_edac controller Intel_10nm Socket#1 =
IMC#2: DEV 0000:fe:0e.0 (INTERRUPT)
> 2025-05-21T09:18:23.200977+00:00 mc-misc2002 kernel: [   25.547668] fbcon=
: astdrmfb (fb0) is primary device
> 2025-05-21T09:18:23.200980+00:00 mc-misc2002 kernel: [   25.547715] EDAC =
MC7: Giving out device to module i10nm_edac controller Intel_10nm Socket#1 =
IMC#3: DEV 0000:fe:0f.0 (INTERRUPT)
> 2025-05-21T09:18:23.200980+00:00 mc-misc2002 kernel: [   25.547720] EDAC =
i10nm: v0.0.5
> 2025-05-21T09:18:23.200980+00:00 mc-misc2002 kernel: [   25.558860] Conso=
le: switching to colour frame buffer device 128x48
> 2025-05-21T09:18:23.200981+00:00 mc-misc2002 kernel: [   25.565018] intel=
_rapl_common: Found RAPL domain package
> 2025-05-21T09:18:23.200981+00:00 mc-misc2002 kernel: [   25.565024] intel=
_rapl_common: Found RAPL domain dram
> 2025-05-21T09:18:23.200981+00:00 mc-misc2002 kernel: [   25.565027] intel=
_rapl_common: DRAM domain energy unit 15300pj
> 2025-05-21T09:18:23.200984+00:00 mc-misc2002 kernel: [   25.565230] intel=
_rapl_common: Found RAPL domain package
> 2025-05-21T09:18:23.200984+00:00 mc-misc2002 kernel: [   25.577992] ast 0=
000:04:00.0: [drm] fb0: astdrmfb frame buffer device
> 2025-05-21T09:18:23.200984+00:00 mc-misc2002 kernel: [   25.581425] intel=
_rapl_common: Found RAPL domain dram
> 2025-05-21T09:18:23.200985+00:00 mc-misc2002 kernel: [   25.581428] intel=
_rapl_common: DRAM domain energy unit 15300pj
> 2025-05-21T09:18:23.200985+00:00 mc-misc2002 kernel: [   26.659674] Proce=
ss accounting resumed
> 2025-05-21T09:18:24.331353+00:00 mc-misc2002 kernel: [   27.522992] BUG: =
unable to handle page fault for address: ff409f140a4dc000
> 2025-05-21T09:18:24.331362+00:00 mc-misc2002 kernel: [   27.531786] #PF: =
supervisor write access in kernel mode
> 2025-05-21T09:18:24.331363+00:00 mc-misc2002 kernel: [   27.537653] #PF: =
error_code(0x0003) - permissions violation
> 2025-05-21T09:18:24.331365+00:00 mc-misc2002 kernel: [   27.543912] PGD 2=
267801067 P4D 2267802067 PUD 208002d063 PMD 11168c063 PTE 800000010a4dc161
> 2025-05-21T09:18:24.331366+00:00 mc-misc2002 kernel: [   27.553294] Oops:=
 0003 [#3] PREEMPT SMP NOPTI
> 2025-05-21T09:18:24.331369+00:00 mc-misc2002 kernel: [   27.558188] CPU: =
27 PID: 1253 Comm: prometheus-debi Tainted: G      D            6.1.0-36-am=
d64 #1  Debian 6.1.139-1
> 2025-05-21T09:18:24.331370+00:00 mc-misc2002 kernel: [   27.570005] Hardw=
are name: Supermicro SYS-120C-TN10R/X12DDW-A6, BIOS 1.9 01/11/2024
> 2025-05-21T09:18:24.331371+00:00 mc-misc2002 kernel: [   27.578604] RIP: =
0010:clear_page_erms+0x7/0x10
> 2025-05-21T09:18:24.331373+00:00 mc-misc2002 kernel: [   27.583600] Code:=
 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75=
 d9 90 e9 c3 c3 41 00 0f 1f 00 b9 00 10 00 00 31 c0 <f3> aa c3 cc cc cc cc =
66 90 89 c8 48 c1 e9 03 74 18 0f 1f 84 00 00
> 2025-05-21T09:18:24.331374+00:00 mc-misc2002 kernel: [   27.604775] RSP: =
0000:ff5a1475ceedfc48 EFLAGS: 00010246
> 2025-05-21T09:18:24.331375+00:00 mc-misc2002 kernel: [   27.610646] RAX: =
0000000000000000 RBX: 0000000000000001 RCX: 0000000000001000
> 2025-05-21T09:18:24.331376+00:00 mc-misc2002 kernel: [   27.618659] RDX: =
ffa371c684293700 RSI: ffa371c684293740 RDI: ff409f140a4dc000
> 2025-05-21T09:18:24.331377+00:00 mc-misc2002 kernel: [   27.626672] RBP: =
ff409f32ffff78c0 R08: 0000000000000000 R09: 0000000001ed0595
> 2025-05-21T09:18:24.331378+00:00 mc-misc2002 kernel: [   27.634685] R10: =
ff5a1475ceedfd48 R11: ff409f32ffff78d8 R12: 0000000000000000
> 2025-05-21T09:18:24.331379+00:00 mc-misc2002 kernel: [   27.642697] R13: =
ff409f337ffd5c00 R14: ff409f337ffd6e00 R15: ffa371c684293700
> 2025-05-21T09:18:24.331380+00:00 mc-misc2002 kernel: [   27.650710] FS:  =
00007fe3036c7740(0000) GS:ff409f32fffc0000(0000) knlGS:0000000000000000
> 2025-05-21T09:18:24.331381+00:00 mc-misc2002 kernel: [   27.659796] CS:  =
0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2025-05-21T09:18:24.331382+00:00 mc-misc2002 kernel: [   27.666249] CR2: =
ff409f140a4dc000 CR3: 0000000211b62001 CR4: 0000000000771ee0
> 2025-05-21T09:18:24.331383+00:00 mc-misc2002 kernel: [   27.674262] DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 2025-05-21T09:18:24.331384+00:00 mc-misc2002 kernel: [   27.682275] DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 2025-05-21T09:18:24.331385+00:00 mc-misc2002 kernel: [   27.690287] PKRU:=
 55555554
> 2025-05-21T09:18:24.331399+00:00 mc-misc2002 kernel: [   27.693328] Call =
Trace:
> 2025-05-21T09:18:24.331400+00:00 mc-misc2002 kernel: [   27.696078]  <TAS=
K>
> 2025-05-21T09:18:24.331401+00:00 mc-misc2002 kernel: [   27.698434]  get_=
page_from_freelist+0xe24/0x11b0
> 2025-05-21T09:18:24.331402+00:00 mc-misc2002 kernel: [   27.703625]  ? __=
alloc_pages+0x1b0/0x330
> 2025-05-21T09:18:24.331403+00:00 mc-misc2002 kernel: [   27.708416]  ? do=
_set_pte+0x189/0x1d0
> 2025-05-21T09:18:24.331404+00:00 mc-misc2002 kernel: [   27.712532]  __al=
loc_pages+0x1dc/0x330
> 2025-05-21T09:18:24.331405+00:00 mc-misc2002 kernel: [   27.716748]  pte_=
alloc_one+0x13/0x40
> 2025-05-21T09:18:24.331406+00:00 mc-misc2002 kernel: [   27.720768]  do_f=
ault+0x3a6/0x410
> 2025-05-21T09:18:24.331407+00:00 mc-misc2002 kernel: [   27.724488]  __ha=
ndle_mm_fault+0x660/0xfa0
> 2025-05-21T09:18:24.331408+00:00 mc-misc2002 kernel: [   27.729090]  hand=
le_mm_fault+0xdb/0x2d0
> 2025-05-21T09:18:24.331409+00:00 mc-misc2002 kernel: [   27.733400]  do_u=
ser_addr_fault+0x191/0x550
> 2025-05-21T09:18:24.331409+00:00 mc-misc2002 kernel: [   27.738096]  exc_=
page_fault+0x70/0x170
> 2025-05-21T09:18:24.331411+00:00 mc-misc2002 kernel: [   27.738099]  asm_=
exc_page_fault+0x22/0x30
> 2025-05-21T09:18:24.331412+00:00 mc-misc2002 kernel: [   27.738104] RIP: =
0033:0x5607a07f8d93
> 2025-05-21T09:18:24.331413+00:00 mc-misc2002 kernel: [   27.738106] Code:=
 1f 84 00 00 00 00 00 41 54 55 53 48 85 ff 74 67 0f b6 2f 48 89 fb 45 31 e4=
 40 84 ed 74 48 e8 14 10 ff ff 48 8b 30 40 0f b6 c5 <f6> 44 46 01 04 75 06 =
40 80 fd 5f 75 2f 0f b6 43 01 48 8d 53 01 84
> 2025-05-21T09:18:24.331414+00:00 mc-misc2002 kernel: [   27.738107] RSP: =
002b:00007ffc1b3926c0 EFLAGS: 00010207
> 2025-05-21T09:18:24.331415+00:00 mc-misc2002 kernel: [   27.738109] RAX: =
0000000000000056 RBX: 00005607c4fc6060 RCX: 00000000000000b1
> 2025-05-21T09:18:24.331415+00:00 mc-misc2002 kernel: [   27.738110] RDX: =
0000000000000000 RSI: 00007fe30321982c RDI: 00005607c4fc6060
> 2025-05-21T09:18:24.331416+00:00 mc-misc2002 kernel: [   27.738111] RBP: =
0000000000000056 R08: 00007ffc1b3928a8 R09: 00007ffc1b3928a0
> 2025-05-21T09:18:24.331417+00:00 mc-misc2002 kernel: [   27.738111] R10: =
0000000000000024 R11: 0000000000000190 R12: 0000000000000000
> 2025-05-21T09:18:24.331418+00:00 mc-misc2002 kernel: [   27.738112] R13: =
00000000000000ab R14: 00007ffc1b3928a8 R15: 00005607c4fc94a0
> 2025-05-21T09:18:24.331419+00:00 mc-misc2002 kernel: [   27.738114]  </TA=
SK>
> 2025-05-21T09:18:24.331419+00:00 mc-misc2002 kernel: [   27.825564] Modul=
es linked in: nfnetlink_log nfnetlink tls nvme_fabrics binfmt_misc intel_ra=
pl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_comm=
on i10nm_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_pow=
erclamp coretemp ghash_clmulni_intel sha512_ssse3 sha512_generic ast sha256=
_ssse3 ipmi_ssif sha1_ssse3 drm_vram_helper drm_ttm_helper iTCO_wdt aesni_i=
ntel intel_th_gth ttm intel_pmc_bxt crypto_simd iTCO_vendor_support acpi_ip=
mi mei_me cryptd intel_th_pci isst_if_mbox_pci isst_if_mmio rapl pcspkr drm=
_kms_helper mei watchdog isst_if_common ioatdma intel_pch_thermal intel_th =
intel_vsec ipmi_si acpi_pad evdev joydev sg button ipmi_devintf ipmi_msghan=
dler nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 loop fuse efi_pstore drm co=
nfigfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 raid10 raid456 as=
ync_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcr=
c32c crc32c_generic raid0 multipath linear rndis_host cdc_ether usbnet mii
> 2025-05-21T09:18:24.331421+00:00 mc-misc2002 kernel: [   27.825613]  hid_=
generic usbhid hid dm_mod raid1 md_mod sd_mod nvme nvme_core ahci t10_pi li=
bahci xhci_pci crc64_rocksoft crc64 crc_t10dif libata xhci_hcd igb crct10di=
f_generic bnxt_en usbcore scsi_mod crc32_pclmul i2c_algo_bit crct10dif_pclm=
ul crc32c_intel i2c_i801 crct10dif_common dca i2c_smbus usb_common scsi_com=
mon
> 2025-05-21T09:18:24.331422+00:00 mc-misc2002 kernel: [   27.954456] CR2: =
ff409f140a4dc000
> 2025-05-21T09:18:24.331423+00:00 mc-misc2002 kernel: [   27.954458] ---[ =
end trace 0000000000000000 ]---
> 2025-05-21T09:18:24.331423+00:00 mc-misc2002 kernel: [   28.012273] RIP: =
0010:clear_page_erms+0x7/0x10
> 2025-05-21T09:18:24.331424+00:00 mc-misc2002 kernel: [   28.020894] Code:=
 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75=
 d9 90 e9 c3 c3 41 00 0f 1f 00 b9 00 10 00 00 31 c0 <f3> aa c3 cc cc cc cc =
66 90 89 c8 48 c1 e9 03 74 18 0f 1f 84 00 00
> 2025-05-21T09:18:24.331425+00:00 mc-misc2002 kernel: [   28.041975] RSP: =
0018:ff5a1475ced77b48 EFLAGS: 00010246
> 2025-05-21T09:18:24.331426+00:00 mc-misc2002 kernel: [   28.047850] RAX: =
0000000000000000 RBX: ff409f33000b78c0 RCX: 0000000000001000
> 2025-05-21T09:18:24.331428+00:00 mc-misc2002 kernel: [   28.055858] RDX: =
ffa371c686f7d248 RSI: ffa371c6844720c8 RDI: ff409f1411c83000
> 2025-05-21T09:18:24.331429+00:00 mc-misc2002 kernel: [   28.063875] RBP: =
0000000000000005 R08: 0000000000000000 R09: ff409f337ffd6e00
> 2025-05-21T09:18:24.331430+00:00 mc-misc2002 kernel: [   28.071892] R10: =
0000000000000000 R11: ffffffffffffffff R12: ffa371c6844720c8
> 2025-05-21T09:18:24.331431+00:00 mc-misc2002 kernel: [   28.079910] R13: =
ff409f33000b78c0 R14: ffa371c6844720c0 R15: ff409f14bf2cf8a0
> 2025-05-21T09:18:24.331431+00:00 mc-misc2002 kernel: [   28.087927] FS:  =
00007fe3036c7740(0000) GS:ff409f32fffc0000(0000) knlGS:0000000000000000
> 2025-05-21T09:18:24.331432+00:00 mc-misc2002 kernel: [   28.097018] CS:  =
0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2025-05-21T09:18:24.331433+00:00 mc-misc2002 kernel: [   28.103475] CR2: =
ff409f140a4dc000 CR3: 0000000211b62001 CR4: 0000000000771ee0
> 2025-05-21T09:18:24.331434+00:00 mc-misc2002 kernel: [   28.111492] DR0: =
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 2025-05-21T09:18:24.331435+00:00 mc-misc2002 kernel: [   28.119511] DR3: =
0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 2025-05-21T09:18:24.331438+00:00 mc-misc2002 kernel: [   28.127529] PKRU:=
 55555554
> 2025-05-21T09:18:24.331439+00:00 mc-misc2002 kernel: [   28.130575] note:=
 prometheus-debi[1253] exited with irqs disabled

>                                                                  =1B[23;0=
0H                                                                         =
       =1B[05;01H=1B[04;00HLoading initial ramdisk ...                     =
                                =1B[05;01H[    0.000000] microcode: microco=
de updated early to revision 0xd000404, date =3D 2025-01-07
> [    0.000000] Linux version 6.1.0-36-amd64 (debian-kernel@lists.debian.o=
rg) (gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 6.1.139-1 (2025-05-18)
> [    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-6.1.0-36-amd64 ro=
ot=3D/dev/mapper/vg0-root ro console=3DttyS1,115200n8 raid0.default_layout=
=3D2 elevator=3Ddeadline
> [    0.000000] x86/tme: not enabled by BIOS
> [    0.000000] x86/split lock detection: #AC: crashing the kernel on kern=
el split_locks and warning on user-space split_locks
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000987ff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x0000000000098800-0x000000000009ffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000645fefff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x00000000645ff000-0x0000000066ffefff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x0000000066fff000-0x00000000678fefff] ACP=
I data
> [    0.000000] BIOS-e820: [mem 0x00000000678ff000-0x0000000067dfefff] ACP=
I NVS
> [    0.000000] BIOS-e820: [mem 0x0000000067dff000-0x000000006c1fefff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x000000006c1ff000-0x000000006f7fffff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x000000006f800000-0x000000008fffffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed44fff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000407fffffff] usa=
ble
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 3.3.0 present.
> [    0.000000] DMI: Supermicro SYS-120C-TN10R/X12DDW-A6, BIOS 1.9 01/11/2=
024
> [    0.000000] tsc: Detected 2100.000 MHz processor
> [    0.001605] last_pfn =3D 0x4080000 max_arch_pfn =3D 0x10000000000
> [    0.001847] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- =
WT =20
> [    0.004739] last_pfn =3D 0x6f800 max_arch_pfn =3D 0x10000000000
> [    0.021891] Using GB pages for direct mapping
> [    0.022119] RAMDISK: [mem 0x32691000-0x3533ffff]
> [    0.022125] ACPI: Early table checksum verification disabled
> [    0.022131] ACPI: RSDP 0x00000000000F05B0 000024 (v02 SUPERM)
> [    0.022137] ACPI: XSDT 0x0000000067AC4728 0000FC (v01 SUPERM SMCI--MB =
01072009 AMI  01000013)
> [    0.022144] ACPI: FACP 0x00000000678FC000 000114 (v06 SUPERM SMCI--MB =
01072009 INTL 20091013)
> [    0.022151] ACPI: DSDT 0x0000000067893000 067849 (v02 SUPERM SMCI--MB =
01072009 INTL 20091013)
> [    0.022156] ACPI: FACS 0x0000000067DFD000 000040
> [    0.022159] ACPI: SPMI 0x00000000678FB000 000041 (v05 SUPERM SMCI--MB =
00000000 AMI. 00000000)
> [    0.022163] ACPI: FIDT 0x0000000067892000 00009C (v01 SUPERM SMCI--MB =
01072009 AMI  00010013)
> [    0.022167] ACPI: SSDT 0x00000000678FE000 000704 (v02 INTEL  RAS_ACPI =
00000001 INTL 20200925)
> [    0.022172] ACPI: EINJ 0x00000000678FD000 000150 (v01 SUPERM SMCI--MB =
00000001 INTL 00000001)
> [    0.022176] ACPI: ERST 0x0000000067891000 000230 (v01 SUPERM SMCI--MB =
00000001 INTL 00000001)
> [    0.022179] ACPI: BERT 0x0000000067890000 000030 (v01 SUPERM SMCI--MB =
00000001 INTL 00000001)
> [    0.022183] ACPI: SSDT 0x000000006788F000 000745 (v02 INTEL  ADDRXLAT =
00000001 INTL 20200925)
> [    0.022187] ACPI: MCFG 0x000000006788E000 00003C (v01 SUPERM SMCI--MB =
01072009 MSFT 00000097)
> [    0.022191] ACPI: BDAT 0x000000006788D000 000030 (v01 SUPERM SMCI--MB =
00000000 INTL 20091013)
> [    0.022195] ACPI: HMAT 0x000000006788C000 000180 (v01 SUPERM SMCI--MB =
00000001 INTL 20091013)
> [    0.022199] ACPI: HPET 0x000000006788B000 000038 (v01 SUPERM SMCI--MB =
00000001 INTL 20091013)
> [    0.022203] ACPI: MIGT 0x000000006788A000 000040 (v01 SUPERM SMCI--MB =
00000000 INTL 20091013)
> [    0.022207] ACPI: MSCT 0x0000000067889000 000090 (v01 SUPERM SMCI--MB =
00000001 INTL 20091013)
> [    0.022211] ACPI: WDDT 0x0000000067888000 000040 (v01 SUPERM SMCI--MB =
00000000 INTL 20091013)
> [    0.022215] ACPI: APIC 0x0000000067886000 0001DE (v04 SUPERM SMCI--MB =
00000000 INTL 20091013)
> [    0.022218] ACPI: SLIT 0x0000000067885000 000030 (v01 SUPERM SMCI--MB =
00000001 AMI  01000013)
> [    0.022222] ACPI: SRAT 0x000000006787E000 006430 (v03 SUPERM SMCI--MB =
00000002 AMI  01000013)
> [    0.022226] ACPI: OEM4 0x00000000676F6000 187A61 (v02 INTEL  CPU  CST =
00003000 INTL 20200925)
> [    0.022230] ACPI: OEM1 0x00000000675E2000 113489 (v02 INTEL  CPU EIST =
00003000 INTL 20200925)
> [    0.022234] ACPI: SSDT 0x000000006756B000 0764A5 (v02 INTEL  SSDT  PM =
00004000 INTL 20200925)
> [    0.022238] ACPI: HEST 0x0000000067569000 00013C (v01 SUPERM SMCI--MB =
00000001 INTL 00000001)
> [    0.022242] ACPI: DMAR 0x0000000067568000 0002F8 (v01 SUPERM SMCI--MB =
00000001 INTL 20091013)
> [    0.022246] ACPI: SSDT 0x0000000067560000 0078BA (v02 INTEL  SpsNm    =
00000002 INTL 20200925)
> [    0.022250] ACPI: SSDT 0x000000006755E000 001744 (v01 SUPERM SMCCDN   =
00000000 INTL 20181221)
> [    0.022254] ACPI: WSMT 0x0000000067887000 000028 (v01 SUPERM SMCI--MB =
01072009 AMI  00010013)
> [    0.022258] ACPI: SSDT 0x000000006756A000 0009B3 (v02 SUPERM SMCI--MB =
00000000 INTL 20091013)
> [    0.022261] ACPI: Reserving FACP table memory at [mem 0x678fc000-0x678=
fc113]
> [    0.022262] ACPI: Reserving DSDT table memory at [mem 0x67893000-0x678=
fa848]
> [    0.022263] ACPI: Reserving FACS table memory at [mem 0x67dfd000-0x67d=
fd03f]
> [    0.022265] ACPI: Reserving SPMI table memory at [mem 0x678fb000-0x678=
fb040]
> [    0.022266] ACPI: Reserving FIDT table memory at [mem 0x67892000-0x678=
9209b]
> [    0.022266] ACPI: Reserving SSDT table memory at [mem 0x678fe000-0x678=
fe703]
> [    0.022267] ACPI: Reserving EINJ table memory at [mem 0x678fd000-0x678=
fd14f]
> [    0.022268] ACPI: Reserving ERST table memory at [mem 0x67891000-0x678=
9122f]
> [    0.022269] ACPI: Reserving BERT table memory at [mem 0x67890000-0x678=
9002f]
> [    0.022270] ACPI: Reserving SSDT table memory at [mem 0x6788f000-0x678=
8f744]
> [    0.022271] ACPI: Reserving MCFG table memory at [mem 0x6788e000-0x678=
8e03b]
> [    0.022272] ACPI: Reserving BDAT table memory at [mem 0x6788d000-0x678=
8d02f]
> [    0.022273] ACPI: Reserving HMAT table memory at [mem 0x6788c000-0x678=
8c17f]
> [    0.022274] ACPI: Reserving HPET table memory at [mem 0x6788b000-0x678=
8b037]
> [    0.022275] ACPI: Reserving MIGT table memory at [mem 0x6788a000-0x678=
8a03f]
> [    0.022276] ACPI: Reserving MSCT table memory at [mem 0x67889000-0x678=
8908f]
> [    0.022277] ACPI: Reserving WDDT table memory at [mem 0x67888000-0x678=
8803f]
> [    0.022278] ACPI: Reserving APIC table memory at [mem 0x67886000-0x678=
861dd]
> [    0.022279] ACPI: Reserving SLIT table memory at [mem 0x67885000-0x678=
8502f]
> [    0.022280] ACPI: Reserving SRAT table memory at [mem 0x6787e000-0x678=
8442f]
> [    0.022281] ACPI: Reserving OEM4 table memory at [mem 0x676f6000-0x678=
7da60]
> [    0.022282] ACPI: Reserving OEM1 table memory at [mem 0x675e2000-0x676=
f5488]
> [    0.022283] ACPI: Reserving SSDT table memory at [mem 0x6756b000-0x675=
e14a4]
> [    0.022284] ACPI: Reserving HEST table memory at [mem 0x67569000-0x675=
6913b]
> [    0.022285] ACPI: Reserving DMAR table memory at [mem 0x67568000-0x675=
682f7]
> [    0.022286] ACPI: Reserving SSDT table memory at [mem 0x67560000-0x675=
678b9]
> [    0.022287] ACPI: Reserving SSDT table memory at [mem 0x6755e000-0x675=
5f743]
> [    0.022288] ACPI: Reserving WSMT table memory at [mem 0x67887000-0x678=
87027]
> [    0.022289] ACPI: Reserving SSDT table memory at [mem 0x6756a000-0x675=
6a9b2]
> [    0.022329] SRAT: PXM 0 -> APIC 0x00 -> Node 0
> [    0.022331] SRAT: PXM 0 -> APIC 0x01 -> Node 0
> [    0.022332] SRAT: PXM 0 -> APIC 0x02 -> Node 0
> [    0.022333] SRAT: PXM 0 -> APIC 0x03 -> Node 0
> [    0.022333] SRAT: PXM 0 -> APIC 0x04 -> Node 0
> [    0.022334] SRAT: PXM 0 -> APIC 0x05 -> Node 0
> [    0.022335] SRAT: PXM 0 -> APIC 0x06 -> Node 0
> [    0.022336] SRAT: PXM 0 -> APIC 0x07 -> Node 0
> [    0.022336] SRAT: PXM 0 -> APIC 0x08 -> Node 0
> [    0.022337] SRAT: PXM 0 -> APIC 0x09 -> Node 0
> [    0.022338] SRAT: PXM 0 -> APIC 0x0a -> Node 0
> [    0.022339] SRAT: PXM 0 -> APIC 0x0b -> Node 0
> [    0.022339] SRAT: PXM 0 -> APIC 0x0c -> Node 0
> [    0.022340] SRAT: PXM 0 -> APIC 0x0d -> Node 0
> [    0.022341] SRAT: PXM 0 -> APIC 0x0e -> Node 0
> [    0.022342] SRAT: PXM 0 -> APIC 0x0f -> Node 0
> [    0.022343] SRAT: PXM 0 -> APIC 0x10 -> Node 0
> [    0.022344] SRAT: PXM 0 -> APIC 0x11 -> Node 0
> [    0.022344] SRAT: PXM 0 -> APIC 0x12 -> Node 0
> [    0.022345] SRAT: PXM 0 -> APIC 0x13 -> Node 0
> [    0.022346] SRAT: PXM 0 -> APIC 0x14 -> Node 0
> [    0.022347] SRAT: PXM 0 -> APIC 0x15 -> Node 0
> [    0.022347] SRAT: PXM 0 -> APIC 0x16 -> Node 0
> [    0.022348] SRAT: PXM 0 -> APIC 0x17 -> Node 0
> [    0.022349] SRAT: PXM 1 -> APIC 0x40 -> Node 1
> [    0.022350] SRAT: PXM 1 -> APIC 0x41 -> Node 1
> [    0.022351] SRAT: PXM 1 -> APIC 0x42 -> Node 1
> [    0.022352] SRAT: PXM 1 -> APIC 0x43 -> Node 1
> [    0.022352] SRAT: PXM 1 -> APIC 0x44 -> Node 1
> [    0.022353] SRAT: PXM 1 -> APIC 0x45 -> Node 1
> [    0.022354] SRAT: PXM 1 -> APIC 0x46 -> Node 1
> [    0.022355] SRAT: PXM 1 -> APIC 0x47 -> Node 1
> [    0.022355] SRAT: PXM 1 -> APIC 0x48 -> Node 1
> [    0.022356] SRAT: PXM 1 -> APIC 0x49 -> Node 1
> [    0.022357] SRAT: PXM 1 -> APIC 0x4a -> Node 1
> [    0.022358] SRAT: PXM 1 -> APIC 0x4b -> Node 1
> [    0.022359] SRAT: PXM 1 -> APIC 0x4c -> Node 1
> [    0.022360] SRAT: PXM 1 -> APIC 0x4d -> Node 1
> [    0.022361] SRAT: PXM 1 -> APIC 0x4e -> Node 1
> [    0.022362] SRAT: PXM 1 -> APIC 0x4f -> Node 1
> [    0.022363] SRAT: PXM 1 -> APIC 0x50 -> Node 1
> [    0.022364] SRAT: PXM 1 -> APIC 0x51 -> Node 1
> [    0.022365] SRAT: PXM 1 -> APIC 0x52 -> Node 1
> [    0.022366] SRAT: PXM 1 -> APIC 0x53 -> Node 1
> [    0.022367] SRAT: PXM 1 -> APIC 0x54 -> Node 1
> [    0.022367] SRAT: PXM 1 -> APIC 0x55 -> Node 1
> [    0.022368] SRAT: PXM 1 -> APIC 0x56 -> Node 1
> [    0.022369] SRAT: PXM 1 -> APIC 0x57 -> Node 1
> [    0.022431] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> [    0.022433] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
> [    0.022435] ACPI: SRAT: Node 1 PXM 1 [mem 0x2080000000-0x407fffffff]
> [    0.022455] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x10000000=
0-0x207fffffff] -> [mem 0x00000000-0x207fffffff]
> [    0.022468] NODE_DATA(0) allocated [mem 0x207ffd5000-0x207fffffff]
> [    0.022486] NODE_DATA(1) allocated [mem 0x407ffd4000-0x407fffefff]
> [    0.023267] Zone ranges:
> [    0.023268]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.023270]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.023272]   Normal   [mem 0x0000000100000000-0x000000407fffffff]
> [    0.023274]   Device   empty
> [    0.023275] Movable zone start for each node
> [    0.023280] Early memory node ranges
> [    0.023280]   node   0: [mem 0x0000000000001000-0x0000000000097fff]
> [    0.023282]   node   0: [mem 0x0000000000100000-0x00000000645fefff]
> [    0.023284]   node   0: [mem 0x000000006c1ff000-0x000000006f7fffff]
> [    0.023285]   node   0: [mem 0x0000000100000000-0x000000207fffffff]
> [    0.023299]   node   1: [mem 0x0000002080000000-0x000000407fffffff]
> [    0.023314] Initmem setup node 0 [mem 0x0000000000001000-0x000000207ff=
fffff]
> [    0.023318] Initmem setup node 1 [mem 0x0000002080000000-0x000000407ff=
fffff]
> [    0.023322] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.023361] On node 0, zone DMA: 104 pages in unavailable ranges
> [    0.027534] On node 0, zone DMA32: 31744 pages in unavailable ranges
> [    0.027896] On node 0, zone Normal: 2048 pages in unavailable ranges
> [    0.028389] ACPI: PM-Timer IO Port: 0x508
> [    0.028403] ACPI: X2APIC_NMI (uid[0xffffffff] high edge lint[0x1])
> [    0.028407] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [    0.028426] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI =
0-119
> [    0.028430] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.028433] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.028439] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.028440] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> [    0.028445] TSC deadline timer available
> [    0.028447] smpboot: Allowing 48 CPUs, 0 hotplug CPUs
> [    0.028467] PM: hibernation: Registered nosave memory: [mem 0x00000000=
-0x00000fff]
> [    0.028470] PM: hibernation: Registered nosave memory: [mem 0x00098000=
-0x000fffff]
> [    0.028472] PM: hibernation: Registered nosave memory: [mem 0x645ff000=
-0x6c1fefff]
> [    0.028474] PM: hibernation: Registered nosave memory: [mem 0x6f800000=
-0xffffffff]
> [    0.028476] [mem 0x90000000-0xfcffffff] available for PCI devices
> [    0.028478] Booting paravirtualized kernel on bare hardware
> [    0.028481] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:=
 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.034737] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:48 nr_cpu_ids:4=
8 nr_node_ids:2
> [    0.036851] percpu: Embedded 61 pages/cpu s212992 r8192 d28672 u262144
> [    0.036932] Fallback order for Node 0: 0 1=20
> [    0.036935] Fallback order for Node 1: 1 0=20
> [    0.036940] Built 2 zonelists, mobility grouping on.  Total pages: 659=
62256
> [    0.036942] Policy zone: Normal
> [    0.036944] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-6.1.0-36-a=
md64 root=3D/dev/mapper/vg0-root ro console=3DttyS1,115200n8 raid0.default_=
layout=3D2 elevator=3Ddeadline
> [    0.037028] Kernel parameter elevator=3D does not have any effect anym=
ore.
> [    0.037028] Please use sysfs to set IO scheduler for individual device=
s.
> [    0.037032] Unknown kernel command line parameters "BOOT_IMAGE=3D/boot=
/vmlinuz-6.1.0-36-amd64", will be passed to user space.
> [    0.037044] random: crng init done
> [    0.037046] printk: log_buf_len individual max cpu contribution: 4096 =
bytes
> [    0.037047] printk: log_buf_len total cpu_extra contributions: 192512 =
bytes
> [    0.037048] printk: log_buf_len min size: 131072 bytes
> [    0.037499] printk: log_buf_len: 524288 bytes
> [    0.037500] printk: early log buf free: 117400(89%)
> [    0.038316] mem auto-init: stack:all(zero), heap alloc:on, heap free:o=
ff
> [    0.038338] software IO TLB: area num 64.
> [    0.164047] Memory: 1849464K/268037724K available (14343K kernel code,=
 2339K rwdata, 9096K rodata, 2800K init, 17380K bss, 4372848K reserved, 0K =
cma-reserved)
> [    0.164375] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D48=
, Nodes=3D2
> [    0.164412] ftrace: allocating 40346 entries in 158 pages
> [    0.173860] ftrace: allocated 158 pages with 5 groups
> [    0.174888] Dynamic Preempt: voluntary
> [    0.175034] rcu: Preemptible hierarchical RCU implementation.
> [    0.175035] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_i=
ds=3D48.
> [    0.175037] 	Trampoline variant of Tasks RCU enabled.
> [    0.175038] 	Rude variant of Tasks RCU enabled.
> [    0.175038] 	Tracing variant of Tasks RCU enabled.
> [    0.175040] rcu: RCU calculated value of scheduler-enlistment delay is=
 25 jiffies.
> [    0.175041] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D48
> [    0.180715] NR_IRQS: 524544, nr_irqs: 2440, preallocated irqs: 16
> [    0.180957] rcu: srcu_init: Setting srcu_struct sizes based on content=
ion.
> [    0.181593] Console: colour dummy device 80x25
> [    1.691126] printk: console [ttyS1] enabled
> [    1.695874] mempolicy: Enabling automatic NUMA balancing. Configure wi=
th numa_balancing=3D or the kernel.numa_balancing sysctl
> [    1.708469] ACPI: Core revision 20220331
> [    1.715691] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 79635855245 ns
> [    1.725895] APIC: Switch to symmetric I/O mode setup
> [    1.731484] DMAR: Host address width 46
> [    1.735802] DMAR: DRHD base: 0x000000d0ffc000 flags: 0x0
> [    1.741785] DMAR: dmar0: reg_base_addr d0ffc000 ver 4:0 cap 8ed008c407=
80466 ecap 60000f050df
> [    1.751271] DMAR: DRHD base: 0x000000dbbfc000 flags: 0x0
> [    1.757252] DMAR: dmar1: reg_base_addr dbbfc000 ver 4:0 cap 8ed008c407=
80466 ecap 60000f050df
> [    1.766737] DMAR: DRHD base: 0x000000e67fc000 flags: 0x0
> [    1.772716] DMAR: dmar2: reg_base_addr e67fc000 ver 4:0 cap 8ed008c407=
80466 ecap 60000f050df
> [    1.782193] DMAR: DRHD base: 0x000000f13fc000 flags: 0x0
> [    1.788176] DMAR: dmar3: reg_base_addr f13fc000 ver 4:0 cap 8ed008c407=
80466 ecap 60000f050df
> [    1.797662] DMAR: DRHD base: 0x000000fb7fc000 flags: 0x0
> [    1.803640] DMAR: dmar4: reg_base_addr fb7fc000 ver 4:0 cap 8ed008c407=
80466 ecap 60000f050df
> [    1.813127] DMAR: DRHD base: 0x000000a63fc000 flags: 0x0
> [    1.819103] DMAR: dmar5: reg_base_addr a63fc000 ver 4:0 cap 8ed008c407=
80466 ecap 60000f050df
> [    1.828589] DMAR: DRHD base: 0x000000b0ffc000 flags: 0x0
> [    1.834566] DMAR: dmar6: reg_base_addr b0ffc000 ver 4:0 cap 8ed008c407=
80466 ecap 60000f050df
> [    1.844053] DMAR: DRHD base: 0x000000bbbfc000 flags: 0x0
> [    1.850031] DMAR: dmar7: reg_base_addr bbbfc000 ver 4:0 cap 8ed008c407=
80466 ecap 60000f050df
> [    1.859515] DMAR: DRHD base: 0x000000c5ffc000 flags: 0x0
> [    1.865493] DMAR: dmar8: reg_base_addr c5ffc000 ver 4:0 cap 8ed008c407=
80466 ecap 60000f050df
> [    1.874978] DMAR: DRHD base: 0x0000009b7fc000 flags: 0x1
> [    1.880957] DMAR: dmar9: reg_base_addr 9b7fc000 ver 4:0 cap 8ed008c407=
80466 ecap 60000f050df
> [    1.890441] DMAR: RMRR base: 0x0000006b985000 end: 0x0000006b9a8fff
> [    1.897489] DMAR: RMRR base: 0x0000006a3d8000 end: 0x0000006a621fff
> [    1.904538] DMAR: ATSR flags: 0x0
> [    1.908272] DMAR: ATSR flags: 0x0
> [    1.912004] DMAR: RHSA base: 0x0000009b7fc000 proximity domain: 0x0
> [    1.919051] DMAR: RHSA base: 0x000000a63fc000 proximity domain: 0x0
> [    1.926098] DMAR: RHSA base: 0x000000b0ffc000 proximity domain: 0x0
> [    1.933145] DMAR: RHSA base: 0x000000bbbfc000 proximity domain: 0x0
> [    1.940191] DMAR: RHSA base: 0x000000c5ffc000 proximity domain: 0x0
> [    1.947239] DMAR: RHSA base: 0x000000d0ffc000 proximity domain: 0x1
> [    1.954287] DMAR: RHSA base: 0x000000dbbfc000 proximity domain: 0x1
> [    1.961334] DMAR: RHSA base: 0x000000e67fc000 proximity domain: 0x1
> [    1.968380] DMAR: RHSA base: 0x000000f13fc000 proximity domain: 0x1
> [    1.975426] DMAR: RHSA base: 0x000000fb7fc000 proximity domain: 0x1
> [    1.982478] DMAR-IR: IOAPIC id 8 under DRHD base  0x9b7fc000 IOMMU 9
> [    1.989614] DMAR-IR: HPET id 0 under DRHD base 0x9b7fc000
> [    1.995687] DMAR-IR: Queued invalidation will be enabled to support x2=
apic and Intr-remapping.
> [    2.008440] DMAR-IR: Enabled IRQ remapping in x2apic mode
> [    2.014502] x2apic enabled
> [    2.017555] Switched APIC routing to cluster x2apic.
> [    2.025768] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=
=3D-1
> [    2.049871] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycle=
s: 0x1e4530a99b6, max_idle_ns: 440795257976 ns
> [    2.061689] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 4200.00 BogoMIPS (lpj=3D8400000)
> [    2.065722] x86/cpu: VMX (outside TXT) disabled by BIOS
> [    2.069687] x86/cpu: SGX disabled by BIOS.
> [    2.073697] CPU0: Thermal monitoring enabled (TM1)
> [    2.077688] x86/cpu: User Mode Instruction Prevention (UMIP) activated
> [    2.082047] process: using mwait in idle threads
> [    2.085689] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> [    2.089687] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> [    2.093693] Spectre V1 : Mitigation: usercopy/swapgs barriers and __us=
er pointer sanitization
> [    2.097688] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on vm=
 exit
> [    2.101687] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on sy=
scall
> [    2.105687] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
> [    2.109687] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CAL=
L on VMEXIT
> [    2.113688] Spectre V2 : mitigation: Enabling conditional Indirect Bra=
nch Prediction Barrier
> [    2.117687] Speculative Store Bypass: Mitigation: Speculative Store By=
pass disabled via prctl
> [    2.121690] MMIO Stale Data: Mitigation: Clear CPU buffers
> [    2.125688] GDS: Mitigation: Microcode
> [    2.129687] ITS: Mitigation: Aligned branch/return thunks
> [    2.133696] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating poi=
nt registers'
> [    2.137687] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    2.141687] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    2.145687] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
> [    2.149687] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
> [    2.153687] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi25=
6'
> [    2.157687] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys =
User registers'
> [    2.161687] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    2.165687] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
> [    2.169687] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
> [    2.173687] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
> [    2.177687] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
> [    2.181687] x86/fpu: Enabled xstate features 0x2e7, context size is 24=
40 bytes, using 'compacted' format.
> [    2.232887] Freeing SMP alternatives memory: 36K
> [    2.233688] pid_max: default: 49152 minimum: 384
> [    2.237758] LSM: Security Framework initializing
> [    2.241707] landlock: Up and running.
> [    2.245687] Yama: disabled by default; enable with sysctl kernel.yama.*
> [    2.249718] AppArmor: AppArmor initialized
> [    2.253688] TOMOYO Linux initialized
> [    2.257693] LSM support for eBPF active
> [    2.283366] Dentry cache hash table entries: 16777216 (order: 15, 1342=
17728 bytes, vmalloc hugepage)
> [    2.298782] Inode-cache hash table entries: 8388608 (order: 14, 671088=
64 bytes, vmalloc hugepage)
> [    2.302046] Mount-cache hash table entries: 262144 (order: 9, 2097152 =
bytes, vmalloc)
> [    2.306000] Mountpoint-cache hash table entries: 262144 (order: 9, 209=
7152 bytes, vmalloc)
> [    2.310435] smpboot: CPU0: Intel(R) Xeon(R) Silver 4310 CPU @ 2.10GHz =
(family: 0x6, model: 0x6a, stepping: 0x6)
> [    2.313848] cblist_init_generic: Setting adjustable number of callback=
 queues.
> [    2.317687] cblist_init_generic: Setting shift to 6 and lim to 1.
> [    2.321707] cblist_init_generic: Setting adjustable number of callback=
 queues.
> [    2.325687] cblist_init_generic: Setting shift to 6 and lim to 1.
> [    2.329710] cblist_init_generic: Setting adjustable number of callback=
 queues.
> [    2.333687] cblist_init_generic: Setting shift to 6 and lim to 1.
> [    2.337701] Performance Events: PEBS fmt4+-baseline,  AnyThread deprec=
ated, Icelake events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    2.341688] ... version:                5
> [    2.345687] ... bit width:              48
> [    2.349687] ... generic registers:      8
> [    2.353687] ... value mask:             0000ffffffffffff
> [    2.357687] ... max period:             00007fffffffffff
> [    2.361687] ... fixed-purpose events:   4
> [    2.365687] ... event mask:             0001000f000000ff
> [    2.369834] signal: max sigframe size: 3632
> [    2.373706] Estimated ratio of average max frequency by base frequency=
 (times 1024): 1316
> [    2.377708] rcu: Hierarchical SRCU implementation.
> [    2.381687] rcu: 	Max phase no-delay instances is 1000.
> [    2.389309] NMI watchdog: Enabled. Permanently consumes one hw-PMU cou=
nter.
> [    2.390188] smp: Bringing up secondary CPUs ...
> [    2.393790] x86: Booting SMP configuration:
> [    2.397690] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8=
  #9 #10 #11
> [    2.509689] .... node  #1, CPUs:   #12
> [    1.688655] smpboot: CPU 12 Converting physical 0 to logical die 1
> [    2.653778]  #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
> [    2.765687] .... node  #0, CPUs:   #24
> [    2.768307] MMIO Stale Data CPU bug present and SMT on, data leak poss=
ible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/proces=
sor_mmio_stale_data.html for more details.
> [    2.773823]  #25 #26 #27 #28 #29 #30 #31 #32 #33 #34 #35
> [    2.801690] .... node  #1, CPUs:   #36 #37 #38 #39 #40 #41 #42 #43 #44=
 #45 #46 #47
> [    2.831120] smp: Brought up 2 nodes, 48 CPUs
> [    2.837688] smpboot: Max logical packages: 2
> [    2.841688] smpboot: Total of 48 processors activated (201650.65 BogoM=
IPS)
> [    2.905738] node 0 deferred pages initialised in 56ms
> [    2.910569] node 1 deferred pages initialised in 60ms
> [    2.927108] devtmpfs: initialized
> [    2.929764] x86/mm: Memory block size: 2048MB
> [    2.934906] ACPI: PM: Registering ACPI NVS region [mem 0x678ff000-0x67=
dfefff] (5242880 bytes)
> [    2.937828] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 7645041785100000 ns
> [    2.941854] futex hash table entries: 16384 (order: 8, 1048576 bytes, =
vmalloc)
> [    2.945848] pinctrl core: initialized pinctrl subsystem
> [    2.951093] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    2.954480] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allo=
cations
> [    2.958159] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for ato=
mic allocations
> [    2.962156] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for a=
tomic allocations
> [    2.965698] audit: initializing netlink subsys (disabled)
> [    2.969703] audit: type=3D2000 audit(1747827887.104:1): state=3Dinitia=
lized audit_enabled=3D0 res=3D1
> [    2.969859] thermal_sys: Registered thermal governor 'fair_share'
> [    2.973688] thermal_sys: Registered thermal governor 'bang_bang'
> [    2.977688] thermal_sys: Registered thermal governor 'step_wise'
> [    2.981687] thermal_sys: Registered thermal governor 'user_space'
> [    2.985687] thermal_sys: Registered thermal governor 'power_allocator'
> [    2.989717] cpuidle: using governor ladder
> [    3.001699] cpuidle: using governor menu
> [    3.005723] ACPI FADT declares the system doesn't support PCIe ASPM, s=
o disable it
> [    3.009689] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    3.013789] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x800000=
00-0x8fffffff] (base 0x80000000)
> [    3.017690] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E=
820
> [    3.021699] pmd_set_huge: Cannot satisfy [mem 0x80000000-0x80200000] w=
ith a huge-page mapping due to MTRR override.
> [    3.025956] PCI: Using configuration type 1 for base access
> [    3.030837] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    3.034597] kprobes: kprobe jump-optimization is enabled. All kprobes =
are optimized if possible.
> [    3.045739] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pa=
ges
> [    3.049688] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> [    3.057687] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pa=
ges
> [    3.065687] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    3.073846] ACPI: Added _OSI(Module Device)
> [    3.077688] ACPI: Added _OSI(Processor Device)
> [    3.085687] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    3.089688] ACPI: Added _OSI(Processor Aggregator Device)
> [    3.243211] ACPI: 7 ACPI AML tables successfully acquired and loaded
> [    3.266679] ACPI: Dynamic OEM Table Load:
> [    3.407668] ACPI: Dynamic OEM Table Load:
> [    3.661459] ACPI: Interpreter enabled
> [    3.665712] ACPI: PM: (supports S0 S5)
> [    3.669688] ACPI: Using IOAPIC for interrupt routing
> [    3.673790] HEST: Table parsing has been initialized.
> [    3.677791] GHES: APEI firmware first mode is enabled by APEI bit and =
WHEA _OSC.
> [    3.689915] PCI: Using host bridge windows from ACPI; if necessary, us=
e "pci=3Dnocrs" and report a bug
> [    3.697687] PCI: Ignoring E820 reservations for host bridge windows
> [    3.720476] ACPI: Enabled 5 GPEs in block 00 to 7F
> [    3.820807] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-15])
> [    3.829692] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
> [    3.842000] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotp=
lug AER LTR]
> [    3.849905] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability]
> [    3.857687] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using=
 BIOS configuration
> [    3.866428] PCI host bridge to bus 0000:00
> [    3.873688] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 wind=
ow]
> [    3.877688] pci_bus 0000:00: root bus resource [io  0x1000-0x4fff wind=
ow]
> [    3.885687] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bf=
fff window]
> [    3.893687] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cf=
fff window]
> [    3.905687] pci_bus 0000:00: root bus resource [mem 0xfe010000-0xfe010=
fff window]
> [    3.913689] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9b7ff=
fff window]
> [    3.921687] pci_bus 0000:00: root bus resource [mem 0x200000000000-0x2=
00fffffffff window]
> [    3.929687] pci_bus 0000:00: root bus resource [bus 00-15]
> [    3.937710] pci 0000:00:00.0: [8086:09a2] type 00 class 0x088000
> [    3.941801] pci 0000:00:00.1: [8086:09a4] type 00 class 0x088000
> [    3.949770] pci 0000:00:00.2: [8086:09a3] type 00 class 0x088000
> [    3.957769] pci 0000:00:00.4: [8086:0998] type 00 class 0x060000
> [    3.961773] pci 0000:00:01.0: [8086:0b00] type 00 class 0x088000
> [    3.969698] pci 0000:00:01.0: reg 0x10: [mem 0x200ffff50000-0x200ffff5=
3fff 64bit]
> [    3.977801] pci 0000:00:01.1: [8086:0b00] type 00 class 0x088000
> [    3.985697] pci 0000:00:01.1: reg 0x10: [mem 0x200ffff4c000-0x200ffff4=
ffff 64bit]
> [    3.993796] pci 0000:00:01.2: [8086:0b00] type 00 class 0x088000
> [    4.001697] pci 0000:00:01.2: reg 0x10: [mem 0x200ffff48000-0x200ffff4=
bfff 64bit]
> [    4.009797] pci 0000:00:01.3: [8086:0b00] type 00 class 0x088000
> [    4.017697] pci 0000:00:01.3: reg 0x10: [mem 0x200ffff44000-0x200ffff4=
7fff 64bit]
> [    4.025804] pci 0000:00:01.4: [8086:0b00] type 00 class 0x088000
> [    4.029697] pci 0000:00:01.4: reg 0x10: [mem 0x200ffff40000-0x200ffff4=
3fff 64bit]
> [    4.037796] pci 0000:00:01.5: [8086:0b00] type 00 class 0x088000
> [    4.045697] pci 0000:00:01.5: reg 0x10: [mem 0x200ffff3c000-0x200ffff3=
ffff 64bit]
> [    4.053794] pci 0000:00:01.6: [8086:0b00] type 00 class 0x088000
> [    4.061697] pci 0000:00:01.6: reg 0x10: [mem 0x200ffff38000-0x200ffff3=
bfff 64bit]
> [    4.069798] pci 0000:00:01.7: [8086:0b00] type 00 class 0x088000
> [    4.077697] pci 0000:00:01.7: reg 0x10: [mem 0x200ffff34000-0x200ffff3=
7fff 64bit]
> [    4.085792] pci 0000:00:02.0: [8086:09a6] type 00 class 0x088000
> [    4.093695] pci 0000:00:02.0: reg 0x10: [mem 0x9b388000-0x9b389fff]
> [    4.097771] pci 0000:00:02.1: [8086:09a7] type 00 class 0x088000
> [    4.105695] pci 0000:00:02.1: reg 0x10: [mem 0x9b300000-0x9b37ffff]
> [    4.113692] pci 0000:00:02.1: reg 0x14: [mem 0x9b280000-0x9b2fffff]
> [    4.121769] pci 0000:00:02.4: [8086:3456] type 00 class 0x130000
> [    4.125697] pci 0000:00:02.4: reg 0x10: [mem 0x200fffe00000-0x200fffef=
ffff 64bit]
> [    4.133694] pci 0000:00:02.4: reg 0x18: [mem 0x200ffff30000-0x200ffff3=
3fff 64bit]
> [    4.145694] pci 0000:00:02.4: reg 0x20: [mem 0x200ffff00000-0x200ffff1=
ffff 64bit]
> [    4.153780] pci 0000:00:11.0: [8086:a1ec] type 00 class 0xff0000
> [    4.157689] pci 0000:00:11.0: device has non-compliant BARs; disabling=
 IO/MEM decoding
> [    4.169797] pci 0000:00:11.5: [8086:a1d2] type 00 class 0x010601
> [    4.173700] pci 0000:00:11.5: reg 0x10: [mem 0x9b386000-0x9b387fff]
> [    4.181694] pci 0000:00:11.5: reg 0x14: [mem 0x9b38b000-0x9b38b0ff]
> [    4.189694] pci 0000:00:11.5: reg 0x18: [io  0x4070-0x4077]
> [    4.193694] pci 0000:00:11.5: reg 0x1c: [io  0x4060-0x4063]
> [    4.201694] pci 0000:00:11.5: reg 0x20: [io  0x4020-0x403f]
> [    4.205694] pci 0000:00:11.5: reg 0x24: [mem 0x9b180000-0x9b1fffff]
> [    4.213732] pci 0000:00:11.5: PME# supported from D3hot
> [    4.221916] pci 0000:00:14.0: [8086:a1af] type 00 class 0x0c0330
> [    4.225705] pci 0000:00:14.0: reg 0x10: [mem 0x200ffff20000-0x200ffff2=
ffff 64bit]
> [    4.237756] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    4.241925] pci 0000:00:14.2: [8086:a1b1] type 00 class 0x118000
> [    4.249705] pci 0000:00:14.2: reg 0x10: [mem 0x200ffff57000-0x200ffff5=
7fff 64bit]
> [    4.257826] pci 0000:00:16.0: [8086:a1ba] type 00 class 0x078000
> [    4.265711] pci 0000:00:16.0: reg 0x10: [mem 0x200ffff56000-0x200ffff5=
6fff 64bit]
> [    4.273777] pci 0000:00:16.0: PME# supported from D3hot
> [    4.277762] pci 0000:00:16.1: [8086:a1bb] type 00 class 0x078000
> [    4.285712] pci 0000:00:16.1: reg 0x10: [mem 0x200ffff55000-0x200ffff5=
5fff 64bit]
> [    4.293777] pci 0000:00:16.1: PME# supported from D3hot
> [    4.301761] pci 0000:00:16.4: [8086:a1be] type 00 class 0x078000
> [    4.305711] pci 0000:00:16.4: reg 0x10: [mem 0x200ffff54000-0x200ffff5=
4fff 64bit]
> [    4.313776] pci 0000:00:16.4: PME# supported from D3hot
> [    4.321760] pci 0000:00:17.0: [8086:a182] type 00 class 0x010601
> [    4.329700] pci 0000:00:17.0: reg 0x10: [mem 0x9b384000-0x9b385fff]
> [    4.333694] pci 0000:00:17.0: reg 0x14: [mem 0x9b38a000-0x9b38a0ff]
> [    4.341694] pci 0000:00:17.0: reg 0x18: [io  0x4050-0x4057]
> [    4.349695] pci 0000:00:17.0: reg 0x1c: [io  0x4040-0x4043]
> [    4.353694] pci 0000:00:17.0: reg 0x20: [io  0x4000-0x401f]
> [    4.361694] pci 0000:00:17.0: reg 0x24: [mem 0x9b100000-0x9b17ffff]
> [    4.369731] pci 0000:00:17.0: PME# supported from D3hot
> [    4.373902] pci 0000:00:1c.0: [8086:a190] type 01 class 0x060400
> [    4.381766] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    4.389779] pci 0000:00:1c.4: [8086:a194] type 01 class 0x060400
> [    4.393767] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
> [    4.401793] pci 0000:00:1c.5: [8086:a195] type 01 class 0x060400
> [    4.409767] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
> [    4.413792] pci 0000:00:1f.0: [8086:a1cb] type 00 class 0x060100
> [    4.421953] pci 0000:00:1f.2: [8086:a1a1] type 00 class 0x058000
> [    4.429702] pci 0000:00:1f.2: reg 0x10: [mem 0x9b380000-0x9b383fff]
> [    4.437917] pci 0000:00:1f.4: [8086:a1a3] type 00 class 0x0c0500
> [    4.441707] pci 0000:00:1f.4: reg 0x10: [mem 0x00000000-0x000000ff 64b=
it]
> [    4.449711] pci 0000:00:1f.4: reg 0x20: [io  0x0780-0x079f]
> [    4.457761] pci 0000:00:1f.5: [8086:a1a4] type 00 class 0x0c8000
> [    4.465703] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
> [    4.469834] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    4.477731] pci 0000:00:1c.4: PCI bridge to [bus 02]
> [    4.481754] pci 0000:03:00.0: [1a03:1150] type 01 class 0x060400
> [    4.489747] pci 0000:03:00.0: enabling Extended Tags
> [    4.493763] pci 0000:03:00.0: supports D1 D2
> [    4.497687] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    4.505824] pci 0000:00:1c.5: PCI bridge to [bus 03-04]
> [    4.513689] pci 0000:00:1c.5:   bridge window [io  0x3000-0x3fff]
> [    4.521689] pci 0000:00:1c.5:   bridge window [mem 0x9a000000-0x9b0fff=
ff]
> [    4.525730] pci_bus 0000:04: extended config space not accessible
> [    4.533716] pci 0000:04:00.0: [1a03:2000] type 00 class 0x030000
> [    4.541707] pci 0000:04:00.0: reg 0x10: [mem 0x9a000000-0x9affffff]
> [    4.549697] pci 0000:04:00.0: reg 0x14: [mem 0x9b000000-0x9b03ffff]
> [    4.553697] pci 0000:04:00.0: reg 0x18: [io  0x3000-0x307f]
> [    4.561770] pci 0000:04:00.0: supports D1 D2
> [    4.565687] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    4.573789] pci 0000:03:00.0: PCI bridge to [bus 04]
> [    4.577692] pci 0000:03:00.0:   bridge window [io  0x3000-0x3fff]
> [    4.585690] pci 0000:03:00.0:   bridge window [mem 0x9a000000-0x9b0fff=
ff]
> [    4.594420] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 16-2f])
> [    4.601689] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
> [    4.614315] acpi PNP0A08:01: _OSC: platform does not support [SHPCHotp=
lug AER]
> [    4.621953] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability LTR]
> [    4.629687] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using=
 BIOS configuration
> [    4.637814] PCI host bridge to bus 0000:16
> [    4.641688] pci_bus 0000:16: root bus resource [io  0x5000-0x6fff wind=
ow]
> [    4.649687] pci_bus 0000:16: root bus resource [mem 0x9b800000-0xa63ff=
fff window]
> [    4.657688] pci_bus 0000:16: root bus resource [mem 0x201000000000-0x2=
01fffffffff window]
> [    4.669687] pci_bus 0000:16: root bus resource [bus 16-2f]
> [    4.673698] pci 0000:16:00.0: [8086:09a2] type 00 class 0x088000
> [    4.681766] pci 0000:16:00.1: [8086:09a4] type 00 class 0x088000
> [    4.689763] pci 0000:16:00.2: [8086:09a3] type 00 class 0x088000
> [    4.693761] pci 0000:16:00.4: [8086:0998] type 00 class 0x060000
> [    4.701862] ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 30-49])
> [    4.709688] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
> [    4.718479] acpi PNP0A08:02: _OSC: platform does not support [SHPCHotp=
lug AER]
> [    4.729949] acpi PNP0A08:02: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability LTR]
> [    4.737687] acpi PNP0A08:02: FADT indicates ASPM is unsupported, using=
 BIOS configuration
> [    4.745810] PCI host bridge to bus 0000:30
> [    4.749687] pci_bus 0000:30: root bus resource [io  0x7000-0x8fff wind=
ow]
> [    4.757687] pci_bus 0000:30: root bus resource [mem 0xa6400000-0xb0fff=
fff window]
> [    4.765687] pci_bus 0000:30: root bus resource [mem 0x202000000000-0x2=
02fffffffff window]
> [    4.777688] pci_bus 0000:30: root bus resource [bus 30-49]
> [    4.781697] pci 0000:30:00.0: [8086:09a2] type 00 class 0x088000
> [    4.789762] pci 0000:30:00.1: [8086:09a4] type 00 class 0x088000
> [    4.797761] pci 0000:30:00.2: [8086:09a3] type 00 class 0x088000
> [    4.801760] pci 0000:30:00.4: [8086:0998] type 00 class 0x060000
> [    4.809886] ACPI: PCI Root Bridge [PC04] (domain 0000 [bus 4a-63])
> [    4.817689] acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
> [    4.826658] acpi PNP0A08:04: _OSC: platform does not support [SHPCHotp=
lug AER]
> [    4.838196] acpi PNP0A08:04: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability LTR]
> [    4.845688] acpi PNP0A08:04: FADT indicates ASPM is unsupported, using=
 BIOS configuration
> [    4.853808] PCI host bridge to bus 0000:4a
> [    4.857687] pci_bus 0000:4a: root bus resource [io  0x9000-0x9fff wind=
ow]
> [    4.865687] pci_bus 0000:4a: root bus resource [mem 0xb1000000-0xbbbff=
fff window]
> [    4.873687] pci_bus 0000:4a: root bus resource [mem 0x203000000000-0x2=
03fffffffff window]
> [    4.885687] pci_bus 0000:4a: root bus resource [bus 4a-63]
> [    4.889697] pci 0000:4a:00.0: [8086:09a2] type 00 class 0x088000
> [    4.897765] pci 0000:4a:00.1: [8086:09a4] type 00 class 0x088000
> [    4.905763] pci 0000:4a:00.2: [8086:09a3] type 00 class 0x088000
> [    4.909763] pci 0000:4a:00.4: [8086:0998] type 00 class 0x060000
> [    4.917772] pci 0000:4a:05.0: [8086:347d] type 01 class 0x060400
> [    4.925697] pci 0000:4a:05.0: reg 0x10: [mem 0x203ffff00000-0x203ffff1=
ffff 64bit]
> [    4.933700] pci 0000:4a:05.0: enabling Extended Tags
> [    4.937722] pci 0000:4a:05.0: PME# supported from D0 D3hot D3cold
> [    4.946112] pci 0000:4b:00.0: [8086:1521] type 00 class 0x020000
> [    4.953702] pci 0000:4b:00.0: reg 0x10: [mem 0xbba20000-0xbba3ffff]
> [    4.961705] pci 0000:4b:00.0: reg 0x18: [io  0x9020-0x903f]
> [    4.965694] pci 0000:4b:00.0: reg 0x1c: [mem 0xbba44000-0xbba47fff]
> [    4.973756] pci 0000:4b:00.0: PME# supported from D0 D3hot D3cold
> [    4.981717] pci 0000:4b:00.0: reg 0x184: [mem 0x203fffe60000-0x203fffe=
63fff 64bit pref]
> [    4.989687] pci 0000:4b:00.0: VF(n) BAR0 space: [mem 0x203fffe60000-0x=
203fffe7ffff 64bit pref] (contains BAR0 for 8 VFs)
> [    5.001702] pci 0000:4b:00.0: reg 0x190: [mem 0x203fffe40000-0x203fffe=
43fff 64bit pref]
> [    5.009687] pci 0000:4b:00.0: VF(n) BAR3 space: [mem 0x203fffe40000-0x=
203fffe5ffff 64bit pref] (contains BAR3 for 8 VFs)
> [    5.021866] pci 0000:4b:00.1: [8086:1521] type 00 class 0x020000
> [    5.029700] pci 0000:4b:00.1: reg 0x10: [mem 0xbba00000-0xbba1ffff]
> [    5.037700] pci 0000:4b:00.1: reg 0x18: [io  0x9000-0x901f]
> [    5.041694] pci 0000:4b:00.1: reg 0x1c: [mem 0xbba40000-0xbba43fff]
> [    5.049779] pci 0000:4b:00.1: PME# supported from D0 D3hot D3cold
> [    5.057712] pci 0000:4b:00.1: reg 0x184: [mem 0x203fffe20000-0x203fffe=
23fff 64bit pref]
> [    5.065688] pci 0000:4b:00.1: VF(n) BAR0 space: [mem 0x203fffe20000-0x=
203fffe3ffff 64bit pref] (contains BAR0 for 8 VFs)
> [    5.077701] pci 0000:4b:00.1: reg 0x190: [mem 0x203fffe00000-0x203fffe=
03fff 64bit pref]
> [    5.085687] pci 0000:4b:00.1: VF(n) BAR3 space: [mem 0x203fffe00000-0x=
203fffe1ffff 64bit pref] (contains BAR3 for 8 VFs)
> [    5.097826] pci 0000:4a:05.0: PCI bridge to [bus 4b]
> [    5.105689] pci 0000:4a:05.0:   bridge window [io  0x9000-0x9fff]
> [    5.113688] pci 0000:4a:05.0:   bridge window [mem 0xbba00000-0xbbafff=
ff]
> [    5.117689] pci 0000:4a:05.0:   bridge window [mem 0x203fffe00000-0x20=
3fffefffff 64bit pref]
> [    5.129790] ACPI: PCI Root Bridge [PC05] (domain 0000 [bus 64-7d])
> [    5.137689] acpi PNP0A08:05: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
> [    5.147149] acpi PNP0A08:05: _OSC: platform does not support [SHPCHotp=
lug AER]
> [    5.153958] acpi PNP0A08:05: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability LTR]
> [    5.165688] acpi PNP0A08:05: FADT indicates ASPM is unsupported, using=
 BIOS configuration
> [    5.173819] PCI host bridge to bus 0000:64
> [    5.177687] pci_bus 0000:64: root bus resource [io  0xa000-0xafff wind=
ow]
> [    5.185687] pci_bus 0000:64: root bus resource [mem 0xbbc00000-0xc5fff=
fff window]
> [    5.193688] pci_bus 0000:64: root bus resource [mem 0x204000000000-0x2=
04fffffffff window]
> [    5.205688] pci_bus 0000:64: root bus resource [bus 64-7d]
> [    5.209698] pci 0000:64:00.0: [8086:09a2] type 00 class 0x088000
> [    5.217766] pci 0000:64:00.1: [8086:09a4] type 00 class 0x088000
> [    5.221762] pci 0000:64:00.2: [8086:09a3] type 00 class 0x088000
> [    5.229764] pci 0000:64:00.4: [8086:0998] type 00 class 0x060000
> [    5.237769] pci 0000:64:02.0: [8086:347a] type 01 class 0x060400
> [    5.245697] pci 0000:64:02.0: reg 0x10: [mem 0x204ffff60000-0x204ffff7=
ffff 64bit]
> [    5.253736] pci 0000:64:02.0: PME# supported from D0 D3hot D3cold
> [    5.257950] pci 0000:64:03.0: [8086:347b] type 01 class 0x060400
> [    5.265698] pci 0000:64:03.0: reg 0x10: [mem 0x204ffff40000-0x204ffff5=
ffff 64bit]
> [    5.273700] pci 0000:64:03.0: enabling Extended Tags
> [    5.281724] pci 0000:64:03.0: PME# supported from D0 D3hot D3cold
> [    5.285940] pci 0000:64:04.0: [8086:347c] type 01 class 0x060400
> [    5.293701] pci 0000:64:04.0: reg 0x10: [mem 0x204ffff20000-0x204ffff3=
ffff 64bit]
> [    5.301701] pci 0000:64:04.0: enabling Extended Tags
> [    5.309724] pci 0000:64:04.0: PME# supported from D0 D3hot D3cold
> [    5.313944] pci 0000:64:05.0: [8086:347d] type 01 class 0x060400
> [    5.321698] pci 0000:64:05.0: reg 0x10: [mem 0x204ffff00000-0x204ffff1=
ffff 64bit]
> [    5.329700] pci 0000:64:05.0: enabling Extended Tags
> [    5.337724] pci 0000:64:05.0: PME# supported from D0 D3hot D3cold
> [    5.342084] pci 0000:65:00.0: [1344:51c4] type 00 class 0x010802
> [    5.349701] pci 0000:65:00.0: reg 0x10: [mem 0xc5e40000-0xc5e7ffff 64b=
it]
> [    5.357714] pci 0000:65:00.0: reg 0x30: [mem 0xc5e00000-0xc5e3ffff pre=
f]
> [    5.365740] pci 0000:65:00.0: PME# supported from D0 D1 D3hot
> [    5.373790] pci 0000:64:02.0: PCI bridge to [bus 65]
> [    5.377689] pci 0000:64:02.0:   bridge window [mem 0xc5e00000-0xc5efff=
ff]
> [    5.385820] pci 0000:64:03.0: PCI bridge to [bus 66]
> [    5.389689] pci 0000:64:03.0:   bridge window [mem 0xc5d00000-0xc5dfff=
ff]
> [    5.397819] pci 0000:64:04.0: PCI bridge to [bus 67]
> [    5.405689] pci 0000:64:04.0:   bridge window [mem 0xc5c00000-0xc5cfff=
ff]
> [    5.409818] pci 0000:64:05.0: PCI bridge to [bus 68]
> [    5.417689] pci 0000:64:05.0:   bridge window [mem 0xc5b00000-0xc5bfff=
ff]
> [    5.425806] ACPI: PCI Root Bridge [UC06] (domain 0000 [bus 7e])
> [    5.433689] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
> [    5.441758] acpi PNP0A08:06: _OSC: platform does not support [SHPCHotp=
lug AER LTR]
> [    5.449812] acpi PNP0A08:06: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability]
> [    5.457688] acpi PNP0A08:06: FADT indicates ASPM is unsupported, using=
 BIOS configuration
> [    5.469805] PCI host bridge to bus 0000:7e
> [    5.473687] pci_bus 0000:7e: root bus resource [bus 7e]
> [    5.477697] pci 0000:7e:00.0: [8086:3450] type 00 class 0x088000
> [    5.485774] pci 0000:7e:00.1: [8086:3451] type 00 class 0x088000
> [    5.493756] pci 0000:7e:00.2: [8086:3452] type 00 class 0x088000
> [    5.497752] pci 0000:7e:00.3: [8086:0998] type 00 class 0x060000
> [    5.505753] pci 0000:7e:00.5: [8086:3455] type 00 class 0x088000
> [    5.513760] pci 0000:7e:02.0: [8086:3440] type 00 class 0x088000
> [    5.521830] pci 0000:7e:02.1: [8086:3441] type 00 class 0x088000
> [    5.525809] pci 0000:7e:02.2: [8086:3442] type 00 class 0x088000
> [    5.533821] pci 0000:7e:04.0: [8086:3440] type 00 class 0x088000
> [    5.541821] pci 0000:7e:04.1: [8086:3441] type 00 class 0x088000
> [    5.545817] pci 0000:7e:04.2: [8086:3442] type 00 class 0x088000
> [    5.553818] pci 0000:7e:04.3: [8086:3443] type 00 class 0x088000
> [    5.561825] pci 0000:7e:05.0: [8086:3445] type 00 class 0x088000
> [    5.569828] pci 0000:7e:05.1: [8086:3446] type 00 class 0x088000
> [    5.573812] pci 0000:7e:05.2: [8086:3447] type 00 class 0x088000
> [    5.581813] pci 0000:7e:06.0: [8086:3445] type 00 class 0x088000
> [    5.589800] pci 0000:7e:06.1: [8086:3446] type 00 class 0x088000
> [    5.593777] pci 0000:7e:06.2: [8086:3447] type 00 class 0x088000
> [    5.601785] pci 0000:7e:07.0: [8086:3445] type 00 class 0x088000
> [    5.609837] pci 0000:7e:07.1: [8086:3446] type 00 class 0x088000
> [    5.617822] pci 0000:7e:07.2: [8086:3447] type 00 class 0x088000
> [    5.621818] pci 0000:7e:0b.0: [8086:3448] type 00 class 0x088000
> [    5.629770] pci 0000:7e:0b.1: [8086:3448] type 00 class 0x088000
> [    5.637774] pci 0000:7e:0b.2: [8086:344b] type 00 class 0x088000
> [    5.641769] pci 0000:7e:0c.0: [8086:344a] type 00 class 0x110100
> [    5.649804] pci 0000:7e:0d.0: [8086:344a] type 00 class 0x110100
> [    5.657799] pci 0000:7e:0e.0: [8086:344a] type 00 class 0x110100
> [    5.665835] pci 0000:7e:0f.0: [8086:344a] type 00 class 0x110100
> [    5.669856] pci 0000:7e:1a.0: [8086:2880] type 00 class 0x110100
> [    5.677802] pci 0000:7e:1b.0: [8086:2880] type 00 class 0x110100
> [    5.685796] pci 0000:7e:1c.0: [8086:2880] type 00 class 0x110100
> [    5.689843] pci 0000:7e:1d.0: [8086:2880] type 00 class 0x110100
> [    5.697916] ACPI: PCI Root Bridge [UC07] (domain 0000 [bus 7f])
> [    5.705689] acpi PNP0A08:07: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
> [    5.713757] acpi PNP0A08:07: _OSC: platform does not support [SHPCHotp=
lug AER LTR]
> [    5.721811] acpi PNP0A08:07: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability]
> [    5.733687] acpi PNP0A08:07: FADT indicates ASPM is unsupported, using=
 BIOS configuration
> [    5.741815] PCI host bridge to bus 0000:7f
> [    5.745688] pci_bus 0000:7f: root bus resource [bus 7f]
> [    5.753702] pci 0000:7f:00.0: [8086:344c] type 00 class 0x088000
> [    5.757817] pci 0000:7f:00.1: [8086:344c] type 00 class 0x088000
> [    5.765810] pci 0000:7f:00.2: [8086:344c] type 00 class 0x088000
> [    5.773794] pci 0000:7f:00.3: [8086:344c] type 00 class 0x088000
> [    5.777818] pci 0000:7f:00.4: [8086:344c] type 00 class 0x088000
> [    5.785817] pci 0000:7f:00.5: [8086:344c] type 00 class 0x088000
> [    5.793782] pci 0000:7f:00.6: [8086:344c] type 00 class 0x088000
> [    5.801818] pci 0000:7f:00.7: [8086:344c] type 00 class 0x088000
> [    5.805829] pci 0000:7f:01.0: [8086:344c] type 00 class 0x088000
> [    5.813844] pci 0000:7f:01.1: [8086:344c] type 00 class 0x088000
> [    5.821831] pci 0000:7f:01.2: [8086:344c] type 00 class 0x088000
> [    5.825838] pci 0000:7f:01.3: [8086:344c] type 00 class 0x088000
> [    5.833847] pci 0000:7f:0a.0: [8086:344d] type 00 class 0x088000
> [    5.841813] pci 0000:7f:0a.1: [8086:344d] type 00 class 0x088000
> [    5.849809] pci 0000:7f:0a.2: [8086:344d] type 00 class 0x088000
> [    5.853793] pci 0000:7f:0a.3: [8086:344d] type 00 class 0x088000
> [    5.861821] pci 0000:7f:0a.4: [8086:344d] type 00 class 0x088000
> [    5.869817] pci 0000:7f:0a.5: [8086:344d] type 00 class 0x088000
> [    5.873780] pci 0000:7f:0a.6: [8086:344d] type 00 class 0x088000
> [    5.881818] pci 0000:7f:0a.7: [8086:344d] type 00 class 0x088000
> [    5.889825] pci 0000:7f:0b.0: [8086:344d] type 00 class 0x088000
> [    5.897838] pci 0000:7f:0b.1: [8086:344d] type 00 class 0x088000
> [    5.901830] pci 0000:7f:0b.2: [8086:344d] type 00 class 0x088000
> [    5.909838] pci 0000:7f:0b.3: [8086:344d] type 00 class 0x088000
> [    5.917860] pci 0000:7f:1d.0: [8086:344f] type 00 class 0x088000
> [    5.925820] pci 0000:7f:1d.1: [8086:3457] type 00 class 0x088000
> [    5.929804] pci 0000:7f:1e.0: [8086:3458] type 00 class 0x088000
> [    5.937779] pci 0000:7f:1e.1: [8086:3459] type 00 class 0x088000
> [    5.945755] pci 0000:7f:1e.2: [8086:345a] type 00 class 0x088000
> [    5.949755] pci 0000:7f:1e.3: [8086:345b] type 00 class 0x088000
> [    5.957754] pci 0000:7f:1e.4: [8086:345c] type 00 class 0x088000
> [    5.965754] pci 0000:7f:1e.5: [8086:345d] type 00 class 0x088000
> [    5.969761] pci 0000:7f:1e.6: [8086:345e] type 00 class 0x088000
> [    5.977753] pci 0000:7f:1e.7: [8086:345f] type 00 class 0x088000
> [    5.985833] ACPI: PCI Root Bridge [PC06] (domain 0000 [bus 80-96])
> [    5.993689] acpi PNP0A08:08: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
> [    6.002270] acpi PNP0A08:08: _OSC: platform does not support [SHPCHotp=
lug AER]
> [    6.009891] acpi PNP0A08:08: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability LTR]
> [    6.021687] acpi PNP0A08:08: FADT indicates ASPM is unsupported, using=
 BIOS configuration
> [    6.029809] PCI host bridge to bus 0000:80
> [    6.033687] pci_bus 0000:80: root bus resource [io  0xb000-0xbfff wind=
ow]
> [    6.041687] pci_bus 0000:80: root bus resource [mem 0xc6800000-0xd0fff=
fff window]
> [    6.049687] pci_bus 0000:80: root bus resource [mem 0x205000000000-0x2=
05fffffffff window]
> [    6.057687] pci_bus 0000:80: root bus resource [bus 80-96]
> [    6.065697] pci 0000:80:00.0: [8086:09a2] type 00 class 0x088000
> [    6.073774] pci 0000:80:00.1: [8086:09a4] type 00 class 0x088000
> [    6.077756] pci 0000:80:00.2: [8086:09a3] type 00 class 0x088000
> [    6.085756] pci 0000:80:00.4: [8086:0998] type 00 class 0x060000
> [    6.093785] pci 0000:80:01.0: [8086:0b00] type 00 class 0x088000
> [    6.097696] pci 0000:80:01.0: reg 0x10: [mem 0x205ffff40000-0x205ffff4=
3fff 64bit]
> [    6.109784] pci 0000:80:01.1: [8086:0b00] type 00 class 0x088000
> [    6.113697] pci 0000:80:01.1: reg 0x10: [mem 0x205ffff3c000-0x205ffff3=
ffff 64bit]
> [    6.121787] pci 0000:80:01.2: [8086:0b00] type 00 class 0x088000
> [    6.129696] pci 0000:80:01.2: reg 0x10: [mem 0x205ffff38000-0x205ffff3=
bfff 64bit]
> [    6.137782] pci 0000:80:01.3: [8086:0b00] type 00 class 0x088000
> [    6.145696] pci 0000:80:01.3: reg 0x10: [mem 0x205ffff34000-0x205ffff3=
7fff 64bit]
> [    6.153781] pci 0000:80:01.4: [8086:0b00] type 00 class 0x088000
> [    6.161696] pci 0000:80:01.4: reg 0x10: [mem 0x205ffff30000-0x205ffff3=
3fff 64bit]
> [    6.169781] pci 0000:80:01.5: [8086:0b00] type 00 class 0x088000
> [    6.173696] pci 0000:80:01.5: reg 0x10: [mem 0x205ffff2c000-0x205ffff2=
ffff 64bit]
> [    6.185782] pci 0000:80:01.6: [8086:0b00] type 00 class 0x088000
> [    6.189696] pci 0000:80:01.6: reg 0x10: [mem 0x205ffff28000-0x205ffff2=
bfff 64bit]
> [    6.197780] pci 0000:80:01.7: [8086:0b00] type 00 class 0x088000
> [    6.205696] pci 0000:80:01.7: reg 0x10: [mem 0x205ffff24000-0x205ffff2=
7fff 64bit]
> [    6.213778] pci 0000:80:02.0: [8086:09a6] type 00 class 0x088000
> [    6.221694] pci 0000:80:02.0: reg 0x10: [mem 0xd0f80000-0xd0f81fff]
> [    6.229747] pci 0000:80:02.1: [8086:09a7] type 00 class 0x088000
> [    6.233694] pci 0000:80:02.1: reg 0x10: [mem 0xd0f00000-0xd0f7ffff]
> [    6.241691] pci 0000:80:02.1: reg 0x14: [mem 0xd0e80000-0xd0efffff]
> [    6.249755] pci 0000:80:02.4: [8086:3456] type 00 class 0x130000
> [    6.257697] pci 0000:80:02.4: reg 0x10: [mem 0x205fffe00000-0x205fffef=
ffff 64bit]
> [    6.265693] pci 0000:80:02.4: reg 0x18: [mem 0x205ffff20000-0x205ffff2=
3fff 64bit]
> [    6.273693] pci 0000:80:02.4: reg 0x20: [mem 0x205ffff00000-0x205ffff1=
ffff 64bit]
> [    6.281824] ACPI: PCI Root Bridge [PC07] (domain 0000 [bus 97-af])
> [    6.289688] acpi PNP0A08:09: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
> [    6.298665] acpi PNP0A08:09: _OSC: platform does not support [SHPCHotp=
lug AER]
> [    6.305953] acpi PNP0A08:09: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability LTR]
> [    6.317689] acpi PNP0A08:09: FADT indicates ASPM is unsupported, using=
 BIOS configuration
> [    6.325815] PCI host bridge to bus 0000:97
> [    6.329687] pci_bus 0000:97: root bus resource [io  0xc000-0xcfff wind=
ow]
> [    6.337687] pci_bus 0000:97: root bus resource [mem 0xd1000000-0xdbbff=
fff window]
> [    6.345687] pci_bus 0000:97: root bus resource [mem 0x206000000000-0x2=
06fffffffff window]
> [    6.357687] pci_bus 0000:97: root bus resource [bus 97-af]
> [    6.361696] pci 0000:97:00.0: [8086:09a2] type 00 class 0x088000
> [    6.369758] pci 0000:97:00.1: [8086:09a4] type 00 class 0x088000
> [    6.373754] pci 0000:97:00.2: [8086:09a3] type 00 class 0x088000
> [    6.381756] pci 0000:97:00.4: [8086:0998] type 00 class 0x060000
> [    6.389763] pci 0000:97:04.0: [8086:347c] type 01 class 0x060400
> [    6.397696] pci 0000:97:04.0: reg 0x10: [mem 0x206ffff00000-0x206ffff1=
ffff 64bit]
> [    6.405728] pci 0000:97:04.0: PME# supported from D0 D3hot D3cold
> [    6.410076] acpiphp: Slot [0-2] registered
> [    6.417722] pci 0000:98:00.0: [14e4:16d7] type 00 class 0x020000
> [    6.421704] pci 0000:98:00.0: reg 0x10: [mem 0x206fffe10000-0x206fffe1=
ffff 64bit pref]
> [    6.433700] pci 0000:98:00.0: reg 0x18: [mem 0x206fffd00000-0x206fffdf=
ffff 64bit pref]
> [    6.441698] pci 0000:98:00.0: reg 0x20: [mem 0x206fffe22000-0x206fffe2=
3fff 64bit pref]
> [    6.449694] pci 0000:98:00.0: reg 0x30: [mem 0xdba40000-0xdba7ffff pre=
f]
> [    6.457754] pci 0000:98:00.0: PME# supported from D0 D3hot D3cold
> [    6.465871] pci 0000:98:00.1: [14e4:16d7] type 00 class 0x020000
> [    6.469702] pci 0000:98:00.1: reg 0x10: [mem 0x206fffe00000-0x206fffe0=
ffff 64bit pref]
> [    6.481697] pci 0000:98:00.1: reg 0x18: [mem 0x206fffc00000-0x206fffcf=
ffff 64bit pref]
> [    6.489697] pci 0000:98:00.1: reg 0x20: [mem 0x206fffe20000-0x206fffe2=
1fff 64bit pref]
> [    6.497693] pci 0000:98:00.1: reg 0x30: [mem 0xdba00000-0xdba3ffff pre=
f]
> [    6.505751] pci 0000:98:00.1: PME# supported from D0 D3hot D3cold
> [    6.513801] pci 0000:97:04.0: PCI bridge to [bus 98]
> [    6.517689] pci 0000:97:04.0:   bridge window [mem 0xdba00000-0xdbafff=
ff]
> [    6.525689] pci 0000:97:04.0:   bridge window [mem 0x206fffc00000-0x20=
6fffefffff 64bit pref]
> [    6.533802] ACPI: PCI Root Bridge [PC08] (domain 0000 [bus b0-c8])
> [    6.541695] acpi PNP0A08:0a: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
> [    6.554500] acpi PNP0A08:0a: _OSC: platform does not support [SHPCHotp=
lug AER]
> [    6.561954] acpi PNP0A08:0a: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability LTR]
> [    6.569687] acpi PNP0A08:0a: FADT indicates ASPM is unsupported, using=
 BIOS configuration
> [    6.577814] PCI host bridge to bus 0000:b0
> [    6.585687] pci_bus 0000:b0: root bus resource [io  0xd000-0xdfff wind=
ow]
> [    6.593687] pci_bus 0000:b0: root bus resource [mem 0xdbc00000-0xe67ff=
fff window]
> [    6.601687] pci_bus 0000:b0: root bus resource [mem 0x207000000000-0x2=
07fffffffff window]
> [    6.609687] pci_bus 0000:b0: root bus resource [bus b0-c8]
> [    6.613698] pci 0000:b0:00.0: [8086:09a2] type 00 class 0x088000
> [    6.621760] pci 0000:b0:00.1: [8086:09a4] type 00 class 0x088000
> [    6.629755] pci 0000:b0:00.2: [8086:09a3] type 00 class 0x088000
> [    6.637760] pci 0000:b0:00.4: [8086:0998] type 00 class 0x060000
> [    6.641884] ACPI: PCI Root Bridge [PC10] (domain 0000 [bus c9-e1])
> [    6.649689] acpi PNP0A08:0c: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
> [    6.662823] acpi PNP0A08:0c: _OSC: platform does not support [SHPCHotp=
lug AER]
> [    6.669959] acpi PNP0A08:0c: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability LTR]
> [    6.677689] acpi PNP0A08:0c: FADT indicates ASPM is unsupported, using=
 BIOS configuration
> [    6.685816] PCI host bridge to bus 0000:c9
> [    6.693688] pci_bus 0000:c9: root bus resource [io  0xe000-0xefff wind=
ow]
> [    6.701687] pci_bus 0000:c9: root bus resource [mem 0xe6800000-0xf13ff=
fff window]
> [    6.709687] pci_bus 0000:c9: root bus resource [mem 0x208000000000-0x2=
08fffffffff window]
> [    6.717687] pci_bus 0000:c9: root bus resource [bus c9-e1]
> [    6.721696] pci 0000:c9:00.0: [8086:09a2] type 00 class 0x088000
> [    6.729759] pci 0000:c9:00.1: [8086:09a4] type 00 class 0x088000
> [    6.737755] pci 0000:c9:00.2: [8086:09a3] type 00 class 0x088000
> [    6.745760] pci 0000:c9:00.4: [8086:0998] type 00 class 0x060000
> [    6.749762] pci 0000:c9:02.0: [8086:347a] type 01 class 0x060400
> [    6.757696] pci 0000:c9:02.0: reg 0x10: [mem 0x208ffff20000-0x208ffff3=
ffff 64bit]
> [    6.765699] pci 0000:c9:02.0: enabling Extended Tags
> [    6.769719] pci 0000:c9:02.0: PME# supported from D0 D3hot D3cold
> [    6.777944] pci 0000:c9:03.0: [8086:347b] type 01 class 0x060400
> [    6.785699] pci 0000:c9:03.0: reg 0x10: [mem 0x208ffff00000-0x208ffff1=
ffff 64bit]
> [    6.793702] pci 0000:c9:03.0: enabling Extended Tags
> [    6.797738] pci 0000:c9:03.0: PME# supported from D0 D3hot D3cold
> [    6.806068] pci 0000:c9:02.0: PCI bridge to [bus ca]
> [    6.813689] pci 0000:c9:02.0:   bridge window [mem 0xf1200000-0xf12fff=
ff]
> [    6.821814] pci 0000:c9:03.0: PCI bridge to [bus cb]
> [    6.825689] pci 0000:c9:03.0:   bridge window [mem 0xf1100000-0xf11fff=
ff]
> [    6.833802] ACPI: PCI Root Bridge [PC11] (domain 0000 [bus e2-fa])
> [    6.841689] acpi PNP0A08:0d: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
> [    6.852385] acpi PNP0A08:0d: _OSC: platform does not support [SHPCHotp=
lug AER]
> [    6.861959] acpi PNP0A08:0d: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability LTR]
> [    6.869688] acpi PNP0A08:0d: FADT indicates ASPM is unsupported, using=
 BIOS configuration
> [    6.877814] PCI host bridge to bus 0000:e2
> [    6.885688] pci_bus 0000:e2: root bus resource [io  0xf000-0xffff wind=
ow]
> [    6.893687] pci_bus 0000:e2: root bus resource [mem 0xf1400000-0xfb7ff=
fff window]
> [    6.901687] pci_bus 0000:e2: root bus resource [mem 0x209000000000-0x2=
09fffffffff window]
> [    6.909687] pci_bus 0000:e2: root bus resource [bus e2-fa]
> [    6.917696] pci 0000:e2:00.0: [8086:09a2] type 00 class 0x088000
> [    6.921758] pci 0000:e2:00.1: [8086:09a4] type 00 class 0x088000
> [    6.929755] pci 0000:e2:00.2: [8086:09a3] type 00 class 0x088000
> [    6.937756] pci 0000:e2:00.4: [8086:0998] type 00 class 0x060000
> [    6.941761] pci 0000:e2:02.0: [8086:347a] type 01 class 0x060400
> [    6.949696] pci 0000:e2:02.0: reg 0x10: [mem 0x209ffff60000-0x209ffff7=
ffff 64bit]
> [    6.957699] pci 0000:e2:02.0: enabling Extended Tags
> [    6.961719] pci 0000:e2:02.0: PME# supported from D0 D3hot D3cold
> [    6.969945] pci 0000:e2:03.0: [8086:347b] type 01 class 0x060400
> [    6.977699] pci 0000:e2:03.0: reg 0x10: [mem 0x209ffff40000-0x209ffff5=
ffff 64bit]
> [    6.985703] pci 0000:e2:03.0: enabling Extended Tags
> [    6.989745] pci 0000:e2:03.0: PME# supported from D0 D3hot D3cold
> [    6.997935] pci 0000:e2:04.0: [8086:347c] type 01 class 0x060400
> [    7.005696] pci 0000:e2:04.0: reg 0x10: [mem 0x209ffff20000-0x209ffff3=
ffff 64bit]
> [    7.013699] pci 0000:e2:04.0: enabling Extended Tags
> [    7.017719] pci 0000:e2:04.0: PME# supported from D0 D3hot D3cold
> [    7.025939] pci 0000:e2:05.0: [8086:347d] type 01 class 0x060400
> [    7.033696] pci 0000:e2:05.0: reg 0x10: [mem 0x209ffff00000-0x209ffff1=
ffff 64bit]
> [    7.041699] pci 0000:e2:05.0: enabling Extended Tags
> [    7.045720] pci 0000:e2:05.0: PME# supported from D0 D3hot D3cold
> [    7.054060] pci 0000:e2:02.0: PCI bridge to [bus e3]
> [    7.061689] pci 0000:e2:02.0:   bridge window [mem 0xfb600000-0xfb6fff=
ff]
> [    7.065816] pci 0000:e2:03.0: PCI bridge to [bus e4]
> [    7.073689] pci 0000:e2:03.0:   bridge window [mem 0xfb500000-0xfb5fff=
ff]
> [    7.081814] pci 0000:e2:04.0: PCI bridge to [bus e5]
> [    7.085689] pci 0000:e2:04.0:   bridge window [mem 0xfb400000-0xfb4fff=
ff]
> [    7.093815] pci 0000:e2:05.0: PCI bridge to [bus e6]
> [    7.101689] pci 0000:e2:05.0:   bridge window [mem 0xfb300000-0xfb3fff=
ff]
> [    7.105810] ACPI: PCI Root Bridge [UC16] (domain 0000 [bus fe])
> [    7.113689] acpi PNP0A08:0e: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
> [    7.125759] acpi PNP0A08:0e: _OSC: platform does not support [SHPCHotp=
lug AER LTR]
> [    7.133818] acpi PNP0A08:0e: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability]
> [    7.141687] acpi PNP0A08:0e: FADT indicates ASPM is unsupported, using=
 BIOS configuration
> [    7.149800] PCI host bridge to bus 0000:fe
> [    7.153688] pci_bus 0000:fe: root bus resource [bus fe]
> [    7.161697] pci 0000:fe:00.0: [8086:3450] type 00 class 0x088000
> [    7.169766] pci 0000:fe:00.1: [8086:3451] type 00 class 0x088000
> [    7.173747] pci 0000:fe:00.2: [8086:3452] type 00 class 0x088000
> [    7.181746] pci 0000:fe:00.3: [8086:0998] type 00 class 0x060000
> [    7.189748] pci 0000:fe:00.5: [8086:3455] type 00 class 0x088000
> [    7.193758] pci 0000:fe:02.0: [8086:3440] type 00 class 0x088000
> [    7.201824] pci 0000:fe:02.1: [8086:3441] type 00 class 0x088000
> [    7.209804] pci 0000:fe:02.2: [8086:3442] type 00 class 0x088000
> [    7.217809] pci 0000:fe:04.0: [8086:3440] type 00 class 0x088000
> [    7.221816] pci 0000:fe:04.1: [8086:3441] type 00 class 0x088000
> [    7.229812] pci 0000:fe:04.2: [8086:3442] type 00 class 0x088000
> [    7.237812] pci 0000:fe:04.3: [8086:3443] type 00 class 0x088000
> [    7.241815] pci 0000:fe:05.0: [8086:3445] type 00 class 0x088000
> [    7.249836] pci 0000:fe:05.1: [8086:3446] type 00 class 0x088000
> [    7.257806] pci 0000:fe:05.2: [8086:3447] type 00 class 0x088000
> [    7.265806] pci 0000:fe:06.0: [8086:3445] type 00 class 0x088000
> [    7.269785] pci 0000:fe:06.1: [8086:3446] type 00 class 0x088000
> [    7.277771] pci 0000:fe:06.2: [8086:3447] type 00 class 0x088000
> [    7.285778] pci 0000:fe:07.0: [8086:3445] type 00 class 0x088000
> [    7.289833] pci 0000:fe:07.1: [8086:3446] type 00 class 0x088000
> [    7.297815] pci 0000:fe:07.2: [8086:3447] type 00 class 0x088000
> [    7.305819] pci 0000:fe:0b.0: [8086:3448] type 00 class 0x088000
> [    7.313770] pci 0000:fe:0b.1: [8086:3448] type 00 class 0x088000
> [    7.317752] pci 0000:fe:0b.2: [8086:344b] type 00 class 0x088000
> [    7.325759] pci 0000:fe:0c.0: [8086:344a] type 00 class 0x110100
> [    7.333800] pci 0000:fe:0d.0: [8086:344a] type 00 class 0x110100
> [    7.337793] pci 0000:fe:0e.0: [8086:344a] type 00 class 0x110100
> [    7.345829] pci 0000:fe:0f.0: [8086:344a] type 00 class 0x110100
> [    7.353847] pci 0000:fe:1a.0: [8086:2880] type 00 class 0x110100
> [    7.361800] pci 0000:fe:1b.0: [8086:2880] type 00 class 0x110100
> [    7.365790] pci 0000:fe:1c.0: [8086:2880] type 00 class 0x110100
> [    7.373839] pci 0000:fe:1d.0: [8086:2880] type 00 class 0x110100
> [    7.381908] ACPI: PCI Root Bridge [UC17] (domain 0000 [bus ff])
> [    7.385689] acpi PNP0A08:0f: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
> [    7.397757] acpi PNP0A08:0f: _OSC: platform does not support [SHPCHotp=
lug AER LTR]
> [    7.405810] acpi PNP0A08:0f: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability]
> [    7.413688] acpi PNP0A08:0f: FADT indicates ASPM is unsupported, using=
 BIOS configuration
> [    7.425811] PCI host bridge to bus 0000:ff
> [    7.429687] pci_bus 0000:ff: root bus resource [bus ff]
> [    7.433703] pci 0000:ff:00.0: [8086:344c] type 00 class 0x088000
> [    7.441820] pci 0000:ff:00.1: [8086:344c] type 00 class 0x088000
> [    7.449788] pci 0000:ff:00.2: [8086:344c] type 00 class 0x088000
> [    7.453807] pci 0000:ff:00.3: [8086:344c] type 00 class 0x088000
> [    7.461784] pci 0000:ff:00.4: [8086:344c] type 00 class 0x088000
> [    7.469815] pci 0000:ff:00.5: [8086:344c] type 00 class 0x088000
> [    7.473775] pci 0000:ff:00.6: [8086:344c] type 00 class 0x088000
> [    7.481814] pci 0000:ff:00.7: [8086:344c] type 00 class 0x088000
> [    7.489826] pci 0000:ff:01.0: [8086:344c] type 00 class 0x088000
> [    7.497849] pci 0000:ff:01.1: [8086:344c] type 00 class 0x088000
> [    7.501831] pci 0000:ff:01.2: [8086:344c] type 00 class 0x088000
> [    7.509830] pci 0000:ff:01.3: [8086:344c] type 00 class 0x088000
> [    7.517839] pci 0000:ff:0a.0: [8086:344d] type 00 class 0x088000
> [    7.521823] pci 0000:ff:0a.1: [8086:344d] type 00 class 0x088000
> [    7.529795] pci 0000:ff:0a.2: [8086:344d] type 00 class 0x088000
> [    7.537811] pci 0000:ff:0a.3: [8086:344d] type 00 class 0x088000
> [    7.545792] pci 0000:ff:0a.4: [8086:344d] type 00 class 0x088000
> [    7.549811] pci 0000:ff:0a.5: [8086:344d] type 00 class 0x088000
> [    7.557776] pci 0000:ff:0a.6: [8086:344d] type 00 class 0x088000
> [    7.565813] pci 0000:ff:0a.7: [8086:344d] type 00 class 0x088000
> [    7.569825] pci 0000:ff:0b.0: [8086:344d] type 00 class 0x088000
> [    7.577882] pci 0000:ff:0b.1: [8086:344d] type 00 class 0x088000
> [    7.585832] pci 0000:ff:0b.2: [8086:344d] type 00 class 0x088000
> [    7.593829] pci 0000:ff:0b.3: [8086:344d] type 00 class 0x088000
> [    7.597847] pci 0000:ff:1d.0: [8086:344f] type 00 class 0x088000
> [    7.605826] pci 0000:ff:1d.1: [8086:3457] type 00 class 0x088000
> [    7.613809] pci 0000:ff:1e.0: [8086:3458] type 00 class 0x088000
> [    7.621768] pci 0000:ff:1e.1: [8086:3459] type 00 class 0x088000
> [    7.625753] pci 0000:ff:1e.2: [8086:345a] type 00 class 0x088000
> [    7.633757] pci 0000:ff:1e.3: [8086:345b] type 00 class 0x088000
> [    7.641751] pci 0000:ff:1e.4: [8086:345c] type 00 class 0x088000
> [    7.645750] pci 0000:ff:1e.5: [8086:345d] type 00 class 0x088000
> [    7.653753] pci 0000:ff:1e.6: [8086:345e] type 00 class 0x088000
> [    7.661751] pci 0000:ff:1e.7: [8086:345f] type 00 class 0x088000
> [    7.666023] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
> [    7.673727] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
> [    7.681726] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
> [    7.689725] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
> [    7.693725] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
> [    7.701725] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
> [    7.709725] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
> [    7.713725] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
> [    7.722242] iommu: Default domain type: Translated=20
> [    7.729688] iommu: DMA domain TLB invalidation policy: lazy mode=20
> [    7.733803] pps_core: LinuxPPS API ver. 1 registered
> [    7.741687] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolf=
o Giometti <giometti@linux.it>
> [    7.749689] PTP clock support registered
> [    7.753720] EDAC MC: Ver: 3.0.0
> [    7.757907] NetLabel: Initializing
> [    7.761688] NetLabel:  domain hash size =3D 128
> [    7.769687] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
> [    7.773703] NetLabel:  unlabeled traffic allowed by default
> [    7.781688] PCI: Using ACPI for IRQ routing
> [    7.789735] pci 0000:04:00.0: vgaarb: setting as boot VGA device
> [    7.793686] pci 0000:04:00.0: vgaarb: bridge control possible
> [    7.793686] pci 0000:04:00.0: vgaarb: VGA device added: decodes=3Dio+m=
em,owns=3Dnone,locks=3Dnone
> [    7.813713] vgaarb: loaded
> [    7.819615] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> [    7.825687] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
> [    7.833700] clocksource: Switched to clocksource tsc-early
> [    7.840077] VFS: Disk quotas dquot_6.6.0
> [    7.844507] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 by=
tes)
> [    7.852373] AppArmor: AppArmor Filesystem Enabled
> [    7.857675] pnp: PnP ACPI init
> [    7.869873] system 00:01: [io  0x0500-0x05fe] has been reserved
> [    7.876525] system 00:01: [io  0x0400-0x041f] has been reserved
> [    7.883177] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
> [    7.890881] system 00:02: [io  0x0600-0x063f] has been reserved
> [    7.897531] system 00:02: [io  0x0a40-0x0a5f] has been reserved
> [    7.904177] system 00:02: [io  0x0a60-0x0a6f] has been reserved
> [    7.910825] system 00:02: [io  0x0a70-0x0a7f] has been reserved
> [    7.918102] system 00:05: [mem 0xfd000000-0xfdabffff] has been reserved
> [    7.925533] system 00:05: [mem 0xfdad0000-0xfdadffff] has been reserved
> [    7.932960] system 00:05: [mem 0xfdb00000-0xfdffffff] has been reserved
> [    7.940386] system 00:05: [mem 0xfe000000-0xfe00ffff] has been reserved
> [    7.947815] system 00:05: [mem 0xfe011000-0xfe01ffff] has been reserved
> [    7.955242] system 00:05: [mem 0xfe036000-0xfe03bfff] has been reserved
> [    7.962669] system 00:05: [mem 0xfe03d000-0xfe3fffff] has been reserved
> [    7.970096] system 00:05: [mem 0xfe410000-0xfe7fffff] has been reserved
> [    7.977810] system 00:06: [io  0x0f00-0x0ffe] has been reserved
> [    7.985327] pnp: PnP ACPI: found 7 devices
> [    7.995979] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,=
 max_idle_ns: 2085701024 ns
> [    8.006021] NET: Registered PF_INET protocol family
> [    8.011837] IP idents hash table entries: 262144 (order: 9, 2097152 by=
tes, vmalloc)
> [    8.024881] tcp_listen_portaddr_hash hash table entries: 65536 (order:=
 8, 1048576 bytes, vmalloc)
> [    8.034991] Table-perturb hash table entries: 65536 (order: 6, 262144 =
bytes, vmalloc)
> [    8.044357] TCP established hash table entries: 524288 (order: 10, 419=
4304 bytes, vmalloc hugepage)
> [    8.055376] TCP bind hash table entries: 65536 (order: 9, 2097152 byte=
s, vmalloc)
> [    8.063979] TCP: Hash tables configured (established 524288 bind 65536)
> [    8.071776] MPTCP token hash table entries: 65536 (order: 8, 1572864 b=
ytes, vmalloc)
> [    8.080948] UDP hash table entries: 65536 (order: 9, 2097152 bytes, vm=
alloc)
> [    8.089394] UDP-Lite hash table entries: 65536 (order: 9, 2097152 byte=
s, vmalloc)
> [    8.098111] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    8.104473] NET: Registered PF_XDP protocol family
> [    8.109874] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bu=
s 01] add_size 1000
> [    8.119059] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus 01] add_size 200000 add_align 100000
> [    8.131949] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff=
] to [bus 01] add_size 200000 add_align 100000
> [    8.143774] pci 0000:00:1c.0: BAR 14: assigned [mem 0x90000000-0x901ff=
fff]
> [    8.151495] pci 0000:00:1c.0: BAR 15: assigned [mem 0x200000000000-0x2=
000001fffff 64bit pref]
> [    8.161070] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
> [    8.168011] pci 0000:00:1f.4: BAR 0: assigned [mem 0x200000200000-0x20=
00002000ff 64bit]
> [    8.177007] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    8.182581] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> [    8.189424] pci 0000:00:1c.0:   bridge window [mem 0x90000000-0x901fff=
ff]
> [    8.197047] pci 0000:00:1c.0:   bridge window [mem 0x200000000000-0x20=
00001fffff 64bit pref]
> [    8.206526] pci 0000:00:1c.4: PCI bridge to [bus 02]
> [    8.212108] pci 0000:03:00.0: PCI bridge to [bus 04]
> [    8.217675] pci 0000:03:00.0:   bridge window [io  0x3000-0x3fff]
> [    8.224520] pci 0000:03:00.0:   bridge window [mem 0x9a000000-0x9b0fff=
ff]
> [    8.232151] pci 0000:00:1c.5: PCI bridge to [bus 03-04]
> [    8.238018] pci 0000:00:1c.5:   bridge window [io  0x3000-0x3fff]
> [    8.244861] pci 0000:00:1c.5:   bridge window [mem 0x9a000000-0x9b0fff=
ff]
> [    8.252488] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    8.259426] pci_bus 0000:00: resource 5 [io  0x1000-0x4fff window]
> [    8.266358] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff win=
dow]
> [    8.274079] pci_bus 0000:00: resource 7 [mem 0x000c8000-0x000cffff win=
dow]
> [    8.281797] pci_bus 0000:00: resource 8 [mem 0xfe010000-0xfe010fff win=
dow]
> [    8.289515] pci_bus 0000:00: resource 9 [mem 0x90000000-0x9b7fffff win=
dow]
> [    8.297225] pci_bus 0000:00: resource 10 [mem 0x200000000000-0x200ffff=
fffff window]
> [    8.305823] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
> [    8.312080] pci_bus 0000:01: resource 1 [mem 0x90000000-0x901fffff]
> [    8.319115] pci_bus 0000:01: resource 2 [mem 0x200000000000-0x2000001f=
ffff 64bit pref]
> [    8.327997] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
> [    8.334254] pci_bus 0000:03: resource 1 [mem 0x9a000000-0x9b0fffff]
> [    8.341291] pci_bus 0000:04: resource 0 [io  0x3000-0x3fff]
> [    8.347548] pci_bus 0000:04: resource 1 [mem 0x9a000000-0x9b0fffff]
> [    8.354659] pci_bus 0000:16: resource 4 [io  0x5000-0x6fff window]
> [    8.361599] pci_bus 0000:16: resource 5 [mem 0x9b800000-0xa63fffff win=
dow]
> [    8.369319] pci_bus 0000:16: resource 6 [mem 0x201000000000-0x201fffff=
ffff window]
> [    8.377839] pci_bus 0000:30: resource 4 [io  0x7000-0x8fff window]
> [    8.384780] pci_bus 0000:30: resource 5 [mem 0xa6400000-0xb0ffffff win=
dow]
> [    8.392499] pci_bus 0000:30: resource 6 [mem 0x202000000000-0x202fffff=
ffff window]
> [    8.401019] pci 0000:4a:05.0: PCI bridge to [bus 4b]
> [    8.406594] pci 0000:4a:05.0:   bridge window [io  0x9000-0x9fff]
> [    8.413436] pci 0000:4a:05.0:   bridge window [mem 0xbba00000-0xbbafff=
ff]
> [    8.421059] pci 0000:4a:05.0:   bridge window [mem 0x203fffe00000-0x20=
3fffefffff 64bit pref]
> [    8.430535] pci_bus 0000:4a: resource 4 [io  0x9000-0x9fff window]
> [    8.437472] pci_bus 0000:4a: resource 5 [mem 0xb1000000-0xbbbfffff win=
dow]
> [    8.445193] pci_bus 0000:4a: resource 6 [mem 0x203000000000-0x203fffff=
ffff window]
> [    8.453692] pci_bus 0000:4b: resource 0 [io  0x9000-0x9fff]
> [    8.459950] pci_bus 0000:4b: resource 1 [mem 0xbba00000-0xbbafffff]
> [    8.466986] pci_bus 0000:4b: resource 2 [mem 0x203fffe00000-0x203fffef=
ffff 64bit pref]
> [    8.475894] pci 0000:64:02.0: bridge window [io  0x1000-0x0fff] to [bu=
s 65] add_size 1000
> [    8.485075] pci 0000:64:02.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus 65] add_size 200000 add_align 100000
> [    8.497964] pci 0000:64:03.0: bridge window [io  0x1000-0x0fff] to [bu=
s 66] add_size 1000
> [    8.507147] pci 0000:64:03.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus 66] add_size 200000 add_align 100000
> [    8.520034] pci 0000:64:04.0: bridge window [io  0x1000-0x0fff] to [bu=
s 67] add_size 1000
> [    8.529222] pci 0000:64:04.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus 67] add_size 200000 add_align 100000
> [    8.542102] pci 0000:64:05.0: bridge window [io  0x1000-0x0fff] to [bu=
s 68] add_size 1000
> [    8.551285] pci 0000:64:05.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus 68] add_size 200000 add_align 100000
> [    8.564175] pci 0000:64:02.0: BAR 15: assigned [mem 0x204000000000-0x2=
040001fffff 64bit pref]
> [    8.573747] pci 0000:64:03.0: BAR 15: assigned [mem 0x204000200000-0x2=
040003fffff 64bit pref]
> [    8.583321] pci 0000:64:04.0: BAR 15: assigned [mem 0x204000400000-0x2=
040005fffff 64bit pref]
> [    8.592893] pci 0000:64:05.0: BAR 15: assigned [mem 0x204000600000-0x2=
040007fffff 64bit pref]
> [    8.602464] pci 0000:64:02.0: BAR 13: assigned [io  0xa000-0xafff]
> [    8.609402] pci 0000:64:03.0: BAR 13: no space for [io  size 0x1000]
> [    8.616536] pci 0000:64:03.0: BAR 13: failed to assign [io  size 0x100=
0]
> [    8.624059] pci 0000:64:04.0: BAR 13: no space for [io  size 0x1000]
> [    8.631193] pci 0000:64:04.0: BAR 13: failed to assign [io  size 0x100=
0]
> [    8.638717] pci 0000:64:05.0: BAR 13: no space for [io  size 0x1000]
> [    8.645851] pci 0000:64:05.0: BAR 13: failed to assign [io  size 0x100=
0]
> [    8.653376] pci 0000:64:05.0: BAR 13: assigned [io  0xa000-0xafff]
> [    8.660314] pci 0000:64:04.0: BAR 13: no space for [io  size 0x1000]
> [    8.667442] pci 0000:64:04.0: BAR 13: failed to assign [io  size 0x100=
0]
> [    8.674966] pci 0000:64:03.0: BAR 13: no space for [io  size 0x1000]
> [    8.682098] pci 0000:64:03.0: BAR 13: failed to assign [io  size 0x100=
0]
> [    8.689613] pci 0000:64:02.0: BAR 13: no space for [io  size 0x1000]
> [    8.696746] pci 0000:64:02.0: BAR 13: failed to assign [io  size 0x100=
0]
> [    8.704261] pci 0000:64:02.0: PCI bridge to [bus 65]
> [    8.709835] pci 0000:64:02.0:   bridge window [mem 0xc5e00000-0xc5efff=
ff]
> [    8.717457] pci 0000:64:02.0:   bridge window [mem 0x204000000000-0x20=
40001fffff 64bit pref]
> [    8.726934] pci 0000:64:03.0: PCI bridge to [bus 66]
> [    8.732509] pci 0000:64:03.0:   bridge window [mem 0xc5d00000-0xc5dfff=
ff]
> [    8.740130] pci 0000:64:03.0:   bridge window [mem 0x204000200000-0x20=
40003fffff 64bit pref]
> [    8.749608] pci 0000:64:04.0: PCI bridge to [bus 67]
> [    8.755183] pci 0000:64:04.0:   bridge window [mem 0xc5c00000-0xc5cfff=
ff]
> [    8.762808] pci 0000:64:04.0:   bridge window [mem 0x204000400000-0x20=
40005fffff 64bit pref]
> [    8.772283] pci 0000:64:05.0: PCI bridge to [bus 68]
> [    8.777857] pci 0000:64:05.0:   bridge window [io  0xa000-0xafff]
> [    8.784700] pci 0000:64:05.0:   bridge window [mem 0xc5b00000-0xc5bfff=
ff]
> [    8.792324] pci 0000:64:05.0:   bridge window [mem 0x204000600000-0x20=
40007fffff 64bit pref]
> [    8.801799] pci_bus 0000:64: resource 4 [io  0xa000-0xafff window]
> [    8.808739] pci_bus 0000:64: resource 5 [mem 0xbbc00000-0xc5ffffff win=
dow]
> [    8.816456] pci_bus 0000:64: resource 6 [mem 0x204000000000-0x204fffff=
ffff window]
> [    8.824948] pci_bus 0000:65: resource 1 [mem 0xc5e00000-0xc5efffff]
> [    8.831985] pci_bus 0000:65: resource 2 [mem 0x204000000000-0x2040001f=
ffff 64bit pref]
> [    8.840874] pci_bus 0000:66: resource 1 [mem 0xc5d00000-0xc5dfffff]
> [    8.847909] pci_bus 0000:66: resource 2 [mem 0x204000200000-0x2040003f=
ffff 64bit pref]
> [    8.856799] pci_bus 0000:67: resource 1 [mem 0xc5c00000-0xc5cfffff]
> [    8.863834] pci_bus 0000:67: resource 2 [mem 0x204000400000-0x2040005f=
ffff 64bit pref]
> [    8.872716] pci_bus 0000:68: resource 0 [io  0xa000-0xafff]
> [    8.878971] pci_bus 0000:68: resource 1 [mem 0xc5b00000-0xc5bfffff]
> [    8.886009] pci_bus 0000:68: resource 2 [mem 0x204000600000-0x2040007f=
ffff 64bit pref]
> [    8.894942] pci_bus 0000:80: resource 4 [io  0xb000-0xbfff window]
> [    8.901881] pci_bus 0000:80: resource 5 [mem 0xc6800000-0xd0ffffff win=
dow]
> [    8.909601] pci_bus 0000:80: resource 6 [mem 0x205000000000-0x205fffff=
ffff window]
> [    8.918106] pci 0000:97:04.0: PCI bridge to [bus 98]
> [    8.923681] pci 0000:97:04.0:   bridge window [mem 0xdba00000-0xdbafff=
ff]
> [    8.931304] pci 0000:97:04.0:   bridge window [mem 0x206fffc00000-0x20=
6fffefffff 64bit pref]
> [    8.940781] pci_bus 0000:97: resource 4 [io  0xc000-0xcfff window]
> [    8.947721] pci_bus 0000:97: resource 5 [mem 0xd1000000-0xdbbfffff win=
dow]
> [    8.955438] pci_bus 0000:97: resource 6 [mem 0x206000000000-0x206fffff=
ffff window]
> [    8.963936] pci_bus 0000:98: resource 1 [mem 0xdba00000-0xdbafffff]
> [    8.970973] pci_bus 0000:98: resource 2 [mem 0x206fffc00000-0x206fffef=
ffff 64bit pref]
> [    8.979884] pci_bus 0000:b0: resource 4 [io  0xd000-0xdfff window]
> [    8.986824] pci_bus 0000:b0: resource 5 [mem 0xdbc00000-0xe67fffff win=
dow]
> [    8.994542] pci_bus 0000:b0: resource 6 [mem 0x207000000000-0x207fffff=
ffff window]
> [    9.003063] pci 0000:c9:02.0: bridge window [io  0x1000-0x0fff] to [bu=
s ca] add_size 1000
> [    9.012247] pci 0000:c9:02.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus ca] add_size 200000 add_align 100000
> [    9.025133] pci 0000:c9:03.0: bridge window [io  0x1000-0x0fff] to [bu=
s cb] add_size 1000
> [    9.034314] pci 0000:c9:03.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus cb] add_size 200000 add_align 100000
> [    9.047203] pci 0000:c9:02.0: BAR 15: assigned [mem 0x208000000000-0x2=
080001fffff 64bit pref]
> [    9.056776] pci 0000:c9:03.0: BAR 15: assigned [mem 0x208000200000-0x2=
080003fffff 64bit pref]
> [    9.066348] pci 0000:c9:02.0: BAR 13: assigned [io  0xe000-0xefff]
> [    9.073287] pci 0000:c9:03.0: BAR 13: no space for [io  size 0x1000]
> [    9.080422] pci 0000:c9:03.0: BAR 13: failed to assign [io  size 0x100=
0]
> [    9.087946] pci 0000:c9:03.0: BAR 13: assigned [io  0xe000-0xefff]
> [    9.094886] pci 0000:c9:02.0: BAR 13: no space for [io  size 0x1000]
> [    9.102021] pci 0000:c9:02.0: BAR 13: failed to assign [io  size 0x100=
0]
> [    9.109543] pci 0000:c9:02.0: PCI bridge to [bus ca]
> [    9.115118] pci 0000:c9:02.0:   bridge window [mem 0xf1200000-0xf12fff=
ff]
> [    9.122740] pci 0000:c9:02.0:   bridge window [mem 0x208000000000-0x20=
80001fffff 64bit pref]
> [    9.132219] pci 0000:c9:03.0: PCI bridge to [bus cb]
> [    9.137793] pci 0000:c9:03.0:   bridge window [io  0xe000-0xefff]
> [    9.144635] pci 0000:c9:03.0:   bridge window [mem 0xf1100000-0xf11fff=
ff]
> [    9.152258] pci 0000:c9:03.0:   bridge window [mem 0x208000200000-0x20=
80003fffff 64bit pref]
> [    9.161733] pci_bus 0000:c9: resource 4 [io  0xe000-0xefff window]
> [    9.168671] pci_bus 0000:c9: resource 5 [mem 0xe6800000-0xf13fffff win=
dow]
> [    9.176391] pci_bus 0000:c9: resource 6 [mem 0x208000000000-0x208fffff=
ffff window]
> [    9.184888] pci_bus 0000:ca: resource 1 [mem 0xf1200000-0xf12fffff]
> [    9.191926] pci_bus 0000:ca: resource 2 [mem 0x208000000000-0x2080001f=
ffff 64bit pref]
> [    9.200815] pci_bus 0000:cb: resource 0 [io  0xe000-0xefff]
> [    9.207072] pci_bus 0000:cb: resource 1 [mem 0xf1100000-0xf11fffff]
> [    9.214108] pci_bus 0000:cb: resource 2 [mem 0x208000200000-0x2080003f=
ffff 64bit pref]
> [    9.223018] pci 0000:e2:02.0: bridge window [io  0x1000-0x0fff] to [bu=
s e3] add_size 1000
> [    9.232198] pci 0000:e2:02.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus e3] add_size 200000 add_align 100000
> [    9.245088] pci 0000:e2:03.0: bridge window [io  0x1000-0x0fff] to [bu=
s e4] add_size 1000
> [    9.254269] pci 0000:e2:03.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus e4] add_size 200000 add_align 100000
> [    9.267157] pci 0000:e2:04.0: bridge window [io  0x1000-0x0fff] to [bu=
s e5] add_size 1000
> [    9.276340] pci 0000:e2:04.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus e5] add_size 200000 add_align 100000
> [    9.289228] pci 0000:e2:05.0: bridge window [io  0x1000-0x0fff] to [bu=
s e6] add_size 1000
> [    9.298409] pci 0000:e2:05.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus e6] add_size 200000 add_align 100000
> [    9.311298] pci 0000:e2:02.0: BAR 15: assigned [mem 0x209000000000-0x2=
090001fffff 64bit pref]
> [    9.320870] pci 0000:e2:03.0: BAR 15: assigned [mem 0x209000200000-0x2=
090003fffff 64bit pref]
> [    9.330443] pci 0000:e2:04.0: BAR 15: assigned [mem 0x209000400000-0x2=
090005fffff 64bit pref]
> [    9.340013] pci 0000:e2:05.0: BAR 15: assigned [mem 0x209000600000-0x2=
090007fffff 64bit pref]
> [    9.349575] pci 0000:e2:02.0: BAR 13: assigned [io  0xf000-0xffff]
> [    9.356515] pci 0000:e2:03.0: BAR 13: no space for [io  size 0x1000]
> [    9.363650] pci 0000:e2:03.0: BAR 13: failed to assign [io  size 0x100=
0]
> [    9.371173] pci 0000:e2:04.0: BAR 13: no space for [io  size 0x1000]
> [    9.378305] pci 0000:e2:04.0: BAR 13: failed to assign [io  size 0x100=
0]
> [    9.385829] pci 0000:e2:05.0: BAR 13: no space for [io  size 0x1000]
> [    9.392964] pci 0000:e2:05.0: BAR 13: failed to assign [io  size 0x100=
0]
> [    9.400490] pci 0000:e2:05.0: BAR 13: assigned [io  0xf000-0xffff]
> [    9.407429] pci 0000:e2:04.0: BAR 13: no space for [io  size 0x1000]
> [    9.414562] pci 0000:e2:04.0: BAR 13: failed to assign [io  size 0x100=
0]
> [    9.422084] pci 0000:e2:03.0: BAR 13: no space for [io  size 0x1000]
> [    9.429209] pci 0000:e2:03.0: BAR 13: failed to assign [io  size 0x100=
0]
> [    9.436732] pci 0000:e2:02.0: BAR 13: no space for [io  size 0x1000]
> [    9.443858] pci 0000:e2:02.0: BAR 13: failed to assign [io  size 0x100=
0]
> [    9.451380] pci 0000:e2:02.0: PCI bridge to [bus e3]
> [    9.456949] pci 0000:e2:02.0:   bridge window [mem 0xfb600000-0xfb6fff=
ff]
> [    9.464573] pci 0000:e2:02.0:   bridge window [mem 0x209000000000-0x20=
90001fffff 64bit pref]
> [    9.474050] pci 0000:e2:03.0: PCI bridge to [bus e4]
> [    9.479625] pci 0000:e2:03.0:   bridge window [mem 0xfb500000-0xfb5fff=
ff]
> [    9.487248] pci 0000:e2:03.0:   bridge window [mem 0x209000200000-0x20=
90003fffff 64bit pref]
> [    9.496724] pci 0000:e2:04.0: PCI bridge to [bus e5]
> [    9.502300] pci 0000:e2:04.0:   bridge window [mem 0xfb400000-0xfb4fff=
ff]
> [    9.509921] pci 0000:e2:04.0:   bridge window [mem 0x209000400000-0x20=
90005fffff 64bit pref]
> [    9.519400] pci 0000:e2:05.0: PCI bridge to [bus e6]
> [    9.524975] pci 0000:e2:05.0:   bridge window [io  0xf000-0xffff]
> [    9.531817] pci 0000:e2:05.0:   bridge window [mem 0xfb300000-0xfb3fff=
ff]
> [    9.539440] pci 0000:e2:05.0:   bridge window [mem 0x209000600000-0x20=
90007fffff 64bit pref]
> [    9.548919] pci_bus 0000:e2: resource 4 [io  0xf000-0xffff window]
> [    9.555857] pci_bus 0000:e2: resource 5 [mem 0xf1400000-0xfb7fffff win=
dow]
> [    9.563577] pci_bus 0000:e2: resource 6 [mem 0x209000000000-0x209fffff=
ffff window]
> [    9.572081] pci_bus 0000:e3: resource 1 [mem 0xfb600000-0xfb6fffff]
> [    9.579121] pci_bus 0000:e3: resource 2 [mem 0x209000000000-0x2090001f=
ffff 64bit pref]
> [    9.588012] pci_bus 0000:e4: resource 1 [mem 0xfb500000-0xfb5fffff]
> [    9.595049] pci_bus 0000:e4: resource 2 [mem 0x209000200000-0x2090003f=
ffff 64bit pref]
> [    9.603941] pci_bus 0000:e5: resource 1 [mem 0xfb400000-0xfb4fffff]
> [    9.610978] pci_bus 0000:e5: resource 2 [mem 0x209000400000-0x2090005f=
ffff 64bit pref]
> [    9.619870] pci_bus 0000:e6: resource 0 [io  0xf000-0xffff]
> [    9.626128] pci_bus 0000:e6: resource 1 [mem 0xfb300000-0xfb3fffff]
> [    9.633168] pci_bus 0000:e6: resource 2 [mem 0x209000600000-0x2090007f=
ffff 64bit pref]
> [    9.643151] pci 0000:4b:00.0: CLS mismatch (64 !=3D 32), using 64 bytes
> [    9.650597] pci 0000:00:1f.1: [8086:a1a0] type 00 class 0x058000
> [    9.657367] pci 0000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64b=
it]
> [    9.665277] Trying to unpack rootfs image as initramfs...
> [    9.665322] DMAR: No SATC found
> [    9.674876] DMAR: dmar8: Using Queued invalidation
> [    9.680261] DMAR: dmar7: Using Queued invalidation
> [    9.685645] DMAR: dmar4: Using Queued invalidation
> [    9.691028] DMAR: dmar3: Using Queued invalidation
> [    9.696409] DMAR: dmar1: Using Queued invalidation
> [    9.701797] DMAR: dmar0: Using Queued invalidation
> [    9.707176] DMAR: dmar9: Using Queued invalidation
> [    9.712673] pci 0000:64:02.0: Adding to iommu group 0
> [    9.718380] pci 0000:64:03.0: Adding to iommu group 1
> [    9.724083] pci 0000:64:04.0: Adding to iommu group 2
> [    9.729787] pci 0000:64:05.0: Adding to iommu group 3
> [    9.735495] pci 0000:65:00.0: Adding to iommu group 4
> [    9.742798] pci 0000:4a:05.0: Adding to iommu group 5
> [    9.748509] pci 0000:4b:00.0: Adding to iommu group 6
> [    9.754212] pci 0000:4b:00.1: Adding to iommu group 7
> [    9.760999] pci 0000:e2:02.0: Adding to iommu group 8
> [    9.766695] pci 0000:e2:03.0: Adding to iommu group 9
> [    9.772399] pci 0000:e2:04.0: Adding to iommu group 10
> [    9.778202] pci 0000:e2:05.0: Adding to iommu group 11
> [    9.785129] pci 0000:c9:02.0: Adding to iommu group 12
> [    9.790936] pci 0000:c9:03.0: Adding to iommu group 13
> [    9.797392] pci 0000:97:04.0: Adding to iommu group 14
> [    9.803196] pci 0000:98:00.0: Adding to iommu group 15
> [    9.808996] pci 0000:98:00.1: Adding to iommu group 16
> [    9.815682] pci 0000:80:01.0: Adding to iommu group 17
> [    9.821487] pci 0000:80:01.1: Adding to iommu group 18
> [    9.827290] pci 0000:80:01.2: Adding to iommu group 19
> [    9.833091] pci 0000:80:01.3: Adding to iommu group 20
> [    9.838891] pci 0000:80:01.4: Adding to iommu group 21
> [    9.844694] pci 0000:80:01.5: Adding to iommu group 22
> [    9.850492] pci 0000:80:01.6: Adding to iommu group 23
> [    9.856294] pci 0000:80:01.7: Adding to iommu group 24
> [    9.864489] pci 0000:00:00.0: Adding to iommu group 25
> [    9.870294] pci 0000:00:00.1: Adding to iommu group 26
> [    9.876096] pci 0000:00:00.2: Adding to iommu group 27
> [    9.881897] pci 0000:00:00.4: Adding to iommu group 28
> [    9.887697] pci 0000:00:01.0: Adding to iommu group 29
> [    9.893499] pci 0000:00:01.1: Adding to iommu group 30
> [    9.899301] pci 0000:00:01.2: Adding to iommu group 31
> [    9.905093] pci 0000:00:01.3: Adding to iommu group 32
> [    9.910893] pci 0000:00:01.4: Adding to iommu group 33
> [    9.916694] pci 0000:00:01.5: Adding to iommu group 34
> [    9.922495] pci 0000:00:01.6: Adding to iommu group 35
> [    9.928298] pci 0000:00:01.7: Adding to iommu group 36
> [    9.934177] pci 0000:00:02.0: Adding to iommu group 37
> [    9.939979] pci 0000:00:02.1: Adding to iommu group 37
> [    9.945778] pci 0000:00:02.4: Adding to iommu group 37
> [    9.951632] pci 0000:00:11.0: Adding to iommu group 38
> [    9.957435] pci 0000:00:11.5: Adding to iommu group 38
> [    9.959185] Freeing initrd memory: 45756K
> [    9.963291] pci 0000:00:14.0: Adding to iommu group 39
> [    9.973517] pci 0000:00:14.2: Adding to iommu group 39
> [    9.979396] pci 0000:00:16.0: Adding to iommu group 40
> [    9.985198] pci 0000:00:16.1: Adding to iommu group 40
> [    9.990991] pci 0000:00:16.4: Adding to iommu group 40
> [    9.996793] pci 0000:00:17.0: Adding to iommu group 41
> [   10.002618] pci 0000:00:1c.0: Adding to iommu group 42
> [   10.008421] pci 0000:00:1c.4: Adding to iommu group 43
> [   10.014222] pci 0000:00:1c.5: Adding to iommu group 44
> [   10.020124] pci 0000:00:1f.0: Adding to iommu group 45
> [   10.025926] pci 0000:00:1f.2: Adding to iommu group 45
> [   10.031721] pci 0000:00:1f.4: Adding to iommu group 45
> [   10.037525] pci 0000:00:1f.5: Adding to iommu group 45
> [   10.043327] pci 0000:03:00.0: Adding to iommu group 46
> [   10.049101] pci 0000:04:00.0: Adding to iommu group 46
> [   10.054901] pci 0000:16:00.0: Adding to iommu group 47
> [   10.060701] pci 0000:16:00.1: Adding to iommu group 48
> [   10.066502] pci 0000:16:00.2: Adding to iommu group 49
> [   10.072303] pci 0000:16:00.4: Adding to iommu group 50
> [   10.078104] pci 0000:30:00.0: Adding to iommu group 51
> [   10.083905] pci 0000:30:00.1: Adding to iommu group 52
> [   10.089707] pci 0000:30:00.2: Adding to iommu group 53
> [   10.095509] pci 0000:30:00.4: Adding to iommu group 54
> [   10.101314] pci 0000:4a:00.0: Adding to iommu group 55
> [   10.107114] pci 0000:4a:00.1: Adding to iommu group 56
> [   10.112913] pci 0000:4a:00.2: Adding to iommu group 57
> [   10.118714] pci 0000:4a:00.4: Adding to iommu group 58
> [   10.124516] pci 0000:64:00.0: Adding to iommu group 59
> [   10.130317] pci 0000:64:00.1: Adding to iommu group 60
> [   10.136116] pci 0000:64:00.2: Adding to iommu group 61
> [   10.141918] pci 0000:64:00.4: Adding to iommu group 62
> [   10.147715] pci 0000:7e:00.0: Adding to iommu group 63
> [   10.153516] pci 0000:7e:00.1: Adding to iommu group 64
> [   10.159316] pci 0000:7e:00.2: Adding to iommu group 65
> [   10.165119] pci 0000:7e:00.3: Adding to iommu group 66
> [   10.170913] pci 0000:7e:00.5: Adding to iommu group 67
> [   10.176703] pci 0000:7e:02.0: Adding to iommu group 68
> [   10.182505] pci 0000:7e:02.1: Adding to iommu group 69
> [   10.188305] pci 0000:7e:02.2: Adding to iommu group 70
> [   10.194108] pci 0000:7e:04.0: Adding to iommu group 71
> [   10.199912] pci 0000:7e:04.1: Adding to iommu group 72
> [   10.205714] pci 0000:7e:04.2: Adding to iommu group 73
> [   10.211517] pci 0000:7e:04.3: Adding to iommu group 74
> [   10.217318] pci 0000:7e:05.0: Adding to iommu group 75
> [   10.223121] pci 0000:7e:05.1: Adding to iommu group 76
> [   10.228921] pci 0000:7e:05.2: Adding to iommu group 77
> [   10.234722] pci 0000:7e:06.0: Adding to iommu group 78
> [   10.240523] pci 0000:7e:06.1: Adding to iommu group 79
> [   10.246323] pci 0000:7e:06.2: Adding to iommu group 80
> [   10.252122] pci 0000:7e:07.0: Adding to iommu group 81
> [   10.257923] pci 0000:7e:07.1: Adding to iommu group 82
> [   10.263722] pci 0000:7e:07.2: Adding to iommu group 83
> [   10.269597] pci 0000:7e:0b.0: Adding to iommu group 84
> [   10.275405] pci 0000:7e:0b.1: Adding to iommu group 84
> [   10.281212] pci 0000:7e:0b.2: Adding to iommu group 84
> [   10.287010] pci 0000:7e:0c.0: Adding to iommu group 85
> [   10.292811] pci 0000:7e:0d.0: Adding to iommu group 86
> [   10.298614] pci 0000:7e:0e.0: Adding to iommu group 87
> [   10.304404] pci 0000:7e:0f.0: Adding to iommu group 88
> [   10.310202] pci 0000:7e:1a.0: Adding to iommu group 89
> [   10.316002] pci 0000:7e:1b.0: Adding to iommu group 90
> [   10.321800] pci 0000:7e:1c.0: Adding to iommu group 91
> [   10.327599] pci 0000:7e:1d.0: Adding to iommu group 92
> [   10.333397] pci 0000:7f:00.0: Adding to iommu group 93
> [   10.339195] pci 0000:7f:00.1: Adding to iommu group 94
> [   10.344993] pci 0000:7f:00.2: Adding to iommu group 95
> [   10.350795] pci 0000:7f:00.3: Adding to iommu group 96
> [   10.356596] pci 0000:7f:00.4: Adding to iommu group 97
> [   10.362397] pci 0000:7f:00.5: Adding to iommu group 98
> [   10.368197] pci 0000:7f:00.6: Adding to iommu group 99
> [   10.373996] pci 0000:7f:00.7: Adding to iommu group 100
> [   10.379894] pci 0000:7f:01.0: Adding to iommu group 101
> [   10.385791] pci 0000:7f:01.1: Adding to iommu group 102
> [   10.391687] pci 0000:7f:01.2: Adding to iommu group 103
> [   10.397586] pci 0000:7f:01.3: Adding to iommu group 104
> [   10.403480] pci 0000:7f:0a.0: Adding to iommu group 105
> [   10.409378] pci 0000:7f:0a.1: Adding to iommu group 106
> [   10.415275] pci 0000:7f:0a.2: Adding to iommu group 107
> [   10.421173] pci 0000:7f:0a.3: Adding to iommu group 108
> [   10.427071] pci 0000:7f:0a.4: Adding to iommu group 109
> [   10.432972] pci 0000:7f:0a.5: Adding to iommu group 110
> [   10.438868] pci 0000:7f:0a.6: Adding to iommu group 111
> [   10.444766] pci 0000:7f:0a.7: Adding to iommu group 112
> [   10.450664] pci 0000:7f:0b.0: Adding to iommu group 113
> [   10.456560] pci 0000:7f:0b.1: Adding to iommu group 114
> [   10.462459] pci 0000:7f:0b.2: Adding to iommu group 115
> [   10.468355] pci 0000:7f:0b.3: Adding to iommu group 116
> [   10.474251] pci 0000:7f:1d.0: Adding to iommu group 117
> [   10.480148] pci 0000:7f:1d.1: Adding to iommu group 118
> [   10.486247] pci 0000:7f:1e.0: Adding to iommu group 119
> [   10.492157] pci 0000:7f:1e.1: Adding to iommu group 119
> [   10.498065] pci 0000:7f:1e.2: Adding to iommu group 119
> [   10.503974] pci 0000:7f:1e.3: Adding to iommu group 119
> [   10.509874] pci 0000:7f:1e.4: Adding to iommu group 119
> [   10.515781] pci 0000:7f:1e.5: Adding to iommu group 119
> [   10.521688] pci 0000:7f:1e.6: Adding to iommu group 119
> [   10.527596] pci 0000:7f:1e.7: Adding to iommu group 119
> [   10.533495] pci 0000:80:00.0: Adding to iommu group 120
> [   10.539391] pci 0000:80:00.1: Adding to iommu group 121
> [   10.545288] pci 0000:80:00.2: Adding to iommu group 122
> [   10.551187] pci 0000:80:00.4: Adding to iommu group 123
> [   10.557164] pci 0000:80:02.0: Adding to iommu group 124
> [   10.563074] pci 0000:80:02.1: Adding to iommu group 124
> [   10.568983] pci 0000:80:02.4: Adding to iommu group 124
> [   10.574871] pci 0000:97:00.0: Adding to iommu group 125
> [   10.580768] pci 0000:97:00.1: Adding to iommu group 126
> [   10.586665] pci 0000:97:00.2: Adding to iommu group 127
> [   10.592561] pci 0000:97:00.4: Adding to iommu group 128
> [   10.598459] pci 0000:b0:00.0: Adding to iommu group 129
> [   10.604356] pci 0000:b0:00.1: Adding to iommu group 130
> [   10.610251] pci 0000:b0:00.2: Adding to iommu group 131
> [   10.616147] pci 0000:b0:00.4: Adding to iommu group 132
> [   10.622044] pci 0000:c9:00.0: Adding to iommu group 133
> [   10.627944] pci 0000:c9:00.1: Adding to iommu group 134
> [   10.633839] pci 0000:c9:00.2: Adding to iommu group 135
> [   10.639734] pci 0000:c9:00.4: Adding to iommu group 136
> [   10.645632] pci 0000:e2:00.0: Adding to iommu group 137
> [   10.651531] pci 0000:e2:00.1: Adding to iommu group 138
> [   10.657427] pci 0000:e2:00.2: Adding to iommu group 139
> [   10.663322] pci 0000:e2:00.4: Adding to iommu group 140
> [   10.669221] pci 0000:fe:00.0: Adding to iommu group 141
> [   10.675118] pci 0000:fe:00.1: Adding to iommu group 142
> [   10.681014] pci 0000:fe:00.2: Adding to iommu group 143
> [   10.686909] pci 0000:fe:00.3: Adding to iommu group 144
> [   10.692807] pci 0000:fe:00.5: Adding to iommu group 145
> [   10.698708] pci 0000:fe:02.0: Adding to iommu group 146
> [   10.704605] pci 0000:fe:02.1: Adding to iommu group 147
> [   10.710502] pci 0000:fe:02.2: Adding to iommu group 148
> [   10.716398] pci 0000:fe:04.0: Adding to iommu group 149
> [   10.722298] pci 0000:fe:04.1: Adding to iommu group 150
> [   10.728187] pci 0000:fe:04.2: Adding to iommu group 151
> [   10.734083] pci 0000:fe:04.3: Adding to iommu group 152
> [   10.739981] pci 0000:fe:05.0: Adding to iommu group 153
> [   10.745877] pci 0000:fe:05.1: Adding to iommu group 154
> [   10.751773] pci 0000:fe:05.2: Adding to iommu group 155
> [   10.757669] pci 0000:fe:06.0: Adding to iommu group 156
> [   10.763566] pci 0000:fe:06.1: Adding to iommu group 157
> [   10.769466] pci 0000:fe:06.2: Adding to iommu group 158
> [   10.775362] pci 0000:fe:07.0: Adding to iommu group 159
> [   10.781261] pci 0000:fe:07.1: Adding to iommu group 160
> [   10.787159] pci 0000:fe:07.2: Adding to iommu group 161
> [   10.793132] pci 0000:fe:0b.0: Adding to iommu group 162
> [   10.799049] pci 0000:fe:0b.1: Adding to iommu group 162
> [   10.804958] pci 0000:fe:0b.2: Adding to iommu group 162
> [   10.810852] pci 0000:fe:0c.0: Adding to iommu group 163
> [   10.816749] pci 0000:fe:0d.0: Adding to iommu group 164
> [   10.822644] pci 0000:fe:0e.0: Adding to iommu group 165
> [   10.828540] pci 0000:fe:0f.0: Adding to iommu group 166
> [   10.834437] pci 0000:fe:1a.0: Adding to iommu group 167
> [   10.840333] pci 0000:fe:1b.0: Adding to iommu group 168
> [   10.846231] pci 0000:fe:1c.0: Adding to iommu group 169
> [   10.852130] pci 0000:fe:1d.0: Adding to iommu group 170
> [   10.858026] pci 0000:ff:00.0: Adding to iommu group 171
> [   10.863924] pci 0000:ff:00.1: Adding to iommu group 172
> [   10.869820] pci 0000:ff:00.2: Adding to iommu group 173
> [   10.875715] pci 0000:ff:00.3: Adding to iommu group 174
> [   10.881612] pci 0000:ff:00.4: Adding to iommu group 175
> [   10.887509] pci 0000:ff:00.5: Adding to iommu group 176
> [   10.893404] pci 0000:ff:00.6: Adding to iommu group 177
> [   10.899299] pci 0000:ff:00.7: Adding to iommu group 178
> [   10.905196] pci 0000:ff:01.0: Adding to iommu group 179
> [   10.911092] pci 0000:ff:01.1: Adding to iommu group 180
> [   10.916989] pci 0000:ff:01.2: Adding to iommu group 181
> [   10.922885] pci 0000:ff:01.3: Adding to iommu group 182
> [   10.928782] pci 0000:ff:0a.0: Adding to iommu group 183
> [   10.934679] pci 0000:ff:0a.1: Adding to iommu group 184
> [   10.940575] pci 0000:ff:0a.2: Adding to iommu group 185
> [   10.946472] pci 0000:ff:0a.3: Adding to iommu group 186
> [   10.952369] pci 0000:ff:0a.4: Adding to iommu group 187
> [   10.958265] pci 0000:ff:0a.5: Adding to iommu group 188
> [   10.964161] pci 0000:ff:0a.6: Adding to iommu group 189
> [   10.970058] pci 0000:ff:0a.7: Adding to iommu group 190
> [   10.975955] pci 0000:ff:0b.0: Adding to iommu group 191
> [   10.981852] pci 0000:ff:0b.1: Adding to iommu group 192
> [   10.987750] pci 0000:ff:0b.2: Adding to iommu group 193
> [   10.993646] pci 0000:ff:0b.3: Adding to iommu group 194
> [   10.999545] pci 0000:ff:1d.0: Adding to iommu group 195
> [   11.005443] pci 0000:ff:1d.1: Adding to iommu group 196
> [   11.011544] pci 0000:ff:1e.0: Adding to iommu group 197
> [   11.017463] pci 0000:ff:1e.1: Adding to iommu group 197
> [   11.023382] pci 0000:ff:1e.2: Adding to iommu group 197
> [   11.029303] pci 0000:ff:1e.3: Adding to iommu group 197
> [   11.035224] pci 0000:ff:1e.4: Adding to iommu group 197
> [   11.041144] pci 0000:ff:1e.5: Adding to iommu group 197
> [   11.047062] pci 0000:ff:1e.6: Adding to iommu group 197
> [   11.052984] pci 0000:ff:1e.7: Adding to iommu group 197
> [   11.107802] DMAR: Intel(R) Virtualization Technology for Directed I/O
> [   11.115041] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [   11.122271] software IO TLB: mapped [mem 0x00000000605ff000-0x00000000=
645ff000] (64MB)
> [   11.132071] Initialise system trusted keyrings
> [   11.137072] Key type blacklist registered
> [   11.141648] workingset: timestamp_bits=3D36 max_order=3D26 bucket_orde=
r=3D0
> [   11.149974] zbud: loaded
> [   11.153078] integrity: Platform Keyring initialized
> [   11.158559] integrity: Machine keyring initialized
> [   11.163940] Key type asymmetric registered
> [   11.168541] Asymmetric key parser 'x509' registered
> [   11.178820] alg: self-tests for CTR-KDF (hmac(sha256)) passed
> [   11.185299] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 248)
> [   11.193658] io scheduler mq-deadline registered
> [   11.200177] pcieport 0000:00:1c.0: PME: Signaling with IRQ 130
> [   11.206761] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- M=
RL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLAc=
tRep+
> [   11.222136] pcieport 0000:00:1c.4: PME: Signaling with IRQ 131
> [   11.228882] pcieport 0000:00:1c.5: PME: Signaling with IRQ 132
> [   11.235607] pcieport 0000:4a:05.0: PME: Signaling with IRQ 133
> [   11.242313] pcieport 0000:64:02.0: PME: Signaling with IRQ 134
> [   11.248878] pcieport 0000:64:02.0: pciehp: Slot #48 AttnBtn+ PwrCtrl+ =
MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLA=
ctRep+ (with Cmd Compl erratum)
> [   11.266736] pcieport 0000:64:03.0: PME: Signaling with IRQ 135
> [   11.273300] pcieport 0000:64:03.0: pciehp: Slot #49 AttnBtn+ PwrCtrl+ =
MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLA=
ctRep+ (with Cmd Compl erratum)
> [   11.291138] pcieport 0000:64:04.0: PME: Signaling with IRQ 136
> [   11.297704] pcieport 0000:64:04.0: pciehp: Slot #50 AttnBtn+ PwrCtrl+ =
MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLA=
ctRep+ (with Cmd Compl erratum)
> [   11.315552] pcieport 0000:64:05.0: PME: Signaling with IRQ 137
> [   11.322118] pcieport 0000:64:05.0: pciehp: Slot #51 AttnBtn+ PwrCtrl+ =
MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLA=
ctRep+ (with Cmd Compl erratum)
> [   11.340102] pcieport 0000:97:04.0: PME: Signaling with IRQ 138
> [   11.346810] pcieport 0000:c9:02.0: PME: Signaling with IRQ 139
> [   11.353381] pcieport 0000:c9:02.0: pciehp: Slot #52 AttnBtn+ PwrCtrl+ =
MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLA=
ctRep+ (with Cmd Compl erratum)
> [   11.371243] pcieport 0000:c9:03.0: PME: Signaling with IRQ 140
> [   11.377814] pcieport 0000:c9:03.0: pciehp: Slot #53 AttnBtn+ PwrCtrl+ =
MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLA=
ctRep+ (with Cmd Compl erratum)
> [   11.395670] pcieport 0000:e2:02.0: PME: Signaling with IRQ 141
> [   11.402241] pcieport 0000:e2:02.0: pciehp: Slot #54 AttnBtn+ PwrCtrl+ =
MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLA=
ctRep+ (with Cmd Compl erratum)
> [   11.420097] pcieport 0000:e2:03.0: PME: Signaling with IRQ 142
> [   11.426662] pcieport 0000:e2:03.0: pciehp: Slot #55 AttnBtn+ PwrCtrl+ =
MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLA=
ctRep+ (with Cmd Compl erratum)
> [   11.444511] pcieport 0000:e2:04.0: PME: Signaling with IRQ 143
> [   11.451077] pcieport 0000:e2:04.0: pciehp: Slot #56 AttnBtn+ PwrCtrl+ =
MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLA=
ctRep+ (with Cmd Compl erratum)
> [   11.468920] pcieport 0000:e2:05.0: PME: Signaling with IRQ 144
> [   11.475483] pcieport 0000:e2:05.0: pciehp: Slot #57 AttnBtn+ PwrCtrl+ =
MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- IbPresDis- LLA=
ctRep+ (with Cmd Compl erratum)
> [   11.493483] shpchp: Standard Hot Plug PCI Controller Driver version: 0=
=2E4
> [   11.501159] ACPI: \_SB_.SCK0.C000: Found 2 idle states
> [   11.510844] acpi/hmat: Memory (0x0 length 0x80000000) Flags:0003 Proce=
ssor Domain:0 Memory Domain:0
> [   11.521005] acpi/hmat: Memory (0x100000000 length 0x1f80000000) Flags:=
0003 Processor Domain:0 Memory Domain:0
> [   11.532139] acpi/hmat: Memory (0x2080000000 length 0x2000000000) Flags=
:0003 Processor Domain:1 Memory Domain:1
> [   11.543369] acpi/hmat: Locality: Flags:00 Type:Read Latency Initiator =
Domains:2 Target Domains:2 Base:100
> [   11.554112] acpi/hmat:   Initiator-Target[0-0]:7600 nsec
> [   11.560075] acpi/hmat:   Initiator-Target[0-1]:13560 nsec
> [   11.566129] acpi/hmat:   Initiator-Target[1-0]:13560 nsec
> [   11.572192] acpi/hmat:   Initiator-Target[1-1]:7600 nsec
> [   11.578157] acpi/hmat: Locality: Flags:00 Type:Write Latency Initiator=
 Domains:2 Target Domains:2 Base:100
> [   11.588996] acpi/hmat:   Initiator-Target[0-0]:7600 nsec
> [   11.594959] acpi/hmat:   Initiator-Target[0-1]:13560 nsec
> [   11.601012] acpi/hmat:   Initiator-Target[1-0]:13560 nsec
> [   11.607074] acpi/hmat:   Initiator-Target[1-1]:7600 nsec
> [   11.613038] acpi/hmat: Locality: Flags:00 Type:Read Bandwidth Initiato=
r Domains:2 Target Domains:2 Base:1
> [   11.623778] acpi/hmat:   Initiator-Target[0-0]:1790 MB/s
> [   11.629734] acpi/hmat:   Initiator-Target[0-1]:1790 MB/s
> [   11.635697] acpi/hmat:   Initiator-Target[1-0]:1790 MB/s
> [   11.641650] acpi/hmat:   Initiator-Target[1-1]:1790 MB/s
> [   11.647611] acpi/hmat: Locality: Flags:00 Type:Write Bandwidth Initiat=
or Domains:2 Target Domains:2 Base:1
> [   11.658448] acpi/hmat:   Initiator-Target[0-0]:1910 MB/s
> [   11.664412] acpi/hmat:   Initiator-Target[0-1]:1910 MB/s
> [   11.670374] acpi/hmat:   Initiator-Target[1-0]:1910 MB/s
> [   11.676336] acpi/hmat:   Initiator-Target[1-1]:1910 MB/s
> [   11.682540] ERST: Error Record Serialization Table (ERST) support is i=
nitialized.
> [   11.690945] pstore: Registered erst as persistent store backend
> [   11.697897] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [   11.705192] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200=
) is a 16550A
> [   11.727945] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200=
) is a 16550A
> [   11.750297] Linux agpgart interface v0.103
> [   11.755095] AMD-Vi: AMD IOMMUv2 functionality not available on this sy=
stem - This is not a bug.
> [   11.768526] i8042: PNP: No PS/2 controller found.
> [   11.773880] mousedev: PS/2 mouse device common for all mice
> [   11.780157] rtc_cmos 00:00: RTC can wake from S4
> [   11.785786] rtc_cmos 00:00: registered as rtc0
> [   11.790856] rtc_cmos 00:00: setting system clock to 2025-05-21T11:44:5=
8 UTC (1747827898)
> [   11.799967] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvr=
am
> [   11.809272] intel_pstate: Intel P-state driver initializing
> [   11.839847] ledtrig-cpu: registered to indicate activity on CPUs
> [   11.855157] NET: Registered PF_INET6 protocol family
> [   11.870454] Segment Routing with IPv6
> [   11.874578] In-situ OAM (IOAM) with IPv6
> [   11.879000] mip6: Mobile IPv6
> [   11.882334] NET: Registered PF_PACKET protocol family
> [   11.888176] mpls_gso: MPLS GSO support
> [   11.905448] microcode: sig=3D0x606a6, pf=3D0x1, revision=3D0xd000404
> [   11.912834] microcode: Microcode Update Driver: v2.2.
> [   11.913779] resctrl: L3 allocation detected
> [   11.924155] resctrl: MB allocation detected
> [   11.928852] resctrl: L3 monitoring detected
> [   11.933552] IPI shorthand broadcast: enabled
> [   11.938370] sched_clock: Marking stable (10253687425, 1684655956)->(12=
547956524, -609613143)
> [   11.949439] registered taskstats version 1
> [   11.954051] Loading compiled-in X.509 certificates
> [   11.980812] Loaded X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f=
6149f3dd27dfcc5cbb419ea1'
> [   11.990594] Loaded X.509 cert 'Debian Secure Boot Signer 2022 - linux:=
 14011249c2675ea8e5148542202005810584b25f'
> [   12.006325] zswap: loaded using pool lzo/zbud
> [   12.011629] Key type .fscrypt registered
> [   12.016037] Key type fscrypt-provisioning registered
> [   12.022073] pstore: Using crash dump compression: deflate
> [   12.034695] Key type encrypted registered
> [   12.039205] AppArmor: AppArmor sha1 policy hashing enabled
> [   12.045371] ima: No TPM chip found, activating TPM-bypass!
> [   12.051532] ima: Allocated hash algorithm: sha256
> [   12.056819] ima: No architecture policies found
> [   12.061913] evm: Initialising EVM extended attributes:
> [   12.067681] evm: security.selinux
> [   12.071392] evm: security.SMACK64 (disabled)
> [   12.076188] evm: security.SMACK64EXEC (disabled)
> [   12.081372] evm: security.SMACK64TRANSMUTE (disabled)
> [   12.087044] evm: security.SMACK64MMAP (disabled)
> [   12.092227] evm: security.apparmor
> [   12.096038] evm: security.ima
> [   12.099370] evm: security.capability
> [   12.103383] evm: HMAC attrs: 0x1
> [   12.136679] tsc: Refined TSC clocksource calibration: 2100.000 MHz
> [   12.143635] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1=
e4530a99b6, max_idle_ns: 440795257976 ns
> [   12.155000] clocksource: Switched to clocksource tsc
> [   12.190642] clk: Disabling unused clocks
> [   12.199014] Freeing unused decrypted memory: 2036K
> [   12.204878] Freeing unused kernel image (initmem) memory: 2800K
> [   12.211519] Write protecting the kernel read-only data: 26624k
> [   12.218617] Freeing unused kernel image (text/rodata gap) memory: 2040K
> [   12.226259] Freeing unused kernel image (rodata/data gap) memory: 1144K
> [   12.242399] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [   12.249635] Run /init as init process
> Loading, please wait...
> Starting systemd-udevd version 252.36-1~deb12u1=0D
> [   12.463681] dca service started, version 1.12.1
> [   12.469221] i801_smbus 0000:00:1f.4: enabling device (0001 -> 0003)
> [   12.476590] i801_smbus 0000:00:1f.4: SPD Write Disable is set
> [   12.483091] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> [   12.496629] ACPI: bus type USB registered
> [   12.501155] usbcore: registered new interface driver usbfs
> [   12.501829] i2c i2c-0: 16/16 memory slots populated (from DMI)
> [   12.507324] usbcore: registered new interface driver hub
> [   12.513865] i2c i2c-0: Systems with more than 4 memory slots not suppo=
rted yet, not instantiating SPD
> [   12.519857] usbcore: registered new device driver usb
> [   12.536624] SCSI subsystem initialized
> [   12.542102] ACPI Warning: \_SB.PC07.QR1C._PRT: Return Package has no e=
lements (empty) (20220331/nsprepkg-94)
> [   12.553503] bnxt_en 0000:98:00.0 (unnamed net_device) (uninitialized):=
 Device requests max timeout of 100 seconds, may trigger hung task watchdog
> [   12.586624] igb: Intel(R) Gigabit Ethernet Network Driver
> [   12.588189] bnxt_en 0000:98:00.0 eth0: Broadcom BCM57414 NetXtreme-E 1=
0Gb/25Gb Ethernet found at mem 206fffe10000, node addr 90:5a:08:00:b7:aa
> [   12.592679] igb: Copyright (c) 2007-2014 Intel Corporation.
> [   12.592796] ACPI Warning: \_SB.PC04.BR4D._PRT:=20
> [   12.607036] bnxt_en 0000:98:00.0: 63.008 Gb/s available PCIe bandwidth=
 (8.0 GT/s PCIe x8 link)
> [   12.613294] Return Package has no elements (empty)
> [   12.618506] ACPI Warning: \_SB.PC07.QR1C._PRT:=20
> [   12.628061]  (20220331/nsprepkg-94)
> [   12.633440] Return Package has no elements (empty) (20220331/nsprepkg-=
94)
> [   12.650210] bnxt_en 0000:98:00.1 (unnamed net_device) (uninitialized):=
 Device requests max timeout of 100 seconds, may trigger hung task watchdog
> [   12.665467] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [   12.671345] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bu=
s number 1
> [   12.680806] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0=
x100 quirks 0x0000000000009810
> [   12.691447] bnxt_en 0000:98:00.1 eth1: Broadcom BCM57414 NetXtreme-E 1=
0Gb/25Gb Ethernet found at mem 206fffe00000, node addr 90:5a:08:00:b7:ab
> [   12.692128] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [   12.705807] bnxt_en 0000:98:00.1: 63.008 Gb/s available PCIe bandwidth=
 (8.0 GT/s PCIe x8 link)
> [   12.713746] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bu=
s number 2
> [   12.730225] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> [   12.737282] igb 0000:4b:00.0: added PHC on eth2
> [   12.742382] igb 0000:4b:00.0: Intel(R) Gigabit Ethernet Network Connec=
tion
> [   12.750104] igb 0000:4b:00.0: eth2: (PCIe:5.0Gb/s:Width x4) 90:5a:08:1=
0:40:a8
> [   12.758196] igb 0000:4b:00.0: eth2: PBA No: 010300-000
> [   12.763959] igb 0000:4b:00.0: Using MSI-X interrupts. 8 rx queue(s), 8=
 tx queue(s)
> [   12.772492] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.01
> [   12.781773] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
> [   12.789882] usb usb1: Product: xHCI Host Controller
> [   12.795359] usb usb1: Manufacturer: Linux 6.1.0-36-amd64 xhci-hcd
> [   12.802201] usb usb1: SerialNumber: 0000:00:14.0
> [   12.807669] ahci 0000:00:11.5: AHCI 0001.0301 32 slots 6 ports 6 Gbps =
0x3f impl SATA mode
> [   12.816854] ahci 0000:00:11.5: flags: 64bit ncq sntf led clo only pio =
slum part ems deso sadm sds apst=20
> [   12.827483] hub 1-0:1.0: USB hub found
> [   12.831710] hub 1-0:1.0: 16 ports detected
> [   12.837700] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.01
> [   12.846981] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
> [   12.848710] bnxt_en 0000:98:00.1 enp152s0f1np1: renamed from eth1
> [   12.855093] usb usb2: Product: xHCI Host Controller
> [   12.855094] usb usb2: Manufacturer: Linux 6.1.0-36-amd64 xhci-hcd
> [   12.855095] usb usb2: SerialNumber: 0000:00:14.0
> [   12.855242] hub 2-0:1.0: USB hub found
> [   12.883694] hub 2-0:1.0: 10 ports detected
> [   12.889135] ACPI Warning: \_SB.PC04.BR4D._PRT: Return Package has no e=
lements (empty) (20220331/nsprepkg-94)
> [   12.900607] nvme nvme0: pci function 0000:65:00.0
> [   12.912765] nvme nvme0: 48/0/0 default/read/poll queues
> [   12.912799] bnxt_en 0000:98:00.0 enp152s0f0np0: renamed from eth0
> [   12.922822] scsi host0: ahci
> [   12.928922] scsi host1: ahci
> [   12.932277] scsi host2: ahci
> [   12.935661] scsi host3: ahci
> [   12.939973] scsi host4: ahci
> [   12.943616] scsi host5: ahci
> [   12.946882] ata1: SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b1=
80100 irq 179
> [   12.955483] ata2: SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b1=
80180 irq 179
> [   12.964083] ata3: SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b1=
80200 irq 179
> [   12.972686] ata4: SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b1=
80280 irq 179
> [   12.981283] ata5: SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b1=
80300 irq 179
> [   12.989880] ata6: SATA max UDMA/133 abar m524288@0x9b180000 port 0x9b1=
80380 irq 179
> [   13.000901] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps =
0xff impl SATA mode
> [   13.010089] ahci 0000:00:17.0: flags: 64bit ncq sntf led clo only pio =
slum part ems deso sadm sds apst=20
> [   13.021021] igb 0000:4b:00.1: added PHC on eth0
> [   13.026120] igb 0000:4b:00.1: Intel(R) Gigabit Ethernet Network Connec=
tion
> [   13.033842] igb 0000:4b:00.1: eth0: (PCIe:5.0Gb/s:Width x4) 90:5a:08:1=
0:40:a9
> [   13.041935] igb 0000:4b:00.1: eth0: PBA No: 010300-000
> [   13.047704] igb 0000:4b:00.1: Using MSI-X interrupts. 8 rx queue(s), 8=
 tx queue(s)
> [   13.137416] scsi host6: ahci
> [   13.140981] scsi host7: ahci
> [   13.144512] scsi host8: ahci
> [   13.148144] scsi host9: ahci
> [   13.151676] scsi host10: ahci
> [   13.155295] scsi host11: ahci
> [   13.158887] scsi host12: ahci
> [   13.162514] scsi host13: ahci
> [   13.165909] ata7: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b1=
00100 irq 238
> [   13.174513] ata8: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b1=
00180 irq 238
> [   13.183128] ata9: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b1=
00200 irq 238
> [   13.191732] ata10: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b=
100280 irq 238
> [   13.200421] ata11: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b=
100300 irq 238
> [   13.209115] ata12: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b=
100380 irq 238
> [   13.217809] ata13: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b=
100400 irq 238
> [   13.226502] ata14: SATA max UDMA/133 abar m524288@0x9b100000 port 0x9b=
100480 irq 238
> [   13.235190] usb 1-1: new high-speed USB device number 2 using xhci_hcd
> [   13.310933] ata6: SATA link down (SStatus 0 SControl 300)
> [   13.317036] ata1: SATA link down (SStatus 0 SControl 300)
> [   13.323134] ata4: SATA link down (SStatus 0 SControl 300)
> [   13.329234] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [   13.336214] ata5: SATA link down (SStatus 0 SControl 300)
> [   13.342313] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [   13.349327] ata2.00: ATA-11: Micron_5400_MTFDDAK1T9TGA,  D4MU002, max =
UDMA/133
> [   13.357485] ata3.00: ATA-11: Micron_5400_MTFDDAK1T9TGA,  D4MU002, max =
UDMA/133
> [   13.368998] ata2.00: 3750748848 sectors, multi 16: LBA48 NCQ (depth 32=
), AA
> [   13.376842] ata3.00: 3750748848 sectors, multi 16: LBA48 NCQ (depth 32=
), AA
> [   13.384681] ata2.00: Features: NCQ-prio
> [   13.389011] ata3.00: Features: NCQ-prio
> [   13.389996] usb 1-1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0107, bcdDevice=3D 1.00
> [   13.398774] ata2.00: configured for UDMA/133
> [   13.402521] usb 1-1: New USB device strings: Mfr=3D3, Product=3D2, Ser=
ialNumber=3D1
> [   13.402526] usb 1-1: Product: USB Virtual Hub
> [   13.402530] usb 1-1: Manufacturer: Aspeed
> [   13.402532] usb 1-1: SerialNumber: 00000000
> [   13.403734] hub 1-1:1.0: USB hub found
> [   13.407378] ata3.00: configured for UDMA/133
> [   13.407716] scsi 1:0:0:0: Direct-Access     ATA      Micron_5400_MTFD =
U002 PQ: 0 ANSI: 5
> [   13.415635] hub 1-1:1.0: 7 ports detected
> [   13.420550] scsi 2:0:0:0: Direct-Access     ATA      Micron_5400_MTFD =
U002 PQ: 0 ANSI: 5
> [   13.546961] ata8: SATA link down (SStatus 0 SControl 300)
> [   13.553064] ata9: SATA link down (SStatus 0 SControl 300)
> [   13.559164] ata14: SATA link down (SStatus 0 SControl 300)
> [   13.565360] ata13: SATA link down (SStatus 0 SControl 300)
> [   13.571554] ata7: SATA link down (SStatus 0 SControl 300)
> [   13.577652] ata12: SATA link down (SStatus 0 SControl 300)
> [   13.583849] ata11: SATA link down (SStatus 0 SControl 300)
> [   13.590046] ata10: SATA link down (SStatus 0 SControl 300)
> [   13.603797] ata2.00: Enabling discard_zeroes_data
> [   13.609124] sd 1:0:0:0: [sda] 3750748848 512-byte logical blocks: (1.9=
2 TB/1.75 TiB)
> [   13.609128] ata3.00: Enabling discard_zeroes_data
> [   13.617830] sd 1:0:0:0: [sda] 4096-byte physical blocks
> [   13.623139] sd 2:0:0:0: [sdb] 3750748848 512-byte logical blocks: (1.9=
2 TB/1.75 TiB)
> [   13.628998] sd 1:0:0:0: [sda] Write Protect is off
> [   13.637684] sd 2:0:0:0: [sdb] 4096-byte physical blocks
> [   13.637704] sd 2:0:0:0: [sdb] Write Protect is off
> [   13.640767] igb 0000:4b:00.0 enp75s0f0: renamed from eth2
> [   13.643094] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
> [   13.654367] sd 1:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
> [   13.660419] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
> [   13.671095] ata2.00: Enabling discard_zeroes_data
> [   13.693055] sd 2:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
> [   13.694489]  sda: sda1 sda2
> [   13.700482] ata3.00: Enabling discard_zeroes_data
> [   13.703371] sd 1:0:0:0: [sda] Attached SCSI disk
> [   13.710056]  sdb: sdb1 sdb2
> [   13.716928] sd 2:0:0:0: [sdb] Attached SCSI disk
> [   13.720668] usb 1-1.1: new high-speed USB device number 3 using xhci_h=
cd
> [   13.728741] igb 0000:4b:00.1 enp75s0f1: renamed from eth0
> [   13.751392] md/raid1:md0: active with 2 out of 2 mirrors
> [   13.757836] md0: detected capacity change from 0 to 3749898240
> [   13.834539] usb 1-1.1: New USB device found, idVendor=3D0557, idProduc=
t=3D9241, bcdDevice=3D 5.04
> [   13.843942] usb 1-1.1: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
> [   13.852158] usb 1-1.1: Product: SMCI HID KM
> [   13.856861] usb 1-1.1: Manufacturer: Linux 5.4.62 with aspeed_vhub
> [   13.868288] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled=
=2E Duplicate IMA measurements will not be recorded in the IMA log.
> [   13.882018] device-mapper: uevent: version 1.0.3
> [   13.887377] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialise=
d: dm-devel@redhat.com
> [   13.902944] hid: raw HID events driver (C) Jiri Kosina
> [   13.921012] usbcore: registered new interface driver usbhid
> [   13.927279] usbhid: USB HID core driver
> [   13.935380] input: Linux 5.4.62 with aspeed_vhub SMCI HID KM as /devic=
es/pci0000:00/0000:00:14.0/usb1/1-1/1-1.1/1-1.1:1.0/0003:0557:9241.0001/inp=
ut/input0
> [   13.944702] usb 1-1.2: new high-speed USB device number 4 using xhci_h=
cd
> [   14.062121] usb 1-1.2: New USB device found, idVendor=3D0b1f, idProduc=
t=3D03ee, bcdDevice=3D 5.04
> [   14.071516] usb 1-1.2: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
> [   14.079732] usb 1-1.2: Product: RNDIS/Ethernet Gadget
> [   14.085409] usb 1-1.2: Manufacturer: Linux 5.4.62 with aspeed_vhub
> [   14.096740] hid-generic 0003:0557:9241.0001: input,hidraw0: USB HID v1=
=2E00 Keyboard [Linux 5.4.62 with aspeed_vhub SMCI HID KM] on usb-0000:00:1=
4.0-1.1/input0
> [   14.112734] input: Linux 5.4.62 with aspeed_vhub SMCI HID KM as /devic=
es/pci0000:00/0000:00:14.0/usb1/1-1/1-1.1/1-1.1:1.1/0003:0557:9241.0002/inp=
ut/input1
> [   14.128440] hid-generic 0003:0557:9241.0002: input,hidraw1: USB HID v1=
=2E00 Mouse [Linux 5.4.62 with aspeed_vhub SMCI HID KM] on usb-0000:00:14.0=
-1.1/input1
> [   14.154649] usbcore: registered new interface driver cdc_ether
> [   14.164737] rndis_host 1-1.2:2.0 usb0: register 'rndis_host' at usb-00=
00:00:14.0-1.2, RNDIS device, be:3a:f2:b6:05:9f
> [   14.176698] usbcore: registered new interface driver rndis_host
> [   14.185226] rndis_host 1-1.2:2.0 enxbe3af2b6059f: renamed from usb0
> Begin: Loading essential drivers ... [   14.304660] raid6: avx512x4 gen()=
 40154 MB/s
> [   14.376660] raid6: avx512x2 gen() 42788 MB/s
> [   14.448660] raid6: avx512x1 gen() 41993 MB/s
> [   14.520670] raid6: avx2x4   gen() 34152 MB/s
> [   14.592670] raid6: avx2x2   gen() 32998 MB/s
> [   14.664669] raid6: avx2x1   gen() 29343 MB/s
> [   14.669462] raid6: using algorithm avx512x2 gen() 42788 MB/s
> [   14.740660] raid6: .... xor() 25888 MB/s, rmw enabled
> [   14.746332] raid6: using avx512x2 recovery algorithm
> [   14.753072] xor: automatically using best checksumming function   avx =
     =20
> [   14.762712] async_tx: api initialized (async)
> done.
> Begin: Running /scripts/init-premount ... Waiting 5s for disks to show up=
 (T131961)
> done.
> Begin: Mounting root file system ... Begin: Running /scripts/local-top ..=
=2E done.
> Begin: Running /scripts/local-premount ... done.
> Begin: Will now check root file system ... fsck from util-linux 2.38.1
> [/sbin/fsck.ext4 (1) -- /dev/mapper/vg0-root] fsck.ext4 -a -C0 /dev/mappe=
r/vg0-root=20
> /dev/mapper/vg0-root: recovering journal
> /dev/mapper/vg0-root: Clearing orphaned inode 266288 (uid=3D0, gid=3D0, m=
ode=3D040700, size=3D4096)
> /dev/mapper/vg0-root: Clearing orphaned inode 266293 (uid=3D0, gid=3D0, m=
ode=3D041777, size=3D4096)
> /dev/mapper/vg0-root: Clearing orphaned inode 4063241 (uid=3D0, gid=3D0, =
mode=3D040700, size=3D4096)
> /dev/mapper/vg0-root: Clearing orphaned inode 4063242 (uid=3D0, gid=3D0, =
mode=3D041777, size=3D4096)
> /dev/mapper/vg0-root: clean, 73795/4890624 files, 2647372/19530752 blocks
> done.
> [   20.239290] EXT4-fs (dm-1): mounted filesystem with ordered data mode.=
 Quota mode: none.
> done.
> Begin: Running /scripts/local-bottom ... done.
> Begin: Running /scripts/init-bottom ... done.
> [   20.296192] Not activating Mandatory Access Control as /sbin/tomoyo-in=
it does not exist.
> [   20.403510] systemd[1]: Inserted module 'autofs4'
> [   20.433586] systemd[1]: systemd 252.36-1~deb12u1 running in system mod=
e (+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPE=
NSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSET=
UP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLI=
B +ZSTD -BPF_FRAMEWORK -XKBCOMMON +UTMP +SYSVINIT default-hierarchy=3Dunifi=
ed)
> [   20.470290] systemd[1]: Detected architecture x86-64.
>=20
> Welcome to =1B[1mDebian GNU/Linux 12 (bookworm)=1B[0m!
> =0D
> [   20.493655] systemd[1]: Hostname set to <mc-misc2002>.
> [   20.678873] systemd[1]: Queued start job for default target graphical.=
target.
> [   20.709823] systemd[1]: Created slice system-getty.slice - Slice /syst=
em/getty.
> [=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39msystem-getty.slice=1B[0m=
 - Slice /system/getty.=0D
> [   20.737219] systemd[1]: Created slice system-modprobe.slice - Slice /s=
ystem/modprobe.
> [=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39msystem-modpr=E2=80=A6lic=
e=1B[0m - Slice /system/modprobe.=0D
> [   20.765167] systemd[1]: Created slice system-serial\x2dgetty.slice - S=
lice /system/serial-getty.
> [=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39msystem-seria=E2=80=A6=1B=
[0m - Slice /system/serial-getty.=0D
> [   20.793149] systemd[1]: Created slice system-systemd\x2dfsck.slice - S=
lice /system/systemd-fsck.
> [=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39msystem-syste=E2=80=A6=1B=
[0m - Slice /system/systemd-fsck.=0D
> [   20.821425] systemd[1]: Created slice user.slice - User and Session Sl=
ice.
> [=1B[0;32m  OK  =1B[0m] Created slice =1B[0;1;39muser.slice=1B[0m - User =
and Session Slice.=0D
> [   20.848892] systemd[1]: Started systemd-ask-password-console.path - Di=
spatch Password Requests to Console Directory Watch.
> [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39msystemd-ask-passwo=E2=80=A6que=
sts to Console Directory Watch.=0D
> [   20.880903] systemd[1]: Started systemd-ask-password-wall.path - Forwa=
rd Password Requests to Wall Directory Watch.
> [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39msystemd-ask-passwo=E2=80=A6 Re=
quests to Wall Directory Watch.=0D
> [   20.913325] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.autom=
ount - Arbitrary Executable File Formats File System Automount Point.
> [=1B[0;32m  OK  =1B[0m] Set up automount =1B[0;1;39mproc-sys-=E2=80=A6rma=
ts File System Automount Point.=0D
> [   20.944841] systemd[1]: Expecting device dev-mapper-vg0\x2dsrv.device =
- /dev/mapper/vg0-srv...
>          Expecting device =1B[0;1;39mdev-mappe=E2=80=A6evice=1B[0m - /dev=
/mapper/vg0-srv...=0D
> [   20.972803] systemd[1]: Expecting device dev-mapper-vg0\x2dswap.device=
 - /dev/mapper/vg0-swap...
>          Expecting device =1B[0;1;39mdev-mappe=E2=80=A6vice=1B[0m - /dev/=
mapper/vg0-swap...=0D
> [   21.000809] systemd[1]: Expecting device dev-ttyS1.device - /dev/ttyS1=
=2E..
>          Expecting device =1B[0;1;39mdev-ttyS1.device=1B[0m - /dev/ttyS1.=
=2E.=0D
> [   21.024815] systemd[1]: Reached target cryptsetup.target - Local Encry=
pted Volumes.
> [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mcryptsetup.=E2=80=A6get=
=1B[0m - Local Encrypted Volumes.=0D
> [   21.052855] systemd[1]: Reached target integritysetup.target - Local I=
ntegrity Protected Volumes.
> [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mintegrityse=E2=80=A6Loc=
al Integrity Protected Volumes.=0D
> [   21.080868] systemd[1]: Reached target nss-lookup.target - Host and Ne=
twork Name Lookups.
> [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mnss-lookup.=E2=80=A6m -=
 Host and Network Name Lookups.=0D
> [   21.108834] systemd[1]: Reached target paths.target - Path Units.
> [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mpaths.target=1B[0m - Pa=
th Units.=0D
> [   21.132844] systemd[1]: Reached target remote-fs.target - Remote File =
Systems.
> [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mremote-fs.target=1B[0m =
- Remote File Systems.=0D
> [   21.160826] systemd[1]: Reached target slices.target - Slice Units.
> [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mslices.target=1B[0m - S=
lice Units.=0D
> [   21.184876] systemd[1]: Reached target veritysetup.target - Local Veri=
ty Protected Volumes.
> [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mveritysetup=E2=80=A6 - =
Local Verity Protected Volumes.=0D
> [   21.213000] systemd[1]: Listening on dm-event.socket - Device-mapper e=
vent daemon FIFOs.
> [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mdm-event.sock=E2=80=A6 De=
vice-mapper event daemon FIFOs.=0D
> [   21.241069] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll =
daemon socket.
> [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39mlvm2-lvmpolld=E2=80=A6ket=
=1B[0m - LVM2 poll daemon socket.=0D
> [   21.269082] systemd[1]: Listening on syslog.socket - Syslog Socket.
> [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39msyslog.socket=1B[0m - Sys=
log Socket.=0D
> [   21.293073] systemd[1]: Listening on systemd-fsckd.socket - fsck to fs=
ckd communication Socket.
> [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39msystemd-fsckd=E2=80=A6sck=
 to fsckd communication Socket.=0D
> [   21.321003] systemd[1]: Listening on systemd-initctl.socket - initctl =
Compatibility Named Pipe.
> [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39msystemd-initc=E2=80=A6 in=
itctl Compatibility Named Pipe.=0D
> [   21.349546] systemd[1]: Listening on systemd-journald-audit.socket - J=
ournal Audit Socket.
> [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39msystemd-journ=E2=80=A6soc=
ket=1B[0m - Journal Audit Socket.=0D
> [   21.377058] systemd[1]: Listening on systemd-journald-dev-log.socket -=
 Journal Socket (/dev/log).
> [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39msystemd-journ=E2=80=A6t=
=1B[0m - Journal Socket (/dev/log).=0D
> [   21.405141] systemd[1]: Listening on systemd-journald.socket - Journal=
 Socket.
> [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39msystemd-journald.socket=
=1B[0m - Journal Socket.=0D
> [   21.433476] systemd[1]: Listening on systemd-udevd-control.socket - ud=
ev Control Socket.
> [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39msystemd-udevd=E2=80=A6.so=
cket=1B[0m - udev Control Socket.=0D
> [   21.461063] systemd[1]: Listening on systemd-udevd-kernel.socket - ude=
v Kernel Socket.
> [=1B[0;32m  OK  =1B[0m] Listening on =1B[0;1;39msystemd-udevd=E2=80=A6l.s=
ocket=1B[0m - udev Kernel Socket.=0D
> [   21.504942] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File=
 System...
>          Mounting =1B[0;1;39mdev-hugepages.mount=1B[0m - Huge Pages File =
System...=0D
> [   21.534716] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queu=
e File System...
>          Mounting =1B[0;1;39mdev-mqueue.mount=1B=E2=80=A6POSIX Message Qu=
eue File System...=0D
> [   21.562769] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug=
 File System...
>          Mounting =1B[0;1;39msys-kernel-debug.=E2=80=A6=1B[0m - Kernel De=
bug File System...=0D
> [   21.589820] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Tra=
ce File System...
>          Mounting =1B[0;1;39msys-kernel-tracin=E2=80=A6=1B[0m - Kernel Tr=
ace File System...=0D
> [   21.616864] systemd[1]: Finished blk-availability.service - Availabili=
ty of block devices.
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mblk-availability.=E2=80=A6m -=
 Availability of block devices.=0D
> [   21.661075] systemd[1]: Starting kmod-static-nodes.service - Create Li=
st of Static Device Nodes...
>          Starting =1B[0;1;39mkmod-static-nodes=E2=80=A6ate List of Static=
 Device Nodes...=0D
> [   21.690850] systemd[1]: Starting lvm2-monitor.service - Monitoring of =
LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
>          Starting =1B[0;1;39mlvm2-monitor.serv=E2=80=A6ng dmeventd or pro=
gress polling...=0D
> [   21.723061] systemd[1]: Starting modprobe@configfs.service - Load Kern=
el Module configfs...
>          Starting =1B[0;1;39mmodprobe@configfs=E2=80=A6m - Load Kernel Mo=
dule configfs...=0D
> [   21.751010] systemd[1]: Starting modprobe@dm_mod.service - Load Kernel=
 Module dm_mod...
>          Starting =1B[0;1;39mmodprobe@dm_mod.s=E2=80=A6[0m - Load Kernel =
Module dm_mod...=0D
> [   21.779199] systemd[1]: Starting modprobe@drm.service - Load Kernel Mo=
dule drm...
>          Starting =1B[0;1;39mmodprobe@drm.service=1B[0m - Load Kernel Mod=
ule drm...=0D
> [   21.807289] systemd[1]: Starting modprobe@efi_pstore.service - Load Ke=
rnel Module efi_pstore...
>          Starting =1B[0;1;39mmodprobe@efi_psto=E2=80=A6- Load Kernel Modu=
le efi_pstore...=0D
> [   21.838993] systemd[1]: Starting modprobe@fuse.service - Load Kernel M=
odule fuse...
>          Starting =1B[0;1;39mmodprobe@fuse.ser=E2=80=A6e=1B[0m - Load Ker=
nel Module fuse...=0D
> [   21.857689] ACPI: bus type drm_connector registered
> [   21.857819] fuse: init (API version 7.38)
> [   21.870103] systemd[1]: Starting modprobe@loop.service - Load Kernel M=
odule loop...
>          Starting =1B[0;1;39mmodprobe@loop.ser=E2=80=A6e=1B[0m - Load Ker=
nel Module loop...=0D
> [   21.887418] loop: module loaded
> [   21.897068] systemd[1]: systemd-fsck-root.service - File System Check =
on Root Device was skipped because of an unmet condition check (ConditionPa=
thExists=3D!/run/initramfs/fsck-root).
> [   21.941108] systemd[1]: Starting systemd-journald.service - Journal Se=
rvice...
>          Starting =1B[0;1;39msystemd-journald.service=1B[0m - Journal Ser=
vice...=0D
> [   21.967495] systemd[1]: Starting systemd-modules-load.service - Load K=
ernel Modules...
>          Starting =1B[0;1;39msystemd-modules-l=E2=80=A6rvice=1B[0m - Load=
 Kernel Modules...=0D
> [   21.994553] systemd[1]: Starting systemd-remount-fs.service - Remount =
Root and Kernel File Systems...
>          Startin[   22.006176] EXT4-fs (dm-1): re-mounted. Quota mode: no=
ne.
> g =1B[0;1;39msystemd-remount-f=E2=80=A6nt Root and Kernel File Systems...=
=0D
> [   22.019396] IPMI message handler: version 39.2
> [   22.026905] ipmi device interface
> [   22.032449] systemd[1]: Starting systemd-udev-trigger.service - Coldpl=
ug All udev Devices...
>          Starting =1B[0;1;39msystemd-udev-trig=E2=80=A6[0m - Coldplug All=
 udev Devices...=0D
> [   22.063603] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File =
System.
> [=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mdev-hugepages.mount=1B[0m - Hu=
ge Pages File System.=0D
> [   22.088897] systemd[1]: Started systemd-journald.service - Journal Ser=
vice.
> [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39msystemd-journald.service=1B[0m=
 - Journal Service.=0D
> [=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mdev-mqueue.mount=1B[=E2=80=A6-=
 POSIX Message Queue File System.=0D
> [=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39msys-kernel-debug.m=E2=80=A6nt=
=1B[0m - Kernel Debug File System.=0D
> [=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39msys-kernel-tracing=E2=80=A6nt=
=1B[0m - Kernel Trace File System.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mkmod-static-nodes=E2=80=A6rea=
te List of Static Device Nodes.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mlvm2-monitor.serv=E2=80=A6sin=
g dmeventd or progress polling.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mmodprobe@configfs=E2=80=A6[0m=
 - Load Kernel Module configfs.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mmodprobe@dm_mod.s=E2=80=A6e=
=1B[0m - Load Kernel Module dm_mod.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mmodprobe@drm.service=1B[0m - =
Load Kernel Module drm.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mmodprobe@efi_psto=E2=80=A6m -=
 Load Kernel Module efi_pstore.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mmodprobe@fuse.service=1B[0m -=
 Load Kernel Module fuse.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mmodprobe@loop.service=1B[0m -=
 Load Kernel Module loop.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39msystemd-modules-l=E2=80=A6ser=
vice=1B[0m - Load Kernel Modules.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39msystemd-remount-f=E2=80=A6oun=
t Root and Kernel File Systems.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39msystemd-udev-trig=E2=80=A6e=
=1B[0m - Coldplug All udev Devices.=0D
>          Mounting =1B[0;1;39msys-fs-fuse-conne=E2=80=A6=1B[0m - FUSE Cont=
rol File System...=0D
>          Mounting =1B[0;1;39msys-kernel-config=E2=80=A6ernel Configuratio=
n File System...=0D
>          Starting =1B[0;1;39mifupdown-pre.serv=E2=80=A6ynchronize boot up=
 for ifupdown...=0D
>          Starting =1B[0;1;39msystemd-journal-f=E2=80=A6h Journal to Pers[=
   22.476613] systemd-journald[774]: Received client request to flush runti=
me journal.
> istent Storage...=0D
>          Starting =1B[0;1;39msystemd-pstore.se=E2=80=A6orm Persistent Sto=
rage Archival..[   22.509248] BUG: unable to handle page fault for address:=
 ff2c5dfa7ab59000
> [   22.517145] #PF: supervisor write access in kernel mode
> [   22.523011] #PF: error_code(0x0003) - permissions violation
> [   22.529258] PGD 3f3d001067 P4D 3f3d002067 PUD 1001b9063 PMD 3f3befc063=
 PTE 8000003f3ab59161
> [   22.538638] Oops: 0003 [#1] PREEMPT SMP NOPTI
> [   22.543531] CPU: 19 PID: 788 Comm: systemd-pstore Not tainted 6.1.0-36=
-amd64 #1  Debian 6.1.139-1
> [   22.553495] Hardware name: Supermicro SYS-120C-TN10R/X12DDW-A6, BIOS 1=
=2E9 01/11/2024
> [   22.562093] RIP: 0010:clear_page_erms+0x7/0x10
> [   22.567088] Code: 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 8=
9 47 38 48 8d 7f 40 75 d9 90 e9 c3 c3 41 00 0f 1f 00 b9 00 10 00 00 31 c0 <=
f3> aa c3 cc cc cc cc 66 90 89 c8 48 c1 e9 03 74 18 0f 1f 84 00 00
> [   22.588167] RSP: 0018:ff4375fa8ee4f488 EFLAGS: 00010246
> [   22.594035] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000=
0001000
> [   22.602047] RDX: ffd75b767cead640 RSI: ffd75b767cead680 RDI: ff2c5dfa7=
ab59000
> [   22.610060] RBP: ff2c5dfb3f7f7a00 R08: 0000000000000000 R09: 000000000=
1f5e235
> [   22.618073] R10: ff4375fa8ee4f588 R11: ff2c5dfb3f7f7a18 R12: 000000000=
0000000
> [   22.626084] R13: ff2c5dfbbffd4c00 R14: ff2c5dfbbffd5e00 R15: ffd75b767=
cead640
> [   22.634095] FS:  00007fe3c6d44440(0000) GS:ff2c5dfb3f7c0000(0000) knlG=
S:0000000000000000
> [. =0D =0D=20
> 22.643181S:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   22.649738] CR2: ff2c5dfa7ab59000 CR3: 00000020b25fc004 CR4: 000000000=
0771ee0
> [   22.657749] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   22.665765] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   22.665766] PKRU: 55555554
> [   22.665767] Call Trace:
>          Starting =1B[0;1;39msystemd-random-se=E2=80=A6ice=1B[0m - Load/S=
ave Random Seed...=0D
> [   22.665770]  <TASK>
> [   22.665771]  get_page_from_freelist+0xe24/0x11b0
> [   22.695309]  ? xas_store+0x2de/0x620
> [   22.699328]  ? __filemap_add_folio+0x28e/0x4b0
> [   22.704323]  __alloc_pages+0x1dc/0x330
> [   22.708537]  folio_alloc+0x17/0x50
> [   22.708542]  __filemap_get_folio+0x155/0x340
>          Starting =1B[0;1;39msystemd-sysctl.se=E2=80=A6ce=1B[0m - Apply K=
ernel Variables...=0D
> [   22.708550]  ? ext4_mb_init_cache+0x5b5/0x660 [ext4]
> [   22.708597]  pagecache_get_page+0x11/0x60
> [   22.708601]  ext4_mb_init_group+0x172/0x390 [ext4]
> [   22.740890]  ext4_mb_prefetch_fini+0xa4/0xd0 [ext4]
> [   22.746392]  ext4_mb_regular_allocator+0x5bf/0xda0 [ext4]
> [   22.746418]  ext4_mb_new_blocks+0x82f/0x11f0 [ext4]
> [   22.746444]  ? ext4_find_extent+0x3d3/0x430 [ext4]
>          Startin[   22.763364]  ext4_ext_map_blocks+0x66a/0x19b0 [ext4]
> [   22.770502]  ? ext4_ext_map_blocks+0x2ac/0x19b0 [ext4]
> [   22.776295]  ? ext4_mark_iloc_dirty+0x222/0x6c0 [ext4]
> [   22.782091]  ext4_map_blocks+0x1b6/0x5f0 [ext4]
> [   22.787205]  ext4_getblk+0x9a/0x230 [ext4]
> [   22.791830]  ext4_bread+0xb/0x70 [ext4]
> [   22.796159]  ext4_append+0xa5/0x1b0 [ext4]
> [   22.800785]  ext4_init_new_dir+0xd4/0x170 [ext4]
> [   22.805997]  ext4_mkdir+0x10f/0x330 [ext4]
> [   22.810622]  vfs_mkdir+0x9f/0x140
> [   22.814349]  do_mkdirat+0x142/0x170
> [   22.818270]  __x64_sys_mkdirat+0x47/0x80
> [   22.822676]  do_syscall_64+0x55/0xb0
> [   22.826695]  ? __do_sys_newfstatat+0x4e/0x80
> [   22.831493]  ? exit_to_user_mode_prepare+0x40/0x1e0
> [   22.836976]  ? syscall_exit_to_user_mode+0x1e/0x40
> [   22.842360]  ? do_syscall_64+0x61/0xb0
> [   22.846573]  ? exit_to_user_mode_prepare+0x40/0x1e0
> [   22.852051]  ? syscall_exit_to_user_mode+0x1e/0x40
> [g   =1B [202;.18;5? do_syscall_64+0x61/0xb0
> md-sysusers.=E2=80=A6rvice=1B[0m - Create System Users...=0D
> [   22.866806]  ? exit_to_user_mode_prepare+0x40/0x1e0
> [   22.872284]  ? syscall_exit_to_user_mode+0x1e/0x40
> [   22.877666]  ? do_syscall_64+0x61/0xb0
> [   22.881877]  ? syscall_exit_to_user_mode+0x1e/0x40
> [   22.887258]  ? do_syscall_64+0x61/0xb0
> [   22.887260]  ? exit_to_user_mode_prepare+0x40/0x1e0
> [   22.887263]  ? syscall_exit_to_user_mode+0x1e/0x40
> [=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39msys-fs-fuse-connec=E2=80=A6nt=
=1B[0m - FUSE Control File System.=0D
> [   22.887264]  ? do_syscall_64+0x61/0xb0
> [   22.887267]  ? clear_bhb_loop+0x30/0x80
> [   22.887271]  ? clear_bhb_loop+0x30/0x80
> [   22.887274]  ? clear_bhb_loop+0x30/0x80
> [   22.887276]  ? clear_bhb_loop+0x30/0x80
> [   22.887279]  ? clear_bhb_loop+0x30/0x80
> [   22.887282]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   22.887285] RIP: 0033:0x7fe3c6916f17
> [   22.887288] Code: 73 01 c3 48 8b 0d e9 9e 0d 00 f7 d8 64 89 01 48 83 c=
8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 02 01 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b9 9e 0d 00 f7 d8 64 89 01 48
> [   22.887289] RSP: 002b:00007ffc6671af38 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000102
> [   22.887292] RAX: ffffffffffffffda RBX: 00007ffc6671b060 RCX: 00007fe3c=
6916f17
> [   22.887293] RDX: 00000000000001ed RSI: 00007ffc6671b060 RDI: 00000000f=
fffff9c
> [   22.887294] RBP: 00007fe3c6b8f5a0 R08: 0000000000000002 R09: 00007fe3c=
6b8f5a0
> [   22.887295] R10: 00007ffc6671b078 R11: 0000000000000202 R12: 000000000=
00001ed
> [   22.887296] R13: 0000000000000002 R14: 00000000ffffffff R15: 00007ffc6=
671af80
> [   22.887298]  </TASK>
> [   22.887299] Modules linked in: ipmi_devintf ipmi_msghandler nf_conntra=
ck nf_defrag_ipv6 nf_defrag_ipv4 loop fuse efi_pstore drm configfs ip_table=
s x_tables autofs4 ext4 crc16 mbcache jbd2 raid10 raid456 async_raid6_recov=
 async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_gen=
eric raid0 multipath linear rndis_host cdc_ether usbnet mii hid_generic usb=
hid hid dm_mod raid1 md_mod sd_mod nvme ahci nvme_core t10_pi libahci xhci_=
pci crc64_rocksoft crc64 libata xhci_hcd igb crc_t10dif crc32_pclmul bnxt_e=
n usbcore scsi_mod crc32c_intel crct10dif_generic i2c_algo_bit i2c_i801 crc=
t10dif_pclmul dca crct10dif_common i2c_smbus usb_common scsi_common
> [   23.019191] CR2: ff2c5dfa7ab59000
> [   23.019192] ---[ end trace 0000000000000000 ]---
> [   23.080992] RIP: 0010:clear_page_erms+0x7/0x10
> [=1B[0;32m  OK  =1B[[   23.153735] Code: 48 89 47 18 48 89 47 20 48 89 47=
 28 48 89 47 30 48 89 47 38 48 8d 7f 40 75 d9 90 e9 c3 c3 41 00 0f 1f 00 b9=
 00 10 00 00 31 c0 <f3> aa c3 cc cc cc cc 66 90 89 c8 48 c1 e9 03 74 18 0f =
1f 84 00 00
> 0m] Mounted =1B[0;[   23.176378] RSP: 0018:ff4375fa8ee4f488 EFLAGS: 00010=
246
> [   23.183805] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000=
0001000
> [   23.191817] RDX: ffd75b767cead640 RSI: ffd75b767cead680 RDI: ff2c5dfa7=
ab59000
> [   23.199830] RBP: ff2c5dfb3f7f7a00 R08: 0000000000000000 R09: 000000000=
1f5e235
> [   23.207843] R10: ff4375fa8ee4f588 R11: ff2c5dfb3f7f7a18 R12: 000000000=
0000000
> [   23.215857] R13: ff2c5dfbbffd4c00 R14: ff2c5dfbbffd5e00 R15: ffd75b767=
cead640
> [   23.223868] FS:  00007fe3c6d44440(0000) GS:ff2c5dfb3f7c0000(0000) knlG=
S:0000000000000000
> [   23.232953] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   23.239405] CR2: ff2c5dfa7ab59000 CR3: 00000020b25fc004 CR4: 000000000=
0771ee0
> [   23.247418] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   23.255431] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   23.263444] PKRU: 55555554
> [   23.266484] note: systemd-pstore[788] exited with irqs disabled
> 1;39msys-kernel-config.=E2=80=A6 Kernel Configuration File System.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39mifupdown-pre.serv=E2=80=A6 sy=
nchronize boot up for ifupdown.=0D
> [=1B[0;1;31mFAILED=1B[0m] Failed to start =1B[0;1;39msystemd-ps=E2=80=A6t=
form Persistent Storage Archival.=0D
> See 'systemctl status systemd-pstore.service' for details.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39msystemd-sysctl.service=1B[0m =
- Apply Kernel Variables.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39msystemd-sysusers.service=1B[0=
m - Create System Users.=0D
>          Starting =1B[0;1;39msystemd-tmpfiles-=E2=80=A6ate Static Device =
Nodes in /dev...=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39msystemd-tmpfiles-=E2=80=A6rea=
te Static Device Nodes in /dev.=0D
> [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mlocal-fs-pr=E2=80=A6rep=
aration for Local File Systems.=0D
>          Starting =1B[0;1;39msystemd-udevd.ser=E2=80=A6ger for Device Eve=
nts and Files...=0D
> [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39msystemd-udevd.serv=E2=80=A6nag=
er for Device Events and Files.=0D
> [=1B[0;32m  OK  =1B[0m] Found device =1B[0;1;39mdev-ttyS1.device=1B[0m - =
/dev/ttyS1.=0D
> [=1B[0;32m  OK  =1B[0m] Found device =1B[0;1;39mdev-mapper-vg=E2=80=A6.de=
vice=1B[0m - /dev/mapper/vg0-srv.=0D
> [=1B[0;32m  OK  =1B[0m] Found device =1B[0;1;39mdev-mapper-vg=E2=80=A6dev=
ice=1B[0m - /dev/mapper/vg0-swap.=0D
> [   23.631537] BUG: unable to handle page fault for address: ff2c5ddbd689=
6000
> [   23.639260] #PF: supervisor write access in kernel mode
> [   23.645127] #PF: error_code(0x0003) - permissions violation
> [   23.651385] PGD 3f3d001067 P4D 3f3d002067 PUD 208002f063 PMD 20969fa06=
3 PTE 8000002096896161
> [   23.660864] Oops: 0003 [#2] PREEMPT SMP NOPTI
> [   23.665754] CPU: 20 PID: 906 Comm: (udev-worker) Tainted: G      D    =
        6.1.0-36-amd64 #1  Debian 6.1.139-1
> [   23.677273] Hardware name: Supermicro SYS-120C-TN10R/X12DDW-A6, BIOS 1=
=2E9 01/11/2024
> [   23.685869] RIP: 0010:clear_page_erms+0x7/0x10
> [   23.690859] Code: 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 8=
9 47 38 48 8d 7f 40 75 d9 90 e9 c3 c3 41 00 0f 1f 00 b9 00 10 00 00 31 c0 <=
f3> aa c3 cc cc cc cc 66 90 89 c8 48 c1 e9 03 74 18 0f 1f 84 00 00
> [   23.711935] RSP: 0018:ff4375faa0d537d8 EFLAGS: 00010246
> [   23.717799] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000=
0001000
> [   23.725808] RDX: ffd75b76025a2580 RSI: ffd75b76025a25c0 RDI: ff2c5ddbd=
6896000
> [   23.733816] RBP: ff2c5dfb3f837a00 R08: 0000000000000000 R09: 000000000=
1f594b5
> [   23.741827] R10: ff4375faa0d538d8 R11: ff2c5dfb3f837a18 R12: 000000000=
0000000
> [   23.749840] R13: ff2c5dfbbffd4c00 R14: ff2c5dfbbffd5e00 R15: ffd75b760=
25a2580
> [   23.757848] FS:  00007fd6888ee8c0(0000) GS:ff2c5dfb3f800000(0000) knlG=
S:0000000000000000
> [   23.766932] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   23.773387] CR2: ff2c5ddbd6896000 CR3: 0000002096ef8006 CR4: 000000000=
0771ee0
> [   23.781389] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   23.789402] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   23.797412] PKRU: 55555554
> [   23.800439] Call Trace:
> [   23.803184]  <TASK>
> [   23.805528]  get_page_from_freelist+0xe24/0x11b0
> [   23.810718]  __alloc_pages+0x1dc/0x330
> [   23.814927]  allocate_slab+0x334/0x490
> [   23.819136]  ___slab_alloc+0x39a/0x9a0
> [   23.823334]  ? kernfs_fop_open+0x300/0x380
> [   23.827936]  __kmem_cache_alloc_node+0x110/0x2a0
> [   23.833118]  ? kernfs_fop_open+0x300/0x380
> [   23.837718]  kmalloc_trace+0x26/0x90
> [   23.841733]  kernfs_fop_open+0x300/0x380
> [   23.846127]  ? kernfs_fop_write_iter+0x1f0/0x1f0
> [   23.851300]  do_dentry_open+0x1e5/0x410
> [   23.855607]  path_openat+0xb7d/0x1260
> [   23.859716]  ? ____sys_recvmsg+0xf5/0x1a0
> [   23.864220]  do_filp_open+0xaf/0x160
> [   23.868233]  do_sys_openat2+0xaf/0x170
> [   23.872441]  __x64_sys_openat+0x6a/0xa0
> [   23.876746]  do_syscall_64+0x55/0xb0
> [   23.880762]  ? __x64_sys_getrandom+0x94/0x100
> [   23.885655]  ? exit_to_user_mode_prepare+0x40/0x1e0
> [   23.891134]  ? syscall_exit_to_user_mode+0x1e/0x40
> [   23.896509]  ? do_syscall_64+0x61/0xb0
> [   23.900716]  ? ksys_write+0xb7/0xf0
> [   23.904630]  ? exit_to_user_mode_prepare+0x40/0x1e0
> [   23.910106]  ? syscall_exit_to_user_mode+0x1e/0x40
> [   23.915483]  ? clear_bhb_loop+0x30/0x80
> [   23.919789]  ? clear_bhb_loop+0x30/0x80
> [   23.924095]  ? clear_bhb_loop+0x30/0x80
> [   23.928401]  ? clear_bhb_loop+0x30/0x80
> [   23.928673] ipmi_si IPI0001:00: The BMC does not support clearing the =
recv irq bit, compensating, but the BMC needs to be fixed.
> [   23.932706]  ? clear_bhb_loop+0x30/0x80
> [   23.932708]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   23.955667] RIP: 0033:0x7fd688ad613f
> [   23.959683] Code: 24 38 31 c0 f6 c2 40 75 4a 89 d0 45 31 d2 25 00 00 4=
1 00 3d 00 00 41 00 74 39 80 3d a2 24 0e 00 00 74 5d b8 01 01 00 00 0f 05 <=
48> 3d 00 f0 ff ff 0f 87 9d 00 00 00 48 8b 54 24 38 64 48 2b 14 25
> [   23.980760] RSP: 002b:00007ffcda5a1be0 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000101
> [   23.989266] RAX: ffffffffffffffda RBX: 0000559bf0949610 RCX: 00007fd68=
8ad613f
> [   23.997265] RDX: 0000000000080100 RSI: 00007ffcda5a1c90 RDI: 00000000f=
fffff9c
> [   24.005275] RBP: ffffffffffffffff R08: efe9bdf36f2c651c R09: f428cf7c5=
bbf5f9f
> [   24.013276] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffcd=
a5a1d10
> [   24.021276] R13: 00007ffcda5a1d00 R14: 0000559bf0949610 R15: 000000000=
0000000
> [   24.029288]  </TASK>
> [   24.031740] Modules linked in: intel_vsec acpi_ipmi ipmi_si(+) acpi_pa=
d evdev joydev pcc_cpufreq(-) sg button ipmi_devintf ipmi_msghandler nf_con=
ntrack nf_defrag_ipv6 nf_defrag_ipv4 loop fuse efi_pstore drm configfs ip_t=
ables x_tables autofs4 ext4 crc16 mbcache jbd2 raid10 raid456 async_raid6_r=
ecov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c=
_generic raid0 multipath linear rndis_host cdc_ether usbnet mii hid_generic=
 usbhid hid dm_mod raid1 md_mod sd_mod nvme ahci nvme_core t10_pi libahci x=
hci_pci crc64_rocksoft crc64 libata xhci_hcd igb crc_t10dif crc32_pclmul bn=
xt_en usbcore scsi_mod crc32c_intel crct10dif_generic i2c_algo_bit i2c_i801=
 crct10dif_pclmul dca crct10dif_common i2c_smbus usb_common scsi_common
> [   24.038474] ipmi_si IPI0001:00: IPMI message handler: Found new BMC (m=
an_id: 0x002a7c, prod_id: 0x1b58, dev_id: 0x20)
> [   24.104536] CR2: ff2c5ddbd6896000
> [   24.104537] ---[ end trace 0000000000000000 ]---
> [   24.163557] RIP: 0010:clear_page_erms+0x7/0x10
> [   24.184672] Code: 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 8=
9 47 38 48 8d 7f 40 75 d9 90 e9 c3 c3 41 00 0f 1f 00 b9 00 10 00 00 31 c0 <=
f3> aa c3 cc cc cc cc 66 90 89 c8 48 c1 e9 03 74 18 0f 1f 84 00 00
> [   24.205750] RSP: 0018:ff4375fa8ee4f488 EFLAGS: 00010246
> [   24.211626] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000=
0001000
> [   24.219634] RDX: ffd75b767cead640 RSI: ffd75b767cead680 RDI: ff2c5dfa7=
ab59000
> [   24.219646] ipmi_si IPI0001:00: IPMI kcs interface initialized
> [   24.227643] RBP: ff2c5dfb3f7f7a00 R08: 0000000000000000 R09: 000000000=
1f5e235
> [   24.227644] R10: ff4375fa8ee4f588 R11: ff2c5dfb3f7f7a18 R12: 000000000=
0000000
> [   24.227645] R13: ff2c5dfbbffd4c00 R14: ff2c5dfbbffd5e00 R15: ffd75b767=
cead640
> [   24.227646] FS:  00007fd6888ee8c0(0000) GS:ff2c5dfb3f800000(0000) knlG=
S:0000000000000000
> [   24.227647] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   24.273735] CR2: ff2c5ddbd6896000 CR3: 0000002096ef8006 CR4: 000000000=
0771ee0
> [   24.281744] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   24.289753] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   24.297761] PKRU: 55555554
> [   24.300798] note: (udev-worker)[906] exited with irqs disabled
>          Activating swap =1B[0;1;39mdev-mapper=E2=80=A6s[   24.345274] Ad=
ding 999420k swap on /dev/mapper/vg0-swap.  Priority:-2 extents:1 across:99=
9420k SSFS
> wap=1B[0m - /dev/mapper/vg0-swap...=0D
> [   24.370043] input: PC Speaker as /devices/platform/pcspkr/input/input3
> [=1B[0;32m  OK  =1B[[   24.378261] RAPL PMU: API unit is 2^-32 Joules, 2 =
fixed counters, 655360 ms ovfl timer
> 0m] Started =1B[0;[   24.387935] RAPL PMU: hw unit of domain package 2^-1=
4 Joules
> 1;39mmdmonitor.s[   24.395849] RAPL PMU: hw unit of domain dram 2^-16 Jou=
les
> ervice=1B[0m - MD array monitor.=0D
> [   24.409610] ipmi_ssif: IPMI SSIF Interface driver
> [   24.415749] ioatdma: Intel(R) QuickData Technology Driver 5.00
> [   24.422776] cryptd: max_cpu_qlen set to 1000
>          Startin[   24.428787] iTCO_vendor_support: vendor-support=3D0
> g =1B[0;1;39msystemd-fsck@dev-=E2=80=A6em Check on /dev/mapper/vg0-srv...=
=0D
> [   24.444396] mei_me 0000:00:16.0: Device doesn't have valid ME Interface
> [   24.453843] iTCO_wdt iTCO_wdt: unable to reset NO_REBOOT flag, device =
disabled by hardware/BIOS
> [=1B[0;32m  OK  =1B[0m] Activated swap =1B[0;1;39mdev-mapper-=E2=80=A6p.s=
wap[   24.469932] AVX2 version of gcm_enc/dec engaged.
> =1B[0m - /dev/mapp[   24.475658] AES CTR mode by8 optimization enabled
> er/vg0-swap.=0D
> [=1B[0;32m  OK  =1B[0m] Reached target =1B[0;1;39mswap.target=1B[0m - Swa=
ps.=0D
> [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39msystemd-fsckd.serv=E2=80=A6tem=
 Check Daemon to report status.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39msystemd-fsck@dev-=E2=80=A6ste=
m Check on /dev/mapper/vg0-srv.=0D
> [   24.519594] ast 0000:04:00.0: [drm] P2A bridge disabled, using default=
 configuration
> [   24.528319] ast 0000:04:00.0: [drm] AST 2600 detected
>          Mounting =1B[0;1;39msrv.mount=1B[0m - /srv...=0D
> [   24.553336] EXT4-fs (dm-2): mounted filesystem with ordered data mode.=
 Quota mode: none.
> [=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39msrv.mount=1B[0m - /srv.=0D
> [=1B[0;32m  OK  =1B[0m] Reached targ[   24.583150] EDAC i10nm: No hbm mem=
ory
> et =1B[0;1;39mloca[   24.588333] EDAC MC0: Giving out device to module i1=
0nm_edac controller Intel_10nm Socket#0 IMC#0: DEV 0000:7e:0c.0 (INTERRUPT)
> l-fs.target=1B[0m [   24.602745] EDAC MC1: Giving out device to module i1=
0nm_edac controller Intel_10nm Socket#0 IMC#1: DEV 0000:7e:0d.0 (INTERRUPT)
> - Local File Sys[   24.617208] EDAC MC2: Giving out device to module i10n=
m_edac controller Intel_10nm Socket#0 IMC#2: DEV 0000:7e:0e.0 (INTERRUPT)
> tems.=0D
> [   24.631664] EDAC MC3: Giving out device to module i10nm_edac controlle=
r Intel_10nm Socket#0 IMC#3: DEV 0000:7e:0f.0 (INTERRUPT)
> [   24.644670] ast 0000:04:00.0: [drm] Using analog VGA
> [   24.645328] EDAC MC4: Giving out device to module i10nm_edac controlle=
r Intel_10nm Socket#1 IMC#0: DEV 0000:fe:0c.0 (INTERRUPT)
> [   24.650871] ast 0000:04:00.0: [drm] dram MCLK=3D396 Mhz type=3D1 bus_w=
idth=3D16
> [   24.663787] EDAC MC5: Giving out device to module i10nm_edac controlle=
r Intel_10nm Socket#1 IMC#1: DEV 0000:fe:0d.0 (INTERRUPT)
> [   24.671663] [drm] Initialized ast 0.1.0 20120228 for 0000:04:00.0 on m=
inor 0
> [   24.684310] EDAC MC6: Giving out device to module i10nm_edac controlle=
r Intel_10nm Socket#1 IMC#2: DEV 0000:fe:0e.0 (INTERRUPT)
> [   24.705094] fbcon: astdrmfb (fb0) is primary device
> [   24.705145] EDAC MC7: Giving out device to module i10nm_edac controlle=
r Intel_10nm Socket#1 IMC#3: DEV 0000:fe:0f.0 (INTERRUPT)
> [   24.705150] EDAC i10nm: v0.0.5
> [   24.716354] Console: switching to colour frame buffer device 128x48
> [   24.722648] intel_rapl_common: Found RAPL domain package
> [   24.722655] intel_rapl_common: Found RAPL domain dram
> [   24.722657] intel_rapl_common: DRAM domain energy unit 15300pj
> [   24.722927] intel_rapl_common: Found RAPL domain package
> [   24.735639] ast 0000:04:00.0: [drm] fb0: astdrmfb frame buffer device
> [   24.739074] intel_rapl_common: Found RAPL domain dram
> [   24.783220] intel_rapl_common: DRAM domain energy unit 15300pj
> [=1B[0;32m  OK  =1B[0m] Started =1B[0;1;39mifup@enp152s0f0np0=E2=80=A6vic=
e=1B[0m - ifup for enp152s0f0np0.=0D
>          Starting =1B[0;1;39mnetworking.service=1B[0m - Raise network int=
erfaces...=0D
>          Starting =1B[0;1;39msystemd-binfmt.se=E2=80=A6et Up Additional B=
inary Formats...=0D
>          Mounting =1B[0;1;39mproc-sys-fs-binfm=E2=80=A6utable File Format=
s File System..[   24.881649] bnxt_en 0000:98:00.0 enp152s0f0np0: NIC Link =
is Up, 10000 Mbps (NRZ) full duplex, Flow control: none
> [   24.893445] bnxt_en 0000:98:00.0 enp152s0f0np0: FEC autoneg off encodi=
ng: None
> .=0D
> [=1B[0;32m  OK  =1B[0m] Mounted =1B[0;1;39mproc-sys-fs-binfmt=E2=80=A6ecu=
table File Formats File System.=0D
> [=1B[0;32m  OK  =1B[0m] Finished =1B[0;1;39msystemd-binfmt.se=E2=80=A6 Se=
t Up Additional Binary Formats.=0D
> [   24.963436] BUG: unable to handle page fault for address: ff2c5dbca256=
c000
> [   24.971156] #PF: supervisor write access in kernel mode
> [   24.977012] #PF: error_code(0x0003) - permissions violation
> [   24.983267] PGD 3f3d001067 P4D 3f3d002067 PUD 16240b063 PMD 16240c063 =
PTE 800000016256c161
> [   24.992549] Oops: 0003 [#3] PREEMPT SMP NOPTI
> [   24.997438] CPU: 28 PID: 1 Comm: systemd Tainted: G      D            =
6.1.0-36-amd64 #1  Debian 6.1.139-1
> [   25.008179] Hardware name: Supermicro SYS-120C-TN10R/X12DDW-A6, BIOS 1=
=2E9 01/11/2024
> [   25.016773] RIP: 0010:clear_page_erms+0x7/0x10
> [   25.021764] Code: 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 8=
9 47 38 48 8d 7f 40 75 d9 90 e9 c3 c3 41 00 0f 1f 00 b9 00 10 00 00 31 c0 <=
f3> aa c3 cc cc cc cc 66 90 89 c8 48 c1 e9 03 74 18 0f 1f 84 00 00
> [   25.042841] RSP: 0018:ff4375fa800ef920 EFLAGS: 00010246
> [   25.048706] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000=
0001000
> [   25.056721] RDX: ffd75b7585895b00 RSI: ffd75b7585895b40 RDI: ff2c5dbca=
256c000
> [   25.064723] RBP: ff2c5ddb400378c0 R08: 0000000000000000 R09: 000000000=
1edcb9b
> [   25.072725] R10: ff4375fa800efa20 R11: ff2c5ddb400378d8 R12: 000000000=
0000000
> [   25.080734] R13: ff2c5ddbbffd5c00 R14: ff2c5ddbbffd6e00 R15: ffd75b758=
5895b00
> [   25.088744] FS:  00007f5b75687940(0000) GS:ff2c5ddb40000000(0000) knlG=
S:0000000000000000
> [   25.097827] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   25.104278] CR2: ff2c5dbca256c000 CR3: 00000020b241e003 CR4: 000000000=
0771ee0
> [   25.112290] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   25.120298] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   25.128308] PKRU: 55555554
> [   25.131336] Call Trace:
> [   25.134083]  <TASK>
> [   25.136437]  get_page_from_freelist+0xe24/0x11b0
> [   25.141628]  __alloc_pages+0x1dc/0x330
> [   25.145839]  pte_alloc_one+0x13/0x40
> [   25.149859]  __pte_alloc+0x26/0x90
> [   25.153682]  copy_page_range+0xe2d/0x1370
> [   25.158190]  dup_mmap+0x482/0x620
> [   25.161913]  copy_process+0x19d1/0x1b60
> [   25.166222]  kernel_clone+0xbf/0x430
> [   25.170237]  __do_sys_clone+0x7b/0xb0
> [   25.174350]  do_syscall_64+0x55/0xb0
> [   25.178369]  ? clear_bhb_loop+0x30/0x80
> [   25.182681]  ? clear_bhb_loop+0x30/0x80
> [   25.186987]  ? clear_bhb_loop+0x30/0x80
> [   25.191292]  ? clear_bhb_loop+0x30/0x80
> [   25.195590]  ? clear_bhb_loop+0x30/0x80
> [   25.199896]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [   25.205567] RIP: 0033:0x7f5b75e12353
> [   25.209580] Code: 00 00 00 00 00 66 90 64 48 8b 04 25 10 00 00 00 45 3=
1 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
> [   25.230655] RSP: 002b:00007ffc0163fcb8 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000038
> [   25.239154] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f5b7=
5e12353
> [   25.247162] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
1200011
> [   25.255172] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f5b7=
606f7c0
> [   25.263182] R10: 00007f5b75687c10 R11: 0000000000000246 R12: 000000000=
0000001
> [   25.271198] R13: 00007ffc0163fff0 R14: 0000564705fa9330 R15: 000000000=
0000000
> [   25.279201]  </TASK>
> [   25.281653] Modules linked in: binfmt_misc intel_rapl_msr intel_rapl_c=
ommon intel_uncore_frequency intel_uncore_frequency_common i10nm_edac skx_e=
dac_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp gh=
ash_clmulni_intel sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3 ast a=
esni_intel drm_vram_helper iTCO_wdt drm_ttm_helper intel_pmc_bxt crypto_sim=
d iTCO_vendor_support ttm mei_me intel_th_gth cryptd isst_if_mbox_pci isst_=
if_mmio intel_th_pci ipmi_ssif rapl drm_kms_helper pcspkr mei isst_if_commo=
n watchdog ioatdma intel_pch_thermal intel_th intel_vsec acpi_ipmi ipmi_si =
acpi_pad evdev joydev sg button ipmi_devintf ipmi_msghandler nf_conntrack n=
f_defrag_ipv6 nf_defrag_ipv4 loop fuse efi_pstore drm configfs ip_tables x_=
tables autofs4 ext4 crc16 mbcache jbd2 raid10 raid456 async_raid6_recov asy=
nc_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic=
 raid0 multipath linear rndis_host cdc_ether usbnet mii hid_generic usbhid =
hid dm_mod raid1 md_mod sd_mod
> [   25.281733]  nvme ahci nvme_core t10_pi libahci xhci_pci crc64_rocksof=
t crc64 libata xhci_hcd igb crc_t10dif crc32_pclmul bnxt_en usbcore scsi_mo=
d crc32c_intel crct10dif_generic i2c_algo_bit i2c_i801 crct10dif_pclmul dca=
 crct10dif_common i2c_smbus usb_common scsi_common
> [   25.406579] CR2: ff2c5dbca256c000
> [   25.410290] ---[ end trace 0000000000000000 ]---

