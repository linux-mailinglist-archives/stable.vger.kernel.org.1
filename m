Return-Path: <stable+bounces-76990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F221984578
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 14:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0AC28541A
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 12:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A111A707C;
	Tue, 24 Sep 2024 12:04:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F821A7058;
	Tue, 24 Sep 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179472; cv=none; b=Utk2zP0DFuLfe+O3Hp6vZIBaXF84gNCiY9PjMyf9f0zntxLHJVCvXJ8mrqY+hkSxX1Es97Xx6HHGOsSMosSLL4EisQddAKpMLM6s8Owm4Z01b3LMmqnfckWunxJYrXcY1LMaTDAml7Ed7fNT9vnqLGkeRh4qdo4bXW8nkUs5J/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179472; c=relaxed/simple;
	bh=YdL10GeXIjk2nbU0lsa5VntCDc2dr0aErMRWGxduYus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJgcjegTh+Zh0jRUJRzxwMKtT0pjdKd4bE2oRw8++jRX54Zqen57urDTx6er99vc1IVsLijig68vc+7pImmGqfCCHJ9MJ1QDNG/i8+BogefpqcSe0KVS5Mrs6zjCAUME19+WVZEzPJX50CAI1rcmZgFDpyJTUe0MyuufxQa4EvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 24 Sep
 2024 15:04:18 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 24 Sep
 2024 15:04:18 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Jaegeuk Kim
	<jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 6.1 1/1] f2fs: convert to MAX_SBI_FLAG instead of 32 in stat_show()
Date: Tue, 24 Sep 2024 05:04:11 -0700
Message-ID: <20240924120411.34948-2-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924120411.34948-1-n.zhandarovich@fintech.ru>
References: <20240924120411.34948-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

From: Yangtao Li <frank.li@vivo.com>

commit 5bb9c111cd98ad844d48ace9924e29f56312f036 upstream.

BIW reduce the s_flag array size and make s_flag constant.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[Nikita: This patch has been cherry-picked from original commit:
the only discrepancy was in stat_show(). Specifically, due to
lack of commit dda7d77bcd42 ("f2fs: replace si->sbi w/ sbi in
stat_show()") keep &si->sbi->s_flag instead of &sbi->s_flag.]
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 fs/f2fs/debug.c | 36 ++++++++++++++++++------------------
 fs/f2fs/f2fs.h  |  6 +++++-
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index a9baa121d829..002bf12b4e26 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -332,22 +332,22 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 #endif
 }
 
-static char *s_flag[] = {
-	[SBI_IS_DIRTY]		= " fs_dirty",
-	[SBI_IS_CLOSE]		= " closing",
-	[SBI_NEED_FSCK]		= " need_fsck",
-	[SBI_POR_DOING]		= " recovering",
-	[SBI_NEED_SB_WRITE]	= " sb_dirty",
-	[SBI_NEED_CP]		= " need_cp",
-	[SBI_IS_SHUTDOWN]	= " shutdown",
-	[SBI_IS_RECOVERED]	= " recovered",
-	[SBI_CP_DISABLED]	= " cp_disabled",
-	[SBI_CP_DISABLED_QUICK]	= " cp_disabled_quick",
-	[SBI_QUOTA_NEED_FLUSH]	= " quota_need_flush",
-	[SBI_QUOTA_SKIP_FLUSH]	= " quota_skip_flush",
-	[SBI_QUOTA_NEED_REPAIR]	= " quota_need_repair",
-	[SBI_IS_RESIZEFS]	= " resizefs",
-	[SBI_IS_FREEZING]	= " freezefs",
+static const char *s_flag[MAX_SBI_FLAG] = {
+	[SBI_IS_DIRTY]		= "fs_dirty",
+	[SBI_IS_CLOSE]		= "closing",
+	[SBI_NEED_FSCK]		= "need_fsck",
+	[SBI_POR_DOING]		= "recovering",
+	[SBI_NEED_SB_WRITE]	= "sb_dirty",
+	[SBI_NEED_CP]		= "need_cp",
+	[SBI_IS_SHUTDOWN]	= "shutdown",
+	[SBI_IS_RECOVERED]	= "recovered",
+	[SBI_CP_DISABLED]	= "cp_disabled",
+	[SBI_CP_DISABLED_QUICK]	= "cp_disabled_quick",
+	[SBI_QUOTA_NEED_FLUSH]	= "quota_need_flush",
+	[SBI_QUOTA_SKIP_FLUSH]	= "quota_skip_flush",
+	[SBI_QUOTA_NEED_REPAIR]	= "quota_need_repair",
+	[SBI_IS_RESIZEFS]	= "resizefs",
+	[SBI_IS_FREEZING]	= "freezefs",
 };
 
 static int stat_show(struct seq_file *s, void *v)
@@ -367,8 +367,8 @@ static int stat_show(struct seq_file *s, void *v)
 			"Disabled" : (f2fs_cp_error(si->sbi) ? "Error" : "Good"));
 		if (si->sbi->s_flag) {
 			seq_puts(s, "[SBI:");
-			for_each_set_bit(j, &si->sbi->s_flag, 32)
-				seq_puts(s, s_flag[j]);
+			for_each_set_bit(j, &si->sbi->s_flag, MAX_SBI_FLAG)
+				seq_printf(s, " %s", s_flag[j]);
 			seq_puts(s, "]\n");
 		}
 		seq_printf(s, "[SB: 1] [CP: 2] [SIT: %d] [NAT: %d] ",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2b540d87859e..75db7c09bdfe 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1271,7 +1271,10 @@ struct f2fs_gc_control {
 	unsigned int nr_free_secs;	/* # of free sections to do GC */
 };
 
-/* For s_flag in struct f2fs_sb_info */
+/*
+ * For s_flag in struct f2fs_sb_info
+ * Modification on enum should be synchronized with s_flag array
+ */
 enum {
 	SBI_IS_DIRTY,				/* dirty flag for checkpoint */
 	SBI_IS_CLOSE,				/* specify unmounting */
@@ -1288,6 +1291,7 @@ enum {
 	SBI_QUOTA_NEED_REPAIR,			/* quota file may be corrupted */
 	SBI_IS_RESIZEFS,			/* resizefs is in process */
 	SBI_IS_FREEZING,			/* freezefs is in process */
+	MAX_SBI_FLAG,
 };
 
 enum {

