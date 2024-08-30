Return-Path: <stable+bounces-71635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8244A966066
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010D51F29DE4
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 11:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACEF17DFF3;
	Fri, 30 Aug 2024 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glZFuTAh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C3D17ADF8;
	Fri, 30 Aug 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016610; cv=none; b=j6lzUsyZSwIg2gF9sUNhRZxZ1PuRxA3w8CV4IXryUZvWtPkT0Wk+dQ4Eu8zHpws7lqdQIWO5hmBp20uvxsf6tsaVLUKDId3UdOhzP8F87HQDlF66tCv6SaP+zhihhKi4oLVbt+03pddfu2SGr+1mA+CeompzGtzuZuydVWbBZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016610; c=relaxed/simple;
	bh=AvmihkIx7oKurA5QPSf2V5FnxKKOMPmtGhEcjarscpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eu5ZqJpvjqwTgDs77cdlcy0krL3S6d8QSNFwdop0pp/+tui6mPHWPJS7LI/2EXW1iAC8ZUNSXbXL7l8+piLkRVwH24fyrIQXkf3ayusA5pr3QWHwFbvBC2IQXhYOnbPvbQn9Zd0IFJYekY3HqNpfHoBmYzVvSKfgkGiEkeruk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glZFuTAh; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725016609; x=1756552609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AvmihkIx7oKurA5QPSf2V5FnxKKOMPmtGhEcjarscpo=;
  b=glZFuTAhdd/04yYkQBdZPboA2aRhSa8j3JaXdv71xUnqrFqN/pABN2yy
   a1SD/Wy+bAVMDH5muMqayN4sg6lFizV+gKbvEI+OcNA0Ws19FEd0Z5es+
   cKbvrZbl9nY+mUPI7+URt+ySvt4Ue5KUeIcPtBDkA+2DO3IwnvR18sxSN
   g5ZSr/iSWBCDAMYueYiI2E0uhNBArJBmvntZwkoaRZqkJmDPUT2hVmlKZ
   +fUT6ml4Wfq/IhNIL3toRg/3YhhsywDcmJArZBGJomfrn6SboZSGEerFR
   OivOzMayLQthoW6ee8Y5oAkmg8G4lfwqdPTfXqez66t4yxXIxTM/Y2iDC
   Q==;
X-CSE-ConnectionGUID: zLX7tznRQH2X1HPuEQi8vA==
X-CSE-MsgGUID: RHccfPQaScq9VkpivEJNYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="41153279"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="41153279"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 04:16:49 -0700
X-CSE-ConnectionGUID: kH3jSM+1QKSKkkiqSabCow==
X-CSE-MsgGUID: BD+byvfsQB2xpV/LbQl99g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="64220204"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 30 Aug 2024 04:16:46 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: Fix the partner PD revision
Date: Fri, 30 Aug 2024 14:16:45 +0300
Message-ID: <20240830111645.2134301-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Partner PD Revision field in GET_CONNECTOR_CAPABILITY
data structure was introduced in UCSI v2.1. In
ucsi_check_connector_capability() the version was assumed to
be 2.0, and in ucsi_register_partner() the field is accessed
completely unconditionally.

Fixing the version in ucsi_check_connector_capability(), and
replacing the unconditional pd_revision assignment with a
direct call to ucsi_check_connector_capability() in
ucsi_register_port(). After this the revision is also
checked only if there is a PD contract.

Fixes: b9fccfdb4ebb ("usb: typec: ucsi: Get PD revision for partner")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 50 ++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index f0b5867048e2..fad43f292e7f 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -959,6 +959,27 @@ static void ucsi_unregister_cable(struct ucsi_connector *con)
 	con->cable = NULL;
 }
 
+static int ucsi_check_connector_capability(struct ucsi_connector *con)
+{
+	u64 command;
+	int ret;
+
+	if (!con->partner || con->ucsi->version < UCSI_VERSION_2_1)
+		return 0;
+
+	command = UCSI_GET_CONNECTOR_CAPABILITY | UCSI_CONNECTOR_NUMBER(con->num);
+	ret = ucsi_send_command(con->ucsi, command, &con->cap, sizeof(con->cap));
+	if (ret < 0) {
+		dev_err(con->ucsi->dev, "GET_CONNECTOR_CAPABILITY failed (%d)\n", ret);
+		return ret;
+	}
+
+	typec_partner_set_pd_revision(con->partner,
+		UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags));
+
+	return ret;
+}
+
 static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 {
 	switch (UCSI_CONSTAT_PWR_OPMODE(con->status.flags)) {
@@ -968,6 +989,7 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 		ucsi_partner_task(con, ucsi_get_src_pdos, 30, 0);
 		ucsi_partner_task(con, ucsi_check_altmodes, 30, HZ);
 		ucsi_partner_task(con, ucsi_register_partner_pdos, 1, HZ);
+		ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
 		break;
 	case UCSI_CONSTAT_PWR_OPMODE_TYPEC1_5:
 		con->rdo = 0;
@@ -1012,7 +1034,6 @@ static int ucsi_register_partner(struct ucsi_connector *con)
 	if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
 		desc.identity = &con->partner_identity;
 	desc.usb_pd = pwr_opmode == UCSI_CONSTAT_PWR_OPMODE_PD;
-	desc.pd_revision = UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags);
 
 	partner = typec_register_partner(con->port, &desc);
 	if (IS_ERR(partner)) {
@@ -1089,27 +1110,6 @@ static void ucsi_partner_change(struct ucsi_connector *con)
 			con->num, u_role);
 }
 
-static int ucsi_check_connector_capability(struct ucsi_connector *con)
-{
-	u64 command;
-	int ret;
-
-	if (!con->partner || con->ucsi->version < UCSI_VERSION_2_0)
-		return 0;
-
-	command = UCSI_GET_CONNECTOR_CAPABILITY | UCSI_CONNECTOR_NUMBER(con->num);
-	ret = ucsi_send_command(con->ucsi, command, &con->cap, sizeof(con->cap));
-	if (ret < 0) {
-		dev_err(con->ucsi->dev, "GET_CONNECTOR_CAPABILITY failed (%d)\n", ret);
-		return ret;
-	}
-
-	typec_partner_set_pd_revision(con->partner,
-		UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(con->cap.flags));
-
-	return ret;
-}
-
 static int ucsi_check_connection(struct ucsi_connector *con)
 {
 	u8 prev_flags = con->status.flags;
@@ -1231,15 +1231,16 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 		if (con->status.flags & UCSI_CONSTAT_CONNECTED) {
 			ucsi_register_partner(con);
 			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
-			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
 			if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
 				ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
 			if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
 				ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
 
 			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
-			    UCSI_CONSTAT_PWR_OPMODE_PD)
+			    UCSI_CONSTAT_PWR_OPMODE_PD) {
 				ucsi_partner_task(con, ucsi_register_partner_pdos, 1, HZ);
+				ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
+			}
 		} else {
 			ucsi_unregister_partner(con);
 		}
@@ -1668,6 +1669,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 		ucsi_register_device_pdos(con);
 		ucsi_get_src_pdos(con);
 		ucsi_check_altmodes(con);
+		ucsi_check_connector_capability(con);
 	}
 
 	trace_ucsi_register_port(con->num, &con->status);
-- 
2.45.2


