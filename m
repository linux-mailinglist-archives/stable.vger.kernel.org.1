Return-Path: <stable+bounces-36347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 662FE89BCC3
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AD61C2239C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8823A52F6A;
	Mon,  8 Apr 2024 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LN+yOVS5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207B2537FB
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571264; cv=none; b=RsIETyd2E+E6a1YA3J2d7uCPQ5BgHQgZRbKsu8weRpBm2+t7ZabH5NwICAPMnTig+oSYG+WrhkVQKw+ntEZz0JdzYxS5+RwcMcwPU9GaADlFhiLKrE1AEun4Zv9mJnqv51zOvVL7QS2N28qmha/ftlMbw/C+ynhdXdAJ27N8bC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571264; c=relaxed/simple;
	bh=UOpAZ8D3HaJ6exHxURqMyvaWB1prQjExaL1DMkJMWcU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k/cxMPgk9WNvDFeRtQFYQcsiuLEwHoiNDjc1gFb5eiFcQacgV8W9ckrawUhlrT+fYoQenveqa03Z7EZ80T2cHbNWGPlHQeDGLuCslaoBWiuVxSVG3MxvePnTVHozbMV1stsgZsL4Of6RG6pn39GQa2lZxPzQ48vcjOUqgDYshKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LN+yOVS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A6EC433F1;
	Mon,  8 Apr 2024 10:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712571263;
	bh=UOpAZ8D3HaJ6exHxURqMyvaWB1prQjExaL1DMkJMWcU=;
	h=Subject:To:Cc:From:Date:From;
	b=LN+yOVS5pj5eqteziqbHdLEoP3IitlHASFRoaPk3ShdSZC/KRB8bFoow/ebr1KlFM
	 EiwcWf9OAG3KPxIKpeZWu6oE3JB+XSved76MYv9jyfv1ufWwHdDyI4liohOLBLiQck
	 jaDrnIjujF9W9IDnlezLsVnGwDivHc4UlJGGgWbc=
Subject: FAILED: patch "[PATCH] mm/secretmem: fix GUP-fast succeeding on secretmem folios" failed to apply to 6.1-stable tree
To: david@redhat.com,akpm@linux-foundation.org,lstoakes@gmail.com,miklos@szeredi.hu,mszeredi@redhat.com,rppt@kernel.org,samsun1006219@gmail.com,stable@vger.kernel.org,xrivendell7@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Apr 2024 12:14:19 +0200
Message-ID: <2024040819-elf-bamboo-00f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 65291dcfcf8936e1b23cfd7718fdfde7cfaf7706
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040819-elf-bamboo-00f6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

65291dcfcf89 ("mm/secretmem: fix GUP-fast succeeding on secretmem folios")
8f9ff2deb8b9 ("secretmem: convert page_is_secretmem() to folio_is_secretmem()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65291dcfcf8936e1b23cfd7718fdfde7cfaf7706 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Mar 2024 15:32:08 +0100
Subject: [PATCH] mm/secretmem: fix GUP-fast succeeding on secretmem folios

folio_is_secretmem() currently relies on secretmem folios being LRU
folios, to save some cycles.

However, folios might reside in a folio batch without the LRU flag set, or
temporarily have their LRU flag cleared.  Consequently, the LRU flag is
unreliable for this purpose.

In particular, this is the case when secretmem_fault() allocates a fresh
page and calls filemap_add_folio()->folio_add_lru().  The folio might be
added to the per-cpu folio batch and won't get the LRU flag set until the
batch was drained using e.g., lru_add_drain().

Consequently, folio_is_secretmem() might not detect secretmem folios and
GUP-fast can succeed in grabbing a secretmem folio, crashing the kernel
when we would later try reading/writing to the folio, because the folio
has been unmapped from the directmap.

Fix it by removing that unreliable check.

Link: https://lkml.kernel.org/r/20240326143210.291116-2-david@redhat.com
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/lkml/CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com/
Debugged-by: Miklos Szeredi <miklos@szeredi.hu>
Tested-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index 35f3a4a8ceb1..acf7e1a3f3de 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -13,10 +13,10 @@ static inline bool folio_is_secretmem(struct folio *folio)
 	/*
 	 * Using folio_mapping() is quite slow because of the actual call
 	 * instruction.
-	 * We know that secretmem pages are not compound and LRU so we can
+	 * We know that secretmem pages are not compound, so we can
 	 * save a couple of cycles here.
 	 */
-	if (folio_test_large(folio) || !folio_test_lru(folio))
+	if (folio_test_large(folio))
 		return false;
 
 	mapping = (struct address_space *)


