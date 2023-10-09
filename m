Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA357BDF23
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376491AbjJIN0n (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376490AbjJIN0m (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:26:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBE594
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:26:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB36C433C9;
        Mon,  9 Oct 2023 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858001;
        bh=Zw/BF71tm3PSYOBxdwVe+lcOgJftJt+YkMkt8NiVS5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1eJoehtil6ZWF9tOSfwT0wYoSZzwi/uo2GMoI3Rknc4tfiWECBSJaQD/GUK2FTa8
         G9eEio3SiRiGA8rbvwkh7rgLcdUCdXAi3/704+E5WH7dYgpHvU1cvichvRrIxZg1EP
         Eluh7RG8MfT9+oOwV8p3vSI9hsGVIb6BbGyRpLqA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Leon Hwang <hffilwlqm@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 34/75] bpf: Fix tr dereferencing
Date:   Mon,  9 Oct 2023 15:01:56 +0200
Message-ID: <20231009130112.426919408@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Hwang <hffilwlqm@gmail.com>

[ Upstream commit b724a6418f1f853bcb39c8923bf14a50c7bdbd07 ]

Fix 'tr' dereferencing bug when CONFIG_BPF_JIT is turned off.

When CONFIG_BPF_JIT is turned off, 'bpf_trampoline_get()' returns NULL,
which is same as the cases when CONFIG_BPF_JIT is turned on.

Closes: https://lore.kernel.org/r/202309131936.5Nc8eUD0-lkp@intel.com/
Fixes: f7b12b6fea00 ("bpf: verifier: refactor check_attach_btf_id()")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230917153846.88732-1-hffilwlqm@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 84efd8dd139d9..9ab087d73ab34 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -840,7 +840,7 @@ static inline int bpf_trampoline_unlink_prog(struct bpf_prog *prog,
 static inline struct bpf_trampoline *bpf_trampoline_get(u64 key,
 							struct bpf_attach_target_info *tgt_info)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return NULL;
 }
 static inline void bpf_trampoline_put(struct bpf_trampoline *tr) {}
 #define DEFINE_BPF_DISPATCHER(name)
-- 
2.40.1



