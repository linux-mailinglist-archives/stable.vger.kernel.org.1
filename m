Return-Path: <stable+bounces-108104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1BAA0764F
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 13:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4AD168320
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99654218EB3;
	Thu,  9 Jan 2025 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="poEDIYbY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C721859A;
	Thu,  9 Jan 2025 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427439; cv=none; b=D98ZCYZGRLWFQIhH39TjDL8q5NTKEUak9Yb65XWDLncfiBhqrpjaSjPC7aeQ8gtoddyYpsyEPrQk82Y7aRPlFPIJQAP6A0DXbpPpOH/RYvnLTCZzL6oo8e57VZJVu18emVBcua1+4ua6S/bdEOdsNVDo834YuvWljvZrbpxT3lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427439; c=relaxed/simple;
	bh=Fvu58OLCxhZWpyGZdcZAkduhFAS2BYl79pTzGaYKpPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ifaeiMbZuwoCutJHsCwQ56imPilVtT8Xn5Fode3Pk2uAI6rtV8DzrTGDisx9EK+MM0q8TD/UuUHqUrjfZStS6WRJf7tGsCUEc1KKGSomVv74UoEFIaSB87irKfF9w7JWj/ECs+Cf7hOLTEAPb6ah9zQFaZbT7mofsuexSEVIuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=poEDIYbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D6FC4CEE4;
	Thu,  9 Jan 2025 12:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736427437;
	bh=Fvu58OLCxhZWpyGZdcZAkduhFAS2BYl79pTzGaYKpPg=;
	h=From:To:Cc:Subject:Date:From;
	b=poEDIYbY+5IXKZX+wzcLwbCAjVtlMXUSyolTFjVEKeKaJVCKmqC6ZtzdITxQ0mf4j
	 BWxfDt+A8n6HDRgJlmjpQMnHwpNEs+fj5FQAvOT4pHvzLF7TxDi7xLtf0ZnX6rbnB4
	 Tke2xnO/+j5BOJ5wpS/ueZf7OLx/66u1Kc5qVqkE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.70
