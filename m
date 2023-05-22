Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CED870C71F
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjEVT0E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjEVT0D (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:26:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF5C9C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 345B0628A1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418DCC433EF;
        Mon, 22 May 2023 19:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783561;
        bh=4P211YT8/0M0fmViOACoSJ0/RAqxd5CBjxbTUNuJyJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sdV31JYhtKEbWSlyDiKLhsSTQMLN6ac+fnhCQVbshZeE+fswIDrMYWYlnxiJUiKwM
         0KyKKetpCqgxubw10q89DL1vmzlIpTOKOFBI0sLuSBQjxhMO7AXTndlf5LPxh5TLV6
         rlUb793jp/MZnfIK2Q/FYctPcDzn+/h8ym/UXJP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 058/292] ACPI: EC: Fix oops when removing custom query handlers
Date:   Mon, 22 May 2023 20:06:55 +0100
Message-Id: <20230522190407.392381804@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 9751b84c1b221..ee4c812c8f6cc 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1121,6 +1121,7 @@ static void acpi_ec_remove_query_handlers(struct acpi_ec *ec,
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 {
 	acpi_ec_remove_query_handlers(ec, false, query_bit);
+	flush_workqueue(ec_query_wq);
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
-- 
2.39.2



