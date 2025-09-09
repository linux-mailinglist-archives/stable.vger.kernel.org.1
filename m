Return-Path: <stable+bounces-179123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F23B5041F
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 19:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751AD3AE2E2
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3FD369327;
	Tue,  9 Sep 2025 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k5Y7dJoN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37A23168E4;
	Tue,  9 Sep 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437888; cv=none; b=NlwYGHY6AnZd/PfBY/Ht8KRsUZFjZN2VoiHtJz8VuXBH3/bS0hOcjl7wPwoUm0jSOZMLInqtcTTCv+ksctxfz/REH0bYusJZTtT+2tIj2YTf3yFDdTTBectjIKZ179Iux7jbAVrAg/hyGZBiynPgHfJDzXom34BOKw/RgoP3LQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437888; c=relaxed/simple;
	bh=3IyltxXHpdr6mMEL+eMQ8vnexkQupWDJZlSozBaW+ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=obu1qj52jmpgD4ssLFSIkt5Nx0I6eudn5pbpDpCoAyGotEYnhl8uUNs5WhGwEq4sw5Pva6Xjvh4YpjKeeS9R8LGZCeixfak3GewKvgqDmkLzwXwqsmnwDY0COakjqjTjuXpLzyvp4Z6dN/RDMktpXsiPNxf++0SvKam5MjQgm6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k5Y7dJoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90802C4CEF4;
	Tue,  9 Sep 2025 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757437888;
	bh=3IyltxXHpdr6mMEL+eMQ8vnexkQupWDJZlSozBaW+ZA=;
	h=From:To:Cc:Subject:Date:From;
	b=k5Y7dJoNUnFk8M6tLoIqtgA4dLmYuPIKumpNDeXF0UqoFCYAhIHlWnP/IhFhSPkOd
	 pguVRommUD2sfsLLfdVVy6kO9I1joOKmLex1hrQ8gaPxQghoR/NH5tEqrHrILRk4j0
	 xvIyyOmo/as0UQPmkrttbUG116i2V4hNKW4XmKY8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.16.6
Date: Tue,  9 Sep 2025 19:11:10 +0200
Message-ID: <2025090911-tactics-molar-588d@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.16.6 kernel.

All users of the 6.16 kernel series must upgrade.

