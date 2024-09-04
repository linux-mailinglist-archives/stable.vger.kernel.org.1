Return-Path: <stable+bounces-73039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD2A96BB12
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555A62838F4
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9011D1F42;
	Wed,  4 Sep 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xsj8aYbj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E705B1D1F47;
	Wed,  4 Sep 2024 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450131; cv=none; b=uKNhC0fu8BWAWW9xGqcRQjYW/ZpccRpgXRayn5S3MJH5mlebeZQvF5zM0JgMtFVuJhYUS79TCLffkPstLWB9f3p3CrOaaX7nzwKjy5eGuMKO7X35CcI2REymHKys/sCX/QhE3QiRoHzGYksXVuAR2M1B71wRUluvKZzIsn7k3cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450131; c=relaxed/simple;
	bh=tBTsgBo1jQB8/1tbRmgsGAOIw7vlZueVLCUEJ3E+hbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XZPcOuRiuWuEDiSUbh87LFOVnuKkdM223OIJvzkk0BV99ynQ/EMmJRuVTloY1N9+Absxbz4MJkzc1/FiPk6Ps/NSK9a95kIo8UvMh57tIj3Qa0ZgnB83eSQSlPEuEuoOIpS2vMT46lQNPTaFn8l7od56coqDE3RyE+BILrgIu0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xsj8aYbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5721CC4CEC9;
	Wed,  4 Sep 2024 11:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725450130;
	bh=tBTsgBo1jQB8/1tbRmgsGAOIw7vlZueVLCUEJ3E+hbI=;
	h=From:To:Cc:Subject:Date:From;
	b=Xsj8aYbj5ob4vdbiwc6yz8+cN39gohjJDyRfc+k9UnoDiZA6mli4yWXvlYeRsJ9mS
	 GH/HI/zyIa95hXMs1j4b62K/5gLlC1mMIeI1VXmnuhyK+puo9Pc9SejKvRsfpdtWHk
	 Bpnfcn2Xuk4FTFuGj4aRoK9nEp+mt2AbVyxtBzpM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.108
Date: Wed,  4 Sep 2024 13:41:55 +0200
Message-ID: <2024090456-glutton-annuity-5d91@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.108 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    2 
 arch/loongarch/include/asm/dma-direct.h                     |   11 
 drivers/ata/libata-core.c                                   |    3 
 drivers/dma/dw/core.c                                       |   89 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                     |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c     |    9 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                   |   21 -
 drivers/iommu/io-pgtable-arm-v7s.c                          |    3 
 drivers/iommu/io-pgtable-arm.c                              |    3 
 drivers/iommu/io-pgtable-dart.c                             |    3 
 drivers/mmc/core/core.c                                     |    3 
 drivers/mmc/host/dw_mmc.c                                   |    3 
 drivers/mmc/host/mtk-sd.c                                   |   14 -
 drivers/mmc/host/sdhci-msm.c                                |    3 
 drivers/mmc/host/sdhci-pci-o2micro.c                        |    3 
 drivers/mmc/host/sdhci-tegra.c                              |    8 
 drivers/mmc/host/sdhci.c                                    |    9 
 drivers/net/bonding/bond_main.c                             |   36 ++
 drivers/net/ethernet/intel/igc/igc_tsn.c                    |    9 
 drivers/net/ethernet/microsoft/mana/hw_channel.c            |   62 ++--
 drivers/net/gtp.c                                           |    2 
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                |   13 -
 drivers/net/wireless/marvell/mwifiex/cfg80211.c             |   32 ++
 drivers/net/wireless/silabs/wfx/sta.c                       |    5 
 drivers/nfc/pn533/pn533.c                                   |    5 
 drivers/phy/xilinx/phy-zynqmp.c                             |  152 +++++++-----
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c            |   55 ++--
 drivers/pinctrl/pinctrl-rockchip.c                          |    2 
 drivers/pinctrl/pinctrl-single.c                            |    2 
 drivers/scsi/aacraid/comminit.c                             |    2 
 drivers/soc/qcom/cmd-db.c                                   |    2 
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
 drivers/video/fbdev/offb.c                                  |    1 
 fs/btrfs/compression.c                                      |    2 
 fs/btrfs/qgroup.c                                           |    2 
 fs/smb/client/smb2pdu.c                                     |    2 
 include/linux/of.h                                          |   15 +
 include/net/busy_poll.h                                     |    2 
 include/net/netfilter/nf_tables_ipv4.h                      |   10 
 include/net/netfilter/nf_tables_ipv6.h                      |    5 
 mm/truncate.c                                               |    4 
 net/bluetooth/hci_core.c                                    |   10 
 net/core/net-sysfs.c                                        |    2 
 net/ethtool/ioctl.c                                         |    3 
 net/mptcp/pm.c                                              |   32 +-
 net/mptcp/pm_netlink.c                                      |  110 ++++----
 net/mptcp/protocol.c                                        |    7 
 net/mptcp/protocol.h                                        |    7 
 net/mptcp/subflow.c                                         |    8 
 net/sctp/sm_statefuns.c                                     |   22 +
 security/apparmor/policy_unpack_test.c                      |    6 
 sound/soc/amd/acp/acp-legacy-mach.c                         |    2 
 sound/soc/sof/amd/acp.c                                     |   19 +
 sound/soc/sof/amd/acp.h                                     |    7 
 tools/testing/selftests/net/forwarding/local_termination.sh |    4 
 tools/testing/selftests/net/forwarding/no_forwarding.sh     |    3 
 66 files changed, 649 insertions(+), 314 deletions(-)

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

