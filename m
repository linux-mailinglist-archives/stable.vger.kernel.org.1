Return-Path: <stable+bounces-140847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F5DAAAC08
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738D43B97F5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DFB3BA873;
	Mon,  5 May 2025 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAK9SlgA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699392EE16D;
	Mon,  5 May 2025 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486545; cv=none; b=niDhWJiQV9H4+wu98IOzGe52rSZk9bDEDiQZHljblPD3hHX3AQ1hbe5UFjnSuAmQV1HVMbYPERFVxTy4FeAroKc6NplNRZFdrCzi2EAS8zcllcNwprVJ+ESEryz21MMSfM0WD/fOsefxJiO4IxrNbQLo9SccHfot/M58mCstD2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486545; c=relaxed/simple;
	bh=SRnRJO6g1B7jvzWhfxhh5YTRN7XIca6siImFMw6aC7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z19XXIO6QvSqojVe77R77LeQQEzON0ry7UgwmWv2H/dJLy2ajpKi2f0Hfj+mlYIjSoS0MzJN/kCpzHZlQJtN4wOdfcmFnimyVA2VGLGclkWnIkSe8/xi/z3RlW//JHH2EWzGg2K0PgfCd74ydiHVru7r0eBxKj/I+tUOqzeDy4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAK9SlgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4843DC4CEE4;
	Mon,  5 May 2025 23:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486545;
	bh=SRnRJO6g1B7jvzWhfxhh5YTRN7XIca6siImFMw6aC7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAK9SlgAyY63JbqUCLnAH7K3yy5WmOAbkhSwB4Q3PQZdb5NcZGqHz7qkU0kPlo0jQ
	 19I6BSVBNcr8uoi/3geh7VZYWIQM4gdo2VvGBW4Nc0b8VOclUmYiqZjpYoVkxSMKVt
	 gZ5/BkgYGUkfcsubVtoyRFwoJMYUFBVf+cbCGbXVq/AC+gBy4Og5rCERzRg2FR5bpj
	 K6hlSErCkjIHe+bak5JwelRqTSH+ABtE9rkdaQ0O3vJR+XkesAX5wYnCNXgKciMhE6
	 scdC8RqixEzCoIABN5zE2gAEaCDLPQ92IkBzVn3Xh6wMOTjlCIMwsvPYbgJ3QbDKy6
	 b68fX+BcBUhFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot+2d373c9936c00d7e120c@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	viro@zeniv.linux.org.uk,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 082/212] ALSA: seq: Improve data consistency at polling
Date: Mon,  5 May 2025 19:04:14 -0400
Message-Id: <20250505230624.2692522-82-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit e3cd33ab17c33bd8f1a9df66ec83a15dd8f7afbb ]

snd_seq_poll() calls snd_seq_write_pool_allocated() that reads out a
field in client->pool object, while it can be updated concurrently via
ioctls, as reported by syzbot.  The data race itself is harmless, as
it's merely a poll() call, and the state is volatile.  OTOH, the read
out of poll object info from the caller side is fragile, and we can
leave it better in snd_seq_pool_poll_wait() alone.

A similar pattern is seen in snd_seq_kernel_client_write_poll(), too,
which is called from the OSS sequencer.

This patch drops the pool checks from the caller side and add the
pool->lock in snd_seq_pool_poll_wait() for better data consistency.

Reported-by: syzbot+2d373c9936c00d7e120c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/67c88903.050a0220.15b4b9.0028.GAE@google.com
Link: https://patch.msgid.link/20250307084246.29271-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_clientmgr.c | 5 +----
 sound/core/seq/seq_memory.c    | 1 +
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 2d707afa1ef1c..1252ea7ad55ea 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1140,8 +1140,7 @@ static __poll_t snd_seq_poll(struct file *file, poll_table * wait)
 	if (snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_OUTPUT) {
 
 		/* check if data is available in the pool */
-		if (!snd_seq_write_pool_allocated(client) ||
-		    snd_seq_pool_poll_wait(client->pool, file, wait))
+		if (snd_seq_pool_poll_wait(client->pool, file, wait))
 			mask |= EPOLLOUT | EPOLLWRNORM;
 	}
 
@@ -2382,8 +2381,6 @@ int snd_seq_kernel_client_write_poll(int clientid, struct file *file, poll_table
 	if (client == NULL)
 		return -ENXIO;
 
-	if (! snd_seq_write_pool_allocated(client))
-		return 1;
 	if (snd_seq_pool_poll_wait(client->pool, file, wait))
 		return 1;
 	return 0;
diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index 47ef6bc30c0ee..e30b92d85079b 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -366,6 +366,7 @@ int snd_seq_pool_poll_wait(struct snd_seq_pool *pool, struct file *file,
 			   poll_table *wait)
 {
 	poll_wait(file, &pool->output_sleep, wait);
+	guard(spinlock_irq)(&pool->lock);
 	return snd_seq_output_ok(pool);
 }
 
-- 
2.39.5


