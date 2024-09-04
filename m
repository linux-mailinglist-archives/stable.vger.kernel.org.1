Return-Path: <stable+bounces-73041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A785396BB15
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2829D1F272FF
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1361D61AB;
	Wed,  4 Sep 2024 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LSEMJJEL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7F1D61A9;
	Wed,  4 Sep 2024 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450138; cv=none; b=lTF6upxzhNA+hVpe/UT72/y18SFkdZiT3syrMaI+SWCu70OumI7+e2uKJUS3BISA2FtwR8/9AgkYX2l4ZqCqMNPbrNUpP0++YBcPiYD+ShaK7zNx+TRESUr42gpiA54+IaBNV9TSY/Kx2pYJrexG1h6odA7F2hnEkqb6GhPDPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450138; c=relaxed/simple;
	bh=oUMmhAx4JXHtJvGjBNkTQO0g1Z6iMCmS6ULnjcoyKQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jeS8ykDklqsqr5stVaEOzV2BYg53hy/N+vTpGut9EeThM02gr1O9b5URQsakB8o6jdlqraMYW42KV2092viVGJeAKS39BszRtHWw906js0WvJzjrFHQ01NHW2Mby07t0U47Wor1Whdz1IOPMhMJybiQ0Me0bMaRupnydZyGFXf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LSEMJJEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7C4C4CEC2;
	Wed,  4 Sep 2024 11:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725450138;
	bh=oUMmhAx4JXHtJvGjBNkTQO0g1Z6iMCmS6ULnjcoyKQE=;
	h=From:To:Cc:Subject:Date:From;
	b=LSEMJJELykGBF7kHk/Lua8Iw7VrlUMVhNbj0DbkICFuSu0qMMTR5qpjsl5jLbeilQ
	 FPtXYiZLcSzqYrslyCi7myVsyZ5Z07XumytnciQodQaSf5OOOl4tm9zJFBBNSPZKFp
	 hJPAA5diSUZGE6lSpT15eI/axPcAT5OARvypB8DA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.49
