Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE6075D367
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjGUTKP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjGUTKO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831C1E4C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2136861D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33212C433C7;
        Fri, 21 Jul 2023 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966612;
        bh=LULTxCY0NcejywFFwB/9TLPN3NVh1iQ0Padl4avB77U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4kBKRtkORzNXHOO8IQs4GjIQQo4YjE1tGVrcH0pg2h9sSo2cFm8r652wsaSQgFx2
         yUJJZZBKh53PMoDRECj9NRnb0oQvBTsrmEKDfjczlPJZW6rv18EEq8jxfcBLleYdzW
         siiXRX9o8JDA+uPajQw2s15saKNt+l/7zWmJdbD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 405/532] bpf: Fix max stack depth check for async callbacks
Date:   Fri, 21 Jul 2023 18:05:09 +0200
Message-ID: <20230721160636.432083300@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit 5415ccd50a8620c8cbaa32d6f18c946c453566f5 ]

The check_max_stack_depth pass happens after the verifier's symbolic
execution, and attempts to walk the call graph of the BPF program,
ensuring that the stack usage stays within bounds for all possible call
chains. There are two cases to consider: bpf_pseudo_func and
bpf_pseudo_call. In the former case, the callback pointer is loaded into
a register, and is assumed that it is passed to some helper later which
calls it (however there is no way to be sure), but the check remains
conservative and accounts the stack usage anyway. For this particular
case, asynchronous callbacks are skipped as they execute asynchronously
when their corresponding event fires.

The case of bpf_pseudo_call is simpler and we know that the call is
definitely made, hence the stack depth of the subprog is accounted for.

However, the current check still skips an asynchronous callback even if
a bpf_pseudo_call was made for it. This is erroneous, as it will miss
accounting for the stack usage of the asynchronous callback, which can
be used to breach the maximum stack depth limit.

Fix this by only skipping asynchronous callbacks when the instruction is
not a pseudo call to the subprog.

Fixes: 7ddc80a476c2 ("bpf: Teach stack depth check about async callbacks.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20230705144730.235802-2-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7a70595c3c15a..bd31aa6407a78 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3765,8 +3765,9 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 				verbose(env, "verifier bug. subprog has tail_call and async cb\n");
 				return -EFAULT;
 			}
-			 /* async callbacks don't increase bpf prog stack size */
-			continue;
+			/* async callbacks don't increase bpf prog stack size unless called directly */
+			if (!bpf_pseudo_call(insn + i))
+				continue;
 		}
 		i = next_insn;
 
-- 
2.39.2



