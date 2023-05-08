Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F506FA407
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjEHJyX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjEHJyW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:54:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330AA25722
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:54:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC19B6221E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0361C4339B;
        Mon,  8 May 2023 09:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539660;
        bh=LCapMZ1+/LjFxFu3lU0qCm2SE4KyPiinndmiipswXZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PLGszKpCQeUzg4ROKayiAL9zUpgoFrmPvHfwT3CavRI2R87DoJN6qOllRgv7qO+8m
         ejfdIHsGZDrnLa/vgE+Bq28kBywKJl34NH7pWx2jCAlg8BmJomGJoW5C1rZxJ1L3Hw
         5amMY4odMJPz2zkSCrhouBHrFlM0DrzAHrYaSx78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.1 096/611] tracing: Fix permissions for the buffer_percent file
Date:   Mon,  8 May 2023 11:38:58 +0200
Message-Id: <20230508094425.332044972@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
@@ -9619,7 +9619,7 @@ init_tracer_tracefs(struct trace_array *
 
 	tr->buffer_percent = 50;
 
-	trace_create_file("buffer_percent", TRACE_MODE_READ, d_tracer,
+	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
 			tr, &buffer_percent_fops);
 
 	create_trace_options_dir(tr);


