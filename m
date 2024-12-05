Return-Path: <stable+bounces-98761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA219E50F4
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25789162189
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950141D5CE5;
	Thu,  5 Dec 2024 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QzDpmO9s"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B3A1D5AD1;
	Thu,  5 Dec 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389947; cv=fail; b=tbDHmc1F6J2IxdjHeuxHzn6dehrQUoeG4U0pfaneLx0yBkgkS3if02ODFtsEuaMyqYHSQnPEUI+aD7RMCIOgx+TQnddLeYEYgYZW07s/lsFXNRmKKyhB+evVRW9kPppRdpFWzgdDKnKgGaDtYCsZ7Oh8hwxFsJor4U2Px7/1LRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389947; c=relaxed/simple;
	bh=BRDHLdx5g4DrQHcO5B44ke0PkhayCcBrD9q9LVAH4nU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AhaG07qPVUnWXst9R/NaQDQAlXcXClvknEZmNslhgEgPSPgC8hmhoxAzCEo8JdXTk+rm0O4sDorkFd3by393FXeZC/fviw47SrSO2Ey6t2HbD/CtNe1ZdbOf/CRjOUfnVQbva8O01Stq8tMwtv+2oDi+TnMQwYIH1fD1d6cgljg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QzDpmO9s; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piGOPKZnSAqLGbagrXDLL2Sft+QxW9IgVOQblgsc9NO2pmnwCmJYbxmu/6zLgSk7uCvTrLZcBEOum93rwz3QJoTRfQGdhOWhOnVkGwufGuLU5oiTBmNwZ32QzmQ0LXstUmRmN8160+wuHr80xLag/jy8r5ylJTzyC8UnxZYXLHKf+AfVvGWpmFPKN2Kb80XNq/Oon8658buSLO2u3L0YAGrXY8wR1K+6DflgDRh2woij4x5oMrY100az70HGWZA9J/PjiWzOFSQTklJaeTiFQJYwcdlbo1z7cWFseohENQQDaK2+4hxSvq3Yat//0YoVxHmAagbHfC1BX3aYXgDJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LD0977Ixbg0eBsI5Z9nv/JJMWGO1qmwdS+hNIknkppY=;
 b=RfivVEg4FT9oidejvKeEDuggwqls+7jX/RJkwShweV5QMv5uprq7NuwgkNwBLn7F8nBfTnrKFUtKSFy+phaCwwqRJcc29ETC/V+8KOuWNLJDHwNeIe9h9JDtA9z0t0dRAw71hHV2GzDeNq5D+nHV+60yw0NS/mbXluQSnrfjSfOzlB60jw2HQCUlcEQZLsT3dX27H5UUACFKen2wMuz4NJzHlLouFOXUfBf5MdScp4hkBljhgiwJ6AzSNLnnOouR4PpFO8LtflG/p8u5dXxvVTz7ql/rYYsaF5zDzMDXDV7+R3efROqUZWOwsXlPvGK6gKBGE1EmcMMVTPrus8UmeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LD0977Ixbg0eBsI5Z9nv/JJMWGO1qmwdS+hNIknkppY=;
 b=QzDpmO9stvE2LoPRTwTjBtQKe+T4aTkuf3aIqLxIeHQqmmXoAbkYZZu8aukuIu+4+OTzAyrrqK5gRBnS+J+7Tvd/PVe5zkuHKP6/CSUBTxCy+9Ej1SWaRSYCbaSbvoBnEIqMhjtJnudMwfBGC+78NqcV2XmVSFjKA1AcUHswQyj1FP5fAwAyQbQ4t4kW+Mf4OV9t0MVnU68Jk1BtJUEF69prO9nw6fuqzXoHE6eOCO8Xlhb+Yync0NE6EtbF+3FVVuTwx6M1r+HdQysm2Wl/VGz1KkAi7Uo/I5EhPZh63bdAcwvYoe8OFrJw5t8xgonfvcF8bnyc39gtQOX85yo2pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 09:12:22 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%6]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 09:12:22 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: gregkh@linuxfoundation.org
