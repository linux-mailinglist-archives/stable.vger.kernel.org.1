Return-Path: <stable+bounces-142024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDDFAADBCE
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A421170958
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E439B1BD9D0;
	Wed,  7 May 2025 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UPRJsuu0"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239578248C
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611269; cv=fail; b=HuYQG5WeD5s0qJzjFkWo5EwSRAe5vkQT9zPTZ81FeuZiicrMEVRsXf2kAzU5Gy49mREyna93pJo1XUcULKQyAZzEa4VX4DUnOAVXDokafcoMSmb2CrXT90YUKdhUfkEp5O4lrHjes7sN2qyodrttdhzVSR0830lyPLPi0J3B5fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611269; c=relaxed/simple;
	bh=7m8hQNQmO7Yko0lsvpaqdTNYbWbrI0o7Hl/5zsbVG5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GYXyjufQh8QYb2oSD6Ffv19zJLrDFK3LObcjqFNVN+QmfNkBmpdBQRZjBkth6FQioNCUFqtJOf2YhoTys8yS5J8qFmngvFzBkvLfjC3S5qfZ2GBQf9+s/SpYOhdryTa2g261wmZhh54LSi+ZK++4n8gkhYYvgey070Y+F1DsFUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UPRJsuu0; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjb0e51Usk14R9V7BGUBeu1+LJ1JXiQ7LB2GnLLbym2j1MwqP4o57rfdCkuDS3dOEHgTwJYvqyA/JIxn4wF2Ohx0gZgJXG7dnq1Oo8XkX4Pbzj6w8BEKmHkKFuBd9wFTTvTK7Hk58vL+p68iEwhsR+X4HWVjbLBSzRvcV0/bGyTHmv5Bx8Mq+aHrVYZCyzwS19ptIdJ1cocY29oZ63zKWih+8vbbW4xW/kfRQe5xdeyUNreiZZEIfH68Y0XUHsANxGaNhEAHSuwnhiDsymY3BdqUudPEx2IISknOophlInsIeiFk2rfOcNEsXzKYGpo3MgMgBnyGrFsO5kUn/s+kUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGR71iICYIb1EIQ04klAe43nu0ExMzf2tX1AUmoyF24=;
 b=pQoMqjngfUaEGeXbEOGLqqPaZcSp+rLtMRRMOQsDSZTA6nRMlPhJvPWA2tknohIHlFRhcHY3Uce7mlxXKO29FrpcJxwex65gKtgrsXwRW81LYeMIWZ7pTC3ZPPi99fJjIfvTpP+Fce1GksfmvnHKZYzSQCcP/LZS8sOMqjj8pD2+OvZsPtofYfeRV1jqtyN/a7yiUN2/8OxaUA9+PEB/vf57WW8uoyndpQ9FVq7xf1z6+3sTUOUOiqSm9zeOD8qj8Fl154qNYXNJtmTziO/jeVnEF5boP30iOUNO7dCI0MPlZ2a9boGf1NjlDfU6XI8YAe7ZSmbtrMyLrCZ6PTai4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGR71iICYIb1EIQ04klAe43nu0ExMzf2tX1AUmoyF24=;
 b=UPRJsuu084dSwNdn28wXUnOP+wwKg/RjjzwGyMiKAuPKwasRhlNyNGQBGyFFCiwvORtJ3k15lds3k/KMyzuVEFaDIGuLwhq32i8/pw/gc5bs6pdNtlyFuDrZNAqYPAfEXDelEq72NmZ5O3htjPlpw16Lc1pMv4meJzJ+Tr5lKtHEq0lwk9Sjvx7VB30ZYRB1l1xqwIB4/RqJgwS1ahiKnPOiWGuLamwEtLgm2Qtbtm6QxQz16CpRMyFJemcq4O5gULzgPP+dWk/nLGB48RLZXUbpRrKSAX09NOFYqCptd+SmW87EJzgj/xF2lHHppuqx6Q9ttx0J6L7NsQD9SjMJBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 09:47:39 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 09:47:39 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH 6.14.y v2 7/7] ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd
