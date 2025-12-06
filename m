Return-Path: <stable+bounces-200270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6571FCAAE2D
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 22:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68E3430DC7D1
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 21:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E8E2D8DDD;
	Sat,  6 Dec 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JVL7nlgZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FE02C0F9C;
	Sat,  6 Dec 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765057201; cv=none; b=iAo6kqi4Y6ir9xl8QcN/XN5aqeaGi13hRR1XqcHskHfXxWgcZRfT+wKr8hxGESOYiqg1zcTND04wK2Q/Vb/3x6gafD/L1GUG9tCQOeBRPG8aBav8s8Lqz+DYovooquEw0Hmszg12KWtQxqKWXihIB0g4pYtTfwJa89VO9fPIQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765057201; c=relaxed/simple;
	bh=XxUDmdW/6WrgyUEjkAcDeSEDmsetSlBs3OYxLluWMUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZnVx0lnojOnbIYSXMHGJrcET5jUiZV5LwsObs0BMQX3JpdJHlCDejjp6AVxf5eRErpS70qAsbePes9G79Yp2g1Sb2hG+dvBvoZCF0vK1j7+iW0jaUHs51dGOKXPwt9OAbQyPkm6e0uS68HTlCDaJ9yoibvxoRe+2LBbUFnyOjlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JVL7nlgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9B2C4CEF5;
	Sat,  6 Dec 2025 21:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765057201;
	bh=XxUDmdW/6WrgyUEjkAcDeSEDmsetSlBs3OYxLluWMUI=;
	h=From:To:Cc:Subject:Date:From;
	b=JVL7nlgZE+Fv843dEQhp+RjXPkJnvFapqfW3PqzjlxlZTXssq2Z261XgtpoD1f8aT
	 BT5SLFtBayZFbQnQXPJJcDYyvno+lEojUQupT/+6zZxrlblWfoqp4YBY9l/YseraRq
	 UElp7JlIs4OHzuPy5QgC1HaAv+irz5UpoDuBSLr8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.119
