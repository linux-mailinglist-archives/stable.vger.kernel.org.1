Return-Path: <stable+bounces-197707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA732C96D20
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A16084E15F0
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F183307ACF;
	Mon,  1 Dec 2025 11:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XPW21KP4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1C3074BB;
	Mon,  1 Dec 2025 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764587358; cv=none; b=ppn0lNYxVxUNK7KxhdMEROB4T4cRBUjoWcRIiclWt8WnU+piQB+u48FPAmP/O7ogUwm+ZfwcJStS0nKjyopY0uDqFrBDHEqppMWT/sZ9geV5yRBikPRrjnr5UKw6nACwxXXjaRpAbHNyU5k/VCeI8O6DGxXEXgge8OyDauspims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764587358; c=relaxed/simple;
	bh=tNFmq0+fWhqKjNOhRIMlRM4cQiiTuDTEwEnX6pNu83g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aEEeTy2bzuWofjIL13ZBvE9Qjs5eG3QigYmIFZfno7rMWemtBRw4wus+jIOUZN5sk1O0sj1FaILhen1JkcEmct9CNcYDBAtA243pOIjaq5ZxMapZwxnl8A/YrqAZW9ydBd0Uu4oaSpTSvFdKGH5I4MKooMER77b6jL4y/ElFUN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XPW21KP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA11C113D0;
	Mon,  1 Dec 2025 11:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764587358;
	bh=tNFmq0+fWhqKjNOhRIMlRM4cQiiTuDTEwEnX6pNu83g=;
	h=From:To:Cc:Subject:Date:From;
	b=XPW21KP4raJP1ztcWNaQYbP5FdcSUlmuEm6A3MFU6YodfwNp5heyZuQEg7T2jdCc2
	 zGkp6cM3R0tpT7iOIGezuVqlHrCfyGffx3Z2wGZs5IYquR8gRCZYaO2N0WAbp2ab1b
	 SiV8iKQtpF9812d2Yc1CZj20lSeMQqpc2eZO4gvc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.60
