Return-Path: <stable+bounces-124268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B22BA5F0F1
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 11:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C50317D80E
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59314265CCB;
	Thu, 13 Mar 2025 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="qhyMk2wU"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266DE1A00E7;
	Thu, 13 Mar 2025 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861892; cv=fail; b=B8AUNuOZ+gyCj409z+nKIA7cigoszVj8zbXgVkes4JR6CBHT3kcLspSP2zDRJ4R3GdhRaSbjxMvHSTgLEsk2+CFJCBhNGoY7br0bYUymOsFDBJK0bzPOGJXZXQrwrcUyWjd/IBMF6ILOovWTovs5R+MPfiS/K8qZTQvNNW5Z0Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861892; c=relaxed/simple;
	bh=SqI37NTOxvS2pIFC3G8QbPSFrBEV42jvhBrHLAjugIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQL+Fho419SjaeBLMaH0YmSFDhRAiw5zeKvMccUiU4ytuVC6PODzwCQg57KNcpfd8346vlFPo13Y0dqk33ftPB4xDT+FrS/YTz7nOK/d1LW2jY74NjrfphAWfCRtm3/JDlPipXavn99DM4GojRmtQWpphEJnQe/uF1i+Xt8k0Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=qhyMk2wU; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGbrDU4qCRmTI6nlyoMdyEfjbM8AH3DeYfBjqUaGeOTtJCD5B0wQQpAfmVFXGqRchOBYJPHUQ//9z4ti1F/SpuhCjcqpp13EFRWUo0G9fmgds8I63dUBxFByLiYvZBdlt0fMYZd53ZEQ2ODCk1Xi7tMQnXEwJIlHWSy0KgOAYGEYZ2jCuzAIHuGZB4BX1L5cc0yk8j5hV8bIgkqEx0YLfqv6B7/Jz/W7YXM44vF37iY2kj3PUGzE8u0jMULCieiZl8eX/JjELctQGuBH15yGb/v2rausbEJw6Z/pDbz7ur+IfB+50PuRqUpYcqS7RJOHAN5opCfs5wIlPM4hR6sTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+fKTU87AqlupGhvDTYLkOQz/xMmyf17J72kabbLUsQ=;
 b=tAsek/QzU3dWBv65ViwZQr8XGn8mLxCQEhdt58fk+RKuMFscjkIbWVOsD8O7FYAkgbedEeXZmvPmbPlT/7yBmSDmtOqOOKm6SArKo7g1F2rShxozbbinCNTWAptNa39/zUQaEtrz9/mIIS0hc0HMaf5lNdGON/DkIOjEeMHKJQE6JqW+LMO46dOkq83YgyUcL4QaubadGxNoNisNId9uSrnCNcGgFR+MoVrzGdmEWgNN2w7Zx/uZJP/+AhttH+mrjF93dKcN8zFvZVd6bDY/XC9w2mq5DCIAg3s9F2BJtoeYngjanTsA+BiBgOknqyM/eKCZiUBXeU3nigVCPYmRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+fKTU87AqlupGhvDTYLkOQz/xMmyf17J72kabbLUsQ=;
 b=qhyMk2wUKuiTlfiVLiPzCq5nLNPb0fO9+jsz0F62XRtRYwJE6N5G/F17Kile978lVyITdMP31/8vlE9qlAvwYiG75rF6YhepTDMM6/uA2D74FCQZySWx41OygdPDIW46zFaeaAYS2nahwdZwiPGGaWOGpyodZmg1QDVC4accFbE=
