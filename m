Return-Path: <stable+bounces-95600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F8E9DA472
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 10:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504282869A1
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6401F1917C2;
	Wed, 27 Nov 2024 09:05:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449CF190499
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698315; cv=fail; b=VVURzMZ6pcB2B9ser77kaPqDAR9z06Bt/+jyyNcHS0gVc15HxIQVSeTEIHTz6K6ZwmG8UMu60dqbTr1C5CNPdgnIR9sfGICuleL0Sg77TzwTwqehMIVKC1arBhccsWtVX4K5F0ltfQaM5PElmE33QLo9K51LIm612qx1leY6bYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698315; c=relaxed/simple;
	bh=qS55QdBl9gCFW+Z+gg/IF+RJg9p7WdvM9iGZIaaOS2U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UYsKlbd0bh5Jhm5hPEBNQhhpSKj0c6LfsfuzrQtwlkEYZzOlKDWpQWbmaKXFVEzo444cGPJLqNu5lliMU8TakvXeA+8v+/PP2ubJsvC+rlHYUHQ7PiRybIpTrlJNTXgd5z0IJGyEyhKwKZEpJ8YXwfoPJLz0jMcghCWrWqgMOSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR6s3Pf020085;
	Wed, 27 Nov 2024 01:05:08 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433b79c3ta-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 01:05:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOy4qVsQGVCt6ZkFGk79NB06MsaUIqcLa9X5aY3XY0tR6DXzJ38mJrtAICVDr7B7szFydCBCnsyeW1zsq73y3LLs1bkwQXdCz34Ufqb1STSiLMMx9lwrgW4+hJ0QSvrPtcXh81VVIHdUNDFyyE5BhMqy+/mdGzh7dc1X+9CKGhiw4edA0T5wROahMR2iZM8+eQlmkQlTdpqgcAv/n/uJVwm77RH0B/BYQTXO2NAe2lyWPH3qj+FBYGboLpUN+J4vxXiiJ4a5yHbl1JUKBoZlguk8pp3eCfG9i7F+L2WdxeezgbfD6s3Nw3IjOBbcZhvDTxcTIU2At54REbuTVMWyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrtknuozXxVtD7oIlxogvNp6l7Mdav6+gdCMD8f1M+M=;
 b=WsFcLChnfY5hqJ7talBg9Ky+mBJ2bvjUG9695ocy+92DDZK1lUcnP31IlppDXmZqOzR79m1beNaC5bENNUN7Z9+5aqpnEzgDS3Xy1/EOggzljQQYhVoKMJTVNMbBUAJishxpDu0wTpJeFx9yFTm/BIbuAHJzMVMCZqE8kcmDHJjKK+EBleQjeoipttnBic3DdamSGgO++wMQpLzjs6xB14fuKUWeOq5j2ptpmTKjpxqtiA4Gkuk/MMgGZO4eakoR1dXHD+Bq3jCW9OFLSBvLEKN0uunQdGtZUOTQj7LzHDmhBaGw5IUqLevrVrJmYKtQ0rfJSGaGcQ8wesiHMM+omA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by PH7PR11MB6770.namprd11.prod.outlook.com (2603:10b6:510:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Wed, 27 Nov
 2024 09:05:02 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 09:05:02 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: justin.tee@broadcom.com, martin.petersen@oracle.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1 1/1] scsi: lpfc: Validate hdwq pointers before dereferencing in reset/errata paths
