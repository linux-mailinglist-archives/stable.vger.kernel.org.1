Return-Path: <stable+bounces-126622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40357A7096A
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 19:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6153A9505
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 18:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475FB1FAC4B;
	Tue, 25 Mar 2025 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQYrFaeU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B3B1EF096;
	Tue, 25 Mar 2025 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928200; cv=none; b=O070qGINVkfjMBgzbuQZz4QT0CBAcC+ZNYGAJrKIe1uQ5pN0pyU/WeIe7X/A6rPeNf+em1RN+EUk/AWgxRHQJiPhZoG92OWrtR1wCiqaIfusc9d2z1Br2Q797CgNHNJG6tCu9mD5rRfNIda1arL1s/HCU9jxLLl3qD1MEBm0r0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928200; c=relaxed/simple;
	bh=qKysUtbqgECWt4ejiYMsB2WxYSks8fISKOCETNl/QNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j5Tg14Pkl8mbDaFWu2RFdcYR/zC5taUCJKCR+udFhJGcptBYXNSyUW23rGzpTCKbL2bR/IikRhTKqzP2jNTYfF9zlBsYNNZ2SuloHYzoNHN2Pp0BsjF8LCvRPyfkQx7Fdwswd7M7KFqk5mPhNC7U6AEDu+vKmVJUURwR/Zn8O6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQYrFaeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42E1C4CEED;
	Tue, 25 Mar 2025 18:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742928199;
	bh=qKysUtbqgECWt4ejiYMsB2WxYSks8fISKOCETNl/QNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQYrFaeUzqOlLD/AYNEbuwJ3Jz3xBWTYvqy2FuJKg4F2tjR0PcZ4FupTWmiZ1cwph
	 0BtyNHIFcH/vE8hlGUcab7q7bGI73OTqPzvipQerEdfTCrPx+eBThpwHW/vUpamj9r
	 k0mphAFBuroh9cZ383oPXEqvlYKm+mPeqvIlpgwJu9MfvNQEgP/Dxpdm1Iw6bxbwvw
	 wBr1uE2nYk32L+mqj3BlBX7C5bg1vbzXOh6hFsaZHtisosXQ3C6nJPbEh00/5HAbyv
	 dc6NupbwBlKLX0KkoYRTnx3gKK1u2WPJXOEBpJ1TLjkpz9SHEAWW/UPZHjx9mK1EmP
	 09MfZii9TElnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tasos Sahanidis <tasos@tasossah.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/2] hwmon: (nct6775-core) Fix out of bounds access for NCT679{8,9}
Date: Tue, 25 Mar 2025 14:43:13 -0400
Message-Id: <20250325184313.2152467-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325184313.2152467-1-sashal@kernel.org>
References: <20250325184313.2152467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
Content-Transfer-Encoding: 8bit

From: Tasos Sahanidis <tasos@tasossah.com>

[ Upstream commit 815f80ad20b63830949a77c816e35395d5d55144 ]

pwm_num is set to 7 for these chips, but NCT6776_REG_PWM_MODE and
NCT6776_PWM_MODE_MASK only contain 6 values.

Fix this by adding another 0 to the end of each array.

Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
Link: https://lore.kernel.org/r/20250312030832.106475-1-tasos@tasossah.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 3645a19cdaf4d..71cfc1c5bd12e 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -420,8 +420,8 @@ static const s8 NCT6776_BEEP_BITS[] = {
 static const u16 NCT6776_REG_TOLERANCE_H[] = {
 	0x10c, 0x20c, 0x30c, 0x80c, 0x90c, 0xa0c, 0xb0c };
 
-static const u8 NCT6776_REG_PWM_MODE[] = { 0x04, 0, 0, 0, 0, 0 };
-static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0 };
+static const u8 NCT6776_REG_PWM_MODE[] = { 0x04, 0, 0, 0, 0, 0, 0 };
+static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0, 0 };
 
 static const u16 NCT6776_REG_FAN_MIN[] = {
 	0x63a, 0x63c, 0x63e, 0x640, 0x642, 0x64a, 0x64c };
-- 
2.39.5


