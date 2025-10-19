Return-Path: <stable+bounces-187901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09940BEE774
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87A0188531E
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2088F2E88B7;
	Sun, 19 Oct 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="obQgKqdq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05ED2E8882;
	Sun, 19 Oct 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760885172; cv=none; b=QRK1uQMZXuu7F1tATLTOFYLKTSsgqC03gdm2eBKDkgBcjiR4DSFQrnOrd8pmb+3Pvg/NLnnVh+2owEuE0zGYzopDKfvsBY00YFbrHXvvKUVX/dp1zRFtwMbwvInj2PnVDXxqASG2Hy3NZd3Vk67BcQeJ6SL7VN1olhAVG9zg3ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760885172; c=relaxed/simple;
	bh=Z3Y45baxMqFHJMF4DwtO5py0EhiPScW9jUyPsOMulIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g3lMTpd90X9dnjRLOuPOwhvGQ3uY32YXDCg+S7gMR14C0Bl7ZpatFy1vY8sokaXSJZsyh8MooFx4ssL13i3ABknziDDFV+LeUfg60m6Z7Bl3AD5I3ZhWHuUKccY5VMcTW9/RwfMbtRBVPYmhAL/ldMYZVa3+W0DTJyrMh7UL+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=obQgKqdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37A9C4CEE7;
	Sun, 19 Oct 2025 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760885171;
	bh=Z3Y45baxMqFHJMF4DwtO5py0EhiPScW9jUyPsOMulIM=;
	h=From:To:Cc:Subject:Date:From;
	b=obQgKqdqCSPPh8rgHLncqM+UKZ++EDam1PMddjRWgFhKfbBHwS68ZgkjR8dJvYYQT
	 NHsZHrngo22U+uYjRBs1flw+LKB/7iEsvok1uA7bKu6QIakFfH5TMJY4vjwwtkER7u
	 IrWj8paSf6c8DAYbqHlHW712RYMClMCkqmsi7oo4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.113
