Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD7E6FAB38
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjEHLKi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjEHLKd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AA83234F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E05862B55
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D35C4339B;
        Mon,  8 May 2023 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544230;
        bh=a10Z9gk8KifaWlkndg4PwUl0YBly/ikSQjbzOAHQbNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uK6GjbaL32G9ASZKo9wLohOtq2hnLhCbMnHW2WDFIdUh/SyM/lfS1mvSefhDtBZ27
         sw1/Yr5OQ2gMJNA7W3KSIdIzDpWEKJ1KKHgBlCNyAebiuRlLVkQvSaglsyYHjYAEOI
         SvwyZac4Ho8TaIsf24su3SrKGAXi+SY+aBgkg4go=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 342/694] bpf: fix precision propagation verbose logging
Date:   Mon,  8 May 2023 11:42:57 +0200
Message-Id: <20230508094443.606489925@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

[ Upstream commit 34f0677e7afd3a292bc1aadda7ce8e35faedb204 ]

Fix wrong order of frame index vs register/slot index in precision
propagation verbose (level 2) output. It's wrong and very confusing as is.

Fixes: 529409ea92d5 ("bpf: propagate precision across all frames, not just the last one")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20230313184017.4083374-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 63510f8a1c7dc..856e2088289da 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14229,7 +14229,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			    !(state_reg->live & REG_LIVE_READ))
 				continue;
 			if (env->log.level & BPF_LOG_LEVEL2)
-				verbose(env, "frame %d: propagating r%d\n", i, fr);
+				verbose(env, "frame %d: propagating r%d\n", fr, i);
 			err = mark_chain_precision_frame(env, fr, i);
 			if (err < 0)
 				return err;
@@ -14245,7 +14245,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 				continue;
 			if (env->log.level & BPF_LOG_LEVEL2)
 				verbose(env, "frame %d: propagating fp%d\n",
-					(-i - 1) * BPF_REG_SIZE, fr);
+					fr, (-i - 1) * BPF_REG_SIZE);
 			err = mark_chain_precision_stack_frame(env, fr, i);
 			if (err < 0)
 				return err;
-- 
2.39.2



