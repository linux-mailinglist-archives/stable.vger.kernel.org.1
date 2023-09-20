Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556D07A7B97
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjITLxi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbjITLxh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:53:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34826CE
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:53:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F30C433C8;
        Wed, 20 Sep 2023 11:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210811;
        bh=3FXbHG5XTst+mKgJnSW7ImAFOyynUu+H5zuqFuz9h8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKpJt6sXPEq1hI6JsyUSp6lzwqd0zd+vIluF61kicgDO0KKhoN5NGdGQsaaPUbkoj
         89vYfrKXJj6JHtrsCZ1MTA2xvlzLq8fCYxQfMpaAq5I4y4PegsF3tJM/UlTdj1Uz8t
         A/SmSKvzD48yUV62UkePiu721wrFkC/wJun9a4zE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tero Kristo <tero.kristo@linux.intel.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.5 187/211] tracing/synthetic: Print out u64 values properly
Date:   Wed, 20 Sep 2023 13:30:31 +0200
Message-ID: <20230920112851.670295143@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tero Kristo <tero.kristo@linux.intel.com>

commit 62663b849662c1a5126b6274d91671b90566ef13 upstream.

The synth traces incorrectly print pointer to the synthetic event values
instead of the actual value when using u64 type. Fix by addressing the
contents of the union properly.

Link: https://lore.kernel.org/linux-trace-kernel/20230911141704.3585965-1-tero.kristo@linux.intel.com

Fixes: ddeea494a16f ("tracing/synthetic: Use union instead of casts")
Cc: stable@vger.kernel.org
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 9897d0bfcab7..14cb275a0bab 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -337,7 +337,7 @@ static void print_synth_event_num_val(struct trace_seq *s,
 		break;
 
 	default:
-		trace_seq_printf(s, print_fmt, name, val, space);
+		trace_seq_printf(s, print_fmt, name, val->as_u64, space);
 		break;
 	}
 }
-- 
2.42.0