Date: Sun, 19 Oct 2025 16:46:06 +0200
Message-ID: <2025101907-prorate-fasting-cd8a@gregkh>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.113 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                   |    3 
 Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml |   15 
 Makefile                                                          |    2 
 arch/arm/mach-omap2/pm33xx-core.c                                 |    6 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                             |    2 
 arch/arm64/boot/dts/qcom/msm8939.dtsi                             |    2 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                              |    4 
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                         |    2 
 arch/arm64/kernel/cpufeature.c                                    |   10 
 arch/arm64/kernel/mte.c                                           |    3 
 arch/arm64/kernel/probes/kprobes.c                                |    8 
 arch/loongarch/kernel/setup.c                                     |    5 
 arch/parisc/include/uapi/asm/ioctls.h                             |    8 
 arch/parisc/lib/memcpy.c                                          |    1 
 arch/powerpc/platforms/powernv/pci-ioda.c                         |    2 
 arch/powerpc/platforms/pseries/msi.c                              |    2 
 arch/s390/net/bpf_jit.h                                           |   55 -
 arch/s390/net/bpf_jit_comp.c                                      |  161 ++-
 arch/sparc/kernel/of_device_32.c                                  |    1 
 arch/sparc/kernel/of_device_64.c                                  |    1 
 arch/sparc/mm/hugetlbpage.c                                       |   20 
 arch/x86/include/asm/msr-index.h                                  |    1 
 arch/x86/kernel/umip.c                                            |   15 
 arch/x86/kvm/pmu.c                                                |    5 
 arch/x86/kvm/svm/pmu.c                                            |    1 
 arch/x86/kvm/svm/svm.c                                            |   13 
 arch/x86/kvm/x86.c                                                |    2 
 arch/xtensa/platforms/iss/simdisk.c                               |    6 
 block/blk-crypto-fallback.c                                       |    3 
 crypto/essiv.c                                                    |   14 
 drivers/acpi/acpi_dbg.c                                           |   26 
 drivers/acpi/acpi_tad.c                                           |    3 
 drivers/acpi/acpica/evglock.c                                     |    4 
 drivers/acpi/battery.c                                            |   60 -
 drivers/acpi/property.c                                           |  137 ++-
 drivers/bus/mhi/ep/main.c                                         |   37 
 drivers/bus/mhi/host/init.c                                       |    5 
 drivers/char/ipmi/ipmi_kcs_sm.c                                   |   16 
 drivers/char/ipmi/ipmi_msghandler.c                               |  416 ++++------
 drivers/char/tpm/tpm_tis_core.c                                   |    4 
 drivers/clk/at91/clk-peripheral.c                                 |    7 
 drivers/clk/mediatek/clk-mt8195-infra_ao.c                        |    2 
 drivers/clk/mediatek/clk-mux.c                                    |    4 
 drivers/clk/nxp/clk-lpc18xx-cgu.c                                 |   20 
 drivers/clk/tegra/clk-bpmp.c                                      |    2 
 drivers/clocksource/clps711x-timer.c                              |   23 
 drivers/cpufreq/intel_pstate.c                                    |    8 
 drivers/cpufreq/tegra186-cpufreq.c                                |    8 
 drivers/crypto/aspeed/aspeed-hace-crypto.c                        |    2 
 drivers/crypto/atmel-tdes.c                                       |    2 
 drivers/crypto/rockchip/rk3288_crypto_ahash.c                     |    2 
 drivers/firmware/meson/meson_sm.c                                 |    7 
 drivers/gpio/gpio-wcd934x.c                                       |    2 
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c                |   21 
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.h                |    4 
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_d.h              |    7 
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h        |    2 
 drivers/gpu/drm/nouveau/nouveau_bo.c                              |    2 
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c                   |    5 
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi_regs.h              |    8 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                           |   17 
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c                        |    6 
 drivers/iio/adc/xilinx-ams.c                                      |   47 -
 drivers/iio/dac/ad5360.c                                          |    2 
 drivers/iio/dac/ad5421.c                                          |    2 
 drivers/iio/frequency/adf4350.c                                   |   20 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c                  |    4 
 drivers/iommu/intel/iommu.c                                       |    2 
 drivers/irqchip/irq-sifive-plic.c                                 |   13 
 drivers/mailbox/zynqmp-ipi-mailbox.c                              |    7 
 drivers/media/i2c/mt9v111.c                                       |    2 
 drivers/media/mc/mc-devnode.c                                     |    6 
 drivers/media/mc/mc-entity.c                                      |    2 
 drivers/media/pci/cx18/cx18-queue.c                               |   13 
 drivers/media/pci/ivtv/ivtv-irq.c                                 |    2 
 drivers/media/pci/ivtv/ivtv-yuv.c                                 |    8 
 drivers/media/platform/qcom/venus/firmware.c                      |    8 
 drivers/media/rc/lirc_dev.c                                       |    9 
 drivers/memory/samsung/exynos-srom.c                              |   10 
 drivers/mfd/intel_soc_pmic_chtdc_ti.c                             |    5 
 drivers/misc/fastrpc.c                                            |   37 
 drivers/mmc/core/sdio.c                                           |    6 
 drivers/mtd/nand/raw/fsmc_nand.c                                  |    6 
 drivers/net/ethernet/freescale/fsl_pq_mdio.c                      |    2 
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c                    |    2 
 drivers/net/wireless/ath/ath11k/core.c                            |    6 
 drivers/net/wireless/ath/ath11k/hal.c                             |   16 
 drivers/net/wireless/ath/ath11k/hal.h                             |    1 
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c                   |    3 
 drivers/nvme/host/pci.c                                           |    2 
 drivers/of/unittest.c                                             |    1 
 drivers/pci/controller/dwc/pci-keystone.c                         |    4 
 drivers/pci/controller/dwc/pcie-tegra194.c                        |   22 
 drivers/pci/controller/pci-tegra.c                                |   27 
 drivers/pci/controller/pcie-rcar-host.c                           |   40 
 drivers/pci/endpoint/functions/pci-epf-test.c                     |   19 
 drivers/pci/iov.c                                                 |    5 
 drivers/pci/pci-driver.c                                          |    1 
 drivers/pci/pci-sysfs.c                                           |   20 
 drivers/pci/pcie/aer.c                                            |   12 
 drivers/pci/pcie/err.c                                            |    8 
 drivers/pinctrl/samsung/pinctrl-samsung.h                         |    4 
 drivers/power/supply/max77976_charger.c                           |   12 
 drivers/pwm/pwm-berlin.c                                          |    4 
 drivers/rtc/interface.c                                           |   27 
 drivers/rtc/rtc-optee.c                                           |    1 
 drivers/rtc/rtc-x1205.c                                           |    2 
 drivers/scsi/hpsa.c                                               |   21 
 drivers/scsi/mvsas/mv_init.c                                      |    2 
 drivers/spi/spi-cadence-quadspi.c                                 |    5 
 drivers/video/fbdev/core/fb_cmdline.c                             |    2 
 drivers/xen/events/events_base.c                                  |   37 
 drivers/xen/manage.c                                              |    3 
 fs/btrfs/export.c                                                 |    8 
 fs/btrfs/extent_io.c                                              |   14 
 fs/cramfs/inode.c                                                 |   11 
 fs/ext4/fsmap.c                                                   |   14 
 fs/ext4/inode.c                                                   |   10 
 fs/ext4/move_extent.c                                             |    2 
 fs/ext4/orphan.c                                                  |   17 
 fs/ext4/xattr.c                                                   |   19 
 fs/file.c                                                         |    5 
 fs/fs-writeback.c                                                 |   32 
 fs/fsopen.c                                                       |   70 -
 fs/minix/inode.c                                                  |    8 
 fs/namei.c                                                        |    8 
 fs/namespace.c                                                    |   11 
 fs/nfsd/lockd.c                                                   |   15 
 fs/nfsd/nfs4proc.c                                                |    2 
 fs/ntfs3/bitmap.c                                                 |    1 
 fs/smb/client/smb1ops.c                                           |   62 +
 fs/smb/client/smb2inode.c                                         |   22 
 fs/smb/server/ksmbd_netlink.h                                     |    5 
 fs/smb/server/server.h                                            |    1 
 fs/smb/server/transport_ipc.c                                     |    3 
 fs/smb/server/transport_tcp.c                                     |   28 
 fs/squashfs/inode.c                                               |   24 
 include/acpi/acpixf.h                                             |    6 
 include/asm-generic/io.h                                          |   98 +-
 include/linux/iio/frequency/adf4350.h                             |    2 
 include/linux/ksm.h                                               |    6 
 include/linux/sched.h                                             |   11 
 include/media/v4l2-subdev.h                                       |   30 
 include/net/netfilter/nf_tables.h                                 |    3 
 include/net/netfilter/nft_fib.h                                   |    4 
 include/net/netfilter/nft_meta.h                                  |    3 
 include/net/netfilter/nft_reject.h                                |    3 
 init/main.c                                                       |   12 
 kernel/bpf/inode.c                                                |    4 
 kernel/fork.c                                                     |    2 
 kernel/pid.c                                                      |    2 
 kernel/rseq.c                                                     |   10 
 kernel/sched/deadline.c                                           |   73 +
 kernel/sys.c                                                      |   22 
 kernel/trace/trace_fprobe.c                                       |   11 
 kernel/trace/trace_kprobe.c                                       |   11 
 kernel/trace/trace_probe.h                                        |    9 
 kernel/trace/trace_uprobe.c                                       |   12 
 lib/crypto/Makefile                                               |    4 
 lib/genalloc.c                                                    |    5 
 mm/damon/vaddr.c                                                  |    8 
 mm/hugetlb.c                                                      |    3 
 mm/page_alloc.c                                                   |    2 
 net/bridge/br_vlan.c                                              |    2 
 net/bridge/netfilter/nft_meta_bridge.c                            |    5 
 net/bridge/netfilter/nft_reject_bridge.c                          |    3 
 net/core/filter.c                                                 |    2 
 net/ipv4/tcp.c                                                    |    5 
 net/ipv4/tcp_input.c                                              |    1 
 net/mptcp/pm.c                                                    |    7 
 net/mptcp/pm_netlink.c                                            |   52 +
 net/mptcp/protocol.h                                              |    8 
 net/netfilter/nf_tables_api.c                                     |    3 
 net/netfilter/nft_compat.c                                        |    6 
 net/netfilter/nft_fib.c                                           |    3 
 net/netfilter/nft_flow_offload.c                                  |    3 
 net/netfilter/nft_fwd_netdev.c                                    |    3 
 net/netfilter/nft_immediate.c                                     |    3 
 net/netfilter/nft_lookup.c                                        |    3 
 net/netfilter/nft_masq.c                                          |    3 
 net/netfilter/nft_meta.c                                          |    6 
 net/netfilter/nft_nat.c                                           |    3 
 net/netfilter/nft_objref.c                                        |   39 
 net/netfilter/nft_osf.c                                           |    3 
 net/netfilter/nft_queue.c                                         |    3 
 net/netfilter/nft_redir.c                                         |    3 
 net/netfilter/nft_reject.c                                        |    3 
 net/netfilter/nft_reject_inet.c                                   |    3 
 net/netfilter/nft_reject_netdev.c                                 |    3 
 net/netfilter/nft_rt.c                                            |    3 
 net/netfilter/nft_socket.c                                        |    3 
 net/netfilter/nft_synproxy.c                                      |    3 
 net/netfilter/nft_tproxy.c                                        |    3 
 net/netfilter/nft_xfrm.c                                          |    3 
 net/sctp/sm_make_chunk.c                                          |    3 
 net/sctp/sm_statefuns.c                                           |    6 
 security/keys/trusted-keys/trusted_tpm1.c                         |    7 
 sound/soc/sof/ipc4-topology.h                                     |    4 
 tools/build/feature/Makefile                                      |    4 
 tools/lib/perf/include/perf/event.h                               |    1 
 tools/perf/builtin-stat.c                                         |   18 
 tools/perf/tests/perf-record.c                                    |    4 
 tools/perf/tests/shell/stat.sh                                    |   29 
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h                 |   18 
 tools/perf/util/arm-spe.c                                         |   34 
 tools/perf/util/evsel.c                                           |   31 
 tools/perf/util/lzma.c                                            |    2 
 tools/perf/util/session.c                                         |    2 
 tools/perf/util/setup.py                                          |    5 
 tools/perf/util/zlib.c                                            |    2 
 tools/testing/selftests/mm/madv_populate.c                        |   21 
 tools/testing/selftests/mm/soft-dirty.c                           |    5 
 tools/testing/selftests/mm/vm_util.c                              |   77 +
 tools/testing/selftests/mm/vm_util.h                              |    1 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                   |   11 
 tools/testing/selftests/rseq/rseq.c                               |    8 
 216 files changed, 1920 insertions(+), 1078 deletions(-)

