Return-Path: <stable+bounces-141951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE0DAAD19B
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 01:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC79E1B65E1F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 23:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF11217F46;
	Tue,  6 May 2025 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eG86Pjgb"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C01FBC92
	for <stable@vger.kernel.org>; Tue,  6 May 2025 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574716; cv=fail; b=c1GLc11nC5en+VLT1DC1XPqpHVwy405hZkf53ZHEF60BV3T9lu1H1koKjx6sS4RkbDfzwUWsr+s5Z3bjtnAbmoKWYgSNyGarKoclu/L94nXAVl8Mt6KOWmYAuzsFswZFUALdvby4mWyTNJmV3NNGdK+z1euB/bKK7DaedjY2+VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574716; c=relaxed/simple;
	bh=txxv/516S8fa4cmnfTG97i2coU1vZShednlk7HPTcdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fe2jC8qJfJcGOaeMyf3NWyWN8A/Tr4lAUBlKQOE8TbnDFGCd8krFuB56hPnAQtd04GenBPqFl49jcKLXevS6vLJcAfoasdam4QO7Tnq/0yYELSYNJR+yHLlVXpKVLy7oSeChJbZEgR5TGxNEiqU9kSEp1twK7G2+9+CVhYkr8Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eG86Pjgb; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwMDsizJfKVhORq8sgONu2dchwVtrmavkyKMxV0pp/tr2LRWvupaCR6Ip2QxYtDOo7UOIemAOlpnORgXYDt/dwCAGoFu7W7SmmSey3dUbmKPrBf+hOWvai15OkTKDjTfyIV0Jugsbf+La5J//6RBmNWTGZCwWaZ6BLhjb+boCieQGHpDxHEc/m49t6UkoQmoqZCWSUpGxBcMAG+Kn+ODfFPRkX2u2Ovg9TVzyIg1h/q4D9t/MR727Z8RjqhHU2nJYM3cGeQUDp94+ejJ1TbEX3Q4yZkSfDEnGcSzqP/FoRCX2xC9ZIJ8vK407aid8sLzs+c9cRo0Qs8r1XVpPOt1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQZ/ChAU1Ux5SoZNhV5cohc2W2Bwy0IfQQ7fQ7Qo2RM=;
 b=NEGNbWja/0PGEl2QP4GYInd/V9ErSsK9wi0UchRoojGfTJ61fRL8Th3xzlQLfOWt0Uuna765WLMmtMzTufIeqPBTI2qtk9hLJAHnUxyQf5hoboWZM+3pdKbUrINtc6GBJW99oeVUvvpLsM9FomovzIwHNLV0MyC2wWv3HFOnK3DayfeLZ9OrbOfeQdfkpbxsNclaQGNRrcUPj+o44xRzHpzy03EVmRG5OhAz+kzaql9pFHKH29LCjX0whDkkKc3ZDTe8Eczgq4bZdErE2BTGKaa9pcsnZFfIaRD4zLp1Ceoov35GNLQh6wkYePOn4XHQ5foj6eUKHGckXZVbthg4CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQZ/ChAU1Ux5SoZNhV5cohc2W2Bwy0IfQQ7fQ7Qo2RM=;
 b=eG86PjgbgLOAxWsxbbsw0BasQU8wKCNp8gtF+U4Cv9DwspTiO1LOmHL/Iwa9Yp8IJ/nQufvvP/KV8FYgRq/AqQMoZ4GxCr+L0urhUIEteUF/wqmeMFLISr8F+IxYAnfe+XOhLNbKHo1OTnrnSzt6n99woCfyNjNb/B6zczUgdKKJjb29qbCIysVne3NjsWtf4GiXAyQQuaEFLvb/xWcTaZj8wnIj7TLgLY7Nn2JtKq/E6+OCqQJuM+K7ED3FJ5W/YkiIvyJWY4SnKZBidAwYsBOz3g1Mn8hnZA6fkYTS6QtmKLgv+YGBS+073IktvgDFpMrBufZURt2dfHAH3oUojQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 23:38:28 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 23:38:28 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH v1 6/7] ublk: simplify aborting ublk request