Date: Wed, 27 Nov 2024 18:02:36 +0800
Message-Id: <20241127100237.1138842-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0033.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::17) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|PH7PR11MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 5040a09f-7207-464d-ab73-08dd0ec293ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bpemttykXOvo1Dx3Sbki5s0BnbdRxC3vQjSVuSHkHAe57Of9bfsU0O2QgeMf?=
 =?us-ascii?Q?O7203YwRuDJEySfjoE9PRkxdSNcJ0jYWHm3l5oi/uVJUYLWg6FIdRlQUriym?=
 =?us-ascii?Q?fuhr6Wa4dUSd81jWSXvpSI1+ZowlGi7kCiF+4D9gzvhvHppb1+zenRSv22LQ?=
 =?us-ascii?Q?VT5FLuE0wz5amUOkE033gkxbEHzAPdyKnkVKYyFMCsf7md+D658j+HQBA2oX?=
 =?us-ascii?Q?oGdejJ0fwCqOQMFhRyxtiTRoqrThb4tfqN0cJspNf558u3O77jnDb0Rn1R8F?=
 =?us-ascii?Q?4VeboV1WUexNYLds4Jlzg5rDzDOmqgftOzcA2Ii/6swGeuNIqI+9sWL3x8+S?=
 =?us-ascii?Q?Rro9TpOab3AtzjDRx7F/yZmmhtfDap0v+yGUxSGa8qkIdJAf1c5mTuUPwmz6?=
 =?us-ascii?Q?z0gIaR36JyGAU0FelMqCBg/B25bKqqIzjovzH7PZUjbuHrp28ZpTrd2SjHF2?=
 =?us-ascii?Q?sNA9Rg/EP6BMhzu1stvFYeAkrWBhrg7eiWsy3YMF4EG/vTnveZl7aJPZiKAa?=
 =?us-ascii?Q?C1QTr5sNs1Po60Zoo6zPmfbmK9C7Zi/LqYSFHqqHAvWvatudy/mB8TrZkg8o?=
 =?us-ascii?Q?FvqbQWxFIScgU2YIG3nzLeBMu1vgWXZaZ1WYHbSEbwPR7U8z3FpyqodhsX3K?=
 =?us-ascii?Q?cr60OOSVG22aM0feLku6uJAX9z5ppo1ZjNc10ULvDJ/eiZc31ar1vgGRqolC?=
 =?us-ascii?Q?stLe8PNPP76tuvL80z6s4yO+QyqGmsPHbacIDfrzmlG5asgHQnhSP12vzBWq?=
 =?us-ascii?Q?oPzlbzzQHSpfbS4rMG1dS1hWVkHy88T5t7ZX4bwXdgwrumtxBO7ZuRtmJ+gh?=
 =?us-ascii?Q?a+TRvUH9pLtXXHWoktqokEGtL+8UnHOwwhx0rpGm6fXl31iDfDVUd7vikUz5?=
 =?us-ascii?Q?KFvW1SsXdpSTUsd01/JrzG6rutRDGQontY4P2wNvJeSwUyx3j6qvXoGqdZ9v?=
 =?us-ascii?Q?PrFrejhP79ZWv+6VEu2tsnTypFZt5OaYDHNmDqlJlIa79OmV7+9fcB2zUowv?=
 =?us-ascii?Q?LDXsU/JbD5xOiBLxT0wneHcYR6DLBGgdgtm2pWZZIA1YyZK13hvtRtT5gv5c?=
 =?us-ascii?Q?tbYYLwCCzUIB+y85dFR9Z+3xvYK5/S2OHlyK0j3c/542IaEv/1cJ04Cyx1ks?=
 =?us-ascii?Q?TAQoDGP3+J454wp++wlD3XL9S2NQf1YYVu8JpormcNtlu0dyd849tDeA8YNG?=
 =?us-ascii?Q?+BV6qlkbd0+mJodtw1/+vko5ryztnQRHfUYi6cWYkWWUziGDGbyKrNNwiq/i?=
 =?us-ascii?Q?KhaKx8KOruYQLniTG7+9CyQbDWuN6TMFpGbaGttyUOgFcEh5B8l1pBBPYc/1?=
 =?us-ascii?Q?DeyNLVGJnGFuGLEuAgxcNTqkDFTfVOaqdHEBMx0DQdIlhqEhDYh+INscVmDh?=
 =?us-ascii?Q?namceCErXKTA1Ux9vpmJrkPIfDVNF2HhBLQVxLperF1bAT1BKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mx2rCmuCnIiL8PXj6/kwNeoVethy7eYe7dyWYMUIA+tni/t/t2u7/BVvHo+r?=
 =?us-ascii?Q?ghTM6ZydV5HvJ4QyuJYMWzpdH5rmQrc6nkPoiu4HAgz6muy7bugDMkraj8H8?=
 =?us-ascii?Q?3RvAs33I/9SO/u0DO1j7BDr/TT0TqENkgI2KSobRjULbHtF6Ud0LluMRO18Y?=
 =?us-ascii?Q?ycFTXITnBhOWuoi0W6EwbNqaeZT6u64eMBOzKTCN9CPxuyJAtso5i1NMRdNm?=
 =?us-ascii?Q?dWrx6dVKAREkQPH9jOvtYM9jT+l6CU7Fj/eo3gcM8BJMzFEd3C7uFnbi5qET?=
 =?us-ascii?Q?8t4NFyT5J+KFWm0CK0SAK8dZHxXUYpqolHc2HqQvveshXx/8NC20vKBMHPuo?=
 =?us-ascii?Q?gw3JxN8WXc+brDixjzsxW7d57F+VDgjsSPiza6dG4O9+mF+ojslu2BcOeSGS?=
 =?us-ascii?Q?JCSN5fG8VrB+l47uJ+vYB9ujFJIcIrYusghn0wuGK79keZy2/ESjxMfVSgDv?=
 =?us-ascii?Q?5yA0ssfAGtS1SNXo3CC207BUARRVMoZXc94saGGZIPCc6F9ukvur9LO6iCVV?=
 =?us-ascii?Q?IdyA22+DF0wYICRa4cmnL9PIKCKS4slyJTsyhboQ/F/g8nFG2eofJ7xxCF/S?=
 =?us-ascii?Q?MkYd+g3aGNx/4KGqlhmfWWpK0BWQJYWrhClWTX6oU/P39EiLT5uNguCjVpEX?=
 =?us-ascii?Q?5+VioRlCUAKqM/6gGwjcrAeNSNnLqcLQKoT0hZ5Q9YBvXxCOxJmKa5wposYd?=
 =?us-ascii?Q?qi0TLkhWn+ZfpS13QBxyA8dV0seGL8vKWeQGY5wgWWFnoQXU6NUm9K5fYebc?=
 =?us-ascii?Q?tXvJQVLAK0O5Dp2n0eLuPNmeoALzaU0qp2togpbCfEp7FgSieYKVq4PEbopK?=
 =?us-ascii?Q?To1rImb2/shr6W7A81XOGatOErih8tEjyjgM6yuGi05NCNiGs3H59mEYXeQZ?=
 =?us-ascii?Q?kQohjjP/XOwfzhjN0ipseHmbjc0Gq29ivu6+5SDuVMDw/VfKaLslzLNExFsu?=
 =?us-ascii?Q?ytiiijlI6KWX5TtslR9T+pzubONKfgvhlE/XeHpMu/6dFikmVreOiM5AIZPf?=
 =?us-ascii?Q?t8rTnJY6CqYB5qfKIx0PP2qR1HHjRuVvSAonloKNhtsLmw9NJGcc4k1TEe4H?=
 =?us-ascii?Q?8UU3/EQcD91IRUK8YoUK89ND6M5OpBRin1gQdglA0DMp3vo7jeyIx9SllG64?=
 =?us-ascii?Q?6iRA8cbCFNlOCGf4aIN6gsWsPxy0kj0562+DxIKgBwCiREAcsM0YOtWq6jyD?=
 =?us-ascii?Q?0Jc82qDPui0O6M+Dx7b119lEtEfKs9Q1wzwR7K+WZUc8+k5NoeR/YR42inRt?=
 =?us-ascii?Q?0/T8OLyEoLwiNL2hPQ7tMup4ZSKP2uKDy52S/Dwq8/pR2pHXxexOSDywIn6H?=
 =?us-ascii?Q?Ro7iCUMIUHYN5FVOwVetJqGDCYkYDcmSXP3ZLVHHdFPeyEXWRwdGlf2OMrR6?=
 =?us-ascii?Q?1D+z15ixGPvBWvWzrFfcjDHSGZRg1Ve29IYJcy9B3ZR4sdq4ZmWnZVt+vkm1?=
 =?us-ascii?Q?mODMl6zS2ft0H3MB5BEdyWN7AOhPvVwtiFjViDHEXGHhEB6ne9ojLrwimo3Q?=
 =?us-ascii?Q?GXi4FkSEtsM3GQE4ItFJ/sjSqBzqO8Ma5B4W+j/nhGGid8DTNauIo1oY+jri?=
 =?us-ascii?Q?dpd/jriKvqJy+b1/1RTp0zvwW6LEo6iHTC7m4ntn8HqLYOQOayG2W8sFxNrP?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5040a09f-7207-464d-ab73-08dd0ec293ce
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 09:05:02.4616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hz97XUWr4uyV8xWdGYCdhHizUSZbVQej35NWIEu2aQr09MgCOE+JDLF134kG7Le4ag+TUG0ZASWKDs58trAxEWx4UUw5Uew5RH6XabZVhjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6770
X-Authority-Analysis: v=2.4 cv=atbgCjZV c=1 sm=1 tr=0 ts=6746e0c3 cx=c_pps a=2/f09Pi2ycfuKzF0xiDRrg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=yPCof4ZbAAAA:8 a=t7CeM3EgAAAA:8 a=z1QgHnsnO9wyuj6i02EA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: bAcutwBdvks9V2g7OYUfBA5quPyA3Gty
X-Proofpoint-ORIG-GUID: bAcutwBdvks9V2g7OYUfBA5quPyA3Gty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_04,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411270074

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit 2be1d4f11944cd6283cb97268b3e17c4424945ca ]

