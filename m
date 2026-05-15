Return-Path: <stable+bounces-247810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDOvHGg4B2ottwIAu9opvQ
	(envelope-from <stable+bounces-247810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:14:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E17B1551FA9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 691493087286
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CE848AE1D;
	Fri, 15 May 2026 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQAFG9RE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58349292B54
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857624; cv=none; b=TaM/GWm1ozH67TJIfmCxtBJOP75wY+apXQHGL0/nzEqlflSbjG9jXjVdlOdf0l9XST3HDfMxpuug6LDTVJygdKrkp+pQXbNx64anVTaX0TwycxggWGoJyDvoCBGpGHV1ON1QOLmQU3yqt/59MQu7+47lthep9NM26dRN88zfWIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857624; c=relaxed/simple;
	bh=zBUTHBSxgSjwLBFaIsWU1w+Dk3nypy4vVcS4qWx/muk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhGhlq14Ug7B3ntzV5psOgDXVLKpXi2HUpDELB2lxZCwpPe8HXsbWe+Qh4j3QUoxZdWiB7bAJ7LItXSZ9PK29s3u9/T6gPdJ7CA1nAKIOT74UqYspaJRE6ebjVK893CD1YowKv8b78YpN81przjjWuQSiBGMC727iu7Opm1Hg0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQAFG9RE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7A1C2BCB0;
	Fri, 15 May 2026 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778857624;
	bh=zBUTHBSxgSjwLBFaIsWU1w+Dk3nypy4vVcS4qWx/muk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQAFG9REG4vjtavkFJBPgNOdIr7M5geaQyHnvXsfNqvTv+4tVn52AXBY6YJtvZwLM
	 rFLwh1vH9OXQA1rOzWK9kLH/B8LdO2PpLdzcJr9R1NoR+rZd43HSr/GC3PtQhEO39D
	 9jlWirMZg0AlzSNKo3nPogAC9n16SjyMJtIzuF/TrMYsn7y6nRtFZTbjUdmJ42ksdi
	 Dx6uQnfDxMsvs1bA//htNVwIA2mklXguuFfxH5E7i1y34iSHe+iBmrPIlxpgHay+0w
	 PEFr1ir8agXqwlElBMEPdsEMKcz8Khy1qblK5pAjt8ixx9C1cgyrHKzUHwg5HKIo30
	 I7S8gJaxk7qIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/2] eventfs: Simplify code using guard()s
Date: Fri, 15 May 2026 11:06:59 -0400
Message-ID: <20260515150700.3261577-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051232-clapped-algebra-8969@gregkh>
References: <2026051232-clapped-algebra-8969@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E17B1551FA9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247810-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email,efficios.com:email]
X-Rspamd-Action: no action

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 4d9b262031ffef203243e53577a90ae6e1090e67 ]

Use guard(mutex), scoped_guard(mutex) and guard(src) to simplify the code
and remove a lot of the jumps to "out:" labels.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250604151625.250d13e1@gandalf.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: f67950b2887f ("eventfs: Use list_add_tail_rcu() for SRCU-protected children list")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/tracefs/event_inode.c | 96 +++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 60 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index af3387eebef5b..592dac31f5624 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -180,29 +180,25 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	const char *name;
 	int ret;
 
-	mutex_lock(&eventfs_mutex);
+	guard(mutex)(&eventfs_mutex);
 	ei = dentry->d_fsdata;
-	if (ei->is_freed) {
-		/* Do not allow changes if the event is about to be removed. */
-		mutex_unlock(&eventfs_mutex);
+	/* Do not allow changes if the event is about to be removed. */
+	if (ei->is_freed)
 		return -ENODEV;
-	}
 
 	/* Preallocate the children mode array if necessary */
 	if (!(dentry->d_inode->i_mode & S_IFDIR)) {
 		if (!ei->entry_attrs) {
 			ei->entry_attrs = kzalloc_objs(*ei->entry_attrs,
 						       ei->nr_entries, GFP_NOFS);
-			if (!ei->entry_attrs) {
-				ret = -ENOMEM;
-				goto out;
-			}
+			if (!ei->entry_attrs)
+				return -ENOMEM;
 		}
 	}
 
 	ret = simple_setattr(idmap, dentry, iattr);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/*
 	 * If this is a dir, then update the ei cache, only the file
@@ -225,8 +221,6 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 			}
 		}
 	}
- out:
-	mutex_unlock(&eventfs_mutex);
 	return ret;
 }
 
@@ -530,26 +524,24 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
 	const char *name = dentry->d_name.name;
-	struct dentry *result = NULL;
 
 	ti = get_tracefs(dir);
 	if (WARN_ON_ONCE(!(ti->flags & TRACEFS_EVENT_INODE)))
 		return ERR_PTR(-EIO);
 
-	mutex_lock(&eventfs_mutex);
+	guard(mutex)(&eventfs_mutex);
 
 	ei = ti->private;
 	if (!ei || ei->is_freed)
-		goto out;
+		return NULL;
 
 	list_for_each_entry(ei_child, &ei->children, list) {
 		if (strcmp(ei_child->name, name) != 0)
 			continue;
 		/* A child is freed and removed from the list at the same time */
 		if (WARN_ON_ONCE(ei_child->is_freed))
