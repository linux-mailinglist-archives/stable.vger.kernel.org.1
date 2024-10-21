Return-Path: <stable+bounces-87027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFB89A5E7B
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC991F2114F
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EA81E1A37;
	Mon, 21 Oct 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PCQczRlX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CC31C69A
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498906; cv=none; b=FEShz5ndVPszjkOx0KoD61yGj7U+yr+9ZzZ2xVrwNSPnPYWAX+zLRcbITxtwafoDlKpV8b/Zh//NwCwtIiI3fCUwQkaZckv318EM0Jfm5+hcLw2DDuxN12yPnjl/vE1GfMP7OAFl3571WFWbZQda2VDQ83uY6n/dv5PWU7YaWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498906; c=relaxed/simple;
	bh=YC7Gt5N9rw4f2vyTUvYXdXzTft21Wflo8IFgftIjBHQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WO/0EXJKzXYDyA9ThEyKClMBnqfmOFC0BDPbSFvDNxyWbB9fZB7nVLJNlvpDiweINMpZpJIo52i2zuCpnWyA72mwwNQGNUnFfIZLl+ydSaEnwvO9X8iOMdmc1XybIsIJeWYTw2zyWMsWXCA5PTLffIIO49baM8SEv9lbc+3/7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PCQczRlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A273C4CEC3;
	Mon, 21 Oct 2024 08:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729498905;
	bh=YC7Gt5N9rw4f2vyTUvYXdXzTft21Wflo8IFgftIjBHQ=;
	h=Subject:To:Cc:From:Date:From;
	b=PCQczRlXK6LL0HJ11J4cf2nxJwcb4Ph3uAzGL/nWPNEFA0XmkdGa0VQYSvG/2CkTw
	 wKuB9bQ463PJROpUtUsaWBar086rTfHUHUPoLlPVCWDJyITYoNCOG2SWdq0YGxrog3
	 lFncqNYsf58U0ALukV5k17WtEZmZyE8BtW3h2zro=
Subject: FAILED: patch "[PATCH] serial: qcom-geni: fix shutdown race" failed to apply to 6.6-stable tree
To: johan+linaro@kernel.org,bartosz.golaszewski@linaro.org,dianders@chromium.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Oct 2024 10:21:42 +0200
Message-ID: <2024102142-pristine-mayday-9998@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 23f5f5debcaac1399cfeacec215278bf6dbc1d11
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102142-pristine-mayday-9998@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 23f5f5debcaac1399cfeacec215278bf6dbc1d11 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 9 Oct 2024 16:51:04 +0200
Subject: [PATCH] serial: qcom-geni: fix shutdown race

A commit adding back the stopping of tx on port shutdown failed to add
back the locking which had also been removed by commit e83766334f96
("tty: serial: qcom_geni_serial: No need to stop tx/rx on UART
shutdown").

Holding the port lock is needed to serialise against the console code,
which may update the interrupt enable register and access the port
state.

Fixes: d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in progress at shutdown")
Fixes: 947cc4ecc06c ("serial: qcom-geni: fix soft lockup on sw flow control and suspend")
Cc: stable@vger.kernel.org	# 6.3
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20241009145110.16847-4-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 2e4a5361f137..87cd974b76bf 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1114,10 +1114,12 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 {
 	disable_irq(uport->irq);
 
+	uart_port_lock_irq(uport);
 	qcom_geni_serial_stop_tx(uport);
 	qcom_geni_serial_stop_rx(uport);
 
 	qcom_geni_serial_cancel_tx_cmd(uport);
+	uart_port_unlock_irq(uport);
 }
 
 static void qcom_geni_serial_flush_buffer(struct uart_port *uport)


