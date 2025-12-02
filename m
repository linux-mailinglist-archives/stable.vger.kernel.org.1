Return-Path: <stable+bounces-198024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D7CC99ACF
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 01:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AB154E159B
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 00:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A83B1339B1;
	Tue,  2 Dec 2025 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR7LB4P3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925D86329
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764636595; cv=none; b=crRDcbY4p+CZMz5OOjjvz0XZ7RfLhh2MFsGU/e4st/BP8rUeEbnwWtj5KgNMAkQgdDBA9NAGaGoNXWk2Vo33E1Tc8whpctNs93zLJs4oEzD7aRmYXp1c+u+ubjSasLrCDlXJCD/QF9YmSnBRWxrp51jxwHbXd9cDNyhcVV7S/Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764636595; c=relaxed/simple;
	bh=iRBiBVhAdRRhYWZ1f/7YjLLT4bdCpZyXrQkkz+EzjJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZwPpc9Wn+YQgx8BBMv2dC96HKhODeMkIK7HCFL9LfoaW1M+4lVyQHJDU/MU+auIiKvmSoZSLfEvfOmB92sWNJdSN599SSSAswc/32i+dhiVZvhnfpsR7G0leusbAnprpciOze8hObi8HBF+xkyUgJ7Y4elWMKNBllxQrt3NoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jR7LB4P3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D8FC4CEF1;
	Tue,  2 Dec 2025 00:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764636595;
	bh=iRBiBVhAdRRhYWZ1f/7YjLLT4bdCpZyXrQkkz+EzjJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jR7LB4P3If7bGffqoHRvtIVdV7ac/A5ZZ2TsFAMhAhaz/W3I9XGcWrF3AHWpYoqHo
	 3y6Lzo7N7neoPzbPpuViYLOkBq03kuBXih8o21QxcD6K6N5BnQfKAM3vSjCB/H74ZP
	 hHY0DlLy+al7C8+KjKjG9ej+OTYmxUna3dKYdCAOBANI+tu0p6OxKJPA1K6VXXOkRX
	 q2oypZi9iM1rP8fVv7uAj1ixsghiwPZI0BVoErIGr9u5sNwHNJoAuBUI5G8H9qu/Uh
	 NzCe/kCR0pavaT5GiydPv5qfZYoYDV1PPmBufnv41ieTOetecHRFHApXawckk4JXA9
	 hvyLE8HCoPIrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	"Kenneth R. Crudup" <kenny@panix.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: typec: ucsi: psy: Set max current to zero when disconnected
Date: Mon,  1 Dec 2025 19:49:46 -0500
Message-ID: <20251202004946.1530030-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120116-bullwhip-geometry-eaa5@gregkh>
References: <2025120116-bullwhip-geometry-eaa5@gregkh>
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


