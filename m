Return-Path: <stable+bounces-238255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMl4GBR84GnlhgAAu9opvQ
	(envelope-from <stable+bounces-238255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:05:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AC740A8DF
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ED8F302B744
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 06:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02443218BA;
	Thu, 16 Apr 2026 06:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E8xBb1Nt"
X-Original-To: stable@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038681BD9C9;
	Thu, 16 Apr 2026 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776319397; cv=none; b=rJLSNEF/8p9VfhyvlMOHtgqmXG84lJ8AbIQAsqEWU5PSnxdeLANKuXZR0ZTU95/1zaOZB90HSAEsCt6g5xvnYf06/0RLzb6sd/bEaFAuEePbZdgOGg+dc5LfFU5CesMdIQL9AvERtvp8nsmEOQpgyJ67OErPSpwMGMOg91/AQQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776319397; c=relaxed/simple;
	bh=jzW/IRXsD0pARdFJ7w3GkHpIKhal7AiE+1QIw2RRcTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+PDHiRCgvNCBy/Q5hv4PoRs1VwmEZY6RUZgDJFjAPuFmXO0Mpq5TRRABAjEm/hOlFpOGSA4vCUwO8Haj6i7cc7ofFVcpjVkgtKrz1H4FWDyMs9SmywdKlVPlOQkZdVScXDKlhTfW+Dsgv77lmzImw/Ek8fyF8ZrOvv1rUOeABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E8xBb1Nt; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776319390; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZomflwDXNwqG6gSK6tClB89Uhm5LpUQnhTnVd8IiJTo=;
	b=E8xBb1NttxcwuBBLXU510O/o0tnoS64v1WLaneTJE3cXe1jrCVB3+CXk9UxWDbIAhAgz012yVY2Ky/xGUcRXH/zAmdti0cjhR805NwjZ5NAP8PcrYZJwrzNymYnhtb1XoWxKSTylDsdFwMQJbI3JxnwdJpiL4EQCNR0YfnqRWzI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X17IOFV_1776319385;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X17IOFV_1776319385 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Apr 2026 14:03:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH] erofs: fix the out-of-bounds nameoff handling for trailing dirents
Date: Thu, 16 Apr 2026 14:03:05 +0800
Message-ID: <20260416060305.3129334-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	TAGGED_FROM(0.00)[bounces-238255-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.alibaba.com,gmail.com,outlook.com];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: A6AC740A8DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently we already have boundary-checks for nameoffs, but the trailing
dirents are special since the namelens are calculated with strnlen()
with unchecked nameoffs.

If a crafted EROFS has a trailing dirent with nameoff >= maxsize,
maxsize - nameoff can underflow, causing strnlen() to read past the
directory block.

Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
Fixes: 33bac912840f ("staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Closes: https://lore.kernel.org/r/A0FD7E0F-7558-49B0-8BC8-EB1ECDB2479A@outlook.com
Cc: stable@vger.kernel.org
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/dir.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index e5132575b9d3..ecfac9b49322 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -19,20 +19,18 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 		const char *de_name = (char *)dentry_blk + nameoff;
 		unsigned int de_namelen;
 
-		/* the last dirent in the block? */
-		if (de + 1 >= end)
-			de_namelen = strnlen(de_name, maxsize - nameoff);
-		else
+		/* non-trailing dirent in the directory block? */
+		if (de + 1 < end)
 			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+		else if (maxsize <= nameoff)
+			goto err_bogus;
+		else
+			de_namelen = strnlen(de_name, maxsize - nameoff);
 
-		/* a corrupted entry is found */
-		if (nameoff + de_namelen > maxsize ||
-		    de_namelen > EROFS_NAME_LEN) {
-			erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
-				  EROFS_I(dir)->nid);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
+		/* a corrupted entry is found (including negative namelen) */
+		if (!clamp_t(unsigned int, de_namelen, 1, EROFS_NAME_LEN) ||
+		    nameoff + de_namelen > maxsize)
+			goto err_bogus;
 
 		if (!dir_emit(ctx, de_name, de_namelen,
 			      erofs_nid_to_ino64(EROFS_SB(dir->i_sb),
@@ -42,6 +40,10 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 		ctx->pos += sizeof(struct erofs_dirent);
 	}
 	return 0;
+err_bogus:
+	erofs_err(dir->i_sb, "bogus dirent @ nid %llu", EROFS_I(dir)->nid);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
 }
 
 static int erofs_readdir(struct file *f, struct dir_context *ctx)
-- 
2.43.5


