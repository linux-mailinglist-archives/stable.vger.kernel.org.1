Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EA67615EF
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjGYLep (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbjGYLeo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:34:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E858BF3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:34:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DF7261691
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE15C433C7;
        Tue, 25 Jul 2023 11:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284882;
        bh=o1aIdVDZtP8Jax4ru05Maq2K3TL6F0y8Ihq2D4+uU3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4J8jUpFrcyXM2ArZK/FkmFo6UoixQMT0frkYelZdzf8CjgOHc2Oy1vadp+rmh/Nh
         CS6AX2YVJ4E+bU0O6t9VKzdcsuAsjg2Seq6pl7v5hA1BnOre3AbDKYssbtaFcQPygi
         Ksp9I1mC4z6Q6ozWxpgvPuOu5qwiSbYRoSOzkbHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mohamed Khalfella <mkhalfella@purestorage.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.10 506/509] tracing/histograms: Return an error if we fail to add histogram to hist_vars list
Date:   Tue, 25 Jul 2023 12:47:25 +0200
Message-ID: <20230725104616.883265318@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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
@@ -5822,7 +5822,8 @@ static int event_hist_trigger_func(struc
 		goto out_unreg;
 
 	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
-		if (save_hist_vars(hist_data))
+		ret = save_hist_vars(hist_data);
+		if (ret)
 			goto out_unreg;
 	}
 


