Return-Path: <stable+bounces-137008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DF4AA04A1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 09:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72513841959
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 07:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C1C277002;
	Tue, 29 Apr 2025 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HyhkPFvT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8455A275107
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745912091; cv=none; b=ORZQJ8sBMlvq8Qp8dpn28xxi69DQzvq2lbYJNlU+MM2dthhk/MAAwE1cc452JzlBgZIa1aN7KWJDJUYTolKTgS+jUAI/oAAz23sBBi4NK3bVMqjmd+b/T37Mb+H61peTWKQboVn25LKlcUAry/hn1dtmwkUW3rjk1xxQOvY4K6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745912091; c=relaxed/simple;
	bh=6W0SRe9v2bS7ZFdAu+YWvAMtwGDA9En+V3jqOMZeYk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyXVqp2GWfc6DWAc/igxx59K8Rt+APkSUcXnvvYN3n3Z+ZwxmnK/i+0iu8TX988zCny6vYaI6EFwMI9xfMLZJSyXP1Z83uspT/ty4ZzJzrRQYvsGpmtE6fRpbin8f9G/Ewk8MBb9XUa5o3eezSQ/I6l2ngfPUY3ZXP7tFehP5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HyhkPFvT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso8365296a12.0
        for <stable@vger.kernel.org>; Tue, 29 Apr 2025 00:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745912087; x=1746516887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl35yG8NKEmrrtu+erREdj/hdFt7Nnd6kBvL/vjl4Zw=;
        b=HyhkPFvTEXGhBcEtFIQVup8XZ2t5fbrjSfS1lq8/zsJ44Ckr9KIxnVHKDEsYLKQkXE
         eAy7Zm4O3i2h1gv2FwwEYmlbcicozDhLzrERU2zIg4Pi2Ubm2ejZ/EfALNzC3knBx2nc
         eWfiA4FUs25GcAbSi0fl/HMS25q7HaId4oib8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745912087; x=1746516887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kl35yG8NKEmrrtu+erREdj/hdFt7Nnd6kBvL/vjl4Zw=;
        b=giMy0sl/qinrdQh+wXMld/JiubYrLtnW7CGzxRkyg8DxKvgSIC8XjJWsig3Pp8iDFI
         hiGqTlx8Rer8tU1JNUBPZ3jgGQJbu/SAEg3PBi9lhfuxGPpr1xRedpvidM68VRYyZhof
         4IQV7YgmQ35Dclw1BOGV9AC6kJslJ9ueudVXzpBEfXMRoARHPM5F4tfXNxh6tyHrxd+i
         sV/UggZPM5QA5RWG0mIhxW/bRp0jKVYs8nWbPB7JjuoV2iXooD9n8RuWbh/WQvSIUMr8
         sscj8L6yK3AfWC+11cOJcbTNcFBQgu74yo1LxtJTOOPCcTRe491fCXRKR3Fmfe9PdIbX
         ADDA==
X-Gm-Message-State: AOJu0YzDm1CA/T68nFJJzKCAskusiZCkh3DyvhFoQtOkWrCaFc6/i2gl
	aXu7OxXQQLqR4Qxrl9nAZIRxGQo48tXjqLjnEMhG0cuWgQi4zWLyYP8Ebpn6+zxgyu+yq2vNkKg
	=
X-Gm-Gg: ASbGncv//mIhAnNbM2fkO8mMYr6of/ibSR/9PXFMJWSJ2M4FIZx5IMrycFIratA2DDb
	WyjCsdZlMikhfloJfOPQ9s0ZbMisW1mz5gDbEGzoL8rpO08qBJj91p4QWIIMgUmarapYNWUASyn
	COtbzLn4U9QInyPEOQWSrLVY6Bge5creXbjPZniOaah9WQfoEc1xwLB2eD+ylLYGN3BOI8q28yS
	pfvbkSFhkR0Qr+AAYi/LIK0f21DPptzMreZqowzY+I0aHn4wWJ3mUhfjbfAx/BKiy8OOd2g3EB6
	GCDhrkLKcz1TSa29iiiB+f2KtIFUxDVf/zb0UfdunsoAnDyRToFvRjMT3EvaNBH1Snkx3sMgLbW
	otvn5avKTzRmkIyNGjyjTexV6BpWFaak=
