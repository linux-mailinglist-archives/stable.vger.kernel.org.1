Return-Path: <stable+bounces-86625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BD29A23F6
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 15:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5921C21828
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279B01DE2BB;
	Thu, 17 Oct 2024 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EbxJKTnU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CDF1DDC21;
	Thu, 17 Oct 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172113; cv=none; b=KjjRdumuasJsJeOoEklabelv2jdkkub3RpxD/PW4haJ9anWG68+UAGA2K9eykvFkFBWSqgGnis3DYnjzSeJ7adrJLTyB/1VXbL7WKFY1wGE4R5drqZ3715a89ai2RzY4GlH8rlyEKPpQkAcC7tgdorn4zCZF29j4dJQwfpZnHUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172113; c=relaxed/simple;
	bh=N8JZTdZc9bHCnYV32+JLEdYfoA+HQhmnZUn4OTjlELA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g9zMeq45TuIqSpBa0gTEI8EjN2g1YoKXDCttRA2d3m7c9//hrf+bhq14rmoBNQSfQMqEwokPT3+is1OvLYq6l65wagmiG6Tu4zyjC6ldsVImhjFeQPrp76+Te/ZNVAOseyvPJ5dra0Q1hi65jwTwq3FK9RfDefBNV9kPzh8O4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EbxJKTnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5FDC4CED7;
	Thu, 17 Oct 2024 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729172113;
	bh=N8JZTdZc9bHCnYV32+JLEdYfoA+HQhmnZUn4OTjlELA=;
	h=From:To:Cc:Subject:Date:From;
	b=EbxJKTnUzdXZf0lJvlmB7PdzzXuPr7rV2j8hfg1v6+05Ebpxn+L665QvfT3jeXQKr
	 y6c9QG3lsmVmN4drTVaIgOtOJF07hv+NFNpnwzI4M/pJ0W7PIIuhVOjtG7+pp5cbmt
	 1hDt+dPftudST1NiwZwBCBYJDWvQ5Pi/vMpLDVts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.57