Aaron Kling (1):
      cpufreq: tegra186: Set target frequency for all cpus in policy

Adam Xue (1):
      bus: mhi: host: Do not use uninitialized 'dev' pointer in mhi_init_irq_setup()

Ahmet Eray Karadag (1):
      ext4: guard against EA inode refcount underflow in xattr update

Aleksa Sarai (1):
      fscontext: do not consume log entries when returning -EMSGSIZE

Alex Deucher (1):
      drm/amdgpu: Add additional DCE6 SCL registers

Alexandr Sapozhnikov (1):
      net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()

Alok Tiwari (1):
      clk: nxp: Fix pll0 rate check condition in LPC18xx CGU driver

Amir Mohammad Jahangirzad (1):
      ACPI: debug: fix signedness issues in read/write helpers

Anderson Nascimento (1):
      btrfs: avoid potential out-of-bounds in btrfs_encode_fh()

Andy Shevchenko (2):
      mfd: intel_soc_pmic_chtdc_ti: Drop unneeded assignment for cache_type
      ACPI: battery: Check for error code from devm_mutex_init() call

AngeloGioacchino Del Regno (1):
      clk: mediatek: mt8195-infra_ao: Fix parent for infra_ao_hdmi_26m

Anthony Yznaga (1):
      sparc64: fix hugetlb for sun4u

