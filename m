Return-Path: <stable+bounces-142023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF975AADBCD
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14EE3B3387
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB52156F5E;
	Wed,  7 May 2025 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FuuwZA9G"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C808248C
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611266; cv=fail; b=DkJz6LL74+7XoB+TlNYLLB/KVisye4OlhSDL+cc3xDJdbmsF34Ve5yPACGCc4LE5YfFgQEFTDF8AapVBU1Ovy29AAqxSmhk37K9LcdPcxV063BbCtcZbWS5jiQe72bFmR9gQ2B6O5oKZkUblX2PClQZPvVv2YiCMshns45UXjcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611266; c=relaxed/simple;
	bh=4HzLnFq1zDTUF4vBbBLebkEPFlrX/Y9Iu41bkgHguXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SmGmv0xuoj2ArxGUXjZkMhVrP1ty9Qz4KuUCM6S3xeYEEzN5EnbgO2HJUgh/IVzEHnlRWsBaKrvtVoehKFQk4uy9e0sBr94AXdsq5boNO6GFYK17NHSn9A97BSptWMe622irg+ljmaJkgd3c61D0urc6bu/iyH6dAODTg16QCU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FuuwZA9G; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbI9mQCJbYSoFQ1INfT/tXtZZwIbWC/A0eCc3N0pzFL08/axbF6/YA8ggtNfXNOIcbWdLrbqWwEJrnhhi36ALrA/qcUUH5aSHneVFuIx+mjHupLou7YLRSYN5iEJ/naQeJqd9ala7LVKRJ/qmbzPC8s6tA9zsZqveEpPSPD8UQCJca9cTGngWkF5b7hL8a65wrdO7WiLazY+VbXcGUgOMsp+fKJjdScMPUp5whG/oE3uCv2BILPA87WWr0kqkRvJ01Cg2eOvsGjobPwLfujz3xgPxShYVelxmJ5U2jkclPvM90yBhM9NgHxPzupJBIxWCojEoKhJnX73azPf+TNyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zC+aOJAoidNqqZjtl1/8u4A5//FQ3Q62LedaUxyUp0=;
 b=cdhB8/vkZE2JpVT/2u4/2tAamV5VKFeN2U+tfmsh+4Weq7PO9/sXDKOklJD2NLU1LuGol86ISgFQaorjl6mUYDZ5PUQVfIHNTnrW0nlayoXTCsId8OaM6lCOG4tYdSACz9+/p9dvFMYY4psBKVe/jJs1TMiYkfvIXl/tiNf8Jt30151+dcsf6AA8mMCi46cmRz5KA42zdFk06aq7h6RZDBcckhl2QfIfL5lbTcL3pa9A5leABE+x1ZDMQCIgDjZF8wDQcPkSfW28enFpPJ3zg3cH8feQO7HEa1wOhu89tFpsp4BSI5JCSSBkY1wjyrR0ZJMEndQI/27O+dVJaU38lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zC+aOJAoidNqqZjtl1/8u4A5//FQ3Q62LedaUxyUp0=;
 b=FuuwZA9GWMyKjEzc4uaDCWDmsUDzTYjlfzaURYd1lSdo6IdA7bGE0hkA+8ixEePWGGBjSrgn7AuJCmNOAJBbm8uWWgVmcMnKRT4TD8KuiEJzlq5tIo84avk1du7xp/zo4/2su3IQJ4WpVMfyhIAJWf9piIwNpfcCcIZTrEah4kpOfkLqYr8x/2QQTu+01A3yuZh4kzJE5CQp89koFzwcFZ6lcpSULf5b1XxbOexwF9ztBEDuTc8SgkuvmE4ymst4WNIL2KoKE+1QpOVaxRcmc/aAeqyn2ONa4zuK8LX69B3U+f814AvdvZVmGaw6wrZ/gOyTEEwEqU6grOOl1eshhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 09:47:34 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 09:47:34 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH 6.14.y v2 6/7] ublk: simplify aborting ublk request
