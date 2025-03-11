Return-Path: <stable+bounces-123164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A11A5BBE0
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 10:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB58188C324
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 09:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3139D225A50;
	Tue, 11 Mar 2025 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="j5fdJcJS"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149091E7C27;
	Tue, 11 Mar 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684710; cv=fail; b=n+4EpSHlzkr6U2fk64RQExCgY/aR1jHp0Av8O/6jHrFXEqZVkpUQSoLmQlPGGhqf+AsThVG0GpK5GFiRK8Rd/vB7FzkGakSujUyHupcBR1J3kPbpThElnrlpqJYOpalKcLuYDwiITQXjUxB15cKfu+D2jZ/1FtZ9yzm3HvkeMnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684710; c=relaxed/simple;
	bh=NHfiCeYHA911QoH8nFoAs4IPAr0NOX7o+Ox6+zvBXls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RHyRLuGfhTpUOCwZ0tmC1FnV2PiRc5/S6PXpMMesK0ExF5fc5R3H2/ri9+tjLxYDga0pXfiCj19qO4ib8DXqxLZrU/tK/TwTQKOzTJ1HjrazHeXzjaU9AYbnU8XGQ7sf3HPKv3wRYDRuNkUrl2yhoj4MMlBUraRsGWEDsAIpZM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=j5fdJcJS; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8p90wvtgD/5BTFZHjkd+fu69K4A+R6Q9bzNZmcxLArx4lHKmsaokzaMJ0no+ojlkMU+T3abOGd7GjxhSAR7qWeq4Kg3YF2yR7uDsj4gF7KPs/4XlLyLWzON52cu4DgxP/+g944gf+QKmEOJYqqnMaye0YCh3tOZv2040dd3BFwfqu2N8Qpt4pmaaRnWY/zISzzWXE7/CWuTEmapNTpjdet5MqrTIgh0z7/U8tnbh1hQuuxQ969dUnoIY2Tq8GZ+FeiYaVBe4c+pYW2zZDvUeyxE+SK/m6CyqV4JWapKbTnFbFaBfNEkhvGCHOgZ+aCxaebdzwnBNIiwsESIdkK4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ri3CIvl/o/WIVwWEWk+x1E5RVfhivV90pOCaRMHxpY=;
 b=p3Bnu6Gxw55yr2BOIeAu+vxatNKc9cKVmzSkGcIQjiJltT8ic+aD+feAukLpljk2K2x8/O7YczEua44ChFkNpGDImszm8axnfO6j7CoKNdfiOtAcprWkoJOzjorNjpYdZxX6gxcI2zY5uhhmu2Y0yok7cho1MhR/0NNeihTEVKHn3wTakTuY7gAW2x0hHns6ZAajfLk9o453HM8NzSomOUFN9ul3YGvlEdrziqrdpefHNPVkybKv/DxxWBGplnYX3NtmTATcVksGGHHXDRrYDVrZHoV5bb1Ag7qKmAHkFvNUeSWwwODnh6xdyNtuOQKsTTdlpIKMYvkPltqK7PU34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ri3CIvl/o/WIVwWEWk+x1E5RVfhivV90pOCaRMHxpY=;
 b=j5fdJcJSXDVDmuKPbHi7LERYuZb5Px0nXPnRdSHCcZLMinG/IP6LVjYpS9mmUCPxHoa3qNwKoMBEIuadnOVWWZRheMZhruna5szmD4x7Ca1fPIEH/mSMpvqCEgzPdRVvxAmP4Dq3RuMUw7S3BI9WIBeaNWkyapubTyx+CzkFr7E=
