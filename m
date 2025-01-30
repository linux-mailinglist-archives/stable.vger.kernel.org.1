Return-Path: <stable+bounces-111727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989E1A2339C
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 19:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B224618862FB
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD971F03C3;
	Thu, 30 Jan 2025 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VB7uBt+N"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61CC8831
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738260897; cv=none; b=G7Kxo0ECPq+8CNBC4cv6oPYotjjPEDUbLNntsDmELifH78g+SB5ZRJhLNlJs2KmDdmDDXoThwdD/MzlKZt1eWnGOcngNzCJNmgMrMwRDCSZ2uCe1HXvaY9jkvenWERNU17D+qdgIv/OnI+o/onyNNldsqZpkIAbnalCJWerSt7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738260897; c=relaxed/simple;
	bh=oEhMXwyIwF3IK31iIIHzNkw72GZvTvNTtxyvyXjezzQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXMUzak6fzGyJmyatdswEOAGQ3tN3nWr9RFp6aodgNCJ/DzJHbWmIjCtYH6t+4EggdvMPYILo+YaLUwW2QUTuAEyUKvkSaOUdScGQhe/ba73u/ezMA3q4+dq/RZPPSeALZjEZrbFmL3LNDrrJGVecV+7uwc0ekBjJECvcRygm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VB7uBt+N; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so11450475e9.3
        for <stable@vger.kernel.org>; Thu, 30 Jan 2025 10:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1738260893; x=1738865693; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8W6hvBybKKuU8+xuvI8NcY3NnQGF7KBBYcVudTmJ4Y=;
        b=VB7uBt+NmZEvsyAHep0uktPwTrQ6Q9Zsj96OwVYF2Rlr73t7jUqV/FDN9YrNer34XU
         Gc0AguYl7AV/17FHEnKIQT4rYkhq8tV1cTWt7819rd4IbeQXQKs47EgOAM7u6jxSWm/F
         AX5mdTzzSjKJPkZ0DyAPB/VRMAGaP3/5PbyYVxxv8Hux6lkAx7eOc7MqKnNJmBY5tgnK
         9NYSVNvJU96IGvzKENdCYZWMLzTh5oh2Yxe9UIxzyboxET0nlHwB6fkomfaW4i6q3ym4
         RL5sfhkbY+C1jT/yrM6kFeB9tsGk3+4WwuhsiiKCapcfA3mKW8Fz+o9/XYuC2FJ71iix
         Ll4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738260893; x=1738865693;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8W6hvBybKKuU8+xuvI8NcY3NnQGF7KBBYcVudTmJ4Y=;
        b=XbRkG4L1HWrc4F0gc91yJnrhVPBw0j67V2dmQpHWkmoxF1ENF112LS3YgXmm+ZmBhT
         UorUMNOrWOsJ2wSfIOZV6B+BAnFLgzl6tMzePuwQQGqvsWZe1e5vaR5osp4rKL/4TWIB
         JCxqAitv1pEXS3MggvhjkrdkPwVTyEtDQ/ZmfDj1c2ZFUCX2FhSZw/x4jBmjcZhxfGis
         XuGfbKX4aq5tR4J7mE8vLZ3ipxX1YCmtijJy2HpqdWZdsab9yMaUr1SRe7CAZHfcpAll
         CTaz9hQyjNSP/vSyDUPY2silH3ZRJwZokFQfHdWX1k8evGxJHF+x8Of8cCGRrzEGzwGz
         CkSg==
X-Forwarded-Encrypted: i=1; AJvYcCVTmJfhBeMGYDzmojptow1L2f2jF777tDyiU/XR2O6VCk39ghSW/PQ6nzQTRzC2df7te7vNkZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfdhLtxoN0mJBzj0QMwG82OaqmozIF5w5FSmQN9s7Ep5iZV9L
	/Zbj9yNKzWTbvhIRlwwSwgXy13b12wGZXNLjpC8h7GsEAeLInRMX
X-Gm-Gg: ASbGnctX7f/SpW+MNZ/bofuF+1b5SMn/vkz86xIluQJqX/SMAuv4F2kFXxWO7zXXUqh
	Dzpj/IscpSgLo5JrEO66K7oM0Ht49wkm1SfBA8DGYtGJlSSLDFiElSQaG1tlFE8bwtwZlx4BiKq
	cWW5LuZ0SPqVexAfMQDOEIo9yHFomlN2IQk6/EtjTRS9xpjHAYS+B5gF0KDirUkRcGF8KysD4l7
	KZLFVm/4VF26k2mi4eQJLW1w9aTX6pZfnEcAD99H2rOX/w7pT+2IkiH4kPqe1+I81x/4JLf4nMD
	oEsAAT9FpKvTAjQ7uQ2Xl/R9Lf/7ZA==
X-Google-Smtp-Source: AGHT+IHewSP64MJTBot0XX041wj/NZSHFwUuaPTc1DKCFQ61SV22A9/+gbIAvKhZWfub9AOKRpxXjA==
X-Received: by 2002:a05:6000:1a8c:b0:38c:5bb2:b932 with SMTP id ffacd0b85a97d-38c5bb2bc01mr2798932f8f.3.1738260892275;
        Thu, 30 Jan 2025 10:14:52 -0800 (PST)
