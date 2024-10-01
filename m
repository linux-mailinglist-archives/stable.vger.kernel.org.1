Return-Path: <stable+bounces-78459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4B898BAE6
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF3E1F21E80
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7022E1BF7F5;
	Tue,  1 Oct 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DFEK0tuq"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0919D88B
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781716; cv=fail; b=udxfnOh+kzIAZpzvVGkjGDeFya4Zh7HVn4npO32K80gG1PyniOwlIZ9Z7LUN9bvAPknkqhLgutkW+ynnZ2aYs4xa5O6v13ku316i8mV7cWs+UyGgWsyKUqK7GDRU1JUSUPUzurX0Z9MihzLwwXFDsUbN6bMhGxWLNS5VB+82idg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781716; c=relaxed/simple;
	bh=wG6InxGyPF9HWy7we6QFvNG0ahkHo6LMibD/39tGLDc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TU9IXVqxdwH7AjK/rEkXLS8+vAIIFWc4Pj8IZIbHJTR9fvHyxzgivB40BBXrmaeAB1O9ID6UXL585qjdaCmxIJC1QI/1G2rC0KZwIqoaBDuOfMWQ6FboNoO7pRQPQq/LTBl7uLKc23lSk3hEw1fQU7CuVRrb1YxA4zqqha5JuwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DFEK0tuq; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMv3O8xFxUAA2iIhZ7HovDk4opB8I6akraHiDQCo+898Bjhm19A5hq6KEBKVkc05QpaZZUYlCPZI/SyXmU5MlD3EmR5nxxab/GiuoHLprMDzVJQGEu9tNdtibbcWi6xHGwIFkgCPhfRsljWOgnN4DAdMFuYU3PDRCKL9QvEb9w2VKy0N49t4m7q+qMdcVdf0HJFUkOO/hRi8HRlNEfGATokEH3Crt/QSnOKvQ9HXakdc8j4KlTjxDQ5YEu2CPkr3cngYlu2aMsgUKmH92ymMTSXXFAl5qpbTLr5w8sEW75ydjCJQcPb7v8z9tkeFUplfjQHFav0R12+JZcfZi9oknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGqyAgWNl9YXf/0IAjp/+lLAzRZfdTge0k+200jVBX0=;
 b=JMC7BusxizJW8SY4VS0CPCnGKUGdrMq+T0Z+eAHPCPqKjjTizz/FNSbGLkx1IffdSq/eMR4uxePAafuHy6pFb9lzoEJ4ThLj7dbPqWJ7BN+MawrT3Mbal4njjBjUSVkmG+vx2TK43zr4x6GuBN96TWUCTxdKMfeVUF+oQkGaeweksqIDqhwneS2DQBUMyXurC/fgzfa3Uss0USA3hZr0imi0YChq77dq88OT5A34jKPCu5Zc1K0T1NZDAKceMiIPcQi6zO5sm2YrLVk/8FVGw5k6xyxaW1anf3fi9YTYA8Cf/30GJItI9OYNgTS+kWLFSzry2z8aJO/mQaicSWo57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGqyAgWNl9YXf/0IAjp/+lLAzRZfdTge0k+200jVBX0=;
 b=DFEK0tuqRY+3KRk0BbiJ/fxCgZrgdNLdeY19wZaT9B3nQ5Rb6i/+lmWwfAGtwXCq/jXa3R/l7E4N2Dy9pGzK1utyyFIJmMIinTV49yQ7gBt8Fa3W3UVYQGebP9c55M3/DwIZm2zuWr/wKu7idP0GUsLNaxLRX5kk2dIB3Tjm+iIaPmINOLzdr7Ciqm6JaBTriuBQuRcVH1PUihXhfAVyYgDiy7oSniJQuCdJ5Y9Wq0EUc5ui/r35pPXnu9zQ6i3JBqIncPwIVEGIHjn+4r2V9JYIw5aWweJfw31/2JzfKmbw+B0+anAHeiG3sKKT+65/uoFQYG56G9jToWPEQzjimA==
