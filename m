Return-Path: <stable+bounces-244334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMoMDRj0+mn/UgMAu9opvQ
	(envelope-from <stable+bounces-244334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 09:56:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF6B4D77A7
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 09:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B799E3018342
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 07:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44A8306B31;
	Wed,  6 May 2026 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls/u1PSN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658903B8948
	for <stable@vger.kernel.org>; Wed,  6 May 2026 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778054161; cv=none; b=eQ+AP78r82gVYod1hge6TCG9mmpVLQyy0QHymQGlmNlUrDbbX65ncjx+p072vyD099xYCZBEWhbc3rRfzGBmnNGnYk65L4qURNNPAT0x54BXSra/mpidFdYRe8lSBNY9emHx/X5NQ+KC88HrGFtv67311EXWEmPAsyaZzclbRF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778054161; c=relaxed/simple;
	bh=Zn/HSxgx9qZwQ5YGcGoKI6Qy28bsewtR+Ggg1f8p6C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1QaQo0NKwN5OldJV+gqUTmqkuwahNuDbcHro0+fv4kvh2mt8UevAzx0Ws33HGpU16PND3xz1wOOLg6rv3XkT5gPFasQ59hmdMm+SyCU+LDaAyhXmbN3GJhtoWAmOlw7HGbGzAd/SCaEUpG74/xu5kSa+zxti5yHg77MuGko8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls/u1PSN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-837b39eb078so2116315b3a.2
        for <stable@vger.kernel.org>; Wed, 06 May 2026 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778054160; x=1778658960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/svLyhDt4LmrmppOf0GneXzDZZYkFPlrB5biDFWZro=;
        b=ls/u1PSN5kuiVWrNRfnXJqZjWLudKqCWMtxljFOjqS6TVsJQhplDKckFseKsUxxIym
         fr9rCb2hx6/EHlRAEiuS+fr/DtnVVnPY8IoUtHXH1d8138W0dptnFA0bxmVcn+s/WVsF
         mn2SICsEpMbAK5m1W4tZbV6IibXaN3ExAJgw/y0B/PPNks33GVWaeiKfAI/FLh66iiVp
         NDbws64rx9PiQsqJKU2y7xaX29lN2Br93r0oxoDOwToBSK3aq7oAr/C72sA+I7RiHTK7
         OSp9cJFPLKY3JLXOaZaxy6qvD1/amx9pc8TrpglEkA9O3LBZ5gdZuBy5rZKA4kPDdoEz
         pTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778054160; x=1778658960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/svLyhDt4LmrmppOf0GneXzDZZYkFPlrB5biDFWZro=;
        b=KHE+2liDyyt5Vu5YioKj2UILtiTP730J8xJIJYR8Sq4ERoWOBm0G3xJvvc2IU/LE3N
         18K389+Mzo+cz5k4Xhv/FrzWF/FvjmneZogJW9cxN2wIvP3xIBtBndXlfIOi4UwVaTN5
         4aDyna8TlBbL675lIoIUe1BSyINtPRW7kgusdnqP2qvf2HiWxi8AoBT9lh3OxF1L/qdh
         fT6k0dYVud4sx98A84tybFZ9jg+R0ywlrMX1bGJxtATt85XdHvzIyhCVM6hl5XzZvfoM
         +rEiczJTEka/qbh8XeS4m7dq2Ui2aXZW9xcOXVHkssFqO3yUPK6tin7fnWxFXBhKLYPI
         BUIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SNCUyatGNeKEnuyx3bidL8ZzhYuXOOjL8ezEwv5OWtMFz8ksaITqIqbMDvfwIuC8QlluixL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg7W6Z6J8Sauz6ZPPk5AhGILzyRfIzljKpvKcTZEu2EYtgQQFT
	L10r2yLCvythBbleqBsvylwMhYHgnqRRugq2GMNXUkwoOreDt3yr3da2
X-Gm-Gg: AeBDievnUT9+0BRqw4FpaSCq3CcdpisLjxk0bzodisLP8h/3h623pIRDDzptzNrYW4b
	ZrmFlEPH7bMVLL12SbbifCKkXnim6mFY87x/oUGKVe+jiCTP2YnefbGtKZVg/ax0RDBWtPfeCHL
	p6Jxoh3TiusPrIhYvwu0H2c8B9L8N7wiCqTFJfpipGd9gZavQgnks+WNt9bxbx36vfLK84BVYat
	hgIutKEC4Mag3lH+PK6ZKzgqDDMf1g51VJu+t3MxVg/OXbIaoeESCfVs5VK2zOpPrbT34OZb/tv
	rUhFog3eLlCu5+NVw/XYmDP9TgzbkDUozQ3hhxsHc1nxoFDxiAchj1FRj7wcJp9zf/s25Q9OkOA
	XaaEeCcrkAWEwCjC+hqLIU0baOiUTtWtt8MibT1R4/8b/q2IzYjwww487BM47rStsFs1quc7Dai
	yAYLWpGeaKBw+3l7MmUc0jT6G++2uvnD80STHpoubR/HsrPR4YJJ9DM9ujfg==
X-Received: by 2002:a05:6a00:10d2:b0:82d:603f:f3a with SMTP id d2e1a72fcca58-83a5df4b0c2mr2178592b3a.24.1778054159720;
        Wed, 06 May 2026 00:55:59 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8c10sm4421502b3a.37.2026.05.06.00.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 00:55:58 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH] fs/ntfs3: fix syncing wrong inode on DIRSYNC cross-directory rename
Date: Wed,  6 May 2026 15:55:54 +0800
Message-ID: <20260506075554.7469-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422152010.205694-1-zhanxusheng@xiaomi.com>
References: <20260422152010.205694-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1DF6B4D77A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-244334-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,xiaomi.com:mid,xiaomi.com:email]

In ntfs3_rename(), when IS_DIRSYNC(new_dir) is true, the code syncs
the renamed file inode instead of the target directory new_dir:
    if (IS_DIRSYNC(new_dir))
        ntfs_sync_inode(inode);      /* should be new_dir */

DIRSYNC requires that directory metadata changes are written to disk
synchronously.  Since new_dir was modified (a new directory entry was
added), it is new_dir that must be synced to satisfy the guarantee,
not the renamed file itself.

This bug has existed since the initial ntfs3 implementation and was
carried through the refactoring in commit 78ab59fee07f
("fs/ntfs3: Rework file operations").

Fix by syncing new_dir instead of inode.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v2:
 - Cc ntfs3@lists.linux.dev (was missing in v1, see
   https://lore.kernel.org/all/20260422152010.205694-1-zhanxusheng@xiaomi.com/).
 - Add Cc: stable@vger.kernel.org; this is a data-persistence bug under
   DIRSYNC and affects all ntfs3 since 4342306f0f0d.
v1: https://lore.kernel.org/all/20260422152010.205694-1-zhanxusheng@xiaomi.com/
---
 fs/ntfs3/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index b2af8f695e60..64cde1a856f4 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -340,7 +340,7 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 			ntfs_sync_inode(dir);
 
 		if (IS_DIRSYNC(new_dir))
-			ntfs_sync_inode(inode);
+			ntfs_sync_inode(new_dir);
 	}
 
 	if (dir_ni != new_dir_ni)
-- 
2.43.0


