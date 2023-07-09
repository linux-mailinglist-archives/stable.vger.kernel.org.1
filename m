Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2944574C253
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGILTU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjGILTT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:19:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9925B130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:19:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2427460BD6
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AD6C433C8;
        Sun,  9 Jul 2023 11:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901557;
        bh=44wYcN7dU3HjPXSPPhoYLcbj/0dBYkBjyGKjKQzP/0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AwEUvKDnPpHwdr4V/uufPXUnUENuDvlolUMrKYQBOPOlrphNngHHQQQEQMZEr3tVu
         aystpxCRCK7MC0L6NVGCexVmO0P5sljVSrk7sH36nokClCCLZ1lQeXt/HPkJi7CcKd
         EhnLNyplPIiE2gELP2qwB2bXXZ3sw7weSfzfaQy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wen Yang <wenyang.linux@foxmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 034/431] tick/rcu: Fix bogus ratelimit condition
Date:   Sun,  9 Jul 2023 13:09:42 +0200
Message-ID: <20230709111451.897136502@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wen Yang <wenyang.linux@foxmail.com>

[ Upstream commit a7e282c77785c7eabf98836431b1f029481085ad ]

The ratelimit logic in report_idle_softirq() is broken because the
exit condition is always true:

	static int ratelimit;

	if (ratelimit < 10)
		return false;  ---> always returns here

	ratelimit++;           ---> no chance to run

Make it check for >= 10 instead.

Fixes: 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/tencent_5AAA3EEAB42095C9B7740BE62FBF9A67E007@qq.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d6fb6a676bbbb..1ad89eec2a55f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1046,7 +1046,7 @@ static bool report_idle_softirq(void)
 			return false;
 	}
 
-	if (ratelimit < 10)
+	if (ratelimit >= 10)
 		return false;
 
 	/* On RT, softirqs handling may be waiting on some lock */
-- 
2.39.2