Date: Thu,  9 Jan 2025 13:56:57 +0100
Message-ID: <2025010957-discourse-riverside-b734@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.70 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/media/building.rst                      |    2 
 Documentation/admin-guide/media/saa7134.rst                       |    2 
 Documentation/arch/arm64/silicon-errata.rst                       |    5 
 Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml |    2 
 Documentation/i2c/busses/i2c-i801.rst                             |    2 
 Makefile                                                          |    2 
 arch/arc/Makefile                                                 |    2 
 arch/loongarch/kernel/numa.c                                      |   28 -
 arch/powerpc/kernel/setup-common.c                                |    1 
 arch/x86/entry/vsyscall/vsyscall_64.c                             |    2 
 arch/x86/include/asm/ptrace.h                                     |  104 +++
 arch/x86/include/asm/tlb.h                                        |    4 
 arch/x86/kernel/Makefile                                          |    4 
 arch/x86/kernel/cet.c                                             |   30 +
 arch/x86/kernel/cpu/mshyperv.c                                    |   68 ++
 arch/x86/kernel/kexec-bzimage64.c                                 |    4 
 arch/x86/kernel/kvm.c                                             |    4 
 arch/x86/kernel/machine_kexec_64.c                                |    3 
 arch/x86/kernel/process_64.c                                      |    2 
 arch/x86/kernel/reboot.c                                          |    4 
 arch/x86/kernel/setup.c                                           |    2 
 arch/x86/kernel/smp.c                                             |    2 
 arch/x86/mm/numa.c                                                |   34 -
 arch/x86/mm/tlb.c                                                 |    3 
 arch/x86/xen/enlighten_hvm.c                                      |    4 
 arch/x86/xen/mmu_pv.c                                             |    2 
 crypto/ecc.c                                                      |   22 
 crypto/ecdsa.c                                                    |   51 -
 drivers/acpi/arm64/iort.c                                         |    9 
 drivers/bluetooth/btusb.c                                         |   47 +
 drivers/clk/qcom/clk-alpha-pll.c                                  |   27 +
 drivers/clk/qcom/clk-alpha-pll.h                                  |    5 
 drivers/clocksource/hyperv_timer.c                                |   14 
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c                          |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c       |   16 
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c                    |   14 
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c                      |   10 
 drivers/gpu/drm/bridge/adv7511/adv7533.c                          |    4 
 drivers/gpu/drm/i915/gt/intel_rc6.c                               |    2 
 drivers/i2c/busses/Kconfig                                        |    2 
 drivers/i2c/busses/i2c-i801.c                                     |    9 
 drivers/i2c/busses/i2c-xgene-slimpro.c                            |   16 
 drivers/iio/adc/ad7192.c                                          |   39 -
 drivers/infiniband/core/uverbs_cmd.c                              |   16 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                          |   63 +-
 drivers/infiniband/hw/bnxt_re/main.c                              |   21 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                          |   93 +--
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                          |   19 
 drivers/infiniband/hw/bnxt_re/qplib_res.h                         |    6 
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                          |   26 
 drivers/infiniband/hw/bnxt_re/qplib_sp.h                          |    9 
 drivers/infiniband/hw/bnxt_re/roce_hsi.h                          |   30 +
 drivers/infiniband/hw/hns/hns_roce_alloc.c                        |    3 
 drivers/infiniband/hw/hns/hns_roce_cq.c                           |   11 
 drivers/infiniband/hw/hns/hns_roce_device.h                       |   12 
 drivers/infiniband/hw/hns/hns_roce_hem.c                          |   54 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                        |  130 ++--
 drivers/infiniband/hw/hns/hns_roce_mr.c                           |   95 ++-
 drivers/infiniband/hw/hns/hns_roce_qp.c                           |    4 
 drivers/infiniband/hw/hns/hns_roce_srq.c                          |    4 
 drivers/infiniband/hw/mlx5/main.c                                 |    6 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                            |    2 
 drivers/irqchip/irq-gic.c                                         |    2 
 drivers/mailbox/pcc.c                                             |  136 ++++-
 drivers/media/usb/uvc/uvc_driver.c                                |   22 
 drivers/mmc/host/sdhci-msm.c                                      |   16 
 drivers/net/dsa/microchip/ksz9477.c                               |   47 +
 drivers/net/dsa/microchip/ksz9477_reg.h                           |    4 
 drivers/net/dsa/microchip/lan937x_main.c                          |   62 ++
 drivers/net/dsa/microchip/lan937x_reg.h                           |    9 
 drivers/net/ethernet/broadcom/bcmsysport.c                        |   21 
 drivers/net/ethernet/google/gve/gve_main.c                        |   25 
 drivers/net/ethernet/google/gve/gve_tx.c                          |    5 
 drivers/net/ethernet/marvell/mv643xx_eth.c                        |   14 
 drivers/net/ethernet/marvell/sky2.c                               |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c         |    4 
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c            |    6 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                 |    3 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c        |    3 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c                 |    7 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c        |    4 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c               |    3 
 drivers/net/ethernet/renesas/rswitch.c                            |    5 
 drivers/net/ethernet/sfc/tc_conntrack.c                           |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c             |  118 ++--
 drivers/net/ethernet/ti/icssg/icss_iep.c                          |    8 
 drivers/net/usb/qmi_wwan.c                                        |    3 
 drivers/net/wireless/ath/ath10k/bmi.c                             |    1 
 drivers/net/wireless/ath/ath10k/ce.c                              |    1 
 drivers/net/wireless/ath/ath10k/core.c                            |    1 
 drivers/net/wireless/ath/ath10k/core.h                            |    1 
 drivers/net/wireless/ath/ath10k/coredump.c                        |    1 
 drivers/net/wireless/ath/ath10k/coredump.h                        |    1 
 drivers/net/wireless/ath/ath10k/debug.c                           |    1 
 drivers/net/wireless/ath/ath10k/debugfs_sta.c                     |    1 
 drivers/net/wireless/ath/ath10k/htc.c                             |    1 
 drivers/net/wireless/ath/ath10k/htt.h                             |    1 
 drivers/net/wireless/ath/ath10k/htt_rx.c                          |    1 
 drivers/net/wireless/ath/ath10k/htt_tx.c                          |    1 
 drivers/net/wireless/ath/ath10k/hw.c                              |    1 
 drivers/net/wireless/ath/ath10k/hw.h                              |    1 
 drivers/net/wireless/ath/ath10k/mac.c                             |    1 
 drivers/net/wireless/ath/ath10k/pci.c                             |    1 
 drivers/net/wireless/ath/ath10k/pci.h                             |    1 
 drivers/net/wireless/ath/ath10k/qmi.c                             |    1 
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c                    |    1 
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h                    |    1 
 drivers/net/wireless/ath/ath10k/rx_desc.h                         |    1 
 drivers/net/wireless/ath/ath10k/sdio.c                            |    5 
 drivers/net/wireless/ath/ath10k/thermal.c                         |    1 
 drivers/net/wireless/ath/ath10k/usb.h                             |    1 
 drivers/net/wireless/ath/ath10k/wmi-tlv.h                         |    1 
 drivers/net/wireless/ath/ath10k/wmi.c                             |    1 
 drivers/net/wireless/ath/ath10k/wmi.h                             |    1 
 drivers/net/wireless/ath/ath10k/wow.c                             |    1 
 drivers/net/wireless/ath/ath12k/mac.c                             |   26 
 drivers/net/wireless/ath/ath12k/reg.c                             |    6 
 drivers/net/wireless/realtek/rtw88/sdio.c                         |    6 
 drivers/net/wireless/realtek/rtw88/usb.c                          |    5 
 drivers/net/wwan/iosm/iosm_ipc_mmio.c                             |    2 
 drivers/net/wwan/t7xx/t7xx_state_monitor.c                        |   26 
 drivers/net/wwan/t7xx/t7xx_state_monitor.h                        |    5 
 drivers/nvme/host/core.c                                          |   27 -
 drivers/nvme/host/nvme.h                                          |    5 
 drivers/nvme/host/pci.c                                           |    9 
 drivers/of/address.c                                              |   30 -
 drivers/pinctrl/pinctrl-mcp23s08.c                                |    6 
 drivers/platform/x86/mlx-platform.c                               |    2 
 drivers/remoteproc/qcom_q6v5_pas.c                                |   94 +++
 drivers/scsi/hisi_sas/hisi_sas.h                                  |    3 
 drivers/scsi/hisi_sas/hisi_sas_main.c                             |   17 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                            |  200 ++++---
 drivers/scsi/mpi3mr/mpi3mr_os.c                                   |   12 
 drivers/thunderbolt/nhi.c                                         |   12 
 drivers/thunderbolt/nhi.h                                         |    6 
 drivers/thunderbolt/retimer.c                                     |   17 
 drivers/usb/chipidea/ci.h                                         |    2 
 drivers/usb/chipidea/ci_hdrc_imx.c                                |    1 
 drivers/usb/chipidea/core.c                                       |    2 
 drivers/usb/chipidea/otg.c                                        |    5 
 drivers/usb/chipidea/udc.c                                        |    6 
 drivers/usb/dwc3/core.h                                           |    4 
 drivers/usb/dwc3/gadget.c                                         |   54 +-
 drivers/usb/host/xhci-ring.c                                      |   42 +
 drivers/usb/host/xhci.c                                           |   21 
 drivers/usb/host/xhci.h                                           |    2 
 drivers/usb/typec/ucsi/ucsi.c                                     |    9 
 drivers/usb/typec/ucsi/ucsi.h                                     |    5 
 drivers/usb/typec/ucsi/ucsi_glink.c                               |   60 +-
 drivers/watchdog/rzg2l_wdt.c                                      |   83 +--
 fs/btrfs/ctree.c                                                  |   37 -
 fs/btrfs/ctree.h                                                  |    7 
 fs/btrfs/disk-io.c                                                |    9 
 fs/btrfs/inode.c                                                  |    2 
 fs/ceph/mds_client.c                                              |    9 
 fs/ext4/ext4.h                                                    |   20 
 fs/ext4/extents.c                                                 |   18 
 fs/ext4/ialloc.c                                                  |    4 
 fs/ext4/inline.c                                                  |    4 
 fs/ext4/inode.c                                                   |   70 +-
 fs/ext4/ioctl.c                                                   |   13 
 fs/ext4/namei.c                                                   |   10 
 fs/ext4/super.c                                                   |    2 
 fs/ext4/xattr.c                                                   |    8 
 fs/f2fs/file.c                                                    |   13 
 fs/ntfs3/attrib.c                                                 |   32 -
 fs/ntfs3/frecord.c                                                |  103 ---
 fs/ntfs3/inode.c                                                  |    3 
 fs/ntfs3/ntfs_fs.h                                                |    3 
 fs/ocfs2/quota_global.c                                           |    2 
 fs/ocfs2/quota_local.c                                            |    1 
 fs/proc/task_mmu.c                                                |    2 
 fs/smb/client/cifsacl.c                                           |  266 +++++-----
 fs/smb/client/cifsacl.h                                           |   20 
 fs/smb/client/cifsfs.c                                            |    1 
 fs/smb/client/cifsglob.h                                          |   22 
 fs/smb/client/cifsproto.h                                         |   26 
 fs/smb/client/cifssmb.c                                           |    6 
 fs/smb/client/inode.c                                             |    4 
 fs/smb/client/smb2inode.c                                         |    4 
 fs/smb/client/smb2ops.c                                           |   14 
 fs/smb/client/smb2pdu.c                                           |   12 
 fs/smb/client/smb2pdu.h                                           |    8 
 fs/smb/client/smb2proto.h                                         |    4 
 fs/smb/client/smb2transport.c                                     |   56 +-
 fs/smb/client/xattr.c                                             |    4 
 fs/smb/server/smb2pdu.c                                           |   22 
 fs/smb/server/vfs.h                                               |    1 
 fs/udf/namei.c                                                    |   17 
 include/acpi/pcc.h                                                |   20 
 include/clocksource/hyperv_timer.h                                |    2 
 include/crypto/internal/ecc.h                                     |   10 
 include/linux/bpf_verifier.h                                      |   31 -
 include/linux/cleanup.h                                           |   88 +++
 include/linux/if_vlan.h                                           |   16 
 include/linux/memblock.h                                          |    1 
 include/linux/mlx5/driver.h                                       |    6 
 include/linux/mutex.h                                             |    3 
 include/linux/rwsem.h                                             |    8 
 include/linux/seq_buf.h                                           |   25 
 include/linux/spinlock.h                                          |   15 
 include/linux/trace_events.h                                      |    6 
 include/linux/trace_seq.h                                         |    2 
 include/linux/usb/chipidea.h                                      |    2 
 include/net/bluetooth/hci_core.h                                  |  108 ++--
 include/net/mac80211.h                                            |   31 +
 include/net/netfilter/nf_tables.h                                 |    7 
 kernel/bpf/core.c                                                 |    6 
 kernel/bpf/verifier.c                                             |  175 ++----
 kernel/kcov.c                                                     |    2 
 kernel/sched/core.c                                               |   12 
 kernel/softirq.c                                                  |   15 
 kernel/trace/trace.c                                              |  233 ++------
 kernel/trace/trace.h                                              |    6 
 kernel/trace/trace_events.c                                       |   44 +
 kernel/trace/trace_output.c                                       |    6 
 kernel/trace/trace_seq.c                                          |    6 
 lib/seq_buf.c                                                     |   26 
 mm/kmemleak.c                                                     |    2 
 mm/memblock.c                                                     |   34 +
 mm/readahead.c                                                    |    6 
 mm/vmscan.c                                                       |    9 
 net/bluetooth/hci_conn.c                                          |   13 
 net/bluetooth/hci_core.c                                          |   10 
 net/bluetooth/iso.c                                               |    6 
 net/bluetooth/l2cap_core.c                                        |   12 
 net/bluetooth/rfcomm/core.c                                       |    6 
 net/bluetooth/sco.c                                               |   12 
 net/core/dev.c                                                    |    4 
 net/core/sock.c                                                   |    5 
 net/ipv4/ip_tunnel.c                                              |   38 -
 net/ipv4/tcp_input.c                                              |    1 
 net/ipv6/ila/ila_xlat.c                                           |   16 
 net/llc/llc_input.c                                               |    2 
 net/mac80211/ieee80211_i.h                                        |    2 
 net/mac80211/mesh.c                                               |    6 
 net/mac80211/status.c                                             |    1 
 net/mac80211/util.c                                               |   19 
 net/mctp/route.c                                                  |   36 -
 net/mptcp/options.c                                               |    7 
 net/mptcp/protocol.c                                              |   22 
 net/netrom/nr_route.c                                             |    6 
 net/packet/af_packet.c                                            |   28 -
 net/sctp/associola.c                                              |    3 
 scripts/mod/file2alias.c                                          |    4 
 scripts/sorttable.h                                               |    5 
 security/selinux/ss/services.c                                    |    8 
 sound/core/seq/oss/seq_oss_synth.c                                |    2 
 sound/core/seq/seq_clientmgr.c                                    |   14 
 sound/core/ump.c                                                  |   61 +-
 sound/pci/hda/patch_ca0132.c                                      |   37 -
 sound/pci/hda/patch_realtek.c                                     |    2 
 sound/usb/format.c                                                |    7 
 sound/usb/mixer_us16x08.c                                         |    2 
 sound/usb/quirks.c                                                |    2 
 tools/testing/selftests/bpf/progs/verifier_subprog_precision.c    |   23 
 tools/testing/selftests/bpf/verifier/precise.c                    |   38 -
 257 files changed, 3085 insertions(+), 1788 deletions(-)

