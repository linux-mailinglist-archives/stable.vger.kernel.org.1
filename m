Return-Path: <stable+bounces-103093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ACC9EF5E3
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FCAD17AD8C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEAF2236EF;
	Thu, 12 Dec 2024 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RoHeNOyp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F10222D7B;
	Thu, 12 Dec 2024 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023523; cv=none; b=AKaxfe1WPyFLR5eUe1iN0skH2y0qvD8+/708sB+8l9DW/vdQcO/4m8So0LP7U/I7FGLYxh7PQ1GDg/iNB5Ho+aHymibW8LxO9f/Txl2xgE3xmSeGMWcK7JlzO+/Gb9azTMyBXBsX4vms2A/vKtymStuHS2ALcncy6rB9S2CWiaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023523; c=relaxed/simple;
	bh=1OmMS6AhLl/eLVZWDFdOZRYpZQ7mSom20ecxWqbI9h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MW2waOmTYEOhTkVZ2WYEenRMBKv+q4ONXJC0OZLZy6RCyJxBi4mQa3hJIfy9OoQu/diWQc3m0fK9jAV66TXE59/SJnMLKQL3tRLAETAbIqJlDiq7iXpHiWjDLodxPZUYiIhGop7zwkg9WYSGfrvgajtF0Qw2FiV7BxO9wtCtHbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RoHeNOyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B18EC4CED0;
	Thu, 12 Dec 2024 17:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023523;
	bh=1OmMS6AhLl/eLVZWDFdOZRYpZQ7mSom20ecxWqbI9h8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RoHeNOyp40cF9UXgtBD8Z68TkTYtPtkPDQr95fHQVd230hk50puLYf5OoYOvwxrSP
	 sfxpTAn6SO4ze3aCOLOytClkoFYxYQ5E2JTZ4N9tYo80atcueQj5vpe2zB9WsWmuPM
	 85IYRLUvYY9XMmkERt/qdGk8x1HwtIkf/mgnDzOw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.15 562/565] serial: amba-pl011: fix build regression
Date: Thu, 12 Dec 2024 16:02:37 +0100
Message-ID: <20241212144334.090328234@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit b5a23a60e8ab5711f4952912424347bf3864ce8d upstream.

When CONFIG_DMA_ENGINE is disabled, the driver now fails to build:

drivers/tty/serial/amba-pl011.c: In function 'pl011_unthrottle_rx':
drivers/tty/serial/amba-pl011.c:1822:16: error: 'struct uart_amba_port' has no member named 'using_rx_dma'
 1822 |         if (uap->using_rx_dma) {
      |                ^~
drivers/tty/serial/amba-pl011.c:1823:20: error: 'struct uart_amba_port' has no member named 'dmacr'
 1823 |                 uap->dmacr |= UART011_RXDMAE;
      |                    ^~
drivers/tty/serial/amba-pl011.c:1824:32: error: 'struct uart_amba_port' has no member named 'dmacr'
 1824 |                 pl011_write(uap->dmacr, uap, REG_DMACR);
      |                                ^~

Add the missing #ifdef check around these field accesses, matching
what other parts of this driver do.

Fixes: 2bcacc1c87ac ("serial: amba-pl011: Fix RX stall when DMA is used")
Cc: stable <stable@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411140617.nkjeHhsK-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20241115110021.744332-1-arnd@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/amba-pl011.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1842,10 +1842,12 @@ static void pl011_unthrottle_rx(struct u
 
 	pl011_write(uap->im, uap, REG_IMSC);
 
+#ifdef CONFIG_DMA_ENGINE
 	if (uap->using_rx_dma) {
 		uap->dmacr |= UART011_RXDMAE;
 		pl011_write(uap->dmacr, uap, REG_DMACR);
 	}
+#endif
 
 	uart_port_unlock_irqrestore(&uap->port, flags);
 }



