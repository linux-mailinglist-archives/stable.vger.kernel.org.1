Return-Path: <stable+bounces-71536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83129964BAE
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2141F21D7B
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118101B4C49;
	Thu, 29 Aug 2024 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="swrOfUb6"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2102.outbound.protection.outlook.com [40.107.105.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A31B5330
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948808; cv=fail; b=TmFM9ermk9tNxbgxlthHcFN0Kf32QB14AhrS7sv6gxjuo1E3K2+U9s2GSWepWF0IV7o0ccW9Ym2avFJgckws3cF+v7DV94OhXoGlmcB6atjw1VPjHDaSIEkoycWGrBzjLmP6RmBDqZ3WQHTjwYAAwA8v8esLoVO1bGsCNq9Dyww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948808; c=relaxed/simple;
	bh=TVMzlI7tcVBBXlxJkXPRaLdP0D705BQte6aMv51q/vg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GxWPQcJp6xgF/lAo+VNX43zO6wWlIZrOi8xOl5aJ0OoaAwAg8TlWBbMhK/S5l+t5wBgZ5A4X2QKmjadEl/55VbdRx8zhjhYqfdzFp4DnkRvZsiQDsZgxPwzHPwhA52CEr6mAUYqFfNitUdpNebpi9imY8/v8bniv9EBrw2Lc4aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=swrOfUb6; arc=fail smtp.client-ip=40.107.105.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTtN5OzIUwFUZuIG0Kuqf5HlAXeEQ8bQvyk2V8JL6d8Mqrakiq6vMi4J1hIPUkmX02CBW53fiko4RJ/dG+c7niMO/xy1AXYPXtax5Dh6CQ4N+sbl74jMbs05Id2xXvDXVARlHTmVmjRrYkhaN8YOPd+HPA3yZGfBpQuyihk30kLdQR5SalDHjxbAqH3m1g8ObsRC8ZsH5ELNdBA8bFj5fTaCSf8M0aXusBd8mWy5R5bIx7rYc8xsmqBIkHUDbs9o5+PFTzOa6gbhU/2DIjh8d4a7Ecl0jtfv69+V6gG7jrgXKUAUrcuQ99937vlEqZYRqiRadyg2AsNpjTYrQPLWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVMzlI7tcVBBXlxJkXPRaLdP0D705BQte6aMv51q/vg=;
 b=xL93hLlKjf1AVEUV6ENWxEWBbYHYhkmg7J3Z6S0zHOT+M60fSFIJq8lAqMETYUPpc1v9Bs8H5ZtKhNdfMYkjDV7ErqsLwTax+3U2Fz+l1CWEVSHFzGxW8I+2MNY0QhBu4W9+XA935uMN2zS4j3BYwwCLLIEzQj119MYvPHkC97yNNgdDZDIzezFE/rA00PHLMnE1ZLAVFWBV5crlCv7z7PbfZPtqUdJ21UNPRrsmgtXbCP6wsliMhpDizFtiKqxBaYtN0WMX2U5Xk4zO2dslf2s0xwNEwMhoNH8PKiwgO4s+2doCYkmG9MmE5kRhA/qVSq2IslHVcfxmfkagwlHTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVMzlI7tcVBBXlxJkXPRaLdP0D705BQte6aMv51q/vg=;
 b=swrOfUb6sG31AW8KUTCp2vz0klMQ7hadYsGDItV0cpD3MjDwDCTLWiWaWsVhoVHDPTFUiQXQb4UVjizuLRbR3dHLjmCoVOQzPJNMPj0M3d9LOAPw3Xq7NFPDxrfld1wMVzAZdflLeSxSGdKU1HZc40tAQAsRbEKuHM9rn8SEeTFlpr2GR4AZRVz5GbjH1lcQkvI+8rWdPWluPNI1TcYDlwYLmJ5jpUEF/8NQyQQNImkI7Wikuisg8Pu5lHFrZdwMopQD+4j5uA+fu1/eSeVMn79EaYquJm9nM9zWrDQqiutKDjujym5Ce5Na8ioh/nZO7SNMcg1GugU6Em7VjG2ILg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DU2P192MB2159.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:495::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 16:26:39 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 16:26:39 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Subject: [PATCH 4.19 0/1] Fix CVE-2021-3493
Date: Thu, 29 Aug 2024 18:26:20 +0200
Message-ID: <20240829162631.19391-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0091.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::10) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DU2P192MB2159:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9514b9-f7a3-4783-ab23-08dcc8475c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xzn8goAx0krW2jFkiF7jXxJrg5wYzO3WHvx+xGpNFOHiNE4slfR4D31nn6Wa?=
 =?us-ascii?Q?AMRyoqLXBMynEHWAckm16xuE0fejIU8uRmUnI4tvPj8RWKbCm4O1Q5ppg+Vf?=
 =?us-ascii?Q?xq6LRz/xrpdszIWSA0xI2k8GXTAQn3CrdPWh9G7jM0jBeXJAubFV87MZ73mu?=
 =?us-ascii?Q?INXZ16c8GGfPnDuBEplcYftXykJ/VHxnJOV0CL7xtnh+mrx7PI85enbfCbHn?=
 =?us-ascii?Q?g8/ZlWK2I86mzko4xUWSW6rsq5BhabbyuYGjRfvd+gkFWmRJzs5+sroRtLBN?=
 =?us-ascii?Q?AE9yzk7Lm6tiJyMuemM2O+SjuX/tX3QpoSjRhuJN1bDCwxdZD5XvBtLtSCNW?=
 =?us-ascii?Q?oph/f1Foq2/KWC4GKLl806T8txniXjUpSjSrWm1IEEvAFg7DZFQT8TJMuemX?=
 =?us-ascii?Q?bs6hyZeJ+97wDOqZ17MVI/FtumX9vqjxyx+dTjTVDO0oZ1xLKzYwR7L6T0Oi?=
 =?us-ascii?Q?74N9qnAOt5p0C+KNb1BGlHK90vpqU/Y8EaP+VbAr5EDPquZHfB6aIAGoB5v2?=
 =?us-ascii?Q?0swzJIRgCoxFAYADi5xTX/x3hKn27aypxvEU6uct5khk/zAuC6dR3DbOn/WJ?=
 =?us-ascii?Q?oSMiZYMWAHelA5L1eEoivKzNrv5tLPq2ZM5i2G3s5q6C92urI+BSe/KpmfxC?=
 =?us-ascii?Q?/XfbVzLa8nvDr31KCZQWpwJimJt8/IbRuK9ojzY2Ya8/3yQO49e/CMKzSYSI?=
 =?us-ascii?Q?2PQtO4WdXjeOZN5G5My1nC2+78Kvf7XkxmBCeiMvpetQsrd2cMlgE+yrIMKL?=
 =?us-ascii?Q?mjCodeFin4t6HwwRkKpL+78vwjzMvw0YNlMBKgCysDYhumiyxA49n5/UHeN6?=
 =?us-ascii?Q?mm31pOlo+YUIgZfPE87jfLcPd8vEn8PIq793f0QXfHlpzIrJBc+Y6WICtkRe?=
 =?us-ascii?Q?NQgsFY41n6HarhP8PtymchthFy/ChntH9o+wx6rFL5xZOLzqrL1VzDWePwCN?=
 =?us-ascii?Q?jGPf4r7GdZCv8UtvM3fqcMqFKu4uyqeL5Cpl0DIt6uFu5wnUdxaoxyAwetbC?=
 =?us-ascii?Q?AM4NWVUQcujOavpZYxMbHibPdlURR2Idgf6fm4e1bUCDZelc/WWFcYjbrI8O?=
 =?us-ascii?Q?93Ob4jLkt04TIc9nEqA6vSmgLB7khdpEISCPQPwj/SVHbw9vBnh7XjvK6AEM?=
 =?us-ascii?Q?U5DNAa2IcsCKBFm1sqiC1sVohwwLoJjD8eR/gXZowLW/U2nKgw+WFvuaYtEJ?=
 =?us-ascii?Q?nlBvpd+DZBuPPwPUVTgxu3sWgtEEUYVa7brvvHwcGB7LL9AGzMmRPxCJzqZr?=
 =?us-ascii?Q?fieGU9UIuQCqzcpmtD7JYpVGYal5s6YO43bsnQ9X+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aXRky40lDt/cMxie7gztgwRRl03KphcyYqpV3OqeiZgZkq2y1yz0QYjqSyUJ?=
 =?us-ascii?Q?MnTA0iuJhNwrOuzdfGAi7x7MKAGFdmqmD7BVPWJ7ZzAh7k3rJC2o+6o4J23U?=
 =?us-ascii?Q?nIJUMd4e90kuRx1YiCr5M5KcgwD3M51S57vp5aBaAz05y2Cw3LOHz97K55hc?=
 =?us-ascii?Q?QSGYP0wHVO+pcuDLB5PaSuIcIklyzSsOYhcsrBFzFcMAmO4cZRwWFj8dhJbd?=
 =?us-ascii?Q?a3FmJtwRisLpWEW4skrSphxu0NNl2CyCfJu8GmNRYz4k8e0lSh86ZQWSh98l?=
 =?us-ascii?Q?rYFa+fbf0cY0S60M6ntQ0wWA7t/oc8JgAAdUcLlWJfFI5AXztf83nVJzfsa8?=
 =?us-ascii?Q?AyT5yk7e3ry4SL1Wg+KdHCZ8sXJqITdpRM/owR9uKKqzNEQ4musjzpnMqoin?=
 =?us-ascii?Q?EcRbxtzZG9zAwpB7yNwGMb+uJeuP9+CvQfW01jfrdjjuJcSRI4Gw29oFPem8?=
 =?us-ascii?Q?JIfki4xTdIeP3tIv0fbK9+ri9mN4L9luM5zLs7MWJaGAdIvguF+iLNWJ4rhi?=
 =?us-ascii?Q?vk+62CZkKzJjUTicRmgRTM88VRx2kLpgEl57yWbckgf61iVtgMB5b2YOStmK?=
 =?us-ascii?Q?s5pvdeBHix1zfDXvNzdm5kByTA0REPuba24Q0/1v+iKmAE7p8sB/l/c1Fb7G?=
 =?us-ascii?Q?MeUtP1vtWkp3OaJeP0NOTfOxOiLTTwSSm+/bYdK4lh8hR1Hpp1siHkDbnnV/?=
 =?us-ascii?Q?ghoaJkNuRp+nUe0HoewBoqv7FO9D9zAFn9fyR761Q78iDvbVu99/4Lc9mDjp?=
 =?us-ascii?Q?5jyri5u0ibB3xzJlcEUwSc93a4o6iKEBhctJ2iOMR+NgQ4Jns4rxXMWmxnkC?=
 =?us-ascii?Q?1RlA0Bo8XPTu9nD7uBlNGBslzbwB436Ws4Ymm+TuEKAtFtMOdl5vJao7r8uX?=
 =?us-ascii?Q?xkuhJMcQhhc3zvV9K+qgSsCpCyMNLOHMil15TRDsRqKCl6TN2/OMclFTF/2o?=
 =?us-ascii?Q?P4YHJdPXyJK2U18xjrQN0iRDjCfm3EjsfrgxiFZkhL6FMtEp7AShKRtoLEXB?=
 =?us-ascii?Q?+OW0VcHK7QZ7HtiGAYjQ2JhW35M6bFzG8DP4ylVwNzYwbAebhylJzAKTbWuT?=
 =?us-ascii?Q?m+Blzjk+/XoHvuYpG7LpjLWaN/8OK7YrsTVWv8Zlb4FixGFYrSTUdlWGkKIy?=
 =?us-ascii?Q?X4L/wOaX8VApOjSZQCuj9yzHFwJdabk9TNGqWLyqagwHeXAUpB43XYaXp7m3?=
 =?us-ascii?Q?J4YX5UMJZRLkYbWHn0SYgaTjMdNRQ8HKa7gmkKeFIEb+87+i9LWiCR6rEjQT?=
 =?us-ascii?Q?IEhew2YOD6TjBpVq8/LsCSZcI+WgTQio5lexHRzu5RqU9fZ9yJfwzHYeTpnH?=
 =?us-ascii?Q?CeBk1EnEsJqMrFvQgfD4osmrnXKhY3i2yUwaz0sBpV7T5jwbTw31z3XgNIgE?=
 =?us-ascii?Q?xhFhzpAquojU3f8kd+biELMY/7JYddb7zgpN81qvOQ4igPdy/oz3kIQ7EzXy?=
 =?us-ascii?Q?ShtaGeitABWvXRaeJhqizKPbHdO62ZZnF5eF/5cqiVZcNULPP6Bo0cY1ENmQ?=
 =?us-ascii?Q?qGnd1XZgZeGd0pQFCIFfntiEte9vG0ag9GnYbk7jwMEmR6s8yUem43aomz6i?=
 =?us-ascii?Q?TyuyVsQWRK2UhIKe5Ov29BLntKrPmfhr8QffJRKPluC5I11TGbQsQaJYcHXo?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9514b9-f7a3-4783-ab23-08dcc8475c02
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 16:26:39.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNDiESH9La1+/97BXV2GIdtcceo4J5oMZmcHGB5bAhi8l+iJS8kXevltzLAGAbyCNV3mCSGszrOCw/g65hL69g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P192MB2159


https://nvd.nist.gov/vuln/detail/CVE-2021-3493

