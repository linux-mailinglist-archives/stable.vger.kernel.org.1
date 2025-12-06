Return-Path: <stable+bounces-200275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EDFCAAE3F
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 22:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A709E309666F
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 21:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F43A2DF144;
	Sat,  6 Dec 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cf0IICDU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0852DF13A;
	Sat,  6 Dec 2025 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765057228; cv=none; b=U+SfDuOPoI1egk8N+aRzMXAzyOoHakJaHxDtZNmpjK6R4OZq3lM9cDMuhsp2T5Z628f3/uiMXy94zHr4QsbiQykzUFdCBg1Rrr/L6Tf8kkwJItPIleCBvNKRfX4H4F74WxfUmXAw79J2YMjJBpMD1Zawz9FHHeNjpuKkoFtlBp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765057228; c=relaxed/simple;
	bh=N8NbJs/hwOvWA7tcvEAMDllrCGiiAtw0Z3Hm759rqoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WJK22s5bWi8clscWfKuq7HNUzdkeNtvS693/alufzP2vCEctCXqihHSN1JXHIxnctIfPWWTbpsX4vQ2f4hayQOZ6qlYeAtgmqXgmUWeqmtf/1SsA73X65E+GYscqoov1Y12GO/dE/xa6iU65K4/bHMBxTZUQxRA5uSt1ylY4jdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cf0IICDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C9BC4CEF5;
	Sat,  6 Dec 2025 21:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765057228;
	bh=N8NbJs/hwOvWA7tcvEAMDllrCGiiAtw0Z3Hm759rqoM=;
	h=From:To:Cc:Subject:Date:From;
	b=Cf0IICDUH3TTmhSOPFatbuyIw3Jmq2+kjbRcQs0DXrYeV+tEmpvMZVuez5gSzBxK8
	 iyFgaWsv+IWtzzP8exf1r8tLqbCKiCsb8QR/Ge8T/YebXyZ/bLCQQ7ZaOUDBy16MGv
	 OJb7q3TKTgmV0lgt1FxHtc1+YJ9W+jbXdYnH1mOc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.17.11
Date: Sun,  7 Dec 2025 06:39:47 +0900
Message-ID: <2025120747-gradation-spotless-6d31@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.17.11 kernel.

All users of the 6.17 kernel series must upgrade.

