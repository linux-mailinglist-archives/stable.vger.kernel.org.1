Return-Path: <stable+bounces-125752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2BBA6BD39
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 15:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497571885E8D
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CABC1D63C5;
	Fri, 21 Mar 2025 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jlxx5N8T"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F00154426
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567915; cv=none; b=WnB2Z9ycOL7dwqY98RyGYNohxW2PQbpDx5X0VP2vTXHfn/Xrfdg21qCc1JxAVwoUI4M3IJxkeBXNOA/QqciV2UvR/91OY8O1qHuun2QLlB+iVyKby1VMZzZGuTo2nr7xt/GS38LugrOP/88dwgdu+RGdkYoBa4fndiP9CmuMKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567915; c=relaxed/simple;
	bh=LHadlXEBY0RJqphizh74S6xIrnVqPwoW2mXBiPwoWbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIvkQVXxVNHF4tqZiJwccQppxQftAhsEEzKM+XXcaLOb166em9auXIJZQ7FfZ4Y0QDXK8xtG3ULURG8k0y89Le5G8xIPAVpBdYA+SVD/ACTPA7sHnMiPQBdLJc3/Fb/eR/EXX5Xo5Pb1JZGzy3ycBwshkzoCuaGc2pqkDHxy0IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jlxx5N8T; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac29af3382dso329960166b.2
        for <stable@vger.kernel.org>; Fri, 21 Mar 2025 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742567911; x=1743172711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKF4B5xhWhYwRHI0OYv6HEkOpn9LJElh+TkLEa7DhHM=;
        b=Jlxx5N8TU7cdrB/Zo+2AwEwfXuVYoxLrREkWMEgTkWMqcKsj2donMWvyveD5qHD1nY
         /HWoCNUZAbg/vNVUTuINSQHLbbhBKhE5aLr+9tSPlGEIYh0vmepYO2aHpRfTnvNIW6hO
         CR7QNhKiFpcRCCIDIqDPPh2NlEVoM/EaEn9kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567911; x=1743172711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKF4B5xhWhYwRHI0OYv6HEkOpn9LJElh+TkLEa7DhHM=;
        b=xK9TfSXmpDq8EvgbN3RbZDzI2+HwouSbzthJ+4RzRUPKxDWFlRFNVPsaC0QKZU713U
         4H4RNE7MbWk7f/lWA9MyP9UExVPxjF1kXu3aEoD3bYLusM7DVVmvYZTZqLhReEUlDF3f
         gnaV7ekIXBUXFn4Q+6GzzqZ/fkD74qsQkRL/61xqLA++6/g1x66p2lEPK1kq++TVip1F
         NAHheiBcjhUlAX1lbdlJ3ASOXr27zBfpi041QXKb4CF1rYV3b8WdY27XnGA+W4LO8AQ2
         PELULyVmPMbMCODsBNukt+PWdWWraB9arnkd6N7OaPjJFky0Ztf5DhCXoDeexr/cbUTp
         dDBA==
X-Forwarded-Encrypted: i=1; AJvYcCXT7fLieXcgyKm9BoScpLBPVtgBHLxLr3NGv6Waaq77J7yPYpsFHpUyFqP6+b7l90NfDWfFh2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHFLQ7UdaXQvw1RF2n/GGFhnjz2aEV5wden5y2RzvFjuxRKvyn
	wKH6pkTwQpx4yn1qIzwVgG7GpHnMlkFXiU0waf7b+XUWr8sB1xcm2pV0ciXnJA==
X-Gm-Gg: ASbGncuoj1YlbBpRC4zkd7niIBFU2yRD2j8nhVuZzShxzMDQ3EEec6IFcG16CCDGUvP
	7W3Me3Q8Ex9SFWRIMP80t3ZeyzSiBLZWsMWRvIaLrL+fRQ+MuegBket/Ae7YapvGtwVA3sR16Oc
	z9SSywob19Q0alO7hUTTpRREf83yHLJ01URxAhsogCnC0FtOxvZ79evVwb8XX13edvTIdNzjN9m
	FFYWCCifQ7ru2ppmvjFeZ57NgWVWM+SMAA+BkJhuiYeOJUHG+P8Elgg2YOJIbAtpTZ17xw/hVUW
	9nZQ76B7zj7Aflq5NAG2JC/Wh2l7mYws+c91bichiydvYFDtGGSvvJ2ERCpKAj1XRqAe0FYrh37
	lgDYxZTeM3ZgJPj+OBaH0ojhJt6dvEDvm9ew=
X-Google-Smtp-Source: AGHT+IFpuiiFmVMjocZ1fI0j1MUodJptENZgY17uK77vP78UE9/ca5hL6ArbUbHVzIv5T7omt9klgg==
X-Received: by 2002:a17:907:3f21:b0:ac3:8537:904e with SMTP id a640c23a62f3a-ac3f251f2b6mr326382966b.49.1742567911535;
        Fri, 21 Mar 2025 07:38:31 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d3d43sm165303566b.51.2025.03.21.07.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:38:31 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] usb: typec: class: Fix NULL pointer access
