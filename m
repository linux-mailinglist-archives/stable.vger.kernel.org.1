Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081B579AD19
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbjIKU4H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239971AbjIKOcy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:32:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB154F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:32:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BC2C433C7;
        Mon, 11 Sep 2023 14:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442769;
        bh=46rK/ggphDCRyuXAAyFkOvF26WBXrKgqQu11JSnSSQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1YJgmDWBHUAgwHHulAqiG7RrIvKXD96Yqs8Fbrx98oEZZQ0oTnzGvr8bLeko/d+9g
         y7pl20PoRlLdY7vI3vI/FaQKGShIvKU5bD3Bv6I10YW5NDYbuJf08ZyJy5R+UFgqM3
         Y9npbEEixdFKSvC3BZa/7qLqRjTzvqqbaG9MHlG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ravi Bangoria <ravi.bangoria@amd.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 141/737] libbpf: only reset sec_def handler when necessary
Date:   Mon, 11 Sep 2023 15:40:00 +0200
Message-ID: <20230911134654.436391168@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit c628747cc8800cf6d33d09f7f42c8b6f91e64dc7 ]

Don't reset recorded sec_def handler unconditionally on
bpf_program__set_type(). There are two situations where this is wrong.

First, if the program type didn't actually change. In that case original
SEC handler should work just fine.

Second, catch-all custom SEC handler is supposed to work with any BPF
program type and SEC() annotation, so it also doesn't make sense to
reset that.

This patch fixes both issues. This was reported recently in the context
of breaking perf tool, which uses custom catch-all handler for fancy BPF
prologue generation logic. This patch should fix the issue.

  [0] https://lore.kernel.org/linux-perf-users/ab865e6d-06c5-078e-e404-7f90686db50d@amd.com/

Fixes: d6e6286a12e7 ("libbpf: disassociate section handler on explicit bpf_program__set_type() call")
Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/r/20230707231156.1711948-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a27f6e9ccce75..57c040a9c3705 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8534,13 +8534,31 @@ enum bpf_prog_type bpf_program__type(const struct bpf_program *prog)
 	return prog->type;
 }
 
+static size_t custom_sec_def_cnt;
+static struct bpf_sec_def *custom_sec_defs;
+static struct bpf_sec_def custom_fallback_def;
+static bool has_custom_fallback_def;
+static int last_custom_sec_def_handler_id;
+
 int bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type type)
 {
 	if (prog->obj->loaded)
 		return libbpf_err(-EBUSY);
 
+	/* if type is not changed, do nothing */
+	if (prog->type == type)
+		return 0;
+
 	prog->type = type;
-	prog->sec_def = NULL;
+
+	/* If a program type was changed, we need to reset associated SEC()
+	 * handler, as it will be invalid now. The only exception is a generic
+	 * fallback handler, which by definition is program type-agnostic and
+	 * is a catch-all custom handler, optionally set by the application,
+	 * so should be able to handle any type of BPF program.
+	 */
+	if (prog->sec_def != &custom_fallback_def)
+		prog->sec_def = NULL;
 	return 0;
 }
 
@@ -8716,13 +8734,6 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("netfilter",		NETFILTER, BPF_NETFILTER, SEC_NONE),
 };
 
-static size_t custom_sec_def_cnt;
-static struct bpf_sec_def *custom_sec_defs;
-static struct bpf_sec_def custom_fallback_def;
-static bool has_custom_fallback_def;
-
-static int last_custom_sec_def_handler_id;
-
 int libbpf_register_prog_handler(const char *sec,
 				 enum bpf_prog_type prog_type,
 				 enum bpf_attach_type exp_attach_type,
-- 
2.40.1