Received: from mars.fritz.box ([2a02:8071:7130:82c0:da34:bd1d:ae27:5be6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b61f1sm2719867f8f.68.2025.01.30.10.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 10:14:51 -0800 (PST)
Message-ID: <fc0b65020f3376e5245a8f599a060fdca10ab61c.camel@googlemail.com>
Subject: Re: rk3399 fails to boot since v6.12.7
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, 
	KeverYang <kever.yang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-rockchip@lists.infradead.org, stable <stable@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date: Thu, 30 Jan 2025 19:14:50 +0100
In-Reply-To: <86a5b8vd0d.wl-maz@kernel.org>
References: <b1266652fb64857246e8babdf268d0df8f0c36d9.camel@googlemail.com>
	 <86a5b8vd0d.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>=20
>=20
> > Any ideas?
>=20
> I think this calls for a revert of this patch, potentially at the
> expense if NMI support on this machine. Could you show how SCR_EL3.FIQ
> is configured on this machine? Mine shows:
>=20
> [    0.000000] GICv3: GICD_CTRL.DS=3D0, SCR_EL3.FIQ=3D0
>=20
> and I suspect yours has FIQ=3D1.

yes it's 1:

[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: Broken GIC integration, security disabled
[    0.000000] GICv3: GICD_CTRL.DS=3D1, SCR_EL3.FIQ=3D1
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000fef000=
00

The device is not closed (there is no docu) and OP-TEE is actually here
not used for anything. But I think I had the OP-TEE xtests running
successfully before.

Here is the full boot log:


DDR Version 1.27 20211018
In
soft reset
SRX
channel 0
CS =3D 0
MR0=3D0xB8
MR4=3D0x2
MR5=3D0xFF
MR8=3D0x8
MR12=3D0x72
MR14=3D0x72
MR18=3D0x0
MR19=3D0x0
MR24=3D0x8
MR25=3D0x0
channel 1
CS =3D 0
MR0=3D0x38
MR4=3D0x2
MR5=3D0xFF
MR8=3D0x8
MR12=3D0x72
MR14=3D0x72
MR18=3D0x0
MR19=3D0x0
MR24=3D0x8
MR25=3D0x0
channel 0 training pass!
channel 1 training pass!
change freq to 416MHz 0,1
Channel 0: LPDDR4,416MHz
Bus Width=3D32 Col=3D10 Bank=3D8 Row=3D15 CS=3D1 Die Bus-Width=3D16 Size=3D=
1024MB
Channel 1: LPDDR4,416MHz
Bus Width=3D32 Col=3D10 Bank=3D8 Row=3D15 CS=3D1 Die Bus-Width=3D16 Size=3D=
1024MB
256B stride
channel 0
CS =3D 0
MR0=3D0xB8
MR4=3D0x2
MR5=3D0xFF
MR8=3D0x8
MR12=3D0x72
MR14=3D0x72
MR18=3D0x0
MR19=3D0x0
MR24=3D0x8
MR25=3D0x0
channel 1
CS =3D 0
MR0=3D0x38
MR4=3D0x2
MR5=3D0xFF
MR8=3D0x8
MR12=3D0x72
MR14=3D0x72
MR18=3D0x0
MR19=3D0x0
MR24=3D0x8
MR25=3D0x0
channel 0 training pass!
channel 1 training pass!
channel 0, cs 0, advanced training done
channel 1, cs 0, advanced training done
channel 0, cs 0, dq 3 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 4 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 6 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 8 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 10 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 11 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 12 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 13 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 14 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 15 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 17 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 18 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 19 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 20 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 23 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 24 RISK!!! read vref 27% no find pass-eye
channel 0, cs 0, dq 25 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 26 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 27 RISK!!! TdiVW_total violate spec
 channel 0, cs 0, dq 28 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 1 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 2 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 8 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 12 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 13 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 14 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 16 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 17 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 18 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 19 RISK!!! read vref 27% no find pass-eye
channel 1, cs 0, dq 20 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 21 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 22 RISK!!! read vref 27% no find pass-eye
channel 1, cs 0, dq 23 RISK!!! read vref 27% no find pass-eye
channel 1, cs 0, dq 24 RISK!!! read vref 27% no find pass-eye
channel 1, cs 0, dq 25 RISK!!! read vref 27% no find pass-eye
channel 1, cs 0, dq 26 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 27 RISK!!! read vref 27% no find pass-eye
channel 1, cs 0, dq 28 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 29 RISK!!! TdiVW_total violate spec
 channel 1, cs 0, dq 30 RISK!!! read vref 27% no find pass-eye
channel 1, cs 0, dq 31 RISK!!! TdiVW_total violate spec
 change freq to 856MHz 1,0
ch 0 ddrconfig =3D 0x101, ddrsize =3D 0x20
ch 1 ddrconfig =3D 0x101, ddrsize =3D 0x20
pmugrf_os_reg[2] =3D 0x3281F281, stride =3D 0x9
ddr_set_rate to 328MHZ
ddr_set_rate to 666MHZ
ddr_set_rate to 416MHZ, ctl_index 0
ddr_set_rate to 856MHZ, ctl_index 1
support 416 856 328 666 MHz, current 856MHz
OUT
Boot1 Release Time: May 29 2020 17:36:36, version: 1.26
CPUId =3D 0x0
ChipType =3D 0x10, 438
SdmmcInit=3D2 0
BootCapSize=3D100000
UserCapSize=3D29820MB
FwPartOffset=3D2000 , 100000
mmc0:cmd8,20
mmc0:cmd5,20
mmc0:cmd55,20
mmc0:cmd1,20
mmc0:cmd8,20
mmc0:cmd5,20
mmc0:cmd55,20
mmc0:cmd1,20
mmc0:cmd8,20
mmc0:cmd5,20
mmc0:cmd55,20
mmc0:cmd1,20
SdmmcInit=3D0 1
StorageInit ok =3D 71316
SecureMode =3D 0
SecureInit read PBA: 0x4
SecureInit read PBA: 0x404
SecureInit read PBA: 0x804
SecureInit read PBA: 0xc04
SecureInit read PBA: 0x1004
SecureInit read PBA: 0x1404
SecureInit read PBA: 0x1804
SecureInit read PBA: 0x1c04
SecureInit ret =3D 0, SecureMode =3D 0
atags_set_bootdev: ret:(0)
Trust Addr:0x4000, 0x58334c42
No find bl30.bin
Load uboot, ReadLba =3D 2000
Load OK, addr=3D0x200000, size=3D0xf33b0
RunBL31 0x40000 @ 122275 us
NOTICE:  BL31: v1.3(release):845ee93
NOTICE:  BL31: Built : 15:51:11, Jul 22 2020
NOTICE:  BL31: Rockchip release version: v1.1
INFO:    GICv3 with legacy support detected. ARM GICV3 driver initialized i=
n EL3
INFO:    Using opteed sec cpu_context!
INFO:    boot cpu mask: 0
INFO:    plat_rockchip_pmu_init(1196): pd status 3e
INFO:    BL31: Initializing runtime services
INFO:    BL31: Initializing BL32
I/TC:
I/TC: No non-secure external DT
I/TC: OP-TEE version: 3.20.0-3-g7067d1c29 (gcc version 12.2.0 (Debian 12.2.=
0-14))
#1 Sat Jan  6 14:14:21 UTC 2024 aarch64
I/TC: WARNING: This OP-TEE configuration might be insecure!
I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architec=
ture/porting_guidelines.html
I/TC: Primary CPU initializing
I/TC: Primary CPU switching to normal world boot
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address =3D 0x200000
INFO:    SPSR =3D 0x3c9
ns16550_serial serial@ff1a0000: pinctrl_select_state_full: uclass_get_devic=
e_by_phandle_id: err=3D-19


U-Boot 2023.04-00022-gb92cd75aa58-dirty (Jan 06 2024 - 15:42:35 +0100)

SoC: Rockchip rk3399
Reset cause: RST
Model: tcirk
DRAM:  2 GiB
optee optee: OP-TEE: revision 3.20 (7067d1c2)
I/TC: Reserved shared memory is enabled
I/TC: Dynamic shared memory is enabled
I/TC: Normal World virtualization support is disabled
I/TC: Asynchronous notifications are disabled
PMIC:  RK808
Core:  290 devices, 26 uclasses, devicetree: separate
MMC:   mmc@fe320000: 1, mmc@fe330000: 0
Loading Environment from MMC... OK
In:    serial
Out:   serial
Err:   serial
Model: tcirk
Net:   No ethernet found.
Hit any key to stop autoboot:  0
switch to partitions #0, OK
mmc0(part 0) is current device
Booting from mmc ...
18937052 bytes read in 1297 ms (13.9 MiB/s)
## Loading kernel from FIT Image at 00800800 ...
   Using 'conf-rockchip_rk3399-tcirk.dtb' configuration
   Verifying Hash Integrity ... OK
   Trying 'kernel-1' kernel subimage
     Description:  Linux kernel
     Created:      2025-01-29  20:53:29 UTC
     Type:         Kernel Image
     Compression:  gzip compressed
     Data Start:   0x0080090c
     Data Size:    9619255 Bytes =3D 9.2 MiB
     Architecture: AArch64
     OS:           Linux
     Load Address: 0x02200000
     Entry Point:  0x02200000
     Hash algo:    sha256
     Hash value:   4e4a1ce89d766d2b34ecfd7a61327ec4f26e42f02f69c999fc8b905c=
8c98a663
   Verifying Hash Integrity ... sha256+ OK
   Decrypting Data ... OK
## Loading ramdisk from FIT Image at 00800800 ...
   Using 'conf-rockchip_rk3399-tcirk.dtb' configuration
   Verifying Hash Integrity ... OK
   Trying 'ramdisk-1' ramdisk subimage
     Description:  initramfs
     Created:      2025-01-29  20:53:29 UTC
     Type:         RAMDisk Image
     Compression:  uncompressed
     Data Start:   0x0113d7dc
     Data Size:    9248611 Bytes =3D 8.8 MiB
     Architecture: AArch64
     OS:           Linux
     Load Address: unavailable
     Entry Point:  unavailable
     Hash algo:    sha256
     Hash value:   7cb5aaab6a280284d8f6809daaec2e208fb7c0a1b1eff918371925f0=
4ff8e2ea
   Verifying Hash Integrity ... sha256+ OK
   Decrypting Data ... OK
## Loading fdt from FIT Image at 00800800 ...
   Using 'conf-rockchip_rk3399-tcirk.dtb' configuration
   Verifying Hash Integrity ... OK
   Trying 'fdt-rockchip_rk3399-tcirk.dtb' fdt subimage
     Description:  Flattened Device Tree blob
     Created:      2025-01-29  20:53:29 UTC
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x0112d160
     Data Size:    66993 Bytes =3D 65.4 KiB
     Architecture: AArch64
     Hash algo:    sha256
     Hash value:   3fe8d11246291479c1bdd95fd1367caee7a15c0de5a81a7ac5aca40b=
9c4240ba
   Verifying Hash Integrity ... sha256+ OK
   Decrypting Data ... OK
   Booting using the fdt blob at 0x112d160
Working FDT set to 112d160
   Uncompressing Kernel Image
   Loading Ramdisk to 5e5cc000, end 5ee9df63 ... OK
   Loading Device Tree to 000000005e5b8000, end 000000005e5cb5b0 ... OK
Working FDT set to 5e5b8000


Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 6.12.6-00065-g20bf32f48288-dirty (x@x) (aarch6=
4-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian)=
 2.40) #1 SMP PREEMPT Wed Jan 29 21:53:22 CET 2025
[    0.000000] KASLR disabled due to lack of seed
[    0.000000] Machine model: tcirk-vir4-hw
[    0.000000] earlycon: uart8250 at MMIO32 0x00000000ff1a0000 (options '')
[    0.000000] printk: legacy bootconsole [uart8250] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: 0x0000000000000000..0x00000000001fffff (20=
48 KiB) nomap non-reusable secmon@0
[    0.000000] OF: reserved mem: 0x0000000030000000..0x0000000031ffffff (32=
768 KiB) nomap non-reusable optee@43200000
[    0.000000] NUMA: Faking a node at [mem 0x0000000000200000-0x000000007ff=
fffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x7fbab600-0x7fbadc3f]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000200000-0x000000007fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000200000-0x000000002fffffff]
[    0.000000]   node   0: [mem 0x0000000030000000-0x0000000031ffffff]
[    0.000000]   node   0: [mem 0x0000000032000000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x000000007ffff=
fff]
[    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
[    0.000000] cma: Reserved 32 MiB at 0x000000007ba00000 on node -1
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] percpu: Embedded 23 pages/cpu s53272 r8192 d32744 u94208
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Kernel command line: panic=3D3 console=3DttyS2,1500000 early=
con=3Duart8250,mmio32,0xff1a0000 root=3DPARTUUID=3D14ac38b7-213e-19fa-9ba2-=
2147628lbaa3 rootwait fsck.repair=3Dyes
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 b=
ytes, linear)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 by=
tes, linear)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 52377=
6
[    0.000000] Policy zone: DMA
[    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:of=
f
[    0.000000] software IO TLB: SWIOTLB bounce buffer size adjusted to 1MB
[    0.000000] software IO TLB: area num 8.
[    0.000000] software IO TLB: mapped [mem 0x000000007b600000-0x000000007b=
800000] (2MB)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D6, N=
odes=3D1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_i=
ds=3D6.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D6
[    0.000000] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjus=
t=3D1 rcu_task_cpu_ids=3D6.
[    0.000000] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D6.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: Broken GIC integration, security disabled
[    0.000000] GICv3: GICD_CTRL.DS=3D1, SCR_EL3.FIQ=3D1
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000fef000=
00
[    0.000000] ITS [mem 0xfee20000-0xfee3ffff]
[    0.000000] ITS@0x00000000fee20000: allocated 65536 Devices @480000 (fla=
t, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x0000000000460000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000000=
470000
[    0.000000] GICv3: GIC: PPI partition interrupt-partition-0[0] { /cpus/c=
pu@0[0] /cpus/cpu@1[1] /cpus/cpu@2[2] /cpus/cpu@3[3] }
[    0.000000] GICv3: GIC: PPI partition interrupt-partition-1[1] { /cpus/c=
pu@100[4] /cpus/cpu@101[5] }
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cy=
cles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000003] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every =
4398046511097ns
[    0.004487] Console: colour dummy device 80x25
[    0.005311] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 48.00 BogoMIPS (lpj=3D24000)
[    0.006425] pid_max: default: 32768 minimum: 301
[    0.007248] LSM: initializing lsm=3Dcapability
[    0.008339] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes,=
 linear)
