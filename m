Return-Path: <stable+bounces-19665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE28F85251F
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 02:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CFD2B292A6
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 01:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B329612D767;
	Tue, 13 Feb 2024 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQbSXo39"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AA512DDBC;
	Tue, 13 Feb 2024 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783863; cv=none; b=O40iH9+h7pSCIUGi9qDekwIjSyqgnzyz6CXu0I7fAGf4SgAcWa2nuBvFrHBT7RDYASL7yFptFtf0tbPDBHnMt1G2rqu5nY2Nn6HQyGBNMqhsPVn84Ozp/20sj6wzglpR/wFu60cvYBcJnpLHWNH+bSWbkwlYEwztEfQfBoRV6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783863; c=relaxed/simple;
	bh=OET/8XFZvUB+tdghlDcFDzOlcCZEeqpMgInensZwx5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dny4NMZ4Y6z5pbCxRxecyYJ3Hc7KaHAwcflDSs6h1zh1yQsdmvOXCxeA49Vzvu9ulZ86eoF15LkgfxUuyafw3SgmvgyVqDwFMV1ePaO2WkPOPhVUROvzXXsAf5c6S2yb2MZ1yf7KbljiD+9yIkdMIJkeTHXc30ObFcC54PhoWO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQbSXo39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD65C433C7;
	Tue, 13 Feb 2024 00:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783862;
	bh=OET/8XFZvUB+tdghlDcFDzOlcCZEeqpMgInensZwx5s=;
	h=From:To:Cc:Subject:Date:From;
	b=cQbSXo39PpPvo0LXI64p4RIFyQvwwxcv+4GYmiWxM8MJl6EHiOLs2MlNXt+WPzOOc
	 OYbFi6CcySI6Y249I3OVlmI3cdUtpqiyd2om4tGRsCsFy5fWur2rtX2yOl7RTolz7e
	 6ktuLyLnNdE7IVWYYu+ZJ8bxem3y4iFaBVRepQEsqASG6rYGqZ2CWDKsz6SUKv8j47
	 23qKd9N/BERnXSAJfPqkvLYosQXupx9sFQxbV9MhdFXIWGMugjVrdBl23xAAhTek8N
	 B9nehrAzHSrCgVQa1shoz/blawUr+U43KVp3mEPBvo27l6QPvR2M8bvwHzXQejr9F8
	 L/6HS1FYBvDOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	fenghua.yu@intel.com,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/4] hwmon: (coretemp) Enlarge per package core count limit
Date: Mon, 12 Feb 2024 19:24:16 -0500
Message-ID: <20240213002420.673218-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
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
index 0eabad344961..b8d5087da65b 100644
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


