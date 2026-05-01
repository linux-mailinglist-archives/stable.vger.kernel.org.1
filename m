Return-Path: <stable+bounces-242300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DocIICI9Gl3CAIAu9opvQ
	(envelope-from <stable+bounces-242300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:03:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 048704ABD8F
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B9B43016F30
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0778739C015;
	Fri,  1 May 2026 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcQz8oOA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A139B488
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633372; cv=none; b=FS1pZeUrjF67AXSlFjdq3t21yIzTsKmb1dbCakSpDnoyi8CqM0knGzf1ILPNVPCzkDNQJ+Zr99bIhbMJP0GvQ3GXUAIxKHpFJ4ycjl0GFZSPeeSw5DLysq+dkqR4lGvVCEedfg5ugeGrG88d0gUbu+Bqs+a6Wtogfy9fGDHNZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633372; c=relaxed/simple;
	bh=FO4uYCslB8uw9GgCcf+U9hU9S4PuFGJx/NZIUxdIVlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kv1qQXY7XhSpjr3tSLBtCiVBB35/eaCNYaf6OvxyYX2uer9abMJs19wAucw/wCGA7gPngd7jYp/zg2XfVqL8UQ18kN+59xpGtWK9/z024ieWi2oGvFB4kwGAkLxkMUqj9nkBJQGCYocHXEVIQ2o9rPGxX7x4xIf+SSTqML5UVvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcQz8oOA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so17630505e9.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633370; x=1778238170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+0lxbCgi4fdg+cPkHoOKKRDCXmHxPZDe6bIN/WeBEA=;
        b=AcQz8oOAmxnQUDjm5uUaNVvuuYCpcAtxBNHyQ5Xj1iNUV9bZDTELXiIrcy42birTc1
         27oVCyfA8lB2jNO2d0x62MKc8by6ZEO+vUQRgHIMxrsZyP5nszSGkkOtkdyQkEsQxluY
         9osBj66sxJqkt+lNkV6+4K/w5ADr1P2hH72fOxJfdsdq1qLJtXKdTPXtbdLZQ1CfbwPk
         izek5UGxuUir6t7Kgb3NAnMLEDyIa4k0iB0mh2m2wYSG3Ln0ZzFk7gjENs+5QcQpRnVe
         tdpFUMpUZxvhN5IOXsa4eFQqFkEnyrLf+CvEK0IwiAfbBuU5J9/fIsLVge0BahnwwtCa
         sX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633370; x=1778238170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q+0lxbCgi4fdg+cPkHoOKKRDCXmHxPZDe6bIN/WeBEA=;
        b=m5JyVkD7GrxTXgFXjV3aVeyXGIsSR/02HhpTHoksnpLt9J1GRcyTXmQLH58fO5mmeZ
         zO2EQZxtcslTZcQECyzbV3RSV4PDmnI71OFxERqlOar/l374clKzxSKcASwqr+sMeBio
         YEoJm2Vtb6ODsTdU/Rxm3HtJzPz1OMiAel5pqiLG7lODt83JrC8Kko6KG0Wjgf/9KdES
         5nGvmrBXPf6CtqmisS9+lvVcXZhPFHG2u57MYHBE1wK/I+CEqEu2oozGuEkXOrZVILLN
         KXu8GIevsj0nTEwoPrKQ3wxAvBD+4DIIt5EXO1J3A+9XTkJ14NkjANvB6mCiX+Ndg4mh
         nPMw==
X-Forwarded-Encrypted: i=1; AFNElJ9dVdpm1bchobyMEj8pxc/CI0UkqjuiOZU3yJcyC/Gv4dlZ2V/xV3svCllr8LWIrWCHvxICtkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFSm7U0/ZPfUsBlDdOb/Fe2zcb2rlKp2elt5sJQ9uwMWOyB9D4
	bx3D6QK7B1wjxhsSSHk/DgwyGZaBd5xXSe7Gp3mRTOCPsPFm3Lf+qwM=
X-Gm-Gg: AeBDievhGtS3zVmwaorqYbWlJetjuI/Rvkpf5wpwpFVxHgVSJcoP+B1x/B3zL+jy++3
	RIwSjqtABBsgIvwadA9UvG1eBJi8BGYqhbm8RoEoM2jZTAsREqLwmeU/BLqu6130VtDx69QXKoW
	UzU3esdWPfPXlaVq+/XoiKScvdVPECxo2BG0WqH+IkrdMDmUk6ZNGIuiCJuYso77HhamgFKxWIU
	bisbXFl26xwBt+b6usEpqefdrGv6u2J9G2Fw3WcttX1JfC4rKl1YfLtGp1DZG9l/97oI88lc3Ua
	YfWsi3tJjFCOesL1+N20e++hZaTDGML6lU+xSEBiyWvXagOIsz8nWler76fPMbUsmKOKGkaeeWA
	LGqu0mqxPgeLySwuiSMnUWEoUzOcw/X2arxVW0Kh97ad0iicvNrrEE+LYesrQKQHsz5ak7Y9KWH
	vSFZRt0umZPX5txg==
X-Received: by 2002:a05:600c:8710:b0:48a:581c:ead with SMTP id 5b1f17b1804b1-48a844448f9mr115645805e9.10.1777633369516;
        Fri, 01 May 2026 04:02:49 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb3427fsm79491905e9.0.2026.05.01.04.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:02:49 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	syzbot+61a9d95630970eece39d@syzkaller.appspotmail.com
Subject: [PATCH 3/3] jffs2: fix GC thread BUG_ON during reconfigure via fspick
Date: Fri,  1 May 2026 11:02:46 +0000
Message-ID: <20260501110246.50647-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501110246.50647-1-tristmd@gmail.com>
References: <20260501110246.50647-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 048704ABD8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242300-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,61a9d95630970eece39d];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email,talencesecurity.com:email]

