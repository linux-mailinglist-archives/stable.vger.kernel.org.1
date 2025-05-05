Return-Path: <stable+bounces-141261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ECFAAB1E4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B86516138F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D0627FD5D;
	Tue,  6 May 2025 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTefZgwC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26162D4B6B;
	Mon,  5 May 2025 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485664; cv=none; b=m4oZRtu3l1gB8VBFThHXVdKVLf+GW6Ij9xnsahVsysffaBMJKDH0AzhGOoEIo4QOaXqCwvINEeRgTQBvtIB7auS6sQveNp4Ns++EAQc80NiYhJSsK1nxb1ErwQ5uvxALAr6ecjjVwID2ESGX+KBdVvmsKkEzxy2WA92VdumUWBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485664; c=relaxed/simple;
	bh=1lVLviGO2hGeP0bjhg7Ye0CgtStFo61fKGBpbAB19NY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCrROffW1CnWx1erzUmEBm5wyIdmlFW90rQkHyCvfDnEE/aIMsXl8fwl8U5GJlVrLazoHHJjjHSllLVUKV4uFMSoiXa+q1/5i04NjBWAM+Wu5fZW/T6G01utjVXtTjNJu+VTzqRPoH/5Nd3tcECkwnskxuhUvwiWLr2LQAY8N8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTefZgwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB22C4CEEE;
	Mon,  5 May 2025 22:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485663;
	bh=1lVLviGO2hGeP0bjhg7Ye0CgtStFo61fKGBpbAB19NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTefZgwCNrNywDWhy9uEzS4sNd8p+J35vsjttfZ7y6121o9OE9VgMYsrlbKEsNUeD
	 Wur8AA0voyHc90215+yZBygGDxYlEMZqzhXN0DWDYrpxsvEGzcq2o0sBPRTnc/E0LW
	 6A9xSa+LpMc+D3jxwpo8dCzYEf3ni1X3Uhc0rEWvQLxT0tg9FMljMPJYKJqG6drA+R
	 HyTHIdxAOEq49q+ylYMeEc72TzPMlRB7fmmDlj2NjaUBw0zh3YutQE+nUtQO6YTCqN
	 WeCGhrffi9LnQiEK35PGrGKjuGXQ6V1bcauFwzq1v3wTdooqg8FrXQHe1MtdUIGLdG
	 VT36wZkfO4dzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Vatoropin <a.vatoropin@crpt.ru>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 415/486] hwmon: (xgene-hwmon) use appropriate type for the latency value
Date: Mon,  5 May 2025 18:38:11 -0400
Message-Id: <20250505223922.2682012-415-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 92d82faf237fc..4e05077e4256d 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -105,7 +105,7 @@ struct xgene_hwmon_dev {
 
 	phys_addr_t		comm_base_addr;
 	void			*pcc_comm_addr;
-	u64			usecs_lat;
+	unsigned int		usecs_lat;
 };
 
 /*
-- 
2.39.5


