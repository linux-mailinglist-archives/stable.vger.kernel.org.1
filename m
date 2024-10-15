Return-Path: <stable+bounces-85185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E39899E604
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DFF6285AD2
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1D11E32AF;
	Tue, 15 Oct 2024 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m4kJJ6Vj"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E3E15099D
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992256; cv=fail; b=DtRVieMcYrl24itoQEnO2nJ4RFkhRNff1pC/vy51z5gb4a0h8hhMncO5S0sCf+AR4xz5UN239rXxtt0UGvloS37c9b4J21WfniZlCoBZpFxtFDBYQtgnu7lZWVYh1SPpqPY/1xIMxZzZeoR/9kKGVWL4gg1AtA7g6HrM1xDpS2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992256; c=relaxed/simple;
	bh=piGgcP5JND9WMMDTflmafebcJJ49AjI5jhkh72tBomU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGZKUrqYSYPLmRv4Z+9HNBoWguhp6FskItHySVOpjJIOvuzI26pC62rLf/A1QS7JlF7PeTHKWQx+vkhgoa6EmW+vDNcOaBgBJZj1OCKaeUn8qXLocLGg5qky1UrcFfqb3MMkJBh30Po6tZbDo72Jevb2J1DLBEyHtT8XTP3lRgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m4kJJ6Vj; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KX+jlqc6xuOj6yoskKidsEA9gR70QSHaiwVNELywOu49Kr48+dRczCtpVhT8Eahr1vP90hNwxYYXZo9OOA+tkv6YJKZsRjMEhabMjYpmw13AgJgQab5ycfam4/822sIMFtY41rlvDMUtFke2oiRBIcyWqNLGbtj3o2amggRfNi6JEyiavLEvyug+JPXJztrdsegDVuAdzTMxcHXYMu3Robt+2DCTPUrrTHGki5xHvQfB5B2810N81JWwsh8hCYXadJ88PY0wLkFiYcnrjqrVyTk4LeI3zw0owNeYtb15rOVSSTi9VoDioxVmb1XNKWqdKa9kAYpUWX9JOhDy8K4qvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJNju0KEu5UCzdnf++1zDBmeRohWPYsI8a8h717+k3w=;
 b=juBdtxrZT+DbSO6JTT3kohvmgD3n7xz42OPkN/glGHrRypym7xNRnYflqWtX8Vci8XldWaYb8+fnAlXSUJSkCPI5MyG4El3hZM31EkbKnjI2sYfzevJZxyS6vkYoEdtKUc0a7FQ0cNL14cd89ZgON3e/YkTGzSIfXXTDGOxuSpi4RHpGuvl3LAkS5BWI//CCSY9zrhOTq83DTZ7IvsW7/VA1hadGrke38BELJgvXgjoTB3xLcYu3uk0qnwG/o2HM5D1c1kKK+o2X9JpbdsusPg06MQXNGKxCrAkjKyuaLwDCn3Dq+BOCLlQysJ31G244RiK85xQ8eiypTLeRTl4Q/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJNju0KEu5UCzdnf++1zDBmeRohWPYsI8a8h717+k3w=;
 b=m4kJJ6Vjfe4q9ZIMKTdTK80bjMwIruTKtfGNtCyYxXvAoMUZeE+cw36elTUSn6HcZJntcHd4yIYVYxx6A+eNnjFD/NG12CmXgOgZHnnRcHtOGHD3OCDvNIqDdn9ocCjNGsAJnZiK8EpGA24AkxoBPoyOReN0Rd9tnZZOla3vhmVObw0ScIfSOD44DsRRoVuRgvEfaoZropFH9J4K/U40Ds8cMsDXY7pj8fB83XVCy7pn9g6H6nhmlQn4fjZYVVQBkFJkZl/OXdu7N83ajtZDGgeWkMQ/y9V58LXb+394ozttIbgnsxPBGv4Jttr9nM9fvdrZkPmgiuyJzWNYR4fFAg==
