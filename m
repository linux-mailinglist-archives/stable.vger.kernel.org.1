Return-Path: <stable+bounces-133127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A89A91E53
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920D219E52A2
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F36824C094;
	Thu, 17 Apr 2025 13:42:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7724C09B
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897320; cv=fail; b=kn/c6bxTFXFXJmdPZeqZDiK6DKkxal68p4eIfC7fTseKuKl+Ha+1Eq998FjZKoRu37qtXj8QMVyx0W609KcWLYLHkcHyurVn7RJKHzmohfoo5G0mmYmuKvd+difC9MSrce2DW1pn8g7jbzu89FMeztiE0hV8OS9Aq2mo4JhD61k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897320; c=relaxed/simple;
	bh=qEilE8Tum3kHivvDb9pkYLWSwHXFAXrXorymMw3YwlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g/PzBDtTVjZiKKVnFvNIat7Xlfkeeujs4nzuGLF8n45jJJA5dr1PikLCyZ8ekhCtfJuMIqhXtYavoYicxUqJTGkgyYgL3ItDrdLNUj0KzLI8p14sxPkLrjhWBURjR0B1tdfg4ipRsU0Hy637efqLvz6HEu2YOJy2R2P/EUeaSus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H6AZmn015888;
	Thu, 17 Apr 2025 13:41:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ydd1pbea-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 13:41:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKTYrKwP93bgNqxCEHd4BXc5MptRYLsM7AMOGt3h2WNJm97B9VFcNrBlL/cAhI0TxMqVu9y4Rc17o0si1HBRVG2Oy5UAOibk5ZRhAw0DEa5VACG7bneHry+7JVy3jAPm6f3x2J4xnGFsQZ0cUT6vMEh8Gf3710SHvoIu31BebMlMaBX0VnUr0PAd2ITMCN4wNZP76RWEf9HJCB8DP0ttMiB8AW22Wx2HhsxlOurbmJDv+Dj6hBeh4zicMwjJTZQH2cu8lv0yDloTVL6g3d0cLsMQIskNDz1U6kc9x9Lm/8GNMr+RkUitpvAVxchvPYAPuKcduhVfXiCf4RuzTgCJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlQre8YdQOLbhCGjE1V8W1NoGojHq37CJ+OkIl0CBFA=;
 b=pDF55m5FFBngDRr4v9fHLGjM6ImqYL26IXudj7xJn/NveMrKM0Q5bb5mcIbf8xhSEhANxXvSCQ8gyobm/Xbki55fSl3lMQjNnYuRUj75+4q/c5Uzpak+nyYhQA1HONwGsfuEcG1OEzzzRv9uP+1tGNeDwu4AjwgwC6mlYIWri0YQHbLn+JUAjQzuiegiYpJ/yT1wU1z+GmUhFsEwifTjLEDkluiLIk5lnJ0QulKAsdcedkCRBG5r8g1R+3pu/o7Qcvk9Clqvx4C0eGI521z+FYlM9eqVJdXEtBi2M/e8mWrUTAv2o6vFji6m5njsoyCd5j6fckGYZklWHqHMmU+3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by MW6PR11MB8437.namprd11.prod.outlook.com (2603:10b6:303:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 13:41:52 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 13:41:52 +0000
From: He Zhe <zhe.he@windriver.com>
To: cve@kernel.org, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH vulns 2/2 v2] CVE-2024-36913: Fix affected versions
Date: Thu, 17 Apr 2025 21:41:34 +0800
Message-Id: <20250417134134.376156-2-zhe.he@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417134134.376156-1-zhe.he@windriver.com>
References: <20250417134134.376156-1-zhe.he@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|MW6PR11MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 149f1085-8a24-4853-90be-08dd7db59c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F0pbAKiCP07ooAAh1OcUpB6bYyvNc6DBVJXh6zyHToTnLoeMNZDZmoGd+7T1?=
 =?us-ascii?Q?pZBMgj8S4nFv01EAkYk+S1WZz7MHMsuovej+fnOY/V2p8i74QGsEBWTFofHG?=
 =?us-ascii?Q?yw55FiPV1r18ncu0OgbWFR+xjjjyo9Gv3kfeo1SqSiGIScYzgUzqL5hmEhy3?=
 =?us-ascii?Q?Eo8H3cfjwrf0Kzzf4GAHD6ovFAe5j3zdE8hLxwq2ER1JhGwCet+swpF6PTPq?=
 =?us-ascii?Q?xFhuYuhYaV/5GK6qQqdJiVVRuCSznHkmn7qHhbHczvNC5pxkgavhOPcA3upW?=
 =?us-ascii?Q?cgRhW44NldEBwt1uMSEzXBMyjXESvMa4/QsxrcgHRSYu1qhgpPeSsnCtv64O?=
 =?us-ascii?Q?I3UogqCtHfWRz38iTLNBh4s3ayOIDPQL4jnFSsn1A7O2bnc10sFdJiAcfR7b?=
 =?us-ascii?Q?8KtGbIn1rivfdaaVkZnvTgE0FVX+AR9U5bn9iNzx7qew9qoJ+PZMcccvj4q8?=
 =?us-ascii?Q?xZrV3/IlTw7H180nUmIm1JLiqRQ4OE395OAMu7ZPvxkVVUx/eYI5Rx+dSRHl?=
 =?us-ascii?Q?u22UAbnrLHCD+nx1OgtXvFsUeYyvcPttwy+VJ96zo7Ich7C0DPCY2BvurVQc?=
 =?us-ascii?Q?PQJ2uNlkm7lEgY5WysVi3NTyMYMgiAgiY/lFDJzHDC+G8bOcbUUFRHQdIO2K?=
 =?us-ascii?Q?vn5d3fRIeu8UzutMyjghOWjfJut+qtx+kP1YZX/pR6JZkH4BV3XfqsQYHDi+?=
 =?us-ascii?Q?G3y0YSkXhiUWoQhlu6QoEBUS5slB1cSPGeEtMjRO6Oyu7y+Rjxcx/R1/hK41?=
 =?us-ascii?Q?YBnK9PsjC616i8axQ8RmscFRK+Igu2/dToI9JHOluu41/HqqN/lCBolCKhV+?=
 =?us-ascii?Q?1+yUDeVyoZCHYZ8xHczJD3CYRa0jE3Wr0QpsndfsJ2VOAZliKnXDOJUBr8id?=
 =?us-ascii?Q?dLthzYYhH7vbkb/dnWNLWIAsMWby+1L721igPc9BzPMOY1M9iJTl6ZsNC3ia?=
 =?us-ascii?Q?PSg3lQuIlrodQN216xFDHH/7vseBoY0yXTo6ccUE2+K+QKFjb20qI/86AcQb?=
 =?us-ascii?Q?2AOyDPL1S3BNRK/JjRv0omxgeA4vw0I4xN8m4rHS4ncSLPB+vSy1pM1cjqwY?=
 =?us-ascii?Q?c370848JiFuItgfHVe6hh+iVyho3m/gHwopH55JMCEyoh7/U+EQ8N5fgDwph?=
 =?us-ascii?Q?msfBVSGldtu+lYQ6K8mtih9sCifdXBCO/f0xxrNKyaWhM3uflaIJT1izhNB+?=
 =?us-ascii?Q?jlysDtYsP84h6Fav0xGeIp3wsfUAVNa/XRPGO7omFRmOuPYaLah/95vHu4Pi?=
 =?us-ascii?Q?0ojKuLpISaqLMyFLLxkBb2FX9FVF2pJHKD4S6ahRAjVyjURs4tV1Trye1Ryl?=
 =?us-ascii?Q?lrxvtgLDgfOtsSp7esEzIY0iPjRG6Da5BGfyn7IasMpTrcgsZkU8Tz0oL0BU?=
 =?us-ascii?Q?1wmBCpkIFSNUy4MUC87y/P0oBj/skc0ywvtzPPcm8YIY8oDFu+F/iP4WL0cO?=
 =?us-ascii?Q?UA0zmqw8k9qI0+31kxbB4CpHTufaEZsdNX1wgrFMk/N3mdq5djduoBscTmqn?=
 =?us-ascii?Q?eJZy8xM2dQgazco=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ASKEOaRXudEcJ5EJL65WF0FnCI6mURsWmH/D2hUaWYFDNlxqEFwBn/U/u4tO?=
 =?us-ascii?Q?nRAaQ9P9NCKA9pQ0f+23IlpZARmXAWWzIhoYn/eFoCx2OviEmQ+8NkVSqwKx?=
 =?us-ascii?Q?E7cxVyDGZFmkamQAerf5d30e3/K/g2cqFUMt6UYntCtBc4AmlOL8b1Ru4ont?=
 =?us-ascii?Q?eZQHxCMbNNub9oV+y7I8vdetLSYUCJaMZ63jHHqjbw9sOU4NlQI6dXUyyTje?=
 =?us-ascii?Q?ICXKgsm0G8uKXNtq1XCwGq65E8LmlkIV9w6yU02LrIIwgY/P7/czWQjs2bV+?=
 =?us-ascii?Q?CI6VQk81RNUqObtHzZ0Zvk+Gdtvf7hrq7ER1d87KH9ayvwLzEoG6R62TP3V3?=
 =?us-ascii?Q?RGJ9VbVgyLar2N1g4mnN3i9GBx66yFonV6mtQ3aUW3UEoW6wOrccXPklqvmN?=
 =?us-ascii?Q?XZ8bXh84QjOZoOXvR2qT8M7BNNEwXbFynNjB8Q5Hu9lK79P9HG80H0RIUwKD?=
 =?us-ascii?Q?U3d2H1qoiOGhguws4DVCSbC+SM6/IQL6pWT3a1EERbgQJPM+E8WshaX0Ccg8?=
 =?us-ascii?Q?9BDG/bIWExMOclP4bINb8Y8StlcQKIOnX2izM1+FKvurzB4AxNxkLX7A1u9l?=
 =?us-ascii?Q?GpKTPa+U0CA9sK5Nukkwg0QwIA6rNHd8ExFdJv2MZpdil9AcmcJwImXhZkT1?=
 =?us-ascii?Q?arh8ToFrKUNoAWP6VqlekA4FJtcdYIUV4UUR2ASlAr/cZqo+P0h88SBSRumg?=
 =?us-ascii?Q?5Dyv2bO1okuKP0S3ZdVwVwhgxVEHa+YvRMzQMROzRrNwZiIZvUoRspoKMK3Z?=
 =?us-ascii?Q?pDq//EZsfNy7N83r3WMo3AZuRdqFBpzO62vk5kNoFKgLZ7LwpNtXFfRO9ai+?=
 =?us-ascii?Q?vGjkNZP8jwOLqCtQt6ndvTe3rsp7pDjga4Lot6MB0YSp85zwyKSUilaR0v4d?=
 =?us-ascii?Q?S9kuuHn8Ju2ruSFRzsFcCHWqhFy9foIgYgQEzV2p9Or7rULSvImJ7an+i+B6?=
 =?us-ascii?Q?7EKsLoUgeHzq5bGHpNCgsPC0fFzD5Y8Dmyw8qubMf8Ks04Ouso9ksBJvvqE7?=
 =?us-ascii?Q?/d/4t7lQ66VDEulO1ikftlarYSYw8d2yd0ax2DfzjaOCFRltrN9PW2I6PA7e?=
 =?us-ascii?Q?YL9GHUb/hVK+52eOCI6vM7hRA4YohJOENPfMefjHBPLlGTyIS69Q4Dy2ztKd?=
 =?us-ascii?Q?xhOiu3gEY1eELiaxa/MshfTP5Hi7L9eOcFwnWMGg9DaM8iWhSAIrfan6l4fG?=
 =?us-ascii?Q?G6OKtMGo01C22RPM4kSuKKb4vNjcgv0DGZa7ooXEvAwEw8BtH23+Uz8fUsf+?=
 =?us-ascii?Q?j+o7d1pkQsfb6s2xfFTEP4LYYoMn4BCFvbCvu6cV1Us03WZH11C7d8hCTArA?=
 =?us-ascii?Q?AThRdc7zkzmt5quLuncvKOFKLFppujxrliXSwAggKZqdoGyERxJZ8aI17eMi?=
 =?us-ascii?Q?LhheLbwSrgw+b59+h94nodsgvnelm6iSZ7zQIxquQpn6ovePcY2vGgltKWXS?=
 =?us-ascii?Q?XnGBfByw3N2kzYBRQiXSripWLwhL3fuD/sx8QzQhjFvj2quLTVOiiZ/Lvs6b?=
 =?us-ascii?Q?AGVd+b0yRRX9w+vfW/oFQxQ++HUxZsd1QrBEaixjKb+MwLWORl/RLHagLRHS?=
 =?us-ascii?Q?5/k0jn52KFpBYuKLiWIwsYLWnyqJRyCjQdKQjlf4?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149f1085-8a24-4853-90be-08dd7db59c3e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:41:52.4154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdnRQsMZB6/jNMdNfhvJ4PYfwy4ozSYC6SHcGRFIfnO+b40BNWdsn/p4kW/TSBTYzNqIjq2cYZIlerXmsr4sbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8437
