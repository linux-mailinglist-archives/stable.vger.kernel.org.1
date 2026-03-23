Return-Path: <stable+bounces-227935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKiXLk8LwWmtPwQAu9opvQ
	(envelope-from <stable+bounces-227935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:43:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA5D2EF435
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC4A530086BD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D6D38654C;
	Mon, 23 Mar 2026 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSL/kERc"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765733859CE
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259016; cv=none; b=totehqMrVMF7yw1Eim34kHktIE5CnoQAxhCl7ddmLWwQdhhdsM5RDOVUOcE3NKC425e7ko9okuVrdXp8Y5aWKKcFnDj268CPoUgBRdrnzWasGD5iFRhFw6xvTNNeAkdIVmHtPIa1AMxOYgqnJRUMxjaE37viX5xC7SDdp8JAAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259016; c=relaxed/simple;
	bh=5y4szdYhhZnDzxMFhE0sPxE3rTf1Kkyq4C5A6KvmgX0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kZ9raI2RkIO2jAdNdV0rJWYlW0GZzkuLk2+Gtxe+Ptf0xNEqUkLn2RYtmretPQK8IVFIPjvpSlDqQa9k6DP3K/tnFscd2jCIawfR+EmKqwG0KoRz8Lk4UxkA7FGt8jAZ3pES9otlFZ85oco3xOgHurhmtOB1rd+oYZJCgEkvVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CSL/kERc; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78fc4425b6bso35129227b3.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774259014; x=1774863814; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ym4pkkY92K3/0r9PfgVLK1H3UUTu6ye1dXSd2uLPJZc=;
        b=CSL/kERcVYyjwr7+49YjYUyIQaNnPIq/kIYRIIdOXa95DRrJfz85Wxan+QYHHASU5S
         xJIIx3bjUUXXe5mb20A8EOFTRSB7I0oQ+2g35JhVAObsQHK+3Ri7ASJYHjARbn6yX6rx
         raWLGukGJHhGt6b4WTBzm4ju6JIzvWObXj/Igurc4GE/rZnT6aJ2K8KH0n0D1XR+aSpa
         8hmhq3XW84AH367v2DivU5U/00gVSqrdupv/XIuoI+seXIbWTV4RYb7myXAPAPk+wAtk
         PebOTE33ayJ3sBdAr6lNhDLMxrZC7D/zoweXBLgyGqBGFmqSbwo1V+rYNsJXXxyXUHOK
         LF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774259014; x=1774863814;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ym4pkkY92K3/0r9PfgVLK1H3UUTu6ye1dXSd2uLPJZc=;
        b=cynhKkP5fBzFkNv87IqG66fTbloRNk738CzRvJNfKcon06czEUxiAjH8ZOuDnbpfby
         mANVmTj0D7LNEZpJqOndyWUdw4MUb5vljrsRMv7YyAoMpHmY8BI/cfWWGVcPYp5pJSe7
         fkcvQDWYzObbyk6mx0JaJ2kXdqSke7WXrbCVOnw8rVjgrVDswJUfFUADPd20xfks0xoy
         JCGb1hvIJFCfKieUMSid3uqP/WmgPUggujqoIbOW21r2DHjCHYGG6brFiGTiOJnu18Zh
         M79V1GUj/p6YsaCtVIljz0JI2+E/zbeflNYD+YdfFVlyUb8PoYAz6e4DeZqPriUVCC03
         fUnw==
X-Forwarded-Encrypted: i=1; AJvYcCULYnRJX0u2qKcnUHfNy5coz9Yz+UkqO/WIWr8Nvi5eRpn1NuRTHgyUeHrwjdpSYoWganJhfGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYAH6UWh5sM4fuxLlSBmmv7A0h5qSyDZhynbL2wo54YF4b5zdl
	fKf2mI9ogSQV6sBPscJST9u0mfVuaUExjHrRasQHWCdxmAov5v3enOIWpOf9pWVcXA==
X-Gm-Gg: ATEYQzyvIc121gpMZqwWebkS4c2Ky9+1p1AaJvHR8UrSNpwebWOYJC8YfwpTPG+tl1G
	MBAFg51UXepChtCgNVq2JP2wWHt8jbEr0L4TKiNjiQ8yEU6Plw8ednAff5/Xs0y80ePwWYDBdc7
	IKFWOOSVAo5cY2kESLvwm6EqihicU8wHu+2Nw6mdHZS+hEfIfqpgk0CFqmbAOQ5mAOKyjmlUZpo
	/0DrU4YA/XKzWcl4aV2Y9TZNoY4pXjvi6axQfYbmV8rkKYgLKVcCJdnxJFdxG7fIEERM+/kGcGx
	UnibsN86k+9xAVT/kUa1cO4dtO7GpL0qgNHSLqVvEHgwFFFQ7bIcMMZ3yPdbT4NUwSllydfuMpt
	G2rJtVLeqPgj7LPK0NUpSxSDskA3hcNObnXAeTBogKWZKzdjGxDHVXPUBscU0HD2F1DfPWZ1zEJ
	B1sveQV10nkcgWIxyHZVNi1MzLRbIGbced/ie2WAvMlVvbzh9Lz2HEE6dXpFOf/R4fr3MBNwwJX
	KyY4MnqoZc=
X-Received: by 2002:a05:690e:e23:b0:64e:a30f:e67e with SMTP id 956f58d0204a3-64eaa833f62mr8891182d50.67.1774259013998;
        Mon, 23 Mar 2026 02:43:33 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabe9fda4sm5926373d50.16.2026.03.23.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:43:33 -0700 (PDT)
Date: Mon, 23 Mar 2026 02:43:31 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
    Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
    David Hildenbrand <david@kernel.org>, Dev Jain <dev.jain@arm.com>, 
    Greg Thelen <gthelen@google.com>, Guenter Roeck <groeck@google.com>, 
    Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
    Lance Yang <lance.yang@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
    Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, stable@vger.kernel.org
Subject: [PATCH 6.12.y 4/4] mm/shmem, swap: avoid redundant Xarray lookup
 during swapin
In-Reply-To: <a07eace6-82f2-32a8-0cbc-85972d4b1eee@google.com>
Message-ID: <ebffe1a4-f575-8a38-2584-70cbfeda6913@google.com>
References: <a07eace6-82f2-32a8-0cbc-85972d4b1eee@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,linux.alibaba.com,redhat.com,kernel.org,arm.com,tencent.com,huaweicloud.com,linux.dev,infradead.org,gmail.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-227935-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hughd@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,alibaba.com:email,linux-foundation.org:email,arm.com:email,tencent.com:email,infradead.org:email]
X-Rspamd-Queue-Id: BEA5D2EF435
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 mm/shmem.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1b95e8e7d68d..c92af39eebdd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -499,15 +499,27 @@ static int shmem_replace_entry(struct address_space *mapping,
 
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
@@ -2155,16 +2167,20 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
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
@@ -2241,7 +2257,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	 */
 	folio_lock(folio);
 	if (!folio_test_swapcache(folio) ||
-	    !shmem_confirm_swap(mapping, index, swap) ||
+	    shmem_confirm_swap(mapping, index, swap) < 0 ||
 	    folio->swap.val != swap.val) {
 		error = -EEXIST;
 		goto unlock;
@@ -2284,7 +2300,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	*foliop = folio;
 	return 0;
 failed:
-	if (!shmem_confirm_swap(mapping, index, swap))
+	if (shmem_confirm_swap(mapping, index, swap) < 0)
 		error = -EEXIST;
 	if (error == -EIO)
 		shmem_set_folio_swapin_error(inode, index, folio, swap);

