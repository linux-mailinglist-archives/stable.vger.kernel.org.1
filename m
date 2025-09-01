Return-Path: <stable+bounces-176878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C7AB3E837
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 17:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5F07A3BAE
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 15:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826BB343D77;
	Mon,  1 Sep 2025 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GMo7N4uI"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCED341ACE
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739103; cv=none; b=dfr76SLoFZqv16xpTAQ2XZjs2RZZohKjtDvYkOOU67eoGFRxit4GR8OZJ0zJnLfRdka/SBj3PN7roC9jPIPcqCJfjd8yTH0eMYon3h3av4rUM3rB+KKxyi3IzMVh8/zURq1z3M8wy442cg+Qh/YRpBxf6uLjIyDirqIX82ZyQxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739103; c=relaxed/simple;
	bh=NzJKaNqFey2ehopdK0ID3IioXGnhql27vSag7QFDFso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbbxo2jcp5ocljZdmk9mYYbZ5U3SsuY8hZrcssfGoj4jPEu17WU6iOnfHIjv01iYrr80bHZKrtKaSRcYK18A+QxVz3w00SAq8p3PB6hFtKY56U1WnhjWw/nu4pkfPwI1aHpL8vjfcAebiyZvfl93dVDWIE9KG0DTvmbFdOHpSkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GMo7N4uI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756739102; x=1788275102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NzJKaNqFey2ehopdK0ID3IioXGnhql27vSag7QFDFso=;
  b=GMo7N4uI3sCmQE0PyVW+Jh+tq5M/UM5pwjnJEYY9HUwqLiKMMNdRdSNN
   ZHBd2BEL9uJi05VN1MhibojZmL06+WDnhF30A1/xSTBd5+pfVgr+A7yxU
   9BGBvR3c44FOX8TXWgPewOB9tvdpQZU9hJ8tUNITA5JKcybCq19aAYwdV
   TYOHauQejvHYO3Ea130b+FOJK6c2w+MODgfYcEY1ty4rNMKRpWnwo9K1X
   Ws5+xU9Ak1TPfL/yn5CTwh9Z1a2i1Rq6AZmkq/Au7iT6s1tqUsGen1ZRM
   ETc/88M/8OMgID0HQn7lJZPcl+31IKC5x3gVcScxvCmYTIOVIkFKPIi9K
   w==;
X-CSE-ConnectionGUID: hRJ1odblTViAzW9QhPAUiw==
X-CSE-MsgGUID: p/U0svi7SAi9I4wn3mOfQw==
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="277284642"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 08:05:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 1 Sep 2025 08:04:31 -0700
Received: from ROU-LT-M70749.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 1 Sep 2025 08:04:30 -0700
From: Romain Sioen <romain.sioen@microchip.com>
To: <stable@vger.kernel.org>
CC: <hamish.martin@alliedtelesis.co.nz>, <jikos@kernel.org>, Romain Sioen
	<romain.sioen@microchip.com>
Subject: [PATCH 2/2] HID: mcp2221: Handle reads greater than 60 bytes
Date: Mon, 1 Sep 2025 17:03:31 +0200
Message-ID: <20250901150331.198437-3-romain.sioen@microchip.com>
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

[ Upstream commit 2682468671aa0b4d52ae09779b48212a80d71b91 ]

When a user requests more than 60 bytes of data the MCP2221 must chunk
the data in chunks up to 60 bytes long (see command/response code 0x40
in the datasheet).
In order to signal that the device has more data the (undocumented) byte
at byte index 2 of the Get I2C Data response uses the value 0x54. This
contrasts with the case for the final data chunk where the value
returned is 0x55 (MCP2221_I2C_READ_COMPL). The fact that 0x55 was not
returned in the response was interpreted by the driver as a failure
meaning that all reads of more than 60 bytes would fail.

Add support for reads that are split over multiple chunks by looking for
the response code indicating that more data is expected and continuing
the read as the code intended. Some timing delays are required to ensure
the chip has time to refill its FIFO as data is read in from the I2C
bus. This timing has been tested in my system when configured for bus
speeds of 50KHz, 100KHz, and 400KHz and operates well.

Fixes: 67a95c21463d0 ("HID: mcp2221: add usb to i2c-smbus host bridge")
Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
[romain.sioen@microchip.com: backport to stable, up to 6.8. Add "Fixes" tag]
Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
---
 drivers/hid/hid-mcp2221.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index ce4e8e6b3d86..a985301a4135 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -49,6 +49,7 @@ enum {
 	MCP2221_I2C_MASK_ADDR_NACK = 0x40,
 	MCP2221_I2C_WRADDRL_SEND = 0x21,
 	MCP2221_I2C_ADDR_NACK = 0x25,
+	MCP2221_I2C_READ_PARTIAL = 0x54,
 	MCP2221_I2C_READ_COMPL = 0x55,
 	MCP2221_ALT_F_NOT_GPIOV = 0xEE,
 	MCP2221_ALT_F_NOT_GPIOD = 0xEF,
@@ -297,6 +298,7 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 {
 	int ret;
 	u16 total_len;
+	int retries = 0;
 
 	mcp->txbuf[0] = type;
 	if (msg) {
@@ -320,20 +322,31 @@ static int mcp_i2c_smbus_read(struct mcp2221 *mcp,
 	mcp->rxbuf_idx = 0;
 
 	do {
+		/* Wait for the data to be read by the device */
+		usleep_range(980, 1000);
+
 		memset(mcp->txbuf, 0, 4);
 		mcp->txbuf[0] = MCP2221_I2C_GET_DATA;
 
 		ret = mcp_send_data_req_status(mcp, mcp->txbuf, 1);
-		if (ret)
-			return ret;
-
-		ret = mcp_chk_last_cmd_status_free_bus(mcp);
-		if (ret)
-			return ret;
-
-		usleep_range(980, 1000);
+		if (ret) {
+			if (retries < 5) {
+				/* The data wasn't ready to read.
+				 * Wait a bit longer and try again.
+				 */
+				usleep_range(90, 100);
+				retries++;
+			} else {
+				return ret;
+			}
+		} else {
+			retries = 0;
+		}
 	} while (mcp->rxbuf_idx < total_len);
 
+	usleep_range(980, 1000);
+	ret = mcp_chk_last_cmd_status_free_bus(mcp);
+
 	return ret;
 }
 
@@ -799,7 +812,8 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 				mcp->status = -EIO;
 				break;
 			}
-			if (data[2] == MCP2221_I2C_READ_COMPL) {
+			if (data[2] == MCP2221_I2C_READ_COMPL ||
+			    data[2] == MCP2221_I2C_READ_PARTIAL) {
 				buf = mcp->rxbuf;
 				memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
 				mcp->rxbuf_idx = mcp->rxbuf_idx + data[3];
-- 
2.48.1


