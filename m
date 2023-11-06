Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8357E24D9
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjKFNZ4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjKFNZz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:25:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFCDD69
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:25:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609FAC433C8;
        Mon,  6 Nov 2023 13:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277150;
        bh=Cid7JzwXhEODJPEgJv0Az71wZcDyR+Hi2VXtQHLgqxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lOUZ8k/pkUMi+iSnRK2A8fry9sGIKkyU3pzA8SoDoDX9Zp2XsnYnV+J3Rp58v9E0a
         pqfO3iD0EW79oL54FqDLsb2KyarahpJTiRkh4WW+Je7jU4ERZgnl2ODdYJnuvceEkU
         +v8qQ0OGos6/XpMgO96KNqMaUrnGptGFdlfkCbF4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Philip Daly <pdaly@redhat.com>,
        "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.15 055/128] clk: Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name
Date:   Mon,  6 Nov 2023 14:03:35 +0100
Message-ID: <20231106130311.605832156@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3182,6 +3182,7 @@ static void possible_parent_show(struct
 				 unsigned int i, char terminator)
 {
 	struct clk_core *parent;
+	const char *name = NULL;
 
 	/*
 	 * Go through the following options to fetch a parent's name.
@@ -3196,18 +3197,20 @@ static void possible_parent_show(struct
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


