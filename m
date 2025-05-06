Return-Path: <stable+bounces-141948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5995EAAD198
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 01:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410C81B65E94
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 23:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1EF217F46;
	Tue,  6 May 2025 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oQrmm6oO"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA81FBC92
	for <stable@vger.kernel.org>; Tue,  6 May 2025 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574704; cv=fail; b=n4IA1vD+6K/gEvrXq+eYnEVUtRfF7y7sUhm05f+HejvsMbG3gr2gRtlsTn+kwxkx35r3ZCp/QLszkS5jmEEnrdjukIITdpKcYzpQDiJNefq0xOGIdxbdarsxr+RizVmWNchUoPK01zYyjqRnhmpHVQwx3n9gYZ7J8avtMV1Dz4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574704; c=relaxed/simple;
	bh=LuJ1QuAwccjFuZ8QGBWhAZYe3H2r56zQTkhpaDf1iW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AM0RpfxXCuqqf5b7GTK6F5Jgg/tScR4lk4Xf3rtBuu2MgCWWbuUT9wfnoXZm/Tzz8OKUeIqkthP3fTOUamhOQbCRhoIoUn8YbyfBeHxC83emQBFBKplxHIYvIYZLRdTB/nYthT+Ok8lraraBy0YD4WSrvUl0Ay0XfLnD0nY1sb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oQrmm6oO; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUjq/2UpbC3F6+XlAPpGCCLmfAGNwSC41YJujMCyg/yLjN6pvfNoWIug5av/4vdbidTcrRwcvJMougpY+Iqa03VS1eSaKCBz9r+LyC1zf8b7YgabiRsq+c6rWyi+cbzl9cqCGu4Ni/ASDE7hx/hAgYcoXLgODZM+lPgzWOq9BzMkQWweEnU1PmDfbaBCxxkzof+UE8tfq873NUWQUN954YkUhpRRs4oiJbSA1vRSHKuJuGeQ24yrKICBLrMIpABeO0pU2v++FAzuqOhaN7n/5cDRmSBX9wCnC3+kdFblV2GjjR/4f6PmSDbqp8olkvvfUMjADjEmzmnRFM5Q3lRbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGCuNtmBjQZXurQSMOSKshXvigGa7hFNQc9tgW/PeGI=;
 b=FShpFe+q5R9btaktD9Sw+MqhQMfkrGM2gBVK9SI2vE2MMWhD7v85iPFUM1hwqSc122C2WHFJd/5c6CUw2RoVd4jYwI72XUZAGC8biB/FtJ4Mj/3Chu/QNLU25BZnfDmDihA92tsmNuy6UFzUro7kM4Nsgm0EqchH/ub0P82QJiBEIyfSl7cv+pG+P0Y44TIYaUsxkl4o1O5VZl0eTWr5zWd1Cz9z7+aEar0z6dF2T4M5C2ycKXnmq2ehO2gwRxX0C2gIbLBa+dg0+wB4vEFHIthlz7a3vNajTGNrlQOk4gD+KnocOJEL9k/hMgIQPAcF7lqUqfJ5RBdzvaePQg5c9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGCuNtmBjQZXurQSMOSKshXvigGa7hFNQc9tgW/PeGI=;
 b=oQrmm6oOydghZ33+QEn/JG3qFGtpp93DLwxE7Qtfach13qRg3gfZn77pu5PcmPwckP2PBracb+ln9LfYjqVl8FrQ/k9faghZmoB15zPnMvY8bWGmwys+tJJIUHCmkWqrwncAyYEYvUlqa36B7KKI4Dd+pwSqhm/zxYcxCB5at0Tyop5RpGDQHmwe1is8ATCh/eYhHE+o3OVzDf/axO8v8RtDLHAqWR+FHMI5BiIAdJzBgXQKoj70GiP+WPCZmtfs0xa9oo+zDoKPnroyTu+3q+Kdyowtm9cA+y+2vPWqWZjYFoIeGBrXR93+Oh5WqMcHNcT5zDKR4VHDtkWfYppTIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 23:38:15 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 23:38:15 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH v1 3/7] ublk: move device reset into ublk_ch_release()
