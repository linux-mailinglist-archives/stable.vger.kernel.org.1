Return-Path: <stable+bounces-232938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIdhNcIqzmnIlQYAu9opvQ
	(envelope-from <stable+bounces-232938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:37:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F103861E3
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 380FF3011596
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 08:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F1833F5AF;
	Thu,  2 Apr 2026 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Imf6nAnL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA671A2392
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118741; cv=none; b=hGb1okOaodn1qoIhLhFjof1iPAi6q7UGJmuPmH98LRPtoxYjpygPuiCz4kZ8I/aS0MQIUY1/5MuYcETrguNujSB5q/kFLkPUFIlED3otecOyknyGaIla/6D3CuJwI4y4pZ2MMk7LqYGWZDnGuIVgSi+YzphXRgkVlU8EOjw6kcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118741; c=relaxed/simple;
	bh=nrb6HIjhgxKYnR0UDduqrNoJQQemyIP66gRJkVAcR9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUc3ykd4vRi4lcxVd2/e5zyQQ2o7zOuVeFAj5hqHH2MdaZF1QkOwwiHW4suPXhytBvsDoyISl+5Se7YKQJTDD0lsfsaOb5srl3bjuLF6vgLQ9OxOn3OX7K5EWekmdNG1UJXJfofI7BXuFuSSTn/0HM0DpAX+X6FztX4jlxEyMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Imf6nAnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B743C116C6;
	Thu,  2 Apr 2026 08:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775118740;
	bh=nrb6HIjhgxKYnR0UDduqrNoJQQemyIP66gRJkVAcR9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Imf6nAnL/fwgDskwQL9xldVzL4FwAddpLCpc6zRaFkMjkyjRmN+YxLZtxybcog1TO
	 vTPHrg6QTjix0SyOAb09zxYSGU8BhUdQylp+AuFyryOaDHGkGZn1J9kA3UzqhDsTEJ
	 UWqofLPzF2+CHYMhCO9i27elO7MPsr+L0eUrapBPcfXS/9A6BnktPsTi300kStktW3
	 c4TNgaZHQ5m3T+GaaPgAP3eC+oWdlyKpAQ0BYitLfUPInSwQ3YlVzX7rPcyf04RZld
	 I0ibapvOYJWPUZ4nW6nkPIZQQc8kg9BKmmuYEN4rUHi3ZHs1vf4V8ZV+E4xQ+rx/wl
	 bJ5p7PxHlOU+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuto Ohnuki <ytohnuki@amazon.com>,
	syzbot+652af2b3c5569c4ab63c@syzkaller.appspotmail.com,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: stop reclaim before pushing AIL during unmount
Date: Thu,  2 Apr 2026 04:32:18 -0400
Message-ID: <20260402083218.458355-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033039-geranium-flame-8f03@gregkh>
References: <2026033039-geranium-flame-8f03@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-232938-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,652af2b3c5569c4ab63c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 44F103861E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yuto Ohnuki <ytohnuki@amazon.com>

[ Upstream commit 4f24a767e3d64a5f58c595b5c29b6063a201f1e3 ]

The unmount sequence in xfs_unmount_flush_inodes() pushed the AIL while
background reclaim and inodegc are still running. This is broken
independently of any use-after-free issues - background reclaim and
inodegc should not be running while the AIL is being pushed during
unmount, as inodegc can dirty and insert inodes into the AIL during the
flush, and background reclaim can race to abort and free dirty inodes.

Reorder xfs_unmount_flush_inodes() to stop inodegc and cancel background
reclaim before pushing the AIL. Stop inodegc before cancelling
m_reclaim_work because the inodegc worker can re-queue m_reclaim_work
via xfs_inodegc_set_reclaimable.

Reported-by: syzbot+652af2b3c5569c4ab63c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=652af2b3c5569c4ab63c
Fixes: 90c60e164012 ("xfs: xfs_iflush() is no longer necessary")
Cc: stable@vger.kernel.org # v5.9
Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ dropped xfs_inodegc_stop() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_mount.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 402cf828cc919..c408dded40dc2 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -652,8 +652,9 @@ xfs_check_summary_counts(
  * have been retrying in the background.  This will prevent never-ending
  * retries in AIL pushing from hanging the unmount.
  *
- * Finally, we can push the AIL to clean all the remaining dirty objects, then
- * reclaim the remaining inodes that are still in memory at this point in time.
+ * Stop inodegc and background reclaim before pushing the AIL so that they
+ * are not running while the AIL is being flushed. Then push the AIL to
+ * clean all the remaining dirty objects and reclaim the remaining inodes.
  */
 static void
 xfs_unmount_flush_inodes(
@@ -665,8 +666,8 @@ xfs_unmount_flush_inodes(
 
 	mp->m_flags |= XFS_MOUNT_UNMOUNTING;
 
-	xfs_ail_push_all_sync(mp->m_ail);
 	cancel_delayed_work_sync(&mp->m_reclaim_work);
+	xfs_ail_push_all_sync(mp->m_ail);
 	xfs_reclaim_inodes(mp);
 	xfs_health_unmount(mp);
 }
-- 
2.53.0


