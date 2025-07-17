Return-Path: <stable+bounces-163302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A56B0964A
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 23:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B773B1797DD
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 21:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1A622AE7A;
	Thu, 17 Jul 2025 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="Q+JsNM/X"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761F32264A7
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786501; cv=pass; b=iNgNemjqDLU6wjtlLdi3GlSIn8BtNs+vZv4bSU+teOkSC/jaQbroqEfHfLvxaxhWwMaCpq1HbplhQgjKcMfIkWmRe0GIKihCJPPKPiI1hS52DiuccycXKgKxJ8VBOOPAZ//ynWuCTgA7FeeS4eNQktvB2KCbXqX43irQTSkFyAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786501; c=relaxed/simple;
	bh=ioxlL3aYKJYTHOpNSYQ4z3dj4I/7Y65M8Y/Abd/0jcc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GCql6iWwHsltOFxoCDJhJX48fMM3UapjwkERHYnjf6xIy+QdPmNbMXjrMkeP9tHtw5+R2yfUT/zHTEjvUMqkdhRB/xRkNYQjAxAlRSUrTq6Rs7UYkPhZw4+IMyFIHiaKFVk6xdH9wsVN5FHwpMzNHcmZ1gK6DSzCdUtnxmzNd8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=Q+JsNM/X; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752786494; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GysS3je4NrcqNEaOrm1Qe5lNwM7LadXrM1RVvfkXBqr3G+I5qq1traqOOf6rS0XpPLqPtwCBzb17E8QyBIAM7Q29DauZMmClcHuMbBD8PxQRAMyAo/F3XdK5G+t5GrnP5YxJ6ySvuIIsG3ozBiHVIXCIuRXEujW/ebJGx0gqfEM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752786494; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7U/raLA/XYlb6CIjAw/9mV3RhVw0ukTrqX7y1rI4IQM=; 
	b=KfXWauaA0bdNca6Vy8UYGmseFNpLL6owQdlcYpau5lmoj5cfgSkSjK12lujcm7qjE/xnvSUQpBTb1nyT8T3e2tk63/GtGVzEiwyVTFop59B7xQ5JTtftmMmjXCl0/zlzsUE3GJTEjv3Rx1CRUlM+MQwLPN7ruwimUWW3zAQu/RA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752786494;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7U/raLA/XYlb6CIjAw/9mV3RhVw0ukTrqX7y1rI4IQM=;
	b=Q+JsNM/X3qRNOkSCko/cg469QY3+JG0r5SnELrcjWPW7SuH5JmsOEyaY4BpPskfY
	s9hX7AWSU0gVQVOKmaQIFeNN3f3ljQ4OdhgS9AjfG+PcZhnUVxdsBa4ZBiIoRNG3V3J
	nJpR4TyXhW6o0BrGlkVXPci/BB+WInaxfS6Q9/ao=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 17527864915689.489843909569913; Thu, 17 Jul 2025 14:08:11 -0700 (PDT)
Date: Thu, 17 Jul 2025 18:08:11 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "kernelci" <kernelci@lists.linux.dev>
Cc: "kernelci-results" <kernelci-results@groups.io>,
	"stable" <stable@vger.kernel.org>
Message-ID: <1981a37589f.3ce79d75533263.2198784111493991651@collabora.com>
In-Reply-To: <175278560529.3533138.9991813707938719759@poutine>
References: <175278560529.3533138.9991813707938719759@poutine>
Subject: Re: [TEST REGRESSION] stable-rc/linux-6.12.y:
 kselftest.breakpoints.breakpoints_step_after_suspend_test on
 stm32mp157a-dhcor-avenger96
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail



---- On Thu, 17 Jul 2025 17:53:26 -0300 KernelCI bot <bot@kernelci.org> wro=
te ---

 >=20
 >=20
 >=20
 > Hello,=20
 > =20
 > New test failure found on stable-rc/linux-6.12.y:=20
 > =20
 > kselftest.breakpoints.breakpoints_step_after_suspend_test running on stm=
32mp157a-dhcor-avenger96=20
 > =20
 > giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-sta=
ble-rc.git=20
 > branch: linux-6.12.y=20
 > commit HEAD: d50d16f002928cde05a54e0049ddc203323ae7ac=20
 > =20
 > =20
 > test id: maestro:687945d32ce2c1874ed4d342=20
 > status: FAIL=20
 > start time:=20
 > log: https://files.kernelci.org/kselftest-breakpoints-6876a2d634612746bb=