The updated 6.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.17.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                        |    2 
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi                           |    2 
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi              |    4 
 arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi              |    5 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                    |    4 
 arch/arm64/kernel/acpi.c                                        |   10 
 arch/mips/mm/tlb-r4k.c                                          |  116 ++++---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi                   |    2 
 arch/x86/events/core.c                                          |   10 
 drivers/atm/fore200e.c                                          |    2 
 drivers/bluetooth/btusb.c                                       |   39 ++
 drivers/counter/microchip-tcb-capture.c                         |    2 
 drivers/firmware/stratix10-svc.c                                |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                         |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                          |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c               |   15 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c       |    8 
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c                 |   11 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c       |    1 
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c         |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c       |    2 
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c                 |    3 
 drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c |    7 
 drivers/gpu/drm/bridge/sii902x.c                                |   20 -
 drivers/gpu/drm/drm_fb_helper.c                                 |   14 
 drivers/gpu/drm/i915/display/intel_display.c                    |    8 
 drivers/gpu/drm/i915/display/intel_psr.c                        |    6 
 drivers/gpu/drm/sti/sti_vtg.c                                   |    7 
 drivers/gpu/drm/xe/xe_gt_clock.c                                |    7 
 drivers/gpu/drm/xe/xe_guc_ct.c                                  |    3 
 drivers/iio/accel/adxl355_core.c                                |   44 ++
 drivers/iio/accel/bmc150-accel-core.c                           |    5 
 drivers/iio/accel/bmc150-accel.h                                |    1 
 drivers/iio/adc/ad4030.c                                        |    2 
 drivers/iio/adc/ad7124.c                                        |   12 
 drivers/iio/adc/ad7280a.c                                       |    2 
 drivers/iio/adc/ad7380.c                                        |    8 
 drivers/iio/adc/rtq6056.c                                       |    2 
 drivers/iio/adc/stm32-dfsdm-adc.c                               |    5 
 drivers/iio/buffer/industrialio-buffer-dma.c                    |    6 
 drivers/iio/buffer/industrialio-buffer-dmaengine.c              |    2 
 drivers/iio/common/ssp_sensors/ssp_dev.c                        |    4 
 drivers/iio/humidity/hdc3020.c                                  |   73 ++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                         |   40 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c                    |   19 -
 drivers/iio/industrialio-buffer.c                               |   21 +
 drivers/iio/pressure/bmp280-core.c                              |   15 
 drivers/iommu/iommufd/driver.c                                  |    2 
 drivers/mailbox/mailbox-test.c                                  |    2 
 drivers/mailbox/mtk-cmdq-mailbox.c                              |   45 +-
 drivers/mailbox/pcc.c                                           |    8 
 drivers/md/dm-verity-fec.c                                      |    6 
 drivers/mmc/host/sdhci-of-dwcmshc.c                             |   29 +
 drivers/most/most_usb.c                                         |   14 
 drivers/net/can/rcar/rcar_canfd.c                               |   53 +--
 drivers/net/can/sja1000/sja1000.c                               |    4 
 drivers/net/can/sun4i_can.c                                     |    4 
 drivers/net/can/usb/gs_usb.c                                    |  100 +++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c                |    4 
 drivers/net/dsa/microchip/ksz_common.c                          |   31 -
 drivers/net/dsa/microchip/ksz_ptp.c                             |   22 -
 drivers/net/dsa/sja1105/sja1105_main.c                          |    7 
 drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c            |   22 +
 drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h            |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c                |    5 
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c       |   19 -
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c        |    2 
 drivers/net/ethernet/freescale/fec.h                            |    1 
 drivers/net/ethernet/freescale/fec_ptp.c                        |   64 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c              |    2 
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c                      |    2 
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c            |    5 
 drivers/net/ethernet/realtek/r8169_main.c                       |   19 -
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c                 |    4 
 drivers/net/phy/mxl-gpy.c                                       |   20 -
 drivers/net/team/team_core.c                                    |   23 -
 drivers/net/tun_vnet.h                                          |    2 
 drivers/net/veth.c                                              |    7 
 drivers/net/virtio_net.c                                        |    3 
 drivers/net/wwan/mhi_wwan_mbim.c                                |    2 
 drivers/nvmem/layouts.c                                         |    2 
 drivers/platform/x86/intel/punit_ipc.c                          |    2 
 drivers/pmdomain/tegra/powergate-bpmp.c                         |    1 
 drivers/regulator/rtq2208-regulator.c                           |    6 
 drivers/slimbus/qcom-ngd-ctrl.c                                 |    1 
 drivers/spi/Kconfig                                             |    4 
 drivers/spi/spi-amlogic-spifc-a1.c                              |    4 
 drivers/spi/spi-bcm63xx.c                                       |   14 
 drivers/spi/spi-cadence-quadspi.c                               |   18 -
 drivers/spi/spi-nxp-fspi.c                                      |   28 +
 drivers/thunderbolt/nhi.c                                       |    2 
 drivers/thunderbolt/nhi.h                                       |    1 
 drivers/tty/serial/8250/8250.h                                  |    4 
 drivers/tty/serial/8250/8250_platform.c                         |    2 
 drivers/tty/serial/8250/8250_rsa.c                              |   26 +
 drivers/tty/serial/8250/Makefile                                |    2 
 drivers/tty/serial/amba-pl011.c                                 |    2 
 drivers/usb/cdns3/cdns3-pci-wrap.c                              |    5 
 drivers/usb/dwc3/core.c                                         |    3 
 drivers/usb/dwc3/dwc3-pci.c                                     |   80 ++---
 drivers/usb/dwc3/ep0.c                                          |    1 
 drivers/usb/dwc3/gadget.c                                       |    7 
 drivers/usb/gadget/function/f_eem.c                             |    7 
 drivers/usb/gadget/udc/core.c                                   |   18 +
 drivers/usb/gadget/udc/renesas_usbf.c                           |    4 
 drivers/usb/gadget/udc/trace.h                                  |    5 
 drivers/usb/host/xhci-dbgcap.h                                  |    1 
 drivers/usb/host/xhci-dbgtty.c                                  |   23 +
 drivers/usb/host/xhci-ring.c                                    |   15 
 drivers/usb/host/xhci.c                                         |    1 
 drivers/usb/renesas_usbhs/common.c                              |   14 
 drivers/usb/serial/ftdi_sio.c                                   |    1 
 drivers/usb/serial/ftdi_sio_ids.h                               |    1 
 drivers/usb/serial/option.c                                     |   10 
 drivers/usb/storage/sddr55.c                                    |    6 
 drivers/usb/storage/transport.c                                 |   16 +
 drivers/usb/storage/uas.c                                       |    5 
 drivers/usb/storage/unusual_devs.h                              |    2 
 drivers/usb/typec/ucsi/psy.c                                    |    5 
 drivers/vhost/net.c                                             |   53 ++-
 drivers/vhost/vhost.c                                           |   76 +++-
 drivers/vhost/vhost.h                                           |   10 
 drivers/video/fbdev/core/fbcon.c                                |    9 
 fs/afs/cell.c                                                   |   43 --
 fs/afs/internal.h                                               |    1 
 fs/afs/security.c                                               |   49 ++-
 fs/namespace.c                                                  |    7 
 fs/overlayfs/util.c                                             |    4 
 fs/smb/client/connect.c                                         |    1 
 include/linux/iio/buffer-dma.h                                  |    1 
 include/linux/iio/buffer_impl.h                                 |    2 
 include/linux/mailbox/mtk-cmdq-mailbox.h                        |   10 
 include/linux/usb/gadget.h                                      |    5 
 include/linux/virtio_net.h                                      |    7 
 include/net/bluetooth/hci_core.h                                |   21 -
 io_uring/net.c                                                  |    6 
 kernel/dma/direct.c                                             |    1 
 kernel/time/timekeeping.c                                       |    4 
 kernel/trace/trace.c                                            |   10 
 mm/huge_memory.c                                                |   22 -
 mm/memfd.c                                                      |   27 +
 mm/swapfile.c                                                   |    4 
 net/bluetooth/hci_core.c                                        |   89 ++---
 net/bluetooth/hci_sock.c                                        |    2 
 net/bluetooth/iso.c                                             |   30 +
 net/bluetooth/l2cap_core.c                                      |   23 +
 net/bluetooth/sco.c                                             |   35 +-
 net/bluetooth/smp.c                                             |   31 -
 net/ceph/auth_x.c                                               |    2 
 net/ceph/ceph_common.c                                          |   53 ++-
 net/ceph/debugfs.c                                              |   14 
 net/ceph/messenger_v2.c                                         |   11 
 net/ceph/osdmap.c                                               |   18 -
 net/mctp/route.c                                                |    1 
 net/mptcp/protocol.c                                            |   19 +
 net/xdp/xsk.c                                                   |  160 ++++++----
 sound/hda/codecs/cirrus/cs420x.c                                |    1 
 sound/usb/quirks.c                                              |    3 
 159 files changed, 1533 insertions(+), 802 deletions(-)

