Return-Path: <stable+bounces-164570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E510B10173
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 09:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCA74E43C0
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 07:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9088C23AB88;
	Thu, 24 Jul 2025 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LQ18FCGq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985F23AB81;
	Thu, 24 Jul 2025 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341320; cv=none; b=mPjDfE14AZmQopr4FjnRQxCcKMOElvmYm8yOw9NKWsj10e/RXFUObKwvP9HGI7UZWU4X+U2/ppjs24Aj/SGwNweQJod9uDLPI9X8Wo5yg9kMdEmoqfMhaztmHoKnwqfXNN+T54tEYbQdUQwtvnZCaVFoAP9AqftvGgvcXlfIZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341320; c=relaxed/simple;
	bh=/cmDZKin2FDAmXwhh+AVuHPJ8fCM6Vs2jTVhnhSTLlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MBlWYKS2KK9lGJEILOZYqkikwwqKMPGRBfYGBW3pk5DEX9amx6GWdbh33vTsJ+Cm/jddjlHtH/axd7aCIox2mZmfTX/at6txctdZJzsoxMQdGMZAOcMQfqN2eVnhzuWvUbhwRfPy9sFsi8UqE6KAFepuv5B4tHXD5J0fvL6NutE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LQ18FCGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D365C4CEED;
	Thu, 24 Jul 2025 07:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753341317;
	bh=/cmDZKin2FDAmXwhh+AVuHPJ8fCM6Vs2jTVhnhSTLlY=;
	h=From:To:Cc:Subject:Date:From;
	b=LQ18FCGqxczswLLoXVL+5OeQ2XdEcje0SsGRm9OxRawpNmamszspf9g/XR4Pctrxf
	 gGFhiHJ+UASvVmb653/KOEW2fT0n/cPvFEQQNbP+PdWpVp40we8ApzDCdRG8OUwI96
	 T0Ha8nw9SH3Ab0Tnsdfkh6ll3hF9tEoPBIl8o0hA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.40
