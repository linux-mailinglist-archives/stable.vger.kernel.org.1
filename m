Return-Path: <stable+bounces-163251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F67B08AEE
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 12:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDC81791C3
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 10:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE1929993D;
	Thu, 17 Jul 2025 10:38:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877A299957
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748733; cv=fail; b=io44NmSuzbEgv9YUNfTQpKv3K0NBUA5MWUg0gr4TEp2N62Eln+g5nEEuuiK9YaBF39fkryz9YdtaPX2kxJgiRg9xvAtnDdr7LyHZ+eI+PJzlzPOpLm2D/Ydb5J+jE0h8qE86ZTMyRbdKJCXT7dwGZs2PLKeYTx59itY5eE44830=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748733; c=relaxed/simple;
	bh=nR2Fp60tiPA8EDfbhGnKFzvW6DnHu8aSnhiXKnakR4k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Fc8jrW47Sj0FHmsw8+jY4mLh0uxxrSluKJ0sNP3LHFAz6rTSsWN2bw8WxUXiXpeRJKjSvEtegFj+dZEOGduCEx/Q9UJ5zluT6FJ/c+UiNp4wCxIe8oztkffOtuDhs0pplXnD+tIQN9JrFpmKq9uR8eZ50L9/zZL3p+7ga0Zeki0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56H8hwkV376462;
	Thu, 17 Jul 2025 10:38:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47wdva2xhg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:38:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMsECF9hpcln8SDOWjwOd6NxqonbPu1piZ5UdBrC68MDaawHRKOJltM2c9WxEiuQ5fZP87grECHt0YPSFo8er9BXVYdrLd9lKwWTlFp1AOQVUJzXh6f8nmE930SL1TwT/TLKYlBN46T6xJI3ti++ibWYDE0ZftynSeGdOBfFoLLL6Ot/wqImJaHhY300gvtPFlMjP1Ts9M6SCPjujX5PlGYGteI6EkbcRxkDfMfh7ETJKe7HI8BbQWT5bz23hwtUUqe7bkWog6gnU7VgJt01ItO9KkFCQn0zL3BHPG7BxM3qcuaVngy+48UPxVpSH6G7XnbMEUIPeiwo52i/1FM95Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQWleHKS6/8yCUJ55WzQEeww2kKN7UNV78C2eHm/Tv4=;
 b=fYARNU7wnRJZLi7Kw6g8bsh6GE3R2dKRyyLaaUPSc6Ku2BFk2pASO94K4nMAJv6bMleGBgZb7614Ipi+rhJxNVuyXuRFZt+5h/mLsfAb73T3/jdzP3q+Rw899Gp0mEQEuBQpGxw7Cc2QqshiWUtnawQ49yC/KSCfquC8v98oew1xbKncmXQeePzFWTPPCt5+nV8FwfWBkjDjZkHNE8OVBdY6zdLIskpA3iBv0MedDI0zgDzrTxE7c+ChETWNnOjWD/7znIdwCLEk3lnZiokXU115xlrV8Ngq0IuLhOG0G2iF5vxlfDn4pbddw7XvotsfQqg+5KxBuAhvmFRlQTn4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 10:38:38 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%5]) with mapi id 15.20.8901.024; Thu, 17 Jul 2025
 10:38:38 +0000
