Return-Path: <stable+bounces-212215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJIOODEwemlq3wEAu9opvQ
	(envelope-from <stable+bounces-212215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:50:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0005CA4825
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 724F03153C98
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4669A2F25F2;
	Wed, 28 Jan 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MU+0Sjb2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB82EBBBC;
	Wed, 28 Jan 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614770; cv=none; b=PDD2cHnaFHu1EonKOfV3MwWtbrNzjQfA09vLTc6/PKVCnTKtRj7p+2PbmHFbUSDwhRyhDnhMAGOqET5vcgnEds/mm0xtdUNSXzQQoTxeAhBwXVZAyKC4hPxcNZPkXEH8SrRRhOZqpD0bhMlolEAKPqc6ju1yiwc1XIlxu95Yzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614770; c=relaxed/simple;
	bh=J+yXDa7sZc6r0ZNng0KspDXxLnkFy7OqPkH06HqZ4kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPiEnhYBREIRdvESf2zQYpwqSXeJ4inijxiK6BhPQ5Fw5K6JQuFbg9LP2dIry+8vwut6pRJqNbgb+tkAHtVWf2/nnkcCAbrDM5xZQCAFuPTp+GwC60C2RUsNi0oCkV7XwPoYERz2Ep72KLgVpeg5TSbyiJuSmygzHbvxSsFVcCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MU+0Sjb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D1FC4CEF1;
	Wed, 28 Jan 2026 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614769;
	bh=J+yXDa7sZc6r0ZNng0KspDXxLnkFy7OqPkH06HqZ4kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MU+0Sjb2fHqJE8UYnLCgrN/1TBqM4pzY9m1bGzS5jPgVWD68T3U+3EjYUVpqsMbFE
	 GcMsjfV4tRLeYxd4thE3A6tuVTmEGysv6dGvWFrGZkb9q++jS1OhmQBZHK/2smYwH3
	 6ZVe8Pi6eb9/vuUSH0W0Hk1fPUmJTROb4qk0Fxd4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitriy Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 236/254] mm: kmsan: fix poisoning of high-order non-compound pages
Date: Wed, 28 Jan 2026 16:23:32 +0100
Message-ID: <20260128145353.285804773@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212215-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0005CA4825
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryan Roberts <ryan.roberts@arm.com>

[ Upstream commit 4795d205d78690a46b60164f44b8bb7b3e800865 ]

kmsan_free_page() is called by the page allocator's free_pages_prepare()
during page freeing.  Its job is to poison all the memory covered by the
page.  It can be called with an order-0 page, a compound high-order page
or a non-compound high-order page.  But page_size() only works for order-0
and compound pages.  For a non-compound high-order page it will
incorrectly return PAGE_SIZE.

The implication is that the tail pages of a high-order non-compound page
do not get poisoned at free, so any invalid access while they are free
could go unnoticed.  It looks like the pages will be poisoned again at
allocation time, so that would bookend the window.

Fix this by using the order parameter to calculate the size.

Link: https://lkml.kernel.org/r/20260104134348.3544298-1-ryan.roberts@arm.com
Fixes: b073d7f8aee4 ("mm: kmsan: maintain KMSAN metadata for page operations")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/kmsan/shadow.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -210,7 +210,7 @@ void kmsan_free_page(struct page *page,
 		return;
 	kmsan_enter_runtime();
 	kmsan_internal_poison_memory(page_address(page),
-				     page_size(page),
+				     PAGE_SIZE << order,
 				     GFP_KERNEL,
 				     KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
 	kmsan_leave_runtime();