Date: Thu, 24 Jul 2025 09:15:04 +0200
Message-ID: <2025072405-trophy-ladies-1d12@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.40 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi                 |    3 
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi               |    1 
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw71xx.dtsi        |    2 
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi        |    2 
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi        |    2 
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts         |    2 
 arch/arm64/boot/dts/freescale/imx95.dtsi                       |    2 
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi                |   23 ++
 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi            |    1 
 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts             |    1 
 arch/riscv/kernel/traps.c                                      |   10 
 arch/riscv/kernel/traps_misaligned.c                           |    2 
 arch/s390/net/bpf_jit_comp.c                                   |   10 
 arch/x86/kvm/xen.c                                             |    2 
 block/blk-sysfs.c                                              |    1 
 drivers/block/loop.c                                           |    5 
 drivers/bluetooth/btintel.c                                    |    2 
 drivers/bluetooth/btusb.c                                      |   78 +++---
 drivers/comedi/comedi_fops.c                                   |   30 ++
 drivers/comedi/drivers.c                                       |   17 -
 drivers/comedi/drivers/aio_iiro_16.c                           |    3 
 drivers/comedi/drivers/das16m1.c                               |    3 
 drivers/comedi/drivers/das6402.c                               |    3 
 drivers/comedi/drivers/pcl812.c                                |    3 
 drivers/cpuidle/cpuidle-psci.c                                 |   23 +-
 drivers/dma/nbpfaxi.c                                          |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                       |    9 
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                          |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c         |   11 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |    3 
 drivers/gpu/drm/mediatek/mtk_crtc.c                            |   36 +++
 drivers/gpu/drm/mediatek/mtk_crtc.h                            |    1 
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c                        |    1 
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h                        |    9 
 drivers/gpu/drm/mediatek/mtk_disp_drv.h                        |    1 
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c                        |    7 
 drivers/gpu/drm/mediatek/mtk_plane.c                           |   12 -
 drivers/gpu/drm/mediatek/mtk_plane.h                           |    3 
 drivers/gpu/drm/xe/xe_gt.c                                     |   13 -
 drivers/gpu/drm/xe/xe_gt_sriov_pf.c                            |  114 +++++++++-
 drivers/gpu/drm/xe/xe_gt_sriov_pf.h                            |    6 
 drivers/gpu/drm/xe/xe_gt_sriov_pf_control.c                    |    3 
 drivers/gpu/drm/xe/xe_gt_sriov_pf_types.h                      |   10 
 drivers/hid/hid-core.c                                         |   19 +
 drivers/hwmon/corsair-cpro.c                                   |    5 
 drivers/i2c/busses/Kconfig                                     |    1 
 drivers/i2c/busses/i2c-omap.c                                  |   30 ++
 drivers/i2c/busses/i2c-stm32.c                                 |    8 
 drivers/i2c/busses/i2c-stm32f7.c                               |   24 --
 drivers/iio/accel/fxls8962af-core.c                            |    2 
 drivers/iio/accel/st_accel_core.c                              |   10 
 drivers/iio/adc/axp20x_adc.c                                   |    1 
 drivers/iio/adc/max1363.c                                      |   43 +--
 drivers/iio/adc/stm32-adc-core.c                               |    7 
 drivers/iio/common/st_sensors/st_sensors_core.c                |   36 +--
 drivers/iio/common/st_sensors/st_sensors_trigger.c             |   20 -
 drivers/iio/industrialio-backend.c                             |    5 
 drivers/input/joystick/xpad.c                                  |    2 
 drivers/iommu/intel/iommu.c                                    |    6 
 drivers/md/dm-bufio.c                                          |    6 
 drivers/memstick/core/memstick.c                               |    2 
 drivers/mmc/host/bcm2835.c                                     |    3 
 drivers/mmc/host/sdhci-pci-core.c                              |    3 
 drivers/mmc/host/sdhci_am654.c                                 |    9 
 drivers/net/can/m_can/tcan4x5x-core.c                          |   80 +++++--
 drivers/net/can/m_can/tcan4x5x.h                               |    2 
 drivers/net/ethernet/intel/ice/ice_debugfs.c                   |    2 
 drivers/net/ethernet/intel/ice/ice_lag.c                       |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                |   12 -
 drivers/net/ethernet/mellanox/mlx5/core/main.c                 |    1 
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c              |    8 
 drivers/net/ethernet/wangxun/libwx/wx_hw.c                     |    9 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                    |   20 -
 drivers/net/ethernet/wangxun/libwx/wx_type.h                   |    2 
 drivers/net/ethernet/xilinx/xilinx_emaclite.c                  |    2 
 drivers/net/hyperv/netvsc_drv.c                                |    5 
 drivers/net/phy/phy_device.c                                   |    6 
 drivers/net/usb/sierra_net.c                                   |    4 
 drivers/net/virtio_net.c                                       |    2 
 drivers/nvme/host/core.c                                       |   18 -
 drivers/nvme/target/tcp.c                                      |    4 
 drivers/nvmem/imx-ocotp-ele.c                                  |    5 
 drivers/nvmem/imx-ocotp.c                                      |    5 
 drivers/nvmem/layouts/u-boot-env.c                             |    6 
 drivers/phy/tegra/xusb-tegra186.c                              |   75 ++++--
 drivers/phy/tegra/xusb.h                                       |    1 
 drivers/pmdomain/governor.c                                    |   18 +
 drivers/soc/aspeed/aspeed-lpc-snoop.c                          |   13 +
 drivers/soundwire/amd_manager.c                                |    4 
 drivers/spi/spi.c                                              |   14 -
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  |   69 +++---
 drivers/thunderbolt/switch.c                                   |   10 
 drivers/thunderbolt/tb.h                                       |    2 
 drivers/thunderbolt/usb4.c                                     |   12 -
 drivers/tty/serial/pch_uart.c                                  |    2 
 drivers/usb/core/hub.c                                         |   36 ++-
 drivers/usb/core/hub.h                                         |    1 
 drivers/usb/dwc2/gadget.c                                      |   38 ++-
 drivers/usb/dwc3/dwc3-qcom.c                                   |    8 
 drivers/usb/gadget/configfs.c                                  |    4 
 drivers/usb/musb/musb_gadget.c                                 |    2 
 drivers/usb/serial/ftdi_sio.c                                  |    2 
 drivers/usb/serial/ftdi_sio_ids.h                              |    3 
 drivers/usb/serial/option.c                                    |    5 
 fs/btrfs/block-group.c                                         |    3 
 fs/cachefiles/io.c                                             |    2 
 fs/cachefiles/ondemand.c                                       |    4 
 fs/efivarfs/super.c                                            |    6 
 fs/isofs/inode.c                                               |    9 
 fs/namespace.c                                                 |    5 
 fs/notify/dnotify/dnotify.c                                    |    8 
 fs/smb/client/file.c                                           |   10 
 fs/smb/client/smb2ops.c                                        |    7 
 fs/smb/client/smbdirect.c                                      |   31 ++
 include/net/bluetooth/hci_core.h                               |   22 -
 include/net/cfg80211.h                                         |    2 
 include/net/netfilter/nf_conntrack.h                           |   15 +
 include/trace/events/rxrpc.h                                   |    3 
 io_uring/net.c                                                 |   12 -
 io_uring/poll.c                                                |    2 
 kernel/bpf/helpers.c                                           |   11 
 kernel/cgroup/legacy_freezer.c                                 |    8 
 kernel/freezer.c                                               |   15 -
 kernel/sched/loadavg.c                                         |    2 
 kernel/sched/sched.h                                           |    2 
 kernel/trace/trace_events.c                                    |    5 
 kernel/trace/trace_osnoise.c                                   |    2 
 kernel/trace/trace_probe.c                                     |    2 
 net/8021q/vlan.c                                               |   42 ++-
 net/8021q/vlan.h                                               |    1 
 net/bluetooth/hci_sync.c                                       |    4 
 net/bluetooth/l2cap_core.c                                     |   26 +-
 net/bluetooth/l2cap_sock.c                                     |    3 
 net/bluetooth/smp.c                                            |   21 +
 net/bluetooth/smp.h                                            |    1 
 net/bridge/br_switchdev.c                                      |    3 
 net/ipv4/tcp_offload.c                                         |    1 
 net/ipv4/udp_offload.c                                         |    1 
 net/ipv6/mcast.c                                               |    2 
 net/ipv6/rpl_iptunnel.c                                        |    8 
 net/mptcp/options.c                                            |    3 
 net/mptcp/pm.c                                                 |    8 
 net/mptcp/protocol.c                                           |   56 ++++
 net/mptcp/protocol.h                                           |   29 +-
 net/mptcp/subflow.c                                            |   30 +-
 net/netfilter/nf_conntrack_core.c                              |   26 +-
 net/packet/af_packet.c                                         |   27 +-
 net/phonet/pep.c                                               |    2 
 net/rxrpc/call_accept.c                                        |    1 
 net/rxrpc/output.c                                             |    3 
 net/rxrpc/recvmsg.c                                            |   19 +
 net/sched/sch_htb.c                                            |    4 
 net/sched/sch_qfq.c                                            |   30 +-
 net/smc/af_smc.c                                               |   14 +
 net/smc/smc.h                                                  |    8 
 net/tls/tls_strp.c                                             |    3 
 rust/Makefile                                                  |    1 
 rust/kernel/lib.rs                                             |    1 
 rust/macros/module.rs                                          |   10 
 scripts/Makefile.build                                         |    2 
 sound/pci/hda/patch_realtek.c                                  |    2 
 tools/lib/bpf/libbpf.c                                         |   20 +
 tools/objtool/check.c                                          |    1 
 tools/testing/selftests/bpf/prog_tests/token.c                 |   19 +
 tools/testing/selftests/net/udpgro.sh                          |    8 
 tools/testing/selftests/sched_ext/exit.c                       |    8 
 167 files changed, 1334 insertions(+), 543 deletions(-)