ChanWoo Lee (1):
      mmc: Avoid open coding by using mmc_op_tuning()

Cong Wang (1):
      gtp: fix a potential NULL pointer dereference

David Howells (1):
      mm: Fix missing folio invalidation calls during truncation

Eric Dumazet (1):
      net: busy-poll: use ktime_get_ns() instead of local_clock()

Faizal Rahim (2):
      igc: Fix reset adapter logics when tx mode change
      igc: Fix qbv tx latency by setting gtxoffset

Filipe Manana (1):
      btrfs: fix extent map use-after-free when adding pages to compressed bio

Geliang Tang (1):
      mptcp: unify pm get_local_id interfaces

Greg Kroah-Hartman (3):
      usb: typec: fix up incorrectly backported "usb: typec: tcpm: unregister existing source caps before re-registration"
      fbdev: offb: fix up missing cleanup.h
      Linux 6.1.108

Guenter Roeck (1):
      apparmor: fix policy_unpack_test on big endian systems

Haiyang Zhang (1):
      net: mana: Fix race of mana_hwc_post_rx_wqe and new hwc response

Huang-Huang Bao (1):
      pinctrl: rockchip: correct RK3328 iomux width flag for GPIO2-B pins

Ian Ray (1):
      cdc-acm: Add DISABLE_ECHO quirk for GE HealthCare UI Controller

Jamie Bainbridge (1):
      ethtool: check device is present when getting link settings

Jason Gunthorpe (1):
      iommu: Do not return 0 from map_pages if it doesn't do anything

Jesse Zhang (1):
      drm/amdgpu: Using uninitialized value *size when calling amdgpu_vce_cs_reloc

Jianbo Liu (1):
      bonding: implement xdo_dev_state_free and call it after deletion

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

Matthieu Baerts (NGI0) (10):
      mptcp: close subflow when receiving TCP+FIN
      mptcp: sched: check both backup in retrans
      mptcp: pm: skip connecting to already established sf
      mptcp: pm: reset MPC endp ID when re-added
      mptcp: pm: send ACK on an active subflow
      mptcp: pm: do not remove already closed subflows
      mptcp: pm: ADD_ADDR 0 is not a new address
      mptcp: pm: remove mptcp_pm_remove_subflow()
      mptcp: pm: only mark 'subflow' endp as available
      mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR

Mengqi Zhang (1):
      mmc: mtk-sd: receive cmd8 data when hs400 tuning fail

Miao Wang (1):
      LoongArch: Remove the unused dma-direct.h

Niklas Cassel (1):
      ata: libata-core: Fix null pointer dereference on error

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

Petr Machata (2):
      selftests: forwarding: no_forwarding: Down ports on cleanup
      selftests: forwarding: local_termination: Down ports on cleanup

Piyush Mehta (3):
      phy: xilinx: add runtime PM support
      phy: xilinx: phy-zynqmp: dynamic clock support for power-save
      phy: xilinx: phy-zynqmp: Fix SGMII linkup failure on resume

Sascha Hauer (1):
      wifi: mwifiex: duplicate static structs used in driver instances

Sean Anderson (1):
      phy: zynqmp: Enable reference clock correctly

Selvarasu Ganesan (1):
      usb: dwc3: core: Prevent USB core invalid event buffer address access

Serge Semin (2):
      dmaengine: dw: Add peripheral bus width verification
      dmaengine: dw: Add memory bus width verification

Stefan Metzmacher (1):
      smb/client: avoid dereferencing rdata=NULL in smb2_new_read_req()

Vijendar Mukunda (1):
      ASoC: SOF: amd: Fix for acp init sequence

Volodymyr Babchuk (1):
      soc: qcom: cmd-db: Map shared memory as WC, not WB

Yuntao Liu (1):
      ASoC: amd: acp: fix module autoloading

ZHANG Yuntian (1):
      USB: serial: option: add MeiG Smart SRM825L

Zijun Hu (1):
      usb: core: sysfs: Unmerge @usb3_hardware_lpm_attr_group in remove_power_attributes()


