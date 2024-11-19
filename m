Return-Path: <stable+bounces-93896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1159D1EEF
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23432B21A60
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 03:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07091494C9;
	Tue, 19 Nov 2024 03:43:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E854C2CAB
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 03:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731987813; cv=fail; b=mtpgTCE2YArxaPq6UDpf+3QFedN+GbkyRWSmSD4JnS32Zs3JDkc7DHq9Rdm2RIykJdiItum/sgJBUljRCVHAejHEkZapgA12O3Pt5NKM8mPcgumrML7Hh7lDtI1Mn+cZ4vdavLacEcSNFf8DAl47AhQLv0GVhtIBTaNZd7HTvCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731987813; c=relaxed/simple;
	bh=DOe4R3z6a2GB/SCJEf8ao96DnkFRqSCJWeHuacCV0wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W5a+GajbGYreynjsl0u+hivbo4v+c4e6pj/O5yiIiNT8acF9tSU//MsMcM+5E/QjNMX9zTZt8JLLmd4rgAlPhai2dFPUC6iEkkt5KT1SzdsM/HsOhsYopqPjLDtgLCOWuZKUpKIJAicYYtNPggMsdWd0Fh/bFaeCljxu3Wj92uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ3dwqo011415;
	Tue, 19 Nov 2024 03:43:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xgm0jnb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 03:43:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LR1AqBHOAQGeIMbNUo+ffWf2V4qddWa7mXEe8zMLV99DLkJOvsTPq9RPsHEQeMgHqNMAHIR3RBkksfASp8uHGJGeoTgPX+f+7Blk+tjFnQiFs7icnb3H7ZiAViASXL8J8zpJzvVNRl2UceOGV2zEHMEziIHRkl+jCi1IP9Eyq7zR0hLcTdHtgX8ZTgRG4lFjqn8O+cEL5Epr3Aw5aqgEW5AgzOBmI9vMxDz1cp4hfaFhIZ6IhFWKx0ylCQp9bWsoGWdFGeFQuc6DdKvbwPgXUy/TEpRLwxeP39zs2b6QW92XOYSGRl8IQneVNTTNRn2c0xezwCmueFZxDc4ASimmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdMeIsXjWOJKfQU3NNz1UHWlryj48pgVMeqq8oXkGbI=;
 b=SoRB6Zzu521PdkBNM5AqXlAwxmhm1g8UyjSb/Pe44DD6f4qkNUfqa12nYvBevapvm3QliCidRKTXsrRj+VN+SdAsNQxZLa3F0aSaJ+AnzDRDqAkgHnxsNJTHStoP5oMTEfIoSXEagXXaDjutx8lPFvSY4qNACMn7JTn+BG7e7q4bSJj3k9DZx4Nisgp1kQPRbh4qDyLwhh9Q2yeNCFAny8Hd4hhQm8OafNvAzsTQDSNcs/Pr1l3IeTlo19Cyhw3vG2COI7+Ra+AhSz6jkfkg/ho3UCAXEgTBG5sH6bRk9O9oiOloDukvWbtcyy2cS8jfO51U4LpyGqzywF7iO0i/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Tue, 19 Nov 2024 03:43:18 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 03:43:18 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: ericvh@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y 2/2] fs/9p: fix uninitialized values during inode evict
