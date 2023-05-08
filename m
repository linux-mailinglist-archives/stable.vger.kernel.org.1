Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3F76FAB60
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjEHLMe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjEHLM3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:12:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230353612B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C3B962B89
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA71C433D2;
        Mon,  8 May 2023 11:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544346;
        bh=w2Sd3g6b7ju81ePBnXxDHrPGpcWlK4jU8ptPm8LW3s0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNAP+bq0hF6I8w+CCuCo1pjOYL+gCz3/3MIyiiG5K7QN2YCz7oDYTll+ChyVUwxbS
         BNV7h7IT8t4aw3NW/D2ZqhklzzNxDmfPcE+QmTnM1X/WfN8fPUsvrEFFnDw0b+93NA
         vP3LZHd4Jp4CHuYQ1xLZB+JYYsZ+o1mbJ/MZdHDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Luis Gerhorst <gerhorst@cs.fau.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 350/694] bpf: Remove misleading spec_v1 check on var-offset stack read
Date:   Mon,  8 May 2023 11:43:05 +0200
Message-Id: <20230508094443.954562367@linuxfoundation.org>
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

From: Luis Gerhorst <gerhorst@cs.fau.de>

[ Upstream commit 082cdc69a4651dd2a77539d69416a359ed1214f5 ]

For every BPF_ADD/SUB involving a pointer, adjust_ptr_min_max_vals()
ensures that the resulting pointer has a constant offset if
bypass_spec_v1 is false. This is ensured by calling sanitize_check_bounds()
which in turn calls check_stack_access_for_ptr_arithmetic(). There,
-EACCESS is returned if the register's offset is not constant, thereby
rejecting the program.

In summary, an unprivileged user must never be able to create stack
pointers with a variable offset. That is also the case, because a
respective check in check_stack_write() is missing. If they were able
to create a variable-offset pointer, users could still use it in a
stack-write operation to trigger unsafe speculative behavior [1].

Because unprivileged users must already be prevented from creating
variable-offset stack pointers, viable options are to either remove
this check (replacing it with a clarifying comment), or to turn it
into a "verifier BUG"-message, also adding a similar check in
check_stack_write() (for consistency, as a second-level defense).
This patch implements the first option to reduce verifier bloat.

This check was introduced by commit 01f810ace9ed ("bpf: Allow
variable-offset stack access") which correctly notes that
"variable-offset reads and writes are disallowed (they were already
disallowed for the indirect access case) because the speculative
execution checking code doesn't support them". However, it does not
further discuss why the check in check_stack_read() is necessary.
The code which made this check obsolete was also introduced in this
commit.

I have compiled ~650 programs from the Linux selftests, Linux samples,
Cilium, and libbpf/examples projects and confirmed that none of these
trigger the check in check_stack_read() [2]. Instead, all of these
programs are, as expected, already rejected when constructing the
variable-offset pointers. Note that the check in
check_stack_access_for_ptr_arithmetic() also prints "off=%d" while the
code removed by this patch does not (the error removed does not appear
in the "verification_error" values). For reproducibility, the
repository linked includes the raw data and scripts used to create
the plot.

  [1] https://arxiv.org/pdf/1807.03757.pdf
  [2] https://gitlab.cs.fau.de/un65esoq/bpf-spectre/-/raw/53dc19fcf459c186613b1156a81504b39c8d49db/data/plots/23-02-26_23-56_bpftool/bpftool/0004-errors.pdf?inline=false

Fixes: 01f810ace9ed ("bpf: Allow variable-offset stack access")
Signed-off-by: Luis Gerhorst <gerhorst@cs.fau.de>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230315165358.23701-1-gerhorst@cs.fau.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 856e2088289da..672a667b3d760 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3977,17 +3977,13 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	}
 	/* Variable offset is prohibited for unprivileged mode for simplicity
 	 * since it requires corresponding support in Spectre masking for stack
-	 * ALU. See also retrieve_ptr_limit().
+	 * ALU. See also retrieve_ptr_limit(). The check in
+	 * check_stack_access_for_ptr_arithmetic() called by
+	 * adjust_ptr_min_max_vals() prevents users from creating stack pointers
+	 * with variable offsets, therefore no check is required here. Further,
+	 * just checking it here would be insufficient as speculative stack
+	 * writes could still lead to unsafe speculative behaviour.
 	 */
-	if (!env->bypass_spec_v1 && var_off) {
-		char tn_buf[48];
-
-		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-		verbose(env, "R%d variable offset stack access prohibited for !root, var_off=%s\n",
-				ptr_regno, tn_buf);
-		return -EACCES;
-	}
-
 	if (!var_off) {
 		off += reg->var_off.value;
 		err = check_stack_read_fixed_off(env, state, off, size,
-- 
2.39.2



