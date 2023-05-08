Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3446FAA2C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjEHLA0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbjEHK7l (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860F92BCED
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62D0162A05
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FADDC433EF;
        Mon,  8 May 2023 10:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543495;
        bh=i6hwX11FH4O84Q+vdT5kVWOBAbcTXMl+z8vkTWxiA8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1cYyQnL+PR0ZzZ8P1jy1l0RN4oetxcNzPrtGtR1KMgkXNglO58J9kUW3wReEafRwD
         L1RJT7Ah6b2UrIbvZQkGcLI0PS9FHHJ5vlX1gVAczPI1cDFKhjUWpPboOFZTXkguq7
         dLuPHZgShiFk6PIRBTH4V7RWfFFVgFUOSiemm3WE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.3 081/694] tracing: Fix permissions for the buffer_percent file
Date:   Mon,  8 May 2023 11:38:36 +0200
Message-Id: <20230508094435.162180838@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ondrej Mosnacek <omosnace@redhat.com>

commit 4f94559f40ad06d627c0fdfc3319cec778a2845b upstream.

This file defines both read and write operations, yet it is being
created as read-only. This means that it can't be written to without the
CAP_DAC_OVERRIDE capability. Fix the permissions to allow root to write
to it without the need to override DAC perms.

Link: https://lore.kernel.org/linux-trace-kernel/20230503140114.3280002-1-omosnace@redhat.com

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 03329f993978 ("tracing: Add tracefs file buffer_percentage")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9658,7 +9658,7 @@ init_tracer_tracefs(struct trace_array *
 
 	tr->buffer_percent = 50;
 
-	trace_create_file("buffer_percent", TRACE_MODE_READ, d_tracer,
+	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
 			tr, &buffer_percent_fops);
 
 	create_trace_options_dir(tr);


