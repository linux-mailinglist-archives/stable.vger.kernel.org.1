Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F578779AE8
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 01:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbjHKXAE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 19:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbjHKW7h (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 18:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145B03A89;
        Fri, 11 Aug 2023 15:59:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FF23676A6;
        Fri, 11 Aug 2023 22:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024F8C433C8;
        Fri, 11 Aug 2023 22:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691794762;
        bh=oNdle7nmOAZ1yCoqJ0/drzH9iPVe08TvFIklaOrPTnw=;
        h=Date:To:From:Subject:From;
        b=xWC4Lu6AmT41LJImgItWPb8XMJiUoNcQTO9sd4ZS0c9grlrdaOg0XPcN7NXT+3cJq
         jKXZ5dcvU6eVLQ3SRZTT3gnULu+aC1hywSYRciN3OEonxJhdmL8HjPcvJSAMeAx1UI
         JC1Meqwp8xF69Uv4snf2etCF4Z7VN/k+ouW71lEs=
Date:   Fri, 11 Aug 2023 15:59:21 -0700
To:     mm-commits@vger.kernel.org, tj@kernel.org, stable@vger.kernel.org,
        shakeelb@google.com, roman.gushchin@linux.dev,
        muchun.song@linux.dev, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] memcg-drop-kmemlimit_in_bytes.patch removed from -mm tree
Message-Id: <20230811225922.024F8C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: memcg: drop kmem.limit_in_bytes
has been removed from the -mm tree.  Its filename was
     memcg-drop-kmemlimit_in_bytes.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Michal Hocko <mhocko@suse.com>
Subject: memcg: drop kmem.limit_in_bytes
Date: Tue, 4 Jul 2023 13:52:40 +0200

kmem.limit_in_bytes (v1 way to limit kernel memory usage) has been
deprecated since 58056f77502f ("memcg, kmem: further deprecate
kmem.limit_in_bytes") merged in 5.16.  We haven't heard about any serious
users since then but it seems that the mere presence of the file is
causing more harm thatn good.  We (SUSE) have had several bug reports from
customers where Docker based containers started to fail because a write to
kmem.limit_in_bytes has failed.

This was unexpected because runc code only expects ENOENT (kmem disabled)
or EBUSY (tasks already running within cgroup).  So a new error code was
unexpected and the whole container startup failed.  This has been later
addressed by
https://github.com/opencontainers/runc/commit/52390d68040637dfc77f9fda6bbe70952423d380
so current Docker runtimes do not suffer from the problem anymore.  There
are still older version of Docker in use and likely hard to get rid of
completely.

Address this by wiping out the file completely and effectively get back to
pre 4.5 era and CONFIG_MEMCG_KMEM=n configuration.

I would recommend backporting to stable trees which have picked up
58056f77502f ("memcg, kmem: further deprecate kmem.limit_in_bytes").

[mhocko@suse.com: restore _KMEM switch case]
  Link: https://lkml.kernel.org/r/ZKe5wxdbvPi5Cwd7@dhcp22.suse.cz
Link: https://lkml.kernel.org/r/20230704115240.14672-1-mhocko@kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/admin-guide/cgroup-v1/memory.rst |    2 --
 mm/memcontrol.c                                |   10 ----------
 2 files changed, 12 deletions(-)

--- a/Documentation/admin-guide/cgroup-v1/memory.rst~memcg-drop-kmemlimit_in_bytes
+++ a/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -92,8 +92,6 @@ Brief summary of control files.
  memory.oom_control		     set/show oom controls.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
- memory.kmem.limit_in_bytes          This knob is deprecated and writing to
-                                     it will return -ENOTSUPP.
  memory.kmem.usage_in_bytes          show current kernel memory allocation
  memory.kmem.failcnt                 show the number of kernel memory usage
 				     hits limits
--- a/mm/memcontrol.c~memcg-drop-kmemlimit_in_bytes
+++ a/mm/memcontrol.c
@@ -3871,10 +3871,6 @@ static ssize_t mem_cgroup_write(struct k
 		case _MEMSWAP:
 			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
 			break;
-		case _KMEM:
-			/* kmem.limit_in_bytes is deprecated. */
-			ret = -EOPNOTSUPP;
-			break;
 		case _TCP:
 			ret = memcg_update_tcp_max(memcg, nr_pages);
 			break;
@@ -5086,12 +5082,6 @@ static struct cftype mem_cgroup_legacy_f
 	},
 #endif
 	{
-		.name = "kmem.limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_KMEM, RES_LIMIT),
-		.write = mem_cgroup_write,
-		.read_u64 = mem_cgroup_read_u64,
-	},
-	{
 		.name = "kmem.usage_in_bytes",
 		.private = MEMFILE_PRIVATE(_KMEM, RES_USAGE),
 		.read_u64 = mem_cgroup_read_u64,
_

Patches currently in -mm which might be from mhocko@suse.com are