Received: from DM6PR04CA0026.namprd04.prod.outlook.com (2603:10b6:5:334::31)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 11:37:27 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::b) by DM6PR04CA0026.outlook.office365.com
 (2603:10b6:5:334::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 11:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 11:37:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 04:37:15 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 04:37:10 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <jiri@nvidia.com>, <jacob.e.keller@intel.com>,
	<gregkh@linuxfoundation.org>, <sashal@kernel.org>, <vkarri@nvidia.com>,
	<nogikh@google.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH stable 6.1 1/2] devlink: drop the filter argument from devlinks_xa_find_get
Date: Tue, 15 Oct 2024 14:36:24 +0300
Message-ID: <20241015113625.613416-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015113625.613416-1-idosch@nvidia.com>
References: <20241015113625.613416-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b274623-c79d-414f-5374-08dced0dbe94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xFmCCCsSxvlLjyZQtBwiIfvtoaGIelM7DQv3g94Wmg3kFOLjBQXjPArTXcb9?=
 =?us-ascii?Q?aVaN0HbL/UdYbtAS3KeWzqcVOn2vY4JkJwG7ScrJUcfhquueVzEJu2etjqLZ?=
 =?us-ascii?Q?DLqsEBA17Z8Fv5NHes5LC76BdhHC1MM7XN8c8lBmupb1DDmeHlMb1x2ab+zz?=
 =?us-ascii?Q?FmDq4aA9wqFiEzIWdGtf3Cz56NV4nFz02Z60ucavKyYm4qoTKYSGkq+gd2bZ?=
 =?us-ascii?Q?c0pwAGjvhrYeVCwlePRp3ymjdbM3z6+KNrDit5c6a8IbcSTw38v1CQaucVzk?=
 =?us-ascii?Q?2XOZoeoJ6myJA0JXcGjta0cET1pr+ktvPhqFdyZ2OUsGy4uyx/8htpJVRf9O?=
 =?us-ascii?Q?84YYVgvy/fgAr1bH9vZ4zTDsHntzyyLyywRS3Zt6gN4ivNYGdmakzYZR6Yxz?=
 =?us-ascii?Q?9rAyd7EwKzf2F/FZWvoJ1kYlN01ph6aP5SU6ZJDtMaS5hIHN8QrFirPNkNI+?=
 =?us-ascii?Q?IrquQculj//Cq6OhxrJJH9PFMVc4yIeiZsUFLIG132rSZRvZQvKg7iu5z2l7?=
 =?us-ascii?Q?9gx3FEclvXT2hk4i9tAIv0CsD9mT/op7pfrNQvdcy4RDTD511972Qss/MEDL?=
 =?us-ascii?Q?J2DCjrThPd7bC9X70WZ6t1pK5xV4j/y9OXb919+Dpygr8RSRYGCUX6z+mso7?=
 =?us-ascii?Q?mtlL49/zeQpkHzLyLwOeP/pMRW1Dw4/aMYFUtp5yg4nH5bUmqHuitiKUvTgb?=
 =?us-ascii?Q?qMH21W0OdxOORowIDEajOfnnsnx9sPVAOzY9leLQmfHTim2G8LHqLKeXnPuA?=
 =?us-ascii?Q?BiwHZFvwEe/FtoZFocx8ORUWpPx5VJvK4c2WrzO0U6G7TQtEKJKTn680dGuu?=
 =?us-ascii?Q?ZwNLsZVq8mJiXfGovCW6+MfuQ0TsePIOzzb6LzstR/yLB10WPJ/6CJUCw1Cr?=
 =?us-ascii?Q?509njZ5Xf+HopK2ObyQqXGE/pdq3x7new5s+FdEBUMY44vH56WGsWzmE1txu?=
 =?us-ascii?Q?Swmblbnp11NalPE/p14P/yxKCheesCvHpzlweeqNia5i5/sRos84TopCk/s9?=
 =?us-ascii?Q?MaKPiypLXYUw0mA8V20GOeiRWhX6qxmCXSdNLHUkw2rgkftxIYmgzVmye1WA?=
 =?us-ascii?Q?4hfv+l/WaiggDgCP6jbIPCrtRMcFqA+On9lERRNz6T9KtdCPS3N6BP02+/g4?=
 =?us-ascii?Q?IZarjWeZ4zm1LYeiZr0LBroPRr+4DUz/ryDXZyj8tRBhuSSXxCrBMPurZhn6?=
 =?us-ascii?Q?RHT/0ZKc1yr5frm/BCyHuu+LpI9KIsNSN3sMzgHg3ZJ8XkeMgGQG932JQLCl?=
 =?us-ascii?Q?OLo5gxKAzqj7ZrZCeFUsGzlFfkhXuvEXON0vk5DlHoBn1es3mQHx2B8KS/7j?=
 =?us-ascii?Q?w0oA8iZlXcpEQa7giUrCx+pJMgzEh27E2uCbVsmY8lHfGw/Yd7BWjvaG0Wl/?=
 =?us-ascii?Q?MpLlEX7Sk8swYlCApN2187AhLQzV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 11:37:26.6267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b274623-c79d-414f-5374-08dced0dbe94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176

