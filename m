Return-Path: <stable+bounces-220164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGzfLRUyo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:21:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C34321C5B1B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B94E310FBB7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE004968E7;
	Sat, 28 Feb 2026 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKoJgdTS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272E4963DD;
	Sat, 28 Feb 2026 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300072; cv=none; b=CD0BVv/hrzQordmEJKRctV+dcVULotd2QJ/+ntFm10PPjhWmg9GUMU8/0VXzkNOs+3QdCqyvq0t+5qtafYHDVyPte8v6hMcqDXjHRFgnSJJrz07q1AI8zIrr675l8p6iewY7hWeu/BIbXOakkq/PXqr5po3Mrq8wKy2k3NgVPMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300072; c=relaxed/simple;
	bh=NJLBrRX2j4NQXdAxOknzdGN5sq8YYJbadoVPGouiUgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bq6CCxXRJnKGyzDvVapqoE24o1V0GvZJjj4wsViAkP+YAJrC+do9f4Z6DtrhCkjz39Mg5EB0fK6gR4ZoVEEI94AmlBSCJs7TKwxWRgRyu305Iqy6RwpWqUo/TCm0Jy/rA7bmr7buyE9mY+M6wDrwxYzAOjIQNCsti8P/EcDh/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKoJgdTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080A5C116D0;
	Sat, 28 Feb 2026 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300071;
	bh=NJLBrRX2j4NQXdAxOknzdGN5sq8YYJbadoVPGouiUgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PKoJgdTSiWfkQYKb3buqqp2ZlGfojiTw20RQkssXYJqiSD3OpDf1QuZjEK0A1wtbF
	 Z4YDi/9GvVcRvaFffR/wvZdHu/Cf/fJ+r5ryeRUYuJijkaRNVASF1lpAdqCz+m0R5a
	 s9mcFdCK7wh9kgk81VlzfuvQfYz5RlyNTjcN0TDh6SRsFWxQL81fnNkaLMsMjJ+8nY
	 AqUz3PiikC2+oNsJcy+/HIi5mFzRQBjOm6b4L846iUJxtTTQbh9SNaSzWGDbj+fPLn
	 LuNAszbSnbVQQhOv2eIJWJQqzHHsTbWqBiY9wjBTqzIOBqfFco/bqLvGX+aRWO5+wW
	 L5Zl0i7af+v6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai@fnnas.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 086/844] blk-mq-debugfs: add missing debugfs_mutex in blk_mq_debugfs_register_hctxs()
Date: Sat, 28 Feb 2026 12:19:59 -0500
Message-ID: <20260228173244.1509663-87-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220164-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel.dk:email,fnnas.com:email]
X-Rspamd-Queue-Id: C34321C5B1B
X-Rspamd-Action: no action

From: Yu Kuai <yukuai@fnnas.com>

[ Upstream commit 9d20fd6ce1ba9733cd5ac96fcab32faa9fc404dd ]

In blk_mq_update_nr_hw_queues(), debugfs_mutex is not held while
creating debugfs entries for hctxs. Hence add debugfs_mutex there,
it's safe because queue is not frozen.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq-debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4896525b1c054..553d93b88e194 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -686,8 +686,10 @@ void blk_mq_debugfs_register_hctxs(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
+	mutex_lock(&q->debugfs_mutex);
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_debugfs_register_hctx(q, hctx);
+	mutex_unlock(&q->debugfs_mutex);
 }
 
 void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
-- 
2.51.0


