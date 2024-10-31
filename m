Return-Path: <stable+bounces-89434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A4F9B811F
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 18:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C057E2831B0
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 17:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BB71C2456;
	Thu, 31 Oct 2024 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J4ReKVPc"
X-Original-To: stable@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728519DF60;
	Thu, 31 Oct 2024 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395408; cv=none; b=TnAnhgTeDu1kxbj8r6r8p7yuHGcZqrHm3HddBbNlQa1K2wIRo/e/xuVM7OtGDH9EAK47nY99Gmr6m1NmkuGHk8HAyUKCTSRv7RhyITabUDpjWCNV9rAzViFFj/hpFRvPY9uwy0gTwOUYt6XMhKQ9Inqo7YJnpvdIbducJ8gpoOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395408; c=relaxed/simple;
	bh=aCDK/sXM3SgFDux9XvTqAvGfN/okqVMFQNUlKyGIalM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LjQgo2lmXWmUSkjO3HHWtN9kDDRekSS4n0BEJ5VidFwRujO0gUbmN6sXnIamnezP+KDcHSrgVyCIefKajtn7bWXD73zWYbJfVldKYlBt5BzD+SEIQ1cbE1tXDtw49OJDrjqAO60Xts+X0RJUtJOTdo4Ej8Qhnv1eP2n9gIUi9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J4ReKVPc; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49VHNFuM108643;
	Thu, 31 Oct 2024 12:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730395395;
	bh=pyc5mtkPJw5E2FWifYXQA9O+3uyDDN9DH0eaPCzh9Yo=;
	h=From:To:CC:Subject:Date;
	b=J4ReKVPcSi8juriugwCFk22wPKkmJcKj9iLZ7oGnTFySh0KePlR0jYY9QibQBWIfS
	 B7eKoIgFcYr003hVkn2ZNzQcnilKRVYdnZ8JLXCFAWb/C7yPYmaB1dsU/zzq6ADCrH
	 zjg2gtAn6WkboZuf62ysmd7F/+qMdBfV6r3C99kw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49VHNF1J057526;
	Thu, 31 Oct 2024 12:23:15 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 31
 Oct 2024 12:23:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 31 Oct 2024 12:23:15 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49VHNF3o014863;
	Thu, 31 Oct 2024 12:23:15 -0500
From: Judith Mendez <jm@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Andreas Kemnade
	<andreas@kemnade.info>, Andrew Davis <afd@ti.com>,
        Bin Liu <b-liu@ti.com>, Judith Mendez <jm@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] serial: 8250: omap: Move pm_runtime_get_sync
Date: Thu, 31 Oct 2024 12:23:15 -0500
Message-ID: <20241031172315.453750-1-jm@ti.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Bin Liu <b-liu@ti.com>

Currently in omap_8250_shutdown, the dma->rx_running flag is
set to zero in omap_8250_rx_dma_flush. Next pm_runtime_get_sync
is called, which is a runtime resume call stack which can
re-set the flag. When the call omap_8250_shutdown returns, the
flag is expected to be UN-SET, but this is not the case. This
is causing issues the next time UART is re-opened and
omap_8250_rx_dma is called. Fix by moving pm_runtime_get_sync
before the omap_8250_rx_dma_flush.

cc: stable@vger.kernel.org
Fixes: 0e31c8d173ab ("tty: serial: 8250_omap: add custom DMA-RX callback")
Signed-off-by: Bin Liu <b-liu@ti.com>
[Judith: Add commit message]
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
Issue seen on am335x devices so far [0].
The patch has been tested with sanity boot test on am335x EVM,
am335x-boneblack and am57xx-beagle-x15.

Changes since v1 RESEND:
- Fix email header and commit description length
- Add fixes tag, add link [0], cc stable, add kevin's reviewed-by/tested-by's
- Separate patch from patch series [1]

[0] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1365142/am3352-resume-from-standby-problem-with-kernel-6-1-46

Link to v1 RESEND:
[1] https://lore.kernel.org/linux-omap/20241011173356.870883-1-jm@ti.com/
---
 drivers/tty/serial/8250/8250_omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 88b58f44e4e97..0dd68bdbfbcf7 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -776,12 +776,12 @@ static void omap_8250_shutdown(struct uart_port *port)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct omap8250_priv *priv = port->private_data;
 
+	pm_runtime_get_sync(port->dev);
+
 	flush_work(&priv->qos_work);
 	if (up->dma)
 		omap_8250_rx_dma_flush(up);
 
-	pm_runtime_get_sync(port->dev);
-
 	serial_out(up, UART_OMAP_WER, 0);
 	if (priv->habit & UART_HAS_EFR2)
 		serial_out(up, UART_OMAP_EFR2, 0x0);
-- 
2.47.0


