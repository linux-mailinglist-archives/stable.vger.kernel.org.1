Return-Path: <stable+bounces-93010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 515DB9C8C4E
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 14:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55DD1F24E6A
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCC02B9B9;
	Thu, 14 Nov 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lnqi8is4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8429B2A1CF;
	Thu, 14 Nov 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592756; cv=none; b=d1encZbdrdfQDZMyNNZnJmZgTb9OLlkqN1TApr7eMqptt/N+DNXofLW8mDtPGXT1d3GEzFL98plOqzq39R51Kg4NiIFfxLgE5X+/4/rY1xShQF6qOSAndhy4rxnCUe2XXf/To6+7KT072svdf/AtvCHZex6PVWEsrlOG6PJv/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592756; c=relaxed/simple;
	bh=/Ox0mkgBomp9Jv5yEA8b3ZKv+o5+jtVpcwp44DtabQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PBqUP4PkvqQXRGojhc3rwNK5fCT0dnTYZ48pWoH34ftXnjmUDymY0tk7ckTsq5SqRiKnH6qf7MkQ4BnfvmtfPCARNtbearX4jLOiouFxyzcMJ3oHP0CfPb48L12oi5RzzIB/geUSWKcrLtPyxFRJ6CnaSSan1xhcuc4xspUkLxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lnqi8is4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E455DC4CED4;
	Thu, 14 Nov 2024 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731592756;
	bh=/Ox0mkgBomp9Jv5yEA8b3ZKv+o5+jtVpcwp44DtabQs=;
	h=From:To:Cc:Subject:Date:From;
	b=lnqi8is4U67dpW/FS5bTkAqsk2lLbWNWek4mJF750Wc0Ocf3/HZ8qwiMM9cvX/0/N
	 mm/mt2iaS6c8fwfHxZ575ElOYzTdqdHrBAg+oOgsL+ZfzU0Cf9lTWzxDOHrfgOaRWn
	 SnyyuBrh4Vl2d1HVSqi2wcueFFCi8FxQMJICmG6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.117