[    0.009195] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 b=
ytes, linear)
[    0.022860] rcu: Hierarchical SRCU implementation.
[    0.023390] rcu:     Max phase no-delay instances is 400.
[    0.025119] Timer migration: 1 hierarchy levels; 8 children per group; 1=
 crossnode level
[    0.028650] EFI services will not be available.
[    0.030776] smp: Bringing up secondary CPUs ...
I/TC: Secondary CPU 1 initializing
I/TC: Secondary CPU 1 switching to normal world boot
I/TC: Secondary CPU 2 initializing
I/TC: Secondary CPU 2 switching to normal world boot
I/TC: Secondary CPU 3 initializing
I/TC: Secondary CPU 3 switching to normal world boot
I/TC: Secondary CPU 4 initializing
I/TC: Secondary CPU 4 switching to normal world boot
I/TC: Secondary CPU 5 initializing
I/TC: Secondary CPU 5 switching to normal world boot
[    0.036689] Detected VIPT I-cache on CPU1
[    0.036956] GICv3: CPU1: found redistributor 1 region 0:0x00000000fef200=
00
[    0.037013] GICv3: CPU1: using allocated LPI pending table @0x0000000000=
500000
[    0.037146] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.042458] Detected VIPT I-cache on CPU2
[    0.042733] GICv3: CPU2: found redistributor 2 region 0:0x00000000fef400=
00
[    0.042791] GICv3: CPU2: using allocated LPI pending table @0x0000000000=
510000
[    0.042924] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.048145] Detected VIPT I-cache on CPU3
[    0.048436] GICv3: CPU3: found redistributor 3 region 0:0x00000000fef600=
00
[    0.048494] GICv3: CPU3: using allocated LPI pending table @0x0000000000=
520000
[    0.048625] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.064979] CPU features: detected: Spectre-v2
[    0.065590] CPU features: detected: Spectre-v3a
[    0.065933] CPU features: detected: Spectre-v4
[    0.066243] CPU features: detected: Spectre-BHB
[    0.066641] CPU features: detected: ARM erratum 1742098
[    0.067027] CPU features: detected: ARM errata 1165522, 1319367, or 1530=
923
[    0.067364] Detected PIPT I-cache on CPU4
[    0.071008] GICv3: CPU4: found redistributor 100 region 0:0x00000000fef8=
0000
[    0.071769] GICv3: CPU4: using allocated LPI pending table @0x0000000000=
530000
[    0.073446] CPU4: Booted secondary processor 0x0000000100 [0x410fd082]
[    0.102961] Detected PIPT I-cache on CPU5
[    0.107087] GICv3: CPU5: found redistributor 101 region 0:0x00000000fefa=
0000
[    0.107886] GICv3: CPU5: using allocated LPI pending table @0x0000000000=
540000
[    0.109552] CPU5: Booted secondary processor 0x0000000101 [0x410fd082]
[    0.121026] smp: Brought up 1 node, 6 CPUs
[    0.137438] SMP: Total of 6 processors activated.
[    0.137994] CPU: All CPU(s) started at EL2
[    0.138462] CPU features: detected: 32-bit EL0 Support
[    0.139081] CPU features: detected: CRC32 instructions
[    0.142315] alternatives: applying system-wide alternatives
[    0.152865] Memory: 1946248K/2095104K available (13824K kernel code, 134=
6K rwdata, 4528K rodata, 3520K init, 603K bss, 108856K reserved, 32768K cma=
-reserved)
[    0.157602] devtmpfs: initialized
[    0.226157] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    0.227568] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.232219] 26752 pages in range for non-PLT usage
[    0.232591] 518272 pages in range for PLT usage
[    0.234879] pinctrl core: initialized pinctrl subsystem
[    0.238462] DMI not present or invalid.
[    0.262606] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.274891] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocat=
ions
[    0.277008] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic=
 allocations
