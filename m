Return-Path: <stable+bounces-71645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C92966230
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 15:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC362854D2
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E63E192D65;
	Fri, 30 Aug 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RyGgkr7s"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74F1165F05;
	Fri, 30 Aug 2024 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022944; cv=none; b=WppzWYMw8KE2AfWGK6Ej4DC61uPGPlREhKYXdf5M+dtQsIvaMzuGNbIj7WxoocbGafUc/VhBIez2wQ25Dm+r9eHZ1gWY110m0dOLSaW2V5r+TAO72csECSMpzl3cij/cSHypq8q3u6zqJUiu917CBdaCe5EoqJWK0H3pOiOJl6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022944; c=relaxed/simple;
	bh=YKVp3jB/X6CldVurN3XJqpg8lhB66UVuPDyc0LV3BXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKpk5h0c33hNaM21c+Xukg3i2SuHXDY/KJzyrxxdWzh+dQqrd+nZcUagvF4I3yqJdlPC+azwjxGpKaCm9vAguvOOXbcGjhrqe0bUgf5RfyVr4DxUVlktFAKf0Nq8EDXk1aAZORW392U+usLC4ShHlabXfJg4gouDgZF2zt7zdno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RyGgkr7s; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725022941; x=1756558941;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YKVp3jB/X6CldVurN3XJqpg8lhB66UVuPDyc0LV3BXk=;
  b=RyGgkr7so6D8V4FMkz/aZm0v5WbymvJcMDPxajKHyI6T/al0FszYR+ao
   wNJhMIpD/M4+cQ9zgwIHeMa54fjGA3Y+brOOFnaNw4iIzQ17fVOgLyXiK
   fMyJFmzltUSk+2f3e359znFqbQFZ1oksD3uE85WXVFWwe/w9Air5ofveo
   wBs1KSlV3lCSiFte3o1OR/tcPBEItgpNc1o7b6aQORxx7fOM2ln5KoP6v
   3xvTFQi+NX1cULzhLFSz8nWxsGaq7Tnq248pQE7J6P8jjPIa3A4h3PpmE
   vUrzS62XY5dyBv8m/GSSTNVNeiVcQm3rblGyI4Xvb1eftXrgguMhtjPJ6
   A==;
X-CSE-ConnectionGUID: PjycBiUDTN2Rk3CsIwMiPw==
X-CSE-MsgGUID: UCKrLmDyTCqiiIV+y7g6Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="26558841"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="26558841"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 06:02:21 -0700
X-CSE-ConnectionGUID: jStNW+s0Q0OTJdn1Qup4lA==
X-CSE-MsgGUID: 2+RVGbKoTu+ShsH8Dxl+uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="64397785"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 30 Aug 2024 06:02:19 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: Fix cable registration
Date: Fri, 30 Aug 2024 16:02:17 +0300
Message-ID: <20240830130217.2155774-1-heikki.krogerus@linux.intel.com>
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
 drivers/usb/typec/ucsi/ucsi.c | 30 +++++++++++++++---------------
 drivers/usb/typec/ucsi/ucsi.h |  1 -
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index fad43f292e7f..35dce4057c25 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -911,10 +911,20 @@ static void ucsi_unregister_plug(struct ucsi_connector *con)
 
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
@@ -931,10 +941,10 @@ static int ucsi_register_cable(struct ucsi_connector *con)
 
 	if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
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
@@ -1141,21 +1151,11 @@ static int ucsi_check_connection(struct ucsi_connector *con)
 
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
index 63cc7f982663..4a017eb6a65b 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -435,7 +435,6 @@ struct ucsi_connector {
 
 	struct ucsi_connector_status status;
 	struct ucsi_connector_capability cap;
-	struct ucsi_cable_property cable_prop;
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
 	u32 rdo;
-- 
2.45.2


