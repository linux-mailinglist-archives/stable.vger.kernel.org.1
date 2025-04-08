Return-Path: <stable+bounces-128928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE458A7FC3B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2DD87A67C5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06315267393;
	Tue,  8 Apr 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="drNdrQ66"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B02676E6;
	Tue,  8 Apr 2025 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108585; cv=none; b=TWq3nE9Y4mgp+x69st8t0VL5/c0aZoB+AGGZ0tpNvXOQ6/n5g8z5JKa2eJXfFoDLf0wDV3PdBc4ZQ8UgvhhR8d/CMsSDWQpmuEz6RG6cP0OgwfEV/hBwnW1zXnMbe2DBam+uJSmKxu2RmxQvL3R43GnZit71CuUDsJnj5ltxYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108585; c=relaxed/simple;
	bh=qPyi2s7HmZ5EXbVFvDklSrFrMIdZqxq/ExK1qhNSZq0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c14ieHM1ozXLKjMe0Tue+/S5Dpsq3B/SedAqeOOiBOkQWxml+/khrI4LR7cTtJ8JxdS0TTRzkGRDaJFGLGv2A/frCw+knF68Gb9BjxM8OXjr7suqVIqgF6HxZI2A9SzyFZp/xMtN85yDI0dRw3mDzwvK4bLGdQdb4VIviFV4foQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=drNdrQ66; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 538AaBmk1150072
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 05:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744108571;
	bh=y4i93wF9m6/Pka4RzDhnFmGJ1Adb5uJ6IEyLecKy9PE=;
	h=From:To:CC:Subject:Date;
	b=drNdrQ66X9B5u24i0vnfT1PBKEeGh67zXRLujTj6JftMtLn/dj7SSIsylETYvGVxx
	 rcDXnmU2F/5mjtySlmuTyjaZ/3cjw1baVkCyHpo2T8kkU4iE3V16pbztSdkyHq+jlD
	 geHSZKCxLH4GRZ2/xvOK6Lv+rSaPlU6V/mqOC+4k=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 538AaBkg028449
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 8 Apr 2025 05:36:11 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Apr 2025 05:36:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Apr 2025 05:36:11 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 538Aa6T7016171;
	Tue, 8 Apr 2025 05:36:07 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 0/2] J722S: Disable WIZ0 and WIZ1 in SoC file
Date: Tue, 8 Apr 2025 16:06:04 +0530
Message-ID: <20250408103606.3679505-1-s-vadapalli@ti.com>
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

Series is based on linux-next tagged next-20250408.

v1 of this series is at:
https://lore.kernel.org/r/20250408060636.3413856-1-s-vadapalli@ti.com/
Changes since v1:
- Added "Fixes" tag and updated commit message accordingly.

Regards,
Siddharth.

Siddharth Vadapalli (2):
  arm64: dts: ti: k3-j722s-evm: Enable "serdes_wiz0" and "serdes_wiz1"
  arm64: dts: ti: k3-j722s-main: Disable "serdes_wiz0" and "serdes_wiz1"

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts   | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 4 ++++
 2 files changed, 12 insertions(+)

-- 
2.34.1


