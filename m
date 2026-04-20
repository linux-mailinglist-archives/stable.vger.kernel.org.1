Return-Path: <stable+bounces-239530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEKiHUtM5mkgugEAu9opvQ
	(envelope-from <stable+bounces-239530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:54:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EF042EB62
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F77D30055B1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E2F331A78;
	Mon, 20 Apr 2026 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gcaFd6uO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5212E093A;
	Mon, 20 Apr 2026 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700489; cv=none; b=EmOUOrT2RVeom4otTKnZzI5CK5L0uynX19g5v5YK28+LsfSXGS8HAVJ8isLggpBoUQaI1pNMPssdKLmqQ/BkqgD0DDMY00KvMAR3zw9mKpQ5TEPoxx1zWEqKgAk4VmGehe3iFyEnoU6T3kqYn0Wfi/ZPuLiz4c6iKtBsOh9Mh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700489; c=relaxed/simple;
	bh=4eiApwrGy2kebTZLivE8/XCMGj36g/ItG8DXkJIiqvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbu3JgKo1jNoe2A2JVPRoO6T+H8koTkaW/rxzt2HTHEAi1bOGdDuR79GbF6Ko/kDK3jEnCVq5d+aLdXjR7JFo5jvKEqyA5u0W+NavavsAU6CH9cknNyCWrVDdEr9W9SunuPGI+vBWpUEo5JpwT3Vb7BL1jesCb92iygQ7WcLFLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gcaFd6uO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B616CC19425;
	Mon, 20 Apr 2026 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700489;
	bh=4eiApwrGy2kebTZLivE8/XCMGj36g/ItG8DXkJIiqvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gcaFd6uOfJd6gNTvLYqmmyS0Ywpkck6+BtIvcLjrY/R9/4XOe4hbD6NHZAHJ/Vx+N
	 oBMbILIBthBLoYWypa73PDRAvmgYDJH2no6jXC8WVWm/2wCUu1MmcaqPrzNpADMFqO
	 VjwprrVvAO0R4hNoN5dgKvHV9m01J/wDLXsE8pgQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Google Big Sleep <big-sleep-vuln-reports+bigsleep-501448199@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.19 193/220] mm: call ->free_folio() directly in folio_unmap_invalidate()
Date: Mon, 20 Apr 2026 17:42:14 +0200
Message-ID: <20260420153940.974540985@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-239530-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,bigsleep-501448199];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linux-foundation.org:email,suse.cz:email,kernel.dk:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 17EF042EB62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

commit 615d9bb2ccad42f9e21d837431e401db2e471195 upstream.

We can only call filemap_free_folio() if we have a reference to (or hold a
lock on) the mapping.  Otherwise, we've already removed the folio from the
mapping so it no longer pins the mapping and the mapping can be removed,
causing a use-after-free when accessing mapping->a_ops.

Follow the same pattern as __remove_mapping() and load the free_folio
function pointer before dropping the lock on the mapping.  That lets us
make filemap_free_folio() static as this was the only caller outside
filemap.c.

Link: https://lore.kernel.org/20260413184314.3419945-1-willy@infradead.org
Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when writeback completes")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reported-by: Google Big Sleep <big-sleep-vuln-reports+bigsleep-501448199@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/filemap.c  |    3 ++-
 mm/internal.h |    1 -
 mm/truncate.c |    6 +++++-
 3 files changed, 7 insertions(+), 3 deletions(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -228,7 +228,8 @@ void __filemap_remove_folio(struct folio
 	page_cache_delete(mapping, folio, shadow);
 }
 
-void filemap_free_folio(struct address_space *mapping, struct folio *folio)
+static void filemap_free_folio(const struct address_space *mapping,
+		struct folio *folio)
 {
 	void (*free_folio)(struct folio *);
 
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -471,7 +471,6 @@ unsigned find_lock_entries(struct addres
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
-void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
 		loff_t end);
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -622,6 +622,7 @@ static int folio_launder(struct address_
 int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 			   gfp_t gfp)
 {
+	void (*free_folio)(struct folio *);
 	int ret;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -648,9 +649,12 @@ int folio_unmap_invalidate(struct addres
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
 		inode_lru_list_add(mapping->host);
+	free_folio = mapping->a_ops->free_folio;
 	spin_unlock(&mapping->host->i_lock);
 
-	filemap_free_folio(mapping, folio);
+	if (free_folio)
+		free_folio(folio);
+	folio_put_refs(folio, folio_nr_pages(folio));
 	return 1;
 failed:
 	xa_unlock_irq(&mapping->i_pages);



