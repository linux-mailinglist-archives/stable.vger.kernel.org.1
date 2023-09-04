Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD84C791CE5
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243928AbjIDScq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244677AbjIDScq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:32:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9EDCCB
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA52F61987
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5EBC433CA;
        Mon,  4 Sep 2023 18:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852362;
        bh=rrIBxXaxNvo3qSXM5KBngAgYmvv/cTmgL5MQVWxFqmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+G9983oG1+6/rpQiaBoPvECD6F7KiWW3ivjgTR3ml3Z/aEVUIh9pTNK4tsDGeIKB
         XKIesMzcH8XbeqZATV+o+VXdAMBLBnq53pfW3TCAOPy5+kZD9yfAcuN6dZoUzig4P0
         zZdaXwBN9sbNmY5qyT9QtAVM/dizaEoVZ6ubApYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rajendra Nayak <quic_rjendra@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 6.5 24/34] serial: qcom-geni: fix opp vote on shutdown
Date:   Mon,  4 Sep 2023 19:30:11 +0100
Message-ID: <20230904182949.720548919@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
References: <20230904182948.594404081@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit 8ece7b754bc34ffd7fcc8269ccb9128e72ca76d8 upstream.

The operating-performance-point vote needs to be dropped when shutting
down the port to avoid wasting power by keeping resources like power
domains in an unnecessarily high performance state (e.g. when a UART
connected Bluetooth controller is not in use).

Fixes: a5819b548af0 ("tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state")
Cc: stable@vger.kernel.org      # 5.9
Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230714130214.14552-2-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/qcom_geni_serial.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -126,6 +126,7 @@ struct qcom_geni_serial_port {
 	dma_addr_t rx_dma_addr;
 	bool setup;
 	unsigned int baud;
+	unsigned long clk_rate;
 	void *rx_buf;
 	u32 loopback;
 	bool brk;
@@ -1249,6 +1250,7 @@ static void qcom_geni_serial_set_termios
 			baud * sampling_rate, clk_rate, clk_div);
 
 	uport->uartclk = clk_rate;
+	port->clk_rate = clk_rate;
 	dev_pm_opp_set_rate(uport->dev, clk_rate);
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
@@ -1513,10 +1515,13 @@ static void qcom_geni_serial_pm(struct u
 
 	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
 		geni_icc_enable(&port->se);
+		if (port->clk_rate)
+			dev_pm_opp_set_rate(uport->dev, port->clk_rate);
 		geni_se_resources_on(&port->se);
 	} else if (new_state == UART_PM_STATE_OFF &&
 			old_state == UART_PM_STATE_ON) {
 		geni_se_resources_off(&port->se);
+		dev_pm_opp_set_rate(uport->dev, 0);
 		geni_icc_disable(&port->se);
 	}
 }


