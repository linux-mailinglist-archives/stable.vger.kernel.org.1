Return-Path: <stable+bounces-146201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E926AC24CC
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 16:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C23E169E64
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 14:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D9B2951AC;
	Fri, 23 May 2025 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNCpdDBu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECFD2DCBE3
	for <stable@vger.kernel.org>; Fri, 23 May 2025 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748009629; cv=none; b=evKnX+DF4J6NWmEGtr0k05WmeDmdn3QzAzdwmPDVQKuJv9y6kjTb9Nm6w5k/wOtxQRYg+cZzrPNeOGPlGY3mPMMS/PY1ON196rN5BT0pWFenEzo72hOEug3pH9iitKvGxmi6fYD5q4cb+Zr6JLtu05QFEWhIvWE7aLu2S0ulJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748009629; c=relaxed/simple;
	bh=Jseb4NS2eqGwI4R7w8s8bDPF1GlcckFkUdxBLC2H7yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J5ncqfgRyPzN5IKfeO7ow+KpVzLIQQRu+VbWgm3yI7nIWh1ZGFelVzBMe+X1+HqWohTI301g7MRSwq0oHG+B79g+VTDVsSkFDITfp1iur6DVaVIQW3P416qH18RaHLjqrC6KKj11agyBlo/Z3dXQY4Ft27IdNqbdK1iUIc+UrDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNCpdDBu; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742a018da9cso1279332b3a.1
        for <stable@vger.kernel.org>; Fri, 23 May 2025 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748009627; x=1748614427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+4Gw41/OQ0iOZUqqBhOAfMdmLA0mV1S28wgYG2zZJw=;
        b=CNCpdDBuZDVN+UglsLCQ1lIwtc4j3zuCkVqP6g4hu4pfjI47lI1w9yyuiGZxpeXCK/
         3RjgtOq19hqXMAla5N1cbab4bhkTisjkta5JJOdovYDXJ8Mfi1evlNuGYBtdBKUgMdM/
         GvX6whuOetq63zB61vaq85YfQVmYyNohzovtwybsDGHARRevqwJ45vSFrJOJQqsboJF2
         dpd4F4wA3VMPxFViuJYXmy4RFj3mU86mIo2xJ6fcz6Nv8bree9XPXjW1iRJZvx7Zfd4U
         6fb42NfzJan0Cu8gcyEsuILut8RdPkDT6vN62s3HLgFzp9yk3gL26Lu5UJZZxDRwGxve
         +4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748009627; x=1748614427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+4Gw41/OQ0iOZUqqBhOAfMdmLA0mV1S28wgYG2zZJw=;
        b=mETRvf8fx64/TBjVhiilkyQI+CZu07ERCd/y/8H8KxtXzctptysNgIn9Ihnq4/9AMR
         hrgFf6fj6h7clT2saO03dTL47JafKM48dD3LWDlzSr80urSLYQtBN8OWDgEhtkxSoc3D
         FEAWSugBx2RLAKZg6T/yT3O5k65oyYlKUelT+ZcLxAzR/3VJGbhO7noKa35hFibTtx4c
         Mbkgy/4xFV3BmFJuFWNfpiErfk91AcYUTnauy45PVF5KggD6iChWfaFl+ORp6XACYaT6
         R8jEDt/6Z5ZagIFEl/QDo5wcnWb9NDoqPgked/J8wZHJqGGtsKCLcW2EbgIYSNBVo8jd
         3bQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW0ryt4KESdAgVOmpAcfw1xmot+di+Sk6a4u6XekGs5stdrBR/45s8N57NNG5I1e/TXYocqk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEugmKYKDmxPFgoqw38sSFKz+wg4kYL408XMwJs5o/TI3M0UyJ
	F1sCDSg+NewoCaRoeHCnev+vJTm3WJ4Dbw9Jvu5DpzoXyT5d/TiCCDD0
X-Gm-Gg: ASbGncvJHns2NPdVkAF6UjCpV2XK6Kjeye8yS/pUGwW4XGTs68D1JgBp21xdgVuyI+m
	it7ukD8pWlAv7iFqtXQhB4UH3gojj7MXZmngoyH+XhBmkYeE6Lhp1Jf8I9x6HFKlP0KIS/A+HcQ
	qVsDBhjlP4jy3p9ZWY7irNds97vhAmT9R7ARwOTlgWVehxG6xMLE5r2MgQ72k8mWq+mpQzUbN6U
	5DlcZ5ymJ/XOGQSOg5Y+7EBqhG3Sy8xNHnNhaPqY+nlhBgXpdQxop1Kl7lUnnOb4279uhEuZcT9
	CzWAJ+FDluKCQjUzcndA39UU7YW/gIyAc64G6m0Ywm1FY3WL0KygF1PCegwV9Cx56OuumgJ3iyu
	5hH6rj9xkMg==
X-Google-Smtp-Source: AGHT+IEsFNkFA5mx/IiPhUbfF5BwPlD+SPDWdvJ4H9SUm4nKencOfhrpwR+9czg55PcKFZP6SJnscg==
X-Received: by 2002:a05:6a21:350d:b0:201:8a06:6e34 with SMTP id adf61e73a8af0-2187c0f18a5mr1841504637.3.1748009627021;
        Fri, 23 May 2025 07:13:47 -0700 (PDT)
Received: from MGG23TF6W0.corp.ebay.com ([202.76.247.146])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-745f73f4b29sm668569b3a.21.2025.05.23.07.13.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 May 2025 07:13:46 -0700 (PDT)
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
Date: Fri, 23 May 2025 22:13:38 +0800
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