Date: Thu, 17 Oct 2024 15:34:42 +0200
Message-ID: <2024101742-underwire-outnumber-b9b8@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.57 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/dev-tools/kselftest.rst                                |   12 
 Makefile                                                             |    2 
 arch/loongarch/pci/acpi.c                                            |    1 
 arch/powerpc/configs/ps3_defconfig                                   |    1 
 arch/riscv/include/asm/sbi.h                                         |    2 
 arch/riscv/include/asm/sparsemem.h                                   |    2 
 arch/riscv/include/asm/thread_info.h                                 |    1 
 arch/riscv/kernel/cpu.c                                              |   40 
 arch/riscv/kernel/cpufeature.c                                       |    8 
 arch/riscv/kernel/elf_kexec.c                                        |    6 
 arch/riscv/kernel/entry.S                                            |    4 
 arch/s390/include/asm/facility.h                                     |    6 
 arch/s390/include/asm/io.h                                           |    2 
 arch/s390/kernel/perf_cpum_sf.c                                      |   12 
 arch/s390/mm/cmm.c                                                   |   18 
 arch/x86/kernel/amd_nb.c                                             |    4 
 arch/x86/net/bpf_jit_comp.c                                          |   54 
 drivers/ata/ahci.c                                                   |   85 
 drivers/ata/libata-eh.c                                              |   18 
 drivers/base/bus.c                                                   |    8 
 drivers/block/zram/zram_drv.c                                        |    7 
 drivers/bus/mhi/ep/internal.h                                        |    1 
 drivers/bus/mhi/ep/main.c                                            |  248 
 drivers/bus/mhi/ep/ring.c                                            |    8 
 drivers/char/virtio_console.c                                        |   18 
 drivers/clk/bcm/clk-bcm53573-ilp.c                                   |    2 
 drivers/clk/imx/clk-imx7d.c                                          |    4 
 drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c            |    5 
 drivers/dax/device.c                                                 |    2 
 drivers/gpio/gpio-aspeed.c                                           |    4 
 drivers/gpu/drm/amd/display/dc/core/dc.c                             |    2 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c           |   27 
 drivers/gpu/drm/drm_crtc.c                                           |    1 
 drivers/gpu/drm/i915/display/intel_hdcp.c                            |   10 
 drivers/gpu/drm/nouveau/dispnv04/crtc.c                              |    2 
 drivers/gpu/drm/nouveau/nouveau_abi16.c                              |    2 
 drivers/gpu/drm/nouveau/nouveau_bo.c                                 |    2 
 drivers/gpu/drm/nouveau/nouveau_chan.c                               |   21 
 drivers/gpu/drm/nouveau/nouveau_chan.h                               |    3 
 drivers/gpu/drm/nouveau/nouveau_dmem.c                               |    2 
 drivers/gpu/drm/nouveau/nouveau_drm.c                                |    4 
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c                       |    8 
 drivers/gpu/drm/v3d/v3d_perfmon.c                                    |    9 
 drivers/gpu/drm/vc4/vc4_perfmon.c                                    |    7 
 drivers/hid/Kconfig                                                  |    9 
 drivers/hid/Makefile                                                 |    1 
 drivers/hid/amd-sfh-hid/amd_sfh_client.c                             |   14 
 drivers/hid/hid-asus.c                                               |   14 
 drivers/hid/hid-ids.h                                                |   10 
 drivers/hid/hid-mcp2200.c                                            |  392 
 drivers/hid/hid-multitouch.c                                         |    8 
 drivers/hid/hid-plantronics.c                                        |   23 
 drivers/hid/i2c-hid/i2c-hid-core.c                                   |   22 
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c                          |    2 
 drivers/hwmon/Kconfig                                                |    4 
 drivers/hwmon/intel-m10-bmc-hwmon.c                                  |    2 
 drivers/hwmon/k10temp.c                                              |    1 
 drivers/i2c/busses/i2c-i801.c                                        |    9 
 drivers/i3c/master/i3c-master-cdns.c                                 |    1 
 drivers/infiniband/core/mad.c                                        |   14 
 drivers/infiniband/hw/mlx5/odp.c                                     |   25 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                               |   13 
 drivers/input/rmi4/rmi_driver.c                                      |    6 
 drivers/media/common/videobuf2/videobuf2-core.c                      |    8 
 drivers/mfd/intel_soc_pmic_chtwc.c                                   |    1 
 drivers/net/dsa/b53/b53_common.c                                     |   17 
 drivers/net/dsa/lan9303-core.c                                       |   29 
 drivers/net/ethernet/adi/adin1110.c                                  |    4 
 drivers/net/ethernet/amd/pds_core/main.c                             |    6 
 drivers/net/ethernet/cortina/gemini.c                                |   32 
 drivers/net/ethernet/freescale/fec_main.c                            |    6 
 drivers/net/ethernet/ibm/emac/mal.c                                  |    2 
 drivers/net/ethernet/intel/e1000e/hw.h                               |    4 
 drivers/net/ethernet/intel/e1000e/ich8lan.c                          |   55 
 drivers/net/ethernet/intel/e1000e/netdev.c                           |   22 
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h                    |    1 
 drivers/net/ethernet/intel/i40e/i40e_diag.h                          |    1 
 drivers/net/ethernet/intel/i40e/i40e_main.c                          |    1 
 drivers/net/ethernet/intel/i40e/i40e_register.h                      |    2 
 drivers/net/ethernet/intel/i40e/i40e_type.h                          |    4 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                   |    2 
 drivers/net/ethernet/intel/ice/ice.h                                 |    6 
 drivers/net/ethernet/intel/ice/ice_eswitch.c                         |   63 
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c                      |   17 
 drivers/net/ethernet/intel/ice/ice_eswitch_br.h                      |    1 
 drivers/net/ethernet/intel/ice/ice_main.c                            |   27 
 drivers/net/ethernet/intel/ice/ice_switch.c                          |    2 
 drivers/net/ethernet/intel/ice/ice_tc_lib.c                          |   15 
 drivers/net/ethernet/intel/igb/igb_main.c                            |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                    |    2 
 drivers/net/phy/bcm84881.c                                           |    4 
 drivers/net/phy/dp83869.c                                            |    1 
 drivers/net/phy/phy_device.c                                         |    5 
 drivers/net/ppp/ppp_async.c                                          |    2 
 drivers/net/slip/slhc.c                                              |   57 
 drivers/net/vxlan/vxlan_core.c                                       |    6 
 drivers/net/vxlan/vxlan_private.h                                    |    2 
 drivers/net/vxlan/vxlan_vnifilter.c                                  |   19 
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c                               |    1 
 drivers/nvdimm/nd_virtio.c                                           |    9 
 drivers/pci/endpoint/functions/pci-epf-mhi.c                         |    8 
 drivers/pci/quirks.c                                                 |    8 
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c                       |  151 
 drivers/powercap/intel_rapl_tpmi.c                                   |   19 
 drivers/remoteproc/imx_rproc.c                                       |   13 
 drivers/scsi/lpfc/lpfc_ct.c                                          |   12 
 drivers/scsi/lpfc/lpfc_disc.h                                        |    7 
 drivers/scsi/lpfc/lpfc_els.c                                         |    7 
 drivers/scsi/lpfc/lpfc_vport.c                                       |   43 
 drivers/scsi/sd.c                                                    |    9 
 drivers/scsi/wd33c93.c                                               |    2 
 drivers/soundwire/cadence_master.c                                   |   39 
 drivers/soundwire/cadence_master.h                                   |    5 
 drivers/soundwire/intel.h                                            |    2 
 drivers/soundwire/intel_auxdevice.c                                  |    1 
 drivers/soundwire/intel_bus_common.c                                 |   27 
 drivers/spi/spi-fsl-lpspi.c                                          |   14 
 drivers/staging/vme_user/vme_fake.c                                  |    6 
 drivers/staging/vme_user/vme_tsi148.c                                |    6 
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c |   23 
 drivers/tty/serial/serial_core.c                                     |   16 
 drivers/ufs/core/ufshcd.c                                            |    5 
 drivers/usb/chipidea/udc.c                                           |    8 
 drivers/usb/dwc2/platform.c                                          |   26 
 drivers/usb/dwc3/core.c                                              |   22 
 drivers/usb/dwc3/core.h                                              |    4 
 drivers/usb/dwc3/gadget.c                                            |   11 
 drivers/usb/gadget/udc/core.c                                        |    1 
 drivers/usb/host/xhci-pci.c                                          |    5 
 drivers/usb/misc/yurex.c                                             |   19 
 drivers/usb/storage/unusual_devs.h                                   |   11 
 drivers/usb/typec/tipd/core.c                                        |    2 
 drivers/video/fbdev/core/fbcon.c                                     |    2 
 drivers/video/fbdev/sis/sis_main.c                                   |    2 
 fs/btrfs/extent-tree.c                                               |   19 
 fs/btrfs/volumes.h                                                   |    6 
 fs/btrfs/zoned.c                                                     |    2 
 fs/ext4/super.c                                                      |    9 
 fs/ext4/xattr.c                                                      |    4 
 fs/gfs2/quota.c                                                      |   59 
 fs/nfs/callback_xdr.c                                                |    2 
 fs/nfs/client.c                                                      |    1 
 fs/nfs/nfs42proc.c                                                   |    2 
 fs/nfs/nfs4state.c                                                   |    2 
 fs/nfsd/filecache.c                                                  |    4 
 fs/ntfs3/file.c                                                      |    4 
 fs/ntfs3/frecord.c                                                   |   21 
 fs/ntfs3/fslog.c                                                     |   19 
 fs/ntfs3/namei.c                                                     |    4 
 fs/proc/kcore.c                                                      |   36 
 fs/smb/client/smb2ops.c                                              |   47 
 fs/smb/client/smb2pdu.c                                              |    6 
 fs/unicode/mkutf8data.c                                              |   70 
 fs/unicode/utf8data.c_shipped                                        | 6703 ++++------
 include/linux/bpf.h                                                  |    1 
 include/linux/intel_tpmi.h                                           |    6 
 include/linux/jbd2.h                                                 |    2 
 include/linux/mhi_ep.h                                               |   21 
 include/linux/netlink.h                                              |    2 
 include/linux/nfs_fs_sb.h                                            |    1 
 include/linux/pci.h                                                  |   34 
 include/linux/pci_ids.h                                              |    4 
 include/linux/tcp.h                                                  |    8 
 include/net/mctp.h                                                   |    2 
 include/net/rtnetlink.h                                              |   18 
 include/net/sch_generic.h                                            |    1 
 include/net/sock.h                                                   |    2 
 include/scsi/scsi_device.h                                           |    1 
 include/sound/cs35l56.h                                              |    1 
 include/sound/tas2781-tlv.h                                          |    2 
 include/uapi/linux/tcp.h                                             |   12 
 io_uring/io_uring.c                                                  |   15 
 kernel/bpf/arraymap.c                                                |    3 
 kernel/bpf/core.c                                                    |   21 
 kernel/bpf/hashtab.c                                                 |    3 
 kernel/kthread.c                                                     |    2 
 kernel/rcu/tree.c                                                    |    9 
 kernel/rcu/tree_nocb.h                                               |   28 
 kernel/trace/trace.c                                                 |   18 
 kernel/trace/trace_output.c                                          |    6 
 lib/bootconfig.c                                                     |    3 
 lib/build_OID_registry                                               |    4 
 mm/secretmem.c                                                       |    4 
 net/bluetooth/hci_conn.c                                             |    3 
 net/bluetooth/hci_core.c                                             |   27 
 net/bluetooth/rfcomm/sock.c                                          |    2 
 net/bridge/br_netfilter_hooks.c                                      |    5 
 net/bridge/br_netlink.c                                              |    6 
 net/bridge/br_private.h                                              |    5 
 net/bridge/br_vlan.c                                                 |   19 
 net/ceph/messenger_v2.c                                              |    3 
 net/core/dst.c                                                       |   17 
 net/core/rtnetlink.c                                                 |   31 
 net/ipv4/netfilter/nf_reject_ipv4.c                                  |   10 
 net/ipv4/netfilter/nft_fib_ipv4.c                                    |    4 
 net/ipv4/tcp.c                                                       |    9 
 net/ipv4/tcp_input.c                                                 |   57 
 net/ipv4/tcp_minisocks.c                                             |    4 
 net/ipv4/tcp_timer.c                                                 |   17 
 net/ipv6/netfilter/nf_reject_ipv6.c                                  |    5 
 net/ipv6/netfilter/nft_fib_ipv6.c                                    |    5 
 net/mac80211/scan.c                                                  |   17 
 net/mctp/af_mctp.c                                                   |    6 
 net/mctp/device.c                                                    |   30 
 net/mctp/neigh.c                                                     |   31 
 net/mctp/route.c                                                     |   33 
 net/mpls/af_mpls.c                                                   |   87 
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
 net/netlink/af_netlink.c                                             |   38 
 net/netlink/af_netlink.h                                             |    5 
 net/phonet/pn_netlink.c                                              |   43 
 net/rxrpc/sendmsg.c                                                  |   10 
 net/sched/sch_api.c                                                  |    7 
 net/sctp/socket.c                                                    |   18 
 net/socket.c                                                         |    7 
 sound/pci/hda/hda_intel.c                                            |    2 
 sound/pci/hda/patch_realtek.c                                        |    7 
 sound/soc/codecs/cs35l56-shared.c                                    |   36 
 sound/soc/codecs/cs35l56.c                                           |   32 
 sound/soc/codecs/cs35l56.h                                           |    1 
 tools/iio/iio_generic_buffer.c                                       |    4 
 tools/lib/subcmd/parse-options.c                                     |    8 
 tools/perf/builtin-kmem.c                                            |    2 
 tools/perf/builtin-kvm.c                                             |    3 
 tools/perf/builtin-kwork.c                                           |    3 
 tools/perf/builtin-lock.c                                            |    3 
 tools/perf/builtin-mem.c                                             |    3 
 tools/perf/builtin-sched.c                                           |  164 
 tools/testing/ktest/ktest.pl                                         |    2 
 tools/testing/selftests/Makefile                                     |    7 
 tools/testing/selftests/bpf/progs/verifier_int_ptr.c                 |    5 
 tools/testing/selftests/lib.mk                                       |   19 
 tools/testing/selftests/mm/hmm-tests.c                               |    2 
 tools/testing/selftests/net/forwarding/no_forwarding.sh              |    2 
 tools/testing/selftests/rseq/rseq.c                                  |  110 
 tools/testing/selftests/rseq/rseq.h                                  |   10 
 257 files changed, 6538 insertions(+), 4677 deletions(-)

