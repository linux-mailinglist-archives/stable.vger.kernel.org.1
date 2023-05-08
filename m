Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407736FAB6E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjEHLNT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbjEHLNN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:13:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346B735B1A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14B2A62BA2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1432BC4339E;
        Mon,  8 May 2023 11:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544390;
        bh=/03fbBh2jBfg1ikfLKMm09rU5BB0nUBayxZ9K7gbWcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1CT54bPQ/m9wzNZHW4V86EOJf8Qv5ACsUHtOJRAlPVitzw9AdwY395Zn3s4TiY4o0
         wzpc50V3Pk50agzPn9ywPG0dHzxFSKRe88gSTYw5KDi8sRu1SwQsYoH6TqX5WrY5gK
         G8duaYBwB/EHxA7X13K9VFKxMg87d/rlly33JjhI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 395/694] bpf/btf: Fix is_int_ptr()
Date:   Mon,  8 May 2023 11:43:50 +0200
Message-Id: <20230508094445.906656513@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Feng Zhou <zhoufeng.zf@bytedance.com>

[ Upstream commit 91f2dc6838c19342f7f2993627c622835cc24890 ]

When tracing a kernel function with arg type is u32*, btf_ctx_access()
would report error: arg2 type INT is not a struct.

The commit bb6728d75611 ("bpf: Allow access to int pointer arguments
in tracing programs") added support for int pointer, but did not skip
modifiers before checking it's type. This patch fixes it.

Fixes: bb6728d75611 ("bpf: Allow access to int pointer arguments in tracing programs")
Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20230410085908.98493-2-zhoufeng.zf@bytedance.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 73780748404c2..3140a7881665d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5891,12 +5891,8 @@ struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog)
 
 static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 {
-	/* t comes in already as a pointer */
-	t = btf_type_by_id(btf, t->type);
-
-	/* allow const */
-	if (BTF_INFO_KIND(t->info) == BTF_KIND_CONST)
-		t = btf_type_by_id(btf, t->type);
+	/* skip modifiers */
+	t = btf_type_skip_modifiers(btf, t->type, NULL);
 
 	return btf_type_is_int(t);
 }
-- 
2.39.2



