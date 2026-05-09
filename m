Return-Path: <stable+bounces-244870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOXOJB+K/mlasgAAu9opvQ
	(envelope-from <stable+bounces-244870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 03:13:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0904FD323
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 03:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9C893015C88
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 01:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1041A9B46;
	Sat,  9 May 2026 01:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s15gEKbW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD911A6823
	for <stable@vger.kernel.org>; Sat,  9 May 2026 01:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778289178; cv=none; b=OMvcK3JOVPM4Rx6QK1YFqsLJEZzBSJXa+5xG1g6lajS4nmIgIIrgq7QIionQ9GDoSPchxuNT1+dGFD67a4L4kNKigZ/M4FiYMXFteXWYvCFWgwYWGTr3JCfJYnb+ChdzSGTfMh/Zn5+BId8P3YlZ9OOivJlNKJbP94Fx12VE8AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778289178; c=relaxed/simple;
	bh=+EI/DdsvMyP+B26j8djy4XD8j8k57+JO+YAG3hSIAc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3voiaoO86PwPl1nlK2rZvQXwgnKahCoVBhEbh4AZ3HkOFdtj1RqUUgqWqpko2O0CB6BBj6pKxuhAQfVCRamb+MAqnG/QgstAPCzsCSIiZUZJJTRhaNhfNmOo2+N4M9LCY9z4iduwIqNy70w0/8xcX9hPCu/wOf0U2ilOQrN/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s15gEKbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53B9C2BCB0;
	Sat,  9 May 2026 01:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778289178;
	bh=+EI/DdsvMyP+B26j8djy4XD8j8k57+JO+YAG3hSIAc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s15gEKbW+YnRabn1naqkpilPhx3PGy+0v/9ZQw8RV1CHYfGdO6YW2WK5Strg7cE9z
	 ItKEM6LlWWd3d3EO0R9KL53zJU3t9Dnc+IihqTydrOJdBaNzCjLAoRTju4fKlRxO0E
	 LBNE3Nbd7tdbKDQ5c7KzWV6o4Ln+B/jqWrRmYnrjfEbn9c5EphXVIGD+ISAb1Dupya
	 ApPxCDeu1VU9IghlEzfwrGSDHUNytLbGKHAN1+C5VTbdcjw8SHBqJ+0QQRjXR54Wqn
	 bI5YW+2GHHItGqQwTeWm8FFFrCKSOKHJ+g3VaS0J+gaV+X1ITG+cyXQxDbJ5LwzD25
	 IFt9cJbFRI8jA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cengiz Can <cengiz.can@canonical.com>,
	Qualys Security Advisory <qsa@qualys.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] apparmor: use target task's context in apparmor_getprocattr()
Date: Fri,  8 May 2026 21:12:54 -0400
Message-ID: <20260509011255.2724005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050424-extended-ship-1e65@gregkh>
References: <2026050424-extended-ship-1e65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF0904FD323
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244870-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualys.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Cengiz Can <cengiz.can@canonical.com>

[ Upstream commit 4afc61702bdcc3b9b519749ef966cf762a6e7051 ]

apparmor_getprocattr() incorrectly calls task_ctx(current) instead of
task_ctx(task) when retrieving prev and exec attributes, returning the
caller's labels rather than the target's.

Fix by passing task to task_ctx().

The issue can be reproduced when a process with an onexec transition
(e.g., configured by a container runtime) is inspected via
/proc/<pid>/attr/apparmor/exec. The reader's own value is returned
instead of the target's.

Reported-by: Qualys Security Advisory <qsa@qualys.com>
Fixes: 3b529a7600d8 ("apparmor: move task domain change info to task security")
Cc: stable@vger.kernel.org
Co-developed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Cengiz Can <cengiz.can@canonical.com>
Co-developed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/lsm.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index cf26ffe8cccb7..6d71c1282af73 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -598,25 +598,23 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 				char **value)
 {
 	int error = -ENOENT;
-	/* released below */
-	const struct cred *cred = get_task_cred(task);
-	struct aa_task_ctx *ctx = task_ctx(current);
 	struct aa_label *label = NULL;
 
+	rcu_read_lock();
 	if (strcmp(name, "current") == 0)
-		label = aa_get_newest_label(cred_label(cred));
-	else if (strcmp(name, "prev") == 0  && ctx->previous)
-		label = aa_get_newest_label(ctx->previous);
-	else if (strcmp(name, "exec") == 0 && ctx->onexec)
-		label = aa_get_newest_label(ctx->onexec);
+		label = aa_get_newest_cred_label(__task_cred(task));
+	else if (strcmp(name, "prev") == 0  && task_ctx(task)->previous)
+		label = aa_get_newest_label(task_ctx(task)->previous);
+	else if (strcmp(name, "exec") == 0 && task_ctx(task)->onexec)
+		label = aa_get_newest_label(task_ctx(task)->onexec);
 	else
 		error = -EINVAL;
+	rcu_read_unlock();
 
 	if (label)
 		error = aa_getprocattr(label, value);
 
 	aa_put_label(label);
-	put_cred(cred);
 
 	return error;
 }
-- 
2.53.0


