Return-Path: <stable+bounces-225356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGIgNiU9tGmDjQAAu9opvQ
	(envelope-from <stable+bounces-225356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:36:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B332287227
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCC093008C3B
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0BB3B27C7;
	Fri, 13 Mar 2026 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RNjKymoB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454503C6A4B;
	Fri, 13 Mar 2026 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419809; cv=none; b=CmhYzeiMolhNBIJAucHG2MsBfUjumPHzK6WiAO55DZ2CsqaP16S1kPQp+yn5XQiqiCDUi/TQ1wNV47QeAt+JsgbaXzg9MXPV5YpiEX/oWVG52PEC8kgpHadXGPckuEarvBnfI6HwiiLoPzb1C+SziqlOOzyzgjLwTxJKSa6vY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419809; c=relaxed/simple;
	bh=sIEoghhxyCdHpP/iTYLwleNcBx3P+gNGw3kqG3X9wNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NdcVmlEuuSKuehMmjZ6yp2+buF1muvNWWElOEPsDqu/k37Yo5UBfbd3OkcZ9bONsc0IBssqqrKFESCHDST3iSKWGQZn0SkbSz9BJpRz3DNb1vsZzukuZ/LTZvZwc8dCA/M5ohWeGXPX1hgAXT8w8OM64puGeI7SyKmD0lWDNo/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RNjKymoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457CBC19421;
	Fri, 13 Mar 2026 16:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773419808;
	bh=sIEoghhxyCdHpP/iTYLwleNcBx3P+gNGw3kqG3X9wNs=;
	h=From:To:Cc:Subject:Date:From;
	b=RNjKymoBAKRuUhudrwDlOMpfJXXINK2m3ru6K0Vkkyaoa8IWQm/heLbShJ6UGcbuF
	 c9UYjc1NDuc4oWfTEPQ/Tm5jawlOlXvnxG9HkVMMquG0VccUoqT+vfGIVU3HhvpnXJ
	 08aJY+vvQOPONaldbf6qtPy+aJkSdEbB48McNO4w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.77
Date: Fri, 13 Mar 2026 17:36:41 +0100
Message-ID: <2026031342-activism-situation-e01c@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225356-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.908];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 7B332287227
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.12.77 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/hwmon/aht10.rst                                      |   10 
 Makefile                                                           |    2 
 arch/Kconfig                                                       |    1 
 arch/arm/include/asm/string.h                                      |   14 
 arch/arm64/boot/dts/rockchip/rk3568.dtsi                           |    4 
 arch/arm64/boot/dts/rockchip/rk356x.dtsi                           |    2 
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                      |    4 
 arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi                     |    6 
 arch/arm64/kvm/sys_regs.c                                          |    3 
 arch/arm64/net/bpf_jit_comp.c                                      |    2 
 arch/loongarch/include/asm/setup.h                                 |    3 
 arch/loongarch/kernel/unwind_orc.c                                 |   32 
 arch/loongarch/kernel/unwind_prologue.c                            |    4 
 arch/loongarch/mm/tlb.c                                            |    1 
 arch/s390/include/asm/idle.h                                       |    1 
 arch/s390/kernel/idle.c                                            |   13 
 arch/s390/kernel/irq.c                                             |   10 
 arch/s390/kernel/vtime.c                                           |   18 
 arch/x86/entry/entry_fred.c                                        |    5 
 arch/x86/include/asm/efi.h                                         |    2 
 arch/x86/kernel/acpi/boot.c                                        |   12 
 arch/x86/kernel/cpu/topology.c                                     |   15 
 arch/x86/kvm/x86.c                                                 |    3 
 arch/x86/platform/efi/efi.c                                        |    2 
 arch/x86/platform/efi/quirks.c                                     |   55 
 drivers/acpi/apei/Makefile                                         |    4 
 drivers/ata/libata-core.c                                          |   18 
 drivers/ata/libata-eh.c                                            |   31 
 drivers/ata/libata-scsi.c                                          |  544 +++++--
 drivers/ata/libata.h                                               |   14 
 drivers/block/drbd/drbd_actlog.c                                   |   53 
 drivers/block/drbd/drbd_interval.h                                 |    5 
 drivers/block/drbd/drbd_req.c                                      |    3 
 drivers/clk/tegra/clk-tegra124-emc.c                               |    2 
 drivers/firmware/efi/mokvar-table.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c                            |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                         |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c                         |   32 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                           |   61 
 drivers/gpu/drm/logicvc/logicvc_drm.c                              |    4 
 drivers/gpu/drm/scheduler/sched_main.c                             |    1 
 drivers/gpu/drm/solomon/ssd130x.c                                  |    6 
 drivers/gpu/drm/tegra/dsi.c                                        |    6 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                            |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c                         |    9 
 drivers/gpu/drm/xe/xe_reg_sr.c                                     |    4 
 drivers/gpu/drm/xe/xe_ring_ops.c                                   |    9 
 drivers/hid/hid-cmedia.c                                           |    2 
 drivers/hid/hid-creative-sb0540.c                                  |    2 
 drivers/hid/hid-ids.h                                              |    1 
 drivers/hid/hid-multitouch.c                                       |   83 +
 drivers/hid/hid-zydacron.c                                         |    2 
 drivers/hwmon/Kconfig                                              |    6 
 drivers/hwmon/aht10.c                                              |   21 
 drivers/hwmon/it87.c                                               |    5 
 drivers/hwmon/max16065.c                                           |   26 
 drivers/hwmon/max6639.c                                            |   83 -
 drivers/i2c/busses/i2c-i801.c                                      |   14 
 drivers/infiniband/hw/irdma/verbs.c                                |    2 
 drivers/infiniband/hw/mthca/mthca_provider.c                       |    5 
 drivers/input/mouse/synaptics_i2c.c                                |   13 
 drivers/iommu/intel/pasid.c                                        |    8 
 drivers/irqchip/irq-sifive-plic.c                                  |    7 
 drivers/mailbox/mailbox.c                                          |  132 -
 drivers/media/dvb-core/dmxdev.c                                    |    4 
 drivers/media/i2c/Kconfig                                          |    2 
 drivers/media/i2c/dw9714.c                                         |   56 
 drivers/memory/mtk-smi.c                                           |    3 
 drivers/net/arcnet/com20020-pci.c                                  |   16 
 drivers/net/bonding/bond_main.c                                    |    9 
 drivers/net/bonding/bond_options.c                                 |    2 
 drivers/net/can/spi/mcp251x.c                                      |   15 
 drivers/net/can/usb/ems_usb.c                                      |    7 
 drivers/net/can/usb/etas_es58x/es58x_core.c                        |    8 
 drivers/net/can/usb/f81604.c                                       |   45 
 drivers/net/can/usb/ucan.c                                         |    2 
 drivers/net/dsa/realtek/rtl8365mb.c                                |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-common.h                        |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                           |   10 
 drivers/net/ethernet/amd/xgbe/xgbe-main.c                          |    1 
 drivers/net/ethernet/amd/xgbe/xgbe.h                               |    3 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c                |    3 
 drivers/net/ethernet/intel/e1000e/defines.h                        |    1 
 drivers/net/ethernet/intel/e1000e/ich8lan.c                        |    9 
 drivers/net/ethernet/intel/i40e/i40e_main.c                        |   41 
 drivers/net/ethernet/intel/i40e/i40e_trace.h                       |    2 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                        |    5 
 drivers/net/ethernet/intel/iavf/iavf_main.c                        |   17 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                        |    2 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c                |   40 
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c                  |   27 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c          |   38 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c            |   28 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                        |   15 
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c               |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                  |   18 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                           |    2 
 drivers/net/ethernet/ti/cpsw_ale.c                                 |    9 
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                       |    8 
 drivers/net/usb/kalmia.c                                           |    7 
 drivers/net/usb/kaweth.c                                           |   13 
 drivers/net/usb/pegasus.c                                          |   13 
 drivers/net/vxlan/vxlan_core.c                                     |    5 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c               |    1 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                    |    1 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                    |    1 
 drivers/net/wireless/rsi/rsi_91x_mac80211.c                        |    2 
 drivers/net/wireless/st/cw1200/pm.c                                |    2 
 drivers/net/wireless/ti/wlcore/main.c                              |    4 
 drivers/nfc/pn533/usb.c                                            |    1 
 drivers/nvme/host/core.c                                           |    7 
 drivers/nvme/host/pr.c                                             |   10 
 drivers/of/kexec.c                                                 |   15 
 drivers/pci/controller/dwc/pcie-designware-ep.c                    |   38 
 drivers/pci/endpoint/pci-epc-core.c                                |  182 +-
 drivers/pci/probe.c                                                |    6 
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c                           |    5 
 drivers/pinctrl/pinctrl-equilibrium.c                              |   31 
 drivers/platform/x86/dell/dell-wmi-base.c                          |    6 
 drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c |    1 
 drivers/platform/x86/thinkpad_acpi.c                               |    6 
 drivers/scsi/lpfc/lpfc_init.c                                      |    2 
 drivers/scsi/lpfc/lpfc_sli.c                                       |   36 
 drivers/scsi/lpfc/lpfc_sli4.h                                      |    3 
 drivers/scsi/pm8001/pm8001_sas.c                                   |    5 
 drivers/scsi/scsi_scan.c                                           |    1 
 drivers/staging/media/tegra-video/vi.c                             |   13 
 drivers/target/target_core_configfs.c                              |   15 
 drivers/ufs/core/ufshcd.c                                          |   18 
 drivers/usb/cdns3/core.c                                           |   11 
 drivers/xen/xen-acpi-processor.c                                   |    7 
 fs/btrfs/block-group.c                                             |   43 
 fs/btrfs/direct-io.c                                               |   16 
 fs/btrfs/disk-io.c                                                 |    6 
 fs/btrfs/inode.c                                                   |    2 
 fs/btrfs/misc.h                                                    |    7 
 fs/btrfs/scrub.c                                                   |    2 
 fs/btrfs/space-info.c                                              |   22 
 fs/btrfs/tree-checker.c                                            |    4 
 fs/btrfs/zoned.c                                                   |  271 +++
 fs/eventpoll.c                                                     |    5 
 fs/ext4/ext4.h                                                     |   43 
 fs/ext4/extents.c                                                  |   20 
 fs/ext4/mballoc-test.c                                             |    4 
 fs/ext4/mballoc.c                                                  |  718 +++++-----
 fs/ext4/mballoc.h                                                  |    9 
 fs/namespace.c                                                     |   20 
 fs/nfsd/nfsctl.c                                                   |    2 
 fs/smb/client/connect.c                                            |    1 
 fs/smb/client/smb2inode.c                                          |    4 
 fs/smb/client/smb2pdu.c                                            |   24 
 fs/smb/client/transport.c                                          |   21 
 fs/smb/server/mgmt/user_session.c                                  |    5 
 fs/smb/server/mgmt/user_session.h                                  |    1 
 fs/smb/server/smb2pdu.c                                            |   21 
 fs/squashfs/cache.c                                                |    3 
 fs/xattr.c                                                         |   35 
 include/linux/ima.h                                                |    4 
 include/linux/indirect_call_wrapper.h                              |   18 
 include/linux/ioport.h                                             |   32 
 include/linux/kexec.h                                              |    6 
 include/linux/libata.h                                             |    4 
 include/linux/mailbox_client.h                                     |    2 
 include/linux/mailbox_controller.h                                 |    9 
 include/linux/pci-epc.h                                            |   38 
 include/linux/platform_data/max6639.h                              |   15 
 include/linux/ring_buffer.h                                        |    1 
 include/linux/workqueue.h                                          |    8 
 include/net/act_api.h                                              |    1 
 include/net/bonding.h                                              |    1 
 include/net/ip_fib.h                                               |    2 
 include/net/netfilter/nf_tables.h                                  |    5 
 include/net/sch_generic.h                                          |   10 
 include/net/tc_act/tc_ife.h                                        |    4 
 include/net/xdp_sock_drv.h                                         |   24 
 include/net/xsk_buff_pool.h                                        |    3 
 include/uapi/linux/pci_regs.h                                      |    2 
 kernel/bpf/devmap.c                                                |   22 
 kernel/bpf/trampoline.c                                            |    4 
 kernel/cgroup/cpuset.c                                             |    2 
 kernel/events/core.c                                               |   42 
 kernel/events/uprobes.c                                            |   38 
 kernel/kexec_core.c                                                |   54 
 kernel/rseq.c                                                      |    5 
 kernel/trace/ring_buffer.c                                         |   21 
 kernel/trace/trace.c                                               |   13 
 kernel/trace/trace_events_trigger.c                                |    3 
 kernel/workqueue.c                                                 |   13 
 net/atm/lec.c                                                      |   26 
 net/bridge/br_device.c                                             |    2 
 net/bridge/br_input.c                                              |    2 
 net/can/bcm.c                                                      |    1 
 net/core/filter.c                                                  |    6 
 net/ipv4/sysctl_net_ipv4.c                                         |    5 
 net/ipv6/route.c                                                   |   11 
 net/mac80211/mesh.c                                                |    3 
 net/mac80211/mlme.c                                                |    3 
 net/netfilter/nf_tables_api.c                                      |    5 
 net/netfilter/nft_set_pipapo.c                                     |   51 
 net/netfilter/nft_set_pipapo.h                                     |    2 
 net/nfc/nci/core.c                                                 |   21 
 net/nfc/nci/data.c                                                 |   12 
 net/nfc/rawsock.c                                                  |   11 
 net/rds/tcp.c                                                      |   14 
 net/sched/act_ct.c                                                 |    6 
 net/sched/act_ife.c                                                |   93 -
 net/sched/cls_api.c                                                |    7 
 net/sched/sch_ets.c                                                |   12 
 net/sched/sch_fq.c                                                 |    1 
 net/wireless/core.c                                                |    1 
 net/wireless/radiotap.c                                            |    4 
 net/xdp/xsk.c                                                      |   28 
 net/xdp/xsk_buff_pool.c                                            |   15 
 rust/kernel/kunit.rs                                               |    8 
 security/apparmor/apparmorfs.c                                     |  225 +--
 security/apparmor/include/label.h                                  |   16 
 security/apparmor/include/lib.h                                    |   12 
 security/apparmor/include/match.h                                  |    1 
 security/apparmor/include/policy.h                                 |   10 
 security/apparmor/include/policy_ns.h                              |    2 
 security/apparmor/include/policy_unpack.h                          |   75 -
 security/apparmor/label.c                                          |   12 
 security/apparmor/match.c                                          |   58 
 security/apparmor/policy.c                                         |   77 -
 security/apparmor/policy_ns.c                                      |    2 
 security/apparmor/policy_unpack.c                                  |   49 
 security/integrity/ima/ima_kexec.c                                 |  148 +-
 sound/pci/hda/cs35l56_hda.c                                        |   14 
 sound/pci/hda/patch_conexant.c                                     |   11 
 sound/pci/hda/patch_realtek.c                                      |    2 
 sound/usb/endpoint.c                                               |    9 
 sound/usb/mixer_scarlett2.c                                        |   14 
 sound/usb/quirks.c                                                 |    2 
 sound/usb/validate.c                                               |    2 
 tools/testing/kunit/kunit_kernel.py                                |    6 
 tools/testing/kunit/kunit_tool_test.py                             |   26 
 tools/testing/selftests/arm64/abi/hwcap.c                          |    4 
 tools/testing/selftests/kselftest_harness.h                        |   15 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                    |   13 
 tools/testing/selftests/net/mptcp/simult_flows.sh                  |   11 
 240 files changed, 3622 insertions(+), 1634 deletions(-)

