Return-Path: <stable+bounces-19661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE11085250D
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 02:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEA0281349
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 01:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616D312CD80;
	Tue, 13 Feb 2024 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZoAEM37"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B64512C810;
	Tue, 13 Feb 2024 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783855; cv=none; b=NlXq8tzbVPKJT2ugqmKGNSn4wZwczjd8J/c6xYpcIEKabkEYGmSawvkxMyM12EWmxeW8RWGttX/OjRFkbboR1QMhtfwWmVxRhfta5qwdvFRlFobsTUf3N0Woj/WIIME5TBRuea45ifeDBcgTf1hNWBNbZOgFIWsnUhgFF4Nmn04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783855; c=relaxed/simple;
	bh=Ezlrsu8Cpnk9jt6VCc0qt5xWi89GOLhSDzVRUGGBsD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kn8y+dDMK98MPMFau7qbJ+3pQsWWBMMKZbWV668VIEvdhSA29GbNAK0rOEKGigOtDPq0OmU5HlkXtiXENvDrNjtegtsul7ewy+5Po5PFYWQ3govCPn/LPRJMzStpwc5IGUTY70/RQR7hFdnQGmP9sAtrItP8vf1hS/+yBxb//io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZoAEM37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD95C433C7;
	Tue, 13 Feb 2024 00:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783854;
	bh=Ezlrsu8Cpnk9jt6VCc0qt5xWi89GOLhSDzVRUGGBsD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZoAEM37rz6Grn28MiXRGAY0y2//GvRi2a6EMVWRZRlwFrGNmS9Dnv1ZIe8HT6J8Y
	 1nJcj/I6jj2NWIyU+su5ZD65OjyZvVkJ+Mn7FQ7MU/MefzBmv7VPmhN7kRKocMi4rU
	 +QEPt6+/UK8s+Cpy8LUWz7r1DACXX0tp333GWmG8V7eYCDpy3uMZsE+lLI/0L1PWGs
	 l1tBj5bLsxffFUVf80ujHO6Y7FhAbJH/T3WXZNsudG1BHqz6KOF5qCXUSslT5Z/9cs
	 1MaLKDoXP7rSu6Wi4Gl/xRiWbouNcpFUvc5jN51Eu7cCPLE8aNttU+PfTBb+BtRVSR
	 ob6pgBrS9eLFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	fenghua.yu@intel.com,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/6] hwmon: (coretemp) Enlarge per package core count limit
Date: Mon, 12 Feb 2024 19:24:05 -0500
Message-ID: <20240213002409.673084-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002409.673084-1-sashal@kernel.org>
References: <20240213002409.673084-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit 34cf8c657cf0365791cdc658ddbca9cc907726ce ]

Currently, coretemp driver supports only 128 cores per package.
This loses some core temperature information on systems that have more
than 128 cores per package.
 [   58.685033] coretemp coretemp.0: Adding Core 128 failed
 [   58.692009] coretemp coretemp.0: Adding Core 129 failed
 ...

Enlarge the limitation to 512 because there are platforms with more than
256 cores per package.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20240202092144.71180-4-rui.zhang@intel.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5b2057ce5a59..23b1c4c0452c 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -40,7 +40,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
 #define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
-#define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
+#define NUM_REAL_CORES		512	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
-- 
2.43.0