Al Viro (2):
      fix a leak in fcntl_dirnotify()
      clone_private_mnt(): make sure that caller has CAP_SYS_ADMIN in the right userns

Alessandro Gasbarroni (1):
      Bluetooth: hci_sync: fix connectable extended advertising when using static random address

Alok Tiwari (2):
      thunderbolt: Fix bit masking in tb_dp_port_set_hops()
      net: emaclite: Fix missing pointer increment in aligned_read()

Andrea Righi (1):
      selftests/sched_ext: Fix exit selftest hang on UP

Andreas Schwab (1):
      riscv: traps_misaligned: properly sign extend value in misaligned load handler

Andrew Jeffery (2):
      soc: aspeed: lpc-snoop: Cleanup resources in stack-order
      soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled

Andrii Nakryiko (1):
      libbpf: Fix handling of BPF arena relocations

Andy Yan (2):
      arm64: dts: rockchip: Add cd-gpios for sdcard detect on Cool Pi CM5
      arm64: dts: rockchip: Add cd-gpios for sdcard detect on Cool Pi 4B

Aruna Ramakrishna (1):
      sched: Change nr_uninterruptible type to unsigned long

Balasubramani Vivekanandan (1):
      drm/xe/mocs: Initialize MOCS index early

Ban ZuoXiang (1):
      iommu/vt-d: Fix misplaced domain_attached assignment

