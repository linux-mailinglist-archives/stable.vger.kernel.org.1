Return-Path: <stable+bounces-141947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C9AAAD197
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 01:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3ED982763
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 23:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72316217F46;
	Tue,  6 May 2025 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CCQYFssb"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7C1FBC92
	for <stable@vger.kernel.org>; Tue,  6 May 2025 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574699; cv=fail; b=oSBm+GPuRuG+yzRVZxxWjfPDpLke9ZKYeQuAXeK7DcW048eLpj4lo5p1O+LQAf22ZKVL9j1srOFhc/SoOJH24NSw8CQg1D3by+pMk2I7uhwpQWK/JahvFuZEzGsmd10dq/qzB/U8MdX1SLwTTyJpXZ5HuTh1jLS26XRnM5ryLgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574699; c=relaxed/simple;
	bh=JMjHJnxLagWKKNh3nMMhRtO2GX9FuNzZfxmRCUJzk4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M2ess/+vn3aAbwWRISSP/Od+twjRan1CSPNUqbdpxw2McumnhDvedgnXTCTmub3Q98TF7Ay3Epo1lPkgASwUYkPA8xLg+inAmoI3YDGDekKqsv/V20F3oWg4KtlYiJkO6yyIzfZAVDpx/DiTowYYLeUr0l0FiuL2xvc4epP8Udk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CCQYFssb; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nL+rPQ1PqQh0jLi8o+Z8O+8r25eMLf/v9gtvuM6adM25wwV6TyQ69SfKpjHeCQ7AFvemfaw6sxXbtcLr26+R7XFKaB4Vq0zEGe1bxvbmkuJ/U3KJd0sE772EdgPliCGW93jjzWVHhCE6iJAt5kpa6fejyM87j5r/auGabyKiOgSPVUvFcA5hOPZjhtHTEiFe+nEU/6oquUmYhvNP8jaRZZBMGU5fT5djzoHeGY9w0ryVXkvLlSXndfSt9PO6dcrC3rRtr+0nA4Rp1mwIghyr81DZmBUFGiILqtIDeUaSjP1BsUIMPWnOor837jn0juU+KBucKuWvxcDGk8iyzrgRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDTZ0ebuWXwWWH6+iRm4JhbHMFe0K4PVWKZLJnJE0MM=;
 b=Ncy3dAcdTo0y+lioClkE12l/8ZqAYMhLcUcSeauNu4prcTZqso9IMxm02348JnZGQydap+X4BaCUzQsgMO0HTaQpKlhYzji07g6UTRZY78OFwmzpuwx7tAELblAPFa26zn6uAqTAnDZjwcPTtQ+lNP+lowqsiWjH+RGRt6zDu8Kwr6ytBSk22Z5cWsfZu1teLnWBeeLk6npdebRAmQicXvnJ0+pcpK4RfVLbJgmRFi1WvcjRUQonNscdooAXukxbrgK26MkCnQAbGZItnKpigkQng0DxGHqwa4DrGU9I3mmgGLzBdulaPFAcYkszPFsTfHimXoBrEOJlpGlfBaZN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDTZ0ebuWXwWWH6+iRm4JhbHMFe0K4PVWKZLJnJE0MM=;
 b=CCQYFssb2eJc5BYcr9w/6fRjxub+5HZsOWgBPbTq7m6PbullBCqSQtfu0IUIi+wi28M5b0vG8xdOq8+EI8BChUMd9HWmTph2yJhzj87ePKfwbntfFBJBBLjGnM4Nx+D4HyquBp0gopsPssw8l8ysEnknnclvamqUvl51XY4aAQNQnBTIFaEq4jN/CgbG8p4QTJzHeQeZSs/d6qcOy3u2ZVUDPlRID/+hXshDvVhSo9FPjQ4vqdu/v7aLxn95yvBamNFyCPiH0dxoLFVeAwJFEjXbP8iwvQnccpAR017IBW2bhlKx21O5LiE6sBrzgGGcL9f3Kirh3rvJUo5kSToOeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 23:38:10 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 23:38:10 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH v1 2/7] ublk: properly serialize all FETCH_REQs
