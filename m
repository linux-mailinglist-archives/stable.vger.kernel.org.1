Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F4975CE0D
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjGUQRE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjGUQQo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:16:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7843044A1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:15:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58B7161D26
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CDAC433C8;
        Fri, 21 Jul 2023 16:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956143;
        bh=j+lhCQDjnFl3aEG4Bo/KFDm6e3CaRFvxMWFYY88P/MM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g56F9J/mGoWHvI9UfUIn4+z3Cc5OzV6ADK2qExDU/2H5e9peJ4lOQeSxjuUpciq0s
         AV6T3X/DQ90KausPEzlsW+c/ZFTnw0v6a72dXV/6Jrnw9pya4k1HGcoMqYwBIDFfXA
         IPCH25F3abWOcmfLkq/eE0ZHYa2T3E4a/A9qhMK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Beau Belgrave <beaub@linux.microsoft.com>,
        sunliming <sunliming@kylinos.cn>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.4 140/292] tracing/user_events: Fix incorrect return value for writing operation when events are disabled
Date:   Fri, 21 Jul 2023 18:04:09 +0200
Message-ID: <20230721160534.871438682@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: sunliming <sunliming@kylinos.cn>

commit f6d026eea390d59787a6cdc2ef5c983d02e029d0 upstream.

The writing operation return the count of writes regardless of whether events
are enabled or disabled. Switch it to return -EBADF to indicates that the event
is disabled.

Link: https://lkml.kernel.org/r/20230626111344.19136-2-sunliming@kylinos.cn

Cc: stable@vger.kernel.org
7f5a08c79df35 ("user_events: Add minimal support for trace_event into ftrace")
Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events_user.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2096,7 +2096,8 @@ static ssize_t user_events_write_core(st
 
 		if (unlikely(faulted))
 			return -EFAULT;
-	}
+	} else
+		return -EBADF;
 
 	return ret;
 }


