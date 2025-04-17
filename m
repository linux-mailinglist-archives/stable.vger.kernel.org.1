Return-Path: <stable+bounces-133054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE03A91B0E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E883ACE84
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287EF23CEF9;
	Thu, 17 Apr 2025 11:38:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEAF17A315
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889887; cv=fail; b=jpRZC/HH2hNdAo61yuJzXTawG/O0ro5HVl06kHS4ZsVWH1jUHa0kzwsdEFm//+AUsQ2ntxuRA9cYDs4ezUr7w2/UFiU0DJxHOocytPcZwhXCcT8oBx9iQKzAmIdbzmlKIrCVdR6LeonsAKQA2AN4cyFkpaQP5PisbS5H/2jDr1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889887; c=relaxed/simple;
	bh=Un3VBtfyYUmfDw2Wx0qgdtH1XLEg7gyvBk+h5Ji+Cdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnZlkgYPN/4dOQD1o6K4WZI7uINiF5wN2gPSq8BMjVukfYzbsTAbyNwb9YwYLc/sWPEgYEhoB8mglg/J+lg4IpeN5S6XmTK80C2y/uUQRVFLK3zs1cppMwDKzAeCejL/a4syfkIm+3D7nSEyPdSQs8zSuUNXD5nlGebnwEpmQYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H6023T019651;
	Thu, 17 Apr 2025 04:38:01 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45yqpknxbt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 04:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Elx5voTzLo2r0E8ZPdv3WE1RE0dr0ngMTc4dWpv4h9OCaJEbPF0EmRDtKcm7y6DqhB1r+hvq4OVLw1JloWQFQKFCFU0oiWGvDzpbyxahVLwOYTqT7HuzeaDiiTQqJnFrvjO+/aALvafz/YuVPt1IoKRffSYabZ44UC01N+f3I5NSwJ27/crWoKdQjl4st5xvyfht9Ry930Wuaf40o28ntAXZ5VCDORixMhoWtFgEoHU0gnwuLi40+B/jteqjZo0Vv5cRkpa0PTZM1ZUDrpHB1OWhRUdEkhlIhKo8LgpYBJ+RynT/lutqBbeK3fADbxauxd7+d5csTb3FCJlWAv8Q4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Smqz3KmfibYsS/ucJ3yS+EeY4aQyczgdVfQdVEP4i0w=;
 b=n2xAYXGVsDbhJw7u29fJyF0EQ8iyAqhHgKYnVlU8kg2bjCxAnRUpENFLGv52uqOAsQ5XcUX8hejBcfAo4gH3rpIptJM8IS4w2pM1k+5qpR7WNycohhF9n7jUyHZEbNWY4eth1a9lYshDcVf0zgVkRvNTMvR1ggHKWvydlbOK+M+inw3KqfHEcE6imPgym4DCMoRh45SWm4auTyeIFyDmHqwoFJ7aPBzIv1cqeB+RgC9l9ZdBBZ8YygvdymgITuEDJEzBkX7+NJwQmA2SkzZ/BwGRqh4Ck0oB37o4hL6sDTvFR6kjsdXo3ZMBB0RooBzgOZkl6L20HdsTlmLfFm1Ttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 11:37:57 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 11:37:57 +0000