Aananth V (1):
      tcp: new TCP_INFO stats for RTO events

Abel Vesa (1):
      phy: qualcomm: eusb2-repeater: Rework init to drop redundant zero-out loop

Aditya Gupta (1):
      libsubcmd: Don't free the usage string

Aleksandr Loktionov (1):
      i40e: Fix macvlan leak by synchronizing access to mac_filter_hash

Alex Hung (2):
      drm/amd/display: Revert "Check HDCP returned status"
      drm/amd/display: Check null pointer before dereferencing se

Alex Williamson (1):
      PCI: Mark Creative Labs EMU20k2 INTx masking as broken

Alexander Gordeev (1):
      fs/proc/kcore.c: allow translation of physical memory addresses

Anastasia Kovaleva (1):
      net: Fix an unsafe loop on the list

Anatolij Gustschin (1):
      net: dsa: lan9303: ensure chip reset and wait for READY status

Andreas Gruenbacher (3):
      gfs2: Revert "introduce qd_bh_get_or_undo"
      gfs2: qd_check_sync cleanups
      gfs2: Revert "ignore negated quota changes"

Andrey Shumilin (1):
      fbdev: sisfb: Fix strbuf array overflow

Andrey Skvortsov (1):
      zram: don't free statically defined names

Andy Roulin (1):
      netfilter: br_netfilter: fix panic with metadata_dst skb

