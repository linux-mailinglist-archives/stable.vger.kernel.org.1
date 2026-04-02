Return-Path: <stable+bounces-232991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICi3KMFazmkxnAYAu9opvQ
	(envelope-from <stable+bounces-232991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:02:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C06388B7E
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D51FB304EC89
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 11:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC173C3C01;
	Thu,  2 Apr 2026 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JbrI88G6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721D3BE64C;
	Thu,  2 Apr 2026 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130675; cv=none; b=S5qhgVsygGKi6PZTi4NCUSJN9S1zDdx0p02JWXgY4QjcOEOjeOlCMVv1FrLJqAi/6ZTXkuamjwEk++2BTS0rlz3EV3FYJ0V+Yg6Oxo3+tKH5EwTdMx358Ee2djWbUsItT6XLJ0ZLplq5Z61h/ArOz7jVG8r5gzdG354bK6f8B5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130675; c=relaxed/simple;
	bh=AoXkF3HRgrIbcQZp+Ee2reYTBOY6kKkPoIElZxTiOAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jXY4xwaUhqqNQtXDV0eONpWvVty8s31wOD1ebE9u8yNr0DH8XLAIwtiZEDDU+Tl3F+v7SxpQcWy7JmNdbbpodxKsnBoBPDn/C+5GtsyV3ka0hMKTfwtw3vbBzjWrj8k+/DU41VXqJzNEGtJ5geKNTZztG0dWfWV/h4ptibuojDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JbrI88G6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F045C2BC9E;
	Thu,  2 Apr 2026 11:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775130675;
	bh=AoXkF3HRgrIbcQZp+Ee2reYTBOY6kKkPoIElZxTiOAo=;
	h=From:To:Cc:Subject:Date:From;
	b=JbrI88G67uUCYfOaDEQM6JepJHSkePjeeR4l6FPFRhr2ebvFhVObDuymkxhqCxPkx
	 2eHEwo915oEhkwZRRnJurpQHK8zUhNldjlfhQ4ePu+MN+SCF+0N0vUWwMQmfi2sydN
	 TT0TxwvYOCg1R/0ioZ6lamRs04DVUcHJzmE2x5uM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.80
Date: Thu,  2 Apr 2026 13:51:07 +0200
Message-ID: <2026040208-puritan-jugular-ac28@gregkh>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232991-lists,stable=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[policy_hthresh.work:query timed out];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C1C06388B7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.12.80 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt             |    3 
 Documentation/filesystems/overlayfs.rst                     |   50 ++
 Documentation/hwmon/adm1177.rst                             |    8 
 Documentation/hwmon/peci-cputemp.rst                        |   10 
 Makefile                                                    |    2 
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts   |   13 
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi         |   22 +
 arch/arm64/kvm/reset.c                                      |   14 
 arch/loongarch/include/asm/linkage.h                        |   36 +
 arch/loongarch/include/asm/sigframe.h                       |    9 
 arch/loongarch/kernel/asm-offsets.c                         |    2 
 arch/loongarch/kernel/env.c                                 |    7 
 arch/loongarch/kernel/signal.c                              |    6 
 arch/loongarch/kvm/vcpu.c                                   |    3 
 arch/loongarch/pci/pci.c                                    |   80 ++++
 arch/loongarch/vdso/Makefile                                |    4 
 arch/loongarch/vdso/sigreturn.S                             |    6 
 arch/powerpc/net/bpf_jit_comp64.c                           |   23 -
 arch/s390/include/asm/barrier.h                             |    4 
 arch/s390/kernel/entry.S                                    |    3 
 arch/s390/kernel/syscall.c                                  |    2 
 arch/sh/drivers/platform_early.c                            |    4 
 arch/x86/kernel/cpu/common.c                                |   20 -
 arch/x86/kvm/mmu/mmu.c                                      |   14 
 arch/x86/platform/efi/quirks.c                              |    2 
 drivers/acpi/ec.c                                           |    2 
 drivers/base/bus.c                                          |   43 ++
 drivers/base/core.c                                         |    2 
 drivers/base/dd.c                                           |   60 +++
 drivers/base/platform.c                                     |   37 -
 drivers/base/regmap/regmap.c                                |   30 +
 drivers/bluetooth/btintel.c                                 |   11 
 drivers/bluetooth/btusb.c                                   |    5 
 drivers/bluetooth/hci_ll.c                                  |    2 
 drivers/bus/simple-pm-bus.c                                 |    4 
 drivers/clk/imx/clk-scu.c                                   |    3 
 drivers/cpufreq/cpufreq_conservative.c                      |   12 
 drivers/cpufreq/cpufreq_governor.c                          |    3 
 drivers/cpufreq/cpufreq_governor.h                          |    1 
 drivers/cxl/core/hdm.c                                      |   25 -
 drivers/cxl/core/port.c                                     |    8 
 drivers/dma/dw-edma/dw-hdma-v0-core.c                       |    6 
 drivers/dma/fsl-edma-main.c                                 |   26 -
 drivers/dma/idxd/cdev.c                                     |    8 
 drivers/dma/idxd/device.c                                   |    7 
 drivers/dma/idxd/submit.c                                   |    2 
 drivers/dma/idxd/sysfs.c                                    |    1 
 drivers/dma/sh/rz-dmac.c                                    |   66 +--
 drivers/dma/xilinx/xdma.c                                   |    4 
 drivers/dma/xilinx/xilinx_dma.c                             |   46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                  |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c                     |   45 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h                     |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                      |    1 
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c                      |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h           |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |    4 
 drivers/gpu/drm/i915/display/intel_display.c                |    8 
 drivers/gpu/drm/i915/display/intel_dp_tunnel.c              |   20 -
 drivers/gpu/drm/i915/display/intel_dp_tunnel.h              |   11 
 drivers/gpu/drm/i915/display/intel_gmbus.c                  |    4 
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c                     |    4 
 drivers/gpu/drm/xe/xe_pt.c                                  |   12 
 drivers/gpu/drm/xe/xe_vm.c                                  |   22 -
 drivers/gpu/drm/xe/xe_vm_types.h                            |    4 
 drivers/hid/hid-apple.c                                     |    7 
 drivers/hid/hid-asus.c                                      |   18 
 drivers/hid/hid-ids.h                                       |    1 
 drivers/hid/hid-magicmouse.c                                |    6 
 drivers/hid/hid-mcp2221.c                                   |    2 
 drivers/hwmon/adm1177.c                                     |   54 +-
 drivers/hwmon/axi-fan-control.c                             |    2 
 drivers/hwmon/peci/cputemp.c                                |    4 
 drivers/hwmon/pmbus/isl68137.c                              |   21 -
 drivers/hwmon/pmbus/pmbus_core.c                            |  117 ++++--
 drivers/i3c/master/dw-i3c-master.c                          |    2 
 drivers/infiniband/core/rw.c                                |   21 -
 drivers/infiniband/hw/irdma/cm.c                            |   29 -
 drivers/infiniband/hw/irdma/utils.c                         |    2 
 drivers/infiniband/hw/irdma/verbs.c                         |    9 
 drivers/irqchip/irq-qcom-mpm.c                              |    3 
 drivers/media/mc/mc-request.c                               |    5 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c        |  156 ++------
 drivers/media/v4l2-core/v4l2-ioctl.c                        |    5 
 drivers/net/ethernet/broadcom/asp2/bcmasp.c                 |  231 ++++-------
 drivers/net/ethernet/broadcom/asp2/bcmasp.h                 |   82 ++--
 drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c         |   75 ---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c            |   38 +
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf_defs.h       |    3 
 drivers/net/ethernet/cadence/macb_main.c                    |   41 +-
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c        |    2 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c              |   31 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c                |   14 
 drivers/net/ethernet/intel/ice/ice_main.c                   |    3 
 drivers/net/ethernet/intel/ice/ice_ptp.c                    |   17 
 drivers/net/ethernet/intel/ice/ice_ptp.h                    |    5 
 drivers/net/ethernet/intel/ice/ice_repr.c                   |    5 
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c          |   24 -
 drivers/net/ethernet/intel/idpf/idpf.h                      |    2 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                  |  233 ++++++------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                 |   38 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                 |    5 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c             |    9 
 drivers/net/ethernet/microchip/lan743x_main.c               |    5 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c             |   17 
 drivers/net/team/team_core.c                                |   65 +++
 drivers/net/usb/r8152.c                                     |    1 
 drivers/net/virtio_net.c                                    |    1 
 drivers/nvme/host/fabrics.c                                 |    4 
 drivers/nvme/host/pci.c                                     |   11 
 drivers/nvme/target/admin-cmd.c                             |    2 
 drivers/nvme/target/core.c                                  |   14 
 drivers/nvme/target/nvmet.h                                 |    1 
 drivers/nvme/target/rdma.c                                  |    1 
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c                     |    3 
 drivers/phy/ti/phy-j721e-wiz.c                              |    2 
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c               |    9 
 drivers/platform/olpc/olpc-xo175-ec.c                       |    2 
 drivers/platform/x86/intel/hid.c                            |   23 +
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c |    2 
 drivers/platform/x86/touchscreen_dmi.c                      |   18 
 drivers/scsi/ibmvscsi/ibmvfc.c                              |    3 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                             |   10 
 drivers/scsi/scsi_devinfo.c                                 |    2 
 drivers/scsi/scsi_transport_sas.c                           |    2 
 drivers/scsi/ses.c                                          |    2 
 drivers/slimbus/qcom-ngd-ctrl.c                             |    6 
 drivers/spi/spi-fsl-lpspi.c                                 |    3 
 drivers/spi/spi-intel-pci.c                                 |    1 
 drivers/spi/spi-meson-spicc.c                               |    2 
 drivers/spi/spi-sn-f-ospi.c                                 |   17 
 drivers/spi/spi-tegra210-quad.c                             |   20 +
 drivers/spi/spi.c                                           |   19 
 drivers/usb/core/config.c                                   |    6 
 drivers/usb/core/quirks.c                                   |    5 
 drivers/virt/coco/tdx-guest/tdx-guest.c                     |   14 
 drivers/xen/privcmd.c                                       |    3 
 fs/btrfs/block-group.c                                      |    2 
 fs/btrfs/disk-io.c                                          |    4 
 fs/btrfs/ioctl.c                                            |    7 
 fs/btrfs/volumes.c                                          |    5 
 fs/erofs/fileio.c                                           |    6 
 fs/erofs/zdata.c                                            |    3 
 fs/ext4/crypto.c                                            |    9 
 fs/ext4/ext4.h                                              |    1 
 fs/ext4/extents.c                                           |   23 +
 fs/ext4/fast_commit.c                                       |   13 
 fs/ext4/fsync.c                                             |   16 
 fs/ext4/ialloc.c                                            |    6 
 fs/ext4/inline.c                                            |   10 
 fs/ext4/inode.c                                             |   12 
 fs/ext4/mballoc.c                                           |   30 -
 fs/ext4/page-io.c                                           |   10 
 fs/ext4/super.c                                             |   16 
 fs/ext4/sysfs.c                                             |   10 
 fs/jbd2/checkpoint.c                                        |   15 
 fs/netfs/iterator.c                                         |   43 ++
 fs/overlayfs/copy_up.c                                      |    6 
 fs/overlayfs/overlayfs.h                                    |   21 +
 fs/overlayfs/ovl_entry.h                                    |    7 
 fs/overlayfs/params.c                                       |   42 +-
 fs/overlayfs/super.c                                        |    2 
 fs/overlayfs/util.c                                         |    5 
 fs/smb/server/oplock.c                                      |   72 ++-
 fs/smb/server/smb2pdu.c                                     |   73 ++-
 fs/xfs/scrub/quota.c                                        |    4 
 fs/xfs/scrub/trace.h                                        |   12 
 fs/xfs/xfs_attr_item.c                                      |    5 
 fs/xfs/xfs_dquot_item.c                                     |    9 
 fs/xfs/xfs_inode_item.c                                     |    9 
 fs/xfs/xfs_mount.c                                          |    7 
 fs/xfs/xfs_trace.h                                          |   47 +-
 fs/xfs/xfs_trans_ail.c                                      |   26 -
 include/linux/device.h                                      |   54 ++
 include/linux/device/bus.h                                  |    4 
 include/linux/dma-mapping.h                                 |    4 
 include/linux/platform_device.h                             |    5 
 include/linux/spi/spi.h                                     |   42 +-
 include/linux/usb/quirks.h                                  |    3 
 include/linux/usb/r8152.h                                   |    1 
 include/net/inet_hashtables.h                               |   14 
 include/net/ip6_fib.h                                       |   21 +
 include/uapi/linux/dma-buf.h                                |    1 
 include/uapi/linux/netfilter/nf_conntrack_common.h          |    4 
 kernel/bpf/btf.c                                            |   24 +
 kernel/bpf/core.c                                           |   43 +-
 kernel/bpf/verifier.c                                       |    2 
 kernel/dma/swiotlb.c                                        |   21 -
 kernel/events/core.c                                        |   19 
 kernel/futex/pi.c                                           |    3 
 kernel/futex/syscalls.c                                     |    8 
 kernel/module/main.c                                        |    7 
 kernel/power/snapshot.c                                     |   11 
 kernel/sched/ext.c                                          |    2 
 kernel/sysctl.c                                             |    2 
 kernel/time/alarmtimer.c                                    |    2 
 kernel/trace/trace_osnoise.c                                |   48 --
 mm/damon/sysfs.c                                            |    3 
 net/bluetooth/l2cap_core.c                                  |   34 +
 net/bluetooth/l2cap_sock.c                                  |    3 
 net/bluetooth/mgmt.c                                        |    2 
 net/bluetooth/sco.c                                         |   10 
 net/can/af_can.c                                            |    4 
 net/can/af_can.h                                            |    2 
 net/can/gw.c                                                |    6 
 net/can/isotp.c                                             |   24 -
 net/can/proc.c                                              |    3 
 net/core/net-procfs.c                                       |   49 +-
 net/core/rtnetlink.c                                        |    9 
 net/ipv4/esp4.c                                             |   11 
 net/ipv4/inet_connection_sock.c                             |   22 -
 net/ipv4/udp.c                                              |    2 
 net/ipv6/addrconf.c                                         |    4 
 net/ipv6/esp6.c                                             |   11 
 net/ipv6/ip6_fib.c                                          |   15 
 net/ipv6/netfilter/ip6t_rt.c                                |    4 
 net/ipv6/route.c                                            |    2 
 net/ipv6/xfrm6_output.c                                     |    4 
 net/key/af_key.c                                            |   19 
 net/netfilter/nf_conntrack_expect.c                         |    4 
 net/netfilter/nf_conntrack_netlink.c                        |   16 
 net/netfilter/nf_conntrack_proto_tcp.c                      |   10 
 net/netfilter/nf_conntrack_sip.c                            |   14 
 net/netfilter/nfnetlink_log.c                               |    8 
 net/nfc/nci/core.c                                          |   10 
 net/openvswitch/flow_netlink.c                              |    2 
 net/openvswitch/vport-netdev.c                              |   11 
 net/packet/af_packet.c                                      |    1 
 net/smc/smc_rx.c                                            |    9 
 net/tls/tls_sw.c                                            |    2 
 net/xfrm/xfrm_interface_core.c                              |    2 
 net/xfrm/xfrm_nat_keepalive.c                               |    2 
 net/xfrm/xfrm_output.c                                      |    7 
 net/xfrm/xfrm_policy.c                                      |    4 
 net/xfrm/xfrm_state.c                                       |    1 
 net/xfrm/xfrm_user.c                                        |    7 
 rust/kernel/init/macros.rs                                  |  165 ++++++--
 scripts/package/install-extmod-build                        |    4 
 security/landlock/errata/abi-1.h                            |   16 
 security/landlock/fs.c                                      |   78 ++--
 sound/firewire/amdtp-stream.c                               |    2 
 sound/pci/hda/patch_realtek.c                               |   41 +-
 sound/pci/hda/patch_senarytech.c                            |    5 
 sound/soc/codecs/adau1372.c                                 |   34 +
 sound/soc/codecs/ak4458.c                                   |   13 
 sound/soc/fsl/fsl_easrc.c                                   |   14 
 sound/soc/intel/catpt/device.c                              |   10 
 sound/soc/intel/catpt/dsp.c                                 |    3 
 sound/soc/samsung/i2s.c                                     |    6 
 sound/soc/sof/ipc4-topology.c                               |    2 
 tools/objtool/arch/x86/decode.c                             |   62 +--
 tools/objtool/check.c                                       |   14 
 253 files changed, 2821 insertions(+), 1464 deletions(-)

Aaron Ma (1):
      ice: Fix PTP NULL pointer dereference during VSI rebuild

Abel Vesa (1):
      phy: qcom: qmp-ufs: Fix SM8650 PCS table for Gear 4

Alan Borzeszkowski (1):
      spi: intel-pci: Add support for Nova Lake mobile SPI flash

Alberto Garcia (1):
      PM: hibernate: Drain trailing zero pages on userspace restore

Alexander Stein (1):
      dmaengine: xilinx: xdma: Fix regmap init error handling

Alexey Nepomnyashih (1):
      ALSA: firewire-lib: fix uninitialized local variable

Ali Norouzi (1):
      can: gw: fix OOB heap access in cgw_csum_crc8_rel()

Alison Schofield (1):
      cxl/port: Fix use after free of parent_port in cxl_detach_ep()

Alok Tiwari (1):
      platform/olpc: olpc-xo175-ec: Fix overflow error message to print inlen

Amir Goldstein (1):
      ovl: fix wrong detection of 32bit inode numbers

Anas Iqbal (1):
      Bluetooth: hci_ll: Fix firmware leak on error path

Andy Shevchenko (2):
      regmap: Synchronize cache for the page selector
      spi: Group CS related fields in struct spi_device

Anil Samal (1):
      RDMA/irdma: Fix deadlock during netdev reset with active connections

Baokun Li (1):
      ext4: fix iloc.bh leak in ext4_fc_replay_inode() error paths

Benno Lossin (2):
      rust: pin-init: add references to previously initialized fields
      rust: pin-init: internal: init: document load-bearing fact of field accessors

Boris Burkov (1):
      btrfs: set BTRFS_ROOT_ORPHAN_CLEANUP during subvol create

Borislav Petkov (AMD) (1):
      x86/cpu: Remove X86_CR4_FRED from the CR4 pinned bits mask

Breno Leitao (1):
      spi: tegra210-quad: Protect curr_xfer check in IRQ handler

Cen Zhang (1):
      Bluetooth: btintel: serialize btintel_hw_error() with hci_req_sync_lock

Cezary Rojewski (1):
      ASoC: Intel: catpt: Fix the device initialization

Chaitanya Kulkarni (1):
      nvmet: move async event work off nvmet-wq

Chuck Lever (2):
      tls: Purge async_hold in tls_decrypt_async_wait()
      RDMA/rw: Fall back to direct SGE on MR pool exhaustion

Claudiu Beznea (2):
      dmaengine: sh: rz-dmac: Protect the driver specific lists
      dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock

Daniel Hodges (1):
      nvme-fabrics: use kfree_sensitive() for DHCHAP secrets

Daniel Wade (1):
      bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR

Danilo Krummrich (5):
      hwmon: axi-fan: don't use driver_override as IRQ name
      sh: platform_early: remove pdev->driver_override check
      driver core: generalize driver_override in struct device
      driver core: platform: use generic driver_override infrastructure
      spi: use generic driver_override infrastructure

Darrick J. Wong (2):
      xfs: don't irele after failing to iget in xfs_attri_recover_work
      xfs: remove file_path tracepoint data

David Carlier (1):
      netfilter: ctnetlink: use netlink policy range checks

David McFarland (1):
      platform/x86: intel-hid: disable wakeup_mode during hibernation

Davidlohr Bueso (1):
      futex: Clear stale exiting pointer in futex_lock_pi() retry path

Deepanshu Kartikey (2):
      ext4: convert inline data to extents when truncate exceeds inline size
      netfs: Fix kernel BUG in netfs_limit_iter() for ITER_KVEC iterators

Denis Benato (1):
      HID: asus: add xg mobile 2023 external hardware support

Edward Adam Davis (1):
      ext4: avoid infinite loops caused by residual data

Emil Tantilov (2):
      idpf: check error for register_netdev() on init
      idpf: detach and close netdevs while handling a reset

Eric Dumazet (3):
      af_key: validate families in pfkey_send_migrate()
      tcp: optimize inet_use_bhash2_on_bind()
      net: add proper RCU protection to /proc/net/ptype

Eric Huang (1):
      drm/amdgpu: prevent immediate PASID reuse case

Fei Lv (1):
      ovl: make fsync after metadata copy-up opt-in mount option

Felix Gu (3):
      spi: sn-f-ospi: Fix resource leak in f_ospi_probe()
      spi: meson-spicc: Fix double-put in remove path
      phy: ti: j721e-wiz: Fix device node reference leak in wiz_get_lane_phy_types()

Filipe Manana (1):
      btrfs: fix lost error when running device stats on multiple devices fs

Florian Fainelli (1):
      net: bcmasp: Restore programming of TX map vector register

Florian Fuchs (1):
      scsi: devinfo: Add BLIST_SKIP_IO_HINTS for Iomega ZIP

Greg Kroah-Hartman (3):
      s390/syscalls: Add spectre boundary for syscall dispatch table
      scsi: ses: Handle positive SCSI error from ses_recv_diag()
      Linux 6.12.80

Guenter Roeck (3):
      hwmon: (pmbus/core) Fix various coding style issues
      hwmon: (pmbus) Mark lowest/average/highest/rated attributes as read-only
      hwmon: (pmbus) Introduce the concept of "write-only" attributes

GuoHan Zhao (1):
      xen/privcmd: unregister xenstore notifier on module exit

Günther Noack (3):
      HID: asus: avoid memory leak in asus_report_fixup()
      HID: magicmouse: avoid memory leak in magicmouse_report_fixup()
      HID: apple: avoid memory leak in apple_report_fixup()

Hans de Goede (1):
      platform/x86: touchscreen_dmi: Add quirk for y-inverted Goodix touchscreen on SUPI S10

Hari Bathini (1):
      powerpc64/bpf: do not increment tailcall count when prog is NULL

Helen Koike (2):
      Bluetooth: L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb
      ext4: reject mount if bigalloc with s_first_data_block != 0

Huacai Chen (2):
      LoongArch: Workaround LS2K/LS7A GPU DMA hang bug
      LoongArch: KVM: Make kvm_get_vcpu_by_cpuid() more robust

Hyunwoo Kim (5):
      xfrm: Fix work re-schedule after cancel in xfrm_nat_keepalive_net_fini()
      Bluetooth: L2CAP: Validate PDU length before reading SDU length in l2cap_ecred_data_rcv()
      Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold
      Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len infinite loop
      ksmbd: do not expire session on binding failure

Ihor Solodrai (1):
      module: Fix kernel panic when a symbol st_shndx is out of bounds

Imre Deak (1):
      drm/i915/dp_tunnel: Fix error handling when clearing stream BW in atomic state

Isaac J. Manjarres (1):
      dma-buf: Include ioctl.h in UAPI header

Ivan Barrera (1):
      RDMA/irdma: Clean up unnecessary dereference of event->cm_node

Jacob Moroni (1):
      RDMA/irdma: Initialize free_qp completion before using it

Jakub Kicinski (1):
      nfc: nci: fix circular locking dependency in nci_close_device

Jan Kara (3):
      ext4: fix stale xarray tags after writeback
      ext4: fix fsync(2) for nojournal mode
      ext4: make recently_deleted() properly work with lazy itable initialization

Jassi Brar (1):
      irqchip/qcom-mpm: Add missing mailbox TX done acknowledgment

Jenny Guanni Qu (1):
      bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN

Jiayuan Chen (2):
      team: fix header_ops type confusion with non-Ethernet ports
      ext4: fix use-after-free in update_super_work when racing with umount

Jie Deng (1):
      usb: core: new quirk to handle devices with zero configurations

Jihed Chaibi (2):
      ASoC: adau1372: Fix unchecked clk_prepare_enable() return value
      ASoC: adau1372: Fix clock leak on PLL lock failure

Jiucheng Xu (1):
      erofs: add GFP_NOIO in the bio completion if needed

Josh Law (1):
      mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]

