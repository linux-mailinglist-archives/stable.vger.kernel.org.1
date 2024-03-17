Return-Path: <stable+bounces-28320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8F787E071
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 22:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23724B218EE
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 21:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9360F208B8;
	Sun, 17 Mar 2024 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoFVENiJ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3C208B0
	for <stable@vger.kernel.org>; Sun, 17 Mar 2024 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710711718; cv=none; b=YCEJ4SrzyrMSmfCsaxPQFN55l9ZN3HfnnFKuH4Va+zRWplCB92CKgc4zibhVHYB7dNUmjzxDNZnJpezRrsOP6+H0gBXZR6RaUBA9L/Vl27+ibEeMlq/S6B0q7gGLWn2GqWdxhx8g9sbTvDPcK9VYoHDzy1DHF16a/Yn06maSvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710711718; c=relaxed/simple;
	bh=AQOuIZCrB9FidQg/kAZKaa1dIJbFfCNIrJ6x/+ojQx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEmQmyFQKzWez0+2pU5W1Az7kfO57RxjzGQl5C3+RMXYPJInk5LIjtBb3w7XN9r+K5EiGVXxnkGiyxYCFwZNa07Hwj6RVHdPJrtHyeq1brFB/cY13/zPMskyxYWJuJMkkQIThmgCljSwieIJAw6VUzGeVROf6yW+j6T2BKf9JXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UoFVENiJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710711715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2UD1uhUWB3+uEEu+3aOovx1iyyjT3/jslhdCSc8fWe4=;
	b=UoFVENiJav7tz8dbLLT/lFeX0uyQTjcNP+kI13/TAAX8gvGnKqiSZZtJFp8BKfCAJH2kmt
	TXYV37QeprXianqlpRgyWZPjCRia/EdDbYrUpOkBOd12ve7bahrYk5SxEPC3WfA0nUdmZv
	cr2tzBEQILFJWrm/cUJ6kE4+xC51Pe4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-6U4vIbqgOXWdvg-o3vllVg-1; Sun, 17 Mar 2024 17:41:50 -0400
X-MC-Unique: 6U4vIbqgOXWdvg-o3vllVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BFAD101A526;
	Sun, 17 Mar 2024 21:41:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.64])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DCE6740C6DAE;
	Sun, 17 Mar 2024 21:41:48 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org,
	Peter Collingbourne <pcc@google.com>
Subject: [PATCH] serial: 8250_dw: Revert: Do not reclock if already at correct rate
Date: Sun, 17 Mar 2024 22:41:23 +0100
Message-ID: <20240317214123.34482-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Commit e5d6bd25f93d ("serial: 8250_dw: Do not reclock if already at
correct rate") breaks the dw UARTs on Intel Bay Trail (BYT) and
Cherry Trail (CHT) SoCs.

Before this change the RTL8732BS Bluetooth HCI which is found
connected over the dw UART on both BYT and CHT boards works properly:

Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000b lmp_ver=06 lmp_subver=8723
Bluetooth: hci0: RTL: rom_version status=0 version=1
Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
Bluetooth: hci0: RTL: fw version 0x365d462e

where as after this change probing it fails:

Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000b lmp_ver=06 lmp_subver=8723
Bluetooth: hci0: RTL: rom_version status=0 version=1
Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
Bluetooth: hci0: command 0xfc20 tx timeout
Bluetooth: hci0: RTL: download fw command failed (-110)

Revert the changes to fix this regression.

Fixes: e5d6bd25f93d ("serial: 8250_dw: Do not reclock if already at correct rate")
Cc: stable@vger.kernel.org
Cc: Peter Collingbourne <pcc@google.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note it is not entirely clear to me why this commit is causing
this issue. Maybe probe() needs to explicitly set the clk rate
which it just got (that feels like a clk driver issue) or maybe
the issue is that unless setup before hand by firmware /
the bootloader serial8250_update_uartclk() needs to be called
at least once to setup things ?  Note that probe() does not call
serial8250_update_uartclk(), this is only called from the
dw8250_clk_notifier_cb()

This requires more debugging which is why I'm proposing
a straight revert to fix the regression ASAP and then this
can be investigated further.
---
 drivers/tty/serial/8250/8250_dw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index c1d43f040c43..2d1f350a4bea 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -357,9 +357,9 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	long rate;
 	int ret;
 
+	clk_disable_unprepare(d->clk);
 	rate = clk_round_rate(d->clk, newrate);
-	if (rate > 0 && p->uartclk != rate) {
-		clk_disable_unprepare(d->clk);
+	if (rate > 0) {
 		/*
 		 * Note that any clock-notifer worker will block in
 		 * serial8250_update_uartclk() until we are done.
@@ -367,8 +367,8 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 		ret = clk_set_rate(d->clk, newrate);
 		if (!ret)
 			p->uartclk = rate;
-		clk_prepare_enable(d->clk);
 	}
+	clk_prepare_enable(d->clk);
 
 	dw8250_do_set_termios(p, termios, old);
 }
-- 
2.44.0


