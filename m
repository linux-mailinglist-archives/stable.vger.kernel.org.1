Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6C779BB29
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjIKWeD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbjIKOcU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:32:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FACF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:32:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045ABC433C7;
        Mon, 11 Sep 2023 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442735;
        bh=KjxfeO6B3ZNjSBfxCqx5CxPRkMjcjF5qEkdZ0Au+p5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0HRJ5b6ATp99iQFJg8EnBUM/INO8GweTvViBl968lLW+NRbktAr6D/NhDLqHelIz
         o2iVTpr8PD/6QmDPFr+ydrnDU5/63e4hgX5o7NciO9LJfCmTby1UeCSb3H6wA+iOxW
         neGZ/n4h+RFobVeQBpQ2FaMbGwh4KVIFaO5n/KYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bibo Mao <maobibo@loongson.cn>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 130/737] irqchip/loongson-eiointc: Fix return value checking of eiointc_index
Date:   Mon, 11 Sep 2023 15:39:49 +0200
Message-ID: <20230911134654.134660204@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bibo Mao <maobibo@loongson.cn>

[ Upstream commit 2e99b73afde18853754c5fae8e8d1a66fe5e3f64 ]

Return value of function eiointc_index is int, however it is converted
into uint32_t and then compared smaller than zero, this will cause logic
problem.

Fixes: dd281e1a1a93 ("irqchip: Add Loongson Extended I/O interrupt controller support")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230811095805.2974722-2-maobibo@loongson.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-loongson-eiointc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index a7fcde3e3ecc7..ae28918df5c59 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -143,7 +143,7 @@ static int eiointc_router_init(unsigned int cpu)
 	int i, bit;
 	uint32_t data;
 	uint32_t node = cpu_to_eio_node(cpu);
-	uint32_t index = eiointc_index(node);
+	int index = eiointc_index(node);
 
 	if (index < 0) {
 		pr_err("Error: invalid nodemap!\n");
-- 
2.40.1



