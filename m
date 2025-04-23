Return-Path: <stable+bounces-135997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C968EA990EB
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F2D87A3BEB
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFF728FFD5;
	Wed, 23 Apr 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nqnItTnM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4C828CF6B;
	Wed, 23 Apr 2025 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421386; cv=none; b=gxAR0teAZ3IIIo6RyUfRSxxFCFTtBN+G1AS3vMyRqYQ9T/a/zWCDPyfOErUY2WLQiLA6oso4PbdTR6fEwpD5cUl9Cejv9xJ0ea/2XjUe95G57c0qVNorRhO0T4JAxjAMFyNUF9ulEFDvpSnPwtQ5C6MsTyCihxm75pSAAJeotsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421386; c=relaxed/simple;
	bh=idD66FNbxnzWEMPCw8mhG6iVtLNpuzf3kXbJrBQehCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqHJG37Qt8HbRhcqZx8cBV71Z4AF04NsjqlsFpjz5kE8ey4fUK7PHj81jsyLkeYx7dPvN92vdkLuUpvF7WpsODLRvKt8PwIERbLEezBQ8jauTZnPaK6/x7M5+bTwMtMohprU2oKDkJDH29AAnMYhMamneYtFTBtFGxyxv+e14HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nqnItTnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A68C4CEE2;
	Wed, 23 Apr 2025 15:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421386;
	bh=idD66FNbxnzWEMPCw8mhG6iVtLNpuzf3kXbJrBQehCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqnItTnMBhkcPW3I/R8PjRrGqzSF75LjBTD6oEcVFk3C2oKU1jXziPc9Ik3JEfE7v
	 vi4mIqXrgoWBhr2VIx4OrowWASi5FP0pdojnQlhFUOjpWKwOsFy1G/aM8jcK4P3njT
	 /lzYcuhhWrGg2AVV9R2A7hOKGKe9cxaELtrb2s+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 132/291] mm: add missing release barrier on PGDAT_RECLAIM_LOCKED unlock
Date: Wed, 23 Apr 2025 16:42:01 +0200
Message-ID: <20250423142629.793168397@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
References: <20250423142624.409452181@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit c0ebbb3841e07c4493e6fe351698806b09a87a37 upstream.

The PGDAT_RECLAIM_LOCKED bit is used to provide mutual exclusion of node
reclaim for struct pglist_data using a single bit.

It is "locked" with a test_and_set_bit (similarly to a try lock) which
provides full ordering with respect to loads and stores done within
__node_reclaim().

It is "unlocked" with clear_bit(), which does not provide any ordering
with respect to loads and stores done before clearing the bit.

The lack of clear_bit() memory ordering with respect to stores within
__node_reclaim() can cause a subsequent CPU to fail to observe stores from
a prior node reclaim.  This is not an issue in practice on TSO (e.g.
x86), but it is an issue on weakly-ordered architectures (e.g.  arm64).

Fix this by using clear_bit_unlock rather than clear_bit to clear
PGDAT_RECLAIM_LOCKED with a release memory ordering semantic.

This provides stronger memory ordering (release rather than relaxed).

Link: https://lkml.kernel.org/r/20250312141014.129725-1-mathieu.desnoyers@efficios.com
Fixes: d773ed6b856a ("mm: test and set zone reclaim lock before starting reclaim")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmscan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7729,7 +7729,7 @@ int node_reclaim(struct pglist_data *pgd
 		return NODE_RECLAIM_NOSCAN;
 
 	ret = __node_reclaim(pgdat, gfp_mask, order);
-	clear_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
+	clear_bit_unlock(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
 
 	if (!ret)
 		count_vm_event(PGSCAN_ZONE_RECLAIM_FAILED);



