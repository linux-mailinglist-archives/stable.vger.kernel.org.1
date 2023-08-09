Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DA6775BCC
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjHILVI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbjHILVH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:21:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDECED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2531B631D8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33551C433C8;
        Wed,  9 Aug 2023 11:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580066;
        bh=zQj0mF09h+PsoflCAP/MixvTSZp8WKAFEJ9F/zbnAfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xrOZdyIS8GD6LPru7xZQqJbPMfSqkNi6i1H5hhGXHOlKWCP3vcJmh8mxKYx/jAXvK
         ufXlRqMZ70bd+/TE3BdLh3uUhhljH/fqq0PIomIsW5VlILxvOY2sgRe+sR3Yqhxgq0
         cqAJiVMaIJz7Oa2BiqGLbDptwgbvOF+KSSEeT8jQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mohamed Khalfella <mkhalfella@purestorage.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 216/323] tracing/histograms: Return an error if we fail to add histogram to hist_vars list
Date:   Wed,  9 Aug 2023 12:40:54 +0200
Message-ID: <20230809103707.994494332@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mohamed Khalfella <mkhalfella@purestorage.com>

commit 4b8b3905165ef98386a3c06f196c85d21292d029 upstream.

Commit 6018b585e8c6 ("tracing/histograms: Add histograms to hist_vars if
they have referenced variables") added a check to fail histogram creation
if save_hist_vars() failed to add histogram to hist_vars list. But the
commit failed to set ret to failed return code before jumping to
unregister histogram, fix it.

Link: https://lore.kernel.org/linux-trace-kernel/20230714203341.51396-1-mkhalfella@purestorage.com

Cc: stable@vger.kernel.org
Fixes: 6018b585e8c6 ("tracing/histograms: Add histograms to hist_vars if they have referenced variables")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events_hist.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5792,7 +5792,8 @@ static int event_hist_trigger_func(struc
 		goto out_unreg;
 
 	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
-		if (save_hist_vars(hist_data))
+		ret = save_hist_vars(hist_data);
+		if (ret)
 			goto out_unreg;
 	}
 


