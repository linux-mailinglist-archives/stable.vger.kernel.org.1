Return-Path: <stable+bounces-213325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDEXE1aSgmmhWQMAu9opvQ
	(envelope-from <stable+bounces-213325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:27:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD053E0025
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 01:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3F0630A9AF3
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 00:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36E19D074;
	Wed,  4 Feb 2026 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3apMHEH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB7128816
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770164817; cv=none; b=Kn+ciYweyU253qVCYs+yo+khRJm25bXoZ0Hk+WCMGedSf9W/wCipnnJzvHgeh73Tu+HA5GDprfZ+ia6fWb3iTN3twWVfuAZj8mBlvhs5dNgQv3RG+GkrfIaCgkuh6P2QBAFH19ci1tqH+Jx1lWFR/2EzE8FhMatlS4GK7myvm58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770164817; c=relaxed/simple;
	bh=ZaNh73bMrH03v3eiBU4NbNgedfqZllF6g41hr77c8n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+mZlPWulomKuSHNld15ltZHSUdqtPsmLRYMlE9xcsP3IYvICaZ380ps9zqO+8vq/qIs3Khnirypg/pq7zMhoHXeg1CqbXmPDylMMK8mC/cNS/xqYgGjHHaugy2XarNfEQoSE/6iT9HKOASktEkABA7TkWCjLOVeDMdyiLUSeDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3apMHEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040BBC116D0;
	Wed,  4 Feb 2026 00:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770164817;
	bh=ZaNh73bMrH03v3eiBU4NbNgedfqZllF6g41hr77c8n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d3apMHEH1F2PY6tkCT6ZsmrPG7OTHcpyeXeBqjbWDds82bWhjmu6PAHF3mlxmp4Lm
	 mVoIam84aOkFFEmeWrzF99/DBhDmZT4pq/kXYtZmr/GAVOZ2BLQXci96Uj73M+KRRr
	 mnBRghK4kZFCcMaLK9jJJRqlQiAljg1tsQZhSYx2saBcCvqORb5EnA4QXszYnLKgsB
	 GgCokPK9P1UMwnDAp5IdjjR9YcA+HSZgw2fFEtCGZ9cC1ComgaR2nlTrt0Ml4/osFc
	 /ByPehIBth8v4jzgCuyfY96yJp3V50NwQGPpBSrj9swxaGJB5tgiiOsSTV9mw/N+gH
	 xuLY1eRUDVkjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] kho: init alloc tags when restoring pages from reserved memory
Date: Tue,  3 Feb 2026 19:26:54 -0500
Message-ID: <20260204002654.1462558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020303-drippy-appliance-a74c@gregkh>
References: <2026020303-drippy-appliance-a74c@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213325-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: BD053E0025
X-Rspamd-Action: no action

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

[ Upstream commit e86436ad0ad2a9aaf88802d69b68f02cbd1f04a9 ]

Memblock pages (including reserved memory) should have their allocation
tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
released to the page allocator.  When kho restores pages through
kho_restore_page(), missing this call causes mismatched
allocation/deallocation tracking and below warning message:

alloc_tag was not set
WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260, CPU#1: swapper/0/1
RIP: 0010:___free_pages+0xb8/0x260
 kho_restore_vmalloc+0x187/0x2e0
 kho_test_init+0x3c4/0xa30
 do_one_initcall+0x62/0x2b0
 kernel_init_freeable+0x25b/0x480
 kernel_init+0x1a/0x1c0
 ret_from_fork+0x2d1/0x360

Add missing clear_page_tag_ref() annotation in kho_restore_page() to
fix this.

Link: https://lkml.kernel.org/r/20260122132740.176468-1-ranxiaokai627@163.com
Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kexec_handover.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 03d12e27189fc..db08c1a2e1f80 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -260,6 +260,14 @@ static struct page *kho_restore_page(phys_addr_t phys)
 	if (info.order > 0)
 		prep_compound_page(page, info.order);
 
+	/* Always mark headpage's codetag as empty to avoid accounting mismatch */
+	clear_page_tag_ref(page);
+	if (!is_folio) {
+		/* Also do that for the non-compound tail pages */
+		for (unsigned int i = 1; i < nr_pages; i++)
+			clear_page_tag_ref(page + i);
+	}
+
 	adjust_managed_page_count(page, nr_pages);
 	return page;
 }
-- 
2.51.0