Date: Wed,  7 May 2025 02:37:51 +0300
Message-ID: <20250506233755.4146156-4-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506233755.4146156-1-jholzman@nvidia.com>
References: <20250506233755.4146156-1-jholzman@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 1150aa48-4dba-4631-57a3-08dd8cf71281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FniBYxFITdhZc+LFDfQDdxY+o4FqR3gvU6FFIWOoWiodzp9TDSGF2ROwuKxX?=
 =?us-ascii?Q?M9uYPYznvc7xDeH3wsSOCKHnb81gLreeaAgLcz/oqBN/YUJxTf7o/HMf+aPR?=
 =?us-ascii?Q?lbuX0SHFTVRfz35iaXhzsWcC8Y5spZp9WTfhm87XceDD3bWtAxqrLesxhGdX?=
 =?us-ascii?Q?Y6RXl307xCa0/WgZ8PGyQh0OMI4fIwAORiMMKKrp5L2YBQo1w+Gw+R1qM9e5?=
 =?us-ascii?Q?pvau6m7leOB5JlZ/u6u5ZqbkCoV39jSk8IYJ7VqCrzZnSe/ctYBJ18Db14cA?=
 =?us-ascii?Q?RT9j1o0QGP/e15/Q8iiEnot4mYjD+GvHAf6avDHbfs0hh3AFsxlFCN3jCivI?=
 =?us-ascii?Q?Dp3TOH5TFTykgKgGu2SZH947g8b1IOJkcNEcR0KGvgZxiu9fJwbMQJRkJ1rq?=
 =?us-ascii?Q?Icy4Ua+wnX46+fYZ4gL93qCTiuz6/Gp7BgbD3H2hBv42htSKiUUN4oG63frJ?=
 =?us-ascii?Q?P6pZsTU8bDHDj3dASO95CBqvgdzIm7547FcUNCmad5/YKU/4FU+gGJR6BltP?=
 =?us-ascii?Q?u5tr95oTSshoz9sSq4hLfD+pVzsSz4p39Td++oSwWtYezSIlXNxvNj572+Hg?=
 =?us-ascii?Q?7q9Tm5yTppxMJlYc7l5mGog4xQv0rVum/7NofVLi7RSsZZQ5WyMxW8dtYSsR?=
 =?us-ascii?Q?EIHBNGQ7g1T9JEeLiDdh0eh8iRTl1cRKG5epjphOAZKaSGrmkWMs6cilZXE2?=
 =?us-ascii?Q?SicFphmL5tm8c6WI06TC1J2aZGKTVkOJNrn8p+fklLk2GoXuBRejtAlFCYSS?=
 =?us-ascii?Q?DFJLO92yH0sdhCe7loblLSI6XftfNh496G4akAiUJYEUAScFsTCq3Smex2uP?=
 =?us-ascii?Q?ObEkFciUuI5+CNZ7hz6diuNgKFJlUAOuQm+Xu5jkfNzvt7UJwN6avw06MZr7?=
 =?us-ascii?Q?bAcHkoSQvnGsYMtK+ceOp4k0hkx7kCBMbetPzmPEnJ9dlCBHyxE5zPmpKDBQ?=
 =?us-ascii?Q?AeBp2eMehWMNK2SdHs8bQXWuoPV+DvhBPJ292ZXTRVaOgpn100s/h+6TrcOC?=
 =?us-ascii?Q?pXJuNfBLz3E8r/bPYfXgfYDZ5CyjyHslIRBB6LUF+j+XJeRNIZXZkePFZVBI?=
 =?us-ascii?Q?zLXVvO3tO6oFBIogezUDRV15aqSfP8Wh4sMpT98jITtXYiwE68OcowfWQEC6?=
 =?us-ascii?Q?Wcr/Di5aNS4nvh3Rush37Fm9tFx9BCaa7O7/lanlt3RlJbqw4ezSTHCr3P40?=
 =?us-ascii?Q?SmQ0PMQRaZ0y+f/NaeC9TKSisQWPYrnaQlVqTTHcG6w6dUFQ6Ie7duIcaPNK?=
 =?us-ascii?Q?+w7sC9TSYjUDFlVsQ0d8tCmrz8rE5DMmeQkpIiobUPuVnie1z//6KeYyXh63?=
 =?us-ascii?Q?1ta1sn8cV9mtX9/5/KomxBcdAI/1sQoJJ8t7Uv+CqPLr01cUBdRVeHx5XZo/?=
 =?us-ascii?Q?tJUme/Pxm35yHIkVvpnQhqbJsuPIKi1ZoAiP+i8Hn+WGrpMuT3D+p0rqG//w?=
 =?us-ascii?Q?d1ELxM0HdIc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TL8dSu2RUBzZK5ZHYAz0sKT56V6hS2eyzk7KkVjlNXJEaYp0GwCspB/LjEHd?=
 =?us-ascii?Q?5Ny90GRMZhFEi9zX5gT2n69yEr3HvNAay2Scu0j8BEGK2XbAAcd+Ps6oQ0OI?=
 =?us-ascii?Q?UC3W/Uzbg2aq3+l9O+CequqxohMI4mSR++VGvO2LyoPhNT2JRRUFvoE6FaGw?=
 =?us-ascii?Q?jL0zXw+ji9dABu1o/ZeJawKHT6EV58TPVsIgyy3VS9ARqODIAH3Ag39PmfbC?=
 =?us-ascii?Q?CijTaeG+0LTrfUBt+gv4jYzXPYvihvCSs4PO3JuBZHhMl/2VpkuSjs1M0AuN?=
 =?us-ascii?Q?pq19MVpxDl+nFTTQTtKkmIWTOCpaAvbTQLEmKaZoPq959U42Q5eYQQPxbeNB?=
 =?us-ascii?Q?Z0uhiVRtZmOPYR2s3SjAAIyD2qosechLVAy5RLKw57/IS2jPFgyS3BEyTugO?=
 =?us-ascii?Q?4b4RJ/CF0IL3DQEFLb/6yGurcdQ/UQxBWutoNf9i5hnrWoO/F7f9BN1OYNRL?=
 =?us-ascii?Q?8S8nPMsY9H288TxQe/7l2E3WU/xd6E0RWHKZr2SPprnolHcpgxo4951sM0I+?=
 =?us-ascii?Q?CobfRym7o86ATbINzf0iXmUg8pq7plwFnwDpraoKYYqMV1aIgFOKxuPT2Iby?=
 =?us-ascii?Q?qa3qu7eT+FjchO5DONH9GSC14S/KgFbuJUni99sJj+UIjR9eHhlnzwZzBFWt?=
 =?us-ascii?Q?w4smuB9c0KfQL2Qtl3hblaYDR50UOvyqmYy3KDlxtfi2Fl95+UbehIEb7+3G?=
 =?us-ascii?Q?gwZ+ZBkaUwEzTbYNhcwtTABQ3hDUCdM1DgAsq1iTFbKGqX62cpPwFReQhmnL?=
 =?us-ascii?Q?UhFXQ67oqG2L4rll+gJpH8aNnY5lB7fLuDEtyLPXNbB4gTXCAz9iAcplXJO2?=
 =?us-ascii?Q?UDkIhMD0/mgfJtjwkNX5pB4e4J+ERuHA0zRcKPqt/zMLe3siujVwxZUL41XE?=
 =?us-ascii?Q?HHgaFnk1HxM9a7Upq+mmG9/sZFHNg1fmDS5r/10mXGXt+2UMlQNL1DC8Z50r?=
 =?us-ascii?Q?Cj9+4f01e0ispTjOBOBbX3E5pSEwr6Dcm/ft8J4HndQxXS8/bruSIcpFhPE5?=
 =?us-ascii?Q?pWXzdBMbPrzvPbjkRqskh71kc4adm7yBP9ifSJgVV/Hjtp/4eCQ8ZghO8gVg?=
 =?us-ascii?Q?201ygluTofT9eFYSSKZzxcGqeoYRYL/JqD9m1ooYUD9GvVQGs/SX59pWsU/t?=
 =?us-ascii?Q?12CeDkXgQKs3ZAbi7iiW5+C728jsMd9PxgsHBSxYvxqkcW29c1nxDB5jnpV9?=
 =?us-ascii?Q?Aaz6/omKEW/v3XKdOGNvot6JpM5fD1IHE7EnaYG5FAeZoaDfTkGzF955ioZa?=
 =?us-ascii?Q?30EqyBpInvVjuZKT481M9oUuO6WfRvAfpqbCIoTFOP1NjhQGN1HEizjth5D/?=
 =?us-ascii?Q?dt5DbIdwe1vgcpDj4Lbcn9/f9D71sMIjXpCF0HWN9kx1+cFv2PgN4EKAP6P0?=
 =?us-ascii?Q?DnjERYOYPTO6JAnv/3l0HS92lFrSmqowy+4fdVjZ9Ru0xvWIfkO42s917QAY?=
 =?us-ascii?Q?BdwCztzv9i2J9bBEgdbijwiAQMz7z3Pxxc0ywddQ+dk46iILGWeOw2MgoJrV?=
 =?us-ascii?Q?Y/M/AUit/XJP+LQa7GjHHbJp3kerKQJi4A5kRa6xf1QYygePU44dnamikL8t?=
 =?us-ascii?Q?ca7y1VCibiknit9czd3+VswSb2+8wWR5KImwddivU1zQWzerUS8JI7pOtbzO?=
 =?us-ascii?Q?gyiWL2mCGcisEvb2x13nDUaxqBUaIymZ+x1Kbdcm4un+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1150aa48-4dba-4631-57a3-08dd8cf71281
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 23:38:15.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlHrHnNAatj0Am0qDCfwh0UofhrJSYY2Oc8rwkBEjRYpjD496HdPqTDpcoj4vi0BNmoei6IbwV1AQ+ImkrX+/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

