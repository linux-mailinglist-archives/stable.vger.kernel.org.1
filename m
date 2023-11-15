Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC92D7ECE13
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjKOTkV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjKOTkQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:40:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA146D51
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:40:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACEBC433CA;
        Wed, 15 Nov 2023 19:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077209;
        bh=49da5BXOfKK6+TRQtEZoVevxdOJM87R6MzNoN8S7s9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLaq4OUNeYdBw6N8ARqddzVkTuUY1IsdVU8aK79bKcXPxt1eNO7as5Bt6CqfrE1I+
         yKLU0v3pKS1r3yEybGDDSVp8Z/IWmEC4tHwUCP34t0bt8A2G4hekMyRPVd8XVfhWvl
         hBb4I+OSrXMuteZx6/bozG/IOnEA3xg/L2Iugdo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mukesh Ojha <quic_mojha@quicinc.com>,
        Yujie Liu <yujie.liu@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 542/550] tracing/kprobes: Fix the order of argument descriptions
Date:   Wed, 15 Nov 2023 14:18:46 -0500
Message-ID: <20231115191638.500845887@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index c63e25cb9406e..d23b18cbdadd1 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1019,9 +1019,9 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
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



