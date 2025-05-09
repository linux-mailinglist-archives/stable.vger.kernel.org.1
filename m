Return-Path: <stable+bounces-142975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6061AB0A90
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 934E17AC60B
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 06:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7215626AA8C;
	Fri,  9 May 2025 06:28:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F4269CF1
	for <stable@vger.kernel.org>; Fri,  9 May 2025 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746772107; cv=fail; b=W0WwEEK+aASvA0LgZpWyWllxg5yzcdRysUyHgeeM3A9ykVX7ta9WUvu+y8dVortdwo9l2KdDo4o89SAVSlnxzlGENEDTneVp5if56xH4mTtcCwgp41Hrs/Sv8jjBW+7W1SwkJmwJo5X1bPJbwe8ZKsU+cDzhPYL/5fAJqzM2WPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746772107; c=relaxed/simple;
	bh=2JdRYc3GWAGjpLO/nIlc9d1YD0CfQF8hsUavPwP3RmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgMk+BeGjUvXlnWwzMFnFWWywZNosbYEYLpVwMtEjqzALTsIS9biwDBQ9lxeG3Np/NgwPyY3ivIWl7Eo2lLUagKc45OWlvZsXZoT1poq3GnnCEL5/QqGwWCi84zSYJgr1Uzlg3lYW3+hdsF/QZip5LS2uYvFM3n9Ay1qiix9yA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494bbWt013638;
	Fri, 9 May 2025 06:28:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46e430p7a8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:28:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVJ0yhH22t5pEsJApBekB04lk7fdi82KuZfhwHJlcXGruM1D073x0PdL21uzN9ao7/2A5K/Fj2I8krJBLaK/adM/S1ozpwILUwAU6hO6E3wuY/dIbneRy8J1pzljbwYwqIt+1wvW/fUW7jEDiAK2p/lPlTSF2jCkg4Ws0Us7lU7wqj+ukUAvvJDqJFMZsuVBkAiKtAhRv+P3u5uuNnaMj2JTlvFn4sKk7sXsSx9XV871ucPH0rzvzG8yxtKuCm99Uyb+qjVlooPFmXLHr0IIy0g2YRrOm773TV0OOqviOLGy9ye5i3/yVnVmhCnfkf7d2n+qSvWbkKU/1GfLxx8euQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqn+CENtXzldQ91ZOCTEmvM/SjcbRs/SA0rl0xxqWJE=;
 b=wfoM3e5euh+879qYHdSOnZGEF/g8MRUdLsO6Aon6tVkQLvVAbsOguCl0SXDlfg27VAuKJo34zRfBMkwnu0yyuwECKpz3BByHaPBENl1Us0gK2RCwklT/dXBZ4PjolqpzZtpIL0JKH7KOfgUePLTYuXkA9tD0mVJdVoiP3YtpE1lD5lC/CUEHGSeAx7kpO+/kK6BzlyDK8QH6wosW8J5pWYfxdRvjyPwmEkQk1I25xYtZfiBfAmQoHJSMm720c6hPWYMUdpXs4ZjIVTlcFlwHYkNbBj/qegOTLF+hJPft6KNonNAWGi8l3o0rDvqfbcTJzl0FzaDiEelGrJP5lWd1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 06:28:20 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%6]) with mapi id 15.20.8699.037; Fri, 9 May 2025
 06:28:20 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: heikki.krogerus@linux.intel.com, dan.carpenter@linaro.org,
        bin.lan.cn@windriver.com
