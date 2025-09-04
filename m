Return-Path: <stable+bounces-177755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A49B4401C
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 17:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F0D7B4EB9
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14663164A6;
	Thu,  4 Sep 2025 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="004yGREE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD9F30CD87;
	Thu,  4 Sep 2025 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998667; cv=none; b=FnX4OszghBg3bOCbU+72k96+tJgnQ7+1/2t/CeSQjwnfDel+YM+upM4iROAhYWZCJ6RtYNyLfi8+DupW0C2v6/H9c03HlDoxTAxcm0I44RjVQbihVmxb92rT19jHsvpdcmmBByjWANVGOsQBzci2t4QKyslNw1ndnJQtLmL5BPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998667; c=relaxed/simple;
	bh=AySmvidr7iqZHhMRzYQi9YWE18nPJ/YOOHLHZ/sWov4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BvIVX7Y3/On8Hp+xlnvk1YYca8InH66xh8cwJaIkB05oZFFLOCQ2s02s1uzw7w+qLkhQT8LA8VCfyWfuH/A1LRKUtYFpJM66FVwQjl60WVUes/27AFeEh95jdefb/X4VSl9cXjXiC6w4+BW19aIuZF7nQeid8x7CDVGWp0hvjhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=004yGREE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97083C4CEF0;
	Thu,  4 Sep 2025 15:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756998667;
	bh=AySmvidr7iqZHhMRzYQi9YWE18nPJ/YOOHLHZ/sWov4=;
	h=From:To:Cc:Subject:Date:From;
	b=004yGREEgt1KcI6ZFhGj2h7H/bYyWDiq0mIxZkSvFgaw9HQxaLZR/Qf11LDCPlpw5
	 ZCn25XNue7oVbQ80+CvXlJTFJIP6bZ9TdL667Y0EtMDsxO+LUeLZVnXtA0nPaRxF7f
	 rETPxKI3/9KJSm+HEtyEszXJX5Iq22lTnjlKauIM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.45
