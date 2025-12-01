Return-Path: <stable+bounces-197709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96502C96D3C
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFECD34368E
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2540306D5F;
	Mon,  1 Dec 2025 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G3jRiB5O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE03090C7;
	Mon,  1 Dec 2025 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764587367; cv=none; b=QJGprEEpCpap3GjK3V6j1TuHBZ8pNzlTmD7FfUZhc+zhBdRDkElPajEPKIY1sY8wEZOfdRHh5cwGPRKODelwrMiKLY2dlMeeyuooVDpvtlJB2/pYOx9b0iR0Fmy5mnFWJdrJE46xBbqYj2875GS9E233gnZRurxlyphbHAOfRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764587367; c=relaxed/simple;
	bh=ppfIa6GbrBkOv0W9GLRLF/jaWWY8iM+bSKuzNqvm5R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RXZ/jxLLNhTWx83hgB1CZxdx1KjN9M+/x96zW38korPtdrea7XMXiWc2BBYLHJoiWKDd4JE0eyIRx4qVNe5L4RSepMg8zlQ6bCWmyPjERuXi0zvaOiodwi1jiH7hfrNvT1DS3XIarZJ97BnEJyFamL1KpLQDZ0dqB7vYk0OEs+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G3jRiB5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50880C4CEF1;
	Mon,  1 Dec 2025 11:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764587367;
	bh=ppfIa6GbrBkOv0W9GLRLF/jaWWY8iM+bSKuzNqvm5R0=;
	h=From:To:Cc:Subject:Date:From;
	b=G3jRiB5OtmIy8CqbbuWryHy1oPGlep+Gs2ezDkMP4UlK5GreEWMU+scEWuetwzpMn
	 ElX5FcZx3sn9aGLEvJeZVqzZkvoooNuov1tPu2n0T7X73s/rfleMdF4uqcHZCFfKps
	 dt2pGobzQCsmAfnp7rRZXlMwEwgKTJTKBW49gGRg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.17.10
Date: Mon,  1 Dec 2025 12:09:16 +0100
Message-ID: <2025120117-magnolia-settling-62d4@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.17.10 kernel.

All users of the 6.17 kernel series must upgrade.

