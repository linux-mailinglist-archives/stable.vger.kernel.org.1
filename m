Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3445B74C22D
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGILRk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGILRk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:17:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161E013D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A977660BD6
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF1FC433C8;
        Sun,  9 Jul 2023 11:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901458;
        bh=CXJPnuNPVFbreSBqxV+PzZP85Lus4EBNuYijVPTflRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IW4VbQlRNdklZZML34J3r9EjON/5c5h6ONPNiYWFQwUsILSlU1w/Zb86VpfAaXvbI
         pXo+Lc8SUyu2We1DpmjDyVxPHJAD550NbZyy9KnKqUrC5++IEdhemyz5snZH3ZKCWw
         D1CFfFBMaSwLKjOhYdrDJBJZiBGhz0B43aiGv0Q8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, yangqiming <yangqiming@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 027/431] irqchip/loongson-eiointc: Fix irq affinity setting during resume
Date:   Sun,  9 Jul 2023 13:09:35 +0200
Message-ID: <20230709111451.736909026@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jianmin Lv <lvjianmin@loongson.cn>

[ Upstream commit fb07b8f83441febeb0daf199b5f18c6de9bbab03 ]

The hierarchy of PCH PIC, PCH PCI MSI and EIONTC is as following:

        PCH PIC ------->|
                        |---->EIOINTC
        PCH PCI MSI --->|

so the irq_data list of irq_desc for IRQs on PCH PIC and PCH PCI MSI
is like this:

irq_desc->irq_data(domain: PCH PIC)->parent_data(domain: EIOINTC)
irq_desc->irq_data(domain: PCH PCI MSI)->parent_data(domain: EIOINTC)

In eiointc_resume(), the irq_data passed into eiointc_set_irq_affinity()
should be matched to EIOINTC domain instead of PCH PIC or PCH PCI MSI
domain, so fix it.

Fixes: a90335c2dfb4 ("irqchip/loongson-eiointc: Add suspend/resume support")

Reported-by: yangqiming <yangqiming@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230614115936.5950-6-lvjianmin@loongson.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-loongson-eiointc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 90181c42840b4..873a326ed6cbc 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -317,7 +317,7 @@ static void eiointc_resume(void)
 			desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
 			if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
 				raw_spin_lock(&desc->lock);
-				irq_data = &desc->irq_data;
+				irq_data = irq_domain_get_irq_data(eiointc_priv[i]->eiointc_domain, irq_desc_get_irq(desc));
 				eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
 				raw_spin_unlock(&desc->lock);
 			}
-- 
2.39.2