Avri Altman (1):
      scsi: ufs: Use pre-calculated offsets in ufshcd_init_lrb()

Basavaraj Natikar (1):
      HID: amd_sfh: Switch to device-managed dmam_alloc_coherent()

Ben Skeggs (1):
      drm/nouveau: pass cli to nouveau_channel_new() instead of drm+device

Benjamin Poirier (2):
      selftests: net: Remove executable bits from library scripts
      selftests: Introduce Makefile variable to list shared bash scripts

Billy Tsai (2):
      gpio: aspeed: Add the flush write to ensure the write complete.
      gpio: aspeed: Use devm_clk api to manage clock source

Bjorn Helgaas (1):
      Revert "PCI/MSI: Provide stubs for IMS functions"

Carlos Song (1):
      spi: spi-fsl-lpspi: remove redundant spi_controller_put call

Charlie Jenkins (1):
      riscv: cpufeature: Fix thead vector hwcap removal

Christian Marangi (1):
      net: phy: Remove LED entry from LEDs list on unregister

Christophe JAILLET (2):
      net: phy: bcm84881: Fix some error handling paths
      net: ethernet: adi: adin1110: Fix some error handling path in adin1110_read_fifo()

Chuck Lever (1):
      NFSD: Mark filecache "down" if init fails

Cong Yang (1):
      drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02 panel HFP and HBP (again)

