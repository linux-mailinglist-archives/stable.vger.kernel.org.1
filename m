Return-Path: <stable+bounces-96152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAE19E0C84
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 20:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF08B33D96
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7C21DE2CD;
	Mon,  2 Dec 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mig94dba"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A61DDC39;
	Mon,  2 Dec 2024 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733165317; cv=fail; b=c8wx57IosEp2zdwyxHuIeBvHht6eTczcOsBJ1udEChCAcZ9m7TNkuSICXla+AzqcpX1KmapRu2Q/t/45k1xkBHjIAPosBb4E85OwXzf/PEVQCog3pvaQ+asEHGgXuRvunJeFG78lsl3+Dj4wvPei0PbDbz0bSL9em3VkaWjH4t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733165317; c=relaxed/simple;
	bh=WRmDbxkj4Z+2iUoQvvnymrb1wyhBXuyUEUoRMv9Oecs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VJunaZwMSw302G543bXNKKtReChRRdzRJET5C0SVrxff5ze5kafJ24QtmRWqLLhQNGeeVQi7NuorHpvqXUuqaKddfJE42UTUhTkltcwGnZ8yE4TlfIT1YU/GeV9lwhZY1ukfvuJbs5MtfK9uSstBKJ6q9L9oXcINyvyqb2ecRVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mig94dba; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbN3SIvspCOSUr5TbzDlKGvkb7xk7OSJU1uBTvUR/2e3xv1KQIOb3GpvRZlYgnf/ugR0N20m1MF7h1Q7XR0sQM2XSULvWIKDWQJI+95jZvhwYthEcG+36LQ+s/uo24uOPtBF+DSQeBysTUSSyy2yZiy3ezV8eHbJQq3gDkxk3psYBQu5DnNPkgybVfw8znRE4N6ISlBpeB/xTlObEgGgX9D9hJBwk3WOGJ3hJjwlOxF7YmjnlzLgzGn5ZlzbD2w/981kdsi1ydjlc9ImbPR6z21/KXeW90gGOTds9taraltIUv9vMVCXt7LyDnMcAWDsEp2lSYLtmtLKMCOtYZJmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOtZgqwXCqtwubgP4KpRV2iFdeEXYQWSTpfB/sz/1sU=;
 b=wz7RqcjHct18YlOTSNLAkogwy3rLovPBYqdSa91f29WtEppThQa0WZirXAO3T8miDetfmUKtxRR+R2tVWpzdsu8pAk8jOcTAWssxR/VkUsLkfVS3RIof4RB4YeYF9HfNIxdHSoDqf1I7CWA3kqrLOQNVXNQCMQ7Dt90N2srPCUbXWjoO6Ir+yOkebzsaKRnpQHdUB0ELXZg2w2i5LIsBcqzaupr/zWhbFAwrEHnCusl7EbKy36NFH2QM8k0UYbfVK5n/gBf26zsQhf4WwXHpFO+m4FnVfLo2oP0KgKiB6SjEKof6uzLgI8xQQhomSQluW5DqIHxUajphIt+RpknAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOtZgqwXCqtwubgP4KpRV2iFdeEXYQWSTpfB/sz/1sU=;
 b=Mig94dbaRfwmZ0y+YgwQDcxD7xoQcJRieXXGKAlLkJX19e9XmkLpl3Xqe2uLVg2VdH2gX2zK9t8b4xqF8p5CBV4ES8uPiSnkKl8unWuMqEdR02blu9Dwd2HX474IP5pHlCTM+1EtMPQeZA7ZTzBrZu+tFSCI8c6cZtVaVnsrl8g=
Received: from CH2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:610:4c::23)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 18:48:31 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::28) by CH2PR10CA0013.outlook.office365.com
 (2603:10b6:610:4c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 18:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 18:48:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 12:48:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 12:48:29 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Dec 2024 12:48:27 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <mka@chromium.org>, <gregkh@linuxfoundation.org>,
	<radhey.shyam.pandey@amd.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] usb: misc: onboard_usb_dev: skip suspend/resume sequence for USB5744 SMBus support
