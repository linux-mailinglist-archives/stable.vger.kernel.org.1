Return-Path: <stable+bounces-228909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPSVNpdqwWnVSwQAu9opvQ
	(envelope-from <stable+bounces-228909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:30:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFBE2F8304
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E48DD33241FE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593422741A0;
	Mon, 23 Mar 2026 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v0L0cvii"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6871A5B84;
	Mon, 23 Mar 2026 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277461; cv=none; b=VdSa/56NfEndOjpCTQ5oLLsoG6eU5NCSsWEMat77EiW3qa+B2GzPUIWd0UoIX9hsqySwJOPy8E00EmA6E11HLR0YMd7JlMxCYazmusiSMGEbnyLJarqCavkbzvjTCdhaeng5ZNPYBCV1ShSlqdrG9AgUyXOmwNm087jh+0FB+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277461; c=relaxed/simple;
	bh=jJIc9dtLNTM6+nd0286zvZc8DqoBZOrWjv0pY0V3y6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mR+BxcuVk8KScOG7nxIHUhuXlV+rldWG/x7p9//O/4Unh6rZ6kCYzrm/zeiXkRYUconfGutsTv0oSwtRiq1PyLo9qWjyY8PlN1/PJbjc8gHa8byJjD6JIHIm9bkwqMurzr7Z2WZGymAyLifTFaoAmJ2ChNPf2MvgMdwV2GH3uR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v0L0cvii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D7AC4CEF7;
	Mon, 23 Mar 2026 14:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277461;
	bh=jJIc9dtLNTM6+nd0286zvZc8DqoBZOrWjv0pY0V3y6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v0L0cviiH7ipbrJY0RROG4d7OBQc9Oxvw89xIT+j5LGHhS5/VtCQXQYxMmvZGfAjC
	 JHzMkmu0r8nnC6CF7Acw8bQLQAOsBK+6EWJdRjcWum1n4/8SToZiP+9r2yLh2zBLcY
	 wuRpYqsAZpun0XgxMwf9gaTUjwFMK6JulX7BVbRQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 448/460] mm/shmem, swap: avoid redundant Xarray lookup during swapin
Date: Mon, 23 Mar 2026 14:47:24 +0100
Message-ID: <20260323134537.596455704@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228909-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,tencent.com,huaweicloud.com,arm.com,linux.alibaba.com,redhat.com,kernel.org,google.com,infradead.org,gmail.com,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 7CFBE2F8304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kairui Song <kasong@tencent.com>

commit 0cfc0e7e3d062b93e9eec6828de000981cdfb152 upstream.

Currently shmem calls xa_get_order to get the swap radix entry order,
requiring a full tree walk.  This can be easily combined with the swap
entry value checking (shmem_confirm_swap) to avoid the duplicated lookup
and abort early if the entry is gone already.  Which should improve the
performance.

Link: https://lkml.kernel.org/r/20250728075306.12704-1-ryncsn@gmail.com
Link: https://lkml.kernel.org/r/20250728075306.12704-3-ryncsn@gmail.com
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Stable-dep-of: 8a1968bd997f ("mm/shmem, swap: fix race of truncate and swap entry split")
[ hughd: removed series cover letter and skip_swapcache dependencies ]
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/shmem.c |   34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -499,15 +499,27 @@ static int shmem_replace_entry(struct ad
 
 /*
  * Sometimes, before we decide whether to proceed or to fail, we must check
- * that an entry was not already brought back from swap by a racing thread.
+ * that an entry was not already brought back or split by a racing thread.
  *
  * Checking folio is not enough: by the time a swapcache folio is locked, it
  * might be reused, and again be swapcache, using the same swap as before.
+ * Returns the swap entry's order if it still presents, else returns -1.
  */
-static bool shmem_confirm_swap(struct address_space *mapping,
-			       pgoff_t index, swp_entry_t swap)
+static int shmem_confirm_swap(struct address_space *mapping, pgoff_t index,
+			      swp_entry_t swap)
 {
-	return xa_load(&mapping->i_pages, index) == swp_to_radix_entry(swap);
+	XA_STATE(xas, &mapping->i_pages, index);
+	int ret = -1;
+	void *entry;
+
+	rcu_read_lock();
+	do {
+		entry = xas_load(&xas);
+		if (entry == swp_to_radix_entry(swap))
+			ret = xas_get_order(&xas);
+	} while (xas_retry(&xas, entry));
+	rcu_read_unlock();
+	return ret;
 }
 
 /*
@@ -2155,16 +2167,20 @@ static int shmem_swapin_folio(struct ino
 		return -EIO;
 
 	si = get_swap_device(swap);
-	if (!si) {
-		if (!shmem_confirm_swap(mapping, index, swap))
+	order = shmem_confirm_swap(mapping, index, swap);
+	if (unlikely(!si)) {
+		if (order < 0)
 			return -EEXIST;
 		else
 			return -EINVAL;
 	}
+	if (unlikely(order < 0)) {
+		put_swap_device(si);
+		return -EEXIST;
+	}
 
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap, NULL, 0);
-	order = xa_get_order(&mapping->i_pages, index);
 	if (!folio) {
 
 		/* Or update major stats only when swapin succeeds?? */
@@ -2241,7 +2257,7 @@ static int shmem_swapin_folio(struct ino
 	 */
 	folio_lock(folio);
 	if (!folio_test_swapcache(folio) ||
-	    !shmem_confirm_swap(mapping, index, swap) ||
+	    shmem_confirm_swap(mapping, index, swap) < 0 ||
 	    folio->swap.val != swap.val) {
 		error = -EEXIST;
 		goto unlock;
@@ -2284,7 +2300,7 @@ static int shmem_swapin_folio(struct ino
 	*foliop = folio;
 	return 0;
 failed:
-	if (!shmem_confirm_swap(mapping, index, swap))
+	if (shmem_confirm_swap(mapping, index, swap) < 0)
 		error = -EEXIST;
 	if (error == -EIO)
 		shmem_set_folio_swapin_error(inode, index, folio, swap);