The updated 6.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.16.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                         |    2 
 arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts          |    2 
 arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts      |    1 
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi              |    1 
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314.dts |   13 -
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts      |   13 -
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi              |   22 +
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts             |    1 
 arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts               |    1 
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts          |    2 
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi              |    2 
 arch/arm64/include/asm/module.h                                  |    1 
 arch/arm64/include/asm/module.lds.h                              |    1 
 arch/arm64/kernel/ftrace.c                                       |   13 -
 arch/arm64/kernel/module-plts.c                                  |   12 
 arch/arm64/kernel/module.c                                       |   11 
 arch/loongarch/kernel/signal.c                                   |   10 
 arch/loongarch/kernel/time.c                                     |   22 +
 arch/riscv/Kconfig                                               |    2 
 arch/riscv/include/asm/asm.h                                     |    2 
 arch/riscv/include/asm/uaccess.h                                 |    8 
 arch/riscv/kernel/entry.S                                        |    2 
 arch/riscv/kernel/kexec_elf.c                                    |    4 
 arch/riscv/kernel/kexec_image.c                                  |    2 
 arch/riscv/kernel/machine_kexec_file.c                           |    2 
 arch/riscv/net/bpf_jit_comp64.c                                  |    4 
 arch/x86/include/asm/pgtable_64_types.h                          |    3 
 arch/x86/mm/init_64.c                                            |   18 +
 drivers/accel/ivpu/ivpu_drv.c                                    |    2 
 drivers/accel/ivpu/ivpu_pm.c                                     |    4 
 drivers/accel/ivpu/ivpu_pm.h                                     |    2 
 drivers/acpi/arm64/iort.c                                        |    4 
 drivers/acpi/riscv/cppc.c                                        |    4 
 drivers/bluetooth/hci_vhci.c                                     |   57 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c                           |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c                           |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c                            |    5 
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c                            |    5 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                           |    5 
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c                           |    6 
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c            |    8 
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c             |    9 
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h             |    2 
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c             |    1 
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c        |   72 +++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h        |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c         |    1 
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h                      |    3 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                            |   11 
 drivers/gpu/drm/display/drm_dp_helper.c                          |    2 
 drivers/gpu/drm/nouveau/gv100_fence.c                            |    7 
 drivers/gpu/drm/nouveau/include/nvhw/class/clc36f.h              |   85 ++++++
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c                  |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c                 |   23 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c                 |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h                  |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c           |    1 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                     |    9 
 drivers/gpu/drm/xe/xe_bo.c                                       |    3 
 drivers/hwmon/ina238.c                                           |    9 
 drivers/hwmon/mlxreg-fan.c                                       |    5 
 drivers/isdn/mISDN/dsp_hwec.c                                    |    6 
 drivers/md/md.c                                                  |    5 
 drivers/md/raid1.c                                               |    2 
 drivers/net/dsa/mv88e6xxx/leds.c                                 |   17 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                        |    2 
 drivers/net/ethernet/cadence/macb_main.c                         |   28 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c                |   20 -
 drivers/net/ethernet/intel/e1000e/ethtool.c                      |   10 
 drivers/net/ethernet/intel/i40e/i40e_client.c                    |    4 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c                   |  123 +---------
 drivers/net/ethernet/intel/ice/ice_main.c                        |   12 
 drivers/net/ethernet/intel/ice/ice_ptp.c                         |   13 -
 drivers/net/ethernet/intel/idpf/idpf_lib.c                       |    9 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                  |   12 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c                 |    4 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                      |   10 
 drivers/net/ethernet/mellanox/mlx4/en_rx.c                       |    4 
 drivers/net/ethernet/microchip/lan865x/lan865x.c                 |    7 
 drivers/net/ethernet/oa_tc6.c                                    |    3 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                         |    2 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                |   10 
 drivers/net/ethernet/xircom/xirc2ps_cs.c                         |    2 
 drivers/net/macsec.c                                             |    8 
 drivers/net/mctp/mctp-usb.c                                      |    1 
 drivers/net/pcs/pcs-rzn1-miic.c                                  |    2 
 drivers/net/phy/mscc/mscc_ptp.c                                  |   18 -
 drivers/net/ppp/ppp_generic.c                                    |    6 
 drivers/net/usb/cdc_ncm.c                                        |    7 
 drivers/net/vxlan/vxlan_core.c                                   |   18 -
 drivers/net/vxlan/vxlan_private.h                                |    4 
 drivers/net/wireless/ath/ath11k/core.h                           |    2 
 drivers/net/wireless/ath/ath11k/mac.c                            |  111 ++++++++-
 drivers/net/wireless/ath/ath12k/wmi.c                            |    1 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c        |    6 
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                     |   25 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h                  |    8 
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c                     |    6 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                    |   22 +
 drivers/net/wireless/marvell/libertas/cfg.c                      |    9 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                  |    5 
 drivers/net/wireless/marvell/mwifiex/main.c                      |    4 
 drivers/net/wireless/mediatek/mt76/mac80211.c                    |   41 +++
 drivers/net/wireless/mediatek/mt76/mt76.h                        |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                  |   12 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                 |    5 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                 |    7 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                  |   12 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                  |   56 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                 |    5 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                  |   15 -
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h               |    1 
 drivers/net/wireless/mediatek/mt76/tx.c                          |   12 
 drivers/net/wireless/st/cw1200/sta.c                             |    2 
 drivers/of/of_numa.c                                             |    5 
 drivers/pcmcia/omap_cf.c                                         |    2 
 drivers/pcmcia/rsrc_iodyn.c                                      |    3 
 drivers/pcmcia/rsrc_nonstatic.c                                  |    4 
 drivers/platform/x86/acer-wmi.c                                  |   71 -----
 drivers/platform/x86/amd/pmc/pmc-quirks.c                        |   68 +++--
 drivers/platform/x86/amd/pmc/pmc.c                               |   13 -
 drivers/platform/x86/asus-nb-wmi.c                               |    2 
 drivers/platform/x86/asus-wmi.c                                  |    9 
 drivers/platform/x86/intel/tpmi_power_domains.c                  |    2 
 drivers/ptp/ptp_ocp.c                                            |    3 
 drivers/scsi/lpfc/lpfc_nvmet.c                                   |   10 
 drivers/scsi/sr.c                                                |   16 -
 drivers/soc/qcom/mdt_loader.c                                    |   12 
 drivers/spi/spi-fsl-lpspi.c                                      |   24 +
 drivers/spi/spi-microchip-core-qspi.c                            |   12 
 drivers/spi/spi-qpic-snand.c                                     |    6 
 drivers/tee/optee/ffa_abi.c                                      |    4 
 drivers/tee/tee_shm.c                                            |   14 -
 fs/btrfs/btrfs_inode.h                                           |    2 
 fs/btrfs/extent_io.c                                             |   17 +
 fs/btrfs/inode.c                                                 |    1 
 fs/btrfs/tree-log.c                                              |   78 ++++--
 fs/btrfs/zoned.c                                                 |   55 ++--
 fs/fs-writeback.c                                                |    9 
 fs/ocfs2/inode.c                                                 |    3 
 fs/proc/generic.c                                                |   38 +--
 fs/smb/client/cifs_unicode.c                                     |    3 
 include/linux/cpuhotplug.h                                       |    1 
 include/linux/pgalloc.h                                          |   29 ++
 include/linux/pgtable.h                                          |   25 +-
 include/linux/vmalloc.h                                          |   16 -
 include/net/sock.h                                               |   17 -
 include/uapi/linux/netfilter/nf_tables.h                         |    2 
 kernel/auditfilter.c                                             |    2 
 kernel/sched/topology.c                                          |    2 
 mm/kasan/init.c                                                  |   12 
 mm/kasan/kasan_test_c.c                                          |    2 
 mm/kmemleak.c                                                    |   27 +-
 mm/percpu.c                                                      |    6 
 mm/slub.c                                                        |   37 ++-
 mm/sparse-vmemmap.c                                              |   11 
 mm/sparse.c                                                      |   15 -
 mm/userfaultfd.c                                                 |    9 
 net/appletalk/atalk_proc.c                                       |    2 
 net/atm/resources.c                                              |    6 
 net/ax25/ax25_in.c                                               |    4 
 net/batman-adv/network-coding.c                                  |    7 
 net/bluetooth/af_bluetooth.c                                     |    2 
 net/bluetooth/hci_sync.c                                         |    2 
 net/bluetooth/l2cap_sock.c                                       |    3 
 net/bridge/br_netfilter_hooks.c                                  |    3 
 net/core/gen_estimator.c                                         |    2 
 net/core/sock.c                                                  |   33 --
 net/ipv4/devinet.c                                               |    7 
 net/ipv4/icmp.c                                                  |    6 
 net/ipv4/inet_connection_sock.c                                  |   27 --
 net/ipv4/inet_diag.c                                             |    2 
 net/ipv4/inet_hashtables.c                                       |    4 
 net/ipv4/ping.c                                                  |    2 
 net/ipv4/raw.c                                                   |    2 
 net/ipv4/tcp_ipv4.c                                              |    8 
 net/ipv4/udp.c                                                   |   16 -
 net/ipv6/datagram.c                                              |    2 
 net/ipv6/ip6_icmp.c                                              |    6 
 net/ipv6/tcp_ipv6.c                                              |   36 +-
 net/key/af_key.c                                                 |    2 
 net/llc/llc_proc.c                                               |    2 
 net/mac80211/mlme.c                                              |    8 
 net/mac80211/tests/chan-mode.c                                   |   30 ++
 net/mctp/af_mctp.c                                               |    2 
 net/mctp/route.c                                                 |   35 +-
 net/mptcp/protocol.c                                             |    1 
 net/netfilter/nf_conntrack_helper.c                              |    4 
 net/netfilter/nf_tables_api.c                                    |   42 ++-
 net/netlink/diag.c                                               |    2 
 net/packet/af_packet.c                                           |    2 
 net/packet/diag.c                                                |    2 
 net/phonet/socket.c                                              |    4 
 net/sctp/input.c                                                 |    2 
 net/sctp/proc.c                                                  |    4 
 net/sctp/socket.c                                                |    4 
 net/smc/smc_clc.c                                                |    2 
 net/smc/smc_diag.c                                               |    2 
 net/smc/smc_ib.c                                                 |    3 
 net/tipc/socket.c                                                |    2 
 net/unix/af_unix.c                                               |    2 
 net/unix/diag.c                                                  |    2 
 net/wireless/scan.c                                              |    3 
 net/wireless/sme.c                                               |    5 
 net/xdp/xsk_diag.c                                               |    2 
 rust/kernel/mm/virt.rs                                           |    1 
 scripts/Makefile.kasan                                           |   12 
 scripts/generate_rust_target.rs                                  |   12 
 sound/pci/hda/patch_hdmi.c                                       |    1 
 sound/pci/hda/patch_realtek.c                                    |    2 
 sound/pci/hda/tas2781_hda_i2c.c                                  |    5 
 sound/soc/renesas/rcar/core.c                                    |    2 
 sound/soc/soc-core.c                                             |    5 
 sound/soc/sof/intel/ptl.c                                        |    1 
 sound/usb/format.c                                               |   12 
 sound/usb/mixer_quirks.c                                         |    2 
 tools/gpio/Makefile                                              |    2 
 tools/net/ynl/pyynl/ynl_gen_c.py                                 |    2 
 tools/perf/util/bpf-event.c                                      |   39 ++-
 tools/perf/util/bpf-utils.c                                      |   61 +++-
 tools/power/cpupower/utils/cpupower-set.c                        |    4 
 tools/testing/selftests/drivers/net/hw/csum.py                   |    4 
 tools/testing/selftests/net/bind_bhash.c                         |    4 
 tools/testing/selftests/net/netfilter/conntrack_clash.sh         |    2 
 tools/testing/selftests/net/netfilter/conntrack_resize.sh        |    5 
 tools/testing/selftests/net/netfilter/nft_flowtable.sh           |  113 ++++++---
 tools/testing/selftests/net/netfilter/udpclash.c                 |    2 
 229 files changed, 1706 insertions(+), 917 deletions(-)

