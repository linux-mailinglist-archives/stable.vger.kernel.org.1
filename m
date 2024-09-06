Return-Path: <stable+bounces-73772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7618B96F209
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 12:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D4A2849B7
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72C5153598;
	Fri,  6 Sep 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="bHDiieit"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2104.outbound.protection.outlook.com [40.107.21.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F31C9DD3
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620321; cv=fail; b=YvGxdxRklLaIY3oEnqaaGH8X93uXJKFqs7RUg/pOOaByEzbBLJi3emUIfZIzCAv3+0CN2w0v+FqL+DCCW/TuNkAfdrny1GLbMWldvwSnNFc8rGy/iWgaf6mEYdUNHLvTTRhf+sfEiJ+jaEaZz4jo9b75+TVvXbvN1hm/51o+kNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620321; c=relaxed/simple;
	bh=IUd/Jx7wLx/0uEP9mSrVJDUmItV+50AWrDt22q+x8w0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YHelT5894CDpO206TBJh2EWafssxQBYpcOMPFOkqlkyJclw8RJ1dywVHZK2XKXDMKeaJGDbqCz4tlq670hzTcpfJobC3qL0lDVezYdIzMiOdFcX4TCFpaHgl460BqRshXEFRLpI0o1EO66vYsirGKUOUAAaqeoBr+CLFi8uV1XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=bHDiieit; arc=fail smtp.client-ip=40.107.21.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVEHpXhVX5krY58gHo813I+1rlgJsQY3sjv6ILQGrgFOvE9V09HHTb/20qQHfF3hJ8hjgrQ9BcBvr59N0/B1jMiQ3KupIfLH84Oo0DmfHH5XiA3mzFffqs5VowZIA6iB8ai+KONLmccZv/zBEhZnKe643/X9TMXTlXPf109s2rad7OV1HKTvQJHetNsU3h9tNH10k3UkAUUg+fxRIODP5zsT8T7bHX2h1zzo9LY42gfcCgrsSxNWYgzJBCOu11N09M8rrF+c+nrhBfRabL7vi0mREYpbojHtBHNtOYcj8YKmV9qZ90luZflgRlWKW0pv9MmMLYbkLi8uNmtCLinfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTtam2OiJWOIEqtLcsW0jQmrlNJdcUbS26lB/MVwTIA=;
 b=qfk+SccrRA+b/uAzDhKPeUmQfxt0e4XXW7PKUmZxtq5iQTfUGSqDDh4HSNwU6XZuTjHkiELNGlNJb/1nZ0lkOy7C4VzhRVKa4YTMZthjNAewmoFWoMf05HvSehM2oPR1da8kBANiwE4RT7+wYg/ZAHlead1NUrlxtiB9BsCi7+wfSNLtCCR8kDXoCJmRt0JZ0G87kOR/v43dm+aC2eSxSR9DlI8yiZkXlo3+M+dQyccQYVEa5t1Zqyf0sH8Sp6DApqN+iMCYgbz8IhrFHHkZ59IGqT1dsuimDTkvAjjRQxCKiXy04LmqCdxIASsktP/PJno6G9BBjp11Qs43/y+jiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTtam2OiJWOIEqtLcsW0jQmrlNJdcUbS26lB/MVwTIA=;
 b=bHDiieitpzuD55IlmSUdlNNCtM4lPI94gwWrECaBWpSqD0OmQMNUG+aXzmxS9orBAK8wUL764FQk0BcSNnTXp9acB1Gwq9keSKhW1amU5+adjnq5b33BK52J6NZCdX3pjTECSJd1ePUSzkROlpeWQTE0u3vN0wIxA3WMbKuZPVHknBkYUq04MsEAzI2uSSbYDAf6lbC2rOdtzP3YTl/93PkUwcjSRwBtX1s+yh9D3ednRIuKunrQsLYthq+sJWKcQ05YF/6G2kS5h6CdtXq2wfLFRRROS47qcKCMbaDnTmGhFBVORFOLErpHAkGaMBnLdnGBB4jTTxUURguznR6Anw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by VI0P192MB2314.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:23d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 10:58:31 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 10:58:31 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 5.10] btrfs: fix use-after-free after failure to create a snapshot