Damien Le Moal (3):
      ata: ahci: Add mask_port_map module parameter
      scsi: Remove scsi device no_start_on_resume flag
      scsi: sd: Do not repeat the starting disk message

Dan Carpenter (1):
      SUNRPC: Fix integer overflow in decode_rc_list()

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

Eric Dumazet (8):
      net/sched: accept TCA_STAB only for root qdisc
      net: do not delay dst_entries_add() in dst_release()
      rtnetlink: change nlk->cb_mutex role
      rtnetlink: add RTNL_FLAG_DUMP_UNLOCKED flag
      mpls: no longer hold RTNL in mpls_netconf_dump_devconf()
      phonet: no longer hold RTNL in route_dumpit()
      ppp: fix ppp_async_encode() illegal access
      slip: make slhc_remember() more robust against malicious packets

Filipe Manana (1):
      btrfs: zoned: fix missing RCU locking in error message when loading zone info

Florian Westphal (3):
      netfilter: nf_nat: don't try nat source port reallocation for reverse dir clash
      netfilter: xtables: avoid NFPROTO_UNSPEC where needed
      netfilter: fib: check correct rtable in vrf setups

Frederic Weisbecker (3):
      rcu/nocb: Make IRQs disablement symmetric
      rcu/nocb: Fix rcuog wake-up from offline softirq
      kthread: unpark only parked kthread

