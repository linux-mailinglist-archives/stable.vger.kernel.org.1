Return-Path: <stable+bounces-227203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ov3DxZiu2lujQIAu9opvQ
	(envelope-from <stable+bounces-227203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 03:40:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C4A2C50E9
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 03:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84A16301C104
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 02:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A96386C02;
	Thu, 19 Mar 2026 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNyn5FyA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39E1F1534
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 02:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773888019; cv=none; b=VuhVplTEeB0UjFxGWUbki7QZWbp5OoguhvzpqGlogVCegR1kLHM1TAHOYtsK5XybkXoe1uMmuLht0DhhZYu0bmrJlxbI4FF+I1GckELGWO0/5tQzZ8RMrasWRozb8JE1INZE+Omdh5GduatH4QF+Xvux5Lg57bueS95jcZ9YGK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773888019; c=relaxed/simple;
	bh=mY5S4EvLe4ZlOs204lwhOVN2qu5Qw+xOHZptPLW7WU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F0sq7GjYOeLFHjm79Y9HVphHMrAeutPS4//aWJyeHhmU8Q5a48/sVh01zIUyiqcJOG6wiygimmi8PyA+DRPMoKRsim9VU5xCyq8FkoD/u3zRZ9t6uTr7uH/VYrDE4Siunlwae9BDTlZOfto3o6aXeQS5Bj2QP99f1clDrwOnkSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNyn5FyA; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso213955a12.1
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 19:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773888017; x=1774492817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HF3dhpPX3brhaCSBxcgIx0vD92ueHkK4Zsm76LgK6Dk=;
        b=eNyn5FyAoDzLDs2NiEww7FdV/t3HEbGJTFJ6cvz92JTO1Z4C6ODpWff2WPL/902cLg
         XcL4EO4BKelSaOTkpKNuVEZrgaiqef4h2oN7Dfpv0IlVhEzN89PG/dcGeS/Zyy2FmL8z
         fTrb4Ux4J4AQ7ZilfXtGEE7UJxvL6O4+yws46UI07pGmwe9LjSprKvTaT4+6Af8N66Li
         blqY4zggotPxgXImcEgqNksLz38tQqr1OuR3SyjKgvwiEHnKbu8+eQM0JvU9aXxO+7SB
         ftlTm3qVb5a56LmbKxzpvLZCzFDu3ivYgtIWefi+7kGJsYavnvAj7DWX7J2zIiarTKT0
         tqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773888017; x=1774492817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HF3dhpPX3brhaCSBxcgIx0vD92ueHkK4Zsm76LgK6Dk=;
        b=JnjNDMzUCZqxLU8zCX9TOnLdpUjqjUUjiBVgxkQRRmDkrZMZ3lf3OOAk61Ml268Exp
         xY1fy7hLUyxAMpw3GxqyO5JsvigdVs24L2cUEbzPfevx1PKmJ27Ha6Sory01mzVFIAKv
         fRlTwSmPactrZWIQRNmA9DaluRElqJA3qTXRJMnukiAGFVxTGBZEiH/3xkfHipL1Z0EX
         l65KoOuA/5upAG8q5W6EDXEwbsGbwRIbBlxtchNaD7IBD1iuNGKY5UaOPNTLjJz7anZy
         13SE9MiQonBWwkz6pXVXpI4nhipvSCMeU8keAcXG6sAP0Ku2BYjlsI9aaiFKf42/M61u
         BMrA==
X-Forwarded-Encrypted: i=1; AJvYcCXRs7ETsnMlRbzc1HeyqbhM28EA5EC9j+uVW4RHzXW9wav15pVo+i4vNRve6hfgKuuG/THia0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs4eHCw2gVM7gAO+47YYghvRJd3GeHVxxUVt6UYmbNumnc4U54
	PQmU5ESUZknL8iU+q2MDf0o3UXvWF6FczWAUaNqXf406od5RlzNSiqQ+
X-Gm-Gg: ATEYQzyy97F6vWm40bRD0oeeMn2+SEpnolXbHzlxyGpCRJjbdMutYr8R1N30MQ8lu+o
	tfTwMSsnErQrjA+DEL/mPR1cRh8JnrFXSRih+KB5wFRjvr4jNpBptj2a5a47FHyegZcnQKPj/Y4
	FcYeOFG+HVF8iiPAF+/0tcX1jMN3Fl4Pil/IZwvN1cYj+KZ6LhWBNADOtvRXlgfrtYnJNnLq5aj
	zQ1mmKY3vrnFE0ZHf7KBlVbQ1J/edWPFsh7v0mvmQuCHK3Bi42fuSs7bivFPUWHuJ7aI8C6SHMD
	3xF94oKpiDGxm4Joz7G5rna1wLgl/O+0CD+249HWZN/WN7sb4gh+vvw7yj9tyM7hwwObn+zCoWo
	75xoGivksgXAtGxVZrZD2JPaGu2qqriAOMjcylkCkzyK2UBYv9eT3OcSnoLB/BwLaUZXMOI2zLs
	F98LVKT5rSI6af7t0N8w==
X-Received: by 2002:a05:6a21:690:b0:398:9c27:2479 with SMTP id adf61e73a8af0-39b99c8d2d6mr5321541637.5.1773888017010;
        Wed, 18 Mar 2026 19:40:17 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c742bc99cf4sm528427a12.0.2026.03.18.19.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 19:40:16 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: annotate data races around fi->i_flags
Date: Thu, 19 Mar 2026 10:23:35 +0800
Message-Id: <20260319022335.3213311-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.sourceforge.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-227203-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.934];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B1C4A2C50E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fi->i_flags can be read by f2fs_update_inode() in the writeback path,
f2fs_getattr(), and f2fs_fileattr_get() without holding inode_lock or
fi->i_sem, while it can be concurrently written by
f2fs_setflags_common(), set_compress_context(), and
f2fs_disable_compressed_file() under inode_lock and/or fi->i_sem.

