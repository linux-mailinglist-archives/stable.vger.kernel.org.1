Return-Path: <stable+bounces-93895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3209D1EEE
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C1EB21851
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 03:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8C81487C1;
	Tue, 19 Nov 2024 03:43:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860F02CAB
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731987809; cv=fail; b=u3xU8ai2dCCytjBPXGokEGb+u8clCY0AZlQPGiueo47Wx6SY44JyQmw0JH3zLH0xhGBcUF7lD2Y4OI0YWLPRZFXAMxWH7vnhzacmJ5lWRa29xeseEfZTZNZBsc/hx5niIUG56nUaRQS6UedfegRhcagEeUcyin09rw6+beFv7v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731987809; c=relaxed/simple;
	bh=Ha9tDfSIy6ZmnFcFNHzKWqTvbIX+A++cziq4fSwsfhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QspXn94msmD3LH5nSnplRs69dkTjcuConzkMkQdyU0OT69gdRWRodd9uDXBG2cMkDkwhonUEbIIu4p50j/j2HVGNLVoBY3jHzEj9nK6rH6znRT/DV1pDytRU+7NkPtFMJBMcNL0SJxQnDC4tPjoppnNWEaz1r+R/zZRyFleAP04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ2xLDu005029;
	Tue, 19 Nov 2024 03:43:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xjc8ajjs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 03:43:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHeAeb4/2Ov3bwo1upv9ikOmxsm2iuV4RahR9Yo/as0o+YE8L1oMeFk0Su6SBleJjBHRVvNZ9EVLqqPgj3lcuDsBnYNW9cZ53xWOiPNLGv8Dc1SQMsgPlSlZld9l6UQ7cchCx95oC5X1UqKOIrL/VlkR4bjA4mquA9JKSxG4ulNPr0Roi1yACKlD46LAarE7hmEdixBLSHum5O3a31KfqvTyuuplAqdqBcdmEhUbG1N9Le29EAxuhxg7SUYJqPGyA+NtD3l68g4QELNsG7+XczIJ3lpEjI3Xn8l+Q5dIGdx8E3TpPPm8j6LJ7iMW2RnS5DWZQ2iSKAlUaMLEOQIoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYn5t5nASbh3tBWMv23CLqtf2BaF9JvW1m7GdULOgJQ=;
 b=VFXxZaGoFYhDVICELZbZo6e8qeGHw2aSZ8JU5iimT/Teu6uD+pW2/b2zWllUHrjwRUueBxw/A7Xd9hh5ObPwHCVeKteBLJhq5nRl7mAftLEebaeLR5LuWIc8k55eetBc+s+y1tP8ErwGJpRoMVYfMrIzUNYCSVXz7B3gJPo2WcYgYpgUrUYt3bWwyZmB+CH51T/xv7Tj9fQlzcrG38gGiCEAYLGx8MrRsG1tqhutPhwz2qIdA4tnhlybBnN4MDiLOrkSIIoo7grTYCLQj7EzJbTScKq6L43MV20MFYcxmlgY8OVWu2mlg5sPxZ1kCcpREp/SG4gezc+RJLKp3vkOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Tue, 19 Nov 2024 03:43:17 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 03:43:17 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: ericvh@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1.y 1/2] fs/9p: fix uninitialized values during inode evict
