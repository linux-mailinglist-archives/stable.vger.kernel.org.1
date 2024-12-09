Return-Path: <stable+bounces-100121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09E09E8FC6
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BCA1882D6B
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E021660C;
	Mon,  9 Dec 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jE7vHkoo"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E7F12CD8B;
	Mon,  9 Dec 2024 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739037; cv=fail; b=LEevN7yEbBPNi8u4fQHcBhe2q8vFMFc6bC7eHzMPWdRwW5ODtdT9JuNO6Q3EBSsakpeOVDROmx67moW317yM8gnUkkastKO1tPnBl44MVb9crDzc2ZMYwOsjgT0eXjumVAQq70U5O8Uvli8C5PIZ/LqFuWj9inKjAmU2g2jwGVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739037; c=relaxed/simple;
	bh=IYcrBkae5aK9/oEMZJiiWPXW7pKfznQtmCT0JQ70n6U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RqYiDxsPxztIkCDDZ0JxftGTrHfwoGiOKw4GTdZfOt++uxlKGhidfIo3ZHuRbJJOhHJOFSvtBSADFfGEoEE0Yl4d7Gvv+8BwyFezTnCBHvlma5Ran4OrveAXEdS6r8WRlVdwtxlb49dOteY7aRv/a1XLdWoRIBHjZ7Uq64Y5FzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jE7vHkoo; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvjXDdUzTV4jtu1EnIu9ITScJ0ANDaLxOFQsepW2VN/G52hGvY348S1hVLti8Ykq2Ma2wjjAMYrECZ8UKjE7MKV1LD79xKTG8XvXXe6ov+De7iNCF4KS8LmdslYlQ6l9P/RNQjC9hC7suYJy5Jzq2yIcwlAB+HHnAB0uLqibnJeBRFRFfeYRnxXHiLXoitOp/+lg440pPwks7S311NHq5bd7RxhR9p3o+203s1UuOSMa4mnhIQaemsKJTffXVfdur9Le9E0quBQp69gsHdTkXDih6O1uJ+ZTSYhGaXQHBp96HY9+7naT34e5tner29zTlvuS1LVhiRXqole/ks5XnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQ1XqdpdY3+iecExSMkteIZfhNUqpafc1KIEH8j8zyE=;
 b=Z5k8OSQCBO4zJ/3sXk9n+KOaXysOmYupp7eGFHRogQ14NsoNFTHWvYb1bt74h+DQTV/YxfZlOry+pS+l01YA7bQQfA8Zch/F0ZqfndNYl8b+aObvVg9o3tApm9pqiY+QGbRKkurqnXhwiGOQoQf3WtFy/NwnwER63vlmM8co5lUK6u4oPk7lDb3jeMa0FRfFCg0QgWHQufIifnyvD2NIiFOR6CpvjDajRvQScDmUM1CyDhPRNG9bh1p18m8YO7CkjW1LYvoWxqdTCG2OQIZqOwrBDA7WBwHMehC4qMU7Hfc5wimoTyYc+p/Hga9edUkMmYewiEzUBP97g/s189qvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ1XqdpdY3+iecExSMkteIZfhNUqpafc1KIEH8j8zyE=;
 b=jE7vHkooWukyyO9H3KCn+a/sg0VfRpfrVQjO3SGquMhZwvUescQzsI7G7QGyrtyJG9XrsA30Mp3t26nsTo9cdDZ1neHyklHclHhJ4Y2u32GslHGa7ZduPi9aw2k5QFqPVh2xFosHofdo8tOjTRb97wl9ifbhs0djzEW2PV3wUg55SbkXVQBf5H0oHf+lf+CUvL8RGze43wge50oPL78cMv2ZmPax7X6oPCCXByjqtXNty/k1dOJYJRunUX0pfbnsPsu+GxjjpHWdZntVGpwQk9/R0r4Giu+2PecdbCF5mUQA4akGS5rjsUjq5psnTL+c667PuxcbJ2t6rwVJTyGuUg==
