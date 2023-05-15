Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0271A70399C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbjEORoL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbjEORns (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8861C11D9C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:41:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAD0F62E57
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B200C433D2;
        Mon, 15 May 2023 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172476;
        bh=po7BveljnL+uE1oi7vuTJKw+iOecQRUKjAeTneo+wN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ca8LGUR9QahrQWu4lY4ixCK8mkLmOMUWz4drV2vIMD+a+vLAuESE84xlXZuDEXgzF
         NXMg3XUa+WtClc1lRflbgRCxAnkvPvg14JR0MdTeVovx5I6KPlh1OXBeDNfWYG+tWI
         vOoN5bUjJM9jOW2msAeSFRuqFJKuqHD9wCDzCqWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 137/381] bpf: take into account liveness when propagating precision
Date:   Mon, 15 May 2023 18:26:28 +0200
Message-Id: <20230515161743.017607442@linuxfoundation.org>
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

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 52c2b005a3c18c565fc70cfd0ca49375f301e952 ]

When doing state comparison, if old state has register that is not
marked as REG_LIVE_READ, then we just skip comparison, regardless what's
the state of corresponing register in current state. This is because not
REG_LIVE_READ register is irrelevant for further program execution and
correctness. All good here.

But when we get to precision propagation, after two states were declared
equivalent, we don't take into account old register's liveness, and thus
attempt to propagate precision for register in current state even if
that register in old state was not REG_LIVE_READ anymore. This is bad,
because register in current state could be anything at all and this
could cause -EFAULT due to internal logic bugs.

Fix by taking into account REG_LIVE_READ liveness mark to keep the logic
in state comparison in sync with precision propagation.

Fixes: a3ce685dd01a ("bpf: fix precision tracking")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20230309224131.57449-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5a96a9dd51e4c..e2488a00efc5a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9550,7 +9550,8 @@ static int propagate_precision(struct bpf_verifier_env *env,
 		state_reg = state->regs;
 		for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
 			if (state_reg->type != SCALAR_VALUE ||
-			    !state_reg->precise)
+			    !state_reg->precise ||
+			    !(state_reg->live & REG_LIVE_READ))
 				continue;
 			if (env->log.level & BPF_LOG_LEVEL2)
 				verbose(env, "frame %d: propagating r%d\n", i, fr);
@@ -9564,7 +9565,8 @@ static int propagate_precision(struct bpf_verifier_env *env,
 				continue;
 			state_reg = &state->stack[i].spilled_ptr;
 			if (state_reg->type != SCALAR_VALUE ||
-			    !state_reg->precise)
+			    !state_reg->precise ||
+			    !(state_reg->live & REG_LIVE_READ))
 				continue;
 			if (env->log.level & BPF_LOG_LEVEL2)
 				verbose(env, "frame %d: propagating fp%d\n",
-- 
2.39.2



