Return-Path: <stable+bounces-127480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B80A79C47
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 08:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142783B233C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 06:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3972119D071;
	Thu,  3 Apr 2025 06:48:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EFE15575C
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743662888; cv=fail; b=qfVlJX+CRYTd5HNwEEKIg7Q6e/tMGxm0MHTvRAIs7/2Z4aIZHo2tt2gn51QJb1D8j/GvPpuavRQRRCVesAnM9bDgG/Y7UU/bysS94Ah1w8eoqKUrRd1xkwvy6Y0j+l32zNqgCYdkFaVO7m8NfkEFErkTmmx/ZESkbLDgjXB4UIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743662888; c=relaxed/simple;
	bh=s6mECk2XJTtHpWGn1hrRnigcTqnuDv+5ZHMg34Qh9sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h+V8eyv+FN8QKsQ5S5gdnXDnpjKkTDNbYn0CKBjdWz1/p4IN08NiUCWfuLn4nlXhFuKSwLke52SMVxL988Z1j67QTz/XFVozgNGD44jxMEExEQvhMYxarChY7775Tyad1fGOaQEV9NU9Q1wkOg+OnOEqLjWjXagtmbwO5UfXhAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53354Bx5030773;
	Thu, 3 Apr 2025 06:47:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45sg0q8ayh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 06:47:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uf7vDRoKV71alSESHu0KxBnk1VDvzzQDHnQZIbuV516MPD9JeSN1YFBTh7bO9mi742djtkidLJn5akELCO+pd5ThrCl/jbbhtBEJHoRkCr2fElaTj7Gnyxw6wT4Rp4vc3LOI+kKgBPiLnZzuorKzH5p3nCU/Am8JIqmm3+I5NaifCrYmP40zg7f7tKsLP9xmXP7CbHSXpjs1pZ6PS9764XBHIHTqSh9LuQbJm0va8fwpPLOqdrnT0YR324LY7lsny6U8/ONS12qcST7iomwygQJsMdLZYPh1hUeUv8IGLx9pnemIJ0yEn6uiLGbprKSI2xdUg3c4MaKhTzGGG9xi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7qKx11b/44MH37+AyFVax0xRf4gUjx7Rw61poTjRe8=;
 b=Z5lWBZQbdynNBH1wa+cT+EXHjaAUiCrxECYWWD15dRO8766JISq601H91YN3T88LZxCgAcW3aX5WWHzzPPplWC4gUEhN/MjAit7wTez7PEFWi4fhVdO3OWx0IV0ZUuTavmBm8QxfRVlmg0yADWMl/pTZvas+xVo7hhU5fYqP+lLQiS7OH3jl1T4g2AESSvYHf/gj7WiXzndXpfqsrSW3c8yIZd/QZSsrHVnCbCY05aJpY5zzokRVQENlsz/ddhJLwkXgQeNOyzAXYONTbseIz+j2zoA3mNv3IzwhYnhe7XCu5IYGXOCFb0aaxrUBlzLcCkSZa0ib7FEyrapVdAMgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Thu, 3 Apr
 2025 06:47:52 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 06:47:52 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: edumazet@google.com, davem@davemloft.net, kuniyu@amazon.com,
        tom@talpey.com, stfrench@microsoft.com
