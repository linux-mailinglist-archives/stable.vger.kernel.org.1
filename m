Return-Path: <stable+bounces-141950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF790AAD19A
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 01:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BBD1B65EA8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 23:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF9121CC61;
	Tue,  6 May 2025 23:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GrzXVyY+"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A719217F46
	for <stable@vger.kernel.org>; Tue,  6 May 2025 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574711; cv=fail; b=uNXbMk2oUXEhiqQYTq75i23MFbTuRhJApQYgaeJpoC7Y0nh/q5ngeUHYCzeTdhEoqJya4Y3lX8KavWSyV/kLipDagOdU0Hv5Bjk38E5vRIJY53j/29c3IXH6C3Dgnm4Da35V4EHlEhhky2oUjgOTe+Km6Y5KoKD2r1MEkv0C5YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574711; c=relaxed/simple;
	bh=SJSgIJOgDj5cXSi/PWGMzYlEu4uGbIgf1grnd/UBDNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rWyls2V+he//yZH3xdmY9GU+uO/iFR+Sfoq/5z2AacRM9L4nKqPNNub9SIcYsWWrAoxbZ3naxofdvEmBp7s7LNe2kyyRQAS2mR+Kl0xAK5Bm5On5tTzBAWDqHSv5Bh/poSe1kII0qU1zKpfIl1gIglkYZ08dHhkXffDnB6yLnlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GrzXVyY+; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mx8X0j4n15CHlXP2ihoZcPWLW9Y1ZTmDtIsjmd17rfVnFZt91dUFKSklgLYWgxxupez831/s3pIjnQxGGhwYwOODQvK8usClTaV9Vbq6279K+oJzj5HaeTCxVUFEaXmlEMIHXFvYwY9797ePh6ZePJ3ggRq2iNeyuSXbEpTJzAXplGfE1i0l9FMXjw6CNKtEqvr/WI9VRc//as17a7UGcqZroFC4mdQZyqvO4rCbS0eI8tlwbUjj2SMDd2HlWoNX0os4HbqfGIlWWumV+NGK9W8a7jrI+XzSt1VEaQFL3Up56gOhcPiqrdNu1H6Eav9YrnXdzAQLQl9COH0NL8yHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDVCiXSEXY2jNCJ3UehXKr0OgLxHW5hJo/yAsNDC3nU=;
 b=FMqC8fbOvtkI438ZzRZP3ECDT183fbJrkXmvKy9D+MugdxYbxoAqFuadr0oGEZ8px91wx+mJrXsrDCIYnRvE+QdUob8Hj639NkCQGNouasrCZTsWzuejxE1Jaj/tHuZ/NBkSas1k9fh+oTEDjxjYltjcAsNHi9wLdwHeaIwqGKCQ/s++iRfQz5vL6O+TQzglTfY1c+213lG/QGN4q97dzngc/9yZ0YS5zdiNEF4j8TXG7lo0BrmTTcP7xCsyJGkvHexJlC9fDzSOKWM1DiMZBXSNxY5QTGnOcEd/1VgQXsQnWwB4GAhrJIMa/9llx5NVESZnrtBnvk11CoGEsmIo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDVCiXSEXY2jNCJ3UehXKr0OgLxHW5hJo/yAsNDC3nU=;
 b=GrzXVyY+5lcZ82h803lf6A3++8tci+ia7qm/vqSYUdg+wiFqVM90bDZw0LRAguEPsMuo0mC6xrbm7ySORH9YSGWMITnUuRpa0KFrjB5uMxlsgs38Cc2iNpJwz5DqpHN6bNniQhevIbnJ30lPguc5TgkAAGNBnkOzmltqCGOH+hX7oqF7XXJTAz71ik9fVEfL6AePmvEWW/NttN7+ZkPPPfW/RBrR8jLLLc7bKaUMXmX4lRaod4F05wS9LHcedg293kPer8fqIsAmEEqIukfq1NRU3vH5ElSRyD+P3sdVRG4zckTThnJtK6wAWuB5WMWbpJDQPhT19VUOv1DeslY5XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 23:38:23 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 23:38:23 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH v1 5/7] ublk: remove __ublk_quiesce_dev()