X-Google-Smtp-Source: AGHT+IGEvqUoMshjkPhs0wPUXrL8illtHs6vNQ12y2v0cwgShY4aZMkvwMeoBKSbrqLnloxAXYId4g==
X-Received: by 2002:a17:906:dc92:b0:ace:388e:d84a with SMTP id a640c23a62f3a-acec4eb4abfmr233096466b.47.1745912087169;
        Tue, 29 Apr 2025 00:34:47 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acecf906c33sm33116466b.59.2025.04.29.00.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 00:34:46 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: stable@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y] usb: typec: class: Fix NULL pointer access
Date: Tue, 29 Apr 2025 07:34:38 +0000
Message-ID: <20250429073438.1812645-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <2025042828-delivery-nearly-1a44@gregkh>
References: <2025042828-delivery-nearly-1a44@gregkh>
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
Change-Id: I27a35646da91d18c4671d406d7f7d9fbf80d533a
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250321143728.4092417-2-akuchynski@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit ec27386de23a511008c53aa2f3434ad180a3ca9a)
---
 drivers/usb/typec/class.c | 15 +++++++++++++--
 drivers/usb/typec/class.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 58f40156de56..bdccf77260e6 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -932,6 +932,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 	partner->dev.type = &typec_partner_dev_type;
 	dev_set_name(&partner->dev, "%s-partner", dev_name(&port->dev));
 
+	mutex_lock(&port->partner_link_lock);
 	ret = device_register(&partner->dev);
 	if (ret) {
 		dev_err(&port->dev, "failed to register partner (%d)\n", ret);
@@ -943,6 +944,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 		typec_partner_link_device(partner, port->usb2_dev);
 	if (port->usb3_dev)
 		typec_partner_link_device(partner, port->usb3_dev);
+	mutex_unlock(&port->partner_link_lock);
 
 	return partner;
 }
@@ -963,12 +965,14 @@ void typec_unregister_partner(struct typec_partner *partner)
 
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
 
@@ -1862,25 +1866,30 @@ static struct typec_partner *typec_get_partner(struct typec_port *port)
 static void typec_partner_attach(struct typec_connector *con, struct device *dev)
 {
 	struct typec_port *port = container_of(con, struct typec_port, con);
-	struct typec_partner *partner = typec_get_partner(port);
+	struct typec_partner *partner;
 	struct usb_device *udev = to_usb_device(dev);
 
+	mutex_lock(&port->partner_link_lock);
 	if (udev->speed < USB_SPEED_SUPER)
 		port->usb2_dev = dev;
 	else
 		port->usb3_dev = dev;
 
+	partner = typec_get_partner(port);
 	if (partner) {
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
@@ -1890,6 +1899,7 @@ static void typec_partner_deattach(struct typec_connector *con, struct device *d
 		port->usb2_dev = NULL;
 	else if (port->usb3_dev == dev)
 		port->usb3_dev = NULL;
+	mutex_unlock(&port->partner_link_lock);
 }
 
 /**
@@ -2425,6 +2435,7 @@ struct typec_port *typec_register_port(struct device *parent,
 
 	ida_init(&port->mode_ids);
 	mutex_init(&port->port_type_lock);
+	mutex_init(&port->partner_link_lock);
 
 	port->id = id;
 	port->ops = cap->ops;
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index 7485cdb9dd20..300312a1c152 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -56,6 +56,7 @@ struct typec_port {
 	enum typec_pwr_opmode		pwr_opmode;
 	enum typec_port_type		port_type;
 	struct mutex			port_type_lock;
+	struct mutex			partner_link_lock;
 
 	enum typec_orientation		orientation;
 	struct typec_switch		*sw;
-- 
2.49.0.906.g1f30a19c02-goog