Gabriel Krisman Bertazi (1):
      unicode: Don't special case ignorable code points

Geoff Levand (1):
      Revert "powerpc/ps3_defconfig: Disable PPC64_BIG_ENDIAN_ELF_ABI_V2"

Gerald Schaefer (1):
      s390/mm: Add cond_resched() to cmm_alloc/free_pages()

Gergo Koteles (1):
      ASoC: tas2781: mark dvc_tlv with __maybe_unused

Greg Kroah-Hartman (1):
      Linux 6.6.57

Guenter Roeck (1):
      hwmon: (tmp513) Add missing dependency on REGMAP_I2C

Hans de Goede (4):
      i2c: i801: Use a different adapter-name for IDF adapters
      mfd: intel_soc_pmic_chtwc: Make Lenovo Yoga Tab 3 X90F DMI match less strict
      HID: i2c-hid: Remove I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV quirk
      HID: i2c-hid: Renumber I2C_HID_QUIRK_ defines

He Lugang (1):
      HID: multitouch: Add support for lenovo Y9000P Touchpad

Heiko Carstens (1):
      s390/facility: Disable compile time optimization for decompressor code

Hui Wang (1):
      e1000e: move force SMBUS near the end of enable_ulp function

Icenowy Zheng (1):
      usb: storage: ignore bogus device raised by JieLi BR21 USB sound chip

Ignat Korchagin (1):
      net: explicitly clear the sk pointer, when pf->create fails

Ingo van Lil (1):
      net: phy: dp83869: fix memory corruption when enabling fiber

Ivan Vecera (1):
      i40e: Fix ST code value for Clause 45

Jakub Kicinski (1):
      Revert "net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled"

Jan Kara (1):
      ext4: don't set SB_RDONLY after filesystem errors

Jani Nikula (1):
      drm/i915/hdcp: fix connector refcounting

Javier Carrasco (3):
      hwmon: (mc34vr500) Add missing dependency on REGMAP_I2C
      hwmon: (adm9240) Add missing dependency on REGMAP_I2C
      hwmon: (adt7470) Add missing dependency on REGMAP_I2C

Jean-Loïc Charroud (2):
      ALSA: hda/realtek: cs35l41: Fix order and duplicates in quirks table
      ALSA: hda/realtek: cs35l41: Fix device ID / model name

Jens Axboe (1):
      io_uring: check if we need to reschedule during overflow flush