Date: Tue, 3 Dec 2024 00:18:22 +0530
Message-ID: <1733165302-1694891-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: b27f5a3c-a324-4253-d73f-08dd1301ead6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qZWyHM7vC2K0Q2IEC9iPHBYOK0XLY6Frz/C/1gaZwbEkk84MnrJD195b7YQA?=
 =?us-ascii?Q?9OMAgWLFHpXy/wIrOxJe2rB2SnjGa2CUv9MFKnYCcj098yZKhf/hIAPrgDsg?=
 =?us-ascii?Q?IafCrPXxDYwL2XzS3FxkYdURAeef0RW8Ct5khSMOVXJPJ8rnCypLl+jTSY2Z?=
 =?us-ascii?Q?fZ8LY6OMdfjayzFsN7t5j1TkhZgdZRQkvekokJ++HHt74C0DS3E22Qo9m+8w?=
 =?us-ascii?Q?GgcjsRoKW0SjF7lPwfZ/CQFQArrDBw8xJsIC9C5kk8n8izNuy/jn7RCg8da5?=
 =?us-ascii?Q?nl881VAso8HxLJ1pR+Obc7APkFxXg/RwFmE/J7Dr+1/Vc7BAhj1uo4mFRpyA?=
 =?us-ascii?Q?OogrtjygRwiqKrY+7PAAZ0Grd5lOp0tCc2Eds+EVBmrCGqgoUeRwbmB3Nuba?=
 =?us-ascii?Q?Ton1xS9GOjtW9HKxFz4pQk2dPJmFSVSDBZ5/ka+ZnCERJszyW4jfD2K12ZW1?=
 =?us-ascii?Q?LMp/U7w5sdqIz5ea7gWULIndMVD9y0udeXj3neTSyom8uerE502DhUrciq9B?=
 =?us-ascii?Q?7w5ZtU/N1D+P3IqCYSyg551NaU60hftCZ9a9qJxjhCzvKdZnMeCx2GS4I1Q6?=
 =?us-ascii?Q?293Psvb2iuO6IE/w/v7xqwNem/oJPPQSmkMmpwHSNGF5X/Nf58xAeWmrZfUj?=
 =?us-ascii?Q?MJxokhKJrl4AM0chAQjTEA+KzVKG1XZCAOFoYd0WJfC+9pacuDNOF1yk1Cml?=
 =?us-ascii?Q?sm2xhMICXxTxWOHQX+YBspbyV46QOKU2lJ03lREkwv4nyPhasuSERO1x4qCi?=
 =?us-ascii?Q?fJhKsVvXOdlmLVCVVgTTdADTeVESPJENmF1znESuP3YNrQMIOdGDQkGU9duW?=
 =?us-ascii?Q?ziWMtPfjKNlQWaSHdL1eyhoD5O1FHFILLiH2PcHMztywu2IffxIuBtfV81oN?=
 =?us-ascii?Q?vN1Ll8Tmj/8Luw33+crygWQx0vWb2nbpRxVz7NFvRaW3Rrq3qokhCDipNSiC?=
 =?us-ascii?Q?eRcgnjshlrRKfb4jRR8Bjbf+kzlDHO21l2R/lkluACH9m8TaMBdl2Sm0mj2t?=
 =?us-ascii?Q?VkbttpG++9WlZKTA6SxcMdmuipWcjNP3qouYHXG42A/O/f6E6IL+Q5jeLYTC?=
 =?us-ascii?Q?mdyA8na87qw2qnmulSnOWumbNpYH0mfJ2QygvaTpmnUcdX8zxQG3bCOp3PVz?=
 =?us-ascii?Q?sy1TwJV2Zm2W7nUo+tVCQGMIe1v51mmxBweYloGmd23/g0FzUOTBaln/4C2g?=
 =?us-ascii?Q?j31bfzNvnvZBDcEQCmeejUa0qwzVJBZpF4A5hrdL4jnYCw9ZAalz/eo8xPwY?=
 =?us-ascii?Q?4IxSxFUknen2RIxu0KAA/gAnDOFevKWF8FrzeyZvy5QTt4EKiDwpTCLiCdYy?=
 =?us-ascii?Q?9wuBl+xgg0kbYWpJVHPgVHce3wzEpLGLSSdcu1ljvsyVIyJMvSEoaeDtDcg4?=
 =?us-ascii?Q?8dtd5x9vJoVl+PtrJg4x6vfslh1g6TryGnZM4OE0ZJL5DNSH4TTtrDtxLk2R?=
 =?us-ascii?Q?ueUDgoofFZoMbTulbH+Sept7YM+SbCbV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 18:48:31.1540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b27f5a3c-a324-4253-d73f-08dd1301ead6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710

USB5744 SMBus initialization is done once in probe() and doing it in resume
is not supported so avoid going into suspend and reset the HUB.

There is a sysfs property 'always_powered_in_suspend' to implement this
feature but since default state should be set to a working configuration
so override this property value.

It fixes the suspend/resume testcase on Kria KR260 Robotics Starter Kit.

Fixes: 6782311d04df ("usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus programming support")
Cc: stable@vger.kernel.org
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/usb/misc/onboard_usb_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index 36b11127280f..75ac3c6aa92d 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -407,8 +407,10 @@ static int onboard_dev_probe(struct platform_device *pdev)
 		}
 
 		if (of_device_is_compatible(pdev->dev.of_node, "usb424,2744") ||
-		    of_device_is_compatible(pdev->dev.of_node, "usb424,5744"))
+		    of_device_is_compatible(pdev->dev.of_node, "usb424,5744")) {
 			err = onboard_dev_5744_i2c_init(client);
+			onboard_dev->always_powered_in_suspend = true;
+		}
 
 		put_device(&client->dev);
 		if (err < 0)
-- 
2.34.1


