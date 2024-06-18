Return-Path: <stable+bounces-53186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AC990D097
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF271F245B4
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F27B156985;
	Tue, 18 Jun 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sez9McXx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC00156972;
	Tue, 18 Jun 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715583; cv=none; b=Ea/m5g+sv+Lj+gRAF20kKyv3hj7mTJ8YOuLAM9cVfnG6SflKzlEloRI/0+ovclRsKKbIiRNfmtYqUwr437WQDt0Sskn9hdy2sLqqT429yUmC9K6Xuv+YhPgWvngLjvlMeo6APqvstIrbpi9Ke8B3tuZJSrlH6mysK67L7x5Sxmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715583; c=relaxed/simple;
	bh=/KgpvdMINzSvbfrfLroIxag+pf+I+/DwP50m0Vmy0vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfSVihjzDVlD+rgsTWTVELKZxX4mNaAFuYe5/+NBq7yq/iEGE3aR0QY+mgz/2+YZ6piDpJAFAnnXRQJV7Iwd5sr+oAj2tt8KqajRSu5ejs6ZOOnfd8TaikpBCrtX2HgXa2AzOzOJeydW0XJnF6a07F8aphM+PCgtpTqGQ9zO67k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sez9McXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA02AC3277B;
	Tue, 18 Jun 2024 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715583;
	bh=/KgpvdMINzSvbfrfLroIxag+pf+I+/DwP50m0Vmy0vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sez9McXxInl39ejF2F7KxyA6aNwKu/57gVE0Hb+ETJM1Dh9ywm9me7QT3IDkCLisB
	 H0CX+RItu0oLdY2rMXRHo+bm7eqOW7UQXioyDDN1+N7wX4cp4o5QyKm9WKR9km1PFM
	 oXus9rXI3IfMMJa+g6nX8IXJYjafU+ulcb5Pxgf0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Murphy Zhou <jencce.kernel@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 358/770] fsnotify: fix sb_connectors leak
Date: Tue, 18 Jun 2024 14:33:31 +0200
Message-ID: <20240618123421.085388950@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 4396a73115fc8739083536162e2228c0c0c3ed1a ]

Fix a leak in s_fsnotify_connectors counter in case of a race between
concurrent add of new fsnotify mark to an object.

The task that lost the race fails to drop the counter before freeing
the unused connector.

Following umount() hangs in fsnotify_sb_delete()/wait_var_event(),
because s_fsnotify_connectors never drops to zero.

Fixes: ec44610fe2b8 ("fsnotify: count all objects with attached connectors")
Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
Link: https://lore.kernel.org/linux-fsdevel/20210907063338.ycaw6wvhzrfsfdlp@xzhoux.usersys.redhat.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/mark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 796946eb0c2e2..bea106fac0901 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -531,6 +531,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		/* Someone else created list structure for us */
 		if (inode)
 			fsnotify_put_inode_ref(inode);
+		fsnotify_put_sb_connectors(conn);
 		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
 	}
 
-- 
2.43.0