Jiri Slaby (SUSE) (1):
      serial: protect uart_port_dtr_rts() in uart_shutdown() too

Jisheng Zhang (1):
      riscv: avoid Imbalance in RAS

Johan Hovold (1):
      scsi: Revert "scsi: sd: Do not repeat the starting disk message"

Johannes Roith (1):
      HID: mcp2200: added driver for GPIOs of MCP2200

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

Justin Tee (2):
      scsi: lpfc: Add ELS_RSP cmd to the list of WQEs to flush in lpfc_els_flush_cmd()
      scsi: lpfc: Ensure DA_ID handling completion before deleting an NPIV instance

Kacper Ludwinski (1):
      selftests: net: no_forwarding: fix VID for $swp2 in one_bridge_two_pvids() test

Kai-Heng Feng (1):
      HID: i2c-hid: Skip SET_POWER SLEEP for Cirque touchpad on system suspend

Kaixin Wang (2):
      i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
      ntb: ntb_hw_switchtec: Fix use after free vulnerability in switchtec_ntb_remove due to race condition

Kenton Groombridge (1):
      wifi: mac80211: Avoid address calculations via out of bounds array indexing

Konrad Dybcio (1):
      phy: qualcomm: phy-qcom-eusb2-repeater: Add tuning overrides

Konstantin Komarov (3):
      fs/ntfs3: Do not call file_modified if collapse range failed
      fs/ntfs3: Fix sparse warning in ni_fiemap
      fs/ntfs3: Refactor enum_rstbl to suppress static checker

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

Linus Walleij (2):
      net: ethernet: cortina: Drop TSO support
      net: ethernet: cortina: Restore TSO support

Luca Stefani (1):
      btrfs: split remaining space to discard in chunks

Luiz Augusto von Dentz (3):
      Bluetooth: Fix usage of __hci_cmd_sync_status
      Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change
      Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync

Luke D. Jones (3):
      HID: asus: add ROG Ally N-Key ID and keycodes
      HID: asus: add ROG Z13 lightbar
      hid-asus: add ROG Ally X prod ID to quirk list

Manivannan Sadhasivam (5):
      bus: mhi: ep: Rename read_from_host() and write_to_host() APIs
      bus: mhi: ep: Introduce async read/write callbacks
      bus: mhi: ep: Add support for async DMA write operation
      bus: mhi: ep: Add support for async DMA read operation
      bus: mhi: ep: Do not allocate memory for MHI objects from DMA zone

Marcin Szycik (1):
      ice: Fix netif_is_ice() in Safe Mode

Masami Hiramatsu (Google) (1):
      bootconfig: Fix the kerneldoc of _xbc_exit()

Mathias Krause (1):
      Input: synaptics-rmi4 - fix UAF of IRQ domain on driver removal

Mathieu Desnoyers (1):
      selftests/rseq: Fix mm_cid test failure

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
      ice: rename switchdev to eswitch

Mohamed Khalfella (1):
      igb: Do not bring the device up after non-fatal error

Neal Cardwell (3):
      tcp: fix to allow timestamp undo if no retransmits were sent
      tcp: fix tcp_enter_recovery() to zero retrans_stamp when it's safe
      tcp: fix TFO SYN_RECV to not zero retrans_stamp with retransmits out

Niklas Cassel (1):
      ata: libata: avoid superfluous disk spin down + spin up during hibernation

Oliver Neukum (1):
      Revert "usb: yurex: Replace snprintf() with the safer scnprintf() variant"

Palmer Dabbelt (1):
      RISC-V: Don't have MAX_PHYSMEM_BITS exceed phys_addr_t

Paolo Abeni (1):
      mptcp: handle consistently DSS corruption

Patrick Roy (1):
      secretmem: disable memfd_secret() if arch cannot set direct map

Paul Menzel (1):
      lib/build_OID_registry: avoid non-destructive substitution for Perl < 5.13.2 compat

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

Qianqiang Liu (1):
      fbcon: Fix a NULL pointer dereference issue in fbcon_putcs