Aaron Erhardt (1):
      ALSA: hda/realtek: Fix headset mic for TongFang X6[AF]R5xxY

Abin Joseph (1):
      net: xilinx: axienet: Add error handling for RX metadata pointer retrieval

Ada Couprie Diaz (1):
      kasan: fix GCC mem-intrinsic prefix with sw tags

Ajye Huang (1):
      ASoC: SOF: Intel: WCL: Add the sdw_process_wakeen op

Alex Deucher (2):
      drm/amdgpu: drop hw access in non-DC audio fini
      drm/amdgpu/mes11: make MES_MISC_OP_CHANGE_CONFIG failure non-fatal

Alexandre Ghiti (2):
      riscv: Fix sparse warning in __get_user_error()
      riscv: Fix sparse warning about different address spaces

Alok Tiwari (4):
      xirc2ps_cs: fix register access when enabling FullDuplex
      bnxt_en: fix incorrect page count in RX aggr ring log
      ixgbe: fix incorrect map used in eee linkmode
      mctp: return -ENOPROTOOPT for unknown getsockopt options

Antheas Kapenekakis (1):
      platform/x86: asus-wmi: Remove extra keys from ignore_key_wlan quirk

Anup Patel (1):
      ACPI: RISC-V: Fix FFH_CPPC_CSR error handling