Date: Wed,  4 Sep 2024 13:42:01 +0200
Message-ID: <2024090401-slate-repose-e69b@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.49 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    2 
 arch/alpha/kernel/pci_iommu.c                               |    2 
 arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi         |   12 
 arch/arm/boot/dts/ti/omap/omap3-n900.dts                    |    2 
 arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts         |   12 
 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts  |    2 
 arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi           |    2 
 arch/arm64/boot/dts/freescale/imx93.dtsi                    |   15 +
 arch/loongarch/include/asm/dma-direct.h                     |   11 
 arch/mips/jazz/jazzdma.c                                    |    2 
 arch/powerpc/kernel/dma-iommu.c                             |    2 
 arch/powerpc/platforms/ps3/system-bus.c                     |    4 
 arch/powerpc/platforms/pseries/vio.c                        |    2 
 arch/x86/kernel/amd_gart_64.c                               |    2 
 drivers/bluetooth/btnxpuart.c                               |   89 +++++-
 drivers/dma/dw-edma/dw-hdma-v0-core.c                       |   26 -
 drivers/dma/dw/core.c                                       |   89 ++++++
 drivers/firmware/qcom_scm-smc.c                             |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c     |    9 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                   |   21 -
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c                        |  114 ++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                         |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                        |   12 
 drivers/iommu/dma-iommu.c                                   |    2 
 drivers/iommu/io-pgtable-arm-v7s.c                          |    3 
 drivers/iommu/io-pgtable-arm.c                              |    3 
 drivers/iommu/io-pgtable-dart.c                             |    3 
 drivers/iommu/iommufd/ioas.c                                |    8 
 drivers/net/bonding/bond_main.c                             |  159 +++++++-----
 drivers/net/ethernet/microsoft/mana/hw_channel.c            |   62 ++--
 drivers/net/gtp.c                                           |    2 
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                |   13 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c             |   32 +-
 drivers/net/wireless/silabs/wfx/sta.c                       |    5 
 drivers/nfc/pn533/pn533.c                                   |    5 
 drivers/parisc/ccio-dma.c                                   |    2 
 drivers/parisc/sba_iommu.c                                  |    2 
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c                  |    2 
 drivers/phy/xilinx/phy-zynqmp.c                             |   56 ++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c            |   55 ++--
 drivers/pinctrl/pinctrl-rockchip.c                          |    2 
 drivers/pinctrl/pinctrl-single.c                            |    2 
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c          |    4 
 drivers/power/supply/qcom_battmgr.c                         |   16 -
 drivers/scsi/aacraid/comminit.c                             |    2 
 drivers/scsi/sd.c                                           |   12 
 drivers/soc/qcom/cmd-db.c                                   |    2 
 drivers/soc/qcom/pmic_glink.c                               |   30 +-
 drivers/soc/qcom/pmic_glink_altmode.c                       |   17 -
 drivers/soundwire/stream.c                                  |    8 
 drivers/thermal/thermal_of.c                                |   17 -
 drivers/usb/cdns3/cdnsp-gadget.h                            |    3 
 drivers/usb/cdns3/cdnsp-ring.c                              |   30 ++
 drivers/usb/class/cdc-acm.c                                 |    3 
 drivers/usb/core/sysfs.c                                    |    1 
 drivers/usb/dwc3/core.c                                     |    8 
 drivers/usb/dwc3/dwc3-omap.c                                |    4 
 drivers/usb/dwc3/dwc3-st.c                                  |   16 -
 drivers/usb/serial/option.c                                 |    5 
 drivers/usb/typec/tcpm/tcpm.c                               |   14 -
 drivers/usb/typec/ucsi/ucsi_glink.c                         |   16 -
 drivers/xen/grant-dma-ops.c                                 |    2 
 drivers/xen/swiotlb-xen.c                                   |    2 
 fs/btrfs/bio.c                                              |   26 +
 fs/btrfs/qgroup.c                                           |    2 
 fs/overlayfs/params.c                                       |   51 ---
 fs/smb/client/smb2ops.c                                     |   22 +
 fs/smb/client/smb2pdu.c                                     |    2 
 include/linux/dma-map-ops.h                                 |    2 
 include/linux/of.h                                          |   15 +
 include/linux/soc/qcom/pmic_glink.h                         |   11 
 include/net/bonding.h                                       |    2 
 include/net/busy_poll.h                                     |    2 
 include/net/netfilter/nf_tables_ipv4.h                      |   10 
 include/net/netfilter/nf_tables_ipv6.h                      |    5 
 kernel/dma/mapping.c                                        |    4 
 kernel/trace/trace.h                                        |   23 +
 kernel/trace/trace_events.c                                 |   33 +-
 kernel/trace/trace_events_hist.c                            |    4 
 kernel/trace/trace_events_inject.c                          |    2 
 kernel/trace/trace_events_trigger.c                         |    6 
 mm/truncate.c                                               |    4 
 net/bluetooth/hci_core.c                                    |   10 
 net/core/net-sysfs.c                                        |    2 
 net/ethtool/ioctl.c                                         |    3 
 net/mptcp/pm.c                                              |    4 
 net/mptcp/pm_netlink.c                                      |   59 +++-
 net/mptcp/protocol.c                                        |    7 
 net/mptcp/protocol.h                                        |    2 
 net/mptcp/subflow.c                                         |    8 
 net/sctp/sm_statefuns.c                                     |   22 +
 security/apparmor/policy_unpack_test.c                      |    6 
 security/selinux/hooks.c                                    |    4 
 security/smack/smack_lsm.c                                  |    4 
 sound/core/seq/seq_clientmgr.c                              |    3 
 sound/soc/amd/acp/acp-legacy-mach.c                         |    2 
 sound/soc/sof/amd/acp.c                                     |   19 +
 sound/soc/sof/amd/acp.h                                     |    7 
 tools/testing/selftests/iommu/iommufd.c                     |    6 
 tools/testing/selftests/net/forwarding/local_termination.sh |    4 
 tools/testing/selftests/net/forwarding/no_forwarding.sh     |    3 
 tools/testing/selftests/net/mptcp/mptcp_join.sh             |   46 ++-
 102 files changed, 1071 insertions(+), 444 deletions(-)

