Return-Path: <stable+bounces-142018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8419CAADBC8
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0F8982F96
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA091AF0AE;
	Wed,  7 May 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N5iupvnb"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671672612
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611241; cv=fail; b=cWT2ZIivfkCnYmQg4dYH+cDdoyBCNJWNGaaqArtnx9Exb7mOUdvwD8/ffVmWHnjBQRqXXSAScclgjuJ/Qx/XBicJAwiufCV+q50Y47DKLZH0/uq2dqlzfRrJboO02HoY1TDaCeaZ3rvbeB23pfTIQ+l8hHBxfy6BfO06VejmYyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611241; c=relaxed/simple;
	bh=eGn0t8gkBFmb/3wRYsP52GxSmsYD+CSzcM05W69kkkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FYmZ4UWiQ2dG1Ie2+dtnkRkNhns1WElzudSniHdtkQFEEwAuvrCEoME0EAapDFPEOrB8KQC0psuStONA8nrLLXLR08fKWiB38C/PQOxSx8BDeeSdqmyLg66EnvXcvueHZFm9kkbPD+T77RB9BiziHGFWj8hUahgzBhGOuzZM8+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N5iupvnb; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RvRMNAKuQEiwK2z8FTiDD3DPDMFV0aUi08GbWG9bQpaJXm+QeP0800CpcEIdcLPXUJGn68YNzUMT0J/Tg6XT7bYVMXMmRF2wcHIyUGbYJyFqz1g8unEnN7lHiQIasbj6o8cnvEaN4pQ8fK2Jm8RcIyM+Hq46IEKYTevGB6aLNlmKUhcrxcai9uzdEInpVumWQZC9HUns8tcDWndeVqR/N2f5znVecT7dj2YAvCdtRI1Yy5iIFyeodJ2pdkCKYVVTdYYiHDST37v9LKrlgCSRaYzbO64XgOBWaee52qpuD8YdhYIn36YCOy8sYqMJnw/S0HaCZQwWa67khZLz/VCcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPI+pT0AA9Bz9Wtnx8x24IYVKJkKqhkmAln9WTwpZS0=;
 b=q4absXBHSLGqjSx70HnjufDEpGH3JpO/xFeFdSC7zNnFIBVMNIUe3xvsM4vUlmXU55tky4bt1OGlY3zvzm8LDxm0yNBuMmxqd8dwyrw+wrlIGAQP3Lsd9PEPM9ceScGANEpRu/JrL0c9bxET3RX3lpnAz6PQHwvGUTG4YYty0kQA5Fia2Xa0iMYd30eDeplzFeoczEbQNXMq0NMWUYqmq7606ovtCtK558uKGL5wkPvr6R8vRG5hQBmAqJzt7i+CFMbB3GH8nyYpyasWuuJzOdQ9Uwp5Z4UWxyFmncp6BPOa9fDIAQwjwSYlZJPICUVw75Ut0t4cRn6kFn88cPaVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPI+pT0AA9Bz9Wtnx8x24IYVKJkKqhkmAln9WTwpZS0=;
 b=N5iupvnbBfXKuL1ujUNQMSEdUcxH7aTfaS/AiY81xW+1iwamn1pa+Y/F6BiGaIl9RRfTvaZT1WXoSosTxz3wJjHNG74GgClYa9vy+2tH5TJyTuaIopyC2NeqaQw7EyNWw6otlFDtVYcIm7m+awE0Jez3KXH1I7BO68Po8wFKPm9edFm33cpeEvizfJPBcM+73M1JMNjDV73/iaTBCeuQJ2rkybL63HZOXBWseeyQpPL8N+CAwChIIw9CQGb/2eOuaKHtn5xRc8qg+wvBcWt6dasbGqdkxnZK8o1stId+VpD/9+x7qZycw9Nkl6gAdG66nmqFRUhQomZj2FHbqexgQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 09:47:11 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 09:47:11 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH 6.14.y v2 1/7] ublk: add helper of ublk_need_map_io()
