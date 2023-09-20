Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F5E7A7B07
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjITLsk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjITLsj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:48:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70DDB0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:48:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053CBC433C7;
        Wed, 20 Sep 2023 11:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210513;
        bh=eQTpE/tkbVrvVzBnyLpCpcEt4JSWLgN73lSsOzsP7B8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tlsinLplcdnK29VHCEN2cHiRFvyZJqyyODktxb1nVYuy8dieAu51Cd+uT7WyzaHvn
         L4xjiGOkmMEaNT/D1EMBePXtd5Yqp0O9IsiZ+Ro+Kaywhgk7A22yiiapqNkBSnFtdV
         nRiNKLW2z568H4wsc746fQMvRd/dNCWCGmEd+k0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Marchevsky <davemarchevsky@fb.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 062/211] bpf: Consider non-owning refs trusted
Date:   Wed, 20 Sep 2023 13:28:26 +0200
Message-ID: <20230920112847.699838815@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

From: Dave Marchevsky <davemarchevsky@fb.com>

[ Upstream commit 2a6d50b50d6d589d43a90d6ca990b8b811e67701 ]

Recent discussions around default kptr "trustedness" led to changes such
as commit 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the
verifier."). One of the conclusions of those discussions, as expressed
in code and comments in that patch, is that we'd like to move away from
'raw' PTR_TO_BTF_ID without some type flag or other register state
indicating trustedness. Although PTR_TRUSTED and PTR_UNTRUSTED flags mark
this state explicitly, the verifier currently considers trustedness
implied by other register state. For example, owning refs to graph
collection nodes must have a nonzero ref_obj_id, so they pass the
is_trusted_reg check despite having no explicit PTR_{UN}TRUSTED flag.
This patch makes trustedness of non-owning refs to graph collection
nodes explicit as well.

By definition, non-owning refs are currently trusted. Although the ref
has no control over pointee lifetime, due to non-owning ref clobbering
rules (see invalidate_non_owning_refs) dereferencing a non-owning ref is
safe in the critical section controlled by bpf_spin_lock associated with
its owning collection.

Note that the previous statement does not hold true for nodes with shared
ownership due to the use-after-free issue that this series is
addressing. True shared ownership was disabled by commit 7deca5eae833
("bpf: Disable bpf_refcount_acquire kfunc calls until race conditions are fixed"),
though, so the statement holds for now. Further patches in the series will change
the trustedness state of non-owning refs before re-enabling
bpf_refcount_acquire.

Let's add NON_OWN_REF type flag to BPF_REG_TRUSTED_MODIFIERS such that a
non-owning ref reg state would pass is_trusted_reg check. Somewhat
surprisingly, this doesn't result in any change to user-visible
functionality elsewhere in the verifier: graph collection nodes are all
marked MEM_ALLOC, which tends to be handled in separate codepaths from
"raw" PTR_TO_BTF_ID. Regardless, let's be explicit here and document the
current state of things before changing it elsewhere in the series.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20230821193311.3290257-3-davemarchevsky@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf_verifier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f70f9ac884d24..b6e58dab8e275 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -745,7 +745,7 @@ static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
 	}
 }
 
-#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED)
+#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED | NON_OWN_REF)
 
 static inline bool bpf_type_has_unsafe_modifiers(u32 type)
 {
-- 
2.40.1