Date: Tue, 19 Nov 2024 11:43:17 +0800
Message-ID: <20241119034317.3364577-3-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119034317.3364577-1-xiangyu.chen@eng.windriver.com>
References: <20241119034317.3364577-1-xiangyu.chen@eng.windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0127.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::12) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS0PR11MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c85b80c-af4f-42df-8dac-08dd084c4e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?od7dR/k3JTeYUpzvB8Zsxy2XxM7HeXSPMem750Pq3zrM/4CtVKF+7jyFbZJt?=
 =?us-ascii?Q?Pzf5IhrWrh3yAc37B1ImFgJM38c/MkKpbKPaE02NjQNPmvrkv4b7MQUL5nQ1?=
 =?us-ascii?Q?zymWtRLw0B5bcQBXWm4khm9lwGlNYS7TmYu3Dr/tByc6Z1knxvNrdwYcAzN0?=
 =?us-ascii?Q?0XugAKyujbiop2POS+eR+QStY490KTqc6wrLrdSqid8MKo6pi++tP3pmg2V+?=
 =?us-ascii?Q?yJ3D9vKeVp9yWsWN37/UQCytmdN1GckwsgIzixv5asCU1tHa5t7PWZLXWYPn?=
 =?us-ascii?Q?VK9alROgC+zGRcvQiYd8uwQEdVyMIOtdTnKtXH7r8D6po4Nbp1YjlTyL6cQm?=
 =?us-ascii?Q?SYJXdzXHt/ogNvcIHwL1VMCQnxwQD3hnNoEOz34zCRQA/3DNfB710R2Go6qv?=
 =?us-ascii?Q?uaPkC4JB4GGVJi2CAfWg058mBeJIRVLU36J6wQRHAsRS2k3HtVdZt0+yJyz0?=
 =?us-ascii?Q?aXLTDKnFGN2aKLfS88ke9lBvyPxAdDJn6S9H0lTyQd7nr8FRUDZH1hPgBxd0?=
 =?us-ascii?Q?nPK2JVCxuXE08jR3soAg0TGohCecj0nS2dqcW7iPdGEWcqat1hPU0sP+L8Ht?=
 =?us-ascii?Q?kVoxsf9C2cZ1jfbjS3x+eNV6gbhOhzJHwcU5W5wKzneqUV/aJzbYXxwvj37n?=
 =?us-ascii?Q?xkwk8wVGvG0DPvNfix6BPWKklD+KzpuZdm1PUL7Xtn9T39PxUCTE6jivzeMd?=
 =?us-ascii?Q?lWwkIxm6z/ntFTgbjxNUUqG4DamMqxbBeJuGpsoWB5Qij6OEm45urRQOYxJd?=
 =?us-ascii?Q?VcuCs39HNigj0aDfzp0zu5I5oknFlpgd6yHI2qa3RtsCWdyU8n9YrHUJtVra?=
 =?us-ascii?Q?H+591APn51yiVQIEJpRfrWQj6kXMSvE6xSomx4aFO7qF6m1r7VdEnDb/v2u3?=
 =?us-ascii?Q?vSeMbLbMjnn0V7qQeHxNcg1gZy8ZdPniqOGW1gPgbReVGQ9FuD27xTXWMGSz?=
 =?us-ascii?Q?z7fNynayQxwevRPlbu3COD5uHP7480Z5xtBscb7K8CcyLfCchjviNcN6dzH/?=
 =?us-ascii?Q?/vpP7d9jS8owcX/JuuKp9hEmUiyT/ZlXJqkbYLqHG+QNEPBDRxpaVpkyR1+d?=
 =?us-ascii?Q?pbCZDH7u/TftKkNAaqJUD9kkK7BspnTozFKt5RQyP/DV21BkV5P0glcBZLKb?=
 =?us-ascii?Q?r52Dy8OeGJWEHcZQQuH22MWJRzJZMF4xnGNQmz2+lKmuOi4Bmxi3j+3Y0N8+?=
 =?us-ascii?Q?X2AeJLh7R7VfP1U0fo2cUx13ywQg8jt6w0kB9D71He2FLc8i/O9SfKL7EXtH?=
 =?us-ascii?Q?IkN2znOsW1NPPamkPAIZDi/G7lfs6JcrOg15DvUFAwnNJBhwWclrjiw4mR6s?=
 =?us-ascii?Q?sE1iOK9ivm9axbUMmg/z/Bs0G+0FeuP2pKxHLsLbNw4BJ5Sdl8XP52hDRyGS?=
 =?us-ascii?Q?IARsu7o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jj/M62HpuriHjxejrf4iklfbaomotCKwMiiiW+HTo9cUDN44Bs7X5jEDKNzq?=
 =?us-ascii?Q?zK8VCXiS/lKtkdZP+gHEnXCbIewNZK8+JK8NcAQBwovwhad02B38E1Ht4qix?=
 =?us-ascii?Q?FdzIeNa01eF+PWW3tSS8734MvOWBHfJu88X52zUf7ElR2djD7/b29w1n93Q+?=
 =?us-ascii?Q?oaN0t6MHLnU97QlBM6ci2Z3SthT3jjoO2N4Lbcm7U+LBPLnaukyvjazpQAG1?=
 =?us-ascii?Q?zX7KQ2JbS9GXvSzaZm1h2roguMJL7oEPhvROYGaY7tfv7k1FOKkB+lxk58tB?=
 =?us-ascii?Q?8DHXSTSVysd5qMjqBfjUhlrtFA3Yr5TvjtfsGJS1aFOYdXApNdqTch94bQxD?=
 =?us-ascii?Q?ypQMpFjQJF8q3hM6rBaC4kqzxhS2o4rDEeYVaRlXbVy6K60qWCBpd/wZAo/k?=
 =?us-ascii?Q?xnk2X5DUpDLvau5Svx/7q4vF7B2kLnmtQLAMJ7ped7tZJAPmDqSrW/QG4Ddu?=
 =?us-ascii?Q?5i8LjJBth4wiYcqGXzLe/1CrfuK4mAITxiZvixQS3C6C6RTPZ0ChxMkhvaJD?=
 =?us-ascii?Q?rxrqNDl9Sd+vFWJ7VWzBuz1w4TzhAbHA4fLmVDFR32cYuPfTOcuXYYPN4SYs?=
 =?us-ascii?Q?atlrEI8naed1Am9YFfDzeyxgc5imfoQWwPNbLi0+YqgmHeLqkDAA8jREJIiT?=
 =?us-ascii?Q?4R7ZRRq0Nv4A0ZXzIrWMo47kWk+40v1Sq9R36ag2nU99T8POV414MMlRTTqH?=
 =?us-ascii?Q?7DOQhyBRDt6pJSSyX1yyqoqlw7NgAwo2d5b3nAaVicCtjl2GNz4PtCvEs922?=
 =?us-ascii?Q?gFVKp/eoMaCrZVjc3JuFv+hYKdR6BpclPZHz48jmPsjYGJ+zTyLGloqq+a+Y?=
 =?us-ascii?Q?n/AIBfzZzY+4q/DqUEJAdGbA6KiAl+GlnIYM8TdwgvPBRDf7KSqcPw2sBSWt?=
 =?us-ascii?Q?SNC0PGMZ1XI+01DnDSdrXxaVURgB/6PJNtxS1E7DXAr6PAqrrPs0fIWAmFNK?=
 =?us-ascii?Q?URTxiDQCxFzY2QG1PX7ST1KfRcG4hY7G8oG/BX0M7zt4Ci/NFC+/3HvzQDt2?=
 =?us-ascii?Q?n4SdSdsnk5y9nOhqE7iKpWnyXGIRabuQAsZwJ7TCKR3qpq7k4AtDYIk4/0M+?=
 =?us-ascii?Q?G1+a3Enj1VfKT8VwpF2pqKgkhAej0nszdK2c4QcDteXerH3AOUKKebBFwBHB?=
 =?us-ascii?Q?0lZHINUjAUCGRmBUGup/AcgQf4PmPEGWfNns+xag4f0T7b0h2cBZzycaGWbM?=
 =?us-ascii?Q?Ia/NdOqB5v9AA3UwICm8h9YVK8L6CFKzfu/qV0KiP54TGkIIPMIEIBPjLRq9?=
 =?us-ascii?Q?m6XutRtz45EYW0hGZLHDKO/Gdm9QGWNBwcJgQE6WAHTeVOFUOS8rgY28i88c?=
 =?us-ascii?Q?sdVYUtLhVyiJonx+rb296wr9yCckYCiQhPCUxjes0umvDK6cDehO4Nu9g+ht?=
 =?us-ascii?Q?DHro/CjJK36oXaZLK0VIPJFarDlgf+alBBvE0PMGvZpRMof23ZzGs28hTylS?=
 =?us-ascii?Q?1oPhpaXwEYkgMFbmz2m68NTDdpiKOpXDz8FLXOvL5Cc73a1eTm/ZEzLEf8wi?=
 =?us-ascii?Q?uRftTR7+rkfNNNw6oaOKvc0Ad6HjSRfR+i4zMyBVYSBcqaEyR2qFGwEiNHBj?=
 =?us-ascii?Q?f/1L9wUcI2TckSBCD2Jh+rDez8qmswvoEO6KRtmO896XJOZ7vOtKZfSuEaS5?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c85b80c-af4f-42df-8dac-08dd084c4e3f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 03:43:18.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8VFlKzQnDRQRVDhRj7qiY74mXGW/elzOzUApQL8FxQlaCcvXiuEXeks838UVAo7GnBtPF3vW1SC1pyuZEtAolESwLSFYdcDxdrWBTi4ORQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7786
