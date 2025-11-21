Return-Path: <stable+bounces-196015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 608CBC798F9
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 061CB2C631
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DD534C819;
	Fri, 21 Nov 2025 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OumiSscv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCD9349AF4;
	Fri, 21 Nov 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732319; cv=none; b=rbhUZLY1c/RXvPsNiJ41nTaQtDUJKYxfeO8GYbnYrq9EeyOoZYWvLAsADS1imRg5Tbo0ftAmMp/F5kPafCpOuey4KlTpmE9hiVbbK/fO/Vffp2cZO159kWM8CPF8KjSKQdTy32m+VtRXGpfT3Y1RRWvUlq7qSGhaN52ysfcgoEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732319; c=relaxed/simple;
	bh=VHwWbSkOCrz8OE2ZRvLd8UNDB7zSY45xYwtOtGy2l9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnCAJ8Goa5Mo0xqIF3tXBcAPHk/HOf8BIHmQ1tWtURt1+/0HCA5+v4ylUt5I0+r6ej0sZXAVmMGr2+bFdp4wR108ZycmvaaKZTtsl5WTo3a0h7zTSfNTjxz8rLTCDEn5PxBVCNuhku7J0QR0F4vKlEV0I3Kk5lsg71AA4+cFCTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OumiSscv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6EAC4CEF1;
	Fri, 21 Nov 2025 13:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763732318;
	bh=VHwWbSkOCrz8OE2ZRvLd8UNDB7zSY45xYwtOtGy2l9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OumiSscvdq7c0qmpPrqEps7FRuwYbBSsgdynT2qnfNkt3UjJzuN40vPgJLhln0Aiq
	 3SKLb2F9vQ/YIEHn/L7lspbY2bB7b1YcCD13teTMrEoKSNqxoJgJIkluUgSAhmWwii
	 9Z8h1QjRTfIV8a5FjMedVkwkRIsfYBk12tI1TqEM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Kemnade <andreas@kemnade.info>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 079/529] hwmon: sy7636a: add alias
Date: Fri, 21 Nov 2025 14:06:18 +0100
Message-ID: <20251121130233.834198198@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130230.985163914@linuxfoundation.org>
References: <20251121130230.985163914@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Kemnade <andreas@kemnade.info>

[ Upstream commit 80038a758b7fc0cdb6987532cbbf3f75b13e0826 ]

Add module alias to have it autoloaded.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Link: https://lore.kernel.org/r/20250909080249.30656-1-andreas@kemnade.info
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/sy7636a-hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
index ed110884786b4..a12fc0ce70e76 100644
--- a/drivers/hwmon/sy7636a-hwmon.c
+++ b/drivers/hwmon/sy7636a-hwmon.c
@@ -104,3 +104,4 @@ module_platform_driver(sy7636a_sensor_driver);
 
 MODULE_DESCRIPTION("SY7636A sensor driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sy7636a-temperature");
-- 
2.51.0




