Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556987BDDA3
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376677AbjJINLr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376956AbjJINL0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:11:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC3810C6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:10:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F18C433CB;
        Mon,  9 Oct 2023 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857040;
        bh=mQr9Dl0QfRLNQbRSBrylobpMdR9t8dfyoSaB4f2EzQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TlMXE3JXqDoN3/N2GF09npeetEiFAvr6vVElrwAZkBmBWP3dZjLlvlGBBpMvin2PL
         bhDwuFXmiPPFDrmKH/HYepYELTXvRSrjoMhNgt84DCMrwmbeXNEbCJGFU0a4B1Smv0
         8r1QCGBz2Z9n9TWbsHzDKySA/dxHN/Hc/6zWOjPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Mason <clm@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 076/163] bpf: unconditionally reset backtrack_state masks on global func exit
Date:   Mon,  9 Oct 2023 15:00:40 +0200
Message-ID: <20231009130126.155031003@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 81335f90e8a88b81932df011105c46e708744f44 ]

In mark_chain_precision() logic, when we reach the entry to a global
func, it is expected that R1-R5 might be still requested to be marked
precise. This would correspond to some integer input arguments being
tracked as precise. This is all expected and handled as a special case.

What's not expected is that we'll leave backtrack_state structure with
some register bits set. This is because for subsequent precision
propagations backtrack_state is reused without clearing masks, as all
code paths are carefully written in a way to leave empty backtrack_state
with zeroed out masks, for speed.

The fix is trivial, we always clear register bit in the register mask, and
then, optionally, set reg->precise if register is SCALAR_VALUE type.

Reported-by: Chris Mason <clm@meta.com>
Fixes: be2ef8161572 ("bpf: allow precision tracking for programs with subprogs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20230918210110.2241458-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9cdba4ce23d2b..93fd32f2957b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4039,11 +4039,9 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				bitmap_from_u64(mask, bt_reg_mask(bt));
 				for_each_set_bit(i, mask, 32) {
 					reg = &st->frame[0]->regs[i];
-					if (reg->type != SCALAR_VALUE) {
-						bt_clear_reg(bt, i);
-						continue;
-					}
-					reg->precise = true;
+					bt_clear_reg(bt, i);
+					if (reg->type == SCALAR_VALUE)
+						reg->precise = true;
 				}
 				return 0;
 			}
-- 
2.40.1



