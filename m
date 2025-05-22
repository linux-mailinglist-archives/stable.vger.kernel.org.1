Return-Path: <stable+bounces-146090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13B9AC0C60
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 15:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9332F165957
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A112428C030;
	Thu, 22 May 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VP8iityF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B60128C010;
	Thu, 22 May 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747919525; cv=none; b=pkj0XqF7dWFP7rH4uaMAIRUfF5JIJHPwajcwf3qHOduuE/DYMFZ9eallzq/SNZ4GWwiu2co1HXXRRmjoFVgLXlk2jyYp+/kQPWrkTWULY+zPyR4ENZBix+26h6WHKsfFElkAbP2CzEx8mISq5Yz7I8QaPw6GEhJ0daIcFONrG1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747919525; c=relaxed/simple;
	bh=wJ8F85/QY4+qkfWnH1fVPlWh7BJa/U8fJOr5dRN71Us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=It1bnSYJjTsrch+j5kqIK+R3f0LDASEDK20yGoaF/Ic/pDG1jepac9k5VuOGiyzgdLaEr90wFARRZ01Bdmh6mWwKZF6q/VrUm8NpW9QYzvDC6O1LB94H0wLIz6NbCxznpM1Zb6PnOCZ0JoTlaFIGDkH0eXuUXea7BJolxqXWOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VP8iityF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCED7C4CEED;
	Thu, 22 May 2025 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747919525;
	bh=wJ8F85/QY4+qkfWnH1fVPlWh7BJa/U8fJOr5dRN71Us=;
	h=From:To:Cc:Subject:Date:From;
	b=VP8iityFrDPm+X3JgZpbsifOls3L2zf8t7BmDlR5JQ+68z0n5Y/PgIOxcsR300hYx
	 sneIQe9Cjnqg2R2fW8snntdg6FcrhRljspGAX0f0middlyil6gRdiQl9yH2gezBOqU
	 Ye7oWnZG7zvi/QSmdw7UTpq9igZVJYEJ5SaLG16A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.30
