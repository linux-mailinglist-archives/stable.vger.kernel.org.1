Return-Path: <stable+bounces-151402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8F4ACDE96
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E831C189A5D1
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B2D290BCB;
	Wed,  4 Jun 2025 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JNbZAHLX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA40290BC8;
	Wed,  4 Jun 2025 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042460; cv=none; b=Cw2HV9CtAGXQhqjSQ1Q6N9jE8sWXisOnX3Zn9PPcrRdNFGtQF0+giI5WVM4ZO20npiKuXT6tKqarEllSd3KQnpDMJitLrOPthM+Z46WGBbFZRAZpbxX2YpWsHd+Ycrn3CohLhEn2fOrbV5RysNCEkh8bU7zCsLtutbTmt0RYtxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042460; c=relaxed/simple;
	bh=kdMBXsfn38QcEibyN76/lcT4C2epGwHE/sJbI4Uz574=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OjD2893RHrI7ydZWtWmi4xXReUbOq5xmU4CXPHCcPLO3hWTP2Xp4RmNIEugJM173BvrCzNPp5QP+D4Kp0cD+KEWKnRQWasHmTdqhqTJXzUmQ97+swMY9Nra48H3hs7scIRmkErhqR1KlI4PMbK8tdCO4jJfzIKOROCg4j5jrRzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JNbZAHLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A37C4CEF0;
	Wed,  4 Jun 2025 13:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749042460;
	bh=kdMBXsfn38QcEibyN76/lcT4C2epGwHE/sJbI4Uz574=;
	h=From:To:Cc:Subject:Date:From;
	b=JNbZAHLXAGnS6awRNeHQpQ/63o3kihJV4aw1r3+AYWCAJRaWREHj/BObz8cPYObZE
	 qj+oWTWQhsQ5mQCSWLqK3KgB5uPuiPzqTn3V6WeicMeIOSixnh4MUBCPbUYJArI4HS
	 I551zf+1o12SihOQHqNcfnMhPuHqJlo0hRyUJqgw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.14.10
Date: Wed,  4 Jun 2025 15:07:32 +0200
Message-ID: <2025060433-cyclic-dares-5e34@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.14.10 kernel.

All users of the 6.14 kernel series must upgrade.

The updated 6.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                             |    2 
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi                       |    4 
 arch/arm64/boot/dts/qcom/ipq9574.dtsi                                |    2 
 arch/arm64/boot/dts/qcom/sa8775p.dtsi                                |  248 --------
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                         |    6 
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts              |    4 
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts                |    2 
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts                |   14 
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts             |    7 
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                            |    6 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                               |  309 +++++-----
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                        |   40 -
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                             |    2 
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                            |    2 
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi               |    2 
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso                  |    3 
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso                  |    2 
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso             |    2 
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi                             |    2 
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts                     |   13 
 arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso             |   35 +
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                               |   31 +
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                              |    8 
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi                            |    4 
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi             |    2 
 arch/um/Makefile                                                     |    1 
 drivers/char/tpm/tpm-buf.c                                           |    6 
 drivers/dma/idxd/cdev.c                                              |    4 
 drivers/gpio/gpio-virtuser.c                                         |   12 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c |   20 
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c                      |   13 
 drivers/gpu/drm/xe/regs/xe_gt_regs.h                                 |    1 
 drivers/gpu/drm/xe/xe_lrc.c                                          |    4 
 drivers/gpu/drm/xe/xe_lrc_types.h                                    |    4 
 drivers/gpu/drm/xe/xe_wa.c                                           |    4 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c                        |    5 
 drivers/hid/hid-ids.h                                                |    4 
 drivers/hid/hid-quirks.c                                             |    2 
 drivers/iommu/iommu.c                                                |   26 
 drivers/net/can/kvaser_pciefd.c                                      |   81 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                             |    2 
 drivers/nvme/host/core.c                                             |   30 
 drivers/nvme/host/multipath.c                                        |    3 
 drivers/nvme/host/nvme.h                                             |    3 
 drivers/nvme/host/pci.c                                              |    2 
 drivers/nvme/target/pci-epf.c                                        |   10 
 drivers/perf/arm-cmn.c                                               |   11 
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c                    |    2 
 drivers/phy/starfive/phy-jh7110-usb.c                                |    7 
 drivers/platform/x86/fujitsu-laptop.c                                |   33 -
 drivers/platform/x86/thinkpad_acpi.c                                 |    7 
 drivers/spi/spi-sun4i.c                                              |    5 
 fs/coredump.c                                                        |   65 +-
 fs/nfs/client.c                                                      |    2 
 fs/nfs/dir.c                                                         |   15 
 fs/nfs/filelayout/filelayoutdev.c                                    |    6 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                            |    6 
 fs/nfs/pnfs.h                                                        |    4 
 fs/nfs/pnfs_nfs.c                                                    |    9 
 fs/smb/server/oplock.c                                               |    7 
 include/linux/coredump.h                                             |    1 
 include/linux/iommu.h                                                |    2 
 include/linux/nfs_fs_sb.h                                            |   12 
 kernel/module/Kconfig                                                |    5 
 net/sched/sch_hfsc.c                                                 |    9 
 sound/pci/hda/patch_realtek.c                                        |    5 
 70 files changed, 672 insertions(+), 538 deletions(-)