Askar Safin (1):
      openat2: don't trigger automounts with RESOLVE_NO_XDEV

Bartosz Golaszewski (1):
      gpio: wcd934x: mark the GPIO controller as sleeping

Brian Masney (2):
      clk: at91: peripheral: fix return value
      clk: nxp: lpc18xx-cgu: convert from round_rate() to determine_rate()

Brian Norris (1):
      PCI/sysfs: Ensure devices are powered for config reads

Catalin Marinas (1):
      arm64: mte: Do not flag the zero page as PG_mte_tagged

Chen-Yu Tsai (1):
      clk: mediatek: clk-mux: Do not pass flags to clk_mux_determine_rate_flags()

Clément Le Goffic (1):
      rtc: optee: fix memory leak on driver removal

Corey Minyard (2):
      Revert "ipmi: fix msg stack when IPMI is disconnected"
      ipmi: Rework user message limit handling

Dan Carpenter (1):
      net/mlx4: prevent potential use after free in mlx4_en_do_uc_filter()

Daniel Borkmann (1):
      bpf: Fix metadata_dst leak __bpf_redirect_neigh_v{4,6}

Daniel Tang (1):
      ACPI: TAD: Add missing sysfs_remove_group() for ACPI_TAD_RT

Deepanshu Kartikey (1):
      ext4: validate ea_ino and size in check_xattrs

