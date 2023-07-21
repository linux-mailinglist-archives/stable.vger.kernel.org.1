Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4206C75D190
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjGUSuO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGUSuN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:50:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0176530CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 944DD61D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A502EC433C7;
        Fri, 21 Jul 2023 18:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965412;
        bh=feYMWgQ6hmqnIpf9xz6ddBfNzTOy4Q7lLVEwF7oy/2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0DqmgZzNwv8bl57/6GKNf2S1LycItikLzuy/zOlCyjUZsxP8kA75JpjqPo3fK9suI
         Hse2TlkHNahGYhTnuQoJ5bMSzZ8+yFEpCVCzinDRFaB54nzyeksUQp+MU4T1SXLGLz
         rXoIK/kPh5EPjoKKHoDue9ysBvlLgXNo8miH+gwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Beau Belgrave <beaub@linux.microsoft.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.4 274/292] tracing/user_events: Fix struct arg size match check
Date:   Fri, 21 Jul 2023 18:06:23 +0200
Message-ID: <20230721160540.706505889@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

commit d0a3022f30629a208e5944022caeca3568add9e7 upstream.

When users register an event the name of the event and it's argument are
checked to ensure they match if the event already exists. Normally all
arguments are in the form of "type name", except for when the type
starts with "struct ". In those cases, the size of the struct is passed
in addition to the name, IE: "struct my_struct a 20" for an argument
that is of type "struct my_struct" with a field name of "a" and has the
size of 20 bytes.

The current code does not honor the above case properly when comparing
a match. This causes the event register to fail even when the same
string was used for events that contain a struct argument within them.
The example above "struct my_struct a 20" generates a match string of
"struct my_struct a" omitting the size field.

Add the struct size of the existing field when generating a comparison
string for a struct field to ensure proper match checking.

Link: https://lkml.kernel.org/r/20230629235049.581-2-beaub@linux.microsoft.com

Cc: stable@vger.kernel.org
Fixes: e6f89a149872 ("tracing/user_events: Ensure user provided strings are safely formatted")
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events_user.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1317,6 +1317,9 @@ static int user_field_set_string(struct
 	pos += snprintf(buf + pos, LEN_OR_ZERO, " ");
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "%s", field->name);
 
+	if (str_has_prefix(field->type, "struct "))
+		pos += snprintf(buf + pos, LEN_OR_ZERO, " %d", field->size);
+
 	if (colon)
 		pos += snprintf(buf + pos, LEN_OR_ZERO, ";");
 


