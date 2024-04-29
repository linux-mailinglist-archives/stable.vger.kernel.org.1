Return-Path: <stable+bounces-41713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9858B5951
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 15:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10781F22248
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260396F099;
	Mon, 29 Apr 2024 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="lGWvS5Fs"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4E6EB7B
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395745; cv=none; b=CRixuRG0Z8opOYcUoA2AjGXt/GM2Oro5tlCTVaSbyXKjF/EkK3VmOHflyl42fgTvBkiZGKZUDrq9ZffGxr92FgAXU5VoEviU2fiPJtLg4YyR3LO9jUC0Qx5pLsk6whyO1Q9DnaI3KwwyAuHOdAuf73LWvlGLhZ8yOM8IfDuCS2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395745; c=relaxed/simple;
	bh=o3wjLA+LBB98YNQw4zY1N1kJtlTHUkjdXDOKBkUkPBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrPwyOw04BWrk+geBdrZMmzpKviVcI5vISjeSbRpFK9Ti6Ny9pX1Z/8loCN80HNpfVux0Byq+oWtm0iSrCxfClLRVpdXPS7JoLaVlxuUufYQC4igKvJ5KNk5k+w1j9Qc5H+JHFOn6wDb9VLgoInxwzWvUFzK410WYrnyZjRyB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=lGWvS5Fs; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78ebc7e1586so564604485a.1
        for <stable@vger.kernel.org>; Mon, 29 Apr 2024 06:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1714395741; x=1715000541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn3cBZVXhwFsBAUCYPUCAxb4Cv46ewbFDd1nsP2hoz4=;
        b=lGWvS5FsuW2t9fOQxwV3Kh2R+nzhmga6JLfZ578vYP4e66FIPDsVTqJCjzQQ8Nlzz/
         Nl1v1ePy8VJZ8U0Pnys8TTnx63pBFjlnQ7d6GI6mYpgY3sUQM5pDc2j+pi2I6PhXde3q
         U3iR5jeX0BoIu/kjnDug3xytJBAEtaruE8eQKbRsXYBA2xBPy4zyTYOHwFgs+3n6kgPr
         GBJPCq8thcOaXAbLNsyBNLMDdi9FNOr8P2QDN9ScgjKaZV3BO1aGE6YhlSxqIii2POrO
         dNhZ+7ymRDxSlN4W0I+8lcKHNcFzkrurXNoiZJrQKqGxWBGHmKVGw7dkbyTrZ6nA/oPw
         GrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714395741; x=1715000541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qn3cBZVXhwFsBAUCYPUCAxb4Cv46ewbFDd1nsP2hoz4=;
        b=o91MfZ4NKm5NgGi8uYeF+DZEbd8aRBTaGdTV1gFfsPHdzQfrbt4lkNyXG0UMfoTe9k
         bRxSeAirAnWnCka6mdmCGbbr9GfZY3pJbYOpaPVzwkYA7+i1rHqwpJQpRf1h7ywRiNzh
         CfuDMkkI0YcJMuPtHjdwD/TFjezA3gqUOGWVgvp5h9P2e012wC514G09/Rmb9iodl950
         5JnuVuajBvG5ZsVyjUJLqYYtuqafFy60p7hbt5jnZIWLoMPkelpB/mIKKB+DLYpVTYyu
         H5LgFA+KzrlBjAAbkZ66JN7VRCUauauq2LUgyiQ1NLPn+S4+eUnMqP1aKx3LgGO67/OV
         LvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwZ8M2nFzrxNyyic3N7sKmpXAQYIFyOKGdjbID1TQFwltFsgCJF/O5mJeP0FZ9m8g7uW/4sAyngzOsiRSTXbigzyO7Fh1r
X-Gm-Message-State: AOJu0YzJGfIo4B4/42kCJHjbORCAcz14Fu9V4p8L2K9Gspdyc0kz5kki
	hvwvA1BqRJCoykV5Se5H4agZ8PzHQaeW1XLtqz/Qvhi1OdKB8/QOY4qXghpOBC0=
