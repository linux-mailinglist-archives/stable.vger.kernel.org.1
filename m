Return-Path: <stable+bounces-72468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80A7967AC0
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 19:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91001C21475
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9F376EC;
	Sun,  1 Sep 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V8ZW/1oJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C5225D9;
	Sun,  1 Sep 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725210024; cv=none; b=bBiWTRZQsIXTO0jhwAN4OeYvyzHF+ggWxc5JB6zOueDnLPuULxbulNK1hDYlZ9/IoDSxzeX2pZrIHsDIy1nUDzmfNQdk/rxqrR7QzW0a8tAbTZkBW+XDW32J3AsHbxqtOb/rsL1Uh5O3+PLnOv3LGh7zLW8spNXzEPy+trKTPlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725210024; c=relaxed/simple;
	bh=lC/aUdU5V5g6gs+iTRJ6vZ5mJ6bqsKzYL88YniNqsA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2Dq2koOsul6q0XZEY3lTjkoPMop2BsFTPNweypyr5K/3/6IUktj1w8CmyRblT+hPwdr5cSCJX0bWPAy0IMH7K/5qVT3aAyS8B5I5G9z+aj8n53JVUM4GpdJdZ9ZR8yNqUwrw8Rj/cHXm4V4OBvtkpHly84AE35wpgoDG8qQpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V8ZW/1oJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C5FC4CEC3;
	Sun,  1 Sep 2024 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725210024;
	bh=lC/aUdU5V5g6gs+iTRJ6vZ5mJ6bqsKzYL88YniNqsA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8ZW/1oJfhwPKg7ao8SsGIwxDdqjzVTTuoVypW5mNxLgMPbjAuXxtCzrsTCShW8r6
	 c+DefJ/gHkESueW+7einZdCigSiTCufQ9h13oOIHqsyhJfCdbiMmeLWwLIgxHlPtUR
	 HqrjNqRHONAbUNOOEY2e1hjV14tTRGMrHcgGARXI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 063/215] hwmon: (ltc2992) Avoid division by zero
Date: Sun,  1 Sep 2024 18:16:15 +0200
Message-ID: <20240901160825.736809930@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160823.230213148@linuxfoundation.org>
References: <20240901160823.230213148@linuxfoundation.org>
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

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

[ Upstream commit 10b02902048737f376104bc69e5212466e65a542 ]

Do not allow setting shunt resistor to 0. This results in a division by
zero when performing current value computations based on input voltages
and connected resistor values.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Link: https://lore.kernel.org/r/20231011135754.13508-1-antoniu.miclaus@analog.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/ltc2992.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
index 009a0a5af9236..a657f93882dd1 100644
--- a/drivers/hwmon/ltc2992.c
+++ b/drivers/hwmon/ltc2992.c
@@ -912,8 +912,12 @@ static int ltc2992_parse_dt(struct ltc2992_state *st)
 		}
 
 		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms", &val);
-		if (!ret)
+		if (!ret) {
+			if (!val)
+				return dev_err_probe(&st->client->dev, -EINVAL,
+						     "shunt resistor value cannot be zero\n");
 			st->r_sense_uohm[addr] = val;
+		}
 	}
 
 	return 0;
-- 
2.43.0




