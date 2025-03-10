Return-Path: <stable+bounces-121731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B1A59B16
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE573A39AC
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210C822FF51;
	Mon, 10 Mar 2025 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="ud2IX6hL"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848722FF2D;
	Mon, 10 Mar 2025 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624426; cv=fail; b=kWfI4+NHknybCfKe/jUXiKRJ3iShmK2Ia5XehaVwXPJ2scBwcQxXSZ5B5ac/DOzu6OqdkptX1fksMMJBE2JdyPBxKbRXnqied2NPRLCq11vytdvgr7dgrw2kJ4zoqSbzrUWBQdjCwa8rWfdCT4b8mfRB5SnVnIbglAIGpyyj/7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624426; c=relaxed/simple;
	bh=NNnpT628qJwas+m9oh5zJAh6GzuD9xG4cGeOu3ch/uI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1p5iNCoy2DJgsNVpBtZ4S2u//YMyZlfL7XD7ulgiLNKaIFzuosMFttxjJy+0SL6sAPa1tWoeNtNo0eCJaibOB5Wqq5pv0qKu+O5jhS5h6SQhW631hNxGW/BhSVcUQWoO8+tUcpPeOFluPL1Qmgwg0w/gie77Qfncmtbx3EOnF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=ud2IX6hL; arc=fail smtp.client-ip=40.107.104.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+BaIpT1B0uUfES6xbRYd03yVJvEoe3LMtT6ucedU1MC0WS+TAJA65LMHH642GB4JhlIxx/UoIsr+ZJNzMVkW/bfIwvy10JR162LqhxSPTdiwneCDRzQXZey48eit2Qb+DDnz5UQ6jGY/13us56JZRJys3AqHER84Deh0XP8CqZ3t3PtK+2ORswxWSVg1dncqfVZmIw/GRF4tFFI/hwfKGywAZKKq5sbPOe7QXAm5Z212e6AoEOQx5+zLeZyXeXjWTOUUSNkVcR2XBtBckYr0v7VU1bgpJjoSNapzPoPWw9ezFEpbCCcg1jMPM9s/Or6mtnf4/gYOB02oQI1WYPruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5YuwEvc84YbFpPC1wpb1RMBTuLZ/BC971SzUy4sT+8=;
 b=QR0AtGyvY+TNZtByOZ9BBVuIJXvNrfJxPiJ/hG24DlRM3VELIsM00qtPZWmx/UmYshydrPG/PGlmYhARlUXZpFnAhr5SB50cclcEQEEbocGkkhO0SzWyQ2tpORMHB0F5iF+WcNH5BasJ2SV+/eYT1B8XdvkS2pbrEEp/G6NBtwJhygl+rxLCWs7X/xNe4bwy6jxjmimujoBI3JRLmBuIepIDUV9RijWPjN7vc/K8QnYqaqcZ5ZfBSZe8cTWE/Km4JVtWCrb8KTCykuJLvzJ60qE4CUnmmgxm10zaUacyXcBfwvI0j2EnaBnIf/lohxnXVRzRIJx+NF+vejl2ghRm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5YuwEvc84YbFpPC1wpb1RMBTuLZ/BC971SzUy4sT+8=;
 b=ud2IX6hLDiPmL6PCAGql/rtzezPf8nA7B+NaeYhH5rOFM/oiahG309ccMbl3KsedZJvMv1JUrw+V5yIGQKe8ds9/bFs27ulPIjmR6Xf5GFeb1wgVP+5cj8rBcWL6z3trBZccJ9cwmP4MnryPRcbblA5CXN+fwzSlGeOM3R5rGLQ=
