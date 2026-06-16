Return-Path: <stable+bounces-264468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hhcmMt13MWpokAUAu9opvQ
	(envelope-from <stable+bounces-264468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:20:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47367691F69
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:20:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fVgAv5iu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264468-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264468-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 016003223A57
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CC04534B3;
	Tue, 16 Jun 2026 16:07:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0D644CF40;
	Tue, 16 Jun 2026 16:07:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626045; cv=none; b=m30rnfiniqA4HdHOdqfFY89CSF3g75OXN/IOo7ykVs8EslFYQqrwsWoAmP+GNwoOaGt1lRMlqtRWoCOWIenv6acNX4vXWCGlzCiu3+Ah7BUgu8xCg3PMwh8+DYnxGkLlkFkI4cSAmpoFRumeIKKC106SZcXhe+Z6CFYuWqP25Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626045; c=relaxed/simple;
	bh=DKYKHpLWQFbSLVWtChZPmsZjEdPn2Vt+wAEFc9bPtK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9DjncFqT7NWZZT4Ee3Ze9InGnBhdiixBf8EW0iVtA1N58p51kylfJ+MGYDnwpP1Ijw3VZiKnZIc2e5qjd4NrRXrTzvsf6F6wCAoyfivZvyt0hEmQDmTnZtYsUKP32byAcOShAV9DJeiZzPXsZ0TQnkhxHQMG2suW8OepnKhrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fVgAv5iu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEB71F000E9;
	Tue, 16 Jun 2026 16:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626044;
	bh=q7s3Muj8MO/jTG2ZQW7qcYD/tRoG+Uengzcc9JVsgNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fVgAv5iuIUX6spp496J5pogua1buN7LRje5UhsIexFYsorvUsvvhKhHwsiSCT6NjR
	 kAiZfVTYWKJ9JYX435BZjuVc6VZHeFw5b7hkNqk7zsM/cVSl0yp4CEUxYy/13W1lGY
	 KxsquS77rBKtXVuOIbRoussbzcF/8uM0yIEvLhlA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Usama Arif <usama.arif@linux.dev>,
	Pedro Falcato <pfalcato@suse.de>,
	Kairui Song <kasong@tencent.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Jann Horn <jannh@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 256/325] mm/mincore: handle non-swap entries before !CONFIG_SWAP guard
Date: Tue, 16 Jun 2026 20:30:52 +0530
Message-ID: <20260616145111.328272923@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:usama.arif@linux.dev,m:pfalcato@suse.de,m:kasong@tencent.com,m:ljs@kernel.org,m:hannes@cmpxchg.org,m:baoquan.he@linux.dev,m:chrisl@kernel.org,m:jannh@google.com,m:liam@infradead.org,m:riel@surriel.com,m:shakeel.butt@linux.dev,m:vbabka@kernel.org,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264468-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,vger.kernel.org:from_smtp,surriel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47367691F69

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Usama Arif <usama.arif@linux.dev>

commit 0c25b8734367574e21aeb8468c2e522713134da7 upstream.

mincore_swap() also fields migration/hwpoison entries (and shmem
swapin-error entries), which can exist on !CONFIG_SWAP builds when
CONFIG_MIGRATION or CONFIG_MEMORY_FAILURE is enabled.  The
!IS_ENABLED(CONFIG_SWAP) guard ran before the non-swap-entry early return,
so mincore_pte_range() can spuriously WARN and report these pages
nonresident on !CONFIG_SWAP kernels.

Move the guard below the non-swap-entry check so only true swap entries
trip the WARN, and migration/hwpoison entries take the existing "uptodate
/ non-shmem" path.

Link: https://lore.kernel.org/20260602172247.279421-1-usama.arif@linux.dev
Fixes: 1f2052755c15 ("mm/mincore: use a helper for checking the swap cache")
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Chris Li <chrisl@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/mincore.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -53,11 +53,6 @@ static unsigned char mincore_swap(swp_en
 	struct folio *folio = NULL;
 	unsigned char present = 0;
 
-	if (!IS_ENABLED(CONFIG_SWAP)) {
-		WARN_ON(1);
-		return 0;
-	}
-
 	/*
 	 * Shmem mapping may contain swapin error entries, which are
 	 * absent. Page table may contain migration or hwpoison
@@ -66,6 +61,11 @@ static unsigned char mincore_swap(swp_en
 	if (non_swap_entry(entry))
 		return !shmem;
 
+	if (!IS_ENABLED(CONFIG_SWAP)) {
+		WARN_ON(1);
+		return 0;
+	}
+
 	/*
 	 * Shmem mapping lookup is lockless, so we need to grab the swap
 	 * device. mincore page table walk locks the PTL, and the swap



