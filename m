Return-Path: <stable+bounces-110770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B603A1CC62
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703DB3AD642
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2865323A573;
	Sun, 26 Jan 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvoWXQIY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428E23A56B;
	Sun, 26 Jan 2025 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904133; cv=none; b=nbxJNfVbXz0oX7c1Hc388727xUOvg74ziKoRSnA8YWJ23osKWIGwfSOxq+eGmMdpnv2oRkpKclq6MwPXSxpsjcyvcFtAFYlFki8PE4froiHxrjh6CyDc8P+Yf3+TsWDgMG7Z0RKeddgr/kQwvwLoiHcbQt/8Nh1T/tsbum4Pj9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904133; c=relaxed/simple;
	bh=WvXfEVf4L9LMLOW/knb5Zil35y4vEWnb1a4ozLDSwOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0uWa7DAApV+dFIbMVXcvJSCLmYyemwLMm8d8CEAm9YPWwAKfX1h7OyHzI87nDWCD6n/osCEA0GVIrqldltTG/arnavc36/pUdnvsfrwzkJXFlb9Wl5PbhAE7BaY1YeKfZDM6cVEFI7dROCCb7zsJ+vw+NSdvD7sMkHM94SVEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvoWXQIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86129C4CED3;
	Sun, 26 Jan 2025 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904133;
	bh=WvXfEVf4L9LMLOW/knb5Zil35y4vEWnb1a4ozLDSwOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AvoWXQIYuFilyJpGHRtauDk8QSjGcYcNNvE2tFb5/7yyw4LeE+emt6wDxpXt/VIhM
	 Z7g9nHhfODjUTXu/vVZglxRA/N3Jn3NBDKJ3mcyijlXh0p+81lPvvLSGqHLY6Up/c9
	 fm9TfgLeomfm0woxB8FbWGZ+Ct+pn0rKxztiH9k8RahfxQ8nYfaHifL54OFptSyiho
	 /BYQcJutg7HXpKDI9kBIc6JQH3jno0EjRgb1JQeolE2FzhFfgknleGNrOZyXeyixsq
	 HN8qJemdUPcl9B8TecL4xR+PkynnpamsHOqwTAUL6b857PI+SRYQZJCvMLbr8W52Do
	 XETPW5jaj3yKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	djrscally@gmail.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 5/9] platform/x86: int3472: Check for adev == NULL
Date: Sun, 26 Jan 2025 10:08:33 -0500
Message-Id: <20250126150839.962669-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150839.962669-1-sashal@kernel.org>
References: <20250126150839.962669-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit cd2fd6eab480dfc247b737cf7a3d6b009c4d0f1c ]

Not all devices have an ACPI companion fwnode, so adev might be NULL. This
can e.g. (theoretically) happen when a user manually binds one of
the int3472 drivers to another i2c/platform device through sysfs.

Add a check for adev not being set and return -ENODEV in that case to
avoid a possible NULL pointer deref in skl_int3472_get_acpi_buffer().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20241209220522.25288-1-hdegoede@redhat.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/int3472/discrete.c | 3 +++
 drivers/platform/x86/intel/int3472/tps68470.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index e33c2d75975cf..d56f79043f5e2 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -284,6 +284,9 @@ static int skl_int3472_discrete_probe(struct platform_device *pdev)
 	struct int3472_cldb cldb;
 	int ret;
 
+	if (!adev)
+		return -ENODEV;
+
 	ret = skl_int3472_fill_cldb(adev, &cldb);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't fill CLDB structure\n");
diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
index 1e107fd49f828..81ac4c6919630 100644
--- a/drivers/platform/x86/intel/int3472/tps68470.c
+++ b/drivers/platform/x86/intel/int3472/tps68470.c
@@ -152,6 +152,9 @@ static int skl_int3472_tps68470_probe(struct i2c_client *client)
 	int ret;
 	int i;
 
+	if (!adev)
+		return -ENODEV;
+
 	n_consumers = skl_int3472_fill_clk_pdata(&client->dev, &clk_pdata);
 	if (n_consumers < 0)
 		return n_consumers;
-- 
2.39.5