The updated 6.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.17.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml |   26 +-
 Documentation/wmi/driver-development-guide.rst                          |    1 
 Makefile                                                                |    2 
 arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi                            |    2 
 arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi                       |    2 
 arch/arm64/boot/dts/rockchip/rk3576.dtsi                                |   12 
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi                          |    4 
 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts                     |    4 
 arch/arm64/kvm/hyp/nvhe/ffa.c                                           |    9 
 arch/loongarch/include/uapi/asm/ptrace.h                                |   40 +--
 arch/loongarch/kernel/numa.c                                            |   60 +---
 arch/loongarch/net/bpf_jit.c                                            |    3 
 arch/loongarch/pci/pci.c                                                |    8 
 arch/mips/boot/dts/econet/en751221.dtsi                                 |    2 
 arch/mips/kernel/process.c                                              |    2 
 arch/mips/mti-malta/malta-init.c                                        |   20 +
 arch/s390/include/asm/pgtable.h                                         |   12 
 arch/s390/mm/pgtable.c                                                  |    4 
 arch/x86/events/intel/uncore.c                                          |    1 
 arch/x86/kernel/cpu/amd.c                                               |    2 
 arch/x86/kernel/cpu/microcode/amd.c                                     |   20 +
 arch/x86/kvm/svm/svm.c                                                  |    9 
 arch/x86/kvm/svm/svm.h                                                  |    1 
 block/blk-crypto.c                                                      |    2 
 drivers/acpi/apei/einj-core.c                                           |   64 +++--
 drivers/ata/libata-scsi.c                                               |   11 
 drivers/base/power/main.c                                               |   25 +-
 drivers/bcma/main.c                                                     |    6 
 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c                                |    4 
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c                                  |    2 
 drivers/gpio/gpiolib-cdev.c                                             |    9 
 drivers/gpio/gpiolib-swnode.c                                           |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                              |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c                                |   65 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h                                |   10 
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c                              |    3 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c                                  |   58 ----
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h                                  |    6 
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c                                  |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c                                  |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c                                |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c             |   59 +---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c            |    4 
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c                  |   26 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c                 |    8 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c      |   11 
 drivers/gpu/drm/drm_plane.c                                             |    4 
 drivers/gpu/drm/i915/display/intel_cx0_phy.c                            |   14 -
 drivers/gpu/drm/i915/display/intel_display_device.c                     |   13 +
 drivers/gpu/drm/i915/display/intel_display_device.h                     |    4 
 drivers/gpu/drm/i915/display/intel_dmc.c                                |   10 
 drivers/gpu/drm/i915/display/intel_dp.c                                 |   30 --
 drivers/gpu/drm/i915/display/intel_psr.c                                |   36 ++
 drivers/gpu/drm/i915/display/intel_quirks.c                             |    9 
 drivers/gpu/drm/i915/display/intel_quirks.h                             |    1 
 drivers/gpu/drm/msm/msm_iommu.c                                         |    5 
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c                                |    2 
 drivers/gpu/drm/radeon/radeon_fence.c                                   |    7 
 drivers/gpu/drm/tegra/dc.c                                              |    1 
 drivers/gpu/drm/tegra/dsi.c                                             |    9 
 drivers/gpu/drm/tegra/uapi.c                                            |    7 
 drivers/gpu/drm/xe/tests/xe_mocs.c                                      |    2 
 drivers/gpu/drm/xe/xe_irq.c                                             |   18 -
 drivers/gpu/drm/xe/xe_pci.c                                             |    1 
 drivers/gpu/drm/xe/xe_vm.c                                              |    4 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c                           |    2 
 drivers/hid/hid-ids.h                                                   |    4 
 drivers/hid/hid-quirks.c                                                |   13 -
 drivers/input/keyboard/cros_ec_keyb.c                                   |    6 
 drivers/input/keyboard/imx_sc_key.c                                     |    2 
 drivers/input/tablet/pegasus_notetaker.c                                |    9 
 drivers/input/touchscreen/goodix.c                                      |    1 
 drivers/mtd/mtdchar.c                                                   |    6 
 drivers/mtd/nand/raw/cadence-nand-controller.c                          |    3 
 drivers/net/dsa/hirschmann/hellcreek_ptp.c                              |   14 -
 drivers/net/dsa/microchip/lan937x_main.c                                |    1 
 drivers/net/ethernet/airoha/airoha_eth.h                                |   11 
 drivers/net/ethernet/airoha/airoha_ppe.c                                |  103 ++++++--
 drivers/net/ethernet/emulex/benet/be_main.c                             |    7 
 drivers/net/ethernet/intel/ice/ice_ptp.c                                |   22 +
 drivers/net/ethernet/intel/idpf/idpf_main.c                             |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c              |    9 
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c                       |    6 
 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c                    |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c                   |    6 
 drivers/net/ethernet/qlogic/qede/qede_fp.c                              |    5 
 drivers/net/ethernet/ti/netcp_core.c                                    |   10 
 drivers/net/phy/phylink.c                                               |    3 
 drivers/net/veth.c                                                      |   38 +--
 drivers/net/wireless/realtek/rtw89/fw.c                                 |    7 
 drivers/nvme/host/fc.c                                                  |   15 -
 drivers/nvme/host/multipath.c                                           |    2 
 drivers/nvme/target/auth.c                                              |    4 
 drivers/nvme/target/fabrics-cmd-auth.c                                  |    1 
 drivers/nvme/target/nvmet.h                                             |    1 
 drivers/perf/riscv_pmu_sbi.c                                            |    2 
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c                                |   23 +
 drivers/pinctrl/mediatek/pinctrl-mt8189.c                               |    4 
 drivers/pinctrl/mediatek/pinctrl-mt8196.c                               |    6 
 drivers/pinctrl/nxp/pinctrl-s32cc.c                                     |    3 
 drivers/pinctrl/realtek/Kconfig                                         |    1 
 drivers/platform/x86/Kconfig                                            |    1 
 drivers/platform/x86/dell/alienware-wmi-wmax.c                          |  104 ++------
 drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c               |    4 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h   |    9 
 drivers/platform/x86/msi-wmi-platform.c                                 |   43 +++
 drivers/reset/reset-imx8mp-audiomix.c                                   |    4 
 drivers/s390/net/ctcm_mpc.c                                             |    1 
 drivers/scsi/hosts.c                                                    |    5 
 drivers/scsi/sg.c                                                       |   10 
 drivers/soc/ti/knav_dma.c                                               |   14 -
 drivers/target/loopback/tcm_loop.c                                      |    3 
 drivers/tty/vt/vt_ioctl.c                                               |    4 
 drivers/ufs/host/ufs-qcom.c                                             |   15 +
 fs/btrfs/inode.c                                                        |    1 
 fs/btrfs/tree-log.c                                                     |    3 
 fs/exfat/super.c                                                        |    5 
 fs/fat/inode.c                                                          |    6 
 fs/isofs/inode.c                                                        |    5 
 fs/namespace.c                                                          |    4 
 fs/smb/client/cached_dir.c                                              |   43 +++
 fs/smb/client/cifsfs.c                                                  |    2 
 fs/smb/client/cifsproto.h                                               |    2 
 fs/smb/client/connect.c                                                 |   38 +--
 fs/smb/client/dfs_cache.c                                               |   55 +++-
 fs/smb/client/fs_context.c                                              |    4 
 fs/xfs/scrub/symlink_repair.c                                           |    4 
 fs/xfs/xfs_super.c                                                      |    5 
 include/drm/intel/pciids.h                                              |    5 
 include/linux/ata.h                                                     |    1 
 include/net/tls.h                                                       |   25 +-
 include/net/xfrm.h                                                      |    3 
 io_uring/cmd_net.c                                                      |    2 
 kernel/events/core.c                                                    |    2 
 kernel/sched/ext.c                                                      |  121 +++++++++-
 kernel/sched/sched.h                                                    |    1 
 kernel/time/tick-sched.c                                                |   11 
 kernel/time/timekeeping.c                                               |   21 -
 kernel/time/timer.c                                                     |    7 
 lib/test_kho.c                                                          |    3 
 mm/mempool.c                                                            |   32 ++
 mm/shmem.c                                                              |   15 -
 mm/truncate.c                                                           |   35 ++
 net/core/dev_ioctl.c                                                    |    3 
 net/devlink/rate.c                                                      |    4 
 net/ipv4/esp4_offload.c                                                 |    6 
 net/ipv6/esp6_offload.c                                                 |    6 
 net/mptcp/options.c                                                     |   54 ++++
 net/mptcp/pm.c                                                          |   20 +
 net/mptcp/pm_kernel.c                                                   |    2 
 net/mptcp/protocol.c                                                    |   84 ++++--
 net/mptcp/protocol.h                                                    |    3 
 net/mptcp/subflow.c                                                     |    8 
 net/openvswitch/actions.c                                               |   68 -----
 net/openvswitch/flow_netlink.c                                          |   64 -----
 net/openvswitch/flow_netlink.h                                          |    2 
 net/tls/tls_device.c                                                    |    4 
 net/unix/af_unix.c                                                      |    3 
 net/vmw_vsock/af_vsock.c                                                |   40 ++-
 net/xfrm/xfrm_device.c                                                  |    2 
 net/xfrm/xfrm_output.c                                                  |    8 
 net/xfrm/xfrm_state.c                                                   |   16 -
 net/xfrm/xfrm_user.c                                                    |    5 
 scripts/kconfig/mconf.c                                                 |    3 
 scripts/kconfig/nconf.c                                                 |    3 
 security/selinux/hooks.c                                                |   79 +++---
 security/selinux/include/objsec.h                                       |   20 +
 sound/hda/codecs/realtek/alc269.c                                       |    2 
 sound/soc/codecs/rt721-sdca.c                                           |    4 
 sound/soc/codecs/rt721-sdca.h                                           |    1 
 sound/usb/mixer.c                                                       |    2 
 tools/arch/riscv/include/asm/csr.h                                      |    5 
 tools/testing/selftests/cachestat/test_cachestat.c                      |    4 
 tools/testing/selftests/net/bareudp.sh                                  |    2 
 tools/testing/selftests/net/forwarding/lib_sh_test.sh                   |    7 
 tools/testing/selftests/net/lib.sh                                      |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                         |   18 -
 tools/tracing/latency/latency-collector.c                               |    2 
 184 files changed, 1493 insertions(+), 919 deletions(-)

