Return-Path: <stable+bounces-142020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2408AADBCA
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92E51B68294
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FEB1AF0AE;
	Wed,  7 May 2025 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oXNYVoOL"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5120156F5E
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611251; cv=fail; b=I43Gh2glImWJlogh+raDDYd5xTlGmO+XM1UL0fw3wvaXmqbQyhI9WuX9mdBj7lmWLyqGhj4CV0gmUgqCqHL22MilnCBB8tSl1RKusEuEhfh/70FNltMuMIuGKh1phuQZiKbGrtJZB+97LcKlAeVrP3yT5N7MfGX9EB4AU3ZOkDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611251; c=relaxed/simple;
	bh=hRqQ3yvHzvHuV7qD1SbanOI4p9jk4eOWcBmDJXrFGW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OBdGDZ2t2mdj3lgDPa2kSzmlZhkCTQOw66MU6PB9hWR8Z5P04dEGv64eqHwlycJtnFfWoLybDQTGRJk1Jz9/gA+lmNjA7kVfQi8I9z/R+lBKS2EYo76+7KHCaFa4oacpt+P9JfQzWTZURq+BwS0JFcKIa6CfEYjAIwZ2RVBg208=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oXNYVoOL; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2OplCNFLM2YH0qlnuFhInQOSjNwJsSqUpczwNLFgB2u3Hz85xE7jVDxb60cy0bzuh47567ZTA6RAKQ0zKKjFbiFE4kneqwnfKk35Bg/H5mf1DlVu/u/zAmTFruOBWdS9YMPj4aFseijKqAuUhjnI5hF6OhaWFf9Ldw5SBBJC0R/u/D39hL3657430bMBknCL4/vvscfYH0fOl2XesMBu6qUJxVbBIF1UvPb7V4qMC22jTjw+731lgEshHwMmF37YCXtZlDyubwfglt6wQxPqsXOMrQFP7/Sz1OGEQpX73cItit4JuvkJtyaME3DOe8BibeheVlW1TtmvwjM9jDXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcipPGDPQe2oQoQK+Hb+QAOz0Pwyb5msNWB6yUDfi8E=;
 b=SVkrrG/7zFkiMXJeAIAjHl49tgu0cxHiAwF8KjzQS0XORxdmj2EzlcTZyeZ68CcZYrZaiob9xhTwtAuB9ztkMd/KVTiV4Po2jvmppqAH+xjdt+E4M9RTeIAZNR5FAY/OeF5OQggfrrmLORetLjsYEDCvw8lZvqhHp/gdBAAhnCMrWiueQ7hOqQjEJTRe+g0s11kueLOk49GXUqUguY9ps9Klu3eLlDJWmM9nYRSPZDy9bVDV7H3nOUVeAe19wc5PrWpGqdnRE6BtdNsvnIBCXfZbI/4JpVArrV2UNXoFZkqKu392oOOtGpr7m88MeAicEKmo99VCQ6AUBt4x+PTFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcipPGDPQe2oQoQK+Hb+QAOz0Pwyb5msNWB6yUDfi8E=;
 b=oXNYVoOLlCmUN8GOiCVAUWtupkw9Df1EOWXWda6HAGex4R7zDXXK7KGmLkncUPE/uaWgm6UGCk+sW71P8zKVkAUbRrvyLQoR8Pl3jxObIkIA8Qmdnk+SoeMS8DVhpeEZ/3lBmae6lQHgoi4XbVpVkjld8bD5BII9+PwPrFmN269kp6YZ6waN5krb/zqs6qT4Dvi+UIg6rdA3mkC/GzuWqnKMekJnhcusg2rYGEL0vmmnlDiD5K/KzGj1YYKF9ZzrF9JGBVTHAogoU2drWueE0cAFja5tY7NVj/P80G7sCDMa/mYKMlEMTw/LexD66P5UiIVBw3yZpFb3qoG3a0XzzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 09:47:20 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 09:47:20 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH 6.14.y v2 3/7] ublk: move device reset into ublk_ch_release()