cec7ff/log.txt.gz=20
 > =20
 > # Test details:=20
 > - test path: kselftest.breakpoints.breakpoints_step_after_suspend_test=
=20
 > - platform: stm32mp157a-dhcor-avenger96=20
 > - compatibles: arrow,stm32mp157a-avenger96 | dh,stm32mp157a-dhcor-som | =
st,stm32mp157=20
 > - config: multi_v7_defconfig=20
 > - architecture: arm=20
 > - compiler: gcc-12=20
 > =20
 > Dashboard: https://d.kernelci.org/t/maestro:687945d32ce2c1874ed4d342=20

FYI, the history for this test on this tree and hw platform is this:

History: =E2=9C=85 =E2=86=92 =E2=9C=85 =E2=86=92 =E2=9C=85 =E2=86=92 =E2=9C=
=85 =E2=86=92 =E2=9C=85 =E2=86=92 =E2=9C=85 =E2=86=92 =E2=9C=85 =E2=86=92 =
=E2=9C=85 =E2=86=92 =E2=9C=85 =E2=86=92 =E2=9D=8C

It is the first failure in while, so more likely to be a regression.


 > =20
 > =20
 > Log excerpt:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=20
 > of an unmet condition check (ConditionPathExists=3D/sys/kernel/mm/hugepa=
ges).=20
 > [   28.116033] systemd[1]: dev-mqueue.mount - POSIX Message Queue File S=
ystem was skipped because of an unmet condition check (ConditionPathExists=
=3D/proc/sys/fs/mqueue).=20
 > [   28.180697] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debu=
