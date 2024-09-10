Return-Path: <stable+bounces-74302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A28972E97
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFBA2853BD
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B68B183CB0;
	Tue, 10 Sep 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LjZhv/4p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3765218CBE8;
	Tue, 10 Sep 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961412; cv=none; b=J54iiIKPg8i+8eL/k1lx5fBOyGjvgJeyVXBuf9O3txeGNc0OveeVOg+9tyrnGAEMnb+UqXB8tFHDVkG/jYzoZdR0kkoHiA0mxPte4ZZGCAvuScz6kvhNjSyVrclm9qzFebh8Oefos7KjGj4NIrRhu2XyB5zG4h4C5r2rHVQZOAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961412; c=relaxed/simple;
	bh=d00oKJP3DMwv3KUVtncDuEz2LuYUAHAy2Ss49MYgun4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjKHlYnqLE1hpHtlCyMJryrR9TOt+Iw3Y9ttldp5TZO8J8lvY6iagMfAb/lYKBeL6WqJSbj9vEr1Nd2fjZ/rtKd1Ps4R+bugV8sj3uJQnzV4AFz5NtNhaEbN+x+XduXTm4O70gcYGyTQyHgyoV4+3GIF9fwjUSKiw8l667usGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LjZhv/4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AF1C4CEC3;
	Tue, 10 Sep 2024 09:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961411;
	bh=d00oKJP3DMwv3KUVtncDuEz2LuYUAHAy2Ss49MYgun4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjZhv/4p2Hqyd23kcz8j1wX0xgBC5mk+C8ZArbx0VMaEKHsHu0NbXbdCL/RHmVyVX
	 uYBtdYUMWsmEl12N1no7Z6/7m/bnywioYi4BGOJv8MKCdwvS7V1ovqCQ+rgF+l1IH5
	 Duh5aCKtmAEEnqGeiU8cwsgumVYqW7THG/AYxSOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Brian Norris <briannorris@chromium.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.10 061/375] spi: rockchip: Resolve unbalanced runtime PM / system PM handling
Date: Tue, 10 Sep 2024 11:27:38 +0200
Message-ID: <20240910092624.272257754@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Norris <briannorris@chromium.org>

commit be721b451affbecc4ba4eaac3b71cdbdcade1b1b upstream.

Commit e882575efc77 ("spi: rockchip: Suspend and resume the bus during
NOIRQ_SYSTEM_SLEEP_PM ops") stopped respecting runtime PM status and
simply disabled clocks unconditionally when suspending the system. This
causes problems when the device is already runtime suspended when we go
to sleep -- in which case we double-disable clocks and produce a
WARNing.

Switch back to pm_runtime_force_{suspend,resume}(), because that still
seems like the right thing to do, and the aforementioned commit makes no
explanation why it stopped using it.

Also, refactor some of the resume() error handling, because it's not
actually a good idea to re-disable clocks on failure.

Fixes: e882575efc77 ("spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops")
Cc: stable@vger.kernel.org
Reported-by: Ondřej Jirman <megi@xff.cz>
Closes: https://lore.kernel.org/lkml/20220621154218.sau54jeij4bunf56@core/
Signed-off-by: Brian Norris <briannorris@chromium.org>
Link: https://patch.msgid.link/20240827171126.1115748-1-briannorris@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-rockchip.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -945,14 +945,16 @@ static int rockchip_spi_suspend(struct d
 {
 	int ret;
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
 	ret = spi_controller_suspend(ctlr);
 	if (ret < 0)
 		return ret;
 
-	clk_disable_unprepare(rs->spiclk);
-	clk_disable_unprepare(rs->apb_pclk);
+	ret = pm_runtime_force_suspend(dev);
+	if (ret < 0) {
+		spi_controller_resume(ctlr);
+		return ret;
+	}
 
 	pinctrl_pm_select_sleep_state(dev);
 
@@ -963,25 +965,14 @@ static int rockchip_spi_resume(struct de
 {
 	int ret;
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
 	pinctrl_pm_select_default_state(dev);
 
-	ret = clk_prepare_enable(rs->apb_pclk);
+	ret = pm_runtime_force_resume(dev);
 	if (ret < 0)
 		return ret;
 
-	ret = clk_prepare_enable(rs->spiclk);
-	if (ret < 0)
-		clk_disable_unprepare(rs->apb_pclk);
-
-	ret = spi_controller_resume(ctlr);
-	if (ret < 0) {
-		clk_disable_unprepare(rs->spiclk);
-		clk_disable_unprepare(rs->apb_pclk);
-	}
-
-	return 0;
+	return spi_controller_resume(ctlr);
 }
 #endif /* CONFIG_PM_SLEEP */
 



