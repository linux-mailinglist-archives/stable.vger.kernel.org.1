Return-Path: <stable+bounces-223487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIuqOIJSrmkMCQIAu9opvQ
	(envelope-from <stable+bounces-223487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 05:54:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 911CB233C07
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 05:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABEBE301E225
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 04:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1992D3727;
	Mon,  9 Mar 2026 04:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K9z7S7p7"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12BC2010EE;
	Mon,  9 Mar 2026 04:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773032044; cv=fail; b=GoOyvjEaFA4tpIZuKAvZoaB8WtOhWYw3BDbFOfXAuLwUVPIfzKRDY+8T+Bi/3KQuLtyZoM3ZnLH6jWv+WwfNMsKpT0Vqfe8XUJyoygoyH3QaFZNU/3TCpoiwBxtHKfmqOvH+6UskVsBPvu90YuNOWLWabJixWQmh/XNw4ELCwGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773032044; c=relaxed/simple;
	bh=No5XHFZG3IctDeXeePjX6woFLFXuBVhK0dSEKB1gprE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SgWQI61HQIdbSMzRb8crDP2u++iGHIpxDAKox2ij9NOyyn6Wj4rZ7rig/nnZ9jBXMsjlPnvbnpl4gvCV/qtPxh05Bf0W7ACyjl5HLCYp8ZJr9fjqr6GQ4pMeLsvGIf+atJ1oBsSfBksrIGXLT2eB0QH3Jrp/PWMJQ0WE9LaJWvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K9z7S7p7; arc=fail smtp.client-ip=52.101.56.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xY1LoqAXRnQ0Cf1HH3K0avvC58lwl+S4zoGwgJuC8C7ay1zG3eFrVLQmgyj8lrlWhWh5Z5OLbT071H06zCm4Ju0bD7Xwq8LQ/aTy/Wej5Vovvmi3kD0FBwuEj+SfwGOTjVZLWgT8Ve08bGS6IXXqJ/7vvWEtJBdbmDQPVU+WKcF4nmnkIrK6Ba90bkeshY4Xz/AjNyTHDHZMk5UGMWbQ2ANOymKnBRmpuyO+A5OirS8AYnScBZKrott1qfVhUGMN7vXwMng5w+U4h6qBXYYQyWI0I7reku8U5x4vh7xOSWrT8BLJqbVfWXS2fFzBmaqECnC1SEiZesrqK1LOyNi/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSi1yTq6L4fwXsdzr9g+PaFvQ4XFZ9/hutjmcWkBAIo=;
 b=J0mN/SffteHzARhFMV33m1Vht4PQQyd/TR+5zbMkC6+yjXVAgYF9yAXcwGdLRzOq4rFLuhmUGUFNNEB8Zo5Wc7GhNUt6obKLWt4yrPePXkphnQAky55axQ6AalfESRqGGCCqUQnkX3s1Gh33lQ160pZ6qbjxdTXg266ZEKskeKXSn6C3v06khnyKLAhU95X0otWaVbfFz8F28KUrJZOkJGL1uvCvYydvbaoSZuVOceIAhIKeBh8K8f42Pe2XP3uCXzqMBMhl0EmOIQcA/T9d1IM8yVNgupJjiLs+71Z40OYnzt5iIiGC8W4knaxi4ylKjLz0ULLK9bD1I/fEFpdoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSi1yTq6L4fwXsdzr9g+PaFvQ4XFZ9/hutjmcWkBAIo=;
 b=K9z7S7p7LQ+X82lMsyCRnTAUGJlpWMqFjVn2w6ivCTvU/yBefYe1DAK9YvW98Vi75OdsrAX20NVIMyVIm3HTrK5v4FionkF3GROafGblXxCxr7UNuF45BTNWSjysaydDsXNHUunHfQu9zKfQFoO7QFI12g89wWjITGcZ6SUxM8c=
Received: from BN9PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:fb::29)
 by IA3PR10MB8090.namprd10.prod.outlook.com (2603:10b6:208:50e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 04:54:00 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::a2) by BN9PR03CA0054.outlook.office365.com
 (2603:10b6:408:fb::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 04:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 04:53:59 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 23:53:52 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 23:53:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 8 Mar 2026 23:53:52 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6294rmTt410971;
	Sun, 8 Mar 2026 23:53:48 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jm@ti.com>, <afd@ti.com>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-am62a7-sk: Fix pin name in comment from M19 to N22
Date: Mon, 9 Mar 2026 10:25:32 +0530
Message-ID: <20260309045539.2070793-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|IA3PR10MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c65619f-0a18-4104-bb9d-08de7d97e07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	no0eww1wAejO//458qEWE8RDkWnQTp4qz0h6dfjxIUx467ti4AZjI5d2p1dAbbcRkVqQ6U5T9b7v5PuHRNUW+Ix4tXGwr4M0b7KjbsXpmqYKFocDHn8dWBPPKIZojzhlhsOifOSwcC1b0XyRNqCVqYA3MovXI6w3td3KBku3FoZz0W07LWyJDtHSCICqtCEZ48z4g2kGjgKswHiI5Hmap3uQqHISCpPzYtC9aQD5eOgiGVvySZ3+MT0TGhEyNAHwx3DwN7tjV0jdIW+uIoVsMVOhhn1qmWIlAYJbLsECNKloPKjoTnNQX9K1qDsbiaBzovEWMIIj3uudliKVSQkZ0bGY3CbXUSX2bNZZR90/+o2koi2eufI6w6zfof6U5JD8j2IlqhGLVz+HCqxofCu5oOzovUQvEr61knX8n0iG5KfeWs4aHCCK2Du0ovGV4E9o+2Qgr1fRvM9faKPsbmkMUC1bL0S+oQ3ZaVorPAovfPAE+LW0B4HsY+H+G5ZZyUoC5tPrXC8I0e8YDKZlQTlfiK97dPPDqotClQTTeLyWuzxJOPGARNucNyFhUv/fN/l49yZDfX1xDxNcns6KvO0eJoXvnK88IiINjlCNTqVBp845uWfg4AEb+n8T5JAOnPFfnsgsdthrV+r2lEdWZ357d84RPVQuOO7YXyDF8lwnIFTPmsHcsJjnWndgrHLaSqTvsx4rDHDaoNth8HGnhFHvmHimbWbF/34frU5LNS10CXM=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LsRCsHpBwTI0LMIqf+J2ibSJKnIgcY0a8Ecju5YZaI+l5q5TYAtuQBJ0jdTk5YPJHwOWDi+pY8J0kgI3omccoD2obk13b1arPcfYFMrI7HYVqLM9nCg/DZn3wIuU3lWuXgm0174ylfI9PWqKS+68iWQ+SBnZl7ig2tLE+J/NSPbQIha+DPPAmOE3/yI29md1c2zi73iUmeFVPkHJG+qyQS96tchSZVkBEOU0hlzpSM+2Do3TMTVQmXYIleJzMVlfhgGpEpkElZa9hTCRJ9D9cobYzLQORE2iEWEVkusucoU+1FqV6qhpaonEbd4Ad9JJ0U5OSiIL/qlt5LIwn28kedDICTFWXnP7ZDEGNSwj0Ql9Mw5oJPru7vmuPMvtIUd58aoMfH7lyBW6cINkcQF3+UBenc4V8Ujfnkai+fziXWdX29J/xVdsT1yo/xAG8NV0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 04:53:59.1902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c65619f-0a18-4104-bb9d-08de7d97e07c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8090
X-Rspamd-Queue-Id: 911CB233C07
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223487-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:dkim,ti.com:email,ti.com:mid];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

The pin for GPMC0_CLK.GPIO0_31 at address 0x000F407C is N22 and not M19.
Hence, fix the pin name in the comment to avoid confusion.

Fixes: 8f023012eb4a ("arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Base-Commit: 1f318b96cc84 Linux 7.0-rc3

v1:
https://lore.kernel.org/r/20260212130843.1054100-1-s-vadapalli@ti.com/
Changes since v1:
- Corrected pin name in comment to N22 instead of updating address to match
  the incorrect pin M19.

 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index e99bdbc2e0cb..b1a6f10adf26 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -398,7 +398,7 @@ AM62AX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C15) UART0_RTSn.GPIO1_23 */
 
 	vddshv_sdio_pins_default: vddshv-sdio-default-pins {
 		pinctrl-single,pins = <
-			AM62AX_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
+			AM62AX_IOPAD(0x07c, PIN_OUTPUT, 7) /* (N22) GPMC0_CLK.GPIO0_31 */
 		>;
 	};
 
-- 
2.51.1


