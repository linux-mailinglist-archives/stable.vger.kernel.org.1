Return-Path: <stable+bounces-92893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD599C6A0D
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 08:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF14C2822BD
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE82317C9B7;
	Wed, 13 Nov 2024 07:31:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA017C7D4
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483103; cv=fail; b=UJEzUEHxd9P+y+E4lUgtwOe+54niPd8m3XmzADhc4KnDL/FN8qk7ZoojnAs/M30MQQsAHI/0w7i4VNbwRmXOel8Iwz997xMYgalCeSg6qh+x0SzF7l5yA0iFImu3pYse82VFXUIut66ZVhYEOVGOPnLrp/5qlcrWXSbv2pTqgdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483103; c=relaxed/simple;
	bh=S4PLHMFTwxe+RPjOUTrgTqxnLZtRqDjt8IIKFVmusAc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k2ho2y30Lxe0r8myn8dJuTrRDVjzTei+Jp8/5LYNHFP0syYCgMjK3F+z4Poq/klxuboSgpKUk5F/qUo98uRzz0j/KlBd4wNT2UM9sjfaSCRnkFBLwkyT4rPUKTgZ0Uo1sXnzvs+yUb7kqx2rpasx4StPYdTCR6Wb0loZu8tjBOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD6n1bp030252;
	Tue, 12 Nov 2024 23:31:37 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42uwpp9q4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 23:31:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOBhY3jDk+u3imSuxPTkLLh0ihrv5SnNuUhylup1JwZ6hXVMK6jFBGNv+n2bQIWYCXGO/XUI4dzFms5RbQ6foQhOdOna62P4Sr0Ce9QRWxZTTHd9Y+BlQJUm9bgFTPbdQW3gBiYzictzzi31/kusitnNG5exb2xdaobYZT3P8GBkZKWnnBLRynwd5UHd0/TgtcpsLtpSMhDIh8+OwiYxD+ntqLYd5xBiHQyjacxY/nSz8uGmYYntX0Oufqni1LTHdJKfCFr1kr/9WhC9gEED4JsdpZFNTGY8qXi4aa9i2cCLhuSPeqiU9X1qWQ1rUygcOfcxBN5PBwa2gm6HcUaEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VMPny6H8yDKRBA7cM46aU1EdUTfjyIU8rlemacvMXI=;
 b=lJPN6nHu1wu9HlhaBWnntm8l+lxgV9B3u3AQ+T25GQc+ud4xy6TkRIPctCyf6lz3FEN4mr+lUeGTS0oGVoT3RipSh4Y80nOmsvv9T9212JIUatZ4RDAvv/zNxxOFKSpTwlo175sg/nfN1oTC02hLH4LlkLDpxzr9CuvnZk4ScDLOEbttsxwvJwoSpIdcIUnhGt39+Bm99+c+ZzUPg7ZQtDTTatqVrW70rCrcp29ByASSetlrnpJwfDxGZj+6xegR9f+t58aEhZa9P9DtxsZMdh2rnaaW9RkplN0IFjZvWgGog5KRFlr8GMBA4Vg3sBU80OeNS8GFugWWjDIephLxCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Wed, 13 Nov
 2024 07:31:33 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 07:31:33 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: shenxiaxi26@gmail.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1] ext4: fix timer use-after-free on failed mount
