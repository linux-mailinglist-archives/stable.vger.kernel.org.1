Return-Path: <stable+bounces-124584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F9CA63F3C
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228DC188EB11
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 05:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6322153E2;
	Mon, 17 Mar 2025 05:10:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B3A21518D
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 05:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742188220; cv=fail; b=coNQbAaULV7Mf0vhC+sfJnTK+5n7DvE94KeNeNnRWCZWFKRSaUWGH0DETMqc2qb3CvaLz6xcxW8yLCM8klfPD7q8SbrMR3ppOmFK4s8R7xzEVITrWpXKC4QPUSgMi2HYXrZymqF3SqoWRx0Z1muirNlpcZjyEwY4DpG43RzZ/ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742188220; c=relaxed/simple;
	bh=ha3A3+2sJX0uUZhQfZb7LmZdavUeeD0R7CH9LAUepl8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=or3OvvY7GMxvObD5aHFdGDP5ZzHpIr0rGNcnLVYeov2F9glel8xmKAo53HKRlOdlV6USWJSCUjTSQkV4lcIV3Fp1MrenmipVYE6+fEiVUPv3l2K+/AwU6gsqHxT8jhisDObUzXlO9M9RmDtr/51HX8x/oSbfmv80jf05Fbjq2NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H4gBUu001509;
	Mon, 17 Mar 2025 05:09:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45cxs0srsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 05:09:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efN5PzSg+qjHUQN2IQJ8qeqdvvhpcO1+hSaV+dD4LNAjoVblbRAG7agjIgLPM9mucQGGB0k8oJuF4wvPDiYaOPE4AxqGvrt936P4lHjBm5IZrSU/InHhrbwVD2W0/ZR7+txF1MPpCGk64pYQzhZRw6UIAZ/CkiBHVdMru5dOxZ/ZyFAOA2POZZzLqBpbvvEmqCzTIK9oc7p9aGJW/g+lT5lFTrynQ2xlKWljlT6gIHqIBz+S5Weglp4Dk49O0OiIPWyR176dV7YPUfAKgFSZZx0knKD/oS7wA541KHkquo4MetdV6TLoOEJWO3WtBNYR+V9HSFvg76IDgbHxOpXtbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fplD/GlXq1lMQbiG5DeMAIwMC14zoTNUf7WrX9bmxo=;
 b=nUzl9AKgQD5sF0XCyEzP2wVowUw7joqJXVu7rD48MynDTFicJabGoFNTXJyfpeXDXn6D+XQbriiShGj68+0N1GgsUKBGqugvHFxH6E2qn2mxRXjI72yKcceh2eBj+hLqe8X0HALVL15wmD89eatDLDSVdCLV525S9Znd6pzEtcNIuBBVcHJTsRA9E4jmnUIsBODfWTJHpML5uhaiOPh6GwzcljdLG6oLyAP5GVmcAZwxuNQYr4vJ8ZBbkBJXYX9aPalbyf+JiYCuM2n6r0fFo2PUS6ZHz2ku6YdymgtG3ikIIQp3krmoqbttsl/Gr2H2U+1fm7ZlMXuSsdO+k1VD1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by IA1PR11MB6515.namprd11.prod.outlook.com (2603:10b6:208:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 05:09:46 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 05:09:44 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: George Stark <gnstark@salutedevices.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee@kernel.org>, Bin Lan <bin.lan.cn@windriver.com>,
        He Zhe <zhe.he@windriver.com>
Subject: [PATCH 6.1.y] leds: mlxreg: Use devm_mutex_init() for mutex initialization
Date: Mon, 17 Mar 2025 13:09:02 +0800
Message-Id: <20250317050902.1151438-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::33)
 To CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|IA1PR11MB6515:EE_
