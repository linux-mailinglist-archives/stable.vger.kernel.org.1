Return-Path: <stable+bounces-142019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD219AADBC9
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8163ADFFE
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF16B17A2E3;
	Wed,  7 May 2025 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LsfjNsmN"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0325172612
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611249; cv=fail; b=im54lwLMDKVxVUoIzp6i63zWA9IJpPaf2d93g3WuHp12VHBdf3FS8xnr1WQ66+oi+qSCsUVfYbFMBkaNzUWg6FXVkrcW8s1u21LfWzCowl7m0OFaa5Dyp+scYgRxks5KAgoqIGiI1UyWIVKyxyXaJIp/PZO8fP+Hnpbv4MuC2DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611249; c=relaxed/simple;
	bh=0oCIpdk1JrvyrBdSe6hkk1GzINc/OVou2f3xfDBgqWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JwRxf12uVOTOQRT3LdeH/i7yWveBdjTiw402EhX3qtMJ77ohaOA/JhxkLU2E7LdsB8FtQaeOb5zFW/ge58Gii7HhkxRrhrRNuC7lVHP1bChLiVzHn8Niczmuw87yqPcVZ1fiyRaT59pLFEygXdWtKEywB/J8rNefmpKO2GthOIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LsfjNsmN; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4KrperV2S8A9oiRvnc5muTpowlVWCG9gOz1rrHE+o7TTUxjlkNqi36It+AIJD/VtIUVDODzCHT+QyWM0HQBe2Alt8moAnFODxlL1d0UO+e3bwUHXzabscLE+057bGWGZ5UGZbDdYRm/8AbhgS4mpznhBAwtyhs5odnoMHAm6Qbspjg9+EwoV6LR9RS/cqOfWJx7GIyC3pJBligHDbB5i6/9Oq20PyKzFoZxw1U27Fo255kC/B9ZV9o1ELyh7WFh1oQlx0uzd50c2rj+ZOfgsCvYCJoxnp6Oq+3FPAb9ppa2A0ROljdBVB3k46kSMs/lJp4DMu4rBMcgtJf0Ui3HDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCVGGgGkp1BMWrQ7D6na9xY59mYBvEbwYXvQg11CRKw=;
 b=CDZiU6Z5tzybROjXiNLWXwf0bKETQdHS9Lrrk2KCJyTXXfeBVy8EKXsshgoBqjxguNWrBeniXgm4/ORKwkjjP1bx5meFmqGmzworF01o+hobR/lfHSMB/KZgIXjQ6KyqhMjb/D4y8beZ2g/5jdlD21jvwrVBHvuT1dkNwBVoVaJ4xIbjZXmOWtcXb+rJo4TuCEOoFP0VxMQ8AglZupvyveQKIwVqxhAAuksSQPrfyIci2tmr77PdWk8MGEgncTlCqdfChPTobmkhaRqDbSOGzDeNovLL4jyuZjbSOYL9Dnjl5HwLzT3HnTDhqd7jQ2wxjdfjsz2UmcgPrBfKvjbRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCVGGgGkp1BMWrQ7D6na9xY59mYBvEbwYXvQg11CRKw=;
 b=LsfjNsmNih7uGQVFf4OPrShG8TrNfDUKHzHqAZ3skep2+zF06nrbzBbdr2/xw41sGGklk/q/XVRGmerzZxvDZSeXlm28CAqsPoHZ9TchfpUFfh2Wds71t79z7y2vhBDeUNcog8rJg9gvXF8ZzG+MIe+8FCMjZ+QMlpXJIj3lIJaX2Kuw2p8QxJG5QnS5rVqghGy579POMbCoaGPrTf/GZiuiJR4ueaQv9SD0mYRVX52hZuv6vvQT1ZOQwMwpmjVH0ZPnbq8pn8QD4TiCrLmtAhrxQk08Jj+hX4YWeCuLa39j9C4WMe2FLyK3oNfKF4Mab1kqzbNxOh6sRQFgtkz0/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 09:47:16 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 09:47:15 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH 6.14.y v2 2/7] ublk: properly serialize all FETCH_REQs
