Return-Path: <stable+bounces-57375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA6E925C35
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6936E1F21102
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A6D17C221;
	Wed,  3 Jul 2024 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xf2fI4Am"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3713B280;
	Wed,  3 Jul 2024 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004688; cv=none; b=SuZd3AhWskSA29Hdvr9Cqo+Cz7Qw3eLvhj5r8zapwqYQcHFHhvzMgR/iul5pDAXmecYkeDX39LrXl6qhddr3VB9KtZF03MIVLk4/ol7MumoWe8jaxFyEjk2zcnvHRzTS+/ufWC0s3fo/qbY4WTud3TVWRI6s3xTMfHytSpbg4lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004688; c=relaxed/simple;
	bh=1JlTW75juxLUMM/E89eVE3I0ZqUyAFlflA3sTA45y3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnqbb1mEe6jmP3h83QioII5M4jPAC3bQKw9sUn1XILICGr/EejoBc8Zcg3sve6ZAJdMcpwDvPpu+SrXKA6zjbVR6sd92aWI70lz473QFrnYgnKDHTZrhYxE4ZTZhbwcHbUwJO0HMfqbYkHYYcRAJwv8ILpRVY93rBmzyysFr998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xf2fI4Am; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9E1C32781;
	Wed,  3 Jul 2024 11:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004687;
	bh=1JlTW75juxLUMM/E89eVE3I0ZqUyAFlflA3sTA45y3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xf2fI4AmpvTSozk2wvpc1IJusOe6Whyz16TVA1PF8w6mrixUVUl0RsjFFmm1KvOZA
	 9EtjunTbFPYyXJRC4giyTb4DlVzir2iBJiOleEzE3BU0PPYGlwqf/fuFkkbScM6cOj
	 TpVuJj33AQG9j82PVvla//VFLKdTKfGHmdCqWbJA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Doug Brown <doug@schmorgal.com>,
	stable <stable@kernel.org>
Subject: [PATCH 5.10 094/290] serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level
Date: Wed,  3 Jul 2024 12:37:55 +0200
Message-ID: <20240703102907.739885258@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doug Brown <doug@schmorgal.com>

commit 5208e7ced520a813b4f4774451fbac4e517e78b2 upstream.

The FIFO is 64 bytes, but the FCR is configured to fire the TX interrupt
when the FIFO is half empty (bit 3 = 0). Thus, we should only write 32
bytes when a TX interrupt occurs.

This fixes a problem observed on the PXA168 that dropped a bunch of TX
bytes during large transmissions.

Fixes: ab28f51c77cd ("serial: rewrite pxa2xx-uart to use 8250_core")
Signed-off-by: Doug Brown <doug@schmorgal.com>
Link: https://lore.kernel.org/r/20240519191929.122202-1-doug@schmorgal.com
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pxa.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -125,6 +125,7 @@ static int serial_pxa_probe(struct platf
 	uart.port.regshift = 2;
 	uart.port.irq = irq;
 	uart.port.fifosize = 64;
+	uart.tx_loadsz = 32;
 	uart.port.flags = UPF_IOREMAP | UPF_SKIP_TEST | UPF_FIXED_TYPE;
 	uart.port.dev = &pdev->dev;
 	uart.port.uartclk = clk_get_rate(data->clk);



