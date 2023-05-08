Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543036FA4F1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjEHKEr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjEHKEo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:04:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4059530164
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A96BD62322
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7C4C433EF;
        Mon,  8 May 2023 10:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540282;
        bh=M1WxhtCixUDrUKBeAnZf8pMKfDVgV0AvS+YaIuute0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cnBwXoq3f7wJS6KmnDXnkd1vXga9gtWcYNEOA8KmMRerl0270wmkoJQdIbnnR6MZt
         YTXPiOiUUfBdxLbTtMB7KlektysiT8cgUPtD+QicmpCGM/+4NhQ8HYDeMqFKdHo6o3
         gb0TDt/h61oOIaNZpZjP4/j54ftmxMXsvUIGR154=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 278/611] bpf: fix precision propagation verbose logging
Date:   Mon,  8 May 2023 11:42:00 +0200
Message-Id: <20230508094431.420791803@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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
index deaeedcdc12d7..8a9f5143bbd1f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11912,7 +11912,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			    !(state_reg->live & REG_LIVE_READ))
 				continue;
 			if (env->log.level & BPF_LOG_LEVEL2)
-				verbose(env, "frame %d: propagating r%d\n", i, fr);
+				verbose(env, "frame %d: propagating r%d\n", fr, i);
 			err = mark_chain_precision_frame(env, fr, i);
 			if (err < 0)
 				return err;
@@ -11928,7 +11928,7 @@ static int propagate_precision(struct bpf_verifier_env *env,
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



