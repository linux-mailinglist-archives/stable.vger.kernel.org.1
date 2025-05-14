Return-Path: <stable+bounces-144362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A93EAB6A8C
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 13:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC7F47ADD9C
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FF02749CF;
	Wed, 14 May 2025 11:52:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A539927465C
	for <stable@vger.kernel.org>; Wed, 14 May 2025 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747223552; cv=fail; b=u0XiF8zH0WCMP16vqBpkbR/h3ZrzUTuUpKdqWBqzzaaA8CugsPeqyXPOkjX1BIzzlgrAkhFTNDbCiQr1xHIZPbA1/GPD9HiDLD0BguF9LOvG1rESC9DkT/FfbbOs1BGfz4DsHyFngF8gWlZwaXuaVH1y+3KmS1QiwkKL3129xaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747223552; c=relaxed/simple;
	bh=KfUV7VXHYZj2cZQtlGKBjyWs8xmWRxV0uJF+aiA1i28=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K4XexaQUK7cPNz1eN/XNT9F366LOWX+yzmVAXjz2EdtbDYZQXeba2sCLNrs9ctN4vbNxLWnDcUpH0n+Kvdb/7vChy/7/m99T6sdPFQNSR5fqFGzH10eQ1AU5M+LFsAKm+2mjKj19bLxC0kfZCjwuZSAtcYiKk7FcIFBUGZT0Uq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EATdhq026939;
	Wed, 14 May 2025 11:52:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbc8rycb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:52:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7Jx4ZgC6WJd2KGMedt/MUsSRUtnfWDPgG08LBRGlmAH4WV7oisRCQa7Rnz6ibh7NQ4QSHhGpDrDIUB+9VV3sGPF80I5+vWdR/uO5MwkCUcNYxxct8dv02bijpcL4wzvtj2CxYcTVb9yr+Sg2tddNNf/LRCZkNXwvoBaxcIIy629mpvLUcTsNIv6n31b+hoPeZ1XhOXvqOpZV3dbSLu/ZflYSUmXutTV0Zb2O22Djh36d0umFV+GVekT0AnAi+NozC6q3FHuOlOtORG0qX+oMVh7ydCRRD269LRJdRb28jm6+6qakn3JdI39EqDRkAAk/qqV8BrrIgpk+sBcDC2EQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5ZRIiuZBum2U4wrTiCMrZ8hUv7NJtC9QOIGN89yYO0=;
 b=iWTCYNuzKooqEKcj0qjpmCWontgT5/Id7Od1sYBJJIyFmCYK5F74qbqbcUN1ockuBg37y44u0bq0+6+fjn6fsM/U6RoCz86hYsvZNopf+8qLtm1/dBEUbCob5jLzaQRvXlaP0C81F03P64dwK9kTU8HaLdmLVYo6A2UoylrIQnNzNQBe7y5xZW+xGz7sLR/1vC1wkSucfWo+WtF8BlSTvLYqqpolBxBkkgBMN6M4Lg/WqCATkRHNqmqOJxbESMo3RtfVqUnT9egvUEBCqcEBnadvrEeFSDEiSrUfcE/oUHe9KCUUjXSU4xKFlkr5+3sVI+xtqStWhz78MSXEZMX8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA0PR11MB4672.namprd11.prod.outlook.com (2603:10b6:806:96::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 11:52:12 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 11:52:12 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com, nnac123@linux.ibm.com, kuba@kernel.org,
        horms@kernel.org
Subject: [PATCH 5.15.y] ibmvnic: Don't reference skb after sending to VIOS
Date: Wed, 14 May 2025 19:51:54 +0800
Message-Id: <20250514115155.3487850-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA0PR11MB4672:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb05c04-c43f-4b0c-b29c-08dd92ddc378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RsM7AMQab1lHhNzPYLi9YsYd/FF7wYAhiRR2it5B6bNc8GCNUW2CTJkmvdIp?=
 =?us-ascii?Q?ZsDjQW0VSY1V4SgJIGGBWnez+y0EA8R7WwfqXw0zRhZWrQdClY2IEmgIbsnO?=
 =?us-ascii?Q?wk5ssSG0Tlz/6Kk0w2FH01+BtfnYFP7714oE1kgDz/TmLMGzss4GQegUQlut?=
 =?us-ascii?Q?Ob7zUPpyCIIoEtcFhE1CPw9xrQfM2CFo8sg7z4lcCAoSVXRTUUKlbhAcx8lF?=
 =?us-ascii?Q?3cWJ4zfzUkCkgOdTwZPeZVjaYexbdbDt5VFzyr0awUozZbTBlj+UeCuSr81n?=
 =?us-ascii?Q?NidcMpaH3j0WkDWCGGGUXBB+kKFsCULYIJttjHs7/mO3gwni4nuiBEjMADHY?=
 =?us-ascii?Q?IFvA3KVB2igI40zQJcJkQIvTnnUI54TRjFOt9lU0iIjcvatG4hsYLJVMfSFT?=
 =?us-ascii?Q?UeVu3mrdylFlDxDKFOsL1UYI486n05rpdjYkLTqWMLKX/nmwp54CiFjHnc3p?=
 =?us-ascii?Q?D3m21wQbIwhhrOqJ3AYbfJ9Z7umF4zKbVT06B7FzL5eHJcXCabMckFoUuLb0?=
 =?us-ascii?Q?bL2y4hktvKH2zJQ0BiiCnx/2X89gDtGfKuoRMKeSD/5oHWv+agXtwDrHhtox?=
 =?us-ascii?Q?/vI7zPzgASGRZStckgJ+fj9uqMG/hVA+UV6kRJfugN5XdzuHkZRp4tv43F1w?=
 =?us-ascii?Q?8f/UwOTBRNgelKzUCgMcIWrg8O8dbe8jmCxiJOvoVLVpsUc7RHiQ+dSL4Vz1?=
 =?us-ascii?Q?HrJUVEz7nk5GA1mV4tYaI2DupNK7mMyrUnF3s9tKHlFpKaEiyNFqniXLurtU?=
 =?us-ascii?Q?g+Sdcp2ycHITnk3cwKG3+a69qjWMySgUsPAwMYMPCaYnF/Q3kHM7nOAvMI/h?=
 =?us-ascii?Q?5grPqw/S64iMq2C21xPXto1l/f9ivX5IhITm/fT9Wvk6hrdtWVMbSPAGpfvo?=
 =?us-ascii?Q?zlRGr87rLceyfHHJTxJ9K1ZflgipClytBhrrUJ735bv4ybEKXBId9wgnSBOx?=
 =?us-ascii?Q?ChIyeF48AIQz0ocXnX192Q6TsJ7pqFNr72Gcrsk/jPSrqH/1mAXmXXj/zCIw?=
 =?us-ascii?Q?9N5co78iLzZ5GctSD9MPw+/EaYJ2VcKV47aI7IulY04/z3LPa0F2isJR7BSn?=
 =?us-ascii?Q?XdlvZaFJxkXnIXKyVjc5bfv8kWOAyT/zffVW74qyh2pzcg9WBMHSCUp+Urmc?=
 =?us-ascii?Q?/Dj1bh+mZI4XNff9nn6rkTf2Ve1ISUWRw0pFcD5e1qIzcTFPziIhcA4kDglv?=
 =?us-ascii?Q?eJ2S7mTrvc7gZ3vxrLK7bIsZKLJs8KYwKJpg7uGe4gdMlIUJE4wuIHo5zqRl?=
 =?us-ascii?Q?tMZe8NchYERF82zKzy1ydeZuPR1Trt521+1jx7UXEYWjPe/jGV0uef4CAWs6?=
 =?us-ascii?Q?sERBp3UaoHwFJAT1Uo2b9rd93Tdjhkk4wws++oEhhdFKF9uSohY3PQaNrrGd?=
 =?us-ascii?Q?5Zx+fk/jiJPHxMnbG4lcx6gAr7czITk2WhqKiHlrOqPlHBsepNZPWZHc/6jb?=
 =?us-ascii?Q?Gp5ZzwJmURc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S7Z7Ia7Z2THZNxwEaK0E0R0lp00jtc7aFACRm+2UzzPM7k454X/0WpApJAME?=
 =?us-ascii?Q?wLGd79csknWXL79KOsh0KLq4tvu3+B9eemrtvvx7Oc/cxs/73YZJXXRPSdJY?=
 =?us-ascii?Q?T1wWC8yyuuKAcoxiXYG0l1jAAu7Zr9FpWqsd8kBkznOsIWfxCs/0cdKFRyAS?=
 =?us-ascii?Q?A7HU3E3i7NU+bFiaZbbSE7yppUiFj11JGWE06XMveAqA+VMCJeCxsVJaHO6P?=
 =?us-ascii?Q?pRPQv4iTxPEDR0nJcIIpxRQ60DfqEYGAsqfgwI/q4c9oxRqc0uFb7qH1D+VL?=
 =?us-ascii?Q?jgw0DNF/1s5EevsOplBCDeytKlrADQfGGYiQ4OY0VuNoo1TD3EBdqQ1Eo0JU?=
 =?us-ascii?Q?H85AzWup3kQp1+Nt0cup1nguk28Wkk2D107jmDc08C5nxc4wluRvfcc4z/dK?=
 =?us-ascii?Q?g0vp1EjgEWIayyfWmAlJO+PZrBroZyRpGKgQ+5No86wrygzDQonW1l0+TiPd?=
 =?us-ascii?Q?d5SX+IjhwRELZO9vciXwNM6lb2qw7VIR3a8s0cFzhp6BVevqhMKbK5iwZS1K?=
 =?us-ascii?Q?z4f9Z4kMph340CB82K9ZEd5c2e+ASw8Cg+a/4fdt2RpvPt6PLb1TbLPqlKcu?=
 =?us-ascii?Q?elyN0NZxXhxFbKSVQQm9nTiSVJwQ8oobZ2biMgUq4GuPDvMnLcSmPsuPNLw8?=
 =?us-ascii?Q?wApT2oDOPF/eNAL5P6a4erZIYd2ZyTKhlk+Ek5RHNq37Td9SK6XVZgeYM8e8?=
 =?us-ascii?Q?yZOV3Tb503FyKWusSoo+uTTQYUR29WoFvf/cSoTvRaaQHYgyh7TUSlb+zpEE?=
 =?us-ascii?Q?/nWwDmuiMDrnR6WeGTrQVS9cxP2q2SEeWz6HgxJDikm5pytGkusi7v+9u8TB?=
 =?us-ascii?Q?CFZLissgC0IIZL/arI6+vVJTkLMFC57P3Tm3U6RGpmglXfx5Q3ydsfUhACDG?=
 =?us-ascii?Q?NeEwhTBkyJe1kib6UxIn/xtQnxkkWSzu8ACn3tqBrW/89PsKSEBavDGvAE28?=
 =?us-ascii?Q?vTmHTk0vckyvGaUZfY9EgPbgM/2/Zn++pn/vSH3/pGndzSS1/XW6EqNNv5xA?=
 =?us-ascii?Q?7/tlrsDZVnkyDjeXYhXS9Wsb8CVJSpfHR864o5vxj0K+LR1vrjuSzX6/nt+n?=
 =?us-ascii?Q?bh/6US/HKUR6fi4771gcf103DRaUx7TN7FCOcW5maw6Y1Wsm9JABDX7nnHEn?=
 =?us-ascii?Q?LsgdA4/a4lvE+Ww3eRxVcbaHruOgsoEs4gvIrU7f6mI2xRgJasfCzmIq3CkH?=
 =?us-ascii?Q?lWsHUtKvE4v8OSsTVAN6Fxwsox09CA5oGSIjSuF3qcVOFa6YTk04LChh8OK+?=
 =?us-ascii?Q?U0aTskJNnTuowWItxpuwgz81MRYa9IW9WX7NdfdRTpiMGiFuyUmydiThFeOI?=
 =?us-ascii?Q?xTKUwqb9P2Vpg/BfQ4z0hTgXrdJKMqMn+i3nuocxHt10AX9XAmJ5IQ+mwgim?=
 =?us-ascii?Q?40rsPM2fseOfEvaJfpP4O4Ct8rk20iLUP0t9fizg4knglxGYmVD/TfSkTnQ6?=
 =?us-ascii?Q?s5FTakVyT63lRSuoM0dd9QbrztEMh8V3tJ8jVajFAjc585EG1UudSg4oKfpB?=
 =?us-ascii?Q?LgLShR3nBeIZpkxoOitMuSZdUwnzFIwQ9hH3/PpxxY7Srum5aE/rgjBlrJBh?=
 =?us-ascii?Q?rK4UJ0ShERhvCY7OJ0xnZAMSEp3XLxKy9M1CvblaGV/p4YuLiLSfsB2IXvLX?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb05c04-c43f-4b0c-b29c-08dd92ddc378
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 11:52:12.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgmAVNKZx75I4dO7Gs+0oBzDiy3tLGt68xdPFDK4sGOAXXEtr05sp2IQh8rf6IacU5ypPQTHsH4Gqu/D9jBIwhWvGGoUoxt7gLBmr960Rfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4672
X-Proofpoint-GUID: V0HtE6QU1L3Ra1nceTIZuQB4FS71rqIJ
X-Proofpoint-ORIG-GUID: V0HtE6QU1L3Ra1nceTIZuQB4FS71rqIJ
X-Authority-Analysis: v=2.4 cv=IIACChvG c=1 sm=1 tr=0 ts=682483ef cx=c_pps a=p6j+uggflNHdUAyuNTtjyw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=bC-a23v3AAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=Yc5L10HpTH3LqOobwVEA:9 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEwNCBTYWx0ZWRfX/cepAGFuGFww N2DA1gIFVW3JTplxbpi3Scelu1fLENr8Dt0tvDfuCx9sOSJYyzcvpZb7BHb8qyWeAefaNzZaoMC VQtpaJmMbj+L3VM0NbyVTZe47/Dg+gthjOZSxhlex2ypSshn5vPmtmoXj72Wf76gt394CJE78BJ
 Tg/v1ZSB01+J0FLP/Bw0Tn+8rNv6HwzXisDvQt6jDkyh8MLttGAx755pnnRPqXl7mN7FBDcQioQ XYuKdX7itwRGOiPGBKNkGEi8Gm4DrsmdgOWMhX0hU4hLUCGRjryr7JLkF/rR1b0z5n/vE4DE8xy SlTMD9/XlEg5tBGhHhbNaEbGN5JqASF5Gk5X6xxKY2nMSk+bt2S5EmPQBhBga21uM2eim5PjYlF
 lLHA3/wCBBwVEoY4mekrWnTdvaBQgC8z8153Rc9zJ7CY7bJ+xiG00kgOwWOwQmTtIFxKnm45
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=894 priorityscore=1501
 clxscore=1011 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505140104

From: Nick Child <nnac123@linux.ibm.com>

[ Upstream commit bdf5d13aa05ec314d4385b31ac974d6c7e0997c9 ]

Previously, after successfully flushing the xmit buffer to VIOS,
the tx_bytes stat was incremented by the length of the skb.

It is invalid to access the skb memory after sending the buffer to
the VIOS because, at any point after sending, the VIOS can trigger
an interrupt to free this memory. A race between reading skb->len
and freeing the skb is possible (especially during LPM) and will
result in use-after-free:
 ==================================================================
 BUG: KASAN: slab-use-after-free in ibmvnic_xmit+0x75c/0x1808 [ibmvnic]
 Read of size 4 at addr c00000024eb48a70 by task hxecom/14495
 <...>
 Call Trace:
 [c000000118f66cf0] [c0000000018cba6c] dump_stack_lvl+0x84/0xe8 (unreliable)
 [c000000118f66d20] [c0000000006f0080] print_report+0x1a8/0x7f0
 [c000000118f66df0] [c0000000006f08f0] kasan_report+0x128/0x1f8
 [c000000118f66f00] [c0000000006f2868] __asan_load4+0xac/0xe0
 [c000000118f66f20] [c0080000046eac84] ibmvnic_xmit+0x75c/0x1808 [ibmvnic]
 [c000000118f67340] [c0000000014be168] dev_hard_start_xmit+0x150/0x358
 <...>
 Freed by task 0:
 kasan_save_stack+0x34/0x68
 kasan_save_track+0x2c/0x50
 kasan_save_free_info+0x64/0x108
 __kasan_mempool_poison_object+0x148/0x2d4
 napi_skb_cache_put+0x5c/0x194
 net_tx_action+0x154/0x5b8
 handle_softirqs+0x20c/0x60c
 do_softirq_own_stack+0x6c/0x88
 <...>
 The buggy address belongs to the object at c00000024eb48a00 which
  belongs to the cache skbuff_head_cache of size 224
==================================================================

Fixes: 032c5e82847a ("Driver for IBM System i/p VNIC protocol")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250214155233.235559-1-nnac123@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/net/ethernet/ibm/ibmvnic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 7f4539a2e551..4b87d9f59628 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1758,6 +1758,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	dma_addr_t data_dma_addr;
 	struct netdev_queue *txq;
 	unsigned long lpar_rc;
+	unsigned int skblen;
 	union sub_crq tx_crq;
 	unsigned int offset;
 	int num_entries = 1;
@@ -1843,6 +1844,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tx_buff->skb = skb;
 	tx_buff->index = index;
 	tx_buff->pool_index = queue_num;
+	skblen = skb->len;
 
 	memset(&tx_crq, 0, sizeof(tx_crq));
 	tx_crq.v1.first = IBMVNIC_CRQ_CMD;
@@ -1919,7 +1921,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	}
 
 	tx_packets++;
-	tx_bytes += skb->len;
+	tx_bytes += skblen;
 	txq->trans_start = jiffies;
 	ret = NETDEV_TX_OK;
 	goto out;
-- 
2.34.1