[    0.279510] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atom=
ic allocations
[    0.287254] thermal_sys: Registered thermal governor 'step_wise'
[    0.287334] thermal_sys: Registered thermal governor 'power_allocator'
[    0.288498] cpuidle: using governor menu
[    0.291457] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers=
.
[    0.295740] ASID allocator initialised with 65536 entries
[    0.374178] /syscon@ff770000/phy@f780: Fixed dependency cycle(s) with /m=
mc@fe330000
[    0.378621] /mmc@fe330000: Fixed dependency cycle(s) with /syscon@ff7700=
00/phy@f780
[    0.379769] /syscon@ff770000/phy@f780: Fixed dependency cycle(s) with /m=
mc@fe330000
[    0.400094] /vop@ff900000: Fixed dependency cycle(s) with /dsi@ff960000
[    0.401196] /vop@ff8f0000: Fixed dependency cycle(s) with /dsi@ff960000
[    0.402205] /dsi@ff960000: Fixed dependency cycle(s) with /dsi@ff960000/=
bridge-dsi@0
[    0.403080] /dsi@ff960000:  dependency cycle(s) with /vop@ff8f0000
[    0.404041] /dsi@ff960000: Fixed dependency cycle(s) with /vop@ff900000
[    0.405380] /dsi@ff960000/bridge-dsi@0: Fixed dependency cycle(s) with /=
dsi@ff960000
[    0.431355] gpio gpiochip0: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    0.434094] rockchip-gpio ff720000.gpio: probed /pinctrl/gpio@ff720000
[    0.436711] gpio gpiochip1: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    0.438580] rockchip-gpio ff730000.gpio: probed /pinctrl/gpio@ff730000
[    0.440577] gpio gpiochip2: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    0.442324] rockchip-gpio ff780000.gpio: probed /pinctrl/gpio@ff780000
[    0.444303] gpio gpiochip3: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    0.446154] rockchip-gpio ff788000.gpio: probed /pinctrl/gpio@ff788000
[    0.448175] gpio gpiochip4: Static allocation of GPIO base is deprecated=
, use dynamic allocation.
[    0.449955] rockchip-gpio ff790000.gpio: probed /pinctrl/gpio@ff790000
[    0.461437] /dsi@ff960000/bridge-dsi@0: Fixed dependency cycle(s) with /=
panel-dpi
[    0.462719] /panel-dpi: Fixed dependency cycle(s) with /dsi@ff960000/bri=
dge-dsi@0
[    0.490476] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 page=
s
[    0.491515] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.492218] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 page=
s
[    0.492922] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.493619] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 page=
s
[    0.494320] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.495014] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 page=
s
[    0.495713] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.525614] iommu: Default domain type: Passthrough
[    0.537266] SCSI subsystem initialized
[    0.540585] usbcore: registered new interface driver usbfs
[    0.541351] usbcore: registered new interface driver hub
[    0.542062] usbcore: registered new device driver usb
[    0.543936] mc: Linux media interface: v0.10
[    0.544562] videodev: Linux video capture interface: v2.00
[    0.545400] pps_core: LinuxPPS API ver. 1 registered
[    0.545928] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.546946] PTP clock support registered
[    0.547523] EDAC MC: Ver: 3.0.0
[    0.550022] scmi_core: SCMI protocol bus registered
[    0.553236] Advanced Linux Sound Architecture Driver Initialized.
[    0.566115] clocksource: Switched to clocksource arch_sys_counter
[    0.568672] VFS: Disk quotas dquot_6.6.0
[    0.569218] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.613752] NET: Registered PF_INET protocol family
[    0.615404] IP idents hash table entries: 32768 (order: 6, 262144 bytes,=
 linear)
