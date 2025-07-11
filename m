Return-Path: <stable+bounces-161645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59617B01B5F
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 14:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08817545E10
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 12:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB8928E5F3;
	Fri, 11 Jul 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="aUaSRnYI"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013018.outbound.protection.outlook.com [40.107.159.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2A28E594;
	Fri, 11 Jul 2025 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235310; cv=fail; b=BAkIhKAuUPP6yZiMa9PCkmSTUdHzjbVSTpufcUJBom1z/vxOCiKKhWcVeKi10Mlyy1/4EbxTlE5Had/myKJmarjVVxacurp9QmAy2PewxghTfNxLW4U9UNYzfAaJYwDCw8GnaQaTlero9eqfsou/KqZ/3xZhnCuMstzsrUASmEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235310; c=relaxed/simple;
	bh=OBXjXet0pk45ayYnaEOv+b31hMSw0kD6NoUVt3P325I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkT/F6gs0k56nNSvEu7FDfTfII4po+bjM5M+xkzzLqItKDPHuuwfP3WnmeDBKUkmNDEnqP01hr+FFVBH78cdzNKUA002LlK9yrv2YFiD8vKm9ufPY4nqNC1IxAolNfq30RhW5jyjnCoTxN2yCrG5qEhrzmXOOUcNrIMpjwTsk9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=aUaSRnYI; arc=fail smtp.client-ip=40.107.159.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAw0AZ+llqaz+hcvke8PxKrOYq/Y8suEOscPTAIZvCwxrjuXlBx1v3FDfRDBX94uD9IKcazz7pnS4T++o9OGkDLVl8ztDORBylUTSfzgYZB10u1ZMjBo9VmjfamshDJQFSlutJ0QfIziW29yLh89Hm/dbCFRtUI7tIYAvG/Dke+nplgdU3yt9x/PKdRNsCNuwny5Y/q0aXTOsbzw81h5g785JipUXmsiKcoWwIRwIwe5300Mp80m0d9pHolYcD3fPCWWO0whRWnTNxcYjtP8z3Ehu8O9CRpHyRVT9BSdRMMP2RhLVMCZbA4mzIueNMowQRUWS2U8AVwWRJYFp3206A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrJ+nPgqSQzLzJMZ8lQd1TWE3VQTpIhJGub411SIjQo=;
 b=PbUFvc50aXAy0aR7pMAmyjSSzwRt79E2/3uaEChKaN5MC46J/NFb70qR07Kbw96N++uOdzpiyXjy+suaKO3xUYaqNBoUhr1owlchJoKBt4D+Ob3Z5k2rOEkB4+wXvkd6asrRKcm9SxdNrgSv4yfjKr3E4JDqE/J2tAe/TuvoSnHe/8Slzq+mJNDm65pvZgBWqx+OtUoSBk1uXzd5dW3VIThuMvHKUuT0hIWU7xpTPr7G+eHj2/eAbrk0ocW9LVuVp0ZfMvyfdWlG7ItEDOagP7qK4HjdPfV3/PgRbMBkoECY+NzMwIJEd216xbji8Xs0f6D9lu+YSryGSn+luXrkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrJ+nPgqSQzLzJMZ8lQd1TWE3VQTpIhJGub411SIjQo=;
 b=aUaSRnYIGmzGuAJnbOKRflScVCSt0YiWthAoVPhlOwF151y1OVvWep0yTZ8CdGGklXJ5CyEbTMR12qHsfRdyXuGXDKQpTpPH1bgSTQGBavF3K3mewW6KZPjEPpL93Li55K5WtIj+L5aAdclTyhBnfvXCZTT6qG3wTfZa2OjQ7js=
Received: from DB8P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::26)
 by GV1PR03MB10727.eurprd03.prod.outlook.com (2603:10a6:150:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Fri, 11 Jul
 2025 12:01:40 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::98) by DB8P191CA0016.outlook.office365.com
 (2603:10a6:10:130::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 12:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 12:01:39 +0000
Received: from N9W6SW14.arri.de (192.168.54.39) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 14:01:38 +0200
From: Christian Eggers <ceggers@arri.de>
To: Srinivas Kandagatla <srini@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Dmitry Baryshkov <lumag@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Sasha
 Levin" <sashal@kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Christian Eggers <ceggers@arri.de>, <stable@vger.kernel.org>
Subject: [PATCH 1/2] nvmem: imx: assign nvmem_cell_info::raw_len
Date: Fri, 11 Jul 2025 13:55:47 +0200
Message-ID: <20250711120110.12885-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711120110.12885-1-ceggers@arri.de>
References: <20250711120110.12885-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885A:EE_|GV1PR03MB10727:EE_
X-MS-Office365-Filtering-Correlation-Id: 289fdbd2-c1e9-43a4-45ac-08ddc072b1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ppA/u/88Da5jpXyrMAksQEMx9zY1C6Lrn6hElksX4sFonvrEgQg201Mx24up?=
 =?us-ascii?Q?aujZCroh7Jc9xy7y5Cxbop4j7xf0Xpm1XRqaKRJmX5wx7Eu5YBIFTVB7ZHvS?=
 =?us-ascii?Q?4TwSxDInvNdz2EcsNDbj9XLL6AIku5m4biygR+P7pleiz6dNtOxCVOUHLty6?=
 =?us-ascii?Q?/yemQ7MqrSZ3upGImkSblCTCDwkKU9+1l5kVt3DILIU5axqbg4qB5XsQfoA0?=
 =?us-ascii?Q?EIwZ6robuLH9Mgu/j/kawsrdufS6RVam1jZoftq24zzTxyzsNB3K61VVAKfv?=
 =?us-ascii?Q?U8Y8N/5u3w+pugV5G6Y/wdeXBsj6vyf1xl2wKgiwSUtd8O1p3jqdPfjjhK46?=
 =?us-ascii?Q?nKgICgtVBK2Ww5uJBz94Ucku9GefC6pnlzBq5B5XuSU+4j6JcgnHjh/RIK93?=
 =?us-ascii?Q?7A4gk8WudViO1DQ5MXH2HviK5Idc+SF3PEtLU1g/RawMJb6d8viNN/0vHO2g?=
 =?us-ascii?Q?FmEOvY2//cPWZ3OYZVEMHGpLcMmLc5qGlU88d6WqApzzKX0LedMkH9omCW6Z?=
 =?us-ascii?Q?nnzOln5EIGeDlg9QfX9AOlpQe59nl5sqh0GqVMP6ZK3kmW5BJe75Tl/oquMc?=
 =?us-ascii?Q?F4Iu9HHOzaHyo7anUO0kOYOC8SViVkenTefxVHoj8yDNuY9SmmrqqWohYBLh?=
 =?us-ascii?Q?vzdmoGWSrG1vTitzGm84gM0cTrrgXv+478NcDAidzQxv8DkjDioGv8N7+TCa?=
 =?us-ascii?Q?ZdbaaTHz35raE/FZvn0DLcE/8KdTayGGm9ngRKSWgSYJjCr/1PEYlea2p45d?=
 =?us-ascii?Q?yeUDo+0uZYvAjJ1kJLojrQw372+fSemlhwmPcfHQRKjYT/S4Rjwa4Pwv0X2o?=
 =?us-ascii?Q?OqX5IB4ncg35h5qoNMDd10OVT/HSAC5o/R+HRVKGN9mTRiRFOGaAcoUNDVQB?=
 =?us-ascii?Q?JqRtdAMFZALB8apqkn0ngK1CABP/qb9JH5R0pZNEW2dKPuzCjqQXh5LiqAFv?=
 =?us-ascii?Q?27KQbQCOkNbGUB4RtwmUc59KQfQzlwOuRoLZjeCyeY4RFRmL9NG4Oio6BMdt?=
 =?us-ascii?Q?6X+PSMMaoxUXUdQ53qYAptqvPNOJUvkwx/Mq2gCKN+AXzb3rbxQKDgAbZgYU?=
 =?us-ascii?Q?OyPtiLLPXD3ddHVEd8R15n6Dd0FiLeVRD0ccHXO28EIuUWhz+ktOXmJyDrTH?=
 =?us-ascii?Q?rnCMinpS0AwYmNAmLQqraowGxM7pNYerlu4TP5aMnofn4ditiS47MI47dvyv?=
 =?us-ascii?Q?AmvwfDSy/JfFTu9102mEbVVRrAtxEy3omaBkqsWLE8RGtMW+mzwlutmStCar?=
 =?us-ascii?Q?TJBtDDcT2Z5cgAUqjTlnhnNu28Yqu7tj66xIJAuHr66l8MsXv7sa65a6W58F?=
 =?us-ascii?Q?3SSh+9upkdBpbu4d0SYtENEkcphjl4y48Y5lnLHUg4JIifCmmEE9cF0vzmWO?=
 =?us-ascii?Q?e6bzWwboI3fkglRGqa+PsQoF4e+49HUkSxdknFUS/71NmUACYdcvKXD1EbsK?=
 =?us-ascii?Q?4qx16+mCBxGhalJH511b79ppJZXrrT1v1arUEhLmqdGlJDgk+NzhZ6I6AzlJ?=
 =?us-ascii?Q?uuGTdELFZEufLkIzV0YP0DCADuqTkgJ/1vcv?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 12:01:39.4662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289fdbd2-c1e9-43a4-45ac-08ddc072b1ad
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10727

Avoid getting error messages at startup like the following on i.MX6ULL:

nvmem imx-ocotp0: cell mac-addr raw len 6 unaligned to nvmem word size 4
nvmem imx-ocotp0: cell mac-addr raw len 6 unaligned to nvmem word size 4

This shouldn't cause any functional change as this alignment would
otherwise be done in nvmem_cell_info_to_nvmem_cell_entry_nodup().

Fixes: 4327479e559c ("nvmem: core: verify cell's raw_len")
Signed-off-by: Christian Eggers <ceggers@arri.de>
Cc: stable@vger.kernel.org
---
Tested on i.MX6ULL, but I assume that this is also required for 
imx-ocotp-ele.c (i.MX93).

 drivers/nvmem/imx-ocotp-ele.c | 1 +
 drivers/nvmem/imx-ocotp.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index ca6dd71d8a2e..83617665c8d7 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -128,6 +128,7 @@ static int imx_ocotp_cell_pp(void *context, const char *id, int index,
 static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
 					 struct nvmem_cell_info *cell)
 {
+	cell->raw_len = round_up(cell->bytes, 4);
 	cell->read_post_process = imx_ocotp_cell_pp;
 }
 
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 79dd4fda0329..22cc77908018 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -586,6 +586,7 @@ MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
 static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
 					 struct nvmem_cell_info *cell)
 {
+	cell->raw_len = round_up(cell->bytes, 4);
 	cell->read_post_process = imx_ocotp_cell_pp;
 }
 
-- 
2.43.0


