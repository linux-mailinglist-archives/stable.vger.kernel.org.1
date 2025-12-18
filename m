Return-Path: <stable+bounces-202936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84648CCAB3B
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 08:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B75E302D5F5
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 07:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5FF2C0F7A;
	Thu, 18 Dec 2025 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J2nj5iGd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5987422FF22
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043484; cv=none; b=byA5bxIfUdEaN7SWbysL9rd1+C2VMK+Dxks0vyODqdgpYcTkK3MYymMQmiXRkMRs6OR08gixjg65DXrCLdMMViOBT5gMxw5v5Oy7wcSvrS6qOgjssEGA2/OaEeEZUHzwrZ6u1zWulw6GYHfjrTrwgTDqtc2OhjrjxZY56gpKjPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043484; c=relaxed/simple;
	bh=BHfPKR3CiAkdgTBUhQ0QCk3mqCn+3n9u+VlCPU72xr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gShyaMta3Ho2eICjwBVLWZY1nPHYfIt6QvENCLdDoTSSKyAmOrWwwf9r+tLW5yhNIbunuI6oDlPpwHlJm6Cj3Krztgru12pMOCG/yP/McXyVReRNE53VzvVKxiwD1sr8LrOBLWBeQRx1QJrjBvAMcIZXZu5bYHFHLgpRfPCJMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J2nj5iGd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0d5c365ceso3896095ad.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 23:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766043482; x=1766648282; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J64RN7C8q1D2IvQ0DJE4mDN5k31hTVkVCCfa1UP6tlo=;
        b=J2nj5iGd6CCRSwsf7FTQ6HnMcQuFbLamT1HYP8qxsaY6IBhDD+R+Plw6mI4PEBw46s
         BVcvrHk0Xpejog8jjjbACF0wGkFw1Ha9x60k3cXzpS/7atubQYW4vej9vKKvNJyR5W4Q
         CQYRYDAaGxJk52ufX3Wtmp9RvNWkv2e+0HCSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766043482; x=1766648282;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J64RN7C8q1D2IvQ0DJE4mDN5k31hTVkVCCfa1UP6tlo=;
        b=RWDNK/9m6COh5Na/gzQdYM9vT9x5sgYSwds0rs5SQdYHhLSRPmcErwenb4D935UC2f
         hSqSx9ecEoVuDY9ihDG+zS5UsOI6dLroBvtDcH+BIxqvxLxQDC2eF2qdKl9GRQP+ICqx
         OGVxtWILYGxzVf6CoRvvh/ClI/4XICXuaaj12wBD3EnnooA7ueLRDPHcrnNdp28CmE03
         c5FOpqOuK+NH3ANsuaumyNTBoE/AdtVFrri3Vo7qiHaOIysXD/EtJTROrC+c0iZmVboc
         E1QMUH3OWzVGjqA1+AM8gaCyo5/KvYh84h/mZ4omt6kNCP9BDN7G+SXa1AqWDkDgo+B0
         gq4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWr3gJ5UwkQ7yHkc/djbtlZjeNfKr0KD1FpXZiwIDCTlxQb5K33jhsaOG5YCr/jBhRYri7Gpv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYwCKnulW/pNo5MfFG8VHkF4XZsE1gYK4FEnC2GDjXHbogxVsc
	kvydvGJ3GwHPJAuPnW25r/A8lDy+BJDdV8EJ5ik1c/0CrxZgPpUjuLb6fTjrf9Q73A==
X-Gm-Gg: AY/fxX7Bk/JkNcH8gZAP8OjzRGxEQ2cp8fMPYP3Y23Y3BFVNxgBWiuBcUCa/224ipvG
	13lMtBHG/YQrUAkVr30VsFFlq157lpqX4W70PqoQv3alDiJxF3tZ6XRnHeARlL1kmrvUQ3JLz9o
	gttmZaeW9lEUlLi0bK0U43bao+6x3mgbWrSVrbubf+YeEai1sztoQylsIzM9ix2g2xvaI0f3aQG
	hNiRj/tKEote55HC2IZJRsjBx4LbRKki4xvJm0xgnMXtjqJ3bwkMSG7f6jDuqE5pa5CAK5DYFfI
	Tc0NNAiMlWRCA5HGpdUkXdc8e8CKEv4mUiL/YzZcw+ZmHBzFYzE+KtyrGLvLEmP0EG/fkPYyJbn
	f8oAlAJJkC0ZgaosccgOCfP+l+/Q2DwXl+/hWIAvtrd7jILT8vKiPuM2OqhSKntXDK6R4mXFpKI
	5J1h5DkxKHF0FFcv+GfmnI2Ed80oW86NBYQIZQooHFlcV7ZhPcYPxRlGC+I5uG2iMshtkK86XpI
	Rs8Y0LJm2uEYxAQZCcw921g
X-Google-Smtp-Source: AGHT+IF7Vo84hBarzcNuwS+HrIGFB6JJOaHQdMvt5OZfRsuzKPyb+5LGeKykTEnqCL/dTe4lwn3nsA==
X-Received: by 2002:a17:902:f551:b0:2a0:afeb:fbb2 with SMTP id d9443c01a7336-2a0afec01acmr124106815ad.60.1766043481497;
        Wed, 17 Dec 2025 23:38:01 -0800 (PST)