Armin Wolf (1):
      platform/x86: acer-wmi: Stop using ACPI bitmap for platform profile choices

Asbjørn Sloth Tønnesen (1):
      tools: ynl-gen: fix nested array counting

Aurelien Jarno (1):
      riscv: uaccess: fix __put_user_nocheck for unaligned accesses

Baptiste Lepers (1):
      rust: mm: mark VmaNew as transparent

Benjamin Berg (1):
      wifi: mac80211: do not permit 40 MHz EHT operation on 5/6 GHz

Bjorn Andersson (1):
      soc: qcom: mdt_loader: Deal with zero e_shentsize

Breno Leitao (1):
      riscv: kexec: Initialize kexec_buf struct

Chad Monroe (1):
      wifi: mt76: mt7996: use the correct vif link for scanning/roc

Chen Ni (1):
      pcmcia: omap: Add missing check for platform_get_resource

Chen-Yu Tsai (1):
      arm64: dts: rockchip: Add supplies for eMMC on rk3588-orangepi-5

Chris Packham (1):
      hwmon: (ina238) Correctly clamp temperature

Christian Loehle (1):
      sched: Fix sched_numa_find_nth_cpu() if mask offline

Christoffer Sandberg (1):
      platform/x86/amd/pmc: Add TUXEDO IB Pro Gen10 AMD to spurious 8042 quirks list