Adam Young (1):
      mailbox: pcc: Check before sending MCTP PCC response ACK

Adrian Ratiu (2):
      sound: usb: enable DSD output for ddHiFi TC44C
      sound: usb: format: don't warn that raw DSD is unsupported

Agustin Gutierrez (1):
      drm/amd/display: Fix DSC-re-computing

Al Viro (1):
      udf_rename(): only access the child content on cross-directory rename

Alessandro Carminati (1):
      mm/kmemleak: fix sleeping function called from invalid context at print message

Andrea della Porta (1):
      of: address: Preserve the flags portion on 1:1 dma-ranges mapping

Andrew Halaney (1):
      net: stmmac: don't create a MDIO bus if unnecessary

Anton Protopopov (1):
      bpf: fix potential error return

Antonio Pastor (1):
      net: llc: reset skb->transport_header

Arnd Bergmann (1):
      kcov: mark in_softirq_really() as __always_inline

Baoquan He (1):
      x86, crash: wrap crash dumping code into crash related ifdefs

Biju Das (3):
      drm: adv7511: Drop dsi single lane support
      dt-bindings: display: adi,adv7533: Drop single lane support
      drm: adv7511: Fix use-after-free in adv7533_attach_dsi()

Borislav Petkov (AMD) (1):
      x86/mm: Carve out INVLPG inline asm for use by others

