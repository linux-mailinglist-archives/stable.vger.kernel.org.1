Return-Path: <stable+bounces-5550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348DE80D556
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E731C213F4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9285101B;
	Mon, 11 Dec 2023 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jWUUfwul"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F9C4F212;
	Mon, 11 Dec 2023 18:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BA8C433C7;
	Mon, 11 Dec 2023 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319019;
	bh=rMN7QoxVwmNgMZwloy8rcbgGUXhXNLlav5jGEz3CR68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWUUfwulafkY+B07+CeqLxuKlMjKk5Hx+2e0/1mSRT+2mfSPsQdDeGRFzx2cHu5vx
	 CBt1idl6yWKZq4eKCeD5P+Lu5NeQno7JihDVNsZIQa0vQ/jnPGCCLVAgxjdmi30GZw
	 9rRp6s/rJfs40ul8E+hWfcAtwmHIfRgXsdUVaQRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 01/55] spi: imx: add a device specific prepare_message callback
Date: Mon, 11 Dec 2023 19:21:11 +0100
Message-ID: <20231211182012.314171089@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182012.263036284@linuxfoundation.org>
References: <20231211182012.263036284@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit e697271c4e2987b333148e16a2eb8b5b924fd40a ]

This is just preparatory work which allows to move some initialisation
that currently is done in the per transfer hook .config to an earlier
point in time in the next few patches. There is no change in behaviour
introduced by this patch.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-imx.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 1ad4b69292ad8..eb27f47578eb9 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -59,6 +59,7 @@ struct spi_imx_data;
 
 struct spi_imx_devtype_data {
 	void (*intctrl)(struct spi_imx_data *, int);
+	int (*prepare_message)(struct spi_imx_data *, struct spi_message *);
 	int (*config)(struct spi_device *);
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
@@ -502,6 +503,12 @@ static void mx51_ecspi_disable(struct spi_imx_data *spi_imx)
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
+static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
+				      struct spi_message *msg)
+{
+	return 0;
+}
+
 static int mx51_ecspi_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -672,6 +679,12 @@ static void mx31_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
+static int mx31_prepare_message(struct spi_imx_data *spi_imx,
+				struct spi_message *msg)
+{
+	return 0;
+}
+
 static int mx31_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -768,6 +781,12 @@ static void mx21_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
+static int mx21_prepare_message(struct spi_imx_data *spi_imx,
+				struct spi_message *msg)
+{
+	return 0;
+}
+
 static int mx21_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -837,6 +856,12 @@ static void mx1_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
+static int mx1_prepare_message(struct spi_imx_data *spi_imx,
+			       struct spi_message *msg)
+{
+	return 0;
+}
+
 static int mx1_config(struct spi_device *spi)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -871,6 +896,7 @@ static void mx1_reset(struct spi_imx_data *spi_imx)
 
 static struct spi_imx_devtype_data imx1_cspi_devtype_data = {
 	.intctrl = mx1_intctrl,
+	.prepare_message = mx1_prepare_message,
 	.config = mx1_config,
 	.trigger = mx1_trigger,
 	.rx_available = mx1_rx_available,
@@ -884,6 +910,7 @@ static struct spi_imx_devtype_data imx1_cspi_devtype_data = {
 
 static struct spi_imx_devtype_data imx21_cspi_devtype_data = {
 	.intctrl = mx21_intctrl,
+	.prepare_message = mx21_prepare_message,
 	.config = mx21_config,
 	.trigger = mx21_trigger,
 	.rx_available = mx21_rx_available,
@@ -898,6 +925,7 @@ static struct spi_imx_devtype_data imx21_cspi_devtype_data = {
 static struct spi_imx_devtype_data imx27_cspi_devtype_data = {
 	/* i.mx27 cspi shares the functions with i.mx21 one */
 	.intctrl = mx21_intctrl,
+	.prepare_message = mx21_prepare_message,
 	.config = mx21_config,
 	.trigger = mx21_trigger,
 	.rx_available = mx21_rx_available,
@@ -911,6 +939,7 @@ static struct spi_imx_devtype_data imx27_cspi_devtype_data = {
 
 static struct spi_imx_devtype_data imx31_cspi_devtype_data = {
 	.intctrl = mx31_intctrl,
+	.prepare_message = mx31_prepare_message,
 	.config = mx31_config,
 	.trigger = mx31_trigger,
 	.rx_available = mx31_rx_available,
@@ -925,6 +954,7 @@ static struct spi_imx_devtype_data imx31_cspi_devtype_data = {
 static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 	/* i.mx35 and later cspi shares the functions with i.mx31 one */
 	.intctrl = mx31_intctrl,
+	.prepare_message = mx31_prepare_message,
 	.config = mx31_config,
 	.trigger = mx31_trigger,
 	.rx_available = mx31_rx_available,
@@ -938,6 +968,7 @@ static struct spi_imx_devtype_data imx35_cspi_devtype_data = {
 
 static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.intctrl = mx51_ecspi_intctrl,
+	.prepare_message = mx51_ecspi_prepare_message,
 	.config = mx51_ecspi_config,
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
@@ -952,6 +983,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 
 static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.intctrl = mx51_ecspi_intctrl,
+	.prepare_message = mx51_ecspi_prepare_message,
 	.config = mx51_ecspi_config,
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
@@ -1486,7 +1518,13 @@ spi_imx_prepare_message(struct spi_master *master, struct spi_message *msg)
 		return ret;
 	}
 
-	return 0;
+	ret = spi_imx->devtype_data->prepare_message(spi_imx, msg);
+	if (ret) {
+		clk_disable(spi_imx->clk_ipg);
+		clk_disable(spi_imx->clk_per);
+	}
+
+	return ret;
 }
 
 static int
-- 
2.42.0




