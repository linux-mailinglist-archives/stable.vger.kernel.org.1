Return-Path: <stable+bounces-178802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79791B4801F
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B967A89E7
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6741F12F4;
	Sun,  7 Sep 2025 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aaFfxU5h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E7125B2;
	Sun,  7 Sep 2025 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757278006; cv=none; b=N8+fNQiGaow1fetr7+o41KXV3PIRn+/5vM8nI3DERDNpQy7q+kK+hYupniJpyscla74XojrQd/8vxiXWDMYorlqf74Q0mqahYppotZookyIOQzqmh5jAix5ZLgwTmSlNt1wOXjxB9edhA2lSh+QUMoBqRVNJ0Of51RYD3wuaqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757278006; c=relaxed/simple;
	bh=bXMToLhIK6JC66BhQEDhleWRd7ynMVpIkp/Zr55bYqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdINkA503OsbkV2mfoFfZ5D665/DcR2XTyGhaWYYC6NBmsuWNBDSUOMbNuz1rQu53FnWvRUkrgns6UznBxva540YrXOBOBK00QL3Ps8n+p1FetDonggMTcsFaz+c9nPLApWS34D/rcRwt2No974m/TnSHlbXUXtEawJg0EmaVI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aaFfxU5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0113C4CEF0;
	Sun,  7 Sep 2025 20:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757278006;
	bh=bXMToLhIK6JC66BhQEDhleWRd7ynMVpIkp/Zr55bYqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaFfxU5hSUxjStjCxcD4hJuupHc2K9PiExYx1ukGnfpcoGKHImojqS1wQugduqL6T
	 eEx8+SpgNV4g71a9fNFYKe39fG+z1URJ51paqpPPhaNFvtkD3j12KQF9jOCiAZ4VEX
	 Wy1J9989qjBFVkZ/PwXLGMnq7HNO3PJ9pcVZmQYE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Rossi <nathan.rossi@digi.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 161/183] hwmon: (ina238) Correctly clamp shunt voltage limit
Date: Sun,  7 Sep 2025 21:59:48 +0200
Message-ID: <20250907195619.642308316@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit bd7e7bc2cc2024035dfbc8239c9f4d8675793445 ]

When clamping a register value, the result needs to be masked against the
register size. This was missing, resulting in errors when trying to write
negative limits. Fix by masking the clamping result against the register
size.

Fixes: eacb52f010a80 ("hwmon: Driver for Texas Instruments INA238")
Cc: Nathan Rossi <nathan.rossi@digi.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/ina238.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
index a2cb615fa2789..0562f9a4dcf12 100644
--- a/drivers/hwmon/ina238.c
+++ b/drivers/hwmon/ina238.c
@@ -300,7 +300,7 @@ static int ina238_write_in(struct device *dev, u32 attr, int channel,
 		regval = clamp_val(val, -163, 163);
 		regval = (regval * 1000 * 4) /
 			 (INA238_SHUNT_VOLTAGE_LSB * data->gain);
-		regval = clamp_val(regval, S16_MIN, S16_MAX);
+		regval = clamp_val(regval, S16_MIN, S16_MAX) & 0xffff;
 
 		switch (attr) {
 		case hwmon_in_max:
-- 
2.51.0