Josh Poimboeuf (1):
      objtool: Handle Clang RSP musical chairs

Joy Zou (1):
      dmaengine: fsl-edma: fix channel parameter config for fixed channel requests

Julius Lehmann (1):
      HID: magicmouse: fix battery reporting for Apple Magic Trackpad 2

Justin Chen (6):
      net: bcmasp: Remove support for asp-v2.0
      net: bcmasp: streamline early exit in probe
      net: bcmasp: fix double free of WoL irq
      net: bcmasp: Add support for asp-v3.0
      net: bcmasp: fix double disable of clk
      net: bcmasp: Fix network filter wake for asp-3.0

Keith Busch (2):
      nvme-pci: cap queue creation to used queues
      nvme-pci: ensure we're polling a polled queue

Kevin Hao (3):
      net: macb: Move devm_{free,request}_irq() out of spin lock area
      net: macb: Protect access to net_device::ip_ptr with RCU lock
      net: macb: Use dev_consume_skb_any() to free TX SKBs

Kohei Enju (1):
      iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()

Kumar Kartikeya Dwivedi (1):
      bpf: Release module BTF IDR before module unload

Kuniyuki Iwashima (2):
      ipv6: Remove permanent routes from tb6_gc_hlist when all exceptions expire.
      ipv6: Don't remove permanent routes with exceptions from tb6_gc_hlist.