Date: Thu, 22 May 2025 15:11:46 +0200
Message-ID: <2025052246-dork-egotistic-7d01@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.30 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/netlink/specs/tc.yaml                          |   10 
 MAINTAINERS                                                  |    6 
 Makefile                                                     |    2 
 arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi         |    4 
 arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi            |   12 
 arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi |    4 
 arch/arm64/boot/dts/rockchip/rk3588j.dtsi                    |   53 -
 arch/loongarch/include/asm/ptrace.h                          |    2 
 arch/loongarch/include/asm/uprobes.h                         |    1 
 arch/loongarch/kernel/genex.S                                |    7 
 arch/loongarch/kernel/kfpu.c                                 |   22 
 arch/loongarch/kernel/time.c                                 |    2 
 arch/loongarch/kernel/uprobes.c                              |   11 
 arch/loongarch/power/hibernate.c                             |    3 
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi                       |    2 
 arch/x86/kvm/mmu/mmu.c                                       |   75 +-
 block/bio.c                                                  |    2 
 drivers/accel/ivpu/ivpu_debugfs.c                            |    2 
 drivers/accel/ivpu/ivpu_fw.c                                 |    4 
 drivers/accel/ivpu/ivpu_fw_log.c                             |  113 ++-
 drivers/accel/ivpu/ivpu_fw_log.h                             |    9 
 drivers/accel/ivpu/ivpu_pm.c                                 |    1 
 drivers/acpi/pptt.c                                          |   11 
 drivers/bluetooth/btnxpuart.c                                |    6 
 drivers/char/tpm/tpm2-sessions.c                             |   20 
 drivers/char/tpm/tpm_tis_core.h                              |    2 
 drivers/dma-buf/dma-resv.c                                   |    5 
 drivers/dma/dmatest.c                                        |    6 
 drivers/dma/idxd/init.c                                      |  159 +++-
 drivers/dma/ti/k3-udma.c                                     |   10 
 drivers/gpio/gpio-pca953x.c                                  |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                          |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c                     |   18 
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                   |   47 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                      |   11 
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c                       |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c            |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  |   16 
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c    |    5 
 drivers/gpu/drm/drm_fbdev_dma.c                              |   60 +
 drivers/gpu/drm/tiny/Kconfig                                 |    1 
 drivers/gpu/drm/tiny/panel-mipi-dbi.c                        |    7 
 drivers/gpu/drm/xe/instructions/xe_mi_commands.h             |    4 
 drivers/gpu/drm/xe/xe_gsc.c                                  |   22 
 drivers/gpu/drm/xe/xe_gsc.h                                  |    1 
 drivers/gpu/drm/xe/xe_gsc_proxy.c                            |   11 
 drivers/gpu/drm/xe/xe_gsc_proxy.h                            |    1 
 drivers/gpu/drm/xe/xe_gt.c                                   |    2 
 drivers/gpu/drm/xe/xe_lrc.c                                  |    2 
 drivers/gpu/drm/xe/xe_ring_ops.c                             |    7 
 drivers/gpu/drm/xe/xe_uc.c                                   |    8 
 drivers/gpu/drm/xe/xe_uc.h                                   |    1 
 drivers/hid/bpf/hid_bpf_dispatch.c                           |    9 
 drivers/hid/hid-thrustmaster.c                               |    1 
 drivers/hid/hid-uclogic-core.c                               |    7 
 drivers/hv/channel.c                                         |   65 -
 drivers/hv/hyperv_vmbus.h                                    |    6 
 drivers/hv/vmbus_drv.c                                       |  100 ++
 drivers/iio/adc/ad7266.c                                     |    2 
 drivers/iio/adc/ad7768-1.c                                   |    2 
 drivers/iio/chemical/pms7003.c                               |    5 
 drivers/iio/chemical/sps30.c                                 |    2 
 drivers/iio/light/opt3001.c                                  |    5 
 drivers/iio/pressure/mprls0025pa.h                           |   17 
 drivers/infiniband/core/device.c                             |    6 
 drivers/infiniband/sw/rxe/rxe_cq.c                           |    5 
 drivers/net/dsa/b53/b53_common.c                             |   33 
 drivers/net/dsa/b53/b53_regs.h                               |   14 
 drivers/net/dsa/sja1105/sja1105_main.c                       |    6 
 drivers/net/ethernet/cadence/macb_main.c                     |   19 
 drivers/net/ethernet/engleder/tsnep_main.c                   |   30 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c              |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c    |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h     |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c    |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c      |    3 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                  |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c            |    4 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c        |    3 
 drivers/net/ethernet/qlogic/qede/qede_main.c                 |    2 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c     |    7 
 drivers/net/hyperv/hyperv_net.h                              |   13 
 drivers/net/hyperv/netvsc.c                                  |   57 +
 drivers/net/hyperv/netvsc_drv.c                              |   62 -
 drivers/net/hyperv/rndis_filter.c                            |   24 
 drivers/net/virtio_net.c                                     |    5 
 drivers/net/wireless/mediatek/mt76/dma.c                     |    1 
 drivers/nvme/host/pci.c                                      |    4 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                     |   40 -
 drivers/phy/tegra/xusb-tegra186.c                            |   46 -
 drivers/phy/tegra/xusb.c                                     |    8 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                    |    7 
 drivers/platform/x86/amd/pmf/tee-if.c                        |   23 
 drivers/platform/x86/asus-wmi.c                              |    3 
 drivers/regulator/max20086-regulator.c                       |    7 
 drivers/scsi/sd_zbc.c                                        |    6 
 drivers/scsi/storvsc_drv.c                                   |    1 
 drivers/spi/spi-loopback-test.c                              |    2 
 drivers/spi/spi-tegra114.c                                   |    6 
 drivers/uio/uio_hv_generic.c                                 |   39 -
 drivers/usb/gadget/function/f_midi2.c                        |    2 
 drivers/usb/host/xhci-dbgcap.c                               |   21 
 drivers/usb/host/xhci-dbgcap.h                               |    3 
 drivers/usb/typec/ucsi/displayport.c                         |   19 
 drivers/usb/typec/ucsi/ucsi.c                                |   34 
 drivers/usb/typec/ucsi/ucsi.h                                |    2 
 drivers/virtio/virtio_ring.c                                 |    6 
 fs/binfmt_elf.c                                              |   71 +
 fs/btrfs/discard.c                                           |   17 
 fs/btrfs/fs.h                                                |    1 
 fs/btrfs/inode.c                                             |    7 
 fs/btrfs/super.c                                             |    4 
 fs/nfs/nfs4proc.c                                            |    9 
 fs/nfs/pnfs.c                                                |    9 
 fs/smb/client/cifs_spnego.c                                  |   16 
 fs/smb/client/cifsfs.c                                       |   25 
 fs/smb/client/cifsglob.h                                     |    7 
 fs/smb/client/connect.c                                      |   20 
 fs/smb/client/fs_context.c                                   |   39 +
 fs/smb/client/fs_context.h                                   |   10 
 fs/smb/client/smb2pdu.c                                      |    2 
 fs/udf/truncate.c                                            |    2 
 fs/xattr.c                                                   |   24 
 include/drm/drm_fbdev_dma.h                                  |   12 
 include/linux/bio.h                                          |    1 
 include/linux/hyperv.h                                       |   13 
 include/linux/kvm_host.h                                     |    6 
 include/linux/tpm.h                                          |   21 
 include/linux/virtio.h                                       |    3 
 include/net/sch_generic.h                                    |   15 
 include/sound/ump_msg.h                                      |    4 
 kernel/cgroup/cpuset.c                                       |    6 
 kernel/sched/ext.c                                           |    6 
 kernel/trace/ring_buffer.c                                   |    8 
 kernel/trace/trace_dynevent.c                                |   16 
 kernel/trace/trace_dynevent.h                                |    1 
 kernel/trace/trace_events_trigger.c                          |    2 
 kernel/trace/trace_functions.c                               |    6 
 kernel/trace/trace_kprobe.c                                  |    2 
 kernel/trace/trace_probe.c                                   |    9 
 kernel/trace/trace_uprobe.c                                  |    2 
 mm/page_alloc.c                                              |   23 
 mm/userfaultfd.c                                             |   12 
 net/bluetooth/mgmt.c                                         |    9 
 net/mac80211/main.c                                          |    6 
 net/mctp/device.c                                            |   65 -
 net/mctp/route.c                                             |    4 
 net/sched/sch_codel.c                                        |    2 
 net/sched/sch_fq.c                                           |    2 
 net/sched/sch_fq_codel.c                                     |    2 
 net/sched/sch_fq_pie.c                                       |    2 
 net/sched/sch_hhf.c                                          |    2 
 net/sched/sch_pie.c                                          |    2 
 net/tls/tls_strp.c                                           |    3 
 samples/ftrace/sample-trace-array.c                          |    2 
 scripts/Makefile.extrawarn                                   |   12 
 sound/core/seq/seq_clientmgr.c                               |   52 -
 sound/core/seq/seq_ump_convert.c                             |   18 
 sound/core/seq/seq_ump_convert.h                             |    1 
 sound/pci/es1968.c                                           |    6 
 sound/sh/Kconfig                                             |    2 
 sound/usb/quirks.c                                           |    4 
 tools/net/ynl/ethtool.py                                     |   22 
 tools/testing/selftests/net/ncdevmem.c                       |  394 ++++++-----
 tools/testing/vsock/vsock_test.c                             |   28 
 virt/kvm/guest_memfd.c                                       |    2 
 virt/kvm/kvm_main.c                                          |   14 
 168 files changed, 1803 insertions(+), 906 deletions(-)