Akhilesh Patil (1):
      hwmon: (aht10) Add support for dht20

Al Viro (1):
      xattr: switch to CLASS(fd)

Alban Bedel (1):
      can: mcp251x: fix deadlock in error path of mcp251x_open

Alexandre Courbot (1):
      rust: kunit: fix warning when !CONFIG_PRINTK

Allison Henderson (1):
      net/rds: Fix circular locking dependency in rds_tcp_tune

Andrew Cooper (1):
      x86/fred: Correct speculative safety in fred_extint()

Andrii Nakryiko (1):
      uprobes: switch to RCU Tasks Trace flavor for better performance

Anup Patel (1):
      mailbox: Allow controller specific mapping using fwnode

Ariel Silver (1):
      wifi: mac80211: bounds-check link_id in ieee80211_ml_reconfiguration

Baokun Li (8):
      ext4: add ext4_try_lock_group() to skip busy groups
      ext4: factor out __ext4_mb_scan_group()
      ext4: factor out ext4_mb_might_prefetch()
      ext4: factor out ext4_mb_scan_group()
      ext4: convert free groups order lists to xarrays
      ext4: refactor choose group to scan group
      ext4: implement linear-like traversal across order xarrays
      ext4: fix potential null deref in ext4_mb_init()

Bart Van Assche (5):
      drm/amdgpu: Unlock a mutex before destroying it
      drm/amdgpu: Fix locking bugs in error paths
      hwmon: (it87) Check the it87_lock() return value
      wifi: cw1200: Fix locking in error paths
      wifi: wlcore: Fix a locking bug

