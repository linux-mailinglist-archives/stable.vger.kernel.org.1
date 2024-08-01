Return-Path: <stable+bounces-64896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8765D943BDA
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E2EFB2379F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E2119E7E0;
	Thu,  1 Aug 2024 00:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4u+peHn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFF61A00F5;
	Thu,  1 Aug 2024 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471319; cv=none; b=PbBtq+0mkJdpoHVIazO9uqMR5m9WzzvUEcP3KQAq5VLnBJyLefOG0gxST8tbNqdZHFdp98PzjvAOIUTcT3W/37kZaK7VqXYbP+KwU+y0vWZV8eI42mKjuXLfVgNJQFOVst356+FTMnoa7DAYiST+hdlQ6WbR8rqSlK7QqRa0uxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471319; c=relaxed/simple;
	bh=KTGm+ilUVWniYjnuDO3KDX6ydHfBknLU0Z30PK8azqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh2YzUzngMyrx91c7Jnte94fgswK9DRiKErbTeRJt5CY1zxbknKRLQrJ+ytXEkPfTgragbPE/nYv4sOwAb+yeMDJA01XFLKcgexZSR7N6dKrJtAHNyF35tUsUEhAe8Gd2TUhvEkgUlVTrvCraUY/wJPSKqzyR44Yp1W9F/1JeO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4u+peHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723CCC32786;
	Thu,  1 Aug 2024 00:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471318;
	bh=KTGm+ilUVWniYjnuDO3KDX6ydHfBknLU0Z30PK8azqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4u+peHnJQWRatWGxivx5k5OXhhbQkS0jv6IMYWhizReuZFvOkwT3ubChRd9FUoFn
	 VnXvu81K5QOCuJwwExXtZPtAsjOqZNTu6svR3Eni5Z1TMhUQ6EhVbn1UEZZQYoF1Z4
	 CZbNLJ4biHdsFQdDkv3ffxS+zSIox11EzMVTFvbULEogYgRxl795yEcWbf8xxyx0wV
	 sb+10v7p/VhIEzdgyPOIpNke7xc+HxXIXDaLSDKt/nEo+V+5lcwXxxJ36C2We3P1LW
	 6jj1AeEogeY3fqtZPr0yfPMQguWvE4YUXJdZzXfFMukhDQt3HxBC3j/8/brVLaIPyA
	 xzNPylhJj1yDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	clemens@ladisch.de,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 071/121] hwmon: (k10temp) Check return value of amd_smn_read()
Date: Wed, 31 Jul 2024 20:00:09 -0400
Message-ID: <20240801000834.3930818-71-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit c2d79cc5455c891de6c93e1e0c73d806e299c54f ]

Check the return value of amd_smn_read() before saving a value. This
ensures invalid values aren't saved or used.

There are three cases here with slightly different behavior:

1) read_tempreg_nb_zen():
	This is a function pointer which does not include a return code.
	In this case, set the register value to 0 on failure. This
	enforces Read-as-Zero behavior.

2) k10temp_read_temp():
	This function does have return codes, so return the error code
	from the failed register read. Continued operation is not
	necessary, since there is no valid data from the register.
	Furthermore, if the register value was set to 0, then the
	following operation would underflow.

3) k10temp_get_ccd_support():
	This function reads the same register from multiple CCD
	instances in a loop. And a bitmask is formed if a specific bit
	is set in each register instance. The loop should continue on a
	failed register read, skipping the bit check.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240606-fix-smn-bad-read-v4-3-ffde21931c3f@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/k10temp.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 8092312c0a877..6cad35e7f1828 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -153,8 +153,9 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
 
 static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
 {
-	amd_smn_read(amd_pci_dev_to_node_id(pdev),
-		     ZEN_REPORTED_TEMP_CTRL_BASE, regval);
+	if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
+			 ZEN_REPORTED_TEMP_CTRL_BASE, regval))
+		*regval = 0;
 }
 
 static long get_raw_temp(struct k10temp_data *data)
@@ -205,6 +206,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 			     long *val)
 {
 	struct k10temp_data *data = dev_get_drvdata(dev);
+	int ret = -EOPNOTSUPP;
 	u32 regval;
 
 	switch (attr) {
@@ -221,13 +223,17 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 				*val = 0;
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
-			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
-						  &regval);
+			ret = amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
+					   ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
+					   &regval);
+
+			if (ret)
+				return ret;
+
 			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
 			break;
 		default:
-			return -EOPNOTSUPP;
+			return ret;
 		}
 		break;
 	case hwmon_temp_max:
@@ -243,7 +249,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 			- ((regval >> 24) & 0xf)) * 500 + 52000;
 		break;
 	default:
-		return -EOPNOTSUPP;
+		return ret;
 	}
 	return 0;
 }
@@ -381,8 +387,20 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
 	int i;
 
 	for (i = 0; i < limit; i++) {
-		amd_smn_read(amd_pci_dev_to_node_id(pdev),
-			     ZEN_CCD_TEMP(data->ccd_offset, i), &regval);
+		/*
+		 * Ignore inaccessible CCDs.
+		 *
+		 * Some systems will return a register value of 0, and the TEMP_VALID
+		 * bit check below will naturally fail.
+		 *
+		 * Other systems will return a PCI_ERROR_RESPONSE (0xFFFFFFFF) for
+		 * the register value. And this will incorrectly pass the TEMP_VALID
+		 * bit check.
+		 */
+		if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
+				 ZEN_CCD_TEMP(data->ccd_offset, i), &regval))
+			continue;
+
 		if (regval & ZEN_CCD_TEMP_VALID)
 			data->show_temp |= BIT(TCCD_BIT(i));
 	}
-- 
2.43.0


