Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52724703682
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbjEORKu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243735AbjEORKW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C598A68
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CB8E62B0A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B65AC433D2;
        Mon, 15 May 2023 17:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170522;
        bh=Q78DGS2MyicXtrjFMWMxC3toSrSzxb74uLDbtfm8efw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/eZM6QlrOWVt8bJwnW0VFO46nt1HiVuhKyjUhWUbq+f+tKZFvE9F3SM5fOEa+oSh
         av19sKVefEzthdwDHOP2cu0Qt/Ht9bYS/zAoMWJy9IbfRfXCK7cMRP6Y+fiXetgfDx
         bSFRopX2ert+Jh133LD/seBz+OU7GERDm6TUIJ7I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.1 158/239] irqchip/loongson-pch-pic: Fix pch_pic_acpi_init calling
Date:   Mon, 15 May 2023 18:27:01 +0200
Message-Id: <20230515161726.416922652@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Jianmin Lv <lvjianmin@loongson.cn>

commit 48ce2d722f7f108f27bedddf54bee3423a57ce57 upstream.

For dual-bridges scenario, pch_pic_acpi_init() will be called
in following path:

cpuintc_acpi_init
  acpi_cascade_irqdomain_init(in cpuintc driver)
    acpi_table_parse_madt
      eiointc_parse_madt
        eiointc_acpi_init /* this will be called two times
                             correspondingto parsing two
                             eiointc entries in MADT under
                             dual-bridges scenario*/
          acpi_cascade_irqdomain_init(in eiointc driver)
            acpi_table_parse_madt
              pch_pic_parse_madt
                pch_pic_acpi_init /* this will be called depend
                                     on valid parent IRQ domain
                                     handle for one or two times
                                     corresponding to parsing
                                     two pchpic entries in MADT
                                     druring calling
                                     eiointc_acpi_init() under
                                     dual-bridges scenario*/

During the first eiointc_acpi_init() calling, the
pch_pic_acpi_init() will be called just one time since only
one valid parent IRQ domain handle will be found for current
eiointc IRQ domain.

During the second eiointc_acpi_init() calling, the
pch_pic_acpi_init() will be called two times since two valid
parent IRQ domain handles will be found. So in pch_pic_acpi_init(),
we must have a reasonable way to prevent from creating second same
pch_pic IRQ domain.

The patch matches gsi base information in created pch_pic IRQ
domains to check if the target domain has been created to avoid the
bug mentioned above.

Cc: stable@vger.kernel.org
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230407083453.6305-6-lvjianmin@loongson.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-loongson-pch-pic.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -350,6 +350,9 @@ int __init pch_pic_acpi_init(struct irq_
 	int ret, vec_base;
 	struct fwnode_handle *domain_handle;
 
+	if (find_pch_pic(acpi_pchpic->gsi_base) >= 0)
+		return 0;
+
 	vec_base = acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
 
 	domain_handle = irq_domain_alloc_fwnode(&acpi_pchpic->address);