Christoph Paasch (1):
      net/tcp: Fix socket memory leak in TCP-AO failure handling for IPv6

Chukun Pan (1):
      arm64: dts: rockchip: mark eeprom as read-only for Radxa E52C

Colin Ian King (1):
      drm/amd/amdgpu: Fix missing error return on kzalloc failure

Conor Dooley (1):
      spi: microchip-core-qspi: stop checking viability of op->max_freq in supports_op callback

Cryolitia PukNgae (1):
      ALSA: usb-audio: Add mute TLV for playback volumes on some devices

Dan Carpenter (4):
      wifi: cw1200: cap SSID length in cw1200_do_join()
      wifi: libertas: cap SSID len in lbs_associate()
      wifi: cfg80211: sme: cap SSID length in __cfg80211_connect_result()
      ipv4: Fix NULL vs error pointer check in inet_blackhole_dev_init()

Dave Airlie (1):
      nouveau: fix disabling the nonstall irq due to storm code

David Arcari (1):
      platform/x86/intel: power-domains: Use topology_logical_package_id() for package ID

Dmitry Antipov (1):
      wifi: cfg80211: fix use-after-free in cmp_bss()

Duoming Zhou (2):
      wifi: brcmfmac: fix use-after-free when rescheduling brcmf_btcoex_info work
      ptp: ocp: fix use-after-free bugs causing by ptp_ocp_watchdog

Edward Adam Davis (1):
      ocfs2: prevent release journal inode after journal shutdown

Emil Tantilov (1):
      idpf: set mac type when adding and removing MAC filters

Emmanuel Grumbach (1):
      wifi: iwlwifi: if scratch is ~0U, consider it a failure

Eric Dumazet (4):
      net_sched: gen_estimator: fix est_timer() vs CONFIG_PREEMPT_RT=y
      net: remove sock_i_uid()
      net: lockless sock_i_ino()
      ax25: properly unshare skbs in ax25_kiss_rcv()

Fabian Bläse (1):
      icmp: fix icmp_ndo_send address translation for reply direction

Faith Ekstrand (1):
      nouveau: Membar before between semaphore writes and the interrupt

Felix Fietkau (7):
      wifi: mt76: prevent non-offchannel mgmt tx during scan/roc
      wifi: mt76: mt7996: disable beacons when going offchannel
      wifi: mt76: mt7996: add missing check for rx wcid entries
      wifi: mt76: mt7915: fix list corruption after hardware restart
      wifi: mt76: free pending offchannel tx frames on wcid cleanup
      wifi: mt76: fix linked list corruption
      net: ethernet: mtk_eth_soc: fix tx vlan tag for llc packets