From: He Zhe <zhe.he@windriver.com>
To: cve@kernel.org, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH vulns] CVE-2022-49501: Fix affected versions
Date: Thu, 17 Jul 2025 18:38:08 +0800
Message-Id: <20250717103808.2094047-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0010.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::15) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|MW5PR11MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a9e056-1c3a-4f6d-977a-08ddc51e16be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bFaEC0/THA/QQU7jL4N0+G0hNRUil8ART36neg2jTsR0j2QJT0LFME8jloAv?=
 =?us-ascii?Q?ygAf1r00LpgOULZMnIigWr/gqJQQfgezzRf6VzThMubazYRDZ6O2IphMBA1R?=
 =?us-ascii?Q?fMvmWvXtv3iRFgttDecfyNYVRcOWu5irW7ktAr7UfUpyURhbPISrhu7aUBil?=
 =?us-ascii?Q?lJ67DUyh2r7qRRUSlia/EoVW2XRR8tmuam+coBD9Fg1L4MHR7Itz5K4ut+hF?=
 =?us-ascii?Q?WCwUOjWhy8jG5iZVNww12cxbsfyDOwPi1M0rrCr0CzkflyW+h4zegfySHv9K?=
 =?us-ascii?Q?32BHhzGmk6L7JumO/JzXliezeW/sL2N3myHnCgMPqnjnS3+Q6DITwi22r3Vl?=
 =?us-ascii?Q?mTgfaCNBVcPBb0tp/TVJu3Q+7wYJKgHc1EmV2JsI06t733rYFrR/buAzQuq9?=
 =?us-ascii?Q?IPoYEZGm6MxrwOcTusz/RlN4fRpc9tbX5mWYn1Xk2DNWjeSiH+sD4YwlBaYD?=
 =?us-ascii?Q?jOWqVc9vYfZ3DTtRJG/2wXWOzvodLKOVk/K1qDCbWU3zVrKCaXB9kJVajVP9?=
 =?us-ascii?Q?/nm0PGQlcuyL1mTzfqkCmlfOdMtvoKl2417L4yfLFmz4Ri5znm5jDSkdD3e1?=
 =?us-ascii?Q?H3P7YCCODp4cDdd5m1gEmnLRzIGTiMxDwSF9UvVzXzcJaSa5hDnm2knbcq9A?=
 =?us-ascii?Q?TqtzBBs1BnBBjS4aumwsn6RPUSS+BGMYDH+veL4B7NMzPCAgsQQzGye6Jc+T?=
 =?us-ascii?Q?JSX1lcHXfHtFExuNbUxz8qd9MWrbnkpLsmrpggV/MX7PAavl7qYwW+Ex9RaO?=
 =?us-ascii?Q?pIutpE0hOZTmXZNSqj++eMBotJzaL0XZuyf9Rcj/bmVDsMSZu9r4Q2G2Zt+t?=
 =?us-ascii?Q?dg6d5+Qy2LXgkfZ+/nf4pOwkzVEQhBCFTbCb630TgIuP4hIgh70dSZYelwhC?=
 =?us-ascii?Q?dq3KMalWuNvoY4x3PhBOSjbiAs+CdaXg4DKMIn2Acdu3Yuq+ZtTQBO5Zkl/y?=
 =?us-ascii?Q?u6E4kP+h3J7FVmfZViRGvhLIBqt9tiY9FdhPl1mwkOswucHTsW3QDvi74EOa?=
 =?us-ascii?Q?Dy06jSyu7ozisl+e1HyET8laMHDBmDqppMEsGEAtJEWSqv9rUPR0vWKeAoXS?=
 =?us-ascii?Q?mGwGjD5bffMWugZUm/aEWyG79KE8wul5Ga9VIT7eoZoxnHqd62ZFsz2lBy7H?=
 =?us-ascii?Q?4nBer0tsZWZqUkJmTQnG7j6GSQjZsUfjCbdWqObIUpASKx23DoyTqVaKkdpt?=
 =?us-ascii?Q?GCKeWR0n+069VCu6lrgor1j7Hxi35BqTuLKoxYyvvKqCDYGel0S91YKCCm1F?=
 =?us-ascii?Q?U+YfIQh1EzAkVuyyE1Pz8a6ejA25qvQvXNs/Dlco3iyv5OJBnVcIJHQyySgc?=
 =?us-ascii?Q?5twYDDHvI7UeesSXlL2DZXZSQlGFv2MnxxjymZ6nVKkal8bFy0xTm4HqiWln?=
 =?us-ascii?Q?exOd+e1+SXhD8Q7SWDZ368gVLbx/4NT1ay0ZX75OkX7UGBu517AMtKSeQm8L?=
 =?us-ascii?Q?UpOyNHK0gD1O5dyMm3vteS2k9RPyP+J9Hqf00XpCP4EiV8SlfbAKYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?le1pInwdo8W5XXf8APTXOjhJMtOS0sfaINeZWG1YMM/ShEcWho3Cqw7J5S2V?=
 =?us-ascii?Q?ZpZTgxoDtCJdHhiiuCziRZsI1+MAj9SC2I3Yv//EB9ORGvsJYKnKCE5JBv6+?=
 =?us-ascii?Q?myxWKeG4OpJHz6RsAh7ConMW1qjzYuBvfXtL7HOD6nvM2qrs2d2TI2VP0vLU?=
 =?us-ascii?Q?+sJ/PkwmrrixHOAyVSwup0vfcwuM+vtZ6Lt2EcSGm5Kh6ikfOC0ccfcHS5y+?=
 =?us-ascii?Q?l7/xOAQSgSctqw7171tOC6CmXsoBEJM2Aae4VJhStRLveWy9Vb3XYS5tGk3Q?=
 =?us-ascii?Q?HMFc+8JcDUXUYiE5jaUYgal1pcVq0H6dbYdHj5hmV1TJTcixLp59UuNnXuRV?=
 =?us-ascii?Q?KT7Ho7BeaqCV3clU+jkJUipDEhM28NY9BFCuSrwxH7E1UBLXHEgDEVmCodur?=
 =?us-ascii?Q?Yqb0mrmQ+3LehtF3WOMLNxi2wKwU6nagoi/eB9KJ68fpfvBF4gwHOsKA4nEb?=
 =?us-ascii?Q?G5REDmZuisKVlW5GHP5UFZcDl2bijlrLKDhIyWLTe3a0gBOhdupJK4I4cd83?=
 =?us-ascii?Q?kXklp1Fx1ZyUoU9uPnyHWutFUI6EM7Oq9nEc1g+D7FzofLOk/WWJPCcG88FD?=
 =?us-ascii?Q?FNLOb7GoU38+SyRuZPoGyJbdaOR1D+stmiJLWY3mn8rGOlyI0OjC/Qu8QwIh?=
 =?us-ascii?Q?tuHRfJvwpgknfjNQi9bfBdP702YNomC4kJEN2DCYvJehzKEPf1EmyxJAxSO2?=
 =?us-ascii?Q?EH3zYKmWI+5qgTCSUm7WlfsmO55ci6VwITuJG0Ij2biGYxII8Zy9nFG8h0Kq?=
 =?us-ascii?Q?sEvr5FWXHIXLNoqvnqGXnwTobOnkXva9ecgTJgw/T6NmdPYoOSPo9coPjPIG?=
 =?us-ascii?Q?Ag2lBLY3lLmRZbAazrHGUbndMbGvLLRt06vaAXzLpH7HS0c93LRuT0a8RXB6?=
 =?us-ascii?Q?9oYh4LFtuuShXn0vkQ766FwxA+sKXJxyuj4rgrwgY5cNQf00YpJQzIOH0qid?=
 =?us-ascii?Q?4VqsRUJluMlZEoaARpDEWG3UDudVM5Qw/8ql4Wv7c46L7hX6jpg90KZRJ51/?=
 =?us-ascii?Q?FVCQeyF52F+5ScbeIJxJ4JjzXp1tB9hUwOFtt16519MJQQWIVU96yuOEV2y7?=
 =?us-ascii?Q?pGmFC95cc6RHEeF4P19L5WoSgwzyYJSjPWQa9AG9Qr4so7MwHTTxBMIPF6fF?=
 =?us-ascii?Q?u8wXQbNYu4jkOTz1kBeQMm34u9YEBByZCF409/VLwSBGDw6nLDlPPix+jzUX?=
 =?us-ascii?Q?iFGdUHljU37zjTXy4gtuIS3FaTQrPxU+10kvTp8pwCCLN/05oT93TbwpexAu?=
 =?us-ascii?Q?fn/DSXAVzPnMG+jb2jwbFtsllwWthpdWcLXR7my8xFGVNsRQ74ZH72wbNkbx?=
 =?us-ascii?Q?gLBOItPXIUCWfO3LmkAzcB7tlDoPQOdWBF0WLDIxp9zIeIc3tfExYd3eQwp0?=
 =?us-ascii?Q?2i0fL8Q25u7XKuO31vdrgR0Jqw4b2bKY0ypSSsUcSDyg/K4h2tsWL7OTlyaL?=
 =?us-ascii?Q?P8Nnrxy8yuuB7MdrpZNbXGnGKJcyt/m2bDKyV3tisFBGYN+OPz3nokVYoC9P?=
 =?us-ascii?Q?Dh9EkDWY8BmiD66mZvaTL7V0PD/+wluyki4V1syCjKvvrCcj2lwRQc5nTNnV?=
 =?us-ascii?Q?+2wEXw5vJR5Ipbb5TeTIs8h7RXSnumf5hQk2A+7/?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a9e056-1c3a-4f6d-977a-08ddc51e16be
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 10:38:38.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1s8IDCo2+wFpBlJfacdo2OLD7T6FtRxU6ZlzrleVY6lm5WUlFxjqZPa5g0BAqPjXSdsaCroA7TElQlsjmSxGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5810
X-Authority-Analysis: v=2.4 cv=AbaxH2XG c=1 sm=1 tr=0 ts=6878d2b1 cx=c_pps
 a=HSMRk6+LWERSksWCO9SsIw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=t7CeM3EgAAAA:8 a=liYTdsxeVQq0j245N9MA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: zNjOgJ_hcQeeLzkT66uLBPGM2xYzv0nA
