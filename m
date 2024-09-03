Return-Path: <stable+bounces-72839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25C6969EBD
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 15:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF851F24D11
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 13:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBF71A7241;
	Tue,  3 Sep 2024 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koi3WWFJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61491CA6B7;
	Tue,  3 Sep 2024 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368991; cv=none; b=ssdYQxiMvIk9C6suYrpCjblfM2zK6CeqKv6p68af8kxeyGsNFJxanaUkMBmXaxveztO4sPxt1j7BJ26vygHXaC+7mCpcat2NyMxbOWdcTI+qc/bQ5wHWyOXyhA0d02Izta1cE7D4l6GvD5TjNoxRLOkIzuWC6/gGygn6YmgMZ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368991; c=relaxed/simple;
	bh=8mw08bfGNoVPR6V3tmRj81krcv15qI2aaad6jNL/UlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZtXayvTvt+WSSY0iVSeLpkZqe3DWJPiUeXYPOCNz91UYh2YHxnnG5oQ3q2WejuHF6t9weuEk96dMMBq0s9sDiUlsO36hPrxjIwbjf7yEp4pDdeuexfoXrJpM3BxwA2hIfEjaqEuSnljPbpemFk1BajUmf+SQoqhEfa+6RHCARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=koi3WWFJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725368989; x=1756904989;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8mw08bfGNoVPR6V3tmRj81krcv15qI2aaad6jNL/UlM=;
  b=koi3WWFJqBxxvVXeN0hVKaAmKnG96IBjTv9JB0ib/Xy1F+8bMLPAyBuf
   C25P7htYLkSmabu08X+mo+4Z4HleqKejm1nAQrrRuxZnGO9fwa/jpVaI1
   +G4XcrHCTGEuYbbFAqA76y2KRkEhwc62aOg6tVcZ2Z0CD88sAnq0IOZf1
   rOMrhq/R3xksuDzBT6/7QMbndiWuGskrJfYWwXCkKsvRBdnGC++Tcb2nC
   CKSuI+Nu76//VE3ZwiWHVwB1+92wgmNxQ4yjSGup2sc/g/j5jI0rb5kn3
   ksLIc76vX7lug6fPqtYAg1ente+CKpYXU2lGmp0THhvUEftDWCbJt5HeV
   g==;
X-CSE-ConnectionGUID: XPV2Y4+kSyyjVjtsTeYw3A==
X-CSE-MsgGUID: mly3dnSjS0qnQy0vxZXfCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="27845620"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="27845620"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 06:09:48 -0700
X-CSE-ConnectionGUID: 8aB2M8G7SV+BIySESXT8XQ==
X-CSE-MsgGUID: emqfdTatSmi/rn4cL1xskA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="102322883"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 03 Sep 2024 06:09:46 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: typec: ucsi: Fix cable registration
Date: Tue,  3 Sep 2024 16:09:44 +0300
Message-ID: <20240903130945.3395291-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Cable PD Revision field in GET_CABLE_PROPERTY was
introduced in UCSI v2.1, so adding check for that.

The cable properties are also not used anywhere after the
cable is registered, so removing the cable_prop member
from struct ucsi_connector while at it.

Fixes: 38ca416597b0 ("usb: typec: ucsi: Register cables based on GET_CABLE_PROPERTY")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Hi Greg,

This version is for your usb-linus branch. The original [1] should
apply on top of your usb-next branch.

thanks,

[1] https://lore.kernel.org/linux-usb/20240830130217.2155774-1-heikki.krogerus@linux.intel.com/

---
 drivers/usb/typec/ucsi/ucsi.c | 30 +++++++++++++++---------------
 drivers/usb/typec/ucsi/ucsi.h |  1 -
 2 files changed, 15 insertions(+), 16 deletions(-)

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
+
+	command = UCSI_GET_CABLE_PROPERTY | UCSI_CONNECTOR_NUMBER(con->num);
+	ret = ucsi_send_command(con->ucsi, command, &cable_prop, sizeof(cable_prop));
+	if (ret < 0) {
+		dev_err(con->ucsi->dev, "GET_CABLE_PROPERTY failed (%d)\n", ret);
+		return ret;
+	}
 
-	switch (UCSI_CABLE_PROP_FLAG_PLUG_TYPE(con->cable_prop.flags)) {
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
-- 
2.45.2


