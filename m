Return-Path: <stable+bounces-242293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ppKbFVqI9GnFCAIAu9opvQ
	(envelope-from <stable+bounces-242293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:02:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2894ABD6E
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1161300D4FE
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D6739B482;
	Fri,  1 May 2026 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brCv+gyu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386439B488
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633344; cv=none; b=H2/7RhALfwFGqKc1Mni7Qf77KH1s7FTyKs8+uN3NYPZH5ZqbmfPsgjnfS+0ZNvSdZrKVT7lTsPejbvoPVK5KqhQ3VFHMiEltHsydWeXK8BEFIxdbFRh++2vHB4LWCPYXLpxljUO6Udsh1sA/YuUnireO7ryCXHVQDiaOFXK7WPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633344; c=relaxed/simple;
	bh=Fv/OiQ1bnW0J2vPNKf91L9Akl/sJBzQMgAnEhO7UEdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8VkQaLLZO1sQRAdRN3TDXWlaz4qfIBdqiCK5to5chkZnq+Sxic/KUwbFu6H5L65nq1uOzvSCmIGNOp+HEhr6JBYuiSnupdEOjxhkzJ4tddECnwN99mw38nP75kQTlgi0+2XpT8QhmLif9aV4vUgCMqOhs5iAPjHiRUrlDCkjkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brCv+gyu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483487335c2so19849175e9.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633341; x=1778238141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkx0SbVcB+vrfiwO5OKv0Vwto/EW891UcGdT1uFJmtM=;
        b=brCv+gyu/kz7RnEGt9CPjcygTi8NWhRI7vx0LiI1NV2yJNCK5bVpJ4w9ETQOsqx9d6
         NRJyqTleU2KAaZYA9ADkdVeluRo+xPeOdq542fsGfEGjgv66KVP7bbyMDPGOg68Rq9uH
         0oklUMCIB92qPGnNQfSZzqsHCFlu9nAF9XI85IkUN0IVRY7945dpa6nwdBIglOFLTy5V
         eHkZfOS9uLIPg9ePQ7veChjPoZc0F7XknhKJj5BNxABcX3kPiGcoRYfgRqxE9seiy10r
         R08yudyw0uDeYN9kopOoV+j/8McPjUKhC+Q8D0goAqzDqWlecGSfSD2ACpQGfhoj39Op
         tO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633341; x=1778238141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xkx0SbVcB+vrfiwO5OKv0Vwto/EW891UcGdT1uFJmtM=;
        b=TaxGMdi+lswwTYlX3A3EY9z3ygZxyYPEw/hdVCHVGPROYRu13IUlnu0Fvi6HcVGlww
         ITAEVZ0NKk5eRRW7KMOxBkoHy6uyg6F8HPIV3KZXulJoja+YVOps3jazXLRdExPvHA7c
         5xm3XyAaTLahn7B++4/DM1YPaLgFA9QKHTzjZTTHCNfkAsV4AjagBVWg0sOYNjuoupHa
         UVTSIQZmOqPU4i0b6hlNNT96EHB2IcVvCJF6nYsnBmvGTO2YPuLhRqEE8I924MCTJq5V
         XxF28blxE4wtrVLV0wBm/SUFSdXa1Tk1Ioxl+YJI1olyTo/5UKZn4ScQnCPDKz6uahsO
         s8pw==
X-Forwarded-Encrypted: i=1; AFNElJ/loii6e8FxpWy08GaZw1G4CczFI57LtMOpAelyOEjHwR6R3S0Y+GhHV5Ibr9JCFvPPAc9ixYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+cMCmKJ6JAFf8pqTJaXuJynCIPoN+3LaD0o4opR7L3SgZOdT
	0E/t3J4SSPjPtVzuy+dhuUHEAWGcAKQXAWByZF40DjSItrAJPwD+FQk=
X-Gm-Gg: AeBDietll/8UmVA5rTo5GmVjX1XQ/MZ5+VbS6NunAEkdIEdMVtYLFkbqyWyhyIL/dGM
	PC2kfWh0+EkkbWrKDdpKFJzc5m+ZFvj3XquHwvk7/8GipvKC1//0PJMeWXGvwNFY3MtlIcX/n2C
	d7tg/i5Gm92lYXnRGvvI8mHWqyMmKLiR1tlY8UHaCizaBBK00i65S7WjrFIkatxunr+pjzsg3tg
	/8bCC90g38in6hpHejkErkEIWQxKV/uCYuL6ovRm+a9H06fQQDkJ7sNDI+cawfrf5VIlOn89j0W
	taCEk+tpwYcZNEcJ9pLDKGpFB3A5gFeSeem1hUHRNkbsuTlvOLmUyDdwiUT2Hat54wQjWfm+HwS
	WUxlPJLziSig6SI7Xx0LzeRt9kfetkIXTQ8u7W4z7pvqOEe6Z+bPYXfNvXZn/t/wg3SGqiAWvrv
	YogqM=
X-Received: by 2002:a05:600c:c10b:b0:48a:5821:5ff2 with SMTP id 5b1f17b1804b1-48a844eba7fmr87053555e9.8.1777633340787;
        Fri, 01 May 2026 04:02:20 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c8556sm121627405e9.4.2026.05.01.04.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:02:20 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
Subject: [PATCH 3/3] hfsplus: fix null pointer dereference in hfsplus_create_attributes_file
Date: Fri,  1 May 2026 11:02:17 +0000
Message-ID: <20260501110218.29906-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501110218.29906-1-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8A2894ABD6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242293-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,bc70a12e438dadba4fb4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]

From: Tristan Madani <tristan@talencesecurity.com>

hfsplus_create_attributes_file() calls hfsplus_mark_inode_dirty() with
HFSPLUS_ATTR_TREE_I(sb) before sbi->attr_tree has been set by
hfs_btree_open().  HFSPLUS_ATTR_TREE_I dereferences sbi->attr_tree to
reach ->inode, causing a null pointer dereference when attr_tree is
still NULL.

Move the mark_dirty call to after hfs_btree_open() and guard it with a
NULL check on sbi->attr_tree.

Reported-by: syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bc70a12e438dadba4fb4
Tested-by: syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
Fixes: ee8422d00b7c ("hfsplus: fix potential Allocation File corruption after fsync")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfsplus/xattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 452a1f9becb2d..1ea9f313368c5 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -317,12 +317,13 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 		next_node++;
 	}
 
-	hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY);
 	hfsplus_mark_inode_dirty(attr_file, HFSPLUS_I_ATTR_DIRTY);
 
 	sbi->attr_tree = hfs_btree_open(sb, HFSPLUS_ATTR_CNID);
 	if (!sbi->attr_tree)
 		pr_err("failed to load attributes file\n");
+	else
+		hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY);
 
 failed_header_node_init:
 	kfree(buf);
-- 
2.47.3