Received: from SJ0PR13CA0078.namprd13.prod.outlook.com (2603:10b6:a03:2c4::23)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 11:21:49 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::9e) by SJ0PR13CA0078.outlook.office365.com
 (2603:10b6:a03:2c4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 11:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 11:21:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 04:21:37 -0700
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 04:21:31 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <jiri@nvidia.com>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>, <vkarri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH stable 6.1] devlink: Fix RCU stall when unregistering a devlink instance
Date: Tue, 1 Oct 2024 14:20:35 +0300
Message-ID: <20241001112035.973187-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 7838bbcf-06bb-4a62-d9fb-08dce20b3e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9bRDNzKSVj8ZRUgj/eUyhpArGXCPSXYCLL0LS8SlwtTrJkE7EBdnetsnQpvb?=
 =?us-ascii?Q?DssDSt9MprAsZnKW3CaRba356vBKFQrByGLadaj4dvufc31HRwNWWIONpjIX?=
 =?us-ascii?Q?m2u8svncdtPpcDkKdCMJzuAGacLfHuykG/Wv2YLiXQEv5DNX7MliB/HOb1WR?=
 =?us-ascii?Q?WxI6nkJbisy8k9hIXz4rhoVXNFPHYoGxcxFIMuYPMsg3W89m/DuCa4PKL0zz?=
 =?us-ascii?Q?ehe6Rd/ZoosQZKIaQwy7sQeMXWVgTTSLT73D8DvJ898+ZsRupi4GlcJRp+wT?=
 =?us-ascii?Q?eDLGMCllAA9Y/AZ86MKG+Qr8OkBjwbap9he2qvjkIFcQOl3jwLyDorNPEVvD?=
 =?us-ascii?Q?yKWPA2N6K9OABse0FO5ImYZgXDczQKiPMZRAiT+RFVC7Lg0hg7cw1FCvzmzU?=
 =?us-ascii?Q?ferWEdPHgIH950bZ1cGfQ1Lai+dHyRYh0nz/E4x0jwCpyr8B5oEuE9oo+ST4?=
 =?us-ascii?Q?lZyK7dhqKj/zj/sbgwj9fzqoqMSh6ZfFoOXHGpDFlCpdOgldNFbWaCXb8i7C?=
 =?us-ascii?Q?bGnIt2wqEWK0qso7Cp3718y3w69xKVy7EtyoR7XcAPfH5Uw/7atUVJBZSxrW?=
 =?us-ascii?Q?qJWdnqQsvJKcrDl1dapem/qxqWdDyLZndZZlP0U0dfkulVQvd3jJbVxl8Dqs?=
 =?us-ascii?Q?M/uG16HGpQaE4qp3ddB7b2CLDSCh3ygrm3oW3xkqrygDoinGD3wwiWUnghnW?=
 =?us-ascii?Q?jwp+HLYqjlD5Nn00M5+i9cmk3Fmh+5U1fd4CvDUO3RCfBEWFskC6E3ZvnDPz?=
 =?us-ascii?Q?s6/jTaOhA1xylYHmqnhzTASXYHKkOGG76Dg1qnoayvK2nTIEscmab8gUa/lG?=
 =?us-ascii?Q?eNcMGcLn2BPuJDX4VVhpLqB6ZkCz+7gYaab1MQ9lphrR0V0/qtdB3IvIVr2M?=
 =?us-ascii?Q?kNyr3gfILP+gHW4up0fbeqo5e3/rYiqOcwWWiscPULfhWHtuCDm+AuVlFuWd?=
 =?us-ascii?Q?G3KIkbAbBY6GDTTyZySdBq5lw/1sGsHpEGuUvCE5Q1PSq8ufvCGOvIE4aw7D?=
 =?us-ascii?Q?RmCx8Zl58Ifu+Iod9VzLwxEZUlhLmfOhviLWKPKJ/ViYUxYnFy15LMdYDhCm?=
 =?us-ascii?Q?nnopsXblB0IAg7EmCRdlhSwM2SClDoaoFxkvaKrk1FND6CSyzSHEpcdS1Tfk?=
 =?us-ascii?Q?uOSnZFr5BpL9fr/eOzeDQYQrrYMQanBmlxpEL9efsLL53g2WX4EMk5IBKUFq?=
 =?us-ascii?Q?BT8r93Pg4m/fkQePh0vSelVRReR7yic1QESf2Htj0vuNMId+KbydcjKf3uq3?=
 =?us-ascii?Q?a1+yGFU7sxgKge+cZv73KA6sb7zOsuUwxAFaEoMFbl2zQTkKRZMdhlmQn5rP?=
 =?us-ascii?Q?yubQabH2XV3dArkKYV8YO4/pd8j7gGOLV8WACxyOdVglSNaReTbln6OL0jcV?=
 =?us-ascii?Q?XdUBChQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 11:21:49.4157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7838bbcf-06bb-4a62-d9fb-08dce20b3e3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610

