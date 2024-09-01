Return-Path: <stable+bounces-72506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6D9967AE8
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 19:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C286281F4B
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD37317E918;
	Sun,  1 Sep 2024 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q89tSil7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDAC225D9;
	Sun,  1 Sep 2024 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725210146; cv=none; b=Dy20PFnwIXNLL0XCY65zgiHrM0bhtduD/goZnElLzG7guCt8lAohUVht3sTXFU+Ls0BKKIJPBPH+RWHPsOZ6IGZDqRhuaZKfdMG9nVzFsMwX3ZSMcrgHU/PLyQ6QtrQ/RmQI1ImaJ9IG5BOa7knlPov9TnQV6pl35MvEmkj60Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725210146; c=relaxed/simple;
	bh=7O7GxWGC08EBpdBwiQcelT/wQlgsg62GuRVvPLcdotg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmQ10ZGYRRdrmmNZFvbiZImIr6cD/iEkaJlzzIZMN2QnZC0R694Gp1ESjG2fcnIzC/5jvlfbV0IZsNazaUkS5DoiG8rqTxrxLsuxgtCbxQe+AbyVscUN+EsxpMXs5dT3NVLqZOqOUG7fYnZzxPG8nQwE03LoqHlciKF4puCc/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q89tSil7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CE6C4CEC3;
	Sun,  1 Sep 2024 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725210146;
	bh=7O7GxWGC08EBpdBwiQcelT/wQlgsg62GuRVvPLcdotg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q89tSil7hlrqDUHDiDi824uI+LyKTqCKwaCFrmP3cCQxgBiA/Hpo2KqxSXdokF+Nz
	 cSDSa7dcPi7ji19AECSLk7w1YtUmFZqnQdgxlLxnpB25Dp7ut+Zym9l50x7to/rb11
	 sXNGcAjf+BmlZQVH8tOhZmC0VwGtXKngVVuOaTjg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 071/215] quota: Remove BUG_ON from dqget()
Date: Sun,  1 Sep 2024 18:16:23 +0200
Message-ID: <20240901160826.036514917@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160823.230213148@linuxfoundation.org>
References: <20240901160823.230213148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

[ Upstream commit 249f374eb9b6b969c64212dd860cc1439674c4a8 ]

dqget() checks whether dquot->dq_sb is set when returning it using
BUG_ON. Firstly this doesn't work as an invalidation check for quite
some time (we release dquot with dq_sb set these days), secondly using
BUG_ON is quite harsh. Use WARN_ON_ONCE and check whether dquot is still
hashed instead.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index edb414d3fd164..3b62fbcefa8c3 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -995,9 +995,8 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 	 * smp_mb__before_atomic() in dquot_acquire().
 	 */
 	smp_rmb();
-#ifdef CONFIG_QUOTA_DEBUG
-	BUG_ON(!dquot->dq_sb);	/* Has somebody invalidated entry under us? */
-#endif
+	/* Has somebody invalidated entry under us? */
+	WARN_ON_ONCE(hlist_unhashed(&dquot->dq_hash));
 out:
 	if (empty)
 		do_destroy_dquot(empty);
-- 
2.43.0




