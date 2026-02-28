Return-Path: <stable+bounces-220449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILkNKLc2o2lg+gQAu9opvQ
	(envelope-from <stable+bounces-220449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:40:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA861C61DE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12BB0314BA21
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B113B7FCD;
	Sat, 28 Feb 2026 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkFqVH88"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD9E3B7FC3;
	Sat, 28 Feb 2026 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300337; cv=none; b=kxYE8ouO7IAu5/3C5kCxvMuxYZvWpd+MnzboVg51RePiHaxc3fGHBJhVesR8JlYKph++7XBz2VR/6XlJMnHNcY4dorisJayxfpOXqUhGADhdx2uXWBYT3pAHzE8B6lzvTO+6uJYna2v+wF4qzdmxoBfWOi3Lu9h2pm5Rmu07+MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300337; c=relaxed/simple;
	bh=2P9R8lmUl+1m/5BkjvZoI2Z8hkc/ln2kqBMgtnzsO1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PP8ir0Us3eVwPlvktNAegrE8f8NAjeHQ1F9gvcOvMiFeEelL47yn1v111VDvt8QORp9QYBhunx6wviqSHjNmuzxU9apQhGh58MJTXYx2LLJBc3viaE4VU5uqCnfDPDujCFAulBj1bVjexr+H4/rVxMBwNoTvSir1CevBY0WTtsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkFqVH88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA958C19423;
	Sat, 28 Feb 2026 17:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300337;
	bh=2P9R8lmUl+1m/5BkjvZoI2Z8hkc/ln2kqBMgtnzsO1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkFqVH88eoEFnyTMQHQ335YG2R2ZhErlDcY9H4XsCLqYLCsGqHanMxESiqCzvQ4fR
	 Vk6lCmAW3/sbpilorxFJrdkNvKiwjqhRaXNe+Ixc13nH0+ut7zVq8q42kPAkxS+KFi
	 3Lb3VtoFknhKWgru2k9Ds0LROtg8/pk27LgGieCX1jC/iU1S+V7uUolO5Z7z8OKBBf
	 AL0ymSJvC8c7xvIdRfVZ3NQpMMutAZpvwfS6bHV7lL7HMEVnJJ1/XHwJLO1zaERfeD
	 AA4PHGl4367zITtrqWi+Ep25ezNEuhdRY4UZdpemYOVMWeo9IkUdWHMMlEtjqfw35u
	 v919ths6yhAkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 370/844] usb: typec: ucsi: psy: Fix voltage and current max for non-Fixed PDOs
Date: Sat, 28 Feb 2026 12:24:43 -0500
Message-ID: <20260228173244.1509663-371-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220449-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2DA861C61DE
X-Rspamd-Action: no action

From: Benson Leung <bleung@chromium.org>

[ Upstream commit 6811e0a08bdce6b2767414caf17fda24c2e4e032 ]

ucsi_psy_get_voltage_max and ucsi_psy_get_current_max are calculated
using whichever pdo is in the last position of the src_pdos array, presuming
it to be a fixed pdo, so the pdo_fixed_voltage or pdo_max_current
helpers are used on that last pdo.

However, non-Fixed PDOs such as Battery PDOs, Augmented PDOs (used for AVS and
for PPS) may exist, and are always at the end of the array if they do.
In the event one of these more advanced chargers are attached the helpers for
fixed return mangled values.

Here's an example case of a Google Pixel Flex Dual Port 67W USB-C Fast Charger
with PPS support:
POWER_SUPPLY_NAME=ucsi-source-psy-cros_ec_ucsi.4.auto2
POWER_SUPPLY_TYPE=USB
POWER_SUPPLY_CHARGE_TYPE=Standard
POWER_SUPPLY_USB_TYPE=C [PD] PD_PPS PD_DRP
POWER_SUPPLY_ONLINE=1
POWER_SUPPLY_VOLTAGE_MIN=5000000
POWER_SUPPLY_VOLTAGE_MAX=13400000
POWER_SUPPLY_VOLTAGE_NOW=20000000
POWER_SUPPLY_CURRENT_MAX=5790000
POWER_SUPPLY_CURRENT_NOW=3250000

Voltage Max is reading as 13.4V, but that's an incorrect decode of the PPS
APDO in the last position. Same goes for CURRENT_MAX. 5.79A is incorrect.

Instead, enumerate through the src_pdos and filter just for Fixed PDOs for
now, and find the one with the highest voltage and current respectively.

After, from the same charger:
POWER_SUPPLY_NAME=ucsi-source-psy-cros_ec_ucsi.4.auto2
POWER_SUPPLY_TYPE=USB
POWER_SUPPLY_CHARGE_TYPE=Standard
POWER_SUPPLY_USB_TYPE=C [PD] PD_PPS PD_DRP
POWER_SUPPLY_ONLINE=1
POWER_SUPPLY_VOLTAGE_MIN=5000000
POWER_SUPPLY_VOLTAGE_MAX=20000000
POWER_SUPPLY_VOLTAGE_NOW=20000000
POWER_SUPPLY_CURRENT_MAX=4000000
POWER_SUPPLY_CURRENT_NOW=3250000

Signed-off-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20251208174918.289394-3-bleung@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/psy.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 3abe9370ffaaf..62160c4191718 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -112,15 +112,20 @@ static int ucsi_psy_get_voltage_max(struct ucsi_connector *con,
 				    union power_supply_propval *val)
 {
 	u32 pdo;
+	int max_voltage = 0;
 
 	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
 	case UCSI_CONSTAT_PWR_OPMODE_PD:
-		if (con->num_pdos > 0) {
-			pdo = con->src_pdos[con->num_pdos - 1];
-			val->intval = pdo_fixed_voltage(pdo) * 1000;
-		} else {
-			val->intval = 0;
+		for (int i = 0; i < con->num_pdos; i++) {
+			int pdo_voltage = 0;
+
+			pdo = con->src_pdos[i];
+			if (pdo_type(pdo) == PDO_TYPE_FIXED)
+				pdo_voltage = pdo_fixed_voltage(pdo) * 1000;
+			max_voltage = (pdo_voltage > max_voltage) ? pdo_voltage
+								  : max_voltage;
 		}
+		val->intval = max_voltage;
 		break;
 	case UCSI_CONSTAT_PWR_OPMODE_TYPEC3_0:
 	case UCSI_CONSTAT_PWR_OPMODE_TYPEC1_5:
@@ -168,6 +173,7 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 				    union power_supply_propval *val)
 {
 	u32 pdo;
+	int max_current = 0;
 
 	if (!UCSI_CONSTAT(con, CONNECTED)) {
 		val->intval = 0;
@@ -176,12 +182,16 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 
 	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
 	case UCSI_CONSTAT_PWR_OPMODE_PD:
-		if (con->num_pdos > 0) {
-			pdo = con->src_pdos[con->num_pdos - 1];
-			val->intval = pdo_max_current(pdo) * 1000;
-		} else {
-			val->intval = 0;
+		for (int i = 0; i < con->num_pdos; i++) {
+			int pdo_current = 0;
+
+			pdo = con->src_pdos[i];
+			if (pdo_type(pdo) == PDO_TYPE_FIXED)
+				pdo_current = pdo_max_current(pdo) * 1000;
+			max_current = (pdo_current > max_current) ? pdo_current
+								  : max_current;
 		}
+		val->intval = max_current;
 		break;
 	case UCSI_CONSTAT_PWR_OPMODE_TYPEC1_5:
 		val->intval = UCSI_TYPEC_1_5_CURRENT * 1000;
-- 
2.51.0


