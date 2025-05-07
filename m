Return-Path: <stable+bounces-141974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0964AAAD822
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E16F3BE929
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 07:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668E6219312;
	Wed,  7 May 2025 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="e/my3sV9"
X-Original-To: stable@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1901215772;
	Wed,  7 May 2025 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602884; cv=none; b=BIKF1bF2YGAVluyjyaBuGk1gLta2wXxuXA+J7iZFUG/y8lf4ASi7IRH05fWB8OxK2R9VKoaCIWf7jxdHqg3dejcqWLBV89GMT8cuU1hzDawjEwhCGUciakc6dpi0H4jkQI34yDXkr9QOTBUrOLfKn7O4lRFYUA9HtapeopH4luo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602884; c=relaxed/simple;
	bh=/fS75YgNQqufVubGOZNHO5Z+UxgbbZ3y2istb9E1Mj8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=DYeorxdq9Rj5pcWEWIYfq7Pvs1VVutGuneN8awt3JqJ+K+yDOLJOA63Uk859ujdS8eOt/c1fAVhtRvOPkGmdKDvaY1d8dE3djJE4cTdwkbYHX1h8gvH7KLFthvjjSPa508eG3Qms7CKS5b8ce9+2wAzWMgQCIeU4cdpmYIENI68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=e/my3sV9; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54779UN1021799;
	Wed, 7 May 2025 09:27:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=iQxRiNu03TITYfxYaE1KEL
	g0ZyDlorP8jtI9q1o4F6c=; b=e/my3sV93bdOMqA87zdXgDZozgW27q51n3s91T
	PyFonW6LZchI4REOiGzdUslND+smkmX+NTuAeZMTcCDZ3oqUZsC/qwaclxOyNaEx
	lQNFTq9BbmDv7gKgwNuOSHGPuYGG2duTt3jGUZySYiMDjV49/7ebwevEOgLSWe3E
	e8IIP0D9FGiM+cxY1vjG1M5gwunPTFyK9N1mPoGdT5zgRq9VBZ6NoruYDaR90xhT
	GwRc3l1rGtA/83hV8AqEWCI8STYimMCTpuf6coxmSs/QRo/viy92cf+IKzDwB/ly
	Dwgrf9OD+6zA9ddLQ2n6hyapdTnJY0fWeJTWbG4gzGFSPSXQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46dx3mct86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 09:27:47 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2EC284005C;
	Wed,  7 May 2025 09:26:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 56C46ACB658;
	Wed,  7 May 2025 09:25:16 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 09:25:16 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v13 0/4] Add STM32MP25 SPI NOR support
Date: Wed, 7 May 2025 09:25:13 +0200
Message-ID: <20250507-upstream_ospi_v6-v13-0-32290b21419a@foss.st.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANoKG2gC/23Qy2rDQAwF0F8Js66DpHm6q/5HKWGezSwSG49rW
 oL/vZNAiYsHtLkXdAS6sRKnHAt7PdzYFJdc8nCtAfnLgfmzvX7GLodaMAKSwAm6r7HMU7SX01D
 GfFpUFwQna1ATgmR1bZxiyt8P8/2j5nMu8zD9PE4s6t7+YbjH6kDHtXPeOsEF79/SUMqxzEc/X
 NidW/STENAidCUgJjISeQwG94TZErpBmEpopzUqjx6T2hP9hsDGV5a+Ej4h9hKMEcbuCYSNQdQ
 wKgydSqIXZEFEhAaCW8S0EKwISmE0Vyn0gRoIPREJqoVQRSJ3TloI2iT3H1nX9RcEAV7wSwIAA
 A==
X-Change-ID: 20250320-upstream_ospi_v6-d432a8172105
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
CC: <christophe.kerello@foss.st.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Patrice Chotard
	<patrice.chotard@foss.st.com>,
        <stable@vger.kernel.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_02,2025-05-06_01,2025-02-21_01

This series adds SPI NOR support for STM32MP25 SoCs from STMicroelectronics.

On STM32MP25 SoCs family, an Octo Memory Manager block manages the muxing,
the memory area split, the chip select override and the time constraint
between its 2 Octo SPI children.

Due to these depedencies, this series adds support for:
  - Octo Memory Manager driver.
  - Octo SPI driver.
  - yaml schema for Octo Memory Manager and Octo SPI drivers.

The device tree files adds Octo Memory Manager and its 2 associated Octo
SPI chidren in stm32mp251.dtsi and adds SPI NOR support in stm32mp257f-ev1
board.
    
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Changes in v13:
- Make firewall prototypes always exposed.
- Restore STM32_OMM Kconfig dependency from v11.
- Link to v12: https://lore.kernel.org/r/20250506-upstream_ospi_v6-v12-0-e3bb5a0d78fb@foss.st.com

Changes in v12:
- Update Kconfig dependencies.
- Link to v11: https://lore.kernel.org/r/20250428-upstream_ospi_v6-v11-0-1548736fd9d2@foss.st.com

Changes in v11:
  - Add stm32_omm_toggle_child_clock(dev, false) in stm32_omm_disable_child() in case of error.
  - Check MUXEN bit in stm32_omm_probe() to check if child clock must be disabled.
  - Add dev_err_probe() in stm32_omm_probe().
  - Link to v10: https://lore.kernel.org/r/20250422-upstream_ospi_v6-v10-0-6f4942a04e10@foss.st.com