LUO Haowen (1):
      dmaengine: dw-edma: Fix multiple times setting of the CYCLE_STATE and CYCLE_BIT bits for HDMA.

Leif Skunberg (1):
      platform/x86: intel-hid: Enable 5-button array on ThinkPad X1 Fold 16 Gen 1

Li Jun (1):
      LoongArch: Fix missing NULL checks for kstrdup()

Li Li (1):
      idpf: nullify pointers after they are freed

Liucheng Lu (1):
      ALSA: hda/realtek: add HP Laptop 14s-dr5xxx mute LED quirk

Long Li (1):
      xfs: fix ri_total validation in xlog_recover_attri_commit_pass2

Luca Leonardo Scorcia (1):
      pinctrl: mediatek: common: Fix probe failure for devices without EINT

Luiz Augusto von Dentz (1):
      Bluetooth: MGMT: Fix dangling pointer on mgmt_add_adv_patterns_monitor_complete

Luo Haiyang (1):
      tracing: Fix potential deadlock in cpu hotplug with osnoise

Maarten Lankhorst (1):
      drm/ttm/tests: Fix build failure on PREEMPT_RT

Marc Buerg (1):
      sysctl: fix uninitialized variable in proc_do_large_bitmap

Marc Kleine-Budde (1):
      spi: spi-fsl-lpspi: fix teardown order issue (UAF)

