Return-Path: <stable+bounces-133052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5967A91B06
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F523BBFC2
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E004523E330;
	Thu, 17 Apr 2025 11:37:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2DE8460
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889839; cv=fail; b=cjA/dLeL66CSr3wLeHmQiqu6H6ic4ewgDff1viBQ5rsVDi2egdXY+8mPRNOoCzKyhmSSe7cwqPAkuXSRkujVRGGRHyUVbyv8Zp18MLUCKiUf4bxOSBA3iV6YpwugS1hGoqliE772n8JdW2d9Yzz51ywfwBqF5U5VSm344CokQ9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889839; c=relaxed/simple;
	bh=SVZNRI57e5Zw9xIPrbg1pv/GK55PfDYbZEkXPh6zaqU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=O4beN9OJtZ11mxcwrlehnEPg6SYNJG1z690bhw8jKblGyaC6uw1dIjqoMbLRLMT/3rVwB3lGEMqzUNW1JftaTetJXRCS3AzDBsihV/swKP6hhr/gtlT38+3KJNi/EPC/fQssaV/pLWC02yGgyrWKCYVneBZSnPu5vU29qy89aRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H6AVIU015850;
	Thu, 17 Apr 2025 11:37:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ydd1p6rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 11:37:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0mmJewl9aO5+zI+7fqY+4F8Dg/yW4lw4FWg13+wiXzuj1Ab91XufMrKdMEQM88roSzV5MPRty1semv/yNcfNrZqZ0YX8wPSisCJK9gu027WcmMszw9Z/S5koXfi+uRIwHFmZNavNGEw38wrDU7uOUXdvPBAb2GFICBLaerXEu2OP7W1yVbbFmKEm8FlTNwWjLtihEVpG829fffQ5ZQFyT8w65pbfN6jVtHIsNyxw9AEQqxBtcioazVuElIX45SPR/E6vTQMkQRY9TAXVWmUle4kX6uHZQWpBQ6NPnL4gWai/SIx80cOYV2eWrkaqU8pzFpkTkuoyEEUO6USqgYhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cDMscb8gP/0SOcuBILbKsHysyxy/0WbqdGIev60qBI=;
 b=PiecMPJVqDXWQGCbynV5rtLS/Yuc3e1FfVcuI1BG6iGcycpOEGcZS+LPnOcGWzxMSIiZogjQoaW5A4eptqSYDPhUd52yjI57DyDSK4UwA+iGLz9mFMiwwU5gj8cQINQLoCa7tx3PQRONsy/2dhAqqxxrWSVBAjk52PnEyZ9PrOM/j6n32QGphgf0KX2Eips8LTb70UtUecd5IdRJ/dJRxwl/mQZeoirnL/eH+TIIpJ2yXgWmAGPAjzoWvMVjlav2XZK12WYVmoo6e6PCUhDmI93mqbdfc0joPulY/R4ZergoEzMAbl46Z4qUEI5ZM4Xy1IdWoKrVplp5v6HdOd7NMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by CH0PR11MB5234.namprd11.prod.outlook.com (2603:10b6:610:e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 11:36:59 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 11:36:58 +0000
From: He Zhe <zhe.he@windriver.com>
To: cve@kernel.org, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH vulns] scripts: Correct kernel tree variable name
Date: Thu, 17 Apr 2025 19:36:41 +0800
Message-Id: <20250417113641.273565-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|CH0PR11MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ea37ce-c925-471d-5e79-08dd7da429d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T0ZGtFwXbl8Fu2uA43/b/I2etNohJi51wLNjzrFvCrnz4KWYZFZDsPGTcy+L?=
 =?us-ascii?Q?87elcbUF47MJomNkhso2kUE9Y+Of6uPvEcQqj3HAk8naeL0mSPigjd/a9zgp?=
 =?us-ascii?Q?32AcHV3hza1ih0ZPh5MT8LY47YZt8PWxMsVNFk6k53nT+GS+iw1PPs1iZoUC?=
 =?us-ascii?Q?/kjrXMaHhWlrfxOL0ZFNQtxDH6bxfvaNsHLfWNHj3jFCu9WgskCvdTWH0UmZ?=
 =?us-ascii?Q?FLMHEYGDiWQeVArSLMqqY/Tx2ZhWgerUqI6aj140U9WAANUqloQkag36/QpE?=
 =?us-ascii?Q?yqY1j4x6QC2usYszcBC+VW4M83pYhT/gBaUirP+eUhIrw3OWvppvcxhLtyb4?=
 =?us-ascii?Q?XInep4Bi4kHCHPiNNaBDG356/VfFL3YKRt3w4RBhhUWIlcU1grhfAWysUfOn?=
 =?us-ascii?Q?LxeelmmXkdPxc1QehzQpnU8iSKSUZ+oaXozJlZ3qgzp0VKFBoYmzRaOt4wVh?=
 =?us-ascii?Q?rTKkeLC32zMaowbr2eq/jd9BF/6Ynqv33EXcSmnPsheGQXNWRl+hSDEuaKW9?=
 =?us-ascii?Q?Krxh7JS5X+4taO4fOkYNH2/pL1pj8Py950lPMa5eTpyPr3EgHp6kosrxCXOs?=
 =?us-ascii?Q?t3w4XLjcSb5gV6DF8yVyJtgExpmGDtstyGBc0XDC9WxpJfGfnX3onUt74dwW?=
 =?us-ascii?Q?Slwnlt/CBGoyELWXVsQ9WXEQ1dXa9RpKLSfohTUpE1jDkEqleNDYwOQprb8l?=
 =?us-ascii?Q?wWuXOllH5o+TQjYBhF2QCsDIJM8srQ4qgORy2fViTs7RItqioYlqY9X8ba6Z?=
 =?us-ascii?Q?H1pWLpxZ5IwrJkNEAWP/yN+SXX23LxJTXooBk+r74njFZghLhkC6Bo6mR+JQ?=
 =?us-ascii?Q?37tYd+K+pNXm2yV0Ktv4MU7+YBsRZgvX6GTaejGhA9dtgw0PjvdRt/CfOk6H?=
 =?us-ascii?Q?NF1XYDc/ekbfREbgq2UQVFgXSQ0kmPtnIs9QCuLK0sU5XvfAsRfcl9ifBuCv?=
 =?us-ascii?Q?ZxZlY4RZH49AjfFKti01DLHT246eH1s75IvV2GO/dKntx0remPgvl9iTYUAn?=
 =?us-ascii?Q?pxyDcjQibmmu8EsfWwyQNvUqXQaQ5CDKNFL+ikJsZ54YKCZdesIe3QyuD5tR?=
 =?us-ascii?Q?j8X8LScsH97wQBLloO/R8ycJ5JhxzpKVOCP3geDZnCmzr5YYA1rNgJK3KzvU?=
 =?us-ascii?Q?Oh/OfWyCqlkbt9RQwAIKS8cH33eixjPFP+Eubsa7YgJPQ0puo8liDg3xZddS?=
 =?us-ascii?Q?sCM+EZHzd5oqN/84TgiaaWTW7ChAiEh9k+vh6MOno/IXyVbvD5JlAivxKqdP?=
 =?us-ascii?Q?Jiy9AXoOL8aQVvfNXEc1ca05wBr7m0fj69oEieVu96zefPr50YvuHTiUHd53?=
 =?us-ascii?Q?Lj+JlGGvCoIiLZSGD11IjZOQQugzX/A9I5w09eGS7HICuF4qPDNcDC+F+oRW?=
 =?us-ascii?Q?mpwlNGxTLg2x4cQBwqquaIoRaX8EizjRvu95qoOYpV2GoKBUU77ObZl6zpuW?=
 =?us-ascii?Q?bbx/RGWQ0haOwSGa7oUjQ+Q7UZOD5T9fnpyrSw6TVBHjN1/nG4v3PA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kgtdODm9Q+xWGkvFw0/T2x0ujjClLACPf1pxqkpBcCvBdvhnyurnykIPK9R8?=
 =?us-ascii?Q?jx5hge2pvZL8UpiGF/nuX54TpR4zUSjyMKvgqc17Dqo64+jN+VFqnoZebb9m?=
 =?us-ascii?Q?I0mioscEsKWOE7cHRudsGJyFxJDZ4ENF+sNIFS9DiAPGx8ZTADgIkHY+51Gp?=
 =?us-ascii?Q?J5tga4yJAiOizQS1kC0rmoVUOQv+Ojuspk+aOU04gg2w05iZNOGgNj4vFTzy?=
 =?us-ascii?Q?/k/hLr3yDuXVaQYv+OIQzjYLfBpy0OOlhkAyLVt4OMTMkDlSWeX+AmFORt2X?=
 =?us-ascii?Q?8RNrgUswM/4p0hwkCpcEamwa+zSEPNqyrJ+fsRPfFM0uOZ5l4hN23Loj1Rtl?=
 =?us-ascii?Q?Hqm6xPR9pAMX9nF5FcHkEzyZaX+j0SIjhg0tqFpRB5Lcluh8XQnGhGnNk8u2?=
 =?us-ascii?Q?sEh9ZM1M94M3TGis6on4L44heqX3an0M7eYMAUFXmRw6P97muq8emE5INvLQ?=
 =?us-ascii?Q?T4YDVDnDeG6ULv7OlktnnkNeTonitLMDHOPiPyIxSl6e9pN2Aa/M41VnNezJ?=
 =?us-ascii?Q?n/W5yXFXilu4kj6Z7ELpYSa682BMBOAy5n7lrXtsqAuw+2hUfasOAG0GD2L4?=
 =?us-ascii?Q?18r75k3+Bz11tDT2n+VDz6y1iV8HgtBuixIK88SV73cWzxe6IYOb0HHk9dpc?=
 =?us-ascii?Q?BVqs5VXlyPKQBp+LWfoiNZ+PCXMqN5TkQoLxgNTGnexgwFoUKsTLoIdMwKyR?=
 =?us-ascii?Q?d3C76TKUMRCV94e6OtXc3rb0Sx5s3HLd0OddO6ssDATIb5MnB+2eaDrHoMV7?=
 =?us-ascii?Q?jC+5yG4ac0ibW82wGJamUtCYa4kKTEj1I/+v3KyuDjCZmPUzPlJAd1uNOR0V?=
 =?us-ascii?Q?RVeWVXnqt9EThb/gYjm+c5fKoM1t3zQopkz0XYyjqeTrAmCI5osMR1L66eCF?=
 =?us-ascii?Q?5VMFozpATeKiZKtUAUEtmkHopdRlTLbt7ItUW16cfRzo1AQVU/UnjGXARHfg?=
 =?us-ascii?Q?kcVp6vjf6dXVaYBsW+g3npdnsFat4f+pRL7esEZ0+8y8MOUuT7iGOfHJ3h31?=
 =?us-ascii?Q?ISoOuJPHqCqsazOWDitjzEsDlpb2qGXCRwANUXXdgdrKB7xVWKM4X2HUA76f?=
 =?us-ascii?Q?14O7QpCIU7kNV2T95kj+sYR9ItPrJxGqpeTgzt4MWdDWJrTxR+YI2TbAbwsk?=
 =?us-ascii?Q?gj+JpuQppvbkNzGbZOKK8WN3+7yZhF6GPG3cVJZD45lbeaAcJ5gWeOW3sinQ?=
 =?us-ascii?Q?z5mmeuO0apDyMpN6G9LWg2s7fSNY+MX93ZTA8lF6Wtwik2JlE4oCn2rQlPlG?=
 =?us-ascii?Q?2dfgCMyGdb94IwW40+zbLL+ZJg3aaHP5SnNKmVhJG+WdxWflBCmXdVoYnQ3c?=
 =?us-ascii?Q?sd82mqOm2uhJc20pDf0yVY0u1UFz2ToT8zOjOst/eKnRZYIQjln+FMzyLaqu?=
 =?us-ascii?Q?gV8SxvQiRzc8WZSmXh9szB11vY4EoZ9jdHwo5rFL8ZWfPqVq3CuBVosvxkjX?=
 =?us-ascii?Q?5dTwEWIj0Cw6zA3k3xajFduO+5JuUg8M+3oorOszXkkWxa2/W2jNzFjo9t6w?=
 =?us-ascii?Q?Bv7EKbJcnnvUCo3gDomQrLyAgknbI8ciX8Op6zB+NrX0wahsAY8WTMQu9GVn?=
 =?us-ascii?Q?eUspsyFDrSp2fasgqNJdzGooZEOT4NjhfXRAmQ/c?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ea37ce-c925-471d-5e79-08dd7da429d5
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 11:36:58.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sf72wNDOUClcSTE80/IoLDyVdtFP73JkKqNzXCCpuytwlICOcOnHa+9NeUoeB8XS4X4YiWwsuVpmaOxk9CpFrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5234
X-Proofpoint-ORIG-GUID: vftxt7gb1tT_UWkrcf0Sgn75XAxBbxfb
X-Proofpoint-GUID: vftxt7gb1tT_UWkrcf0Sgn75XAxBbxfb
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=6800e7df cx=c_pps a=CmjB6Nkc3E8pi8fe8piFzA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=t7CeM3EgAAAA:8 a=cY0Ew82nYH292C_oGIQA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=679 impostorscore=0 suspectscore=0 clxscore=1011
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504170087

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 scripts/cve_create       | 2 +-
 scripts/cve_create_batch | 2 +-
 scripts/cve_search       | 2 +-
 scripts/cvelistV5_check  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/cve_create b/scripts/cve_create
