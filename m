Return-Path: <stable+bounces-237294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PotKIcf3WmsaAkAu9opvQ
	(envelope-from <stable+bounces-237294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:53:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 473E03F01EB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF314302BC30
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F57317173;
	Mon, 13 Apr 2026 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pFZqSwOL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22375317148;
	Mon, 13 Apr 2026 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099086; cv=none; b=oRjtpZuiFjRNMxGFn4uUgasfel4TfY3r+zq3NAFlWLeoCOdIizU5BaS8ft1uMRjEi9/Yai3X/TilLf/9P2F09iRbifvRYX/Mf2iwC+p/nde3kf3RpGTffNW/l2IGpXA090ourYQCrz4PXPUXP1W86H7MgVHVbjakSyEXb6SdLzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099086; c=relaxed/simple;
	bh=kyT1hcDMBSpfOKP9p0H09gVAAeEmTCjZgL8cBkq1IiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Su8UXnWju92WuXDgnIhC/H1itE3cLgc2u7oQ26vme9b84XGAgsZDEAi4byiiMblUq4zMsPESBuL6nfMWhEc/uytGf4bwjmEkpArDode1YvXWWyw6hOcFnnrLoo/J4nuhY1tKIpvuGDXqsPV0tsHNX65WOnnhFq9L9rncMzv+hK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pFZqSwOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4B9C2BCAF;
	Mon, 13 Apr 2026 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099086;
	bh=kyT1hcDMBSpfOKP9p0H09gVAAeEmTCjZgL8cBkq1IiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pFZqSwOLOqc928AelCTa2/Vcv8FRxyiM0nuzwDAibroy0HeqKdb3vniGO4h85WJHb
	 JHHO5Yca0Rl0A8lLlUpaeTwE53uZavXIW1cRTUnG+V8SmXdlVgDkMa9YMs105ditnb
	 Rd6y5BwNZfUrhUvcBQcIyIN/8oTiMm/UwKjoLBd0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Long Li <leo.lilong@huawei.com>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 177/491] xfs: ensure dquot item is deleted from AIL only after log shutdown
Date: Mon, 13 Apr 2026 17:57:02 +0200
Message-ID: <20260413155825.679155892@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-237294-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,lst.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 473E03F01EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_dquot.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

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