From: Ming Lei <ming.lei@redhat.com>

ublk_ch_release() is called after ublk char device is closed, when all
uring_cmd are done, so it is perfect fine to move ublk device reset to
ublk_ch_release() from ublk_ctrl_start_recovery().

This way can avoid to grab the exiting daemon task_struct too long.

However, reset of the following ublk IO flags has to be moved until ublk
io_uring queues are ready:

- ubq->canceling

For requeuing IO in case of ublk_nosrv_dev_should_queue_io() before device
is recovered

- ubq->fail_io

For failing IO in case of UBLK_F_USER_RECOVERY_FAIL_IO before device is
recovered

- ublk_io->flags

For preventing using io->cmd

With this way, recovery is simplified a lot.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250416035444.99569-5-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 121 +++++++++++++++++++++++----------------
 1 file changed, 72 insertions(+), 49 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9345a6d8dbd8..c619df880c72 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1043,7 +1043,7 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 
 static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
 {
-	return ubq->ubq_daemon->flags & PF_EXITING;
+	return !ubq->ubq_daemon || ubq->ubq_daemon->flags & PF_EXITING;
 }
 
 /* todo: handle partial completion */
@@ -1440,6 +1440,37 @@ static const struct blk_mq_ops ublk_mq_ops = {
 	.timeout	= ublk_timeout,
 };
 