Date: Thu, 14 Nov 2024 14:59:05 +0100
Message-ID: <2024111405-expansion-result-1447@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.117 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arm/boot/dts/rk3036-kylin.dts                         |    4 
 arch/arm/boot/dts/rk3036.dtsi                              |   14 -
 arch/arm64/Kconfig                                         |    1 
 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi             |    4 
 arch/arm64/boot/dts/freescale/imx8mp.dtsi                  |    6 
 arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi          |   25 ++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi                 |    6 
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts             |    4 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                   |    3 
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi              |    1 
 arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts          |    2 
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi           |    2 
 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts |    2 
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi          |    4 
 arch/riscv/purgatory/entry.S                               |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                   |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                |    8 
 drivers/hid/hid-core.c                                     |    2 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                   |    3 
 drivers/irqchip/irq-gic-v3.c                               |    7 
 drivers/md/dm-cache-target.c                               |   59 +++---
 drivers/md/dm-unstripe.c                                   |    4 
 drivers/media/cec/usb/pulse8/pulse8-cec.c                  |    2 
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c              |    3 
 drivers/media/dvb-core/dvb_frontend.c                      |    4 
 drivers/media/dvb-core/dvbdev.c                            |   17 +
 drivers/media/dvb-frontends/cx24116.c                      |    7 
 drivers/media/dvb-frontends/stb0899_algo.c                 |    2 
 drivers/media/i2c/adv7604.c                                |   26 +-
 drivers/media/i2c/ar0521.c                                 |    4 
 drivers/media/platform/amphion/vpu_core.c                  |    2 
 drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c        |   17 +
 drivers/media/usb/uvc/uvc_driver.c                         |    2 
 drivers/media/v4l2-core/v4l2-ctrls-api.c                   |   17 +
 drivers/net/can/c_can/c_can_main.c                         |    7 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c             |    8 
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c              |   10 -
 drivers/net/ethernet/arc/emac_main.c                       |   27 +-
 drivers/net/ethernet/arc/emac_mdio.c                       |    9 
 drivers/net/ethernet/freescale/enetc/enetc_vf.c            |    9 
 drivers/net/ethernet/hisilicon/hns3/hnae3.c                |    5 
 drivers/net/ethernet/intel/i40e/i40e.h                     |    1 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c             |    1 
 drivers/net/ethernet/intel/i40e/i40e_main.c                |   12 +
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c          |    3 
 drivers/net/ethernet/intel/ice/ice_fdir.h                  |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c          |    1 
 drivers/net/ethernet/vertexcom/mse102x.c                   |    5 
 drivers/net/phy/dp83848.c                                  |    2 
 drivers/net/virtio_net.c                                   |    6 
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c                 |    2 
 drivers/platform/x86/amd/pmc.c                             |    5 
 drivers/pwm/pwm-imx-tpm.c                                  |    4 
 drivers/scsi/sd_zbc.c                                      |    3 
 drivers/thermal/qcom/lmh.c                                 |    7 
 drivers/thermal/thermal_of.c                               |   21 +-
 drivers/usb/dwc3/core.c                                    |   25 +-
 drivers/usb/musb/sunxi.c                                   |    2 
 drivers/usb/serial/io_edgeport.c                           |    8 
 drivers/usb/serial/option.c                                |    6 
 drivers/usb/serial/qcserial.c                              |    2 
 drivers/usb/typec/ucsi/ucsi_ccg.c                          |    2 
 fs/btrfs/delayed-ref.c                                     |    2 
 fs/nfs/inode.c                                             |  125 +++++++++++--
 fs/nfs/super.c                                             |   10 -
 fs/ocfs2/xattr.c                                           |    3 
 fs/proc/vmcore.c                                           |    9 
 fs/smb/server/mgmt/user_session.c                          |   15 +
 fs/smb/server/server.c                                     |    4 
 include/linux/nfs_fs.h                                     |   47 ++++
 include/linux/tick.h                                       |    8 
 include/linux/user_namespace.h                             |    3 
 kernel/fork.c                                              |    2 
 kernel/signal.c                                            |    3 
 kernel/ucount.c                                            |    9 
 mm/filemap.c                                               |    2 
 net/core/dst.c                                             |   17 +
 net/mac80211/chan.c                                        |    4 
 net/mac80211/mlme.c                                        |    2 
 net/mac80211/scan.c                                        |    2 
 net/mac80211/util.c                                        |    4 
 net/mptcp/pm_userspace.c                                   |    3 
 net/sched/sch_taprio.c                                     |   18 +
 net/sctp/sm_statefuns.c                                    |    2 
 net/sunrpc/xprtsock.c                                      |    1 
 net/vmw_vsock/hyperv_transport.c                           |    1 
 net/vmw_vsock/virtio_transport_common.c                    |    1 
 security/keys/keyring.c                                    |    7 
 sound/firewire/tascam/amdtp-tascam.c                       |    2 
 sound/pci/hda/patch_conexant.c                             |    2 
 sound/pci/hda/patch_realtek.c                              |    1 
 sound/soc/amd/yc/acp6x-mach.c                              |    7 
 sound/soc/stm/stm32_spdifrx.c                              |    2 
 sound/usb/mixer.c                                          |    1 
 sound/usb/quirks.c                                         |    2 
 tools/lib/thermal/sampling.c                               |    2 
 tools/testing/selftests/arm64/signal/test_signals.c        |    4 
 98 files changed, 569 insertions(+), 228 deletions(-)

Aleksandr Loktionov (1):
      i40e: fix race condition by adding filter's intermediate sync state

Alex Deucher (2):
      drm/amdgpu: Adjust debugfs eviction and IB access permissions
      drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()

Alexander Stein (4):
      arm64: dts: imx8qm: Fix VPU core alias name
      arm64: dts: imx8qxp: Add VPU subsystem file
      arm64: dts: imx8-ss-vpu: Fix imx8qm VPU IRQs
      media: amphion: Fix VPU core alias name

Amelie Delaunay (1):
      ASoC: stm32: spdifrx: fix dma channel release in stm32_spdifrx_remove

