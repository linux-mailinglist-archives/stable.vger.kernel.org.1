Return-Path: <stable+bounces-230307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MDZOWm4w2litgQAu9opvQ
	(envelope-from <stable+bounces-230307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:26:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A949322E9C
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70BBC302A2DF
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BEC3B0AFB;
	Wed, 25 Mar 2026 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qTktJmxm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1903B0AE9;
	Wed, 25 Mar 2026 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433815; cv=none; b=FKS2LrlvSI4elfRICwjofEK8/TEgtE0N+YwDD1hlrS2uVal+dFeGMGCI3MSDL7T5LQFZU70AxK9MQs9YsjzjN8CK6uSoPGzM38q9WZliXJ0MIejWaTHWj+0zslLpz2p50zEHrOt+OZd5eGf6H4Cfb3UI15W4CgdjtyeAj2P79BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433815; c=relaxed/simple;
	bh=jC63L7/SdPfYenDAeB5QJtCT8KklsqCi+TqErD5w/bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jNKFbobdrkOOOkXBBzr4n1Wc+hJDEBjelKA3JvbvJo4ZTQtvk9SUyEkQUHRrygvSYp5XATH1Lz5bmBdUyNy4mQUM7DvuSqZCcEog3i/9+Ex9D6JJBSnlvSRjOWYrmkWZtuEhokGF02GbY0XpQuJt+K/kCzWfsc3P5jLb0TIy1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qTktJmxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C307C2BCB6;
	Wed, 25 Mar 2026 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774433814;
	bh=jC63L7/SdPfYenDAeB5QJtCT8KklsqCi+TqErD5w/bo=;
	h=From:To:Cc:Subject:Date:From;
	b=qTktJmxmPF7qle5bQ7rlLCqSgzRO5tWzlSvRYmyzjeG1fjvlbkvlPfVxr3voXd/Ow
	 bXFJyTiS6F12OutO6MDoQARN+bxwPPv5v2MDDBXGIywKlml+D1W02lajd9/4c4ocLF
	 7l+IrKTaVfcKsnLLfE8nCDgLHjam+c54jT6YQhVU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.19.10
Date: Wed, 25 Mar 2026 11:16:07 +0100
Message-ID: <2026032508-stifle-nemeses-098f@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230307-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A949322E9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.19.10 kernel.

All users of the 6.19 kernel series must upgrade.

The updated 6.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/netlink/specs/net_shaper.yaml                      |   12 
 Makefile                                                         |    2 
 arch/arm64/boot/dts/renesas/r8a78000.dtsi                        |   16 
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi                       |   30 -
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi                       |    4 
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi                       |    4 
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi                 |    2 
 arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi            |    1 
 arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso                |    1 
 arch/arm64/kernel/rsi.c                                          |    3 
 arch/loongarch/include/asm/uaccess.h                             |   14 
 arch/loongarch/kernel/inst.c                                     |   21 
 arch/parisc/kernel/cache.c                                       |    4 
 arch/x86/events/core.c                                           |    3 
 arch/x86/events/intel/core.c                                     |   31 -
 arch/x86/hyperv/hv_crash.c                                       |   82 +-
 arch/x86/kernel/apic/x2apic_uv_x.c                               |   18 
 arch/x86/kernel/cpu/mce/amd.c                                    |   17 
 drivers/acpi/acpi_processor.c                                    |   15 
 drivers/acpi/acpica/acpredef.h                                   |    2 
 drivers/ata/libata-core.c                                        |    3 
 drivers/ata/libata-scsi.c                                        |    2 
 drivers/base/power/runtime.c                                     |    1 
 drivers/bluetooth/btqca.c                                        |    2 
 drivers/cache/ax45mp_cache.c                                     |    4 
 drivers/cache/starfive_starlink_cache.c                          |    4 
 drivers/char/ipmi/ipmi_msghandler.c                              |  142 +++-
 drivers/crypto/atmel-sha204a.c                                   |    5 
 drivers/crypto/ccp/sev-dev.c                                     |    4 
 drivers/crypto/padlock-sha.c                                     |    7 
 drivers/firewire/net.c                                           |    5 
 drivers/firmware/arm_ffa/driver.c                                |    8 
 drivers/firmware/arm_scmi/notify.c                               |    4 
 drivers/firmware/arm_scpi.c                                      |    5 
 drivers/firmware/stratix10-svc.c                                 |  240 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c                      |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                       |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                           |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h                           |    2 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                            |   21 
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c                          |    9 
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c                          |    3 
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c                          |    3 
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c                        |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                |    4 
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c                 |    8 
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c   |    3 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                       |    4 
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c                     |    2 
 drivers/gpu/drm/drm_file.c                                       |    5 
 drivers/gpu/drm/drm_mode_config.c                                |    9 
 drivers/gpu/drm/i915/display/intel_display_power_well.c          |    2 
 drivers/gpu/drm/i915/display/intel_display_types.h               |    1 
 drivers/gpu/drm/i915/display/intel_dmc.c                         |    3 
 drivers/gpu/drm/i915/display/intel_psr.c                         |   17 
 drivers/gpu/drm/i915/display/intel_vdsc.c                        |   23 
 drivers/gpu/drm/i915/display/intel_vdsc.h                        |    3 
 drivers/gpu/drm/i915/display/intel_vdsc_regs.h                   |   12 
 drivers/gpu/drm/i915/gt/intel_engine_cs.c                        |    3 
 drivers/gpu/drm/imagination/pvr_device.c                         |   17 
 drivers/gpu/drm/imagination/pvr_power.c                          |   22 
 drivers/gpu/drm/radeon/si_dpm.c                                  |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                              |    3 
 drivers/gpu/drm/xe/xe_ggtt.c                                     |   10 
 drivers/gpu/drm/xe/xe_ggtt_types.h                               |    5 
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c                              |    2 
 drivers/gpu/drm/xe/xe_guc.c                                      |    6 
 drivers/gpu/drm/xe/xe_guc_ct.c                                   |    1 
 drivers/gpu/drm/xe/xe_guc_submit.c                               |    3 
 drivers/gpu/drm/xe/xe_oa.c                                       |    7 
 drivers/gpu/drm/xe/xe_vm_madvise.c                               |    3 
 drivers/hid/bpf/hid_bpf_dispatch.c                               |    2 
 drivers/hv/mshv_root_main.c                                      |    2 
 drivers/hwmon/max6639.c                                          |   10 
 drivers/hwmon/pmbus/ina233.c                                     |    2 
 drivers/hwmon/pmbus/isl68137.c                                   |    7 
 drivers/hwmon/pmbus/mp2869.c                                     |   35 -
 drivers/hwmon/pmbus/mp2975.c                                     |    2 
 drivers/i2c/busses/i2c-cp2615.c                                  |    3 
 drivers/i2c/busses/i2c-fsi.c                                     |    1 
 drivers/i2c/busses/i2c-pxa.c                                     |   17 
 drivers/iommu/amd/iommu.c                                        |   15 
 drivers/iommu/intel/dmar.c                                       |    3 
 drivers/iommu/intel/svm.c                                        |   12 
 drivers/iommu/iommu-sva.c                                        |   12 
 drivers/iommu/iommu.c                                            |    6 
 drivers/irqchip/irq-riscv-rpmi-sysmsi.c                          |    1 
 drivers/mmc/host/sdhci-pci-gli.c                                 |    9 
 drivers/mmc/host/sdhci.c                                         |    9 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                         |    6 
 drivers/mtd/nand/raw/cadence-nand-controller.c                   |    2 
 drivers/mtd/nand/raw/nand_base.c                                 |   14 
 drivers/mtd/nand/raw/pl35x-nand-controller.c                     |    3 
 drivers/mtd/parsers/redboot.c                                    |    6 
 drivers/mtd/spi-nor/core.c                                       |    2 
 drivers/net/bonding/bond_debugfs.c                               |   16 
 drivers/net/bonding/bond_main.c                                  |    8 
 drivers/net/dsa/bcm_sf2.c                                        |    8 
 drivers/net/ethernet/airoha/airoha_eth.c                         |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                        |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                        |    2 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c               |    2 
 drivers/net/ethernet/cadence/macb_main.c                         |   26 
 drivers/net/ethernet/cadence/macb_ptp.c                          |    4 
 drivers/net/ethernet/intel/iavf/iavf_main.c                      |    9 
 drivers/net/ethernet/intel/igc/igc.h                             |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                        |   14 
 drivers/net/ethernet/intel/igc/igc_ptp.c                         |   33 +
 drivers/net/ethernet/intel/libie/fwlog.c                         |   49 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                  |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h         |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c |   50 -
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c                |   23 
 drivers/net/ethernet/microsoft/mana/hw_channel.c                 |    6 
 drivers/net/ethernet/ti/icssg/icssg_common.c                     |    5 
 drivers/net/netconsole.c                                         |    2 
 drivers/net/netdevsim/netdev.c                                   |    5 
 drivers/net/usb/aqc111.c                                         |   12 
 drivers/net/usb/cdc_ncm.c                                        |   10 
 drivers/net/wireless/ath/ath9k/channel.c                         |    6 
 drivers/net/wireless/mediatek/mt76/scan.c                        |    4 
 drivers/net/wireless/ti/wlcore/tx.c                              |    2 
 drivers/net/wireless/virtual/mac80211_hwsim.c                    |    1 
 drivers/nfc/nxp-nci/i2c.c                                        |    4 
 drivers/nvdimm/bus.c                                             |    5 
 drivers/pmdomain/bcm/bcm2835-power.c                             |   12 
 drivers/pmdomain/mediatek/mtk-pm-domains.c                       |    2 
 drivers/resctrl/mpam_devices.c                                   |    2 
 drivers/soc/fsl/qbman/qman.c                                     |   24 
 drivers/soc/fsl/qe/qmc.c                                         |    4 
 drivers/soc/microchip/mpfs-sys-controller.c                      |   13 
 drivers/soc/rockchip/grf.c                                       |    1 
 drivers/spi/spi-amlogic-spifc-a4.c                               |   46 -
 drivers/spi/spi-amlogic-spisg.c                                  |   12 
 drivers/spi/spi.c                                                |   25 
 drivers/tee/tee_shm.c                                            |   27 
 drivers/tty/serial/8250/8250.h                                   |   25 
 drivers/tty/serial/8250/8250_dma.c                               |   15 
 drivers/tty/serial/8250/8250_dw.c                                |  296 +++++++---
 drivers/tty/serial/8250/8250_pci.c                               |   17 
 drivers/tty/serial/8250/8250_port.c                              |   75 +-
 drivers/tty/serial/serial_core.c                                 |    5 
 drivers/tty/serial/uartlite.c                                    |    1 
 drivers/tty/vt/vt.c                                              |    8 
 drivers/xen/privcmd.c                                            |   73 ++
 fs/binfmt_elf_fdpic.c                                            |    6 
 fs/btrfs/tree-checker.c                                          |    2 
 fs/btrfs/tree-log.c                                              |    6 
 fs/nfsd/export.c                                                 |   63 +-
 fs/nfsd/export.h                                                 |    7 
 fs/nfsd/nfs4xdr.c                                                |    9 
 fs/nfsd/nfsctl.c                                                 |   22 
 fs/nfsd/state.h                                                  |   17 
 fs/smb/client/cifsfs.c                                           |    7 
 fs/smb/client/cifsproto.h                                        |    1 
 fs/smb/client/connect.c                                          |    4 
 fs/smb/client/file.c                                             |   11 
 fs/smb/client/misc.c                                             |   42 +
 fs/smb/client/trace.h                                            |    2 
 fs/smb/server/smb2pdu.c                                          |   17 
 fs/tests/exec_kunit.c                                            |    3 
 include/linux/auxvec.h                                           |    2 
 include/linux/console_struct.h                                   |    1 
 include/linux/etherdevice.h                                      |    3 
 include/linux/firmware/intel/stratix10-svc-client.h              |    8 
 include/linux/if_ether.h                                         |    3 
 include/linux/io_uring_types.h                                   |    3 
 include/linux/netdevice.h                                        |    9 
 include/linux/security.h                                         |    1 
 include/linux/serial_8250.h                                      |    1 
 include/net/ip_tunnels.h                                         |   30 -
 include/net/mac80211.h                                           |    4 
 include/net/netfilter/nf_tables.h                                |    2 
 include/net/sch_generic.h                                        |   33 +
 include/net/udp_tunnel.h                                         |    2 
 io_uring/kbuf.c                                                  |   14 
 io_uring/poll.c                                                  |    9 
 kernel/crash_dump_dm_crypt.c                                     |    4 
 kernel/sched/idle.c                                              |   30 -
 kernel/trace/ring_buffer.c                                       |    2 
 kernel/trace/trace.c                                             |   36 -
 lib/bootconfig.c                                                 |    3 
 mm/huge_memory.c                                                 |    3 
 mm/rmap.c                                                        |   21 
 net/batman-adv/bat_iv_ogm.c                                      |    3 
 net/bluetooth/hci_conn.c                                         |    4 
 net/bluetooth/hci_sync.c                                         |    2 
 net/bluetooth/hidp/core.c                                        |   16 
 net/bluetooth/l2cap_core.c                                       |   51 +
 net/bluetooth/mgmt.c                                             |    7 
 net/bluetooth/smp.c                                              |    2 
 net/bridge/br_cfm.c                                              |    4 
 net/ethernet/eth.c                                               |    9 
 net/ipv4/icmp.c                                                  |    4 
 net/ipv4/ip_gre.c                                                |    3 
 net/ipv6/exthdrs.c                                               |    4 
 net/ipv6/seg6_hmac.c                                             |    2 
 net/mac80211/cfg.c                                               |   12 
 net/mac80211/chan.c                                              |    6 
 net/mac80211/debugfs.c                                           |   14 
 net/mac80211/mesh.c                                              |    3 
 net/mac80211/sta_info.c                                          |    7 
 net/mac80211/tx.c                                                |    4 
 net/mac802154/iface.c                                            |    4 
 net/mpls/af_mpls.c                                               |    1 
 net/mptcp/pm_kernel.c                                            |    2 
 net/netfilter/nf_bpf_link.c                                      |    2 
 net/netfilter/nf_conntrack_h323_asn1.c                           |    4 
 net/netfilter/nf_conntrack_netlink.c                             |   28 
 net/netfilter/nf_conntrack_proto_sctp.c                          |    3 
 net/netfilter/nf_conntrack_sip.c                                 |    6 
 net/netfilter/nf_flow_table_ip.c                                 |    1 
 net/netfilter/nf_tables_api.c                                    |    5 
 net/netfilter/nfnetlink_osf.c                                    |   13 
 net/netfilter/nft_ct.c                                           |    4 
 net/netfilter/nft_dynset.c                                       |   10 
 net/netfilter/xt_CT.c                                            |    4 
 net/netfilter/xt_time.c                                          |    4 
 net/phonet/af_phonet.c                                           |    5 
 net/rose/af_rose.c                                               |    5 
 net/sched/sch_generic.c                                          |   27 
 net/sched/sch_ingress.c                                          |   14 
 net/sched/sch_teql.c                                             |    7 
 net/shaper/shaper.c                                              |  158 +++--
 net/shaper/shaper_nl_gen.c                                       |   12 
 net/shaper/shaper_nl_gen.h                                       |    5 
 net/smc/af_smc.c                                                 |   23 
 net/smc/smc.h                                                    |    5 
 net/smc/smc_close.c                                              |    2 
 net/sunrpc/cache.c                                               |   26 
 net/unix/af_unix.c                                               |    2 
 net/unix/af_unix.h                                               |    1 
 net/unix/garbage.c                                               |   79 +-
 net/wireless/pmsr.c                                              |    1 
 security/security.c                                              |    1 
 tools/bootconfig/main.c                                          |    7 
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h              |   12 
 239 files changed, 2169 insertions(+), 1056 deletions(-)

Adam Ford (1):
      pmdomain: mediatek: Fix power domain count

AlanSong-oc (1):
      crypto: padlock-sha - Disable for Zhaoxin processor

Alessio Belle (2):
      drm/imagination: Fix deadlock in soft reset sequence
      drm/imagination: Synchronize interrupts before suspending the GPU

Alex Deucher (10):
      drm/amdgpu/gmc9.0: add bounds checking for cid
      drm/amdgpu/mmhub2.0: add bounds checking for cid
      drm/amdgpu/mmhub2.3: add bounds checking for cid
      drm/amdgpu/mmhub3.0.1: add bounds checking for cid
      drm/amdgpu/mmhub3.0.2: add bounds checking for cid
      drm/amdgpu/mmhub3.0: add bounds checking for cid
      drm/amdgpu/mmhub4.1.0: add bounds checking for cid
      drm/radeon: apply state adjust rules to some additional HAINAN vairants
      drm/amdgpu: apply state adjust rules to some additional HAINAN vairants
      drm/amdgpu: rework how we handle TLB fences

Anas Iqbal (1):
      net: dsa: bcm_sf2: fix missing clk_disable_unprepare() in error paths

Andrei Vagin (1):
      binfmt_elf_fdpic: fix AUXV size calculation for ELF_HWCAP3 and ELF_HWCAP4

Andy Nguyen (1):
      drm/amd: fix dcn 2.01 check

Antheas Kapenekakis (1):
      iommu: Fix mapping check for 0x0 to avoid re-mapping it

Ard Biesheuvel (1):
      x86/hyperv: Use __naked attribute to fix stackless C function

Ashutosh Dixit (1):
      drm/xe/oa: Allow reading after disabling OA stream

Bart Van Assche (1):
      PM: runtime: Fix a race condition related to device removal

Ben Horgan (1):
      arm_mpam: Fix null pointer dereference when restoring bandwidth counters

Benjamin Tissoires (2):
      selftests/hid: fix compilation when bpf_wq and hid_device are not exported
      HID: bpf: prevent buffer overflow in hid_hw_request

Breno Leitao (2):
      netconsole: fix sysdata_release_enabled_show checking wrong flag
      perf/x86: Move event pointer setup earlier in x86_pmu_enable()

Chen Ni (2):
      mtd: rawnand: cadence: Fix error check for dma_alloc_coherent() in cadence_nand_init()
      soc: fsl: cpm1: qmc: Fix error check for devm_ioremap_resource() in qmc_qe_init_resources()

Chris Down (1):
      mm/huge_memory: fix use of NULL folio in move_pages_huge_pmd()

Christian Eggers (3):
      Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU
      Bluetooth: LE L2CAP: Disconnect if sum of payload sizes exceed SDU
      Bluetooth: SMP: make SM/PER/KDU/BI-04-C happy

Christophe JAILLET (1):
      i2c: fsi: Fix a potential leak in fsi_i2c_probe()

Chuck Lever (2):
      NFSD: Defer sub-object cleanup in export put callbacks
      NFSD: Hold net reference for the lifetime of /proc/fs/nfs/exports fd

Claudiu Beznea (1):
      arm64: dts: renesas: rzg3s-smarc-som: Set bypass for Versa3 PLL2

Corey Minyard (2):
      ipmi: Consolidate the run to completion checking for xmit msgs lock
      ipmi:msghandler: Handle error returns from the SMI sender

Cosmin Ratiu (1):
      net/mlx5: qos: Restrict RTNL area to avoid a lock cycle

Cristian Marussi (1):
      firmware: arm_scmi: Fix NULL dereference on notify error path

Damien Le Moal (2):
      ata: libata-core: disable LPM on ADATA SU680 SSD
      ata: libata-scsi: report correct sense field pointer in ata_scsiop_maint_in()

Dan Carpenter (1):
      firmware: stratix10-svc: Delete some stray tabs

Daniel Borkmann (1):
      clsact: Fix use-after-free in init/destroy rollback asymmetry

Daniele Ceraolo Spurio (1):
      drm/xe/guc: Fail immediately on GuC load error

Dapeng Mi (1):
      perf/x86/intel: Add missing branch counters constraint apply

Dev Jain (1):
      mm/rmap: fix incorrect pte restoration for lazyfree folios

Dipayaan Roy (1):
      net: mana: fix use-after-free in mana_hwc_destroy_channel() by reordering teardown

Dmitry Baryshkov (1):
      Bluetooth: qca: fix ROM version reading on WCN3998 chips

Eric Dumazet (2):
      ip_tunnel: adapt iptunnel_xmit_stats() to NETDEV_PCPU_STAT_DSTATS
      bonding: prevent potential infinite loop in bond_header_parse()

Eric Woudstra (1):
      netfilter: nf_flow_table_ip: reset mac header before vlan push

Fabrizio Castro (1):
      arm64: dts: renesas: r9a09g057: Remove wdt{0,2,3} nodes

Fedor Pchelkin (2):
      net: macb: fix use-after-free access to PTP clock
      net: macb: fix uninitialized rx_fs_lock

Felix Fietkau (2):
      mac80211: fix crash in ieee80211_chan_bw_change for AP_VLAN stations
      wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure

Felix Gu (6):
      cache: starfive: fix device node leak in starlink_cache_init()
      cache: ax45mp: Fix device node reference leak in ax45mp_cache_init()
      firmware: arm_scpi: Fix device_node reference leak in probe path
      irqchip/riscv-rpmi-sysmsi: Fix mailbox channel leak in rpmi_sysmsi_probe()
      spi: amlogic: spifc-a4: Remove redundant clock cleanup
      spi: amlogic-spisg: Fix memory leak in aml_spisg_probe()

Filipe Manana (1):
      btrfs: log new dentries when logging parent dir of a conflicting inode

Finn Thain (1):
      mtd: Avoid boot crash in RedBoot partition table parser

Florian Westphal (2):
      netfilter: conntrack: add missing netlink policy validations
      netfilter: bpf: defer hook memory release until rcu readers are done

Gabor Juhos (1):
      i2c: pxa: defer reset on Armada 3700 when recovery is used

Geert Uytterhoeven (1):
      arm64: dts: renesas: r8a78000: Fix out-of-range SPI interrupt numbers

Greg Kroah-Hartman (1):
      Linux 6.19.10

Guanghui Feng (1):
      iommu/vt-d: Fix intel iommu iotlb sync hardlockup and retry

Guenter Roeck (3):
      crypto: ccp - Fix leaking the same page twice
      wifi: wlcore: Return -ENOMEM instead of -EAGAIN if there is not enough headroom
      hwmon: (max6639) Fix pulses-per-revolution implementation

Helge Deller (1):
      parisc: Flush correct cache in cacheflush() syscall

Hyunwoo Kim (4):
      bridge: cfm: Fix race condition in peer_mep deletion
      netfilter: ctnetlink: fix use-after-free in ctnetlink_dump_exp_ct()
      ksmbd: fix use-after-free of share_conf in compound request
      ksmbd: fix use-after-free in durable v2 replay of active file handles

Ian Forbes (1):
      drm/vmwgfx: Don't overwrite KMS surface dirty tracker

Ian Ray (1):
      NFC: nxp-nci: allow GPIOs to sleep

Ilpo Järvinen (7):
      serial: 8250: Protect LCR write in shutdown
      serial: 8250_dw: Avoid unnecessary LCR writes
      serial: 8250: Add serial8250_handle_irq_locked()
      serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling
      serial: 8250_dw: Rework IIR_NO_INT handling to stop interrupt storm
      serial: 8250: Add late synchronize_irq() to shutdown to handle DW UART BUSY
      serial: 8250_dw: Ensure BUSY is deasserted

Imre Deak (1):
      drm/i915/dmc: Fix an unlikely NULL pointer deference at probe

Ira Weiny (1):
      nvdimm/bus: Fix potential use after free in asynchronous initialization

Jakub Kicinski (2):
      net: shaper: protect late read accesses to the hierarchy
      net: shaper: protect from late creation of hierarchy

Jamal Hadi Salim (1):
      net/sched: teql: Fix double-free in teql_master_xmit

Jeff Layton (2):
      nfsd: fix heap overflow in NFSv4.0 LOCK replay cache
      sunrpc: fix cache_request leak in cache_release

Jenny Guanni Qu (3):
      netfilter: nf_conntrack_h323: fix OOB read in decode_int() CONS case
      netfilter: xt_time: use unsigned int for monthday bit shift
      netfilter: nf_conntrack_h323: check for zero length in DecodeQ931()

Jens Axboe (3):
      io_uring/poll: fix multishot recv missing EOF on wakeup race
      io_uring/kbuf: fix missing BUF_MORE for incremental buffers at EOF
      io_uring/kbuf: propagate BUF_MORE through early buffer commit path

Jesse.Zhang (1):
      drm/amdgpu: Limit BO list entry count to prevent resource exhaustion

Jianbo Liu (2):
      net/mlx5e: Prevent concurrent access to IPSec ASO context
      net/mlx5e: Fix race condition during IPSec ESN update

Jiayuan Chen (3):
      serial: core: fix infinite loop in handle_tx() for PORT_UNKNOWN
      net/rose: fix NULL pointer dereference in rose_transmit_link on reconnect
      net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()

Joe Damato (1):
      iommu/amd: Block identity domain when SNP enabled

Johan Hovold (3):
      spi: fix use-after-free on controller registration failure
      spi: fix statistics allocation
      i2c: cp2615: fix serial string NULL-deref at probe

Johannes Berg (1):
      wifi: mac80211: remove keys after disabling beaconing

Jonas Karlman (1):
      drm/bridge: dw-hdmi-qp: fix multi-channel audio output

Josh Law (2):
      lib/bootconfig: check xbc_init_node() return in override path
      tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure

Jouni Högander (5):
      drm/i915/dsc: Add Selective Update register definitions
      drm/i915/dsc: Add helper for writing DSC Selective Update ET parameters
      drm/i915/psr: Write DSC parameters on Selective Update in ET mode
      drm/i915/psr: Compute PSR entry_setup_frames into intel_crtc_state
      drm/i915/psr: Disable PSR on update_m_n and update_lrr

Juergen Gross (2):
      xen/privcmd: restrict usage in unprivileged domU
      xen/privcmd: add boot control for restricted usage in domU

Junrui Luo (1):
      bnxt_en: fix OOB access in DBG_BUF_PRODUCER async event handler

Justin Chen (1):
      net: bcmgenet: increase WoL poll timeout

Kamal Dasu (2):
      mtd: rawnand: serialize lock/unlock against other NAND operations
      mtd: rawnand: brcmnand: skip DMA during panic write

Kees Cook (1):
      fs/tests: exec: Remove bad test vector

Kevin Hao (2):
      net: macb: Introduce gem_init_rx_ring()
      net: macb: Reinitialize tx/rx queue pointer registers and rx ring during resume

Kohei Enju (1):
      igc: fix missing update of skb->tail in igc_xmit_frame()

Kuniyuki Iwashima (2):
      wifi: mac80211: Fix static_branch_dec() underflow for aql_disable.
      af_unix: Give up GC if MSG_PEEK intervened.

Kyle Meyer (1):
      x86/platform/uv: Handle deconfigured sockets

Lad Prabhakar (4):
      arm64: dts: renesas: rzt2h-n2h-evk: Add ramp delay for SD0 card regulator
      arm64: dts: renesas: rzv2-evk-cn15-sd: Add ramp delay for SD0 regulator
      arm64: dts: renesas: r9a09g077: Fix CPG register region sizes
      arm64: dts: renesas: r9a09g087: Fix CPG register region sizes

Li Xiasong (1):
      MPTCP: fix lock class name family in pm_nl_create_listen_socket

Lizhi Hou (1):
      iommu/sva: Fix crash in iommu_sva_unbind_device()

Lorenzo Bianconi (1):
      net: airoha: Remove airoha_dev_stop() in airoha_remove()

Lu Baolu (1):
      iommu/vt-d: Only handle IOPF for SVA when PRI is supported

Luiz Augusto von Dentz (3):
      Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
      Bluetooth: ISO: Fix defer tests being unstable
      Bluetooth: HIDP: Fix possible UAF

Lukas Johannes Möller (3):
      Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
      Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload length before access
      netfilter: nf_conntrack_sip: fix Content-Length u32 truncation in sip_help_tcp()

Luke Wang (1):
      mmc: sdhci: fix timing selection for 1-bit bus width

Maarten Lankhorst (1):
      drm: Fix use-after-free on framebuffers and property blobs when calling drm_dev_unplug

Maciej Andrzejewski ICEYE (1):
      serial: uartlite: fix PM runtime usage count underflow on probe

Mario Limonciello (1):
      drm/amd: Fix hang on amdgpu unload by using pci_dev_is_disconnected()

Martin Roukala (né Peres) (1):
      serial: 8250_pci: add support for the AX99100

Masami Hiramatsu (Google) (1):
      ring-buffer: Fix to update per-subbuf entries of persistent ring buffer

Matthew Brost (2):
      drm/xe: Always kill exec queues in xe_guc_submit_pause_abort
      drm/xe: Open-code GGTT MMIO access protection

Matthew Schwartz (1):
      mmc: sdhci-pci-gli: fix GL9750 DMA write corruption

Matthew Wilcox (1):
      tee: shm: Remove refcounting of kernel pages

Maíra Canal (1):
      pmdomain: bcm: bcm2835-power: Increase ASB control timeout

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix memory leak in XDP_DROP for non-zero-copy mode

Michael Grzeschik (1):
      Bluetooth: hci_sync: Fix hci_le_create_conn_sync

Michal Swiatkowski (1):
      libie: prevent memleak in fwlog code

Minhong He (1):
      ipv6: add NULL checks for idev in SRv6 paths

Miquel Raynal (1):
      mtd: spi-nor: Fix RDCR controller capability core check

Muhammad Amirul Asyraf Mohamad Jamian (1):
      firmware: stratix10-svc: Add Multi SVC clients support

Muhammad Hammad Ijaz (1):
      net: mvpp2: guard flow control update with global_tx_fc in buffer switching

Namjae Jeon (2):
      ksmbd: unset conn->binding on failed binding request
      ksmbd: use volume UUID in FS_OBJECT_ID_INFORMATION

Nicolas Cavallari (1):
      wifi: mac80211: use jiffies_delta_to_msecs() for sta_info inactive times

Nicolas Pitre (1):
      vt: save/restore unicode screen buffer for alternate screen

Nikola Z. Ivanov (1):
      net: usb: aqc111: Do not perform PM inside suspend callback

Olivier Sobrie (1):
      mtd: rawnand: pl353: make sure optimal timings are applied

Pablo Neira Ayuso (4):
      nf_tables: nft_dynset: fix possible stateful expression memleak in error path
      netfilter: nft_ct: drop pending enqueued packets on removal
      netfilter: xt_CT: drop pending enqueued packets on template removal
      netfilter: nf_tables: release flowtable after rcu grace period on error

Paulo Alcantara (1):
      smb: client: fix krb5 mount with username option

Peddolla Harshavardhan Reddy (1):
      wifi: cfg80211: cancel pmsr_free_wk in cfg80211_pmsr_wdev_down

Peng Zhang (1):
      serial: 8250: always disable IRQ during THRE test

Petr Oros (1):
      iavf: fix VLAN filter lost on add/delete race

Rafael J. Wysocki (2):
      sched: idle: Consolidate the handling of two special cases
      ACPI: processor: Fix previous acpi_processor_errata_piix4() fix

Rahul Bukte (1):
      drm/i915/gt: Check set_default_submission() before deferencing

Raul E Rangel (1):
      serial: 8250: Fix TX deadlock when using DMA

Richard Genoud (1):
      soc: fsl: qbman: fix race condition in qman_destroy_fq

Sabrina Dubroca (1):
      mpls: add missing unregister_netdevice_notifier to mpls_init

Saket Dumbre (1):
      ACPICA: Update the format of Arg3 of _DSM

Sanjay Yadav (1):
      drm/xe: Fix missing runtime PM reference in ccs_mode_store

Sanman Pradhan (4):
      hwmon: (pmbus/ina233) Add error check for pmbus_read_word_data() return value
      hwmon: (pmbus/mp2975) Add error check for pmbus_read_word_data() return value
      hwmon: (pmbus/mp2869) Check pmbus_read_byte_data() before using its return value
      hwmon: (pmbus/isl68137) Fix unchecked return value and use sysfs_emit()

Shaurya Rane (1):
      Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user

Shawn Lin (1):
      soc: rockchip: grf: Add missing of_node_put() when returning

Shyam Prasad N (1):
      cifs: open files should not hold ref on superblock

Srinivasan Shanmugam (1):
      drm/amd/display: Fix DisplayID not-found handling in parse_edid_displayid_vrr()

Stanislav Kinsburskii (1):
      mshv: Fix use-after-free in mshv_map_user_memory error path

Steven Rostedt (2):
      tracing: Fix failure to read user space from system call trace events
      tracing: Fix trace_marker copy link list updates

Suzuki K Poulose (1):
      arm64: realm: Fix PTE_NS_SHARED for 52bit PA support

Thorsten Blum (2):
      crash_dump: don't log dm-crypt key bytes in read_key_from_user_keying
      crypto: atmel-sha204a - Fix OOM ->tfm_count leak

Tiezhu Yang (3):
      LoongArch: Give more information if kmem access failed
      LoongArch: No need to flush icache if text copy failed
      LoongArch: Check return values for set_memory_{rw,rox}

Tobi Gaertner (2):
      net: usb: cdc_ncm: add ndpoffset to NDP16 nframes bounds check
      net: usb: cdc_ncm: add ndpoffset to NDP32 nframes bounds check

Varun Gupta (1):
      drm/xe: Fix memory leak in xe_vm_madvise_ioctl

Wang Tao (1):
      Bluetooth: MGMT: Fix list corruption and UAF in command complete handlers

Wei Yang (1):
      mm/huge_memory: fix early failure try_to_migrate() when split huge pmd for shared THP

Weiming Shi (2):
      nfnetlink_osf: validate individual option lengths in fingerprints
      icmp: fix NULL pointer dereference in icmp_tag_validation()

Wesley Atwell (1):
      netdevsim: drop PSP ext ref on forward failure

William Roche (1):
      x86/mce/amd: Check SMCA feature bit before accessing SMCA MSRs

Xi Ruoyao (1):
      drm/amd/display: Wrap dcn32_override_min_req_memclk() in DC_FP_{START, END}

Xiang Mei (3):
      wifi: mac80211: fix NULL deref in mesh_matches_local()
      udp_tunnel: fix NULL deref caused by udp_sock_create6 when CONFIG_IPV6=n
      net: bonding: fix NULL deref in bond_debug_rlb_hash_show

Yang Yang (1):
      batman-adv: avoid OGM aggregation when skb tailroom is insufficient

Yeoreum Yun (1):
      firmware: arm_ffa: Remove vm_id argument in ffa_rxtx_unmap()

Zdenek Bouska (1):
      igc: fix page fault in XDP TX timestamps handling

Zhanjun Dong (1):
      drm/xe/guc: Ensure CT state transitions via STOP before DISABLED

ZhengYuan Huang (1):
      btrfs: tree-checker: fix misleading root drop_level error message

Zilin Guan (1):
      soc: microchip: mpfs: Fix memory leak in mpfs_sys_controller_probe()