Received: from DU6P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::7) by
 AS8PR03MB8859.eurprd03.prod.outlook.com (2603:10a6:20b:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:18:21 +0000
Received: from DB5PEPF00014B92.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::48) by DU6P191CA0010.outlook.office365.com
 (2603:10a6:10:540::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 09:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B92.mail.protection.outlook.com (10.167.8.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 09:18:20 +0000
Received: from N9W6SW14.arri.de (10.30.5.19) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 11 Mar
 2025 10:18:20 +0100
From: Christian Eggers <ceggers@arri.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
CC: <linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 1/2] regulator: dummy: force synchronous probing
Date: Tue, 11 Mar 2025 10:18:02 +0100
Message-ID: <20250311091803.31026-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B92:EE_|AS8PR03MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: a05cd123-56ed-4d95-7b06-08dd607daac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DeT/45Jp5iXjSAdiu4J8KrUF5ZhB0D3V1N9IvaPa3x9eIss3YjP1dmfdqZGF?=
 =?us-ascii?Q?3wXWPTxghCzuF5ymQ5wJAeTZQZ7arrsXNdaZQLryS1AzXYbDJVjTBK9mF0eH?=
 =?us-ascii?Q?B0UAwnmXcgbyhXzndwzAInenm8AMqj/wcMyeTteyQ3/4/cN6dWcKEKMsCXgR?=
 =?us-ascii?Q?RbGvTqzFbzEfEW8OkgN+oqD3vktY2IuPOc0nWhG8sLQEQ8dj6L7JMr9o/Epz?=
 =?us-ascii?Q?vqhGV6n8YWhT3yIZKCx+J/JAYaw8CBjlPpDZ5Su8cjrZkPGCbqu5dmyFpgv8?=
 =?us-ascii?Q?POUGvBT+eSvip+YaJp7Y5lArEJcRnZTPmyjj/5yy5lZHqDQK8Q6Mc7sZUzAv?=
 =?us-ascii?Q?Ct23XEjQIx4NIhmMChDJTlmZFl13S5DIhHYAbfIRfaIzc1LjGV7+1BqMIv/8?=
 =?us-ascii?Q?dcJtebiBmOL5IQodq2nNPqvzIyPcivO6DF1ctENg31H78+oelfV8Ax8viARf?=
 =?us-ascii?Q?Ifc/Up0nxE0076EbHdCfcu1l7Pxw6ItqMarFwLDdgljLGSCrTsHLtLafw8gU?=
 =?us-ascii?Q?amXa6VNlT1l7sovLvWmyaQ+mimW5KkjMncBuGiuUP3rqbJmSFZODNBlhFWwc?=
 =?us-ascii?Q?AHdV2QyGsZ+3UDxpzkjQ1Zn0Swgq8TkFMS5R+3YRPz83Zt7eyez7GfYY1E4T?=
 =?us-ascii?Q?QIULlfYEQQoA+QaOGK1RKd1r8OfxjN4cw65ni6HUc6GfhSThgNu2zsUOZNSZ?=
 =?us-ascii?Q?2WeL8z2hRQrGoYa6r6tHU6bWCcEVuoEr4Iy3LyzAQd0Iqxwwel7qjV5n+VX0?=
 =?us-ascii?Q?ehCWyINZ6ixpTK/q/e+1KLEp3MrBpd9cu1+wZSGL0qWtk33SKbaIpRt2JdEn?=
 =?us-ascii?Q?chgvAPkuez8t7iRTLEE8QjdQ/X1drKcNm/5klPZN814TQyg/8gd8dyvegBAa?=
 =?us-ascii?Q?r9Iro9jbvM2jU7FaA30tEF9tMW7Zi3+u8ByOOltXdxFe1GLJNOeNWGNT0rXR?=
 =?us-ascii?Q?z5xDQJr6ATOfld3NR2bjuSgxD3/3rt079dMtk9zOaVBCkI0Dehk30HVhLXD6?=
 =?us-ascii?Q?uozpKUpTgyRIUpHYBgzAd39uNIMJAs/CQ28c066JQAKv4sJ41wa08OyW6Nkv?=
 =?us-ascii?Q?6SBMaGEnA0sk6Cudy/dfDLUDN81MyCHBX6NueiO8FxAN5E1yVartObUJeKLN?=
 =?us-ascii?Q?k8I8PjO80xzgYjJf79LJ/E/KdWGr40ajfL3qcKesNy7qwk/CoSXG2YFcTb5z?=
 =?us-ascii?Q?mZwVPSq1HIdL2R5fKM5kMJjKRvsPBLoMe/qVrys+agIZJ1wp6WHhsqj9U5bq?=
 =?us-ascii?Q?3/+nrfZrIaY1Dsw3fgwWyAHoHfs6+viJYguU3N4Qnn2de14xayUzomgksn6c?=
 =?us-ascii?Q?fwpek5E1TFVoEn5KFVB+qKtrhA0BIJcEx8QBCsnA+PSeDmvPhTXTtcAndbno?=
 =?us-ascii?Q?KhQboFBaCrdPNMEx91szRXIyIh+4y6Us1bCPCQ8t8Mzb0ZiClfvu8hD55SkS?=
 =?us-ascii?Q?8vRLKq9SUY0XYryrnHLilFewNFOr1IaqT90ljWkODibKMrfdckbo2zauKkxj?=
 =?us-ascii?Q?bH5fohLIuZORlrs=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 09:18:20.7969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a05cd123-56ed-4d95-7b06-08dd607daac3
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8859

Sometimes I get a NULL pointer dereference at boot time in kobject_get()
with the following call stack:

anatop_regulator_probe()
 devm_regulator_register()
  regulator_register()
   regulator_resolve_supply()
    kobject_get()

By placing some extra BUG_ON() statements I could verify that this is
raised because probing of the 'dummy' regulator driver is not completed
('dummy_regulator_rdev' is still NULL).

In the JTAG debugger I can see that dummy_regulator_probe() and
anatop_regulator_probe() can be run by different kernel threads
(kworker/u4:*).  I haven't further investigated whether this can be
changed or if there are other possibilities to force synchronization
between these two probe routines.  On the other hand I don't expect much
boot time penalty by probing the 'dummy' regulator synchronously.

Cc: stable@vger.kernel.org
Fixes: 259b93b21a9f ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in 4.14")
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
v2:
- no changes

 drivers/regulator/dummy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/dummy.c b/drivers/regulator/dummy.c
index 5b9b9e4e762d..9f59889129ab 100644
--- a/drivers/regulator/dummy.c
+++ b/drivers/regulator/dummy.c
@@ -60,7 +60,7 @@ static struct platform_driver dummy_regulator_driver = {
 	.probe		= dummy_regulator_probe,
 	.driver		= {
 		.name		= "reg-dummy",
-		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type	= PROBE_FORCE_SYNCHRONOUS,
 	},
 };
 
-- 
2.44.1