Andrei Vagin (1):
      ucounts: fix counter leak in inc_rlimit_get_ucounts()

Andrew Kanner (1):
      ocfs2: remove entry once instead of null-ptr-dereference in ocfs2_xa_remove()

Antonio Quartulli (1):
      drm/amdgpu: prevent NULL pointer dereference if ATIF is not supported

Benjamin Segall (1):
      posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER on clone

Benoit Sevens (1):
      media: uvcvideo: Skip parsing frames of type UVC_VS_UNDEFINED in uvc_parse_format

Benoît Monin (1):
      USB: serial: option: add Quectel RG650V

Chen Ridong (1):
      security/keys: fix slab-out-of-bounds in key_task_permission

Christoffer Sandberg (1):
      ALSA: hda/realtek: Fix headset mic on TUXEDO Gemini 17 Gen3

Corey Hickey (1):
      platform/x86/amd/pmc: Detect when STB is not available

Dan Carpenter (2):
      usb: typec: fix potential out of bounds in ucsi_ccg_update_set_new_cam_cmd()
      USB: serial: io_edgeport: fix use after free in debug printk

Daniel Maslowski (1):
      riscv/purgatory: align riscv_kernel_entry

Dario Binacchi (1):
      can: c_can: fix {rx,tx}_errors statistics

Diederik de Haas (2):
      arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328
      arm64: dts: rockchip: Fix wakeup prop names on PineNote BT node

Diogo Silva (1):
      net: phy: ti: add PHY_RST_AFTER_CLK_EN flag

Dmitry Antipov (1):
      net: sched: use RCU read-side critical section in taprio_dump()

Dmitry Baryshkov (1):
      thermal/drivers/qcom/lmh: Remove false lockdep backtrace

Emil Dahl Juhl (1):
      tools/lib/thermal: Fix sampling handler context ptr

Eric Dumazet (1):
      net: do not delay dst_entries_add() in dst_release()

Erik Schumacher (1):
      pwm: imx-tpm: Use correct MODULO value for EPWM mode

Filipe Manana (1):
      btrfs: reinitialize delayed ref list after deleting it from the list

Geert Uytterhoeven (2):
      arm64: dts: rockchip: Fix rt5651 compatible value on rk3399-eaidk-610
      arm64: dts: rockchip: Fix rt5651 compatible value on rk3399-sapphire-excavator

Geliang Tang (1):
      mptcp: use sock_kfree_s instead of kfree

Greg Kroah-Hartman (2):
      Revert "wifi: mac80211: fix RCU list iterations"
      Linux 6.1.117

Heiko Stuebner (7):
      arm64: dts: rockchip: Fix bluetooth properties on Rock960 boards
      arm64: dts: rockchip: Remove #cooling-cells from fan on Theobroma lion
      arm64: dts: rockchip: Fix LED triggers on rk3308-roc-cc
      ARM: dts: rockchip: fix rk3036 acodec node
      ARM: dts: rockchip: drop grf reference from rk3036 hdmi
      ARM: dts: rockchip: Fix the spi controller on rk3036
      ARM: dts: rockchip: Fix the realtek audio codec on rk3036-kylin

Hyunwoo Kim (2):
      hv_sock: Initializing vsk->trans to NULL to prevent a dangling pointer
      vsock/virtio: Initialization of the dangling pointer occurring in vsk->trans

Icenowy Zheng (1):
      thermal/of: support thermal zones w/o trips subnode

Jack Wu (1):
      USB: serial: qcserial: add support for Sierra Wireless EM86xx

Jarosław Janik (1):
      Revert "ALSA: hda/conexant: Mute speakers at suspend / shutdown"

Jinjie Ruan (2):
      ksmbd: Fix the missing xa_store error check
      net: wwan: t7xx: Fix off-by-one error in t7xx_dpmaif_rx_buf_alloc()

Jiri Kosina (1):
      HID: core: zero-initialize the report buffer

Johan Jonker (2):
      net: arc: fix the device for dma_map_single/dma_unmap_single
      net: arc: rockchip: fix emac mdio node support