Brian Foster (1):
      ext4: partial zero eof block on unaligned inode size extension

Chao Yu (1):
      f2fs: fix to wait dio completion

ChenXiaoSong (4):
      smb/client: rename cifs_ntsd to smb_ntsd
      smb/client: rename cifs_sid to smb_sid
      smb/client: rename cifs_acl to smb_acl
      smb/client: rename cifs_ace to smb_ace

Chengchang Tang (4):
      RDMA/hns: Refactor mtr find
      RDMA/hns: Remove unused parameters and variables
      RDMA/hns: Fix warning storm caused by invalid input in IO path
      RDMA/hns: Fix missing flush CQE for DWQE

Chris Lu (2):
      Bluetooth: btusb: add callback function in btusb suspend/resume
      Bluetooth: btusb: mediatek: add callback function in btusb_disconnect

Claudiu Beznea (3):
      watchdog: rzg2l_wdt: Remove reset de-assert from probe
      watchdog: rzg2l_wdt: Rely on the reset driver for doing proper reset
      watchdog: rzg2l_wdt: Power on the watchdog domain in the restart handler

Damodharam Ammepalli (2):
      RDMA/bnxt_re: Add send queue size check for variable wqe
      RDMA/bnxt_re: Fix MSN table size for variable wqe mode

