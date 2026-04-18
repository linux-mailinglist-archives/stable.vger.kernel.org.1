Return-Path: <stable+bounces-238607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGmbKdzY42nDLQEAu9opvQ
	(envelope-from <stable+bounces-238607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 21:17:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0204A42209E
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 21:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 274AE302B767
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 19:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E74730C35C;
	Sat, 18 Apr 2026 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaHxRZaR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693B40DFDD
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776539863; cv=none; b=bHCBMUJ90XiAKP2QVaLErRNtiA1z0XYXZun6WGVgCt4ZtboSigI3BsB1oI5JnW66tQC19/q1y1yQF87TRJ7/n+2AX69GUq8/UuWFo85IaRIUCoJ+vWoC3HZg1eJ+7H4FTvjUe6q89pBcvg4C05jfje+SRvkZubQfSEHPcGXbwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776539863; c=relaxed/simple;
	bh=GymHzhvKrvD17ZOrxb4Dq9BmOKQK6lNjMoVhIjQSDAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKedYNrh7UKcTeUmbbzihT8QHZMHjqoR9zHz1wiAPhJ+DBhJkgyYWNoLgzCLIe5iK/ru9DsUVTtckG8Dq55I5bsyTaO0UceVrSXuBPASVUK20r7Sx9qGoK3CUMJ9bguKEzCMmNH6eDHdecSzG/nH8Kd0azjHiZqYMB4WoOMPWGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaHxRZaR; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso1030713f8f.0
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776539860; x=1777144660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NrEV29CtMlnaVQCR7QbuyoYiQZBB4+LYKoPg0T6j78k=;
        b=EaHxRZaRhv+D1Djj57nmPrmEsca1Q4hzTeYJeDMzgpWrsPJLDyHIpKa/za3NdwOcvR
         aBjcJ+o2Sd/fR72+Fg4QHkqNE6yeVIkrB+72yN4iLH9iCfMyTXTw9rNPQepVTcXI/X73
         351e7e++jZGRMdnhrLuOokus6IjFK/G9kdyjKVDEC4nvZ0EXzHwOqk+rhU9CRjWu6bw1
         AtQq7Ej5uJF49uR5+Kzds19UXL2vt0WSbxO1vwKLR86oHW+ar2q6L6FozbSOc8ukwZ0d
         0FJr1v4Pk6nnRpZo4sKEpLRh8AbWdObmUv978CFAKQpI7dm2njs22F0FKYhbwCNAadVf
         +crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776539860; x=1777144660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrEV29CtMlnaVQCR7QbuyoYiQZBB4+LYKoPg0T6j78k=;
        b=OV/09aieCFetm8Ej6Y/YnSyQ/yR/bs/u7OM6khK4En4z+OFWPmiZYePbcDwcWiG205
         +lr160nUHwwJdqr4nsaO2bKkm4/8XrFpjeZgYEgU0tUrvy1U8QsZzuaNm8h74k1ykwKV
         gg3nwMzDBRfC46Om3eHMKm2213Kmw/jNCHN40iia8WCDKcl6HcRxdnj1LdCCL3aJGtCb
         Cug1usGRekYuY+vX0TMjGgDE3AqiEuQUrrtYrkbFl3MF3CVMUcsa4qPPxBc+3OTzlkoh
         +mC3W208FbUIsgXvraFRu+BLdBj7bZx22zHjiZ38DPyr1Y0iH6jaRXLbC9pMk5WPZN0N
         /N0Q==
X-Forwarded-Encrypted: i=1; AFNElJ87TOjsUbjNyQnEf6Y3nksOtqRxjRgh/osWS6bT0cMLzH25SSth2aN3Jo8UtZP23O1RLejuXIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOa12dNM0nHmy5PgXlo6kcfF2scgMAq11pdeFC+CDwHwLNjUU0
	97sN7uBi0o4gqIJqxIuuflTa/z6I1Q8DWCOSItSHAAV1/37fVRIBNGVi
X-Gm-Gg: AeBDieupCa8RLTlLh4+qunPUgcZoXZIjlPKP6Q5MkPOYxePAb/HOsgVBaX7EoXi5bob
	Yygwv7N+6eNJ8o4w8JKbhiYwuCYsdOkJdIl7EpHLqy0etFjsFzcnsxLzffOyG9pbJtKwoQX3Z0t
	ktiZnHm/5bHdPuylTJOjbtn359j9NkvTHOpv5phzN/HFLnSgffA+iQQEIZS+0CzJXb5iVwu/2ej
	8UmuR/2SbKwfdqt42+VIQlYvN92jOeDauf8siLU8982RJm87VVZJpPTJ0i8V6VGozaWbWvLvWwq
	W/pe8VIgQEy/nBJWTMLm3zG4TQRkrJ/RBGpvRJ0khVJb9ONxKvq54WuGltTB+Npu6G8lvCRIY6O
	X5PIJEROPXdpveH5emxNFeh3n1oRyCyRba+WEOtexWuMuzL+I76diWV9MiJ1vW8zOrdSw+nzupW
	AqwaQohd1n0AC/INn7D3rIabXoZxojorDS+i5mvD+Hu4LGwOSbkSCiWxR6wxTIZYPeYjp8PQufc
	m6f3948IUIIVSnAynvNXA==
X-Received: by 2002:a05:6000:40de:b0:43d:7946:badc with SMTP id ffacd0b85a97d-43fe3e073dcmr11320272f8f.26.1776539859788;
        Sat, 18 Apr 2026 12:17:39 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm15253423f8f.0.2026.04.18.12.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 12:17:39 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] eventfs: Hold eventfs_mutex and SRCU when remount walks events
