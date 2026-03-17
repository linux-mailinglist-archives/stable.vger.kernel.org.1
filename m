Return-Path: <stable+bounces-226451-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GOSCgKMuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226451-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:14:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BC12AF2CB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A7A0309FB25
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7142B3F7A84;
	Tue, 17 Mar 2026 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="RzYPfypG"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C7357A4A
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766770; cv=fail; b=SS2dxnh389U5InzessCIapTNviyjYZfRRU2KVGtzE+w/0ztFzfdem/1ipuOjYYLCMNHcI3gy1taA61BKLFBQRIReN3QV4j5xBFEvCScF/R/P8+kO/Snqh/3H8P081MoeojZaaxacJWHRJqdWnzS1Fcm9b38dvIJJ4Z1k1ajkVtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766770; c=relaxed/simple;
	bh=ypYLzPmwDZawMhJ5CpU5bjvikyNp6gBD8Au7FypGfzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oKdNVKCxOEkhjwouwGRolCyl2B3IwmrZ5q/l7EnKzXUFY0UM5hqj7gCCNgczP4Ivuni90PER3H6BqOiecbhibzzCUDEk7/z52hpAwbwChkDfYaAKmtmTKiuOLMJQOKJO+mWbvetnAkPN1lyHSmHZAAXo+HSp1deKr0zKq+zWM5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=RzYPfypG; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GNJGfr2339267;
	Tue, 17 Mar 2026 16:59:22 GMT
Received: from os0p286cu010.outbound.protection.outlook.com (mail-japanwestazon11011054.outbound.protection.outlook.com [40.107.74.54])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4cw11gtb5r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 16:59:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMBM5tUXZGXjaid8NMZ4giHJjjRxjugUhPLKEQ3bRq94mkDTPTrh2hb+VAKU+a7157cKKyKF7A0YaQS/qsJ72RH8phoomgSdy1cmbYrIBA/8npU9UzTO8TU35PbKPBvoaHKu5YeS6K2bPc+kjJZFOT/SQfSnDEA0VVIj8yEmZ1UTFuxgfWAwrSY0TUN9DjicBCSWuMe2EzdP868sxXHS32OSAE7B/YfDiDnkiC58HKfFKHP/IwHlvHzdG7TW0qmZ8SuDGxCi7ni9WtT3qLj/aWF8+kPLYnPbIZn9EhN8XKYIk0bE4EMPU70VlGpAka4hKE4SAN0RV8gP+cb63Cw99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcyOv1Z3Y4V3DG+HTIAIal3UmI8QFmC74UKUFPigk/A=;
 b=zSJ5fMQhNhCD/bw0esw0zSdjZyAKeJZXRjU54N2RquxTWI34SG2XXqzhxz3TSnqofReUqjA0W1PsMEx8xwmqSRQByiw6rW5uawPdI0zDeh0KdbTHdw060KDTA4vTbHM95E/7+Bfohogk3gpoY/coF+hHYgOyl3XfpfDcZ7I07DWLy0dFBRJMuuMj5DxnZbSMSaNiX937Wp+8/xMr1Dz+OIhXymuXL6Vmleseu9kAreLTX4nCpYJuc6Z76v3CPkC5vosQi1kI1CWk0hq3w2JhRrQxPP4xrVrNHaCDYUNlPA3gvt7PErWw42N0mkSAeGOAjolyr+0tFldem8SzrQ19eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcyOv1Z3Y4V3DG+HTIAIal3UmI8QFmC74UKUFPigk/A=;
 b=RzYPfypGQ8S14cCabAsZNQFXE2AB2W9wy9WJ7ReDPkSh3JE4gk6OeV1Nk6iE7SBv4Vgl6+ojMIcEd3mZTqI7J1V0la6WexeoCWEAkP5+p3gWntcFESlLIRI6C2dRhczeOF7jxAmF/VoDCSujJXnqVtf8G92pcljJt5h1Biws7dtkB66I5hi94ORae8uNqGOKyrb0Xv0ljUX/ae9HTY/xob08k72cx4htB24boLzdABi1vPgKaLq1tW5u4Xgv5BgoL1bBV3jzP8MtDehUigBS9sl+Q5z9KvEi4bwsWwSZwuVIE/iaACjDUxnRAwSZ5lJph6g44QYwDFAeIoGbU8f2oQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TY7P286MB6609.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:326::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 16:59:20 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7f13:e26e:3d72:9ab1%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 16:59:19 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6.y] iio: imu: inv_icm42600: fix odr switch when turning buffer off