Donet Tom (1):
      mm/ksm: fix incorrect KSM counter handling in mm_struct during fork

Duoming Zhou (1):
      scsi: mvsas: Fix use-after-free bugs in mvs_work_queue

Dzmitry Sankouski (1):
      power: supply: max77976_charger: fix constant current reporting

Edward Adam Davis (1):
      media: mc: Clear minor number before put device

Ekansh Gupta (1):
      misc: fastrpc: Add missing dev_err newlines

Eric Biggers (2):
      KEYS: trusted_tpm1: Compare HMAC values in constant time
      sctp: Fix MAC comparison to be constant-time

Eric Dumazet (1):
      tcp: take care of zero tp->window_clamp in tcp_set_rcvlowat()

Eric Woudstra (1):
      bridge: br_vlan_fill_forward_path_pvid: use br_vlan_group_rcu()

Erick Karanja (1):
      net: fsl_pq_mdio: Fix device node reference leak in fsl_pq_mdio_probe

Esben Haabendal (2):
      rtc: interface: Ensure alarm irq is enabled when UIE is enabled
      rtc: interface: Fix long-standing race when setting alarm

Fedor Pchelkin (1):
      clk: tegra: do not overallocate memory for bpmp clocks

Fernando Fernandez Mancera (1):
      netfilter: nft_objref: validate objref and objrefmap expressions

Finn Thain (1):
      fbdev: Fix logic error in "offb" name match

Florian Westphal (1):
      netfilter: nf_tables: drop unused 3rd argument from validate callback ops

Georg Gottleuber (1):
      nvme-pci: Add TUXEDO IBS Gen8 to Samsung sleep quirk

Greg Kroah-Hartman (1):
      Linux 6.6.113

Guenter Roeck (1):
      ipmi: Fix handling of messages with provided receive message pointer

Gunnar Kudrjavets (1):
      tpm_tis: Fix incorrect arguments in tpm_tis_probe_irq_single

Hans de Goede (2):
      mfd: intel_soc_pmic_chtdc_ti: Fix invalid regmap-config max_register value
      mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag

Haoxiang Li (1):
      fs/ntfs3: Fix a resource leak bug in wnd_extend()

Harini T (2):
      mailbox: zynqmp-ipi: Remove redundant mbox_controller_unregister() call
      mailbox: zynqmp-ipi: Remove dev.parent check in zynqmp_ipi_free_mboxes

Harshit Agarwal (1):
      sched/deadline: Fix race in push_dl_task()

Herbert Xu (1):
      crypto: essiv - Check ssize for decryption and in-place encryption

Hongbo Li (1):
      irqchip/sifive-plic: Make use of __assign_bit()

