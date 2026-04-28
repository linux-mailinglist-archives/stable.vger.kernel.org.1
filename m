Return-Path: <stable+bounces-241492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPc7HMdu8GmgTQEAu9opvQ
	(envelope-from <stable+bounces-241492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:24:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D935347FF82
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7E8C30684C5
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A963CFF41;
	Tue, 28 Apr 2026 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bnbZl8YO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBE3CF041
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364356; cv=none; b=LUaPUxcTGTSuha/0SWBISFA4kzKdomP3a28ZyPtBAhLGpao4+pGnh+xM/6VuwFzH3qFZLioWTjjA/34FNoLLpAirlDRXoCk69F/oZiiv2r4s5o2LcyFYwY+K2FpeCdZdBXW6IwVq4Q5PWuTrIEpMeifNXSGXtAOX9ZBOPnGOYz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364356; c=relaxed/simple;
	bh=T4yKhyHGB1poxPphLLlyVRDB+bCKixNLLBGYdEPxJas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RneErVeLDTdPiFVDrjdnAVM/bCN2cdIM0/QPLjhoiUSBL+WzshZ4c05AfFXDNoqwore1/wynmsNCe0rMVgGijpOkXJx2ACu/J2QdR+I4JgofKswH69fYAmpmG0yXGoT3mAlXqrmTQENQmbaHnGnltBEJpUBB4ph4YX6uDhPRupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bnbZl8YO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35e576110adso7696324a91.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777364354; x=1777969154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM345nkBQh5gaxmYsV6Qr69X0RaLtEwieY1kCbsL1/U=;
        b=bnbZl8YOqfGj4yJfTP1VKSpo3Bb1/YLehDdTWm89VE8SAisnzo2OAtnVpDOsWfCUsa
         R0XUYMjnPSPcNUfrHT1iE4N/TLlYoSoBArRBTgMCM8a3EU4xlk2wizncVp02N9QbYUGG
         xIpqxNPrwodmjI8CxSSzgKZ8B68HCCRgzpRxvjYNWGXSP9MfV9/Hlg0xrNmwms8HH1Tb
         FViZ5/MyJglwS1wkvqO0d4VdFsTNpOCKLWBDV38DSlnVktBVfi/5rboj5wJkJ8tfjifT
         jV6+vI/1OUcOqHK+lIlDJfBI2DQQMfmdQLnOYVvjyMiBmzsXuIAGJG0Y5DfTTaEe+MbK
         Tj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364354; x=1777969154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HM345nkBQh5gaxmYsV6Qr69X0RaLtEwieY1kCbsL1/U=;
        b=FyJcuzI4XR792OuaUGOOvaEjbh10RMxPpT8mYATwwmUVg0akdHlkcCP0D2J0sKZCJO
         45pMrAUdAzO9tqOwv1mt+pCzYW/Nv9KhFCKd+brbgiO7gBtV8jUtjmYqKsN+hpQIQv+s
         wazAdfsIAf7oXpkoBo6WZoglKOYqEHjO4D2sd2wqtiuNkJMMf4NLl4Jx0Uun2xVznCz2
         f3FU+wV1miYwXOVSDX703i9jKm3zlhnigbW1n3suklC4Ejpbkw+nODLUjZ+byX+eJLqd
         W/SVLwUS7RJO1tjKPjm//PmWj32FGtEL7fh08CNi2sCpH+cmDbBgLBye3Ls7Dkkpu5U6
         v5Yw==
X-Forwarded-Encrypted: i=1; AFNElJ+ul1BzDpBTPtsMnfvXjtoaxe+9cGP8o5fakEBjtgyNVAwwWpiS+knIb1KmjR51hb9PgDeMtQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2pcRUxDeLqn/UkotE3aSdpn7LYQOQdFNE2gDp/YEusPr/bv2Z
	b0rwbSVkrhQ4O7madR3NTt6F6DHraqbysiUQtN0PkYvotLR/eGoi4FD0h+k+mop9J4o=
X-Gm-Gg: AeBDiesOumz3lp6bbcMoK6JqH17Fm3B489jKvcHXJKR6kQq1vya8WlEYUU1lMY5Fywf
	l1Jqh8mJkoI3rBMafrmUW1fbkk8nA0j0r0mgOt2wlOvlPBfglh9B8FbbLBTWLGsL4jSmNEUMqAx
	NdN75CvDa0NBOxK40t1NdSwG8iqs32ggyN0/dZK7u8U2eSxqLn7WJ963XClo2PnpOxiT+w3bbr8
	VcZ0wGLPIlgqw6pfGjqA+JyLxeYuVlod7VwWvtt8h+C6I0ePjHw4nqMwAMR6gY/Ru0VJ2b2IUfr
	P4TnUOLwoUSqWIKkTMAjYhAiQMmYmvtFy2HxitS/leToDAR4UaAZ+ih893DcV/mXrv4vHXUGCRF
	aLsvB3C2Lye/XQduRcGWCksflXaOCAum4o2EVUHsfMtWMC0xuqtTl9BO2QYNjDm4Q5s84KRu6e9
	RSBx+34epVX7yz1qa2yAR5ic5wVZN1a+cfNdCgczCFfs2JmtIB+Wn8fZc=
X-Received: by 2002:a17:90b:5804:b0:35f:b230:5889 with SMTP id 98e67ed59e1d1-36491ccd608mr1594024a91.6.1777364354086;
        Tue, 28 Apr 2026 01:19:14 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3649003650esm2181356a91.8.2026.04.28.01.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:19:13 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 2/6] mm/memory_hotplug: Fix incorrect altmap passing in error path
Date: Tue, 28 Apr 2026 16:18:51 +0800
Message-Id: <20260428081855.1249045-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260428081855.1249045-1-songmuchun@bytedance.com>
References: <20260428081855.1249045-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D935347FF82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,google.com,suse.com,gmail.com,linux.ibm.com,kvack.org,lists.ozlabs.org,vger.kernel.org,bytedance.com];
	TAGGED_FROM(0.00)[bounces-241492-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bytedance.com:email,bytedance.com:dkim,bytedance.com:mid]

In create_altmaps_and_memory_blocks(), when arch_add_memory() succeeds
with memmap_on_memory enabled, the vmemmap pages are allocated from
params.altmap. If create_memory_block_devices() subsequently fails, the
error path calls arch_remove_memory() with a NULL altmap instead of
params.altmap.

This is a bug that could lead to memory corruption. Since altmap is
NULL, vmemmap_free() falls back to freeing the vmemmap pages into the
system buddy allocator via free_pages() instead of the altmap.
arch_remove_memory() then immediately destroys the physical linear
mapping for this memory. This injects unowned pages into the buddy
allocator, causing machine checks or memory corruption if the system
later attempts to allocate and use those freed pages.

Fix this by passing params.altmap to arch_remove_memory() in the error
path.

Fixes: 6b8f0798b85a ("mm/memory_hotplug: split memmap_on_memory requests across memblocks")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4426abb05655..e3352284f635 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1469,7 +1469,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 		ret = create_memory_block_devices(cur_start, memblock_size, nid,
 						  params.altmap, group);
 		if (ret) {
-			arch_remove_memory(cur_start, memblock_size, NULL);
+			arch_remove_memory(cur_start, memblock_size, params.altmap);
 			kfree(params.altmap);
 			goto out;
 		}
-- 
2.20.1


