Return-Path: <stable+bounces-60292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A2E933001
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795111C20EB1
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3181A08A1;
	Tue, 16 Jul 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9LvucgA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016C1A072C;
	Tue, 16 Jul 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154749; cv=none; b=C1oWF8TvUsuYtCWzTmFE0I31/8wk9VVDBYN27mBf8ctDKmWkyaiu++3ssCRytwRAW5J1qezbdS7/z3lc7O7CqCsWUoJgiEiNDpkswBqeBQ7GbsH05VkgWLGk1GIKIK+jUOnCmUJYv/O1ULQpwTzebx34u2nMr+UPvX+CkxtSLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154749; c=relaxed/simple;
	bh=lqc3OqZNH/tdSCuL9uHksJx7di2erjMhjEm9jioaF0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVL148Iqzaf3kZxnILsVSvqpeFoSo8BS/l1lQBWEer/dijZgYm81Uyhcg7B4ie1KwWqpxJ9bMlRrA/PUhCFws0kZTLdbLlq2krQ/KKNVt+p+3Gp0ucfk7ifDK2SMF1WK5ig/A2mrNiZZNj43Zb0/1EAQLtqI3AP6i/oFzbBID30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9LvucgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC329C4AF12;
	Tue, 16 Jul 2024 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154749;
	bh=lqc3OqZNH/tdSCuL9uHksJx7di2erjMhjEm9jioaF0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l9LvucgA3f2REfcBxYfgWaoRppjnCIieIYu/dT/XpUqkswb+XutBxuideZK5CIH0x
	 OZPHKTwiX1fsl+QUkO3x3hk2BDTWcKEAXVvhwJDovrGJcrRv6o0yy5jZ4uUsis9FsJ
	 aQFj3NHXqD3SrWvaE9bHWTpsXdcjEYbIgQX/fspPHxk4wUyXO0ZrKFUm3G5GW5r62u
	 oykLRQeaM+OSRAKe8N79G6MmTfhkLhlNVhRXqTiQ6sqsU5IvofJcCvvlQlUkMifX9F
	 Pb1H8c6opdurZgoEt8nzjW9MrF9dRVd3nZ1KLk4xp3+q/RACfRgkqWJ4NZg04QGj8l
	 k71Exz6hEbNJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Jia Zhu <zhujia.zj@bytedance.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dhowells@redhat.com,
	netfs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.9 03/11] cachefiles: stop sending new request when dropping object
Date: Tue, 16 Jul 2024 14:31:47 -0400
Message-ID: <20240716183222.2813968-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716183222.2813968-1-sashal@kernel.org>
References: <20240716183222.2813968-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit b2415d1f4566b6939acacc69637eaa57815829c1 ]

Added CACHEFILES_ONDEMAND_OBJSTATE_DROPPING indicates that the cachefiles
object is being dropped, and is set after the close request for the dropped
object completes, and no new requests are allowed to be sent after this
state.

This prepares for the later addition of cancel_work_sync(). It prevents
leftover reopen requests from being sent, to avoid processing unnecessary
requests and to avoid cancel_work_sync() blocking by waiting for daemon to
complete the reopen requests.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240628062930.2467993-6-libaokun@huaweicloud.com
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/internal.h |  2 ++
 fs/cachefiles/ondemand.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 6845a90cdfcce..a1a1d25e95147 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -48,6 +48,7 @@ enum cachefiles_object_state {
 	CACHEFILES_ONDEMAND_OBJSTATE_CLOSE, /* Anonymous fd closed by daemon or initial state */
 	CACHEFILES_ONDEMAND_OBJSTATE_OPEN, /* Anonymous fd associated with object is available */
 	CACHEFILES_ONDEMAND_OBJSTATE_REOPENING, /* Object that was closed and is being reopened. */
+	CACHEFILES_ONDEMAND_OBJSTATE_DROPPING, /* Object is being dropped. */
 };
 
 struct cachefiles_ondemand_info {
@@ -335,6 +336,7 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
 CACHEFILES_OBJECT_STATE_FUNCS(close, CLOSE);
 CACHEFILES_OBJECT_STATE_FUNCS(reopening, REOPENING);
+CACHEFILES_OBJECT_STATE_FUNCS(dropping, DROPPING);
 
 static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
 {
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 89f118d68d125..14f91a9fbe447 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -494,7 +494,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		 */
 		xas_lock(&xas);
 
-		if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
+		if (test_bit(CACHEFILES_DEAD, &cache->flags) ||
+		    cachefiles_ondemand_object_is_dropping(object)) {
 			xas_unlock(&xas);
 			ret = -EIO;
 			goto out;
@@ -535,7 +536,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 	 * If error occurs after creating the anonymous fd,
 	 * cachefiles_ondemand_fd_release() will set object to close.
 	 */
-	if (opcode == CACHEFILES_OP_OPEN)
+	if (opcode == CACHEFILES_OP_OPEN &&
+	    !cachefiles_ondemand_object_is_dropping(object))
 		cachefiles_ondemand_set_object_close(object);
 	kfree(req);
 	return ret;
@@ -634,8 +636,12 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 
 void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 {
+	if (!object->ondemand)
+		return;
+
 	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
 			cachefiles_ondemand_init_close_req, NULL);
+	cachefiles_ondemand_set_object_dropping(object);
 }
 
 int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
-- 
2.43.0


