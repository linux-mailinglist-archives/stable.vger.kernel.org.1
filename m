Return-Path: <stable+bounces-247811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP7DOVk4B2ottwIAu9opvQ
	(envelope-from <stable+bounces-247811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:14:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 539FD551F9F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA68C30A9E69
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817FA48AE37;
	Fri, 15 May 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sde48J9M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F8292B54
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857625; cv=none; b=jtW79p/HCbbDteZp5CP1GFNOUHkA3mmzi7D3/0E2J5dH7Vd+N3hUHOIn42aW6vseWQPvJL4j/JFWh7/iXaGSvEz+hOIUVz2uOqSgTknk8Ma6ClZshi4rpXPYRh+yRrPSf0iz76NsYa/XSSNcuTngI5DTA/T+Q7ydMLtcGgibifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857625; c=relaxed/simple;
	bh=AoAe+4HrvRpchsQfpcsTdgwbHQ1JSOkgzHjkR6ErJFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEw5lGYf0RJwxH6BPInz1COVwGLM+yjgwixRBJuiNSygCQnR6b4uTC/e3XG1p93tuyP0/hOOORfrPY6uRyFN8n6PnpLu+B4TUiMVUkKg5RuJYv1WGn1JdHMtYBAJLJ9WUuIJiF1groJVx5tiFGfroUyGqfMcBWyuzYY6xAO8FA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sde48J9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F3BC2BCF5;
	Fri, 15 May 2026 15:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778857625;
	bh=AoAe+4HrvRpchsQfpcsTdgwbHQ1JSOkgzHjkR6ErJFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sde48J9Mc8OZvtpx52RdK2oZH5zgpbnQHQkPFtFgbSa16xHURsJJOSwoM70aWxxgp
	 h4+H+r+bbhGBv7wIfISTrda+qiU2EqNBLx1aXeTybYtVi1RBnK0MGqHHBfs/qtKY7v
	 Og17bYrin1H0CBkMri3lnl6ectVwz1BQZDpD9zHYzFEZd6q6LpNFyhfsp5SlajktE6
	 gnw8L1ojloXunxF7zVTE5zY/OsRKagUFPO49vwwNfgrIdXpyuw90q/nU7qzvZXKdiu
	 sWhna5Yuh9eyafj7b9lencfIhJI8ooXZvtBoNWEzDG0FJHJgC9Qgwgdk2M3elNep8g
	 mu9LrVVdJhaPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/2] eventfs: Use list_add_tail_rcu() for SRCU-protected children list
Date: Fri, 15 May 2026 11:07:00 -0400
Message-ID: <20260515150700.3261577-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515150700.3261577-1-sashal@kernel.org>
References: <2026051232-clapped-algebra-8969@gregkh>
 <20260515150700.3261577-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 539FD551F9F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,goodmis.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247811-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email]
X-Rspamd-Action: no action

From: David Carlier <devnexen@gmail.com>

[ Upstream commit f67950b2887fa10df50c4317a1fe98a65bc6875b ]

Commit d2603279c7d6 ("eventfs: Use list_del_rcu() for SRCU protected
list variable") converted the removal side to pair with the
list_for_each_entry_srcu() walker in eventfs_iterate(). The insertion
in eventfs_create_dir() was left as a plain list_add_tail(), which on
weakly-ordered architectures can expose a new entry to the SRCU reader
before its list pointers and fields are observable.

Use list_add_tail_rcu() so the publication pairs with the existing
list_del_rcu() and list_for_each_entry_srcu().

Fixes: 43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260418152251.199343-1-devnexen@gmail.com
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 592dac31f5624..4c265192fd9dc 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -710,7 +710,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 
 	scoped_guard(mutex, &eventfs_mutex) {
 		if (!parent->is_freed)
-			list_add_tail(&ei->list, &parent->children);
+			list_add_tail_rcu(&ei->list, &parent->children);
 	}
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
-- 
2.53.0


