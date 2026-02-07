Return-Path: <stable+bounces-214801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFiyBHxch2n3XAQAu9opvQ
	(envelope-from <stable+bounces-214801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:38:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B41106650
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A92EB304EEBB
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B3B270ED2;
	Sat,  7 Feb 2026 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IglpdTtC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA52749FE
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770478647; cv=none; b=S98SXl/RK/7skCqqUC/RtSgK8klfYmY2ES14raPr7AfM830ZUnu3vW5ey+4624cq9dqm93QOn8nuJbCCHOiBw+K1BoO8U03bX7oFdTBMJIrIIML3PgMmxcr0K6Uq98vbW7nX8vP7Lh7fJ3dczc2yQzSH90wj1HAz7aCesnhK750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770478647; c=relaxed/simple;
	bh=pV+4WLwV6bCSiMcZMzv7vrRqs0Utn76hbyAWzYQGUVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eh7wcPqUcp0lAEG6Dl/FHPcVDqqU5PKffwucWCElp5aGjW2gYuy1FWUaZwgjGKULpbk5PpnKb0r9Qctp9/hcifLAmKm3An7jUhlb4y/pb93n7Jvzsp5f1qBrd68LdXzJQEfFxuPtbbJWLtv6Mdxv76/SIxHc2tyr8kYp0/JYNyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IglpdTtC; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b834e3d64so1826026e87.2
        for <stable@vger.kernel.org>; Sat, 07 Feb 2026 07:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770478645; x=1771083445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k/wh7ANdTi5nQi/YCLRVFUaW1qmyLoqNdMBFYAjzbQ=;
        b=IglpdTtCzn4NdpgZ8zSzBAkAro8+NqKm5LDFMI+BzTcEA1VoCyayURXwtuE2Ejp4RV
         DcIi/WfZomV+PWyA94r5n5pz+QX6b4nnwGm923BIfoKRnfPAb0uniVevC0y4h+naO7fi
         0dvDj5M5WtQpevJ32M8rM5OXFuFMhXnZOJwpf3/8WxL+W42emRpeQeY6VKxDiwCe2Zzq
         f5gk+rRdA1UgHeyY4e3k9vB9xSHhOBscv/qh6FBa66DZOImMEmVuxqFIA6ud06RHF6/s
         T3pu/3/oSlxuFj40ohSQPrDwsEGKYzCYPAn9HvgeIwH3JgMGk+ol3/FQX9ephobGRYGe
         7y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770478645; x=1771083445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0k/wh7ANdTi5nQi/YCLRVFUaW1qmyLoqNdMBFYAjzbQ=;
        b=NYZebiszHHbkzW+ApP/z6EowwiDpE2eLJ80XO5DYiQM31GrNRL714sT7QHwSq+5RJr
         j5pRYR66NpoUGz8DK5Ad4tC4/86fUpuSHIzo+xmuBzC0/SfRzJkP44viOwheHi5WWBnR
         prZMlOgeEuVJMODstCD6zOqbB/5Jgdv6guNngFjm1m3Xb3rnWlYfOzFEjrEo7rgV/ymE
         3H0LbcnpoL6GdHnp1DPpwWZi6/2cVbxYIW/krHxq8Ja7UtdqmviHhDdH5EKJKmzc7O94
         /tlWx7tgq4PG4ruVE3+mYVCtltpVUFO4TaE3W6BPGArzPSrF9v7rlb/n5t+uc0RGvGBR
         EjZw==
X-Forwarded-Encrypted: i=1; AJvYcCWEn83aDHOfO34V7FJxxkx713HxcxRuF3pLfom+xHaiLpugXk67dI5zMhPCcbUMeClK36tbQT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBZeOjizeVKthSRd3QFNMj0kLB78jsVwURmiqUvylDqhxiCGr
	0lbtjPRw59wmhQXU0+gR/QPhNASEbyuoXbqYuEHRrdfLPzynr5hIDegl
X-Gm-Gg: AZuq6aIi1Fa7IRr5kIPyh+HI+Zlr9bGy9szpQgyJ4Zlv5cvbf77zxiaKRw1C+Py/0MW
	0pK9eW+FiRdgBIRadWliQ5qYnsVDavO70rqZsgrdRxAHyiC6qTXsu8t7TGZISEvvb0uJStlMe0d
	XI1hEC4/HarAYYu81l8zEWLiPnz+hm89kOk5cpuuH7AhsnW9iz8Uf+E+cprPRSJvUMrlNrg7TMm
	WVNTlC8gSQIQmXwx2C2hw860ycvni1dC1Umy+jdE54qhqQPNVkOShLUipvuFEIdKOFJD/F5b5Ke
	W1daxOy+ATk3SeUNBfvPZRK+UIN70fpSz5Pvh5rHpE83/jMiEVvaUK+XRcEXfepTcJOXCJXmXhN
	cexXWD2ZyVxuXgc6UtKMT2P9+HgoHt+4NH2JZmhHdfu6QkijbPRsQ7+jwGZSEheWV/RlcCywIsD
	OvI5rnY6wIoOx8WPcZ9mbPuCw5rzHmFkD3
X-Received: by 2002:a05:6512:3c86:b0:59d:e771:61f0 with SMTP id 2adb3069b0e04-59e4515829cmr1941200e87.24.1770478644744;
        Sat, 07 Feb 2026 07:37:24 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44d299d1sm1374187e87.64.2026.02.07.07.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 07:37:23 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	vbabka@suse.cz,
	chrisl@kernel.org,
	kasong@tencent.com,
	hughd@google.com,
	ryncsn@gmail.com,
	ziy@nvidia.com,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/page_alloc: clear page->private in free_pages_prepare()
Date: Sat,  7 Feb 2026 20:37:15 +0500
Message-ID: <20260207153716.59302-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <17A126A7-BACA-49E5-8A89-F8E665981136@nvidia.com>
References: <17A126A7-BACA-49E5-8A89-F8E665981136@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-214801-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,suse.cz,kernel.org,tencent.com,google.com,gmail.com,nvidia.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77B41106650
X-Rspamd-Action: no action

Several subsystems (slub, shmem, ttm, etc.) use page->private but don't
clear it before freeing pages. When these pages are later allocated as
high-order pages and split via split_page(), tail pages retain stale
page->private values.

This causes a use-after-free in the swap subsystem. The swap code uses
page->private to track swap count continuations, assuming freshly
allocated pages have page->private == 0. When stale values are present,
swap_count_continued() incorrectly assumes the continuation list is valid
and iterates over uninitialized page->lru containing LIST_POISON values,
causing a crash:

  KASAN: maybe wild-memory-access in range [0xdead000000000100-0xdead000000000107]
  RIP: 0010:__do_sys_swapoff+0x1151/0x1860

Fix this by clearing page->private in free_pages_prepare(), ensuring all
freed pages have clean state regardless of previous use.

Fixes: 3b8000ae185c ("mm/vmalloc: huge vmalloc backing pages should be split rather than compound")
Cc: stable@vger.kernel.org
Suggested-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 mm/page_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cbf758e27aa2..24ac34199f95 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1430,6 +1430,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 
 	page_cpupid_reset_last(page);
 	page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	page->private = 0;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
 	pgalloc_tag_sub(page, 1 << order);
-- 
2.53.0