Received: from SJ0PR13CA0060.namprd13.prod.outlook.com (2603:10b6:a03:2c2::35)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 10:10:31 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::b3) by SJ0PR13CA0060.outlook.office365.com
 (2603:10b6:a03:2c2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.9 via Frontend Transport; Mon, 9
 Dec 2024 10:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 10:10:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Dec 2024
 02:10:14 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Dec 2024
 02:10:14 -0800
Received: from pshete-ubuntu.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Dec 2024 02:10:11 -0800
From: Prathamesh Shete <pshete@nvidia.com>
To: <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <pshete@nvidia.com>, <anrao@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH] mmc: sdhci-tegra: Remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk
Date: Mon, 9 Dec 2024 15:40:09 +0530
Message-ID: <20241209101009.22710-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 566190a5-d5ab-4240-a51f-08dd1839b67c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CElE9UkY6DQklEV709vy1UxJ7+/fzWSJ5pOJ47zymfuFUuaMfc0NQC0Rumq4?=
 =?us-ascii?Q?S6hinQKUvOwtkf7RqUGwso7+0qSG7b3b0iTx/GdccqYgO3YefjpiYzAeVH30?=
 =?us-ascii?Q?Ah7sTp3IhCDbosae2YeeAfImeMZjvoRKWwjmcTUGfWpWTFryHvlCEknYwE7s?=
 =?us-ascii?Q?MEKEROWLmnI43j5lFNbFQFrstC/XXSH5Cic5uRt2beFtnG1w4fPIi7N1bubf?=
 =?us-ascii?Q?QZqPKLYqlmgNh+igEhS9McfBS/df+ygNVUcv0+6ttcMaGLxrdxIm4SsFw3UZ?=
 =?us-ascii?Q?uP3nDQuukZhwh6gTzbiMeX7oPwvOeAJTH1ocDN1JFGAw3xkwNBnYEG0eW1lh?=
 =?us-ascii?Q?h34khoUDnMzZFheeHiQkpkWhUdM5Az0MIF/7RmQkjpIPbx0hGOL5EEF0pkJG?=
 =?us-ascii?Q?lEvFo2+2KOxZxLC8b6bP4iJfaY8N6QHLov4M/WUhEb9425/aj3PQT2M+C1MW?=
 =?us-ascii?Q?dHSS9Zv+EeUFXtaYsW5Xubvu+94BRXEt8lbV/FNFQtfR3V18bpPF19y0Wn+U?=
 =?us-ascii?Q?07afZmYO8oXISc0JJw5R1Y6BT5dvI7A0T2kv2uSceP4zD8JOUXU+/F+z6sV1?=
 =?us-ascii?Q?el45+8XqQ7RMRYj7Bcu+EAlawvAgnssvX6z0XkO/Ky5dghaY+KCINVFNSzHk?=
 =?us-ascii?Q?chxXISfiU0+ZEAGaMRB8adccB8cWY5QM7OCbsJwhDvbKSYNdpcQRgsw6UXd7?=
 =?us-ascii?Q?ktr/Ssa2WHVETApzd44W3+6nWj1CHu/9/PZ/UBXYcyvKm1nA/0otOo1+IwTr?=
 =?us-ascii?Q?n0XZ2z/vxrFhVVO6pvHI2cJRGFOKqth5LzX2df2rl4DzM6qQMmpT937UQxUc?=
 =?us-ascii?Q?UR9pW8Ac8Tfi7NR7hCqn8m+RjilMRHFewM+nE4skr36jKeSquuRCu5os3FAf?=
 =?us-ascii?Q?gSQ9BRsrAv86aJCV6rwSnp1qvxcOiLDdf2WXsCImhBjE3d9Dx0pcBEUzXSdH?=
 =?us-ascii?Q?bJRLad9yad+9+9TTTKraf+4wpKySujgMk9CO5Yghj/insxTeUdDhd26BXS4f?=
 =?us-ascii?Q?5pPPeJtH18b3Ygw6pW5mxUMg/LiWk12MRjTJfTGvll1CIQ2Sqlob9K9Wip9Y?=
 =?us-ascii?Q?0gbUr9OWK+o5e34saEO89rM/+oeMJWQrsTd5mYQ6KgW3tS9fo7Ce+rC3RzBi?=
 =?us-ascii?Q?QpXV4teZ/rCyIQBXnTxblyMPMEZB1JcG9Ku1zgguCgdHadazv7behJzJ9UZ0?=
 =?us-ascii?Q?S+utlm+RIBmwxo0fD/wJiV/JuhgJnI3+gZkHFsBHwHm7PKRTXVLv4h0ewUZh?=
 =?us-ascii?Q?jzSh2lrJ3J36MiScMt4zQJFyAsBE0g1iG3gj48XV5JThLsp707/wyPlVxINQ?=
 =?us-ascii?Q?Fh75jXTeI0s44UB59anEDQvC+bk3VzaeVcI2Xif5Eu7/3LhMl0aW40dbnx2F?=
 =?us-ascii?Q?BFQuoDskY6g/1WPMCcPYGSYLgAcjmrx1tUOp65E7VhaE8i4pStU+j1gbiwtA?=
 =?us-ascii?Q?KAagi76wS/6o6+bAzdOn3sqArdtE5bR/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:10:30.9052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 566190a5-d5ab-4240-a51f-08dd1839b67c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455

Value 0 in ADMA length decsriptor is interpretated as 65536 on new Tegra
chips, remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk to make sure
max ADMA2 length is 65536

Fixes: 4346b7c7941d ("mmc: tegra: Add Tegra186 support")
Cc: stable@vger.kernel.org
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 1ad0a6b3a2eb..7b6b82bec855 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1525,7 +1525,6 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
 		  SDHCI_QUIRK_NO_HISPD_BIT |
-		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
-- 
2.17.1


