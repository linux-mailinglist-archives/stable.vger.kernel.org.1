Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83226FF17D
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 14:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbjEKM2Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 08:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbjEKM2X (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 08:28:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F667198C
        for <stable@vger.kernel.org>; Thu, 11 May 2023 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683808103; x=1715344103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zfewlhwzgj/TgmvZ/Ivx2TWoDVyRGnBFFfb5f4Sx4mQ=;
  b=eLDF0UvxZjiBWWJ4EHbB9idSnKBZxQOoRozAqHeHw6mPC0wrqC/MMs3F
   6rSbbts9yFgpEz7Pergjem15f6pWDJeZDVWDOcgMGuY5ncVtR5umdOiKn
   63YTV1ElAuwdwZWpQNHhch7/I+Rr9ImafzZwOoj0iN6zGbH8kS3RspGSD
   +lg2D4/n66mFdDVPuR+BCxy7jd0Geo+3i7om+yLSVe9/SZIxTxD2PgJYT
   kkWhq13i0FmYFP2kp82RwzB3g/t9rKvm2mfZs4GG8NKYERziFwHrp0tRX
   KeSqiyZD3iCmjm7i4rg4hOKXDjhoOLJBvAcv+1LDJjBU0sXukeslAtTYh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="347955428"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="347955428"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="811573953"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="811573953"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:28:21 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15.y] serial: 8250: Fix serial8250_tx_empty() race with DMA Tx
Date:   Thu, 11 May 2023 15:27:58 +0300
Message-Id: <20230511122758.19505-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2023050627-kept-container-b02a@gregkh>
References: <2023050627-kept-container-b02a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

There's a potential race before THRE/TEMT deasserts when DMA Tx is
starting up (or the next batch of continuous Tx is being submitted).
This can lead to misdetecting Tx empty condition.

It is entirely normal for THRE/TEMT to be set for some time after the
DMA Tx had been setup in serial8250_tx_dma(). As Tx side is definitely
not empty at that point, it seems incorrect for serial8250_tx_empty()
claim Tx is empty.

Fix the race by also checking in serial8250_tx_empty() whether there's
DMA Tx active.

Note: This fix only addresses in-kernel race mainly to make using
TCSADRAIN/FLUSH robust. Userspace can still cause other races but they
seem userspace concurrency control problems.

Fixes: 9ee4b83e51f74 ("serial: 8250: Add support for dmaengine")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20230317113318.31327-3-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 146a37e05d620cef4ad430e5d1c9c077fe6fa76f)
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h      | 12 ++++++++++++
 drivers/tty/serial/8250/8250_port.c | 12 +++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index b3abc29aa927..bb1a98c97adf 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -349,6 +349,13 @@ static inline void serial8250_do_prepare_rx_dma(struct uart_8250_port *p)
 	if (dma->prepare_rx_dma)
 		dma->prepare_rx_dma(p);
 }
+
+static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	return dma && dma->tx_running;
+}
 #else
 static inline int serial8250_tx_dma(struct uart_8250_port *p)
 {
@@ -364,6 +371,11 @@ static inline int serial8250_request_dma(struct uart_8250_port *p)
 	return -1;
 }
 static inline void serial8250_release_dma(struct uart_8250_port *p) { }
+
+static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
+{
+	return false;
+}
 #endif
 
 static inline int ns16550a_goto_highspeed(struct uart_8250_port *up)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 691e7a07565c..a01085791e13 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1984,19 +1984,25 @@ static int serial8250_tx_threshold_handle_irq(struct uart_port *port)
 static unsigned int serial8250_tx_empty(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int result = 0;
 	unsigned long flags;
 	unsigned int lsr;
 
 	serial8250_rpm_get(up);
 
 	spin_lock_irqsave(&port->lock, flags);
-	lsr = serial_port_in(port, UART_LSR);
-	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+	if (!serial8250_tx_dma_running(up)) {
+		lsr = serial_port_in(port, UART_LSR);
+		up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+
+		if ((lsr & BOTH_EMPTY) == BOTH_EMPTY)
+			result = TIOCSER_TEMT;
+	}
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	serial8250_rpm_put(up);
 
-	return (lsr & BOTH_EMPTY) == BOTH_EMPTY ? TIOCSER_TEMT : 0;
+	return result;
 }
 
 unsigned int serial8250_do_get_mctrl(struct uart_port *port)
-- 
2.30.2