Aaron Kling (1):
      spi: tegra114: Use value to check for invalid delays

Abdun Nihaal (1):
      qlcnic: fix memory leak in qlcnic_sriov_channel_cfg_cmd()

Alex Deucher (2):
      Revert "drm/amd: Stop evicting resources on APUs in suspend"
      drm/amdgpu: fix pm notifier handling

Alexey Makhalov (1):
      MAINTAINERS: Update Alexey Makhalov's email address

Andrei Kuchynski (1):
      usb: typec: ucsi: displayport: Fix deadlock

Andrew Jeffery (1):
      net: mctp: Ensure keys maintain only one ref to corresponding dev

Barry Song (1):
      mm: userfaultfd: correct dirty flags set for both present and swap pte

Bo-Cun Chen (1):
      net: ethernet: mtk_eth_soc: fix typo for declaration MT7988 ESW capability

Boris Burkov (1):
      btrfs: fix folio leak in submit_one_async_extent()

Carolina Jubran (1):
      net/mlx5e: Disable MACsec offload for uplink representor profile

Christian Heusel (1):
      ALSA: usb-audio: Add sample rate quirk for Audioengine D1

Christian Hewitt (1):
      arm64: dts: amlogic: dreambox: fix missing clkc_audio node

Claudiu Beznea (2):
      phy: renesas: rcar-gen3-usb2: Fix role detection on unbind/bind
      phy: renesas: rcar-gen3-usb2: Set timing registers only once

