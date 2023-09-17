Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1D47A374A
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjIQTRT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjIQTRA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:17:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892F8FA
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:16:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ADBC433C7;
        Sun, 17 Sep 2023 19:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978215;
        bh=3N6CPRqJLNDG5YfgfAdhq/nuURKiCO1kxHMh5SjEoU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wzZY1cpbwJsqCZypqx2RF+m3+XA5KLyhxLFhyS31CXSln25btCb+Vm96vzUb5itVJ
         p89QTUtpsxU3qvTDMgutMnHe1TPEJU+bhu/jo1QY4WaFwShIOolQ4rdBYNgM9q6fCT
         mEk6PmFaVU5yfB02zvi8KaE4JAJYNFjGEP/TRxGQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rajendra Nayak <quic_rjendra@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 5.10 015/406] serial: qcom-geni: fix opp vote on shutdown
Date:   Sun, 17 Sep 2023 21:07:49 +0200
Message-ID: <20230917191101.541205896@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -125,6 +125,7 @@ struct qcom_geni_serial_port {
 	u32 tx_fifo_width;
 	u32 rx_fifo_depth;
 	bool setup;
+	unsigned long clk_rate;
 	int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
 	unsigned int baud;
 	void *rx_fifo;
@@ -1022,6 +1023,7 @@ static void qcom_geni_serial_set_termios
 		goto out_restart_rx;
 
 	uport->uartclk = clk_rate;
+	port->clk_rate = clk_rate;
 	dev_pm_opp_set_rate(uport->dev, clk_rate);
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
@@ -1305,10 +1307,13 @@ static void qcom_geni_serial_pm(struct u
 
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


