Return-Path: <stable+bounces-121730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B9A59B14
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E521885BB2
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A6F22A1EC;
	Mon, 10 Mar 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="Bz5U7DLM"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6A621D3F7;
	Mon, 10 Mar 2025 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624421; cv=fail; b=XuXdKAVhg1T3gQ7dzN9U4kcMuoRCfWAk9rydeRQkHZF6HRSlABE4ZHRJBwvaWU4pEc/em8FSu0p5ft6vgg8//O2lPX3XRqM9P3l1IOKMtI1dCLTLVeID/pdB05X6s3tm/qLINhBxgOgB0eK0zubyP3WGnJndOANG9fR5FH3cNFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624421; c=relaxed/simple;
	bh=ijKCGClfiAS5+88wFqdbJVEAmvI5F3tppGBCtj03otY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BRnIgmOjXLqeRjOMCKLqsNtwk6zDSHshmo+Dd7mILKKtoAAF24hkAGeOVRkiqRipMUIisYybg9qjAKVbzv5ZJavdZLoiKqBl9cmu3xXnmmRKByqCXsoPBiwndB06EIxsEjemRI5YJ8EgDtPo1twRAFjjcYNWZs+AIqPcQya1Ew4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=Bz5U7DLM; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQRbpGofTZaMZH1/VS2axhj4XhtyfxebEipm2VcQAE4cLEoDIqJ8snzKyYuRGkvxPcrcZI6mcBM7jwZkbxhwD29jd8cHGbVvPlprszSm5t0ip5qBs5hUMEw6f6Nr9BJw5Jt5/mvvZY6jmW1ECyBXF5n4tHGoXLdfG6xKZYJrbF4Zzrp0FLceqmbRGHH66kNmRw5a2xn06YuLInK//zAImHyAwiyd3K6KM/oZL9Khz8A8o/mFlmyxD/LsbwuJ9PO7sggJbq82Ria9I3KCezAGIvGbaw5HSvKLmDurnO8htgkcnSvvVKhVYFsgkqufdtT62MTP20RJkKD380mA4BuAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJljNFnePQ1d+UQoC1kOln3sAZXYHJ5qak5G1ThDCZA=;
 b=vXHTp+Nm0nCAXuChpQPTClqQqNnCV1glGdCcAmgQAeEs7SSc3e7KFiIb2UsE4l9oWZCxRMhGrS7iBTIrHVZGOtzrBnXA/DtoNahzWQWWQYtDwmVRdhO0ZxMYRLudIZqD2Iuoq7Rty8PI53yVA0AmC4ueOey2akvxuaTzp4bLwYc/ONfV8ppn4dkNyQ+kRNGGf+aCbu76HbKnD8V6GWyERNEwWGikCf33n5EJzotEFo0roqukkSV4kj8R8LwJTpkuhJkj4EGVwB6vF//aWwBJ5LElFovC9rHMO7U3laaS5y7uoI94ehgyqOyXLV6P3IeupXkrc/zzyvDzRYaJzzt1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJljNFnePQ1d+UQoC1kOln3sAZXYHJ5qak5G1ThDCZA=;
 b=Bz5U7DLM8Nn6rpHeXTPjzL6vQ7srmbfyw8EDGigAcCD78CQgnrDjF9/8z73nU6Cru9BQignbt29qaEdSPp2TZsnC/6eraDD/erErA3DpV+Wy+0fi07cKZ9TRPd3T0gPiM9+QGQ6B0FvfWbLXhQj7cVj8jRZVW7Tf0DMol9+32+E=