Received: from DB7PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:10:36::25)
 by AS8PR03MB7524.eurprd03.prod.outlook.com (2603:10a6:20b:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:33:39 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::e6) by DB7PR05CA0012.outlook.office365.com
 (2603:10a6:10:36::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:33:38 +0000
Received: from N9W6SW14.arri.de (10.30.5.19) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 10 Mar
 2025 17:33:38 +0100
From: Christian Eggers <ceggers@arri.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
CC: <linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/2] regulator: assert that dummy regulator has been probed before using it
Date: Mon, 10 Mar 2025 17:33:02 +0100
Message-ID: <20250310163302.15276-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310163302.15276-1-ceggers@arri.de>
References: <20250310163302.15276-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|AS8PR03MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ab882d-a6d8-4815-9111-08dd5ff14fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|30052699003|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E1h+OP5JNAkS14aK8z2+QZzXRQiHhLU6b6NUD9sGBRvrOiRKKOUFHk3fGeZb?=
 =?us-ascii?Q?q9lBALvYC/+N3t5vWJfNiOZVuTItIfXO1xFH6oSAIQWlvPaMvDSy4YpFJOu3?=
 =?us-ascii?Q?4pCFLTDWGgvHH541R1sTdht9mkcrzqy5ebp+C42QKJbPdUKzBWBaPP2flnxz?=
 =?us-ascii?Q?OD5wMZA5OyWvRsa2waqI26a9NjKvcVTSOLLMN1fWISefLc1mFypMtqtO3a1G?=
 =?us-ascii?Q?RNMpha8RBqWIeS5/yzJQ2nrHtZlo59OwhouALJscJ3LzFsI96f3qHtWe3KBO?=
 =?us-ascii?Q?MSdw0m41DAT+1mE2cltTTANbKBg5f1afZyH0KOwm65ZBnMCSnLyM3DsNh6zu?=
 =?us-ascii?Q?hOcUu03Ef77R3QwsggQPgQHajvXc38xOlTZJ5yQwdqRzg4eUhajOJRx3LIO7?=
 =?us-ascii?Q?TjYOUQ1Ou6VADxXolg/b+iaA+N4CpLR1apTmQdkuR6Z+LwgCdxKeF8625VCM?=
 =?us-ascii?Q?KB7hHAGSCTQOLNyeMjZN2zfeuYX5EHVe3okhmf3tmUuEwzBpDUHTEsISKhQA?=
 =?us-ascii?Q?e1qnse/G/sXWcRXuq/YirzWTEtDbbcKOEJMnu8+eQmQ2Gd9nZ/dLFdGSooe2?=
 =?us-ascii?Q?qOMmYx3CATgXiA8bSrRWHknMb0lGQuzBxUjmzuQYv13LITr7iDjaoOOZYsZP?=
 =?us-ascii?Q?wNsJM+QBWGdkZdw5P7uo9hr8xqcZnI00t77ncg4JLylEyAA7owdG05G2bev6?=
 =?us-ascii?Q?WNAnB/pKLLv9eSgSVPA5vC6aEBJIv7yo7lf9YoU/hwMGNxCfAY/W8HyStqMy?=
 =?us-ascii?Q?WprfGMwjfh+mygAE5e3xfKyyU+5P+EXn9F911Jkwc7CGw7fyiIQB5SM3k14Z?=
 =?us-ascii?Q?pNyQkYFujkJ7WSGMd0OdS6hHAeoyrr2/Nw2MLtG/E8rOkVyn4Hfecv7Ds4ni?=
 =?us-ascii?Q?P/fhQ9Ec9mKZpNAH0vUa6R/Ty8W5gR4w6i3uc6rB5vB88F+XWZbpsCXGtgJs?=
 =?us-ascii?Q?QaLcBgNW8rhFeXtj4Jk/S+O660v7qkyntDDFtF4weH3ojtbFpYYdxJvFce/L?=
 =?us-ascii?Q?6ihZtTuO+Qk53O3qCptjRVGxMFPl5+4BU2V5V8DxUo4cQqtLXfjucS96qL86?=
 =?us-ascii?Q?gJRJ3zwLhwzO2ng2OHBmnWAXaeoM63B9WrvcP5Hl+DP6pPmWGhCbnXIG3HQ3?=
 =?us-ascii?Q?MHL5Mq5Fg20/jx+I4Ggp+bLT0wornWOUCwzhuLE+o7c6x4x4zWK0/c0ZK0pX?=
 =?us-ascii?Q?LinaLJ8ZxWRgX9gTM3rDkluderqmXRPswIyo3ZnZdpdc57Tc2XG6eOFM9eVg?=
 =?us-ascii?Q?fc3anILw2vXIK9FDPoqhn9W45w+wlNQN2YBg2coLAoei2+WHPZHKlL6H2IIg?=
 =?us-ascii?Q?uvm+TcNb8SeRemHQHm/hzSPysZNf5v0+HmNIbDn6MPqGFj27zcck6M1GK5tU?=
 =?us-ascii?Q?+4Wz6b8/8+TymaW5aF78eqULTAoPCf15qg4X0s7JInRnVtfHJywUtp0yIxpc?=
 =?us-ascii?Q?61+zueU8i2uezyEZ/TmIITCrCslBb7G4mGaZ42bjtGwNZ0/MCqkLTdWeASN6?=
 =?us-ascii?Q?Roxjy259cOHSe9Q=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(30052699003)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:33:38.7269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ab882d-a6d8-4815-9111-08dd5ff14fd9
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7524

Due to asynchronous driver probing there is a chance that the dummy
regulator hasn't already been probed when first accessing it.

Cc: stable@vger.kernel.org
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 drivers/regulator/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4ddf0efead68..bb9fe44aea11 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2069,6 +2069,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 
 		if (have_full_constraints()) {
 			r = dummy_regulator_rdev;
+			BUG_ON(!r);
 			get_device(&r->dev);
 		} else {
 			dev_err(dev, "Failed to resolve %s-supply for %s\n",
@@ -2086,6 +2087,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 			goto out;
 		}
 		r = dummy_regulator_rdev;
+		BUG_ON(!r);
 		get_device(&r->dev);
 	}
 
@@ -2213,6 +2215,7 @@ struct regulator *_regulator_get_common(struct regulator_dev *rdev, struct devic
 			 */
 			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
 			rdev = dummy_regulator_rdev;
+			BUG_ON(!rdev);
 			get_device(&rdev->dev);
 			break;
 
-- 
2.43.0


