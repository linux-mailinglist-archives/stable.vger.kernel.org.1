Return-Path: <stable+bounces-119749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A39A46BDD
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 21:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0FE7A1CFD
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 20:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1747C266B4C;
	Wed, 26 Feb 2025 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u/kWefc9"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44578262D12;
	Wed, 26 Feb 2025 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600057; cv=fail; b=bwP7dgpdGQr8bc9jnbfIulSm+WXHInVUqlYSEgbMFIENIiR4jN2aqFJ+pyMjWwaLmsJOeCbdSWbKjDXl8d65hDLj4ZtPY9+Vqktt7uEJXLhzUDIB/Ld8UVIxgAuceF1VPQXFZP4dinM3qtwYe1EXJLTu+uw6ke8LlZdvc31mD/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600057; c=relaxed/simple;
	bh=bybFBrlH34meCOdcm2cfB4isjVUI91d05hgM05gAE18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sMz+Ib5zn2buu/+Uoi5WgAKSQD0/gaRR6SayUqOeWkQGEc1v79oUVvZfL6Ex52xBVyXVlMp6noqUSjCM+oN/tRdH0DfzJ/dZuHIWOwR6LWMBXwOwdO5fF9svmNjRpwKQf1vFYc1J66w7zTyHtZzwEo7w70AiLtZMlgYtQCGt55I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u/kWefc9; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLkMGeOSMANJSG1NirpaGwlS0cyPMgcnXNKOOZam/3z+C3MyZmZ8+xcmtybHqi0vtT9uV6bDszdirPRYRSe44eamxfrw7NdUco/KYQo0QpB+HtNkVLxx2Co1Wj673LR+Uqh8fk/pO0XQdra6OY+OL9OnT1v2rwJ7alqVh2u9qAw5/Na6K/CO4ANtoXz2B+vzPkampjCe8MRR6e8i9gBxwRhwEsdeYGdmoGPJt4Qgm9qUW0M97JHNvh9InheGvYOlGYhWM1pw75teKItXTm/2atejvXnGFZyKoXriEcCY0WrwTtdnYKWjDWqdNftjx1FjLvp6OkCnDbxu9TI0UFd5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOpcNjzZQH+G6MvjZkQ0U0mJZ/4R1o8PfIADvNcTUGU=;
 b=wFLZC5ycOUuI8TCjiaHsHhlztQ0SDpz3NL5AGkceuM3UhzhkFqO6zsss7m+lKX880AEQ92gs4XRNoB451IFN/Af0jwKanhmPwfQq9XOSWiIFqG7nXIa+apdIVVIIPTQRNaNU9erf/eZSHQ1rc6dDnrkaIGLojf9+T0ylOQ12HTtGPcMQXRTcBT+5ywKPkBJD8Jnw9IK5fVTiR9bOdLGvkoDEiQdPeSwyY6G2igaq/8kfkNXw6wtj08CPJK4BzjlLGBD+/HmnC9q0GmSsUFGAKk5/g5O4xi0O5GrseHQEcNAl1f9wbx/cCX/9anTD+6mxEzMw5jynB7hpwYkwEvrIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOpcNjzZQH+G6MvjZkQ0U0mJZ/4R1o8PfIADvNcTUGU=;
 b=u/kWefc9JPdIkHVeq27YOVIG3oYhBGVHccDACfdyW2AgF7dcsgJlGOEUNgASNEuizWvcsH0UHEK/BBCpdQPhPouaX3afYxsc7UmJilAG0QyKsRbkSnTge/ONh5qASxHbH3kr/X/0tQ0cDq8pxzwsEcGAHAtkacTv45e3UYiUzqA=