Achim Gratz (1):
      iio: pressure: bmp280: correct meas_time_us calculation

Alan Borzeszkowski (1):
      thunderbolt: Add support for Intel Wildcat Lake

Alan Stern (1):
      USB: storage: Remove subclass and protocol overrides from Novatek quirk

Alex Deucher (2):
      drm/amdgpu: fix cyan_skillfish2 gpu info fw handling
      Revert "drm/amd/display: Move setup_stream_attribute"

Alex Hung (1):
      drm/amd/display: Check NULL before accessing

Alexey Kodanev (1):
      net: sxgbe: fix potential NULL dereference in sxgbe_rx()

Andrei Vagin (1):
      fs/namespace: fix reference leak in grab_requested_mnt_ns

Andy Shevchenko (1):
      spi: nxp-fspi: Propagate fwnode in ACPI case as well

Anurag Dutta (2):
      spi: spi-cadence-quadspi: Remove duplicate pm_runtime_put_autosuspend() call
      spi: spi-cadence-quadspi: Enable pm runtime earlier to avoid imbalance

Bastien Curutchet (Schneider Electric) (5):
      net: dsa: microchip: common: Fix checks on irq_find_mapping()
      net: dsa: microchip: ptp: Fix checks on irq_find_mapping()
      net: dsa: microchip: Don't free uninitialized ksz_irq
      net: dsa: microchip: Free previously initialized ports on init failures
      net: dsa: microchip: Fix symetry in ksz_ptp_msg_irq_{setup/free}()