Bjorn Helgaas (1):
      PCI: Correct PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 value

Brad Spengler (1):
      drm/vmwgfx: Fix invalid kref_put callback in vmw_bo_dirty_release

Breno Leitao (2):
      ima: kexec: silence RCU list traversal warning
      uprobes: Fix incorrect lockdep condition in filter_chain()

Brian Howard (1):
      HID: multitouch: add quirks for Lenovo Yoga Book 9i

Brian Vazquez (1):
      idpf: change IRQ naming to match netdev and ethtool queue numbering

Charles Haithcock (1):
      i2c: i801: Revert "i2c: i801: replace acpi_lock with I2C bus lock"

Chintan Vankar (1):
      net: ethernet: ti: am65-cpsw-nuss/cpsw-ale: Fix multicast entry handling in ALE table

Christian Brauner (1):
      namespace: fix proc mount iteration

Christoph Böhmwalder (1):
      drbd: fix null-pointer dereference on local read error

Damien Le Moal (13):
      PCI: endpoint: Introduce pci_epc_function_is_valid()
      PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
      PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation
      ata: libata-scsi: Refactor ata_scsi_simulate()
      ata: libata-scsi: Refactor ata_scsiop_read_cap()
      ata: libata-scsi: Refactor ata_scsiop_maint_in()
      ata: libata-scsi: Document all VPD page inquiry actors
      ata: libata-scsi: Remove struct ata_scsi_args
      ata: libata: Remove ATA_DFLAG_ZAC device flag
      ata: libata: Introduce ata_port_eh_scheduled()
      ata: libata-scsi: avoid Non-NCQ command starvation
      ata: libata-core: fix cancellation of a port deferred qc work
      ata: libata-eh: correctly handle deferred qc timeouts

