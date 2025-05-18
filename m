Return-Path: <stable+bounces-144699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD4BABAE41
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 08:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40E13B9583
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 06:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3171720125F;
	Sun, 18 May 2025 06:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DlPmPydA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB56B20102B;
	Sun, 18 May 2025 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747550603; cv=none; b=jnUnd3+OKeq8GJZUuoggHbov4rlFDf2vO2JeYgi+brD4IEDD7gd6+LwtR/e2Jvr1xHLerj1Ner47zGPGI9qr38U95FZzBx+jfBVChDn+cE/CJKU05G1sRltuHtPpQwbm82qUL893NkJcebAuC6CKKxqOcvGG0XxxgowV9t5fLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747550603; c=relaxed/simple;
	bh=vhGht7Oqo949jUJMEe3ANoercq68Os1Ting7It/etjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SX4WfnBJ8is4Vp+MXsv1iAnGhSnfwb7jKyzxtTh9N7GhFNgsoKBohUxBEpbT42ZYrc7RfhAbLaedfM+FoNN+F9QOG1oABsx6aT8Lt/kx7LQzCOsDwOBVPLWect3uelzgFksBK4Wo7Mkh/TXrUROKhm3OQMZeb18VvleaQihqISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DlPmPydA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E8CC4CEE7;
	Sun, 18 May 2025 06:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747550602;
	bh=vhGht7Oqo949jUJMEe3ANoercq68Os1Ting7It/etjc=;
	h=From:To:Cc:Subject:Date:From;
	b=DlPmPydAHScJTuXdKrEW0dI5kg8GQab27LmuThFM/6+VotUcxjRrCCuYAeZUNbHEX
	 MPiOJdfcQLoKxDmZ9t8rh5zIV7nzfxrx5AsqXM9Y0JvLlX62mRY5v7fk+CqjI5TdZf
	 tRhvRbKctQUK2h22pGkrdnlDYYTjUOIlfek/ny24=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.183
Date: Sun, 18 May 2025 08:41:31 +0200
Message-ID: <2025051832-disarm-unsolved-c002@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.183 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    2 
 arch/mips/include/asm/ptrace.h                              |    3 
 arch/x86/kernel/cpu/bugs.c                                  |    5 
 arch/x86/kernel/cpu/common.c                                |    9 
 arch/x86/mm/tlb.c                                           |   23 +
 arch/x86/net/bpf_jit_comp.c                                 |   52 +++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |   28 +-
 drivers/gpu/drm/panel/panel-simple.c                        |   25 -
 drivers/iio/accel/adis16201.c                               |    4 
 drivers/iio/adc/ad7606_spi.c                                |    2 
 drivers/iio/adc/dln2-adc.c                                  |    2 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c              |    6 
 drivers/input/mouse/synaptics.c                             |    5 
 drivers/net/can/m_can/m_can.c                               |    2 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c              |    2 
 drivers/net/dsa/b53/b53_common.c                            |   36 +-
 drivers/net/phy/microchip.c                                 |   46 +++
 drivers/nvme/host/core.c                                    |    3 
 drivers/staging/axis-fifo/axis-fifo.c                       |   14 -
 drivers/staging/iio/adc/ad7816.c                            |    2 
 drivers/usb/cdns3/cdnsp-gadget.c                            |   31 ++
 drivers/usb/cdns3/cdnsp-gadget.h                            |    6 
 drivers/usb/cdns3/cdnsp-pci.c                               |   12 
 drivers/usb/cdns3/cdnsp-ring.c                              |    3 
 drivers/usb/cdns3/core.h                                    |    3 
 drivers/usb/class/usbtmc.c                                  |   59 ++--
 drivers/usb/gadget/udc/tegra-xudc.c                         |    4 
 drivers/usb/host/uhci-platform.c                            |    2 
 drivers/usb/host/xhci-tegra.c                               |    3 
 drivers/usb/typec/tcpm/tcpm.c                               |    2 
 drivers/usb/typec/ucsi/displayport.c                        |    2 
 drivers/xen/xenbus/xenbus.h                                 |    2 
 drivers/xen/xenbus/xenbus_comms.c                           |    9 
 drivers/xen/xenbus/xenbus_dev_frontend.c                    |    2 
 drivers/xen/xenbus/xenbus_xs.c                              |   18 +
 fs/namespace.c                                              |    3 
 fs/ocfs2/journal.c                                          |   80 ++++-
 fs/ocfs2/journal.h                                          |    1 
 fs/ocfs2/ocfs2.h                                            |   17 +
 fs/ocfs2/quota_local.c                                      |    9 
 fs/ocfs2/super.c                                            |    3 
 include/linux/rcupdate.h                                    |    3 
 include/linux/types.h                                       |    3 
 include/uapi/linux/types.h                                  |    1 
 kernel/params.c                                             |    4 
 net/can/gw.c                                                |  165 +++++++-----
 net/ipv6/addrconf.c                                         |   15 -
 net/netfilter/ipset/ip_set_hash_gen.h                       |    2 
 net/openvswitch/actions.c                                   |    3 
 49 files changed, 536 insertions(+), 202 deletions(-)