Date: Sat, 18 Apr 2026 20:17:37 +0100
Message-ID: <20260418191737.10289-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[efficios.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-238607-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0204A42209E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 340f0c7067a9 ("eventfs: Update all the eventfs_inodes from the
events descriptor") had eventfs_set_attrs() recurse through ei->children
on remount.  The walk only holds the rcu_read_lock() taken by
tracefs_apply_options() over tracefs_inodes, which is wrong:

  - list_for_each_entry over ei->children races with the list_del_rcu()
    in eventfs_remove_rec() -- LIST_POISON1 deref, same shape as
    d2603279c7d6.
  - eventfs_inodes are freed via call_srcu(&eventfs_srcu, ...).
    rcu_read_lock() does not extend an SRCU grace period, so ti->private
    can be reclaimed under the walk.
  - The writes to ei->attr race with eventfs_set_attr(), which holds
    eventfs_mutex.

Reproducer:

  while :; do mount -o remount,uid=$((RANDOM%1000)) /sys/kernel/tracing; done &
  while :; do
      echo "p:kp submit_bio" > /sys/kernel/tracing/kprobe_events
      echo > /sys/kernel/tracing/kprobe_events
  done

Wrap the events portion of tracefs_apply_options() in
eventfs_remount_lock()/_unlock() that take eventfs_mutex and
srcu_read_lock(&eventfs_srcu).  eventfs_set_attrs() doesn't sleep so the
nested rcu_read_lock() is fine; lockdep_assert_held() pins the contract.

Comment in tracefs_drop_inode() said "RCU cycle" -- it is SRCU.

Fixes: 340f0c7067a9 ("eventfs: Update all the eventfs_inodes from the events descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 fs/tracefs/event_inode.c | 14 ++++++++++++++
 fs/tracefs/inode.c       |  5 ++++-
 fs/tracefs/internal.h    |  3 +++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 81df94038f2e..79193021c6b0 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -244,6 +244,8 @@ static void eventfs_set_attrs(struct eventfs_inode *ei, bool update_uid, kuid_t
 {
 	struct eventfs_inode *ei_child;
 
+	lockdep_assert_held(&eventfs_mutex);
+
 	/* Update events/<system>/<event> */
 	if (WARN_ON_ONCE(level > 3))
 		return;
@@ -886,3 +888,15 @@ void eventfs_remove_events_dir(struct eventfs_inode *ei)
 	d_invalidate(dentry);
 	d_make_discardable(dentry);
 }
+
+int eventfs_remount_lock(void)
+{
+	mutex_lock(&eventfs_mutex);
+	return srcu_read_lock(&eventfs_srcu);
+}
+
+void eventfs_remount_unlock(int srcu_idx)
+{
+	srcu_read_unlock(&eventfs_srcu, srcu_idx);
+	mutex_unlock(&eventfs_mutex);
+}
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 03f768536fd5..f3d6188a3b7b 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -313,6 +313,7 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 	struct inode *inode = d_inode(sb->s_root);
 	struct tracefs_inode *ti;
 	bool update_uid, update_gid;
+	int srcu_idx;
 	umode_t tmp_mode;
 
 	/*
@@ -337,6 +338,7 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 		update_uid = fsi->opts & BIT(Opt_uid);
 		update_gid = fsi->opts & BIT(Opt_gid);
 
+		srcu_idx = eventfs_remount_lock();
 		rcu_read_lock();
 		list_for_each_entry_rcu(ti, &tracefs_inodes, list) {
 			if (update_uid) {
@@ -358,6 +360,7 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 				eventfs_remount(ti, update_uid, update_gid);
 		}
 		rcu_read_unlock();
+		eventfs_remount_unlock(srcu_idx);
 	}
 
 	return 0;
@@ -403,7 +406,7 @@ static int tracefs_drop_inode(struct inode *inode)
 	 * This inode is being freed and cannot be used for
 	 * eventfs. Clear the flag so that it doesn't call into
 	 * eventfs during the remount flag updates. The eventfs_inode
-	 * gets freed after an RCU cycle, so the content will still
+	 * gets freed after an SRCU cycle, so the content will still
 	 * be safe if the iteration is going on now.
 	 */
 	ti->flags &= ~TRACEFS_EVENT_INODE;
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index d83c2a25f288..a4a7f8431aff 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -76,4 +76,7 @@ struct inode *tracefs_get_inode(struct super_block *sb);
 void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid);
 void eventfs_d_release(struct dentry *dentry);
 
+int eventfs_remount_lock(void);
+void eventfs_remount_unlock(int srcu_idx);
+
 #endif /* _TRACEFS_INTERNAL_H */
-- 
2.53.0