Cc: stern@rowland.harvard.edu,
	mathias.nyman@linux.intel.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Wayne Chang <waynec@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] USB: core: Disable LPM only for non-suspended ports
Date: Thu,  5 Dec 2024 17:12:15 +0800
Message-Id: <20241205091215.41348-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::6) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 84dd18f5-4793-4a8d-9311-08dd150ced28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pKgl+4p3SB8T4NoRhb2pvJehv36aLTKjcfqnMGF75LG+Jg3j6pYvSScfKn45?=
 =?us-ascii?Q?qsj8eRNq9lGQ1oW/iIAq6wcBVpp7PR9qO8GYF7/G2q60mopDLD6mZCH3Kvgm?=
 =?us-ascii?Q?bpM21hM+JVvaI5gjuUu9/gBtH8RWEqckNTTqPODR2PPvSbdWgpgIN9zk4Ajj?=
 =?us-ascii?Q?elgMLiXXNmex8+Gpu4w9ameRx0MwVTpk6XCVB+w6nilzlw3sYndowomJIYRq?=
 =?us-ascii?Q?eoyyy02QCwJwXhp5tyitQE5pdVA0kN7Ww8M/zujrI89j700tEP0n6KZaif+Y?=
 =?us-ascii?Q?VL0HTJRgM4//XExBrJu8Kk434SzP70gAxdJ6msID+n2GYN8sNsd6EnUYzAm2?=
 =?us-ascii?Q?zO58HTy4N//1y/oOLp9f9zbVzK7xRfKKrt0hRQ6G8nOnYoxEtyyMv312AUC7?=
 =?us-ascii?Q?Kd7uRPLWaQYBMw/+kLI2BKZvOfBiFb36eyU3fOKfnXi2/Zzajnegxn1b0CkR?=
 =?us-ascii?Q?gHmL24Ds500GJ4CTYbnbtwOJqli/POgk/yVGyornUapigAaISK5OjE4G4o38?=
 =?us-ascii?Q?Unlub6X4Qofp1FTMhN7+pwUMpq1hsmp9D0ZgbWqD56LLkba7yu0IUru7ER7y?=
 =?us-ascii?Q?J6gWLIjYrlLEACFoGI46h3lbcMfEfZEJIwLDIo4QX3FVS4CuHvSMPvUb2Ur4?=
 =?us-ascii?Q?kfbeK8TbzbaJJgq1bGFJRau8CJ1q0ZRbZobNUQUsQWerlaltWNl8kbHelJeD?=
 =?us-ascii?Q?x2Ye9gAUfhI78z0kMvsm2J5eSPqpp3d9VBIyumkOd7ImebQcp3YA6/ispsKx?=
 =?us-ascii?Q?nFDVxT6WKHr9Le81NKrOk0UGIG+aFRbjnLusaQdHtxNiOx4HpzhAEZLwrKWz?=
 =?us-ascii?Q?Qb5ZjAr7gST5Jmdrnx0ZxKJG7kziF1ZZhFpUazylaigMdNQrhTyyhYQOPej+?=
 =?us-ascii?Q?Fr59yivLTeJbkbSvmxRxDyUJsGF7MjitLYO/UAED+qdUe0q4TpJhm9VDNa+1?=
 =?us-ascii?Q?twPLNv40wtmZmIDvULfRveoAoDdlp5Fd+zE3drfL/uNpkGGmnFgWudUgGE8I?=
 =?us-ascii?Q?wdt+TUxHvGkI7URqNyACeVSYm3ljp6KhhXQ+QTr1waQgCa1/VmksJRHNP1PM?=
 =?us-ascii?Q?FYmzyR6r+HMnbGBuJVA+2o13iB+glVoajiOb2KkDh+3nFiw2Q8ephiL48k/d?=
 =?us-ascii?Q?PNxF+E2IO+inVoZR1kVku67pNC8O1zPopz1XYFcNI+uwOYnNshfcedJjKX4X?=
 =?us-ascii?Q?auyl1u9ONpxOtqtIIYiAcC/3w63ZvMvJpu2kbBmCxkeZWyv//gQoMWlEii1d?=
 =?us-ascii?Q?5H0j836HSw9VPBf20YwzgjGEBFPMS/uCU+SRcim+A+Ol9FmGVu4isLHESOw4?=
 =?us-ascii?Q?vuBv+p9B+cNgGmSrsffSL5gAZR/cWHEDpDmcM0IiSTwV4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oPf7gXfbzI7N+uA60YSIaE46HK3nwd1tGqztckQwBjXM7UCfUWd7uIiJaN7y?=
 =?us-ascii?Q?Id83EU7jrN4BQp28+A1UF3pXXtjoGAVh5YMo3bKiHR6sb0+b1GE89paKIQXF?=
 =?us-ascii?Q?MxcqtifUNYHmQ+5+dMUKOEjhlQKr75Ecaamn2WOCMx0isewLE9xshg4YUCaU?=
 =?us-ascii?Q?MRfFiJDEXd/6cjR8m+CYnFCv2V7DrLyWEjtqCIyZ11/V9h+Jyizy8L60l4fU?=
 =?us-ascii?Q?Wyk+XC0EULhvjYDZiJmdGE9apfm/TyyODVVmBryC0K3u6ravXx9wsoD2YjjW?=
 =?us-ascii?Q?ZJ+qc2+gBMhZF6ffRklZJww3Q+OxWxL2NCyNbZh6ClVrfM70MFUh9k3GeIMO?=
 =?us-ascii?Q?K51sBdnKEtpbEPnPEzGzoTF4hMGidoXU3YqS8Ex3YmscCFTZljBIHrfQP8qQ?=
 =?us-ascii?Q?M0KFOq7kzm1aeZzGxQgff1uAkQ5GGBtWIL7CM8hQ6kPPz4nrk7SBJwPIcfti?=
 =?us-ascii?Q?ATWWj1Y4EdLrB9ibgY8kEbt1Vi/MIrEJbR2IBR5RFT35NoXq3kYtimILP0Kw?=
 =?us-ascii?Q?iC/2jJG8W3LL/cqxZQzwUujKLp+z1E9RR6pMbe0ET/W54OwwzuUDEyyrERAa?=
 =?us-ascii?Q?tqOq5MjKC1+q+UH70D8xOCWpz+aJD6KpIiouPPn+iiXTb4rynpgfnJmhmkqZ?=
 =?us-ascii?Q?RrTLMXZhD3METXZnIIuy716Y2YeijB9EW4fsdxMYeb89fO7O2caD900HoCOV?=
 =?us-ascii?Q?opylYG97oO7CnTIL728hInRiUNvYShHN5D7CXZSVev/Xzysk8cLtUhzitXob?=
 =?us-ascii?Q?/ewyXaRRGSsFbiXRWAJP1xMKgqLBO1K6yfciUEZm4mfaUkw/R4IHjo7D6/sU?=
 =?us-ascii?Q?VPjgxJU2BjHD0DmO3yTBrPL5I0cEF9kOcvuBaJWPW27QKs/PYhyNqD93Syd+?=
 =?us-ascii?Q?vSTfpP8TvYkwiWr9m/XLhzA/YIYK2xuoSJZX+ZW2DAUFef1OhS/N0daJdw1h?=
 =?us-ascii?Q?Wltsfyh2CmZAtem+om6/eymwpXuI8Ie180utwoMJwuCKp0v0IVdokyONfWXh?=
 =?us-ascii?Q?wRfIHfMqovN+8DQOFywC+AdllPVPQk5aVCdg6pp4FhT1MaFJmFRJJqtYMa+f?=
 =?us-ascii?Q?KLAxrbbgTYXIqpgwvPI6CBauAWgwgN3FPrMfZ0nW6Hlk6IV+wm9D0KOvKdnq?=
 =?us-ascii?Q?UlaDXBNpGMMOb/5Hs+roeIwkTV1ohpCgIPDfEbkEP/sWBZNW00ZDIA5t+l6+?=
 =?us-ascii?Q?sUvRF0rmCf42ts0Urms8oZ3KCAsjVDpHTxIwbowunWNqYrMG4u2GfoA0m+zn?=
 =?us-ascii?Q?vYUsalT2jG0jZonuMC9N0EzNVeFf4zQDqYMJESct9FKDLIOhS+5PPVO63cdC?=
 =?us-ascii?Q?wQgXh8bxg9jxBAlsJM8uyFI1am7tfo9vhGkdTruyg8MEaPKh6zxm+uZ0q6xv?=
 =?us-ascii?Q?e5JsIkHhwGddIYMc3InKSlzXnIvaVFc3Pprs6z09SPEYPUnplwK1l+iO4N3Z?=
 =?us-ascii?Q?OM2KGW222VKpeHCAvzXzeZXu4pwPBLzDCF8F4Lr2rnWErDrgHOamD8T6CkjK?=
 =?us-ascii?Q?QKUiEpGJkx+nm/3O3KQLOfRoiC8mLBKLwTN226RnF2YklLE+2k/VZsh64GFq?=
 =?us-ascii?Q?UGW6ZF5uGTmSe4zMQCWeBxhucEWCN2BW2AgcVFHS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dd18f5-4793-4a8d-9311-08dd150ced28
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 09:12:22.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4UjBFSy+SXSktUgAmbOlSAgPE2GZ5P8UPC8jR6VVfYexGQzVQhBbPNPw96/cMMkFTmjVTjdOPXLEgn6T4v1AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958

