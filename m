Return-Path: <stable+bounces-225735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMUgIkvDuGlWjAEAu9opvQ
	(envelope-from <stable+bounces-225735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 03:58:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E052A2FAD
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 03:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFE56303A91C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 02:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9ED2C234A;
	Tue, 17 Mar 2026 02:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JSt0fYRQ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0AB199949;
	Tue, 17 Mar 2026 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716211; cv=none; b=ZQDx1ZCPpdLrPgCB/ViQuXfTK1g+rYrqKnKQvsPp8WS0KgDDP75NqGTyprso7czLRo28VWovxlWRz8X4jMueoPtqJT/6pVCxsOivpFuP8uvB5VhPWlkxN+3VARhIlURhqvzPs9ZXItfrMbvFqFd0cNKQpYZCLRmAuSnHEUGFmXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716211; c=relaxed/simple;
	bh=5idiaM5ya0ZMcmh4ZOciWJkmKYgEJKIeAs3Tkdo/yrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CPhQbCWw/W/6dUY5+J1mXBpKD56HNRHNdwywhpwJ1pcm21NRF27K9mC1BHoEzH32bPYWa0811H9ZDr53mdpXA/hzkek7yhO9rluVzgms2clJrTdBl5baN1O3X3YuSV0tKlhHQtugazi4sWNrcX5t0WqmJ0l0v5cNvgw+/Z30rgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JSt0fYRQ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fl
	keyKELInxzqtQjTpvZ9iQ7lXdYqruNsdCwFkYgqcY=; b=JSt0fYRQKlXAbDM6x6
	Gm4dzWkMV6CHbqnpeNGTgZX/tKxPDjUFLXZ1XHZQfRylBjlz2ZDIUUj2fqJSmwyD
	bo/Vnkyq/q/NZMyectN09bBRkQmVsck8oLfxJRCg7L6zyIXdu3Ld4qK5njycu7l1
	GOPj38a18WwZJ/P+0BBpQtSDQ=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3u1C+wrhphmaaBQ--.42197S2;
	Tue, 17 Mar 2026 10:55:59 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Cc: "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-hardening@vger.kernel.org,
	Robert Garcia <rob_garcia@163.com>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] pstore: inode: Only d_invalidate() is needed
Date: Tue, 17 Mar 2026 10:55:58 +0800
Message-Id: <20260317025558.1666400-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3u1C+wrhphmaaBQ--.42197S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur17CF17trWDWw4kuFy8Krg_yoW8Zw47pr
	nxCw45ArW8Ka4Sgw48XF45Z345uFsYgw45XrZ7Ga1ftrnxKw4FqF43tFnIvFyrJrWruFZY
	qr10kr1YvFyYyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRpVbDUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDAR9o02m4wr9emAAA3P
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225735-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[igalia.com,intel.com,vger.kernel.org,163.com,enomsg.org,android.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linux.org.uk:email]
X-Rspamd-Queue-Id: 17E052A2FAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kees Cook <keescook@chromium.org>

[ Upstream commit a43e0fc5e9134a46515de2f2f8d4100b74e50de3 ]

Unloading a modular pstore backend with records in pstorefs would
trigger the dput() double-drop warning:

  WARNING: CPU: 0 PID: 2569 at fs/dcache.c:762 dput.part.0+0x3f3/0x410

Using the combo of d_drop()/dput() (as mentioned in
Documentation/filesystems/vfs.rst) isn't the right approach here, and
leads to the reference counting problem seen above. Use d_invalidate()
and update the code to not bother checking for error codes that can
never happen.

Suggested-by: Alexander Viro <viro@zeniv.linux.org.uk>
Fixes: 609e28bb139e ("pstore: Remove filesystem records when backend is unregistered")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-hardening@vger.kernel.org
[ Minor context change fixed. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 fs/pstore/inode.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 14658b009f1b..f56e0b105be7 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -312,7 +312,6 @@ int pstore_put_backend_records(struct pstore_info *psi)
 {
 	struct pstore_private *pos, *tmp;
 	struct dentry *root;
-	int rc = 0;
 
 	root = psinfo_lock_root();
 	if (!root)
@@ -322,11 +321,8 @@ int pstore_put_backend_records(struct pstore_info *psi)
 	list_for_each_entry_safe(pos, tmp, &records_list, list) {
 		if (pos->record->psi == psi) {
 			list_del_init(&pos->list);
-			rc = simple_unlink(d_inode(root), pos->dentry);
-			if (WARN_ON(rc))
-				break;
-			d_drop(pos->dentry);
-			dput(pos->dentry);
+			d_invalidate(pos->dentry);
+			simple_unlink(d_inode(root), pos->dentry);
 			pos->dentry = NULL;
 		}
 	}
@@ -334,7 +330,7 @@ int pstore_put_backend_records(struct pstore_info *psi)
 
 	inode_unlock(d_inode(root));
 
-	return rc;
+	return 0;
 }
 
 /*
-- 
2.34.1