Date: Wed,  7 May 2025 12:46:58 +0300
Message-ID: <20250507094702.73459-4-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507094702.73459-1-jholzman@nvidia.com>
References: <20250507094702.73459-1-jholzman@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::12) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6d5df5-4d0b-419e-54c4-08dd8d4c2934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fish9aGd615gP3hXCFNeN9st1EPGxJUxCK2MwLRwnTb1+eNgr0XNXKA/wbQw?=
 =?us-ascii?Q?8ysIMOOBRjryUW5PTwANosy+PQLhkK+h0M5wDi/uQkHHrlJ+LdGMbjNafz9O?=
 =?us-ascii?Q?rE/g6Gd9N5Hd8m1de8yyWla69Pa+sEwGSqlMHWaCUq7l8UckEaDQ2LdZJ4q5?=
 =?us-ascii?Q?fXwAqMffGi1xUlUZy6dAQb/mBFtL5oat/SjEdA58bVlh1SI6ctw7PchIuIr3?=
 =?us-ascii?Q?9IPsOYwqWx0ztN/W9n804DhaGX2DSbuR2/4gHnO1vjd7mRHUENAySrXDfmC3?=
 =?us-ascii?Q?wQTL2ntgTa+laAj2dtwJWRd4bJM/Gwm8SGUWQk9OzhtCD+SVTdLFkFxZKIbp?=
 =?us-ascii?Q?oJBZIu6J1x79VtIM7EAWn4j/JuVikP7VAwThFgwuhpvttoY3G++w4P+ROtuA?=
 =?us-ascii?Q?hgFLl1ICEHMiUoyyKybiJX1td8YNwmIG0H9p+GufpSm3oqRgfPHpOlhg9q2m?=
 =?us-ascii?Q?iRCvBC+mLig779qjWh+6gSkr4jyJodXyphLM5v6gOo6cMNR9Yp1clMpa5Hcw?=
 =?us-ascii?Q?YViE17Oqqh3/dwrlQ9cvpYKw47UuyUQXfAkh1yxPLwL8PVFEj2plzhmI/kkG?=
 =?us-ascii?Q?w1a203OoROjbwne/+x9ZzAcFWy4m++iVUt98oRk7yXrfpFBPHu4IxgXFMJom?=
 =?us-ascii?Q?hQAyu+p5C/KYKpZxv9GvEAsVo6HC0b/J4+7Li12qHK7kUD/Og7XouidPRTXa?=
 =?us-ascii?Q?pETbayaoCr+/Kk52IztUs7nAZUaGYe0YWosoomU+7Cb2UfzvRFf+Mitjn8ag?=
 =?us-ascii?Q?VzXSCC7vibAJ7dUBcRN3F9Iaa2UAHwLWTeVIpnsWqq9ucQzxQcqsXxxIi66J?=
 =?us-ascii?Q?QSEowD9JeQcHFB0iWsH8vopk/13aCXT71jcT3XOxQQyMZXPtH6nKwiJr6BGA?=
 =?us-ascii?Q?Q8KI8+7BcTbV/F1uiMuTbLsQfW3NV4AcSpSnByy5wmbezhmNYevKUeo+YZE4?=
 =?us-ascii?Q?ydS+0XnjCukOnDSA9Luhzyv/QefAtd7zMPmiRezCtKhO0u1cobP3Uxy8zcYS?=
 =?us-ascii?Q?zOaSzIOxpqTPU7oK4n1Hac+Wv+WQUwX9S+ckO3tXmC4p+lh+h0pH+steiFxc?=
 =?us-ascii?Q?7lhegnnIHtbm5CLGdVH0/2SxTA9pOs0wBK3q2rDSG0roMLy6D04tvlncAbke?=
 =?us-ascii?Q?VNzJRv5r6U5lDJjeaR7OvIDygViEt6rXwKeaM2z/iggfUYoHsAxl26vSTHT8?=
 =?us-ascii?Q?MRgeEeBbxjWMJECSJEDHpR3WgXgTmB5iCD9SjWuAwH+wVKaaSlcawpRX/INM?=
 =?us-ascii?Q?H+XV1NspOPG3jyJh1QHgz+0q5+YCYQBffofBsIBNG0rTcRRzPADuWnnLMPeW?=
 =?us-ascii?Q?EX8d9r+xYi49Yi19JEQQRTcqXuwHtI0zK7F3gzrlwD9kASh5vi0fdMMUyuU/?=
 =?us-ascii?Q?ZHoq+3OrjgWw+BFyWaEpYtLEcPyF+04G869uZOSJooQkkGnjbc3GrzhpsGlK?=
 =?us-ascii?Q?V1cYnrHS0aI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i3+1+cNhmSJsadswJYIR39Uk1KPVS6qFjzycaJz5bL5fA4WYZYDHz2BxJo6C?=
 =?us-ascii?Q?SZUKCKLiHxnt8o72ry0DHWftLaDFYH5V+cBxBwHoQo0dkfAnAGf8egJB20uU?=
 =?us-ascii?Q?2FzQ8ceNQJ//hdkNb/EDKxm+7epJd5eM2uIZXvcMMlnBklZnHsprhl2vB6FQ?=
 =?us-ascii?Q?11CPZq4Moae3cDuiPIewPk8Q/JIMuG2Vw7u6/qW0zvDUqYbDGfzpFNA/tKHP?=
 =?us-ascii?Q?M4SsLtDDOEuYjfsXZBctRy34Bq76PJndqsCKdzRnXOsxQVfoEYj/7+EJ01b6?=
 =?us-ascii?Q?Ek/nlZ+OMeZDFVhAkVO4j1v8m9mTAOvd+FP+11paA4VVBwjJq+gZW3uHFMXk?=
 =?us-ascii?Q?deYamEcIvmWxpFagySAXUAHHZconhBq9QKn8SvfC0enoS7WxrDt0ms+owWZg?=
 =?us-ascii?Q?ptJpqK+uQ7lESljoIzkHQd7IZu81v+jsuvgsE9DPyzD+xYcXaNfgMgXr8Hia?=
 =?us-ascii?Q?gptCdouQfrFjFWShxpi/8axQ9Aye8CyFjYMViw16mTAdqjqGp3NCygKT7fy4?=
 =?us-ascii?Q?HunSwwh+i+DHiZUrXFlEydGlEm/vHRsF6DXVjnLjLlNM8RlBA4dwEhfssu5x?=
 =?us-ascii?Q?eowJJMolApPwVtDLFbXBo+AfsGt6MkS0fr67DZcbpbTVpKRKv6AJCQNgZCVd?=
 =?us-ascii?Q?U6YaHrCpN/87OGRq+wGpkFsAY2JE9kb99S/Vs93VFPcMLJGsJ3RXuZbkJFD4?=
 =?us-ascii?Q?ndqAanLH7WwqthCv1Pwd67KQTR7kDp039UOHKEfRvxewHAy6TLbjcBfmNMXp?=
 =?us-ascii?Q?lym+CnrMezuTAdwaz6e7jf2q4CNyWc7C4/fMtr6FpsRMZpAECDrNGc3+z068?=
 =?us-ascii?Q?MSbTJANCZ7RCnnXDIMa6Ijj/s7buhHrvOIEl/bvMMEq1CmJVLH/ipd3Khj70?=
 =?us-ascii?Q?eWtXwdm6C28YFat7lMN7o3tEBDglQUYO3Is6Xwtn69g5fz3UyA/mDAS6nOvV?=
 =?us-ascii?Q?PU8pFce1RNEK4He0YZtHIxkIe4S1dAMAOfphsJX6gFGg/LCizInzuj9IMd/N?=
 =?us-ascii?Q?ojEPuWdIlZNS9dp1g8vKpgFu8eS7nfY+igwozjKX3ufgeenfiLXkGHykAzMJ?=
 =?us-ascii?Q?o3p6k5D7GWNOZlE+H7H9Ef/1xx8yiVM5EnqhyLgKXa4lmoBU9zu2Lo0B2ZXv?=
 =?us-ascii?Q?Kbiw3kYlvC6gH1P1+TJC0T3Mb59cYMEJ4MQgsU9zzqyfw6nsXNT3bC2XqZbS?=
 =?us-ascii?Q?/9+XVpZO03S2nDrSF4LZVllhwu8OklR09Y9ZSJTRFu344hGeoefzJ8hKS8GW?=
 =?us-ascii?Q?1qRPW1Vo6n6wsMuMgrBaYXerjt8fFWyq+wkT548+WUTCIOgGc93r6YlDgbMT?=
 =?us-ascii?Q?WhGqH49J1lFkBBK1kjCZdTDrKb6az1RDOuwOH/3F4RTfJUqUzBjZoQmlQwBZ?=
 =?us-ascii?Q?cg2wzjOfm65t74HNFWd4qmi/jorhVeJ4bPJdgAGQBvCgvzOSrGE0dgqpGiTg?=
 =?us-ascii?Q?594ZbrylJJt1tUEsUmhVJoRrPboSKmHZzEtyoZpx28RtMWR0wH6TPXBq5Q8K?=
 =?us-ascii?Q?QxQN1d845Wx0TAgH0iJF/Cp638Vww7WUdX2Sqc8h+a1e7gNzlwv7Nw8o8w+9?=
 =?us-ascii?Q?rCOwbT/ffpaLgesunqvhq6b/PPNehuiaFOLB43i6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6d5df5-4d0b-419e-54c4-08dd8d4c2934
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 09:47:20.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pWgEO5KjxwU65EGWNBc9krp0amJbnlYpL5zpMWmr2zlaTIGltYWL0McR8E8fLVijxXHVNgBIW4Ue2+bo/4sBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 728cbac5fe219d3b8a21a0688a08f2b7f8aeda2b ]

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