Cong Wang (1):
      net_sched: Flush gso_skb list too during ->change()

Cosmin Ratiu (1):
      tests/ncdevmem: Fix double-free of queue array

Cosmin Tanislav (1):
      regulator: max20086: fix invalid memory access

Dan Carpenter (1):
      phy: tegra: xusb: remove a stray unlock

Daniele Ceraolo Spurio (1):
      drm/xe/gsc: do not flush the GSC worker from the reset path

David Lechner (3):
      iio: chemical: pms7003: use aligned_s64 for timestamp
      iio: pressure: mprls0025pa: use aligned_s64 for timestamp
      iio: chemical: sps30: use aligned_s64 for timestamp

Dragan Simic (1):
      arm64: dts: rockchip: Remove overdrive-mode OPPs from RK3588J SoC dtsi

Emanuele Ghidoli (1):
      gpio: pca953x: fix IRQ storm on system wake up

Eric Dumazet (1):
      mctp: no longer rely on net->dev_index_head[]

Fabio Estevam (1):
      drm/tiny: panel-mipi-dbi: Use drm_client_setup_with_fourcc()

Fedor Pchelkin (1):
      wifi: mt76: disable napi on driver removal

Filipe Manana (1):
      btrfs: fix discard worker infinite loop after disabling discard

Geert Uytterhoeven (2):
      spi: loopback-test: Do not split 1024-byte hexdumps
      ALSA: sh: SND_AICA should depend on SH_DMA_API

Gerhard Engleder (1):
      tsnep: fix timestamping with a stacked DSA driver

Greg Kroah-Hartman (1):
      Linux 6.12.30

Hangbin Liu (1):
      tools/net/ynl: ethtool: fix crash when Hardware Clock info is missing

Hans de Goede (1):
      platform/x86: asus-wmi: Fix wlan_ctrl_by_user detection

Hariprasad Kelam (1):
      octeontx2-af: Fix CGX Receive counters

Henry Martin (1):
      HID: uclogic: Add NULL check in uclogic_input_configured()

Himanshu Bhavani (1):
      arm64: dts: imx8mp-var-som: Fix LDO5 shutdown causing SD card timeout

Huacai Chen (3):
      LoongArch: Move __arch_cpu_idle() to .cpuidle.text section
      LoongArch: Save and restore CSR.CNTC for hibernation
      LoongArch: Fix MAX_REG_OFFSET calculation

Hyejeong Choi (1):
      dma-buf: insert memory barrier before updating num_fences

Ido Schimmel (1):
      mlxsw: spectrum_router: Fix use-after-free when deleting GRE net devices

Isaku Yamahata (1):
      KVM: Add member to struct kvm_gfn_range to indicate private/shared

Jacek Lawrynowicz (3):
      accel/ivpu: Rename ivpu_log_level to fw_log_level
      accel/ivpu: Refactor functions in ivpu_fw_log.c
      accel/ivpu: Fix fw log printing

Jakub Kicinski (2):
      netlink: specs: tc: fix a couple of attribute names
      netlink: specs: tc: all actions are indexed arrays

Jan Kara (1):
      udf: Make sure i_lenExtents is uptodate on inode eviction

Jarkko Sakkinen (1):
      tpm: Mask TPM RC in tpm2_start_auth_session()

Jeremy Linton (1):
      ACPI: PPTT: Fix processor subtable walk

Jethro Donaldson (1):
      smb: client: fix memory leak during error handling for POSIX mkdir