Marc Zyngier (1):
      KVM: arm64: Discard PC update state on vcpu reset

Marek Vasut (3):
      dmaengine: xilinx: xilinx_dma: Fix dma_device directions
      dmaengine: xilinx: xilinx_dma: Fix residue calculation for cyclic DMA
      dmaengine: xilinx: xilinx_dma: Fix unmasked residue subtraction

Mark Brown (2):
      ASoC: fsl_easrc: Fix event generation in fsl_easrc_iec958_set_reg()
      ASoC: fsl_easrc: Fix event generation in fsl_easrc_iec958_put_bits()

Mark Harmstone (1):
      btrfs: fix super block offset in error message in btrfs_validate_super()

Markus Niebel (1):
      arm64: dts: imx8mn-tqma8mqnl: fix LDO5 power off

Martin KaFai Lau (1):
      udp: Fix wildcard bind conflict check when using hash2

Mateusz Polchlopek (1):
      ice: fix using untrusted value of pkt_len in ice_vc_fdir_parse_raw()

Matthew Auld (1):
      drm/xe: always keep track of remap prev/next

Mickaël Salaün (2):
      landlock: Optimize file path walks and prepare for audit support
      landlock: Fix handling of disconnected directories

Miguel Ojeda (1):
      dma-mapping: add missing `inline` for `dma_free_attrs`

