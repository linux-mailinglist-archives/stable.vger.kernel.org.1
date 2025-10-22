Return-Path: <stable+bounces-189008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EFBBFCE17
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29BE3A9E34
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D853E28031C;
	Wed, 22 Oct 2025 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxwkrXbU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8083934D4F1;
	Wed, 22 Oct 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146814; cv=none; b=Jph5mScdFeeVjJoI6Cl/uTTb6I6SzL++W4DNjAVEmwnt2EHw08Fw17HMKCFvfZp7GdUPUR+gB+F4MM10LKg803mO1ZH4sfueXM4KWi94D76HUvloAX5JTEXMZ9h0pwPKspimoRp+AG5uA58NlL/bioxViHgxMXPegDCv4SxJwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146814; c=relaxed/simple;
	bh=N9SEG1mjhY5ITcDXuFtE95SgJ+Pu0dWYnfe73PHyEdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGatbkxdlQ/FyqHdbVpHeDbfalCkPDwpRlrgDeHswUQK00yHGLn2hPDGfwmavoBjxctfw/IFH+y7V/XNyMv2xmjYQyqx/c5v4rJZYOQXyx3OFFDCUQZl1OhitQIfAmoMWhJNRAcerma//+a9AcVFeOBaCds8ge4lTh+lYoOPZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxwkrXbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6EDC113D0;
	Wed, 22 Oct 2025 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761146813;
	bh=N9SEG1mjhY5ITcDXuFtE95SgJ+Pu0dWYnfe73PHyEdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxwkrXbUrQMUU+8trCZE4X5seegiGALUBJJxZqrPVP4xrhUu1pQa7d/oDAQzTtA5v
	 Rq/u/Odi58cjnE587dXPwsdVdLpP9J6e1ZgGLiDgT9dT34+J4bD9JJLK4v5ZijNwPH
	 gljvcB7WjKw7r4AX9cOH5bVixD4f+wA6Xi/NGVrAC9MKSeo0OAf2EvAWlsPmVf2dbW
	 ZpwfZcBhPZ57vnc+pvo7uTiy7Jpug6tzRt64NItrqs9qNskWk/dn4dLzK9WCdXOVru
	 X1QaNytieRWpytzIpwJHVtBobgabJ3H1uQQx0J038hlA9/9kpFk9LjhCMrtS4PBn66
	 nA31zDlpQ9Kng==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vBajr-000000006JD-2jYt;
	Wed, 22 Oct 2025 17:26:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/8] USB: serial: belkin_sa: fix TIOCMBIS and TIOCMBIC
Date: Wed, 22 Oct 2025 17:26:33 +0200
Message-ID: <20251022152640.24212-2-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251022152640.24212-1-johan@kernel.org>
References: <20251022152640.24212-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Asserting or deasserting a modem control line using TIOCMBIS or TIOCMBIC
should not deassert any lines that are not in the mask.

Fix this long-standing regression dating back to 2003 when the
tiocmset() callback was introduced.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/belkin_sa.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
index 44f5b58beec9..aa6b4c4ad5ec 100644
--- a/drivers/usb/serial/belkin_sa.c
+++ b/drivers/usb/serial/belkin_sa.c
@@ -435,7 +435,7 @@ static int belkin_sa_tiocmset(struct tty_struct *tty,
 	struct belkin_sa_private *priv = usb_get_serial_port_data(port);
 	unsigned long control_state;
 	unsigned long flags;
-	int retval;
+	int retval = 0;
 	int rts = 0;
 	int dtr = 0;
 
@@ -452,26 +452,32 @@ static int belkin_sa_tiocmset(struct tty_struct *tty,
 	}
 	if (clear & TIOCM_RTS) {
 		control_state &= ~TIOCM_RTS;
-		rts = 0;
+		rts = 1;
 	}
 	if (clear & TIOCM_DTR) {
 		control_state &= ~TIOCM_DTR;
-		dtr = 0;
+		dtr = 1;
 	}
 
 	priv->control_state = control_state;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	retval = BSA_USB_CMD(BELKIN_SA_SET_RTS_REQUEST, rts);
-	if (retval < 0) {
-		dev_err(&port->dev, "Set RTS error %d\n", retval);
-		goto exit;
+	if (rts) {
+		retval = BSA_USB_CMD(BELKIN_SA_SET_RTS_REQUEST,
+					!!(control_state & TIOCM_RTS));
+		if (retval < 0) {
+			dev_err(&port->dev, "Set RTS error %d\n", retval);
+			goto exit;
+		}
 	}
 
-	retval = BSA_USB_CMD(BELKIN_SA_SET_DTR_REQUEST, dtr);
-	if (retval < 0) {
-		dev_err(&port->dev, "Set DTR error %d\n", retval);
-		goto exit;
+	if (dtr) {
+		retval = BSA_USB_CMD(BELKIN_SA_SET_DTR_REQUEST,
+					!!(control_state & TIOCM_DTR));
+		if (retval < 0) {
+			dev_err(&port->dev, "Set DTR error %d\n", retval);
+			goto exit;
+		}
 	}
 exit:
 	return retval;
-- 
2.49.1