g File System...=20
 > Mounting [0;1;39msys-kernel-debug.=E2=80=A6[0m - Kernel Debug File Syste=
m...=20
 > [   28.217714] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Tr=
ace File System...=20
 > Mounting [0;1;39msys-kernel-tracin=E2=80=A6[0m - Kernel Trace File Syste=
m...=20
 > [   28.291406] systemd[1]: Starting kmod-static-nodes.service - Create L=
ist of Static Device Nodes...=20
 > Starting [0;1;39mkmod-static-nodes=E2=80=A6ate List of Static Device Nod=
es...=20
 > [   28.331680] systemd[1]: Starting modprobe@configfs.service - Load Ker=
nel Module configfs...=20
 > Starting [0;1;39mmodprobe@configfs=E2=80=A6m - Load Kernel Module config=
fs...=20
 > [   28.371165] systemd[1]: Starting modprobe@dm_mod.service - Load Kerne=
l Module dm_mod...=20
 > Starting [0;1;39mmodprobe@dm_mod.s=E2=80=A6[0m - Load Kernel Module dm_m=
od...=20
 > [   28.408054] systemd[1]: Starting modprobe@drm.service - Load Kernel M=
odule drm...=20
 > Starting [0;1;39mmodprobe@drm.service[0m - Load Kernel Module drm...=20
 > [   28.449915] systemd[1]: Starting modprobe@efi_pstore.service - Load K=
ernel Module efi_pstore...=20
 > Starting [0;1;39mmodprobe@efi_psto=E2=80=A6- Load Kernel Module efi_psto=
re...=20
 > [   28.487986] systemd[1]: Starting modprobe@fuse.service - Load Kernel =
Module fuse...=20
 > Starting [0;1;39mmodprobe@fuse.ser=E2=80=A6e[0m - Load Kernel Module fus=
e...=20
 > [   28.532255] systemd[1]: Starting modprobe@loop.service - Load Kernel =
Module loop...=20
 > Starting [0;1;39mmodprobe@loop.ser=E2=80=A6e[0m - Load Kernel Module loo=
p...=20
 > [   28.563256] systemd[1]: systemd-journald.service: unit configures an =
IP firewall, but the local system does not support BPF/cgroup firewalling.=
=20
 > [   28.574983] systemd[1]: (This warning is only shown for the first uni=
t using IP firewalling.)=20
 > [   28.588124] systemd[1]: Starting systemd-journald.service - Journal S=
ervice...=20
 > Starting [0;1;39msystemd-journald.service[0m - Journal Service...=20
 > [   28.682143] systemd[1]: Starting systemd-modules-load.service - Load =
Kernel Modules...=20
 > Starting [0;1;39msystemd-modules-l=E2=80=A6rvice[0m - Load Kernel Module=
s...=20
 > [   28.726528] systemd[1]: Starting systemd-network-generator.service - =
Generate network units from Kernel command line...=20
 > Starting [0;1;39msystemd-network-g=E2=80=A6 units from Kernel command li=
ne...=20
 > [   28.831292] systemd[1]: Starting systemd-remount-fs.service - Remount=
 Root and Kernel File Systems...=20
 > Starting [0;1;39msystemd-remount-f=E2=80=A6nt Root and Kernel File Syste=
ms...=20
 > [   28.868196] systemd[1]: Starting systemd-udev-trigger.service - Coldp=
lug All udev Devices...=20
 > Starting [0;1;39msystemd-udev-trig=E2=80=A6[0m - Coldplug All udev Devic=
es...=20
 > [   28.925905] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug=
 File System.=20
 > [[0;32m  OK  [0m] Mounted [0;1;39msys-kernel-debug.m=E2=80=A6nt[0m - Ker=
nel Debug File System.=20
 > [   28.971980] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Tra=
ce File System.=20
 > [[0;32m  OK  [0m] Mounted [0;1;39msys-kernel-tracing=E2=80=A6nt[0m - Ker=
nel Trace File System.=20
 > [   29.004249] systemd[1]: Finished kmod-static-nodes.service - Create L=
ist of Static Device Nodes.=20
 > [[0;32m  OK  [0m] Finished [0;1;39mkmod-static-nodes=E2=80=A6reate List =
of Static Device Nodes.=20
 > [   29.106198] systemd[1]: modprobe@configfs.service: Deactivated succes=
sfully.=20
 > [   29.121680] systemd[1]: Finished modprobe@configfs.service - Load Ker=
nel Module configfs.=20
 > [[0;32m  OK  [0m] Finished [0;1;39mmodprobe@configfs=E2=80=A6[0m - Load =
Kernel Module configfs.=20
 > [   29.142952] systemd[1]: modprobe@dm_mod.service: Deactivated successf=
ully.=20
 > [   29.160513] systemd[1]: Finished modprobe@dm_mod.service - Load Kerne=
l Module dm_mod.=20
 > [[0;32m  OK  [0m] Finished [0;1;39mmodprobe@dm_mod.s=E2=80=A6e[0m - Load=
 Kernel Module dm_mod.=20
 > [   29.203027] systemd[1]: modprobe@drm.service: Deactivated successfull=
y.=20
 > [   29.209669] systemd[1]: Finished modprobe@drm.service - Load Kernel M=
odule drm.=20
 > [[0;32m  OK  [0m] Finished [0;1;39mmodprobe@drm.service[0m - Load Kernel=
 Module drm.=20
 > [   29.251945] systemd[1]: Started systemd-journald.service - Journal Se=
rvice.=20
 > [[0;32m  OK  [0m] Started [0;1;39msystemd-journald.service[0m - Journal =
Service.=20
 > [[0;32m  OK  [0m] Finished [0;1;39mmodprobe@efi_psto=E2=80=A6m - Load Ke=
rnel Module efi_pstore.=20
 > [[0;32m  OK  [0m] Finished [0;1;39mmodprobe@fuse.service[0m - Load Kerne=
l Module fuse.=20
 > [[0;32m  OK  [0m] Finished [0;1;39mmodprobe@loop.service[0m - Load Kerne=
l Module loop.=20
 > [[0;32m  OK  [0m] Finished [0;1;39msystemd-modules-l=E2=80=A6service[0m =
- Load Kernel Modules.=20
 > [[0;32m  OK  [0m] Finished [0;1;39msystemd-network-g=E2=80=A6rk units fr=
om Kernel command line.=20
 > [[0;32m  OK  [0m] Finished [0;1;39msystemd-remount-f=E2=80=A6ount Root a=
nd Kernel File Systems.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39mnetwork-pre=E2=80=A6get[0m - Pr=
eparation for Network.=20
 > Mounting [0;1;39msys-kernel-config=E2=80=A6ernel Configuration File Syst=
em...=20
 > Starting [0;1;39msystemd-journal-f=E2=80=A6h Journal to Persistent Stora=
ge...=20
 > Starting [0;1;39msystemd-random-se=E2=80=A6ice[0m - Load/Save Random See=
d...=20
 > Starting [0;1;39msystemd-sysctl.se=E2=80=A6ce[0m - Apply Kernel Variable=
s...=20
 > Starting [0;1;39msystemd-sysusers.=E2=80=A6rvice[0m - Create System User=
s...=20
 > [[0;32m  OK  [0m] Mounted [0;1;39msys-kernel-config.=E2=80=A6 Kernel Con=
figuration File System.=20
 > [   29.895899] systemd-journald[191]: Received client request to flush r=
untime journal.=20
 > [[0;32m  OK  [0m] Finished [0;1;39msystemd-random-se=E2=80=A6rvice[0m - =
Load/Save Random Seed.=20
 > [[0;32m  OK  [0m] Finished [0;1;39msystemd-sysctl.service[0m - Apply Ker=
nel Variables.=20
 > [[0;32m  OK  [0m] Finished [0;1;39msystemd-sysusers.service[0m - Create =
System Users.=20
 > Starting [0;1;39msystemd-tmpfiles-=E2=80=A6ate Static Device Nodes in /d=
ev...=20
 > [[0;32m  OK  [0m] Finished [0;1;39msystemd-journal-f=E2=80=A6ush Journal=
 to Persistent Storage.=20
 > [[0;32m  OK  [0m] Finished [0;1;39msystemd-tmpfiles-=E2=80=A6reate Stati=
c Device Nodes in /dev.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39mlocal-fs-pr=E2=80=A6reparation =
for Local File Systems.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39mlocal-fs.target[0m - Local File=
 Systems.=20
 > Starting [0;1;39msystemd-tmpfiles-=E2=80=A6te System Files and Directori=
es...=20
 > Starting [0;1;39msystemd-udevd.ser=E2=80=A6ger for Device Events and Fil=
es...=20
 > [[0;32m  OK  [0m] Started [0;1;39msystemd-udevd.serv=E2=80=A6nager for D=
evice Events and Files.=20
 > [[0;32m  OK  [0m] Finished [0;1;39msystemd-tmpfiles-=E2=80=A6eate System=
 Files and Directories.=20
 > Starting [0;1;39msystemd-networkd.=E2=80=A6ice[0m - Network Configuratio=
n...=20
 > Starting [0;1;39msystemd-timesyncd=E2=80=A6 - Network Time Synchronizati=
on...=20
 > Starting [0;1;39msystemd-update-ut=E2=80=A6rd System Boot/Shutdown in UT=
MP...=20
 > [[0;32m  OK  [0m] Finished [0;1;39msystemd-update-ut=E2=80=A6cord System=
 Boot/Shutdown in UTMP.=20
 > [[0;32m  OK  [0m] Finished [0;1;39msystemd-udev-trig=E2=80=A6e[0m - Cold=
plug All udev Devices.=20
 > [[0;32m  OK  [0m] Started [0;1;39msystemd-timesyncd.=E2=80=A60m - Networ=
k Time Synchronization.=20
 > [[0;32m  OK  [0m] Started [0;1;39msystemd-networkd.service[0m - Network =
Configuration.=20
 > [[0;32m  OK  [0m] Found device [0;1;39mdev-ttySTM0.device[0m - /dev/ttyS=
TM0.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39mbluetooth.target[0m - Bluetooth=
 Support.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39mnetwork.target[0m - Network.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39mtime-set.target[0m - System Tim=
e Set.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39musb-gadget.=E2=80=A6m - Hardwar=
e activated USB gadget.=20
 > [[0;32m  OK  [0m] Listening on [0;1;39msystemd-rfkil=E2=80=A6l Switch St=
atus /dev/rfkill Watch.=20
 > Starting [0;1;39mmodprobe@dm_mod.s=E2=80=A6[0m - Load Kernel Module dm_m=
od...=20
 > Starting [0;1;39mmodprobe@efi_psto=E2=80=A6- Load Kernel Module efi_psto=
re...=20
 > Starting [0;1;39mmodprobe@fuse.ser=E2=80=A6e[0m - Load Kernel Module fus=
e...=20
 > Starting [0;1;39mmodprobe@loop.ser=E2=80=A6e[0m - Load Kernel Module loo=
p...=20
 > [[0;32m  OK  [0m] Finished [0;1;39mmodprobe@dm_mod.s=E2=80=A6e[0m - Load=
 Kernel Module dm_mod.=20
 > [[0;32m  OK  [0m] Finished [0;1;39mmodprobe@efi_psto=E2=80=A6m - Load Ke=
rnel Module efi_pstore.=20
 > [[0;32m  OK  [0m] Finished [0;1;39mmodprobe@fuse.service[0m - Load Kerne=
l Module fuse.=20
 > [[0;32m  OK  [0m] Finished [0;1;39mmodprobe@loop.service[0m - Load Kerne=
l Module loop.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39msysinit.target[0m - System Init=
ialization.=20
 > [[0;32m  OK  [0m] Started [0;1;39mapt-daily.timer[0m - Daily apt downloa=
d activities.=20
 > [[0;32m  OK  [0m] Started [0;1;39mapt-daily-upgrade.=E2=80=A6 apt upgrad=
e and clean activities.=20
 > [[0;32m  OK  [0m] Started [0;1;39mdpkg-db-backup.tim=E2=80=A6 Daily dpkg=
 database backup timer.=20
 > [[0;32m  OK  [0m] Started [0;1;39me2scrub_all.timer=E2=80=A6etadata Chec=
k for All Filesystems.=20
 > [[0;32m  OK  [0m] Started [0;1;39mfstrim.timer[0m - Discard unused block=
s once a week.=20
 > [[0;32m  OK  [0m] Started [0;1;39msystemd-tmpfiles-c=E2=80=A6 Cleanup of=
 Temporary Directories.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39mtimers.target[0m - Timer Units.=
=20
 > [[0;32m  OK  [0m] Listening on [0;1;39mdbus.socket[=E2=80=A6- D-Bus Syst=
em Message Bus Socket.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39msockets.target[0m - Socket Unit=
s.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39mbasic.target[0m - Basic System.=
=20
 > Starting [0;1;39malsa-restore.serv=E2=80=A6- Save/Restore Sound Card Sta=
te...=20
 > Starting [0;1;39mdbus.service[0m - D-Bus System Message Bus...=20
 > Starting [0;1;39me2scrub_reap.serv=E2=80=A6e ext4 Metadata Check Snapsho=
ts...=20
 > Starting [0;1;39msystemd-logind.se=E2=80=A6ice[0m - User Login Managemen=
t...=20
 > Starting [0;1;39msystemd-rfkill.se=E2=80=A6Load/Save RF Kill Switch Stat=
us...=20
 > Starting [0;1;39msystemd-user-sess=E2=80=A6vice[0m - Permit User Session=
s...=20
 > [[0;32m  OK  [0m] Finished [0;1;39malsa-restore.serv=E2=80=A6m - Save/Re=
store Sound Card State.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39msound.target[0m - Sound Card.=
=20
 > [[0;32m  OK  [0m] Started [0;1;39msystemd-rfkill.ser=E2=80=A6- Load/Save=
 RF Kill Switch Status.=20
 > [[0;32m  OK  [0m] Finished [0;1;39msystemd-user-sess=E2=80=A6ervice[0m -=
 Permit User Sessions.=20
 > [[0;32m  OK  [0m] Started [0;1;39mgetty@tty1.service[0m - Getty on tty1.=
=20
 > [[0;32m  OK  [0m] Started [0;1;39mserial-getty@ttyST=E2=80=A6ice[0m - Se=
rial Getty on ttySTM0.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39mgetty.target[0m - Login Prompts=
.=20
 > [[0;32m  OK  [0m] Started [0;1;39mdbus.service[0m - D-Bus System Message=
 Bus.=20
 > Starting [0;1;39msystemd-hostnamed.service[0m - Hostname Service...=20
 > [[0;32m  OK  [0m] Started [0;1;39msystemd-logind.service[0m - User Login=
 Management.=20
 > [[0;32m  OK  [0m] Finished [0;1;39me2scrub_reap.serv=E2=80=A6ine ext4 Me=
tadata Check Snapshots.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39mmulti-user.target[0m - Multi-Us=
er System.=20
 > [[0;32m  OK  [0m] Reached target [0;1;39mgraphical.target[0m - Graphical=
 Interface.=20
 > Starting [0;1;39msystemd-update-ut=E2=80=A6 Record Runlevel Change in UT=
MP...=20
 > [[0;32m  OK  [0m] Finished [0;1;39msystemd-update-ut=E2=80=A6 - Record R=
unlevel Change in UTMP.=20
 > [[0;32m  OK  [0m] Started [0;1;39msystemd-hostnamed.service[0m - Hostnam=
e Service.=20
 > Debian GNU/Linux 12 debian-bookworm-armhf ttySTM0=20
 > debian-bookworm-armhf login: root (automatic login)=20
 > Linux debian-bookworm-armhf 6.12.39-rc2 #1 SMP Tue Jul 15 18:39:20 UTC 2=
025 armv7l=20
 > The programs included with the Debian GNU/Linux system are free software=
;=20
 > the exact distribution terms for each program are described in the=20
 > individual files in /usr/share/doc/*/copyright.=20
 > Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent=20
 > permitted by applicable law.=20
 > / #=20
 > / # export NFS_ROOTFS=3D'/var/lib/lava/dispatcher/tmp/1574985/extract-nf=
srootfs-w6q8rnvr'=20
 > export NFS_ROOTFS=3D'/var/lib/lava/dispatcher/tmp/1574985/extract-nfsroo=
tfs-w6q8rnvr'=20
 > / # export NFS_SERVER_IP=3D'172.16.0.3'=20
 > export NFS_SERVER_IP=3D'172.16.0.3'=20
 > / # #=20
 > #=20
 > / # export SHELL=3D/bin/bash=20
 > export SHELL=3D/bin/bash=20
 > / # . /lava-1574985/environment=20
 > . /lava-1574985/environment=20
 > / # /lava-1574985/bin/lava-test-runner /lava-1574985/0=20
 > /lava-1574985/bin/lava-test-runner /lava-1574985/0=20
 > + export TESTRUN_ID=3D0_timesync-off=20
 > + TESTRUN_ID=3D0_timesync-off=20
 > + cd /lava-1574985/0/tests/0_timesync-off=20
 > ++ cat uuid=20
 > + UUID=3D1574985_1.6.2.4.1=20
 > + set +x=20
 > <LAVA_SIGNAL_STARTRUN 0_timesync-off 1574985_1.6.2.4.1>=20
 > + systemctl stop systemd-timesyncd=20
 > + set +x=20
 > <LAVA_SIGNAL_ENDRUN 0_timesync-off 1574985_1.6.2.4.1>=20
 > + export TESTRUN_ID=3D1_kselftest-breakpoints=20
 > + TESTRUN_ID=3D1_kselftest-breakpoints=20
 > + cd /lava-1574985/0/tests/1_kselftest-breakpoints=20
 > ++ cat uuid=20
 > + UUID=3D1574985_1.6.2.4.5=20
 > + set +x=20
 > <LAVA_SIGNAL_STARTRUN 1_kselftest-breakpoints 1574985_1.6.2.4.5>=20
 > + cd ./automated/linux/kselftest/=20
 > + ./kselftest.sh -c breakpoints -T '' -t kselftest_armhf.tar.gz -s True =
-u https://files.kernelci.org/kbuild-gcc-12-arm-6876975b34612746bbce6ee9/ks=
elftest.tar.gz -L '' -S /dev/null -b '' -g '' -e '' -p /opt/kselftests/main=
line/ -n 1 -i 1 -E ''=20
 > INFO: install_deps skipped=20
 > --2025-07-17 18:49:22-- https://files.kernelci.org/kbuild-gcc-12-arm-687=
6975b34612746bbce6ee9/kselftest.tar.gz=20
 > Resolving files.kernelci.org (files.kernelci.org)... 20.171.243.82=20
 > Connecting to files.kernelci.org (files.kernelci.org)|20.171.243.82|:443=
... connected.=20
 > HTTP request sent, awaiting response... 200 OK=20
 > Length: 9351030 (8.9M) [application/gzip]=20
 > Saving to: 'kselftest_armhf.tar.gz'=20
 > kselftest_armhf.tar   0%[                    ]       0  --.-KB/s        =
       ?kselftest_armhf.tar   1%[                    ] 103.76K   357KB/s   =
            ?kselftest_armhf.tar   4%[                    ] 439.76K   756KB=
/s               ?kselftest_armhf.tar  12%[=3D>                  ]   1.13M =
 1.45MB/s               ?kselftest_armhf.tar  23%[=3D=3D=3D>               =
 ]   2.13M  2.17MB/s               ?kselftest_armhf.tar  35%[=3D=3D=3D=3D=
=3D=3D>             ]   3.13M  2.64MB/s               ?kselftest_armhf.tar =
 46%[=3D=3D=3D=3D=3D=3D=3D=3D>           ]   4.13M  2.98MB/s               =
?kselftest_armhf.tar  57%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>         ]   5.13M=
  3.24MB/s               ?kselftest_armhf.tar  68%[=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D>       ]   6.13M  3.43MB/s               ?kselftest_armhf.tar =
 79%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>     ]   7.13M  3.59MB/s   =
            ?kselftest_armhf.tar  90%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D>  ]   8.06M  3.57MB/s               ?kselftest_armhf.tar 10=
0%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>]   8.92M  3.6=
6MB/s    in 2.4s=20
 > 2025-07-17 18:49:25 (3.66 MB/s) - 'kselftest_armhf.tar.gz' saved [935103=
0/9351030]=20
 > skiplist:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > breakpoints:step_after_suspend_test=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Tests to run =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > breakpoints:step_after_suspend_test=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DEnd Tests to run =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=20
 > shardfile-breakpoints pass=20
 > [   67.220163] kselftest: Running tests in breakpoints=20
 > TAP version 13=20
 > 1..1=20
 > # timeout set to 45=20
 > # selftests: breakpoints: step_after_suspend_test=20
 > [   67.432985] PM: suspend entry (deep)=20
 > [   67.449347] Filesystems sync: 0.014 seconds=20
 > [   67.458329] Freezing user space processes=20
 > [   67.462606] Freezing user space processes completed (elapsed 0.001 se=
conds)=20
 > [   67.468205] OOM killer disabled.=20
 > [   67.471493] Freezing remaining freezable tasks=20
 > [   67.477234] Freezing remaining freezable tasks completed (elapsed 0.0=
01 seconds)=20
 > [   67.483366] printk: Suspending console(s) (use no_console_suspend to =
debug)=20
 > [   67.611609] stm32-dwmac 5800a000.ethernet end0: Link is Down=20
 > [   67.624958] Disabling non-boot CPUs ...=20
 > [   67.626403] CPU1 killed.=20
 > [   67.628604] Enabling non-boot CPUs ...=20
 > [   67.630318] CPU1 is up=20
 > [   67.638677] stm32-dwmac 5800a000.ethernet end0: configuring for phy/r=
gmii link mode=20
 > [   67.640262] dwmac4: Master AXI performs any burst length=20
 > [   67.640314] stm32-dwmac 5800a000.ethernet end0: No Safety Features su=
pport found=20
 > [   67.640345] stm32-dwmac 5800a000.ethernet end0: Invalid PTP clock rat=
e=20
 > [   67.640361] stm32-dwmac 5800a000.ethernet end0: PTP init failed=20
 > [   67.642550] stm32-dwmac 5800a000.ethernet end0: Link is Up - 1Gbps/Fu=
ll - flow control off=20
 > [   67.910193] usb 2-1: reset high-speed USB device number 2 using ehci-=
platform=20
 > [   68.257543] OOM killer enabled.=20
 > [   68.260709] Restarting tasks ... done.=20
 > [   68.267811] random: crng reseeded on system resumption=20
 > [   68.281019] PM: suspend exit=20
 > # TAP version 13=20
 > # Bail out! Failed to enter Suspend state=20
 > # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0=20
 > not ok 1 selftests: breakpoints: step_after_suspend_test # exit=3D1=20
 > WARNING: Optional imports not found, TAP 13 output will be=20
 > ignored. To parse yaml, see requirements in docs:=20
 > https://tappy.readthedocs.io/en/latest/consumers.html#tap-version-13=20
 > breakpoints_step_after_suspend_test fail=20
 > + ../../utils/send-to-lava.sh ./output/result.txt=20
 > <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dshardfile-breakpoints RESULT=3Dpass=
>=20
 > <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dbreakpoints_step_after_suspend_test=
 RESULT=3Dfail>=20
 > + set +x=20
 > <LAVA_SIGNAL_ENDRUN 1_kselftest-breakpoints 1574985_1.6.2.4.5>=20
 > <LAVA_TEST_RUNNER EXIT>=20
 > / #=20
 > =20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=20
 > =20
 > =20
 > #kernelci test maestro:687945d32ce2c1874ed4d342=20
 > =20
 > Reported-by: kernelci.org bot <bot@kernelci.org>=20
 > =20
 > --=20
 > This is an experimental report format. Please send feedback in!=20
 > Talk to us at kernelci@lists.linux.dev=20
 > =20
 > Made with love by the KernelCI team - https://kernelci.org=20
 >=20


