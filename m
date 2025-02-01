Return-Path: <stable+bounces-111912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FF1A24B46
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 18:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA451886F66
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548AA1F2378;
	Sat,  1 Feb 2025 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X2106pkZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD91CAA84;
	Sat,  1 Feb 2025 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738431986; cv=none; b=FRxtzwrrj6FlKwlZ6W5P8KphEz1adXyTc3q5P0bDJ2STjfSrP8m0tzf8Gd5K8HincrVc/gQ8J7mLWsTBo3oGlD8QNBYuR7YwVJEhcyzP6UP7nqFczIgu6uyXUjnQP4TNyf0vwh8L95qUPEmGhr0U293jdh/ZPFUZnhQuiAEmgTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738431986; c=relaxed/simple;
	bh=T6TaLIK1pxifRwHI1VTmhbdoEe5VgQjcoy8x0X0iXU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aRZKETRVtivYrlzcO4wpPUNvgYO4XGwl6h26lUD7RWV0o8aFdhM54YSWw/8ZVtu4INnA2ZFHp08gPqM7gavwwt/20/HeVFL3RXjnUJLt7Rx8KJHJ8h1c1bQ3eFBQd3oJTGIP/nepdUybA0P68KIQdRjBnVArTxGTIGrxT19f3Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X2106pkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CB2C4CEDF;
	Sat,  1 Feb 2025 17:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738431985;
	bh=T6TaLIK1pxifRwHI1VTmhbdoEe5VgQjcoy8x0X0iXU8=;
	h=From:To:Cc:Subject:Date:From;
	b=X2106pkZLe6gD4agPSQJihbPBXyVoS8uo3yunbOCft8TVSpCwTyaR1AyzhXiyBqHp
	 92+6yK06TGb41VMHY5s79uML1sKlvXgeDIYsrOQKSrcGANHxPI7DIGfO2rUmT1buJL
	 CjWrvrT+k6/ZjHxQq0CmoIvxUXpGq0JkHKpBDsZ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.75
Date: Sat,  1 Feb 2025 18:46:08 +0100
Message-ID: <2025020109-serpent-crescent-6219@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.75 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                     |    2 
 block/ioctl.c                                                |    9 
 drivers/ata/libahci.c                                        |   12 
 drivers/ata/libata-core.c                                    |    8 
 drivers/cpufreq/amd-pstate.c                                 |    7 
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c        |    3 
 drivers/gpu/drm/v3d/v3d_irq.c                                |   16 
 drivers/hid/hid-ids.h                                        |    1 
 drivers/hid/hid-multitouch.c                                 |    8 
 drivers/hwmon/drivetemp.c                                    |    2 
 drivers/infiniband/hw/bnxt_re/main.c                         |   10 
 drivers/input/joystick/xpad.c                                |    9 
 drivers/input/keyboard/atkbd.c                               |    2 
 drivers/irqchip/irq-sunxi-nmi.c                              |    3 
 drivers/of/unittest-data/tests-platform.dtsi                 |   13 
 drivers/of/unittest.c                                        |   14 
 drivers/scsi/scsi_transport_iscsi.c                          |    4 
 drivers/scsi/storvsc_drv.c                                   |    8 
 drivers/usb/gadget/function/u_serial.c                       |    8 
 drivers/usb/serial/quatech2.c                                |    2 
 drivers/vfio/platform/vfio_platform_common.c                 |   10 
 fs/ext4/super.c                                              |    3 
 fs/gfs2/file.c                                               |    1 
 fs/libfs.c                                                   |  177 +++++--
 fs/smb/client/smb2inode.c                                    |   92 ++-
 include/linux/fs.h                                           |    2 
 include/linux/seccomp.h                                      |    2 
 mm/filemap.c                                                 |   19 
 mm/shmem.c                                                   |    3 
 net/ipv4/ip_tunnel.c                                         |    2 
 net/ipv6/ip6_fib.c                                           |    8 
 net/ipv6/route.c                                             |   45 +
 net/sched/sch_ets.c                                          |    2 
 sound/soc/codecs/Kconfig                                     |    1 
 sound/soc/samsung/Kconfig                                    |    6 
 sound/usb/quirks.c                                           |    2 
 tools/testing/selftests/net/Makefile                         |    1 
 tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh |  262 +++++++++++
 38 files changed, 645 insertions(+), 134 deletions(-)

