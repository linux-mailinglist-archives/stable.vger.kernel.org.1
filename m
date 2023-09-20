Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6037A7BCA
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjITLzc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjITLza (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:55:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E140D7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:55:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D50C433C9;
        Wed, 20 Sep 2023 11:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210923;
        bh=tSHD87igLk4pcFiXigZnBP6BYYRhURcYrhMcLHMnwig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FlaXIXOarqgjCOWmnRnq8o99L0z0j95N5CNLNEces5Gm6aJs1+OM9XrmevVCWwzWE
         ZKrsRz0GsMxwbPz4eSKwvtVGzej8dqNsDiKIE/Erp1YRu6ikV9XAPfMy+0einxipK+
         MGpgv4Rx59CAAeqf7EovwSrSYZzl+f9T7gQuETPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 007/139] scftorture: Forgive memory-allocation failure if KASAN
Date:   Wed, 20 Sep 2023 13:29:01 +0200
Message-ID: <20230920112835.853306717@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
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

From: Paul E. McKenney <paulmck@kernel.org>

[ Upstream commit 013608cd0812bdb21fc26d39ed8fdd2fc76e8b9b ]

Kernels built with CONFIG_KASAN=y quarantine newly freed memory in order
to better detect use-after-free errors.  However, this can exhaust memory
more quickly in allocator-heavy tests, which can result in spurious
scftorture failure.  This commit therefore forgives memory-allocation
failure in kernels built with CONFIG_KASAN=y, but continues counting
the errors for use in detailed test-result analyses.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/scftorture.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 5d113aa59e773..83c33ba0ca7e0 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -171,7 +171,8 @@ static void scf_torture_stats_print(void)
 		scfs.n_all_wait += scf_stats_p[i].n_all_wait;
 	}
 	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) ||
-	    atomic_read(&n_mb_out_errs) || atomic_read(&n_alloc_errs))
+	    atomic_read(&n_mb_out_errs) ||
+	    (!IS_ENABLED(CONFIG_KASAN) && atomic_read(&n_alloc_errs)))
 		bangstr = "!!! ";
 	pr_alert("%s %sscf_invoked_count %s: %lld resched: %lld single: %lld/%lld single_ofl: %lld/%lld single_rpc: %lld single_rpc_ofl: %lld many: %lld/%lld all: %lld/%lld ",
 		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count, scfs.n_resched,
@@ -323,7 +324,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		preempt_disable();
 	if (scfsp->scfs_prim == SCF_PRIM_SINGLE || scfsp->scfs_wait) {
 		scfcp = kmalloc(sizeof(*scfcp), GFP_ATOMIC);
-		if (WARN_ON_ONCE(!scfcp)) {
+		if (!scfcp) {
+			WARN_ON_ONCE(!IS_ENABLED(CONFIG_KASAN));
 			atomic_inc(&n_alloc_errs);
 		} else {
 			scfcp->scfc_cpu = -1;
-- 
2.40.1