Changes in v10:
  - Add of_node_put() in stm32_omm_set_amcr().
  - Link to v9: https://lore.kernel.org/r/20250410-upstream_ospi_v6-v9-0-cf119508848a@foss.st.com

Changes in v9:
  - split patchset by susbsystem, current one include only OMM related
    patches.
  - Update SPDX Identifiers to "GPL-2.0-only".
  - Add of_node_put)() instm32_omm_set_amcr().
  - Rework error path in stm32_omm_toggle_child_clock().
  - Make usage of reset_control_acquire/release() in stm32_omm_disable_child()
    and move reset_control_get in probe().
  - Rename error label in stm32_omm_configure().
  - Remove child compatible check in stm32_omm_probe().
  - Make usage of devm_of_platform_populate().
  - Link to v8: https://lore.kernel.org/r/20250407-upstream_ospi_v6-v8-0-7b7716c1c1f6@foss.st.com

Changes in v8:
  - update OMM's dt-bindings:
    - Remove minItems for clocks and resets properties.
    - Fix st,syscfg-amcr items declaration.
    - move power-domains property before vendor specific properties.
  - Update compatible check wrongly introduced during internal tests in
    stm32_omm.c.
  - Move ommanager's node outside bus@42080000's node in stm32mp251.dtsi.
  - Link to v7: https://lore.kernel.org/r/20250401-upstream_ospi_v6-v7-0-0ef28513ed81@foss.st.com

Changes in v7:
  - update OMM's dt-bindings by updating :
    - clock-names and reset-names properties.
    - spi unit-address node.
    - example.
  - update stm32mp251.dtsi to match with OMM's bindings update.
  - update stm32mp257f-ev1.dts to match with OMM's bindings update.
  - Link to v6: https://lore.kernel.org/r/20250321-upstream_ospi_v6-v6-0-37bbcab43439@foss.st.com

Changes in v6:
  - Update MAINTAINERS file.
  - Remove previous patch 1/8 and 2/8, merged by Mark Brown in spi git tree.
  - Fix Signed-off-by order for patch 3.
  - OMM driver:
    - Add dev_err_probe() in error path.
    - Rename stm32_omm_enable_child_clock() to stm32_omm_toggle_child_clock().
    - Reorder initialised/non-initialized variable in stm32_omm_configure()
          and stm32_omm_probe().
    - Move pm_runtime_disable() calls from stm32_omm_configure() to
      stm32_omm_probe().
    - Update children's clocks and reset management.
    - Use of_platform_populate() to probe children.
    - Add missing pm_runtime_disable().
    - Remove useless stm32_omm_check_access's first parameter.
  - Update OMM's dt-bindings by adding OSPI's clocks and resets.
  - Update stm32mp251.dtsi by adding OSPI's clock and reset in OMM's node.

Changes in v5:
  - Add Reviewed-by Krzysztof Kozlowski for patch 1 and 3.

Changes in v4:
  - Add default value requested by Krzysztof for st,omm-req2ack-ns,
    st,omm-cssel-ovr and st,omm-mux properties in st,stm32mp25-omm.yaml
  - Remove constraint in free form test for st,omm-mux property.
  - Fix drivers/memory/Kconfig by replacing TEST_COMPILE_ by COMPILE_TEST.
  - Fix SPDX-License-Identifier for stm32-omm.c.
  - Fix Kernel test robot by fixing dev_err() format in stm32-omm.c.
  - Add missing pm_runtime_disable() in the error handling path in
    stm32-omm.c.
  - Replace an int by an unsigned int in stm32-omm.c
  - Remove uneeded "," after terminator in stm32-omm.c.
  - Update cover letter description to explain dependecies between
Octo Memory Manager and its 2 Octo SPI children.

Changes in v3:
  - Squash defconfig patches 8 and 9.
  - Update STM32 Octo Memory Manager controller bindings.
  - Rename st,stm32-omm.yaml to st,stm32mp25-omm.yaml.
  - Update STM32 OSPI controller bindings.
  - Reorder DT properties in .dtsi and .dts files.
  - Replace devm_reset_control_get_optional() by
    devm_reset_control_get_optional_exclusive() in stm32_omm.c.
  - Reintroduce region-memory-names management in stm32_omm.c.
  - Rename stm32_ospi_tx_poll() and stm32_ospi_tx() to respectively to
    stm32_ospi_poll() and stm32_ospi_xfer() in spi-stm32-ospi.c.
  - Set SPI_CONTROLLER_HALF_DUPLEX in controller flags in spi-stm32-ospi.c.

Changes in v2:
  - Move STM32 Octo Memory Manager controller driver and bindings from
    misc to memory-controllers.
  - Update STM32 OSPI controller bindings.
  - Update STM32 Octo Memory Manager controller bindings.
  - Update STM32 Octo Memory Manager driver to match bindings update.
  - Update DT to match bindings update.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (4):
      firewall: Always expose firewall prototype
      dt-bindings: memory-controllers: Add STM32 Octo Memory Manager controller
      memory: Add STM32 Octo Memory Manager driver
      MAINTAINERS: add entry for STM32 OCTO MEMORY MANAGER driver

 .../memory-controllers/st,stm32mp25-omm.yaml       | 226 ++++++++++
 MAINTAINERS                                        |   6 +
 drivers/memory/Kconfig                             |  17 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/stm32_omm.c                         | 476 +++++++++++++++++++++
 include/linux/bus/stm32_firewall_device.h          |  10 +-
 6 files changed, 735 insertions(+), 1 deletion(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250320-upstream_ospi_v6-d432a8172105

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