X-Google-Smtp-Source: AGHT+IEmxbUTSND3fuTrnCk5HBsF2z/cMpFEI5kVqFMv+MZjTKpCibpi5plMmupkRe5Km7Z0imDUAg==
X-Received: by 2002:a05:620a:231:b0:790:fc62:efd4 with SMTP id u17-20020a05620a023100b00790fc62efd4mr2025436qkm.1.1714395741284;
        Mon, 29 Apr 2024 06:02:21 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id v10-20020ae9e30a000000b0078ef0d4773bsm10433117qkf.109.2024.04.29.06.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:02:20 -0700 (PDT)
Date: Mon, 29 Apr 2024 09:02:16 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
	christian@heusel.eu, ddstreet@ieee.org, nphamcs@gmail.com,
	rjones@redhat.com, sjenning@redhat.com, stable@vger.kernel.org,
	vitaly.wool@konsulko.com, yosryahmed@google.com
Subject: [PATCH 6.8.y] mm: zswap: fix shrinker NULL crash with
 cgroup_disable=memory
Message-ID: <20240429130216.GB1155473@cmpxchg.org>
References: <2024042923-monday-hamlet-26ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024042923-monday-hamlet-26ca@gregkh>

Christian reports a NULL deref in zswap that he bisected down to the zswap
shrinker.  The issue also cropped up in the bug trackers of libguestfs [1]
and the Red Hat bugzilla [2].

The problem is that when memcg is disabled with the boot time flag, the
zswap shrinker might get called with sc->memcg == NULL.  This is okay in
many places, like the lruvec operations.  But it crashes in
memcg_page_state() - which is only used due to the non-node accounting of
cgroup's the zswap memory to begin with.

Nhat spotted that the memcg can be NULL in the memcg-disabled case, and I
was then able to reproduce the crash locally as well.

[1] https://github.com/libguestfs/libguestfs/issues/139
[2] https://bugzilla.redhat.com/show_bug.cgi?id=2275252

Link: https://lkml.kernel.org/r/20240418124043.GC1055428@cmpxchg.org
Link: https://lkml.kernel.org/r/20240417143324.GA1055428@cmpxchg.org
Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reported-by: Christian Heusel <christian@heusel.eu>
Debugged-by: Nhat Pham <nphamcs@gmail.com>
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Tested-by: Christian Heusel <christian@heusel.eu>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Richard W.M. Jones <rjones@redhat.com>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: <stable@vger.kernel.org>	[v6.8]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 682886ec69d22363819a83ddddd5d66cb5c791e1)
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

Two minor conflicts in the else branch:
- zswap_pool_total_size was get_zswap_pool_size() in 6.8
- zswap_nr_stored was pool->nr_stored in 6.8

diff --git a/mm/zswap.c b/mm/zswap.c
index e9c04387195f..69766f2c5a6c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -653,15 +653,22 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	if (!gfp_has_io_fs(sc->gfp_mask))
 		return 0;
 
-#ifdef CONFIG_MEMCG_KMEM
-	mem_cgroup_flush_stats(memcg);
-	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
-	nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
-#else
-	/* use pool stats instead of memcg stats */
-	nr_backing = get_zswap_pool_size(pool) >> PAGE_SHIFT;
-	nr_stored = atomic_read(&pool->nr_stored);
-#endif
+	/*
+	 * For memcg, use the cgroup-wide ZSWAP stats since we don't
+	 * have them per-node and thus per-lruvec. Careful if memcg is
+	 * runtime-disabled: we can get sc->memcg == NULL, which is ok
+	 * for the lruvec, but not for memcg_page_state().
+	 *
+	 * Without memcg, use the zswap pool-wide metrics.
+	 */
+	if (!mem_cgroup_disabled()) {
+		mem_cgroup_flush_stats(memcg);
+		nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
+		nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
+	} else {
+		nr_backing = get_zswap_pool_size(pool) >> PAGE_SHIFT;
+		nr_stored = atomic_read(&pool->nr_stored);
+	}
 
 	if (!nr_stored)
 		return 0;
-- 
2.44.0


