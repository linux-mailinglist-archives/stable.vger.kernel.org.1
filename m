Return-Path: <stable+bounces-48174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B38FCD7A
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C352B2B135
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8C71C7752;
	Wed,  5 Jun 2024 12:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/MsrZpm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE251C7748;
	Wed,  5 Jun 2024 12:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589058; cv=none; b=KrxFGVirHIplh9AFFzbsAy4rrApkJoQjkjW7L6PJvc19ykpFPqj2VOVbf9pyWytxiBYnYk/jZiNXhlKUwAhx1ROmGN+EZ9M/2KtaRGU10QVMDYP2iSO+rj+YP/8RR2ndIXBdaASsc817PiPx4kxUOOs0F1bFsp7GPVrNiWeT6Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589058; c=relaxed/simple;
	bh=dRcy6OS1IofzbD1NjQE76rjD0zXix+SxVmT62c0IwPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7St/lhLTkejWp1SPXnjI6gZ5nUDV/da8ilF8hnVxTZrdkn7s7g53+oSGYB2+/aw4mg/NsD0qnUAgZo5bb+kZrJ8IQ3P1CzROoDTwb6u444wGe6AM4oZ1YPg94hUKp70sK2Q9G/dlLRMxlfPpWAN9WYquEZYi6VW/zGQfvAgqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/MsrZpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855B6C4AF07;
	Wed,  5 Jun 2024 12:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589058;
	bh=dRcy6OS1IofzbD1NjQE76rjD0zXix+SxVmT62c0IwPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/MsrZpm96uqlFfwUM2fkzHmyq12ehTJ45OP9RG9RNJESuma9BBhZndk/jC+CE26Y
	 RensooTSldzv+5qcUQYTgnE9Pw1Gyabu48DCMNp57emco/uHGxTP8oZWjy9UIxAnO+
	 yw70y9VMN24aEldI/JSBYEvrCv358vI+j7NQasE7ga+byj53nhnBR8doKj+XyQhFa2
	 PlaIP4TWov4SMpQML0bJilrEKxNMgsrwyKSVY385hD00WiXaqJ6LTxzNTWxHooDV49
	 W1qdYHSAdcbPMcfxLJY2Plg0uNtA5mVthHqlbazw6YxNZ4rnOb9ALQ2VknA8Lp6bny
	 GCIWhr1fnemIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jim Wylder <jwylder@google.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 6.6 06/18] regmap-i2c: Subtract reg size from max_write
Date: Wed,  5 Jun 2024 08:03:45 -0400
Message-ID: <20240605120409.2967044-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120409.2967044-1-sashal@kernel.org>
References: <20240605120409.2967044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

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


