Return-Path: <stable+bounces-86626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AA29A23F8
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 15:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85591C221C8
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1C21DE4CB;
	Thu, 17 Oct 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FmyDema4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8FC1DE4C6;
	Thu, 17 Oct 2024 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172117; cv=none; b=B+3j+guenaWotTuJ9QnbG8Kre4HF2kcBLtI7QWlAj8HCEw0a3VWW8iAMJ+shciqdeUpiWwrW78PB6xOnbVkfR+T/t0P/EM8/z/A0YxCILNknFdtNR46Or7ITHR8eTVWuUO3RsxuVtBSRTUn+p0mAUUVmk7TfO91gb0VrmVfKPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172117; c=relaxed/simple;
	bh=kSHMpYi3Dg7nvPYQ77jUVis5FfFTfVlbDtOBPOU1e5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RUJdWFMka+sXf/2KBIl4KkyYLFELML/nDoTL8s75AEKjP/4TvwCGi3xWE0/5pYyj7UZ7z9skJb5mhZHIR4kR9mIKbwfiVmcykxfhIS8VSENnJwCKIAEVD2NXxWmplqDzPr+bqoANTAFJbBvIHocsIZOXJUgyHd1m20Kp3hy+TCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FmyDema4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AF8C4CECD;
	Thu, 17 Oct 2024 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729172116;
	bh=kSHMpYi3Dg7nvPYQ77jUVis5FfFTfVlbDtOBPOU1e5U=;
	h=From:To:Cc:Subject:Date:From;
	b=FmyDema4wVB10Y6JHa4swwIOPUSCHEZm/7XOSJbiuh7726Tn/4ulVefJ9eb6EZb4E
	 HjeFQTdAVmnKpKDQJlMq3VddmiZS3Qufo1B/NHEF5bFgsLud9x/phzkS80X41066n6
	 Ci5XN9g7TWbFvxQUze4LI4MQKwPpZ7mEMjn4Y9WU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.11.4
Date: Thu, 17 Oct 2024 15:34:49 +0200
Message-ID: <2024101749-avenue-compactor-406a@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.11.4 kernel.

All users of the 6.11 kernel series must upgrade.