X-MS-Office365-Filtering-Correlation-Id: 916b64cf-60e7-4619-7163-08dd6511ee58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7S5Hqk5iEuMHWAn36NRl29Ki3hCmeQvVhRW4LZ0S523lbrSyr1xk0iaeURdC?=
 =?us-ascii?Q?m+/fEVmbFovPA5Lhti4HTM6cZUoapCCkqMEB6FTkixz3oHKcJ8vd/lBk4SSP?=
 =?us-ascii?Q?qAoyZ3zultqO2qi6mnT5ql4pZPn6/1AIx0L7Ts84QjBysoOprh6mpP0tQZQQ?=
 =?us-ascii?Q?3l4dlYOyCA/zKdoS6bxYhgDrdc/+X0AOEVSs9nV2/zyB0ECDwRN3Zm5jhFDG?=
 =?us-ascii?Q?d0Tlx5PlHKC1p+nQX4IF0plveWvIoQGqH78whXFt6xhyobBC9iP8MCcKFvSP?=
 =?us-ascii?Q?dKOf0IDRaNdKUAUHyVmOH+4WeR+XxfzH8RLhgYLgexAvrI7XrLa/4QLSZd1S?=
 =?us-ascii?Q?8N2WVOCir1DqKGW2aE8Hu5qnoyjesTRZflfye3XvcIS5xV6QsWSNPi1kexrh?=
 =?us-ascii?Q?HLmf5gOEpwEWLAnEy52KjxoBDxeALab1apKhgbw7ZTPa468o1jP+1w9WBPKv?=
 =?us-ascii?Q?1Wbdsi8TSJZ1pXpgRQf9WLQDpB/z0fkOrn7Og00n7y7bh2JlIQRuNx53GEZv?=
 =?us-ascii?Q?6BGB3AV9TdAzHfYNkyxEzEhdkHa49dLvy7tNevCyvrWU0BEfz++IE8RwkgZn?=
 =?us-ascii?Q?BD1BC/UEyWmom9AE0iK/yTg5P8ezppIlctOlCDAAbjP/EghUGr+BIiTgGvBS?=
 =?us-ascii?Q?MBh/8VozuoYXlf8beWFy+2xtMb24Pl8ceb51gvCUnLo+pCLRw7VGuBJ4g71B?=
 =?us-ascii?Q?l1z0yCQgsTM0qH927jsvoQAG3G16fTkTo5BdevPI6dRacDNL5z43mlBRp5SG?=
 =?us-ascii?Q?sXUGNeGt5gJrhWTle87dvh8Vn3Kjj9SeL9m8sZvTAYU4DkwzP1DtzJ+KaFzC?=
 =?us-ascii?Q?m5sFf4i1r9NBOXiqZSQsGs3fbwf3A7/k6lQd+8frMqO7K6PrBPMG9vvLI9LU?=
 =?us-ascii?Q?GJLa2q2GN1Ac/2PGioxoiRmJHxtXtIGHWU1ECmu2kd64mmh9n9m08PdmuvvM?=
 =?us-ascii?Q?6HVCmpqhmrjtnYWPc5zY/VpSTXYbqZl98kbR9wtML1m81BQ5ts5Hmd6ucBZN?=
 =?us-ascii?Q?pMjdHCca3fji/m3QdPOPAr83pOmOoC5UFOwvcmmjNNvDmgsDqsV77vxFEudM?=
 =?us-ascii?Q?KthgfW3NTN8OoZ0bGovkpHkBa+ElBvYYZF8H2zohAML3iSPxMeha4I0BJDav?=
 =?us-ascii?Q?HzA09bl/+A6+EdUGwHqvSV716ixYok69GGGar2Iw/danj56EgdjKhM0v9Bcu?=
 =?us-ascii?Q?+LD5mR6V80bb0Fq0pS/uZ7vswu3SAcxT5oc1HHXvCKgsr7IV4/wORIqlj7rC?=
 =?us-ascii?Q?0CWXmqE1xHQSbReLYyLr7PMEr6OjB77A5OCMMQB0zi/bXLYHp0hVgcrx1O1D?=
 =?us-ascii?Q?6sUae82/mr5Nq0jsjLL1ZykHNDXVCoBTAhikAsdJn6LPNvn8gfIPiCd8sRI8?=
 =?us-ascii?Q?PgpjnzECVqwRvAxJc5ESCUzyhk+NjfLv1YgtExZOBQt/tVfM6Ro8gdiESu/j?=
 =?us-ascii?Q?GStNB4EaGZ9xet0BjyYQvggkmQt+ilT9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C8M23NJQRAuz403pGt3QbTlIQhhsdQnxTwWdToRgEv9VQLjb9vvGa8whPao2?=
 =?us-ascii?Q?PodAc/RRBQwshGPFm7v2A3mwPM/BWSts0Yr19Cmgq57yUOkFlLvzN2BWvBRH?=
 =?us-ascii?Q?Glefr+rIo0ktEqW+6r5zIAbtzLdqGgwXvmbrelVwrZeBgoNJaveQtax3S1VU?=
 =?us-ascii?Q?5PdRgD3gBHOJntTy+uHtk+FzGgUR4Q/FRbo0EFzs0PQeAs4UwFyJcSQKNuzp?=
 =?us-ascii?Q?SK4FEpkNV2RGJ4otIULqTMk+64nmgMyip72OZyDfO4UozjL+JPylhtbxMuTR?=
 =?us-ascii?Q?/VbXBMJWaimcTzGf44mJK1Htwizcu+k7iOWFkEK8j3kg0ZM+TNeeNCrDhW8C?=
 =?us-ascii?Q?Itjoh7MkH3m1u38vGdHyQU6QA7CJRc4N4MbRywASs48NXbdwLrdjl3Y+YXiz?=
 =?us-ascii?Q?YqT6VwjrBVUwd9C8cjT14StkEuc/BedpGUUefWw73mGwgsWwkpCiz8Ianugb?=
 =?us-ascii?Q?dVYDaZ+EiCvjHkqGCNkRnBqTbdzo9Qa5+mMe3a2nc1Z0kGZv3fiV2c51VGQX?=
 =?us-ascii?Q?ueHG84J2uxggo+jUlKs2zslULeuQvN54f0lIxxrbFxk1/0b4WYI/WJ6V3zUR?=
 =?us-ascii?Q?zMxJTaIFiyE9kunEFQE08fVdjO8WOWzTYmQE7C5gCOIxqgyqPceYljKlELhx?=
 =?us-ascii?Q?aRIsIED8OBRJKGjtuVVgrp2i/nVsXWR3AdnbVKpV/89cFQEvn9joo1hzd3wU?=
 =?us-ascii?Q?nEafgWut4/N7w8Zw1hhGvI3nr2E/R2t79eryLLmYf+xHmkn9BDH2W6bNH8Cb?=
 =?us-ascii?Q?P3dd4ZKDpKJKayX1DvLI6FmmIsH+8AMfYOOe99KiYBRU32L3dl1KHNt/JvBk?=
 =?us-ascii?Q?CttDOFM2xRa0tj5U59cJX+syK+Wcy0S9OZDndY1QE/WLFxXbdkEegPyfhXlr?=
 =?us-ascii?Q?aqKnlAi18MxWdXtKGDSVU0AuetOfkWyRIpzer47HF31vNdtz8n3KWABhhuT0?=
 =?us-ascii?Q?vGCWfGGafhcO1evYSvwdnuYOISyklEuBBX8njTcqbZhwIr9gDBBFfuJBxlXG?=
 =?us-ascii?Q?ODZLEE1ETvrtJF/DqltwLZ6OsYqTx26CxF2hW0WizvwbYv5RQKIEfYvXLfV/?=
 =?us-ascii?Q?mElxgSA70qhhir4IkfbjKUz+BGlGPQ8BXTcguMNjziSIBjsg/8zP/zMvMmQI?=
 =?us-ascii?Q?wcweb/l0Hc5BBJzYjcwb2lTSQNdo41sI3KXiJn8mgJ/0uuqv3xnP/ZN4weSV?=
 =?us-ascii?Q?3W9HMK4ZpJ/VFUSZsxjJD7sxClv0ElCJNq1ZIXeaj2MFF/gC4Lqf551S4WmF?=
 =?us-ascii?Q?2nYCd2hSTmNX87riB1rbp1QSuILd1SAp0lmvYmDonOzEZclDDRY2YKEm4Tfh?=
 =?us-ascii?Q?RO40Wyvjc9C68PGdzXfRKh6AZPawhNsnsjdq4/6LVOAuCUP2mm+KY0eVYEn4?=
 =?us-ascii?Q?1EUTuXkUgLO2H6qUUHt2NGFTfwAqpfnCI1ezlAo5nbbhm+hDzEGHpymNJKzp?=
 =?us-ascii?Q?9BbEd2p2399hfGHrQhhuSWXL0sYmD4qKLNSILAOCeq8Y5thc0XkFZvW8LXjo?=
 =?us-ascii?Q?uQDAb/i6QcdrbKj3P/9TX8aa3TAtqBeLJLbf3vyTDrWQW5LMGQDeDkdFp1MK?=
 =?us-ascii?Q?onQKVi3PcXQIed7eqH3xuOM8cQSVm9nyPBDlXd9NvU0o3Gc56MmGaYN6kiau?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916b64cf-60e7-4619-7163-08dd6511ee58
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 05:09:44.6378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q02e0BgWPhIZxLQj/xmRFAcg4Y1HawfNl9esBL4eN1ckM927Vs1FIpa/j4hKMNF3RwK0p4RMsT6WopKwja3MBuE9SKoyPQcoQ29T2qLp4lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6515
X-Proofpoint-ORIG-GUID: UBVFGViF5IHhFwLdnZV8wvhT2ymxrk5J
X-Proofpoint-GUID: UBVFGViF5IHhFwLdnZV8wvhT2ymxrk5J
X-Authority-Analysis: v=2.4 cv=NY/m13D4 c=1 sm=1 tr=0 ts=67d7ae9e cx=c_pps a=MHkl0I0wjNeC5ak5fNlPUA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=oIrh2ZjCAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=XpvTgcSfuN2lSBDXnSgA:9 a=PybRJKj6JLd7Pqq7RWh6:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_01,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503170035

