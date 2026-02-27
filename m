Return-Path: <stable+bounces-219901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFMlKVEQoWlDqAQAu9opvQ
	(envelope-from <stable+bounces-219901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:32:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EFE1B246E
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 091CC30B9916
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 03:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4631355F;
	Fri, 27 Feb 2026 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="acEUbhRb"
X-Original-To: stable@vger.kernel.org
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAC62F1FCA
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163036; cv=none; b=uheKaj+ZLBXhAx+wLaMgd1UWWF6uLrpF9szduK+48xOQ+NOQO1yMUMUg0/3Uivt/kRgcqIPQEnKxQvn7Bzhfo2nZQujU6tNaVocZNrLtlh1R08qVaHIhctGqJvpBdhurrXMx8aPpwmjzoAOLYu6YRCr+/uYY5du5jOu18VaUot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163036; c=relaxed/simple;
	bh=lYU3ZWPhKbMwhmgrteQr6W9c6Fg1JPTM61yX3B8R/zs=;
	h=From:To:Subject:Date:Message-Id; b=oqX7pHuN5HGTXK+eTRJN6y7x4IT8jAeGTljVaWCslU68pGefHl1GepZOMpmOTyls91XHrQN9WVhLO1JMAi0hX0HauZhRg5BP5cYkYYQ1L3d0EuzR/dDkJYHbXaaKWATDcqWuT404a0koRny88ZSy1yzIYim7oFXVYKebqIFN3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=acEUbhRb; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1772163030;
	bh=vVvpmf6xdd88ZX2h9Vg8vyUW1gpWppGn1R5iKhALtc0=;
	h=From:Subject:Date:Message-Id;
	b=acEUbhRbPieImFAJggCvNWJ76uNMz0ttAFHYT92FLUd35Wvnjs7OaJAgPjebUUc7s
	 0L8PiAHmYp+Ey0yYc44ZxWQVMW6QvF1Swz/AbHx/3Jm9zBWyZ2PJ7xlQeKfIg1zb0G
	 5Upbx1BvDvIw/DdgxJ7tD9p1dEfMMtmwyhf3lpy8=
X-SMAIL-HELO: sina-kernel-team
Received: from unknown (HELO sina-kernel-team)([117.129.7.78])
	by sina.cn (10.54.253.32) with ESMTP
	id 69A10FCB000042E8; Fri, 27 Feb 2026 11:30:21 +0800 (CST)
X-Sender: xnguchen@sina.cn
X-Auth-ID: xnguchen@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=xnguchen@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=xnguchen@sina.cn
X-SMAIL-MID: 7251174456887
X-SMAIL-UIID: 7BEF11208067499384233B296955F96C-20260227-113021-1
From: Chen Yu <xnguchen@sina.cn>
To: hch@lst.de,
	dchinner@redhat.com,
	djwong@kernel.org,
	brauner@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] iomap: allocate s_dio_done_wq for async reads as well
Date: Fri, 27 Feb 2026 11:30:18 +0800
Message-Id: <20260227033018.2506-1-xnguchen@sina.cn>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sina.cn:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[sina.cn];
	TAGGED_FROM(0.00)[bounces-219901-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xnguchen@sina.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sina.cn:mid,sina.cn:dkim,sina.cn:email,appspotmail.com:email,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: A7EFE1B246E
X-Rspamd-Action: no action

From: Christoph Hellwig <hch@lst.de>

commit 7fd8720dff2d9c70cf5a1a13b7513af01952ec02 upstream.

Since commit 222f2c7c6d14 ("iomap: always run error completions in user
context"), read error completions are deferred to s_dio_done_wq.  This
means the workqueue also needs to be allocated for async reads.

Fixes: 222f2c7c6d14 ("iomap: always run error completions in user context")
Reported-by: syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20251124140013.902853-1-hch@lst.de
Tested-by: syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Chen Yu <xnguchen@sina.cn>
---
 fs/iomap/direct-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8158ab18e1ae..6dfdd52060ba 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -655,12 +655,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			}
 			goto out_free_dio;
 		}
+	}
 
-		if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {
-			ret = sb_init_dio_done_wq(inode->i_sb);
-			if (ret < 0)
-				goto out_free_dio;
-		}
+	if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {
+		ret = sb_init_dio_done_wq(inode->i_sb);
+		if (ret < 0)
+			goto out_free_dio;
 	}
 
 	inode_dio_begin(inode);
-- 
2.17.1