Date: Wed,  7 May 2025 12:47:01 +0300
Message-ID: <20250507094702.73459-7-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507094702.73459-1-jholzman@nvidia.com>
References: <20250507094702.73459-1-jholzman@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::8) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de195bf-db33-4fb6-dc15-08dd8d4c3190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uC1lORdJ5blvwJuoJcQF6DHB4uyh6RTwMM9T7vN3YP4W2IW89tMxrSqtm7Mp?=
 =?us-ascii?Q?jrex0O5LOQsbed8Llw2vX9jgE4977SEt2lb8/9/hkyQENEm7oxePz9rhX7M5?=
 =?us-ascii?Q?Ez4CnbBp426JZVpf1FL/CLYFVOMopzAHkeBeTjtJgAGbO4X1ulxJL0Es9t0E?=
 =?us-ascii?Q?h8fJ3gJ1+sYPYPpGvWvJPUS0kvsySpewqGUk8PFtVyJQoIZf0LDzPBrfb1ew?=
 =?us-ascii?Q?DaoHKGJm7IoC8ZAc2luVUAp3cBtCAs7Ul9U1SNE4XZov8EHux/gQ1QmF5b0b?=
 =?us-ascii?Q?CirtGZzE398RuJKjlaY5MBf26neRM/epO8InnoRTMJXRShv6TEv+8RNNZyTt?=
 =?us-ascii?Q?ZA7rwCgvmCtM7FTLMMKntkdQKvw9S0sYPGi8f5SdxMATAJuWfh5bZY3hzQPK?=
 =?us-ascii?Q?w1VP0AKx2/Q/xUhY8v+z6OjQnSVnryib7orEuAcz8JeTmN+LbofEHpm2Z/1D?=
 =?us-ascii?Q?uxqDdiVYqep4Sblw5VuDLdoVqpcAZ5yRBdNz44t8VDnoOgkfo+Wy1ER0Z0LM?=
 =?us-ascii?Q?Mq3YLGk1qTnc7BRh9t6Al/E57SA2tRCL+BrJi4GD8WmlS7hcYxwA1ukF8gTQ?=
 =?us-ascii?Q?z4b9DANBIrH+QKTuuBnoWe4GwcrxnCa0MlJqdoDIDiKcIUj2apSZCRnY6y4L?=
 =?us-ascii?Q?MLP9oXV08UdrPUH4tUPYfQoyfj4sddiKNnhryaroJSyb7KLbZq7cI/Bv822Z?=
 =?us-ascii?Q?67Vc/r3/3Umffw75GadP15yjSoZWGtmYazDSZfeKTsnQEH2emlJdOWLqfQKR?=
 =?us-ascii?Q?68TIuAbmppg11TA/eKuYf6CYRWeedWA2B+94JFSZRMCO/3NGxvSaDYWb3LwC?=
 =?us-ascii?Q?2ppIX8Agp1GTan9rgn88WOXLLpqWk/+7kd20R0TVjxMV4kjgMr3gcgtJmWWs?=
 =?us-ascii?Q?K6XgGFtgsr4hOwXLukgJo8FOuTmCAXmuZv6QoWVh6241NL2kj6n5fkCmwmq2?=
 =?us-ascii?Q?mqhYxoDwaEOLMlQCCWECaTbo9OQ40NXG/cDPZiC4zmA4WygCtBUgtn4HiPBZ?=
 =?us-ascii?Q?SXEu6uxobW/eczyq9QQjqZPDjyn+VIQrPpbiPxJyp1kVY3CJM8FZ7Mgz6m+D?=
 =?us-ascii?Q?eCPgjRJQFsY1jNaBRG6q1wGJR6Kpw439/oafEZ3JOwUh3b1Z2OTSlOkNnmBK?=
 =?us-ascii?Q?KVrLj+ENIpu2GekbhhNqmIoCYoq6rVh2CIlR28FkXxJ+4g6Y5gIos3buHKIY?=
 =?us-ascii?Q?POszmpotzy7fKRHP3er6QG8TSmfK7/ugkI+HXtN3HlFtNjBUibpHgh454D9W?=
 =?us-ascii?Q?C25H/c/AqsMbU/7HUWT8zzFvaa0dap1cwTA8Br0lpKx0da+W7a0dwHNnyXM/?=
 =?us-ascii?Q?54hOlsu+upR+rpdHuKTLIcuA34UBnQRYSFEL404uJ1VHgjQxUwBj7gpLuSlT?=
 =?us-ascii?Q?XmPdncTrTY3aTPZhluJoUgt9l6VrAfpJb9RGRGNmMXifiP6sRisEUvcNw1DY?=
 =?us-ascii?Q?gXoONyu1tQs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?84qqHhsGBEgIeFe9tolcwcrhT1gz9IOU/6Tcbj7KTfszK18CfCRRZuZhfpky?=
 =?us-ascii?Q?CPwdT7aa1EMMZ6bOHmYuwitdnX1LOHcJa5XkotnVc+pSL5BAc3+Ro9sZOkt/?=
 =?us-ascii?Q?O2Ccz92ZrEw9hCwgf9d36FVpldMeTCXztNfccRM7nk8YUQwjUA56Z+uY3cQE?=
 =?us-ascii?Q?p/l2//3MrbP0llXnBHfOvMkrbuBOeAuFiO28yTAnXQLKWXmh6MEvZAYKpZtX?=
 =?us-ascii?Q?KKw9noGkYt7eUYeuPEiFsvsRpsaQqeqkpgretlMCgAH0pzZ/+hMJGD3wjtkI?=
 =?us-ascii?Q?TUeVghtG5YRfgf9rGeyd0u6ORTMq4E07v9pfrbZFsn5ywXPmDBmDoflmDDj9?=
 =?us-ascii?Q?CjhKEfDcITYrPQMkuGavLicd1lAfYfrBJPgZ3XGmAv1OF69amrcKl4cKpgme?=
 =?us-ascii?Q?eYiRGgyjVH61e5+viGtJNkUFhsOmM2+4Xm/RzRsOwVcPR+srL+MOum9J2Lsb?=
 =?us-ascii?Q?3unofJqyt3BPutlp5g1MjeOJdu7uif3gmH4MXrvi9v/kurZ87IMPiYvRUM7C?=
 =?us-ascii?Q?lQtCLYxw8cKtSsfImGXSqfnCGDrGIPEpczBJvx2ND/iXBX5LGhmlrISUIpd6?=
 =?us-ascii?Q?8cgK8nxGMSmwJeVTjqcd804KO4yeawmjGHBtcpdEJneAW7hunYF5/sMAvhsi?=
 =?us-ascii?Q?H6FKtYlitbmGyOvZDerR7Hp1oz7il0oY6e7isuzJREY0n7iaEXklot3j2hXf?=
 =?us-ascii?Q?VdQA+4F/K2iR/2yNiheb2emPipUTwAh2jW3fJeG2ePyAjSxuLWO94JZYHKvu?=
 =?us-ascii?Q?EnfSNy2c1G/sdjJsdf6LkgbA6jChx/0J/SwjS7UX6SnjTrT6i1aGEG28nhR/?=
 =?us-ascii?Q?sApnc7ZnefVjk1C8B/tbaahdhxXk9sFyv+Obvi8JLrJZLixCGO5BO72RKaF3?=
 =?us-ascii?Q?cJSdo/71DT6HvOEKoXFwPblx+BkiqPRzLcmsHV8p6e+n6mUQBXr5glvkp6yo?=
 =?us-ascii?Q?A/AzaMGCKuwLjDhwtJ8DRFTsYrBzabfGC8M91M7uzeZtw/6vDXVG95QT/D23?=
 =?us-ascii?Q?uuE9408E3Mwh3Bjzq1uHITZb6WddIGJLvmThdNuhu9jjvHSGB/uynsJiwKBE?=
 =?us-ascii?Q?FBzKHjyc2PR2Kyza/qpUi5cQyM3B2/A/y86tffGVghrEDsr5Y6TZSaT5JBl6?=
 =?us-ascii?Q?9SxnMA7FaD6ss34/P6iNhpQhsp7Gpi08l10Sac18sGmaEyIOvIXR4Q/mnnET?=
 =?us-ascii?Q?9t8uJLf6HQLd1os2ZUCXcloCebShWYkkfsFtryHoPtwHdbgY/g9//yzTdjwa?=
 =?us-ascii?Q?USgK6UGHkmMPBjpgCQV5PKU6ndJQ3hnOKXcRBTCi1ohe6cdMzPLx66JvNNlt?=
 =?us-ascii?Q?s+aYHt1g/u6CWPvk03dP+t3+MOw4iC6LglWPK/REbBzuiQ+aMB2nJsSrvCDZ?=
 =?us-ascii?Q?vLFOkMG705+nAL0/nBd1cuZdj2ZWJ60kSuTJxNpD/x/DFQLwIY5gEDkjf6V8?=
 =?us-ascii?Q?JGiJu5P3fLjTEQzC25LPigcIuond2PH6iuuoAAM0BwnAzaqV/k5Nep5S+eqM?=
 =?us-ascii?Q?DyBDY1RPZGpoypabpkyMmDTRttIvoHVst9IJtgz248Pfz+luBetv6zNpi6pu?=
 =?us-ascii?Q?prKwfUA+1sNXk3qwL7DEdI8YVvQwVf8rGMR9LroW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de195bf-db33-4fb6-dc15-08dd8d4c3190
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 09:47:34.6404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/6fKqzJNWiTefMG/fkPv4q9ncNTgtwrD39RrVSW81NEFiaDTcxBqZLFo99RNFu5MQPNmlJvkFkEWsZcWT6peA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit e63d2228ef831af36f963b3ab8604160cfff84c1 ]

