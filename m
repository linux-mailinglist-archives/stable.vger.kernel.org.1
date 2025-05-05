Return-Path: <stable+bounces-141089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B14EBAAB07E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9E61BA54D3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAFC30FD07;
	Mon,  5 May 2025 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFkutQau"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B903C01D9;
	Mon,  5 May 2025 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487431; cv=none; b=ONTKw99nqzVqSWDhnllJ7gNWa0NCGQ6UvBy1CXTl65bKdscKnT05ZTkDnljE2+eBbxDViWns7JwBF5RaLU5lVbEQjPhdNWIF+AJO6fR9hgaNW6zNLRG4jVxA2HGCugdBJq6RNrWH8mkhlK1n4NCgRqfcR/CEj78a+FPLEJ95VC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487431; c=relaxed/simple;
	bh=/5BcaKk29skcl6C0x/EXuNzv3BY6vyonckuttvX+NdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m8oorU2Zj9JO71UqpEiexKw72xG03eG7zJwDhW9BR6LN8duuQLQ2HuAZ0NKaH8nCfL/r91KJFeG0CD5iqoLTSwnfgDI8psrcjbIy8u6y7ZoVPOEBR7Tw8QsAtGfOc6HOw8EzZ0mjfR7Tei9jXLQ2ohGhjAvc8DCRnimRX/OIHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFkutQau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D7AC4CEE4;
	Mon,  5 May 2025 23:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487430;
	bh=/5BcaKk29skcl6C0x/EXuNzv3BY6vyonckuttvX+NdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFkutQauMAcbZIBmcPBNZRs05NpUYU8zTQ8S8zkzdhhN4sT8Q2vNb0Ar9ErUX9i9F
	 +oM1CvFPCS8lzQscfws2l+MwRm0OQiUtsr6tan8f/KZ0O+cx+8m4kXzjqZPWE3WfyR
	 FNG/0PQbIbbzjcV0BPCcRWSaT6NVc38AZRgOjtiyVdGGWl21RG0nRpAI4WQacImUv8
	 a1gMW4WYGjDPjg21FKy5nmKXcKymhnaqDLrdNt8xyf7GW8DjtOXLy4bD3gPbWT7jER
	 qZ7L7EMl5epUQp3xxH57fAGLn4/YYlH/I/xPnP4BEHDi84DgmgjJe+aJtK1ydfrVgN
	 zlIiVQSkvHWBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Vatoropin <a.vatoropin@crpt.ru>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 67/79] hwmon: (xgene-hwmon) use appropriate type for the latency value
Date: Mon,  5 May 2025 19:21:39 -0400
Message-Id: <20250505232151.2698893-67-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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