Daniil Dulov (1):
      wifi: cfg80211: cancel rfkill_block work in wiphy_unregister()

David Sterba (1):
      btrfs: drop unused parameter fs_info from do_reclaim_sweep()

David Thomson (1):
      xen/acpi-processor: fix _CST detection using undersized evaluation buffer

Davide Caratti (1):
      net/sched: ets: fix divide by zero in the offload path

Eric Dumazet (2):
      indirect_call_wrapper: do not reevaluate function pointer
      net_sched: sch_fq: clear q->band_pkt_count[] in fq_reset()

Eric Naim (1):
      ALSA: hda/realtek: Add quirk for Gigabyte G5 KF5 (2023)

Ethan Nelson-Moore (1):
      net: arcnet: com20020-pci: fix support for 2.5Mbit cards

Felix Gu (2):
      drm/logicvc: Fix device node reference leak in logicvc_drm_config_parse()
      pinctrl: cirrus: cs42l43: Fix double-put in cs42l43_pin_probe()

Fernando Fernandez Mancera (2):
      net: bridge: fix nd_tbl NULL dereference when IPv6 is disabled
      net: vxlan: fix nd_tbl NULL dereference when IPv6 is disabled

Filipe Manana (2):
      btrfs: get used bytes while holding lock at btrfs_reclaim_bgs_work()
      btrfs: fix reclaimed bytes accounting after automatic block group reclaim