There's USB error when tegra board is shutting down:
[  180.919315] usb 2-3: Failed to set U1 timeout to 0x0,error code -113
[  180.919995] usb 2-3: Failed to set U1 timeout to 0xa,error code -113
[  180.920512] usb 2-3: Failed to set U2 timeout to 0x4,error code -113
[  186.157172] tegra-xusb 3610000.usb: xHCI host controller not responding, assume dead
[  186.157858] tegra-xusb 3610000.usb: HC died; cleaning up
[  186.317280] tegra-xusb 3610000.usb: Timeout while waiting for evaluate context command

The issue is caused by disabling LPM on already suspended ports.

For USB2 LPM, the LPM is already disabled during port suspend. For USB3
LPM, port won't transit to U1/U2 when it's already suspended in U3,
hence disabling LPM is only needed for ports that are not suspended.

Cc: Wayne Chang <waynec@nvidia.com>
Cc: stable@vger.kernel.org
Fixes: d920a2ed8620 ("usb: Disable USB3 LPM at shutdown")
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
v2:
 Add "Cc: stable@vger.kernel.org"

 drivers/usb/core/port.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index e7da2fca11a4..d50b9e004e76 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -452,10 +452,11 @@ static int usb_port_runtime_suspend(struct device *dev)
 static void usb_port_shutdown(struct device *dev)
 {
 	struct usb_port *port_dev = to_usb_port(dev);
+	struct usb_device *udev = port_dev->child;
 
-	if (port_dev->child) {
-		usb_disable_usb2_hardware_lpm(port_dev->child);
-		usb_unlocked_disable_lpm(port_dev->child);
+	if (udev && !pm_runtime_suspended(&udev->dev)) {
+		usb_disable_usb2_hardware_lpm(udev);
+		usb_unlocked_disable_lpm(udev);
 	}
 }
 
-- 
2.47.0