The updated 6.11.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.11.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                             |    2 
 arch/loongarch/pci/acpi.c                                            |    1 
 arch/riscv/include/asm/sparsemem.h                                   |    2 
 arch/riscv/include/asm/string.h                                      |    2 
 arch/riscv/kernel/elf_kexec.c                                        |    6 
 arch/riscv/kernel/entry.S                                            |    4 
 arch/riscv/kernel/riscv_ksyms.c                                      |    3 
 arch/riscv/lib/Makefile                                              |    2 
 arch/riscv/lib/strcmp.S                                              |    1 
 arch/riscv/lib/strlen.S                                              |    1 
 arch/riscv/lib/strncmp.S                                             |    1 
 arch/riscv/purgatory/Makefile                                        |    2 
 arch/s390/include/asm/facility.h                                     |    6 
 arch/s390/include/asm/io.h                                           |    2 
 arch/s390/kernel/early.c                                             |   17 
 arch/s390/kernel/perf_cpum_sf.c                                      |   12 
 arch/s390/mm/cmm.c                                                   |   18 
 arch/x86/kernel/amd_nb.c                                             |    3 
 arch/x86/net/bpf_jit_comp.c                                          |   54 
 arch/x86/xen/enlighten_pv.c                                          |    4 
 drivers/acpi/resource.c                                              |   29 
 drivers/ata/libata-eh.c                                              |   18 
 drivers/base/bus.c                                                   |    8 
 drivers/base/power/common.c                                          |   25 
 drivers/block/zram/zram_drv.c                                        |    7 
 drivers/bluetooth/btusb.c                                            |   20 
 drivers/char/virtio_console.c                                        |   18 
 drivers/clk/bcm/clk-bcm53573-ilp.c                                   |    2 
 drivers/clk/imx/clk-imx7d.c                                          |    4 
 drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c            |    5 
 drivers/dax/device.c                                                 |    2 
 drivers/gpio/gpio-aspeed.c                                           |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                     |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                             |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                    |    7 
 drivers/gpu/drm/amd/display/dc/core/dc.c                             |   47 
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h                         |   26 
 drivers/gpu/drm/drm_fbdev_dma.c                                      |    3 
 drivers/gpu/drm/i915/display/intel_hdcp.c                            |   10 
 drivers/gpu/drm/nouveau/dispnv04/crtc.c                              |    2 
 drivers/gpu/drm/nouveau/nouveau_abi16.c                              |    2 
 drivers/gpu/drm/nouveau/nouveau_bo.c                                 |    2 
 drivers/gpu/drm/nouveau/nouveau_chan.c                               |   21 
 drivers/gpu/drm/nouveau/nouveau_chan.h                               |    3 
 drivers/gpu/drm/nouveau/nouveau_dmem.c                               |    2 
 drivers/gpu/drm/nouveau/nouveau_drm.c                                |    4 
 drivers/gpu/drm/v3d/v3d_perfmon.c                                    |    9 
 drivers/gpu/drm/vc4/vc4_perfmon.c                                    |    7 
 drivers/gpu/drm/xe/xe_bb.c                                           |    3 
 drivers/gpu/drm/xe/xe_debugfs.c                                      |    2 
 drivers/gpu/drm/xe/xe_gt.c                                           |    4 
 drivers/gpu/drm/xe/xe_guc_ct.c                                       |   44 
 drivers/gpu/drm/xe/xe_guc_submit.c                                   |    9 
 drivers/hid/amd-sfh-hid/amd_sfh_client.c                             |   14 
 drivers/hid/hid-ids.h                                                |    3 
 drivers/hid/hid-multitouch.c                                         |    8 
 drivers/hid/hid-plantronics.c                                        |   23 
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c                          |    2 
 drivers/hid/wacom_wac.c                                              |    2 
 drivers/hwmon/Kconfig                                                |    5 
 drivers/hwmon/intel-m10-bmc-hwmon.c                                  |    2 
 drivers/hwmon/k10temp.c                                              |    1 
 drivers/i2c/busses/i2c-i801.c                                        |    9 
 drivers/i3c/master/i3c-master-cdns.c                                 |    1 
 drivers/infiniband/core/mad.c                                        |   14 
 drivers/infiniband/hw/mlx5/odp.c                                     |   25 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                               |   13 
 drivers/md/dm-vdo/dedupe.c                                           |    3 
 drivers/media/common/videobuf2/videobuf2-core.c                      |    8 
 drivers/mfd/intel-lpss-pci.c                                         |   39 
 drivers/mfd/intel_soc_pmic_chtwc.c                                   |    1 
 drivers/mmc/host/mvsdio.c                                            |   71 
 drivers/mmc/host/sdhci-of-dwcmshc.c                                  |    8 
 drivers/net/dsa/b53/b53_common.c                                     |   17 
 drivers/net/dsa/lan9303-core.c                                       |   29 
 drivers/net/dsa/sja1105/sja1105_main.c                               |    1 
 drivers/net/ethernet/adi/adin1110.c                                  |    4 
 drivers/net/ethernet/freescale/fec_main.c                            |    6 
 drivers/net/ethernet/ibm/emac/mal.c                                  |    4 
 drivers/net/ethernet/intel/e1000e/hw.h                               |    4 
 drivers/net/ethernet/intel/e1000e/netdev.c                           |    4 
 drivers/net/ethernet/intel/i40e/i40e_main.c                          |    1 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                   |    2 
 drivers/net/ethernet/intel/ice/ice_ddp.c                             |   58 
 drivers/net/ethernet/intel/ice/ice_ddp.h                             |    4 
 drivers/net/ethernet/intel/ice/ice_dpll.c                            |    6 
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c                      |    5 
 drivers/net/ethernet/intel/ice/ice_eswitch_br.h                      |    1 
 drivers/net/ethernet/intel/ice/ice_main.c                            |   39 
 drivers/net/ethernet/intel/ice/ice_sriov.c                           |   19 
 drivers/net/ethernet/intel/ice/ice_switch.c                          |    2 
 drivers/net/ethernet/intel/ice/ice_tc_lib.c                          |   11 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                          |    9 
 drivers/net/ethernet/intel/ice/ice_vf_lib_private.h                  |    1 
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c                    |   57 
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h                    |    1 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                      |    9 
 drivers/net/ethernet/intel/igb/igb_main.c                            |    4 
 drivers/net/ethernet/sfc/efx_channels.c                              |    3 
 drivers/net/ethernet/sfc/siena/efx_channels.c                        |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                    |    2 
 drivers/net/ethernet/ti/icssg/icssg_config.c                         |    2 
 drivers/net/ethernet/ti/icssg/icssg_prueth.c                         |    1 
 drivers/net/ethernet/ti/icssg/icssg_prueth.h                         |    2 
 drivers/net/netconsole.c                                             |    8 
 drivers/net/phy/aquantia/aquantia_main.c                             |   51 
 drivers/net/phy/bcm84881.c                                           |    4 
 drivers/net/phy/dp83869.c                                            |    1 
 drivers/net/phy/phy_device.c                                         |    5 
 drivers/net/phy/realtek.c                                            |   24 
 drivers/net/ppp/ppp_async.c                                          |    2 
 drivers/net/pse-pd/pse_core.c                                        |   11 
 drivers/net/slip/slhc.c                                              |   57 
 drivers/net/vxlan/vxlan_core.c                                       |    6 
 drivers/net/vxlan/vxlan_private.h                                    |    2 
 drivers/net/vxlan/vxlan_vnifilter.c                                  |   19 
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c                               |    1 
 drivers/nvdimm/nd_virtio.c                                           |    9 
 drivers/opp/core.c                                                   |    4 
 drivers/pci/controller/dwc/pcie-designware.c                         |    2 
 drivers/pci/controller/dwc/pcie-designware.h                         |    2 
 drivers/pci/controller/dwc/pcie-qcom.c                               |   72 
 drivers/pci/endpoint/pci-epc-core.c                                  |   14 
 drivers/pci/pci.c                                                    |   14 
 drivers/pci/probe.c                                                  |    2 
 drivers/pci/quirks.c                                                 |    8 
 drivers/pci/remove.c                                                 |    2 
 drivers/powercap/intel_rapl_tpmi.c                                   |   19 
 drivers/remoteproc/imx_rproc.c                                       |   13 
 drivers/scsi/fnic/fnic_main.c                                        |    2 
 drivers/scsi/lpfc/lpfc_ct.c                                          |   22 
 drivers/scsi/lpfc/lpfc_disc.h                                        |    7 
 drivers/scsi/lpfc/lpfc_els.c                                         |  132 
 drivers/scsi/lpfc/lpfc_vport.c                                       |   43 
 drivers/scsi/wd33c93.c                                               |    2 
 drivers/soundwire/cadence_master.c                                   |   39 
 drivers/soundwire/cadence_master.h                                   |    5 
 drivers/soundwire/intel.h                                            |    2 
 drivers/soundwire/intel_auxdevice.c                                  |    1 
 drivers/soundwire/intel_bus_common.c                                 |   27 
 drivers/staging/vme_user/vme_fake.c                                  |    6 
 drivers/staging/vme_user/vme_tsi148.c                                |    6 
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c |    2 
 drivers/thermal/thermal_core.c                                       |    5 
 drivers/thermal/thermal_core.h                                       |    3 
 drivers/thermal/thermal_netlink.c                                    |    9 
 drivers/tty/serial/serial_core.c                                     |   16 
 drivers/ufs/core/ufshcd.c                                            |    5 
 drivers/usb/chipidea/udc.c                                           |    8 
 drivers/usb/dwc2/platform.c                                          |   26 
 drivers/usb/dwc3/core.c                                              |   30 
 drivers/usb/dwc3/core.h                                              |    4 
 drivers/usb/dwc3/gadget.c                                            |   11 
 drivers/usb/gadget/function/uvc_v4l2.c                               |   12 
 drivers/usb/gadget/udc/core.c                                        |    1 
 drivers/usb/host/xhci-dbgcap.c                                       |  133 
 drivers/usb/host/xhci-dbgcap.h                                       |    2 
 drivers/usb/host/xhci-pci.c                                          |    5 
 drivers/usb/host/xhci-plat.c                                         |    6 
 drivers/usb/misc/yurex.c                                             |   19 
 drivers/usb/storage/unusual_devs.h                                   |   11 
 drivers/usb/typec/tipd/core.c                                        |    3 
 drivers/vdpa/octeon_ep/octep_vdpa_hw.c                               |   12 
 drivers/video/fbdev/core/fbcon.c                                     |    2 
 drivers/video/fbdev/sis/sis_main.c                                   |    2 
 fs/btrfs/extent-tree.c                                               |   26 
 fs/btrfs/free-space-cache.c                                          |    4 
 fs/btrfs/free-space-cache.h                                          |    6 
 fs/btrfs/volumes.h                                                   |    6 
 fs/btrfs/zoned.c                                                     |    2 
 fs/ext4/super.c                                                      |    9 
 fs/ext4/xattr.c                                                      |    4 
 fs/nfs/callback_xdr.c                                                |    2 
 fs/nfs/client.c                                                      |    1 
 fs/nfs/nfs42proc.c                                                   |    2 
 fs/nfs/nfs4state.c                                                   |    2 
 fs/nfsd/filecache.c                                                  |    4 
 fs/nfsd/nfs4state.c                                                  |    1 
 fs/nfsd/nfssvc.c                                                     |    6 
 fs/ntfs3/file.c                                                      |   40 
 fs/ntfs3/frecord.c                                                   |   21 
 fs/ntfs3/fslog.c                                                     |   19 
 fs/ntfs3/namei.c                                                     |    4 
 fs/ntfs3/super.c                                                     |    3 
 fs/proc/kcore.c                                                      |   36 
 fs/smb/client/smb2ops.c                                              |   47 
 fs/smb/client/smb2pdu.c                                              |    6 
 fs/unicode/mkutf8data.c                                              |   70 
 fs/unicode/utf8data.c_shipped                                        | 6703 ++++------
 include/linux/bpf.h                                                  |    1 
 include/linux/nfs_fs_sb.h                                            |    1 
 include/linux/pci-epc.h                                              |    2 
 include/linux/pci.h                                                  |    2 
 include/linux/pci_ids.h                                              |    3 
 include/net/mctp.h                                                   |    2 
 include/net/rtnetlink.h                                              |   17 
 include/net/sch_generic.h                                            |    1 
 include/net/sock.h                                                   |    2 
 io_uring/io_uring.c                                                  |   15 
 io_uring/rw.c                                                        |   19 
 kernel/bpf/arraymap.c                                                |    3 
 kernel/bpf/core.c                                                    |   21 
 kernel/bpf/hashtab.c                                                 |    3 
 kernel/bpf/syscall.c                                                 |   19 
 kernel/kthread.c                                                     |    2 
 kernel/rcu/tree_nocb.h                                               |    8 
 mm/secretmem.c                                                       |    4 
 net/bluetooth/hci_conn.c                                             |    3 
 net/bluetooth/rfcomm/sock.c                                          |    2 
 net/bridge/br_netfilter_hooks.c                                      |    5 
 net/bridge/br_netlink.c                                              |    6 
 net/bridge/br_private.h                                              |    5 
 net/bridge/br_vlan.c                                                 |   19 
 net/core/dst.c                                                       |   17 
 net/core/rtnetlink.c                                                 |   29 
 net/dsa/user.c                                                       |   11 
 net/ipv4/netfilter/nf_reject_ipv4.c                                  |   10 
 net/ipv4/netfilter/nft_fib_ipv4.c                                    |    4 
 net/ipv4/tcp_input.c                                                 |   42 
 net/ipv6/netfilter/nf_reject_ipv6.c                                  |    5 
 net/ipv6/netfilter/nft_fib_ipv6.c                                    |    5 
 net/mctp/af_mctp.c                                                   |    6 
 net/mctp/device.c                                                    |   30 
 net/mctp/neigh.c                                                     |   31 
 net/mctp/route.c                                                     |   33 
 net/mpls/af_mpls.c                                                   |   32 
 net/mptcp/mib.c                                                      |    2 
 net/mptcp/mib.h                                                      |    2 
 net/mptcp/pm_netlink.c                                               |    3 
 net/mptcp/protocol.c                                                 |   24 
 net/mptcp/subflow.c                                                  |    6 
 net/netfilter/nf_nat_core.c                                          |  120 
 net/netfilter/xt_CHECKSUM.c                                          |   33 
 net/netfilter/xt_CLASSIFY.c                                          |   16 
 net/netfilter/xt_CONNSECMARK.c                                       |   36 
 net/netfilter/xt_CT.c                                                |  106 
 net/netfilter/xt_IDLETIMER.c                                         |   59 
 net/netfilter/xt_LED.c                                               |   39 
 net/netfilter/xt_NFLOG.c                                             |   36 
 net/netfilter/xt_RATEEST.c                                           |   39 
 net/netfilter/xt_SECMARK.c                                           |   27 
 net/netfilter/xt_TRACE.c                                             |   35 
 net/netfilter/xt_addrtype.c                                          |   15 
 net/netfilter/xt_cluster.c                                           |   33 
 net/netfilter/xt_connbytes.c                                         |    4 
 net/netfilter/xt_connlimit.c                                         |   39 
 net/netfilter/xt_connmark.c                                          |   28 
 net/netfilter/xt_mark.c                                              |   42 
 net/netlink/af_netlink.c                                             |    3 
 net/phonet/pn_netlink.c                                              |   28 
 net/rxrpc/sendmsg.c                                                  |   10 
 net/sched/sch_api.c                                                  |    7 
 net/sctp/socket.c                                                    |   18 
 net/smc/smc_inet.c                                                   |   11 
 net/socket.c                                                         |    7 
 sound/pci/hda/hda_intel.c                                            |    2 
 tools/build/feature/Makefile                                         |    5 
 tools/iio/iio_generic_buffer.c                                       |    4 
 tools/perf/Makefile.config                                           |    7 
 tools/perf/util/vdso.c                                               |    4 
 tools/testing/ktest/ktest.pl                                         |    2 
 tools/testing/selftests/bpf/progs/verifier_int_ptr.c                 |    5 
 tools/testing/selftests/mm/hmm-tests.c                               |    2 
 tools/testing/selftests/net/forwarding/no_forwarding.sh              |    2 
 tools/testing/selftests/rseq/rseq.c                                  |  110 
 tools/testing/selftests/rseq/rseq.h                                  |   10 
 266 files changed, 5943 insertions(+), 4521 deletions(-)

