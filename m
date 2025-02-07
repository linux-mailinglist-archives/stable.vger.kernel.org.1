Return-Path: <stable+bounces-114259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32D8A2C652
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 15:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749047A5E8D
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 14:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E497B1EB181;
	Fri,  7 Feb 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b="o0Pf4mO2"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2115.outbound.protection.outlook.com [40.107.20.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9411238D37
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738940153; cv=fail; b=h+/wnLCP1Dasnh5hVgLAIBrRVM1UVXfpbzOw5+2+C7f/wV1JEZAqpQm0tK+wveacyJhmIOCKpmqzy2v6Su9FtaOHFoA9JFXsTSBr1pbm5HdsP/AcoSSbMEFyW3joxLbnkdDnDPZadrduwCVzjlnz9UYUDQ7ZXvqc9tBYhpXBoKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738940153; c=relaxed/simple;
	bh=YoAXxJMPX2p56Ob24C0Kv/X0F4ndoqzQVolVKFr0njg=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XcDBfzgUTxWPbYKl72qYJPQ0w7l0LosRlT0LE5yLZKfcc3iZNJ7obPsTqCr8mCfawW/sAzCYWj+4WoUV+JP32NossIEjI999eiD9KadWYpZeo6hhTtgt4cu3Bf4Ak9/g5+u6kCh+cpkDPqs7xyQtx5RDzH5goEEQaVxNH3rfXDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b=o0Pf4mO2; arc=fail smtp.client-ip=40.107.20.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnyTZ0z30BK1DnKAbf9pLLqOTbN9ox/46dzW6bpC51nAIF1Kh+awSVhG4fY7Xw3GU1Qt2EvDtkX6EjTdsvM3LHJJlSipo9Ma3HejSKaNTAvbm9e4wkhQGFllcxbhsFMs+LpmMX3uFVPor2u1ZCUoWw86TguSY4hGG5Y3XeaecQj0kcmU/8D+xA5vnIwK4RpbOFBa4UfLZ5u/fK0IxBKwxCXFYwpTtljuSFCg99F1Jm9shRgbk9hnhZJ0HAsGaUpokbVMtgE4cgRMEJnK0ln7Cmkpm++hlrfmlrJC/vPbaSCZpnyBY9vMNgg3vJlvEAh8MJnMfP9ok+cTJw+nAJCXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVIpXs1kZeGIOn2V0NbGrQjyDjDuAfIibS1IX+IJW6I=;
 b=IFYG3xSMcwRoPR6Vln7a0eNDg80yIJBZd3zQITsidfD3zn0M6d6bbbm2rGJde0NthoeZlSFIO5pb5/X6K0ajmbFwjhTKsnCxcBgkeb8XpXTBTHdsm/icgGrit6a8NKzxMkBmZ/dQc9Q4npq3ZJB06HzhKjvTpj4GMVo75iL121y2aHZber48cHE2Mn1Lk3CQHtOZFXhtTig2mBPbFzupBb/yzedrmVHpyYreCnDojYIO1d2ltNc1WcKK70MPRRmzt7Wbt3hv+X0MSETWxwC6yTGuJzTSE37qOXEbxceIF8iy2HDUNbApvSKJ+Nvm9gtA6tWwj9fB4rAOKiEW47g8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=WITEKIO.onmicrosoft.com; s=selector2-WITEKIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVIpXs1kZeGIOn2V0NbGrQjyDjDuAfIibS1IX+IJW6I=;
 b=o0Pf4mO219gQunaqJV8UQ95euGqSAEI9ExHKPb7wTchAQ78gjUVrsSE4WFm1yhTWLyu6bM450vlMRzDLhrdzLjB6WauQBPhpauFOIm0e93kFdP4z1F/Sed1W6twNFI4HrwY8WyKmf5+oWavL7ap5unNpa0aKFZwbud+6KDr14H0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from VE1P192MB0765.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:14a::15)
 by PR3P192MB0666.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:43::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 14:55:46 +0000