Received: from DS7PR07CA0005.namprd07.prod.outlook.com (2603:10b6:5:3af::15)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 20:00:53 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::61) by DS7PR07CA0005.outlook.office365.com
 (2603:10b6:5:3af::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 20:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 20:00:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 14:00:52 -0600
Received: from amd-BIRMANPLUS.mshome.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 26 Feb 2025 14:00:51 -0600
From: Jason Andryuk <jason.andryuk@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Jiqian Chen <Jiqian.Chen@amd.com>, Huang Rui
	<ray.huang@amd.com>
CC: Jason Andryuk <jason.andryuk@amd.com>, <stable@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] xen/pciback: Make missing GSI non-fatal
Date: Wed, 26 Feb 2025 15:01:34 -0500
Message-ID: <20250226200134.29759-1-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 88561c76-9d37-4c4d-8b69-08dd56a04633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vmqnu3TfGjbPbmzA7/6gLmZbRZpE02cGOfWCiqBHRzWdoxcHGz+j0rfn5Y4M?=
 =?us-ascii?Q?b8mfaz/+z7ujIxP81Yrgoi8hu056kb7Oy4bFuX7SNIuC1Xv9smVy9btOGCxa?=
 =?us-ascii?Q?DUTz8engmWQvUNu82sVvXM5CRnOQP5uxhq7+MkfrgSRvMaNCWM6BnphM6MvE?=
 =?us-ascii?Q?zIzn9RNdtUQETgydJ+d0oRglbtgS9KgzNvBDzA1C6sYlguM0XpC0io4g7UDq?=
 =?us-ascii?Q?cYh/DXweG9h7ZiFrGAafeuMVKbJ9L9DDQ8FKwSNshPFraVj8ZkZW7PNPy53K?=
 =?us-ascii?Q?LCuqhkws9J4pHaPRCcSdERtnbOsuAwbM0CgytgEyaH0+dQQwYeP8iorPF2Hy?=
 =?us-ascii?Q?GXDtAomlPYafJLIQ9l16wOEVnq9rdFx6rxQTpa09haNk1BQQf8lV1Xpue7Vw?=
 =?us-ascii?Q?0Kr/mPNQCaBRWAUenUMffTR9YwZq5+j8Y7MXseOsU+LEoOMQ9le7Ifm0FIE9?=
 =?us-ascii?Q?I1vijAaS2FW+AI26s+ym+sGQz6STtY44eUtCpwBimg5baB86d5SVqfoAyhS/?=
 =?us-ascii?Q?CC/dthyQsAKEiRbLon66FA50zHvlAALu1mEJNE0p4wbR+oR1Wnm8xLyWgaM8?=
 =?us-ascii?Q?ORud/+m+8Y3VPuJkytZ+gmH8SVXKokY+TjTNkLPQdzxASO9BqWxvEoDQxfDX?=
 =?us-ascii?Q?hcuRB+LhSn5aYoaH30HQQBJI97kP6w1rjVzn5kjFehy3/pb25PZcyBncceHW?=
 =?us-ascii?Q?utozP/whTx/ZXU3GEsLbfCgD5otQ6xBzSI5sdJpgs2L011lhK6/VIUtg9JN4?=
 =?us-ascii?Q?bwEylI1sV5OJT1uzB39Z9qxaVGLwYvSEfvGkuYE93a3TySw7h7kh08T7tKUw?=
 =?us-ascii?Q?8PkDJxQlFeRRKxSF3hsGbDyKR9ZQfCw1umb8Kpc1/sM7gbYSrZI2QCqogl13?=
 =?us-ascii?Q?RVJ5Hl/tz+5Jf+4FySglI/6uzFNQenVJqvgWAlvr8a/n0m1xGfUIIHdRneO3?=
 =?us-ascii?Q?gE2AUAr/MHQQhovPN65sF67pQiOWtdun0Bm+QPwWooo1yYo7ii1m7C7I1BUn?=
 =?us-ascii?Q?9E1GeVG0q9ufAlFZFC49DxFbs1ADBs3ctJio2g++QSS4WSyhFsuVK5QHkFOQ?=
 =?us-ascii?Q?CmXHMem6vYJT9IavODrZHi/cnFfn8tZ444YD4kLz+2CZ+to9WxkfAStJfczT?=
 =?us-ascii?Q?5xohM7yoLZuV5Qfykf0UsK2Qk/gkBHy9a6xLX80j8vgUoheZgpnm3a22wyL1?=
 =?us-ascii?Q?Kjkf2YG4uMUvFXqrG/i8ttz3NEJ0MzvOPs67z11vDqAscdZt7rshhx3oE3gg?=
 =?us-ascii?Q?+N3kObsoFQizAYR/mKJAVoMahACbKyU0Z+1bpSHxE44G2AWcbFNY8BtVTFKi?=
 =?us-ascii?Q?NJ2HOWX0gXlPFGmSYn5Ibt7oPGqL5OwCwptixX/l35JIHucZu+dkUb6J2idz?=
 =?us-ascii?Q?IOoR64Yk5fp0fDGSzdZ/+NYk4p1wPdX2OcM0cewIJT4dwr2KAGDL/mmeeAz7?=
 =?us-ascii?Q?HdrgTidscn/IH7phJdUmwHsREIxtgY5evoLjw01pE9VF56h9asfGVVFVDscs?=
 =?us-ascii?Q?QOfQZb1mKSjvgHA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 20:00:52.8080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88561c76-9d37-4c4d-8b69-08dd56a04633
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238

