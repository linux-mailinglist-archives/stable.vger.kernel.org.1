Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1517039AB
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244549AbjEORo6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244634AbjEORol (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:44:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2B719F22
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E820062E5C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE29DC433EF;
        Mon, 15 May 2023 17:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172534;
        bh=u5scZ3YwEk8evyVzAjI6zcE7PyPejgJcwJm7WBuXZi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JA3QiOS1aZa9EIGFKg+qFyI73K4nnHG2Yqx5SECGOJzWwolEznuTPpPXAGcb2B8FQ
         bvevOg6CH2RRNZmmUVK8JpXfBPMG/m+4IkOarn0zLIzJLEZFIN3UsReNuXPqqinfpW
         Js9z2dok7Mu6ykPCeTimPPfeKK+PeQJPAnD6Mevg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin KaFai Lau <martin.lau@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 184/381] bpf: Dont EFAULT for getsockopt with optval=NULL
Date:   Mon, 15 May 2023 18:27:15 +0200
Message-Id: <20230515161745.127603527@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit 00e74ae0863827d944e36e56a4ce1e77e50edb91 ]

Some socket options do getsockopt with optval=NULL to estimate the size
of the final buffer (which is returned via optlen). This breaks BPF
getsockopt assumptions about permitted optval buffer size. Let's enforce
these assumptions only when non-NULL optval is provided.

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Reported-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/ZD7Js4fj5YyI2oLd@google.com/T/#mb68daf700f87a9244a15d01d00c3f0e5b08f49f7
Link: https://lore.kernel.org/bpf/20230418225343.553806-2-sdf@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/cgroup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 6d92e393e1bc6..d3593a520bb72 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1516,7 +1516,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		goto out;
 	}
 
-	if (ctx.optlen > max_optlen || ctx.optlen < 0) {
+	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -1530,8 +1530,11 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	}
 
 	if (ctx.optlen != 0) {
-		if (copy_to_user(optval, ctx.optval, ctx.optlen) ||
-		    put_user(ctx.optlen, optlen)) {
+		if (optval && copy_to_user(optval, ctx.optval, ctx.optlen)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		if (put_user(ctx.optlen, optlen)) {
 			ret = -EFAULT;
 			goto out;
 		}
-- 
2.39.2