Date: Sun,  7 Dec 2025 06:39:34 +0900
Message-ID: <2025120735-fang-ovary-9e14@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.119 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 MAINTAINERS                                               |    6 
 Makefile                                                  |    2 
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi                     |    2 
 arch/mips/mm/tlb-r4k.c                                    |  116 
 arch/x86/events/core.c                                    |   10 
 drivers/atm/fore200e.c                                    |    2 
 drivers/firmware/stratix10-svc.c                          |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                |    2 
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c           |   11 
 drivers/gpu/drm/sti/sti_vtg.c                             |    7 
 drivers/hid/hid-core.c                                    |    7 
 drivers/iio/accel/adxl355_core.c                          |   44 
 drivers/iio/accel/bmc150-accel-core.c                     |    5 
 drivers/iio/accel/bmc150-accel.h                          |    1 
 drivers/iio/adc/ad7280a.c                                 |    2 
 drivers/iio/adc/rtq6056.c                                 |    2 
 drivers/iio/common/ssp_sensors/ssp_dev.c                  |    4 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                   |   40 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c              |   19 
 drivers/mailbox/mailbox-test.c                            |    2 
 drivers/mailbox/pcc.c                                     |   32 
 drivers/md/dm-verity-fec.c                                |    6 
 drivers/most/most_usb.c                                   |   14 
 drivers/mtd/nand/spi/core.c                               |    2 
 drivers/net/bonding/bond_main.c                           |   11 
 drivers/net/bonding/bond_options.c                        |    3 
 drivers/net/can/rcar/rcar_canfd.c                         |   53 
 drivers/net/can/sja1000/sja1000.c                         |    4 
 drivers/net/can/sun4i_can.c                               |    4 
 drivers/net/can/usb/gs_usb.c                              |  100 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c          |    4 
 drivers/net/dsa/microchip/ksz_common.c                    |   30 
 drivers/net/dsa/microchip/ksz_ptp.c                       |   22 
 drivers/net/dsa/sja1105/sja1105_main.c                    |   66 
 drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c      |   22 
 drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h      |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c          |    5 
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c |   19 
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c  |    2 
 drivers/net/ethernet/cadence/macb_main.c                  |    2 
 drivers/net/ethernet/freescale/fec.h                      |    1 
 drivers/net/ethernet/freescale/fec_ptp.c                  |   64 
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c        |    2 
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c      |    5 
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c           |    4 
 drivers/net/phy/mxl-gpy.c                                 |    2 
 drivers/platform/x86/intel/punit_ipc.c                    |    2 
 drivers/slimbus/qcom-ngd-ctrl.c                           |    1 
 drivers/spi/Kconfig                                       |    4 
 drivers/spi/spi-amlogic-spifc-a1.c                        |    4 
 drivers/spi/spi-bcm63xx.c                                 |   14 
 drivers/spi/spi-mem.c                                     |   37 
 drivers/spi/spi-nxp-fspi.c                                |   22 
 drivers/staging/Kconfig                                   |    2 
 drivers/staging/Makefile                                  |    1 
 drivers/staging/rtl8712/Kconfig                           |   21 
 drivers/staging/rtl8712/Makefile                          |   35 
 drivers/staging/rtl8712/TODO                              |   13 
 drivers/staging/rtl8712/basic_types.h                     |   28 
 drivers/staging/rtl8712/drv_types.h                       |  175 -
 drivers/staging/rtl8712/ethernet.h                        |   21 
 drivers/staging/rtl8712/hal_init.c                        |  401 --
 drivers/staging/rtl8712/ieee80211.c                       |  415 --
 drivers/staging/rtl8712/ieee80211.h                       |  165 
 drivers/staging/rtl8712/mlme_linux.c                      |  160 
 drivers/staging/rtl8712/mlme_osdep.h                      |   31 
 drivers/staging/rtl8712/mp_custom_oid.h                   |  287 -
 drivers/staging/rtl8712/os_intfs.c                        |  482 --
 drivers/staging/rtl8712/osdep_intf.h                      |   32 
 drivers/staging/rtl8712/osdep_service.h                   |   60 
 drivers/staging/rtl8712/recv_linux.c                      |  139 
 drivers/staging/rtl8712/recv_osdep.h                      |   39 
 drivers/staging/rtl8712/rtl8712_bitdef.h                  |   26 
 drivers/staging/rtl8712/rtl8712_cmd.c                     |  409 --
 drivers/staging/rtl8712/rtl8712_cmd.h                     |  231 -
 drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h          |   95 
 drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h          |   19 
 drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h        |   41 
 drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h        |   32 
 drivers/staging/rtl8712/rtl8712_edcasetting_bitdef.h      |   65 
 drivers/staging/rtl8712/rtl8712_edcasetting_regdef.h      |   24 
 drivers/staging/rtl8712/rtl8712_efuse.c                   |  564 ---
 drivers/staging/rtl8712/rtl8712_efuse.h                   |   44 
 drivers/staging/rtl8712/rtl8712_event.h                   |   86 
 drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h         |  131 
 drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h         |   61 
 drivers/staging/rtl8712/rtl8712_gp_bitdef.h               |   68 
 drivers/staging/rtl8712/rtl8712_gp_regdef.h               |   29 
 drivers/staging/rtl8712/rtl8712_hal.h                     |  142 
 drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h        |   44 
 drivers/staging/rtl8712/rtl8712_io.c                      |   99 
 drivers/staging/rtl8712/rtl8712_led.c                     | 1830 ----------
 drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h       |   31 
 drivers/staging/rtl8712/rtl8712_macsetting_regdef.h       |   20 
 drivers/staging/rtl8712/rtl8712_powersave_bitdef.h        |   39 
 drivers/staging/rtl8712/rtl8712_powersave_regdef.h        |   26 
 drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h         |   36 
 drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h         |   43 
 drivers/staging/rtl8712/rtl8712_recv.c                    | 1080 ------
 drivers/staging/rtl8712/rtl8712_recv.h                    |  145 
 drivers/staging/rtl8712/rtl8712_regdef.h                  |   32 
 drivers/staging/rtl8712/rtl8712_security_bitdef.h         |   34 
 drivers/staging/rtl8712/rtl8712_spec.h                    |  121 
 drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h           |  163 
 drivers/staging/rtl8712/rtl8712_syscfg_regdef.h           |   42 
 drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h         |   49 
 drivers/staging/rtl8712/rtl8712_timectrl_regdef.h         |   26 
 drivers/staging/rtl8712/rtl8712_wmac_bitdef.h             |   49 
 drivers/staging/rtl8712/rtl8712_wmac_regdef.h             |   36 
 drivers/staging/rtl8712/rtl8712_xmit.c                    |  744 ----
 drivers/staging/rtl8712/rtl8712_xmit.h                    |  108 
 drivers/staging/rtl8712/rtl871x_cmd.c                     |  796 ----
 drivers/staging/rtl8712/rtl871x_cmd.h                     |  761 ----
 drivers/staging/rtl8712/rtl871x_debug.h                   |  130 
 drivers/staging/rtl8712/rtl871x_eeprom.c                  |  220 -
 drivers/staging/rtl8712/rtl871x_eeprom.h                  |   88 
 drivers/staging/rtl8712/rtl871x_event.h                   |  109 
 drivers/staging/rtl8712/rtl871x_ht.h                      |   33 
 drivers/staging/rtl8712/rtl871x_io.c                      |  147 
 drivers/staging/rtl8712/rtl871x_io.h                      |  236 -
 drivers/staging/rtl8712/rtl871x_ioctl.h                   |   94 
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c             | 2330 --------------
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.c               |  519 ---
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.h               |  109 
 drivers/staging/rtl8712/rtl871x_ioctl_set.c               |  354 --
 drivers/staging/rtl8712/rtl871x_ioctl_set.h               |   45 
 drivers/staging/rtl8712/rtl871x_led.h                     |  118 
 drivers/staging/rtl8712/rtl871x_mlme.c                    | 1710 ----------
 drivers/staging/rtl8712/rtl871x_mlme.h                    |  205 -
 drivers/staging/rtl8712/rtl871x_mp.c                      |  724 ----
 drivers/staging/rtl8712/rtl871x_mp.h                      |  275 -
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c                |  883 -----
 drivers/staging/rtl8712/rtl871x_mp_ioctl.h                |  328 -
 drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h           | 1034 ------
 drivers/staging/rtl8712/rtl871x_pwrctrl.c                 |  234 -
 drivers/staging/rtl8712/rtl871x_pwrctrl.h                 |  113 
 drivers/staging/rtl8712/rtl871x_recv.c                    |  671 ----
 drivers/staging/rtl8712/rtl871x_recv.h                    |  208 -
 drivers/staging/rtl8712/rtl871x_rf.h                      |   55 
 drivers/staging/rtl8712/rtl871x_security.c                | 1386 --------
 drivers/staging/rtl8712/rtl871x_security.h                |  218 -
 drivers/staging/rtl8712/rtl871x_sta_mgt.c                 |  263 -
 drivers/staging/rtl8712/rtl871x_wlan_sme.h                |   35 
 drivers/staging/rtl8712/rtl871x_xmit.c                    | 1059 ------
 drivers/staging/rtl8712/rtl871x_xmit.h                    |  288 -
 drivers/staging/rtl8712/sta_info.h                        |  132 
 drivers/staging/rtl8712/usb_halinit.c                     |  307 -
 drivers/staging/rtl8712/usb_intf.c                        |  638 ---
 drivers/staging/rtl8712/usb_ops.c                         |  195 -
 drivers/staging/rtl8712/usb_ops.h                         |   38 
 drivers/staging/rtl8712/usb_ops_linux.c                   |  515 ---
 drivers/staging/rtl8712/usb_osintf.h                      |   35 
 drivers/staging/rtl8712/wifi.h                            |  196 -
 drivers/staging/rtl8712/wlan_bssdef.h                     |  223 -
 drivers/staging/rtl8712/xmit_linux.c                      |  181 -
 drivers/staging/rtl8712/xmit_osdep.h                      |   52 
 drivers/thunderbolt/nhi.c                                 |    2 
 drivers/thunderbolt/nhi.h                                 |    1 
 drivers/tty/serial/amba-pl011.c                           |    2 
 drivers/usb/cdns3/cdns3-pci-wrap.c                        |    5 
 drivers/usb/dwc3/core.c                                   |    3 
 drivers/usb/dwc3/dwc3-pci.c                               |   80 
 drivers/usb/dwc3/ep0.c                                    |    1 
 drivers/usb/dwc3/gadget.c                                 |    7 
 drivers/usb/gadget/function/f_eem.c                       |    7 
 drivers/usb/gadget/udc/core.c                             |   18 
 drivers/usb/gadget/udc/renesas_usbf.c                     |    4 
 drivers/usb/gadget/udc/trace.h                            |    5 
 drivers/usb/host/xhci-dbgcap.h                            |    1 
 drivers/usb/host/xhci-dbgtty.c                            |   23 
 drivers/usb/renesas_usbhs/common.c                        |   14 
 drivers/usb/serial/ftdi_sio.c                             |    1 
 drivers/usb/serial/ftdi_sio_ids.h                         |    1 
 drivers/usb/serial/option.c                               |   10 
 drivers/usb/storage/sddr55.c                              |    6 
 drivers/usb/storage/transport.c                           |   16 
 drivers/usb/storage/uas.c                                 |    5 
 drivers/usb/storage/unusual_devs.h                        |    2 
 drivers/usb/typec/ucsi/psy.c                              |    5 
 fs/nfsd/nfs4state.c                                       |    6 
 fs/smb/client/connect.c                                   |    1 
 fs/smb/server/smb2pdu.c                                   |    4 
 include/linux/spi/spi-mem.h                               |   22 
 include/linux/usb/gadget.h                                |    5 
 include/net/bonding.h                                     |    1 
 net/bluetooth/hci_sock.c                                  |    2 
 net/bluetooth/smp.c                                       |   31 
 net/ceph/auth_x.c                                         |    2 
 net/ceph/ceph_common.c                                    |   53 
 net/ceph/debugfs.c                                        |   14 
 net/ceph/messenger_v2.c                                   |   11 
 net/ceph/osdmap.c                                         |   18 
 net/mptcp/protocol.c                                      |   48 
 sound/usb/quirks.c                                        |    3 
 tools/testing/selftests/net/mptcp/mptcp_join.sh           |   14 
 tools/testing/selftests/net/mptcp/mptcp_lib.sh            |   21 
 196 files changed, 909 insertions(+), 28082 deletions(-)

