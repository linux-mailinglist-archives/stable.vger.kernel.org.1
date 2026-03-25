Return-Path: <stable+bounces-230271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPR0OaqAw2nZrAQAu9opvQ
	(envelope-from <stable+bounces-230271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 07:28:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ACD3202A9
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 07:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE8923057904
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 06:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E28C353EF9;
	Wed, 25 Mar 2026 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="m8yuhECE"
X-Original-To: stable@vger.kernel.org
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB5F313546
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420129; cv=none; b=T6iWTOw3AZV4eDU0VsidiAmrThkhMyqOTDSOJsmJ+akHH3ZsFQ7E4c6mtE1wl1qWEfXnx4aa7VqaqK/ms5bM/YNYCkMItJuML3tD+yx0+1UYgFrBWZBRrxa3vCUxpjpuEqDXG4BjFa2HuXBwdYW3GxhlWaTgjruPYEzFVgGE1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420129; c=relaxed/simple;
	bh=p7NXvVvfQNlLWr8HKYPTEjTaPzpyR1QqPIXdkZ4u9Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oVVwz2TN0TSc662Vcmr7kDdjEdiRIjKMCTpq7EbU7brReYxlLcRQ1gqffdqwv0GGsKhe1BmDqP5DLM29DBTzvKx0GodgDhsPhT1/U46c89dgsXqYPVCj/zlE8ncLptkg46vW1zwceZtGBSbq67MciLx2ygLNrQONUQ0IoaMpV88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=m8yuhECE; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1774420123;
	bh=TMsRB3to/k/zBcz+8Wn5OoGb/as2lSJ6brutYuCSE3Y=;
	h=From:Subject:Date:Message-Id;
	b=m8yuhECEwbQREifzxD+75CW3Q98HBuNHCUgZXZEz/8hsJy+8ocZr6YmvqR4bMYIu5
	 ulZPK/SsTRv8dpCEJvFFUme77zE2/Fkcp+R2HNLFYGMbwTRRuUyZmwp5zl3QAG0++D
	 lVUmsLifq5nzzmv6D0CsQucerYe+FTbFd3P0OocI=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.23) with ESMTP
	id 69C3808900006AF4; Wed, 25 Mar 2026 14:28:34 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 1918078912987
X-SMAIL-UIID: 5BCB09C9359243C397048549FCFF42E9-20260325-142834-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Song Liu <song@kernel.org>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 5.15.y] md/md-bitmap: Synchronize bitmap_get_stats() with bitmap lifetime
Date: Wed, 25 Mar 2026 14:28:24 +0800
Message-Id: <20260325062824.2373999-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230271-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,huawei.com,oracle.com,kernel.org,sina.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sina.com:dkim,sina.com:email,sina.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,oracle.com:email]
X-Rspamd-Queue-Id: A0ACD3202A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 8d28d0ddb986f56920ac97ae704cc3340a699a30 ]

After commit ec6bb299c7c3 ("md/md-bitmap: add 'sync_size' into struct
md_bitmap_stats"), following panic is reported:

Oops: general protection fault, probably for non-canonical address
RIP: 0010:bitmap_get_stats+0x2b/0xa0
Call Trace:
 <TASK>
 md_seq_show+0x2d2/0x5b0
 seq_read_iter+0x2b9/0x470
 seq_read+0x12f/0x180
 proc_reg_read+0x57/0xb0
 vfs_read+0xf6/0x380
 ksys_read+0x6c/0xf0
 do_syscall_64+0x82/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Root cause is that bitmap_get_stats() can be called at anytime if mddev
is still there, even if bitmap is destroyed, or not fully initialized.
Deferenceing bitmap in this case can crash the kernel. Meanwhile, the
above commit start to deferencing bitmap->storage, make the problem
easier to trigger.

Fix the problem by protecting bitmap_get_stats() with bitmap_info.mutex.

Cc: stable@vger.kernel.org # v6.12+
Fixes: 32a7627cf3a3 ("[PATCH] md: optimised resync using Bitmap based intent logging")
Reported-and-tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/linux-raid/ca3a91a2-50ae-4f68-b317-abd9889f3907@oracle.com/T/#m6e5086c95201135e4941fe38f9efa76daf9666c5
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20250124092055.4050195-1-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
[ The context change is due to the commit 38f287d7e495
("md/md-bitmap: replace md_bitmap_status() with a new helper md_bitmap_get_stats()")
in v6.12 and the commit f9cfe7e7f96a ("md: Fix md_seq_ops() regressions") in v6.8
which are irrelevant to the logic of this patch. ]
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 drivers/md/md-bitmap.c | 4 ++++
 drivers/md/md.c        | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 03efb3c72980..2789dbbd7eaf 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2033,6 +2033,10 @@ void md_bitmap_status(struct seq_file *seq, struct bitmap *bitmap)
 
 	if (!bitmap)
 		return;
+	if (bitmap->mddev->bitmap_info.external)
+		return;
+	if (!bitmap->storage.sb_page) /* no superblock */
+		return;
 
 	counts = &bitmap->counts;
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 332458ad9663..bb6b5360d94b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8300,6 +8300,9 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		return 0;
 	}
 
+	/* prevent bitmap to be freed after checking */
+	mutex_lock(&mddev->bitmap_info.mutex);
+
 	spin_lock(&mddev->lock);
 	if (mddev->pers || mddev->raid_disks || !list_empty(&mddev->disks)) {
 		seq_printf(seq, "%s : %sactive", mdname(mddev),
@@ -8371,6 +8374,7 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "\n");
 	}
 	spin_unlock(&mddev->lock);
+	mutex_unlock(&mddev->bitmap_info.mutex);
 
 	return 0;
 }
-- 
2.34.1


