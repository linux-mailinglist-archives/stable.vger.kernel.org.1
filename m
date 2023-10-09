Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6466F7BDE66
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377054AbjJINTT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377046AbjJINTS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:19:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE25AC
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:19:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F847C433C7;
        Mon,  9 Oct 2023 13:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857556;
        bh=cmTthydeuR5Z+BEtfEjQpswvt661le9/5Cqn2ShugOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjQO+/xqZsz1Ffq+Xn8DoWsnTeELXv6Of1EQa4Od+kTEH9rSDzN6OV8hF5Muhv+ss
         UBUuCbIwsa4JaonVbLCU7V58TgYZ0GC8JZVdhFK9aIWUroo9CMX6XDtzt/At/lXqP1
         dYSfqhQH9iTwTCqRRFglCASIbziJ3oa2YCnzTW8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Leon Hwang <hffilwlqm@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 084/162] bpf: Fix tr dereferencing
Date:   Mon,  9 Oct 2023 15:01:05 +0200
Message-ID: <20231009130125.235637808@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 1ed2ec035e779..1fba826f0acef 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1065,7 +1065,7 @@ static inline int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
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