Received: from DB8PR06CA0022.eurprd06.prod.outlook.com (2603:10a6:10:100::35)
 by PAWPR03MB9036.eurprd03.prod.outlook.com (2603:10a6:102:33c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:33:31 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:100:cafe::17) by DB8PR06CA0022.outlook.office365.com
 (2603:10a6:10:100::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:33:31 +0000
Received: from N9W6SW14.arri.de (10.30.5.19) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 10 Mar
 2025 17:33:30 +0100
From: Christian Eggers <ceggers@arri.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
CC: <linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/2] regulator: dummy: force synchronous probing
Date: Mon, 10 Mar 2025 17:33:01 +0100
Message-ID: <20250310163302.15276-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|PAWPR03MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa1bdf8-43df-4357-acf5-08dd5ff14b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uORcwLl23ti9Q/76RliHlGmgIpid730ffO39tvFHm7EdA6Ux5ylQovE8puOW?=
 =?us-ascii?Q?oeiIAqB8nugeCb5wYJS35uPc7NyLi5sBN4oIjfjtfe3zOntjGPkQeHhQ5UuV?=
 =?us-ascii?Q?+lqv3RCPGAkuWqQYzKFzWWFYqeLZcKJPqc24Ha+wwBlzWSaS9srfojW62VJB?=
 =?us-ascii?Q?RHTCIMhWgmcaVj7uXlRt12hZHVcQ7UVpomVT2XZLN+FLTcTNkfyA2HtilE43?=
 =?us-ascii?Q?32rRXuKJiIjm8npH2cCzVVrHXfCcxLLqNuyC5q2HKEE8yOhp+o10CPp5zSM4?=
 =?us-ascii?Q?sSSfM71ISuyG3sPSDn3cLpMMmJtt4kijnNVAhxtQ5ftJIEqaaz6xlPoRXN8g?=
 =?us-ascii?Q?PWI84Rf0uEEkCp44prapfAEqXTgQCQk1vOiC6BjKnIA0dRMq2Uu3c7u/2+kE?=
 =?us-ascii?Q?UOu2sLzb52ODNRDn9kaqnTUBAwXeYGaNf33QMCOHE8H1J+7G6moZxf/MGD6y?=
 =?us-ascii?Q?koWjon29HQIjN/pDPSkU679UCN9jbjqY+oslsSvuQgpEb5k2PwFAdY19Ae39?=
 =?us-ascii?Q?4bRWIlHFEzXAWSTOefkvleyW/1r8/7qKO68BCTMKhFUBq93p+dJgrIGFf1aM?=
 =?us-ascii?Q?IgrrExcf1QwBW+iJcavhif9EVCxydblwvQuxtpiySY0jd40wgclgGp+NMVNP?=
 =?us-ascii?Q?Htwvsd+KmeAP/ppmb4RszqIGbt53ZPO67638Uj57DkJp2WCjPPQojxqrJpBH?=
 =?us-ascii?Q?W6GpfOGy3jStwHNZPOUIDgak5O1uOJ5JqDPfasmziWOB0hQy07tuYWinvUtn?=
 =?us-ascii?Q?RbkDMGv9vE0ebzd7lFLM+UuEgS7gz6WFkIvliYcoT4/13+5k9NIZAuTHkwN/?=
 =?us-ascii?Q?zDw44RiEZh4jZbS6MMfuWklEQeGisQpkVNRxgZXzwDK3Ir+LthZDbdHRlIKU?=
 =?us-ascii?Q?WITxYjQA4ErPeBwW/nN13WNdK2lOe9hnyzL3iKS3wssO3Ta09MpGoTOPZtxP?=
 =?us-ascii?Q?kKFhqTT2F77DI8Sxi+TqzFhWKwx2ucRf5pOrfkAS6UTE0xexD+xtau5e7DSQ?=
 =?us-ascii?Q?plroRTK6aOEnK0NaO+cJxyLVtQGCXuCRDwXJTwzLxUIlRwNzqzNCjBdWIEvz?=
 =?us-ascii?Q?Cj3dXZfPG1QU6KYoOQXzB4W9J54Lah00Fp2xztHpFWAXvpRoKEboejjMX9Tv?=
 =?us-ascii?Q?oXS3hqKDnK+EJ/IJHwhYxC7buYpWOZN11cmu9LaYSJJY95TAHCpdoafaMIH+?=
 =?us-ascii?Q?uLC9nILO/Z7ljXyNhB08hEoGnkUkwZZqYA0JjpEhDXgyRpNliLQpIJsWr34t?=
 =?us-ascii?Q?DpGskcO2WV/xkuemCnohyzaq1YYMw173bi1r+vcYrJrc5fYq9aJ+RPd6TPiI?=
 =?us-ascii?Q?zM1NFxPQ/pD2urBbR9lOP2XauMjok2oGUf/Df3dpe4EJ2kNap1jcn7hz1bU2?=
 =?us-ascii?Q?p7g4xUpDhAa0hQ0Baa5pamMKoczyI7X78ZQF1bw+7WDWLCl4uaM6nYWkWEgH?=
 =?us-ascii?Q?qS1YRnTAcOniIgot+7zyx3VIw4fUNc0/B/OQxZhCRq36jitepJwrqd5Uv/xV?=
 =?us-ascii?Q?6enrRdF6xEkQNHM=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:33:31.1032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa1bdf8-43df-4357-acf5-08dd5ff14b50
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9036

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
2.43.0


