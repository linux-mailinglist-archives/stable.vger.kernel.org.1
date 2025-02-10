Return-Path: <stable+bounces-114496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00DA2E802
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 10:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F351888C10
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E681C3C0D;
	Mon, 10 Feb 2025 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b="xSAT0O0a"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2125.outbound.protection.outlook.com [40.107.20.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680AA185935
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180376; cv=fail; b=UH2tIkVClaD4BHHoWljJr67Rk+2Dx5zq+l2j7NdiGBZMh2lqOYdcvlXMAq0/+ig6XKTzsevZ8rRr6lhXbuCzANclnTPMlgtBHHvJ4c4x6yTuQwPhnIIQZ8aQhV2jq6AWGk7yn1uGBHmweasMzU5vlbiNmQG4W4DxcLQ9lakIXxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180376; c=relaxed/simple;
	bh=L7hiRvTATli4GTutzUjifHX25g61dVy4OHCW6f441yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ShYXoTLyF3Mz1PyPdpMPf0UTNTLD3mhxeRruJIsEfa7IbU7fPzxC4Y+IiRQOZNa/sRETQyDtVUzhnIIsLTQAkeggbqJ4stZKRMMF3UMiaQ56jh1hSMf9JYr4euxEG5IHq7y9QpTZxePBClsL9SJjA2TZMZySnn1PvVM6WoFbuHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b=xSAT0O0a; arc=fail smtp.client-ip=40.107.20.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIT3KXR5qRdCVeYwo0ilMck1gvaBZw7mXyb9FfQ48fKGGu/Ced7utVPZ3vJ2a6RMkA71VGVVnjurNT2sVxY0KrDqP009UNvyBD0eEQfXd751sAwkDaoWB7RlcrLeqmzKANQj4no+pPlRtticvrKVZLixEfJu9k7sMicUEysfhYGd1x+E40FYk0syVzccSWv+XAxTPYMr6HwTvBtl0R/7vh8jSkj/3H9g0Gd5TdiwOe9xmB8spuN/Hvo9drnXBXfNE9LetbQsYz00VoK4chsa7J7kPtz4HG61rZvFItBdk3ShQmf7dmxQbdiOK7F/gPJNoYHagIzGlASG8zl6QKG97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7hiRvTATli4GTutzUjifHX25g61dVy4OHCW6f441yY=;
 b=A3ZEeYIUPDdXZucCXHqiRZHv3Mb5SKPWgI5TE/j1zO3Ca41kNHGxNb4Uv5h07Ce8upxah0ooeVFwYgTHM/+g7jSi3t3+vd8V8eIXFU3L3VcsYxniPyqBI+jhdVZhM0SChnpn6BuIxPIhqHA7ZvsmTZ5MSv+XeVb2+vQ6gGs7kqrHUsIchXIcTg5RV9nV/WXVA3u/5VANJq4TdcvPiSxr7I0hNF7/OLikoLrhMNLrx4Cuasxdb3znCZsViRGg8SnOfEhOBbSBAccXDUpWphPOzr+SYxaQVyEE/ZJW6dRpZFj3/rBw1eoyHGWOrfvrr82wg919OU2R1yGguhlJNYIDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=WITEKIO.onmicrosoft.com; s=selector2-WITEKIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7hiRvTATli4GTutzUjifHX25g61dVy4OHCW6f441yY=;
 b=xSAT0O0aBoRF37p2KRQ0aQYM6tIhPMPmlnF+N1lvcHc75VjXUyLed5k+1nyI1z7E1sIMnZxpxsaYb25pTazAnpmKGBWTSiuoB4AyzZq3e88snE87nbHm+688gD43DCAj7xhgEhcnlison7E5epfrdb8R+lDToFo24gwD8mrZSlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS8P192MB1948.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:53c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 09:39:29 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 09:39:29 +0000
From: hsimeliere.opensource@witekio.com
To: gregkh@linuxfoundation.org
Cc: bruno.vernay@se.com,
	hsimeliere.opensource@witekio.com,
	kent.overstreet@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v5.15-v5.4] lib/generic-radix-tree.c: Don't overflow in peek()