+static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
+{
+	int i;
+
+	/* All old ioucmds have to be completed */
+	ubq->nr_io_ready = 0;
+
+	/*
+	 * old daemon is PF_EXITING, put it now
+	 *
+	 * It could be NULL in case of closing one quisced device.
+	 */
+	if (ubq->ubq_daemon)
+		put_task_struct(ubq->ubq_daemon);
+	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
+	ubq->ubq_daemon = NULL;
+	ubq->timeout = false;
+
+	for (i = 0; i < ubq->q_depth; i++) {
+		struct ublk_io *io = &ubq->ios[i];
+
+		/*
+		 * UBLK_IO_FLAG_CANCELED is kept for avoiding to touch
+		 * io->cmd
+		 */
+		io->flags &= UBLK_IO_FLAG_CANCELED;
+		io->cmd = NULL;
+		io->addr = 0;
+	}
+}
+
 static int ublk_ch_open(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = container_of(inode->i_cdev,
@@ -1451,10 +1482,26 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static void ublk_reset_ch_dev(struct ublk_device *ub)
+{
+	int i;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
+
+	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	ub->mm = NULL;
+	ub->nr_queues_ready = 0;
+	ub->nr_privileged_daemon = 0;
+}
+
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
 
+	/* all uring_cmd has been done now, reset device & ubq */
+	ublk_reset_ch_dev(ub);
+
 	clear_bit(UB_STATE_OPEN, &ub->state);
 	return 0;
 }
@@ -1801,6 +1848,24 @@ static void ublk_nosrv_work(struct work_struct *work)
 	ublk_cancel_dev(ub);
 }
 
