Return-Path: <stable+bounces-199923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F635CA196D
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 21:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D21F430198B2
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 20:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50D2C11C5;
	Wed,  3 Dec 2025 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfjcJ7kw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD5398FA5
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764794852; cv=none; b=UiiMfV8Ujnh+A22Bj2ULqyx3IktHs8TSG8ZPtkfLctnlXHCvtxYNvf4u7FNeVwQUCHFs+0dxflB5LaDFnnq8ATfDLGF3t/s0dLljAtjeDxpE1EVyx0x+1yr+WzwEb5FN8rxsUjbGWeitvmyaRpA2ousuNTWKKi1GUDVP663tg8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764794852; c=relaxed/simple;
	bh=4ER1hptm4gojeHx6uRW4Uz8DU/Bg9jquy8QJ0sXweSc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=a0xm5264my/zmlAuqRbU4+gWgXIy+iS3N9wQkGTQqoi8NZPoUey1RCCzEWmfpIZj6wIrQnbmHRqmGYk+XM6caiMMlVbkxQ00XGlx/S0jqj0Yn+MEvXAMK7S2nrPgK29r98LFREgCbrKQIYRJJu9F3fRpei0PM9jBzjixmQ8ixO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfjcJ7kw; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so259068a12.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 12:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764794843; x=1765399643; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hbpL3PLjHVB4UGW6khCth80XBeGei+9aiGLy/e342cY=;
        b=BfjcJ7kwSsr2AzMEbvztRL3BxjUyGODHhfDxndvl+xe1aYMPXCf2aw3/oRSst/XJ3g
         TjKszDQNsN6rpn3AJicdOTbh9DOmmoTphaq868zm+wbVZ5R+5V+rayzC3YfjhwqOjuDi
         jwtdV66xnroEdD+AYGjPZ85UmWby+P4AOtlGD0kqpUm9bmYzsYtD4dqHxlLk/wDdE7Hi
         V0AhNUhumoGwVmjhPSR74MLljMdV2Sy9y3OxNVdOhgKxZpPWNdlRG/tASmXUY2zoAV/P
         Gl/O7zKDsKDKUVtPBYkyOgfGtI3wQPv6wNP6Jo7qF27L42oKj+Z2QuAroBLcqX90dgmP
         eAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764794843; x=1765399643;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbpL3PLjHVB4UGW6khCth80XBeGei+9aiGLy/e342cY=;
        b=ANJ3LSZgl60xc6R8NpEng8nWDOK3EI1uKHF9zeQfW88VKB+oquX4o3Srwum6e/6rGI
         +3xpWgtW+FB/yufgwtzAXaCeYBosRXnMBiKO69Uumf+HuVDoZ2Wv4dOkjZ/nMhTmoRY1
         sHo6wwbd3f7DhTeWS7NQjovVk34ECbOXPXDS1uV65hVKoyjxeBCeBVeph1c3wnuSpWly
         1f1S/KtMVxigQ84dgSAS/Rih7mNJAJbXO5X8NmDUNMkVVErExbXEXgWsIAJc6UgWHn15
         u4ByJ8EjjOQLy+l0J/BnbfXhOzBAEnucQ65XNatTDdq5+VWua5U74QjUBE/P155tgjaE
         VLeg==
X-Gm-Message-State: AOJu0YwvUKwDVwaRhSEoTbRlwM55bPHt0fwt/IYqSMwOpXw9Q1j8IwRl
	RN/0hUUqDp9u4XHlD0S7bq/kWZ0RFPGEJ7nMJ6qT248sEPAqg8oDzttOFAn/MlAftD+7wZXFqfG
	gBkMK87teWvGBudS3yJXL/0nWUCM+TWN6yKzj
X-Gm-Gg: ASbGncvT8CHPTVisG8pUulMtR2QY1o6CZb3aURYNTtorqs6GPQmha2qiJpzOu0MJTku
	tvWIbh6a4BTEQL7z8Mo88JoK12+jROr3vYft2plI3OrVKh9Hd5Vw20KB3T0nWs68Qb8FYMTt23v
	zDdxd6E8apVxt/cLgjn4uVpFmJxLKsC2Lm7++xJeGrdiG1yFMjOXnbpZCvbCK1zcN+boqrv1aDM
	nECo+GJiL9CCsEBDHi4DyW2/CbknnUcJizs5P0bTwtgeAd5/xChH27TZvAb+W6y7+hmkEg=
