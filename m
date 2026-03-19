Return-Path: <stable+bounces-227271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEpJMkDhu2lXpQIAu9opvQ
	(envelope-from <stable+bounces-227271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:42:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3594F2CA7F1
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD6593077CEC
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D6E3AD50B;
	Thu, 19 Mar 2026 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1wwRASP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B6137F8B5
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920404; cv=none; b=AZGpXRJwzdc2EPZunmJylO1MLPURxVJ0vjIKAR+bftWYMYfzYrTVsZvkH4SGU/1h9LQLOMcKt1Tb60EloXS9gnZyp+lCccUfEJo6ZEh8w5/2S5xDO20wEjKBqYH0KgZ+pD/MH9FE5wfk6ZfJjPyBhxuYtTKLnfbyyOuOS5qvxro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920404; c=relaxed/simple;
	bh=d85fIjxsjly83OOddN9GiaxXgpn/1+PDSey6/Aa3swg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTZzBiPWLjJZ6FrqYSq+GETIjWtSGivFgLxbdkhAgwDbGoYbUqMjhdoYa78VjHQ3MzVWWHz5GIL4QypTj7mQ0wb2EcP9/5cWw7KHxhYkHXaUOSEku7WU9vKI4N6cOm5ADt00Ag/5Kx69ZiERq1qPSD580uZpYks0iSqGFrbjZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1wwRASP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA3EC2BCB1;
	Thu, 19 Mar 2026 11:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773920404;
	bh=d85fIjxsjly83OOddN9GiaxXgpn/1+PDSey6/Aa3swg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1wwRASPGjZ5EmniLghjKC3BudGN8i0/kYxbnjEOWjvwfMQn/gWewBpqxR29unUt3
	 TFS7o2cW8qG33p8Xcwe5izKbBKqKPIAKNu6NLJlZIuLpdCScrnoPBNDabIYeRcC2qM
	 bUzY6jsVYSS2BYXBTr+hZRJNyCVeylt//ELomWKT/oHAifT5kK/mhQ9yoaFtqi0bbN
	 QKqWScpcUyHu9AGlpkLvGwIQqR0jSuTnVAOo0J96PrgDD9E77liWpG14s6nn84Ps5r
	 usSG+7kzSrV4D+RxgnmQi7O+wEh9ZfYEn90zJtke5RqUv0Lp81TWMc7WMIdD+9Sb7Z
	 zen9ZA2IGOTRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Long Li <leo.lilong@huawei.com>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: ensure dquot item is deleted from AIL only after log shutdown
Date: Thu, 19 Mar 2026 07:40:01 -0400
Message-ID: <20260319114001.2348820-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031751-drastic-afraid-2b79@gregkh>
References: <2026031751-drastic-afraid-2b79@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227271-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email,huawei.com:email]
X-Rspamd-Queue-Id: 3594F2CA7F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit 186ac39b8a7d3ec7ce9c5dd45e5c2730177f375c ]

In xfs_qm_dqflush(), when a dquot flush fails due to corruption
(the out_abort error path), the original code removed the dquot log
item from the AIL before calling xfs_force_shutdown(). This ordering
introduces a subtle race condition that can lead to data loss after
a crash.

The AIL tracks the oldest dirty metadata in the journal. The position
of the tail item in the AIL determines the log tail LSN, which is the
oldest LSN that must be preserved for crash recovery. When an item is
removed from the AIL, the log tail can advance past the LSN of that item.

The race window is as follows: if the dquot item happens to be at
the tail of the log, removing it from the AIL allows the log tail
to advance. If a concurrent log write is sampling the tail LSN at
the same time and subsequently writes a complete checkpoint (i.e.,
one containing a commit record) to disk before the shutdown takes
effect, the journal will no longer protect the dquot's last
modification. On the next mount, log recovery will not replay the
dquot changes, even though they were never written back to disk,
resulting in silent data loss.

Fix this by calling xfs_force_shutdown() before xfs_trans_ail_delete()
in the out_abort path. Once the log is shut down, no new log writes
can complete with an updated tail LSN, making it safe to remove the
dquot item from the AIL.

Cc: stable@vger.kernel.org
Fixes: b707fffda6a3 ("xfs: abort consistently on dquot flush failure")
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ adapted error path to preserve existing out_unlock label between xfs_trans_ail_delete and xfs_dqfunlock ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_dquot.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 80c4579d68357..3a2bfc075e908 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1324,9 +1324,15 @@ xfs_qm_dqflush(
 	return 0;
 
 out_abort:
+	/*
+	 * Shut down the log before removing the dquot item from the AIL.
+	 * Otherwise, the log tail may advance past this item's LSN while
+	 * log writes are still in progress, making these unflushed changes
+	 * unrecoverable on the next mount.
+	 */
+	xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
 	dqp->q_flags &= ~XFS_DQFLAG_DIRTY;
 	xfs_trans_ail_delete(lip, 0);
-	xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
 out_unlock:
 	xfs_dqfunlock(dqp);
 	return error;
-- 
2.51.0