X-Proofpoint-ORIG-GUID: vp4XKBnDcNLQN-irMgXm6P2WDHbTPQhp
X-Proofpoint-GUID: vp4XKBnDcNLQN-irMgXm6P2WDHbTPQhp
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=68010522 cx=c_pps a=5b96o3JgDboJA9an2DnXiA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=t7CeM3EgAAAA:8 a=JlKoGYRGfjBZGDWtW-YA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=852 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504170102

The kernel is affected since the following commit rather currently the first     
commit in the repository.
f2f136c05fb6 ("Drivers: hv: vmbus: Add SNP support for VMbus channel initiate message")

Link: https://lore.kernel.org/stable/SN6PR02MB415791F29F01716CCB1A23FAD4B72@SN6PR02MB4157.namprd02.prod.outlook.com/
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
v2: Add commit log

 cve/published/2024/CVE-2024-36913.vulnerable | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 cve/published/2024/CVE-2024-36913.vulnerable

diff --git a/cve/published/2024/CVE-2024-36913.vulnerable b/cve/published/2024/CVE-2024-36913.vulnerable
new file mode 100644
index 000000000..3aec72af1
--- /dev/null
+++ b/cve/published/2024/CVE-2024-36913.vulnerable
@@ -0,0 +1 @@
+f2f136c05fb6093818a3b3fefcba46231ac66a62
-- 
2.34.1