Date: Fri,  6 Sep 2024 12:58:11 +0200
Message-ID: <20240906105811.93397-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0106.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::11) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|VI0P192MB2314:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f4aa1c-50ce-4cb9-01a8-08dcce62d863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lHdIwOb/haalqf/3zdTvG6XvAY3BwfsGr54BGwHeMCnaa3kNfwEvl9fjFeVm?=
 =?us-ascii?Q?aU1D68guMeInsNSKzxdXM1lt2AokNZv+kd/hEyejSzOrvYHe8/orE+891inf?=
 =?us-ascii?Q?nQVo9YF6px+BBGzp0TEANl4sqiN0Aa7S437d5IBV83i1Qx6yPYovpRBeKCuz?=
 =?us-ascii?Q?v4kxRZxSiLzKgLItPHSkikP+h2iInVoyPqOzj4NOHYR2IebWYzbyNGAm52eJ?=
 =?us-ascii?Q?EhTUdVLf2USggNFigmpvoB+UnOz8Xvs9T18eiU/NU7YS5pFitSepswo7w0lB?=
 =?us-ascii?Q?B0Y32gEK6hE1kK0sHn2cspmaGBlFIe14ale/JvLHsyIx9v61wtpSPvJIt5Wx?=
 =?us-ascii?Q?Znd0sEW/2OqxtzJidzOifyyCG+TRYTi0ADw4+7Igl0UdNWoj0CiOF0iiLEkj?=
 =?us-ascii?Q?3joF1dMNVnyYXm02RMxT+sSdWhRLjxJ/ME2FjDiOuCKny0erZdhgInDHK61H?=
 =?us-ascii?Q?QR0MwXmE0AEzY+I7/8fj3BFYGyRhwVhUD6YonqlYaaEmS8wQBBt/fkarsLMC?=
 =?us-ascii?Q?mTLLw9sAqgfvXrorUxu5EiLEdVtfYmAr2wyoHQ9q4W3JrDf3lcUA+Aes6OgB?=
 =?us-ascii?Q?dlSbxkBnJQrKmdLLGHvOFwP79FEP/0Ya9khFzmdAUhu44rB4wBXSAUzmR4CU?=
 =?us-ascii?Q?6VkMzbvSrlPoKTeqz7O0wgOO4aiDOgTWEGMWnNP1BFbuG+mbk6konfqWQDEe?=
 =?us-ascii?Q?QugmICitANd9FdzA87YZAVFXKRDjvWpghP1ySjR3gBBpnoLcoqxEFfmJLCzq?=
 =?us-ascii?Q?qFzvUMC4Y/WKynvYfyaNi+NUaMBg5BJ31C1V1zZ8t7UwtRX0Q9L8OBGoWGp0?=
 =?us-ascii?Q?6w1wh7fEbjUkOC3bvG7XmDe1lmmU+Dhf/Cw+5QKsZyWQi+LWtvVFKlrWksHt?=
 =?us-ascii?Q?be34iVI6hytIl2Hhko7Z/+2QEnQH3pcuN7l5h+Q0Pa759DlypW1gCTiOFnMK?=
 =?us-ascii?Q?VbFvNMkimveot4tYnboQieiq/1z2y/GcxDwZMyDgoRlLWN47aFSrBQvSA3ft?=
 =?us-ascii?Q?13xpsF5SvfspCqn882fUFBBTWGipHEv6IwJg5eTUodFGy8n1fJBZmzs3cCVF?=
 =?us-ascii?Q?EJlEx4OGCHm5AF+z+NS2wECLN3Q8Jd/5ktSl4rbhW/XJmOKRiI3EDMJEsK8J?=
 =?us-ascii?Q?lEFj+FQT0MgjNNGF5/MHrvVkurff4gcKGK6KndR0xpV5LXXgTzITIDVPI9K8?=
 =?us-ascii?Q?v+/bU66XvZv93WHXUwOjKjac3GawL62UBNXpdpU9uYlullBhNPiwGFz3A+MG?=
 =?us-ascii?Q?Y+mmQFDNpYEzFjsye3dD/7itGH4/IRYo0MVH10K53k7kCCBvYFL41+qIgxrt?=
 =?us-ascii?Q?QFhMp3xlYUTQyZbKDlwmvWHgJ07RxACHpeSHN+UTWF/TM0Q6x49aNtV7kSaF?=
 =?us-ascii?Q?q9PhCZlxzBfguieiUmkgEeP7spIs+We+8bznOi3MeGjJkFbjBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ix3wOAH0p94x3WJ5pGEc7FYi7sXTK7qsZrFL5H/ZMhPG/+/eUqPJTESbBPXp?=
 =?us-ascii?Q?6LnWicALJvGhRSItOCCcUF6HscWsC1gHzHSwrGyvPphyTg8uSOGOv5LWiK4U?=
 =?us-ascii?Q?3yZ3JB3y6Yf4yFMdURtqHsHyr9mHMMMPPl0tXmgOYjiflF1kbIPaOQj74FmC?=
 =?us-ascii?Q?EQF/YHtW7V4omlNyvszPpt5Xw5Nt+D+IK+JomKU5uqQS1d17f0ozW82+IO6j?=
 =?us-ascii?Q?Z5vm4NTDQoC40ZJb/K1eNrlMl3yb+I2e6Ejv63JN9bY1MZEttTZp325ERgwQ?=
 =?us-ascii?Q?wfRL1N76gPTinVYcI/WZ0PPkVOAKaBy8vgBP8Vk9VDKerDXShEnIUgsXxVd3?=
 =?us-ascii?Q?3sa5sDJO9eh1vFuoU5RNvFcAQMmfJc76ezLpUyJqfsy1xWvI5FFGvMET0FIq?=
 =?us-ascii?Q?IjYne84glkMnqWXTkB1imBwqWkAzsp/IosqlYLaZZUwQaxd3utPRILT4voit?=
 =?us-ascii?Q?kzYjoJblJc/y1hBc/Tw4RykhdZIuwJlxMmwLheXBY2o/Gm2osDMxH3A/BMJ3?=
 =?us-ascii?Q?KHIkqCn7MV5gcwY6o0v894sd6FpADTy6qVpPzDViEskBFJ6z/r34PnMTPqGZ?=
 =?us-ascii?Q?NyQbB0qp4bNv/Y4D+M6SQYOMfSLqaLSBJ8bNxh7ZAnPO7dDbOGRP7nMQQvBl?=
 =?us-ascii?Q?QCfMDuv5Uw8FlCBN2z2EoKDKY/PfiokYXF2e+lQHoi820DY73jyKBp5kZSQ1?=
 =?us-ascii?Q?bRHik4ymrmQOiLU9jt+a5zpoKfx8SaQuSSnGilEpS5jd7m/Lj2vU17zjIy3p?=
 =?us-ascii?Q?gkQFLp0M0XzQIpnW7vtzpK9a02+jLxTZiqpzjwGBpsJLNIUDXbh7NIPpXgrm?=
 =?us-ascii?Q?6eFkfg6vFnEXlcyPSf1i1IikVQMXhMykcsjocV/WeRebdOL/UeoMeNC0mvMC?=
 =?us-ascii?Q?nE3x9xQOjhJVKNoXdFWTr4UhJcMa+y1nEtXBa83wspFNFkT9KJZlPmA/uWQR?=
 =?us-ascii?Q?5J3QamI4oMbbMealvR1AJwl5mMlfBzC0UoJ4QiBG6RmURVI5ar7OTvV7Xx+U?=
 =?us-ascii?Q?Q/ijz26bLahFJHTGAC27XxDlou+rQ9Z0Jb3nV99fOGP89M1qkXEvtaidu7qN?=
 =?us-ascii?Q?QrQ1voXSC4Bfd7bfICvzb8fNPBFviAqUMPc4w+Et11pdj0EK2yrUrqSuJpb8?=
 =?us-ascii?Q?ogWZb0SNv74OufzY0zSND2O69839NWc4hB2Wcmz4s/swOrm/0m/WMLaim+Ps?=
 =?us-ascii?Q?xrnruu/VVyRQBU+9J+MDgvRwnpHP7veF+hJ/bezHZCOj8xTQUo3tj1k4Xafp?=
 =?us-ascii?Q?go6OJCaQadSr8DpMl/dwJEyZbEmdj2KpQX1tLoiNA6/egnAmsuj9zst1VLdH?=
 =?us-ascii?Q?bv+TJhJBq4YY3+1fhnmn7Z9UijOqPsUCDW3GrogO9HCqvUrdC5Y95/LoELAo?=
 =?us-ascii?Q?qG5UwStSd1o9BlSj25JEyjHGY3nFJkH51/2BsFodcPSTqB1+s1VICnDyRFC2?=
 =?us-ascii?Q?sVAa2r+3yIRluOLO1Mj7fSSwpsAo/vr8dmN/+/9UqFTa4CZ+ZvZf1E0AEUpi?=
 =?us-ascii?Q?nZ17vB2ZKcHpoTRRKduulizO3h01I9tfzMYVy+u3KfCXOjEHhlqO4Lmdp9WV?=
 =?us-ascii?Q?AevYgtyiAPYubCAQt3orULl0fhWwcAz4M4SoJXaqovQA4OQT6FBnIJGnlS8k?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f4aa1c-50ce-4cb9-01a8-08dcce62d863
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 10:58:31.3767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3Q7pbsmpaIXY1X2PQONw3GbkDRkT68675ABvT767RNJzsZwRMspCEOHV2PN9e96ppkoU5oVivnmrAX9eFxKBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P192MB2314

