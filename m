Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6239073E7D7
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjFZSTb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjFZSTa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:19:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76F7ED
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A6EE60E8D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55027C433C8;
        Mon, 26 Jun 2023 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803568;
        bh=M4O/k72JoEPPpUeXmm5VNOs5Kb7+gg1vFbFArzBcQzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wBY12hTfB0j1uQb8OP9kt2U55XnfiHPrGdenVBUpnI37f0aPjDjzEtPyL39YFNvwR
         4A3JeGRvcZLR/85QjZqkRsnjP+ciWY3fZn0Tt8YSWA9Bmt7BmVpjz0LPkIZt+jHTLE
         20AvGkcp8Y2nW/HxSMWQIv4WVB5KPTiO9jGWMwUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 106/199] bpf: Fix a bpf_jit_dump issue for x86_64 with sysctl bpf_jit_enable.
Date:   Mon, 26 Jun 2023 20:10:12 +0200
Message-ID: <20230626180810.304671738@linuxfoundation.org>
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

From: Yonghong Song <yhs@fb.com>

[ Upstream commit ad96f1c9138e0897bee7f7c5e54b3e24f8b62f57 ]

The sysctl net/core/bpf_jit_enable does not work now due to commit
1022a5498f6f ("bpf, x86_64: Use bpf_jit_binary_pack_alloc"). The
commit saved the jitted insns into 'rw_image' instead of 'image'
which caused bpf_jit_dump not dumping proper content.

With 'echo 2 > /proc/sys/net/core/bpf_jit_enable', run
'./test_progs -t fentry_test'. Without this patch, one of jitted
image for one particular prog is:

  flen=17 proglen=92 pass=4 image=0000000014c64883 from=test_progs pid=1807
  00000000: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
  00000010: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
  00000020: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
  00000030: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
  00000040: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
  00000050: cc cc cc cc cc cc cc cc cc cc cc cc

With this patch, the jitte image for the same prog is:

  flen=17 proglen=92 pass=4 image=00000000b90254b7 from=test_progs pid=1809
  00000000: f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3
  00000010: 0f 1e fa 31 f6 48 8b 57 00 48 83 fa 07 75 2b 48
  00000020: 8b 57 10 83 fa 09 75 22 48 8b 57 08 48 81 e2 ff
  00000030: 00 00 00 48 83 fa 08 75 11 48 8b 7f 18 be 01 00
  00000040: 00 00 48 83 ff 0a 74 02 31 f6 48 bf 18 d0 14 00
  00000050: 00 c9 ff ff 48 89 77 00 31 c0 c9 c3

Fixes: 1022a5498f6f ("bpf, x86_64: Use bpf_jit_binary_pack_alloc")
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/bpf/20230609005439.3173569-1-yhs@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1056bbf55b172..438adb695daab 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2570,7 +2570,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	if (bpf_jit_enable > 1)
-		bpf_jit_dump(prog->len, proglen, pass + 1, image);
+		bpf_jit_dump(prog->len, proglen, pass + 1, rw_image);
 
 	if (image) {
 		if (!prog->is_func || extra_pass) {
-- 
2.39.2



