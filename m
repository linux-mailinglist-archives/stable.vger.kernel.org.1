Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0321713C3D
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjE1TN1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjE1TN0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:13:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D65A2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:13:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A9456158D
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21940C433D2;
        Sun, 28 May 2023 19:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301204;
        bh=DcjXekO6d7vfiiA44MWWCEOPfLjA8/jcAX3MbvESGyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9J0paz2F4ikgl0JwO8NwNDkTrP4v7RMy4MAweNLAauACjzCUqAklqfb6UZjhyQ8g
         un2YvHChYzu7MkZc/CX0uVpz927SVBNSH5M843mUPmQ1YS61a54ONzrAMwxhv/JqKU
         H/p3OLyLEvK7wrrtHUN9BJlBA4eNz3mO4weRE0jo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 09/86] ACPI: EC: Fix oops when removing custom query handlers
Date:   Sun, 28 May 2023 20:09:43 +0100
Message-Id: <20230528190828.894241558@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.564682883@linuxfoundation.org>
References: <20230528190828.564682883@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit e5b492c6bb900fcf9722e05f4a10924410e170c1 ]

When removing custom query handlers, the handler might still
be used inside the EC query workqueue, causing a kernel oops
if the module holding the callback function was already unloaded.

Fix this by flushing the EC query workqueue when removing
custom query handlers.

Tested on a Acer Travelmate 4002WLMi

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index f8fc30be68711..1dedab328c464 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1135,6 +1135,7 @@ static void acpi_ec_remove_query_handlers(struct acpi_ec *ec,
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 {
 	acpi_ec_remove_query_handlers(ec, false, query_bit);
+	flush_workqueue(ec_query_wq);
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
-- 
2.39.2