Date: Wed,  7 May 2025 12:47:02 +0300
Message-ID: <20250507094702.73459-8-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507094702.73459-1-jholzman@nvidia.com>
References: <20250507094702.73459-1-jholzman@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::10) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f804386-71eb-4f3b-2bfa-08dd8d4c3436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/zrBm7f91G9zddJ1utQzMYwVzojmfPOYDK4hLRiP89LWlveRvtb5YiodgvV1?=
 =?us-ascii?Q?3XRFlV+i1YXvhTnxEP6urSohOW1067h6kBGurAsN+UfJ0FxUJlfGc89ZiMCO?=
 =?us-ascii?Q?syoO/VbQ7mpwtJQ/n5aBFmQCgpjlPYT8ED91EyD0DPBy+TpBcg+7+oOOGpdv?=
 =?us-ascii?Q?57RpBKWvkmeSN7o5ccDjWWRYFdmRWaauI1yU1yikwZ8e8mzphsgYMLMwWKRO?=
 =?us-ascii?Q?8ZOPwy+uzq2URzv4dnsktVy0Wjv5KTzhz6T+y2cBE0HzM9FgSgDFopckvLtt?=
 =?us-ascii?Q?M9Cd+faXS0AAURv+Gm+XVnZpK77Eln/ORNQER2pJRMTT7751Et1RtbAXmNeF?=
 =?us-ascii?Q?u+A7JuENzncRs3/H6K/qkpd4Qs4yCG1Raj+tAReJhxyAvn/IG5sK1JwTZs7l?=
 =?us-ascii?Q?C240uOFOsX9Ao/s7Q5OEh+kILpx6OutVQfgT1WfROa3EHBBOlz7yziuOX9GN?=
 =?us-ascii?Q?VS7btSLCTTHlH/Se8rkhxLdrHXgmyg9a6IL4TEoUUddEFUNuhiQMAUChZ/Ob?=
 =?us-ascii?Q?3o117Ft3uwVAXTGt7FzcWZydsFozmZzgRGbZtKg8eGaY4S6b/MFTQ2eKLBKN?=
 =?us-ascii?Q?ETBRLlxuN+wD7bezdnHd5Waci7a3smdW7FKcTO3lGfg4ej2aQn4IbGj4Vfqc?=
 =?us-ascii?Q?bHn0YbdN2Eu57l0AkgypFlBwzd4HsspJOfYgmLa4eahDuzSMfWdfvfMdWmMG?=
 =?us-ascii?Q?yYWtQaHfbWpWXV0nP0s5vg89g0w6buFusnvEq7axAPWD5On5OkPHwwWnnoaL?=
 =?us-ascii?Q?RAbxd7L4uX1qdsGhJApJizKZ5XF+EL/lhLf2SoGV35tNqPFdQpQaTWMrfUlm?=
 =?us-ascii?Q?S/drxjMQEz1w2x6kpRDLTu3Xx3IH9qJEAqoPYZGyD80voa62XdC0aFBFpsGn?=
 =?us-ascii?Q?GWQEvrbiGEhcVkZBBy0yuYmsoLh/OcnfZj6ajZsqNS49okw89OCz+TbeYlZv?=
 =?us-ascii?Q?1hEFKAYPHIw+DyrZIu6MqM/eUverkBuEtgxMo9zZysxoIuQQRA0c9FHb6G53?=
 =?us-ascii?Q?tCdmdhUMBBJwbGfPuR2plaSyyCHo1FmW7s9lJa0CqEmhskn7oWymEu3UdedV?=
 =?us-ascii?Q?2QMNDgSVOiQQQ6rtmyYBDyN4vVTOOHsoXewY36uFtsPyA9xV/YwigD0YoaJ3?=
 =?us-ascii?Q?Il4dyQcGI61XIwNZlT8G0qI7vV34JDO7iRbiHP1EHZXA4OOlUUmB0b00HcWY?=
 =?us-ascii?Q?uc9X/q3dXC68EizZ3/SQZgX69Lued/OUEpjtgTkBYD0wI0RR1jKPR7ilY4H2?=
 =?us-ascii?Q?3U++hsIFYsSWHHfHhvQdL/er/W10p4xGm4oSfysBJzRuKNRlLVTuMiv/M9K+?=
 =?us-ascii?Q?SIhH2toyffqzgqgesZ5YM0YznctQs7lmhUbyAgML746b90pZsSRRJ874WmWU?=
 =?us-ascii?Q?UReatq/fm6A2ik36fr4Ie1KL2465IwgNHYPd84WlrR8aaQKynaIUczD/j2ji?=
 =?us-ascii?Q?pylKXwOzmFs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1kRikb/vfXn5GcsvhYMaz4TKzM37ubxON7i1jDylQZ3z2Y4elzfwNl7xsbmA?=
 =?us-ascii?Q?Wg7EhdlZKYZVNxFJvjoCi0yfSxQ1a456XU6JGbse2YMBLGRyhsL3b6ZOPv8L?=
 =?us-ascii?Q?MGtjZhVRZ/FiFi7P0zfXIG4vqU4X/Grpm6wCnhu4MrTyOMTqJNAiHWoRp63U?=
 =?us-ascii?Q?fKhx3on/zgi9OfZaj+EahTKW1aYaLk1hLzGKXfDrNHTh56MCJNyu6ZepaVk6?=
 =?us-ascii?Q?4S2goS7w4ZlFejcPEnmKYuHI5r0A/ihD+uIWUaHIdyRjVARMo/05F9x6cJ0g?=
 =?us-ascii?Q?U23aA2MFIh/FwapybX+RtdV/cij4ic0ZPIijOrjNG+ZlA6dqq09P1fspkF3r?=
 =?us-ascii?Q?MJFKy3JqRt9FqKyTTgAgUe5vYs3/9Yq04HyHoZXr0AU+8yoyfgnPR+FAHPGD?=
 =?us-ascii?Q?m4YGDWQusMEeBrJQwzoenDGKYVzsJaEEwPAD4HfgNpzppkX7kNQNnTgW1GcC?=
 =?us-ascii?Q?B8Ssl4XouJHv586HbjmlnaBIMF+dwDC6Q1HZUwJs0tqn1wqWA2Mrym+9JiWw?=
 =?us-ascii?Q?g0rrPQN0OwAH2Ou+cwxlE6ZwKgGnBj+MyKaD8VOiLTo4teMT838+qgftFAfR?=
 =?us-ascii?Q?qoS+3OaZ0HwI0L15i3jMFCxL5CbLXq+rwX2i8HKntKQ8sB7nBgips8w+EJgd?=
 =?us-ascii?Q?lw0BMd7pJ8FGOAT3Yk60bW/eiR88/QLbE6MoF21WrzvRjL4QUziPNwMtp9Bn?=
 =?us-ascii?Q?tzlVqngXZ7E5cC357Kb9ZsF24olT1zmJPzebjv8sVv6Dax77Mpqe2maq8kOu?=
 =?us-ascii?Q?AQqC2m4/rE3QGvaPkONhKdnZPbleuxftQSE2ykNxq+xHDvZLlIN2Wz9CWgf6?=
 =?us-ascii?Q?BAyce+t3rE7D7xwJw6EazMq/U47AtnJGTOAgLefwz3a/9PC5IYCBSuNwrzNN?=
 =?us-ascii?Q?TrQC4vc6YCgAJYhILpHdLOvzlLNh3rhBQngn8wJ5yw4F1ucs5S5o1s8nJnE7?=
 =?us-ascii?Q?scGrkkULQPqOMvjcrRDNpWwqhS1Un797SQHYy0ic4NvkDbNpJT7era1yh+CN?=
 =?us-ascii?Q?kZhimgBBAx9qUit1KWeOUdGfLcBwAI1vu6OAjOoMCT8ixfW1DOyhdJ3uLEnc?=
 =?us-ascii?Q?wcpSde/4P4wO6wmuCK6UBfJa86/5yAUSzT/FP8XL5qae3Fc93RN5RTjT/H4D?=
 =?us-ascii?Q?EIFHGt9DDNFyww97MT1nWFQLSbtNK86ofSaMdhHydvk1n8+2nfWafChprDQv?=
 =?us-ascii?Q?EegdCE1YHG6NSBnU+43Xsckbhf/JZ01pawsWIZiITI1MTX+0e3lb7igpYLVp?=
 =?us-ascii?Q?ht2M8uEG3dnpEw3YcRBgFtBlNPeWhqz67oicjaYqua5ZcBGnl8qM9HkzH/lx?=
 =?us-ascii?Q?lyWQ/xXZ8JZMZ7wwwp4sODFhigbZQ9MF/jjaY3TVX4nHAby/TABK7X0n4gOQ?=
 =?us-ascii?Q?IhSnVM9fgS8ysm+RsgTNumwDh4z5VEbDVCmCi+11H3h73Y2rwJnbmKwfyVPl?=
 =?us-ascii?Q?KCV0Pwi3uFqQdDi0QG9IDWzz+IJAIKiU3cY3tFs5uUHeozHNCmL1HypB4GHB?=
 =?us-ascii?Q?3DKUIYlMsO0MkOHLns0oZ9ZLVEg4Q/RGErgVZLaLNMq1PsCiWUcx/MfFg5qV?=
 =?us-ascii?Q?WcbRV5WznJXysRmIWN34J3pycNWCNVl5FVMZYeb0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f804386-71eb-4f3b-2bfa-08dd8d4c3436
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 09:47:39.0981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7ApI5WITanAK2Kvh+IWzUMN/ONevBjXI3Zd/QpUZFxYmkpzZkIKhKooZ2McfI8ROH9H8h8faJDEMANGZNVaPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit f40139fde5278d81af3227444fd6e76a76b9506d ]

