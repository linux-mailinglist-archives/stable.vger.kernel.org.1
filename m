Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2077ED5C2
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbjKOVMZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344680AbjKOVMY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:12:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB0B11F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:12:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95959C433C7;
        Wed, 15 Nov 2023 20:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081221;
        bh=mP/KCifvT7rr/ijEV4+pLIGtRw48pxdQtaTm3kAHDtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LrSSPTtygdfgNYiB71d569qCZr5zMtPP8bRIykKvCIMbC3dYzdwfH8jxaO2uJYpm9
         AvrZZbC4FzXzMRouSdL3xe9Ar18O3k88Bd7Sk201d6jATOMrnVz1LTEg163LBb/qIs
         NwoREmc+kDO+uHZJqI2Y3MWR6VmXwHOfHUV3XFG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 007/244] futex: Dont include process MM in futex key on no-MMU
Date:   Wed, 15 Nov 2023 15:33:19 -0500
Message-ID: <20231115203548.814391924@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Wolsieffer <ben.wolsieffer@hefring.com>

[ Upstream commit c73801ae4f22b390228ebf471d55668e824198b6 ]

On no-MMU, all futexes are treated as private because there is no need
to map a virtual address to physical to match the futex across
processes. This doesn't quite work though, because private futexes
include the current process's mm_struct as part of their key. This makes
it impossible for one process to wake up a shared futex being waited on
in another process.

Fix this bug by excluding the mm_struct from the key. With
a single address space, the futex address is already a unique key.

Fixes: 784bdf3bb694 ("futex: Assume all mappings are private on !MMU systems")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: André Almeida <andrealmeid@igalia.com>
Link: https://lore.kernel.org/r/20231019204548.1236437-2-ben.wolsieffer@hefring.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 764e73622b386..d42245170a7a0 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -570,7 +570,17 @@ static int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 	 *        but access_ok() should be faster than find_vma()
 	 */
 	if (!fshared) {
-		key->private.mm = mm;
+		/*
+		 * On no-MMU, shared futexes are treated as private, therefore
+		 * we must not include the current process in the key. Since
+		 * there is only one address space, the address is a unique key
+		 * on its own.
+		 */
+		if (IS_ENABLED(CONFIG_MMU))
+			key->private.mm = mm;
+		else
+			key->private.mm = NULL;
+
 		key->private.address = address;
 		return 0;
 	}
-- 
2.42.0



