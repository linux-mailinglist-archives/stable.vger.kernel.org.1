Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33A87554DF
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGPUfB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjGPUfA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA752BC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:34:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5998960EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CB3C433C8;
        Sun, 16 Jul 2023 20:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539697;
        bh=IWkkqNL0D1GaGqrjVuFdx/c/HoEuScii0PqS4uyuKIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnIlOh1l5d3XC9TA0AP4cmD4A0R8rGHoU161y+9nIds0u2P1kX4aSEmINeJ0PhhR5
         4j0Gs4qTIPbl9sVUpFMrnvF0WSGYAgLp5cRjltIN7FwSfHmKAeFrgISVDZuDoheFlN
         Jrxey8w4P4S/odnAjtRc1NIsG6Jo+vygn71hZg+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Haifeng Xu <haifeng.xu@shopee.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 099/591] selftests: cgroup: fix unexpected failure on test_memcg_low
Date:   Sun, 16 Jul 2023 21:43:58 +0200
Message-ID: <20230716194926.439929957@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Haifeng Xu <haifeng.xu@shopee.com>

[ Upstream commit 19ab365762c6cc39dfdee9e13ab0d12fe4b5540d ]

Since commit f079a020ba95 ("selftests: memcg: factor out common parts of
memory.{low,min} tests"), the value used in second alloc_anon has changed
from 148M to 170M.  Because memory.low allows reclaiming page cache in
child cgroups, so the memory.current is close to 30M instead of 50M.
Therefore, adjust the expected value of parent cgroup.

Link: https://lkml.kernel.org/r/20230522095233.4246-2-haifeng.xu@shopee.com
Fixes: f079a020ba95 ("selftests: memcg: factor out common parts of memory.{low,min} tests")
Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index fe4f9f4302822..5a526a8e7d333 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -284,6 +284,7 @@ static int test_memcg_protection(const char *root, bool min)
 	char *children[4] = {NULL};
 	const char *attribute = min ? "memory.min" : "memory.low";
 	long c[4];
+	long current;
 	int i, attempts;
 	int fd;
 
@@ -392,7 +393,8 @@ static int test_memcg_protection(const char *root, bool min)
 		goto cleanup;
 	}
 
-	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
+	current = min ? MB(50) : MB(30);
+	if (!values_close(cg_read_long(parent[1], "memory.current"), current, 3))
 		goto cleanup;
 
 	if (min) {
-- 
2.39.2



