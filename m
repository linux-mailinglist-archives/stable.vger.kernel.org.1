Return-Path: <stable+bounces-141033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6FBAAAD93
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D0C3B59C7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83F4308A78;
	Mon,  5 May 2025 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2WCVmeR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122153B6B80;
	Mon,  5 May 2025 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487287; cv=none; b=WXNMLX8ao6evF1/m3C7bix9KxSWTW6xXgebKl8OVsE/mch0MyUht3PGqcwuufbLAJzvNPqFQhme2wdwWIepl/JRfivn65/J6qkU6YXEJ8SNPg5zySE4f0RH3qrVNM9noOxb55ou0+Xb3iC8u8yTslkxkwr8QNUtoeOQ5RjCoxSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487287; c=relaxed/simple;
	bh=/5BcaKk29skcl6C0x/EXuNzv3BY6vyonckuttvX+NdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vf/JH/Vo3gIWGkQEijMwKtCBjnjn122MDS1L8IW4TmUT/lXSdL9I2foUUbK2rp6VG2ZJVV45MBfldD/N64Lu2Vq/fe8hebBskgOTAVgPbVTEMLii0c50gU74RK2v50bq519CjKOj8+ZVUxqYpddQIzWhsisyNP+yZypBWCWfbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2WCVmeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8923EC4CEF9;
	Mon,  5 May 2025 23:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487285;
	bh=/5BcaKk29skcl6C0x/EXuNzv3BY6vyonckuttvX+NdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I2WCVmeRWSZ2nvXjXhQzfoKwhwKg1RNjIfw5MoenqTakzUjVVYxJIbeG8nvy7thmR
	 MwsJJCpSj5V+3BAz6WPurfaRgsMA2siRl8lgODed4+4dUGWJVTj8hKL8hAXSzcLKVn
	 hBw1FYGW4RTChMrV9Fauq6tIq4+co+yyZJBxL/INLj5TCAKLel24ikMsPK1ZgyZomX
	 +QMmIq1euhjPXBmNNzjaH2iZ7nSjJ9/BiWPIvzdI3G9U9T3bhciJKiGE8O9I6Gco3Y
	 GslLsn27aSN/Em5UWcmWolBYGm1hn6Fo7ncRvvHz85uOAovEpoQL1H+Qjd6dbO9otI
	 UPdGk1Y8Ygt1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Vatoropin <a.vatoropin@crpt.ru>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 099/114] hwmon: (xgene-hwmon) use appropriate type for the latency value
Date: Mon,  5 May 2025 19:18:02 -0400
Message-Id: <20250505231817.2697367-99-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

[ Upstream commit 8df0f002827e18632dcd986f7546c1abf1953a6f ]

The expression PCC_NUM_RETRIES * pcc_chan->latency is currently being
evaluated using 32-bit arithmetic.

Since a value of type 'u64' is used to store the eventual result,
and this result is later sent to the function usecs_to_jiffies with
input parameter unsigned int, the current data type is too wide to
store the value of ctx->usecs_lat.

Change the data type of "usecs_lat" to a more suitable (narrower) type.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
Link: https://lore.kernel.org/r/20250204095400.95013-1-a.vatoropin@crpt.ru
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/xgene-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 559a73bab51e8..15889bcc85875 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -110,7 +110,7 @@ struct xgene_hwmon_dev {
 
 	phys_addr_t		comm_base_addr;
 	void			*pcc_comm_addr;
-	u64			usecs_lat;
+	unsigned int		usecs_lat;
 };
 
 /*
-- 
2.39.5


