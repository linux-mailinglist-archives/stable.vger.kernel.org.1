Return-Path: <stable+bounces-217807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKjYE/GRnGnvJQQAu9opvQ
	(envelope-from <stable+bounces-217807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:44:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A843C17B038
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E583317999E
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ED3333733;
	Mon, 23 Feb 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwZPMv2o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67858331A66;
	Mon, 23 Feb 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868386; cv=none; b=cTC7aAr8igD0tEKVe1vzV01BwoWr85aZOS1XO2nPyH+hBLSYEe80WLJpTr14VaS+peRd+a8ukB2z3WcpV7Yv/RPffj7YEoKF/BGNnP3GLrywJwv5K54hbLLXI65m2B7Qm6txgwmpBCyEpHwfV3M7sjiVnDdYBMIWdn7zcSIjWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868386; c=relaxed/simple;
	bh=KPLMRqJNulMdw70KhDZpgFoKTEgDZfxf2vi2hDqk/Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jv2a2+t2EUfwiBQZWjLvPWJNuMq0/jE3BXUh9s53Z8DTX8RukHATjt75Y86VANhBdjmI5cslkJYu7Ok8xV2NTeLYBLMPy0lkesyQvYjg6ERtpOfzUnfU7pWJfw5D5WrBGO25CZ+2DsAws99/CIN2TdZC3Mq4sMTuefk8EOs9X8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwZPMv2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9C9C116D0;
	Mon, 23 Feb 2026 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771868386;
	bh=KPLMRqJNulMdw70KhDZpgFoKTEgDZfxf2vi2hDqk/Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwZPMv2oaRXv+q25/D5x6vlZzXflUJmjGV4pALpQJgz46CHbsuieJUiHTSaROAbnm
	 u7pmDRkPoqTELwyN5p5AbHtMTBjfrilOMgqbApDyxACq46wf1nYixFbyN9gYQdcmaP
	 VQqSgbKN1Y0UT/mklqsSts0sqKX0785iCigbgnDRLxdU7qcPyMh08y0uchYRV+2VON
	 yCIztLlF1sGjQHylJ+ueQAr0tIt1R4fnKDZq+g1VT2rDE2AkQbW9VIhB3yy0v7sgtn
	 1omxvKDF1Xt2WYMBOknNyu27Z0nuIP3JYPdG+qQ8XvqYyK6u2mpUVPn6S6C86Wsbp5
	 6dJL1sbClyTDw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm: memfd_luo: always make all folios uptodate
Date: Mon, 23 Feb 2026 18:39:28 +0100
Message-ID: <20260223173931.2221759-2-pratyush@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217807-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A843C17B038
X-Rspamd-Action: no action

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

When a folio is added to a shmem file via fallocate, it is not zeroed on
allocation. This is done as a performance optimization since it is
possible the folio will never end up being used at all. When the folio
is used, shmem checks for the uptodate flag, and if absent, zeroes the
folio (and sets the flag) before returning to user.

With LUO, the flags of each folio are saved at preserve time. It is
possible to have a memfd with some folios fallocated but not uptodate.
For those, the uptodate flag doesn't get saved. The folios might later
end up being used and become uptodate. They would get passed to the next
kernel via KHO correctly since they did get preserved. But they won't
have the MEMFD_LUO_FOLIO_UPTODATE flag.

This means that when the memfd is retrieved, the folios will be added to
the shmem file without the uptodate flag. They will be zeroed before
first use, losing the data in those folios.

Since we take a big performance hit in allocating, zeroing, and pinning
all folios at prepare time anyway, take some more and zero all
non-uptodate ones too.

Later when there is a stronger need to make prepare faster, this can be
optimized.

To avoid racing with another uptodate operation, take the folio lock.

Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
Cc: stable@vger.kernel.org
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 mm/memfd_luo.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index a34fccc23b6a..ccbf1337f650 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -152,10 +152,31 @@ static int memfd_luo_preserve_folios(struct file *file,
 		if (err)
 			goto err_unpreserve;
 
+		folio_lock(folio);
+
 		if (folio_test_dirty(folio))
 			flags |= MEMFD_LUO_FOLIO_DIRTY;
-		if (folio_test_uptodate(folio))
-			flags |= MEMFD_LUO_FOLIO_UPTODATE;
+
+		/*
+		 * If the folio is not uptodate, it was fallocated but never
+		 * used. Saving this flag at prepare() doesn't work since it
+		 * might change later when someone uses the folio.
+		 *
+		 * Since we have taken the performance penalty of allocating,
+		 * zeroing, and pinning all the folios in the holes, take a bit
+		 * more and zero all non-uptodate folios too.
+		 *
+		 * NOTE: For someone looking to improve preserve performance,
+		 * this is a good place to look.
+		 */
+		if (!folio_test_uptodate(folio)) {
+			folio_zero_range(folio, 0, folio_size(folio));
+			flush_dcache_folio(folio);
+			folio_mark_uptodate(folio);
+		}
+		flags |= MEMFD_LUO_FOLIO_UPTODATE;
+
+		folio_unlock(folio);
 
 		pfolio->pfn = folio_pfn(folio);
 		pfolio->flags = flags;
-- 
2.53.0.371.g1d285c8824-goog