Date: Tue, 17 Mar 2026 16:59:03 +0000
Message-Id: <20260317165903.745349-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026031710-candle-hypnotism-fa31@gregkh>
References: <2026031710-candle-hypnotism-fa31@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::10) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TY7P286MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cbe2cc4-455c-4651-7472-08de84468803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|1800799024|22082099003|56012099003|18002099003|7053199007|3613699012|38350700014;
X-Microsoft-Antispam-Message-Info:
	E6drUXfnYZtucuuzkUpu+fFOUululAMwLC/SdhYbePEsLRXjYvxWbwXwRLXwfrW/imGm5Lo832Scp4GuwsfK1KjZMQFSFayhS2ELWHBHY3eu5VcyKbhSWPGgFbhXm23mAz6REhJj3/TIoG6vlpAAM7KQV7z/cqsMACpzbKIJvaKCKSpEx3zNmfpj22VNaeSOEAeDzn/MAj8FGAD1EeFkZLX1XqGGDoUc9KyVj142mxRrbiIRtvRJoa08zqKwKhGuZMMoL16mK0u9kKW2hYjliK9xMqQ9fFTM669BE5Ur0Z84RHgKD8AHxmrkWgJkSO9zFcNCMfl2rDbz8DbjGeYjzMFuwL0S77T8OChL1auDKkpPCjqHcpvs4gqJGiK3zKk6ZXOYOkyupzCgvjA/jCgmiwUN+zx9I0Rcr8Pc03JnJLm7P7NwPpCwDTTu1nX6sE51OMtBWG382Td2ebA73K7qdL17/owMlUYEgPOA9o2q0dbbNnmgaUkeyJayg1NOdTfzR1Iz6IF65Qg2Rzqylx3fDdeUy3kfnjdbkD7yHi/90pgqvwAKQFPgyrFfAjN+8MtrYtxvBEZ1FP9ZeKIC6vFaNY+7NDCx187i0I3ZaG5jdy4sfiD5zXtNsmmNaJOoMWn1HWrWR0hMN16Sc6CsX/aQYvkNNjpGn+3MhtWBIJipNGgOFbM2tplhDCeX73Tt+Q5TFBcu4D1hv51+qFi4cWl5DzGFbXdZUEhmpm38Esr5EWJrE8SPES4oPcNDkFXTTFFMCvj0LL3u3tFOS0osvK0d8p+NxrlFe6TpWKd74xbCdNhjhCKyoV+lrOZTvRpBCQqm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(22082099003)(56012099003)(18002099003)(7053199007)(3613699012)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zTn21XPUxCTcjMVLN8d5lzkZ9gFvxdQl9XoqTB07zzgwQ73nZmgjuJ7cWw2O?=
 =?us-ascii?Q?WgPsS9R7qjg0xhkeFTq0sOIPB7SOhdOXY8mTrgRiV8StjusQqKAQMPgfn4ts?=
 =?us-ascii?Q?uEZJeaO98uZ5bMvUC4uaaUGgg8vXaqmdFHV6eqizRQK52GCdr6ZPrtHvyM18?=
 =?us-ascii?Q?aZk/9q5B8JBm6AZAAWh2MjdpZ3cKC1Kf2Wkv8h2o1T85MTYjtBsdugmjvsAf?=
 =?us-ascii?Q?od2+8yZQGWa5xKv9A77pljwoYMNCXxOh5KwX2NZHlRzOufdjvpaqY/gWnLDi?=
 =?us-ascii?Q?Cgx/AQCpo8nTFCKhO4QVjb4ALc5HYZoOVvcoe6DpM7gnIqX1D8Dw3cKY209t?=
 =?us-ascii?Q?0zZhWhvUb6u/GfIkGPYQRcQRD2KROxPF9EFcs9PDaiBPFv5XBziA20xMF56H?=
 =?us-ascii?Q?l1oELl7TQ+Jy43qriEFV+cB9qwC8WZx4pepFzP4w/CroT8xSnNemsZak21zQ?=
 =?us-ascii?Q?6uOGwtmmnNn2tXu0wgTvQEl7QvX+9+TSMLM0orhlxqJCg2odKUSlng3Cc77R?=
 =?us-ascii?Q?BMqVY5P1tbqBDaEQrv8dLvKtvOTj1YW3zWDYRJWD7VYaLTpeJR8WGuTTftOx?=
 =?us-ascii?Q?YhtJEGIU4NWjQIeAPydG0Kdmr7NJ8cE3YIf2M88DmrIg1Umreikp8XJD3qxb?=
 =?us-ascii?Q?p48QHAOuwb6iLK3TOJlvBd5q37vW0w/Lk+bi3/4H29schxv6W0dzS+CvvWdN?=
 =?us-ascii?Q?1lrtzpY0rXv1plxto4Ad3TUWJFSeLjsb4/ODmkDeVyT4y3DSAWM65MjM7+7T?=
 =?us-ascii?Q?RD6TE+ax6GzFmLIswbG43HSR9dwecjRPTk+2VwYrfmsIJI7JBxoRQzDwDNsX?=
 =?us-ascii?Q?pkfKF8yTaV9h5lyBM666mlmRA/HmltLYCI4LlxmV/dTdMKBHkY4P2UaZOtJ+?=
 =?us-ascii?Q?A16JkSM/YkdmzSoaqwAnsKyfi+xP5y/v4vLS2m2Be3rWkYiG64RHk9LrpUw1?=
 =?us-ascii?Q?oG1975Z2TbJM5jUecLKPou8oGtPmpCKDYvpC89K0EnRa06QiZWs9welOA3nb?=
 =?us-ascii?Q?bVnIV3xLQtaTu/FrGNbw06r8K8HN1i2rhCYXGygS4fuMA0kCjEpbev7Zblb9?=
 =?us-ascii?Q?IuMk982WOhol3CKWW32RtBN7i5CrWtX73uX/qyMkxOzScu+9u82AC3n2C5pR?=
 =?us-ascii?Q?1WeDRLUPosbs1zx1laGieCsgKjz5+XzYA/7KP8lxtvUs1/2yyDy/TO6UhmaZ?=
 =?us-ascii?Q?N9GQAQFmu6smKenBmChl2lRHboo/fbuOdgp+Dntaiw9b6S4GI2sm7TDqMKUh?=
 =?us-ascii?Q?02xDj2Q46ytWJ7KJD8a9hsU/yP3b/Q49fn5qjqvGmYSGViSn6X57Tj3iF4Cx?=
 =?us-ascii?Q?mXYzFpenapo1A31qLGHzn259wDfevxvB26gXIasQllRiSbrlMjD2MJoowMFN?=
 =?us-ascii?Q?3QFf3B/BnFliGb3fs1g98BFulqn86nmL67VSAmthRez+s6L4THB4Tq3g08N8?=
 =?us-ascii?Q?Sud3vNiR5+v5KV1+HhYoDLq4tRsq5uolFQ9RVCofJMGCtTbGaRFJS2D2qP+G?=
 =?us-ascii?Q?aBgIXLHRnisEoWn5XhutmbyzxDXlXpPYVyZuS2jxFU443EoZlXIrBCn80vHs?=
 =?us-ascii?Q?N8Qmmnlfp2hS4VwqsCoGH4UYPio8w2AUGJClhI3nFv1FhxVMKKiwuE/ok3w+?=
 =?us-ascii?Q?oOiuw3B/UoflXxRyG+m5++PovVEk8VhWRea9ojQOt9D0bIQER6kxcajoFEQq?=
 =?us-ascii?Q?gUA2ZyYpj2KwmbOVwyELr01NyOX/c6XcW0KRmMajUs1RVHkYgPqnDFSgh5e9?=
 =?us-ascii?Q?rlf5OaPCWg=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	Tc0do/f3k6EWMQPYP/edV4tBNsQ/wOF8pbvubvwZcvXATxqIzHCy7/PKuDM2S16KZGBsgRrgiDQaNHb91LS5HTg9io0Emkaf27ssrZ4n4IkVE4YcqKZiOTuPDgxcWwOINnrMlXJoR7Dz570/vzkEESP7tCUzuzJNO3ZwIoWp81O35JNdVRCf4Vi4ukSqPhD6agr5FRrIsxqANkbW2BViWSmaTA8du6sytfgnKhqLg6kL7JbRksHrAOJQPtztr3aTPnagcwMCz9a5imwJX/AngqytmIXbBPnwEJXyRkCRI1CWQIoUIy2iweK8TcdZNYczzvsIiLvJxOceR2Rd5BcDhg==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbe2cc4-455c-4651-7472-08de84468803
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:59:19.9136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnAsdczKqxWmWaGolMLOAe29WDcMzPaP22ASJhKYzV+gwDvBOdGnGGrNFXVUTRZ3Ddkm/McHezmo1Cgdbjhp4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6609
X-Authority-Analysis: v=2.4 cv=AIx+R2tb c=1 sm=1 tr=0 ts=69b9886a cx=c_pps
 a=85yAfjzY1oMow6J16d6OIw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=Uwzcpa5oeQwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22
 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=dmF26TSAndsNLafa5AIA:9
 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-GUID: 0u6AysdHIGOIU3Mqm7JyHgRp1xYvnTVQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE0OSBTYWx0ZWRfXzBZCDVfS+QzY
 DPhNdDQxSVomMsmOzLNSPNemHO6H4of2nhjKa4d49Sf/92zxLUjJnPPJq6wJrFcJ1zUzwVnKD0x
 O3FP2pwZ7/TZKpKjYV72aMdUxtvW3adezyVFrx4q9khYGBzLdZWSouPY0XR0qV/DVOn3SsTz69b
 UyaVYTHC8BhO8FeMcbSh3DX/xdrmfs4LpPupip8FHCd6/TWMOVhiIoXqZ21MdaGmCS0K9dZfRgN
 1O5FEL8bxOlYEAgry5M0U4T8vsWkhYTExOBbZQWJxbMmMj5CDRykC8n46Cob9gYh8V3aTexLUrQ
 gD8b8j3z55AtGMBIOI0CrVr++cFa2UITwcvQjWI3JhdVu+bH3UqA1G89Wi8aBHE81IFQpfhi/tY
 DLIJKRy/SwgtAXIflY37StTTT3PDcJ46u5d+d4dC/usQTsU7R0ccwsShqIacbSG00VjW6h/IE42
 07dkyQAE282xhLRBDqA==
X-Proofpoint-ORIG-GUID: 0u6AysdHIGOIU3Mqm7JyHgRp1xYvnTVQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170149
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tdk.com,quarantine];
	R_DKIM_ALLOW(-0.20)[tdk.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226451-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[tdk.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,tdk.com:dkim,tdk.com:email,tdk.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inv.git-commit@tdk.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 26BC12AF2CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

[ Upstream commit ffd32db8263d2d785a2c419486a450dc80693235 ]

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
index aca6ce758890..743580ea5845 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -378,6 +378,7 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
@@ -399,6 +400,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 
 	mutex_lock(&st->lock);
 
+	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
+
 	ret = inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
 	if (ret)
 		goto out_unlock;
-- 
2.25.1