This is a data race as defined by the LKMM.  Use READ_ONCE() on the
read side and WRITE_ONCE() on the write side to ensure proper marking
of the concurrent accesses.

Fixes: 360985573b55 ("f2fs: separate f2fs i_flags from fs_flags and ext4 i_flags")
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/f2fs/f2fs.h  | 4 ++--
 fs/f2fs/file.c  | 6 +++---
 fs/f2fs/inode.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c66472e409a3..28161df79e4f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4764,7 +4764,7 @@ static inline int set_compress_context(struct inode *inode)
 		fi->i_compress_algorithm == COMPRESS_ZSTD) &&
 			F2FS_OPTION(sbi).compress_level)
 		fi->i_compress_level = F2FS_OPTION(sbi).compress_level;
-	fi->i_flags |= F2FS_COMPR_FL;
+	WRITE_ONCE(fi->i_flags, READ_ONCE(fi->i_flags) | F2FS_COMPR_FL);
 	set_inode_flag(inode, FI_COMPRESSED_FILE);
 	stat_inc_compr_inode(inode);
 	inc_compr_inode_stat(inode);
@@ -4791,7 +4791,7 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
 		return false;
 	}
 
-	fi->i_flags &= ~F2FS_COMPR_FL;
+	WRITE_ONCE(fi->i_flags, READ_ONCE(fi->i_flags) & ~F2FS_COMPR_FL);
 	stat_dec_compr_inode(inode);
 	clear_inode_flag(inode, FI_COMPRESSED_FILE);
 	f2fs_mark_inode_dirty_sync(inode, true);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c8a2f17a8f11..abff927a8699 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1005,7 +1005,7 @@ int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		}
 	}
 
-	flags = fi->i_flags;
+	flags = READ_ONCE(fi->i_flags);
 	if (flags & F2FS_COMPR_FL)
 		stat->attributes |= STATX_ATTR_COMPRESSED;
 	if (flags & F2FS_APPEND_FL)
@@ -2153,7 +2153,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 		}
 	}
 
-	fi->i_flags = iflags | (fi->i_flags & ~mask);
+	WRITE_ONCE(fi->i_flags, iflags | (READ_ONCE(fi->i_flags) & ~mask));
 	f2fs_bug_on(F2FS_I_SB(inode), (fi->i_flags & F2FS_COMPR_FL) &&
 					(fi->i_flags & F2FS_NOCOMP_FL));
 
@@ -3437,7 +3437,7 @@ int f2fs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	u32 fsflags = f2fs_iflags_to_fsflags(fi->i_flags);
+	u32 fsflags = f2fs_iflags_to_fsflags(READ_ONCE(fi->i_flags));
 
 	if (IS_ENCRYPTED(inode))
 		fsflags |= FS_ENCRYPT_FL;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 078874db918c..17c8aff690fb 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -720,7 +720,7 @@ void f2fs_update_inode(struct inode *inode, struct folio *node_folio)
 	else if (S_ISREG(inode->i_mode))
 		ri->i_gc_failures = cpu_to_le16(fi->i_gc_failures);
 	ri->i_xattr_nid = cpu_to_le32(fi->i_xattr_nid);
-	ri->i_flags = cpu_to_le32(fi->i_flags);
+	ri->i_flags = cpu_to_le32(READ_ONCE(fi->i_flags));
 	ri->i_pino = cpu_to_le32(fi->i_pino);
 	ri->i_generation = cpu_to_le32(inode->i_generation);
 	ri->i_dir_level = fi->i_dir_level;
-- 
2.34.1


