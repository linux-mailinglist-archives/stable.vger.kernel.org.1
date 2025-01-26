Return-Path: <stable+bounces-110778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B271A1CC55
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328A31884634
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0AD2451DF;
	Sun, 26 Jan 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euhhqIeY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527E2451D6;
	Sun, 26 Jan 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904155; cv=none; b=hM7oddd43fts1CNvL91n3Pg2tP7W3qARBtA9pN27xCN3nEC0r4ZpO4tLQY2VSyjjDHgkAHFE4IIOs4uadSnq5YEpw8CUr/NhyFUGhxsn1r3qxwjzCKX8XSgruTXWfLTcD+JQyDUt5qpjPfAmx33vrhiXUOeTaZvdapiNvV3AClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904155; c=relaxed/simple;
	bh=kSW9BxWYGLCWm0wPaJ9MIvqC55F0Loeq4teWutAwFjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpyWB1Glkc5bKryv5wyXEoH1dpsaOMPLIqtJ0RPgaxVaHqYz+/T+Dy7xS+XQshqMLzsE03hFjTU12vPTNdL4dPgJsEOSTqvDZruy03vVY/QHBqsHpjgG2bcGLVibc6HnZ082b+tlh++ukuynoQS7TSAANUQJ3XYXkRcoKYnLmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euhhqIeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913B3C4CEE4;
	Sun, 26 Jan 2025 15:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904155;
	bh=kSW9BxWYGLCWm0wPaJ9MIvqC55F0Loeq4teWutAwFjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=euhhqIeY6TwjhpDLkDOxcAyqGTeLp4HAOFTuPB94+ezoiYSN0bX9ElIS6ZP1B4Nk7
	 AnN1pXVYUOG6ove1gAwAxATaBWH6YrsuW/C2+EbzHNL/R+Ln8t1RgbPLEL6Y2q+aUt
	 DZ4JRBZvWZmC2UuxDOo13vXmUhCga2rTUcYyVQoddQX+tAezTHRnFJWnVbVEiCdaCl
	 1jOMuBPMoI917P8KK/BgkJ4hbNoRFAlhMiOEQ3LE9HvuZWwnYogD4WAWI7HSgpqka7
	 8iC+p1t4zge4sOdTrO/GjyiiwQOAkzHqaQ95FxotNMguGQgcRLqpyKAzYWhKQ5EqjM
	 DD4jcZ1cISnMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	djrscally@gmail.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 4/8] platform/x86: int3472: Check for adev == NULL
Date: Sun, 26 Jan 2025 10:08:56 -0500
Message-Id: <20250126150902.962837-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150902.962837-1-sashal@kernel.org>
References: <20250126150902.962837-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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
index c42c3faa2c32d..0f16436e5804b 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -359,6 +359,9 @@ static int skl_int3472_discrete_probe(struct platform_device *pdev)
 	struct int3472_cldb cldb;
 	int ret;
 
+	if (!adev)
+		return -ENODEV;
+
 	ret = skl_int3472_fill_cldb(adev, &cldb);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't fill CLDB structure\n");
diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
index 5b8d1a9620a5d..82fb2fbc1000f 100644
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