Florian Eckert (2):
      pinctrl: equilibrium: rename irq_chip function callbacks
      pinctrl: equilibrium: fix warning trace on load

Florian Westphal (1):
      netfilter: nft_set_pipapo: split gc into unlink and reclaim phase

Francesco Lavra (1):
      drm/solomon: Fix page start when updating rectangle in page addressing mode

Fuad Tabba (2):
      KVM: arm64: Hide S1POE from guests when not supported by the host
      bpf, arm64: Force 8-byte alignment for JIT buffer to prevent atomic tearing

Geoffrey D. Bennett (3):
      ALSA: scarlett2: Fix redeclaration of loop variable
      ALSA: scarlett2: Fix DSP filter control array handling
      ALSA: usb-audio: Remove VALIDATE_RATES quirk for Focusrite devices

Greg Kroah-Hartman (12):
      nfc: pn533: properly drop the usb interface reference on disconnect
      net: usb: kaweth: validate USB endpoints
      net: usb: kalmia: validate USB endpoints
      net: usb: pegasus: validate USB endpoints
      can: ems_usb: ems_usb_read_bulk_callback(): check the proper length of a message
      can: usb: f81604: correctly anchor the urb in the read bulk callback
      can: ucan: Fix infinite loop from zero-length messages
      can: usb: etas_es58x: correctly anchor the urb in the read bulk callback
      can: usb: f81604: handle short interrupt urb messages properly
      can: usb: f81604: handle bulk write errors properly
      HID: Add HID_CLAIMED_INPUT guards in raw_event callbacks missing them
      Linux 6.12.77

Guenter Roeck (3):
      dpaa2-switch: Fix interrupt storm after receiving bad if_id in IRQ handler
      tracing: Add NULL pointer check to trigger_data_free()
      ata: libata-eh: Fix detection of deferred qc timeouts

Gui-Dong Han (1):
      hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler optimization induced race

Hao Yu (1):
      hwmon: (aht10) Fix initialization commands for AHT20

Harshit Mogalapalli (2):
      ima: verify the previous kernel's IMA buffer lies in addressable RAM
      of/kexec: refactor ima_get_kexec_buffer() to use ima_validate_range()

Heiko Carstens (2):
      s390/idle: Fix cpu idle exit cpu time accounting
      s390/vtime: Fix virtual timer forwarding

Henrique Carvalho (1):
      smb: client: fix cifs_pick_channel when channels are equally loaded

Hongyu Xie (1):
      usb: cdns3: remove redundant if branch

Huacai Chen (1):
      net: stmmac: dwmac-loongson: Set clk_csr_i to 100-150MHz

Ian Forbes (1):
      drm/vmwgfx: Return the correct value in vmw_translate_ptr functions

Ian Ray (2):
      HID: multitouch: new class MT_CLS_EGALAX_P80H84
      net: nfc: nci: Fix zero-length proprietary notifications

Ilpo Järvinen (2):
      resource: Add resource set range and size helpers
      PCI: Use resource_set_range() that correctly sets ->end

