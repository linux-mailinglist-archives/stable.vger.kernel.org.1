Return-Path: <stable+bounces-133086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3E1A91C49
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5443BDD59
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5B9288D6;
	Thu, 17 Apr 2025 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JnKSTnWw"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABCF1C27;
	Thu, 17 Apr 2025 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893179; cv=none; b=aRvsYrpudPSDSMvDzLjdwAXt+tfXV5UFI6owMABSMp2WVeltcNu03Q+u9seRDuoOpk7btAErhLP0lmFQUN2MNNz1pDZk8WgoTysZyqfg4pjHQQCysw3GieuipBiMLG36cWFgnqKMsk2R8wAM54/QWSS+LfKJpe4RX7nzxR+2/Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893179; c=relaxed/simple;
	bh=Ii05zIHwE5PtGR8fmg0C/JKjvqQ+oPVsnJtjyK1EOF0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kKWQgYXC+vVmYzi7k5sEnXa4bkFYZDQmkubrq/5xGGzAILL6og3ZWYboBGGKTCtHbMGEAluLEqucmitgbN7tM97KI2+lToCisPODV+nAJjEZLyOK310VS8v1ud7bx87rLdWks+9UHCDLxq7djUUKIPYS4/SW9LRD8aUq9P7KigE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JnKSTnWw; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53HCWpHk691161
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 07:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744893171;
	bh=gY5xaGXP02UKsHjzScQaLSQMWROzx3JrkxRyvWtZiEs=;
	h=From:To:CC:Subject:Date;
	b=JnKSTnWwK0T9zGwACqEuTOILuB3S4ncoJzRY/fXZPi9hyQhzxw9XLS1ySEgHMo2XB
	 uXwhjC/xqtsbo5nRBhcOAXT8G2scPtdJ+4E+9+9Z+GJ5pA4KHMvFoITIl2wCLbcwXh
	 0JLp4ipU6RmLDfyPbTe7fF2VWT0tUMq1d43PADwo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53HCWphO094055
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Apr 2025 07:32:51 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 07:32:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 07:32:51 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53HCWkMO038275;
	Thu, 17 Apr 2025 07:32:47 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rogerq@kernel.org>,
        <u-kumar1@ti.com>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 0/4] J722S: Disable WIZ0 and WIZ1 in SoC file
Date: Thu, 17 Apr 2025 18:02:42 +0530
Message-ID: <20250417123246.2733923-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello,

This series disables the "serdes_wiz0" and "serdes_wiz1" device-tree
nodes in the J722S SoC file and enables them in the board files where
they are required along with "serdes0" and "serdes1". There are two
reasons behind this change:
1. To follow the existing convention of disabling nodes in the SoC file
   and enabling them in the board file as required.
2. To address situations where a board file hasn't explicitly disabled
   "serdes_wiz0" and "serdes_wiz1" (example: am67a-beagley-ai.dts)
   as a result of which booting the board displays the following errors:
     wiz bus@f0000:phy@f000000: probe with driver wiz failed with error -12
     ...
     wiz bus@f0000:phy@f010000: probe with driver wiz failed with error -12

Additionally, another series for DT cleanup at:
https://lore.kernel.org/r/20250412052712.927626-1-s-vadapalli@ti.com/
has been squashed into this series as patches 3 and 4.
This has been done based on Nishanth's suggestion at:
https://lore.kernel.org/r/20250414143916.zhskssezbffmvnsz@dragonfly/

Series is based on linux-next tagged next-20250417.
NOTE: For patches 1 and 2 of this series which are "Fixes", it has also
been verified that this series applies to the following commit
cfb2e2c57aef Merge tag 'mm-hotfixes-stable-2025-04-16-19-59' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
of Mainline Linux.

v2 of this series is at:
https://lore.kernel.org/r/20250408103606.3679505-1-s-vadapalli@ti.com/
Changes since v2:
- Collected Reviewed-by tags from Udit Kumar <u-kumar1@ti.com>.
- Squashed the DT cleanup series at:
  https://lore.kernel.org/r/20250412052712.927626-1-s-vadapalli@ti.com/
  as patches 3 and 4 of this series.

v1 of this series is at:
https://lore.kernel.org/r/20250408060636.3413856-1-s-vadapalli@ti.com/
Changes since v1:
- Added "Fixes" tag and updated commit message accordingly.

Regards,
Siddharth.

Siddharth Vadapalli (4):
  arm64: dts: ti: k3-j722s-evm: Enable "serdes_wiz0" and "serdes_wiz1"
  arm64: dts: ti: k3-j722s-main: Disable "serdes_wiz0" and "serdes_wiz1"
  arm64: dts: ti: k3-j722s-main: don't disable serdes0 and serdes1
  arm64: dts: ti: k3-j722s-evm: drop redundant status within
    serdes0/serdes1

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts   | 10 ++++++++--
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi |  8 ++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.34.1


