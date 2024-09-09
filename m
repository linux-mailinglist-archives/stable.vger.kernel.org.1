Return-Path: <stable+bounces-73968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39785970EAF
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 08:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA139282740
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2591AC8B0;
	Mon,  9 Sep 2024 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VM8HK6dX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B81F95E
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865032; cv=none; b=AH3qUPIIifmDUsEXUatSAsuZWDRTTacP7M17YcUkKi0O59psLLB183IAHlbMwh8uBLuSVod8OE4FnPK28Lo+ayf42k8rXPXDA5dFk8P52+oZOPN/roCXC+TqzuGMUGJTfDvkc/UZvGOU5FIF1mzmfMyvoJg8rTr7McrkOJHHpjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865032; c=relaxed/simple;
	bh=MPUA1bO06Eyo1PizSOKPSE4xolMiXvVVTSFT+CPGtHA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jWBwTmQBJ/6O8DAh1nYcBUkHxVrQqpQuoPhJ8QJ6UrZI6pdoHw8mYeuCMvTEJH2psD5TGa7zEtwMe81lAV9lRonqts2vaBQ7gstG1dl1cNV6tVyoYePUU4AkJXy0jjJSxEOsHo7AD2G6yieecRzR73UenrdtSw9+f6eU3nt2wMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VM8HK6dX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A33C4CEC5;
	Mon,  9 Sep 2024 06:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725865032;
	bh=MPUA1bO06Eyo1PizSOKPSE4xolMiXvVVTSFT+CPGtHA=;
	h=Subject:To:Cc:From:Date:From;
	b=VM8HK6dXw8Zz+aCcdhyIlReGvR5Hu24MH3s1fP3f7YxU4PnWCr0nnYtfXfVTETYTK
	 tfkEMSqXMTGL6zrCrC+OZgYo9nCoEp6YODdzCRifibZhjn4P2CsiUxVmzxgSWpeF16
	 umqsFvrepc5icdBhMeSzlbSTOxi6851iR+N3Nv5w=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Fix cable registration" failed to apply to 6.10-stable tree
To: heikki.krogerus@linux.intel.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Sep 2024 08:57:09 +0200
Message-ID: <2024090909-goes-yogurt-80fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 87eb3cb4ec619299cd5572e1d5eb68aef4074ac2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090909-goes-yogurt-80fa@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

87eb3cb4ec61 ("usb: typec: ucsi: Fix cable registration")
c313a44ac9cd ("usb: typec: ucsi: Always set number of alternate modes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 87eb3cb4ec619299cd5572e1d5eb68aef4074ac2 Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Tue, 3 Sep 2024 16:09:44 +0300
Subject: [PATCH] usb: typec: ucsi: Fix cable registration

The Cable PD Revision field in GET_CABLE_PROPERTY was
introduced in UCSI v2.1, so adding check for that.

The cable properties are also not used anywhere after the
cable is registered, so removing the cable_prop member
from struct ucsi_connector while at it.

Fixes: 38ca416597b0 ("usb: typec: ucsi: Register cables based on GET_CABLE_PROPERTY")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240903130945.3395291-1-heikki.krogerus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 9a799637754c..17155ed17fdf 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -965,10 +965,20 @@ static void ucsi_unregister_plug(struct ucsi_connector *con)
 
 static int ucsi_register_cable(struct ucsi_connector *con)
 {
+	struct ucsi_cable_property cable_prop;
 	struct typec_cable *cable;
 	struct typec_cable_desc desc = {};
+	u64 command;
+	int ret;
 
-	switch (UCSI_CABLE_PROP_FLAG_PLUG_TYPE(con->cable_prop.flags)) {
+	command = UCSI_GET_CABLE_PROPERTY | UCSI_CONNECTOR_NUMBER(con->num);
+	ret = ucsi_send_command(con->ucsi, command, &cable_prop, sizeof(cable_prop));
+	if (ret < 0) {
+		dev_err(con->ucsi->dev, "GET_CABLE_PROPERTY failed (%d)\n", ret);
+		return ret;
+	}
+
+	switch (UCSI_CABLE_PROP_FLAG_PLUG_TYPE(cable_prop.flags)) {
 	case UCSI_CABLE_PROPERTY_PLUG_TYPE_A:
 		desc.type = USB_PLUG_TYPE_A;
 		break;
@@ -984,10 +994,10 @@ static int ucsi_register_cable(struct ucsi_connector *con)
 	}
 
 	desc.identity = &con->cable_identity;
-	desc.active = !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE &
-			 con->cable_prop.flags);
-	desc.pd_revision = UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(
-	    con->cable_prop.flags);
+	desc.active = !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE & cable_prop.flags);
+
+	if (con->ucsi->version >= UCSI_VERSION_2_1)
+		desc.pd_revision = UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(cable_prop.flags);
 
 	cable = typec_register_cable(con->port, &desc);
 	if (IS_ERR(cable)) {
@@ -1193,21 +1203,11 @@ static int ucsi_check_connection(struct ucsi_connector *con)
 
 static int ucsi_check_cable(struct ucsi_connector *con)
 {
-	u64 command;
 	int ret, num_plug_am;
 
 	if (con->cable)
 		return 0;
 
-	command = UCSI_GET_CABLE_PROPERTY | UCSI_CONNECTOR_NUMBER(con->num);
-	ret = ucsi_send_command(con->ucsi, command, &con->cable_prop,
-				sizeof(con->cable_prop));
-	if (ret < 0) {
-		dev_err(con->ucsi->dev, "GET_CABLE_PROPERTY failed (%d)\n",
-			ret);
-		return ret;
-	}
-
 	ret = ucsi_register_cable(con);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 57129f3c0814..5a3481d36d7a 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -465,7 +465,6 @@ struct ucsi_connector {
 
 	struct ucsi_connector_status status;
 	struct ucsi_connector_capability cap;
-	struct ucsi_cable_property cable_prop;
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
 	u32 rdo;


