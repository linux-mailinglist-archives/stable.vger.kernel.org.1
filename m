Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960917D3577
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjJWLsj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjJWLsj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:48:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13906AF
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:48:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A3AC433C8;
        Mon, 23 Oct 2023 11:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061716;
        bh=zPAvn1JhndAW43thYym5s8knzjqTyaWF+LNZ1JTK0no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8GVpPKlr9UrnXDoWlHsqOT01Djn7xEuGvtDjF5l5mNSsw04rVymd91giItNnr7iS
         a4BPZdntX99vG0XYwWe7imOgyt1HgwdZVDLZKomwYl5hs2xIMzly1TtcdRy5M+Ku7Q
         HFd8oGoDZF83luskRO4ri1+kNx74wKKyzBWKvMfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Garry <john.garry@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 123/202] ACPI: Drop acpi_dev_irqresource_disabled()
Date:   Mon, 23 Oct 2023 12:57:10 +0200
Message-ID: <20231023104830.125382853@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Garry <john.garry@huawei.com>

[ Upstream commit 1c3f69b4543af0aad514c127298e5ea40392575d ]

The functionality of acpi_dev_irqresource_disabled() is same as in common
irqresource_disabled(), so drop acpi_dev_irqresource_disabled() in favour
of that function.

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/1606905417-183214-4-git-send-email-john.garry@huawei.com
Stable-dep-of: c1ed72171ed5 ("ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index f2f5f1dc7c61d..20a7892c6d3fd 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -380,13 +380,6 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
 
-static void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
-{
-	res->start = gsi;
-	res->end = gsi;
-	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
-}
-
 static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 				     u8 triggering, u8 polarity, u8 shareable,
 				     bool legacy)
@@ -394,7 +387,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 	int irq, p, t;
 
 	if (!valid_IRQ(gsi)) {
-		acpi_dev_irqresource_disabled(res, gsi);
+		irqresource_disabled(res, gsi);
 		return;
 	}
 
@@ -426,7 +419,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 		res->start = irq;
 		res->end = irq;
 	} else {
-		acpi_dev_irqresource_disabled(res, gsi);
+		irqresource_disabled(res, gsi);
 	}
 }
 
@@ -463,7 +456,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 		 */
 		irq = &ares->data.irq;
 		if (index >= irq->interrupt_count) {
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 			return false;
 		}
 		acpi_dev_get_irqresource(res, irq->interrupts[index],
@@ -473,7 +466,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		ext_irq = &ares->data.extended_irq;
 		if (index >= ext_irq->interrupt_count) {
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 			return false;
 		}
 		if (is_gsi(ext_irq))
@@ -481,7 +474,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 					 ext_irq->triggering, ext_irq->polarity,
 					 ext_irq->shareable, false);
 		else
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 		break;
 	default:
 		res->flags = 0;
-- 
2.40.1



