Return-Path: <stable+bounces-211719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDjtOgk5eGmmowEAu9opvQ
	(envelope-from <stable+bounces-211719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 05:03:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 936648FC7C
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 05:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79C6930107D0
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 04:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13431619E;
	Tue, 27 Jan 2026 04:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="u/uSEa5l"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1246A3161BA
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769486596; cv=none; b=lM8FAA1raT3blBxc5sWKhWRa6GS5C752YEKaFIuto8pr0axUkvd+Xh1rs+f9e03x+RKOJqW5cGRkoRfYVfsq2ZSUUH8YW49HDxtSfLE29n5t+4FiCcYssLif9LYUMivQVEmXVnmar3HlhXeOG26hsRb9+0tBS0Uxfz7aDwV555c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769486596; c=relaxed/simple;
	bh=z00k1mNJMCCnnMo882MdaKjIXkbHPxHg+aCyI9sy8kw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=JG6dcHyY8moRVgF4UdkaGtl3XR6R9+nzjnAAkrMmXwJlI8hJayk2SF5fYevHlfUl1e8YYx14/WWA7/fIBOg4dTKcPNTd+h3WvfoXAHG+O4786rIEkKJ1adYDnToJm6XxbtmDb4oeCQGi86OeZz4haiZKS5nYY34SynRMVRdHeHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=u/uSEa5l; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1769486582;
	bh=YFKuTugJWj1dXQygRYo9wKTNykkK0JyFvdmnF5gzMec=;
	h=From:To:Cc:Subject:Date;
	b=u/uSEa5l6Y3hPmEK6QgzDODBHbLhiUuXakq7X+JWDiELBhjsLkEGXTgtHOgVwB+n5
	 o4fFDErCX6FJN5rdO7F3eI+nmEnO4GFZx5z1xsdFVc0RGXtyvj1ijAE6hAcCm6IpkW
	 fOQBBSq3uSJn+FrJqDq7EICRsD4y7eamENp3O7AI=
Received: from ubuntu24.. ([2409:8a00:dd3:9760:874a:c122:32cf:6f61])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id B1B8E6C; Tue, 27 Jan 2026 12:02:49 +0800
X-QQ-mid: xmsmtpt1769486569t2owj6jy0
Message-ID: <tencent_6A48B46F35791FDA92E8D6A1384130E60D08@qq.com>
X-QQ-XMAILINFO: Mi9y8J8807RSt3T4dTeDJtVtwOoAO4qa+Fl/2uUL2F1HsKC3ymb3W9SWZBSx8Y
	 OS8Krl+5Lkgvkbm8ll8Lz4K/Os6cip03UCLKUc5CRJrN5k1uj00x7W/HmnhyZT5wuOdt+9aOQIRs
	 Xcz66yoOnEC65mZwQvd6s8amOgn0RQaYKAbF7JMbsFdSuVzYY867E04uQknVHnZ9BUWN8zrZApbD
	 Zo36u4PLojsERRddAgfLROu9N+Om1qZq071Y7IY/eRaesH4U5m9TmrvOSbrC6vJ4cX0vyXetJQ1Q
	 G+wsq2Vhb4sWzf1Gc6fY0WCswtyD2FU784slLTcizAKaCQqzBCh6h1yEsbUqPuTEZ/xWG1IAlEJy
	 rL+DhXcsb65FKObe67iJ2s5uPLThSqiLkG30WoyZ0/CW101RjfPNlssUmldRWAJ5GHsD7wZ08Mrv
	 SU85JkM3RBeIp45csUUCml/fvqMyl9BL2njeoHSmYBGux7qlAomb3qNAcEfgLODtPCJrCHYzZ7WJ
	 YSy+yCn+rnD0l6jLKoaJUQW6MOqgKJQWU7o3AxDMJndF3ixxabUDH8OBjgMoTTvhebG5Bjlx4Qhf
	 ktsFTAp6bFokdJlkgyr52JM9Sim85HgFK41BXsAj/VdSKDKPtsOXo/70SfBHYSKrKzk/L3j491c5
	 2toThICNvG70Lf20HXe/K8T1rwh0aSfuKgzTOgbLrUwFuB0Gx/zu9kxPTaWitwb+OJynLrxMq7r5
	 rxqR/AB8sDxbfkkLOpzViq54dA/p11m5bJQ0iJ3jY2P4kXNqVJEpHMJjl4Or86lfrBqo/BgDvZl8
	 ucQE6PpljMtAn2314749yMeoexT4HQ4xDYpjIdBsyOKqg3KEhFGzDMR5dje2DV4D7jK/VxOTLEKN
	 AlzVvf4KPexY/sIfbU+fAEWYN/RH8AfAgb49RRrwZL0Ydl9Jyv0ByBuXnumPuls08X71V6biBqJ3
	 qUwaCDix7FOOAR+WgfGwpDv7BqTeDi/GgE7x1iwGXY6QleoztPfggWVSBKxBaJ380OW3gTJGquaU
	 cQ2c+5MeWMlni57SIrZd5eF8OsxFnPSqmEH5+7DaFFd4l2Y+x8KNvQPexl8zkD2Ea2PRYxGkk37n
	 UfN6SRJ2U5RcTfYjY=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.1.y] blk-cgroup: Reinit blkg_iostat_set after clearing in blkcg_reset_stats()
Date: Tue, 27 Jan 2026 04:02:42 +0000
X-OQ-MSGID: <20260127040242.5098-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211719-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[foxmail.com];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,kernel.dk,foxmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 936648FC7C
X-Rspamd-Action: no action

From: Waiman Long <longman@redhat.com>

[ Upstream commit 3d2af77e31ade05ff7ccc3658c3635ec1bea0979 ]

When blkg_alloc() is called to allocate a blkcg_gq structure
with the associated blkg_iostat_set's, there are 2 fields within
blkg_iostat_set that requires proper initialization - blkg & sync.
The former field was introduced by commit 3b8cc6298724 ("blk-cgroup:
Optimize blkcg_rstat_flush()") while the later one was introduced by
commit f73316482977 ("blk-cgroup: reimplement basic IO stats using
cgroup rstat").

Unfortunately those fields in the blkg_iostat_set's are not properly
re-initialized when they are cleared in v1's blkcg_reset_stats(). This
can lead to a kernel panic due to NULL pointer access of the blkg
pointer. The missing initialization of sync is less problematic and
can be a problem in a debug kernel due to missing lockdep initialization.

Fix these problems by re-initializing them after memory clearing.

Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
Fixes: f73316482977 ("blk-cgroup: reimplement basic IO stats using cgroup rstat")
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20230606180724.2455066-1-longman@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ Remove this line: bis -> blkg = blkg for blkg was introduced by commit
  3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()") since v6.2. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 block/blk-cgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index ef596fc10465..f314192b6de8 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -531,8 +531,12 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 			struct blkg_iostat_set *bis =
 				per_cpu_ptr(blkg->iostat_cpu, cpu);
 			memset(bis, 0, sizeof(*bis));
+
+			/* Re-initialize the cleared blkg_iostat_set */
+			u64_stats_init(&bis->sync);
 		}
 		memset(&blkg->iostat, 0, sizeof(blkg->iostat));
+		u64_stats_init(&blkg->iostat.sync);
 
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
-- 
2.43.0


