Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA3479BFFF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbjIKU42 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241391AbjIKPHn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:07:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8AAE40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:07:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA49BC433C8;
        Mon, 11 Sep 2023 15:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444859;
        bh=QT9ThB/4PdB7WuYSa6O2iulkdjGcg2Y3eqGXN6n8AIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqR2zfry1GTVuSRD4/6fnXXdtU/6PMFOO2eXu0nmqKitcrlf5vV5UtwpNQPPRLyOb
         +8QIP+VzlJWCAIEtYeSmvGHRmvQZsEgjClmkaP8dxoPYk+MT8A5aEtrlNOTTxO6d2o
         fJxHyw0h35Te+lBHp1+AwRgkoX6iBlCQhZ8OOaCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 141/600] libbpf: Fix realloc API handling in zero-sized edge cases
Date:   Mon, 11 Sep 2023 15:42:54 +0200
Message-ID: <20230911134637.771986580@linuxfoundation.org>
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

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 8a0260dbf6553c969248b6530cafadac46562f47 ]

realloc() and reallocarray() can either return NULL or a special
non-NULL pointer, if their size argument is zero. This requires a bit
more care to handle NULL-as-valid-result situation differently from
NULL-as-error case. This has caused real issues before ([0]), and just
recently bit again in production when performing bpf_program__attach_usdt().

This patch fixes 4 places that do or potentially could suffer from this
mishandling of NULL, including the reported USDT-related one.

There are many other places where realloc()/reallocarray() is used and
NULL is always treated as an error value, but all those have guarantees
that their size is always non-zero, so those spot don't need any extra
handling.

  [0] d08ab82f59d5 ("libbpf: Fix double-free when linker processes empty sections")

Fixes: 999783c8bbda ("libbpf: Wire up spec management and other arch-independent USDT logic")
Fixes: b63b3c490eee ("libbpf: Add bpf_program__set_insns function")
Fixes: 697f104db8a6 ("libbpf: Support custom SEC() handlers")
Fixes: b12688267280 ("libbpf: Change the order of data and text relocations.")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230711024150.1566433-1-andrii@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 15 ++++++++++++---
 tools/lib/bpf/usdt.c   |  5 ++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b9a29d1053765..eeb2693128d8a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6063,7 +6063,11 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
 	if (main_prog == subprog)
 		return 0;
 	relos = libbpf_reallocarray(main_prog->reloc_desc, new_cnt, sizeof(*relos));
-	if (!relos)
+	/* if new count is zero, reallocarray can return a valid NULL result;
+	 * in this case the previous pointer will be freed, so we *have to*
+	 * reassign old pointer to the new value (even if it's NULL)
+	 */
+	if (!relos && new_cnt)
 		return -ENOMEM;
 	if (subprog->nr_reloc)
 		memcpy(relos + main_prog->nr_reloc, subprog->reloc_desc,
@@ -8345,7 +8349,8 @@ int bpf_program__set_insns(struct bpf_program *prog,
 		return -EBUSY;
 
 	insns = libbpf_reallocarray(prog->insns, new_insn_cnt, sizeof(*insns));
-	if (!insns) {
+	/* NULL is a valid return from reallocarray if the new count is zero */
+	if (!insns && new_insn_cnt) {
 		pr_warn("prog '%s': failed to realloc prog code\n", prog->name);
 		return -ENOMEM;
 	}
@@ -8640,7 +8645,11 @@ int libbpf_unregister_prog_handler(int handler_id)
 
 	/* try to shrink the array, but it's ok if we couldn't */
 	sec_defs = libbpf_reallocarray(custom_sec_defs, custom_sec_def_cnt, sizeof(*sec_defs));
-	if (sec_defs)
+	/* if new count is zero, reallocarray can return a valid NULL result;
+	 * in this case the previous pointer will be freed, so we *have to*
+	 * reassign old pointer to the new value (even if it's NULL)
+	 */
+	if (sec_defs || custom_sec_def_cnt == 0)
 		custom_sec_defs = sec_defs;
 
 	return 0;
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 49f3c3b7f6095..af1cb30556b46 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -852,8 +852,11 @@ static int bpf_link_usdt_detach(struct bpf_link *link)
 		 * system is so exhausted on memory, it's the least of user's
 		 * concerns, probably.
 		 * So just do our best here to return those IDs to usdt_manager.
+		 * Another edge case when we can legitimately get NULL is when
+		 * new_cnt is zero, which can happen in some edge cases, so we
+		 * need to be careful about that.
 		 */
-		if (new_free_ids) {
+		if (new_free_ids || new_cnt == 0) {
 			memcpy(new_free_ids + man->free_spec_cnt, usdt_link->spec_ids,
 			       usdt_link->spec_cnt * sizeof(*usdt_link->spec_ids));
 			man->free_spec_ids = new_free_ids;
-- 
2.40.1



