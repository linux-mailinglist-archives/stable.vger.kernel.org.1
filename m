Return-Path: <stable+bounces-227404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNHRMEeavGmz1AIAu9opvQ
	(envelope-from <stable+bounces-227404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 01:52:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFD22D481B
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 01:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7135B30C4AD7
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 00:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA2A253F05;
	Fri, 20 Mar 2026 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvuUQMon"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72F24677F
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 00:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967929; cv=none; b=YXdNAkJtJU1lqGZyRRggL7QUOXAinRRA3kxW/9Zftse9uGWTSU+Pf/ej8MRMMc12NfBKeWZqXa5OcCNn/i1/h1AWeQbxauRR/OMXkL6OvnsrexB6OTFyVjfBVtk/9kNLPR9TU8/iwcd8d2jv3CnucQiGaz6+JgP/BRVFpT7IvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967929; c=relaxed/simple;
	bh=6zbojOudXdggg9qVMe4xYt6ynrLslbVnlF/4yirnZVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeueuANKOBjVrCthX7Exy7gHOoJj7Tt4DNeiyTkM2bXHLdMdQZOOpMK4b55x0iK63VE/JG/gHMK80IoAqoKW3jABWk3pYhQi3bA+JrjhuE9fopPHKcGlAEjPRPWISkFJdaS1oXpYtxDDNwfszPRHHmFCRrlrURVQbc99V82xJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvuUQMon; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35a211df8e3so1069733a91.2
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 17:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773967927; x=1774572727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OLuNnZGT6jZ9snvlA/KM/8SsxaBnz20mK3bQKuVL7g=;
        b=UvuUQMon0HHFWaOEKxy4/4l28kL5jD09N3dRPbi4p0vIsVaXYBRxq62FqQfVwGkFum
         3JKEqdJkJSW9xVh7RRJGk7cCiU+g2dXDF/lKnNY1NPrDgb1HuDbAGZjFBrtlP7ODiUoG
         PiFARQkQ/9Z9zrnXVu2+MjFmlhk5+bNkpz3nLkF6N+h3PRTehoidzuK9c6v1eGHQH7dZ
         wxzqzuskx/NpCYw4Eh6TKd6FfxpftldP7cKw+qOgutKKMYkruCIjB0uappJF2WwNjn+9
         RA6mNiJOUy85P32ML/g3k9WYozlVm7x9XW9u5UHh3MtwxVYFiu+NwxHGR/R4JqMR/qcA
         qYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773967927; x=1774572727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2OLuNnZGT6jZ9snvlA/KM/8SsxaBnz20mK3bQKuVL7g=;
        b=MWUkEd20X6X7nzDkTEkk125SVWoPqyZhytM8c3Ri9fG2UOQIHJG4yQPGDU6w/VJn+0
         i7tB+EeW7PCCw/8KXxQ5WmQ5egDKfMzFBbKfJWTd/DHRT8v4ZrXkoutRlHN06rjGG4ey
         GlGebefKLgW+OyMQlhW4UAGkHAZvLLqNR2ApF57jtfawpsOxStNFpPpUSNv58TH7bWtv
         bFH6hN8aezJWv4NfFaYmNj47FTd3+7Scr0sV1u0xCU266A4XBQ4wzBgo4Y7dy28hJwor
         t8Pb5c3NXVlgxZ0KdBXFtHf4jUSCUYKbaRKKhLTFXwsz7cduh7Z3RukAwNIWHZgm23Fy
         QXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8FKNbhb75qOMU7LfnSTvKYFgmSq08O7V0YgvOUdBRvaso1qyF9KnFvT/LpBL1pR3DgYjR66I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa6iWPO8tsD/4meQxWXVDG9K4zs1lceaNYlUXzfUBYip+AmrRM
	YR2xjvtri52L1rnhYz1QIAdIeLqZTKrWFIGHqog+VWtR/ITwOcIFV0il
X-Gm-Gg: ATEYQzwtTboKPs2kjwnxnY5IL/NFlJXKmHxLwWxjJ8S4MDDGZHWX9t4HcXd3rmUuJeH
	tSmDUEwKbhLEkCy8xVW7vxW8Um1hdCgzDbIhsFbX+acjFUMRqn6L07a+kQGvVoOG5pmCwZ/r4FD
	ISIRC7d5tWXHClXfrNLTdIdQh9q9shGj8D/UqJ2lDRPAKin17vFZUY+5KYYnDDEj46Lc+LFb+ij
	4vLnsn2Nw/13/A6f9Ta6jWPISpVQdTmD9OwfU1WaSssb73x76v+Uviwda2a/0OjL2GkXCTUBIEG
	qevZr8IMvfucJIZujqzSk9VDw3CUxFAZ4nXDuaO5XxyBAqArPQe+KXsl5Oopt3oAvvrQYY7Eeyj
	PX8oNHTfVZUBTJW/crytjT0nMVbfA2YWwFH4gVV4kTwhu57REkNKRso7aYrXiifgaTj0df39G85
	GEnE3hh627oz6iPG/gt+875hnnxqU=
X-Received: by 2002:a17:902:e947:b0:2ae:3a77:a1eb with SMTP id d9443c01a7336-2b0827c3e2cmr10402495ad.39.1773967927029;
        Thu, 19 Mar 2026 17:52:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083655b45sm4857475ad.42.2026.03.19.17.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:52:06 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	david@kernel.org,
	therealgraysky@proton.me,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/1] writeback: don't block sync for filesystems with no data integrity guarantees
