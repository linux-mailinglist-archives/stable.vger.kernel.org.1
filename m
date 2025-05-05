Return-Path: <stable+bounces-141173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D45FAAB10C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DCF1BC1682
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDDC331F4D;
	Tue,  6 May 2025 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGy3ZaX8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51552C17A9;
	Mon,  5 May 2025 22:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485375; cv=none; b=Rr4/MIpUFHgb8kKoTI6W9m7JgHBXUzB/rtGdXDotj/P5mCVOmrFc2N4hyFOaFaKlAFLL4oLkkakU34uK73GpHzwjU75XyS1GtrIxencAzttkLPX7Od0GOlVHISmj8lIUClQt1HKLuDXkje2JAvxDQlITGtejP5AADJbUMVUtg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485375; c=relaxed/simple;
	bh=ya6bTDMEoKFuM8nw+msw5m2ONCtsb+u6tThQg0e0PIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tPMEUtdTMWPW8IsbeFWXGpgZGwyl7CKSWDzn0zDKEF+sToXd6pfS5rVl9YpSQfsd2AomCB3azX8p3P1sl1xJN4Q7yBc4EWr+OGRuIn3IqO5OryXIvqZ9QRdWRwwAaBbXakybc5JQ2daVSRNdJttpkY5nplCQH055AKeEirDpLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGy3ZaX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C905FC4CEEF;
	Mon,  5 May 2025 22:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485374;
	bh=ya6bTDMEoKFuM8nw+msw5m2ONCtsb+u6tThQg0e0PIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGy3ZaX8mi7FayECjksrHygh/GTA6BS9K371B2QvwKFJC95txDHfNk6xcBAiEnemW
	 EvX7iZoPQubN4OjYop/jrmCzGoeqSmWfPl6OUP6XAeeIqu/UcfyE5FmlzO08UssTL9
	 uef4ZwJPMd7G6ebQ1gtaA37mv28qAHoiL1uP2AkG26F7IG2trnHpJUPv0pSUOmdPiO
	 H11wFdWQSHj+e0Vz0YZAwrg7GX2uFwfyEWNK04gx5MaiuBhMR9Jfx6W3M4QfadnGld
	 rgZ3EYsW7k46XjfcV2weooX9Ym7zACF2ohWEeHT59A98F9bBm9z/CxE6U5WFau59ta
	 L4DMDs4+0F4iQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	W_Armin@gmx.de,
	linux@roeck-us.net,
	dan.carpenter@linaro.org,
	u.kleine-koenig@pengutronix.de
Subject: [PATCH AUTOSEL 6.12 297/486] eeprom: ee1004: Check chip before probing
Date: Mon,  5 May 2025 18:36:13 -0400
Message-Id: <20250505223922.2682012-297-sashal@kernel.org>
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