Jakub Kicinski (4):
      ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
      nfc: nci: free skb on nci_transceive early error paths
      nfc: nci: clear NCI_DATA_EXCHANGE before calling completion callback
      nfc: rawsock: cancel tx_work before socket teardown

Jamal Hadi Salim (1):
      net/sched: act_ife: Fix metalist update behavior

Jan Kara (1):
      ext4: always allocate blocks only from groups inode can use

Jann Horn (1):
      eventpoll: Fix integer overflow in ep_loop_check_proc()

Jason Gunthorpe (2):
      IB/mthca: Add missed mthca_unmap_user_db() for mthca_create_srq()
      RDMA/irdma: Fix kernel stack leak in irdma_create_user_ah()

Jens Axboe (1):
      media: dvb-core: fix wrong reinitialization of ringbuffer on reopen

Jeongjun Park (2):
      drm/exynos: vidi: fix to avoid directly dereferencing user pointer
      drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free

Jiayuan Chen (3):
      atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
      bpf/bonding: reject vlan+srcmac xmit_hash_policy change when XDP is loaded
      net: ipv6: fix panic when IPv4 route references loopback IPv6 nexthop

Jinhui Guo (1):
      iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device without scalable mode

Johan Hovold (4):
      memory: mtk-smi: fix device leaks on common probe
      memory: mtk-smi: fix device leak on larb probe
      drm/tegra: dsi: fix device leak on probe
      clk: tegra: tegra124-emc: fix device leak on set_rate()

Johannes Berg (1):
      wifi: radiotap: reject radiotap with unknown bits

Johannes Thumshirn (1):
      btrfs: zoned: fix alloc_offset calculation for partly conventional block groups

John Johansen (6):
      apparmor: fix: limit the number of levels of policy namespaces
      apparmor: Fix double free of ns_name in aa_replace_profiles()
      apparmor: fix unprivileged local user can do privileged policy management
      apparmor: fix differential encoding verification
      apparmor: fix race on rawdata dereference
      apparmor: fix race between freeing data and fs accessing it

Jonathan Teh (1):
      platform/x86: thinkpad_acpi: Fix errors reading battery thresholds

Joonwon Kang (1):
      mailbox: Prevent out-of-bounds access in fw_mbox_index_xlate()

Jun Seo (1):
      ALSA: usb-audio: Use correct version for UAC3 header validation

Junxiao Bi (1):
      scsi: core: Fix refcount leak for tagset_refcnt

Kohei Enju (2):
      bpf: Fix stack-out-of-bounds write in devmap
      iavf: fix netdev->max_mtu to respect actual hardware limit

Koichiro Den (1):
      net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue race for lockless qdiscs

Krishna chaitanya chundru (1):
      PCI: qcom: Don't wait for link if we can detect Link Up

Kuninori Morimoto (1):
      ALSA: pci: hda: use snd_kcontrol_chip()

Kuniyuki Iwashima (1):
      nfsd: Fix cred ref leak in nfsd_nl_threads_set_doit().

Kurt Borja (1):
      platform/x86: dell-wmi: Add audio/mic mute key codes

Lang Xu (1):
      bpf: Fix a UAF issue in bpf_trampoline_link_cgroup_shim

Lars Ellenberg (1):
      drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()

Larysa Zaremba (5):
      xdp: use modulo operation to calculate XDP frag tailroom
      xsk: introduce helper to determine rxq->frag_size
      i40e: fix registering XDP RxQ info
      i40e: use xdp.frame_sz as XDP RxQ info frag_size
      xdp: produce a warning when calculated tailroom is negative

Lewis Mason (1):
      ALSA: hda/realtek: Add quirk for Samsung Galaxy Book3 Pro 360 (NP965QFG)

Lorenzo Bianconi (4):
      wifi: mt76: mt7996: Fix possible oob access in mt7996_mac_write_txwi_80211()
      wifi: mt76: mt7925: Fix possible oob access in mt7925_mac_write_txwi_80211()
      wifi: mt76: Fix possible oob access in mt76_connac2_mac_write_txwi_80211()
      net: ethernet: mtk_eth_soc: Reset prog ptr to old_prog in case of error in mtk_xdp_setup()

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix ping failure after offload mode setup when link speed is not 1G

Maciej Fijalkowski (2):
      xsk: Get rid of xdp_buff_xsk::xskb_list_node
      xsk: s/free_list_node/list_node/

Marco Crivellari (2):
      workqueue: Add system_percpu_wq and system_dfl_wq
      Input: synaptics_i2c - replace use of system_wq with system_dfl_wq

Mario Limonciello (1):
      drm/amd: Fix hang on amdgpu unload by using pci_dev_is_disconnected()