X-Proofpoint-ORIG-GUID: jiFxgmdkX4Xpv-iLmg4-NbGPBDhXo8J_
X-Proofpoint-GUID: jiFxgmdkX4Xpv-iLmg4-NbGPBDhXo8J_
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673c0958 cx=c_pps a=6L7f6dt9FWfToKUQdDsCmg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=JbCBjjcmJYvfsEDl-egA:9 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411190029

From: Eric Van Hensbergen <ericvh@kernel.org>

[ Upstream commit 6630036b7c228f57c7893ee0403e92c2db2cd21d ]

If an iget fails due to not being able to retrieve information
from the server then the inode structure is only partially
initialized.  When the inode gets evicted, references to
uninitialized structures (like fscache cookies) were being
made.

This patch checks for a bad_inode before doing anything other
than clearing the inode from the cache.  Since the inode is
bad, it shouldn't have any state associated with it that needs
to be written back (and there really isn't a way to complete
those anyways).

Reported-by: syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: CVE-2024-36923 Minor conflict resolution ]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 fs/9p/vfs_inode.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 853c63b83681..aba0625de48a 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -374,20 +374,23 @@ void v9fs_evict_inode(struct inode *inode)
 	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);
 	__le32 __maybe_unused version;
 
-	truncate_inode_pages_final(&inode->i_data);
+	if (!is_bad_inode(inode)) {
+		truncate_inode_pages_final(&inode->i_data);
 
 #ifdef CONFIG_9P_FSCACHE
-	version = cpu_to_le32(v9inode->qid.version);
-	fscache_clear_inode_writeback(v9fs_inode_cookie(v9inode), inode,
+		version = cpu_to_le32(v9inode->qid.version);
+		fscache_clear_inode_writeback(v9fs_inode_cookie(v9inode), inode,
 				      &version);
 #endif
-
-	clear_inode(inode);
-	filemap_fdatawrite(&inode->i_data);
+		clear_inode(inode);
+		filemap_fdatawrite(&inode->i_data);
 
 #ifdef CONFIG_9P_FSCACHE
-	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+		if (v9fs_inode_cookie(v9inode))
+			fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
 #endif
+	} else
+		clear_inode(inode);
 }
 
 static int v9fs_test_inode(struct inode *inode, void *data)
-- 
2.43.0