Aleksander Jan Bajkowski (1):
      mips: dts: econet: fix EN751221 core type

Aleksei Nikiforov (1):
      s390/ctcm: Fix double-kfree

Alexey Charkov (1):
      arm64: dts: rockchip: Remove non-functioning CPU OPPs from RK3576

Alistair Francis (1):
      nvmet-auth: update sc_c in target host hash calculation

Andrea Righi (1):
      sched_ext: Fix scx_kick_pseqs corruption on concurrent scheduler loads

Andrey Vatoropin (1):
      be2net: pass wrb_params in case of OS2BMC

Ankit Nautiyal (2):
      Revert "drm/i915/dp: Reject HBR3 when sink doesn't support TPS4"
      drm/i915/dp: Add device specific quirk to limit eDP rate to HBR2

Anthony Wong (1):
      platform/x86: alienware-wmi-wmax: Add AWCC support to Alienware 16 Aurora

Armin Wolf (2):
      platform/x86: msi-wmi-platform: Only load on MSI devices
      platform/x86: msi-wmi-platform: Fix typo in WMI GUID

Bart Van Assche (2):
      scsi: sg: Do not sleep in atomic context
      scsi: core: Fix a regression triggered by scsi_host_busy()

Bartosz Golaszewski (1):
      gpio: cdev: make sure the cdev fd is still active before emitting events

