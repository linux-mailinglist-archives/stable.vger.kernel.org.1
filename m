Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9087A7C4D
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjITMAM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjITMAE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:00:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF97A3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:59:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12421C433CA;
        Wed, 20 Sep 2023 11:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211198;
        bh=dTfg/SSMS6LPLIeVzLFnZS5ko3nlY06ZTD/Wtje4aGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFOV2Qu4q5eyRQez8GnH62iHpseUnm4Q4ka6t0aRUFQO2Eax/vG+XhEa/sd37Cv7p
         fZRK2oyagooYFCfkC4A0J8wrYrePGLqjN3+oF5uehv03ZNpWWDvWsp6ZhhKabF13e8
         s4ZTyokUOQpCrNKWV+KXr+XI1VxH7Jw6Bm5jh1Ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 137/139] Revert "memcg: drop kmem.limit_in_bytes"
Date:   Wed, 20 Sep 2023 13:31:11 +0200
Message-ID: <20230920112840.753207861@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 21ef9e11205fca43785eecf7d4a99528d4de5701 which is
commit 86327e8eb94c52eca4f93cfece2e29d1bf52acbf upstream.

It breaks existing runc systems, as the tool always thinks the file
should be present.

Reported-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Link: https://lore.kernel.org/r/20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
Cc: Michal Hocko <mhocko@suse.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/cgroup-v1/memory.rst |    2 ++
 mm/memcontrol.c                                |   10 ++++++++++
 2 files changed, 12 insertions(+)

--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -91,6 +91,8 @@ Brief summary of control files.
  memory.oom_control		     set/show oom controls.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
+ memory.kmem.limit_in_bytes          This knob is deprecated and writing to
+                                     it will return -ENOTSUPP.
  memory.kmem.usage_in_bytes          show current kernel memory allocation
  memory.kmem.failcnt                 show the number of kernel memory usage
 				     hits limits
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3841,6 +3841,10 @@ static ssize_t mem_cgroup_write(struct k
 		case _MEMSWAP:
 			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
 			break;
+		case _KMEM:
+			/* kmem.limit_in_bytes is deprecated. */
+			ret = -EOPNOTSUPP;
+			break;
 		case _TCP:
 			ret = memcg_update_tcp_max(memcg, nr_pages);
 			break;
@@ -5052,6 +5056,12 @@ static struct cftype mem_cgroup_legacy_f
 	},
 #endif
 	{
+		.name = "kmem.limit_in_bytes",
+		.private = MEMFILE_PRIVATE(_KMEM, RES_LIMIT),
+		.write = mem_cgroup_write,
+		.read_u64 = mem_cgroup_read_u64,
+	},
+	{
 		.name = "kmem.usage_in_bytes",
 		.private = MEMFILE_PRIVATE(_KMEM, RES_USAGE),
 		.read_u64 = mem_cgroup_read_u64,


