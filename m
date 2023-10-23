Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DC87D3490
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjJWLkv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbjJWLku (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:40:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07A41A4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:40:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EABC433C7;
        Mon, 23 Oct 2023 11:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061247;
        bh=3zthHt3DzTich6vpvkMDApOEThwwTE/udz6dJAQ7F04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kpZPuuxhoLTmRvVTFubDnex2blFMdl0GE86PADJJmLEnNFPT29XXZaaeJvCN84zXi
         7tz6mxJZtw0ERurdMkRQFH2g460btR/B/TWk5CzM3HP+t+e7xmT6A2vIGBxoEuC38b
         c48lbxcUpy7McRvlBpKEU13cJ4wSGvjgrLuru9LM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francis Laniel <flaniel@linux.microsoft.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH 5.15 122/137] selftests/ftrace: Add new test case which checks non unique symbol
Date:   Mon, 23 Oct 2023 12:57:59 +0200
Message-ID: <20231023104824.860026261@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
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

From: Francis Laniel <flaniel@linux.microsoft.com>

commit 03b80ff8023adae6780e491f66e932df8165e3a0 upstream.

If name_show() is non unique, this test will try to install a kprobe on this
function which should fail returning EADDRNOTAVAIL.
On kernel where name_show() is not unique, this test is skipped.

Link: https://lore.kernel.org/all/20231020104250.9537-3-flaniel@linux.microsoft.com/

Cc: stable@vger.kernel.org
Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc  | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
new file mode 100644
index 000000000000..bc9514428dba
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test failure of registering kprobe on non unique symbol
+# requires: kprobe_events
+
+SYMBOL='name_show'
+
+# We skip this test on kernel where SYMBOL is unique or does not exist.
+if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}" /proc/kallsyms)" -le '1' ]; then
+	exit_unsupported
+fi
+
+! echo "p:test_non_unique ${SYMBOL}" > kprobe_events
-- 
2.42.0