Johannes Thumshirn (1):
      scsi: sd_zbc: Use kvzalloc() to allocate REPORT ZONES buffer

Marc Kleine-Budde (2):
      can: mcp251xfd: mcp251xfd_get_tef_len(): fix length calculation
      can: mcp251xfd: mcp251xfd_ring_alloc(): fix coalescing configuration when switching CAN modes

Marc Zyngier (1):
      irqchip/gic-v3: Force propagation of the active state with a read-back

Mark Brown (1):
      kselftest/arm64: Initialise current at build time in signal tests

Mark Rutland (1):
      arm64: Kconfig: Make SME depend on BROKEN for now

Mateusz Polchlopek (1):
      ice: change q_index variable type to s16 to store -1 value

Mauro Carvalho Chehab (10):
      media: stb0899_algo: initialize cfr before using it
      media: dvbdev: prevent the risk of out of memory access
      media: dvb_frontend: don't play tricks with underflow values
      media: adv7604: prevent underflow condition when reporting colorspace
      media: ar0521: don't overflow when checking PLL values
      media: s5p-jpeg: prevent buffer overflows
      media: cx24116: prevent overflows on SNR calculus
      media: pulse8-cec: fix data timestamp at pulse8_setup()
      media: v4l2-tpg: prevent the risk of a division by zero
      media: v4l2-ctrls-api: fix error handling for v4l2_g_ctrl()

Michal Schmidt (1):
      bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq

Mike Snitzer (1):
      nfs: avoid i_lock contention in nfs_clear_invalid_mapping

Ming-Hung Tsai (5):
      dm cache: correct the number of origin blocks to match the target length
      dm cache: fix flushing uninitialized delayed_work on cache_ctr error
      dm cache: fix out-of-bounds access to the dirty bitset when resizing
      dm cache: optimize dirty bit checking with find_next_bit when resizing
      dm cache: fix potential out-of-bounds access on the first resume

Mingcong Bai (1):
      ASoC: amd: yc: fix internal mic on Xiaomi Book Pro 14 2022

Murad Masimov (1):
      ALSA: firewire-lib: fix return value on fail in amdtp_tscm_init()

Namjae Jeon (2):
      ksmbd: fix slab-use-after-free in ksmbd_smb2_session_create
      ksmbd: fix slab-use-after-free in smb3_preauth_hash_rsp

NeilBrown (3):
      sunrpc: handle -ENOTCONN in xs_tcp_setup_socket()
      NFSv3: only use NFS timeout for MOUNT when protocols are compatible
      NFSv3: handle out-of-order write replies.

Nícolas F. R. A. Prado (1):
      net: stmmac: Fix unbalanced IRQ wake disable warning on single irq case

Peiyang Wang (1):
      net: hns3: fix kernel crash when uninstalling driver

Peng Fan (1):
      arm64: dts: imx8mp: correct sdhc ipg clk

Philo Lu (1):
      virtio_net: Add hash_key_length check

Qi Xi (1):
      fs/proc: fix compile warning about variable 'vmcore_mmap_ops'

Reinhard Speyerer (1):
      USB: serial: option: add Fibocom FG132 0x0112 composition

Roberto Sassu (1):
      nfs: Fix KMSAN warning in decode_getfattr_attrs()

Roger Quadros (1):
      usb: dwc3: fix fault at system suspend if device was already runtime suspended

Roman Gushchin (1):
      signal: restore the override_rlimit logic

Stefan Wahren (1):
      net: vertexcom: mse102x: Fix possible double free of TX skb

Takashi Iwai (1):
      ALSA: usb-audio: Add quirk for HP 320 FHD Webcam

Trond Myklebust (1):
      filemap: Fix bounds checking in filemap_read()

Wei Fang (1):
      net: enetc: set MAC address to the VF net_device

Xin Long (1):
      sctp: properly validate chunk size in sctp_sf_ootb()

Zichen Xie (1):
      dm-unstriped: cast an operand to sector_t to prevent potential uint32_t overflow

Zijun Hu (1):
      usb: musb: sunxi: Fix accessing an released usb phy


