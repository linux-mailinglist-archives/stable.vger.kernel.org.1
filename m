Return-Path: <stable+bounces-241162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOiBGX7a7WnGoAAAu9opvQ
	(envelope-from <stable+bounces-241162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 11:27:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC05469429
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 11:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A1EA30067A2
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9782E31F98D;
	Sun, 26 Apr 2026 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hWvnjP+G"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B004342517
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195639; cv=none; b=I16xr+R6csQkGWOLeO/uFt68Pnxq233VWzrGmYbnskyO3njX6YHj3XUxYvquGFUU4R0SM53HfroVLfRbpYrjty8w4vQpjzar8fLG85YwXO+TvrwIvVRhHIR/BC7pqfTT7VKqHdezH+AkMoGSoqmplYl/aa8RPIKH0ezI1oOdV8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195639; c=relaxed/simple;
	bh=9/CO8vx+V21oREl0OLJTEhDPgpJAF4/FGvx8E6oUzqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d2c8av0pAjbdBdqysHqgHCLzvWIGkaQGV4uLsjeRMNdlaX34vyFpBXWyfwQLQX/LjufsH3pe1+iIDEJ/frA2Ml8Q0Q6vIRzuHy0vcApL44yv8LQeGv2n7H59RZPx47hGakrMr36aNim+ybjnLnPyywDhAByRlWeRcUwAmjeZ6lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hWvnjP+G; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b23fcf90b2so88169245ad.3
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777195637; x=1777800437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4lJZQuHOoBwkCuOEzBR659IeprHDGyqMQmHH4+zCQA=;
        b=hWvnjP+G6aiArIbv0+lIuyeJK1VuZ47oP7cMAVqTfF4J3vKJn+cJCsD+9HEnH1pPET
         dIdZdmsmzOf9Ds3XZTvJ1+tIslu6su9ZZN/aUubs6xzRU/BG7cF4gltYOKEudK4AvrVt
         H8Dlqp+pBKQlIOfVVh/9XFRiOB0Yn2Wy8u/FuSEUhP92y6Qs9AIg8S6sD3/nVLvfnprc
         sCXerimm/IYL9G6PnP8i+Pmlm5lnLf4zvOn57BB35nlHGlDKUBzSFVXgUGPGL7nwQ2e0
         TucobcaoQcQsGSPzshMDWdSwnwgMSnKgMlspzT9EMcQGHoj3OiEt5QiK7ApuFU4XB4lU
         Q1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195637; x=1777800437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4lJZQuHOoBwkCuOEzBR659IeprHDGyqMQmHH4+zCQA=;
        b=pnYdrhTXocWJiSFEXTOcoM0k3rvPtJGP/S+TAFmzFvHxdcopkYgquqVZnE7Z1Y4cTG
         vDwSAuZyH3PJ4Z9PofIAD5y+WkHAs5r5PmtJsu6Y9W2cNlSU0kNiD7aMAg2EBqPPBJ65
         BMLjar2EmhfRmeheu1KXuewxQLJeaGJBpbZOe8pdc+3CC6R3uDcKAapaobdsQcTlm+JO
         5t/QwAG5pSbVcVY9/+Bs9tzrOfPGavZGw30PtY0pc3jdE/txvqP49Mp169vH8VlP9H4Q
         hi+l2eUApX5QYAciAa2QTU/59VV08kDS5DMBCWKKYZoB+3OreXbUVSnFQPAkmjkNyOGM
         NZuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/c5P3DBY/prSk7AZlQF5nHfPHJixt6Hv6r43Gsqenhe/vP3nU1gA31k3Gmmj6VCetfbzpeUBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YywqY2GT6o8LPi8cQurCQeBuawgvhEXAnYQbBtkfEJGHPyeIqOa
	bkUYZQ1YtL2bXbSv28k7zMUExtR4vrD6ZsfQrh7CMeRuXFfuOX7olIRC8L/hQCSxax4=
X-Gm-Gg: AeBDiev1nZlJXlqQThp3xCdY7xuxlrzw4r25Tqr41tpbzsaCCmUmV4AwHBJZs5iChIS
	0bq/Fl0MG3mI82SZx0BpF5nGu1haQ0cj1xEr+sg6iW+BMLFDuR8ciYWwbzlmizQat1YHB51pZmF
	bqL3OunC2WYDlIvMImSvur8ZpqIhwE5zmEOFbZOYL88N0imBot8DhT8jUOKsLYSrUjfBin5Wdv4
	i2LHoWakbmbrx/uAps0Sn67EQzcatRHq9tDqjU/XM7rc06XNfhH0/5G816HkR/oGXKvOYmyrw2P
	QQ9FJKN3DguAkEzZvBnwZBj++wiPRjEFwXrmIwYpmhcRtKnXaYTTc5l+Vc59KDIkeJrwGcFqR9w
	AKqVvuS7GCVAI/DEeH+SDh/ZcFUTwcAdmQECVJLnQ6WQyGRP4y9GFvkQyJ3zK8p3erclzaIN2/C
	/MPo3RPF0sok9pSbmxcKUy5cyzjM3l
X-Received: by 2002:a17:903:37c4:b0:2b7:abc0:3bd7 with SMTP id d9443c01a7336-2b7abc0448fmr145875755ad.9.1777195637394;
        Sun, 26 Apr 2026 02:27:17 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caa9sm270352885ad.40.2026.04.26.02.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:27:17 -0700 (PDT)
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
Subject: [PATCH v7 2/6] mm/memory_hotplug: Fix incorrect altmap passing in error path
Date: Sun, 26 Apr 2026 17:26:36 +0800
Message-Id: <20260426092640.375967-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260426092640.375967-1-songmuchun@bytedance.com>
References: <20260426092640.375967-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EEC05469429
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,google.com,suse.com,gmail.com,linux.ibm.com,kvack.org,lists.ozlabs.org,vger.kernel.org,bytedance.com];
	TAGGED_FROM(0.00)[bounces-241162-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:dkim,bytedance.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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