Date: Thu, 19 Mar 2026 17:51:45 -0700
Message-ID: <20260320005145.2483161-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320005145.2483161-1-joannelkoong@gmail.com>
References: <20260320005145.2483161-1-joannelkoong@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227404-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.948];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proton.me:email]
X-Rspamd-Queue-Id: 3EFD22D481B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that cannot
guarantee data persistence on sync (eg fuse). For superblocks with this
flag set, sync kicks off writeback of dirty inodes but does not wait
for the flusher threads to complete the writeback.

This replaces the per-inode AS_NO_DATA_INTEGRITY mapping flag added in
commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
in wait_sb_inodes()"). The flag belongs at the superblock level because
data integrity is a filesystem-wide property, not a per-inode one.
Having this flag at the superblock level also allows us to skip having
to iterate every dirty inode in wait_sb_inodes() only to skip each inode
individually.

Prior to this commit, mappings with no data integrity guarantees skipped
waiting on writeback completion but still waited on the flusher threads
to finish initiating the writeback. Waiting on the flusher threads is
unnecessary. This commit kicks off writeback but does not wait on the
flusher threads. This change properly addresses a recent report [1] for
a suspend-to-RAM hang seen on fuse-overlayfs that was caused by waiting
on the flusher threads to finish:

Workqueue: pm_fs_sync pm_fs_sync_work_fn
Call Trace:
 <TASK>
 __schedule+0x457/0x1720
 schedule+0x27/0xd0
 wb_wait_for_completion+0x97/0xe0
 sync_inodes_sb+0xf8/0x2e0
 __iterate_supers+0xdc/0x160
 ksys_sync+0x43/0xb0
 pm_fs_sync_work_fn+0x17/0xa0
 process_one_work+0x193/0x350
 worker_thread+0x1a1/0x310
 kthread+0xfc/0x240
 ret_from_fork+0x243/0x280
 ret_from_fork_asm+0x1a/0x30
 </TASK>

