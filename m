Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D83575D1F3
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjGUSyd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjGUSyc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:54:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0968830EA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9609F61D80
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BAEC433C9;
        Fri, 21 Jul 2023 18:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965670;
        bh=una6Je6luT+7lgXj5ss00MzUO9SOy1hhZmt9SkhbR3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yK1P1Or9yNGnwlmq8w9C3hpJicr5M4t2paZdYY/eBwMB+Yi6fUgHmBZl1aFLcXTi4
         E7AsgP97e918T7DZrVDWTjT0LFinbrDmNgQamGNz9FdOEaVbz52OGXreF2HauwRU+b
         UUZmRPGARp+85vHLLJHDhm8OdpqvTpZjrMrq78pY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin KaFai Lau <martin.lau@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 044/532] bpf: Dont EFAULT for {g,s}setsockopt with wrong optlen
Date:   Fri, 21 Jul 2023 17:59:08 +0200
Message-ID: <20230721160617.035993292@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit 29ebbba7d46136cba324264e513a1e964ca16c0a ]

With the way the hooks implemented right now, we have a special
condition: optval larger than PAGE_SIZE will expose only first 4k into
BPF; any modifications to the optval are ignored. If the BPF program
doesn't handle this condition by resetting optlen to 0,
the userspace will get EFAULT.

The intention of the EFAULT was to make it apparent to the
developers that the program is doing something wrong.
However, this inadvertently might affect production workloads
with the BPF programs that are not too careful (i.e., returning EFAULT
for perfectly valid setsockopt/getsockopt calls).

Let's try to minimize the chance of BPF program screwing up userspace
by ignoring the output of those BPF programs (instead of returning
EFAULT to the userspace). pr_info_once those cases to
the dmesg to help with figuring out what's going wrong.

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/r/20230511170456.1759459-2-sdf@google.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/cgroup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 87174832aa86d..297569e5c6399 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1481,6 +1481,12 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		ret = 1;
 	} else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
 		/* optlen is out of bounds */
+		if (*optlen > PAGE_SIZE && ctx.optlen >= 0) {
+			pr_info_once("bpf setsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
+				     ctx.optlen, max_optlen);
+			ret = 0;
+			goto out;
+		}
 		ret = -EFAULT;
 	} else {
 		/* optlen within bounds, run kernel handler */
@@ -1536,6 +1542,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		.optname = optname,
 		.retval = retval,
 	};
+	int orig_optlen;
 	int ret;
 
 	/* Opportunistic check to see whether we have any BPF program
@@ -1545,6 +1552,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	if (__cgroup_bpf_prog_array_is_empty(cgrp, CGROUP_GETSOCKOPT))
 		return retval;
 
+	orig_optlen = max_optlen;
 	ctx.optlen = max_optlen;
 
 	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
@@ -1568,6 +1576,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 			ret = -EFAULT;
 			goto out;
 		}
+		orig_optlen = ctx.optlen;
 
 		if (copy_from_user(ctx.optval, optval,
 				   min(ctx.optlen, max_optlen)) != 0) {
@@ -1587,6 +1596,12 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	}
 
 	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
+		if (orig_optlen > PAGE_SIZE && ctx.optlen >= 0) {
+			pr_info_once("bpf getsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
+				     ctx.optlen, max_optlen);
+			ret = retval;
+			goto out;
+		}
 		ret = -EFAULT;
 		goto out;
 	}
-- 
2.39.2



