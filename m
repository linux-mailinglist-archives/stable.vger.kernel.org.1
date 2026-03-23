Return-Path: <stable+bounces-229820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAn4MTR1wWl5TQQAu9opvQ
	(envelope-from <stable+bounces-229820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:15:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E11C02F9A4D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AA973131ACE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE37135958;
	Mon, 23 Mar 2026 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UfhjaYAI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823761DA0E1;
	Mon, 23 Mar 2026 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282953; cv=none; b=jwHCKPIQedUDidcZ5TlPAD1nxHkKNOpRMgEWvnetWlofnasaHrZ1ywhIKscckeXWhHpBBZiKMDfKjttiQrAKeh9dZgweJhU41WFxtmx2YEWyZM2hFNde7Kp9PPv3oL7T3LAllPy+VGb3yjb1CmMEFX68Q+q5cSibz+T25DMRoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282953; c=relaxed/simple;
	bh=CCMNrLekyZhq9vJReGEoDjLP49s1pDRWL2pywqkksGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEpkCIHRQ3FLvuMe5rBwn8BbyvVvnfLtvAAOD39ZIffs4YMfpbJ/ZqLbbeI4TtRGG25wQrIPxyPfpnjFBI1gizEdG7ghjEa3k6sXPrgB9y6LxMR1YKTyCGsojhH/L7qWufp8hvGXQePs1grsCWEElDW4rdbHiz3LXJ0VrAbhByk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UfhjaYAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48BCC4CEF7;
	Mon, 23 Mar 2026 16:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282953;
	bh=CCMNrLekyZhq9vJReGEoDjLP49s1pDRWL2pywqkksGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfhjaYAIJGSUZbSEoU+7jHYrnluYizX5yF5/A9aY6LaIhCf9hFwhe0KP82mbtEasR
	 cryX4EVzf6cdet4wtAgsVvLdX/LYM5LQ6+K1nlXXlbGtixO00NQx7DBkXmktstZP4Q
	 VnivoDsPAxSuFYLulD9c205/teRS7zKK8boCUWWA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Long Li <leo.lilong@huawei.com>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 347/481] xfs: ensure dquot item is deleted from AIL only after log shutdown
Date: Mon, 23 Mar 2026 14:45:29 +0100
Message-ID: <20260323134533.556376184@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229820-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E11C02F9A4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1297,9 +1297,15 @@ xfs_qm_dqflush(
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



