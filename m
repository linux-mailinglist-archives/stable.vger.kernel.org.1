Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2761F735473
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjFSK4a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjFSKz4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:55:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE2319A1
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B757960BA1
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF7EC433C0;
        Mon, 19 Jun 2023 10:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172037;
        bh=A5zdteXpUM8no805DUNErwDVd2xG8Exjgq3OcfmlveI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYSRGm70BDzCzYSYpO5ALCEecp8CajgE7hHFcFuqC0+PauwmJDrvOtQG0rwNfWdGN
         WZdqwHB2tlT7cvBuCpq3pGIAspW4R9z9i9ocAbXAygk+CShlPyJogKEbZbqVtIoVQb
         QNpOL5MIaWRC+iH/3DgjjOPhNFtmi7pEMNos6DDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Julius Werner <jwerner@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 14/89] irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware issues
Date:   Mon, 19 Jun 2023 12:30:02 +0200
Message-ID: <20230619102138.937184726@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
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

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 44bd78dd2b8897f59b7e3963f088caadb7e4f047 ]

Some Chromebooks with Mediatek SoCs have a problem where the firmware
doesn't properly save/restore certain GICR registers. Newer
Chromebooks should fix this issue and we may be able to do firmware
updates for old Chromebooks. At the moment, the only known issue with
these Chromebooks is that we can't enable "pseudo NMIs" since the
priority register can be lost. Enabling "pseudo NMIs" on Chromebooks
with the problematic firmware causes crashes and freezes.

Let's detect devices with this problem and then disable "pseudo NMIs"
on them. We'll detect the problem by looking for the presence of the
"mediatek,broken-save-restore-fw" property in the GIC device tree
node. Any devices with fixed firmware will not have this property.

Our detection plan works because we never bake a Chromebook's device
tree into firmware. Instead, device trees are always bundled with the
kernel. We'll update the device trees of all affected Chromebooks and
then we'll never enable "pseudo NMI" on a kernel that is bundled with
old device trees. When a firmware update is shipped that fixes this
issue it will know to patch the device tree to remove the property.

In order to make this work, the quick detection mechanism of the GICv3
code is extended to be able to look for properties in addition to
looking at "compatible".

Reviewed-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230515131353.v2.2.I88dc0a0eb1d9d537de61604cd8994ecc55c0cac1@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-common.c |  8 ++++++--
 drivers/irqchip/irq-gic-common.h |  1 +
 drivers/irqchip/irq-gic-v3.c     | 20 ++++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index f47b41dfd0238..02828a16979af 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -29,7 +29,11 @@ void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data)
 {
 	for (; quirks->desc; quirks++) {
-		if (!of_device_is_compatible(np, quirks->compatible))
+		if (quirks->compatible &&
+		    !of_device_is_compatible(np, quirks->compatible))
+			continue;
+		if (quirks->property &&
+		    !of_property_read_bool(np, quirks->property))
 			continue;
 		if (quirks->init(data))
 			pr_info("GIC: enabling workaround for %s\n",
@@ -41,7 +45,7 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data)
 {
 	for (; quirks->desc; quirks++) {
-		if (quirks->compatible)
+		if (quirks->compatible || quirks->property)
 			continue;
 		if (quirks->iidr != (quirks->mask & iidr))
 			continue;
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index ccba8b0fe0f58..b42572d88f9f7 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -13,6 +13,7 @@
 struct gic_quirk {
 	const char *desc;
 	const char *compatible;
+	const char *property;
 	bool (*init)(void *data);
 	u32 iidr;
 	u32 mask;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 2805969e4f15a..c1f8c1be84856 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -35,6 +35,7 @@
 
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
+#define FLAGS_WORKAROUND_MTK_GICR_SAVE		(1ULL << 2)
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
@@ -1587,6 +1588,15 @@ static bool gic_enable_quirk_msm8996(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_mtk_gicr(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	d->flags |= FLAGS_WORKAROUND_MTK_GICR_SAVE;
+
+	return true;
+}
+
 static bool gic_enable_quirk_cavium_38539(void *data)
 {
 	struct gic_chip_data *d = data;
@@ -1622,6 +1632,11 @@ static const struct gic_quirk gic_quirks[] = {
 		.compatible = "qcom,msm8996-gic-v3",
 		.init	= gic_enable_quirk_msm8996,
 	},
+	{
+		.desc	= "GICv3: Mediatek Chromebook GICR save problem",
+		.property = "mediatek,broken-save-restore-fw",
+		.init	= gic_enable_quirk_mtk_gicr,
+	},
 	{
 		.desc	= "GICv3: HIP06 erratum 161010803",
 		.iidr	= 0x0204043b,
@@ -1658,6 +1673,11 @@ static void gic_enable_nmi_support(void)
 	if (!gic_prio_masking_enabled())
 		return;
 
+	if (gic_data.flags & FLAGS_WORKAROUND_MTK_GICR_SAVE) {
+		pr_warn("Skipping NMI enable due to firmware issues\n");
+		return;
+	}
+
 	ppi_nmi_refs = kcalloc(gic_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL);
 	if (!ppi_nmi_refs)
 		return;
-- 
2.39.2



