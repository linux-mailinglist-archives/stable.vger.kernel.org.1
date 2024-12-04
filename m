Return-Path: <stable+bounces-98613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6659E492A
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DABF16B220
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5FD2101B2;
	Wed,  4 Dec 2024 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfZkROQQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0152101AC;
	Wed,  4 Dec 2024 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354875; cv=none; b=TguGAzAfZuSCOW3WpTxrh3llbfhGiaVl3e/j2zzuIMwiPnuDtJ5kAg7JsNrSWEFNaLbfUYgEQldEFtgxVdOdXocEhLSbklAXJDTSZPFDxCkSMSyUCMIdcRUR2uoWEMkiHbR/Fs4R254sWUwvztFsJrBi4XA40DHwCiRNZO/uc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354875; c=relaxed/simple;
	bh=iwmQgpFpv3ojbLRaQam3mb39EDcfTKLT2dz4T1Vlnvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzhX6nF7t7SusxMf2rv4AppNxYtDDtTJh3OvHJpPZGZmAbDLBkck9m1hsxxSJfwcE3pCJJeDJz4Oq9K3y1yqbhxhJeoEan+SRpR5xfW2q1o4827t8dQ3hoYciiF4I04OCwMD71OS9BS/rsw2ZP757LixNk6T65KQB2K5qubgzJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfZkROQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D40C4CEDD;
	Wed,  4 Dec 2024 23:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354875;
	bh=iwmQgpFpv3ojbLRaQam3mb39EDcfTKLT2dz4T1Vlnvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YfZkROQQPYtohofSQowPhNbw8zNb650f1ZmGK4xZwGo3EVWj6a5J81W8wELqAgHXR
	 Kqs9FniMjnbicJnShNzvF4zl8adPbiYDsnczdcoQUtXZTTeLB4gxri0woRjhOnGNz1
	 vfzJKq+mfBtOEHGItgtVDCPSH5w3jYr8U4q84UZ8GkrOGKR9Qcg2f/fSDIf2QdpB/x
	 Y13LbOGp865woW9PbHAOHXNFA3IPNJNItq0gTYUxnhhKtjNcL/icVZVV6GTRItwYTK
	 UgJJJ2G/8cTUUsmXQX7+AuQp/HW1pr1HoqAyW7yisBiRS7UXsyZbW2iiUp7XgvjXl9
	 eVCcNoNFr3xPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saranya Gopal <saranya.gopal@intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Christian A . Ehrhardt" <lk@c--e.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	dmitry.baryshkov@linaro.org,
	u.kleine-koenig@baylibre.com,
	diogo.ivo@tecnico.ulisboa.pt,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 05/15] usb: typec: ucsi: Do not call ACPI _DSM method for UCSI read operations
Date: Wed,  4 Dec 2024 17:15:59 -0500
Message-ID: <20241204221627.2247598-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221627.2247598-1-sashal@kernel.org>
References: <20241204221627.2247598-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Saranya Gopal <saranya.gopal@intel.com>

[ Upstream commit fa48d7e81624efdf398b990a9049e9cd75a5aead ]

ACPI _DSM methods are needed only for UCSI write operations and for reading
CCI during RESET_PPM operation. So, remove _DSM calls from other places.
While there, remove the Zenbook quirk also since the default behavior
now aligns with the Zenbook quirk. With this change, GET_CONNECTOR_STATUS
returns at least 6 seconds faster than before in Arrowlake-S platforms.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>
Reviewed-by: Christian A. Ehrhardt <lk@c--e.de>
Link: https://lore.kernel.org/r/20240830084342.460109-1-saranya.gopal@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 56 +++---------------------------
 1 file changed, 5 insertions(+), 51 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 7a5dff8d9cc6c..accf15ff1306a 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -61,9 +61,11 @@ static int ucsi_acpi_read_cci(struct ucsi *ucsi, u32 *cci)
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 	int ret;
 
-	ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
-	if (ret)
-		return ret;
+	if (UCSI_COMMAND(ua->cmd) == UCSI_PPM_RESET) {
+		ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
+		if (ret)
+			return ret;
+	}
 
 	memcpy(cci, ua->base + UCSI_CCI, sizeof(*cci));
 
@@ -73,11 +75,6 @@ static int ucsi_acpi_read_cci(struct ucsi *ucsi, u32 *cci)
 static int ucsi_acpi_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	int ret;
-
-	ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
-	if (ret)
-		return ret;
 
 	memcpy(val, ua->base + UCSI_MESSAGE_IN, val_len);
 
@@ -102,42 +99,6 @@ static const struct ucsi_operations ucsi_acpi_ops = {
 	.async_control = ucsi_acpi_async_control
 };
 
-static int
-ucsi_zenbook_read_cci(struct ucsi *ucsi, u32 *cci)
-{
-	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	int ret;
-
-	if (UCSI_COMMAND(ua->cmd) == UCSI_PPM_RESET) {
-		ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
-		if (ret)
-			return ret;
-	}
-
-	memcpy(cci, ua->base + UCSI_CCI, sizeof(*cci));
-
-	return 0;
-}
-
-static int
-ucsi_zenbook_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
-{
-	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-
-	/* UCSI_MESSAGE_IN is never read for PPM_RESET, return stored data */
-	memcpy(val, ua->base + UCSI_MESSAGE_IN, val_len);
-
-	return 0;
-}
-
-static const struct ucsi_operations ucsi_zenbook_ops = {
-	.read_version = ucsi_acpi_read_version,
-	.read_cci = ucsi_zenbook_read_cci,
-	.read_message_in = ucsi_zenbook_read_message_in,
-	.sync_control = ucsi_sync_control_common,
-	.async_control = ucsi_acpi_async_control
-};
-
 static int ucsi_gram_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
 {
 	u16 bogus_change = UCSI_CONSTAT_POWER_LEVEL_CHANGE |
@@ -190,13 +151,6 @@ static const struct ucsi_operations ucsi_gram_ops = {
 };
 
 static const struct dmi_system_id ucsi_acpi_quirks[] = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
-		},
-		.driver_data = (void *)&ucsi_zenbook_ops,
-	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
-- 
2.43.0


