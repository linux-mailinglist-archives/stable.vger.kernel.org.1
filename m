Return-Path: <stable+bounces-176877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52081B3E83F
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 17:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1876B203AAC
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 15:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DBA34321E;
	Mon,  1 Sep 2025 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y4LsOPEl"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D500341665
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739102; cv=none; b=glUpnpoRJ9wjrhEZgdbp2azdDbKnW6nOY9HkeVLeri9uPaoHHRx2w9Udtv9+o37HW15CNL/HMg3tDlKBdamzSmyUQRsQ450v/zmok9hxjarLCIVueHI7C3D4ogAh0oMTztqZHxucZ586wrHX/YprpdhISFOCkwcjn+4ME2ehGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739102; c=relaxed/simple;
	bh=F5YTMjAxGFn9vJP5s3i39HadH3tToaPKIgtEx2txZ+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUN4CyIwbc6lJ8dXJGptPfmkkKY6hYRoxVdNKUqgLfpI5L27AvWrF+lAJluTYC8fA2gaeDek/h9qpg1aCw7swuR7al6CKPZvTacwwMcnW2Kz6x8e06uKCJpnewjqwJHYVQobEe/+fsTo5/OBvoEUrrL0eoSn21LW+HfcRImksoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y4LsOPEl; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756739101; x=1788275101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F5YTMjAxGFn9vJP5s3i39HadH3tToaPKIgtEx2txZ+E=;
  b=y4LsOPElGXbUp0BFRAPURggfqEZ7yAUfmfVqhe1wYXEvL2EDoC1mPo7/
   ktjrhneNlWHO4L3fTSCubEgNtfPcZiOXlMspxrmRST6zm/YVycanV8uuf
   J7Q2boCbzeFvs2mV8Tqk2IzVFdLJPXXs9bzzsmV0pwYBzNbiIv08MxHhO
   DeQAkom6740zdxMxi6GbrGwK2xYG3xnLNwQzZ4hF6jtNrIh0t2MABZH3k
   vKT0cUpfBCbkFqGYv45+aWgQYp+78plVp3eXxu22MxlQGqI/qq4lQxeCV
   BqoEtIFbNZNqtrxFLHCa4aadA5n6+ZslTX14IjqBY8ncZCzM3hDQJ6V0N
   A==;
X-CSE-ConnectionGUID: hRJ1odblTViAzW9QhPAUiw==
X-CSE-MsgGUID: WwBXSEHETTCO1Qq5NfxweA==
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="277284641"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 08:04:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 1 Sep 2025 08:04:29 -0700
Received: from ROU-LT-M70749.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 1 Sep 2025 08:04:28 -0700
From: Romain Sioen <romain.sioen@microchip.com>
To: <stable@vger.kernel.org>
CC: <hamish.martin@alliedtelesis.co.nz>, <jikos@kernel.org>, Romain Sioen
	<romain.sioen@microchip.com>
Subject: [PATCH 1/2] HID: mcp2221: Don't set bus speed on every transfer
Date: Mon, 1 Sep 2025 17:03:30 +0200
Message-ID: <20250901150331.198437-2-romain.sioen@microchip.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250901150331.198437-1-romain.sioen@microchip.com>
References: <20250901150331.198437-1-romain.sioen@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>

[ Upstream commit 02a46753601a24e1673d9c28173121055e8e6cc9 ]

Since the initial commit of this driver the I2C bus speed has been
reconfigured for every single transfer. This is despite the fact that we
never change the speed and it is never "lost" by the chip.
Upon investigation we find that what was really happening was that the
setting of the bus speed had the side effect of cancelling a previous
failed command if there was one, thereby freeing the bus. This is the
part that was actually required to keep the bus operational in the face
of failed commands.

Instead of always setting the speed, we now correctly cancel any failed
commands as they are detected. This means we can just set the bus speed
at probe time and remove the previous speed sets on each transfer.
This has the effect of improving performance and reducing the number of
commands required to complete transfers.

Fixes: 67a95c21463d ("HID: mcp2221: add usb to i2c-smbus host bridge")
Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
[romain.sioen@microchip.com: backport to stable, up to 6.8. Add "Fixes" tag]
Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
---
 drivers/hid/hid-mcp2221.c | 41 ++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index c5bfca8ac5e6..ce4e8e6b3d86 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -187,6 +187,25 @@ static int mcp_cancel_last_cmd(struct mcp2221 *mcp)
 	return mcp_send_data_req_status(mcp, mcp->txbuf, 8);
 }
 
+/* Check if the last command succeeded or failed and return the result.
+ * If the command did fail, cancel that command which will free the i2c bus.
+ */
+static int mcp_chk_last_cmd_status_free_bus(struct mcp2221 *mcp)
+{
+	int ret;
+
+	ret = mcp_chk_last_cmd_status(mcp);
+	if (ret) {
+		/* The last command was a failure.
+		 * Send a cancel which will also free the bus.
+		 */
+		usleep_range(980, 1000);
+		mcp_cancel_last_cmd(mcp);
+	}
+
+	return ret;
+}
+
 static int mcp_set_i2c_speed(struct mcp2221 *mcp)
 {
 	int ret;
@@ -241,7 +260,7 @@ static int mcp_i2c_write(struct mcp2221 *mcp,
 		usleep_range(980, 1000);
 
 		if (last_status) {
-			ret = mcp_chk_last_cmd_status(mcp);
+			ret = mcp_chk_last_cmd_status_free_bus(mcp);
 			if (ret)
 				return ret;
 		}
@@ -308,7 +327,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 		if (ret)
 			return ret;
 
-		ret = mcp_chk_last_cmd_status(mcp);
+		ret = mcp_chk_last_cmd_status_free_bus(mcp);
 		if (ret)
 			return ret;
 
@@ -328,11 +347,6 @@ static int mcp_i2c_xfer(struct i2c_adapter *adapter,
 
 	mutex_lock(&mcp->lock);
 
-	/* Setting speed before every transaction is required for mcp2221 */
-	ret = mcp_set_i2c_speed(mcp);
-	if (ret)
-		goto exit;
-
 	if (num == 1) {
 		if (msgs->flags & I2C_M_RD) {
 			ret = mcp_i2c_smbus_read(mcp, msgs, MCP2221_I2C_RD_DATA,
@@ -417,9 +431,7 @@ static int mcp_smbus_write(struct mcp2221 *mcp, u16 addr,
 	if (last_status) {
 		usleep_range(980, 1000);
 
-		ret = mcp_chk_last_cmd_status(mcp);
-		if (ret)
-			return ret;
+		ret = mcp_chk_last_cmd_status_free_bus(mcp);
 	}
 
 	return ret;
@@ -437,10 +449,6 @@ static int mcp_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 
 	mutex_lock(&mcp->lock);
 
-	ret = mcp_set_i2c_speed(mcp);
-	if (ret)
-		goto exit;
-
 	switch (size) {
 
 	case I2C_SMBUS_QUICK:
@@ -1152,6 +1160,11 @@ static int mcp2221_probe(struct hid_device *hdev,
 	if (i2c_clk_freq < 50)
 		i2c_clk_freq = 50;
 	mcp->cur_i2c_clk_div = (12000000 / (i2c_clk_freq * 1000)) - 3;
+	ret = mcp_set_i2c_speed(mcp);
+	if (ret) {
+		hid_err(hdev, "can't set i2c speed: %d\n", ret);
+		return ret;
+	}
 
 	mcp->adapter.owner = THIS_MODULE;
 	mcp->adapter.class = I2C_CLASS_HWMON;
-- 
2.48.1