Biju Das (1):
      can: rcar_canfd: Fix CAN-FD mode as default

ChiYuan Huang (3):
      iio: adc: rtq6056: Correct the sign bit index
      regulator: rtq2208: Correct buck group2 phase mapping logic
      regulator: rtq2208: Correct LDO2 logic judgment bits

Chris Lu (1):
      Bluetooth: btusb: mediatek: Fix kernel crash when releasing mtk iso interface

Christophe JAILLET (1):
      iio:common:ssp_sensors: Fix an error handling path ssp_probe()

Claudiu Beznea (1):
      usb: renesas_usbhs: Fix synchronous external abort on unbind

Dan Carpenter (2):
      platform/x86: intel: punit_ipc: fix memory corruption
      timekeeping: Fix error code in tk_aux_sysfs_init()

Daniel Golle (2):
      net: phy: mxl-gpy: fix bogus error on USXGMII and integrated PHY
      net: phy: mxl-gpy: fix link properties on USXGMII and internal PHYs

Danielle Costantino (1):
      net/mlx5e: Fix validation logic in rate limiting

David Howells (2):
      afs: Fix delayed allocation of a cell's anonymous key
      afs: Fix uninit var in afs_alloc_anon_key()

David Lechner (3):
      iio: adc: ad7124: fix temperature channel
      iio: adc: ad7280a: fix ad7280_store_balance_timer()
      iio: adc: ad7380: fix SPI offload trigger rate

Deepanshu Kartikey (2):
      tracing: Fix WARN_ON in tracing_buffers_mmap_close for split VMAs
      mm/memfd: fix information leak in hugetlb folios

Desnes Nunes (1):
      usb: storage: Fix memory leak in USB bulk transport

Devarsh Thakkar (1):
      drm/bridge: sii902x: Fix HDMI detection with DRM_BRIDGE_ATTACH_NO_CONNECTOR

Dharma Balasubiramani (1):
      counter: microchip-tcb-capture: Allow shared IRQ for multi-channel TCBs

Dimitri Fedrau (2):
      iio: humditiy: hdc3020: fix units for temperature and humidity measurement
      iio: humditiy: hdc3020: fix units for thresholds and hysteresis

Douglas Anderson (1):
      Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref

Edward Adam Davis (1):
      Bluetooth: hci_sock: Prevent race in socket write iter and sock bind

Fernando Fernandez Mancera (1):
      xsk: avoid data corruption on cq descriptor number

Francesco Lavra (2):
      spi: tegra114: remove Kconfig dependency on TEGRA20_APB_DMA
      iio: imu: st_lsm6dsx: fix array size for st_lsm6dsx_settings fields

Frank Li (2):
      arm64: dts: imx8dxl-ss-conn: swap interrupts number of eqos
      arm64: dts: imx8dxl: Correct pcie-ep interrupt number

Greg Kroah-Hartman (1):
      Linux 6.17.11

Gui-Dong Han (1):
      atm/fore200e: Fix possible data race in fore200e_open()

Gustavo A. R. Silva (1):
      iommufd/driver: Fix counter initialization for counted_by annotation

Haibo Chen (1):
      spi: spi-nxp-fspi: Add OCT-DTR mode support

Hang Zhou (1):
      spi: bcm63xx: fix premature CS deassertion on RX-only transactions

Haotian Zhang (3):
      usb: gadget: renesas_usbf: Handle devm_pm_runtime_enable() errors
      mailbox: mailbox-test: Fix debugfs_create_dir error checking
      spi: amlogic-spifc-a1: Handle devm_pm_runtime_enable() errors

Harish Chegondi (1):
      drm/xe: Fix conversion from clock ticks to milliseconds

Heikki Krogerus (2):
      usb: dwc3: pci: add support for the Intel Nova Lake -S
      usb: dwc3: pci: Sort out the Intel device IDs