Date: Tue, 19 Nov 2024 11:43:16 +0800
Message-ID: <20241119034317.3364577-2-xiangyu.chen@eng.windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0b8ebb06-b2f5-4407-1b46-08dd084c4d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QycNRoKGYyyl5HNzkCOGR01olcUfpNjcNhxcLLq6TrqctyIZ8El3BwpKNFxK?=
 =?us-ascii?Q?nMvKtSRkpGbmK/OCpiy1EK5154kWINqDN0HjjbBbqupn6+Mc/0N0sGEa62jJ?=
 =?us-ascii?Q?yRWg7Jtv+QbmkrJmzp2antsTb1pIoaU0Vev1ZaJqh91FPjiraVPIcFmtmi46?=
 =?us-ascii?Q?d0C9mfUpBHP66VfUTdoFwDZJ/YIm9Ow1P3X1VS0Xoh80IFcmNW8/CdAah4fb?=
 =?us-ascii?Q?FCs7V7hrAozu4N0957qNSzLTHvYov+vR8Bw4KREjDn1dAJkoiCnaoHUlLjEa?=
 =?us-ascii?Q?Yv28K98PgNXFwcqXo6KZFHMCT6KyYBtXLuOWVWJJi3fS7zjFKG+wAlXErU5p?=
 =?us-ascii?Q?sScxty9BN86cnDnHC7Yqmo9JIU0bW1Bldfx2PV0wqA4S43R6v3NgkMYpnp7f?=
 =?us-ascii?Q?n09J8ZbjedKTXhGbhPb4reKhn6JjBKpvnXqSxhc5e6oTbeEijoHsw24YtUG/?=
 =?us-ascii?Q?FrkVLcNKjWtPOD5uK8MGSeZRkeRig0U4NksMcQvoiM+o34q5iFkHIQ1vGPDV?=
 =?us-ascii?Q?tnl8Chl2fBOcoDJbTn3KqlyEeO0PbaMp9IPy1XvqrxlfzdnBPyGqjTaC4aC4?=
 =?us-ascii?Q?qW0Qo4JBytWoi6PUb8Y6OBj77GNYLHl5i2XjW+kgaG5v8CKRv56+vJ8dxZva?=
 =?us-ascii?Q?Xoxx/PM3hNnLVLrblcgj2wvD4pim1td/ScmtigeOyGm94IZvmrwKHxZGhYhC?=
 =?us-ascii?Q?nA9S1Un6xDFrXPHo1/JHgMQFYhVNO9MBMuJzQm9h1mdftnSj8e9oiGVyJTnS?=
 =?us-ascii?Q?IC14iLG/kc2iMyI+Qy7IXib5hOVcco07tdm1cmVsiTPZbkhom9g+e2wcb8ZQ?=
 =?us-ascii?Q?Z5wEZUUDHK1fPjblKss2am04yM+ZEfGVz/oR62Rul8RGOFURIKF6tMPnqj3Z?=
 =?us-ascii?Q?KEixMWCCY+OoAPi9zIHGT95R+agtPd1y2EUF108SWLOs185bfzVkP7Yn7bch?=
 =?us-ascii?Q?RpJ441a4ju6S8eS4i8lZkv+x7SRWStC+9ldmwRBZ7HUW/UChJq8HhJYa2iBi?=
 =?us-ascii?Q?XBf4gUEht9p72k/ypP/zv5mMJdl4YcZit4UC30dOrGk51Jnr8XKs1lv0jzKR?=
 =?us-ascii?Q?1F+OL3VDUMgcpQC0R6bJNNsoBIdc38me9Iv1jx8GRcIu/rmUSYiTcJP8wgOP?=
 =?us-ascii?Q?wydPZ9yByzQDEvZSIvUIPUc6GcnGYmkZKZHZY1RZnaDC+HrIM75Qp2aAx2G3?=
 =?us-ascii?Q?EiZFxmE8PHifTx/AAoRFFh7mR3Wk4rH7QXpuvdORy6AuFP9nwdTq6/x7EQbo?=
 =?us-ascii?Q?zSjMJIYCQWeMQq5EN9JPLT1rTPY6hjQmG5HaQGIvEztD6XbAe+ZKXoGBtRqU?=
 =?us-ascii?Q?sCv4rOoXdLwVtWynwqJozHttDC80SGAfupx2F0Bu9Dz2wF1wPYsv7UlXlr+8?=
 =?us-ascii?Q?7E++Eqo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RS6iU/mlvP4sJaL1U7HiWy24CcRAdJku8wtCMrgXZLLMZKvnWEngtVSeu3kQ?=
 =?us-ascii?Q?YfAKWKH8opGelBEBX+EQ1xxV5dtY2JIIeP7CVqBKotbLX924l+3kqJxFJpQ/?=
 =?us-ascii?Q?1LIbXrDxOLqzX3pzSJz+MLzq+WINdTp4tn719nJlmxd+pQT/HaOiW2nJV5dr?=
 =?us-ascii?Q?PImgXFIHHtZKcB0IRfrF8J2TXbfufGCmUIilJLS+En3Lwoz+SWaSWIg8am7d?=
 =?us-ascii?Q?9EvLXd+kVtUhnbFR+5JvtCIarYNj3LSMMaOxaU/kxjbgr8m+Qv8TAS35xFYY?=
 =?us-ascii?Q?fDvQjr/CEjsMaJpBijZzYy2aPiYL+1vpQ77WD7yu23r7dmllrGCCf8+ylXKj?=
 =?us-ascii?Q?ZjQSlI0KMroK89JKIFpfCKwTLdrnA4Dae5qQSvmrNFmQfK8gQAUoR6RLKNJ4?=
 =?us-ascii?Q?G0SyIF2l9iMnUp0kwUosqFhi9HYuzdvDwiZ9uMccf4sVtaxudGhOkv+tB9eZ?=
 =?us-ascii?Q?qRl9eaLp/5TbQB6lulxBh/z5cu8b7YYpFACbAT0PgVDddnABpiVFcJXlqs5N?=
 =?us-ascii?Q?td+Q6j+ZBFPx1aZCI35x2DbGtFLIeDb0jF1BH6J66sxIBNbyUqCB3ITmUR8o?=
 =?us-ascii?Q?S7g/JyEVzm3R86SznRsbpJwRjcTdiZZK2tHx6Z73C3fE+bcdU4rI44twUd3z?=
 =?us-ascii?Q?o+V8FLyQ6DkJsJpTwOXC9Qi5e0T6t/FyfJjIMNbZNENQ6yjGBkpdYKz/d2+i?=
 =?us-ascii?Q?aJBjjZhObGBu2/mfDb3+r4qFJR4BTA1RV2HMGMQfa+tYoqz7i/YlLNgQKbh0?=
 =?us-ascii?Q?qLPJ9K3t8AvIxBpVOnRxXT5e/k2uDqm3cXIu/uu4NbvZFQRZPeeUpohRyHBl?=
 =?us-ascii?Q?FzZZFrG+rkjRfBseFoCQsrWR+00arpNTJf/a9Dkp76TXddnTAyLu8sXQP6pu?=
 =?us-ascii?Q?pK1jn0dztMAJNxtKrL2w+fkh1hTkjHUCLeSq1nZ/fb6MfXf97sal4MoMtgLf?=
 =?us-ascii?Q?g25RnhN+YeKj180Vd0yy7YdpGSX1sGt9Tl7wr70nykeDx/Gr4jGJfcDAVzkm?=
 =?us-ascii?Q?cX7YqaXhtGLsiEif9i2Km01BW8mRIJUjDlIZufic3CQIS2kr84OfxpPvPTrm?=
 =?us-ascii?Q?ExPfdtqCXN+JANrjOW08bwNuMd1kdQhDafpRhHiwUGMakpV4nivt6T0tl47Y?=
 =?us-ascii?Q?5ahX1gxJUSOTG8iQR41lHXApd223wa0/wUWNXMC5/z/vkzGDnUlny0LeMi8d?=
 =?us-ascii?Q?mb1zFto6eUM7H/13WMUOFMX2TS8NsO+r0OL4lyNxl/LGJv0kUiAO5BAfB9oj?=
 =?us-ascii?Q?MIKxn7f8LQSWrzBEO1mIBp6yS7qVrXk3jC1PPwM1Z+/Zwsy61mk4BbdU/npM?=
 =?us-ascii?Q?Is7FuPCeF2lr5XBkYk/rn7gjS/IKNQBviubbjZSpWB/KqAMMFefPhd2Z+T3I?=
 =?us-ascii?Q?Pj83u1bM79QumtLW44Q4GlzKz6dk7QdC23IaIr0FcGAAwO4qcRXmOcnYFo6i?=
 =?us-ascii?Q?bvuaS6hTGhcxSvfxgwE6cps+eCWGgIDHZpSJ1PtjdVp9Yg9mYvaOuUuug4IA?=
 =?us-ascii?Q?5GKymXjndsAzBc/bg0OOxlXjyehWUEwzp1Jqh45msyM5uShBn8ZeFhi6OBHE?=
 =?us-ascii?Q?lMCKKkXZQI7RtsX1tn2Ewo3vpJvqji8hHcTNuKRAdAO1XNBiLbmXqGt9eFiq?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8ebb06-b2f5-4407-1b46-08dd084c4d8e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 03:43:17.0079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvwH4KDCbT/84ywIp8RTB53L2jG5nLf7zJbn95hSjATIXiUd+hwMsq5rcXJr6uQlJz+DYz3tWf8KidYXLxyTKG8dlrmlwKEr0IsH9fcWxdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7786