Mark Harmstone (5):
      btrfs: fix incorrect key offset in error message in check_dev_extent_item()
      btrfs: fix objectid value in error message in check_extent_data_ref()
      btrfs: fix warning in scrub_verify_one_metadata()
      btrfs: print correct subvol num if active swapfile prevents deletion
      btrfs: fix compat mask in error messages in btrfs_check_features()

Massimiliano Pellizzer (5):
      apparmor: validate DFA start states are in bounds in unpack_pdb
      apparmor: fix memory leak in verify_header
      apparmor: replace recursive profile removal with iterative approach
      apparmor: fix side-effect bug in match_char() macro usage
      apparmor: fix missing bounds check on DEFAULT table in verify_dfa()

Mathias Krause (1):
      scsi: lpfc: Properly set WC for DPP mapping

Mathieu Desnoyers (1):
      rseq: Clarify rseq registration rseq_size bound check comment

Matthew Brost (1):
      drm/xe: Do not preempt fence signaling CS instructions

Matthias Fend (2):
      media: dw9714: move power sequences to dedicated functions
      media: dw9714: add support for powerdown pin

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: join: check removing signal+subflow endp

Mieczyslaw Nalewaj (1):
      net: dsa: realtek: rtl8365mb: fix rtl8365mb_phy_ocp_write return value

Mike Rapoport (Microsoft) (1):
      x86/efi: defer freeing of boot services memory

Ming Lei (1):
      nvme: fix admin queue leak on controller reset

Minseong Kim (1):
      Input: synaptics_i2c - guard polling restart in resume

Miquel Sabaté Solà (1):
      btrfs: define the AUTO_KFREE/AUTO_KVFREE helper macros

Nam Cao (1):
      irqchip/sifive-plic: Fix frozen interrupt due to affinity setting

Namjae Jeon (2):
      ksmbd: check return value of xa_store() in krb5_authenticate
      ksmbd: add chann_lock to protect ksmbd_chann_list xarray

Naohiro Aota (4):
      btrfs: zoned: fixup last alloc pointer after extent removal for RAID1
      btrfs: zoned: fixup last alloc pointer after extent removal for DUP
      btrfs: zoned: fix stripe width calculation
      btrfs: zoned: fixup last alloc pointer after extent removal for RAID0/10

Naresh Solanki (1):
      hwmon: (max6639) : Configure based on DT property

Nathan Chancellor (1):
      ACPI: APEI: GHES: Disable KASAN instrumentation when compile testing with clang < 18

Nikhil P. Rao (2):
      xsk: Fix fragment node deletion to prevent buffer leak
      xsk: Fix zero-copy AF_XDP fragment drop

Niklas Cassel (6):
      PCI: dwc: ep: Use align addr function for dw_pcie_ep_raise_{msi,msix}_irq()
      PCI: dwc: ep: Flush MSI-X write before unmapping its ATU entry
      PCI: dw-rockchip: Don't wait for link since we can detect Link Up
      Revert "PCI: dw-rockchip: Don't wait for link since we can detect Link Up"
      Revert "PCI: qcom: Don't wait for link if we can detect Link Up"
      ata: libata: cancel pending work after clearing deferred_qc

Oliver Hartkopp (1):
      can: bcm: fix locking for bcm_op runtime updates

Olivier Sobrie (1):
      hwmon: (max6639) fix inverted polarity

Ovidiu Panait (1):
      net: stmmac: Fix error handling in VLAN add and delete paths

Paolo Abeni (1):
      selftests: mptcp: more stable simult_flows tests

Paulo Alcantara (1):
      smb: client: fix broken multichannel with krb5+signing

Peng Fan (2):
      mailbox: Use dev_err when there is error
      mailbox: Use guard/scoped_guard for con_mutex

Peter Wang (1):
      scsi: ufs: core: Move link recovery for hibern8 exit failure to wl_resume

Peter Zijlstra (1):
      perf: Fix __perf_event_overflow() vs perf_remove_from_context() race

Phillip Lougher (1):
      Squashfs: check metadata block offset is within range

Prithvi Tambewagh (1):
      scsi: target: Fix recursive locking in __configfs_open_file()

Qing Wang (1):
      tracing: Fix WARN_ON in tracing_buffers_mmap_close

Qu Wenruo (1):
      btrfs: always fallback to buffered write if the inode requires checksum

Raju Rangoju (2):
      amd-xgbe: fix MAC_TCR_SS register width for 2.5G and 10M speeds
      amd-xgbe: fix sleep while atomic on suspend/resume

Ricardo Ribalda (1):
      media: dw9714: Fix powerup sequence

Richard Fitzgerald (1):
      ALSA: hda: cs35l56: Fix signedness error in cs35l56_hda_posture_put()