From: He Zhe <zhe.he@windriver.com>
To: cve@kernel.org, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH vulns 2/2] CVE-2024-36913: Fix affected versions
Date: Thu, 17 Apr 2025 19:37:37 +0800
Message-Id: <20250417113737.273764-2-zhe.he@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417113737.273764-1-zhe.he@windriver.com>
References: <20250417113737.273764-1-zhe.he@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|SJ0PR11MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc4bd09-f799-4e9d-efaa-08dd7da44cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?45mupcFVNjKzNEszFxBu4jv8TZR6adopNJRQ08LNKvOJs3a8QfpZi4UXRyAo?=
 =?us-ascii?Q?mkj+r1sNOgul8zn2wp0d/qLkefC2B7AUa93QiN/jKpJoJR9ImgFdTfshZSry?=
 =?us-ascii?Q?BAKQKlE5N9LsdPA24SMB5lccY0BuR0uv3TJlD+RLH7G0P1vusyEsCEhYqvM2?=
 =?us-ascii?Q?QnhcO1Vi7Y74OpqILFzi2z8W9kNqtWcO2eRsn9EWFQAerrySpfEV5tLtl23R?=
 =?us-ascii?Q?WHA82qI7pCKbWEduJ4Qm1UBd3W5vNn21o42nRv7qsw2K1Cu0tkqpAnUz6/oA?=
 =?us-ascii?Q?jy5m5D5yVQu7CKgQi9QyihGFV25SycpTfZ/Y8zMP1Ybb8FHyDPBfr42yZb0A?=
 =?us-ascii?Q?8x/cRz0ZcCTSPnyIWw6cn/lT7iWCiJpSJtE961fbLQRhO/FjREzbxHCo2QH1?=
 =?us-ascii?Q?NzNje7h3QqYalN0u7QaKtOX0Z5QDxbXFJXpxEFEYXEIB8FwYIcDih9HNRJBW?=
 =?us-ascii?Q?0tEd/GZn/coWLyAdGOgH4WAccDmo99LdTc17zmb/wfmkk24Zci9OlyYmn6+I?=
 =?us-ascii?Q?dUMbdmGWMWJPOhuXCtCZwQkRQSWIXyUy1mvpBP7tLKtHz63U2uIj/oPA2T6M?=
 =?us-ascii?Q?WktyIZQ6LYJTJc/hWCucXIaBscdBClea6N+UN69cy/ifUmafRcJZ7GBflWPn?=
 =?us-ascii?Q?udUEHo/WWbSTlWTJdKR8sxLv0YQAClFxo9jggiktRFVXludaNgYC7UwgHtI7?=
 =?us-ascii?Q?0/ClyKJ9hiov2AMt7K3ncUCG8RhqCsQ5v8FWiZqdREQ+pDfwTQuMzjR4dbZq?=
 =?us-ascii?Q?Pe44mKNtnncmoDbw8GSkIag991DLNmF9wO2HSNPjkiiTgjiqQL0dh3nb9G3w?=
 =?us-ascii?Q?vFHg+bAdiIcgR5/3CEr/gZQocQ2cAS2l/QEMycv/y9JnGRUx/LRoQvcfVluZ?=
 =?us-ascii?Q?qLF6AQYqs6T7EvLizm2ratLYdsaHXxWL6c50/HZDN6pdLEY83vsgPlOv5Q4N?=
 =?us-ascii?Q?eqjkKS0coorr9ZpApF1jpz/5lu2groPmme+zG6P0IJjNHUI53if00tQDIRcq?=
 =?us-ascii?Q?/E2Jyzv1mU5/IYeJuZiF6Nt5BFGoeAqFW7F1wpjK2UGkSVy3rsi1bfw7VPxk?=
 =?us-ascii?Q?jPt+77trCiK/f1Z+2aq2oyLY+RRFz6nEGr8Qfv0UXv5vS3ICSgecbc1qu2a3?=
 =?us-ascii?Q?VLkwPEAuMQ3Q1pxXG/oss8mlGsgSYsiY1p1IUGr9g+EQcbtyqSWAM0VhGPHr?=
 =?us-ascii?Q?RV+AaL4/jjSbflEWzEsWxyDyVfiOfvKHAwqUI1o+9w3wOGzCo0YfRbM8tRMI?=
 =?us-ascii?Q?s4bH8Td9lWLIzqdlL5UuDIPo0Q8aLzNwqxHKxi33Mhw7ocDhiZ2/mjUo1X+D?=
 =?us-ascii?Q?1+YV8tXgheJaO8vvNelRX5OtwCH9zg+B77cPvZfVwGJn2E33bsaG3b1N8Q+E?=
 =?us-ascii?Q?uQehHFKrfoBVkseg8+kK6+i0hbR8LrlN/YwX0QK2q5fHeD72Z/SGIPxpapp0?=
 =?us-ascii?Q?oxT0eH7F1rDowFmtmmy1s8aJ01UaSReXEIWFfZCdq42ziKHL6haFP0ftCaNM?=
 =?us-ascii?Q?AyjP5SdOMRmDA3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lmqzPuegQBDRKZ7DkeKEx0wMmMPszGYYn8StEzhNt131C1t+l032dOcadm2x?=
 =?us-ascii?Q?Vs1ZQMDBlQbph6RqahI1OjKpcj9BpSnRhsg4ycgot0AyWmOvxYmTUs8qWOkK?=
 =?us-ascii?Q?mcHOZ1XQmIfFiAv4pZke8lYl+v6EBw/xvQ+nLOIkfLHb7Ocl5mGGVwW6BSFa?=
 =?us-ascii?Q?TLKdZWQg/8xPkTjor+dpgoxYGtR9RqP2R36K52/uUTWLgV5jcONn+/XrBz7m?=
 =?us-ascii?Q?0+1Dib39zu6uRF5HvKF8ViEEKYewVcl4p23rzgRMlPV35rE7r1NblVPf71YB?=
 =?us-ascii?Q?qwpaa9XVmeOaIFZHmbSP+aMghOxwSgsPDBZRRrtVdeherEkr6htnshEHbaV8?=
 =?us-ascii?Q?MmzniySP7fKFkYGe6fV4c5rXy2Hr9TzCele5e9eTnml9Si8Nc3IYXJgkV1+4?=
 =?us-ascii?Q?hms7UTIruVoDgqZxxSlgVwLuTEus+GiIh1q1+JEYJkHPi9OVgE+T83wBJugb?=
 =?us-ascii?Q?j5DG1Vdw2TWVSXrJbsZwsCfo5/UIMXi8ZIZJ91e0WufDoym7/Ms9grgj3wre?=
 =?us-ascii?Q?SG2sKb6wZo6XcjYLAwDN9HYrTy/vVZAgZddF6AUxLk5bbu2NFvPL8oDrUIz6?=
 =?us-ascii?Q?kShq+qaeBIQ//2ryZnDviLZHVZaHuwaDWyhPudvYLBoF7JWdXQHd8YAMDDW2?=
 =?us-ascii?Q?8Jn72t2Hv40lyspjZCw5fXVkMfWS0rxy6A7dFmfWM5rmKb+doGBlMBhUv4Pt?=
 =?us-ascii?Q?ukvYP8GvAfjslzI71eBot+am+/uJxEyxtiqO8zKAZMLqY4pPsZbyMvk1Xhib?=
 =?us-ascii?Q?/HS/u+pjohV2dU/bp8Ics5VOfW3Lyr8dSHYBdSXo3/g9gKHvlwYxazoSAT31?=
 =?us-ascii?Q?tu2v0exuuwYKhK/ToEBJkZclIqXCPwb4pGzNTrhKXcrtv83qdGKNYz7b9xp/?=
 =?us-ascii?Q?Oig7TvkLBJ19ZrwHTn81YFkDZmpV6GluocgXS3sF/6u/MHlhIhVAi0wYV6NQ?=
 =?us-ascii?Q?YwLBlTQjADkTc1xMNj/mKLVa4MX4tZ1nUoE2wpOxYAjkWcipDPnLpN1CNDmQ?=
 =?us-ascii?Q?CP6lOwscAAsksBiOR2oCHI1Q2FJ4Zl/TqKHQX4c8aDWWq9qSyKfyRrlnaoKX?=
 =?us-ascii?Q?35jY30e4JbFMeuO87vyMIMihEkBeC/iwvcE2ygRVDVn1hRGbBcIndKMAj9pT?=
 =?us-ascii?Q?4WQy9ObpmVRlUrSCHv98r0BMiv56LtDxIG1FGN42Mj7pt5VtaAKB06yVkdz/?=
 =?us-ascii?Q?0ae8qCLFWqvyXOEvoOGc5N6/XK4genZibPSSf/VaL6gyjYcvlJaLs/+7Kus2?=
 =?us-ascii?Q?RB8Td79gGbx8OcuOYbpTizQ8Yfu9IjhEHihfB+jvNvDrYBYYu5QXP2SF8TLv?=
 =?us-ascii?Q?KuBSGtvU2sRbXBBu69oaJgbUZuF9WB7/tG2R8G/2VWO8JyKXxC55/yzzui2S?=
 =?us-ascii?Q?pWHokBlt+RkCPm8EDHojS71Xk62C6a8+aADuTQTyzD49ilW+c4Pc8dVWZxON?=
 =?us-ascii?Q?ZbglZ5a1omHfAaPT97qS2yYXz4BxFvV5F/bpah10sqLeuSO6m676PWl/HmhM?=
 =?us-ascii?Q?qSwd0s6Ie/4KgJINHqDm4lc6+75PAEDX3cqQQuZsOB+R5P8846XJLt0Yapal?=
 =?us-ascii?Q?48+kJbu/5MihRSeqByYYzyg/G71dPbAHewrWkGBP?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc4bd09-f799-4e9d-efaa-08dd7da44cbe
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 11:37:57.5768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+YfypGH/baU8kPmXaivv/GV56o7i18HWY0fkj3EPGEEPNKFk7ZVMZ4uFl6WM2JOE9IC4q8GSQOuGa+iMIWPZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-Proofpoint-ORIG-GUID: 247PTnE91w5zWr3vmdk7GvSrFvpzqYWm
X-Proofpoint-GUID: 247PTnE91w5zWr3vmdk7GvSrFvpzqYWm
X-Authority-Analysis: v=2.4 cv=UZBRSLSN c=1 sm=1 tr=0 ts=6800e819 cx=c_pps a=hSS9g3ca6WprpwKybkK64g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=t7CeM3EgAAAA:8 a=JlKoGYRGfjBZGDWtW-YA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=601 lowpriorityscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504170087

Link: https://lore.kernel.org/stable/SN6PR02MB415791F29F01716CCB1A23FAD4B72@SN6PR02MB4157.namprd02.prod.outlook.com/

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
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


