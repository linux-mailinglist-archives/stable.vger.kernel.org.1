Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AE8713D19
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjE1TVx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjE1TVv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:21:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB5AD2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58A7161B22
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7565CC433EF;
        Sun, 28 May 2023 19:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301709;
        bh=Vq+LpJbwCTrbIP1QboJ5zmJL+RgJRJTi2osprRgpdUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENX5THoVIv2Nu7poi57lAurSTJkDvUSaIop/xU2Yg/JCw3FK4dy23RBVNd0cBoszE
         +M6DVizbQ3VGRmj9ZQKS6FqpzFkcelFkpQVqhksVfp4d9nXILBc2NEt7dZ+qpl+aHN
         KBV/rQvDQrUJtLBpi2Pk/lacloaUcecbd2BwOc+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Krzesimir Nowak <krzesimir@kinvolk.io>,
        Andrey Ignatov <rdna@fb.com>, Yonghong Song <yhs@fb.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 4.19 120/132] bpf: Fix mask generation for 32-bit narrow loads of 64-bit fields
Date:   Sun, 28 May 2023 20:10:59 +0100
Message-Id: <20230528190837.487753081@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit 0613d8ca9ab382caabe9ed2dceb429e9781e443f upstream.

A narrow load from a 64-bit context field results in a 64-bit load
followed potentially by a 64-bit right-shift and then a bitwise AND
operation to extract the relevant data.

In the case of a 32-bit access, an immediate mask of 0xffffffff is used
to construct a 64-bit BPP_AND operation which then sign-extends the mask
value and effectively acts as a glorified no-op. For example:

0:	61 10 00 00 00 00 00 00	r0 = *(u32 *)(r1 + 0)

results in the following code generation for a 64-bit field:

	ldr	x7, [x7]	// 64-bit load
	mov	x10, #0xffffffffffffffff
	and	x7, x7, x10

Fix the mask generation so that narrow loads always perform a 32-bit AND
operation:

	ldr	x7, [x7]	// 64-bit load
	mov	w10, #0xffffffff
	and	w7, w7, w10

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Krzesimir Nowak <krzesimir@kinvolk.io>
Cc: Andrey Ignatov <rdna@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
Fixes: 31fd85816dbe ("bpf: permits narrower load from bpf program context fields")
Signed-off-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20230518102528.1341-1-will@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5936,7 +5936,7 @@ static int convert_ctx_accesses(struct b
 					insn_buf[cnt++] = BPF_ALU64_IMM(BPF_RSH,
 									insn->dst_reg,
 									shift);
-				insn_buf[cnt++] = BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
+				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
 								(1ULL << size * 8) - 1);
 			}
 		}