Heiner Kallweit (1):
      r8169: fix RTL8127 hang on suspend/shutdown

Horatiu Vultur (1):
      net: lan966x: Fix the initialization of taprio

Ilpo Järvinen (1):
      serial: 8250: Fix 8250_rsa symbol loop

Ilya Dryomov (1):
      libceph: fix potential use-after-free in have_mon_and_osd_map()

Ivan Zhaldak (1):
      ALSA: usb-audio: Add DSD quirk for LEAK Stereo 230

Jameson Thies (1):
      usb: typec: ucsi: psy: Set max current to zero when disconnected

Jamie Iles (2):
      mailbox: pcc: don't zero error register
      drivers/usb/dwc3: fix PCI parent check

Jason Wang (1):
      vhost: rewind next_avail_head while discarding descriptors

Jason-JH Lin (1):
      mailbox: mtk-cmdq: Refine DMA address handling for the command buffer

Jens Axboe (1):
      io_uring/net: ensure vectored buffer node import is tied to notification

Jeremy Kerr (1):
      net: mctp: unconditionally set skb->dev on dst output

Jesper Dangaard Brouer (1):
      veth: reduce XDP no_direct return section to fix race

Jiefeng Zhang (1):
      net: atlantic: fix fragment overflow handling in RX path

Jimmy Hu (1):
      usb: gadget: udc: fix use-after-free in usb_gadget_state_work

Jiri Olsa (1):
      Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"

Jisheng Zhang (1):
      mmc: sdhci-of-dwcmshc: Promote the th1520 reset handling to ip level

Johan Hovold (2):
      most: usb: fix double free on late probe failure
      drm: sti: fix device leaks at component probe

Jon Hunter (1):
      pmdomain: tegra: Add GENPD_FLAG_NO_STAY_ON flag

Jon Kohler (1):
      virtio-net: avoid unnecessary checksum calculation on guest RX

Kai-Heng Feng (1):
      net: aquantia: Add missing descriptor cache invalidation on ATL2

Khairul Anuar Romli (1):
      firmware: stratix10-svc: fix bug in saving controller data

Kuen-Han Tsai (2):
      usb: gadget: f_eem: Fix memory leak in eem_unwrap
      usb: udc: Add trace event for usb_gadget_set_state

Kuniyuki Iwashima (1):
      mptcp: Initialise rcv_mss before calling tcp_send_active_reset() in mptcp_do_fastclose().

Linus Walleij (1):
      iio: accel: bmc150: Fix irq assumption regression

Lucas De Marchi (1):
      drm/xe/guc: Fix stack_depot usage

Luiz Augusto von Dentz (2):
      Bluetooth: hci_core: Fix triggering cmd_timer for HCI_OP_NOP
      Bluetooth: SMP: Fix not generating mackey and ltk when repairing

Maarten Zanders (1):
      ARM: dts: nxp: imx6ul: correct SAI3 interrupt line

Maciej Fijalkowski (1):
      xsk: avoid overwriting skb fields for multi-buffer traffic

Maciej W. Rozycki (1):
      MIPS: mm: Prevent a TLB shutdown on initial uniquification

Manish Nagar (1):
      usb: dwc3: Fix race condition between concurrent dwc3_remove_requests() call paths

Marc Kleine-Budde (4):
      can: gs_usb: gs_usb_xmit_callback(): fix handling of failed transmitted URBs
      can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing header
      can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing data
      can: sun4i_can: sun4i_can_interrupt(): fix max irq loop handling

Marcelo Schmitt (1):
      iio: adc: ad4030: Fix _scale value for common-mode channels

Mario Limonciello (AMD) (2):
      drm/amd/display: Don't change brightness for disabled connectors
      drm/amd/display: Increase EDID read retries

Mario Tesi (1):
      iio: st_lsm6dsx: Fixed calibrated timestamp calculation

Mathias Nyman (2):
      xhci: fix stale flag preventig URBs after link state error is cleared
      xhci: dbgtty: Fix data corruption when transmitting data form DbC to host

