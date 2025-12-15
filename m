Return-Path: <stable+bounces-201068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA39ECBEF00
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 17:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0593930166EA
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B452F2DFA54;
	Mon, 15 Dec 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hailo.ai header.i=@hailo.ai header.b="QFJWH4T6"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022096.outbound.protection.outlook.com [52.101.66.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B963285C8D
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816687; cv=fail; b=Cluybneq+nT4096JXnu/qWSc63Njs6tUhdVZ3OUUdhFRdxVfO5uUROx7ZN00c133SAW14fjEblLRZnhGyuPFERsRxGxU+KddNlg18mZrK3zRKIiiRIXIR04dpOH86mJKnTFUFbtTDJYLeboShdmCLhJo+CY7ppHh/waTJzKwtE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816687; c=relaxed/simple;
	bh=3WKFi/sFuIlBJpPVNgzy4PKRxNHCliGvzrLpYbujQ40=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=onZzK23IgZ82FrlIE/vgktiRx0jiXCagZSNEqmOlHPaYS61oN229eZM3DJMawv5eRwpbNLhFzIYQ5xLwy67WoVwFC1D+bFCQoYw1GEMWA8vyF85VLUDxFGHkg90UyH7WiRUT2tKx1C0HRL/vourGrVNwaN8Hj1VWWAC4cR8L+3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hailo.ai; spf=pass smtp.mailfrom=hailo.ai; dkim=pass (1024-bit key) header.d=hailo.ai header.i=@hailo.ai header.b=QFJWH4T6; arc=fail smtp.client-ip=52.101.66.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hailo.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hailo.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ro9wuP+6ItY0a30rNCRR6wxlMfOsUt9eQA96cNadB0oEoF8w69foTsw3QFNsEPusFlJDcLgid8gD94XtFl00KZHtJPbMpDNH0g2pivvHLJW78iQA6cI0NqR1ubsDNhjnQyH58tSfr8h1Z7pYtvcoU+y9L5qQO+MzIlcanBy3F13vfEJo+S30m2lcPYp3f8fOuQ09munEF89SOFotBfnKhQwva0qJoXf/dnPJ5nGIJcDiSIjDrdTQHz3tvYrez4EXXe3FG/YSZ3Uj65GwrZvIRhSt6a1dNVlbnLG5aE1GWQ/eVNxnCbD/8NCevesUZIAs6dr2cqo5RHfeGyDFUwrkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDH13l0qgtckHXxKxJGRXtkCdrdrKhYfkT7PebVkwGg=;
 b=cznc+rK/TiLZrj/OiDZnO6xz/Av7NevS4WHS7fxzolrbQJyOlcUEo0SdHXdH6M48oFcYJbJD+G9doS9cjGWSn4VuTTf4iNoosCXXS4P53plzT5jnUeAL0qHO1Fqt44+hiX4AZPTLn4chcuI1ei52UUCRSQNs+8w7KWfM19cr6nbiaovZUMvq0DV3Kv9P1TXrVyEQFs0ldibsVB6prcwrQt5ZNuxBqDiZVg2gFtdaUDKghpJuqcaKU0FW3gY7VFDQNt36ZpNCEktONmBT1tawUCfowpm0DPFFOa5+2lG9qvz7kyeKlTXCPhldD5WgBI5LxBYAVhwdnpkvtOxdcspWZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hailo.ai; dmarc=pass action=none header.from=hailo.ai;
 dkim=pass header.d=hailo.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hailo.ai; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDH13l0qgtckHXxKxJGRXtkCdrdrKhYfkT7PebVkwGg=;
 b=QFJWH4T6UhckyZ7psqG7eYBYSVY8boqCzw4X8d5aLL/uZOhs9QpzNkG3FGelg9V8XgBkJIA//+3n9YHcW9cHcXNqyjFrAttuErJ4v4tUPCDGF6OPfMHyf6IT0hmSAEgCgW0akRQ5kjZLly5ibNXMmzP//+0G8GMXLDeFsrWHsKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hailo.ai;
Received: from DB9P194MB1356.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:29e::14)
 by AMBP194MB2727.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:6a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:38:03 +0000