Dan Carpenter (1):
      RDMA/uverbs: Prevent integer overflow issue

Daniel Schaefer (1):
      ALSA hda/realtek: Add quirk for Framework F111:000C

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FE910C04 compositions

David Hildenbrand (1):
      fs/proc/task_mmu: fix pagemap flags with PMD THP entries on 32bit

Dennis Lam (1):
      ocfs2: fix slab-use-after-free due to dangling pointer dqi_priv

Devi Priya (1):
      clk: qcom: clk-alpha-pll: Add NSS HUAYRA ALPHA PLL support for ipq9574

Dmitry Baryshkov (7):
      remoteproc: qcom: pas: enable SAR2130P audio DSP support
      usb: typec: ucsi: add callback for connector status updates
      usb: typec: ucsi: glink: move GPIO reading into connector_status callback
      usb: typec: ucsi: add update_connector callback
      usb: typec: ucsi: glink: set orientation aware if supported
      usb: typec: ucsi: glink: be more precise on orientation-aware ports
      usb: typec: ucsi: glink: fix off-by-one in connector_status

Dragos Tatulea (1):
      net/mlx5e: macsec: Maintain TX SA from encoding_sa

Emmanuel Grumbach (1):
      wifi: mac80211: wake the queues in case of failure in resume

Enzo Matsumiya (1):
      smb: client: destroy cfid_put_wq on module exit

Eric Biggers (1):
      mmc: sdhci-msm: fix crypto key eviction

Eric Dumazet (5):
      ip_tunnel: annotate data-races around t->parms.link
      net: restrict SO_REUSEPORT to inet sockets
      af_packet: fix vlan_get_tci() vs MSG_PEEK
      af_packet: fix vlan_get_protocol_dgram() vs MSG_PEEK
      ila: serialize calls to nf_register_net_hooks()

Evgenii Shatokhin (1):
      pinctrl: mcp23s08: Fix sleeping in atomic context due to regmap locking

Fangzhi Zuo (1):
      drm/amd/display: Fix incorrect DSC recompute trigger

Filipe Manana (3):
      btrfs: rename and export __btrfs_cow_block()
      btrfs: fix use-after-free when COWing tree bock and tracing is enabled
      btrfs: flush delalloc workers queue before stopping cleaner kthread during unmount

