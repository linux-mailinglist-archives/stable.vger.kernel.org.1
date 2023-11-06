Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00137E2565
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjKFNba (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjKFNb3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:31:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BB3191
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:31:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA319C433C7;
        Mon,  6 Nov 2023 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277486;
        bh=47Zs9sWPoqf7GhbBRhdGTqZJDIOIle82LLL+pHbfkMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fORemOu9V4USkLGPOCDanuv4AuqSprhuIRW6QV/nxyi51jCwp6nRA18/oaWAR0H2o
         o1kGmLQOZohBUX3HP3xvb1avBOu1OfxfKjAuqyzVeZmsBqxhfpds22vW5vmCkHVNkE
         0EVm4lewPfLBJBq9zcapgewfiavtoJFqj6E0mKhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Philip Daly <pdaly@redhat.com>,
        "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.10 39/95] clk: Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name
Date:   Mon,  6 Nov 2023 14:04:07 +0100
Message-ID: <20231106130306.141946646@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alessandro Carminati <alessandro.carminati@gmail.com>

commit ceb87a361d0b079ecbc7d2831618c19087f304a9 upstream.

In the possible_parent_show function, ensure proper handling of the return
value from of_clk_get_parent_name to prevent potential issues arising from
a NULL return.
The current implementation invokes seq_puts directly on the result of
of_clk_get_parent_name without verifying the return value, which can lead
to kernel panic if the function returns NULL.

This patch addresses the concern by introducing a check on the return
value of of_clk_get_parent_name. If the return value is not NULL, the
function proceeds to call seq_puts, providing the returned value as
argument.
However, if of_clk_get_parent_name returns NULL, the function provides a
static string as argument, avoiding the panic.

Fixes: 1ccc0ddf046a ("clk: Use seq_puts() in possible_parent_show()")
Reported-by: Philip Daly <pdaly@redhat.com>
Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
Link: https://lore.kernel.org/r/20230921073217.572151-1-alessandro.carminati@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3167,6 +3167,7 @@ static void possible_parent_show(struct
 				 unsigned int i, char terminator)
 {
 	struct clk_core *parent;
+	const char *name = NULL;
 
 	/*
 	 * Go through the following options to fetch a parent's name.
@@ -3181,18 +3182,20 @@ static void possible_parent_show(struct
 	 * registered (yet).
 	 */
 	parent = clk_core_get_parent_by_index(core, i);
-	if (parent)
+	if (parent) {
 		seq_puts(s, parent->name);
-	else if (core->parents[i].name)
+	} else if (core->parents[i].name) {
 		seq_puts(s, core->parents[i].name);
-	else if (core->parents[i].fw_name)
+	} else if (core->parents[i].fw_name) {
 		seq_printf(s, "<%s>(fw)", core->parents[i].fw_name);
-	else if (core->parents[i].index >= 0)
-		seq_puts(s,
-			 of_clk_get_parent_name(core->of_node,
-						core->parents[i].index));
-	else
-		seq_puts(s, "(missing)");
+	} else {
+		if (core->parents[i].index >= 0)
+			name = of_clk_get_parent_name(core->of_node, core->parents[i].index);
+		if (!name)
+			name = "(missing)";
+
+		seq_puts(s, name);
+	}
 
 	seq_putc(s, terminator);
 }


