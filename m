Return-Path: <stable+bounces-68598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA7A95331D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000C81F21FA9
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFB51A2C0F;
	Thu, 15 Aug 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="14AoXMy2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A79719EED4;
	Thu, 15 Aug 2024 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731070; cv=none; b=Gab6DMLGbfolWq38xI48k+zp90m7or9aju6c/Wgm3HdbkoJm5v+RGtfirzwzhsumXm48hi0ZCP/RqIn4XgXuesgTJaqYKEEM61gbZrgW2BDwdXrycpNiBzueMfcpC4FBdFpf7xPuA13fwh9qd4s/g4czGOrTo57BBYKO5UyCNfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731070; c=relaxed/simple;
	bh=Wm0qyGiuOzbYW9wMMJ/mZMtKYgs7HRY7UnqmnaHRfWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJo1DjTaLqMAIwfT6izDx1X1QghZPX/dhmqAkMhZshClP962rXajc7cWOyOFVDBe2xXNTD8friS3hlyzXvOz7zBr/sBq9tT/Rs939/fnzHGADk94sSV5E6viXcQ7R6tNvp02p1ZGVzw8xuXrhkbFBdD3VxCaEgFATYssulJitpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=14AoXMy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459E7C4AF0A;
	Thu, 15 Aug 2024 14:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731069;
	bh=Wm0qyGiuOzbYW9wMMJ/mZMtKYgs7HRY7UnqmnaHRfWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=14AoXMy2ftsdLG04JgKaNzg8CSVmNWIQ+fhcNt6WrPXb5Y6zm7r060AxN1dQz5mFT
	 gUgS52YYMivWnsX65QtFzTVVoI2uCBsiO0tYYiy957Y9apmYk8istCbRqxO537Halb
	 oJKVxSdBsbQOgs7EEHbRKTDEaHl0r8jASbBuMYXs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 014/259] hwmon: (max6697) Fix swapped temp{1,8} critical alarms
Date: Thu, 15 Aug 2024 15:22:27 +0200
Message-ID: <20240815131903.344304699@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 1ea3fd1eb9869fcdcbc9c68f9728bfc47b9503f1 ]

The critical alarm bit for the local temperature sensor (temp1) is in
bit 7 of register 0x45 (not bit 6), and the critical alarm bit for remote
temperature sensor 7 (temp8) is in bit 6 (not bit 7).

This only affects MAX6581 since all other chips supported by this driver
do not support those critical alarms.

Fixes: 5372d2d71c46 ("hwmon: Driver for Maxim MAX6697 and compatibles")
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/max6697.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index cfd5815e60dfa..6804d840351ac 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -359,14 +359,14 @@ static SENSOR_DEVICE_ATTR_RO(temp6_max_alarm, alarm, 20);
 static SENSOR_DEVICE_ATTR_RO(temp7_max_alarm, alarm, 21);
 static SENSOR_DEVICE_ATTR_RO(temp8_max_alarm, alarm, 23);
 
-static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 14);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 15);
 static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, 8);
 static SENSOR_DEVICE_ATTR_RO(temp3_crit_alarm, alarm, 9);
 static SENSOR_DEVICE_ATTR_RO(temp4_crit_alarm, alarm, 10);
 static SENSOR_DEVICE_ATTR_RO(temp5_crit_alarm, alarm, 11);
 static SENSOR_DEVICE_ATTR_RO(temp6_crit_alarm, alarm, 12);
 static SENSOR_DEVICE_ATTR_RO(temp7_crit_alarm, alarm, 13);
-static SENSOR_DEVICE_ATTR_RO(temp8_crit_alarm, alarm, 15);
+static SENSOR_DEVICE_ATTR_RO(temp8_crit_alarm, alarm, 14);
 
 static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, 1);
 static SENSOR_DEVICE_ATTR_RO(temp3_fault, alarm, 2);
-- 
2.43.0




