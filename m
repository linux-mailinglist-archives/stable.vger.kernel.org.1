Return-Path: <stable+bounces-67995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3FF953024
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85964288966
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831117C9B1;
	Thu, 15 Aug 2024 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Z2bspLM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A9D19D89D;
	Thu, 15 Aug 2024 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729169; cv=none; b=MrqXbcWBOgOfb38DSotSAJYcqmwUJbsUz4u/Kvh2Lu4jWz/Zx2dcoc4MnpaaiDtRcw4bbpFTFBQ6AChhBoSAyclfmaprLLgwcT9XWITwNW0WEo7CoaBdoG/VfbHrOKa/91HHIIYsBypwBLDpUKRjA7nj6OH414Ot3M0OXmHHBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729169; c=relaxed/simple;
	bh=3H1kbqTI0MLVsEFGsKVtMNdTMt6TEmQqx99T49FC4fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2ttQt2/0BRbkahINa9dI5IpBzqFYN0hriYZM7RpdOxzS3H6TemtjSs1x2P+zCe8TjW7a7asY1yE2/+vFFl0JwcdkxFImH+bBIx0r0oJaOEgUp4M/J8bfUetbf9M87SRt+pihT07A4nccrRE8BiTOVoZjF3cD1CO3sYeDVGZqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Z2bspLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1E0C32786;
	Thu, 15 Aug 2024 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729169;
	bh=3H1kbqTI0MLVsEFGsKVtMNdTMt6TEmQqx99T49FC4fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Z2bspLMCysqFLt3FqbqmrnU/+goH0C1FQQxob7y79PJ3Zp58cQcDgp0W5PEYu4fy
	 SRxHPBM+BR/xwsE02djTe3i55WDuxOCHTo0BvaXn65j3hG7eVmu0hnVlUXskssPVH1
	 67fx+C2Gvy45Ha7irWPpwcDoTqFqzlCm/gHDKSns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wayne Tung <chineweff@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 013/484] hwmon: (adt7475) Fix default duty on fan is disabled
Date: Thu, 15 Aug 2024 15:17:51 +0200
Message-ID: <20240815131941.781377950@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wayne Tung <chineweff@gmail.com>

[ Upstream commit 39b24cced70fdc336dbc0070f8b3bde61d8513a8 ]

According to the comments on fan is disabled, we change to manual mode
and set the duty cycle to 0.
For setting the duty cycle part, the register is wrong. Fix it.

Fixes: 1c301fc5394f ("hwmon: Add a driver for the ADT7475 hardware monitoring chip")
Signed-off-by: Wayne Tung <chineweff@gmail.com>
Link: https://lore.kernel.org/r/20240701073252.317397-1-chineweff@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/adt7475.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 22e314725def0..b4c0f01f52c4f 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1770,7 +1770,7 @@ static void adt7475_read_pwm(struct i2c_client *client, int index)
 		data->pwm[CONTROL][index] &= ~0xE0;
 		data->pwm[CONTROL][index] |= (7 << 5);
 
-		i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
+		i2c_smbus_write_byte_data(client, PWM_REG(index),
 					  data->pwm[INPUT][index]);
 
 		i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
-- 
2.43.0




