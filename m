Return-Path: <stable+bounces-226118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJt4EoZ8uWmxHAIAu9opvQ
	(envelope-from <stable+bounces-226118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:08:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F882ADA5E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C409930C78E5
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8C2D593E;
	Tue, 17 Mar 2026 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="jGbwWFaG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0422989B5
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763469; cv=fail; b=ts7+09T0S+lYK+LXiXenj9wQYj/US40ieVZspNvMA6XTIPQ/Wdn+3OL/JtyYDf59hgc3inFnjLqMAFG4GbsC6FjJbQz6mOMUoCpDZdd2FPxqCkKDDbFKvNy61xB7AFMrQBw4/L8Q5sfev1mY1H7AEH0ZDoac8l5BOvaVSKHtNKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763469; c=relaxed/simple;
	bh=glAdVYYZHcvrke2htk9jdYG4Xwyc6HQAC3ScWziKNS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B2fpVrySu1XxkVoIE6T++jMK76TMSp6F8ZJA8FgNfaw6MN09PwqyxsSkuE/cMdj5zR8UiOpi5sEqpQ24jqiB9xcRjaXG88igYbERaIfQ5weUnu18tfPm6YyNix2tOAXzZjYI2hMvupIkRLpsxbfNgSYubYCwTy3QmYVVYqVk9GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=jGbwWFaG; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HBdwLj1899369;
	Tue, 17 Mar 2026 15:31:38 GMT
Received: from ty3p286cu002.outbound.protection.outlook.com (mail-japaneastazon11010012.outbound.protection.outlook.com [52.101.229.12])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4cw02n2ad9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 15:31:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngTnVeyasbUujUPUYz72TudO++P02EKQhf1q0i7/tdJPl7w1kwPWZ5t2Bd5f9DsHSlDOUX41w3fg0BPKFeIDqS1K+ONY3ZY2s5EJX/L0/QLpcvbcCHqkZ9c04BESJDHReMOeWAdG02ShYiEx9yDYP7x7d3rdSCW0GNt/inJYDorUI3DdDzYSONSgPY8c2c5q7phuYQnpFZid7WfY4sZQJbAojd2DYv4QhsaRL7AR3LkNgi0h1U6etvgdR02h6rhNU9HtANNE1uYi9aUF/wj/YwLwdWKpT7sTmWVx1T+g2+XyoQ1OESepl2SHDXrWywRHMczhPlPQLaCr+drzp7FOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r70mkxKZKc5AFIBU6sxE8MZBAC+/dDH4qM8FDRLj7xs=;
 b=ShQafgiw1BwXsrGFgVpzEZRpds0oq1mfdGNWM8w14XDYifDlI2Bxn+6O31oj5wn2HvHSXcdKx5Jy2F6/3lLC5WhKakdYWVNE1v0o3KdTDX7cPE4l/6svM8AYIDFJacPbeQfLLxOv/bSr3fAI2wE9iL1N/tio147+d8Be0vfSAWXC3eY4Wgkh7YxYGtRJ9GHol61sgf0NC6qIf30S1qnQb+C8gVEaNfgvQxRkElncYoF+kh2ATDJqYig8btksruBbA0sMFSXPpbxli/dpwECaHbJ41/WCvQ05AoPrwyrPSJxYBx8EfhjfXkX1AmYfGu/eMPYrhVHt16v+tw80Hu55aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r70mkxKZKc5AFIBU6sxE8MZBAC+/dDH4qM8FDRLj7xs=;
 b=jGbwWFaGLi2gxMkm/ND6K8lW7tt5ZeZf8yUbvIJyrHflhJwiB8o3eBidVDUmnbs+JOxs7SaaKQxpO21c6iWJ5W/pdFTupBLfqR0GfcTG0zNUuEe1ciKxlnlpElHwif0NrAWU8+EnOMQ/MjBsoBnE2BXXXlqId12mLlVPu1vZPAsiJv/cSSmhdr1CHJRphBt50zpzTG9ggsYUutCEQ4/x5wuCvagPB0zD6RQzyD2T4FAPTzEqApQKsEF4+jZ9Ln1yqvUBacr9cyV+tMNyoWHLQwsGIxwD+K6T4pnREF5wyq88rcYhev5P6ToQFriHJA3PgsuN7fhBz9M1noQA0LehyA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS9P286MB7078.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:413::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 15:31:35 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 15:31:35 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1.y] iio: imu: inv_icm42600: fix odr switch when turning buffer off