X-Google-Smtp-Source: AGHT+IFq5I3kuTwUALj7GJqWUh2E3nxSh7PENBwvfbTaBGdIlbZr7BeHNyUW56mshNyXsIIPtcwaEd3dF6fvWO1JsmU=
X-Received: by 2002:a17:907:d05:b0:b72:5e2c:9e97 with SMTP id
 a640c23a62f3a-b79dc73ccf1mr387077366b.36.1764794841701; Wed, 03 Dec 2025
 12:47:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: luoyonggang@gmail.com
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 4 Dec 2025 04:47:07 +0800
X-Gm-Features: AWmQ_bnOvNuBpSQzVFKIQN3AgrxWynUIk7CPgSb7VDP0aRuBWcygmlpMHCT8avw
Message-ID: <CAE2XoE88ptwc9cG8U18gMPOd1nx8LfMtWn8Urtuu892LRJ8CFQ@mail.gmail.com>
Subject: kernel crash when use zstd compress 256gb qemu raw image file
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dec 04 03:29:28 32core systemd-modules-load[916]: Failed to find
module 'vendor-reset'
Dec 04 03:29:28 32core systemd-udevd[938]: Using default interface
naming scheme 'v257'.
Dec 04 03:29:28 32core lvm[908]:   5 logical volume(s) in volume group
"pve" monitored
Dec 04 03:29:28 32core systemd-modules-load[916]: Inserted module 'vhost_ne=
t'
Dec 04 03:29:28 32core systemd[1]: Starting
systemd-journal-flush.service - Flush Journal to Persistent Storage...
Dec 04 03:29:28 32core kernel: input: Generic USB Audio Consumer
Control as /devices/pci0000:40/0000:40:01.1/0000:41:00.0/0000:42:08.0/0000:=
48:00.3/usb9/9-5/9-5:1.7/0003:26CE:0A01.0006/input/input10
Dec 04 03:29:28 32core kernel: input: Generic USB Audio as
/devices/pci0000:40/0000:40:01.1/0000:41:00.0/0000:42:08.0/0000:48:00.3/usb=
9/9-5/9-5:1.7/0003:26CE:0A01.0006/input/input11
Dec 04 03:29:28 32core kernel: hid-generic 0003:26CE:0A01.0006:
input,hiddev2,hidraw5: USB HID v1.11 Device [Generic USB Audio] on
usb-0000:48:00.3-5/input7
Dec 04 03:29:28 32core (udev-worker)[954]: lo: Invalid network
interface name, ignoring:
Dec 04 03:29:28 32core systemd[1]: Found device dev-pve-swap.device -
/dev/pve/swap.
Dec 04 03:29:28 32core lvm[1079]: PV /dev/nvme2n1p3 online, VG pve is compl=
ete.
Dec 04 03:29:28 32core lvm[1079]: VG pve finished
Dec 04 03:29:29 32core kernel: mc: Linux media interface: v0.10
Dec 04 03:29:29 32core kernel: input: PC Speaker as
/devices/platform/pcspkr/input/input12
Dec 04 03:29:29 32core kernel: RAPL PMU: API unit is 2^-32 Joules, 2
fixed counters, 163840 ms ovfl timer
Dec 04 03:29:29 32core kernel: RAPL PMU: hw unit of domain package 2^-16 Jo=
ules
Dec 04 03:29:29 32core kernel: RAPL PMU: hw unit of domain core 2^-16 Joule=
s
Dec 04 03:29:29 32core kernel: ee1004 1-0051: 512 byte
EE1004-compliant SPD EEPROM, read-only
Dec 04 03:29:29 32core kernel: ccp 0000:22:00.1: enabling device (0000 -> 0=
002)
Dec 04 03:29:29 32core kernel: ccp 0000:22:00.1: ccp enabled
Dec 04 03:29:29 32core kernel: ccp 0000:22:00.1: psp enabled
Dec 04 03:29:29 32core kernel: ee1004 1-0053: 512 byte
EE1004-compliant SPD EEPROM, read-only
Dec 04 03:29:29 32core kernel: ee1004 1-0055: 512 byte
EE1004-compliant SPD EEPROM, read-only
Dec 04 03:29:29 32core kernel: ee1004 1-0057: 512 byte
EE1004-compliant SPD EEPROM, read-only
Dec 04 03:29:29 32core kernel: ee1004 3-0057: Failed to select page 0 (-6)
Dec 04 03:29:29 32core kernel: ee1004 3-0057: 512 byte
EE1004-compliant SPD EEPROM, read-only
Dec 04 03:29:29 32core systemd[1]: Activating swap dev-pve-swap.swap -
/dev/pve/swap...
Dec 04 03:29:29 32core systemd[1]: Finished
systemd-udev-trigger.service - Coldplug All udev Devices.
Dec 04 03:29:29 32core systemd-journald[915]: Time spent on flushing
to /var/log/journal/9b05606f693a449bb4ef49b502ff7c47 is 14.486ms for
1566 entries.
Dec 04 03:29:29 32core systemd-journald[915]: System Journal
(/var/log/journal/9b05606f693a449bb4ef49b502ff7c47) is 3.1G, max 4G,
907.3M free.
Dec 04 03:29:29 32core systemd-journald[915]: Received client request
to flush runtime journal.
Dec 04 03:29:29 32core systemd-journald[915]: File
/var/log/journal/9b05606f693a449bb4ef49b502ff7c47/system.journal
corrupted or uncleanly shut down, renaming and replacing.
Dec 04 03:29:29 32core kernel: Adding 8388604k swap on
/dev/mapper/pve-swap.  Priority:-2 extents:1 across:8388604k SS
Dec 04 03:29:29 32core systemd[1]: Activated swap dev-pve-swap.swap -
/dev/pve/swap.
Dec 04 03:29:29 32core systemd[1]: Found device
dev-disk-by\x2duuid-9EA6\x2dDCA3.device - THNSN51T02DU7 TOSHIBA 2.
Dec 04 03:29:29 32core systemd[1]: Found device
dev-disk-by\x2duuid-c1ab544a\x2d4190\x2d426a\x2d8cdd\x2d8d6af66f97fa.device
- Asgard AN2TNVMe M.2/80 1.
Dec 04 03:29:29 32core systemd[1]: Reached target swap.target - Swaps.
Dec 04 03:29:29 32core systemd-fsck[1210]: fsck.fat 4.2 (2021-01-31)
Dec 04 03:29:29 32core systemd-fsck[1210]: There are differences
between boot sector and its backup.
Dec 04 03:29:29 32core systemd-fsck[1210]: This is mostly harmless.
Differences: (offset:original/backup)
Dec 04 03:29:29 32core systemd-fsck[1210]:   65:01/00
Dec 04 03:29:29 32core systemd-fsck[1210]:   Not automatically fixing this.
Dec 04 03:29:29 32core systemd-fsck[1210]: Dirty bit is set. Fs was
not properly unmounted and some data may be corrupt.
Dec 04 03:29:29 32core systemd-fsck[1210]:  Automatically removing dirty bi=
t.
Dec 04 03:29:29 32core systemd-fsck[1210]: *** Filesystem was changed ***
Dec 04 03:29:29 32core systemd-fsck[1210]: Writing changes.
Dec 04 03:29:29 32core systemd-fsck[1210]: /dev/nvme2n1p2: 5 files,
88/130812 clusters
Dec 04 03:29:29 32core systemd[1]: Reached target tpm2.target -
Trusted Platform Module.
Dec 04 03:29:29 32core systemd[1]: Listening on systemd-rfkill.socket
- Load/Save RF Kill Switch Status /dev/rfkill Watch.
Dec 04 03:29:29 32core systemd[1]: Starting ifupdown2-pre.service -
Helper to synchronize boot up for ifupdown...
Dec 04 03:29:29 32core systemd[1]: Starting
systemd-fsck@dev-disk-by\x2duuid-9EA6\x2dDCA3.service - File System
Check on /dev/disk/by-uuid/9EA6-DCA3...
Dec 04 03:29:29 32core systemd[1]: Starting
systemd-udev-settle.service - Wait for udev To Complete Device
Initialization...
Dec 04 03:29:29 32core udevadm[1208]: systemd-udev-settle.service is
deprecated. Please fix zfs-import-scan.service,
zfs-import-cache.service not to pull it in.
Dec 04 03:29:29 32core systemd[1]: Finished
systemd-fsck@dev-disk-by\x2duuid-9EA6\x2dDCA3.service - File System
Check on /dev/disk/by-uuid/9EA6-DCA3.
Dec 04 03:29:29 32core systemd[1]: Finished
systemd-journal-flush.service - Flush Journal to Persistent Storage.
Dec 04 03:29:29 32core kernel: kvm_amd: TSC scaling supported
Dec 04 03:29:29 32core kernel: kvm_amd: Nested Virtualization enabled
Dec 04 03:29:29 32core kernel: kvm_amd: Nested Paging enabled
Dec 04 03:29:29 32core kernel: kvm_amd: LBR virtualization supported
Dec 04 03:29:29 32core kernel: kvm_amd: SEV disabled (ASIDs 1 - 509)
Dec 04 03:29:29 32core kernel: kvm_amd: SEV-ES disabled (ASIDs 0 - 0)
Dec 04 03:29:29 32core kernel: kvm_amd: Virtual VMLOAD VMSAVE supported
Dec 04 03:29:29 32core kernel: kvm_amd: Virtual GIF supported
Dec 04 03:29:29 32core kernel: snd_hda_intel 0000:01:00.1: Force to
non-snoop mode
Dec 04 03:29:29 32core kernel: snd_hda_intel 0000:22:00.4: enabling
device (0000 -> 0002)
Dec 04 03:29:29 32core kernel: snd_hda_intel 0000:22:00.4: no codecs found!
Dec 04 03:29:29 32core kernel: ZFS: Loaded module v2.3.4-pve1, ZFS
pool version 5000, ZFS filesystem version 5
Dec 04 03:29:29 32core systemd-modules-load[916]: Inserted module 'zfs'
Dec 04 03:29:29 32core systemd[1]: Finished
systemd-modules-load.service - Load Kernel Modules.
Dec 04 03:29:29 32core kernel: [drm] radeon kernel modesetting enabled.
Dec 04 03:29:29 32core systemd[1]: Starting systemd-sysctl.service -
Apply Kernel Variables...
Dec 04 03:29:29 32core kernel: MCE: In-kernel MCE decoding enabled.
Dec 04 03:29:29 32core systemd[1]: Reached target sound.target - Sound Card=
.
Dec 04 03:29:29 32core kernel: input: HDA ATI HDMI HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:01.1/0000:01:00.1/sound/card1/input13
Dec 04 03:29:29 32core kernel: Console: switching to colour dummy device 80=
x25
Dec 04 03:29:29 32core systemd[1]: Finished systemd-sysctl.service -
Apply Kernel Variables.
Dec 04 03:29:29 32core kernel: radeon 0000:01:00.0: vgaarb: deactivate
vga console
Dec 04 03:29:29 32core kernel: [drm] initializing kernel modesetting
(OLAND 0x1002:0x6613 0x1002:0x2B0A 0x81).
Dec 04 03:29:29 32core kernel: ATOM BIOS: C57701
Dec 04 03:29:29 32core kernel: radeon 0000:01:00.0: VRAM: 1024M
0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
Dec 04 03:29:29 32core kernel: radeon 0000:01:00.0: GTT: 2048M
0x0000000040000000 - 0x00000000BFFFFFFF
Dec 04 03:29:29 32core kernel: [drm] Detected VRAM RAM=3D1024M, BAR=3D256M
Dec 04 03:29:29 32core kernel: [drm] RAM width 128bits DDR
Dec 04 03:29:29 32core kernel: [drm] radeon: 1024M of VRAM memory ready
Dec 04 03:29:29 32core kernel: [drm] radeon: 2048M of GTT memory ready.
Dec 04 03:29:29 32core kernel: [drm] Loading oland Microcode
Dec 04 03:29:29 32core kernel: [drm] Internal thermal controller with
fan control
Dec 04 03:29:29 32core kernel: [drm] radeon: dpm initialized
Dec 04 03:29:29 32core kernel: [drm] GART: num cpu pages 524288, num
gpu pages 524288
Dec 04 03:29:29 32core kernel: intel_rapl_common: Found RAPL domain package
Dec 04 03:29:29 32core kernel: intel_rapl_common: Found RAPL domain core
Dec 04 03:29:29 32core kernel: amd_atl: AMD Address Translation
Library initialized
Dec 04 03:29:29 32core kernel: [drm] PCIE GART of 2048M enabled (table
at 0x0000000000165000).
Dec 04 03:29:29 32core kernel: radeon 0000:01:00.0: WB enabled
Dec 04 03:29:29 32core kernel: radeon 0000:01:00.0: fence driver on
ring 0 uses gpu addr 0x0000000040000c00
Dec 04 03:29:29 32core kernel: radeon 0000:01:00.0: fence driver on
ring 1 uses gpu addr 0x0000000040000c04
Dec 04 03:29:29 32core kernel: radeon 0000:01:00.0: fence driver on
ring 2 uses gpu addr 0x0000000040000c08
Dec 04 03:29:29 32core kernel: radeon 0000:01:00.0: fence driver on
ring 3 uses gpu addr 0x0000000040000c0c
Dec 04 03:29:29 32core kernel: radeon 0000:01:00.0: fence driver on
ring 4 uses gpu addr 0x0000000040000c10
Dec 04 03:29:29 32core kernel: radeon 0000:01:00.0: fence driver on
ring 5 uses gpu addr 0x0000000000075a18
Dec 04 03:29:29 32core kernel: radeon 0000:01:00.0: radeon: MSI
limited to 32-bit
Dec 04 03:29:29 32core kernel: radeon 0000:01:00.0: radeon: using MSI.
Dec 04 03:29:29 32core kernel: [drm] radeon: irq initialized.
Dec 04 03:29:29 32core systemd[1]: Mounting boot-efi.mount - /boot/efi...
Dec 04 03:29:29 32core systemd[1]: Mounting
mnt-pve-asgard\x2d2tb.mount - Mount storage 'asgard-2tb' under
/mnt/pve...
Dec 04 03:29:29 32core systemd[1]: tmp.mount: Directory /tmp to mount
over is not empty, mounting anyway.
Dec 04 03:29:29 32core systemd[1]: Mounting tmp.mount - Temporary
Directory /tmp...
Dec 04 03:29:29 32core kernel: [drm] ring test on 0 succeeded in 1 usecs
Dec 04 03:29:29 32core kernel: [drm] ring test on 1 succeeded in 1 usecs
Dec 04 03:29:29 32core kernel: [drm] ring test on 2 succeeded in 1 usecs
Dec 04 03:29:29 32core kernel: [drm] ring test on 3 succeeded in 3 usecs
Dec 04 03:29:29 32core kernel: [drm] ring test on 4 succeeded in 3 usecs
Dec 04 03:29:30 32core kernel: [drm] ring test on 5 succeeded in 1 usecs
Dec 04 03:29:30 32core kernel: [drm] UVD initialized successfully.
Dec 04 03:29:30 32core kernel: snd_hda_intel 0000:01:00.1: bound
0000:01:00.0 (ops radeon_audio_component_bind_ops [radeon])
Dec 04 03:29:30 32core kernel: [drm] ib test on ring 0 succeeded in 0 usecs
Dec 04 03:29:30 32core kernel: [drm] ib test on ring 1 succeeded in 0 usecs
Dec 04 03:29:30 32core kernel: [drm] ib test on ring 2 succeeded in 0 usecs
Dec 04 03:29:30 32core kernel: [drm] ib test on ring 3 succeeded in 0 usecs
Dec 04 03:29:30 32core kernel: [drm] ib test on ring 4 succeeded in 0 usecs
Dec 04 03:29:30 32core kernel: [drm] ib test on ring 5 succeeded
Dec 04 03:29:30 32core kernel: [drm] Radeon Display Connectors
Dec 04 03:29:30 32core kernel: [drm] Connector 0:
Dec 04 03:29:30 32core kernel: [drm]   HDMI-A-1
Dec 04 03:29:30 32core kernel: [drm]   HPD1
Dec 04 03:29:30 32core kernel: [drm]   DDC: 0x6540 0x6540 0x6544
0x6544 0x6548 0x6548 0x654c 0x654c
Dec 04 03:29:30 32core kernel: [drm]   Encoders:
Dec 04 03:29:30 32core kernel: [drm]     DFP1: INTERNAL_UNIPHY
Dec 04 03:29:30 32core kernel: [drm] Connector 1:
Dec 04 03:29:30 32core kernel: [drm]   DVI-D-1
Dec 04 03:29:30 32core kernel: [drm]   HPD2
Dec 04 03:29:30 32core kernel: [drm]   DDC: 0x6530 0x6530 0x6534
0x6534 0x6538 0x6538 0x653c 0x653c
Dec 04 03:29:30 32core kernel: [drm]   Encoders:
Dec 04 03:29:30 32core kernel: [drm]     DFP2: INTERNAL_UNIPHY
Dec 04 03:29:30 32core kernel: [drm] Connector 2:
Dec 04 03:29:30 32core kernel: [drm]   VGA-1
Dec 04 03:29:30 32core kernel: [drm]   DDC: 0x65c0 0x65c0 0x65c4
0x65c4 0x65c8 0x65c8 0x65cc 0x65cc
Dec 04 03:29:30 32core kernel: [drm]   Encoders:
Dec 04 03:29:30 32core kernel: [drm]     CRT1: INTERNAL_KLDSCP_DAC1
Dec 04 03:29:30 32core kernel: [drm] Initialized radeon 2.51.0 for
0000:01:00.0 on minor 0
Dec 04 03:29:30 32core kernel: [drm] fb mappable at 0xD0571000
Dec 04 03:29:30 32core kernel: [drm] vram apper at 0xD0000000
Dec 04 03:29:30 32core kernel: [drm] size 35389440
Dec 04 03:29:30 32core kernel: [drm] fb depth is 24
Dec 04 03:29:30 32core kernel: [drm]    pitch is 16384
Dec 04 03:29:30 32core kernel: fbcon: radeondrmfb (fb0) is primary device
Dec 04 03:29:30 32core kernel: Console: switching to colour frame
buffer device 256x67
Dec 04 03:29:30 32core kernel: radeon 0000:01:00.0: [drm] fb0:
radeondrmfb frame buffer device
Dec 04 03:29:31 32core systemd[1]: Mounted tmp.mount - Temporary Directory =
/tmp.
Dec 04 03:29:31 32core systemd[1]: Mounted boot-efi.mount - /boot/efi.
Dec 04 03:29:31 32core kernel: EXT4-fs (nvme1n1p1): recovery complete
Dec 04 03:29:31 32core kernel: EXT4-fs (nvme1n1p1): mounted filesystem
c1ab544a-4190-426a-8cdd-8d6af66f97fa r/w with ordered data mode. Quota
mode: none.
Dec 04 03:29:31 32core systemd[1]: Mounted mnt-pve-asgard\x2d2tb.mount
- Mount storage 'asgard-2tb' under /mnt/pve.
Dec 04 03:29:32 32core kernel: radeon 0000:4d:00.0: enabling device
(0000 -> 0003)
Dec 04 03:29:32 32core kernel: [drm] initializing kernel modesetting
(RV380 0x1002:0x5B64 0x1002:0x0102 0x80).
Dec 04 03:29:32 32core kernel: [drm] amdgpu kernel modesetting enabled.
Dec 04 03:29:32 32core kernel: amdgpu: Virtual CRAT table created for CPU
Dec 04 03:29:32 32core kernel: amdgpu: Topology: Add CPU node
Dec 04 03:29:32 32core kernel: [drm] GPU not posted. posting now...
Dec 04 03:29:32 32core kernel: [drm] Generation 2 PCI interface, using
max accessible memory
Dec 04 03:29:32 32core kernel: radeon 0000:4d:00.0: VRAM: 128M
0x00000000B0000000 - 0x00000000B7FFFFFF (128M used)
Dec 04 03:29:32 32core kernel: radeon 0000:4d:00.0: GTT: 2048M
0x0000000030000000 - 0x00000000AFFFFFFF
Dec 04 03:29:32 32core kernel: debugfs: 'radeon_gpu_reset' already exists i=
n '/'
Dec 04 03:29:32 32core kernel: debugfs: 'radeon_fence_info' already
exists in '/'
Dec 04 03:29:32 32core kernel: [drm] Detected VRAM RAM=3D128M, BAR=3D128M
Dec 04 03:29:32 32core kernel: [drm] RAM width 128bits DDR
Dec 04 03:29:32 32core kernel: [drm] radeon: 128M of VRAM memory ready
Dec 04 03:29:32 32core kernel: [drm] radeon: 2048M of GTT memory ready.
Dec 04 03:29:32 32core kernel: debugfs: 'radeon_vram' already exists in '/'
Dec 04 03:29:32 32core kernel: debugfs: 'radeon_gtt' already exists in '/'
Dec 04 03:29:32 32core kernel: debugfs: 'ttm_page_pool' already exists in '=
/'
Dec 04 03:29:32 32core kernel: debugfs: 'radeon_vram_mm' already exists in =
'/'
Dec 04 03:29:32 32core kernel: debugfs: 'radeon_gtt_mm' already exists in '=
/'
Dec 04 03:29:32 32core kernel: [drm] GART: num cpu pages 524288, num
gpu pages 524288
Dec 04 03:29:32 32core kernel: [drm] radeon: 1 quad pipes, 1 Z pipes initia=
lized
Dec 04 03:29:32 32core kernel: [drm] PCIE GART of 2048M enabled (table
at 0x00000000B0040000).
Dec 04 03:29:32 32core kernel: radeon 0000:4d:00.0: WB enabled
Dec 04 03:29:32 32core kernel: radeon 0000:4d:00.0: fence driver on
ring 0 uses gpu addr 0x0000000030000000
Dec 04 03:29:32 32core kernel: radeon 0000:4d:00.0: radeon: MSI
limited to 32-bit
Dec 04 03:29:32 32core kernel: radeon 0000:4d:00.0: radeon: using MSI.
Dec 04 03:29:32 32core kernel: [drm] radeon: irq initialized.
Dec 04 03:29:32 32core kernel: [drm] Loading R300 Microcode
Dec 04 03:29:32 32core kernel: debugfs: 'radeon_ring_gfx' already exists in=
 '/'
Dec 04 03:29:32 32core kernel: [drm] radeon: ring at 0x0000000030001000
Dec 04 03:29:32 32core kernel: [drm] ring test succeeded in 1 usecs
Dec 04 03:29:32 32core kernel: debugfs: 'radeon_sa_info' already exists in =
'/'
Dec 04 03:29:32 32core kernel: debugfs: 'radeon_gem_info' already exists in=
 '/'