Date: Mon,  1 Dec 2025 12:09:10 +0100
Message-ID: <2025120111-ancient-rumor-f2cd@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.60 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml |   26 +--
 Documentation/wmi/driver-development-guide.rst                          |    1 
 Makefile                                                                |    2 
 arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi                            |    2 
 arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi                       |    2 
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi                          |    4 
 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts                     |    4 
 arch/arm64/kvm/hyp/nvhe/ffa.c                                           |    9 -
 arch/arm64/kvm/sys_regs.c                                               |   61 +++----
 arch/loongarch/include/uapi/asm/ptrace.h                                |   40 ++--
 arch/loongarch/pci/pci.c                                                |    8 
 arch/mips/mti-malta/malta-init.c                                        |   20 +-
 arch/s390/include/asm/pgtable.h                                         |   12 -
 arch/s390/mm/pgtable.c                                                  |    4 
 arch/x86/kernel/cpu/microcode/amd.c                                     |   20 ++
 block/blk-crypto.c                                                      |    2 
 drivers/ata/libata-scsi.c                                               |   11 +
 drivers/bcma/main.c                                                     |    6 
 drivers/gpio/gpiolib-swnode.c                                           |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                              |    3 
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c                              |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                                 |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c             |   59 ++-----
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c            |   20 +-
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c                  |   60 +++++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c                 |    8 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c                 |   21 +-
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c      |   11 -
 drivers/gpu/drm/i915/display/intel_psr.c                                |    4 
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c                                |    2 
 drivers/gpu/drm/radeon/radeon_fence.c                                   |    7 
 drivers/gpu/drm/tegra/dc.c                                              |    1 
 drivers/gpu/drm/tegra/dsi.c                                             |    9 -
 drivers/gpu/drm/tegra/uapi.c                                            |    7 
 drivers/gpu/drm/xe/xe_vm.c                                              |    4 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c                           |    2 
 drivers/hid/hid-ids.h                                                   |    4 
 drivers/hid/hid-quirks.c                                                |   13 +
 drivers/infiniband/hw/irdma/Kconfig                                     |    7 
 drivers/input/keyboard/cros_ec_keyb.c                                   |    6 
 drivers/input/keyboard/imx_sc_key.c                                     |    2 
 drivers/input/tablet/pegasus_notetaker.c                                |    9 +
 drivers/input/touchscreen/goodix.c                                      |    1 
 drivers/mtd/mtdchar.c                                                   |    6 
 drivers/mtd/nand/raw/cadence-nand-controller.c                          |    3 
 drivers/net/dsa/hirschmann/hellcreek_ptp.c                              |   14 +
 drivers/net/dsa/microchip/lan937x_main.c                                |    1 
 drivers/net/ethernet/emulex/benet/be_main.c                             |    7 
 drivers/net/ethernet/intel/ice/ice_ptp.c                                |   22 ++
 drivers/net/ethernet/intel/idpf/idpf_main.c                             |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c              |    9 -
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c                       |    6 
 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c                    |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c                   |    6 
 drivers/net/ethernet/qlogic/qede/qede_fp.c                              |    5 
 drivers/net/ethernet/ti/netcp_core.c                                    |   10 -
 drivers/nvme/host/fc.c                                                  |   15 -
 drivers/nvme/host/multipath.c                                           |    2 
 drivers/perf/riscv_pmu_sbi.c                                            |    2 
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c                                |   23 ++
 drivers/pinctrl/nxp/pinctrl-s32cc.c                                     |    3 
 drivers/pinctrl/realtek/Kconfig                                         |    1 
 drivers/platform/x86/Kconfig                                            |    1 
 drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c               |    4 
 drivers/platform/x86/msi-wmi-platform.c                                 |   43 ++++-
 drivers/s390/net/ctcm_mpc.c                                             |    1 
 drivers/scsi/hosts.c                                                    |    5 
 drivers/scsi/sg.c                                                       |   10 +
 drivers/soc/ti/knav_dma.c                                               |   14 -
 drivers/target/loopback/tcm_loop.c                                      |    3 
 drivers/tty/vt/vt_ioctl.c                                               |    4 
 fs/exfat/super.c                                                        |    5 
 fs/isofs/inode.c                                                        |    5 
 fs/smb/client/cached_dir.c                                              |   43 ++++-
 fs/smb/client/cifsfs.c                                                  |    2 
 fs/smb/client/fs_context.c                                              |    4 
 fs/xfs/scrub/symlink_repair.c                                           |    4 
 include/linux/ata.h                                                     |    1 
 include/net/tls.h                                                       |   25 +-
 include/net/xfrm.h                                                      |    3 
 kernel/time/timer.c                                                     |    7 
 lib/maple_tree.c                                                        |   30 +--
 mm/mempool.c                                                            |   32 +++
 mm/shmem.c                                                              |   15 -
 net/devlink/rate.c                                                      |    4 
 net/ipv4/esp4_offload.c                                                 |    6 
 net/ipv6/esp6_offload.c                                                 |    6 
 net/mptcp/options.c                                                     |   54 ++++++
 net/mptcp/pm_netlink.c                                                  |   20 +-
 net/mptcp/protocol.c                                                    |   84 ++++++----
 net/mptcp/protocol.h                                                    |    3 
 net/mptcp/subflow.c                                                     |    8 
 net/openvswitch/actions.c                                               |   68 --------
 net/openvswitch/flow_netlink.c                                          |   64 -------
 net/openvswitch/flow_netlink.h                                          |    2 
 net/tls/tls_device.c                                                    |    4 
 net/unix/af_unix.c                                                      |   36 ++--
 net/vmw_vsock/af_vsock.c                                                |   40 +++-
 net/xfrm/xfrm_output.c                                                  |    6 
 net/xfrm/xfrm_state.c                                                   |    8 
 net/xfrm/xfrm_user.c                                                    |    5 
 scripts/kconfig/mconf.c                                                 |    3 
 scripts/kconfig/nconf.c                                                 |    3 
 sound/usb/endpoint.c                                                    |    3 
 sound/usb/mixer.c                                                       |    2 
 tools/arch/riscv/include/asm/csr.h                                      |    5 
 tools/testing/selftests/net/bareudp.sh                                  |    2 
 tools/testing/selftests/net/forwarding/lib_sh_test.sh                   |    7 
 tools/testing/selftests/net/lib.sh                                      |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                         |   18 +-
 tools/tracing/latency/latency-collector.c                               |    2 
 112 files changed, 850 insertions(+), 522 deletions(-)

Aleksei Nikiforov (1):
      s390/ctcm: Fix double-kfree

Andrey Vatoropin (1):
      be2net: pass wrb_params in case of OS2BMC

Armin Wolf (2):
      platform/x86: msi-wmi-platform: Only load on MSI devices
      platform/x86: msi-wmi-platform: Fix typo in WMI GUID

Bart Van Assche (2):
      scsi: sg: Do not sleep in atomic context
      scsi: core: Fix a regression triggered by scsi_host_busy()

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Limit Entrysign signature checking to known generations

Carlos Llamas (1):
      blk-crypto: use BLK_STS_INVAL for alignment errors