Abhishek Chauhan (2):
      net: phy: aquantia: AQR115c fix up PMA capabilities
      net: phy: aquantia: remove usage of phy_set_max_speed

Abhishek Tamboli (1):
      usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c

Aleksandr Loktionov (1):
      i40e: Fix macvlan leak by synchronizing access to mac_filter_hash

Alex Deucher (1):
      drm/amdgpu: partially revert powerplay `__counted_by` changes

Alex Hung (1):
      drm/amd/display: Check null pointer before dereferencing se

Alex Williamson (1):
      PCI: Mark Creative Labs EMU20k2 INTx masking as broken

Alexander Gordeev (1):
      fs/proc/kcore.c: allow translation of physical memory addresses

Anastasia Kovaleva (1):
      net: Fix an unsafe loop on the list

Anatolij Gustschin (1):
      net: dsa: lan9303: ensure chip reset and wait for READY status

Andrey Shumilin (1):
      fbdev: sisfb: Fix strbuf array overflow

Andrey Skvortsov (1):
      zram: don't free statically defined names

Andy Roulin (1):
      netfilter: br_netfilter: fix panic with metadata_dst skb

Arkadiusz Kubalewski (1):
      ice: disallow DPLL_PIN_STATE_SELECTABLE for dpll output pins

Avri Altman (1):
      scsi: ufs: Use pre-calculated offsets in ufshcd_init_lrb()