Date: Mon, 10 Feb 2025 10:39:13 +0100
Message-ID: <20250210093913.209407-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025021059-waking-parlor-c55d@gregkh>
References: <2025021059-waking-parlor-c55d@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P192CA0014.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::19) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS8P192MB1948:EE_
X-MS-Office365-Filtering-Correlation-Id: 6084e606-353f-4023-4a05-08dd49b6d0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GuzLhBBl8xyli18CR7Hv0457hgHJrhNwu8qd51iEkmGvdK0NT+fkitL+yBJf?=
 =?us-ascii?Q?5xB4ggzPciO5jRVmHur2UynRXVZO/bElt2wkJGlCg//ruMplhm0d8EasT9Vp?=
 =?us-ascii?Q?htNqWyQBm1tAVxLQssFZpEQh9/CCzMg+slOZiji6oQAHKUH7F47oBaLizJ6Y?=
 =?us-ascii?Q?i+rJ16QURZivikIIbGcAh86ME+Zfs/UCLJg9ek8O4xPh5tuckwib2+cMk5UQ?=
 =?us-ascii?Q?rlEoRDGy6gXw6ga6Jhae3NBGHj2bka/DWwS/8wsPHR5s7yq+hw17K2kpFyHB?=
 =?us-ascii?Q?cgPnPKYl1ANLaVJTFUVVN4TpOe0d9e51PjQRtT/VFYWZE91Ph5UM4XEb72xa?=
 =?us-ascii?Q?ZZX1hFy3Y10LyD+V4UgtEFAnwSPf6/qtZ7naI+3lll4tW2Ld5DHsE4SClu8s?=
 =?us-ascii?Q?H5vCpTWJ3GePrafaRjkgCurUa307raYD9GumPulJtDgNv96OxnXbhkdJbbWK?=
 =?us-ascii?Q?ciZDyGKf6NWeCSShNEcLh68uXqeDtrQJ/bmiEsYr7S20XANxz78NBsUaaOE8?=
 =?us-ascii?Q?bE1WZ3uUfqZFDAzxitZbQGc4MdYpBx8YOXNneB3FjTUbPR8oPofrunG7nt+O?=
 =?us-ascii?Q?FUiKRsEK6TCsijWG8WxUB5opjLRJWgDYZnYEOXH0yFLEtI7YWMT5gowaJPiQ?=
 =?us-ascii?Q?RndcS87iWClNTQo45tVL0K27kWwzRQ+vugweVQ9ZTPU5JypV0jCVqx977Xru?=
 =?us-ascii?Q?BFYPFHyDkI10INO5Nr3A8T2tY7dBQXaQB3+R+hgJ9cOHHxmFv+LCQSbKSXHu?=
 =?us-ascii?Q?5Tt7vIecpWYmtqLOtlnQQS9ein8BwfMVPgQiFHO7fgWDpFUajkGYCLId9pTz?=
 =?us-ascii?Q?27lr3arH1wrk5SfIIdVqRdCm3J/2W7e4vsd8dFJTNUHPVKLdLWbI6BlGdlOK?=
 =?us-ascii?Q?IGGgQxiWirD3l/K+STi506hl2gOnQB5xXsH/O2MvismpHfG2BbXUypFGNoMl?=
 =?us-ascii?Q?OdmwjF6I5nf3SRFrKrWkyZ/aQgYuw3SZXzlofl8Mj2wfI1jmOxO9XJBh1t3X?=
 =?us-ascii?Q?CboBSaldGOFbV0tRzxceg/Y5D1d0VZN7lR65bzoSFNpM7PAFD/BYtl1YcsB3?=
 =?us-ascii?Q?WpetKWqxq/azn0P7jCKaxY5AOiq/kZzxmaWkI4h2WVStR4CY7cTPzs6oeGf5?=
 =?us-ascii?Q?lCiOumkb5bnvopFC3u7ZQgbruHMpSt8D/P9XT971szHAh5hUm0BK5TA9mf1n?=
 =?us-ascii?Q?g7Xfh0uLFZyvzjFLsYHmEz2safEs7vMVuIdsEEXcbRHi4swGyT7c3LF/gRKJ?=
 =?us-ascii?Q?LOgv45EjVkh6MdGFxmz4wnfEzhY6ezPJVwMTXKvc0UpeC9dnzPpRNf5I81oq?=
 =?us-ascii?Q?0WH7eWUiChelUpz8C42C7b5MA/n0SzQfLjrG1uunWPNzARRCjeJN3GAMQoYx?=
 =?us-ascii?Q?cOSLXL9AEWgn6AlC8xxhP1ZMFr+AnreYC2Ucvzml387OQ2M7AXb6Ldc+4Wjm?=
 =?us-ascii?Q?Q1n6pdJF+Jd10TG2IaMOC3hLNungZcLV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+PDgpEpwIpUby4jd5KpsyicHD+aa7awDeK6M4K0nicd2YVva6WIu2oMK/8+u?=
 =?us-ascii?Q?14BKQt7xE3+PQCLSrEGiLesEYEKPeAbRNSunoyAc2fq3m/tRQVM0DVPkhB4i?=
 =?us-ascii?Q?OrD7KsHDvWIwLpQRnDeROLOpDo+vpoiotQ2B2nO4Cc6LxiCh4JBI/NCgMwqQ?=
 =?us-ascii?Q?tkNqX2sGcWq0uXN0OROSidbD9RvN5rDVbXZ+326XwRLJ0GOYUk5AaoTu+cEv?=
 =?us-ascii?Q?24cA1w1Dh6pCc75Hfxt5yI8CGx+9di33L0APjnlQZUJakZ1Jx/LtiYBuP2XF?=
 =?us-ascii?Q?zQU7siorLAPPWOTs7swX0ikkX+4aHrPei1w9jw+uV5JziQr9uH2ShTGKz3Eo?=
 =?us-ascii?Q?+3j4ul5F/j12u1buBvSdUs3ei/d0HvgkHN/BdC2vBzMcDT8Re6rYl9oqlxcE?=
 =?us-ascii?Q?oXQHG2o8fg4cK0Q5LctISfdBM3o9TuegAPCJJXSGmLlc9nB7i+XRjVOKXctY?=
 =?us-ascii?Q?oqqjEIr2+AAoQRmCSHJPv1CuWwuXLbcTH9RCC17WrfRnmVcBQ7gpL1qTvUPP?=
 =?us-ascii?Q?NWDdJkaezKcHwtpHoPn/zIUNqMXTdAGYeEi4yKYc2ouB9oXHkfaTxgRUbzkE?=
 =?us-ascii?Q?F8GTU9Zu1I2Sz5DfaPLLKsbaHhZ09n7cExMEpnQyoiHu5rCKtmJ/2L3O/mmR?=
 =?us-ascii?Q?Lvp47udihhbDEZNxOwAagiS2WWJhkizMvBQUrSqrfSzvrrJRNoBQ1pKcchAA?=
 =?us-ascii?Q?gMr3eyTFsjdIr4v8reFZOsYiIa1GGkG+yxbOd83gNf0VPMNMz1SckGp2VHpp?=
 =?us-ascii?Q?D0XjQZI0jJSFQ88SS85tiZdX4TFYJ0+ivvnBcgr/JjBUViJYzSDZ1Yj24XJO?=
 =?us-ascii?Q?j76vN9OGon7SlfjgHMlVtFJh1FFSfIo1wpqgOPOKiO/Dfs7BdoAGYbGgkks+?=
 =?us-ascii?Q?C2ZYy1xrcvgJsvTy6u6jujZ4fUKpmpxx/pKbrgZz3TsPmGNMONQe7arEN2uR?=
 =?us-ascii?Q?rkAaNDxz8XhDR3pEqzZRiFkTFb3nwkNJ94II7cSHYA/Ee8gSPouc0hMiXSp5?=
 =?us-ascii?Q?AWxLKsGihF7uK1NZ3JEI7ows60MPUobOrlmx8+v1rUT37zr0SSNcmBf6l8X5?=
 =?us-ascii?Q?CFjG8BMDYdNq5/qrQgnH42fLMxZwZeR8D29sC8/2bRsUVIO2H78AS0eAhvNp?=
 =?us-ascii?Q?It8Zbc+I9+MGwhC7BRhLAxVyW+RHpL40MVdTXNe05fwYtK+nTBnbBV8mN+j6?=
 =?us-ascii?Q?R1idaf186wNY4X2jq/B+85M2Cwu2KFgDS9tcLivtR2WzUjY+H+rdooggMmN4?=
 =?us-ascii?Q?TDhVrmEeh82yNuE162G2dbBb4/p8tZOaw1xVCyJ5WHvi1+TQjaB6HUPKyxy5?=
 =?us-ascii?Q?XSyPIdvxAlpbUwZv31s20qpOjssyQWv4pkRust6ovYxZ5Q5x4hz1C6ekKutF?=
 =?us-ascii?Q?rFZOZWUekPt2qKEi6Mtrof9yMbL6jj1gzZo2VuX/CBlJahM3QbsZJ1i8Qcqa?=
 =?us-ascii?Q?1FdtE1anY5u/9tIGMBDXZthkK+JEBsHC9+jEbTpbZ0PflVVGvkcUdLesMmBK?=
 =?us-ascii?Q?MFj95hAiPEWDk7YY5eelX7/y7zK1UHl8lfuGQKyDOXd/AwXhVo3akGkPrEUL?=
 =?us-ascii?Q?7VdYYKbooYQtY/HwqeKmhc4DdWXo+A5Juf3PNhcRvxaZMFpgNJux7ilQeNOz?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6084e606-353f-4023-4a05-08dd49b6d0bc
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:39:29.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ku7ZWFjRbGbYLyqufe9FbJ38X7YVWq0MBtpxqSWeG+i4Nh9X6YvvLgb+R9kgTR6lbJtX3tPJovWaZ65pio1mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB1948

This patch is needed to correct CVE-2021-47432
https://nvd.nist.gov/vuln/detail/cve-2021-47432

Kind regards,
Hugo Simeliere

