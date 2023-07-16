Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B67755421
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjGPU1I (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjGPU1H (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:27:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27F010FB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B337360EC3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6071C433C8;
        Sun, 16 Jul 2023 20:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539215;
        bh=/r9coQI/c86bfz2AzFJBAcdPN/2Tw5gNz52TjejPKc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDPzBuAW0BRGMuEnepMqNMF24y39d/7GiH7tFi7QcQJACTujAiOw12s84oUMa3iN4
         jh41tNxRDX+D7M12x3hY0uJ/wWD7abMMqrj1SGLKiu3Q0ocp8+I+eMnG7eckImy7Hp
         LQXNUuZg8S2YHUEJtSTPlRL9+XLmzpf7RFGl+hAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.4 721/800] irqchip/loongson-pch-pic: Fix potential incorrect hwirq assignment
Date:   Sun, 16 Jul 2023 21:49:34 +0200
Message-ID: <20230716195005.866220856@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Liu Peibao <liupeibao@loongson.cn>

commit 783422e704ca0fa41cb2fe9ed79e46b6fe7eae29 upstream.

In DeviceTree path, when ht_vec_base is not zero, the hwirq of PCH PIC
will be assigned incorrectly. Because when pch_pic_domain_translate()
adds the ht_vec_base to hwirq, the hwirq does not have the ht_vec_base
subtracted when calling irq_domain_set_info().

The ht_vec_base is designed for the parent irq chip/domain of the PCH PIC.
It seems not proper to deal this in callbacks of the PCH PIC domain and
let's put this back like the initial commit ef8c01eb64ca ("irqchip: Add
Loongson PCH PIC controller").

Fixes: bcdd75c596c8 ("irqchip/loongson-pch-pic: Add ACPI init support")
Cc: stable@vger.kernel.org
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230614115936.5950-3-lvjianmin@loongson.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-loongson-pch-pic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -164,7 +164,7 @@ static int pch_pic_domain_translate(stru
 		if (fwspec->param_count < 2)
 			return -EINVAL;
 
-		*hwirq = fwspec->param[0] + priv->ht_vec_base;
+		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 	} else {
 		if (fwspec->param_count < 1)
@@ -196,7 +196,7 @@ static int pch_pic_alloc(struct irq_doma
 
 	parent_fwspec.fwnode = domain->parent->fwnode;
 	parent_fwspec.param_count = 1;
-	parent_fwspec.param[0] = hwirq;
+	parent_fwspec.param[0] = hwirq + priv->ht_vec_base;
 
 	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
 	if (err)


