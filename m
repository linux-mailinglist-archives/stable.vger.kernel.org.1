Return-Path: <stable+bounces-93933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E069D2191
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA98280D6F
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A38B198E6D;
	Tue, 19 Nov 2024 08:27:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D319C553
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004858; cv=fail; b=YziQRP3JmvE/Ifkr8072Tcdb6kxYuOLh9BnyoXc4boNVouXZ05H1mpjk2hyxQ/kQ3orT5TUyBfMgJ8arOTnQW3ikQGXwK2E0Gc4BLpJCpeCGMaV6FP5wyDMDxLRPtojbYA5HyGUhsUkvcyUNTAtxZS17wIi8MTKKSR/FopLUUs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004858; c=relaxed/simple;
	bh=vm7aHi7BiEByX/cthb+y9xIZsrEZgGoaIjz58LwM9zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M9XWAjFjJC/4fCUU98XyAtV7hTysqj+Zt+CiQ/h60IwaWz59+of0ci+eA382SATqxY44cJCFXGwJgb/S8Kqk94FdW4UuSr/YPYxxZKCYWaltU4Xf9vnS23lRBXEaWiMAlw6Or/XlUTJFAD8FVySga/SS6d985RZRTOBq1cACE9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7fELZ015305;
	Tue, 19 Nov 2024 00:27:27 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xqj7tn2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:27:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mU3IAbuPKgGo3++W2S+A94qoExD2K7rYNWNk20rItPxrOBgaWxYGmSqnsa8J1lMZw7JiV2xE6gKCr9RoiqaCLAimwQS0/tbCVE8bwSLN0mtXQOd8zr2RRKm67mSRoA48B0nVpD2g7doZmgr/nGNXWiZgAd+9nI9qxXj6bACs5MgteKvXZu3kBc+YpxSKHFa6gNIRmNdz+08+h+tBiX0Lw7zKRHnH5uJa/8a1bdhMXpmmJYAPpe5nXqf9QCZ3n8BSTKb7temPRWMQ/7xMWVolpWzGI4JG1Q7tJrKqtqHGFlrdFD+pvHS4iFCCbLdRc2MLJtRtZ+/ua/xwA/B/ZiGWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjJgkwPOm5OYCZjtKPYjy04rCR2tBWza14F1Q6wza9Q=;
 b=Q/I6asi30qZpkEU9lQsTXN63sO6v9h7o3e3K9YI0+azvtrhITMNqVSEYDToeTNKVvZlgoDjzd0D3XFV28jjYa74ha6At5IicdE2ch2PEnYC3KyW/mAHtug+cTmJKed8cx1LbK8Gj0DyFsKCBAIiux5Bq+ziCpjYx0EWuZWs/331Gt0ls/5j4Q8XLcaEsJIATU0LEjcbmV6/44+6ViWeHoQohWw1pGTZfebxdRDPvo3qH51SeMi+mOvjLbTZlk1c1mC9bPuLy7St6SOgjUH0u1xyfLEH0h2XHNF7m9HMezvJfZuZysoCcYSwC1SPOsj5tTPmt3Xy1eSKswz9kWzIJCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:27:24 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:27:24 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: christophe.jaillet@wanadoo.fr, yukuai3@huawei.com
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y 2/2] null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'
Date: Tue, 19 Nov 2024 16:27:19 +0800
Message-ID: <20241119082719.4034054-3-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119082719.4034054-1-xiangyu.chen@eng.windriver.com>
References: <20241119082719.4034054-1-xiangyu.chen@eng.windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|MN0PR11MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e236f7e-3787-47d3-6eb3-08dd0873fe7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TM0y67XG6ANHh0z4oIl3mvxvQjiBmu/eh3HJqFL77lZulFiqFq5YIjwLBp0e?=
 =?us-ascii?Q?xzqfsmOtBPkOUBV6UhtYRL1yov+HqD+uChRBG37mpRcZjHn3LTgSF2qWvogL?=
 =?us-ascii?Q?fkc66hGUWb1Q3NjMWLc9lOPg/2/TVm0Lfzs5DGVyZGCOGvqKr/H5qUhNM5E0?=
 =?us-ascii?Q?NI7hnKLJab/9GRB3l71TYyqZOJB7qGUQHOPOYoNKJ7JG/GAILZtQZsmCqvvj?=
 =?us-ascii?Q?d3EsnergAF35OmWrN34GeGbugYnmsT20T4Wl3Esqul+xD3cGHXJAZqibOG95?=
 =?us-ascii?Q?va3tqtWtrwJlC4kXS0n/rfdStmVWFoaF5ugr4EcpcQMvfE4fcNfWNxDqR8Qi?=
 =?us-ascii?Q?XyzEctNHOJXM7/vOvN1OyMK1KfsO0MLXb2q3aNzdh/tYT9OquUWDkwTeXsEk?=
 =?us-ascii?Q?INwVImkwHja4ZgTSbOD84g4jLGMe1mVAwRp16HTLmNZ5KCEoh7ZsllDcQnZI?=
 =?us-ascii?Q?3LxVtQqGJxHGvUaUdvKGdWydtSKbVEvHN144nXTG6zWNvhKT+gkmkg8C0rFH?=
 =?us-ascii?Q?6j3rcOR0PvUbST9EhkESLXV+4h6WrXzQ7UWhUsKKrV+wREYkxUZSBoqUdcX6?=
 =?us-ascii?Q?YM2E0NkNsHWuqBLTUv/QUZ6GkcZd+cEYjo9cJVVZqveuUoNMVkI45jsLI3KU?=
 =?us-ascii?Q?zQQi0krGvCpO/nX474Jh4DFH+cIsEytq1w7qLVlnDZT3Q8gVnrXAucNA94sx?=
 =?us-ascii?Q?Iplz4/eYUp59M/uupl9t0s4JvF84LsuPzZ3jQXxovAbQuK9samBy/f4LqyLo?=
 =?us-ascii?Q?+z88Zcq/vE+s+YqL4S/zk4XS7E/wE1coLebCD3W6oWUJ8hmxR2L5iwwuDSB4?=
 =?us-ascii?Q?fRxX21dzcbyINZ8O+epO8nJXOwABxRFTHYY7wEbcDpDTsu0ANJK+XE3BXBYU?=
 =?us-ascii?Q?F/p5/WYpYilwNd4gMMQKLA9hrCMajujgtE324nK/IRvNGi9oEHYlSZXVzoFh?=
 =?us-ascii?Q?4AFuevuVA52KNhcFfLp5Y2vl72BRxzjvWIMCD0ZXnPIU8VHSn8E5eEvCN8zJ?=
 =?us-ascii?Q?D6/Ygia5EW6xOTsLFb2Qkc/OD7TEWOpFw6ZcRdFw0g6tUg1Xws/Elrad+gbB?=
 =?us-ascii?Q?23VXiZgNLMWG2qFfsH7IX9mhpJJNYyEG7lm8ZGYLHhQZGXHxKYCAQpi8LYPz?=
 =?us-ascii?Q?T+hqArr6vNYfivhJRGILE+pMIxGtQ6s+DZPeZqtiUDHcznJYU3beXVhVveU5?=
 =?us-ascii?Q?IsnU96LJ4pdh+cQ7eeF/Cxiz2se7epjNHjfE814is6fPXLukLfepMaxrgqm3?=
 =?us-ascii?Q?saOKdlCzzm6TPkBdVXiHr1dItqKJCg2Vs95LWjnqLordyYo41L0RxAtCy9GQ?=
 =?us-ascii?Q?EKwhOAi5dBebu+kQehIZwfGtx05/Qd4ZwmFkPVz0vtYsc3cT89QvPzWZiiUi?=
 =?us-ascii?Q?u1tz5CWpiVbl/cXjtbY1Rmn62eJA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s5+ge4L5tS50ejIVWBcG5hAbYAhI0dc2CXrD5w8r9/fEUiEuCCrpTh7JOPSr?=
 =?us-ascii?Q?W92DDIzj5NNMXC/DRVEcwzSK8hhieogUc/PcA/b/S9cFVMg4af56RoIS9srf?=
 =?us-ascii?Q?VATXf1MaG7kee1d3g8RBr+10eq0vGJxZc6Sn0tTZAlbWW4jM2FCKOnLtCmY9?=
 =?us-ascii?Q?vsepdi2SMYerwlSH4xYLa4bEuNFg9m8pjioGuHoqZYnLbTf3ORMQt7gcUhk9?=
 =?us-ascii?Q?HkcVpM+cd5C2gPPWBPGS6FJONeApfpQYlZ7nwmA1Nt4GUGs2CWCykIne9kQE?=
 =?us-ascii?Q?M3AqDgItaiiBay2qvX1I5bzvJM2OVJoLD7M/xJ2KPxWwCMnbOViW1I1mBkhd?=
 =?us-ascii?Q?thuMSRhDQQyUEvgwkOGdAJbMQp/YS5Zp7LGSN3Hn+x/rFGp7IXa0twxsLgAD?=
 =?us-ascii?Q?at6kJSsBo+t1vY5JB2gkYF2G1BMxJpkQfKLPfGznSFJY5hlHzGCJa6V0w4zy?=
 =?us-ascii?Q?+Trz3w4IQ39O/rv/2iE4ir4zwm9VJGtkld1jliq1/p6l6UUmzQTF5USCGtju?=
 =?us-ascii?Q?k/77jq7KwZG7vVB+ccYf/Uf2gDxoXCOlJsNiVKg7rhrjlvHI6BOcJgIwwfn/?=
 =?us-ascii?Q?7SQqJI9TJFfr8kxOriqSRMJLGvEsiz7ViJNkrtuZQOe3RFAOBrvzDcdxyTNq?=
 =?us-ascii?Q?5jqTIvNPfwaHNArFYX+3YeDViYUbsv5mkymF3AJAZxvvssObaQNiF4TUlrm1?=
 =?us-ascii?Q?4g3GhLhNqgjQAho+wjlYgbAwEEQj5pd6of4vF+oKA2sB2Y15O0B40jq5o8ly?=
 =?us-ascii?Q?OPxYeFjAa6IMplvzlcyKRcY1Ie3y1VXuFc4kRaY9jjYQg1anO74JXcv3DtR/?=
 =?us-ascii?Q?QjSJKAhNWV+QbcuGyfGHHz2BIQbCPmenzP0Az3gsuV9wj+B25bchjlF9X3KM?=
 =?us-ascii?Q?ohNTQDx+qUxAkd4/p2DRW46cgpGKN9CK8V5QPwIy1ahvNb4HnxUYjTXvowHH?=
 =?us-ascii?Q?ZgvAvxX8copoOCmKq7AgT8otnp30l6gmFQn/+p8VXuOo1YQrGANnhLCzFLmS?=
 =?us-ascii?Q?qqoucxVjru89i2683XTOMv/Ckbw9Bm7YSUma9vOwz3kwSoi0SPLKCjz7PdfN?=
 =?us-ascii?Q?AMI7JQC7P9QMmrF+bNwUrf6KrJRImnRmqCGwrwzPG8Osj5A/C3e7SrIcn1iM?=
 =?us-ascii?Q?1m6pWssA6ZRAueaXLCtqEy8clRzywAN4ZjsuEvNJTBysBpRGX+xs1FWuPsP+?=
 =?us-ascii?Q?4jh5uR31+6DBFaYqZacqyhfmZEpR689qo2SpXqAGhTFvw4NntXW4x2WzKbC9?=
 =?us-ascii?Q?1+X4BYL1UJwjed0qbu0x2JTsyHapPGUptW8IRgiyX8K9YdRWIi7t6gdJW659?=
 =?us-ascii?Q?UL6CnD6MUcHomGRlDJRV+W8Gcl1dtFgkYUVPgP9zuCLF6VGOVUP9sA32JxMD?=
 =?us-ascii?Q?uJKN72VOuhn0gqfUMiCmlAeIEHA6IHk1nVlq3KZJRrSafbisPyl7xoEA89Ra?=
 =?us-ascii?Q?GBxIbbiGtxnOHO/UZunMxf7lQ+1zLPn2ATQttdeDM51J2Q1YGvK0JVdCqDNP?=
 =?us-ascii?Q?/cJC51olLx1uiobxXRK6iWuvzrRRiS/epp6kzArF6vZMXx0Ufj7PN5w3nngp?=
 =?us-ascii?Q?n28KSDOuD189dyyMZQdWf51dvKapzOXt7NDvPy4014k/bUr/CDBYOdtOb83X?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e236f7e-3787-47d3-6eb3-08dd0873fe7e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:27:24.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNr9hDeI/OSTUKQ6q6Oko/LN+3A8nafcdNP8HPK7CABxGV6VLULlYoo8WsAFjPHm8T90qSCSbiGXfsihUkPlOypkLcDvmljbmFyo7WrBOKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6207
