Return-Path: <stable+bounces-132812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 058E1A8AD90
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 03:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E981917F3C5
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 01:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DD61D63CD;
	Wed, 16 Apr 2025 01:36:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553D19F40A
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744767418; cv=fail; b=l/T7Jxt103SXng/1BEqo0ljl9T1nHIMG+FceXtzAjw27vHRmwbAQBwYIzpvhWqz87MgqEjesPTFFbKq+iFUqgomHImobOWTSTMgnMSrqJIlCELpwKAKS5mxlNhKxadkgjZCBpdCh/FJ3S0KOvRcn9FOn5ivOA9HAG0lv8m62NPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744767418; c=relaxed/simple;
	bh=+pku5Jk3Jmego34q8sTUjGCV15uOT8GKM6PyFYwJlYA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uo7bG3oMzNe32xqQSEcxb6zVL5/YA+f5AndZjWpkgndvWoKmwV3tFI18TqrJ59iHEaaTA+IoVL992qFEVU37VfzMrHWLnbWVLK6iW69uIv6yIWBHGC2wcL7xrhKQ93iw8Ek4mDEJH/ikD/gCYGoRbn7jYVO1kcU9iCGL7U498NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G1Knaa000490;
	Tue, 15 Apr 2025 18:36:48 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45yqpkkwhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 18:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jP633B+2kSx8g6pYqZflLJX2RIfjPI3ensLR6BrHMMWIiRntwSHs6LMFpwrnrCaMPnmrKKFvKc90/SIYWW4fnDE7KyFHkcSMGV+h66vYqwi29Anxt7WoZuv2bC34cVTom3+vBb2xmHBcwp0P/pZH1mrSZt4DYLxrjzwNjMAOfp5MQ1Ho/hBoBdHVR7JpRbS/Wsq3knYMaCObjXiTkcx/hBHF7fbXNkEMYdF5zJD7Qz4WVOxWyOkXb5QbvjR52oYTmwt1SBzrV9ojepjyxO3VmwFsU52dvtY7bMFa2nWCpBJhbDvNTPSC+h9DT6WItJ9XAj74KeERcIpxjmS3DmZi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR58ZjL+w3pY32fvAVrrtsvHXfZvUcupVzynB5u2KGI=;
 b=gSQWV6pvtFO3R2B4EU0dy+oroklbyoYj3+x1HVAkWYAml/tDUZCUFnjiYsEk6BRCmJ4bGM1xR7IDfiEG4XPduEPvASPB4tKY1k0yaleZ3Vti/jJKsGG943AxHXPjpCCGuNo6qnsa/Pmes5T5E2oXSmVBHMtuk5cFrkscv8i7zP/OH1RdRPFpIRvbwSdxYMMNWmTHpgbHgaYE3lbpUFiRiFYiWkIw8nns5LT1D/FmmJp4dA/tapOJiTxBrTaiVvLniKT3c6Kv2TlrTaJbKMa7fuhmTenqqeg+JJucBN94BcZ3TmXgMSd7rH8TWklGOEn2kNTv5S/E/1Vmpr6nXF5U6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by IA1PR11MB6396.namprd11.prod.outlook.com (2603:10b6:208:3ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 01:36:43 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 01:36:43 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: kanie@linux.alibaba.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc: zhe.he@windriver.com, stable@vger.kernel.org
Subject: [PATCH 5.15/5.10] scsi: ufs: bsg: Set bsg_queue to NULL after removal
Date: Wed, 16 Apr 2025 09:36:33 +0800
Message-Id: <20250416013633.449339-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0366.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::6) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|IA1PR11MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: c213c994-0ef7-4e37-7805-08dd7c872490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WuXgVcssppuzZJMz1e9voE7JcPGsusmWjCBwfpQGIynW5gqub3xnRhPJPxV7?=
 =?us-ascii?Q?tdHwH/TCE1MrHO2zHGz7eHLF49stPVvp4E1Bn935tQbxFTVa7C1HhahIm9IF?=
 =?us-ascii?Q?x4WJOH0e+fw2MClQtEc8opwaLQeoSD1Yr9rQ63JiJYZCTCc2DB+2qfMIBayP?=
 =?us-ascii?Q?WEhO5Wgiq4AGQKrSfUWRBdp3z/3AVuF2VyXskez99hfCvNcq1X/9yyVoTo82?=
 =?us-ascii?Q?EEDCMY5Ny/xQchkiY9de9iVe9BhTsGle0bEISAQTvLSPK4JyVZnRfsoRuRbs?=
 =?us-ascii?Q?85PKvQOcx7mubd5e4aocw6ZVb6MIh8PNbqL797u2Cz5z4eQRtwYkXiPvsIM+?=
 =?us-ascii?Q?pcJKYeJEcjHLXfAcwz0Z7by8/jgoWJzFah6x0KA9xaWd/FqdNGzC9uw3+uWY?=
 =?us-ascii?Q?IAYxtTK4yL8fa9o5F+UVYEagwRyjcx1zZmAJLXOW8WCVA9Yzti5qGGbMDFAW?=
 =?us-ascii?Q?o0H1LWKx6nsy9LKHMxcbIuvQUTEeLyftdVPYHv5PikyezwkOpkNueeFME2wZ?=
 =?us-ascii?Q?orlQcxRFPZ0umyvhXqOGTdjl74ynPbJn32fCUBYi5T22zFIKQlom8BJR3dw/?=
 =?us-ascii?Q?8Qjfzaf1jpdKvYx99R4EPWi+r0ssCQPb4xv3pAq+qjWb2e0lf+fXSu0no8cQ?=
 =?us-ascii?Q?4fHNSaWWy1l3gA1Ae9/jG/tlJKzRNxGMo2csN3t6ZLMTNFlHqPgrEgZVFzno?=
 =?us-ascii?Q?4Ap4VjKDY9pUZ1C28Q7ki6BQRFSGUdKvs7tl2Ery/RsW9CUXZKyXfUMT5d2C?=
 =?us-ascii?Q?dq2zSsLUaKC9jCu5LmKvMV1bQNqkgTgb/zCd5a34O5OSBxD3757dLCH6sX0i?=
 =?us-ascii?Q?5AjavK6GipQPc5ESV5WfKM6VviV+NeTd6XUl1U6HmwH/Inko9hP3efEDJCtf?=
 =?us-ascii?Q?AMNhQSkUmFwIwslOjhOln3Zv1DBw7T74Kx9oOrU+BuJeB0++MOZ8QXgo6aoE?=
 =?us-ascii?Q?yQPwqMDKUPET8r4k5UJmfVuLQn5tD+6zuud/hn7eQG4DLo4zZcoQiJw/elpC?=
 =?us-ascii?Q?aeUkcK2cc+vYbKAblRYxo1lx14vNnRd6yIh1S0RozQb5+1U0XHJGY9DfsBUN?=
 =?us-ascii?Q?UyJtzZ1xEk/plWoWkdBIHYMXxY+38F6vUESddi69s6OUPK+IeDQ8AjdHNugD?=
 =?us-ascii?Q?0EHI3aVNUh+aMd+GVagVZr8l5P01GSOcAaBBqlPX36ZJ5tZGWg68GhwtSPhD?=
 =?us-ascii?Q?ToEj48K2otMwX5ZIAzjuxN7K1lj5IYqAo7GlWatvNy5i4VURjEm5IaQ0OIN3?=
 =?us-ascii?Q?I2873ZyM/F6DxjKF+quRfZb0Gb++HFAUdN80R5u0VWusRiwu/xNsU20LuIf0?=
 =?us-ascii?Q?/5CRtXyezFrSNPSMS19wswKgMxWaFkTmpXFD1Mu4vjQajDbzBexzhuV5zlGz?=
 =?us-ascii?Q?XKItFvrQwcYLKC3QmbPD1ayiznogpi6PIXOCI0WxkUf0mL0NvZduttIzbHll?=
 =?us-ascii?Q?CT24fsjvZA7kiAPEaiizi/sY9GVIamcvD18IICvosPeJiTiSvbQsmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JI8bu5Sl42Tu+r5LLta7FcQVmKFi+ZFsjA9579xevG9q92W5SF5WUlsBbJMN?=
 =?us-ascii?Q?iYEH/CgxVqBWc7beA3u/4rgq+fi4o96EGW/+S9IHBOznOIPljTXgZklo44Xn?=
 =?us-ascii?Q?GSmMKF6Jm+NCe0e/TnsXQqeeHLn1cj6MZe+ihu+427aVR158wemWDYi3tnNS?=
 =?us-ascii?Q?apJ3C6HomACrTUvltriyWY5TUx4iYYeItNJtGCmm8MJzRCzpvqg3RsLSsBLC?=
 =?us-ascii?Q?rIhdZSVNsv0WISBIOgDpFPZ0FOrNAm4/G3QIWOH4yRBKg5tz1lkeytSVgcyn?=
 =?us-ascii?Q?o5ufda7GNmb2gVMdbLpxZ4AgTMHf7N1wEGK4Qoo5Db/3mT2H67rx0IFlXORt?=
 =?us-ascii?Q?tAMIMhSXTqI/o/hyklItoYIaf/WssTJQ4F9eiOM1ja7+/E63TRjEZSgwlWHm?=
 =?us-ascii?Q?pbKcPS1uGGJZCuxUR+ZkQVadS7FLlP82UPfSiEL9ViX8w9YctxmsGW7+sHAm?=
 =?us-ascii?Q?nBIeNpHj0g99FKLVZG4Ht5Uz/m7vZZZ+soiZpoyIeK9C8A41i+ei5Iin5fEJ?=
 =?us-ascii?Q?4dBP8yJ2L8QBvPwTeurJraKL8aSVQYdr814Bdu60DBkrH1Gly1/79aqf/+DG?=
 =?us-ascii?Q?KPz6ICj9z588sCO1IhxUtC44Lbp4dYWFXPPwXCQGzUbDTifOvbyR8PgYbjIw?=
 =?us-ascii?Q?s33EvVvZ0aKk5d70zg0W1T2lz9m+Ivd5I68IQzHLlmCIJhcLLVDcRvNEILUH?=
 =?us-ascii?Q?+UQoZIZ1yrYw2Mkf8YWuq85G/i42KBtoK/g4CElbPeJ2Bfl7cIuagg8qEDYv?=
 =?us-ascii?Q?QEUOt2zbArIhqucl/Zoe7wKVp9tyr0lbGgA9VBevIzjgTFseV/mc1ME/NgEC?=
 =?us-ascii?Q?ptJMUrLfcmVIRyGf9Xh1nDTgtOaQEBBtXEFuNHLDdSRzDtDhN7vr5e+x2Wej?=
 =?us-ascii?Q?r+OxT//wuPWzqc9xxCKkDQUJNN7loof3gvLuZ8SqJtxeH8xu93vKmZ0jpNS9?=
 =?us-ascii?Q?U+0LT+hW1OCVl99PMjBxL960DCB+SAMIjom+rqMZcLNrOjskgZoKLK/WDgTo?=
 =?us-ascii?Q?w93xVaru1aawLZ8FYdKd+MMFXDskZjtLiaQ+YFv9GKqCwlR7JfJjyxJAYvPf?=
 =?us-ascii?Q?yzGpiTJW2F01bQl3LvFDzFKM8hMdwVW9qAArFq0c5ki+c4YlZumESfCHRAwz?=
 =?us-ascii?Q?xSpdudysh5q4THoL8uFkY3byuz070TNAOJwlWiwE1FG09hzkizndXGOgZuix?=
 =?us-ascii?Q?YCJoLW8x69PR8lOjRAIdx2ujAaMhplh3+kCCtR714Ga/pSucIvTxy7V34JLE?=
 =?us-ascii?Q?JsHCOZQ9Mi8VO8O/d1P7w7JCJHwsNtfumYqdolCXh0aYGiQ6+cyULtRKvlmM?=
 =?us-ascii?Q?MMvOMW6md+XzNt6EUD2b5cNbsHMlrBIWyf1vzOvYgFGNL2fnRs5259hLDQfG?=
 =?us-ascii?Q?uPuincd9rog1bRzHYAJmNX6NytI9/bmRNFoqNyPPKSUpr+3TSfWalEtiT99S?=
 =?us-ascii?Q?5gMwwNJDvLpzVuYn48htVr+F+aKlH4nb9bH/SwKmDiXlImjFPU3OJUuRxw5J?=
 =?us-ascii?Q?A1aHbHUWuZW9XBiK8hWoqru15MeuA1gXjVm+MqJO2wadI+1quxf4XDE6vIUc?=
 =?us-ascii?Q?CRV1cXMt2o33YQYrrLVtlGsywv964nRZrCLXYPtDfgndclj6Ojjzo3rrNvXm?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c213c994-0ef7-4e37-7805-08dd7c872490
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 01:36:43.4986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSSJg7ap+s7aGzUiTb3rVI9yLTNUbci5qOeVGwHH34ExzKNFFOcMNOlf1CFT56Pu0E7TLvRj/uezfcM0gxNxrLGF4VIDeVmrivr5n1OPWBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6396
X-Proofpoint-ORIG-GUID: Qgu9lLjTkOOEEf_zKod1E1b-h0NnviqS
X-Proofpoint-GUID: Qgu9lLjTkOOEEf_zKod1E1b-h0NnviqS
X-Authority-Analysis: v=2.4 cv=UZBRSLSN c=1 sm=1 tr=0 ts=67ff09af cx=c_pps a=hHPfuxNGWHHq0fQgDGst2w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=JF9118EUAAAA:8 a=yPCof4ZbAAAA:8 a=t7CeM3EgAAAA:8 a=KBm1-I60o4NjQ0l6RaYA:9 a=xVlTc564ipvMDusKsbsT:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504160011

From: Guixin Liu <kanie@linux.alibaba.com>

[ Upstream commit 1e95c798d8a7f70965f0f88d4657b682ff0ec75f ]

Currently, this does not cause any issues, but I believe it is necessary to
set bsg_queue to NULL after removing it to prevent potential use-after-free
(UAF) access.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Link: https://lore.kernel.org/r/20241218014214.64533-3-kanie@linux.alibaba.com
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test.
---
 drivers/scsi/ufs/ufs_bsg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index 16e8ddcf22fe..b8bbfd81b8ae 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -175,6 +175,7 @@ void ufs_bsg_remove(struct ufs_hba *hba)
 		return;
 
 	bsg_remove_queue(hba->bsg_queue);
+	hba->bsg_queue = NULL;
 
 	device_del(bsg_dev);
 	put_device(bsg_dev);
-- 
2.34.1


