Return-Path: <stable+bounces-239680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKA6N+hg5mkxvgEAu9opvQ
	(envelope-from <stable+bounces-239680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:22:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A29D431137
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E2B632CE196
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9993F33F8AA;
	Mon, 20 Apr 2026 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0ccr1FAB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E1C33E377;
	Mon, 20 Apr 2026 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700943; cv=none; b=f+iPnWFXIeYGmI8EUuUKbZjXRbJ7dVTiO4b67bWIU8nc7QhAuISJgdbOEB1tI2DFzIBCn5kCWWH16ChE3IhV4FwHIhM8KXCMngiZbfom6l9tNH9QuoD/Ktth/O1Ctd6t2UQuXFma0a6UdzGPE90wx0qvWeA0cWnvBO900cmuAgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700943; c=relaxed/simple;
	bh=2oIhMKk5lIFp7QMHv3phBe62aQKpniqvOir5C2/gYYE=;
	h=Date:To:From:Subject:Message-Id; b=WzlmrztI2sJ0TOdx6xRfqqcFJEtnjS2m4OsOzihakOtDLmM3qJw7DV1fqrb72Rqq+8MAkzwV4DQKFx4AEAJg1GaWrHDaqFfgrk+eainQComRAZtYQ7Kb5HvTYMii37stIuw9vOBI918GmYxg8mEHfYJWvOy1E4y84RUH3BRNYfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0ccr1FAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FC8C2BCB6;
	Mon, 20 Apr 2026 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776700943;
	bh=2oIhMKk5lIFp7QMHv3phBe62aQKpniqvOir5C2/gYYE=;
	h=Date:To:From:Subject:From;
	b=0ccr1FABWDOLmo2ducxbZgAfOK9ROolbmPmAQvRb8TGHEUDAdweZj4ci+kfZz/Ea6
	 VjZlXvgg6ohOTfxa95NaXEybZU45nYPB80wGGpPNJkANBaAjGaCNr4+D2RxajJPaEZ
	 zMVGksS1MT5c7FWmHaoxm0yd7FnzotVkaZ2OZ07A=
Date: Mon, 20 Apr 2026 09:02:20 -0700
To: mm-commits@vger.kernel.org,vbabka@kernel.org,urezki@gmail.com,stable@vger.kernel.org,harry@kernel.org,elver@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + vmalloc-fix-buffer-overflow-in-vrealloc_node_align.patch added to mm-hotfixes-unstable branch
Message-Id: <20260420160222.91FC8C2BCB6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239680-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,google.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,linux-foundation.org:dkim,linux-foundation.org:email]
X-Rspamd-Queue-Id: 6A29D431137
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch titled
     Subject: vmalloc: fix buffer overflow in vrealloc_node_align()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     vmalloc-fix-buffer-overflow-in-vrealloc_node_align.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/vmalloc-fix-buffer-overflow-in-vrealloc_node_align.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

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

vmalloc-fix-buffer-overflow-in-vrealloc_node_align.patch


