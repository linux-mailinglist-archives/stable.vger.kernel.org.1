Return-Path: <stable+bounces-240618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEdBN68762mOKAAAu9opvQ
	(envelope-from <stable+bounces-240618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:45:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E666245C6C5
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 037553001FB4
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1FA2ED872;
	Fri, 24 Apr 2026 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LxCkW6qy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9812DECDE
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023913; cv=none; b=JTFYFvb4VZMKOj/eY4+PbKlL7oW9HPCVM5LDKQeIbODNBHpRW88vV2jI0QngYh2orsyy7hYlPicfd/eNnEw7FFPGH9+K7T7QJycDuSJvjBhMXAIz3Ti4q/2ZMhVx0tFVIgOiJjgi0XJpu4iCg6cuixjfghoWuXQ8MHVsWiETK1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023913; c=relaxed/simple;
	bh=/09cbFYYFFZsSPn59djOsyND2/i4LvW5O5kqOHeOirs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jmwjUgsooZZsryeXT+1eqDQxXjRT11q9hmlMJtP84KOTiiu0GV3pVKX+bd/YC+rc5JWRDrvdfSFHeZ2BgEEMQNkRTy7goP+iNsg9FnAgBFob3BG6N96kC6meQ5WRya8u+r3OtlaW5Y/q2WF4Wx8x2tI/oqeEpnz7NQ0LumVjvwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LxCkW6qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36D1C19425;
	Fri, 24 Apr 2026 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777023913;
	bh=/09cbFYYFFZsSPn59djOsyND2/i4LvW5O5kqOHeOirs=;
	h=Subject:To:Cc:From:Date:From;
	b=LxCkW6qyi91M2aayW8nT2w2HUyj/XwM/Pbz6Lds406xoFuLgHq7xexLpSDhvw2uHP
	 93eXs7WmWa5sDsx9e22429hGjOWmNwqlFlyJi9u679neN87KUQpK3Fl/7fPDrdN1iW
	 u+y+az4xAPsaigkIS7EJ1tCkP4KXcqBeiNXUvXbY=
Subject: FAILED: patch "[PATCH] f2fs: fix use-after-free of sbi in" failed to apply to 5.10-stable tree
To: geoo115@gmail.com,chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Apr 2026 11:45:02 +0200
Message-ID: <2026042402-grievance-choosy-4ff8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E666245C6C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240618-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 39d4ee19c1e7d753dd655aebee632271b171f43a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042402-grievance-choosy-4ff8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 39d4ee19c1e7d753dd655aebee632271b171f43a Mon Sep 17 00:00:00 2001
From: George Saad <geoo115@gmail.com>
Date: Mon, 23 Mar 2026 11:21:23 +0000
Subject: [PATCH] f2fs: fix use-after-free of sbi in
 f2fs_compress_write_end_io()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In f2fs_compress_write_end_io(), dec_page_count(sbi, type) can bring
the F2FS_WB_CP_DATA counter to zero, unblocking
f2fs_wait_on_all_pages() in f2fs_put_super() on a concurrent unmount
CPU. The unmount path then proceeds to call
f2fs_destroy_page_array_cache(sbi), which destroys
sbi->page_array_slab via kmem_cache_destroy(), and eventually
kfree(sbi). Meanwhile, the bio completion callback is still executing:
when it reaches page_array_free(sbi, ...), it dereferences
sbi->page_array_slab — a destroyed slab cache — to call
kmem_cache_free(), causing a use-after-free.

This is the same class of bug as CVE-2026-23234 (which fixed the
equivalent race in f2fs_write_end_io() in data.c), but in the
compressed writeback completion path that was not covered by that fix.

Fix this by moving dec_page_count() to after page_array_free(), so
that all sbi accesses complete before the counter decrement that can
unblock unmount. For non-last folios (where atomic_dec_return on
cic->pending_pages is nonzero), dec_page_count is called immediately
before returning — page_array_free is not reached on this path, so
there is no post-decrement sbi access. For the last folio,
page_array_free runs while the F2FS_WB_CP_DATA counter is still
nonzero (this folio has not yet decremented it), keeping sbi alive,
and dec_page_count runs as the final operation.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Cc: stable@vger.kernel.org
Signed-off-by: George Saad <geoo115@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 8c76400ba631..aa8ba4cdfe34 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1491,10 +1491,10 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 
 	f2fs_compress_free_page(page);
 
-	dec_page_count(sbi, type);
-
-	if (atomic_dec_return(&cic->pending_pages))
+	if (atomic_dec_return(&cic->pending_pages)) {
+		dec_page_count(sbi, type);
 		return;
+	}
 
 	for (i = 0; i < cic->nr_rpages; i++) {
 		WARN_ON(!cic->rpages[i]);
@@ -1504,6 +1504,14 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 
 	page_array_free(sbi, cic->rpages, cic->nr_rpages);
 	kmem_cache_free(cic_entry_slab, cic);
+
+	/*
+	 * Make sure dec_page_count() is the last access to sbi.
+	 * Once it drops the F2FS_WB_CP_DATA counter to zero, the
+	 * unmount thread can proceed to destroy sbi and
+	 * sbi->page_array_slab.
+	 */
+	dec_page_count(sbi, type);
 }
 
 static int f2fs_write_raw_pages(struct compress_ctx *cc,