Now ublk_abort_queue() is moved to ublk char device release handler,
meantime our request queue is "quiesced" because either ->canceling was
set from uring_cmd cancel function or all IOs are inflight and can't be
completed by ublk server, things becomes easy much:

- all uring_cmd are done, so we needn't to mark io as UBLK_IO_FLAG_ABORTED
for handling completion from uring_cmd

- ublk char device is closed, no one can hold IO request reference any more,
so we can simply complete this request or requeue it for ublk_nosrv_should_reissue_outstanding.

Reviewed-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250416035444.99569-8-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 82 ++++++++++------------------------------
 1 file changed, 20 insertions(+), 62 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c3f576a9dbf2..6000147ac2a5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -115,15 +115,6 @@ struct ublk_uring_cmd_pdu {
  */
 #define UBLK_IO_FLAG_OWNED_BY_SRV 0x02
 
-/*
- * IO command is aborted, so this flag is set in case of
- * !UBLK_IO_FLAG_ACTIVE.
- *
- * After this flag is observed, any pending or new incoming request
- * associated with this io command will be failed immediately
- */
-#define UBLK_IO_FLAG_ABORTED 0x04
-
 /*
  * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
  * get data buffer address from ublksrv.
@@ -1054,12 +1045,6 @@ static inline void __ublk_complete_rq(struct request *req)
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
 
-	/* called from ublk_abort_queue() code path */
-	if (io->flags & UBLK_IO_FLAG_ABORTED) {
-		res = BLK_STS_IOERR;
-		goto exit;
-	}
-
 	/* failed read IO if nothing is read */
 	if (!io->res && req_op(req) == REQ_OP_READ)
 		io->res = -EIO;
@@ -1109,47 +1094,6 @@ static void ublk_complete_rq(struct kref *ref)
 	__ublk_complete_rq(req);
 }
 