Filipe Manana (3):
      btrfs: fix race between logging inode and checking if it was logged before
      btrfs: fix race between setting last_dir_index_offset and inode logging
      btrfs: avoid load/store tearing races when checking if an inode was logged

Florian Westphal (2):
      netfilter: nft_flowtable.sh: re-run with random mtu sizes
      selftests: netfilter: fix udpclash tool hang

Gabor Juhos (1):
      spi: spi-qpic-snand: unregister ECC engine on probe error and device remove

Gergo Koteles (2):
      ALSA: hda: tas2781: fix tas2563 EFI data endianness
      ALSA: hda: tas2781: reorder tas2563 calibration variables

Greg Kroah-Hartman (1):
      Linux 6.16.6

Gu Bowen (1):
      mm: fix possible deadlock in kmemleak

Guenter Roeck (2):
      hwmon: (ina238) Correctly clamp shunt voltage limit
      hwmon: (ina238) Correctly clamp power limits

Harry Yoo (3):
      x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings()
      mm: move page table sync declarations to linux/pgtable.h
      mm: introduce and use {pgd,p4d}_populate_kernel()

Harshit Mogalapalli (1):
      wifi: mt76: mt7925: fix locking in mt7925_change_vif_links()

Horatiu Vultur (1):
      phy: mscc: Stop taking ts_lock for tx_queue and use its own lock

Huacai Chen (1):
      LoongArch: Save LBT before FPU in setup_sigcontext()

Ian Rogers (3):
      perf bpf-event: Fix use-after-free in synthesis
      perf bpf-utils: Constify bpil_array_desc
      perf bpf-utils: Harden get_bpf_prog_info_linear

Ido Schimmel (2):
      vxlan: Fix NPD when refreshing an FDB entry with a nexthop object
      vxlan: Fix NPD in {arp,neigh}_reduce() when using nexthop objects

Imre Deak (1):
      drm/dp: Change AUX DPCD probe address from LANE0_1_STATUS to TRAINING_PATTERN_SET

Ivan Lipski (1):
      drm/amd/display: Clear the CUR_ENABLE register on DCN314 w/out DPP PG

Ivan Pravdin (1):
      Bluetooth: vhci: Prevent use-after-free by removing debugfs files early

Jacob Keller (3):
      ice: fix NULL access of tx->in_use in ice_ptp_ts_irq
      ice: fix NULL access of tx->in_use in ice_ll_ts_intr
      i40e: remove read access to debugfs files

Jakub Kicinski (1):
      selftests: drv-net: csum: fix interface name for remote host

Janusz Dziedzic (1):
      wifi: mt76: mt7921: don't disconnect when CSA to DFS chan

Jeremy Kerr (2):
      net: mctp: mctp_fraq_queue should take ownership of passed skb
      net: mctp: usb: initialise mac header in RX path

Jesse.Zhang (1):
      drm/amdgpu/sdma: bump firmware version checks for user queue support

Jiufei Xue (1):
      fs: writeback: fix use-after-free in __mark_inode_dirty()

Johannes Berg (4):
      wifi: iwlwifi: acpi: check DSM func validity
      wifi: iwlwifi: uefi: check DSM item validity
      wifi: iwlwifi: cfg: restore some 1000 series configs
      wifi: iwlwifi: cfg: add back more lost PCI IDs

Johannes Thumshirn (1):
      btrfs: zoned: skip ZONE FINISH of conventional zones

John Evans (1):
      scsi: lpfc: Fix buffer free/clear order in deferred receive path

Joonas Lahtinen (1):
      Revert "drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1"

Karol Wachowski (1):
      accel/ivpu: Prevent recovery work from being queued during device removal

Kuninori Morimoto (2):
      ASoC: soc-core: care NULL dirver name on snd_soc_lookup_component_nolocked()
      ASoC: rsnd: tidyup direction name on rsnd_dai_connect()