X-Proofpoint-ORIG-GUID: IDJeHhIatx9oRKT81x-quZ-J5BoEmPZZ
X-Proofpoint-GUID: IDJeHhIatx9oRKT81x-quZ-J5BoEmPZZ
X-Authority-Analysis: v=2.4 cv=Sb6ldeRu c=1 sm=1 tr=0 ts=673c4bef cx=c_pps a=ZuQraZtzrhlqXEa35WAx3g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=hDw6coYFGg755DguiL8A:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411190059

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit a2db328b0839312c169eb42746ec46fc1ab53ed2 ]

Writing 'power' and 'submit_queues' concurrently will trigger kernel
panic:

Test script:

modprobe null_blk nr_devices=0
mkdir -p /sys/kernel/config/nullb/nullb0
while true; do echo 1 > submit_queues; echo 4 > submit_queues; done &
while true; do echo 1 > power; echo 0 > power; done

Test result:

BUG: kernel NULL pointer dereference, address: 0000000000000148
Oops: 0000 [#1] PREEMPT SMP
RIP: 0010:__lock_acquire+0x41d/0x28f0
Call Trace:
 <TASK>
 lock_acquire+0x121/0x450
 down_write+0x5f/0x1d0
 simple_recursive_removal+0x12f/0x5c0
 blk_mq_debugfs_unregister_hctxs+0x7c/0x100
 blk_mq_update_nr_hw_queues+0x4a3/0x720
 nullb_update_nr_hw_queues+0x71/0xf0 [null_blk]
 nullb_device_submit_queues_store+0x79/0xf0 [null_blk]
 configfs_write_iter+0x119/0x1e0
 vfs_write+0x326/0x730
 ksys_write+0x74/0x150

This is because del_gendisk() can concurrent with
blk_mq_update_nr_hw_queues():

nullb_device_power_store	nullb_apply_submit_queues
 null_del_dev
 del_gendisk
				 nullb_update_nr_hw_queues
				  if (!dev->nullb)
				  // still set while gendisk is deleted
				   return 0
				  blk_mq_update_nr_hw_queues
 dev->nullb = NULL

Fix this problem by resuing the global mutex to protect
nullb_device_power_store() and nullb_update_nr_hw_queues() from configfs.

Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs9LgsHLnjg8z06LQ3Pr5cax-+Ps+xT7AP7TPnEjStuwZA@mail.gmail.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Link: https://lore.kernel.org/r/20240523153934.1937851-1-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/block/null_blk/main.c | 40 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f58778b57375..e838eed4aacf 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -392,13 +392,25 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
 static int nullb_apply_submit_queues(struct nullb_device *dev,
 				     unsigned int submit_queues)
 {
-	return nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
+	int ret;
+
+	mutex_lock(&lock);
+	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
+	mutex_unlock(&lock);
+
+	return ret;
 }
 
 static int nullb_apply_poll_queues(struct nullb_device *dev,
 				   unsigned int poll_queues)
 {
-	return nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
+	int ret;
+
+	mutex_lock(&lock);
+	ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
+	mutex_unlock(&lock);
+
+	return ret;
 }
 
 NULLB_DEVICE_ATTR(size, ulong, NULL);
@@ -444,28 +456,31 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 	if (ret < 0)
 		return ret;
 
+	ret = count;
+	mutex_lock(&lock);
 	if (!dev->power && newp) {
 		if (test_and_set_bit(NULLB_DEV_FL_UP, &dev->flags))
-			return count;
+			goto out;
+
 		ret = null_add_dev(dev);
 		if (ret) {
 			clear_bit(NULLB_DEV_FL_UP, &dev->flags);
-			return ret;
+			goto out;
 		}
 
 		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 		dev->power = newp;
 	} else if (dev->power && !newp) {
 		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
-			mutex_lock(&lock);
 			dev->power = newp;
 			null_del_dev(dev->nullb);
-			mutex_unlock(&lock);
 		}
 		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 	}
 
