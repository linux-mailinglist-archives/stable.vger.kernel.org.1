Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F77E780752
	for <lists+stable@lfdr.de>; Fri, 18 Aug 2023 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358667AbjHRIjh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 18 Aug 2023 04:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358749AbjHRIjd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 Aug 2023 04:39:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D4A3A9A;
        Fri, 18 Aug 2023 01:39:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf1935f6c2so4770005ad.1;
        Fri, 18 Aug 2023 01:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692347970; x=1692952770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NATVvEwRdPYa24RR+CE7PmZVk6EWVd7A6dmv5g7pFo=;
        b=AmV7XXIxC2RYlnrsPxc7EuBoiE+QbIzdMbQ5Hl9ro+fvn9nTJe4dpDyB47XUBQ995Y
         G46tiaU+tmCbLKAUfr2DEsEalUp6U9dIWBxAjNJjXH6gfNi/yPg+HpYu8wwNRbs7LSK0
         F8hHqixL7huEOpn/H8nvjqCwpsXiTCENiM0NDrqk1ya3hyIne98bH/bkUZcdlsGHGkrV
         ldtgpB1L3YpkeOJ91s4oieL+7sIFzJ0VPqlG/NB6twcNaAQqpbYXBvKCB/Yycy2OCFg5
         97bPxa6fYN+NIhnM6eKOcVgies6/rX2b81e8yGq4lK20pkzV5kJcMB7QWUoi+ojuaiJb
         tazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692347970; x=1692952770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NATVvEwRdPYa24RR+CE7PmZVk6EWVd7A6dmv5g7pFo=;
        b=kNblxNxD1WJ+sq09pvb5z4sLVzWWjYK7vXiSRKjDWqwn6r6ebpzqqrh2ZlxIxWCZo2
         5ds9hIO9MSBTbJubCAoZitBb3R+sn+pEZRhbVwuzx6ZTqY4BYbt39Rszglqf+uSNExR8
         JbBBqb7DgWL5KWwXfoGBZnsE6UCsjlapiZ/1hvUpr/ypPU1+JSYUoEZmrdCLeen3LWGD
         ROrA3fwc6GqCeU8okiuGDEis3n1MGDPfWf6ZRA74WE+74BcRZQMQ2IJ0fGDxBj/SM3/T
         drnq9LkYKO0Stq7htOiMhH2UZcLnrz5U2xVWhLmWgvdMUHK8oZVhQyckSY3Aq/yUQfJB
         NUUA==
X-Gm-Message-State: AOJu0YwNKQ5iukgeoDBfAXPJFRE9qtm0GYGXALAPHFpaIhbHYw6zx+IN
        kJ4TYQCDpFgCo88fE5tBCDk=
X-Google-Smtp-Source: AGHT+IHLPnihvPMjRmiTpca5REHhBCf64XMSzNveAr8JDX3R/nz2UEkLzgunQGrYDCuMgyKzrL4G0Q==
X-Received: by 2002:a17:902:d484:b0:1af:e302:123 with SMTP id c4-20020a170902d48400b001afe3020123mr2604371plg.3.1692347970381;
        Fri, 18 Aug 2023 01:39:30 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b001b53c8659fesm1185209plb.30.2023.08.18.01.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:39:29 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Fix issue in verifying allow_ptr_leaks
Date:   Fri, 18 Aug 2023 08:39:19 +0000
Message-Id: <20230818083920.3771-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230818083920.3771-1-laoar.shao@gmail.com>
References: <20230818083920.3771-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
Cc: stable@vger.kernel.org
---
 kernel/bpf/verifier.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ccca1f..b6b60cd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14047,6 +14047,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
@@ -14058,12 +14064,13 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
@@ -14071,12 +14078,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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
-- 
1.8.3.1

