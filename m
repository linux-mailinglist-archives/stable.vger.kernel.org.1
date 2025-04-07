Return-Path: <stable+bounces-128427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4CCA7D140
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 02:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7CF16EAAA
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 00:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A2139E;
	Mon,  7 Apr 2025 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIBRtGCN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5B191;
	Mon,  7 Apr 2025 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743984656; cv=none; b=kKH4XQ6BDUnhAaDalEYO5kmXP+fXMIad92GMNO+Yw/uuyfRuamH6IdArx1HU/MN9+ZrusaFfMfpV5dlJT4XFVB3QnOcxgzxxwYfPHpu94hivAgX3z5Iw3Y+LwZdMFdkzPKVGTtBfp8IVAY3ySIctoBTCRXXZ+QXWGzwxb+B/MvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743984656; c=relaxed/simple;
	bh=9un9VmFkdH9K3+ubLeKF5bvDTRpmsxY+GE0bjL8Hmpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AJdAdqMpVy5HcTBt3CFKegq57898816CNM6ontAJGFBlAt2cq1bCDPG8mQubhMt0hvsfSyKDeo2+dzn8XiUYENP2BeSO9sh0fL5VmAkO/pnSZXi7IeWtsOxAM1g0Wjb9NmSWibgWwy/tbzWHzwkZbeet7r8h8AupCsTQCDRDw4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIBRtGCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6E4C4CEE3;
	Mon,  7 Apr 2025 00:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743984655;
	bh=9un9VmFkdH9K3+ubLeKF5bvDTRpmsxY+GE0bjL8Hmpg=;
	h=From:To:Cc:Subject:Date:From;
	b=SIBRtGCNSzbEd33ko9d2X0/uxOvR8U0MQins8rNMCDytJ9wCsp9UkzDnM/T5XQhR5
	 WgYYtjdqKCoFlQkGx+x0Jt2ZkDki9JlwQEJWwpFkbq3p2aPZ3Qbu4wYuIGdoBHc4c7
	 dP3zkQtVYLgml/OrOQYrvfTeOw7dj8lpzA6u+Lob2fQcrXTb23Ko9sg3KdlAr/qB3J
	 FPmY5JGLvynnlQ178BUiwpe9DoEspq3SdXw8Ausz2LgcGq44S6064bu/QWlZlq7anQ
	 AH60SRSXr248euDum6TKPqHanXdmGSpL6aRWAYpV/wu+wCVXv3yHhU1jG0hy1RQY0e
	 Q6uT1w+MGXYTQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5] KEYS: Add a list for unreferenced keys
Date: Mon,  7 Apr 2025 03:10:45 +0300
Message-Id: <20250407001046.19189-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Add an isolated list of unreferenced keys to be queued for deletion, and
try to pin the keys in the garbage collector before processing anything.
Skip unpinnable keys.

Use this list for blocking the reaping process during the teardown:

1. First off, the keys added to `keys_graveyard` are snapshotted, and the
   list is flushed. This the very last step in `key_put()`.
2. `key_put()` reaches zero. This will mark key as busy for the garbage
   collector.
3. `key_garbage_collector()` will try to increase refcount, which won't go
   above zero. Whenever this happens, the key will be skipped.

Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
v5:
- Rebased on top of v6.15-rc
- Updated commit message to explain how spin lock and refcount
  isolate the time window in key_put().
v4:
- Pin the key while processing key type teardown. Skip dead keys.
- Revert key_gc_graveyard back key_gc_unused_keys.
- Rewrote the commit message.
- "unsigned long flags" declaration somehow did make to the previous
  patch (sorry).
v3:
- Using spin_lock() fails since key_put() is executed inside IRQs.
  Using spin_lock_irqsave() would neither work given the lock is
  acquired for /proc/keys. Therefore, separate the lock for
  graveyard and key_graveyard before reaping key_serial_tree.
v2:
- Rename key_gc_unused_keys as key_gc_graveyard, and re-document the
  function.
