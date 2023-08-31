Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7F478EBA4
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjHaLMK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjHaLMI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:12:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE043E79
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:11:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E31FB82262
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF10C433C8;
        Thu, 31 Aug 2023 11:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693480302;
        bh=rnFiiiFf6JkVS+r3sZqzuwn/lOreRNt0mGEyduogGGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxlLPH81h2zBMs3iPOFT2LoXCu2SCFs3de/PBBffva4JvPcIcCCKofWh0CkUSSNQy
         5xo4qgzI0KSgtNLVyK6UPjHxEgvwrSU36wXGtVo84LAoRC1PgPUypEM811V8rQbPUI
         pWmlsA2k09kpGyJCRc/7tzNXVwBURLiBs6zH0yXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <oliver.sang@intel.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Song Liu <song@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.5 8/8] kallsyms: Fix kallsyms_selftest failure
Date:   Thu, 31 Aug 2023 13:10:35 +0200
Message-ID: <20230831110831.131024174@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831110830.817738361@linuxfoundation.org>
References: <20230831110830.817738361@linuxfoundation.org>
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

From: Yonghong Song <yonghong.song@linux.dev>

commit 33f0467fe06934d5e4ea6e24ce2b9c65ce618e26 upstream.

Kernel test robot reported a kallsyms_test failure when clang lto is
enabled (thin or full) and CONFIG_KALLSYMS_SELFTEST is also enabled.
I can reproduce in my local environment with the following error message
with thin lto:
  [    1.877897] kallsyms_selftest: Test for 1750th symbol failed: (tsc_cs_mark_unstable) addr=ffffffff81038090
  [    1.877901] kallsyms_selftest: abort

It appears that commit 8cc32a9bbf29 ("kallsyms: strip LTO-only suffixes
from promoted global functions") caused the failure. Commit 8cc32a9bbf29
changed cleanup_symbol_name() based on ".llvm." instead of '.' where
".llvm." is appended to a before-lto-optimization local symbol name.
We need to propagate such knowledge in kallsyms_selftest.c as well.

Further more, compare_symbol_name() in kallsyms.c needs change as well.
In scripts/kallsyms.c, kallsyms_names and kallsyms_seqs_of_names are used
to record symbol names themselves and index to symbol names respectively.
For example:
  kallsyms_names:
    ...
    __amd_smn_rw._entry       <== seq 1000
    __amd_smn_rw._entry.5     <== seq 1001
    __amd_smn_rw.llvm.<hash>  <== seq 1002
    ...

kallsyms_seqs_of_names are sorted based on cleanup_symbol_name() through, so
the order in kallsyms_seqs_of_names actually has

  index 1000:   seq 1002   <== __amd_smn_rw.llvm.<hash> (actual symbol comparison using '__amd_smn_rw')
  index 1001:   seq 1000   <== __amd_smn_rw._entry
  index 1002:   seq 1001   <== __amd_smn_rw._entry.5

Let us say at a particular point, at index 1000, symbol '__amd_smn_rw.llvm.<hash>'
is comparing to '__amd_smn_rw._entry' where '__amd_smn_rw._entry' is the one to
search e.g., with function kallsyms_on_each_match_symbol(). The current implementation
will find out '__amd_smn_rw._entry' is less than '__amd_smn_rw.llvm.<hash>' and
then continue to search e.g., index 999 and never found a match although the actual
index 1001 is a match.

To fix this issue, let us do cleanup_symbol_name() first and then do comparison.
In the above case, comparing '__amd_smn_rw' vs '__amd_smn_rw._entry' and
'__amd_smn_rw._entry' being greater than '__amd_smn_rw', the next comparison will
be > index 1000 and eventually index 1001 will be hit an a match is found.

For any symbols not having '.llvm.' substr, there is no functionality change
for compare_symbol_name().

Fixes: 8cc32a9bbf29 ("kallsyms: strip LTO-only suffixes from promoted global functions")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202308232200.1c932a90-oliver.sang@intel.com
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Song Liu <song@kernel.org>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/r/20230825034659.1037627-1-yonghong.song@linux.dev
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/kallsyms.c          |   17 +++++++----------
 kernel/kallsyms_selftest.c |   23 +----------------------
 2 files changed, 8 insertions(+), 32 deletions(-)

--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -188,16 +188,13 @@ static bool cleanup_symbol_name(char *s)
 
 static int compare_symbol_name(const char *name, char *namebuf)
 {
-	int ret;
-
-	ret = strcmp(name, namebuf);
-	if (!ret)
-		return ret;
-
-	if (cleanup_symbol_name(namebuf) && !strcmp(name, namebuf))
-		return 0;
-
-	return ret;
+	/* The kallsyms_seqs_of_names is sorted based on names after
+	 * cleanup_symbol_name() (see scripts/kallsyms.c) if clang lto is enabled.
+	 * To ensure correct bisection in kallsyms_lookup_names(), do
+	 * cleanup_symbol_name(namebuf) before comparing name and namebuf.
+	 */
+	cleanup_symbol_name(namebuf);
+	return strcmp(name, namebuf);
 }
 
 static unsigned int get_symbol_seq(int index)
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -196,7 +196,7 @@ static bool match_cleanup_name(const cha
 	if (!IS_ENABLED(CONFIG_LTO_CLANG))
 		return false;
 
-	p = strchr(s, '.');
+	p = strstr(s, ".llvm.");
 	if (!p)
 		return false;
 
@@ -344,27 +344,6 @@ static int test_kallsyms_basic_function(
 			goto failed;
 		}
 
-		/*
-		 * The first '.' may be the initial letter, in which case the
-		 * entire symbol name will be truncated to an empty string in
-		 * cleanup_symbol_name(). Do not test these symbols.
-		 *
-		 * For example:
-		 * cat /proc/kallsyms | awk '{print $3}' | grep -E "^\." | head
-		 * .E_read_words
-		 * .E_leading_bytes
-		 * .E_trailing_bytes
-		 * .E_write_words
-		 * .E_copy
-		 * .str.292.llvm.12122243386960820698
-		 * .str.24.llvm.12122243386960820698
-		 * .str.29.llvm.12122243386960820698
-		 * .str.75.llvm.12122243386960820698
-		 * .str.99.llvm.12122243386960820698
-		 */
-		if (IS_ENABLED(CONFIG_LTO_CLANG) && !namebuf[0])
-			continue;
-
 		lookup_addr = kallsyms_lookup_name(namebuf);
 
 		memset(stat, 0, sizeof(*stat));