index dee842d43..eed7b45b2 100755
--- a/scripts/cve_create
+++ b/scripts/cve_create
@@ -24,7 +24,7 @@
 KERNEL_TREE=${CVEKERNELTREE}
 
 if [ ! -d ${KERNEL_TREE} ]; then
-       echo "CVEERNELTREE needs setting to the stable repo directory"
+       echo "CVEKERNELTREE needs setting to the stable repo directory"
        echo "Either manually export it or add it to your .bashrc/.zshrc et al."
        echo "See HOWTO in the root of this repo"
        exit 1
diff --git a/scripts/cve_create_batch b/scripts/cve_create_batch
index 00c7e89f8..28e98b836 100755
--- a/scripts/cve_create_batch
+++ b/scripts/cve_create_batch
@@ -27,7 +27,7 @@ fi
 
 KERNEL_TREE=${CVEKERNELTREE}
 if [ ! -d ${KERNEL_TREE} ]; then
-       echo "CVEERNELTREE needs setting to the stable repo directory"
+       echo "CVEKERNELTREE needs setting to the stable repo directory"
        echo "Either manually export it or add it to your .bashrc/.zshrc et al."
        echo "See HOWTO in the root of this repo"
        exit 1
diff --git a/scripts/cve_search b/scripts/cve_search
index cd90a1599..cb0730c63 100755
--- a/scripts/cve_search
+++ b/scripts/cve_search
@@ -18,7 +18,7 @@
 KERNEL_TREE=${CVEKERNELTREE}
 
 if [ ! -d "${KERNEL_TREE}" ]; then
-       echo "CVEERNELTREE needs setting to the stable repo directory"
+       echo "CVEKERNELTREE needs setting to the stable repo directory"
        echo "Either manually export it or add it to your .bashrc/.zshrc et al."
        echo "See HOWTO in the root of this repo"
        exit 1
diff --git a/scripts/cvelistV5_check b/scripts/cvelistV5_check
index 5eb41cea1..8a3bd71d3 100755
--- a/scripts/cvelistV5_check
+++ b/scripts/cvelistV5_check
@@ -45,7 +45,7 @@ fi
 
 KERNEL_TREE=${CVEKERNELTREE}
 if [ ! -d ${KERNEL_TREE} ]; then
-	echo "CVEERNELTREE needs setting to the stable repo directory"
+	echo "CVEKERNELTREE needs setting to the stable repo directory"
 	echo "Either manually export it or add it to your .bashrc/.zshrc et al."
 	echo "See HOWTO in the root of this repo"
 	exit 1
-- 
2.34.1