Huacai Chen (3):
      LoongArch: Init acpi_gbl_use_global_lock to false
      init: handle bootloader identifier in kernel parameters
      ACPICA: Allow to skip Global Lock initialization

Ian Forbes (2):
      drm/vmwgfx: Fix Use-after-free in validation
      drm/vmwgfx: Fix copy-paste typo in validation

Ian Rogers (5):
      perf evsel: Avoid container_of on a NULL leader
      libperf event: Ensure tracing data is multiple of 8 sized
      perf test: Don't leak workload gopipe in PERF_RECORD_*
      perf evsel: Ensure the fallback message is always written to
      perf test stat: Avoid hybrid assumption when virtualized

Ilya Leoshkevich (5):
      s390/bpf: Change seen_reg to a mask
      s390/bpf: Centralize frame offset calculations
      s390/bpf: Describe the frame using a struct instead of constants
      s390/bpf: Write back tail call counter for BPF_PSEUDO_CALL
      s390/bpf: Write back tail call counter for BPF_TRAMP_F_CALL_ORIG

James Clark (1):
      perf test: Add a test for default perf stat command

Jan Kara (4):
      ext4: verify orphan file size is not too big
      ext4: free orphan info with kvfree
      writeback: Avoid softlockup when switching many inodes
      writeback: Avoid excessively long inode switching times

Jason Andryuk (3):
      xen/events: Cleanup find_virq() return codes
      xen/events: Return -EEXIST for bound VIRQs
      xen/events: Update virq_to_irq on migration

Jisheng Zhang (1):
      pwm: berlin: Fix wrong register in suspend/resume

Johan Hovold (2):
      firmware: meson_sm: fix device leak at probe
      lib/genalloc: fix device leak in of_gen_pool_get()

John David Anglin (1):
      parisc: Remove spurious if statement from raw_copy_from_user()

KaFai Wan (1):
      bpf: Avoid RCU context warning when unpinning htab with internal structs

Krzysztof Kozlowski (1):
      pinctrl: samsung: Drop unused S3C24xx driver data

Kuniyuki Iwashima (1):
      tcp: Don't call reqsk_fastopen_remove() in tcp_conn_request().

Lance Yang (1):
      selftests/mm: skip soft-dirty tests when CONFIG_MEM_SOFT_DIRTY is disabled

Laurent Pinchart (1):
      media: mc: Fix MUST_CONNECT handling for pads with no links

Leo Yan (6):
      perf arm_spe: Correct setting remote access
      perf arm-spe: Rename the common data source encoding
      perf arm_spe: Correct memory level for remote access
      perf session: Fix handling when buffer exceeds 2 GiB
      tools build: Align warning options with perf
      perf python: split Clang options when invoking Popen

Li RongQing (1):
      mm/hugetlb: early exit from hugetlb_pages_alloc_boot() when max_huge_pages=0

Lichen Liu (1):
      fs: Add 'initramfs_options' to set initramfs mount options

Ling Xu (1):
      misc: fastrpc: Save actual DMA size in fastrpc_map structure

Linus Walleij (1):
      mtd: rawnand: fsmc: Default to autodetect buswidth

Lu Baolu (1):
      iommu/vt-d: PRS isn't usable if PDS isn't supported

Lucas Zampieri (1):
      irqchip/sifive-plic: Avoid interrupt ID 0 handling during suspend/resume

Lukas Wunner (3):
      xen/manage: Fix suspend error path
      PCI/ERR: Fix uevent on failure to recover
      PCI/AER: Support errors introduced by PCIe r6.0

Ma Ke (3):
      media: lirc: Fix error handling in lirc_register()
      of: unittest: Fix device reference count leak in of_unittest_pci_node_verify
      sparc: fix error handling in scan_one_device()

Marek Vasut (4):
      drm/rcar-du: dsi: Fix 1/2/3 lane support
      PCI: tegra: Convert struct tegra_msi mask_lock into raw spinlock
      PCI: rcar-host: Drop PMSR spinlock
      PCI: rcar-host: Convert struct rcar_msi mask_lock into raw spinlock

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: join: validate C-flag + def limit
      mptcp: pm: in-kernel: usable client side with C-flag

