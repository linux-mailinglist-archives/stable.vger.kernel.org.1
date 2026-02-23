Return-Path: <stable+bounces-217808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJLRI+qQnGnRJQQAu9opvQ
	(envelope-from <stable+bounces-217808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:39:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 703E617AF09
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88099301B789
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235BE334C08;
	Mon, 23 Feb 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHTL20es"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A8B334683;
	Mon, 23 Feb 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868387; cv=none; b=WxZIatzMFQZRuFjbpWihwFfwCdnXQ95QFjYi8QM5UmUVP4Zf/u3i/cczFZ4JgQDED8+jE9T0eUsYyCv1gjU6XvtaMVjBZd51jACT8YpgxdbTEQFYEFeEsHmHlVeY2deMtjYY2XUFfidYptlA778KrYs8Z53suQHg10zFoeDEiOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868387; c=relaxed/simple;
	bh=NkcemZpJG7TCrHsvZICKpUMsr7YdyLPMVXVEcANIaKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDokif6cYRUSdhi2vqLtYhV9y+smmrpRIztKb4uITmzV6cXpSHeLJhMn9r0ELolIEp/U0pLfrmfSltF15JqCDQ7MKre2qH+E6H3DoQ8zA8w17+iGB+jpApSk+K7utwOPRyjRCdZ0edX5wtp5IJYy4WfSEmARK3JXM1pGyl6BIfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHTL20es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCABC19421;
	Mon, 23 Feb 2026 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771868387;
	bh=NkcemZpJG7TCrHsvZICKpUMsr7YdyLPMVXVEcANIaKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHTL20es9YL5TdCn2/GZoN52kB9d1BjQa4LXiqBfKeudVn+ehx8Yfqm1hXMnuKye7
	 inc8mYiLyi+w677wZMOPLtBnhSE86TqylTRKxVANwNQsqae+Evb0hRxJD1g8x41bTh
	 8/sTpvSYR9niPAD5TLbMKm7yIGMcmJTgSJOHAdj/jEjCgql2smOs7EGVJ0U7jb2sJE
	 qa02Mm3EFfOQeGuVqRgIZ2Nr7ZWmW47qGTcLdCHFP/9S2KtaPyPfsUBgJgKU/HE4Tt
	 hwRr0ONDc4y3rQJRvZ3qpfxmM4GInWPkN8c7l3R4OT8k9hqAYxPH6swiwbCSM1rn5b
	 TDDyFJ4/yotAw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mm: memfd_luo: always dirty all folios
Date: Mon, 23 Feb 2026 18:39:29 +0100
Message-ID: <20260223173931.2221759-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223173931.2221759-1-pratyush@kernel.org>
References: <20260223173931.2221759-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217808-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 703E617AF09
X-Rspamd-Action: no action

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

A dirty folio is one which has been written to. A clean folio is its
opposite. Since a clean folio has no user data, it can be freed under
memory pressure.

memfd preservation with LUO saves the flag at preserve(). This is
problematic. The folio might get dirtied later. Saving it at freeze()
also doesn't work, since the dirty bit from PTE is normally synced at
unmap and there might still be mappings of the file at freeze().

To see why this is a problem, say a folio is clean at preserve, but gets
dirtied later. The serialized state of the folio will mark it as clean.
After retrieve, the next kernel will see the folio as clean and might
try to reclaim it under memory pressure. This will result in losing user
data.

Mark all folios of the file as dirty, and always set the
MEMFD_LUO_FOLIO_DIRTY flag. This comes with the side effect of making
all clean folios un-reclaimable. This is a cost that has to be paid for
participants of live update. It is not expected to be a common use case
to preserve a lot of clean folios anyway.

Since the value of pfolio->flags is a constant now, drop the flags
variable and set it directly.

Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
Cc: stable@vger.kernel.org
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 mm/memfd_luo.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index ccbf1337f650..9eac02d06b5a 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -146,7 +146,6 @@ static int memfd_luo_preserve_folios(struct file *file,
 	for (i = 0; i < nr_folios; i++) {
 		struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
 		struct folio *folio = folios[i];
-		unsigned int flags = 0;
 
 		err = kho_preserve_folio(folio);
 		if (err)
@@ -154,8 +153,26 @@ static int memfd_luo_preserve_folios(struct file *file,
 
 		folio_lock(folio);
 
-		if (folio_test_dirty(folio))
-			flags |= MEMFD_LUO_FOLIO_DIRTY;
+		/*
+		 * A dirty folio is one which has been written to. A clean folio
+		 * is its opposite. Since a clean folio does not carry user
+		 * data, it can be freed by page reclaim under memory pressure.
+		 *
+		 * Saving the dirty flag at prepare() time doesn't work since it
+		 * can change later. Saving it at freeze() also won't work
+		 * because the dirty bit is normally synced at unmap and there
+		 * might still be a mapping of the file at freeze().
+		 *
+		 * To see why this is a problem, say a folio is clean at
+		 * preserve, but gets dirtied later. The pfolio flags will mark
+		 * it as clean. After retrieve, the next kernel might try to
+		 * reclaim this folio under memory pressure, losing user data.
+		 *
+		 * Unconditionally mark it dirty to avoid this problem. This
+		 * comes at the cost of making clean folios un-reclaimable after
+		 * live update.
+		 */
+		folio_mark_dirty(folio);
 
 		/*
 		 * If the folio is not uptodate, it was fallocated but never
@@ -174,12 +191,11 @@ static int memfd_luo_preserve_folios(struct file *file,
 			flush_dcache_folio(folio);
 			folio_mark_uptodate(folio);
 		}
-		flags |= MEMFD_LUO_FOLIO_UPTODATE;
 
 		folio_unlock(folio);
 
 		pfolio->pfn = folio_pfn(folio);
-		pfolio->flags = flags;
+		pfolio->flags = MEMFD_LUO_FOLIO_DIRTY | MEMFD_LUO_FOLIO_UPTODATE;
 		pfolio->index = folio->index;
 	}
 
-- 
2.53.0.371.g1d285c8824-goog


