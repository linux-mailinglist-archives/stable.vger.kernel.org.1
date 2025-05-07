Return-Path: <stable+bounces-142121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8943AAE915
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03D31BC8C39
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF5328E572;
	Wed,  7 May 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O+ssYJgn"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944B28DF5B
	for <stable@vger.kernel.org>; Wed,  7 May 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642664; cv=none; b=doGZMWj/1QehZ4gXw9b91rVPqMRDX2sHzhWqk3CGb9sY2dQMUmROxph2mGCSpdibJUFkeBiJ8Xe+ob3mhSOaU6kSSZt9w5C6sW7a6HY+xY+2OS0eojqno8HQ49fGFXQbeOhXAIDI2KgQ3pM1oRJeIgSEEYLFRGC/W+XevspD+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642664; c=relaxed/simple;
	bh=mj9E4NXpqXs+PyNBP0D8DvBQ6VnMJLycjotW1P+lB4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CebJehgai1gZcJz6cSOdUJWpp9YMXBVcTGiljPGhmIE7ndRuRnpK607g4Ybz4B+MUNQLJ41aBEt+j0fJ5euyDJQjXyQN8EhRYiHWnzdQPF7tXQ8Antlfu1cE5WT+5xa6TLlKzNTzSAV4tsBWuQU91WwgSUDjjjZuaT8yIDWUEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O+ssYJgn; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746642658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fb3ibDE+g8+K3Y7TLpoOoO3m+BJNPGJFV7tVY45mdeY=;
	b=O+ssYJgnMX7PbUnAAxDu5aE58U7QJOYHftjKdnlJv5eSYZ8AFBuOmvBOCbWSOBLDReqdx3
	GrfgfKMW7eWV69oUZCDKgLgQkUXkdBbBwTN8EUyngOAbOPWDyDv0nTSEKEFXn9r52wRFpE
	TR0obFKAIOy0DLgln+7S2IJAPEjXpik=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH] bcachefs: Change btree_insert_node() assertion to error
Date: Wed,  7 May 2025 14:30:51 -0400
Message-ID: <20250507183051.3235368-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Debug for https://github.com/koverstreet/bcachefs/issues/843

Print useful debug info and go emergency read-only.

(cherry picked from commit 63c3b8f616cc95bb1fcc6101c92485d41c535d7c)

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/btree_update_interior.c | 17 ++++++++++++++++-
 fs/bcachefs/error.c                 |  8 ++++++++
 fs/bcachefs/error.h                 |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/btree_update_interior.c b/fs/bcachefs/btree_update_interior.c
index e4e7c804625e..e9be8b5571a4 100644
--- a/fs/bcachefs/btree_update_interior.c
+++ b/fs/bcachefs/btree_update_interior.c
@@ -35,6 +35,8 @@ static const char * const bch2_btree_update_modes[] = {
 	NULL
 };
 
+static void bch2_btree_update_to_text(struct printbuf *, struct btree_update *);
+
 static int bch2_btree_insert_node(struct btree_update *, struct btree_trans *,
 				  btree_path_idx_t, struct btree *, struct keylist *);
 static void bch2_btree_update_add_new_node(struct btree_update *, struct btree *);
@@ -1782,11 +1784,24 @@ static int bch2_btree_insert_node(struct btree_update *as, struct btree_trans *t
 	int ret;
 
 	lockdep_assert_held(&c->gc_lock);
-	BUG_ON(!btree_node_intent_locked(path, b->c.level));
 	BUG_ON(!b->c.level);
 	BUG_ON(!as || as->b);
 	bch2_verify_keylist_sorted(keys);
 
+	if (!btree_node_intent_locked(path, b->c.level)) {
+		struct printbuf buf = PRINTBUF;
+		bch2_log_msg_start(c, &buf);
+		prt_printf(&buf, "%s(): node not locked at level %u\n",
+			   __func__, b->c.level);
+		bch2_btree_update_to_text(&buf, as);
+		bch2_btree_path_to_text(&buf, trans, path_idx);
+
+		bch2_print_string_as_lines(KERN_ERR, buf.buf);
+		printbuf_exit(&buf);
+		bch2_fs_emergency_read_only(c);
+		return -EIO;
+	}
+
 	ret = bch2_btree_node_lock_write(trans, path, &b->c);
 	if (ret)
 		return ret;
diff --git a/fs/bcachefs/error.c b/fs/bcachefs/error.c
index 038da6a61f6b..6cbf4819e923 100644
--- a/fs/bcachefs/error.c
+++ b/fs/bcachefs/error.c
@@ -11,6 +11,14 @@
 
 #define FSCK_ERR_RATELIMIT_NR	10
 
+void bch2_log_msg_start(struct bch_fs *c, struct printbuf *out)
+{
+#ifdef BCACHEFS_LOG_PREFIX
+	prt_printf(out, bch2_log_msg(c, ""));
+#endif
+	printbuf_indent_add(out, 2);
+}
+
 bool bch2_inconsistent_error(struct bch_fs *c)
 {
 	set_bit(BCH_FS_error, &c->flags);
diff --git a/fs/bcachefs/error.h b/fs/bcachefs/error.h
index 7acf2a27ca28..5730eb6b2f38 100644
--- a/fs/bcachefs/error.h
+++ b/fs/bcachefs/error.h
@@ -18,6 +18,8 @@ struct work_struct;
 
 /* Error messages: */
 
+void bch2_log_msg_start(struct bch_fs *, struct printbuf *);
+
 /*
  * Inconsistency errors: The on disk data is inconsistent. If these occur during
  * initial recovery, they don't indicate a bug in the running code - we walk all
-- 
2.49.0


