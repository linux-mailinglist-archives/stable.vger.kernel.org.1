Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9F1713EEF
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjE1TkX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjE1TkV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D89EAB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D120361EAB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF81FC433D2;
        Sun, 28 May 2023 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302816;
        bh=d2iGA6U1G93m7fcgvIrolP/V/MrOkik0/FSmaX4JwkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rIES2t52Ib329q7xWc58FfKRxqWltL9Aqw0HDNeEtL+NtQZTsAmWi8lJjCh06k9N4
         KkOrg/Y0I/d/C5bX/QVYDjBVBdKwPNjv61oNmREihV8pRTEXHrghfrCnPCAJUSWSPX
         jPmaorH0snjlhpUPm4KoY9Jl1JeD6gGQycYbLodw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 038/211] ACPI: EC: Fix oops when removing custom query handlers
Date:   Sun, 28 May 2023 20:09:19 +0100
Message-Id: <20230528190844.490565683@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
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
index 4707d1808ca54..487884420fb0d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1114,6 +1114,7 @@ static void acpi_ec_remove_query_handlers(struct acpi_ec *ec,
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 {
 	acpi_ec_remove_query_handlers(ec, false, query_bit);
+	flush_workqueue(ec_query_wq);
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
-- 
2.39.2