-	return count;
+out:
+	mutex_unlock(&lock);
+	return ret;
 }
 
 CONFIGFS_ATTR(nullb_device_, power);
@@ -2102,15 +2117,12 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
 
-	mutex_lock(&lock);
 	rv = ida_alloc(&nullb_indexes, GFP_KERNEL);
-	if (rv < 0) {
-		mutex_unlock(&lock);
+	if (rv < 0)
 		goto out_cleanup_zone;
-	}
+
 	nullb->index = rv;
 	dev->index = rv;
-	mutex_unlock(&lock);
 
 	blk_queue_logical_block_size(nullb->q, dev->blocksize);
 	blk_queue_physical_block_size(nullb->q, dev->blocksize);
@@ -2134,9 +2146,7 @@ static int null_add_dev(struct nullb_device *dev)
 	if (rv)
 		goto out_ida_free;
 
-	mutex_lock(&lock);
 	list_add_tail(&nullb->list, &nullb_list);
-	mutex_unlock(&lock);
 
 	pr_info("disk %s created\n", nullb->disk_name);
 
@@ -2185,7 +2195,9 @@ static int null_create_dev(void)
 	if (!dev)
 		return -ENOMEM;
 
+	mutex_lock(&lock);
 	ret = null_add_dev(dev);
+	mutex_unlock(&lock);
 	if (ret) {
 		null_free_dev(dev);
 		return ret;
-- 
2.43.0