Received: from AS4P189CA0015.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::19)
 by AS8PR03MB9895.eurprd03.prod.outlook.com (2603:10a6:20b:638::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 10:31:26 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::cb) by AS4P189CA0015.outlook.office365.com
 (2603:10a6:20b:5d7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Thu,
 13 Mar 2025 10:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 10:31:26 +0000
Received: from N9W6SW14.arri.de (10.30.5.19) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Thu, 13 Mar
 2025 11:31:26 +0100
From: Christian Eggers <ceggers@arri.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
CC: <linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>,
	<stable@vger.kernel.org>
Subject: [PATCH v3 2/2] regulator: check that dummy regulator has been probed before using it
Date: Thu, 13 Mar 2025 11:27:39 +0100
Message-ID: <20250313103051.32430-3-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DA:EE_|AS8PR03MB9895:EE_
X-MS-Office365-Filtering-Correlation-Id: c4719a9c-1cf5-4023-be74-08dd621a35b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QA2glPBxheYBCBJSTbyY326A6Yjx+sWTp+OJ3F1f1pya3UJC8QyP8PzDMGDm?=
 =?us-ascii?Q?Ks4cD2feOYT60CzEc3GyK92k0SOfrO/K/hSfrgAfhYDjwGGxV3Y+IAVcr/Dc?=
 =?us-ascii?Q?O2lIZ7+UpbxmnYgW3N4XrSOffx26N1sXZZ4v0cTgP9URkboNp2hw+UXlibEf?=
 =?us-ascii?Q?FThQ4ueia2BWHJ/vmPAO5WhJSChk7a+boVpOIcq/KRaTxfCy9dZ3PKqhqv57?=
 =?us-ascii?Q?H/kaFB2DIDlO9GLgU3xfiUKKxNCO6dWuLRemVr+dDmRRYUELtanqqzJLAKaW?=
 =?us-ascii?Q?Lxw7rew0SGIzUjX5XJ5jMWC2yFiCyET107fRLv27mr7Zf/jp3ql6p+VKVuXP?=
 =?us-ascii?Q?1a0PhfSRGSouPbBOikYzCaiQAnj+hDPk+r9TwqfEWd68wQktnpx/79UtdPCz?=
 =?us-ascii?Q?QoKwTGk+lErjDeX7xK/Cxit85tolYQdR50kFdB8cIAPdWyFVIu2PyZV/x6bw?=
 =?us-ascii?Q?27obH99tyBODQK6pPzMIRGae5q8GwGgAXGIB06Vy7vvDXbj7C9gW24h60Hsy?=
 =?us-ascii?Q?WlDPTPLYyJJdRj7f/Vu/OzH6xZfZrlcwbqzsD86156biHxu1o9Ce5xPeO3o1?=
 =?us-ascii?Q?B/m4RzpUyjHBmOiLJprJSq7yRXbSTyTp+nODmiMDMXqIeYfEa5tZyhPTWOVq?=
 =?us-ascii?Q?8J9itTpWcsFmvl4H74iyNpns24pH+OjgFDRjvyIf8DpO2xGOoyrmJktzZtwg?=
 =?us-ascii?Q?zVn7D0O9H8qv/sDUgxSxZRQjbilaO6cVSISXZHCOrharTtC/pkk22PEvy1J8?=
 =?us-ascii?Q?DFGjheY0HZd7VS45BFAA1PX0iy7nu3eiAvYSrm8okYVzlU9PvNYy5bph5AAE?=
 =?us-ascii?Q?rl7SUX4ZDzds1+41iZNQ2s3obvQZdxuk7J12XW1Dg2gbns7hs4uu2G5oI8eN?=
 =?us-ascii?Q?7Clv6okrGFshhL/dN7ldP4tUDaiyO6hHodt+U8gYFdhU2EO7Xux4afogin57?=
 =?us-ascii?Q?Dn09qsUSAbHPrNpGCgzE+JlUfwZixP2m/A53INL6zfH+fXda7pQwQMfRU7hv?=
 =?us-ascii?Q?XiUabqyLOfv1QKoMgJ6+VvJjITWMoQYfu1BQy6J4eV6L+Zd5DMBoTyyID9Hy?=
 =?us-ascii?Q?xjfZs6rPs6Okm1evPePubQx+xbEh0Nf9pFszJT+9pDae798t+BVvMDqWNlXE?=
 =?us-ascii?Q?ya0hBckalgJpqEN2L+M9a8x9+/JpJCMfG/l5GAbu+pLf1ck3BOAvA1fbEEAW?=
 =?us-ascii?Q?d+fcDWS74s9siSsXrIJREO5sY00IbUqgp5Wb0hTKTjvg6oCucWdlfp/Rt2F3?=
 =?us-ascii?Q?CwqoHOvS1umiOVNrHAU7sD+d6aGme+Qp2EF/ezO1clpla0mRL3R1+GoxJo0T?=
 =?us-ascii?Q?yolvpHAnVAHIJnbAqpk2ttuaiOpeaz2YEE709yQO6kuXlYxdZBP9rUg96iJo?=
 =?us-ascii?Q?/Mb3gspVOELDj6fpc0CO0MfkU5kvrxIKNnpoLtleemmSk4JukGQdxVxlEci5?=
 =?us-ascii?Q?a6MoHC+icLoIbCfTtD0KC+AjWt38XNsXiKeV4+wwJSL9egdbyLdd1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:31:26.5809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4719a9c-1cf5-4023-be74-08dd621a35b3
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9895

Due to asynchronous driver probing there is a chance that the dummy
regulator hasn't already been probed when first accessing it.

Cc: stable@vger.kernel.org
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
v2:
- return -EPROBE_DEFER rather than using BUG_ON()

v3:
- move dev_warn() below returning -EPROBE_DEFER

 drivers/regulator/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4ddf0efead68..4d0f13899e6b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2069,6 +2069,10 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 
 		if (have_full_constraints()) {
 			r = dummy_regulator_rdev;
+			if (!r) {
+				ret = -EPROBE_DEFER;
+				goto out;
+			}
 			get_device(&r->dev);
 		} else {
 			dev_err(dev, "Failed to resolve %s-supply for %s\n",
@@ -2086,6 +2090,10 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 			goto out;
 		}
 		r = dummy_regulator_rdev;
+		if (!r) {
+			ret = -EPROBE_DEFER;
+			goto out;
+		}
 		get_device(&r->dev);
 	}
 
@@ -2211,8 +2219,10 @@ struct regulator *_regulator_get_common(struct regulator_dev *rdev, struct devic
 			 * enabled, even if it isn't hooked up, and just
 			 * provide a dummy.
 			 */
-			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
 			rdev = dummy_regulator_rdev;
+			if (!rdev)
+				return ERR_PTR(-EPROBE_DEFER);
+			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
 			get_device(&rdev->dev);
 			break;
 
-- 
2.44.1


