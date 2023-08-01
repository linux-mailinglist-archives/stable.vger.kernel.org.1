Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C7276ACF4
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjHAJYe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjHAJYR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:24:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2459BC6
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B65BA614FB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C845EC433C8;
        Tue,  1 Aug 2023 09:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881799;
        bh=zgUOmrEBsomrFKo/BlzugHtCPP/PhxZdt9GvXGusjKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXM1i67HS8pzzYIxh65mRMBXSR/pB8LfeOerAJfcNRIFfqe987yIEq+iWx7wGTlUP
         rJrXM/2XaDXBsln6Ois79bqCaTPQ7MRUT/lWMDP24W5cnwFinlxzbuLlaTzHnlcr1O
         vRGztPFUdpPZfU+VoMTuCyXSDhSShYbI3gWK/6PE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 034/155] tracing/probes: Fix to avoid double count of the string length on the array
Date:   Tue,  1 Aug 2023 11:19:06 +0200
Message-ID: <20230801091911.398314632@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[ Upstream commit 66bcf65d6cf0ca6540e2341e88ee7ef02dbdda08 ]

If an array is specified with the ustring or symstr, the length of the
strings are accumlated on both of 'ret' and 'total', which means the
length is double counted.
Just set the length to the 'ret' value for avoiding double counting.

Link: https://lore.kernel.org/all/168908492917.123124.15076463491122036025.stgit@devnote2/

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain/
Fixes: 88903c464321 ("tracing/probe: Add ustring type for user-space string")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe_tmpl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 21799fa813ca8..98ac09052fea4 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -136,11 +136,11 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 			code++;
 			goto array;
 		case FETCH_OP_ST_USTRING:
-			ret += fetch_store_strlen_user(val + code->offset);
+			ret = fetch_store_strlen_user(val + code->offset);
 			code++;
 			goto array;
 		case FETCH_OP_ST_SYMSTR:
-			ret += fetch_store_symstrlen(val + code->offset);
+			ret = fetch_store_symstrlen(val + code->offset);
 			code++;
 			goto array;
 		default:
-- 
2.39.2



