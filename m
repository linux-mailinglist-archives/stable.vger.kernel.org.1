Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1629F7ECFFA
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjKOTwE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbjKOTwC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:52:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1035CC2
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:52:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840E2C433C8;
        Wed, 15 Nov 2023 19:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077919;
        bh=GM5oCnp6ZqXLCwZKSz3r+P1VNV7VySmV0DBJ9WgLLMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qn4JP4+Fz96Vt6aJNs7dgm1HqAgPFfH4+1M72WvPAzK+c/FT2gbLH0/vw4KHgG+Vs
         gWdRiew/ZyCZh03Dcw+dn1CnRE9H9CGlSwTlOfNjz7C2U3ZPb05vKvDvzKB8YDDh+t
         EAVOEnrLN9Ul1Sdm5Ll+AxZblOdrvKc0nSatO9Eo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mukesh Ojha <quic_mojha@quicinc.com>,
        Yujie Liu <yujie.liu@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 594/603] tracing/kprobes: Fix the order of argument descriptions
Date:   Wed, 15 Nov 2023 14:18:59 -0500
Message-ID: <20231115191652.272530075@linuxfoundation.org>
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

From: Yujie Liu <yujie.liu@intel.com>

[ Upstream commit f032c53bea6d2057c14553832d846be2f151cfb2 ]

The order of descriptions should be consistent with the argument list of
the function, so "kretprobe" should be the second one.

int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
                                 const char *name, const char *loc, ...)

Link: https://lore.kernel.org/all/20231031041305.3363712-1-yujie.liu@intel.com/

Fixes: 2a588dd1d5d6 ("tracing: Add kprobe event command generation functions")
Suggested-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_kprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e834f149695b7..47812aa16bb57 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1020,9 +1020,9 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
 /**
  * __kprobe_event_gen_cmd_start - Generate a kprobe event command from arg list
  * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @kretprobe: Is this a return probe?
  * @name: The name of the kprobe event
  * @loc: The location of the kprobe event
- * @kretprobe: Is this a return probe?
  * @...: Variable number of arg (pairs), one pair for each field
  *
  * NOTE: Users normally won't want to call this function directly, but
-- 
2.42.0