Date: Wed,  7 May 2025 02:37:54 +0300
Message-ID: <20250506233755.4146156-7-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506233755.4146156-1-jholzman@nvidia.com>
References: <20250506233755.4146156-1-jholzman@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: cfec9346-73ed-4ff0-d924-08dd8cf71a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z/tgFHXs0eBUW5QdG4PqQ4I2x/vckQZ6TKahBO/3jxOheQHN8CwXxqtB6LaV?=
 =?us-ascii?Q?1u8hOwSqBr8sWUuCuzfxK3HtbZ0vGE2hIq99IY/G1PETXtDLmzhzL2ZmxAHt?=
 =?us-ascii?Q?L8UWtkOvU0UzfknE3ayqIyC4DtMx9lSX49ou1vEQO6dRsqBV7uXwT1k200UZ?=
 =?us-ascii?Q?/fDmUFyD45zHALXzeoS01ixRKCOK8i95s9cQ0zzk2BT/2x59CcI2x8iiS5Zb?=
 =?us-ascii?Q?WbcWjY7Gx1f3iialHWu582xRC0UtMOi2pRm+tfTuo7sSErxnrau0WZqH4PcC?=
 =?us-ascii?Q?f1MdOvfduqJ/5Ba1CjJ/ErWT0ee4XowXLqcesROSKXYErJksNTsJYMbTjxDB?=
 =?us-ascii?Q?wcPsLbOnSFZwVAW9I5f2xcccVzcf1M2nGbM83b04Phzg2xpdgxfHh7WcB4Os?=
 =?us-ascii?Q?Mq9SBWgpQ3fRDOYYXBj+A12+dHeGil7Q/6DMUQZpSVnjBaUucdIHony0gCjA?=
 =?us-ascii?Q?lo4VP1WiUaUkbXMjrrPeVcoZQ3CkowSOlG3o05ktYtYRMcxl1XjjBhzvqNYM?=
 =?us-ascii?Q?+ynEnRaaDDvKYPo+fdgLPTUOoyViXX6SKvddSlfNCU7bhfqXPkwTHv0l8uOy?=
 =?us-ascii?Q?B6c+vavi0AN69fQGhOD1MRztShyW06osPV020Q50TluUoGQL47hagILjU3wc?=
 =?us-ascii?Q?kRD11Vtn3hRK5gCZQTKW0xqNS7WiCc4vP9u1gRir3wtvvpk/1/Sk2N4QS7sR?=
 =?us-ascii?Q?P5R52RlOpZz0ma7WbsUaGM0iU4orN6JpHytImlhd9yHSD51H1Wqu4KDQAKWu?=
 =?us-ascii?Q?CWvCgG9dYBbhgO5nfS+PWAacHT1C/VUv2lcpfcQuuc+9OVJbla2guA1jNJaX?=
 =?us-ascii?Q?AxLu6eIjc8BQve9gWEq0R7B9pW0fj3ZZWhmdBqQe89eEbBY5D6GaXAvDgMge?=
 =?us-ascii?Q?XK1fJeoOULlhHtk6UM1WKhqGUlGbwOSqsmJHBPkFMutoO1pQCryLIiEOF6yV?=
 =?us-ascii?Q?E9wIwv57agzbda9k7izOGr5oxYnzbqOdM4pkWbAlJc9Mu6V6zHWhnywjCknD?=
 =?us-ascii?Q?h7i/qjtTbbr13TSoHGw9RsgVym5briXjUoZq9X9kq0zsNkM8IDeAjl8b1N0h?=
 =?us-ascii?Q?14/jWj4oNgG532ZCeR/riKfttAr0e1V6B+MbNea6PMI3iEuyIFA+jWExUUoV?=
 =?us-ascii?Q?boHcn8Qh43k6Ibz6nJvSR61LSlh9IbDokwB1tfB+aWIbIzV9vyYGvs/CqDP3?=
 =?us-ascii?Q?QwHKkx1+SXNB0rchRp9ZAgoMn94P90OGjLCkdr13w5ib+4XkjfikF8navlXd?=
 =?us-ascii?Q?uBvxTte0B0jb6La2sL6ptPFGtoZPh6VhW4m5W3Vqz6qC2blaqxh+/8vzv8/y?=
 =?us-ascii?Q?QPGtlVIjnwDybb7aroJUZMikKmfuy6sK4MwrC1Rzo0AxCvNsnKCJdJLEwd5a?=
 =?us-ascii?Q?PkIYlrkY+bWj4S7xz0tcEMgZTEqJYRrKA/8/rrh7Z+D61Nz8sEeY16M8+ZBR?=
 =?us-ascii?Q?jTqdZuP450o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oczFF2NoZ+8pS/y18sVqy22jzGyr3ipmlX5mYBwEmuMO86Go9yhHLe3FA6PQ?=
 =?us-ascii?Q?DnGmdIiG1j4+xoI9iEPQELDZYdzJIzWVL38k/SL8LZoP2AnLwWtY2p8Da/Jw?=
 =?us-ascii?Q?P2YRwEqsr1efTNwM6tvmwfTXY4koLkytIMiUHj5Gyc+vfmyuGZO6dPXWyHpm?=
 =?us-ascii?Q?eMjqIDWmupPE7DUyPzuuG+C2qIwMSSNBMQbgIbJiRXet4UgbmB62AroDZtHl?=
 =?us-ascii?Q?66QEmhBtS+GoR8LIxsYSGY6mU7JFK28yuSomYYF31sT5/1RT5yTcwSAv3q/i?=
 =?us-ascii?Q?5yKCnfE3A+Xz7L9pZFaSuaLGsVijzLmVbTL59DbbVDHERuDEAcLBJpol/mom?=
 =?us-ascii?Q?Lh5exKrRUGDHeFJ/Gvn2FyLml3NjHWBae5psWn4tikOKPabbA1F98iZ+6+vy?=
 =?us-ascii?Q?xjkgRfWfR5Jd8Kce+4cADnoeg/AIjgr0Wy/AKGKe3IekvSZ62xr/7mJ15haA?=
 =?us-ascii?Q?5JFFwUDYdMm32diA6hgZcf+cG9s4sBFST3JiUQwK25EUpBLlbdBN0U6X27Jc?=
 =?us-ascii?Q?EOHXIhAC2bfXC/AB3BDfF4JUhB1Its9TOF4ZBRz+JyVXRhXYAe3LGp1495Aq?=
 =?us-ascii?Q?oYnpBy9ta6fomnSb/neb2Rb+RwRYkH1p3LMOhXFgNC2hvn7d2eGjxjAnewGk?=
 =?us-ascii?Q?Sj8BNDG9sx/9SGuOZM54dKnB9no/UXsHUaSnZc5jPL6r1tURsqk5g8mgGUCX?=
 =?us-ascii?Q?XHG9M7u/GO3x2LfVpZAkfW5RpJLFm2RgTFPEAeqhEpZJ4d/YHtWBqgI5fxrj?=
 =?us-ascii?Q?W7WpUKRHoFXCOG8CxG4eePJtzLZupYEBhIlGp3Q7IG0n2q4dB0OVOqGMGP6P?=
 =?us-ascii?Q?Y/ovaT5TK/BVx4t8RxlNs2xsvJNEROSmyIH06VeeLyCj9aifjG1woULe/6zR?=
 =?us-ascii?Q?a3X3t6lA2umweCAY/Uw4EIFxblF5rJJAYkr2SBER5lzeaKiUa6FOTBPqIs/n?=
 =?us-ascii?Q?0uVQNnMhUz9ErH/v9JYFDaLLuqBNEzsEZZpnoKpKSWMZy4MoZII30t/9Ftka?=
 =?us-ascii?Q?A43zjABlVI+zxFLZXUFBypDANhPlzZM+kprqMpSKHVr78/qWPIuGFOEHoLnw?=
 =?us-ascii?Q?Ek0TSFI3wjMK66RuV22OtNrpwXteBmxcyeAPi2sviRwisSg9N3LRYumzO5OO?=
 =?us-ascii?Q?mb7z36cORH5EiAR5aUv29fXCOLr8ZFWtB9f50A0pKxfD8/XfeMbZCeJsFCi5?=
 =?us-ascii?Q?T1HTO/3pk6c7GqBbh0QGnm73q5sT512hfDfkGkP+KwyWADuNjWWZyHfyqMXU?=
 =?us-ascii?Q?2Ldznn7lqHeTR48dM3qW1oUKNqoOk3AWsdwH0kgZrLC0uRgabuDXsN0eGqKY?=
 =?us-ascii?Q?B8vjuKTWErne+EPQVs0eote33DMqhTdRUz0AgOa+WCOMu6CPJwguldDcCsbh?=
 =?us-ascii?Q?JBu0T1R84v3PNlCHpubKH3nfn5s29EUdL3jS7Fe8FU+L/5jVnELiB2jLI251?=
 =?us-ascii?Q?dEBd8sUK+5wVXv6C+GTxpDrmMaXNxi1LDLjI3W4vm+EZRMkbYCwhbqTL8RV5?=
 =?us-ascii?Q?VxXxqgc7xfAJdOpLzw0Z92woBtE7KRH4E0OUZJmWr81KUVrwJWw7BR8yNOtO?=
 =?us-ascii?Q?zDnn0zDBwZnsuWrWBFrd1hv3n0NY75qGy3uUqbcA1lsKz4h1BIOg4nk3OFcn?=
 =?us-ascii?Q?Zc8RR/uWLskS0a5BX5dD8sj02+Ae5O2nG7kyjCyQsjiV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfec9346-73ed-4ff0-d924-08dd8cf71a40
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 23:38:28.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOl5h1BsIZeMU/GrDZovqTr5ZcSUpe/CbOaNyxDBTgOiIp08rCi+8L4FWDvd5h91Q3rJuDjvdAqdJbG4X6Y+YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

From: Ming Lei <ming.lei@redhat.com>

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