Date: Tue, 17 Mar 2026 15:31:24 +0000
Message-Id: <20260317153124.522408-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026031739-putdown-harmony-6f22@gregkh>
References: <2026031739-putdown-harmony-6f22@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0098.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::13) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS9P286MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 13fb8042-1e97-4507-db9a-08de843a4654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|19092799006|366016|3613699012|38350700014|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	WF1iP42HcDR+gwEKrdJaNb/jQXbsJ2fVSN0lzJawBuEtcEnBexVHeQfK2tJzD6Fd+BRk+uTxbP9xiOnOyAvAX7AvGthwIDUSSzhg9Fu/5gwUYl4PJpfHy7hXK9hNDxL2IiV/xUyNha2AMTGBvirEe4Av+ZmfnHvt1roVpBUCiUYDrw9YI3WrEXho8NyuNze8BVrmqqFuglfe6c/X5O35htbuKOBwhGfK+qfoeji+RIrjHaU7X6sKC+m2PE1au3tw8RL1DIf75T7lWLwa4LbiA9WtnGcYbbCKCKmXGAbfpKzZGDARMbnne2+AqxvBYBr32RdELNfw41WdbLw9Uy1BQGis3ZbvEvYCSIhXvYQVda2lD0M230FK96KrJTPALvtEWbwbxlMcQT69TRVVCVPR90YiloDbIm6ohlCPh391AFNMBXUz6n+d0Qd8F6gSdxMMviCyYyH46L5zw0VZkoGmN4NmbLRlJ34OYnP0dCEZgb2JyWDgphLpqqISFvEk0oQuxeppztZX1PT/xBkY4SAUTSq/quA67zsqpZx61QYOE42/gatgu8NxG96RnWxeCaWJOEVKiJadMR9y6WLurB5ALGQwdos2aLyzPq5mfuywBZC+/THSvSPWZDlVbu3C0o+Hzz0O9/XwJG+3kAPT7TiVgaPJppfasvExe8BzAADNAZ8s3dBwReWUn7L5Z1GqyV3dxTXekSn9kKw8GX5yEGmvkIuJWoA0vF+w3XoVLru35rUb9Ek4UHCJ0+xsFXN7zk8cPOl2LjrvvJz0jfuK8G41UjhC1jO7ijbWe3VbZW4AhTl1mR8euvnK46w9Kl4WoH1/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(19092799006)(366016)(3613699012)(38350700014)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q6s2WwsNE7QeI/t+0ZYyWzXgCgmWp6IfOXNZP36RmRLaBiUypggtqcJHmtcl?=
 =?us-ascii?Q?6GU5bWR/OJsbpwr4eDUx3/xnnXy9Bb0mBMmWcp438oE3jGvM/liiYW/ijjbq?=
 =?us-ascii?Q?FXO6grhz9kV+vIAYvEqEtcnQvLSDAIjRBJPN1vqLKQeWuloGqyFeaI8wyKWD?=
 =?us-ascii?Q?diCGaVQqvZk1ZXDFEPk2MTpGQvPXbio2mSCgrvxgH3v9c7dp/RqkjSaJzUDK?=
 =?us-ascii?Q?o/tnzUSWxZlb5+T7eMNxL/A04zUEDgTlFBEgFLME20N97f/qwzpPlzmxYYMB?=
 =?us-ascii?Q?fPvZllvc8LSpwk1ZsmqMcTksck9/Lxg7nYrQIWiu745v2QVFA2uSdHD3KwJm?=
 =?us-ascii?Q?7av86FTdKZYIjqyWJHzI/WdtZckxOI884b8sMHZ5Lg7Hjp5mWAaGP0HdKydS?=
 =?us-ascii?Q?oc4nUyLxla0cEnZt52d8wF6ERe5vxl+v8D0hecmwD+y9WSrRWZCcQDNiIRz3?=
 =?us-ascii?Q?aUYn57jPFjy6bkl93oRPrQ0Z2Ulk68sGgwKqeqKbeO+0p+O4BGxh71AOokmC?=
 =?us-ascii?Q?OCCcfvvqoT8cRUgK9flaehO/2zdOqjftqJ1mmu4IkjP8OLOWcM9+RZ3ACyL0?=
 =?us-ascii?Q?q0qEYyP0ClJEjbbrr/kq2bVw3vsGJzXWB7h+rrSRizd71pzKIQgVe2YBMVRH?=
 =?us-ascii?Q?2qkH1BpqZQ3yqmZPCNEj91r+L/Bae+oR1j9m6njjT40UUmkkcIUZx4rLmU14?=
 =?us-ascii?Q?N84R8QTW3eAnUyrl0ArSorVWdHzLZMg8ycR+vnX53mxzcI0MrmcbKWTpjqgs?=
 =?us-ascii?Q?QyCZdiCy6NI7cIOw3RWEqAFjL8ysCBktrq7KDJOJ6GZIBXPgYd/FKeKSalKK?=
 =?us-ascii?Q?AL8agMSB0uVCYlcTRwWcsz0aAPfbhlEVjurQJ/ss/Iukt580T9aee2U17aIa?=
 =?us-ascii?Q?EFfzJ/QbQ6gQl84d2oWf7oHtgkunlCNKP8XBwYnIaSPSn0NIaSXnQ4wCobHn?=
 =?us-ascii?Q?9W1CxKv/yMRJy/sxayU6oWCTQeHTXo5rtTUYUiEaU8WTt6FZ5sYbf6ZzbmHv?=
 =?us-ascii?Q?9Wq/KUIjZJc9w1TMl12uLdAQ2DJ+IkICckJoX+7J4GlsIyjyv5Y6QzoKJOKg?=
 =?us-ascii?Q?cIOXwHk9NWj1X3gaL6EZAGHgMJ/S1hJz90kAcOJGMx6xlZ1tnSL3QCimQub4?=
 =?us-ascii?Q?sdjWcH/d5wiKtqWLLQh88afQM7HyGCJzplaBLU3qxQh3c3eyhI7GltUngPwP?=
 =?us-ascii?Q?l/hKTqqhgjR8UJ0x3hN8U2hC0MslkyLxybb2sO18nunL9apNCUzlTSD/A5b7?=
 =?us-ascii?Q?rN19eVRizdsBcFUPrfDnsC39c5nMBCjUv/Owxu9VhbG7pDcV6kBhZ9hdO8O2?=
 =?us-ascii?Q?bNmMcCeJV1F0QynpSifgkuErSBsxcbcB0aEIm+6I/zceuprKUxGxqaMpoZys?=
 =?us-ascii?Q?+DWOKwOvXz3ejL/V9oTm4o1oG2uiBA9ba53uo6aGplnCwXc6N0VsZTtIRJHC?=
 =?us-ascii?Q?nRp3GLWv1j5yLP+9eZXj2U2XSC9LIJIgfTH4QLs1yNBD9avXzFkIzDnvQ72b?=
 =?us-ascii?Q?PChrbb1VoMPODayReq/wko2NtQ030EKN8h3K8F+EGEHgxm0nbzo7F5Bgh/4K?=
 =?us-ascii?Q?oGZdyXYbO51HQpkw2H/0+6IVG4nACq3GMuzBnuFeaQPp688D/0E9N6omOZqs?=
 =?us-ascii?Q?SkPrir9F1U3M3w0410IaeP8ucHDCrri22YypR3DGmmE6O33wAmpn/5tZYO6X?=
 =?us-ascii?Q?w/eMFcQmiLnRHS4vtpzGV/VKlKWRTrSemktqjjEzh9KXOXSpz83xO2Pb8ETo?=
 =?us-ascii?Q?DgYK70KPZA=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	RiZxs2KhcU5UPFeB5V1ZzndH8I9s1N+ur3Lb/wC2MMmoKvX031WSLRm32FfQwdyqaLNVxeF0nydbo+moZ36rhpaWlXndBxBIWknKEJle/UwLROjHPFQ/H3i6VoN1oWEp34iiYfqMJ3LS821RrTfyBGmzrsDS0+XBbHb2zIOr/tZbE/TkCWs0Lqg7RMejDYPRlByjdqoE01Hssei3rkiDfivxb72Z7zqC0HIh+Vz9jV2qhFw06rXoMeXwSKhmvrUp4yi+cvkMWWPu9SIskdomCyZObI1CKSyCZqeS+BCg1MW+MkKoE44jtl4Un9iR8oGnzFwhVFn+HTQAGGc0hIDKhw==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fb8042-1e97-4507-db9a-08de843a4654
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:31:35.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtIh6R4LFOuu4YGBVEs/68jItHG/QA0QW/AY6X/CFfil+s/aXVFzCbg9EL1Tkqv/K290+RJfmErmVpqQIYQYEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7078
X-Proofpoint-ORIG-GUID: WSeFTUy8H4UHgcIoC_k-6bvg2YXqBISY
X-Proofpoint-GUID: WSeFTUy8H4UHgcIoC_k-6bvg2YXqBISY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEzNyBTYWx0ZWRfXzAm4WG/vcfoO
 rOQ2v2C8axC8sqiAQpE0Hk0e8t6Nrl1sOkqYAYxm8i/J8+Qp3kbIRPqbBxFv2yFEaJtYhSXoZvG
 g3SqD7p/1kt46yhrZvuhriAADsFFfpuBfkRRvx1Jn9D97a4SDPkDa7iYFl8DLWv+ztNE8tZsGLS
 RyxM1CP/6wp8rSdw4TFH+q3cTSb7BktV4bMD8KyNU0tRA8hLeo3AAX5KgJai6Lv1NtPn+E5zTsE
 r1TAasfAhDDsxujKlobUSESnRYu+CD19n/OIHn/w+R40BwSmnX8mEOM3H/2+irxnEbzx0RoWPIC
 tgeSrNYzqh4TjqHvqEqccQE6EwjOj/Nqlj79m2wsDvj6xHIzhmWaG0SLCthq2in/OBP+uLtSgJh
 iepzuSy2rxhLBeTvh/UlRxuoCdmESkS39e6P5JAReKGtN3Wc2BkcIya6vIEZHCBrhALADV2pHxu
 I1lFTJIWl/nMT5tGxYQ==
X-Authority-Analysis: v=2.4 cv=etDSD4pX c=1 sm=1 tr=0 ts=69b973da cx=c_pps
 a=FRg/6euESSP7/9Ah0YgALQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=Uwzcpa5oeQwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22
 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=dmF26TSAndsNLafa5AIA:9
 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_02,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170137
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tdk.com,quarantine];
	R_DKIM_ALLOW(-0.20)[tdk.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226118-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[tdk.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,tdk.com:dkim,tdk.com:email,tdk.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inv.git-commit@tdk.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A5F882ADA5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

ODR switch is done in 2 steps when FIFO is on : change the ODR register
value and acknowledge change when reading the FIFO ODR change flag.
When we are switching odr and turning buffer off just afterward, we are
losing the FIFO ODR change flag and ODR switch is blocked.

Fix the issue by force applying any waiting ODR change when turning
buffer off.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 32d7f8364230..f29c3e8531e6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -377,6 +377,7 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
@@ -398,6 +399,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 
 	mutex_lock(&st->lock);
 
+	inv_icm42600_timestamp_apply_odr(ts, 0, 0, 0);
+
 	ret = inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
 	if (ret)
 		goto out_unlock;
-- 
2.25.1