Date: Wed,  7 May 2025 02:37:53 +0300
Message-ID: <20250506233755.4146156-6-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506233755.4146156-1-jholzman@nvidia.com>
References: <20250506233755.4146156-1-jholzman@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e200dd4-0aba-4a49-f831-08dd8cf71769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2koCO4XjCtxuG5wczZcQlozhN46Pb27WcxmxS708FYOFiSBZIiIDUPxURYDV?=
 =?us-ascii?Q?KezideZtMJNatimcktlJfSuAH32uvhZSKTgTy89LsCC9xriXPHT16+/JDkOT?=
 =?us-ascii?Q?cW9TQ9J58xMkudE05CEe8NeZAw4C2aFkEK9Fi8qmjXBm5xUxS0wOEesa643E?=
 =?us-ascii?Q?9UUMg4GlXidxWQh/HO4jh8UctUvhAg0xL9DW84AOVY0mXus4oN3U+3dlQj16?=
 =?us-ascii?Q?l6yr/uTKwB6u8zXyRi5R+sfUtbivTYktQMyQLgXr1J0Akw5APe1SP/IJzfrr?=
 =?us-ascii?Q?XPWjq+QyfSzRkiPQMDn/UlSr/3Jp2jinWwrKso6WLxTiemRUanE/cEWQsXof?=
 =?us-ascii?Q?IgmglyoMfWDOpF/RQKrZsk1rFNL5rhqCgOe3FCM1ClgDxu9HH4eHRRVMIahN?=
 =?us-ascii?Q?GdPZE2S5j/km1IYLo/yXb94iz3XbJeD2tzTlD1QxuY4/VrZebgG8vfLJGiLh?=
 =?us-ascii?Q?dhH/za1Op2ATViu7GPGS+9xMh0BTSndu6QLhfLmFgQThY69NXzjF8fSU334r?=
 =?us-ascii?Q?a0KIjlQhVEtV/GJGfknnfuxsvKOHIB1Lxy3YWj8m8xOH/+PERFkkLnJ6EoCs?=
 =?us-ascii?Q?6QjnKFe/aQe7YGZa6mKpamPx9dFfsVuZVcBPP6oer3Bj0OMqoTs3Q3XAWjXm?=
 =?us-ascii?Q?o1MpNNe+n3CLS3FXqCXMpoAJmqm/7zW2jgl4coKW2FLHDnzCjnYL/NYon5G8?=
 =?us-ascii?Q?PrTS1hdlg70yTxo0wS2e6YwakwC7dIInFi5q5MhY0FJMS3hjRo6kXynl2EES?=
 =?us-ascii?Q?eh2G+sT5ZhkE0yijMatKDBA+twdwk6goJh9Hidvx4lTEZu4ov6qytJY6kplY?=
 =?us-ascii?Q?GnNcv3yj/yRa4dCoq8K/mXWMJr1bg5EVSP1SwqoTvGY5TDwOB1ILyT45s75S?=
 =?us-ascii?Q?xnN8NvkC/7LWL8TYycXNNi5jwpFXKkJEamBwM7GV+X+00Kewqx1W+U46EPyo?=
 =?us-ascii?Q?TFeMpGwG6WiZDejU2DML1wjLFU+fYldCOxJk6ymmWNnR2z9vCei+J2V7AGiA?=
 =?us-ascii?Q?F9Iot8g8fghtgpXfEu+qiCE5oqqaWy++rhuV2wj2plZa8KVrXn/4siXMl/PL?=
 =?us-ascii?Q?Rdd8ld2qP/1KvAPicJgHxH7uYwHKXNUF775mD4mx0Sj0lz9VKZozZjxP1Flb?=
 =?us-ascii?Q?83d9eacj9G+pNYQtN3uNMA2wh/0WaE/zkep9mwzD+VnvVcOK0lZRtZRVhX+2?=
 =?us-ascii?Q?S/4NNmehOp52ylVOTe1w9dcPh3RquxPCd1Z6FVdyGua0HfxCA6GoXpcTn+hY?=
 =?us-ascii?Q?970+BR3AYoEvLUct6WFlTD3IxnTmcY4HJHvmjaMb1ZbKLdD8dXhLtfIAQRUk?=
 =?us-ascii?Q?KOlANcgY87EazaY4pkselHfvehCfi5gToS7Wc/ItvGg6Cjl/DHvMovrsk0Z5?=
 =?us-ascii?Q?MjfQiOXtcsMxtBGhjEzz4o1pVoZHl+KOz/k2Q9M7LH5BlM8eSGcVLOPB8CGZ?=
 =?us-ascii?Q?daqaBJh23ME=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FUhbiZzGGdGGuX+UxDDSEdOaQkK4ls6E/NYG9/6V9ab6qUaoIOAkhGwvliag?=
 =?us-ascii?Q?wyquv2JjnLLEY4EAGaAD0WhFkdhEgztZI4bGScFKDJu6FoVNl4A1ndebGBfH?=
 =?us-ascii?Q?QaDfQDkrpEhss4Uj39EeJxuKc4vYnZkHkpOucShTZpXWcbKxpKEGus1WQZkG?=
 =?us-ascii?Q?s6+h+U3w/o8NY2saeyAaabnnmZhTQGZsu2A7Gvz2QEOfZ7ha4WeCbbnEd5Gf?=
 =?us-ascii?Q?UnlzpWK1M7SV+O17RkV7Zt8o6wjCSer55/erbXh9zbDbocqLnwR8bcxhEqKp?=
 =?us-ascii?Q?xFnNhpF166kuH98sbhvz4wO4kMq4BxzWdhqLFOsn4zDGVxsXxujjADg7ypOf?=
 =?us-ascii?Q?cJThqKcLdn4MpsEUbJsWtXiWLlwSsDmRoaTKXJ5IgEWdWE9jPenQXyqEdFXT?=
 =?us-ascii?Q?1HeQk2zPupFOBq33enZTrOkb7UCTyZukoK7gwgmLRRjfvsqz3ZlMbc3itgkj?=
 =?us-ascii?Q?zKGYYFxPVywBCGCl8r25o5oUAgvPy8+g3Mz+HXOHY4p4Ji+XZ4aefCRCyj8k?=
 =?us-ascii?Q?3GVYK6XCYyIBhxutPuHD/BkRtijP7PLXOa29lu07g73+UJRWH0ngQxuBQ+rW?=
 =?us-ascii?Q?ho9P7fNvg/tr9ljX0ve5Z54ezqXeNLeAImM/BHiB3l1wE5CLl16MCiq1kwKu?=
 =?us-ascii?Q?pfJZHmCLtZQ3gZ2qwHDNOBpTYJy+QbEsGsR8oVsYB/wS8WyPwHD6GB+KP7Te?=
 =?us-ascii?Q?kle0hBHbo8VjIFMXRtki5GA+ossMoTnXHH+4ptNDZZrrHly7bzqOKJvCEqoK?=
 =?us-ascii?Q?xNkFVQwVzCxMAFJFInSyxeo/3OoaTX/ibuDiVoLv4RVSxiudwpp8pqs8M6mS?=
 =?us-ascii?Q?3OVvthldNioS4bn4JYR/yNfCDwfMJyKc8TOQNbYF/tkBjQChH4x/yi+oA2ga?=
 =?us-ascii?Q?NX62Cbo0VtdaiVKu3NilHWdA9c3msBb3DtAS2lNX4eWzTJbVnD3vLuVqAdOv?=
 =?us-ascii?Q?uQidY7b4htXpUF1BoCOSb8asF2v1mix91vH8JJa/3rq6uJQPd3JXY5gjfaGh?=
 =?us-ascii?Q?OHdok35pz3nML727zpCF1BcgrwnH237BHjHN8kuxs7c/Sq6jvH7/ix/z2hoB?=
 =?us-ascii?Q?GaUq/7GfsV/yb5eUBw543Ha+hhxbKFsJrwLem0hnsTGeXZxZWaxUKXUQwN6p?=
 =?us-ascii?Q?IEnqoYPODTLzvy8r0U/1a1acKTca8WnTgj5FfURyc+oTzxIi1NB/k07lEXin?=
 =?us-ascii?Q?lIpbwnf0U3b5Qn8PJskR1RcaYTiifGERGtIAz4MTtY0bPNhKScvaby/WgdKR?=
 =?us-ascii?Q?lcGUPAJfSVy3Ze/lZcwe9paVhn0FxfEOZ8fUvXr6lGWH78TjMPeY14qQCAsV?=
 =?us-ascii?Q?KV+1AlyIw3sN4NNrOD+JvoqvEpEO7FjM1WLjSMXWdBAIg0VzUCPKyBa7NFML?=
 =?us-ascii?Q?owcECBbRAUt44vmm8cwBJF0xOokP/jXifKDnw9oOubaJV8tAL/TugCY5M4mw?=
 =?us-ascii?Q?3uAu+qQQfwhpHbvbA/JsDSLb+XM1d1GzinZEFC0OugRj03bhG7Q96K9MJWFe?=
 =?us-ascii?Q?/820peny/7gMi7DGlP0Y6v/shh6lAYB7nZFnEksits/A965x11umNoMVMgUw?=
 =?us-ascii?Q?JHoMhrCvKuOgi8JfHXFZcZOKZ6p+dw0FWSGqAkqiGB+CWrFh4DtO6jVbjHnX?=
 =?us-ascii?Q?eUk2O+pworsYcarW47mIL8vPNetuqgC6jj6GtqAOgrPc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e200dd4-0aba-4a49-f831-08dd8cf71769
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 23:38:23.5616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20bRMTxi56A7X1L/PhVJQkNz2ho1r7j6CJ9SiQFQx1eIJsMln2FX3p2bgY/lKIUt4CiooM6oK4JDQLw25zRwfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