Date: Wed,  7 May 2025 12:46:56 +0300
Message-ID: <20250507094702.73459-2-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507094702.73459-1-jholzman@nvidia.com>
References: <20250507094702.73459-1-jholzman@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::17) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 017b35a6-ac4c-4a29-d7ce-08dd8d4c2393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5v+6ZITPxLnkP5oR8sImLnKf/T9Yw0QvWm5fUzNjiGeXu2EpTC/Dt0gF/1Ei?=
 =?us-ascii?Q?h22SJ/JjiSk+kxBR5utxmVqlwpCLvqClpzcXxhrcfc8qIx2yvMw0RxICD0cu?=
 =?us-ascii?Q?1K8bPaxqECbXgiLkiwCx/unDdyvqsV+gDeQOHCCHjGLsjw7jDuVUJC0OpM5l?=
 =?us-ascii?Q?1tbp7nk4YG+MMcp1ZOv4WyOZCchlMMl+zjU/Cr7amYBTW3V+Tl/+PWvHtf5I?=
 =?us-ascii?Q?pZEzm5K5COE0tDvIkzCdPNyxR2kpyORl99+BN06QIXHFk0x/Ey/C5f1XJ15f?=
 =?us-ascii?Q?lt3Fx4THzRIgvzLG991wUPzAkX1qjqyMMe+qgraLUzevdeW1oLWQ6s4kUCji?=
 =?us-ascii?Q?XUxeNFiV1y8z8r1INiNJNU8SbSwNJwzbZM6PmG3SdsEKkN/xlOgIk67MLa5x?=
 =?us-ascii?Q?iHwR4rjkHpxgYcFrmDA1X9ysphQ4MIZw58yf2ZmyiS0/6lBLgP6FCVNkUx7n?=
 =?us-ascii?Q?qujhYVDvsA26Xutlwno2t+GHNy4CsSl6O0ugLMGIOOmzebxdSr3Gx8s6qekp?=
 =?us-ascii?Q?BWSsEF+rzGXzwdKUJtMilXzBE34ozO5nwiaM+O3ab0QRgNMbP54EY66fkChm?=
 =?us-ascii?Q?k6VxkrPF4PwQhAIgkw/bdFu/H/0smBm1zHP8WSPFYWVwwhjUYbC/JAn+WyS9?=
 =?us-ascii?Q?mNCTq5VlcRJxlCFOe1f4UzRnLQ+uP/AxlTypuueG/DmTBLjOnnqJiXp0UQsq?=
 =?us-ascii?Q?niptO2mc2ugRNuKsrnQxDbTLgqLmNuOsuHFVc+JjAbv9kCN+WKDwjvh+jpog?=
 =?us-ascii?Q?4pzvsc+vybrrwjXeFVMG4r17MPCbEoXm9uymWyJ2PR+mpn6QA2K4E+AGw+aI?=
 =?us-ascii?Q?DzDXmLeO4d2jmBIHK6hkBStv01MlyCRJYfC25NYo9Gp6Sg358U1y37qvx0/N?=
 =?us-ascii?Q?MQXmEkr6Ay03o00efptijDrDDZ1rCpLzX05es7QBfNUTh2Zd3FNxt6dn+DYj?=
 =?us-ascii?Q?Nioyp1PXmLfUM0NppMHu/L/YgL+hLSgo+g27gpTKKdwW1g/L6J1jgpId8X/j?=
 =?us-ascii?Q?oKLH9p0p3MG0llBUCC+33P/dC0H2bSTlO3A1hNTa+5RVFM30Cf4uydMFineE?=
 =?us-ascii?Q?JksLo7tSdogvouYEtmPcReAYB6vidFgK8KNKNBjUDNJBeUVikLlf0TOxD4AB?=
 =?us-ascii?Q?6t/kof/EJ/dylGlFt0k7kV+QKUeBBL2SeS5SCXGjSQbKnxNO3lzwBkrKQ+4v?=
 =?us-ascii?Q?bSYJI0hHySrdZlVxnwXyohcmZAfB78AwIX4FWu3J67xEu52ZijjOQ5LyIdCh?=
 =?us-ascii?Q?S7/XGzWJfuCvNGPHShUkVaFdWMndYqyNA5c/EIFtRSN1Rs9NB6mCiBs247GC?=
 =?us-ascii?Q?sOG6kqW7D8X3wEFLsJIuoWO9sNuo6f7+XbUblJh7aMirRTPr/2Q7XB9J/tL3?=
 =?us-ascii?Q?Kyc1KK0eBEU9ZCZrqlPkez/iPG1zCTmkqAkkyqv40T3RnQ/m3cXcli28lgSL?=
 =?us-ascii?Q?dcO5n1iA/u8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+B98vW8tsGBgBuab8a+b19GifqvBeCQixBpKBW8CiLb6KBuP88q+rMYEQJQ?=
 =?us-ascii?Q?pwUHlw9P8YNWgis0/yFT/lhdlRqNLUSMgfG65PxMyNDmZAO8jhZn+SkVBaqo?=
 =?us-ascii?Q?8UUt4XPqaM/VokrasMYcc5d/vEVPb3yb13KbLesxKgP0/r4LN12ASfmitwOl?=
 =?us-ascii?Q?rSU+YwEviH8DBu2Ryisq9SueRUTPeF6D1Jwe5bXKvY4cAqkDcg0urPXlw62+?=
 =?us-ascii?Q?ryoZm4sYab0P1RHszrWWWeF+1DqJV5wVQu7vY8cIO0VOiHNH8TQJcXh3GgdR?=
 =?us-ascii?Q?+Z3Fd5bYFH+w6NWc/40UJhI24OFV6BGjlblrce7xu4lA9BD4IggF59qMvegY?=
 =?us-ascii?Q?IYAbuRyTeAHFGLfTelaiH/MQjlYZ9U4mWXEq2G0/LPKdNlZDlFnQftK36RlC?=
 =?us-ascii?Q?hyqRWFNuvom6nvPdajOImdkhCoyccOU2k+4UBTMjkvfUWrgb/Jtc8NzV7C7a?=
 =?us-ascii?Q?0OrO8k6Wwv/MjWrTqMtdT0T/yzClvLbb8nWoG/qT1LRRP98SLIqFeV++lIUk?=
 =?us-ascii?Q?hqOM2DCikEEy6DFQ/l/8cnPIKHQR3ud+ft1DAnyM8LdnJuSz5NuWSvjvabWS?=
 =?us-ascii?Q?1852EYstWmhT0BmvvA8opHiHByk2wHVomMmX+rCnZMPIu/5sx552KgcmMXX4?=
 =?us-ascii?Q?g+oAk0qDBXVuf+UriWlEwx1N+2uAhBDpY6Ak/D8c/CjU8Urbksc+6Gu8DbYh?=
 =?us-ascii?Q?LUcynzPT0hunnGccfm0pErZycO2wWUkzBd0CKYspnjzmgDIwurz68WlPyNOO?=
 =?us-ascii?Q?trqPnMpvMwA8Ily8CFSw9UBEnoDwlziUHgX3NmmLgQNk5BgfGclLN1aKe0QV?=
 =?us-ascii?Q?zdx9ZH4g/wRzgO2fRWFy1p51gKJ5BcKqaeMv/6zsdRgkSl7ey3Be5RqwrfIK?=
 =?us-ascii?Q?fyvSJ7mtniR+eexqVeJKW6YH2+4nzMcib57+ZZzzZr0NAOjQlF3XBI/64X5v?=
 =?us-ascii?Q?hqYRWtaVFP2BVX3cjkXX4rqw6sMzZoowSfC4oMlJl9rWpzbyLIAq4i5PlSSp?=
 =?us-ascii?Q?TC2DdqYoCG2rxKNu1LF014pfubPVv1CvRBovNARvGpEugUtzAQTIKvEKOmZ/?=
 =?us-ascii?Q?8Mj3aWXe0oLJ+BbG3f5OErOa9M+4qc96T4y2pDOYQYhGztRdIm+z3vTrcm//?=
 =?us-ascii?Q?GU9d2DbcLKOoWnBzykSRGgEqCXPhAQtAeTHjGk9I7CsuZPey44SxzfFoCZm1?=
 =?us-ascii?Q?HqNqG1LpzV9YU2HeLxAH5AOvyBbnUta0cJ7GOr25bFaNaJDjV6kDwHZQsCbE?=
 =?us-ascii?Q?3lwx+62s1o5cJBM73hh2nfijpQu8cQnf2GGSaJYMxHfsaZ2zY4z8UEnHZlvr?=
 =?us-ascii?Q?bJOMd8FRSoApmTJkIvOYta7RK4zQDutLpjxHpNb7cvyKwj16ubclvTQahPxp?=
 =?us-ascii?Q?iZJKSY65eKxQ3HW5huWHbu88tzq166MoQAPhH35MojrZ5hZ91MOcDNPSOjsu?=
 =?us-ascii?Q?pTqI5afMr3g+edzLvlbDfuWdmdvmHMD6+CGWfcUiMjNPqe0k4mn5CxzfNG1n?=
 =?us-ascii?Q?lvpiXWizjcz8ICEl1CieKAvnB7Iz/GwKtBdAMYEdGU9egMZYQV2wK5W/ZGQ5?=
 =?us-ascii?Q?FCZlUqk9WfwVCcb570G5ErAiTxlHsEnUr7HQ3FGR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017b35a6-ac4c-4a29-d7ce-08dd8d4c2393
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 09:47:11.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9Yd4KSurJxJvqXvD04zmPPiPVTxd2p4PjGuWO3BM6S4PhSunPcQ7jRoUoUCfz6iaZdRA5eie7bbgSdyrwHmzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 1d781c0de08c0b35948ad4aaf609a4cc9995d9f6 ]

ublk_need_map_io() is more readable.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250327095123.179113-5-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ab06a7a064fb..4e81505179c6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -594,6 +594,11 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 	return ubq->flags & UBLK_F_USER_COPY;
 }
 
+static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
+{
+	return !ublk_support_user_copy(ubq);
+}
+
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 {
 	/*
@@ -921,7 +926,7 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (ublk_support_user_copy(ubq))
+	if (!ublk_need_map_io(ubq))
 		return rq_bytes;
 
 	/*
@@ -945,7 +950,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (ublk_support_user_copy(ubq))
+	if (!ublk_need_map_io(ubq))
 		return rq_bytes;
 
 	if (ublk_need_unmap_req(req)) {
@@ -1914,7 +1919,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
 			goto out;
 
-		if (!ublk_support_user_copy(ubq)) {
+		if (ublk_need_map_io(ubq)) {
 			/*
 			 * FETCH_RQ has to provide IO buffer if NEED GET
 			 * DATA is not enabled
@@ -1936,7 +1941,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
 
-		if (!ublk_support_user_copy(ubq)) {
+		if (ublk_need_map_io(ubq)) {
 			/*
 			 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
 			 * NEED GET DATA is not enabled or it is Read IO.
-- 
2.43.0


