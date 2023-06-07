Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB28726C32
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjFGUbZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjFGUbV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:31:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324551706
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADA47644FE
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13A5C4339B;
        Wed,  7 Jun 2023 20:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169879;
        bh=VdXBLB94u1FakrTQHf+3OQU/q4bmnAr1xiJkQLcWOrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s22dXNmV0MwvYQiqvxTwpoNRgOR59dqMMpl5ov9SrlNZZdsE0kMolxAaBPaXXWWyI
         zw//gb8GMBjeqbY/sfaA0NBPuVIr4bp+OalA7ptrHcEQE6OZHR8/U9ZQwxOfmFXhjh
         Ki6dJ4iBoJ/wC6V1Bd7xXTCsJsiLZR3om8oOT7lM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 6.3 248/286] tracing/probe: trace_probe_primary_from_call(): checked list_first_entry
Date:   Wed,  7 Jun 2023 22:15:47 +0200
Message-ID: <20230607200931.398146574@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pietro Borrello <borrello@diag.uniroma1.it>

commit 81d0fa4cb4fc0e1a49c2b22f92c43d9fe972ebcf upstream.

All callers of trace_probe_primary_from_call() check the return
value to be non NULL. However, the function returns
list_first_entry(&tpe->probes, ...) which can never be NULL.
Additionally, it does not check for the list being possibly empty,
possibly causing a type confusion on empty lists.
Use list_first_entry_or_null() which solves both problems.

Link: https://lore.kernel.org/linux-trace-kernel/20230128-list-entry-null-check-v1-1-8bde6a3da2ef@diag.uniroma1.it/

Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_probe.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -308,7 +308,7 @@ trace_probe_primary_from_call(struct tra
 {
 	struct trace_probe_event *tpe = trace_probe_event_from_call(call);
 
-	return list_first_entry(&tpe->probes, struct trace_probe, list);
+	return list_first_entry_or_null(&tpe->probes, struct trace_probe, list);
 }
 
 static inline struct list_head *trace_probe_probe_list(struct trace_probe *tp)


