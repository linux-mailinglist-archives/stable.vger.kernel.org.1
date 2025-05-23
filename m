Return-Path: <stable+bounces-146184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2CBAC1FDD
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 11:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53151B67917
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 09:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09F92253AB;
	Fri, 23 May 2025 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dny6B4Hk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31657083A
	for <stable@vger.kernel.org>; Fri, 23 May 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747993054; cv=none; b=dMH+9JuTX+7ojvMMPtKS93NLeMxblXK4EAEzEdov0Fnbz4K//k5Xg4iOq/P853bud0yR1JdFGjbD2OeUUxmyUqWapxVaTV6FfJPDlyYLhHoa+xV43VjVZEidKnckpUe+EJZ0yEbeAJgUZRxaemKdNGRu1jAtcAx9W4S7izRzKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747993054; c=relaxed/simple;
	bh=Jseb4NS2eqGwI4R7w8s8bDPF1GlcckFkUdxBLC2H7yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O1bAGCvkKJ4eAKjCPGXtSwXZFMN8N/TCMgk5npbqx2kJRYefo5r5vDmby9yPqK3Tohdu7KnUa5xqXTzn7Ob4qhW+TkPLpFn4MLIQWMnEG4y4X+W4RpnWIkl9NdE6a8UFtTL+AoXzajNqMPaNbWqJ5Hsw/7av4+PzEIQpcgWKUoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dny6B4Hk; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742a018da9cso1241658b3a.1
        for <stable@vger.kernel.org>; Fri, 23 May 2025 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747993052; x=1748597852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+4Gw41/OQ0iOZUqqBhOAfMdmLA0mV1S28wgYG2zZJw=;
        b=Dny6B4HkH2SNnNj1o+MHbk+QZVQgOBNoU1b318LPnWqcs2rHAnGHCI6Y5ChLvwGICG
         Ig1cndkkK9J2SI0o18ZW1XzRflw4DBc9YB1s1T6CWfG9oiEy7r0rXiablOnJJPuUyL4B
         S6WJo0J8rc7YpqaQxnnxLeQZU1D8KczeAkMRyACOhw814btSu2opfY0XGsfj0oBYK40S
         wd4JSqjan3gHnGh3rZmDZjH/CJs+0NN0xXfSHp+x0adZO5XDKlbF386HKAuWO/r6mLBM
         sb6j4htp0Gbmefr2j+RT7Vuz0/YHgeIDcyJCQ56TwwpsIyK+j7lwcs00yYU83RLX1/S8
         saIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747993052; x=1748597852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+4Gw41/OQ0iOZUqqBhOAfMdmLA0mV1S28wgYG2zZJw=;
        b=nsh+CAZPjYTwlo/k5H5VqXxuZJzG9DOK/XTzWf0l20ZplZvlGz3R/Un3F9A+yqunvG
         6ZzGAM+6kkVXzau80LJ48zWpGfbGr4uyyK/nKSrmDfC38vZJeklmNcfBe2wJqgZhZiaG
         RmrOJ//bZOOLRtC9DARb0JbdGCs9iJ9EamfPw2PV7mDQNYP/gQW2TgyCXWUe+0xqL6vo
         ciJjS019t42njCi+mKFCV8tq6op0DVi9Hoalm5sscKyvOC9AVl5tXapadh8Jd3mUpRaH
         E4mGaYTfoNWLh9Jot6p3fxj0rNnQQSIZq8+P9hEFfCDZilj1zOD1ksMibpc7cq8PoRZF
         3aYA==
X-Forwarded-Encrypted: i=1; AJvYcCXD0AKC8VncaKH1mxg7vNiuVDP/zKO2kMbtwFKzk24cB5pjXGch1RRaGFz1kN+bV7n59jpQJ+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7WIM9UlQ+RZX6cONmhmL2e3hbrmz2zrXnme8f6XSV6GUnWd38
	wcmvN29HcWiVLSJG5pPMyRjthib0+NmzYZzPiyjSU7WdEpyjgRQl69aE
X-Gm-Gg: ASbGncuyuzWdcaqHYanSSVb5v7GPaliOh+d65KYiZAu2jQaRdwR1oAGGWPE9WYs1gmZ
	2h1fLMAPxtEHwVZtnaHrUKy+vJiRbe1qbEwyekd4H0RYpGYdeUVEl4z6El33KFNu6uC0rzuWXaX
	RUW0gg/doC7oKDJPI7SJ/TqBwf61hXxDuB+C+Tqc/EiBC4VXU29kgRnkcI5o4ONXqSefPyKR2Zs
	/YAN+BRJVNqUuP+oxhv5iZUE8xIhu2mtmYwM+mU9xq3EwNdI3yW0fOHwqxdL9e9L9SUFjyoM/J2
	/rAUZAEf5pHtfhAajOBGHTj4VLxFqpNThKgLrlNo2T7EWNhOGLmdRqcn9M+AGycJbVy9PykJfEE
	=
X-Google-Smtp-Source: AGHT+IG3bLszhXZ9OLxi60uggY71fjbb0TPhyepp4B0Z/FofBsz5komyssfqCEkICHAzvu1IbQYObQ==
X-Received: by 2002:a05:6a20:7d9b:b0:1ee:b8d7:7b56 with SMTP id adf61e73a8af0-2187c2379b9mr1078881637.6.1747993051952;
        Fri, 23 May 2025 02:37:31 -0700 (PDT)
Received: from MGG23TF6W0.corp.ebay.com ([202.76.247.150])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b26eb084cd2sm12425927a12.54.2025.05.23.02.37.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 May 2025 02:37:31 -0700 (PDT)
From: Jianlin Lv <iecedge@gmail.com>
X-Google-Original-From: Jianlin Lv <jianlv@ebay.com>
To: jianlv@ebay.com
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	stable@vger.kernel.org,
	Ahmed Naseef <naseefkm@gmail.com>,
	Oliver Neukum <oneukum@suse.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jianlin Lv <iecedge@gmail.com>
Subject: [SRU] [Noble] [PATCH 1/1] net: usb: usbnet: restore usb%d name exception for local mac addresses
Date: Fri, 23 May 2025 17:37:23 +0800
Message-Id: <7de740f8e6f5ba6b23f96f2f89ccf5949845c36b.1747992812.git.iecedge@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1747992812.git.iecedge@gmail.com>
References: <cover.1747992812.git.iecedge@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

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