Date: Thu,  4 Sep 2025 17:10:49 +0200
Message-ID: <2025090450-fabulous-sinner-9790@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.45 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml |    1 
 Makefile                                                     |    2 
 arch/mips/boot/dts/lantiq/danube_easy50712.dts               |    5 
 arch/mips/lantiq/xway/sysctrl.c                              |   10 
 arch/powerpc/kernel/kvm.c                                    |    8 
 arch/riscv/kvm/vcpu_vector.c                                 |    2 
 arch/x86/kernel/cpu/microcode/amd.c                          |   22 +-
 arch/x86/kernel/cpu/topology_amd.c                           |   23 +-
 arch/x86/kvm/lapic.c                                         |    2 
 arch/x86/kvm/x86.c                                           |    7 
 block/blk-zoned.c                                            |   11 -
 drivers/acpi/ec.c                                            |    6 
 drivers/atm/atmtcp.c                                         |   17 +
 drivers/firmware/efi/stmm/tee_stmm_efi.c                     |   21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c                      |    4 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                           |   18 -
 drivers/gpu/drm/display/drm_dp_helper.c                      |    2 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                       |   21 +-
 drivers/gpu/drm/mediatek/mtk_plane.c                         |    3 
 drivers/gpu/drm/msm/msm_gem_submit.c                         |   14 -
 drivers/gpu/drm/msm/msm_kms.c                                |   10 
 drivers/gpu/drm/msm/registers/display/dsi.xml                |   28 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c                      |    4 
 drivers/gpu/drm/nouveau/nvkm/falcon/gm200.c                  |   15 -
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c              |    5 
 drivers/gpu/drm/xe/xe_bo.c                                   |    3 
 drivers/gpu/drm/xe/xe_sync.c                                 |    2 
 drivers/gpu/drm/xe/xe_vm.c                                   |    8 
 drivers/hid/hid-asus.c                                       |    8 
 drivers/hid/hid-ids.h                                        |    3 
 drivers/hid/hid-input-test.c                                 |   10 
 drivers/hid/hid-input.c                                      |   51 ++--
 drivers/hid/hid-logitech-dj.c                                |    4 
 drivers/hid/hid-logitech-hidpp.c                             |    2 
 drivers/hid/hid-multitouch.c                                 |    8 
 drivers/hid/hid-ntrig.c                                      |    3 
 drivers/hid/hid-quirks.c                                     |    2 
 drivers/hid/wacom_wac.c                                      |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                    |   36 ++-
 drivers/net/ethernet/cadence/macb_main.c                     |    9 
 drivers/net/ethernet/dlink/dl2k.c                            |    2 
 drivers/net/ethernet/intel/ice/ice_adapter.c                 |   49 +++-
 drivers/net/ethernet/intel/ice/ice_adapter.h                 |    4 
 drivers/net/ethernet/intel/ice/ice_ddp.c                     |   44 +++-
 drivers/net/ethernet/intel/ice/ice_main.c                    |   16 +
 drivers/net/ethernet/intel/ice/ice_txrx.c                    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c     |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h     |   12 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c            |   19 +
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c           |  114 ++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h           |    1 
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c         |   10 
 drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h              |    6 
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c               |    4 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c                  |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c          |   13 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c           |    9 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c            |    6 
 drivers/net/hyperv/netvsc.c                                  |   18 +
 drivers/net/hyperv/rndis_filter.c                            |   20 +
 drivers/net/phy/mscc/mscc.h                                  |    4 
 drivers/net/phy/mscc/mscc_main.c                             |    4 
 drivers/net/phy/mscc/mscc_ptp.c                              |   34 ++-
 drivers/net/usb/qmi_wwan.c                                   |    3 
 drivers/of/dynamic.c                                         |    9 
 drivers/of/of_reserved_mem.c                                 |   16 +
 drivers/pci/controller/dwc/pcie-designware.c                 |    8 
 drivers/pci/controller/plda/pcie-starfive.c                  |    2 
 drivers/pci/pci.h                                            |    2 
 drivers/pinctrl/Kconfig                                      |    1 
 drivers/scsi/scsi_sysfs.c                                    |    4 
 drivers/thermal/mediatek/lvts_thermal.c                      |   74 +++++--
 drivers/vhost/net.c                                          |    9 
 fs/efivarfs/super.c                                          |    4 
 fs/erofs/zdata.c                                             |   13 +
 fs/smb/client/cifsfs.c                                       |   14 +
 fs/smb/client/inode.c                                        |   34 +++
 fs/smb/client/smb2inode.c                                    |    7 
 fs/xfs/libxfs/xfs_attr_remote.c                              |    7 
 fs/xfs/libxfs/xfs_da_btree.c                                 |    6 
 include/linux/atmdev.h                                       |    1 
 include/linux/dma-map-ops.h                                  |    3 
 include/net/bluetooth/hci_sync.h                             |    2 
 include/net/rose.h                                           |   18 +
 include/uapi/linux/vhost.h                                   |    4 
 kernel/dma/contiguous.c                                      |    2 
 kernel/dma/pool.c                                            |    4 
 kernel/trace/fgraph.c                                        |    1 
 kernel/trace/trace.c                                         |    4 
 net/atm/common.c                                             |   15 +
 net/bluetooth/hci_event.c                                    |   20 +
 net/bluetooth/hci_sync.c                                     |    6 
 net/bluetooth/mgmt.c                                         |    5 
 net/ipv4/route.c                                             |   10 
 net/l2tp/l2tp_ppp.c                                          |   25 --
 net/rose/af_rose.c                                           |   13 -
 net/rose/rose_in.c                                           |   12 -
 net/rose/rose_route.c                                        |   62 +++--
 net/rose/rose_timer.c                                        |    2 
 net/sctp/ipv6.c                                              |    2 
 sound/soc/codecs/lpass-tx-macro.c                            |    2 
 tools/perf/util/symbol-minimal.c                             |   55 ++---
 tools/tracing/latency/Makefile.config                        |    8 
 tools/tracing/rtla/Makefile.config                           |    8 
 105 files changed, 907 insertions(+), 399 deletions(-)

