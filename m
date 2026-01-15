Return-Path: <stable+bounces-209956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B874BD28743
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 21:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D656D304B3E0
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E312C11E4;
	Thu, 15 Jan 2026 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ITus7f+L"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BFB30DED8;
	Thu, 15 Jan 2026 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768509485; cv=fail; b=OyBMLc8omt4QCyxfduoOMARyoOSLDM2yda7P3CinAFkgtaPsvuAFms0Ii9iwwJ+Xxr71+uQtcHd65l4fsOaaItkZf2198UlicJEcKzApYhV8QCC/wbRRKDwOh68HJYI2n2c515rSYrRSuEOxiTaOXausGYm5cEaz/+qXGsCc/9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768509485; c=relaxed/simple;
	bh=A6tjc1Vrh/vvLRAz8uOMS8N1nQ6rBEE3Eley291HxKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uclhYAusTAj7TMZEljUhS9ZQ1Bu7SCXEy2V4g5czw7okqYRdowso3LVtw2D1dXE7HCnmmbTSfdmgQ2AOy7LqYv1ii/s9thdNleCAe1yHjqqk48mAFEPZbCWsxw1VcOgmZXJ3XdV4fIW+HRSzNUcOpijG0FcTeCJBbnpdLBAojVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ITus7f+L; arc=fail smtp.client-ip=52.101.46.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8ZYf4NGhGnpcFnJW3UAQaa0cr/y0JBZ5ZsJtLBmsVNmmaDIckvI1E5cahXJ11OUyeHo50sjoWfrk5X9Ka1atzXIj6IMU7HmUpvwLvJ4HWwP+CjX+JFYBl0Um8FP9oT3kSYeQuu5JzwCGdvKXNguAgF2jaQslfO/TN0c5rXELAkLnH4X2Atma0YVc/6zcwBUzMJnpjJrY4YbHc6ZouwvCAsk2pF7Hcx4sxduIN5ze0P6m8tZp4hbeUJuZwfNnlCL0IKetwFMaiKmRfoqhShntN3AxIwQpiYiB063xvgptOyWG9ad0sBGYgDfwjR3fbIIKT9jBgsWgn85jSHmEQ+5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=un61YU6zOBq7LK+DnwxVdGQJFtEU9XtKBKAq5Imx+BQ=;
 b=bj341qvyg6wtTVRmNuspWeOx0ZGOPCAQ4LX+dlqT8mvFQxe61DW5nrPrCwRPMp5iQkQYtszS8YUVI1U1QOorY/lmzhW6kCc7BtHCrmw5YZvLZDDb1UPWANTdCe+4Ol7/cHIPyqnoNk7+K0GzT6EvsdZrXHY0U8BzcsHFPTg3aYVPmXUxkE6T84X7Qc6V3bFlWcy7BpvKRUqhGXooImKAoQFqXbTp4SaA6ZidZVJjvBqeHTbZrshdR037us2nqLZaFJH0UhEuh8N5MRhh7xsb9ZziHFaoTJrWewL5S/mr98fnKtz6LG0pPk4OIBJuiPI1dmA77w8hG35QBO7huVGW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=un61YU6zOBq7LK+DnwxVdGQJFtEU9XtKBKAq5Imx+BQ=;
 b=ITus7f+LAjC4ETDcpRpKhLYMDbKudsOf/aX7VmpA4pP6TXYdii4M4QQM3KFiU3T7JSB1V8v0ulZg6Suy77fqtpntaJ+1bmcn4Ze0687xjNDtDLl3kx6DM9N47mhARgWTTMOLyuvyhoJ4tv0iXV65S88h1dqBlgkebTEEe+BC2Gg=
