Return-Path: <stable+bounces-122720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB15CA5A0E6
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871731892A5A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2476A23237F;
	Mon, 10 Mar 2025 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mtDFCl6j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFDC2D023;
	Mon, 10 Mar 2025 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629304; cv=none; b=jMLFs5u3HEqhMs2Bw9+xwguM9b50xXmC19whqsotza/S7sXxQwbd2DYrt5ylHZoDgBqJgWLcJdccAxEzsyX1lvy9hL6XJO5nqi0x8xBerHzs88Y7xiMSvWR72fmKSdGi2cJcxJuDB+3jbWPnIn/vm+HV/co9rFbR3QnTxKuvcbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629304; c=relaxed/simple;
	bh=919Oj1QLToLl+MQLiHaa0bVnG4U53FPKDsbUAhYbL9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJEbr3iulQj7qeCgYTH7WE++zLxMXukH6Ui8M8m4J4yVVYTZtq4sGbIlMwm/l+lzni2mVMGt92XlyTCIZmBBTGfxtcgVfI4REpaTy3vuodcpMKH2E6JvOBAu7z52j+GozlyFtyi1MPRQ2gFchZs2OxfU/XGC8p5pzGFvPDyhO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mtDFCl6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49223C4CEF1;
	Mon, 10 Mar 2025 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741629304;
	bh=919Oj1QLToLl+MQLiHaa0bVnG4U53FPKDsbUAhYbL9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mtDFCl6jvu5GceslDSAKzYn48RQpsfKbpDy6HbPDPx2lCMGwf2YsojCN+plJlZSVh
	 JA9jR77vlZrVA4kikVWPVAAZu9O5a17YDHix6AtNoESLWgZSYQhSGN2rJgOzXnASWW
	 gpB4zncHy/hcSzl8Rxj88c1LjUkwsKkYV2/PEzQA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randolph Ha <rha051117@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 217/620] i2c: Force ELAN06FA touchpad I2C bus freq to 100KHz
Date: Mon, 10 Mar 2025 18:01:03 +0100
Message-ID: <20250310170554.190099426@linuxfoundation.org>
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

From: Randolph Ha <rha051117@gmail.com>

[ Upstream commit bfd74cd1fbc026f04446e67d6915c7e199c2bffd ]

When a 400KHz freq is used on this model of ELAN touchpad in Linux,
excessive smoothing (similar to when the touchpad's firmware detects
a noisy signal) is sometimes applied. As some devices' (e.g, Lenovo
V15 G4) ACPI tables specify a 400KHz frequency for this device and
some I2C busses (e.g, Designware I2C) default to a 400KHz freq,
force the speed to 100KHz as a workaround.

For future investigation: This problem may be related to the default
HCNT/LCNT values given by some busses' drivers, because they are not
specified in the aforementioned devices' ACPI tables, and because
the device works without issues on Windows at what is expected to be
a 400KHz frequency. The root cause of the issue is not known.

Signed-off-by: Randolph Ha <rha051117@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-acpi.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 6ce05441178a3..8b06f5d4a4c30 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -327,6 +327,25 @@ static const struct acpi_device_id i2c_acpi_force_400khz_device_ids[] = {
 	{}
 };
 
+static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
+	/*
+	 * When a 400KHz freq is used on this model of ELAN touchpad in Linux,
+	 * excessive smoothing (similar to when the touchpad's firmware detects
+	 * a noisy signal) is sometimes applied. As some devices' (e.g, Lenovo
+	 * V15 G4) ACPI tables specify a 400KHz frequency for this device and
+	 * some I2C busses (e.g, Designware I2C) default to a 400KHz freq,
+	 * force the speed to 100KHz as a workaround.
+	 *
+	 * For future investigation: This problem may be related to the default
+	 * HCNT/LCNT values given by some busses' drivers, because they are not
+	 * specified in the aforementioned devices' ACPI tables, and because
+	 * the device works without issues on Windows at what is expected to be
+	 * a 400KHz frequency. The root cause of the issue is not known.
+	 */
+	{ "ELAN06FA", 0 },
+	{}
+};
+
 static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
 					   void *data, void **return_value)
 {
@@ -348,6 +367,9 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
 	if (acpi_match_device_ids(adev, i2c_acpi_force_400khz_device_ids) == 0)
 		lookup->force_speed = I2C_MAX_FAST_MODE_FREQ;
 
+	if (acpi_match_device_ids(adev, i2c_acpi_force_100khz_device_ids) == 0)
+		lookup->force_speed = I2C_MAX_STANDARD_MODE_FREQ;
+
 	return AE_OK;
 }
 
-- 
2.39.5




