Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E8E75432D
	for <lists+stable@lfdr.de>; Fri, 14 Jul 2023 21:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbjGNTWX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 15:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjGNTWW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 15:22:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D631BFA
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 12:22:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-262e5e71978so1459663a91.1
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 12:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1689362540; x=1691954540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MAy1Nmg9Ap1Qe0UwHvT/6xtuWqD4pHgiKYUbjAYyU40=;
        b=WKnOfHWdVmhkN7isgvYOXqKox4Cd1GAlUg7TbK46LrTxhFBYsUk2PsvxTqbrJF1Ff5
         XohvYMV2xNdZma3khBnSe4bvrxmxBp8PDZtZyJiMmv388jnhJh4d6vtfgUso1yxTFXuo
         HQdxTU43e71ouoVt5V45Q694F3sdAVn9Tv26recHjyLmxCp3XDUHSZP3DFDSqXELFtOT
         9F9kae8R2iyfvLFnajADd66G8hiB1E66qKA4ZjHQZZeIe4Z3GtG5zsM6pNxP5vPXNZ/Q
         18laIQw0NlAfhBmUg13pNWWZN2JCa8p1cGdhWld5u9Oq1BrFKU8zYFQYRuAcwoItbLSr
         oYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689362540; x=1691954540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAy1Nmg9Ap1Qe0UwHvT/6xtuWqD4pHgiKYUbjAYyU40=;
        b=dclwCGiIZsl6X0sJCwBUFiUQKT1SJ/wkflX3clsETO47WT3nq2HVfpQX6L4jzFIfZb
         WwZRq/TmL7xldBsiNEAPBcUB7ldYCqPQRp4wsMrvqT6AITyQ0M4mPd+C0KVBsDpnrxzz
         BCPT3HZfP3FnAf+jcwvDV7wzrvAIb87b0emishMeZF/PBkia2BMoeAuLKKHIKWUeEKoT
         J8Q/uM7/AyN68EfJFd9PxVeuv9cNB9P/21qolvL4UY3gPT2zUyTpoSa6EFFjsCSNiD4/
         ylPkQvji/9X72neEbHuoXX4yjIZo2hPC4tCJPujHAIsyLI7aWBL7boKf9b3CXegWTo9g
         IvnQ==
X-Gm-Message-State: ABy/qLavYMhfkaidEC7/6VaU40cjigLHk12KrYW1MucpAJZSf62SUyx4
        dRq32x158QnjROaoSOsuHYWpsdJNQzUeIMOkthONtQ==
X-Google-Smtp-Source: APBJJlFHW1hxE0Y+jKVjsjwsoL2NoUjnUmgyrdOBUsowtg6aP6QU8U85OoEZ7AvpE/BQV8qu1bgn/w==
X-Received: by 2002:a17:90a:43c6:b0:265:780e:5edc with SMTP id r64-20020a17090a43c600b00265780e5edcmr4957528pjg.10.1689362539885;
        Fri, 14 Jul 2023 12:22:19 -0700 (PDT)
Received: from gaia.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id 20-20020a17090a199400b00263ba6a248bsm1520537pji.1.2023.07.14.12.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 12:22:19 -0700 (PDT)
From:   Mohamed Khalfella <mkhalfella@purestorage.com>
To:     mkhalfella@purestorage.com
Cc:     stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org (open list:TRACING),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH] tracing/histograms: Return an error if we fail to add histogram to hist_vars list
Date:   Fri, 14 Jul 2023 19:21:43 +0000
Message-Id: <20230714192143.3656-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

If the code fails to add histogram to hist_vars list, then ret should
contain error code before jumping to unregister histogram.

Cc: stable@vger.kernel.org
Fixes: 6018b585e8c6 ("tracing/histograms: Add histograms to hist_vars if they have referenced variables")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 kernel/trace/trace_events_hist.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c8c61381eba4..d06938ae0717 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6668,7 +6668,8 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		goto out_unreg;
 
 	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
-		if (save_hist_vars(hist_data))
+		ret = save_hist_vars(hist_data);
+		if (ret)
 			goto out_unreg;
 	}
 
-- 
2.34.1