Bibo Mao (1):
      LoongArch: Fix NUMA node parsing with numa_memblks

Bitterblue Smith (1):
      wifi: rtw89: hw_scan: Don't let the operating channel be last

Borislav Petkov (AMD) (2):
      x86/microcode/AMD: Limit Entrysign signature checking to known generations
      x86/CPU/AMD: Extend Zen6 model range

Carlos Llamas (1):
      blk-crypto: use BLK_STS_INVAL for alignment errors

Charlene Liu (1):
      drm/amd/display: Insert dccg log for easy debug

Charles Keepax (1):
      Revert "gpio: swnode: don't use the swnode's name as the key for GPIO lookup"

Chen Pei (1):
      tools: riscv: Fixed misalignment of CSR related definitions

Chen-Yu Tsai (2):
      clk: sunxi-ng: sun55i-a523-r-ccu: Mark bus-r-dma as critical
      clk: sunxi-ng: sun55i-a523-ccu: Lower audio0 pll minimum rate

Dan Carpenter (2):
      mtdchar: fix integer overflow in read/write ioctls
      Input: imx_sc_key - fix memory corruption on unload

Dapeng Mi (1):
      perf: Fix 0 count issue of cpu-clock

Darrick J. Wong (1):
      xfs: fix out of bounds memory read error in symlink repair

Diederik de Haas (1):
      arm64: dts: rockchip: Fix vccio4-supply on rk3566-pinetab2

Diogo Ivo (1):
      Revert "drm/tegra: dsi: Clear enable register if powered by bootloader"

Dnyaneshwar Bhadane (4):
      drm/i915/xe3lpd: Load DMC for Xe3_LPD version 30.02
      drm/pcids: Split PTL pciids group to make wcl subplatform
      drm/i915/display: Add definition for wcl as subplatform
      drm/i915/xe3: Restrict PTL intel_encoder_is_c10phy() to only PHY A

Emil Tantilov (1):
      idpf: fix possible vport_config NULL pointer deref in remove

Emil Tsalapatis (2):
      sched_ext: defer queue_balance_callback() until after ops.dispatch
      sched_ext: fix flag check for deferred callbacks

Eren Demir (1):
      ALSA: hda/realtek: Fix mute led for HP Victus 15-fa1xxx (MB 8C2D)

Eric Dumazet (2):
      mptcp: fix race condition in mptcp_schedule_work()
      mptcp: fix a race in mptcp_pm_del_add_timer()

Ewan D. Milne (2):
      nvme: nvme-fc: move tagset removal to nvme_fc_delete_ctrl()
      nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()

Fangzhi Zuo (2):
      drm/amd/display: Fix pbn to kbps Conversion
      drm/amd/display: Prevent Gating DTBCLK before It Is Properly Latched

