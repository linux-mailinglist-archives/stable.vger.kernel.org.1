Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F5778AC29
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjH1Khs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjH1KhM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA91AA7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8970C63F25
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0C8C433C8;
        Mon, 28 Aug 2023 10:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219029;
        bh=1i0CVaNZIZo1kuzhJZwKXkYgaMpUDI0HfsumnCIkFrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=izpnYVIPFgCJwfLCEq7f/v997HR/eUz15BbDATXPcoZnyCMq4+ZzNQr8qXkSIsnTe
         ohOaqDyABwvr9hRaOFFiMgyBWghFtENLWIflgsl7G5OPARD988aKltXF2Q7/FJ3Bwt
         m27IhZOOh9tisfZeI5sgHzp5QrSg8NlINIM804H0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 048/158] tracing/probes: Fix to update dynamic data counter if fetcharg uses it
Date:   Mon, 28 Aug 2023 12:12:25 +0200
Message-ID: <20230828101158.957370858@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[ Upstream commit e38e2c6a9efc435f9de344b7c91f7697e01b47d5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe_tmpl.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index bbb479b3ba8fd..cf14a37dff8c8 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -206,11 +206,13 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
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
-- 
2.40.1