Charlene Liu (3):
      drm/amd/display: avoid reset DTBCLK at clock init
      drm/amd/display: disable DPP RCG before DPP CLK enable
      drm/amd/display: Insert dccg log for easy debug

Charles Keepax (1):
      Revert "gpio: swnode: don't use the swnode's name as the key for GPIO lookup"

Chen Pei (1):
      tools: riscv: Fixed misalignment of CSR related definitions

Dan Carpenter (2):
      mtdchar: fix integer overflow in read/write ioctls
      Input: imx_sc_key - fix memory corruption on unload

Darrick J. Wong (1):
      xfs: fix out of bounds memory read error in symlink repair

Diederik de Haas (1):
      arm64: dts: rockchip: Fix vccio4-supply on rk3566-pinetab2

Diogo Ivo (1):
      Revert "drm/tegra: dsi: Clear enable register if powered by bootloader"

Emil Tantilov (1):
      idpf: fix possible vport_config NULL pointer deref in remove

Eric Dumazet (2):
      mptcp: fix race condition in mptcp_schedule_work()
      mptcp: fix a race in mptcp_pm_del_add_timer()

Ewan D. Milne (2):
      nvme: nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
      nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()

Fangzhi Zuo (2):
      drm/amd/display: Fix pbn to kbps Conversion
      drm/amd/display: Prevent Gating DTBCLK before It Is Properly Latched

Greg Kroah-Hartman (1):
      Linux 6.12.60

Grzegorz Nitka (1):
      ice: fix PTP cleanup on driver removal in error path

Hamza Mahfooz (1):
      scsi: target: tcm_loop: Fix segfault in tcm_loop_tpg_address_show()

Hans de Goede (1):
      Input: goodix - add support for ACPI ID GDIX1003

Haotian Zhang (2):
      pinctrl: cirrus: Fix fwnode leak in cs42l43_pin_probe()
      platform/x86/intel/speed_select_if: Convert PCIBIOS_* return codes to errnos

Heiko Carstens (1):
      s390/mm: Fix __ptep_rdp() inline assembly

Henrique Carvalho (2):
      smb: client: introduce close_cached_dir_locked()
      smb: client: fix incomplete backport in cfids_invalidation_worker()

Huacai Chen (1):
      LoongArch: Don't panic if no valid cache info for PCI

Ido Schimmel (1):
      selftests: net: lib: Do not overwrite error messages

Ilya Maximets (1):
      net: openvswitch: remove never-working support for setting nsh fields

Imre Deak (1):
      drm/i915/dp_mst: Disable Panel Replay

Ivan Lipski (1):
      drm/amd/display: Clear the CUR_ENABLE register on DCN20 on DPP5

Jakub Horký (2):
      kconfig/mconf: Initialize the default locale at startup
      kconfig/nconf: Initialize the default locale at startup

Jared Kangas (2):
      pinctrl: s32cc: fix uninitialized memory in s32_pinctrl_desc
      pinctrl: s32cc: initialize gpio_pin_config::list after kmalloc()

Jari Ruusu (1):
      tty/vt: fix up incorrect backport to stable releases

Jianbo Liu (2):
      xfrm: Determine inner GSO type from packet inner protocol
      xfrm: Prevent locally generated packets from direct output in tunnel mode

Jiayuan Chen (2):
      mptcp: Disallow MPTCP subflows from sockmap
      mptcp: Fix proto fallback detection with BPF

Krzysztof Kozlowski (1):
      dt-bindings: pinctrl: toshiba,visconti: Fix number of items in groups

Kuniyuki Iwashima (2):
      af_unix: Cache state->msg in unix_stream_read_generic().
      af_unix: Read sk_peek_offset() again after sleeping in unix_stream_read_generic().

Ma Ke (1):
      drm/tegra: dc: Fix reference leak in tegra_dc_couple()

Maciej W. Rozycki (1):
      MIPS: Malta: Fix !EVA SOC-it PCI MMIO

Marc Zyngier (1):
      KVM: arm64: Make all 32bit ID registers fully writable

Marcelo Moreira (1):
      xfs: Replace strncpy with memcpy

Mario Limonciello (1):
      drm/amd: Skip power ungate during suspend for VPE

Mario Limonciello (AMD) (3):
      HID: amd_sfh: Stop sensor before starting
      drm/amd/display: Increase DPCD read retries
      drm/amd/display: Move sleep into each retry for retrieve_link_cap()

Martin Kaiser (1):
      maple_tree: fix tracepoint string pointers

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: join: endpoints: longer timeout
      selftests: mptcp: join: userspace: longer timeout

Michal Luczaj (1):
      vsock: Ignore signal/timeout on connect() if already established

Mike Yuan (1):
      shmem: fix tmpfs reconfiguration (remount) when noswap is set