Date: Wed, 13 Nov 2024 15:31:40 +0800
Message-ID: <20241113073140.1814792-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CO1PR11MB4929:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a12649d-26ad-4190-55b9-08dd03b53286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PQUnslczjFjp/bNpgFKXOUlT1XVEbrg4AqZssTFb22TYX24X+epK+iNHDyQa?=
 =?us-ascii?Q?1D32KPVSvLZvNJB58FjJaXcxK1i3NH3TUbkiVXkMTszgYfywMj7Ugv8KWAVm?=
 =?us-ascii?Q?uN2o/SDXFwXn/w6yllkJSXJhh3/8s9KIvSi2yuTTGhItlZftQg2P1Q5+/935?=
 =?us-ascii?Q?ct1gmBzyT0MtEZSp748Fw18infFzPrA43XX5hyiSKv771I5rRetp0EaBTGbi?=
 =?us-ascii?Q?xBV7eGIPZECXksnbW9mSGFs8wFhP9WQzI4uMkPO52IFulb8EELAlYJz6chkK?=
 =?us-ascii?Q?nBxHJrDX55kuZz1OZZR7tCq6LTu2YzZjWLXs2BWCW+QqKgPqTqio58t27zKw?=
 =?us-ascii?Q?BCQorZhbnIaS1hqkx7BsaW8msLCHko4H7Ci6TP7OcL/E2sHq4MaBItQwPm1U?=
 =?us-ascii?Q?/FoSUDC+BbAu+uNS9tWfQFdiWMfMEgx4PIx2CSuIswRID8FRFErpzqfQFm5r?=
 =?us-ascii?Q?kVlMDI/lrl4FR/yXfG0u4cGQMIhmMl8iD40xCgzEGIgk6avbpeAay+cjCY04?=
 =?us-ascii?Q?7JFNuxYJj6TRQJzfBI6uNVYMT/O2LtEiSxXQ/l9Z6CJKZwb1mIhib7aGubh1?=
 =?us-ascii?Q?qnAn67uGx1IEuc7NrO4iFxOu/V1iyzibtUBZTLmjI7ZrXBD3w1nrPdgYm3qn?=
 =?us-ascii?Q?V4tD9/QQIumMnVGOF+Jk3xRjnJ0izAr4rU0hjoW1W7DIBFuhRgVFsC5WB9eF?=
 =?us-ascii?Q?RFnRwwyO2p9Mq1QHtN7XLIz9qnahiGHJUT6NlFr08MV0OtYDJ7vmPpvrtsGu?=
 =?us-ascii?Q?4Wzydf7VVi8vbuE5KipvPVUl++08tX/M16yAqvrzc32ZwsO8GURIHMlVBXdl?=
 =?us-ascii?Q?MttSsR26nCZlaGM3JIiR88T2ovxeSZB7bWjv4Y397MO9WEQB9Q5HNg00vlqh?=
 =?us-ascii?Q?J+LCcCIQsbN+u4M53lcM8jrFXaaNo6XKDTd9HZJr/Un/97yjo5+7h3efOEY3?=
 =?us-ascii?Q?oMxyX2gUOjA60zDEvIUR7kgbNgyLcw//8wMZ7HctqdKZQzmmbsM5x2qGPZ3X?=
 =?us-ascii?Q?rxjPQ+thgU06oYIeKg3JxXmcNBpkj4k0RxWcC7HwlpKbDGTNVR/jWSInABN1?=
 =?us-ascii?Q?BkrzM9gEEgh0YmaJ6KJiRY2f4WHDFcWWu+a2HBnjXqw7w5DeV/8ys/QpdE0R?=
 =?us-ascii?Q?6/cTGbWk7uXtwk0SZpq85y6kam02JbUTizeC7i3E8r5p3rFXdQC8LZZYkHFj?=
 =?us-ascii?Q?kFFBTx9LaxR2o6STa2rbxyjmbIBtOkRRoRVKnY5o5obr7a3ZyKNfZr45+j10?=
 =?us-ascii?Q?2mGLuO9MWokS8McTEgM+YTh+SJplkGMA+Jkwqx1iD44vxr6rGJ6+wfvDl1Eg?=
 =?us-ascii?Q?aFTl0cgDz7BSxeAdHxk6cs9g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+kHLVNUSqTUUpC+97jl2QvuKbrhiBtnc4uiSWG/zkclBtTeteHqKdNDtDsRP?=
 =?us-ascii?Q?7or/tR9Z8QZLvbv0ZTGp3SLHNM33CePMN1mSFNEyJf5SiBEYzOp1J8+PWvqs?=
 =?us-ascii?Q?Wef1EHSe53N7H6uCzIeKwMsu1g5ay7C2U75KhUC9EyCrICAnSziE7hiTAqdJ?=
 =?us-ascii?Q?yRd8NkFB0f3WX0Mb4zTq4E79NLNyNM/KIlo0PmpDI1PujOQgK76aXPeSF7xB?=
 =?us-ascii?Q?l46MswdFfuojhAW5nZTEB+111YMHk7fSlwoeoztLrN0CCg9mBh+O++vgLIeL?=
 =?us-ascii?Q?cfKTSlVyjvgBECnzoj7bSYaGduY9ypexsalGe4jc1mW3q3dfKCnu0eOv57Qu?=
 =?us-ascii?Q?GzQ693rzJZR8QOnehogt1/dau47Clnp0Q94JMAVek7TeJRJ5HE0WHpDMROkP?=
 =?us-ascii?Q?4mTiKRF8PLCPG1Qpz+27L6KbB4J1QPQrmy9QrOCZnSNf+XAK5ziBfeDeNu9Y?=
 =?us-ascii?Q?RtIAMQ/rfE8PldtIE6jlBUfKRLtJTi/ur2gaSTriomM1KCRayTyP+WqK4YWo?=
 =?us-ascii?Q?ykv9lf5eMxH6HYpUJai0WYUGsxeMxEAa2refqFrE0NAXgAA/ZCjyg6EKvUCN?=
 =?us-ascii?Q?gW7x4Jsp08Lg689X+oxRe+g0DeMxngAqpbuHjeMxHwfuB7bn0XiIAuBj52Az?=
 =?us-ascii?Q?LHa6NX/MdnP5f50lmzge5Fk7KfDRnLwddK/abkQ91ftmkdqwxXHTxp5mWSOJ?=
 =?us-ascii?Q?cGVRJrfOhNS5K/VgkadHSrvyg4cYjadhO9AQf7Dff7RCtbwaLt7wxi8laegv?=
 =?us-ascii?Q?n//fzcpVkBTqu4qZdQZbe4UZ+iQJRMsT+iYolql3PWRvygth1PN35gd0rHH1?=
 =?us-ascii?Q?WH2EQjnfz4uJrcxwPLd9AxtJnKFd8mQp/jItR9LDqoVBT3UW2rWFqAfoQN0v?=
 =?us-ascii?Q?9XB6m83OZSeJHq7O8bZ7I7W6Cff8Jh5a2bScZeciLOM7K8bwBtceWyA6LeKQ?=
 =?us-ascii?Q?5LuEOsRQ1X/cYGGeP4LDa1UI5j7IXTj14szbj8mJ2/bCm0/JocJuxvxXnTWP?=
 =?us-ascii?Q?us6vZM7enAApkL5oG1B031qMXUTPgCttialyfG6IpZ/Hihzf9YyFnhgtyaBi?=
 =?us-ascii?Q?acg0sRSBTpTtGTm6GKlMJHkS/cIsZYe83ZTW/n4hlqoelTnoimadgiwTzYNe?=
 =?us-ascii?Q?tSV+nzovvSOwOekKZyzL3jsmJUuSVBQSq2kVxTRD9811VUr1qZo+dnzSN9vk?=
 =?us-ascii?Q?xUxVYEe63K9FZ+nNbRr1Cn0xm9ZN7WXIfyOsZcfCX/C6NDENXaA/aAhI3zVQ?=
 =?us-ascii?Q?53218gqmm1tIgIgRPtBx2+2LviajmSvBGWBzO7AyMwtdxdKFEz8enOwt/3MN?=
 =?us-ascii?Q?Tpp1c72FWAMAlBYsvfziTOmIGJ4ZldwWRym9Tk6yUMIZE6cOPZYMFMjo86QK?=
 =?us-ascii?Q?wz4lyg+vfhsDiPHhsTznrU6Ieq8eptKYrfwcMKjCOpRU6OxxSN/5rz4S5B8c?=
 =?us-ascii?Q?LJsCLpBFELmXjmuWhVqQvTIERHOkamnajEYj6VrhXqt8Lt/cruo2Vl+bh4g7?=
 =?us-ascii?Q?VO+5IlovcV/snVyyPlACVqxtrAA9RZOjbBqz815U3brWFXgc+Xq9s8FDCxOd?=
 =?us-ascii?Q?o+bvbgWvesNXZJUvEcfYvBiqs7fvVoenWIQvH52iyMYAKOaWmycKSDh6IXRw?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a12649d-26ad-4190-55b9-08dd03b53286
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 07:31:32.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: volxyL1yVPr2qmf2wMHvbHKp68dbaQrOA25MJ3fdgxmvswz0B0n2YsD3HXEoqD/hJ3GrTorQLMttctWbADyOyGpi1UPS5cRfuwzi7GgkdFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4929
X-Proofpoint-ORIG-GUID: jBg1Kxv6hAJ6bjVVkZyuz0a5rqK62sLJ
X-Proofpoint-GUID: jBg1Kxv6hAJ6bjVVkZyuz0a5rqK62sLJ
X-Authority-Analysis: v=2.4 cv=J4f47xnS c=1 sm=1 tr=0 ts=673455d9 cx=c_pps a=XlWNgFwcAB8XWrBhwjv7Vg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=pGLkceISAAAA:8
 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=bC-a23v3AAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=LUACZsOYbq23hAV1XZkA:9 a=-FEs8UIgK8oA:10 a=cQPPKAXgyycSBL8etih5:22 a=DcSpbTIhAlouE1Uv7lRv:22 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=879 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411130065

