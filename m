Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFF675D4FC
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjGUT1R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjGUT1Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07813AAF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42F3361D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52696C433C8;
        Fri, 21 Jul 2023 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967614;
        bh=YRq3MRXQ/9ed3BU9vGD3EL5xWyQL8+zGkJVnrb0ScqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bj1ZVV9ZAQUU8lUMsgacbOUQU2U++AfCPRUxfJ5C6ugTK/f4skormQqVHkQ7rR+1a
         51/XkWwcGJDOvxrFfkAao6bqNI0CTEzFfDYyUDd1+GyHuhAG0MnP1pC1EsLQssiyQa
         8YwqRvmQ+hjGSFLbEvf6ri9CKzVMnTiqTft+RJ9o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH 6.1 203/223] tracing/probes: Fix to update dynamic data counter if fetcharg uses it
Date:   Fri, 21 Jul 2023 18:07:36 +0200
Message-ID: <20230721160529.530074643@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

commit e38e2c6a9efc435f9de344b7c91f7697e01b47d5 upstream.

Fix to update dynamic data counter ('dyndata') and max length ('maxlen')
only if the fetcharg uses the dynamic data. Also get out arg->dynamic
from unlikely(). This makes dynamic data address wrong if
process_fetch_insn() returns error on !arg->dynamic case.

Link: https://lore.kernel.org/all/168908494781.123124.8160245359962103684.stgit@devnote2/

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Link: https://lore.kernel.org/all/20230710233400.5aaf024e@gandalf.local.home/
Fixes: 9178412ddf5a ("tracing: probeevent: Return consumed bytes of dynamic area")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_probe_tmpl.h |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -206,11 +206,13 @@ store_trace_args(void *data, struct trac
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
 		ret = process_fetch_insn(arg->code, rec, dl, base);
-		if (unlikely(ret < 0 && arg->dynamic)) {
-			*dl = make_data_loc(0, dyndata - base);
-		} else {
-			dyndata += ret;
-			maxlen -= ret;
+		if (arg->dynamic) {
+			if (unlikely(ret < 0)) {
+				*dl = make_data_loc(0, dyndata - base);
+			} else {
+				dyndata += ret;
+				maxlen -= ret;
+			}
 		}
 	}
 }


