Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917007D33BC
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjJWLdd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjJWLdc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:33:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A27E8
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:33:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40483C433C7;
        Mon, 23 Oct 2023 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060810;
        bh=xoAL4ZOfMug1y+DwsCVPcveqrGIzIXMclj/31Lvfjks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLJj00NF1DYXwrq/YnAmjY/9YDO17DBGs3LmJ+tqiuz+8K0Ahwm0Smrb/QtHZd+16
         LvAVguKcX1iZ+wo1IOhBs3swtDaZHOEv0EsNkKiTSLrUpiHzCWq0dxouAx7R/xAu0j
         8Ne+cMiOxoDqFoF/yMEw25FIxq7SuOT3oCXOILxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Garry <john.garry@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 073/123] resource: Add irqresource_disabled()
Date:   Mon, 23 Oct 2023 12:57:11 +0200
Message-ID: <20231023104820.128885809@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Garry <john.garry@huawei.com>

[ Upstream commit 9806731db684a475ade1e95d166089b9edbd9da3 ]

Add a common function to set the fields for a irq resource to disabled,
which mimics what is done in acpi_dev_irqresource_disabled(), with a view
to replace that function.

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/1606905417-183214-3-git-send-email-john.garry@huawei.com
Stable-dep-of: c1ed72171ed5 ("ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ioport.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index fdc201d614607..d94db8d6df52a 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -300,6 +300,13 @@ struct resource *devm_request_free_mem_region(struct device *dev,
 struct resource *request_free_mem_region(struct resource *base,
 		unsigned long size, const char *name);
 
+static inline void irqresource_disabled(struct resource *res, u32 irq)
+{
+	res->start = irq;
+	res->end = irq;
+	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
+}
+
 #ifdef CONFIG_IO_STRICT_DEVMEM
 void revoke_devmem(struct resource *res);
 #else
-- 
2.40.1



