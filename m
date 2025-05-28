Return-Path: <stable+bounces-147908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2152AAC616D
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 07:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A139E2E3E
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 05:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BFB20AF9A;
	Wed, 28 May 2025 05:53:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9365A382
	for <stable@vger.kernel.org>; Wed, 28 May 2025 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748411610; cv=fail; b=CSx/3fhALvKYYIl2YQ/cNFomn5jQr3bdqOTiJZUN910rol4cXdBZO3OWNaqgqzn/dVg0pufoTZELQOabrjC0Bh1oor/nyHRNOhMtMmPyR410+A2DYNGoJQjUvDpiRm+AhB04A/7dxW2tej9Ve/JQT025Z+T21STXu3OA8jkRjeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748411610; c=relaxed/simple;
	bh=l+oUwKJE6me/c4D2Z5tUKFK2ifN2sI4e9K+kH+7ryrA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WPuFhtxt2W3450vzSbrrrwBKFbD5rh2q61cU2IAlqouJj+q9bweDyleDlQJhS43dbYdoDjbukagXFfojJHYO08Lj0/k1iwJeitKafjX2GgCp7BPbRgKUPbtzhnBBDtMNr2QiB+OGrQLk4ERErHt9R3gasnHbufom3AF6aF/WGBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S4ZwuT009748;
	Tue, 27 May 2025 22:53:04 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46u9d43hbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 22:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJf7ce4+vltUqNbNRIDcfNUysAN10gIyEuNGED/EkgJQDF64DjA/kCrBE3jI7uQmX9tx3h1CJyDuDIAhw5l2SIbciCeIl+8Kllr+YdlAOLgaNMS/ifsWHzbKHGVDiG+RFvRXasZbTdGS5nXpdyGIULYriDr/fWt1t7jQ7OsnRN2/QbeFDDjx9v16Yx+HH6WUwSq9gdVcu+JWvl6JsXxfV5pf3CK/KJ7ceGkcxwUrixLpbbOe6myFAwEM1x+KeH9foCr6R7CMkkZfG1gb4VV8mHeciNUleO8jg2qX8UH7HbeXiD/0gdSocG1mcHoBeYGgsFfCUinwVYosMY7zA8PQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2BWOV/X3Q5OpjSJIyihdfejXj2g2N8rdyri3B37gto=;
 b=MLNiiJnE+Ll04NfiX7buaRC31AmwKzw1HqqLNz1dIXjZm9jL8ovu4RLL5Gj6OBxc7kTSBQjRlhjd2Jx1F1G0FyOcqvqR6INm/MOwW+WUezex8Vcs2cNLlsbaKr+5HCspvvCDSy4uu7n6XMkhLGkwnaISSdiHQ1+2VI3YWQFLExhR7QCvzV4lYQ6JvCVkZelutoXsoIK+7e9wQOunyePZ1nvqSqmxfjaRxYqCDeDdB8WpbLGrC4VfAXCU38ZebXnyTJR0fNjCGffh8VzoMbyKjfiTy6tw7WZH7TXOCis5muB7fFIKh+QJgeg8w3fJRJQqA9g6D/9DeYdmufHRCml8Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN6PR11MB8170.namprd11.prod.outlook.com (2603:10b6:208:47c::10)
 by PH7PR11MB6930.namprd11.prod.outlook.com (2603:10b6:510:205::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 28 May
 2025 05:53:00 +0000
Received: from MN6PR11MB8170.namprd11.prod.outlook.com
 ([fe80::a943:8506:56e1:43ce]) by MN6PR11MB8170.namprd11.prod.outlook.com
 ([fe80::a943:8506:56e1:43ce%5]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 05:53:00 +0000
From: wndgwang4 <guangming.wang@windriver.com>
To: guangming.wang@windriver.com
Cc: xjgwwseu@126.com, xjgwwseu@gmail.com, stable@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Zach O'Keefe <zokeefe@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] selftests/vm: fix split huge page tests
Date: Wed, 28 May 2025 13:52:52 +0800
Message-Id: <20250528055252.614656-1-guangming.wang@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::35) To MN6PR11MB8170.namprd11.prod.outlook.com
 (2603:10b6:208:47c::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8170:EE_|PH7PR11MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e49d2c5-44a4-4751-74a8-08dd9dabe6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cz9slzLsxwRPxi6PjNyH0JZqyKGg9QVEi/8qMIH/xP3kvfHJEbTRQoYMOfkF?=
 =?us-ascii?Q?AlodFSOf9CdHdtE8VxeWFvMWbRLO5hEued+/5nKFUW/5E0CgTjFMr/FcN9PI?=
 =?us-ascii?Q?fZgNIjGRfstucohrcDV2sM4mprOW++jJ9eb5ZNcpJJXMYjAeUm39OomoPgl7?=
 =?us-ascii?Q?n/TzwH94BWu0wwYJ9g6YRmguLbo2CbsvJfnTHTQX1hzDtXlPP7vbumttUnC+?=
 =?us-ascii?Q?q9P1MfNfTB6gBqr0klJUK+SAhI3T3xFpTPCUPreZPPna0mueJb6K+mZwo5GS?=
 =?us-ascii?Q?7nMyKBaXsdu9j84N8hQothlijoA4GDwknhMLholBASOFYSUbc9vSQb9dxNBe?=
 =?us-ascii?Q?eP38wahyqpYDaMvkNOuM3dz7oPCV5EzyBFAmA3Hmgh+6HE3as/NKEB5vk3kb?=
 =?us-ascii?Q?LCL1pivSEeEBfcYJkLOL9eo2QSUbBBFP/WegBhsPnwe/cnMoc8PYci11HEZ+?=
 =?us-ascii?Q?zOFI2DLiJsyudc2eySiMWlikcgqzbb6xKwZqDpSV2Nt+dl7C/sHS+FqnRjeH?=
 =?us-ascii?Q?QxXzW6qnQxrzkOGGDke2pIPFEMj0dJOTXIAWraA8+UjpNQvUo39FgMZq+02Q?=
 =?us-ascii?Q?1WWgdXArl5/eA4jAJaLbWyxQygXO6Mg49VRiE0HvYGDwB4EMtzeBhLskCUl1?=
 =?us-ascii?Q?L0nKlnN0UpM+/2gbQLepscxY2JniqCmDX06Yu4OszPIsatHQKvY6tvaXFrpG?=
 =?us-ascii?Q?tkzxlyUehUTf+KSv4kmWab04j12I0Oz2HEWrcGmZYk/rIZJuiAEl5FCe+kfS?=
 =?us-ascii?Q?SjEe3gL9/YN6Si3+nSWKMrtZFBvd6abVu3AgVRupg5tPf9K+dCUMRnhVZXU2?=
 =?us-ascii?Q?o88EJYeLaE1J3IBxZ+7Jfv8iy1lwzHsG8MNafPTUDljvM5f4Yc0qAPWLUSQV?=
 =?us-ascii?Q?0y5PQ1k6Wg8ip+pYYDenYhj+6D1lzjSdtuSF6nVs0YAR7HNbULumiA78Q8qU?=
 =?us-ascii?Q?0jLhHKgp8+2oxiba5/0MFr+3zFbZzTZXIt+Jk2assQCwCo+jDKatRyCZ3c5g?=
 =?us-ascii?Q?RAmQzod9L8WxMcSGD3Yar+V9noD4ZcG94S9hUr6jkneV8Ng25w4hbuI6BtcI?=
 =?us-ascii?Q?qGwdEPpj6dZLm4ZsBPqPbkpGgmR85TIfiDEMGbEpYge1x+DEcYU2Xdzj6idh?=
 =?us-ascii?Q?cVHmpjNKeRmgSUIkf3Dc0jVZNALYTUiUN8aCf1issgtbODyMwlBPly9SdTtj?=
 =?us-ascii?Q?bJ9hCSvcNeqgNAsi+mwO5nsi/gE9PTUhRbOFkhlT5dXh4TwfnleFyd4Z+2/8?=
 =?us-ascii?Q?aae8dnf6/tT6lNvEKJ+z6TzgpbOc4Pb+vLZ1Spd7p8BG4DVjKDtSJ7M6vQaa?=
 =?us-ascii?Q?2OZskH0+YZWEMj+1pUCu4gJuPS837vwYukb5eX/fJfvvGDwFV/o5REErrh35?=
 =?us-ascii?Q?8nDDeS7LvLomnyLrCZduafIzc7VWqfWm4nxLeJtj2zNsEAwwxs14H6xi8Lc9?=
 =?us-ascii?Q?NvdNNdgbjWalwz3I/Q3Nkm6JvnkT1v6Dw1Ts0+x7DKHf+/ipBeRbnoH5btIb?=
 =?us-ascii?Q?dmal3YgcJXYrSAPIp5hUrlrEIN16kOCe56Jl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8170.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2CfPk/Zy67YALOgeOpdsA4HANvO1OLQ4bXzejY8NyGrRbYDqUtRCYAa/1c3n?=
 =?us-ascii?Q?DJDkuC9Ku/s7dm0ntDvqtffywlqAlirrTJf6+j3OlNZprBZepT5bVRVjZTdm?=
 =?us-ascii?Q?Tif/X2IIx3Dnqf/Eq7yzU0ej4BLkDQGRuvc3ZP96+ExuiW+6uLX0tgogdVED?=
 =?us-ascii?Q?GiIJl2T4mD3ZnbyVcx2mD+Gz6tSjV+Ky87kYDmWPOUIeDbzBrA4joVDw9Y/2?=
 =?us-ascii?Q?j842ZVAFS8SXPW8+wKolHhMIKYAoi7jk3sFR5NrLL0ajpsUloCJzNpgk38DZ?=
 =?us-ascii?Q?Kdr1uQjrdBDxH7PWhdB2OYK2/zlFzV8rNK1M9+S10TVhXGCTb9nNw3wCu1Ul?=
 =?us-ascii?Q?8bH9V1tNdQM5/um0SXSu0u32dGk9zYWFMLuM1v4WQBg1/sZePIfafYFllQfR?=
 =?us-ascii?Q?g4cCMTXCfO37FEd7qzYMWrzOBmtsWXBsufRvL0nVS8fKm02URn32AnlwfSeq?=
 =?us-ascii?Q?FjtmFAzBCflY6PWybPSJS7aLGr/Q7BG7lTUlLMCBuvHM30zRQmtDYp5L2RNW?=
 =?us-ascii?Q?jcAP9DlDOAXJcTnHH2Xw5M2ZtWdmfZ1t07P+qMP4uY4TFHJPE+sl+QoTVmA8?=
 =?us-ascii?Q?LneUEQRJ0Pq/Kf1NPpYBlgdM23Na17EtzBMxoRSA099O92vc+LxHpR2ywvZl?=
 =?us-ascii?Q?zdGYrq1eZTFVpZT5/FnAQ3BuhJYqGa6zgl45mBGf+B4Drn9phjlt7xPsDvb0?=
 =?us-ascii?Q?IBdbY1/qIOzz0/cxCxQCAwOWyIVEgssdqcoL7V68Tu0B+YeKmLp0Xhhx1WfW?=
 =?us-ascii?Q?YqR8+Y+sbea4/rIbKiGQEiSBtfn79JjVywW3kh3exSQ2qQuziwrZrEMicNNL?=
 =?us-ascii?Q?0YRBZHCay+l3mn624Wyz0lpSFjDT/0M4gXXwjmLWhJX8YsS0TvHZb7G9DZsa?=
 =?us-ascii?Q?QvSd4k8YqMmWJjyOkY0WFtQq6wdtTybbfl0VUIi9pf/+qhwLUZMxheLz/YTS?=
 =?us-ascii?Q?nyoKU5mplwMm/BsA+/tDDaRTfCjakBf9JSBDxvW4qDZIB7ZlADU5PnMENpJV?=
 =?us-ascii?Q?juVWl1EYfWHv80b5wqQZkktJ/oFPFfhZOVYrfvWScmx+juzwiFLu5agCcHo6?=
 =?us-ascii?Q?kVYZEq9fvyVmRg1PVpa3nql9KZU8B2sC1F0aQ/GVnMhQ7GnGVcjdGwR8CbEo?=
 =?us-ascii?Q?4uFjqcIHXxB29H8h8KVMN7R7QA9bg9zII3SmbUdsrIKkXQF8Vx9t81t+4Cn9?=
 =?us-ascii?Q?SX5rk2r147yonsxkL9JCBt+mJUEBp7U8tp/szA0/zXTAIPO9pLsPl8cLLA6x?=
 =?us-ascii?Q?q0FrGzns0N7umF03z9pfFgtf18zKLw/laRGjkzoa+/IS7Lw0jD6PlN1vnz8C?=
 =?us-ascii?Q?CZe1mwiQTacl035cfe3CMO/jDGBol5UorM/F7tF0xfCqFdcKWk4kRnIYuZ9e?=
 =?us-ascii?Q?skvwtRVXinGxxSRp8bFoBE3b9PXpEOXO+89H/on/Nd6fTkVrznlypUsoNh7P?=
 =?us-ascii?Q?DNkRUtBSanQrUDQ4PnW2iGye9EsL4H7ctVanQ2coILylLQhbXP2SwA94hDZ1?=
 =?us-ascii?Q?YLDpNywWfyd6/9d7qMdaiobagK7QQuf+3H0B7NIUjKkw8+waqsW9xmieZdrY?=
 =?us-ascii?Q?M6GRkRiojnojIhHCekFMOUFhrpAODvSivisl/cZdTmK6pSqduUqDi8X8cn7a?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e49d2c5-44a4-4751-74a8-08dd9dabe6f6
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8170.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 05:52:59.9731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78HNMEVncHHKVLYJZyv+r43W7bTPJDz8hB+biDs9YdmSoiRmkwmW1F2kqPQvlVSxipzBIu0qBPw2qV4AU7cxQ32sPzu+sdHyAIrLvPAjW4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6930
X-Proofpoint-GUID: hipGONWuglfYe7LeG7XoMLkOXRgeGqOG
X-Proofpoint-ORIG-GUID: hipGONWuglfYe7LeG7XoMLkOXRgeGqOG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA1MCBTYWx0ZWRfX5a5KcONQo9dc TjQEwjjt6T87C1diFWo25lt4vFrqFePa+shfepnb0fLgbOGKSWCy/0/WeEkJvHYhVMtQNWCSsyc +uawiLb975EuPptp93rIYoZl7NHSd05818/xg6NKusMoCZpy0EcRvio79gk1rygSWfUWpTiE3Jl
 2YVYTUwf5NLx0BPkTSGXMs6+R3HZ1q+kRXLe0QMRFCNQAZ4cRH1Ktq1tzKXqRdoJXDg4GBZUe2J xn2Vvn+c7QgT4+el72Sk7yHnh9tcUZBWBzHATYR0vKxRE0YsxLWL3I+L9rK7/StUHzl1s35kwpa 0tLYjFnVVDvHDdXRR5Knmbg2JzhO5zPzifYWwdr0mwAEhEGrXzLawZ46tnKfyYuLcnUFkEliw1I
 ezK+4wZkQglcLpGRzEPwO5JOx5k60tmH4Wh9QbP+hXkxuAHxckyH6litb9mwpv6wnv54LCSz
X-Authority-Analysis: v=2.4 cv=fdCty1QF c=1 sm=1 tr=0 ts=6836a4c0 cx=c_pps a=0X41gtVjVlASHecNQXUhFQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=UD7uQ7OiAAAA:8 a=Ikd4Dj_1AAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8 a=t7CeM3EgAAAA:8 a=hiaTr5BkvdKmfNpcCjYA:9 a=Zkq0o-JBKtHmMz2AGXNj:22 a=HkZW87K1Qel5hWWM3VKY:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 clxscore=1011 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505280050

Fix two inputs to check_anon_huge() and one if condition, so the tests
work as expected.

Link: https://lkml.kernel.org/r/20230306160907.16804-1-zi.yan@sent.com
Fixes: c07c343cda8e ("selftests/vm: dedup THP helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Zach O'Keefe <zokeefe@google.com>
Tested-by: Zach O'Keefe <zokeefe@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: wndgwang4 <guangming.wang@windriver.com>
---
 tools/testing/selftests/vm/split_huge_page_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
index 76e1c36dd..b8558c7f1 100644
--- a/tools/testing/selftests/vm/split_huge_page_test.c
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -106,7 +106,7 @@ void split_pmd_thp(void)
 	for (i = 0; i < len; i++)
 		one_page[i] = (char)i;
 
-	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
+	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
 		printf("No THP is allocated\n");
 		exit(EXIT_FAILURE);
 	}
@@ -122,7 +122,7 @@ void split_pmd_thp(void)
 		}
 
 
-	if (check_huge_anon(one_page, 0, pmd_pagesize)) {
+	if (!check_huge_anon(one_page, 0, pmd_pagesize)) {
 		printf("Still AnonHugePages not split\n");
 		exit(EXIT_FAILURE);
 	}
@@ -169,7 +169,7 @@ void split_pte_mapped_thp(void)
 	for (i = 0; i < len; i++)
 		one_page[i] = (char)i;
 
-	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
+	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
 		printf("No THP is allocated\n");
 		exit(EXIT_FAILURE);
 	}
-- 
2.34.1


