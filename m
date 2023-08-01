Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60ED76AEDD
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjHAJmj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjHAJm0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:42:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F58F3A9A
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40C146150B
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E6DC433C7;
        Tue,  1 Aug 2023 09:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882801;
        bh=Q0erdX7soxwV9m/bSTuY4rVq6sDvEeR439xNA0ReEBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUILnpKq0eovCQ5m0nUNdaKlMYM98nXe0ljg2EcplJ43+A+gsdQl3ppNorJ3AzuEE
         bpM0lNKE/QpLu7XKnckOKWZTbZcXSP1eHFY//5IvW2Kx8Up/GoAt1+gj4+HgJLcC//
         77JOQilGv0bc64h1BLG8WKKljj+A94Nc7Tgek3Xc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Colin King (gmail)" <colin.i.king@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.1 204/228] LoongArch: BPF: Fix check condition to call lu32id in move_imm()
Date:   Tue,  1 Aug 2023 11:21:02 +0200
Message-ID: <20230801091930.245240168@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

commit 4eece7e6de94d833c8aeed2f438faf487cbf94ff upstream.

As the code comment says, the initial aim is to reduce one instruction
in some corner cases, if bit[51:31] is all 0 or all 1, no need to call
lu32id. That is to say, it should call lu32id only if bit[51:31] is not
all 0 and not all 1. The current code always call lu32id, the result is
right but the logic is unexpected and wrong, fix it.

Cc: stable@vger.kernel.org # 6.1
Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
Reported-by: Colin King (gmail) <colin.i.king@gmail.com>
Closes: https://lore.kernel.org/all/bcf97046-e336-712a-ac68-7fd194f2953e@gmail.com/
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/net/bpf_jit.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -148,7 +148,7 @@ static inline void move_imm(struct jit_c
 			 * no need to call lu32id to do a new filled operation.
 			 */
 			imm_51_31 = (imm >> 31) & 0x1fffff;
-			if (imm_51_31 != 0 || imm_51_31 != 0x1fffff) {
+			if (imm_51_31 != 0 && imm_51_31 != 0x1fffff) {
 				/* lu32id rd, imm_51_32 */
 				imm_51_32 = (imm >> 32) & 0xfffff;
 				emit_insn(ctx, lu32id, rd, imm_51_32);