Adam Ford (1):
      arm64: dts: imx8mp-beacon-kit: Fix Stereo Audio on WM8962

Aleksandr Mishin (1):
      nfc: pn533: Add poll mod list filling check

Alex Deucher (2):
      drm/amdgpu: align pp_power_profile_mode with kernel docs
      drm/amdgpu/swsmu: always force a state reprogram on init

Alexander Sverdlin (1):
      wifi: wfx: repair open network AP mode

Anjaneyulu (1):
      wifi: iwlwifi: fw: fix wgds rev 3 exact size

Ben Hutchings (1):
      scsi: aacraid: Fix double-free on probe failure

Bjorn Andersson (2):
      soc: qcom: pmic_glink: Actually communicate when remote goes down
      soc: qcom: pmic_glink: Fix race during initialization

Christian Brauner (1):
      ovl: pass string to ovl_parse_layer()

Cong Wang (1):
      gtp: fix a potential NULL pointer dereference

David Howells (2):
      mm: Fix missing folio invalidation calls during truncation
      cifs: Fix FALLOC_FL_PUNCH_HOLE support

Eric Dumazet (1):
      net: busy-poll: use ktime_get_ns() instead of local_clock()

Greg Kroah-Hartman (3):
      usb: typec: fix up incorrectly backported "usb: typec: tcpm: unregister existing source caps before re-registration"
      Revert "change alloc_pages name in dma_map_ops to avoid name conflicts"
      Linux 6.6.49

Guenter Roeck (1):
      apparmor: fix policy_unpack_test on big endian systems

Haiyang Zhang (1):
      net: mana: Fix race of mana_hwc_post_rx_wqe and new hwc response

Hal Feng (1):
      pinctrl: starfive: jh7110: Correct the level trigger configuration of iev register

Huang-Huang Bao (1):
      pinctrl: rockchip: correct RK3328 iomux width flag for GPIO2-B pins

Ian Ray (1):
      cdc-acm: Add DISABLE_ECHO quirk for GE HealthCare UI Controller

Jamie Bainbridge (1):
      ethtool: check device is present when getting link settings

Jason Gunthorpe (2):
      iommufd: Do not allow creating areas without READ or WRITE
      iommu: Do not return 0 from map_pages if it doesn't do anything

Jianbo Liu (3):
      bonding: implement xdo_dev_state_free and call it after deletion
      bonding: extract the use of real_device into local variable
      bonding: change ipsec_lock from spin lock to mutex

Jonathan Cameron (2):
      of: Add cleanup.h based auto release via __free(device_node) markings
      of: Introduce for_each_*_child_of_node_scoped() to automate of_node_put() handling

Josef Bacik (1):
      btrfs: run delayed iputs when flushing delalloc

Krzysztof Kozlowski (6):
      thermal: of: Fix OF node leak in thermal_of_trips_init() error path
      thermal: of: Fix OF node leak in of_thermal_zone_find() error paths
      soundwire: stream: fix programming slave ports for non-continous port maps
      usb: dwc3: omap: add missing depopulate in probe error path
      usb: dwc3: st: fix probed platform device ref count on probe error path
      usb: dwc3: st: add missing depopulate in probe error path

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix not handling hibernation actions

Ma Ke (2):
      pinctrl: single: fix potential NULL dereference in pcs_get_function()
      drm/amd/display: avoid using null object of framebuffer

Markus Niebel (2):
      arm64: dts: freescale: imx93-tqma9352: fix CMA alloc-ranges
      arm64: dts: freescale: imx93-tqma9352-mba93xxla: fix typo

Matthieu Baerts (NGI0) (12):
      mptcp: close subflow when receiving TCP+FIN
      mptcp: sched: check both backup in retrans
      mptcp: pm: reuse ID 0 after delete and re-add
      mptcp: pm: skip connecting to already established sf
      mptcp: pm: reset MPC endp ID when re-added
      mptcp: pm: send ACK on an active subflow
      mptcp: pm: do not remove already closed subflows
      mptcp: pm: fix ID 0 endp usage after multiple re-creations
      mptcp: pm: ADD_ADDR 0 is not a new address
      selftests: mptcp: join: check removing ID 0 endpoint
      selftests: mptcp: join: no extra msg if no counter
      selftests: mptcp: join: check re-re-adding ID 0 endp