A PCI may not have a legacy IRQ.  In that case, do not fail assigning
to the pciback stub.  Instead just skip xen_pvh_setup_gsi().

This will leave psdev->gsi == -1.  In that case, when reading the value
via IOCTL_PRIVCMD_PCIDEV_GET_GSI, return -ENOENT.  Userspace can used
this to distinquish from other errors.

Fixes: b166b8ab4189 ("xen/pvh: Setup gsi for passthrough device")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
 drivers/xen/acpi.c                 |  4 ++--
 drivers/xen/xen-pciback/pci_stub.c | 17 ++++++++++-------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/xen/acpi.c b/drivers/xen/acpi.c
index d2ee605c5ca1..d6ab0cb3ba3f 100644
--- a/drivers/xen/acpi.c
+++ b/drivers/xen/acpi.c
@@ -101,7 +101,7 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
 
 	pin = dev->pin;
 	if (!pin)
-		return -EINVAL;
+		return -ENOENT;
 
 	entry = acpi_pci_irq_lookup(dev, pin);
 	if (entry) {
@@ -116,7 +116,7 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
 		gsi = -1;
 
 	if (gsi < 0)
-		return -EINVAL;
+		return -ENOENT;
 
 	*gsi_out = gsi;
 	*trigger_out = trigger;
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index b616b7768c3b..9715c2f70586 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -240,6 +240,9 @@ static int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
 	if (!psdev)
 		return -ENODEV;
 
+	if (psdev->gsi == -1)
+		return -ENOENT;
+
 	return psdev->gsi;
 }
 #endif
@@ -475,14 +478,14 @@ static int pcistub_init_device(struct pcistub_device *psdev)
 #ifdef CONFIG_XEN_ACPI
 	if (xen_initial_domain() && xen_pvh_domain()) {
 		err = xen_acpi_get_gsi_info(dev, &gsi, &trigger, &polarity);
-		if (err) {
-			dev_err(&dev->dev, "Fail to get gsi info!\n");
-			goto config_release;
+		if (err && err != -ENOENT) {
+			dev_err(&dev->dev, "Failed to get gsi info! %d\n", err);
+		} else if (!err) {
+			err = xen_pvh_setup_gsi(gsi, trigger, polarity);
+			if (err)
+				goto config_release;
+			psdev->gsi = gsi;
 		}
-		err = xen_pvh_setup_gsi(gsi, trigger, polarity);
-		if (err)
-			goto config_release;
-		psdev->gsi = gsi;
 	}
 #endif
 
-- 
2.34.1


