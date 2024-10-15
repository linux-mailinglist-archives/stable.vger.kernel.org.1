Return-Path: <stable+bounces-85188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8829D99E60A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E721C22558
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CFD1D90DC;
	Tue, 15 Oct 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aIWR/3Nd"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76D1D90DB
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992263; cv=fail; b=PABfcao7rjHZwF7H6q4rLgBF6GPpXhrQABfaAlSaLQOZybeaRA+fMHF9NYqGfnBsmJoWhHnqB8ykCYUkP+UHD+r2HaUnDiNDth1FwYfrXuSI5rqjJRICp0UXOpKFuxKVE+zXiodsIAX5WeDm/TBgTNbS8GRBOsBzFvQ65EeYO+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992263; c=relaxed/simple;
	bh=WR6ANooRYOmTrabYgofHWoRJHWBH4li+vimz5/AiGdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRZ3rLjJE9ITuSVs/RnNhIXzePzXQU1t8FRnMHdp6gBdnfULh7S9fmUiq8OD0GaHwvQ50qnWSfcAfwimNwT0PZbQZyXNo63EOXLdRpj6DJG1QuY5MhM5hx1ipQJX68n5HnqVwEq/r4yRVwsVoYXIlJuVKP+qy5B7Wrr9wBsTXeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aIWR/3Nd; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQACpxRVjtZ/FP39JWbKk/6xPOwP2M0qBHlSZaeeqq0ktsxom2e85VdsovKrnuf2GdNHeyJhCTn8QHZ7u6P76gCKYFLJYwfGiUCbY2Xd2mFPGEOQkIHGXAxvKDcj7QF9y4YZ5D2oIBcJkjjiZf3llbeykKG0IFpHPhuYWm9dNTga+CHatTsV7obYiRygsT59VoKmLsGGUngKWfcbcF/XGN2dDv+sd4108Pg1sWlzyiU7t4auaNzMy4Kw6LbNsMBOtJE4pukKHl2BWWnWP20+X+4gvA0tCezKiRljpFZEGmkOxRNj5L6IuhJlNj6TeFxcP4ZaYsMDKlBmtujzhd+6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9yISr3NcOH0bKs9R2HQ8uyGN5BTkP7FODcyMbI4ZEY=;
 b=FZGACu2wKVmsILCpx6Zfj5DJ7dtupikkAThW5JDuaoRZGGGIIcHize1XagLwxk6jkkBINxCDu131b/wgXBJ4mlergIgGeEplMXQLoO+bkTBIw9XQMYuCkICOqVbbe80gaF72TEUx/sLwhHy8VFUdiJ9PLsHK4C7uTrGDItoidPJqcF7ooZqO1S1N9wvhsTklykEl50cEdLj0MODYEg/mY99PDiinLSXxKMsoIV1nSlDj+A93TFurtZoYELyWKGntRBUfio2nSF/VxVoUUnHFmf84Tsd4CgjyiWy6GKtriYNMckueZ+bFVXccZCNEJrbt/OVpSa2vofqkJQjA+U4qCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9yISr3NcOH0bKs9R2HQ8uyGN5BTkP7FODcyMbI4ZEY=;
 b=aIWR/3NdFh3R54DCPtPxNIydQO7gW2IcK8Bn4lgWcvwd77lalFFqdXDhOQ8lYIanyH6slCbGWZ7yMP7/LvlOAR2b7XihI6sTpkCBwChxMrV5dcWFl+cyVn939G0nmFqUo8dPM4K36D/lDDUbWqji+Ma5TwTzN5KS4x/+syNTHwbSF7TdeBA3jydr4CsmUxWJAMrXeYjPxo/ATZMr70UPUlLiImQnHk1KOEtwBuCE9dEvNLCBrvIdZ4AXzGM0EmQ0YWv/BnOMBwzk27aqj/amILB2yU6Bbk2yb/Mt/YrZK089VHFvv/x/6278T3kEInrPk1Zbye6Ju/MN1VQFbujQHg==