Kuniyuki Iwashima (2):
      Bluetooth: Fix use-after-free in l2cap_sock_cleanup_listen()
      selftest: net: Fix weird setsockopt() in bind_bhash.c.

Lad Prabhakar (1):
      net: pcs: rzn1-miic: Correct MODCTRL register offset

Larisa Grigore (4):
      spi: spi-fsl-lpspi: Fix transmissions when using CONT
      spi: spi-fsl-lpspi: Set correct chip-select polarity bit
      spi: spi-fsl-lpspi: Reset FIFO and disable module on transfer abort
      spi: spi-fsl-lpspi: Clear status register after disabling the module

Li Nan (1):
      md: prevent incorrect update of resync/recovery offset

Li Qiong (1):
      mm/slub: avoid accessing metadata when pointer is invalid in object_err()

Liu Jian (1):
      net/smc: fix one NULL pointer dereference in smc_ib_is_sg_need_sync()

Lubomir Rintel (1):
      cdc_ncm: Flag Intel OEM version of Fibocom L850-GL as WWAN

Ma Ke (1):
      pcmcia: Fix a NULL pointer dereference in __iodyn_find_io_region()

Mahanta Jambigi (1):
      net/smc: Remove validation of reserved bits in CLC Decline message

Makar Semyonov (1):
      cifs: prevent NULL pointer dereference in UTF16 conversion

Marek Vasut (2):
      arm64: dts: imx8mp: Fix missing microSD slot vqmmc on DH electronics i.MX8M Plus DHCOM
      arm64: dts: imx8mp: Fix missing microSD slot vqmmc on Data Modul i.MX8M Plus eDM SBC

Mario Limonciello (1):
      platform/x86/amd: pmc: Drop SMU F/W match for Cezanne

Markus Niebel (1):
      arm64: dts: imx8mp-tqma8mpql: fix LDO5 power off

Maud Spierings (1):
      arm64: dts: rockchip: Fix the headphone detection on the orangepi 5 plus

Miaoqian Lin (4):
      mISDN: Fix memory leak in dsp_hwec_enable()
      eth: mlx4: Fix IS_ERR() vs NULL check bug in mlx4_en_create_rx_ring
      ACPI/IORT: Fix memory leak in iort_rmr_alloc_sids()
      net: dsa: mv88e6xxx: Fix fwnode reference leaks in mv88e6xxx_port_setup_leds

Michael Walle (1):
      drm/bridge: ti-sn65dsi86: fix REFCLK setting

Miguel Ojeda (1):
      rust: support Rust >= 1.91.0 target spec

Ming Lei (1):
      scsi: sr: Reinstate rotational media flag

Ming Yen Hsieh (3):
      wifi: mt76: mt7925u: use connac3 tx aggr check in tx complete
      wifi: mt76: mt7925: fix the wrong bss cleanup for SAP
      wifi: mt76: mt7925: skip EHT MLD TLV on non-MLD and pass conn_state for sta_cmd

Nathan Chancellor (2):
      wifi: mt76: mt7996: Initialize hdr before passing to skb_put_data()
      riscv: Only allow LTO with CMODEL_MEDANY

Nishanth Menon (1):
      net: ethernet: ti: am65-cpsw-nuss: Fix null pointer dereference for ndev

Pei Xiao (2):
      tee: fix NULL pointer dereference in tee_shm_put
      tee: fix memory leak in tee_dyn_shm_alloc_helper

Peter Robinson (1):
      arm64: dts: rockchip: Add vcc-supply to SPI flash on rk3399-pinebook-pro

Phil Sutter (2):
      netfilter: conntrack: helper: Replace -EEXIST by -EBUSY
      netfilter: nf_tables: Introduce NFTA_DEVICE_PREFIX

Piotr Zalewski (1):
      drm/rockchip: vop2: make vp registers nonvolatile

Qianfeng Rong (1):
      wifi: mwifiex: Initialize the chan_stats array to zero

