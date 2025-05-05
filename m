Return-Path: <stable+bounces-140126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1681AAA561
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8C498378D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E3730DE3B;
	Mon,  5 May 2025 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/w4GJJf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62928BAA3;
	Mon,  5 May 2025 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484155; cv=none; b=pG7zuqcSKUx/JY784h1M0lLCnxEVjwD688hVJBawQWM349UM22c2ANo8EwvhayWR1WL5Hkdll1UZA0wdrHiwU5PSIjyXDNyA6ecgCyo7bLqbFC27ECeCnZs/AYHVG6l+6FjYryYzDo6iJ4Mtv0OahEKQEND1tC64EvFc/Pv7/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484155; c=relaxed/simple;
	bh=ya6bTDMEoKFuM8nw+msw5m2ONCtsb+u6tThQg0e0PIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CmoO/8uOHVsbN+ThgeX/l+exNg8VCgrNcmFMvZP9dpap4H6URy18TnN7RR6CvQwAmyYhyFMBv4D009MByFEfR1BjL7QgtPxdSbuXuP1gv9wAB6WIU/SYZbU3JnwmDnc6TR5pFMww4K5qbz5AN31Ino2ZEg1INzCE/DRaMehB87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/w4GJJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA6EC4CEED;
	Mon,  5 May 2025 22:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484155;
	bh=ya6bTDMEoKFuM8nw+msw5m2ONCtsb+u6tThQg0e0PIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/w4GJJfNb4dgu+gUxcAWIHSlhGboCWUaEAol9m5sVJoQa/hJl4EUnWWs8GPx/uEQ
	 nFud0wjL+mKPlcG+ctY1qOiUofckk60780lss+PfIP1UL9PY9sGFsv3VYuX5+oYzpY
	 NKzsYkWQQbX/2Ka5deaKrJ6J2wuQaNOf2xPwSxcfymDcgYWOeKfSgx0sdRUFI3ZAAi
	 VMxQw6veZEIQKAzOSn1y6kIHpFVQo8AeVjG0O7G5tdgweurxL8BGiTmCpgFOYvjxs9
	 aPbO+f0rqVZ9s/kee+aKWHgfacleTYt6Rar/VoKp343teeZ6g7nFcEB/m9pyQb9sbP
	 4D6ssNEt/Tvcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	W_Armin@gmx.de,
	linux@roeck-us.net,
	u.kleine-koenig@pengutronix.de
Subject: [PATCH AUTOSEL 6.14 379/642] eeprom: ee1004: Check chip before probing
Date: Mon,  5 May 2025 18:09:55 -0400
Message-Id: <20250505221419.2672473-379-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Eddie James <eajames@linux.ibm.com>

[ Upstream commit d9406677428e9234ea62bb2d2f5e996d1b777760 ]

Like other eeprom drivers, check if the device is really there and
functional before probing.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Link: https://lore.kernel.org/r/20250218220959.721698-1-eajames@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/eeprom/ee1004.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 89224d4af4a20..e13f9fdd9d7b1 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -304,6 +304,10 @@ static int ee1004_probe(struct i2c_client *client)
 				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_READ_BYTE_DATA))
 		return -EPFNOSUPPORT;
 
+	err = i2c_smbus_read_byte(client);
+	if (err < 0)
+		return -ENODEV;
+
 	mutex_lock(&ee1004_bus_lock);
 
 	err = ee1004_init_bus_data(client);
-- 
2.39.5


