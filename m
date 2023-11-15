Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE0A7ECF8C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjKOTtN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbjKOTtL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:49:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72D4C2
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:49:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26609C433C7;
        Wed, 15 Nov 2023 19:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077748;
        bh=c4YuRie9xhhmW29pwxA6y3tTCO1uESm7C0abb8biDwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQv0lp4aAg3UIGDncbTnbx5YlEdv+NxDAgFlg24DCzGfRTU0aT5DapSqo7/vGwFfI
         j0edL4yTKaHAHqItQxji+izZ9opS/r5z4JPu9mie38/sj418rDYBKCK5LUsjiMa8By
         a2MkI+IqO1KmILZuCjpRc90EJrFkG2eZIPMmc1W4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 473/603] powerpc/imc-pmu: Use the correct spinlock initializer.
Date:   Wed, 15 Nov 2023 14:16:58 -0500
Message-ID: <20231115191645.220240634@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 007240d59c11f87ac4f6cfc6a1d116630b6b634c ]

The macro __SPIN_LOCK_INITIALIZER() is implementation specific. Users
that desire to initialize a spinlock in a struct must use
__SPIN_LOCK_UNLOCKED().

Use __SPIN_LOCK_UNLOCKED() for the spinlock_t in imc_global_refc.

Fixes: 76d588dddc459 ("powerpc/imc-pmu: Fix use of mutex in IRQs disabled section")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230309134831.Nz12nqsU@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/perf/imc-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 9d229ef7f86ef..ada817c49b722 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -51,7 +51,7 @@ static int trace_imc_mem_size;
  * core and trace-imc
  */
 static struct imc_pmu_ref imc_global_refc = {
-	.lock = __SPIN_LOCK_INITIALIZER(imc_global_refc.lock),
+	.lock = __SPIN_LOCK_UNLOCKED(imc_global_refc.lock),
 	.id = 0,
 	.refc = 0,
 };
-- 
2.42.0



