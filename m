Return-Path: <stable+bounces-126919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0B2A74632
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 10:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17AD1894425
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6022116ED;
	Fri, 28 Mar 2025 09:19:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77891DE4D0
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153544; cv=fail; b=n4p31Dd3Dhs3QI4lTYFNKC1nPfhb/fORHkY/InvPW1v5FBEtQR6iebf5YskbcW/bmRBG8KI5uXkMcpu1ThBmnhRekE2cmm0VWPcPSyGIYgiJcTKxRwpf1S4wgIs665LRNaS/grNJxEJXXgRtZRerS0RkWqAnKuDz4YIhov8ciEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153544; c=relaxed/simple;
	bh=1rY+5Kt4AhNLTU4OUYD4wv2jJvewR9aWbSQB/A+O8A8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ubVM+PU4TVDtnDZfaW+WAyhDzWnI07uqIgdgIbTm9RguXbMB+382CExM4NRKAImCE2ihnpFn7mbcUX5ixjh6BTgDVhD7TTHtWjKzQGwjzXnmylTBzVjbaBarxaoOcbRsdoF9gTyQg2ZWfb0YzEWVV1Nc9DgV6tVuYeneJPJlTPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S7YTHe017967;
	Fri, 28 Mar 2025 02:18:43 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45n7v7h1kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 02:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIJm/KInbQel7MVEQqr3kOLb/RRuAYii43G7j3q30q8e4C3v8r+j2roV6ETTEjz0NR6C5k/lNSP17X3u+m5T6xt1zi0WU6lxHFvkfXnpUf2ok2KljwOfkrEdC3a2hzKOa4jqkAHEOaB+a+607xfgn6ekLp0i9+25iGGEBZLmTN1ENuSfTwIj8wYCU8DYl73isF1C6YiR8binIE1M67s2tRgKm4UaBQH91/J2ZCZ4+KmP9IS0fcoQ/tXKd+Wdl+9KPLJ6xrWMEUwbz/M7csLI6gjuXzGH3P9kWjK8gFN5BpRTeXwDLUNfz7x9mILoSNylzsdb9NL/1CElGhDyh1pz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uy2ThooeJUHpVzrpXoFKKXpU3iP1lb/YoO3HHYi8aYg=;
 b=ulxWXxz9hWIDSbPcqEHQTOlAkoyRMD0wRHVPABIGAT+ZQ30DFN+IoOniKnCPYROZBsTGPoJ6cc2+KsKzYPB3pvvpKyYKb5kBI88uP7AxhynIO3XQCnGqllqnb6ftlf5YyAff9PY3H7xuLVYOR0H4U9UpboYCcNXZt/LhKdEfqwjvbI+wT9/kkmlrkbtD17A+x6hcWlWUPngrgAnTndy1QLMHEr+bYUeuolAOnE+CWoSf67+0RtdKj2AloGCjoF5toToaMbGx81HyGVYaG7MXlc3Coq+K5BLiho1u/spMmo5EgK5eaiQMKZxs3BfY/xa2ag8NWVrXOc3P+S1BTlcV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA2PR11MB4908.namprd11.prod.outlook.com (2603:10b6:806:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 09:18:40 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 09:18:40 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: rtm@csail.mit.edu, bin.lan.cn@windriver.com,
        almaz.alexandrovich@paragon-software.com
Subject: [PATCH 5.15.y] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Date: Fri, 28 Mar 2025 17:18:24 +0800
Message-Id: <20250328091824.1646736-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA2PR11MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: 694ea72e-08af-440b-9e1d-08dd6dd9872a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rCQK8nu/uQlXvPU+8glhus4pNsxNDRf45TKRitErSAxtpfsb72WW2EnrOQ/K?=
 =?us-ascii?Q?X3VdX7l9mc6NLp0epox5zYG/P2UjwDhtJAIKOXmdvXQVyXjWT6FyGphST3ef?=
 =?us-ascii?Q?12OdI3J3vshtA20xxsAo+ixCbPZDUjwZnCBpy/2wr27yZOEcCozaLT2dsO0I?=
 =?us-ascii?Q?iFJAlSAQQHPEygfXW9Jq0I0GE5NeOaGiidKa10flH863HARKuf8CUhHIngbX?=
 =?us-ascii?Q?fpnPaHzrpbosyNAQz9O2zTp090CuvrLfhIuqs7aXs+SPWFlPz3XHiYwEl6V4?=
 =?us-ascii?Q?MomJfbzpU0iU6BzowEqdCCJQopp0AWOQccpOJZ4TfXr9YTY+5Ba5F54pHJn6?=
 =?us-ascii?Q?O5yn9/XJBKQ3tFCCBzGIMHjT0fygAThuntzDGgja14xrIjIS6yn6V79dVLz2?=
 =?us-ascii?Q?jGscPPQMpMmzFAYC585ov9MXFsCmTPMUf/5fjGneIFLtTPIjzvqyib9GN2Cu?=
 =?us-ascii?Q?iPO1qxEkgwfglKP5Lx0P+kI1rjM/LYe3mhI5uMJ7OID9/ZXoBkWSiP0OkJRq?=
 =?us-ascii?Q?mh12enYOn7hnIyy+QvnEdtq8iH19l1FVgKRB4bnGBihMP4Gf+8NmQy03WZhR?=
 =?us-ascii?Q?ssGi+bT6xO2KdiI5XJDZoTBMzKSTcNHsBTILb2KTKOV0vz5sLVGL3iNDt3TN?=
 =?us-ascii?Q?+oHauy7fLkgLdQZXTxGMrujTEO2zM/wP4NXa8Yp5BvNXLM2qrPif1kGDvVWA?=
 =?us-ascii?Q?aocttHsC0nagFnOyHgNYF7oxUDrWFhTA1rp4EimYlsjZYmL/QJbFuOBo+YXg?=
 =?us-ascii?Q?3FC1pQCbjNKa/y3qKY5OBUg++P2RHj5uAfTbA6dEe3RqEKT/vSnTK8iGiSDf?=
 =?us-ascii?Q?bx4as/g0DCvxI52ICrS56X2trUag+cBLTLgH64KDbpcUkKdTfHtTkw3F0pyp?=
 =?us-ascii?Q?jmR2RFZVIVWTcFbHBd4d6r32L2m8vz38bi5vOPWLNr4DEJAS1vwUcEPZyB1g?=
 =?us-ascii?Q?azk+qBmwwWtFEZMJNjUNlmXrPbEejtJPiYTrEApUBQYXexj533e7fATQrDgT?=
 =?us-ascii?Q?6DNusXK+ubcA8RfvV23HXEJIVy86VKMYXI3RWGy67g+D6bAz/Han0qVY/vPn?=
 =?us-ascii?Q?M+sksCQ8Li1rB4g2nUBMopb7oLPJIPGEMbcU9KUM14I4xt2YKuOjn4IWr7QA?=
 =?us-ascii?Q?KB5ON95UBSAaYuuVBVXZjNMJSyt+LOr1Rzqe55GuUYwY4b2Khic2KBx0ChDS?=
 =?us-ascii?Q?A+az1jhEeaKcxwH7ZFLfMyyRmMfzSRoLkM1qwAowwG3n9DfRYK5hFRhReTlp?=
 =?us-ascii?Q?WFrARJ3Zxvlexl0lMDehxFFoxQIlIbmYy/lPYucAOKcnAIroz0goYqPPBcWq?=
 =?us-ascii?Q?qxfVNcUlYhKPiXM3pslD/aVc5WBMZRx/L7XgSKrrNn7OQmHAWzVyfJZ0Gck3?=
 =?us-ascii?Q?+kf7zOC5r+D+N01fgcCMDO9tm0s3KItiY3IMVVB8H+HcVeP/3zUDOziCDBkX?=
 =?us-ascii?Q?Pvq190u3zBYD9K1AtqOp4BuLzZOEE3RX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kQDcHhq2t9SnOBSN2jKGseU7kxcSUUmf/bfLK8XEO5JgBHrkzsEzBVGF1CZu?=
 =?us-ascii?Q?DLa60jX3WE8IyHcv7rjDJKkmf1bLbjiFqKZrpXHJMnFWIciCTtLo6oDP5d9G?=
 =?us-ascii?Q?fnStJJfeC7XwLXoTiu7gIvblPxCYz1sp9QuohB5hBAuKju34gwpf7+iu2yz+?=
 =?us-ascii?Q?tpkEGF0GzuhQdp0TeIE9pohNVsbBohVPMRtyXmOGcl5znTZa0EUGNy8uQowP?=
 =?us-ascii?Q?qDU2juATZngIjg5SEz1Vpfgxvx6pJAoF4eTqnHJtENedomLeDoNAabpETm8s?=
 =?us-ascii?Q?NMHI+/tOq/nFsoYyLs/1elb0d/E1ocZt1XSu06qWKuLwhk7vrHo78+jQBy7s?=
 =?us-ascii?Q?zd0Zq56ugNqxDRo88L9QdxtRgsP8Chfh3Yu2+qcr/Br9qKsmrXv1b5PUXePb?=
 =?us-ascii?Q?FJ+/fG/4aVKdZ3GW0dCRO2nqlrOJwkiNiyH1Zmzk3aDr0YdUvxGBWR5uLGy/?=
 =?us-ascii?Q?c26vKrbCSaCZ5/kOvRZWdKH01KXPtT33pfXUn9+JbgaxvkWqWH++RnZpxdRY?=
 =?us-ascii?Q?bY030QUj0gZDk/deNhb69YWQ57//egahyvnnEgCrWKv2y8NwgoEMyMbiNsBw?=
 =?us-ascii?Q?i2CeISrWuKbLMGd+Rj7sNL2LK6Z/nKNgXNkCPGPk40EPzhMY1EM/+z02S3L1?=
 =?us-ascii?Q?sIpFcT8iTfAnlT1I1A0OajwH3EywMFg3/oAAOfzK8KzPhiNxOEfmipV7c5vV?=
 =?us-ascii?Q?GNOySVw8cVSCRzSVwpp3znZAKT5zBUhlJRzUmqyq7vHIEiO1n4H2rAM7+/Jj?=
 =?us-ascii?Q?900M0139TlcVms6AMDz96Kd2bROtapMnzMVA2gfhcWfT3sm/EakNQ8uOfJQ+?=
 =?us-ascii?Q?Bb/GtSRys4uehaN5KELjRw9FyjU0M4j1b+foZkoRSH4ZqakKNWlVgPPFA2Y+?=
 =?us-ascii?Q?2SOEdx4lMauauIK+iWtS+buaSPglRUewGxQBSZdEWd6ySfnAq5/W0LKLi6+B?=
 =?us-ascii?Q?sPhOSAYeOAiE3gQZNu44lrjr4ORwwyBGK5JuuPWLY3na24r1x3jtzyzejnVH?=
 =?us-ascii?Q?3vtHI5pQaQCAo8A4nY/kExZwEzImmF9ZIazFuuByxgghXcSz+9/SA/OXc9pf?=
 =?us-ascii?Q?ZH9ON/OvJDS2blCX8ObinuOpsKnzzvCmErbhTE3k76mI2fQiISrHNmTca+K5?=
 =?us-ascii?Q?Q+OkKgzXbLQCYKCkcxJ0aP8QHDtrr0bQYGTEHkcRXWoGrtfgqH8/hQTiRMr+?=
 =?us-ascii?Q?DMEePFVQ6HKVlYgzfocikAngGE8qzR5Jpgc9XIUEffzQWq2yEIktLNgo2KAO?=
 =?us-ascii?Q?7/iPD9IxR41e8hZVsW0u+aE1xI0w1bNOowku4Dxg3jJe2GEIhZO3BvQA9ltI?=
 =?us-ascii?Q?l8L3QohJNryga8yvr+pS5Obn3BROjDfZteMnoktBt8X9ecr3eXyjupndKtQq?=
 =?us-ascii?Q?KIE3+gWMLukQ3CHeW8AoqCtS9J9AhzXNfqdfmjshH4Mel1VW5dUS0lLbacIg?=
 =?us-ascii?Q?K5aqbGg5uCxI3po1ZZCJ5v5BnMVBHzx6rK3ChRWaqSYFk+dSeq3q+LlqEQIU?=
 =?us-ascii?Q?TOoNly86P4nia6SCfpbvDNFWvgiCHoMsZQNVL4gRkr0beOOXMVQ3IjAXPRhq?=
 =?us-ascii?Q?gwiYX6GwWvdX7/U9IOGY0Jb/uDtPIh5K6wa4pXrJLPOVo2YtZP9n+eu/71jI?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694ea72e-08af-440b-9e1d-08dd6dd9872a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 09:18:40.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ixDE6yl4iRSAP9N4DhA4T2BnEcB9JfU8J32EocLbCi1Qv50rL7Bq3bYz/CLDXMvIteLD8SojadlIuuRzJjUGe8N7N0iJTUkB4bDCnRxH00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4908
X-Authority-Analysis: v=2.4 cv=bsdMBFai c=1 sm=1 tr=0 ts=67e66973 cx=c_pps a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=GFCt93a2AAAA:8 a=t7CeM3EgAAAA:8 a=fATKHIbVh68Ky4GJMjkA:9 a=0UNspqPZPZo5crgNHNjb:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 2todbKtY-WY42QdjqH52OTluDd9tEWTn
X-Proofpoint-GUID: 2todbKtY-WY42QdjqH52OTluDd9tEWTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503280063

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 652cfeb43d6b9aba5c7c4902bed7a7340df131fb ]

Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 fs/ntfs3/record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 383fc3437f02..fb0683c983cf 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -263,7 +263,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 			return NULL;
 
 		t32 = le32_to_cpu(attr->res.data_size);
-		if (t16 + t32 > asize)
+		if (t32 > asize - t16)
 			return NULL;
 
 		if (attr->name_len &&
-- 
2.34.1