[    0.625739] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2,=
 16384bytes, linear)
[    0.626896] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.629804] TCP established hash table entries: 16384 (order: 5, 131072 =
bytes, linear)
[    0.631401] TCP bind hash table entries: 16384 (order: 7, 524288 bytes, =
linear)
[    0.634324] TCP: Hash tables configured (established 16384 bind 16384)
[    0.635926] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    0.637024] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, li=
near)
[    0.638943] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.644047] RPC: Registered named UNIX socket transport module.
[    0.644806] RPC: Registered udp transport module.
[    0.645354] RPC: Registered tcp transport module.
[    0.645852] RPC: Registered tcp-with-tls transport module.
[    0.646469] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.654176] Unpacking initramfs...
[    0.669172] Initialise system trusted keyrings
[    0.672849] workingset: timestamp_bits=3D42 max_order=3D19 bucket_order=
=3D0
[    0.675780] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.679691] NFS: Registering the id_resolver key type
[    0.680711] Key type id_resolver registered
[    0.681176] Key type id_legacy registered
[    0.681793] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.682558] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regist=
ering..  .
[    0.684806] 9p: Installing v9fs 9p2000 file system support
[    1.014409] Key type asymmetric registered
[    1.015335] Asymmetric key parser 'x509' registered
[    1.016907] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 245)
[    1.017753] io scheduler mq-deadline registered
[    1.018287] io scheduler kyber registered
[    1.018886] io scheduler bfq registered
[    1.103497] ledtrig-cpu: registered to indicate activity on CPUs
[    1.121682] dma-pl330 ff6d0000.dma-controller: Loaded driver for PL330 D=
MAC-241330
[    1.122828] dma-pl330 ff6d0000.dma-controller:       DBUFF-32x8bytes Num=
_Chans-6 Num_Peri-12 Num_Events-12
[    1.130971] dma-pl330 ff6e0000.dma-controller: Loaded driver for PL330 D=
MAC-241330
[    1.132002] dma-pl330 ff6e0000.dma-controller:       DBUFF-128x8bytes Nu=
m_Chans-8 Num_Peri-20 Num_Events-16
[    1.165185] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.179214] printk: legacy console [ttyS2] disabled
[    1.182047] ff1a0000.serial: ttyS2 at MMIO 0xff1a0000 (irq =3D 37, base_=
baud =3D 1500000) is a 16550A
[    1.184023] printk: legacy console [ttyS2] enabled
[    1.184023] printk: legacy console [ttyS2] enabled
[    1.185074] printk: legacy bootconsole [uart8250] disabled
[    1.185074] printk: legacy bootconsole [uart8250] disabled
[    1.196793] ff1b0000.serial: ttyS3 at MMIO 0xff1b0000 (irq =3D 38, base_=
baud =3D 1500000) is a 16550A
[    1.224035] rockchip-vop ff8f0000.vop: Adding to iommu group 0
[    1.227910] rockchip-vop ff900000.vop: Adding to iommu group 1
[    1.238640] /panel-dpi: Fixed dependency cycle(s) with /dsi@ff960000/bri=
dge-dsi@0
[    1.240012] /dsi@ff960000: Fixed dependency cycle(s) with /dsi@ff960000/=
bridge-dsi@0
[    1.241498] /dsi@ff960000/bridge-dsi@0: Fixed dependency cycle(s) with /=
panel-dpi
[    1.242550] /dsi@ff960000/bridge-dsi@0: Fixed dependency cycle(s) with /=
dsi@ff960000
[    1.359770] loop: module loaded
[    1.391983] tun: Universal TUN/TAP device driver, 1.6
[    1.398847] usbcore: registered new device driver r8152-cfgselector
[    1.399799] usbcore: registered new interface driver r8152
[    1.401916] VFIO - User Level meta-driver version: 0.3
[    1.439447] ehci-platform fe3c0000.usb: EHCI Host Controller
[    1.439552] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    1.439684] ohci-platform fe3e0000.usb: Generic Platform OHCI controller
[    1.439811] ehci-platform fe3c0000.usb: new USB bus registered, assigned=
 bus number 1
