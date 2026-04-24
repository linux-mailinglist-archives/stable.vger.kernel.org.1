Return-Path: <stable+bounces-240552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OH0Cx3c6ml8EwAAu9opvQ
	(envelope-from <stable+bounces-240552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 04:57:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6748459394
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 04:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BE2830158BB
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 02:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C484312831;
	Fri, 24 Apr 2026 02:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YajlZVeG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5630F806
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776999373; cv=none; b=MDBlgV6TvsRu6SI4Ws5/Oq8gBzygQmzb4J54JXYBBC1GaWOgklN7rH6672q3Jo+xWmvMblJQL7NJ21lZSvGcE3vzGtyVzXCBLC/WNM0+l3fADnppnO11vongstI8DO03dfi4lbisYGT6ZqfniIXsT4XGzYD4/knb/npfL8Vjv8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776999373; c=relaxed/simple;
	bh=9/CO8vx+V21oREl0OLJTEhDPgpJAF4/FGvx8E6oUzqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FI+PxQG57ynor2k5J/vOKZLTlqSbqFXA8qCK1KLypnAJ2PeXLjQ4eTnMtwElIr/7ql6xsYmzs3LlAYEugJqqIjmHF6s4oqQ2eTvKS/LXMgqECpLCVF3zXG27soqdFY2nSWTLxBv00cHhEXY3AXUi9IZu3+1QvQQSSveONk4jwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YajlZVeG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad9f316d68so33165935ad.2
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 19:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776999367; x=1777604167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4lJZQuHOoBwkCuOEzBR659IeprHDGyqMQmHH4+zCQA=;
        b=YajlZVeGPbLCqOu7hK93QpTyZSoew7cPPZGJfWl7a64Xb574NRIPwRSnStqUaju0Dd
         0jsz7wlhHYY5NP4kO9SjHW0TcXJgNZ+UVzKLwI/eGC5C+MECd5CaBXZHkZwDR7R4tqt0
         0ybRCavX/4k7Nu3NKGzy2YjqU0GfB2Hd7r5YG3gRGaCvO826MHyTa4NtmphhQaQZFiJU
         ElfcDRNsoPVt3bIERTF8CEzqNEFMxUIEWfr/Fh/syNz3nJpTNBNwDInFv/yP2x72l5+a
         XZe2eiEuk2M6wa22c8boqtumYs0pJPyeJXjcjx660PPNvXulAREtHQsC1DRdh5M1/aIU
         L4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776999367; x=1777604167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4lJZQuHOoBwkCuOEzBR659IeprHDGyqMQmHH4+zCQA=;
        b=JYJS/ogNB027nyFVMu6aNpABsNLCSSd9vRo/RDe+72PLC/6dFl/qxbdoJyHov3Rdik
         LM0TZvDoiyFdE1ynCEYdQsBYJHRrnVdVWe9/SVg2Vz8xlaP4WNJ7tdp60Ty3MIw2BXeS
         kFnhVR87hkYmojPruac82wOvDVcylV48J3RjxMdQWqv90Etls8lRBTfPoOGUr8hajOVF
         LjGd8z/9fKtuPU9Gu5kyqQ1zhQl87f04KF5U2tM0GqayROiizqFukdhuUTSjiZzU4U8/
         2O+9tTmaYxthidcCQ2ezFWfwoiBwvjCluoJRdzK5MbbolkQv/ybJmz923WsIjPyESBK+
         +tnA==
X-Forwarded-Encrypted: i=1; AFNElJ/6d2TBRitdCxV3kN2PS5I2QFBTHHMIOoAa4OmNRxOOPWxMf1gmIn1Abz2IblipX4TcE7METMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjiuGGPdkF1Pvc03YNNl2mNTrLQvUiLpqQ4V3RUl17JG1rI+ZU
	w5viuG1Z4vf2O4uB02q/DWLPfWwgxYNll4+0+lTD5FscYa1ptgeRYClSUtT3UWH67mo=
X-Gm-Gg: AeBDiesVdhL/y3BzLn/2Y3DYpni1iczi2QpPsVJzL/mgCaRsdwGITgd33m95/8rmD72
	UAaTDn78WY1AHXXIOif1lsaDXW72plbqK2MZW25WAiqVsleqp55Bufs406afoDZI+4RHdMOEVy/
	4QD8ritDwqTUl3x3JiMxQJdW1NKx4nCHh/igW5I/+qnSROeOXuEsd1yB3eWY1wds7+6gIm5aHNc
	b49UyTR2ggNeDYkAiqlbLPEGlf16JJTojsc16fRPR4LYLaNWoXm++yizSdpnqzo0LJM13RaWEoK
	c4wJF6wIgS9VwWfPWPdcjLYi134QbEsOJqf/Slu/z5PKnlncaj8kKb3VOoN1UtqR7dsP98BvkvH
	4NKgjipfkb8UqVQZlJDmP1pA8frhCN181nWQJ2SeMivXRdN/Pqz7oa6Pd5UHKh+kwayQJbGefaq
	LHwRIuW52d46a1It2xNaNbVPj0sc4C0NW/jMzvpoDXtQcswut3aTt+drM=
X-Received: by 2002:a17:903:2412:b0:2b2:42f8:1a4b with SMTP id d9443c01a7336-2b5f9f3a987mr327922445ad.27.1776999366531;
        Thu, 23 Apr 2026 19:56:06 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20d33sm221668325ad.63.2026.04.23.19.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 19:56:06 -0700 (PDT)
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
Subject: [PATCH v6 2/7] mm/memory_hotplug: Fix incorrect altmap passing in error path
Date: Fri, 24 Apr 2026 10:55:42 +0800
Message-Id: <20260424025547.3806072-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260424025547.3806072-1-songmuchun@bytedance.com>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C6748459394
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
	TAGGED_FROM(0.00)[bounces-240552-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:dkim,bytedance.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
index 2a943ec57c85..0bad2aed2bde 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1468,7 +1468,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
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


