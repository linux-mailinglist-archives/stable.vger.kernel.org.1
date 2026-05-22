Return-Path: <stable+bounces-253698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBjaIEH3D2oTSAYAu9opvQ
	(envelope-from <stable+bounces-253698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 08:27:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AAF5AF7B9
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 08:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0CAE301DEFB
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 06:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325F133F58E;
	Fri, 22 May 2026 06:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cud0EFLF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8E3E47B
	for <stable@vger.kernel.org>; Fri, 22 May 2026 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779431228; cv=none; b=UdDhG5ZL6gg9PltvCzJfqrodfSX6EPEquV7qUQeExgdXFcoEyjDVfHOdJs7VJ73S962a6nl+6iJnfY3dBvyDVF3If2F/zcBHuHnFuprM+848vmQoLH3pwhA4+YDshF5eVkNhT8KW8oR6C0UaOgUlmX1f85N0ZaYZ7Q3H8drBlb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779431228; c=relaxed/simple;
	bh=qkE9eLDNCvElBpBJpSA9Pv7dV1uNeBwAPHBmQOSWzaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlct/g7lwIu+O/lK3ZN4Sf6nlwmcAZyw0Ik+tYMhGqSxwBwhejvQxbr378f77WEdtTUSPuYYuaVj4zu2lP4d2hD4neGdNS6pJncqK9NrpUHHXey1+xqmSlkuwUO73aNe7Th+nOCu+j0hfecoViSRRlSztgif/T3jYXNM5WHamcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cud0EFLF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba17c8cfacso68632895ad.2
        for <stable@vger.kernel.org>; Thu, 21 May 2026 23:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1779431227; x=1780036027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YdtJYhJK7/PxyZ+XkjgH1lwtc20KzI5A/QEO0gs3i1k=;
        b=cud0EFLF1LyAQao+gTpH2AeyISamt3ufAgHAA1sUHzm1ZSLp1/VIQDerYJRi+kmMDV
         m8l3ROsKmX/3L0NfJPa8lFpWYmP+WK6s0aUOB/QdI7gcKO9+8AXRhYxePMxX2rvRjmqG
         GZPeq7HZdKtdMi0bur9XN58x8QqmhPn+BhxWop3jj6ntrXNt0Tf1KXYIONLZ1m6k1NAI
         rc8CCLKJ/0oBD9YDyep/RP9ZNxk5tSzZZ3H8xeYbM3x+WDyq3QwuQkRQI8kFbGl6kn/Y
         HC4xa8LR4fYRytAUZz02T1P6yYOXLDE9/51T3E3OMN2huj31rQPRvTDA1n2sZxnXdI0N
         GSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779431227; x=1780036027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdtJYhJK7/PxyZ+XkjgH1lwtc20KzI5A/QEO0gs3i1k=;
        b=CV1TEb+ZeJ1LQhlawMlwNYeWaiADXH+nBrJXkgrhRvqFBX2NfkYkr8OIb8BrNYNUCF
         PTm5g1gAOSRwj/2ToHjs/MfQQeI7YcZOiRCUpEIjgpjlK7va2i3MpNQ5qjkMISzpt+Lq
         Ixixcw/9cSCUdgxgbIRY5N7NEat8mfZkrKMJYV7jc2FXW59HOv3/3E4LXeRQUEHP/QJE
         YN1zoPMD+OfFnnvnbHkO6bPD1H/dNDfhOpHrwR5kfUF5/cv2QZcpSTq3b7sBrGBB+Vjy
         XtnPvOAvhc/gs4OuCO5FmTiio4/ovgzgPnGCCkLcQo7xtKdhCNXhfylsrMSrAgrrA09u
         12GQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kdLsgsH5NsYYKzoOgiL4U5jiM8Is95Riyfhy0Poq4cPHvgkVB3j1nLI/QL1Gx2rfYKNN7f7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywugg15nSFdMg4T5F8hPmXQDITJF8pAT4VquGfdoD92VsHfHmlM
	+RY1GVzStbv/m3dWchoNNzVvHSBXRguCbLVRQAYMXtPYUKmODUUjO4QopxcdIpvO+pM=
X-Gm-Gg: Acq92OFQl2rnmQGJg7rPAldbPkUegoIyq26bwZfourwVpZGNGyxnn2Nnbdw4lxIyumh
	0goHHUHhIGxppX6y+Po38eR5V2Ux6Zf4xj+RMoRUBXGcer9htvL04smdS7EZ3AeAp5wmelIQ9du
	F/9iC8V6W5BHfNx13nxo90WjrV0vMY8W2DMOvNBlGkdEob/9sLcB6aseew/vR2rWrK2sXjNoY/4
	iKalXGUvGnM+hIpIXU82kvM6F/kJtapgoYInYNEdbhiqWVySobuAd67klKfUcJZ9q3Zxj1j1RUF
	xVFwK02bmW+hnqlXNhg8GzoMqPL3Gss66VSEKwrhTLcR6BsF/LtMxrz9upTElYRUf3dII14ZP6Q
	NqGs5REY3aeIeFFBFroIjMD7LpOJTk5ESDetEQyyEfjOhT+oA0ol39LahWehXvnBJrAvTCX7Q5M
	zDD1geAz8QIL9Y6P0owRZYmBfp0gXbtJ3TCofWh3i3KH4=
X-Received: by 2002:a17:903:3887:b0:2b2:ec46:dfd4 with SMTP id d9443c01a7336-2beb05e290dmr22751115ad.22.1779431226532;
        Thu, 21 May 2026 23:27:06 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58ff106sm5045035ad.74.2026.05.21.23.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 23:27:06 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Frank van der Linden <fvdl@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH] mm/cma: fix reserved page leak on activation failure
Date: Fri, 22 May 2026 14:26:58 +0800
Message-ID: <20260522062658.4095405-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253698-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F0AAF5AF7B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If cma_activate_area() fails after allocating only part of the range
bitmaps, its cleanup path frees the bitmaps for the ranges below
allocrange and then releases reserved pages using the same bound.

That bound is only correct for bitmap freeing. Pages in ranges that did
not reach bitmap allocation are still reserved and should also be
returned to the buddy when CMA_RESERVE_PAGES_ON_ERROR is clear. As a
result, a partial bitmap allocation failure can permanently leak the
reserved pages from the failed range and all later ranges.

Fix this by releasing reserved pages for all ranges. For ranges whose
bitmap allocation succeeded, use the early_pfn[] snapshot saved before
the bitmap pointer overwrote the union field. For later ranges, continue
to use cmr->early_pfn directly.

Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/cma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index c7ca567f4c5c..a30075507d41 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -188,10 +188,13 @@ static void __init cma_activate_area(struct cma *cma)
 
 	/* Expose all pages to the buddy, they are useless for CMA. */
 	if (!test_bit(CMA_RESERVE_PAGES_ON_ERROR, &cma->flags)) {
-		for (r = 0; r < allocrange; r++) {
+		for (r = 0; r < cma->nranges; r++) {
+			unsigned long start_pfn;
+
 			cmr = &cma->ranges[r];
+			start_pfn = r < allocrange ? early_pfn[r] : cmr->early_pfn;
 			end_pfn = cmr->base_pfn + cmr->count;
-			for (pfn = early_pfn[r]; pfn < end_pfn; pfn++)
+			for (pfn = start_pfn; pfn < end_pfn; pfn++)
 				free_reserved_page(pfn_to_page(pfn));
 		}
 	}

base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
-- 
2.54.0


