Return-Path: <stable+bounces-56518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E939244BB
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE66B25ACB
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3E31BE22F;
	Tue,  2 Jul 2024 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BVsgAG9c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD78915B0FE;
	Tue,  2 Jul 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940451; cv=none; b=u4hvHNvYgaJBxVquQEJ04uaPqgzdepmV4oNgVggGmsIymXBUnGWkuwxI6/xr8wj3S+GPGgE2DGPt3YWrplVb7eoa8msuJE1z+ko2HPG8/QY7QRlQ0n99S62/Htz2pOFfyCLMFfM/F876ROw5WxNtwRSgj7LcE+tPtgIAOJnowfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940451; c=relaxed/simple;
	bh=ZqUR3oK1MKCqZBcCkU+X1CJ4pEkb95Lf0hQzNmMDwpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHuEb8SKhN/B31/sqwZ5hAqJyfEhf+JPPtmFsiTcC+bQlHx6GdBByBQ0/5yMCbWn+STN7OuSPwZg15pSTZrhaPv7ET8UBxYoU8v/XhbYDs2czeYbrY8ynj2kHFZtjp+K0v1q+ZvSOU4lvXLeT1vBVrC+/N/UbQE+JrJ9ooMc6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BVsgAG9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3086DC116B1;
	Tue,  2 Jul 2024 17:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940451;
	bh=ZqUR3oK1MKCqZBcCkU+X1CJ4pEkb95Lf0hQzNmMDwpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BVsgAG9c71Ee1rFJJvpyeS4/2TtunVt0i5uTVJ38LCqnh+HVKQ+t28luWYiyEtdAW
	 QFnGUnItgzL8EEOB0ALzqHBUWM6ivicajUWG4pqdb1IyX2lSRRzsIQjYlDQVY6k1HT
	 vfg+w3mYmrjJCNrjYnUxNum3OLq2WgZxKmoD3g3g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Doug Brown <doug@schmorgal.com>
Subject: [PATCH 6.9 159/222] serial: core: introduce uart_port_tx_limited_flags()
Date: Tue,  2 Jul 2024 19:03:17 +0200
Message-ID: <20240702170250.055989351@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
References: <20240702170243.963426416@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jonas.gorski@gmail.com>

commit 9bb43b9e8d9a288a214e9b17acc9e46fda3977cf upstream.

Analogue to uart_port_tx_flags() introduced in commit 3ee07964d407
("serial: core: introduce uart_port_tx_flags()"), add a _flags variant
for uart_port_tx_limited().

Fixes: d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()")
Cc: stable@vger.kernel.org
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Doug Brown <doug@schmorgal.com>
Link: https://lore.kernel.org/r/20240606195632.173255-3-doug@schmorgal.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/serial_core.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -829,6 +829,24 @@ enum UART_TX_FLAGS {
 })
 
 /**
+ * uart_port_tx_limited_flags -- transmit helper for uart_port with count limiting with flags
+ * @port: uart port
+ * @ch: variable to store a character to be written to the HW
+ * @flags: %UART_TX_NOSTOP or similar
+ * @count: a limit of characters to send
+ * @tx_ready: can HW accept more data function
+ * @put_char: function to write a character
+ * @tx_done: function to call after the loop is done
+ *
+ * See uart_port_tx_limited() for more details.
+ */
+#define uart_port_tx_limited_flags(port, ch, flags, count, tx_ready, put_char, tx_done) ({ \
+	unsigned int __count = (count);							   \
+	__uart_port_tx(port, ch, flags, tx_ready, put_char, tx_done, __count,		   \
+			__count--);							   \
+})
+
+/**
  * uart_port_tx -- transmit helper for uart_port
  * @port: uart port
  * @ch: variable to store a character to be written to the HW