[    1.439814] ohci-platform fe3e0000.usb: new USB bus registered, assigned=
 bus number 2
[    1.440401] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned b=
us number 3
[    1.440455] ohci-platform fe3e0000.usb: irq 47, io mem 0xfe3e0000
[    1.441218] ehci-platform fe3c0000.usb: irq 46, io mem 0xfe3c0000
[    1.441889] xhci-hcd xhci-hcd.0.auto: hcc params 0x0220fe64 hci version =
0x110 quirks 0x0000808002000010
[    1.445802] xhci-hcd xhci-hcd.0.auto: irq 45, io mem 0xfe900000
[    1.447205] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    1.447954] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned b=
us number 4
[    1.448611] ehci-platform fe3c0000.usb: USB 2.0 started, EHCI 1.00
[    1.448781] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
[    1.453899] hub 1-0:1.0: USB hub found
[    1.454581] hub 1-0:1.0: 1 port detected
[    1.460692] hub 3-0:1.0: USB hub found
[    1.461448] hub 3-0:1.0: 1 port detected
[    1.463918] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    1.468035] hub 4-0:1.0: USB hub found
[    1.468626] hub 4-0:1.0: 1 port detected
[    1.471219] usbcore: registered new interface driver usb-storage
[    1.483730] UDC core: g_ether: couldn't find an available UDC
[    1.489488] i2c_dev: i2c /dev entries driver
[    1.515561] hub 2-0:1.0: USB hub found
[    1.516545] hub 2-0:1.0: 1 port detected
[    1.532183] rtc-s35390a 5-0030: registered as rtc0
[    1.534539] rtc-s35390a 5-0030: setting system clock to 2025-01-29T20:53=
:51 UTC (1738184031)
[    1.543848] /i2c@ff3c0000/pmic@1b: Fixed dependency cycle(s) with /i2c@f=
f3c0000 /pmic@1b/regulators/DCDC_REG4
[    1.609013] rk808-rtc rk808-rtc.3.auto: registered as rtc1
[    1.616450] fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detecte=
d!
[    1.620451] fan53555-regulator 0-0041: FAN53555 Option[8] Rev[1] Detecte=
d!
[    1.622577] hantro-vpu ff650000.video-codec: Adding to iommu group 2
[    1.628648] hantro-vpu ff650000.video-codec: registered rockchip,rk3399-=
vpu-enc as /dev/video0
[    1.631489] hantro-vpu ff650000.video-codec: registered rockchip,rk3399-=
vpu-dec as /dev/video1
[    1.660392] dw_wdt ff848000.watchdog: No valid TOPs array specified
[    1.679904] cpufreq: cpufreq_online: CPU0: Running at unlisted initial f=
requency: 200000 KHz, changing to: 408000 KHz
[    1.682388] cpu cpu0: EM: created perf domain
[    1.691575] cpufreq: cpufreq_online: CPU4: Running at unlisted initial f=
requency: 12000 KHz, changing to: 408000 KHz
[    1.692804] cpu cpu4: EM: created perf domain
[    1.695948] sdhci: Secure Digital Host Controller Interface driver
[    1.696503] sdhci: Copyright(c) Pierre Ossman
[    1.697090] Synopsys Designware Multimedia Card Interface Driver
[    1.698013] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.699318] dwmmc_rockchip fe320000.mmc: IDMAC supports 32-bit address m=
ode.
[    1.699665] usbcore: registered new interface driver usbhid
[    1.699974] dwmmc_rockchip fe320000.mmc: Using internal DMA controller.
[    1.700062] mmc1: CQHCI version 5.10
[    1.700444] usbhid: USB HID core driver
[    1.701709] dwmmc_rockchip fe320000.mmc: Version ID is 270a
[    1.702284] dwmmc_rockchip fe320000.mmc: DW MMC controller at irq 66,32 =
bit host data width,256 deep fifo
[    1.703364] dwmmc_rockchip fe320000.mmc: Got CD GPIO
[    1.705422] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 (=
0,8000003f) counters available
[    1.706582] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 (=
0,8000003f) counters available
[    1.708117] optee: probing for conduit method.
I/TC: Reserved shared memory is enabled
I/TC: Dynamic shared memory is enabled
I/TC: Normal World virtualization support is disabled
I/TC: Asynchronous notifications are disabled
[    1.708530] optee: revision 3.20 (7067d1c2)
[    1.710428] optee: dynamic shared memory is enabled
E/TC:4 0 Panic 'Secure interrupt handler not defined' at core/kernel/interr=
upt.c:139 <itr_core_handler>
E/TC:4 0 TEE load address @ 0x30000000
E/TC:4 0 Call stack:
E/TC:4 0  0x300091f8
E/TC:4 0  0x30016664
E/TC:4 0  0x30015710
[    1.716572] mmc_host mmc0: Bus speed (slot 0) =3D 400000Hz (slot req 400=
000Hz, actual 400000HZ div =3D 0)
[    1.795412] usb 4-1: new SuperSpeed USB device number 2 using xhci-hcd
[    1.843025] Freeing initrd memory: 9028K
[    1.962283] r8152-cfgselector 4-1: reset SuperSpeed USB device number 2 =
using xhci-hcd
[    1.983718] r8152 4-1:1.0 eth0: v1.12.13
[   22.722238] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   22.722774] rcu:     4-...0: (1 GPs behind) idle=3D11cc/1/0x400000000000=
0000 softirq=3D98/99 fqs=3D4193
[   22.723528] rcu:     (detected by 5, t=3D21005 jiffies, g=3D-743, q=3D98=
8 ncpus=3D6)
[   22.724124] Sending NMI from CPU 5 to CPUs 4:
[   32.725383] rcu: rcu_preempt kthread starved for 9995 jiffies! g-743 f0x=
0 RCU_GP_DOING_FQS(6) ->state=3D0x0 ->cpu=3D1
[   32.725442] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tas=
ks: {
[   32.725767] rcu:     Unless rcu_preempt kthread gets sufficient CPU time=
, OOM is now expected behavior.
[   32.725770] rcu: RCU grace-period kthread stack dump:
[   32.725772] task:rcu_preempt     state:I stack:0     pid:16    tgid:16  =
  ppid:2      flags:0x00000008
[   32.725780] Call trace:
[   32.725782]  __switch_to+0xf0/0x14c
[   32.726713]  4-...D
[   32.727301]  __schedule+0x264/0xa90
[   32.727305]  schedule+0x34/0x104
[   32.727308]  schedule_timeout+0x80/0xf4
[   32.727314]  rcu_gp_fqs_loop+0x14c/0x4a4
[   32.727323]  rcu_gp_kthread+0x138/0x164
[   32.727327]  kthread+0x114/0x118
[   32.728139]  } 30878 jiffies s: 37 root: 0x10/.
[   32.728564]  ret_from_fork+0x10/0x20
[   32.728570] rcu: Stack dump where RCU GP kthread last ran:
[   32.728572] Sending NMI from CPU 5 to CPUs 1:
[   32.728581] NMI backtrace for cpu 1
[   32.729421] rcu: blocking rcu_node structures (internal RCU debug):
[   32.729619] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.12.6-0006=
5-g20bf32f48288-dirty #1
[   32.729922]
[   32.730108] Hardware name: tcirk-vir4-hw (DT)
[   32.735680] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   32.736292] pc : cpuidle_enter_state+0xac/0x2fc
[   32.736699] lr : cpuidle_enter_state+0xa4/0x2fc
[   32.737101] sp : ffff80008196bd90
[   32.737394] x29: ffff80008196bd90 x28: 0000000000000000 x27: 00000000000=
00000
[   32.738027] x26: 0000000000000000 x25: 000000079ec1bd5c x24: 00000000000=
00000
[   32.738659] x23: 0000000000000000 x22: ffff000001c58880 x21: ffff00007fb=
2c138
[   32.739292] x20: 0000000000000000 x19: 000000079ec66d11 x18: 00000000000=
00001
[   32.739924] x17: 000000040044ffff x16: 00500072b5503510 x15: 00000000000=
00000
[   32.740556] x14: ffff80008133d900 x13: 0000000000000400 x12: 00000000000=
00000
[   32.741188] x11: ffff80008133bf00 x10: 071c71c71c71c71c x9 : 00000000000=
00350
[   32.741820] x8 : 00000000000cf080 x7 : 00000000000000c0 x6 : 00000000152=
1f5e1
[   32.742452] x5 : 00ffffffffffffff x4 : 0000000000000015 x3 : 00000000005=
0d8f0
[   32.743084] x2 : ffff7ffffe7f0000 x1 : ffff00007fb2d900 x0 : 00000000000=
00000
[   32.743717] Call trace:
[   32.743934]  cpuidle_enter_state+0xac/0x2fc
[   32.744307]  cpuidle_enter+0x38/0x50
[   32.744630]  do_idle+0x1e8/0x258
[   32.744920]  cpu_startup_entry+0x38/0x3c
[   32.745268]  secondary_start_kernel+0x124/0x144
[   32.745671]  __secondary_switched+0xb8/0xbc




