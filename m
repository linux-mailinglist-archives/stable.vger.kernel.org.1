Return-Path: <stable+bounces-71571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85475965C12
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48321C2318A
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 08:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9711D12F7;
	Fri, 30 Aug 2024 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="mh2LX3yQ"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2114.outbound.protection.outlook.com [40.107.20.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F138F15FA92
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007792; cv=fail; b=HsLsjetpvWALl9gG6uF3IhZMYOldfs6N+3nIe/3a0lsW91Yxqs34/xJgccQk0SHv+TMqfuhwSmfWySCg8trpKlB53cJvI+HoH3e7C5ffKtk7I+/YIsxkomBbjOQMOSHSJ5ab/Y141AuHDYfzjuqqMo9pIdmz/KrKN621svqSHsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007792; c=relaxed/simple;
	bh=HMNGoaLNwhB/m2gNFdw6PXt5kkGDvryKVYVdbNhwsJI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HflNG5c1xt+kJZrrYvvHy6DBIwlXnVLSL8jAJ4L93j+006CVBU45biH9aHQC4nGz0ZGAIxPbOInTWagdHJ8XVM7IJmTk74pqpa1lR0nswI02TC6UamxsKQJt89m9SLJDgSu2nn3w+/VDPnMzdInOnpsL3y1CV08Aggr2YsXsT1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=mh2LX3yQ; arc=fail smtp.client-ip=40.107.20.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azYpkMIJmeUxRjH36bRq1GWYkCM+ioisRhz0i2LVJRtv+1SXm1jgLJrTAOsBSXAu3jtwWvbOu8hNoU1GEw/I5X9pHYkdA5GfIEiNSVSW9kIEwMla0mfFpWnp42jFfit0YKEoDAuzmNeG9YJVd0a3qOcf0VNokSidal9nu75kGzxsd8AjaVM7ugyyfj7RE4jd6sz24bPq2QiRRrZS/etDLK/P7YM7GSZpiGI44PgeLBvhjqEYO0OB7fbtEWtpQmKy4AjGOaeuXmmBOcJIGbXSqmzNB5D1SmYIHgKF+OoV3dJFA/tybVOs7noqukKqkVCxsUUHFmd0mBLENX9MQ0ivEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMNGoaLNwhB/m2gNFdw6PXt5kkGDvryKVYVdbNhwsJI=;
 b=AG7PMWMpBPyLdYuA6o27E16KdKt8HWg1KCWZSDAXYxy9+3fW/npGawBeVwnpsAJtjFWoN7FHR0AoYiDQmufjTviszc3YfRfnHG17V4UbTMgNdpeb8BU0b6KMtam5phT5w0fEeWECeY8nVn4pgAX+d/vAsL/kjON7HsGEgOOxfhK+WeIyQ7ZIzlXw1XXMyAHYWR6sSZwGRzkBEGcvR5PJdP4sIjmG483j0trdA6bpV61ZDLYOTD9Nogp8ZbM4cj1Hs5T9H8PxuQuI4xmnw3LI3Vq0gmc6nZLB1K9Z6gAq9Jlk0/V6un9xkC48vnvt2bdWnOat5rBbcCZJeOEa2kXx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMNGoaLNwhB/m2gNFdw6PXt5kkGDvryKVYVdbNhwsJI=;
 b=mh2LX3yQXoKLoTcG+qY3RnHNC/uyFmtXNT3Gnu3ga4AEKj+atJDlFzEWfTvrI+L8xrzmH92ZU1JmfUQu66V+tQhPPTcaqGOv+EKwaahcD2x/oagkp21J2+BOQq+O1dRk76zOZaWjH8Wjsp13kEKTeFWPPr3AbAzzdiTGWwMAi2P9RuNGe7dD2xCxG6w+JtorYQFXhbwjVMiX1svm4UrDzZEBf/2hcgjgdfliOpxUwAPY1fkxUkGS81Fq5XZqxrwPe6ZTS8QZzb/QTIlCGEyrFHy8azso4poltbz6okJ/A60X8FlMrth8LqNTWxGR/i+aONolv1uBvox333ZDw3TMyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AM8P192MB0884.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 08:49:46 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 08:49:46 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Subject: [PATCH 4.19 0/1] Fix CVE-2023-52435
Date: Fri, 30 Aug 2024 10:44:53 +0200
Message-ID: <20240830084923.27162-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P193CA0014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::19) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AM8P192MB0884:EE_
X-MS-Office365-Filtering-Correlation-Id: d20c89ac-1035-4b75-54a5-08dcc8d0b31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrYcHaZhy428m2jbdBTeEKSKWQd6wP6YsYnQwQgA0JfiHhWojPjrMG+emLF9?=
 =?us-ascii?Q?BXctVcTOOC+Xk3jfNgsUvyBxZBOIuUgA4c3T4R95xFnCAPi53E+RnX3W2CFM?=
 =?us-ascii?Q?IKVRdZDWSBPg+dayBGCA6tMQPxpcXY0ViEQ/jJyqgosDXmj0Hqwwa3a43pXS?=
 =?us-ascii?Q?RL0AoA6ROJmlfn88kOKTskng+MdR3mUPoTS++NGZ31kPkkhA+3L5nvvGidDb?=
 =?us-ascii?Q?qnOPLl8GtBVGfmwIsIYvFXsZ4VepBdDGtpppAmfmxBvr/Fp0KMIvKilVIS1P?=
 =?us-ascii?Q?Rh+WSt3NCDn+TsWyDIhx2zWyCkE19v7MzUd2maWyMI4ugHvqhCuXe533zh5Y?=
 =?us-ascii?Q?02SxBlud/KX3p8cvCn1tKSqbhdESmkdpL6bDCBsv6cI/eylNqjw1dCa0V81P?=
 =?us-ascii?Q?EWYxj2VIhVkNiQdtjlAQn6s9+6MKvXh9b/vIEg9jKnxaNjW9C4P+7upfNUE0?=
 =?us-ascii?Q?YSvJJQZRGn9Jj4EaBbvosST8XkE63twM41AoOZ55Mvt2cMI8vxb3AItLjYbL?=
 =?us-ascii?Q?+PFZNnfmjQKuuqMwnYyt/5c6TMEM+ZGwsMHn+dUiPM3JtUBJ+Rw+a/MSBpPe?=
 =?us-ascii?Q?l1WAuhpjH1a0A6a1wPn9IkiLjA2TDj71faajr7anqh9jqjLcx/4om3gY/cxT?=
 =?us-ascii?Q?5kRk9+vTWmnqfd8B0SfalydkeFbUg1AH9kqmb8goxr0sX+9rYKVyfYOcZsuU?=
 =?us-ascii?Q?wiBi8TrW7kFLKaSLy3Z9Ta7XL66WeBS7JEYO0INvrxUIVHbuqJQZsC+vEgyc?=
 =?us-ascii?Q?5wZ70QEx4P0vXgqzToCN+Klj8r5MiW2hXbtUtdSmPJ0TieTD/8bnYTOjUPnz?=
 =?us-ascii?Q?1ALBHjj7BH1ZZotmo6IbbFuQSQF1e+AtzpEB/6X2sllr2gq4E4cFm5cdo5ql?=
 =?us-ascii?Q?ENhRMA5EsJ3l4Xu/LKUi/vDTr9qQG1HCkEsIDC18new6ZQP/jqNbkWTn21Db?=
 =?us-ascii?Q?CpNpfVfLutbHlvGpLSnfkluJIC8/o+Wcy+iRh29yvxOIrhDiCCaFMli/TaXB?=
 =?us-ascii?Q?14AmKRf0ODTwkBAugnbulIoOZD4jAwMVITCYpv9dgYDgi74euilJBxy3J8UJ?=
 =?us-ascii?Q?r4Unk599dum+xRe+LQEjf03YUh9GUD15eWVQ1xfm96Q45lhmTfxhXmeQGfjj?=
 =?us-ascii?Q?w1vRNYmV43bmojCW9eDmfNQmNhgOSlq3CGFJHPDAkqv2cr0P9sYnG6m58XPD?=
 =?us-ascii?Q?VHsYwjutKbsk0FY0YnDlz84uJXCnMSokDMHEib7LgRd82NHAKmqvZAem/rj1?=
 =?us-ascii?Q?0nBsDwF3IbgeUnYiLWVgY7uGiklXaHb8S9DUT6c2+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PjdnF5Ddc1CtEIVRD/BvnL/uJSOkMFhxkKHxBJu5Q1UnN7Pf0LhKsvx4Gmcg?=
 =?us-ascii?Q?F46o/IfWukG9+Vk2bzxMEPXLKIwNseuvM8qoCqBbH4kMAfS9njFMB17hmuky?=
 =?us-ascii?Q?Cdy8OC6aO5Z2MmhTCvKGL1ToY/8PRAWmeQA2rfHU4Y2ORcK7q19Ok9oGQunn?=
 =?us-ascii?Q?kWEFwsWSWguBPOO/n7feqrcI0rGB4yZFDSR9y24/mPGf2pnSlGlHhdkJB0D1?=
 =?us-ascii?Q?LSDRHEAgM0j1E3LymKOtAjljWz1uIF9iadCjNNYgSYBHVyAQKycSWQD+JhMX?=
 =?us-ascii?Q?HWhI4MEMrWGW4MBd4ZUSW4SgNtJoE32wJbZ0Ijme/CIrALSEIgwVuJDOwCJd?=
 =?us-ascii?Q?s50wRk0EgDgkogGDJ0vk8OmkMbNxXxT68CNairmPLE/z3hmg5MK1b90iZWXd?=
 =?us-ascii?Q?483n7d8/7bLrff6KrekeWpm6c/9U3C0IAIEzf+7dU2G5cVYr3RKhIwIqrQwx?=
 =?us-ascii?Q?polVjo8MLbMOCT8fVXYQdHN7hU1gAq9k7nAKcfSjJTJhkBQqxgHuKC/Q2EYx?=
 =?us-ascii?Q?sIBfbtmEQxVesKiJRk4+pqh1yQA8oHXMkbeMyrKpHvunCSX2CO0Z3lQ05VIX?=
 =?us-ascii?Q?MbFjw0C/TF0aa8NXHEic4qEcJyGx/NAYtHAUAS7Zlh6KGn1EIhfkF3MoP4MI?=
 =?us-ascii?Q?4CCnU8LibcEjlDi9JrfqLkuEcYxFFURa9IiXF2lJ37DK4H5mFTkOssN3cddf?=
 =?us-ascii?Q?djDRYNM/1NoIvCf1pDIOjiw2G0DmPJtFo43CNyy//Niwi5LFqftykPmUsOiv?=
 =?us-ascii?Q?iIO7FS2BWdH0uDX6miu+mcHcv98hf9MAPKC9ugQRWCUclQYvZDsSIxvFgWM5?=
 =?us-ascii?Q?qrdQDPPKXGle3Q+BaLSEnlFldVJMDgEzQZjQRpw/zKwu1/LwsSeBUkgD98Ti?=
 =?us-ascii?Q?+AZFM2EGbyFangwqQWvCxPSdUmh7gPl+1hR2BRec3Km5oP5G9YPdfUbvsdIn?=
 =?us-ascii?Q?pjuSI5K4KmBPVga34d0Cs8FNtQkM2WVCBHx95NK1P++3fW5iBli1xpn6gtSu?=
 =?us-ascii?Q?s0cWWuDYVwFEAs4T/wLtDAZC46+LQIE6KbIEvuCQSQRqWMGpVY6wZcXCZmL3?=
 =?us-ascii?Q?r8gFf1RIVSnjSHSUTnJpRiedSEVzE2dmbLu4Ky5+w9+hcclHuwf2ASyZa95i?=
 =?us-ascii?Q?ytum64egbcb8mMtL6/9NAwkeFtSE5hDWs2wb7PLEgdHL7eJzNZv92XLPsxde?=
 =?us-ascii?Q?ogINxPe3LzAzr6NXoag0INXJtPhRkIN5l94sWYy981AHDtNj8QOXXbdS1O+D?=
 =?us-ascii?Q?hEuHQygMq3IUyfZRSt7Ji8yfS3DudgiyBLysNuaMMC05HhxswvWnIribn43h?=
 =?us-ascii?Q?o5pR2AsUERZsP/GjGjGjM7Pp/3xKgrEwj0P19lZcpyROGNr+wB7meiE6ZFRo?=
 =?us-ascii?Q?HRQbeFRu3mINee3ZfatDcevic1spVD/TbgW+/QFjVtrSiEtZTZlvitCM/7zu?=
 =?us-ascii?Q?j9ZLmhKrfEM27Qp87r8ALwNdy2g+x3b48qEiRlSRYwEMOVFfaYc5SwMWctuy?=
 =?us-ascii?Q?mnWKMe7kJy0gqyL+U5UOe1bBJgIwfRIxXekRzw3D7ettNNRooMrnRcx3fkDB?=
 =?us-ascii?Q?8XL0wpg4GAPRzfAoxhu765aOSdCbs6PTm/OjFtPmsjVejd54Xef+TK8VkLVc?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20c89ac-1035-4b75-54a5-08dcc8d0b31f
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:49:46.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CODg7VhauZ7KQiAp69be0Sv60PWvCRRINaOnMXbOE00QyypcfQ6PHr6bhfBvE17NympIh0ChljW4EwZAHpcxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0884


https://nvd.nist.gov/vuln/detail/CVE-2023-52435

