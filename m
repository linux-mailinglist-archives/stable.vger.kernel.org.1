Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CE679BE6E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359181AbjIKWPm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239266AbjIKOQJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:16:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D272DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:16:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A640C433C9;
        Mon, 11 Sep 2023 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441764;
        bh=IHFTg1XBnqsi3zQ2y8wIfi6rn86Jv4yf1IkgNs/pf14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9hkLBfr2ft0HK40fJ+i0d+T2WyYjH3iydrfMDN9fguu5jcROh2PLoFpx0B9pkmyt
         0IH87aCr7mV5RHRVbh13It+JNDCACjrjwVWYYS8q/GbMiUC5F6S7zwvFDMEpRoBByv
         ekHSmLF+QKM64eaoAnNXYiDvsG3xV2ygskWSNLgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 521/739] tty: serial: qcom-geni-serial: Poll primary sequencer irq status after cancel_tx
Date:   Mon, 11 Sep 2023 15:45:20 +0200
Message-ID: <20230911134705.665614439@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

From: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>

[ Upstream commit 9c8441330bb399cba6177acce9b0e68c0dbaa597 ]

TX is handled by primary sequencer. After cancelling primary command, poll
primary sequencer's irq status instead of that of secondary.
While at it, also remove a couple of redundant lines that read from IRQ_EN
register and write back same.

Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Link: https://lore.kernel.org/r/1691578393-9891-1-git-send-email-quic_vnivarth@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 54b22cbc0fcef..67484c062edd1 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -592,7 +592,6 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	bool done;
-	u32 m_irq_en;
 
 	if (!qcom_geni_serial_main_active(uport))
 		return;
@@ -604,12 +603,10 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
 		port->tx_remaining = 0;
 	}
 
-	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
-	writel(m_irq_en, uport->membase + SE_GENI_M_IRQ_EN);
 	geni_se_cancel_m_cmd(&port->se);
 
-	done = qcom_geni_serial_poll_bit(uport, SE_GENI_S_IRQ_STATUS,
-					 S_CMD_CANCEL_EN, true);
+	done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
+					 M_CMD_CANCEL_EN, true);
 	if (!done) {
 		geni_se_abort_m_cmd(&port->se);
 		done = qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
-- 
2.40.1