On fuse this is problematic because there are paths that may cause the
flusher thread to block (eg if systemd freezes the user session cgroups
first, which freezes the fuse daemon, before invoking the kernel
suspend. The kernel suspend triggers ->write_node() which on fuse issues
a synchronous setattr request, which cannot be processed since the
daemon is frozen. Or if the daemon is buggy and cannot properly complete
writeback, initiating writeback on a dirty folio already under writeback
leads to writeback_get_folio() -> folio_prepare_writeback() ->
unconditional wait on writeback to finish, which will cause a hang).
This commit restores fuse to its prior behavior before tmp folios were
removed, where sync was essentially a no-op.

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a-asuvfrbKXbEwwDSctvemF+6zfhdnuzO65Pt8HsFSRw@mail.gmail.com/T/#m632c4648e9cafc4239299887109ebd880ac6c5c1

Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
Reported-by: John <therealgraysky@proton.me>
Cc: <stable@vger.kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fs-writeback.c              | 18 ++++++++++++------
 fs/fuse/file.c                 |  4 +---
 fs/fuse/inode.c                |  1 +
 include/linux/fs/super_types.h |  1 +
 include/linux/pagemap.h        | 11 -----------
 5 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 7c75ed7e8979..dd6225736721 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2775,13 +2775,8 @@ static void wait_sb_inodes(struct super_block *sb)
 		 * The mapping can appear untagged while still on-list since we
 		 * do not have the mapping lock. Skip it here, wb completion
 		 * will remove it.
-		 *
-		 * If the mapping does not have data integrity semantics,
-		 * there's no need to wait for the writeout to complete, as the
-		 * mapping cannot guarantee that data is persistently stored.
 		 */
-		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
-		    mapping_no_data_integrity(mapping))
+		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
 			continue;
 
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
@@ -2916,6 +2911,17 @@ void sync_inodes_sb(struct super_block *sb)
 	 */
 	if (bdi == &noop_backing_dev_info)
 		return;
+
+	/*
+	 * If the superblock has SB_I_NO_DATA_INTEGRITY set, there's no need to
+	 * wait for the writeout to complete, as the filesystem cannot guarantee
+	 * data persistence on sync. Just kick off writeback and return.
+	 */
+	if (sb->s_iflags & SB_I_NO_DATA_INTEGRITY) {
+		wakeup_flusher_threads_bdi(bdi, WB_REASON_SYNC);
+		return;
+	}
+
 	WARN_ON(!rwsem_is_locked(&sb->s_umount));
 
 	/* protect against inode wb switch, see inode_switch_wbs_work_fn() */
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a9c836d7f586..f6240f24b814 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3202,10 +3202,8 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
-	if (fc->writeback_cache) {
+	if (fc->writeback_cache)
 		mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
-		mapping_set_no_data_integrity(&inode->i_data);
-	}
 
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e57b8af06be9..c795abe47a4f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1709,6 +1709,7 @@ static void fuse_sb_defaults(struct super_block *sb)
 	sb->s_export_op = &fuse_export_operations;
 	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
 	sb->s_iflags |= SB_I_NOIDMAP;
+	sb->s_iflags |= SB_I_NO_DATA_INTEGRITY;
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index fa7638b81246..383050e7fdf5 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -338,5 +338,6 @@ struct super_block {
 #define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
 #define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
 #define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
+#define SB_I_NO_DATA_INTEGRITY	0x00008000 /* fs cannot guarantee data persistence on sync */
 
 #endif /* _LINUX_FS_SUPER_TYPES_H */
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ec442af3f886..31a848485ad9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,7 +210,6 @@ enum mapping_flags {
 	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
 	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
 				   account usage to user cgroups */
-	AS_NO_DATA_INTEGRITY = 11, /* no data integrity guarantees */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
@@ -346,16 +345,6 @@ static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct addres
 	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
 }
 
-static inline void mapping_set_no_data_integrity(struct address_space *mapping)
-{
-	set_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
-}
-
-static inline bool mapping_no_data_integrity(const struct address_space *mapping)
-{
-	return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
-}
-
 static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
 {
 	return mapping->gfp_mask;
-- 
2.52.0


