Return-Path: <stable+bounces-72089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D238F967922
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1281C20B6F
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C017E900;
	Sun,  1 Sep 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ptEmb3Yj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B161817E46E;
	Sun,  1 Sep 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208804; cv=none; b=rqut8bZj9oPchlH62S4wnhaxhS0l/wpbdZGRDOsnQFv0gXHvclDAafIoTJz6Nfi7VSnqua8eT9L8RUd+t8Kp/CKWQfZvPujPn7q1PAEYDKPCmjUhnOgJdAtI3A8Af1b+Hl9RDLcOHl60wmh9aecYWZK+hllLMjy+tUQ6cuFBqZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208804; c=relaxed/simple;
	bh=M9I8iJC7iBtagehsi9VzPcgEjVpyXXRHx8aLbXpMoso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkU6X4ivT0d4HevBNG4kiAw9cxuu6UhbDCxJxJ2WNsQS8EGzKq4QtO6EmVru5BGTVBPYc/FXDHgmrIKfQ9Fil97ncGETkImUehJDKnxvoP72f/HAMJdvR+B60VeVo1pkIDBPlVrXCeISG+Sf0Mq1kkJKMjevmefPajvQi7m81IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ptEmb3Yj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAC8C4CEC3;
	Sun,  1 Sep 2024 16:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208804;
	bh=M9I8iJC7iBtagehsi9VzPcgEjVpyXXRHx8aLbXpMoso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ptEmb3YjZbdpFoa2Xo2DaxNksTTPaJXxwIMcY/cZnws8ncJtFNwrXZgyq+jQA/MC/
	 w5P7PskoI0EfjOUHo8U0YrdXQtRnsvRV10dc3ZXwnic5oJ+EgfM0VQRTkzJLjA6qpK
	 jzjtuk7SMwM+xoux/000T9odcXQmfOAN8fqgWgE8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 044/134] quota: Remove BUG_ON from dqget()
Date: Sun,  1 Sep 2024 18:16:30 +0200
Message-ID: <20240901160811.767121087@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160809.752718937@linuxfoundation.org>
References: <20240901160809.752718937@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index a7ddb874912d4..14c0dd5b65a43 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -986,9 +986,8 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
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