From: Filipe Manana <fdmanana@suse.com>

commit 28b21c558a3753171097193b6f6602a94169093a upstream.

At ioctl.c:create_snapshot(), we allocate a pending snapshot structure and
then attach it to the transaction's list of pending snapshots. After that
we call btrfs_commit_transaction(), and if that returns an error we jump
to 'fail' label, where we kfree() the pending snapshot structure. This can
result in a later use-after-free of the pending snapshot:

1) We allocated the pending snapshot and added it to the transaction's
   list of pending snapshots;

2) We call btrfs_commit_transaction(), and it fails either at the first
   call to btrfs_run_delayed_refs() or btrfs_start_dirty_block_groups().
   In both cases, we don't abort the transaction and we release our
   transaction handle. We jump to the 'fail' label and free the pending
   snapshot structure. We return with the pending snapshot still in the
   transaction's list;

3) Another task commits the transaction. This time there's no error at
   all, and then during the transaction commit it accesses a pointer
   to the pending snapshot structure that the snapshot creation task
   has already freed, resulting in a user-after-free.

This issue could actually be detected by smatch, which produced the
following warning:

  fs/btrfs/ioctl.c:843 create_snapshot() warn: '&pending_snapshot->list' not removed from list

So fix this by not having the snapshot creation ioctl directly add the
pending snapshot to the transaction's list. Instead add the pending
snapshot to the transaction handle, and then at btrfs_commit_transaction()
we add the snapshot to the list only when we can guarantee that any error
returned after that point will result in a transaction abort, in which
case the ioctl code can safely free the pending snapshot and no one can
access it anymore.