Cc: zhe.he@windriver.com, stable@vger.kernel.org
Subject: [PATCH 5.15.y 1/2] net: make sock_inuse_add() available
Date: Thu,  3 Apr 2025 14:47:35 +0800
Message-ID: <20250403064736.3716535-2-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250403064736.3716535-1-xiangyu.chen@eng.windriver.com>
References: <20250403064736.3716535-1-xiangyu.chen@eng.windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SA2PR11MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: bab0b2aa-81e8-4fa9-bb2f-08dd727b74f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WYn4GEC9eyBZ3/mCqpZiBxKBg34jLie0KdtkyDDtr509gUz5nzYr7A1GTKq+?=
 =?us-ascii?Q?K7G+caIF8NFkvY8SC41mHIbpNuBnB87i6B/+b/JjCksGgHIYXNp2Bc7xG2CQ?=
 =?us-ascii?Q?YdaHBoUBuqQHA9dpK32zTi0n7r5JIQCNEYQBxjxs0baLk1GsPRYB3UCrMZFO?=
 =?us-ascii?Q?BJBnHC54bk7KbsqCRpaZFnN5gmNHjWAGaLkGdit90t5FJBMRMi1a4eARJAil?=
 =?us-ascii?Q?KzwXm8RFNb/6+Rqc/Ypw+hRXplMj/8bxcGDvCreeaLGwPxhMe1HXWkkuvcXd?=
 =?us-ascii?Q?VETmyNcB+6r5X0y0faQCWjW61kDGCz+4/8kDSrDnSpG1XhO02aXfsWYIc+K6?=
 =?us-ascii?Q?B0UlTb7vQ9SlDqXfOdSbZHOa+ikrDW4BOARup8QVDXE8TfdjPvROrPqP9VBL?=
 =?us-ascii?Q?nZhLQ1JhS3VKXFQicFQSTiD59Jpdmn/OzI3VVBcJUz5zcBWNSwox9/rj8aH3?=
 =?us-ascii?Q?0OUSxgL0qcVjiMALLhWTYSu07u9uz+cBR7J2owKxYH6ZVtCW1WW5rn1PoqQR?=
 =?us-ascii?Q?bk5oem1P0YO2bY405qbJSwVfJ+MYm56CafbEzzw6P0RaVHBx4uttxy2OBwTy?=
 =?us-ascii?Q?EMeTjQmhyizStNvYtjI+yQ2fbZbH4ahDMg6pnaOnk9iPU70S86Ke9B2/2vHc?=
 =?us-ascii?Q?e/+2QU4hgro3OD9jBmpc5lzqPzpDJCf9oJkup21sedAx3DJA9Ep0T4MykCRd?=
 =?us-ascii?Q?iMP7eYrPB6Ocs9EBpKjs6WncqyzvY0J05Oniw1B6bjNG0gSyySxjkIDQ6Fyc?=
 =?us-ascii?Q?AvVqAQOo0CuGArpGsRCm1m1NEll16eIrDGhP06SYMMQ7BH2gCA649Io/YowZ?=
 =?us-ascii?Q?urgUM0LYTWxWMxabsaI0eLr/Vvi/OXQQe3XEruQOeJPbU0uO0anoNuahhUUP?=
 =?us-ascii?Q?M8YpPi88Kw2NSTSM3vGPyBmsofExWwbjpX4YWkeAgr0xmRk+yaNCrCtjYdSX?=
 =?us-ascii?Q?5wYsGao6jZieB59671a4M666AGM4vgKFXtl5CRBj7AUw0/x/suukGihCe676?=
 =?us-ascii?Q?wU76ro5rD4YfhvoftjqkADso5TErqeMvB3BVmlfiY9vzIve8DYS+feCeJJku?=
 =?us-ascii?Q?su68sBCURbVUlvfTVULOQJS9yfVsn/11Jmbj3DQZ17Mbb/XhAVv260WTyjDZ?=
 =?us-ascii?Q?y0PGkY1lC0IUujTv+xFVJnPrr7PvSpOG2IaBmPychY7Uea7wUFsUVgusFxCc?=
 =?us-ascii?Q?W9YPMGtTyHIsFEp4X+1BIl0aM8d7v/RfbeZnhn/YmGyKe/4n0iWV9oXTUoJA?=
 =?us-ascii?Q?W4kluY781fBMLIOdGlavxKN8ZD7CO69YRPQNVnNi3tXJ6FB3RnsExFryECMa?=
 =?us-ascii?Q?si7hGkaU1RAgr27vdZc3Q3zuTNzBFe8kNcSh50fuU5oihOXBOxAwkXBBNBP0?=
 =?us-ascii?Q?vIu9gSaSFbuEON3SNIhOxmgFutei?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8KbzJVcPac3fa+JFUP68/kbDNlow03WZ3kLs/61iKeEBeZV+kxpqctJo+0Q+?=
 =?us-ascii?Q?F3tb8/s1iWlHDLiE6EuSVdDvR3yj8wZg6w5vho1WLpVvRhhzd+aMOdSdMeJt?=
 =?us-ascii?Q?ddQNB6Wzzd7I/+gurAK4xS0k3Btaio3yoJPWt6LOxFX+EhujSYcSLplITlTB?=
 =?us-ascii?Q?gTmC9X1Nz7EEjQRAfMSYPXWcg9N2zyzdFBeeVTqIgbh6evmhz7oDfZW13GQO?=
 =?us-ascii?Q?KxhnwYQFLo3qoMXiIfm5+nRTPV2rqWsYlHcl/VQ8s6ErBw0bhUPD2xjNIUnW?=
 =?us-ascii?Q?UtVDxqyAmCpCHs4Hf0X5mJTpmQPGhZrFdG6BGtDLrR/5sHHvrmHxBqHj/VG0?=
 =?us-ascii?Q?H25nQDddzoSo+hJVx5MGMcJ0G/C1NEEK8KwPCUKR6ILbTAtIBZf6z1KfkPWh?=
 =?us-ascii?Q?HjIBk7Q0nPnDrRdj9kYJl8vZ6EY0GCR14DUsrxGKvs3iJinocimz0Zc63h4c?=
 =?us-ascii?Q?RVMfLJaBCkmfIU8QgtSNEAwDARU77VKtKSQ6KGKIw0zgeP9sJiamc+y5jZE1?=
 =?us-ascii?Q?HS9ut28mA6pLlUuxDl3vtKhM5R/FnAcm0HsM3aT4Wv8fBHHjpO6NdgsybbXJ?=
 =?us-ascii?Q?eomfvpsqHmKLZnCQkBx8oE0IYvtURbyf6GDtS7KNrty4ICKG12M2j0UVHkI8?=
 =?us-ascii?Q?kKyawP7fB7bnM/JOaOujagoTMtCs1w49NBdu7d+UZweXANubY1rQ+JBEH0YY?=
 =?us-ascii?Q?k/UjXMZgam3932P0b87GH4vBtc6V8S9/xQz5UE7A0TGy2pEQkkV+yfkpetNn?=
 =?us-ascii?Q?CWeE7NIF3T3fxKiCUFW+i8YYcMvfIC293VnEF5XvEowGmj3B2wT83wVIKb5j?=
 =?us-ascii?Q?RLVP0iJcabNACUj/PEoHhxVokWhvo8RPRJDVdMgJrTpxxzaSqDTGKknwFF0y?=
 =?us-ascii?Q?OOonXl8wSbUpD1sFQs2y88uf0l/5yArfKAUN9WdGejFmdOX69UexncsfyqoC?=
 =?us-ascii?Q?jTSbYFfEM/4mpIYwwQAhEyS/9aVxzHOX2ST00/d/AdCQ/jlaXigRvh0kDzT6?=
 =?us-ascii?Q?C9pUZyyqCJOIOZdtikHtS5o+IUUuK6SDZW1lWScJ7Q1NlLY3iIO42l5Ws0DB?=
 =?us-ascii?Q?3FUQ++X65Ks/sAR5Q8/kX2SZzLKYLQed1F3Hgr5csppec+MjejFl2pydtIyI?=
 =?us-ascii?Q?4xGYOHUQfWduW4tmkZ7ybiimzpjxFXiqkq0gCtiCIKCR7465pB9PkIhujzWG?=
 =?us-ascii?Q?hoSUXz9TN70l9mOt7lBIm0a/pJDci2O8m51r485IfoC6gLPby6YijEoXclOA?=
 =?us-ascii?Q?lunQvDElT7THfyedEocUbXW+2kYHQ4gLQPXZFh8DzyDBPF4oiZ281kVQTybs?=
 =?us-ascii?Q?Ko+si5vFgpE3T2B1jf2G6IdN2xM4b2Iw2XOcu48pCRBGPUxO7GepX5DiKx3d?=
 =?us-ascii?Q?myRLiG1A1xalcv0ggG2Fi9xBuLG7JSK8qs5BIQduMtmcXACa9mQTwHa6ZrTh?=
 =?us-ascii?Q?adHluz4yWYiRV0D3UgZX/DkSGjXT6bwGD6c65zBqg97JzSF97P+9Eoc2XAhd?=
 =?us-ascii?Q?HNthKQ++rekBWKIYfSe72JNkVCwOvBENASQWDx9Ucvk740j2k37B+v5FFqu6?=
 =?us-ascii?Q?fm8iLP/0NL8Ji67bQDH9HTI/nuwQ8EpshY2ugebvfRJg03Px/8CeN0U+0OWG?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab0b2aa-81e8-4fa9-bb2f-08dd727b74f6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 06:47:52.7201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9bzZ0bOp7CIV9AmCbspiyoFD2qz3h28oYInNqN5irlm6jyR1oDxW6xoguqOljTklA273juVoxQkT5tC9wXtfQwdFY9Wz2P8gsBGV1Tfy+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
