Return-Path: <stable+bounces-226805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHmiOAKPuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:27:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF122AF96B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC9113054793
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B0F3176FD;
	Tue, 17 Mar 2026 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lQS15eu4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459AF33EC;
	Tue, 17 Mar 2026 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768259; cv=none; b=edFt3i1m17j/iUoHq7xKLxRvG/WS8xCxFbbGEt+urswAhEWWySw4llftCITDAJRttVNsGzoP0IzarszQdTXwcFI3wkbqZE+6MRhPaOjD5toPndlXvaNLsJfXSv9Nsq9HKnMK4jaq0hBDi41C0Z3/uC6vq9fnVrfZEeL8rLc/fpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768259; c=relaxed/simple;
	bh=rA+M/uMETcdS222GHx0fJ0icuQ6hQIKqvPVWuRwyoT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVmiMgKazsioLxdM97xDerpYhXegvZT1wbeEeQjewd9LROvNWghrqo+XfRbGufq9kKhpU3Dbe6TaxOD0Eg3vSHs7ANdE6V7unaCEgq3oAYnPaHR5tXKpEK28VcUhKzFo2cysY+9JxULdCx0c8UsN9abkL3Xq/mL+yTFrHQPzRFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lQS15eu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C80AC4CEF7;
	Tue, 17 Mar 2026 17:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768259;
	bh=rA+M/uMETcdS222GHx0fJ0icuQ6hQIKqvPVWuRwyoT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lQS15eu4uGTner6vpW8pE8dHaNFonYuGvgsHTAL67ndEjzMPyCYksH8id6OJq6ZmN
	 jPoHsumuynntMcYwcpl/hSQ8xZwryosVH/9Zu2QTtMu4tVrZ/2MtvbAOaDi6+I9hbW
	 Hk9iYtOuvLQt4xJ6rw+VK0bibNpmVhJHLFBctEBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Long Li <leo.lilong@huawei.com>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.18 270/333] xfs: ensure dquot item is deleted from AIL only after log shutdown
Date: Tue, 17 Mar 2026 17:34:59 +0100
Message-ID: <20260317163009.382702027@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226805-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFF122AF96B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <leo.lilong@huawei.com>

commit 186ac39b8a7d3ec7ce9c5dd45e5c2730177f375c upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_dquot.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1464,9 +1464,15 @@ xfs_qm_dqflush(
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
 	xfs_dqfunlock(dqp);
 	return error;
 }



