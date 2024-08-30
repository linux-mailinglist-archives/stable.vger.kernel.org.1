Return-Path: <stable+bounces-71579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FC6965D25
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 11:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729D4281FE6
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AFD1531F2;
	Fri, 30 Aug 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="kmvZEzoJ"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2101.outbound.protection.outlook.com [40.107.22.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338D01428E2
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010820; cv=fail; b=NpkqYcFxwKst3M+WwMtEny7X7RpQBt9UNG18jIbWk5ShiQZhFJUKYBJiS3L8VHw260MyIo7qZtnLfOwKtNOrIT18LgAkGYxzksGkJbZkdnvxCixOhWhcDSZt0IC3Fcm9Ph000bFVFY1x0MzlJpmRysZTp1RiULrSSePHZuNgqII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010820; c=relaxed/simple;
	bh=zBTGAGabmUfgRv/AOq1Lmluuwnsg0U9tr6/Q4lff+4o=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WKu7ZJXajzaBp0eSRF9NHXaSuTq+PvbXQBT+/AdZy7YGwKqkT+j8/hy58LPHFiF8H03x4fJyr459v4mCRfiUn6PeAqkqQxwIYoUW+93wpvCVyF78OIbZBRa95fEn1f2zDmmEwIXnenGLcCPCMYbjXqD5DhVvxAkyJxFrfLyg95w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=kmvZEzoJ; arc=fail smtp.client-ip=40.107.22.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9xRFAxg54ArwuBiO/WXFxon7RIfM17sIuy5HbAwNwb0b+JuDN88NkwDm+o8FC7OpCmNoyjbvKXduRxQ9pR0oJ/11bzXvd9Vvmd9QCmCji/3Mj/6LhV5ERQHYllEyDveYrZ6VjGVw3OHR/7g8cxGkvk1WPnbWTJlznYMJVpc44tA02CETTTeWdIKE5jtVGo9gwNSvF8YU1chMheqA5seI34gskJWtJoUIyDHUxqmj1q5c1x8j4cJPHp9YO+GYyOgnEEY1qgd+US8ujTIHKHsOETdk6gsnY4WVu4Wt5Yk0Cxz+poNoaGnFPUmERrT0MgVa8X9ZmwHpVTcUZmo2vxfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBTGAGabmUfgRv/AOq1Lmluuwnsg0U9tr6/Q4lff+4o=;
 b=R7skB5qfaWgAooQnoNb+C4rkE03+LGfM6jOJQBuVJ9GRLjyt8ABt8i45aCrCSzPqTH/WD9IPHMHCOEJ7sTp6OvdmHabMc24AsF6z0zGWgotrdxbhklQCWBLCdlo+ucnG0soXaYTbrgAUEsDNGay3FqHGlWqjnphnCJBdcFSCY2FmTsZt33bVV1J4Afik00yHvoUYRWO5L4E/5REmBPObwu1pldkpkNG4d7QbmNmxYPla3ITxWs78VYIaYhwVXKvcv0LSA4HmE91oMSi+KZjswjC3K1Fd2vBfhbJdnNkaxnBHTS/tXRlEckEgeoHIyZ/pOa1pNe4YKHzn7d8+kWuDDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBTGAGabmUfgRv/AOq1Lmluuwnsg0U9tr6/Q4lff+4o=;
 b=kmvZEzoJmw/lFeegOiDDvXx9tY+r9/pbztQ9SyIgt0VuEK9UhMXWZUGjWEIwafbJkZle+H/cv51LkMV0/7VmDpp1OjgCg0t5NbyTPQCFhFpt7OZ+sM4Ofkr/E1t0DZ2AAE0yrI2d9K3RWBFFDizGOcpO/nwfu3W5w2FWabneUILzJjyxo/BturcXZM+I5tszONZQJoNmCZEJaaOXKYxMPinkOLBcctZ/Ne3y377AwHhEld1QMDoPLvXYVJ3ujeGSfsZ3IEUfUf50r//4vHMXQN1KgFTps5Q6iLBa41U1s/2CPsPNUaLfbeqojBzs28gpTk42mDQ0Q1Cpn3qxB9GhSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS2P192MB2145.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:62f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 09:40:12 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 09:40:12 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Subject: [PATCH 5.10 0/1] Fix CVE-2021-3669
Date: Fri, 30 Aug 2024 11:38:28 +0200
Message-ID: <20240830094001.30036-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0076.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fa::23) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS2P192MB2145:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e8c356-321f-486b-d9d9-08dcc8d7bed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o/kKoq1UR9SKzmqorhAuP7qmGtbSFIggOGFUM5HLlmRBnrsXatfFdNz3GDdr?=
 =?us-ascii?Q?Q/TYv/R9jXz2h3Dc7of8LLG92cXdUfjtB2poPTZ1Nblc8WsgnYiPfDiJUBhi?=
 =?us-ascii?Q?sGASrjBprxhe6jbqIuOKqk6iC7a7bbWbppCHMBq+CGmCFkA98QWS7dgy7nCB?=
 =?us-ascii?Q?QFbCCL0NPaH7g5qzQ9LGRrxCRfHkhnvLPon3lhKbde5xTxJKdJitXzbjnCrY?=
 =?us-ascii?Q?cCHAPl4kXAbBGunKs45kM2n9rvnnX52+gQAUHULwIrci3MSNclmCIOflQ871?=
 =?us-ascii?Q?VzpSf2Xx55GLXvl025ukb1hoq+mJGQJf5CnjTnyHwVRXF5YEhSG9X8K9iEzv?=
 =?us-ascii?Q?iXe9cftHeZ1qKKZfKr0zYXwRZC7Loky02FH5LD0x4xHkHH71e0P5tANECnDx?=
 =?us-ascii?Q?HU6LkPbhAPb9Ttmr6OWk6A2VueO5S+cX8obNirjbzO6fv2zZMVBO6jr+BryW?=
 =?us-ascii?Q?Qn2fGbKLdbnF3c2lwF/PBEXqY5havtf9eY1oDVgxEFun8Ikl8QtsQ5lVwRFb?=
 =?us-ascii?Q?ET5d6MYTpnraXh5gEGfc/yJmtRUjoxc6wsuqtYl1tuLcnGCUrXBhiMEqfOqk?=
 =?us-ascii?Q?YI/1hL9l63lbCi5XnHV6t+sU+2Kob8q8HPbOirQyKzTQABqn+vtjN/Mmo6lQ?=
 =?us-ascii?Q?GApl1RyZHRETf+tWLlkoIkOu5amygz9rkxSj5fMBWyVPXlzJItObEfrTkHAk?=
 =?us-ascii?Q?2irP6+G9bpPfosbca+F9M1GFR20RK09+U4VwD086Lm+ofNnWQUowfcgFMi03?=
 =?us-ascii?Q?tgNz3utodmHMKUUa04vwxZk769pDOSRkcwSf44CO+guJdVEKlTrMnC1YO/Pt?=
 =?us-ascii?Q?OF0LrUCsgncEvqTnbp6EZeyBuYKmHZn36rEP4K865zpC86N2eVTogKOPDgRu?=
 =?us-ascii?Q?e3OPbh1xlNv+JmQH78n+8jajaI9AfUobH+G4SUAhaf0sLvlByF+ZbHkXKIJG?=
 =?us-ascii?Q?6MOXhSQDQjwX55weEez7xFCh19BOpNlyQOji4I+UKXQVnBQS0TeR2vUkpKDy?=
 =?us-ascii?Q?peOC4mw8SglD9LrAcs7WJWv7AtK/w0IHwbrmVXo9Jhvyim+nM+1L+I7QEihv?=
 =?us-ascii?Q?m4stf1UF/7jckgRcQWtF0VS2ARHvvZZj5C0rH6QaZkAGhDSh1eRE0ZtTHph1?=
 =?us-ascii?Q?YBbDzFXZum8uS2C0GlzNO6ixnHiFUgbSwCUQPIw5wHocaiS8m3NlBR6zDWXx?=
 =?us-ascii?Q?6L+ociUDUtALO0R+o+7H9ZdFRXGl2jioFiwpzrCGUwOK/j2Ig4rF3s64E3eV?=
 =?us-ascii?Q?riuF+6NEJnS8r2Fd/Rj+WoaZesb25EmLGIFV6Cpo7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tgxlft20rGo7zR7+zJd5Ag2ZrIelh0Kbs8BerX7QksLVwxHxBr2ICdLmWC3J?=
 =?us-ascii?Q?40BwmF7/ORPvwi7aGe7P7umw+a3IfpSY4XXyFXnW1hpvwmU2uqJYseIqknwN?=
 =?us-ascii?Q?4A9JABhMtY0ynRUbsInuk5kThb9t9WWalvppmtWP/mCDRBDWBzVOh2682+kg?=
 =?us-ascii?Q?myaH1/DXmn3ChAcjucHHN5SaLec0jJjzlWAfQnVaxLEg33G61ywdmCsrEPlJ?=
 =?us-ascii?Q?BE6ECjyqOPjPXPjNFHO4wrMI1lHMCPkLKiCtnODIypEaoTaORfmORpnvwYfQ?=
 =?us-ascii?Q?KKclIK661ro54WNyy+k9Dy3WDwzoTR0KtDlvhiiUv4nKKwOkqL/YwRPAbbnR?=
 =?us-ascii?Q?xPzPTJVnE9/9cjbRq/+B/6PY7tOvUwHQMfpd8LGCF56v1jeUNaHYQyExxfoH?=
 =?us-ascii?Q?wHeXcvqQgJCrdoordAYXE2Ky45ukCrGF2guuz4qM42Yk45Z1Io/OEOwlkTa1?=
 =?us-ascii?Q?/Jx74s7LDTUKggYBEiU7BE503TN9K7m7fSIeQnLI6wKwM4sWjGH0KAGL1TzE?=
 =?us-ascii?Q?7TVPTVU27Ko2xp4zNoWqcmRv+wr5hqOXXPgBGMp7Jh7LtPaRkvT6rJvzQay2?=
 =?us-ascii?Q?FZHpPGtPM4ICC2hyjUtSFzB5cYJZrzSnRvcoKGRwLmZ7c4LiyychYAw2LmV7?=
 =?us-ascii?Q?v0u6S13xZHSbMlNB640qzI3vkzGPzIFqyrDbRjyr0f9J27QBGrfuXatXCMag?=
 =?us-ascii?Q?le7XfSY/m115hrmhkeUv+lWghMopQOAHVFHjU2b9o/3OhBoDDmYhPXw1rYvi?=
 =?us-ascii?Q?ZtgrLIXv6LnHDyCTcqTYDYOFt7/v5gWQvPNzYHjB3ZWiRdfWBQFdtTR9lCw0?=
 =?us-ascii?Q?uIlKP9iBN5eigaZ7JM1xOc1P0ESel3/xo7aRUAe1T9nlYdswtHNZ60YUSkf1?=
 =?us-ascii?Q?4JIOyyZtxuMmCsdaYlqd1ahgloh2kEVCCGSANPAyq+uCVicltvpRJ56lyYll?=
 =?us-ascii?Q?yEYjnftdw2bkIutnQnWstQKDNzX1yB0bpXiahx+oUgJanlXkS1+MYP7Kn4Kd?=
 =?us-ascii?Q?OgA4CXKrIDDQ0FcroAdiE1rXKijXzKDubfHTs1WX1tePtLUpWw3MUZKGWQrE?=
 =?us-ascii?Q?z3KwtUomHEOZoMOfq71W5m1HLnKFB/5HtdtYQ2ociwIsPPNAXN42k6GUj3sx?=
 =?us-ascii?Q?I0fU0sS5CS8hR5NZk6XzNKeopv5nUyDnP85koNukV4cqWYvBuTTSPU4PJaI2?=
 =?us-ascii?Q?QnDqWVs3kdDPoYOZaObNTiC0SNUM/sKjGVusvIihSDri00mc3IvJQlhjlrwL?=
 =?us-ascii?Q?Ytn1Kb7VbIoG3h+J1/8RVp1RDrP2eCo3P/ZxFaOz+7YJ4TCq2I+BUu0Dwsed?=
 =?us-ascii?Q?5ptMZcg0cPZwtbaOZw2hYZHwdLZBoWysG7bBNE4f/O/Cvq/ryWEGjCjQVsHz?=
 =?us-ascii?Q?GRQi5dgTZ/VsaemDY3AGYh07QO3paxloUnCdbfY3uozEs02ynT+5BrI9Y6ul?=
 =?us-ascii?Q?3Oh6crsCcQ/ElCGgF3va9/Q9aSfZBfWoZqT2Qpk/mpqcCYF2ghmPVwZpow0x?=
 =?us-ascii?Q?+uwwnagANbYnsJHuHndjt1HBvnLZFGgQEJ+2tzA+O5Faqhqtc24uY2hA/p9u?=
 =?us-ascii?Q?5HLd5i+pAhz6Ufc/invxHxVeHwKtMUfLBfVGR5o1RfrpBoRn5Q71VSri756A?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e8c356-321f-486b-d9d9-08dcc8d7bed6
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:40:12.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckXBmDDo/KiKbfr5BcdDSmfj3IP02VJ0lj9xD9fXgDhtNOzZTHVmosOA/A21FEz/FGfJTpKfK6PhbCBAH5fHXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2145


https://nvd.nist.gov/vuln/detail/CVE-2021-3669