-static void ublk_do_fail_rq(struct request *req)
-{
-	struct ublk_queue *ubq = req->mq_hctx->driver_data;
-
-	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
-		blk_mq_requeue_request(req, false);
-	else
-		__ublk_complete_rq(req);
-}
-
-static void ublk_fail_rq_fn(struct kref *ref)
-{
-	struct ublk_rq_data *data = container_of(ref, struct ublk_rq_data,
-			ref);
-	struct request *req = blk_mq_rq_from_pdu(data);
-
-	ublk_do_fail_rq(req);
-}
-
-/*
- * Since ublk_rq_task_work_cb always fails requests immediately during
- * exiting, __ublk_fail_req() is only called from abort context during
- * exiting. So lock is unnecessary.
- *
- * Also aborting may not be started yet, keep in mind that one failed
- * request may be issued by block layer again.
- */
-static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
-		struct request *req)
-{
-	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
-
-	if (ublk_need_req_ref(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
-
-		kref_put(&data->ref, ublk_fail_rq_fn);
-	} else {
-		ublk_do_fail_rq(req);
-	}
-}
-
 static void ubq_complete_io_cmd(struct ublk_io *io, int res,
 				unsigned issue_flags)
 {
@@ -1639,10 +1583,26 @@ static void ublk_commit_completion(struct ublk_device *ub,
 		ublk_put_req_ref(ubq, req);
 }
 
+static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
+		struct request *req)
+{
+	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
+
+	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
+		blk_mq_requeue_request(req, false);
+	else {
+		io->res = -EIO;
+		__ublk_complete_rq(req);
+	}
+}
+
 /*
- * Called from ubq_daemon context via cancel fn, meantime quiesce ublk
- * blk-mq queue, so we are called exclusively with blk-mq and ubq_daemon
- * context, so everything is serialized.
+ * Called from ublk char device release handler, when any uring_cmd is
+ * done, meantime request queue is "quiesced" since all inflight requests
+ * can't be completed because ublk server is dead.
+ *
+ * So no one can hold our request IO reference any more, simply ignore the
+ * reference, and complete the request immediately
  */
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 {
@@ -1659,10 +1619,8 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 			 * will do it
 			 */
 			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
-			if (rq && blk_mq_request_started(rq)) {
-				io->flags |= UBLK_IO_FLAG_ABORTED;
+			if (rq && blk_mq_request_started(rq))
 				__ublk_fail_req(ubq, io, rq);
-			}
 		}
 	}
 }
-- 
2.43.0