Basavaraj Natikar (1):
      HID: amd_sfh: Switch to device-managed dmam_alloc_coherent()

Ben Skeggs (1):
      drm/nouveau: pass cli to nouveau_channel_new() instead of drm+device

Billy Tsai (2):
      gpio: aspeed: Add the flush write to ensure the write complete.
      gpio: aspeed: Use devm_clk api to manage clock source

Breno Leitao (1):
      net: netconsole: fix wrong warning

Christian Marangi (1):
      net: phy: Remove LED entry from LEDs list on unregister

Christophe JAILLET (2):
      net: phy: bcm84881: Fix some error handling paths
      net: ethernet: adi: adin1110: Fix some error handling path in adin1110_read_fifo()

Chuck Lever (1):
      NFSD: Mark filecache "down" if init fails

D. Wythe (1):
      net/smc: fix lacks of icsk_syn_mss with IPPROTO_SMC

Dan Carpenter (2):
      SUNRPC: Fix integer overflow in decode_rc_list()
      OPP: fix error code in dev_pm_opp_set_config()

Daniel Borkmann (1):
      selftests/bpf: Fix ARG_PTR_TO_LONG {half-,}uninitialized test

Daniel Jordan (1):
      ktest.pl: Avoid false positives with grub2 skip regex

Daniel Palmer (1):
      scsi: wd33c93: Don't use stale scsi_pointer value

