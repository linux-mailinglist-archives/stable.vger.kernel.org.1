Return-Path: <stable+bounces-103960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BBB9F0348
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 04:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200362814EC
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 03:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2121D16D4E6;
	Fri, 13 Dec 2024 03:52:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79915B10D
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 03:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734061954; cv=fail; b=sGGPiky/otiY3l0dhMcOk7DHGkAKVcatb7ReaNWrxC1t6BqIFj8gm2qeySuCtCoZEmRoOYL5ucuxR4CGH+NIiPX6YCABsEydDCXDLMf4NHAIQGRQ80dNS8eFb0onZcVcjssdodot4zcY7gRFTuwf27GH0RfHaz7u6LNXpUFov6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734061954; c=relaxed/simple;
	bh=0wmiPS0kEu1kiPeCRGdflnHWkvsNInxL+ZAOYHlEbzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=It2GRgvHs6AKfcdDkur5+ldmAkhawLMV4g41rS7EWAZ5FbklMrVrdySX+YOJKejRFw9DAWhVN9ZrjHbTGP8xnngu1DWp1krHf64rUH0UHk7gI3hk6x7pTZK+5T1Klp3zCAlAUiiMzMY88i494mZYxmGwOU5xeVRMlo6YBxPm8E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCDskaI022806;
	Fri, 13 Dec 2024 03:52:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx4xemj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 03:52:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOmcIUn0oDJoQY8Wb36Rvc9Op0KBI+CPO+aCWDMlA4SqYYl780AMvoxXmhPk6aq22mQXcXCoiWWkPPeIPw/0TR7l9OhZqb6mBER6xZeoo1HiL/tydiUbuPuCUY4WOFqFR5/0zALD/L1W+n1joP1T7n4GuX22Feh5L3T6vXi8fnO1vtjZuhbPD8GEKy3gcW7pcIOQ7ayoRoOj5+XSFhu+T8IFSy5MlCP1a/ORsTCdCldLok4nSqh5XkwF2DLWtCNJIB70hosN7TaVziGBRgtjcDdqYjXQbUqZRlT8LEss4kaHXbiWRO06M1DxJKmvW2Td6Kkui/WgBLOFhEngeABEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W2eZcMO84V2bG+zH2a69h/xb+VLwi4dRzSSkIIB3O4=;
 b=W/UNkQ5pa6SMW8Gf0xkhvcLk32zLmcmm8ZGfiYBkIB7PvchhoDdByTvOOcw1umASaKiE5QhLwrGTDwx9oFz3Zgpr56uNwmRb7cCi2un8ZQS9X5HLBgFPOwPvHETiWegZh/OlkihAxlQ0nnnqRGT+dsvEXYJnaTMKWf7P1Eyx2z2DSHPh+F4CdJMxvM3FnRi9kGyfb54DA7zEkiktxK9czOr8HlxYlho6X81tsOTRvQli7vXwPzK+jI7PR+rHDkMc1epMLvJ9JSECUfqzwSFnLFO3QSwIp+Ct9uxJGta2jnoBflopq2cCUH+dofzceKCBXBqw2RFKaW72ocPCeStdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by DS7PR11MB6150.namprd11.prod.outlook.com (2603:10b6:8:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 03:52:01 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 03:52:01 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org, gnstark@salutedevices.com
Cc: andy.shevchenko@gmail.com
Subject: [PATCH 6.1] leds: an30259a: Use devm_mutex_init() for mutex initialization
Date: Fri, 13 Dec 2024 11:52:06 +0800
Message-ID: <20241213035206.3518851-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|DS7PR11MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 377eed60-effb-43dc-c899-08dd1b297fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ydfaPCRcKWxojWgYIHy8lgMBrVAYBR9cZe/eqqOOjIAx4MAQF9YFqTJKc2uW?=
 =?us-ascii?Q?XD1ldSYUbz/N6uIDARoKUouEEaTImx/CZfdGse3ZxtzRkua2oOOSu7jcniWC?=
 =?us-ascii?Q?iLZCz/wGPP1xppk758DfkSPF7fao+k8jkCvL5TsKI4hQIMKl8PjLA2A29UoF?=
 =?us-ascii?Q?AoGOkPEweCc+c2gBz0+P20AsJob2bqRXt8CXxmB71CaYDHufFFkarGQfbmIl?=
 =?us-ascii?Q?kFdfCC+kQURLy24dbSQyYc6BSDe/sizDr7arnX+Kzs/fTzYdwhQB5LIqotON?=
 =?us-ascii?Q?Gxbq9MBfYW9NXXHgaxkdpwl7IMEO8C2EfBTyi0lUI7JokvshAq2Ll8KtCKik?=
 =?us-ascii?Q?qKKVMxvrkzzGvmaiuzgF/KVO+M4DovihJoasO/zHjQE5+HB4QOTjjJTa80c4?=
 =?us-ascii?Q?JO9/TdEr9oNQNNFtkgKt+ysGWdO2wSZolm5BmzvtO99MEyLM8ShD4zRqg+z9?=
 =?us-ascii?Q?zMvrNTEBOmnOVJ7ORuLuIX44bVbKlsTMjsNv9T7A83laR+heaZxZOHw/y3pk?=
 =?us-ascii?Q?2is0bU2IaYojjararLv0iZXhh4Q1K6cMjlwjNiVsJe46x9D0STTR3x+HDvcs?=
 =?us-ascii?Q?q8SnZ4unaPMjFFflWc3aqXFdO7eQ/dBu5Vmqk59rU6fkwwHFQmcbwuhKUy9G?=
 =?us-ascii?Q?lvWPmn4Wjtq8w4qGKiusfjjNqNckNjbfUYD8CvQmvhWwn6YSIy7RB4E+Y2cg?=
 =?us-ascii?Q?4PV3QraGvILQsfh7p7JNEd+zdPrlz785llo6IxY7xlUJuVr4QFAopNufcX4b?=
 =?us-ascii?Q?rinU5dIfBA0E90hJbFTzSw1NaGeolYfm2ZZUOhDJXPTWCQdXcQZW+SFf9SuA?=
 =?us-ascii?Q?+sln9G1V4xW1UzjzHJy5xfObm4bgZbPVwaxEhKsKsypfoj+uGJSPC/bLnCRW?=
 =?us-ascii?Q?3k26bm3tncAkQA6gJazZYJ133oPGp2e3rj/knO4+CBH30H0PYFV8+ztkQZni?=
 =?us-ascii?Q?gtR/OHnffu5eVpTusl6uNqbXS9pe2SnxCwnPKoFkf31cIKBEU+fpXx8TjiqW?=
 =?us-ascii?Q?dJtaR+qcgjGBbUXjyLyry72/cR49+PbuhCf2TPQgV9G6gYZBnvMoZZdy09bv?=
 =?us-ascii?Q?OVgmzZLV7Nr+x6616Nr18Le+DXBarzC6ijrzjZi3ZpsiWyJTDM85R+BZKWjH?=
 =?us-ascii?Q?1BZ2LTX1zdJJNnYUKO0qwxN+qfmDBGsv/eUmMde9AL5iCD5eQ69S6JLhT6No?=
 =?us-ascii?Q?ThKR0Ljo3Dxm8gVBvB0aNCqyyzkE6xLJtdXltMus7Fivo3xQlDhTokJTs6f3?=
 =?us-ascii?Q?UyWV5wV4UOPrwP490q0PjVyToiTdzIaw/8y8PT/8ZOuC48EvPdu4GmVuY9Np?=
 =?us-ascii?Q?zsenabWTgc+VXZ0jSKndV3//Y3RbOq6tDFDH1YwLgceO0p6AZYUwo/2j+Mx0?=
 =?us-ascii?Q?lCCRibJ6q8CatD4k5qxHjxW8z2IKr9OWyWIir0N4bj2LnRy6aXGsrhyiFZza?=
 =?us-ascii?Q?lnguk/7FHsfIHkN8rRa7WO3n8NiTR+GG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zFUqnHmwNRL6FGGqMKMOrxOOOCKRy0ubj53ZZFFK7SArE0NGbWruDBYNgyp9?=
 =?us-ascii?Q?8kWZKBygz/WC5MOxxH6R/oEUmVMhXeKsjBKito3YPok9ynEJZzWBVDQsdWW5?=
 =?us-ascii?Q?vhkQL9WODAmTEBNq+EEWxzWBKmpCz1JxbrmIqtmDVSg/i7uRhDy+5JnzHdvX?=
 =?us-ascii?Q?2jE75XbYCZMbO4Qw35fzZDomhvWqgfJNgXhA8TvwGim7ickdD6D1VyBIKPeM?=
 =?us-ascii?Q?dTP1yYr/N+i6/lkWNc6Q2qkOH2lwnxgDrDUgYZPtep3TGtIRTneL72Rm5IWa?=
 =?us-ascii?Q?i9ytnWIJRuKZlfhqnJbEmxhB5QO/4mBQf0Gcj5J16AX1qhoWdJgViWpnuJES?=
 =?us-ascii?Q?ZbvERtVGvpdUoUeC4iHDw4uCUQOWqPNTq3ov2FFTjGeGFED8j0Gw21Q64HfD?=
 =?us-ascii?Q?tQCAH8xo4lM/+OHs32BIlVMJfB/1xfCDtLW3jT/gFxiNUTZf/X7tweyX60oT?=
 =?us-ascii?Q?tk4yZSWbQyi1CdSXHVLQKGTgYjOuRmaffQ3C0yN6EJcL29VDkdbAA4cVAqbL?=
 =?us-ascii?Q?EM1luIB2IngQph2qHkiIf9E87du+L2KnnrzI7lOOctsdzJ9njvrYSzcHaegA?=
 =?us-ascii?Q?QwkDlQScF9GVA5tD4eUWWadG2vdPxwSTKy2allwPCLs/vZSqRIGUJdbsDexD?=
 =?us-ascii?Q?BepWZ1l9KUXjCyAqykwrFsVmxSE6mUo5l4VXejod1Rng/waGdnlHH92B4q3N?=
 =?us-ascii?Q?PR0iOI+O2IJ7HkMAa1xjf7Bi1pV+Zy7AccLmGDeOytDQ8IfJZF7m6h071akw?=
 =?us-ascii?Q?rFG7Xywc3hk6rQQGCxqSE8gsR1v4/sfOFbDMIXRG0y2OopFk/FLkc1OUyszt?=
 =?us-ascii?Q?odrCfEvDxM/wCNPcoZxakyZafvgt8D1ZfWxOcGtIaLN9H5IGt3b0ChK4FtG8?=
 =?us-ascii?Q?PmpO+SU3BJ/soUOOs0jynPc0UJUoh1yr2+64V97rY0GoOI6kEdeo/fj2+twQ?=
 =?us-ascii?Q?Pk564cqEXD7uFZOx35frEcGpiPpagNyAWSMLfodFEQHDfE60WBe07jvA0qxF?=
 =?us-ascii?Q?/fut2zfu+Z7IFCe0qW9I1oW/xLeyRpECeYZzVKimoOhDgX/DhPDUFGiDMr70?=
 =?us-ascii?Q?iYb5BwW6QsxI1+QDHqziaDsRmn+NIqNcaUz6jx1BF2P9mcyCoUzNZIhhamM+?=
 =?us-ascii?Q?2Z6esrLglRKY2oPyRBietCuQHfLhFaMppa09CltciOjmDhGc+8gPMfyiTq5K?=
 =?us-ascii?Q?6MUzcplR1o98zWK6Re6iKHz5YxEwA7BWlA2Rq+fYTYjAxXCFfP2gs2KNkwF+?=
 =?us-ascii?Q?/aX2uQfjLqP+8NiJQnnVRKjLAG+Rjor7N6yzGA3mkCF9CZfePr3J70uIWlkO?=
 =?us-ascii?Q?ExYrFeyg8b4wJSmUSRKe3ckEScmNGO6tRDjEBGgPkPmz5L8Gq0EZUAgoIJ+b?=
 =?us-ascii?Q?5o0XG4wPqY1plMtgrjHBnTyBAN1wSM/oQNluxd1+YHpogV5Y7HmumlpaOZr7?=
 =?us-ascii?Q?cv+BwMSv2ROrHsG14Kfkzv6RJlUDLkQ3BldlWDH6THpll7DPfEg3CskSbO/p?=
 =?us-ascii?Q?Dnhdf0uAOjQvJ7cUYHayZeJMXn75FAqarOA5tmAXHrY/HnJsaz9l41IzxMq1?=
 =?us-ascii?Q?HBzKuG81oAasXzRRyikZ/aWTVJdYuvsXLcfrMvzuFY7SjIZQtsb69cMF25Z/?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377eed60-effb-43dc-c899-08dd1b297fd5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 03:52:01.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5KTB62nM/SsqsZjJ4109VKKyGQ8ZeXee0/t1IS5AOn3ArdSwg0Tx+6DJjimGx3Xz5PjfGg0vPgaD0tEqI1C6WuXnKoR1Uo74/yNw9sWBpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6150
X-Proofpoint-GUID: 9LFcmKdpnXIYheyWCuxnrVxifsqwhWba
X-Proofpoint-ORIG-GUID: 9LFcmKdpnXIYheyWCuxnrVxifsqwhWba
X-Authority-Analysis: v=2.4 cv=Y/UCsgeN c=1 sm=1 tr=0 ts=675baf65 cx=c_pps a=SX8rmsjRxG1z7ITso5uGAQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=oIrh2ZjCAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=X3DoHm6qPMLrhE3DJoQA:9 a=PybRJKj6JLd7Pqq7RWh6:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_01,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2412130027

From: George Stark <gnstark@salutedevices.com>

[ Upstream commit c382e2e3eccb6b7ca8c7aff5092c1668428e7de6 ]

In this driver LEDs are registered using devm_led_classdev_register()
so they are automatically unregistered after module's remove() is done.
led_classdev_unregister() calls module's led_set_brightness() to turn off
the LEDs and that callback uses mutex which was destroyed already
in module's remove() so use devm API instead.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20240411161032.609544-9-gnstark@salutedevices.com
Signed-off-by: Lee Jones <lee@kernel.org>
[ Resolve merge conflict in drivers/leds/leds-an30259a.c ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/leds/leds-an30259a.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/leds-an30259a.c b/drivers/leds/leds-an30259a.c
index e072ee5409f7..374011e3121e 100644
--- a/drivers/leds/leds-an30259a.c
+++ b/drivers/leds/leds-an30259a.c
@@ -296,7 +296,10 @@ static int an30259a_probe(struct i2c_client *client)
 	if (err < 0)
 		return err;
 
-	mutex_init(&chip->mutex);
+	err = devm_mutex_init(&client->dev, &chip->mutex);
+	if (err)
+		return err;
+
 	chip->client = client;
 	i2c_set_clientdata(client, chip);
 
@@ -330,17 +333,9 @@ static int an30259a_probe(struct i2c_client *client)
 	return 0;
 
 exit:
-	mutex_destroy(&chip->mutex);
 	return err;
 }
 
-static void an30259a_remove(struct i2c_client *client)
-{
-	struct an30259a *chip = i2c_get_clientdata(client);
-
-	mutex_destroy(&chip->mutex);
-}
-
 static const struct of_device_id an30259a_match_table[] = {
 	{ .compatible = "panasonic,an30259a", },
 	{ /* sentinel */ },
@@ -360,7 +355,6 @@ static struct i2c_driver an30259a_driver = {
 		.of_match_table = of_match_ptr(an30259a_match_table),
 	},
 	.probe_new = an30259a_probe,
-	.remove = an30259a_remove,
 	.id_table = an30259a_id,
 };
 
-- 
2.43.0