Date: Wed,  7 May 2025 02:37:50 +0300
Message-ID: <20250506233755.4146156-3-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506233755.4146156-1-jholzman@nvidia.com>
References: <20250506233755.4146156-1-jholzman@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 671341f1-a592-40ed-1022-08dd8cf70f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wwQc6PygxA9/l2stffAhupMgISJfzAQ/6KtkheTcsdZ1nBxflJkwQVSyBOP3?=
 =?us-ascii?Q?zapKVH8FceeP5TAa58yIw/pes2vAkfDiGiD3oxn509wa47tO+goYUHug/Daf?=
 =?us-ascii?Q?/CW/AcyIi1iHqGuDASFWsNHIPNjW4BjIpwg3EYyVmm6ZZVlUPCjOTK5IxQRt?=
 =?us-ascii?Q?dlzZ3doBn15I32HSq36cFVSoW6s5XQYDx/E1vSyrsWnkeheS9reeprAhTnm3?=
 =?us-ascii?Q?0b4A3qOHigKaWGQ0cL5pGIte8/N8I/tNpWNpoQrXmysGbWtPb/nQo2FINiXV?=
 =?us-ascii?Q?FVF9l9paFM6G68P25NrBfCu62gx/ictgZWHp5FhjG/7sSy93HJEAHIf3FvXD?=
 =?us-ascii?Q?O15KfgkUixE1dDMKlsf3G0N6znlux/rWCcd+X+CQ0MIhotpQXEeuKqerHMq9?=
 =?us-ascii?Q?H53ckV9i9PTYXHlwuzvzSY27mFErSZUMEktqtlw/m6IAR9ELL4QAMQ2JaA+V?=
 =?us-ascii?Q?+Sjo4T5YOpyNhLK8mAn5VZabo/823tmn+PKHMM9vPQxdZuQug8yRrHXOXIhf?=
 =?us-ascii?Q?ubuNV2KspkWE95eLKmvJDlZdv5I5A4cuPt52YZOkvaQ3mfCvmbBAuWnpBEb0?=
 =?us-ascii?Q?hsgciKtftIC5yMS0O38WIM8qM+d7A3B8XSs4mSPIeGS5RzYNkCw81rYQRSsC?=
 =?us-ascii?Q?HMFFCEsOWjueaCzNWAr+jRh7tCvvLodSAkgaWsnnCSY9a0XAkyVIwpDx4kpv?=
 =?us-ascii?Q?OpP48OUhCoO3Om5duc4Kqxz8LBuyVGXv1yC7ntSmHIM26hTdQXfoTzVWB+HD?=
 =?us-ascii?Q?NHQLYhNEPCzDhUbYr3ZBbhdkf5JDVdO+sWldyTX7SWu3X/nrZVZ3ehJyigIp?=
 =?us-ascii?Q?IQnmoR/cCxE2Orppp41RlHG/pbQehz8a3+IhRd8WogaK4678EtEsEqKOScO7?=
 =?us-ascii?Q?pI8cl/v7Dx7ofZpY9w/GYyZd1c8knqXSHlF6z+V3vW2OyJt1DrTntVPwgr7z?=
 =?us-ascii?Q?8LLXDm9Sqaky08Y95DJytAWYhDS76iCEQddU8uVsEOLhtkyW7JsusGUnQPKv?=
 =?us-ascii?Q?R1BqPBPM1953hrAlGoNZblewAkP4LzxDm1uxBN57rj+mx7ri8QHnsxNus7lB?=
 =?us-ascii?Q?E/hBRtOTPkl+ka5kZqRwvAGiE8YsPqaUuqb+vbYFe8ixi0A5KopKt8DG47pC?=
 =?us-ascii?Q?pKoTVjWAFS3N5wB6FgNLrCd/GfTaYlv/JtVJizmbeor/qA/ODYpGp9MZHeEk?=
 =?us-ascii?Q?iHBGWCpHM4IRzJnVqQ9+PjMsaQoXa5VTD/mOqe1kl7YLkjtu9C4CszTzoqm6?=
 =?us-ascii?Q?UXieS5BLo0Y2wbAjADlijpO1/0R5UwhlKgu1LSpXG6FvLlGRhpAJqbYzCxSh?=
 =?us-ascii?Q?ejJMjSFF10Rp+bNuZxjnpxYXCUVwh/ltaWPCYillQf1WqIClhMUUzGv6av+T?=
 =?us-ascii?Q?XCpezFfytE3EiBpH4RGfl81qy2mpO3u839H/joquB++DLL7wXPid2SECJVKL?=
 =?us-ascii?Q?sPDAvcpFhMk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UwAe0KIVx9QAGj4hgbwTjHHRfFT8XlBdd8+N/SG1x8ERFtX0K6kzESt4Lfpa?=
 =?us-ascii?Q?ui0SzdXQTu6qKNMvMXZn2tfQnKV4wR7EuDM4Wz9Gon8WHXSjxmj/Xm+mrfsJ?=
 =?us-ascii?Q?GAMxA2eyvGWquReV08keHuVh1fI6GKgy41uRykOak458+MnZoOzl793oOOhg?=
 =?us-ascii?Q?d7TkvcNKFQOo5k7PUH4rq7rhC4TXMy6TgAD97el+c4pW0DPpPrncwHGXcS08?=
 =?us-ascii?Q?p6v7Lh4aes4CJdHFVCXcZTWgr3/I7UqadvOHEVSFHjqUlKTfds2eVmNLeImr?=
 =?us-ascii?Q?aIoTuuMcIEmvjdLIGZSlxX7/PBzyQUYZ56mICukLv0ILU4cH3PJo91MUOFOT?=
 =?us-ascii?Q?YBXOGvcymcuc1OQhpI2xMUNPC/aG2VjFGq3ICACMiT/k3uCrSf5SVsIyEVWP?=
 =?us-ascii?Q?phns8zR5fRn3C7XDYsh/iAkBdKGUJKcFN2/3rolcry5uiGLb+1YXxDW9WZ2S?=
 =?us-ascii?Q?JtAF+SOZZo5lYT2rof0BcZHz0QQ6jSa9yjC/QHQOfJpI1jffyR9gx86XTZU8?=
 =?us-ascii?Q?YbqK9taacF7SdS3zG5l2kszO6KfUeSptBpcjtT0yEY6GDjZ7YZZx2VVFWqvR?=
 =?us-ascii?Q?BpHN9U8PFVgKo3o1SUMfA8xdsjs5K/I4Xfbz3qikiZfth705EE9EyKJLMdpD?=
 =?us-ascii?Q?DCW9CNxuV+5UPkfYmrSz/spezEAqOekz+3xt1X30vcezhXYeg3QmJtai2Nkr?=
 =?us-ascii?Q?jpbg/FHwe/7ClHL3HmR1SmSjXwAIuyTEuT2Vx/6Li7DEq823rHJXxo5EYK/Q?=
 =?us-ascii?Q?pv55HAubGsrfKlIzFR+dxLxOq/kK5v18156lG3RSU/JX90VXdNKb4ZWLbPsZ?=
 =?us-ascii?Q?KGICi0pnF/ivUGK9LGdOCMPcKtwrV7ynWFEdTgDQAICBfluh7uZFaGNBXZ5q?=
 =?us-ascii?Q?AfyymTTIZvVWsZvfWe3pOZQeD8aCMys7W3ENcgWmAUUpxhOAMGqwxQzXnT7Y?=
 =?us-ascii?Q?TsyApNfix7uVqfEvD9ZboLdICX5hSbrhm1YhLJgARZY7eW0FlFKIHqVp/0uL?=
 =?us-ascii?Q?eMHA6Gi90OrYm2qJK7oFVfVAUY12arkj6t/2O/9H47+3M1QSGWJDEk6wcfKT?=
 =?us-ascii?Q?sxcH0AeQSchqP7gDDAKRpyk1XgTKKmug99+0A8xzRXB/TfKCCWc5YX/3z+6P?=
 =?us-ascii?Q?LhO2Jp65B1k0V4WVCo49jSEZ5xc1PCLoJkIfJLONVRyP8z1+bsZp+3HJFlHr?=
 =?us-ascii?Q?lrO0TrqD13tpweIl5okylNWwqqnGck1nOIuZ7MIsiWC65ge08ExEVTCR3exD?=
 =?us-ascii?Q?gVhAF6yr7Stu0WsfymVbJT8hFZusdJOdcHnSDh8jGA+y9m4PRTzxUqPka66t?=
 =?us-ascii?Q?eKlsbUjRXo3csTfN2OpdS8httsXSDghrFWz69xfHztXcT35KwXrNJFp5S4XS?=
 =?us-ascii?Q?cVUCw3mEHaLT9Mjv46wt7pa5R+kkhaJOGKl+bu+vbn0Fc5V0T/VpAAg4KHya?=
 =?us-ascii?Q?/TJlXhVoJrbh01boluXpMKSnACPjp8HSevdbaAdjqTClGD9itmuu8EqdRa5R?=
 =?us-ascii?Q?fs6BVhWJrld93HxE+A9QnOucpaYUvWu0UA0NTFXlScxHgZs0yj7wPQXnotcq?=
 =?us-ascii?Q?3vsuItZY9WosLfcI+YK03bZpvxl6+waRw8sGF+Kcn8f5nV0OZmQ5lcRBpnD/?=
 =?us-ascii?Q?SuZQ5TrZLjp+4NhLZQK+TDlFNSd9PU9Nwdxof4dLircN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671341f1-a592-40ed-1022-08dd8cf70f63
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 23:38:10.4532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQyQpIRw0Sused7XFul2JNZ42H1SJdpfocJVZn64e5HvlDIB9kEHbVjO2iGEr0+jTLMD7Zgb+3So4hxFPdAPoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

From: Uday Shankar <ushankar@purestorage.com>

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