When the HBA is undergoing a reset or is handling an errata event, NULL ptr
dereference crashes may occur in routines such as
lpfc_sli_flush_io_rings(), lpfc_dev_loss_tmo_callbk(), or
lpfc_abort_handler().

Add NULL ptr checks before dereferencing hdwq pointers that may have been
freed due to operations colliding with a reset or errata event handler.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240726231512.92867-4-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: BP to fix CVE: CVE-2024-49891, no test_bit() conflict resolution]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c |  3 ++-
 drivers/scsi/lpfc/lpfc_scsi.c    | 13 +++++++++++--
 drivers/scsi/lpfc/lpfc_sli.c     | 11 +++++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index aaa98a006fdc..d3a5f10b8b83 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -177,7 +177,8 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 	/* Don't schedule a worker thread event if the vport is going down.
 	 * The teardown process cleans up the node via lpfc_drop_node.
 	 */
-	if (vport->load_flag & FC_UNLOADING) {
+	if ((vport->load_flag & FC_UNLOADING) ||
+	    !(phba->hba_flag & HBA_SETUP)) {
 		((struct lpfc_rport_data *)rport->dd_data)->pnode = NULL;
 		ndlp->rport = NULL;
 
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 2a81a42de5c1..ed32aa01c711 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5554,11 +5554,20 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
 
 	iocb = &lpfc_cmd->cur_iocbq;
 	if (phba->sli_rev == LPFC_SLI_REV4) {
-		pring_s4 = phba->sli4_hba.hdwq[iocb->hba_wqidx].io_wq->pring;
-		if (!pring_s4) {
+		/* if the io_wq & pring are gone, the port was reset. */
+		if (!phba->sli4_hba.hdwq[iocb->hba_wqidx].io_wq ||
+		    !phba->sli4_hba.hdwq[iocb->hba_wqidx].io_wq->pring) {
+			lpfc_printf_vlog(vport, KERN_WARNING, LOG_FCP,
+					 "2877 SCSI Layer I/O Abort Request "
+					 "IO CMPL Status x%x ID %d LUN %llu "
+					 "HBA_SETUP %d\n", FAILED,
+					 cmnd->device->id,
+					 (u64)cmnd->device->lun,
+					 (HBA_SETUP & phba->hba_flag));
 			ret = FAILED;
 			goto out_unlock_hba;
 		}
+		pring_s4 = phba->sli4_hba.hdwq[iocb->hba_wqidx].io_wq->pring;
 		spin_lock(&pring_s4->ring_lock);
 	}
 	/* the command is in process of being cancelled */
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 587e3c2f7c48..1e04b6fc127a 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -4668,6 +4668,17 @@ lpfc_sli_flush_io_rings(struct lpfc_hba *phba)
 	/* Look on all the FCP Rings for the iotag */
 	if (phba->sli_rev >= LPFC_SLI_REV4) {
 		for (i = 0; i < phba->cfg_hdw_queue; i++) {
+			if (!phba->sli4_hba.hdwq ||
+			    !phba->sli4_hba.hdwq[i].io_wq) {
+				lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+						"7777 hdwq's deleted %lx "
+						"%lx %x %x\n",
+						(unsigned long)phba->pport->load_flag,
+						(unsigned long)phba->hba_flag,
+						phba->link_state,
+						phba->sli.sli_flag);
+				return;
+			}
 			pring = phba->sli4_hba.hdwq[i].io_wq->pring;
 
 			spin_lock_irq(&pring->ring_lock);
-- 
2.25.1


