Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715D9704FA1
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 15:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjEPNnh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 09:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjEPNng (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 09:43:36 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A485BAA
        for <stable@vger.kernel.org>; Tue, 16 May 2023 06:43:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f24d4900bbso12706695e87.3
        for <stable@vger.kernel.org>; Tue, 16 May 2023 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684244612; x=1686836612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PW4p5Kg6Kn9DmWcmDDr7BRFxGnCD5yJt1CwE2IKAMU4=;
        b=F8ZPIVP0/I02zY7iARerKURDE5Dwu5YAaXiplDs32pO2nCCJsjRyEJG2geyCJ9U0VW
         i1z3QCn+o9tW0p5ojsmNxMNXSdvoW7hyeK/Q/XE5a1D92W98FYzeMEGg/LQDvgtkakVN
         ZEiLsSr/v6XzfNdk3FFrh9OYxjSgJJtKUkW0t+b3hqfY7EgCQtI2ERPqpIZQK2XMn66Y
         nIS8ThjrFCYx916AvYu5aaRO3VYSKIfLnahU6+GZp6FUqeyqQqjSfsyQeeW4xhvXnybu
         F+xdlT1NV0KOYq8tTCYGcKIr1kWoF55IG3KEsGlxqBBFwu7tVZRdqTY2Lkd24npVGa0v
         TEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684244612; x=1686836612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PW4p5Kg6Kn9DmWcmDDr7BRFxGnCD5yJt1CwE2IKAMU4=;
        b=PfiN9K9/vUbyuf8WTgw2PfcGgnhfLGhAvvO6hwfHI9WdR0a+qV38MAnbsbhcfdoDO3
         TAGSnmexN4fFlVTaLup/BWclqWWSS7OwRX8rWQEsoGWA3Z3wx61GpSSM+GGhbqFp3Sj0
         uiH4W1zJf/PNg1GQiYfFk7CvkrEx6IDotHINS8iN2N/bGThYLODBD4amXSqRGtlhej3a
         kBRQav8p0K8MrwIxfCMF40rlUyo+tKw00Ak++u8558ltWxWrK+VMWeUru079D+DenTi0
         N3gujsQQyB5Cd2GZPovWx9PQM5AgX1XeJ8s5Yi3CBIg7ZJDIcU5j2E6VaHemjeJ3jPX6
         j9yw==
X-Gm-Message-State: AC+VfDxjJzwhlYyq/RCHuklZRAEkiOg/WXoa4AJlxc5YxD+qEIKfISPg
        1u6SvGEXprI5s6C1QDQcNBqP1w==
X-Google-Smtp-Source: ACHHUZ72BcK92RZqbvcKzJkeCvHjMt30Fvjze9CD0zzjN/fWkAccjDjqk714HeSOo+tWYW+QLZYfrA==
X-Received: by 2002:a05:6512:11ee:b0:4ea:e60a:2f5d with SMTP id p14-20020a05651211ee00b004eae60a2f5dmr6634164lfs.40.1684244612604;
        Tue, 16 May 2023 06:43:32 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id l26-20020ac24a9a000000b004f13b59307asm2962558lfp.232.2023.05.16.06.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 06:43:32 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 3/6] can: kvaser_pciefd: Call request_irq() before enabling interrupts
Date:   Tue, 16 May 2023 15:43:15 +0200
Message-Id: <20230516134318.104279-4-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230516134318.104279-1-extja@kvaser.com>
References: <20230516134318.104279-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Make sure the interrupt handler is registered before enabling interrupts.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index cdc894d12885..4b8591d48735 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1827,6 +1827,11 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_teardown_can_ctrls;
 
+	err = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
+			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
+	if (err)
+		goto err_teardown_can_ctrls;
+
 	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_IRQ_REG);
 
@@ -1847,11 +1852,6 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
 
-	err = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
-			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
-	if (err)
-		goto err_teardown_can_ctrls;
-
 	err = kvaser_pciefd_reg_candev(pcie);
 	if (err)
 		goto err_free_irq;
-- 
2.40.0

