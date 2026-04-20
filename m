Return-Path: <stable+bounces-239566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH2hEcRl5mkKvwEAu9opvQ
	(envelope-from <stable+bounces-239566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:43:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B11C2431EA7
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4816132912DE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C999A33A9FF;
	Mon, 20 Apr 2026 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dWadmnei"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF633321AA;
	Mon, 20 Apr 2026 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700581; cv=none; b=PadtYL6Mx+dArscqT80eD4WQNlMWK4d4Uu1mPnSvK2kZHfF6nKAoQfh9BF+SLvpdRrFwm4OnXxpRayoZqZ66yCgWVbVLx/v+3jBja7HXhg+kXlKqVFg3a49t+0CyFUJtFbHL5Hh9N1kfBSuQe2ANaTYSUOovoPFnJbkLxDeGoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700581; c=relaxed/simple;
	bh=rHc+Ge6fdv1IZeVsq9cegwzb+RmrjQcdNkfS6KluaoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBITuSKxxm4vFlQujdb5tzy89JnNGid9dOksp9l3FFSDRZ+cYnbVf7DP/T7rPT+dYCix9e0KTSSbvCIAqq8XY6vtg6afi+CfGHgRA92dWckt1iockhFZ1qH7ydcRClO090prOfCLODYlhpzdXqA/YWW8XY4E2bdYWXWZj0HE+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dWadmnei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240A4C19425;
	Mon, 20 Apr 2026 15:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700581;
	bh=rHc+Ge6fdv1IZeVsq9cegwzb+RmrjQcdNkfS6KluaoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWadmneiS+ygFLSIvqU9a7Scqa88WY5xgshfJl+YwSpgKj8ZrDyJhnJVrwaJJDBmo
	 KucVB0yYhZUzavrbsBDxMtLbgOBqx/16AZJdeP2VnaZcl8E6t6ql7IrB5XAtzgIv5Y
	 KOqlflPkpAwILCm0cyysd9BNqeHSDix0pw4JiIos=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.19 210/220] hwmon: (powerz) Fix use-after-free on USB disconnect
Date: Mon, 20 Apr 2026 17:42:31 +0200
Message-ID: <20260420153941.588854268@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239566-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:email,juniper.net:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: B11C2431EA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

commit 08e57f5e1a9067d5fbf33993aa7f51d60b3d13a4 upstream.

After powerz_disconnect() frees the URB and releases the mutex, a
subsequent powerz_read() call can acquire the mutex and call
powerz_read_data(), which dereferences the freed URB pointer.

Fix by:
 - Setting priv->urb to NULL in powerz_disconnect() so that
   powerz_read_data() can detect the disconnected state.
 - Adding a !priv->urb check at the start of powerz_read_data()
   to return -ENODEV on a disconnected device.
 - Moving usb_set_intfdata() before hwmon registration so the
   disconnect handler can always find the priv pointer.

Fixes: 4381a36abdf1c ("hwmon: add POWER-Z driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260410002521.422645-2-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/powerz.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/hwmon/powerz.c
+++ b/drivers/hwmon/powerz.c
@@ -108,6 +108,9 @@ static int powerz_read_data(struct usb_d
 {
 	int ret;
 
+	if (!priv->urb)
+		return -ENODEV;
+
 	priv->status = -ETIMEDOUT;
 	reinit_completion(&priv->completion);
 
@@ -224,6 +227,8 @@ static int powerz_probe(struct usb_inter
 	mutex_init(&priv->mutex);
 	init_completion(&priv->completion);
 
+	usb_set_intfdata(intf, priv);
+
 	hwmon_dev =
 	    devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,
 						 &powerz_chip_info, NULL);
@@ -232,8 +237,6 @@ static int powerz_probe(struct usb_inter
 		return PTR_ERR(hwmon_dev);
 	}
 
-	usb_set_intfdata(intf, priv);
-
 	return 0;
 }
 
@@ -244,6 +247,7 @@ static void powerz_disconnect(struct usb
 	mutex_lock(&priv->mutex);
 	usb_kill_urb(priv->urb);
 	usb_free_urb(priv->urb);
+	priv->urb = NULL;
 	mutex_unlock(&priv->mutex);
 }
 