Qingfang Deng (1):
      ppp: fix memory leak in pad_compress_skb

Qu Wenruo (1):
      btrfs: clear block dirty if submit_one_sector() failed

Radim Krčmář (4):
      riscv: use lw when reading int cpu in new_vmalloc_check
      riscv: use lw when reading int cpu in asm_per_cpu
      riscv, bpf: use lw when reading int cpu in BPF_MOV64_PERCPU_REG
      riscv, bpf: use lw when reading int cpu in bpf_get_smp_processor_id

Rameshkumar Sundaram (1):
      wifi: ath11k: fix group data packet drops during rekey

Ramya Gnanasekar (1):
      wifi: ath12k: Set EMLSR support flag in MLO flags for EML-capable stations

Rosen Penev (2):
      net: thunder_bgx: add a missing of_node_put
      net: thunder_bgx: decrement cleanup index before use

Ryan Wanner (1):
      ARM: dts: microchip: sama7d65: Force SDMMC Legacy mode

Sabrina Dubroca (1):
      macsec: read MACSEC_SA_ATTR_PN with nla_get_uint

Sasha Levin (1):
      mm/userfaultfd: fix kmap_local LIFO ordering for CONFIG_HIGHPTE

Sean Anderson (1):
      net: macb: Fix tx_ptr_lock locking

Shinji Nomoto (1):
      cpupower: Fix a bug where the -t option of the set subcommand was not working.

Stanislav Fort (2):
      audit: fix out-of-bounds read in audit_compare_dname_path()
      batman-adv: fix OOB read/write in network-coding decode

Stefan Wahren (3):
      net: ethernet: oa_tc6: Handle failure of spi_setup
      microchip: lan865x: Fix module autoloading
      microchip: lan865x: Fix LAN8651 autoloading

Sumanth Korikkar (1):
      mm: fix accounting of memmap pages

Sungbae Yoo (1):
      tee: optee: ffa: fix a typo of "optee_ffa_api_is_compatible"

Takashi Iwai (2):
      ALSA: hda/hdmi: Add pin fix for another HP EliteDesk 800 G4 model
      platform/x86: asus-wmi: Fix racy registrations

Thomas Hellström (1):
      drm/xe: Fix incorrect migration of backed-up object to VRAM

Timur Kristóf (1):
      drm/amd/display: Don't warn when missing DCE encoder caps

Tina Wuest (1):
      ALSA: usb-audio: Allow Focusrite devices to use low samplerates

Vadim Pasternak (1):
      hwmon: mlxreg-fan: Prevent fans from getting stuck at 0 RPM

Ville Syrjälä (1):
      drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1

Vitaly Lifshits (1):
      e1000e: fix heap overflow in e1000_set_eeprom

Wang Liang (2):
      netfilter: br_netfilter: do not check confirmed bit in br_nf_local_in() after confirm
      net: atm: fix memory leak in atm_register_sysfs when device_register fail

Wentao Liang (1):
      pcmcia: Add error handling for add_interval() in do_validate_mem()

Xianglai Li (1):
      LoongArch: Add cpuhotplug hooks to fix high cpu usage of vCPU threads

Yang Li (1):
      Bluetooth: hci_sync: Avoid adding default advertising on startup

Yeoreum Yun (1):
      kunit: kasan_test: disable fortify string checker on kasan_strings() test

Yin Tirui (1):
      of_numa: fix uninitialized memory nodes causing kernel panic

Yu Kuai (1):
      md/raid1: fix data lost for writemostly rdev

Zhen Ni (1):
      i40e: Fix potential invalid access when MAC list is empty

panfan (1):
      arm64: ftrace: fix unreachable PLT for ftrace_caller in init_module with CONFIG_DYNAMIC_FTRACE

wangzijie (1):
      proc: fix missing pde_set_flags() for net proc files

yangshiguang (1):
      mm: slub: avoid wake up kswapd in set_track_prepare

zhang jiao (1):
      tools: gpio: remove the include directory on make clean


