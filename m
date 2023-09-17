Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65D77A3A53
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbjIQUCV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240349AbjIQUBn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:01:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1D1B9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:01:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93249C433D9;
        Sun, 17 Sep 2023 20:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980872;
        bh=fheggj1bHESoSWOMU6fK3HWTw//kdpMm8Odx12UGc+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wDjvK4Ht9smyqXF7sMT37oBKwCkqqIheYrurFlas/JK4LJEUaTFowI9ivDiu3H7qY
         Pzk344krvpiqQ2ERnRD3KEfvaA83PMJ7zbKGcpOZ9NejRUs4wfe3poOW6bimC/et1L
         TfHr7xbmmKEV5awnB7YzQHaZGoyCV9mY2E9RNxKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 033/219] memcg: drop kmem.limit_in_bytes
Date:   Sun, 17 Sep 2023 21:12:40 +0200
Message-ID: <20230917191042.204185566@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

commit 86327e8eb94c52eca4f93cfece2e29d1bf52acbf upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/cgroup-v1/memory.rst |    2 --
 mm/memcontrol.c                                |   10 ----------
 2 files changed, 12 deletions(-)

--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -91,8 +91,6 @@ Brief summary of control files.
  memory.oom_control		     set/show oom controls.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
- memory.kmem.limit_in_bytes          This knob is deprecated and writing to
-                                     it will return -ENOTSUPP.
  memory.kmem.usage_in_bytes          show current kernel memory allocation
  memory.kmem.failcnt                 show the number of kernel memory usage
 				     hits limits
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3841,10 +3841,6 @@ static ssize_t mem_cgroup_write(struct k
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
@@ -5056,12 +5052,6 @@ static struct cftype mem_cgroup_legacy_f
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