Received: from SJ0PR05CA0161.namprd05.prod.outlook.com (2603:10b6:a03:339::16)
 by DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 20:37:56 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::d4) by SJ0PR05CA0161.outlook.office365.com
 (2603:10b6:a03:339::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Thu,
 15 Jan 2026 20:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 20:37:55 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 15 Jan 2026 14:37:53 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <hansg@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <jorge.lopez2@hp.com>,
	<linux@weissschuh.net>
CC: <stable@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2 3/3] platform/x86: hp-bioscfg: Fix automatic module loading
Date: Thu, 15 Jan 2026 14:31:12 -0600
Message-ID: <20260115203725.828434-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f3afcd-f3e3-4f23-77cd-08de5475f6c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w7KNTy5tjxk1oUTMO5kYNr7KFySUz9jzwXKIom04JpoBJbCwvo3pu6Fc2S/P?=
 =?us-ascii?Q?enncj5jymHo1INcd9J2vUq3P2rWK7N9YycFahPbMkjkBxsG5U2IQzE9UeU3B?=
 =?us-ascii?Q?Y+MTiPRWLod64tBtGFYfqm5s3S42kHlyLnUJsNsxgGGMa9KyGnYH3BoFz6ZR?=
 =?us-ascii?Q?6DPdjN9gUCz89A8sMRPF/CbhkD+92CxNZxqosPlaFsPvfU27rWqnqr3/y3Z2?=
 =?us-ascii?Q?HmgSKMzj3+sO6p9FMzOuEaX2EtaS069zMYTbap4BGTmFAUTigV0Zmaq2Gx4d?=
 =?us-ascii?Q?+TZr44sPVP2K2/BucjkRnjNSmaYfMIAh9fMPMrNtlR2SZWLN/6SDvwKFUTKT?=
 =?us-ascii?Q?u4g8LP/roPCtX4BKad7G2gygFdSIV7zBdM/x7NgqN7Rp8c6py/r9soVVNGZP?=
 =?us-ascii?Q?oPXDozbjabiDofmWaPSUSEsZGYNuq6s/M7s7yqENSxHcUYH3vP5BLDWZgYdr?=
 =?us-ascii?Q?/gJ5WHD5JcWCJX/HVCqlIXnwmr6UBDa1Mg8NYgH8BYPfs7zTtpI8BXKply/Z?=
 =?us-ascii?Q?/8xn9PZJWiqa1rPd79QHyQGXpd2NEPx0AtZ2GbuKFDMiA0F+nWPuAjMXh8cs?=
 =?us-ascii?Q?P+Hvwjfb398ENLJ54utRnqjfjY2iXVkEMLrSMjdaOoR56rSw7qOWiISTDEGx?=
 =?us-ascii?Q?xCXQO3uIB64PEaChgJoBEnFAMvFmA//BxV/y5/1ul1YDWMtFm2KjS8SkzxP7?=
 =?us-ascii?Q?vVbHDTNqUr3NN7kOj5832TdJRpFGheBNWTfSBJQ8EHNEIw2CgFXvXu8mHEQG?=
 =?us-ascii?Q?IzrpH3rG1lNwRp/+2tDYJJ4BQu8F+W8VFAOIa9MauxP2O4ZOS/56dX/N1Yk6?=
 =?us-ascii?Q?Waqo43suBLNwXmcWgibGNr/4UrC0zkoBP6wKR3UICBVCpO9TdwO94iqp4rme?=
 =?us-ascii?Q?E0Ex1G7EwbZqXouPuoI85nbgxyYbkYMHra9UUXCXvxnjMlFI8IzkQnIMpZjq?=
 =?us-ascii?Q?hAb3exNpMV4X0DuwBnYjAdkHY9cFcn9qBzN1l3HlpShwc6dSnjVZQcKP2Wug?=
 =?us-ascii?Q?ylhNqcvFixOJiP4xQpL1M5AIQJcJqlFNe7N5CLPPNCPbpPp/YA9r303m6Bkd?=
 =?us-ascii?Q?UoujJT5NcTru9SY7YWZ6OYd5zsfp7l5EzTcykjR3gTE4mBKyyePtHfQQw2Tv?=
 =?us-ascii?Q?APxfFLVHHRkZr2jYy1Omiy6GQFqWNdt1HXhwaMnKA3Onqx7LlvrPuxK48Nfj?=
 =?us-ascii?Q?jpJSeew1nllSBAKXaTXe9r2vgjkDHKRJYKvGwYUMUhL+tqJg16b8d9tKUtc4?=
 =?us-ascii?Q?OczibE6ZqjE7x8VVXtdjSzHr7pDebagElkkd5WIIUmfUME081tQBh4j6mQvY?=
 =?us-ascii?Q?nSnyuvD8vA+44+j3hIUyoLv6X7tRBe1N69peceXWaR2hLN9fOUW/5cf4gOus?=
 =?us-ascii?Q?CbO+AuTWLNWKgf/5STyi3fQsaAr+XSBzHBFFR8UxSyEjI9YN1KuvL0cSHcft?=
 =?us-ascii?Q?J1ZEK/kCSUHfAz+GM6aOe34foSiEXhAeOj8KsLOyEaj6a1PS1s4+mr4JNGpH?=
 =?us-ascii?Q?qSlf/s4MY8l97doGG/kgMYkOsWg7ksniy/tTeUQN0jKvqVDpc32MLwCdFVFb?=
 =?us-ascii?Q?IUlZu3QOCJ3tR82u3mk78043eG/qlTciayr+G71N+kgbda1lMHIFuHDgUVrk?=
 =?us-ascii?Q?zkSDGptewFWp3WIoGAsTreg3FgmFhDXo1tLLA0yV72e6P+8kn651yDrawzbg?=
 =?us-ascii?Q?1RfU6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7142099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 20:37:55.9895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f3afcd-f3e3-4f23-77cd-08de5475f6c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274