Aleksander Jan Bajkowski (2):
      mips: dts: lantiq: danube: add missing burst length property
      mips: lantiq: xway: sysctrl: rename the etop node

Alex Deucher (1):
      Revert "drm/amdgpu: fix incorrect vm flags to map bo"

Alexander Duyck (1):
      fbnic: Move phylink resume out of service_task and into open/close

Alexei Lazar (3):
      net/mlx5e: Update and set Xon/Xoff upon MTU set
      net/mlx5e: Update and set Xon/Xoff upon port speed set
      net/mlx5e: Set local Xoff after FW update

Alexey Klimov (1):
      ASoC: codecs: tx-macro: correct tx_macro_component_drv name

Antheas Kapenekakis (1):
      HID: quirks: add support for Legion Go dual dinput modes

Ayushi Makhija (1):
      drm/msm: update the high bitfield of certain DSI registers

Bart Van Assche (1):
      blk-zoned: Fix a lockdep complaint about recursive locking

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Handle the case of no BIOS microcode

Damien Le Moal (1):
      scsi: core: sysfs: Correct sysfs attributes access rights

Dan Carpenter (1):
      of: dynamic: Fix use after free in of_changeset_add_prop_helper()

Dipayaan Roy (1):
      net: hv_netvsc: fix loss of early receive events from host during channel open.

Dmitry Baryshkov (2):
      drm/msm/kms: move snapshot init earlier in KMS init
      dt-bindings: display/msm: qcom,mdp5: drop lut clock

Eric Dumazet (3):
      sctp: initialize more fields in sctp_v6_from_sk()
      l2tp: do not use sock_hold() in pppol2tp_session_get_sock()
      net: rose: fix a typo in rose_clear_routes()

Eric Sandeen (1):
      xfs: do not propagate ENODATA disk errors into xattr code

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion LE910C4-WWX new compositions

Greg Kroah-Hartman (1):
      Linux 6.12.45

Horatiu Vultur (1):
      phy: mscc: Fix when PTP clock is register and unregister

Ian Rogers (1):
      perf symbol-minimal: Fix ehdr reading in filename__read_build_id

Imre Deak (1):
      Revert "drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS"

Jacob Keller (2):
      ice: don't leave device non-functional if Tx scheduler config fails
      ice: use fixed adapter index for E825C embedded devices

James Jones (1):
      drm/nouveau/disp: Always accept linear modifier

Jan Kiszka (1):
      efi: stmm: Fix incorrect buffer allocation method

Jason-JH Lin (1):
      drm/mediatek: Add error handling for old state CRTC in atomic_disable

Joe Damato (1):
      hv_netvsc: Link queues to NAPIs

José Expósito (2):
      HID: input: rename hidinput_set_battery_charge_status()
      HID: input: report battery status changes immediately

Junli Liu (1):
      erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC

K Prateek Nayak (1):
      x86/cpu/topology: Use initial APIC ID from XTOPOLOGY leaf on AMD/HYGON

Kuniyuki Iwashima (1):
      atm: atmtcp: Prevent arbitrary write in atmtcp_recv_control().

Li Nan (1):
      efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare

Lizhi Hou (1):
      of: dynamic: Fix memleak when of_pci_add_properties() failed

Ludovico de Nittis (2):
      Bluetooth: hci_event: Treat UNKNOWN_CONN_ID on disconnect as success
      Bluetooth: hci_event: Mark connection as closed during suspend disconnect

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Detect if HCI_EV_NUM_COMP_PKTS is unbalanced

Ma Ke (1):
      drm/mediatek: Fix device/node reference count leaks in mtk_drm_get_all_drm_priv

Madhavan Srinivasan (1):
      powerpc/kvm: Fix ifdef to remove build warning

Mason Chang (3):
      thermal/drivers/mediatek/lvts_thermal: Change lvts commands array to static const
      thermal/drivers/mediatek/lvts_thermal: Add lvts commands and their sizes to driver data
      thermal/drivers/mediatek/lvts_thermal: Add mt7988 lvts commands

Matt Coffin (1):
      HID: logitech: Add ids for G PRO 2 LIGHTSPEED