Abel Vesa (1):
      arm64: dts: qcom: x1e80100: Fix PCIe 3rd controller DBI size

Alan Adamson (2):
      nvme: multipath: enable BLK_FEAT_ATOMIC_WRITES for multipathing
      nvme: all namespaces in a subsystem must adhere to a common atomic write size

Alessandro Grassi (1):
      spi: spi-sun4i: fix early activation

Algea Cao (1):
      phy: phy-rockchip-samsung-hdptx: Fix PHY PLL output 50.25MHz error

Alok Tiwari (1):
      arm64: dts: qcom: sm8350: Fix typo in pil_camera_mem node

Aradhya Bhatia (1):
      drm/xe/xe2hpg: Add Wa_22021007897

Aurabindo Pillai (1):
      drm/amd/display: check stream id dml21 wrapper to get plane_id

Axel Forsman (1):
      can: kvaser_pciefd: Force IRQ edge in case of nested IRQ

Christian Brauner (2):
      coredump: fix error handling for replace_fd()
      coredump: hand a pidfd to the usermode coredump helper

Damien Le Moal (1):
      nvmet: pci-epf: cleanup nvmet_pci_epf_raise_irq()

George Shen (1):
      drm/amd/display: fix link_set_dpms_off multi-display MST corner case

Greg Kroah-Hartman (1):
      Linux 6.14.10

Hal Feng (1):
      phy: starfive: jh7110-usb: Fix USB 2.0 host occasional detection failure

Ilya Guterman (1):
      nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro

Jeff Layton (1):
      nfs: don't share pNFS DS connections between net namespaces

Johan Hovold (5):
      arm64: dts: qcom: x1e001de-devkit: mark l12b and l15b always-on
      arm64: dts: qcom: x1e80100-dell-xps13-9345: mark l12b and l15b always-on
      arm64: dts: qcom: x1e80100-hp-x14: mark l12b and l15b always-on
      arm64: dts: qcom: x1e80100-qcp: mark l12b and l15b always-on
      arm64: dts: qcom: x1e80100-yoga-slim7x: mark l12b and l15b always-on

John Chau (1):
      platform/x86: thinkpad_acpi: Support also NEC Lavie X1475JAS

Judith Mendez (4):
      arm64: dts: ti: k3-am62-main: Set eMMC clock parent to default
      arm64: dts: ti: k3-am62a-main: Set eMMC clock parent to default
      arm64: dts: ti: k3-am62p-j722s-common-main: Set eMMC clock parent to default
      arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0

Juerg Haefliger (1):
      arm64: dts: qcom: x1e80100-hp-omnibook-x14: Enable SMB2360 0 and 1

Kailang Yang (1):
      ALSA: hda/realtek - restore auto-mute mode for Dell Chrome platform

Karthik Sanagavarapu (1):
      arm64: dts: qcom: sa8775p: Remove cdsp compute-cb@10

