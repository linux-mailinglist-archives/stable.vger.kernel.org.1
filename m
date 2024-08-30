Return-Path: <stable+bounces-71566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59331965A19
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 10:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C79E1C21F90
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 08:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C28113635E;
	Fri, 30 Aug 2024 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="aheGZcLQ"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2102.outbound.protection.outlook.com [40.107.20.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5816C856
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006078; cv=fail; b=LG0NDS2uTmOb2JdxLWLBRZ5OPyfDZe6rGf1N7Z2Vbl9qtChjOJ38BcsnKaYw4NahTxerCf13XPX+Yfzxk63K1q4Op4I54CWv55F04Rq8ZRJxVYgaR/+tfAle3J+5ZxmZUiVZPTkYt0GmtagWV64tufrzVuui1vxo8elRhuVBwyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006078; c=relaxed/simple;
	bh=eFuDkriKpj36p1CBbEFYSDQyy3ODhoI17z87ZAwVRp8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GfeS41mleDeM2/ToVvZU9N29Vs2ZBGIp/wzry7PNjeiUKamn23eWiEoh9tzRHLquhpg0lwUweVe7ARkExcvBt2qZI6WfD3vftzLxK24k0oRxHKnM/h2LbpZG9n4REP7QA4m5VF7WD3UEGjBMPG4P1IQ1OjkhzWkHSf9DY9oMIPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=aheGZcLQ; arc=fail smtp.client-ip=40.107.20.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/LyvZ3+ttsTr9MzhQsX18LraDwmckSoks9V517pbbPzuiWGdNr9vUww65NhEY7+qbBJT5dOHAq4OKoRcW+8M+9F8ZMnL9/U7NOnwSrdh2h5zc4eRhZi1qowmRBnZn+rpjHRDAPg4JNJnwkI47NeCSh61Ylfod47bkQhlK3X3ohKlicNSl7E9PcV/h/XPnjqll8J9lwWWJwMOTjOtGleQp60M1XySSPIa7pcDj2UplriYgnnw9ih18RszjLJhdQOuSAlmRmiHiCLnpuRcLpsPpoKOBDquGOZuJkUDOxQLVujfl+jt04oxkXYPidfjNlipc5KqcEKfJzmyzZTgGzrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFuDkriKpj36p1CBbEFYSDQyy3ODhoI17z87ZAwVRp8=;
 b=RzOKsHSzGNUfCOyIiJ2CL2Gv/45IFXU0x6OEV2ugxkV8qg3A8aG3qo+eY2ui91HnLFkLdUdhfMv6wsubGEU1ZJKcv7zYKWILjOzkUtMzrzRanE7qgL+oPaauuJRA+WUNobwuvPASuKmpxcNTlKB67nR2h10vKhvihTkO7Ydt0mB6xKCVH0AuvOZumWsumLzea1ycT6eLswz1nQWwltOqUwwq+OvzCp1RboBe/pllGJ3SDx0q/HtHNG2J3nGt7EL1M34Idcx5RM5+gB+meYnHuJfa95zcSQDctwJ1BL9AgVF5tTvuFNMObtQ+0coaaLp3aKEu4X0dZJ7cTS3H3YfvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFuDkriKpj36p1CBbEFYSDQyy3ODhoI17z87ZAwVRp8=;
 b=aheGZcLQOo3a/BFsywsQPW9K/GCJ/oHPbZAiSf5r1TvivDcVE4gAZqayfTEEkd4vurD3itXMnEDnHfNMM1l6V4Ra6c4gw3lzRSKcEZRH0IYfRtuaewbDeALtO104GIrlrNcrhUKbrCkbY6bx8/QozQyutZiklhWmXgacuz5ZkoQsQcT+A7AEsSSSw8nLe4M68QF/XV//Hq/oLPjfXq7njvKdMGe2NepeCDjdZNMxC7mLv2+9Sfd7azkpdccucvk168qNR6BHVbWdL3UsCLGfu4lrA7X2L1aUhKG2u1TH+8/XtLdP06R3q2oiatymLUM46Z5qJev7F40tOZpdA2yyKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DB9P192MB1827.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:39b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 08:21:10 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 08:21:05 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Subject: [PATCH 4.19 0/1] Fix CVE-2021-3759
Date: Fri, 30 Aug 2024 10:20:27 +0200
Message-ID: <20240830082045.24405-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0050.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::25) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DB9P192MB1827:EE_
X-MS-Office365-Filtering-Correlation-Id: dee89305-797c-44b8-9a98-08dcc8ccb0fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D8TbVwSvzDnbUaO1HX9FwomRsz/Kb8+jcsfTN8SeYn1zRkgY5G2rrKvmXXdS?=
 =?us-ascii?Q?CiChp+3CUF/UCgbYGLNDypCPVANTkOh9A7nBFhCE5N2rHGWByBekvmmNTy7P?=
 =?us-ascii?Q?ERIYMMlaKCLI5VrYJnV2wMuk9ryYH/taVhWKuvZhSZKu2rJXfbIGIQAmzDL2?=
 =?us-ascii?Q?FaNL/n4QEru7Jl74BmLopE0iqjfyS1l26zdQ+h5UtRpS7JICVgtwGYj/b0nF?=
 =?us-ascii?Q?QgjpF8vrB0tVAn3cvSOWNZiNR9vAxVPNKL5KOuCiWNu8kYk9j/3jpTISzEKy?=
 =?us-ascii?Q?jFvpP9swD556953BJ93P6lzes9Z7bZpcJIUnsvD8kqsNbMIGLOEWnpJkJhfP?=
 =?us-ascii?Q?B8hdS2KKetv/1qR+ocypdfPANoxVbZA2sf1d9GYSdS8TlqRJAClO+42Y/FCu?=
 =?us-ascii?Q?248iQs+ZccU1ndT+gtqTYiTTozGrdWVgJEmduf44PqFF6MDejOJhL2pYG9Qh?=
 =?us-ascii?Q?2sW3JHXIHxoCBD9caVuFCBIMeDpHd9kph6E4gv/F/TvGocwdkrbxa2sthWm4?=
 =?us-ascii?Q?Bx/UmiA8ehftwpyVDppCjD5kQlDF3ACkVTRAlyz5tCxWGflSSzToA+SJye8g?=
 =?us-ascii?Q?YHwNUqv+TyLqlsP7ZDHSI4tirNDoHOace82dI1LAvM4rMMJxMuwsPrGBv377?=
 =?us-ascii?Q?+az5rB9HQZeBc4ZU5WUHpSAUMn+HfoZjYzBs5jdFZQomR12MwS99YvCSwR+1?=
 =?us-ascii?Q?TN0aL6/DWFcGXr2qa1CseLCnvdalh1t3IJ1s4iAmOv2VG5WC/8tkqxGQ5+2C?=
 =?us-ascii?Q?zbdNJFzP3sn4nI51gnaHl3wQp7akGpC2x/H0BhX9OMORPHHg7wa9eMM9xRRi?=
 =?us-ascii?Q?DzdYtJXIRV4JesYii6vpkrzqU0Q6KscMWnX0uh88FmeJwRZdUP4pA2oDGXMc?=
 =?us-ascii?Q?2aPdNAjsjHFRXspx3d/RRXxsSpxy28KMCNPytOtNwGr0vISLu30sXSSZiB5K?=
 =?us-ascii?Q?9N9k0sq0gh1TaNQF+/j376CiZqaybsY8Cknu/wS2HHEIAZHx1nhNmLqtsFgq?=
 =?us-ascii?Q?Y6E0xWiR1pvUPF3Mvpifc6csk24gS8+5N04GP3/e80Hc9ORV9mIu/uMq+WrP?=
 =?us-ascii?Q?7aH6eW+pElAMhgdre/8R33cxhRAyFNOm2B3g8F/tvmVj69RHIsGpRMPB8fDn?=
 =?us-ascii?Q?B/fouxrOBIFtLCYz2IxGF3Kpn0UAL8Uu0nfa9OmolWQKjMfjqT7mPkFlzQF3?=
 =?us-ascii?Q?EzuFNSwBaNPdXeo8OVma4kv+lRSw/PJSm4xEBq5EHcPIfjeax1E7SKQcOW48?=
 =?us-ascii?Q?pdKD3zZFwYaYKlJY3GQUI3yBfg/V/FBgOg6WJK8tDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6XgZRyR6NpGAD4hV/huiJ2s8owoP+6o0k5p+amagxEWxaIjB8bebxVK8L/A/?=
 =?us-ascii?Q?EaKDZ4xxuCvteAFHtl7fUngBN7iZiHcpcqRX/TlXbQR6Zqydc8n79Wgb+wbU?=
 =?us-ascii?Q?9HlvlvnwHu3RCUlvtcEwWaG6sc3f5IpE6kTWhXpN+m1TJzT3fkU+qDdntEe6?=
 =?us-ascii?Q?qOZCoUZ15rxpvrklDMcKjJaNeTkpYL1qyI8DKYeqJ+a2TdRIsJGKYWmfWQyE?=
 =?us-ascii?Q?10fjWLBvvFx9GuYkhVpjsd+HxNMnSBRDOlU7gk38xx2V7B5HKBa5W0sGbjdR?=
 =?us-ascii?Q?jIJWW6juy+t3jtnBEX1fh2IvcfZbL9K9TMRKJ4vmMGC5ioiu/Qe3k2vQinky?=
 =?us-ascii?Q?pXhfuXESUxV83Sy08ceZReynAEvzBqUhvbLcuMHjJN3SofVwN2Nx7wMvaOVb?=
 =?us-ascii?Q?HcaqnvS1EyzTKTfUZHw+xDfF9Ri4htvQp4NPs9LGJUkyzQWGAa8IQQsfQhGb?=
 =?us-ascii?Q?O37zyQIUIzJ5ze4kyVqPT52L898dBYKIb707WzJU0npGn9RXgxNKB6uWppql?=
 =?us-ascii?Q?U065YBa4gW3sSlovP2qZqS/lPUDcqXFwLLCtVz7AjUc13dBT/417mGTzS1sh?=
 =?us-ascii?Q?BjuervtkTLIQFKLw6JDuD5QDmx/2yNEyDRqd81eC3IizvtSphAlH2IBieBdn?=
 =?us-ascii?Q?7YW+YDm9EePEu5bHN+OJjBHT/2Bld+xtAR9j/CaZbLaN25BUywYi9TVi67nS?=
 =?us-ascii?Q?cDxZHvQe+wTs2bouL0iOeFxzueLmGD5N8NwoNJjHkMVpqSi14VPr9zgIENaB?=
 =?us-ascii?Q?1j2OW1R7qlm5AI3Us6Zn0GQYSPxnNmrol2jCLSnA4+FmMwD2vSMlVKzyhp9y?=
 =?us-ascii?Q?NUCFS9/UgZ4Ki9ZzHIdIIZtuHmygS8x1/cQa6HaMSsm9573LprqPum527Kj/?=
 =?us-ascii?Q?f6yh92lfOp9Sj74rWiUFYxnBnEMWqdyUx6rh6+5jroESbhjVZa3J0gAksuwi?=
 =?us-ascii?Q?0oPh4FVk9FH1iYUjrEZCDdeM38fEm7sVZMn7Uw7kAU+JUyu4gIOtdTA4BoBF?=
 =?us-ascii?Q?P8YlxpzQ3JzUscLv2kuN6ksLh1SJQfRVCvDv9PRdo/SO5N5REa7V5qpK0qkl?=
 =?us-ascii?Q?fvWoz3hZhcI01XNuFZCIVYu6FOGYuXCWkxQvaVpL1cZL/2J8X6Pf20qgRQU3?=
 =?us-ascii?Q?YbdtVlBJs6qhC+htqMGga7ynaOoQiR7LpAIxZ4kinDeEpuS7lv3Ha44oxvg+?=
 =?us-ascii?Q?lsg4fzHBybz/7QpeY26UzEFupWyZsR7wmnD7Yy6PtCmvpeR+IEam4Ufkphwb?=
 =?us-ascii?Q?c5yO4H1Z+arEhWYwNOV+pC4ev4Dk8IUjHg0X9f9jFPeiAlfhrPELCjXuNJMU?=
 =?us-ascii?Q?Rr+JRgRQBbZ0B2B3XvjPpvIHMODQF64SFoFUczBBS5DzSfsGAm52ZrDfJ7AK?=
 =?us-ascii?Q?V7kliCZbelsjDiDAuWyGEokSZxi/xFQbbH9Rgr3c2gk/Q9tD8F72HzaHR+j4?=
 =?us-ascii?Q?DBFAp+tQnNIHABp94+NQxtbhHBuLBDyWbazTjSoDgJHJQAzyo1B6h+ZsdH+K?=
 =?us-ascii?Q?tAOw5tooyitBqNIS12HCZgQUUKMK6tLDkhKbryE1JnQcSBE79tzZqrRVRCdU?=
 =?us-ascii?Q?IcexHhjBaAM4DVXqvc57tVHAYcdafDaaTAyf64YtFoFWpz6RqzT6fmLbQAz7?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee89305-797c-44b8-9a98-08dcc8ccb0fe
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:21:05.0288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQWDZd4Lxko/KIXXbu30uRiHotD84+vNfFuy+XtVZnPyb/R1IkMrbOVqf6RxC+PSL40W+ipAMeEEcYW54T8wbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB1827


https://nvd.nist.gov/vuln/detail/cve-2021-3759