Dec 04 03:29:32 32core kernel: [drm] ib test succeeded in 0 usecs
Dec 04 03:29:32 32core kernel: [drm] Radeon Display Connectors
Dec 04 03:29:32 32core kernel: [drm] Connector 0:
Dec 04 03:29:32 32core kernel: [drm]   VGA-2
Dec 04 03:29:32 32core kernel: [drm]   DDC: 0x60 0x60 0x60 0x60 0x60
0x60 0x60 0x60
Dec 04 03:29:32 32core kernel: [drm]   Encoders:
Dec 04 03:29:32 32core kernel: [drm]     CRT1: INTERNAL_DAC1
Dec 04 03:29:32 32core kernel: [drm] Connector 1:
Dec 04 03:29:32 32core kernel: [drm]   DVI-I-1
Dec 04 03:29:32 32core kernel: [drm]   HPD1
Dec 04 03:29:32 32core kernel: [drm]   DDC: 0x64 0x64 0x64 0x64 0x64
0x64 0x64 0x64
Dec 04 03:29:32 32core kernel: [drm]   Encoders:
Dec 04 03:29:32 32core kernel: [drm]     CRT2: INTERNAL_DAC2
Dec 04 03:29:32 32core kernel: [drm]     DFP1: INTERNAL_TMDS1
Dec 04 03:29:32 32core kernel: [drm] Initialized radeon 2.51.0 for
0000:4d:00.0 on minor 1
Dec 04 03:29:32 32core kernel: radeon 0000:4d:00.0: [drm] Cannot find
any crtc or sizes
Dec 04 03:29:32 32core kernel: radeon 0000:4d:00.0: [drm] Cannot find
any crtc or sizes
Dec 04 03:29:32 32core kernel: radeon 0000:4d:00.0: [drm] Cannot find
any crtc or sizes
Dec 04 03:29:32 32core kernel: usbcore: registered new interface
driver snd-usb-audio
Dec 04 03:29:32 32core kernel: Bluetooth: Core ver 2.22
Dec 04 03:29:32 32core kernel: cfg80211: Loading compiled-in X.509
certificates for regulatory database
Dec 04 03:29:32 32core kernel: Loaded X.509 cert 'benh@debian.org:
577e021cb980e0e820821ba7b54b4961b8b4fadf'
Dec 04 03:29:32 32core kernel: Loaded X.509 cert
'romain.perier@gmail.com: 3abbc6ec146e09d1b6016ab9d6cf71dd233f0328'
Dec 04 03:29:32 32core kernel: Loaded X.509 cert 'sforshee: 00b28ddf47aef9c=
ea7'
Dec 04 03:29:32 32core kernel: Loaded X.509 cert 'wens:
61c038651aabdcf94bd0ac7ff06c7248db18c600'
Dec 04 03:29:32 32core kernel: faux_driver regulatory: Direct firmware
load for regulatory.db failed with error -2
Dec 04 03:29:32 32core kernel: cfg80211: failed to load regulatory.db
Dec 04 03:29:32 32core kernel: NET: Registered PF_BLUETOOTH protocol family
Dec 04 03:29:32 32core kernel: Bluetooth: HCI device and connection
manager initialized
Dec 04 03:29:32 32core kernel: Bluetooth: HCI socket layer initialized
Dec 04 03:29:32 32core kernel: Bluetooth: L2CAP socket layer initialized
Dec 04 03:29:32 32core kernel: Bluetooth: SCO socket layer initialized
Dec 04 03:29:32 32core kernel: iwlwifi 0000:46:00.0: enabling device
(0000 -> 0002)
Dec 04 03:29:32 32core kernel: iwlwifi 0000:46:00.0: Detected crf-id
0x3617, cnv-id 0x100530 wfpm id 0x80000000
Dec 04 03:29:32 32core kernel: iwlwifi 0000:46:00.0: PCI dev
2723/0084, rev=3D0x340, rfid=3D0x10a100
Dec 04 03:29:32 32core kernel: iwlwifi 0000:46:00.0: Detected Intel(R)
Wi-Fi 6 AX200 160MHz
Dec 04 03:29:32 32core kernel: usbcore: registered new interface driver btu=
sb
Dec 04 03:29:32 32core systemd[1]: Starting systemd-rfkill.service -
Load/Save RF Kill Switch Status...
Dec 04 03:29:32 32core systemd[1]: Reached target bluetooth.target -
Bluetooth Support.
Dec 04 03:29:32 32core kernel: iwlwifi 0000:46:00.0: loaded firmware
version 77.6eaf654b.0 cc-a0-77.ucode op_mode iwlmvm
Dec 04 03:29:32 32core systemd[1]: Started systemd-rfkill.service -
Load/Save RF Kill Switch Status.
Dec 04 03:29:32 32core kernel: Bluetooth: hci0: Found device firmware:
intel/ibt-20-1-3.sfi
Dec 04 03:29:32 32core kernel: Bluetooth: hci0: Boot Address: 0x24800
Dec 04 03:29:32 32core kernel: Bluetooth: hci0: Firmware Version: 193-33.24
Dec 04 03:29:32 32core kernel: Bluetooth: hci0: Firmware already loaded
Dec 04 03:29:32 32core kernel: Bluetooth: hci0: HCI LE Coded PHY
feature bit is set, but its usage is not supported.
Dec 04 03:29:32 32core systemd[1]: Finished
systemd-udev-settle.service - Wait for udev To Complete Device
Initialization.
Dec 04 03:29:32 32core systemd[1]: zfs-import-cache.service - Import
ZFS pools by cache file was skipped because of an unmet condition
check (ConditionFileNotEmpty=3D/etc/zfs/zpool.cache).
Dec 04 03:29:32 32core systemd[1]: Starting zfs-import-scan.service -
Import ZFS pools by device scanning...
Dec 04 03:29:32 32core systemd[1]: Finished ifupdown2-pre.service -
Helper to synchronize boot up for ifupdown.
Dec 04 03:29:33 32core zpool[1304]: no pools available to import
Dec 04 03:29:33 32core systemd[1]: Finished zfs-import-scan.service -
Import ZFS pools by device scanning.
Dec 04 03:29:33 32core systemd[1]: Reached target zfs-import.target -
ZFS pool import target.
Dec 04 03:29:33 32core systemd[1]: Starting zfs-mount.service - Mount
ZFS filesystems...
Dec 04 03:29:33 32core systemd[1]: Starting zfs-volume-wait.service -
Wait for ZFS Volume (zvol) links in /dev...
Dec 04 03:29:33 32core zvol_wait[1370]: No zvols found, nothing to do.
Dec 04 03:29:33 32core systemd[1]: Finished zfs-mount.service - Mount
ZFS filesystems.
Dec 04 03:29:33 32core systemd[1]: Finished zfs-volume-wait.service -
Wait for ZFS Volume (zvol) links in /dev.
Dec 04 03:29:33 32core systemd[1]: Reached target local-fs.target -
Local File Systems.
Dec 04 03:29:33 32core systemd[1]: Reached target zfs-volumes.target -
ZFS volumes are ready.
Dec 04 03:29:33 32core systemd[1]: Listening on systemd-sysext.socket
- System Extension Image Management.
Dec 04 03:29:33 32core kernel: iwlwifi 0000:46:00.0: Detected RF HR
B3, rfid=3D0x10a100
Dec 04 03:29:33 32core systemd[1]: Starting apparmor.service - Load
AppArmor profiles...
Dec 04 03:29:33 32core systemd[1]: Starting console-setup.service -
Set console font and keymap...
Dec 04 03:29:33 32core systemd[1]: Starting networking.service -
Network initialization...
Dec 04 03:29:33 32core systemd[1]: Starting pvebanner.service -
Proxmox VE Login Banner...
Dec 04 03:29:33 32core systemd[1]: Starting pvefw-logger.service -
Proxmox VE firewall logger...
Dec 04 03:29:33 32core systemd[1]: Starting pvenetcommit.service -
Commit Proxmox VE network changes...
Dec 04 03:29:33 32core systemd[1]: Starting systemd-binfmt.service -
Set Up Additional Binary Formats...
Dec 04 03:29:33 32core systemd[1]: Starting
systemd-tmpfiles-setup.service - Create System Files and
Directories...
Dec 04 03:29:33 32core systemd[1]: Finished console-setup.service -
Set console font and keymap.
Dec 04 03:29:33 32core apparmor.systemd[1377]: Restarting AppArmor
Dec 04 03:29:33 32core apparmor.systemd[1377]: Reloading AppArmor profiles
Dec 04 03:29:33 32core networking[1379]: networking: Configuring
network interfaces
Dec 04 03:29:33 32core systemd[1]: proc-sys-fs-binfmt_misc.automount:
Got automount request for /proc/sys/fs/binfmt_misc, triggered by 1385
(systemd-binfmt)
Dec 04 03:29:33 32core systemd[1]: Mounting
proc-sys-fs-binfmt_misc.mount - Arbitrary Executable File Formats File
System...
Dec 04 03:29:33 32core systemd-tmpfiles[1387]:
/usr/lib/tmpfiles.d/legacy.conf:14: Duplicate line for path
"/run/lock", ignoring.
Dec 04 03:29:33 32core pvefw-logger[1405]: starting pvefw logger
Dec 04 03:29:33 32core systemd[1]: Finished pvenetcommit.service -
Commit Proxmox VE network changes.
Dec 04 03:29:33 32core systemd[1]: Started pvefw-logger.service -
Proxmox VE firewall logger.
Dec 04 03:29:33 32core kernel: audit: type=3D1400
audit(1764790173.086:2): apparmor=3D"STATUS" operation=3D"profile_load"
profile=3D"unconfined" name=3D"linux-sandbox" pid=3D1440
comm=3D"apparmor_parser"
Dec 04 03:29:33 32core kernel: audit: type=3D1400
audit(1764790173.086:3): apparmor=3D"STATUS" operation=3D"profile_load"
profile=3D"unconfined" name=3D"QtWebEngineProcess" pid=3D1410
comm=3D"apparmor_parser"
Dec 04 03:29:33 32core kernel: audit: type=3D1400
audit(1764790173.086:4): apparmor=3D"STATUS" operation=3D"profile_load"
profile=3D"unconfined" name=3D"1password" pid=3D1407 comm=3D"apparmor_parse=
r"
Dec 04 03:29:33 32core kernel: audit: type=3D1400
audit(1764790173.086:5): apparmor=3D"STATUS" operation=3D"profile_load"
profile=3D"unconfined" name=3D"chromium" pid=3D1420 comm=3D"apparmor_parser=
"
Dec 04 03:29:33 32core kernel: audit: type=3D1400
audit(1764790173.087:6): apparmor=3D"STATUS" operation=3D"profile_load"
profile=3D"unconfined" name=3D"balena-etcher" pid=3D1412
comm=3D"apparmor_parser"
Dec 04 03:29:33 32core kernel: audit: type=3D1400
audit(1764790173.087:7): apparmor=3D"STATUS" operation=3D"profile_load"
profile=3D"unconfined" name=3D"lc-compliance" pid=3D1438
comm=3D"apparmor_parser"
Dec 04 03:29:33 32core kernel: audit: type=3D1400
audit(1764790173.087:8): apparmor=3D"STATUS" operation=3D"profile_load"
profile=3D"unconfined" name=3D"github-desktop" pid=3D1433
comm=3D"apparmor_parser"
Dec 04 03:29:33 32core kernel: audit: type=3D1400
audit(1764790173.087:9): apparmor=3D"STATUS" operation=3D"profile_load"
profile=3D"unconfined" name=3D"vscode" pid=3D1421 comm=3D"apparmor_parser"
Dec 04 03:29:33 32core kernel: audit: type=3D1400
audit(1764790173.087:10): apparmor=3D"STATUS" operation=3D"profile_load"
profile=3D"unconfined" name=3D"ch-checkns" pid=3D1417 comm=3D"apparmor_pars=
er"
Dec 04 03:29:33 32core kernel: audit: type=3D1400
audit(1764790173.087:11): apparmor=3D"STATUS" operation=3D"profile_load"
profile=3D"unconfined" name=3D"loupe" pid=3D1441 comm=3D"apparmor_parser"
Dec 04 03:29:33 32core systemd[1]: Mounted
proc-sys-fs-binfmt_misc.mount - Arbitrary Executable File Formats File
System.
Dec 04 03:29:33 32core systemd[1]: Finished systemd-binfmt.service -
Set Up Additional Binary Formats.
Dec 04 03:29:33 32core systemd[1]: Finished
systemd-tmpfiles-setup.service - Create System Files and Directories.
Dec 04 03:29:33 32core systemd[1]: Mounting run-rpc_pipefs.mount - RPC
Pipe File System...
Dec 04 03:29:33 32core systemd[1]: ldconfig.service - Rebuild Dynamic
Linker Cache was skipped because no trigger condition checks were met.
Dec 04 03:29:33 32core systemd[1]: Starting rpcbind.service - RPC bind
portmap service...
Dec 04 03:29:33 32core systemd[1]: systemd-firstboot.service - First
Boot Wizard was skipped because of an unmet condition check
(ConditionFirstBoot=3Dyes).
Dec 04 03:29:33 32core systemd[1]: first-boot-complete.target - First
Boot Complete was skipped because of an unmet condition check
(ConditionFirstBoot=3Dyes).
Dec 04 03:29:33 32core systemd[1]:
systemd-journal-catalog-update.service - Rebuild Journal Catalog was
skipped because of an unmet condition check
(ConditionNeedsUpdate=3D/var).
Dec 04 03:29:33 32core systemd[1]: systemd-machine-id-commit.service -
Save Transient machine-id to Disk was skipped because of an unmet
condition check (ConditionPathIsMountPoint=3D/etc/machine-id).
Dec 04 03:29:33 32core systemd[1]: systemd-update-done.service -
Update is Completed was skipped because no trigger condition checks
were met.
Dec 04 03:29:33 32core systemd[1]: Finished apparmor.service - Load
AppArmor profiles.
Dec 04 03:29:33 32core systemd[1]: Reached target sysinit.target -
System Initialization.
Dec 04 03:29:33 32core systemd[1]: Started apt-daily.timer - Daily apt
download activities.
Dec 04 03:29:33 32core systemd[1]: Started apt-daily-upgrade.timer -
Daily apt upgrade and clean activities.
Dec 04 03:29:33 32core systemd[1]: Started dpkg-db-backup.timer -
Daily dpkg database backup timer.
Dec 04 03:29:33 32core systemd[1]: Started e2scrub_all.timer -
Periodic ext4 Online Metadata Check for All Filesystems.
Dec 04 03:29:33 32core systemd[1]: Started fstrim.timer - Discard
unused filesystem blocks once a week.
Dec 04 03:29:33 32core systemd[1]: Started fwupd-refresh.timer -
Refresh fwupd metadata regularly.
Dec 04 03:29:33 32core systemd[1]: Started logrotate.timer - Daily
rotation of log files.
Dec 04 03:29:33 32core systemd[1]: Started man-db.timer - Daily man-db
regeneration.
Dec 04 03:29:33 32core systemd[1]: Started pve-daily-update.timer -
Daily PVE download activities.
Dec 04 03:29:33 32core systemd[1]: Started
systemd-tmpfiles-clean.timer - Daily Cleanup of Temporary Directories.
Dec 04 03:29:33 32core systemd[1]: Started xfs_scrub_all.timer -
Periodic XFS Online Metadata Check for All Filesystems.
Dec 04 03:29:33 32core systemd[1]: Reached target timers.target - Timer Uni=
ts.
Dec 04 03:29:33 32core systemd[1]: Listening on dbus.socket - D-Bus
System Message Bus Socket.
Dec 04 03:29:33 32core systemd[1]: Listening on iscsid.socket -
Open-iSCSI iscsid Socket.
Dec 04 03:29:33 32core systemd[1]: Listening on
netavark-dhcp-proxy.socket - Netavark DHCP proxy socket.
Dec 04 03:29:33 32core systemd[1]: Listening on rrdcached.socket -
sockets activating rrdcached.
Dec 04 03:29:33 32core systemd[1]: Listening on sshd-unix-local.socket
- OpenSSH Server Socket (systemd-ssh-generator, AF_UNIX Local).
Dec 04 03:29:33 32core systemd[1]: Listening on
systemd-hostnamed.socket - Hostname Service Socket.
Dec 04 03:29:33 32core systemd[1]: Reached target sockets.target - Socket U=
nits.
Dec 04 03:29:33 32core systemd[1]: systemd-pcrphase-sysinit.service -
TPM PCR Barrier (Initialization) was skipped because of an unmet
condition check (ConditionSecurity=3Dmeasured-uki).
Dec 04 03:29:33 32core systemd[1]: Reached target basic.target - Basic Syst=
em.
Dec 04 03:29:33 32core systemd[1]: System is tainted: unmerged-bin
Dec 04 03:29:33 32core kernel: iwlwifi 0000:46:00.0: base HW address:
50:e0:85:f3:21:e5
Dec 04 03:29:33 32core systemd[1]: Starting chrony.service - chrony,
an NTP client/server...
Dec 04 03:29:33 32core systemd[1]: Starting dbus.service - D-Bus
System Message Bus...
Dec 04 03:29:33 32core systemd[1]: Starting e2scrub_reap.service -
Remove Stale Online ext4 Metadata Check Snapshots...
Dec 04 03:29:33 32core systemd[1]: getty-static.service - getty on
tty2-tty6 if dbus and logind are not available was skipped because of
an unmet condition check (ConditionPathExists=3D!/usr/bin/dbus-daemon).
Dec 04 03:29:33 32core systemd[1]: Starting grub-common.service -
Record successful boot for GRUB...
Dec 04 03:29:33 32core systemd[1]: Starting hardinfo2.service -
Hardinfo2 support for root access...
Dec 04 03:29:33 32core systemd[1]: Starting ksmtuned.service - Kernel
Samepage Merging (KSM) Tuning Daemon...
Dec 04 03:29:33 32core systemd[1]: Starting lm-sensors.service -
Initialize hardware monitoring sensors...
Dec 04 03:29:33 32core systemd[1]: Starting lxcfs.service - FUSE
filesystem for LXC...
Dec 04 03:29:33 32core systemd[1]: Starting
netavark-dhcp-proxy.service - Netavark DHCP proxy service...
Dec 04 03:29:33 32core systemd[1]: Starting polkit.service -
Authorization Manager...
Dec 04 03:29:33 32core systemd[1]: proxmox-boot-cleanup.service -
Clean up bootloader next-boot setting was skipped because of an unmet
condition check (ConditionPathExists=3D/etc/kernel/next-boot-pin).
Dec 04 03:29:33 32core systemd[1]: Starting pve-lxc-syscalld.service -
Proxmox VE LXC Syscall Daemon...
Dec 04 03:29:33 32core systemd[1]: Starting
pve-query-machine-capabilities.service - PVE Query Machine
Capabilities...
Dec 04 03:29:33 32core systemd[1]: Starting qmeventd.service - PVE
Qemu Event Daemon...
Dec 04 03:29:33 32core systemd[1]: Started rrdcached.service - Data
caching daemon for rrdtool.
Dec 04 03:29:33 32core systemd[1]: Starting rsyslog.service - System
Logging Service...
Dec 04 03:29:33 32core systemd[1]: Starting smartmontools.service -
Self Monitoring and Reporting Technology (SMART) Daemon...
Dec 04 03:29:33 32core systemd[1]: sshd-keygen.service - Generate sshd
host keys on first boot was skipped because of an unmet condition
check (ConditionFirstBoot=3Dyes).
Dec 04 03:29:33 32core query-machine-capabilities[1543]: AuthenticAMD
Dec 04 03:29:33 32core systemd[1]: Starting systemd-logind.service -
User Login Management...
Dec 04 03:29:33 32core systemd[1]: Starting udisks2.service - Disk Manager.=
..
Dec 04 03:29:33 32core systemd[1]: Started watchdog-mux.service -
Proxmox VE watchdog multiplexer.
Dec 04 03:29:33 32core systemd[1]: Starting zfs-share.service - ZFS
file system shares...
Dec 04 03:29:33 32core systemd[1]: Started zfs-zed.service - ZFS Event
Daemon (zed).
Dec 04 03:29:33 32core systemd[1]: Started netavark-dhcp-proxy.service
- Netavark DHCP proxy service.
Dec 04 03:29:33 32core systemd[1]: Started rpcbind.service - RPC bind
portmap service.
Dec 04 03:29:33 32core systemd[1]: Started pve-lxc-syscalld.service -
Proxmox VE LXC Syscall Daemon.
Dec 04 03:29:33 32core systemd[1]: e2scrub_reap.service: Deactivated
successfully.
Dec 04 03:29:33 32core systemd[1]: Finished e2scrub_reap.service -
Remove Stale Online ext4 Metadata Check Snapshots.
Dec 04 03:29:33 32core systemd[1]: Started ksmtuned.service - Kernel
Samepage Merging (KSM) Tuning Daemon.
Dec 04 03:29:33 32core systemd[1]: Started lxcfs.service - FUSE
filesystem for LXC.
Dec 04 03:29:33 32core systemd[1]: Finished
pve-query-machine-capabilities.service - PVE Query Machine
Capabilities.
Dec 04 03:29:33 32core systemd[1]: Started qmeventd.service - PVE Qemu
Event Daemon.
Dec 04 03:29:33 32core systemd[1]: Finished zfs-share.service - ZFS
file system shares.
Dec 04 03:29:33 32core zed[1582]: ZFS Event Daemon 2.3.4-pve1 (PID 1582)
Dec 04 03:29:33 32core systemd[1]: Reached target rpcbind.target - RPC
Port Mapper.
Dec 04 03:29:33 32core systemd[1]: Reached target zfs.target - ZFS
startup target.
Dec 04 03:29:33 32core kernel: iwlwifi 0000:46:00.0 wlp70s0: renamed from w=
lan0
Dec 04 03:29:33 32core zed[1582]: Processing events since eid=3D0
Dec 04 03:29:33 32core udisksd[1558]: udisks daemon version 2.10.1 starting
Dec 04 03:29:33 32core lxcfs[1636]: Starting LXCFS at /usr/bin/lxcfs
Dec 04 03:29:33 32core watchdog-mux[1559]: Watchdog driver 'Software
Watchdog', version 0
Dec 04 03:29:33 32core kernel: softdog: initialized. soft_noboot=3D0
soft_margin=3D60 sec soft_panic=3D0 (nowayout=3D0)
Dec 04 03:29:33 32core kernel: softdog:
soft_reboot_cmd=3D<not set> soft_active_on_boot=3D0
Dec 04 03:29:33 32core smartd[1551]: smartd 7.4 2024-10-15 r5620
[x86_64-linux-6.17.2-2-pve] (local build)
Dec 04 03:29:33 32core smartd[1551]: Opened configuration file /etc/smartd.=
conf
Dec 04 03:29:33 32core smartd[1551]: Drive: DEVICESCAN, implied '-a'
Directive on line 18 of file /etc/smartd.conf
Dec 04 03:29:33 32core smartd[1551]: Configuration file
/etc/smartd.conf was parsed, found DEVICESCAN, scanning devices
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/sda [SAT], opened
Dec 04 03:29:33 32core lxcfs[1636]: Using runtime path /run
Dec 04 03:29:33 32core lxcfs[1636]: Running lxcfslib_init to reload liblxcf=
s
Dec 04 03:29:33 32core lxcfs[1636]: mount namespace: 7
Dec 04 03:29:33 32core lxcfs[1636]: hierarchies:
Dec 04 03:29:33 32core lxcfs[1636]:   0: fd:   8:
cpuset,cpu,io,memory,hugetlb,pids,rdma,misc,dmem
Dec 04 03:29:33 32core lxcfs[1636]: Kernel supports pidfds
Dec 04 03:29:33 32core lxcfs[1636]: Kernel supports swap accounting
Dec 04 03:29:33 32core lxcfs[1636]: api_extensions:
Dec 04 03:29:33 32core lxcfs[1636]: - cgroups
Dec 04 03:29:33 32core lxcfs[1636]: - sys_cpu_online
Dec 04 03:29:33 32core lxcfs[1636]: - proc_cpuinfo
Dec 04 03:29:33 32core lxcfs[1636]: - proc_diskstats
Dec 04 03:29:33 32core lxcfs[1636]: - proc_loadavg
Dec 04 03:29:33 32core lxcfs[1636]: - proc_meminfo
Dec 04 03:29:33 32core lxcfs[1636]: - proc_stat
Dec 04 03:29:33 32core lxcfs[1636]: - proc_swaps
Dec 04 03:29:33 32core lxcfs[1636]: - proc_uptime
Dec 04 03:29:33 32core lxcfs[1636]: - proc_slabinfo
Dec 04 03:29:33 32core lxcfs[1636]: - shared_pidns
Dec 04 03:29:33 32core lxcfs[1636]: - cpuview_daemon
Dec 04 03:29:33 32core lxcfs[1636]: - loadavg_daemon
Dec 04 03:29:33 32core lxcfs[1636]: - pidfds
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/sda [SAT], WDC
WD10JMVW-11S5XS0, S/N:WD-WXC1EC2KL905, WWN:5-0014ee-6ade71d74,
FW:01.01A01, 1.00 TB
Dec 04 03:29:33 32core dbus-daemon[1527]: [system] AppArmor D-Bus
mediation is enabled
Dec 04 03:29:33 32core systemd[1]: Started dbus.service - D-Bus System
Message Bus.
Dec 04 03:29:33 32core kernel: RPC: Registered named UNIX socket
transport module.
Dec 04 03:29:33 32core kernel: RPC: Registered udp transport module.
Dec 04 03:29:33 32core kernel: RPC: Registered tcp transport module.
Dec 04 03:29:33 32core kernel: RPC: Registered tcp-with-tls transport modul=
e.
Dec 04 03:29:33 32core kernel: RPC: Registered tcp NFSv4.1 backchannel
transport module.
Dec 04 03:29:33 32core systemd[1]: Mounted run-rpc_pipefs.mount - RPC
Pipe File System.
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/sda [SAT], found in
smartd database 7.3/5528: Western Digital Elements / My Passport (USB,
AF)
Dec 04 03:29:33 32core systemd[1]: grub-common.service: Deactivated
successfully.
Dec 04 03:29:33 32core systemd[1]: Finished grub-common.service -
Record successful boot for GRUB.
Dec 04 03:29:33 32core systemd[1]: Reached target rpc_pipefs.target.
Dec 04 03:29:33 32core systemd[1]: Starting nfs-blkmap.service - pNFS
block layout mapping daemon...
Dec 04 03:29:33 32core systemd[1]: rpc-gssd.service - RPC security
service for NFS client and server was skipped because of an unmet
condition check (ConditionPathExists=3D/etc/krb5.keytab).
Dec 04 03:29:33 32core addgroup[1542]: The group `hardinfo2' already exists=
.
Dec 04 03:29:33 32core systemd[1]: Reached target nfs-client.target -
NFS client services.
Dec 04 03:29:33 32core blkmapd[1691]: open pipe file
/run/rpc_pipefs/nfs/blocklayout failed: No such file or directory
Dec 04 03:29:33 32core systemd[1]: Started nfs-blkmap.service - pNFS
block layout mapping daemon.
Dec 04 03:29:33 32core systemd-logind[1555]: New seat seat0.
Dec 04 03:29:33 32core dbus-daemon[1527]: [system] Activating via
systemd: service name=3D'org.freedesktop.PolicyKit1'
unit=3D'polkit.service' requested by ':1.0' (uid=3D0 pid=3D1558
comm=3D"/usr/libexec/udisks2/udisksd" label=3D"unconfined")
Dec 04 03:29:33 32core systemd-logind[1555]: Watching system buttons
on /dev/input/event1 (Power Button)
Dec 04 03:29:33 32core systemd-logind[1555]: Watching system buttons
on /dev/input/event0 (Power Button)
Dec 04 03:29:33 32core chronyd[1703]: chronyd version 4.6.1 starting
(+CMDMON +NTP +REFCLOCK +RTC +PRIVDROP +SCFILTER +SIGND +ASYNCDNS +NTS
+SECHASH +IPV6 -DEBUG)
Dec 04 03:29:33 32core systemd-logind[1555]: Watching system buttons
on /dev/input/event3 (Logitech USB Receiver)
Dec 04 03:29:33 32core systemd-logind[1555]: Watching system buttons
on /dev/input/event5 (Logitech USB Receiver Consumer Control)
Dec 04 03:29:33 32core systemd-logind[1555]: Watching system buttons
on /dev/input/event6 (Logitech USB Receiver System Control)
Dec 04 03:29:33 32core systemd-logind[1555]: Watching system buttons
on /dev/input/event9 (Generic USB Audio Consumer Control)
Dec 04 03:29:33 32core chronyd[1703]: Loaded 0 symmetric keys
Dec 04 03:29:33 32core systemd[1]: Started systemd-logind.service -
User Login Management.
Dec 04 03:29:33 32core chronyd[1703]: Using leap second list
/usr/share/zoneinfo/leap-seconds.list
Dec 04 03:29:33 32core chronyd[1703]: Frequency -27.572 +/- 2.569 ppm
read from /var/lib/chrony/chrony.drift
Dec 04 03:29:33 32core chronyd[1703]: Loaded seccomp filter (level 1)
Dec 04 03:29:33 32core systemd[1]: Started chrony.service - chrony, an
NTP client/server.
Dec 04 03:29:33 32core rsyslogd[1550]: imuxsock: Acquired UNIX socket
'/run/systemd/journal/syslog' (fd 3) from systemd.  [v8.2504.0]
Dec 04 03:29:33 32core rsyslogd[1550]: [origin software=3D"rsyslogd"
swVersion=3D"8.2504.0" x-pid=3D"1550" x-info=3D"https://www.rsyslog.com"]
start
Dec 04 03:29:33 32core systemd[1]: Started rsyslog.service - System
Logging Service.
Dec 04 03:29:33 32core polkitd[1538]: Started polkitd version 126
Dec 04 03:29:33 32core polkitd[1538]: Loading rules from directory
/etc/polkit-1/rules.d
Dec 04 03:29:33 32core polkitd[1538]: Loading rules from directory
/run/polkit-1/rules.d
Dec 04 03:29:33 32core polkitd[1538]: Error opening rules directory:
Error opening directory =E2=80=9C/run/polkit-1/rules.d=E2=80=9D: No such fi=
le or
directory (g-file-error-quark, 4)
Dec 04 03:29:33 32core systemd[1]: hardinfo2.service: Deactivated successfu=
lly.
Dec 04 03:29:33 32core polkitd[1538]: Loading rules from directory
/usr/local/share/polkit-1/rules.d
Dec 04 03:29:33 32core polkitd[1538]: Error opening rules directory:
Error opening directory =E2=80=9C/usr/local/share/polkit-1/rules.d=E2=80=9D=
: No such
file or directory (g-file-error-quark, 4)
Dec 04 03:29:33 32core polkitd[1538]: Loading rules from directory
/usr/share/polkit-1/rules.d
Dec 04 03:29:33 32core systemd[1]: Finished hardinfo2.service -
Hardinfo2 support for root access.
Dec 04 03:29:33 32core polkitd[1538]: Finished loading, compiling and
executing 4 rules
Dec 04 03:29:33 32core systemd[1]: Started polkit.service -
Authorization Manager.
Dec 04 03:29:33 32core dbus-daemon[1527]: [system] Successfully
activated service 'org.freedesktop.PolicyKit1'
Dec 04 03:29:33 32core polkitd[1538]: Acquired the name
org.freedesktop.PolicyKit1 on the system bus
Dec 04 03:29:33 32core systemd[1]: Starting ModemManager.service -
Modem Manager...
Dec 04 03:29:33 32core kernel: nvme nvme0: using unchecked data buffer
Dec 04 03:29:33 32core sensors[1674]: iwlwifi_1-virtual-0
Dec 04 03:29:33 32core sensors[1674]: Adapter: Virtual device
Dec 04 03:29:33 32core sensors[1674]: temp1:            N/A
Dec 04 03:29:33 32core sensors[1674]: k10temp-pci-00c3
Dec 04 03:29:33 32core sensors[1674]: Adapter: PCI adapter
Dec 04 03:29:33 32core sensors[1674]: Tctl:         +58.4=C2=B0C
Dec 04 03:29:33 32core sensors[1674]: Tccd1:        +46.0=C2=B0C
Dec 04 03:29:33 32core sensors[1674]: Tccd3:        +44.2=C2=B0C
Dec 04 03:29:33 32core sensors[1674]: Tccd5:        +59.0=C2=B0C
Dec 04 03:29:33 32core sensors[1674]: Tccd7:        +48.2=C2=B0C
Dec 04 03:29:33 32core sensors[1674]: nvme-pci-4b00
Dec 04 03:29:33 32core sensors[1674]: Adapter: PCI adapter
Dec 04 03:29:33 32core sensors[1674]: Composite:    +45.9=C2=B0C  (low  =3D
-0.1=C2=B0C, high =3D +74.8=C2=B0C)
Dec 04 03:29:33 32core sensors[1674]:                        (crit =3D +79.=
8=C2=B0C)
Dec 04 03:29:33 32core sensors[1674]: nvme-pci-4300
Dec 04 03:29:33 32core sensors[1674]: Adapter: PCI adapter
Dec 04 03:29:33 32core sensors[1674]: Composite:    +28.9=C2=B0C  (low  =3D
-20.1=C2=B0C, high =3D +74.8=C2=B0C)
Dec 04 03:29:33 32core sensors[1674]:                        (crit =3D +79.=
8=C2=B0C)
Dec 04 03:29:33 32core sensors[1674]: radeon-pci-0100
Dec 04 03:29:33 32core sensors[1674]: Adapter: PCI adapter
Dec 04 03:29:33 32core sensors[1674]: temp1:        +34.0=C2=B0C  (crit =3D
+120.0=C2=B0C, hyst =3D +90.0=C2=B0C)
Dec 04 03:29:33 32core sensors[1674]: pwm1:             36%
Dec 04 03:29:33 32core sensors[1674]: freq1:        300 MHz
Dec 04 03:29:33 32core sensors[1674]: enp69s0-pci-4500
Dec 04 03:29:33 32core sensors[1674]: Adapter: PCI adapter
Dec 04 03:29:33 32core sensors[1674]: PHY Temperature:  +51.3=C2=B0C
Dec 04 03:29:33 32core sensors[1674]: MAC Temperature:  +51.9=C2=B0C
Dec 04 03:29:33 32core sensors[1674]: nvme-pci-4c00
Dec 04 03:29:33 32core sensors[1674]: Adapter: PCI adapter
Dec 04 03:29:33 32core sensors[1674]: Composite:    +54.9=C2=B0C  (low  =3D
-20.1=C2=B0C, high =3D +84.8=C2=B0C)
Dec 04 03:29:33 32core sensors[1674]:                        (crit =3D +81.=
8=C2=B0C)
Dec 04 03:29:33 32core sensors[1674]: Sensor 1:     +54.9=C2=B0C  (low  =3D
-20.1=C2=B0C, high =3D +84.8=C2=B0C)
Dec 04 03:29:33 32core systemd[1]: Finished lm-sensors.service -
Initialize hardware monitoring sensors.
Dec 04 03:29:33 32core udisksd[1558]: Error probing device: Error
sending ATA command IDENTIFY DEVICE to '/dev/sda': Unexpected sense
data returned:
                                      0000: 00 00 00 00  00 00 00 00
00 00 00 00  00 00 00 00    ................
                                      0010: 00 00 00 00  00 00 00 00
00 00 00 00  00 00 00 00    ................
                                       (g-io-error-quark, 0)
Dec 04 03:29:33 32core ModemManager[1735]: <msg> ModemManager (version
1.24.0) starting in system bus...
Dec 04 03:29:33 32core systemd[1]: Finished pvebanner.service -
Proxmox VE Login Banner.
Dec 04 03:29:33 32core kernel: NET: Registered PF_QIPCRTR protocol family
Dec 04 03:29:33 32core systemd[1]: Started ModemManager.service - Modem Man=
ager.
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/sda [SAT], not
capable of SMART Health Status check
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/sda [SAT], no ATA
CHECK POWER STATUS support, ignoring -n Directive
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/sda [SAT], is SMART
capable. Adding to "monitor" list.
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/sda [SAT], state
read from /var/lib/smartmontools/smartd.WDC_WD10JMVW_11S5XS0-WD_WXC1EC2KL90=
5.ata.state
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme0, opened
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme0, PNY CS2130
4TB SSD, S/N:PNY21122103150100005, FW:CS213530, 4.00 TB
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme0, is SMART
capable. Adding to "monitor" list.
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme0, state read
from /var/lib/smartmontools/smartd.PNY_CS2130_4TB_SSD-PNY21122103150100005.=
nvme.state
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme1, opened
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme1, Asgard
AN2TNVMe M.2/80, S/N:100000000074, FW:FWSS0104
Dec 04 03:29:33 32core systemd[1]: Started udisks2.service - Disk Manager.
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme1, is SMART
capable. Adding to "monitor" list.
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme1, state read
from /var/lib/smartmontools/smartd.Asgard_AN2TNVMe_M_2_80-100000000074.nvme=
.state
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme2, opened
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme2, THNSN51T02DU7
TOSHIBA, S/N:76IS1009TTQV, FW:57HA4103
Dec 04 03:29:33 32core udisksd[1558]: Acquired the name
org.freedesktop.UDisks2 on the system message bus
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme2, is SMART
capable. Adding to "monitor" list.
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme2, state read
from /var/lib/smartmontools/smartd.THNSN51T02DU7_TOSHIBA-76IS1009TTQV.nvme.=
state
Dec 04 03:29:33 32core smartd[1551]: Monitoring 1 ATA/SATA, 0 SCSI/SAS
and 3 NVMe devices
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/sda [SAT], SMART
Prefailure Attribute: 3 Spin_Up_Time changed from 188 to 187
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme0, NVMe error
count increased from 853 to 856 (0 new, 1 ignored, 2 unknown)
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/sda [SAT], state
written to /var/lib/smartmontools/smartd.WDC_WD10JMVW_11S5XS0-WD_WXC1EC2KL9=
05.ata.state
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme0, state written
to /var/lib/smartmontools/smartd.PNY_CS2130_4TB_SSD-PNY21122103150100005.nv=
me.state
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme1, state written
to /var/lib/smartmontools/smartd.Asgard_AN2TNVMe_M_2_80-100000000074.nvme.s=
tate
Dec 04 03:29:33 32core smartd[1551]: Device: /dev/nvme2, state written
to /var/lib/smartmontools/smartd.THNSN51T02DU7_TOSHIBA-76IS1009TTQV.nvme.st=
ate
Dec 04 03:29:33 32core systemd[1]: Started smartmontools.service -
Self Monitoring and Reporting Technology (SMART) Daemon.
Dec 04 03:29:33 32core networking[1757]: error: vmbr0: bridge port
enp68s0 does not exist
Dec 04 03:29:33 32core /usr/sbin/ifup[1757]: error: vmbr0: bridge port
enp68s0 does not exist
Dec 04 03:29:33 32core networking[1757]: error: vmbr0: bridge port
enp70s0 does not exist
Dec 04 03:29:33 32core /usr/sbin/ifup[1757]: error: vmbr0: bridge port
enp70s0 does not exist
Dec 04 03:29:33 32core networking[1757]: error: vmbr0: bridge port
enp72s0 does not exist
Dec 04 03:29:33 32core /usr/sbin/ifup[1757]: error: vmbr0: bridge port
enp72s0 does not exist
Dec 04 03:29:33 32core kernel: vmbr0: port 1(enp69s0) entered blocking stat=
e
Dec 04 03:29:33 32core kernel: vmbr0: port 1(enp69s0) entered disabled stat=
e
Dec 04 03:29:33 32core kernel: atlantic 0000:45:00.0 enp69s0: entered
allmulticast mode
Dec 04 03:29:33 32core kernel: atlantic 0000:45:00.0 enp69s0: entered
promiscuous mode
Dec 04 03:29:33 32core kernel: vmbr0: port 2(enp71s0) entered blocking stat=
e
Dec 04 03:29:33 32core kernel: vmbr0: port 2(enp71s0) entered disabled stat=
e
Dec 04 03:29:33 32core kernel: r8169 0000:47:00.0 enp71s0: entered
allmulticast mode
Dec 04 03:29:33 32core kernel: r8169 0000:47:00.0 enp71s0: entered
promiscuous mode
Dec 04 03:29:33 32core networking[1757]: warning: vmbr0: apply bridge
ports settings: bridge configuration failed (missing ports)
Dec 04 03:29:33 32core /usr/sbin/ifup[1757]: warning: vmbr0: apply
bridge ports settings: bridge configuration failed (missing ports)
Dec 04 03:29:34 32core kernel: Realtek Internal NBASE-T PHY
r8169-0-4700:00: attached PHY driver
(mii_bus:phy_addr=3Dr8169-0-4700:00, irq=3DMAC)
Dec 04 03:29:34 32core kernel: r8169 0000:47:00.0 enp71s0: Link is Down
Dec 04 03:29:34 32core kernel: vmbr0: port 2(enp71s0) entered blocking stat=
e
Dec 04 03:29:34 32core kernel: vmbr0: port 2(enp71s0) entered forwarding st=
ate
Dec 04 03:29:34 32core networking[1757]: error: >>> Full logs
available in: /var/log/ifupdown2/network_config_ifupdown2_282_Dec-04-2025_0=
3:29:33.465229
<<<
Dec 04 03:29:34 32core /usr/sbin/ifup[1757]: >>> Full logs available
in: /var/log/ifupdown2/network_config_ifupdown2_282_Dec-04-2025_03:29:33.46=
5229
<<<
Dec 04 03:29:34 32core systemd[1]: Finished networking.service -
Network initialization.
Dec 04 03:29:34 32core systemd[1]: Reached target network.target - Network.
Dec 04 03:29:34 32core systemd[1]: Reached target
network-online.target - Network is Online.
Dec 04 03:29:34 32core systemd[1]: Starting iscsid.service - iSCSI
initiator daemon (iscsid)...
Dec 04 03:29:34 32core systemd[1]: Started lxc-monitord.service - LXC
Container Monitoring Daemon.
Dec 04 03:29:34 32core systemd[1]: Starting lxc-net.service - LXC
network bridge setup...
Dec 04 03:29:34 32core systemd[1]: Starting postfix.service - Postfix
Mail Transport Agent (main/default instance)...
Dec 04 03:29:34 32core systemd[1]: Starting pve-cluster.service - The
Proxmox VE cluster filesystem...
Dec 04 03:29:34 32core kernel: vmbr0: port 2(enp71s0) entered disabled stat=
e
Dec 04 03:29:34 32core systemd[1]: Starting rbdmap.service - Map RBD device=
s...
Dec 04 03:29:34 32core systemd[1]: Starting rpc-statd-notify.service -
Notify NFS peers of a restart...
Dec 04 03:29:34 32core systemd[1]: rsync.service - fast remote file
copy program daemon was skipped because of an unmet condition check
(ConditionPathExists=3D/etc/rsyncd.conf).
Dec 04 03:29:34 32core systemd[1]: Starting ssh.service - OpenBSD
Secure Shell server...
Dec 04 03:29:34 32core sm-notify[1838]: Version 2.8.3 starting
Dec 04 03:29:34 32core systemd[1]: Finished rbdmap.service - Map RBD device=
s.
Dec 04 03:29:34 32core systemd[1]: Started rpc-statd-notify.service -
Notify NFS peers of a restart.
Dec 04 03:29:34 32core pmxcfs[1832]: [main] notice: resolved node name
'32core' to '192.168.199.12' for default node IP address
Dec 04 03:29:34 32core pmxcfs[1832]: [main] notice: resolved node name
'32core' to '192.168.199.12' for default node IP address
Dec 04 03:29:34 32core postfix[1831]: postfix: Postfix is using
backwards-compatible default settings
Dec 04 03:29:34 32core postfix[1831]: postfix: See
https://www.postfix.org/COMPATIBILITY_README.html for details
Dec 04 03:29:34 32core postfix[1831]: postfix: To disable backwards
compatibility use "postconf compatibility_level=3D3.6" and "postfix
reload"
Dec 04 03:29:34 32core postfix[1831]: Postfix is using
backwards-compatible default settings
Dec 04 03:29:34 32core postfix[1831]: See
https://www.postfix.org/COMPATIBILITY_README.html for details
Dec 04 03:29:34 32core postfix[1831]: To disable backwards
compatibility use "postconf compatibility_level=3D3.6" and "postfix
reload"
Dec 04 03:29:34 32core iscsid[1840]: iSCSI logger with pid=3D1846 started!
Dec 04 03:29:34 32core systemd[1]: Started iscsid.service - iSCSI
initiator daemon (iscsid).
Dec 04 03:29:34 32core systemd[1]: open-iscsi.service - Login to
default iSCSI targets was skipped because no trigger condition checks
were met.
Dec 04 03:29:34 32core systemd[1]: Reached target remote-fs-pre.target
- Preparation for Remote File Systems.
Dec 04 03:29:34 32core systemd[1]: Reached target remote-fs.target -
Remote File Systems.
Dec 04 03:29:34 32core systemd[1]: Reached target pve-storage.target -
PVE Storage Target.
Dec 04 03:29:34 32core systemd[1]: Starting blk-availability.service -
Availability of block devices...
Dec 04 03:29:34 32core systemd[1]: systemd-pcrphase.service - TPM PCR
Barrier (User) was skipped because of an unmet condition check
(ConditionSecurity=3Dmeasured-uki).
Dec 04 03:29:34 32core systemd[1]: Starting
systemd-user-sessions.service - Permit User Sessions...
Dec 04 03:29:34 32core systemd[1]: Finished lxc-net.service - LXC
network bridge setup.
Dec 04 03:29:34 32core systemd[1]: Finished blk-availability.service -
Availability of block devices.
Dec 04 03:29:34 32core kernel: Loading iSCSI transport class v2.0-870.
Dec 04 03:29:34 32core systemd[1]: Starting lxc.service - LXC
Container Initialization and Autoboot Code...
Dec 04 03:29:34 32core systemd[1]: Finished
systemd-user-sessions.service - Permit User Sessions.
Dec 04 03:29:34 32core systemd[1]: Started getty@tty1.service - Getty on tt=
y1.
Dec 04 03:29:34 32core systemd[1]: Reached target getty.target - Login Prom=
pts.
Dec 04 03:29:34 32core sshd[1855]: Server listening on 0.0.0.0 port 22.
Dec 04 03:29:34 32core sshd[1855]: Server listening on :: port 22.
Dec 04 03:29:34 32core systemd[1]: Started ssh.service - OpenBSD
Secure Shell server.
Dec 04 03:29:34 32core systemd[1]: Finished lxc.service - LXC
Container Initialization and Autoboot Code.
Dec 04 03:29:34 32core postfix[1986]: postfix: Postfix is using
backwards-compatible default settings
Dec 04 03:29:34 32core postfix[1986]: postfix: See
https://www.postfix.org/COMPATIBILITY_README.html for details
Dec 04 03:29:34 32core postfix[1986]: postfix: To disable backwards
compatibility use "postconf compatibility_level=3D3.6" and "postfix
reload"
Dec 04 03:29:34 32core postfix[1986]: Postfix is using
backwards-compatible default settings
Dec 04 03:29:34 32core postfix[1986]: See
https://www.postfix.org/COMPATIBILITY_README.html for details
Dec 04 03:29:34 32core postfix[1986]: To disable backwards
compatibility use "postconf compatibility_level=3D3.6" and "postfix
reload"
Dec 04 03:29:34 32core postfix/master[1994]: daemon started -- version
3.10.5, configuration /etc/postfix
Dec 04 03:29:34 32core systemd[1]: Started postfix.service - Postfix
Mail Transport Agent (main/default instance).
Dec 04 03:29:35 32core iscsid[1846]: iSCSI daemon with pid=3D1847 started!
Dec 04 03:29:35 32core systemd[1]: Started pve-cluster.service - The
Proxmox VE cluster filesystem.
Dec 04 03:29:35 32core systemd[1]: corosync.service - Corosync Cluster
Engine was skipped because of an unmet condition check
(ConditionPathExists=3D/etc/corosync/corosync.conf).
Dec 04 03:29:35 32core systemd[1]: Started cron.service - Regular
background program processing daemon.
Dec 04 03:29:35 32core systemd[1]: Starting
pve-firewall-commit.service - Commit Proxmox VE Firewall changes...
Dec 04 03:29:35 32core systemd[1]: Starting pve-firewall.service -
Proxmox VE firewall...
Dec 04 03:29:35 32core systemd[1]: Starting pve-sdn-commit.service -
Commit Proxmox VE SDN changes...
Dec 04 03:29:35 32core systemd[1]: Starting pvedaemon.service - PVE
API Daemon...
Dec 04 03:29:35 32core systemd[1]: Starting pvestatd.service - PVE
Status Daemon...
Dec 04 03:29:35 32core cron[2002]: (CRON) INFO (pidfile fd =3D 3)
Dec 04 03:29:35 32core cron[2002]: (CRON) INFO (Running @reboot jobs)
Dec 04 03:29:35 32core systemd[1]: Finished
pve-firewall-commit.service - Commit Proxmox VE Firewall changes.
Dec 04 03:29:35 32core pve-sdn-commit[2005]: No changes to SDN
configuration detected, skipping reload
Dec 04 03:29:35 32core systemd[1]: Finished pve-sdn-commit.service -
Commit Proxmox VE SDN changes.
Dec 04 03:29:36 32core pve-firewall[2018]: starting server
Dec 04 03:29:36 32core pvestatd[2020]: starting server
Dec 04 03:29:36 32core systemd[1]: Started pve-firewall.service -
Proxmox VE firewall.
Dec 04 03:29:36 32core systemd[1]: Started pvestatd.service - PVE Status Da=
emon.
Dec 04 03:29:36 32core pvedaemon[2046]: starting server
Dec 04 03:29:36 32core pvedaemon[2046]: starting 3 worker(s)
Dec 04 03:29:36 32core pvedaemon[2046]: worker 2047 started
Dec 04 03:29:36 32core pvedaemon[2046]: worker 2048 started
Dec 04 03:29:36 32core pvedaemon[2046]: worker 2049 started
Dec 04 03:29:36 32core systemd[1]: Started pvedaemon.service - PVE API Daem=
on.
Dec 04 03:29:36 32core systemd[1]: Starting pve-ha-crm.service - PVE
Cluster HA Resource Manager Daemon...
Dec 04 03:29:36 32core systemd[1]: Starting pveproxy.service - PVE API
Proxy Server...
Dec 04 03:29:37 32core pve-ha-crm[2056]: starting server
Dec 04 03:29:37 32core pve-ha-crm[2056]: status change startup =3D>
wait_for_quorum
Dec 04 03:29:37 32core systemd[1]: Started pve-ha-crm.service - PVE
Cluster HA Resource Manager Daemon.
Dec 04 03:29:37 32core ModemManager[1735]: <msg> [base-manager]
couldn't check support for device
'/sys/devices/pci0000:40/0000:40:01.1/0000:41:00.0/0000:42:03.0/0000:45:00.=
0':
not supported by any plugin
Dec 04 03:29:37 32core ModemManager[1735]: <msg> [base-manager]
couldn't check support for device
'/sys/devices/pci0000:40/0000:40:01.1/0000:41:00.0/0000:42:04.0/0000:46:00.=
0':
not supported by any plugin
Dec 04 03:29:37 32core ModemManager[1735]: <msg> [base-manager]
couldn't check support for device
'/sys/devices/pci0000:40/0000:40:01.1/0000:41:00.0/0000:42:05.0/0000:47:00.=
0':
not supported by any plugin
Dec 04 03:29:37 32core pveproxy[2058]: starting server
Dec 04 03:29:37 32core pveproxy[2058]: starting 3 worker(s)
Dec 04 03:29:37 32core pveproxy[2058]: worker 2059 started
Dec 04 03:29:37 32core pveproxy[2058]: worker 2060 started
Dec 04 03:29:37 32core pveproxy[2058]: worker 2061 started
Dec 04 03:29:37 32core systemd[1]: Started pveproxy.service - PVE API
Proxy Server.
Dec 04 03:29:37 32core systemd[1]: Starting pve-ha-lrm.service - PVE
Local HA Resource Manager Daemon...
Dec 04 03:29:37 32core systemd[1]: Starting spiceproxy.service - PVE
SPICE Proxy Server...
Dec 04 03:29:37 32core spiceproxy[2067]: starting server
Dec 04 03:29:37 32core spiceproxy[2067]: starting 1 worker(s)
Dec 04 03:29:37 32core spiceproxy[2067]: worker 2068 started
Dec 04 03:29:37 32core systemd[1]: Started spiceproxy.service - PVE
SPICE Proxy Server.
Dec 04 03:29:38 32core pve-ha-lrm[2070]: starting server
Dec 04 03:29:38 32core pve-ha-lrm[2070]: status change startup =3D>
wait_for_agent_lock
Dec 04 03:29:38 32core systemd[1]: Started pve-ha-lrm.service - PVE
Local HA Resource Manager Daemon.
Dec 04 03:29:38 32core systemd[1]: Starting pve-guests.service - PVE guests=
...
Dec 04 03:29:38 32core systemd[1]: systemd-rfkill.service: Deactivated
successfully.
Dec 04 03:29:38 32core pve-guests[2075]: <root@pam> starting task
UPID:32core:0000081C:000005D6:69308FA2:startall::root@pam:
Dec 04 03:29:38 32core pve-guests[2075]: <root@pam> end task
UPID:32core:0000081C:000005D6:69308FA2:startall::root@pam: OK
Dec 04 03:29:38 32core systemd[1]: Finished pve-guests.service - PVE guests=
.
Dec 04 03:29:38 32core systemd[1]: Starting pvescheduler.service -
Proxmox VE scheduler...
Dec 04 03:29:39 32core kernel: atlantic 0000:45:00.0 enp69s0:
atlantic: link change old 0 new 10000
Dec 04 03:29:39 32core kernel: vmbr0: port 1(enp69s0) entered blocking stat=
e
Dec 04 03:29:39 32core kernel: vmbr0: port 1(enp69s0) entered forwarding st=
ate
Dec 04 03:29:39 32core pvescheduler[2079]: starting server
Dec 04 03:29:39 32core systemd[1]: Started pvescheduler.service -
Proxmox VE scheduler.
Dec 04 03:29:39 32core systemd[1]: Reached target multi-user.target -
Multi-User System.
Dec 04 03:29:39 32core systemd[1]: Reached target graphical.target -
Graphical Interface.
Dec 04 03:29:39 32core systemd[1]: Startup finished in 40.684s
(firmware) + 6.890s (loader) + 4.456s (kernel) + 11.103s (userspace) =3D
1min 3.135s.
Dec 04 03:30:03 32core netavark[1535]: timeout met: exiting after 30
secs of inactivity
Dec 04 03:30:03 32core systemd[1]: netavark-dhcp-proxy.service:
Deactivated successfully.
Dec 04 03:30:07 32core pvedaemon[2047]: <root@pam> successful auth for
user 'root@pam'
Dec 04 03:30:17 32core chronyd[1703]: Selected source 15.204.87.223
(2.debian.pool.ntp.org)
Dec 04 03:30:17 32core chronyd[1703]: System clock TAI offset set to 37 sec=
onds
Dec 04 03:30:17 32core sshd-session[2221]: Accepted password for root
from 192.168.199.2 port 6648 ssh2
Dec 04 03:30:17 32core sshd-session[2221]: pam_unix(sshd:session):
session opened for user root(uid=3D0) by root(uid=3D0)
Dec 04 03:30:17 32core systemd[1]: Created slice user-0.slice - User
Slice of UID 0.
Dec 04 03:30:17 32core systemd[1]: Starting user-runtime-dir@0.service
- User Runtime Directory /run/user/0...
Dec 04 03:30:17 32core systemd-logind[1555]: New session 1 of user root.
Dec 04 03:30:17 32core systemd[1]: Finished user-runtime-dir@0.service
- User Runtime Directory /run/user/0.
Dec 04 03:30:17 32core systemd[1]: Starting user@0.service - User
Manager for UID 0...
Dec 04 03:30:17 32core (systemd)[2227]:
pam_unix(systemd-user:session): session opened for user root(uid=3D0) by
root(uid=3D0)
Dec 04 03:30:17 32core systemd-logind[1555]: New session 2 of user root.
Dec 04 03:30:17 32core systemd[2227]: Queued start job for default
target default.target.
Dec 04 03:30:17 32core systemd[2227]: Created slice app.slice - User
Application Slice.
Dec 04 03:30:17 32core systemd[2227]: Reached target paths.target - Paths.
Dec 04 03:30:17 32core systemd[2227]: Reached target timers.target - Timers=
.
Dec 04 03:30:17 32core systemd[2227]: Starting dbus.socket - D-Bus
User Message Bus Socket...
Dec 04 03:30:17 32core systemd[2227]: Listening on dirmngr.socket -
GnuPG network certificate management daemon.
Dec 04 03:30:17 32core systemd[2227]: Listening on
gpg-agent-browser.socket - GnuPG cryptographic agent and passphrase
cache (access for web browsers).
Dec 04 03:30:17 32core systemd[2227]: Listening on
gpg-agent-extra.socket - GnuPG cryptographic agent and passphrase
cache (restricted).
Dec 04 03:30:17 32core systemd[2227]: Starting gpg-agent-ssh.socket -
GnuPG cryptographic agent (ssh-agent emulation)...
Dec 04 03:30:17 32core systemd[2227]: Starting gpg-agent.socket -
GnuPG cryptographic agent and passphrase cache...
Dec 04 03:30:17 32core systemd[2227]: Listening on keyboxd.socket -
GnuPG public key management service.
Dec 04 03:30:17 32core systemd[2227]: Starting ssh-agent.socket -
OpenSSH Agent socket...
Dec 04 03:30:17 32core systemd[2227]: Listening on dbus.socket - D-Bus
User Message Bus Socket.
Dec 04 03:30:17 32core systemd[2227]: Listening on ssh-agent.socket -
OpenSSH Agent socket.
Dec 04 03:30:17 32core systemd[2227]: Listening on
gpg-agent-ssh.socket - GnuPG cryptographic agent (ssh-agent
emulation).
Dec 04 03:30:17 32core systemd[2227]: Listening on gpg-agent.socket -
GnuPG cryptographic agent and passphrase cache.
Dec 04 03:30:17 32core systemd[2227]: Reached target sockets.target - Socke=
ts.
Dec 04 03:30:17 32core systemd[2227]: Reached target basic.target -
Basic System.
Dec 04 03:30:17 32core systemd[2227]: Reached target default.target -
Main User Target.
Dec 04 03:30:17 32core systemd[2227]: Startup finished in 272ms.
Dec 04 03:30:17 32core systemd[1]: Started user@0.service - User
Manager for UID 0.
Dec 04 03:30:18 32core systemd[1]: Started session-1.scope - Session 1
of User root.
Dec 04 03:30:19 32core chronyd[1703]: Selected source 12.205.28.193
(2.debian.pool.ntp.org)
Dec 04 03:30:26 32core kernel: NOTICE: Automounting of tracing to
debugfs is deprecated and will be removed in 2030
Dec 04 03:31:57 32core kernel: BUG: kernel NULL pointer dereference,
address: 0000000000000008
Dec 04 03:31:57 32core kernel: #PF: supervisor write access in kernel mode
Dec 04 03:31:57 32core kernel: #PF: error_code(0x0002) - not-present page
Dec 04 03:31:57 32core kernel: PGD 0 P4D 0
Dec 04 03:31:57 32core kernel: Oops: Oops: 0002 [#1] SMP NOPTI
Dec 04 03:31:57 32core kernel: CPU: 50 UID: 0 PID: 2365 Comm: zstd
Tainted: P           O        6.17.2-2-pve #1 PREEMPT(voluntary)
Dec 04 03:31:57 32core kernel: Tainted: [P]=3DPROPRIETARY_MODULE, [O]=3DOOT=
_MODULE
Dec 04 03:31:57 32core kernel: Hardware name: To Be Filled By O.E.M.
To Be Filled By O.E.M./TRX40 Creator, BIOS P1.88C 12/23/2024
Dec 04 03:31:57 32core kernel: RIP: 0010:list_lru_del+0xc0/0x180
Dec 04 03:31:57 32core kernel: Code: 00 00 00 00 00 00 00 80 48 39 c2
74 64 e8 58 62 db ff 49 8b 55 00 49 39 d5 0f 84 9c 00 00 00 49 8b 4d
00 49 8b 55 08 4c 89 e7 <48> 89 51 08 48 89 0a 4d 89 6d 00 4d 89 6d 08
49 83 6f 10 01 e8 f7
Dec 04 03:31:57 32core kernel: RSP: 0018:ffffd3ed589ef600 EFLAGS: 00010086
Dec 04 03:31:57 32core kernel: RAX: 0000000000000000 RBX:
ffffffff997f07e0 RCX: 0000000000000000
Dec 04 03:31:57 32core kernel: RDX: 0000000000000000 RSI:
0000000000000000 RDI: ffff8b43c3fa30e8
Dec 04 03:31:57 32core kernel: RBP: ffffd3ed589ef640 R08:
0000000000000000 R09: 0000000000000000
Dec 04 03:31:57 32core kernel: R10: 0000000000000000 R11:
0000000000000000 R12: ffff8b43c3fa30e8
Dec 04 03:31:57 32core kernel: R13: ffff8b61a34319e8 R14:
ffff8b43dfcfabc0 R15: ffff8b43c3fa30d0
Dec 04 03:31:57 32core kernel: FS:  00007ea767a956c0(0000)
GS:ffff8b6325286000(0000) knlGS:0000000000000000
Dec 04 03:31:57 32core kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Dec 04 03:31:57 32core kernel: CR2: 0000000000000008 CR3:
000000014b096000 CR4: 0000000000350ef0
Dec 04 03:31:57 32core kernel: Call Trace:
Dec 04 03:31:57 32core kernel:  <TASK>
Dec 04 03:31:57 32core kernel:  list_lru_del_obj+0x7f/0xe0
Dec 04 03:31:57 32core kernel:  workingset_update_node+0x61/0xb0
Dec 04 03:31:57 32core kernel:  xas_store+0x25f/0x6d0
Dec 04 03:31:57 32core kernel:  __filemap_add_folio+0x234/0x510
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? __pfx_workingset_update_node+0x10/0x10
Dec 04 03:31:57 32core kernel:  filemap_add_folio+0x99/0xf0
Dec 04 03:31:57 32core kernel:  page_cache_ra_order+0x205/0x3b0
Dec 04 03:31:57 32core kernel:  page_cache_async_ra+0x19f/0x1f0
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? filemap_get_read_batch+0x15b/0x2e0
Dec 04 03:31:57 32core kernel:  filemap_readahead.isra.0+0x73/0xb0
Dec 04 03:31:57 32core kernel:  filemap_get_pages+0x40f/0x740
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? sched_clock_noinstr+0x9/0x10
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  filemap_read+0x114/0x4a0
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  generic_file_read_iter+0xbb/0x110
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? apparmor_file_permission+0x1f/0x30
Dec 04 03:31:57 32core kernel:  ext4_file_read_iter+0x60/0x200
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  vfs_read+0x274/0x390
Dec 04 03:31:57 32core kernel:  ksys_read+0x6f/0xf0
Dec 04 03:31:57 32core kernel:  __x64_sys_read+0x19/0x30
Dec 04 03:31:57 32core kernel:  x64_sys_call+0x1e95/0x2330
Dec 04 03:31:57 32core kernel:  do_syscall_64+0x80/0xa30
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? ksys_read+0xd9/0xf0
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? __x64_sys_read+0x19/0x30
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? x64_sys_call+0x1e95/0x2330
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? do_syscall_64+0xb8/0xa30
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? ext4_file_read_iter+0x60/0x200
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? vfs_read+0x274/0x390
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? ksys_read+0xd9/0xf0
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? __x64_sys_read+0x19/0x30
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? x64_sys_call+0x1e95/0x2330
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? do_syscall_64+0xb8/0xa30
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? do_syscall_64+0xb8/0xa30
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? do_syscall_64+0xb8/0xa30
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  ? do_syscall_64+0xb8/0xa30
Dec 04 03:31:57 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:31:57 32core kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Dec 04 03:31:57 32core kernel: RIP: 0033:0x7ea7684929ee
Dec 04 03:31:57 32core kernel: Code: 08 0f 85 f5 4b ff ff 49 89 fb 48
89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24
10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00
00 00 00 48 83 ec 08
Dec 04 03:31:57 32core kernel: RSP: 002b:00007ea767a94d98 EFLAGS:
00000246 ORIG_RAX: 0000000000000000
Dec 04 03:31:57 32core kernel: RAX: ffffffffffffffda RBX:
00007ea767a956c0 RCX: 00007ea7684929ee
Dec 04 03:31:57 32core kernel: RDX: 0000000000020000 RSI:
00007ea76716c010 RDI: 0000000000000003
Dec 04 03:31:57 32core kernel: RBP: 00007ea7685ddfd0 R08:
0000000000000000 R09: 0000000000000000
Dec 04 03:31:57 32core kernel: R10: 0000000000000000 R11:
0000000000000246 R12: 00007ea76716c010
Dec 04 03:31:57 32core kernel: R13: 0000000000020000 R14:
00007ea7685dde80 R15: 0000000000020000
Dec 04 03:31:57 32core kernel:  </TASK>
Dec 04 03:31:57 32core kernel: Modules linked in: ebtable_filter
ebtables ip_set ip6table_raw iptable_raw ip6table_filter ip6_tables
iptable_filter scsi_transport_iscsi nf_tables qrtr bonding tls at24
spd5118 softdog sunrpc binfmt_misc nfnetlink_log iwlmvm mac80211
libarc4 btusb btrtl btintel btbcm btmtk iwlwifi bluetooth input_leds
cfg80211 amd_atl intel_rapl_msr intel_rapl_common sch_fq_codel amdgpu
amdxcp snd_hda_codec_atihdmi edac_mce_amd drm_panel_backlight_quirks
snd_hda_codec_hdmi snd_hda_intel gpu_sched radeon snd_hda_codec
drm_buddy snd_usb_audio kvm_amd snd_hda_core drm_ttm_helper
snd_usbmidi_lib ttm drm_exec snd_intel_dspcfg snd_ump
drm_suballoc_helper snd_intel_sdw_acpi snd_rawmidi snd_hwdep kvm
snd_seq_device drm_display_helper snd_pcm cec polyval_clmulni
snd_timer rc_core ghash_clmulni_intel snd aesni_intel joydev
i2c_algo_bit rapl wmi_bmof pcspkr ccp mxm_wmi ee1004 video k10temp
soundcore mac_hid mc zfs(PO) spl(O) vhost_net vhost vhost_iotlb tap
nct6683 lm83 vfio_pci vfio_pci_core irqbypass vfio_iommu_type1 vfio
iommufd
Dec 04 03:31:57 32core kernel:  msr efi_pstore nfnetlink dmi_sysfs
ip_tables x_tables autofs4 btrfs blake2b_generic xor raid6_pq
hid_multitouch uas usb_storage usbkbd usbmouse hid_generic usbhid hid
dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio nvme atlantic
r8169 nvme_core xhci_pci ahci nvme_keyring libahci macsec realtek
nvme_auth xhci_hcd i2c_piix4 i2c_smbus wmi
Dec 04 03:31:57 32core kernel: CR2: 0000000000000008
Dec 04 03:31:57 32core kernel: ---[ end trace 0000000000000000 ]---
Dec 04 03:31:57 32core kernel: RIP: 0010:list_lru_del+0xc0/0x180
Dec 04 03:31:57 32core kernel: Code: 00 00 00 00 00 00 00 80 48 39 c2
74 64 e8 58 62 db ff 49 8b 55 00 49 39 d5 0f 84 9c 00 00 00 49 8b 4d
00 49 8b 55 08 4c 89 e7 <48> 89 51 08 48 89 0a 4d 89 6d 00 4d 89 6d 08
49 83 6f 10 01 e8 f7
Dec 04 03:31:57 32core kernel: RSP: 0018:ffffd3ed589ef600 EFLAGS: 00010086
Dec 04 03:31:57 32core kernel: RAX: 0000000000000000 RBX:
ffffffff997f07e0 RCX: 0000000000000000
Dec 04 03:31:57 32core kernel: RDX: 0000000000000000 RSI:
0000000000000000 RDI: ffff8b43c3fa30e8
Dec 04 03:31:57 32core kernel: RBP: ffffd3ed589ef640 R08:
0000000000000000 R09: 0000000000000000
Dec 04 03:31:57 32core kernel: R10: 0000000000000000 R11:
0000000000000000 R12: ffff8b43c3fa30e8
Dec 04 03:31:57 32core kernel: R13: ffff8b61a34319e8 R14:
ffff8b43dfcfabc0 R15: ffff8b43c3fa30d0
Dec 04 03:31:57 32core kernel: FS:  00007ea767a956c0(0000)
GS:ffff8b6325286000(0000) knlGS:0000000000000000
Dec 04 03:31:57 32core kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Dec 04 03:31:57 32core kernel: CR2: 0000000000000008 CR3:
000000014b096000 CR4: 0000000000350ef0
Dec 04 03:31:57 32core kernel: note: zstd[2365] exited with irqs disabled
Dec 04 03:31:57 32core kernel: note: zstd[2365] exited with preempt_count 2
Dec 04 03:32:33 32core kernel: Oops: general protection fault,
probably for non-canonical address 0x9a3ae555524f6ec2: 0000 [#2] SMP
NOPTI
Dec 04 03:32:33 32core kernel: CPU: 50 UID: 0 PID: 1547 Comm: ksmtuned
Tainted: P      D    O        6.17.2-2-pve #1 PREEMPT(voluntary)
Dec 04 03:32:33 32core kernel: Tainted: [P]=3DPROPRIETARY_MODULE,
[D]=3DDIE, [O]=3DOOT_MODULE
Dec 04 03:32:33 32core kernel: Hardware name: To Be Filled By O.E.M.
To Be Filled By O.E.M./TRX40 Creator, BIOS P1.88C 12/23/2024
Dec 04 03:32:33 32core kernel: RIP: 0010:kmem_cache_alloc_noprof+0x203/0x3e=
0
Dec 04 03:32:33 32core kernel: Code: 84 ce fe ff ff 48 85 db 0f 84 c5
fe ff ff 48 8b 03 48 c1 e8 36 41 39 c2 0f 85 b5 fe ff ff 41 8b 44 24
28 49 8b 34 24 48 01 f8 <48> 8b 18 48 89 c1 49 33 9c 24 b8 00 00 00 48
89 f8 48 0f c9 48 31
Dec 04 03:32:33 32core kernel: RSP: 0018:ffffd3ed42de3990 EFLAGS: 00010282
Dec 04 03:32:33 32core kernel: RAX: 9a3ae555524f6ec2 RBX:
fffffc073b8d0c00 RCX: 0000000000000000
Dec 04 03:32:33 32core kernel: RDX: 0000000033e52032 RSI:
ffffffff996b42d0 RDI: 9a3ae555524f6c82
Dec 04 03:32:33 32core kernel: RBP: ffffd3ed42de39d8 R08:
0000000000000028 R09: 0000000000000000
Dec 04 03:32:33 32core kernel: R10: 00000000ffffffff R11:
00000000003fffff R12: ffff8b43c0055e00
Dec 04 03:32:33 32core kernel: R13: 0000000000002820 R14:
0000000000000240 R15: ffffffff97cac677
Dec 04 03:32:33 32core kernel: FS:  000074d3ea109740(0000)
GS:ffff8b6325286000(0000) knlGS:0000000000000000
Dec 04 03:32:33 32core kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Dec 04 03:32:33 32core kernel: CR2: 000074d3ea2f57b0 CR3:
00000001112c5000 CR4: 0000000000350ef0
Dec 04 03:32:33 32core kernel: Call Trace:
Dec 04 03:32:33 32core kernel:  <TASK>
Dec 04 03:32:33 32core kernel:  radix_tree_node_alloc.constprop.0+0xb7/0x10=
0
Dec 04 03:32:33 32core kernel:  idr_get_free+0x26d/0x330
Dec 04 03:32:33 32core kernel:  idr_alloc_u32+0x7d/0xf0
Dec 04 03:32:33 32core kernel:  idr_alloc_cyclic+0x57/0xc0
Dec 04 03:32:33 32core kernel:  alloc_pid+0x1b8/0x410
Dec 04 03:32:33 32core kernel:  copy_process+0x1298/0x1ca0
Dec 04 03:32:33 32core kernel:  kernel_clone+0xb6/0x4b0
Dec 04 03:32:33 32core kernel:  __do_sys_clone+0x68/0xa0
Dec 04 03:32:33 32core kernel:  __x64_sys_clone+0x25/0x40
Dec 04 03:32:33 32core kernel:  x64_sys_call+0x1b4d/0x2330
Dec 04 03:32:33 32core kernel:  do_syscall_64+0x80/0xa30
Dec 04 03:32:33 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:32:33 32core kernel:  ? __handle_mm_fault+0xadb/0xfd0
Dec 04 03:32:33 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:32:33 32core kernel:  ? count_memcg_events+0xd7/0x1a0
Dec 04 03:32:33 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:32:33 32core kernel:  ? __set_task_blocked+0x29/0x80
Dec 04 03:32:33 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:32:33 32core kernel:  ? _copy_to_user+0x31/0x60
Dec 04 03:32:33 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:32:33 32core kernel:  ? __x64_sys_rt_sigprocmask+0xee/0x160
Dec 04 03:32:33 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:32:33 32core kernel:  ? x64_sys_call+0x178d/0x2330
Dec 04 03:32:33 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:32:33 32core kernel:  ? do_syscall_64+0xb8/0xa30
Dec 04 03:32:33 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:32:33 32core kernel:  ? x64_sys_call+0x178d/0x2330
Dec 04 03:32:33 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:32:33 32core kernel:  ? do_syscall_64+0xb8/0xa30
Dec 04 03:32:33 32core kernel:  ? irqentry_exit+0x43/0x50
Dec 04 03:32:33 32core kernel:  ? srso_return_thunk+0x5/0x5f
Dec 04 03:32:33 32core kernel:  ? exc_page_fault+0x90/0x1b0
Dec 04 03:32:33 32core kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Dec 04 03:32:33 32core kernel: RIP: 0033:0x74d3ea1e9202
Dec 04 03:32:33 32core kernel: Code: 89 e7 e8 71 3b f6 ff 45 31 c0 31
d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00
00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5e 89 c5 85 c0 75 31 64
48 8b 04 25 10 00 00
Dec 04 03:32:33 32core kernel: RSP: 002b:00007ffd24e48590 EFLAGS:
00000246 ORIG_RAX: 0000000000000038
Dec 04 03:32:33 32core kernel: RAX: ffffffffffffffda RBX:
00007ffd24e48590 RCX: 000074d3ea1e9202
Dec 04 03:32:33 32core kernel: RDX: 0000000000000000 RSI:
0000000000000000 RDI: 0000000001200011
Dec 04 03:32:33 32core kernel: RBP: 0000000000000000 R08:
0000000000000000 R09: 0000000000000000
Dec 04 03:32:33 32core kernel: R10: 000074d3ea109a10 R11:
0000000000000246 R12: 00007ffd24e48700
Dec 04 03:32:33 32core kernel: R13: 0000000000000000 R14:
0000000000000000 R15: 00000000ffffffff
Dec 04 03:32:33 32core kernel:  </TASK>
Dec 04 03:32:33 32core kernel: Modules linked in: ebtable_filter
ebtables ip_set ip6table_raw iptable_raw ip6table_filter ip6_tables
iptable_filter scsi_transport_iscsi nf_tables qrtr bonding tls at24
spd5118 softdog sunrpc binfmt_misc nfnetlink_log iwlmvm mac80211
libarc4 btusb btrtl btintel btbcm btmtk iwlwifi bluetooth input_leds
cfg80211 amd_atl intel_rapl_msr intel_rapl_common sch_fq_codel amdgpu
amdxcp snd_hda_codec_atihdmi edac_mce_amd drm_panel_backlight_quirks
snd_hda_codec_hdmi snd_hda_intel gpu_sched radeon snd_hda_codec
drm_buddy snd_usb_audio kvm_amd snd_hda_core drm_ttm_helper
snd_usbmidi_lib ttm drm_exec snd_intel_dspcfg snd_ump
drm_suballoc_helper snd_intel_sdw_acpi snd_rawmidi snd_hwdep kvm
snd_seq_device drm_display_helper snd_pcm cec polyval_clmulni
snd_timer rc_core ghash_clmulni_intel snd aesni_intel joydev
i2c_algo_bit rapl wmi_bmof pcspkr ccp mxm_wmi ee1004 video k10temp
soundcore mac_hid mc zfs(PO) spl(O) vhost_net vhost vhost_iotlb tap
nct6683 lm83 vfio_pci vfio_pci_core irqbypass vfio_iommu_type1 vfio
iommufd
Dec 04 03:32:33 32core kernel:  msr efi_pstore nfnetlink dmi_sysfs
ip_tables x_tables autofs4 btrfs blake2b_generic xor raid6_pq
hid_multitouch uas usb_storage usbkbd usbmouse hid_generic usbhid hid
dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio nvme atlantic
r8169 nvme_core xhci_pci ahci nvme_keyring libahci macsec realtek
nvme_auth xhci_hcd i2c_piix4 i2c_smbus wmi
Dec 04 03:32:33 32core kernel: ---[ end trace 0000000000000000 ]---
Dec 04 03:32:33 32core kernel: RIP: 0010:list_lru_del+0xc0/0x180
Dec 04 03:32:33 32core kernel: Code: 00 00 00 00 00 00 00 80 48 39 c2
74 64 e8 58 62 db ff 49 8b 55 00 49 39 d5 0f 84 9c 00 00 00 49 8b 4d
00 49 8b 55 08 4c 89 e7 <48> 89 51 08 48 89 0a 4d 89 6d 00 4d 89 6d 08
49 83 6f 10 01 e8 f7
Dec 04 03:32:33 32core kernel: RSP: 0018:ffffd3ed589ef600 EFLAGS: 00010086
Dec 04 03:32:33 32core kernel: RAX: 0000000000000000 RBX:
ffffffff997f07e0 RCX: 0000000000000000
Dec 04 03:32:33 32core kernel: RDX: 0000000000000000 RSI:
0000000000000000 RDI: ffff8b43c3fa30e8
Dec 04 03:32:33 32core kernel: RBP: ffffd3ed589ef640 R08:
0000000000000000 R09: 0000000000000000
Dec 04 03:32:33 32core kernel: R10: 0000000000000000 R11:
0000000000000000 R12: ffff8b43c3fa30e8
Dec 04 03:32:33 32core kernel: R13: ffff8b61a34319e8 R14:
ffff8b43dfcfabc0 R15: ffff8b43c3fa30d0
Dec 04 03:32:33 32core kernel: FS:  000074d3ea109740(0000)
GS:ffff8b6325286000(0000) knlGS:0000000000000000
Dec 04 03:32:33 32core kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Dec 04 03:32:33 32core kernel: CR2: 000074d3ea2f57b0 CR3:
00000001112c5000 CR4: 0000000000350ef0
Dec 04 03:32:33 32core kernel: note: ksmtuned[1547] exited with preempt_cou=
nt 2
Dec 04 03:32:33 32core systemd[1]: ksmtuned.service: Main process
exited, code=3Dkilled, status=3D11/SEGV
Dec 04 03:32:33 32core systemd[1]: ksmtuned.service: Failed with
result 'signal'.
Dec 04 03:33:00 32core kernel: watchdog: BUG: soft lockup - CPU#17
stuck for 23s! [pve-firewall:2018]


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