When a devlink instance is unregistered the following happens (among
other things):

t0 - The instance is marked with 'DEVLINK_UNREGISTERING'.
t1 - Blocking until an RCU grace period passes.
t2 - The 'DEVLINK_UNREGISTERING' mark is cleared from the instance.

When iterating over devlink instances (f.e., when requesting a dump of
available instances) and encountering an instance that is currently
being unregistered, the current code will loop around until the
'DEVLINK_UNREGISTERING' mark is cleared.

The iteration over devlink instances happens in an RCU critical section,
so if the instance that is currently being unregistered was encountered
between t0 and t1, the system will deadlock and RCU stalls will be
reported [1]. The task unregistering the instance will forever wait for an
RCU grace period to pass and the task iterating over the instances will
forever wait for the mark to be cleared.

The issue can be reliably reproduced by increasing the time window
between t0 and t1 (used a 60 seconds sleep) and running the following
reproducer [2].

Fix by skipping over instances that are currently being unregistered.

[1]
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-7): P344
 (detected by 4, t=26002 jiffies, g=5773, q=12 ncpus=8)
task:devlink         state:R  running task     stack:25568 pid:344   ppid:260    flags:0x00004002
[...]
Call Trace:
 xa_get_mark+0x184/0x3e0
 devlinks_xa_find_get.constprop.0+0xc6/0x2e0
 devlink_nl_cmd_get_dumpit+0x105/0x3f0
 netlink_dump+0x568/0xff0
 __netlink_dump_start+0x651/0x900
 genl_family_rcv_msg_dumpit+0x201/0x340
 genl_rcv_msg+0x573/0x780
 netlink_rcv_skb+0x15f/0x430
 genl_rcv+0x29/0x40
 netlink_unicast+0x546/0x800
 netlink_sendmsg+0x958/0xe60
 __sys_sendto+0x3a2/0x480
 __x64_sys_sendto+0xe1/0x1b0
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x68/0xd2

[2]
 # echo 10 > /sys/bus/netdevsim/new_device
 # echo 10 > /sys/bus/netdevsim/del_device &
 # devlink dev

Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")
Reported-by: Vivek Reddy Karri <vkarri@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
I read the stable rules and I am not providing an "upstream commit ID"
since the code in upstream has been reworked, making this fix
irrelevant. The only affected stable kernel is 6.1.y.
---
 net/devlink/leftover.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 032c7af065cd..c6f781a08d06 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -301,6 +301,9 @@ devlinks_xa_find_get(struct net *net, unsigned long *indexp, xa_mark_t filter,
 	if (!devlink)
 		goto unlock;
 
+	/* For a possible retry, the xa_find_after() should be always used */
+	xa_find_fn = xa_find_after;
+
 	/* In case devlink_unregister() was already called and "unregistering"
 	 * mark was set, do not allow to get a devlink reference here.
 	 * This prevents live-lock of devlink_unregister() wait for completion.
@@ -308,8 +311,6 @@ devlinks_xa_find_get(struct net *net, unsigned long *indexp, xa_mark_t filter,
 	if (xa_get_mark(&devlinks, *indexp, DEVLINK_UNREGISTERING))
 		goto retry;
 
-	/* For a possible retry, the xa_find_after() should be always used */
-	xa_find_fn = xa_find_after;
 	if (!devlink_try_get(devlink))
 		goto retry;
 	if (!net_eq(devlink_net(devlink), net)) {
-- 
2.46.1


