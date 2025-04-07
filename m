Return-Path: <stable+bounces-128601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E20A7E9C3
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFFA3B4654
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E97253F2C;
	Mon,  7 Apr 2025 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEb9w07F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D7A21B9E5;
	Mon,  7 Apr 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049476; cv=none; b=Y8j8+sEm+/Xu5ATG64jFcoRWImSCEsuekEfzIUJhUSqdu8YBeNGerRR1f1RLExSm0lr7PyqMrNkxJylSBdx7dQwbY4en1MzrZfT+UDyeCyaoL2DG9Z4iyC7RoSZ1KKvHXcLAYtXKcMXXbvPp2v8cu1h22RA3hJCpIuY+b7b7MkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049476; c=relaxed/simple;
	bh=IXmX+R1etJYleCxhJEyeEUBu6d/Gzl8XoxiZqTW4Luk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fjAZPIkitfaJMMl13ObVBxyYmR/W/t+EtuLcoEDj0xdHy3xaAhLrPQTA04u1QSEalMdFCJX48J8o+QFi/gtd+cuI5TClQpZWlR1zCASKnBzEPIdqp3z7SDe0EggLTbisnthpwXsnJv4MI5Es00S88wP3cNa59doc1BIjFKHdBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEb9w07F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E9EC4CEE9;
	Mon,  7 Apr 2025 18:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049475;
	bh=IXmX+R1etJYleCxhJEyeEUBu6d/Gzl8XoxiZqTW4Luk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BEb9w07FqAEMBnyiZ9zNTwyQP/A8vTaxwDyK0f4NL0ptD8obw7IXaxYi+MXZu26/N
	 pd4HFGtOZqY6cffkPsK5krd5nl3oXPvi9pcf+l57KJaQbwT83nuc7MfmA8YgJoi8pd
	 JfTDdC0sbAlASHwcJLjr3oIX8B44rNmiLSxjQZEQt3SqpmGDHNUYCZq8dvqgF7JDYC
	 +62C+oDt6TiQq8xRI/Lhx+NN9mIqQOwSdXNXsXNgsIjww4oGplmAl5QfHGB63N0iLv
	 FwfnveOPe6VhtTSCruG83wuiIrgI1FOHAONx0l5hTilcPNQmSFNhPfJmPSTjmYo6XQ
	 7ay1nhU9uAQpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	lumag@kernel.org,
	dan.carpenter@linaro.org,
	mario.limonciello@amd.com,
	viro@zeniv.linux.org.uk,
	lk@c--e.de,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 04/31] usb: typec: ucsi: ccg: move command quirks to ucsi_ccg_sync_control()
Date: Mon,  7 Apr 2025 14:10:20 -0400
Message-Id: <20250407181054.3177479-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 7f82635494ef3391ff6b542249793c7febf99c3f ]

