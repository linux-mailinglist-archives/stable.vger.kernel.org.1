Return-Path: <stable+bounces-93932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D743A9D218E
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97533281CC0
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C1D158874;
	Tue, 19 Nov 2024 08:27:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6D4198A1A
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004853; cv=fail; b=BIq71AXIoD87BgWcssn0IsN1kKG3LLpCn912nTW3ODbTe1D1jqjJuWUZbkoV3gqcLQf49Y3WZjWJ6pUtRveefmBuGPd6XLEl2vbu6gFDkaUuEJA3FHQ9G5Up5f+WDiSBRrSwgkzjePsON9S1Intdr9cE/+cd0aIHB07W8s765nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004853; c=relaxed/simple;
	bh=fsj3lryRDYhBYNSmyLl9xOyRwVXZ/Xuh9RCsd2NjCss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=glKESKRm32F9Q0YZCvTWL3jCkFozKE9prAXdRLh8Nbt6n0P3Ww1AJAnuAjSrxQ+mxB9OSGwVwxeKX9XU9WayFrntXrJr2w6VQ8SNM/v7AuZbbHfkbXu6sYc6dnAwsH3pztsRMf0xXgA1PR59xi6pNw0qL7qeTRBbuP3fJPJvRiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ89xJW013332;
	Tue, 19 Nov 2024 08:27:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xgm0ju8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 08:27:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHVbpER4l8Y0ftYMGzIQzOmTPaz6BktwcFhUrgdgk08xlJgwo5RKHLK0oIJT+6uV6k1g5I+cYDFvpAoOdfQJ5ALmiVpVMy71yGUpxOqRXjVh2ufoM+/u200oojdoqkChKZBtoWBDBAza2oCq7XR5QKHeZ2yfFfZEvfVXcaf6Aav7VgkKHKhwXKGU4ZQ3xwntr5M4uLI1KF7GlcnzxWMOiWGvLVsI6GGgr66Q1F50+8srQO2mwmjKA5B65MtN0D3oL5rcSnPzyZDBFi2P+yMcRiNdL/ycXx4HprKblHDmOlNLi5sd0pVWwwFQqGbMKBlR1FAoGgrYvNEo7aJhu1DMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk4/x1jds7msLNLhccKAVXH0ao/3MBvFG0r/UQiaalg=;
 b=FclGFahpYJX5tGKFjoJONiA01iZZTwmcT6TfnS46gJ/JgExsBBIR12P4uMMDeQYS7bZJqzD6Jhs+bO4RoIptItfz76n45skweklDV16DlmffclcUd4wYcjZUbY5sLkdwO5FYmoMjFA4KlyLf5mPdM9zMsZBVquaSnsrJSJuTsmRsCmz5+sc+GsxveYZdqJ6EeONDMEj7bl+1svwddLRrWDqsT/2U5xDfpcTTL8lS99EgA+xYrxkgjP3mbbFPohS84ufsA7CcA1bj0A8yUX/mfhWnbMw1fRBGxWB1zrN1VBfmW/x2KBNYwnRqBwDwTjGHre8+iCa1O2nq5icAk0lfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:27:22 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:27:22 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: christophe.jaillet@wanadoo.fr, yukuai3@huawei.com
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y 1/2] null_blk: Remove usage of the deprecated ida_simple_xx() API
Date: Tue, 19 Nov 2024 16:27:18 +0800
Message-ID: <20241119082719.4034054-2-xiangyu.chen@eng.windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 45345813-beee-49c7-b9d6-08dd0873fd5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ohiaUYuzU/xRnpWxJ2on0l/qSlEwiRHGmOAxx92tAzinX7UIT/r0hlwtDJr2?=
 =?us-ascii?Q?W040I6Kj1CvilqkCRy0IYVhaGCUfIO68BhvcpQ0gNsw24wAPuXb3gO2lByFx?=
 =?us-ascii?Q?IhgKAQGqvYxWRrJ7PY3z9XRGc3KBSIN8eXxjAS19GfWltuy9NNmWISC6jjQ6?=
 =?us-ascii?Q?sCrqo9LGH2tbAm4yQBE0jE5XZkU5jHrEHz4XoUnZlMMG/JYHXguB6yrNyZnS?=
 =?us-ascii?Q?4vZ0/q2bpPtTnf8PZI3SAP+2VPvKcJxsL/ASMn3hwHy6GmOm5KziM1/RIcsd?=
 =?us-ascii?Q?iSX8p4W1rqdiyl4llWCq6ZvFsAkIp9QL2ZKgSkHyU2xgks08g7biqhE73r6G?=
 =?us-ascii?Q?auwU9wp0h5w+egIho3QgLeMfA8ozmrJgyt+nvbi/2WZXQPtDAm7EztE6tuzH?=
 =?us-ascii?Q?Otzb69Lbxvjun9i9GC+db7dkVFT8DXllNCrnJx+yHLQ/hBehjisK/rLai5/V?=
 =?us-ascii?Q?P/NpytqGr5rRbmQn7swmNgGPTR0iYWAEA+Vp7NE2h8wI3EQF3OnNxIEVE3di?=
 =?us-ascii?Q?WCNHcOZHVWQbRjAwQB4vBZdElGxH7IfgCQHMJMTtP1W5qXdKLQHKiM1ws7O1?=
 =?us-ascii?Q?gTSQLF4okI4QYkVmNHg+60ymqSHg9j53Qu5bLXaax2mTl0M136rBfIyPxPzQ?=
 =?us-ascii?Q?NPvg86P8kGx4rrov6KYr6Qik3lpwKTWRwXvbJhoUjMkOVjgnWdQdwieH24yp?=
 =?us-ascii?Q?4QVvmbJV2ID5BetW72ByQIVd720zP8jJc7Xm9BRkWpcJaxQOHXBIMbJvY2su?=
 =?us-ascii?Q?c+p3YU7VAbrVcbJIYS5WX1N1HwrWCENQ1JzSGJKGxaDzLkKID9LgFN+7lOa8?=
 =?us-ascii?Q?TpBVoBih+L867E5i4XTThDus+GXYDVMEdFdFgM0H+eMs9xzxUYVTmy0b8T4a?=
 =?us-ascii?Q?+7AwwS53pR2dTDVrot5T9vdTXyaf0LkVyJqbvH6X6hJi3gKE8wM7QFj0W/f6?=
 =?us-ascii?Q?Ik2UEWJmvlYHkWPnQj8omfU/PXnyG0NV75N1oCSinOpv5JIegQlUwibxB7sA?=
 =?us-ascii?Q?jZwJmKCBnRYhEx8ZYaNEOHY7qQp4uu43UVHc78JC/L7tmyi/Qlnc92tIdDtL?=
 =?us-ascii?Q?65MoAtBszoJSX1AngQRpqTvtNs8U8TxAKp8F9iNCPzb2EgSCXavLte/s+QRr?=
 =?us-ascii?Q?g6F/cvUV4EJwOzSXT2uiv/MMAR1fhDLrqjzOzjmozmlCOWsTp3Mspg8yqVRB?=
 =?us-ascii?Q?BXB8IK0fCa4YrEYrlKGD5C2hQc09xq02WxXGFsX8o7qtZgMBQaWykYocmgpQ?=
 =?us-ascii?Q?LtWNUNy/3D69lsnWw/AliePthmEI+g2ZLHH9XBrOk+neMqH13j8OtVzLG8q3?=
 =?us-ascii?Q?/U21sArBWB5f7OcL1Ttv1HRIqoTABEAFzTUNbM3iwHe50TtAptF5xx9Uk/Ii?=
 =?us-ascii?Q?yy/HdcbGk+XovuSg+yQ4OCIZQ22Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6DKrnfOeUHgZKlfuaD5ybXHGn01IWecH8v3CicAAFER63gMPBs/KNqRkleEK?=
 =?us-ascii?Q?MKZe7sBW8eSNMyeuXu9ZEfLqoyjdXweq3NQhkBcvU4utBlSxH1dN2w8nS1uL?=
 =?us-ascii?Q?CyL0KPXWbMaNGz3q1MN0CtSyVqUcicfH6jF8qSkKT7Yk9fbgmiS4FD4ZwJEJ?=
 =?us-ascii?Q?GsOstpn1jW/MQJuXDcOY/LTPN+jWCyXssyQEsTucARutk9LfObYj6Azc2Zwr?=
 =?us-ascii?Q?9t4lqnSvlyFNfmC6W4XzVSv/l3I1D8LN14zSkaqgasUctrsm7S1KARDWR/tf?=
 =?us-ascii?Q?tCDk0tNKNdYYZeTcBc1s2DWBETdnpsHByLsBtoX3f4MZiC0uDQnHyHZh3OTV?=
 =?us-ascii?Q?ahif4BVemHqpDYI351wSMzC5MWgs6EMtX//aphnwKEGHzwAJGdmqnwq021+r?=
 =?us-ascii?Q?RqO2aj2G2bH7nT13xXRiRpX4n3gzYho7aGhRVgOl2XzM7R6xp+l1E2CWQ1yj?=
 =?us-ascii?Q?JoOHTfKnGUgzc0vu3UsB6PyobAuLzAsRQnnEHMYMAueOqJG2MbsUhYi49o0h?=
 =?us-ascii?Q?lxYJEx38APDum/mcPVYo+4D9roDr5P8KV3v72yUf4tqfkK8716WPtCZbaB7I?=
 =?us-ascii?Q?Q/jIC1yu9LJQT2a5BF3QRxm8GaIxFyYnIg2YC12oAPsOw2zjD8m1wi2V6s9K?=
 =?us-ascii?Q?luqQ64dzgDNTv/xs0XNoZKL/dbOGuBP6adgJsJWb1FOBCpf93o2OagUhPWYP?=
 =?us-ascii?Q?cDODaYYCVKLj0C1RIYlVirUzylC9gyVORAVRuROXyYZsxGY186BdxIbEqG4r?=
 =?us-ascii?Q?AL8dytf7DDTn+8xw1h/+m/+KuULjO1N56MMwyESKf+MXlmh5xjbo9febtWRB?=
 =?us-ascii?Q?gAywpJf0sgcc4yoSLJyEFlxfQ0cgTRgmj0nmVEWAaHMCQ5GOBBoFPipBDCNF?=
 =?us-ascii?Q?WMbiXcIyfFN62DTB9VALsPtMSXGQvZYBMxbNW908Eje0PpMYCeq3uXjxSCul?=
 =?us-ascii?Q?Xms4KkmQ/cO3RVdBfOpjXxnyQ4jkAH0Fd9h2Tyr26HYlmcReJM7CLteNjQgZ?=
 =?us-ascii?Q?IthCXuurIZMgVwGVwTVtvW3qhKhsuOpIofupbO1y/e+v+Oe7hWLIzRjrstrh?=
 =?us-ascii?Q?HzRw+sHofhhUWZBVEYdz0/qTsfgYpyGspDLyz9MZwWQivG144Fd2EGdpncuh?=
 =?us-ascii?Q?7GxUItxeQHOBgs6NsdyXabV58SOA1zswMU6maLV31d61gxRqbehA4yMO1SRl?=
 =?us-ascii?Q?Hl39VizerzkB2OMK2nKbCwQICFDHZf+mYbJ7zZwGil+nx/MObNy/eUdCieCG?=
 =?us-ascii?Q?udgssUJF2LYnDrcstIoT1INQkAC3QbARD6wIoCKr+OcM8dKizpEQZMc0UomA?=
 =?us-ascii?Q?qePiAD8GFm1LHsYDZwqYF0hlsp6Ae8A2rB+XKcKhF0pI7AdV2JMvDCc7d9Ig?=
 =?us-ascii?Q?8Kwgj6jmIzyXUtAXjUYUhj/ok98uGaXLZPWP2AZjNcLjfnNCZEs2wVUh9z54?=
 =?us-ascii?Q?pee9b7OBhCKsBxz8DM7ZRVt7T3qzvHOmy/Q0RvC4Zoh9i9u02yyOFsydDArD?=
 =?us-ascii?Q?m9v+Yj4SopUsBYwaj8bvmRtHjfl5Y4yJcEmjCQVi0yGv0IUME5CwTO0kw+0y?=
 =?us-ascii?Q?04zKcQlaP2sSMPGbbL4IiWpLJtJZNV9FohAgbkUzbcQvKQOG3CpNRsMHFBJd?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45345813-beee-49c7-b9d6-08dd0873fd5a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:27:22.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASQ1y5ynaifmby8cA+mC8qqarZVbJr7O9iyYcKWmy1S6OxoOcZLwVsj6SmLT0stYnpWMnv07SbufnWSSblKQexFjEp8WmpKwWTTMYKqgJm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6207
X-Proofpoint-ORIG-GUID: RBwnTuUXelauk88ROUoxTRAj_X-SPimf
X-Proofpoint-GUID: RBwnTuUXelauk88ROUoxTRAj_X-SPimf
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673c4bec cx=c_pps a=7lEIVCGJCL/qymYIH7Lzhw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=WX6PLalKbiYTgt8n8iMA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411190059

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 95931a245b44ee04f3359ec432e73614d44d8b38 ]

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/bf257b1078475a415cdc3344c6a750842946e367.1705222845.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 4d78b5583dc6..f58778b57375 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1764,7 +1764,7 @@ static void null_del_dev(struct nullb *nullb)
 
 	dev = nullb->dev;
 
-	ida_simple_remove(&nullb_indexes, nullb->index);
+	ida_free(&nullb_indexes, nullb->index);
 
 	list_del_init(&nullb->list);
 
@@ -2103,7 +2103,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
 
 	mutex_lock(&lock);
-	rv = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
+	rv = ida_alloc(&nullb_indexes, GFP_KERNEL);
 	if (rv < 0) {
 		mutex_unlock(&lock);
 		goto out_cleanup_zone;
-- 
2.43.0


