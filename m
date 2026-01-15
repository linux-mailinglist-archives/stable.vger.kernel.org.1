Return-Path: <stable+bounces-209954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E142D2873B
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 21:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45DCD301D5A0
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5D931AF15;
	Thu, 15 Jan 2026 20:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fIXMUg+L"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655BB30B527;
	Thu, 15 Jan 2026 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768509479; cv=fail; b=WSFlK2FIDiwWZpfwXa1FK8G1Nxbukc/x0t2JSmREtcDmgxI/PL9bIf5DT3h9wMtiIHT0vKIR92hJkWGPxd9xBv8fkq1MYO4k7MLU+aM8EDc0YlftMttV8s+5yF3Vfx870peF5jtmHuP1WqZT9YEpYTc50iOxHHWqHnkq46eGVKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768509479; c=relaxed/simple;
	bh=RTSl+WYNotFOmcW0PH1+m5kNVBxq5D/sralQj4WQ03I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxU/ajydOtPPGNRnkoeGdNsGUBhC1c9NkwqFojP+3kp3UlxRGvXUkSO8xxYvwE3rnp9nMICw5b6e6/BYY6+F6LbMuCnYdZZNBTHGlSwm/DrV2CxZ/CRkVP6QffdYuFjTpLLggSvp/+13pgyK6ab22ZXnln1G/bqqHIPHGwMtWzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fIXMUg+L; arc=fail smtp.client-ip=52.101.43.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxRa5ST61HcFIa1VjAti6azpCSN+6WPqKCN3l54JGUZKWogelGrHQykEAaTBYVShPXOPLKcEFmlwcCn67VZz68o/FGrWWPGAwLfi5VmMTZ+PgXCcY+70DsLnQSs50iW5b8vtqivl7eRWwQ7xPpHruFZhaM9d19MzlRiuQR3NdV/rFN8xyQ8BqJtiJpv4kK1qu3KoYnsz2DfG8EkqVLoOqQcL8DNRbwTGUch2HwO1ySCtBkPymXHxVI/IqbJtZcutdchTB2e1MU7MnqeDHZOe5pCDIjBSk7WLelIEO6r6JI0e8XSShSgVvzV0V6GAZbsIJoCYBtg2kYbSIVGRaKTgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggNeQn2sO9VtmiX+PuSEK4aspDBa4S7w6rb/fhYSTgs=;
 b=lADOtpCD7CL9nalK/Bd5EQ0GF/1Ngu7VI2g0OYODaF18xRif924frJ5G230TD3MjG+/QAX+714O6LsW+sCSognduh52UzvqLlD7oTKC4ZXtEJxnIzQSLdAntM9R+DB5Eh7OF3UaZRKdO1BzAgRE/ymy9/64OalnJO4oczDW66d27r0eOBOjmeizSShosrBdXyl8NczRd5Uj5cwbT8yJV9DW+dsOlGpgh4mb+vUhf/YmtAfUz4WW3YO9hNQf05OlTQNYSD7Y0Na3SjRcya3ANy/Esbb/+A/wBCDyU6SnIh/fdvVnu41I3kKlSCLrizic2jvputyspvpWs//su3aZbEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggNeQn2sO9VtmiX+PuSEK4aspDBa4S7w6rb/fhYSTgs=;
 b=fIXMUg+LJNlhaHPhqMBx0xL6k7JlcaemAzD7BUaKrGvbs/BsyyrGMUMSPoXzsFGnTh05eV8lJS4YPuFucfYGTGYiWit1iOLfcOqGVvWBwyYfzk2r3d/OUi6YClR1elGBICG5/JZcGXre4v5rfIGYKvohJjv8ttZAF9NcEQUFKDA=
