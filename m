Return-Path: <stable+bounces-239976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DU1MkFw5mmBwAEAu9opvQ
	(envelope-from <stable+bounces-239976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:28:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AD1432D5A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75593305638D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAB13AB263;
	Mon, 20 Apr 2026 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKR3+zMo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCC53AA4E1;
	Mon, 20 Apr 2026 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708636; cv=none; b=LFAN4Scge5dSwwIrriHk3qrWUdD27Xbel3Tpkk4OfJLv7IxANyB3rpzOQ6p/7fWHUpj+2LNuJ509ntJODUHGJyiMUFyTvMUWI+oulzZFuOCCuVG+J5oqAp422Dx1bgPU6nlpdCAQhiAZCRdn/ys1xLFGAd1wOrCbEyw5w6AlhAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708636; c=relaxed/simple;
	bh=pWrR8Z0Td/iCp1eVgaoH6EZ4EwyB4hXurSX8ZNwlu2c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=E971+r8BqsuxxASiRmAymLct1g9UnRMW1nVI7WDsiFm8/UBzd/UrXNuCANJYNFGTEdQ1vEhgNIi8xAPgRcN3FE+9MfGekqpt71NcMBP9kgL48CQErzBvvDIBx4sTr0Xi89IfCT6CRr6MhuacawI46XT4YsqaR3z3tDDJz3hpKhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKR3+zMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356C2C2BCB8;
	Mon, 20 Apr 2026 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776708636;
	bh=pWrR8Z0Td/iCp1eVgaoH6EZ4EwyB4hXurSX8ZNwlu2c=;
	h=Date:From:To:Cc:Subject:References:From;
	b=mKR3+zMo4XMXE0JIX6OuK5UCPM1ZXgZJ58APv8pjIiT3Rxmj3qBRGCX4Pd8GAE3/Y
	 Euhz2XbGFS/Y3EIzOm5W2wvQYgwEnpPGNP1mTIm0KX+1Tk85ViruPFQ6hf/qEMQxBC
	 o18vTFLYkeybCpgL7OCHOHHSq+LwuTGxykmsZ4ea/UrnWXCHSXVoXonbaslaMqgqPT
	 ByWJURApCHnfAKofXNh+R6yaOCYuRKa9+e1O6SN7xpEzh0Ywpptgo7i8AZOYL5gqWA
	 f3Y9gZyRMkALVOtKAerGq4HOtPkBvx+zlXCNQX6P746rdzvFVYQd4vtBNpOcFA2/6G
	 P3Fxx6evW4wfg==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1wEt6a-00000006nIo-27Wy;
	Mon, 20 Apr 2026 14:12:20 -0400
Message-ID: <20260420181220.362882530@kernel.org>
User-Agent: quilt/0.69
Date: Mon, 20 Apr 2026 14:11:53 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 David Carlier <devnexen@gmail.com>
Subject: [for-linus][PATCH 2/2] eventfs: Hold eventfs_mutex and SRCU when remount walks events
References: <20260420181151.771404678@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,efficios.com,linux-foundation.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239976-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,goodmis.org:email,msgid.link:url]
X-Rspamd-Queue-Id: C9AD1432D5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Carlier <devnexen@gmail.com>

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
Link: https://patch.msgid.link/20260418191737.10289-1-devnexen@gmail.com
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 14 ++++++++++++++
 fs/tracefs/inode.c       |  5 ++++-
 fs/tracefs/internal.h    |  3 +++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 8dd554508828..26b6453de30e 100644
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
index 5602baf980f6..1e8a78c5e996 100644
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
2.51.0