Jonas Gorski (1):
      net: dsa: b53: prevent standalone from trying to forward to other ports

Jonathan Cameron (2):
      iio: adc: ad7266: Fix potential timestamp alignment issue.
      iio: adc: ad7768-1: Fix insufficient alignment of timestamp.

Kees Cook (3):
      binfmt_elf: Move brk for static PIE even if ASLR disabled
      nvme-pci: make nvme_pci_npages_prp() __always_inline
      wifi: mac80211: Set n_channels after allocating struct cfg80211_scan_request

Keith Busch (1):
      nvme-pci: acquire cq_poll_lock in nvme_poll_irqdisable

Kirill A. Shutemov (1):
      mm/page_alloc: fix race condition in unaccepted memory handling

Koichiro Den (2):
      virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()
      virtio_net: ensure netdev_tx_reset_queue is called on bind xsk for tx

Konstantin Shkolnyy (1):
      vsock/test: Fix occasional failure in SIOCOUTQ tests

Kyoji Ogasawara (1):
      btrfs: add back warning for mount option commit values exceeding 300

Li Lingfeng (1):
      nfs: handle failure of nfs_get_lock_context in unlock path

Luca Ceresoli (1):
      iio: light: opt3001: fix deadlock due to concurrent flag access

Luiz Augusto von Dentz (1):
      Bluetooth: MGMT: Fix MGMT_OP_ADD_DEVICE invalid device flags

Ma Ke (1):
      phy: Fix error handling in tegra_xusb_port_init

Mario Limonciello (3):
      drivers/platform/x86/amd: pmf: Check for invalid sideloaded Smart PC Policies
      drivers/platform/x86/amd: pmf: Check for invalid Smart PC Policies
      drm/amd: Add Suspend/Hibernate notification callback support

Masami Hiramatsu (Google) (1):
      tracing: probes: Fix a possible race in trace_probe_log APIs

Mathias Nyman (2):
      xhci: dbc: Improve performance by removing delay in transfer event polling.
      xhci: dbc: Avoid event polling busyloop if pending rx transfers are inactive.

Mathieu Othacehe (1):
      net: cadence: macb: Fix a possible deadlock in macb_halt_tx.

Matt Johnston (1):
      net: mctp: Don't access ifa_index when missing

Melissa Wen (1):
      Revert "drm/amd/display: Hardware cursor changes color when switched to software cursor"

Michael Kelley (5):
      hv_netvsc: Use vmbus_sendpacket_mpb_desc() to send VMBus messages
      hv_netvsc: Preserve contiguous PFN grouping in the page buffer array
      hv_netvsc: Remove rmsg_pgcnt
      Drivers: hv: Allow vmbus_sendpacket_mpb_desc() to create multiple ranges
      Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()

Michal Suchanek (1):
      tpm: tis: Double the timeout B to 4s

Naman Jain (1):
      uio_hv_generic: Fix sysfs creation path for ring buffer

Nathan Chancellor (2):
      kbuild: Disable -Wdefault-const-init-unsafe
      net: qede: Initialize qede_ll_ops with designated initializer

Nathan Lynch (1):
      dmaengine: Revert "dmaengine: dmatest: Fix dmatest waiting less when interrupted"

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix kernel panic during FW release

Nicolas Chauvet (1):
      ALSA: usb-audio: Add sample rate quirk for Microdia JP001 USB Camera

Pengtao He (1):
      net/tls: fix kernel panic when alloc_page failed

Philip Yang (1):
      drm/amdgpu: csa unmap use uninterruptible lock

Qasim Ijaz (1):
      HID: thrustmaster: fix memory leak in thrustmaster_interrupts()

Ritvik Budhiraja (1):
      CIFS: New mount option for cifs.upcall namespace resolution

Ronald Wahl (1):
      dmaengine: ti: k3-udma: Add missing locking

Rong Zhang (1):
      HID: bpf: abort dispatch if device destroyed

Runhua He (1):
      platform/x86/amd/pmc: Declare quirk_spurious_8042 for MECHREVO Wujie 14XA (GX4HRXL)

Sean Christopherson (1):
      KVM: x86/mmu: Prevent installing hugepages when mem attributes are changing

