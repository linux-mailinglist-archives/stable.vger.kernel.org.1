Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086737613AF
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjGYLM4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjGYLMl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A709A2129
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:11:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BC616166F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C3EC433C7;
        Tue, 25 Jul 2023 11:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283511;
        bh=b45XEIsHvdqdYO2vFL8jFpVFFY20ZjasJ521Q5g5o9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ei3rKHZB5UIS71BGkW/N7Fp70rck27LLNELBEQak/JdTtU79lzycqCZIU8CYsvfQ2
         Loxt12gfdyxOoMygxL2k/wZgAl91knmGlcZPF1HpHNWbQi3C4HLByaJuW9E7v00jKG
         D7NVizHbCs6IdDy5djkGOp+zprm1IM9XZL9ahDU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 023/509] tracing/timer: Add missing hrtimer modes to decode_hrtimer_mode().
Date:   Tue, 25 Jul 2023 12:39:22 +0200
Message-ID: <20230725104554.712719052@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 2951580ba6adb082bb6b7154a5ecb24e7c1f7569 ]

The trace output for the HRTIMER_MODE_.*_HARD modes is seen as a number
since these modes are not decoded. The author was not aware of the fancy
decoding function which makes the life easier.

Extend decode_hrtimer_mode() with the additional HRTIMER_MODE_.*_HARD
modes.

Fixes: ae6683d815895 ("hrtimer: Introduce HARD expiry mode")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20230418143854.8vHWQKLM@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/timer.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 40e9b5a12732d..5c540ccabcac9 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -156,7 +156,11 @@ DEFINE_EVENT(timer_class, timer_cancel,
 		{ HRTIMER_MODE_ABS_SOFT,	"ABS|SOFT"	},	\
 		{ HRTIMER_MODE_REL_SOFT,	"REL|SOFT"	},	\
 		{ HRTIMER_MODE_ABS_PINNED_SOFT,	"ABS|PINNED|SOFT" },	\
-		{ HRTIMER_MODE_REL_PINNED_SOFT,	"REL|PINNED|SOFT" })
+		{ HRTIMER_MODE_REL_PINNED_SOFT,	"REL|PINNED|SOFT" },	\
+		{ HRTIMER_MODE_ABS_HARD,	"ABS|HARD" },		\
+		{ HRTIMER_MODE_REL_HARD,	"REL|HARD" },		\
+		{ HRTIMER_MODE_ABS_PINNED_HARD, "ABS|PINNED|HARD" },	\
+		{ HRTIMER_MODE_REL_PINNED_HARD,	"REL|PINNED|HARD" })
 
 /**
  * hrtimer_init - called when the hrtimer is initialized
-- 
2.39.2