Received: from VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 ([fe80::9356:670a:78a:d38b]) by VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 ([fe80::9356:670a:78a:d38b%5]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 14:55:46 +0000
From: vgiraud.opensource@witekio.com
To: stable@vger.kernel.org
Subject: [PATCH 6.6 0/1] Fix CVE-2024-56647
Date: Fri,  7 Feb 2025 15:55:31 +0100
Message-Id: <20250207145532.2503951-1-vgiraud.opensource@witekio.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0209.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::9) To VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:800:14a::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1P192MB0765:EE_|PR3P192MB0666:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d2a3b4-b1fa-4167-5f16-08dd47878063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8h2baTJzklias1AxZEGT22w/0pmc6K0vnPFk/+pwurP5d4USdGt/HbZ/LNUp?=
 =?us-ascii?Q?s8l1CQ2c4bb/9b96pq1/RMQXsd1NFKvWF0DJ5TQY/LzKEnTKuq/YEz//cPgM?=
 =?us-ascii?Q?Fy6R0vAa8LgbV0H65DIFdkDuO7x1Ueo6H/rIYhKlEdzIZx1kPkzLhe8HFyyy?=
 =?us-ascii?Q?U6XoV5kqBT4F3u9NhIFgWJTizQOLTVLBpmZk1k43hftWLGBgevMlv+xK85+l?=
 =?us-ascii?Q?sQUgzl2e/3dsSIgvwNF64Vu8lSiplmC2Yt5KbdwkB2blrnsqdyhfpuc5Vw5k?=
 =?us-ascii?Q?Wx2n6+0q4eaOIEgM8dKqchiqJ1VxlX0ZSdwfWKSrs/r4J/D1NwZwNXCJ+yxl?=
 =?us-ascii?Q?5hS3/LWwCC2am0Hf3MTC+Wz5YUKcJ7htqT2DceWRGeIr+8KQV+jL43/AmmuM?=
 =?us-ascii?Q?4KSqbAQS4eG5l8s4PPQ8ISQBX56H/ZiwJueRLhTxEh/cygxwPHeOFslO1G6j?=
 =?us-ascii?Q?QEsRGFG3eqF2m3D0g/aJ0z2LSeu2VEzgEBhpVLeQv1YoFmNwXbfgE4jtFPwr?=
 =?us-ascii?Q?CBEJauWrLC0h40X6CS94CangbnYhf82mIXSpOkmTKm32j3gHxvVdhBk/BFYl?=
 =?us-ascii?Q?uad5wKnxexuJVsTFZlriVrtPczwv66wPWQgDf+CYH2w/vpuyd58hcawGrkFn?=
 =?us-ascii?Q?oTQDJUDDx9sttKiXYxlgGeNOsPJM4+TQ/M6sSSv3lj2cXW7LHhDUQokrVkZk?=
 =?us-ascii?Q?1AbGiJKaOJ5F3GNX+P0lN+5CdPKhLJYz7c464G7yD4bdEkJyZhNoVxM13V4z?=
 =?us-ascii?Q?lwBVT1FsSmQQuSg9HTke0sOvPvu3oJuHJDJfwpXUk5qPYFTxvXgW55uQSlSb?=
 =?us-ascii?Q?qlmE+Z4Z+JbAVv1p7YyRwhlf25TfSHhZKa8ik2u30IjSY1inae9dazDGIZTj?=
 =?us-ascii?Q?q7+hRiCEFeCUq8NSUfxv+m+XEUa336b4bAUGO1WLDv0v5cAUjamJML8TBC4C?=
 =?us-ascii?Q?Y3vIje44KOtaAPnSv97vHLAvIK5oq+PHSWw7qZLC9HSLhGvmsG2mJmXdAUk6?=
 =?us-ascii?Q?5MOrcsQWquMRvu33PTl/Ra4Pa2a0T5imnnw/OY/OG6lItS5KjflXEsE7t/ip?=
 =?us-ascii?Q?6ArNZLVr5rCF0tLecLY1igveie7lWozheLxtUJNqC1MqeKZbKXE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1P192MB0765.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OL26/4xkNSXF2vF6E72YVz7xBmVWYcCqhVc72/U44wIeVLvv5OdcO0GOvzJF?=
 =?us-ascii?Q?Wnx5xfLyK2cRBkWWf6qxLreQeAzNxlhVMxaQeAeHG45YNGJXwdwNgPAlekef?=
 =?us-ascii?Q?3F+NQJ2i9HllF/5TPCKXwrvYpvwNHaIyuvRFT0IpSu0DPbzI2gOfM2qY9gvH?=
 =?us-ascii?Q?SF0fAzVM1AY1gU56sKsp93OPDuI/yJHGcwvYLnQaHnzzlZlnJ8d80xSp0p81?=
 =?us-ascii?Q?DdtEKQN9SV59vmCaZVV7+iuCXUMCqc4pEt2RPvVYOH2imzKWPwGgmYVo0c1L?=
 =?us-ascii?Q?gFfiB6iNVLlkcchlyeJL+4+xTjEW4oZvK5hdPxOPGgbPbKHfuEBJZsNB038e?=
 =?us-ascii?Q?4yYw4ibZ4xB5keJfNIGXbMUnVwMs/LPR8pkimVHA7pgFeodYTxcvmHGNsn2V?=
 =?us-ascii?Q?0fOWMkSmC/iPttZJR6goLEXqysL+Jme3UDRro3NzeAifAlbARf4iki7HYG1I?=
 =?us-ascii?Q?m+wVVYkXl+l3m7C7EXwNvyaIKRd678Zax4rlTUY4SYAcVb1s2AOmHkm5IWuy?=
 =?us-ascii?Q?PvNajmSsrfKmJrCu3avhp8skvbUC4AOj79rg4KEtjCHqRnJcMS3myF78LdfU?=
 =?us-ascii?Q?J6JGvedaK4jmGdBLXZtD9qfIN3B10KFHS9jC63FlXMajA8YyHt5pSvDZjcf9?=
 =?us-ascii?Q?1IZmTgX/k/9ZP1vTHWPAFuvdOCc8w4A/7SUmYj/70gQqeZ2XuR0AqKULIT0N?=
 =?us-ascii?Q?0fvesVc1fpR/A3DH90hJFtHWgp49EIA8NFTElmJIZtKdqRDVlNzBQnj45zei?=
 =?us-ascii?Q?k5LMx/+q6rhXb8v9KgR/nk7ar3Hg1QiUw0tgehnAkAsNE1wTKR5+yo/c/79g?=
 =?us-ascii?Q?kmPR/3ckuJ2Dan/gaw+x1k1vvPyz/VwmbyyRQ6w0wXq/ITr8eyZdi3YIUQsD?=
 =?us-ascii?Q?0sgsxeQeNX1wMQjzwX0KFl10vShSnwyO/xa3ayCfLikDRH2J3BwOSXR5XR2L?=
 =?us-ascii?Q?Hf9s6hu1nf4kQyLN+IbjQCMOP8r6V5lCjc+iP/PWwBb5g8Di8OsK+PEGRVg8?=
 =?us-ascii?Q?aQt7t1hMeBsChaI3IRI+q6tQWu8jAU900ZQZkUHBAZstaNIMRBHMoR6LZjzP?=
 =?us-ascii?Q?E891QUwV91eCvpvD1EUT8ZP/bUQDA31Cki3WlwLRT4llRnzHoQOcgMq8jgQE?=
 =?us-ascii?Q?JSESBTF591S34ZL9qKfU2aYNx+JeL6uTIT5Jn0XnwIoir9r0UNimKJG5zec3?=
 =?us-ascii?Q?YrZ4tLuYOllzuKCwmvZVeMzVdeJ5MW0m3f91lVADRokGx31Q7sfcjV+Y5TEB?=
 =?us-ascii?Q?wt9sUnirU86nMD282oQLOauNaTA3TfARvMx3lHVkqVgyglQFJd0/DrVpN3th?=
 =?us-ascii?Q?UHD0ZRqo1FbR25BZ6jSPfim/8f/NeRCZBrKfowbpVO2Rp5pdhv/+lR1hvT+z?=
 =?us-ascii?Q?Rci0xQXtVpk6Q01xYHAsWnxc0w4Mo8WDDoUrF3ZxntfxM3JGwPdzSqfG0D8a?=
 =?us-ascii?Q?S4JSlXGb4iSc8DN4OjDgXAhRskieA+1MOd/nk6ral7OkQc5+1JPtbm0U/NpW?=
 =?us-ascii?Q?bNor3lAUYI9gmBE+epCG8iXcmysAZViNrQzMNM9OLIenVEI/+hkNNduakZ5r?=
 =?us-ascii?Q?A0flSRl8ymvmsGTyx9GRidMs8rqxylD3TODNZvZTtDbwdBAmzGeg2TC8GU3B?=
 =?us-ascii?Q?AcaLSAdF1+SaIWih9vG9xSf/t/bdTyNavg6nId4GKIsl?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d2a3b4-b1fa-4167-5f16-08dd47878063
X-MS-Exchange-CrossTenant-AuthSource: VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:55:45.9361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zgxtWhXLF9M0NEx86CT2chuECxWL+S36ZamnH7H1MHUyL5WzEo35HrinWebQjM51WuFh54Vj7H3F8NCKaJRzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0666

In-Reply-To: 