From: George Stark <gnstark@salutedevices.com>

[ Upstream commit efc347b9efee1c2b081f5281d33be4559fa50a16 ]

In this driver LEDs are registered using devm_led_classdev_register()
so they are automatically unregistered after module's remove() is done.
led_classdev_unregister() calls module's led_set_brightness() to turn off
the LEDs and that callback uses mutex which was destroyed already
in module's remove() so use devm API instead.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20240411161032.609544-8-gnstark@salutedevices.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test.
---
 drivers/leds/leds-mlxreg.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
index b7855c93bd72..31eca8394a26 100644
--- a/drivers/leds/leds-mlxreg.c
+++ b/drivers/leds/leds-mlxreg.c
@@ -258,6 +258,7 @@ static int mlxreg_led_probe(struct platform_device *pdev)
 {
 	struct mlxreg_core_platform_data *led_pdata;
 	struct mlxreg_led_priv_data *priv;
+	int err;
 
 	led_pdata = dev_get_platdata(&pdev->dev);
 	if (!led_pdata) {
@@ -269,28 +270,21 @@ static int mlxreg_led_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	mutex_init(&priv->access_lock);
+	err = devm_mutex_init(&pdev->dev, &priv->access_lock);
+	if (err)
+		return err;
+
 	priv->pdev = pdev;
 	priv->pdata = led_pdata;
 
 	return mlxreg_led_config(priv);
 }
 
-static int mlxreg_led_remove(struct platform_device *pdev)
-{
-	struct mlxreg_led_priv_data *priv = dev_get_drvdata(&pdev->dev);
-
-	mutex_destroy(&priv->access_lock);
-
-	return 0;
-}
-
 static struct platform_driver mlxreg_led_driver = {
 	.driver = {
 	    .name = "leds-mlxreg",
 	},
 	.probe = mlxreg_led_probe,
-	.remove = mlxreg_led_remove,
 };
 
 module_platform_driver(mlxreg_led_driver);
-- 
2.34.1


