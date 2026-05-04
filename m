Return-Path: <stable+bounces-243654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O5SIB2u+GlIxwIAu9opvQ
	(envelope-from <stable+bounces-243654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:33:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8554BFA6C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 305B930377C8
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A5E3DE443;
	Mon,  4 May 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wl9pr3+Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1AB3DE450;
	Mon,  4 May 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904437; cv=none; b=ntrgleEnkyuIVCoZq+lAE6fcJGDuGdGLPYB0Ej87ki6rg6WPRd07pVULcAjdv3968WcdO++6nnamW1+C1GY3Vvbx8v4F202F53HQkOT9IZIqlqpa7JAlJ7blIyjvlox2geeUMgAB3PExR4faVSuLc4GwAfLmWAHsBtkrLSrT6Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904437; c=relaxed/simple;
	bh=uIfo70Q/3W7VBo5FjFsS1hNq25MG6QNYGX0hPsGAQFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bwm9/K3D9eMBwLl9HN1M2kPHkSOh45EjVicuWEmD9u/Ymodm0xwAim+SqAqWUvdWwR3FZpEPJPYyX8Hv2vRQENIDyFRPWYdj55MuBiTl78eeIRfhnOOr4hppIPc9cK7aLYTJVCeV9ndJFEEJ45+o090XqeSuiii3PXZ7li33Nn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wl9pr3+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EB9C2BCB8;
	Mon,  4 May 2026 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904437;
	bh=uIfo70Q/3W7VBo5FjFsS1hNq25MG6QNYGX0hPsGAQFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wl9pr3+ZMywPsTKSmzADVfsIcd+8FbLoxe8sGu7SVR2WNdv/8TK2e7WZNplk0j+8m
	 msue/JAeaweWunBMeyk1K+JpIPNy9W02GexvHi7jQ+T97p4rPYkh5T25m4bh1JnPHr
	 UtCSYSGSCUIUwA6e4PQu24RfXgMcDp0SyDqkgwfM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.12 039/215] hwmon: (powerz) Fix missing usb_kill_urb() on signal interrupt
Date: Mon,  4 May 2026 15:50:58 +0200
Message-ID: <20260504135131.610085226@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE8554BFA6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243654-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,roeck-us.net:email,juniper.net:email]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

commit b66437cb20a2d9ef201f40b675569f8ea7787c9f upstream.

wait_for_completion_interruptible_timeout() returns -ERESTARTSYS when
interrupted. This needs to abort the URB and return an error. No data
has been received from the device so any reads from the transfer
buffer are invalid.

The original code tests !ret, which only catches the timeout case (0).
On signal delivery (-ERESTARTSYS), !ret is false so the function skips
usb_kill_urb() and falls through to read from the unfilled transfer
buffer.

Fix by capturing the return value into a long (matching the function
return type) and handling signal (negative) and timeout (zero) cases
with separate checks that both call usb_kill_urb() before returning.

Fixes: 4381a36abdf1c ("hwmon: add POWER-Z driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260410002521.422645-3-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/powerz.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/hwmon/powerz.c
+++ b/drivers/hwmon/powerz.c
@@ -112,6 +112,7 @@ static void powerz_usb_cmd_complete(stru
 
 static int powerz_read_data(struct usb_device *udev, struct powerz_priv *priv)
 {
+	long rc;
 	int ret;
 
 	if (!priv->urb)
@@ -133,8 +134,14 @@ static int powerz_read_data(struct usb_d
 	if (ret)
 		return ret;
 
-	if (!wait_for_completion_interruptible_timeout
-	    (&priv->completion, msecs_to_jiffies(5))) {
+	rc = wait_for_completion_interruptible_timeout(&priv->completion,
+						       msecs_to_jiffies(5));
+	if (rc < 0) {
+		usb_kill_urb(priv->urb);
+		return rc;
+	}
+
+	if (rc == 0) {
 		usb_kill_urb(priv->urb);
 		return -EIO;
 	}



