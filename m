Return-Path: <stable+bounces-126619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA440A70974
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 19:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFAF3179108
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 18:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533EE1F891C;
	Tue, 25 Mar 2025 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo7IlL4A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5F71F874F;
	Tue, 25 Mar 2025 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928186; cv=none; b=Bt+mAvbegih8JOCUB0+ftl8ECVybOzY+q+pkddqNDg7q7VRmkLjfzH90nyqmsk0mPFRCd60hIGc9qYls6+gGDWTnDXlxxD28eNyZwZHdpQbimIZOZfQTpHN6qbfA/s/Td47PZ4ddQsRhQZULPhid5+CES8gpHKRJDqKzfpAVno8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928186; c=relaxed/simple;
	bh=9IMmDSkBWJTA3YSD8svpuNrMfYCFJbNxTLX+M0T3GzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2wq7nM54ApyQcJjRJ319vjD/bt4lyKoDoQLzpXeL2hzLa/4ZLDXGsF4gdcoK1vP12BsjGk+nAqNVWloexStdW89btc9jQt6ERxX7htOUCrvb6IxsRewA6Cd/HM0ncI05qGWGOjrJ+aTYEx0ILSnc1YbXN2POuFP7pY1GP/NqII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eo7IlL4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F3EC4CEE4;
	Tue, 25 Mar 2025 18:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742928185;
	bh=9IMmDSkBWJTA3YSD8svpuNrMfYCFJbNxTLX+M0T3GzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eo7IlL4AzxWKa7/6Oa6pI4xwr5Qzzz0QdcDE3ezIbFLWz75todjDjD68Aeq667gFM
	 HWaIoabXm96QmTjobwLcSJ+8lUp7HV4ffUouON0YCJAEsPsSSzDYIlwA1KlEO9Rtu+
	 0rQkurHdVihtP+WKKTdoBd0S0qysJ980muv9UrKGGphX4BaCD15nglkuKtM7JFNbTW
	 8OTaKgDCPDjpRArGedYB/FX9/8uzvdHE5GyjQ7rf/JAvbZaUM/q+/BS6mj27DkJvPH
	 z08OOO/ZIrgCcTvf90oWK7AkJfT3QH18wdO7PoT9Rk0otHOlH/YO76Y/kpu+tLKQwl
	 WwOWGnnBFP+LA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tasos Sahanidis <tasos@tasossah.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 3/3] hwmon: (nct6775-core) Fix out of bounds access for NCT679{8,9}
Date: Tue, 25 Mar 2025 14:42:57 -0400
Message-Id: <20250325184258.2152379-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325184258.2152379-1-sashal@kernel.org>
References: <20250325184258.2152379-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.131
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
 drivers/hwmon/nct6775-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 9de3ad2713f1d..ec3ff4e9a9abd 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -276,8 +276,8 @@ static const s8 NCT6776_BEEP_BITS[] = {
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