Benjamin Tissoires (3):
      HID: core: ensure the allocated report buffer can contain the reserved report ID
      HID: core: ensure __hid_request reserves the report ID as the first byte
      HID: core: do not bypass hid_hw_raw_request

Boris Burkov (1):
      btrfs: fix block group refcount race in btrfs_create_pending_block_groups()

Breno Leitao (1):
      efivarfs: Fix memory leak of efivarfs_fs_info in fs_context error paths

Brett Werling (1):
      can: tcan4x5x: fix reset gpio usage during probe

Chen Ni (1):
      iio: adc: stm32-adc: Fix race in installing chained IRQ handler

Chen Ridong (2):
      Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"
      sched,freezer: Remove unnecessary warning in __thaw_task

Chen-Yu Tsai (1):
      iio: adc: axp20x_adc: Add missing sentinel to AXP717 ADC channel maps

Cheng Ming Lin (1):
      spi: Add check for 8-bit transfer with 8 IO mode support

Christian Eggers (1):
      Bluetooth: hci_core: add missing braces when using macro parameters

Christoph Paasch (1):
      net/mlx5: Correctly set gso_size when LRO is used

Christophe JAILLET (2):
      i2c: omap: Fix an error handling path in omap_i2c_probe()
      i2c: omap: Handle omap_i2c_init() errors in omap_i2c_probe()

Clayton King (1):
      drm/amd/display: Free memory allocation

Clément Le Goffic (2):
      i2c: stm32: fix the device used for the DMA map
      i2c: stm32f7: unmap DMA mapped buffer

Dan Carpenter (1):
      dmaengine: nbpfaxi: Fix memory corruption in probe()

Daniel Lezcano (1):
      cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y

Dave Ertman (1):
      ice: add NULL check in eswitch lag check

David Howells (2):
      rxrpc: Fix recv-recv race of completed call
      rxrpc: Fix transmission of an abort in response to an abort

Dong Chenchen (1):
      net: vlan: fix VLAN 0 refcount imbalance of toggling filtering during runtime

Drew Hamilton (1):
      usb: musb: fix gadget state on disconnect

Edip Hazuri (1):
      ALSA: hda/realtek - Fix mute LED for HP Victus 16-r0xxx

Edson Juliano Drosdeck (1):
      mmc: sdhci-pci: Quirk for broken command queuing on Intel GLK-based Positivo models

Eeli Haapalainen (1):
      drm/amdgpu/gfx8: reset compute ring wptr on the GPU on resume

Fabio Estevam (2):
      iio: adc: max1363: Fix MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
      iio: adc: max1363: Reorder mode_list[] entries

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion FE910C04 (ECM) composition

Felix Fietkau (1):
      net: fix segmentation after TCP/UDP fraglist GRO

Florian Westphal (1):
      netfilter: nf_conntrack: fix crash due to removal of uninitialised entry

Francesco Dolcini (1):
      arm64: dts: freescale: imx8mm-verdin: Keep LDO5 always on

Greg Kroah-Hartman (1):
      Linux 6.12.40

Haotien Hsu (1):
      phy: tegra: xusb: Disable periodic tracking on Tegra234

Ian Abbott (8):
      comedi: pcl812: Fix bit shift out of bounds
      comedi: aio_iiro_16: Fix bit shift out of bounds
      comedi: das16m1: Fix bit shift out of bounds
      comedi: das6402: Fix bit shift out of bounds
      comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
      comedi: Fix some signed shift left operations
      comedi: Fix use of uninitialized data in insn_rw_emulate_bits()
      comedi: Fix initialization of data for instructions that write to subdevice

Icenowy Zheng (1):
      drm/mediatek: only announce AFBC if really supported

Ihor Solodrai (1):
      selftests/bpf: Set test path for token/obj_priv_implicit_token_envvar

