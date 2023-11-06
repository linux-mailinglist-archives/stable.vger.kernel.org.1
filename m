Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1027E257E
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjKFNcu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjKFNct (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:32:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C002010B
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:32:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025B3C433C7;
        Mon,  6 Nov 2023 13:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277565;
        bh=7wmXqJXf3F1/JkamQxr0R2dQgft8cZPEPTF0hIHSGAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjCP7p5NqmvxVSABNvhf3nNsZLpTCjLJKucDqvDLWp/AZNZdKXZmdMcpr9KE4rryW
         mWAgY8G9OCEhyqrY8kqlQYj2MeGHCL5C7KfRBGOjvRaTD8t9CvmHzXiP6lWNubxEus
         eaFpHkgzoZaASagavd5tW+i+UxrA8xEaSRE0G0rE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Yujie Liu <yujie.liu@intel.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH 5.10 32/95] tracing/kprobes: Fix the description of variable length arguments
Date:   Mon,  6 Nov 2023 14:04:00 +0100
Message-ID: <20231106130305.887811019@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yujie Liu <yujie.liu@intel.com>

commit e0f831836cead677fb07d54bd6bf499df35640c2 upstream.

Fix the following kernel-doc warnings:

kernel/trace/trace_kprobe.c:1029: warning: Excess function parameter 'args' description in '__kprobe_event_gen_cmd_start'
kernel/trace/trace_kprobe.c:1097: warning: Excess function parameter 'args' description in '__kprobe_event_add_fields'

Refer to the usage of variable length arguments elsewhere in the kernel
code, "@..." is the proper way to express it in the description.

Link: https://lore.kernel.org/all/20231027041315.2613166-1-yujie.liu@intel.com/

Fixes: 2a588dd1d5d6 ("tracing: Add kprobe event command generation functions")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310190437.paI6LYJF-lkp@intel.com/
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_kprobe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -952,7 +952,7 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init)
  * @name: The name of the kprobe event
  * @loc: The location of the kprobe event
  * @kretprobe: Is this a return probe?
- * @args: Variable number of arg (pairs), one pair for each field
+ * @...: Variable number of arg (pairs), one pair for each field
  *
  * NOTE: Users normally won't want to call this function directly, but
  * rather use the kprobe_event_gen_cmd_start() wrapper, which automatically
@@ -1025,7 +1025,7 @@ EXPORT_SYMBOL_GPL(__kprobe_event_gen_cmd
 /**
  * __kprobe_event_add_fields - Add probe fields to a kprobe command from arg list
  * @cmd: A pointer to the dynevent_cmd struct representing the new event
- * @args: Variable number of arg (pairs), one pair for each field
+ * @...: Variable number of arg (pairs), one pair for each field
  *
  * NOTE: Users normally won't want to call this function directly, but
  * rather use the kprobe_event_add_fields() wrapper, which