Received: from DB9P194MB1356.EURP194.PROD.OUTLOOK.COM
 ([fe80::f805:511f:699c:7c1f]) by DB9P194MB1356.EURP194.PROD.OUTLOOK.COM
 ([fe80::f805:511f:699c:7c1f%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 16:38:02 +0000
From: Amitai Gottlieb <amitaig@hailo.ai>
To: stable@vger.kernel.org
Cc: sudeep.holla@arm.com,
	amitaigottlieb@gmail.com,
	Amitai Gottlieb <amitaig@hailo.ai>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Fix unused notifier-block in unregister
Date: Mon, 15 Dec 2025 18:37:32 +0200
Message-Id: <20251215163732.120102-1-amitaig@hailo.ai>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To DB9P194MB1356.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:29e::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P194MB1356:EE_|AMBP194MB2727:EE_
X-MS-Office365-Filtering-Correlation-Id: c60073bd-acca-4756-c530-08de3bf850ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w7xVLL1HTimxbOiFJnUOwGHGiPNwLaUS+vBtznq4HME+MQEYlI05wdosKory?=
 =?us-ascii?Q?yd1RTd0JIWHIKjpFJx51KO6fRoeAR1vcEtDGOyTNJpoc3pvrq1HysWlIIfLn?=
 =?us-ascii?Q?SA2Xy71ki+v//a/RT7vTIJVnHOrL07TuRwWX1+RTKrLo49t8rZoiDqQRf/l3?=
 =?us-ascii?Q?oXCkf6bc/5kjzGyTZKE7dSRU0wXqA5C3mn0wQj9o/264o+LNBFkhG6UEcnKy?=
 =?us-ascii?Q?v+Yeb+J4QrpE+UbLyUA59iNWzFQcmMu5SNjbXt7RildnXqqQLATf/QCLA794?=
 =?us-ascii?Q?yP2sF+/chr9mjl/2wTFGU/n+g8HElTolr6R3sIqcV5sFak/UFUCDWvDUqNGU?=
 =?us-ascii?Q?kNuAtE4y3e6PM955K9eFFz3ybx86X/cjDgiHihCAJkgMXOOcWvhF2T2uClSI?=
 =?us-ascii?Q?gk1naB3jbZldVxtr+gdFEZJAbk1hcepE48KeffNwuT8rfEdIHkkCNCeX8erp?=
 =?us-ascii?Q?QvugQa79CLnoktGqtN8ncCM1/8GxDVOlFsUf5uhv9qGUD2A+ZIJjgTZZ/OX2?=
 =?us-ascii?Q?C1s/KoO8nYugYGJDryTJhsc6pD5iitGcg3D92KOhUVBmRwBZbMHz1oI+dV+l?=
 =?us-ascii?Q?gyLLRUyS7uLFX8Ck35Mb3Q75eK3scR22E9mbQihEJTAYPFFyef8TrO0Rrjfm?=
 =?us-ascii?Q?U1aCbqNwMjHi1d/G69M/KKwyVFJmhVEb7vY6ZDv1RQOoaWfournogPeElCa4?=
 =?us-ascii?Q?9WlUj3XJ2KgReiq3mbeI+6FiNz/hSPiYPAByoxRXqBV4pLZbpXuErhU6GYph?=
 =?us-ascii?Q?8gtZBNkZvAyy2s8eWbiOofUDeq0QLdCLMMrSEvUlYHQ9lgrpsfLWztJHdVaH?=
 =?us-ascii?Q?ZE6pU3WNMlLnkKLX937J+FiMdnKIEZ/ltjiyEdNvUzW6U7mEx+EQrTXZIO06?=
 =?us-ascii?Q?g5b2+0x38Uz3CX2KwGdRobVhjMjjYw25NmjW9Fax5xMaE1QWC7mCxMY/ZGEl?=
 =?us-ascii?Q?PFLlLaFZkk+FoEK61cD4Qvg/VF46o8DVQx2Dr4cuCVo6dKI6HXBdj+o9Ma6N?=
 =?us-ascii?Q?EhJFwoLJa7TBiJlMqExU0omO5Lp7BhAPunqM2Ung+6t3PH24isxHwA5AbcGj?=
 =?us-ascii?Q?L6DXOn1dl7amotTaxmWFeK3+vMMu89/fS0f/cfeKlrbnu0shAFhxIEL05REf?=
 =?us-ascii?Q?IpE29EF4F6r79LQmzqPBQyjaxII6p9fjcqQZHcm+2z3S1nvh0U4ZsiDK4NY+?=
 =?us-ascii?Q?8szjq4qshdocgt/8XhOq/koHKql9UXZXflz0Zr3U0QMtbkQIv3lzplmGlg42?=
 =?us-ascii?Q?u5xHsBLCQ/SWt6Z/PMP5FvmmoQAchrGFX9Z5Scr/AzX8HFFjQvlW1ckAgVq0?=
 =?us-ascii?Q?DJm49CoFZFu95QAN1hbQnnW4uftzl0snBXJfi0HWAn5k1LNjJGk+SgDHkZ0N?=
 =?us-ascii?Q?BfN+u4yB2XuGzslb9ZLTps18jRRUxOhaOsuGCUY4sF3OI0/n+qsmekIEJwxd?=
 =?us-ascii?Q?sjMoo/fmY7ZYgJM8wkTAeqN4RrourhhC6jxkuEf3H8EVKIRdXICJiGtiW9gE?=
 =?us-ascii?Q?kjfI/ZEE5l27GlsLEXX0FR4XQyCfLw7UFeAo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P194MB1356.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HSV9gvyTuvyTXGEUW/GbzQM9alV7Vr2U9GkfNT871DO6teWyzF4pqG8B4UrY?=
 =?us-ascii?Q?wuoTGJ/coBI1jK+wbfXUzJiMJOTWDGcliNZe9afpg20FJsL0OPAA86CUvJsN?=
 =?us-ascii?Q?jRvBmfMffSAQMCN3XcWExeeSse6wJ+qW65k6bwX4b6NjboFSx5SQtnzBuhF/?=
 =?us-ascii?Q?UrWQO/1LWMxU/9RArOvYtN9c/XzVOQrIzRebIoePIjMi5SUGvpfBc51DK1pP?=
 =?us-ascii?Q?Yb/Sj5xiWmvHfJyqjZuYH0wGkbZbfuCO8RDTXVg7SFVzOGnBc48FMHrwFjql?=
 =?us-ascii?Q?hV4VIhyJF9G8EsfRNaxDjxE88E4vV5QulmnrWsDrV/zTP5GpYCgr+xQUmSqh?=
 =?us-ascii?Q?/ZIvY18UF9rxE0sI8cHFmGzz7sCiCNQqiM9y7kDXCisa7PR2E3dc0WVi5E6g?=
 =?us-ascii?Q?Khe/G12oc9ROxURq6ZIHXOvcfKizPOBjzhtAKAiqxLTTQtZUv18ndtwxVAdW?=
 =?us-ascii?Q?Rk3HEa0AvjlfTjO3ZNgvGETM+Fg3Lwh4fw9+z5U+Vs/hmluZ3AlNjz+eFKrS?=
 =?us-ascii?Q?AYtE5/4chC6XqzFCAiux0TwmVzyKdHwVVTNyYo6UhZuLWbhJmIOA28HSea3m?=
 =?us-ascii?Q?l6u7yR03ZtOND+JKuS+3lfdN4Ju8omTjy/6B8a0maXEo4CuFSyNPD7DP3Wdl?=
 =?us-ascii?Q?lhY9sJ1KBfkVwrh1iiU5HO9Bmb9+LSDD6/qTMWiPQC5oDyEQdi9rjP0/z0cG?=
 =?us-ascii?Q?jIFsrKBn7OaASh7PYtCRLnpOU+AIYkYJpdYs2F8hOHN9bVMxcXKkT92GUMd5?=
 =?us-ascii?Q?6wnEETZbo8G6DIi5/oXgSR8H7ARf8O59mooXgwoBfH8iaVleQIIMkZ96W6xA?=
 =?us-ascii?Q?xbMa8+vqFHrvLyT/MHIiVE+hmTTGbplf/Cu7ia4N0tfjGsd4RPLR32V697G6?=
 =?us-ascii?Q?HTBJMT700FEmNBCf1CIiVZUo/9+EnKNvAHBrQ6x+KSXD6Xl7WgS1AW0TDpnu?=
 =?us-ascii?Q?gA3hp0tubHl2hZY03+e227y867B1pSD8voGHodGGXjJD9Gt/+BMcG6NAbvry?=
 =?us-ascii?Q?JoyqSxMBQ6REBOSpbEm60rxDtPsZZTPaF2JCLfsPpg11kOM9DAUbO06P2skc?=
 =?us-ascii?Q?Nw5qKA2ddFckYudKKhrk4kSqnS8gjMHzm7qYo4Nkf+Nnem0z/9waqV6BibL1?=
 =?us-ascii?Q?sZ4OrbjtrPw07jy/SZ9BCXRm7cv88asw3SoqNB3hEfeGlxfN9uOhd3k+kceH?=
 =?us-ascii?Q?qyv6Gv+sPXYU+Kc5jrLS+q1FAerHdnGPLrVG6za4wiQ0Ypzn0jP+a1/4bU3E?=
 =?us-ascii?Q?grKppw/0CaHp6uhVDER2uumvE7lI5UzpYfvjJBh7aojI5dGPr4K6lUDKlQWe?=
 =?us-ascii?Q?vYlUwDnFXJDcB93UbQPTfd49a1YP4eET2GHiQu0oGC6sVhRlArh5z0BF9AUB?=
 =?us-ascii?Q?bEDoPy3gB5A7rI9MRV/Nr3xRtmKyU8oqaqq0YWd/xqi2gkUeLeHouiJUvJiK?=
 =?us-ascii?Q?c43oAQe5mup42hUZYHX3b3uysEth3XOWeBVc8QxreA/8sveB3Bz6x4gCBtrR?=
 =?us-ascii?Q?qQ7mPUprVlZVhZcf9jhT6K625PSn0RMdrtGh5ToDReBknFNJa9IiTMyl0NU9?=
 =?us-ascii?Q?hWpY1f5HN6sdtCUOY/ISU1eYQnQDZSYP2/p6F2xx?=
X-OriginatorOrg: hailo.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: c60073bd-acca-4756-c530-08de3bf850ce
X-MS-Exchange-CrossTenant-AuthSource: DB9P194MB1356.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:38:02.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6ae4a5f7-5467-4189-8f6a-f2928ed536de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4pS9/d09c7bnjMxWevBQFXXts7h5L2PtAB5LpnlfpLekj7AEmWMmROo+QzrO9Kj10HvwkKFb286wgZdMwav5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP194MB2727

In function `scmi_devm_notifier_unregister` the notifier-block parameter
was unused and therefore never passed to `devres_release`. This causes
the function to always return -ENOENT and fail to unregister the
notifier.

In drivers that rely on this function for cleanup this causes
unexpected failures including kernel-panic.

This is not needed upstream becaues the bug was fixed
in a refactor by commit 264a2c520628 ("firmware: arm_scmi: Simplify
scmi_devm_notifier_unregister").  It is needed for the 5.15, 6.1 and
6.6 kernels.

Cc: <stable@vger.kernel.org> # 5.15.x, 6.1.x, and 6.6.x
Fixes: 5ad3d1cf7d34 ("firmware: arm_scmi: Introduce new devres notification ops")
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Amitai Gottlieb <amitaig@hailo.ai>
---

 drivers/firmware/arm_scmi/notify.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 0efd20cd9d69..4782b115e6ec 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1539,6 +1539,7 @@ static int scmi_devm_notifier_unregister(struct scmi_device *sdev,
 	dres.handle = sdev->handle;
 	dres.proto_id = proto_id;
 	dres.evt_id = evt_id;
+	dres.nb = nb;
 	if (src_id) {
 		dres.__src_id = *src_id;
 		dres.src_id = &dres.__src_id;
-- 
2.34.1


