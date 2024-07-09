Return-Path: <stable+bounces-58409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846D892B6D8
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54221C20938
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3853C156F37;
	Tue,  9 Jul 2024 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H269QxQg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959155E4C;
	Tue,  9 Jul 2024 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523851; cv=none; b=pFdY/cCuQ+dtFq4UGKZPaDxwodQNxBb8C5vE+kSIyG/Q1+25LL4Zoxudh8/57dNxeWsmPAdQgDbZOpubCSl+pONbEKO8BqeEWvr6xINN2wKICllfJcbwQpg9DlwhWxUos+02yRPXBGSI1pVAVgytbaHHqfWraHnsC8QiDyTCYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523851; c=relaxed/simple;
	bh=NfGh7hod9xay254dKwgt3kxc4/1BpGSdVBW5nJXXjdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4dAvw785h+Gw5irwSivCJnKV0+rF3cFkAx/lTlxa/ujYcBJDr8tSKgK4wPnKjYh8QAQ7sULY5CMNT2+T5SDBw4GeYq+XeUavdqe4MMLr6GiG1e5hr02JNsL0h1afCt1GJJ2c/nNS0kIuZZLX0wqz/89aAH+XoY+IRdnKwQ8GoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H269QxQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7AFC32786;
	Tue,  9 Jul 2024 11:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720523850;
	bh=NfGh7hod9xay254dKwgt3kxc4/1BpGSdVBW5nJXXjdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H269QxQgOssncMZlH4bzdPHCBbCDQhdnKwYiYqv0CkZv5RSyrflc6niug8iaMNPDw
	 zfcAtvvM6cvYc007/jRFv2rM2OTWCrzZwlIpfThaVF0BYRQSOhGoRoj8PzersAlNJT
	 iB8NDGcYubH039K2FBqgYmiy39ROJ2elig6iQjNQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jim Wylder <jwylder@google.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 129/139] regmap-i2c: Subtract reg size from max_write
Date: Tue,  9 Jul 2024 13:10:29 +0200
Message-ID: <20240709110703.153666807@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
References: <20240709110658.146853929@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Wylder <jwylder@google.com>

[ Upstream commit 611b7eb19d0a305d4de00280e4a71a1b15c507fc ]

Currently, when an adapter defines a max_write_len quirk,
the data will be chunked into data sizes equal to the
max_write_len quirk value.  But the payload will be increased by
the size of the register address before transmission.  The
resulting value always ends up larger than the limit set
by the quirk.

Avoid this error by setting regmap's max_write to the quirk's
max_write_len minus the number of bytes for the register and
padding.  This allows the chunking to work correctly for this
limited case without impacting other use-cases.

Signed-off-by: Jim Wylder <jwylder@google.com>
Link: https://msgid.link/r/20240523211437.2839942-1-jwylder@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap-i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 3ec611dc0c09f..a905e955bbfc7 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -350,7 +350,8 @@ static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
 
 		if (quirks->max_write_len &&
 		    (bus->max_raw_write == 0 || bus->max_raw_write > quirks->max_write_len))
-			max_write = quirks->max_write_len;
+			max_write = quirks->max_write_len -
+				(config->reg_bits + config->pad_bits) / BITS_PER_BYTE;
 
 		if (max_read || max_write) {
 			ret_bus = kmemdup(bus, sizeof(*bus), GFP_KERNEL);
-- 
2.43.0