-			goto out;
-		result = lookup_dir_entry(dentry, ei, ei_child);
-		goto out;
+			return NULL;
+		return lookup_dir_entry(dentry, ei, ei_child);
 	}
 
 	for (int i = 0; i < ei->nr_entries; i++) {
@@ -563,14 +555,12 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 
 		data = ei->data;
 		if (entry->callback(name, &mode, &data, &fops) <= 0)
-			goto out;
+			return NULL;
+
+		return lookup_file_dentry(dentry, ei, i, mode, data, fops);
 
-		result = lookup_file_dentry(dentry, ei, i, mode, data, fops);
-		goto out;
 	}
- out:
-	mutex_unlock(&eventfs_mutex);
-	return result;
+	return NULL;
 }
 
 /*
@@ -586,7 +576,6 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	struct eventfs_inode *ei;
 	const char *name;
 	umode_t mode;
-	int idx;
 	int ret = -EINVAL;
 	int ino;
 	int i, r, c;
@@ -600,16 +589,13 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 	c = ctx->pos - 2;
 
-	idx = srcu_read_lock(&eventfs_srcu);
-
-	mutex_lock(&eventfs_mutex);
-	ei = READ_ONCE(ti->private);
-	if (ei && ei->is_freed)
-		ei = NULL;
-	mutex_unlock(&eventfs_mutex);
+	guard(srcu)(&eventfs_srcu);
 
-	if (!ei)
-		goto out;
+	scoped_guard(mutex, &eventfs_mutex) {
+		ei = READ_ONCE(ti->private);
+		if (!ei || ei->is_freed)
+			return -EINVAL;
+	}
 
 	/*
 	 * Need to create the dentries and inodes to have a consistent
@@ -624,21 +610,19 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		entry = &ei->entries[i];
 		name = entry->name;
 
-		mutex_lock(&eventfs_mutex);
 		/* If ei->is_freed then just bail here, nothing more to do */
-		if (ei->is_freed) {
-			mutex_unlock(&eventfs_mutex);
-			goto out;
+		scoped_guard(mutex, &eventfs_mutex) {
+			if (ei->is_freed)
+				return -EINVAL;
+			r = entry->callback(name, &mode, &cdata, &fops);
 		}
-		r = entry->callback(name, &mode, &cdata, &fops);
-		mutex_unlock(&eventfs_mutex);
 		if (r <= 0)
 			continue;
 
 		ino = EVENTFS_FILE_INODE_INO;
 
 		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
-			goto out;
+			return -EINVAL;
 	}
 
 	/* Subtract the skipped entries above */
@@ -661,19 +645,13 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 		ino = eventfs_dir_ino(ei_child);
 
-		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
-			goto out_dec;
+		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR)) {
+			/* Incremented ctx->pos without adding something, reset it */
+			ctx->pos--;
+			return -EINVAL;
+		}
 	}
-	ret = 1;
- out:
-	srcu_read_unlock(&eventfs_srcu, idx);
-
-	return ret;
-
- out_dec:
-	/* Incremented ctx->pos without adding something, reset it */
-	ctx->pos--;
-	goto out;
+	return 1;
 }
 
 /**
@@ -730,11 +708,10 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	INIT_LIST_HEAD(&ei->children);
 	INIT_LIST_HEAD(&ei->list);
 
-	mutex_lock(&eventfs_mutex);
-	if (!parent->is_freed)
-		list_add_tail(&ei->list, &parent->children);
-	mutex_unlock(&eventfs_mutex);
-
+	scoped_guard(mutex, &eventfs_mutex) {
+		if (!parent->is_freed)
+			list_add_tail(&ei->list, &parent->children);
+	}
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
 		cleanup_ei(ei);
@@ -880,9 +857,8 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
 	if (!ei)
 		return;
 
-	mutex_lock(&eventfs_mutex);
+	guard(mutex)(&eventfs_mutex);
 	eventfs_remove_rec(ei, 0);
-	mutex_unlock(&eventfs_mutex);
 }
 
 /**
-- 
2.53.0