From: Xiaxi Shen <shenxiaxi26@gmail.com>

commit 0ce160c5bdb67081a62293028dc85758a8efb22a upstream.

Syzbot has found an ODEBUG bug in ext4_fill_super

The del_timer_sync function cancels the s_err_report timer,
which reminds about filesystem errors daily. We should
guarantee the timer is no longer active before kfree(sbi).

When filesystem mounting fails, the flow goes to failed_mount3,
where an error occurs when ext4_stop_mmpd is called, causing
a read I/O failure. This triggers the ext4_handle_error function
that ultimately re-arms the timer,
leaving the s_err_report timer active before kfree(sbi) is called.

Fix the issue by canceling the s_err_report timer after calling ext4_stop_mmpd.

Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
Reported-and-tested-by: syzbot+59e0101c430934bc9a36@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=59e0101c430934bc9a36
Link: https://patch.msgid.link/20240715043336.98097-1-shenxiaxi26@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3bf214d4afef..987d49e18dbe 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5617,8 +5617,8 @@ failed_mount9: __maybe_unused
 failed_mount3:
 	/* flush s_error_work before sbi destroy */
 	flush_work(&sbi->s_error_work);
-	del_timer_sync(&sbi->s_err_report);
 	ext4_stop_mmpd(sbi);
+	del_timer_sync(&sbi->s_err_report);
 	ext4_group_desc_free(sbi);
 failed_mount:
 	if (sbi->s_chksum_driver)
-- 
2.43.0


