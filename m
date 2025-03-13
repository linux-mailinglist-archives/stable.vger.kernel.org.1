Return-Path: <stable+bounces-124267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67112A5F0F0
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 11:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FAE19C15F2
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD097265CA5;
	Thu, 13 Mar 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="UEsyqnS8"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2068.outbound.protection.outlook.com [40.107.249.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2828D1FBC87;
	Thu, 13 Mar 2025 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861891; cv=fail; b=EXrdOA+Lc27olchbS0mj6sSwjjl3wJqu6uHItoalsvILgQ0jjt4GHc5pZqPrtfih2KJApYV71OhNKGU7/+yLyqk5qLqgAAFAKz8Ubxl/pmeEHcYU7gyFOTgNWk2vu/NIo0WyFJA6awJTO7WJzlmlpUOfTi7BORhcQGzNMCZkIOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861891; c=relaxed/simple;
	bh=3Y/E69fW6ogJbZ6Q6iGGKaihQv15wvQaW6VDB3IioyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8Rj6u5MyPS+cdJAjd71O0x7cfh2Xq/LtqxVThAXSQePnNXou/u0JQwzpvY3Q7suZy6wAyAkr5QJ/MaHW03Oiv2UCpP7bnengbCz4NXoehe1m5c8YztpUzwrtNZNMScZyYibpPfzg0Mmam18jnQ0xG+0Hmlm+3/SnmHjCNCAKbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=UEsyqnS8; arc=fail smtp.client-ip=40.107.249.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL5FcWoOncbKtMKQ9KmK1nYlDzbHv1Xe9D57KKr3CTTXOgre5ZOAdiMBD45419UuPGsOUT1gP6cJQPjXuDRAxY7ujdpE4bC9pgqnd0gGYeK6Xy7uXThOVHMVZmpfGIdEez1wQpuhOIlVBZPMZz7eZQXbIn8pSBjZeD6DhDnt3KBtCyMfRCRL7vBL1ixOXLkhdL0Ann1hF/QsDb4q8uBsEnD/km7UiHs4uY5R71yF3m7NGDe2uA0M07H4f3U9sh5bIlt56ijm/kB2SOlolQ4GLNnqMLwIefBodc/iSeiG0eKlvECLLWQjDxo6r1n0OPOJgpDYXoh1aoBIKlMFx6WSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGhSwsBSILb/+nMOCZp5IU1JOlAmygG/ks18+mGfATw=;
 b=g82dW/5k4mi+y6ikcRKp1F5S/Hki/wZT1k60otIXgHiGp3Rq/S3tDsBtRWr4+0ImPnIeRAFtq7Bp6P1Jdqyu8H5xMVvk0SWv/3ZyMwyo2eMb0DBmMM1WfKWSqq+ILm+w+VRGHvkfsQOIQQ30OMMIQduPy/h+Tv7yAvc5xa8mHvnFpSBYZD3kruniqI09JBVXYMDcZA7e542i5b0Rbnxbb/Lqn0urQsXbJUeX+oOU0+f1b9Lt2UQtC3Vw6VV91PC6jIJYQF222dQevlpK3IdjTJHMxZuwyII/M3Jkkjc0Dqa5h2+LHrUl/7Ps+BEW773AAk9DoCLZMYOBUs4fOSrd1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGhSwsBSILb/+nMOCZp5IU1JOlAmygG/ks18+mGfATw=;
 b=UEsyqnS8dgUR7zTsmoMn35CAOU0OPMiadkIWtWfx58zO3BwtgTvNMACNTnmh3vLJo6M2VizRqo4Cs8X7yID8+iZf7ZX4D+Z1J7mHkbOuu9i3JcW0s1WMhbyOZniTwFeAHAsxZJNePqwyTYfXuwKcIkewyu8pagAcAHEe6ceASZ4=
Received: from AM4PR07CA0009.eurprd07.prod.outlook.com (2603:10a6:205:1::22)
 by PA4PR03MB7472.eurprd03.prod.outlook.com (2603:10a6:102:10c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 10:31:23 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:205:1:cafe::bf) by AM4PR07CA0009.outlook.office365.com
 (2603:10a6:205:1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.7 via Frontend Transport; Thu,
 13 Mar 2025 10:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 10:31:22 +0000
Received: from N9W6SW14.arri.de (10.30.5.19) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Thu, 13 Mar
 2025 11:31:21 +0100
From: Christian Eggers <ceggers@arri.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
CC: <linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>,
	<stable@vger.kernel.org>
Subject: [PATCH v3 1/2] regulator: dummy: force synchronous probing
Date: Thu, 13 Mar 2025 11:27:38 +0100
Message-ID: <20250313103051.32430-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313103051.32430-1-ceggers@arri.de>
References: <20250313103051.32430-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DF:EE_|PA4PR03MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: d18f9322-424e-431d-ae08-08dd621a3311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2F1jB6ZJJYLi8CcVOB/EK3v+9Uh6KSHamowUGmL/zkrXwjYg6sbMInZzmp4r?=
 =?us-ascii?Q?y1pGfFQhVPXJzrIMT7vNYhImYbhyAui8rWuhAnjLhgawZD2l3eU8pWLwPLEL?=
 =?us-ascii?Q?gYXuHi9nENR3kv7lJO+gpXSTNpwl4d5WDx+3WcCS5JNeCHzp+w93gVfKEe19?=
 =?us-ascii?Q?rpMbwAhks4Q0oxB6Hx8PoXuUrgJlgub1nfahxm76PWFSZp5aUO1y2q9h1gGM?=
 =?us-ascii?Q?h1Hw9tOd5vAu4ZMpqncR1c8+5MqXc3xV1Ji3I5+QcCCs/7jDD2daXIPh7hPM?=
 =?us-ascii?Q?48WhbCeCLtBbxzjC6o9X2mC/X+0805KoOXedGdkpSLlzfqOp4yZ4HW0hgTji?=
 =?us-ascii?Q?7EaKs3AvJkIO/rahNOv8NyXN78eIMjlah1aaGILqSVQo6df0Np24nZ0WRjLq?=
 =?us-ascii?Q?767PF/4oo/votdL7XqozKc9w9OomKhIbidZ6PVU+uMYjglRJ2PH+3PWFe7fK?=
 =?us-ascii?Q?GNqUc9/MX+a77vy+1MeUASP5zW/aRnznRsSBFAAwA7wvzkZw3p4vkMQj5ZUs?=
 =?us-ascii?Q?i5vF4cmzTwUlKT2ke19w3m0QuoESJohYvYHgEOyKWOzf6ZjabLv3NViJ8EsO?=
 =?us-ascii?Q?zn3rYFrQkE6dLdRCCndYLa5aZeKF2hEDU/oAhI+LATv8CWE+AGlNwxamNI+V?=
 =?us-ascii?Q?t86/jC064Edvg9fqXDozYuPwBH1OE42HCB7uiwPkDwyPldFWPiNv/1dkErSo?=
 =?us-ascii?Q?TTb5twwPtVGIk3D+EL7+zar0VKu6hmvBUc0r6Z3nPTbB9+Gq/fObq8S0CiJl?=
 =?us-ascii?Q?TqgXqLq+1+xGVAYZMaxj4HoqF/dH46upA/UbcNhTkUOwLqjFL/a9OBKbUYHR?=
 =?us-ascii?Q?k7uK/gxYJXsqvZRXdxNeU3I6Bjfo1OcPbmN3QaoZZRC9cwzdd1o4zJcliVT7?=
 =?us-ascii?Q?J7/7M7b01zvwHEGlZCqj7cnTHQaukYERvPXyAL542CaIC8mh/mf5IFw3BXBQ?=
 =?us-ascii?Q?aoqqceGFW60N5FWzSYV1FCd3O4Mj7Q1SNTc1uetBbQ0xo98OX5+5LQNBpER3?=
 =?us-ascii?Q?Q2jfsty8hY8RMSqzpWA5pqH0CDy0JWgUmkCmZvNVJHJDI0Xso55LQ9+/Z5Wc?=
 =?us-ascii?Q?wZyGpZCXFVSRXOPaNoE3+YAwIGQFgFNQ/NxhhOoI08h/jMJg5RMJgG1BVErG?=
 =?us-ascii?Q?4BexsfPnuoneUagFhyQlLhHoo08k6oP9Ycb4QFDvjUZY/rbNL5apMncZnpQT?=
 =?us-ascii?Q?XFQ2o/beKks8rTGAYYrZYE6ICQBFVvvl9Z0DPRm4FfrygB5d2ITn/El/M7Xx?=
 =?us-ascii?Q?H4ncl6TverCIX7jXsbfDWO1aerGoGRQEy+RPJwm8a1tSPLdqm162LHJxVqMK?=
 =?us-ascii?Q?CWroZuaPquhbylwk3Hy3jeBKkk7IrMMm4nmE2ObSxJvpmFbHsozpm/0Cgs4y?=
 =?us-ascii?Q?s+PeQ8/woPnfiFVTE0jK4ycFkir1y93KbpP23BJk+g6aJtvFdsOzmUkh8u5v?=
 =?us-ascii?Q?QJVsBfk+mmKc8P2Wye7UtMRQhkDIr3KySnQ2lI2c+omDUUtexEoj+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:31:22.1634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d18f9322-424e-431d-ae08-08dd621a3311
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7472

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

v3:
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


