Return-Path: <stable+bounces-249570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A72OZFQDGrwegUAu9opvQ
	(envelope-from <stable+bounces-249570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:59:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4537357E2EC
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A28FC30479E6
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0883F35201B;
	Tue, 19 May 2026 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g/l7c2yP"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B33F1AC9;
	Tue, 19 May 2026 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191782; cv=fail; b=aPHINrPyrb/U5PWzrtei52d2dbn0zqAvmvCHj44zUp0mKdNaHFnxiCayc8puCD7qA1hX7iejdCdK4U266x7xyTg0jIbKzWpJQkAjauoQ3nFea2U7Km5YHjJepgjQZJnjZ2MvzDXJqsIXfIgt5pop3oWw3p4oO7EyyUy10zv3464=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191782; c=relaxed/simple;
	bh=t7uTeFIEuLjpr/zMCWvh/r30EQrvPmJKKV6+kTDkGow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gdhYgyHOZQQO6tWWaibK+YbBTKSXaOBnCdA2ftGXwfsktECWBxmAWypsqUWxjyGUT2KttzxU29t97EeeeNiu693Cdf4mNwUX/mKX/UJhSe0ypTvSNw3yuouG/+6CLwS4BTUlwx0zhSdPxIGyOx/NZmQhw1nHP7RAiGC2RjO0pbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g/l7c2yP; arc=fail smtp.client-ip=52.101.46.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVRyjc7ybee46wwmdKaktM2SLqrqJTgJb5uYxIT7HFsaOCz1bud7x6WsJf8TcRj9e5BIpGGS57mfiKYXy6Dta65DNLh+k1QwVIUoys92nhO03n4M5MoDOSosEiA1yJnfG3Lw1+s45O+Lw9r6x3Il4h9GiPhi4L3ot6vSHjxUP8G0gbnvHI/bKs2+Et6/CHAY0XmPqpbkHtBMEvNSkrPPwSXLSFZeaMMwhqdUwfErc7XaKpL4cB97Y/M1gskRqOFQ89SSwB0SibCZ1bLvZtz/BrtrGIYte3QZrX18ivzWSfeeOfaALD+dmHSuR1996ZQhbManSsY+C3jXwuFFJdWGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJ8nHN/x2+au6HKocmUFU/jOzsdDqlRaRHUrINPn0Lk=;
 b=IbJOJPE8OJS04vF3GPlJkKr3C5cap2+6bVfwEhgR7tq8SRSOj0CHVbW3Nec4Cv7c68VDG7wFxj6AXxeNgyZHQUe34T1iXS6ETI6DylvgC7L9K5i/GCjqiXAkOkUqE9OBRiKML6MkY3xxnl+8Pi1OD76G47WrO0Ib9hclnMErWyILhAghIXCPbqKPeJ/U/6AySuaVKcgMUMxm1Fw5WcIngQ7ZIRcnmM6/l6rgx9zwDcFthxu08B6pVqYvq+3QkS1moe3FqmEpK68dDp5TIbT8zBAKdEOZ9qj5XAbqCfvq4D+AB95Sl8ZOCNYH2Z7aA2Lysz01uQUF/IgGuv2i0PI8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ8nHN/x2+au6HKocmUFU/jOzsdDqlRaRHUrINPn0Lk=;
 b=g/l7c2yPZVIcnKZPzYq7huKssYgvQn0yEuF2gsaiYybabaVf5bZDxs7zMkHtdcWbkH8EwKpk+Pe4pRD/TXdgk/huFjxR9IylDhEo0ktJrG2Tu9kuRq9vEALJnEYFq27P0ifmzPyGJKeHMgAymruAxJY27yHuiBj9J9W+Icb+TLs=
Received: from SJ0PR13CA0217.namprd13.prod.outlook.com (2603:10b6:a03:2c1::12)
 by MN0PR12MB6030.namprd12.prod.outlook.com (2603:10b6:208:3ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 11:56:15 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::3) by SJ0PR13CA0217.outlook.office365.com
 (2603:10b6:a03:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 11:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 11:56:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 06:56:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 04:56:13 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 06:56:10 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
	<michal.simek@amd.com>
CC: <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2] usb: dwc3: xilinx: fix error handling in zynqmp init error paths
Date: Tue, 19 May 2026 17:25:29 +0530
Message-ID: <20260519115529.2980421-1-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|MN0PR12MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 690180ba-8a82-40b7-70a9-08deb59da11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|11063799006|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sMkjxdDAE6IcoNG3TWDWt5CFcTPGakTfr8zbEFrkMQKWriqnijp0qyIO7IRga0zRA4vditF4wzNigSQrYmmCsn+Tofnba2H6zXln61IncIOYdiRbMeno4foI5HmNynkbOpnClqU5xRt5qejdQzgB9FTH2M099e1LZxoD3iau8NQcA2rekHoeTXyRJ91pK7ISMWMAJdNxCtXA3JglnHupYWyJw2LkpQVJRxsY1cPEeGR7vUM0PpMFvzYBLTHn2RSCEaajQ/5Zojf7baAQGvnz5viZzlL9KFL4aq4zNZausJRoXYXO36bFrkIGKY8S5my0KJ0R+Wr7UB4/KqNSVnkZOH/7nxOCCcZJnTH2mYOxBdpL9Xq2LtUWaISu2XEDQafIhzNp+szK+Ty7brapDzkGoKtqxq/PUIg7Nv+Ilf9C8TVpDSo5AKa257cGdB7zdP4WFnkRDnxLUOwMVpfvhff2rUpHJN1KeUCvtT3h77HCOMNzuNQ65nypkniwZ5joFDVjCSuiI71VOi7OHifefzkBisDJgHYnItbouMmaQ92i5CjzFAZc0Ba8NbyOI6+e8Ec1Nons5Rh6CIA8zUBxcpbxj4ueZkWkCXtenbPzpyeSF6ILl4EXSvfEOJyese8IINvnLl/eRECG3G+luAOXMioB9Wqs2ysiBJVcXJjZq2CDxE4Nn8P5pJN5xm2CAPcHRaKGHLeP0NcEKubNjzbFxlZxskctV3z6gKSUlE9y5jp3LBc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uE7VQ6S2FMMGz0d4urouZn9lelQoV6VCIC2gRUtyfLV6W2fwg5oV3It2/0EnJSRsYlcfwN344ASrXeFhsptfDwrlheI4P5Rtrd8q2LVuUfdqRbl046+1OfhykvhXGtle9X9peEz1gihx9D4a6LA/ePUfPJzZi6c7n3PBEEw1ZXOXsbz9P5KjmYRAOmqiuaXIf487oJpEQb44KC+/uIsohSfmG1CjefbL76rJhw5tBGYMg+PE9+cnu1rIOZo7uPILKj5yLnk2G6bBHIJybFnLjave5/eOsuxhuIRWRo1uSMYxn3L1/ZNcj+p7hhnwy0UjxzVOzUnqCgorp1alOOqc3pABQb1ZW7IMlLIp1jYmpKgSJPI/j0f5+/kFXvYNla/OluyXQDn7K0l/lisDJg7L757Ot9Q3OU5HfAyxxux4K8NEmwG4Po6jTLOw1/C8fJY5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 11:56:15.0033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 690180ba-8a82-40b7-70a9-08deb59da11d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6030
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249570-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radhey.shyam.pandey@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,amd.com:mid,amd.com:dkim];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4537357E2EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix error handling and resource cleanup i.e remove invalid
phy_exit() after failed phy_init(), route failures through
proper cleanup paths and return 0 explicitly on success.

Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
Cc: stable@vger.kernel.org
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v2:
- Split this functional fix into a separate patch.
- Add Thinh Nguyen acked-by tag.