Date: Fri, 21 Mar 2025 14:37:26 +0000
Message-ID: <20250321143728.4092417-2-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250321143728.4092417-1-akuchynski@chromium.org>
References: <20250321143728.4092417-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Concurrent calls to typec_partner_unlink_device can lead to a NULL pointer
dereference. This patch adds a mutex to protect USB device pointers and
prevent this issue. The same mutex protects both the device pointers and
the partner device registration.

Cc: stable@vger.kernel.org
Fixes: 59de2a56d127 ("usb: typec: Link enumerated USB devices with Type-C partner")       
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/class.c | 15 +++++++++++++--
 drivers/usb/typec/class.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 9c76c3d0c6cf..eadb150223f8 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1052,6 +1052,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 		partner->usb_mode = USB_MODE_USB3;
 	}
 
+	mutex_lock(&port->partner_link_lock);
 	ret = device_register(&partner->dev);
 	if (ret) {
 		dev_err(&port->dev, "failed to register partner (%d)\n", ret);
@@ -1063,6 +1064,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 		typec_partner_link_device(partner, port->usb2_dev);
 	if (port->usb3_dev)
 		typec_partner_link_device(partner, port->usb3_dev);
+	mutex_unlock(&port->partner_link_lock);
 
 	return partner;
 }
@@ -1083,12 +1085,14 @@ void typec_unregister_partner(struct typec_partner *partner)
 
 	port = to_typec_port(partner->dev.parent);
 
+	mutex_lock(&port->partner_link_lock);
 	if (port->usb2_dev)
 		typec_partner_unlink_device(partner, port->usb2_dev);
 	if (port->usb3_dev)
 		typec_partner_unlink_device(partner, port->usb3_dev);
 
 	device_unregister(&partner->dev);
+	mutex_unlock(&port->partner_link_lock);
 }
 EXPORT_SYMBOL_GPL(typec_unregister_partner);
 
@@ -2041,10 +2045,11 @@ static struct typec_partner *typec_get_partner(struct typec_port *port)
 static void typec_partner_attach(struct typec_connector *con, struct device *dev)
 {
 	struct typec_port *port = container_of(con, struct typec_port, con);
-	struct typec_partner *partner = typec_get_partner(port);
+	struct typec_partner *partner;
 	struct usb_device *udev = to_usb_device(dev);
 	enum usb_mode usb_mode;
 
+	mutex_lock(&port->partner_link_lock);
 	if (udev->speed < USB_SPEED_SUPER) {
 		usb_mode = USB_MODE_USB2;
 		port->usb2_dev = dev;
@@ -2053,18 +2058,22 @@ static void typec_partner_attach(struct typec_connector *con, struct device *dev
 		port->usb3_dev = dev;
 	}
 
+	partner = typec_get_partner(port);
 	if (partner) {
 		typec_partner_set_usb_mode(partner, usb_mode);
 		typec_partner_link_device(partner, dev);
 		put_device(&partner->dev);
 	}
+	mutex_unlock(&port->partner_link_lock);
 }
 
 static void typec_partner_deattach(struct typec_connector *con, struct device *dev)
 {
 	struct typec_port *port = container_of(con, struct typec_port, con);
-	struct typec_partner *partner = typec_get_partner(port);
+	struct typec_partner *partner;
 
+	mutex_lock(&port->partner_link_lock);
+	partner = typec_get_partner(port);
 	if (partner) {
 		typec_partner_unlink_device(partner, dev);
 		put_device(&partner->dev);
@@ -2074,6 +2083,7 @@ static void typec_partner_deattach(struct typec_connector *con, struct device *d
 		port->usb2_dev = NULL;
 	else if (port->usb3_dev == dev)
 		port->usb3_dev = NULL;
+	mutex_unlock(&port->partner_link_lock);
 }
 
 /**
@@ -2614,6 +2624,7 @@ struct typec_port *typec_register_port(struct device *parent,
 
 	ida_init(&port->mode_ids);
 	mutex_init(&port->port_type_lock);
+	mutex_init(&port->partner_link_lock);
 
 	port->id = id;
 	port->ops = cap->ops;
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index b3076a24ad2e..db2fe96c48ff 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -59,6 +59,7 @@ struct typec_port {
 	enum typec_port_type		port_type;
 	enum usb_mode			usb_mode;
 	struct mutex			port_type_lock;
+	struct mutex			partner_link_lock;
 
 	enum typec_orientation		orientation;
 	struct typec_switch		*sw;
-- 
2.49.0.395.g12beb8f557-goog