Greg Kroah-Hartman (1):
      Linux 6.6.70

Guixin Liu (1):
      scsi: mpi3mr: Use ida to manage mrioc ID

Hao Qin (1):
      Bluetooth: btusb: Add new VID/PID 0489/e111 for MT7925

Herve Codina (1):
      of: address: Remove duplicated functions

Hobin Woo (1):
      ksmbd: retry iterate_dir in smb2_query_dir

Huisong Li (2):
      mailbox: pcc: Add support for platform notification handling
      mailbox: pcc: Support shared interrupt for multiple subspaces

Ido Schimmel (3):
      ipv4: ip_tunnel: Unmask upper DSCP bits in ip_tunnel_bind_dev()
      ipv4: ip_tunnel: Unmask upper DSCP bits in ip_md_tunnel_xmit()
      ipv4: ip_tunnel: Unmask upper DSCP bits in ip_tunnel_xmit()

Ilya Shchipletsov (1):
      netrom: check buffer length before accessing it

Issam Hamdi (1):
      wifi: mac80211: fix mbss changed flags corruption on 32 bit systems

Jan Kara (1):
      udf: Verify inode link counts before performing rename

Jarkko Nikula (2):
      i2c: i801: Add support for Intel Arrow Lake-H
      i2c: i801: Add support for Intel Panther Lake

Jeff Johnson (1):
      wifi: ath10k: Update Qualcomm Innovation Center, Inc. copyrights

Jeff Layton (1):
      ext4: convert to new timestamp accessors

Jeremy Kerr (1):
      net: mctp: handle skb cleanup on sock_queue failures

Jianbo Liu (1):
      net/mlx5e: Skip restore TC rules for vport rep without loaded flag

Jiande Lu (1):
      Bluetooth: btusb: Add USB HW IDs for MT7921/MT7922/MT7925

Jingyang Wang (1):
      Bluetooth: Add support ITTIM PE50-M75C

Jinjian Song (1):
      net: wwan: t7xx: Fix FSM command timeout issue

Joe Hattori (3):
      platform/x86: mlx-platform: call pci_dev_put() to balance the refcount
      net: stmmac: restructure the error path of stmmac_probe_config_dt()
      net: mv643xx_eth: fix an OF node reference leak

Johannes Thumshirn (1):
      btrfs: fix use-after-free in btrfs_encoded_read_endio()

Jonathan Cameron (1):
      iio: adc: ad7192: Convert from of specific to fwnode property handling

Joshua Washington (2):
      gve: guard XSK operations on the existence of queues
      gve: guard XDP xmit NDO on existence of xdp queues

K Prateek Nayak (1):
      softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT kernel

Kalesh AP (3):
      RDMA/bnxt_re: Fix the check for 9060 condition
      RDMA/bnxt_re: Fix reporting hw_ver in query_device
      RDMA/bnxt_re: Disable use of reserved wqes

Kalle Valo (1):
      wifi: ath12k: fix atomic calls in ath12k_mac_op_set_bitrate_mask()

Kang Yang (1):
      wifi: ath10k: avoid NULL pointer error during sdio remove

Karthikeyan Periyasamy (1):
      wifi: ath12k: Optimize the mac80211 hw data access

Kashyap Desai (2):
      RDMA/bnxt_re: Avoid sending the modify QP workaround for latest adapters
      RDMA/bnxt_re: Fix max SGEs for the Work Request

Kees Cook (1):
      seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()

Konstantin Komarov (2):
      fs/ntfs3: Implement fallocate for compressed files
      fs/ntfs3: Fix warning in ni_fiemap

Kuan-Wei Chiu (1):
      scripts/sorttable: fix orc_sort_cmp() to maintain symmetry and transitivity

Laurent Pinchart (1):
      media: uvcvideo: Force UVC version to 1.0a for 0408:4035

Leon Romanovsky (2):
      RDMA/bnxt_re: Remove always true dattr validity check
      ARC: build: Try to guess GCC variant of cross compiler

Li Zhijian (1):
      RDMA/rtrs: Ensure 'ib_sge list' is accessible

Liam Ni (1):
      NUMA: optimize detection of memory with no node id assigned by firmware

Liang Jie (1):
      net: sfc: Correct key_len for efx_tc_ct_zone_ht_params

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix sleeping function called from invalid context

Lukas Wunner (1):
      crypto: ecdsa - Avoid signed integer overflow on signature decoding

