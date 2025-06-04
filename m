Return-Path: <stable+bounces-151404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 887CAACDE9E
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECBF189A615
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660A9291146;
	Wed,  4 Jun 2025 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w/FfYPHH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D8E28F935;
	Wed,  4 Jun 2025 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042495; cv=none; b=upCjdpMH5kK7Reupd3hDgDQMVn51S/ZFvOaOlcJJZYnlD61RnA0S56rfVxeX9FbIuhQa2JD+XwPJF8trlP5gwUSocIAnXuiIRO3CuElLoea/porRCMNNJT09mCiawOfZ7EOcwuEZZ5NJc26w625bIjNXvLl958+cPnstR3QLYac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042495; c=relaxed/simple;
	bh=UR8I1JXHlwp7wjKuuuJEtkxlyaVUMaHRzGq+2e6KiGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRC5sDUp2JA7Z2PlAEM9hzBH6xp5XLlK2iILW4Xhhgsvqj86bBlNthJkV4wd/CflfvFb7gQv244fxaer9H4KlHIi9HLYLvr47mNyOpziw0Big+lKuKrhrztdlk2buX5bEq738y5h9fUqTzcxzu3DAogu7U+T1WtbGwweFXa+rkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w/FfYPHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D0EC4CEEF;
	Wed,  4 Jun 2025 13:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749042493;
	bh=UR8I1JXHlwp7wjKuuuJEtkxlyaVUMaHRzGq+2e6KiGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=w/FfYPHHYWVSrXYZacCXq9qNRGndclMtlgep61STtrVV7mLhzeSiRdR5VSlVNyP2H
	 1EzSXgY6XWa7MXLvVljnX/e1slQRyekluSbx/K2bQJpeaLZZOmnioTlAPm9q2B+oUF
	 FHqFNM+VXYixPp4ba7B+N9De5+wuIZ2O8I2zH/90=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.15.1
Date: Wed,  4 Jun 2025 15:08:09 +0200
Message-ID: <2025060455-steering-surfboard-abe4@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.15.1 kernel.

All users of the 6.15 kernel series must upgrade.

The updated 6.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                 |    2 
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi           |    4 
 arch/arm64/boot/dts/qcom/ipq9574.dtsi                    |    2 
 arch/arm64/boot/dts/qcom/sa8775p.dtsi                    |  248 +-----------
 arch/arm64/boot/dts/qcom/sm8350.dtsi                     |    2 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                     |    2 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                     |    2 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                     |    2 
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts             |    6 
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts  |    4 
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts    |    2 
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts    |   14 
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts |    7 
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                |    6 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                   |  309 +++++++--------
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi            |   40 +
 arch/arm64/boot/dts/rockchip/rk3576.dtsi                 |    2 
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                 |    2 
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                |    2 
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi   |    2 
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso      |    3 
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso      |    2 
 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso |    2 
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi                 |    2 
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts         |   13 
 arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso |   35 +
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                   |   31 +
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                  |    8 
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi                |    4 
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi |    2 
 drivers/iommu/iommu.c                                    |   34 +
 drivers/perf/arm-cmn.c                                   |   11 
 fs/coredump.c                                            |   65 ++-
 fs/pidfs.c                                               |    1 
 include/linux/coredump.h                                 |    1 
 include/linux/iommu.h                                    |    2 
 net/sched/sch_hfsc.c                                     |    9 
 37 files changed, 446 insertions(+), 439 deletions(-)

Abel Vesa (1):
      arm64: dts: qcom: x1e80100: Fix PCIe 3rd controller DBI size

Alok Tiwari (1):
      arm64: dts: qcom: sm8350: Fix typo in pil_camera_mem node

Christian Brauner (3):
      pidfs: move O_RDWR into pidfs_alloc_file()
      coredump: fix error handling for replace_fd()
      coredump: hand a pidfd to the usermode coredump helper

Greg Kroah-Hartman (1):
      Linux 6.15.1

Johan Hovold (5):
      arm64: dts: qcom: x1e001de-devkit: mark l12b and l15b always-on
      arm64: dts: qcom: x1e80100-dell-xps13-9345: mark l12b and l15b always-on
      arm64: dts: qcom: x1e80100-hp-x14: mark l12b and l15b always-on
      arm64: dts: qcom: x1e80100-qcp: mark l12b and l15b always-on
      arm64: dts: qcom: x1e80100-yoga-slim7x: mark l12b and l15b always-on

Judith Mendez (4):
      arm64: dts: ti: k3-am62-main: Set eMMC clock parent to default
      arm64: dts: ti: k3-am62a-main: Set eMMC clock parent to default
      arm64: dts: ti: k3-am62p-j722s-common-main: Set eMMC clock parent to default
      arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0

Juerg Haefliger (1):
      arm64: dts: qcom: x1e80100-hp-omnibook-x14: Enable SMB2360 0 and 1

Karthik Sanagavarapu (1):
      arm64: dts: qcom: sa8775p: Remove cdsp compute-cb@10

Ling Xu (1):
      arm64: dts: qcom: sa8775p: Remove extra entries from the iommus property

Lukasz Czechowski (1):
      arm64: dts: rockchip: fix internal USB hub instability on RK3399 Puma

Niravkumar L Rabara (1):
      arm64: dts: socfpga: agilex5: fix gpio0 address

Pedro Tammela (1):
      net_sched: hfsc: Address reentrant enqueue adding class to eltree twice

Robin Murphy (5):
      perf/arm-cmn: Fix REQ2/SNP2 mixup
      perf/arm-cmn: Initialise cmn->cpu earlier
      perf/arm-cmn: Add CMN S3 ACPI binding
      iommu: Avoid introducing more races
      iommu: Handle yet another race around registration

Sebastian Reichel (1):
      arm64: dts: rockchip: Add missing SFC power-domains to rk3576

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

Yemike Abhilash Chandra (7):
      arm64: dts: ti: k3-am62x: Remove clock-names property from IMX219 overlay
      arm64: dts: ti: k3-am62x: Rename I2C switch to I2C mux in IMX219 overlay
      arm64: dts: ti: k3-am62x: Rename I2C switch to I2C mux in OV5640 overlay
      arm64: dts: ti: k3-am68-sk: Fix regulator hierarchy
      arm64: dts: ti: k3-j721e-sk: Add DT nodes for power regulators
      arm64: dts: ti: k3-j721e-sk: Remove clock-names property from IMX219 overlay
      arm64: dts: ti: k3-j721e-sk: Add requiried voltage supplies for IMX219


