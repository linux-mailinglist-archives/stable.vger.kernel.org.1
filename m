Return-Path: <stable+bounces-151400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC72EACDE90
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8855B7A39DF
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7076029009B;
	Wed,  4 Jun 2025 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CG4GQp1p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ED9290096;
	Wed,  4 Jun 2025 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042452; cv=none; b=AbKymV3nAv9H3yI1inLls+Q6aIK3dwEALZQtN0gwe+TEN8K07Q+UzAb1wYneo+3FW9EKaJUWVk8Jp3JS+ZuklSitCoUfck6O/WzDWoQxn2FKBUzcoznN8ps6c91GiRhYtlQsIkGpNNp9EPY6tRn7AoKnNAp6tlU8qgbiH/sm6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042452; c=relaxed/simple;
	bh=YnbVhycwNlCAmLvUJ5SxF0iHmjf6LW/tw6qgy9F6qpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=muuw2P8LWMLt+LoVyYa93Hdyx8FuyK7sWsV2UeuqJFMmZlNVHKtG2lrTAnOMen1no/Vyfvn8lOn5jRmaMyGH7IrVMfWhgPvV2QMxpB4gn8unVyu8kB5xEvSs4UPJxbqy0/hq7HR6sXIwTX2E31r1T9JfSuPipJh2xuYdJY0S/T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CG4GQp1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CD5C4CEE7;
	Wed,  4 Jun 2025 13:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749042451;
	bh=YnbVhycwNlCAmLvUJ5SxF0iHmjf6LW/tw6qgy9F6qpU=;
	h=From:To:Cc:Subject:Date:From;
	b=CG4GQp1pwDGzlQFCDiZ0oMHSsN3PtbR1qdmAcB13sG5qeeF8e9f+Pms/4wIPA6IT/
	 YasIF22rO1I63XAJMb9n4411i55FApyC85p3iQEqu8JjfFYBb7Rv5vNxyFjiTixx+o
	 RC+TT1kB9ktZOTP4LW+5JjMxWjOutXI0pMdbvUbo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.32
Date: Wed,  4 Jun 2025 15:07:27 +0200
Message-ID: <2025060428-exile-lubricate-e455@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.32 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                             |    2 
 arch/arm64/boot/dts/qcom/ipq9574.dtsi                                |    2 
 arch/arm64/boot/dts/qcom/sa8775p.dtsi                                |  246 ----------
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts              |    4 
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts             |    7 
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                            |    6 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                               |   10 
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
 drivers/hid/hid-ids.h                                                |    4 
 drivers/hid/hid-quirks.c                                             |    2 
 drivers/net/can/kvaser_pciefd.c                                      |   81 +--
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                             |    2 
 drivers/nvme/host/pci.c                                              |    2 
 drivers/perf/arm-cmn.c                                               |   11 
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c                    |    2 
 drivers/phy/starfive/phy-jh7110-usb.c                                |    7 
 drivers/platform/x86/fujitsu-laptop.c                                |   33 +
 drivers/platform/x86/thinkpad_acpi.c                                 |    7 
 drivers/spi/spi-sun4i.c                                              |    5 
 fs/coredump.c                                                        |   65 ++
 fs/nfs/client.c                                                      |    2 
 fs/nfs/dir.c                                                         |   15 
 fs/nfs/filelayout/filelayoutdev.c                                    |    6 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                            |    6 
 fs/nfs/pnfs.h                                                        |    4 
 fs/nfs/pnfs_nfs.c                                                    |    9 
 fs/smb/server/oplock.c                                               |    7 
 include/linux/coredump.h                                             |    1 
 include/linux/nfs_fs_sb.h                                            |   12 
 net/sched/sch_hfsc.c                                                 |    9 
 sound/pci/hda/patch_realtek.c                                        |    5 
 57 files changed, 406 insertions(+), 353 deletions(-)

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

George Shen (1):
      drm/amd/display: fix link_set_dpms_off multi-display MST corner case

Greg Kroah-Hartman (1):
      Linux 6.12.32

Hal Feng (1):
      phy: starfive: jh7110-usb: Fix USB 2.0 host occasional detection failure

Ilya Guterman (1):
      nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro

Jeff Layton (1):
      nfs: don't share pNFS DS connections between net namespaces

Johan Hovold (2):
      arm64: dts: qcom: x1e80100-qcp: mark l12b and l15b always-on
      arm64: dts: qcom: x1e80100-yoga-slim7x: mark l12b and l15b always-on

John Chau (1):
      platform/x86: thinkpad_acpi: Support also NEC Lavie X1475JAS

Judith Mendez (4):
      arm64: dts: ti: k3-am62-main: Set eMMC clock parent to default
      arm64: dts: ti: k3-am62a-main: Set eMMC clock parent to default
      arm64: dts: ti: k3-am62p-j722s-common-main: Set eMMC clock parent to default
      arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0

Kailang Yang (1):
      ALSA: hda/realtek - restore auto-mute mode for Dell Chrome platform

Karthik Sanagavarapu (1):
      arm64: dts: qcom: sa8775p: Remove cdsp compute-cb@10

Ling Xu (1):
      arm64: dts: qcom: sa8775p: Remove extra entries from the iommus property

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

Nishanth Menon (1):
      net: ethernet: ti: am65-cpsw: Lower random mac address error print to info

Pedro Tammela (1):
      net_sched: hfsc: Address reentrant enqueue adding class to eltree twice

Purva Yeshi (2):
      dmaengine: idxd: cdev: Fix uninitialized use of sva in idxd_cdev_open
      char: tpm: tpm-buf: Add sanity check fallback in read helpers

Robin Murphy (3):
      perf/arm-cmn: Fix REQ2/SNP2 mixup
      perf/arm-cmn: Initialise cmn->cpu earlier
      perf/arm-cmn: Add CMN S3 ACPI binding

Siddharth Vadapalli (3):
      arm64: dts: ti: k3-j722s-evm: Enable "serdes_wiz0" and "serdes_wiz1"
      arm64: dts: ti: k3-j722s-main: Disable "serdes_wiz0" and "serdes_wiz1"
      arm64: dts: ti: k3-j784s4-j742s2-main-common: Fix length of serdes_ln_ctrl

Stephan Gerhold (8):
      arm64: dts: qcom: ipq9574: Add missing properties for cryptobam
      arm64: dts: qcom: sm8450: Add missing properties for cryptobam
      arm64: dts: qcom: sm8550: Add missing properties for cryptobam
      arm64: dts: qcom: sm8650: Add missing properties for cryptobam
      arm64: dts: qcom: x1e80100-asus-vivobook-s15: Fix vreg_l2j_1p2 voltage
      arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x: Fix vreg_l2j_1p2 voltage
      arm64: dts: qcom: x1e80100-qcp: Fix vreg_l2j_1p2 voltage
      arm64: dts: qcom: x1e80100: Fix video thermal zone

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