Miaoqian Lin (3):
      slimbus: ngd: Fix reference count leak in qcom_slim_ngd_notify_slaves
      serial: amba-pl011: prefer dma_mapping_error() over explicit address checking
      usb: cdns3: Fix double resource release in cdns3_pci_probe

Michael Chen (1):
      drm/amd/amdgpu: reserve vm invalidation engine for uni_mes

Mikulas Patocka (1):
      dm-verity: fix unreliable memory allocation

Mohsin Bashir (1):
      eth: fbnic: Fix counter roll-over issue

NeilBrown (1):
      ovl: fail ovl_lock_rename_workdir() if either target is unhashed

Nikola Z. Ivanov (1):
      team: Move team device type change at the end of team_port_add

Nuno Sá (3):
      iio: buffer-dma: support getting the DMA channel
      iio: buffer-dmaengine: enable .get_dma_dev()
      iio: buffer: support getting dma channel from the buffer

Oleksandr Suvorov (1):
      USB: serial: ftdi_sio: add support for u-blox EVK-M101

Olivier Moysan (1):
      iio: adc: stm32-dfsdm: fix st,adc-alt-channel property handling

Owen Gu (1):
      usb: uas: fix urb unmapping issue when the uas device is remove during ongoing data transfer

Paolo Abeni (1):
      mptcp: clear scheduled subflows on retransmit

Pauli Virtanen (1):
      Bluetooth: hci_core: lookup hci_conn on RX path on protocol side

Paulo Alcantara (1):
      smb: client: fix memory leak in cifs_construct_tcon()

Pranjal Shrivastava (1):
      dma-direct: Fix missing sg_dma_len assignment in P2PDMA bus mappings

Prike Liang (1):
      drm/amdgpu: attach tlb fence to the PTs update

Punit Agrawal (1):
      Revert "ACPI: Suppress misleading SPCR console message when SPCR table is absent"

René Rebe (1):
      ALSA: hda/cirrus fix cs420x MacPro 6,1 inverted jack detection

Sergey Matyukevich (1):
      riscv: dts: allwinner: d1: fix vlenb property

Seungjin Bae (1):
      can: kvaser_usb: leaf: Fix potential infinite loop in command parsers

Siddharth Vadapalli (1):
      spi: cadence-quadspi: Fix cqspi_probe() error handling for runtime pm

Slark Xiao (1):
      net: wwan: mhi: Keep modem name match with Foxconn T99W640

Thomas Bogendoerfer (1):
      MIPS: mm: kmalloc tlb_vpn array to avoid stack overflow

Thomas Mühlbacher (1):
      can: sja1000: fix max irq loop handling

Thomas Zimmermann (1):
      drm, fbcon, vga_switcheroo: Avoid race condition in fbcon setup

Tianchu Chen (1):
      usb: storage: sddr55: Reject out-of-bound new_pba

Valek Andrej (1):
      iio: accel: fix ADXL355 startup race condition

Vanillan Wang (1):
      USB: serial: option: add support for Rolling RW101R-GL

Viacheslav Dubeyko (1):
      ceph: fix crash in process_v2_sparse_read() for encrypted directories

Ville Syrjälä (1):
      drm/i915/psr: Reject async flips when selective fetch is enabled

Vladimir Oltean (1):
      net: dsa: sja1105: fix SGMII linking at 10M or 100M but not passing traffic

Wei Fang (4):
      net: fec: cancel perout_timer when PEROUT is disabled
      net: fec: do not update PEROUT if it is enabled
      net: fec: do not allow enabling PPS and PEROUT simultaneously
      net: fec: do not register PPS event for PEROUT

Wei Yang (1):
      mm/huge_memory: fix NULL pointer deference when splitting folio

Wentao Guan (1):
      nvmem: layouts: fix nvmem_layout_bus_uevent

Xu Yang (1):
      arm64: dts: imx8qm-mek: fix mux-controller select/enable-gpios polarity

Youngjun Park (1):
      mm: swap: remove duplicate nr_swap_pages decrement in get_swap_page_of_type()

ziming zhang (2):
      libceph: prevent potential out-of-bounds writes in handle_auth_session_key()
      libceph: replace BUG_ON with bounds check for map->max_osd

Łukasz Bartosik (1):
      xhci: dbgtty: fix device unregister


