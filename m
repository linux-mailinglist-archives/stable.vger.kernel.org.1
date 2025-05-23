Return-Path: <stable+bounces-146202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F29AC250C
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 16:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A042D4A7249
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADB02628C;
	Fri, 23 May 2025 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqtXw+2S"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328D2DCC06
	for <stable@vger.kernel.org>; Fri, 23 May 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010669; cv=none; b=tyLl+kt5h75tx56gNanWKqABScHjTNqkWnwhC6gJxvKQID6G2PwJdwj41+wIoZrA0XsOPLTvKl/Z9C1BnclmBc3S5lNsawRxjyjAwqBLApDDrpGnmHZi852qdxrjYCBqLrCX4Wv57sZ3WuRaQV4BnHUd8JFmDJ3SgD73BR5GR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010669; c=relaxed/simple;
	bh=rvd7EUXzFIsALCAIQdUtEkd4vd12Kun7uEH+SRQn8BY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B4c2YszUoW+XxbbybtpB7onqZPh1SAsc1R8APW/Akfu5L3qBLQWeE9tURRLDOGBMO6SgtIHBr0d687x0yWCMHbf90IQNErn+2AQeMCa3+iMQbuer4xXrJ4ZYLq+dk95DjWnanO8CQJOP6nisxSMjQ6Q8Enc1KwhWZ8JEE1pk+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqtXw+2S; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-231b7b21535so6473345ad.1
        for <stable@vger.kernel.org>; Fri, 23 May 2025 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748010667; x=1748615467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCNjrDvh5XV67zUUtWHRod2ZItIfCN0Mi7RLGuUb1Jk=;
        b=CqtXw+2SkK7Rqi/4O4Yi5PTU4+O3rP74ijLvIHG1mgB9Q8f6IfXXyDn1hyzUThy3GQ
         TMcDH5iq078ULO/rz4lEo0IXHkEs9eOmNNhOE8TjqDMdOHK2f1CK68Np+3y1sQ0ItiLA
         mYIxUIbQJO+JxpQrX2LbyfzYLeFZGxN89KF4ibDLMCBg4U8ju3Fw0ZVSt9MgASHHhIZp
         4hRIvzYJ67sgtCmdB6GP4WvWjYv/d6hagbDYgfcRl87cqF1gcbAL8UEdrLEG+dXCUOgI
         psqwOAwloiBcn7MukSNLjwwSw7Rs9Xo9EGcJagphelqALVp8X1IB3b7YKkqP/GXdPzky
         MGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748010667; x=1748615467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCNjrDvh5XV67zUUtWHRod2ZItIfCN0Mi7RLGuUb1Jk=;
        b=TiAJNq/h4KGyGTscPJFPMlHQ7m8+5Il4JKUg1QQNe87YTe9jV8O1an8uotb+/qogCw
         oKrqDeBtLAtL1Mf1s2mxmjfjT78lueEDCTVX6tLX3YRWb9tHV/MYGCXN6KH3tNbYiBoX
         2VhBXKd/Z5Kpn1aEaXyIXGTwgbEfA3M1cbIwOnmVPECJdyCwqXqmspltml9MYSRYj97N
         l4PtGFH/Y/ngGRyOe3P8zOeVV0/rIxOkaQqpDOjqsA2QrwJEU015Jl351l3eDRIE22bS
         Z1fJgfNrpGBjWF294QI8pdoCwlzWlXyMgGh/2mzsN7DnZuC8L8hkm2B1eHXe/RRP+rQY
         +bGg==
X-Forwarded-Encrypted: i=1; AJvYcCW6OCjhp2zZSu49lJlXqo6VFbvripPvOf+WrIvym5Nh33QoqXN8UejwBW/8waVNNZt8UBTBJJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWQPbFT4tJfU1iIOSHhC6tFNTI+PPWiFObcl7oUPH9qO9vOPEU
	TVnmSQazmW6iPjvBsXhYrzErBDsRItt3BwOsTdYN7pSyz7zAj/OUt0az
X-Gm-Gg: ASbGnctLTYzDytduZCMdEQpCCABhza80LJMNBInuf301XkT4XxVPnzAgXCYSwSg6pMd
	Vszo+FU0NZMRjuopFK8y4wJRHEO06FavbR4vzK0j4ohxGhntcG/alf/3mHGEvYLkZDbzUio8hDA
	xIhiRbQBUGscByq1jJ0EBLNyVHUI1Q3gC+LI7lucIDlwy0L2CgAWYhUbCz/p59DGwXJnpbq7F9/
	ADJAsNszaE6cAqXdbHYTNFDEYwuQOY9IB3isdsxzNRtSYWVa//QR6X87lFE29aFgBiKZhm33NuZ
	DhjgCnJJpD7o0T1W1EQ8B4zO/pRiVhBJRFM3JwBpGzj91EzZAUqR4721cbDLvSjGvy0dorrxKFo
	=