Shuai Xue (9):
      dmaengine: idxd: fix memory leak in error handling path of idxd_setup_wqs
      dmaengine: idxd: fix memory leak in error handling path of idxd_setup_engines
      dmaengine: idxd: fix memory leak in error handling path of idxd_setup_groups
      dmaengine: idxd: Add missing cleanup for early error out in idxd_setup_internals
      dmaengine: idxd: Add missing cleanups in cleanup internals
      dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call
      dmaengine: idxd: fix memory leak in error handling path of idxd_alloc
      dmaengine: idxd: fix memory leak in error handling path of idxd_pci_probe
      dmaengine: idxd: Refactor remove call with idxd_cleanup() helper

Stanislav Fomichev (5):
      selftests: ncdevmem: Redirect all non-payload output to stderr
      selftests: ncdevmem: Separate out dmabuf provider
      selftests: ncdevmem: Unify error handling
      selftests: ncdevmem: Make client_ip optional
      selftests: ncdevmem: Switch to AF_INET6

Stephen Smalley (1):
      fs/xattr.c: fix simple_xattr_list to always include security.* xattrs

Steve Siwinski (1):
      scsi: sd_zbc: block: Respect bio vector limits for REPORT ZONES buffer

Steven Rostedt (2):
      tracing: samples: Initialize trace_array_printk() with the correct function
      ring-buffer: Fix persistent buffer when commit page is the reader page

Subbaraya Sundeep (2):
      octeontx2-pf: macsec: Fix incorrect max transmit size in TX secy
      octeontx2-pf: Do not reallocate all ntuple filters

Takashi Iwai (2):
      ALSA: seq: Fix delivery of UMP events to group ports
      ALSA: ump: Fix a typo of snd_ump_stream_msg_device_info

Tejun Heo (1):
      sched_ext: bpf_iter_scx_dsq_new() should always initialize iterator

Thomas Zimmermann (2):
      drm/fbdev-dma: Support struct drm_driver.fbdev_probe
      drm/panel-mipi-dbi: Run DRM default client setup

Tianyang Zhang (1):
      LoongArch: Prevent cond_resched() occurring within kernel-fpu

Tiezhu Yang (2):
      LoongArch: uprobes: Remove user_{en,dis}able_single_step()
      LoongArch: uprobes: Remove redundant code about resume_era

Tim Huang (1):
      drm/amdgpu: fix incorrect MALL size for GFX1151

Tom Vincent (1):
      arm64: dts: rockchip: Assign RT5616 MCLK rate on rk3588-friendlyelec-cm3588

Tomasz Rusinowicz (1):
      accel/ivpu: Reset fw log on cold boot

Trond Myklebust (1):
      NFSv4/pnfs: Reset the layout state after a layoutreturn

Umesh Nerlige Ramappa (1):
      drm/xe: Save CTX_TIMESTAMP mmio value instead of LRC value

Vladimir Oltean (1):
      net: dsa: sja1105: discard incoming frames in BR_STATE_LISTENING

Waiman Long (1):
      cgroup/cpuset: Extend kthread_is_per_cpu() check to all PF_NO_SETAFFINITY tasks

Wayne Chang (1):
      phy: tegra: xusb: Use a bitmask for UTMI pad power state tracking

Wayne Lin (2):
      drm/amd/display: Correct the reply value when AUX write incomplete
      drm/amd/display: Avoid flooding unnecessary info messages

Wentao Liang (1):
      ALSA: es1968: Add error handling for snd_pcm_hw_constraint_pow2()

Yemike Abhilash Chandra (1):
      dmaengine: ti: k3-udma: Use cap_mask directly from dma_device structure instead of a local copy

Ze Huang (1):
      riscv: dts: sophgo: fix DMA data-width configuration for CV18xx

Zhu Yanjun (2):
      RDMA/rxe: Fix slab-use-after-free Read in rxe_queue_cleanup bug
      RDMA/core: Fix "KASAN: slab-use-after-free Read in ib_register_device" problem

pengdonglin (2):
      ftrace: Fix preemption accounting for stacktrace trigger command
      ftrace: Fix preemption accounting for stacktrace filter command