hp-bioscfg has a MODULE_DEVICE_TABLE with a GUID in it that looks
plausible, but the module doesn't automatically load on applicable
systems.

This is because the GUID has some lower case characters and so it
doesn't match the modalias during boot. Update the GUIDs to be all
uppercase.

Cc: stable@vger.kernel.org
Fixes: 5f94f181ca25 ("platform/x86: hp-bioscfg: bioscfg-h")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
index 6b6748e4be21..f1eec0e4ba07 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
@@ -57,14 +57,14 @@ enum mechanism_values {
 
 #define PASSWD_MECHANISM_TYPES "password"
 
-#define HP_WMI_BIOS_GUID		"5FB7F034-2C63-45e9-BE91-3D44E2C707E4"
+#define HP_WMI_BIOS_GUID		"5FB7F034-2C63-45E9-BE91-3D44E2C707E4"
 
-#define HP_WMI_BIOS_STRING_GUID		"988D08E3-68F4-4c35-AF3E-6A1B8106F83C"
+#define HP_WMI_BIOS_STRING_GUID		"988D08E3-68F4-4C35-AF3E-6A1B8106F83C"
 #define HP_WMI_BIOS_INTEGER_GUID	"8232DE3D-663D-4327-A8F4-E293ADB9BF05"
 #define HP_WMI_BIOS_ENUMERATION_GUID	"2D114B49-2DFB-4130-B8FE-4A3C09E75133"
 #define HP_WMI_BIOS_ORDERED_LIST_GUID	"14EA9746-CE1F-4098-A0E0-7045CB4DA745"
 #define HP_WMI_BIOS_PASSWORD_GUID	"322F2028-0F84-4901-988E-015176049E2D"
-#define HP_WMI_SET_BIOS_SETTING_GUID	"1F4C91EB-DC5C-460b-951D-C7CB9B4B8D5E"
+#define HP_WMI_SET_BIOS_SETTING_GUID	"1F4C91EB-DC5C-460B-951D-C7CB9B4B8D5E"
 
 enum hp_wmi_spm_commandtype {
 	HPWMI_SECUREPLATFORM_GET_STATE  = 0x10,
-- 
2.52.0


