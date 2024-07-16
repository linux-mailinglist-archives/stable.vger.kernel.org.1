Return-Path: <stable+bounces-59795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F72932BCA
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1A8B20EE3
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B2119AD46;
	Tue, 16 Jul 2024 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lcop3L9i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577C312B72;
	Tue, 16 Jul 2024 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144931; cv=none; b=f3R20aWQO3VlR6lp9mvKxX4hUv7rvHCO3hMa7giSnmLGtOHUYjLM4JfcajuKM8AVNmaZs8TqHDryoJbBq7ujfYBdpAYhQXdULcatuKbnPFvO6f092zY6Nc+mwiAIr99f8bSSvBnvJOb++JlIUoh5dhNIX/sN2a612EVMtkd2GcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144931; c=relaxed/simple;
	bh=N5yyPMZAJ8A/xapwlQcb1II3ixTC5pOXcTtLE/rcuRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdIkAn8ilCz6dS4K7Wy/XZq/+JXD+yf+dKJK0a2H1/9m1xgRmwDgHgAXDwgsO5bQ8H/rKzunEuJRHECs0ilopr6dIaVq5t4XyqpHxU/fG+MdRujdFnJTJjfbFYemXrGWPyyEuBNkkTbXE+KwZSIJFCxPn7PQh7IbvS2dVg5EuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lcop3L9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B81C4AF0D;
	Tue, 16 Jul 2024 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144931;
	bh=N5yyPMZAJ8A/xapwlQcb1II3ixTC5pOXcTtLE/rcuRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lcop3L9iCh1iCvTr8RvXrub6OukLQFQOeluJq9kzLuhk4eT4tvB2gAzEU7Htb87VB
	 GQjYwBIt7YGg76asfBYZ2AF4aM8IRYet/bIX1RmCpI9hQkgPhiOkaOodYWSH4kGWke
	 L3QuODrphEaGYfOrTaoJaZakGUxEL3gmOfyY9u+s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 026/143] spi: add defer_optimize_message controller flag
Date: Tue, 16 Jul 2024 17:30:22 +0200
Message-ID: <20240716152756.994428054@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152755.980289992@linuxfoundation.org>
References: <20240716152755.980289992@linuxfoundation.org>
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

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit ca52aa4c60f76566601b42e935b8a78f0fb4f8eb ]

Adding spi_optimize_message() broke the spi-mux driver because it
calls spi_async() from it's transfer_one_message() callback. This
resulted in passing an incorrectly optimized message to the controller.
For example, if the underlying controller has an optimize_message()
callback, this would have not been called and can cause a crash when
the underlying controller driver tries to transfer the message.

Also, since the spi-mux driver swaps out the controller pointer by
replacing msg->spi, __spi_unoptimize_message() was being called with a
different controller than the one used in __spi_optimize_message(). This
could cause a crash when attempting to free the message resources when
__spi_unoptimize_message() is called in spi_finalize_current_message()
since it is being called with a controller that did not allocate the
resources.

This is fixed by adding a defer_optimize_message flag for controllers.
This flag causes all of the spi_[maybe_][un]optimize_message() calls to
be a no-op (other than attaching a pointer to the spi device to the
message).

This allows the spi-mux driver to pass an unmodified message to
spi_async() in spi_mux_transfer_one_message() after the spi device has
been swapped out. This causes __spi_optimize_message() and
__spi_unoptimize_message() to be called only once per message and with
the correct/same controller in each case.

Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
Closes: https://lore.kernel.org/linux-spi/Zn6HMrYG2b7epUxT@pengutronix.de/
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Closes: https://lore.kernel.org/linux-spi/20240628-awesome-discerning-bear-1621f9-mkl@pengutronix.de/
Fixes: 7b1d87af14d9 ("spi: add spi_optimize_message() APIs")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20240708-spi-mux-fix-v1-2-6c8845193128@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mux.c   |  1 +
 drivers/spi/spi.c       | 18 +++++++++++++++++-
 include/linux/spi/spi.h |  4 ++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index bd988f53753e2..031b5795d1060 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -162,6 +162,7 @@ static int spi_mux_probe(struct spi_device *spi)
 	ctlr->bus_num = -1;
 	ctlr->dev.of_node = spi->dev.of_node;
 	ctlr->must_async = true;
+	ctlr->defer_optimize_message = true;
 
 	ret = devm_spi_register_controller(&spi->dev, ctlr);
 	if (ret)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a1958e86f75c8..9304fd03bf764 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2137,7 +2137,8 @@ static void __spi_unoptimize_message(struct spi_message *msg)
  */
 static void spi_maybe_unoptimize_message(struct spi_message *msg)
 {
-	if (!msg->pre_optimized && msg->optimized)
+	if (!msg->pre_optimized && msg->optimized &&
+	    !msg->spi->controller->defer_optimize_message)
 		__spi_unoptimize_message(msg);
 }
 
@@ -4285,6 +4286,11 @@ static int __spi_optimize_message(struct spi_device *spi,
 static int spi_maybe_optimize_message(struct spi_device *spi,
 				      struct spi_message *msg)
 {
+	if (spi->controller->defer_optimize_message) {
+		msg->spi = spi;
+		return 0;
+	}
+
 	if (msg->pre_optimized)
 		return 0;
 
@@ -4315,6 +4321,13 @@ int spi_optimize_message(struct spi_device *spi, struct spi_message *msg)
 {
 	int ret;
 
+	/*
+	 * Pre-optimization is not supported and optimization is deferred e.g.
+	 * when using spi-mux.
+	 */
+	if (spi->controller->defer_optimize_message)
+		return 0;
+
 	ret = __spi_optimize_message(spi, msg);
 	if (ret)
 		return ret;
@@ -4341,6 +4354,9 @@ EXPORT_SYMBOL_GPL(spi_optimize_message);
  */
 void spi_unoptimize_message(struct spi_message *msg)
 {
+	if (msg->spi->controller->defer_optimize_message)
+		return;
+
 	__spi_unoptimize_message(msg);
 	msg->pre_optimized = false;
 }
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c459809efee4f..64a4deb18dd00 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -532,6 +532,9 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @queue_empty: signal green light for opportunistically skipping the queue
  *	for spi_sync transfers.
  * @must_async: disable all fast paths in the core
+ * @defer_optimize_message: set to true if controller cannot pre-optimize messages
+ *	and needs to defer the optimization step until the message is actually
+ *	being transferred
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -775,6 +778,7 @@ struct spi_controller {
 	/* Flag for enabling opportunistic skipping of the queue in spi_sync */
 	bool			queue_empty;
 	bool			must_async;
+	bool			defer_optimize_message;
 };
 
 static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
-- 
2.43.0