CC: stable@vger.kernel.org # 5.10+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 fs/btrfs/ioctl.c       |  5 +----
 fs/btrfs/transaction.c | 24 ++++++++++++++++++++++++
 fs/btrfs/transaction.h |  2 ++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ab8ed187746e..24c4d059cfab 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -853,10 +853,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 		goto fail;
 	}
 
-	spin_lock(&fs_info->trans_lock);
-	list_add(&pending_snapshot->list,
-		 &trans->transaction->pending_snapshots);
-	spin_unlock(&fs_info->trans_lock);
+	trans->pending_snapshot = pending_snapshot;
 
 	ret = btrfs_commit_transaction(trans);
 	if (ret)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8cefe11c57db..8878aa7cbdc5 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2075,6 +2075,27 @@ static inline void btrfs_wait_delalloc_flush(struct btrfs_trans_handle *trans)
 	}
 }
 
+/*
+ * Add a pending snapshot associated with the given transaction handle to the
+ * respective handle. This must be called after the transaction commit started
+ * and while holding fs_info->trans_lock.
+ * This serves to guarantee a caller of btrfs_commit_transaction() that it can
+ * safely free the pending snapshot pointer in case btrfs_commit_transaction()
+ * returns an error.
+ */
+static void add_pending_snapshot(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_transaction *cur_trans = trans->transaction;
+
+	if (!trans->pending_snapshot)
+		return;
+
+	lockdep_assert_held(&trans->fs_info->trans_lock);
+	ASSERT(cur_trans->state >= TRANS_STATE_COMMIT_START);
+
+	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots);
+}
+
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -2161,6 +2182,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	spin_lock(&fs_info->trans_lock);
 	if (cur_trans->state >= TRANS_STATE_COMMIT_START) {
+		add_pending_snapshot(trans);
+
 		spin_unlock(&fs_info->trans_lock);
 		refcount_inc(&cur_trans->use_count);
 		ret = btrfs_end_transaction(trans);
@@ -2243,6 +2266,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * COMMIT_DOING so make sure to wait for num_writers to == 1 again.
 	 */
 	spin_lock(&fs_info->trans_lock);
+	add_pending_snapshot(trans);
 	cur_trans->state = TRANS_STATE_COMMIT_DOING;
 	spin_unlock(&fs_info->trans_lock);
 	wait_event(cur_trans->writer_wait,
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index f73654d93fa0..eb26eb068fe8 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -122,6 +122,8 @@ struct btrfs_trans_handle {
 	struct btrfs_transaction *transaction;
 	struct btrfs_block_rsv *block_rsv;
 	struct btrfs_block_rsv *orig_rsv;
+	/* Set by a task that wants to create a snapshot. */
+	struct btrfs_pending_snapshot *pending_snapshot;
 	refcount_t use_count;
 	unsigned int type;
 	/*
-- 
2.43.0