X-Proofpoint-GUID: KXaOKlF3ltYCx5UpFqsE5ggse2wk-oKB
X-Authority-Analysis: v=2.4 cv=R6hRGsRX c=1 sm=1 tr=0 ts=673c0956 cx=c_pps a=gIIqiywzzXYl0XjYY6oQCA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=JbCBjjcmJYvfsEDl-egA:9 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: KXaOKlF3ltYCx5UpFqsE5ggse2wk-oKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=991
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411190029

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
(cherry picked from commit 1b4cb6e91f19b81217ad98142ee53a1ab25893fd)
[Xiangyu: CVE-2024-36923 Minor conflict resolution due to missing 4eb31178 ]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 fs/9p/vfs_inode.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 8f287009545c..495631eba3a6 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -392,17 +392,20 @@ void v9fs_evict_inode(struct inode *inode)
 	struct v9fs_inode *v9inode = V9FS_I(inode);
 	__le32 version;
 
-	truncate_inode_pages_final(&inode->i_data);
-	version = cpu_to_le32(v9inode->qid.version);
-	fscache_clear_inode_writeback(v9fs_inode_cookie(v9inode), inode,
+	if (!is_bad_inode(inode)) {
+		truncate_inode_pages_final(&inode->i_data);
+		version = cpu_to_le32(v9inode->qid.version);
+		fscache_clear_inode_writeback(v9fs_inode_cookie(v9inode), inode,
 				      &version);
-	clear_inode(inode);
-	filemap_fdatawrite(&inode->i_data);
-
-	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
-	/* clunk the fid stashed in writeback_fid */
-	p9_fid_put(v9inode->writeback_fid);
-	v9inode->writeback_fid = NULL;
+		clear_inode(inode);
+		filemap_fdatawrite(&inode->i_data);
+		if (v9fs_inode_cookie(v9inode))
+			fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+		/* clunk the fid stashed in writeback_fid */
+		p9_fid_put(v9inode->writeback_fid);
+		v9inode->writeback_fid = NULL;
+	} else
+		clear_inode(inode);
 }
 
 static int v9fs_test_inode(struct inode *inode, void *data)
-- 
2.43.0


