Return-Path: <stable+bounces-218519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDIuLI9SnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:38:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F1818F3EF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A410C308F60E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0670C24677D;
	Wed, 25 Feb 2026 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eq/jUvxJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1418B0A;
	Wed, 25 Feb 2026 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983354; cv=none; b=pK9PTAWRhKIqiSFy2Q0pCiaAq0cqvvgW/9azJnR5axqTwbIumJC51Rr85YGmCvweurx/vHcI660fY2PakB49xNTF5/0JNkf9DpJ8gMQPq1rq44ls5N/8AYA8Xzp4S8F92eK1qwKncEl3lkQGXE8kwbjRYc5QZEVXANQHKl+7dAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983354; c=relaxed/simple;
	bh=5cTxWdpHnI/7/w5u/oMEE2lxXYhTVlijzY2QXLZf2d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLpP4DsnVlru4HKr/Go4lzTJKV+aRjC5PmQlKB1XpSICyvb3XI4Fn+k41twl9bE8N6HpBHKwFj1eAzTpg/2trN5kvKCtWVSqwfjY7qGwAHsbPnns0ZsV3awcPQ1ctbZSnp/cz8T255Ha8Dm4EUrSowStJM7vduhWKAPEd0W3U0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eq/jUvxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA54C116D0;
	Wed, 25 Feb 2026 01:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983354;
	bh=5cTxWdpHnI/7/w5u/oMEE2lxXYhTVlijzY2QXLZf2d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eq/jUvxJOV4l8ZR+nGa50YOZkQdAlMeghe/fRjkShLaElmJygmSwrRF4CG8rOdtXV
	 U1X2Mgkqy8dDnLw8vSdM64tMNpgs2YzksDSsWyvZ2sCDb741GQAx8zEIwBehSHHZTJ
	 A4w0EgdjHfkmTtR1qc6NRWNo3JeGZOCWPMG3lrmI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mike Snitzer <snitzer@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 479/781] NFS/localio: use GFP_NOIO and non-memreclaim workqueue in nfs_local_commit
Date: Tue, 24 Feb 2026 17:19:48 -0800
Message-ID: <20260225012411.564170843@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218519-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52F1818F3EF
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@hammerspace.com>

[ Upstream commit 9bb0060f7860aa4561c5b21163dd45ceb66946a9 ]

nfslocaliod_workqueue is a non-memreclaim workqueue (it isn't
initialized with WQ_MEM_RECLAIM), see commit b9f5dd57f4a5
("nfs/localio: use dedicated workqueues for filesystem read and
write").

Use nfslocaliod_workqueue for LOCALIO's SYNC work.

Also, set PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO in
nfs_local_fsync_work.

Fixes: b9f5dd57f4a5 ("nfs/localio: use dedicated workqueues for filesystem read and write")
Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/localio.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 84f53f27a9089..f553ac0e1d86e 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -1060,17 +1060,22 @@ nfs_local_fsync_ctx_free(struct nfs_local_fsync_ctx *ctx)
 static void
 nfs_local_fsync_work(struct work_struct *work)
 {
+	unsigned long old_flags = current->flags;
 	struct nfs_local_fsync_ctx *ctx;
 	int status;
 
 	ctx = container_of(work, struct nfs_local_fsync_ctx, work);
 
+	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
+
 	status = nfs_local_run_commit(nfs_to->nfsd_file_file(ctx->localio),
 				      ctx->data);
 	nfs_local_commit_done(ctx->data, status);
 	if (ctx->done != NULL)
 		complete(ctx->done);
 	nfs_local_fsync_ctx_free(ctx);
+
+	current->flags = old_flags;
 }
 
 static struct nfs_local_fsync_ctx *
@@ -1094,7 +1099,7 @@ int nfs_local_commit(struct nfsd_file *localio,
 {
 	struct nfs_local_fsync_ctx *ctx;
 
-	ctx = nfs_local_fsync_ctx_alloc(data, localio, GFP_KERNEL);
+	ctx = nfs_local_fsync_ctx_alloc(data, localio, GFP_NOIO);
 	if (!ctx) {
 		nfs_local_commit_done(data, -ENOMEM);
 		nfs_local_release_commit_data(localio, data, call_ops);
@@ -1106,10 +1111,10 @@ int nfs_local_commit(struct nfsd_file *localio,
 	if (how & FLUSH_SYNC) {
 		DECLARE_COMPLETION_ONSTACK(done);
 		ctx->done = &done;
-		queue_work(nfsiod_workqueue, &ctx->work);
+		queue_work(nfslocaliod_workqueue, &ctx->work);
 		wait_for_completion(&done);
 	} else
-		queue_work(nfsiod_workqueue, &ctx->work);
+		queue_work(nfslocaliod_workqueue, &ctx->work);
 
 	return 0;
 }
-- 
2.51.0




