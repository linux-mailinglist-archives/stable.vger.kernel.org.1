Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B598079B30F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344100AbjIKVNS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbjIKOZB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:25:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A16ADE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:24:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58D9C433C8;
        Mon, 11 Sep 2023 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442297;
        bh=7arcCSyzYzrkuJbRBoioCwEiy+Wzj9F1je0RwZ2mCvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KxGFgvjleFJLU8jjn+rLEc4ts80BV+6Z/13biWh9JHVQCLtvTRnbsgDtjxIPufkVg
         SNHxTlJ4HtgQItGWhLK8/SA0nauWEI0quBaXtuc3iRGhceJ1gEQM/lBs96gTZoIzjM
         p2TY+f69cKcrvEOaAkZTtsoLltks9qKDW4viYyJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.5 698/739] bpf: Fix issue in verifying allow_ptr_leaks
Date:   Mon, 11 Sep 2023 15:48:17 +0200
Message-ID: <20230911134710.590538494@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yafang Shao <laoar.shao@gmail.com>

commit d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2 upstream.

After we converted the capabilities of our networking-bpf program from
cap_sys_admin to cap_net_admin+cap_bpf, our networking-bpf program
failed to start. Because it failed the bpf verifier, and the error log
is "R3 pointer comparison prohibited".

A simple reproducer as follows,

SEC("cls-ingress")
int ingress(struct __sk_buff *skb)
{
	struct iphdr *iph = (void *)(long)skb->data + sizeof(struct ethhdr);

	if ((long)(iph + 1) > (long)skb->data_end)
		return TC_ACT_STOLEN;
	return TC_ACT_OK;
}

Per discussion with Yonghong and Alexei [1], comparison of two packet
pointers is not a pointer leak. This patch fixes it.

Our local kernel is 6.1.y and we expect this fix to be backported to
6.1.y, so stable is CCed.

[1]. https://lore.kernel.org/bpf/CAADnVQ+Nmspr7Si+pxWn8zkE7hX-7s93ugwC+94aXSy4uQ9vBg@mail.gmail.com/

Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230823020703.3790-2-laoar.shao@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13816,6 +13816,12 @@ static int check_cond_jmp_op(struct bpf_
 		return -EINVAL;
 	}
 
+	/* check src2 operand */
+	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
+	if (err)
+		return err;
+
+	dst_reg = &regs[insn->dst_reg];
 	if (BPF_SRC(insn->code) == BPF_X) {
 		if (insn->imm != 0) {
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
@@ -13827,12 +13833,13 @@ static int check_cond_jmp_op(struct bpf_
 		if (err)
 			return err;
 
-		if (is_pointer_value(env, insn->src_reg)) {
+		src_reg = &regs[insn->src_reg];
+		if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_reg)) &&
+		    is_pointer_value(env, insn->src_reg)) {
 			verbose(env, "R%d pointer comparison prohibited\n",
 				insn->src_reg);
 			return -EACCES;
 		}
-		src_reg = &regs[insn->src_reg];
 	} else {
 		if (insn->src_reg != BPF_REG_0) {
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
@@ -13840,12 +13847,6 @@ static int check_cond_jmp_op(struct bpf_
 		}
 	}
 
-	/* check src2 operand */
-	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
-	if (err)
-		return err;
-
-	dst_reg = &regs[insn->dst_reg];
 	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 
 	if (BPF_SRC(insn->code) == BPF_K) {


