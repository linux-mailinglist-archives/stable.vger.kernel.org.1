Return-Path: <stable+bounces-230040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHPoM5vewWnxXQQAu9opvQ
	(envelope-from <stable+bounces-230040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:45:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDCA2FFF01
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E2B33038D52
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 00:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EE5332EA0;
	Tue, 24 Mar 2026 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kagXhBpw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B924BBF0
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313043; cv=none; b=nSrj1zhl1ajuNLUgmVFG81r1HVFnovo3KDJIrwQAJPCZI6udCMp6NMHgpbFcKnr5P+Frfhe82HY6Pe+SO7hWv50GfpI4M/F2b7WHoP5mqHF4Gv+4io3qqQfCni5lQbqB/mEtKsWIF7ZF+nyf/i0A900uu7v6jURK81CM0rf6V+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313043; c=relaxed/simple;
	bh=YhtyfJ45Egr/v4difiiZp6RTk5abgQy3xHFlwXSZ+mI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kwxKzrREq9Vq3qBWjxYU6KgbsjYwY+Jst0Y1xrn2sD4RsR+HKGj2rmisQTSaf3GJSvpbO2sqLkkv1Rm2ZnMkroRWhNpPAM35hp/WTuEZDxbmYDxpbk77poGyjg7lwJ9yPlsw+hJcoliLZxLVXNXw/gkw2+37ddlBNihBY758w8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kagXhBpw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8296dabef74so4055980b3a.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 17:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774313040; x=1774917840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WDF2rKSjnx+vam0p+IAkZHVoKVx3ZMEABJISbR0EKR8=;
        b=kagXhBpw2+IPoIgrmJBkqHEJxDZDOS300cG8dfkOWLAnviyHg4I3d7f3cU+1gawLlS
         /z/gG2dTEJ2ygJa7uzlH+kW7bbheQWWGIlNrW1R9i3nQniipgZakomPSZf7t4vj7uFi9
         ASiEi6oIYRoGwwazw0LrB/Tf5h784MMXkLKRei+HcZlkE9KidGnbvDDObZY2rLBrXp4X
         L+iAp4tFt12o69OKN//BAGeY234zJpUr48027IgFKY/UwZA7F24g/gEZEZ8wCjrqNRwr
         k0ddklj8BWuHO3qBYGdUI/yK/HLet3zRUcNFzVxo5BXFe7jLsPITIHTMTJ+ijjkBFQMv
         4FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774313040; x=1774917840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDF2rKSjnx+vam0p+IAkZHVoKVx3ZMEABJISbR0EKR8=;
        b=CJctdv41uCEgeTLZd4O9Np2J05jT1vJqwiPgorB0Qq54uySIWbL2rCPkHiMYaDSwSZ
         U68qdP8JDPZL2CGdPgb8K3qY28o+x7KHRQI2qfSxrECbbp1ol8cFa/RHjohCqTvLM8IO
         8CNg0gTFNFK4RWDeax3OlYzJLZEw4PNP9Lv4PMk0Xi0cACyuMTydb46fSzWKSyE7OUUL
         r10mSnWqi70IqWReUFKlvCW+gaw30A9VJQZ64N8I/LKPlFrCKElIUXxlP3+A9F/7wNzK
         e2D6XcC6sPmtRGXSHmB1cajQkdr76RVww7UTLHTgdIu4zZKiRH8KxyG5Geyj8qfGp0OT
         EGQg==
X-Forwarded-Encrypted: i=1; AJvYcCVaia5fXvoedKR9Fk+3MEnkQXZIu7wV7mmovVMu0fc1rGSGahvaXhz3HcKFNamK02i1ynkL3u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGn4CDRUUoMIuEiAoeQYvhHvtDk4aV6CgLwmL4u1lQT0Z5DNsr
	Q+cttQicgYCHdis7wmkEVKj4sli8cq91y/bqBH31sXx3rx2dW+EcgISj
X-Gm-Gg: ATEYQzwd1CfqPeHNjJAuKU9wUprpdWbsMYgd3HUyuXuvdXKWUDn6HLpC4bt99mYDx4v
	Fw593K+QeBEJM4rNX+n5NlrOIJOkE9xNFHb+HIfXtSiWm5cSuvXf+S8FY1DpuGE8g+Z4rVYBakB
	igMKW/9CoL1haE8HVWjjcMmQ5SX83Xf+oUpOT/7/DpZ0pEZd8cWJB2M26EJzQunaWwdHrBHF9vN
	QXfsYf1zcXWGYZ/WIfbvCIc6IYXCJLn5nDAYBfwEXjrpHCNaCsJuy99h8Unpfk0bX/9tCj3RPkz
	ITLx+wj6NJz8dZtqFA/wGfYv+9F4kUiSmF1unilnsL/F16L6b64KSG+1pog0ITC9gOy0nI04CKi
	BJtn/olMJqYFeQuEminxo66fWcsEYwCt574PGRvdwEmnz6lD3KcKfI2o2NGSFPQvmBZ2JF+E5ZL
	0epHdY3DONsTA6htnuTQ==
X-Received: by 2002:a05:6a20:734b:b0:38b:dec8:9da2 with SMTP id adf61e73a8af0-39bce9f7a44mr12203730637.26.1774313040089;
        Mon, 23 Mar 2026 17:44:00 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443cc2ddsm8105285a12.24.2026.03.23.17.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:43:59 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: jaegeuk@kernel.org
Cc: chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] f2fs: annotate data races around fi->i_flags
Date: Tue, 24 Mar 2026 08:26:20 +0800
Message-Id: <20260324002620.3879274-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lists.sourceforge.net,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230040-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FDCA2FFF01
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

Fixes: 19f99cee206c ("f2fs: add core inode operations")
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


