Return-Path: <stable+bounces-241308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O9uA6hc72m3AgEAu9opvQ
	(envelope-from <stable+bounces-241308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:55:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C4F472E65
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F355530071F3
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155483BA22E;
	Mon, 27 Apr 2026 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rJjF2DsG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306930E0F8;
	Mon, 27 Apr 2026 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294498; cv=none; b=ERdGZ8TGKtyTLoIiupgY6M9b0e3PTkBJfCzMre+oQUynmY8tltqTaA/k7Tz17vtUVimbL0YByuiaZ+4ejwih0vJpx1jH7a3rfjxExq2/KW8NqlRTS3NyqiGDpu0uGrxvBY5Gz+RGmaukI6I1I6lnqsHBNIXArEvE+7rnq8N2G2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294498; c=relaxed/simple;
	bh=wgVk72+XDVQUy97KVGpKHVmAAhh2QqpT7XggA7Tux0Q=;
	h=Date:To:From:Subject:Message-Id; b=jw+GxQyTIbeiAWDEFvbMPCmTdT70AJF8RX/cStzCfzSnWH0UYC90WuH+f80muSn5SJacO5KlKsBcTpSoGkXEbAqFEniCv7ui5y/Dw5dFsSaqYyBrBYk8FvnmM52wMbtlCh3Q7DnLCd000u765SILyUtIL8foS9swdT80fWMtSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rJjF2DsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5DDC19425;
	Mon, 27 Apr 2026 12:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777294498;
	bh=wgVk72+XDVQUy97KVGpKHVmAAhh2QqpT7XggA7Tux0Q=;
	h=Date:To:From:Subject:From;
	b=rJjF2DsGgRjMOrsD7Iojgpc/KG6LNy0akDM+VeIm1qRmYSSRoTkMjThLtECKbqmln
	 DbbcyJwyQLQ+WhSW/HUovkzXzxaDjYe+oYyQKoOVT7h7P88EPYoFbL9McsulidPmwG
	 qpwbRPhFdtfJp0kdWv3N0m1rE0qlf/pRGWlZQs8k=
Date: Mon, 27 Apr 2026 05:54:57 -0700
To: mm-commits@vger.kernel.org,vbabka@kernel.org,urezki@gmail.com,stable@vger.kernel.org,harry@kernel.org,elver@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] vmalloc-fix-buffer-overflow-in-vrealloc_node_align.patch removed from -mm tree
Message-Id: <20260427125458.5C5DDC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 97C4F472E65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241308-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,google.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]


The quilt patch titled
     Subject: vmalloc: fix buffer overflow in vrealloc_node_align()
has been removed from the -mm tree.  Its filename was
     vmalloc-fix-buffer-overflow-in-vrealloc_node_align.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Marco Elver <elver@google.com>
Subject: vmalloc: fix buffer overflow in vrealloc_node_align()
Date: Mon, 20 Apr 2026 13:47:26 +0200

Commit 4c5d3365882d ("mm/vmalloc: allow to set node and align in
vrealloc") added the ability to force a new allocation if the current
pointer is on the wrong NUMA node, or if an alignment constraint is not
met, even if the user is shrinking the allocation.

On this path (need_realloc), the code allocates a new object of 'size'
bytes and then memcpy()s 'old_size' bytes into it.  If the request is to
shrink the object (size < old_size), this results in an out-of-bounds
write on the new buffer.

Fix this by bounding the copy length by the new allocation size.

Link: https://lore.kernel.org/20260420114805.3572606-2-elver@google.com
Fixes: 4c5d3365882d ("mm/vmalloc: allow to set node and align in vrealloc")
Signed-off-by: Marco Elver <elver@google.com>
Reported-by: Harry Yoo (Oracle) <harry@kernel.org>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmalloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/vmalloc.c~vmalloc-fix-buffer-overflow-in-vrealloc_node_align
+++ a/mm/vmalloc.c
@@ -4361,7 +4361,7 @@ need_realloc:
 		return NULL;
 
 	if (p) {
-		memcpy(n, p, old_size);
+		memcpy(n, p, min(size, old_size));
 		vfree(p);
 	}
 
_

Patches currently in -mm which might be from elver@google.com are