Received: from yuanhsinte-p620-1.tpe.corp.google.com ([2a00:79e0:201d:8:c3f8:2ced:4d1e:5de4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1926ab0sm15227475ad.75.2025.12.17.23.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:38:01 -0800 (PST)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Thu, 18 Dec 2025 15:37:57 +0800
Subject: [PATCH v7] usb: typec: ucsi: Get connector status after enable
 notifications
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ucsi-v7-1-aea83e83fb12@chromium.org>
X-B4-Tracking: v=1; b=H4sIAFSvQ2kC/23PTWrDMBAF4KsEreuiGf26q96jdCGNJrEWiYPUm
 ITgu1cJLjXBaPXEfG+Yu6hcMlfxsbuLwlOueTy14N52goZwOnCXU8sCJRoAcN2Fau4I0549SWm
 TE230XHifr8+ar++Wh1x/xnJ7tk7w+H0pmKBrL1Ekw8FqjJ80lPGYL8f3sRzEo2PCtfOLw+aSA
 p2MVEoxbji1cgiLU81FkNpRUA6i33B67czidHOeem2sTykEs+HMv0P550xz2nuOvo/Ub+6zW84
 2xxgSWGMk6tf75nn+BfZhfdOzAQAA
X-Change-ID: 20251117-ucsi-c2dfe8c006d7
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Kenneth R. Crudup" <kenny@panix.com>, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.14.2

Originally, the notification for connector change will be enabled after
the first read of the connector status. Therefore, if the event happens
during this window, it will be missing and make the status unsynced.

Get the connector status only after enabling the notification for
connector change to ensure the status is synced.

Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
Cc: stable@vger.kernel.org # v4.13+
Tested-by: Kenneth R. Crudup <kenny@panix.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v7:
- Rebase onto 6.19-rc1
- Link to v6: https://lore.kernel.org/r/20251205-ucsi-v6-1-e2ad16550242@chromium.org

Changes in v6:
- Free the locks in error path.
- Link to v5: https://lore.kernel.org/r/20251205-ucsi-v5-1-488eb89bc9b8@chromium.org

Changes in v5:
- Hold the lock of each connector during the initialization to avoid
  race condition between initialization and other event handler
- Add Fixes tag
- Link to v4: https://lore.kernel.org/r/20251125-ucsi-v4-1-8c94568ddaa5@chromium.org

Changes in v4:
- Handle a single connector in ucsi_init_port() and call it in a loop
- Link to v3: https://lore.kernel.org/r/20251121-ucsi-v3-1-b1047ca371b8@chromium.org

Changes in v3:
- Seperate the status checking part into a new function called
  ucsi_init_port() and call it after enabling the notifications
- Link to v2: https://lore.kernel.org/r/20251118-ucsi-v2-1-d314d50333e2@chromium.org

Changes in v2:
- Remove unnecessary braces.
- Link to v1: https://lore.kernel.org/r/20251117-ucsi-v1-1-1dcbc5ea642b@chromium.org
---
 drivers/usb/typec/ucsi/ucsi.c | 133 +++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 59 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 9b3df776137a17e569588d41ee437a778342146e..f933c873f9e0d5f85275ebd96d34f90803230565 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1624,11 +1624,71 @@ static struct fwnode_handle *ucsi_find_fwnode(struct ucsi_connector *con)
 	return NULL;
 }
 
+static void ucsi_init_port(struct ucsi *ucsi, struct ucsi_connector *con)
+{
+	enum usb_role u_role = USB_ROLE_NONE;
+	int ret;
+
+	/* Get the status */
+	ret = ucsi_get_connector_status(con, false);
+	if (ret) {
+		dev_err(ucsi->dev, "con%d: failed to get status\n", con->num);
+		return;
+	}
+
+	if (ucsi->ops->connector_status)
+		ucsi->ops->connector_status(con);
+
+	switch (UCSI_CONSTAT(con, PARTNER_TYPE)) {
+	case UCSI_CONSTAT_PARTNER_TYPE_UFP:
+	case UCSI_CONSTAT_PARTNER_TYPE_CABLE_AND_UFP:
+		u_role = USB_ROLE_HOST;
+		fallthrough;
+	case UCSI_CONSTAT_PARTNER_TYPE_CABLE:
+		typec_set_data_role(con->port, TYPEC_HOST);
+		break;
+	case UCSI_CONSTAT_PARTNER_TYPE_DFP:
+		u_role = USB_ROLE_DEVICE;
+		typec_set_data_role(con->port, TYPEC_DEVICE);
+		break;
+	default:
+		break;
+	}
+
+	/* Check if there is already something connected */
+	if (UCSI_CONSTAT(con, CONNECTED)) {
+		typec_set_pwr_role(con->port, UCSI_CONSTAT(con, PWR_DIR));
+		ucsi_register_partner(con);
+		ucsi_pwr_opmode_change(con);
+		ucsi_orientation(con);
+		ucsi_port_psy_changed(con);
+		if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
+			ucsi_get_partner_identity(con);
+		if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
+			ucsi_check_cable(con);
+	}
+
+	/* Only notify USB controller if partner supports USB data */
+	if (!(UCSI_CONSTAT(con, PARTNER_FLAG_USB)))
+		u_role = USB_ROLE_NONE;
+
+	ret = usb_role_switch_set_role(con->usb_role_sw, u_role);
+	if (ret)
+		dev_err(ucsi->dev, "con:%d: failed to set usb role:%d\n",
+			con->num, u_role);
+
+	if (con->partner && UCSI_CONSTAT(con, PWR_OPMODE) == UCSI_CONSTAT_PWR_OPMODE_PD) {
+		ucsi_register_device_pdos(con);
+		ucsi_get_src_pdos(con);
+		ucsi_check_altmodes(con);
+		ucsi_check_connector_capability(con);
+	}
+}
+
 static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 {
 	struct typec_capability *cap = &con->typec_cap;
 	enum typec_accessory *accessory = cap->accessory;
-	enum usb_role u_role = USB_ROLE_NONE;
 	u64 command;
 	char *name;
 	int ret;
@@ -1729,63 +1789,6 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 		goto out;
 	}
 
-	/* Get the status */
-	ret = ucsi_get_connector_status(con, false);
-	if (ret) {
-		dev_err(ucsi->dev, "con%d: failed to get status\n", con->num);
-		goto out;
-	}
-
-	if (ucsi->ops->connector_status)
-		ucsi->ops->connector_status(con);
-
-	switch (UCSI_CONSTAT(con, PARTNER_TYPE)) {
-	case UCSI_CONSTAT_PARTNER_TYPE_UFP:
-	case UCSI_CONSTAT_PARTNER_TYPE_CABLE_AND_UFP:
-		u_role = USB_ROLE_HOST;
-		fallthrough;
-	case UCSI_CONSTAT_PARTNER_TYPE_CABLE:
-		typec_set_data_role(con->port, TYPEC_HOST);
-		break;
-	case UCSI_CONSTAT_PARTNER_TYPE_DFP:
-		u_role = USB_ROLE_DEVICE;
-		typec_set_data_role(con->port, TYPEC_DEVICE);
-		break;
-	default:
-		break;
-	}
-
-	/* Check if there is already something connected */
-	if (UCSI_CONSTAT(con, CONNECTED)) {
-		typec_set_pwr_role(con->port, UCSI_CONSTAT(con, PWR_DIR));
-		ucsi_register_partner(con);
-		ucsi_pwr_opmode_change(con);
-		ucsi_orientation(con);
-		ucsi_port_psy_changed(con);
-		if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
-			ucsi_get_partner_identity(con);
-		if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
-			ucsi_check_cable(con);
-	}
-
-	/* Only notify USB controller if partner supports USB data */
-	if (!(UCSI_CONSTAT(con, PARTNER_FLAG_USB)))
-		u_role = USB_ROLE_NONE;
-
-	ret = usb_role_switch_set_role(con->usb_role_sw, u_role);
-	if (ret) {
-		dev_err(ucsi->dev, "con:%d: failed to set usb role:%d\n",
-			con->num, u_role);
-		ret = 0;
-	}
-
-	if (con->partner && UCSI_CONSTAT(con, PWR_OPMODE) == UCSI_CONSTAT_PWR_OPMODE_PD) {
-		ucsi_register_device_pdos(con);
-		ucsi_get_src_pdos(con);
-		ucsi_check_altmodes(con);
-		ucsi_check_connector_capability(con);
-	}
-
 	trace_ucsi_register_port(con->num, con);
 
 out:
@@ -1903,17 +1906,29 @@ static int ucsi_init(struct ucsi *ucsi)
 			goto err_unregister;
 	}
 
+	/* Delay other interactions with each connector until ucsi_init_port is done */
+	for (i = 0; i < ucsi->cap.num_connectors; i++)
+		mutex_lock(&connector[i].lock);
+
 	/* Enable all supported notifications */
 	ntfy = ucsi_get_supported_notifications(ucsi);
 	command = UCSI_SET_NOTIFICATION_ENABLE | ntfy;
 	ucsi->message_in_size = 0;
 	ret = ucsi_send_command(ucsi, command);
-	if (ret < 0)
+	if (ret < 0) {
+		for (i = 0; i < ucsi->cap.num_connectors; i++)
+			mutex_unlock(&connector[i].lock);
 		goto err_unregister;
+	}
 
 	ucsi->connector = connector;
 	ucsi->ntfy = ntfy;
 
+	for (i = 0; i < ucsi->cap.num_connectors; i++) {
+		ucsi_init_port(ucsi, &connector[i]);
+		mutex_unlock(&connector[i].lock);
+	}
+
 	mutex_lock(&ucsi->ppm_lock);
 	ret = ucsi->ops->read_cci(ucsi, &cci);
 	mutex_unlock(&ucsi->ppm_lock);

---
base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
change-id: 20251117-ucsi-c2dfe8c006d7

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