ublk_cancel_cmd() calls io_uring_cmd_done() to complete uring_cmd, but
we may have scheduled task work via io_uring_cmd_complete_in_task() for
dispatching request, then kernel crash can be triggered.

Fix it by not trying to canceling the command if ublk block request is
started.

Fixes: 216c8f5ef0f2 ("ublk: replace monitor with cancelable uring_cmd")
Reported-by: Jared Holzman <jholzman@nvidia.com>
Tested-by: Jared Holzman <jholzman@nvidia.com>
Closes: https://lore.kernel.org/linux-block/d2179120-171b-47ba-b664-23242981ef19@nvidia.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250425013742.1079549-3-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6000147ac2a5..348c4feb7a2d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1655,14 +1655,31 @@ static void ublk_start_cancel(struct ublk_queue *ubq)
 	ublk_put_disk(disk);
 }
 
-static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
+static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 		unsigned int issue_flags)
 {
+	struct ublk_io *io = &ubq->ios[tag];
+	struct ublk_device *ub = ubq->dev;
+	struct request *req;
 	bool done;
 
 	if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
 		return;
 
+	/*
+	 * Don't try to cancel this command if the request is started for
+	 * avoiding race between io_uring_cmd_done() and
+	 * io_uring_cmd_complete_in_task().
+	 *
+	 * Either the started request will be aborted via __ublk_abort_rq(),
+	 * then this uring_cmd is canceled next time, or it will be done in
+	 * task work function ublk_dispatch_req() because io_uring guarantees
+	 * that ublk_dispatch_req() is always called
+	 */
+	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
+	if (req && blk_mq_request_started(req))
+		return;
+
 	spin_lock(&ubq->cancel_lock);
 	done = !!(io->flags & UBLK_IO_FLAG_CANCELED);
 	if (!done)
@@ -1694,7 +1711,6 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
 	struct task_struct *task;
-	struct ublk_io *io;
 
 	if (WARN_ON_ONCE(!ubq))
 		return;
@@ -1709,9 +1725,8 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	if (!ubq->canceling)
 		ublk_start_cancel(ubq);
 
-	io = &ubq->ios[pdu->tag];
-	WARN_ON_ONCE(io->cmd != cmd);
-	ublk_cancel_cmd(ubq, io, issue_flags);
+	WARN_ON_ONCE(ubq->ios[pdu->tag].cmd != cmd);
+	ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
 }
 
 static inline bool ublk_queue_ready(struct ublk_queue *ubq)
@@ -1724,7 +1739,7 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
 	int i;
 
 	for (i = 0; i < ubq->q_depth; i++)
-		ublk_cancel_cmd(ubq, &ubq->ios[i], IO_URING_F_UNLOCKED);
+		ublk_cancel_cmd(ubq, i, IO_URING_F_UNLOCKED);
 }
 
 /* Cancel all pending commands, must be called after del_gendisk() returns */
-- 
2.43.0