Dave Ertman (1):
      ice: fix VLAN replay after reset

David Howells (1):
      rxrpc: Fix uninitialised variable in rxrpc_send_data()

Diogo Jahchan Koike (1):
      ntfs3: Change to non-blocking allocation in ntfs_d_hash

Donet Tom (1):
      selftests/mm: fix incorrect buffer->mirror size in hmm2 double_map test

Enzo Matsumiya (1):
      smb: client: fix UAF in async decryption

Eric Dumazet (4):
      net/sched: accept TCA_STAB only for root qdisc
      net: do not delay dst_entries_add() in dst_release()
      ppp: fix ppp_async_encode() illegal access
      slip: make slhc_remember() more robust against malicious packets

Filipe Manana (1):
      btrfs: zoned: fix missing RCU locking in error message when loading zone info

Florian Westphal (3):
      netfilter: nf_nat: don't try nat source port reallocation for reverse dir clash
      netfilter: xtables: avoid NFPROTO_UNSPEC where needed
      netfilter: fib: check correct rtable in vrf setups

Frank Li (1):
      usb: host: xhci-plat: Parse xhci-missing_cas_quirk and apply quirk

Frederic Weisbecker (2):
      rcu/nocb: Fix rcuog wake-up from offline softirq
      kthread: unpark only parked kthread

Gabriel Krisman Bertazi (1):
      unicode: Don't special case ignorable code points

Gerald Schaefer (1):
      s390/mm: Add cond_resched() to cmm_alloc/free_pages()

Greg Kroah-Hartman (1):
      Linux 6.11.4

Guenter Roeck (1):
      hwmon: (tmp513) Add missing dependency on REGMAP_I2C