Miaoqian Lin (2):
      ARM: OMAP2+: pm33xx-core: ix device node reference leaks in amx3_idle_init
      xtensa: simdisk: add input size check in proc_write_simdisk

Michael Hennerich (2):
      iio: frequency: adf4350: Fix ADF4350_REG3_12BIT_CLKDIV_MODE
      iio: frequency: adf4350: Fix prescaler usage.

Michael Riesch (1):
      dt-bindings: phy: rockchip-inno-csi-dphy: make power-domains non-required

Muhammad Usama Anjum (1):
      wifi: ath11k: HAL SRNG: don't deinitialize and re-initialize again

Nam Cao (2):
      powerpc/powernv/pci: Fix underflow and leak issue
      powerpc/pseries/msi: Fix potential underflow and leak issue

Namhyung Kim (1):
      perf tools: Add fallback for exclude_guest

Namjae Jeon (1):
      ksmbd: add max ip connections parameter

Nathan Chancellor (1):
      lib/crypto/curve25519-hacl64: Disable KASAN with clang-17 and older

Nick Morrow (1):
      wifi: mt76: mt7921u: Add VID/PID for Netgear A7500

Niklas Cassel (1):
      PCI: tegra194: Fix broken tegra_pcie_ep_raise_msi_irq()

Niklas Schnelle (2):
      PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV
      PCI/AER: Fix missing uevent on recovery when a reset is requested

Ojaswin Mujoo (1):
      ext4: correctly handle queries for metadata mappings

Oleg Nesterov (1):
      kernel/sys.c: fix the racy usage of task_lock(tsk->group_leader) in sys_prlimit64() paths

Olga Kornievskaia (1):
      nfsd: nfserr_jukebox in nlm_fopen should lead to a retry

Pali Rohár (1):
      cifs: Query EA $LXMOD in cifs_query_path_info() for WSL reparse points

Paulo Alcantara (1):
      smb: client: fix missing timestamp updates after utime(2)

Peter Ujfalusi (1):
      ASoC: SOF: ipc4-topology: Correct the minimum host DMA buffer size

Phillip Lougher (2):
      Squashfs: add additional inode sanity checking
      Squashfs: reject negative file sizes in squashfs_read_inode()

Pratyush Yadav (2):
      spi: cadence-quadspi: Flush posted register writes before INDAC access
      spi: cadence-quadspi: Flush posted register writes before DAC access

Qianfeng Rong (3):
      media: i2c: mt9v111: fix incorrect type for ret
      iio: dac: ad5360: use int type to store negative error codes
      iio: dac: ad5421: use int type to store negative error codes

Qu Wenruo (1):
      btrfs: fix the incorrect max_bytes value for find_lock_delalloc_range()

Rafael J. Wysocki (6):
      ACPI: property: Fix buffer properties extraction for subnodes
      cpufreq: intel_pstate: Fix object lifecycle issue in update_qos_request()
      ACPI: battery: Add synchronization between interface updates
      ACPI: property: Disregard references in data-only subnode lists
      ACPI: property: Add code comments explaining what is going on
      ACPI: property: Do not pass NULL handles to acpi_attach_data()

Rex Chen (1):
      mmc: core: SPI mode remove cmd7

Rob Herring (Arm) (1):
      rtc: x1205: Fix Xicor X1205 vendor prefix

Sam James (1):
      parisc: don't reference obsolete termio struct for TC* constants

Sean Anderson (2):
      iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK
      iio: xilinx-ams: Unmask interrupts after updating alarms

Sean Christopherson (5):
      rseq/selftests: Use weak symbol reference, not definition, to link with glibc
      x86/umip: Check that the instruction opcode is at least two bytes
      x86/umip: Fix decoding of register forms of 0F 01 (SGDT and SIDT aliases)
      KVM: SVM: Skip fastpath emulation on VM-Exit if next RIP isn't valid
      KVM: SVM: Emulate PERF_CNTR_GLOBAL_STATUS_SET for PerfMonV2

