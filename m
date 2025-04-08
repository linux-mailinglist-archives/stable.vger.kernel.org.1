Return-Path: <stable+bounces-131517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66C1A80BD3
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6C5902F3F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C37126A1A8;
	Tue,  8 Apr 2025 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y6GAudCG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0845E267F4F;
	Tue,  8 Apr 2025 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116613; cv=none; b=FvhmzA2cPqdbW5trN92/g0nsOkYZkFGKLHx1SxmbTnMJEUSzLOYyd+DBtctwPDjp0O9nFaB/tMgsZc5WNBtSmLQYGWPQAGZKWMwzRMFGYCDtJIlA5iPbR4r8bj+oGdm3qMKxQQOBq2GVHmvzjZeteiQklWlYgZmeGTAptwm8S8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116613; c=relaxed/simple;
	bh=uxQ9n+EyVys2a38yphDh08UAVQ5vBUCJiGsaDoQux2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDyv67UKQrr3BWq6ThQLl+DqQEEbtW7zX4ux1svuy+FIfS8GKWFXoY8ThUYSgh7KFxq68ouPUOueOOeyMlGKxZO1bFEuJWVVvR5ggUHzqss+qhc+tRYeVzROtbEktI1aGgimvUvfPH78B/VpMOzfasa+rLxsCo0sV/sbgMimpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y6GAudCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6430BC4CEE5;
	Tue,  8 Apr 2025 12:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116612;
	bh=uxQ9n+EyVys2a38yphDh08UAVQ5vBUCJiGsaDoQux2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6GAudCGQhIrlFsSbOgdNj5yuar1P5AvZBNxbkgwdjDe/yyv8EO2pujJvxnhilRCz
	 Anj/Lpu5YdDd5j0Ix/cQOcUQ9sh3PQLNpbe/CcPqgmaeRimINF5s1SdhG0CcdKZCTW
	 22Ja20EhXP3z/4b4pPwtsm5sLYoN1CY2fTlJG32E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 177/423] ucsi_ccg: Dont show failed to get FW build information error
Date: Tue,  8 Apr 2025 12:48:23 +0200
Message-ID: <20250408104849.868920837@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit c16006852732dc4fe37c14b81f9b4458df05b832 ]

The error `failed to get FW build information` is added for what looks
to be for misdetection of the device property firmware-name.

If the property is missing (such as on non-nvidia HW) this error shows up.
Move the error into the scope of the property parser for "firmware-name"
to avoid showing errors on systems without the firmware-name property.

Fixes: 5c9ae5a87573d ("usb: typec: ucsi: ccg: add firmware flashing support")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250221054137.1631765-2-superm1@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 4b1668733a4be..511dd1b224ae5 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1433,11 +1433,10 @@ static int ucsi_ccg_probe(struct i2c_client *client)
 			uc->fw_build = CCG_FW_BUILD_NVIDIA_TEGRA;
 		else if (!strcmp(fw_name, "nvidia,gpu"))
 			uc->fw_build = CCG_FW_BUILD_NVIDIA;
+		if (!uc->fw_build)
+			dev_err(uc->dev, "failed to get FW build information\n");
 	}
 
-	if (!uc->fw_build)
-		dev_err(uc->dev, "failed to get FW build information\n");
-
 	/* reset ccg device and initialize ucsi */
 	status = ucsi_ccg_init(uc);
 	if (status < 0) {
-- 
2.39.5