---
 include/linux/key.h      |  7 ++-----
 security/keys/gc.c       | 21 +++++++++++++++++++++
 security/keys/internal.h |  2 ++
 security/keys/key.c      | 11 ++++-------
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index ba05de8579ec..c50659184bdf 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -195,10 +195,8 @@ enum key_state {
 struct key {
 	refcount_t		usage;		/* number of references */
 	key_serial_t		serial;		/* key serial number */
-	union {
-		struct list_head graveyard_link;
-		struct rb_node	serial_node;
-	};
+	struct list_head	graveyard_link; /* key->usage == 0 */
+	struct rb_node		serial_node;
 #ifdef CONFIG_KEY_NOTIFICATIONS
 	struct watch_list	*watchers;	/* Entities watching this key for changes */
 #endif
@@ -236,7 +234,6 @@ struct key {
 #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
 #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
 #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
-#define KEY_FLAG_FINAL_PUT	10	/* set if final put has happened on key */
 
 	/* the key type and key description string
 	 * - the desc is used to match a key against search criteria
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 4a7f32a1208b..e32534027494 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -193,6 +193,7 @@ static void key_garbage_collector(struct work_struct *work)
 	struct rb_node *cursor;
 	struct key *key;
 	time64_t new_timer, limit, expiry;
+	unsigned long flags;
 
 	kenter("[%lx,%x]", key_gc_flags, gc_state);
 
@@ -210,17 +211,36 @@ static void key_garbage_collector(struct work_struct *work)
 
 	new_timer = TIME64_MAX;
 
+	spin_lock_irqsave(&key_graveyard_lock, flags);
+	list_splice_init(&key_graveyard, &graveyard);
+	spin_unlock_irqrestore(&key_graveyard_lock, flags);
+
+	list_for_each_entry(key, &graveyard, graveyard_link) {
+		spin_lock(&key_serial_lock);
+		kdebug("unrefd key %d", key->serial);
+		rb_erase(&key->serial_node, &key_serial_tree);
+		spin_unlock(&key_serial_lock);
+	}
+
 	/* As only this function is permitted to remove things from the key
 	 * serial tree, if cursor is non-NULL then it will always point to a
 	 * valid node in the tree - even if lock got dropped.
 	 */
 	spin_lock(&key_serial_lock);
+	key = NULL;
 	cursor = rb_first(&key_serial_tree);
 
 continue_scanning:
+	key_put(key);
 	while (cursor) {
 		key = rb_entry(cursor, struct key, serial_node);
 		cursor = rb_next(cursor);
+		/* key_get(), unless zero: */
+		if (!refcount_inc_not_zero(&key->usage)) {
+			key = NULL;
+			gc_state |= KEY_GC_REAP_AGAIN;
+			goto skip_dead_key;
+		}
 
 		if (unlikely(gc_state & KEY_GC_REAPING_DEAD_1)) {
 			if (key->type == key_gc_dead_keytype) {
@@ -273,6 +293,7 @@ static void key_garbage_collector(struct work_struct *work)
 		spin_lock(&key_serial_lock);
 		goto continue_scanning;
 	}
+	key_put(key);
 
 	/* We've completed the pass.  Set the timer if we need to and queue a
 	 * new cycle if necessary.  We keep executing cycles until we find one
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 676d4ce8b431..4e3d9b322390 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -69,6 +69,8 @@ extern spinlock_t key_graveyard_lock;
 extern struct rb_root	key_user_tree;
 extern spinlock_t	key_user_lock;
 extern struct key_user	root_key_user;
+extern struct list_head	key_graveyard;
+extern spinlock_t	key_graveyard_lock;
 
 extern struct key_user *key_user_lookup(kuid_t uid);
 extern void key_user_put(struct key_user *user);
diff --git a/security/keys/key.c b/security/keys/key.c
index 23cfa62f9c7e..7511f2017b6b 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -22,6 +22,8 @@ DEFINE_SPINLOCK(key_serial_lock);
 
 struct rb_root	key_user_tree; /* tree of quota records indexed by UID */
 DEFINE_SPINLOCK(key_user_lock);
+LIST_HEAD(key_graveyard);
+DEFINE_SPINLOCK(key_graveyard_lock);
 
 unsigned int key_quota_root_maxkeys = 1000000;	/* root's key count quota */
 unsigned int key_quota_root_maxbytes = 25000000; /* root's key space quota */
@@ -658,14 +660,9 @@ void key_put(struct key *key)
 				key->user->qnbytes -= key->quotalen;
 				spin_unlock_irqrestore(&key->user->lock, flags);
 			}
-			smp_mb(); /* key->user before FINAL_PUT set. */
-			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
-			spin_lock(&key_serial_lock);
-			rb_erase(&key->serial_node, &key_serial_tree);
-			spin_unlock(&key_serial_lock);
-			spin_lock(&key_graveyard_lock);
+			spin_lock_irqsave(&key_graveyard_lock, flags);
 			list_add_tail(&key->graveyard_link, &key_graveyard);
-			spin_unlock(&key_graveyard_lock);
+			spin_unlock_irqrestore(&key_graveyard_lock, flags);
 			schedule_work(&key_gc_work);
 		}
 	}
-- 
2.39.5