Mike Rapoport (Microsoft) (1):
      x86/efi: efi_unmap_boot_services: fix calculation of ranges_to_free size

Milos Nikic (1):
      jbd2: gracefully abort on checkpointing state corruptions

Minseo Park (1):
      Bluetooth: L2CAP: Fix stack-out-of-bounds read in l2cap_ecred_conn_req

Minwoo Ra (1):
      xfrm: prevent policy_hthresh.work from racing with netns teardown

Mohammad Heib (1):
      ionic: fix persistent MAC address override on PF

Namjae Jeon (2):
      ksmbd: replace hardcoded hdr2_len with offsetof() in smb2_calc_max_out_buf_len()
      ksmbd: fix potencial OOB in get_file_all_info() for compound requests

Nikunj A Dadhania (1):
      x86/cpu: Enable FSGSBASE early in cpu_init_exception_handling()

Oliver Hartkopp (2):
      can: statistics: add missing atomic access in hot path
      can: isotp: fix tx.buf use-after-free in isotp_sendmsg()

Pablo Neira Ayuso (1):
      netfilter: nf_conntrack_expect: skip expectations in other netns via proc

Paolo Valerio (1):
      net: macb: use the current queue number for stats

Pengpeng Hou (1):
      Bluetooth: btusb: clamp SCO altsetting table indices