Salomon Dushimirimana (1):
      scsi: pm8001: Fix use-after-free in pm8001_queue_command()

Sean Christopherson (1):
      KVM: x86: Ignore -EBUSY when checking nested events from vcpu_block()

Sebastian Andrzej Siewior (1):
      LoongArch/orc: Use RCU in all users of __module_address().

Sebastian Krzyszkowiak (1):
      wifi: rsi: Don't default to -EOPNOTSUPP in rsi_mac80211_config

Shawn Lin (2):
      arm64: dts: rockchip: Fix rk356x PCIe range mappings
      arm64: dts: rockchip: Fix rk3588 PCIe range mappings

Shuicheng Lin (1):
      drm/xe/reg_sr: Fix leak on xa_store failure

Shuvam Pandey (1):
      kunit: tool: copy caller args in run_kernel to prevent mutation

Stefan Hajnoczi (1):
      nvme: reject invalid pr_read_keys() num_keys values

Steven Chen (4):
      ima: rename variable the seq_file "file" to "ima_kexec_file"
      ima: define and call ima_alloc_kexec_file_buf()
      kexec: define functions to map and unmap segments
      ima: kexec: define functions to copy IMA log at soft boot

Sun Jian (1):
      selftests/harness: order TEST_F and XFAIL_ADD constructors

Sun YangKai (1):
      btrfs: fix periodic reclaim condition

Sungwoo Kim (1):
      nvme: fix memory allocation in nvme_pr_read_keys()

Takashi Iwai (4):
      ALSA: usb-audio: Cap the packet size pre-calculations
      ALSA: usb-audio: Use inclusive terms
      ALSA: hda/conexant: Add quirk for HP ZBook Studio G4
      ALSA: hda/conexant: Fix headphone jack handling on Acer Swift SF314

Thomas Gleixner (1):
      i40e: Fix preempt count leak in napi poll tracepoint

Thomas Richard (TI) (1):
      usb: cdns3: fix role switching during resume

Thomas Weißschuh (1):
      ARM: clean up the memset64() C wrapper

Thorsten Blum (3):
      drm/amdgpu: Replace kzalloc + copy_from_user with memdup_user
      platform/x86: dell-wmi-sysman: Don't hex dump plaintext password data
      smb: client: Don't log plaintext credentials in cifs_set_cifscreds

Théo Lebrun (1):
      usb: cdns3: call cdns_power_is_lost() only once in cdns_resume()

Tiezhu Yang (3):
      LoongArch: Remove unnecessary checks for ORC unwinder
      LoongArch: Handle percpu handler address for ORC unwinder
      LoongArch: Remove some extern variables in source files

Tudor Ambarus (3):
      mailbox: don't protect of_parse_phandle_with_args with con_mutex
      mailbox: sort headers alphabetically
      mailbox: remove unused header files

Vahagn Vardanian (1):
      wifi: mac80211: fix NULL pointer dereference in mesh_rx_csa_frame()

Victor Nogueira (1):
      net/sched: Only allow act_ct to bind to clsact/ingress qdiscs and shared blocks

Vimlesh Kumar (4):
      octeon_ep: Relocate counter updates before NAPI
      octeon_ep: avoid compiler and IQ/OQ reordering
      octeon_ep_vf: Relocate counter updates before NAPI
      octeon_ep_vf: avoid compiler and IQ/OQ reordering

Vitaly Lifshits (1):
      e1000e: clear DPG_EN after reset to avoid autonomous power-gating

Waiman Long (1):
      cgroup/cpuset: Fix incorrect use of cpuset_update_tasks_cpumask() in update_cpumasks_hier()

Wake Liu (1):
      kselftest/harness: Use helper to avoid zero-size memset warning

Wentao Liang (1):
      drm/exynos/vidi: Remove redundant error handling in vidi_get_modes()

Yang Erkun (1):
      ext4: correct the comments place for EXT4_EXT_MAY_ZEROOUT

Yazen Ghannam (1):
      x86/acpi/boot: Correct acpi_is_processor_usable() check again

Yifan Wu (1):
      selftest/arm64: Fix sve2p1_sigill() to hwcap test

Yujie Liu (1):
      drm/sched: Fix kernel-doc warning for drm_sched_job_done()

Yung Chih Su (1):
      net: ipv4: fix ARM64 alignment fault in multipath hash seed

Zhang Yi (1):
      ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before submitting I/O

ZhangGuoDong (2):
      smb/client: fix buffer size for smb311_posix_qinfo in smb2_compound_op()
      smb/client: fix buffer size for smb311_posix_qinfo in SMB311_posix_query_info()

Zilin Guan (1):
      media: tegra-video: Fix memory leak in __tegra_channel_try_format()


