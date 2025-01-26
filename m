Return-Path: <stable+bounces-110743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2400EA1CC52
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C363AF81A
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCC71F8687;
	Sun, 26 Jan 2025 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4EDoeDv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F91F867C;
	Sun, 26 Jan 2025 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904068; cv=none; b=Ozsn1VodoKpKK0q/8Hzv9erXrwnffygEk3IGpQisHXt5JZN46MaMUMhkqFO3MNu223caY2tPbbV1SRyg/xksj6dCa/Y7KeyB5J7yRGjiZLYrpsUGTrnTZdTZcqMqImjt/90wdgRXHsSUgH2lAUjwpTWLQo+T7wnLe85/obXDBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904068; c=relaxed/simple;
	bh=CqYnAwsVyOnba8EFcvBMzyqTe8jtNWeYkeeFQ/7KGI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIdpHqyMatmwU+0A67oVLLTeaSZipFp3aLxr5f0p3URFY0+jOEwgXXI1vqJ3RyfF0QF1LV/X8Aj1YXKrEl7865qatuZYEzuxUTIXsFZ7TW4wFKtXFX9hDX9vg9An5n7AOBBv/GPjjQLwzuPnFnyeZfNNlsL5LKDXuvVR22uCnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4EDoeDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52347C4CEE2;
	Sun, 26 Jan 2025 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904068;
	bh=CqYnAwsVyOnba8EFcvBMzyqTe8jtNWeYkeeFQ/7KGI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4EDoeDvNz/LMjABvQCCmwNvjNGVxyDdhjvN8qk6oVruZSwS7brQrVn1qsV+SuS7D
	 tUEXfnWhG0zkcpqFtSHSyYUaicLdrX3+PF//v4+2dHsTBzndDznSwkwIYErwH23aMF
	 EdaP7Qzt++ihARSeGymn6z9tdxexLb5Nvnw4DGo0aPAimhiudhMkHZfRnjn06zliN0
	 iXeJlrd9Q1tB70z6q4HUjgcGYZirfF9iaU3LQtSURseVIBolKnJwIYfjlu/tshEy0E
	 9afTP6QIeFcRd5lpas1k66Qn57uswqbzBVLABLGQyU8pdRz+5MdregA4J9MJHuWMLN
	 hZ4J8j/hDluTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	djrscally@gmail.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 08/16] platform/x86: int3472: Check for adev == NULL
Date: Sun, 26 Jan 2025 10:07:10 -0500
Message-Id: <20250126150720.961959-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150720.961959-1-sashal@kernel.org>
References: <20250126150720.961959-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index d881b2cfcdfcf..09fff213b0911 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -336,6 +336,9 @@ static int skl_int3472_discrete_probe(struct platform_device *pdev)
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


