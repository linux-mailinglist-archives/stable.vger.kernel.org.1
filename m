Return-Path: <stable+bounces-76515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0738297A6B9
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 19:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB21F27264
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B1415B97B;
	Mon, 16 Sep 2024 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfKZ0IwF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2A15AD9B;
	Mon, 16 Sep 2024 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507623; cv=none; b=lmVu6csPQGIA8IsKv2+sbf2QhRil8vEJUCx5y8dboc5EHSZWOrfGnFRd3n63d2Hnqmlp6SyJd+qKL2m3UxFoph3w8f8cJUU5ZC3Ca4ar9zvr2wK30WZXO53eVFuHVJHgA/+vyi2SBljWZCekcrPhT8npJ0tOS7bKRrxn7hO6f3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507623; c=relaxed/simple;
	bh=5qUhOm/N1xmDx37BzF4Us12jj7jxEK7J2OvOQCs+KIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUgBYn2EnggjRgWwNY4T8UiOTOy6GAhAlMDmcRrQESysF5zq9gzPjtr+VqGU39/kkrdqZ7K4F33PSkWEK3PmLLL2vwa8gRPsrJKc9oYsrxSG1A5ClRt6p17h4Ripu74uT+kIkkeZhoSU1OQEDEMIK2OicLxCtNJFTzfad3G2Klo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfKZ0IwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F8CC4CED3;
	Mon, 16 Sep 2024 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726507623;
	bh=5qUhOm/N1xmDx37BzF4Us12jj7jxEK7J2OvOQCs+KIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DfKZ0IwF1udZMyn5LKM4gMYAnIY4mM6dt4LOFY2RCTt3At5qS+hMZpPmgKDCuR/p6
	 k84EeefGYh/HaDUie//XokwSUGUPgJplID/uo9euiZW1bpXjEPGMJMftnmZmHIss13
	 NGzgJLo6KQyUV5ko+dndHApXfXU7KmSv64LgiBqbxnaoBhadi44NM2vH/tggB4Me/1
	 55Bm1TDP/1X4KVW7jjew5kJNpZSegNZgO0NETOjYBKSQelLBDnemWsKGtCnX6h1Knq
	 GcQL+mYdp3IiG13RyqJ3BIRXo4MKzMozW0HKRTSvpWB2TYesLuo/WjGhQQzIC2360O
	 EEA+lHyaVgd9Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sqFVS-00000000234-3RXq;
	Mon, 16 Sep 2024 19:27:22 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Aniket Randive <quic_arandive@quicinc.com>
Subject: [PATCH 1/3] serial: qcom-geni: fix premature receiver enable
Date: Mon, 16 Sep 2024 19:26:40 +0200
Message-ID: <20240916172642.7814-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240916172642.7814-1-johan+linaro@kernel.org>
References: <20240916172642.7814-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The receiver should no be enabled until the port is opened so drop the
bogus call to start tx from the setup code which is shared with the
console implementation.

This was added for some confused implementation of hibernation support,
but the receiver must not be started unconditionally as the port may not
have been open when hibernating the system.

Fixes: 35781d8356a2 ("tty: serial: qcom-geni-serial: Add support for Hibernation feature")
Cc: stable@vger.kernel.org	# 6.2
Cc: Aniket Randive <quic_arandive@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 6f0db310cf69..9ea6bd09e665 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1152,7 +1152,6 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 			       false, true, true);
 	geni_se_init(&port->se, UART_RX_WM, port->rx_fifo_depth - 2);
 	geni_se_select_mode(&port->se, port->dev_data->mode);
-	qcom_geni_serial_start_rx(uport);
 	port->setup = true;
 
 	return 0;
-- 
2.44.2


