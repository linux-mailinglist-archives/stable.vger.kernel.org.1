Return-Path: <stable+bounces-48191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0B28FCD7E
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02A2280A4A
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169C8195964;
	Wed,  5 Jun 2024 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/lyY28O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A7A1CB2F9;
	Wed,  5 Jun 2024 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589102; cv=none; b=foXq5Ulsb/EclSyc7d59Pugucz6xb3fdeD54k8QTaYf56EF+WqpV4RPWr81MJYSq3HqLt9pC2logMz6E3poOcPP5maQuugVlzoP2v+I1bGZ6AICvh6EyM0qbUvpw1V+BqBRqzBeEXcHRvWqm8toF8JZIz9GAA8/jsS0c0okMAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589102; c=relaxed/simple;
	bh=dRcy6OS1IofzbD1NjQE76rjD0zXix+SxVmT62c0IwPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYXys/mUsO40HAQ9Vjj+IoOHROBYqCifNydV9EY3p9+BV9aG5V1RyDdlTiuQrDm1U+6E/x3Jn3cT6388P3RG2ICzc7+JmZ7bZI+0VNROHMvRtByC5EEy4w0h/LZG7A15SrikTq/jbKkrRPm/j1SXgR7CzRmpXPzxjoCsQJs7K9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/lyY28O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E691BC32781;
	Wed,  5 Jun 2024 12:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589102;
	bh=dRcy6OS1IofzbD1NjQE76rjD0zXix+SxVmT62c0IwPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/lyY28OuAbbz0yOB59IoiNlCJUrGBtv600dpp/v/QmHgTk+7sDCrgy3JMsm96ZpZ
	 93yypthpvcH9POgV43wcjswUg+uDXDSfPJlwDDjHw7py13I3xVkRSOXUiWgrDwncXh
	 7qqK5zmPTVphk18DeoSMjezRdkDzzCzjL47Or+0NG7ggUOGNJAsVnowzsNaGupHhcH
	 kMTDbE1BNqeOiEs2PKw/w9djHVoFoLzXpu6b5+/6QRCJYNPnj3aNCBOf71W70A/xxS
	 cHyoZfepQiKsVNbf31uvwmryWxtLT/S2S6rHiKknKIBOiwQdCIJz/O06aSueXQIX7I
	 b1ePqKKjIqOhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jim Wylder <jwylder@google.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 6.1 05/14] regmap-i2c: Subtract reg size from max_write
Date: Wed,  5 Jun 2024 08:04:38 -0400
Message-ID: <20240605120455.2967445-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120455.2967445-1-sashal@kernel.org>
References: <20240605120455.2967445-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
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