Randy Dunlap (1):
      jbd2: fix kernel-doc for j_transaction_overhead_buffers

Richard Fitzgerald (1):
      ASoC: cs35l56: Load tunings for the correct speaker models

Riyan Dhiman (1):
      staging: vme_user: added bound check to geoid

Rob Clark (1):
      drm/crtc: fix uninitialized variable use even harder

Rosen Penev (1):
      net: ibm: emac: mal: fix wrong goto

Ruffalo Lavoisier (1):
      comedi: ni_routing: tools: Check when the file could not be opened

Saravanan Vajravel (1):
      RDMA/mad: Improve handling of timed out WRs of mad agent

Selvarasu Ganesan (1):
      usb: dwc3: core: Stop processing of pending events if controller is halted

Sergey Senozhatsky (1):
      zram: free secondary algorithms names

Shannon Nelson (1):
      pds_core: no health-thread in VF path

Shawn Shao (1):
      usb: dwc2: Adjust the timing of USB Driver Interrupt Registration in the Crashkernel Scenario

Shyam Sundar S K (2):
      x86/amd_nb: Add new PCI IDs for AMD family 0x1a
      x86/amd_nb: Add new PCI IDs for AMD family 1Ah model 60h

Simon Horman (1):
      netfilter: nf_reject: Fix build warning when CONFIG_BRIDGE_NETFILTER=n

Song Shuai (1):
      riscv: Remove SHADOW_OVERFLOW_STACK_SIZE macro

Srinivas Pandruvada (2):
      thermal: int340x: processor_thermal: Set feature mask before proc_thermal_add
      platform/x86/intel/tpmi: Add defines to get version information

Steven Rostedt (Google) (2):
      tracing: Remove precision vsnprintf() check from print event
      tracing: Have saved_cmdlines arrays all in one allocation

Subramanian Ananthanarayanan (1):
      PCI: Add ACS quirk for Qualcomm SA8775P

SurajSonawane2415 (1):
      hid: intel-ish-hid: Fix uninitialized variable 'rv' in ish_fw_xfer_direct_dma

Tao Chen (1):
      bpf: Check percpu map value size first

Thomas Richter (1):
      s390/cpum_sf: Remove WARN_ON_ONCE statements

Tony Nguyen (1):
      i40e: Include types.h to some headers

Vitaly Lifshits (2):
      e1000e: change I219 (19) devices to ADP
      e1000e: fix force smbus during suspend flow

Wade Wang (1):
      HID: plantronics: Workaround for an unexcepted opposite volume key

Wadim Egorov (1):
      usb: typec: tipd: Free IRQ only if it was requested before

WangYuli (1):
      PCI: Add function 0 DMA alias quirk for Glenfly Arise chip

Wei Fang (1):
      net: fec: don't save PTP state if PTP is unsupported

Wenjing Liu (1):
      drm/amd/display: Remove a redundant check in authenticated_dp

Wentao Guan (1):
      LoongArch: Fix memleak in pci_acpi_scan_root()

Wojciech Drewek (1):
      ice: Flush FDB entries before reset

Wojciech Gładysz (1):
      ext4: nested locking for xattr inode

Xin Long (1):
      sctp: ensure sk_state is set to CLOSED if hashing fails in sctp_listen_start

Xiubo Li (1):
      libceph: init the cursor when preparing sparse read in msgr2

Xu Kuohai (1):
      bpf: Prevent tail call between progs attached to different hooks

Xu Yang (1):
      usb: chipidea: udc: enable suspend interrupt after usb reset

Yang Jihong (4):
      perf sched: Move start_work_mutex and work_done_wait_mutex initialization to perf_sched__replay()
      perf sched: Fix memory leak in perf_sched__map()
      perf sched: Move curr_thread initialization to perf_sched__map()
      perf sched: Move curr_pid and cpu_last_switched initialization to perf_sched__{lat|map|replay}()

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