Alan Borzeszkowski (1):
      thunderbolt: Add support for Intel Wildcat Lake

Alan Stern (2):
      USB: storage: Remove subclass and protocol overrides from Novatek quirk
      HID: core: Harden s32ton() against conversion to 0 bits

Alex Deucher (1):
      drm/amdgpu: fix cyan_skillfish2 gpu info fw handling

Alex Hung (1):
      drm/amd/display: Check NULL before accessing

Alexey Kodanev (1):
      net: sxgbe: fix potential NULL dereference in sxgbe_rx()

Andy Shevchenko (1):
      spi: nxp-fspi: Propagate fwnode in ACPI case as well

Bastien Curutchet (Schneider Electric) (4):
      net: dsa: microchip: common: Fix checks on irq_find_mapping()
      net: dsa: microchip: ptp: Fix checks on irq_find_mapping()
      net: dsa: microchip: Fix symetry in ksz_ptp_msg_irq_{setup/free}()
      net: dsa: microchip: Free previously initialized ports on init failures

Biju Das (1):
      can: rcar_canfd: Fix CAN-FD mode as default

ChiYuan Huang (1):
      iio: adc: rtq6056: Correct the sign bit index

Christophe JAILLET (1):
      iio:common:ssp_sensors: Fix an error handling path ssp_probe()