Ilya Leoshkevich (1):
      s390/bpf: Fix bpf_arch_text_poke() with new_addr == NULL again

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: use cs-gpios for spi1 on ringneck

Jakub Kicinski (1):
      tls: always refresh the queue when reading sock

Jan Kara (1):
      isofs: Verify inode mode when loading from disk

Jason-JH Lin (1):
      drm/mediatek: Add wait_event_timeout when disabling plane

Jayesh Choudhary (1):
      i2c: omap: Add support for setting mux

Jiawen Wu (4):
      net: libwx: remove duplicate page_pool_put_full_page()
      net: libwx: fix the using of Rx buffer DMA
      net: libwx: properly reset Rx ring descriptor
      net: libwx: fix multicast packets received count

Johan Hovold (1):
      i2c: omap: fix deprecated of_property_read_bool() use

Johannes Berg (1):
      wifi: cfg80211: remove scan request n_channels counted_by

John Garry (1):
      nvme: fix endianness of command word prints in nvme_log_err_passthru()

Joseph Huang (1):
      net: bridge: Do not offload IGMP/MLD messages

Judith Mendez (1):
      mmc: sdhci_am654: Workaround for Errata i2312

Krishna Kurapati (1):
      usb: dwc3: qcom: Don't leave BCR asserted

Kuniyuki Iwashima (3):
      rpl: Fix use-after-free in rpl_do_srh_inline().
      smc: Fix various oops due to inet_sock type confusion.
      Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()

Li Tian (1):
      hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF before open to prevent IPv6 addrconf

Lijo Lazar (1):
      drm/amdgpu: Increase reset counter only on success

Luiz Augusto von Dentz (4):
      Bluetooth: btintel: Check if controller is ISO capable on btintel_classify_pkt_type
      Bluetooth: SMP: If an unallowed command is received consider it a failure
      Bluetooth: SMP: Fix using HCI_ERROR_REMOTE_USER_TERM on timeout
      Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU

Manuel Andreas (1):
      KVM: x86/xen: Fix cleanup logic in emulation of Xen schedop poll hypercalls

Maor Gottlieb (1):
      net/mlx5: Update the list of the PCI supported devices

Mario Limonciello (1):
      thunderbolt: Fix wake on connect at runtime

Marius Zachmann (1):
      hwmon: (corsair-cpro) Validate the size of the received input buffer

Markus Blöchl (1):
      net: stmmac: intel: populate entire system_counterval_t in get_time_fn() callback

Markus Burri (1):
      iio: backend: fix out-of-bound write

Mathias Nyman (4):
      usb: hub: fix detection of high tier USB3 devices behind suspended hubs
      usb: hub: Fix flushing and scheduling of delayed work that tunes runtime pm
      usb: hub: Fix flushing of delayed work used for post resume purposes
      usb: hub: Don't try to recover devices lost during warm reset.

Matthew Brost (1):
      drm/xe: Move page fault init after topology init

Maud Spierings (1):
      iio: common: st_sensors: Fix use of uninitialize device structs

Maulik Shah (1):
      pmdomain: governor: Consider CPU latency tolerance from pm_domain_cpu_gov

Maurizio Lombardi (1):
      nvmet-tcp: fix callback lock for TLS handshake

Melissa Wen (1):
      drm/amd/display: Disable CRTC degamma LUT for DCN401

Meng Li (1):
      arm64: dts: add big-endian property back into watchdog node

Michael C. Pratt (1):
      nvmem: layouts: u-boot-env: remove crc32 endianness conversion

Michal Swiatkowski (1):
      ice: check correct pointer in fwlog debugfs

Michal Wajdeczko (3):
      drm/xe/pf: Sanitize VF scratch registers on FLR
      drm/xe/pf: Move VFs reprovisioning to worker
      drm/xe/pf: Prepare to stop SR-IOV support prior GT reset

Miguel Ojeda (2):
      objtool/rust: add one more `noreturn` Rust function for Rust 1.89.0
      rust: use `#[used(compiler)]` to fix build and `modpost` with Rust >= 1.89.0

Minas Harutyunyan (1):
      usb: dwc2: gadget: Fix enter to hibernation for UTMI+ PHY

Ming Lei (2):
      block: fix kobject leak in blk_unregister_queue
      loop: use kiocb helpers to fix lockdep warning

Nam Cao (1):
      riscv: Enable interrupt during exception handling

