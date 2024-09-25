Return-Path: <stable+bounces-77202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18831985A15
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF771B257CE
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5BA1B2ED7;
	Wed, 25 Sep 2024 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWVc25dR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695AC1B2ED5;
	Wed, 25 Sep 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264502; cv=none; b=NEwdvCWf/SueQ/o7/QT+ePTXJ71Oj6HgKwYISQa+C48woOlUqDeQdPHXSL1Mfyl/3eiA69HFb4xoryT6h3dxjSgkGF6Sto5/wzT5mYcdrD7++PNBR+d1LklKogle+WtaTv5zStRlPYtTbkd5wJQEbpsR3Hj6cegvGTzVWzvZKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264502; c=relaxed/simple;
	bh=DnhQTcPsO4Inu1xsSAmeigbg9O6TgM6qp+qE/hcOo7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vg+1LXUx7c/LTJsgJdJZAoayFKBbkWA2kDiKPeQMMCWKewr2Z+TSGMIwE51VLnXETMfBOf/bUxd12zQkS0JBJQ0aUvSLSuuX0wOXXEdggSp2vAlr9sR7VS5XAKUZcIr+i7Q+1Z58LgfmXfYFNk3pgS+avJpeCmWeAhnAHO6aEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWVc25dR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF7BC4CEC3;
	Wed, 25 Sep 2024 11:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264500;
	bh=DnhQTcPsO4Inu1xsSAmeigbg9O6TgM6qp+qE/hcOo7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oWVc25dRaGmZNE71R1gswc1mT2UT5UIkq5VVzQC5X38b23pim3ITplAzjpfwNfq8Z
	 RNxmBYtmr1+DutUUZlnigYlBkJhOT+oyDaG6JReAcRi6uD0WWSxohQbvdqzoajDwb/
	 5nmJ8MCSY+OxLCZG+udp/tf5yQIaGhd3LoVJ4HdVMu/rjwqFMeCmHpwbFkBx4yw0Jh
	 iDpOnBTRiYM2sOGBvw/fWYDK10tYmanMF/1w73DYE8JgSWzOzDE+T0cSmzlccJ6YMX
	 czcFU3S9Tn5FR3ASMLYeKSnMEElaKhnrLURm12nkHo0dsNkThMdtrLKCBF8helVqGt
	 yaiO+Cf72q+Nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Steve Wahl <steve.wahl@hpe.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pavin Joseph <me@pavinjoseph.com>,
	Sarah Brofeldt <srhb@dbc.dk>,
	Eric Hagberg <ehagberg@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org
Subject: [PATCH AUTOSEL 6.11 104/244] x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
Date: Wed, 25 Sep 2024 07:25:25 -0400
Message-ID: <20240925113641.1297102-104-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Steve Wahl <steve.wahl@hpe.com>

[ Upstream commit cc31744a294584a36bf764a0ffa3255a8e69f036 ]

When ident_pud_init() uses only GB pages to create identity maps, large
ranges of addresses not actually requested can be included in the resulting
table; a 4K request will map a full GB.  This can include a lot of extra
address space past that requested, including areas marked reserved by the
BIOS.  That allows processor speculation into reserved regions, that on UV
systems can cause system halts.

Only use GB pages when map creation requests include the full GB page of
space.  Fall back to using smaller 2M pages when only portions of a GB page
are included in the request.

No attempt is made to coalesce mapping requests. If a request requires a
map entry at the 2M (pmd) level, subsequent mapping requests within the
same 1G region will also be at the pmd level, even if adjacent or
overlapping such requests could have been combined to map a full GB page.
Existing usage starts with larger regions and then adds smaller regions, so
this should not have any great consequence.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavin Joseph <me@pavinjoseph.com>
Tested-by: Sarah Brofeldt <srhb@dbc.dk>
Tested-by: Eric Hagberg <ehagberg@gmail.com>
Link: https://lore.kernel.org/all/20240717213121.3064030-3-steve.wahl@hpe.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/ident_map.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index c45127265f2fa..437e96fb49773 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -99,18 +99,31 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
+		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		if (info->direct_gbpages) {
-			pud_t pudval;
+		/* if this is already a gbpage, this portion is already mapped */
+		if (pud_leaf(*pud))
+			continue;
+
+		/* Is using a gbpage allowed? */
+		use_gbpage = info->direct_gbpages;
 
-			if (pud_present(*pud))
-				continue;
+		/* Don't use gbpage if it maps more than the requested region. */
+		/* at the begining: */
+		use_gbpage &= ((addr & ~PUD_MASK) == 0);
+		/* ... or at the end: */
+		use_gbpage &= ((next & ~PUD_MASK) == 0);
+
+		/* Never overwrite existing mappings */
+		use_gbpage &= !pud_present(*pud);
+
+		if (use_gbpage) {
+			pud_t pudval;
 
-			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;
-- 
2.43.0


