Return-Path: <stable+bounces-256143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM4mG6qrGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:55:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B7A5F9D9A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0AEE3104D3B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE97433A9FC;
	Thu, 28 May 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fwatUmLD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C52332909;
	Thu, 28 May 2026 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000876; cv=none; b=gK1n+/oXgbbU/52d1SC1SxV0DKyxI3ccGwaqR7/LXjaZ0KjCu0N+aEVDnftS0g/D7TkcGrYvX5qNmyHnrFdCd/oqVQFIK9ipAsVHzZsHpnf1yAJb/Ik79Xe+d0i6wbadTaKQOAMX12R4Brf3cfq0qTKmtW7eCog21H1ZxXlRPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000876; c=relaxed/simple;
	bh=ZRZTWHzomEwl/2EvcKEXN7lCbI6L9aOXVPW3tcGzWm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2sneMNrpe72Jr1dsOEZTalUTruPSPscGXMz7R2fuh39atNsRSMB92YnrwHWHdYECgyinLATE7M6IMUMRk7cPx8/f/hEwOIEsOxHfSrb6VLrYOzk+KZQiyVSV6M6fxwJnucEIVt1PBRHO4B6aBMnwcNCsAC3Q67c7QE9NxfCYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fwatUmLD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063CD1F000E9;
	Thu, 28 May 2026 20:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000875;
	bh=MjMGqdY+58GBToAbyxT1ZaU9ii8aI40E2S8naCHAA+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fwatUmLD3g3KrulyXQCX/Wh8rr0qeOpy/cyQgwZlkwwBl5NYrvxBeWpLSw27oHYR0
	 6L/29tQ9ZQTyD64MpuSLUGdZD/xbKTjnbFfnWadH80cd+HAsC3V9VNtfimcjHLRnVs
	 lGmrPV9LU/BXNEcMUWiJVeygdCmw3cIFhchFjuMM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 199/272] netfs: Fix a few minor bugs in netfs_page_mkwrite()
Date: Thu, 28 May 2026 21:49:33 +0200
Message-ID: <20260528194634.827592081@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256143-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 78B7A5F9D9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

[ Upstream commit c6a90fe7f080d71271b723490454cfda1f81e4b0 ]

We can't return with VM_FAULT_SIGBUS | VM_FAULT_LOCKED; the core
code will not unlock the folio in this instance.  Introduce a new
"unlock" error exit to handle this case.  Use it to handle
the "folio is truncated" check, and change the "writeback interrupted
by a fatal signal" to do a NOPAGE exit instead of letting the core
code install the folio currently under writeback before killing the
process.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20241005182307.3190401-3-willy@infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: ccde2ac757c7 ("netfs: Fix folio->private handling in netfs_perform_write()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/buffered_write.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 08da4c2512f52..a02bd071cee77 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -513,7 +513,9 @@ EXPORT_SYMBOL(netfs_file_write_iter);
 
 /*
  * Notification that a previously read-only page is about to become writable.
- * Note that the caller indicates a single page of a multipage folio.
+ * The caller indicates the precise page that needs to be written to, but
+ * we only track group on a per-folio basis, so we block more often than
+ * we might otherwise.
  */
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group)
 {
@@ -523,7 +525,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = file_inode(file);
 	struct netfs_inode *ictx = netfs_inode(inode);
-	vm_fault_t ret = VM_FAULT_RETRY;
+	vm_fault_t ret = VM_FAULT_NOPAGE;
 	int err;
 
 	_enter("%lx", folio->index);
@@ -532,21 +534,15 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 
 	if (folio_lock_killable(folio) < 0)
 		goto out;
-	if (folio->mapping != mapping) {
-		folio_unlock(folio);
-		ret = VM_FAULT_NOPAGE;
-		goto out;
-	}
-
-	if (folio_wait_writeback_killable(folio)) {
-		ret = VM_FAULT_LOCKED;
-		goto out;
-	}
+	if (folio->mapping != mapping)
+		goto unlock;
+	if (folio_wait_writeback_killable(folio) < 0)
+		goto unlock;
 
 	/* Can we see a streaming write here? */
 	if (WARN_ON(!folio_test_uptodate(folio))) {
-		ret = VM_FAULT_SIGBUS | VM_FAULT_LOCKED;
-		goto out;
+		ret = VM_FAULT_SIGBUS;
+		goto unlock;
 	}
 
 	group = netfs_folio_group(folio);
@@ -581,5 +577,8 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 out:
 	sb_end_pagefault(inode->i_sb);
 	return ret;
+unlock:
+	folio_unlock(folio);
+	goto out;
 }
 EXPORT_SYMBOL(netfs_page_mkwrite);
-- 
2.53.0