Ling Xu (1):
      arm64: dts: qcom: sa8775p: Remove extra entries from the iommus property

Lukasz Czechowski (1):
      arm64: dts: rockchip: fix internal USB hub instability on RK3399 Puma

Mario Limonciello (1):
      HID: amd_sfh: Avoid clearing reports for SRA sensor

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Ignore battery threshold change event notification

Markus Burri (1):
      gpio: virtuser: fix potential out-of-bound write

Masahiro Yamada (1):
      um: let 'make clean' properly clean underlying SUBARCH as well

Milton Barrera (1):
      HID: quirks: Add ADATA XPG alpha wireless mouse support

Namjae Jeon (1):
      ksmbd: use list_first_entry_or_null for opinfo_get_list()

Niravkumar L Rabara (1):
      arm64: dts: socfpga: agilex5: fix gpio0 address

Nishanth Menon (1):
      net: ethernet: ti: am65-cpsw: Lower random mac address error print to info

Pedro Tammela (1):
      net_sched: hfsc: Address reentrant enqueue adding class to eltree twice

Purva Yeshi (2):
      dmaengine: idxd: cdev: Fix uninitialized use of sva in idxd_cdev_open
      char: tpm: tpm-buf: Add sanity check fallback in read helpers

Robin Murphy (4):
      perf/arm-cmn: Fix REQ2/SNP2 mixup
      perf/arm-cmn: Initialise cmn->cpu earlier
      perf/arm-cmn: Add CMN S3 ACPI binding
      iommu: Handle yet another race around registration

Sami Tolvanen (1):
      kbuild: Require pahole <v1.28 or >v1.29 with GENDWARFKSYMS on X86

Siddharth Vadapalli (3):
      arm64: dts: ti: k3-j722s-evm: Enable "serdes_wiz0" and "serdes_wiz1"
      arm64: dts: ti: k3-j722s-main: Disable "serdes_wiz0" and "serdes_wiz1"
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Fix length of serdes_ln_ctrl

Stephan Gerhold (13):
      arm64: dts: qcom: ipq9574: Add missing properties for cryptobam
      arm64: dts: qcom: sa8775p: Add missing properties for cryptobam
      arm64: dts: qcom: sm8450: Add missing properties for cryptobam
      arm64: dts: qcom: sm8550: Add missing properties for cryptobam
      arm64: dts: qcom: sm8650: Add missing properties for cryptobam
      arm64: dts: qcom: x1e001de-devkit: Fix vreg_l2j_1p2 voltage
      arm64: dts: qcom: x1e80100-asus-vivobook-s15: Fix vreg_l2j_1p2 voltage
      arm64: dts: qcom: x1e80100-hp-omnibook-x14: Fix vreg_l2j_1p2 voltage
      arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x: Fix vreg_l2j_1p2 voltage
      arm64: dts: qcom: x1e80100-qcp: Fix vreg_l2j_1p2 voltage
      arm64: dts: qcom: x1e80100: Fix video thermal zone
      arm64: dts: qcom: x1e80100: Apply consistent critical thermal shutdown
      arm64: dts: qcom: x1e80100: Add GPU cooling

Trond Myklebust (1):
      NFS: Avoid flushing data while holding directory locks in nfs_rename()

Umesh Nerlige Ramappa (1):
      drm/xe: Save the gt pointer in lrc and drop the tile

Valtteri Koskivuori (1):
      platform/x86: fujitsu-laptop: Support Lifebook S2110 hotkeys

Yemike Abhilash Chandra (7):
      arm64: dts: ti: k3-am62x: Remove clock-names property from IMX219 overlay
      arm64: dts: ti: k3-am62x: Rename I2C switch to I2C mux in IMX219 overlay
      arm64: dts: ti: k3-am62x: Rename I2C switch to I2C mux in OV5640 overlay
      arm64: dts: ti: k3-am68-sk: Fix regulator hierarchy
      arm64: dts: ti: k3-j721e-sk: Add DT nodes for power regulators
      arm64: dts: ti: k3-j721e-sk: Remove clock-names property from IMX219 overlay
      arm64: dts: ti: k3-j721e-sk: Add requiried voltage supplies for IMX219


