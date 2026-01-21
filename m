Return-Path: <stable+bounces-210690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDEoGyVocGkVXwAAu9opvQ
	(envelope-from <stable+bounces-210690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:46:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDFE51AB2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ABC994A4008
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273F7429835;
	Wed, 21 Jan 2026 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iIBDqRWC"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060C9425CCE;
	Wed, 21 Jan 2026 05:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974296; cv=fail; b=RCM7Ff5v/Enlb66o1xxPjjNkkk58RBLJ5yFz70kz9wippnUD2hfbv0yDEIK8e8TEDEwYnR+2dyvdZBr+7hKOo9iEQMJRmT2zeE3sUDD15zehC+0+hRc7u+rWO9gsf5J7G3ybiEcBYBieKXxGIXth3iRTQrpYJ1GpTd1zLHva6vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974296; c=relaxed/simple;
	bh=bco/h2FvogNC2nRT+E1RufPPpSSuacJ7Q/KYzHJr02E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RcY0waxo1dPIbqsOMNhSfP7Lgn63r72IMI5UGdyp4WLOsNauJ9x7i+21J9nz4Tz/BIgZiA9AqUwfQBLu/16lr2UPLGrQwb6Q3J2/CmtvXQjQIKhMQwZEWg1n4/9wFMufWu9OwLoyIdl8OY4QrQwSlxwWTkLLwXCJzfUhumkFylA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iIBDqRWC; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSngYZAw3XmXRQ//HLVf4iGkwaEPqUtoKWZmbzwGX2pejxcs8P6JDsNCyeV2Ue60gr40aMc+MN1h+7tVjqGoi3NvcIkK1C845pdMk6Uo067MhO/y9a2sCZagC3UgT/gyGvFyax57fjQXXViYa9yOC6KFSJYAsc7nsfgh3lTkZe73AhEehCaTYyi5gsi9jYifqG47XY3zh8OlTVUWz6UPeifDw3qk+lyrCnfk7SAJE8tBBMf+1IVjEB2BzPrn9tPRla4YA2g0FoakAHmGJNHHJwrwLB2XerPy+tJfr7ENQaJC8QVOTzTWdo1o2t1FJ+6Te00BhQx8963837v9Zs/p+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dQIm0BHOTGHpR6soWJLiPDn99WTp8i9bUIveaQNyTY=;
 b=PNiaZ2/sUvTFMUF0NceHAySHZLEyvQkNJDy13EfqYda6YRHAeuyUO/L2tZ7dJi5G617dJR6PtI1g1fttEQKEU9QX2zqirbB0ZVAtuWwzafQMHCd3CLjU2eavUu5358vRRg2iye+j6pan+37BHJ/tW2gK80PQJyh1Tmnk5YmJ1URBh1O6IJTKkCmWBBBVTRL4OHSRo4wqAtdwZJCUKNLW+RMCDSfwd9rlh/QbrD+fV6c6mqwJ0Zwqids8k1hkdJTMWEUyAiQNGPuEpxV/ZjBTg/X00gYv3thcAl4lOv7efHGNqo2y4cq52De3OB1U+qkcTn/US/4fdYCtQSK2wOfdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dQIm0BHOTGHpR6soWJLiPDn99WTp8i9bUIveaQNyTY=;
 b=iIBDqRWCXJZ1xR56C8rHY5Bui+OhaLW/lCa/Lwz5UFNQHwgvSZnioD1hBnowRx8M+BJIB/GFWy4wk/PRYdW96L133MGbsdZ1li5ulWoT7eIpuuwy9GPVK9xMtXl4Kw03dS5PVW1Smza2SC99KwtcWSPEGXZaidYkF1YeyWk6/SM=
Received: from BY5PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:1e0::36)
 by DM3PPF5F5663669.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Wed, 21 Jan
 2026 05:44:41 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::c) by BY5PR03CA0026.outlook.office365.com
 (2603:10b6:a03:1e0::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.13 via Frontend Transport; Wed,
 21 Jan 2026 05:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 05:44:39 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:44:39 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:44:37 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 23:44:37 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60L5iWqa2323641;
	Tue, 20 Jan 2026 23:44:32 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <bb@ti.com>, <afd@ti.com>,
	<p-bhagat@ti.com>, <gehariprasath@ti.com>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-am62d2-evm: Fix missing RX delay for DP83867 PHY
Date: Wed, 21 Jan 2026 11:15:50 +0530
Message-ID: <20260121054552.1650926-1-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DM3PPF5F5663669:EE_
X-MS-Office365-Filtering-Correlation-Id: 28720447-32ae-4ba6-0590-08de58b02b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TlAvRiX0lptlugi+h1KCCirT33bXt8zPrQDJkHPHVEVaeMIfXNcu1W8NqJ73?=
 =?us-ascii?Q?x/MVdWzGtI7XrjVbDNvytg8NRmGARhbwd7FculDk+DurMkC6mI6x83bPvk7a?=
 =?us-ascii?Q?vcCPUFhKFeD/eov/ysl6Fs25oaXJeIYy1yy3GLASwm8Cy/+mMCJRNBoh4Tt1?=
 =?us-ascii?Q?3GeQeYeSlihFFVPkt232Bo7SdVh9wR8TH689rCPEuR78vTZXGRTE68UlA7OT?=
 =?us-ascii?Q?KQgmFAWY8fXZuXiIfDB/M++csF6jx1N7C8PS8f1tznIVzHwgZqXyUasEYsU4?=
 =?us-ascii?Q?mB3RjeHrR1BE91oviSVbSwJ6FNNAGisERniLGLJ8s0L14TB0Bbn9M/v1sqcQ?=
 =?us-ascii?Q?YHDyzvVUnuJ04xnZUeVzE6SteM4rtlKxFUPGOHPOXxDHKTpcEGdsU7BLDvLz?=
 =?us-ascii?Q?/pZXuQaSAhYalyLpbkUwMZVFy+QEUByWQEY/YfiI4Idf3cCChjwx/7hsC1GN?=
 =?us-ascii?Q?204Aa1yvE9sOgFc9JLbFMrL0JMH8Iwk8ege9kMGY4j1napeKzgNjmzq586MF?=
 =?us-ascii?Q?JEhOM1VqouCEgZeFIN4J6dW1SFqsApdquxZ6TUr+1HVrp9vFJif17FoTDXH+?=
 =?us-ascii?Q?Wy53TScBGpZ+ohH8w0rpjCExq3LFbMqzgREam/f0lwoO7gAz4hd6lqUqvPAd?=
 =?us-ascii?Q?oB74VVYrdClbK2h0/lBxcse0bv3oNhBya2uREOBNYY4QRb/bq0AUlkUDyXdJ?=
 =?us-ascii?Q?NPvkjdUFMhCuBkLhdaq6pqEYIoGQkKKcCqUbFJbN/pRwi8piJa7ROz4tioy2?=
 =?us-ascii?Q?WpkaJxJSDyE3hl4oLfz0GHv/Z8A2nVUJ2PJBpe9z6zlByoboh4bG4wvDeAu1?=
 =?us-ascii?Q?OPOFkiVIcbTfU9PyGoCKQZYFXNlH8DCUB0Uf6+cV5gYak8qnYIGMp+B+PsoB?=
 =?us-ascii?Q?P8MkIrlAwODUDIjPkAy6uaRQt6X+xm39GHFs5Jq08/2yaCh3azhmyp3VjXMe?=
 =?us-ascii?Q?EGawoV0ay5BK/MMVPYQw/ExI99xLk9x/MKZbV2Z2xNLXJkETcfRKUNThGgxN?=
 =?us-ascii?Q?2Lg61h7c7JHL14+D6N7D1dbao4WwX7d5G78AjyZENTif+OIej+0aUTGYLz/T?=
 =?us-ascii?Q?PQ7gVHqGmPjeE8wgJGtIPO5detvC9Og5NjkDGz1q5+4tRlYMZ2SxmWPG9BdA?=
 =?us-ascii?Q?Zk0Rrok1a9DYrFaUQoYlqB+H3+1kwC7Tcccqwqq54HmPxNV8p05oAc5gyORW?=
 =?us-ascii?Q?3QOB33VZbMi3elp7ssxgBC5tUarcMc3HSrctDWGuXZc6YiR4cNMXcm1wEoQl?=
 =?us-ascii?Q?njLeEE76E0cch3ME/qnayJdlDCHTi8y+ScfFcKVZ3eTXu117OJ6CdlEliwQ+?=
 =?us-ascii?Q?w6Tz/Qbt6YvDKlYVQYxCe/3QEvHBQ7Lc3xUTxoYy8I3A/Hfh3UiGZmXqvErE?=
 =?us-ascii?Q?wzu+hrJzdM7NZ2qZ1vTS07jAUr6HXJRKaD9SYSirxBg3kps9txFMzd6jn46M?=
 =?us-ascii?Q?Tc5NE/lcgIoDpms5FkWJCaEQeBSagCT7HZYBmbO0kEkcJp4j9BWXC2Z7plCs?=
 =?us-ascii?Q?80i3xWGTBmq+yMpA1nzxuK/Yxo/I0VCp8IjYh/+gw2ZGpTX57uz8ijTF71Gx?=
 =?us-ascii?Q?ii7gd+HlqdKDP6xTkDpzgAWUv6y62p45ybbz4sW6fOSCCSBhW8cb/BDPzCBn?=
 =?us-ascii?Q?iwDXqZ+GcXWN2M3JxjZsZz1HzSAWrJj0Mi+44tX5c+0pVr6ttdDRcuXsYcbB?=
 =?us-ascii?Q?NFWJ+M7+z82b1C6bVikvEameh9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 05:44:39.5564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28720447-32ae-4ba6-0590-08de58b02b49
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5F5663669
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210690-lists,stable=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,0.0.0.3:email,ti.com:email,ti.com:dkim,ti.com:mid];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0CDFE51AB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MAC Ports 1 and 2 of the CPSW3G Ethernet Switch in the AM62D2 SoC are both
connected to different instances of the DP83867 Ethernet PHY on the AM62D2
EVM, with the 'phy-mode' set to 'rgmii-id'. The DP83867 Ethernet PHY has to
add a 2 nanosecond delay on receive (from wire) based on the EVM design.

