Return-Path: <stable+bounces-126612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C9EA70947
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 19:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E3F3AA925
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 18:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E211F4635;
	Tue, 25 Mar 2025 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhrM7lGR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9E1F4627;
	Tue, 25 Mar 2025 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928167; cv=none; b=MHiCyAp2O2cz2Abe5MxxSHErsTP4J92PRUBgbY8Fs1NzQjd9MVHl4nb/49EWCoHcW4njQKk3M3ulqC7I8DP4y5BxmtOXRZ3+HNGLhbFQY4nhlrQn5gX/HxJ9mXhyYgRqI7SPHzeurrxS+yciQTjHeexeGRWwZZeCs2/gdBOzkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928167; c=relaxed/simple;
	bh=b0ElTFIwXwNHL7nzondQmJSf/3QVUkxQFYvSen+AJuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eZSv93gv5961c7O23KCiogBklq+SbU9zBDJNasSBrRXXRa0/foLf5FiNhwNE0GqwhnEyV4bU2C1puLLaqUS+tnhuX43azIMraWkuNBb7HH0G18ufzn1O/mxTTuJINwEg87BZ4kw6VqNuo8sWaOtun44VW4mtaQc0eBzsUmBxAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhrM7lGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BE9C4CEE4;
	Tue, 25 Mar 2025 18:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742928166;
	bh=b0ElTFIwXwNHL7nzondQmJSf/3QVUkxQFYvSen+AJuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhrM7lGR74knscFivecoEcbSSy+iU2/LVZqJcExIOhvnEdVwPkMaSJUMjIIHANkWZ
	 xZ0O7eepX7scJVOPn1S8DTYpiNttIqkPLVTbuGneZLlJih7ytuuzqfeOAZOC3WFsPj
	 X0omgxa8g/0X9w6b0/ZQOFRnzrd6+LMuoW4vbdYrqbSBWryB9kfPk9viJC/yO497Md
	 iG3+SfAmC97n3QvGMamBBKjQp2ZCjKA9iBMViCou/86bVI5ZcGeCjqxnY5J2d/wB+d
	 TzRjqRnFM/H/sVfekq8qwrAbN9sSyP9w2Xzls1H7JOua8NX6o4U9/pATbkaffr1DqA
	 4wNIdQc++TMiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tasos Sahanidis <tasos@tasossah.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 4/5] hwmon: (nct6775-core) Fix out of bounds access for NCT679{8,9}
Date: Tue, 25 Mar 2025 14:42:34 -0400
Message-Id: <20250325184236.2152255-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325184236.2152255-1-sashal@kernel.org>
References: <20250325184236.2152255-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.20
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
index fa3351351825b..79bc67ffb9986 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -273,8 +273,8 @@ static const s8 NCT6776_BEEP_BITS[NUM_BEEP_BITS] = {
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


