Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F4E79BABB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbjIKVST (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbjIKPIr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:08:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8617FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:08:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1D5C433C7;
        Mon, 11 Sep 2023 15:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444923;
        bh=dI+BDpE42zrX9V7qkes4CBZDwbR04OxiotVmiEGt6gY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MjMDpaRn5dNQZBfPRUfi21kIXW7lyuCkWkr29RgyeZj2y7Qj1CrhFYFFdNNsluofW
         VodhH2G+lEZMCl/MqmKCSmuCVuCYkhtKgDsjiUk4nlPb34pjy6Bx+rBnwJUGGwDtrq
         Qun7ir76hIc1bo1pol+7q8YrzK4i++uGvFVErBqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Colm Harrington <colm.harrington@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 162/600] selftests/bpf: fix static assert compilation issue for test_cls_*.c
Date:   Mon, 11 Sep 2023 15:43:15 +0200
Message-ID: <20230911134638.391213489@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Maguire <alan.maguire@oracle.com>

[ Upstream commit 416c6d01244ecbf0abfdb898fd091b50ef951b48 ]

commit bdeeed3498c7 ("libbpf: fix offsetof() and container_of() to work with CO-RE")

...was backported to stable trees such as 5.15. The problem is that with older
LLVM/clang (14/15) - which is often used for older kernels - we see compilation
failures in BPF selftests now:

In file included from progs/test_cls_redirect_subprogs.c:2:
progs/test_cls_redirect.c:90:2: error: static assertion expression is not an integral constant expression
        sizeof(flow_ports_t) !=
        ^~~~~~~~~~~~~~~~~~~~~~~
progs/test_cls_redirect.c:91:3: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
                offsetofend(struct bpf_sock_tuple, ipv4.dport) -
                ^
progs/test_cls_redirect.c:32:3: note: expanded from macro 'offsetofend'
        (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
         ^
tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:86:33: note: expanded from macro 'offsetof'
                                 ^
In file included from progs/test_cls_redirect_subprogs.c:2:
progs/test_cls_redirect.c:95:2: error: static assertion expression is not an integral constant expression
        sizeof(flow_ports_t) !=
        ^~~~~~~~~~~~~~~~~~~~~~~
progs/test_cls_redirect.c:96:3: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
                offsetofend(struct bpf_sock_tuple, ipv6.dport) -
                ^
progs/test_cls_redirect.c:32:3: note: expanded from macro 'offsetofend'
        (offsetof(TYPE, MEMBER) + sizeof((((TYPE *)0)->MEMBER)))
         ^
tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:86:33: note: expanded from macro 'offsetof'
                                 ^
2 errors generated.
make: *** [Makefile:594: tools/testing/selftests/bpf/test_cls_redirect_subprogs.bpf.o] Error 1

The problem is the new offsetof() does not play nice with static asserts.
Given that the context is a static assert (and CO-RE relocation is not
needed at compile time), offsetof() usage can be replaced by restoring
the original offsetof() definition as __builtin_offsetof().

Fixes: bdeeed3498c7 ("libbpf: fix offsetof() and container_of() to work with CO-RE")
Reported-by: Colm Harrington <colm.harrington@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Yipeng Zou <zouyipeng@huawei.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20230802073906.3197480-1-alan.maguire@oracle.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_cls_redirect.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.h b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
index 76eab0aacba0c..233b089d1fbac 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.h
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
@@ -12,6 +12,15 @@
 #include <linux/ipv6.h>
 #include <linux/udp.h>
 
+/* offsetof() is used in static asserts, and the libbpf-redefined CO-RE
+ * friendly version breaks compilation for older clang versions <= 15
+ * when invoked in a static assert.  Restore original here.
+ */
+#ifdef offsetof
+#undef offsetof
+#define offsetof(type, member) __builtin_offsetof(type, member)
+#endif
+
 struct gre_base_hdr {
 	uint16_t flags;
 	uint16_t protocol;
-- 
2.40.1