Peter Metz (1):
      platform/x86: intel-hid: Add Dell 14 Plus 2-in-1 to dmi_vgbs_allow_list

Peter Ujfalusi (1):
      ASoC: SOF: ipc4-topology: Allow bytes controls without initial payload

Peter Yin (1):
      i3c: master: dw-i3c: Fix missing of_node for virtual I2C adapter

Peter Zijlstra (2):
      perf: Make sure to use pmu_ctx->pmu for groups
      futex: Require sys_futex_requeue() to have identical flags

Petr Oros (2):
      ice: fix inverted ready check for VF representors
      ice: use ice_update_eth_stats() for representor stats

Qi Tang (1):
      net/smc: fix double-free of smc_spd_priv when tee() duplicates splice pipe buffer

Ranjan Kumar (1):
      scsi: mpi3mr: Clear reset history on ready and recheck state after timeout

Ren Wei (1):
      netfilter: ip6t_rt: reject oversized addrnr in rt_mt6_check()

Richard Leitner (1):
      media: nxp: imx8-isi: Fix streaming cleanup on release

Romain Sioen (1):
      HID: mcp2221: cancel last I2C command on read error

Russell King (Oracle) (3):
      net: bcm: asp2: fix LPI timer handling
      net: bcm: asp2: remove tx_lpi_enabled
      net: bcm: asp2: convert to phylib managed EEE