Received: from SJ0PR05CA0161.namprd05.prod.outlook.com (2603:10b6:a03:339::16)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 20:37:55 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::e7) by SJ0PR05CA0161.outlook.office365.com
 (2603:10b6:a03:339::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Thu,
 15 Jan 2026 20:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 20:37:53 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 15 Jan 2026 14:37:52 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <hansg@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <jorge.lopez2@hp.com>,
	<linux@weissschuh.net>
CC: <stable@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2 1/3] platform/x86: hp-bioscfg: Fix kobject warnings for empty attribute names
Date: Thu, 15 Jan 2026 14:31:10 -0600
Message-ID: <20260115203725.828434-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115203725.828434-1-mario.limonciello@amd.com>
References: <20260115203725.828434-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ea55c1-a916-4ba7-ba07-08de5475f577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lJtOWQW7Sf3jzg4fl7eRMtZClUnpgbPwr5FEK10otx9pQ3Ny4G+3QIoycD7Y?=
 =?us-ascii?Q?kzVB7hq1V+2K7wMC5N7XdZ9nZOSQjG7md+JN5PjkUzuu4tAsI+QtuatKDye8?=
 =?us-ascii?Q?VS6Ahh1T6i0/s8dpLc/fS+vMSnZTIXIvx3jNuv5vqrwzPZzCcKpB1sQ/z9XH?=
 =?us-ascii?Q?JL91m0n64ceht4LbkwFMKsxlHeknNIUyoMmRLnjjCXqxihajbvjVXsojFNR6?=
 =?us-ascii?Q?GtJVj/QdM4nt+Cn2geTqR0Ct4UDDZ/hUNnaWev0b01S1ZMQL94iJOs6z9r2Z?=
 =?us-ascii?Q?lviUWg3eyP9uZ7nNeBHpWnbiNvy6QhnplqzL9XK4dHkx0DuAksz+jIYibXgG?=
 =?us-ascii?Q?uRkyBSNJ5DEKBQOJS5u1W8mbqdqFGldlynJAI2tM4UaR4H2RGR8fwuGXlTck?=
 =?us-ascii?Q?gUrzCW3tAuW13R7YzaDdRviwscoXHfD9vQOO6yiE7k89LKPU5yOCSWA9/1TS?=
 =?us-ascii?Q?WqYuW9c8tKGzKQ3jlYrTsQrTOan9JgfrWyP1bI6jC2ZGIJooYIdfVVx0Xxa0?=
 =?us-ascii?Q?NJHkbL2f6vrK6T1Jwazdd7hePrMhlnF+GHjVqNFDvCR/Ebi+R5I+ZqqpTFZ8?=
 =?us-ascii?Q?reqb7BgKMiiPfHSdFOzeUjhTjCh3qKLunrZqkru0Z/Jhq9QnHUiX1FC4n1qg?=
 =?us-ascii?Q?Ri8aCzdf7ECOy8fDnx4q0T50kORa1ETkarBCSw1ZzH/fPBoBHcA9Yz3i0Q3p?=
 =?us-ascii?Q?rCgjnyuDCvB1IiGRKm1yAAidXFI37a2+yLAh7ObrybBqITNg7ZQSzUp4y8NM?=
 =?us-ascii?Q?+XxdCR8fCqafj+MBrmwa9QTechilQzKpwTLwCz8BXQaiPgG8Tt+/ESl0Rypj?=
 =?us-ascii?Q?8dN7+TfwqBlILYeaRj8K+rPgdpPYwF/bORTBw5s4BLHriwFVjCeLkOGbdGL1?=
 =?us-ascii?Q?FiQ924kQf0LKD/0mmP5eDqf5biFHs4SWcnNIcd8OkmZiMn5f+VTlgpRvzdUO?=
 =?us-ascii?Q?AwtDLxt3TeO/Vahz0TAT0sJqkyt+0lKwGrNfY2QCKTedj/C0OzE/+xhl6qMP?=
 =?us-ascii?Q?wgXCB8bUzsDjpkMvk1wG0QTuzW/OBdjJCt6lP7Tx/vUNCmIOm3r0fgXgzGey?=
 =?us-ascii?Q?PTodpC3+578NfML2KdhH0D5TC+R8GEX5MdTUBR1nSB3uaYYVTu70GMPczQud?=
 =?us-ascii?Q?XDTYYlWOrTRZFzOZXtBDoQc5oLRxgo5btMagIpc8x4vWqrExWPvl6wwRsXuS?=
 =?us-ascii?Q?UFjnBblRjLDhCGOHCY2rZ2Sg99z6mZiRPuFTpoGUMkqnhhNxyMqT7HZqh7Za?=
 =?us-ascii?Q?1g1F4Zlu2ht8V+l/B6YDN6s5NvcCHSiABZ8BTqIrBev1ybMWVYIaCzyxF0b6?=
 =?us-ascii?Q?Ms0P7kv8RL2mLCEfxSQTKKi93eJi3caVB/vr1tvtIaxCLlv/uMzG2gxTi0rk?=
 =?us-ascii?Q?8SyteFj/LTvrchm7vjRCH9DLhuZMxk3f8DPhJDXvwBh6LzfrJwFF+lhQ6HlG?=
 =?us-ascii?Q?x7pbzbU3gQVRkbNZYEHs/Eq7Nn3oxDZ9ouBlRxuzbPmrfTror8o69WqG/Neq?=
 =?us-ascii?Q?01UwHRdeO2EQ+9iyA6a8GMMaon6Lq3q/qlsMwlNX8Ypwm6Ebit8zWNW8H1tT?=
 =?us-ascii?Q?cRoIyGjozk94wmUpPwGX0q2rmg/iw+hBgOdtoeqccuZ2ohjODjuj+N75vO/R?=
 =?us-ascii?Q?d0BHQv32OTfRkMe+F2C4+2lhAVGBc8g+AfRmTxgOErkDPogxZHD0aTCy+IjB?=
 =?us-ascii?Q?AwGaGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 20:37:53.8009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ea55c1-a916-4ba7-ba07-08de5475f577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243

The hp-bioscfg driver attempts to register kobjects with empty names when
the HP BIOS returns attributes with empty name strings. This causes
multiple kernel warnings:

  kobject: (00000000135fb5e6): attempted to be registered with empty name!
  WARNING: CPU: 14 PID: 3336 at lib/kobject.c:219 kobject_add_internal+0x2eb/0x310

Add validation in hp_init_bios_buffer_attribute() to check if the
attribute name is empty after parsing it from the WMI buffer. If empty,
log a debug message and skip registration of that attribute, allowing the
module to continue processing other valid attributes.

Cc: stable@vger.kernel.org
Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Add missing include (Ilpo)
 * Add Fixes tag (Ilpo)
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 5bfa7159f5bc..dbe096eefa75 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -10,6 +10,8 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/wmi.h>
 #include "bioscfg.h"
 #include "../../firmware_attributes_class.h"
@@ -781,6 +783,12 @@ static int hp_init_bios_buffer_attribute(enum hp_wmi_data_type attr_type,
 	if (ret < 0)
 		goto buff_attr_exit;
 
+	if (strlen(str) == 0) {
+		pr_debug("Ignoring attribute with empty name\n");
+		ret = 0;
+		goto buff_attr_exit;
+	}
+
 	if (attr_type == HPWMI_PASSWORD_TYPE ||
 	    attr_type == HPWMI_SECURE_PLATFORM_TYPE)
 		temp_kset = bioscfg_drv.authentication_dir_kset;
-- 
2.52.0


