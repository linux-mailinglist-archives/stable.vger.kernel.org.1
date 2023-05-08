Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CCC6FA89C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjEHKnY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjEHKmk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:42:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E4926EBE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04F9862829
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B94AC433EF;
        Mon,  8 May 2023 10:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542503;
        bh=LMIRdMaa3fH7lGEg6C1PbLcnWMZuqYKIUZ5Rmn4b2hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4CJ4usdgLOrOiD7bYJaKF+PfT6R1hYLUTl6MHq8ZdkD4N9blOGBLRtvunIxNKJH5
         i+dlQxWJop8B5P5/LMD0xExJci26hBc31x7MtPNlz/kA/kUJvL3fTU7Mbl6VAcZDVE
         /345zXUVSoBDV6Ld3/EaQ2yB/dDGW0aplfElDWsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin KaFai Lau <martin.lau@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 425/663] bpf: Dont EFAULT for getsockopt with optval=NULL
Date:   Mon,  8 May 2023 11:44:11 +0200
Message-Id: <20230508094441.865134581@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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
index bf2fdb33fb313..819f011f0a9cd 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1921,14 +1921,17 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	if (ret < 0)
 		goto out;
 
-	if (ctx.optlen > max_optlen || ctx.optlen < 0) {
+	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
 		ret = -EFAULT;
 		goto out;
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