X-Google-Smtp-Source: AGHT+IFFXazplgAk9pwmRJEH8OLFBc1k91+XW9vzy1/ovJPJwPPl9qs7bruSJQdAxZ4Q7fB+zjidqw==
X-Received: by 2002:a17:902:fc43:b0:22e:62da:2e58 with SMTP id d9443c01a7336-233f36e4923mr17923995ad.10.1748010667104;
        Fri, 23 May 2025 07:31:07 -0700 (PDT)
Received: from MGG23TF6W0.corp.ebay.com ([202.76.247.146])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-231d4ac9fc8sm124820515ad.27.2025.05.23.07.31.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 May 2025 07:31:06 -0700 (PDT)
From: Jianlin Lv <iecedge@gmail.com>
X-Google-Original-From: Jianlin Lv <jianlv@ebay.com>
To: kernel-team@lists.ubuntu.com
Cc: iecedge@gmail.com,
	jianlv@ebay.com,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	stable@vger.kernel.org,
	Ahmed Naseef <naseefkm@gmail.com>,
	Oliver Neukum <oneukum@suse.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [SRU] [Noble] [PATCH 1/1] net: usb: usbnet: restore usb%d name exception for local mac addresses
Date: Fri, 23 May 2025 22:30:58 +0800
Message-Id: <83eababe153e10f30ba5097717299b5260d0b574.1748010457.git.iecedge@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1748010457.git.iecedge@gmail.com>
References: <cover.1748010457.git.iecedge@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

BugLink: https://bugs.launchpad.net/bugs/2111592

commit 8a7d12d674ac ("net: usb: usbnet: fix name regression") assumed
that local addresses always came from the kernel, but some devices hand
out local mac addresses so we ended up with point-to-point devices with
a mac set by the driver, renaming to eth%d when they used to be named
usb%d.

Userspace should not rely on device name, but for the sake of stability
restore the local mac address check portion of the naming exception:
point to point devices which either have no mac set by the driver or
have a local mac handed out by the driver will keep the usb%d name.

(some USB LTE modems are known to hand out a stable mac from the locally
administered range; that mac appears to be random (different for
mulitple devices) and can be reset with device-specific commands, so
while such devices would benefit from getting a OUI reserved, we have
to deal with these and might as well preserve the existing behavior
to avoid breaking fragile openwrt configurations and such on upgrade.)

Link: https://lkml.kernel.org/r/20241203130457.904325-1-asmadeus@codewreck.org
Fixes: 8a7d12d674ac ("net: usb: usbnet: fix name regression")
Cc: stable@vger.kernel.org
Tested-by: Ahmed Naseef <naseefkm@gmail.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
Link: https://patch.msgid.link/20250326-usbnet_rename-v2-1-57eb21fcff26@atmark-techno.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

(cherry picked from commit 2ea396448f26d0d7d66224cb56500a6789c7ed07)
Signed-off-by: Jianlin Lv <iecedge@gmail.com>
---
 drivers/net/usb/usbnet.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 9f66c47dc58b..08cbc8e4b361 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -178,6 +178,17 @@ int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
 }
 EXPORT_SYMBOL_GPL(usbnet_get_ethernet_addr);
 
+static bool usbnet_needs_usb_name_format(struct usbnet *dev, struct net_device *net)
+{
+	/* Point to point devices which don't have a real MAC address
+	 * (or report a fake local one) have historically used the usb%d
+	 * naming. Preserve this..
+	 */
+	return (dev->driver_info->flags & FLAG_POINTTOPOINT) != 0 &&
+		(is_zero_ether_addr(net->dev_addr) ||
+		 is_local_ether_addr(net->dev_addr));
+}
+
 static void intr_complete (struct urb *urb)
 {
 	struct usbnet	*dev = urb->context;
@@ -1766,13 +1777,11 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		if (status < 0)
 			goto out1;
 
-		// heuristic:  "usb%d" for links we know are two-host,
-		// else "eth%d" when there's reasonable doubt.  userspace
-		// can rename the link if it knows better.
+		/* heuristic: rename to "eth%d" if we are not sure this link
+		 * is two-host (these links keep "usb%d")
+		 */
 		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
-		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
-		     /* somebody touched it*/
-		     !is_zero_ether_addr(net->dev_addr)))
+		    !usbnet_needs_usb_name_format(dev, net))
 			strscpy(net->name, "eth%d", sizeof(net->name));
 		/* WLAN devices should always be named "wlan%d" */
 		if ((dev->driver_info->flags & FLAG_WLAN) != 0)
-- 
2.34.1