Date: Wed,  7 May 2025 12:46:57 +0300
Message-ID: <20250507094702.73459-3-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507094702.73459-1-jholzman@nvidia.com>
References: <20250507094702.73459-1-jholzman@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::13) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4a4573-757d-4e00-9fed-08dd8d4c2660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5KCFXebwbYG4bFewje4txr3iksAjr+HumJZjiYt+mJ7+yWwexOyaoxNR3Cmo?=
 =?us-ascii?Q?bkNaGUo1VI29gWx39Dg+y2zWZ1jnZEPBfG2xb2XxwCESM+hpnsn4J1cE8fRc?=
 =?us-ascii?Q?1LvqaBDGs8f7gvklPpk9Gh7fzsAeY72l8iPPQGES81X2yd08Pp1U5ADlAqMJ?=
 =?us-ascii?Q?opd2vDNWqLv9jwP7q3dJifvmhRUdhO+CKwfMS/WY9gWR8GADIKfdxcdP3aaX?=
 =?us-ascii?Q?zyOGdvLGdzwGi05rbtVXCf08hf1JDDijD3mWe+QUAIbu6uiMs2OnOzqNQZlP?=
 =?us-ascii?Q?soqVV38LUZCHCi7RotsshhfjQxM62s5WRdyt5wbquH7e9aCI7gHJgLCOaw3j?=
 =?us-ascii?Q?7Dcj9vSZkH4etUBWdp36BLRGLHpbcvaZ7D3dd/NnWUDrNnObgkXoK8oWspKz?=
 =?us-ascii?Q?fCHoaRExRU+fW8QyafURw+tKpf1WnM2nZHtu4EsSGBIUtA5rmYg2qG2Af6dE?=
 =?us-ascii?Q?6JrtASL8ll3xRyMJY6hBOnoGaHIxre0Gzk0/G4k+Jej8adpkw4FjVswm9oHy?=
 =?us-ascii?Q?tRmRR+sU3WbKkccy2BN0XKR4HgQLlfO23VlHN5Yz+dEC7AFq/JqZeZfJcpU9?=
 =?us-ascii?Q?pSI73X7M36dlv+djGq0WImtCDuhyJS6dRtVSg2AR26kgUI4/QVEm44byfzgP?=
 =?us-ascii?Q?r5jtJT2/6quBErHFBNxSha4z1S49FeY8a6+oo8cwkxDyPGelZ/QwDd2AsJvK?=
 =?us-ascii?Q?caKOFRp9InR6FnoV1nqg05DZXL7rX00v7W+W0oXI9TUrGro4B59jpAp9C7J5?=
 =?us-ascii?Q?Pb//BdHSlN8sK0PxQbXw9VbHFt8W9dGF23pureTp8nwriDDXFx8fo4xbXcat?=
 =?us-ascii?Q?rNv0RBzBpgp+C6vD8pPOyJcgH/uVXJCEnt8SX0Dzj+MED3WhCWH52YGMYbET?=
 =?us-ascii?Q?jmFdi275UBoQVkS6hEVUQJL/9KtY26wT0tigMCnz9EVorgkjiSBJggRALNNG?=
 =?us-ascii?Q?PtwwGnGh0UTQcPC7zzjlQUFDx4H4JwN5p3zd9AFH6/nXCuEh2o21k3I9YlTj?=
 =?us-ascii?Q?066P2vct3fDdy8pQHD5ovQwTXCmw9lLTrvpYgmg8Fi5Shb7Xzo9/tVNio+EQ?=
 =?us-ascii?Q?VV18+n2pLzPGgy2QB69U1QYhus2dbnoEmSZRd49eX2SqLLVbsjyuNel4tlng?=
 =?us-ascii?Q?pT13dMwzrQ5MaaNwqyWk3mVqePzd3lTi/fXxpNaDzOLjj/zgViQ6JPW73092?=
 =?us-ascii?Q?tDx6ra4zSbBtZaIK46d19A0MFKAnOLGVU3g3GKB0d82cBDzIbQHjhR5ZunAi?=
 =?us-ascii?Q?8I3rzW2Bc0Jrw51nLH8VRVQE3AggWl4d9t+hFknMZU7b+WoUjSZeX21qNhOe?=
 =?us-ascii?Q?BX+7vyjn/JXmkW+iYyC7CidiguDnZe2PJpYsVfWX2q6XxkRmyuDRE01jdicO?=
 =?us-ascii?Q?mM9Gt61TuEInVb4mz5VBh9bKfoOeILdAKH0kPvEzz9lOQ/pB547B3shtLS6W?=
 =?us-ascii?Q?UTrvZatvBv8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jx2sU2Xcnw9WDSzzm4ZajtmVV24BcCozz4BmAvJKwyD5pAmAfkBdwvR4NIDb?=
 =?us-ascii?Q?dOQW1AAyu3vE6FvV+bCMw0bwkDkHwv946nMBPqRzQt46KvvaJ7/vDZCRB8c6?=
 =?us-ascii?Q?rdnB4LN6j9YIgda5pG5Auho1rnGdhHgTHN0W2Rs6a7IS7XowqU1R81eTzMwF?=
 =?us-ascii?Q?sQi0TH8fr+nT5QH3ksqcRhXW6F5xegFPjlyjK4RsQOB3PqPmnpyF3uxsbC35?=
 =?us-ascii?Q?mfk4KmdSKSZsJwCuA/cLYeoVd5P6LHI9DLMv9YnCi8D6Q7Flz4Sbk9W06Eah?=
 =?us-ascii?Q?R/zeFAiVoNmcx1fajR8uwky2XivrU5lOoO8Dyw9xzVPEkAFYOTUBOlsWHt1/?=
 =?us-ascii?Q?Vime9moAFfzqWO/tSCFNu1OsVtJ9aoDlBaw6VUAyWhCGGq6yb5roQ7XODaCy?=
 =?us-ascii?Q?Vt15zXozL3tB/sihqe2gUUzzhRUhc4E9sQRjB3OShfi04ukCo17vB4TqkVuK?=
 =?us-ascii?Q?HNl/419ct7OsIUKT3Qgk9d8+WQRIqHKAWQINeN7X4P3XLh+fUOMKbPGlW3FB?=
 =?us-ascii?Q?UGXKFzjYSkcNA72+yIleWBVVIvO66G2PWeENCK+eF/aNvhTI05CuHkWGoPIB?=
 =?us-ascii?Q?lfw5Z87A2IuTP2kQxm8xCebXPUYLFbTqrkb3S9ZHXkUJRnKZ0i9/pkr84RQJ?=
 =?us-ascii?Q?o8/mpzqfTiJvcerq/0kposG627e2hlT51s6JhdDdPGEZguZGheCvTAqvGrMf?=
 =?us-ascii?Q?ysZuJx8OG4kQa3ssErt1Qg2h7HFiOBJ7WbeepEq/Eo6ebbRpmNTIo3OmiI3M?=
 =?us-ascii?Q?b/carm874qsLsRds+nVFb4SZn5ssc63BAMulRgdKFJUF0B4IJpjGP5NTmGtY?=
 =?us-ascii?Q?oAJfPN3QSLmRrXAN+QAxcXEmI0mQiHKd6hgWbXe56gsv3U3u/+scKD85/y6d?=
 =?us-ascii?Q?2dKmhwDBB6iB3+m2OIAdUqOl4BMsPZ8cKi4lVUIugurNafPhTL/vTFpfId4Z?=
 =?us-ascii?Q?Db8JNnLWO60n0kmUbgueOQJtEfh3GCX73NfgdpXH5fN8uhUMRjTPX/8kzrbY?=
 =?us-ascii?Q?gbwPYQo49ccLhresqSdaFkJQCLIUD+A39/9Aqkb1SRjWr6CaXQuMjLa9h5j3?=
 =?us-ascii?Q?cgziY2jydZCFSwnbNBmfQSZ9GVG2Fy/VBbGZGlwlFppnl2Hv8SFymJyvAAZm?=
 =?us-ascii?Q?4jpLO364V1JSZBty1VVZfTc8ZT0OrmwOkVeVbO/LYzL8BOtEQsDwqI+ST6HJ?=
 =?us-ascii?Q?XURcduVegQb0/mdweqxus5/8/e2qWc56MGijNmTRzKAqbL40Lnro0i6jUioG?=
 =?us-ascii?Q?67N6mXpdfgJIUjFkeFAhkhDTUnjr+W79Ho+/qNw23IbVplBs7K26pZBCDY1W?=
 =?us-ascii?Q?VaFUVfXuLQEWQYSYdyTLhABDZxxyvS6hse0hq+zA2Mbve30vYQtO/Mdl7NiM?=
 =?us-ascii?Q?q1zDrAvddg727jtGISF+qIpAzxcuyDPM9IAXdQyqqHvD+A0ZkLJ5ckGVCVfh?=
 =?us-ascii?Q?tFStbrq690ZCtoyIKmG7L85R+vbYZJQt1mCnS1z9oQSIQR4Ln/0DKdCZes0E?=
 =?us-ascii?Q?xLsRgIFLVWU7F/zzCnxZinaLrt/SPGmjjDk37BPtnPeFyq7l3CcPgWckxI29?=
 =?us-ascii?Q?IbGLVVX2cbfyEQDAx2YH8sHBvUyMwWt6NEvzG2D/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4a4573-757d-4e00-9fed-08dd8d4c2660
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 09:47:15.9200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IndJYdeDJCd9RZhQeTC7q8uktfc1XipBQYTfG5Y9B6OJinY79/99SZfnCs0GwdNVg+MOrtU4YHgGoc/v0jSI9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit b69b8edfb27dfa563cd53f590ec42b481f9eb174 ]