Alex Williamson (1):
      vfio/platform: check the bounds of read/write syscalls

Alexey Dobriyan (1):
      block: fix integer overflow in BLKSECDISCARD

Anastasia Belova (1):
      cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value

Andreas Gruenbacher (1):
      gfs2: Truncate address space when flipping GFS2_DIF_JDATA flag

Charles Keepax (3):
      ASoC: wm8994: Add depends on MFD core
      ASoC: samsung: Add missing selects for MFD_WM8994
      ASoC: samsung: Add missing depends on I2C

Chuck Lever (10):
      libfs: Re-arrange locking in offset_iterate_dir()
      libfs: Define a minimum directory offset
      libfs: Add simple_offset_empty()
      libfs: Fix simple_offset_rename_exchange()
      libfs: Add simple_offset_rename() API
      shmem: Fix shmem_rename2()
      libfs: Return ENOSPC when the directory offset range is exhausted
      Revert "libfs: Add simple_offset_empty()"
      libfs: Replace simple_offset end-of-directory detection
      libfs: Use d_children list to iterate simple_offset directories

Easwar Hariharan (1):
      scsi: storvsc: Ratelimit warning logs to prevent VM denial of service

Greg Kroah-Hartman (2):
      Revert "usb: gadget: u_serial: Disable ep before setting port to null to fix the crash caused by port being null"
      Linux 6.6.75

Ido Schimmel (1):
      ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()

Igor Pylypiv (1):
      ata: libata-core: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()

Jack Greiner (1):
      Input: xpad - add support for wooting two he (arm)

Jamal Hadi Salim (1):
      net: sched: fix ets qdisc OOB Indexing

Jiri Kosina (1):
      Revert "HID: multitouch: Add support for lenovo Y9000P Touchpad"

Leonardo Brondani Schenkel (1):
      Input: xpad - improve name of 8BitDo controller 2dc8:3106

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for USB Audio Device

Linus Torvalds (1):
      cachestat: fix page cache statistics permission checking

Linus Walleij (1):
      seccomp: Stub for !CONFIG_SECCOMP

Luis Henriques (SUSE) (1):
      ext4: fix access to uninitialised lock in fc replay path

Mark Pearson (1):
      Input: atkbd - map F23 key to support default copilot shortcut

Matheos Mattsson (1):
      Input: xpad - add support for Nacon Evol-X Xbox One Controller

Maíra Canal (1):
      drm/v3d: Assign job pointer to NULL before signaling the fence

Nicolas Nobelis (1):
      Input: xpad - add support for Nacon Pro Compact

Nilton Perim Neto (1):
      Input: xpad - add unofficial Xbox 360 wireless receiver clone

Omid Ehtemam-Haghighi (1):
      ipv6: Fix soft lockups in fib6_select_path under high next hop churn

Paulo Alcantara (1):
      smb: client: handle lack of EA support in smb2_query_path_info()

Philippe Simons (1):
      irqchip/sunxi-nmi: Add missing SKIP_WAKE flag

Pierre-Loup A. Griffais (1):
      Input: xpad - add QH Electronics VID/PID

Qasim Ijaz (1):
      USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()

Rob Herring (Arm) (1):
      of/unittest: Add test that of_address_to_resource() fails on non-translatable address

Russell Harmon (1):
      hwmon: (drivetemp) Set scsi command timeout to 10s

Selvin Xavier (1):
      RDMA/bnxt_re: Avoid CPU lockups due fifo occupancy check loop

Tom Chung (1):
      drm/amd/display: Use HW lock mgr for PSR1

Xiang Zhang (1):
      scsi: iscsi: Fix redundant response for ISCSI_UEVENT_GET_HOST_STATS request