Gui-Dong Han (2):
      ice: Fix improper handling of refcount in ice_dpll_init_rclk_pins()
      ice: Fix improper handling of refcount in ice_sriov_set_msix_vec_count()

Hamza Mahfooz (1):
      drm/amd/display: fix hibernate entry for DCN35+

Hans de Goede (4):
      i2c: i801: Use a different adapter-name for IDF adapters
      mfd: intel_soc_pmic_chtwc: Make Lenovo Yoga Tab 3 X90F DMI match less strict
      ACPI: resource: Make Asus ExpertBook B2402 matches cover more models
      ACPI: resource: Make Asus ExpertBook B2502 matches cover more models

He Lugang (1):
      HID: multitouch: Add support for lenovo Y9000P Touchpad

Heiko Carstens (2):
      s390/facility: Disable compile time optimization for decompressor code
      s390/traps: Handle early warnings gracefully

Heiner Kallweit (1):
      net: phy: realtek: Fix MMD access on RTL8126A-integrated PHY

Hou Tao (1):
      bpf: Call the missed btf_record_free() when map creation fails

Ian Rogers (1):
      perf vdso: Missed put on 32-bit dsos

Icenowy Zheng (1):
      usb: storage: ignore bogus device raised by JieLi BR21 USB sound chip

Ignat Korchagin (1):
      net: explicitly clear the sk pointer, when pf->create fails

Ilpo Järvinen (2):
      mfd: intel-lpss: Add Intel Arrow Lake-H LPSS PCI IDs
      mfd: intel-lpss: Add Intel Panther Lake LPSS PCI IDs

Ingo van Lil (1):
      net: phy: dp83869: fix memory corruption when enabling fiber

Jakub Kicinski (1):
      Revert "net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled"

Jan Kara (1):
      ext4: don't set SB_RDONLY after filesystem errors

Jani Nikula (1):
      drm/i915/hdcp: fix connector refcounting

Janne Grunau (1):
      drm/fbdev-dma: Only cleanup deferred I/O if necessary

Jason Gerecke (1):
      HID: wacom: Hardcode (non-inverted) AES pens as BTN_TOOL_PEN

Javier Carrasco (4):
      hwmon: (mc34vr500) Add missing dependency on REGMAP_I2C
      hwmon: (adm9240) Add missing dependency on REGMAP_I2C
      hwmon: (adt7470) Add missing dependency on REGMAP_I2C
      hwmon: (ltc2991) Add missing dependency on REGMAP_I2C

Jens Axboe (2):
      io_uring: check if we need to reschedule during overflow flush
      io_uring/rw: fix cflags posting for single issue multishot read

Jiri Slaby (SUSE) (1):
      serial: protect uart_port_dtr_rts() in uart_shutdown() too

Jisheng Zhang (1):
      riscv: avoid Imbalance in RAS

John Keeping (1):
      usb: gadget: core: force synchronous registration

Jonas Gorski (5):
      net: dsa: b53: fix jumbo frame mtu check
      net: dsa: b53: fix max MTU for 1g switches
      net: dsa: b53: fix max MTU for BCM5325/BCM5365
      net: dsa: b53: allow lower MTUs on BCM5325/5365
      net: dsa: b53: fix jumbo frames on 10/100 ports

Jose Alberto Reguero (1):
      usb: xhci: Fix problem with xhci resume from suspend

Joshua Hay (1):
      idpf: use actual mbx receive payload length

Josip Pavic (1):
      drm/amd/display: Clear update flags after update has been applied

José Roberto de Souza (1):
      drm/xe/oa: Fix overflow in oa batch buffer

Juergen Gross (1):
      x86/xen: mark boot CPU of PV guest in MSR_IA32_APICBASE

Justin Tee (3):
      scsi: lpfc: Add ELS_RSP cmd to the list of WQEs to flush in lpfc_els_flush_cmd()
      scsi: lpfc: Ensure DA_ID handling completion before deleting an NPIV instance
      scsi: lpfc: Revise TRACE_EVENT log flag severities from KERN_ERR to KERN_WARNING

Kacper Ludwinski (1):
      selftests: net: no_forwarding: fix VID for $swp2 in one_bridge_two_pvids() test

Kaixin Wang (2):
      i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
      ntb: ntb_hw_switchtec: Fix use after free vulnerability in switchtec_ntb_remove due to race condition

Ken Raeburn (1):
      dm vdo: don't refer to dedupe_context after releasing it

Konstantin Komarov (5):
      fs/ntfs3: Do not call file_modified if collapse range failed
      fs/ntfs3: Optimize large writes into sparse file
      fs/ntfs3: Fix sparse warning for bigendian
      fs/ntfs3: Fix sparse warning in ni_fiemap
      fs/ntfs3: Refactor enum_rstbl to suppress static checker

