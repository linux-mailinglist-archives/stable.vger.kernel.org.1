Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269CE70356B
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbjEOQ64 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243355AbjEOQ6s (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D267B7A95
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:58:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DA8562A45
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37BCC433EF;
        Mon, 15 May 2023 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169924;
        bh=4m9WUvZG61KQPOHZvdylmdVpjIVfjslntFbLEp/+F18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ap+9Xb1SjlIyoHOU5rpADeJjevVNmG0xTlh3Imo39AROG0G2r/OFRer+V3ga67/sg
         89Zjaa47RZvffT5kG0uFl6LbMR076NoHifCpVTBrD2Lqa+RGcFu/ty0fjPRZ5Avbye
         5KwuojrnKyd9a0ZYEMgbOreQyIcmlEpgO1tGLfqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.3 185/246] irqchip/loongson-pch-pic: Fix registration of syscore_ops
Date:   Mon, 15 May 2023 18:26:37 +0200
Message-Id: <20230515161728.173914179@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

commit c84efbba46901b187994558ee0edb15f7076c9a7 upstream.

When support suspend/resume for loongson-pch-pic, the syscore_ops
is registered twice in dual-bridges machines where there are two
pch-pic IRQ domains. Repeated registration of an same syscore_ops
broke syscore_ops_list, so the patch will corret it.

Fixes: 1ed008a2c331 ("irqchip/loongson-pch-pic: Add suspend/resume support")
Cc: stable@vger.kernel.org
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230407083453.6305-5-lvjianmin@loongson.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-loongson-pch-pic.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -311,7 +311,8 @@ static int pch_pic_init(phys_addr_t addr
 	pch_pic_handle[nr_pics] = domain_handle;
 	pch_pic_priv[nr_pics++] = priv;
 
-	register_syscore_ops(&pch_pic_syscore_ops);
+	if (nr_pics == 1)
+		register_syscore_ops(&pch_pic_syscore_ops);
 
 	return 0;
 