Link to v1:
https://lore.kernel.org/all/20260511160814.2904882-4-radhey.shyam.pandey@amd.com
---
 drivers/usb/dwc3/dwc3-xilinx.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index f41b0da5e89d..9b9525592a85 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -184,15 +184,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 	ret = phy_init(priv_data->usb3_phy);
-	if (ret < 0) {
-		phy_exit(priv_data->usb3_phy);
+	if (ret < 0)
 		goto err;
-	}
 
 	ret = reset_control_deassert(apbrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release APB reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	if (priv_data->usb3_phy) {
@@ -208,26 +206,24 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	ret = reset_control_deassert(crst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release core reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	ret = reset_control_deassert(hibrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release hibernation reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	ret = phy_power_on(priv_data->usb3_phy);
-	if (ret < 0) {
-		phy_exit(priv_data->usb3_phy);
-		goto err;
-	}
+	if (ret < 0)
+		goto err_phy_exit;
 
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio)) {
-		return dev_err_probe(dev, PTR_ERR(reset_gpio),
-				     "Failed to request reset GPIO\n");
+		ret = PTR_ERR(reset_gpio);
+		goto err_phy_power_off;
 	}
 
 	if (reset_gpio) {
@@ -237,6 +233,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 	dwc3_xlnx_set_coherency(priv_data, XLNX_USB_TRAFFIC_ROUTE_CONFIG);
+
+	return 0;
+
+err_phy_power_off:
+	phy_power_off(priv_data->usb3_phy);
+err_phy_exit:
+	phy_exit(priv_data->usb3_phy);
 err:
 	return ret;
 }

base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
-- 
2.43.0