Kory Maincent (1):
      net: pse-pd: Fix enabled status mismatch

Krzysztof Kozlowski (1):
      clk: bcm: bcm53573: fix OF node leak in init

Kun(llfl) (1):
      device-dax: correct pgoff align in dax_set_mapping()

Kuniyuki Iwashima (6):
      rtnetlink: Add bulk registration helpers for rtnetlink message handlers.
      vxlan: Handle error of rtnl_register_module().
      bridge: Handle error of rtnl_register_module().
      mctp: Handle error of rtnl_register_module().
      mpls: Handle error of rtnl_register_module().
      phonet: Handle error of rtnl_register_module().

Lang Yu (1):
      drm/amdkfd: Fix an eviction fence leak

Linus Walleij (1):
      Revert "mmc: mvsdio: Use sg_miter for PIO"

Luca Stefani (2):
      btrfs: split remaining space to discard in chunks
      btrfs: add cancellation points to trim loops

Luiz Augusto von Dentz (3):
      Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change
      Bluetooth: btusb: Don't fail external suspend requests
      Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix race condition for VLAN table access

Manivannan Sadhasivam (2):
      PCI: endpoint: Assign PCI domain number for endpoint controllers
      PCI: Pass domain number to pci_bus_release_domain_nr() explicitly

Marcin Szycik (3):
      ice: Fix entering Safe Mode
      ice: Fix netif_is_ice() in Safe Mode
      ice: Fix increasing MSI-X on VF

Martin Wilck (1):
      scsi: fnic: Move flush_work initialization out of if block

Mathias Nyman (1):
      xhci: dbc: Fix STALL transfer event handling

Mathieu Desnoyers (1):
      selftests/rseq: Fix mm_cid test failure

Matt Roper (1):
      drm/xe: Make wedged_mode debugfs writable

Matthew Auld (3):
      drm/xe/guc_submit: fix xa_store() error checking
      drm/xe/ct: prevent UAF in send_recv()
      drm/xe/ct: fix xa_store() error checking

Matthieu Baerts (NGI0) (2):
      mptcp: fallback when MPTCP opts are dropped after 1st data
      mptcp: pm: do not remove closing subflows

Maíra Canal (2):
      drm/v3d: Stop the active perfmon before being destroyed
      drm/vc4: Stop the active perfmon before being destroyed

Md Haris Iqbal (1):
      RDMA/rtrs-srv: Avoid null pointer deref during path establishment

Michael Guralnik (1):
      RDMA/mlx5: Enforce umem boundaries for explicit ODP page faults

Michael S. Tsirkin (1):
      virtio_console: fix misc probe bugs

Michal Swiatkowski (2):
      ice: set correct dst VSI in only LAN filters
      ice: clear port vlan config during reset

Michal Wilczynski (1):
      mmc: sdhci-of-dwcmshc: Prevent stale command interrupt handling

Mohamed Khalfella (1):
      igb: Do not bring the device up after non-fatal error

Neal Cardwell (3):
      tcp: fix to allow timestamp undo if no retransmits were sent
      tcp: fix tcp_enter_recovery() to zero retrans_stamp when it's safe
      tcp: fix TFO SYN_RECV to not zero retrans_stamp with retransmits out

NeilBrown (1):
      nfsd: nfsd_destroy_serv() must call svc_destroy() even if nfsd_startup_net() failed

Niklas Cassel (1):
      ata: libata: avoid superfluous disk spin down + spin up during hibernation

Olga Kornievskaia (1):
      nfsd: fix possible badness in FREE_STATEID

Oliver Neukum (1):
      Revert "usb: yurex: Replace snprintf() with the safer scnprintf() variant"

Palmer Dabbelt (1):
      RISC-V: Don't have MAX_PHYSMEM_BITS exceed phys_addr_t

Paolo Abeni (1):
      mptcp: handle consistently DSS corruption

Patrick Roy (1):
      secretmem: disable memfd_secret() if arch cannot set direct map

Peng Fan (2):
      remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table
      clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D

Peter Colberg (1):
      hwmon: intel-m10-bmc-hwmon: relabel Columbiaville to CVL Die Temperature

Philip Chen (1):
      virtio_pmem: Check device status before requesting flush

Pierre-Louis Bossart (2):
      soundwire: intel_bus_common: enable interrupts before exiting reset
      soundwire: cadence: re-check Peripheral status with delayed_work

Prudhvi Yarlagadda (1):
      PCI: qcom: Disable mirroring of DBI and iATU register space in BAR region