+/* reset ublk io_uring queue & io flags */
+static void ublk_reset_io_flags(struct ublk_device *ub)
+{
+	int i, j;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		/* UBLK_IO_FLAG_CANCELED can be cleared now */
+		spin_lock(&ubq->cancel_lock);
+		for (j = 0; j < ubq->q_depth; j++)
+			ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
+		spin_unlock(&ubq->cancel_lock);
+		ubq->canceling = false;
+		ubq->fail_io = false;
+	}
+}
+
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	__must_hold(&ub->mutex)
@@ -1814,8 +1879,12 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 		if (capable(CAP_SYS_ADMIN))
 			ub->nr_privileged_daemon++;
 	}
-	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
+
+	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
+		/* now we are ready for handling ublk io request */
+		ublk_reset_io_flags(ub);
 		complete_all(&ub->completion);
+	}
 }
 
 static inline int ublk_check_cmd_op(u32 cmd_op)
@@ -2866,42 +2935,15 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
 	return ret;
 }
 
-static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
-{
-	int i;
-
-	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
-
-	/* All old ioucmds have to be completed */
-	ubq->nr_io_ready = 0;
-	/* old daemon is PF_EXITING, put it now */
-	put_task_struct(ubq->ubq_daemon);
-	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
-	ubq->ubq_daemon = NULL;
-	ubq->timeout = false;
-
-	for (i = 0; i < ubq->q_depth; i++) {
-		struct ublk_io *io = &ubq->ios[i];
-
-		/* forget everything now and be ready for new FETCH_REQ */
-		io->flags = 0;
-		io->cmd = NULL;
-		io->addr = 0;
-	}
-}
-
 static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
 	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
 	int ret = -EINVAL;
-	int i;
 
 	mutex_lock(&ub->mutex);
 	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
-	if (!ub->nr_queues_ready)
-		goto out_unlock;
 	/*
 	 * START_RECOVERY is only allowd after:
 	 *
@@ -2925,12 +2967,6 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 		goto out_unlock;
 	}
 	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
-		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
-	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
-	ub->mm = NULL;
-	ub->nr_queues_ready = 0;
-	ub->nr_privileged_daemon = 0;
 	init_completion(&ub->completion);
 	ret = 0;
  out_unlock:
@@ -2944,7 +2980,6 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
 	int ublksrv_pid = (int)header->data[0];
 	int ret = -EINVAL;
-	int i;
 
 	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
@@ -2964,22 +2999,10 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		goto out_unlock;
 	}
 	ub->dev_info.ublksrv_pid = ublksrv_pid;
+	ub->dev_info.state = UBLK_S_DEV_LIVE;
 	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
 			__func__, ublksrv_pid, header->dev_id);
-
-	blk_mq_quiesce_queue(ub->ub_disk->queue);
-	ub->dev_info.state = UBLK_S_DEV_LIVE;
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-		struct ublk_queue *ubq = ublk_get_queue(ub, i);
-
-		ubq->canceling = false;
-		ubq->fail_io = false;
-	}
-	blk_mq_unquiesce_queue(ub->ub_disk->queue);
-	pr_devel("%s: queue unquiesced, dev id %d.\n",
-			__func__, header->dev_id);
 	blk_mq_kick_requeue_list(ub->ub_disk->queue);
-
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
-- 
2.43.0


