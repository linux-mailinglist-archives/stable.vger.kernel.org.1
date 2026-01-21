Return-Path: <stable+bounces-210869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMOrBmo2cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-210869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:26:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC6F5D2CF
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05A8776A3B6
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E10927703C;
	Wed, 21 Jan 2026 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0SHUVdld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F7734C83D;
	Wed, 21 Jan 2026 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019660; cv=none; b=lUzYRKp2yH/nd4GZQexkB2I859PTQidj4/iJ9mDUIc7D+moE8+VyieTeHojdFW8oFn3a7qTOMU6ZZEshGdGUlQ7HEHlA8jFTnjSrczpAJmARPZB2YJlvdqUQxv5Sgu8flenBqVtmj2XnhgdULFzTHQJjTgmQ6YXS8E6LvwtVhsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019660; c=relaxed/simple;
	bh=UkIAgxgeldAc1zRfHX7RJZcBDh3fvhVj35fUtn41j4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MS0ix2kAaLH2T6sOBdBckns8Jr1Wm/oHCm84TCViMeLQ+xhIWtexYwfpwOs64cbOSfkFvnkIO7gVBKTFP/7Z9Su/9zd67HYzMMvYlEBd7jkfKy+rNgFJ4UqaJQDy3xjfyUR5JIKN2OLDq4HnJ2kcKWNmn/mmXe9XoJJ+kQsftVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0SHUVdld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0E4C4CEF1;
	Wed, 21 Jan 2026 18:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019660;
	bh=UkIAgxgeldAc1zRfHX7RJZcBDh3fvhVj35fUtn41j4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0SHUVdldfD25ysi61ZTwe3zo6Coq8wtSgoluK77MMC1QHSiD7amtFfsB6k0bsgdpJ
	 8Nv8zj/MMDLKD/zINvueSl7ub/COejeW0Wq9P0oDNu2GIMEZ+sNtNXPY01fZGFjNKF
	 0ER3Ztom3+x0pkLUctOeRagIOB47Rk0Bzn7GFXcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Christoph Hellwig <hch@lst.de>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkman <daniel@iogearbox.net>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 071/139] lib/buildid: use __kernel_read() for sleepable context
Date: Wed, 21 Jan 2026 19:15:19 +0100
Message-ID: <20260121181414.010479567@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-210869-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,linux.dev,lst.de,gmail.com,kernel.org,iogearbox.net,infradead.org,linux-foundation.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,09b7d050e4806540153d];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9FC6F5D2CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shakeel Butt <shakeel.butt@linux.dev>

commit 777a8560fd29738350c5094d4166fe5499452409 upstream.

Prevent a "BUG: unable to handle kernel NULL pointer dereference in
filemap_read_folio".

For the sleepable context, convert freader to use __kernel_read() instead
of direct page cache access via read_cache_folio().  This simplifies the
faultable code path by using the standard kernel file reading interface
which handles all the complexity of reading file data.

At the moment we are not changing the code for non-sleepable context which
uses filemap_get_folio() and only succeeds if the target folios are
already in memory and up-to-date.  The reason is to keep the patch simple
and easier to backport to stable kernels.

Syzbot repro does not crash the kernel anymore and the selftests run
successfully.

In the follow up we will make __kernel_read() with IOCB_NOWAIT work for
non-sleepable contexts.  In addition, I would like to replace the
secretmem check with a more generic approach and will add fstest for the
buildid code.

Link: https://lkml.kernel.org/r/20251222205859.3968077-1-shakeel.butt@linux.dev
Fixes: ad41251c290d ("lib/buildid: implement sleepable build_id_parse() API")
Reported-by: syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=09b7d050e4806540153d
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Jinchao Wang <wangjinchao600@gmail.com>
  Link: https://lkml.kernel.org/r/aUteBPWPYzVWIZFH@ndev
Reviewed-by: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkman <daniel@iogearbox.net>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/buildid.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/fs.h>
 #include <linux/secretmem.h>
 
 #define BUILD_ID 3
@@ -65,20 +66,9 @@ static int freader_get_folio(struct frea
 
 	freader_put_folio(r);
 
-	/* reject secretmem folios created with memfd_secret() */
-	if (secretmem_mapping(r->file->f_mapping))
-		return -EFAULT;
-
+	/* only use page cache lookup - fail if not already cached */
 	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
 
-	/* if sleeping is allowed, wait for the page, if necessary */
-	if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r->folio))) {
-		filemap_invalidate_lock_shared(r->file->f_mapping);
-		r->folio = read_cache_folio(r->file->f_mapping, file_off >> PAGE_SHIFT,
-					    NULL, r->file);
-		filemap_invalidate_unlock_shared(r->file->f_mapping);
-	}
-
 	if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
 		if (!IS_ERR(r->folio))
 			folio_put(r->folio);
@@ -116,6 +106,24 @@ static const void *freader_fetch(struct
 		return r->data + file_off;
 	}
 
+	/* reject secretmem folios created with memfd_secret() */
+	if (secretmem_mapping(r->file->f_mapping)) {
+		r->err = -EFAULT;
+		return NULL;
+	}
+
+	/* use __kernel_read() for sleepable context */
+	if (r->may_fault) {
+		ssize_t ret;
+
+		ret = __kernel_read(r->file, r->buf, sz, &file_off);
+		if (ret != sz) {
+			r->err = (ret < 0) ? ret : -EIO;
+			return NULL;
+		}
+		return r->buf;
+	}
+
 	/* fetch or reuse folio for given file offset */
 	r->err = freader_get_folio(r, file_off);
 	if (r->err)