X-Proofpoint-ORIG-GUID: zNjOgJ_hcQeeLzkT66uLBPGM2xYzv0nA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDAxNyBTYWx0ZWRfX/mW9xv71OF3w
 Npt+MkPyRYjBH+c9GpV7P7ARqEWK007KB+zamx/4qIu9F/kAFZbTr/ciEl5eol9f0o/dIcXSRDm
 WYKA+8bsJ7IwKDZgsSuMhOBEmae0sukbw9QBe9SB/IhZcPA4TX3mROjiql5rw6R2sxabDIueHcW
 n0qUJ2oRC6jGDo+l0P+nweOV8kjf6w/TiK0G2uf+UU59SCFO2Sp522L6F0hwANcanQz+bOty/za
 mPlnJilk6h+xbc7zb37S+xMtVKpZlGwKuyKl4yLMLvjSoWo5hGhDjpWo9B8Iy7vvS9f1NKC3KEx
 +x8d2NDJyiF03gygoP8C1DOOpuz+FVKMrDEek+eOdRpxuOfJ6CxRrggqpWoFHlGK9sgnl9wVsv/
 WnIrDeQL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507150017

As mentioned in the commit log of the fix, it is
commit 2c9d6c2b871d ("usbnet: run unbind() before unregister_netdev()")
that causes this CVE.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 cve/published/2022/CVE-2022-49501.vulnerable | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 cve/published/2022/CVE-2022-49501.vulnerable

diff --git a/cve/published/2022/CVE-2022-49501.vulnerable b/cve/published/2022/CVE-2022-49501.vulnerable
new file mode 100644
index 000000000..138b53caf
--- /dev/null
+++ b/cve/published/2022/CVE-2022-49501.vulnerable
@@ -0,0 +1 @@
+2c9d6c2b871d5841ce26ede3e81fd37e2e33c42c
-- 
2.34.1


