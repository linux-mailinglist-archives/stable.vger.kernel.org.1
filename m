Return-Path: <stable+bounces-20665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B485AADA
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9061F22D24
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CCB481CC;
	Mon, 19 Feb 2024 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d98thUT7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49339446A1
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366904; cv=none; b=uMn+P07Q7XScD3WEAvUoj+xwuL8DRnAsY7t2HrKdB07jPW9zl283zQBgSy+wRigYiRuVui3soDd/6+LE8Wm48AAIB+YG6y3Unu0foTMcPtJ4TgXKYKQ9pQbCykszm0V2GkUZbQWKYOckkRK90sIa0NA8bRYT6Uqr6OmPMKs4Y60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366904; c=relaxed/simple;
	bh=mWkL54OZLMuNYNH9FEVcrVo84b4REs3yoS6aRVGOqtw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bruW2oYoV7TYqw8rXXqpi/vG37BCxSxD1YVGfNZqn407GLV4WmPMuIDlFbQcWD8GEDJ+zQyq1rwIXVmNaOnaQ8d087xCmf8LJM2uRhwHo9dchPuOIYw1xeZ4Nsgz2oc7w7w6k1FoggixdXJBCc73jMF82fhFdChz/ZEtJ4oCq4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d98thUT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7A5C433C7;
	Mon, 19 Feb 2024 18:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366904;
	bh=mWkL54OZLMuNYNH9FEVcrVo84b4REs3yoS6aRVGOqtw=;
	h=Subject:To:Cc:From:Date:From;
	b=d98thUT7K0Sobof4Z/gbizdfqTKMfhv3vk1uNF4o7nfPW5PersrgFcrEoPYGb0Dsf
	 PM6tMqUxsrB0MqYLfcYSJ4RzWp+wRl4CpC3qgRs7CQRtTfRxISjAwrlaAHtxzbH4M+
	 bHQQuKvceE4ibNbk9uAadCUVVNnEV3Uky+YN7uC8=
Subject: FAILED: patch "[PATCH] serial: max310x: prevent infinite while() loop in port" failed to apply to 5.4-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:21:30 +0100
Message-ID: <2024021930-subprime-fondue-f8d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x b35f8dbbce818b02c730dc85133dc7754266e084
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021930-subprime-fondue-f8d3@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

b35f8dbbce81 ("serial: max310x: prevent infinite while() loop in port startup")
93cd256ab224 ("serial: max310x: improve crystal stable clock detection")
0419373333c2 ("serial: max310x: set default value when reading clock ready bit")
6ef281daf020 ("serial: max310x: use a separate regmap for each port")
285e76fc049c ("serial: max310x: use regmap methods for SPI batch operations")
c808fab604ca ("serial: max310x: Make use of device properties")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b35f8dbbce818b02c730dc85133dc7754266e084 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue, 16 Jan 2024 16:30:01 -0500
Subject: [PATCH] serial: max310x: prevent infinite while() loop in port
 startup

If there is a problem after resetting a port, the do/while() loop that
checks the default value of DIVLSB register may run forever and spam the
I2C bus.

Add a delay before each read of DIVLSB, and a maximum number of tries to
prevent that situation from happening.

Also fail probe if port reset is unsuccessful.

Fixes: 10d8b34a4217 ("serial: max310x: Driver rework")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20240116213001.3691629-5-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 552e153a24e0..10bf6d75bf9e 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -237,6 +237,10 @@
 #define MAX310x_REV_MASK		(0xf8)
 #define MAX310X_WRITE_BIT		0x80
 
+/* Port startup definitions */
+#define MAX310X_PORT_STARTUP_WAIT_RETRIES	20 /* Number of retries */
+#define MAX310X_PORT_STARTUP_WAIT_DELAY_MS	10 /* Delay between retries */
+
 /* Crystal-related definitions */
 #define MAX310X_XTAL_WAIT_RETRIES	20 /* Number of retries */
 #define MAX310X_XTAL_WAIT_DELAY_MS	10 /* Delay between retries */
@@ -1346,6 +1350,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		goto out_clk;
 
 	for (i = 0; i < devtype->nr; i++) {
+		bool started = false;
+		unsigned int try = 0, val = 0;
+
 		/* Reset port */
 		regmap_write(regmaps[i], MAX310X_MODE2_REG,
 			     MAX310X_MODE2_RST_BIT);
@@ -1354,8 +1361,17 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 
 		/* Wait for port startup */
 		do {
-			regmap_read(regmaps[i], MAX310X_BRGDIVLSB_REG, &ret);
-		} while (ret != 0x01);
+			msleep(MAX310X_PORT_STARTUP_WAIT_DELAY_MS);
+			regmap_read(regmaps[i], MAX310X_BRGDIVLSB_REG, &val);
+
+			if (val == 0x01)
+				started = true;
+		} while (!started && (++try < MAX310X_PORT_STARTUP_WAIT_RETRIES));
+
+		if (!started) {
+			ret = dev_err_probe(dev, -EAGAIN, "port reset failed\n");
+			goto out_uart;
+		}
 
 		regmap_write(regmaps[i], MAX310X_MODE1_REG, devtype->mode1);
 	}


