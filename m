Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4F273E7D5
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjFZSTZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjFZSTY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:19:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74D099
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:19:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BD3560F4D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67308C433C0;
        Mon, 26 Jun 2023 18:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803562;
        bh=WeN4srA0DkEZQlg3rpa5C9MuLxMp0F6httUrlXchiiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZLvjWJZNsyRiV8tO0jtj5sGMApWkJmbQWUxNAeCAEp2ZXhK5Dn15z80IIgCiNGIf
         AxF+aFJgRJB5zkzEuSDt10IA4FkjRahFaEU1XAi9R1fztXzc4HqaDsE0MfQjNsDAb2
         2+FKWMVm3l/HD9/eO65UiLU6xuqAPKQ6+GuXeogk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maxim Mikityanskiy <maxim@isovalent.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Sasha Levin <sashal@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 6.3 104/199] bpf: Fix verifier id tracking of scalars on spill
Date:   Mon, 26 Jun 2023 20:10:10 +0200
Message-ID: <20230626180810.213201476@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Maxim Mikityanskiy <maxim@isovalent.com>

[ Upstream commit 713274f1f2c896d37017efee333fd44149710119 ]

The following scenario describes a bug in the verifier where it
incorrectly concludes about equivalent scalar IDs which could lead to
verifier bypass in privileged mode:

1. Prepare a 32-bit rogue number.
2. Put the rogue number into the upper half of a 64-bit register, and
   roll a random (unknown to the verifier) bit in the lower half. The
   rest of the bits should be zero (although variations are possible).
3. Assign an ID to the register by MOVing it to another arbitrary
   register.
4. Perform a 32-bit spill of the register, then perform a 32-bit fill to
   another register. Due to a bug in the verifier, the ID will be
   preserved, although the new register will contain only the lower 32
   bits, i.e. all zeros except one random bit.

At this point there are two registers with different values but the same
ID, which means the integrity of the verifier state has been corrupted.

5. Compare the new 32-bit register with 0. In the branch where it's
   equal to 0, the verifier will believe that the original 64-bit
   register is also 0, because it has the same ID, but its actual value
   still contains the rogue number in the upper half.
   Some optimizations of the verifier prevent the actual bypass, so
   extra care is needed: the comparison must be between two registers,
   and both branches must be reachable (this is why one random bit is
   needed). Both branches are still suitable for the bypass.
6. Right shift the original register by 32 bits to pop the rogue number.
7. Use the rogue number as an offset with any pointer. The verifier will
   believe that the offset is 0, while in reality it's the given number.

The fix is similar to the 32-bit BPF_MOV handling in check_alu_op for
SCALAR_VALUE. If the spill is narrowing the actual register value, don't
keep the ID, make sure it's reset to 0.

Fixes: 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Andrii Nakryiko <andrii@kernel.org> # Checked veristat delta
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20230607123951.558971-2-maxtram95@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1f6c0c5a1741d..b039990137444 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3559,6 +3559,9 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 				return err;
 		}
 		save_register_state(state, spi, reg, size);
+		/* Break the relation on a narrowing spill. */
+		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
+			state->stack[spi].spilled_ptr.id = 0;
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   insn->imm != 0 && env->bpf_capable) {
 		struct bpf_reg_state fake_reg = {};
-- 
2.39.2