From: Jakub Kicinski <kuba@kernel.org>

commit 8861c0933c78e3631fe752feadc0d2a6e5eab1e1 upstream.

Looks like devlinks_xa_find_get() was intended to get the mark
from the @filter argument. It doesn't actually use @filter, passing
DEVLINK_REGISTERED to xa_find_fn() directly. Walking marks other
than registered is unlikely so drop @filter argument completely.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Ido: Moved the changes from core.c and devl_internal.h to leftover.c ]
Stable-dep-of: d77278196441 ("devlink: bump the instance index directly when iterating")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/devlink/leftover.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 032c7af065cd..68210b5fab8e 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -289,7 +289,7 @@ void devl_unlock(struct devlink *devlink)
 EXPORT_SYMBOL_GPL(devl_unlock);
 
 static struct devlink *
-devlinks_xa_find_get(struct net *net, unsigned long *indexp, xa_mark_t filter,
+devlinks_xa_find_get(struct net *net, unsigned long *indexp,
 		     void * (*xa_find_fn)(struct xarray *, unsigned long *,
 					  unsigned long, xa_mark_t))
 {
@@ -322,30 +322,25 @@ devlinks_xa_find_get(struct net *net, unsigned long *indexp, xa_mark_t filter,
 }
 
 static struct devlink *devlinks_xa_find_get_first(struct net *net,
-						  unsigned long *indexp,
-						  xa_mark_t filter)
+						  unsigned long *indexp)
 {
-	return devlinks_xa_find_get(net, indexp, filter, xa_find);
+	return devlinks_xa_find_get(net, indexp, xa_find);
 }
 
 static struct devlink *devlinks_xa_find_get_next(struct net *net,
-						 unsigned long *indexp,
-						 xa_mark_t filter)
+						 unsigned long *indexp)
 {
-	return devlinks_xa_find_get(net, indexp, filter, xa_find_after);
+	return devlinks_xa_find_get(net, indexp, xa_find_after);
 }
 
 /* Iterate over devlink pointers which were possible to get reference to.
  * devlink_put() needs to be called for each iterated devlink pointer
  * in loop body in order to release the reference.
  */
-#define devlinks_xa_for_each_get(net, index, devlink, filter)			\
-	for (index = 0,								\
-	     devlink = devlinks_xa_find_get_first(net, &index, filter);		\
-	     devlink; devlink = devlinks_xa_find_get_next(net, &index, filter))
-
 #define devlinks_xa_for_each_registered_get(net, index, devlink)		\
-	devlinks_xa_for_each_get(net, index, devlink, DEVLINK_REGISTERED)
+	for (index = 0,								\
+	     devlink = devlinks_xa_find_get_first(net, &index);	\
+	     devlink; devlink = devlinks_xa_find_get_next(net, &index))
 
 static struct devlink *devlink_get_from_attrs(struct net *net,
 					      struct nlattr **attrs)
-- 
2.47.0