Sabrina Dubroca (5):
      xfrm: add missing extack for XFRMA_SA_PCPU in add_acquire and allocspi
      xfrm: fix the condition on x->pcpu_num in xfrm_sa_len
      xfrm: call xdo_dev_state_delete during state update
      esp: fix skb leak with espintcp and async crypto
      rtnetlink: count IFLA_INFO_SLAVE_KIND in if_nlmsg_size

Sachin Kumar (1):
      bpf: Fix constant blinding for PROBE_MEM32 stores

Samasth Norway Ananda (1):
      drm/i915/gmbus: fix spurious timeout on 512-byte burst reads

Sanman Pradhan (4):
      hwmon: (adm1177) fix sysfs ABI violation and current unit conversion
      hwmon: (pmbus/isl68137) Add mutex protection for AVS enable sysfs attributes
      hwmon: (peci/cputemp) Fix crit_hyst returning delta instead of absolute temperature
      hwmon: (peci/cputemp) Fix off-by-one in cputemp_is_visible()

Sean Christopherson (1):
      KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE

Sean Rhodes (1):
      ALSA: hda/realtek: Sequence GPIO2 on Star Labs StarFighter

Sheng Yong (1):
      erofs: set fileio bio failed in short read case

Shigeru Yoshida (1):
      dma: swiotlb: add KMSAN annotations to swiotlb_bounce()

Shin'ichiro Kawasaki (1):
      btrfs: fix leak of kobject name for sub-group space_info

Simon Weber (1):
      ext4: fix journal credit check when setting fscrypt context

Smita Koralahalli (1):
      cxl/hdm: Avoid incorrect DVSEC fallback when HDM decoders are enabled

Sreedevi Joshi (2):
      idpf: Fix RSS LUT NULL pointer crash on early ethtool operations
      idpf: Fix RSS LUT NULL ptr issue after soft reset

Srinivas Pandruvada (1):
      platform/x86: ISST: Correct locked bit width

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix fence put before wait in amdgpu_amdkfd_submit_ib

Steffen Klassert (1):
      xfrm: Fix the usage of skb->sk

Steven Rostedt (1):
      tracing: Switch trace_osnoise.c code over to use guard() and __free()

