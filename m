Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748D97BDDA2
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376901AbjJINLq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376923AbjJINLY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:11:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D55AB
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:10:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3F7C433CA;
        Mon,  9 Oct 2023 13:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857037;
        bh=ZrH3ERLeBqV9Q2mWIwGEssrxBfesbwkbUMK+B6yes4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1TFcBWHegtKyEuwgbw4dmIsp5oUeoQGArYP5MA8o6vdFHYoXJvT4Vgzt27NFqUfU
         7S0VZuxLwupKetUgoVera5n2yaI7LjhIWNL2sgbQIFw7pPJMumKLL6SgA62aUmUUmK
         HWKWkn8TePZ49GexgueA4d6azf6f5CVxqzNc3AG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Leon Hwang <hffilwlqm@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 075/163] bpf: Fix tr dereferencing
Date:   Mon,  9 Oct 2023 15:00:39 +0200
Message-ID: <20231009130126.128274599@linuxfoundation.org>
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
index 477d91b926b35..6ba9d3ed8f0b0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1294,7 +1294,7 @@ static inline int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
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



