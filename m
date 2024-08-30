Return-Path: <stable+bounces-71569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BD1965A58
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA46E1C22542
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9816D9B8;
	Fri, 30 Aug 2024 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="T4TllRdx"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2133.outbound.protection.outlook.com [40.107.247.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11A16D9B4
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006630; cv=fail; b=CrMN2j7GVCt5857dBU4eXiBpR/ZI3JE7jJne2gVuyqTQIVNMj1P9R9fXSlQehxUQEyvQ1B93WuevYXsbKEAf5fRtgb9JIR3NSgA4wxeGUXywT3BvlbPSL97iDC6JZFPwiCXNvaahkX3jZ5BAQGIm+CjSdjzQ6nFfO5CRBKPhW3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006630; c=relaxed/simple;
	bh=ZjbCvrj3+SpA18bNRWNPa6tPAayw8z78vuKbN5Jlkq8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NyUUYow4cjp1MMzVBpbafuwgGPNZu+amymkacScUhqipPUhvU7ZNJjFQmyD2RsitnviML01ELBYmXeI4Cicb9D5XmfBOwkZoc8py0NeG5m68mKe1y9OfGj00IXUNWaWe59/LoEwFxiu/jZOxeHi41W3OSbxM0iDfIvwqp8wF26c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=T4TllRdx; arc=fail smtp.client-ip=40.107.247.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9fR/LgZ8noj0/nMmK71UCLi2ZPmCP2HXEKeC005C+jwyuWBIARFkUVgiuESb8seY9mS0u7nMR3f+Yne/NmUngcqMSZeGH8nQYr2oKAzVEqGA5m5mDWOq1JZLrVridg+6hirBysQhzFkrNNWsKhuaE2o8ZIhHhZAiZEkG597PkPekk8hQIGyYYwD+cR0Kv5ZpyeaPbZL5Iolft9plkKP1YuIHDqVttsm0Y5ukJZppIpV8p/9o0IFrcXKVLMOaccdc2xmYoTFhTrYZKxLrlqYsck/reWHseF+zo8r2pJOmg6BejWE6Oncn7MwP3ASDAZN7RTcs0/oFwk7QGbC6tZ4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjbCvrj3+SpA18bNRWNPa6tPAayw8z78vuKbN5Jlkq8=;
 b=GfeyRiTeif8qVH+fVDoOkycUU7JCqpxdfLCnLH7dOO1qho+ajRfGn8HL1C6csQmrE3+6AMbwLSXLdUMVYuMvgGaIkzg2tspm0PvKiVGPjmt4gAprWNiY5Jz+6451nub8Pqp6c6GdmMWV85FvuPlnYOJLienqonOLhtxMcGzDbP0p2PsuegPUCPRttb/JGsfaknqrLjOZs9F294azh+BdM8Bvr0oYpFEgPoFr6MOFiMGd4ez7zEgW5Tm726FUreJ8lZb+4wPjYBQ5J6jfhlIMS9w7YrZ8V4kFWbHNimqUuH6otTXeEvRzGzBsQaU3ZfZllhP8FE6h1P7DCNInaI0q6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjbCvrj3+SpA18bNRWNPa6tPAayw8z78vuKbN5Jlkq8=;
 b=T4TllRdx8wlU+NwsZqOoqQgySuArBdeFnVgdErW+Jr/rYcZFntPAcrZ5iBh2pJYDK/JDYzVXK0LtCUJMbwbLcSSA1rtGKSjjjWGBUmG4CWcGyFwJgx/V7VDPKYRYs6FEX3e+eN+rd4lzCqnSGJMJnuM8C8ryhrVdb36tLYCD1deO5qr13Y8WiB4AJqMkp9R08fCLa3+ZQ2AOMsGBBgv2HqsI45SqblU3T6wCMePXo55y5O9YA0+/Ua5LEZ8WouKJ9bQqd0SOAOttxFdcDxFqdri5blnFbSaj+tzTr0z7uqwzfZRcSnwUEAbxKLgSdNTORdj+1GgwoP+tVN2F4G0zUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS8P192MB2068.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 08:30:23 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 08:30:23 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Subject: [PATCH 4.19 0/1] Fix CVE-2023-6915
Date: Fri, 30 Aug 2024 10:29:54 +0200
Message-ID: <20240830083010.25451-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P195CA0018.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::23) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS8P192MB2068:EE_
X-MS-Office365-Filtering-Correlation-Id: 484721b3-395c-4454-aeac-08dcc8cdfe15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cWaQjkiQFro8Sb3/NZDtPzCMRtiv4ZFEV6mUbkIv0pnAx+Q5lBNDJH1fQr9t?=
 =?us-ascii?Q?G/y0QAWnKFdq/zqy3RO7WmxUL0Vn/hLexObYaKRjHgVABEkqdV6HGDuE35pf?=
 =?us-ascii?Q?MdjemjFNxAcI76xlzrVVBYlq17dz9k2pf3DV9XMKaQbnrcGN2DOoYDrQxQGE?=
 =?us-ascii?Q?KEKwSX6CbnTDjWpVy/W4J0MV9QgIbMuHqNuMNXaDw5LgkPg7c5EEYYfG7bDC?=
 =?us-ascii?Q?l1XTOwRHdW1fddxBpl3GDsDFdEfeWFhRFJE0GH/gNwvoDZrMP8znMbMCmOsE?=
 =?us-ascii?Q?HUrtabQVeQDiZzsTV34lPVw4TvEuumozn5Ave5zgkk2HYFXulMxeFBGBvsMo?=
 =?us-ascii?Q?dsOzeJadcB9MrtMywfpG26poMcm50wvPrPsLxFjhjBdfQzNoQ092ukf5Txgf?=
 =?us-ascii?Q?6YugjNSlYNO+gd909bLiGSLZw9TCu5AN5BJHDtvkdFfX3j30H0twdN38X024?=
 =?us-ascii?Q?3A/vwZCKjMjZN8d1K/oEyTBjVYsoO6Lla15WhhFNtqjihNdmcvFr7R/bt7yK?=
 =?us-ascii?Q?RIwwfIT3pnlKXGV1wzA2fV5GfeBR4LGw0GWaKB21muhMqs2Bc1/hh9B4Yxbq?=
 =?us-ascii?Q?REJ8TOjZSiEJgGdoLKB8ROsOmeklmaNVzYABWfweT7Lw2wGMtXRL14r0X7/0?=
 =?us-ascii?Q?8bmSR0l94Kwim+0C3C2UHrR1RYUaNEums2xas6caA30Jn498Xhwq5p+ujUmI?=
 =?us-ascii?Q?IhUxbXYMd76keBN9A9adueI6olwtbXu0ZdEarJXj5C6Q1HJdg4nvV6JuT89H?=
 =?us-ascii?Q?LElSdZ5wmtt86epU0OASqKkKDBpWIEbqBH+KPOC7kfdg8kDDrP2VXYUk/8+a?=
 =?us-ascii?Q?6Ae2i3FXEzEgJGBNS+9YaijHuuiq2K5fRoPIPvIzW6EBuvfMY+DMcb+82aqX?=
 =?us-ascii?Q?I4OMfV4yCfu+tw5p6o7b5+7Q8AWsEMmTCtzec2EgefCWH5Su3d6q57dM7MVX?=
 =?us-ascii?Q?ms24gFGnZiMYZs/VTpHU4VE8IxVK1gA+Loq3663Vz95CeCx48Fs1uwudahRW?=
 =?us-ascii?Q?HZGk+XtsmO9SwJHnG7Lf6b1MQ4oUxarBOte0trw1rdAfClV7TnDxPIjSdWqs?=
 =?us-ascii?Q?JWE147vNkF5J22WiSmtFjPmVVL84FnXosHbHDG6sc0uc7zQJcEeVcNSDtYwA?=
 =?us-ascii?Q?BgaBtIyF3S4WEU4jxCrr498+B45l2Db1U/EKf4S3Wi0AirYkVuQJK6Blujwi?=
 =?us-ascii?Q?90CfGfG6aEcSMhfzsunqGx86jMnWHNI91peGC7ZcxjAZqFFA5IRxDdpzwZpI?=
 =?us-ascii?Q?UaGLr+SdrH3P62+Qlrt+TMfFLfW3vB/0YVAOQ9WNZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yo/BV9LSD/Z10jKjTN0FGOni+6KrOMd6PjaWQPRcJlK3dXFPUNwMzvwKZs1l?=
 =?us-ascii?Q?sB+FwXPkmf7YsM93m9UkrR/ktVitwAr+PsJtkhKq51qA2Acy4dgVWvH0SpCj?=
 =?us-ascii?Q?PkWpd2C7+JgNecbzY+1d0KNu84QFBIisdoIurQuyfOM34mMj21LS/NUY6xJZ?=
 =?us-ascii?Q?5B6QKO1P9YY5wqqvMlOylVe3IZ4pC/P9mOiy8zJYAcxq/Ej8YCnP1loLC6K3?=
 =?us-ascii?Q?rnS2N4tVeZzPIwp17VdAdG8Bbl2CzEAq3CTcgjOBZFzLu7LTn9eJ8cmATmuq?=
 =?us-ascii?Q?5eArVdmYZsYhzVLnV3IMS+Zh5bXBwwM+4QFs/wETSJOFXh85YV0wXtFkNvIC?=
 =?us-ascii?Q?iyT9tGPyX7JWiwdshDO3IoaNs3nd+tGHtcojBheFhOO4KRLqUyRa5XYjcBXL?=
 =?us-ascii?Q?7kkq+YuKTOgR3eW6eMp2grDxHBEpPvxm99cbQ3EnThPArL/km19n8/wqIKsu?=
 =?us-ascii?Q?djnq9IIuO9NNS25EbyVabmDHhpqHM8kj/4YTIGbnNIFU1GiH23skl9MPzcen?=
 =?us-ascii?Q?c7WqQ8sEpA7eVDEUswZqQb66jsqx7refzF8icUWkwTj9ctVjvP/4pNl2ZSdw?=
 =?us-ascii?Q?qtvOpFQU5QxSdyqWJ1iRmz0w79ji+bdw7JmBSegFlKGKZxtccrNR3TdrDOWu?=
 =?us-ascii?Q?OAlvgDBOusiRt+Ol0v4ozF0s5Fu8jGfwOOB1Pos3oc/v0ZTNfKTscetWKpWt?=
 =?us-ascii?Q?iFMk2mXaeQLFwFY5EDAJ2xOVlO5SCYoiml7J9TKGSmUjMVqMTvSJbVRom5gs?=
 =?us-ascii?Q?BTzuLZ2T1Pn08Oz2hMi3uVtQtqslolNca7xoqVB5RnqU9BiujPdtNMeU6RXK?=
 =?us-ascii?Q?wieoZ3M2CBFl1Vkx3oUPYFAuqR49l4XfnhjdOFB9XBUa2ID3m5lWPQXe4+V2?=
 =?us-ascii?Q?uFjyYcwwsBbi/g2YM+twH3sc5AUqSG15Nl37wEIDyOgqWQFBCtth8mn46eZj?=
 =?us-ascii?Q?EWgg7GmECb2PVAm8zgKXaXsUq0g8yrZQJjHOv7j3DZ7LJFXQyBOky0bFUvU6?=
 =?us-ascii?Q?AA4SgMZRCgkpjMnYRh/gdb7nSvv4rUS4mTOZZRPQJDQk2jqnIIwHczLH4d/6?=
 =?us-ascii?Q?o1roZNYQzbelUjbrIaL0VmnDzcS91i4SHLt8nSKhZEIqHW3hRztNGqel1h8w?=
 =?us-ascii?Q?0Ib31ssECZnPKQGgdvRtERJPKE89qrC9ameDnV0O3gE3h7caebGEfgVdQxVg?=
 =?us-ascii?Q?ImauSOPXtzmcfWmXaLpnLukRI4UK5IMTCDn5hWSrOvciGCJn+phXPusM44l0?=
 =?us-ascii?Q?ikBWSofYHr+CEIe2PGsNJl3sCN7n5JdWQyXiY3Gg/WmZtPSsRS+Hv5nbQWEU?=
 =?us-ascii?Q?mlz8M/Aj54EKj6MCgR0wX1j5mDhtR53ca2b9jA1wDWr3yZBmtEionIhiB/GY?=
 =?us-ascii?Q?7YXGPpswjTJE3OEysBrthWQxwWBHi5mGoAg7VnvTYHIyUCTr+SjXpCeOxqgM?=
 =?us-ascii?Q?T5RJaf7o+PRKjuN+uCRsKK0kwCGOqbDzflqmLhP64uOTA8WaJy4hx+t0vBRz?=
 =?us-ascii?Q?7bmNHvWKH4f9ZvuWdaCZdqRETVgN5lAV+OnyvYfzPSRdVNY7cw4XzmBBNfnX?=
 =?us-ascii?Q?itRA8ZVjwApUZH1BSIeMR6H8MA17hz4VMMR+kHjeDJJu2/tDqwRAzNKtTP9r?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484721b3-395c-4454-aeac-08dcc8cdfe15
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:30:23.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pvzyr7pO6ZLlZCcAE3hriB6/Gn6024MQVWFhMPW75I+jYM/CYiitJdassu4T6PYWrYrXxqoY/0pJ2XfQtWOXOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB2068


https://nvd.nist.gov/vuln/detail/CVE-2023-6915