Takashi Iwai (2):
      HID: apple: Add EPOMAKER TH87 to the non-apple keyboards list
      ASoC: ak4458: Convert to RUNTIME_PM_OPS() & co

Tatyana Nikolova (4):
      RDMA/irdma: Update ibqp state to error if QP is already in error state
      RDMA/irdma: Remove a NOP wait_event() in irdma_modify_qp_roce()
      RDMA/irdma: Remove reset check from irdma_modify_qp_to_err()
      RDMA/irdma: Return EINVAL for invalid arp index error

Tejas Bharambe (1):
      ext4: validate p_idx bounds in ext4_ext_correct_indexes

Thangaraj Samynathan (1):
      net: lan743x: fix duplex configuration in mac_link_up

Theodore Ts'o (2):
      ext4: handle wraparound when searching for blocks for indirect mapped blocks
      ext4: always drain queued discard work in ext4_mb_release()

Thomas Weißschuh (1):
      kbuild: install-extmod-build: Package resolve_btfids if necessary

Thorsten Blum (1):
      ovl: Use str_on_off() helper in ovl_show_options()

Toke Høiland-Jørgensen (1):
      net: openvswitch: Avoid releasing netdev before teardown completes

Tomi Valkeinen (1):
      dmaengine: xilinx_dma: Fix reset related timeout with two-channel AXIDMA

Tuo Li (1):
      dmaengine: idxd: fix possible wrong descriptor completion in llist_abort_desc()

Tyllis Xu (1):
      scsi: ibmvfc: Fix OOB access in ibmvfc_discover_targets_done()

Uzair Mughal (1):
      ALSA: hda/realtek: Add headset jack quirk for Thinkpad X390

Valentin Spreckels (1):
      net: usb: r8152: add TRENDnet TUC-ET2G

Vasily Gorbik (2):
      s390/barrier: Make array_index_mask_nospec() __always_inline
      s390/entry: Scrub r12 register on kernel entry

Vinicius Costa Gomes (4):
      dmaengine: idxd: Fix not releasing workqueue on .release()
      dmaengine: idxd: Fix memory leak when a wq is reset
      dmaengine: idxd: Fix freeing the allocated ida too late
      dmaengine: idxd: Fix leaking event log memory

Viresh Kumar (1):
      cpufreq: conservative: Reset requested_freq on limits change

Wei Fang (1):
      net: enetc: fix the output issue of 'ethtool --show-ring'

Weiming Shi (3):
      netfilter: nfnetlink_log: fix uninitialized padding leak in NFULA_PAYLOAD
      netfilter: nf_conntrack_sip: fix use of uninitialized rtp_addr in process_sdp
      ACPI: EC: clean up handlers on probe failure in acpi_ec_setup()

Werner Kasselman (2):
      ksmbd: fix memory leaks and NULL deref in smb2_lock()
      ksmbd: fix use-after-free and NULL deref in smb_grant_oplock()

Xi Ruoyao (1):
      LoongArch: vDSO: Emit GNU_EH_FRAME correctly

Yang Wang (1):
      drm/amdgpu: fix gpu idle power consumption issue for gfx v12

Yang Yang (2):
      openvswitch: defer tunnel netdev_put to RCU release
      openvswitch: validate MPLS set/set_masked payload length

Ye Bin (1):
      ext4: avoid allocate block from corrupted group in ext4_mb_find_by_goal()

Yihang Li (1):
      scsi: scsi_transport_sas: Fix the maximum channel scanning issue

Yochai Eisenrich (1):
      net: fix fanout UAF in packet_release() via NETDEV_UP race

Yuchan Nam (1):
      media: mc, v4l2: serialize REINIT and REQBUFS with req_queue_mutex

Yussuf Khalil (1):
      drm/amd/display: Do not skip unrelated mode changes in DSC validation

Yuto Ohnuki (4):
      xfs: stop reclaim before pushing AIL during unmount
      xfs: save ailp before dropping the AIL lock in push callbacks
      ext4: replace BUG_ON with proper error handling in ext4_read_inline_folio
      xfs: avoid dereferencing log items after push callbacks

Zhan Xusheng (1):
      alarmtimer: Fix argument order in alarm_timer_forward()

Zhang Chen (1):
      Bluetooth: L2CAP: Fix send LE flow credits in ACL link

Zhang Heng (1):
      ALSA: hda/realtek: add quirk for ASUS UM6702RC

Zqiang (1):
      ext4: fix the might_sleep() warnings in kvfree()

Zubin Mithra (1):
      virt: tdx-guest: Fix handling of host controlled 'quote' buffer length

hongao (1):
      xfs: scrub: unlock dquot before early return in quota scrub

wangdicheng (1):
      ALSA: hda/senary: Ensure EAPD is enabled during init

xietangxin (1):
      virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false

zhidao su (1):
      sched_ext: Use WRITE_ONCE() for the write side of dsq->seq update


