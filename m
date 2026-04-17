Return-Path: <stable+bounces-238512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI/KFxiD4mlW6wAAu9opvQ
	(envelope-from <stable+bounces-238512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 20:59:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F092941E1B0
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 20:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11D5B3018625
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 18:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52BE3C9EF8;
	Fri, 17 Apr 2026 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b65z4OkG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFB5314A77
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776452364; cv=none; b=ju3HsegC7fuW6HguyTPFrP0hbCIPO7TSwDT258Xg3izvCl8I6+OlwL++YmUuFahMdLdmaM1fymjaNFKTc2MDt7nwwQLYbaDs03u3akYdj1XopyUt4THolxMne4w63qkEWtPEIxgNbxAwOWPSYvsIO3WmUNtT7buCalaN1GC1ZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776452364; c=relaxed/simple;
	bh=5Y0n6CZoHP4DcntwMAYBkIPzcR5/+vcjyEFl4iue5i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtZOucKQ2nWcZa3ChE5FqEjBypCMCZUeXJ7PF1VAGjvzup7pJhXgbLvogyt9AHWr1kXkRhPypheaoyex8Rc7bMzCyAsftW+Yi1o5oJ1AFRsnFz3V64VYQT5NNa+KDlkXCE7WsZwttA5u32OhQyADep3UDPx/bhESQN7FOV6hkI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b65z4OkG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so7250055e9.1
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776452362; x=1777057162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eiaP9ibW1qoN3pZwr4QXm4whiKQGYd/qsAGcYb+48R8=;
        b=b65z4OkGPH4n6j841yr9PWuDgkXWFwKyZHUMgkJ80Sg5wY/Jo2fr297icQmohC3OoX
         9htCNh+aaOdiiVqhIw1ajXL1KDXkjDdUAwcipNeoHrGu1QE1LnbzS/fGsHcjoXTUmJrN
         vpkctgTS7aXGzPTBt4BE2lfG+k0aZoBCy85Pn5XWgCJJNYmUH9G630iUhrJQA2BaV/1u
         2HMkAdY1zyGqZSYrLsJYFr86OqKN8RxpzJ3vo4MHLGQ45fStGXXd7RpNh2b93N03ekQG
         xtutufZ4ic93lMnMCj2gXjrUIQUdkZXB9ZLbCQPk63gvNWVDu8+Bxo1vjkKpWRmgGiFr
         P3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776452362; x=1777057162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiaP9ibW1qoN3pZwr4QXm4whiKQGYd/qsAGcYb+48R8=;
        b=BvqjEHBbGyJ8XW07mkM6vdZ2OVMgYVHJOjG5dZgetVRAvk3xhzHOUoQmdVPzHiQSsi
         WgTp40BDf3nHizC4kLRwTodZLvjudsvVToctHoyevNGbiUOhHGfUeir1C91fvS1m5aUg
         ScTSu+SWy1K1iyOwT/UXVP0vrnwcrG/WfEyGWfwHKvsF9+tW2jqmFo3PpoW0Xa9fMvlv
         qbFXsBdVnD1dkUn2D/wcGmi1Z8GuBFzUxniHDGyWeT440k84Y1H6tVPJ/u2NwicrhmFg
         e39JD5mOzWBV1yjhyIwqhORPynDcscN+9OGwOdQh93B6NkK4WhMRL49fMu7ytdP/lHqG
         DAzw==
X-Forwarded-Encrypted: i=1; AFNElJ+0Bx1hE0bGDPkAuj7PZNYffGjBXPXBJwZaF/BtyjAedrhBV+a3jNjBq8ll2vhavCuJOnqK14Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdYvw21E/mx0Yl8k1pBGeKRNT3l7DBc7SIgl2+YX+2oLF9nxHg
	O+Kh1kvLx5j2fK9MjDYRcqy/UhVVvPGfYHEXucYG68XXsd5kd3rbSuc=
X-Gm-Gg: AeBDieviZd+7qrJMWJrPEHoZabngHbsduK36QRlXClxDcLESnWDWVokNjPbm10GlrXc
	l556piF7j8AKmJ5NAMm8eQvs1eYNY4GV3433WBgYfHxoD9b2iYTfCAAXVM7CuSQyJZhmEto5btr
	fQwRVVukYAkwn8ZSj6VUUukWN5ci5A47XYUYp0K9BM5I5/pixPTIZkUIOV6hUo3/fypBPm64MFo
	z06MqNyszo5tTGjM8VWz8zLkNraqo51B37r67oMKZgIw42Zwi1lUKyt/FnvO/4Zz/EtH59jqvvC
	HiNu1CF7/kUQry4gajc2CWrXWLwgdOGzUQnjqWF4YRygdfrHJOwYCJyNCvLMRW+CnQYF7dKe/Y9
	nP0T5zX03zPduOnL7aQ4DIcgw1su7InHlHnekjF0Ao5/9qlhZc7E2mgblv4kfRQ281GDo7a0YWS
	4KDuS5MXC5hAddL6gZ
X-Received: by 2002:a05:600c:c0c8:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-488fb787ba3mr47388625e9.27.1776452361489;
        Fri, 17 Apr 2026 11:59:21 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb75c695sm22806255e9.14.2026.04.17.11.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 11:59:20 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] hfs: return error when bnode already hashed in hfs_bnode_create
Date: Fri, 17 Apr 2026 18:59:19 +0000
Message-ID: <20260417185920.182595-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238512-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,a19ca73b21fe8bc69101];
	NEURAL_HAM(-0.00)[-0.940];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,talencesecurity.com:mid,talencesecurity.com:email]
X-Rspamd-Queue-Id: F092941E1B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hfs_bnode_create() checks if the requested node number is already
present in the B-tree hash table.  If it is, the function emits a
WARN_ON(1) and returns the existing node:

    if (node) {
        pr_crit("new node %u already hashed?\n", num);
        WARN_ON(1);
        return node;
    }

On crafted HFS images with inconsistent B-tree bitmap data, the
allocator can repeatedly request creation of node 0 which is
already hashed, triggering this WARNING reliably on every mkdir.

Replace the WARN_ON with an error return.  The node being already
hashed when creation is requested indicates filesystem corruption
-- returning ERR_PTR(-EIO) allows the caller to handle this
gracefully rather than generating a kernel stack trace.

Reported-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
Tested-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfs/bnode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index e8cd1a31f247..69895ccf81ef 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -517,8 +517,7 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *tree, u32 num)
 	spin_unlock(&tree->hash_lock);
 	if (node) {
 		pr_crit("new node %u already hashed?\n", num);
-		WARN_ON(1);
-		return node;
+		return ERR_PTR(-EIO);
 	}
 	node = __hfs_bnode_create(tree, num);
 	if (!node)
-- 
2.47.3