Maciej S. Szmigiero (1):
      net: wwan: iosm: Properly check for valid exec stage in ipc_mmio_init()

Mario Limonciello (1):
      thunderbolt: Don't display nvm_version unless upgrade supported

Markus Elfring (1):
      Bluetooth: hci_conn: Reduce hci_conn_drop() calls in two functions

Masahiro Yamada (2):
      modpost: fix input MODULE_DEVICE_TABLE() built for 64-bit on 32-bit host
      modpost: fix the missed iteration for the max bit in do_input()

Mathias Nyman (1):
      xhci: Turn NEC specific quirk for handling Stop Endpoint errors generic

Matthew Wilcox (Oracle) (2):
      tracing: Move readpos from seq_buf to trace_seq
      powerpc: Remove initialisation of readpos

Mauro Carvalho Chehab (1):
      docs: media: update location of the media patches

Max Kellermann (1):
      ceph: give up on paths longer than PATH_MAX

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix clearing of IEP_CMP_CFG registers during iep_init

Michal Pecio (3):
      xhci: retry Stop Endpoint on buggy NEC controllers
      usb: xhci: Limit Stop Endpoint retries
      usb: xhci: Avoid queuing redundant Stop Endpoint commands

Mika Westerberg (2):
      thunderbolt: Add support for Intel Lunar Lake
      thunderbolt: Add support for Intel Panther Lake-M/P

Mike Rapoport (Microsoft) (1):
      memblock: allow zero threshold in validate_numa_converage()

Naman Jain (1):
      x86/hyperv: Fix hv tsc page based sched_clock for hibernation

Namjae Jeon (1):
      ksmbd: set ATTR_CTIME flags when setting mtime

Nathan Lynch (1):
      seq_buf: Make DECLARE_SEQ_BUF() usable

Nikita Travkin (1):
      remoteproc: qcom: pas: Add sc7180 adsp

Nikita Yushchenko (1):
      net: renesas: rswitch: fix possible early skb release

Nikolay Kuratov (1):
      net/sctp: Prevent autoclose integer overflow in sctp_association_init()

Nilay Shroff (2):
      nvme: use helper nvme_ctrl_state in nvme_keep_alive_finish function
      Revert "nvme: make keep-alive synchronous operation"

Nuno Sa (1):
      iio: adc: ad7192: properly check spi_get_device_match_data()

Pablo Neira Ayuso (1):
      netfilter: nft_set_hash: unaligned atomic read on struct nft_set_ext

Paolo Abeni (3):
      mptcp: fix TCP options overflow.
      mptcp: fix recvbuffer adjust on sleeping rcvmsg
      mptcp: don't always assume copied data in mptcp_cleanup_rbuf()

Pascal Hambourg (1):
      sky2: Add device ID 11ab:4373 for Marvell 88E8075

Patrisious Haddad (1):
      RDMA/mlx5: Enforce same type port association for multiport RoCE

Paulo Alcantara (2):
      smb: client: stop flooding dmesg in smb2_calc_signature()
      smb: client: fix use-after-free of signing key

Peter Zijlstra (1):
      cleanup: Add conditional guard support

Ping-Ke Shih (2):
      wifi: mac80211: export ieee80211_purge_tx_queue() for drivers
      wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb

Prike Liang (1):
      drm/amdkfd: Correct the migration DMA map direction

Przemek Kitszel (1):
      cleanup: Adjust scoped_guard() macros to avoid potential warning

Qinxin Xia (1):
      ACPI/IORT: Add PMCG platform information for HiSilicon HIP09A

Rajendra Nayak (1):
      clk: qcom: clk-alpha-pll: Add support for zonda ole pll configure

Ralph Boehme (1):
      fs/smb/client: implement chmod() for SMB3 POSIX Extensions

Ranjan Kumar (1):
      scsi: mpi3mr: Start controller indexing from 0

Ricardo Ribalda (1):
      media: uvcvideo: Force UVC version to 1.0a for 0408:4033

Rob Herring (1):
      of: address: Store number of bus flag cells rather than bool

Robert Beckett (1):
      nvme-pci: 512 byte aligned dma pool segment quirk

Rodrigo Vivi (1):
      drm/i915/dg1: Fix power gate sequence.

Rory Little (1):
      wifi: mac80211: Add non-atomic station iterator

Saravanan Vajravel (1):
      RDMA/bnxt_re: Add check for path mtu in modify_qp

Sebastian Ott (1):
      net/mlx5: unique names for per device caches

Seiji Nishikawa (1):
      mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim()

Selvarasu Ganesan (1):
      usb: dwc3: gadget: Add missing check for single port RAM in TxFIFO resizing logic