Nathan Chancellor (3):
      tracing/probes: Avoid using params uninitialized in parse_btf_arg()
      phonet/pep: Move call to pn_skb_get_dst_sockaddr() earlier in pep_sock_accept()
      memstick: core: Zero initialize id_reg in h_memstick_read_dev_id()

Nilton Perim Neto (1):
      Input: xpad - set correct controller type for Acer NGR200

Oliver Neukum (1):
      usb: net: sierra: check for no status endpoint

Paolo Abeni (4):
      mptcp: make fallback action and fallback decision atomic
      mptcp: plug races between subflow fail and subflow creation
      mptcp: reset fallback status gracefully at disconnect() time
      selftests: net: increase inter-packet timeout in udpgro.sh

Paul Chaignon (1):
      bpf: Reject %p% format string in bprintf-like helpers

Pavel Begunkov (1):
      io_uring/poll: fix POLLERR handling

Richard Zhu (1):
      arm64: dts: imx95: Correct the DMA interrupter number of pcie0_ep

Ryan Mann (NDI) (1):
      USB: serial: ftdi_sio: add support for NDI EMGUIDE GEMINI

Sean Anderson (1):
      net: phy: Don't register LEDs for genphy

Sean Nyekjaer (2):
      iio: accel: fxls8962af: Fix use after free in fxls8962af_fifo_flush
      can: tcan4x5x: add option for selecting nWKRQ voltage

Sheng Yong (1):
      dm-bufio: fix sched in atomic context

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W640

Stefan Metzmacher (1):
      smb: client: let smbd_post_send_iter() respect the peers max_send_size and transmit all data

Stefan Wahren (1):
      Revert "staging: vchiq_arm: Create keep-alive thread during probe"

Steffen Bätz (1):
      nvmem: imx-ocotp: fix MAC address byte length

Steven Rostedt (1):
      tracing: Add down_write(trace_event_sem) when adding trace event

Takashi Iwai (1):
      ALSA: hda/realtek: Add quirk for ASUS ROG Strix G712LWS

Thomas Fourier (2):
      pch_uart: Fix dma_sync_sg_for_device() nents value
      mmc: bcm2835: Fix dma_unmap_sg() nents value

Tim Harvey (4):
      arm64: dts: imx8mp-venice-gw74xx: fix TPM SPI frequency
      arm64: dts: imx8mp-venice-gw71xx: fix TPM SPI frequency
      arm64: dts: imx8mp-venice-gw72xx: fix TPM SPI frequency
      arm64: dts: imx8mp-venice-gw73xx: fix TPM SPI frequency

Tomas Glozar (1):
      tracing/osnoise: Fix crash in timerlat_dump_stack()

Vijendar Mukunda (2):
      soundwire: amd: fix for handling slave alerts after link is down
      soundwire: amd: fix for clearing command status register

Wang Zhaolong (2):
      smb: client: fix use-after-free in crypt_message when using async crypto
      smb: client: fix use-after-free in cifs_oplock_break

Wayne Chang (2):
      phy: tegra: xusb: Fix unbalanced regulator disable in UTMI PHY mode
      phy: tegra: xusb: Decouple CYA_TRK_CODE_UPDATE_ON_IDLE from trk_hw_mode

William Liu (1):
      net/sched: Return NULL when htb_lookup_leaf encounters an empty rbtree

Xiang Mei (1):
      net/sched: sch_qfq: Fix race condition on qfq_aggregate

Xinyu Liu (1):
      usb: gadget: configfs: Fix OOB read on empty string write

Yu Kuai (1):
      nvme: fix misaccounting of nvme-mpath inflight I/O

Yue Haibing (1):
      ipv6: mcast: Delay put pmc->idev in mld_del_delrec()

Yun Lu (2):
      af_packet: fix the SO_SNDTIMEO constraint not effective on tpacked_snd()
      af_packet: fix soft lockup issue caused by tpacket_snd()

Zheng Qixing (1):
      nvme: fix inconsistent RCU list manipulation in nvme_ns_add_to_ctrl_list()

Zigit Zo (1):
      virtio-net: fix recursived rtnl_lock() during probe()

Zijun Hu (1):
      Bluetooth: btusb: QCA: Fix downloading wrong NVM for WCN6855 GF variant without board ID

Zizhi Wo (1):
      cachefiles: Fix the incorrect return value in __cachefiles_write()


