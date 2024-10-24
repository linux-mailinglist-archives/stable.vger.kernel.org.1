Return-Path: <stable+bounces-88088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62D89AEA02
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 17:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA992819FF
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781081E1311;
	Thu, 24 Oct 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w4NtCV+1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cHtBXh6T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w4NtCV+1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cHtBXh6T"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF91C8788;
	Thu, 24 Oct 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782771; cv=none; b=pR3zFN7PDpMBLpCeTzajLO4I32DvzIwBBrBXEvP5V11F4t3olqOEX2ya0bEVcy88YB2eCnqG77XCL2uApDXwFlwIfxxWOExq72t6WdtKQBBFAeZy7CXnc9gPJinZXx3yFe2hTeD2nRa79rfrsEiev242eQfy7AtlKJu3IxFAk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782771; c=relaxed/simple;
	bh=e5yZyDC8w+nQLKP9TChVKzM2wtrTM52rx9LU0Oy7c7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmwRW1P+kgho4W7FxUci6HLg57qp7Ht6v1MUDlBrVSCJVPzYauu3CsCUaRePEV/lzu9aG3cZAWuomvphyS/PuIyf4Ogc6lw/AKA9WYCsbHKM1TMsrxsXXf7KXbwF0bQ8B0hHNTNFExKlOp66hX2pbqGXkGCymnkU+C9xz/2VA+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w4NtCV+1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cHtBXh6T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w4NtCV+1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cHtBXh6T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 241C722153;
	Thu, 24 Oct 2024 15:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729782765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3E+SnM9nTIdJirG48OGIur8Xm4drVI2DTc9+V4rDTS0=;
	b=w4NtCV+1PXhRANojgclEsLkM44CgDPAFrn96mLtWcW6qnRmFTQKcozW1Dz7vlMgENemK/1
	cbV3ECymKdxQxrNLrGkmtsu+/+m0Hy9fn7Kd4TWpDdtmG4UHdJ3TX9/KjUuFfNsak5mhin
	xjo7jbcztY8JT360seRaAhz/26JC8io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729782765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3E+SnM9nTIdJirG48OGIur8Xm4drVI2DTc9+V4rDTS0=;
	b=cHtBXh6Tz4HByMzeg7ITW0IwfohzkLaV6JNhFogCv4LeQf2cc666QVxm6eU4aBKNHkSp5l
	A73bdgqmmvZl+/CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=w4NtCV+1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cHtBXh6T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729782765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3E+SnM9nTIdJirG48OGIur8Xm4drVI2DTc9+V4rDTS0=;
	b=w4NtCV+1PXhRANojgclEsLkM44CgDPAFrn96mLtWcW6qnRmFTQKcozW1Dz7vlMgENemK/1
	cbV3ECymKdxQxrNLrGkmtsu+/+m0Hy9fn7Kd4TWpDdtmG4UHdJ3TX9/KjUuFfNsak5mhin
	xjo7jbcztY8JT360seRaAhz/26JC8io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729782765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3E+SnM9nTIdJirG48OGIur8Xm4drVI2DTc9+V4rDTS0=;
	b=cHtBXh6Tz4HByMzeg7ITW0IwfohzkLaV6JNhFogCv4LeQf2cc666QVxm6eU4aBKNHkSp5l
	A73bdgqmmvZl+/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 076881368E;
	Thu, 24 Oct 2024 15:12:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d4UWAe1jGmcDPwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 24 Oct 2024 15:12:45 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michael Matz <matz@suse.de>,
	Gabriel Krisman Bertazi <gabriel@krisman.be>,
	Matthias Bodenbinder <matthias@bodenbinder.de>,
	stable@vger.kernel.org,
	Rik van Riel <riel@surriel.com>,
	Yang Shi <yang@os.amperecomputing.com>
Subject: [PATCH hotfix 6.12] mm, mmap: limit THP aligment of anonymous mappings to PMD-aligned sizes
Date: Thu, 24 Oct 2024 17:12:29 +0200
Message-ID: <20241024151228.101841-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info>
References: <2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 241C722153
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Since commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
boundaries") a mmap() of anonymous memory without a specific address
hint and of at least PMD_SIZE will be aligned to PMD so that it can
benefit from a THP backing page.

However this change has been shown to regress some workloads
significantly. [1] reports regressions in various spec benchmarks, with
up to 600% slowdown of the cactusBSSN benchmark on some platforms. The
benchmark seems to create many mappings of 4632kB, which would have
merged to a large THP-backed area before commit efa7df3e3bb5 and now
they are fragmented to multiple areas each aligned to PMD boundary with
gaps between. The regression then seems to be caused mainly due to the
benchmark's memory access pattern suffering from TLB or cache aliasing
due to the aligned boundaries of the individual areas.

Another known regression bisected to commit efa7df3e3bb5 is darktable
[2] [3] and early testing suggests this patch fixes the regression there
as well.

To fix the regression but still try to benefit from THP-friendly
anonymous mapping alignment, add a condition that the size of the
mapping must be a multiple of PMD size instead of at least PMD size. In
case of many odd-sized mapping like the cactusBSSN creates, those will
stop being aligned and with gaps between, and instead naturally merge
again.

Reported-by: Michael Matz <matz@suse.de>
Debugged-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1229012 [1]
Reported-by: Matthias Bodenbinder <matthias@bodenbinder.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219366 [2]
Closes: https://lore.kernel.org/all/2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info/ [3]
Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
Cc: <stable@vger.kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9c0fb43064b5..a5297cfb1dfc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -900,7 +900,8 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 
 	if (get_area) {
 		addr = get_area(file, addr, len, pgoff, flags);
-	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
+		   && IS_ALIGNED(len, PMD_SIZE)) {
 		/* Ensures that larger anonymous mappings are THP aligned. */
 		addr = thp_get_unmapped_area_vmflags(file, addr, len,
 						     pgoff, flags, vm_flags);
-- 
2.47.0