Claudiu Beznea (1):
      usb: renesas_usbhs: Fix synchronous external abort on unbind

Dan Carpenter (1):
      platform/x86: intel: punit_ipc: fix memory corruption

Daniel Golle (1):
      net: phy: mxl-gpy: fix bogus error on USXGMII and integrated PHY

Danielle Costantino (1):
      net/mlx5e: Fix validation logic in rate limiting

David Lechner (1):
      iio: adc: ad7280a: fix ad7280_store_balance_timer()

Desnes Nunes (1):
      usb: storage: Fix memory leak in USB bulk transport

Edward Adam Davis (1):
      Bluetooth: hci_sock: Prevent race in socket write iter and sock bind

Francesco Lavra (2):
      spi: tegra114: remove Kconfig dependency on TEGRA20_APB_DMA
      iio: imu: st_lsm6dsx: fix array size for st_lsm6dsx_settings fields

Greg Kroah-Hartman (1):
      Linux 6.6.119

Gui-Dong Han (1):
      atm/fore200e: Fix possible data race in fore200e_open()

Hang Zhou (1):
      spi: bcm63xx: fix premature CS deassertion on RX-only transactions

Hangbin Liu (1):
      bonding: return detailed error when loading native XDP fails

Haotian Zhang (3):
      usb: gadget: renesas_usbf: Handle devm_pm_runtime_enable() errors
      mailbox: mailbox-test: Fix debugfs_create_dir error checking
      spi: amlogic-spifc-a1: Handle devm_pm_runtime_enable() errors

Heikki Krogerus (2):
      usb: dwc3: pci: add support for the Intel Nova Lake -S
      usb: dwc3: pci: Sort out the Intel device IDs

Horatiu Vultur (1):
      net: lan966x: Fix the initialization of taprio

Ilya Dryomov (1):
      libceph: fix potential use-after-free in have_mon_and_osd_map()

Ivan Zhaldak (1):
      ALSA: usb-audio: Add DSD quirk for LEAK Stereo 230

Jameson Thies (1):
      usb: typec: ucsi: psy: Set max current to zero when disconnected

Jamie Iles (2):
      mailbox: pcc: don't zero error register
      drivers/usb/dwc3: fix PCI parent check

Jiefeng Zhang (1):
      net: atlantic: fix fragment overflow handling in RX path

Jimmy Hu (1):
      usb: gadget: udc: fix use-after-free in usb_gadget_state_work