Miao Wang (1):
      LoongArch: Remove the unused dma-direct.h

Michal Vokáč (1):
      ARM: dts: imx6dl-yapp43: Increase LED current to match the yapp4 HW design

Mrinmay Sarkar (2):
      dmaengine: dw-edma: Fix unmasking STOP and ABORT interrupts for HDMA
      dmaengine: dw-edma: Do not enable watermark interrupts for HDMA

Murali Nalajala (1):
      firmware: qcom: scm: Mark get_wq_ctx() as atomic call

Neeraj Sanjay Kale (3):
      Bluetooth: btnxpuart: Resolve TX timeout error in power save stress test
      Bluetooth: btnxpuart: Handle FW Download Abort scenario
      Bluetooth: btnxpuart: Fix random crash seen while removing driver

Nícolas F. R. A. Prado (1):
      pinctrl: mediatek: common-v2: Fix broken bias-disable for PULL_PU_PD_RSEL_TYPE

Ondrej Mosnacek (1):
      sctp: fix association labeling in the duplicate COOKIE-ECHO case

Pablo Neira Ayuso (2):
      netfilter: nf_tables: restore IP sanity checks for netdev/egress
      netfilter: nf_tables_ipv6: consider network offset in netdev/egress validation

Pawel Laszczak (2):
      usb: cdnsp: fix incorrect index in cdnsp_get_hw_deq function
      usb: cdnsp: fix for Link TRB with TC

Peng Fan (2):
      arm64: dts: imx93: add nvmem property for fec1
      arm64: dts: imx93: add nvmem property for eqos

Petr Machata (2):
      selftests: forwarding: no_forwarding: Down ports on cleanup
      selftests: forwarding: local_termination: Down ports on cleanup

Piyush Mehta (1):
      phy: xilinx: phy-zynqmp: Fix SGMII linkup failure on resume

Qu Wenruo (1):
      btrfs: fix a use-after-free when hitting errors inside btrfs_submit_chunk()

Sascha Hauer (1):
      wifi: mwifiex: duplicate static structs used in driver instances

Scott Mayhew (1):
      selinux,smack: don't bypass permissions check in inode_setsecctx hook

Selvarasu Ganesan (1):
      usb: dwc3: core: Prevent USB core invalid event buffer address access

Serge Semin (2):
      dmaengine: dw: Add peripheral bus width verification
      dmaengine: dw: Add memory bus width verification

Shenwei Wang (1):
      arm64: dts: imx93: update default value for snps,clk-csr

Sicelo A. Mhlongo (1):
      ARM: dts: omap3-n900: correct the accelerometer orientation

Stefan Metzmacher (1):
      smb/client: avoid dereferencing rdata=NULL in smb2_new_read_req()

Steven Rostedt (1):
      tracing: Have format file honor EVENT_FILE_FL_FREED

Takashi Iwai (1):
      ALSA: seq: Skip event type filtering for UMP events

Vijendar Mukunda (1):
      ASoC: SOF: amd: Fix for acp init sequence

Volodymyr Babchuk (1):
      soc: qcom: cmd-db: Map shared memory as WC, not WB

Xu Yang (1):
      phy: fsl-imx8mq-usb: fix tuning parameter name

Yihang Li (1):
      scsi: sd: Ignore command SYNCHRONIZE CACHE error if format in progress

Yuntao Liu (1):
      ASoC: amd: acp: fix module autoloading

ZHANG Yuntian (1):
      USB: serial: option: add MeiG Smart SRM825L

Zack Rusin (1):
      drm/vmwgfx: Fix prime with external buffers

Zhihao Cheng (2):
      ovl: fix wrong lowerdir number check for parameter Opt_lowerdir
      ovl: ovl_parse_param_lowerdir: Add missed '\n' for pr_err

Zijun Hu (1):
      usb: core: sysfs: Unmerge @usb3_hardware_lpm_attr_group in remove_power_attributes()