Mykola Kvach (1):
      arm64: dts: rockchip: fix PCIe 3.3V regulator voltage on orangepi-5

Nam Cao (1):
      nouveau/firmware: Add missing kfree() of nvkm_falcon_fw::boot

Niklas Cassel (1):
      ata: libata-scsi: Fix system suspend for a security locked drive

Niravkumar L Rabara (1):
      mtd: rawnand: cadence: fix DMA device NULL pointer dereference

Nishanth Menon (1):
      net: ethernet: ti: netcp: Standardize knav_dma_open_channel to return NULL on error

Oleksij Rempel (1):
      net: dsa: microchip: lan937x: Fix RGMII delay tuning

Paolo Abeni (6):
      mptcp: fix ack generation for fallback msk
      mptcp: fix duplicate reset on fastclose
      mptcp: fix premature close in case of fallback
      mptcp: avoid unneeded subflow-level drops
      mptcp: decouple mptcp fastclose from tcp close
      mptcp: do not fallback when OoO is present

Pavel Zhigulin (3):
      net: dsa: hellcreek: fix missing error handling in LED registration
      net: mlxsw: linecards: fix missing error check in mlxsw_linecard_devlink_info_get()
      net: qlogic/qede: fix potential out-of-bounds read in qede_tpa_cont() and qede_tpa_end()

Po-Hsu Lin (1):
      selftests: net: use BASH for bareudp testing

Pradyumn Rahar (1):
      net/mlx5: Clean up only new IRQ glue on request_irq() failure

Prateek Agarwal (1):
      drm/tegra: Add call to put_pid()

Quentin Schulz (2):
      arm64: dts: rockchip: include rk3399-base instead of rk3399 in rk3399-op1
      arm64: dts: rockchip: disable HS400 on RK3588 Tiger

Rafał Miłecki (1):
      bcma: don't register devices disabled in OF

René Rebe (1):
      ALSA: usb-audio: fix uac2 clock source at terminal parser

Robert McClinton (1):
      drm/radeon: delete radeon_fence_process in is_signaled, no deadlock

Sabrina Dubroca (2):
      xfrm: drop SA reference in xfrm_state_update if dir doesn't match
      xfrm: set err and extack on failure to create pcpu SA

Samuel Zhang (1):
      drm/amdgpu: fix gpu page fault after hibernation on PF passthrough

Sebastian Ene (1):
      KVM: arm64: Check the untrusted offset in FF-A memory share

Seungjin Bae (1):
      Input: pegasus-notetaker - fix potential out-of-bounds access

Shahar Shitrit (2):
      net: tls: Change async resync helpers argument
      net: tls: Cancel RX async resync request on rcd_delta overflow

Shaurya Rane (1):
      cifs: fix memory leak in smb3_fs_context_parse_param error path

Shay Drory (1):
      devlink: rate: Unset parent pointer in devl_rate_nodes_destroy

Shin'ichiro Kawasaki (1):
      nvme-multipath: fix lockdep WARN due to partition scan work

Shuicheng Lin (1):
      drm/xe: Prevent BIT() overflow when handling invalid prefetch region

Steve French (1):
      cifs: fix typo in enable_gcm_256 module parameter

Takashi Iwai (1):
      ALSA: usb-audio: Fix missing unlock at error path of maxpacksize check

Thomas Weißschuh (1):
      LoongArch: Use UAPI types in ptrace UAPI header

Tzung-Bi Shih (1):
      Input: cros_ec_keyb - fix an invalid memory access

Vlastimil Babka (1):
      mm/mempool: fix poisoning order>0 pages with HIGHMEM

Wentao Guan (1):
      Revert "RDMA/irdma: Update Kconfig"

Yifan Zha (1):
      drm/amdgpu: Skip emit de meta data on gfx11 with rs64 enabled

Yihang Li (1):
      ata: libata-scsi: Add missing scsi_device_put() in ata_scsi_dev_rescan()

Yipeng Zou (1):
      timers: Fix NULL function pointer race in timer_shutdown_sync()

Yongpeng Yang (2):
      isofs: check the return value of sb_min_blocksize() in isofs_fill_super
      exfat: check return value of sb_min_blocksize in exfat_read_boot_sector

Yu-Chun Lin (1):
      pinctrl: realtek: Select REGMAP_MMIO for RTD driver

Zhang Chujun (1):
      tracing/tools: Fix incorrcet short option in usage text for --threads

Zhang Heng (1):
      HID: quirks: work around VID/PID conflict for 0x4c4a/0x4155

Zilin Guan (1):
      mlxsw: spectrum: Fix memory leak in mlxsw_sp_flower_stats()