Jiri Olsa (1):
      Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"

Johan Hovold (2):
      most: usb: fix double free on late probe failure
      drm: sti: fix device leaks at component probe

Kai-Heng Feng (1):
      net: aquantia: Add missing descriptor cache invalidation on ATL2

Khairul Anuar Romli (1):
      firmware: stratix10-svc: fix bug in saving controller data

Kuen-Han Tsai (2):
      usb: gadget: f_eem: Fix memory leak in eem_unwrap
      usb: udc: Add trace event for usb_gadget_set_state

Linus Walleij (1):
      iio: accel: bmc150: Fix irq assumption regression

Luiz Augusto von Dentz (1):
      Bluetooth: SMP: Fix not generating mackey and ltk when repairing

Maarten Zanders (1):
      ARM: dts: nxp: imx6ul: correct SAI3 interrupt line

Maciej W. Rozycki (1):
      MIPS: mm: Prevent a TLB shutdown on initial uniquification

Manish Nagar (1):
      usb: dwc3: Fix race condition between concurrent dwc3_remove_requests() call paths

Marc Kleine-Budde (4):
      can: gs_usb: gs_usb_xmit_callback(): fix handling of failed transmitted URBs
      can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing header
      can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing data
      can: sun4i_can: sun4i_can_interrupt(): fix max irq loop handling

Mario Tesi (1):
      iio: st_lsm6dsx: Fixed calibrated timestamp calculation

Mathias Nyman (1):
      xhci: dbgtty: Fix data corruption when transmitting data form DbC to host

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: join: properly kill background tasks

Miaoqian Lin (3):
      slimbus: ngd: Fix reference count leak in qcom_slim_ngd_notify_slaves
      serial: amba-pl011: prefer dma_mapping_error() over explicit address checking
      usb: cdns3: Fix double resource release in cdns3_pci_probe

Mikulas Patocka (1):
      dm-verity: fix unreliable memory allocation

Miquel Raynal (3):
      spi: spi-mem: Extend spi-mem operations with a per-operation maximum frequency
      spi: spi-mem: Add a new controller capability
      spi: nxp-fspi: Support per spi-mem operation frequency switches

NeilBrown (1):
      nfsd: Replace clamp_t in nfsd4_get_drc_mem()

Oleksandr Suvorov (1):
      USB: serial: ftdi_sio: add support for u-blox EVK-M101

Owen Gu (1):
      usb: uas: fix urb unmapping issue when the uas device is remove during ongoing data transfer

Paolo Abeni (2):
      mptcp: clear scheduled subflows on retransmit
      mptcp: fix duplicate reset on fastclose

Paulo Alcantara (1):
      smb: client: fix memory leak in cifs_construct_tcon()

Philipp Hortmann (1):
      staging: rtl8712: Remove driver using deprecated API wext

Russell King (Oracle) (1):
      net: dsa: sja1105: simplify static configuration reload

Sean Heelan (1):
      ksmbd: fix use-after-free in session logoff

Seungjin Bae (1):
      can: kvaser_usb: leaf: Fix potential infinite loop in command parsers

Sudeep Holla (1):
      mailbox: pcc: Refactor error handling in irq handler into separate function

Thomas Bogendoerfer (1):
      MIPS: mm: kmalloc tlb_vpn array to avoid stack overflow

Thomas Mühlbacher (1):
      can: sja1000: fix max irq loop handling

Tianchu Chen (1):
      usb: storage: sddr55: Reject out-of-bound new_pba

Tudor Ambarus (1):
      spi: spi-mem: Allow specifying the byte order in Octal DTR mode

Valek Andrej (1):
      iio: accel: fix ADXL355 startup race condition

Vanillan Wang (1):
      USB: serial: option: add support for Rolling RW101R-GL

Viacheslav Dubeyko (1):
      ceph: fix crash in process_v2_sparse_read() for encrypted directories

Vladimir Oltean (1):
      net: dsa: sja1105: fix SGMII linking at 10M or 100M but not passing traffic

Wang Liang (1):
      bonding: check xdp prog when set bond mode

Wei Fang (4):
      net: fec: cancel perout_timer when PEROUT is disabled
      net: fec: do not update PEROUT if it is enabled
      net: fec: do not allow enabling PPS and PEROUT simultaneously
      net: fec: do not register PPS event for PEROUT

luoguangfei (1):
      net: macb: fix unregister_netdev call order in macb_remove()

ziming zhang (2):
      libceph: prevent potential out-of-bounds writes in handle_auth_session_key()
      libceph: replace BUG_ON with bounds check for map->max_osd

Łukasz Bartosik (1):
      xhci: dbgtty: fix device unregister