Received: from BL1PR13CA0165.namprd13.prod.outlook.com (2603:10b6:208:2bd::20)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 11:37:38 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::2) by BL1PR13CA0165.outlook.office365.com
 (2603:10b6:208:2bd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Tue, 15 Oct 2024 11:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 11:37:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 04:37:21 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 04:37:15 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <jiri@nvidia.com>, <jacob.e.keller@intel.com>,
	<gregkh@linuxfoundation.org>, <sashal@kernel.org>, <vkarri@nvidia.com>,
	<nogikh@google.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH stable 6.1 2/2] devlink: bump the instance index directly when iterating
Date: Tue, 15 Oct 2024 14:36:25 +0300
Message-ID: <20241015113625.613416-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4fbee1-db98-4a20-a605-08dced0dc575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vPGfB4uhaICoE4eH45HNJqGfJbAUg/h8Jtm8QNwm4r3EUH0W3MlCd0HV4sUF?=
 =?us-ascii?Q?ad99Lpd9L6X4Fl3PsAHC4RD1BOzloNqtJrFPPvr4Ao9BTOy2c517CQrQgCon?=
 =?us-ascii?Q?1M5eamyMSim9BBQLGV2EP43+8bMDDAcQ3SaOLY6Q7l0DAn/A9z6FKD5F2u02?=
 =?us-ascii?Q?btVz0Yf5vXxLCShrR5X5vQSRJ0r0Q9U3xqzEK2U/OXxwtFjmd2UhI5NKsgq2?=
 =?us-ascii?Q?Okk5Uw+mvYRwOeVro6m6OdFATMVd7ffEEnd6JdzwMlrftvsEsN3h1dPlYyUY?=
 =?us-ascii?Q?r85Lk3uhZJZAEkVPafVEhWvnF0VS3WH3ZqGlTg3NTtlu+Mykqlxg+gWn4fOE?=
 =?us-ascii?Q?lrdFNUHISP+au/wLPJGPSwkonM+UCD+HkKE71mpnfaUf0L5/6BWrtpAhGf6q?=
 =?us-ascii?Q?dGSu9L6jG6QJ/6s/v5dEmyIqSRNkaXsYHRcfJAkzXvr71kP5UCPvZmo0AVN0?=
 =?us-ascii?Q?1I5ulGoPWTacFGkYZc6KRMSAOrplIHczlA8KKLJv9CAOzWMvkPRjDMiLriqk?=
 =?us-ascii?Q?zBXgnlrtNB/Hqc+eUQ0uhxlFwslE+mILKr7/PJBWHIW8XXb+O1m0ueoTFd1k?=
 =?us-ascii?Q?WxwK0wFS9ZbY+DZhA0IHrP0+Fp0X2NogNzHhDcPr/6euhIBTkM031MNqWsqm?=
 =?us-ascii?Q?NHpinLLCHjwLypnlWvlKkvgQjaRmqeMxIxM4EeD10LjSr02VvBQBvjOZSM3/?=
 =?us-ascii?Q?/4jy3h34DcNbJrhVoKh35Gr86d9PdIYKPkN5b8RO8MmysjlOI+d9hDWgyi2A?=
 =?us-ascii?Q?7ZHxjj7/zLVGE6EPOOv0lFyskknHQKfLhoJCUlmGIRlQwg9ow3pBF6riB3E4?=
 =?us-ascii?Q?14S3kzH4fZCH3/42hKMYyiwP3tKHL6+fNWrO4NqSaASDh2YdaUuzJmTsITx3?=
 =?us-ascii?Q?/S16eLfejaYUqBHcJ9xE5VFFXg3W3rRULBXEIkTTJQvP7x6netk+5DIvnbRh?=
 =?us-ascii?Q?Ok7Wj6IIOUeNPDXgVbCTMkNiOoBpGUDFQdn/Bmn2rap9nLRWcG2lmglhbH7P?=
 =?us-ascii?Q?Ms2lh8iB1m/D47OoOM9Xn09rrmEy35aNiG2hahHkR0iVuLmeAaZMNUN0Ntbc?=
 =?us-ascii?Q?aRZJcC9CI1yVP+621xrqki3dKSwJhsOkmD2CSsP603RwdDFcVFoL/b9/z96n?=
 =?us-ascii?Q?XTrcR7R3v7KpiHJjXPayYJlAI+srWI/xaQbaNd4bOP1UHhQnEn7gXzPVw9Dg?=
 =?us-ascii?Q?LTu4LGC4qz+i2qSytOjKfSg1JUcEWhW6Pv59GkHlDCh7/eh5ttVpNF4Qmmmy?=
 =?us-ascii?Q?QnkOAwzMb1G3eCgyHTFGTg7iCmnOi6IzgXVs3RFbpORevOsrfjwk1BQnpkJ5?=
 =?us-ascii?Q?BzjZpzcKKO/FAT92WNve3mLK9CbpPDQfJjwR5y0tQ1ff4fvrWq5b44pyWTka?=
 =?us-ascii?Q?eYoz4VNGEGwzgpq2UNeVJHuCaMBR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 11:37:38.1072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4fbee1-db98-4a20-a605-08dced0dc575
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091

