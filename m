Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE0D704FA2
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 15:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjEPNnj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 09:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjEPNnh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 09:43:37 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4892B5BB4
        for <stable@vger.kernel.org>; Tue, 16 May 2023 06:43:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so16492342e87.2
        for <stable@vger.kernel.org>; Tue, 16 May 2023 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684244613; x=1686836613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADyJ8JqyUA7wla+As4DFlyeuBG7lGglvSJmxCSf1cFg=;
        b=Mt5wLa7emt5hs3wzV2oTKd4RKAAQwfA/nvqkrIQgFB+pJb13+dm4JkBKi38QbBF9Nc
         /onZ3DFhcBnbIPKopZW3181wmKDb++8T5eMdQZw1TIXTuLWapz8iIMSaNvH/tMg/9GUi
         YpG/3Zt/XcrBejcxDeGfXeRUrZeAmtwgNkZxbCb8LHTV+ue0R9f/TIv7Y0KS7hI+RHS+
         Ewmpjz+uuZAfTB7mq3ZUeCIuBBEQT9Aa09+c/JtZCBr/RiyVjpR2Xe3VdbvelXEdLtgh
         IEzIw90AolWSfd27+sj+7QTR0tX81t14u2hSTQblWEQ5gGJcsZwR5wvm0pPvTPGVeU7L
         kctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684244613; x=1686836613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADyJ8JqyUA7wla+As4DFlyeuBG7lGglvSJmxCSf1cFg=;
        b=gs3pe6DjBlTKRfwhnr6lu2XIaNltoUv8iOxhmo7YX45rtlWtQKAI5m3H7/8c1hXMpP
         2nTE78l27qG+o2T9lgNW/7+Hi6wkCw1d5alzTTJcfoA/ZvZDriFccpN7y8YTnwG0vpYb
         GZi+lVUod0Ne5KYRfSn8/Ey6gHY5hFqCSTM7eRd64QfbOzPv+Hq/+6e2dbpi61pen0ox
         04NeAg5YNTW8ztzyyytEXB6GKYwJo/4zyJpJHCfWPD5R2x29TwRGIFozjHmFV26JtOmO
         cRdXHpjFbAsIH+zMSf9dyNmO7nHBrWIWzG8SZRQvMxftd743CC++d6FpX4RhOEJtrceo
         Sf8w==
X-Gm-Message-State: AC+VfDz0sAs2Fd2fY74LH7LrXDJlOgFalPAnXYSX+O92slIzCiLnS4x8
        apPBrI+HwQ3+QFB/yXT8ZAIu+w==
X-Google-Smtp-Source: ACHHUZ5ELP+WMB7g7CW42U3mXUrey6R9DW6mEUBzJvxIa2owUNpSvY34vFgNzyVn4pK68MXlM5OcZw==
X-Received: by 2002:a19:761a:0:b0:4f2:7dda:ad06 with SMTP id c26-20020a19761a000000b004f27ddaad06mr3758077lff.10.1684244613412;
        Tue, 16 May 2023 06:43:33 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id l26-20020ac24a9a000000b004f13b59307asm2962558lfp.232.2023.05.16.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 06:43:33 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 4/6] can: kvaser_pciefd: Empty SRB buffer in probe
Date:   Tue, 16 May 2023 15:43:16 +0200
Message-Id: <20230516134318.104279-5-extja@kvaser.com>
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

Empty the "Shared receive buffer" (SRB) in probe, to assure we start in a
known state, and don't process any irrelevant packets.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 4b8591d48735..0e03c1cd47b3 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -71,10 +71,12 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_SYSID_BUILD_REG (KVASER_PCIEFD_SYSID_BASE + 0x14)
 /* Shared receive buffer registers */
 #define KVASER_PCIEFD_SRB_BASE 0x1f200
+#define KVASER_PCIEFD_SRB_FIFO_LAST_REG (KVASER_PCIEFD_SRB_BASE + 0x1f4)
 #define KVASER_PCIEFD_SRB_CMD_REG (KVASER_PCIEFD_SRB_BASE + 0x200)
 #define KVASER_PCIEFD_SRB_IEN_REG (KVASER_PCIEFD_SRB_BASE + 0x204)
 #define KVASER_PCIEFD_SRB_IRQ_REG (KVASER_PCIEFD_SRB_BASE + 0x20c)
 #define KVASER_PCIEFD_SRB_STAT_REG (KVASER_PCIEFD_SRB_BASE + 0x210)
+#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG (KVASER_PCIEFD_SRB_BASE + 0x214)
 #define KVASER_PCIEFD_SRB_CTRL_REG (KVASER_PCIEFD_SRB_BASE + 0x218)
 /* EPCS flash controller registers */
 #define KVASER_PCIEFD_SPI_BASE 0x1fc00
@@ -111,6 +113,9 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 /* DMA support */
 #define KVASER_PCIEFD_SRB_STAT_DMA BIT(24)
 
+/* SRB current packet level */
+#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK 0xff
+
 /* DMA Enable */
 #define KVASER_PCIEFD_SRB_CTRL_DMA_ENABLE BIT(0)
 
@@ -1061,6 +1066,7 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 {
 	int i;
 	u32 srb_status;
+	u32 srb_packet_count;
 	dma_addr_t dma_addr[KVASER_PCIEFD_DMA_COUNT];
 
 	/* Disable the DMA */
@@ -1088,6 +1094,15 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 		  KVASER_PCIEFD_SRB_CMD_RDB1,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
 
+	/* Empty Rx FIFO */
+	srb_packet_count = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG) &
+			   KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK;
+	while (srb_packet_count) {
+		/* Drop current packet in FIFO */
+		ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_FIFO_LAST_REG);
+		srb_packet_count--;
+	}
+
 	srb_status = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_STAT_REG);
 	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DI)) {
 		dev_err(&pcie->pci->dev, "DMA not idle before enabling\n");
-- 
2.40.0