Most uring_cmds issued against ublk character devices are serialized
because each command affects only one queue, and there is an early check
which only allows a single task (the queue's ubq_daemon) to issue
uring_cmds against that queue. However, this mechanism does not work for
FETCH_REQs, since they are expected before ubq_daemon is set. Since
FETCH_REQs are only used at initialization and not in the fast path,
serialize them using the per-ublk-device mutex. This fixes a number of
data races that were previously possible if a badly behaved ublk server
decided to issue multiple FETCH_REQs against the same qid/tag
concurrently.

Reported-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250416035444.99569-2-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 77 +++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4e81505179c6..9345a6d8dbd8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1803,8 +1803,8 @@ static void ublk_nosrv_work(struct work_struct *work)
 
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
+	__must_hold(&ub->mutex)
 {
-	mutex_lock(&ub->mutex);
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
 		ubq->ubq_daemon = current;
@@ -1816,7 +1816,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
 		complete_all(&ub->completion);
-	mutex_unlock(&ub->mutex);
 }
 
 static inline int ublk_check_cmd_op(u32 cmd_op)
@@ -1855,6 +1854,52 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 	io_uring_cmd_mark_cancelable(cmd, issue_flags);
 }
 
+static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
+		      struct ublk_io *io, __u64 buf_addr)
+{
+	struct ublk_device *ub = ubq->dev;
+	int ret = 0;
+
+	/*
+	 * When handling FETCH command for setting up ublk uring queue,
+	 * ub->mutex is the innermost lock, and we won't block for handling
+	 * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
+	 */
+	mutex_lock(&ub->mutex);
+	/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
+	if (ublk_queue_ready(ubq)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* allow each command to be FETCHed at most once */
+	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
+
+	if (ublk_need_map_io(ubq)) {
+		/*
+		 * FETCH_RQ has to provide IO buffer if NEED GET
+		 * DATA is not enabled
+		 */
+		if (!buf_addr && !ublk_need_get_data(ubq))
+			goto out;
+	} else if (buf_addr) {
+		/* User copy requires addr to be unset */
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ublk_fill_io_cmd(io, cmd, buf_addr);
+	ublk_mark_io_ready(ub, ubq);
+out:
+	mutex_unlock(&ub->mutex);
+	return ret;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -1907,33 +1952,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	ret = -EINVAL;
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_FETCH_REQ:
-		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
-		if (ublk_queue_ready(ubq)) {
-			ret = -EBUSY;
-			goto out;
-		}
-		/*
-		 * The io is being handled by server, so COMMIT_RQ is expected
-		 * instead of FETCH_REQ
-		 */
-		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
-			goto out;
-
-		if (ublk_need_map_io(ubq)) {
-			/*
-			 * FETCH_RQ has to provide IO buffer if NEED GET
-			 * DATA is not enabled
-			 */
-			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
-				goto out;
-		} else if (ub_cmd->addr) {
-			/* User copy requires addr to be unset */
-			ret = -EINVAL;
+		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
+		if (ret)
 			goto out;
-		}
-
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_mark_io_ready(ub, ubq);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
-- 
2.43.0