X-Proofpoint-GUID: IZZuVZy3OFLKzYE_C6pzrWgGtIuWRRwH
X-Proofpoint-ORIG-GUID: IZZuVZy3OFLKzYE_C6pzrWgGtIuWRRwH
X-Authority-Analysis: v=2.4 cv=G+4cE8k5 c=1 sm=1 tr=0 ts=67ee2f1a cx=c_pps a=TJva2t+EO/r6NhP7QVz7tA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=NEAV23lmAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=vggBfdFIAAAA:8 a=t7CeM3EgAAAA:8 a=_yOzT_KTvBmZmi2pfG8A:9 a=y1Q9-5lHfBjTkpIzbSAN:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_02,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504030033

From: Eric Dumazet <edumazet@google.com>

commit d477eb9004845cb2dc92ad5eed79a437738a868a upstream.

MPTCP hard codes it, let us instead provide this helper.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
[ cherry-pick from amazon-linux amazon-5.15.y/mainline ]
Link: https://github.com/amazonlinux/linux/commit/7154d8eaac16
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test.
---
 include/net/sock.h  | 10 ++++++++++
 net/core/sock.c     | 10 ----------
 net/mptcp/subflow.c |  4 +---
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index ca3cc2b325d7..0461890f10ae 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1472,6 +1472,12 @@ static inline void sock_prot_inuse_add(const struct net *net,
 {
 	this_cpu_add(net->core.prot_inuse->val[prot->inuse_idx], val);
 }
+
+static inline void sock_inuse_add(const struct net *net, int val)
+{
+	this_cpu_add(*net->core.sock_inuse, val);
+}
+
 int sock_prot_inuse_get(struct net *net, struct proto *proto);
 int sock_inuse_get(struct net *net);
 #else
@@ -1479,6 +1485,10 @@ static inline void sock_prot_inuse_add(const struct net *net,
 				       const struct proto *prot, int val)
 {
 }
+
+static inline void sock_inuse_add(const struct net *net, int val)
+{
+}
 #endif
 
 
diff --git a/net/core/sock.c b/net/core/sock.c
index dce2bf8dfd1d..7f7f02a01f2d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -144,8 +144,6 @@
 static DEFINE_MUTEX(proto_list_mutex);
 static LIST_HEAD(proto_list);
 
-static void sock_inuse_add(struct net *net, int val);
-
 /**
  * sk_ns_capable - General socket capability test
  * @sk: Socket to use a capability on or through
@@ -3519,11 +3517,6 @@ int sock_prot_inuse_get(struct net *net, struct proto *prot)
 }
 EXPORT_SYMBOL_GPL(sock_prot_inuse_get);
 
-static void sock_inuse_add(struct net *net, int val)
-{
-	this_cpu_add(*net->core.sock_inuse, val);
-}
-
 int sock_inuse_get(struct net *net)
 {
 	int cpu, res = 0;
@@ -3602,9 +3595,6 @@ static inline void release_proto_idx(struct proto *prot)
 {
 }
 
-static void sock_inuse_add(struct net *net, int val)
-{
-}
 #endif
 
 static void tw_prot_cleanup(struct timewait_sock_ops *twsk_prot)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d8b33e10750b..919a13c73448 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1579,9 +1579,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 	 */
 	sf->sk->sk_net_refcnt = 1;
 	get_net(net);
-#ifdef CONFIG_PROC_FS
-	this_cpu_add(*net->core.sock_inuse, 1);
-#endif
+	sock_inuse_add(net, 1);
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	release_sock(sf->sk);
 
-- 
2.43.0


