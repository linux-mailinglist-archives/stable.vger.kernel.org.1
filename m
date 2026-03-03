Return-Path: <stable+bounces-222846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLpgDSy0pmk7TAAAu9opvQ
	(envelope-from <stable+bounces-222846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 11:13:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F4E1EC75A
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 11:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09CAA3008610
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 10:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37867390210;
	Tue,  3 Mar 2026 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/+SabYa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A3337BA6
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532773; cv=none; b=TZl0ZFpmUGZkZDcYHwrKq0uX3wbsljLaxm3aecTzN/9wJ9hQtRQ53hUc41MC3oUd//jef5B16XKqaLLjvEmowCBxAkgB2vOefBVUFDZg0ZZuVF/oeApAI5ETZsNTNej0AYbATWuxtIZRkrisc0avpb/QxWlqlGTltq8V6VOwyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532773; c=relaxed/simple;
	bh=QUoN8n5q5DF0utBmkEV5z51l/ueCTY4b7t6dkFsSAlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Axn31lf1iTjbMX9oPkwoZBaXXV2Ix9Q9rChCaAlmXIVf5Qlo52xcVXB1Q+UPA9k3hNUP4ydDoYLo00HmuNk/cAL6MhaNn+292uBclW/CSB51QWVFCiKXvVPPhZiMcImGUpHtDi0mAI+/teq7MoM9IoWT6E3XDfDJKfcQ00s4JAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/+SabYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BF7C116C6;
	Tue,  3 Mar 2026 10:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772532772;
	bh=QUoN8n5q5DF0utBmkEV5z51l/ueCTY4b7t6dkFsSAlE=;
	h=From:To:Cc:Subject:Date:From;
	b=p/+SabYaHTZfFnOfUY/3odZBn9WemruYkJV2T5ThkK3e0SZwOZZNM+cGmt9yDL0Ne
	 MkRFHkl+ea+dphYiXCnAbKLQs81zJUM2xhml1aHy9M2mXNd9yQ3dV1Dl3mYn+bt44h
	 9MhI6Th9CLG8YOXmGB4Bpv8VWFnFW+xGdOmwCRwqMzdqCQWvH/J2Ge+Q2kJi7PKhA6
	 6UTbl62S+sI95Np8TGNQEmQxUaw8vnRhIbvwnQzLbBD6ZnDFrmGqaXjOMpovyuy7iE
	 FmacI4np6IGSpWvRf1UKMk5ehTR6b0ChqF3uTXOFWpXEcbsfOgHYMRb9WRQ137kojv
	 AO5jF4tbZl3GQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: stable@vger.kernel.org
Cc: linux-mm <linux-mm@kvack.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Li Ying <liying3@sungrowpower.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Lameter <cl@linux.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH 6.6.y] mm/mempolicy: fix wrong mmap_read_unlock() in migrate_to_node()
Date: Tue,  3 Mar 2026 11:12:45 +0100
Message-ID: <20260303101245.22290-1-david@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 32F4E1EC75A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222846-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Rspamd-Action: no action

The backport of commit 091c1dd2d4df ("mm/mempolicy: fix migrate_to_node()
assuming there is at least one VMA in a MM") contains an error:
migrate_to_node() does not lock the mmap_lock itself, that is handled by
the caller instead.

So let's drop the wrong mmap_read_unlock(). Fortunately, this path is
very hard to hit in practice.

Fixes: a13b2b9b0b0b ("mm/mempolicy: fix migrate_to_node() assuming there is at least one VMA in a MM")
Reported-by: Li Ying <liying3@sungrowpower.com>
Closes: https://lore.kernel.org/r/aaZgUNxAyKC2IwuG@casper.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mempolicy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 94c74c594d10..d8007e1c2690 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1071,10 +1071,8 @@ static long migrate_to_node(struct mm_struct *mm, int source, int dest,
 
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
 	vma = find_vma(mm, 0);
-	if (unlikely(!vma)) {
-		mmap_read_unlock(mm);
+	if (unlikely(!vma))
 		return 0;
-	}
 
 	/*
 	 * This does not migrate the range, but isolates all pages that
-- 
2.43.0