From: Tristan Madani <tristan@talencesecurity.com>

jffs2_do_remount_fs() uses fc->sb_flags to decide whether to start
the garbage collection thread.  However, when called via fspick(2)
followed by fsconfig(FSCONFIG_CMD_RECONFIGURE), fc->sb_flags does
not reflect the current mount state -- it only contains flags being
explicitly changed (as indicated by fc->sb_flags_mask).

When fspick() is called with flags=0 on a read-only mount,
fc->sb_flags has SB_RDONLY clear (since SB_RDONLY is not in
sb_flags_mask).  This causes jffs2_start_garbage_collect_thread()
to be called even though the filesystem remains read-only.  On the
second reconfigure, BUG_ON(c->gc_task) fires because the thread
from the first call is still running.

Fix this by computing the effective read-only state using both
fc->sb_flags and fc->sb_flags_mask.  Also unconditionally call
jffs2_stop_garbage_collect_thread() before potentially restarting
it, which is safe when gc_task is NULL and prevents the BUG_ON.

Reported-by: syzbot+61a9d95630970eece39d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=61a9d95630970eece39d
Tested-by: syzbot+61a9d95630970eece39d@syzkaller.appspotmail.com
Fixes: ec10a24f10c8f ("vfs: Convert jffs2 to use the new mount API")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/jffs2/fs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 6ada8369a7622..33574312b7abe 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -396,28 +396,28 @@ void jffs2_dirty_inode(struct inode *inode, int flags)
 int jffs2_do_remount_fs(struct super_block *sb, struct fs_context *fc)
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
+	bool new_ro;
 
 	if (c->flags & JFFS2_SB_FLAG_RO && !sb_rdonly(sb))
 		return -EROFS;
 
-	/* We stop if it was running, then restart if it needs to.
-	   This also catches the case where it was stopped and this
-	   is just a remount to restart it.
-	   Flush the writebuffer, if necessary, else we loose it */
+	new_ro = (fc->sb_flags_mask & SB_RDONLY) ?
+		 (fc->sb_flags & SB_RDONLY) : sb_rdonly(sb);
+
+	jffs2_stop_garbage_collect_thread(c);
+
 	if (!sb_rdonly(sb)) {
-		jffs2_stop_garbage_collect_thread(c);
 		mutex_lock(&c->alloc_sem);
 		jffs2_flush_wbuf_pad(c);
 		mutex_unlock(&c->alloc_sem);
 	}
 
-	if (!(fc->sb_flags & SB_RDONLY))
+	if (!new_ro)
 		jffs2_start_garbage_collect_thread(c);
 
 	fc->sb_flags |= SB_NOATIME;
 	return 0;
 }
-
 /* jffs2_new_inode: allocate a new inode and inocache, add it to the hash,
    fill in the raw_inode while you're at it. */
 struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode, struct jffs2_raw_inode *ri)
-- 
2.47.3


