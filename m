Return-Path: <stable+bounces-69223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D0A953760
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 17:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E3A1F2172F
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316981AD9E8;
	Thu, 15 Aug 2024 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="d+I0R0qS"
X-Original-To: stable@vger.kernel.org
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0AD1AD3F5
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736083; cv=none; b=ltNObO+iP2JhM61nfvl/JS+uSsc4wUQRpPwGDiDO/e5itXJgKT7wwOGaZX5EO2CHpI4+ieKGVW96u5HyRG5lLjIB/mgCDLKWHHp6mWh+ZOeosA1JH22EhjaYpFSI8kDilvvprAa6CetVHfBNt2S9irQf8xSHHEsfxc4Fj6bp/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736083; c=relaxed/simple;
	bh=cTeMkB9kqvNTza1MYGrN45vuivHR9kH2hnNYqxewbVg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eoIovcMfjBVeLdIXtvssFfjIJN0Ak1lkPRX9MLYpTxTJecIfX818rAn5eVgyfZZ2Ir2fFdOhuk/ZkXvFHp3gvn6l5FVzGg6FfGw7uHX9wqwOzZmNKgTVmO/5dRL1EAtBYLjRTB8gtnS9j99FdAC/54Kprp7RPXyWyad6yimMEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=d+I0R0qS; arc=none smtp.client-ip=116.203.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1723734050;
	bh=hV9IdHd75FKpbkuCojpQZmNtxtph9xEt9omLOpUCazA=;
	h=From:To:CC:Subject:Date:From;
	b=d+I0R0qSSuap5zgAfco4vCGNcEfrIS20J18HAJ0hYFmdaoxXoDy6jVggg9X3KUCi5
	 ZrHX/UpKWxC+7Z2i9k1kqtT9xICtQ1cUxCSTY20Vhq31blKDcCobXzRmuBQhIQx132
	 kmjQc7vDIszM9JHErUHJK70yQxNHHvrNnx9DIRrqw4YbdyF4+En6PxrSypcazbBww/
	 TWn15pESC9CjjD5IBlMRpoR4mebLpfYsFgxxKTy1dxi9cSyDtbVE5/5eLU0pBsPhbS
	 pZLT1Fkx5P2QcPfo5uH9ID3Ojqw+WCS21ekl74hLcWuaIDlBqUjdpJWaC91e6Mm0Pq
	 VH3Q4VzT0c0Gg==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marek Vasut <marex@denx.de>
Subject: [PATCH 6.6.y] stm32mp15: WARNING after poweroff command
Thread-Topic: [PATCH 6.6.y] stm32mp15: WARNING after poweroff command
Thread-Index: AdrvI7KK67DYDGbzTGmcg+LExmUVOg==
Date: Thu, 15 Aug 2024 15:00:47 +0000
Message-ID: <1c1c2afd73b14a9bbdc918cfd5813558@dh-electronics.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi stable team,

I would suggest to apply the patch
470a66268856 ("i2c: stm32f7: Add atomic_xfer method to driver")
from 6.7-rc1 to the stable Kernel 6.6.y.

Here is why:
After the commit
6e9df38f359a ("mfd: stpmic1: Add PMIC poweroff via sys-off handler")
from 6.5-rc1 the following WARNING appears after calling the poweroff
command:

[  791.813369] systemd-shutdown[1]: Syncing filesystems and block devices.
[  792.865580] systemd-shutdown[1]: Sending SIGTERM to remaining processes.=
..
[  792.921103] systemd-journald[101]: Received SIGTERM from PID 1 (systemd-=
shutdow).
[  792.936515] systemd-shutdown[1]: Sending SIGKILL to remaining processes.=
..
[  792.968715] systemd-shutdown[1]: Unmounting file systems.
[  792.979332] (sd-remount)[315]: Remounting '/' read-only with options ''.
[  793.219266] EXT4-fs (mmcblk2p4): re-mounted f7da42a1-2eed-4d39-a31e-e0ff=
adb97b28 ro. Quota mode: disabled.
[  793.238398] systemd-shutdown[1]: All filesystems unmounted.
[  793.242736] systemd-shutdown[1]: Deactivating swaps.
[  793.248004] systemd-shutdown[1]: All swaps deactivated.
[  793.252937] systemd-shutdown[1]: Detaching loop devices.
[  793.272548] systemd-shutdown[1]: All loop devices detached.
[  793.276918] systemd-shutdown[1]: Stopping MD devices.
[  793.282790] systemd-shutdown[1]: All MD devices stopped.
[  793.287128] systemd-shutdown[1]: Detaching DM devices.
[  793.292995] systemd-shutdown[1]: All DM devices detached.
[  793.297731] systemd-shutdown[1]: All filesystems, swaps, loop devices, M=
D devices and DM devices detached.
[  793.320636] systemd-shutdown[1]: Syncing filesystems and block devices.
[  793.326078] systemd-shutdown[1]: Powering off.
[  793.348421] reboot: Power down
[  793.350129] ------------[ cut here ]------------
[  793.354691] WARNING: CPU: 0 PID: 1 at drivers/i2c/i2c-core.h:42 i2c_tran=
sfer+0x5d/0x7c
[  793.362617] No atomic I2C transfer handler for 'i2c-2'
[  793.367780] Modules linked in:
[  793.370838] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 6.6.41-lardi=
sbox2-00053-g41e0b7f0166f #12
[  793.380047] Hardware name: STM32 (Device Tree Support)
[  793.385122]  unwind_backtrace from show_stack+0xb/0xc
[  793.390215]  show_stack from dump_stack_lvl+0x2b/0x34
[  793.395202]  dump_stack_lvl from __warn+0x5d/0xc4
[  793.399993]  __warn from warn_slowpath_fmt+0x55/0xa8
[  793.404887]  warn_slowpath_fmt from i2c_transfer+0x5d/0x7c
[  793.410387]  i2c_transfer from regmap_i2c_read+0x41/0x6c
[  793.415681]  regmap_i2c_read from _regmap_raw_read+0x87/0xe8
[  793.421378]  _regmap_raw_read from _regmap_bus_read+0x21/0x38
[  793.427079]  _regmap_bus_read from _regmap_read+0x55/0x9c
[  793.432477]  _regmap_read from _regmap_update_bits+0x71/0xa4
[  793.438175]  _regmap_update_bits from regmap_update_bits_base+0x2f/0x42
[  793.444784]  regmap_update_bits_base from stpmic1_power_off+0x19/0x20
[  793.451188]  stpmic1_power_off from sys_off_notify+0x1b/0x38
[  793.456880]  sys_off_notify from notifier_call_chain+0x57/0x78
[  793.462668]  notifier_call_chain from atomic_notifier_call_chain+0x11/0x=
16
[  793.469562]  atomic_notifier_call_chain from do_kernel_power_off+0x21/0x=
38
[  793.476461]  do_kernel_power_off from __do_sys_reboot+0xdf/0x150
[  793.482456]  __do_sys_reboot from ret_fast_syscall+0x1/0x5c
[  793.488042] Exception stack(0xf0815fa8 to 0xf0815ff0)
[  793.493017] 5fa0:                   00000000 00000000 fee1dead 28121969 =
4321fedc 00000000
[  793.501218] 5fc0: 00000000 00000000 00000000 00000058 0001884c 00000003 =
00000000 00018140
[  793.509414] 5fe0: 00000058 bee18c34 b6c20cdd b6b995a6
[  793.514478] ---[ end trace 000000000000000

This can be eliminated by backporting the above mentioned patch. I tested
it with a DHCOM stm32mp157c on a PDK2 board.

Thanks and regards
Christoph