Subject: [PATCH 5.15.y 2/2] usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
Date: Fri,  9 May 2025 14:28:02 +0800
Message-Id: <20250509062802.481959-2-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509062802.481959-1-bin.lan.cn@windriver.com>
References: <20250509062802.481959-1-bin.lan.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0051.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::14) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CO1PR11MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: b12eac5d-365a-4135-156c-08dd8ec2b0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rsIhcc1kchGJSUpCklC27JCLhZWr2fmLSfApH1ciB8g9RER+lUXVpWkuuzNq?=
 =?us-ascii?Q?0zN10jQ0TBJJv1gBJYLW75WW2A44xVGkEWVKyigovDmIZP41w48ss3a4YZeQ?=
 =?us-ascii?Q?0WvzP+3ps+MEMeCHEci17PqbUzrCuOECBoZqsva8EF8vkEFBM5rvzFx4zUrk?=
 =?us-ascii?Q?uZEDhAIVSsi1FKfVRvReWz1sE00KurSaIVGeBVgGkc+uU5yZwSlnYsnMYWvT?=
 =?us-ascii?Q?zyg8zzvxVZ6iPq50E1A9gUCzuczLUjU9eBlDcbwusLi1Mj5uQlGSebfurKaU?=
 =?us-ascii?Q?SbvHXWrSu4rLgOtUd9GmiDXliv7zIq5qoYdQmBtpo9stQyLhUIsCN382bFR6?=
 =?us-ascii?Q?fW0rMCy1hU6FtArs5zHFEjaISuSSth4vv+YwKizERABxREYNXXlYRGrbqtlU?=
 =?us-ascii?Q?aOoeNgg+HHqPuPYaEkPkyTHTPBi3/779SeMuUIP1KiUZFOWpus3SvxaqUguv?=
 =?us-ascii?Q?xdyjK8aYIhsmbEaD1wU5iuwOnfRkxtoYq6v/g8xg3/b1FkR0+7eV/Z4OkD42?=
 =?us-ascii?Q?wd9CsUknbSwsJH0lwqTW9PI0xFQcpk1jcG06rymUylCEtbzruYGWQxVL9iMl?=
 =?us-ascii?Q?fgRLacongdrgXIYjqbAy4x8m4bScBy6eGdOkIA6h60BsdLiF8499Zxm0loNY?=
 =?us-ascii?Q?nmiYBKWyXHCjeNGcRxD7N8mkRGvf88urUWrBLpAV/JU0bXPD0JM2aagl9yQ4?=
 =?us-ascii?Q?8wJwwTFmmlleLnI9rdu2YpYRZXRKVsJcY1C6mTDSSdvWRw5uSyiQooAancgv?=
 =?us-ascii?Q?q/1U6aJjiIYPLsbhSYBiiCh6t7rcsZZ81AgJ05c25a7MzqefE3uveV0AP8wV?=
 =?us-ascii?Q?6+xWe2339BzbQE67lpkIF/taFsS8KCn2jhu296Fm9s7ofp29m52y1NUAS5Rr?=
 =?us-ascii?Q?6C7A6ai6PhyrtawK80XXN8K36rGT6Lk+B6RLQcZL0Tnl+IaOhAbLTq+KDfy0?=
 =?us-ascii?Q?hWgPPSXkqfrCk9SeMKmjkcZx7rf9vIO+neO9tD2BPN2mPBbBuLqHKD5RvvNA?=
 =?us-ascii?Q?Wo2o/dGsYmYmWBFcdLC0jd6RH3sQdAHRxZAFD6S3bIZWMJTlXIuMR/bI92aR?=
 =?us-ascii?Q?JYeA9SC9SXcTUqMjYOuiq4UhaioownZlvN80biCpZ7MUO2eH7te8inBFCmwB?=
 =?us-ascii?Q?oojMUVx7Sx8eybwsLQP3hJxusgsYJMy7qsU5x9bCm28DGb5ciuUBfzAIL0pH?=
 =?us-ascii?Q?dbHZcq9U4fijNPx/6Gs1BsWPifJBr18ZZ3HVwv5NhViTlNW7IeAhf9hdaywK?=
 =?us-ascii?Q?4IdflUvIhXbayWjr0hgmyX7csQt0OLHBWjhUHDiOX98+2/OhoCT4ftSxsnYk?=
 =?us-ascii?Q?Qk0Bwr92tbKaNIA1Ui4o71h6kUKtsbv8S4cIla+Mj3Zd2vOSdKNYNpqfEsI9?=
 =?us-ascii?Q?S8U05ftiEJNp0C2tOXqOQKy+rbPBgbZWEEQZgaP2c99DWTg3CPRD739do2Qf?=
 =?us-ascii?Q?twImVtZU9SlqCTVLelyDriTGBx9cQuVKncCnJCVwjmOhhzLq5vr8W2n2cye6?=
 =?us-ascii?Q?83EH0YccIC34oCo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4NGDe9gvaIYxLR6AqcWr1nwGXCLNIoZu1w0Av7Qc9KIxJuUtfttwj1th8x/i?=
 =?us-ascii?Q?FITKw8vtK/jMUNkTWP0X9TH8NbtSnx5KmHtml4sJa2SepuJK3tFjfA7k0Gvu?=
 =?us-ascii?Q?ZlGGMEcDUCiXCpB+kVrULoEqviS8iW4nrXlpaYgqtBis1jCQxJnAHOww9TtP?=
 =?us-ascii?Q?IjVIvYFObKpPAXdezfQTtnwFNO9+hA95Mkz83bxtRmij0JdH26yVNTwtNkmq?=
 =?us-ascii?Q?VuF2uGE1Y6sh35M0jADYHhfxPrCNgiPK1LT47Wu4Vt4L7LRZEGfZUDUPfcaK?=
 =?us-ascii?Q?QpeTNbWsAZS7tDig9lMFq82AAvnJMDCaU01asNFPnekdPtIRrGOIYZ2buu5z?=
 =?us-ascii?Q?/Sm9maqE0FU/FilOhUGdr0y7WQUgnNu5JwQlMbcN+UOXLwYeZLXpbJm/9cda?=
 =?us-ascii?Q?nXv/NM4Agqq+2aPEVGdNRKMmgFPLFm7PFX7FE9dzmB409p89wuWxRUuy37sw?=
 =?us-ascii?Q?8oCZVSmkDw8TrFc9bRQ8ibZBFGMpULq7q44QnR6PqCqEbTIx2IxWyFmaubID?=
 =?us-ascii?Q?Vvn6HgipM/W0y8eULJNC8cL6m03eocPMhG6JNuHUo2gBbaOO+iegetKwcNfi?=
 =?us-ascii?Q?zzo7uGnddvTI4akMTQJm801sgRAqE1xScyCo3G8ZDu6VOy+bUnryJrwGxk9v?=
 =?us-ascii?Q?nh5wNLuY/LyjoXM0AxJG2v5Gn8+rbugI0tpEOSsthITSrcpXSBDfmT/vuDAF?=
 =?us-ascii?Q?kz4/4ZSw1Y1SlUQ/9F4+LO7wYwxI3f7fkynWevwpqAXHfzikEuw0Af9fADa7?=
 =?us-ascii?Q?WmgOn2YAothvsSEQSLxt1IGeSnJE4eCtg67aDLHQaJBOptqTaip5QbyTeUly?=
 =?us-ascii?Q?rQikLBn2OU2/0ex/JCLT5gZn0mb5XAbLImQ95a2p4uXHWzUSK7fwcpS28MQ+?=
 =?us-ascii?Q?2Mig7mRUF5c+mhjwPQ8CU7YAjBxi3kKcebKUvksfRy7LdmM75arp5eDX+DSi?=
 =?us-ascii?Q?lIZXus96qxTaYRDKRImk0eENBPSjgDDENWAXKJi+ArWRZh12p3MEFnn9UZ6X?=
 =?us-ascii?Q?nZmpyicst3l331NKT9Mw5bD9Xp5xKmhbNQPpS1AGPsCMcI3tdfL7q7wxFul9?=
 =?us-ascii?Q?opDAcSIKlOMMyDafqaZ3y62s7gHuRTkaR4y0NxqDBZJ7ife470zq8LvIGrbf?=
 =?us-ascii?Q?2oBH6LnPGVm4gzI62YVlA1GXB5xluBqbDMLH7GQFjp0PnXgtj8OdA9Yi2wL2?=
 =?us-ascii?Q?dvFgK8PbMy+uXTVepSROZvKMtY0l4CodkeAY9rweWNUX9WiRnEY+bm95tELw?=
 =?us-ascii?Q?5IEcSQF82t+2EEtnzjFMgyRrqZBQZQ6mZ59XmRyYEqMBrDyHGkiOA2N75FM9?=
 =?us-ascii?Q?LzV2FQWg83WRnDZzD0JTzI9ijQovNqvJhNuK1PFq++Rc3LqOmbvfZcqKt3W1?=
 =?us-ascii?Q?33Hi3lnd8ydC/deyrrSuaeflWbgYmFEnIZ2Z8tvAsWZKvNADZU7TKVpNXbj4?=
 =?us-ascii?Q?3MhVFyVvUbXHm2Go4dZ2WuslZpxdio5bG6Z6bE1qCH2MzIyZIONQvBxaalW7?=
 =?us-ascii?Q?DT2d6/CaoHZgt5FbZfai6JQBanN15p7OiiHeFycu1g2y9yD6FjQhEQ8tSjV6?=
 =?us-ascii?Q?IKmqVd9aHcULrRHGPzVrdZsGfCNBtJeHcYXw7JI4DAUUm8ko+693AtfPQ2Mv?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12eac5d-365a-4135-156c-08dd8ec2b0ef
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 06:28:20.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pr3xKC0lkuyC0SBdgw53dcRyNDU6YA+ku1j8sDPSUgiMMDAiryYd6xQE3Tt5WEtMyi9eowvMK7l4YHp0/A7ovwk1d7sYToEa0BqenYQHNlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
X-Authority-Analysis: v=2.4 cv=BajY0qt2 c=1 sm=1 tr=0 ts=681da086 cx=c_pps a=IJ1r+pqWkCYy+K3OX67zYw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=CXR9pdGyltkxUn7QIsEA:9 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: htdx-6My5YPNmAjxNk-rp8qPfWdtwGmQ
X-Proofpoint-ORIG-GUID: htdx-6My5YPNmAjxNk-rp8qPfWdtwGmQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MCBTYWx0ZWRfX2OtDyfB3LvrV qNifkx1mg+6V27agvnilTY6w5Gheu65VBVRXW2tF52BkikD+9LbzAF3I7R59GNJ8sXBAx7AXhL0 fDvczx7M9FoofGwt9SvY3lLIbkPpay83wslaDr/ytDnVaeWzFl66EmEJS/5h7ecyGIoEkBx0ryq
 uq8ymo2m5ZgqZqU5fYydnU9kIjg83Ic/m/cHoEbP4UNMkKJ8KDJrmCI1QXLnIybF3W1ToNqjHPS 5YvPycxHEoO89G/JcotzKjacQXg0hP+inj0ZdV8WH5dNAqVRqUQ7LIHEmDXxiBljKB3JkRdbi1x wTNlCqhB8eRVzDAftzMff+hvBn2jF2ZiBpI4AR9BSHyIkERzi9I5ulGRJKfsPc6R8NXBQdNtj/O
 HfHEO6hJA//LMJwZnENU3Kl54KR1j54X+76BkeRjEnfvgYxHB88hImGw4BFy+DzV4izSCxX4
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505090060

From: GONG Ruiqi <gongruiqi1@huawei.com>

[ Upstream commit b0e525d7a22ea350e75e2aec22e47fcfafa4cacd ]

The error handling for the case `con_index == 0` should involve dropping
the pm usage counter, as ucsi_ccg_sync_control() gets it at the
beginning. Fix it.

Cc: stable <stable@kernel.org>
Fixes: e56aac6e5a25 ("usb: typec: fix potential array underflow in ucsi_ccg_sync_control()")
Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250107015750.2778646-1-gongruiqi1@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 3983bf21a580..dffdb5eb506b 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -575,7 +575,7 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 				    UCSI_CMD_CONNECTOR_MASK;
 			if (con_index == 0) {
 				ret = -EINVAL;
-				goto unlock;
+				goto err_put;
 			}
 			con = &uc->ucsi->connector[con_index - 1];
 			ucsi_ccg_update_set_new_cam_cmd(uc, con, (u64 *)val);
@@ -591,8 +591,8 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 err_clear_bit:
 	clear_bit(DEV_CMD_PENDING, &uc->flags);
+err_put:
 	pm_runtime_put_sync(uc->dev);
-unlock:
 	mutex_unlock(&uc->lock);
 
 	return ret;
-- 
2.34.1