From: Jakub Kicinski <kuba@kernel.org>

commit d772781964415c63759572b917e21c4f7ec08d9f upstream.

xa_find_after() is designed to handle multi-index entries correctly.
If a xarray has two entries one which spans indexes 0-3 and one at
index 4 xa_find_after(0) will return the entry at index 4.

Having to juggle the two callbacks, however, is unnecessary in case
of the devlink xarray, as there is 1:1 relationship with indexes.

Always use xa_find() and increment the index manually.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[ Ido: Moved the changes from core.c and devl_internal.h to leftover.c ]
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/devlink/leftover.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 68210b5fab8e..f1c6bd727a83 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -289,15 +289,13 @@ void devl_unlock(struct devlink *devlink)
 EXPORT_SYMBOL_GPL(devl_unlock);
 
 static struct devlink *
-devlinks_xa_find_get(struct net *net, unsigned long *indexp,
-		     void * (*xa_find_fn)(struct xarray *, unsigned long *,
-					  unsigned long, xa_mark_t))
+devlinks_xa_find_get(struct net *net, unsigned long *indexp)
 {
-	struct devlink *devlink;
+	struct devlink *devlink = NULL;
 
 	rcu_read_lock();
 retry:
-	devlink = xa_find_fn(&devlinks, indexp, ULONG_MAX, DEVLINK_REGISTERED);
+	devlink = xa_find(&devlinks, indexp, ULONG_MAX, DEVLINK_REGISTERED);
 	if (!devlink)
 		goto unlock;
 
@@ -306,31 +304,20 @@ devlinks_xa_find_get(struct net *net, unsigned long *indexp,
 	 * This prevents live-lock of devlink_unregister() wait for completion.
 	 */
 	if (xa_get_mark(&devlinks, *indexp, DEVLINK_UNREGISTERING))
-		goto retry;
+		goto next;
 
-	/* For a possible retry, the xa_find_after() should be always used */
-	xa_find_fn = xa_find_after;
 	if (!devlink_try_get(devlink))
-		goto retry;
+		goto next;
 	if (!net_eq(devlink_net(devlink), net)) {
 		devlink_put(devlink);
-		goto retry;
+		goto next;
 	}
 unlock:
 	rcu_read_unlock();
 	return devlink;
-}
-
-static struct devlink *devlinks_xa_find_get_first(struct net *net,
-						  unsigned long *indexp)
-{
-	return devlinks_xa_find_get(net, indexp, xa_find);
-}
-
-static struct devlink *devlinks_xa_find_get_next(struct net *net,
-						 unsigned long *indexp)
-{
-	return devlinks_xa_find_get(net, indexp, xa_find_after);
+next:
+	(*indexp)++;
+	goto retry;
 }
 
 /* Iterate over devlink pointers which were possible to get reference to.
@@ -338,9 +325,7 @@ static struct devlink *devlinks_xa_find_get_next(struct net *net,
  * in loop body in order to release the reference.
  */
 #define devlinks_xa_for_each_registered_get(net, index, devlink)		\
-	for (index = 0,								\
-	     devlink = devlinks_xa_find_get_first(net, &index);	\
-	     devlink; devlink = devlinks_xa_find_get_next(net, &index))
+	for (index = 0; (devlink = devlinks_xa_find_get(net, &index)); index++)
 
 static struct devlink *devlink_get_from_attrs(struct net *net,
 					      struct nlattr **attrs)
-- 
2.47.0