Sean Nyekjaer (1):
      iio: imu: inv_icm42600: Drop redundant pm_runtime reinitialization in resume

SeongJae Park (1):
      mm/damon/vaddr: do not repeat pte_offset_map_lock() until success

Shin'ichiro Kawasaki (1):
      PCI: endpoint: pci-epf-test: Add NULL check for DMA channels before release

Shuhao Fu (1):
      drm/nouveau: fix bad ret code in nouveau_bo_move_prep

Siddharth Vadapalli (1):
      PCI: keystone: Use devm_request_irq() to free "ks-pcie-error-irq" on exit

Simon Schuster (1):
      copy_sighand: Handle architectures where sizeof(unsigned long) < sizeof(u64)

Stephan Gerhold (4):
      arm64: dts: qcom: msm8916: Add missing MDSS reset
      arm64: dts: qcom: msm8939: Add missing MDSS reset
      arm64: dts: qcom: sdm845: Fix slimbam num-channels/ees
      media: venus: firmware: Use correct reset sequence for IRIS2

Sumit Kumar (1):
      bus: mhi: ep: Fix chained transfer handling in read path

Tetsuo Handa (2):
      minixfs: Verify inode mode when loading from disk
      cramfs: Verify inode mode when loading from disk

Thadeu Lima de Souza Cascardo (1):
      mm/page_alloc: only set ALLOC_HIGHATOMIC for __GPF_HIGH allocations

Thomas Fourier (5):
      media: cx18: Add missing check after DMA map
      media: pci: ivtv: Add missing check after DMA map
      crypto: aspeed - Fix dma_unmap_sg() direction
      crypto: atmel - Fix dma_unmap_sg() direction
      crypto: rockchip - Fix dma_unmap_sg() nents value

Thomas Gleixner (1):
      rseq: Protect event mask against membarrier IPI

Thomas Weißschuh (3):
      fs: always return zero on success from replace_fd()
      ACPI: battery: allocate driver data through devm_ APIs
      ACPI: battery: initialize mutexes through devm_ APIs

Thorsten Blum (2):
      scsi: hpsa: Fix potential memory leak in hpsa_big_passthru_ioctl()
      NFSD: Fix destination buffer size in nfsd4_ssc_setup_dul()

Tiezhu Yang (1):
      LoongArch: Remove CONFIG_ACPI_TABLE_UPGRADE in platform_init()

Timur Kristóf (3):
      drm/amd/display: Add missing DCE6 SCL_HORZ_FILTER_INIT* SRIs
      drm/amd/display: Properly clear SCL_*_FILTER_CONTROL on DCE6
      drm/amd/display: Properly disable scaling on DCE6

Tomi Valkeinen (1):
      media: v4l2-subdev: Fix alloc failure check in v4l2_subdev_call_state_try()

Varad Gautam (1):
      asm-generic/io.h: Skip trace helpers if rwmmio events are disabled

Vibhore Vardhan (1):
      arm64: dts: ti: k3-am62a-main: Fix main padcfg length

Vidya Sagar (1):
      PCI: tegra194: Handle errors in BPMP response

Wang Jiang (1):
      PCI: endpoint: Remove surplus return statement from pci_epf_test_clean_dma_chan()

Yang Shi (1):
      arm64: kprobes: call set_memory_rox() for kprobe page

Yongjian Sun (1):
      ext4: increase i_disksize to offset + len in ext4_update_disksize_before_punch()

Yu Kuai (1):
      blk-crypto: fix missing blktrace bio split events

Yuan Chen (1):
      tracing: Fix race condition in kprobe initialization causing NULL pointer dereference

Yunseong Kim (1):
      perf util: Fix compression checks returning -1 as bool

Zack Rusin (1):
      drm/vmwgfx: Fix a null-ptr access in the cursor snooper

Zhang Yi (1):
      ext4: fix an off-by-one issue during moving extents

Zhen Ni (2):
      clocksource/drivers/clps711x: Fix resource leaks in error paths
      memory: samsung: exynos-srom: Fix of_iomap leak in exynos_srom_probe

gaoxiang17 (1):
      pid: Add a judgment for ns null in pid_nr_ns