It is easier to keep all command-specific quirks in a single place. Move
them to ucsi_ccg_sync_control() as the code now allows us to return
modified messages data.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250120-ucsi-merge-commands-v2-2-462a1ec22ecc@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 62 +++++++++++++++----------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 254c391618521..618d585905a02 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -222,7 +222,6 @@ struct ucsi_ccg {
 	u16 fw_build;
 	struct work_struct pm_work;
 
-	u64 last_cmd_sent;
 	bool has_multiple_dp;
 	struct ucsi_ccg_altmode orig[UCSI_MAX_ALTMODES];
 	struct ucsi_ccg_altmode updated[UCSI_MAX_ALTMODES];
@@ -538,9 +537,10 @@ static void ucsi_ccg_update_set_new_cam_cmd(struct ucsi_ccg *uc,
  * first and then vdo=0x3
  */
 static void ucsi_ccg_nvidia_altmode(struct ucsi_ccg *uc,
-				    struct ucsi_altmode *alt)
+				    struct ucsi_altmode *alt,
+				    u64 command)
 {
-	switch (UCSI_ALTMODE_OFFSET(uc->last_cmd_sent)) {
+	switch (UCSI_ALTMODE_OFFSET(command)) {
 	case NVIDIA_FTB_DP_OFFSET:
 		if (alt[0].mid == USB_TYPEC_NVIDIA_VLINK_DBG_VDO)
 			alt[0].mid = USB_TYPEC_NVIDIA_VLINK_DP_VDO |
@@ -578,37 +578,11 @@ static int ucsi_ccg_read_cci(struct ucsi *ucsi, u32 *cci)
 static int ucsi_ccg_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
 {
 	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
-	struct ucsi_capability *cap;
-	struct ucsi_altmode *alt;
 
 	spin_lock(&uc->op_lock);
 	memcpy(val, uc->op_data.message_in, val_len);
 	spin_unlock(&uc->op_lock);
 
-	switch (UCSI_COMMAND(uc->last_cmd_sent)) {
-	case UCSI_GET_CURRENT_CAM:
-		if (uc->has_multiple_dp)
-			ucsi_ccg_update_get_current_cam_cmd(uc, (u8 *)val);
-		break;
-	case UCSI_GET_ALTERNATE_MODES:
-		if (UCSI_ALTMODE_RECIPIENT(uc->last_cmd_sent) ==
-		    UCSI_RECIPIENT_SOP) {
-			alt = val;
-			if (alt[0].svid == USB_TYPEC_NVIDIA_VLINK_SID)
-				ucsi_ccg_nvidia_altmode(uc, alt);
-		}
-		break;
-	case UCSI_GET_CAPABILITY:
-		if (uc->fw_build == CCG_FW_BUILD_NVIDIA_TEGRA) {
-			cap = val;
-			cap->features &= ~UCSI_CAP_ALT_MODE_DETAILS;
-		}
-		break;
-	default:
-		break;
-	}
-	uc->last_cmd_sent = 0;
-
 	return 0;
 }
 
@@ -639,11 +613,9 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command, u32 *cci,
 	mutex_lock(&uc->lock);
 	pm_runtime_get_sync(uc->dev);
 
-	uc->last_cmd_sent = command;
-
-	if (UCSI_COMMAND(uc->last_cmd_sent) == UCSI_SET_NEW_CAM &&
+	if (UCSI_COMMAND(command) == UCSI_SET_NEW_CAM &&
 	    uc->has_multiple_dp) {
-		con_index = (uc->last_cmd_sent >> 16) &
+		con_index = (command >> 16) &
 			UCSI_CMD_CONNECTOR_MASK;
 		if (con_index == 0) {
 			ret = -EINVAL;
@@ -655,6 +627,30 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command, u32 *cci,
 
 	ret = ucsi_sync_control_common(ucsi, command, cci, data, size);
 
+	switch (UCSI_COMMAND(command)) {
+	case UCSI_GET_CURRENT_CAM:
+		if (uc->has_multiple_dp)
+			ucsi_ccg_update_get_current_cam_cmd(uc, (u8 *)data);
+		break;
+	case UCSI_GET_ALTERNATE_MODES:
+		if (UCSI_ALTMODE_RECIPIENT(command) == UCSI_RECIPIENT_SOP) {
+			struct ucsi_altmode *alt = data;
+
+			if (alt[0].svid == USB_TYPEC_NVIDIA_VLINK_SID)
+				ucsi_ccg_nvidia_altmode(uc, alt, command);
+		}
+		break;
+	case UCSI_GET_CAPABILITY:
+		if (uc->fw_build == CCG_FW_BUILD_NVIDIA_TEGRA) {
+			struct ucsi_capability *cap = data;
+
+			cap->features &= ~UCSI_CAP_ALT_MODE_DETAILS;
+		}
+		break;
+	default:
+		break;
+	}
+
 err_put:
 	pm_runtime_put_sync(uc->dev);
 	mutex_unlock(&uc->lock);
-- 
2.39.5