From: Ming Lei <ming.lei@redhat.com>

Remove __ublk_quiesce_dev() and open code for updating device state as
QUIESCED.

We needn't to drain inflight requests in __ublk_quiesce_dev() any more,
because all inflight requests are aborted in ublk char device release
handler.

Also we needn't to set ->canceling in __ublk_quiesce_dev() any more
because it is done unconditionally now in ublk_ch_release().

Reviewed-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250416035444.99569-7-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 652742db0396..c3f576a9dbf2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -205,7 +205,6 @@ struct ublk_params_header {
 
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
-static void __ublk_quiesce_dev(struct ublk_device *ub);
 
 static inline unsigned int ublk_req_build_flags(struct request *req);
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
@@ -1558,7 +1557,8 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 		ublk_stop_dev_unlocked(ub);
 	} else {
 		if (ublk_nosrv_dev_should_queue_io(ub)) {
-			__ublk_quiesce_dev(ub);
+			/* ->canceling is set and all requests are aborted */
+			ub->dev_info.state = UBLK_S_DEV_QUIESCED;
 		} else {
 			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
 			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
@@ -1804,21 +1804,6 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
 	}
 }
 
-static void __ublk_quiesce_dev(struct ublk_device *ub)
-{
-	int i;
-
-	pr_devel("%s: quiesce ub: dev_id %d state %s\n",
-			__func__, ub->dev_info.dev_id,
-			ub->dev_info.state == UBLK_S_DEV_LIVE ?
-			"LIVE" : "QUIESCED");
-	/* mark every queue as canceling */
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
-		ublk_get_queue(ub, i)->canceling = true;
-	ublk_wait_tagset_rqs_idle(ub);
-	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
-}
-
 static void ublk_force_abort_dev(struct ublk_device *ub)
 {
 	int i;
-- 
2.43.0


