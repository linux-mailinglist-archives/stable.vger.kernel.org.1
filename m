Return-Path: <stable+bounces-123068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F99A5A2AB
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD8718953E0
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F6233729;
	Mon, 10 Mar 2025 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pgk+4DmR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31FB231A24;
	Mon, 10 Mar 2025 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630953; cv=none; b=cR+PDlkJ1CJoKlT4vOEWip05AK0xXwIF+lGc0iLI5T6xkuQiY3RmBwOj18JSdURIcyGDuLTsozWw4EDMQTZKqZp7enANFSWlw9ms2aOFgoV3gzv4LhuWCa8Ar2LcUQCdCvrFmQ+alKqLRPvM4Rsy/JeIpVnVdjhoNmsGzro0U7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630953; c=relaxed/simple;
	bh=w6O/0Z/+DjwKy2nDT62KLTFDZ1OVsFK5S2NRYC2nz1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDLZ7YHoTYgBRDAx/qcq63kKaiCZ0YlF+alrkIZ5Zhdg1RsPtz5mmKXsEEcWWqtJJyfecUsAwzW3BVXowBV/MhtL23w2fIW4VQy0PJzV24jPvJzUA2p0EInBG4lZtgnWJw8MF9BfjH5DqmckxKmL4maj7z8ySd59HkwaO+9UgSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pgk+4DmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4F0C4CEE5;
	Mon, 10 Mar 2025 18:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741630953;
	bh=w6O/0Z/+DjwKy2nDT62KLTFDZ1OVsFK5S2NRYC2nz1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pgk+4DmR8iZL8Ow4WLH9zHmUhebCml5GPTQV1HOQqz5WKEgQgqgmvR8bO3NJ3OPce
	 0PDmamlMe3tyibHSLk1c5xW36dTMQjkApROxrwvHlC2cljTas72jUphw5sOkqaCiHE
	 mYmEVCWtSAq4aIC+WKj1LDlIeGwLAJSJwWAxwM4g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Erik Schumacher <erik.schumacher@iris-sensing.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 560/620] hwmon: (ad7314) Validate leading zero bits and return error
Date: Mon, 10 Mar 2025 18:06:46 +0100
Message-ID: <20250310170607.646534301@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Schumacher <erik.schumacher@iris-sensing.com>

[ Upstream commit e278d5e8aef4c0a1d9a9fa8b8910d713a89aa800 ]

Leading zero bits are sent on the bus before the temperature value is
transmitted. If any of these bits are high, the connection might be
unstable or there could be no AD7314 / ADT730x (or compatible) at all.
Return -EIO in that case.

Signed-off-by: Erik Schumacher <erik.schumacher@iris-sensing.com>
Fixes: 4f3a659581cab ("hwmon: AD7314 driver (ported from IIO)")
Link: https://lore.kernel.org/r/24a50c2981a318580aca8f50d23be7987b69ea00.camel@iris-sensing.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/ad7314.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index 7802bbf5f9587..59424103f6348 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -22,11 +22,13 @@
  */
 #define AD7314_TEMP_MASK		0x7FE0
 #define AD7314_TEMP_SHIFT		5
+#define AD7314_LEADING_ZEROS_MASK	BIT(15)
 
 /*
  * ADT7301 and ADT7302 temperature masks
  */
 #define ADT7301_TEMP_MASK		0x3FFF
+#define ADT7301_LEADING_ZEROS_MASK	(BIT(15) | BIT(14))
 
 enum ad7314_variant {
 	adt7301,
@@ -65,12 +67,20 @@ static ssize_t ad7314_temperature_show(struct device *dev,
 		return ret;
 	switch (spi_get_device_id(chip->spi_dev)->driver_data) {
 	case ad7314:
+		if (ret & AD7314_LEADING_ZEROS_MASK) {
+			/* Invalid read-out, leading zero part is missing */
+			return -EIO;
+		}
 		data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_SHIFT;
 		data = sign_extend32(data, 9);
 
 		return sprintf(buf, "%d\n", 250 * data);
 	case adt7301:
 	case adt7302:
+		if (ret & ADT7301_LEADING_ZEROS_MASK) {
+			/* Invalid read-out, leading zero part is missing */
+			return -EIO;
+		}
 		/*
 		 * Documented as a 13 bit twos complement register
 		 * with a sign bit - which is a 14 bit 2's complement
-- 
2.39.5




