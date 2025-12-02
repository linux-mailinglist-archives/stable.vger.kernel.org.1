Return-Path: <stable+bounces-198021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBE0C99A9C
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 01:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5F2A4E16C1
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 00:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB851519AC;
	Tue,  2 Dec 2025 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWcM9miR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4522097
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764636055; cv=none; b=F9W1KMnZmIiJILIGWgDSMbSUlPgIds4JrvcwL0gQq7FxcS6uj+Z941/aVLqDC1dEJm00wqSrROy6y7GPUvSOJWUGDeCD3oUVvRodrw5qSm8JRlQwpzqSJjTsJV22gW0PxPx8VnnuWvnMT7zzdDV8X82iW1rjhLg4jg09po9Ffvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764636055; c=relaxed/simple;
	bh=iRBiBVhAdRRhYWZ1f/7YjLLT4bdCpZyXrQkkz+EzjJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8lCY/JjRA+fbMLQBXWDKPx4f2Xxj93WKO6oQtqpH1tLooOuoxqGhN/1L7orJJgCXlfEB1rJqzEIAznn99O9gQ9zqK8WNOiBGNNtuBJeOuDNg5+EQOs6X6pAF2XUoFeYEyM/0ObYI8m9NQCCdRRRPS3Y7V3I8WbaNik9NOO/Yh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWcM9miR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F43C4CEF1;
	Tue,  2 Dec 2025 00:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764636055;
	bh=iRBiBVhAdRRhYWZ1f/7YjLLT4bdCpZyXrQkkz+EzjJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWcM9miRkbubkDsBNMLMWdmL+tqvko0uROiiWBvYYWfxiSoWipoh8dYG5Rn2CaE/y
	 SngJTM0FGoOf1hFCwPzBC2LiFab6y7w2+NDP5Ty86tCDNA9ZDJuX1vpTRWPnSZFJfV
	 oNnHJRjkLZ0cPSRfh6G97FyBJMpDJV5KoOAhkIeS/jKh523NrfN1bYaQY0qYPedHcN
	 W81oKRlTCuudfKODGlQjeTCjNLoZjO9AZPNhPiG/LoMCLnYTc7yKgfDVXnbqc/iS6/
	 6FyKnN8wZDlZu2qKCAPTYUdOHHbZiu2fRkl+9oem5tG4xRIhxrfpBY1P132KZiSLEP
	 T7Fniz5/wp8Mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	"Kenneth R. Crudup" <kenny@panix.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: typec: ucsi: psy: Set max current to zero when disconnected
Date: Mon,  1 Dec 2025 19:40:51 -0500
Message-ID: <20251202004051.1515831-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120116-sulfide-compacter-b9f2@gregkh>
References: <2025120116-sulfide-compacter-b9f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jameson Thies <jthies@google.com>

[ Upstream commit 23379a17334fc24c4a9cbd9967d33dcd9323cc7c ]

The ucsi_psy_get_current_max function defaults to 0.1A when it is not
clear how much current the partner device can support. But this does
not check the port is connected, and will report 0.1A max current when
nothing is connected. Update ucsi_psy_get_current_max to report 0A when
there is no connection.

Fixes: af833e7f7db3 ("usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default")
Cc: stable@vger.kernel.org
Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Kenneth R. Crudup <kenny@panix.com>
Rule: add
Link: https://lore.kernel.org/stable/20251017000051.2094101-1-jthies%40google.com
Link: https://patch.msgid.link/20251106011446.2052583-1-jthies@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adapted UCSI_CONSTAT() macro to direct flag access ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/psy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 9b0157063df0a..c80c23d3384e8 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -144,6 +144,11 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 {
 	u32 pdo;
 
+	if (!(con->status.flags & UCSI_CONSTAT_CONNECTED)) {
+		val->intval = 0;
+		return 0;
+	}
+
 	switch (UCSI_CONSTAT_PWR_OPMODE(con->status.flags)) {
 	case UCSI_CONSTAT_PWR_OPMODE_PD:
 		if (con->num_pdos > 0) {
-- 
2.51.0


