Return-Path: <stable+bounces-110758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B386A1CC3A
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E137A64E6
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6524E233144;
	Sun, 26 Jan 2025 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBHIefZR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C707233153;
	Sun, 26 Jan 2025 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904106; cv=none; b=jGVuaz4O6ESzcnHBXz/U3EUv1NWr03Es6DIWbgFgjVVYTOZOX0AqLLfazFZluVSelcrC8zJjNIPPmHDjgAn6XRpgZNDPkzsfu73vUbfedDfPK8y3/d0Y5NX8/jv9nnF/SqNkIB5G5HPpzM7+qd99P2ZlNsALA0CGfGKjxXVnawM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904106; c=relaxed/simple;
	bh=QnzqIaKbw80xWV/edjf9XzoekPfvHQMXzylICAW2DFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8lWOXfph3LAT0Qdk6sGWggA+W5y3AUwZR9Vf2LrDUejcl16oYf5pyRcB3/Tozwv7a0d2n0bpu8l2XzeFkPl4q3pjnU5ocyUhFeX22wZcdnsauRv5BpNZECvhCATjMYFGVA24u6RqSyqZOl78sHHXUiI02k2w5s2CEg5y0dFzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBHIefZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8A1C4CED3;
	Sun, 26 Jan 2025 15:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904105;
	bh=QnzqIaKbw80xWV/edjf9XzoekPfvHQMXzylICAW2DFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mBHIefZR08ZSspr4ikEZezkt4xlne8cRMuGSbnYVlBM5Wk1URJrKovdO9dyzvmTRC
	 7r1ba4aqK4zNnplTq8Cy9AxEuLMe3tezCUokObmaTP7S2AiwzC87RYDj9L7w5S8G64
	 ww0p6c5DNJvLkWNVwXnaTa2+h6kk9ce2u8tuwhdPshbgUaxtj3kkP19IUcp4QD6q9h
	 sNG+NRstEQocB38BMpe3zH/0khlKdtfPQZ9JYeYx7m5o4nj9Q6T2jTWCq+8vpwW/ya
	 Wxxp2h30fF93JpKeKY8utpP2mv80H6Cu+bDzcn2iiiu9TZudT4YscOHzhcdwSOEh/Q
	 Y2YMnG1CaeV8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	djrscally@gmail.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 07/14] platform/x86: int3472: Check for adev == NULL
Date: Sun, 26 Jan 2025 10:07:54 -0500
Message-Id: <20250126150803.962459-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150803.962459-1-sashal@kernel.org>
References: <20250126150803.962459-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
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
index 3de463c3d13b8..15678508ee501 100644
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


