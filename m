Return-Path: <stable+bounces-24689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5926E8695D5
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF651F2BFEC
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1741419AE;
	Tue, 27 Feb 2024 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vgH9N4Us"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771E014264A;
	Tue, 27 Feb 2024 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042718; cv=none; b=ggO5glqMeuiapECLvXH2fajbFHzk0pE03F+0dtWld1D/j4d5FqRUs2D8byHNrh2xLTmuLKoLZutZHqNoWNF4cY33Qa5VMGzIuu/u6xw/WaH1wr0Y5xWc7hGynbj7rxc8A8h0d+/0TfYILHLYysuFBOxKeTQj955F9U9UT8NlMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042718; c=relaxed/simple;
	bh=9ZxHfUYQnN5BIeyb4+T78dDYKVy9XjgrxNQQT24576k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sItUZE8vQzMGEc9UkfiRV/ElcyucYkZT0mrOrtKE6quoltO+ZLi2o1+d8QVfQhyff4UGlipwwbl/vFVE5gWblz0RSyV4c9M8SjLv2kRuebryhqIxjb07NR2KI+qx6kdflkKQJNrIIJxBGzIwPZiOXmc8LJOaessUNS/ozQQVrbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vgH9N4Us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AD5C433B2;
	Tue, 27 Feb 2024 14:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042718;
	bh=9ZxHfUYQnN5BIeyb4+T78dDYKVy9XjgrxNQQT24576k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vgH9N4UsVIfBZ4q0DKBou6igZzT8RhhPl9rjVXtnEsUokKYMieIi6tmbCNNXGB+3r
	 dHtEq4ElIL5/lgn3rtTjGVu3+CYsPB5t29ey0dN2I5Vuq9199PLgPyZlCwdneBldmZ
	 LjmSAQMmOa1N413QUUtkXu4csIq1YWEHtWnWQINM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Rui <rui.zhang@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 067/245] hwmon: (coretemp) Enlarge per package core count limit
Date: Tue, 27 Feb 2024 14:24:15 +0100
Message-ID: <20240227131617.420237402@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
References: <20240227131615.098467438@linuxfoundation.org>
User-Agent: quilt/0.67
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
index d67d972d18aa2..cbe2f874b5e2f 100644
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