Matthew Brost (1):
      drm/xe: Don't trigger rebind on initial dma-buf validation

Michael Chan (2):
      bnxt_en: Adjust TX rings if reservation is less than requested
      bnxt_en: Fix stats context reservation logic

Michal Kubiak (1):
      ice: fix incorrect counter for buffer allocation failures

Minjong Kim (1):
      HID: hid-ntrig: fix unable to handle page fault in ntrig_report_version()

Moshe Shemesh (3):
      net/mlx5: Reload auxiliary drivers on fw_activate
      net/mlx5: Fix lockdep assertion on sync reset unload event
      net/mlx5: Nack sync reset when SFs are present

Namhyung Kim (1):
      vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER

Neil Mandir (1):
      net: macb: Disable clocks once

Niklas Cassel (2):
      PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS
      PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link up

Nikolay Kuratov (1):
      vhost/net: Protect ubufs with rcu read lock in vhost_net_ubuf_put()

Oreoluwa Babatunde (1):
      of: reserved_mem: Restructure call site for dma_contiguous_early_fixup()

Oscar Maes (1):
      net: ipv4: fix regression in local-broadcast routes

Paulo Alcantara (2):
      smb: client: fix race with concurrent opens in unlink(2)
      smb: client: fix race with concurrent opens in rename(2)

Pavel Shpakovskiy (1):
      Bluetooth: hci_sync: fix set_local_name race condition

Ping Cheng (1):
      HID: wacom: Add a new Art Pen 2

Qasim Ijaz (2):
      HID: asus: fix UAF via HID_CLAIMED_INPUT validation
      HID: multitouch: fix slab out-of-bounds access in mt_report_fixup()

Radim Krčmář (1):
      RISC-V: KVM: fix stack overrun when loading vlenb

Randy Dunlap (1):
      pinctrl: STMFX: add missing HAS_IOMEM dependency

Rob Clark (1):
      drm/msm: Defer fd_install in SUBMIT ioctl

Rohan G Thomas (3):
      net: stmmac: xgmac: Do not enable RX FIFO Overflow interrupts
      net: stmmac: xgmac: Correct supported speed modes
      net: stmmac: Set CIC bit only for TX queues with COE

Shanker Donthineni (1):
      dma/pool: Ensure DMA_DIRECT_REMAP allocations are decrypted

Shuhao Fu (1):
      fs/smb: Fix inconsistent refcnt update

Sreekanth Reddy (1):
      bnxt_en: Fix memory corruption when FW resources change during ifdown

Steve French (1):
      smb3 client: fix return code mapping of remap_file_range

Takamitsu Iwai (3):
      net: rose: split remove and free operations in rose_remove_neigh()
      net: rose: convert 'use' field to refcount_t
      net: rose: include node references in rose_neigh refcount

Tao Chen (2):
      tools/latency-collector: Check pkg-config install
      rtla: Check pkg-config install

Tengda Wu (1):
      ftrace: Fix potential warning in trace_printk_seq during ftrace_dump

Thijs Raymakers (1):
      KVM: x86: use array_index_nospec with indices that come from guest

Thomas Hellström (1):
      drm/xe/vm: Clear the scratch_pt pointer on error

Timur Tabi (3):
      drm/nouveau: remove unused increment in gm200_flcn_pio_imem_wr
      drm/nouveau: remove unused memory target test
      drm/nouveau: fix error path in nvkm_gsp_fwsec_v2

Werner Sembach (1):
      ACPI: EC: Add device to acpi_ec_no_wakeup[] qurik list

Yang Wang (1):
      drm/amd/amdgpu: disable hwmon power1_cap* for gfx 11.0.3 on vf mode

Ye Weihua (1):
      trace/fgraph: Fix the warning caused by missing unregister notifier

Yeounsu Moon (1):
      net: dlink: fix multicast stats being counted incorrectly

Zbigniew Kempczyński (1):
      drm/xe/xe_sync: avoid race during ufence signaling

luoguangfei (1):
      net: macb: fix unregister_netdev call order in macb_remove()