Przemek Kitszel (1):
      ice: fix memleak in ice_init_tx_topology()

Qianqiang Liu (1):
      fbcon: Fix a NULL pointer dereference issue in fbcon_putcs

Rafael J. Wysocki (2):
      thermal: core: Reference count the zone in thermal_zone_get_by_id()
      thermal: core: Free tzp copy along with the thermal zone

Riyan Dhiman (1):
      staging: vme_user: added bound check to geoid

Rosen Penev (2):
      net: ibm: emac: mal: fix wrong goto
      net: ibm: emac: mal: add dcr_unmap to _remove

Roy Luo (1):
      usb: dwc3: re-enable runtime PM after failed resume

Ruffalo Lavoisier (1):
      comedi: ni_routing: tools: Check when the file could not be opened

Samuel Holland (1):
      riscv: Omit optimized string routines when using KASAN

Saravanan Vajravel (1):
      RDMA/mad: Improve handling of timed out WRs of mad agent

Sebastian Andrzej Siewior (1):
      sfc: Don't invoke xdp_do_flush() from netpoll.

Selvarasu Ganesan (1):
      usb: dwc3: core: Stop processing of pending events if controller is halted

Sergey Senozhatsky (1):
      zram: free secondary algorithms names

Shawn Shao (1):
      usb: dwc2: Adjust the timing of USB Driver Interrupt Registration in the Crashkernel Scenario

Shyam Sundar S K (1):
      x86/amd_nb: Add new PCI IDs for AMD family 1Ah model 60h

Simon Horman (1):
      netfilter: nf_reject: Fix build warning when CONFIG_BRIDGE_NETFILTER=n

Srujana Challa (1):
      vdpa/octeon_ep: Fix format specifier for pointers in debug messages

Subramanian Ananthanarayanan (1):
      PCI: Add ACS quirk for Qualcomm SA8775P

SurajSonawane2415 (1):
      hid: intel-ish-hid: Fix uninitialized variable 'rv' in ish_fw_xfer_direct_dma

Tao Chen (1):
      bpf: Check percpu map value size first

Thomas Richter (1):
      s390/cpum_sf: Remove WARN_ON_ONCE statements

Ulf Hansson (1):
      PM: domains: Fix alloc/free in dev_pm_domain_attach|detach_list()

Vinay Belgaumkar (1):
      drm/xe: Restore GT freq on GSC load error

Vitaly Lifshits (1):
      e1000e: change I219 (19) devices to ADP

Vladimir Oltean (2):
      net: dsa: sja1105: fix reception from VLAN-unaware bridges
      net: dsa: refuse cross-chip mirroring operations

Wade Wang (1):
      HID: plantronics: Workaround for an unexcepted opposite volume key

Wadim Egorov (1):
      usb: typec: tipd: Free IRQ only if it was requested before

WangYuli (1):
      PCI: Add function 0 DMA alias quirk for Glenfly Arise chip

Wei Fang (1):
      net: fec: don't save PTP state if PTP is unsupported

Wentao Guan (1):
      LoongArch: Fix memleak in pci_acpi_scan_root()

Wojciech Drewek (1):
      ice: Flush FDB entries before reset

Wojciech Gładysz (1):
      ext4: nested locking for xattr inode

Xin Long (1):
      sctp: ensure sk_state is set to CLOSED if hashing fails in sctp_listen_start

Xu Kuohai (1):
      bpf: Prevent tail call between progs attached to different hooks

Xu Yang (1):
      usb: chipidea: udc: enable suspend interrupt after usb reset

Yang Jihong (2):
      perf build: Fix static compilation error when libdw is not installed
      perf build: Fix build feature-dwarf_getlocations fail for old libdw

Yanjun Zhang (1):
      NFSv4: Prevent NULL-pointer dereference in nfs42_complete_copies()

Ying Sun (1):
      riscv/kexec_file: Fix relocation type R_RISCV_ADD16 and R_RISCV_SUB16 unknown

Yonatan Maman (2):
      nouveau/dmem: Fix privileged error in copy engine channel
      nouveau/dmem: Fix vulnerability in migrate_to_ram upon copy error

Yonghong Song (1):
      bpf, x64: Fix a jit convergence issue

Yunke Cao (1):
      media: videobuf2-core: clear memory related fields in __vb2_plane_dmabuf_put()

Zhang Rui (3):
      thermal: intel: int340x: processor: Fix warning during module unload
      powercap: intel_rapl_tpmi: Ignore minor version change
      powercap: intel_rapl_tpmi: Fix bogus register reading

Zhu Jun (1):
      tools/iio: Add memory allocation failure check for trigger_name

Zijun Hu (2):
      driver core: bus: Fix double free in driver API bus_register()
      driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute


