Return-Path: <stable+bounces-161646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAADB01B60
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 14:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB515A28BC
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F1F295DB3;
	Fri, 11 Jul 2025 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="XUTDNfBh"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C4E28B7DA;
	Fri, 11 Jul 2025 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235314; cv=fail; b=FPZMaqpKOomVBBc/6/S9+ts6AZ2Be9dz2KSXQle9wrd1OjNO6OE02tZyH5+jczF8kPNLVXLQ/8NSzCtLn4T/O3qrhExgxVYCccgKlhWOwzKm1Zo97uJtNTBOArmJpMquP4Y85X4mM3tBWV075Dr2smAed6tbI80hdWyXfoRJXT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235314; c=relaxed/simple;
	bh=pnqvu0IrAkdV+gmWR0LZSkRQQT4YKe9W5OS2jXVWjic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7gD+4x4ujgd0UIq9mlv9iemGtNTxislqNjQxzfRYdO9yCrZQCgeOaG/p6+fBp5sEdGoCRdYu7vWHecGFUtw9gP8VJzLQah71S/ItT2RsHkX5E0Hh/KKxg935On5s2xPsErC1MRCDc9Y+ve8mx1kCtzz/o7aKU3puQWRoDdRQog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=XUTDNfBh; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQThHdpofwtDsXZs+MsQ58jbtkYUuaB+6wfZA3DLxnIjOn4Eu67AjIqsZinKBMAcoy1/ZbSkzs/MIh0GyYvwH3LQsMpX3AZr2wz5TzgWL4QGboPDopxJdC5gKUhCHlRbgs/lpaBSkE0D92ZZUyfNXihpYpLHHwYuR9/8gkh1bK234q79a6R0UrBdAM3oWsj95ncT3fLiwiGUuUmW7QlMxl8BXttr3KWENOl9JF/b5eTK8qxMNPTw4Guclu9PxPer60+w5CXPw6EuuqqB97Twd36vVupYzc0triEEOzxEuWk5YQyxqXLiZF3KOufzA3hcRXGAhv6HTF8S71Vu6zhXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+McHn7DalzcIgymFaZSpYE2KY4wWUGqal/hKL4lE/Vk=;
 b=nlzATvy/6qUbU4Ibx5DsoSzJIKp4HIgmXGuaQpU6z76R13OK+eEzONbtzT7+EMXUWQAR5Sh3Q6DGfKqMPbyiBmuNBJuGXt/ipvUL7tiBozJfccxnf/45Qi6CM3oOIS4OpeAv7MoRMnGV6TpXzScKTAEciC3c5Ax6XqgTGXas//k0c13wjY1UcLwlRWn7Aiz3UzJ3LKGMRWJvJDhwADbycZombKlpQ8EBBmG/nm3PlCzbrIrciEdJWjA5BrW/J8EGRT3JsoP5q23HDg1LcwdBRr9t2gaJXsrkxT+YJYLYoflnJVgjGzhmpAJKriGJfyid87IwTU4fSdOVr2IMt3w/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+McHn7DalzcIgymFaZSpYE2KY4wWUGqal/hKL4lE/Vk=;
 b=XUTDNfBhnSDtsDBP2GWoF4wJSOJGJa5j9QzEJLLn0GqU0iuARVhtd1014fJxzLoNurhtYkXv7FOHH5zlQc8Kd4qDsuIVX94QE9dPPlcrunq/Ht6aUc3LC67p2e9xrxapAHKLBlnmtnNjUpexzO6hQ3AolaMmN+8ZCqTck/el6tQ=
Received: from DUZPR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::13) by DB3PR0302MB9205.eurprd03.prod.outlook.com
 (2603:10a6:10:429::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 12:01:48 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::95) by DUZPR01CA0035.outlook.office365.com
 (2603:10a6:10:468::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 12:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 12:01:48 +0000
Received: from N9W6SW14.arri.de (192.168.54.39) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Fri, 11 Jul
 2025 14:01:47 +0200
From: Christian Eggers <ceggers@arri.de>
To: Srinivas Kandagatla <srini@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Dmitry Baryshkov <lumag@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Sasha
 Levin" <sashal@kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Christian Eggers <ceggers@arri.de>, <stable@vger.kernel.org>
Subject: [PATCH 2/2] nvmem: imx: Swap only the first 6 bytes of the MAC address
Date: Fri, 11 Jul 2025 13:55:48 +0200
Message-ID: <20250711120110.12885-3-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885E:EE_|DB3PR0302MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2b530f-8218-4ede-9fbb-08ddc072b6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UoSWV1gOseHX7y6xKQr+fh605K1pMtmd7w4uBcCiNbwx07idvarmXAodQjAp?=
 =?us-ascii?Q?qiCTmY6MwRx+rT5RyiQhaIP0oeH1DMqZjms/4numrrFl97Y81KWRaPMH50vR?=
 =?us-ascii?Q?hzwABq8XPxGbKQzvMeZebkG+k9Du/8wrMNdRiL0kYVbQnUJAY9MKwHe5Azxl?=
 =?us-ascii?Q?xB8q7/UxrbPojqetQoc/QfBo5fEBh4s3NqMtEjCxk9cPOnfTWmDzhU4zSC4H?=
 =?us-ascii?Q?jx9bya0eglQDh/B30R/buDygqok9/6Loey8tGAsZNTXrjIUgVlDFjcMMtC5D?=
 =?us-ascii?Q?HOKLIG3bOkunZTuvyx+dIfWafp8vlrVVHpp/0b/cWCBQGz9N3Hykoes8p3kb?=
 =?us-ascii?Q?2vU6aRwZeKY0e79zgqO4Fl1oe709x8jR+GSEg9MHQYP9WumJFvoP7haxwau6?=
 =?us-ascii?Q?ReXvIq8earlLuMt/4rxyiiV/pZVi8yy2Hn2HGKqDjxiMIgzKaCw2iEfvlt4v?=
 =?us-ascii?Q?wGjA7QbNskZyii7WynZUFMtaKdRNTk7rF6jNSDHdpT9GVpWbQ0c4YndHCvZG?=
 =?us-ascii?Q?9fXlRfXyGvIeShtwNR06P4ymlsd/ldvv4/ck838XvWAR8trdlVy+ONLlnvlk?=
 =?us-ascii?Q?t1bItFQ53Za86ImFs79SEXE+VSp+C6V96/UxIesmIjajfk7MPTgwVRKbF1dI?=
 =?us-ascii?Q?TwaR27/chqqbuxV739Rh9bJAlMxFE/WppyRrTjL63MRzB1NT2fo21mEQZc07?=
 =?us-ascii?Q?IZq6HmI8vgFxUNbpqzVd30zbp66nrdhmG91uXQ3qAnQCd8ClJH/YKFVYzOEi?=
 =?us-ascii?Q?mrNUKINnPKtBO9EnWjpU8vXtYFoybB9OQCctBv/vAT/Wrjf7yWUw65en9QYy?=
 =?us-ascii?Q?zTwl1/jTo8y1tnxPYndX/AWt1ERB2bkUn7LQXfpRzP2OVEDAXwZLKTbi6Nlv?=
 =?us-ascii?Q?3f36WMdtN/0/PNRK5QhwR1OBf+MhzWO2qKEfsS/H0q8FZl6RadSdFGXyXAFn?=
 =?us-ascii?Q?b34t+XufsVeHLWCmvr44GTg3ldA87wHQKU7S9KxtB7u8m20M2kWURUOkatXP?=
 =?us-ascii?Q?iwsNrYUXqrcSlxUA4ncRJwpHTngw6uBly49fx9LTV9XjdRRtjOudRVe2AHVA?=
 =?us-ascii?Q?Ug+RdVsyW6GEuVVA4eA38HEAmpOgmh2qg+ngz0CRBoNOM/SplFyQ+tK+EQym?=
 =?us-ascii?Q?aK0wUFkt/0D09ofpPSybuvIrmeXwiIuGzb//WUrTDccm+MnUs07vpFkFzru9?=
 =?us-ascii?Q?Wci8Ny2hKaX787tVYTr3Y/Y6ISFgQD7PI1xrVK6bPzAGVfTGDgdF0HHmWgqe?=
 =?us-ascii?Q?1uRUOZPrxzS++uVe1zj0wZc+jnLy/Py3mWH2x40ikStqBAzjlkwqX5DP7EoA?=
 =?us-ascii?Q?ZncmM5WUzD3CMflui0wpjxw7pLaWxV1Huql3pZqGSH1AUVbC/iKKn8jSF3eP?=
 =?us-ascii?Q?SVzBi+cTgPmKE/xGW2HNTNOU0QwX0v1TrXmqcQ9tD8kb7aNFnzHqCQNGXf3t?=
 =?us-ascii?Q?nLEssVX7uX+RRBhf+MW1hZf78vbSwlbgSCiAWbN1ef18luxt4f0lUA49b/vS?=
 =?us-ascii?Q?+POBTaaN0UHfbU6VIZkyeugsX1oHoJPKcwJu?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 12:01:48.1855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2b530f-8218-4ede-9fbb-08ddc072b6d3
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9205

Since commit 55d4980ce55b ("nvmem: core: support specifying both: cell
raw data & post read lengths"), the aligned length (e.g. '8' instead of
'6') is passed to the read_post_process callback. This causes that the 2
bytes following the MAC address in the ocotp are swapped to the
beginning of the address. As a result, an invalid MAC address is
returned and to make it even worse, this address can be equal on boards
with the same OUI vendor prefix.

Fixes: 55d4980ce55b ("nvmem: core: support specifying both: cell raw data & post read lengths")
Signed-off-by: Christian Eggers <ceggers@arri.de>
Cc: stable@vger.kernel.org
---
Tested on i.MX6ULL, but I assume that this is also required for.
imx-ocotp-ele.c (i.MX93).

 drivers/nvmem/imx-ocotp-ele.c | 5 +++--
 drivers/nvmem/imx-ocotp.c     | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index 83617665c8d7..07830785ebf1 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/if_ether.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
@@ -119,8 +120,8 @@ static int imx_ocotp_cell_pp(void *context, const char *id, int index,
 
 	/* Deal with some post processing of nvmem cell data */
 	if (id && !strcmp(id, "mac-address"))
-		for (i = 0; i < bytes / 2; i++)
-			swap(buf[i], buf[bytes - i - 1]);
+		for (i = 0; i < ETH_ALEN / 2; i++)
+			swap(buf[i], buf[ETH_ALEN - i - 1]);
 
 	return 0;
 }
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 22cc77908018..4dd3b0f94de2 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -16,6 +16,7 @@
 
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/if_ether.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
@@ -228,8 +229,8 @@ static int imx_ocotp_cell_pp(void *context, const char *id, int index,
 
 	/* Deal with some post processing of nvmem cell data */
 	if (id && !strcmp(id, "mac-address"))
-		for (i = 0; i < bytes / 2; i++)
-			swap(buf[i], buf[bytes - i - 1]);
+		for (i = 0; i < ETH_ALEN / 2; i++)
+			swap(buf[i], buf[ETH_ALEN - i - 1]);
 
 	return 0;
 }
-- 
2.43.0