Since the device driver for the DP83867 Ethernet PHY coincidentally assumes
that a 2 nanosecond receive delay has to be added in the absence of the
'ti,rx-internal-delay' property, Ethernet is functional.

However, since the device-tree is intended to describe the Hardware, and,
the device driver for the DP83867 Ethernet PHY may change in the future,
add the 'ti,rx-internal-delay' property and assign it the value
'DP83867_RGMIIDCTL_2_00_NS' which corresponds to a 2 nanosecond
delay.

Fixes: 1544bca2f188 ("arm64: dts: ti: Add support for AM62D2-EVM")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Hari Prasath Gujulan Elango <gehariprasath@ti.com>
---

Hello,

v1 of this patch is at:
https://lore.kernel.org/r/20260120061335.1497832-1-s-vadapalli@ti.com/
Changes since v1:
- Fixed typo in the commit message based on the feedback at:
  https://lore.kernel.org/r/6650770b-2e9c-4f9a-8310-1f335ffa69f8@ti.com/
- Collected Reviewed-by tag from
  Hari Prasath Gujulan Elango <gehariprasath@ti.com>
  https://lore.kernel.org/r/6650770b-2e9c-4f9a-8310-1f335ffa69f8@ti.com/

Patch is based on commit
6c790212c588 Merge tag 'devicetree-fixes-for-6.19-3' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
of Mainline Linux.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
index 2b233bc0323d..17c64af4f97b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
@@ -649,12 +649,14 @@ &cpsw3g_mdio {
 
 	cpsw3g_phy0: ethernet-phy@0 {
 		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 		ti,min-output-impedance;
 	};
 
 	cpsw3g_phy1: ethernet-phy@3 {
 		reg = <3>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 		ti,min-output-impedance;
 	};
-- 
2.51.1