Selvin Xavier (6):
      RDMA/bnxt_re: Allow MSN table capability check
      RDMA/bnxt_re: Avoid initializing the software queue for user queues
      RDMA/bnxt_re: Fix max_qp_wrs reported
      RDMA/bnxt_re: Add support for Variable WQE in Genp7 adapters
      RDMA/bnxt_re: Fix the locking while accessing the QP table
      RDMA/bnxt_re: Fix the max WQE size for static WQE support

Shahar Shitrit (1):
      net/mlx5: DR, select MSIX vector 0 for completion queue creation

Shung-Hsi Yu (1):
      Revert "bpf: support non-r10 register spill/fill to/from stack in precision tracking"

Stefan Berger (4):
      crypto: ecdsa - Convert byte arrays with key coordinates to digits
      crypto: ecdsa - Rename keylen to bufsize where necessary
      crypto: ecdsa - Use ecc_digits_from_bytes to convert signature
      crypto: ecc - Prevent ecc_digits_from_bytes from reading too many bytes

Stefan Ekenberg (1):
      drm/bridge: adv7511_audio: Update Audio InfoFrame properly

Steven Rostedt (3):
      tracing: Have process_string() also allow arrays
      tracing: Fix trace_check_vprintf() when tp_printk is used
      tracing: Check "%s" dereference via the field and not the TP_printk format

Steven Rostedt (Google) (1):
      tracing: Handle old buffer mappings for event strings and functions

Sudeep Holla (2):
      i2c: xgene-slimpro: Migrate to use generic PCC shmem related macros
      ACPI: PCC: Add PCC shared memory region command and status bitfields

Takashi Iwai (8):
      ALSA: ump: Use guard() for locking
      ALSA: ump: Don't open legacy substream for an inactive group
      ALSA: ump: Indicate the inactive group in legacy substream names
      ALSA: ump: Update legacy substream names upon FB info update
      ALSA: ump: Shut up truncated string warning
      ALSA: hda/ca0132: Use standard HD-audio quirk matching helpers
      ALSA: seq: Check UMP support for midi_version change
      ALSA: seq: oss: Fix races at processing SysEx messages

Tanya Agarwal (1):
      ALSA: usb-audio: US16x08: Initialize array before use

Tengfei Fan (1):
      remoteproc: qcom: pas: Add support for SA8775p ADSP, CDSP and GPDSP

Thiébaud Weksteen (1):
      selinux: ignore unknown extended permissions

Thomas Gleixner (1):
      sched: Initialize idle tasks only once

Tomer Maimon (1):
      usb: chipidea: add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag

Tristram Ha (2):
      net: dsa: microchip: Fix KSZ9477 set_ageing_time function
      net: dsa: microchip: Fix LAN937X set_ageing_time function

Ulrik Strid (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3602 for MT7925

Uros Bizjak (2):
      cleanup: Remove address space of returned pointer
      irqchip/gic: Correct declaration of *percpu_base pointer in union gic_base

Vasiliy Kovalev (1):
      ALSA: hda/realtek: Add new alc2xx-fixup-headset-mic model

Vitalii Mordan (1):
      eth: bcmsysport: fix call balance of priv->clk handling routines

Wang Liang (1):
      net: fix memory leak in tcp_conn_request()

Willem de Bruijn (1):
      net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets

Xiao Liang (1):
      net: Fix netns for ip_tunnel_init_flow()

Xin Li (2):
      x86/ptrace: Cleanup the definition of the pt_regs structure
      x86/ptrace: Add FRED additional information to the pt_regs structure

Xin Li (Intel) (1):
      x86/fred: Clear WFE in missing-ENDBRANCH #CPs

Xu Yang (2):
      usb: chipidea: add CI_HDRC_HAS_SHORT_PKT_LIMIT flag
      usb: chipidea: udc: limit usb request length to max 16KB

Yafang Shao (1):
      mm/readahead: fix large folio support in async readahead

Yicong Yang (1):
      ACPI/IORT: Add PMCG platform information for HiSilicon HIP10/11

Yihang Li (5):
      scsi: hisi_sas: Directly call register snapshot instead of using workqueue
      scsi: hisi_sas: Allocate DFX memory during dump trigger
      scsi: hisi_sas: Create all dump files during debugfs initialization
      scsi: hisi_sas: Fix a deadlock issue related to automatic dump
      scsi: hisi_sas: Remove redundant checks for automatic debugfs dump

wenglianfa (1):
      RDMA/hns: Fix mapping error of zero-hop WQE buffer