Filipe Manana (1):
      btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name

Gang Yan (1):
      mptcp: fix address removal logic in mptcp_pm_nl_rm_addr

Greg Kroah-Hartman (1):
      Linux 6.17.10

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

J-Donald Tournier (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga 7 2-in-1 14AKP10

Jakub Horký (2):
      kconfig/mconf: Initialize the default locale at startup
      kconfig/nconf: Initialize the default locale at startup

Jared Kangas (2):
      pinctrl: s32cc: fix uninitialized memory in s32_pinctrl_desc
      pinctrl: s32cc: initialize gpio_pin_config::list after kmalloc()

Jari Ruusu (1):
      tty/vt: fix up incorrect backport to stable releases

Jens Axboe (1):
      io_uring/cmd_net: fix wrong argument types for skb_queue_splice()

Jernej Skrabec (1):
      clk: sunxi-ng: Mark A523 bus-r-cpucfg clock as critical

Jesper Dangaard Brouer (1):
      veth: more robust handing of race to avoid txq getting stuck

Jiaming Zhang (1):
      net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()

Jianbo Liu (3):
      xfrm: Check inner packet family directly from skb_dst
      xfrm: Determine inner GSO type from packet inner protocol
      xfrm: Prevent locally generated packets from direct output in tunnel mode

Jiayuan Chen (2):
      mptcp: Disallow MPTCP subflows from sockmap
      mptcp: Fix proto fallback detection with BPF

Jouni Högander (1):
      drm/i915/psr: Check drm_dp_dpcd_read return value on PSR dpcd init

Kiryl Shutsemau (1):
      mm/truncate: unmap large folio on split failure

Krzysztof Kozlowski (1):
      dt-bindings: pinctrl: toshiba,visconti: Fix number of items in groups

Kuniyuki Iwashima (1):
      af_unix: Read sk_peek_offset() again after sleeping in unix_stream_read_generic().

Kurt Borja (4):
      platform/x86: alienware-wmi-wmax: Fix "Alienware m16 R1 AMD" quirk order
      platform/x86: alienware-wmi-wmax: Add support for the whole "M" family
      platform/x86: alienware-wmi-wmax: Add support for the whole "X" family
      platform/x86: alienware-wmi-wmax: Add support for the whole "G" family

Laurentiu Mihalcea (1):
      reset: imx8mp-audiomix: Fix bad mask values

Lorenzo Bianconi (2):
      net: airoha: Add wlan flowtable TX offload
      net: airoha: Do not loopback traffic to GDM2 if it is available on the device

Louis-Alexis Eyraud (2):
      pinctrl: mediatek: mt8196: align register base names to dt-bindings ones
      pinctrl: mediatek: mt8189: align register base names to dt-bindings ones

Ma Ke (1):
      drm/tegra: dc: Fix reference leak in tegra_dc_couple()

Maciej W. Rozycki (1):
      MIPS: Malta: Fix !EVA SOC-it PCI MMIO

Malaya Kumar Rout (1):
      timekeeping: Fix resource leak in tk_aux_sysfs_init() error paths

Marcelo Moreira (1):
      xfs: Replace strncpy with memcpy

Mario Limonciello (1):
      drm/amd: Skip power ungate during suspend for VPE

Mario Limonciello (AMD) (3):
      HID: amd_sfh: Stop sensor before starting
      drm/amd/display: Increase DPCD read retries
      drm/amd/display: Move sleep into each retry for retrieve_link_cap()

Matt Roper (1):
      drm/xe/kunit: Fix forcewake assertion in mocs test

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

Nitin Rawat (1):
      scsi: ufs: ufs-qcom: Fix UFS OCP issue during UFS power down (PC=3)

Oleksij Rempel (1):
      net: dsa: microchip: lan937x: Fix RGMII delay tuning

Paolo Abeni (6):
      mptcp: fix ack generation for fallback msk
      mptcp: fix duplicate reset on fastclose
      mptcp: fix premature close in case of fallback
      mptcp: avoid unneeded subflow-level drops
      mptcp: decouple mptcp fastclose from tcp close
      mptcp: do not fallback when OoO is present

Pasha Tatashin (1):
      lib/test_kho: check if KHO is enabled

Paulo Alcantara (1):
      smb: client: handle lack of IPC in dfs_cache_refresh()

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

Rafael J. Wysocki (1):
      PM: sleep: core: Fix runtime PM enabling in device_resume_early()

Rafał Miłecki (1):
      bcma: don't register devices disabled in OF

Randy Dunlap (1):
      platform/x86: intel-uncore-freq: fix all header kernel-doc warnings

René Rebe (1):
      ALSA: usb-audio: fix uac2 clock source at terminal parser

Rob Clark (1):
      drm/msm: Fix pgtable prealloc error path

Robert McClinton (1):
      drm/radeon: delete radeon_fence_process in is_signaled, no deadlock

Sabrina Dubroca (4):
      xfrm: drop SA reference in xfrm_state_update if dir doesn't match
      xfrm: also call xfrm_state_delete_tunnel at destroy time for states that were never added
      xfrm: call xfrm_dev_state_delete when xfrm_state_migrate fails to add the state
      xfrm: set err and extack on failure to create pcpu SA

Saket Kumar Bhaskar (1):
      sched_ext: Fix scx_enable() crash on helper kthread creation failure

Samuel Zhang (1):
      drm/amdgpu: fix gpu page fault after hibernation on PF passthrough

Sathishkumar S (2):
      drm/amdgpu/jpeg: Move parse_cs to amdgpu_jpeg.c
      drm/amdgpu/jpeg: Add parse_cs for JPEG5_0_1

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

Shuming Fan (1):
      ASoC: rt721: fix prepare clock stop failed

Sidharth Seela (1):
      selftests: cachestat: Fix warning on declaration under label

Stephen Smalley (2):
      selinux: rename task_security_struct to cred_security_struct
      selinux: move avdcache to per-task security struct

Steve French (1):
      cifs: fix typo in enable_gcm_256 module parameter

Tejun Heo (1):
      sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily using kvzalloc()

Thomas Bogendoerfer (1):
      MIPS: kernel: Fix random segmentation faults

Thomas Weißschuh (1):
      LoongArch: Use UAPI types in ptrace UAPI header

Tony Luck (1):
      ACPI: APEI: EINJ: Fix EINJV2 initialization and injection

Tzung-Bi Shih (1):
      Input: cros_ec_keyb - fix an invalid memory access

Venkata Ramana Nayana (1):
      drm/xe/irq: Handle msix vector0 interrupt

Ville Syrjälä (1):
      drm/plane: Fix create_in_format_blob() return value

Vincent Li (1):
      LoongArch: BPF: Disable trampoline for kernel module function trace

Vlastimil Babka (1):
      mm/mempool: fix poisoning order>0 pages with HIGHMEM

Wei Fang (1):
      net: phylink: add missing supported link modes for the fixed-link

Wen Yang (1):
      tick/sched: Fix bogus condition in report_idle_softirq()

Yifan Zha (1):
      drm/amdgpu: Skip emit de meta data on gfx11 with rs64 enabled

Yihang Li (1):
      ata: libata-scsi: Add missing scsi_device_put() in ata_scsi_dev_rescan()

Yipeng Zou (1):
      timers: Fix NULL function pointer race in timer_shutdown_sync()

Yongpeng Yang (4):
      vfat: fix missing sb_min_blocksize() return value checks
      xfs: check the return value of sb_min_blocksize() in xfs_fs_fill_super
      isofs: check the return value of sb_min_blocksize() in isofs_fill_super
      exfat: check return value of sb_min_blocksize in exfat_read_boot_sector

Yosry Ahmed (1):
      KVM: SVM: Fix redundant updates of LBR MSR intercepts

Yu-Chun Lin (1):
      pinctrl: realtek: Select REGMAP_MMIO for RTD driver

Zhang Chujun (1):
      tracing/tools: Fix incorrcet short option in usage text for --threads

Zhang Heng (1):
      HID: quirks: work around VID/PID conflict for 0x4c4a/0x4155

Zhen Ni (1):
      fs: Fix uninitialized 'offp' in statmount_string()

Zilin Guan (1):
      mlxsw: spectrum: Fix memory leak in mlxsw_sp_flower_stats()

dongsheng (1):
      perf/x86/intel/uncore: Add uncore PMU support for Wildcat Lake