Aditya Garg (3):
      Input: synaptics - enable InterTouch on Dynabook Portege X30L-G
      Input: synaptics - enable InterTouch on Dell Precision M3800
      Input: synaptics - enable InterTouch on TUXEDO InfinityBook Pro 14 v5

Al Viro (1):
      do_umount(): add missing barrier before refcount checks in sync case

Alexey Charkov (1):
      usb: uhci-platform: Make the clock really optional

Andrei Kuchynski (1):
      usb: typec: ucsi: displayport: Fix NULL pointer access

Andy Shevchenko (1):
      types: Complement the aligned types with signed 64-bit one

Angelo Dureghello (1):
      iio: adc: ad7606: fix serial register access

Daniel Sneddon (2):
      x86/bpf: Call branch history clearing sequence on exit
      x86/bpf: Add IBHF call at end of classic BPF

Daniel Wagner (1):
      nvme: unblock ctrl state transition for firmware update

Dave Hansen (1):
      x86/mm: Eliminate window where TLB flushes may be inadvertently skipped

Dave Penkler (3):
      usb: usbtmc: Fix erroneous get_stb ioctl error returns
      usb: usbtmc: Fix erroneous wait_srq ioctl return
      usb: usbtmc: Fix erroneous generic_read ioctl return

Dmitry Antipov (1):
      module: ensure that kobject_put() is safe for module type kobjects

Dmitry Torokhov (1):
      Input: synaptics - enable SMBus for HP Elitebook 850 G1

Eelco Chaudron (1):
      openvswitch: Fix unsafe attribute parsing in output_userspace()

Eric Dumazet (1):
      can: gw: use call_rcu() instead of costly synchronize_rcu()

Gabriel Shahrouzi (4):
      staging: iio: adc: ad7816: Correct conditional logic for store mode
      staging: axis-fifo: Remove hardware resets for user errors
      staging: axis-fifo: Correct handling of tx_fifo_depth for size validation
      iio: adis16201: Correct inclinometer channel resolution

Greg Kroah-Hartman (2):
      Revert "net: phy: microchip: force IRQ polling mode for lan88xx"
      Linux 5.15.183

Guillaume Nault (1):
      gre: Fix again IPv6 link-local address generation.

Jan Kara (3):
      ocfs2: switch osb->disable_recovery to enum
      ocfs2: implement handshaking with ocfs2 recovery thread
      ocfs2: stop quota recovery before disabling quotas

Jason Andryuk (1):
      xenbus: Use kref to track req lifetime

Jim Lin (1):
      usb: host: tegra: Prevent host controller crash when OTG port is used

Jonas Gorski (6):
      net: dsa: b53: allow leaky reserved multicast
      net: dsa: b53: fix clearing PVID of a port
      net: dsa: b53: fix flushing old pvid VLAN on pvid change
      net: dsa: b53: fix VLAN ID for untagged vlan on bridge leave
      net: dsa: b53: always rejoin default untagged VLAN on bridge leave
      net: dsa: b53: fix learning on VLAN unaware bridges

Jonathan Cameron (1):
      iio: adc: dln2: Use aligned_s64 for timestamp

Jozsef Kadlecsik (1):
      netfilter: ipset: fix region locking in hash types

Kevin Baker (1):
      drm/panel: simple: Update timings for AUO G101EVN010

Manuel Fombuena (1):
      Input: synaptics - enable InterTouch on Dynabook Portege X30-D

Marc Kleine-Budde (2):
      can: mcan: m_can_class_unregister(): fix order of unregistration calls
      can: mcp251xfd: mcp251xfd_remove(): fix order of unregistration calls

Oliver Hartkopp (1):
      can: gw: fix RCU/BH usage in cgw_create_job()

Oliver Neukum (1):
      USB: usbtmc: use interruptible sleep in usbtmc_read

Pawan Gupta (1):
      x86/bhi: Do not set BHI_DIS_S in 32-bit mode

Pawel Laszczak (2):
      usb: cdnsp: Fix issue with resuming from L1
      usb: cdnsp: fix L1 resume issue for RTL_REVISION_NEW_LPM version

RD Babiera (1):
      usb: typec: tcpm: delay SNK_TRY_WAIT_DEBOUNCE to SRC_TRYWAIT transition

Silvano Seva (2):
      iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_fifo
      iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_tagged_fifo

Thorsten Blum (1):
      MIPS: Fix MAX_REG_OFFSET

Uladzislau Rezki (Sony) (1):
      rcu/kvfree: Add kvfree_rcu_mightsleep() and kfree_rcu_mightsleep()

Wayne Chang (1):
      usb: gadget: tegra-xudc: ACK ST_RC after clearing CTRL_RUN

Wayne Lin (1):
      drm/amd/display: Fix wrong handling for AUX_DEFER case


